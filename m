Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUHRV1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUHRV1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267800AbUHRV1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:27:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26854 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267760AbUHRVZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:25:53 -0400
Date: Wed, 18 Aug 2004 12:25:01 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Fix unbalanced pci_dev_put in EEH code
Message-ID: <20040818172501.GF14002@austin.ibm.com>
References: <16674.53330.174867.75311@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16674.53330.174867.75311@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Hang on there, you didn't just rename the variable, you also missed a
teeny chunk of the original patch.  The corrected path is attached below.
(Well, I rather liked my original var names better, but whatever).

--linas

Signed-off-by: Linas Vepstas <linas@linas.org>

On Wed, Aug 18, 2004 at 01:43:14PM +1000, Paul Mackerras was heard to remark:
> The EEH code currently can end up doing an extra pci_dev_put() in the
> case where we hot-unplug a card for which we are ignoring EEH errors
> (e.g. a graphics card).  This patch fixes that problem by only
> maintaining a reference to the PCI device if we have entered any of
> its resource addresses into our address -> PCI device cache.  This
> patch is based on an earlier patch by Linas Vepstas.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> 


===== arch/ppc64/kernel/eeh.c 1.28 vs edited =====
--- 1.28/arch/ppc64/kernel/eeh.c	Mon Jul 12 18:29:16 2004
+++ edited/arch/ppc64/kernel/eeh.c	Wed Jul 14 15:40:47 2004
@@ -208,6 +208,7 @@
 static void __pci_addr_cache_insert_device(struct pci_dev *dev)
 {
 	struct device_node *dn;
+	int inserted = 0;
 	int i;
 
 	dn = pci_device_to_OF_node(dev);
@@ -226,9 +227,6 @@
 #endif
 		return;
 	}
-
-	/* The cache holds a reference to the device... */
-	pci_dev_get(dev);
 
 	/* Walk resources on this device, poke them into the tree */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
@@ -242,6 +242,12 @@
 		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
 			 continue;
 		pci_addr_cache_insert(dev, start, end, flags);
+		inserted = 1;
+	}
+
+	/* The cache holds a reference to the device... */
+	if (inserted) {
+		pci_dev_get (dev);
 	}
 }
 
@@ -265,6 +270,7 @@
 static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
 {
 	struct rb_node *n;
+	int removed = 0;
 
 restart:
 	n = rb_first(&pci_io_addr_cache_root.rb_root);
@@ -275,13 +281,16 @@
 		if (piar->pcidev == dev) {
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
 			kfree(piar);
+			removed = 1;
 			goto restart;
 		}
 		n = rb_next(n);
 	}
 
 	/* The cache no longer holds its reference to this device... */
-	pci_dev_put(dev);
+	if (removed) {
+	   pci_dev_put(dev);
+	}
 }
 
 /**
