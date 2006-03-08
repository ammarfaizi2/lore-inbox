Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWCHTpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWCHTpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWCHTpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:45:20 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:7615 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932185AbWCHTpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:45:18 -0500
Date: Wed, 8 Mar 2006 21:46:27 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] sata_mv: stabilize for 5081 and other fixes
Message-ID: <20060308194627.GA22346@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With the patch below I've managed to stabilize the sata_mv driver 
running a Marvell 5081 SATA controller. Prior to these changes it
would cause sporadic memory corruptions right after insmod. I prefer 
this driver over Marvell's own driver which have all sorts of weird
bugs.

The patch also increases the maximum possible number of SG entries 
per IO to 256 (this large sg_tablesize is a requirement for the 
application we are developing at my company, XIV). Notice that it 
also zeros-out a reserved field in the SG, I'm not sure how it 
affected stability but something did. I've also added the 'volatile' 
qualifier to some fields that belong to structs involved with I/O.

This patch is for 2.6.16-rc5.

Signed-off-by: Dan Aloni <dan@xiv.co.il>

--- drivers/scsi/sata_mv.c	2006-03-08 11:30:10.000000000 +0200
+++ drivers/scsi/sata_mv.c	2006-03-08 20:59:55.000000000 +0200
@@ -72,9 +72,10 @@
 	 */
 	MV_CRQB_Q_SZ		= (32 * MV_MAX_Q_DEPTH),
 	MV_CRPB_Q_SZ		= (8 * MV_MAX_Q_DEPTH),
-	MV_MAX_SG_CT		= 176,
+	MV_MAX_SG_CT		= 256,
 	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
-	MV_PORT_PRIV_DMA_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ + MV_SG_TBL_SZ),
+	MV_PORT_PRIV_DMA1_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ),
+	MV_PORT_PRIV_DMA2_SZ	= (MV_SG_TBL_SZ),
 
 	MV_PORTS_PER_HC		= 4,
 	/* == (port / MV_PORTS_PER_HC) to determine HC from 0-7 port */
@@ -98,7 +99,7 @@
 
 	CRPB_FLAG_STATUS_SHIFT	= 8,
 
-	EPRD_FLAG_END_OF_TBL	= (1 << 31),
+	EPRD_FLAG_END_OF_TBL	= (1 << 15),
 
 	/* PCI interface registers */
 
@@ -257,29 +258,34 @@
 	chip_608x,
 };
 
+#pragma pack(1)
+
 /* Command ReQuest Block: 32B */
 struct mv_crqb {
-	u32			sg_addr;
-	u32			sg_addr_hi;
-	u16			ctrl_flags;
+	volatile u32			sg_addr;
+	volatile u32			sg_addr_hi;
+	volatile u16			ctrl_flags;
 	u16			ata_cmd[11];
 };
 
 /* Command ResPonse Block: 8B */
 struct mv_crpb {
-	u16			id;
-	u16			flags;
-	u32			tmstmp;
+	volatile u16			id;
+	volatile u16			flags;
+	volatile u32			tmstmp;
 };
 
 /* EDMA Physical Region Descriptor (ePRD); A.K.A. SG */
 struct mv_sg {
-	u32			addr;
-	u32			flags_size;
-	u32			addr_hi;
-	u32			reserved;
+	volatile u32			addr;
+	volatile u16			size;
+	volatile u16			flags;
+	volatile u32			addr_hi;
+	volatile u32			reserved;
 };
 
+#pragma pack(0)
+
 struct mv_port_priv {
 	struct mv_crqb		*crqb;
 	dma_addr_t		crqb_dma;
@@ -294,8 +300,8 @@
 };
 
 struct mv_port_signal {
-	u32			amps;
-	u32			pre;
+	volatile u32			amps;
+	volatile u32			pre;
 };
 
 struct mv_host_priv;
@@ -365,7 +371,7 @@
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= MV_MAX_SG_CT / 2,
+	.sg_tablesize		= MV_MAX_SG_CT,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
@@ -509,10 +515,7 @@
 	.reset_bus		= mv_reset_pci_bus,
 };
 
-/*
- * module options
- */
-static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
+static int msi;              /* Use PCI msi; either zero (off, default) or non-zero */
 
 
 /*
@@ -770,7 +773,8 @@
 
 static inline void mv_priv_free(struct mv_port_priv *pp, struct device *dev)
 {
-	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
+	dma_free_coherent(dev, MV_PORT_PRIV_DMA1_SZ, pp->crpb, pp->crpb_dma);
+	dma_free_coherent(dev, MV_PORT_PRIV_DMA2_SZ, pp->sg_tbl, pp->sg_tbl_dma);
 }
 
 /**
@@ -788,8 +792,8 @@
 	struct device *dev = ap->host_set->dev;
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
-	void *mem;
-	dma_addr_t mem_dma;
+	void *mem, *mem2;
+	dma_addr_t mem_dma, mem_dma2;
 	int rc = -ENOMEM;
 
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
@@ -797,11 +801,17 @@
 		goto err_out;
 	memset(pp, 0, sizeof(*pp));
 
-	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
+	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA1_SZ, &mem_dma,
 				 GFP_KERNEL);
 	if (!mem)
 		goto err_out_pp;
-	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
+	memset(mem, 0, MV_PORT_PRIV_DMA1_SZ);
+
+	mem2 = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA2_SZ, &mem_dma2,
+				 GFP_KERNEL);
+	if (!mem2)
+		goto err_out_pp_2;
+	memset(mem2, 0, MV_PORT_PRIV_DMA2_SZ);
 
 	rc = ata_pad_alloc(ap, dev);
 	if (rc)
@@ -820,14 +830,12 @@
 	 */
 	pp->crpb = mem;
 	pp->crpb_dma = mem_dma;
-	mem += MV_CRPB_Q_SZ;
-	mem_dma += MV_CRPB_Q_SZ;
 
 	/* Third item:
 	 * Table of scatter-gather descriptors (ePRD), 16 bytes each
 	 */
-	pp->sg_tbl = mem;
-	pp->sg_tbl_dma = mem_dma;
+	pp->sg_tbl = mem2;
+	pp->sg_tbl_dma = mem_dma2;
 
 	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT |
 		 EDMA_CFG_WR_BUFF_LEN, port_mmio + EDMA_CFG_OFS);
@@ -853,7 +861,9 @@
 	return 0;
 
 err_out_priv:
-	mv_priv_free(pp, dev);
+	dma_free_coherent(dev, MV_PORT_PRIV_DMA2_SZ, pp->sg_tbl, pp->sg_tbl_dma);
+err_out_pp_2:
+	dma_free_coherent(dev, MV_PORT_PRIV_DMA1_SZ, pp->crpb, pp->crpb_dma);
 err_out_pp:
 	kfree(pp);
 err_out:
@@ -915,13 +925,15 @@
 
 			pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
 			pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-			pp->sg_tbl[i].flags_size = cpu_to_le32(len);
+			pp->sg_tbl[i].flags = cpu_to_le16(0);
+			pp->sg_tbl[i].size = cpu_to_le16(len);
+			pp->sg_tbl[i].reserved = 0;
 
 			sg_len -= len;
 			addr += len;
 
 			if (!sg_len && ata_sg_is_last(sg, qc))
-				pp->sg_tbl[i].flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
+				pp->sg_tbl[i].flags |= cpu_to_le16(EPRD_FLAG_END_OF_TBL);
 
 			i++;
 		}


-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
