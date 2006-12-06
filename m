Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937770AbWLFXHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937770AbWLFXHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937756AbWLFXHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:07:06 -0500
Received: from aun.it.uu.se ([130.238.12.36]:44280 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937770AbWLFXHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:07:03 -0500
Date: Thu, 7 Dec 2006 00:06:51 +0100 (MET)
Message-Id: <200612062306.kB6N6p0t009272@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.19-git7] sata_promise: new EH conversion, take 2
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts sata_promise to use new-style libata error
handling on Promise SATA chips, for both SATA and PATA ports.

* ATA_FLAG_SRST is no longer set
* ->phy_reset is no longer set as it is unused when ->error_handler
   is present, and pdc_sata_phy_reset() has been removed
* pdc_freeze() masks interrupts and halts DMA via PDC_CTLSTAT
* pdc_thaw() clears interrupt status in PDC_INT_SEQMASK and then
  unmasks interrupts in PDC_CTLSTAT
* pdc_error_handler() reinitialises the port if it isn't frozen,
  and then invokes ata_do_eh() with standard {s,}ata reset methods
* pdc_post_internal_cmd() resets the port in case of errors
* the PATA-only 20619 chip continues to use old-style EH:
  not by necessity but simply because I don't have documentation
  for it or any way to test it

Since the previous version pdc_error_handler() has been rewritten
and it now mostly matches ahci and sata_sil24. In case anyone
wonders: the call to pdc_reset_port() isn't a heavy-duty reset,
it's a light-weight reset to quickly put a port into a sane state.

The discussion about the PCI flushes in pdc_freeze() and pdc_thaw()
seemed to end with a consensus that the flushes are OK and not
obviously redundant, so I decided to keep them for now.

This patch was prepared against 2.6.19-git7, but it also applies
to 2.6.19 + libata #upstream, with or without the revised sata_promise
cleanup patch I recently submitted.

This patch does conflict with the #promise-sata-pata patch:
this patch removes pdc_sata_phy_reset() while #promise-sata-pata
modifies it. The correct patch resolution is to remove the function.

Tested on 2037x and 2057x chips, with PATA patches on top and disks
on both SATA and PATA ports.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.19-git7/drivers/ata/sata_promise.c.~1~	2006-12-06 23:29:14.000000000 +0100
+++ linux-2.6.19-git7/drivers/ata/sata_promise.c	2006-12-06 23:29:43.000000000 +0100
@@ -72,9 +72,12 @@ enum {
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
+	/* PDC_CTLSTAT bit definitions */
+	PDC_DMA_ENABLE		= (1 << 7),
+	PDC_IRQ_DISABLE		= (1 << 10),
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
-	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
 				  ATA_FLAG_PIO_POLLING,
 
@@ -101,13 +104,16 @@ static void pdc_eng_timeout(struct ata_p
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
@@ -136,11 +142,12 @@ static const struct ata_port_operations 
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
@@ -198,7 +205,7 @@ static const struct ata_port_info pdc_po
 	/* board_20619 */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -366,12 +373,6 @@ static void pdc_reset_port(struct ata_po
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
@@ -439,6 +440,61 @@ static void pdc_qc_prep(struct ata_queue
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
+	readl(mmio + PDC_CTLSTAT); /* flush */
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
+	readl(mmio + PDC_CTLSTAT); /* flush */
+}
+
+static void pdc_error_handler(struct ata_port *ap)
+{
+	ata_reset_fn_t hardreset;
+
+	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+		pdc_reset_port(ap);
+
+	hardreset = NULL;
+	if (sata_scr_valid(ap))
+		hardreset = sata_std_hardreset;
+
+	/* perform recovery */
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
