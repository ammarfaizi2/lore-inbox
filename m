Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUHRDnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUHRDnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 23:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUHRDnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 23:43:19 -0400
Received: from ozlabs.org ([203.10.76.45]:14283 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267234AbUHRDnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 23:43:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16674.53330.174867.75311@cargo.ozlabs.ibm.com>
Date: Wed, 18 Aug 2004 13:43:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix unbalanced pci_dev_put in EEH code
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EEH code currently can end up doing an extra pci_dev_put() in the
case where we hot-unplug a card for which we are ignoring EEH errors
(e.g. a graphics card).  This patch fixes that problem by only
maintaining a reference to the PCI device if we have entered any of
its resource addresses into our address -> PCI device cache.  This
patch is based on an earlier patch by Linas Vepstas.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/eeh.c g5-ppc64/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-08-08 12:05:16.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/eeh.c	2004-08-17 20:15:20.345809872 +1000
@@ -209,6 +209,7 @@
 {
 	struct device_node *dn;
 	int i;
+	int inserted = 0;
 
 	dn = pci_device_to_OF_node(dev);
 	if (!dn) {
@@ -242,7 +243,12 @@
 		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
 			 continue;
 		pci_addr_cache_insert(dev, start, end, flags);
+		inserted = 1;
 	}
+
+	/* If there was nothing to add, the cache has no reference... */
+	if (!inserted)
+		pci_dev_put(dev);
 }
 
 /**
@@ -265,6 +271,7 @@
 static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
 {
 	struct rb_node *n;
+	int removed = 0;
 
 restart:
 	n = rb_first(&pci_io_addr_cache_root.rb_root);
@@ -274,6 +281,7 @@
 
 		if (piar->pcidev == dev) {
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
+			removed = 1;
 			kfree(piar);
 			goto restart;
 		}
@@ -281,7 +289,8 @@
 	}
 
 	/* The cache no longer holds its reference to this device... */
-	pci_dev_put(dev);
+	if (removed)
+		pci_dev_put(dev);
 }
 
 /**
