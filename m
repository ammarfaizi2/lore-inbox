Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966603AbWKTUCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966603AbWKTUCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966610AbWKTUCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:02:01 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:7559 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966603AbWKTUCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:02:00 -0500
Date: Mon, 20 Nov 2006 15:01:59 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061120185712.GA95@oleg>
Message-ID: <Pine.LNX.4.44L0.0611201439350.7569-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Oleg Nesterov wrote:

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

Yes.

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
> It could happen that a == b == 0, yes?

Exactly.

> Isn't this contradicts with definition
> of mb?

One might think so, at first.  But if you do a careful search, you'll find
that there _is_ no definition of mb!  People state in vague terms what
it's supposed to do, but they are almost never specific enough to tell
whether the example above should work.

> By definition, when CPU_0 issues 'b = B', 'A = 1' should be visible to other
> CPUs, yes?

No.  Memory barriers don't guarantee that any particular store will become 
visible to other CPUs at any particular time.  They guarantee only that a 
certain sequence of stores will become visible in a particular order 
(provided the other CPUs also use the correct memory barriers).

>  Now, b == 0 means that CPU_1 did not read 'a = A' yet, otherwise
> 'B = 2' should be visible to all CPUs (by definition again).
> 
> Could you please clarify this?

Here's an example showing how the code can fail.  (Paul can correct me if 
I get this wrong.)

	"A = 1" and "B = 2" are issued simultaneously.  The two caches
	send out Invalidate messages, and each queues the message it
	receives for later processing.

	Both CPUs execute their "mb" instructions.  The mb forces each
	cache to wait until it receives an Acknowdgement for the 
	Invalidate it sent.

	Both caches send an Acknowledgement message to the other.  The
	mb instructions complete.

	"b = B" and "a = A" execute.  The caches return A==0 and B==0
	because they haven't yet invalidated their cache lines.

	Cache 0 invalidates its line for B and Cache 1 invalidates its
	line for A.  But it's already too late.

The reason the code failed is because the mb instructions didn't force
the caches to wait until the Invalidate messages in their queues had been 
fully carried out (i.e., the lines had actually been invalidated).  This 
is because at the time the mb started, those messages had not been 
acknowledged -- they were just sitting in the cache's invalidate queue.


> Btw, this is funny, but I was going to suggest _exactly_ same cleanup for
> srcu_read_lock :)

I guess we think alike!

Alan

