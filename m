Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUHRNjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUHRNjC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUHRNjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 09:39:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266175AbUHRNdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 09:33:03 -0400
Message-ID: <41235A7B.30105@pobox.com>
Date: Wed, 18 Aug 2004 09:32:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sata] libata queue updated
Content-Type: multipart/mixed;
 boundary="------------060300040007010701090509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300040007010701090509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


BK users:
         bk pull bk://gkernel.bkbits.net/libata-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.8.1-libata2.patch.bz2



--------------060300040007010701090509
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"


This will update the following files:

 drivers/scsi/ata_piix.c     |  148 ++++++--
 drivers/scsi/libata-core.c  |  759 +++++++++++++++++++++++++++-----------------
 drivers/scsi/libata-scsi.c  |  426 +++++++++++++++++++++---
 drivers/scsi/libata.h       |    3 
 drivers/scsi/sata_nv.c      |    3 
 drivers/scsi/sata_promise.c |   78 +---
 drivers/scsi/sata_sil.c     |   10 
 drivers/scsi/sata_sis.c     |    6 
 drivers/scsi/sata_svw.c     |    3 
 drivers/scsi/sata_sx4.c     |  166 +++++----
 drivers/scsi/sata_via.c     |    2 
 drivers/scsi/sata_vsc.c     |    2 
 include/linux/ata.h         |   31 +
 include/linux/libata.h      |   43 +-
 include/scsi/scsi.h         |    1 
 15 files changed, 1169 insertions(+), 512 deletions(-)

through these ChangeSets:

Alan Cox:
  o [libata] improve translation of ATA errors to SCSI sense codes

Andrew Morton:
  o libata build fix

Douglas Gilbert:
  o [libata] fix INQUIRY handling

Jeff Garzik:
  o [ata] remove 'packed' attributed from struct ata_prd
  o [libata] fix error recovery reference count
  o [libata] add ioctl infrastructure
  o [libata] ATAPI PIO data xfer
  o [libata] fix PIO data xfer on big endian
  o [libata] support commands SYNCHRONIZE CACHE, VERIFY, VERIFY(16)
  o [libata] (cosmetic) minimize diff with 2.4.x libata
  o [libata] ATAPI work - cdb len, new taskfile protocol, cleanups
  o [libata] flags cleanup
  o [libata ata_piix] make sure AHCI is disabled, if h/w is used by this driver
  o [PCI, libata] Fix "combined mode" PCI quirk for ICH6
  o [libata] ATAPI work - PIO xfer, completion function
  o [libata] update IDENTIFY DEVICE path to use ata_queued_cmd
  o [libata] pio/dma flag bug fix, and cleanup
  o [libata sata_sx4] deliver non-data taskfiles using Promise packet format
  o [libata sata_promise] convert to using packets for non-data taskfiles
  o [libata] transfer mode bug fixes and type cleanup
  o [libata] convert set-xfer-mode operation to use ata_queued_cmd
  o [libata] fix completion bug, better debug output
  o [libata] transfer mode cleanup

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-08-18 03:11:44 -04:00
@@ -39,6 +39,7 @@
 	ICH5_PMR		= 0x90, /* port mapping register */
 	ICH5_PCS		= 0x92,	/* port control and status */
 
+	PIIX_FLAG_AHCI		= (1 << 28), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
 	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
 
@@ -58,6 +59,7 @@
 	ich5_sata		= 1,
 	piix4_pata		= 2,
 	ich6_sata		= 3,
+	ich6_sata_rm		= 4,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -65,10 +67,8 @@
 
 static void piix_pata_phy_reset(struct ata_port *ap);
 static void piix_sata_phy_reset(struct ata_port *ap);
-static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int pio);
-static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
-			       unsigned int udma);
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
+static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
 static unsigned int in_module_init = 1;
 
@@ -87,13 +87,9 @@
 	{ 0x8086, 0x24df, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-
-	/* ICH6 operates in two modes, "looks-like-ICH5" mode,
-	 * and enhanced mode, with queueing and other fancy stuff.
-	 * This is distinguished by PCI class code.
-	 */
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
+	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
+	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 
 	{ }	/* terminate list */
 };
@@ -108,6 +104,7 @@
 static Scsi_Host_Template piix_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -126,7 +123,7 @@
 static struct ata_port_operations piix_pata_ops = {
 	.port_disable		= ata_port_disable,
 	.set_piomode		= piix_set_piomode,
-	.set_udmamode		= piix_set_udmamode,
+	.set_dmamode		= piix_set_dmamode,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
@@ -151,8 +148,6 @@
 
 static struct ata_port_operations piix_sata_ops = {
 	.port_disable		= ata_port_disable,
-	.set_piomode		= piix_set_piomode,
-	.set_udmamode		= piix_set_udmamode,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
@@ -181,7 +176,12 @@
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
 				  PIIX_FLAG_CHECKINTR,
-		.pio_mask	= 0x03,	/* pio3-4 */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+#if 0
+		.mwdma_mask	= 0x06, /* mwdma1-2 */
+#else
+		.mwdma_mask	= 0x00, /* mwdma broken */
+#endif
 		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
 		.port_ops	= &piix_pata_ops,
 	},
@@ -191,8 +191,9 @@
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
 
@@ -200,7 +201,12 @@
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+#if 0
+		.mwdma_mask	= 0x06, /* mwdma1-2 */
+#else
+		.mwdma_mask	= 0x00, /* mwdma broken */
+#endif
 		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
 		.port_ops	= &piix_pata_ops,
 	},
@@ -211,8 +217,21 @@
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
 				  ATA_FLAG_SLAVE_POSS,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
+
+	/* ich6_sata_rm */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
 };
@@ -368,11 +387,11 @@
  *	None (inherited from caller).
  */
 
-static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int pio)
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
+	unsigned int pio	= adev->pio_mode;
 	struct pci_dev *dev	= ap->host_set->pdev;
-	unsigned int is_slave	= (adev->flags & ATA_DFLAG_MASTER) ? 0 : 1;
+	unsigned int is_slave	= (adev->devno != 0);
 	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
@@ -409,7 +428,7 @@
 }
 
 /**
- *	piix_set_udmamode - Initialize host controller PATA PIO timings
+ *	piix_set_dmamode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: um
  *	@udma: udma mode, 0 - 6
@@ -420,9 +439,9 @@
  *	None (inherited from caller).
  */
 
-static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int udma)
+static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
+	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= ap->host_set->pdev;
 	u8 maslave		= ap->port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
@@ -452,25 +471,38 @@
 		case XFER_UDMA_3:
 		case XFER_UDMA_1:	u_speed = 1 << (drive_dn * 4); break;
 		case XFER_UDMA_0:	u_speed = 0 << (drive_dn * 4); break;
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:	break;
 		default:
 			BUG();
 			return;
 	}
 
-	if (!(reg48 & u_flag))
-		pci_write_config_byte(dev, 0x48, reg48 | u_flag);
-	if (speed == XFER_UDMA_5) {
-		pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
+	if (speed >= XFER_UDMA_0) {
+		if (!(reg48 & u_flag))
+			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
+		if (speed == XFER_UDMA_5) {
+			pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
+		} else {
+			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+		}
+		if ((reg4a & a_speed) != u_speed)
+			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
+		if (speed > XFER_UDMA_2) {
+			if (!(reg54 & v_flag))
+				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
+		} else
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 	} else {
-		pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+		if (reg48 & u_flag)
+			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
+		if (reg4a & a_speed)
+			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
+		if (reg54 & v_flag)
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
+		if (reg55 & w_flag)
+			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
-	if ((reg4a & a_speed) != u_speed)
-		pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
-	if (speed > XFER_UDMA_2) {
-		if (!(reg54 & v_flag))
-			pci_write_config_byte(dev, 0x54, reg54 | v_flag);
-	} else
-		pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */
@@ -485,6 +517,42 @@
 	}
 }
 
+#define AHCI_PCI_BAR 5
+#define AHCI_GLOBAL_CTL 0x04
+#define AHCI_ENABLE (1 << 31)
+static int piix_disable_ahci(struct pci_dev *pdev)
+{
+	void *mmio;
+	unsigned long addr;
+	u32 tmp;
+	int rc = 0;
+
+	/* BUG: pci_enable_device has not yet been called.  This
+	 * works because this device is usually set up by BIOS.
+	 */
+
+	addr = pci_resource_start(pdev, AHCI_PCI_BAR);
+	if (!addr || !pci_resource_len(pdev, AHCI_PCI_BAR))
+		return 0;
+	
+	mmio = ioremap(addr, 64);
+	if (!mmio)
+		return -ENOMEM;
+	
+	tmp = readl(mmio + AHCI_GLOBAL_CTL);
+	if (tmp & AHCI_ENABLE) {
+		tmp &= ~AHCI_ENABLE;
+		writel(tmp, mmio + AHCI_GLOBAL_CTL);
+
+		tmp = readl(mmio + AHCI_GLOBAL_CTL);
+		if (tmp & AHCI_ENABLE)
+			rc = -EIO;
+	}
+	
+	iounmap(mmio);
+	return rc;
+}
+
 /**
  *	piix_init_one - Register PIIX ATA PCI device with kernel services
  *	@pdev: PCI device to register
@@ -516,6 +584,12 @@
 
 	port_info[0] = &piix_port_info[ent->driver_data];
 	port_info[1] = NULL;
+
+	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
+		int rc = piix_disable_ahci(pdev);
+		if (rc)
+			return rc;
+	}
 
 	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
 		u8 tmp;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/libata-core.c	2004-08-18 03:11:44 -04:00
@@ -43,6 +43,7 @@
 #include <linux/libata.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
+#include <asm/byteorder.h>
 
 #include "libata.h"
 
@@ -50,11 +51,14 @@
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
 static void __ata_dev_select (struct ata_port *ap, unsigned int device);
-static void ata_host_set_pio(struct ata_port *ap);
-static void ata_host_set_udma(struct ata_port *ap);
-static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
-static void ata_dev_set_udma(struct ata_port *ap, unsigned int device);
 static void ata_set_mode(struct ata_port *ap);
+static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
+static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
+static int fgb(u32 bitmap);
+static int ata_choose_xfer_mode(struct ata_port *ap,
+				u8 *xfer_mode_out,
+				unsigned int *xfer_shift_out);
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -524,7 +528,7 @@
 	dev->write_cmd = (cmd >> 8) & 0xff;
 }
 
-static const char * udma_str[] = {
+static const char * xfer_mode_str[] = {
 	"UDMA/16",
 	"UDMA/25",
 	"UDMA/33",
@@ -533,6 +537,14 @@
 	"UDMA/100",
 	"UDMA/133",
 	"UDMA7",
+	"MWDMA0",
+	"MWDMA1",
+	"MWDMA2",
+	"PIO0",
+	"PIO1",
+	"PIO2",
+	"PIO3",
+	"PIO4",
 };
 
 /**
@@ -550,16 +562,24 @@
  *	@udma_mask, or the constant C string "<n/a>".
  */
 
-static const char *ata_udma_string(unsigned int udma_mask)
+static const char *ata_mode_string(unsigned int mask)
 {
 	int i;
 
-	for (i = 7; i >= 0; i--) {
-		if (udma_mask & (1 << i))
-			return udma_str[i];
-	}
+	for (i = 7; i >= 0; i--)
+		if (mask & (1 << i))
+			goto out;
+	for (i = ATA_SHIFT_MWDMA + 2; i >= ATA_SHIFT_MWDMA; i--)
+		if (mask & (1 << i))
+			goto out;
+	for (i = ATA_SHIFT_PIO + 4; i >= ATA_SHIFT_PIO; i--)
+		if (mask & (1 << i))
+			goto out;
 
 	return "<n/a>";
+
+out:
+	return xfer_mode_str[i];
 }
 
 /**
@@ -930,10 +950,14 @@
 {
 	struct ata_device *dev = &ap->device[device];
 	unsigned int i;
-	u16 tmp, udma_modes;
+	u16 tmp;
+	unsigned long xfer_modes;
 	u8 status;
-	struct ata_taskfile tf;
 	unsigned int using_edd;
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int rc;
 
 	if (!ata_dev_present(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
@@ -953,27 +977,34 @@
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
-retry:
-	ata_tf_init(ap, &tf, device);
-	tf.ctl |= ATA_NIEN;
-	tf.protocol = ATA_PROT_PIO;
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
+	qc->pci_dma_dir = PCI_DMA_FROMDEVICE;
+	qc->tf.protocol = ATA_PROT_PIO;
+	qc->nsect = 1;
 
+retry:
 	if (dev->class == ATA_DEV_ATA) {
-		tf.command = ATA_CMD_ID_ATA;
+		qc->tf.command = ATA_CMD_ID_ATA;
 		DPRINTK("do ATA identify\n");
 	} else {
-		tf.command = ATA_CMD_ID_ATAPI;
+		qc->tf.command = ATA_CMD_ID_ATAPI;
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	ata_tf_to_host(ap, &tf);
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
 
-	/* crazy ATAPI devices... */
-	if (dev->class == ATA_DEV_ATAPI)
-		msleep(150);
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT))
+	if (rc)
 		goto err_out;
+	else
+		wait_for_completion(&wait);
 
 	status = ata_chk_status(ap);
 	if (status & ATA_ERR) {
@@ -988,44 +1019,21 @@
 		 * ATA software reset (SRST, the default) does not appear
 		 * to have this problem.
 		 */
-		if ((using_edd) && (tf.command == ATA_CMD_ID_ATA)) {
+		if ((using_edd) && (qc->tf.command == ATA_CMD_ID_ATA)) {
 			u8 err = ata_chk_err(ap);
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
+				qc->cursg = 0;
+				qc->cursg_ofs = 0;
+				qc->cursect = 0;
+				qc->nsect = 1;
 				goto retry;
 			}
 		}
 		goto err_out;
 	}
 
-	/* make sure we have BSY=0, DRQ=1 */
-	if ((status & ATA_DRQ) == 0) {
-		printk(KERN_WARNING "ata%u: dev %u (ATA%s?) not returning id page (0x%x)\n",
-		       ap->id, device,
-		       dev->class == ATA_DEV_ATA ? "" : "PI",
-		       status);
-		goto err_out;
-	}
-
-	/* read IDENTIFY [X] DEVICE page */
-	if (ap->flags & ATA_FLAG_MMIO) {
-		for (i = 0; i < ATA_ID_WORDS; i++)
-			dev->id[i] = readw((void *)ap->ioaddr.data_addr);
-	} else
-		for (i = 0; i < ATA_ID_WORDS; i++)
-			dev->id[i] = inw(ap->ioaddr.data_addr);
-
-	/* wait for host_idle */
-	status = ata_wait_idle(ap);
-	if (status & (ATA_BUSY | ATA_DRQ)) {
-		printk(KERN_WARNING "ata%u: dev %u (ATA%s?) error after id page (0x%x)\n",
-		       ap->id, device,
-		       dev->class == ATA_DEV_ATA ? "" : "PI",
-		       status);
-		goto err_out;
-	}
-
-	ata_irq_on(ap);	/* re-enable interrupts */
+	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
@@ -1045,12 +1053,13 @@
 		goto err_out_nosup;
 	}
 
-	/* we require UDMA support */
-	udma_modes =
-	tmp = dev->id[ATA_ID_UDMA_MODES];
-	if ((tmp & 0xff) == 0) {
-		printk(KERN_DEBUG "ata%u: no udma\n", ap->id);
-		goto err_out_nosup;
+	/* quick-n-dirty find max transfer mode; for printk only */
+	xfer_modes = dev->id[ATA_ID_UDMA_MODES];
+	if (!xfer_modes)
+		xfer_modes = (dev->id[ATA_ID_MWDMA_MODES]) << ATA_SHIFT_MWDMA;
+	if (!xfer_modes) {
+		xfer_modes = (dev->id[ATA_ID_PIO_MODES]) << (ATA_SHIFT_PIO + 3);
+		xfer_modes |= (0x7 << ATA_SHIFT_PIO);
 	}
 
 	ata_dump_id(dev);
@@ -1083,7 +1092,7 @@
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes),
+		       ata_mode_string(xfer_modes),
 		       (unsigned long long)dev->n_sectors,
 		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
 	}
@@ -1093,15 +1102,18 @@
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
-		/* see if 16-byte commands supported */
-		tmp = dev->id[0] & 0x3;
-		if (tmp == 1)
-			ap->host->max_cmd_len = 16;
+		rc = atapi_cdb_len(dev->id);
+		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
+			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
+			goto err_out_nosup;
+		}
+		ap->cdb_len = (unsigned int) rc;
+		ap->host->max_cmd_len = (unsigned char) ap->cdb_len;
 
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes));
+		       ata_mode_string(xfer_modes));
 	}
 
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
@@ -1232,6 +1244,101 @@
 	ap->flags |= ATA_FLAG_PORT_DISABLED;
 }
 
+static struct {
+	unsigned int shift;
+	u8 base;
+} xfer_mode_classes[] = {
+	{ ATA_SHIFT_UDMA,	XFER_UDMA_0 },
+	{ ATA_SHIFT_MWDMA,	XFER_MW_DMA_0 },
+	{ ATA_SHIFT_PIO,	XFER_PIO_0 },
+};
+
+static inline u8 base_from_shift(unsigned int shift)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++)
+		if (xfer_mode_classes[i].shift == shift)
+			return xfer_mode_classes[i].base;
+
+	return 0xff;
+}
+
+static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
+{
+	int ofs, idx;
+	u8 base;
+
+	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
+		return;
+
+	if (dev->xfer_shift == ATA_SHIFT_PIO)
+		dev->flags |= ATA_DFLAG_PIO;
+
+	ata_dev_set_xfermode(ap, dev);
+
+	base = base_from_shift(dev->xfer_shift);
+	ofs = dev->xfer_mode - base;
+	idx = ofs + dev->xfer_shift;
+	WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
+
+	DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
+		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
+
+	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
+		ap->id, dev->devno, xfer_mode_str[idx]);
+}
+
+static int ata_host_set_pio(struct ata_port *ap)
+{
+	unsigned int mask;
+	int x, i;
+	u8 base, xfer_mode;
+
+	mask = ata_get_mode_mask(ap, ATA_SHIFT_PIO);
+	x = fgb(mask);
+	if (x < 0) {
+		printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+		return -1;
+	}
+
+	base = base_from_shift(ATA_SHIFT_PIO);
+	xfer_mode = base + x;
+
+	DPRINTK("base 0x%x xfer_mode 0x%x mask 0x%x x %d\n",
+		(int)base, (int)xfer_mode, mask, x);
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_present(dev)) {
+			dev->pio_mode = xfer_mode;
+			dev->xfer_mode = xfer_mode;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			if (ap->ops->set_piomode)
+				ap->ops->set_piomode(ap, dev);
+		}
+	}
+
+	return 0;
+}
+
+static void ata_host_set_dma(struct ata_port *ap, u8 xfer_mode,
+			    unsigned int xfer_shift)
+{
+	int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_present(dev)) {
+			dev->dma_mode = xfer_mode;
+			dev->xfer_mode = xfer_mode;
+			dev->xfer_shift = xfer_shift;
+			if (ap->ops->set_dmamode)
+				ap->ops->set_dmamode(ap, dev);
+		}
+	}
+}
+
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
@@ -1241,29 +1348,28 @@
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int force_pio, i;
-
-	ata_host_set_pio(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	unsigned int i, xfer_shift;
+	u8 xfer_mode;
+	int rc;
 
-	ata_host_set_udma(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	/* step 1: always set host PIO timings */
+	rc = ata_host_set_pio(ap);
+	if (rc)
+		goto err_out;
 
-#ifdef ATA_FORCE_PIO
-	force_pio = 1;
-#else
-	force_pio = 0;
-#endif
+	/* step 2: choose the best data xfer mode */
+	xfer_mode = xfer_shift = 0;
+	rc = ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);
+	if (rc)
+		goto err_out;
 
-	if (force_pio) {
-		ata_dev_set_pio(ap, 0);
-		ata_dev_set_pio(ap, 1);
-	} else {
-		ata_dev_set_udma(ap, 0);
-		ata_dev_set_udma(ap, 1);
-	}
+	/* step 3: if that xfer mode isn't PIO, set host DMA timings */
+	if (xfer_shift != ATA_SHIFT_PIO)
+		ata_host_set_dma(ap, xfer_mode, xfer_shift);
+
+	/* step 4: update devices' xfer mode */
+	ata_dev_set_mode(ap, &ap->device[0]);
+	ata_dev_set_mode(ap, &ap->device[1]);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -1275,6 +1381,11 @@
 		struct ata_device *dev = &ap->device[i];
 		ata_dev_set_protocol(dev);
 	}
+
+	return;
+
+err_out:
+	ata_port_disable(ap);
 }
 
 /**
@@ -1536,116 +1647,102 @@
 	DPRINTK("EXIT\n");
 }
 
-/**
- *	ata_host_set_pio -
- *	@ap:
- *
- *	LOCKING:
- */
-
-static void ata_host_set_pio(struct ata_port *ap)
+static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift)
 {
 	struct ata_device *master, *slave;
-	unsigned int pio, i;
-	u16 mask;
+	unsigned int mask;
 
 	master = &ap->device[0];
 	slave = &ap->device[1];
 
 	assert (ata_dev_present(master) || ata_dev_present(slave));
 
-	mask = ap->pio_mask;
-	if (ata_dev_present(master))
-		mask &= (master->id[ATA_ID_PIO_MODES] & 0x03);
-	if (ata_dev_present(slave))
-		mask &= (slave->id[ATA_ID_PIO_MODES] & 0x03);
-
-	/* require pio mode 3 or 4 support for host and all devices */
-	if (mask == 0) {
-		printk(KERN_WARNING "ata%u: no PIO3/4 support, ignoring\n",
-		       ap->id);
-		goto err_out;
+	if (shift == ATA_SHIFT_UDMA) {
+		mask = ap->udma_mask;
+		if (ata_dev_present(master))
+			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
+		if (ata_dev_present(slave))
+			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
+	}
+	else if (shift == ATA_SHIFT_MWDMA) {
+		mask = ap->mwdma_mask;
+		if (ata_dev_present(master))
+			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
+		if (ata_dev_present(slave))
+			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
+	}
+	else if (shift == ATA_SHIFT_PIO) {
+		mask = ap->pio_mask;
+		if (ata_dev_present(master)) {
+			/* spec doesn't return explicit support for
+			 * PIO0-2, so we fake it
+			 */
+			u16 tmp_mode = master->id[ATA_ID_PIO_MODES] & 0x03;
+			tmp_mode <<= 3;
+			tmp_mode |= 0x7;
+			mask &= tmp_mode;
+		}
+		if (ata_dev_present(slave)) {
+			/* spec doesn't return explicit support for
+			 * PIO0-2, so we fake it
+			 */
+			u16 tmp_mode = slave->id[ATA_ID_PIO_MODES] & 0x03;
+			tmp_mode <<= 3;
+			tmp_mode |= 0x7;
+			mask &= tmp_mode;
+		}
+	}
+	else {
+		mask = 0xffffffff; /* shut up compiler warning */
+		BUG();
 	}
 
-	pio = (mask & ATA_ID_PIO4) ? 4 : 3;
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_present(&ap->device[i])) {
-			ap->device[i].pio_mode = (pio == 3) ?
-				XFER_PIO_3 : XFER_PIO_4;
-			if (ap->ops->set_piomode)
-				ap->ops->set_piomode(ap, &ap->device[i], pio);
-		}
+	return mask;
+}
 
-	return;
+/* find greatest bit */
+static int fgb(u32 bitmap)
+{
+	unsigned int i;
+	int x = -1;
 
-err_out:
-	ap->ops->port_disable(ap);
+	for (i = 0; i < 32; i++)
+		if (bitmap & (1 << i))
+			x = i;
+
+	return x;
 }
 
 /**
- *	ata_host_set_udma -
+ *	ata_choose_xfer_mode -
  *	@ap:
  *
  *	LOCKING:
+ *
+ *	RETURNS:
+ *	Zero on success, negative on error.
  */
 
-static void ata_host_set_udma(struct ata_port *ap)
-{
-	struct ata_device *master, *slave;
-	u16 mask;
-	unsigned int i, j;
-	int udma_mode = -1;
-
-	master = &ap->device[0];
-	slave = &ap->device[1];
-
-	assert (ata_dev_present(master) || ata_dev_present(slave));
-	assert ((ap->flags & ATA_FLAG_PORT_DISABLED) == 0);
-
-	DPRINTK("udma masks: host 0x%X, master 0x%X, slave 0x%X\n",
-		ap->udma_mask,
-		(!ata_dev_present(master)) ? 0xff :
-			(master->id[ATA_ID_UDMA_MODES] & 0xff),
-		(!ata_dev_present(slave)) ? 0xff :
-			(slave->id[ATA_ID_UDMA_MODES] & 0xff));
-
-	mask = ap->udma_mask;
-	if (ata_dev_present(master))
-		mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-	if (ata_dev_present(slave))
-		mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
-
-	i = XFER_UDMA_7;
-	while (i >= XFER_UDMA_0) {
-		j = i - XFER_UDMA_0;
-		DPRINTK("mask 0x%X i 0x%X j %u\n", mask, i, j);
-		if (mask & (1 << j)) {
-			udma_mode = i;
-			break;
+static int ata_choose_xfer_mode(struct ata_port *ap,
+				u8 *xfer_mode_out,
+				unsigned int *xfer_shift_out)
+{
+	unsigned int mask, shift;
+	int x, i;
+
+	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++) {
+		shift = xfer_mode_classes[i].shift;
+		mask = ata_get_mode_mask(ap, shift);
+
+		x = fgb(mask);
+		if (x >= 0) {
+			*xfer_mode_out = xfer_mode_classes[i].base + x;
+			*xfer_shift_out = shift;
+			return 0;
 		}
-
-		i--;
 	}
 
-	/* require udma for host and all attached devices */
-	if (udma_mode < 0) {
-		printk(KERN_WARNING "ata%u: no UltraDMA support, ignoring\n",
-		       ap->id);
-		goto err_out;
-	}
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_present(&ap->device[i])) {
-			ap->device[i].udma_mode = udma_mode;
-			if (ap->ops->set_udmamode)
-				ap->ops->set_udmamode(ap, &ap->device[i],
-						      udma_mode);
-		}
-
-	return;
-
-err_out:
-	ap->ops->port_disable(ap);
+	return -1;
 }
 
 /**
@@ -1658,89 +1755,39 @@
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
-	struct ata_taskfile tf;
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	int rc;
+	unsigned long flags;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
-	ata_tf_init(ap, &tf, dev->devno);
-	tf.ctl |= ATA_NIEN;
-	tf.command = ATA_CMD_SET_FEATURES;
-	tf.feature = SETFEATURES_XFER;
-	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_NODATA;
-	if (dev->flags & ATA_DFLAG_PIO)
-		tf.nsect = dev->pio_mode;
-	else
-		tf.nsect = dev->udma_mode;
 
-	/* do bus reset */
-	ata_tf_to_host(ap, &tf);
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
 
-	/* crazy ATAPI devices... */
-	if (dev->class == ATA_DEV_ATAPI)
-		msleep(150);
+	qc->tf.command = ATA_CMD_SET_FEATURES;
+	qc->tf.feature = SETFEATURES_XFER;
+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	qc->tf.protocol = ATA_PROT_NODATA;
+	qc->tf.nsect = dev->xfer_mode;
 
-	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
 
-	ata_irq_on(ap);	/* re-enable interrupts */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	ata_wait_idle(ap);
+	if (rc)
+		ata_port_disable(ap);
+	else
+		wait_for_completion(&wait);
 
 	DPRINTK("EXIT\n");
 }
 
 /**
- *	ata_dev_set_udma - Set ATA device's transfer mode to Ultra DMA
- *	@ap: Port associated with device @dev
- *	@device: Device whose mode will be set
- *
- *	LOCKING:
- */
-
-static void ata_dev_set_udma(struct ata_port *ap, unsigned int device)
-{
-	struct ata_device *dev = &ap->device[device];
-
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-		return;
-
-	ata_dev_set_xfermode(ap, dev);
-
-	assert((dev->udma_mode >= XFER_UDMA_0) &&
-	       (dev->udma_mode <= XFER_UDMA_7));
-	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
-	       ap->id, device,
-	       udma_str[dev->udma_mode - XFER_UDMA_0]);
-}
-
-/**
- *	ata_dev_set_pio - Set ATA device's transfer mode to PIO
- *	@ap: Port associated with device @dev
- *	@device: Device whose mode will be set
- *
- *	LOCKING:
- */
-
-static void ata_dev_set_pio(struct ata_port *ap, unsigned int device)
-{
-	struct ata_device *dev = &ap->device[device];
-
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-		return;
-
-	/* force PIO mode */
-	dev->flags |= ATA_DFLAG_PIO;
-
-	ata_dev_set_xfermode(ap, dev);
-
-	assert((dev->pio_mode >= XFER_PIO_3) &&
-	       (dev->pio_mode <= XFER_PIO_4));
-	printk(KERN_INFO "ata%u: dev %u configured for PIO%c\n",
-	       ap->id, device,
-	       dev->pio_mode == 3 ? '3' : '4');
-}
-
-/**
  *	ata_sg_clean -
  *	@qc:
  *
@@ -2003,7 +2050,7 @@
 	}
 
 	drv_stat = ata_wait_idle(ap);
-	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+	if (!ata_ok(drv_stat)) {
 		ap->pio_task_state = PIO_ST_ERR;
 		return;
 	}
@@ -2018,6 +2065,128 @@
 	ata_qc_complete(qc, drv_stat);
 }
 
+void swap_buf_le16(u16 *buf, unsigned int buf_words)
+{
+#ifdef __BIG_ENDIAN
+	unsigned int i;
+
+	for (i = 0; i < buf_words; i++)
+		buf[i] = le16_to_cpu(buf[i]);
+#endif /* __BIG_ENDIAN */
+}
+
+static void ata_mmio_data_xfer(struct ata_port *ap, unsigned char *buf,
+			       unsigned int buflen, int write_data)
+{
+	unsigned int i;
+	unsigned int words = buflen >> 1;
+	u16 *buf16 = (u16 *) buf;
+	void *mmio = (void *)ap->ioaddr.data_addr;
+
+	if (write_data) {
+		for (i = 0; i < words; i++)
+			writew(le16_to_cpu(buf16[i]), mmio);
+	} else {
+		for (i = 0; i < words; i++)
+			buf16[i] = cpu_to_le16(readw(mmio));
+	}
+}
+
+static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
+			      unsigned int buflen, int write_data)
+{
+	unsigned int dwords = buflen >> 1;
+
+	if (write_data)
+		outsw(ap->ioaddr.data_addr, buf, dwords);
+	else
+		insw(ap->ioaddr.data_addr, buf, dwords);
+}
+
+static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,
+			  unsigned int buflen, int do_write)
+{
+	if (ap->flags & ATA_FLAG_MMIO)
+		ata_mmio_data_xfer(ap, buf, buflen, do_write);
+	else
+		ata_pio_data_xfer(ap, buf, buflen, do_write);
+}
+
+static void ata_pio_sector(struct ata_queued_cmd *qc)
+{
+	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct scatterlist *sg = qc->sg;
+	struct ata_port *ap = qc->ap;
+	struct page *page;
+	unsigned char *buf;
+
+	if (qc->cursect == (qc->nsect - 1))
+		ap->pio_task_state = PIO_ST_LAST;
+
+	page = sg[qc->cursg].page;
+	buf = kmap(page) +
+	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+
+	qc->cursect++;
+	qc->cursg_ofs++;
+
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
+
+	DPRINTK("data %s, drv_stat 0x%X\n",
+		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
+		status);
+
+	/* do the actual data transfer */
+	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
+
+	kunmap(page);
+}
+
+static void atapi_pio_sector(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	unsigned int i, ireason, bc_lo, bc_hi, bytes;
+	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
+
+	ap->ops->tf_read(ap, &qc->tf);
+	ireason = qc->tf.nsect;
+	bc_lo = qc->tf.lbam;
+	bc_hi = qc->tf.lbah;
+	bytes = (bc_hi << 8) | bc_lo;
+
+	/* shall be cleared to zero, indicating xfer of data */
+	if (ireason & (1 << 0))
+		goto err_out;
+	
+	/* make sure transfer direction matches expected */
+	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
+	if (do_write != i_write)
+		goto err_out;
+
+	/* make sure byte count is multiple of sector size; not
+	* required by standard (warning! warning!), but IDE driver
+	* does this to simplify things a bit.  We are lazy, and
+	* follow suit.
+	*/
+	if (bytes & (ATA_SECT_SIZE - 1))
+		goto err_out;
+
+	for (i = 0; i < (bytes >> 9); i++)
+		ata_pio_sector(qc);
+	
+	return;
+
+err_out:
+	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
+	      ap->id, dev->devno);
+	ap->pio_task_state = PIO_ST_ERR;
+}
+
 /**
  *	ata_pio_sector -
  *	@ap:
@@ -2025,12 +2194,9 @@
  *	LOCKING:
  */
 
-static void ata_pio_sector(struct ata_port *ap)
+static void ata_pio_block(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	struct scatterlist *sg;
-	struct page *page;
-	unsigned char *buf;
 	u8 status;
 
 	/*
@@ -2061,36 +2227,29 @@
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	sg = qc->sg;
-
-	if (qc->cursect == (qc->nsect - 1))
-		ap->pio_task_state = PIO_ST_LAST;
+	if (is_atapi_taskfile(&qc->tf))
+		atapi_pio_sector(qc);
+	else
+		ata_pio_sector(qc);
+}
 
-	page = sg[qc->cursg].page;
-	buf = kmap(page) +
-	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+static void ata_pio_error(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc;
+	u8 drv_stat;
 
-	qc->cursect++;
-	qc->cursg_ofs++;
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
 
-	if (qc->flags & ATA_QCFLAG_SG)
-		if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
-			qc->cursg++;
-			qc->cursg_ofs = 0;
-		}
+	drv_stat = ata_chk_status(ap);
+	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
+	       ap->id, drv_stat);
 
-	DPRINTK("data %s, drv_stat 0x%X\n",
-		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
-		status);
+	ap->pio_task_state = PIO_ST_IDLE;
 
-	/* do the actual data transfer */
-	/* FIXME: mmio-ize */
-	if (qc->tf.flags & ATA_TFLAG_WRITE)
-		outsl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
-	else
-		insl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
+	ata_irq_on(ap);
 
-	kunmap(page);
+	ata_qc_complete(qc, drv_stat | ATA_ERR);
 }
 
 static void ata_pio_task(void *_data)
@@ -2100,7 +2259,7 @@
 
 	switch (ap->pio_task_state) {
 	case PIO_ST:
-		ata_pio_sector(ap);
+		ata_pio_block(ap);
 		break;
 
 	case PIO_ST_LAST:
@@ -2113,15 +2272,8 @@
 		break;
 
 	case PIO_ST_TMOUT:
-		printk(KERN_ERR "ata%d: FIXME: PIO_ST_TMOUT\n", /* FIXME */
-		       ap->id);
-		timeout = 11 * HZ;
-		break;
-
 	case PIO_ST_ERR:
-		printk(KERN_ERR "ata%d: FIXME: PIO_ST_ERR\n", /* FIXME */
-		       ap->id);
-		timeout = 11 * HZ;
+		ata_pio_error(ap);
 		break;
 	}
 
@@ -2180,7 +2332,6 @@
 
 		/* fall through */
 
-	case ATA_PROT_NODATA:
 	default:
 		ata_altstatus(ap);
 		drv_stat = ata_chk_status(ap);
@@ -2287,8 +2438,6 @@
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 
-		if (likely((dev->flags & ATA_DFLAG_PIO) == 0))
-			qc->flags |= ATA_QCFLAG_DMA;
 		if (dev->flags & ATA_DFLAG_LBA48)
 			qc->tf.flags |= ATA_TFLAG_LBA48;
 	}
@@ -2296,6 +2445,11 @@
 	return qc;
 }
 
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	return 0;
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -2335,11 +2489,16 @@
 		do_clear = 1;
 	}
 
-	if (qc->waiting)
-		complete(qc->waiting);
+	if (qc->waiting) {
+		struct completion *waiting = qc->waiting;
+		qc->waiting = NULL;
+		complete(waiting);
+	}
 
 	if (likely(do_clear))
 		clear_bit(tag, &ap->qactive);
+
+	VPRINTK("EXIT\n");
 }
 
 /**
@@ -2422,6 +2581,12 @@
 		break;
 
 	case ATA_PROT_ATAPI:
+		ata_qc_set_polling(qc);
+		ata_tf_to_host_nolock(ap, &qc->tf);
+		queue_work(ata_wq, &ap->packet_task);
+		break;
+
+	case ATA_PROT_ATAPI_NODATA:
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
@@ -2581,7 +2746,7 @@
 	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
 		host_stat = ata_bmdma_status(ap);
-		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
+		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
 
 		/* if it's not our irq... */
 		if (!(host_stat & ATA_DMA_INTR))
@@ -2592,6 +2757,7 @@
 
 		/* fall through */
 
+	case ATA_PROT_ATAPI_NODATA:
 	case ATA_PROT_NODATA:
 		/* check altstatus */
 		status = ata_altstatus(ap);
@@ -2602,7 +2768,8 @@
 		status = ata_chk_status(ap);
 		if (unlikely(status & ATA_BUSY))
 			goto idle_irq;
-		DPRINTK("BUS_NODATA (dev_stat 0x%X)\n", status);
+		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
+			ap->id, qc->tf.protocol, status);
 
 		/* ack bmdma irq events */
 		ata_bmdma_ack_irq(ap);
@@ -2701,21 +2868,20 @@
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
-	if ((status & ATA_DRQ) == 0)
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
 		goto err_out;
 
 	/* send SCSI cdb */
-	/* FIXME: mmio-ize */
 	DPRINTK("send cdb\n");
-	outsl(ap->ioaddr.data_addr,
-	      qc->scsicmd->cmnd, ap->host->max_cmd_len / 4);
+	assert(ap->cdb_len >= 12);
+	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
 
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 
 	/* non-data commands are also handled via irq */
-	else if (qc->scsicmd->sc_data_direction == SCSI_DATA_NONE) {
+	else if (qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
 		/* do nothing */
 	}
 
@@ -2804,11 +2970,11 @@
 	ap->host_set = host_set;
 	ap->port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
+	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
-	ap->device[0].flags = ATA_DFLAG_MASTER;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
@@ -2901,19 +3067,23 @@
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
 		struct ata_port *ap;
+		unsigned long xfer_mode_mask;
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
 		host_set->ports[i] = ap;
+		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
+				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
+				(ap->pio_mask << ATA_SHIFT_PIO);
 
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
 			ap->id,
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-			ata_udma_string(ent->udma_mask),
+			ata_mode_string(xfer_mode_mask),
 	       		ap->ioaddr.cmd_addr,
 	       		ap->ioaddr.ctl_addr,
 	       		ap->ioaddr.bmdma_addr,
@@ -3152,6 +3322,7 @@
 	probe_ent->sht = port0->sht;
 	probe_ent->host_flags = port0->host_flags;
 	probe_ent->pio_mask = port0->pio_mask;
+	probe_ent->mwdma_mask = port0->mwdma_mask;
 	probe_ent->udma_mask = port0->udma_mask;
 	probe_ent->port_ops = port0->port_ops;
 
@@ -3174,6 +3345,7 @@
 		probe_ent2->sht = port1->sht;
 		probe_ent2->host_flags = port1->host_flags;
 		probe_ent2->pio_mask = port1->pio_mask;
+		probe_ent2->mwdma_mask = port1->mwdma_mask;
 		probe_ent2->udma_mask = port1->udma_mask;
 		probe_ent2->port_ops = port1->port_ops;
 	} else {
@@ -3388,6 +3560,7 @@
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-08-18 03:11:44 -04:00
@@ -29,6 +29,7 @@
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <asm/uaccess.h>
 
 #include "libata.h"
 
@@ -36,6 +37,8 @@
 static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
+static struct ata_device *
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev);
 
 
 /**
@@ -67,6 +70,43 @@
 	return 0;
 }
 
+int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
+{
+	struct ata_port *ap;
+	struct ata_device *dev;
+	int val = -EINVAL, rc = -EINVAL;
+
+	ap = (struct ata_port *) &scsidev->host->hostdata[0];
+	if (!ap)
+		goto out;
+
+	dev = ata_scsi_find_dev(ap, scsidev);
+	if (!dev) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	switch (cmd) {
+	case ATA_IOC_GET_IO32:
+		val = 0;
+		if (copy_to_user(arg, &val, 1))
+			return -EFAULT;
+		return 0;
+
+	case ATA_IOC_SET_IO32:
+		val = (long) arg;
+		if (val != 0)
+			return -EINVAL;
+		return 0;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+out:
+	return rc;
+}
 
 /**
  *	ata_scsi_qc_new - acquire new ata_queued_cmd reference
@@ -120,34 +160,158 @@
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
  *
- *	Converts an ATA error into a SCSI error.
- *
- *	Right now, this routine is laughably primitive.  We
- *	don't even examine what ATA told us, we just look at
- *	the command data direction, and return a fatal SCSI
- *	sense error based on that.
+ *	Converts an ATA error into a SCSI error. While we are at it
+ *	we decode and dump the ATA error for the user so that they
+ *	have some idea what really happened at the non make-believe
+ *	layer.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct ata_queued_cmd *qc)
+void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 err = 0;
+	unsigned char *sb = cmd->sense_buffer;
+	/* Based on the 3ware driver translation table */
+	static unsigned char sense_table[][4] = {
+		/* BBD|ECC|ID|MAR */
+		{0xd1, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		/* BBD|ECC|ID */
+		{0xd0,  	ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		/* ECC|MC|MARK */
+		{0x61, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Device fault                 Hardware error
+		/* ICRC|ABRT */		/* NB: ICRC & !ABRT is BBD */
+		{0x84, 		ABORTED_COMMAND, 0x47, 0x00}, 	// Data CRC error               SCSI parity error
+		/* MC|ID|ABRT|TRK0|MARK */
+		{0x37, 		NOT_READY, 0x04, 0x00}, 	// Unit offline                 Not ready
+		/* MCR|MARK */
+		{0x09, 		NOT_READY, 0x04, 0x00}, 	// Unrecovered disk error       Not ready
+		/*  Bad address mark */
+		{0x01, 		MEDIUM_ERROR, 0x13, 0x00}, 	// Address mark not found       Address mark not found for data field
+		/* TRK0 */
+		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		  Hardware error
+		/* Abort & !ICRC */
+		{0x04, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Aborted command              Aborted command
+		/* Media change request */
+		{0x08, 		NOT_READY, 0x04, 0x00}, 	// Media change request	  FIXME: faking offline
+		/* SRV */
+		{0x10, 		ABORTED_COMMAND, 0x14, 0x00}, 	// ID not found                 Recorded entity not found
+		/* Media change */
+		{0x08,  	NOT_READY, 0x04, 0x00}, 	// Media change		  FIXME: faking offline
+		/* ECC */
+		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
+		/* BBD - block marked bad */
+		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+	};
+	static unsigned char stat_table[][4] = {
+		/* Must be first because BUSY means no other bits valid */
+		{0x80, 		ABORTED_COMMAND, 0x47, 0x00},	// Busy, fake parity for now
+		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
+		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
+		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+	};
+	int i = 0;
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
-
-	cmd->sense_buffer[0] = 0x70;
-	cmd->sense_buffer[2] = MEDIUM_ERROR;
-	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
-
+	
+	/*
+	 *	Is this an error we can process/parse
+	 */
+	 
+	if(drv_stat & ATA_ERR)
+		/* Read the err bits */
+		err = ata_chk_err(qc->ap);
+
+	/* Display the ATA level error info */
+	
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
+	if(drv_stat & 0x80)
+	{
+		printk("Busy ");
+		err = 0;	/* Data is not valid in this case */
+	}
+	else {
+		if(drv_stat & 0x40)	printk("DriveReady ");
+		if(drv_stat & 0x20)	printk("DeviceFault ");
+		if(drv_stat & 0x10)	printk("SeekComplete ");
+		if(drv_stat & 0x08)	printk("DataRequest ");
+		if(drv_stat & 0x04)	printk("CorrectedError ");
+		if(drv_stat & 0x02)	printk("Index ");
+		if(drv_stat & 0x01)	printk("Error ");
+	}
+	printk("}\n");
+	
+	if(err)
+	{
+		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
+		if(err & 0x04)		printk("DriveStatusError ");
+		if(err & 0x80)
+		{
+			if(err & 0x04)
+				printk("BadCRC ");
+			else
+				printk("Sector ");
+		}
+		if(err & 0x40)		printk("UncorrectableError ");
+		if(err & 0x10)		printk("SectorIdNotFound ");
+		if(err & 0x02)		printk("TrackZeroNotFound ");
+		if(err & 0x01)		printk("AddrMarkNotFound ");
+		printk("}\n");
+		
+		/* Should we dump sector info here too ?? */
+	}
+		
+	
+	/* Look for err */
+	while(sense_table[i][0] != 0xFF)
+	{
+		/* Look for best matches first */
+		if((sense_table[i][0] & err) == sense_table[i][0])
+		{
+			sb[0] = 0x70;
+			sb[2] = sense_table[i][1];
+			sb[7] = 0x0a;
+			sb[12] = sense_table[i][2];
+			sb[13] = sense_table[i][3];
+			return;
+		}
+		i++;
+	}
+	/* No immediate match */
+	if(err)
+		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
+	
+	/* Fall back to interpreting status bits */
+	while(stat_table[i][0] != 0xFF)
+	{
+		if(stat_table[i][0] & drv_stat)
+		{
+			sb[0] = 0x70;
+			sb[2] = stat_table[i][1];
+			sb[7] = 0x0a;
+			sb[12] = stat_table[i][2];
+			sb[13] = stat_table[i][3];
+			return;
+		}
+		i++;
+	}
+	/* No error ?? */
+	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
 	/* additional-sense-code[-qualifier] */
+	
+	sb[0] = 0x70;
+	sb[2] = MEDIUM_ERROR;
+	sb[7] = 0x0A;
 	if (cmd->sc_data_direction == SCSI_DATA_READ) {
-		cmd->sense_buffer[12] = 0x11; /* "unrecovered read error" */
-		cmd->sense_buffer[13] = 0x04;
+		sb[12] = 0x11; /* "unrecovered read error" */
+		sb[13] = 0x04;
 	} else {
-		cmd->sense_buffer[12] = 0x0C; /* "write error -             */
-		cmd->sense_buffer[13] = 0x02; /*  auto-reallocation failed" */
+		sb[12] = 0x0C; /* "write error -             */
+		sb[13] = 0x02; /*  auto-reallocation failed" */
 	}
 }
 
@@ -214,11 +378,135 @@
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
+	/* TODO: this is per-command; when queueing is supported
+	 * this code will either change or move to a more
+	 * appropriate place
+	 */
+	host->host_failed--;
+
 	DPRINTK("EXIT\n");
 	return 0;
 }
 
 /**
+ *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate (ignored)
+ *
+ *	Sets up an ATA taskfile to issue FLUSH CACHE or
+ *	FLUSH CACHE EXT.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &qc->tf;
+
+	tf->flags |= ATA_TFLAG_DEVICE;
+	tf->protocol = ATA_PROT_NODATA;
+
+	if ((tf->flags & ATA_TFLAG_LBA48) &&
+	    (ata_id_has_flush_ext(qc->dev)))
+		tf->command = ATA_CMD_FLUSH_EXT;
+	else
+		tf->command = ATA_CMD_FLUSH;
+
+	return 0;
+}
+
+/**
+ *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Converts SCSI VERIFY command to an ATA READ VERIFY command.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	u64 dev_sectors = qc->dev->n_sectors;
+	u64 sect = 0;
+	u32 n_sect = 0;
+
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->protocol = ATA_PROT_NODATA;
+	tf->device |= ATA_LBA;
+
+	if (scsicmd[0] == VERIFY) {
+		sect |= ((u64)scsicmd[2]) << 24;
+		sect |= ((u64)scsicmd[3]) << 16;
+		sect |= ((u64)scsicmd[4]) << 8;
+		sect |= ((u64)scsicmd[5]);
+
+		n_sect |= ((u32)scsicmd[7]) << 8;
+		n_sect |= ((u32)scsicmd[8]);
+	}
+
+	else if (scsicmd[0] == VERIFY_16) {
+		sect |= ((u64)scsicmd[2]) << 56;
+		sect |= ((u64)scsicmd[3]) << 48;
+		sect |= ((u64)scsicmd[4]) << 40;
+		sect |= ((u64)scsicmd[5]) << 32;
+		sect |= ((u64)scsicmd[6]) << 24;
+		sect |= ((u64)scsicmd[7]) << 16;
+		sect |= ((u64)scsicmd[8]) << 8;
+		sect |= ((u64)scsicmd[9]);
+
+		n_sect |= ((u32)scsicmd[10]) << 24;
+		n_sect |= ((u32)scsicmd[11]) << 16;
+		n_sect |= ((u32)scsicmd[12]) << 8;
+		n_sect |= ((u32)scsicmd[13]);
+	}
+
+	else
+		return 1;
+
+	if (!n_sect)
+		return 1;
+	if (sect >= dev_sectors)
+		return 1;
+	if ((sect + n_sect) > dev_sectors)
+		return 1;
+	if (lba48) {
+		if (n_sect > (64 * 1024))
+			return 1;
+	} else {
+		if (n_sect > 256)
+			return 1;
+	}
+
+	if (lba48) {
+		tf->hob_nsect = (n_sect >> 8) & 0xff;
+
+		tf->hob_lbah = (sect >> 40) & 0xff;
+		tf->hob_lbam = (sect >> 32) & 0xff;
+		tf->hob_lbal = (sect >> 24) & 0xff;
+	} else
+		tf->device |= (sect >> 24) & 0xf;
+
+	tf->nsect = n_sect & 0xff;
+
+	tf->hob_lbah = (sect >> 16) & 0xff;
+	tf->hob_lbam = (sect >> 8) & 0xff;
+	tf->hob_lbal = sect & 0xff;
+
+	return 0;
+}
+
+/**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate
@@ -244,10 +532,6 @@
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	tf->hob_nsect = 0;
-	tf->hob_lbal = 0;
-	tf->hob_lbam = 0;
-	tf->hob_lbah = 0;
 	tf->protocol = qc->dev->xfer_protocol;
 	tf->device |= ATA_LBA;
 
@@ -339,14 +623,10 @@
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
-		if (is_atapi_taskfile(&qc->tf))
-			cmd->result = SAM_STAT_CHECK_CONDITION;
-		else
-			ata_to_sense_error(qc);
-	} else {
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
+		ata_to_sense_error(qc, drv_stat);
+	else
 		cmd->result = SAM_STAT_GOOD;
-	}
 
 	qc->scsidone(cmd);
 
@@ -534,7 +814,7 @@
 		0,
 		0x5,	/* claim SPC-3 version compatibility */
 		2,
-		96 - 4
+		95 - 4
 	};
 
 	/* set scsi removeable (RMB) bit per ata bit */
@@ -545,7 +825,7 @@
 
 	memcpy(rbuf, hdr, sizeof(hdr));
 
-	if (buflen > 36) {
+	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
 		ata_dev_id_string(dev, &rbuf[16], ATA_ID_PROD_OFS, 16);
 		ata_dev_id_string(dev, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
@@ -964,6 +1244,31 @@
 	done(cmd);
 }
 
+static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
+		cmd->result = SAM_STAT_CHECK_CONDITION;
+	else {
+		u8 *scsicmd = cmd->cmnd;
+
+		if (scsicmd[0] == INQUIRY) {
+			u8 *buf = NULL;
+			unsigned int buflen;
+
+			buflen = ata_scsi_rbuf_get(cmd, &buf);
+			buf[2] = 0x5;
+			buf[3] = (buf[3] & 0xf0) | 2;
+			ata_scsi_rbuf_put(cmd);
+		}
+		cmd->result = SAM_STAT_GOOD;
+	}
+
+	qc->scsidone(cmd);
+
+	return 0;
+}
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
@@ -979,6 +1284,13 @@
 static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_device *dev = qc->dev;
+	int using_pio = (dev->flags & ATA_DFLAG_PIO);
+	int nodata = (cmd->sc_data_direction == SCSI_DATA_NONE);
+
+	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
+
+	qc->complete_fn = atapi_qc_complete;
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
@@ -988,19 +1300,18 @@
 
 	qc->tf.command = ATA_CMD_PACKET;
 
-	/* no data - interrupt-driven */
-	if (cmd->sc_data_direction == SCSI_DATA_NONE)
-		qc->tf.protocol = ATA_PROT_ATAPI;
-
-	/* PIO data xfer - polling */
-	else if ((qc->flags & ATA_QCFLAG_DMA) == 0) {
-		ata_qc_set_polling(qc);
-		qc->tf.protocol = ATA_PROT_ATAPI;
+	/* no data, or PIO data xfer */
+	if (using_pio || nodata) {
+		if (nodata)
+			qc->tf.protocol = ATA_PROT_ATAPI_NODATA;
+		else
+			qc->tf.protocol = ATA_PROT_ATAPI;
 		qc->tf.lbam = (8 * 1024) & 0xff;
 		qc->tf.lbah = (8 * 1024) >> 8;
+	}
 
-	/* DMA data xfer - interrupt-driven */
-	} else {
+	/* DMA data xfer */
+	else {
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
@@ -1031,19 +1342,19 @@
  *	Associated ATA device, or %NULL if not found.
  */
 
-static inline struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, struct scsi_cmnd *cmd)
+static struct ata_device *
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
 {
 	struct ata_device *dev;
 
 	/* skip commands not addressed to targets we simulate */
-	if (likely(cmd->device->id < ATA_MAX_DEVICES))
-		dev = &ap->device[cmd->device->id];
+	if (likely(scsidev->id < ATA_MAX_DEVICES))
+		dev = &ap->device[scsidev->id];
 	else
 		return NULL;
 
-	if (unlikely((cmd->device->channel != 0) ||
-		     (cmd->device->lun != 0)))
+	if (unlikely((scsidev->channel != 0) ||
+		     (scsidev->lun != 0)))
 		return NULL;
 
 	if (unlikely(!ata_dev_present(dev)))
@@ -1059,6 +1370,7 @@
 
 /**
  *	ata_get_xlat_func - check if SCSI to ATA translation is possible
+ *	@dev: ATA device
  *	@cmd: SCSI command opcode to consider
  *
  *	Look up the SCSI command given, and determine whether the
@@ -1068,7 +1380,7 @@
  *	Pointer to translation function if possible, %NULL if not.
  */
 
-static inline ata_xlat_func_t ata_get_xlat_func(u8 cmd)
+static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
 	switch (cmd) {
 	case READ_6:
@@ -1079,6 +1391,15 @@
 	case WRITE_10:
 	case WRITE_16:
 		return ata_scsi_rw_xlat;
+
+	case SYNCHRONIZE_CACHE:
+		if (ata_try_flush_cache(dev))
+			return ata_scsi_flush_xlat;
+		break;
+
+	case VERIFY:
+	case VERIFY_16:
+		return ata_scsi_verify_xlat;
 	}
 
 	return NULL;
@@ -1096,11 +1417,12 @@
 				     struct scsi_cmnd *cmd)
 {
 #ifdef ATA_DEBUG
+	struct scsi_device *scsidev = cmd->device;
 	u8 *scsicmd = cmd->cmnd;
 
 	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
 		ap->id,
-		cmd->device->channel, cmd->device->id, cmd->device->lun,
+		scsidev->channel, scsidev->id, scsidev->lun,
 		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
 		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
 		scsicmd[8]);
@@ -1130,12 +1452,13 @@
 {
 	struct ata_port *ap;
 	struct ata_device *dev;
+	struct scsi_device *scsidev = cmd->device;
 
-	ap = (struct ata_port *) &cmd->device->host->hostdata[0];
+	ap = (struct ata_port *) &scsidev->host->hostdata[0];
 
 	ata_scsi_dump_cdb(ap, cmd);
 
-	dev = ata_scsi_find_dev(ap, cmd);
+	dev = ata_scsi_find_dev(ap, scsidev);
 	if (unlikely(!dev)) {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
@@ -1143,7 +1466,8 @@
 	}
 
 	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);
+		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
+							      cmd->cmnd[0]);
 
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
@@ -1184,7 +1508,7 @@
 
 	switch(scsicmd[0]) {
 		/* no-op's, complete with success */
-		case SYNCHRONIZE_CACHE:		/* FIXME: temporary */
+		case SYNCHRONIZE_CACHE:
 		case REZERO_UNIT:
 		case SEEK_6:
 		case SEEK_10:
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/libata.h	2004-08-18 03:11:44 -04:00
@@ -42,10 +42,11 @@
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
+extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc);
+extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-08-18 03:11:44 -04:00
@@ -44,6 +44,7 @@
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
+#define NV_MWDMA_MASK			0x07
 #define NV_UDMA_MASK			0x7f
 #define NV_PORT0_BMDMA_REG_OFFSET	0x00
 #define NV_PORT1_BMDMA_REG_OFFSET	0x08
@@ -177,6 +178,7 @@
 static Scsi_Host_Template nv_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -343,6 +345,7 @@
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->pio_mask = NV_PIO_MASK;
+	probe_ent->mwdma_mask = NV_MWDMA_MASK;
 	probe_ent->udma_mask = NV_UDMA_MASK;
 
 	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-08-18 03:11:44 -04:00
@@ -74,7 +74,6 @@
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void pdc_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -83,14 +82,13 @@
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
-static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc, int have_err);
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
 static Scsi_Host_Template pdc_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -130,7 +128,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
@@ -140,7 +139,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
@@ -269,26 +269,26 @@
 
 	VPRINTK("ENTER\n");
 
-	ata_qc_prep(qc);
-
-	i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,  qc->dev->devno, pp->pkt);
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+		ata_qc_prep(qc);
+		/* fall through */
 
-	if (qc->tf.flags & ATA_TFLAG_LBA48)
-		i = pdc_prep_lba48(&qc->tf, pp->pkt, i);
-	else
-		i = pdc_prep_lba28(&qc->tf, pp->pkt, i);
+	case ATA_PROT_NODATA:
+		i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,
+				   qc->dev->devno, pp->pkt);
 
-	pdc_pkt_footer(&qc->tf, pp->pkt, i);
-}
+		if (qc->tf.flags & ATA_TFLAG_LBA48)
+			i = pdc_prep_lba48(&qc->tf, pp->pkt, i);
+		else
+			i = pdc_prep_lba28(&qc->tf, pp->pkt, i);
 
-static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc,
-				     int have_err)
-{
-	u8 err_bit = have_err ? ATA_ERR : 0;
+		pdc_pkt_footer(&qc->tf, pp->pkt, i);
+		break;
 
-	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(qc, ata_wait_idle(ap) | err_bit);
+	default:
+		break;
+	}
 }
 
 static void pdc_eng_timeout(struct ata_port *ap)
@@ -315,17 +315,9 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		printk(KERN_ERR "ata%u: DMA timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
-		break;
-
 	case ATA_PROT_NODATA:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
-
-		ata_qc_complete(qc, drv_stat);
+		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
+		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
 		break;
 
 	default:
@@ -358,13 +350,8 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		pdc_dma_complete(ap, qc, have_err);
-		handled = 1;
-		break;
-
-	case ATA_PROT_NODATA:   /* command completion, but no data xfer */
-		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+	case ATA_PROT_NODATA:
+		status = ata_wait_idle(ap);
 		if (have_err)
 			status |= ATA_ERR;
 		ata_qc_complete(qc, status);
@@ -440,7 +427,7 @@
 	return IRQ_RETVAL(handled);
 }
 
-static inline void pdc_dma_start(struct ata_queued_cmd *qc)
+static inline void pdc_packet_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
@@ -462,7 +449,8 @@
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		pdc_dma_start(qc);
+	case ATA_PROT_NODATA:
+		pdc_packet_start(qc);
 		return 0;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -478,14 +466,16 @@
 
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	WARN_ON (tf->protocol == ATA_PROT_DMA);
+	WARN_ON (tf->protocol == ATA_PROT_DMA ||
+		 tf->protocol == ATA_PROT_NODATA);
 	ata_tf_load_mmio(ap, tf);
 }
 
 
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	WARN_ON (tf->protocol == ATA_PROT_DMA);
+	WARN_ON (tf->protocol == ATA_PROT_DMA ||
+		 tf->protocol == ATA_PROT_NODATA);
 	ata_exec_command_mmio(ap, tf);
 }
 
@@ -539,8 +529,7 @@
 	writel(tmp, mmio + PDC_TBG_MODE);
 
 	readl(mmio + PDC_TBG_MODE);	/* flush */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(10) + 1);
+	msleep(10);
 
 	/* adjust slew rate control register. */
 	tmp = readl(mmio + PDC_SLEW_CTL);
@@ -601,6 +590,7 @@
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-08-18 03:11:44 -04:00
@@ -6,7 +6,7 @@
  *		    on emails.
  *
  *  Copyright 2003 Red Hat, Inc.
- *  Copyright 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  Copyright 2003 Benjamin Herrenschmidt
  *
  *  The contents of this file are subject to the Open
  *  Software License version 1.1 that can be found at
@@ -106,6 +106,7 @@
 static Scsi_Host_Template sil_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -149,7 +150,8 @@
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03,			/* pio3-4 */
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
@@ -157,7 +159,8 @@
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03,			/* pio3-4 */
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	},
@@ -363,6 +366,7 @@
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
 	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
 	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
+	probe_ent->mwdma_mask = sil_port_info[ent->driver_data].mwdma_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-08-18 03:11:44 -04:00
@@ -76,6 +76,7 @@
 static Scsi_Host_Template sis_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -230,7 +231,8 @@
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 	}
 
-	probe_ent->pio_mask = 0x03;
+	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 	probe_ent->port_ops = &sis_ops;
 
@@ -284,6 +286,6 @@
 	pci_unregister_driver(&sis_pci_driver);
 }
 
-
 module_init(sis_init);
 module_exit(sis_exit);
+
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-08-18 03:11:44 -04:00
@@ -205,6 +205,7 @@
 static Scsi_Host_Template k2_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -343,6 +344,7 @@
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
@@ -387,6 +389,7 @@
 {
 	return pci_module_init(&k2_sata_pci_driver);
 }
+
 
 static void __exit k2_sata_exit(void)
 {
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-08-18 03:11:44 -04:00
@@ -146,8 +146,6 @@
 
 
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void pdc20621_dma_setup(struct ata_queued_cmd *qc);
-static void pdc20621_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static void pdc_20621_phy_reset (struct ata_port *ap);
@@ -157,8 +155,6 @@
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc20621_host_stop(struct ata_host_set *host_set);
-static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc, int have_err);
 static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe);
 static int pdc20621_detect_dimm(struct ata_probe_ent *pe);
 static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, 
@@ -172,11 +168,13 @@
 static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, 
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
+static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static Scsi_Host_Template pdc_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -199,10 +197,8 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_20621_phy_reset,
-	.bmdma_setup            = pdc20621_dma_setup,
-	.bmdma_start            = pdc20621_dma_start,
 	.qc_prep		= pdc20621_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= pdc20621_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
 	.irq_clear		= pdc20621_irq_clear,
@@ -217,7 +213,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_20621_ops,
 	},
@@ -377,7 +374,10 @@
 
 	/* dimm dma S/G, and next-pkt */
 	dw = i >> 2;
-	buf32[dw] = cpu_to_le32(dimm_sg);
+	if (tf->protocol == ATA_PROT_NODATA)
+		buf32[dw] = 0;
+	else
+		buf32[dw] = cpu_to_le32(dimm_sg);
 	buf32[dw + 1] = 0;
 	i += 8;
 
@@ -437,7 +437,7 @@
 		buf32[dw + 3]);
 }
 
-static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
+static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
@@ -449,8 +449,7 @@
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
 
@@ -501,6 +500,56 @@
 	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
 }
 
+static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct pdc_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	struct pdc_host_priv *hpriv = ap->host_set->private_data;
+	void *dimm_mmio = hpriv->dimm_mmio;
+	unsigned int portno = ap->port_no;
+	unsigned int i;
+
+	VPRINTK("ata%u: ENTER\n", ap->id);
+
+	/* hard-code chip #0 */
+	mmio += PDC_CHIP0_OFS;
+
+	i = pdc20621_ata_pkt(&qc->tf, qc->dev->devno, &pp->dimm_buf[0], portno);
+
+	if (qc->tf.flags & ATA_TFLAG_LBA48)
+		i = pdc_prep_lba48(&qc->tf, &pp->dimm_buf[0], i);
+	else
+		i = pdc_prep_lba28(&qc->tf, &pp->dimm_buf[0], i);
+
+	pdc_pkt_footer(&qc->tf, &pp->dimm_buf[0], i);
+
+	/* copy three S/G tables and two packets to DIMM MMIO window */
+	memcpy_toio(dimm_mmio + (portno * PDC_DIMM_WINDOW_STEP),
+		    &pp->dimm_buf, PDC_DIMM_HEADER_SZ);
+
+	/* force host FIFO dump */
+	writel(0x00000001, mmio + PDC_20621_GENERAL_CTL);
+
+	readl(dimm_mmio);	/* MMIO PCI posting flush */
+
+	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
+}
+
+static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
+{
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+		pdc20621_dma_prep(qc);
+		break;
+	case ATA_PROT_NODATA:
+		pdc20621_nodata_prep(qc);
+		break;
+	default:
+		break;
+	}
+}
+
 static void __pdc20621_push_hdma(struct ata_queued_cmd *qc,
 				 unsigned int seq,
 				 u32 pkt_ofs)
@@ -576,13 +625,7 @@
 static inline void pdc20621_dump_hdma(struct ata_queued_cmd *qc) { }
 #endif /* ATA_VERBOSE_DEBUG */
 
-static void pdc20621_dma_setup(struct ata_queued_cmd *qc)
-{
-	/* nothing for now.  later, we will call standard
-	 * code in libata-core for ATAPI here */
-}
-
-static void pdc20621_dma_start(struct ata_queued_cmd *qc)
+static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
@@ -590,24 +633,21 @@
 	void *mmio = host_set->mmio_base;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 seq = (u8) (port_no + 1);
-	unsigned int doing_hdma = 0, port_ofs;
+	unsigned int port_ofs;
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
 
+	wmb();			/* flush PRD, pkt writes */
+
 	port_ofs = PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * port_no);
 
 	/* if writing, we (1) DMA to DIMM, then (2) do ATA command */
-	if (rw) {
-		doing_hdma = 1;
+	if (rw && qc->tf.protocol == ATA_PROT_DMA) {
 		seq += 4;
-	}
 
-	wmb();			/* flush PRD, pkt writes */
-
-	if (doing_hdma) {
 		pdc20621_dump_hdma(qc);
 		pdc20621_push_hdma(qc, seq, port_ofs + PDC_DIMM_HOST_PKT);
 		VPRINTK("queued ofs 0x%x (%u), seq %u\n",
@@ -628,6 +668,25 @@
 	}
 }
 
+static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_NODATA:
+		pdc20621_packet_start(qc);
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
+	return ata_qc_issue_prot(qc);
+}
+
 static inline unsigned int pdc20621_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc,
 					  unsigned int doing_hdma,
@@ -648,7 +707,8 @@
 		if (doing_hdma) {
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
-			pdc_dma_complete(ap, qc, 0);
+			/* get drive status; clear intr; complete txn */
+			ata_qc_complete(qc, ata_wait_idle(ap));
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -685,7 +745,8 @@
 		else {
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
-			pdc_dma_complete(ap, qc, 0);
+			/* get drive status; clear intr; complete txn */
+			ata_qc_complete(qc, ata_wait_idle(ap));
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -779,16 +840,6 @@
 	return IRQ_RETVAL(handled);
 }
 
-static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc,
-				     int have_err)
-{
-	u8 err_bit = have_err ? ATA_ERR : 0;
-
-	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(qc, ata_wait_idle(ap) | err_bit);
-}
-
 static void pdc_eng_timeout(struct ata_port *ap)
 {
 	u8 drv_stat;
@@ -813,17 +864,9 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		printk(KERN_ERR "ata%u: DMA timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
-		break;
-
 	case ATA_PROT_NODATA:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
-
-		ata_qc_complete(qc, drv_stat);
+		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
+		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
 		break;
 
 	default:
@@ -842,15 +885,17 @@
 
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if (tf->protocol != ATA_PROT_DMA)
-		ata_tf_load_mmio(ap, tf);
+	WARN_ON (tf->protocol == ATA_PROT_DMA ||
+		 tf->protocol == ATA_PROT_NODATA);
+	ata_tf_load_mmio(ap, tf);
 }
 
 
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if (tf->protocol != ATA_PROT_DMA)
-		ata_exec_command_mmio(ap, tf);
+	WARN_ON (tf->protocol == ATA_PROT_DMA ||
+		 tf->protocol == ATA_PROT_NODATA);
+	ata_exec_command_mmio(ap, tf);
 }
 
 
@@ -1384,6 +1429,7 @@
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
@@ -1394,21 +1440,11 @@
 	probe_ent->private_data = hpriv;
 	base += PDC_CHIP0_OFS;
 
+	probe_ent->n_ports = 4;
 	pdc_sata_setup_port(&probe_ent->port[0], base + 0x200);
 	pdc_sata_setup_port(&probe_ent->port[1], base + 0x280);
-
-	/* notice 4-port boards */
-	switch (board_idx) {
-	case board_20621:
-       		probe_ent->n_ports = 4;
-
-		pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
-		pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
-		break;
-	default:
-		BUG();
-		break;
-	}
+	pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
+	pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
 
 	pci_set_master(pdev);
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_via.c	2004-08-18 03:11:44 -04:00
@@ -81,6 +81,7 @@
 static Scsi_Host_Template svia_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -214,6 +215,7 @@
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x07;
 	probe_ent->udma_mask = 0x7f;
 
 	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-08-18 03:11:44 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-08-18 03:11:44 -04:00
@@ -190,6 +190,7 @@
 static Scsi_Host_Template vsc_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -320,6 +321,7 @@
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x07;
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-08-18 03:11:44 -04:00
+++ b/include/linux/ata.h	2004-08-18 03:11:44 -04:00
@@ -42,6 +42,7 @@
 	ATA_ID_SERNO_OFS	= 10,
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_PIO_MODES	= 64,
+	ATA_ID_MWDMA_MODES	= 63,
 	ATA_ID_UDMA_MODES	= 88,
 	ATA_ID_PIO4		= (1 << 1),
 
@@ -133,13 +134,20 @@
 	XFER_UDMA_2		= 0x42,
 	XFER_UDMA_1		= 0x41,
 	XFER_UDMA_0		= 0x40,
+	XFER_MW_DMA_2		= 0x22,
+	XFER_MW_DMA_1		= 0x21,
+	XFER_MW_DMA_0		= 0x20,
 	XFER_PIO_4		= 0x0C,
 	XFER_PIO_3		= 0x0B,
+	XFER_PIO_2		= 0x0A,
+	XFER_PIO_1		= 0x09,
+	XFER_PIO_0		= 0x08,
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
 						   0=to device, 1=to host */
+	ATAPI_CDB_LEN		= 16,
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,
@@ -169,16 +177,22 @@
 	ATA_PROT_PIO,		/* PIO single sector */
 	ATA_PROT_PIO_MULT,	/* PIO multiple sector */
 	ATA_PROT_DMA,		/* DMA */
-	ATA_PROT_ATAPI,		/* packet command */
+	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/
+	ATA_PROT_ATAPI_NODATA,	/* packet command, no data */
 	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
 };
 
+enum ata_ioctls {
+	ATA_IOC_GET_IO32	= 0x309,
+	ATA_IOC_SET_IO32	= 0x324,
+};
+
 /* core structures */
 
 struct ata_prd {
 	u32			addr;
 	u32			flags_len;
-} __attribute__((packed));
+};
 
 struct ata_taskfile {
 	unsigned long		flags;		/* ATA_TFLAG_xxx */
@@ -206,6 +220,8 @@
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
+#define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
+#define ata_id_has_flush_ext(dev) ((dev)->id[83] & (1 << 13))
 #define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
 #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
 #define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
@@ -220,9 +236,20 @@
 	  ((u64) dev->id[(n) + 1] << 16) |	\
 	  ((u64) dev->id[(n) + 0]) )
 
+static inline int atapi_cdb_len(u16 *dev_id)
+{
+	u16 tmp = dev_id[0] & 0x3;
+	switch (tmp) {
+	case 0:		return 12;
+	case 1:		return 16;
+	default:	return -1;
+	}
+}
+
 static inline int is_atapi_taskfile(struct ata_taskfile *tf)
 {
 	return (tf->protocol == ATA_PROT_ATAPI) ||
+	       (tf->protocol == ATA_PROT_ATAPI_NODATA) ||
 	       (tf->protocol == ATA_PROT_ATAPI_DMA);
 }
 
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-08-18 03:11:44 -04:00
+++ b/include/linux/libata.h	2004-08-18 03:11:44 -04:00
@@ -32,7 +32,6 @@
 /*
  * compile-time options
  */
-#undef ATA_FORCE_PIO		/* do not configure or use DMA */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
@@ -88,10 +87,7 @@
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
-	ATA_DFLAG_WCACHE	= (1 << 3), /* has write cache we can
-					     * (hopefully) flush? */
-	ATA_DFLAG_LOCK_SECTORS	= (1 << 4), /* don't adjust max_sectors */
+	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -111,7 +107,6 @@
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
-	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
@@ -140,6 +135,13 @@
 	PORT_UNKNOWN		= 0,
 	PORT_ENABLED		= 1,
 	PORT_DISABLED		= 2,
+
+	/* encoding various smaller bitmaps into a single
+	 * unsigned long bitmap
+	 */
+	ATA_SHIFT_UDMA		= 0,
+	ATA_SHIFT_MWDMA		= 8,
+	ATA_SHIFT_PIO		= 11,
 };
 
 enum pio_task_states {
@@ -188,6 +190,7 @@
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
@@ -215,6 +218,9 @@
 	struct scsi_cmnd	*scsicmd;
 	void			(*scsidone)(struct scsi_cmnd *);
 
+	struct ata_taskfile	tf;
+	u8			cdb[ATAPI_CDB_LEN];
+
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
@@ -226,7 +232,6 @@
 	unsigned int		cursg;
 	unsigned int		cursg_ofs;
 
-	struct ata_taskfile	tf;
 	struct scatterlist	sgent;
 	void			*buf_virt;
 
@@ -251,8 +256,10 @@
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
-	unsigned int		pio_mode;
-	unsigned int		udma_mode;
+	u8			pio_mode;
+	u8			dma_mode;
+	u8			xfer_mode;
+	unsigned int		xfer_shift;	/* ATA_SHIFT_xxx */
 
 	/* cache info about current transfer mode */
 	u8			xfer_protocol;	/* taskfile xfer protocol */
@@ -277,8 +284,10 @@
 	unsigned int		bus_state;
 	unsigned int		port_state;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
+	unsigned int		cdb_len;
 
 	struct ata_device	device[ATA_MAX_DEVICES];
 
@@ -303,10 +312,8 @@
 
 	void (*dev_config) (struct ata_port *, struct ata_device *);
 
-	void (*set_piomode) (struct ata_port *, struct ata_device *,
-			     unsigned int);
-	void (*set_udmamode) (struct ata_port *, struct ata_device *,
-			     unsigned int);
+	void (*set_piomode) (struct ata_port *, struct ata_device *);
+	void (*set_dmamode) (struct ata_port *, struct ata_device *);
 
 	void (*tf_load) (struct ata_port *ap, struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
@@ -342,6 +349,7 @@
 	Scsi_Host_Template	*sht;
 	unsigned long		host_flags;
 	unsigned long		pio_mask;
+	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	struct ata_port_operations	*port_ops;
 };
@@ -363,6 +371,7 @@
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
+extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
@@ -472,7 +481,6 @@
 
 static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 {
-	qc->flags &= ~ATA_QCFLAG_DMA;
 	qc->tf.ctl |= ATA_NIEN;
 }
 
@@ -598,6 +606,13 @@
 	} else
 		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	return host_stat;
+}
+
+static inline int ata_try_flush_cache(struct ata_device *dev)
+{
+	return ata_id_wcache_enabled(dev) ||
+	       ata_id_has_flush(dev) ||
+	       ata_id_has_flush_ext(dev);
 }
 
 #endif /* __LINUX_LIBATA_H__ */
diff -Nru a/include/scsi/scsi.h b/include/scsi/scsi.h
--- a/include/scsi/scsi.h	2004-08-18 03:11:44 -04:00
+++ b/include/scsi/scsi.h	2004-08-18 03:11:44 -04:00
@@ -108,6 +108,7 @@
 #define WRITE_LONG_2          0xea
 #define READ_16               0x88
 #define WRITE_16              0x8a
+#define VERIFY_16	      0x8f
 #define SERVICE_ACTION_IN     0x9e
 /* values for service action in */
 #define	SAI_READ_CAPACITY_16  0x10

--------------060300040007010701090509--
