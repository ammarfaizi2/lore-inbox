Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVCCEn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVCCEn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCCEmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:42:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52702 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261458AbVCCEZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:25:01 -0500
Message-ID: <4226918C.9060900@pobox.com>
Date: Wed, 02 Mar 2005 23:24:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.4.x libata update
Content-Type: multipart/mixed;
 boundary="------------030101040407090003060009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101040407090003060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030101040407090003060009
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 Documentation/Configure.help  |    5 
 drivers/scsi/Config.in        |    1 
 drivers/scsi/Makefile         |    1 
 drivers/scsi/ahci.c           |   26 +
 drivers/scsi/ata_piix.c       |    4 
 drivers/scsi/libata-core.c    |  120 ++++++-
 drivers/scsi/libata-scsi.c    |    1 
 drivers/scsi/libata.h         |    1 
 drivers/scsi/sata_nv.c        |   10 
 drivers/scsi/sata_promise.c   |   10 
 drivers/scsi/sata_qstor.c     |  699 ++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_sil.c       |   10 
 drivers/scsi/sata_sis.c       |   10 
 drivers/scsi/sata_svw.c       |   10 
 drivers/scsi/sata_sx4.c       |   14 
 drivers/scsi/sata_uli.c       |   10 
 drivers/scsi/sata_via.c       |  213 +++++++++---
 drivers/scsi/sata_vsc.c       |   12 
 include/linux/libata-compat.h |   22 +
 include/linux/libata.h        |   64 ---
 20 files changed, 1079 insertions(+), 164 deletions(-)

through these ChangeSets:

<mat.loikkanen:synopsys.com>:
  o [libata] add ->bmdma_{stop,status} hooks

Jeff Garzik:
  o [libata ahci] Print out port id on error messages
  o [libata] Use DMA_{32,64}BIT_MASK in ahci, sata_vsc drivers
  o [libata] Add missing hooks, to avoid oops in advanced SATA drivers
  o [libata] do not call pci_disable_device() for certain errors
  o [libata] trivial: whitespace sync with 2.6
  o [libata] resync with 2.6 msleep() updates
  o [libata sata_via] add support for VT6421 SATA
  o [libata sata_via] minor cleanups

John W. Linville:
  o libata: fix command queue leak when xlat_func fails

Mark Lord:
  o [libata qstor] minor update per LKML comments
  o sata_qstor: new basic driver for Pacific Digital


--------------030101040407090003060009
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	2005-03-02 23:23:22 -05:00
+++ b/Documentation/Configure.help	2005-03-02 23:23:22 -05:00
@@ -9345,6 +9345,11 @@
 
   If unsure, say N.
 
+CONFIG_SCSI_SATA_QSTOR
+  This option enables support for Pacific Digital Serial ATA QStor.
+
+  If unsure, say N.
+
 CONFIG_SCSI_SATA_SX4
   This option enables support for Promise Serial ATA SX4.
 
diff -Nru a/drivers/scsi/Config.in b/drivers/scsi/Config.in
--- a/drivers/scsi/Config.in	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/Config.in	2005-03-02 23:23:22 -05:00
@@ -73,6 +73,7 @@
 dep_tristate '  ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SVW $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Intel PIIX/ICH SATA support' CONFIG_SCSI_ATA_PIIX $CONFIG_SCSI_SATA $CONFIG_PCI
 dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
+dep_tristate '  Pacific Digital SATA QStor support' CONFIG_SCSI_SATA_QSTOR $CONFIG_SCSI_SATA $CONFIG_PCI
 dep_tristate '  Promise SATA TX2/TX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_PROMISE $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Promise SATA SX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SX4 $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Silicon Image SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SIL $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/Makefile	2005-03-02 23:23:22 -05:00
@@ -134,6 +134,7 @@
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
 obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
+obj-$(CONFIG_SCSI_SATA_QSTOR)	+= libata.o sata_qstor.o
 obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
 obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
 obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/ahci.c	2005-03-02 23:23:22 -05:00
@@ -40,8 +40,6 @@
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"1.00"
 
-#define msleep libata_msleep   /* 2.4-specific */
-
 enum {
 	AHCI_PCI_BAR		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
@@ -180,6 +178,7 @@
 static void ahci_host_stop(struct ata_host_set *host_set);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
+static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 
 static Scsi_Host_Template ahci_sht = {
@@ -206,6 +205,8 @@
 	.port_disable		= ata_port_disable,
 
 	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
 	.phy_reset		= ahci_phy_reset,
@@ -454,6 +455,13 @@
 	return readl(mmio + PORT_TFDATA) & 0xFF;
 }
 
+static u8 ahci_check_err(struct ata_port *ap)
+{
+	void *mmio = (void *) ap->ioaddr.cmd_addr;
+
+	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
+}
+
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
@@ -566,7 +574,7 @@
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -758,10 +766,10 @@
 
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
-	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		hpriv->flags |= HOST_CAP_64;
 	} else {
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
 				pci_name(pdev));
@@ -926,6 +934,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -938,8 +947,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	pci_enable_intx(pdev);
 
@@ -999,7 +1010,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/ata_piix.c	2005-03-02 23:23:22 -05:00
@@ -139,6 +139,8 @@
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -164,6 +166,8 @@
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/libata-core.c	2005-03-02 23:23:22 -05:00
@@ -376,7 +376,7 @@
 }
 
 /**
- *	ata_check_status - Read device status reg & clear interrupt
+ *	ata_check_status_pio - Read device status reg & clear interrupt
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
@@ -414,6 +414,27 @@
 	return ata_check_status_pio(ap);
 }
 
+u8 ata_altstatus(struct ata_port *ap)
+{
+	if (ap->ops->check_altstatus)
+		return ap->ops->check_altstatus(ap);
+
+	if (ap->flags & ATA_FLAG_MMIO)
+		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
+	return inb(ap->ioaddr.altstatus_addr);
+}
+
+u8 ata_chk_err(struct ata_port *ap)
+{
+	if (ap->ops->check_err)
+		return ap->ops->check_err(ap);
+
+	if (ap->flags & ATA_FLAG_MMIO) {
+		return readb((void __iomem *) ap->ioaddr.error_addr);
+	}
+	return inb(ap->ioaddr.error_addr);
+}
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
@@ -1160,7 +1181,6 @@
 	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
 	       ap->id, device);
 err_out:
-	ata_irq_on(ap);	/* re-enable interrupts */
 	dev->class++;	/* converts ATA_DEV_xxx into ATA_DEV_xxx_UNSUP */
 	DPRINTK("EXIT, err\n");
 }
@@ -1668,7 +1688,8 @@
 		ata_dev_try_classify(ap, 1);
 
 	/* re-enable interrupts */
-	ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -2601,10 +2622,10 @@
 
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		host_stat = ata_bmdma_status(ap);
+		host_stat = ap->ops->bmdma_status(ap);
 
 		/* before we do anything else, clear DMA-Start bit */
-		ata_bmdma_stop(ap);
+		ap->ops->bmdma_stop(ap);
 
 		/* fall through */
 
@@ -2613,7 +2634,7 @@
 		drv_stat = ata_chk_status(ap);
 
 		/* ack bmdma irq events */
-		ata_bmdma_ack_irq(ap);
+		ap->ops->irq_clear(ap);
 
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
@@ -2752,6 +2773,24 @@
 }
 
 /**
+ *	ata_qc_free - free unused ata_queued_cmd
+ *	@qc: Command to complete
+ *
+ *	Designed to free unused ata_queued_cmd object
+ *	in case something prevents using it.
+ *
+ *	LOCKING:
+ *
+ */
+void ata_qc_free(struct ata_queued_cmd *qc)
+{
+	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
+	assert(qc->waiting == NULL);	/* nothing should be waiting */
+
+	__ata_qc_complete(qc);
+}
+
+/**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
  *	@drv_stat: ATA status register contents
@@ -2800,7 +2839,7 @@
 			return 1;
 
 		/* fall through */
-
+	
 	default:
 		return 0;
 	}
@@ -3042,7 +3081,43 @@
 
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
-	ata_bmdma_ack_irq(ap);
+    if (ap->flags & ATA_FLAG_MMIO) {
+        void __iomem *mmio = ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+        writeb(readb(mmio), mmio);
+    } else {
+        unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+        outb(inb(addr), addr);
+    }
+
+}
+
+u8 ata_bmdma_status(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
+}
+
+void ata_bmdma_stop(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+
+		/* clear start/stop bit */
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+			mmio + ATA_DMA_CMD);
+	} else {
+		/* clear start/stop bit */
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	}
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);        /* dummy read */
 }
 
 /**
@@ -3072,7 +3147,7 @@
 	case ATA_PROT_ATAPI_DMA:
 	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
-		host_stat = ata_bmdma_status(ap);
+		host_stat = ap->ops->bmdma_status(ap);
 		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
 
 		/* if it's not our irq... */
@@ -3080,7 +3155,7 @@
 			goto idle_irq;
 
 		/* before we do anything else, clear DMA-Start bit */
-		ata_bmdma_stop(ap);
+		ap->ops->bmdma_stop(ap);
 
 		/* fall through */
 
@@ -3099,7 +3174,7 @@
 			ap->id, qc->tf.protocol, status);
 
 		/* ack bmdma irq events */
-		ata_bmdma_ack_irq(ap);
+		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
@@ -3674,6 +3749,7 @@
 	struct ata_port_info *port[2];
 	u8 tmp8, mask;
 	unsigned int legacy_mode = 0;
+	int disable_dev_on_err = 1;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -3704,18 +3780,22 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		disable_dev_on_err = 0;
 		goto err_out;
+	}
 
 	if (legacy_mode) {
-		if (!request_region(0x1f0, 8, "libata"))
+		if (!request_region(0x1f0, 8, "libata")) {
+			disable_dev_on_err = 0;
 			printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
-		else
+		} else
 			legacy_mode |= (1 << 0);
 
-		if (!request_region(0x170, 8, "libata"))
+		if (!request_region(0x170, 8, "libata")) {
+			disable_dev_on_err = 0;
 			printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
-		else
+		} else
 			legacy_mode |= (1 << 1);
 	}
 
@@ -3764,7 +3844,8 @@
 		release_region(0x170, 8);
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (disable_dev_on_err)
+		pci_disable_device(pdev);
 	return rc;
 }
 
@@ -3922,6 +4003,8 @@
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_check_status);
+EXPORT_SYMBOL_GPL(ata_altstatus);
+EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
@@ -3930,6 +4013,8 @@
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
+EXPORT_SYMBOL_GPL(ata_bmdma_status);
+EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
@@ -3940,7 +4025,6 @@
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_detect);
 EXPORT_SYMBOL_GPL(ata_add_to_probe_list);
-EXPORT_SYMBOL_GPL(libata_msleep);
 EXPORT_SYMBOL_GPL(ssleep);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-03-02 23:23:22 -05:00
@@ -663,6 +663,7 @@
 	return;
 
 err_out:
+	ata_qc_free(qc);
 	ata_bad_cdb(cmd, done);
 	DPRINTK("EXIT - badcmd\n");
 }
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/libata.h	2005-03-02 23:23:22 -05:00
@@ -37,6 +37,7 @@
 /* libata-core.c */
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
+extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_nv.c	2005-03-02 23:23:22 -05:00
@@ -218,6 +218,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -333,6 +335,7 @@
 	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
 
@@ -351,8 +354,10 @@
 		goto err_out;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out_disable;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -418,7 +423,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out_disable:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 err_out:
 	return rc;
 }
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_promise.c	2005-03-02 23:23:22 -05:00
@@ -42,8 +42,6 @@
 #define DRV_NAME	"sata_promise"
 #define DRV_VERSION	"1.01"
 
-#define msleep libata_msleep	/* 2.4-specific */
-
 enum {
 	PDC_PKT_SUBMIT		= 0x40, /* Command packet pointer addr */
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
@@ -558,6 +556,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -572,8 +571,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -647,7 +648,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/sata_qstor.c	2005-03-02 23:23:22 -05:00
@@ -0,0 +1,699 @@
+/*
+ *  sata_qstor.c - Pacific Digital Corporation QStor SATA
+ *
+ *  Maintained by:  Mark Lord <mlord@pobox.com>
+ *
+ *  Copyright 2005 Pacific Digital Corporation.
+ *  (OSL/GPL code release authorized by Jalil Fadavi).
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the terms
+ *  of the GNU General Public License version 2 (the "GPL") as distributed
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above and
+ *  replace them with the notice and other provisions required by the GPL.
+ *  If you do not delete the provisions above, a recipient may use your
+ *  version of this file under either the OSL or the GPL.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <asm/io.h>
+#include <linux/libata.h>
+
+#define DRV_NAME	"sata_qstor"
+#define DRV_VERSION	"0.03"
+
+enum {
+	QS_PORTS		= 4,
+	QS_MAX_PRD		= LIBATA_MAX_PRD,
+	QS_CPB_ORDER		= 6,
+	QS_CPB_BYTES		= (1 << QS_CPB_ORDER),
+	QS_PRD_BYTES		= QS_MAX_PRD * 16,
+	QS_PKT_BYTES		= QS_CPB_BYTES + QS_PRD_BYTES,
+
+	QS_DMA_BOUNDARY		= ~0UL,
+
+	/* global register offsets */
+	QS_HCF_CNFG3		= 0x0003, /* host configuration offset */
+	QS_HID_HPHY		= 0x0004, /* host physical interface info */
+	QS_HCT_CTRL		= 0x00e4, /* global interrupt mask offset */
+	QS_HST_SFF		= 0x0100, /* host status fifo offset */
+	QS_HVS_SERD3		= 0x0393, /* PHY enable offset */
+
+	/* global control bits */
+	QS_HPHY_64BIT		= (1 << 1), /* 64-bit bus detected */
+	QS_CNFG3_GSRST		= 0x01,     /* global chip reset */
+	QS_SERD3_PHY_ENA	= 0xf0,     /* PHY detection ENAble*/
+
+	/* per-channel register offsets */
+	QS_CCF_CPBA		= 0x0710, /* chan CPB base address */
+	QS_CCF_CSEP		= 0x0718, /* chan CPB separation factor */
+	QS_CFC_HUFT		= 0x0800, /* host upstream fifo threshold */
+	QS_CFC_HDFT		= 0x0804, /* host downstream fifo threshold */
+	QS_CFC_DUFT		= 0x0808, /* dev upstream fifo threshold */
+	QS_CFC_DDFT		= 0x080c, /* dev downstream fifo threshold */
+	QS_CCT_CTR0		= 0x0900, /* chan control-0 offset */
+	QS_CCT_CTR1		= 0x0901, /* chan control-1 offset */
+	QS_CCT_CFF		= 0x0a00, /* chan command fifo offset */
+
+	/* channel control bits */
+	QS_CTR0_REG		= (1 << 1),   /* register mode (vs. pkt mode) */
+	QS_CTR0_CLER		= (1 << 2),   /* clear channel errors */
+	QS_CTR1_RDEV		= (1 << 1),   /* sata phy/comms reset */
+	QS_CTR1_RCHN		= (1 << 4),   /* reset channel logic */
+	QS_CCF_RUN_PKT		= 0x107,      /* RUN a new dma PKT */
+
+	/* pkt sub-field headers */
+	QS_HCB_HDR		= 0x01,   /* Host Control Block header */
+	QS_DCB_HDR		= 0x02,   /* Device Control Block header */
+
+	/* pkt HCB flag bits */
+	QS_HF_DIRO		= (1 << 0),   /* data DIRection Out */
+	QS_HF_DAT		= (1 << 3),   /* DATa pkt */
+	QS_HF_IEN		= (1 << 4),   /* Interrupt ENable */
+	QS_HF_VLD		= (1 << 5),   /* VaLiD pkt */
+
+	/* pkt DCB flag bits */
+	QS_DF_PORD		= (1 << 2),   /* Pio OR Dma */
+	QS_DF_ELBA		= (1 << 3),   /* Extended LBA (lba48) */
+
+	/* PCI device IDs */
+	board_2068_idx		= 0,	/* QStor 4-port SATA/RAID */
+};
+
+typedef enum { qs_state_idle, qs_state_pkt, qs_state_mmio } qs_state_t;
+
+struct qs_port_priv {
+	u8			*pkt;
+	dma_addr_t		pkt_dma;
+	qs_state_t		state;
+};
+
+static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int qs_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static irqreturn_t qs_intr (int irq, void *dev_instance, struct pt_regs *regs);
+static int qs_port_start(struct ata_port *ap);
+static void qs_host_stop(struct ata_host_set *host_set);
+static void qs_port_stop(struct ata_port *ap);
+static void qs_phy_reset(struct ata_port *ap);
+static void qs_qc_prep(struct ata_queued_cmd *qc);
+static int qs_qc_issue(struct ata_queued_cmd *qc);
+static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
+static void qs_bmdma_stop(struct ata_port *ap);
+static u8 qs_bmdma_status(struct ata_port *ap);
+static void qs_irq_clear(struct ata_port *ap);
+
+static Scsi_Host_Template qs_ata_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.detect			= ata_scsi_detect,
+	.release		= ata_scsi_release,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= QS_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.use_new_eh_code	= ATA_SHT_NEW_EH_CODE,
+	.emulated		= ATA_SHT_EMULATED,
+	//FIXME .use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.use_clustering		= ENABLE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations qs_ata_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.check_atapi_dma	= qs_check_atapi_dma,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+	.phy_reset		= qs_phy_reset,
+	.qc_prep		= qs_qc_prep,
+	.qc_issue		= qs_qc_issue,
+	.eng_timeout		= ata_eng_timeout,
+	.irq_handler		= qs_intr,
+	.irq_clear		= qs_irq_clear,
+	.scr_read		= qs_scr_read,
+	.scr_write		= qs_scr_write,
+	.port_start		= qs_port_start,
+	.port_stop		= qs_port_stop,
+	.host_stop		= qs_host_stop,
+	.bmdma_stop		= qs_bmdma_stop,
+	.bmdma_status		= qs_bmdma_status,
+};
+
+static struct ata_port_info qs_port_info[] = {
+	/* board_2068_idx */
+	{
+		.sht		= &qs_ata_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SATA_RESET |
+				  //FIXME ATA_FLAG_SRST |
+				  ATA_FLAG_MMIO,
+		.pio_mask	= 0x10, /* pio4 */
+		.udma_mask	= 0x7f, /* udma0-6 */
+		.port_ops	= &qs_ata_ops,
+	},
+};
+
+static struct pci_device_id qs_ata_pci_tbl[] = {
+	{ PCI_VENDOR_ID_PDC, 0x2068, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2068_idx },
+
+	{ }	/* terminate list */
+};
+
+static struct pci_driver qs_ata_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= qs_ata_pci_tbl,
+	.probe			= qs_ata_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static int qs_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	return 1;	/* ATAPI DMA not supported */
+}
+
+static void qs_bmdma_stop(struct ata_port *ap)
+{
+	/* nothing */
+}
+
+static u8 qs_bmdma_status(struct ata_port *ap)
+{
+	return 0;
+}
+
+static void qs_irq_clear(struct ata_port *ap)
+{
+	/* nothing */
+}
+
+static void qs_enter_reg_mode(struct ata_port *ap)
+{
+	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
+
+	writeb(QS_CTR0_REG, chan + QS_CCT_CTR0);
+	readb(chan + QS_CCT_CTR0);        /* flush */
+}
+
+static void qs_phy_reset(struct ata_port *ap)
+{
+	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
+	struct qs_port_priv *pp = ap->private_data;
+
+	pp->state = qs_state_idle;
+	writeb(QS_CTR1_RCHN, chan + QS_CCT_CTR1);
+	qs_enter_reg_mode(ap);
+	sata_phy_reset(ap);
+}
+
+static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	if (sc_reg > SCR_CONTROL)
+		return ~0U;
+	return readl((void __iomem *)(ap->ioaddr.scr_addr + (sc_reg * 8)));
+}
+
+static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	if (sc_reg > SCR_CONTROL)
+		return;
+	writel(val, (void __iomem *)(ap->ioaddr.scr_addr + (sc_reg * 8)));
+}
+
+static void qs_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct scatterlist *sg = qc->sg;
+	struct ata_port *ap = qc->ap;
+	struct qs_port_priv *pp = ap->private_data;
+	unsigned int nelem;
+	u8 *prd = pp->pkt + QS_CPB_BYTES;
+
+	assert(sg != NULL);
+	assert(qc->n_elem > 0);
+
+	for (nelem = 0; nelem < qc->n_elem; nelem++,sg++) {
+		u64 addr;
+		u32 len;
+
+		addr = sg_dma_address(sg);
+		*(__le64 *)prd = cpu_to_le64(addr);
+		prd += sizeof(u64);
+
+		len = sg_dma_len(sg);
+		*(__le32 *)prd = cpu_to_le32(len);
+		prd += sizeof(u64);
+
+		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
+					(unsigned long long)addr, len);
+	}
+}
+
+static void qs_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct qs_port_priv *pp = qc->ap->private_data;
+	u8 dflags = QS_DF_PORD, *buf = pp->pkt;
+	u8 hflags = QS_HF_DAT | QS_HF_IEN | QS_HF_VLD;
+	u64 addr;
+
+	VPRINTK("ENTER\n");
+
+	qs_enter_reg_mode(qc->ap);
+	if (qc->tf.protocol != ATA_PROT_DMA) {
+		ata_qc_prep(qc);
+		return;
+	}
+
+	qs_fill_sg(qc);
+
+	if ((qc->tf.flags & ATA_TFLAG_WRITE))
+		hflags |= QS_HF_DIRO;
+	if ((qc->tf.flags & ATA_TFLAG_LBA48))
+		dflags |= QS_DF_ELBA;
+
+	/* host control block (HCB) */
+	buf[ 0] = QS_HCB_HDR;
+	buf[ 1] = hflags;
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(__le32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
+	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
+	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
+
+	/* device control block (DCB) */
+	buf[24] = QS_DCB_HDR;
+	buf[28] = dflags;
+
+	/* frame information structure (FIS) */
+	ata_tf_to_fis(&qc->tf, &buf[32], 0);
+}
+
+static inline void qs_packet_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
+
+	VPRINTK("ENTER, ap %p\n", ap);
+
+	writeb(QS_CTR0_CLER, chan + QS_CCT_CTR0);
+	wmb();                             /* flush PRDs and pkt to memory */
+	writel(QS_CCF_RUN_PKT, chan + QS_CCT_CFF);
+	readl(chan + QS_CCT_CFF);          /* flush */
+}
+
+static int qs_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct qs_port_priv *pp = qc->ap->private_data;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+
+		pp->state = qs_state_pkt;
+		qs_packet_start(qc);
+		return 0;
+
+	case ATA_PROT_ATAPI_DMA:
+		BUG();
+		break;
+
+	default:
+		break;
+	}
+
+	pp->state = qs_state_mmio;
+	return ata_qc_issue_prot(qc);
+}
+
+static inline unsigned int qs_intr_pkt(struct ata_host_set *host_set)
+{
+	unsigned int handled = 0;
+	u8 sFFE;
+	u8 __iomem *mmio_base = host_set->mmio_base;
+
+	do {
+		u32 sff0 = readl(mmio_base + QS_HST_SFF);
+		u32 sff1 = readl(mmio_base + QS_HST_SFF + 4);
+		u8 sEVLD = (sff1 >> 30) & 0x01;	/* valid flag */
+		sFFE  = sff1 >> 31;		/* empty flag */
+
+		if (sEVLD) {
+			u8 sDST = sff0 >> 16;	/* dev status */
+			u8 sHST = sff1 & 0x3f;	/* host status */
+			unsigned int port_no = (sff1 >> 8) & 0x03;
+			struct ata_port *ap = host_set->ports[port_no];
+
+			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
+					sff1, sff0, port_no, sHST, sDST);
+			handled = 1;
+			if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+				struct ata_queued_cmd *qc;
+				struct qs_port_priv *pp = ap->private_data;
+				if (!pp || pp->state != qs_state_pkt)
+					continue;
+				qc = ata_qc_from_tag(ap, ap->active_tag);
+				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+					switch (sHST) {
+					case 0: /* sucessful CPB */
+					case 3: /* device error */
+						pp->state = qs_state_idle;
+						qs_enter_reg_mode(qc->ap);
+						ata_qc_complete(qc, sDST);
+						break;
+					default:
+						break;
+					}
+				}
+			}
+		}
+	} while (!sFFE);
+	return handled;
+}
+
+static inline unsigned int qs_intr_mmio(struct ata_host_set *host_set)
+{
+	unsigned int handled = 0, port_no;
+
+	for (port_no = 0; port_no < host_set->n_ports; ++port_no) {
+		struct ata_port *ap;
+		ap = host_set->ports[port_no];
+		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			struct ata_queued_cmd *qc;
+			struct qs_port_priv *pp = ap->private_data;
+			if (!pp || pp->state != qs_state_mmio)
+				continue;
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+
+				/* check main status, clearing INTRQ */
+				u8 status = ata_chk_status(ap);
+				if ((status & ATA_BUSY))
+					continue;
+				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
+					ap->id, qc->tf.protocol, status);
+		
+				/* complete taskfile transaction */
+				pp->state = qs_state_idle;
+				ata_qc_complete(qc, status);
+				handled = 1;
+			}
+		}
+	}
+	return handled;
+}
+
+static irqreturn_t qs_intr(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned int handled = 0;
+
+	VPRINTK("ENTER\n");
+
+	spin_lock(&host_set->lock);
+	handled  = qs_intr_pkt(host_set) | qs_intr_mmio(host_set);
+	spin_unlock(&host_set->lock);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+static void qs_ata_setup_port(struct ata_ioports *port, unsigned long base)
+{
+	port->cmd_addr		=
+	port->data_addr		= base + 0x400;
+	port->error_addr	=
+	port->feature_addr	= base + 0x408; /* hob_feature = 0x409 */
+	port->nsect_addr	= base + 0x410; /* hob_nsect   = 0x411 */
+	port->lbal_addr		= base + 0x418; /* hob_lbal    = 0x419 */
+	port->lbam_addr		= base + 0x420; /* hob_lbam    = 0x421 */
+	port->lbah_addr		= base + 0x428; /* hob_lbah    = 0x429 */
+	port->device_addr	= base + 0x430;
+	port->status_addr	=
+	port->command_addr	= base + 0x438;
+	port->altstatus_addr	=
+	port->ctl_addr		= base + 0x440;
+	port->scr_addr		= base + 0xc00;
+}
+
+static int qs_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct qs_port_priv *pp;
+	void __iomem *mmio_base = ap->host_set->mmio_base;
+	void __iomem *chan = mmio_base + (ap->port_no * 0x4000);
+	u64 addr;
+	int rc;
+
+	rc = ata_port_start(ap);
+	if (rc)
+		return rc;
+	qs_enter_reg_mode(ap);
+	pp = kcalloc(1, sizeof(*pp), GFP_KERNEL);
+	if (!pp) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+	pp->pkt = dma_alloc_coherent(dev, QS_PKT_BYTES, &pp->pkt_dma,
+								GFP_KERNEL);
+	if (!pp->pkt) {
+		rc = -ENOMEM;
+		goto err_out_kfree;
+	}
+	memset(pp->pkt, 0, QS_PKT_BYTES);
+	ap->private_data = pp;
+
+	addr = (u64)pp->pkt_dma;
+	writel((u32) addr,        chan + QS_CCF_CPBA);
+	writel((u32)(addr >> 32), chan + QS_CCF_CPBA + 4);
+	return 0;
+
+err_out_kfree:
+	kfree(pp);
+err_out:
+	ata_port_stop(ap);
+	return rc;
+}
+
+static void qs_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct qs_port_priv *pp = ap->private_data;
+
+	if (pp != NULL) {
+		ap->private_data = NULL;
+		if (pp->pkt != NULL)
+			dma_free_coherent(dev, QS_PKT_BYTES, pp->pkt,
+								pp->pkt_dma);
+		kfree(pp);
+	}
+	ata_port_stop(ap);
+}
+
+static void qs_host_stop(struct ata_host_set *host_set)
+{
+	void __iomem *mmio_base = host_set->mmio_base;
+
+	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
+	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
+}
+
+static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
+{
+	void __iomem *mmio_base = pe->mmio_base;
+	unsigned int port_no;
+
+	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
+	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
+
+	/* reset each channel in turn */
+	for (port_no = 0; port_no < pe->n_ports; ++port_no) {
+		u8 __iomem *chan = mmio_base + (port_no * 0x4000);
+		writeb(QS_CTR1_RDEV|QS_CTR1_RCHN, chan + QS_CCT_CTR1);
+		writeb(QS_CTR0_REG, chan + QS_CCT_CTR0);
+		readb(chan + QS_CCT_CTR0);        /* flush */
+	}
+	writeb(QS_SERD3_PHY_ENA, mmio_base + QS_HVS_SERD3); /* enable phy */
+
+	for (port_no = 0; port_no < pe->n_ports; ++port_no) {
+		u8 __iomem *chan = mmio_base + (port_no * 0x4000);
+		/* set FIFO depths to same settings as Windows driver */
+		writew(32, chan + QS_CFC_HUFT);
+		writew(32, chan + QS_CFC_HDFT);
+		writew(10, chan + QS_CFC_DUFT);
+		writew( 8, chan + QS_CFC_DDFT);
+		/* set CPB size in bytes, as a power of two */
+		writeb(QS_CPB_ORDER,    chan + QS_CCF_CSEP);
+	}
+	writeb(1, mmio_base + QS_HCT_CTRL); /* enable host interrupts */
+}
+
+/*
+ * The QStor understands 64-bit buses, and uses 64-bit fields
+ * for DMA pointers regardless of bus width.  We just have to
+ * make sure our DMA masks are set appropriately for whatever
+ * bridge lies between us and the QStor, and then the DMA mapping
+ * code will ensure we only ever "see" appropriate buffer addresses.
+ * If we're 32-bit limited somewhere, then our 64-bit fields will
+ * just end up with zeros in the upper 32-bits, without any special
+ * logic required outside of this routine (below).
+ */
+static int qs_set_dma_masks(struct pci_dev *pdev, void __iomem *mmio_base)
+{
+	u32 bus_info = readl(mmio_base + QS_HID_HPHY);
+	int rc, have_64bit_bus = (bus_info & QS_HPHY_64BIT);
+
+	if (have_64bit_bus &&
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+	    	/* do nothing */
+	} else {
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (rc) {
+			printk(KERN_ERR DRV_NAME
+				"(%s): 32-bit DMA enable failed\n",
+				pci_name(pdev));
+			return rc;
+		}
+	}
+	return 0;
+}
+
+static int qs_ata_init_one(struct pci_dev *pdev,
+				const struct pci_device_id *ent)
+{
+	static int printed_version;
+	struct ata_probe_ent *probe_ent = NULL;
+	void __iomem *mmio_base;
+	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int rc, port_no;
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+	if ((pci_resource_flags(pdev, 4) & IORESOURCE_MEM) == 0) {
+		rc = -ENODEV;
+		goto err_out_regions;
+	}
+
+	mmio_base = ioremap(pci_resource_start(pdev, 4),
+		            pci_resource_len(pdev, 4));
+	if (mmio_base == NULL) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	rc = qs_set_dma_masks(pdev, mmio_base);
+	if (rc)
+		goto err_out_iounmap;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL) {
+		rc = -ENOMEM;
+		goto err_out_iounmap;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->dev = pci_dev_to_dev(pdev);
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	probe_ent->sht		= qs_port_info[board_idx].sht;
+	probe_ent->host_flags	= qs_port_info[board_idx].host_flags;
+	probe_ent->pio_mask	= qs_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= qs_port_info[board_idx].mwdma_mask;
+	probe_ent->udma_mask	= qs_port_info[board_idx].udma_mask;
+	probe_ent->port_ops	= qs_port_info[board_idx].port_ops;
+
+	probe_ent->irq		= pdev->irq;
+	probe_ent->irq_flags	= SA_SHIRQ;
+	probe_ent->mmio_base	= mmio_base;
+	probe_ent->n_ports	= QS_PORTS;
+
+	for (port_no = 0; port_no < probe_ent->n_ports; ++port_no) {
+		unsigned long chan = (unsigned long)mmio_base +
+							(port_no * 0x4000);
+		qs_ata_setup_port(&probe_ent->port[port_no], chan);
+	}
+
+	pci_set_master(pdev);
+
+	/* initialize adapter */
+	qs_host_init(board_idx, probe_ent);
+
+	ata_add_to_probe_list(probe_ent);
+	return 0;
+
+err_out_iounmap:
+	iounmap(mmio_base);
+err_out_regions:
+	pci_release_regions(pdev);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static int __init qs_ata_init(void)
+{
+	int rc;
+
+	rc = pci_module_init(&qs_ata_pci_driver);
+	if (rc)
+		return rc;
+
+	rc = scsi_register_module(MODULE_SCSI_HA, &qs_ata_sht);
+	if (rc) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	pci_unregister_driver(&qs_ata_pci_driver);
+	return rc;
+}
+
+static void __exit qs_ata_exit(void)
+{
+	scsi_unregister_module(MODULE_SCSI_HA, &qs_ata_sht);
+	pci_unregister_driver(&qs_ata_pci_driver);
+}
+
+MODULE_AUTHOR("Mark Lord");
+MODULE_DESCRIPTION("Pacific Digital Corporation QStor SATA low-level driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, qs_ata_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+
+module_init(qs_ata_init);
+module_exit(qs_ata_exit);
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-03-02 23:23:22 -05:00
@@ -140,6 +140,8 @@
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -337,6 +339,7 @@
 	void *mmio_base;
 	int rc;
 	unsigned int i;
+	int pci_dev_busy = 0;
 	u32 tmp, irq_mask;
 
 	if (!printed_version++)
@@ -351,8 +354,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -434,7 +439,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_sis.c	2005-03-02 23:23:22 -05:00
@@ -103,6 +103,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -201,14 +203,17 @@
 	int rc;
 	u32 genctl;
 	struct ata_port_info *ppi;
+	int pci_dev_busy = 0;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -255,7 +260,8 @@
 	pci_release_regions(pdev);
 
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 
 }
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_svw.c	2005-03-02 23:23:22 -05:00
@@ -302,6 +302,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -339,6 +341,7 @@
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
 	void *mmio_base;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -360,8 +363,10 @@
 
 	/* Request PCI regions */
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -429,7 +434,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_sx4.c	2005-03-02 23:23:22 -05:00
@@ -1191,8 +1191,7 @@
 	   		error = 0;
 	   		break;     
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((i * 100) * HZ / 1000 + 1);
+		msleep(i*100);
    	}
    	return error;
 }
@@ -1225,8 +1224,7 @@
 	readl(mmio + PDC_TIME_CONTROL);
 
 	/* Wait 3 seconds */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(3 * HZ);
+	msleep(3000);
 
 	/* 
 	   When timer is enabled, counter is decreased every internal
@@ -1369,6 +1367,7 @@
 	void *mmio_base, *dimm_mmio = NULL;
 	struct pdc_host_priv *hpriv = NULL;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -1383,8 +1382,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -1469,7 +1470,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_uli.c	2005-03-02 23:23:22 -05:00
@@ -98,6 +98,8 @@
 
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -186,14 +188,17 @@
 	struct ata_port_info *ppi;
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -256,7 +261,8 @@
 	pci_release_regions(pdev);
 
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 
 }
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_via.c	2005-03-02 23:23:22 -05:00
@@ -24,6 +24,11 @@
    If you do not delete the provisions above, a recipient may use your
    version of this file under either the OSL or the GPL.
 
+   ----------------------------------------------------------------------
+
+   To-do list:
+   * VT6421 PATA support
+
  */
 
 #include <linux/kernel.h>
@@ -38,11 +43,14 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"1.0"
+#define DRV_VERSION	"1.1"
 
-enum {
-	via_sata		= 0,
+enum board_ids_enum {
+	vt6420,
+	vt6421,
+};
 
+enum {
 	SATA_CHAN_ENAB		= 0x40, /* SATA channel enable */
 	SATA_INT_GATE		= 0x41, /* SATA interrupt gating */
 	SATA_NATIVE_MODE	= 0x42, /* Native mode enable */
@@ -50,10 +58,8 @@
 
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
-
-	ENAB_ALL		= PORT0 | PORT1,
-
-	INT_GATE_ALL		= PORT0 | PORT1,
+	ALL_PORTS		= PORT0 | PORT1,
+	N_PORTS			= 2,
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -66,7 +72,8 @@
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id svia_pci_tbl[] = {
-	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
+	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
+	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
 
 	{ }	/* terminate list */
 };
@@ -111,6 +118,9 @@
 
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -159,18 +169,132 @@
 	8, 4, 8, 4, 16, 256
 };
 
+static const unsigned int vt6421_bar_sizes[] = {
+	16, 16, 16, 16, 32, 128
+};
+
 static unsigned long svia_scr_addr(unsigned long addr, unsigned int port)
 {
 	return addr + (port * 128);
 }
 
+static unsigned long vt6421_scr_addr(unsigned long addr, unsigned int port)
+{
+	return addr + (port * 64);
+}
+
+static void vt6421_init_addrs(struct ata_probe_ent *probe_ent,
+			      struct pci_dev *pdev,
+			      unsigned int port)
+{
+	unsigned long reg_addr = pci_resource_start(pdev, port);
+	unsigned long bmdma_addr = pci_resource_start(pdev, 4) + (port * 8);
+	unsigned long scr_addr;
+
+	probe_ent->port[port].cmd_addr = reg_addr;
+	probe_ent->port[port].altstatus_addr =
+	probe_ent->port[port].ctl_addr = (reg_addr + 8) | ATA_PCI_CTL_OFS;
+	probe_ent->port[port].bmdma_addr = bmdma_addr;
+
+	scr_addr = vt6421_scr_addr(pci_resource_start(pdev, 5), port);
+	probe_ent->port[port].scr_addr = scr_addr;
+
+	ata_std_ports(&probe_ent->port[port]);
+}
+
+static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
+{
+	struct ata_probe_ent *probe_ent;
+	struct ata_port_info *ppi = &svia_port_info;
+
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
+	if (!probe_ent)
+		return NULL;
+
+	probe_ent->port[0].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 0);
+	probe_ent->port[1].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 1);
+
+	return probe_ent;
+}
+
+static struct ata_probe_ent *vt6421_init_probe_ent(struct pci_dev *pdev)
+{
+	struct ata_probe_ent *probe_ent;
+	unsigned int i;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent)
+		return NULL;
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->dev = pci_dev_to_dev(pdev);
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	probe_ent->sht		= &svia_sht;
+	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+				  ATA_FLAG_NO_LEGACY;
+	probe_ent->port_ops	= &svia_sata_ops;
+	probe_ent->n_ports	= N_PORTS;
+	probe_ent->irq		= pdev->irq;
+	probe_ent->irq_flags	= SA_SHIRQ;
+	probe_ent->pio_mask	= 0x1f;
+	probe_ent->mwdma_mask	= 0x07;
+	probe_ent->udma_mask	= 0x7f;
+
+	for (i = 0; i < N_PORTS; i++)
+		vt6421_init_addrs(probe_ent, pdev, i);
+
+	return probe_ent;
+}
+
+static void svia_configure(struct pci_dev *pdev)
+{
+	u8 tmp8;
+
+	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
+	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
+	       pci_name(pdev),
+	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
+
+	/* make sure SATA channels are enabled */
+	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
+	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= ALL_PORTS;
+		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
+	}
+
+	/* make sure interrupts for each channel sent to us */
+	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
+	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= ALL_PORTS;
+		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
+	}
+
+	/* make sure native mode is enabled */
+	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
+	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel native mode (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= NATIVE_MODE_ALL;
+		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
+	}
+}
+
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	unsigned int i;
 	int rc;
-	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	int board_id = (int) ent->driver_data;
+	const int *bar_sizes;
+	int pci_dev_busy = 0;
 	u8 tmp8;
 
 	if (!printed_version++)
@@ -181,20 +305,28 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
-	pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
-	if (tmp8 & SATA_2DEV) {
-		printk(KERN_ERR DRV_NAME "(%s): SATA master/slave not supported (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		rc = -EIO;
-		goto err_out_regions;
+	if (board_id == vt6420) {
+		pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
+		if (tmp8 & SATA_2DEV) {
+			printk(KERN_ERR DRV_NAME "(%s): SATA master/slave not supported (0x%x)\n",
+		       	pci_name(pdev), (int) tmp8);
+			rc = -EIO;
+			goto err_out_regions;
+		}
+
+		bar_sizes = &svia_bar_sizes[0];
+	} else {
+		bar_sizes = &vt6421_bar_sizes[0];
 	}
 
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||
-		    (pci_resource_len(pdev, i) < svia_bar_sizes[i])) {
+		    (pci_resource_len(pdev, i) < bar_sizes[i])) {
 			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
 			       pci_name(pdev), i,
 			       pci_resource_start(pdev, i),
@@ -207,8 +339,11 @@
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &svia_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
+	if (board_id == vt6420)
+		probe_ent = vt6420_init_probe_ent(pdev);
+	else
+		probe_ent = vt6421_init_probe_ent(pdev);
+	
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       pci_name(pdev));
@@ -216,42 +351,7 @@
 		goto err_out_regions;
 	}
 
-	probe_ent->port[0].scr_addr =
-		svia_scr_addr(pci_resource_start(pdev, 5), 0);
-	probe_ent->port[1].scr_addr =
-		svia_scr_addr(pci_resource_start(pdev, 5), 1);
-
-	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
-	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
-	       pci_name(pdev),
-	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
-
-	/* make sure SATA channels are enabled */
-	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
-	if ((tmp8 & ENAB_ALL) != ENAB_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		tmp8 |= ENAB_ALL;
-		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
-	}
-
-	/* make sure interrupts for each channel sent to us */
-	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
-	if ((tmp8 & INT_GATE_ALL) != INT_GATE_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		tmp8 |= INT_GATE_ALL;
-		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
-	}
-
-	/* make sure native mode is enabled */
-	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
-	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel native mode (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		tmp8 |= NATIVE_MODE_ALL;
-		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
-	}
+	svia_configure(pdev);
 
 	pci_set_master(pdev);
 
@@ -262,7 +362,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-03-02 23:23:22 -05:00
+++ b/drivers/scsi/sata_vsc.c	2005-03-02 23:23:22 -05:00
@@ -218,6 +218,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -256,6 +258,7 @@
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
+	int pci_dev_busy = 0;
 	void *mmio_base;
 	int rc;
 
@@ -275,13 +278,15 @@
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
-	rc = pci_set_dma_mask(pdev, 0xFFFFFFFFULL);
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_regions;
 
@@ -348,7 +353,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/include/linux/libata-compat.h b/include/linux/libata-compat.h
--- a/include/linux/libata-compat.h	2005-03-02 23:23:22 -05:00
+++ b/include/linux/libata-compat.h	2005-03-02 23:23:22 -05:00
@@ -1,8 +1,16 @@
 #ifndef __LIBATA_COMPAT_H__
 #define __LIBATA_COMPAT_H__
 
+#include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
+
+typedef u32 __le32;
+typedef u64 __le64;
+
+#define DMA_64BIT_MASK 0xffffffffffffffffULL
+#define DMA_32BIT_MASK 0x00000000ffffffffULL
 
 #define MODULE_VERSION(ver_str)
 
@@ -10,11 +18,6 @@
 	struct pci_dev pdev;
 };
 
-static inline void libata_msleep(unsigned long msecs)
-{
-	msleep(msecs);
-}
-
 static inline struct pci_dev *to_pci_dev(struct device *dev)
 {
 	return (struct pci_dev *) dev;
@@ -46,5 +49,14 @@
 	pci_get_drvdata(to_pci_dev(dev))
 #define dev_set_drvdata(dev,ptr) \
 	pci_set_drvdata(to_pci_dev(dev),(ptr))
+
+static inline void *kcalloc(size_t nmemb, size_t size, int flags)
+{
+	size_t total = nmemb * size;
+	void *mem = kmalloc(total, flags);
+	if (mem)
+		memset(mem, 0, total);
+	return mem;
+}
 
 #endif /* __LIBATA_COMPAT_H__ */
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2005-03-02 23:23:22 -05:00
+++ b/include/linux/libata.h	2005-03-02 23:23:22 -05:00
@@ -335,6 +335,8 @@
 
 	void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
 	u8   (*check_status)(struct ata_port *ap);
+	u8   (*check_altstatus)(struct ata_port *ap);
+	u8   (*check_err)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap);
@@ -361,6 +363,9 @@
 	void (*port_stop) (struct ata_port *ap);
 
 	void (*host_stop) (struct ata_host_set *host_set);
+
+	void (*bmdma_stop) (struct ata_port *ap);
+	u8   (*bmdma_status) (struct ata_port *ap);
 };
 
 struct ata_port_info {
@@ -401,6 +406,8 @@
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
+extern u8 ata_altstatus(struct ata_port *ap);
+extern u8 ata_chk_err(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
@@ -416,6 +423,8 @@
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
+extern void ata_bmdma_stop(struct ata_port *ap);
+extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
@@ -451,26 +460,11 @@
 		(dev->class == ATA_DEV_ATAPI));
 }
 
-static inline u8 ata_chk_err(struct ata_port *ap)
-{
-	if (ap->flags & ATA_FLAG_MMIO) {
-		return readb((void __iomem *) ap->ioaddr.error_addr);
-	}
-	return inb(ap->ioaddr.error_addr);
-}
-
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
 }
 
-static inline u8 ata_altstatus(struct ata_port *ap)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
-	return inb(ap->ioaddr.altstatus_addr);
-}
-
 static inline void ata_pause(struct ata_port *ap)
 {
 	ata_altstatus(ap);
@@ -592,46 +586,6 @@
 static inline unsigned int sata_dev_present(struct ata_port *ap)
 {
 	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;
-}
-
-static inline void ata_bmdma_stop(struct ata_port *ap)
-{
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-		      mmio + ATA_DMA_CMD);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-		    ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	}
-
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);	      /* dummy read */
-}
-
-static inline void ata_bmdma_ack_irq(struct ata_port *ap)
-{
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
-		writeb(readb(mmio), mmio);
-	} else {
-		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
-		outb(inb(addr), addr);
-	}
-}
-
-static inline u8 ata_bmdma_status(struct ata_port *ap)
-{
-	u8 host_stat;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-	} else
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	return host_stat;
 }
 
 static inline int ata_try_flush_cache(struct ata_device *dev)

--------------030101040407090003060009--
