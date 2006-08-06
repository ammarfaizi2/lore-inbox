Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWHFHcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWHFHcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWHFHcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:32:45 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:20133 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932502AbWHFHca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:32:30 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:49 +0300
Message-Id: <11548492543835-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current hdaps driver got some details wrong about the result of
hardware queries. 

First, it fails to check a couple of status values.

Second, it turns out that the hardware will return up to two readouts:
the latest one and also the previous one if it was missed (host didn't
poll fast enough). The current driver wrongly interprets the latter as
a "variance", which is nonsensical. We have no use for that previous
readout, so it should be ignored.

This patch adds proper status checking, and removes the "variance" and
"temp2" sysfs attributes which refer to the old readout.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |   75 +++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -49,12 +49,16 @@ static const struct thinkpad_ec_row ec_a
 #define EC_ACCEL_IDX_TEMP2	0xb	/*   device temperature in Celsius */
 #define EC_ACCEL_IDX_QUEUED	0xc	/* Number of queued readouts left */
 #define EC_ACCEL_IDX_KMACT	0xd	/* keyboard or mouse activity */
+#define EC_ACCEL_IDX_RETVAL	0xf	/* command return value, good=0x00 */
 
 #define KEYBD_MASK		0x20	/* set if keyboard activity */
 #define MOUSE_MASK		0x40	/* set if mouse activity */
 #define KEYBD_ISSET(n)		(!! (n & KEYBD_MASK))	/* keyboard used? */
 #define MOUSE_ISSET(n)		(!! (n & MOUSE_MASK))	/* mouse used? */
 
+#define READ_TIMEOUT_MSECS	100	/* wait this long for device read */
+#define RETRY_MSECS		3	/* retry delay */
+
 #define HDAPS_POLL_PERIOD	(HZ/20)	/* poll for input every 1/20s */
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
 #define HDAPS_INPUT_FLAT	4
@@ -66,12 +70,10 @@ static unsigned int hdaps_invert;
 
 /* Latest state readout */
 static int pos_x, pos_y;   /* position */
-static int var_x, var_y;   /* variance (what is this?) */
-static u8 temp1, temp2;    /* temperatures */
+static int temperature;    /* temperature */
 static u8 km_activity;
 static int rest_x, rest_y; /* calibrated rest position */
 
-
 /* __hdaps_update - read current state and update global state variables.
  * Also prefetches the next read, to reduce udelay busy-waiting.
  * If fast!=0, do one quick attempt without retries.
@@ -83,10 +85,9 @@ static int __hdaps_update(int fast)
 	struct thinkpad_ec_row data;
 	int ret;
 
-	data.mask = (1 << EC_ACCEL_IDX_KMACT)    |
+	data.mask = (1 << EC_ACCEL_IDX_READOUTS) | (1 << EC_ACCEL_IDX_KMACT) |
 	            (3 << EC_ACCEL_IDX_YPOS1)    | (3 << EC_ACCEL_IDX_XPOS1) |
-	            (3 << EC_ACCEL_IDX_YPOS2)    | (3 << EC_ACCEL_IDX_XPOS2) |
-	            (1 << EC_ACCEL_IDX_TEMP1)    | (1 << EC_ACCEL_IDX_TEMP2);
+	            (1 << EC_ACCEL_IDX_TEMP1)    | (1 << EC_ACCEL_IDX_RETVAL);
 	if (fast)
 		ret = thinkpad_ec_try_read_row(&ec_accel_args, &data);
 	else
@@ -95,18 +96,23 @@ static int __hdaps_update(int fast)
 	if (ret)
 		return ret;
 
+	/* Check status: */
+	if (data.val[EC_ACCEL_IDX_RETVAL] != 0x00) {
+		printk(KERN_WARNING "hdaps: read RETVAL=0x%02x\n",
+		       data.val[EC_ACCEL_IDX_RETVAL]);
+		return -EIO;
+	}
+
+	if (data.val[EC_ACCEL_IDX_READOUTS]<1)
+		return -EBUSY; /* no pending readout, try again later */
+
 	/* Parse position data: */
 	pos_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1) * (hdaps_invert?-1:1);
 	pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1) * (hdaps_invert?-1:1);
 
-	/* Parse so-called "variance" data: */
-	var_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS2) * (hdaps_invert?-1:1);
-	var_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS2) * (hdaps_invert?-1:1);
-
 	km_activity = data.val[EC_ACCEL_IDX_KMACT];
 
-	temp1 = data.val[EC_ACCEL_IDX_TEMP1];
-	temp2 = data.val[EC_ACCEL_IDX_TEMP2];
+	temperature = data.val[EC_ACCEL_IDX_TEMP1];
 
 	return 0;
 }
@@ -118,12 +124,20 @@ static int __hdaps_update(int fast)
  */
 static int hdaps_update(void)
 {
-	int ret;
-	ret = thinkpad_ec_lock();
-	if (ret)
-		return ret;
-	ret = __hdaps_update(0);
-	thinkpad_ec_unlock();
+	int total, ret;
+	for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
+		ret = thinkpad_ec_lock();
+		if (ret)
+			return ret;
+		ret = __hdaps_update(0);
+		thinkpad_ec_unlock();
+
+		if (!ret)
+			return 0;
+		if (ret != -EBUSY)
+			break;
+		msleep(RETRY_MSECS);
+	}
 	return ret;
 }
 
@@ -286,31 +300,13 @@ static ssize_t hdaps_position_show(struc
 	return sprintf(buf, "(%d,%d)\n", pos_x, pos_y);
 }
 
-static ssize_t hdaps_variance_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	int ret = hdaps_update();
-	if (ret)
-		return ret;
-	return sprintf(buf, "(%d,%d)\n", var_x, var_y);
-}
-
 static ssize_t hdaps_temp1_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret = hdaps_update();
 	if (ret)
 		return ret;
-	return sprintf(buf, "%u\n", temp1);
-}
-
-static ssize_t hdaps_temp2_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	int ret = hdaps_update();
-	if (ret)
-		return ret;
-	return sprintf(buf, "%u\n", temp2);
+	return sprintf(buf, "%d\n", temperature);
 }
 
 static ssize_t hdaps_keyboard_activity_show(struct device *dev,
@@ -363,9 +359,8 @@ static ssize_t hdaps_invert_store(struct
 }
 
 static DEVICE_ATTR(position, 0444, hdaps_position_show, NULL);
-static DEVICE_ATTR(variance, 0444, hdaps_variance_show, NULL);
 static DEVICE_ATTR(temp1, 0444, hdaps_temp1_show, NULL);
-static DEVICE_ATTR(temp2, 0444, hdaps_temp2_show, NULL);
+  /* "temp1" instead of "temperature" is hwmon convention */
 static DEVICE_ATTR(keyboard_activity, 0444, hdaps_keyboard_activity_show, NULL);
 static DEVICE_ATTR(mouse_activity, 0444, hdaps_mouse_activity_show, NULL);
 static DEVICE_ATTR(calibrate, 0644, hdaps_calibrate_show,hdaps_calibrate_store);
@@ -373,9 +368,7 @@ static DEVICE_ATTR(invert, 0644, hdaps_i
 
 static struct attribute *hdaps_attributes[] = {
 	&dev_attr_position.attr,
-	&dev_attr_variance.attr,
 	&dev_attr_temp1.attr,
-	&dev_attr_temp2.attr,
 	&dev_attr_keyboard_activity.attr,
 	&dev_attr_mouse_activity.attr,
 	&dev_attr_calibrate.attr,
