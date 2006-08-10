Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWHJJyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWHJJyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWHJJyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:54:15 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:60827 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161128AbWHJJyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:54:10 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:41 +0300
Message-Id: <11552033502195-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current hdaps driver queries the hardware on (almost) any sysfs
read, reading just the information it needs and discarding the rest
This is inefficient, because every hardware query actually gives all
information. It also means we're losing data, because readouts are
offered by the hardware at a constant rate and each query "eats up"
a readout. It also results in unnecessarily complex code.

This patch moves all hardware value reading+parsing to a single
function, __hdaps_update(). All values are cached, and easily
referenced afterwards. This function is still invoked on every sysfs
read. This will be fixed in a later patch.

There's a minor race condition here (and and also in the original code):
the global int pos_x, rest_x etc. could be updated while an attribute's
show_* function is reading them. This will be fixed in a future patch.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |  173 ++++++++++++++++++++++++++------------------------
 1 file changed, 90 insertions(+), 83 deletions(-)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -63,73 +63,89 @@ static struct timer_list hdaps_timer;
 static struct platform_device *pdev;
 static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
+
+/* Latest state readout */
+static int pos_x, pos_y;   /* position */
+static int var_x, var_y;   /* variance (what is this?) */
+static u8 temp1, temp2;    /* temperatures */
 static u8 km_activity;
-static int rest_x;
-static int rest_y;
+static int rest_x, rest_y; /* calibrated rest position */
 
-/*
- * hdaps_readb_one - reads a byte from a single I/O port, placing the value in
- * the given pointer.  Returns zero on success or a negative error on failure.
- * Can sleep.
- */
-static int hdaps_readb_one(unsigned int port, u8 *val)
+/* Some models require an axis transformation to the standard reprsentation */
+void transform_axes(int *x, int *y)
 {
-	int ret;
-	struct thinkpad_ec_row data;
-
-	ret = thinkpad_ec_lock();
-	if (ret)
-		return ret;
-	data.mask = (1 << port);
-	ret = thinkpad_ec_read_row(&ec_accel_args, &data);
-	*val = data.val[port];
-	thinkpad_ec_unlock();
-	return ret;
+	if (hdaps_invert) {
+		*x = -*x;
+		*y = -*y;
+	}
 }
 
-/* __hdaps_read_pair - internal lockless helper for hdaps_read_pair(). */
-static int __hdaps_read_pair(unsigned int port1, unsigned int port2,
-			     int *x, int *y)
+/**
+ * __hdaps_update - query current state, with locks already acquired
+ * @fast: if nonzero, do one quick attempt without retries.
+ *
+ * Query current accelerometer state and update global state variables.
+ * Also prefetches the next query. Caller must hold controller lock.
+ */
+static int __hdaps_update(int fast)
 {
-	int ret;
+	/* Read data: */
 	struct thinkpad_ec_row data;
+	int ret;
 
-	data.mask = (3 << port1) | (3 << port2) | (1 << EC_ACCEL_IDX_KMACT);
-	ret = thinkpad_ec_read_row(&ec_accel_args, &data);
+	data.mask = (1 << EC_ACCEL_IDX_KMACT)    |
+	            (3 << EC_ACCEL_IDX_YPOS1)    | (3 << EC_ACCEL_IDX_XPOS1) |
+	            (3 << EC_ACCEL_IDX_YPOS2)    | (3 << EC_ACCEL_IDX_XPOS2) |
+	            (1 << EC_ACCEL_IDX_TEMP1)    | (1 << EC_ACCEL_IDX_TEMP2);
+	if (fast)
+		ret = thinkpad_ec_try_read_row(&ec_accel_args, &data);
+	else
+		ret = thinkpad_ec_read_row(&ec_accel_args, &data);
+	thinkpad_ec_prefetch_row(&ec_accel_args); /* Prefetch even if error */
 	if (ret)
 		return ret;
 
-	*x = *(s16*)(data.val+port1);
-	*y = *(s16*)(data.val+port2);
+	/* Parse position data: */
+	pos_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1);
+	pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1);
+	transform_axes(&pos_x, &pos_y);
+
+	/* Parse so-called "variance" data: */
+	var_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS2);
+	var_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS2);
+	transform_axes(&var_x, &var_y);
+
 	km_activity = data.val[EC_ACCEL_IDX_KMACT];
 
-	/* if hdaps_invert is set, negate the two values */
-	if (hdaps_invert) {
-		*x = -*x;
-		*y = -*y;
-	}
+	temp1 = data.val[EC_ACCEL_IDX_TEMP1];
+	temp2 = data.val[EC_ACCEL_IDX_TEMP2];
 
 	return 0;
 }
 
-/*
- * hdaps_read_pair - reads the values from a pair of ports, placing the values
- * in the given pointers.  Returns zero on success.  Can sleep.
+/**
+ * hdaps_update - acquire locks and query current state
+ *
+ * Query current accelerometer state and update global state variables.
+ * Also prefetches the next query.
+ * Does its own locking.
  */
-static int hdaps_read_pair(unsigned int port1, unsigned int port2,
-			   int *val1, int *val2)
+static int hdaps_update(void)
 {
 	int ret = thinkpad_ec_lock();
 	if (ret)
 		return ret;
-	ret = __hdaps_read_pair(port1, port2, val1, val2);
+	ret = __hdaps_update(0);
 	thinkpad_ec_unlock();
 	return ret;
 }
 
-/*
- * hdaps_device_init - initialize the accelerometer.  Returns zero on success
- * and negative error code on failure.  Can sleep.
+/**
+ * hdaps_device_init - initialize the accelerometer.
+ *
+ * Call several embedded controller functions to test and initialize the
+ * accelerometer.
+ * Returns zero on success and negative error code on failure. Can sleep.
  */
 #define ABORT_INIT(msg) printk(KERN_ERR "hdaps init failed at: %s\n", msg)
 static int hdaps_device_init(void)
@@ -236,35 +252,43 @@ static struct platform_driver hdaps_driv
 	},
 };
 
-/*
- * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_sem.
+/**
+ * hdaps_calibrate - set our "resting" values.
+ * Does its own locking.
  */
 static void hdaps_calibrate(void)
 {
-	__hdaps_read_pair(EC_ACCEL_IDX_XPOS1, EC_ACCEL_IDX_YPOS1, &rest_x, &rest_y);
+	hdaps_update();
+	rest_x = pos_x;
+	rest_y = pos_y;
 }
 
+/* Timer handler for updating the input device. Runs in softirq context,
+ * so avoid lenghty or blocking operations.
+ */
 static void hdaps_mousedev_poll(unsigned long unused)
 {
-	int x, y;
+	int ret;
 
 	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
-	if (thinkpad_ec_try_lock()) {
-		mod_timer(&hdaps_timer,jiffies + HDAPS_POLL_PERIOD);
+	if (thinkpad_ec_try_lock())
+		goto keep_active;
+
+	ret = __hdaps_update(1); /* fast update, we're in softirq context */
+	thinkpad_ec_unlock();
+	/* Any of "successful", "not yet ready" and "not prefetched"? */
+	if (ret!=0 && ret!=-EBUSY && ret!=-ENODATA) {
+		printk(KERN_ERR
+		       "hdaps: poll failed, disabling mousedev updates\n");
 		return;
 	}
 
-	if (__hdaps_read_pair(EC_ACCEL_IDX_XPOS1, EC_ACCEL_IDX_YPOS1, &x, &y))
-		goto out;
-
-	input_report_abs(hdaps_idev, ABS_X, x - rest_x);
-	input_report_abs(hdaps_idev, ABS_Y, y - rest_y);
+keep_active:
+	/* Even if we failed now, pos_x,y may have been updated earlier: */
+	input_report_abs(hdaps_idev, ABS_X, pos_x - rest_x);
+	input_report_abs(hdaps_idev, ABS_Y, pos_y - rest_y);
 	input_sync(hdaps_idev);
-
 	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
-
-out:
-	thinkpad_ec_unlock();
 }
 
 
@@ -273,51 +297,37 @@ out:
 static ssize_t hdaps_position_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	int ret, x, y;
-
-	ret = hdaps_read_pair(EC_ACCEL_IDX_XPOS1, EC_ACCEL_IDX_YPOS1, &x, &y);
+	int ret = hdaps_update();
 	if (ret)
 		return ret;
-
-	return sprintf(buf, "(%d,%d)\n", x, y);
+	return sprintf(buf, "(%d,%d)\n", pos_x, pos_y);
 }
 
 static ssize_t hdaps_variance_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	int ret, x, y;
-
-	ret = hdaps_read_pair(EC_ACCEL_IDX_XPOS2, EC_ACCEL_IDX_YPOS2, &x, &y);
+	int ret = hdaps_update();
 	if (ret)
 		return ret;
-
-	return sprintf(buf, "(%d,%d)\n", x, y);
+	return sprintf(buf, "(%d,%d)\n", var_x, var_y);
 }
 
 static ssize_t hdaps_temp1_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 temp;
-	int ret;
-
-	ret = hdaps_readb_one(EC_ACCEL_IDX_TEMP1, &temp);
-	if (ret < 0)
+	int ret = hdaps_update();
+	if (ret)
 		return ret;
-
-	return sprintf(buf, "%u\n", temp);
+	return sprintf(buf, "%u\n", temp1);
 }
 
 static ssize_t hdaps_temp2_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 temp;
-	int ret;
-
-	ret = hdaps_readb_one(EC_ACCEL_IDX_TEMP2, &temp);
-	if (ret < 0)
+	int ret = hdaps_update();
+	if (ret)
 		return ret;
-
-	return sprintf(buf, "%u\n", temp);
+	return sprintf(buf, "%u\n", temp2);
 }
 
 static ssize_t hdaps_keyboard_activity_show(struct device *dev,
@@ -344,10 +354,7 @@ static ssize_t hdaps_calibrate_store(str
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	if (thinkpad_ec_lock())
-		return -EIO;
 	hdaps_calibrate();
-	thinkpad_ec_unlock();
 	return count;
 }
 
