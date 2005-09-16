Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbVIPAH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVIPAH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbVIPAH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:07:59 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:47784 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S965279AbVIPAH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:07:58 -0400
Message-ID: <60613.200.141.106.169.1126829274.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <43290893.7070207@pobox.com>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
    <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
    <43290893.7070207@pobox.com>
Date: Thu, 15 Sep 2005 21:07:54 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: izvekov@lps.ele.puc-rio.br, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I made a failed attempt to solve it here:
>      http://search.luky.org/linux-kernel.2005/msg14830.html
>
> This patch from Albert Lee might solve it, but the patch itself needs
> bug fixes:
>      http://marc.theaimsgroup.com/?t=112628285200005&r=1&w=2
>
> Also, defining ATA_IRQ_TRAP in include/linux/libata.h may work around
> the problem.
>
> Plenty more info available on request.  Nothing changed in this area
> with regards to 2.6.12/2.6.13, so I presume that ACPI has simply exposed
> the existing problem for you.  :(
>
>      Jeff
>
>

Hi

That patch wich was a failed attempt didnt work for me aswell, but the one
from Albert Lee did indeed fix it! Now i dont get any errors or any oops
in dmesg, everything works perfect!

Below follows the patch, reworked to apply against 2.6.13.1, and with your
concerns adressed, except for:

* renaming PIO_ST_* to HSM_ST_* and pio_task_state to hsm_task_state because
i didnt though it was apropriate here, would generate a huge diff.
* the locking issues, because i really dont understand whats the problem
 with that.

The patch:

diff -urp linux-2.6.13.1/drivers/scsi/libata-core.c
linux-2.6.13.1-2/drivers/scsi/libata-core.c
--- linux-2.6.13.1/drivers/scsi/libata-core.c	2005-09-09
23:42:58.000000000 -0300
+++ linux-2.6.13.1-2/drivers/scsi/libata-core.c	2005-09-15
20:45:24.000000000 -0300
@@ -2550,7 +2550,7 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;

-	buf = kmap(page) + offset;
+	buf = kmap_atomic(page, KM_IRQ0) + offset;

 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -2566,7 +2566,7 @@ static void ata_pio_sector(struct ata_qu
 	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);

-	kunmap(page);
+	kunmap_atomic(page, KM_IRQ0);
 }

 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
@@ -2597,7 +2597,7 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);

-	buf = kmap(page) + offset;
+	buf = kmap_atomic(page, KM_IRQ0) + offset;

 	bytes -= count;
 	qc->curbytes += count;
@@ -2613,7 +2613,7 @@ next_sg:
 	/* do the actual data transfer */
 	ata_data_xfer(ap, buf, count, do_write);

-	kunmap(page);
+	kunmap_atomic(page, KM_IRQ0);

 	if (bytes) {
 		goto next_sg;
@@ -2642,6 +2642,8 @@ static void atapi_pio_bytes(struct ata_q
 	if (do_write != i_write)
 		goto err_out;

+	VPRINTK("ata%u: xfering %d bytes\n", ap->id, bytes);
+
 	__atapi_pio_bytes(qc, bytes);

 	return;
@@ -3170,37 +3172,92 @@ int ata_qc_issue_prot(struct ata_queued_

 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
+		ap->pio_task_state = PIO_ST_LAST;
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->pio_task);
+
 		break;

 	case ATA_PROT_DMA:
+		assert(!(qc->tf.flags & ATA_TFLAG_POLLING));
+
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+		ap->pio_task_state = PIO_ST_LAST;
 		break;

 	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
-		ata_qc_set_polling(qc);
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING) {
+			ap->pio_task_state = PIO_ST;
+			queue_work(ata_wq, &ap->pio_task);
+		} else {
+			/* Interrupt driven PIO. */
+			if (qc->tf.flags & ATA_TFLAG_WRITE) {
+				/*
+				 * PIO data out protocol
+				 */
+				ap->pio_task_state = PIO_ST_FIRST;
+				queue_work(ata_wq, &ap->packet_task);
+
+				/* send first data block by polling */
+			} else {
+				ap->pio_task_state = PIO_ST;
+
+				/* interrupt handler takes over from here */
+			}
+		}
+
 		break;

 	case ATA_PROT_ATAPI:
-		ata_qc_set_polling(qc);
-		ata_tf_to_host_nolock(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
+ 		ata_tf_to_host_nolock(ap, &qc->tf);
+		ap->pio_task_state = PIO_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!ata_id_cdb_intr(qc->dev->id)) ||
+		    qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->packet_task);
 		break;

 	case ATA_PROT_ATAPI_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ap->pio_task_state = PIO_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!ata_id_cdb_intr(qc->dev->id)) ||
+		    qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->packet_task);
 		break;

 	case ATA_PROT_ATAPI_DMA:
+		assert(!(qc->tf.flags & ATA_TFLAG_POLLING));
+
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		queue_work(ata_wq, &ap->packet_task);
+
+		ap->pio_task_state = PIO_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!ata_id_cdb_intr(qc->dev->id)) ||
+		    qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->packet_task);
 		break;

 	default:
@@ -3441,6 +3498,29 @@ void ata_bmdma_stop(struct ata_port *ap)
 	ata_altstatus(ap);        /* dummy read */
 }

+static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	/* send SCSI cdb */
+	DPRINTK("send cdb\n");
+	assert(ap->cdb_len >= 12);
+
+	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI:
+		ap->pio_task_state = PIO_ST;
+		break;
+	case ATA_PROT_ATAPI_NODATA:
+		ap->pio_task_state = PIO_ST_LAST;
+		break;
+	case ATA_PROT_ATAPI_DMA:
+		ap->pio_task_state = PIO_ST_LAST;
+		/* initiate bmdma */
+		ap->ops->bmdma_start(qc);
+		break;
+	}
+}
+
 /**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
@@ -3462,45 +3542,132 @@ inline unsigned int ata_host_intr (struc
 {
 	u8 status, host_stat;

-	switch (qc->tf.protocol) {
-
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI:
-		/* check status of DMA engine */
-		host_stat = ap->ops->bmdma_status(ap);
-		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+	VPRINTK("ata%u: protocol %d task state %d\n",
+		ap->id, qc->tf.protocol, ap->pio_task_state);

-		/* if it's not our irq... */
-		if (!(host_stat & ATA_DMA_INTR))
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->pio_task_state) {
+	case PIO_ST_FIRST:
+		if (!(is_atapi_taskfile(&qc->tf) &&
+		      ata_id_cdb_intr(qc->dev->id)))
 			goto idle_irq;
+		break;
+	case PIO_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_DMA ||
+		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+			/* check status of DMA engine */
+			host_stat = ap->ops->bmdma_status(ap);
+			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+
+			/* if it's not our irq... */
+			if (!(host_stat & ATA_DMA_INTR))
+				goto idle_irq;

-		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(ap);
+			/* before we do anything else, clear DMA-Start bit */
+			ap->ops->bmdma_stop(ap);
+		}
+		break;
+	case PIO_ST:
+		break;
+	default:
+		goto idle_irq;
+	}

-		/* fall through */
+	/* check altstatus */
+	status = ata_altstatus(ap);
+	if (status & ATA_BUSY)
+		goto idle_irq;

-	case ATA_PROT_ATAPI_NODATA:
-	case ATA_PROT_NODATA:
-		/* check altstatus */
-		status = ata_altstatus(ap);
-		if (status & ATA_BUSY)
-			goto idle_irq;
+	/* check main status, clearing INTRQ */
+	status = ata_chk_status(ap);
+	if (unlikely(status & ATA_BUSY))
+		goto idle_irq;

-		/* check main status, clearing INTRQ */
-		status = ata_chk_status(ap);
-		if (unlikely(status & ATA_BUSY))
-			goto idle_irq;
-		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-			ap->id, qc->tf.protocol, status);
+	DPRINTK("ata%u: protocol %d task state %d (dev_stat 0x%X)\n",
+		ap->id, qc->tf.protocol, ap->pio_task_state, status);
+
+	/* check whether error */
+	if (status & ATA_ERR) {
+		ap->pio_task_state = PIO_ST_ERR;
+	}
+
+fsm_start:
+	switch (ap->pio_task_state) {
+	case PIO_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ
+		 * at this point when ready to receive CDB.
+		 */
+
+		/* check device status */
+		if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+			/* Wrong status. Let EH handle this */
+			ap->pio_task_state = PIO_ST_ERR;
+			goto fsm_start;
+		}
+
+		atapi_send_cdb(ap, qc);
+
+		break;
+
+	case PIO_ST:
+		/* complete command or read/write the data register */
+		if (qc->tf.protocol == ATA_PROT_ATAPI) {
+			/* ATAPI PIO protocol */
+			if ((status & ATA_DRQ) == 0) {
+				ap->pio_task_state = PIO_ST_LAST;
+				goto fsm_start;
+			}
+
+			atapi_pio_bytes(qc);
+
+		} else {
+			/* ATA PIO protocol */
+			if (unlikely((status & ATA_DRQ) == 0)) {
+				/* handle BSY=0, DRQ=0 as error */
+				ap->pio_task_state = PIO_ST_ERR;
+				goto fsm_start;
+			}
+
+			ata_pio_sector(qc);
+
+			if (ap->pio_task_state == PIO_ST_LAST &&
+			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+				/* complete the command */
+				status = ata_altstatus(ap);
+				status = ata_chk_status(ap);
+				goto fsm_start;
+			}
+		}
+
+		break;
+
+	case PIO_ST_LAST:
+		if (status & ATA_DRQ) {
+			/* status error */
+			ap->pio_task_state = PIO_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* no more data to transfer */
+		DPRINTK("ata%u: PIO complete, drv_stat 0x%x\n",
+			ap->id, status);

 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);

+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
 		break;

+	case PIO_ST_ERR:
+		printk(KERN_ERR "ata%u: PIO error, drv_stat 0x%x\n",
+		       ap->id, status);
+		ap->pio_task_state = PIO_ST_IDLE;
+		ata_qc_complete(qc, status | ATA_ERR);
+		break;
+
 	default:
 		goto idle_irq;
 	}
@@ -3585,6 +3752,7 @@ static void atapi_packet_task(void *_dat
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;

 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3600,15 +3768,17 @@ static void atapi_packet_task(void *_dat
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
 		goto err_out;

-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
-	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+	if (is_atapi_taskfile(&qc->tf)) {
+ 		spin_lock_irqsave(&ap->host_set->lock, flags);

-	/* if we are DMA'ing, irq handler takes over from here */
-	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+		/* send CDB */
+		atapi_send_cdb(ap, qc);
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->pio_task);

+ 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
 	/* non-data commands are also handled via irq */
 	else if (qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
 		/* do nothing */
@@ -3616,8 +3786,14 @@ static void atapi_packet_task(void *_dat

 	/* PIO commands are handled by polling */
 	else {
+		/* PIO data out protocol.
+		 * send first data block.
+		 */
+		ata_pio_sector(qc);
+
+		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}

 	return;
diff -urp linux-2.6.13.1/include/linux/ata.h
linux-2.6.13.1-2/include/linux/ata.h
--- linux-2.6.13.1/include/linux/ata.h	2005-09-09 23:42:58.000000000 -0300
+++ linux-2.6.13.1-2/include/linux/ata.h	2005-09-15 20:06:11.000000000 -0300
@@ -174,6 +174,7 @@ enum {
 	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
 	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
 	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
+	ATA_TFLAG_POLLING	= (1 << 4),
 };

 enum ata_tf_protocols {
@@ -243,6 +244,8 @@ struct ata_taskfile {
 	  ((u64) (id)[(n) + 1] << 16) |	\
 	  ((u64) (id)[(n) + 0]) )

+#define ata_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
+
 static inline int atapi_cdb_len(u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;
diff -urp linux-2.6.13.1/include/linux/libata.h
linux-2.6.13.1-2/include/linux/libata.h
--- linux-2.6.13.1/include/linux/libata.h	2005-09-09 23:42:58.000000000 -0300
+++ linux-2.6.13.1-2/include/linux/libata.h	2005-09-15 20:06:11.000000000
-0300
@@ -161,6 +161,7 @@ enum pio_task_states {
 	PIO_ST_LAST,
 	PIO_ST_LAST_POLL,
 	PIO_ST_ERR,
+	PIO_ST_FIRST,
 };

 /* forward declarations */



