Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbVKELAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVKELAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 06:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVKELAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 06:00:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60431 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751461AbVKELAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 06:00:08 -0500
Date: Sat, 5 Nov 2005 10:59:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Fix gbefb
Message-ID: <20051105105958.GE30315@flint.arm.linux.org.uk>
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

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1254,17 +1254,22 @@ static struct device_driver gbefb_driver
 	.remove = __devexit_p(gbefb_remove),
 };
 
-static struct platform_device gbefb_device = {
-	.name = "gbefb",
-};
+static struct platform_device *gbefb_device;
 
 int __init gbefb_init(void)
 {
 	int ret = driver_register(&gbefb_driver);
 	if (!ret) {
-		ret = platform_device_register(&gbefb_device);
-		if (ret)
+		gbefb_device = platform_device_alloc("gbefb", 0);
+		if (gbefb_device) {
+			ret = platform_device_add(gbefb_device);
+		} else {
+			ret = -ENOMEM;
+		}
+		if (ret) {
+			platform_device_put(gbefb_device);
 			driver_unregister(&gbefb_driver);
+		}
 	}
 	return ret;
 }
@@ -1271,7 +1276,8 @@ int __init gbefb_init(void)
 
 void __exit gbefb_exit(void)
 {
-	 driver_unregister(&gbefb_driver);
+	platform_device_unregister(gbefb_device);
+	driver_unregister(&gbefb_driver);
 }
 
 module_init(gbefb_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
