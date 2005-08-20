Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVHTPns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVHTPns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVHTPns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 11:43:48 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:13252 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932342AbVHTPns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 11:43:48 -0400
Date: Sat, 20 Aug 2005 17:43:38 +0200
Message-Id: <200508201543.j7KFhbni018183@tirith.ics.muni.cz>
In-reply-to: <20050819043331.7bc1f9a9.akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm1 [i6300escb.c 2 bugs, little cleanup]
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Muni-Spam-TestIP: 147.251.53.71
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In i6300esb.c watchdog card driver were 2 bugs (misused pc_match_device
and pci_dev_put wasn't called in one error case) and one little cleanup
was done (long line was converted to a shorter one with using built-in
macro).

Generated in 2.6.13-rc6-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

i6300esb.c |    9 +++++----
1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
--- a/drivers/char/watchdog/i6300esb.c
+++ b/drivers/char/watchdog/i6300esb.c
@@ -349,7 +349,7 @@ static struct notifier_block esb_notifie
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id esb_pci_tbl[] = {
-        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_9, PCI_ANY_ID, PCI_ANY_ID, },
+        { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_9), },
         { 0, },                 /* End of list */
 };
 MODULE_DEVICE_TABLE (pci, esb_pci_tbl);
@@ -369,7 +369,7 @@ static unsigned char __init esb_getdevic
          */
 
         for_each_pci_dev(dev)
-                if (pci_match_device(esb_pci_tbl, dev)) {
+                if (pci_match_id(esb_pci_tbl, dev)) {
                         esb_pci = dev;
                         break;
                 }
@@ -377,7 +377,7 @@ static unsigned char __init esb_getdevic
         if (esb_pci) {
         	if (pci_enable_device(esb_pci)) {
 			printk (KERN_ERR PFX "failed to enable device\n");
-			goto out;
+			goto err_devput;
 		}
 
 		if (pci_request_region(esb_pci, 0, ESB_MODULE_NAME)) {
@@ -429,9 +429,10 @@ err_release:
 		pci_release_region(esb_pci, 0);
 err_disable:
 		pci_disable_device(esb_pci);
+err_devput:
 		pci_dev_put(esb_pci);
 	}
-out:
+
 	return 0;
 }
 
