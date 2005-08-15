Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVHOVai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVHOVai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVHOVai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:30:38 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:50556 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S964981AbVHOVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:30:38 -0400
Date: Mon, 15 Aug 2005 14:30:15 -0700 (PDT)
From: Naveen Gupta <ngupta@google.com>
To: wim@iguana.be, david@2gen.com, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] remove use of pci_find_device in watchdog driver for
 Intel 6300ESB chipset 
Message-ID: <Pine.LNX.4.56.0508151425320.27212@krishna.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch replaces obsolete 'pci_find_device' with 'pci_get_device' to
prevent the device from being stolen under us in Watchdog timer driver
for intel 6300ESB chipset.

Signed-off-by: Naveen Gupta <ngupta@google.com>

Index: linux-2.6.12/drivers/char/watchdog/i6300esb.c
===================================================================
--- linux-2.6.12.orig/drivers/char/watchdog/i6300esb.c	2005-08-15 11:28:07.000000000 -0700
+++ linux-2.6.12/drivers/char/watchdog/i6300esb.c	2005-08-15 11:36:54.000000000 -0700
@@ -362,23 +362,24 @@
 {
 	u8 val1;
 	unsigned short val2;
-
+	struct pci_device_id *ids = esb_pci_tbl;
         struct pci_dev *dev = NULL;
         /*
          *      Find the PCI device
          */
 
-        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-                if (pci_match_id(esb_pci_tbl, dev)) {
-                        esb_pci = dev;
-                        break;
-                }
-        }
+	while (ids->vendor && ids->device) {
+		if ((dev = pci_get_device(ids->vendor, ids->device, dev)) != NULL) {
+			esb_pci = dev;
+			break;
+		}
+		ids++;
+	}
 
         if (esb_pci) {
         	if (pci_enable_device(esb_pci)) {
 			printk (KERN_ERR PFX "failed to enable device\n");
-			goto out;
+			goto err_devput;
 		}
 
 		if (pci_request_region(esb_pci, 0, ESB_MODULE_NAME)) {
@@ -430,8 +431,9 @@
 		pci_release_region(esb_pci, 0);
 err_disable:
 		pci_disable_device(esb_pci);
+err_devput:
+		pci_dev_put(esb_pci);
 	}
-out:
 	return 0;
 }
 
@@ -481,7 +483,8 @@
 	pci_release_region(esb_pci, 0);
 /* err_disable: */
 	pci_disable_device(esb_pci);
-/* out: */
+/* err_devput: */
+	pci_dev_put(esb_pci);
         return ret;
 }
 
@@ -497,6 +500,7 @@
 	iounmap(BASEADDR);
 	pci_release_region(esb_pci, 0);
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 }
 
 module_init(watchdog_init);
