Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTETWrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTETWrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:47:11 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:24123 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261411AbTETWqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:46:24 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 07/14] USB speedtouch: verbose debugging
Date: Wed, 21 May 2003 00:59:16 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210059.16534.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vdbg macro for verbose debugging, and convert some
noisy debugging statements to use it.

 speedtch.c |  133 +++++++++++++++++++++++++++----------------------------------
 1 files changed, 59 insertions(+), 74 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:31 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:31 2003
@@ -77,18 +77,20 @@
 #include <linux/init.h>
 
 /*
-#define DEBUG 1
-#define DEBUG_PACKET 1
+#define DEBUG
+#define VERBOSE_DEBUG
 */
 
 #include <linux/usb.h>
 
 
-#ifdef DEBUG_PACKET
+#ifdef VERBOSE_DEBUG
 static int udsl_print_packet (const unsigned char *data, int len);
-#define PACKETDEBUG(arg...) udsl_print_packet (arg)
+#define PACKETDEBUG(arg...)	udsl_print_packet (arg)
+#define vdbg(arg...)		dbg (arg)
 #else
 #define PACKETDEBUG(arg...)
+#define vdbg(arg...)
 #endif
 
 #define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@wanadoo.fr>"
@@ -279,8 +281,8 @@
 		vpi = ((cell [0] & 0x0f) << 4) | (cell [1] >> 4);
 		vci = ((cell [1] & 0x0f) << 12) | (cell [2] << 4) | (cell [3] >> 4);
 
-		dbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", instance, skb, ctx);
-		dbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
+		vdbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", instance, skb, ctx);
+		vdbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
 
 		/* here should the header CRC check be... */
 
@@ -288,7 +290,7 @@
 			dbg ("udsl_decode_rawcell: no vcc found for packet on vpi %d, vci %d", vpi, vci);
 			__skb_pull (skb, min (skb->len, (unsigned) 53));
 		} else {
-			dbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc, vpi, vci);
+			vdbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc, vpi, vci);
 
 			if (skb->len >= 53) {
 				cell_payload = cell + 5;
@@ -320,7 +322,7 @@
 						tmp = vcc->skb;
 						vcc->skb = NULL;
 
-						dbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
+						vdbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
 						return tmp;
 					}
 				}
@@ -344,7 +346,7 @@
 	uint crc = 0xffffffff;
 	uint length, pdu_crc, pdu_length;
 
-	dbg ("udsl_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
+	vdbg ("udsl_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
 
 	if (skb->len && (skb->len % 48))
 		return NULL;
@@ -354,7 +356,7 @@
 	    (skb->tail [-4] << 24) + (skb->tail [-3] << 16) + (skb->tail [-2] << 8) + skb->tail [-1];
 	pdu_length = ((length + 47 + 8) / 48) * 48;
 
-	dbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d", skb->len, length, pdu_crc, pdu_length);
+	vdbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d", skb->len, length, pdu_crc, pdu_length);
 
 	/* is skb long enough ? */
 	if (skb->len < pdu_length) {
@@ -390,7 +392,7 @@
 	if (ctx->vcc->stats)
 		atomic_inc (&ctx->vcc->stats->rx);
 
-	dbg ("udsl_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
+	vdbg ("udsl_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
 	return skb;
 }
 
@@ -446,7 +448,7 @@
 	unsigned char *target = *target_p;
 	unsigned int nc, ne, i;
 
-	dbg ("udsl_write_cells: howmany=%u, skb->len=%d, num_cells=%u, num_entire=%u, pdu_padding=%u", howmany, skb->len, ctrl->num_cells, ctrl->num_entire, ctrl->pdu_padding);
+	vdbg ("udsl_write_cells: howmany=%u, skb->len=%d, num_cells=%u, num_entire=%u, pdu_padding=%u", howmany, skb->len, ctrl->num_cells, ctrl->num_entire, ctrl->pdu_padding);
 
 	nc = ctrl->num_cells;
 	ne = min (howmany, ctrl->num_entire);
@@ -513,7 +515,7 @@
 		return;
 	}
 
-	dbg ("udsl_complete_receive entered (urb 0x%p, status %d)", urb, urb->status);
+	vdbg ("udsl_complete_receive entered (urb 0x%p, status %d)", urb, urb->status);
 
 	/* may not be in_interrupt() */
 	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
@@ -533,7 +535,7 @@
 	struct sk_buff *new = NULL, *tmp = NULL;
 	int err;
 
-	dbg ("udsl_process_receive entered");
+	vdbg ("udsl_process_receive entered");
 
 	spin_lock_irq (&instance->completed_receivers_lock);
 	while (!list_empty (&instance->completed_receivers)) {
@@ -542,11 +544,11 @@
 		spin_unlock_irq (&instance->completed_receivers_lock);
 
 		urb = rcv->urb;
-		dbg ("udsl_process_receive: got packet %p with length %d and status %d", urb, urb->actual_length, urb->status);
+		vdbg ("udsl_process_receive: got packet %p with length %d and status %d", urb, urb->actual_length, urb->status);
 
 		switch (urb->status) {
 		case 0:
-			dbg ("udsl_process_receive: processing urb with rcv %p, urb %p, skb %p", rcv, urb, rcv->skb);
+			vdbg ("udsl_process_receive: processing urb with rcv %p, urb %p, skb %p", rcv, urb, rcv->skb);
 
 			/* update the skb structure */
 			skb = rcv->skb;
@@ -554,18 +556,18 @@
 			skb_put (skb, urb->actual_length);
 			data_start = skb->data;
 
-			dbg ("skb->len = %d", skb->len);
+			vdbg ("skb->len = %d", skb->len);
 			PACKETDEBUG (skb->data, skb->len);
 
 			while ((new = udsl_decode_rawcell (instance, skb, &atmsar_vcc))) {
-				dbg ("(after cell processing)skb->len = %d", new->len);
+				vdbg ("(after cell processing)skb->len = %d", new->len);
 
 				tmp = new;
 				new = udsl_decode_aal5 (atmsar_vcc, new);
 
 				/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
 				if (new) {
-					dbg ("(after aal5 decap) skb->len = %d", new->len);
+					vdbg ("(after aal5 decap) skb->len = %d", new->len);
 					if (new->len && atm_charge (atmsar_vcc->vcc, new->truesize)) {
 						PACKETDEBUG (new->data, new->len);
 						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
@@ -596,7 +598,7 @@
 			dbg ("udsl_process_receive: submission failed (%d)", err);
 			/* fall through */
 		default: /* error or urb unlinked */
-			dbg ("udsl_process_receive: adding to spare_receivers");
+			vdbg ("udsl_process_receive: adding to spare_receivers");
 			spin_lock_irq (&instance->spare_receivers_lock);
 			list_add (&rcv->list, &instance->spare_receivers);
 			spin_unlock_irq (&instance->spare_receivers_lock);
@@ -606,7 +608,7 @@
 		spin_lock_irq (&instance->completed_receivers_lock);
 	} /* while */
 	spin_unlock_irq (&instance->completed_receivers_lock);
-	dbg ("udsl_process_receive successful");
+	vdbg ("udsl_process_receive successful");
 }
 
 static void udsl_fire_receivers (struct udsl_instance_data *instance)
@@ -661,7 +663,7 @@
 		return;
 	}
 
-	dbg ("udsl_complete_send entered (urb 0x%p, status %d)", urb, urb->status);
+	vdbg ("udsl_complete_send: urb 0x%p, status %d, snd 0x%p, buf 0x%p", urb, urb->status, snd, snd->buffer);
 
 	/* may not be in_interrupt() */
 	spin_lock_irqsave (&instance->send_lock, flags);
@@ -680,18 +682,14 @@
 	struct sk_buff *skb;
 	struct udsl_sender *snd;
 
-	dbg ("udsl_process_send entered");
-
 made_progress:
 	spin_lock_irq (&instance->send_lock);
 	while (!list_empty (&instance->spare_senders)) {
 		if (!list_empty (&instance->filled_send_buffers)) {
 			buf = list_entry (instance->filled_send_buffers.next, struct udsl_send_buffer, list);
 			list_del (&buf->list);
-			dbg ("sending filled buffer (0x%p)", buf);
 		} else if ((buf = instance->current_buffer)) {
 			instance->current_buffer = NULL;
-			dbg ("sending current buffer (0x%p)", buf);
 		} else /* all buffers empty */
 			break;
 
@@ -708,10 +706,10 @@
 				   udsl_complete_send,
 				   snd);
 
-		dbg ("submitting urb 0x%p, contains %d cells", snd->urb, UDSL_SND_BUF_SIZE - buf->free_cells);
+		vdbg ("udsl_process_send: submitting urb 0x%p (%d cells), snd 0x%p, buf 0x%p", snd->urb, UDSL_SND_BUF_SIZE - buf->free_cells, snd, buf);
 
 		if ((err = usb_submit_urb(snd->urb, GFP_ATOMIC)) < 0) {
-			dbg ("submission failed (%d)!", err);
+			dbg ("udsl_process_send: urb submission failed (%d)!", err);
 			spin_lock_irq (&instance->send_lock);
 			list_add (&snd->list, &instance->spare_senders);
 			spin_unlock_irq (&instance->send_lock);
@@ -724,8 +722,7 @@
 	spin_unlock_irq (&instance->send_lock);
 
 	if (!instance->current_skb && !(instance->current_skb = skb_dequeue (&instance->sndqueue))) {
-		dbg ("done - no more skbs");
-		return;
+		return; /* done - no more skbs */
 	}
 
 	skb = instance->current_skb;
@@ -735,8 +732,7 @@
 		if (list_empty (&instance->spare_send_buffers)) {
 			instance->current_buffer = NULL;
 			spin_unlock_irq (&instance->send_lock);
-			dbg ("done - no more buffers");
-			return;
+			return; /* done - no more buffers */
 		}
 		buf = list_entry (instance->spare_send_buffers.next, struct udsl_send_buffer, list);
 		list_del (&buf->list);
@@ -750,20 +746,18 @@
 
 	num_written = udsl_write_cells (buf->free_cells, skb, &buf->free_start);
 
-	dbg ("wrote %u cells from skb 0x%p to buffer 0x%p", num_written, skb, buf);
+	vdbg ("udsl_process_send: wrote %u cells from skb 0x%p to buffer 0x%p", num_written, skb, buf);
 
 	if (!(buf->free_cells -= num_written)) {
 		list_add_tail (&buf->list, &instance->filled_send_buffers);
 		instance->current_buffer = NULL;
-		dbg ("queued filled buffer");
 	}
 
-	dbg ("buffer contains %d cells, %d left", UDSL_SND_BUF_SIZE - buf->free_cells, buf->free_cells);
+	vdbg ("udsl_process_send: buffer contains %d cells, %d left", UDSL_SND_BUF_SIZE - buf->free_cells, buf->free_cells);
 
 	if (!UDSL_SKB (skb)->num_cells) {
 		struct atm_vcc *vcc = UDSL_SKB (skb)->atm_data.vcc;
 
-		dbg ("discarding empty skb");
 		if (vcc->pop)
 			vcc->pop (vcc, skb);
 		else
@@ -785,7 +779,7 @@
 	spin_lock_irq (&instance->sndqueue.lock);
 	for (skb = instance->sndqueue.next, n = skb->next; skb != (struct sk_buff *)&instance->sndqueue; skb = n, n = skb->next)
 		if (UDSL_SKB (skb)->atm_data.vcc == vcc) {
-			dbg ("popping skb 0x%p", skb);
+			dbg ("udsl_cancel_send: popping skb 0x%p", skb);
 			__skb_unlink (skb, &instance->sndqueue);
 			if (vcc->pop)
 				vcc->pop (vcc, skb);
@@ -796,7 +790,7 @@
 
 	tasklet_disable (&instance->send_tasklet);
 	if ((skb = instance->current_skb) && (UDSL_SKB (skb)->atm_data.vcc == vcc)) {
-		dbg ("popping current skb (0x%p)", skb);
+		dbg ("udsl_cancel_send: popping current skb (0x%p)", skb);
 		instance->current_skb = NULL;
 		if (vcc->pop)
 			vcc->pop (vcc, skb);
@@ -811,10 +805,10 @@
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
 
-	dbg ("udsl_atm_send called (skb 0x%p, len %u)", skb, skb->len);
+	vdbg ("udsl_atm_send called (skb 0x%p, len %u)", skb, skb->len);
 
 	if (!instance || !instance->usb_dev) {
-		dbg ("NULL data!");
+		dbg ("udsl_atm_send: NULL data!");
 		return -ENODEV;
 	}
 
@@ -822,12 +816,12 @@
 		return -EAGAIN;
 
 	if (vcc->qos.aal != ATM_AAL5) {
-		dbg ("unsupported ATM type %d!", vcc->qos.aal);
+		dbg ("udsl_atm_send: unsupported ATM type %d!", vcc->qos.aal);
 		return -EINVAL;
 	}
 
 	if (skb->len > ATM_MAX_AAL5_PDU) {
-		dbg ("packet too long (%d vs %d)!", skb->len, ATM_MAX_AAL5_PDU);
+		dbg ("udsl_atm_send: packet too long (%d vs %d)!", skb->len, ATM_MAX_AAL5_PDU);
 		return -EINVAL;
 	}
 
@@ -856,9 +850,7 @@
 
 	dbg ("udsl_atm_dev_close: queue has %u elements", instance->sndqueue.qlen);
 
-	dbg ("udsl_atm_dev_close: killing tasklet");
 	tasklet_kill (&instance->send_tasklet);
-	dbg ("udsl_atm_dev_close: freeing instance");
 	kfree (instance);
 	dev->dev_data = NULL;
 }
@@ -869,7 +861,7 @@
 	int left = *pos;
 
 	if (!instance) {
-		dbg ("NULL instance!");
+		dbg ("udsl_atm_proc_read: NULL instance!");
 		return -ENODEV;
 	}
 
@@ -921,10 +913,10 @@
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
 	struct udsl_vcc_data *new;
 
-	dbg ("udsl_atm_open called");
+	dbg ("udsl_atm_open: vpi %hd, vci %d", vpi, vci);
 
 	if (!instance || !instance->usb_dev) {
-		dbg ("NULL data!");
+		dbg ("udsl_atm_open: NULL data!");
 		return -ENODEV;
 	}
 
@@ -936,7 +928,7 @@
 		return -EINVAL;
 
 	if (!instance->firmware_loaded) {
-		dbg ("firmware not loaded!");
+		dbg ("udsl_atm_open: firmware not loaded!");
 		return -EAGAIN;
 	}
 
@@ -972,11 +964,9 @@
 
 	up (&instance->serialize);
 
-	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
-
 	udsl_fire_receivers (instance);
 
-	dbg ("udsl_atm_open successful");
+	dbg ("udsl_atm_open: allocated vcc data 0x%p (max_pdu: %u)", new, new->max_pdu);
 
 	return 0;
 }
@@ -989,11 +979,11 @@
 	dbg ("udsl_atm_close called");
 
 	if (!instance || !vcc_data) {
-		dbg ("NULL data!");
+		dbg ("udsl_atm_close: NULL data!");
 		return;
 	}
 
-	dbg ("Deallocating SARLib vcc 0x%p with vpi %d vci %d", vcc_data, vcc_data->vpi, vcc_data->vci);
+	dbg ("udsl_atm_close: deallocating vcc 0x%p with vpi %d vci %d", vcc_data, vcc_data->vpi, vcc_data->vci);
 
 	udsl_cancel_send (instance, vcc);
 
@@ -1043,7 +1033,7 @@
 		int ret;
 
 		if ((ret = usb_set_interface (instance->usb_dev, 1, 1)) < 0) {
-			dbg ("usb_set_interface returned %d!", ret);
+			dbg ("udsl_set_alternate: usb_set_interface returned %d!", ret);
 			up (&instance->serialize);
 			return ret;
 		}
@@ -1061,7 +1051,7 @@
 	dbg ("udsl_usb_ioctl entered");
 
 	if (!instance) {
-		dbg ("NULL instance!");
+		dbg ("udsl_usb_ioctl: NULL instance!");
 		return -ENODEV;
 	}
 
@@ -1086,19 +1076,19 @@
 	int i, length;
 	char *buf;
 
-	dbg ("Trying device with Vendor=0x%x, Product=0x%x, ifnum %d",
-		dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum);
+	dbg ("udsl_usb_probe: trying device with vendor=0x%x, product=0x%x, ifnum %d",
+	     dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum);
 
 	if ((dev->descriptor.bDeviceClass != USB_CLASS_VENDOR_SPEC) ||
 	    (dev->descriptor.idVendor != SPEEDTOUCH_VENDORID) ||
 	    (dev->descriptor.idProduct != SPEEDTOUCH_PRODUCTID) || (ifnum != 1))
 		return -ENODEV;
 
-	dbg ("Device Accepted");
+	dbg ("udsl_usb_probe: device accepted");
 
 	/* instance init */
 	if (!(instance = kmalloc (sizeof (struct udsl_instance_data), GFP_KERNEL))) {
-		dbg ("No memory for Instance data!");
+		dbg ("udsl_usb_probe: no memory for instance data!");
 		return -ENOMEM;
 	}
 
@@ -1132,12 +1122,12 @@
 		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
 		if (!(rcv->skb = dev_alloc_skb (UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE))) {
-			dbg ("No memory for skb %d!", i);
+			dbg ("udsl_usb_probe: no memory for skb %d!", i);
 			goto fail;
 		}
 
 		if (!(rcv->urb = usb_alloc_urb (0, GFP_KERNEL))) {
-			dbg ("No memory for receive urb %d!", i);
+			dbg ("udsl_usb_probe: no memory for receive urb %d!", i);
 			goto fail;
 		}
 
@@ -1145,7 +1135,7 @@
 
 		list_add (&rcv->list, &instance->spare_receivers);
 
-		dbg ("skb->truesize = %d (asked for %d)", rcv->skb->truesize, UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE);
+		dbg ("udsl_usb_probe: skb->truesize = %d (asked for %d)", rcv->skb->truesize, UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE);
 	}
 
 	/* send init */
@@ -1153,7 +1143,7 @@
 		struct udsl_sender *snd = &(instance->senders [i]);
 
 		if (!(snd->urb = usb_alloc_urb (0, GFP_KERNEL))) {
-			dbg ("No memory for send urb %d!", i);
+			dbg ("udsl_usb_probe: no memory for send urb %d!", i);
 			goto fail;
 		}
 
@@ -1166,7 +1156,7 @@
 		struct udsl_send_buffer *buf = &(instance->send_buffers [i]);
 
 		if (!(buf->base = kmalloc (UDSL_SND_BUF_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
-			dbg ("No memory for send buffer %d!", i);
+			dbg ("udsl_usb_probe: no memory for send buffer %d!", i);
 			goto fail;
 		}
 
@@ -1175,7 +1165,7 @@
 
 	/* ATM init */
 	if (!(instance->atm_dev = atm_dev_register (udsl_driver_name, &udsl_atm_devops, -1, 0))) {
-		dbg ("failed to register ATM device!");
+		dbg ("udsl_usb_probe: failed to register ATM device!");
 		goto fail;
 	}
 
@@ -1251,12 +1241,12 @@
 	unsigned int count = 0;
 	int result, i;
 
-	dbg ("disconnecting");
+	dbg ("udsl_usb_disconnect entered");
 
 	usb_set_intfdata (intf, NULL);
 
 	if (!instance) {
-		dbg ("NULL instance!");
+		dbg ("udsl_usb_disconnect: NULL instance!");
 		return;
 	}
 
@@ -1298,14 +1288,12 @@
 		schedule ();
 	} while (1);
 
-	dbg ("udsl_usb_disconnect: flushing");
 	/* no need to take the spinlock */
 	INIT_LIST_HEAD (&instance->completed_receivers);
 
 	tasklet_enable (&instance->receive_tasklet);
 	tasklet_kill (&instance->receive_tasklet);
 
-	dbg ("udsl_usb_disconnect: freeing receivers");
 	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
 		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
@@ -1338,7 +1326,6 @@
 		schedule ();
 	} while (1);
 
-	dbg ("udsl_usb_disconnect: flushing");
 	/* no need to take the spinlock */
 	INIT_LIST_HEAD (&instance->spare_senders);
 	INIT_LIST_HEAD (&instance->spare_send_buffers);
@@ -1346,11 +1333,9 @@
 
 	tasklet_enable (&instance->send_tasklet);
 
-	dbg ("udsl_usb_disconnect: freeing senders");
 	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
 		usb_free_urb (instance->senders [i].urb);
 
-	dbg ("udsl_usb_disconnect: freeing buffers");
 	for (i = 0; i < UDSL_NUM_SND_BUFS; i++)
 		kfree (instance->send_buffers [i].base);
 
@@ -1382,7 +1367,7 @@
 
 static void __exit udsl_usb_cleanup (void)
 {
-	dbg ("udsl_usb_cleanup");
+	dbg ("udsl_usb_cleanup entered");
 
 	usb_deregister (&udsl_usb_driver);
 }
@@ -1399,7 +1384,7 @@
 **  debug  **
 ************/
 
-#ifdef DEBUG_PACKET
+#ifdef VERBOSE_DEBUG
 static int udsl_print_packet (const unsigned char *data, int len)
 {
 	unsigned char buffer [256];

