Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWHJJ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWHJJ4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWHJJzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:55:18 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:20636 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161142AbWHJJzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:55:09 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 11/12] hdaps: Stop polling timer when suspended
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:49 +0300
Message-Id: <11552034053667-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch stops the hdaps driver's polling timer when the module is 
suspended. Accessing a shut-down accelerometer is not harmful, but 
let's avoid it anyway.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -407,13 +407,19 @@ static int hdaps_probe(struct platform_d
 
 static int hdaps_suspend(struct platform_device *dev, pm_message_t state)
 {
+	/* Don't do hdaps polls until resume re-initializes the sensor. */
+	del_timer_sync(&hdaps_timer);
 	hdaps_device_shutdown(); /* ignore errors, effect is negligible */
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
@@ -751,6 +757,9 @@ static int __init hdaps_init(void)
 		goto out;
 	}
 
+	/* Init timer before platform_driver_register, in case of suspend */
+	init_timer(&hdaps_timer);
+	hdaps_timer.function = hdaps_mousedev_poll;
 	ret = platform_driver_register(&hdaps_driver);
 	if (ret)
 		goto out;
@@ -785,11 +794,7 @@ static int __init hdaps_init(void)
 
 	input_register_device(hdaps_idev);
 
-	/* start up our timer for the input device */
-	init_timer(&hdaps_timer);
-	hdaps_timer.function = hdaps_mousedev_poll;
-	hdaps_timer.expires = jiffies + HZ/sampling_rate;
-	add_timer(&hdaps_timer);
+	mod_timer(&hdaps_timer, jiffies + HZ/sampling_rate);
 
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
