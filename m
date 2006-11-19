Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933340AbWKSVYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbWKSVYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWKSVYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:24:32 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:16708
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S933340AbWKSVYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:24:31 -0500
Date: Sun, 19 Nov 2006 13:20:57 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119212057.GE4427@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061119190027.GA3676@oleg> <Pine.LNX.4.44L0.0611191512280.15059-100000@netrider.rowland.org> <20061119205516.GA117@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119205516.GA117@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 11:55:16PM +0300, Oleg Nesterov wrote:
> On 11/19, Alan Stern wrote:
> >
> > On Sun, 19 Nov 2006, Oleg Nesterov wrote:
> >
> > > 	int xxx_read_lock(struct xxx_struct *sp)
> > > 	{
> > > 		int idx;
> > >
> > > 		idx = sp->completed & 0x1;
> > > 		atomic_inc(sp->ctr + idx);
> > > 		smp_mb__after_atomic_inc();
> > >
> > > 		return idx;
> > > 	}
> > >
> > > 	void xxx_read_unlock(struct xxx_struct *sp, int idx)
> > > 	{
> > > 		if (atomic_dec_and_test(sp->ctr + idx))
> > > 			wake_up(&sp->wq);
> > > 	}
> > >
> > > 	void synchronize_xxx(struct xxx_struct *sp)
> > > 	{
> > > 		wait_queue_t wait;
> > > 		int idx;
> > >
> > > 		init_wait(&wait);
> > > 		mutex_lock(&sp->mutex);
> > >
> > > 		idx = sp->completed++ & 0x1;
> > >
> > > 		for (;;) {
> > > 			prepare_to_wait(&sp->wq, &wait, TASK_UNINTERRUPTIBLE);
> > >
> > > 			if (!atomic_add_unless(sp->ctr + idx, -1, 1))
> > > 				break;
> > >
> > > 			schedule();
> > > 			atomic_inc(sp->ctr + idx);
> > > 		}
> > > 		finish_wait(&sp->wq, &wait);
> > >
> > > 		mutex_unlock(&sp->mutex);
> > > 	}
> > >
> > > Very simple. Note that synchronize_xxx() is O(1), doesn't poll, and could
> > > be optimized further.
> >
> > What happens if synchronize_xxx manages to execute inbetween
> > xxx_read_lock's
> >
> >  		idx = sp->completed & 0x1;
> >  		atomic_inc(sp->ctr + idx);
> >
> > statements?
> 
> Oops. I forgot about explicit mb() before sp->completed++ in synchronize_xxx().
> 
> So synchronize_xxx() should do
> 
> 	smp_mb();
> 	idx = sp->completed++ & 0x1;
> 
> 	for (;;) { ... }
> 
> >               You see, there's no way around using synchronize_sched().
> 
> With this change I think we are safe.
> 
> If synchronize_xxx() increments ->completed in between, the caller of
> xxx_read_lock() will see all memory ops (started before synchronize_xxx())
> completed. It is ok that synchronize_xxx() returns immediately.

Let me take Alan's example one step further:

o	CPU 0 starts executing xxx_read_lock(), but is interrupted
	(or whatever) just before the atomic_inc().

o	CPU 1 executes synchronize_xxx() to completion, which it
	can because CPU 0 has not yet incremented the counter.

o	CPU 0 returns from interrupt and completes xxx_read_lock(),
	but has incremented the wrong counter.

o	CPU 0 continues into its critical section, picking up a
	pointer to an xxx-protected data structure (or, in Jens's
	case starting an xxx-protected I/O).

o	CPU 1 executes another synchronize_xxx().  This completes
	immediately because CPU 1 has the wrong counter incremented.

o	CPU 1 continues, either freeing a data structure while
	CPU 0 is still referencing it, or, in Jens's case, completing
	an I/O barrier while there is still outstanding I/O.

I agree with Alan -- unless I am missing something, we need a
synchronize_sched() in synchronize_xxx().  One thing missing in
the I/O-barrier case might be the possible restrictions I call
out in my earlier email.

						Thanx, Paul
