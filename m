Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWHLIzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWHLIzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 04:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWHLIzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 04:55:49 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:22400 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932481AbWHLIzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 04:55:47 -0400
Date: Sat, 12 Aug 2006 12:55:02 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take8 2/2] kevent: poll/select() notifications. Timer notifications.
Message-ID: <20060812085502.GB29523@2ka.mipt.ru>
References: <11552856103972@2ka.mipt.ru> <11552856102674@2ka.mipt.ru> <20060811084531.ac727a7b.akpm@osdl.org> <20060812081835.GA30248@2ka.mipt.ru> <20060812013835.b4b6b815.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060812013835.b4b6b815.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 12:55:04 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:38:35AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> On Sat, 12 Aug 2006 12:18:35 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > On Fri, Aug 11, 2006 at 08:45:31AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > > > +static struct lock_class_key kevent_poll_key;
> > > > +
> > > > +void kevent_poll_reinit(struct file *file)
> > > > +{
> > > > +	lockdep_set_class(&file->st.lock, &kevent_poll_key);
> > > > +}
> > > 
> > > Why is this necessary?
> > 
> > Locks for all storages are initialized in the same function, so lockdep thinks 
> > they are the same, so when later one lock is being held in proces
> > context and other in BH or IRQ lockdep screams, so I reinitialize locks
> > after spin_lock_init().
> 
> So why not simply run spin_lock_init() in the kevent_storage_init() caller?

I separated storage initialization into special function, although it is
quite simple, but it allows not to have a lot of duplicated steps in
each origin (inode, socket, file, AIO, network AIO, poll, timer and so
on). If later some members will be changed or added/removed there will
be no need to change them all instead change one function.

> Does kevent_poll_reinit() have any callers?

Only poll nitialization.

> > > > +	st = (struct kevent_storage *)(t+1);
> > > 
> > > It would be cleaner to create
> > > 
> > > 	struct <something> {
> > > 		struct timer_list timer;
> > > 		struct kevent_storage storage;
> > > 	};
> 
> You missed this?

No problem, I will create such structure instead of pointer-based
scheme.
 
> > > > +	
> > > > +	kevent_storage_dequeue(st, k);
> > > > +	
> > > > +	kfree(t);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int kevent_timer_callback(struct kevent *k)
> > > > +{
> > > > +	struct kevent_storage *st = k->st;
> > > > +	struct timer_list *t = st->origin;
> > > > +
> > > > +	if (!t)
> > > > +		return -ENODEV;
> > > > +	
> > > > +	k->event.ret_data[0] = (__u32)jiffies;
> > > 
> > > What does this do?
> > > 
> > > Does it expose jiffies to userspace?
> > > 
> > > It truncates jiffies on 64-bit machines.
> > 
> > It is a hint when timer was stopped.
> 
> What does that mean?  What is it for?

My test code prints it to stdout and I can show a nice graph of how
precise timer is.

> Does it expose jiffies to userspace?

It is a timestamp of fired condition (measured in jiffies), I can not
say if it exposes jiffies to userspace or not.
It is not a requirement to use that field, it can contain zero or any
other number, I placed jiffies there.

> It truncates jiffies on 64-bit machines.

For the purpose of evnt timestamp it is more than enough.

> Please respond to all review comments and questions.

Sorry if something got lost.

> > > > +late_initcall(kevent_init_timer);
> > > 
> > > module_init() would be more typical.  If there was a reason for using
> > > late_initcall(), that reason should be commented.
> > 
> > No, there are no reasons to use late_initcall() in any kevent
> > initialization function, I do not use module_init() since kevent can not
> > be modular. It can be replaced with pure __init function.
> > Should it?
> 
> We use module_init() for non-modular modules all the time.  Try doing
> grep module_init */*.c

Ok, I will use it instead late_initcall().

-- 
	Evgeniy Polyakov
