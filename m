Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTBIQ5B>; Sun, 9 Feb 2003 11:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbTBIQ4p>; Sun, 9 Feb 2003 11:56:45 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:45708 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267345AbTBIQy7>;
	Sun, 9 Feb 2003 11:54:59 -0500
Date: Sun, 9 Feb 2003 12:05:06 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp - Convert sc1200wdt Driver (8/12) 2.5.59-bk3
Message-ID: <20030209120506.GA20022@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the sc1200wdt driver to the latest pnp code.

Please apply,

Adam


--- a/drivers/char/watchdog/sc1200wdt.c	Thu Jan 16 21:53:51 2003
+++ b/drivers/char/watchdog/sc1200wdt.c	Thu Jan 16 21:55:45 2003
@@ -23,6 +23,7 @@
  *					Add WDIOC_GETBOOTSTATUS and WDIOC_SETOPTIONS ioctls
  *					Fix CONFIG_WATCHDOG_NOWAYOUT
  *	20020530 Joel Becker		Add Matt Domsch's nowayout module option
+ *	20030116 Adam Belay		Updated to the latest pnp code
  *
  */
 
@@ -35,7 +36,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 #include <linux/pci.h>
 
 #include <asm/semaphore.h>
@@ -75,9 +76,9 @@
 static char expect_close;
 spinlock_t sc1200wdt_lock;	/* io port access serialisation */
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined CONFIG_PNP
 static int isapnp = 1;
-static struct pci_dev *wdt_dev;
+static struct pnp_dev *wdt_dev;
 
 MODULE_PARM(isapnp, "i");
 MODULE_PARM_DESC(isapnp, "When set to 0 driver ISA PnP support will be disabled");
@@ -328,40 +329,49 @@
 }
 
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined CONFIG_PNP
 
-static int __init sc1200wdt_isapnp_probe(void)
+struct pnp_device_id scl200wdt_pnp_devices[] = {
+	/* National Semiconductor PC87307/PC97307 watchdog component */
+	{.id = "NSC0800", .driver_data = 0},
+	{.id = ""}
+};
+
+static int scl200wdt_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
 {
-	int ret;
+	/* this driver only supports one card at a time */
+	if (wdt_dev || !isapnp)
+		return -EBUSY;
 
-	/* The WDT is logical device 8 on the main device */
-	wdt_dev = isapnp_find_dev(NULL, ISAPNP_VENDOR('N','S','C'), ISAPNP_FUNCTION(0x08), NULL);
-	if (!wdt_dev)
-		return -ENODEV;
-	
-	if (wdt_dev->prepare(wdt_dev) < 0) {
-		printk(KERN_ERR PFX "ISA PnP found device that could not be autoconfigured\n");
-		return -EAGAIN;
-	}
+	wdt_dev = dev;
+	io = pnp_port_start(wdt_dev, 0);
+	io_len = pnp_port_len(wdt_dev, 0);
 
-	if (!(pci_resource_flags(wdt_dev, 0) & IORESOURCE_IO)) {
-		printk(KERN_ERR PFX "ISA PnP could not find io ports\n");
-		return -ENODEV;
+	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
+		printk(KERN_ERR PFX "Unable to register IO port %#x\n", io);
+		return -EBUSY;
 	}
 
-	ret = wdt_dev->activate(wdt_dev);
-	if (ret && (ret != -EBUSY))
-		return -ENOMEM;
-
-	/* io port resource overriding support? */
-	io = pci_resource_start(wdt_dev, 0);
-	io_len = pci_resource_len(wdt_dev, 0);
-
-	printk(KERN_DEBUG PFX "ISA PnP found device at io port %#x/%d\n", io, io_len);
+	printk(KERN_INFO "scl200wdt: PnP device found at io port %#x/%d\n", io, io_len);
 	return 0;
 }
 
-#endif /* CONFIG_ISAPNP */
+static void scl200wdt_pnp_remove(struct pnp_dev * dev)
+{
+	if (wdt_dev){
+		release_region(io, io_len);
+		wdt_dev = NULL;
+	}
+}
+
+static struct pnp_driver scl200wdt_pnp_driver = {
+	.name		= "scl200wdt",
+	.id_table	= scl200wdt_pnp_devices,
+	.probe		= scl200wdt_pnp_probe,
+	.remove		= scl200wdt_pnp_remove,
+};
+
+#endif /* CONFIG_PNP */
 
 
 static int __init sc1200wdt_init(void)
@@ -373,9 +383,9 @@
 	spin_lock_init(&sc1200wdt_lock);
 	sema_init(&open_sem, 1);
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined CONFIG_PNP
 	if (isapnp) {
-		ret = sc1200wdt_isapnp_probe();
+		ret = pnp_register_driver(&scl200wdt_pnp_driver);
 		if (ret)
 			goto out_clean;
 	}
@@ -387,12 +397,17 @@
 		goto out_clean;
 	}
 
+	/* now that the user has specified an IO port and we haven't detected
+	 * any devices, disable pnp support */
+	isapnp = 0;
+	pnp_unregister_driver(&scl200wdt_pnp_driver);
+
 	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
 		printk(KERN_ERR PFX "Unable to register IO port %#x\n", io);
 		ret = -EBUSY;
-		goto out_pnp;
+		goto out_clean;
 	}
-
+	
 	ret = sc1200wdt_probe();
 	if (ret)
 		goto out_io;
@@ -420,11 +435,6 @@
 out_io:
 	release_region(io, io_len);
 
-out_pnp:
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
-	if (isapnp && wdt_dev)
-		wdt_dev->deactivate(wdt_dev);
-#endif
 	goto out_clean;
 }	
 
@@ -434,11 +444,11 @@
 	misc_deregister(&sc1200wdt_miscdev);
 	unregister_reboot_notifier(&sc1200wdt_notifier);
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
-	if(isapnp && wdt_dev)
-		wdt_dev->deactivate(wdt_dev);
+#if defined CONFIG_PNP
+	if(isapnp)
+		pnp_unregister_driver(&scl200wdt_pnp_driver);
+	else
 #endif
-
 	release_region(io, io_len);
 }
 
@@ -455,7 +465,7 @@
 		if (ints[0] > 1)
 			timeout = ints[2];
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined CONFIG_PNP
 		if (ints[0] > 2)
 			isapnp = ints[3];
 #endif
