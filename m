Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUGILBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUGILBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGILBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:01:24 -0400
Received: from ozlabs.org ([203.10.76.45]:21720 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265668AbUGILBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:01:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16621.6735.922384.937093@cargo.ozlabs.ibm.com>
Date: Thu, 8 Jul 2004 19:56:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] (1/3) Fix unbalanced dev_get/put calls in PPC64 EEH code
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linas Vepstas <linas@austin.ibm.com>

This patch fixes some unbalanced usage of pci_dev_get()/pci_dev_put() calls
in the eeh code.  The old code had too many calls to dev_put, which could
cause memory structs to be freed prematurely, possibly leading to bad
bad pointer derefs in certain cases.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/eeh.c test25/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-07-06 08:43:03.000000000 +1000
+++ test25/arch/ppc64/kernel/eeh.c	2004-07-08 16:56:46.244591376 +1000
@@ -214,7 +214,6 @@
 	if (!dn) {
 		printk(KERN_WARNING "PCI: no pci dn found for dev=%s %s\n",
 			pci_name(dev), pci_pretty_name(dev));
-		pci_dev_put(dev);
 		return;
 	}
 
@@ -225,10 +224,12 @@
 		printk(KERN_INFO "PCI: skip building address cache for=%s %s\n",
 		       pci_name(dev), pci_pretty_name(dev));
 #endif
-		pci_dev_put(dev);
 		return;
 	}
 
+	/* The cache holds a reference to the device... */
+	pci_dev_get(dev);
+
 	/* Walk resources on this device, poke them into the tree */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		unsigned long start = pci_resource_start(dev,i);
@@ -278,6 +279,8 @@
 		}
 		n = rb_next(n);
 	}
+
+	/* The cache no longer holds its reference to this device... */
 	pci_dev_put(dev);
 }
 
@@ -317,7 +320,6 @@
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		/* Ignore PCI bridges ( XXX why ??) */
 		if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
-			pci_dev_put(dev);
 			continue;
 		}
 		pci_addr_cache_insert_device(dev);
