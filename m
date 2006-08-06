Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWHFHdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWHFHdS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWHFHcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:32:48 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:18341 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932486AbWHFHcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:32:23 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:48 +0300
Message-Id: <1154849246822-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
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

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |  152 +++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 71 insertions(+), 81 deletions(-)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -63,66 +63,66 @@ static struct timer_list hdaps_timer;
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
+
+/* __hdaps_update - read current state and update global state variables.
+ * Also prefetches the next read, to reduce udelay busy-waiting.
+ * If fast!=0, do one quick attempt without retries.
+ * Caller must hold controller lock. 
  */
-static int hdaps_readb_one(unsigned int port, u8 *val)
+static int __hdaps_update(int fast)
 {
-	int ret;
+	/* Read data: */
 	struct thinkpad_ec_row data;
-
-	ret = thinkpad_ec_lock();
-	if (ret)
-		return ret;
-	data.mask = (1 << port);
-	ret = thinkpad_ec_read_row(&ec_accel_args, &data);
-	*val = data.val[port];
-	thinkpad_ec_unlock();
-	return ret;
-}
-
-/* __hdaps_read_pair - internal lockless helper for hdaps_read_pair(). */
-static int __hdaps_read_pair(unsigned int port1, unsigned int port2,
-			     int *x, int *y)
-{
 	int ret;
-	struct thinkpad_ec_row data;
 
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
+	pos_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1) * (hdaps_invert?-1:1);
+	pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1) * (hdaps_invert?-1:1);
+
+	/* Parse so-called "variance" data: */
+	var_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS2) * (hdaps_invert?-1:1);
+	var_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS2) * (hdaps_invert?-1:1);
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
+/* hdaps_update - read current state and update global state variables.
+ * Also prefetches the next read, to reduce udelay busy-waiting.
+ * Retries until timeout if the accelerometer is not in ready status (common).
+ * Does its own locking.
  */
-static int hdaps_read_pair(unsigned int port1, unsigned int port2,
-			   int *val1, int *val2)
+static int hdaps_update(void)
 {
-	int ret = thinkpad_ec_lock();
+	int ret;
+	ret = thinkpad_ec_lock();
 	if (ret)
 		return ret;
-	ret = __hdaps_read_pair(port1, port2, val1, val2);
+	ret = __hdaps_update(0);
 	thinkpad_ec_unlock();
 	return ret;
 }
@@ -237,34 +237,41 @@ static struct platform_driver hdaps_driv
 };
 
 /*
- * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_sem.
+ * hdaps_calibrate - Set our "resting" values. Does its own locking.
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
 
 
@@ -273,51 +280,37 @@ out:
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
@@ -344,10 +337,7 @@ static ssize_t hdaps_calibrate_store(str
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	if (thinkpad_ec_lock())
-		return -EIO;
 	hdaps_calibrate();
-	thinkpad_ec_unlock();
 	return count;
 }
 
