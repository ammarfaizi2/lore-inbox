Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVANUYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVANUYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVANUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:23:36 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7561 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262127AbVANUR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:17:27 -0500
Date: Fri, 14 Jan 2005 12:17:14 -0800
From: Dave Jiang <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       greg@kroah.com, linux@arm.linux.org.uk, smaurer@teja.com,
       dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
Subject: [PATCH 5/5] resource: ppc arch updates for u64 resource
Message-ID: <20050114201714.GC19681@plexity.net>
Reply-To: dave.jiang@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Corp.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC arch update for using u64 resources. 

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>


===== arch/ppc/kernel/pci.c 1.48 vs edited =====
--- 1.48/arch/ppc/kernel/pci.c	2004-10-20 01:37:05 -07:00
+++ edited/arch/ppc/kernel/pci.c	2005-01-13 11:10:42 -07:00
@@ -114,7 +114,7 @@
 		if (!res->flags)
 			continue;
 		if (res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
+			DBG("PCI:%s Resource %d [%08Lx-%08Lx] is unassigned\n",
 			    pci_name(dev), i, res->start, res->end);
 			res->end -= res->start;
 			res->start = 0;
@@ -173,17 +173,17 @@
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res, u64 size,
+		       u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", pci_name(dev),
+			       " (%Ld bytes)\n", pci_name(dev),
 			       dev->resource - res, size);
 		}
 
@@ -255,7 +255,7 @@
 				}
 			}
 
-			DBG("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
+			DBG("PCI: bridge rsrc %Lx..%Lx (%lx), parent %p\n",
 			    res->start, res->end, res->flags, pr);
 			if (pr) {
 				if (request_resource(pr, res) == 0)
@@ -306,7 +306,7 @@
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%lx..%lx] under %s\n",
+		DBG(KERN_INFO "PCI: reparented %s [%Lx..%Lx] under %s\n",
 		    p->name, p->start, p->end, res->name);
 	}
 	return 0;
@@ -362,12 +362,12 @@
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
+		DBG(KERN_ERR "PCI: huh? couldn't move to %Lx..%Lx\n",
 		    res->start, res->end);
 		return -1;		/* "can't happen" */
 	}
 	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %lx..%lx\n",
+	printk(KERN_INFO "PCI: bridge %d resource %d moved to %Lx..%Lx\n",
 	       bus->number, i, res->start, res->end);
 	return 0;
 }
@@ -479,14 +479,14 @@
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
+	DBG("PCI:%s: Resource %d: %016Lx-%016Lx (f=%lx)\n",
 	    pci_name(dev), idx, r->start, r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
 		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
 		       " of device %s\n", idx, pci_name(dev));
 		if (pr)
-			DBG("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
+			DBG("PCI:  parent is %p: %016Lx-%016Lx (f=%lx)\n",
 			    pr, pr->start, pr->end, pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
@@ -1061,7 +1061,7 @@
 	DBG("Remapping Bus %d, bridge: %s\n", bus->number, bridge->slot_name);
 	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	DBG("  IO window: %08lx-%08lx\n", res.start, res.end);
+	DBG("  IO window: %016Lx-%016Lx\n", res.start, res.end);
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -1209,8 +1209,8 @@
 					continue;
 				if ((r->flags & IORESOURCE_IO) == 0)
 					continue;
-				DBG("Trying to allocate from %08lx, size %08lx from parent"
-				    " res %d: %08lx -> %08lx\n",
+				DBG("Trying to allocate from %016Lx, size %016Lx from parent"
+				    " res %d: %016Lx -> %016Lx\n",
 					res->start, res->end, i, r->start, r->end);
 			
 				if (allocate_resource(r, res, res->end + 1, res->start, max,
