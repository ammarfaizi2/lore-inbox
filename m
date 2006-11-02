Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752669AbWKBVuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbWKBVuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbWKBVtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:49:46 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21198 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752669AbWKBVto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:49:44 -0500
From: muli@il.ibm.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, muli@il.ibm.com,
       jdmason@kudzu.us
Subject: [PATCH 3/4] Calgary: check BBAR ioremap success when ioremapping
Reply-To: muli@il.ibm.com
Date: Thu, 02 Nov 2006 23:49:39 +0200
Message-Id: <11625041802404-git-send-email-muli@il.ibm.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1162504180570-git-send-email-muli@il.ibm.com>
References: <11625041803066-git-send-email-muli@il.ibm.com> <11625041802816-git-send-email-muli@il.ibm.com> <1162504180570-git-send-email-muli@il.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muli Ben-Yehuda <muli@il.ibm.com>

This patch cleans up the previous "Use BIOS supplied BBAR information"
patch. Mostly stylistic clenaups, but also check for ioremap failure
when we ioremap the BBAR rather than when trying to use it.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Acked-by: Laurent Vivier <Laurent.Vivier@bull.net>
---
 arch/x86_64/kernel/pci-calgary.c |   85 ++++++++++++++++++++++----------------
 include/asm-x86_64/rio.h         |    8 +---
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/arch/x86_64/kernel/pci-calgary.c b/arch/x86_64/kernel/pci-calgary.c
index 71922e0..eaa8d31 100644
--- a/arch/x86_64/kernel/pci-calgary.c
+++ b/arch/x86_64/kernel/pci-calgary.c
@@ -138,7 +138,7 @@ static int calgary_detected __read_mostl
 
 static struct rio_table_hdr	*rio_table_hdr __initdata;
 static struct scal_detail	*scal_devs[MAX_NUMNODES] __initdata;
-static struct rio_detail	*rio_devs[MAX_NUMNODES*4] __initdata;
+static struct rio_detail	*rio_devs[MAX_NUMNODES * 4] __initdata;
 
 struct calgary_bus_info {
 	void *tce_space;
@@ -855,11 +855,6 @@ static void __init calgary_disable_trans
 	del_timer_sync(&tbl->watchdog_timer);
 }
 
-static inline void __iomem * __init locate_register_space(struct pci_dev *dev)
-{
-	return busno_to_bbar(dev->bus->number);
-}
-
 static void __init calgary_init_one_nontraslated(struct pci_dev *dev)
 {
 	pci_dev_get(dev);
@@ -874,15 +869,10 @@ static int __init calgary_init_one(struc
 
 	BUG_ON(dev->bus->number >= MAX_PHB_BUS_NUM);
 
-	bbar = locate_register_space(dev);
-	if (!bbar) {
-		ret = -ENODATA;
-		goto done;
-	}
-
+	bbar = busno_to_bbar(dev->bus->number);
 	ret = calgary_setup_tar(dev, bbar);
 	if (ret)
-		goto iounmap;
+		goto done;
 
 	pci_dev_get(dev);
 	dev->bus->self = dev;
@@ -890,38 +880,39 @@ static int __init calgary_init_one(struc
 
 	return 0;
 
-iounmap:
-	iounmap(bbar);
 done:
 	return ret;
 }
 
-static int __init calgary_init(void)
+static int __init calgary_locate_bbars(void)
 {
-	int ret = -ENODEV;
-	struct pci_dev *dev = NULL;
-	int rio, phb, bus;
+	int ret;
+	int rioidx, phb, bus;
 	void __iomem *bbar;
 	void __iomem *target;
+	unsigned long offset;
 	u8 start_bus, end_bus;
 	u32 val;
 
-	for (rio = 0; rio < rio_table_hdr->num_rio_dev; rio++) {
+	ret = -ENODATA;
+	for (rioidx = 0; rioidx < rio_table_hdr->num_rio_dev; rioidx++) {
+		struct rio_detail *rio = rio_devs[rioidx];
 
-		if ( (rio_devs[rio]->type != COMPAT_CALGARY) &&
-		     (rio_devs[rio]->type != ALT_CALGARY) )
+		if ((rio->type != COMPAT_CALGARY) && (rio->type != ALT_CALGARY))
 			continue;
 
 		/* map entire 1MB of Calgary config space */
-		bbar = ioremap_nocache(rio_devs[rio]->BBAR, 1024 * 1024);
+		bbar = ioremap_nocache(rio->BBAR, 1024 * 1024);
+		if (!bbar)
+			goto error;
 
 		for (phb = 0; phb < PHBS_PER_CALGARY; phb++) {
+			offset = phb_debug_offsets[phb] | PHB_DEBUG_STUFF_OFFSET;
+			target = calgary_reg(bbar, offset);
 
-			target = calgary_reg(bbar, phb_debug_offsets[phb] |
-						   PHB_DEBUG_STUFF_OFFSET);
 			val = be32_to_cpu(readl(target));
 			start_bus = (u8)((val & 0x00FF0000) >> 16);
-			end_bus =   (u8)((val & 0x0000FF00) >> 8);
+			end_bus = (u8)((val & 0x0000FF00) >> 8);
 			for (bus = start_bus; bus <= end_bus; bus++) {
 				bus_info[bus].bbar = bbar;
 				bus_info[bus].phbid = phb;
@@ -929,6 +920,25 @@ static int __init calgary_init(void)
 		}
 	}
 
+	return 0;
+
+error:
+	/* scan bus_info and iounmap any bbars we previously ioremap'd */
+	for (bus = 0; bus < ARRAY_SIZE(bus_info); bus++)
+		if (bus_info[bus].bbar)
+			iounmap(bbar);
+
+	return ret;
+}
+
+static int __init calgary_init(void)
+{
+	int ret;
+	struct pci_dev *dev = NULL;
+
+	ret = calgary_locate_bbars();
+	if (ret)
+		return ret;
 
 	do {
 		dev = pci_get_device(PCI_VENDOR_ID_IBM,
@@ -1000,18 +1010,13 @@ static int __init build_detail_arrays(vo
 
 	if (rio_table_hdr->num_scal_dev > MAX_NUMNODES){
 		printk(KERN_WARNING
-			"Calgary: MAX_NUMNODES too low!  Defined as %d, "
+			"Calgary: MAX_NUMNODES too low! Defined as %d, "
 			"but system has %d nodes.\n",
 			MAX_NUMNODES, rio_table_hdr->num_scal_dev);
 		return -ENODEV;
 	}
 
 	switch (rio_table_hdr->version){
-	default:
-		printk(KERN_WARNING
-		       "Calgary: Invalid Rio Grande Table Version: %d\n",
-		       rio_table_hdr->version);
-		return -ENODEV;
 	case 2:
 		scal_detail_size = 11;
 		rio_detail_size = 13;
@@ -1020,6 +1025,11 @@ static int __init build_detail_arrays(vo
 		scal_detail_size = 12;
 		rio_detail_size = 15;
 		break;
+	default:
+		printk(KERN_WARNING
+		       "Calgary: Invalid Rio Grande Table Version: %d\n",
+		       rio_table_hdr->version);
+		return -EPROTO;
 	}
 
 	ptr = ((unsigned long)rio_table_hdr) + 3;
@@ -1042,6 +1052,7 @@ void __init detect_calgary(void)
 	int calgary_found = 0;
 	unsigned long ptr;
 	int offset;
+	int ret;
 
 	/*
 	 * if the user specified iommu=off or iommu=soft or we found
@@ -1061,27 +1072,29 @@ void __init detect_calgary(void)
 		/* The block id is stored in the 2nd word */
 		if (*((unsigned short *)(ptr + offset + 2)) == 0x4752){
 			/* set the pointer past the offset & block id */
-			rio_table_hdr = (struct rio_table_hdr *)(ptr+offset+4);
+			rio_table_hdr = (struct rio_table_hdr *)(ptr + offset + 4);
 			break;
 		}
 		/* The next offset is stored in the 1st word. 0 means no more */
 		offset = *((unsigned short *)(ptr + offset));
 	}
-	if (!rio_table_hdr){
+	if (!rio_table_hdr) {
 		printk(KERN_ERR "Calgary: Unable to locate "
 				"Rio Grande Table in EBDA - bailing!\n");
 		return;
 	}
 
-	if (build_detail_arrays())
+	ret = build_detail_arrays();
+	if (ret) {
+		printk(KERN_ERR "Calgary: build_detail_arrays ret %d\n", ret);
 		return;
+	}
 
 	specified_table_size = determine_tce_table_size(end_pfn * PAGE_SIZE);
 
 	for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
 		int dev;
 		struct calgary_bus_info *info = &bus_info[bus];
-		info->phbid = -1;
 
 		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
 			continue;
diff --git a/include/asm-x86_64/rio.h b/include/asm-x86_64/rio.h
index 1f315c3..c7350f6 100644
--- a/include/asm-x86_64/rio.h
+++ b/include/asm-x86_64/rio.h
@@ -3,7 +3,6 @@
  *          and include/asm-i386/mach-default/bios_ebda.h
  *
  * Author: Laurent Vivier <Laurent.Vivier@bull.net>
- *
  */
 
 #ifndef __ASM_RIO_H
@@ -19,7 +18,7 @@ struct rio_table_hdr {
 
 struct scal_detail {
 	u8 node_id;      /* Scalability Node ID                    */
-	u32  CBAR;       /* Address of 1MB register space          */
+	u32 CBAR;        /* Address of 1MB register space          */
 	u8 port0node;    /* Node ID port connected to: 0xFF=None   */
 	u8 port0port;    /* Port num port connected to: 0,1,2, or  */
 	                 /* 0xFF=None                              */
@@ -34,7 +33,7 @@ struct scal_detail {
 
 struct rio_detail {
 	u8 node_id;      /* RIO Node ID                            */
-	u32  BBAR;       /* Address of 1MB register space          */
+	u32 BBAR;        /* Address of 1MB register space          */
 	u8 type;         /* Type of device                         */
 	u8 owner_id;     /* Node ID of Hurricane that owns this    */
 	                 /* node                                   */
@@ -65,10 +64,9 @@ enum {
  * there is a real-mode segmented pointer pointing to the
  * 4K EBDA area at 0x40E.
  */
-
 static inline unsigned long get_bios_ebda(void)
 {
-	unsigned long address= *(unsigned short *)phys_to_virt(0x40Eul);
+	unsigned long address = *(unsigned short *)phys_to_virt(0x40EUL);
 	address <<= 4;
 	return address;
 }
-- 
1.4.1

