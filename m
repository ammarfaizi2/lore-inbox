Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752602AbVHGTRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbVHGTRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbVHGTRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:17:44 -0400
Received: from europa.telenet-ops.be ([195.130.132.60]:61396 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1752602AbVHGTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:17:43 -0400
Date: Sun, 7 Aug 2005 21:17:38 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [WATCHDOG] i8xx_tco.c - patch to arm watchdog only when started (Kernel Bug 4251)
Message-ID: <20050807191738.GG499@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please add the following patch/bugfix:
i8xx_tco.c v0.08: only "arm" the watchdog when the watchdog has been started.
(Kernel Bug 4251: system reset when battery is read and i8xx_tco driver loaded)

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	2005-08-07 20:33:01 +02:00
+++ b/drivers/char/watchdog/i8xx_tco.c	2005-08-07 20:41:25 +02:00
@@ -1,5 +1,5 @@
 /*
- *	i8xx_tco 0.07:	TCO timer driver for i8xx chipsets
+ *	i8xx_tco:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -63,6 +63,9 @@
  *  20050128 Wim Van Sebroeck <wim@iguana.be>
  *	0.07 Added support for the ICH4-M, ICH6, ICH6R, ICH6-M, ICH6W and ICH6RW
  *	     chipsets. Also added support for the "undocumented" ICH7 chipset.
+ *  20050807 Wim Van Sebroeck <wim@iguana.be>
+ *	0.08 Make sure that the watchdog is only "armed" when started.
+ *	     (Kernel Bug 4251) 
  */
 
 /*
@@ -87,7 +90,7 @@
 #include "i8xx_tco.h"
 
 /* Module and version information */
-#define TCO_VERSION "0.07"
+#define TCO_VERSION "0.08"
 #define TCO_MODULE_NAME "i8xx TCO timer"
 #define TCO_DRIVER_NAME   TCO_MODULE_NAME ", v" TCO_VERSION
 #define PFX TCO_MODULE_NAME ": "
@@ -125,10 +128,18 @@
 	unsigned char val;
 
 	spin_lock(&tco_lock);
+
+	/* disable chipset's NO_REBOOT bit */
+	pci_read_config_byte (i8xx_tco_pci, 0xd4, &val);
+	val &= 0xfd;
+	pci_write_config_byte (i8xx_tco_pci, 0xd4, val);
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled to count */
 	val = inb (TCO1_CNT + 1);
 	val &= 0xf7;
 	outb (val, TCO1_CNT + 1);
 	val = inb (TCO1_CNT + 1);
+
 	spin_unlock(&tco_lock);
 
 	if (val & 0x08)
@@ -138,13 +149,20 @@
 
 static int tco_timer_stop (void)
 {
-	unsigned char val;
+	unsigned char val, val1;
 
 	spin_lock(&tco_lock);
+	/* Bit 11: TCO Timer Halt -> 1 = The TCO timer is disabled */
 	val = inb (TCO1_CNT + 1);
 	val |= 0x08;
 	outb (val, TCO1_CNT + 1);
 	val = inb (TCO1_CNT + 1);
+
+	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
+	pci_read_config_byte (i8xx_tco_pci, 0xd4, &val1);
+	val1 |= 0x02;
+	pci_write_config_byte (i8xx_tco_pci, 0xd4, val1);
+
 	spin_unlock(&tco_lock);
 
 	if ((val & 0x08) == 0)
@@ -155,6 +173,7 @@
 static int tco_timer_keepalive (void)
 {
 	spin_lock(&tco_lock);
+	/* Reload the timer by writing to the TCO Timer Reload register */
 	outb (0x01, TCO1_RLD);
 	spin_unlock(&tco_lock);
 	return 0;
@@ -417,9 +436,8 @@
 			printk (KERN_ERR PFX "failed to get TCOBASE address\n");
 			return 0;
 		}
-		/*
-		 * Check chipset's NO_REBOOT bit
-		 */
+
+		/* Check chipset's NO_REBOOT bit */
 		pci_read_config_byte (i8xx_tco_pci, 0xd4, &val1);
 		if (val1 & 0x02) {
 			val1 &= 0xfd;
@@ -430,6 +448,10 @@
 				return 0;	/* Cannot reset NO_REBOOT bit */
 			}
 		}
+		/* Disable reboots untill the watchdog starts */
+		val1 |= 0x02;
+		pci_write_config_byte (i8xx_tco_pci, 0xd4, val1);
+
 		/* Set the TCO_EN bit in SMI_EN register */
 		if (!request_region (SMI_EN + 1, 1, "i8xx TCO")) {
 			printk (KERN_ERR PFX "I/O address 0x%04x already in use\n",
@@ -505,17 +527,10 @@
 
 static void __exit watchdog_cleanup (void)
 {
-	u8 val;
-
 	/* Stop the timer before we leave */
 	if (!nowayout)
 		tco_timer_stop ();
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	pci_read_config_byte (i8xx_tco_pci, 0xd4, &val);
-	val |= 0x02;
-	pci_write_config_byte (i8xx_tco_pci, 0xd4, val);
-
 	/* Deregister */
 	misc_deregister (&i8xx_tco_miscdev);
 	unregister_reboot_notifier(&i8xx_tco_notifier);
