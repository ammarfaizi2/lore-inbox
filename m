Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966680AbWKTUtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966680AbWKTUtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966690AbWKTUtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:49:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:38032 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S966680AbWKTUtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:49:49 -0500
Date: Mon, 20 Nov 2006 12:51:06 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120205106.GI8033@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061120185712.GA95@oleg> <Pine.LNX.4.44L0.0611201439350.7569-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201439350.7569-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 03:01:59PM -0500, Alan Stern wrote:
> On Mon, 20 Nov 2006, Oleg Nesterov wrote:
> 
> > On 11/20, Alan Stern wrote:
> > >
> > > @@ -158,6 +199,11 @@ void synchronize_srcu(struct srcu_struct
> > >
> > > [... snip ...]
> > >
> > > +#ifdef	SMP__STORE_MB_LOAD_WORKS	/* The fast path */
> > > +	if (srcu_readers_active_idx(sp, idx) == 0)
> > > +		goto done;
> > > +#endif
> >
> > I guess this is connected to another message from you,
> 
> Yes.
> 
> > > But of course it _is_ needed for the fastpath to work.  In fact, it might
> > > not be good enough, depending on the architecture.  Here's what the
> > > fastpath ends up looking like (using c[idx] is essentially the same as
> > > using hardluckref):
> > >
> > >         WRITER                          READER
> > >         ------                          ------
> > >         dataptr = &(new data)           atomic_inc(&hardluckref)
> > >         mb                              mb
> > >         while (hardluckref > 0) ;       access *dataptr
> > >
> > > Notice the pattern: Each CPU does store-mb-load.  It is known that on
> > > some architectures each CPU can end up loading the old value (the value
> > > from before the other CPU's store).  This would mean the writer would see
> > > hardluckref == 0 right away and the reader would see the old dataptr.
> >
> > So, if we have global A == B == 0,
> >
> > 	CPU_0		CPU_1
> >
> > 	A = 1;		B = 2;
> > 	mb();		mb();
> > 	b = B;		a = A;
> >
> > It could happen that a == b == 0, yes?
> 
> Exactly.
> 
> > Isn't this contradicts with definition
> > of mb?
> 
> One might think so, at first.  But if you do a careful search, you'll find
> that there _is_ no definition of mb!  People state in vague terms what
> it's supposed to do, but they are almost never specific enough to tell
> whether the example above should work.

Yep -- mb() is currently defined only for specific CPUs.  :-/

Some Linux kernel code has been written by considering each SMP-capable
CPU in turn, but that does not scale with increasing numbers of SMP-capable
CPUs.

> > By definition, when CPU_0 issues 'b = B', 'A = 1' should be visible to other
> > CPUs, yes?
> 
> No.  Memory barriers don't guarantee that any particular store will become
> visible to other CPUs at any particular time.  They guarantee only that a
> certain sequence of stores will become visible in a particular order
> (provided the other CPUs also use the correct memory barriers).
> 
> >  Now, b == 0 means that CPU_1 did not read 'a = A' yet, otherwise
> > 'B = 2' should be visible to all CPUs (by definition again).
> >
> > Could you please clarify this?
> 
> Here's an example showing how the code can fail.  (Paul can correct me if
> I get this wrong.)

Looks good to me!

							Thanx, Paul
