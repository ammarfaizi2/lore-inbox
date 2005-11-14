Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVKNT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVKNT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVKNT5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:57:24 -0500
Received: from havoc.gtf.org ([69.61.125.42]:42396 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932077AbVKNT5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:57:20 -0500
Date: Mon, 14 Nov 2005 14:57:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051114195717.GA24373@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I finally got ATAPI working on my x86-64 AHCI box.

Just checked the following changes into the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Will send upstream soon.

 drivers/scsi/ahci.c        |   24 +++++++++++---
 drivers/scsi/libata-core.c |   64 ++++++++++++++++---------------------
 drivers/scsi/libata-scsi.c |   77 +++++++++++++++++++++++++--------------------
 drivers/scsi/libata.h      |    2 -
 include/linux/libata.h     |   14 ++++++++
 5 files changed, 105 insertions(+), 76 deletions(-)

Jeff Garzik:
      [libata ahci] error handling fixes
      [libata] fix bugs in ATAPI padding DMA mapping code
      [libata] minor fixes, new helpers
      [libata] REQUEST SENSE handling fixes

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 4e96ec5..c710a7d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -603,7 +603,12 @@ static void ahci_intr_error(struct ata_p
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
+	printk(KERN_WARNING "ata%u: error occurred, port reset (%s%s%s%s)\n",
+	       ap->id,
+	       irq_stat & PORT_IRQ_TF_ERR ? "taskf " : "",
+	       irq_stat & PORT_IRQ_HBUS_ERR ? "hbus " : "",
+	       irq_stat & PORT_IRQ_HBUS_DATA_ERR ? "hbus_data " : "",
+	       irq_stat & PORT_IRQ_IF_ERR ? "if " : "");
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -618,13 +623,13 @@ static void ahci_eng_timeout(struct ata_
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
-	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (!qc) {
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 	} else {
+		ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+
 		/* hack alert!  We cannot use the supplied completion
 	 	 * function from inside the ->eh_strategy_handler() thread.
 	 	 * libata is the only user of ->eh_strategy_handler() in
@@ -659,9 +664,18 @@ static inline int ahci_host_intr(struct 
 	}
 
 	if (status & PORT_IRQ_FATAL) {
-		ahci_intr_error(ap, status);
+		unsigned int err_mask;
+		if (status & PORT_IRQ_TF_ERR)
+			err_mask = AC_ERR_DEV;
+		else if (status & PORT_IRQ_IF_ERR)
+			err_mask = AC_ERR_ATA_BUS;
+		else
+			err_mask = AC_ERR_HOST_BUS;
+
+		if (err_mask != AC_ERR_DEV)
+			ahci_intr_error(ap, status);
 		if (qc)
-			ata_qc_complete(qc, AC_ERR_OTHER);
+			ata_qc_complete(qc, err_mask);
 	}
 
 	return 1;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d81db3a..ba1eb8b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1263,7 +1263,7 @@ retry:
 	}
 
 	/* ATAPI-specific feature tests */
-	else {
+	else if (dev->class == ATA_DEV_ATAPI) {
 		if (ata_id_is_ata(dev->id))		/* sanity check */
 			goto err_out_nosup;
 
@@ -2399,7 +2399,7 @@ static void ata_sg_clean(struct ata_queu
 	if (qc->flags & ATA_QCFLAG_SINGLE)
 		assert(qc->n_elem == 1);
 
-	DPRINTK("unmapping %u sg elements\n", qc->n_elem);
+	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
 	/* if we padded the buffer out to 32-bit bound, and data
 	 * xfer direction is from-device, we must copy from the
@@ -2409,7 +2409,8 @@ static void ata_sg_clean(struct ata_queu
 		pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
 
 	if (qc->flags & ATA_QCFLAG_SG) {
-		dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
+		if (qc->n_elem)
+			dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 		/* restore last sg */
 		sg[qc->orig_n_elem - 1].length += qc->pad_len;
 		if (pad_buf) {
@@ -2419,8 +2420,10 @@ static void ata_sg_clean(struct ata_queu
 			kunmap_atomic(psg->page, KM_IRQ0);
 		}
 	} else {
-		dma_unmap_single(ap->host_set->dev, sg_dma_address(&sg[0]),
-				 sg_dma_len(&sg[0]), dir);
+		if (sg_dma_len(&sg[0]) > 0)
+			dma_unmap_single(ap->host_set->dev,
+				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
+				dir);
 		/* restore sg */
 		sg->length += qc->pad_len;
 		if (pad_buf)
@@ -2619,6 +2622,11 @@ static int ata_sg_setup_one(struct ata_q
 			sg->length, qc->pad_len);
 	}
 
+	if (!sg->length) {
+		sg_dma_address(sg) = 0;
+		goto skip_map;
+	}
+
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg->length, dir);
 	if (dma_mapping_error(dma_address)) {
@@ -2628,6 +2636,7 @@ static int ata_sg_setup_one(struct ata_q
 	}
 
 	sg_dma_address(sg) = dma_address;
+skip_map:
 	sg_dma_len(sg) = sg->length;
 
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
@@ -2655,7 +2664,7 @@ static int ata_sg_setup(struct ata_queue
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->__sg;
 	struct scatterlist *lsg = &sg[qc->n_elem - 1];
-	int n_elem, dir;
+	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
 	VPRINTK("ENTER, ata%u\n", ap->id);
 	assert(qc->flags & ATA_QCFLAG_SG);
@@ -2689,13 +2698,24 @@ static int ata_sg_setup(struct ata_queue
 		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
 		/* trim last sg */
 		lsg->length -= qc->pad_len;
+		if (lsg->length == 0)
+			trim_sg = 1;
 
 		DPRINTK("padding done, sg[%d].length=%u pad_len=%u\n",
 			qc->n_elem - 1, lsg->length, qc->pad_len);
 	}
 
+	pre_n_elem = qc->n_elem;
+	if (trim_sg && pre_n_elem)
+		pre_n_elem--;
+
+	if (!pre_n_elem) {
+		n_elem = 0;
+		goto skip_map;
+	}
+
 	dir = qc->dma_dir;
-	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
+	n_elem = dma_map_sg(ap->host_set->dev, sg, pre_n_elem, dir);
 	if (n_elem < 1) {
 		/* restore last sg */
 		lsg->length += qc->pad_len;
@@ -2704,6 +2724,7 @@ static int ata_sg_setup(struct ata_queue
 
 	DPRINTK("%d sg elements mapped\n", n_elem);
 
+skip_map:
 	qc->n_elem = n_elem;
 
 	return 0;
@@ -3263,32 +3284,11 @@ static void ata_qc_timeout(struct ata_qu
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
-	struct ata_device *dev = qc->dev;
 	u8 host_stat = 0, drv_stat;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
-	/* FIXME: doesn't this conflict with timeout handling? */
-	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
-		struct scsi_cmnd *cmd = qc->scsicmd;
-
-		if (!(cmd->eh_eflags & SCSI_EH_CANCEL_CMD)) {
-
-			/* finish completing original command */
-			spin_lock_irqsave(&host_set->lock, flags);
-			__ata_qc_complete(qc);
-			spin_unlock_irqrestore(&host_set->lock, flags);
-
-			atapi_request_sense(ap, dev, cmd);
-
-			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
-		}
-	}
-
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	/* hack alert!  We cannot use the supplied completion
@@ -3327,7 +3327,6 @@ static void ata_qc_timeout(struct ata_qu
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
-out:
 	DPRINTK("EXIT\n");
 }
 
@@ -3411,16 +3410,11 @@ struct ata_queued_cmd *ata_qc_new_init(s
 
 	qc = ata_qc_new(ap);
 	if (qc) {
-		qc->__sg = NULL;
-		qc->flags = 0;
 		qc->scsicmd = NULL;
 		qc->ap = ap;
 		qc->dev = dev;
-		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
-		qc->nsect = 0;
-		qc->nbytes = qc->curbytes = 0;
 
-		ata_tf_init(ap, &qc->tf, dev->devno);
+		ata_qc_reinit(qc);
 	}
 
 	return qc;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 0df4b68..3b4ca55 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1955,22 +1955,44 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
-			 struct scsi_cmnd *cmd)
+static int atapi_sense_complete(struct ata_queued_cmd *qc,unsigned int err_mask)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
+	if (err_mask && ((err_mask & AC_ERR_DEV) == 0))
+		/* FIXME: not quite right; we don't want the
+		 * translation of taskfile registers into
+		 * a sense descriptors, since that's only
+		 * correct for ATA, not ATAPI
+		 */
+		ata_gen_ata_desc_sense(qc);
 
-	DPRINTK("ATAPI request sense\n");
+	qc->scsidone(qc->scsicmd);
+	return 0;
+}
+
+/* is it pointless to prefer PIO for "safety reasons"? */
+static inline int ata_pio_use_silly(struct ata_port *ap)
+{
+	return (ap->flags & ATA_FLAG_PIO_DMA);
+}
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
+static void atapi_request_sense(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	DPRINTK("ATAPI request sense\n");
 
 	/* FIXME: is this needed? */
 	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
 
+	ap->ops->tf_read(ap, &qc->tf);
+
+	/* fill these in, for the case where they are -not- overwritten */
+	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[2] = qc->tf.feature >> 4;
+
+	ata_qc_reinit(qc);
+
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
@@ -1981,22 +2003,20 @@ void atapi_request_sense(struct ata_port
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	qc->tf.command = ATA_CMD_PACKET;
 
-	qc->tf.protocol = ATA_PROT_ATAPI;
-	qc->tf.lbam = (8 * 1024) & 0xff;
-	qc->tf.lbah = (8 * 1024) >> 8;
+	if (ata_pio_use_silly(ap)) {
+		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
+		qc->tf.feature |= ATAPI_PKT_DMA;
+	} else {
+		qc->tf.protocol = ATA_PROT_ATAPI;
+		qc->tf.lbam = (8 * 1024) & 0xff;
+		qc->tf.lbah = (8 * 1024) >> 8;
+	}
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	qc->complete_fn = atapi_sense_complete;
 
-	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+	if (ata_qc_issue(qc))
+		ata_qc_complete(qc, AC_ERR_OTHER);
 
 	DPRINTK("EXIT\n");
 }
@@ -2008,19 +2028,8 @@ static int atapi_qc_complete(struct ata_
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
 	if (unlikely(err_mask & AC_ERR_DEV)) {
-		DPRINTK("request check condition\n");
-
-		/* FIXME: command completion with check condition
-		 * but no sense causes the error handler to run,
-		 * which then issues REQUEST SENSE, fills in the sense 
-		 * buffer, and completes the command (for the second
-		 * time).  We need to issue REQUEST SENSE some other
-		 * way, to avoid completing the command twice.
-		 */
 		cmd->result = SAM_STAT_CHECK_CONDITION;
-
-		qc->scsidone(cmd);
-
+		atapi_request_sense(qc);
 		return 1;
 	}
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index fad051c..74a84e0 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -54,8 +54,6 @@ extern int ata_cmd_ioctl(struct scsi_dev
 
 
 /* libata-scsi.c */
-extern void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
-			 struct scsi_cmnd *cmd);
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ad59961..f2dbb68 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -59,6 +59,8 @@
 #define VPRINTK(fmt, args...)
 #endif	/* ATA_DEBUG */
 
+#define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+
 #ifdef ATA_NDEBUG
 #define assert(expr)
 #else
@@ -119,6 +121,7 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
+	ATA_FLAG_DEBUGMSG	= (1 << 10),
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -659,6 +662,17 @@ static inline void ata_tf_init(struct at
 		tf->device = ATA_DEVICE_OBS | ATA_DEV1;
 }
 
+static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
+{
+	qc->__sg = NULL;
+	qc->flags = 0;
+	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
+	qc->nsect = 0;
+	qc->nbytes = qc->curbytes = 0;
+
+	ata_tf_init(qc->ap, &qc->tf, qc->dev->devno);
+}
+
 
 /**
  *	ata_irq_on - Enable interrupts on a port.
