Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032144AbWLGMk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032144AbWLGMk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032142AbWLGMk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:40:58 -0500
Received: from havoc.gtf.org ([69.61.125.42]:59896 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032110AbWLGMk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:40:56 -0500
Date: Thu, 7 Dec 2006 07:40:55 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata updates
Message-ID: <20061207124055.GA8415@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/libata-core.c  |    3 +
 drivers/ata/sata_promise.c |  120 ++++++++++++++++++++++++++++----------------
 2 files changed, 79 insertions(+), 44 deletions(-)

Alan:
      libata: Incorrect timing computation for PIO5/6

Albert Lee:
      libata: let ATA_FLAG_PIO_POLLING use polling pio for ATA_PROT_NODATA

Mikael Pettersson:
      sata_promise: cleanups, take 2
      sata_promise: new EH conversion, take 2

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8816e30..011c0a8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2303,7 +2303,7 @@ int ata_timing_compute(struct ata_device
 	 * DMA cycle timing is slower/equal than the fastest PIO timing.
 	 */
 
-	if (speed > XFER_PIO_4) {
+	if (speed > XFER_PIO_6) {
 		ata_timing_compute(adev, adev->pio_mode, &p, T, UT);
 		ata_timing_merge(&p, t, t, ATA_TIMING_ALL);
 	}
@@ -4960,6 +4960,7 @@ unsigned int ata_qc_issue_prot(struct at
 	if (ap->flags & ATA_FLAG_PIO_POLLING) {
 		switch (qc->tf.protocol) {
 		case ATA_PROT_PIO:
+		case ATA_PROT_NODATA:
 		case ATA_PROT_ATAPI:
 		case ATA_PROT_ATAPI_NODATA:
 			qc->tf.flags |= ATA_TFLAG_POLLING;
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index a2778cf..f055874 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -66,15 +66,17 @@ enum {
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20619		= 2,	/* FastTrak TX4000 */
-	board_20771		= 3,	/* FastTrak TX2300 */
-	board_2057x		= 4,	/* SATAII150 Tx2plus */
-	board_40518		= 5,	/* SATAII150 Tx4 */
+	board_2057x		= 3,	/* SATAII150 Tx2plus */
+	board_40518		= 4,	/* SATAII150 Tx4 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
+	/* PDC_CTLSTAT bit definitions */
+	PDC_DMA_ENABLE		= (1 << 7),
+	PDC_IRQ_DISABLE		= (1 << 10),
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
-	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
 				  ATA_FLAG_PIO_POLLING,
 
@@ -90,7 +92,6 @@ struct pdc_port_priv {
 
 struct pdc_host_priv {
 	unsigned long		flags;
-	int			hotplug_offset;
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -101,13 +102,16 @@ static void pdc_eng_timeout(struct ata_p
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
@@ -136,11 +140,12 @@ static const struct ata_port_operations 
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
@@ -198,23 +203,13 @@ static const struct ata_port_info pdc_po
 	/* board_20619 */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_pata_ops,
 	},
 
-	/* board_20771 */
-	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
-	},
-
 	/* board_2057x */
 	{
 		.sht		= &pdc_ata_sht,
@@ -244,6 +239,7 @@ static const struct pci_device_id pdc_at
 	{ PCI_VDEVICE(PROMISE, 0x3570), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3571), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3574), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3577), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3d73), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3d75), board_2057x },
 
@@ -256,15 +252,6 @@ static const struct pci_device_id pdc_at
 
 	{ PCI_VDEVICE(PROMISE, 0x6629), board_20619 },
 
-/* TODO: remove all associated board_20771 code, as it completely
- * duplicates board_2037x code, unless reason for separation can be
- * divined.
- */
-#if 0
-	{ PCI_VDEVICE(PROMISE, 0x3570), board_20771 },
-#endif
-	{ PCI_VDEVICE(PROMISE, 0x3577), board_20771 },
-
 	{ }	/* terminate list */
 };
 
@@ -366,12 +353,6 @@ static void pdc_reset_port(struct ata_po
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
@@ -439,6 +420,61 @@ static void pdc_qc_prep(struct ata_queue
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
@@ -645,9 +681,14 @@ static void pdc_host_init(unsigned int c
 {
 	void __iomem *mmio = pe->mmio_base;
 	struct pdc_host_priv *hp = pe->private_data;
-	int hotplug_offset = hp->hotplug_offset;
+	int hotplug_offset;
 	u32 tmp;
 
+	if (hp->flags & PDC_FLAG_GEN_II)
+		hotplug_offset = PDC2_SATA_PLUG_CSR;
+	else
+		hotplug_offset = PDC_SATA_PLUG_CSR;
+
 	/*
 	 * Except for the hotplug stuff, this is voodoo from the
 	 * Promise driver.  Label this entire section
@@ -742,8 +783,6 @@ static int pdc_ata_init_one (struct pci_
 		goto err_out_free_ent;
 	}
 
-	/* Set default hotplug offset */
-	hp->hotplug_offset = PDC_SATA_PLUG_CSR;
 	probe_ent->private_data = hp;
 
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
@@ -767,8 +806,6 @@ static int pdc_ata_init_one (struct pci_
 	switch (board_idx) {
 	case board_40518:
 		hp->flags |= PDC_FLAG_GEN_II;
-		/* Override hotplug offset for SATAII150 */
-		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
 	case board_20319:
        		probe_ent->n_ports = 4;
@@ -780,10 +817,7 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
 	case board_2057x:
-	case board_20771:
 		hp->flags |= PDC_FLAG_GEN_II;
-		/* Override hotplug offset for SATAII150 */
-		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
 	case board_2037x:
 		probe_ent->n_ports = 2;
