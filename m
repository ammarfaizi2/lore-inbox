Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWHJJyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWHJJyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWHJJyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:54:41 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:64923 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161128AbWHJJyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:54:21 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 05/12] hdaps: Remember keyboard and mouse activity
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:43 +0300
Message-Id: <11552033643022-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the current hdaps driver is queried for recent keyboard/mouse activity
(which is provided by the hardware for use in disk parking daemons), it
simply returns the last readout. However, every hardware query resets the
activity flag in the hardware, and this is triggered by (almost) any
hdaps sysfs attribute read, so the flag could be reset before it is 
observed and is thus nearly useless.

This patch makes the activities flags persist for 0.1sec, by remembering
when was the last time we saw them set. This gives apps like the hdaps
daemon enough time to poll the flag.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -53,8 +53,6 @@ static const struct thinkpad_ec_row ec_a
 
 #define KEYBD_MASK		0x20	/* set if keyboard activity */
 #define MOUSE_MASK		0x40	/* set if mouse activity */
-#define KEYBD_ISSET(n)		(!! (n & KEYBD_MASK))	/* keyboard used? */
-#define MOUSE_ISSET(n)		(!! (n & MOUSE_MASK))	/* mouse used? */
 
 #define READ_TIMEOUT_MSECS	100	/* wait this long for device read */
 #define RETRY_MSECS		3	/* retry delay */
@@ -62,6 +60,7 @@ static const struct thinkpad_ec_row ec_a
 #define HDAPS_POLL_PERIOD	(HZ/20)	/* poll for input every 1/20s */
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
 #define HDAPS_INPUT_FLAT	4
+#define KMACT_REMEMBER_PERIOD   (HZ/10) /* keyboard/mouse persistance */
 
 static struct timer_list hdaps_timer;
 static struct platform_device *pdev;
@@ -71,9 +70,12 @@ static unsigned int hdaps_invert;
 /* Latest state readout */
 static int pos_x, pos_y;   /* position */
 static int temperature;    /* temperature */
-static u8 km_activity;
 static int rest_x, rest_y; /* calibrated rest position */
 
+/* Last time we saw keyboard and mouse activity: */
+static u64 last_keyboard_jiffies = INITIAL_JIFFIES;
+static u64 last_mouse_jiffies = INITIAL_JIFFIES;
+
 /* Some models require an axis transformation to the standard reprsentation */
 void transform_axes(int *x, int *y)
 {
@@ -122,7 +124,14 @@ static int __hdaps_update(int fast)
 	pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1);
 	transform_axes(&pos_x, &pos_y);
 
-	km_activity = data.val[EC_ACCEL_IDX_KMACT];
+	/* Keyboard and mouse activity status is cleared as soon as it's read,
+	 * so applications will eat each other's events. Thus we remember any
+	 * event for KMACT_REMEMBER_PERIOD jiffies.
+	 */
+	if (data.val[EC_ACCEL_IDX_KMACT] & KEYBD_MASK)
+		last_keyboard_jiffies = get_jiffies_64();
+	if (data.val[EC_ACCEL_IDX_KMACT] & MOUSE_MASK)
+		last_mouse_jiffies = get_jiffies_64();
 
 	temperature = data.val[EC_ACCEL_IDX_TEMP1];
 
@@ -332,14 +341,22 @@ static ssize_t hdaps_keyboard_activity_s
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	return sprintf(buf, "%u\n", KEYBD_ISSET(km_activity));
+	int ret = hdaps_update();
+	if (ret)
+		return ret;
+	return sprintf(buf, "%u\n",
+	   get_jiffies_64() < last_keyboard_jiffies + KMACT_REMEMBER_PERIOD);
 }
 
 static ssize_t hdaps_mouse_activity_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	return sprintf(buf, "%u\n", MOUSE_ISSET(km_activity));
+	int ret = hdaps_update();
+	if (ret)
+		return ret;
+	return sprintf(buf, "%u\n",
+	   get_jiffies_64() < last_mouse_jiffies + KMACT_REMEMBER_PERIOD);
 }
 
 static ssize_t hdaps_calibrate_show(struct device *dev,
