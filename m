Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757964AbWKZUVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964AbWKZUVM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757961AbWKZUVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:21:12 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41941 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1757962AbWKZUVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:21:10 -0500
Date: Sun, 26 Nov 2006 14:20:19 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Nicolas.Mailhot@LaPoste.net
Message-id: <4569F703.8010209@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------090209050809030107040107
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209050809030107040107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch against 2.6.19-rc6-mm1 fixes some problems in sata_nv 
with ATAPI devices on controllers running in ADMA mode. Some of the 
logic in the nv_adma_bmdma_* functions was inverted causing a bunch of 
warnings and caused those functions not to work properly. Also, when an 
ATAPI device is connected, we need to use the legacy DMA engine. The 
code now disables the PCI configuration register bits for ADMA so that 
this works, and ensures that no ATAPI DMA commands go through until this 
is done.

Fixes Bugzilla http://bugzilla.kernel.org/show_bug.cgi?id=7538

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

--------------090209050809030107040107
Content-Type: text/plain;
 name="sata_nv-fix-atapi-in-adma-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv-fix-atapi-in-adma-mode.patch"

--- linux-2.6.19-rc6-mm1/drivers/ata/sata_nv.c	2006-11-25 10:04:14.000000000 -0600
+++ linux-2.6.19-rc6-mm1-admafix/drivers/ata/sata_nv.c	2006-11-25 21:06:24.000000000 -0600
@@ -49,7 +49,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"3.1"
+#define DRV_VERSION			"3.2"
 
 #define NV_ADMA_DMA_BOUNDARY		0xffffffffUL
 
@@ -165,6 +165,7 @@ enum {
 
 	/* port flags */
 	NV_ADMA_PORT_REGISTER_MODE	= (1 << 0),
+	NV_ADMA_ATAPI_SETUP_COMPLETE	= (1 << 1),
 
 };
 
@@ -231,6 +232,7 @@ static void nv_ck804_freeze(struct ata_p
 static void nv_ck804_thaw(struct ata_port *ap);
 static void nv_error_handler(struct ata_port *ap);
 static int nv_adma_slave_config(struct scsi_device *sdev);
+static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance);
@@ -415,6 +417,7 @@ static const struct ata_port_operations 
 	.port_disable		= ata_port_disable,
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
+	.check_atapi_dma	= nv_adma_check_atapi_dma,
 	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
@@ -489,13 +492,71 @@ MODULE_VERSION(DRV_VERSION);
 
 static int adma_enabled = 1;
 
+static inline void __iomem *__nv_adma_ctl_block(void __iomem *mmio,
+					        unsigned int port_no)
+{
+	mmio += NV_ADMA_PORT + port_no * NV_ADMA_PORT_SIZE;
+	return mmio;
+}
+
+static inline void __iomem *nv_adma_ctl_block(struct ata_port *ap)
+{
+	return __nv_adma_ctl_block(ap->host->mmio_base, ap->port_no);
+}
+
+static inline void __iomem *nv_adma_gen_block(struct ata_port *ap)
+{
+	return (ap->host->mmio_base + NV_ADMA_GEN);
+}
+
+static inline void __iomem *nv_adma_notifier_clear_block(struct ata_port *ap)
+{
+	return (nv_adma_gen_block(ap) + NV_ADMA_NOTIFIER_CLEAR + (4 * ap->port_no));
+}
+
+static void nv_adma_register_mode(struct ata_port *ap)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u16 tmp;
+
+	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
+		return;
+
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+
+	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
+}
+
+static void nv_adma_mode(struct ata_port *ap)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u16 tmp;
+
+	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
+		return;
+		
+	WARN_ON(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE);
+
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp | NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+
+	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
+}
+
 static int nv_adma_slave_config(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u64 bounce_limit;
 	unsigned long segment_boundary;
 	unsigned short sg_tablesize;
 	int rc;
+	int adma_enable;
+	u32 current_reg, new_reg, config_mask;
 
 	rc = ata_scsi_slave_config(sdev);
 
@@ -516,13 +577,40 @@ static int nv_adma_slave_config(struct s
 		/* Subtract 1 since an extra entry may be needed for padding, see
 		   libata-scsi.c */
 		sg_tablesize = LIBATA_MAX_PRD - 1;
+		
+		/* Since the legacy DMA engine is in use, we need to disable ADMA
+		   on the port. */
+		adma_enable = 0;
+		nv_adma_register_mode(ap);
 	}
 	else {
 		bounce_limit = *ap->dev->dma_mask;
 		segment_boundary = NV_ADMA_DMA_BOUNDARY;
 		sg_tablesize = NV_ADMA_SGTBL_TOTAL_LEN;
+		adma_enable = 1;
 	}
+	
+	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &current_reg);
 
+	if(ap->port_no == 1)
+		config_mask = NV_MCP_SATA_CFG_20_PORT1_EN |
+			      NV_MCP_SATA_CFG_20_PORT1_PWB_EN;
+	else
+		config_mask = NV_MCP_SATA_CFG_20_PORT0_EN |
+			      NV_MCP_SATA_CFG_20_PORT0_PWB_EN;
+	
+	if(adma_enable) {
+		new_reg = current_reg | config_mask;
+		pp->flags &= ~NV_ADMA_ATAPI_SETUP_COMPLETE;
+	}
+	else {
+		new_reg = current_reg & ~config_mask;
+		pp->flags |= NV_ADMA_ATAPI_SETUP_COMPLETE;
+	}
+	
+	if(current_reg != new_reg)
+		pci_write_config_dword(pdev, NV_MCP_SATA_CFG_20, new_reg);
+	
 	blk_queue_bounce_limit(sdev->request_queue, bounce_limit);
 	blk_queue_segment_boundary(sdev->request_queue, segment_boundary);
 	blk_queue_max_hw_segments(sdev->request_queue, sg_tablesize);
@@ -532,7 +620,13 @@ static int nv_adma_slave_config(struct s
 	return rc;
 }
 
-static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, u16 *cpb)
+static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	struct nv_adma_port_priv *pp = qc->ap->private_data;
+	return !(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE);
+}
+
+static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, __le16 *cpb)
 {
 	unsigned int idx = 0;
 
@@ -563,33 +657,11 @@ static unsigned int nv_adma_tf_to_cpb(st
 	return idx;
 }
 
-static inline void __iomem *__nv_adma_ctl_block(void __iomem *mmio,
-					        unsigned int port_no)
-{
-	mmio += NV_ADMA_PORT + port_no * NV_ADMA_PORT_SIZE;
-	return mmio;
-}
-
-static inline void __iomem *nv_adma_ctl_block(struct ata_port *ap)
-{
-	return __nv_adma_ctl_block(ap->host->mmio_base, ap->port_no);
-}
-
-static inline void __iomem *nv_adma_gen_block(struct ata_port *ap)
-{
-	return (ap->host->mmio_base + NV_ADMA_GEN);
-}
-
-static inline void __iomem *nv_adma_notifier_clear_block(struct ata_port *ap)
-{
-	return (nv_adma_gen_block(ap) + NV_ADMA_NOTIFIER_CLEAR + (4 * ap->port_no));
-}
-
 static void nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
 	int complete = 0, have_err = 0;
-	u16 flags = pp->cpb[cpb_num].resp_flags;
+	u8 flags = pp->cpb[cpb_num].resp_flags;
 
 	VPRINTK("CPB %d, flags=0x%x\n", cpb_num, flags);
 
@@ -634,15 +706,48 @@ static void nv_adma_check_cpb(struct ata
 	}
 }
 
+static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	int handled;
+
+	/* freeze if hotplugged */
+	if (unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
+		ata_port_freeze(ap);
+		return 1;
+	}
+
+	/* bail out if not our interrupt */
+	if (!(irq_stat & NV_INT_DEV))
+		return 0;
+
+	/* DEV interrupt w/ no active qc? */
+	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
+		ata_check_status(ap);
+		return 1;
+	}
+
+	/* handle interrupt */
+	handled = ata_host_intr(ap, qc);
+	if (unlikely(!handled)) {
+		/* spurious, clear it */
+		ata_check_status(ap);
+	}
+
+	return 1;
+}
+
 static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
 	int i, handled = 0;
+	u32 notifier_clears[2];
 
 	spin_lock(&host->lock);
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		notifier_clears[i] = 0;
 
 		if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct nv_adma_port_priv *pp = ap->private_data;
@@ -654,30 +759,18 @@ static irqreturn_t nv_adma_interrupt(int
 
 			/* if in ATA register mode, use standard ata interrupt handler */
 			if (pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
-				struct ata_queued_cmd *qc;
-				VPRINTK("in ATA register mode\n");
-				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
-					handled += ata_host_intr(ap, qc);
-				else {
-					/* No request pending?  Clear interrupt status
-					   anyway, in case there's one pending. */
-					ap->ops->check_status(ap);
-					handled++;
-				}
+				u8 irq_stat = readb(host->mmio_base + NV_INT_STATUS_CK804)
+					>> (NV_INT_PORT_SHIFT * i);
+				handled += nv_host_intr(ap, irq_stat);
 				continue;
 			}
 
 			notifier = readl(mmio + NV_ADMA_NOTIFIER);
 			notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
+			notifier_clears[i] = notifier | notifier_error;
 
 			gen_ctl = readl(nv_adma_gen_block(ap) + NV_ADMA_GEN_CTL);
 
-			/* Seems necessary to clear notifiers even when they were 0.
-			   Otherwise we seem to stop receiving further interrupts.
-			   Unsure why. */
-			writel(notifier | notifier_error, nv_adma_notifier_clear_block(ap));
-
 			if( !NV_ADMA_CHECK_INTR(gen_ctl, ap->port_no) && !notifier &&
 			    !notifier_error)
 				/* Nothing to do */
@@ -730,6 +823,15 @@ static irqreturn_t nv_adma_interrupt(int
 			handled++; /* irq handled if we got here */
 		}
 	}
+	
+	if(notifier_clears[0] || notifier_clears[1]) {
+		/* Note: Both notifier clear registers must be written
+		   if either is set, even if one is zero, according to NVIDIA. */
+		writel(notifier_clears[0], 
+			nv_adma_notifier_clear_block(host->ports[0]));
+		writel(notifier_clears[1], 
+			nv_adma_notifier_clear_block(host->ports[1]));
+	}
 
 	spin_unlock(&host->lock);
 
@@ -742,6 +844,7 @@ static void nv_adma_irq_clear(struct ata
 	u16 status = readw(mmio + NV_ADMA_STAT);
 	u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
 	u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
+	unsigned long dma_stat_addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
 
 	/* clear ADMA status */
 	writew(status, mmio + NV_ADMA_STAT);
@@ -749,92 +852,76 @@ static void nv_adma_irq_clear(struct ata
 	       nv_adma_notifier_clear_block(ap));
 
 	/** clear legacy status */
-	ap->flags &= ~ATA_FLAG_MMIO;
-	ata_bmdma_irq_clear(ap);
-	ap->flags |= ATA_FLAG_MMIO;
+	outb(inb(dma_stat_addr), dma_stat_addr);
 }
 
 static void nv_adma_bmdma_setup(struct ata_queued_cmd *qc)
 {
-	struct nv_adma_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u8 dmactl;
 
-	if(pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
+	if(!(pp->flags & NV_ADMA_PORT_REGISTER_MODE)) {
 		WARN_ON(1);
 		return;
 	}
 
-	qc->ap->flags &= ~ATA_FLAG_MMIO;
-	ata_bmdma_setup(qc);
-	qc->ap->flags |= ATA_FLAG_MMIO;
+	/* load PRD table addr. */
+	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+
+	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* issue r/w command */
+	ata_exec_command(ap, &qc->tf);
 }
 
 static void nv_adma_bmdma_start(struct ata_queued_cmd *qc)
 {
-	struct nv_adma_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u8 dmactl;
 
-	if(pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
+	if(!(pp->flags & NV_ADMA_PORT_REGISTER_MODE)) {
 		WARN_ON(1);
 		return;
 	}
 
-	qc->ap->flags &= ~ATA_FLAG_MMIO;
-	ata_bmdma_start(qc);
-	qc->ap->flags |= ATA_FLAG_MMIO;
+	/* start host DMA transaction */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	outb(dmactl | ATA_DMA_START,
+	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
 static void nv_adma_bmdma_stop(struct ata_queued_cmd *qc)
 {
-	struct nv_adma_port_priv *pp = qc->ap->private_data;
-
-	if(pp->flags & NV_ADMA_PORT_REGISTER_MODE)
-		return;
-
-	qc->ap->flags &= ~ATA_FLAG_MMIO;
-	ata_bmdma_stop(qc);
-	qc->ap->flags |= ATA_FLAG_MMIO;
-}
-
-static u8 nv_adma_bmdma_status(struct ata_port *ap)
-{
-	u8 status;
-	struct nv_adma_port_priv *pp = ap->private_data;
-
-	WARN_ON(pp->flags & NV_ADMA_PORT_REGISTER_MODE);
-
-	ap->flags &= ~ATA_FLAG_MMIO;
-	status = ata_bmdma_status(ap);
-	ap->flags |= ATA_FLAG_MMIO;
-	return status;
-}
-
-static void nv_adma_register_mode(struct ata_port *ap)
-{
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct ata_port *ap = qc->ap;
 	struct nv_adma_port_priv *pp = ap->private_data;
-	u16 tmp;
 
-	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
+	if(!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
 		return;
 
-	tmp = readw(mmio + NV_ADMA_CTL);
-	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+	/* clear start/stop bit */
+	outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+		ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
-	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);        /* dummy read */
 }
 
-static void nv_adma_mode(struct ata_port *ap)
+static u8 nv_adma_bmdma_status(struct ata_port *ap)
 {
-	void __iomem *mmio = nv_adma_ctl_block(ap);
 	struct nv_adma_port_priv *pp = ap->private_data;
-	u16 tmp;
-
-	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
-		return;
 
-	tmp = readw(mmio + NV_ADMA_CTL);
-	writew(tmp | NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+	WARN_ON(!(pp->flags & NV_ADMA_PORT_REGISTER_MODE));
 
-	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
+	return inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 }
 
 static int nv_adma_port_start(struct ata_port *ap)
@@ -997,7 +1084,7 @@ static void nv_adma_fill_aprd(struct ata
 			      int idx,
 			      struct nv_adma_prd *aprd)
 {
-	u32 flags;
+	u8 flags;
 
 	memset(aprd, 0, sizeof(struct nv_adma_prd));
 
@@ -1011,7 +1098,7 @@ static void nv_adma_fill_aprd(struct ata
 
 	aprd->addr  = cpu_to_le64(((u64)sg_dma_address(sg)));
 	aprd->len   = cpu_to_le32(((u32)sg_dma_len(sg))); /* len in bytes */
-	aprd->flags = cpu_to_le32(flags);
+	aprd->flags = flags;
 }
 
 static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
@@ -1045,7 +1132,8 @@ static void nv_adma_qc_prep(struct ata_q
 	VPRINTK("qc->flags = 0x%lx\n", qc->flags);
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP) ||
-	     qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+	     (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
+		nv_adma_register_mode(qc->ap);
 		ata_qc_prep(qc);
 		return;
 	}
@@ -1072,12 +1160,13 @@ static void nv_adma_qc_prep(struct ata_q
 
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 {
+	struct nv_adma_port_priv *pp = qc->ap->private_data;
 	void __iomem *mmio = nv_adma_ctl_block(qc->ap);
 
 	VPRINTK("ENTER\n");
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP) ||
-	     qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+	     (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
 		/* use ATA register mode */
 		VPRINTK("no dmamap or ATAPI, using ATA register mode: 0x%lx\n", qc->flags);
 		nv_adma_register_mode(qc->ap);
@@ -1128,37 +1217,6 @@ static irqreturn_t nv_generic_interrupt(
 	return IRQ_RETVAL(handled);
 }
 
-static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
-{
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	int handled;
-
-	/* freeze if hotplugged */
-	if (unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
-		ata_port_freeze(ap);
-		return 1;
-	}
-
-	/* bail out if not our interrupt */
-	if (!(irq_stat & NV_INT_DEV))
-		return 0;
-
-	/* DEV interrupt w/ no active qc? */
-	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
-		ata_check_status(ap);
-		return 1;
-	}
-
-	/* handle interrupt */
-	handled = ata_host_intr(ap, qc);
-	if (unlikely(!handled)) {
-		/* spurious, clear it */
-		ata_check_status(ap);
-	}
-
-	return 1;
-}
-
 static irqreturn_t nv_do_interrupt(struct ata_host *host, u8 irq_stat)
 {
 	int i, handled = 0;

--------------090209050809030107040107--

