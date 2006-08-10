Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWHJJzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWHJJzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWHJJys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:54:48 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:6300 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161138AbWHJJyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:54:43 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 08/12] hdaps: Add explicit hardware configuration functions
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:46 +0300
Message-Id: <1155203384964-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds functions for configuring accelerometer-related hardware 
parameters in the hdaps driver, and changes the init function to
use these functions instead of opaque magic numbers.
The parameters are configured via variables instead of constants
since a later patch will add sysfs attributes for changing them.

A few of these functions aren't used yet, but will be used by later
patches.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |  205 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 159 insertions(+), 46 deletions(-)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -57,7 +57,6 @@ static const struct thinkpad_ec_row ec_a
 #define READ_TIMEOUT_MSECS	100	/* wait this long for device read */
 #define RETRY_MSECS		3	/* retry delay */
 
-#define HDAPS_POLL_PERIOD	(HZ/50)	/* poll for input every 1/50s */
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
 #define HDAPS_INPUT_FLAT	4
 #define KMACT_REMEMBER_PERIOD   (HZ/10) /* keyboard/mouse persistance */
@@ -68,6 +67,13 @@ static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
 static int needs_calibration;
 
+/* Configuration: */
+static int sampling_rate = 50;       /* Sampling rate  */
+static int oversampling_ratio = 5;   /* Ratio between our sampling rate and
+                                      * EC accelerometer sampling rate      */
+static int running_avg_filter_order = 2; /* EC running average filter order */
+static int fake_data_mode;           /* Enable EC fake data mode? */
+
 /* Latest state readout: */
 static int pos_x, pos_y;      /* position */
 static int temperature;       /* temperature */
@@ -177,6 +183,143 @@ static int hdaps_update(void)
 }
 
 /**
+ * hdaps_set_power - enable or disable power to the accelerometer.
+ * Returns zero on success and negative error code on failure.  Can sleep.
+ */
+static int hdaps_set_power(int on)
+{
+	struct thinkpad_ec_row args =
+		{ .mask=0x0003, .val={0x14, on?0x01:0x00} };
+	struct thinkpad_ec_row data = { .mask = 0x8000 };
+	int ret = thinkpad_ec_read_row(&args, &data);
+	if (ret)
+		return ret;
+	if (data.val[0xF]!=0x00)
+		return -EIO;
+	return 0;
+}
+
+/**
+ * hdaps_set_fake_data_mode - enable or disable EC test mode
+ * EC test mode fakes accelerometer data using an incrementing counter.
+ * Returns zero on success and negative error code on failure.  Can sleep.
+ */
+static int hdaps_set_fake_data_mode(int on)
+{
+	struct thinkpad_ec_row args =
+		{ .mask=0x0007, .val={0x17, 0x83, on?0x01:0x00} };
+	struct thinkpad_ec_row data = { .mask = 0x8000 };
+	int ret = thinkpad_ec_read_row(&args, &data);
+	if (ret)
+		return ret;
+	if (data.val[0xF]!=0x00) {
+		printk(KERN_WARNING "failed setting hdaps fake data to %d\n",
+		       on);
+		return -EIO;
+	}
+	printk(KERN_DEBUG "hdaps: fake_data_mode set to %d\n", on);
+	return 0;
+}
+
+/**
+ * hdaps_set_ec_config - set accelerometer parameters.
+ * @ec_rate: embedded controller sampling rate
+ * @order: embedded controller running average filter order
+ * (Normally we have @ec_rate = sampling_rate * oversampling_ratio.)
+ * Returns zero on success and negative error code on failure.  Can sleep.
+ */
+static int hdaps_set_ec_config(int ec_rate, int order)
+{
+	struct thinkpad_ec_row args = { .mask=0x000F,
+		.val={0x10, (u8)ec_rate, (u8)(ec_rate>>8), order} };
+	struct thinkpad_ec_row data = { .mask = 0x8000 };
+	int ret = thinkpad_ec_read_row(&args, &data);
+	printk(KERN_DEBUG "hdaps: setting ec_rate=%d, filter_order=%d\n",
+	       ec_rate, order);
+	if (ret)
+		return ret;
+	if (data.val[0xF]==0x03) {
+		printk(KERN_WARNING "hdaps: config param out of range\n");
+		return -EINVAL;
+	}
+	if (data.val[0xF]==0x06) {
+		printk(KERN_WARNING "hdaps: config change already pending\n");
+		return -EBUSY;
+	}
+	if (data.val[0xF]!=0x00) {
+		printk(KERN_WARNING "hdaps: config change error, ret=%d\n",
+		      data.val[0xF]);
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
+ * hdaps_get_ec_config - get accelerometer parameters.
+ * @ec_rate: embedded controller sampling rate
+ * @order: embedded controller running average filter order
+ * Returns zero on success and negative error code on failure.  Can sleep.
+ */
+static int hdaps_get_ec_config(int *ec_rate, int *order)
+{
+	const struct thinkpad_ec_row args =
+		{ .mask=0x0003, .val={0x17, 0x82} };
+	struct thinkpad_ec_row data = { .mask = 0x801F };
+	int ret = thinkpad_ec_read_row(&args, &data);
+	if (ret)
+		return ret;
+	if (data.val[0xF]!=0x00)
+		return -EIO;
+	if (!(data.val[0x1] & 0x01))
+		return -ENXIO; /* accelerometer polling not enabled */
+	if (data.val[0x1] & 0x02)
+		return -EBUSY; /* config change in progress, retry later */
+	*ec_rate = data.val[0x2] | ((int)(data.val[0x3]) << 8);
+	*order = data.val[0x4];
+	return 0;
+}
+
+/**
+ * hdaps_get_ec_mode - get EC accelerometer mode
+ * Returns zero on success and negative error code on failure.  Can sleep.
+ */
+static int hdaps_get_ec_mode(u8 *mode)
+{
+	const struct thinkpad_ec_row args = { .mask=0x0001, .val={0x13} };
+	struct thinkpad_ec_row data = { .mask = 0x8002 };
+	int ret = thinkpad_ec_read_row(&args, &data);
+	if (ret)
+		return ret;
+	if (data.val[0xF]!=0x00) {
+		printk(KERN_WARNING
+		       "accelerometer not implemented (0x%02x)\n",
+		       data.val[0xF]);
+		return -EIO;
+	}
+	*mode = data.val[0x1];
+	return 0;
+}
+
+/**
+ * hdaps_check_ec - checks something about the EC.
+ * Follows the clean-room spec for HDAPS; we don't know what it means.
+ * Returns zero on success and negative error code on failure.  Can sleep.
+ */
+static int __init hdaps_check_ec(u8 *mode)
+{
+	const struct thinkpad_ec_row args =
+		{ .mask=0x0003, .val={0x17, 0x81} };
+	struct thinkpad_ec_row data = { .mask = 0x800E };
+	int ret = thinkpad_ec_read_row(&args, &data);
+	if (ret)
+		return  ret;
+	if (data.val[0x1]!=0x00 || data.val[0x2]!=0x60 ||
+	    data.val[0x3]!=0x00 || data.val[0xF]!=0x00)
+		return -EIO;
+	return 0;
+}
+
+/**
  * hdaps_device_init - initialize the accelerometer.
  *
  * Call several embedded controller functions to test and initialize the
@@ -187,61 +330,31 @@ static int hdaps_update(void)
 static int hdaps_device_init(void)
 {
 	int ret;
-	struct thinkpad_ec_row args, data;
 	u8 mode;
 
 	ret = thinkpad_ec_lock();
 	if (ret)
 		return ret;
 
-	args.val[0x0] = 0x13;
-	args.val[0xF] = 0x01;
-	args.mask=0x8001;
-	data.mask=0x8002;
-	if (thinkpad_ec_read_row(&args, &data))
-		{ ABORT_INIT("read1"); goto bad; }
-	if (data.val[0xF]!=0x00)
-		{ ABORT_INIT("check1"); goto bad; }
-	mode = data.val[0x1];
+	if (hdaps_get_ec_mode(&mode))
+		{ ABORT_INIT("hdaps_get_ec_mode failed"); goto bad; }
 
 	printk(KERN_DEBUG "hdaps: initial mode latch is 0x%02x\n", mode);
 	if (mode==0x00)
 		{ ABORT_INIT("accelerometer not available"); goto bad; }
 
-	args.val[0x0] = 0x17;
-	args.val[0x1] = 0x81;
-	args.val[0xF] = 0x01;
-	args.mask = 0x8003;
-	data.mask = 0x800E;
-	if (thinkpad_ec_read_row(&args, &data))
-		{ ABORT_INIT("read2"); goto bad; }
-	if (data.val[0x1]!=0x00 ||
-	    data.val[0x2]!=0x60 ||
-	    data.val[0x3]!=0x00 ||
-	    data.val[0xF]!=0x00)
-		{ ABORT_INIT("check2"); goto bad; }
-
-	args.val[0x0] = 0x14;
-	args.val[0x1] = 0x01;
-	args.val[0xF] = 0x01;
-	args.mask = 0x8003;
-	data.mask = 0x8000;
-	if (thinkpad_ec_read_row(&args, &data))
-		{ ABORT_INIT("read3"); goto bad; }
-	if (data.val[0xF]!=0x00)
-		{ ABORT_INIT("check3"); goto bad; }
+	if (hdaps_check_ec(&mode))
+		{ ABORT_INIT("hdaps_check_ec failed"); goto bad; }
 
-	args.val[0x0] = 0x10;
-	args.val[0x1] = 0xc8;
-	args.val[0x2] = 0x00;
-	args.val[0x3] = 0x02;
-	args.val[0xF] = 0x01;
-	args.mask = 0x800F;
-	data.mask = 0x8000;
-	if (thinkpad_ec_read_row(&args, &data))
-		{ ABORT_INIT("read4"); goto bad; }
-	if (data.val[0xF]!=0x00)
-		{ ABORT_INIT("check4"); goto bad; }
+	if (hdaps_set_power(1))
+		{ ABORT_INIT("hdaps_set_power failed"); goto bad; }
+
+	if (hdaps_set_ec_config(sampling_rate*oversampling_ratio,
+	                        running_avg_filter_order))
+		{ ABORT_INIT("hdaps_set_ec_config failed"); goto bad; }
+
+	if (hdaps_set_fake_data_mode(fake_data_mode))
+		{ ABORT_INIT("hdaps_set_fake_data_mode failed"); goto bad; }
 
 	thinkpad_ec_invalidate();
 	udelay(200);
@@ -327,7 +440,7 @@ keep_active:
 	input_report_abs(hdaps_idev, ABS_X, pos_x - rest_x);
 	input_report_abs(hdaps_idev, ABS_Y, pos_y - rest_y);
 	input_sync(hdaps_idev);
-	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
+	mod_timer(&hdaps_timer, jiffies + HZ/sampling_rate);
 }
 
 
@@ -544,7 +657,7 @@ static int __init hdaps_init(void)
 	/* start up our timer for the input device */
 	init_timer(&hdaps_timer);
 	hdaps_timer.function = hdaps_mousedev_poll;
-	hdaps_timer.expires = jiffies + HDAPS_POLL_PERIOD;
+	hdaps_timer.expires = jiffies + HZ/sampling_rate;
 	add_timer(&hdaps_timer);
 
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
