Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755713AbWK0QL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbWK0QL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756644AbWK0QL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:11:27 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:39851 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1755713AbWK0QL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:11:26 -0500
Date: Mon, 27 Nov 2006 19:11:06 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061127161106.GA279@oleg>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg> <20061127050247.GC5021@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127050247.GC5021@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26, Paul E. McKenney wrote:
>
> Looks pretty good, actually.  A few quibbles below.  I need to review
> again after sleeping on it.

Thanks! Please also look at spinlock-based implementation,

	http://marc.theaimsgroup.com/?l=linux-kernel&m=116457701231964

I must admit, Alan was right: it really looks simpler and the perfomance
penalty should be very low. I personally hate this additional spinlock
per se as a "unneeded complication", but probably you will like it more.

> > +int xxx_read_lock(struct xxx_struct *sp)
> > +{
> > +	for (;;) {
> > +		int idx = sp->completed & 0x1;
> 
> Might need a comment saying why no rcu_dereference() needed on the
> preceding line.  The reason (as I understand it) is that we are
> only doing atomic operations on the element being indexed.

My understanding is the same. Actually, smp_read_barrier_depends() can't
help because 'atomic_inc' and '->completed++' in synchronize_xxx() could
be re-ordered anyway, so we should rely on correctness of atomic_t.

> 
> > +		if (likely(atomic_inc_not_zero(sp->ctr + idx)))
> > +			return idx;
> > +	}
> > +}
> 
> The loop seems absolutely necessary if one wishes to avoid a
> synchronize_sched() in synchronize_xxx() below (and was one of the things
> I was missing earlier).  However, isn't there a possibility that a pile
> of synchronize_xxx() calls might indefinitely delay an unlucky reader?

Note that synchronize_xxx() does nothing when there are no readers under
xxx_read_lock(), so

	for (;;)
		synchronize_xxx();

can't suspend xxx_read_lock(). atomic_inc_not_zero() fails when something like
the events below happen between 'idx = sp->completed' and 'atomic_inc_not_zero'

	- another reader does xxx_read_lock(), increments ->ctr.

	- synchronize_xxx() notices it, goes to __wait_event()

	- both the reader and writer manage to do atomic_dec()

This is possible in theory, but indefinite delay... Look, we have the same
"problem" with spinlocks: in theory synchronize_xxx() calls might indefinitely
delay an unlucky reader because synchronize_xxx() always wins spin_lock(&sp->lock);

> > +
> > +void xxx_read_unlock(struct xxx_struct *sp, int idx)
> > +{
> > +	if (unlikely(atomic_dec_and_test(sp->ctr + idx)))
> > +		wake_up(&sp->wq);
> > +}
> > +
> > +void synchronize_xxx(struct xxx_struct *sp)
> > +{
> > +	int idx;
> > +
> > +	mutex_lock(&sp->mutex);
> > +
> > +	idx = sp->completed & 0x1;
> > +	if (!atomic_add_unless(sp->ctr + idx, -1, 1))
> > +		goto out;
> > +
> > +	atomic_inc(sp->ctr + (idx ^ 0x1));
> > +	sp->completed++;
> > +
> > +	__wait_event(sp->wq, !atomic_read(sp->ctr + idx));
> > +out:
> > +	mutex_unlock(&sp->mutex);
> > +}
> 
> Test code!!!  Very good!!!  (This is added to rcutorture, right?)

Yes, the whole patch goes to kernel/rcutorture.c, it is only for
testing/review.

Note: I suspect that Documentation/ lies about atomic_add_unless(), see

	http://marc.theaimsgroup.com/?l=linux-kernel&m=116448966030359

so synchronize_xxx() should be

	void synchronize_xxx(struct xxx_struct *sp)
	{
		int idx;

		smp_mb();
		mutex_lock(&sp->mutex);

		idx = sp->completed & 0x1;
		if (atomic_read(sp->ctr + idx) == 1)
			goto out;

		atomic_inc(sp->ctr + (idx ^ 0x1));
		sp->completed++;

		atomic_dec(sp->ctr + idx);
		wait_event(sp->wq, !atomic_read(sp->ctr + idx));
	out:
		mutex_unlock(&sp->mutex);
	}

Yes, Alan was right, spinlock_t makes the code simpler.

Oleg.

