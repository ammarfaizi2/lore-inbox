Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTETWoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTETWoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:44:13 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:38 "EHLO mwinf0603.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261305AbTETWnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:43:53 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 05/14] USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
Date: Wed, 21 May 2003 00:56:46 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210056.46181.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spin_lock_irqsave/spin_unlock_irqrestore with
spin_lock_irq/spin_unlock_irq in routines that are only
called in process context.

 speedtch.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:22 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:22 2003
@@ -613,15 +613,14 @@
 static void udsl_fire_receivers (struct udsl_instance_data *instance)
 {
 	struct list_head receivers, *pos, *n;
-	unsigned long flags;
 
 	INIT_LIST_HEAD (&receivers);
 
 	down (&instance->serialize);
 
-	spin_lock_irqsave (&instance->spare_receivers_lock, flags);
+	spin_lock_irq (&instance->spare_receivers_lock);
 	list_splice_init (&instance->spare_receivers, &receivers);
-	spin_unlock_irqrestore (&instance->spare_receivers_lock, flags);
+	spin_unlock_irq (&instance->spare_receivers_lock);
 
 	list_for_each_safe (pos, n, &receivers) {
 		struct udsl_receiver *rcv = list_entry (pos, struct udsl_receiver, list);
@@ -638,9 +637,9 @@
 
 		if (usb_submit_urb (rcv->urb, GFP_KERNEL) < 0) {
 			dbg ("udsl_fire_receivers: submit failed!");
-			spin_lock_irqsave (&instance->spare_receivers_lock, flags);
+			spin_lock_irq (&instance->spare_receivers_lock);
 			list_move (pos, &instance->spare_receivers);
-			spin_unlock_irqrestore (&instance->spare_receivers_lock, flags);
+			spin_unlock_irq (&instance->spare_receivers_lock);
 		}
 	}
 
@@ -782,11 +781,10 @@
 
 static void udsl_cancel_send (struct udsl_instance_data *instance, struct atm_vcc *vcc)
 {
-	unsigned long flags;
 	struct sk_buff *skb, *n;
 
 	dbg ("udsl_cancel_send entered");
-	spin_lock_irqsave (&instance->sndqueue.lock, flags);
+	spin_lock_irq (&instance->sndqueue.lock);
 	for (skb = instance->sndqueue.next, n = skb->next; skb != (struct sk_buff *)&instance->sndqueue; skb = n, n = skb->next)
 		if (UDSL_SKB (skb)->atm_data.vcc == vcc) {
 			dbg ("popping skb 0x%p", skb);
@@ -796,7 +794,7 @@
 			else
 				kfree_skb (skb);
 		}
-	spin_unlock_irqrestore (&instance->sndqueue.lock, flags);
+	spin_unlock_irq (&instance->sndqueue.lock);
 
 	tasklet_disable (&instance->send_tasklet);
 	if ((skb = instance->current_skb) && (UDSL_SKB (skb)->atm_data.vcc == vcc)) {
@@ -1252,7 +1250,6 @@
 {
 	struct udsl_instance_data *instance = usb_get_intfdata (intf);
 	struct list_head *pos;
-	unsigned long flags;
 	unsigned int count = 0;
 	int result, i;
 
@@ -1288,11 +1285,11 @@
 	do {
 		unsigned int completed = 0;
 
-		spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+		spin_lock_irq (&instance->completed_receivers_lock);
 		list_for_each (pos, &instance->completed_receivers)
 			if (++completed > count)
 				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
-		spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+		spin_unlock_irq (&instance->completed_receivers_lock);
 
 		dbg ("udsl_usb_disconnect: found %u completed receivers", completed);
 
@@ -1328,11 +1325,11 @@
 	/* wait for completion handlers to finish */
 	do {
 		count = 0;
-		spin_lock_irqsave (&instance->send_lock, flags);
+		spin_lock_irq (&instance->send_lock);
 		list_for_each (pos, &instance->spare_senders)
 			if (++count > UDSL_NUM_SND_URBS)
 				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
-		spin_unlock_irqrestore (&instance->send_lock, flags);
+		spin_unlock_irq (&instance->send_lock);
 
 		dbg ("udsl_usb_disconnect: found %u spare senders", count);
 

