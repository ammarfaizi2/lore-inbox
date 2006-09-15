Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWIOXzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWIOXzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWIOXzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:55:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:5836 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932224AbWIOXzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:55:36 -0400
Date: Fri, 15 Sep 2006 18:55:34 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH 1/4]: PowerPC: EEH: balance pcidev_get/put calls
Message-ID: <20060915235534.GR29167@austin.ibm.com>
References: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915235025.GQ29167@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch corrects a pci_dev get/put imbalance that can occur 
only in highly unlikely situations (kmalloc failures, pci devices
with overlapping resource addresses).  No actual failures seen,
this was spotted during code review.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_cache.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2006-09-14 13:13:57.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_cache.c	2006-09-14 13:52:34.000000000 -0500
@@ -157,6 +157,7 @@ pci_addr_cache_insert(struct pci_dev *de
 	if (!piar)
 		return NULL;
 
+	pci_dev_get(dev);
 	piar->addr_lo = alo;
 	piar->addr_hi = ahi;
 	piar->pcidev = dev;
@@ -178,7 +179,6 @@ static void __pci_addr_cache_insert_devi
 	struct device_node *dn;
 	struct pci_dn *pdn;
 	int i;
-	int inserted = 0;
 
 	dn = pci_device_to_OF_node(dev);
 	if (!dn) {
@@ -197,9 +197,6 @@ static void __pci_addr_cache_insert_devi
 		return;
 	}
 
-	/* The cache holds a reference to the device... */
-	pci_dev_get(dev);
-
 	/* Walk resources on this device, poke them into the tree */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		unsigned long start = pci_resource_start(dev,i);
@@ -212,12 +209,7 @@ static void __pci_addr_cache_insert_devi
 		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
 			 continue;
 		pci_addr_cache_insert(dev, start, end, flags);
-		inserted = 1;
 	}
-
-	/* If there was nothing to add, the cache has no reference... */
-	if (!inserted)
-		pci_dev_put(dev);
 }
 
 /**
@@ -240,7 +232,6 @@ void pci_addr_cache_insert_device(struct
 static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
 {
 	struct rb_node *n;
-	int removed = 0;
 
 restart:
 	n = rb_first(&pci_io_addr_cache_root.rb_root);
@@ -250,16 +241,12 @@ restart:
 
 		if (piar->pcidev == dev) {
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
-			removed = 1;
+			pci_dev_put(piar->pcidev);
 			kfree(piar);
 			goto restart;
 		}
 		n = rb_next(n);
 	}
-
-	/* The cache no longer holds its reference to this device... */
-	if (removed)
-		pci_dev_put(dev);
 }
 
 /**
