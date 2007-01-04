Return-Path: <linux-kernel-owner+w=401wt.eu-S932187AbXADARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbXADARI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXADARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:17:08 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45871 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbXADARF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:17:05 -0500
Date: Wed, 03 Jan 2007 18:13:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH] sata_nv: add suspend/resume support v3 (Resubmit)
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>
Message-id: <459C46C5.5050407@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thoughts from Jeff & company on merging the patch below into libata-dev? 
This has been in the -mm tree for over a month now, I haven't heard any 
complaints about regressions..

---

From: Robert Hancock <hancockr@shaw.ca>

This patch adds the necessary callbacks to support suspend/resume properly
in sata_nv.  Most of the controllers don't need any specific handling but
CK804/MCP04 controllers, whether ADMA is enabled or not, need some
additional setup on resume.

As well as the additional storage of the controller type needed for proper
resume handling, this also removes the inline helper functions for getting
ADMA register locations by storing the pointers so we don't have to keep
calculating them all the time.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/sata_nv.c |  225 ++++++++++++++++++++++++++++------------
 1 file changed, 161 insertions(+), 64 deletions(-)

diff -puN drivers/ata/sata_nv.c~sata_nv-add-suspend-resume-support drivers/ata/sata_nv.c
--- a/drivers/ata/sata_nv.c~sata_nv-add-suspend-resume-support
+++ a/drivers/ata/sata_nv.c
@@ -49,7 +49,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"3.2"
+#define DRV_VERSION			"3.3"
 
 #define NV_ADMA_DMA_BOUNDARY		0xffffffffUL
 
@@ -213,12 +213,21 @@ struct nv_adma_port_priv {
 	dma_addr_t		cpb_dma;
 	struct nv_adma_prd	*aprd;
 	dma_addr_t		aprd_dma;
+	void __iomem *		ctl_block;
+	void __iomem *		gen_block;
+	void __iomem *		notifier_clear_block;
 	u8			flags;
 };
 
+struct nv_host_priv {
+	unsigned long		type;
+};
+
 #define NV_ADMA_CHECK_INTR(GCTL, PORT) ((GCTL) & ( 1 << (19 + (12 * (PORT)))))
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void nv_remove_one (struct pci_dev *pdev);
+static int nv_pci_device_resume(struct pci_dev *pdev);
 static void nv_ck804_host_stop(struct ata_host *host);
 static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance);
 static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance);
@@ -239,6 +248,8 @@ static irqreturn_t nv_adma_interrupt(int
 static void nv_adma_irq_clear(struct ata_port *ap);
 static int nv_adma_port_start(struct ata_port *ap);
 static void nv_adma_port_stop(struct ata_port *ap);
+static int nv_adma_port_suspend(struct ata_port *ap, pm_message_t mesg);
+static int nv_adma_port_resume(struct ata_port *ap);
 static void nv_adma_error_handler(struct ata_port *ap);
 static void nv_adma_host_stop(struct ata_host *host);
 static void nv_adma_bmdma_setup(struct ata_queued_cmd *qc);
@@ -284,7 +295,9 @@ static struct pci_driver nv_pci_driver =
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
-	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= nv_pci_device_resume,
+	.remove			= nv_remove_one,
 };
 
 static struct scsi_host_template nv_sht = {
@@ -303,6 +316,8 @@ static struct scsi_host_template nv_sht 
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static struct scsi_host_template nv_adma_sht = {
@@ -321,6 +336,8 @@ static struct scsi_host_template nv_adma
 	.slave_configure	= nv_adma_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations nv_generic_ops = {
@@ -429,6 +446,8 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= nv_adma_port_start,
 	.port_stop		= nv_adma_port_stop,
+	.port_suspend		= nv_adma_port_suspend,
+	.port_resume		= nv_adma_port_resume,
 	.host_stop		= nv_adma_host_stop,
 };
 
@@ -467,6 +486,7 @@ static struct ata_port_info nv_port_info
 	{
 		.sht		= &nv_adma_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME |
 				  ATA_FLAG_MMIO | ATA_FLAG_NCQ,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -483,32 +503,10 @@ MODULE_VERSION(DRV_VERSION);
 
 static int adma_enabled = 1;
 
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
 static void nv_adma_register_mode(struct ata_port *ap)
 {
-	void __iomem *mmio = nv_adma_ctl_block(ap);
 	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
 	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
@@ -522,8 +520,8 @@ static void nv_adma_register_mode(struct
 
 static void nv_adma_mode(struct ata_port *ap)
 {
-	void __iomem *mmio = nv_adma_ctl_block(ap);
 	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
 	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
@@ -684,7 +682,7 @@ static void nv_adma_check_cpb(struct ata
 			   For NCQ commands the current status may have nothing to do with
 			   the command just completed. */
 			if(qc->tf.protocol != ATA_PROT_NCQ)
-				ata_status = readb(nv_adma_ctl_block(ap) + (ATA_REG_STATUS * 4));
+				ata_status = readb(pp->ctl_block + (ATA_REG_STATUS * 4));
 
 			if(have_err || force_err)
 				ata_status |= ATA_ERR;
@@ -742,7 +740,7 @@ static irqreturn_t nv_adma_interrupt(int
 
 		if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct nv_adma_port_priv *pp = ap->private_data;
-			void __iomem *mmio = nv_adma_ctl_block(ap);
+			void __iomem *mmio = pp->ctl_block;
 			u16 status;
 			u32 gen_ctl;
 			int have_global_err = 0;
@@ -760,7 +758,7 @@ static irqreturn_t nv_adma_interrupt(int
 			notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
 			notifier_clears[i] = notifier | notifier_error;
 
-			gen_ctl = readl(nv_adma_gen_block(ap) + NV_ADMA_GEN_CTL);
+			gen_ctl = readl(pp->gen_block + NV_ADMA_GEN_CTL);
 
 			if( !NV_ADMA_CHECK_INTR(gen_ctl, ap->port_no) && !notifier &&
 			    !notifier_error)
@@ -818,10 +816,10 @@ static irqreturn_t nv_adma_interrupt(int
 	if(notifier_clears[0] || notifier_clears[1]) {
 		/* Note: Both notifier clear registers must be written
 		   if either is set, even if one is zero, according to NVIDIA. */
-		writel(notifier_clears[0],
-			nv_adma_notifier_clear_block(host->ports[0]));
-		writel(notifier_clears[1],
-			nv_adma_notifier_clear_block(host->ports[1]));
+		struct nv_adma_port_priv *pp = host->ports[0]->private_data;
+		writel(notifier_clears[0], pp->notifier_clear_block);
+		pp = host->ports[1]->private_data;
+		writel(notifier_clears[1], pp->notifier_clear_block);
 	}
 
 	spin_unlock(&host->lock);
@@ -831,7 +829,8 @@ static irqreturn_t nv_adma_interrupt(int
 
 static void nv_adma_irq_clear(struct ata_port *ap)
 {
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
 	u16 status = readw(mmio + NV_ADMA_STAT);
 	u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
 	u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
@@ -840,7 +839,7 @@ static void nv_adma_irq_clear(struct ata
 	/* clear ADMA status */
 	writew(status, mmio + NV_ADMA_STAT);
 	writel(notifier | notifier_error,
-	       nv_adma_notifier_clear_block(ap));
+	       pp->notifier_clear_block);
 
 	/** clear legacy status */
 	outb(inb(dma_stat_addr), dma_stat_addr);
@@ -922,7 +921,7 @@ static int nv_adma_port_start(struct ata
 	int rc;
 	void *mem;
 	dma_addr_t mem_dma;
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	void __iomem *mmio;
 	u16 tmp;
 
 	VPRINTK("ENTER\n");
@@ -937,6 +936,13 @@ static int nv_adma_port_start(struct ata
 		goto err_out;
 	}
 
+	mmio = ap->host->mmio_base + NV_ADMA_PORT +
+	       ap->port_no * NV_ADMA_PORT_SIZE;
+	pp->ctl_block = mmio;
+	pp->gen_block = ap->host->mmio_base + NV_ADMA_GEN;
+	pp->notifier_clear_block = pp->gen_block +
+	       NV_ADMA_NOTIFIER_CLEAR + (4 * ap->port_no);
+
 	mem = dma_alloc_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ,
 				 &mem_dma, GFP_KERNEL);
 
@@ -977,9 +983,9 @@ static int nv_adma_port_start(struct ata
 	/* clear CPB fetch count */
 	writew(0, mmio + NV_ADMA_CPB_COUNT);
 
-	/* clear GO for register mode */
+	/* clear GO for register mode, enable interrupt */
 	tmp = readw(mmio + NV_ADMA_CTL);
-	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+	writew( (tmp & ~NV_ADMA_CTL_GO) | NV_ADMA_CTL_AIEN, mmio + NV_ADMA_CTL);
 
 	tmp = readw(mmio + NV_ADMA_CTL);
 	writew(tmp | NV_ADMA_CTL_CHANNEL_RESET, mmio + NV_ADMA_CTL);
@@ -1001,7 +1007,7 @@ static void nv_adma_port_stop(struct ata
 {
 	struct device *dev = ap->host->dev;
 	struct nv_adma_port_priv *pp = ap->private_data;
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	void __iomem *mmio = pp->ctl_block;
 
 	VPRINTK("ENTER\n");
 
@@ -1013,6 +1019,55 @@ static void nv_adma_port_stop(struct ata
 	ata_port_stop(ap);
 }
 
+static int nv_adma_port_suspend(struct ata_port *ap, pm_message_t mesg)
+{
+	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
+
+	/* Go to register mode - clears GO */
+	nv_adma_register_mode(ap);
+
+	/* clear CPB fetch count */
+	writew(0, mmio + NV_ADMA_CPB_COUNT);
+
+	/* disable interrupt, shut down port */
+	writew(0, mmio + NV_ADMA_CTL);
+
+	return 0;
+}
+
+static int nv_adma_port_resume(struct ata_port *ap)
+{
+	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
+	u16 tmp;
+
+	/* set CPB block location */
+	writel(pp->cpb_dma & 0xFFFFFFFF, 	mmio + NV_ADMA_CPB_BASE_LOW);
+	writel((pp->cpb_dma >> 16 ) >> 16,	mmio + NV_ADMA_CPB_BASE_HIGH);
+
+	/* clear any outstanding interrupt conditions */
+	writew(0xffff, mmio + NV_ADMA_STAT);
+
+	/* initialize port variables */
+	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
+
+	/* clear CPB fetch count */
+	writew(0, mmio + NV_ADMA_CPB_COUNT);
+
+	/* clear GO for register mode, enable interrupt */
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew((tmp & ~NV_ADMA_CTL_GO) | NV_ADMA_CTL_AIEN, mmio + NV_ADMA_CTL);
+
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp | NV_ADMA_CTL_CHANNEL_RESET, mmio + NV_ADMA_CTL);
+	readl( mmio + NV_ADMA_CTL );	/* flush posted write */
+	udelay(1);
+	writew(tmp & ~NV_ADMA_CTL_CHANNEL_RESET, mmio + NV_ADMA_CTL);
+	readl( mmio + NV_ADMA_CTL );	/* flush posted write */
+
+	return 0;
+}
 
 static void nv_adma_setup_port(struct ata_probe_ent *probe_ent, unsigned int port)
 {
@@ -1058,15 +1113,6 @@ static int nv_adma_host_init(struct ata_
 	for (i = 0; i < probe_ent->n_ports; i++)
 		nv_adma_setup_port(probe_ent, i);
 
-	for (i = 0; i < probe_ent->n_ports; i++) {
-		void __iomem *mmio = __nv_adma_ctl_block(probe_ent->mmio_base, i);
-		u16 tmp;
-
-		/* enable interrupt, clear reset if not already clear */
-		tmp = readw(mmio + NV_ADMA_CTL);
-		writew(tmp | NV_ADMA_CTL_AIEN, mmio + NV_ADMA_CTL);
-	}
-
 	return 0;
 }
 
@@ -1120,8 +1166,6 @@ static void nv_adma_qc_prep(struct ata_q
 		       NV_CPB_CTL_APRD_VALID |
 		       NV_CPB_CTL_IEN;
 
-	VPRINTK("qc->flags = 0x%lx\n", qc->flags);
-
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP) ||
 	     (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
 		nv_adma_register_mode(qc->ap);
@@ -1139,6 +1183,8 @@ static void nv_adma_qc_prep(struct ata_q
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		ctl_flags |= NV_CPB_CTL_QUEUE | NV_CPB_CTL_FPDMA;
 
+	VPRINTK("qc->flags = 0x%lx\n", qc->flags);
+
 	nv_adma_tf_to_cpb(&qc->tf, cpb->tf);
 
 	nv_adma_fill_sg(qc, cpb);
@@ -1152,7 +1198,7 @@ static void nv_adma_qc_prep(struct ata_q
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
-	void __iomem *mmio = nv_adma_ctl_block(qc->ap);
+	void __iomem *mmio = pp->ctl_block;
 
 	VPRINTK("ENTER\n");
 
@@ -1337,13 +1383,13 @@ static void nv_adma_error_handler(struct
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
 	if(!(pp->flags & NV_ADMA_PORT_REGISTER_MODE)) {
-		void __iomem *mmio = nv_adma_ctl_block(ap);
+		void __iomem *mmio = pp->ctl_block;
 		int i;
 		u16 tmp;
 
 		u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
 		u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
-		u32 gen_ctl = readl(nv_adma_gen_block(ap) + NV_ADMA_GEN_CTL);
+		u32 gen_ctl = readl(pp->gen_block + NV_ADMA_GEN_CTL);
 		u32 status = readw(mmio + NV_ADMA_STAT);
 
 		ata_port_printk(ap, KERN_ERR, "EH in ADMA mode, notifier 0x%X "
@@ -1388,6 +1434,7 @@ static int nv_init_one (struct pci_dev *
 	static int printed_version = 0;
 	struct ata_port_info *ppi[2];
 	struct ata_probe_ent *probe_ent;
+	struct nv_host_priv *hpriv;
 	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
@@ -1402,7 +1449,7 @@ static int nv_init_one (struct pci_dev *
 		if (pci_resource_start(pdev, bar) == 0)
 			return -ENODEV;
 
-	if (	!printed_version++)
+	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
@@ -1434,6 +1481,10 @@ static int nv_init_one (struct pci_dev *
 
 	rc = -ENOMEM;
 
+	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		goto err_out_regions;
+
 	ppi[0] = ppi[1] = &nv_port_info[type];
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
@@ -1444,6 +1495,8 @@ static int nv_init_one (struct pci_dev *
 		rc = -EIO;
 		goto err_out_free_ent;
 	}
+	probe_ent->private_data = hpriv;
+	hpriv->type = type;
 
 	base = (unsigned long)probe_ent->mmio_base;
 
@@ -1488,6 +1541,60 @@ err_out:
 	return rc;
 }
 
+static void nv_remove_one (struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct nv_host_priv *hpriv = host->private_data;
+
+	ata_pci_remove_one(pdev);
+	kfree(hpriv);
+}
+
+static int nv_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct nv_host_priv *hpriv = host->private_data;
+
+	ata_pci_device_do_resume(pdev);
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
+		if(hpriv->type >= CK804) {
+			u8 regval;
+
+			pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+			regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+			pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+		}
+		if(hpriv->type == ADMA) {
+			u32 tmp32;
+			struct nv_adma_port_priv *pp;
+			/* enable/disable ADMA on the ports appropriately */
+			pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &tmp32);
+
+			pp = host->ports[0]->private_data;
+			if(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)
+				tmp32 &= ~(NV_MCP_SATA_CFG_20_PORT0_EN |
+				 	   NV_MCP_SATA_CFG_20_PORT0_PWB_EN);
+			else
+				tmp32 |=  (NV_MCP_SATA_CFG_20_PORT0_EN |
+				 	   NV_MCP_SATA_CFG_20_PORT0_PWB_EN);
+			pp = host->ports[1]->private_data;
+			if(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)
+				tmp32 &= ~(NV_MCP_SATA_CFG_20_PORT1_EN |
+				 	   NV_MCP_SATA_CFG_20_PORT1_PWB_EN);
+			else
+				tmp32 |=  (NV_MCP_SATA_CFG_20_PORT1_EN |
+				 	   NV_MCP_SATA_CFG_20_PORT1_PWB_EN);
+
+			pci_write_config_dword(pdev, NV_MCP_SATA_CFG_20, tmp32);
+		}
+	}
+
+	ata_host_resume(host);
+
+	return 0;
+}
+
 static void nv_ck804_host_stop(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
@@ -1504,18 +1611,8 @@ static void nv_ck804_host_stop(struct at
 static void nv_adma_host_stop(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
-	int i;
 	u32 tmp32;
 
-	for (i = 0; i < host->n_ports; i++) {
-		void __iomem *mmio = __nv_adma_ctl_block(host->mmio_base, i);
-		u16 tmp;
-
-		/* disable interrupt */
-		tmp = readw(mmio + NV_ADMA_CTL);
-		writew(tmp & ~NV_ADMA_CTL_AIEN, mmio + NV_ADMA_CTL);
-	}
-
 	/* disable ADMA on the ports */
 	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &tmp32);
 	tmp32 &= ~(NV_MCP_SATA_CFG_20_PORT0_EN |
_


