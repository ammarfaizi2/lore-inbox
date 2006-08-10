Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWHJJ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWHJJ4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWHJJzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:55:22 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:10140 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161133AbWHJJy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:54:56 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 10/12] hdaps: Power off accelerometer on suspend and unload
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:48 +0300
Message-Id: <1155203398339-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1155203330179-git-send-email-multinymous@gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables accelerometer power and stops its polling by the
embedded controller upon suspend and module unload. The power saving
is negligible, but it's the right thing to do.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>
---
 drivers/hwmon/hdaps.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -373,6 +373,23 @@ good:
 	return ret;
 }
 
+/**
+ * hdaps_device_shutdown - power off the accelerometer
+ * Returns nonzero on failure. Can sleep.
+ */
+static int hdaps_device_shutdown(void)
+{
+	int ret;
+	ret = hdaps_set_power(0);
+	if (ret) {
+		printk(KERN_WARNING "hdaps: cannot power off\n");
+		return ret;
+	}
+	ret = hdaps_set_ec_config(0, 1);
+	if (ret)
+		printk(KERN_WARNING "hdaps: cannot stop EC sampling\n");
+	return ret;
+}
 
 /* Device model stuff */
 
@@ -388,6 +405,12 @@ static int hdaps_probe(struct platform_d
 	return 0;
 }
 
+static int hdaps_suspend(struct platform_device *dev, pm_message_t state)
+{
+	hdaps_device_shutdown(); /* ignore errors, effect is negligible */
+	return 0;
+}
+
 static int hdaps_resume(struct platform_device *dev)
 {
 	return hdaps_device_init();
@@ -395,6 +418,7 @@ static int hdaps_resume(struct platform_
 
 static struct platform_driver hdaps_driver = {
 	.probe = hdaps_probe,
+	.suspend = hdaps_suspend,
 	.resume = hdaps_resume,
 	.driver	= {
 		.name = "hdaps",
@@ -776,6 +800,7 @@ out_device:
 	platform_device_unregister(pdev);
 out_driver:
 	platform_driver_unregister(&hdaps_driver);
+	hdaps_device_shutdown();
 out:
 	printk(KERN_WARNING "hdaps: driver init failed (ret=%d)!\n", ret);
 	return ret;
@@ -785,6 +810,7 @@ static void __exit hdaps_exit(void)
 {
 	del_timer_sync(&hdaps_timer);
 	input_unregister_device(hdaps_idev);
+	hdaps_device_shutdown(); /* ignore errors, effect is negligible */
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&hdaps_driver);
