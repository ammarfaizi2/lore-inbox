Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWG2TuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWG2TuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWG2TuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:50:18 -0400
Received: from halon.profiwh.com ([85.93.165.2]:24317 "EHLO orfeus.profiwh.com")
	by vger.kernel.org with ESMTP id S1752027AbWG2TuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:50:16 -0400
Message-id: <Watchdog.alim.remove.pci_find_device@ink.os>
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <wim@iguana.be>
Cc: <steve@navaho.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH -repost] Watchdog: alim remove pci_find_device
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Sat, 29 Jul 2006 15:50:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Watchdog: alim remove pci_find_device

Convert pci_find_device to pci_get_device + pci_dev_put in alim watchdog
cards' drivers (refcounting).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 001c77888611f9f4d7cb8db8ba002364f69b1c3f
tree 02532fced9500ec5cd7cbf0238ff9b267adab046
parent fd2ffd531f4fefc2235a4c27614abda74078ef94
author Jiri Slaby <ku@bellona.localdomain> Tue, 18 Jul 2006 18:29:00 +0159
committer Jiri Slaby <ku@bellona.localdomain> Tue, 18 Jul 2006 18:29:00 +0159

 drivers/char/watchdog/alim1535_wdt.c |   10 +++++++---
 drivers/char/watchdog/alim7101_wdt.c |   15 ++++++++++-----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
index c5c94e4..0b2c8e8 100644
--- a/drivers/char/watchdog/alim1535_wdt.c
+++ b/drivers/char/watchdog/alim1535_wdt.c
@@ -330,17 +330,20 @@ static int __init ali_find_watchdog(void
 	u32 wdog;
 
 	/* Check for a 1535 series bridge */
-	pdev = pci_find_device(PCI_VENDOR_ID_AL, 0x1535, NULL);
+	pdev = pci_get_device(PCI_VENDOR_ID_AL, 0x1535, NULL);
 	if(pdev == NULL)
 		return -ENODEV;
+	pci_dev_put(pdev);
 
 	/* Check for the a 7101 PMU */
-	pdev = pci_find_device(PCI_VENDOR_ID_AL, 0x7101, NULL);
+	pdev = pci_get_device(PCI_VENDOR_ID_AL, 0x7101, NULL);
 	if(pdev == NULL)
 		return -ENODEV;
 
-	if(pci_enable_device(pdev))
+	if(pci_enable_device(pdev)) {
+		pci_dev_put(pdev);
 		return -EIO;
+	}
 
 	ali_pci = pdev;
 
@@ -447,6 +450,7 @@ static void __exit watchdog_exit(void)
 	/* Deregister */
 	unregister_reboot_notifier(&ali_notifier);
 	misc_deregister(&ali_miscdev);
+	pci_dev_put(ali_pci);
 }
 
 module_init(watchdog_init);
diff --git a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
index ffd7684..383f9bf 100644
--- a/drivers/char/watchdog/alim7101_wdt.c
+++ b/drivers/char/watchdog/alim7101_wdt.c
@@ -333,6 +333,7 @@ static void __exit alim7101_wdt_unload(v
 	/* Deregister */
 	misc_deregister(&wdt_miscdev);
 	unregister_reboot_notifier(&wdt_notifier);
+	pci_dev_put(alim7101_pmu);
 }
 
 static int __init alim7101_wdt_init(void)
@@ -342,7 +343,8 @@ static int __init alim7101_wdt_init(void
 	char tmp;
 
 	printk(KERN_INFO PFX "Steve Hill <steve@navaho.co.uk>.\n");
-	alim7101_pmu = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,NULL);
+	alim7101_pmu = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+		NULL);
 	if (!alim7101_pmu) {
 		printk(KERN_INFO PFX "ALi M7101 PMU not present - WDT not set\n");
 		return -EBUSY;
@@ -351,21 +353,23 @@ static int __init alim7101_wdt_init(void
 	/* Set the WDT in the PMU to 1 second */
 	pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, 0x02);
 
-	ali1543_south = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	ali1543_south = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+		NULL);
 	if (!ali1543_south) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge not present - WDT not set\n");
-		return -EBUSY;
+		goto err_out;
 	}
 	pci_read_config_byte(ali1543_south, 0x5e, &tmp);
+	pci_dev_put(ali1543_south);
 	if ((tmp & 0x1e) == 0x00) {
 		if (!use_gpio) {
 			printk(KERN_INFO PFX "Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.\n");
-			return -EBUSY;
+			goto err_out;
 		} 
 		nowayout = 1;
 	} else if ((tmp & 0x1e) != 0x12 && (tmp & 0x1e) != 0x00) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge does not have the correct revision number (???1001?) - WDT not set\n");
-		return -EBUSY;
+		goto err_out;
 	}
 
 	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
@@ -404,6 +408,7 @@ static int __init alim7101_wdt_init(void
 err_out_miscdev:
 	misc_deregister(&wdt_miscdev);
 err_out:
+	pci_dev_put(alim7101_pmu);
 	return rc;
 }
 
