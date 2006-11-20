Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966659AbWKTUhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966659AbWKTUhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966661AbWKTUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:37:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39639 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S966659AbWKTUhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:37:54 -0500
Date: Mon, 20 Nov 2006 12:38:37 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120203836.GH8033@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org> <20061120185712.GA95@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120185712.GA95@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 09:57:12PM +0300, Oleg Nesterov wrote:
> On 11/20, Alan Stern wrote:
> >
> > @@ -158,6 +199,11 @@ void synchronize_srcu(struct srcu_struct
> >
> > [... snip ...]
> >
> > +#ifdef	SMP__STORE_MB_LOAD_WORKS	/* The fast path */
> > +	if (srcu_readers_active_idx(sp, idx) == 0)
> > +		goto done;
> > +#endif
> 
> I guess this is connected to another message from you,
> 
> > But of course it _is_ needed for the fastpath to work.  In fact, it might
> > not be good enough, depending on the architecture.  Here's what the
> > fastpath ends up looking like (using c[idx] is essentially the same as
> > using hardluckref):
> >
> >         WRITER                          READER
> >         ------                          ------
> >         dataptr = &(new data)           atomic_inc(&hardluckref)
> >         mb                              mb
> >         while (hardluckref > 0) ;       access *dataptr
> >
> > Notice the pattern: Each CPU does store-mb-load.  It is known that on
> > some architectures each CPU can end up loading the old value (the value
> > from before the other CPU's store).  This would mean the writer would see
> > hardluckref == 0 right away and the reader would see the old dataptr.
> 
> So, if we have global A == B == 0,
> 
> 	CPU_0		CPU_1
> 
> 	A = 1;		B = 2;
> 	mb();		mb();
> 	b = B;		a = A;
> 
> It could happen that a == b == 0, yes? Isn't this contradicts with definition
> of mb?

It can and does happen.  -Which- definition of mb()?  ;-)

To see how this can happen, thing of the SMP system as a message-passing
system, and consider the following sequence of events:

o	The cache line for A is initially in CPU 1's cache, and the
	cache line for B is initially in CPU 0's cache (backwards of
	what you would want knowing about the upcoming writes).

o	CPU 0 stores to A, but because A is not in cache, places it in
	CPU 0's store queue.  It also puts out a request for ownership
	of the cache line containing A.

o	CPU 1 stores to B, with the same situation as for CPU 0's store
	to A.

o	Both CPUs execute an mb(), which ensures that any subsequent writes
	follow the writes to A and B, respectively.  Since neither CPU
	has yet received the other CPU's request for ownership, there is
	no ordering effects on subsequent reads.

o	CPU 0 executes "b = B", and since B is in CPU 0's cache, it loads
	the current value, which is zero.

o	Ditto for CPU 1 and A.

o	CPUs 0 and 1 now receive each other's requests for ownership, so
	exchange the cache lines containing A and B.

o	Once CPUs 0 and 1 receive ownership of the respective cache lines,
	they complete their writes to A and B (moving the values from the
	store buffers to the cache lines).

> By definition, when CPU_0 issues 'b = B', 'A = 1' should be visible to other
> CPUs, yes? Now, b == 0 means that CPU_1 did not read 'a = A' yet, otherwise
> 'B = 2' should be visible to all CPUs (by definition again).
> 
> Could you please clarify this?

See above...

> Btw, this is funny, but I was going to suggest _exactly_ same cleanup for
> srcu_read_lock :)

;-)

							Thanx, Paul
