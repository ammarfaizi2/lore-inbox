Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVKEK5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVKEK5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVKEK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:57:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59407 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751448AbVKEK5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:57:49 -0500
Date: Sat, 5 Nov 2005 10:57:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Fix depca
Message-ID: <20051105105744.GA30315@flint.arm.linux.org.uk>
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

diff --git a/drivers/net/depca.c b/drivers/net/depca.c
--- a/drivers/net/depca.c
+++ b/drivers/net/depca.c
@@ -1470,15 +1470,6 @@ static int __init depca_mca_probe(struct
 ** ISA bus I/O device probe
 */
 
-static void depca_platform_release (struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device (device);
-	kfree (pldev);
-}
-
 static void __init depca_platform_probe (void)
 {
 	int i;
@@ -1491,19 +1482,16 @@ static void __init depca_platform_probe 
 		 * line, use it (if valid) */
 		if (io && io != depca_io_ports[i].iobase)
 			continue;
-		
-		if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL)))
+
+		pldev = platform_device_alloc(depca_string, i);
+		if (!pldev)
 			continue;
 
-		memset (pldev, 0, sizeof (*pldev));
-		pldev->name = depca_string;
-		pldev->id   = i;
 		pldev->dev.platform_data = (void *) depca_io_ports[i].iobase;
-		pldev->dev.release       = depca_platform_release;
 		depca_io_ports[i].device = pldev;
 
-		if (platform_device_register (pldev)) {
-			kfree (pldev);
+		if (platform_device_add(pldev)) {
+			platform_device_put(pldev);
 			depca_io_ports[i].device = NULL;
 			continue;
 		}
@@ -1515,6 +1503,7 @@ static void __init depca_platform_probe 
 		 * allocated structure */
 			
 			depca_io_ports[i].device = NULL;
+			pldev->dev.platform_data = NULL;
 			platform_device_unregister (pldev);
 		}
 	}
@@ -2112,6 +2101,7 @@ static void __exit depca_module_exit (vo
 
 	for (i = 0; depca_io_ports[i].iobase; i++) {
 		if (depca_io_ports[i].device) {
+			depca_io_ports[i].device->dev.platform_data = NULL;
 			platform_device_unregister (depca_io_ports[i].device);
 			depca_io_ports[i].device = NULL;
 		}


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
