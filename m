Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbVKELAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVKELAk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 06:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbVKELAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 06:00:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60943 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751465AbVKELAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 06:00:38 -0500
Date: Sat, 5 Nov 2005 11:00:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Fix sgivwfb
Message-ID: <20051105110030.GF30315@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105105628.GE28438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105105628.GE28438@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated devices in module data is a potential cause
of oopsen.  The device may be in use by a userspace process, which
will keep a reference to the device.  If the module is unloaded,
the module data will be freed.  Subsequent use of the platform
device will cause a kernel oops.

Use generic platform device allocation/release code in modules.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -751,10 +751,6 @@ int __init sgivwfb_setup(char *options)
 /*
  *  Initialisation
  */
-static void sgivwfb_release(struct device *device)
-{
-}
-
 static int __init sgivwfb_probe(struct device *device)
 {
 	struct platform_device *dev = to_platform_device(device);
@@ -859,13 +855,7 @@ static struct device_driver sgivwfb_driv
 	.remove	= sgivwfb_remove,
 };
 
-static struct platform_device sgivwfb_device = {
-	.name	= "sgivwfb",
-	.id	= 0,
-	.dev	= {
-		.release = sgivwfb_release,
-	}
-};
+static struct platform_device *sgivwfb_device;
 
 int __init sgivwfb_init(void)
 {
@@ -880,9 +870,15 @@ int __init sgivwfb_init(void)
 #endif
 	ret = driver_register(&sgivwfb_driver);
 	if (!ret) {
-		ret = platform_device_register(&sgivwfb_device);
-		if (ret)
+		sgivwfb_device = platform_device_alloc("sgivwfb", 0);
+		if (sgivwfb_device) {
+			ret = platform_device_add(sgivwfb_device);
+		} else
+			ret = -ENOMEM;
+		if (ret) {
 			driver_unregister(&sgivwfb_driver);
+			platform_device_put(sgivwfb_device);
+		}
 	}
 	return ret;
 }
@@ -894,7 +890,7 @@ MODULE_LICENSE("GPL");
 
 static void __exit sgivwfb_exit(void)
 {
-	platform_device_unregister(&sgivwfb_device);
+	platform_device_unregister(sgivwfb_device);
 	driver_unregister(&sgivwfb_driver);
 }
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
