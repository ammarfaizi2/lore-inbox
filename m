Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUE1QaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUE1QaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUE1QaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:30:11 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:26062 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S263679AbUE1Q3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:29:55 -0400
Date: Fri, 28 May 2004 09:28:19 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Manfred Spraul <manfred@dbl.q-ag.de>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC, PATCH] 2/5 rcu lock update: Use a sequence lock for starting batches
Message-ID: <20040528162818.GA1242@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200405250535.i4P5ZLiR017599@dbl.q-ag.de> <20040527232210.GA2558@us.ibm.com> <40B74533.1060608@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B74533.1060608@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 03:57:07PM +0200, Manfred Spraul wrote:
> Paul E. McKenney wrote:
> 
> >Hello, Manfred,
> >
> >I am still digging through these, and things look quite good in general,
> >but I have a question on your second patch.

Sorry for the bother, will keep looking, hopefully with more accurate
comments in the future.  :-/

						Thanx, Paul

> Let's assume that
> 
> batch.completed = 5;
> batch.cur = 5;
> batch.next_pending = 0;
> 
> >Given the following sequence of events:
> >
> >1.	CPU 0 executes the
> >
> >		rcu_ctrlblk.batch.next_pending = 1;
> > 
> >
> batch.next_pending = 1.
> 
> >	at the beginning of rcu_start_batch().
> >
> >2.	CPU 1 executes the read_seqcount code sequence in
> >	rcu_process_callbacks(), setting RCU_batch(cpu) to
> >	the next batch number, and setting next_pending to 1.
> > 
> >
> RCU_batch(1) is now 6.
> next_pending is 1, rcu_process_callbacks continues without calling 
> rcu_start_batch().
> 
> >3.	CPU 0 executes the remainder of rcu_start_batch(),
> >	setting rcu_ctrlblk.batch.next_pending to 0 and
> >	incrementing rcu_ctrlblk.batch.cur.
> > 
> >
> batch.cur = 6.
> 
> >4.	CPU 1's state is now as if the grace period had already
> >	completed for the callbacks that were just moved to
> >	RCU_curlist(), which would be very bad.
> > 
> >
> AFAICS: No. RCU_batch(1) is 6 and rcu_ctrlblk.batch.completed is still 
> 5. The test for grace period completed is
> 
> > if (!list_empty(&RCU_curlist(cpu)) &&
> >            
> >!rcu_batch_before(rcu_ctrlblk.batch.completed,RCU_batch(cpu))) {
> >         __list_splice(&RCU_curlist(cpu), &list);
> >         INIT_LIST_HEAD(&RCU_curlist(cpu));
> > }
> 
> 5 is before 6, thus the callbacks won't be processed.
> 
> The only write operation to rcu_ctrlblk.batch.completed is in cpu_quiet, 
> after checking that the cpu bitmap is empty and under 
> spin_lock(rcu_ctrlblk.state.mutex).
> 
> Thanks for looking at my patches,
> 
> --
>    Manfred
> 
> 
