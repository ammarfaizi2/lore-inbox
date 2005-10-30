Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVJ3TpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVJ3TpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJ3TpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:45:20 -0500
Received: from havoc.gtf.org ([69.61.125.42]:7058 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932251AbVJ3TpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:45:18 -0500
Date: Sun, 30 Oct 2005 14:45:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata update
Message-ID: <20051030194512.GA21782@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive today's fixes and updates, including a fix for
"I've lost sdb" problem reported on lkml against -mm.

 drivers/scsi/ahci.c         |   55 ++++++++++++------------------
 drivers/scsi/ata_piix.c     |   15 ++++----
 drivers/scsi/libata-core.c  |   80 +++++++++++++++-----------------------------
 drivers/scsi/libata-scsi.c  |   46 +++++++++++++++----------
 drivers/scsi/libata.h       |    2 -
 drivers/scsi/pdc_adma.c     |   26 +++++++-------
 drivers/scsi/sata_mv.c      |   41 ++++++----------------
 drivers/scsi/sata_nv.c      |    3 +
 drivers/scsi/sata_promise.c |   19 ++++------
 drivers/scsi/sata_qstor.c   |   25 ++++++-------
 drivers/scsi/sata_sil.c     |    7 ++-
 drivers/scsi/sata_sil24.c   |   41 +++++++++-------------
 drivers/scsi/sata_sis.c     |   13 +++++--
 drivers/scsi/sata_svw.c     |    3 +
 drivers/scsi/sata_sx4.c     |   13 +++----
 drivers/scsi/sata_uli.c     |    5 ++
 drivers/scsi/sata_via.c     |   38 +++++++++++---------
 drivers/scsi/sata_vsc.c     |    3 +
 include/linux/libata.h      |   30 ++++++++++++++--
 19 files changed, 232 insertions(+), 233 deletions(-)

Jeff Garzik:
      [libata] remove ata_chk_err(), ->check_err() hook.
      [libata] change ata_qc_complete() to take error mask as second arg
      [libata] fix legacy IDE probing
      [libata ata_piix] use dev_printk() where appropriate
      [libata ata_piix] fix native mode probe, after recent updates
      [libata] use dev_printk() throughout drivers

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index fe8187d..e2a5657 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -192,7 +193,6 @@ static void ahci_port_stop(struct ata_po
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
-static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 static void ahci_remove_one (struct pci_dev *pdev);
 
@@ -221,7 +221,6 @@ static const struct ata_port_operations 
 
 	.check_status		= ahci_check_status,
 	.check_altstatus	= ahci_check_status,
-	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
 	.tf_read		= ahci_tf_read,
@@ -458,13 +457,6 @@ static u8 ahci_check_status(struct ata_p
 	return readl(mmio + PORT_TFDATA) & 0xFF;
 }
 
-static u8 ahci_check_err(struct ata_port *ap)
-{
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-
-	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
-}
-
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -609,7 +601,7 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
+		ata_qc_complete(qc, AC_ERR_OTHER);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -638,7 +630,7 @@ static inline int ahci_host_intr(struct 
 	if (status & PORT_IRQ_FATAL) {
 		ahci_intr_error(ap, status);
 		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
+			ata_qc_complete(qc, AC_ERR_OTHER);
 	}
 
 	return 1;
@@ -683,10 +675,10 @@ static irqreturn_t ahci_interrupt (int i
 			if (!ahci_host_intr(ap, qc))
 				if (ata_ratelimit()) {
 					struct pci_dev *pdev =
-					  to_pci_dev(ap->host_set->dev);
-					printk(KERN_WARNING
-					  "ahci(%s): unhandled interrupt on port %u\n",
-					  pci_name(pdev), i);
+						to_pci_dev(ap->host_set->dev);
+					dev_printk(KERN_WARNING, &pdev->dev,
+					  "unhandled interrupt on port %u\n",
+					  i);
 				}
 
 			VPRINTK("port %u\n", i);
@@ -694,10 +686,9 @@ static irqreturn_t ahci_interrupt (int i
 			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit()) {
 				struct pci_dev *pdev =
-				  to_pci_dev(ap->host_set->dev);
-				printk(KERN_WARNING
-				  "ahci(%s): interrupt on disabled port %u\n",
-				  pci_name(pdev), i);
+					to_pci_dev(ap->host_set->dev);
+				dev_printk(KERN_WARNING, &pdev->dev,
+					"interrupt on disabled port %u\n", i);
 			}
 		}
 
@@ -769,8 +760,8 @@ static int ahci_host_init(struct ata_pro
 
 	tmp = readl(mmio + HOST_CTL);
 	if (tmp & HOST_RESET) {
-		printk(KERN_ERR DRV_NAME "(%s): controller reset failed (0x%x)\n",
-			pci_name(pdev), tmp);
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "controller reset failed (0x%x)\n", tmp);
 		return -EIO;
 	}
 
@@ -798,22 +789,22 @@ static int ahci_host_init(struct ata_pro
 		if (rc) {
 			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
-				printk(KERN_ERR DRV_NAME "(%s): 64-bit DMA enable failed\n",
-					pci_name(pdev));
+				dev_printk(KERN_ERR, &pdev->dev,
+					   "64-bit DMA enable failed\n");
 				return rc;
 			}
 		}
 	} else {
 		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
-				pci_name(pdev));
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "32-bit DMA enable failed\n");
 			return rc;
 		}
 		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): 32-bit consistent DMA enable failed\n",
-				pci_name(pdev));
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "32-bit consistent DMA enable failed\n");
 			return rc;
 		}
 	}
@@ -916,10 +907,10 @@ static void ahci_print_info(struct ata_p
 	else
 		scc_s = "unknown";
 
-	printk(KERN_INFO DRV_NAME "(%s) AHCI %02x%02x.%02x%02x "
+	dev_printk(KERN_INFO, &pdev->dev,
+		"AHCI %02x%02x.%02x%02x "
 		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
 	       	,
-	       	pci_name(pdev),
 
 	       	(vers >> 24) & 0xff,
 	       	(vers >> 16) & 0xff,
@@ -932,11 +923,11 @@ static void ahci_print_info(struct ata_p
 		impl,
 		scc_s);
 
-	printk(KERN_INFO DRV_NAME "(%s) flags: "
+	dev_printk(KERN_INFO, &pdev->dev,
+		"flags: "
 	       	"%s%s%s%s%s%s"
 	       	"%s%s%s%s%s%s%s\n"
 	       	,
-	       	pci_name(pdev),
 
 		cap & (1 << 31) ? "64bit " : "",
 		cap & (1 << 30) ? "ncq " : "",
@@ -969,7 +960,7 @@ static int ahci_init_one (struct pci_dev
 	VPRINTK("ENTER\n");
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index be02147..7f8aa1b 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -45,6 +45,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -621,18 +622,19 @@ static int piix_init_one (struct pci_dev
 {
 	static int printed_version;
 	struct ata_port_info *port_info[2];
-	unsigned int combined = 0, n_ports = 1;
+	unsigned int combined = 0;
 	unsigned int pata_chan = 0, sata_chan = 0;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "version " DRV_VERSION "\n");
 
 	/* no hotplugging support (FIXME) */
 	if (!in_module_init)
 		return -ENODEV;
 
 	port_info[0] = &piix_port_info[ent->driver_data];
-	port_info[1] = NULL;
+	port_info[1] = &piix_port_info[ent->driver_data];
 
 	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
@@ -670,12 +672,13 @@ static int piix_init_one (struct pci_dev
 		port_info[sata_chan] = &piix_port_info[ent->driver_data];
 		port_info[sata_chan]->host_flags |= ATA_FLAG_SLAVE_POSS;
 		port_info[pata_chan] = &piix_port_info[ich5_pata];
-		n_ports++;
 
-		printk(KERN_WARNING DRV_NAME ": combined mode detected\n");
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "combined mode detected (p=%u, s=%u)\n",
+			   pata_chan, sata_chan);
 	}
 
-	return ata_pci_init_one(pdev, port_info, n_ports);
+	return ata_pci_init_one(pdev, port_info, 2);
 }
 
 static int __init piix_init(void)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5ca9760..8be7dc0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -372,7 +372,7 @@ static void ata_tf_read_pio(struct ata_p
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	tf->command = ata_check_status(ap);
-	tf->feature = ata_chk_err(ap);
+	tf->feature = inb(ioaddr->error_addr);
 	tf->nsect = inb(ioaddr->nsect_addr);
 	tf->lbal = inb(ioaddr->lbal_addr);
 	tf->lbam = inb(ioaddr->lbam_addr);
@@ -406,7 +406,7 @@ static void ata_tf_read_mmio(struct ata_
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	tf->command = ata_check_status(ap);
-	tf->feature = ata_chk_err(ap);
+	tf->feature = readb((void __iomem *)ioaddr->error_addr);
 	tf->nsect = readb((void __iomem *)ioaddr->nsect_addr);
 	tf->lbal = readb((void __iomem *)ioaddr->lbal_addr);
 	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
@@ -527,30 +527,6 @@ u8 ata_altstatus(struct ata_port *ap)
 
 
 /**
- *	ata_chk_err - Read device error reg
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile error register for
- *	currently-selected device and return its value.
- *
- *	Note: may NOT be used as the check_err() entry in
- *	ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-u8 ata_chk_err(struct ata_port *ap)
-{
-	if (ap->ops->check_err)
-		return ap->ops->check_err(ap);
-
-	if (ap->flags & ATA_FLAG_MMIO) {
-		return readb((void __iomem *) ap->ioaddr.error_addr);
-	}
-	return inb(ap->ioaddr.error_addr);
-}
-
-/**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
  *	@fis: Buffer into which data will output
@@ -902,8 +878,8 @@ static u8 ata_dev_try_classify(struct at
 
 	memset(&tf, 0, sizeof(tf));
 
-	err = ata_chk_err(ap);
 	ap->ops->tf_read(ap, &tf);
+	err = tf.feature;
 
 	dev->class = ATA_DEV_NONE;
 
@@ -1140,7 +1116,6 @@ static void ata_dev_identify(struct ata_
 	unsigned int major_version;
 	u16 tmp;
 	unsigned long xfer_modes;
-	u8 status;
 	unsigned int using_edd;
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
@@ -1194,8 +1169,11 @@ retry:
 	else
 		wait_for_completion(&wait);
 
-	status = ata_chk_status(ap);
-	if (status & ATA_ERR) {
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->ops->tf_read(ap, &qc->tf);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (qc->tf.command & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1208,7 +1186,7 @@ retry:
 		 * to have this problem.
 		 */
 		if ((using_edd) && (qc->tf.command == ATA_CMD_ID_ATA)) {
-			u8 err = ata_chk_err(ap);
+			u8 err = qc->tf.feature;
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
 				qc->cursg = 0;
@@ -2685,7 +2663,7 @@ static int ata_sg_setup(struct ata_queue
  *	None.  (grabs host lock)
  */
 
-void ata_poll_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_poll_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
@@ -2693,7 +2671,7 @@ void ata_poll_qc_complete(struct ata_que
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
-	ata_qc_complete(qc, drv_stat);
+	ata_qc_complete(qc, err_mask);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
@@ -2790,7 +2768,7 @@ static int ata_pio_complete (struct ata_
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, drv_stat);
+	ata_poll_qc_complete(qc, 0);
 
 	/* another command may start at this point */
 
@@ -3158,18 +3136,15 @@ static void ata_pio_block(struct ata_por
 static void ata_pio_error(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	u8 drv_stat;
+
+	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	drv_stat = ata_chk_status(ap);
-	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
-
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);
 }
 
 static void ata_pio_task(void *_data)
@@ -3292,7 +3267,7 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, drv_stat);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 	}
 
@@ -3397,7 +3372,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	return 0;
 }
@@ -3456,7 +3431,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	int rc;
 
@@ -3473,7 +3448,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, drv_stat);
+	rc = qc->complete_fn(qc, err_mask);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3911,7 +3886,7 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, status);
+		ata_qc_complete(qc, ac_err_mask(status));
 		break;
 
 	default:
@@ -4006,7 +3981,7 @@ static void atapi_packet_task(void *_dat
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
-		goto err_out;
+		goto err_out_status;
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
@@ -4043,8 +4018,10 @@ static void atapi_packet_task(void *_dat
 
 	return;
 
+err_out_status:
+	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, ATA_ERR);
+	ata_poll_qc_complete(qc, __ac_err_mask(status));
 }
 
 
@@ -4550,11 +4527,11 @@ ata_pci_init_native_mode(struct pci_dev 
 	return probe_ent;
 }
 
-static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev, struct ata_port_info **port, int port_num)
+static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev, struct ata_port_info *port, int port_num)
 {
 	struct ata_probe_ent *probe_ent;
 
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;
 
@@ -4701,9 +4678,9 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	if (legacy_mode) {
 		if (legacy_mode & (1 << 0))
-			probe_ent = ata_pci_init_legacy_port(pdev, port, 0);
+			probe_ent = ata_pci_init_legacy_port(pdev, port[0], 0);
 		if (legacy_mode & (1 << 1))
-			probe_ent2 = ata_pci_init_legacy_port(pdev, port, 1);
+			probe_ent2 = ata_pci_init_legacy_port(pdev, port[1], 1);
 	} else {
 		if (n_ports == 2)
 			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
@@ -4867,7 +4844,6 @@ EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
-EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 89a04b1..1e3792f 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -560,7 +560,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
@@ -635,7 +635,7 @@ void ata_gen_fixed_sense(struct ata_queu
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[2], &sb[12], &sb[13]);
 		sb[2] &= 0x0f;
@@ -644,7 +644,11 @@ void ata_gen_fixed_sense(struct ata_queu
 	sb[0] = 0x70;
 	sb[7] = 0x0a;
 
-	if (tf->flags & ATA_TFLAG_LBA && !(tf->flags & ATA_TFLAG_LBA48)) {
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		/* TODO: find solution for LBA48 descriptors */
+	}
+
+	else if (tf->flags & ATA_TFLAG_LBA) {
 		/* A small (28b) LBA will fit in the 32b info field */
 		sb[0] |= 0x80;		/* set valid bit */
 		sb[3] = tf->device & 0x0f;
@@ -652,6 +656,10 @@ void ata_gen_fixed_sense(struct ata_queu
 		sb[5] = tf->lbam;
 		sb[6] = tf->lbal;
 	}
+
+	else {
+		/* TODO: C/H/S */
+	}
 }
 
 /**
@@ -1199,10 +1207,12 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc,
+				unsigned int err_mask)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
- 	int need_sense = drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ);
+	u8 *cdb = cmd->cmnd;
+ 	int need_sense = (err_mask != 0);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1211,8 +1221,8 @@ static int ata_scsi_qc_complete(struct a
 	 * whether the command completed successfully or not. If there
 	 * was no error, SK, ASC and ASCQ will all be zero.
 	 */
-	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
- 	    ((cmd->cmnd[2] & 0x20) || need_sense)) {
+	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
+ 	    ((cdb[2] & 0x20) || need_sense)) {
  		ata_gen_ata_desc_sense(qc);
 	} else {
 		if (!need_sense) {
@@ -1995,21 +2005,13 @@ void atapi_request_sense(struct ata_port
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	VPRINTK("ENTER, drv_stat == 0x%x\n", drv_stat);
-
-	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
-		/* FIXME: not quite right; we don't want the
-		 * translation of taskfile registers into
-		 * a sense descriptors, since that's only
-		 * correct for ATA, not ATAPI
-		 */
-		ata_gen_ata_desc_sense(qc);
+	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
-	else if (unlikely(drv_stat & ATA_ERR)) {
+	if (unlikely(err_mask & AC_ERR_DEV)) {
 		DPRINTK("request check condition\n");
 
 		/* FIXME: command completion with check condition
@@ -2026,6 +2028,14 @@ static int atapi_qc_complete(struct ata_
 		return 1;
 	}
 
+	else if (unlikely(err_mask))
+		/* FIXME: not quite right; we don't want the
+		 * translation of taskfile registers into
+		 * a sense descriptors, since that's only
+		 * correct for ATA, not ATAPI
+		 */
+		ata_gen_ata_desc_sense(qc);
+
 	else {
 		u8 *scsicmd = cmd->cmnd;
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 65c264b..10ecd9e 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,7 +39,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
+extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index af99feb..665017e 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <asm/io.h>
@@ -451,7 +452,7 @@ static inline unsigned int adma_intr_pkt
 		struct adma_port_priv *pp;
 		struct ata_queued_cmd *qc;
 		void __iomem *chan = ADMA_REGS(mmio_base, port_no);
-		u8 drv_stat = 0, status = readb(chan + ADMA_STATUS);
+		u8 status = readb(chan + ADMA_STATUS);
 
 		if (status == 0)
 			continue;
@@ -464,11 +465,14 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			unsigned int err_mask = 0;
+
 			if ((status & (aPERR | aPSD | aUIRQ)))
-				drv_stat = ATA_ERR;
+				err_mask = AC_ERR_OTHER;
 			else if (pp->pkt[0] != cDONE)
-				drv_stat = ATA_ERR;
-			ata_qc_complete(qc, drv_stat);
+				err_mask = AC_ERR_OTHER;
+
+			ata_qc_complete(qc, err_mask);
 		}
 	}
 	return handled;
@@ -498,7 +502,7 @@ static inline unsigned int adma_intr_mmi
 		
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
-				ata_qc_complete(qc, status);
+				ata_qc_complete(qc, ac_err_mask(status));
 				handled = 1;
 			}
 		}
@@ -623,16 +627,14 @@ static int adma_set_dma_masks(struct pci
 
 	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc) {
-		printk(KERN_ERR DRV_NAME
-			"(%s): 32-bit DMA enable failed\n",
-			pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev,
+			"32-bit DMA enable failed\n");
 		return rc;
 	}
 	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc) {
-		printk(KERN_ERR DRV_NAME
-			"(%s): 32-bit consistent DMA enable failed\n",
-			pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev,
+			"32-bit consistent DMA enable failed\n");
 		return rc;
 	}
 	return 0;
@@ -648,7 +650,7 @@ static int adma_ata_init_one(struct pci_
 	int rc, port_no;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 422e0b6..46dbdee 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -258,7 +259,6 @@ struct mv_host_priv {
 static void mv_irq_clear(struct ata_port *ap);
 static u32 mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in);
 static void mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
-static u8 mv_check_err(struct ata_port *ap);
 static void mv_phy_reset(struct ata_port *ap);
 static void mv_host_stop(struct ata_host_set *host_set);
 static int mv_port_start(struct ata_port *ap);
@@ -296,7 +296,6 @@ static const struct ata_port_operations 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
-	.check_err		= mv_check_err,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
@@ -1067,6 +1066,7 @@ static void mv_host_intr(struct ata_host
 	struct ata_queued_cmd *qc;
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
+	unsigned int err_mask;
 	u8 ata_status = 0;
 
 	if (hc == 0) {
@@ -1102,15 +1102,15 @@ static void mv_host_intr(struct ata_host
 			handled++;
 		}
 
+		err_mask = ac_err_mask(ata_status);
+
 		shift = port << 1;		/* (port * 2) */
 		if (port >= MV_PORTS_PER_HC) {
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 		}
 		if ((PORT0_ERR << shift) & relevant) {
 			mv_err_intr(ap);
-			/* OR in ATA_ERR to ensure libata knows we took one */
-			ata_status = readb((void __iomem *)
-					   ap->ioaddr.status_addr) | ATA_ERR;
+			err_mask |= AC_ERR_OTHER;
 			handled++;
 		}
 		
@@ -1120,7 +1120,7 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				ata_qc_complete(qc, ata_status);
+				ata_qc_complete(qc, err_mask);
 			}
 		}
 	}
@@ -1185,22 +1185,6 @@ static irqreturn_t mv_interrupt(int irq,
 }
 
 /**
- *      mv_check_err - Return the error shadow register to caller.
- *      @ap: ATA channel to manipulate
- *
- *      Marvell requires DMA to be stopped before accessing shadow
- *      registers.  So we do that, then return the needed register.
- *
- *      LOCKING:
- *      Inherited from caller.  FIXME: protect mv_stop_dma with lock?
- */
-static u8 mv_check_err(struct ata_port *ap)
-{
-	mv_stop_dma(ap);		/* can't read shadow regs if DMA on */
-	return readb((void __iomem *) ap->ioaddr.error_addr);
-}
-
-/**
  *      mv_phy_reset - Perform eDMA reset followed by COMRESET
  *      @ap: ATA channel to manipulate
  *
@@ -1312,7 +1296,7 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
+		ata_qc_complete(qc, AC_ERR_OTHER);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 }
@@ -1454,9 +1438,9 @@ static void mv_print_info(struct ata_pro
 	else
 		scc_s = "unknown";
 
-	printk(KERN_INFO DRV_NAME 
-	       "(%s) %u slots %u ports %s mode IRQ via %s\n",
-	       pci_name(pdev), (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports, 
+	dev_printk(KERN_INFO, &pdev->dev,
+	       "%u slots %u ports %s mode IRQ via %s\n",
+	       (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports, 
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }
 
@@ -1477,9 +1461,8 @@ static int mv_init_one(struct pci_dev *p
 	void __iomem *mmio_base;
 	int pci_dev_busy = 0, rc;
 
-	if (!printed_version++) {
-		printk(KERN_INFO DRV_NAME " version " DRV_VERSION "\n");
-	}
+	if (!printed_version++)
+		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc) {
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 1a56d6c..d573888 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -61,6 +61,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -383,7 +384,7 @@ static int nv_init_one (struct pci_dev *
 			return -ENODEV;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 63911f1..b41c977 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -399,7 +400,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
+		drv_stat = ata_wait_idle(ap);
+		ata_qc_complete(qc, __ac_err_mask(drv_stat));
 		break;
 
 	default:
@@ -408,7 +410,7 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 	}
 
@@ -420,24 +422,21 @@ out:
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc)
 {
-	u8 status;
-	unsigned int handled = 0, have_err = 0;
+	unsigned int handled = 0, err_mask = 0;
 	u32 tmp;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
-		have_err = 1;
+		err_mask = AC_ERR_DEV;
 		pdc_reset_port(ap);
 	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		status = ata_wait_idle(ap);
-		if (have_err)
-			status |= ATA_ERR;
-		ata_qc_complete(qc, status);
+		err_mask |= ac_err_mask(ata_wait_idle(ap));
+		ata_qc_complete(qc, err_mask);
 		handled = 1;
 		break;
 
@@ -635,7 +634,7 @@ static int pdc_ata_init_one (struct pci_
 	int rc;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 1aaf330..9938dae 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -35,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <asm/io.h>
@@ -400,11 +401,12 @@ static inline unsigned int qs_intr_pkt(s
 				qc = ata_qc_from_tag(ap, ap->active_tag);
 				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					switch (sHST) {
-					case 0: /* sucessful CPB */
+					case 0: /* successful CPB */
 					case 3: /* device error */
 						pp->state = qs_state_idle;
 						qs_enter_reg_mode(qc->ap);
-						ata_qc_complete(qc, sDST);
+						ata_qc_complete(qc,
+							ac_err_mask(sDST));
 						break;
 					default:
 						break;
@@ -441,7 +443,7 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, status);
+				ata_qc_complete(qc, ac_err_mask(status));
 				handled = 1;
 			}
 		}
@@ -599,25 +601,22 @@ static int qs_set_dma_masks(struct pci_d
 		if (rc) {
 			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
-				printk(KERN_ERR DRV_NAME
-					"(%s): 64-bit DMA enable failed\n",
-					pci_name(pdev));
+				dev_printk(KERN_ERR, &pdev->dev,
+					   "64-bit DMA enable failed\n");
 				return rc;
 			}
 		}
 	} else {
 		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
-			printk(KERN_ERR DRV_NAME
-				"(%s): 32-bit DMA enable failed\n",
-				pci_name(pdev));
+			dev_printk(KERN_ERR, &pdev->dev,
+				"32-bit DMA enable failed\n");
 			return rc;
 		}
 		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
-			printk(KERN_ERR DRV_NAME
-				"(%s): 32-bit consistent DMA enable failed\n",
-				pci_name(pdev));
+			dev_printk(KERN_ERR, &pdev->dev,
+				"32-bit consistent DMA enable failed\n");
 			return rc;
 		}
 	}
@@ -634,7 +633,7 @@ static int qs_ata_init_one(struct pci_de
 	int rc, port_no;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 3a05617..435f7e0 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -41,6 +41,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -386,7 +387,7 @@ static int sil_init_one (struct pci_dev 
 	u8 cls;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
@@ -463,8 +464,8 @@ static int sil_init_one (struct pci_dev 
 			writeb(cls, mmio_base + SIL_FIFO_W3);
 		}
 	} else
-		printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
-			pci_name(pdev));
+		dev_printk(KERN_WARNING, &pdev->dev,
+			 "cache line size not set.  Driver may not function\n");
 
 	if (ent->driver_data == sil_3114) {
 		irq_mask = SIL_MASK_4PORT;
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 51855d3..c665480 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -35,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include "scsi.h"
 #include <linux/libata.h>
@@ -225,7 +226,6 @@ struct sil24_host_priv {
 };
 
 static u8 sil24_check_status(struct ata_port *ap);
-static u8 sil24_check_err(struct ata_port *ap);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
@@ -280,7 +280,6 @@ static const struct ata_port_operations 
 
 	.check_status		= sil24_check_status,
 	.check_altstatus	= sil24_check_status,
-	.check_err		= sil24_check_err,
 	.dev_select		= ata_noop_dev_select,
 
 	.tf_read		= sil24_tf_read,
@@ -363,12 +362,6 @@ static u8 sil24_check_status(struct ata_
 	return pp->tf.command;
 }
 
-static u8 sil24_check_err(struct ata_port *ap)
-{
-	struct sil24_port_priv *pp = ap->private_data;
-	return pp->tf.feature;
-}
-
 static int sil24_scr_map[] = {
 	[SCR_CONTROL]	= 0,
 	[SCR_STATUS]	= 1,
@@ -506,7 +499,7 @@ static void sil24_eng_timeout(struct ata
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: tiemout without command\n",
+		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 		return;
 	}
@@ -520,7 +513,7 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, ATA_ERR);
+	ata_qc_complete(qc, AC_ERR_OTHER);
 
 	sil24_reset_controller(ap);
 }
@@ -531,6 +524,7 @@ static void sil24_error_intr(struct ata_
 	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
+	unsigned int err_mask;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
 	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
@@ -558,17 +552,18 @@ static void sil24_error_intr(struct ata_
 		 * Device is reporting error, tf registers are valid.
 		 */
 		sil24_update_tf(ap);
+		err_mask = ac_err_mask(pp->tf.command);
 	} else {
 		/*
 		 * Other errors.  libata currently doesn't have any
 		 * mechanism to report these errors.  Just turn on
 		 * ATA_ERR.
 		 */
-		pp->tf.command = ATA_ERR;
+		err_mask = AC_ERR_OTHER;
 	}
 
 	if (qc)
-		ata_qc_complete(qc, pp->tf.command);
+		ata_qc_complete(qc, err_mask);
 
 	sil24_reset_controller(ap);
 }
@@ -593,7 +588,7 @@ static inline void sil24_host_intr(struc
 		sil24_update_tf(ap);
 
 		if (qc)
-			ata_qc_complete(qc, pp->tf.command);
+			ata_qc_complete(qc, ac_err_mask(pp->tf.command));
 	} else
 		sil24_error_intr(ap, slot_stat);
 }
@@ -696,7 +691,7 @@ static int sil24_init_one(struct pci_dev
 	int i, rc;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -756,14 +751,14 @@ static int sil24_init_one(struct pci_dev
 	 */
 	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
-		       pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "32-bit DMA enable failed\n");
 		goto out_free;
 	}
 	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): 32-bit consistent DMA enable failed\n",
-		       pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "32-bit consistent DMA enable failed\n");
 		goto out_free;
 	}
 
@@ -799,9 +794,8 @@ static int sil24_init_one(struct pci_dev
 					break;
 			}
 			if (tmp & PORT_CS_PORT_RST)
-				printk(KERN_ERR DRV_NAME
-				       "(%s): failed to clear port RST\n",
-				       pci_name(pdev));
+				dev_printk(KERN_ERR, &pdev->dev,
+				           "failed to clear port RST\n");
 		}
 
 		/* Zero error counters. */
@@ -830,9 +824,8 @@ static int sil24_init_one(struct pci_dev
 
 		/* Reset itself */
 		if (__sil24_reset_controller(port))
-			printk(KERN_ERR DRV_NAME
-			       "(%s): failed to reset controller\n",
-			       pci_name(pdev));
+			dev_printk(KERN_ERR, &pdev->dev,
+			           "failed to reset controller\n");
 	}
 
 	/* Turn on interrupts */
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 057f7b9..42288be 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -38,6 +38,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -237,6 +238,7 @@ static void sis_scr_write (struct ata_po
 
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
@@ -245,6 +247,9 @@ static int sis_init_one (struct pci_dev 
 	u8 pmr;
 	u8 port2_start;
 
+	if (!printed_version++)
+		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
+
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -288,16 +293,18 @@ static int sis_init_one (struct pci_dev 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 	if (ent->device != 0x182) {
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
-			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in SATA mode\n");
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Detected SiS 180/181 chipset in SATA mode\n");
 			port2_start = 64;
 		}
 		else {
-			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in combined mode\n");
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Detected SiS 180/181 chipset in combined mode\n");
 			port2_start=0;
 		}
 	}
 	else {
-		printk(KERN_INFO "sata_sis: Detected SiS 182 chipset\n");
+		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182 chipset\n");
 		port2_start = 0x20;
 	}
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 46208f5..db615ff 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -44,6 +44,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -362,7 +363,7 @@ static int k2_sata_init_one (struct pci_
 	int i;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index af08f4f..0ec21e0 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -718,7 +719,7 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ata_wait_idle(ap));
+			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -756,7 +757,7 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ata_wait_idle(ap));
+			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -766,7 +767,7 @@ static inline unsigned int pdc20621_host
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		ata_qc_complete(qc, ac_err_mask(status));
 		handled = 1;
 
 	} else {
@@ -881,7 +882,7 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
+		ata_qc_complete(qc, __ac_err_mask(ata_wait_idle(ap)));
 		break;
 
 	default:
@@ -890,7 +891,7 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat);
+		ata_qc_complete(qc, ac_err_mask(drv_stat));
 		break;
 	}
 
@@ -1385,7 +1386,7 @@ static int pdc_sata_init_one (struct pci
 	int rc;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index d68dc7d..a5e245c 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -32,6 +32,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -178,12 +179,16 @@ static void uli_scr_write (struct ata_po
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	static int printed_version;
 	struct ata_probe_ent *probe_ent;
 	struct ata_port_info *ppi;
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
 
+	if (!printed_version++)
+		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
+
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 80e291a..b3ecdbe 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -259,15 +260,15 @@ static void svia_configure(struct pci_de
 	u8 tmp8;
 
 	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
-	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
-	       pci_name(pdev),
+	dev_printk(KERN_INFO, &pdev->dev, "routed to hard irq line %d\n",
 	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
 
 	/* make sure SATA channels are enabled */
 	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
 	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "enabling SATA channels (0x%x)\n",
+		           (int) tmp8);
 		tmp8 |= ALL_PORTS;
 		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
 	}
@@ -275,8 +276,9 @@ static void svia_configure(struct pci_de
 	/* make sure interrupts for each channel sent to us */
 	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
 	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "enabling SATA channel interrupts (0x%x)\n",
+		           (int) tmp8);
 		tmp8 |= ALL_PORTS;
 		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
 	}
@@ -284,8 +286,9 @@ static void svia_configure(struct pci_de
 	/* make sure native mode is enabled */
 	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
 	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel native mode (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "enabling SATA channel native mode (0x%x)\n",
+		           (int) tmp8);
 		tmp8 |= NATIVE_MODE_ALL;
 		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
 	}
@@ -303,7 +306,7 @@ static int svia_init_one (struct pci_dev
 	u8 tmp8;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -318,8 +321,9 @@ static int svia_init_one (struct pci_dev
 	if (board_id == vt6420) {
 		pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
 		if (tmp8 & SATA_2DEV) {
-			printk(KERN_ERR DRV_NAME "(%s): SATA master/slave not supported (0x%x)\n",
-		       	pci_name(pdev), (int) tmp8);
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "SATA master/slave not supported (0x%x)\n",
+		       		   (int) tmp8);
 			rc = -EIO;
 			goto err_out_regions;
 		}
@@ -332,10 +336,11 @@ static int svia_init_one (struct pci_dev
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||
 		    (pci_resource_len(pdev, i) < bar_sizes[i])) {
-			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
-			       pci_name(pdev), i,
-			       pci_resource_start(pdev, i),
-			       pci_resource_len(pdev, i));
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
+				   i,
+			           pci_resource_start(pdev, i),
+			           pci_resource_len(pdev, i));
 			rc = -ENODEV;
 			goto err_out_regions;
 		}
@@ -353,8 +358,7 @@ static int svia_init_one (struct pci_dev
 		probe_ent = vt6421_init_probe_ent(pdev);
 
 	if (!probe_ent) {
-		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
-		       pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev, "out of memory\n");
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 54273e0..bb84ba0 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -295,7 +296,7 @@ static int __devinit vsc_sata_init_one (
 	int rc;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 00a8a57..0ba3af7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,13 @@ enum hsm_task_states {
 	HSM_ST_ERR,
 };
 
+enum ata_completion_errors {
+	AC_ERR_OTHER		= (1 << 0),
+	AC_ERR_DEV		= (1 << 1),
+	AC_ERR_ATA_BUS		= (1 << 2),
+	AC_ERR_HOST_BUS		= (1 << 3),
+};
+
 /* forward declarations */
 struct scsi_device;
 struct ata_port_operations;
@@ -179,7 +186,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int err_mask);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -347,7 +354,6 @@ struct ata_port_operations {
 	void (*exec_command)(struct ata_port *ap, const struct ata_taskfile *tf);
 	u8   (*check_status)(struct ata_port *ap);
 	u8   (*check_altstatus)(struct ata_port *ap);
-	u8   (*check_err)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap);
@@ -434,7 +440,6 @@ extern void ata_noop_dev_select (struct 
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
-extern u8 ata_chk_err(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
@@ -455,7 +460,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
+extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -718,4 +723,21 @@ static inline int ata_try_flush_cache(co
 	       ata_id_has_flush_ext(dev->id);
 }
 
+static inline unsigned int ac_err_mask(u8 status)
+{
+	if (status & ATA_BUSY)
+		return AC_ERR_ATA_BUS;
+	if (status & (ATA_ERR | ATA_DF))
+		return AC_ERR_DEV;
+	return 0;
+}
+
+static inline unsigned int __ac_err_mask(u8 status)
+{
+	unsigned int mask = ac_err_mask(status);
+	if (mask == 0)
+		return AC_ERR_OTHER;
+	return mask;
+}
+
 #endif /* __LINUX_LIBATA_H__ */
