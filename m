Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFDGJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFDGJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFDGJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:09:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35265 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261254AbVFDGII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:08:08 -0400
Message-ID: <42A14541.6020209@pobox.com>
Date: Sat, 04 Jun 2005 02:08:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: [SATA] libata-dev queue updated
Content-Type: multipart/mixed;
 boundary="------------030402040301030800070702"
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Several updates to the libata-dev.git repository. Some
	of the branches have been folded into a new upstream-2.6.13 branch,
	which holds several changes (see attached). Other branches were updated
	to the most recent kernel, which contained doc updates that caused some
	minor merge conflicts. [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402040301030800070702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Several updates to the libata-dev.git repository.  Some of the branches 
have been folded into a new upstream-2.6.13 branch, which holds several 
changes (see attached).  Other branches were updated to the most recent 
kernel, which contained doc updates that caused some minor merge conflicts.

I haven't yet updated 'passthru' and 'chs-support' branches to the 
latest kernel.

Git Repository URL:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

List of branches:
adma          chs-support  master    pdc2027x           sleeping-eh
adma-mwi      iomap        ncq       promise-sata-pata  upstream-2.6.13
atapi-enable  iomap-step1  passthru  sil24

The "sleeping-eh" branch will be going upstream via James B and the SCSI 
crew (sounds like a hiphop group, doesn't it?)

	Jeff




--------------030402040301030800070702
Content-Type: text/x-patch;
 name="libata-2.6.13.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.13.patch"


Brad Campbell <brad@wasp.net.au>:
  libata basic detection and errata for PATA->SATA bridges

Jeff Garzik <jgarzik@pobox.com>:
  [libata] ahci: finish ATAPI support (hopefully)
  [libata] ahci: minor PCI MSI cleanup
  [libata] ahci: Update for recent ->host_stop() API change
  [libata ahci] support PCI MSI interrupt vector

Narendra Sankar <nsankar@broadcom.com>:
  sata_svw: Add support for new device IDs

Tobias Lorenz <tobias.lorenz@gmx.net>:
  [libata sata_promise] pdc20619 (PATA) support



 drivers/scsi/ahci.c         |  100 +++++++++++++++++++++++++++++++++-----------
 drivers/scsi/libata-core.c  |   35 ++++++++++++++-
 drivers/scsi/sata_promise.c |   26 +++++++++++
 drivers/scsi/sata_svw.c     |   25 +++++++----
 include/linux/ata.h         |    1 
 include/linux/libata.h      |    1 
 6 files changed, 151 insertions(+), 37 deletions(-)



diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"1.00"
+#define DRV_VERSION	"1.01"
 
 
 enum {
@@ -50,6 +50,7 @@ enum {
 	AHCI_CMD_SLOT_SZ	= 32 * 32,
 	AHCI_RX_FIS_SZ		= 256,
 	AHCI_CMD_TBL_HDR	= 0x80,
+	AHCI_CMD_TBL_CDB	= 0x40,
 	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
 				  AHCI_RX_FIS_SZ,
@@ -134,6 +135,9 @@ enum {
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+
+	/* hpriv->flags bits */
+	AHCI_FLAG_MSI		= (1 << 0),
 };
 
 struct ahci_cmd_hdr {
@@ -183,6 +187,7 @@ static void ahci_qc_prep(struct ata_queu
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static void ahci_remove_one (struct pci_dev *pdev);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -272,7 +277,7 @@ static struct pci_driver ahci_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= ahci_remove_one,
 };
 
 
@@ -506,7 +511,8 @@ static void ahci_fill_sg(struct ata_queu
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 
@@ -518,18 +524,8 @@ static void ahci_qc_prep(struct ata_queu
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
@@ -541,6 +537,10 @@ static void ahci_qc_prep(struct ata_queu
 	 * a SATA Register - Host to Device command FIS.
 	 */
 	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+	if (opts & AHCI_CMD_ATAPI) {
+		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
+		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, ap->cdb_len);
+	}
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
@@ -795,8 +795,6 @@ static int ahci_host_init(struct ata_pro
 				return rc;
 			}
 		}
-
-		hpriv->flags |= HOST_CAP_64;
 	} else {
 		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
@@ -879,15 +877,19 @@ static int ahci_host_init(struct ata_pro
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
@@ -969,7 +971,7 @@ static int ahci_init_one (struct pci_dev
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
+	int have_msi, pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -987,12 +989,17 @@ static int ahci_init_one (struct pci_dev
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
@@ -1025,6 +1032,9 @@ static int ahci_init_one (struct pci_dev
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
+	if (have_msi)
+		hpriv->flags |= AHCI_FLAG_MSI;
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
@@ -1044,7 +1054,11 @@ err_out_iounmap:
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
@@ -1052,6 +1066,42 @@ err_out:
 	return rc;
 }
 
+static void ahci_remove_one (struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	struct ata_port *ap;
+	unsigned int i;
+	int have_msi;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		scsi_remove_host(ap->host);
+	}
+
+	have_msi = hpriv->flags & AHCI_FLAG_MSI;
+	free_irq(host_set->irq, host_set);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		ata_scsi_release(ap->host);
+		scsi_host_put(ap->host);
+	}
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
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1295,6 +1295,37 @@ err_out:
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
@@ -1322,8 +1353,7 @@ static int ata_bus_probe(struct ata_port
 		ata_dev_identify(ap, i);
 		if (ata_dev_present(&ap->device[i])) {
 			found = 1;
-			if (ap->ops->dev_config)
-				ap->ops->dev_config(ap, &ap->device[i]);
+			ata_dev_config(ap,i);
 		}
 	}
 
@@ -4408,6 +4438,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 #ifdef CONFIG_PCI
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -59,6 +59,7 @@ enum {
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
+	board_20619		= 2,	/* FastTrak TX4000 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
@@ -147,6 +148,17 @@ static struct ata_port_info pdc_port_inf
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
@@ -172,6 +184,9 @@ static struct pci_device_id pdc_ata_pci_
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 
+	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20619 },
+
 	{ }	/* terminate list */
 };
 
@@ -636,6 +651,15 @@ static int pdc_ata_init_one (struct pci_
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
+                break;
 	default:
 		BUG();
 		break;
@@ -676,7 +700,7 @@ static void __exit pdc_ata_exit(void)
 
 
 MODULE_AUTHOR("Jeff Garzik");
-MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
+MODULE_DESCRIPTION("Promise ATA TX2/TX4/TX4000 low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -344,6 +344,7 @@ static int k2_sata_init_one (struct pci_
 	void *mmio_base;
 	int pci_dev_busy = 0;
 	int rc;
+	int i;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -421,11 +422,11 @@ static int k2_sata_init_one (struct pci_
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
 
@@ -445,11 +446,17 @@ err_out:
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -421,6 +421,7 @@ extern void ata_sg_init(struct ata_queue
 extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
 extern void ata_dev_id_string(u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_port *ap);

--------------030402040301030800070702--
