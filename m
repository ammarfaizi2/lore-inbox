Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbVIEJdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVIEJdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVIEJdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:33:52 -0400
Received: from havoc.gtf.org ([69.61.125.42]:12771 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932626AbVIEJdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:33:50 -0400
Date: Mon, 5 Sep 2005 05:33:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata update
Message-ID: <20050905093344.GA9286@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive some libata updates, described below.

This does two vaguely notable things:

* converts ATAPI from compile-time to runtime option, making it easier
  for people to test.  ATAPI will be turned on by default when its ready
  for production use.  Its not there yet.

* uses pci_iomap() in several drivers, which gets us one step closer
  to killing all those iomap-related warnings when building libata.




 drivers/scsi/ahci.c         |   52 +++++++++++++++++-------------------------
 drivers/scsi/ata_piix.c     |   11 ++++----
 drivers/scsi/libata-core.c  |   15 +++++++++++-
 drivers/scsi/libata-scsi.c  |    8 +++---
 drivers/scsi/libata.h       |    1 
 drivers/scsi/sata_nv.c      |    9 ++++---
 drivers/scsi/sata_promise.c |   20 ++++++++--------
 drivers/scsi/sata_qstor.c   |    8 +++---
 drivers/scsi/sata_sil.c     |   12 +++++----
 drivers/scsi/sata_svw.c     |    7 ++---
 drivers/scsi/sata_sx4.c     |   54 ++++++++++++++++++++++----------------------
 drivers/scsi/sata_vsc.c     |    5 +---
 include/linux/libata.h      |    2 -
 13 files changed, 104 insertions(+), 100 deletions(-)



Jeff Garzik:
  [libata] allow ATAPI to be enabled with new atapi_enabled module option
  [libata ahci] minor remove/unplug path cleanup
  [libata] __iomem annotations for various drivers
  [libata] update several drivers to use pci_iomap()/pci_iounmap()
  [libata] fix ATAPI-enable typo
  /spare/repo/libata-dev branch 'master'
  /spare/repo/libata-dev branch 'iomap-try3'



diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -189,7 +189,6 @@ static void ahci_irq_clear(struct ata_po
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
-static void ahci_host_stop(struct ata_host_set *host_set);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -242,7 +241,6 @@ static struct ata_port_operations ahci_o
 
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
-	.host_stop		= ahci_host_stop,
 };
 
 static struct ata_port_info ahci_port_info[] = {
@@ -296,17 +294,9 @@ static inline unsigned long ahci_port_ba
 	return base + 0x100 + (port * 0x80);
 }
 
-static inline void *ahci_port_base (void *base, unsigned int port)
+static inline void __iomem *ahci_port_base (void __iomem *base, unsigned int port)
 {
-	return (void *) ahci_port_base_ul((unsigned long)base, port);
-}
-
-static void ahci_host_stop(struct ata_host_set *host_set)
-{
-	struct ahci_host_priv *hpriv = host_set->private_data;
-	kfree(hpriv);
-
-	ata_host_stop(host_set);
+	return (void __iomem *) ahci_port_base_ul((unsigned long)base, port);
 }
 
 static int ahci_port_start(struct ata_port *ap)
@@ -314,8 +304,9 @@ static int ahci_port_start(struct ata_po
 	struct device *dev = ap->host_set->dev;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp;
-	void *mem, *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void *mem;
 	dma_addr_t mem_dma;
 
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
@@ -383,8 +374,8 @@ static void ahci_port_stop(struct ata_po
 {
 	struct device *dev = ap->host_set->dev;
 	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
@@ -546,8 +537,8 @@ static void ahci_qc_prep(struct ata_queu
 
 static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
 {
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
 	int work;
 
@@ -595,8 +586,8 @@ static void ahci_intr_error(struct ata_p
 static void ahci_eng_timeout(struct ata_port *ap)
 {
 	struct ata_host_set *host_set = ap->host_set;
-	void *mmio = host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *mmio = host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
@@ -626,8 +617,8 @@ static void ahci_eng_timeout(struct ata_
 
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 status, serr, ci;
 
 	serr = readl(port_mmio + PORT_SCR_ERR);
@@ -663,7 +654,7 @@ static irqreturn_t ahci_interrupt (int i
 	struct ata_host_set *host_set = dev_instance;
 	struct ahci_host_priv *hpriv;
 	unsigned int i, handled = 0;
-	void *mmio;
+	void __iomem *mmio;
 	u32 irq_stat, irq_ack = 0;
 
 	VPRINTK("ENTER\n");
@@ -709,7 +700,7 @@ static irqreturn_t ahci_interrupt (int i
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
@@ -894,7 +885,7 @@ static void ahci_print_info(struct ata_p
 {
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
-	void *mmio = probe_ent->mmio_base;
+	void __iomem *mmio = probe_ent->mmio_base;
 	u32 vers, cap, impl, speed;
 	const char *speed_s;
 	u16 cc;
@@ -967,7 +958,7 @@ static int ahci_init_one (struct pci_dev
 	struct ata_probe_ent *probe_ent = NULL;
 	struct ahci_host_priv *hpriv;
 	unsigned long base;
-	void *mmio_base;
+	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int have_msi, pci_dev_busy = 0;
 	int rc;
@@ -1004,8 +995,7 @@ static int ahci_init_one (struct pci_dev
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = ioremap(pci_resource_start(pdev, AHCI_PCI_BAR),
-		            pci_resource_len(pdev, AHCI_PCI_BAR));
+	mmio_base = pci_iomap(pdev, AHCI_PCI_BAR, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
@@ -1049,7 +1039,7 @@ static int ahci_init_one (struct pci_dev
 err_out_hpriv:
 	kfree(hpriv);
 err_out_iounmap:
-	iounmap(mmio_base);
+	pci_iounmap(pdev, mmio_base);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_msi:
@@ -1089,7 +1079,8 @@ static void ahci_remove_one (struct pci_
 		scsi_host_put(ap->host);
 	}
 
-	host_set->ops->host_stop(host_set);
+	kfree(hpriv);
+	pci_iounmap(pdev, host_set->mmio_base);
 	kfree(host_set);
 
 	if (have_msi)
@@ -1106,7 +1097,6 @@ static int __init ahci_init(void)
 	return pci_module_init(&ahci_pci_driver);
 }
 
-
 static void __exit ahci_exit(void)
 {
 	pci_unregister_driver(&ahci_pci_driver);
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -583,8 +583,7 @@ static void pci_enable_intx(struct pci_d
 #define AHCI_ENABLE (1 << 31)
 static int piix_disable_ahci(struct pci_dev *pdev)
 {
-	void *mmio;
-	unsigned long addr;
+	void __iomem *mmio;
 	u32 tmp;
 	int rc = 0;
 
@@ -592,11 +591,11 @@ static int piix_disable_ahci(struct pci_
 	 * works because this device is usually set up by BIOS.
 	 */
 
-	addr = pci_resource_start(pdev, AHCI_PCI_BAR);
-	if (!addr || !pci_resource_len(pdev, AHCI_PCI_BAR))
+	if (!pci_resource_start(pdev, AHCI_PCI_BAR) ||
+	    !pci_resource_len(pdev, AHCI_PCI_BAR))
 		return 0;
 
-	mmio = ioremap(addr, 64);
+	mmio = pci_iomap(pdev, AHCI_PCI_BAR, 64);
 	if (!mmio)
 		return -ENOMEM;
 
@@ -610,7 +609,7 @@ static int piix_disable_ahci(struct pci_
 			rc = -EIO;
 	}
 
-	iounmap(mmio);
+	pci_iounmap(pdev, mmio);
 	return rc;
 }
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -75,6 +75,10 @@ static void __ata_qc_complete(struct ata
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+int atapi_enabled = 0;
+module_param(atapi_enabled, int, 0444);
+MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -4200,6 +4204,15 @@ ata_probe_ent_alloc(struct device *dev, 
 
 
 
+#ifdef CONFIG_PCI
+
+void ata_pci_host_stop (struct ata_host_set *host_set)
+{
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+
+	pci_iounmap(pdev, host_set->mmio_base);
+}
+
 /**
  *	ata_pci_init_native_mode - Initialize native-mode driver
  *	@pdev:  pci device to be initialized
@@ -4212,7 +4225,6 @@ ata_probe_ent_alloc(struct device *dev, 
  *	ata_probe_ent structure should then be freed with kfree().
  */
 
-#ifdef CONFIG_PCI
 struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
@@ -4595,6 +4607,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
+EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1470,10 +1470,10 @@ ata_scsi_find_dev(struct ata_port *ap, s
 	if (unlikely(!ata_dev_present(dev)))
 		return NULL;
 
-#ifndef ATA_ENABLE_ATAPI
-	if (unlikely(dev->class == ATA_DEV_ATAPI))
-		return NULL;
-#endif
+	if (!atapi_enabled) {
+		if (unlikely(dev->class == ATA_DEV_ATAPI))
+			return NULL;
+	}
 
 	return dev;
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -38,6 +38,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern int atapi_enabled;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -351,6 +351,7 @@ static void nv_scr_write (struct ata_por
 static void nv_host_stop (struct ata_host_set *host_set)
 {
 	struct nv_host *host = host_set->private_data;
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
 	// Disable hotplug event interrupts.
 	if (host->host_desc->disable_hotplug)
@@ -358,7 +359,8 @@ static void nv_host_stop (struct ata_hos
 
 	kfree(host);
 
-	ata_host_stop(host_set);
+	if (host_set->mmio_base)
+		pci_iounmap(pdev, host_set->mmio_base);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -420,8 +422,7 @@ static int nv_init_one (struct pci_dev *
 	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
 		unsigned long base;
 
-		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
-				pci_resource_len(pdev, 5));
+		probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
 		if (probe_ent->mmio_base == NULL) {
 			rc = -EIO;
 			goto err_out_free_host;
@@ -457,7 +458,7 @@ static int nv_init_one (struct pci_dev *
 
 err_out_iounmap:
 	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		iounmap(probe_ent->mmio_base);
+		pci_iounmap(pdev, probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
 err_out_free_ent:
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -92,6 +92,7 @@ static void pdc_exec_command_mmio(struct
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
+
 static Scsi_Host_Template pdc_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -132,7 +133,7 @@ static struct ata_port_operations pdc_sa
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_operations pdc_pata_ops = {
@@ -153,7 +154,7 @@ static struct ata_port_operations pdc_pa
 
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info pdc_port_info[] = {
@@ -282,7 +283,7 @@ static void pdc_port_stop(struct ata_por
 
 static void pdc_reset_port(struct ata_port *ap)
 {
-	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
 	unsigned int i;
 	u32 tmp;
 
@@ -418,7 +419,7 @@ static inline unsigned int pdc_host_intr
 	u8 status;
 	unsigned int handled = 0, have_err = 0;
 	u32 tmp;
-	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
@@ -447,7 +448,7 @@ static inline unsigned int pdc_host_intr
 static void pdc_irq_clear(struct ata_port *ap)
 {
 	struct ata_host_set *host_set = ap->host_set;
-	void *mmio = host_set->mmio_base;
+	void __iomem *mmio = host_set->mmio_base;
 
 	readl(mmio + PDC_INT_SEQMASK);
 }
@@ -459,7 +460,7 @@ static irqreturn_t pdc_interrupt (int ir
 	u32 mask = 0;
 	unsigned int i, tmp;
 	unsigned int handled = 0;
-	void *mmio_base;
+	void __iomem *mmio_base;
 
 	VPRINTK("ENTER\n");
 
@@ -581,7 +582,7 @@ static void pdc_ata_setup_port(struct at
 
 static void pdc_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 {
-	void *mmio = pe->mmio_base;
+	void __iomem *mmio = pe->mmio_base;
 	u32 tmp;
 
 	/*
@@ -624,7 +625,7 @@ static int pdc_ata_init_one (struct pci_
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
-	void *mmio_base;
+	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
 	int rc;
@@ -663,8 +664,7 @@ static int pdc_ata_init_one (struct pci_
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = ioremap(pci_resource_start(pdev, 3),
-		            pci_resource_len(pdev, 3));
+	mmio_base = pci_iomap(pdev, 3, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -538,11 +538,12 @@ static void qs_port_stop(struct ata_port
 static void qs_host_stop(struct ata_host_set *host_set)
 {
 	void __iomem *mmio_base = host_set->mmio_base;
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
 	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
 
-	ata_host_stop(host_set);
+	pci_iounmap(pdev, mmio_base);
 }
 
 static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
@@ -646,8 +647,7 @@ static int qs_ata_init_one(struct pci_de
 		goto err_out_regions;
 	}
 
-	mmio_base = ioremap(pci_resource_start(pdev, 4),
-		            pci_resource_len(pdev, 4));
+	mmio_base = pci_iomap(pdev, 4, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
@@ -697,7 +697,7 @@ static int qs_ata_init_one(struct pci_de
 	return 0;
 
 err_out_iounmap:
-	iounmap(mmio_base);
+	pci_iounmap(pdev, mmio_base);
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -86,6 +86,7 @@ static u32 sil_scr_read (struct ata_port
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
 
+
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
@@ -172,7 +173,7 @@ static struct ata_port_operations sil_op
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info sil_port_info[] = {
@@ -231,6 +232,7 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
 	u8 cache_line = 0;
@@ -242,7 +244,8 @@ static void sil_post_set_mode (struct at
 {
 	struct ata_host_set *host_set = ap->host_set;
 	struct ata_device *dev;
-	void *addr = host_set->mmio_base + sil_port[ap->port_no].xfer_mode;
+	void __iomem *addr =
+		host_set->mmio_base + sil_port[ap->port_no].xfer_mode;
 	u32 tmp, dev_mode[2];
 	unsigned int i;
 
@@ -375,7 +378,7 @@ static int sil_init_one (struct pci_dev 
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
-	void *mmio_base;
+	void __iomem *mmio_base;
 	int rc;
 	unsigned int i;
 	int pci_dev_busy = 0;
@@ -425,8 +428,7 @@ static int sil_init_one (struct pci_dev 
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
 
-	mmio_base = ioremap(pci_resource_start(pdev, 5),
-		            pci_resource_len(pdev, 5));
+	mmio_base = pci_iomap(pdev, 5, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -318,7 +318,7 @@ static struct ata_port_operations k2_sat
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -346,7 +346,7 @@ static int k2_sata_init_one (struct pci_
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
-	void *mmio_base;
+	void __iomem *mmio_base;
 	int pci_dev_busy = 0;
 	int rc;
 	int i;
@@ -392,8 +392,7 @@ static int k2_sata_init_one (struct pci_
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = ioremap(pci_resource_start(pdev, 5),
-		            pci_resource_len(pdev, 5));
+	mmio_base = pci_iomap(pdev, 5, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -245,13 +245,14 @@ static struct pci_driver pdc_sata_pci_dr
 
 static void pdc20621_host_stop(struct ata_host_set *host_set)
 {
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	struct pdc_host_priv *hpriv = host_set->private_data;
 	void *dimm_mmio = hpriv->dimm_mmio;
 
-	iounmap(dimm_mmio);
+	pci_iounmap(pdev, dimm_mmio);
 	kfree(hpriv);
 
-	ata_host_stop(host_set);
+	pci_iounmap(pdev, host_set->mmio_base);
 }
 
 static int pdc_port_start(struct ata_port *ap)
@@ -451,9 +452,9 @@ static void pdc20621_dma_prep(struct ata
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
+	void __iomem *mmio = ap->host_set->mmio_base;
 	struct pdc_host_priv *hpriv = ap->host_set->private_data;
-	void *dimm_mmio = hpriv->dimm_mmio;
+	void __iomem *dimm_mmio = hpriv->dimm_mmio;
 	unsigned int portno = ap->port_no;
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
@@ -513,9 +514,9 @@ static void pdc20621_nodata_prep(struct 
 {
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
+	void __iomem *mmio = ap->host_set->mmio_base;
 	struct pdc_host_priv *hpriv = ap->host_set->private_data;
-	void *dimm_mmio = hpriv->dimm_mmio;
+	void __iomem *dimm_mmio = hpriv->dimm_mmio;
 	unsigned int portno = ap->port_no;
 	unsigned int i;
 
@@ -565,7 +566,7 @@ static void __pdc20621_push_hdma(struct 
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
-	void *mmio = host_set->mmio_base;
+	void __iomem *mmio = host_set->mmio_base;
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -639,7 +640,7 @@ static void pdc20621_packet_start(struct
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
 	unsigned int port_no = ap->port_no;
-	void *mmio = host_set->mmio_base;
+	void __iomem *mmio = host_set->mmio_base;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 seq = (u8) (port_no + 1);
 	unsigned int port_ofs;
@@ -699,7 +700,7 @@ static int pdc20621_qc_issue_prot(struct
 static inline unsigned int pdc20621_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc,
 					  unsigned int doing_hdma,
-					  void *mmio)
+					  void __iomem *mmio)
 {
 	unsigned int port_no = ap->port_no;
 	unsigned int port_ofs =
@@ -778,7 +779,7 @@ static inline unsigned int pdc20621_host
 static void pdc20621_irq_clear(struct ata_port *ap)
 {
 	struct ata_host_set *host_set = ap->host_set;
-	void *mmio = host_set->mmio_base;
+	void __iomem *mmio = host_set->mmio_base;
 
 	mmio += PDC_CHIP0_OFS;
 
@@ -792,7 +793,7 @@ static irqreturn_t pdc20621_interrupt (i
 	u32 mask = 0;
 	unsigned int i, tmp, port_no;
 	unsigned int handled = 0;
-	void *mmio_base;
+	void __iomem *mmio_base;
 
 	VPRINTK("ENTER\n");
 
@@ -940,9 +941,9 @@ static void pdc20621_get_from_dimm(struc
 	u16 idx;
 	u8 page_mask;
 	long dist;
-	void *mmio = pe->mmio_base;
+	void __iomem *mmio = pe->mmio_base;
 	struct pdc_host_priv *hpriv = pe->private_data;
-	void *dimm_mmio = hpriv->dimm_mmio;
+	void __iomem *dimm_mmio = hpriv->dimm_mmio;
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -996,9 +997,9 @@ static void pdc20621_put_to_dimm(struct 
 	u16 idx;
 	u8 page_mask;
 	long dist;
-	void *mmio = pe->mmio_base;
+	void __iomem *mmio = pe->mmio_base;
 	struct pdc_host_priv *hpriv = pe->private_data;
-	void *dimm_mmio = hpriv->dimm_mmio;
+	void __iomem *dimm_mmio = hpriv->dimm_mmio;
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -1044,7 +1045,7 @@ static void pdc20621_put_to_dimm(struct 
 static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, u32 device,
 				      u32 subaddr, u32 *pdata)
 {
-	void *mmio = pe->mmio_base;
+	void __iomem *mmio = pe->mmio_base;
 	u32 i2creg  = 0;
 	u32 status;
 	u32 count =0;
@@ -1103,7 +1104,7 @@ static int pdc20621_prog_dimm0(struct at
 	u32 data = 0;
    	int size, i;
    	u8 bdimmsize;
-   	void *mmio = pe->mmio_base;
+   	void __iomem *mmio = pe->mmio_base;
 	static const struct {
 		unsigned int reg;
 		unsigned int ofs;
@@ -1166,7 +1167,7 @@ static unsigned int pdc20621_prog_dimm_g
 {
 	u32 data, spd0;
    	int error, i;
-   	void *mmio = pe->mmio_base;
+   	void __iomem *mmio = pe->mmio_base;
 
 	/* hard-code chip #0 */
    	mmio += PDC_CHIP0_OFS;
@@ -1220,7 +1221,7 @@ static unsigned int pdc20621_dimm_init(s
 	u32 ticks=0;
 	u32 clock=0;
 	u32 fparam=0;
-   	void *mmio = pe->mmio_base;
+   	void __iomem *mmio = pe->mmio_base;
 
 	/* hard-code chip #0 */
    	mmio += PDC_CHIP0_OFS;
@@ -1344,7 +1345,7 @@ static unsigned int pdc20621_dimm_init(s
 static void pdc_20621_init(struct ata_probe_ent *pe)
 {
 	u32 tmp;
-	void *mmio = pe->mmio_base;
+	void __iomem *mmio = pe->mmio_base;
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -1377,7 +1378,8 @@ static int pdc_sata_init_one (struct pci
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
-	void *mmio_base, *dimm_mmio = NULL;
+	void __iomem *mmio_base;
+	void __iomem *dimm_mmio = NULL;
 	struct pdc_host_priv *hpriv = NULL;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
@@ -1417,8 +1419,7 @@ static int pdc_sata_init_one (struct pci
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = ioremap(pci_resource_start(pdev, 3),
-		            pci_resource_len(pdev, 3));
+	mmio_base = pci_iomap(pdev, 3, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
@@ -1432,8 +1433,7 @@ static int pdc_sata_init_one (struct pci
 	}
 	memset(hpriv, 0, sizeof(*hpriv));
 
-	dimm_mmio = ioremap(pci_resource_start(pdev, 4),
-			    pci_resource_len(pdev, 4));
+	dimm_mmio = pci_iomap(pdev, 4, 0);
 	if (!dimm_mmio) {
 		kfree(hpriv);
 		rc = -ENOMEM;
@@ -1480,9 +1480,9 @@ static int pdc_sata_init_one (struct pci
 
 err_out_iounmap_dimm:		/* only get to this label if 20621 */
 	kfree(hpriv);
-	iounmap(dimm_mmio);
+	pci_iounmap(pdev, dimm_mmio);
 err_out_iounmap:
-	iounmap(mmio_base);
+	pci_iounmap(pdev, mmio_base);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_regions:
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -252,7 +252,7 @@ static struct ata_port_operations vsc_sa
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -326,8 +326,7 @@ static int __devinit vsc_sata_init_one (
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = ioremap(pci_resource_start(pdev, 0),
-		            pci_resource_len(pdev, 0));
+	mmio_base = pci_iomap(pdev, 0, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -40,7 +40,6 @@
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
 #undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
@@ -450,6 +449,7 @@ struct pci_bits {
 	unsigned long		val;
 };
 
+extern void ata_pci_host_stop (struct ata_host_set *host_set);
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
