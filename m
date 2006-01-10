Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWAJVvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWAJVvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWAJVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:51:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17829 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932442AbWAJVvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:51:08 -0500
Date: Tue, 10 Jan 2006 13:51:22 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dipankar@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
Message-ID: <20060110215121.GH18252@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165CE.AF913697@tv-sign.ru> <20060110002818.GD15083@us.ibm.com> <20060110180954.GA5387@in.ibm.com> <43C41CC8.8000203@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C41CC8.8000203@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:44:56PM +0100, Manfred Spraul wrote:
> [I haven't read the diff, just a short comment]
> 
> Dipankar Sarma wrote:
> 
> >rcu_state came over from Manfred's RCU_HUGE patch IIRC. I don't
> >think it is necessary to allocate rcu_state separately in the
> >current mainline RCU code. So, the patch looks OK to me, but
> >Manfred might see something that I am not seeing.
> >
> > 
> >
> The two-level rcu code was never merged, I still plan to clean it up.
> 
> But the idea of splitting the control block and the state is used in the 
> current code:
> - __rcu_pending() is the hot path, it only performs a read access to 
> rcu_ctrlblk.
> - write accesses to the rcu_ctrlblk are really rare, they only happen 
> when a new batch is started. Especially: independant from the number of 
> cpus.
> 
> Write access to the rcu_state are common:
> - each cpu must write once in each cycle to update it's cpu mask.
> - The last cpu then completes the quiescent cycle.
> 
> The idea is that rcu_state is more or less write-only and rcu_state is 
> read-only. Theoretically, rcu_state could be shared in all cpus caches, 
> and there will be only one invalidate when a new batch is started. Thus 
> no cacheline trashing due to rcu_pending calls.
> I think it would be safer to keep the two state counters in a separate 
> cacheline from the spinlock and the cpu mask, but I don't have any hard 
> numbers. IIRC the problems with the large SGI systems disappered, and 
> everyone was happy. No real benchmark comparisons were made.

Good point!

But doesn't the ____cacheline_maxaligned_in_smp directive on the "lock"
field take care of this?  Here is the structure:

/* Global control variables for rcupdate callback mechanism. */
struct rcu_ctrlblk {
        long    cur;            /* Current batch number.                      */
        long    completed;      /* Number of the last completed batch         */
        int     next_pending;   /* Is the next batch already waiting?         */

	spinlock_t      lock    ____cacheline_internodealigned_in_smp;
	cpumask_t       cpumask; /* CPUs that need to switch in order    */
				 /* for current batch to proceed.        */
} ____cacheline_internodealigned_in_smp;

If this does not cover this case, what more is needed?

							Thanx, Paul
