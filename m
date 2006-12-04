Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936974AbWLDO7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936974AbWLDO7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936970AbWLDO6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:58:55 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6269 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936974AbWLDO45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:56:57 -0500
Date: Mon, 4 Dec 2006 15:56:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, braunu@de.ibm.com
Subject: [S390] non-unique constant/macro identifiers.
Message-ID: <20061204145653.GD32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <braunu@de.ibm.com>

[S390] non-unique constant/macro identifiers.

Add some prefixes to constands defined in drivers/s390/net/qdio.h
and drivers/s390/lcs.h to make it possible to include the three
header files drivers/s390/net/qeth.h, drivers/s390/net/qdio.h and
drivers/net/s390/lcs.h in one C file. This is required for the
patch that generates the kerntypes.o file for use by lcrash.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c      |    8 ++--
 drivers/s390/cio/qdio.h      |    4 --
 drivers/s390/net/lcs.c       |   78 ++++++++++++++++++++++---------------------
 drivers/s390/net/lcs.h       |   25 +++++--------
 drivers/s390/net/qeth.h      |    2 -
 drivers/s390/net/qeth_main.c |    6 +--
 6 files changed, 58 insertions(+), 65 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-12-04 14:51:03.000000000 +0100
@@ -481,7 +481,7 @@ qdio_stop_polling(struct qdio_q *q)
        unsigned char state = 0;
        struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
 
-	if (!atomic_swap(&q->polling,0)) 
+	if (!atomic_xchg(&q->polling,0))
 		return 1;
 
 	QDIO_DBF_TEXT4(0,trace,"stoppoll");
@@ -1964,8 +1964,8 @@ qdio_irq_check_sense(struct subchannel_i
 		QDIO_DBF_HEX0(0,sense,irb,QDIO_DBF_SENSE_LEN);
 
 		QDIO_PRINT_WARN("sense data available on qdio channel.\n");
-		HEXDUMP16(WARN,"irb: ",irb);
-		HEXDUMP16(WARN,"sense data: ",irb->ecw);
+		QDIO_HEXDUMP16(WARN,"irb: ",irb);
+		QDIO_HEXDUMP16(WARN,"sense data: ",irb->ecw);
 	}
 		
 }
@@ -3425,7 +3425,7 @@ do_qdio_handle_inbound(struct qdio_q *q,
 	
 	if ((used_elements+count==QDIO_MAX_BUFFERS_PER_Q)&&
 	    (callflags&QDIO_FLAG_UNDER_INTERRUPT))
-		atomic_swap(&q->polling,0);
+		atomic_xchg(&q->polling,0);
 	
 	if (used_elements) 
 		return;
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2006-12-04 14:51:03.000000000 +0100
@@ -236,7 +236,7 @@ enum qdio_irq_states {
 #define QDIO_PRINT_EMERG(x...) do { } while (0)
 #endif
 
-#define HEXDUMP16(importance,header,ptr) \
+#define QDIO_HEXDUMP16(importance,header,ptr) \
 QDIO_PRINT_##importance(header "%02x %02x %02x %02x  " \
 			"%02x %02x %02x %02x  %02x %02x %02x %02x  " \
 			"%02x %02x %02x %02x\n",*(((char*)ptr)), \
@@ -429,8 +429,6 @@ struct qdio_perf_stats {
 };
 #endif /* QDIO_PERFORMANCE_STATS */
 
-#define atomic_swap(a,b) xchg((int*)a.counter,b)
-
 /* unlikely as the later the better */
 #define SYNC_MEMORY if (unlikely(q->siga_sync)) qdio_siga_sync_q(q)
 #define SYNC_MEMORY_ALL if (unlikely(q->siga_sync)) \
diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2006-12-04 14:50:21.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2006-12-04 14:51:03.000000000 +0100
@@ -54,6 +54,8 @@
 #error Cannot compile lcs.c without some net devices switched on.
 #endif
 
+#define PRINTK_HEADER		" lcs: "
+
 /**
  * initialization string for output
  */
@@ -120,7 +122,7 @@ lcs_alloc_channel(struct lcs_channel *ch
 			kzalloc(LCS_IOBUFFERSIZE, GFP_DMA | GFP_KERNEL);
 		if (channel->iob[cnt].data == NULL)
 			break;
-		channel->iob[cnt].state = BUF_STATE_EMPTY;
+		channel->iob[cnt].state = LCS_BUF_STATE_EMPTY;
 	}
 	if (cnt < LCS_NUM_BUFFS) {
 		/* Not all io buffers could be allocated. */
@@ -236,7 +238,7 @@ lcs_setup_read_ccws(struct lcs_card *car
 		((struct lcs_header *)
 		 card->read.iob[cnt].data)->offset = LCS_ILLEGAL_OFFSET;
 		card->read.iob[cnt].callback = lcs_get_frames_cb;
-		card->read.iob[cnt].state = BUF_STATE_READY;
+		card->read.iob[cnt].state = LCS_BUF_STATE_READY;
 		card->read.iob[cnt].count = LCS_IOBUFFERSIZE;
 	}
 	card->read.ccws[0].flags &= ~CCW_FLAG_PCI;
@@ -247,7 +249,7 @@ lcs_setup_read_ccws(struct lcs_card *car
 	card->read.ccws[LCS_NUM_BUFFS].cda =
 		(__u32) __pa(card->read.ccws);
 	/* Setg initial state of the read channel. */
-	card->read.state = CH_STATE_INIT;
+	card->read.state = LCS_CH_STATE_INIT;
 
 	card->read.io_idx = 0;
 	card->read.buf_idx = 0;
@@ -294,7 +296,7 @@ lcs_setup_write_ccws(struct lcs_card *ca
 	card->write.ccws[LCS_NUM_BUFFS].cda =
 		(__u32) __pa(card->write.ccws);
 	/* Set initial state of the write channel. */
-	card->read.state = CH_STATE_INIT;
+	card->read.state = LCS_CH_STATE_INIT;
 
 	card->write.io_idx = 0;
 	card->write.buf_idx = 0;
@@ -496,7 +498,7 @@ lcs_start_channel(struct lcs_channel *ch
 			      channel->ccws + channel->io_idx, 0, 0,
 			      DOIO_DENY_PREFETCH | DOIO_ALLOW_SUSPEND);
 	if (rc == 0)
-		channel->state = CH_STATE_RUNNING;
+		channel->state = LCS_CH_STATE_RUNNING;
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
 		LCS_DBF_TEXT_(4,trace,"essh%s", channel->ccwdev->dev.bus_id);
@@ -520,8 +522,8 @@ lcs_clear_channel(struct lcs_channel *ch
 		LCS_DBF_TEXT_(4,trace,"ecsc%s", channel->ccwdev->dev.bus_id);
 		return rc;
 	}
-	wait_event(channel->wait_q, (channel->state == CH_STATE_CLEARED));
-	channel->state = CH_STATE_STOPPED;
+	wait_event(channel->wait_q, (channel->state == LCS_CH_STATE_CLEARED));
+	channel->state = LCS_CH_STATE_STOPPED;
 	return rc;
 }
 
@@ -535,11 +537,11 @@ lcs_stop_channel(struct lcs_channel *cha
 	unsigned long flags;
 	int rc;
 
-	if (channel->state == CH_STATE_STOPPED)
+	if (channel->state == LCS_CH_STATE_STOPPED)
 		return 0;
 	LCS_DBF_TEXT(4,trace,"haltsch");
 	LCS_DBF_TEXT_(4,trace,"%s", channel->ccwdev->dev.bus_id);
-	channel->state = CH_STATE_INIT;
+	channel->state = LCS_CH_STATE_INIT;
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	rc = ccw_device_halt(channel->ccwdev, (addr_t) channel);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
@@ -548,7 +550,7 @@ lcs_stop_channel(struct lcs_channel *cha
 		return rc;
 	}
 	/* Asynchronous halt initialted. Wait for its completion. */
-	wait_event(channel->wait_q, (channel->state == CH_STATE_HALTED));
+	wait_event(channel->wait_q, (channel->state == LCS_CH_STATE_HALTED));
 	lcs_clear_channel(channel);
 	return 0;
 }
@@ -596,8 +598,8 @@ __lcs_get_buffer(struct lcs_channel *cha
 	LCS_DBF_TEXT(5, trace, "_getbuff");
 	index = channel->io_idx;
 	do {
-		if (channel->iob[index].state == BUF_STATE_EMPTY) {
-			channel->iob[index].state = BUF_STATE_LOCKED;
+		if (channel->iob[index].state == LCS_BUF_STATE_EMPTY) {
+			channel->iob[index].state = LCS_BUF_STATE_LOCKED;
 			return channel->iob + index;
 		}
 		index = (index + 1) & (LCS_NUM_BUFFS - 1);
@@ -626,7 +628,7 @@ __lcs_resume_channel(struct lcs_channel 
 {
 	int rc;
 
-	if (channel->state != CH_STATE_SUSPENDED)
+	if (channel->state != LCS_CH_STATE_SUSPENDED)
 		return 0;
 	if (channel->ccws[channel->io_idx].flags & CCW_FLAG_SUSPEND)
 		return 0;
@@ -636,7 +638,7 @@ __lcs_resume_channel(struct lcs_channel 
 		LCS_DBF_TEXT_(4, trace, "ersc%s", channel->ccwdev->dev.bus_id);
 		PRINT_ERR("Error in lcs_resume_channel: rc=%d\n",rc);
 	} else
-		channel->state = CH_STATE_RUNNING;
+		channel->state = LCS_CH_STATE_RUNNING;
 	return rc;
 
 }
@@ -670,10 +672,10 @@ lcs_ready_buffer(struct lcs_channel *cha
 	int index, rc;
 
 	LCS_DBF_TEXT(5, trace, "rdybuff");
-	BUG_ON(buffer->state != BUF_STATE_LOCKED &&
-	       buffer->state != BUF_STATE_PROCESSED);
+	BUG_ON(buffer->state != LCS_BUF_STATE_LOCKED &&
+	       buffer->state != LCS_BUF_STATE_PROCESSED);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	buffer->state = BUF_STATE_READY;
+	buffer->state = LCS_BUF_STATE_READY;
 	index = buffer - channel->iob;
 	/* Set length. */
 	channel->ccws[index].count = buffer->count;
@@ -695,8 +697,8 @@ __lcs_processed_buffer(struct lcs_channe
 	int index, prev, next;
 
 	LCS_DBF_TEXT(5, trace, "prcsbuff");
-	BUG_ON(buffer->state != BUF_STATE_READY);
-	buffer->state = BUF_STATE_PROCESSED;
+	BUG_ON(buffer->state != LCS_BUF_STATE_READY);
+	buffer->state = LCS_BUF_STATE_PROCESSED;
 	index = buffer - channel->iob;
 	prev = (index - 1) & (LCS_NUM_BUFFS - 1);
 	next = (index + 1) & (LCS_NUM_BUFFS - 1);
@@ -704,7 +706,7 @@ __lcs_processed_buffer(struct lcs_channe
 	channel->ccws[index].flags |= CCW_FLAG_SUSPEND;
 	channel->ccws[index].flags &= ~CCW_FLAG_PCI;
 	/* Check the suspend bit of the previous buffer. */
-	if (channel->iob[prev].state == BUF_STATE_READY) {
+	if (channel->iob[prev].state == LCS_BUF_STATE_READY) {
 		/*
 		 * Previous buffer is in state ready. It might have
 		 * happened in lcs_ready_buffer that the suspend bit
@@ -727,10 +729,10 @@ lcs_release_buffer(struct lcs_channel *c
 	unsigned long flags;
 
 	LCS_DBF_TEXT(5, trace, "relbuff");
-	BUG_ON(buffer->state != BUF_STATE_LOCKED &&
-	       buffer->state != BUF_STATE_PROCESSED);
+	BUG_ON(buffer->state != LCS_BUF_STATE_LOCKED &&
+	       buffer->state != LCS_BUF_STATE_PROCESSED);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	buffer->state = BUF_STATE_EMPTY;
+	buffer->state = LCS_BUF_STATE_EMPTY;
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 }
 
@@ -1264,7 +1266,7 @@ lcs_register_mc_addresses(void *data)
 	netif_carrier_off(card->dev);
 	netif_tx_disable(card->dev);
 	wait_event(card->write.wait_q,
-			(card->write.state != CH_STATE_RUNNING));
+			(card->write.state != LCS_CH_STATE_RUNNING));
 	lcs_fix_multicast_list(card);
 	if (card->state == DEV_STATE_UP) {
 		netif_carrier_on(card->dev);
@@ -1404,7 +1406,7 @@ lcs_irq(struct ccw_device *cdev, unsigne
 		}
 	}
 	/* How far in the ccw chain have we processed? */
-	if ((channel->state != CH_STATE_INIT) &&
+	if ((channel->state != LCS_CH_STATE_INIT) &&
 	    (irb->scsw.fctl & SCSW_FCTL_START_FUNC)) {
 		index = (struct ccw1 *) __va((addr_t) irb->scsw.cpa)
 			- channel->ccws;
@@ -1424,20 +1426,20 @@ lcs_irq(struct ccw_device *cdev, unsigne
 	    (irb->scsw.dstat & DEV_STAT_CHN_END) ||
 	    (irb->scsw.dstat & DEV_STAT_UNIT_CHECK))
 		/* Mark channel as stopped. */
-		channel->state = CH_STATE_STOPPED;
+		channel->state = LCS_CH_STATE_STOPPED;
 	else if (irb->scsw.actl & SCSW_ACTL_SUSPENDED)
 		/* CCW execution stopped on a suspend bit. */
-		channel->state = CH_STATE_SUSPENDED;
+		channel->state = LCS_CH_STATE_SUSPENDED;
 	if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC) {
 		if (irb->scsw.cc != 0) {
 			ccw_device_halt(channel->ccwdev, (addr_t) channel);
 			return;
 		}
 		/* The channel has been stopped by halt_IO. */
-		channel->state = CH_STATE_HALTED;
+		channel->state = LCS_CH_STATE_HALTED;
 	}
 	if (irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		channel->state = CH_STATE_CLEARED;
+		channel->state = LCS_CH_STATE_CLEARED;
 	}
 	/* Do the rest in the tasklet. */
 	tasklet_schedule(&channel->irq_tasklet);
@@ -1461,7 +1463,7 @@ lcs_tasklet(unsigned long data)
 	/* Check for processed buffers. */
 	iob = channel->iob;
 	buf_idx = channel->buf_idx;
-	while (iob[buf_idx].state == BUF_STATE_PROCESSED) {
+	while (iob[buf_idx].state == LCS_BUF_STATE_PROCESSED) {
 		/* Do the callback thing. */
 		if (iob[buf_idx].callback != NULL)
 			iob[buf_idx].callback(channel, iob + buf_idx);
@@ -1469,12 +1471,12 @@ lcs_tasklet(unsigned long data)
 	}
 	channel->buf_idx = buf_idx;
 
-	if (channel->state == CH_STATE_STOPPED)
+	if (channel->state == LCS_CH_STATE_STOPPED)
 		// FIXME: what if rc != 0 ??
 		rc = lcs_start_channel(channel);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	if (channel->state == CH_STATE_SUSPENDED &&
-	    channel->iob[channel->io_idx].state == BUF_STATE_READY) {
+	if (channel->state == LCS_CH_STATE_SUSPENDED &&
+	    channel->iob[channel->io_idx].state == LCS_BUF_STATE_READY) {
 		// FIXME: what if rc != 0 ??
 		rc = __lcs_resume_channel(channel);
 	}
@@ -1689,8 +1691,8 @@ lcs_detect(struct lcs_card *card)
 		card->state = DEV_STATE_UP;
 	} else {
 		card->state = DEV_STATE_DOWN;
-		card->write.state = CH_STATE_INIT;
-		card->read.state =  CH_STATE_INIT;
+		card->write.state = LCS_CH_STATE_INIT;
+		card->read.state =  LCS_CH_STATE_INIT;
 	}
 	return rc;
 }
@@ -1705,8 +1707,8 @@ lcs_stopcard(struct lcs_card *card)
 
 	LCS_DBF_TEXT(3, setup, "stopcard");
 
-	if (card->read.state != CH_STATE_STOPPED &&
-	    card->write.state != CH_STATE_STOPPED &&
+	if (card->read.state != LCS_CH_STATE_STOPPED &&
+	    card->write.state != LCS_CH_STATE_STOPPED &&
 	    card->state == DEV_STATE_UP) {
 		lcs_clear_multicast_list(card);
 		rc = lcs_send_stoplan(card,LCS_INITIATOR_TCPIP);
@@ -1871,7 +1873,7 @@ lcs_stop_device(struct net_device *dev)
 	netif_tx_disable(dev);
 	dev->flags &= ~IFF_UP;
 	wait_event(card->write.wait_q,
-		(card->write.state != CH_STATE_RUNNING));
+		(card->write.state != LCS_CH_STATE_RUNNING));
 	rc = lcs_stopcard(card);
 	if (rc)
 		PRINT_ERR("Try it again!\n ");
diff -urpN linux-2.6/drivers/s390/net/lcs.h linux-2.6-patched/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	2006-12-04 14:50:21.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.h	2006-12-04 14:51:03.000000000 +0100
@@ -23,11 +23,6 @@ do {                                    
 } while (0)
 
 /**
- * some more definitions for debug or output stuff
- */
-#define PRINTK_HEADER		" lcs: "
-
-/**
  *	sysfs related stuff
  */
 #define CARD_FROM_DEV(cdev) \
@@ -127,22 +122,22 @@ do {                                    
  * LCS Buffer states
  */
 enum lcs_buffer_states {
-	BUF_STATE_EMPTY,	/* buffer is empty */
-	BUF_STATE_LOCKED,	/* buffer is locked, don't touch */
-	BUF_STATE_READY,	/* buffer is ready for read/write */
-	BUF_STATE_PROCESSED,
+	LCS_BUF_STATE_EMPTY,	/* buffer is empty */
+	LCS_BUF_STATE_LOCKED,	/* buffer is locked, don't touch */
+	LCS_BUF_STATE_READY,	/* buffer is ready for read/write */
+	LCS_BUF_STATE_PROCESSED,
 };
 
 /**
  * LCS Channel State Machine declarations
  */
 enum lcs_channel_states {
-	CH_STATE_INIT,
-	CH_STATE_HALTED,
-	CH_STATE_STOPPED,
-	CH_STATE_RUNNING,
-	CH_STATE_SUSPENDED,
-	CH_STATE_CLEARED,
+	LCS_CH_STATE_INIT,
+	LCS_CH_STATE_HALTED,
+	LCS_CH_STATE_STOPPED,
+	LCS_CH_STATE_RUNNING,
+	LCS_CH_STATE_SUSPENDED,
+	LCS_CH_STATE_CLEARED,
 };
 
 /**
diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2006-12-04 14:51:03.000000000 +0100
@@ -151,8 +151,6 @@ qeth_hex_dump(unsigned char *buf, size_t
 #define SENSE_RESETTING_EVENT_BYTE 1
 #define SENSE_RESETTING_EVENT_FLAG 0x80
 
-#define atomic_swap(a,b) xchg((int *)a.counter, b)
-
 /*
  * Common IO related definitions
  */
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2006-12-04 14:51:03.000000000 +0100
@@ -2982,7 +2982,7 @@ qeth_check_outbound_queue(struct qeth_qd
 	 */
 	if ((atomic_read(&queue->used_buffers) <= QETH_LOW_WATERMARK_PACK) ||
 	    !atomic_read(&queue->set_pci_flags_count)){
-		if (atomic_swap(&queue->state, QETH_OUT_Q_LOCKED_FLUSH) ==
+		if (atomic_xchg(&queue->state, QETH_OUT_Q_LOCKED_FLUSH) ==
 				QETH_OUT_Q_UNLOCKED) {
 			/*
 			 * If we get in here, there was no action in
@@ -3245,7 +3245,7 @@ qeth_free_qdio_buffers(struct qeth_card 
 	int i, j;
 
 	QETH_DBF_TEXT(trace, 2, "freeqdbf");
-	if (atomic_swap(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
+	if (atomic_xchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
 		QETH_QDIO_UNINITIALIZED)
 		return;
 	kfree(card->qdio.in_q);
@@ -4366,7 +4366,7 @@ out:
 	if (flush_count)
 		qeth_flush_buffers(queue, 0, start_index, flush_count);
 	else if (!atomic_read(&queue->set_pci_flags_count))
-		atomic_swap(&queue->state, QETH_OUT_Q_LOCKED_FLUSH);
+		atomic_xchg(&queue->state, QETH_OUT_Q_LOCKED_FLUSH);
 	/*
 	 * queue->state will go from LOCKED -> UNLOCKED or from
 	 * LOCKED_FLUSH -> LOCKED if output_handler wanted to 'notify' us
