Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDZHTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDZHTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVDZHTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:19:12 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:22638 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261391AbVDZHQV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:16:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Date: Tue, 26 Apr 2005 02:16:10 -0500
User-Agent: KMail/1.8
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
References: <200504210207.02421.dtor_core@ameritech.net> <200504260150.00948.dtor_core@ameritech.net> <1114499202.8527.85.camel@uganda>
In-Reply-To: <1114499202.8527.85.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504260216.10560.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 02:06, Evgeniy Polyakov wrote:
> On Tue, 2005-04-26 at 01:50 -0500, Dmitry Torokhov wrote:
> > 
> > If you program so that you wait in module_exit for object release - you
> > get what you deserve. 
> 
> But we can remove objects not from rmmod path.
> You pointed right example in one previous e-mail.

Right, and you need to be careful so that thread does not hold any references
to the resource it tries to free. rmmod is just one pf the common examples.
But you need to consider this scenario whether you using driver model or your
separate refcount - the basic problem is still the same.

> Using above "waiting for device..." message is for debug only.
> 
> > > > BTW, I am looking at the connector code ATM and I am just amazed at
> > > > all wied refounting stuff that is going on there. what a single
> > > > actomic_dec_and_test() call without checkng reurn vaue is supposed to
> > > > do again?
> > > 
> > > It has explicit barrieres, which guarantees that
> > > there will not be atomic operation vs. non atomic
> > > reordering. 
> > 
> > And you can't use explicit barriers - why exactly?
> 
> I used them - code was following:
> smp_mb__before_atomic_dec();
> atomic_dec();
> smp_mb__after_atomic_dec();
> 
> I think simple atomic_dec_and_test() or even atomic_dec_and_lock()
> is better.

This is usually indicates that there some kiond of a problem. Consider
following fragment:

> +static void cn_queue_wrapper(void *data)
> +{
> +       struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
> +
> +       atomic_inc_and_test(&cbq->cb->refcnt);
> +       cbq->cb->callback(cbq->cb->priv);
> +       atomic_dec_and_test(&cbq->cb->refcnt);
> 

What exactly this refcount protects? Can it be that other code decrements
refcount and frees the object right when one CPU is entering this function?
If not that means that cb structure is protected by some other means, so
why we need to increment refcout here and consider ordering?

Btw, cb refcount can be complelely removed, something like the patch below
(won't apply cleanly as I have some other stuff).

-- 
Dmitry

 drivers/connector/cn_queue.c |   85 +++++++++++--------------------------------
 include/linux/connector.h    |    2 -
 2 files changed, 23 insertions(+), 64 deletions(-)

Index: linux-2.6.11/drivers/connector/cn_queue.c
===================================================================
--- linux-2.6.11.orig/drivers/connector/cn_queue.c
+++ linux-2.6.11/drivers/connector/cn_queue.c
@@ -33,49 +33,12 @@
 
 static void cn_queue_wrapper(void *data)
 {
-	struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
+	struct cn_callback_entry *cbq = data;
 
-	atomic_inc_and_test(&cbq->cb->refcnt);
 	cbq->cb->callback(cbq->cb->priv);
-	atomic_dec_and_test(&cbq->cb->refcnt);
-
 	cbq->destruct_data(cbq->ddata);
 }
 
-static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct cn_callback *cb)
-{
-	struct cn_callback_entry *cbq;
-
-	cbq = kmalloc(sizeof(*cbq), GFP_KERNEL);
-	if (!cbq) {
-		printk(KERN_ERR "Failed to create new callback queue.\n");
-		return NULL;
-	}
-
-	memset(cbq, 0, sizeof(*cbq));
-
-	cbq->cb = cb;
-
-	INIT_WORK(&cbq->work, &cn_queue_wrapper, cbq);
-
-	return cbq;
-}
-
-static void cn_queue_free_callback(struct cn_callback_entry *cbq)
-{
-	cancel_delayed_work(&cbq->work);
-	flush_workqueue(cbq->pdev->cn_queue);
-
-	while (atomic_read(&cbq->cb->refcnt)) {
-		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
-		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
-
-		msleep(1000);
-	}
-
-	kfree(cbq);
-}
-
 int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
 {
 #if 0
@@ -90,40 +53,37 @@ int cn_cb_equal(struct cb_id *i1, struct
 int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
 {
 	struct cn_callback_entry *cbq, *__cbq;
-	int found = 0;
+	int retval = 0;
 
-	cbq = cn_queue_alloc_callback_entry(cb);
-	if (!cbq)
+	cbq = kmalloc(sizeof(*cbq), GFP_KERNEL);
+	if (!cbq) {
+		printk(KERN_ERR "Failed to create new callback queue.\n");
 		return -ENOMEM;
+	}
 
 	atomic_inc(&dev->refcnt);
+
+	memset(cbq, 0, sizeof(*cbq));
+	INIT_WORK(&cbq->work, &cn_queue_wrapper, cbq);
+	cbq->cb = cb;
 	cbq->pdev = dev;
+	cbq->nls = dev->nls;
+	cbq->seq = 0;
+	cbq->group = cbq->cb->id.idx;
 
 	spin_lock_bh(&dev->queue_lock);
+
 	list_for_each_entry(__cbq, &dev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
-			found = 1;
-			break;
+			retval = -EEXIST;
+			kfree(cbq);
+			goto out;
 		}
 	}
-	if (!found) {
-		atomic_set(&cbq->cb->refcnt, 1);
-		list_add_tail(&cbq->callback_entry, &dev->queue_list);
-	}
+	list_add_tail(&cbq->callback_entry, &dev->queue_list);
+ out:
 	spin_unlock_bh(&dev->queue_lock);
-
-	if (found) {
-		atomic_dec(&dev->refcnt);
-		atomic_set(&cbq->cb->refcnt, 0);
-		cn_queue_free_callback(cbq);
-		return -EINVAL;
-	}
-
-	cbq->nls = dev->nls;
-	cbq->seq = 0;
-	cbq->group = cbq->cb->id.idx;
-
-	return 0;
+	return retval;
 }
 
 void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id)
@@ -142,8 +102,9 @@ void cn_queue_del_callback(struct cn_que
 	spin_unlock_bh(&dev->queue_lock);
 
 	if (found) {
-		atomic_dec(&cbq->cb->refcnt);
-		cn_queue_free_callback(cbq);
+		cancel_delayed_work(&cbq->work);
+		flush_workqueue(cbq->pdev->cn_queue);
+		kfree(cbq);
 		atomic_dec_and_test(&dev->refcnt);
 	}
 }
Index: linux-2.6.11/include/linux/connector.h
===================================================================
--- linux-2.6.11.orig/include/linux/connector.h
+++ linux-2.6.11/include/linux/connector.h
@@ -115,8 +115,6 @@ struct cn_callback
 	struct cb_id		id;
 	void			(* callback)(void *);
 	void			*priv;
-
-	atomic_t		refcnt;
 };
 
 struct cn_callback_entry
