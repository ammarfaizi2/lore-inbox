Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277847AbRJRRom>; Thu, 18 Oct 2001 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277859AbRJRRod>; Thu, 18 Oct 2001 13:44:33 -0400
Received: from t2.redhat.com ([199.183.24.243]:49909 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S277847AbRJRRoT>;
	Thu, 18 Oct 2001 13:44:19 -0400
Date: Thu, 18 Oct 2001 10:44:43 -0700
From: Richard Henderson <rth@redhat.com>
To: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: alpha 2.4.13-pre3 pci64 patches
Message-ID: <20011018104443.A13392@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to ink for pointing out that pyxis _does_ have a monster window
enable bit, and Jay for pointing out that I thinko'd tsunami and titan
configury.  The final bit is a hunk that somehow got lost from one of
Dave's merges.


r~



diff -rup linux-dist/arch/alpha/kernel/core_cia.c 2.4.13-3/arch/alpha/kernel/core_cia.c
--- linux-dist/arch/alpha/kernel/core_cia.c	Thu Oct 18 10:39:46 2001
+++ 2.4.13-3/arch/alpha/kernel/core_cia.c	Wed Oct 17 16:14:59 2001
@@ -637,10 +637,11 @@ do_init_arch(int is_pyxis)
 	*(vip)CIA_IOC_HAE_IO = 0;
 
 	/* For PYXIS, we always use BWX bus and i/o accesses.  To that end,
-	   make sure they're enabled on the controller.  */
+	   make sure they're enabled on the controller.  At the same time,
+	   enable the monster window.  */
 	if (is_pyxis) {
 		temp = *(vip)CIA_IOC_CIA_CNFG;
-		temp |= CIA_CNFG_IOA_BWEN;
+		temp |= CIA_CNFG_IOA_BWEN | CIA_CNFG_PCI_MWEN;
 		*(vip)CIA_IOC_CIA_CNFG = temp;
 	}
 
diff -rup linux-dist/arch/alpha/kernel/core_titan.c 2.4.13-3/arch/alpha/kernel/core_titan.c
--- linux-dist/arch/alpha/kernel/core_titan.c	Thu Oct 18 10:39:46 2001
+++ 2.4.13-3/arch/alpha/kernel/core_titan.c	Thu Oct 18 10:08:21 2001
@@ -368,7 +368,7 @@ titan_init_one_pachip_port(titan_pachip_
 
 	port->wsba[2].csr = 0x80000000 | 1;
 	port->wsm[2].csr  = (0x80000000 - 1) & 0xfff00000;
-	port->tba[2].csr  = 0x80000000;
+	port->tba[2].csr  = 0;
 
 	port->wsba[3].csr = 0;
 
diff -rup linux-dist/arch/alpha/kernel/core_tsunami.c 2.4.13-3/arch/alpha/kernel/core_tsunami.c
--- linux-dist/arch/alpha/kernel/core_tsunami.c	Thu Oct 18 10:39:46 2001
+++ 2.4.13-3/arch/alpha/kernel/core_tsunami.c	Thu Oct 18 10:08:40 2001
@@ -368,7 +368,7 @@ tsunami_init_one_pchip(tsunami_pchip *pc
 
 	pchip->wsba[2].csr = 0x80000000 | 1;
 	pchip->wsm[2].csr  = (0x80000000 - 1) & 0xfff00000;
-	pchip->tba[2].csr  = 0x80000000;
+	pchip->tba[2].csr  = 0;
 
 	pchip->wsba[3].csr = 0;
 
diff -rup linux-dist/arch/alpha/kernel/pci.c 2.4.13-3/arch/alpha/kernel/pci.c
--- linux-dist/arch/alpha/kernel/pci.c	Thu Sep 13 15:21:32 2001
+++ 2.4.13-3/arch/alpha/kernel/pci.c	Wed Oct 17 16:44:25 2001
@@ -79,35 +79,30 @@ quirk_ali_ide_ports(struct pci_dev *dev)
 static void __init
 quirk_cypress(struct pci_dev *dev)
 {
-/*
- * Notorious Cy82C693 chip. One of its numerous bugs: although
- * Cypress IDE controller doesn't support native mode, it has
- * programmable addresses of IDE command/control registers.
- * This violates PCI specifications, confuses IDE subsystem
- * and causes resource conflict between primary HD_CMD register
- * and floppy controller. Ugh.
- * Fix that.
- */
+	/* The Notorious Cy82C693 chip.  */
+
+	/* The Cypress IDE controller doesn't support native mode, but it
+	   has programmable addresses of IDE command/control registers.
+	   This violates PCI specifications, confuses the IDE subsystem and
+	   causes resource conflicts between the primary HD_CMD register and
+	   the floppy controller.  Ugh.  Fix that.  */
 	if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE) {
 		dev->resource[0].flags = 0;
 		dev->resource[1].flags = 0;
-		return;
 	}
-/*
- * Another "feature": Cypress bridge responds on the PCI bus
- * in the address range 0xffff0000-0xffffffff (conventional
- * x86 BIOS ROM). No way to turn this off, so if we use
- * large SG window, we must avoid these addresses.
- */
-	if (dev->class >> 8 == PCI_CLASS_BRIDGE_ISA) {
-		struct pci_controller *hose = dev->sysdata;
-		long overlap;
 
-		if (hose->sg_pci) {
-			overlap = hose->sg_pci->dma_base + hose->sg_pci->size;
-			overlap -= 0xffff0000;
-			if (overlap > 0)
-				hose->sg_pci->size -= overlap;
+	/* The Cypress bridge responds on the PCI bus in the address range
+	   0xffff0000-0xffffffff (conventional x86 BIOS ROM).  There is no
+	   way to turn this off, so if we use a large direct-map window, or
+	   a large SG window, we must avoid this region.  */
+	else if (dev->class >> 8 == PCI_CLASS_BRIDGE_ISA) {
+		if (__direct_map_base + __direct_map_size >= 0xffff0000)
+			__direct_map_size = 0xffff0000 - __direct_map_base;
+		else {
+			struct pci_controller *hose = dev->sysdata;
+			struct pci_iommu_arena *pci = hose->sg_pci;
+			if (pci && pci->dma_base + pci->size >= 0xffff0000)
+				pci->size = 0xffff0000 - pci->dma_base;
 		}
 	}
 }
