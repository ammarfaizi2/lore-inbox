Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVKRUKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVKRUKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVKRUKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:10:15 -0500
Received: from havoc.gtf.org ([69.61.125.42]:28060 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932438AbVKRUKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:10:13 -0500
Date: Fri, 18 Nov 2005 15:10:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fixes
Message-ID: <20051118201012.GA5452@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Largely this is to push probe and EH sata_sil24 fixes...  ATAPI is
only on a path that's currently disabled by default.


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_mv.c    |    3 
 drivers/scsi/sata_sil24.c |  197 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 162 insertions(+), 38 deletions(-)

Jeff Garzik:
      [libata sata_mv] update copyright, driver version

Tejun Heo:
      sil24: add sil24_restart_controller
      sil24: use SRST for phy_reset
      sil24: add ATAPI support
      sil24: make error_intr less verbose

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index ac184e6..ab7432a 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2,6 +2,7 @@
  * sata_mv.c - Marvell SATA support
  *
  * Copyright 2005: EMC Corporation, all rights reserved.
+ * Copyright 2005 Red Hat, Inc.  All rights reserved.
  *
  * Please ALWAYS copy linux-ide@vger.kernel.org on emails.
  *
@@ -36,7 +37,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.25"
+#define DRV_VERSION	"0.5"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index cb1933a..e0d6f19 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -5,17 +5,6 @@
  *
  * Based on preview driver from Silicon Image.
  *
- * NOTE: No NCQ/ATAPI support yet.  The preview driver didn't support
- * NCQ nor ATAPI, and, unfortunately, I couldn't find out how to make
- * those work.  Enabling those shouldn't be difficult.  Basic
- * structure is all there (in libata-dev tree).  If you have any
- * information about this hardware, please contact me or linux-ide.
- * Info is needed on...
- *
- * - How to issue tagged commands and turn on sactive on issue accordingly.
- * - Where to put an ATAPI command and how to tell the device to send it.
- * - How to enable/use 64bit.
- *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -42,7 +31,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"0.22"	/* Silicon Image's preview driver was 0.10 */
+#define DRV_VERSION	"0.23"
 
 /*
  * Port request block (PRB) 32 bytes
@@ -221,11 +210,22 @@ enum {
 	IRQ_STAT_4PORTS		= 0xf,
 };
 
-struct sil24_cmd_block {
+struct sil24_ata_block {
 	struct sil24_prb prb;
 	struct sil24_sge sge[LIBATA_MAX_PRD];
 };
 
+struct sil24_atapi_block {
+	struct sil24_prb prb;
+	u8 cdb[16];
+	struct sil24_sge sge[LIBATA_MAX_PRD - 1];
+};
+
+union sil24_cmd_block {
+	struct sil24_ata_block ata;
+	struct sil24_atapi_block atapi;
+};
+
 /*
  * ap->private_data
  *
@@ -233,7 +233,7 @@ struct sil24_cmd_block {
  * here from the previous interrupt.
  */
 struct sil24_port_priv {
-	struct sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
+	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
 	struct ata_taskfile tf;			/* Cached taskfile registers */
 };
@@ -244,6 +244,7 @@ struct sil24_host_priv {
 	void __iomem *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
 };
 
+static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u8 sil24_check_status(struct ata_port *ap);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
@@ -297,6 +298,8 @@ static struct scsi_host_template sil24_s
 static const struct ata_port_operations sil24_ops = {
 	.port_disable		= ata_port_disable,
 
+	.dev_config		= sil24_dev_config,
+
 	.check_status		= sil24_check_status,
 	.check_altstatus	= sil24_check_status,
 	.dev_select		= ata_noop_dev_select,
@@ -333,7 +336,7 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(4),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -344,7 +347,7 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(2),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -355,7 +358,7 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -364,6 +367,16 @@ static struct ata_port_info sil24_port_i
 	},
 };
 
+static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+
+	if (ap->cdb_len == 16)
+		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
+	else
+		writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
+}
+
 static inline void sil24_update_tf(struct ata_port *ap)
 {
 	struct sil24_port_priv *pp = ap->private_data;
@@ -415,22 +428,73 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
-static void sil24_phy_reset(struct ata_port *ap)
+static int sil24_issue_SRST(struct ata_port *ap)
 {
-	__sata_phy_reset(ap);
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
+	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
+	dma_addr_t paddr = pp->cmd_block_dma;
+	u32 irq_enable, irq_stat;
+	int cnt;
+
+	/* temporarily turn off IRQs during SRST */
+	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
+	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
+
 	/*
-	 * No ATAPI yet.  Just unconditionally indicate ATA device.
-	 * If ATAPI device is attached, it will fail ATA_CMD_ID_ATA
-	 * and libata core will ignore the device.
+	 * XXX: Not sure whether the following sleep is needed or not.
+	 * The original driver had it.  So....
 	 */
-	if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
-		ap->device[0].class = ATA_DEV_ATA;
+	msleep(10);
+
+	prb->ctrl = PRB_CTRL_SRST;
+	prb->fis[1] = 0; /* no PM yet */
+
+	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
+
+	for (cnt = 0; cnt < 100; cnt++) {
+		irq_stat = readl(port + PORT_IRQ_STAT);
+		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
+
+		irq_stat >>= PORT_IRQ_RAW_SHIFT;
+		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
+			break;
+
+		msleep(1);
+	}
+
+	/* restore IRQs */
+	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
+
+	if (!(irq_stat & PORT_IRQ_COMPLETE))
+		return -1;
+
+	/* update TF */
+	sil24_update_tf(ap);
+	return 0;
+}
+
+static void sil24_phy_reset(struct ata_port *ap)
+{
+	struct sil24_port_priv *pp = ap->private_data;
+
+	__sata_phy_reset(ap);
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	if (sil24_issue_SRST(ap) < 0) {
+		printk(KERN_ERR DRV_NAME
+		       " ata%u: SRST failed, disabling port\n", ap->id);
+		ap->ops->port_disable(ap);
+		return;
+	}
+
+	ap->device->class = ata_dev_classify(&pp->tf);
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
-				 struct sil24_cmd_block *cb)
+				 struct sil24_sge *sge)
 {
-	struct sil24_sge *sge = cb->sge;
 	struct scatterlist *sg;
 	unsigned int idx = 0;
 
@@ -451,23 +515,47 @@ static void sil24_qc_prep(struct ata_que
 {
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
-	struct sil24_cmd_block *cb = pp->cmd_block + qc->tag;
-	struct sil24_prb *prb = &cb->prb;
+	union sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+	struct sil24_prb *prb;
+	struct sil24_sge *sge;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_PIO:
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
+		prb = &cb->ata.prb;
+		sge = cb->ata.sge;
+		prb->ctrl = 0;
+		break;
+
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_DMA:
+	case ATA_PROT_ATAPI_NODATA:
+		prb = &cb->atapi.prb;
+		sge = cb->atapi.sge;
+		memset(cb->atapi.cdb, 0, 32);
+		memcpy(cb->atapi.cdb, qc->cdb, ap->cdb_len);
+
+		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
+			if (qc->tf.flags & ATA_TFLAG_WRITE)
+				prb->ctrl = PRB_CTRL_PACKET_WRITE;
+			else
+				prb->ctrl = PRB_CTRL_PACKET_READ;
+		} else
+			prb->ctrl = 0;
+
 		break;
+
 	default:
-		/* ATAPI isn't supported yet */
+		prb = NULL;	/* shut up, gcc */
+		sge = NULL;
 		BUG();
 	}
 
 	ata_tf_to_fis(&qc->tf, prb->fis, 0);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-		sil24_fill_sg(qc, cb);
+		sil24_fill_sg(qc, sge);
 }
 
 static int sil24_qc_issue(struct ata_queued_cmd *qc)
@@ -486,6 +574,31 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
+static int __sil24_restart_controller(void __iomem *port)
+{
+	u32 tmp;
+	int cnt;
+
+	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
+
+	/* Max ~10ms */
+	for (cnt = 0; cnt < 10000; cnt++) {
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (tmp & PORT_CS_RDY)
+			return 0;
+		udelay(1);
+	}
+
+	return -1;
+}
+
+static void sil24_restart_controller(struct ata_port *ap)
+{
+	if (__sil24_restart_controller((void __iomem *)ap->ioaddr.cmd_addr))
+		printk(KERN_ERR DRV_NAME
+		       " ata%u: failed to restart controller\n", ap->id);
+}
+
 static int __sil24_reset_controller(void __iomem *port)
 {
 	int cnt;
@@ -505,7 +618,11 @@ static int __sil24_reset_controller(void
 
 	if (tmp & PORT_CS_DEV_RST)
 		return -1;
-	return 0;
+
+	if (tmp & PORT_CS_RDY)
+		return 0;
+
+	return __sil24_restart_controller(port);
 }
 
 static void sil24_reset_controller(struct ata_port *ap)
@@ -567,9 +684,15 @@ static void sil24_error_intr(struct ata_
 	if (serror)
 		writel(serror, port + PORT_SERROR);
 
-	printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
-	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
-	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
+	/*
+	 * Don't log ATAPI device errors.  They're supposed to happen
+	 * and any serious errors will be logged using sense data by
+	 * the SCSI layer.
+	 */
+	if (ap->device[0].class != ATA_DEV_ATAPI || cmd_err > PORT_CERR_SDB)
+		printk("ata%u: error interrupt on port%d\n"
+		       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
+		       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
 
 	if (cmd_err == PORT_CERR_DEV || cmd_err == PORT_CERR_SDB) {
 		/*
@@ -577,6 +700,7 @@ static void sil24_error_intr(struct ata_
 		 */
 		sil24_update_tf(ap);
 		err_mask = ac_err_mask(pp->tf.command);
+		sil24_restart_controller(ap);
 	} else {
 		/*
 		 * Other errors.  libata currently doesn't have any
@@ -584,12 +708,11 @@ static void sil24_error_intr(struct ata_
 		 * ATA_ERR.
 		 */
 		err_mask = AC_ERR_OTHER;
+		sil24_reset_controller(ap);
 	}
 
 	if (qc)
 		ata_qc_complete(qc, err_mask);
-
-	sil24_reset_controller(ap);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
@@ -665,7 +788,7 @@ static int sil24_port_start(struct ata_p
 {
 	struct device *dev = ap->host_set->dev;
 	struct sil24_port_priv *pp;
-	struct sil24_cmd_block *cb;
+	union sil24_cmd_block *cb;
 	size_t cb_size = sizeof(*cb);
 	dma_addr_t cb_dma;
 	int rc = -ENOMEM;
