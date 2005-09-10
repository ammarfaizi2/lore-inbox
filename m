Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVIJMWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVIJMWD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVIJMVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:42 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:40071 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750787AbVIJMVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:17 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL97x017258@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 8/10] drivers/char: pci_find_device remove (drivers/char/watchdog/alim1535_wdt.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 alim1535_wdt.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

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
