Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVAYOYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVAYOYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAYOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:24:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18332 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261955AbVAYOYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:24:00 -0500
Date: Tue, 25 Jan 2005 14:23:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125142356.GA20206@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106662284.5257.53.camel@uganda>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +obj-$(CONFIG_SC_SUPERIO)	+= superio.o
> > +obj-$(CONFIG_SC_GPIO)		+= sc_gpio.o
> > +obj-$(CONFIG_SC_ACB)		+= sc_acb.o
> > +obj-$(CONFIG_SC_PC8736X)	+= pc8736x.o
> > +obj-$(CONFIG_SC_SCX200)		+= scx200.o
> > +
> > +superio-objs		:= sc.o chain.o sc_conn.o
> > 
> > please use superio-y += so new conditional objects can be added more easily.
> 
> They must be added in the same file and line to allow easy control.
> It is not directory like char/.

Huh?

What I mean is you should write

superio-y		+= sc.o chain.o sc_conn.o

this allows adding things like

superio-$(CONFIG_FOO)	+= sc_foo.o

and is generally the canonical form since 2.6

> > +void chain_free(struct dev_chain *ch)
> > +{
> > +	memset(ch, 0, sizeof(struct dev_chain));
> > +	kfree(ch);
> > 
> > The memset completely defeats slab redzoning to catch bugs, don't
> > do that.
> 
> What? Does following code also kills redzoning?
> 
> int *a;
> a = kmalloc();
> if (a)
> {
> 	memset(a, 0, sizeof(*a));
> 	kfree(a);
> }
> 
> Consider size of the dev_chain structure...

Sorry, didn't mean redzoning but poisoning in general, little
brainfart on my side.  The slab code can set freed objects to
known patters so use after frees can be debugged easily, and
by zeroing a structure before freeing we lose that.

> > Also what's the reason you can't simply put the list_head into struct
> > logical_dev?
> 
> Because it is not just list_head, but special structure used for special
> pointer manipulations,
> which you are obviously saw in sc.c 

No, I didn't see it.  I see that the void pointer ptr in struct dev_chain
always points to a struct sc_dev *, and I see we never change that
pointer at run time.  I might have missed something obvious, so maybe
you could point me to it (or even better add a comment describing it)

> 
> > +static void pc8736x_fini(void)
> > +{
> > +	sc_del_sc_dev(&pc8736x_dev);
> > +
> > +	while (atomic_read(&pc8736x_dev.refcnt)) {
> > +		printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
> > +				pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
> > +		
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(HZ);
> > +			
> > +		if (current->flags & PF_FREEZE)
> > +			refrigerator(PF_FREEZE);
> > +
> > +		if (signal_pending(current))
> > +			flush_signals(current);
> > +	}
> > +}
> > 
> > And who gurantess this won't deadlock?  Please use a dynamically allocated
> > driver model device and it's refcounting, thanks.
> 
> Sigh.
> 
> Christoph, please read the code before doing such comments.
> I very respect your review and opinion, but only until you respect
> others.

The code above pretty much means you can keep rmmod stalled forever.

Also it seems to be the only code intree doing refrigerator() on anything
but kernel thread.  While I can't comment on swsusp internals it surely
looks buggy to me.
 
> > +#ifndef __SCX200_H
> > +#define __SCX200_H
> > +
> > +#define SCx200_GPIO_SIZE 	0x2c
> > +
> > +#endif /* __SCX200_H */
> > 
> > Yeah, right - a 30 line header for a single define that's used in a
> > single source file..
> 
> Christoph, do you know what SuperIO is?
> I doubt...
> 
> It is a small chip, which can include various number of devices.
> SuperIO currently supports only GPIO and ACB, so this header only
> includes
> one define. I do not have hardware(sc1100 based for example) that
> "exports"
> other devices and which can be accessed from the outside of the board, 
> so I did not add other defines.
> 
> But specially for you I can remove this file, will it satisfy you?

I've just told you it looks extremly silly, you need to decide on your
own whether it's worthwile.

> > Also your locking is broken.  sdev_lock sometimes nests outside
> > sdev->lock and sometimes inside.  Similarly dev->chain_lock nests
> > inside dev->lock sometimes and sometimes outside.  You really need
> > a locking hiearchy document and the lockign should probably be
> > simplified a lot.
> 
> It is almost the same like after hand waving say that there is a wind.
> 
> Each lock protect it's own data, sometimes it happens when other data is
> locked, 
> sometimes not. Yes, probably interrupt handling can race, it requires
> more review,
> I will take a look.

The thing I mention is called lock order reversal, which means a deadlock
in most cases.  I don't have the time to actual walk through all codepathes
to tell you whether it can really happen and where, but it's a really
big warning sign.

> Resume:
> Cristoph, you rudely try to show that this code is badly broken.
> It is not.
> It was tested as opposed to your claims, and works as expected.

I've seen tons of code that "works as expected" but still is buggy.
That's why code needs to be both tested (with a workload as
expected and other stress testing that shows it handles loads _not_
expected) and reviewed for errors that don't happen with a normal
load or design problems.

