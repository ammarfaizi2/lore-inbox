Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWHLITj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWHLITj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWHLITj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 04:19:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30444 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932339AbWHLITi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 04:19:38 -0400
Date: Sat, 12 Aug 2006 12:18:35 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take8 2/2] kevent: poll/select() notifications. Timer notifications.
Message-ID: <20060812081835.GA30248@2ka.mipt.ru>
References: <11552856103972@2ka.mipt.ru> <11552856102674@2ka.mipt.ru> <20060811084531.ac727a7b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060811084531.ac727a7b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 12:18:37 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 08:45:31AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > +static struct lock_class_key kevent_poll_key;
> > +
> > +void kevent_poll_reinit(struct file *file)
> > +{
> > +	lockdep_set_class(&file->st.lock, &kevent_poll_key);
> > +}
> 
> Why is this necessary?

Locks for all storages are initialized in the same function, so lockdep thinks 
they are the same, so when later one lock is being held in proces
context and other in BH or IRQ lockdep screams, so I reinitialize locks
after spin_lock_init().

> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/timer.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kevent.h>
> > +
> > +static void kevent_timer_func(unsigned long data)
> > +{
> > +	struct kevent *k = (struct kevent *)data;
> > +	struct timer_list *t = k->st->origin;
> > +
> > +	kevent_storage_ready(k->st, NULL, KEVENT_MASK_ALL);
> > +	mod_timer(t, jiffies + msecs_to_jiffies(k->event.id.raw[0]));
> > +}
> > +
> > +static struct lock_class_key kevent_timer_key;
> > +
> > +static int kevent_timer_enqueue(struct kevent *k)
> > +{
> > +	struct timer_list *t;
> > +	struct kevent_storage *st;
> > +	int err;
> > +
> > +	t = kmalloc(sizeof(struct timer_list) + sizeof(struct kevent_storage), 
> > +			GFP_KERNEL);
> > +	if (!t)
> > +		return -ENOMEM;
> > +
> > +	init_timer(t);
> > +	t->function = kevent_timer_func;
> > +	t->expires = jiffies + msecs_to_jiffies(k->event.id.raw[0]);
> > +	t->data = (unsigned long)k;
> 
> setup_timer().

I know about it's existens now...

> > +	st = (struct kevent_storage *)(t+1);
> 
> It would be cleaner to create
> 
> 	struct <something> {
> 		struct timer_list timer;
> 		struct kevent_storage storage;
> 	};
> 
> > +	err = kevent_storage_init(t, st);
> > +	if (err)
> > +		goto err_out_free;
> > +	lockdep_set_class(&st->lock, &kevent_timer_key);
> 
> Why is this necesary?

As I said above kevent_storage_init() initializes locks for all known
storages (inode, socket, file and so on), when later those locks are
called from different contexts (obviously timer callback can not use the
same lock as for example socket one) lockdep screams.

> > +	
> > +	kevent_storage_dequeue(st, k);
> > +	
> > +	kfree(t);
> > +
> > +	return 0;
> > +}
> > +
> > +static int kevent_timer_callback(struct kevent *k)
> > +{
> > +	struct kevent_storage *st = k->st;
> > +	struct timer_list *t = st->origin;
> > +
> > +	if (!t)
> > +		return -ENODEV;
> > +	
> > +	k->event.ret_data[0] = (__u32)jiffies;
> 
> What does this do?
> 
> Does it expose jiffies to userspace?
> 
> It truncates jiffies on 64-bit machines.

It is a hint when timer was stopped.

> > +late_initcall(kevent_init_timer);
> 
> module_init() would be more typical.  If there was a reason for using
> late_initcall(), that reason should be commented.

No, there are no reasons to use late_initcall() in any kevent
initialization function, I do not use module_init() since kevent can not
be modular. It can be replaced with pure __init function.
Should it?

-- 
	Evgeniy Polyakov
