Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752323AbWKBVuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbWKBVuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbWKBVtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:49:50 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:591 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752684AbWKBVtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:49:45 -0500
From: muli@il.ibm.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, muli@il.ibm.com,
       jdmason@kudzu.us, Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH 2/4] Calgary: use BIOS supplied BBARs and topology information
Reply-To: muli@il.ibm.com
Date: Thu, 02 Nov 2006 23:49:38 +0200
Message-Id: <1162504180570-git-send-email-muli@il.ibm.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11625041802816-git-send-email-muli@il.ibm.com>
References: <11625041803066-git-send-email-muli@il.ibm.com> <11625041802816-git-send-email-muli@il.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Vivier <Laurent.Vivier@bull.net>

Find the BBAR register address of each Calgary using the "Extended
BIOS Data Area" rather than calculating it ourselves. Also get the bus
topology (what PHB each bus is on) from Calgary rather than
calculating it ourselves.

This patch fixes http://bugzilla.kernel.org/show_bug.cgi?id=7407.

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 arch/x86_64/kernel/pci-calgary.c |  161 ++++++++++++++++++++++++++++++--------
 include/asm-x86_64/rio.h         |   76 ++++++++++++++++++
 2 files changed, 201 insertions(+), 36 deletions(-)

diff --git a/arch/x86_64/kernel/pci-calgary.c b/arch/x86_64/kernel/pci-calgary.c
index 31d5758..71922e0 100644
--- a/arch/x86_64/kernel/pci-calgary.c
+++ b/arch/x86_64/kernel/pci-calgary.c
@@ -41,6 +41,7 @@ #include <asm/tce.h>
 #include <asm/pci-direct.h>
 #include <asm/system.h>
 #include <asm/dma.h>
+#include <asm/rio.h>
 
 #define PCI_DEVICE_ID_IBM_CALGARY 0x02a1
 #define PCI_VENDOR_DEVICE_ID_CALGARY \
@@ -115,14 +116,35 @@ static const unsigned long phb_offsets[]
 	0xB000 /* PHB3 */
 };
 
+/* PHB debug registers */
+
+static const unsigned long phb_debug_offsets[] = {
+	0x4000	/* PHB 0 DEBUG */,
+	0x5000	/* PHB 1 DEBUG */,
+	0x6000	/* PHB 2 DEBUG */,
+	0x7000	/* PHB 3 DEBUG */
+};
+
+/*
+ * STUFF register for each debug PHB,
+ * byte 1 = start bus number, byte 2 = end bus number
+ */
+
+#define PHB_DEBUG_STUFF_OFFSET	0x0020
+
 unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
 static int translate_empty_slots __read_mostly = 0;
 static int calgary_detected __read_mostly = 0;
 
+static struct rio_table_hdr	*rio_table_hdr __initdata;
+static struct scal_detail	*scal_devs[MAX_NUMNODES] __initdata;
+static struct rio_detail	*rio_devs[MAX_NUMNODES*4] __initdata;
+
 struct calgary_bus_info {
 	void *tce_space;
 	unsigned char translation_disabled;
 	signed char phbid;
+	void __iomem *bbar;
 };
 
 static struct calgary_bus_info bus_info[MAX_PHB_BUS_NUM] = { { NULL, 0, 0 }, };
@@ -475,6 +497,11 @@ static struct dma_mapping_ops calgary_dm
 	.unmap_sg = calgary_unmap_sg,
 };
 
+static inline void __iomem * busno_to_bbar(unsigned char num)
+{
+	return bus_info[num].bbar;
+}
+
 static inline int busno_to_phbid(unsigned char num)
 {
 	return bus_info[num].phbid;
@@ -828,31 +855,9 @@ static void __init calgary_disable_trans
 	del_timer_sync(&tbl->watchdog_timer);
 }
 
-static inline unsigned int __init locate_register_space(struct pci_dev *dev)
+static inline void __iomem * __init locate_register_space(struct pci_dev *dev)
 {
-	int rionodeid;
-	u32 address;
-
-	/*
-	 * Each Calgary has four busses. The first four busses (first Calgary)
-	 * have RIO node ID 2, then the next four (second Calgary) have RIO
-	 * node ID 3, the next four (third Calgary) have node ID 2 again, etc.
-	 * We use a gross hack - relying on the dev->bus->number ordering,
-	 * modulo 14 - to decide which Calgary a given bus is on. Busses 0, 1,
-	 * 2 and 4 are on the first Calgary (id 2), 6, 8, a and c are on the
-	 * second (id 3), and then it repeats modulo 14.
- 	 */
-	rionodeid = (dev->bus->number % 14 > 4) ? 3 : 2;
-	/*
-	 * register space address calculation as follows:
-	 * FE0MB-8MB*OneBasedChassisNumber+1MB*(RioNodeId-ChassisBase)
-	 * ChassisBase is always zero for x366/x260/x460
-	 * RioNodeId is 2 for first Calgary, 3 for second Calgary
-	 */
-	address = START_ADDRESS	-
-		(0x800000 * (ONE_BASED_CHASSIS_NUM + dev->bus->number / 14)) +
-		(0x100000) * (rionodeid - CHASSIS_BASE);
-	return address;
+	return busno_to_bbar(dev->bus->number);
 }
 
 static void __init calgary_init_one_nontraslated(struct pci_dev *dev)
@@ -864,15 +869,12 @@ static void __init calgary_init_one_nont
 
 static int __init calgary_init_one(struct pci_dev *dev)
 {
-	u32 address;
 	void __iomem *bbar;
 	int ret;
 
 	BUG_ON(dev->bus->number >= MAX_PHB_BUS_NUM);
 
-	address = locate_register_space(dev);
-	/* map entire 1MB of Calgary config space */
-	bbar = ioremap_nocache(address, 1024 * 1024);
+	bbar = locate_register_space(dev);
 	if (!bbar) {
 		ret = -ENODATA;
 		goto done;
@@ -898,6 +900,35 @@ static int __init calgary_init(void)
 {
 	int ret = -ENODEV;
 	struct pci_dev *dev = NULL;
+	int rio, phb, bus;
+	void __iomem *bbar;
+	void __iomem *target;
+	u8 start_bus, end_bus;
+	u32 val;
+
+	for (rio = 0; rio < rio_table_hdr->num_rio_dev; rio++) {
+
+		if ( (rio_devs[rio]->type != COMPAT_CALGARY) &&
+		     (rio_devs[rio]->type != ALT_CALGARY) )
+			continue;
+
+		/* map entire 1MB of Calgary config space */
+		bbar = ioremap_nocache(rio_devs[rio]->BBAR, 1024 * 1024);
+
+		for (phb = 0; phb < PHBS_PER_CALGARY; phb++) {
+
+			target = calgary_reg(bbar, phb_debug_offsets[phb] |
+						   PHB_DEBUG_STUFF_OFFSET);
+			val = be32_to_cpu(readl(target));
+			start_bus = (u8)((val & 0x00FF0000) >> 16);
+			end_bus =   (u8)((val & 0x0000FF00) >> 8);
+			for (bus = start_bus; bus <= end_bus; bus++) {
+				bus_info[bus].bbar = bbar;
+				bus_info[bus].phbid = phb;
+			}
+		}
+	}
+
 
 	do {
 		dev = pci_get_device(PCI_VENDOR_ID_IBM,
@@ -962,13 +993,55 @@ static inline int __init determine_tce_t
 	return ret;
 }
 
+static int __init build_detail_arrays(void)
+{
+	unsigned long ptr;
+	int i, scal_detail_size, rio_detail_size;
+
+	if (rio_table_hdr->num_scal_dev > MAX_NUMNODES){
+		printk(KERN_WARNING
+			"Calgary: MAX_NUMNODES too low!  Defined as %d, "
+			"but system has %d nodes.\n",
+			MAX_NUMNODES, rio_table_hdr->num_scal_dev);
+		return -ENODEV;
+	}
+
+	switch (rio_table_hdr->version){
+	default:
+		printk(KERN_WARNING
+		       "Calgary: Invalid Rio Grande Table Version: %d\n",
+		       rio_table_hdr->version);
+		return -ENODEV;
+	case 2:
+		scal_detail_size = 11;
+		rio_detail_size = 13;
+		break;
+	case 3:
+		scal_detail_size = 12;
+		rio_detail_size = 15;
+		break;
+	}
+
+	ptr = ((unsigned long)rio_table_hdr) + 3;
+	for (i = 0; i < rio_table_hdr->num_scal_dev;
+		    i++, ptr += scal_detail_size)
+		scal_devs[i] = (struct scal_detail *)ptr;
+
+	for (i = 0; i < rio_table_hdr->num_rio_dev;
+		    i++, ptr += rio_detail_size)
+		rio_devs[i] = (struct rio_detail *)ptr;
+
+	return 0;
+}
+
 void __init detect_calgary(void)
 {
 	u32 val;
 	int bus;
 	void *tbl;
 	int calgary_found = 0;
-	int phb = -1;
+	unsigned long ptr;
+	int offset;
 
 	/*
 	 * if the user specified iommu=off or iommu=soft or we found
@@ -980,6 +1053,29 @@ void __init detect_calgary(void)
 	if (!early_pci_allowed())
 		return;
 
+	ptr = (unsigned long)phys_to_virt(get_bios_ebda());
+
+	rio_table_hdr = NULL;
+	offset = 0x180;
+	while (offset) {
+		/* The block id is stored in the 2nd word */
+		if (*((unsigned short *)(ptr + offset + 2)) == 0x4752){
+			/* set the pointer past the offset & block id */
+			rio_table_hdr = (struct rio_table_hdr *)(ptr+offset+4);
+			break;
+		}
+		/* The next offset is stored in the 1st word. 0 means no more */
+		offset = *((unsigned short *)(ptr + offset));
+	}
+	if (!rio_table_hdr){
+		printk(KERN_ERR "Calgary: Unable to locate "
+				"Rio Grande Table in EBDA - bailing!\n");
+		return;
+	}
+
+	if (build_detail_arrays())
+		return;
+
 	specified_table_size = determine_tce_table_size(end_pfn * PAGE_SIZE);
 
 	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
@@ -990,12 +1086,6 @@ void __init detect_calgary(void)
 		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
 			continue;
 
-		/*
-		 * There are 4 PHBs per Calgary chip.  Set phb to which phb (0-3)
-		 * it is connected to releative to the clagary chip.
-		 */
-		phb = (phb + 1) % PHBS_PER_CALGARY;
-
 		if (info->translation_disabled)
 			continue;
 
@@ -1010,7 +1100,6 @@ void __init detect_calgary(void)
 				if (!tbl)
 					goto cleanup;
 				info->tce_space = tbl;
-				info->phbid = phb;
 				calgary_found = 1;
 				break;
 			}
diff --git a/include/asm-x86_64/rio.h b/include/asm-x86_64/rio.h
new file mode 100644
index 0000000..1f315c3
--- /dev/null
+++ b/include/asm-x86_64/rio.h
@@ -0,0 +1,76 @@
+/*
+ * Derived from include/asm-i386/mach-summit/mach_mpparse.h
+ *          and include/asm-i386/mach-default/bios_ebda.h
+ *
+ * Author: Laurent Vivier <Laurent.Vivier@bull.net>
+ *
+ */
+
+#ifndef __ASM_RIO_H
+#define __ASM_RIO_H
+
+#define RIO_TABLE_VERSION	3
+
+struct rio_table_hdr {
+	u8 version;      /* Version number of this data structure  */
+	u8 num_scal_dev; /* # of Scalability devices               */
+	u8 num_rio_dev;  /* # of RIO I/O devices                   */
+} __attribute__((packed));
+
+struct scal_detail {
+	u8 node_id;      /* Scalability Node ID                    */
+	u32  CBAR;       /* Address of 1MB register space          */
+	u8 port0node;    /* Node ID port connected to: 0xFF=None   */
+	u8 port0port;    /* Port num port connected to: 0,1,2, or  */
+	                 /* 0xFF=None                              */
+	u8 port1node;    /* Node ID port connected to: 0xFF = None */
+	u8 port1port;    /* Port num port connected to: 0,1,2, or  */
+	                 /* 0xFF=None                              */
+	u8 port2node;    /* Node ID port connected to: 0xFF = None */
+	u8 port2port;    /* Port num port connected to: 0,1,2, or  */
+	                 /* 0xFF=None                              */
+	u8 chassis_num;  /* 1 based Chassis number (1 = boot node) */
+} __attribute__((packed));
+
+struct rio_detail {
+	u8 node_id;      /* RIO Node ID                            */
+	u32  BBAR;       /* Address of 1MB register space          */
+	u8 type;         /* Type of device                         */
+	u8 owner_id;     /* Node ID of Hurricane that owns this    */
+	                 /* node                                   */
+	u8 port0node;    /* Node ID port connected to: 0xFF=None   */
+	u8 port0port;    /* Port num port connected to: 0,1,2, or  */
+	                 /* 0xFF=None                              */
+	u8 port1node;    /* Node ID port connected to: 0xFF=None   */
+	u8 port1port;    /* Port num port connected to: 0,1,2, or  */
+	                 /* 0xFF=None                              */
+	u8 first_slot;   /* Lowest slot number below this Calgary  */
+	u8 status;       /* Bit 0 = 1 : the XAPIC is used          */
+	                 /*       = 0 : the XAPIC is not used, ie: */
+	                 /*            ints fwded to another XAPIC */
+	                 /*           Bits1:7 Reserved             */
+	u8 WP_index;     /* instance index - lower ones have       */
+	                 /*     lower slot numbers/PCI bus numbers */
+	u8 chassis_num;  /* 1 based Chassis number                 */
+} __attribute__((packed));
+
+enum {
+	HURR_SCALABILTY	= 0,  /* Hurricane Scalability info */
+	HURR_RIOIB	= 2,  /* Hurricane RIOIB info       */
+	COMPAT_CALGARY	= 4,  /* Compatibility Calgary      */
+	ALT_CALGARY	= 5,  /* Second Planar Calgary      */
+};
+
+/*
+ * there is a real-mode segmented pointer pointing to the
+ * 4K EBDA area at 0x40E.
+ */
+
+static inline unsigned long get_bios_ebda(void)
+{
+	unsigned long address= *(unsigned short *)phys_to_virt(0x40Eul);
+	address <<= 4;
+	return address;
+}
+
+#endif /* __ASM_RIO_H */
-- 
1.4.1

