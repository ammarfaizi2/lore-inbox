Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933924AbWKWUnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933924AbWKWUnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933930AbWKWUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:43:17 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:60220
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S933924AbWKWUnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:43:16 -0500
Date: Thu, 23 Nov 2006 12:40:54 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061123204054.GA4533@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123145910.GA145@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 05:59:10PM +0300, Oleg Nesterov wrote:
> (Sorry, responding to the wrong message)
> 
> Paul E. McKenney wrote:
> >
> > I am concerned about this as well, and am beginning to suspect that I
> > need to make a special-purpose primitive specifically for Jens that he
> > can include with his code.
> 
> How about this?

For Jens, it might be OK.  For general use, I believe that this has
difficulties with the sequence of events I sent out on November 20th, see:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116397154808901&w=2

Might also be missing a few memory barriers, see below.

> 	struct xxx_struct {
> 		int completed;
> 		atomic_t ctr[2];
> 		struct mutex mutex;
> 		wait_queue_head_t wq;
> 	};
> 
> 	void init_xxx_struct(struct xxx_struct *sp)
> 	{
> 		sp->completed = 0;
> 		atomic_set(sp->ctr + 0, 1);	// active
> 		atomic_set(sp->ctr + 1, 0);	// inactive
> 		mutex_init(&sp->mutex);
> 		init_waitqueue_head(&sp->wq);
> 	}
> 
> 	int xxx_read_lock(struct xxx_struct *sp)
> 	{
> 		for (;;) {
> 			int idx = sp->completed & 0x1;
> 			if (likely(atomic_inc_not_zero(sp->ctr + idx)))

Need an after-atomic-inc memory barrier here?

> 				return idx;
> 		}
> 	}
> 
> 	void xxx_read_unlock(struct xxx_struct *sp, int idx)
> 	{

Need a before-atomic-dec memory barrier here?

> 		if (unlikely(atomic_dec_and_test(sp->ctr + idx)))
> 			wake_up(&sp->wq);
> 	}
> 
> 	void synchronize_xxx(struct xxx_struct *sp)
> 	{
> 		int idx;
> 
> 		mutex_lock(&sp->mutex);
> 
> 		idx = ++sp->completed & 0x1;
> 		smp_mb__before_atomic_inc();
> 		atomic_inc(&sp->ctr + idx);
> 
> 		idx = !idx;
> 		if (!atomic_dec_and_test(&sp->ctr + idx))
> 			__wait_event(&sp->wq, !atomic_read(&sp->ctr + idx));

I don't understand why an unlucky sequence of events mightn't be able
to hang this __wait_event().  Suppose we did the atomic_dec_and_test(),
then some other CPU executed xxx_read_unlock(), finding no one to awaken,
then we execute the __wait_event()?  What am I missing here?

> 
> 		mutex_unlock(&sp->mutex);
> 	}
> 
> Yes, cache thrashing... But I think this is hard to avoid if we want writer
> to be fast.
> 
> I do not claim this is the best solution, but for some reason I'd like to
> suggest something that doesn't need synchronize_sched(). What do you think
> about correctness at least?

The general approach seems reasonable, but I do have the concerns above.

						Thanx, Paul
