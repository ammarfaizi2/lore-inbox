Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVHHXz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVHHXz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVHHXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:55:29 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:49545 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932369AbVHHXz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:55:28 -0400
Date: Tue, 9 Aug 2005 01:55:16 +0200
Message-Id: <200508082355.j78NtGNS029681@wscnet.wsc.cz>
Subject: [PATCH -mm] removes pci_find_device from i6300esb.c
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: <42F73523.80205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes pci_find_device to pci_get_device (encapsulated in
for_each_pci_dev) in i6300esb watchdog card with appropriate adding pci_dev_put.

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
--- a/drivers/char/watchdog/i6300esb.c
+++ b/drivers/char/watchdog/i6300esb.c
@@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
          *      Find the PCI device
          */
 
-        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+        for_each_pci_dev(dev)
                 if (pci_match_id(esb_pci_tbl, dev)) {
                         esb_pci = dev;
                         break;
                 }
-        }
 
         if (esb_pci) {
         	if (pci_enable_device(esb_pci)) {
@@ -430,6 +429,7 @@ err_release:
 		pci_release_region(esb_pci, 0);
 err_disable:
 		pci_disable_device(esb_pci);
+		pci_dev_put(esb_pci);
 	}
 out:
 	return 0;
@@ -481,6 +481,7 @@ err_unmap:
 	pci_release_region(esb_pci, 0);
 /* err_disable: */
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 /* out: */
         return ret;
 }
@@ -497,6 +498,7 @@ static void __exit watchdog_cleanup (voi
 	iounmap(BASEADDR);
 	pci_release_region(esb_pci, 0);
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 }
 
 module_init(watchdog_init);
