Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWHFHez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWHFHez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWHFHdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:33:18 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:36261 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932522AbWHFHdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:33:15 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 10/12] hdaps: Power off accelerometer on suspend and unload
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:55 +0300
Message-Id: <11548492972486-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables accelerometer power and stops its polling by the
embedded controller upon suspend and module unload. The power saving
is negligible, but it's the right thing to do.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -348,6 +348,15 @@ good:
 	return ret;
 }
 
+/*
+ * hdaps_device_shutdown - power off the accelerometer. Can sleep.
+ */
+static void hdaps_device_shutdown(void) {
+	if (hdaps_set_power(0))
+		printk(KERN_WARNING "hdaps: cannot power off\n");
+	if (hdaps_set_ec_config(0, 1))
+		printk(KERN_WARNING "hdaps: cannot stop EC sampling\n");
+}
 
 /* Device model stuff */
 
@@ -363,6 +372,12 @@ static int hdaps_probe(struct platform_d
 	return 0;
 }
 
+static int hdaps_suspend(struct platform_device *dev, pm_message_t state)
+{
+	hdaps_device_shutdown();
+	return 0;
+}
+
 static int hdaps_resume(struct platform_device *dev)
 {
 	return hdaps_device_init();
@@ -370,6 +385,7 @@ static int hdaps_resume(struct platform_
 
 static struct platform_driver hdaps_driver = {
 	.probe = hdaps_probe,
+	.suspend = hdaps_suspend,
 	.resume = hdaps_resume,
 	.driver	= {
 		.name = "hdaps",
@@ -762,6 +778,7 @@ static void __exit hdaps_exit(void)
 {
 	del_timer_sync(&hdaps_timer);
 	input_unregister_device(hdaps_idev);
+	hdaps_device_shutdown();
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&hdaps_driver);
