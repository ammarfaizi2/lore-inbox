Return-Path: <linux-kernel-owner+w=401wt.eu-S1753011AbWLQRZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbWLQRZG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 12:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbWLQRZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 12:25:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45500 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbWLQRZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 12:25:04 -0500
Date: Sun, 17 Dec 2006 09:24:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fallout from atomic_long_t patch
In-Reply-To: <20061217105907.GE17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612170911230.3479@woody.osdl.org>
References: <20061217105907.GE17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Al Viro wrote:
> -			if (likely(!test_bit(WORK_STRUCT_PENDING,
> -					     &__cbq->work.work.management) &&
> +			if (likely(!work_pending(&__cbq->work.work) &&

That should properly be

	if (likely(!delayed_work_pending(&__cbq->work) && ...

and why the heck was it doing that open-coded int he first place?

HOWEVER, looking even more, why is that thing a "delayed work" at all? All 
the queuing seems to happen with a timeout of zero..

So I _think_ that the proper patch is actually the following, but somebody 
who knows and uses the connector thing should double-check. Please?

			Linus
---
diff --git a/drivers/connector/cn_queue.c b/drivers/connector/cn_queue.c
index b418b16..296f510 100644
--- a/drivers/connector/cn_queue.c
+++ b/drivers/connector/cn_queue.c
@@ -34,7 +34,7 @@
 void cn_queue_wrapper(struct work_struct *work)
 {
 	struct cn_callback_entry *cbq =
-		container_of(work, struct cn_callback_entry, work.work);
+		container_of(work, struct cn_callback_entry, work);
 	struct cn_callback_data *d = &cbq->data;
 
 	d->callback(d->callback_priv);
@@ -59,13 +59,12 @@ static struct cn_callback_entry *cn_queue_alloc_callback_entry(char *name, struc
 	memcpy(&cbq->id.id, id, sizeof(struct cb_id));
 	cbq->data.callback = callback;
 	
-	INIT_DELAYED_WORK(&cbq->work, &cn_queue_wrapper);
+	INIT_WORK(&cbq->work, &cn_queue_wrapper);
 	return cbq;
 }
 
 static void cn_queue_free_callback(struct cn_callback_entry *cbq)
 {
-	cancel_delayed_work(&cbq->work);
 	flush_workqueue(cbq->pdev->cn_queue);
 
 	kfree(cbq);
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 5e7cd45..416de8c 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -135,17 +135,16 @@ static int cn_call_callback(struct cn_msg *msg, void (*destruct_data)(void *), v
 	spin_lock_bh(&dev->cbdev->queue_lock);
 	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
-			if (likely(!test_bit(WORK_STRUCT_PENDING,
-					     &__cbq->work.work.management) &&
+			if (likely(!work_pending(&__cbq->work) &&
 					__cbq->data.ddata == NULL)) {
 				__cbq->data.callback_priv = msg;
 
 				__cbq->data.ddata = data;
 				__cbq->data.destruct_data = destruct_data;
 
-				if (queue_delayed_work(
+				if (queue_work(
 					    dev->cbdev->cn_queue,
-					    &__cbq->work, 0))
+					    &__cbq->work))
 					err = 0;
 			} else {
 				struct cn_callback_data *d;
@@ -159,12 +158,12 @@ static int cn_call_callback(struct cn_msg *msg, void (*destruct_data)(void *), v
 					d->destruct_data = destruct_data;
 					d->free = __cbq;
 
-					INIT_DELAYED_WORK(&__cbq->work,
+					INIT_WORK(&__cbq->work,
 							  &cn_queue_wrapper);
 					
-					if (queue_delayed_work(
+					if (queue_work(
 						    dev->cbdev->cn_queue,
-						    &__cbq->work, 0))
+						    &__cbq->work))
 						err = 0;
 					else {
 						kfree(__cbq);
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 3ea1cd5..10eb56b 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -133,7 +133,7 @@ struct cn_callback_data {
 struct cn_callback_entry {
 	struct list_head callback_entry;
 	struct cn_callback *cb;
-	struct delayed_work work;
+	struct work_struct work;
 	struct cn_queue_dev *pdev;
 
 	struct cn_callback_id id;
