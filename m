Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWHULUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWHULUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWHULUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:20:34 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:22942 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964954AbWHULUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:20:33 -0400
Date: Mon, 21 Aug 2006 15:18:48 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       tglx@linutronix.de
Subject: Re: [take12 3/3] kevent: Timer notifications.
Message-ID: <20060821111848.GB8608@2ka.mipt.ru>
References: <11561555893621@2ka.mipt.ru> <1156155589287@2ka.mipt.ru> <20060821111239.GA30945@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060821111239.GA30945@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 21 Aug 2006 15:18:50 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 12:12:39PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Mon, Aug 21, 2006 at 02:19:49PM +0400, Evgeniy Polyakov wrote:
> > 
> > 
> > Timer notifications.
> > 
> > Timer notifications can be used for fine grained per-process time 
> > management, since interval timers are very inconvenient to use, 
> > and they are limited.
> 
> Shouldn't this at leat use a hrtimer?

Not everymachine has them and getting into account possibility that
userspace can be scheduled away, it will be overkill.

> > new file mode 100644
> > index 0000000..5217cd1
> > --- /dev/null
> > +++ b/kernel/kevent/kevent_timer.c
> > @@ -0,0 +1,107 @@
> > +/*
> > + * 	kevent_timer.c
> 
> You still include those sill filename ontop of file comments..

Sorry, it looks like I updated not every file.

> > +static struct lock_class_key kevent_timer_key;
> > +
> > +static int kevent_timer_enqueue(struct kevent *k)
> > +{
> > +	int err;
> > +	struct kevent_timer *t;
> > +
> > +	t = kmalloc(sizeof(struct kevent_timer), GFP_KERNEL);
> > +	if (!t)
> > +		return -ENOMEM;
> > +
> > +	setup_timer(&t->ktimer, &kevent_timer_func, (unsigned long)k);
> > +
> > +	err = kevent_storage_init(&t->ktimer, &t->ktimer_storage);
> > +	if (err)
> > +		goto err_out_free;
> > +	lockdep_set_class(&t->ktimer_storage.lock, &kevent_timer_key);
> 
> When looking at the kevent_storage_init callers most need to do
> those lockdep_set_class class.  Shouldn't kevent_storage_init just
> get a "struct lock_class_key *" argument?

It will not work, since inode is used for both socket and inode
notifications (to save some space in struct sock), lockdep initalization
is performed on the highest level, so I put it alone.

> > +static int kevent_timer_callback(struct kevent *k)
> > +{
> > +	k->event.ret_data[0] = (__u32)jiffies;
> 
> This is returned to userspace, isn't it?  raw jiffies should never be
> user-visible.  Please convert this to an unit that actually makes sense
> for userspace (probably nanoseconds)

It is just to show something, my userspace application just prints it to
stdout to show kernelspace difference between events.
Andrew pointed to it too, I think it is easier to just remove this string.

> > +static int __init kevent_init_timer(void)
> > +{
> > +	struct kevent_callbacks tc = {
> > +		.callback = &kevent_timer_callback, 
> > +		.enqueue = &kevent_timer_enqueue, 
> > +		.dequeue = &kevent_timer_dequeue};
> 
> I think this should be static, and the normal style to write it would be:
> 
> static struct kevent_callbacks tc = {
> 	.callback	= kevent_timer_callback,
> 	.enqueue	= kevent_timer_enqueue,
> 	.dequeue	= kevent_timer_dequeue,
> };
> 
> also please consider makring all the kevent_callbacks structs const
> to avoid false cacheline sharing and accidental modification, similar
> to what we did to various other operation vectors.

Ok.

-- 
	Evgeniy Polyakov
