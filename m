Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUGBSpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUGBSpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUGBSpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:45:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42732 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264781AbUGBSpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:45:42 -0400
Date: Fri, 2 Jul 2004 13:45:39 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 PPC64 EEH unbalanced dev_get/put calls
Message-ID: <20040702134539.W21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="73fGQZLCrFzENemP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--73fGQZLCrFzENemP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Paul,

Please review and forward upstream the following patch.

This patch fixes some unbalanaced usage of pci_dev_get()/pci_dev_put() calls
in the eeh code.  The old code had too many calls to dev_put, which could
cause memory structs to be freed prematurely, possibly leading to bad
bad pointer derefs in certain cases.

Cross-ref LTC bug 9283

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

--73fGQZLCrFzENemP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-unbalanced-dev-put-for-bkbits.patch"

===== arch/ppc64/kernel/eeh.c 1.20 vs edited =====
--- 1.20/arch/ppc64/kernel/eeh.c	Thu Jul  1 17:27:56 2004
+++ edited/arch/ppc64/kernel/eeh.c	Fri Jul  2 13:27:58 2004
@@ -207,7 +207,6 @@
 	if (!dn) {
 		printk(KERN_WARNING "PCI: no pci dn found for dev=%s %s\n",
 			pci_name(dev), pci_pretty_name(dev));
-		pci_dev_put(dev);
 		return;
 	}
 
@@ -218,9 +217,9 @@
 		printk(KERN_INFO "PCI: skip building address cache for=%s %s\n",
 		       pci_name(dev), pci_pretty_name(dev));
 #endif
-		pci_dev_put(dev);
 		return;
 	}
+	pci_dev_get(dev);
 
 	/* Walk resources on this device, poke them into the tree */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
@@ -310,7 +309,6 @@
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		/* Ignore PCI bridges ( XXX why ??) */
 		if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
-			pci_dev_put(dev);
 			continue;
 		}
 		pci_addr_cache_insert_device(dev);

--73fGQZLCrFzENemP--
