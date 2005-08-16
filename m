Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVHPAZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVHPAZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 20:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVHPAZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 20:25:17 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:9347 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965050AbVHPAZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 20:25:16 -0400
Date: Tue, 16 Aug 2005 02:24:57 +0200
Message-Id: <200508160024.j7G0OvmC002258@wscnet.wsc.cz>
Subject: [PATCH] removes pci_find_device from i6300esb.c
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-reply-to: <200508100009.j7A09Qi1003695@wscnet.wsc.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes pci_find_device to pci_get_device (encapsulated in
for_each_pci_dev) in i6300esb watchdog card with appropriate adding pci_dev_put.

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

This is repost, the patch was posted yet:
8 Aug 2005

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
