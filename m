Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935514AbWKZUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935514AbWKZUgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935540AbWKZUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:36:51 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3498 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S935514AbWKZUgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:36:50 -0500
Date: Sun, 26 Nov 2006 14:30:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch] PM: suspend/resume debugging should depend on
 SOFTWARE_SUSPEND
In-reply-to: <200611261113.12826.rjw@sisk.pl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
Message-id: <4569F957.4090100@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------030806090608070804010301
References: <fa.U3NcOE+DHLOUMSq6HkaGglGl7hQ@ifi.uio.no>
 <fa.bo0iOgKqELDD50VEZpxeUpzPsMg@ifi.uio.no> <45693E25.9010504@shaw.ca>
 <200611261113.12826.rjw@sisk.pl>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806090608070804010301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
>> btw, I have some code almost ready for sata_nv to add proper 
>> suspend/resume support. Unfortunately I have trouble testing it, since 
>> STR doesn't work on my machine since, guess what - the video doesn't 
>> come back! It doesn't even take the monitor out of standby mode. None of 
>> the acpi_sleep options seem to work, and vbetool appears to helpfully 
>> segfault on any operation so that's out.
> 
> I guess it's x86-64?  Which version of vbetool?

Yes, it's x86-64, with whatever version of vbetool comes with Fedora Core 5.

> 
>> This is an NVIDIA SLI setup so that probably makes things a bit more
>> complicated.
> 
> Ouch.
> 
>> In any case, it should be better than what we have right now for 
>> suspend/resume support in sata_nv, namely the "do nothing, won't work 
>> (at least not for CK804 and later)" implementation..
> 
> I think I can test it if you send me the patch.
> 
> Greetings,
> Rafael

Here it is attached. This patch needs to be applied to 2.6.19-rc6-mm1 on 
top of the other one I just submitted, "[PATCH -mm] sata_nv: fix ATAPI 
in ADMA mode". I don't think it's too horribly broken since it did what 
it should have on some aborted suspend-to-disk attempts. (It looks like 
STD doesn't work either, it complains there is no swap available even 
though there is.. maybe because there's 2GB of RAM and 2GB of swap? It 
should still fit though, I would think, as not all RAM is in use..) In 
any case, if it works out OK then I can submit this formally.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/



--------------030806090608070804010301
Content-Type: text/plain;
 name="sata_nv-add-suspend-resume-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv-add-suspend-resume-support.patch"

--- linux-2.6.19-rc6-mm1-admafixnoresume/drivers/ata/sata_nv.c	2006-11-26 00:53:44.000000000 -0600
+++ linux-2.6.19-rc6-mm1-admafix/drivers/ata/sata_nv.c	2006-11-26 00:54:30.000000000 -0600
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
@@ -292,7 +303,9 @@ static struct pci_driver nv_pci_driver =
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
-	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= nv_pci_device_resume,
+	.remove			= nv_remove_one,
 };
 
 static struct scsi_host_template nv_sht = {
@@ -311,6 +324,8 @@ static struct scsi_host_template nv_sht 
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static struct scsi_host_template nv_adma_sht = {
@@ -330,6 +345,8 @@ static struct scsi_host_template nv_adma
 	.slave_configure	= nv_adma_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations nv_generic_ops = {
@@ -438,6 +455,8 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= nv_adma_port_start,
 	.port_stop		= nv_adma_port_stop,
+	.port_suspend		= nv_adma_port_suspend,
+	.port_resume		= nv_adma_port_resume,
 	.host_stop		= nv_adma_host_stop,
 };
 
@@ -492,32 +511,10 @@ MODULE_VERSION(DRV_VERSION);
 
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
@@ -531,8 +528,8 @@ static void nv_adma_register_mode(struct
 
 static void nv_adma_mode(struct ata_port *ap)
 {
-	void __iomem *mmio = nv_adma_ctl_block(ap);
 	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
 	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
@@ -693,7 +690,7 @@ static void nv_adma_check_cpb(struct ata
 			   For NCQ commands the current status may have nothing to do with
 			   the command just completed. */
 			if(qc->tf.protocol != ATA_PROT_NCQ)
-				ata_status = readb(nv_adma_ctl_block(ap) + (ATA_REG_STATUS * 4));
+				ata_status = readb(pp->ctl_block + (ATA_REG_STATUS * 4));
 
 			if(have_err || force_err)
 				ata_status |= ATA_ERR;
@@ -751,7 +748,7 @@ static irqreturn_t nv_adma_interrupt(int
 
 		if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct nv_adma_port_priv *pp = ap->private_data;
-			void __iomem *mmio = nv_adma_ctl_block(ap);
+			void __iomem *mmio = pp->ctl_block;
 			u16 status;
 			u32 gen_ctl;
 			int have_global_err = 0;
@@ -769,7 +766,7 @@ static irqreturn_t nv_adma_interrupt(int
 			notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
 			notifier_clears[i] = notifier | notifier_error;
 
-			gen_ctl = readl(nv_adma_gen_block(ap) + NV_ADMA_GEN_CTL);
+			gen_ctl = readl(pp->gen_block + NV_ADMA_GEN_CTL);
 
 			if( !NV_ADMA_CHECK_INTR(gen_ctl, ap->port_no) && !notifier &&
 			    !notifier_error)
@@ -827,10 +824,10 @@ static irqreturn_t nv_adma_interrupt(int
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
@@ -840,7 +837,8 @@ static irqreturn_t nv_adma_interrupt(int
 
 static void nv_adma_irq_clear(struct ata_port *ap)
 {
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = pp->ctl_block;
 	u16 status = readw(mmio + NV_ADMA_STAT);
 	u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
 	u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
@@ -849,7 +847,7 @@ static void nv_adma_irq_clear(struct ata
 	/* clear ADMA status */
 	writew(status, mmio + NV_ADMA_STAT);
 	writel(notifier | notifier_error,
-	       nv_adma_notifier_clear_block(ap));
+	       pp->notifier_clear_block);
 
 	/** clear legacy status */
 	outb(inb(dma_stat_addr), dma_stat_addr);
@@ -931,7 +929,7 @@ static int nv_adma_port_start(struct ata
 	int rc;
 	void *mem;
 	dma_addr_t mem_dma;
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	void __iomem *mmio;
 	u16 tmp;
 
 	VPRINTK("ENTER\n");
@@ -946,6 +944,13 @@ static int nv_adma_port_start(struct ata
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
 
@@ -986,9 +991,9 @@ static int nv_adma_port_start(struct ata
 	/* clear CPB fetch count */
 	writew(0, mmio + NV_ADMA_CPB_COUNT);
 
-	/* clear GO for register mode */
+	/* clear GO for register mode, enable interrupt */
 	tmp = readw(mmio + NV_ADMA_CTL);
-	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+	writew( (tmp & ~NV_ADMA_CTL_GO) | NV_ADMA_CTL_AIEN, mmio + NV_ADMA_CTL);
 
 	tmp = readw(mmio + NV_ADMA_CTL);
 	writew(tmp | NV_ADMA_CTL_CHANNEL_RESET, mmio + NV_ADMA_CTL);
@@ -1010,7 +1015,7 @@ static void nv_adma_port_stop(struct ata
 {
 	struct device *dev = ap->host->dev;
 	struct nv_adma_port_priv *pp = ap->private_data;
-	void __iomem *mmio = nv_adma_ctl_block(ap);
+	void __iomem *mmio = pp->ctl_block;
 
 	VPRINTK("ENTER\n");
 
@@ -1022,6 +1027,55 @@ static void nv_adma_port_stop(struct ata
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
@@ -1067,15 +1121,6 @@ static int nv_adma_host_init(struct ata_
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
 
@@ -1129,8 +1174,6 @@ static void nv_adma_qc_prep(struct ata_q
 		       NV_CPB_CTL_APRD_VALID |
 		       NV_CPB_CTL_IEN;
 
-	VPRINTK("qc->flags = 0x%lx\n", qc->flags);
-
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP) ||
 	     (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
 		nv_adma_register_mode(qc->ap);
@@ -1148,6 +1191,8 @@ static void nv_adma_qc_prep(struct ata_q
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		ctl_flags |= NV_CPB_CTL_QUEUE | NV_CPB_CTL_FPDMA;
 
+	VPRINTK("qc->flags = 0x%lx\n", qc->flags);
+
 	nv_adma_tf_to_cpb(&qc->tf, cpb->tf);
 
 	nv_adma_fill_sg(qc, cpb);
@@ -1161,7 +1206,7 @@ static void nv_adma_qc_prep(struct ata_q
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
-	void __iomem *mmio = nv_adma_ctl_block(qc->ap);
+	void __iomem *mmio = pp->ctl_block;
 
 	VPRINTK("ENTER\n");
 
@@ -1346,13 +1391,13 @@ static void nv_adma_error_handler(struct
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
@@ -1397,6 +1442,7 @@ static int nv_init_one (struct pci_dev *
 	static int printed_version = 0;
 	struct ata_port_info *ppi[2];
 	struct ata_probe_ent *probe_ent;
+	struct nv_host_priv *hpriv;
 	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
@@ -1411,7 +1457,7 @@ static int nv_init_one (struct pci_dev *
 		if (pci_resource_start(pdev, bar) == 0)
 			return -ENODEV;
 
-	if (	!printed_version++)
+	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
@@ -1442,6 +1488,10 @@ static int nv_init_one (struct pci_dev *
 	}
 
 	rc = -ENOMEM;
+	
+	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		goto err_out_regions;
 
 	ppi[0] = ppi[1] = &nv_port_info[type];
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
@@ -1453,6 +1503,8 @@ static int nv_init_one (struct pci_dev *
 		rc = -EIO;
 		goto err_out_free_ent;
 	}
+	probe_ent->private_data = hpriv;
+	hpriv->type = type;
 
 	base = (unsigned long)probe_ent->mmio_base;
 
@@ -1497,6 +1549,60 @@ err_out:
 	return rc;
 }
 
+static void nv_remove_one (struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct nv_host_priv *hpriv = host->private_data;
+	
+	kfree(hpriv);
+	ata_pci_remove_one(pdev);
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
@@ -1513,18 +1619,8 @@ static void nv_ck804_host_stop(struct at
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

--------------030806090608070804010301--

