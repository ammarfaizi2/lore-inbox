Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWHFHdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWHFHdw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWHFHdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:33:37 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:38053 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932591AbWHFHdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:33:22 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 11/12] hdaps: Stop polling timer when suspended
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:56 +0300
Message-Id: <1154849307861-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch stops the hdaps driver's polling timer when the module is 
suspended. Accessing a shut-down accelerometer is not harmful, but 
let's avoid it anyway.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -374,13 +374,19 @@ static int hdaps_probe(struct platform_d
 
 static int hdaps_suspend(struct platform_device *dev, pm_message_t state)
 {
+	/* Don't do hdaps polls until resume re-initializes the sensor. */
+	del_timer_sync(&hdaps_timer);
 	hdaps_device_shutdown();
 	return 0;
 }
 
 static int hdaps_resume(struct platform_device *dev)
 {
-	return hdaps_device_init();
+	int ret = hdaps_device_init();
+	if (ret)
+		return ret;
+	mod_timer(&hdaps_timer, jiffies + HZ/sampling_rate);
+	return 0;
 }
 
 static struct platform_driver hdaps_driver = {
@@ -421,7 +427,7 @@ static void hdaps_mousedev_poll(unsigned
 	/* Any of "successful", "not yet ready" and "not prefetched"? */
 	if (ret!=0 && ret!=-EBUSY && ret!=-ENODATA) {
 		printk(KERN_ERR 
-		       "hdaps: poll failed, disabling mousedev updates\n");
+		       "hdaps: poll failed, disabling update timer\n");
 		return;
 	}
 
@@ -720,6 +726,9 @@ static int __init hdaps_init(void)
 		goto out;
 	}
 
+	/* Init timer before platform_driver_register, in case of suspend */
+	init_timer(&hdaps_timer);
+	hdaps_timer.function = hdaps_mousedev_poll;
 	ret = platform_driver_register(&hdaps_driver);
 	if (ret)
 		goto out;
@@ -754,11 +763,7 @@ static int __init hdaps_init(void)
 
 	input_register_device(hdaps_idev);
 
-	/* start up our timer for the input device */
-	init_timer(&hdaps_timer);
-	hdaps_timer.function = hdaps_mousedev_poll;
-	hdaps_timer.expires = jiffies + HZ/sampling_rate;
-	add_timer(&hdaps_timer);
+	mod_timer(&hdaps_timer, jiffies + HZ/sampling_rate);
 
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
