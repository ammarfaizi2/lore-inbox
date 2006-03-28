Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWC1W1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWC1W1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWC1W1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:27:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20152 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932461AbWC1W1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:27:22 -0500
Date: Tue, 28 Mar 2006 17:27:03 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Morton Andrew Morton <akpm@osdl.org>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] 64 bit resources arch powerpc changes
Message-ID: <20060328222703.GD20335@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o powerpc cross-compilation with CONFIG_PPC=32 resulted in more warnings
  for 64bit resources. This patch fixes it.

o Contains changes for arch/powerpc/* dir.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/powerpc/kernel/pci_32.c          |   15 ++++++++-------
 arch/powerpc/platforms/83xx/pci.c     |    5 +++--
 arch/powerpc/platforms/85xx/pci.c     |    5 +++--
 arch/powerpc/platforms/chrp/pci.c     |    4 ++--
 arch/powerpc/platforms/maple/pci.c    |    5 +++--
 arch/powerpc/platforms/powermac/pci.c |    5 +++--
 6 files changed, 22 insertions(+), 17 deletions(-)

diff -puN arch/powerpc/kernel/pci_32.c~64bit-resources-arch-powerpc-changes arch/powerpc/kernel/pci_32.c
--- linux-2.6.16-mm2-64bit-res/arch/powerpc/kernel/pci_32.c~64bit-resources-arch-powerpc-changes	2006-03-28 16:08:18.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/arch/powerpc/kernel/pci_32.c	2006-03-28 16:09:29.000000000 -0500
@@ -173,8 +173,8 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res, u64 size,
+				u64 align)
 {
 	struct pci_dev *dev = data;
 
@@ -183,7 +183,7 @@ void pcibios_align_resource(void *data, 
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", pci_name(dev),
+			       " (%lld bytes)\n", pci_name(dev),
 			       dev->resource - res, size);
 		}
 
@@ -367,8 +367,9 @@ pci_relocate_bridge_resource(struct pci_
 		return -1;		/* "can't happen" */
 	}
 	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %lx..%lx\n",
-	       bus->number, i, res->start, res->end);
+	printk(KERN_INFO "PCI: bridge %d resource %d moved to %llx..%llx\n",
+	       bus->number, i, (unsigned long long)res->start,
+	       (unsigned long long)res->end);
 	return 0;
 }
 
@@ -1573,8 +1574,8 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
-	       prot);
+	printk("PCI map for %s:%llx, prot: %lx\n", pci_name(dev),
+		(unsigned long long)rp->start, prot);
 
 	return __pgprot(prot);
 }
diff -puN arch/powerpc/platforms/83xx/pci.c~64bit-resources-arch-powerpc-changes arch/powerpc/platforms/83xx/pci.c
--- linux-2.6.16-mm2-64bit-res/arch/powerpc/platforms/83xx/pci.c~64bit-resources-arch-powerpc-changes	2006-03-28 16:08:24.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/arch/powerpc/platforms/83xx/pci.c	2006-03-28 16:09:29.000000000 -0500
@@ -91,9 +91,10 @@ int __init add_bridge(struct device_node
 		mpc83xx_pci2_busno = hose->first_busno;
 	}
 
-	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%08lx. "
+	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-	       rsrc.start, hose->first_busno, hose->last_busno);
+	       (unsigned long long)rsrc.start, hose->first_busno,
+	       hose->last_busno);
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 	    hose, hose->cfg_addr, hose->cfg_data);
diff -puN arch/powerpc/platforms/85xx/pci.c~64bit-resources-arch-powerpc-changes arch/powerpc/platforms/85xx/pci.c
--- linux-2.6.16-mm2-64bit-res/arch/powerpc/platforms/85xx/pci.c~64bit-resources-arch-powerpc-changes	2006-03-28 16:08:34.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/arch/powerpc/platforms/85xx/pci.c	2006-03-28 16:09:29.000000000 -0500
@@ -79,9 +79,10 @@ int __init add_bridge(struct device_node
 		mpc85xx_pci2_busno = hose->first_busno;
 	}
 
-	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%08lx. "
+	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-		rsrc.start, hose->first_busno, hose->last_busno);
+		(unsigned long long)rsrc.start, hose->first_busno,
+		hose->last_busno);
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
diff -puN arch/powerpc/platforms/chrp/pci.c~64bit-resources-arch-powerpc-changes arch/powerpc/platforms/chrp/pci.c
--- linux-2.6.16-mm2-64bit-res/arch/powerpc/platforms/chrp/pci.c~64bit-resources-arch-powerpc-changes	2006-03-28 16:08:42.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/arch/powerpc/platforms/chrp/pci.c	2006-03-28 16:09:29.000000000 -0500
@@ -141,7 +141,7 @@ hydra_init(void)
 	if (np == NULL || of_address_to_resource(np, 0, &r))
 		return 0;
 	Hydra = ioremap(r.start, r.end-r.start);
-	printk("Hydra Mac I/O at %lx\n", r.start);
+	printk("Hydra Mac I/O at %llx\n", (unsigned long long)r.start);
 	printk("Hydra Feature_Control was %x",
 	       in_le32(&Hydra->Feature_Control));
 	out_le32(&Hydra->Feature_Control, (HYDRA_FC_SCC_CELL_EN |
@@ -265,7 +265,7 @@ chrp_find_bridges(void)
 			       bus_range[0], bus_range[1]);
 		printk(" controlled by %s", dev->type);
 		if (!is_longtrail)
-			printk(" at %lx", r.start);
+			printk(" at %llx", (unsigned long long)r.start);
 		printk("\n");
 
 		hose = pcibios_alloc_controller();
diff -puN arch/powerpc/platforms/maple/pci.c~64bit-resources-arch-powerpc-changes arch/powerpc/platforms/maple/pci.c
--- linux-2.6.16-mm2-64bit-res/arch/powerpc/platforms/maple/pci.c~64bit-resources-arch-powerpc-changes	2006-03-28 16:08:49.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/arch/powerpc/platforms/maple/pci.c	2006-03-28 16:09:29.000000000 -0500
@@ -376,9 +376,10 @@ static void __init maple_fixup_phb_resou
 		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
 		hose->io_resource.start += offset;
 		hose->io_resource.end += offset;
-		printk(KERN_INFO "PCI Host %d, io start: %lx; io end: %lx\n",
+		printk(KERN_INFO "PCI Host %d, io start: %llx; io end: %llx\n",
 		       hose->global_number,
-		       hose->io_resource.start, hose->io_resource.end);
+		       (unsigned long long)hose->io_resource.start,
+		       (unsigned long long)hose->io_resource.end);
 	}
 }
 
diff -puN arch/powerpc/platforms/powermac/pci.c~64bit-resources-arch-powerpc-changes arch/powerpc/platforms/powermac/pci.c
--- linux-2.6.16-mm2-64bit-res/arch/powerpc/platforms/powermac/pci.c~64bit-resources-arch-powerpc-changes	2006-03-28 16:08:56.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/arch/powerpc/platforms/powermac/pci.c	2006-03-28 16:09:29.000000000 -0500
@@ -939,9 +939,10 @@ static int __init add_bridge(struct devi
 		disp_name = "Chaos";
 		primary = 0;
 	}
-	printk(KERN_INFO "Found %s PCI host bridge at 0x%08lx. "
+	printk(KERN_INFO "Found %s PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-		disp_name, rsrc.start, hose->first_busno, hose->last_busno);
+		disp_name, (unsigned long long)rsrc.start, hose->first_busno,
+		hose->last_busno);
 #endif /* CONFIG_PPC32 */
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
_
