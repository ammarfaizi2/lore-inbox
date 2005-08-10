Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVHJAJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVHJAJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVHJAJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:09:28 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16775 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750980AbVHJAJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:09:27 -0400
Date: Wed, 10 Aug 2005 02:09:26 +0200
Message-Id: <200508100009.j7A09Qi1003695@wscnet.wsc.cz>
Subject: [PATCH -mm 1/2] removes pci_find_device from i6300esb.c
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-reply-to: <20050809233744.GA24343@kroah.com>
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
