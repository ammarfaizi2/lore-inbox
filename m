Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVG1Tsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVG1Tsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVG1TsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:48:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28875 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261561AbVG1Tqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:46:40 -0400
Message-ID: <42E93618.2070902@pobox.com>
Date: Thu, 28 Jul 2005 15:46:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [git patches] 2.4.x SATA update
Content-Type: multipart/mixed;
 boundary="------------000307020306060206010809"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000307020306060206010809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.4.git

which will update 2.4.x SATA to the latest, according to the attached 
diffstat/changelog/patch.


--------------000307020306060206010809
Content-Type: text/plain;
 name="libata-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.4.txt"

 drivers/scsi/ahci.c           |  127 ++++++---
 drivers/scsi/ata_piix.c       |   32 +-
 drivers/scsi/libata-core.c    |  555 +++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/libata-scsi.c    |   18 -
 drivers/scsi/libata.h         |    2 
 drivers/scsi/sata_nv.c        |    2 
 drivers/scsi/sata_promise.c   |   30 ++
 drivers/scsi/sata_qstor.c     |    2 
 drivers/scsi/sata_sil.c       |   10 
 drivers/scsi/sata_sis.c       |    1 
 drivers/scsi/sata_svw.c       |   28 +-
 drivers/scsi/sata_sx4.c       |    2 
 drivers/scsi/sata_uli.c       |    1 
 drivers/scsi/sata_via.c       |    1 
 drivers/scsi/sata_vsc.c       |    1 
 include/linux/ata.h           |    1 
 include/linux/libata-compat.h |    3 
 include/linux/libata.h        |   67 +++++
 18 files changed, 741 insertions(+), 142 deletions(-)


commit c9a8f5ab981ced23e95b72b25aa83e37880f2287
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Sat Jul 23 20:12:48 2005 -0400

    libata: update to 2.6.x latest
    
    Minor stuff:
    * doc updates
    * pci id updates
    * new ->host_stop behavior
    * fix bugs in PIO data xfer, SATA probe, large disk SCSI xlat


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -38,7 +38,8 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"1.00"
+#define DRV_VERSION	"1.01"
+
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -48,6 +49,7 @@ enum {
 	AHCI_CMD_SLOT_SZ	= 32 * 32,
 	AHCI_RX_FIS_SZ		= 256,
 	AHCI_CMD_TBL_HDR	= 0x80,
+	AHCI_CMD_TBL_CDB	= 0x40,
 	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
 				  AHCI_RX_FIS_SZ,
@@ -132,6 +134,9 @@ enum {
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+
+	/* hpriv->flags bits */
+	AHCI_FLAG_MSI		= (1 << 0),
 };
 
 struct ahci_cmd_hdr {
@@ -181,13 +186,14 @@ static void ahci_qc_prep(struct ata_queu
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static void ahci_remove_one (struct pci_dev *pdev);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -256,6 +262,12 @@ static struct pci_device_id ahci_pci_tbl
 	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ULi M5288 */
+	{ PCI_VENDOR_ID_INTEL, 0x2681, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_INTEL, 0x2682, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ESB2 */
 	{ }	/* terminate list */
 };
 
@@ -264,7 +276,7 @@ static struct pci_driver ahci_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= ahci_remove_one,
 };
 
 
@@ -282,6 +294,8 @@ static void ahci_host_stop(struct ata_ho
 {
 	struct ahci_host_priv *hpriv = host_set->private_data;
 	kfree(hpriv);
+
+	ata_host_stop(host_set);
 }
 
 static int ahci_port_start(struct ata_port *ap)
@@ -289,26 +303,19 @@ static int ahci_port_start(struct ata_po
 	struct device *dev = ap->host_set->dev;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp;
-	int rc;
 	void *mem, *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
 	dma_addr_t mem_dma;
 
-	rc = ata_port_start(ap);
-	if (rc)
-		return rc;
-
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
+	if (!pp)
+		return -ENOMEM;
 	memset(pp, 0, sizeof(*pp));
 
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
+		kfree(pp);
+		return -ENOMEM;
 	}
 	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
@@ -358,12 +365,6 @@ static int ahci_port_start(struct ata_po
 	readl(port_mmio + PORT_CMD); /* flush */
 
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
 }
 
 
@@ -389,7 +390,6 @@ static void ahci_port_stop(struct ata_po
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
 			  pp->cmd_slot, pp->cmd_slot_dma);
 	kfree(pp);
-	ata_port_stop(ap);
 }
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
@@ -496,7 +496,8 @@ static void ahci_fill_sg(struct ata_queu
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 
@@ -508,18 +509,8 @@ static void ahci_qc_prep(struct ata_queu
 	opts = (qc->n_elem << 16) | cmd_fis_len;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
-
-	switch (qc->tf.protocol) {
-	case ATA_PROT_ATAPI:
-	case ATA_PROT_ATAPI_NODATA:
-	case ATA_PROT_ATAPI_DMA:
+	if (is_atapi_taskfile(&qc->tf))
 		opts |= AHCI_CMD_ATAPI;
-		break;
-
-	default:
-		/* do nothing */
-		break;
-	}
 
 	pp->cmd_slot[0].opts = cpu_to_le32(opts);
 	pp->cmd_slot[0].status = 0;
@@ -531,6 +522,10 @@ static void ahci_qc_prep(struct ata_queu
 	 * a SATA Register - Host to Device command FIS.
 	 */
 	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+	if (opts & AHCI_CMD_ATAPI) {
+		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
+		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, ap->cdb_len);
+	}
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
@@ -853,15 +848,19 @@ static int ahci_host_init(struct ata_pro
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
+static void pci_intx(struct pci_dev *pdev, int enable)
 {
-	u16 pci_command;
+	u16 pci_command, new;
 
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
 }
 
 static void ahci_print_info(struct ata_probe_ent *probe_ent)
@@ -943,7 +942,7 @@ static int ahci_init_one (struct pci_dev
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
+	int have_msi, pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -961,12 +960,17 @@ static int ahci_init_one (struct pci_dev
 		goto err_out;
 	}
 
-	pci_enable_intx(pdev);
+	if (pci_enable_msi(pdev) == 0)
+		have_msi = 1;
+	else {
+		pci_intx(pdev, 1);
+		have_msi = 0;
+	}
 
 	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
-		goto err_out_regions;
+		goto err_out_msi;
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
@@ -999,6 +1003,9 @@ static int ahci_init_one (struct pci_dev
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
+	if (have_msi)
+		hpriv->flags |= AHCI_FLAG_MSI;
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
@@ -1016,7 +1023,11 @@ err_out_iounmap:
 	iounmap(mmio_base);
 err_out_free_ent:
 	kfree(probe_ent);
-err_out_regions:
+err_out_msi:
+	if (have_msi)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
 	pci_release_regions(pdev);
 err_out:
 	if (!pci_dev_busy)
@@ -1024,6 +1035,38 @@ err_out:
 	return rc;
 }
 
+static void ahci_remove_one (struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	struct ata_port *ap;
+	Scsi_Host_Template *sht;
+	int have_msi, rc;
+
+	/* FIXME: this unregisters all ports attached to the
+	 * Scsi_Host_Template given.  We _might_ have multiple
+	 * templates (though we don't ATM), so this is ok... for now.
+	 */
+	ap = host_set->ports[0];
+	sht = ap->host->hostt;
+	rc = scsi_unregister_module(MODULE_SCSI_HA, sht);
+	/* FIXME: handle 'rc' failure? */
+
+	have_msi = hpriv->flags & AHCI_FLAG_MSI;
+	free_irq(host_set->irq, host_set);
+
+	host_set->ops->host_stop(host_set);
+	kfree(host_set);
+
+	if (have_msi)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	dev_set_drvdata(dev, NULL);
+}
 
 static int __init ahci_init(void)
 {
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -61,6 +61,7 @@ enum {
 	ich6_sata		= 3,
 	ich6_sata_rm		= 4,
 	ich7_sata		= 5,
+	esb2_sata		= 6,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -93,6 +94,7 @@ static struct pci_device_id piix_pci_tbl
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
 
 	{ }	/* terminate list */
 };
@@ -151,6 +153,7 @@ static struct ata_port_operations piix_p
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_operations piix_sata_ops = {
@@ -178,6 +181,7 @@ static struct ata_port_operations piix_s
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info piix_port_info[] = {
@@ -256,6 +260,18 @@ static struct ata_port_info piix_port_in
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* esb2_sata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
@@ -650,15 +666,6 @@ static int piix_init_one (struct pci_dev
 	return ata_pci_init_one(pdev, port_info, n_ports);
 }
 
-/**
- *	piix_init -
- *
- *	LOCKING:
- *
- *	RETURNS:
- *
- */
-
 static int __init piix_init(void)
 {
 	int rc;
@@ -685,13 +692,6 @@ err_out:
 	return rc;
 }
 
-/**
- *	piix_exit -
- *
- *	LOCKING:
- *
- */
-
 static void __exit piix_exit(void)
 {
 	scsi_unregister_module(MODULE_SCSI_HA, &piix_sht);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -185,6 +185,28 @@ static void ata_tf_load_mmio(struct ata_
 	ata_wait_idle(ap);
 }
 
+
+/**
+ *	ata_tf_load - send taskfile registers to host controller
+ *	@ap: Port to which output is sent
+ *	@tf: ATA taskfile register set
+ *
+ *	Outputs ATA taskfile to standard ATA host controller using MMIO
+ *	or PIO as indicated by the ATA_FLAG_MMIO flag.
+ *	Writes the control, feature, nsect, lbal, lbam, and lbah registers.
+ *	Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
+ *	hob_lbal, hob_lbam, and hob_lbah.
+ *
+ *	This function waits for idle (!BUSY and !DRQ) after writing
+ *	registers.  If the control register has a new value, this
+ *	function also waits for idle after writing control and before
+ *	writing the remaining registers.
+ *
+ *	May be used as the tf_load() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 void ata_tf_load(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -194,11 +216,11 @@ void ata_tf_load(struct ata_port *ap, st
 }
 
 /**
- *	ata_exec_command - issue ATA command to host controller
+ *	ata_exec_command_pio - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Issues PIO/MMIO write to ATA command register, with proper
+ *	Issues PIO write to ATA command register, with proper
  *	synchronization with interrupt handler / other threads.
  *
  *	LOCKING:
@@ -234,6 +256,18 @@ static void ata_exec_command_mmio(struct
 	ata_pause(ap);
 }
 
+
+/**
+ *	ata_exec_command - issue ATA command to host controller
+ *	@ap: port to which command is being issued
+ *	@tf: ATA taskfile register set
+ *
+ *	Issues PIO/MMIO write to ATA command register, with proper
+ *	synchronization with interrupt handler / other threads.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
 void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -304,7 +338,7 @@ void ata_tf_to_host_nolock(struct ata_po
 }
 
 /**
- *	ata_tf_read - input device's ATA taskfile shadow registers
+ *	ata_tf_read_pio - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
@@ -367,6 +401,23 @@ static void ata_tf_read_mmio(struct ata_
 	}
 }
 
+
+/**
+ *	ata_tf_read - input device's ATA taskfile shadow registers
+ *	@ap: Port from which input is read
+ *	@tf: ATA taskfile register set for storing input
+ *
+ *	Reads ATA taskfile registers for currently-selected device
+ *	into @tf.
+ *
+ *	Reads nsect, lbal, lbam, lbah, and device.  If ATA_TFLAG_LBA48
+ *	is set, also reads the hob registers.
+ *
+ *	May be used as the tf_read() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -380,7 +431,7 @@ void ata_tf_read(struct ata_port *ap, st
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
- *	and return it's value. This also clears pending interrupts
+ *	and return its value. This also clears pending interrupts
  *      from this device
  *
  *	LOCKING:
@@ -396,7 +447,7 @@ static u8 ata_check_status_pio(struct at
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
- *	via MMIO and return it's value. This also clears pending interrupts
+ *	via MMIO and return its value. This also clears pending interrupts
  *      from this device
  *
  *	LOCKING:
@@ -407,6 +458,20 @@ static u8 ata_check_status_mmio(struct a
        	return readb((void __iomem *) ap->ioaddr.status_addr);
 }
 
+
+/**
+ *	ata_check_status - Read device status reg & clear interrupt
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile status register for currently-selected device
+ *	and return its value. This also clears pending interrupts
+ *      from this device
+ *
+ *	May be used as the check_status() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 u8 ata_check_status(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -414,6 +479,20 @@ u8 ata_check_status(struct ata_port *ap)
 	return ata_check_status_pio(ap);
 }
 
+
+/**
+ *	ata_altstatus - Read device alternate status reg
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile alternate status register for
+ *	currently-selected device and return its value.
+ *
+ *	Note: may NOT be used as the check_altstatus() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 u8 ata_altstatus(struct ata_port *ap)
 {
 	if (ap->ops->check_altstatus)
@@ -424,6 +503,20 @@ u8 ata_altstatus(struct ata_port *ap)
 	return inb(ap->ioaddr.altstatus_addr);
 }
 
+
+/**
+ *	ata_chk_err - Read device error reg
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile error register for
+ *	currently-selected device and return its value.
+ *
+ *	Note: may NOT be used as the check_err() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 u8 ata_chk_err(struct ata_port *ap)
 {
 	if (ap->ops->check_err)
@@ -872,10 +965,24 @@ void ata_dev_id_string(u16 *id, unsigned
 	}
 }
 
+
+/**
+ *	ata_noop_dev_select - Select device 0/1 on ATA bus
+ *	@ap: ATA channel to manipulate
+ *	@device: ATA device (numbered from zero) to select
+ *
+ *	This function performs no actual function.
+ *
+ *	May be used as the dev_select() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	caller.
+ */
 void ata_noop_dev_select (struct ata_port *ap, unsigned int device)
 {
 }
 
+
 /**
  *	ata_std_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
@@ -883,7 +990,9 @@ void ata_noop_dev_select (struct ata_por
  *
  *	Use the method defined in the ATA specification to
  *	make either device 0, or device 1, active on the
- *	ATA channel.
+ *	ATA channel.  Works with both PIO and MMIO.
+ *
+ *	May be used as the dev_select() entry in ata_port_operations.
  *
  *	LOCKING:
  *	caller.
@@ -1185,11 +1294,47 @@ err_out:
 	DPRINTK("EXIT, err\n");
 }
 
+
+static inline u8 ata_dev_knobble(struct ata_port *ap)
+{
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
+}
+
+/**
+ * 	ata_dev_config - Run device specific handlers and check for
+ * 			 SATA->PATA bridges
+ * 	@ap: Bus 
+ * 	@i:  Device
+ *
+ * 	LOCKING:
+ */
+ 
+void ata_dev_config(struct ata_port *ap, unsigned int i)
+{
+	/* limit bridge transfers to udma5, 200 sectors */
+	if (ata_dev_knobble(ap)) {
+		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+			ap->id, ap->device->devno);
+		ap->udma_mask &= ATA_UDMA5;
+		ap->host->max_sectors = ATA_MAX_SECTORS;
+		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
+		ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+	}
+
+	if (ap->ops->dev_config)
+		ap->ops->dev_config(ap, &ap->device[i]);
+}
+
 /**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
  *
+ *	Master ATA bus probing function.  Initiates a hardware-dependent
+ *	bus reset, then attempts to identify any devices found on
+ *	the bus.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
  *	Zero on success, non-zero on error.
@@ -1207,8 +1352,7 @@ static int ata_bus_probe(struct ata_port
 		ata_dev_identify(ap, i);
 		if (ata_dev_present(&ap->device[i])) {
 			found = 1;
-			if (ap->ops->dev_config)
-				ap->ops->dev_config(ap, &ap->device[i]);
+			ata_dev_config(ap,i);
 		}
 	}
 
@@ -1228,10 +1372,14 @@ err_out:
 }
 
 /**
- *	ata_port_probe -
- *	@ap:
+ *	ata_port_probe - Mark port as enabled
+ *	@ap: Port for which we indicate enablement
  *
- *	LOCKING:
+ *	Modify @ap data structure such that the system
+ *	thinks that the entire port is enabled.
+ *
+ *	LOCKING: host_set lock, or some other form of
+ *	serialization.
  */
 
 void ata_port_probe(struct ata_port *ap)
@@ -1240,10 +1388,15 @@ void ata_port_probe(struct ata_port *ap)
 }
 
 /**
- *	__sata_phy_reset -
- *	@ap:
+ *	__sata_phy_reset - Wake/reset a low-level SATA PHY
+ *	@ap: SATA port associated with target SATA PHY.
+ *
+ *	This function issues commands to standard SATA Sxxx
+ *	PHY registers, to wake up the phy (and device), and
+ *	clear any reset condition.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 void __sata_phy_reset(struct ata_port *ap)
@@ -1252,11 +1405,13 @@ void __sata_phy_reset(struct ata_port *a
 	unsigned long timeout = jiffies + (HZ * 5);
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
-		scr_write(ap, SCR_CONTROL, 0x301); /* issue phy wake/reset */
-		scr_read(ap, SCR_STATUS);	/* dummy read; flush */
-		udelay(400);			/* FIXME: a guess */
+		/* issue phy wake/reset */
+		scr_write_flush(ap, SCR_CONTROL, 0x301);
+		/* Couldn't find anything in SATA I/II specs, but
+		 * AHCI-1.1 10.4.2 says at least 1 ms. */
+		mdelay(1);
 	}
-	scr_write(ap, SCR_CONTROL, 0x300);	/* issue phy wake/clear reset */
+	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
 
 	/* wait for phy to become ready, if necessary */
 	do {
@@ -1288,10 +1443,14 @@ void __sata_phy_reset(struct ata_port *a
 }
 
 /**
- *	__sata_phy_reset -
- *	@ap:
+ *	sata_phy_reset - Reset SATA bus.
+ *	@ap: SATA port associated with target SATA PHY.
+ *
+ *	This function resets the SATA bus, and then probes
+ *	the bus for devices.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 void sata_phy_reset(struct ata_port *ap)
@@ -1303,10 +1462,16 @@ void sata_phy_reset(struct ata_port *ap)
 }
 
 /**
- *	ata_port_disable -
- *	@ap:
+ *	ata_port_disable - Disable port.
+ *	@ap: Port to be disabled.
  *
- *	LOCKING:
+ *	Modify @ap data structure such that the system
+ *	thinks that the entire port is disabled, and should
+ *	never attempt to probe or communicate with devices
+ *	on this port.
+ *
+ *	LOCKING: host_set lock, or some other form of
+ *	serialization.
  */
 
 void ata_port_disable(struct ata_port *ap)
@@ -1415,7 +1580,10 @@ static void ata_host_set_dma(struct ata_
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
  *
+ *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 static void ata_set_mode(struct ata_port *ap)
@@ -1466,7 +1634,10 @@ err_out:
  *	@tmout_pat: impatience timeout
  *	@tmout: overall timeout
  *
- *	LOCKING:
+ *	Sleep until ATA Status register bit BSY clears,
+ *	or a timeout occurs.
+ *
+ *	LOCKING: None.
  *
  */
 
@@ -1552,10 +1723,14 @@ static void ata_bus_post_reset(struct at
 }
 
 /**
- *	ata_bus_edd -
- *	@ap:
+ *	ata_bus_edd - Issue EXECUTE DEVICE DIAGNOSTIC command.
+ *	@ap: Port to reset and probe
+ *
+ *	Use the EXECUTE DEVICE DIAGNOSTIC command to reset and
+ *	probe the bus.  Not often used these days.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 
@@ -1632,8 +1807,8 @@ static unsigned int ata_bus_softreset(st
  *	the device is ATA or ATAPI.
  *
  *	LOCKING:
- *	Inherited from caller.  Some functions called by this function
- *	obtain the host_set lock.
+ *	PCI/etc. bus probe sem.
+ *	Obtains host_set lock.
  *
  *	SIDE EFFECTS:
  *	Sets ATA_FLAG_PORT_DISABLED if bus reset fails.
@@ -1746,6 +1921,7 @@ static const char * ata_dma_blacklist []
 	"HITACHI CDR-8335",
 	"HITACHI CDR-8435",
 	"Toshiba CD-ROM XM-6202B",
+	"TOSHIBA CD-ROM XM-1702BC",
 	"CD-532E-A",
 	"E-IDE CD-ROM CR-840",
 	"CD-ROM Drive/F5A",
@@ -1753,7 +1929,6 @@ static const char * ata_dma_blacklist []
 	"SAMSUNG CD-ROM SC-148C",
 	"SAMSUNG CD-ROM SC",
 	"SanDisk SDP3B-64",
-	"SAMSUNG CD-ROM SN-124",
 	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
 	"_NEC DV5800A",
 };
@@ -1875,7 +2050,11 @@ static int fgb(u32 bitmap)
  *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
  *	@xfer_shift_out: (output) bit shift that selects this mode
  *
+ *	Based on host and device capabilities, determine the
+ *	maximum transfer mode that is amenable to all.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
  *	Zero on success, negative on error.
@@ -1908,7 +2087,11 @@ static int ata_choose_xfer_mode(struct a
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
  *
+ *	Issue SET FEATURES - XFER MODE command to device @dev
+ *	on port @ap.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  */
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
@@ -1946,10 +2129,13 @@ static void ata_dev_set_xfermode(struct 
 }
 
 /**
- *	ata_sg_clean -
- *	@qc:
+ *	ata_sg_clean - Unmap DMA memory associated with command
+ *	@qc: Command containing DMA memory to be released
+ *
+ *	Unmap all mapped DMA memory associated with this command.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  */
 
 static void ata_sg_clean(struct ata_queued_cmd *qc)
@@ -1980,7 +2166,11 @@ static void ata_sg_clean(struct ata_queu
  *	ata_fill_sg - Fill PCI IDE PRD table
  *	@qc: Metadata associated with taskfile to be transferred
  *
+ *	Fill PCI IDE PRD (scatter-gather) table with segments
+ *	associated with the current disk command.
+ *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  *
  */
 static void ata_fill_sg(struct ata_queued_cmd *qc)
@@ -2027,7 +2217,13 @@ static void ata_fill_sg(struct ata_queue
  *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
  *
+ *	Allow low-level driver to filter ATA PACKET commands, returning
+ *	a status indicating whether or not it is OK to use DMA for the
+ *	supplied PACKET command.
+ *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
  *	RETURNS: 0 when ATAPI DMA can be used
  *               nonzero otherwise
  */
@@ -2045,6 +2241,8 @@ int ata_check_atapi_dma(struct ata_queue
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
  *
+ *	Prepare ATA taskfile for submission.
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
@@ -2056,6 +2254,32 @@ void ata_qc_prep(struct ata_queued_cmd *
 	ata_fill_sg(qc);
 }
 
+/**
+ *	ata_sg_init_one - Associate command with memory buffer
+ *	@qc: Command to be associated
+ *	@buf: Memory buffer
+ *	@buflen: Length of memory buffer, in bytes.
+ *
+ *	Initialize the data-related elements of queued_cmd @qc
+ *	to point to a single memory buffer, @buf of byte length @buflen.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+
+
+/**
+ *	ata_sg_init_one - Prepare a one-entry scatter-gather list.
+ *	@qc:  Queued command
+ *	@buf:  transfer buffer
+ *	@buflen:  length of buf
+ *
+ *	Builds a single-entry scatter-gather list to initiate a
+ *	transfer utilizing the specified buffer.
+ *
+ *	LOCKING:
+ */
 void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 {
 	struct scatterlist *sg;
@@ -2070,9 +2294,35 @@ void ata_sg_init_one(struct ata_queued_c
 	sg = qc->sg;
 	sg->page = virt_to_page(buf);
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
-	sg_dma_len(sg) = buflen;
+	sg->length = buflen;
 }
 
+/**
+ *	ata_sg_init - Associate command with scatter-gather table.
+ *	@qc: Command to be associated
+ *	@sg: Scatter-gather table.
+ *	@n_elem: Number of elements in s/g table.
+ *
+ *	Initialize the data-related elements of queued_cmd @qc
+ *	to point to a scatter-gather table @sg, containing @n_elem
+ *	elements.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+
+/**
+ *	ata_sg_init - Assign a scatter gather list to a queued command
+ *	@qc:  Queued command
+ *	@sg:  Scatter-gather list
+ *	@n_elem:  length of sg list
+ *
+ *	Attaches a scatter-gather list to a queued command.
+ *
+ *	LOCKING:
+ */
+
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem)
 {
@@ -2082,14 +2332,16 @@ void ata_sg_init(struct ata_queued_cmd *
 }
 
 /**
- *	ata_sg_setup_one -
- *	@qc:
+ *	ata_sg_setup_one - DMA-map the memory buffer associated with a command.
+ *	@qc: Command with memory buffer to be mapped.
+ *
+ *	DMA-map the memory buffer associated with queued_cmd @qc.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *
+ *	Zero on success, negative on error.
  */
 
 static int ata_sg_setup_one(struct ata_queued_cmd *qc)
@@ -2100,11 +2352,12 @@ static int ata_sg_setup_one(struct ata_q
 	dma_addr_t dma_address;
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
-				     sg_dma_len(sg), dir);
+				     sg->length, dir);
 	if (dma_mapping_error(dma_address))
 		return -1;
 
 	sg_dma_address(sg) = dma_address;
+	sg_dma_len(sg) = sg->length;
 
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
@@ -2113,13 +2366,16 @@ static int ata_sg_setup_one(struct ata_q
 }
 
 /**
- *	ata_sg_setup -
- *	@qc:
+ *	ata_sg_setup - DMA-map the scatter-gather table associated with a command.
+ *	@qc: Command with scatter-gather table to be mapped.
+ *
+ *	DMA-map the scatter-gather table associated with queued_cmd @qc.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
+ *	Zero on success, negative on error.
  *
  */
 
@@ -2149,6 +2405,7 @@ static int ata_sg_setup(struct ata_queue
  *	@ap:
  *
  *	LOCKING:
+ *	None.  (executing in kernel thread context)
  *
  *	RETURNS:
  *
@@ -2196,6 +2453,7 @@ static unsigned long ata_pio_poll(struct
  *	@ap:
  *
  *	LOCKING:
+ *	None.  (executing in kernel thread context)
  */
 
 static void ata_pio_complete (struct ata_port *ap)
@@ -2238,6 +2496,18 @@ static void ata_pio_complete (struct ata
 	ata_qc_complete(qc, drv_stat);
 }
 
+
+/**
+ *	swap_buf_le16 -
+ *	@buf:  Buffer to swap
+ *	@buf_words:  Number of 16-bit words in buffer.
+ *
+ *	Swap halves of 16-bit words if needed to convert from
+ *	little-endian byte order to native cpu byte order, or
+ *	vice-versa.
+ *
+ *	LOCKING:
+ */
 void swap_buf_le16(u16 *buf, unsigned int buf_words)
 {
 #ifdef __BIG_ENDIAN
@@ -2309,7 +2579,7 @@ static void ata_pio_sector(struct ata_qu
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2338,7 +2608,6 @@ static void __atapi_pio_bytes(struct ata
 next_sg:
 	sg = &qc->sg[qc->cursg];
 
-next_page:
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -2346,7 +2615,8 @@ next_page:
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	/* don't overrun current sg */
+	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
@@ -2357,7 +2627,7 @@ next_page:
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg_dma_len(sg)) {
+	if (qc->cursg_ofs == sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2370,8 +2640,6 @@ next_page:
 	kunmap(page);
 
 	if (bytes) {
-		if (qc->cursg_ofs < sg_dma_len(sg))
-			goto next_page;
 		goto next_sg;
 	}
 }
@@ -2413,6 +2681,7 @@ err_out:
  *	@ap:
  *
  *	LOCKING:
+ *	None.  (executing in kernel thread context)
  */
 
 static void ata_pio_block(struct ata_port *ap)
@@ -2539,7 +2808,7 @@ static void atapi_request_sense(struct a
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
-	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
+	memset(&qc->cdb, 0, ap->cdb_len);
 	qc->cdb[0] = REQUEST_SENSE;
 	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
 
@@ -2582,6 +2851,7 @@ static void atapi_request_sense(struct a
  *	transaction completed successfully.
  *
  *	LOCKING:
+ *	Inherited from SCSI layer (none, can sleep)
  */
 
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
@@ -2691,6 +2961,7 @@ out:
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
+ *	None.
  */
 
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
@@ -2716,6 +2987,7 @@ static struct ata_queued_cmd *ata_qc_new
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
+ *	None.
  */
 
 struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
@@ -2780,6 +3052,7 @@ static void __ata_qc_complete(struct ata
  *	in case something prevents using it.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  *
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
@@ -2793,9 +3066,13 @@ void ata_qc_free(struct ata_queued_cmd *
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
- *	@drv_stat: ATA status register contents
+ *	@drv_stat: ATA Status register contents
+ *
+ *	Indicate to the mid and upper layers that an ATA
+ *	command has completed, with either an ok or not-ok status.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  *
  */
 
@@ -2811,6 +3088,7 @@ void ata_qc_complete(struct ata_queued_c
 
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -2839,7 +3117,7 @@ static inline int ata_should_dma_map(str
 			return 1;
 
 		/* fall through */
-	
+
 	default:
 		return 0;
 	}
@@ -2890,6 +3168,7 @@ err_out:
 	return -1;
 }
 
+
 /**
  *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
  *	@qc: command to issue to device
@@ -2899,6 +3178,8 @@ err_out:
  *	classes called "protocols", and issuing each type of protocol
  *	is slightly different.
  *
+ *	May be used as the qc_issue() entry in ata_port_operations.
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
@@ -2956,7 +3237,7 @@ int ata_qc_issue_prot(struct ata_queued_
 }
 
 /**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
@@ -3063,6 +3344,18 @@ static void ata_bmdma_start_pio (struct 
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
+
+/**
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes the ATA_DMA_START flag to the DMA command register.
+ *
+ *	May be used as the bmdma_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
 void ata_bmdma_start(struct ata_queued_cmd *qc)
 {
 	if (qc->ap->flags & ATA_FLAG_MMIO)
@@ -3071,6 +3364,20 @@ void ata_bmdma_start(struct ata_queued_c
 		ata_bmdma_start_pio(qc);
 }
 
+
+/**
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes address of PRD table to device's PRD Table Address
+ *	register, sets the DMA control register, and calls
+ *	ops->exec_command() to start the transfer.
+ *
+ *	May be used as the bmdma_setup() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
 void ata_bmdma_setup(struct ata_queued_cmd *qc)
 {
 	if (qc->ap->flags & ATA_FLAG_MMIO)
@@ -3079,6 +3386,19 @@ void ata_bmdma_setup(struct ata_queued_c
 		ata_bmdma_setup_pio(qc);
 }
 
+
+/**
+ *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clear interrupt and error flags in DMA status register.
+ *
+ *	May be used as the irq_clear() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
     if (ap->flags & ATA_FLAG_MMIO) {
@@ -3091,6 +3411,19 @@ void ata_bmdma_irq_clear(struct ata_port
 
 }
 
+
+/**
+ *	ata_bmdma_status - Read PCI IDE BMDMA status
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Read and return BMDMA status register.
+ *
+ *	May be used as the bmdma_status() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
 u8 ata_bmdma_status(struct ata_port *ap)
 {
 	u8 host_stat;
@@ -3102,6 +3435,19 @@ u8 ata_bmdma_status(struct ata_port *ap)
 	return host_stat;
 }
 
+
+/**
+ *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clears the ATA_DMA_START flag in the dma control register
+ *
+ *	May be used as the bmdma_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
 void ata_bmdma_stop(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -3201,13 +3547,18 @@ idle_irq:
 
 /**
  *	ata_interrupt - Default ATA host interrupt handler
- *	@irq: irq line
- *	@dev_instance: pointer to our host information structure
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_host_set information structure
  *	@regs: unused
  *
+ *	Default interrupt handler for PCI IDE devices.  Calls
+ *	ata_host_intr() for each port that is not disabled.
+ *
  *	LOCKING:
+ *	Obtains host_set lock during operation.
  *
  *	RETURNS:
+ *	IRQ_NONE or IRQ_HANDLED.
  *
  */
 
@@ -3229,7 +3580,8 @@ irqreturn_t ata_interrupt (int irq, void
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
 	}
@@ -3299,6 +3651,19 @@ err_out:
 	ata_qc_complete(qc, ATA_ERR);
 }
 
+
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -3312,6 +3677,18 @@ int ata_port_start (struct ata_port *ap)
 	return 0;
 }
 
+
+/**
+ *	ata_port_stop - Undo ata_port_start()
+ *	@ap: Port to shut down
+ *
+ *	Frees the PRD table.
+ *
+ *	May be used as the port_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ */
+
 void ata_port_stop (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -3319,6 +3696,13 @@ void ata_port_stop (struct ata_port *ap)
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
+void ata_host_stop (struct ata_host_set *host_set)
+{
+	if (host_set->mmio_base)
+		iounmap(host_set->mmio_base);
+}
+
+
 /**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
  *	@ap: Port to unregister
@@ -3347,7 +3731,11 @@ static void ata_host_remove(struct ata_p
  *	@ent: Probe information provided by low-level driver
  *	@port_no: Port number associated with this ata_port
  *
+ *	Initialize a new ata_port structure, and its associated
+ *	scsi_host.
+ *
  *	LOCKING:
+ *	Inherited from caller.
  *
  */
 
@@ -3401,9 +3789,13 @@ static void ata_host_init(struct ata_por
  *	@host_set: Collections of ports to which we add
  *	@port_no: Port number associated with this host
  *
+ *	Attach low-level ATA driver to system.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
+ *	New ata_port on success, for NULL on error.
  *
  */
 
@@ -3436,12 +3828,22 @@ err_out:
 }
 
 /**
- *	ata_device_add -
- *	@ent:
+ *	ata_device_add - Register hardware device with ATA and SCSI layers
+ *	@ent: Probe information describing hardware device to be registered
+ *
+ *	This function processes the information provided in the probe
+ *	information struct @ent, allocates the necessary ATA and SCSI
+ *	host information structures, initializes them, and registers
+ *	everything with requisite kernel subsystems.
+ *
+ *	This function requests irqs, probes the ATA bus, and probes
+ *	the SCSI bus.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
+ *	Number of ports registered.  Zero on error (no ports registered).
  *
  */
 
@@ -3612,7 +4014,15 @@ int ata_scsi_release(struct Scsi_Host *h
 /**
  *	ata_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
+ *
+ *	Utility function which initializes data_addr, error_addr,
+ *	feature_addr, nsect_addr, lbal_addr, lbam_addr, lbah_addr,
+ *	device_addr, status_addr, and command_addr to standard offsets
+ *	relative to cmd_addr.
+ *
+ *	Does not set ctl_addr, altstatus_addr, bmdma_addr, or scr_addr.
  */
+
 void ata_std_ports(struct ata_ioports *ioaddr)
 {
 	ioaddr->data_addr = ioaddr->cmd_addr + ATA_REG_DATA;
@@ -3654,6 +4064,20 @@ ata_probe_ent_alloc(struct device *dev, 
 	return probe_ent;
 }
 
+
+
+/**
+ *	ata_pci_init_native_mode - Initialize native-mode driver
+ *	@pdev:  pci device to be initialized
+ *	@port:  array[2] of pointers to port info structures.
+ *
+ *	Utility function which allocates and initializes an
+ *	ata_probe_ent structure for a standard dual-port
+ *	PIO-based IDE controller.  The returned ata_probe_ent
+ *	structure can be passed to ata_device_add().  The returned
+ *	ata_probe_ent structure should then be freed with kfree().
+ */
+
 #ifdef CONFIG_PCI
 struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
@@ -3735,10 +4159,19 @@ ata_pci_init_legacy_mode(struct pci_dev 
  *	@port_info: Information from low-level host driver
  *	@n_ports: Number of ports attached to host controller
  *
+ *	This is a helper function which can be called from a driver's
+ *	xxx_init_one() probe function if the hardware uses traditional
+ *	IDE taskfile registers.
+ *
+ *	This function calls pci_enable_device(), reserves its register
+ *	regions, sets the dma mask, enables bus master mode, and calls
+ *	ata_device_add()
+ *
  *	LOCKING:
  *	Inherited from PCI layer (may sleep).
  *
  *	RETURNS:
+ *	Zero on success, negative on errno-based value on error.
  *
  */
 
@@ -3882,10 +4315,6 @@ void ata_pci_remove_one (struct pci_dev 
 	/* FIXME: handle 'rc' failure? */
 
 	free_irq(host_set->irq, host_set);
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
-	if (host_set->mmio_base)
-		iounmap(host_set->mmio_base);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
@@ -3900,6 +4329,9 @@ void ata_pci_remove_one (struct pci_dev 
 		}
 	}
 
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
+
 	kfree(host_set);
 
 	pci_release_regions(pdev);
@@ -3958,15 +4390,6 @@ int pci_test_config_bits(struct pci_dev 
 #endif /* CONFIG_PCI */
 
 
-/**
- *	ata_init -
- *
- *	LOCKING:
- *
- *	RETURNS:
- *
- */
-
 static int __init ata_init(void)
 {
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
@@ -4007,6 +4430,7 @@ EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
+EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
@@ -4029,6 +4453,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 #ifdef CONFIG_PCI
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -906,7 +906,7 @@ unsigned int ata_scsiop_inq_83(struct at
 }
 
 /**
- *	ata_scsiop_noop -
+ *	ata_scsiop_noop - Command handler that simply returns success.
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
@@ -1135,8 +1135,12 @@ unsigned int ata_scsiop_read_cap(struct 
 		n_sectors = ata_id_u32(args->id, 60);
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
-	tmp = n_sectors;	/* note: truncates, if lba48 */
 	if (args->cmd->cmnd[0] == READ_CAPACITY) {
+		if( n_sectors >= 0xffffffffULL )
+			tmp = 0xffffffff ;  /* Return max count on overflow */
+		else
+			tmp = n_sectors ;
+
 		/* sector count, 32-bit */
 		rbuf[0] = tmp >> (8 * 3);
 		rbuf[1] = tmp >> (8 * 2);
@@ -1150,10 +1154,12 @@ unsigned int ata_scsiop_read_cap(struct 
 
 	} else {
 		/* sector count, 64-bit */
-		rbuf[2] = n_sectors >> (8 * 7);
-		rbuf[3] = n_sectors >> (8 * 6);
-		rbuf[4] = n_sectors >> (8 * 5);
-		rbuf[5] = n_sectors >> (8 * 4);
+		tmp = n_sectors >> (8 * 4);
+		rbuf[2] = tmp >> (8 * 3);
+		rbuf[3] = tmp >> (8 * 2);
+		rbuf[4] = tmp >> (8 * 1);
+		rbuf[5] = tmp;
+		tmp = n_sectors;
 		rbuf[6] = tmp >> (8 * 3);
 		rbuf[7] = tmp >> (8 * 2);
 		rbuf[8] = tmp >> (8 * 1);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -26,7 +26,7 @@
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"1.10"	/* must be exactly four chars */
+#define DRV_VERSION	"1.11"	/* must be exactly four chars */
 
 struct ata_scsi_args {
 	u16			*id;
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -329,6 +329,8 @@ static void nv_host_stop (struct ata_hos
 		host->host_desc->disable_hotplug(host_set);
 
 	kfree(host);
+
+	ata_host_stop(host_set);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -42,6 +42,7 @@
 #define DRV_NAME	"sata_promise"
 #define DRV_VERSION	"1.01"
 
+
 enum {
 	PDC_PKT_SUBMIT		= 0x40, /* Command packet pointer addr */
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
@@ -58,6 +59,7 @@ enum {
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
+	board_20619		= 2,	/* FastTrak TX4000 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
@@ -121,6 +123,7 @@ static struct ata_port_operations pdc_at
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info pdc_port_info[] = {
@@ -145,11 +148,24 @@ static struct ata_port_info pdc_port_inf
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_ata_ops,
 	},
+
+	/* board_20619 */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+				  ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_ata_ops,
+	},
 };
 
 static struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -168,6 +184,9 @@ static struct pci_device_id pdc_ata_pci_
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 
+	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20619 },
+
 	{ }	/* terminate list */
 };
 
@@ -629,6 +648,15 @@ static int pdc_ata_init_one (struct pci_
 	case board_2037x:
        		probe_ent->n_ports = 2;
 		break;
+	case board_20619:
+		probe_ent->n_ports = 4;
+
+		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+
+		probe_ent->port[2].scr_addr = base + 0x600;
+		probe_ent->port[3].scr_addr = base + 0x700;
+		break;
 	default:
 		BUG();
 		break;
@@ -684,7 +712,7 @@ static void __exit pdc_ata_exit(void)
 
 
 MODULE_AUTHOR("Jeff Garzik");
-MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
+MODULE_DESCRIPTION("Promise ATA TX2/TX4/TX4000 low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -537,6 +537,8 @@ static void qs_host_stop(struct ata_host
 
 	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
+
+	ata_host_stop(host_set);
 }
 
 static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -82,6 +82,7 @@ static struct pci_device_id sil_pci_tbl[
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 
@@ -160,6 +161,7 @@ static struct ata_port_operations sil_op
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sil_port_info[] = {
@@ -427,7 +429,13 @@ static int sil_init_one (struct pci_dev 
 		writeb(cls, mmio_base + SIL_FIFO_R0);
 		writeb(cls, mmio_base + SIL_FIFO_W0);
 		writeb(cls, mmio_base + SIL_FIFO_R1);
-		writeb(cls, mmio_base + SIL_FIFO_W2);
+		writeb(cls, mmio_base + SIL_FIFO_W1);
+		if (ent->driver_data == sil_3114) {
+			writeb(cls, mmio_base + SIL_FIFO_R2);
+			writeb(cls, mmio_base + SIL_FIFO_W2);
+			writeb(cls, mmio_base + SIL_FIFO_R3);
+			writeb(cls, mmio_base + SIL_FIFO_W3);
+		}
 	} else
 		printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
 			pci_name(pdev));
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -114,6 +114,7 @@ static struct ata_port_operations sis_op
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sis_port_info = {
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -49,7 +49,7 @@
 #endif /* CONFIG_PPC_OF */
 
 #define DRV_NAME	"sata_svw"
-#define DRV_VERSION	"1.05"
+#define DRV_VERSION	"1.06"
 
 /* Taskfile registers offsets */
 #define K2_SATA_TF_CMD_OFFSET		0x00
@@ -313,6 +313,7 @@ static struct ata_port_operations k2_sat
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -343,6 +344,7 @@ static int k2_sata_init_one (struct pci_
 	void *mmio_base;
 	int pci_dev_busy = 0;
 	int rc;
+	int i;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -417,11 +419,11 @@ static int k2_sata_init_one (struct pci_
 	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 
-	/* We have 4 ports per PCI function */
-	k2_sata_setup_port(&probe_ent->port[0], base + 0 * K2_SATA_PORT_OFFSET);
-	k2_sata_setup_port(&probe_ent->port[1], base + 1 * K2_SATA_PORT_OFFSET);
-	k2_sata_setup_port(&probe_ent->port[2], base + 2 * K2_SATA_PORT_OFFSET);
-	k2_sata_setup_port(&probe_ent->port[3], base + 3 * K2_SATA_PORT_OFFSET);
+	/* different controllers have different number of ports - currently 4 or 8 */
+	/* All ports are on the same function. Multi-function device is no
+	 * longer available. This should not be seen in any system. */
+	for (i = 0; i < ent->driver_data; i++)
+		k2_sata_setup_port(&probe_ent->port[i], base + i * K2_SATA_PORT_OFFSET);
 
 	pci_set_master(pdev);
 
@@ -439,11 +441,17 @@ err_out:
 	return rc;
 }
 
-
+/* 0x240 is device ID for Apple K2 device
+ * 0x241 is device ID for Serverworks Frodo4
+ * 0x242 is device ID for Serverworks Frodo8
+ * 0x24a is device ID for BCM5785 (aka HT1000) HT southbridge integrated SATA
+ * controller
+ * */
 static struct pci_device_id k2_sata_pci_tbl[] = {
-	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
+	{ 0x1166, 0x024a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ }
 };
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -245,6 +245,8 @@ static void pdc20621_host_stop(struct at
 
 	iounmap(dimm_mmio);
 	kfree(hpriv);
+
+	ata_host_stop(host_set);
 }
 
 static int pdc_port_start(struct ata_port *ap)
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -113,6 +113,7 @@ static struct ata_port_operations uli_op
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info uli_port_info = {
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -134,6 +134,7 @@ static struct ata_port_operations svia_s
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info svia_port_info = {
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -230,6 +230,7 @@ static struct ata_port_operations vsc_sa
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
diff --git a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -224,6 +224,7 @@ struct ata_taskfile {
 };
 
 #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
 #define ata_id_has_flush(id) ((id)[83] & (1 << 12))
diff --git a/include/linux/libata-compat.h b/include/linux/libata-compat.h
--- a/include/linux/libata-compat.h
+++ b/include/linux/libata-compat.h
@@ -23,6 +23,9 @@ static inline struct pci_dev *to_pci_dev
 	return (struct pci_dev *) dev;
 }
 
+static inline int pci_enable_msi(struct pci_dev *dev) { return -1; }
+static inline void pci_disable_msi(struct pci_dev *dev) {}
+
 #define pci_set_consistent_dma_mask(pdev,mask) (0)
 
 #define DMA_FROM_DEVICE PCI_DMA_FROMDEVICE
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -411,6 +411,7 @@ extern u8 ata_chk_err(struct ata_port *a
 extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
+extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
@@ -421,6 +422,7 @@ extern void ata_sg_init(struct ata_queue
 extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
 extern void ata_dev_id_string(u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_port *ap);
@@ -465,12 +467,34 @@ static inline u8 ata_chk_status(struct a
 	return ap->ops->check_status(ap);
 }
 
+
+/**
+ *	ata_pause - Flush writes and pause 400 nanoseconds.
+ *	@ap: Port to wait for.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline void ata_pause(struct ata_port *ap)
 {
 	ata_altstatus(ap);
 	ndelay(400);
 }
 
+
+/**
+ *	ata_busy_wait - Wait for a port status register
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to max*10 microseconds for the selected bits in the port's
+ *	status register to be cleared.
+ *	Returns final value of status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
 			       unsigned int max)
 {
@@ -485,6 +509,18 @@ static inline u8 ata_busy_wait(struct at
 	return status;
 }
 
+
+/**
+ *	ata_wait_idle - Wait for a port to be idle.
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to 10ms for port's BUSY and DRQ signals to clear.
+ *	Returns final value of status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
@@ -523,6 +559,18 @@ static inline void ata_tf_init(struct at
 		tf->device = ATA_DEVICE_OBS | ATA_DEV1;
 }
 
+
+/**
+ *	ata_irq_on - Enable interrupts on a port.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Enable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline u8 ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
@@ -542,6 +590,18 @@ static inline u8 ata_irq_on(struct ata_p
 	return tmp;
 }
 
+
+/**
+ *	ata_irq_ack - Acknowledge a device interrupt.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Wait up to 10 ms for legacy IDE device to become idle (BUSY
+ *	or BUSY+DRQ clear).  Obtain dma status and port status from
+ *	device.  Clear the interrupt.  Return port status.
+ *
+ *	LOCKING:
+ */
+
 static inline u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)
 {
 	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
@@ -583,6 +643,13 @@ static inline void scr_write(struct ata_
 	ap->ops->scr_write(ap, reg, val);
 }
 
+static inline void scr_write_flush(struct ata_port *ap, unsigned int reg, 
+				   u32 val)
+{
+	ap->ops->scr_write(ap, reg, val);
+	(void) ap->ops->scr_read(ap, reg);
+}
+
 static inline unsigned int sata_dev_present(struct ata_port *ap)
 {
 	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;

--------------000307020306060206010809--
