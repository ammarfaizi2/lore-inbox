Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTETWqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTETWqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:46:25 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:44592 "EHLO
	mwinf0403.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261392AbTETWpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:45:13 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 06/14] USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
Date: Wed, 21 May 2003 00:58:07 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210058.07416.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spin_lock_irqsave/spin_unlock_irqrestore with
spin_lock_irq/spin_unlock_irq in tasklet actions, since
these are always called with local irqs enabled.

 speedtch.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:26 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:26 2003
@@ -526,7 +526,6 @@
 {
 	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
 	struct udsl_receiver *rcv;
-	unsigned long flags;
 	unsigned char *data_start;
 	struct sk_buff *skb;
 	struct urb *urb;
@@ -536,11 +535,11 @@
 
 	dbg ("udsl_process_receive entered");
 
-	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+	spin_lock_irq (&instance->completed_receivers_lock);
 	while (!list_empty (&instance->completed_receivers)) {
 		rcv = list_entry (instance->completed_receivers.next, struct udsl_receiver, list);
 		list_del (&rcv->list);
-		spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+		spin_unlock_irq (&instance->completed_receivers_lock);
 
 		urb = rcv->urb;
 		dbg ("udsl_process_receive: got packet %p with length %d and status %d", urb, urb->actual_length, urb->status);
@@ -598,15 +597,15 @@
 			/* fall through */
 		default: /* error or urb unlinked */
 			dbg ("udsl_process_receive: adding to spare_receivers");
-			spin_lock_irqsave (&instance->spare_receivers_lock, flags);
+			spin_lock_irq (&instance->spare_receivers_lock);
 			list_add (&rcv->list, &instance->spare_receivers);
-			spin_unlock_irqrestore (&instance->spare_receivers_lock, flags);
+			spin_unlock_irq (&instance->spare_receivers_lock);
 			break;
 		} /* switch */
 
-		spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+		spin_lock_irq (&instance->completed_receivers_lock);
 	} /* while */
-	spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+	spin_unlock_irq (&instance->completed_receivers_lock);
 	dbg ("udsl_process_receive successful");
 }
 
@@ -676,7 +675,6 @@
 {
 	struct udsl_send_buffer *buf;
 	int err;
-	unsigned long flags;
 	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
 	unsigned int num_written;
 	struct sk_buff *skb;
@@ -685,7 +683,7 @@
 	dbg ("udsl_process_send entered");
 
 made_progress:
-	spin_lock_irqsave (&instance->send_lock, flags);
+	spin_lock_irq (&instance->send_lock);
 	while (!list_empty (&instance->spare_senders)) {
 		if (!list_empty (&instance->filled_send_buffers)) {
 			buf = list_entry (instance->filled_send_buffers.next, struct udsl_send_buffer, list);
@@ -699,7 +697,7 @@
 
 		snd = list_entry (instance->spare_senders.next, struct udsl_sender, list);
 		list_del (&snd->list);
-		spin_unlock_irqrestore (&instance->send_lock, flags);
+		spin_unlock_irq (&instance->send_lock);
 
 		snd->buffer = buf;
 	        usb_fill_bulk_urb (snd->urb,
@@ -714,16 +712,16 @@
 
 		if ((err = usb_submit_urb(snd->urb, GFP_ATOMIC)) < 0) {
 			dbg ("submission failed (%d)!", err);
-			spin_lock_irqsave (&instance->send_lock, flags);
+			spin_lock_irq (&instance->send_lock);
 			list_add (&snd->list, &instance->spare_senders);
-			spin_unlock_irqrestore (&instance->send_lock, flags);
+			spin_unlock_irq (&instance->send_lock);
 			list_add (&buf->list, &instance->filled_send_buffers);
 			return;
 		}
 
-		spin_lock_irqsave (&instance->send_lock, flags);
+		spin_lock_irq (&instance->send_lock);
 	} /* while */
-	spin_unlock_irqrestore (&instance->send_lock, flags);
+	spin_unlock_irq (&instance->send_lock);
 
 	if (!instance->current_skb && !(instance->current_skb = skb_dequeue (&instance->sndqueue))) {
 		dbg ("done - no more skbs");
@@ -733,16 +731,16 @@
 	skb = instance->current_skb;
 
 	if (!(buf = instance->current_buffer)) {
-		spin_lock_irqsave (&instance->send_lock, flags);
+		spin_lock_irq (&instance->send_lock);
 		if (list_empty (&instance->spare_send_buffers)) {
 			instance->current_buffer = NULL;
-			spin_unlock_irqrestore (&instance->send_lock, flags);
+			spin_unlock_irq (&instance->send_lock);
 			dbg ("done - no more buffers");
 			return;
 		}
 		buf = list_entry (instance->spare_send_buffers.next, struct udsl_send_buffer, list);
 		list_del (&buf->list);
-		spin_unlock_irqrestore (&instance->send_lock, flags);
+		spin_unlock_irq (&instance->send_lock);
 
 		buf->free_start = buf->base;
 		buf->free_cells = UDSL_SND_BUF_SIZE;

