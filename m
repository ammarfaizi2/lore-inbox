Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967583AbWK2T2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967583AbWK2T2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967584AbWK2T2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:28:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5769 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S967583AbWK2T2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:28:45 -0500
Date: Wed, 29 Nov 2006 11:29:53 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061129192953.GA2335@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg> <20061127050247.GC5021@us.ibm.com> <20061127161106.GA279@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127161106.GA279@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 07:11:06PM +0300, Oleg Nesterov wrote:
> On 11/26, Paul E. McKenney wrote:
> >
> > Looks pretty good, actually.  A few quibbles below.  I need to review
> > again after sleeping on it.
> 
> Thanks! Please also look at spinlock-based implementation,
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=116457701231964
> 
> I must admit, Alan was right: it really looks simpler and the perfomance
> penalty should be very low. I personally hate this additional spinlock
> per se as a "unneeded complication", but probably you will like it more.

The two have different advantages and disadvantages, but nothing really
overwhelming either way.  Here is my take:

1.	The spinlock version will be easier for most people to understand.

2.	The atomic version has better read-side overhead -- probably
	roughly twice as fast on most machines.

3.	The atomic version will have better worst-case latency under
	heavy read-side load -- at least assuming that the underlying
	hardware is fair.

4.	The spinlock version would have better fairness in face of
	synchronize_xxx() overload.

5.	Neither version can be used from irq (but the same is true of
	SRCU as well).

If I was to choose, I would probably go with the easy-to-understand
case, which would push me towards the spinlocks.  If there is a
read-side performance problem, then the atomic version can be easily
resurrected from the LKML archives.  Maybe have a URL in a comment
pointing to the atomic implementation?  ;-)

All this assuming that the spinlock version passes rcutorture, of course!!!

> > > +int xxx_read_lock(struct xxx_struct *sp)
> > > +{
> > > +	for (;;) {
> > > +		int idx = sp->completed & 0x1;
> >
> > Might need a comment saying why no rcu_dereference() needed on the
> > preceding line.  The reason (as I understand it) is that we are
> > only doing atomic operations on the element being indexed.
> 
> My understanding is the same. Actually, smp_read_barrier_depends() can't
> help because 'atomic_inc' and '->completed++' in synchronize_xxx() could
> be re-ordered anyway, so we should rely on correctness of atomic_t.

Fair enough!

> > > +		if (likely(atomic_inc_not_zero(sp->ctr + idx)))
> > > +			return idx;
> > > +	}
> > > +}
> >
> > The loop seems absolutely necessary if one wishes to avoid a
> > synchronize_sched() in synchronize_xxx() below (and was one of the things
> > I was missing earlier).  However, isn't there a possibility that a pile
> > of synchronize_xxx() calls might indefinitely delay an unlucky reader?
> 
> Note that synchronize_xxx() does nothing when there are no readers under
> xxx_read_lock(), so
> 
> 	for (;;)
> 		synchronize_xxx();
> 
> can't suspend xxx_read_lock(). atomic_inc_not_zero() fails when something like
> the events below happen between 'idx = sp->completed' and 'atomic_inc_not_zero'
> 
> 	- another reader does xxx_read_lock(), increments ->ctr.
> 
> 	- synchronize_xxx() notices it, goes to __wait_event()
> 
> 	- both the reader and writer manage to do atomic_dec()
> 
> This is possible in theory, but indefinite delay... Look, we have the same
> "problem" with spinlocks: in theory synchronize_xxx() calls might indefinitely
> delay an unlucky reader because synchronize_xxx() always wins spin_lock(&sp->lock);

True enough!  Again, the only way I can see to avoid the possibility of
indefinite delay is to make the updater do synchronize_sched(), which
is what we were trying to avoid in the first place.  ;-)

> > > +
> > > +void xxx_read_unlock(struct xxx_struct *sp, int idx)
> > > +{
> > > +	if (unlikely(atomic_dec_and_test(sp->ctr + idx)))
> > > +		wake_up(&sp->wq);
> > > +}
> > > +
> > > +void synchronize_xxx(struct xxx_struct *sp)
> > > +{
> > > +	int idx;
> > > +
> > > +	mutex_lock(&sp->mutex);
> > > +
> > > +	idx = sp->completed & 0x1;
> > > +	if (!atomic_add_unless(sp->ctr + idx, -1, 1))
> > > +		goto out;
> > > +
> > > +	atomic_inc(sp->ctr + (idx ^ 0x1));
> > > +	sp->completed++;
> > > +
> > > +	__wait_event(sp->wq, !atomic_read(sp->ctr + idx));
> > > +out:
> > > +	mutex_unlock(&sp->mutex);
> > > +}
> >
> > Test code!!!  Very good!!!  (This is added to rcutorture, right?)
> 
> Yes, the whole patch goes to kernel/rcutorture.c, it is only for
> testing/review.
> 
> Note: I suspect that Documentation/ lies about atomic_add_unless(), see
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=116448966030359

Hmmm...  Some do and some don't:

Alpha:	Does a memory barrier after (but not before) via cmpxchg().

arm:	No clue.  http://www.arm.com/pdfs/DUI0204G_rvct_assembler_guide.pdf
	does not seem to say much about memory-ordering issues.
	There are no obvious memory-barrier instructions, but I
	don't see what (if any) ordering effects that ldrex or
	strexeq might or might not have.

arm26:	No SMP support, so no problem.

cris:	Uses hashed spinlocks, so probably OK.  (Are cris spinlocks
	"leaky" in the ia64 sense?  If so, then -not- OK.)

frv:	No SMP support, so no problem.

h8300:	No SMP support, despite having code under CONFIG_SMP.
	In any case, local_irq_save() doesn't do much for SMP.
	(Right?  Or does h8300 do something special here?)

i386:	The x86 semantics, as I understand them, are in fact equivalent
	to having a memory barrier before and after the operation.
	However, the documentation I have is not as clear as it might be.

ia64:	"Acquire" semantics, so that earlier operations may be reordered
	after the atomic_add_unless(), but later operations may -not-
	be reordered before atomic_add_unless().

m32r:	Don't know much about m32r, but it does have an CONFIG_SMP
	implementation.

m68k:	I don't know what memory-barrier semantics the "cas" instructions
	provide.  A quick Google search was not helpful.

mips:	Seems to have a memory barrier only after, not before.
	http://www.mips.com/content/PressRoom/TechLibrary/WhitePapers/multi_cpu
	seem to indicate that the semantics of the "sync" instruction
	depend on hardware external to the CPU.

parisc:	Implements atomic_add_unless() with a spinlock, so probably	
	does memory barrier before and after (I believe parisc does
	not have "leaky" spinlock primitives like ia64 does).

powerpc: lwsync before and isync after.

s390:	The "cs" (compare-and-swap) instruction does serialization
	equivalent to memory barrier before and after.

sh:	No SMP support, despite having code under CONFIG_SMP.
	In any case, local_irq_save() doesn't do much for SMP.
	(Right?  Or does "sh" do something special here?)

sh64:	No SMP support, despite having code under CONFIG_SMP.
	In any case, local_irq_save() doesn't do much for SMP.
	(Right?  Or does "sh64" do something special here?)

sparc:	Uses spinlocks, so similar to parisc.

sparc64: Does have explicit memory barriers before and after.  ;-)

v850:	No SMP support, so no problem.

x86_64:	Same as for i386.

xtensa:	No SMP support, so no problem.

---

So either the docs or several of the architectures need fixing.

And it would be -really- nice if more architectures posted complete
instruction reference manuals on the web!!!  (Or maybe I need to
be better at searching for them?)

> so synchronize_xxx() should be
> 
> 	void synchronize_xxx(struct xxx_struct *sp)
> 	{
> 		int idx;
> 
> 		smp_mb();
> 		mutex_lock(&sp->mutex);
> 
> 		idx = sp->completed & 0x1;
> 		if (atomic_read(sp->ctr + idx) == 1)
> 			goto out;
> 
> 		atomic_inc(sp->ctr + (idx ^ 0x1));
> 		sp->completed++;
> 
> 		atomic_dec(sp->ctr + idx);
> 		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
> 	out:
> 		mutex_unlock(&sp->mutex);
> 	}
> 
> Yes, Alan was right, spinlock_t makes the code simpler.

;-)

							Thanx, Paul
