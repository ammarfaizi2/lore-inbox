Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTETWkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTETWkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:40:02 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:25902 "EHLO
	mwinf0103.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261222AbTETWjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:39:49 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 02/14] USB speedtouch: trivial whitespace and name changes
Date: Wed, 21 May 2003 00:52:42 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210052.42399.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No real code changes.

 speedtch.c |  242 +++++++++++++++++++++++++++++--------------------------------
 1 files changed, 117 insertions(+), 125 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:00 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:00 2003
@@ -1,7 +1,8 @@
 /******************************************************************************
- *  speedtouch.c  --  Alcatel SpeedTouch USB xDSL modem driver.
+ *  speedtouch.c  -  Alcatel SpeedTouch USB xDSL modem driver
  *
  *  Copyright (C) 2001, Alcatel
+ *  Copyright (C) 2003, Duncan Sands
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the Free
@@ -40,7 +41,6 @@
  *		udsl_usb_send_data_context->urb to a pointer and adding code
  *		to alloc and free it
  *		- remove_wait_queue() added to udsl_atm_processqueue_thread()
- *		- Duncan Sands (duncan.sands@wanadoo.fr) is the new maintainer
  *
  *  1.5:	- fixed memory leak when atmsar_decode_aal5 returned NULL.
  *		(reported by stephen.robinson@zen.co.uk)
@@ -95,40 +95,38 @@
 #define DRIVER_DESC	"Alcatel SpeedTouch USB driver"
 #define DRIVER_VERSION	"1.6"
 
+static const char udsl_driver_name [] = "speedtch";
+
 #define SPEEDTOUCH_VENDORID		0x06b9
 #define SPEEDTOUCH_PRODUCTID		0x4061
 
-#define UDSL_NUMBER_RCV_URBS		1
-#define UDSL_NUMBER_SND_URBS		1
-#define UDSL_NUMBER_SND_BUFS		(2*UDSL_NUMBER_SND_URBS)
-#define UDSL_RCV_BUFFER_SIZE		(1*64) /* ATM cells */
-#define UDSL_SND_BUFFER_SIZE		(1*64) /* ATM cells */
+#define UDSL_NUM_RCV_URBS		1
+#define UDSL_NUM_SND_URBS		1
+#define UDSL_NUM_SND_BUFS		(2*UDSL_NUM_SND_URBS)
+#define UDSL_RCV_BUF_SIZE		64 /* ATM cells */
+#define UDSL_SND_BUF_SIZE		64 /* ATM cells */
 /* max should be (1500 IP mtu + 2 ppp bytes + 32 * 5 cellheader overhead) for
  * PPPoA and (1500 + 14 + 32*5 cellheader overhead) for PPPoE */
 #define UDSL_MAX_AAL5_MRU		2048
 
-#define UDSL_IOCTL_START		1
-#define UDSL_IOCTL_STOP			2
-
-/* endpoint declarations */
+#define UDSL_IOCTL_LINE_UP		1
+#define UDSL_IOCTL_LINE_DOWN		2
 
 #define UDSL_ENDPOINT_DATA_OUT		0x07
 #define UDSL_ENDPOINT_DATA_IN		0x87
 
 #define ATM_CELL_HEADER			(ATM_CELL_SIZE - ATM_CELL_PAYLOAD)
 
-#define hex2int(c) ( (c >= '0')&&(c <= '9') ?  (c - '0') : ((c & 0xf)+9) )
-
-/* usb_device_id struct */
+#define hex2int(c) ( (c >= '0') && (c <= '9') ? (c - '0') : ((c & 0xf) + 9) )
 
 static struct usb_device_id udsl_usb_ids [] = {
 	{ USB_DEVICE (SPEEDTOUCH_VENDORID, SPEEDTOUCH_PRODUCTID) },
-	{ }			/* Terminating entry */
+	{ }
 };
 
 MODULE_DEVICE_TABLE (usb, udsl_usb_ids);
 
-/* context declarations */
+/* receive */
 
 struct udsl_receiver {
 	struct list_head list;
@@ -137,6 +135,20 @@
 	struct udsl_instance_data *instance;
 };
 
+struct udsl_vcc_data {
+	/* vpi/vci lookup */
+	struct list_head list;
+	short vpi;
+	int vci;
+	struct atm_vcc *vcc;
+
+	/* raw cell reassembly */
+	struct sk_buff *skb;
+	unsigned short max_pdu;
+};
+
+/* send */
+
 struct udsl_send_buffer {
 	struct list_head list;
 	unsigned char *base;
@@ -162,36 +174,22 @@
 
 #define UDSL_SKB(x)		((struct udsl_control *)(x)->cb)
 
-struct udsl_vcc_data {
-	/* vpi/vci lookup */
-	struct list_head list;
-	short vpi;
-	int vci;
-	struct atm_vcc *vcc;
-
-	/* raw cell reassembly */
-	unsigned short mtu;
-	struct sk_buff *reasBuffer;
-};
-
-/*
- * UDSL main driver data
- */
+/* main driver data */
 
 struct udsl_instance_data {
 	struct semaphore serialize;
 
-	/* usb device part */
+	/* USB device part */
 	struct usb_device *usb_dev;
 	char description [64];
 	int firmware_loaded;
 
-	/* atm device part */
+	/* ATM device part */
 	struct atm_dev *atm_dev;
 	struct list_head vcc_list;
 
-	/* receiving */
-	struct udsl_receiver all_receivers [UDSL_NUMBER_RCV_URBS];
+	/* receive */
+	struct udsl_receiver receivers [UDSL_NUM_RCV_URBS];
 
 	spinlock_t spare_receivers_lock;
 	struct list_head spare_receivers;
@@ -201,27 +199,23 @@
 
 	struct tasklet_struct receive_tasklet;
 
-	/* sending */
-	struct udsl_sender all_senders [UDSL_NUMBER_SND_URBS];
-	struct udsl_send_buffer all_buffers [UDSL_NUMBER_SND_BUFS];
+	/* send */
+	struct udsl_sender senders [UDSL_NUM_SND_URBS];
+	struct udsl_send_buffer send_buffers [UDSL_NUM_SND_BUFS];
 
 	struct sk_buff_head sndqueue;
 
 	spinlock_t send_lock;
 	struct list_head spare_senders;
-	struct list_head spare_buffers;
+	struct list_head spare_send_buffers;
 
 	struct tasklet_struct send_tasklet;
 	struct sk_buff *current_skb;			/* being emptied */
 	struct udsl_send_buffer *current_buffer;	/* being filled */
-	struct list_head filled_buffers;
+	struct list_head filled_send_buffers;
 };
 
-static const char udsl_driver_name [] = "speedtch";
-
-/*
- * atm driver prototypes and structures
- */
+/* ATM */
 
 static void udsl_atm_dev_close (struct atm_dev *dev);
 static int udsl_atm_open (struct atm_vcc *vcc, short vpi, int vci);
@@ -239,11 +233,9 @@
 	.proc_read =	udsl_atm_proc_read,
 };
 
-/*
- * usb driver prototypes and structures
- */
-static int udsl_usb_probe (struct usb_interface *intf,
-			   const struct usb_device_id *id);
+/* USB */
+
+static int udsl_usb_probe (struct usb_interface *intf, const struct usb_device_id *id);
 static void udsl_usb_disconnect (struct usb_interface *intf);
 static int udsl_usb_ioctl (struct usb_interface *intf, unsigned int code, void *user_data);
 
@@ -284,8 +276,8 @@
 		short vpi;
 		int vci;
 
-		vpi = ((cell[0] & 0x0f) << 4) | (cell[1] >> 4);
-		vci = ((cell[1] & 0x0f) << 12) | (cell[2] << 4) | (cell[3] >> 4);
+		vpi = ((cell [0] & 0x0f) << 4) | (cell [1] >> 4);
+		vci = ((cell [1] & 0x0f) << 12) | (cell [2] << 4) | (cell [3] >> 4);
 
 		dbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", instance, skb, ctx);
 		dbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
@@ -301,23 +293,23 @@
 			if (skb->len >= 53) {
 				cell_payload = cell + 5;
 
-				if (!vcc->reasBuffer)
-					vcc->reasBuffer = dev_alloc_skb (vcc->mtu);
+				if (!vcc->skb)
+					vcc->skb = dev_alloc_skb (vcc->max_pdu);
 
 				/* if alloc fails, we just drop the cell. it is possible that we can still
 				 * receive cells on other vcc's
 				 */
-				if (vcc->reasBuffer) {
+				if (vcc->skb) {
 					/* if (buffer overrun) discard received cells until now */
-					if ((vcc->reasBuffer->len) > (vcc->mtu - 48))
-						skb_trim (vcc->reasBuffer, 0);
+					if ((vcc->skb->len) > (vcc->max_pdu - 48))
+						skb_trim (vcc->skb, 0);
 
 					/* copy data */
-					memcpy (vcc->reasBuffer->tail, cell_payload, 48);
-					skb_put (vcc->reasBuffer, 48);
+					memcpy (vcc->skb->tail, cell_payload, 48);
+					skb_put (vcc->skb, 48);
 
 					/* check for end of buffer */
-					if (cell[3] & 0x2) {
+					if (cell [3] & 0x2) {
 						struct sk_buff *tmp;
 
 						/* the aal5 buffer ends here, cut the buffer. */
@@ -325,8 +317,8 @@
 						/* don't need to check return from skb_pull */
 						skb_pull (skb, 53);
 						*ctx = vcc;
-						tmp = vcc->reasBuffer;
-						vcc->reasBuffer = NULL;
+						tmp = vcc->skb;
+						vcc->skb = NULL;
 
 						dbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
 						return tmp;
@@ -357,9 +349,9 @@
 	if (skb->len && (skb->len % 48))
 		return NULL;
 
-	length = (skb->tail[-6] << 8) + skb->tail[-5];
+	length = (skb->tail [-6] << 8) + skb->tail [-5];
 	pdu_crc =
-	    (skb->tail[-4] << 24) + (skb->tail[-3] << 16) + (skb->tail[-2] << 8) + skb->tail[-1];
+	    (skb->tail [-4] << 24) + (skb->tail [-3] << 16) + (skb->tail [-2] << 8) + skb->tail [-1];
 	pdu_length = ((length + 47 + 8) / 48) * 48;
 
 	dbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d", skb->len, length, pdu_crc, pdu_length);
@@ -407,7 +399,7 @@
 **  encode  **
 *************/
 
-static const unsigned char zeros[ATM_CELL_PAYLOAD];
+static const unsigned char zeros [ATM_CELL_PAYLOAD];
 
 static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
 {
@@ -597,7 +589,7 @@
 					   instance->usb_dev,
 					   usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
 					   (unsigned char *) rcv->skb->data,
-					   UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE,
+					   UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE,
 					   udsl_complete_receive,
 					   rcv);
 			if (!(err = usb_submit_urb (urb, GFP_ATOMIC)))
@@ -640,7 +632,7 @@
 				   instance->usb_dev,
 				   usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
 				   (unsigned char *) rcv->skb->data,
-				   UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE,
+				   UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE,
 				   udsl_complete_receive,
 				   rcv);
 
@@ -676,7 +668,7 @@
 	/* may not be in_interrupt() */
 	spin_lock_irqsave (&instance->send_lock, flags);
 	list_add (&snd->list, &instance->spare_senders);
-	list_add (&snd->buffer->list, &instance->spare_buffers);
+	list_add (&snd->buffer->list, &instance->spare_send_buffers);
 	tasklet_schedule (&instance->send_tasklet);
 	spin_unlock_irqrestore (&instance->send_lock, flags);
 }
@@ -696,8 +688,8 @@
 made_progress:
 	spin_lock_irqsave (&instance->send_lock, flags);
 	while (!list_empty (&instance->spare_senders)) {
-		if (!list_empty (&instance->filled_buffers)) {
-			buf = list_entry (instance->filled_buffers.next, struct udsl_send_buffer, list);
+		if (!list_empty (&instance->filled_send_buffers)) {
+			buf = list_entry (instance->filled_send_buffers.next, struct udsl_send_buffer, list);
 			list_del (&buf->list);
 			dbg ("sending filled buffer (0x%p)", buf);
 		} else if ((buf = instance->current_buffer)) {
@@ -715,18 +707,18 @@
 				   instance->usb_dev,
 				   usb_sndbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_OUT),
 				   buf->base,
-				   (UDSL_SND_BUFFER_SIZE - buf->free_cells) * ATM_CELL_SIZE,
+				   (UDSL_SND_BUF_SIZE - buf->free_cells) * ATM_CELL_SIZE,
 				   udsl_complete_send,
 				   snd);
 
-		dbg ("submitting urb 0x%p, contains %d cells", snd->urb, UDSL_SND_BUFFER_SIZE - buf->free_cells);
+		dbg ("submitting urb 0x%p, contains %d cells", snd->urb, UDSL_SND_BUF_SIZE - buf->free_cells);
 
 		if ((err = usb_submit_urb(snd->urb, GFP_ATOMIC)) < 0) {
 			dbg ("submission failed (%d)!", err);
 			spin_lock_irqsave (&instance->send_lock, flags);
 			list_add (&snd->list, &instance->spare_senders);
 			spin_unlock_irqrestore (&instance->send_lock, flags);
-			list_add (&buf->list, &instance->filled_buffers);
+			list_add (&buf->list, &instance->filled_send_buffers);
 			return;
 		}
 
@@ -743,18 +735,18 @@
 
 	if (!(buf = instance->current_buffer)) {
 		spin_lock_irqsave (&instance->send_lock, flags);
-		if (list_empty (&instance->spare_buffers)) {
+		if (list_empty (&instance->spare_send_buffers)) {
 			instance->current_buffer = NULL;
 			spin_unlock_irqrestore (&instance->send_lock, flags);
 			dbg ("done - no more buffers");
 			return;
 		}
-		buf = list_entry (instance->spare_buffers.next, struct udsl_send_buffer, list);
+		buf = list_entry (instance->spare_send_buffers.next, struct udsl_send_buffer, list);
 		list_del (&buf->list);
 		spin_unlock_irqrestore (&instance->send_lock, flags);
 
 		buf->free_start = buf->base;
-		buf->free_cells = UDSL_SND_BUFFER_SIZE;
+		buf->free_cells = UDSL_SND_BUF_SIZE;
 
 		instance->current_buffer = buf;
 	}
@@ -764,12 +756,12 @@
 	dbg ("wrote %u cells from skb 0x%p to buffer 0x%p", num_written, skb, buf);
 
 	if (!(buf->free_cells -= num_written)) {
-		list_add_tail (&buf->list, &instance->filled_buffers);
+		list_add_tail (&buf->list, &instance->filled_send_buffers);
 		instance->current_buffer = NULL;
 		dbg ("queued filled buffer");
 	}
 
-	dbg ("buffer contains %d cells, %d left", UDSL_SND_BUFFER_SIZE - buf->free_cells, buf->free_cells);
+	dbg ("buffer contains %d cells, %d left", UDSL_SND_BUF_SIZE - buf->free_cells, buf->free_cells);
 
 	if (!UDSL_SKB (skb)->num_cells) {
 		struct atm_vcc *vcc = UDSL_SKB (skb)->atm_data.vcc;
@@ -890,8 +882,8 @@
 
 	if (!left--)
 		return sprintf (page, "MAC: %02x:%02x:%02x:%02x:%02x:%02x\n",
-				atm_dev->esi[0], atm_dev->esi[1], atm_dev->esi[2],
-				atm_dev->esi[3], atm_dev->esi[4], atm_dev->esi[5]);
+				atm_dev->esi [0], atm_dev->esi [1], atm_dev->esi [2],
+				atm_dev->esi [3], atm_dev->esi [4], atm_dev->esi [5]);
 
 	if (!left--)
 		return sprintf (page, "AAL5: tx %d ( %d err ), rx %d ( %d err, %d drop )\n",
@@ -968,7 +960,7 @@
 	new->vcc = vcc;
 	new->vpi = vpi;
 	new->vci = vci;
-	new->mtu = UDSL_MAX_AAL5_MRU;
+	new->max_pdu = UDSL_MAX_AAL5_MRU;
 
 	vcc->dev_data = new;
 	vcc->vpi = vpi;
@@ -1015,9 +1007,9 @@
 	list_del (&vcc_data->list);
 	tasklet_enable (&instance->receive_tasklet);
 
-	if (vcc_data->reasBuffer)
-		kfree_skb (vcc_data->reasBuffer);
-	vcc_data->reasBuffer = NULL;
+	if (vcc_data->skb)
+		kfree_skb (vcc_data->skb);
+	vcc_data->skb = NULL;
 
 	kfree (vcc_data);
 	vcc->dev_data = NULL;
@@ -1078,10 +1070,10 @@
 	}
 
 	switch (code) {
-	case UDSL_IOCTL_START:
+	case UDSL_IOCTL_LINE_UP:
 		instance->atm_dev->signal = ATM_PHY_SIG_FOUND;
 		return udsl_set_alternate (instance);
-	case UDSL_IOCTL_STOP:
+	case UDSL_IOCTL_LINE_DOWN:
 		instance->atm_dev->signal = ATM_PHY_SIG_LOST;
 		return 0;
 	default:
@@ -1134,16 +1126,16 @@
 
 	spin_lock_init (&instance->send_lock);
 	INIT_LIST_HEAD (&instance->spare_senders);
-	INIT_LIST_HEAD (&instance->spare_buffers);
+	INIT_LIST_HEAD (&instance->spare_send_buffers);
 
 	tasklet_init (&instance->send_tasklet, udsl_process_send, (unsigned long) instance);
-	INIT_LIST_HEAD (&instance->filled_buffers);
+	INIT_LIST_HEAD (&instance->filled_send_buffers);
 
 	/* receive init */
-	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++) {
-		struct udsl_receiver *rcv = &(instance->all_receivers[i]);
+	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
+		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
-		if (!(rcv->skb = dev_alloc_skb (UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE))) {
+		if (!(rcv->skb = dev_alloc_skb (UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE))) {
 			dbg ("No memory for skb %d!", i);
 			goto fail;
 		}
@@ -1157,12 +1149,12 @@
 
 		list_add (&rcv->list, &instance->spare_receivers);
 
-		dbg ("skb->truesize = %d (asked for %d)", rcv->skb->truesize, UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE);
+		dbg ("skb->truesize = %d (asked for %d)", rcv->skb->truesize, UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE);
 	}
 
 	/* send init */
-	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++) {
-		struct udsl_sender *snd = &(instance->all_senders[i]);
+	for (i = 0; i < UDSL_NUM_SND_URBS; i++) {
+		struct udsl_sender *snd = &(instance->senders [i]);
 
 		if (!(snd->urb = usb_alloc_urb (0, GFP_KERNEL))) {
 			dbg ("No memory for send urb %d!", i);
@@ -1174,18 +1166,18 @@
 		list_add (&snd->list, &instance->spare_senders);
 	}
 
-	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++) {
-		struct udsl_send_buffer *buf = &(instance->all_buffers[i]);
+	for (i = 0; i < UDSL_NUM_SND_BUFS; i++) {
+		struct udsl_send_buffer *buf = &(instance->send_buffers [i]);
 
-		if (!(buf->base = kmalloc (UDSL_SND_BUFFER_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
+		if (!(buf->base = kmalloc (UDSL_SND_BUF_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
 			dbg ("No memory for send buffer %d!", i);
 			goto fail;
 		}
 
-		list_add (&buf->list, &instance->spare_buffers);
+		list_add (&buf->list, &instance->spare_send_buffers);
 	}
 
-	/* atm init */
+	/* ATM init */
 	if (!(instance->atm_dev = atm_dev_register (udsl_driver_name, &udsl_atm_devops, -1, 0))) {
 		dbg ("failed to register ATM device!");
 		goto fail;
@@ -1195,14 +1187,14 @@
 	instance->atm_dev->ci_range.vci_bits = ATM_CI_MAX;
 	instance->atm_dev->signal = ATM_PHY_SIG_UNKNOWN;
 
-	/* tmp init atm device, set to 128kbit */
+	/* temp init ATM device, set to 128kbit */
 	instance->atm_dev->link_rate = 128 * 1000 / 424;
 
 	/* set MAC address, it is stored in the serial number */
 	memset (instance->atm_dev->esi, 0, sizeof (instance->atm_dev->esi));
 	if (usb_string (dev, dev->descriptor.iSerialNumber, mac_str, sizeof (mac_str)) == 12)
 		for (i = 0; i < 6; i++)
-			instance->atm_dev->esi[i] = (hex2int (mac_str[i * 2]) * 16) + (hex2int (mac_str[i * 2 + 1]));
+			instance->atm_dev->esi [i] = (hex2int (mac_str [i * 2]) * 16) + (hex2int (mac_str [i * 2 + 1]));
 
 	/* device description */
 	buf = instance->description;
@@ -1235,14 +1227,14 @@
 	return 0;
 
 fail:
-	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++)
-		kfree (instance->all_buffers[i].base);
+	for (i = 0; i < UDSL_NUM_SND_BUFS; i++)
+		kfree (instance->send_buffers [i].base);
 
-	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++)
-		usb_free_urb (instance->all_senders[i].urb);
+	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
+		usb_free_urb (instance->senders [i].urb);
 
-	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++) {
-		struct udsl_receiver *rcv = &(instance->all_receivers[i]);
+	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
+		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
 		usb_free_urb (rcv->urb);
 
@@ -1278,17 +1270,17 @@
 	down (&instance->serialize); /* vs udsl_fire_receivers */
 	/* no need to take the spinlock */
 	list_for_each (pos, &instance->spare_receivers)
-		if (++count > UDSL_NUMBER_RCV_URBS)
+		if (++count > UDSL_NUM_RCV_URBS)
 			panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
 	INIT_LIST_HEAD (&instance->spare_receivers);
 	up (&instance->serialize);
 
 	dbg ("udsl_usb_disconnect: flushed %u spare receivers", count);
 
-	count = UDSL_NUMBER_RCV_URBS - count;
+	count = UDSL_NUM_RCV_URBS - count;
 
-	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++)
-		if ((result = usb_unlink_urb (instance->all_receivers[i].urb)) < 0)
+	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
+		if ((result = usb_unlink_urb (instance->receivers [i].urb)) < 0)
 			dbg ("udsl_usb_disconnect: usb_unlink_urb on receive urb %d returned %d", i, result);
 
 	/* wait for completion handlers to finish */
@@ -1317,8 +1309,8 @@
 	tasklet_kill (&instance->receive_tasklet);
 
 	dbg ("udsl_usb_disconnect: freeing receivers");
-	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++) {
-		struct udsl_receiver *rcv = &(instance->all_receivers[i]);
+	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
+		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
 		usb_free_urb (rcv->urb);
 		kfree_skb (rcv->skb);
@@ -1327,8 +1319,8 @@
 	/* send finalize */
 	tasklet_disable (&instance->send_tasklet);
 
-	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++)
-		if ((result = usb_unlink_urb (instance->all_senders[i].urb)) < 0)
+	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
+		if ((result = usb_unlink_urb (instance->senders [i].urb)) < 0)
 			dbg ("udsl_usb_disconnect: usb_unlink_urb on send urb %d returned %d", i, result);
 
 	/* wait for completion handlers to finish */
@@ -1336,13 +1328,13 @@
 		count = 0;
 		spin_lock_irqsave (&instance->send_lock, flags);
 		list_for_each (pos, &instance->spare_senders)
-			if (++count > UDSL_NUMBER_SND_URBS)
+			if (++count > UDSL_NUM_SND_URBS)
 				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
 		spin_unlock_irqrestore (&instance->send_lock, flags);
 
 		dbg ("udsl_usb_disconnect: found %u spare senders", count);
 
-		if (count == UDSL_NUMBER_SND_URBS)
+		if (count == UDSL_NUM_SND_URBS)
 			break;
 
 		yield ();
@@ -1351,22 +1343,22 @@
 	dbg ("udsl_usb_disconnect: flushing");
 	/* no need to take the spinlock */
 	INIT_LIST_HEAD (&instance->spare_senders);
-	INIT_LIST_HEAD (&instance->spare_buffers);
+	INIT_LIST_HEAD (&instance->spare_send_buffers);
 	instance->current_buffer = NULL;
 
 	tasklet_enable (&instance->send_tasklet);
 
 	dbg ("udsl_usb_disconnect: freeing senders");
-	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++)
-		usb_free_urb (instance->all_senders[i].urb);
+	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
+		usb_free_urb (instance->senders [i].urb);
 
 	dbg ("udsl_usb_disconnect: freeing buffers");
-	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++)
-		kfree (instance->all_buffers[i].base);
+	for (i = 0; i < UDSL_NUM_SND_BUFS; i++)
+		kfree (instance->send_buffers [i].base);
 
 	instance->usb_dev = NULL;
 
-	/* atm finalize */
+	/* ATM finalize */
 	shutdown_atm_dev (instance->atm_dev); /* frees instance */
 }
 
@@ -1415,10 +1407,10 @@
 	int i = 0, j = 0;
 
 	for (i = 0; i < len;) {
-		buffer[0] = '\0';
+		buffer [0] = '\0';
 		sprintf (buffer, "%.3d :", i);
 		for (j = 0; (j < 16) && (i < len); j++, i++) {
-			sprintf (buffer, "%s %2.2x", buffer, data[i]);
+			sprintf (buffer, "%s %2.2x", buffer, data [i]);
 		}
 		dbg ("%s", buffer);
 	}

