Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933283AbWLAJ61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbWLAJ61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759304AbWLAJ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:58:27 -0500
Received: from aun.it.uu.se ([130.238.12.36]:26803 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1759303AbWLAJ6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:58:25 -0500
Date: Fri, 1 Dec 2006 10:58:16 +0100 (MET)
Message-Id: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts sata_promise to use new-style libata error
handling for its SATA ports. PATA is left unchanged.

* ATA_FLAG_SRST is no longer set for SATA ports
* ->phy_reset is no longer set as it is unused when ->error_handler
   is present, and pdc_sata_phy_reset() has been removed
* pdc_freeze() masks interrupts and halts DMA via PDC_CTLSTAT
* pdc_thaw() clears interrupt status in PDC_INT_SEQMASK and then
  unmasks interrupts in PDC_CTLSTAT
* pdc_error_handler() simply freezes the port and then invokes
  ata_do_eh() with standard {s,}ata reset methods
* pdc_post_internal_cmd() resets the port in case of errors

The changes are primarily modelled after ahci and sata_sil24.

These changes have been tested on Promise SATAII (205xx) chips.
I strongly believe they should work on SATAI chips as well, and
probably also on PATA chips (20619) and ports. However, since I
have no documentation for the PATA-only 20619, I let the driver
continue using old-style EH for it (easily changed).

This patch is intended to be applied on top of the sata_promise
SATAII updates patch I sent recently, but will apply and work
even if that patch has not been applied.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

diff -rupN linux-2.6.19.sata_promise-2-PHYMODE4-fixup/drivers/ata/sata_promise.c linux-2.6.19.sata_promise-3-new_EH/drivers/ata/sata_promise.c
--- linux-2.6.19.sata_promise-2-PHYMODE4-fixup/drivers/ata/sata_promise.c	2006-11-30 23:36:57.000000000 +0100
+++ linux-2.6.19.sata_promise-3-new_EH/drivers/ata/sata_promise.c	2006-11-30 23:56:32.000000000 +0100
@@ -73,9 +73,12 @@ enum {
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
+	/* PDC_CTLSTAT bit definitions */
+	PDC_DMA_ENABLE		= (1 << 7),
+	PDC_IRQ_DISABLE		= (1 << 10),
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
-	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
 				  ATA_FLAG_PIO_POLLING,
 
@@ -102,13 +105,16 @@ static void pdc_eng_timeout(struct ata_p
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
 static void pdc_pata_phy_reset(struct ata_port *ap);
-static void pdc_sata_phy_reset(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 static void pdc_host_stop(struct ata_host *host);
+static void pdc_freeze(struct ata_port *ap);
+static void pdc_thaw(struct ata_port *ap);
+static void pdc_error_handler(struct ata_port *ap);
+static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_ata_sht = {
@@ -137,11 +143,12 @@ static const struct ata_port_operations 
 	.exec_command		= pdc_exec_command_mmio,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= pdc_sata_phy_reset,
-
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.eng_timeout		= pdc_eng_timeout,
+	.freeze			= pdc_freeze,
+	.thaw			= pdc_thaw,
+	.error_handler		= pdc_error_handler,
+	.post_internal_cmd	= pdc_post_internal_cmd,
 	.data_xfer		= ata_mmio_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
@@ -199,7 +206,7 @@ static const struct ata_port_info pdc_po
 	/* board_20619 */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -367,12 +374,6 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
-static void pdc_sata_phy_reset(struct ata_port *ap)
-{
-	pdc_reset_port(ap);
-	sata_phy_reset(ap);
-}
-
 static void pdc_pata_cbl_detect(struct ata_port *ap)
 {
 	u8 tmp;
@@ -440,6 +441,63 @@ static void pdc_qc_prep(struct ata_queue
 	}
 }
 
+static void pdc_freeze(struct ata_port *ap)
+{
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	tmp = readl(mmio + PDC_CTLSTAT);
+	tmp |= PDC_IRQ_DISABLE;
+	tmp &= ~PDC_DMA_ENABLE;
+	writel(tmp, mmio + PDC_CTLSTAT);
+	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil does this */
+}
+
+static void pdc_thaw(struct ata_port *ap)
+{
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	/* clear IRQ */
+	readl(mmio + PDC_INT_SEQMASK);
+
+	/* turn IRQ back on */
+	tmp = readl(mmio + PDC_CTLSTAT);
+	tmp &= ~PDC_IRQ_DISABLE;
+	writel(tmp, mmio + PDC_CTLSTAT);
+	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */
+}
+
+static void pdc_error_handler(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	ata_reset_fn_t hardreset;
+
+	/* stop DMA, mask IRQ, don't clobber anything else */
+	ata_eh_freeze_port(ap);
+
+	hardreset = NULL;
+	if (sata_scr_valid(ap)) {
+		ehc->i.action |= ATA_EH_HARDRESET;
+		hardreset = sata_std_hardreset;
+	}
+
+	ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
+		  ata_std_postreset);
+}
+
+static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		qc->err_mask |= AC_ERR_OTHER;
+
+	/* make DMA engine forget about the failed command */
+	if (qc->err_mask)
+		pdc_reset_port(ap);
+}
+
 static void pdc_eng_timeout(struct ata_port *ap)
 {
 	struct ata_host *host = ap->host;
