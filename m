Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbULWSQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbULWSQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 13:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULWSQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 13:16:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33718 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261213AbULWSPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 13:15:35 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] fix ROM enable/disable in r128 and radeon fb drivers
Date: Thu, 23 Dec 2004 10:15:27 -0800
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200412141256.21143.jbarnes@engr.sgi.com> <9e4733910412141345380559da@mail.gmail.com> <200412141420.12863.jbarnes@engr.sgi.com>
In-Reply-To: <200412141420.12863.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AtwyBsLVL2A58Oi"
Message-Id: <200412231015.28033.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_AtwyBsLVL2A58Oi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, December 14, 2004 2:20 pm, Jesse Barnes wrote:
> On Tuesday, December 14, 2004 1:45 pm, Jon Smirl wrote:
> > These drivers should be using the new ROM API in the PCI driver
> > instead of manipulating the ROMs directly. Now that the ROM API is in
> > the kernel all direct use of PCI_ENABLE_ROM should be removed. There
> > are about thirty places in the kernel doing direct access. Kernel
> > janitors would probably be a good place to track removing
> > PCI_ENABLE_ROM.
>
> Sure... but in the meantime the drivers should probably be trivially fixed
> like this so things don't break.

Oops, didn't realize that changing them to use pci_rom_enable/disable would be 
just as trivial as my fix.  Tested on sn2.

This patch fixes a few errors in the aty fb drivers by making them use 
pci_rom_enable/disable instead of manipulating BARs directly.  They were both 
a) incorrectly programming resource values into the BARs instead of actual 
BAR values (resources are cookies and shouldn't be used that way), and b) 
they were both clobbering the original value of the BAR corresponding to 
their ROM, also a no-no.  Switching to pci_rom_enable/disable fixes both at 
once and kills some code.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_AtwyBsLVL2A58Oi
Content-Type: text/plain;
  charset="iso-8859-1";
  name="aty-rom-enable-fixes-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aty-rom-enable-fixes-2.patch"

===== drivers/video/aty/aty128fb.c 1.53 vs edited =====
--- 1.53/drivers/video/aty/aty128fb.c	2004-12-17 00:09:09 -08:00
+++ edited/drivers/video/aty/aty128fb.c	2004-12-23 10:02:59 -08:00
@@ -452,7 +452,6 @@
 static void __init aty128_get_pllinfo(struct aty128fb_par *par,
 				      void __iomem *bios);
 static void __init __iomem *aty128_map_ROM(struct pci_dev *pdev, const struct aty128fb_par *par);
-static void __init aty128_unmap_ROM(struct pci_dev *dev, void __iomem * rom);
 #endif
 static void aty128_timings(struct aty128fb_par *par);
 static void aty128_init_engine(struct aty128fb_par *par);
@@ -788,30 +787,12 @@
 
 
 #ifndef __sparc__
-static void __init aty128_unmap_ROM(struct pci_dev *dev, void __iomem * rom)
-{
-	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
-	
-	iounmap(rom);
-	
-	/* Release the ROM resource if we used it in the first place */
-	if (r->parent && r->flags & PCI_ROM_ADDRESS_ENABLE) {
-		release_resource(r);
-		r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
-		r->end -= r->start;
-		r->start = 0;
-	}
-	/* This will disable and set address to unassigned */
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
-}
-
-
 static void __iomem * __init aty128_map_ROM(const struct aty128fb_par *par, struct pci_dev *dev)
 {
-	struct resource *r;
 	u16 dptr;
 	u8 rom_type;
 	void __iomem *bios;
+	size_t rom_size;
 
     	/* Fix from ATI for problem with Rage128 hardware not leaving ROM enabled */
     	unsigned int temp;
@@ -821,26 +802,13 @@
 	aty_st_le32(RAGE128_MPP_TB_CONFIG, temp);
 	temp = aty_ld_le32(RAGE128_MPP_TB_CONFIG);
 
-	/* no need to search for the ROM, just ask the card where it is. */
-	r = &dev->resource[PCI_ROM_RESOURCE];
+	bios = pci_map_rom(dev, &rom_size);
 
-	/* assign the ROM an address if it doesn't have one */
-	if (r->parent == NULL)
-		pci_assign_resource(dev, PCI_ROM_RESOURCE);
-	
-	/* enable if needed */
-	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
-		pci_write_config_dword(dev, dev->rom_base_reg,
-				       r->start | PCI_ROM_ADDRESS_ENABLE);
-		r->flags |= PCI_ROM_ADDRESS_ENABLE;
-	}
-	
-	bios = ioremap(r->start, r->end - r->start + 1);
 	if (!bios) {
 		printk(KERN_ERR "aty128fb: ROM failed to map\n");
 		return NULL;
 	}
-	
+
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
 		printk(KERN_ERR "aty128fb: Invalid ROM signature %x should be 0xaa55\n",
@@ -899,7 +867,7 @@
 	return bios;
 
  failed:
-	aty128_unmap_ROM(dev, bios);
+	pci_unmap_rom(dev, bios);
 	return NULL;
 }
 
@@ -1959,7 +1927,7 @@
 	else {
 		printk(KERN_INFO "aty128fb: Rage128 BIOS located\n");
 		aty128_get_pllinfo(par, bios);
-		aty128_unmap_ROM(pdev, bios);
+		pci_unmap_rom(pdev, bios);
 	}
 #endif /* __sparc__ */
 
===== drivers/video/aty/radeon_base.c 1.35 vs edited =====
--- 1.35/drivers/video/aty/radeon_base.c	2004-11-11 00:39:04 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2004-12-23 10:03:04 -08:00
@@ -263,30 +263,17 @@
 
 static void __devexit radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 {
-	// leave it disabled and unassigned
-	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
-	
 	if (!rinfo->bios_seg)
 		return;
-	iounmap(rinfo->bios_seg);
-	
-	/* Release the ROM resource if we used it in the first place */
-	if (r->parent && r->flags & PCI_ROM_ADDRESS_ENABLE) {
-		release_resource(r);
-		r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
-		r->end -= r->start;
-		r->start = 0;
-	}
-	/* This will disable and set address to unassigned */
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+	pci_unmap_rom(dev, rinfo->bios_seg);
 }
 
 static int __devinit radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 {
 	void __iomem *rom;
-	struct resource *r;
 	u16 dptr;
 	u8 rom_type;
+	size_t rom_size;
 
 	/* If this is a primary card, there is a shadow copy of the
 	 * ROM somewhere in the first meg. We will just ignore the copy
@@ -301,21 +288,7 @@
 	OUTREG(MPP_TB_CONFIG, temp);
 	temp = INREG(MPP_TB_CONFIG);
                                                                                                           
-	/* no need to search for the ROM, just ask the card where it is. */
-	r = &dev->resource[PCI_ROM_RESOURCE];
-	
-	/* assign the ROM an address if it doesn't have one */
-	if (r->parent == NULL)
-		pci_assign_resource(dev, PCI_ROM_RESOURCE);
-	
-	/* enable if needed */
-	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
-		pci_write_config_dword(dev, dev->rom_base_reg,
-				       r->start | PCI_ROM_ADDRESS_ENABLE);
-		r->flags |= PCI_ROM_ADDRESS_ENABLE;
-	}
-	
-	rom = ioremap(r->start, r->end - r->start + 1);
+	rom = pci_map_rom(dev, &rom_size);
 	if (!rom) {
 		printk(KERN_ERR "radeonfb: ROM failed to map\n");
 		return -ENOMEM;

--Boundary-00=_AtwyBsLVL2A58Oi--
