Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263148AbVCKDFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbVCKDFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbVCKDFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:05:14 -0500
Received: from ozlabs.org ([203.10.76.45]:7910 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262393AbVCKDCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:02:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.2617.625095.404994@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 14:02:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, davej@redhat.com
Cc: benh@kernel.crashing.org, Jerome Glisse <j.glisse@gmail.com>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] AGP support for powermac G5
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AGP support for the U3 northbridge used in Apple G5
machines to drivers/char/agp/uninorth-agp.c.  This patch is based on
earlier work by Jerome Glisse.  With this patch, the driver works in
both ppc32 and ppc64 kernels.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/char/agp/Kconfig g5/drivers/char/agp/Kconfig
--- linux-2.5/drivers/char/agp/Kconfig	2005-03-07 14:01:44.000000000 +1100
+++ g5/drivers/char/agp/Kconfig	2005-03-11 13:53:47.000000000 +1100
@@ -1,6 +1,6 @@
 config AGP
 	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
-	depends on ALPHA || IA64 || PPC32 || X86
+	depends on ALPHA || IA64 || PPC || X86
 	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
@@ -146,11 +146,11 @@
 	default AGP
 
 config AGP_UNINORTH
-	tristate "Apple UniNorth AGP support"
+	tristate "Apple UniNorth & U3 AGP support"
 	depends on AGP && PPC_PMAC
 	help
 	  This option gives you AGP support for Apple machines with a
-	  UniNorth bridge.
+	  UniNorth or U3 (Apple G5) bridge.
 
 config AGP_EFFICEON
 	tristate "Transmeta Efficeon support"
diff -urN linux-2.5/drivers/char/agp/uninorth-agp.c g5/drivers/char/agp/uninorth-agp.c
--- linux-2.5/drivers/char/agp/uninorth-agp.c	2005-03-11 11:47:37.000000000 +1100
+++ g5/drivers/char/agp/uninorth-agp.c	2005-03-11 11:54:54.000000000 +1100
@@ -9,8 +9,23 @@
 #include <linux/delay.h>
 #include <asm/uninorth.h>
 #include <asm/pci-bridge.h>
+#include <asm/prom.h>
 #include "agp.h"
 
+/*
+ * NOTES for uninorth3 (G5 AGP) supports :
+ *
+ * There maybe also possibility to have bigger cache line size for
+ * agp (see pmac_pci.c and look for cache line). Need to be investigated
+ * by someone.
+ *
+ * PAGE size are hardcoded but this may change, see asm/page.h.
+ *
+ * Jerome Glisse <j.glisse@gmail.com>
+ */
+static int uninorth_rev;
+static int is_u3;
+
 static int uninorth_fetch_size(void)
 {
 	int i;
@@ -40,14 +55,20 @@
 
 static void uninorth_tlbflush(struct agp_memory *mem)
 {
+	u32 ctrl = UNI_N_CFG_GART_ENABLE;
+
+	if (is_u3)
+		ctrl |= U3_N_CFG_GART_PERFRD;
 	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			UNI_N_CFG_GART_ENABLE | UNI_N_CFG_GART_INVAL);
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			UNI_N_CFG_GART_ENABLE);
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			UNI_N_CFG_GART_ENABLE | UNI_N_CFG_GART_2xRESET);
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			UNI_N_CFG_GART_ENABLE);
+			       ctrl | UNI_N_CFG_GART_INVAL);
+	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, ctrl);
+
+	if (uninorth_rev <= 0x30) {
+		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
+				       ctrl | UNI_N_CFG_GART_2xRESET);
+		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
+				       ctrl);
+	}
 }
 
 static void uninorth_cleanup(void)
@@ -57,14 +78,16 @@
 	pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, &tmp);
 	if (!(tmp & UNI_N_CFG_GART_ENABLE))
 		return;
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			UNI_N_CFG_GART_ENABLE | UNI_N_CFG_GART_INVAL);
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			0);
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			UNI_N_CFG_GART_2xRESET);
-	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-			0);
+	tmp |= UNI_N_CFG_GART_INVAL;
+	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, tmp);
+	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, 0);
+
+	if (uninorth_rev <= 0x30) {
+		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
+				       UNI_N_CFG_GART_2xRESET);
+		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
+				       0);
+	}
 }
 
 static int uninorth_configure(void)
@@ -87,8 +110,21 @@
 	 * the AGP aperture isn't mapped at bus physical address 0
 	 */
 	agp_bridge->gart_bus_addr = 0;
+#ifdef CONFIG_PPC64
+	/* Assume U3 or later on PPC64 systems */
+	/* high 4 bits of GART physical address go in UNI_N_CFG_AGP_BASE */
+	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_AGP_BASE,
+			       (agp_bridge->gatt_bus_addr >> 32) & 0xf);
+#else
 	pci_write_config_dword(agp_bridge->dev,
 		UNI_N_CFG_AGP_BASE, agp_bridge->gart_bus_addr);
+#endif
+
+	if (is_u3) {
+		pci_write_config_dword(agp_bridge->dev,
+				       UNI_N_CFG_GART_DUMMY_PAGE,
+				       agp_bridge->scratch_page_real >> 12);
+	}
 	
 	return 0;
 }
@@ -111,13 +147,14 @@
 	j = pg_start;
 
 	while (j < (pg_start + mem->page_count)) {
-		if (!PGE_EMPTY(agp_bridge, agp_bridge->gatt_table[j]))
+		if (agp_bridge->gatt_table[j])
 			return -EBUSY;
 		j++;
 	}
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge->gatt_table[j] = cpu_to_le32((mem->memory[i] & 0xfffff000) | 0x00000001UL);
+		agp_bridge->gatt_table[j] =
+		    cpu_to_le32((mem->memory[i] & 0xFFFFF000UL) | 0x1UL);
 		flush_dcache_range((unsigned long)__va(mem->memory[i]),
 				   (unsigned long)__va(mem->memory[i])+0x1000);
 	}
@@ -130,17 +167,90 @@
 	return 0;
 }
 
+static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
+{
+	int i, num_entries;
+	void *temp;
+	u32 *gp;
+
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_32(temp)->num_entries;
+
+	if (type != 0 || mem->type != 0)
+		/* We know nothing of memory types */
+		return -EINVAL;
+	if ((pg_start + mem->page_count) > num_entries)
+		return -EINVAL;
+
+	gp = (u32 *) &agp_bridge->gatt_table[pg_start];
+	for (i = 0; i < mem->page_count; ++i) {
+		if (gp[i]) {
+			printk("u3_insert_memory: entry 0x%x occupied (%x)\n",
+			       i, gp[i]);
+			return -EBUSY;
+		}
+	}
+
+	for (i = 0; i < mem->page_count; i++) {
+		gp[i] = (mem->memory[i] >> PAGE_SHIFT) | 0x80000000UL;
+		flush_dcache_range((unsigned long)__va(mem->memory[i]),
+				   (unsigned long)__va(mem->memory[i])+0x1000);
+	}
+	mb();
+	flush_dcache_range((unsigned long)gp, (unsigned long) &gp[i]);
+	uninorth_tlbflush(mem);
+
+	return 0;
+}
+
+int u3_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
+{
+	size_t i;
+	u32 *gp;
+
+	if (type != 0 || mem->type != 0)
+		/* We know nothing of memory types */
+		return -EINVAL;
+
+	gp = (u32 *) &agp_bridge->gatt_table[pg_start];
+	for (i = 0; i < mem->page_count; ++i)
+		gp[i] = 0;
+	mb();
+	flush_dcache_range((unsigned long)gp, (unsigned long) &gp[i]);
+	uninorth_tlbflush(mem);
+
+	return 0;
+}
+
 static void uninorth_agp_enable(struct agp_bridge_data *bridge, u32 mode)
 {
-	u32 command, scratch;
+	u32 command, scratch, status;
 	int timeout;
 
 	pci_read_config_dword(bridge->dev,
 			      bridge->capndx + PCI_AGP_STATUS,
-			      &command);
+			      &status);
 
-	command = agp_collect_device_status(bridge, mode, command);
-	command |= 0x100;
+	command = agp_collect_device_status(bridge, mode, status);
+	command |= PCI_AGP_COMMAND_AGP;
+	
+	if (uninorth_rev == 0x21) {
+		/*
+		 * Darwin disable AGP 4x on this revision, thus we
+		 * may assume it's broken. This is an AGP2 controller.
+		 */
+		command &= ~AGPSTAT2_4X;
+	}
+
+	if ((uninorth_rev >= 0x30) && (uninorth_rev <= 0x33)) {
+		/*
+		 * We need to to set REQ_DEPTH to 7 for U3 versions 1.0, 2.1,
+		 * 2.2 and 2.3, Darwin do so.
+		 */
+		if ((command >> AGPSTAT_RQ_DEPTH_SHIFT) > 7)
+			command = (command & ~AGPSTAT_RQ_DEPTH)
+				| (7 << AGPSTAT_RQ_DEPTH_SHIFT);
+	}
 
 	uninorth_tlbflush(NULL);
 
@@ -152,11 +262,17 @@
 		pci_read_config_dword(bridge->dev,
 				      bridge->capndx + PCI_AGP_COMMAND,
 				       &scratch);
-	} while ((scratch & 0x100) == 0 && ++timeout < 1000);
-	if ((scratch & 0x100) == 0)
+	} while ((scratch & PCI_AGP_COMMAND_AGP) == 0 && ++timeout < 1000);
+	if ((scratch & PCI_AGP_COMMAND_AGP) == 0)
 		printk(KERN_ERR PFX "failed to write UniNorth AGP command reg\n");
 
-	agp_device_command(command, 0);
+	if (uninorth_rev >= 0x30) {
+		/* This is an AGP V3 */
+		agp_device_command(command, (status & AGPSTAT_MODE_3_0));
+	} else {
+		/* AGP V2 */
+		agp_device_command(command, 0);
+	}
 
 	uninorth_tlbflush(NULL);
 }
@@ -229,12 +345,12 @@
 	struct page *page;
 
 	/* We can't handle 2 level gatt's */
-	if (agp_bridge->driver->size_type == LVL2_APER_SIZE)
+	if (bridge->driver->size_type == LVL2_APER_SIZE)
 		return -EINVAL;
 
 	table = NULL;
-	i = agp_bridge->aperture_size_idx;
-	temp = agp_bridge->current_size;
+	i = bridge->aperture_size_idx;
+	temp = bridge->current_size;
 	size = page_order = num_entries = 0;
 
 	do {
@@ -246,11 +362,11 @@
 
 		if (table == NULL) {
 			i++;
-			agp_bridge->current_size = A_IDX32(agp_bridge);
+			bridge->current_size = A_IDX32(bridge);
 		} else {
-			agp_bridge->aperture_size_idx = i;
+			bridge->aperture_size_idx = i;
 		}
-	} while (!table && (i < agp_bridge->driver->num_aperture_sizes));
+	} while (!table && (i < bridge->driver->num_aperture_sizes));
 
 	if (table == NULL)
 		return -ENOMEM;
@@ -260,14 +376,12 @@
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		SetPageReserved(page);
 
-	agp_bridge->gatt_table_real = (u32 *) table;
-	agp_bridge->gatt_table = (u32 *)table;
-	agp_bridge->gatt_bus_addr = virt_to_phys(table);
-
-	for (i = 0; i < num_entries; i++) {
-		agp_bridge->gatt_table[i] =
-		    (unsigned long) agp_bridge->scratch_page;
-	}
+	bridge->gatt_table_real = (u32 *) table;
+	bridge->gatt_table = (u32 *)table;
+	bridge->gatt_bus_addr = virt_to_phys(table);
+
+	for (i = 0; i < num_entries; i++)
+		bridge->gatt_table[i] = 0;
 
 	flush_dcache_range((unsigned long)table, (unsigned long)table_end);
 
@@ -281,7 +395,7 @@
 	void *temp;
 	struct page *page;
 
-	temp = agp_bridge->current_size;
+	temp = bridge->current_size;
 	page_order = A_SIZE_32(temp)->page_order;
 
 	/* Do not worry about freeing memory, because if this is
@@ -289,13 +403,13 @@
 	 * from the table.
 	 */
 
-	table = (char *) agp_bridge->gatt_table_real;
+	table = (char *) bridge->gatt_table_real;
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		ClearPageReserved(page);
 
-	free_pages((unsigned long) agp_bridge->gatt_table_real, page_order);
+	free_pages((unsigned long) bridge->gatt_table_real, page_order);
 
 	return 0;
 }
@@ -320,6 +434,22 @@
 	{4, 1024, 0, 1}
 };
 
+/*
+ * Not sure that u3 supports that high aperture sizes but it
+ * would strange if it did not :)
+ */
+static struct aper_size_info_32 u3_sizes[8] =
+{
+	{512, 131072, 7, 128},
+	{256, 65536, 6, 64},
+	{128, 32768, 5, 32},
+	{64, 16384, 4, 16},
+	{32, 8192, 3, 8},
+	{16, 4096, 2, 4},
+	{8, 2048, 1, 2},
+	{4, 1024, 0, 1}
+};
+
 struct agp_bridge_driver uninorth_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)uninorth_sizes,
@@ -344,6 +474,31 @@
 	.cant_use_aperture	= 1,
 };
 
+struct agp_bridge_driver u3_agp_driver = {
+	.owner			= THIS_MODULE,
+	.aperture_sizes		= (void *)u3_sizes,
+	.size_type		= U32_APER_SIZE,
+	.num_aperture_sizes	= 8,
+	.configure		= uninorth_configure,
+	.fetch_size		= uninorth_fetch_size,
+	.cleanup		= uninorth_cleanup,
+	.tlb_flush		= uninorth_tlbflush,
+	.mask_memory		= agp_generic_mask_memory,
+	.masks			= NULL,
+	.cache_flush		= null_cache_flush,
+	.agp_enable		= uninorth_agp_enable,
+	.create_gatt_table	= uninorth_create_gatt_table,
+	.free_gatt_table	= uninorth_free_gatt_table,
+	.insert_memory		= u3_insert_memory,
+	.remove_memory		= u3_remove_memory,
+	.alloc_by_type		= agp_generic_alloc_by_type,
+	.free_by_type		= agp_generic_free_by_type,
+	.agp_alloc_page		= agp_generic_alloc_page,
+	.agp_destroy_page	= agp_generic_destroy_page,
+	.cant_use_aperture	= 1,
+	.needs_scratch_page	= 1,
+};
+
 static struct agp_device_ids uninorth_agp_device_ids[] __devinitdata = {
 	{
 		.device_id	= PCI_DEVICE_ID_APPLE_UNI_N_AGP,
@@ -361,6 +516,18 @@
 		.device_id	= PCI_DEVICE_ID_APPLE_UNI_N_AGP2,
 		.chipset_name	= "UniNorth 2",
 	},
+	{
+		.device_id	= PCI_DEVICE_ID_APPLE_U3_AGP,
+		.chipset_name	= "U3",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_APPLE_U3L_AGP,
+		.chipset_name	= "U3L",
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_APPLE_U3H_AGP,
+		.chipset_name	= "U3H",
+	},
 };
 
 static int __devinit agp_uninorth_probe(struct pci_dev *pdev,
@@ -368,6 +535,7 @@
 {
 	struct agp_device_ids *devs = uninorth_agp_device_ids;
 	struct agp_bridge_data *bridge;
+	struct device_node *uninorth_node;
 	u8 cap_ptr;
 	int j;
 
@@ -389,13 +557,36 @@
 	return -ENODEV;
 
  found:
+	/* Set revision to 0 if we could not read it. */
+	uninorth_rev = 0;
+	is_u3 = 0;
+	/* Locate core99 Uni-N */
+	uninorth_node = of_find_node_by_name(NULL, "uni-n");
+	/* Locate G5 u3 */
+	if (uninorth_node == NULL) {
+		is_u3 = 1;
+		uninorth_node = of_find_node_by_name(NULL, "u3");
+	}
+	if (uninorth_node) {
+		int *revprop = (int *)
+			get_property(uninorth_node, "device-rev", NULL);
+		if (revprop != NULL)
+			uninorth_rev = *revprop & 0x3f;
+		of_node_put(uninorth_node);
+	}
+
 	bridge = agp_alloc_bridge();
 	if (!bridge)
 		return -ENOMEM;
 
-	bridge->driver = &uninorth_agp_driver;
+	if (is_u3)
+		bridge->driver = &u3_agp_driver;
+	else
+		bridge->driver = &uninorth_agp_driver;
+
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;
+	bridge->flags = AGP_ERRATA_FASTWRITES;
 
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev, cap_ptr+PCI_AGP_STATUS, &bridge->mode);
diff -urN linux-2.5/include/asm-ppc/uninorth.h g5/include/asm-ppc/uninorth.h
--- linux-2.5/include/asm-ppc/uninorth.h	2005-01-31 17:22:37.000000000 +1100
+++ g5/include/asm-ppc/uninorth.h	2005-03-11 11:54:54.000000000 +1100
@@ -27,13 +27,18 @@
 #define UNI_N_CFG_AGP_BASE		0x90
 #define UNI_N_CFG_GART_CTRL		0x94
 #define UNI_N_CFG_INTERNAL_STATUS	0x98
+#define UNI_N_CFG_GART_DUMMY_PAGE	0xa4
 
 /* UNI_N_CFG_GART_CTRL bits definitions */
-/* Not U3 */
 #define UNI_N_CFG_GART_INVAL		0x00000001
 #define UNI_N_CFG_GART_ENABLE		0x00000100
 #define UNI_N_CFG_GART_2xRESET		0x00010000
 #define UNI_N_CFG_GART_DISSBADET	0x00020000
+/* The following seems to only be used only on U3 <j.glisse@gmail.com> */
+#define U3_N_CFG_GART_SYNCMODE		0x00040000
+#define U3_N_CFG_GART_PERFRD		0x00080000
+#define U3_N_CFG_GART_B2BGNT		0x00200000
+#define U3_N_CFG_GART_FASTDDR		0x00400000
 
 /* My understanding of UniNorth AGP as of UniNorth rev 1.0x,
  * revision 1.5 (x4 AGP) may need further changes.
diff -urN linux-2.5/include/asm-ppc64/agp.h g5/include/asm-ppc64/agp.h
--- /dev/null	2005-03-10 17:27:14.905983648 +1100
+++ g5/include/asm-ppc64/agp.h	2005-03-11 11:54:54.000000000 +1100
@@ -0,0 +1,13 @@
+#ifndef AGP_H
+#define AGP_H 1
+
+#include <asm/io.h>
+
+/* nothing much needed here */
+
+#define map_page_into_agp(page)
+#define unmap_page_from_agp(page)
+#define flush_agp_mappings()
+#define flush_agp_cache() mb()
+
+#endif
diff -urN linux-2.5/include/linux/pci_ids.h g5/include/linux/pci_ids.h
--- linux-2.5/include/linux/pci_ids.h	2005-03-11 11:47:38.000000000 +1100
+++ g5/include/linux/pci_ids.h	2005-03-11 11:54:54.000000000 +1100
@@ -876,10 +876,13 @@
 #define PCI_DEVICE_ID_APPLE_IPID_ATA100	0x003b
 #define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
 #define PCI_DEVICE_ID_APPLE_K2_ATA100	0x0043
+#define PCI_DEVICE_ID_APPLE_U3_AGP	0x004b
 #define PCI_DEVICE_ID_APPLE_K2_GMAC	0x004c
 #define PCI_DEVICE_ID_APPLE_SH_ATA      0x0050
 #define PCI_DEVICE_ID_APPLE_SH_SUNGEM   0x0051
 #define PCI_DEVICE_ID_APPLE_SH_FW       0x0052
+#define PCI_DEVICE_ID_APPLE_U3L_AGP	0x0058
+#define PCI_DEVICE_ID_APPLE_U3H_AGP	0x0059
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
