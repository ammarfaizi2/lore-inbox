Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVJXNNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVJXNNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVJXNNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:13:51 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:11743 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750988AbVJXNNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:13:50 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 24 Oct 2005 15:13:47 +0200
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -rc5-mm1] Char, watchdog: remove pci_find_dev
Message-Id: <20051024131346.3858F22BBD5@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Char, watchdog: remove pci_find_dev

Deprecated pci_find_dev removed from 2 drivers in drivers/char/watchdog/.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5dd0736eb0657d63a2c65696cebb326528c0ca6a
tree 98cc5a287773823b27052671978b5f38d92bb2f4
parent 66817e39a15654c83b8a6f52e225bbffe44bff31
author root <root@bellona.(none)> Mon, 24 Oct 2005 15:10:24 +0200
committer root <root@bellona.(none)> Mon, 24 Oct 2005 15:10:24 +0200

 drivers/char/watchdog/alim1535_wdt.c |   12 +++++++++---
 drivers/char/watchdog/alim7101_wdt.c |    9 +++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
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
 
@@ -392,6 +395,8 @@ static int __init watchdog_init(void)
 {
 	int ret;
 
+	ali_pci = NULL;
+
 	spin_lock_init(&ali_lock);
 
 	/* Check whether or not the hardware watchdog is there */
@@ -445,6 +450,7 @@ static void __exit watchdog_exit(void)
 	ali_stop();
 
 	/* Deregister */
+	pci_dev_put(ali_pci);
 	unregister_reboot_notifier(&ali_notifier);
 	misc_deregister(&ali_miscdev);
 }
diff --git a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c
+++ b/drivers/char/watchdog/alim7101_wdt.c
@@ -333,6 +333,8 @@ static void __exit alim7101_wdt_unload(v
 	/* Deregister */
 	misc_deregister(&wdt_miscdev);
 	unregister_reboot_notifier(&wdt_notifier);
+
+	pci_dev_put(alim7101_pmu);
 }
 
 static int __init alim7101_wdt_init(void)
@@ -342,7 +344,8 @@ static int __init alim7101_wdt_init(void
 	char tmp;
 
 	printk(KERN_INFO PFX "Steve Hill <steve@navaho.co.uk>.\n");
-	alim7101_pmu = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,NULL);
+	alim7101_pmu = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+		NULL);
 	if (!alim7101_pmu) {
 		printk(KERN_INFO PFX "ALi M7101 PMU not present - WDT not set\n");
 		return -EBUSY;
@@ -351,12 +354,14 @@ static int __init alim7101_wdt_init(void
 	/* Set the WDT in the PMU to 1 second */
 	pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, 0x02);
 
-	ali1543_south = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	ali1543_south = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+		NULL);
 	if (!ali1543_south) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge not present - WDT not set\n");
 		return -EBUSY;
 	}
 	pci_read_config_byte(ali1543_south, 0x5e, &tmp);
+	pci_dev_put(ali1543_south);
 	if ((tmp & 0x1e) == 0x00) {
 		if (!use_gpio) {
 			printk(KERN_INFO PFX "Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.\n");
