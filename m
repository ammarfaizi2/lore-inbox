Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbVKEK7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVKEK7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVKEK7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:59:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60175 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751462AbVKEK7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:59:36 -0500
Date: Sat, 5 Nov 2005 10:59:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Fix arcfb
Message-ID: <20051105105931.GD30315@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105105628.GE28438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105105628.GE28438@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release code in driver modules is a potential cause of oopsen.
The device may be in use by a userspace process, which will keep
a reference to the device.  If the module is unloaded, the module
text will be freed.  Subsequently, when the last reference is
dropped, the release code will be called, which no longer exists.

Use generic platform device allocation/release code in modules.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -502,10 +502,6 @@ static ssize_t arcfb_write(struct file *
 	return err;
 }
 
-static void arcfb_platform_release(struct device *device)
-{
-}
-
 static struct fb_ops arcfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= arcfb_open,
@@ -624,13 +620,7 @@ static struct device_driver arcfb_driver
 	.remove = arcfb_remove,
 };
 
-static struct platform_device arcfb_device = {
-	.name	= "arcfb",
-	.id	= 0,
-	.dev	= {
-		.release = arcfb_platform_release,
-	}
-};
+static struct platform_device *arcfb_device;
 
 static int __init arcfb_init(void)
 {
@@ -641,9 +631,16 @@ static int __init arcfb_init(void)
 
 	ret = driver_register(&arcfb_driver);
 	if (!ret) {
-		ret = platform_device_register(&arcfb_device);
-		if (ret)
+		arcfb_device = platform_device_alloc("arcfb", 0);
+		if (arcfb_device) {
+			ret = platform_device_add(arcfb_device);
+		} else {
+			ret = -ENOMEM;
+		}
+		if (ret) {
+			platform_device_put(arcfb_device);
 			driver_unregister(&arcfb_driver);
+		}
 	}
 	return ret;
 
@@ -651,7 +648,7 @@ static int __init arcfb_init(void)
 
 static void __exit arcfb_exit(void)
 {
-	platform_device_unregister(&arcfb_device);
+	platform_device_unregister(arcfb_device);
 	driver_unregister(&arcfb_driver);
 }
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
