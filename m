Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSI1E3l>; Sat, 28 Sep 2002 00:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262709AbSI1E3l>; Sat, 28 Sep 2002 00:29:41 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:4575 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S262702AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPGART 4/5: HP ZX1 cleanups
Message-Id: <E17v9Je-0001mr-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial HP ZX1 cleanups, and remove a flush because ZX1 GART
is operated in coherent mode.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.688   -> 1.689  
#	drivers/char/agp/agpgart_be.c	1.38    -> 1.39   
#	drivers/char/drm-4.0/agpsupport.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	bjorn_helgaas@hp.com	1.689
# ZX1 cleanup.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Thu Sep 19 14:05:03 2002
+++ b/drivers/char/agp/agpgart_be.c	Thu Sep 19 14:05:03 2002
@@ -4087,11 +4087,6 @@
 	{0, 0, 0},		/* filled in by hp_zx1_fetch_size() */
 };
 
-static gatt_mask hp_zx1_masks[] =
-{
-	{HP_ZX1_PDIR_VALID_BIT, 0}
-};
-
 static struct _hp_private {
 	struct pci_dev *ioc;
 	volatile u8 *registers;
@@ -4157,7 +4152,7 @@
 	return 0;
 }
 
-static int __init hp_zx1_ioc_owner(u8 ioc_rev)
+static int __init hp_zx1_ioc_owner(void)
 {
 	struct _hp_private *hp = &hp_private;
 
@@ -4197,7 +4192,6 @@
 	struct _hp_private *hp = &hp_private;
 	struct pci_dev *ioc;
 	int i;
-	u8 ioc_rev;
 
 	ioc = pci_find_device(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_ZX1_IOC, NULL);
 	if (!ioc) {
@@ -4206,8 +4200,6 @@
 	}
 	hp->ioc = ioc;
 
-	pci_read_config_byte(ioc, PCI_REVISION_ID, &ioc_rev);
-
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (pci_resource_flags(ioc, i) == IORESOURCE_MEM) {
 			hp->registers = (u8 *) ioremap(pci_resource_start(ioc,
@@ -4229,7 +4221,7 @@
 	hp->io_pdir_owner = (INREG64(hp->registers, HP_ZX1_IBASE) & 0x1) == 0;
 
 	if (hp->io_pdir_owner)
-		return hp_zx1_ioc_owner(ioc_rev);
+		return hp_zx1_ioc_owner();
 
 	return hp_zx1_ioc_shared();
 }
@@ -4349,11 +4341,6 @@
 		j++;
 	}
 
-	if (mem->is_flushed == FALSE) {
-		CACHE_FLUSH();
-		mem->is_flushed = TRUE;
-	}
-
 	for (i = 0, j = io_pg_start; i < mem->page_count; i++) {
 		unsigned long paddr;
 
@@ -4393,14 +4380,8 @@
 	return HP_ZX1_PDIR_VALID_BIT | addr;
 }
 
-static unsigned long hp_zx1_unmask_memory(unsigned long addr)
-{
-	return addr & ~(HP_ZX1_PDIR_VALID_BIT);
-}
-
 static int __init hp_zx1_setup (struct pci_dev *pdev)
 {
-	agp_bridge.masks = hp_zx1_masks;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.needs_scratch_page = FALSE;
@@ -4409,7 +4390,6 @@
 	agp_bridge.cleanup = hp_zx1_cleanup;
 	agp_bridge.tlb_flush = hp_zx1_tlbflush;
 	agp_bridge.mask_memory = hp_zx1_mask_memory;
-	agp_bridge.unmask_memory = hp_zx1_unmask_memory;
 	agp_bridge.agp_enable = agp_generic_agp_enable;
 	agp_bridge.cache_flush = global_cache_flush;
 	agp_bridge.create_gatt_table = hp_zx1_create_gatt_table;
diff -Nru a/drivers/char/drm-4.0/agpsupport.c b/drivers/char/drm-4.0/agpsupport.c
--- a/drivers/char/drm-4.0/agpsupport.c	Thu Sep 19 14:05:03 2002
+++ b/drivers/char/drm-4.0/agpsupport.c	Thu Sep 19 14:05:03 2002
@@ -296,6 +296,8 @@
 		case SVWRKS_HE: 	head->chipset = "Serverworks HE"; break;
 		case SVWRKS_LE: 	head->chipset = "Serverworks LE"; break;
 
+		case HP_ZX1:		head->chipset = "HP ZX1";	 break;
+
 		default:		head->chipset = "Unknown";       break;
 		}
 #if LINUX_VERSION_CODE <= 0x020408
