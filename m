Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTETW4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTETWzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:55:39 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:38422 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261515AbTETWyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:54:07 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 14/14] USB speedtouch: receive code rewrite
Date: Wed, 21 May 2003 01:06:58 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210106.58629.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Main points:
- receive buffers are decoupled from urbs, so an urb can be
resubmitted with a new buffer before the old buffer is processed.
- the packet reconstruction code is much simpler.
- locking is simplified by the fact that only the tasklet launches
receive urbs

 speedtch.c |  459 ++++++++++++++++++++++++-------------------------------------
 1 files changed, 188 insertions(+), 271 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:41:16 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:41:16 2003
@@ -104,8 +104,9 @@
 
 #define UDSL_NUM_RCV_URBS		1
 #define UDSL_NUM_SND_URBS		1
+#define UDSL_NUM_RCV_BUFS		(2*UDSL_NUM_RCV_URBS)
 #define UDSL_NUM_SND_BUFS		(2*UDSL_NUM_SND_URBS)
-#define UDSL_RCV_BUF_SIZE		64 /* ATM cells */
+#define UDSL_RCV_BUF_SIZE		32 /* ATM cells */
 #define UDSL_SND_BUF_SIZE		64 /* ATM cells */
 
 #define UDSL_IOCTL_LINE_UP		1
@@ -128,9 +129,15 @@
 
 /* receive */
 
+struct udsl_receive_buffer {
+	struct list_head list;
+	unsigned char *base;
+	unsigned int filled_cells;
+};
+
 struct udsl_receiver {
 	struct list_head list;
-	struct sk_buff *skb;
+	struct udsl_receive_buffer *buffer;
 	struct urb *urb;
 	struct udsl_instance_data *instance;
 };
@@ -190,14 +197,14 @@
 
 	/* receive */
 	struct udsl_receiver receivers [UDSL_NUM_RCV_URBS];
+	struct udsl_receive_buffer receive_buffers [UDSL_NUM_RCV_BUFS];
 
-	spinlock_t spare_receivers_lock;
+	spinlock_t receive_lock;
 	struct list_head spare_receivers;
-
-	spinlock_t completed_receivers_lock;
-	struct list_head completed_receivers;
+	struct list_head filled_receive_buffers;
 
 	struct tasklet_struct receive_tasklet;
+	struct list_head spare_receive_buffers;
 
 	/* send */
 	struct udsl_sender senders [UDSL_NUM_SND_URBS];
@@ -262,133 +269,110 @@
 	return NULL;
 }
 
-static struct sk_buff *udsl_decode_rawcell (struct udsl_instance_data *instance, struct sk_buff *skb, struct udsl_vcc_data **ctx)
+static void udsl_extract_cells (struct udsl_instance_data *instance, unsigned char *source, unsigned int howmany)
 {
-	if (!instance || !skb || !ctx)
-		return NULL;
-	if (!skb->data || !skb->tail)
-		return NULL;
-
-	while (skb->len) {
-		unsigned char *cell = skb->data;
-		unsigned char *cell_payload;
-		struct udsl_vcc_data *vcc;
-		short vpi;
-		int vci;
-
-		vpi = ((cell [0] & 0x0f) << 4) | (cell [1] >> 4);
-		vci = ((cell [1] & 0x0f) << 12) | (cell [2] << 4) | (cell [3] >> 4);
-
-		vdbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", instance, skb, ctx);
-		vdbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
-
-		/* here should the header CRC check be... */
-
-		if (!(vcc = udsl_find_vcc (instance, vpi, vci))) {
-			dbg ("udsl_decode_rawcell: no vcc found for packet on vpi %d, vci %d", vpi, vci);
-			__skb_pull (skb, min (skb->len, (unsigned) 53));
+	struct udsl_vcc_data *cached_vcc = NULL;
+	struct atm_vcc *vcc;
+	struct sk_buff *skb;
+	struct udsl_vcc_data *vcc_data;
+	int cached_vci = 0;
+	unsigned int i;
+	unsigned int length;
+	unsigned int pdu_length;
+	int pti;
+	int vci;
+	short cached_vpi = 0;
+	short vpi;
+
+	for (i = 0; i < howmany; i++, source += ATM_CELL_SIZE) {
+		vpi = ((source [0] & 0x0f) << 4) | (source [1] >> 4);
+		vci = ((source [1] & 0x0f) << 12) | (source [2] << 4) | (source [3] >> 4);
+		pti = (source [3] & 0x2) != 0;
+
+		vdbg ("udsl_extract_cells: vpi %hd, vci %d, pti %d", vpi, vci, pti);
+
+		if (cached_vcc && (vci == cached_vci) && (vpi == cached_vpi))
+			vcc_data = cached_vcc;
+		else if ((vcc_data = udsl_find_vcc (instance, vpi, vci))) {
+			cached_vcc = vcc_data;
+			cached_vpi = vpi;
+			cached_vci = vci;
 		} else {
-			vdbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc, vpi, vci);
+			dbg ("udsl_extract_cells: unknown vpi/vci (%hd/%d)!", vpi, vci);
+			continue;
+		}
 
-			if (skb->len >= 53) {
-				cell_payload = cell + 5;
+		vcc = vcc_data->vcc;
 
-				if (!vcc->skb)
-					vcc->skb = dev_alloc_skb (vcc->max_pdu);
+		if (!vcc_data->skb && !(vcc_data->skb = dev_alloc_skb (vcc_data->max_pdu))) {
+			dbg ("udsl_extract_cells: no memory for skb (vcc: 0x%p)!", vcc);
+			if (pti)
+				atomic_inc (&vcc->stats->rx_err);
+			continue;
+		}
 
-				/* if alloc fails, we just drop the cell. it is possible that we can still
-				 * receive cells on other vcc's
-				 */
-				if (vcc->skb) {
-					/* if (buffer overrun) discard received cells until now */
-					if ((vcc->skb->len) > (vcc->max_pdu - 48))
-						skb_trim (vcc->skb, 0);
-
-					/* copy data */
-					memcpy (vcc->skb->tail, cell_payload, 48);
-					skb_put (vcc->skb, 48);
-
-					/* check for end of buffer */
-					if (cell [3] & 0x2) {
-						struct sk_buff *tmp;
-
-						/* the aal5 buffer ends here, cut the buffer. */
-						/* buffer will always have at least one whole cell, so */
-						/* don't need to check return from skb_pull */
-						skb_pull (skb, 53);
-						*ctx = vcc;
-						tmp = vcc->skb;
-						vcc->skb = NULL;
-
-						vdbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
-						return tmp;
-					}
-				}
-				/* flush the cell */
-				/* buffer will always contain at least one whole cell, so don't */
-				/* need to check return value from skb_pull */
-				skb_pull (skb, 53);
-			} else {
-				/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
-				__skb_pull (skb, skb->len);
-				return NULL;
-			}
+		skb = vcc_data->skb;
+
+		if (skb->len + ATM_CELL_PAYLOAD > vcc_data->max_pdu) {
+			dbg ("udsl_extract_cells: buffer overrun (max_pdu: %u, skb->len %u, vcc: 0x%p)", vcc_data->max_pdu, skb->len, vcc);
+			/* discard cells already received */
+			skb_trim (skb, 0);
+			BUG_ON (vcc_data->max_pdu < ATM_CELL_PAYLOAD);
 		}
-	}
 
-	return NULL;
-}
+		memcpy (skb->tail, source + ATM_CELL_HEADER, ATM_CELL_PAYLOAD);
+		__skb_put (skb, ATM_CELL_PAYLOAD);
 
-static struct sk_buff *udsl_decode_aal5 (struct udsl_vcc_data *ctx, struct sk_buff *skb)
-{
-	uint crc = 0xffffffff;
-	uint length, pdu_crc, pdu_length;
+		if (pti) {
+			length = (source [ATM_CELL_SIZE - 6] << 8) + source [ATM_CELL_SIZE - 5];
 
-	vdbg ("udsl_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
+			/* guard against overflow */
+			if (length > ATM_MAX_AAL5_PDU) {
+				dbg ("udsl_extract_cells: bogus length %u (vcc: 0x%p)", length, vcc);
+				goto drop;
+			}
 
-	if (skb->len && (skb->len % 48))
-		return NULL;
+			pdu_length = UDSL_NUM_CELLS (length) * ATM_CELL_PAYLOAD;
 
-	length = (skb->tail [-6] << 8) + skb->tail [-5];
-	pdu_crc =
-	    (skb->tail [-4] << 24) + (skb->tail [-3] << 16) + (skb->tail [-2] << 8) + skb->tail [-1];
-	pdu_length = ((length + 47 + 8) / 48) * 48;
+			if (skb->len < pdu_length) {
+				dbg ("udsl_extract_cells: bogus pdu_length %u (skb->len: %u, vcc: 0x%p)", pdu_length, skb->len, vcc);
+				goto drop;
+			}
 
-	vdbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d", skb->len, length, pdu_crc, pdu_length);
+			if (crc32_be (~0, skb->tail - pdu_length, pdu_length) != 0xc704dd7b) {
+				dbg ("udsl_extract_cells: packet failed crc check (vcc: 0x%p)", vcc);
+				goto drop;
+			}
 
-	/* is skb long enough ? */
-	if (skb->len < pdu_length) {
-		atomic_inc (&ctx->vcc->stats->rx_err);
-		return NULL;
-	}
+			if (!atm_charge (vcc, skb->truesize)) {
+				dbg ("udsl_extract_cells: failed atm_charge (skb->truesize: %u)", skb->truesize);
+				goto drop_no_stats; /* atm_charge increments rx_drop */
+			}
 
-	/* is skb too long ? */
-	if (skb->len > pdu_length) {
-		dbg ("udsl_decode_aal5: Warning: readjusting illegal size %d -> %d", skb->len, pdu_length);
-		/* buffer is too long. we can try to recover
-		 * if we discard the first part of the skb.
-		 * the crc will decide whether this was ok
-		 */
-		skb_pull (skb, skb->len - pdu_length);
-	}
+			/* now that we are sure to send the skb, it is ok to change skb->data */
+			if (skb->len > pdu_length)
+				skb_pull (skb, skb->len - pdu_length); /* discard initial junk */
 
-	crc = ~crc32_be (crc, skb->data, pdu_length - 4);
+			skb_trim (skb, length); /* drop zero padding and trailer */
 
-	/* check crc */
-	if (pdu_crc != crc) {
-		dbg ("udsl_decode_aal5: crc check failed!");
-		atomic_inc (&ctx->vcc->stats->rx_err);
-		return NULL;
-	}
+			atomic_inc (&vcc->stats->rx);
 
-	/* pdu is ok */
-	skb_trim (skb, length);
+			PACKETDEBUG (skb->data, skb->len);
+
+			vdbg ("udsl_extract_cells: sending skb 0x%p, skb->len %u, skb->truesize %u", skb, skb->len, skb->truesize);
+
+			vcc->push (vcc, skb);
+
+			vcc_data->skb = NULL;
 
-	/* update stats */
-	atomic_inc (&ctx->vcc->stats->rx);
+			continue;
 
-	vdbg ("udsl_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
-	return skb;
+drop:
+			atomic_inc (&vcc->stats->rx_err);
+drop_no_stats:
+			skb_trim (skb, 0);
+		}
+	}
 }
 
 
@@ -500,145 +484,89 @@
 
 static void udsl_complete_receive (struct urb *urb, struct pt_regs *regs)
 {
+	struct udsl_receive_buffer *buf;
 	struct udsl_instance_data *instance;
 	struct udsl_receiver *rcv;
 	unsigned long flags;
 
-	if (!urb || !(rcv = urb->context) || !(instance = rcv->instance)) {
+	if (!urb || !(rcv = urb->context)) {
 		dbg ("udsl_complete_receive: bad urb!");
 		return;
 	}
 
-	vdbg ("udsl_complete_receive entered (urb 0x%p, status %d)", urb, urb->status);
+	instance = rcv->instance;
+	buf = rcv->buffer;
+
+	buf->filled_cells = urb->actual_length / ATM_CELL_SIZE;
+
+	vdbg ("udsl_complete_receive: urb 0x%p, status %d, actual_length %d, filled_cells %u, rcv 0x%p, buf 0x%p", urb, urb->status, urb->actual_length, buf->filled_cells, rcv, buf);
+
+	BUG_ON (buf->filled_cells > UDSL_RCV_BUF_SIZE);
 
 	/* may not be in_interrupt() */
-	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
-	list_add_tail (&rcv->list, &instance->completed_receivers);
-	tasklet_schedule (&instance->receive_tasklet);
-	spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+	spin_lock_irqsave (&instance->receive_lock, flags);
+	list_add (&rcv->list, &instance->spare_receivers);
+	list_add_tail (&buf->list, &instance->filled_receive_buffers);
+	if (likely (!urb->status))
+		tasklet_schedule (&instance->receive_tasklet);
+	spin_unlock_irqrestore (&instance->receive_lock, flags);
 }
 
 static void udsl_process_receive (unsigned long data)
 {
+	struct udsl_receive_buffer *buf;
 	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
 	struct udsl_receiver *rcv;
-	unsigned char *data_start;
-	struct sk_buff *skb;
-	struct urb *urb;
-	struct udsl_vcc_data *atmsar_vcc = NULL;
-	struct sk_buff *new = NULL, *tmp = NULL;
 	int err;
 
-	vdbg ("udsl_process_receive entered");
-
-	spin_lock_irq (&instance->completed_receivers_lock);
-	while (!list_empty (&instance->completed_receivers)) {
-		rcv = list_entry (instance->completed_receivers.next, struct udsl_receiver, list);
-		list_del (&rcv->list);
-		spin_unlock_irq (&instance->completed_receivers_lock);
-
-		urb = rcv->urb;
-		vdbg ("udsl_process_receive: got packet %p with length %d and status %d", urb, urb->actual_length, urb->status);
-
-		switch (urb->status) {
-		case 0:
-			vdbg ("udsl_process_receive: processing urb with rcv %p, urb %p, skb %p", rcv, urb, rcv->skb);
-
-			/* update the skb structure */
-			skb = rcv->skb;
-			skb_trim (skb, 0);
-			skb_put (skb, urb->actual_length);
-			data_start = skb->data;
-
-			vdbg ("skb->len = %d", skb->len);
-			PACKETDEBUG (skb->data, skb->len);
-
-			while ((new = udsl_decode_rawcell (instance, skb, &atmsar_vcc))) {
-				vdbg ("(after cell processing)skb->len = %d", new->len);
-
-				tmp = new;
-				new = udsl_decode_aal5 (atmsar_vcc, new);
-
-				/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
-				if (new) {
-					vdbg ("(after aal5 decap) skb->len = %d", new->len);
-					if (new->len && atm_charge (atmsar_vcc->vcc, new->truesize)) {
-						PACKETDEBUG (new->data, new->len);
-						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
-					} else {
-						dbg
-						    ("dropping incoming packet : vcc->sk->rcvbuf = %d, skb->true_size = %d",
-						     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
-						dev_kfree_skb (new);
-					}
-				} else {
-					dbg ("udsl_decode_aal5 returned NULL!");
-					dev_kfree_skb (tmp);
-				}
-			}
-
-			/* restore skb */
-			skb_push (skb, skb->data - data_start);
-
-			usb_fill_bulk_urb (urb,
-					   instance->usb_dev,
-					   usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
-					   (unsigned char *) rcv->skb->data,
-					   UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE,
-					   udsl_complete_receive,
-					   rcv);
-			if (!(err = usb_submit_urb (urb, GFP_ATOMIC)))
-				break;
-			dbg ("udsl_process_receive: submission failed (%d)", err);
-			/* fall through */
-		default: /* error or urb unlinked */
-			vdbg ("udsl_process_receive: adding to spare_receivers");
-			spin_lock_irq (&instance->spare_receivers_lock);
-			list_add (&rcv->list, &instance->spare_receivers);
-			spin_unlock_irq (&instance->spare_receivers_lock);
+made_progress:
+	while (!list_empty (&instance->spare_receive_buffers)) {
+		spin_lock_irq (&instance->receive_lock);
+		if (list_empty (&instance->spare_receivers)) {
+			spin_unlock_irq (&instance->receive_lock);
 			break;
-		} /* switch */
-
-		spin_lock_irq (&instance->completed_receivers_lock);
-	} /* while */
-	spin_unlock_irq (&instance->completed_receivers_lock);
-	vdbg ("udsl_process_receive successful");
-}
-
-static void udsl_fire_receivers (struct udsl_instance_data *instance)
-{
-	struct list_head receivers, *pos, *n;
-
-	INIT_LIST_HEAD (&receivers);
-
-	down (&instance->serialize);
-
-	spin_lock_irq (&instance->spare_receivers_lock);
-	list_splice_init (&instance->spare_receivers, &receivers);
-	spin_unlock_irq (&instance->spare_receivers_lock);
+		}
+		rcv = list_entry (instance->spare_receivers.next, struct udsl_receiver, list);
+		list_del (&rcv->list);
+		spin_unlock_irq (&instance->receive_lock);
 
-	list_for_each_safe (pos, n, &receivers) {
-		struct udsl_receiver *rcv = list_entry (pos, struct udsl_receiver, list);
+		buf = list_entry (instance->spare_receive_buffers.next, struct udsl_receive_buffer, list);
+		list_del (&buf->list);
 
-		dbg ("udsl_fire_receivers: firing urb %p", rcv->urb);
+		rcv->buffer = buf;
 
 		usb_fill_bulk_urb (rcv->urb,
 				   instance->usb_dev,
 				   usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
-				   (unsigned char *) rcv->skb->data,
+				   buf->base,
 				   UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE,
 				   udsl_complete_receive,
 				   rcv);
 
-		if (usb_submit_urb (rcv->urb, GFP_KERNEL) < 0) {
-			dbg ("udsl_fire_receivers: submit failed!");
-			spin_lock_irq (&instance->spare_receivers_lock);
-			list_move (pos, &instance->spare_receivers);
-			spin_unlock_irq (&instance->spare_receivers_lock);
+		vdbg ("udsl_process_receive: sending urb 0x%p, rcv 0x%p, buf 0x%p", rcv->urb, rcv, buf);
+
+		if ((err = usb_submit_urb(rcv->urb, GFP_ATOMIC)) < 0) {
+			dbg ("udsl_process_receive: urb submission failed (%d)!", err);
+			list_add (&buf->list, &instance->spare_receive_buffers);
+			spin_lock_irq (&instance->receive_lock);
+			list_add (&rcv->list, &instance->spare_receivers);
+			spin_unlock_irq (&instance->receive_lock);
+			break;
 		}
 	}
 
-	up (&instance->serialize);
+	spin_lock_irq (&instance->receive_lock);
+	if (list_empty (&instance->filled_receive_buffers)) {
+		spin_unlock_irq (&instance->receive_lock);
+		return; /* done - no more buffers */
+	}
+	buf = list_entry (instance->filled_receive_buffers.next, struct udsl_receive_buffer, list);
+	list_del (&buf->list);
+	spin_unlock_irq (&instance->receive_lock);
+	vdbg ("udsl_process_receive: processing buf 0x%p", buf);
+	udsl_extract_cells (instance, buf->base, buf->filled_cells);
+	list_add (&buf->list, &instance->spare_receive_buffers);
+	goto made_progress;
 }
 
 
@@ -839,6 +767,7 @@
 
 	dbg ("udsl_atm_dev_close: queue has %u elements", instance->sndqueue.qlen);
 
+	tasklet_kill (&instance->receive_tasklet);
 	tasklet_kill (&instance->send_tasklet);
 	kfree (instance);
 	dev->dev_data = NULL;
@@ -913,7 +842,7 @@
 		return -EINVAL;
 
 	/* only support AAL5 */
-	if (vcc->qos.aal != ATM_AAL5 || vcc->qos.rxtp.max_sdu < 0 || vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU)
+	if ((vcc->qos.aal != ATM_AAL5) || (vcc->qos.rxtp.max_sdu < 0) || (vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU))
 		return -EINVAL;
 
 	if (!instance->firmware_loaded) {
@@ -953,7 +882,7 @@
 
 	up (&instance->serialize);
 
-	udsl_fire_receivers (instance);
+	tasklet_schedule (&instance->receive_tasklet);
 
 	dbg ("udsl_atm_open: allocated vcc data 0x%p (max_pdu: %u)", new, new->max_pdu);
 
@@ -1029,7 +958,9 @@
 		instance->firmware_loaded = 1;
 	}
 	up (&instance->serialize);
-	udsl_fire_receivers (instance);
+
+	tasklet_schedule (&instance->receive_tasklet);
+
 	return 0;
 }
 
@@ -1089,13 +1020,12 @@
 
 	INIT_LIST_HEAD (&instance->vcc_list);
 
-	spin_lock_init (&instance->spare_receivers_lock);
+	spin_lock_init (&instance->receive_lock);
 	INIT_LIST_HEAD (&instance->spare_receivers);
-
-	spin_lock_init (&instance->completed_receivers_lock);
-	INIT_LIST_HEAD (&instance->completed_receivers);
+	INIT_LIST_HEAD (&instance->filled_receive_buffers);
 
 	tasklet_init (&instance->receive_tasklet, udsl_process_receive, (unsigned long) instance);
+	INIT_LIST_HEAD (&instance->spare_receive_buffers);
 
 	skb_queue_head_init (&instance->sndqueue);
 
@@ -1110,11 +1040,6 @@
 	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
 		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
-		if (!(rcv->skb = dev_alloc_skb (UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE))) {
-			dbg ("udsl_usb_probe: no memory for skb %d!", i);
-			goto fail;
-		}
-
 		if (!(rcv->urb = usb_alloc_urb (0, GFP_KERNEL))) {
 			dbg ("udsl_usb_probe: no memory for receive urb %d!", i);
 			goto fail;
@@ -1123,8 +1048,17 @@
 		rcv->instance = instance;
 
 		list_add (&rcv->list, &instance->spare_receivers);
+	}
 
-		dbg ("udsl_usb_probe: skb->truesize = %d (asked for %d)", rcv->skb->truesize, UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE);
+	for (i = 0; i < UDSL_NUM_RCV_BUFS; i++) {
+		struct udsl_receive_buffer *buf = &(instance->receive_buffers [i]);
+
+		if (!(buf->base = kmalloc (UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
+			dbg ("udsl_usb_probe: no memory for receive buffer %d!", i);
+			goto fail;
+		}
+
+		list_add (&buf->list, &instance->spare_receive_buffers);
 	}
 
 	/* send init */
@@ -1209,14 +1143,11 @@
 	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
 		usb_free_urb (instance->senders [i].urb);
 
-	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
-		struct udsl_receiver *rcv = &(instance->receivers [i]);
-
-		usb_free_urb (rcv->urb);
+	for (i = 0; i < UDSL_NUM_RCV_BUFS; i++)
+		kfree (instance->receive_buffers [i].base);
 
-		if (rcv->skb)
-			dev_kfree_skb (rcv->skb);
-	}
+	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
+		usb_free_urb (instance->receivers [i].urb);
 
 	kfree (instance);
 
@@ -1227,7 +1158,7 @@
 {
 	struct udsl_instance_data *instance = usb_get_intfdata (intf);
 	struct list_head *pos;
-	unsigned int count = 0;
+	unsigned int count;
 	int result, i;
 
 	dbg ("udsl_usb_disconnect entered");
@@ -1239,20 +1170,8 @@
 		return;
 	}
 
-	tasklet_disable (&instance->receive_tasklet);
-
 	/* receive finalize */
-	down (&instance->serialize); /* vs udsl_fire_receivers */
-	/* no need to take the spinlock */
-	list_for_each (pos, &instance->spare_receivers)
-		if (++count > UDSL_NUM_RCV_URBS)
-			panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
-	INIT_LIST_HEAD (&instance->spare_receivers);
-	up (&instance->serialize);
-
-	dbg ("udsl_usb_disconnect: flushed %u spare receivers", count);
-
-	count = UDSL_NUM_RCV_URBS - count;
+	tasklet_disable (&instance->receive_tasklet);
 
 	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
 		if ((result = usb_unlink_urb (instance->receivers [i].urb)) < 0)
@@ -1260,17 +1179,16 @@
 
 	/* wait for completion handlers to finish */
 	do {
-		unsigned int completed = 0;
-
-		spin_lock_irq (&instance->completed_receivers_lock);
-		list_for_each (pos, &instance->completed_receivers)
-			if (++completed > count)
+		count = 0;
+		spin_lock_irq (&instance->receive_lock);
+		list_for_each (pos, &instance->spare_receivers)
+			if (++count > UDSL_NUM_RCV_URBS)
 				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
-		spin_unlock_irq (&instance->completed_receivers_lock);
+		spin_unlock_irq (&instance->receive_lock);
 
-		dbg ("udsl_usb_disconnect: found %u completed receivers", completed);
+		dbg ("udsl_usb_disconnect: found %u spare receivers", count);
 
-		if (completed == count)
+		if (count == UDSL_NUM_RCV_URBS)
 			break;
 
 		set_current_state (TASK_RUNNING);
@@ -1278,17 +1196,16 @@
 	} while (1);
 
 	/* no need to take the spinlock */
-	INIT_LIST_HEAD (&instance->completed_receivers);
+	INIT_LIST_HEAD (&instance->filled_receive_buffers);
+	INIT_LIST_HEAD (&instance->spare_receive_buffers);
 
 	tasklet_enable (&instance->receive_tasklet);
-	tasklet_kill (&instance->receive_tasklet);
 
-	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
-		struct udsl_receiver *rcv = &(instance->receivers [i]);
+	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
+		usb_free_urb (instance->receivers [i].urb);
 
-		usb_free_urb (rcv->urb);
-		dev_kfree_skb (rcv->skb);
-	}
+	for (i = 0; i < UDSL_NUM_RCV_BUFS; i++)
+		kfree (instance->receive_buffers [i].base);
 
 	/* send finalize */
 	tasklet_disable (&instance->send_tasklet);
@@ -1332,7 +1249,7 @@
 	instance->usb_dev = NULL;
 
 	/* ATM finalize */
-	shutdown_atm_dev (instance->atm_dev); /* frees instance */
+	shutdown_atm_dev (instance->atm_dev); /* frees instance, kills tasklets */
 }
 
 

