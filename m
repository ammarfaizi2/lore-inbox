Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTFPIBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTFPIBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:01:30 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:60342 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263528AbTFPIBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:01:08 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [2.5 PATCH] USB speedtouch: add module parameters
Date: Mon, 16 Jun 2003 09:45:10 +0200
User-Agent: KMail/1.5.9
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306160945.10076.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtch.c |  109 ++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 73 insertions(+), 36 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Mon Jun 16 09:35:26 2003
+++ b/drivers/usb/misc/speedtch.c	Mon Jun 16 09:35:26 2003
@@ -61,6 +61,7 @@
 
 #include <asm/semaphore.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
@@ -102,12 +103,43 @@
 #define SPEEDTOUCH_VENDORID		0x06b9
 #define SPEEDTOUCH_PRODUCTID		0x4061
 
-#define UDSL_NUM_RCV_URBS		1
-#define UDSL_NUM_SND_URBS		1
-#define UDSL_NUM_RCV_BUFS		(2*UDSL_NUM_RCV_URBS)
-#define UDSL_NUM_SND_BUFS		(2*UDSL_NUM_SND_URBS)
-#define UDSL_RCV_BUF_SIZE		32 /* ATM cells */
-#define UDSL_SND_BUF_SIZE		64 /* ATM cells */
+#define UDSL_MAX_RCV_URBS		4
+#define UDSL_MAX_SND_URBS		4
+#define UDSL_MAX_RCV_BUFS		8
+#define UDSL_MAX_SND_BUFS		8
+#define UDSL_MAX_RCV_BUF_SIZE		1024 /* ATM cells */
+#define UDSL_MAX_SND_BUF_SIZE		1024 /* ATM cells */
+#define UDSL_DEFAULT_RCV_URBS		1
+#define UDSL_DEFAULT_SND_URBS		1
+#define UDSL_DEFAULT_RCV_BUFS		2
+#define UDSL_DEFAULT_SND_BUFS		2
+#define UDSL_DEFAULT_RCV_BUF_SIZE	64 /* ATM cells */
+#define UDSL_DEFAULT_SND_BUF_SIZE	64 /* ATM cells */
+
+static unsigned int num_rcv_urbs = UDSL_DEFAULT_RCV_URBS;
+static unsigned int num_snd_urbs = UDSL_DEFAULT_SND_URBS;
+static unsigned int num_rcv_bufs = UDSL_DEFAULT_RCV_BUFS;
+static unsigned int num_snd_bufs = UDSL_DEFAULT_SND_BUFS;
+static unsigned int rcv_buf_size = UDSL_DEFAULT_RCV_BUF_SIZE;
+static unsigned int snd_buf_size = UDSL_DEFAULT_SND_BUF_SIZE;
+
+module_param (num_rcv_urbs, uint, 0444);
+MODULE_PARM_DESC (num_rcv_urbs, "Number of urbs used for reception (range: 0-" __MODULE_STRING (UDSL_MAX_RCV_URBS) ", default: " __MODULE_STRING (UDSL_DEFAULT_RCV_URBS) ")");
+
+module_param (num_snd_urbs, uint, 0444);
+MODULE_PARM_DESC (num_snd_urbs, "Number of urbs used for transmission (range: 0-" __MODULE_STRING (UDSL_MAX_SND_URBS) ", default: " __MODULE_STRING (UDSL_DEFAULT_SND_URBS) ")");
+
+module_param (num_rcv_bufs, uint, 0444);
+MODULE_PARM_DESC (num_rcv_bufs, "Number of buffers used for reception (range: 0-" __MODULE_STRING (UDSL_MAX_RCV_BUFS) ", default: " __MODULE_STRING (UDSL_DEFAULT_RCV_BUFS) ")");
+
+module_param (num_snd_bufs, uint, 0444);
+MODULE_PARM_DESC (num_snd_bufs, "Number of buffers used for transmission (range: 0-" __MODULE_STRING (UDSL_MAX_SND_BUFS) ", default: " __MODULE_STRING (UDSL_DEFAULT_SND_BUFS) ")");
+
+module_param (rcv_buf_size, uint, 0444);
+MODULE_PARM_DESC (rcv_buf_size, "Size of the buffers used for reception (range: 0-" __MODULE_STRING (UDSL_MAX_RCV_BUF_SIZE) ", default: " __MODULE_STRING (UDSL_DEFAULT_RCV_BUF_SIZE) ")");
+
+module_param (snd_buf_size, uint, 0444);
+MODULE_PARM_DESC (snd_buf_size, "Size of the buffers used for transmission (range: 0-" __MODULE_STRING (UDSL_MAX_SND_BUF_SIZE) ", default: " __MODULE_STRING (UDSL_DEFAULT_SND_BUF_SIZE) ")");
 
 #define UDSL_IOCTL_LINE_UP		1
 #define UDSL_IOCTL_LINE_DOWN		2
@@ -196,8 +228,8 @@
 	struct list_head vcc_list;
 
 	/* receive */
-	struct udsl_receiver receivers [UDSL_NUM_RCV_URBS];
-	struct udsl_receive_buffer receive_buffers [UDSL_NUM_RCV_BUFS];
+	struct udsl_receiver receivers [UDSL_MAX_RCV_URBS];
+	struct udsl_receive_buffer receive_buffers [UDSL_MAX_RCV_BUFS];
 
 	spinlock_t receive_lock;
 	struct list_head spare_receivers;
@@ -207,8 +239,8 @@
 	struct list_head spare_receive_buffers;
 
 	/* send */
-	struct udsl_sender senders [UDSL_NUM_SND_URBS];
-	struct udsl_send_buffer send_buffers [UDSL_NUM_SND_BUFS];
+	struct udsl_sender senders [UDSL_MAX_SND_URBS];
+	struct udsl_send_buffer send_buffers [UDSL_MAX_SND_BUFS];
 
 	struct sk_buff_head sndqueue;
 
@@ -503,7 +535,7 @@
 
 	vdbg ("udsl_complete_receive: urb 0x%p, status %d, actual_length %d, filled_cells %u, rcv 0x%p, buf 0x%p", urb, urb->status, urb->actual_length, buf->filled_cells, rcv, buf);
 
-	BUG_ON (buf->filled_cells > UDSL_RCV_BUF_SIZE);
+	BUG_ON (buf->filled_cells > rcv_buf_size);
 
 	/* may not be in_interrupt() */
 	spin_lock_irqsave (&instance->receive_lock, flags);
@@ -541,7 +573,7 @@
 				   instance->usb_dev,
 				   usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
 				   buf->base,
-				   UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE,
+				   rcv_buf_size * ATM_CELL_SIZE,
 				   udsl_complete_receive,
 				   rcv);
 
@@ -626,11 +658,11 @@
 				   instance->usb_dev,
 				   usb_sndbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_OUT),
 				   buf->base,
-				   (UDSL_SND_BUF_SIZE - buf->free_cells) * ATM_CELL_SIZE,
+				   (snd_buf_size - buf->free_cells) * ATM_CELL_SIZE,
 				   udsl_complete_send,
 				   snd);
 
-		vdbg ("udsl_process_send: submitting urb 0x%p (%d cells), snd 0x%p, buf 0x%p", snd->urb, UDSL_SND_BUF_SIZE - buf->free_cells, snd, buf);
+		vdbg ("udsl_process_send: submitting urb 0x%p (%d cells), snd 0x%p, buf 0x%p", snd->urb, snd_buf_size - buf->free_cells, snd, buf);
 
 		if ((err = usb_submit_urb(snd->urb, GFP_ATOMIC)) < 0) {
 			dbg ("udsl_process_send: urb submission failed (%d)!", err);
@@ -662,7 +694,7 @@
 		spin_unlock_irq (&instance->send_lock);
 
 		buf->free_start = buf->base;
-		buf->free_cells = UDSL_SND_BUF_SIZE;
+		buf->free_cells = snd_buf_size;
 
 		instance->current_buffer = buf;
 	}
@@ -676,7 +708,7 @@
 		instance->current_buffer = NULL;
 	}
 
-	vdbg ("udsl_process_send: buffer contains %d cells, %d left", UDSL_SND_BUF_SIZE - buf->free_cells, buf->free_cells);
+	vdbg ("udsl_process_send: buffer contains %d cells, %d left", snd_buf_size - buf->free_cells, buf->free_cells);
 
 	if (!UDSL_SKB (skb)->num_cells) {
 		struct atm_vcc *vcc = UDSL_SKB (skb)->atm_data.vcc;
@@ -1039,7 +1071,7 @@
 	INIT_LIST_HEAD (&instance->filled_send_buffers);
 
 	/* receive init */
-	for (i = 0; i < UDSL_NUM_RCV_URBS; i++) {
+	for (i = 0; i < num_rcv_urbs; i++) {
 		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
 		if (!(rcv->urb = usb_alloc_urb (0, GFP_KERNEL))) {
@@ -1052,10 +1084,10 @@
 		list_add (&rcv->list, &instance->spare_receivers);
 	}
 
-	for (i = 0; i < UDSL_NUM_RCV_BUFS; i++) {
+	for (i = 0; i < num_rcv_bufs; i++) {
 		struct udsl_receive_buffer *buf = &(instance->receive_buffers [i]);
 
-		if (!(buf->base = kmalloc (UDSL_RCV_BUF_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
+		if (!(buf->base = kmalloc (rcv_buf_size * ATM_CELL_SIZE, GFP_KERNEL))) {
 			dbg ("udsl_usb_probe: no memory for receive buffer %d!", i);
 			goto fail;
 		}
@@ -1064,7 +1096,7 @@
 	}
 
 	/* send init */
-	for (i = 0; i < UDSL_NUM_SND_URBS; i++) {
+	for (i = 0; i < num_snd_urbs; i++) {
 		struct udsl_sender *snd = &(instance->senders [i]);
 
 		if (!(snd->urb = usb_alloc_urb (0, GFP_KERNEL))) {
@@ -1077,10 +1109,10 @@
 		list_add (&snd->list, &instance->spare_senders);
 	}
 
-	for (i = 0; i < UDSL_NUM_SND_BUFS; i++) {
+	for (i = 0; i < num_snd_bufs; i++) {
 		struct udsl_send_buffer *buf = &(instance->send_buffers [i]);
 
-		if (!(buf->base = kmalloc (UDSL_SND_BUF_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
+		if (!(buf->base = kmalloc (snd_buf_size * ATM_CELL_SIZE, GFP_KERNEL))) {
 			dbg ("udsl_usb_probe: no memory for send buffer %d!", i);
 			goto fail;
 		}
@@ -1139,16 +1171,16 @@
 	return 0;
 
 fail:
-	for (i = 0; i < UDSL_NUM_SND_BUFS; i++)
+	for (i = 0; i < num_snd_bufs; i++)
 		kfree (instance->send_buffers [i].base);
 
-	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
+	for (i = 0; i < num_snd_urbs; i++)
 		usb_free_urb (instance->senders [i].urb);
 
-	for (i = 0; i < UDSL_NUM_RCV_BUFS; i++)
+	for (i = 0; i < num_rcv_bufs; i++)
 		kfree (instance->receive_buffers [i].base);
 
-	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
+	for (i = 0; i < num_rcv_urbs; i++)
 		usb_free_urb (instance->receivers [i].urb);
 
 	kfree (instance);
@@ -1175,7 +1207,7 @@
 	/* receive finalize */
 	tasklet_disable (&instance->receive_tasklet);
 
-	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
+	for (i = 0; i < num_rcv_urbs; i++)
 		if ((result = usb_unlink_urb (instance->receivers [i].urb)) < 0)
 			dbg ("udsl_usb_disconnect: usb_unlink_urb on receive urb %d returned %d", i, result);
 
@@ -1184,13 +1216,13 @@
 		count = 0;
 		spin_lock_irq (&instance->receive_lock);
 		list_for_each (pos, &instance->spare_receivers)
-			if (++count > UDSL_NUM_RCV_URBS)
+			if (++count > num_rcv_urbs)
 				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
 		spin_unlock_irq (&instance->receive_lock);
 
 		dbg ("udsl_usb_disconnect: found %u spare receivers", count);
 
-		if (count == UDSL_NUM_RCV_URBS)
+		if (count == num_rcv_urbs)
 			break;
 
 		set_current_state (TASK_RUNNING);
@@ -1203,16 +1235,16 @@
 
 	tasklet_enable (&instance->receive_tasklet);
 
-	for (i = 0; i < UDSL_NUM_RCV_URBS; i++)
+	for (i = 0; i < num_rcv_urbs; i++)
 		usb_free_urb (instance->receivers [i].urb);
 
-	for (i = 0; i < UDSL_NUM_RCV_BUFS; i++)
+	for (i = 0; i < num_rcv_bufs; i++)
 		kfree (instance->receive_buffers [i].base);
 
 	/* send finalize */
 	tasklet_disable (&instance->send_tasklet);
 
-	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
+	for (i = 0; i < num_snd_urbs; i++)
 		if ((result = usb_unlink_urb (instance->senders [i].urb)) < 0)
 			dbg ("udsl_usb_disconnect: usb_unlink_urb on send urb %d returned %d", i, result);
 
@@ -1221,13 +1253,13 @@
 		count = 0;
 		spin_lock_irq (&instance->send_lock);
 		list_for_each (pos, &instance->spare_senders)
-			if (++count > UDSL_NUM_SND_URBS)
+			if (++count > num_snd_urbs)
 				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
 		spin_unlock_irq (&instance->send_lock);
 
 		dbg ("udsl_usb_disconnect: found %u spare senders", count);
 
-		if (count == UDSL_NUM_SND_URBS)
+		if (count == num_snd_urbs)
 			break;
 
 		set_current_state (TASK_RUNNING);
@@ -1241,10 +1273,10 @@
 
 	tasklet_enable (&instance->send_tasklet);
 
-	for (i = 0; i < UDSL_NUM_SND_URBS; i++)
+	for (i = 0; i < num_snd_urbs; i++)
 		usb_free_urb (instance->senders [i].urb);
 
-	for (i = 0; i < UDSL_NUM_SND_BUFS; i++)
+	for (i = 0; i < num_snd_bufs; i++)
 		kfree (instance->send_buffers [i].base);
 
 	wmb ();
@@ -1269,6 +1301,11 @@
 		printk (KERN_ERR __FILE__ ": unusable with this kernel!\n");
 		return -EIO;
 	}
+
+	if ((num_rcv_urbs > UDSL_MAX_RCV_URBS) || (num_snd_urbs > UDSL_MAX_SND_URBS) ||
+	    (num_rcv_bufs > UDSL_MAX_RCV_BUFS) || (num_snd_bufs > UDSL_MAX_SND_BUFS) ||
+	    (rcv_buf_size > UDSL_MAX_RCV_BUF_SIZE) || (snd_buf_size > UDSL_MAX_SND_BUF_SIZE))
+		return -EINVAL;
 
 	return usb_register (&udsl_usb_driver);
 }

