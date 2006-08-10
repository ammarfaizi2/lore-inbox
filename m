Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWHJJ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWHJJ4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWHJJyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:54:40 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:1692 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161133AbWHJJy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:54:29 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 06/12] hdaps: Limit hardware query rate
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:44 +0300
Message-Id: <11552033701218-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current hdaps driver queries the hardware on (almost) any sysfs read.
Since fresh readouts are genereated by the hardware at a constant rate,
this means apps are eating each other's events. Also, polling multiple
attributes will genereate excessive hardware queries and excessive CPU
load due to the duration of the hardware query transaction.

With this patch, the driver will normally update its cached readouts
only in its timer function (which exists anyway, for the input device).
If that read failed, it will be retried upon the actual sysfs access.
In all cases, query rate is bounded and apps will get reasonably
fresh and usually cached readouts.

The polling rate is increased to 50Hz, as needed by the hdaps daemon.
A later patch makes this configurable.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -57,7 +57,7 @@ static const struct thinkpad_ec_row ec_a
 #define READ_TIMEOUT_MSECS	100	/* wait this long for device read */
 #define RETRY_MSECS		3	/* retry delay */
 
-#define HDAPS_POLL_PERIOD	(HZ/20)	/* poll for input every 1/20s */
+#define HDAPS_POLL_PERIOD	(HZ/50)	/* poll for input every 1/50s */
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
 #define HDAPS_INPUT_FLAT	4
 #define KMACT_REMEMBER_PERIOD   (HZ/10) /* keyboard/mouse persistance */
@@ -67,10 +67,11 @@ static struct platform_device *pdev;
 static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
 
-/* Latest state readout */
-static int pos_x, pos_y;   /* position */
-static int temperature;    /* temperature */
-static int rest_x, rest_y; /* calibrated rest position */
+/* Latest state readout: */
+static int pos_x, pos_y;      /* position */
+static int temperature;       /* temperature */
+static int stale_readout = 1; /* last read invalid */
+static int rest_x, rest_y;    /* calibrated rest position */
 
 /* Last time we saw keyboard and mouse activity: */
 static u64 last_keyboard_jiffies = INITIAL_JIFFIES;
@@ -135,6 +136,7 @@ static int __hdaps_update(int fast)
 
 	temperature = data.val[EC_ACCEL_IDX_TEMP1];
 
+	stale_readout = 0;
 	return 0;
 }
 
@@ -149,6 +151,8 @@ static int __hdaps_update(int fast)
 static int hdaps_update(void)
 {
 	int total, ret;
+	if (!stale_readout) /* already updated recently? */
+		return 0;
 	for (total=0; total<READ_TIMEOUT_MSECS; total+=RETRY_MSECS) {
 		ret = thinkpad_ec_lock();
 		if (ret)
@@ -244,6 +248,7 @@ bad:
 	thinkpad_ec_invalidate();
 	ret = -ENXIO;
 good:
+	stale_readout = 1;
 	thinkpad_ec_unlock();
 	return ret;
 }
@@ -295,6 +300,8 @@ static void hdaps_mousedev_poll(unsigned
 {
 	int ret;
 
+	stale_readout = 1;
+
 	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
 	if (thinkpad_ec_try_lock())
 		goto keep_active;
@@ -304,7 +311,7 @@ static void hdaps_mousedev_poll(unsigned
 	/* Any of "successful", "not yet ready" and "not prefetched"? */
 	if (ret!=0 && ret!=-EBUSY && ret!=-ENODATA) {
 		printk(KERN_ERR
-		       "hdaps: poll failed, disabling mousedev updates\n");
+		       "hdaps: poll failed, disabling updates\n");
 		return;
 	}
 
