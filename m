Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVHHKeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVHHKeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVHHKeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:34:16 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:13701 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750813AbVHHKeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:34:16 -0400
Message-ID: <42F73523.80205@gmail.com>
Date: Mon, 08 Aug 2005 12:34:11 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: david@2gen.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] i6300esb.c uses pci_find_device
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes pci_find_device to pci_get_device (encapsulated in for_each_pci_dev)
with appropriate adding pci_dev_put.

Generated in 2.6.13-rc5-mm1

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


