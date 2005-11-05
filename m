Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVKEK6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVKEK6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVKEK6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:58:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59663 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751454AbVKEK6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:58:24 -0500
Date: Sat, 5 Nov 2005 10:58:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Fix jazzsonic
Message-ID: <20051105105819.GB30315@flint.arm.linux.org.uk>
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

diff --git a/drivers/net/jazzsonic.c b/drivers/net/jazzsonic.c
--- a/drivers/net/jazzsonic.c
+++ b/drivers/net/jazzsonic.c
@@ -285,18 +285,8 @@ static struct device_driver jazz_sonic_d
 	.remove	= __devexit_p(jazz_sonic_device_remove),
 };
 
-static void jazz_sonic_platform_release (struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device (device);
-	kfree (pldev);
-}
-
 static int __init jazz_sonic_init_module(void)
 {
-	struct platform_device *pldev;
 	int err;
 
 	if ((err = driver_register(&jazz_sonic_driver))) {
@@ -304,27 +294,19 @@ static int __init jazz_sonic_init_module
 		return err;
 	}
 
-	jazz_sonic_device = NULL;
-
-	if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL))) {
+	jazz_sonic_device = platform_device_alloc(jazz_sonic_string, 0);
+	if (!jazz_sonnic_device)
 		goto out_unregister;
-	}
 
-	memset(pldev, 0, sizeof (*pldev));
-	pldev->name		= jazz_sonic_string;
-	pldev->id		= 0;
-	pldev->dev.release	= jazz_sonic_platform_release;
-	jazz_sonic_device	= pldev;
-
-	if (platform_device_register (pldev)) {
-		kfree(pldev);
+	if (platform_device_add(jazz_sonic_device)) {
+		platform_device_put(jazz_sonic_device);
 		jazz_sonic_device = NULL;
 	}
 
 	return 0;
 
 out_unregister:
-	platform_device_unregister(pldev);
+	driver_unregister(&jazz_sonic_driver);
 
 	return -ENOMEM;
 }


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
