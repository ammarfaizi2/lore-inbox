Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUGHBJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUGHBJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUGHBJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:09:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265703AbUGHBGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:06:39 -0400
Message-ID: <40EC9DD3.20406@pobox.com>
Date: Wed, 07 Jul 2004 21:05:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH,RFT] SATA core updates
Content-Type: multipart/mixed;
 boundary="------------050806020300090400040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050806020300090400040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Some updates to the SATA core (libata) are required to support SATA-II 
drivers.  These updates (attached for 2.6.7-bk20) just change internals 
only; no behavior should change.

Testing is requested, to make sure I didn't break anything.  Tested 
locally on sata_sil, ata_piix, sata_promise, sata_via and sata_sx4.

These changes are found in the libata-2.4 and libata-2.6 queues (BK info 
below), and also in patches for 2.4.x and 2.6.x:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.27-rc3-libata1.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.7-bk20-libata1.patch.bz2

bk://gkernel.bkbits.net/libata-2.4
bk://gkernel.bkbits.net/libata-2.6



--------------050806020300090400040600
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

BK users may do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ata_piix.c     |   81 +++--
 drivers/scsi/libata-core.c  |  611 ++++++++++++++++++++++++--------------------
 drivers/scsi/libata-scsi.c  |    9 
 drivers/scsi/sata_nv.c      |    2 
 drivers/scsi/sata_promise.c |   77 ++---
 drivers/scsi/sata_sil.c     |    7 
 drivers/scsi/sata_sis.c     |    3 
 drivers/scsi/sata_svw.c     |    1 
 drivers/scsi/sata_sx4.c     |  165 +++++++----
 drivers/scsi/sata_via.c     |    1 
 drivers/scsi/sata_vsc.c     |    1 
 include/linux/ata.h         |    7 
 include/linux/libata.h      |   25 +
 13 files changed, 571 insertions(+), 419 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/07/07 1.1844)
   [libata] update IDENTIFY DEVICE path to use ata_queued_cmd
   
   rather than hand-rolling our own taskfile call (which won't work at
   all on newer SATA controllers).
   
   Individual changes:
   * use ata_qc_issue to issue identify-device command
   * implement MMIO path for PIO data xfer
   * implement PIO error handling path

<jgarzik@pobox.com> (04/07/07 1.1841.1.1)
   [libata] pio/dma flag bug fix, and cleanup
   
   In the transfer-mode cleanup recently, the code that set flag
   ATA_DFLAG_PIO disappeared.  Resurrect it.
   
   Remove ATA_QCFLAG_DMA, it isn't needed.
   
   Always set polling in the ->qc_issue function, rather than force
   the user to do it when setting up an ata_queued_cmd.  This gives
   maximum flexibility to the driver, letting the driver choose
   whether or not to poll.

<jgarzik@pobox.com> (04/07/05 1.1757.57.14)
   [libata sata_sx4] deliver non-data taskfiles using Promise packet format

<jgarzik@pobox.com> (04/07/04 1.1757.57.13)
   [libata sata_promise] convert to using packets for non-data taskfiles

<jgarzik@pobox.com> (04/07/04 1.1757.58.1)
   [libata] transfer mode bug fixes and type cleanup
   
   Fix two bugs that causes the recently-added transfer mode code
   to break on 64-bit platforms.  Make associated code more type-correct
   in the process.

<jgarzik@pobox.com> (04/07/04 1.1757.57.11)
   [libata] convert set-xfer-mode operation to use ata_queued_cmd

<jgarzik@pobox.com> (04/07/04 1.1757.57.10)
   [libata] fix completion bug, better debug output
   
   When using a completion, we need to clear the entry, and furthermore
   clear the entry before we call the completion.
   
   Make debugging output a bit more explicit.

<jgarzik@pobox.com> (04/07/04 1.1757.57.9)
   [libata] transfer mode cleanup
   
   Add MWDMA support, and rework pio/mwdma/udma mode setup.
   
   In the lone test case for PATA support, ata_piix, MWDMA mode setting
   does not appear to work here.  UDMA and PIO continue to work, so nobody
   will really notice.  But beware.  Probably a driver problem, not
   a bug in the core.
   
   Also, doesn't bother writing to dummy timing registers on ICH5/6 SATA
   anymore.

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-07-07 20:56:50 -04:00
@@ -65,10 +65,8 @@
 
 static void piix_pata_phy_reset(struct ata_port *ap);
 static void piix_sata_phy_reset(struct ata_port *ap);
-static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int pio);
-static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
-			       unsigned int udma);
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
+static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
 static unsigned int in_module_init = 1;
 
@@ -126,7 +124,7 @@
 static struct ata_port_operations piix_pata_ops = {
 	.port_disable		= ata_port_disable,
 	.set_piomode		= piix_set_piomode,
-	.set_udmamode		= piix_set_udmamode,
+	.set_dmamode		= piix_set_dmamode,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
@@ -151,8 +149,6 @@
 
 static struct ata_port_operations piix_sata_ops = {
 	.port_disable		= ata_port_disable,
-	.set_piomode		= piix_set_piomode,
-	.set_udmamode		= piix_set_udmamode,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
@@ -181,7 +177,12 @@
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
@@ -191,8 +192,9 @@
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
 
@@ -200,7 +202,12 @@
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
@@ -211,8 +218,9 @@
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
 				  ATA_FLAG_SLAVE_POSS,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
 };
@@ -368,9 +376,9 @@
  *	None (inherited from caller).
  */
 
-static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int pio)
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
+	unsigned int pio	= adev->pio_mode;
 	struct pci_dev *dev	= ap->host_set->pdev;
 	unsigned int is_slave	= (adev->flags & ATA_DFLAG_MASTER) ? 0 : 1;
 	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
@@ -409,7 +417,7 @@
 }
 
 /**
- *	piix_set_udmamode - Initialize host controller PATA PIO timings
+ *	piix_set_dmamode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: um
  *	@udma: udma mode, 0 - 6
@@ -420,9 +428,9 @@
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
@@ -452,25 +460,38 @@
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
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/libata-core.c	2004-07-07 20:56:50 -04:00
@@ -50,11 +50,14 @@
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
@@ -524,7 +527,7 @@
 	dev->write_cmd = (cmd >> 8) & 0xff;
 }
 
-static const char * udma_str[] = {
+static const char * xfer_mode_str[] = {
 	"UDMA/16",
 	"UDMA/25",
 	"UDMA/33",
@@ -533,6 +536,14 @@
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
@@ -550,16 +561,24 @@
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
@@ -930,10 +949,14 @@
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
@@ -953,27 +976,34 @@
 
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
@@ -988,45 +1018,20 @@
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
-
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
 	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
@@ -1045,12 +1050,13 @@
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
@@ -1083,7 +1089,7 @@
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes),
+		       ata_mode_string(xfer_modes),
 		       (unsigned long long)dev->n_sectors,
 		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
 	}
@@ -1101,7 +1107,7 @@
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes));
+		       ata_mode_string(xfer_modes));
 	}
 
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
@@ -1232,6 +1238,101 @@
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
@@ -1241,29 +1342,28 @@
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
@@ -1275,6 +1375,11 @@
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
@@ -1536,116 +1641,102 @@
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
@@ -1658,89 +1749,39 @@
 
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
@@ -2003,7 +2044,7 @@
 	}
 
 	drv_stat = ata_wait_idle(ap);
-	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+	if (!ata_ok(drv_stat)) {
 		ap->pio_task_state = PIO_ST_ERR;
 		return;
 	}
@@ -2071,26 +2112,58 @@
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if (qc->flags & ATA_QCFLAG_SG)
-		if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
-			qc->cursg++;
-			qc->cursg_ofs = 0;
-		}
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
 
 	DPRINTK("data %s, drv_stat 0x%X\n",
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
 		status);
 
 	/* do the actual data transfer */
-	/* FIXME: mmio-ize */
-	if (qc->tf.flags & ATA_TFLAG_WRITE)
-		outsl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
-	else
-		insl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
+	if (ap->flags & ATA_FLAG_MMIO) {
+		unsigned int i;
+		unsigned int words = ATA_SECT_SIZE / 2;
+		u16 *buf16 = (u16 *) buf;
+		void *mmio = (void *)ap->ioaddr.data_addr;
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+			for (i = 0; i < words; i++)
+				writew(buf16[i], mmio);
+		} else {
+			for (i = 0; i < words; i++)
+				buf16[i] = readw(mmio);
+		}
+	} else {
+		if (qc->tf.flags & ATA_TFLAG_WRITE)
+			outsl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
+		else
+			insl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
+	}
 
 	kunmap(sg[qc->cursg].page);
 }
 
+static void ata_pio_error(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc;
+	u8 drv_stat;
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
+	drv_stat = ata_chk_status(ap);
+	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
+	       ap->id, drv_stat);
+
+	ap->pio_task_state = PIO_ST_IDLE;
+
+	ata_irq_on(ap);
+
+	ata_qc_complete(qc, drv_stat | ATA_ERR);
+}
+
 static void ata_pio_task(void *_data)
 {
 	struct ata_port *ap = _data;
@@ -2111,15 +2184,8 @@
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
 
@@ -2285,8 +2351,6 @@
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 
-		if (likely((dev->flags & ATA_DFLAG_PIO) == 0))
-			qc->flags |= ATA_QCFLAG_DMA;
 		if (dev->flags & ATA_DFLAG_LBA48)
 			qc->tf.flags |= ATA_TFLAG_LBA48;
 	}
@@ -2294,6 +2358,11 @@
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
@@ -2333,11 +2402,16 @@
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
@@ -2420,6 +2494,7 @@
 		break;
 
 	case ATA_PROT_ATAPI:
+		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
@@ -2578,7 +2653,7 @@
 	case ATA_PROT_ATAPI_DMA:
 		/* check status of DMA engine */
 		host_stat = ata_bmdma_status(ap);
-		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
+		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
 
 		/* if it's not our irq... */
 		if (!(host_stat & ATA_DMA_INTR))
@@ -2599,7 +2674,8 @@
 		status = ata_chk_status(ap);
 		if (unlikely(status & ATA_BUSY))
 			goto idle_irq;
-		DPRINTK("BUS_NODATA (dev_stat 0x%X)\n", status);
+		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
+			ap->id, qc->tf.protocol, status);
 
 		/* ack bmdma irq events */
 		ata_bmdma_ack_irq(ap);
@@ -2801,6 +2877,7 @@
 	ap->host_set = host_set;
 	ap->port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
+	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
@@ -2898,19 +2975,23 @@
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
@@ -3149,6 +3230,7 @@
 	probe_ent->sht = port0->sht;
 	probe_ent->host_flags = port0->host_flags;
 	probe_ent->pio_mask = port0->pio_mask;
+	probe_ent->mwdma_mask = port0->mwdma_mask;
 	probe_ent->udma_mask = port0->udma_mask;
 	probe_ent->port_ops = port0->port_ops;
 
@@ -3171,6 +3253,7 @@
 		probe_ent2->sht = port1->sht;
 		probe_ent2->host_flags = port1->host_flags;
 		probe_ent2->pio_mask = port1->pio_mask;
+		probe_ent2->mwdma_mask = port1->mwdma_mask;
 		probe_ent2->udma_mask = port1->udma_mask;
 		probe_ent2->port_ops = port1->port_ops;
 	} else {
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-07-07 20:56:50 -04:00
@@ -979,6 +979,8 @@
 static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_device *dev = qc->dev;
+	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
@@ -992,14 +994,13 @@
 	if (cmd->sc_data_direction == SCSI_DATA_NONE)
 		qc->tf.protocol = ATA_PROT_ATAPI;
 
-	/* PIO data xfer - polling */
-	else if ((qc->flags & ATA_QCFLAG_DMA) == 0) {
-		ata_qc_set_polling(qc);
+	/* PIO data xfer */
+	else if (using_pio) {
 		qc->tf.protocol = ATA_PROT_ATAPI;
 		qc->tf.lbam = (8 * 1024) & 0xff;
 		qc->tf.lbah = (8 * 1024) >> 8;
 
-	/* DMA data xfer - interrupt-driven */
+	/* DMA data xfer */
 	} else {
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-07-07 20:56:50 -04:00
@@ -39,6 +39,7 @@
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
+#define NV_MWDMA_MASK			0x07
 #define NV_UDMA_MASK			0x7f
 #define NV_PORT0_BMDMA_REG_OFFSET	0x00
 #define NV_PORT1_BMDMA_REG_OFFSET	0x08
@@ -289,6 +290,7 @@
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->pio_mask = NV_PIO_MASK;
+	probe_ent->mwdma_mask = NV_MWDMA_MASK;
 	probe_ent->udma_mask = NV_UDMA_MASK;
 
 	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-07-07 20:56:50 -04:00
@@ -74,7 +74,6 @@
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void pdc_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -83,8 +82,6 @@
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
-static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc, int have_err);
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
@@ -130,7 +127,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
@@ -140,7 +138,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
@@ -269,26 +268,26 @@
 
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
@@ -315,17 +314,9 @@
 
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
@@ -358,13 +349,8 @@
 
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
@@ -440,7 +426,7 @@
 	return IRQ_RETVAL(handled);
 }
 
-static inline void pdc_dma_start(struct ata_queued_cmd *qc)
+static inline void pdc_packet_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
@@ -462,7 +448,8 @@
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		pdc_dma_start(qc);
+	case ATA_PROT_NODATA:
+		pdc_packet_start(qc);
 		return 0;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -478,14 +465,16 @@
 
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
 
@@ -539,8 +528,7 @@
 	writel(tmp, mmio + PDC_TBG_MODE);
 
 	readl(mmio + PDC_TBG_MODE);	/* flush */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(10) + 1);
+	msleep(10);
 
 	/* adjust slew rate control register. */
 	tmp = readl(mmio + PDC_SLEW_CTL);
@@ -601,6 +589,7 @@
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-07-07 20:56:50 -04:00
@@ -149,7 +149,8 @@
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03,			/* pio3-4 */
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
@@ -157,7 +158,8 @@
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03,			/* pio3-4 */
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	},
@@ -363,6 +365,7 @@
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
 	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
 	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
+	probe_ent->mwdma_mask = sil_port_info[ent->driver_data].mwdma_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-07-07 20:56:50 -04:00
@@ -230,7 +230,8 @@
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 	}
 
-	probe_ent->pio_mask = 0x03;
+	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 	probe_ent->port_ops = &sis_ops;
 
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-07-07 20:56:50 -04:00
@@ -343,6 +343,7 @@
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-07-07 20:56:50 -04:00
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
@@ -172,6 +168,7 @@
 static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, 
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
+static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static Scsi_Host_Template pdc_sata_sht = {
@@ -199,10 +196,8 @@
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
@@ -217,7 +212,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_20621_ops,
 	},
@@ -377,7 +373,10 @@
 
 	/* dimm dma S/G, and next-pkt */
 	dw = i >> 2;
-	buf32[dw] = cpu_to_le32(dimm_sg);
+	if (tf->protocol == ATA_PROT_NODATA)
+		buf32[dw] = 0;
+	else
+		buf32[dw] = cpu_to_le32(dimm_sg);
 	buf32[dw + 1] = 0;
 	i += 8;
 
@@ -437,7 +436,7 @@
 		buf32[dw + 3]);
 }
 
-static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
+static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
@@ -449,8 +448,7 @@
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
 
@@ -501,6 +499,56 @@
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
@@ -576,13 +624,7 @@
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
@@ -590,24 +632,21 @@
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
@@ -628,6 +667,25 @@
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
@@ -648,7 +706,8 @@
 		if (doing_hdma) {
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
-			pdc_dma_complete(ap, qc, 0);
+			/* get drive status; clear intr; complete txn */
+			ata_qc_complete(qc, ata_wait_idle(ap));
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -685,7 +744,8 @@
 		else {
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
-			pdc_dma_complete(ap, qc, 0);
+			/* get drive status; clear intr; complete txn */
+			ata_qc_complete(qc, ata_wait_idle(ap));
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -779,16 +839,6 @@
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
@@ -813,17 +863,9 @@
 
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
@@ -842,15 +884,17 @@
 
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
 
 
@@ -1384,6 +1428,7 @@
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
@@ -1394,21 +1439,11 @@
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
--- a/drivers/scsi/sata_via.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_via.c	2004-07-07 20:56:50 -04:00
@@ -214,6 +214,7 @@
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x07;
 	probe_ent->udma_mask = 0x7f;
 
 	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-07-07 20:56:50 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-07-07 20:56:50 -04:00
@@ -320,6 +320,7 @@
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x07;
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-07-07 20:56:50 -04:00
+++ b/include/linux/ata.h	2004-07-07 20:56:50 -04:00
@@ -42,6 +42,7 @@
 	ATA_ID_SERNO_OFS	= 10,
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_PIO_MODES	= 64,
+	ATA_ID_MWDMA_MODES	= 63,
 	ATA_ID_UDMA_MODES	= 88,
 	ATA_ID_PIO4		= (1 << 1),
 
@@ -133,8 +134,14 @@
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
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-07-07 20:56:50 -04:00
+++ b/include/linux/libata.h	2004-07-07 20:56:50 -04:00
@@ -32,7 +32,6 @@
 /*
  * compile-time options
  */
-#undef ATA_FORCE_PIO		/* do not configure or use DMA */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
@@ -111,7 +110,6 @@
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
-	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
@@ -140,6 +138,13 @@
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
@@ -188,6 +193,7 @@
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
@@ -251,8 +257,10 @@
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
@@ -277,6 +285,7 @@
 	unsigned int		bus_state;
 	unsigned int		port_state;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
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
@@ -472,7 +480,6 @@
 
 static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 {
-	qc->flags &= ~ATA_QCFLAG_DMA;
 	qc->tf.ctl |= ATA_NIEN;
 }
 

--------------050806020300090400040600--
