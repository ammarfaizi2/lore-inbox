Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVCWFXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVCWFXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVCWFXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:23:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:10421 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262795AbVCWFXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:23:09 -0500
Date: Tue, 22 Mar 2005 21:23:18 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-05
Message-ID: <20050323052318.GB1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322100153.GA23143@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 11:01:53AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm, another thing: i think call_rcu() needs to take the read-lock.
> > Right now it assumes that it has the data structure private, but
> > that's only statistically true on PREEMPT_RT: another CPU may have
> > this CPU's RCU control structure in use. So IRQs-off (or preempt-off)
> > is not a guarantee to have the data structure, the read lock has to be
> > taken.
> 
> i've reworked the code to use the read-lock to access the per-CPU data
> RCU structures, and it boots with 2 CPUs and PREEMPT_RT now. The -40-05
> patch can be downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> had to add two hacks though:
> 
>  static void rcu_advance_callbacks(struct rcu_data *rdp)
>  {
>         if (rdp->batch != rcu_ctrlblk.batch) {
>                 if (rdp->donetail) // HACK
>                         *rdp->donetail = rdp->waitlist;
> 		...
> 
>  void fastcall call_rcu(struct rcu_head *head,
>           void (*func)(struct rcu_head *rcu))
>  [...]
>         rcu_advance_callbacks(rdp);
>         if (rdp->waittail) // HACK
>                 *rdp->waittail = head;
> 	...
> 
> without them it crashes during bootup.

Probably also the cause of the memory leakage.  More evidence that
list macros are useful, just in case anyone needed any more.

> maybe we are better off with the completely unlocked read path and the
> long grace periods.

Might well be...  But doesn't there need to be an smp_mb() right after
the increment in rcu_read_lock() and before the rcu_qsctr_inc(cpu)
in rcu_read_unlock(), at least for non-x86 CPUs?

On the long grace periods...

It should be possible to force the grace periods to end by providing a
pair of active_readers counters per rcu_data structure, one "current",
the other "expiring".  New rcu_read_lock() invocations get a pointer
to the "current" active_readers counter for their current CPU,
and rcu_read_unlock() decrements whichever one the corresponding
rcu_read_lock() got a pointer to.

When it is necessary to force a grace period, the roles of the "current"
and the "expiring" counters are reversed.  Once all CPUs' "expiring"
counters have gone to zero, then we know that all RCU read-side critical
sections that were executing at the time of the role reversal have
completed.  It is necessary to wait for all the "expiring" counters to
go to zero before doing a second role reversal.

This is very similar to some mechanism in the K42 and in Dipankar's
rcu.  See page 18 of http://www.rdrop.com/users/paulmck/RCU/rcu.2002.07.08.pdf
for a better description.  There is a patch against a very early
2.5 that I can dig up if anyone is interested.

Once I get the lock-based method working, I might have the confidence
to take this on.  If someone wants to try it out in the meantime, I
would of course be happy to review their code.

						Thanx, Paul
