Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWHKPpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWHKPpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHKPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:45:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12782 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932071AbWHKPpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:45:51 -0400
Date: Fri, 11 Aug 2006 08:45:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take8 2/2] kevent: poll/select() notifications. Timer
 notifications.
Message-Id: <20060811084531.ac727a7b.akpm@osdl.org>
In-Reply-To: <11552856102674@2ka.mipt.ru>
References: <11552856103972@2ka.mipt.ru>
	<11552856102674@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 12:40:10 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> 
> poll/select() notifications. Timer notifications.
> 
> This patch includes generic poll/select and timer notifications.
> 
> kevent_poll works simialr to epoll and has the same issues (callback
> is invoked not from internal state machine of the caller, but through
> process awake).
> 
> Timer notifications can be used for fine grained per-process time 
> management, since interval timers are very inconvenient to use, 
> and they are limited.
> 
> ...
>
> +static struct lock_class_key kevent_poll_key;
> +
> +void kevent_poll_reinit(struct file *file)
> +{
> +	lockdep_set_class(&file->st.lock, &kevent_poll_key);
> +}

Why is this necessary?

> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer.h>
> +#include <linux/jiffies.h>
> +#include <linux/kevent.h>
> +
> +static void kevent_timer_func(unsigned long data)
> +{
> +	struct kevent *k = (struct kevent *)data;
> +	struct timer_list *t = k->st->origin;
> +
> +	kevent_storage_ready(k->st, NULL, KEVENT_MASK_ALL);
> +	mod_timer(t, jiffies + msecs_to_jiffies(k->event.id.raw[0]));
> +}
> +
> +static struct lock_class_key kevent_timer_key;
> +
> +static int kevent_timer_enqueue(struct kevent *k)
> +{
> +	struct timer_list *t;
> +	struct kevent_storage *st;
> +	int err;
> +
> +	t = kmalloc(sizeof(struct timer_list) + sizeof(struct kevent_storage), 
> +			GFP_KERNEL);
> +	if (!t)
> +		return -ENOMEM;
> +
> +	init_timer(t);
> +	t->function = kevent_timer_func;
> +	t->expires = jiffies + msecs_to_jiffies(k->event.id.raw[0]);
> +	t->data = (unsigned long)k;

setup_timer().

> +	st = (struct kevent_storage *)(t+1);

It would be cleaner to create

	struct <something> {
		struct timer_list timer;
		struct kevent_storage storage;
	};

> +	err = kevent_storage_init(t, st);
> +	if (err)
> +		goto err_out_free;
> +	lockdep_set_class(&st->lock, &kevent_timer_key);

Why is this necesary?

> +	
> +	kevent_storage_dequeue(st, k);
> +	
> +	kfree(t);
> +
> +	return 0;
> +}
> +
> +static int kevent_timer_callback(struct kevent *k)
> +{
> +	struct kevent_storage *st = k->st;
> +	struct timer_list *t = st->origin;
> +
> +	if (!t)
> +		return -ENODEV;
> +	
> +	k->event.ret_data[0] = (__u32)jiffies;

What does this do?

Does it expose jiffies to userspace?

It truncates jiffies on 64-bit machines.

> +late_initcall(kevent_init_timer);

module_init() would be more typical.  If there was a reason for using
late_initcall(), that reason should be commented.

