Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVCDHP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVCDHP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVCDHP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:15:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38887 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262569AbVCDHKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:10:33 -0500
Message-ID: <422809D6.5090909@pobox.com>
Date: Fri, 04 Mar 2005 02:10:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Sommrey <jo@sommrey.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
References: <3Ds62-5AS-3@gated-at.bofh.it> <200503022034.j22KYppm010967@bear.sommrey.de> <422641AF.8070309@pobox.com> <20050303193229.GA10265@sommrey.de> <4227DF76.3030401@pobox.com> <20050304063717.GA12203@sommrey.de>
In-Reply-To: <20050304063717.GA12203@sommrey.de>
Content-Type: multipart/mixed;
 boundary="------------020306020704090906090005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306020704090906090005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joerg Sommrey wrote:
> On Thu, Mar 03, 2005 at 11:09:26PM -0500, Jeff Garzik wrote:
> 
>>Joerg Sommrey wrote:
>>
>>>On Wed, Mar 02, 2005 at 05:43:59PM -0500, Jeff Garzik wrote:
>>>
>>>
>>>>Joerg Sommrey wrote:
>>>>
>>>>
>>>>>Jeff Garzik wrote:
>>>>>
>>>>>
>>>>>>Patch:
>>>>>>http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc5-bk4-libata-dev1.patch.bz2
>>>>>
>>>>>
>>>>>Still not usable here.  The same errors as before when backing up:
>>>>
>>>>Please try 2.6.11 without any patches.
>>>
>>>Plain 2.6.11 doesn't work either.  All of 2.6.10-ac11, 2.6.11-rc5,
>>>2.6.11-rc5 + 2.6.11-rc5-bk4-libata-dev1.patch and 2.6.11 fail with the
>>>same symptoms. 
>>>
>>>Reverting to stable 2.6.10-ac8 :-)
>>
>>Does reverting the attached patch in 2.6.11 (apply with patch -R) fix 
>>things?
>>
> 
> 
> Still the same with this patch reverted.

Does reverting the attached patch in 2.6.11 fix things?  (apply with 
patch -R)

This patch reverts the entire libata back to 2.6.10.

	Jeff



--------------020306020704090906090005
Content-Type: text/plain;
 name="patch-2.6.11-libata"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.11-libata"

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-03-01 23:38:53 -08:00
+++ b/drivers/scsi/ahci.c	2005-03-01 23:38:53 -08:00
@@ -179,6 +179,7 @@
 static void ahci_host_stop(struct ata_host_set *host_set);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
+static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 
 static Scsi_Host_Template ahci_sht = {
@@ -204,6 +205,8 @@
 	.port_disable		= ata_port_disable,
 
 	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
 	.phy_reset		= ahci_phy_reset,
@@ -239,9 +242,19 @@
 
 static struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },
+	  board_ahci }, /* ICH6 */
 	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },
+	  board_ahci }, /* ICH6M */
+	{ PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7 */
+	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7M */
+	{ PCI_VENDOR_ID_INTEL, 0x27c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7R */
+	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7R */
+	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ULi M5288 */
 	{ }	/* terminate list */
 };
 
@@ -442,6 +455,13 @@
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
@@ -509,15 +529,6 @@
 	ahci_fill_sg(qc);
 }
 
-static inline void ahci_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc,
-				     int have_err)
-{
-	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			have_err ? ATA_ERR : 0);
-}
-
 static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
 {
 	void *mmio = ap->host_set->mmio_base;
@@ -939,6 +950,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -951,8 +963,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	pci_enable_intx(pdev);
 
@@ -1014,7 +1028,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2005-03-01 23:39:18 -08:00
+++ b/drivers/scsi/ata_piix.c	2005-03-01 23:39:18 -08:00
@@ -60,6 +60,7 @@
 	piix4_pata		= 2,
 	ich6_sata		= 3,
 	ich6_sata_rm		= 4,
+	ich7_sata		= 5,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -90,6 +91,8 @@
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
 	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
+	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 
 	{ }	/* terminate list */
 };
@@ -135,6 +138,8 @@
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -160,6 +165,8 @@
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -226,6 +233,18 @@
 	},
 
 	/* ich6_sata_rm */
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
+
+	/* ich7_sata */
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-03-01 23:38:44 -08:00
+++ b/drivers/scsi/libata-core.c	2005-03-01 23:38:44 -08:00
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
@@ -376,7 +377,7 @@
 }
 
 /**
- *	ata_check_status - Read device status reg & clear interrupt
+ *	ata_check_status_pio - Read device status reg & clear interrupt
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
@@ -414,6 +415,27 @@
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
@@ -1160,7 +1182,6 @@
 	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
 	       ap->id, device);
 err_out:
-	ata_irq_on(ap);	/* re-enable interrupts */
 	dev->class++;	/* converts ATA_DEV_xxx into ATA_DEV_xxx_UNSUP */
 	DPRINTK("EXIT, err\n");
 }
@@ -1668,7 +1689,8 @@
 		ata_dev_try_classify(ap, 1);
 
 	/* re-enable interrupts */
-	ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -1699,6 +1721,69 @@
 	DPRINTK("EXIT\n");
 }
 
+static void ata_pr_blacklisted(struct ata_port *ap, struct ata_device *dev)
+{
+	printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, disabling DMA\n",
+		ap->id, dev->devno);
+}
+
+static const char * ata_dma_blacklist [] = {
+	"WDC AC11000H",
+	"WDC AC22100H",
+	"WDC AC32500H",
+	"WDC AC33100H",
+	"WDC AC31600H",
+	"WDC AC32100H",
+	"WDC AC23200L",
+	"Compaq CRD-8241B",
+	"CRD-8400B",
+	"CRD-8480B",
+	"CRD-8482B",
+ 	"CRD-84",
+	"SanDisk SDP3B",
+	"SanDisk SDP3B-64",
+	"SANYO CD-ROM CRD",
+	"HITACHI CDR-8",
+	"HITACHI CDR-8335",
+	"HITACHI CDR-8435",
+	"Toshiba CD-ROM XM-6202B",
+	"CD-532E-A",
+	"E-IDE CD-ROM CR-840",
+	"CD-ROM Drive/F5A",
+	"WPI CDD-820",
+	"SAMSUNG CD-ROM SC-148C",
+	"SAMSUNG CD-ROM SC",
+	"SanDisk SDP3B-64",
+	"SAMSUNG CD-ROM SN-124",
+	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
+	"_NEC DV5800A",
+};
+
+static int ata_dma_blacklisted(struct ata_port *ap, struct ata_device *dev)
+{
+	unsigned char model_num[40];
+	char *s;
+	unsigned int len;
+	int i;
+
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
+			  sizeof(model_num));
+	s = &model_num[0];
+	len = strnlen(s, sizeof(model_num));
+
+	/* ATAPI specifies that empty space is blank-filled; remove blanks */
+	while ((len > 0) && (s[len - 1] == ' ')) {
+		len--;
+		s[len] = 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i++)
+		if (!strncmp(ata_dma_blacklist[i], s, len))
+			return 1;
+
+	return 0;
+}
+
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift)
 {
 	struct ata_device *master, *slave;
@@ -1711,17 +1796,37 @@
 
 	if (shift == ATA_SHIFT_UDMA) {
 		mask = ap->udma_mask;
-		if (ata_dev_present(master))
+		if (ata_dev_present(master)) {
 			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-		if (ata_dev_present(slave))
+			if (ata_dma_blacklisted(ap, master)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, master);
+			}
+		}
+		if (ata_dev_present(slave)) {
 			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
+			if (ata_dma_blacklisted(ap, slave)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, slave);
+			}
+		}
 	}
 	else if (shift == ATA_SHIFT_MWDMA) {
 		mask = ap->mwdma_mask;
-		if (ata_dev_present(master))
+		if (ata_dev_present(master)) {
 			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
-		if (ata_dev_present(slave))
+			if (ata_dma_blacklisted(ap, master)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, master);
+			}
+		}
+		if (ata_dev_present(slave)) {
 			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
+			if (ata_dma_blacklisted(ap, slave)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, slave);
+			}
+		}
 	}
 	else if (shift == ATA_SHIFT_PIO) {
 		mask = ap->pio_mask;
@@ -1919,7 +2024,24 @@
 	if (idx)
 		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
+/**
+ *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
+ *	@qc: Metadata associated with taskfile to check
+ *
+ *	LOCKING:
+ *	RETURNS: 0 when ATAPI DMA can be used
+ *               nonzero otherwise
+ */
+int ata_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	int rc = 0; /* Assume ATAPI DMA is OK by default */
+
+	if (ap->ops->check_atapi_dma)
+		rc = ap->ops->check_atapi_dma(qc);
 
+	return rc;
+}
 /**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
@@ -2369,6 +2491,9 @@
 	unsigned long timeout = 0;
 
 	switch (ap->pio_task_state) {
+	case PIO_ST_IDLE:
+		return;
+
 	case PIO_ST:
 		ata_pio_block(ap);
 		break;
@@ -2385,18 +2510,14 @@
 	case PIO_ST_TMOUT:
 	case PIO_ST_ERR:
 		ata_pio_error(ap);
-		break;
+		return;
 	}
 
-	if ((ap->pio_task_state != PIO_ST_IDLE) &&
-	    (ap->pio_task_state != PIO_ST_TMOUT) &&
-	    (ap->pio_task_state != PIO_ST_ERR)) {
-		if (timeout)
-			queue_delayed_work(ata_wq, &ap->pio_task,
-					   timeout);
-		else
-			queue_work(ata_wq, &ap->pio_task);
-	}
+	if (timeout)
+		queue_delayed_work(ata_wq, &ap->pio_task,
+				   timeout);
+	else
+		queue_work(ata_wq, &ap->pio_task);
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
@@ -2405,7 +2526,6 @@
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
-	int using_pio = dev->flags & ATA_DFLAG_PIO;
 	int rc;
 
 	DPRINTK("ATAPI request sense\n");
@@ -2426,16 +2546,10 @@
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	qc->tf.command = ATA_CMD_PACKET;
 
-	if (using_pio) {
-		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
-
-		qc->nbytes = SCSI_SENSE_BUFFERSIZE;
-	} else {
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-		qc->tf.feature |= ATAPI_PKT_DMA;
-	}
+	qc->tf.protocol = ATA_PROT_ATAPI;
+	qc->tf.lbam = (8 * 1024) & 0xff;
+	qc->tf.lbah = (8 * 1024) >> 8;
+	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
@@ -2508,10 +2622,10 @@
 
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		host_stat = ata_bmdma_status(ap);
+		host_stat = ap->ops->bmdma_status(ap);
 
 		/* before we do anything else, clear DMA-Start bit */
-		ata_bmdma_stop(ap);
+		ap->ops->bmdma_stop(ap);
 
 		/* fall through */
 
@@ -2520,7 +2634,7 @@
 		drv_stat = ata_chk_status(ap);
 
 		/* ack bmdma irq events */
-		ata_bmdma_ack_irq(ap);
+		ap->ops->irq_clear(ap);
 
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
@@ -2659,6 +2773,24 @@
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
@@ -2707,7 +2839,7 @@
 			return 1;
 
 		/* fall through */
-	
+
 	default:
 		return 0;
 	}
@@ -2949,7 +3081,43 @@
 
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
@@ -2979,7 +3147,7 @@
 	case ATA_PROT_ATAPI_DMA:
 	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
-		host_stat = ata_bmdma_status(ap);
+		host_stat = ap->ops->bmdma_status(ap);
 		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
 
 		/* if it's not our irq... */
@@ -2987,7 +3155,7 @@
 			goto idle_irq;
 
 		/* before we do anything else, clear DMA-Start bit */
-		ata_bmdma_stop(ap);
+		ap->ops->bmdma_stop(ap);
 
 		/* fall through */
 
@@ -3006,7 +3174,7 @@
 			ap->id, qc->tf.protocol, status);
 
 		/* ack bmdma irq events */
-		ata_bmdma_ack_irq(ap);
+		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
@@ -3442,32 +3610,28 @@
 }
 
 static struct ata_probe_ent *
-ata_probe_ent_alloc(int n, struct device *dev, struct ata_port_info **port)
+ata_probe_ent_alloc(struct device *dev, struct ata_port_info *port)
 {
 	struct ata_probe_ent *probe_ent;
-	int i;
 
-	probe_ent = kmalloc(sizeof(*probe_ent) * n, GFP_KERNEL);
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       kobject_name(&(dev->kobj)));
 		return NULL;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent) * n);
+	memset(probe_ent, 0, sizeof(*probe_ent));
 
-	for (i = 0; i < n; i++) {
-		INIT_LIST_HEAD(&probe_ent[i].node);
-		probe_ent[i].dev = dev;
-
-		probe_ent[i].sht = port[i]->sht;
-		probe_ent[i].host_flags = port[i]->host_flags;
-		probe_ent[i].pio_mask = port[i]->pio_mask;
-		probe_ent[i].mwdma_mask = port[i]->mwdma_mask;
-		probe_ent[i].udma_mask = port[i]->udma_mask;
-		probe_ent[i].port_ops = port[i]->port_ops;
+	INIT_LIST_HEAD(&probe_ent->node);
+	probe_ent->dev = dev;
 
-	}
+	probe_ent->sht = port->sht;
+	probe_ent->host_flags = port->host_flags;
+	probe_ent->pio_mask = port->pio_mask;
+	probe_ent->mwdma_mask = port->mwdma_mask;
+	probe_ent->udma_mask = port->udma_mask;
+	probe_ent->port_ops = port->port_ops;
 
 	return probe_ent;
 }
@@ -3477,7 +3641,7 @@
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
 	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(1, pci_dev_to_dev(pdev), port);
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
 
@@ -3503,39 +3667,47 @@
 	return probe_ent;
 }
 
-struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port)
+static struct ata_probe_ent *
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port,
+    struct ata_probe_ent **ppe2)
 {
-	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(2, pci_dev_to_dev(pdev), port);
+	struct ata_probe_ent *probe_ent, *probe_ent2;
+
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
+	probe_ent2 = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[1]);
+	if (!probe_ent2) {
+		kfree(probe_ent);
+		return NULL;
+	}
 
-	probe_ent[0].n_ports = 1;
-	probe_ent[0].irq = 14;
+	probe_ent->n_ports = 1;
+	probe_ent->irq = 14;
 
-	probe_ent[0].hard_port_no = 0;
-	probe_ent[0].legacy_mode = 1;
+	probe_ent->hard_port_no = 0;
+	probe_ent->legacy_mode = 1;
 
-	probe_ent[1].n_ports = 1;
-	probe_ent[1].irq = 15;
+	probe_ent2->n_ports = 1;
+	probe_ent2->irq = 15;
 
-	probe_ent[1].hard_port_no = 1;
-	probe_ent[1].legacy_mode = 1;
-
-	probe_ent[0].port[0].cmd_addr = 0x1f0;
-	probe_ent[0].port[0].altstatus_addr =
-	probe_ent[0].port[0].ctl_addr = 0x3f6;
-	probe_ent[0].port[0].bmdma_addr = pci_resource_start(pdev, 4);
-
-	probe_ent[1].port[0].cmd_addr = 0x170;
-	probe_ent[1].port[0].altstatus_addr =
-	probe_ent[1].port[0].ctl_addr = 0x376;
-	probe_ent[1].port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+	probe_ent2->hard_port_no = 1;
+	probe_ent2->legacy_mode = 1;
 
-	ata_std_ports(&probe_ent[0].port[0]);
-	ata_std_ports(&probe_ent[1].port[0]);
+	probe_ent->port[0].cmd_addr = 0x1f0;
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr = 0x3f6;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+
+	probe_ent2->port[0].cmd_addr = 0x170;
+	probe_ent2->port[0].altstatus_addr =
+	probe_ent2->port[0].ctl_addr = 0x376;
+	probe_ent2->port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+
+	ata_std_ports(&probe_ent->port[0]);
+	ata_std_ports(&probe_ent2->port[0]);
 
+	*ppe2 = probe_ent2;
 	return probe_ent;
 }
 
@@ -3559,6 +3731,7 @@
 	struct ata_port_info *port[2];
 	u8 tmp8, mask;
 	unsigned int legacy_mode = 0;
+	int disable_dev_on_err = 1;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -3569,7 +3742,8 @@
 	else
 		port[1] = port[0];
 
-	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0) {
+	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0
+	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		/* TODO: support transitioning to native mode? */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
@@ -3588,8 +3762,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		disable_dev_on_err = 0;
 		goto err_out;
+	}
 
 	if (legacy_mode) {
 		if (!request_region(0x1f0, 8, "libata")) {
@@ -3599,8 +3775,10 @@
 			conflict = ____request_resource(&ioport_resource, &res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 0);
-			else
+			else {
+				disable_dev_on_err = 0;
 				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
+			}
 		} else
 			legacy_mode |= (1 << 0);
 
@@ -3611,8 +3789,10 @@
 			conflict = ____request_resource(&ioport_resource, &res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 1);
-			else
+			else {
+				disable_dev_on_err = 0;
 				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
+			}
 		} else
 			legacy_mode |= (1 << 1);
 	}
@@ -3631,9 +3811,7 @@
 		goto err_out_regions;
 
 	if (legacy_mode) {
-		probe_ent = ata_pci_init_legacy_mode(pdev, port);
-		if (probe_ent)
-			probe_ent2 = &probe_ent[1];
+		probe_ent = ata_pci_init_legacy_mode(pdev, port, &probe_ent2);
 	} else
 		probe_ent = ata_pci_init_native_mode(pdev, port);
 	if (!probe_ent) {
@@ -3649,10 +3827,11 @@
 			ata_device_add(probe_ent);
 		if (legacy_mode & (1 << 1))
 			ata_device_add(probe_ent2);
-	} else {
+	} else
 		ata_device_add(probe_ent);
-	}
+
 	kfree(probe_ent);
+	kfree(probe_ent2);
 
 	return 0;
 
@@ -3663,7 +3842,8 @@
 		release_region(0x170, 8);
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (disable_dev_on_err)
+		pci_disable_device(pdev);
 	return rc;
 }
 
@@ -3813,6 +3993,8 @@
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_check_status);
+EXPORT_SYMBOL_GPL(ata_altstatus);
+EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
@@ -3821,6 +4003,8 @@
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
+EXPORT_SYMBOL_GPL(ata_bmdma_status);
+EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
@@ -3838,7 +4022,6 @@
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-03-01 23:38:56 -08:00
+++ b/drivers/scsi/libata-scsi.c	2005-03-01 23:38:56 -08:00
@@ -202,7 +202,7 @@
 		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
 		/* BBD - block marked bad */
 		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static unsigned char stat_table[][4] = {
 		/* Must be first because BUSY means no other bits valid */
@@ -210,22 +210,22 @@
 		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
 		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
 		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	int i = 0;
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
-	
+
 	/*
 	 *	Is this an error we can process/parse
 	 */
-	 
+
 	if(drv_stat & ATA_ERR)
 		/* Read the err bits */
 		err = ata_chk_err(qc->ap);
 
 	/* Display the ATA level error info */
-	
+
 	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
 	if(drv_stat & 0x80)
 	{
@@ -242,7 +242,7 @@
 		if(drv_stat & 0x01)	printk("Error ");
 	}
 	printk("}\n");
-	
+
 	if(err)
 	{
 		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
@@ -259,11 +259,11 @@
 		if(err & 0x02)		printk("TrackZeroNotFound ");
 		if(err & 0x01)		printk("AddrMarkNotFound ");
 		printk("}\n");
-		
+
 		/* Should we dump sector info here too ?? */
 	}
-		
-	
+
+
 	/* Look for err */
 	while(sense_table[i][0] != 0xFF)
 	{
@@ -282,7 +282,8 @@
 	/* No immediate match */
 	if(err)
 		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
-	
+
+	i = 0;
 	/* Fall back to interpreting status bits */
 	while(stat_table[i][0] != 0xFF)
 	{
@@ -300,7 +301,7 @@
 	/* No error ?? */
 	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
 	/* additional-sense-code[-qualifier] */
-	
+
 	sb[0] = 0x70;
 	sb[2] = MEDIUM_ERROR;
 	sb[7] = 0x0A;
@@ -487,19 +488,24 @@
 	}
 
 	if (lba48) {
+		tf->command = ATA_CMD_VERIFY_EXT;
+
 		tf->hob_nsect = (n_sect >> 8) & 0xff;
 
 		tf->hob_lbah = (sect >> 40) & 0xff;
 		tf->hob_lbam = (sect >> 32) & 0xff;
 		tf->hob_lbal = (sect >> 24) & 0xff;
-	} else
+	} else {
+		tf->command = ATA_CMD_VERIFY;
+
 		tf->device |= (sect >> 24) & 0xf;
+	}
 
 	tf->nsect = n_sect & 0xff;
 
-	tf->hob_lbah = (sect >> 16) & 0xff;
-	tf->hob_lbam = (sect >> 8) & 0xff;
-	tf->hob_lbal = sect & 0xff;
+	tf->lbah = (sect >> 16) & 0xff;
+	tf->lbam = (sect >> 8) & 0xff;
+	tf->lbal = sect & 0xff;
 
 	return 0;
 }
@@ -599,7 +605,7 @@
 				return 1;
 
 			/* stores LBA27:24 in lower 4 bits of device reg */
-			tf->device |= scsicmd[2];
+			tf->device |= scsicmd[6];
 
 			qc->nsect = scsicmd[13];
 		}
@@ -695,6 +701,7 @@
 	return;
 
 err_out:
+	ata_qc_free(qc);
 	ata_bad_cdb(cmd, done);
 	DPRINTK("EXIT - badcmd\n");
 }
@@ -1293,6 +1300,11 @@
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (cmd->sc_data_direction == SCSI_DATA_NONE);
+
+	if (!using_pio)
+		/* Check whether ATAPI DMA is safe */
+		if (ata_check_atapi_dma(qc))
+			using_pio = 1;
 
 	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
 
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2005-03-01 23:38:53 -08:00
+++ b/drivers/scsi/libata.h	2005-03-01 23:38:53 -08:00
@@ -37,7 +37,9 @@
 /* libata-core.c */
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
+extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
+extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-03-01 23:38:53 -08:00
+++ b/drivers/scsi/sata_nv.c	2005-03-01 23:38:53 -08:00
@@ -20,6 +20,10 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.06
+ *     - Added generic SATA support by using a pci_device_id that filters on
+ *       the IDE storage class code.
+ *
  *  0.03
  *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
  *       mmio_base, which is only set for the CK804/MCP04 case.
@@ -44,7 +48,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.5"
+#define DRV_VERSION			"0.6"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -108,6 +112,7 @@
 
 enum nv_host_type
 {
+	GENERIC,
 	NFORCE2,
 	NFORCE3,
 	CK804
@@ -128,6 +133,9 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
@@ -136,7 +144,6 @@
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
-	unsigned long		host_flags;
 	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
 	void			(*disable_hotplug)(struct ata_host_set *host_set);
 	void			(*check_hotplug)(struct ata_host_set *host_set);
@@ -144,21 +151,24 @@
 };
 static struct nv_host_desc nv_device_tbl[] = {
 	{
+		.host_type	= GENERIC,
+		.enable_hotplug	= NULL,
+		.disable_hotplug= NULL,
+		.check_hotplug	= NULL,
+	},
+	{
 		.host_type	= NFORCE2,
-		.host_flags	= 0x00000000,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
 	},
 	{
 		.host_type	= NFORCE3,
-		.host_flags	= 0x00000000,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
 	},
 	{	.host_type	= CK804,
-		.host_flags	= NV_HOST_FLAGS_SCR_MMIO,
 		.enable_hotplug	= nv_enable_hotplug_ck804,
 		.disable_hotplug= nv_disable_hotplug_ck804,
 		.check_hotplug	= nv_check_hotplug_ck804,
@@ -168,6 +178,7 @@
 struct nv_host
 {
 	struct nv_host_desc	*host_desc;
+	unsigned long		host_flags;
 };
 
 static struct pci_driver nv_pci_driver = {
@@ -206,6 +217,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -284,8 +297,8 @@
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		return readl((void*)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -298,8 +311,8 @@
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		writel(val, (void*)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -321,7 +334,16 @@
 	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	int pci_dev_busy = 0;
 	int rc;
+	u32 bar;
+
+        // Make sure this is a SATA controller by counting the number of bars
+        // (NVIDIA SATA controllers will always have six bars).  Otherwise,
+        // it's an IDE controller and we ignore it.
+	for (bar=0; bar<6; bar++)
+		if (pci_resource_start(pdev, bar) == 0)
+			return -ENODEV;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -331,8 +353,10 @@
 		goto err_out;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out_disable;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -352,11 +376,15 @@
 	if (!host)
 		goto err_out_free_ent;
 
+	memset(host, 0, sizeof(struct nv_host));
 	host->host_desc = &nv_device_tbl[ent->driver_data];
 
 	probe_ent->private_data = host;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+	if (pci_resource_flags(pdev, 5) & IORESOURCE_MEM)
+		host->host_flags |= NV_HOST_FLAGS_SCR_MMIO;
+
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
 		unsigned long base;
 
 		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
@@ -395,7 +423,7 @@
 	return 0;
 
 err_out_iounmap:
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
 		iounmap(probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
@@ -404,7 +432,8 @@
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
--- a/drivers/scsi/sata_promise.c	2005-03-01 23:39:08 -08:00
+++ b/drivers/scsi/sata_promise.c	2005-03-01 23:39:08 -08:00
@@ -156,10 +156,18 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
+
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
+
 	{ }	/* terminate list */
 };
 
@@ -406,9 +414,11 @@
 		return IRQ_NONE;
 	}
 
-        spin_lock(&host_set->lock);
+	spin_lock(&host_set->lock);
 
-        for (i = 0; i < host_set->n_ports; i++) {
+	writel(mask, mmio_base + PDC_INT_SEQMASK);
+
+	for (i = 0; i < host_set->n_ports; i++) {
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
@@ -546,6 +556,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -560,8 +571,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -640,7 +653,8 @@
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
+++ b/drivers/scsi/sata_qstor.c	2005-03-01 23:39:27 -08:00
@@ -0,0 +1,700 @@
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
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= QS_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	//FIXME .use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.use_clustering		= ENABLE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= QS_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
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
+		*(u64 *)prd = cpu_to_le64(addr);
+		prd += sizeof(u64);
+
+		len = sg_dma_len(sg);
+		*(u32 *)prd = cpu_to_le32(len);
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
+	*(u32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(u32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
+	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
+	*(u64 *)(&buf[16]) = cpu_to_le64(addr);
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
+	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
+		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+		if (rc) {
+			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			if (rc) {
+				printk(KERN_ERR DRV_NAME
+					"(%s): 64-bit DMA enable failed\n",
+					pci_name(pdev));
+				return rc;
+			}
+		}
+	} else {
+		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		if (rc) {
+			printk(KERN_ERR DRV_NAME
+				"(%s): 32-bit DMA enable failed\n",
+				pci_name(pdev));
+			return rc;
+		}
+		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		if (rc) {
+			printk(KERN_ERR DRV_NAME
+				"(%s): 32-bit consistent DMA enable failed\n",
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
+	rc = ata_device_add(probe_ent);
+	kfree(probe_ent);
+	if (rc != QS_PORTS)
+		goto err_out_iounmap;
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
+	return pci_module_init(&qs_ata_pci_driver);
+}
+
+static void __exit qs_ata_exit(void)
+{
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
--- a/drivers/scsi/sata_sil.c	2005-03-01 23:38:44 -08:00
+++ b/drivers/scsi/sata_sil.c	2005-03-01 23:38:44 -08:00
@@ -71,6 +71,8 @@
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
+	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 
@@ -84,10 +86,12 @@
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST380013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
@@ -135,6 +139,8 @@
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -332,6 +338,7 @@
 	void *mmio_base;
 	int rc;
 	unsigned int i;
+	int pci_dev_busy = 0;
 	u32 tmp, irq_mask;
 
 	if (!printed_version++)
@@ -346,8 +353,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -434,7 +443,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2005-03-01 23:38:57 -08:00
+++ b/drivers/scsi/sata_sis.c	2005-03-01 23:38:57 -08:00
@@ -102,6 +102,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -200,14 +202,17 @@
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
@@ -259,7 +264,8 @@
 	pci_release_regions(pdev);
 
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 
 }
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-03-01 23:38:59 -08:00
+++ b/drivers/scsi/sata_svw.c	2005-03-01 23:38:59 -08:00
@@ -301,6 +301,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -338,6 +340,7 @@
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
 	void *mmio_base;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -359,8 +362,10 @@
 
 	/* Request PCI regions */
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -433,7 +438,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2005-03-01 23:38:44 -08:00
+++ b/drivers/scsi/sata_sx4.c	2005-03-01 23:38:44 -08:00
@@ -1366,6 +1366,7 @@
 	void *mmio_base, *dimm_mmio = NULL;
 	struct pdc_host_priv *hpriv = NULL;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -1380,8 +1381,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -1471,7 +1474,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2005-03-01 23:39:09 -08:00
+++ b/drivers/scsi/sata_uli.c	2005-03-01 23:39:09 -08:00
@@ -32,16 +32,18 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_uli"
-#define DRV_VERSION	"0.2"
+#define DRV_VERSION	"0.5"
 
 enum {
 	uli_5289		= 0,
 	uli_5287		= 1,
+	uli_5281		= 2,
 
 	/* PCI configuration registers */
-	ULI_SCR_BASE		= 0x90, /* sata0 phy SCR registers */
-	ULI_SATA1_OFS		= 0x10, /* offset from sata0->sata1 phy regs */
-
+	ULI5287_BASE		= 0x90, /* sata0 phy SCR registers */
+	ULI5287_OFFS		= 0x10, /* offset from sata0->sata1 phy regs */
+	ULI5281_BASE		= 0x60, /* sata0 phy SCR  registers */
+	ULI5281_OFFS		= 0x60, /* offset from sata0->sata1 phy regs */
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -51,6 +53,7 @@
 static struct pci_device_id uli_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
 	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
+	{ PCI_VENDOR_ID_AL, 0x5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
 	{ }	/* terminate list */
 };
 
@@ -94,6 +97,8 @@
 
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -125,33 +130,15 @@
 MODULE_DEVICE_TABLE(pci, uli_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
+static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 {
-	unsigned int addr = ULI_SCR_BASE + (4 * sc_reg);
-
-	switch (port_no) {
-	case 0:
-		break;
-	case 1:
-		addr += ULI_SATA1_OFS;
-		break;
-	case 2:
-		addr += ULI_SATA1_OFS*4;
-		break;
-	case 3:
-		addr += ULI_SATA1_OFS*5;
-		break;
-	default:
-		BUG();
-		break;
-	}
-	return addr;
+	return ap->ioaddr.scr_addr + (4 * sc_reg);
 }
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
 	u32 val;
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
@@ -161,7 +148,7 @@
 static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, scr);
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 }
@@ -200,14 +187,17 @@
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
@@ -222,9 +212,11 @@
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-
+	
 	switch (board_idx) {
 	case uli_5287:
+		probe_ent->port[0].scr_addr = ULI5287_BASE;
+		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
        		probe_ent->n_ports = 4;
 
        		probe_ent->port[2].cmd_addr = pci_resource_start(pdev, 0) + 8;
@@ -232,19 +224,27 @@
 		probe_ent->port[2].ctl_addr =
 			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[2].bmdma_addr = pci_resource_start(pdev, 4) + 16;
+		probe_ent->port[2].scr_addr = ULI5287_BASE + ULI5287_OFFS*4;
 
 		probe_ent->port[3].cmd_addr = pci_resource_start(pdev, 2) + 8;
 		probe_ent->port[3].altstatus_addr =
 		probe_ent->port[3].ctl_addr =
 			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[3].bmdma_addr = pci_resource_start(pdev, 4) + 24;
+		probe_ent->port[3].scr_addr = ULI5287_BASE + ULI5287_OFFS*5;
 
 		ata_std_ports(&probe_ent->port[2]);
 		ata_std_ports(&probe_ent->port[3]);
 		break;
 
 	case uli_5289:
-		/* do nothing; ata_pci_init_native_mode did it all */
+		probe_ent->port[0].scr_addr = ULI5287_BASE;
+		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		break;
+
+	case uli_5281:
+		probe_ent->port[0].scr_addr = ULI5281_BASE;
+		probe_ent->port[1].scr_addr = ULI5281_BASE + ULI5281_OFFS;
 		break;
 
 	default:
@@ -265,7 +265,8 @@
 	pci_release_regions(pdev);
 
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 
 }
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2005-03-01 23:38:53 -08:00
+++ b/drivers/scsi/sata_via.c	2005-03-01 23:38:53 -08:00
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
@@ -110,6 +117,9 @@
 
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -158,18 +168,132 @@
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
@@ -180,20 +304,28 @@
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
@@ -209,8 +341,11 @@
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
@@ -218,42 +353,7 @@
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
 
@@ -266,7 +366,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-03-01 23:38:58 -08:00
+++ b/drivers/scsi/sata_vsc.c	2005-03-01 23:38:58 -08:00
@@ -217,6 +217,8 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -255,6 +257,7 @@
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
+	int pci_dev_busy = 0;
 	void *mmio_base;
 	int rc;
 
@@ -274,8 +277,10 @@
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
@@ -352,7 +357,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2005-03-01 23:38:59 -08:00
+++ b/include/linux/ata.h	2005-03-01 23:38:59 -08:00
@@ -123,6 +123,8 @@
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
+	ATA_CMD_VERIFY		= 0x40,
+	ATA_CMD_VERIFY_EXT	= 0x42,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2005-03-01 23:38:51 -08:00
+++ b/include/linux/libata.h	2005-03-01 23:38:51 -08:00
@@ -334,11 +334,15 @@
 
 	void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
 	u8   (*check_status)(struct ata_port *ap);
+	u8   (*check_altstatus)(struct ata_port *ap);
+	u8   (*check_err)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
 
+	int (*check_atapi_dma) (struct ata_queued_cmd *qc);
+
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 
@@ -358,6 +362,9 @@
 	void (*port_stop) (struct ata_port *ap);
 
 	void (*host_stop) (struct ata_host_set *host_set);
+
+	void (*bmdma_stop) (struct ata_port *ap);
+	u8   (*bmdma_status) (struct ata_port *ap);
 };
 
 struct ata_port_info {
@@ -398,6 +405,8 @@
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
+extern u8 ata_altstatus(struct ata_port *ap);
+extern u8 ata_chk_err(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
@@ -413,6 +422,8 @@
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
+extern void ata_bmdma_stop(struct ata_port *ap);
+extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
@@ -434,8 +445,6 @@
 
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
-extern struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 
 #endif /* CONFIG_PCI */
@@ -452,26 +461,11 @@
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
@@ -593,46 +587,6 @@
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

--------------020306020704090906090005--
