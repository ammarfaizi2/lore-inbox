Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVDABeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVDABeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 20:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVDABeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 20:34:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:3767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262563AbVDABcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 20:32:46 -0500
Date: Thu, 31 Mar 2005 17:32:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: cn_queue.c
Message-Id: <20050331173215.49c959a0.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /*
>  * 	cn_queue.c
>  * 
>  * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
>  * All rights reserved.
>  * 
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation; either version 2 of the License, or
>  * (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>  *
>  */

It's conventinal to add at the start of the file a description of what it
all does.

> static void cn_queue_wrapper(void *data)
> {
> 	struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
> 
> 	smp_mb__before_atomic_inc();
> 	atomic_inc(&cbq->cb->refcnt);
> 	smp_mb__after_atomic_inc();
> 	cbq->cb->callback(cbq->cb->priv);
> 	smp_mb__before_atomic_inc();
> 	atomic_dec(&cbq->cb->refcnt);
> 	smp_mb__after_atomic_inc();
> 
> 	cbq->destruct_data(cbq->ddata);
> }

What on earth are all these barriers for?  Barriers should have an
associated comment describing why they were added, and what they are
defending against, becuase it is very hard to tell that from reading the
code.

Please describe (via code comments) what the refcounting rules are for
these data structures.  It all looks very strange.  You basically have:


	atomic_inc(refcnt);
	use(some_object);
	atomic_dec(refcnt);

Which looks very racy.  Some other CPU could see a zero refcount just
before this CPU did the atomic_inc() and the other CPU will go and free up
some_object.  There should be locking associated with refcounting to
prevent such races, and I don't see any.

> static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct cn_callback *cb)

80 cols again.

> static void cn_queue_free_callback(struct cn_callback_entry *cbq)
> {
> 	cancel_delayed_work(&cbq->work);
> 
> 	while (atomic_read(&cbq->cb->refcnt)) {
> 		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
> 		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
> 
> 		msleep_interruptible(1000);
> 
> 		if (current->flags & PF_FREEZE)
> 			refrigerator(PF_FREEZE);
> 
> 		if (signal_pending(current))
> 			flush_signals(current);
> 	}
> 
> 	kfree(cbq);
> }

erp.  Can you please do this properly?

Free the object on the refcount going to zero (with appropriate locking)? 
If you want (for some reason) to wait until all users of an object have
gone away then you should take a ref on the object (inside locking), then
sleep on a waitqueue_head embedded in that object.  Make all
refcount-droppers do a wake_up.

Why is this function playing with signals?

> int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
> {
> #if 0
> 	printk(KERN_INFO "%s: comparing %04x.%04x and %04x.%04x\n",
> 			__func__,
> 			i1->idx, i1->val,
> 			i2->idx, i2->val);
> #endif
> 	return ((i1->idx == i2->idx) && (i1->val == i2->val));
> }

Please review all functions, check that they really need kernel-wide scope.

Please comment all functions.

> int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
> {
> 	struct cn_callback_entry *cbq, *n, *__cbq;
> 	int found = 0;
> 
> 	cbq = cn_queue_alloc_callback_entry(cb);
> 	if (!cbq)
> 		return -ENOMEM;
> 
> 	atomic_inc(&dev->refcnt);
> 	smp_mb__after_atomic_inc();
> 	cbq->pdev = dev;
> 
> 	spin_lock_bh(&dev->queue_lock);
> 	list_for_each_entry_safe(__cbq, n, &dev->queue_list, callback_entry) {
> 		if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
> 			found = 1;
> 			break;
> 		}
> 	}
> 	if (!found) {
> 		atomic_set(&cbq->cb->refcnt, 1);
> 		list_add_tail(&cbq->callback_entry, &dev->queue_list);
> 	}
> 	spin_unlock_bh(&dev->queue_lock);

Why use spin_lock_bh()?  Does none of this code ever get called from IRQ
context?

> 	if (found) {
> 		smp_mb__before_atomic_inc();
> 		atomic_dec(&dev->refcnt);
> 		smp_mb__after_atomic_inc();
> 		atomic_set(&cbq->cb->refcnt, 0);
> 		cn_queue_free_callback(cbq);
> 		return -EINVAL;
> 	}

More strange barriers.  This practice seems to be unique to this part of the
kernel.  That's probably a bad sign.


> struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *nls)
> {
> 	struct cn_queue_dev *dev;
> 
> 	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
> 	if (!dev) {
> 		printk(KERN_ERR "%s: Failed to allocte new struct cn_queue_dev.\n",
> 		       name);
> 		return NULL;
> 	}
> 
> 	memset(dev, 0, sizeof(*dev));
> 
> 	snprintf(dev->name, sizeof(dev->name), "%s", name);

scnprintf?

> void cn_queue_free_dev(struct cn_queue_dev *dev)
> {
> 	struct cn_callback_entry *cbq, *n;
> 
> 	flush_workqueue(dev->cn_queue);
> 	destroy_workqueue(dev->cn_queue);
> 
> 	spin_lock_bh(&dev->queue_lock);
> 	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
> 		list_del(&cbq->callback_entry);
> 		smp_mb__before_atomic_inc();
> 		atomic_dec(&cbq->cb->refcnt);
> 		smp_mb__after_atomic_inc();
> 	}
> 	spin_unlock_bh(&dev->queue_lock);
> 
> 	while (atomic_read(&dev->refcnt)) {
> 		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
> 		       dev->name, atomic_read(&dev->refcnt));
> 
> 		msleep_interruptible(1000);
> 
> 		if (current->flags & PF_FREEZE)
> 			refrigerator(PF_FREEZE);
> 
> 		if (signal_pending(current))
> 			flush_signals(current);
> 	}
> 
> 	memset(dev, 0, sizeof(*dev));
> 	kfree(dev);
> 	dev = NULL;
> }

Again, why is this code playing with signals?  Hopefully it is never called
by user tasks - that would be very bad.

With proper refcounting and lifetime management and the use of the kthread
API we should be able to make all this go away.

Once we're trying to free up the controlling device, what prevents new
messages from being queued?

