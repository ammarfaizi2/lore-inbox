Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVDAH6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVDAH6D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVDAH55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:57:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:19894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262661AbVDAH51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:57:27 -0500
Date: Thu, 31 Mar 2005 23:57:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: cn_queue.c
Message-Id: <20050331235706.5b5981db.akpm@osdl.org>
In-Reply-To: <1112341236.9334.97.camel@uganda>
References: <20050331173215.49c959a0.akpm@osdl.org>
	<1112341236.9334.97.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > > static void cn_queue_wrapper(void *data)
> > > {
> > > 	struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
> > > 
> > > 	smp_mb__before_atomic_inc();
> > > 	atomic_inc(&cbq->cb->refcnt);
> > > 	smp_mb__after_atomic_inc();
> > > 	cbq->cb->callback(cbq->cb->priv);
> > > 	smp_mb__before_atomic_inc();
> > > 	atomic_dec(&cbq->cb->refcnt);
> > > 	smp_mb__after_atomic_inc();
> > > 
> > > 	cbq->destruct_data(cbq->ddata);
> > > }
> > 
> > What on earth are all these barriers for?  Barriers should have an
> > associated comment describing why they were added, and what they are
> > defending against, becuase it is very hard to tell that from reading the
> > code.
> > 
> > Please describe (via code comments) what the refcounting rules are for
> > these data structures.  It all looks very strange.  You basically have:
> > 
> > 
> > 	atomic_inc(refcnt);
> > 	use(some_object);
> > 	atomic_dec(refcnt);
> > 
> > Which looks very racy.  Some other CPU could see a zero refcount just
> > before this CPU did the atomic_inc() and the other CPU will go and free up
> > some_object.  There should be locking associated with refcounting to
> > prevent such races, and I don't see any.
> 
> It can not happen in the above case.
> It can race with callback removing, but remove path 
> call cancel_delayed_work() which calls del_timer_sync(), 
> so above code can not be run or will not run, 
> only after it refcnt is being checked to be zero.
> It is probably an overhead since sinchronization is done
> in other places.
> All above barriers are introduced to remove already not theoretical
> atomic vs. non-atomic reordering [ppc64 very like it],
> when reference counter must be decremented after object was used, 
> but due to reordering it can happen before use [and it will be seen
> atomically on all CPUs], 
> and other CPU may free object based on knowledge that
> refcnt is zero.

But all the above seems to be tied into the
poll-until-refcount-goes-to-zero cleanup code.  I think - it's quite
unclear what the refcount protocol is for these objects.

Why cannot we manage object lifetimes here in the same manner as dentries,
inodes, skbuffs, etc?

> > > static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct cn_callback *cb)
> > 
> > 80 cols again.
> > 
> > > static void cn_queue_free_callback(struct cn_callback_entry *cbq)
> > > {
> > > 	cancel_delayed_work(&cbq->work);
> > > 
> > > 	while (atomic_read(&cbq->cb->refcnt)) {
> > > 		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
> > > 		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
> > > 
> > > 		msleep_interruptible(1000);
> > > 
> > > 		if (current->flags & PF_FREEZE)
> > > 			refrigerator(PF_FREEZE);
> > > 
> > > 		if (signal_pending(current))
> > > 			flush_signals(current);
> > > 	}
> > > 
> > > 	kfree(cbq);
> > > }
> > 
> > erp.  Can you please do this properly?
> > 
> > Free the object on the refcount going to zero (with appropriate locking)? 
> > If you want (for some reason) to wait until all users of an object have
> > gone away then you should take a ref on the object (inside locking), then
> > sleep on a waitqueue_head embedded in that object.  Make all
> > refcount-droppers do a wake_up.
> > 
> > Why is this function playing with signals?
> 
> It is not, just can be interrupted to check state befor timeout expires.
> It is not a problem to remove signal interrupting here.

If this function is called by userspace tasks then we've just dumped any
signals which that task might have had pending.

> > > 			break;
> > > 		}
> > > 	}
> > > 	if (!found) {
> > > 		atomic_set(&cbq->cb->refcnt, 1);
> > > 		list_add_tail(&cbq->callback_entry, &dev->queue_list);
> > > 	}
> > > 	spin_unlock_bh(&dev->queue_lock);
> > 
> > Why use spin_lock_bh()?  Does none of this code ever get called from IRQ
> > context?
> 
> Test documentation module that lives in
> Documentation/connector/cn_test.c
> describes different usage cases for connector, and it uses
> cn_netlink_send()
> from irq context, which may race with the callback adding/removing.

But cn_netlink_send() takes ->queue_lock.  If this CPU happened to be
holding the same lock in process or bh context it will deadlock in IRQ
context.

> 
> > 
> > > struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *nls)
> > > {
> > > 	struct cn_queue_dev *dev;
> > > 
> > > 	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
> > > 	if (!dev) {
> > > 		printk(KERN_ERR "%s: Failed to allocte new struct cn_queue_dev.\n",
> > > 		       name);
> > > 		return NULL;
> > > 	}
> > > 
> > > 	memset(dev, 0, sizeof(*dev));
> > > 
> > > 	snprintf(dev->name, sizeof(dev->name), "%s", name);
> > 
> > scnprintf?
> 
> Return value is ignored here, but I will change function though.

scnprintf() null-terminates the destination even if it hits the end of its
buffer.

> > 
> > Again, why is this code playing with signals?  Hopefully it is never called
> > by user tasks - that would be very bad.
> 
> I will remove signal interrupting.

And use the kthread API, please.

> According to wait queue inside the object - it can have it, but it will
> be used only for waiting and repeated checking in a slow path.
> Let's postpone it for now until other isssues are resolved first.

This all ties into the refcounting and object lifetime design.  What you
have there appears quite unconventional.  Maybe there's good reason for
that and maybe the code is race-free.  I don't understand what you've done
there sufficiently well to be able to say.

> > With proper refcounting and lifetime management and the use of the kthread
> > API we should be able to make all this go away.
> > 
> > Once we're trying to free up the controlling device, what prevents new
> > messages from being queued?
> 
> Before callback device is removed it is unregistered from the callback
> subsystem,
> so all messages will be discarded, until main socket is removed
> (actually only released so it can be properly freed in network subsystem
> later).
> 

OK, I missed that.

