Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVCXGIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVCXGIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVCXGIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:08:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62704 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263049AbVCXGGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:06:14 -0500
Date: Wed, 23 Mar 2005 22:06:17 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324060617.GB1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323063727.GA32199@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323063727.GA32199@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 07:37:27AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > the 'migrate read count' solution seems more promising, as it would
> > keep other parts of the RCU code unchanged. [ But it seems to break
> > the nice 'flip pointers' method you found to force a grace period. If
> > a 'read section' can migrate from one CPU to another then it can
> > migrate back as well, at which point it cannot have the 'old' pointer.
> > Maybe it would still work better than no flip pointers. ]
> 
> the flip pointer method could be made to work if we had a NR_CPUS array
> of 'current RCU pointer' values attached to the task - and that array
> would be cleared if the task exits the read section. But this has memory
> usage worries with large NR_CPUS. (full clearing of the array can be
> avoided by using some sort of 'read section generation' counter attached
> to each pointer)

The only per-task data you need to maintain is a single pointer to
the per-CPU counter that was incremented by the outermost rcu_read_lock().
You also need a global index, call it "rcu_current_ctr_set" (or come
up with a better name!) along with a per-CPU pair of counters:

	struct rcu_ctr_set {	 /* or maybe there is a way to drop array */
		atomic_t ctr[2]; /* into DECLARE_PER_CPU() without a struct */
	}			 /* wrapper... */
	int	rcu_curset = 0;
	DEFINE_PER_CPU(struct rcu_ctr_set, rcu_ctr_set) = { 0, 0 };

You need two fields in the task structure:

	atomic_t *rcu_preempt_ctr;
	int rcu_nesting;

Then you have something like:

	void rcu_read_lock(void)
	{
		if (current->rcu_nesting++ == 0) {
			preempt_disable();
			current->rcu_preempt_ctr =
				&__get_cpu_var(rcu_ctr_set).ctr[rcu_curset];
			atomic_inc(current->rcu_preempt_ctr);
			preempt_enable();
			smp_mb();
		}
	}

	void rcu_read_unlock(void)
	{
		if (--current->rcu_nesting == 0) {
			smb_mb();  /* might only need smp_wmb()... */
			atomic_dec(current->rcu_preempt_ctr);
			current->rcu_preempt_ctr = NULL;  /* for debug */
		}
	}

One can then force a grace period via something like the following,
but only if you know that all of the rcu_ctr_set.ctr[!current] are zero:

	void _synchronize_kernel(void)
	{
		int cpu;

		spin_lock(&rcu_mutex);
		rcu_curset = !rcu_curset;
		for (;;) {
			for_each_cpu(cpu) {
				if (atomic_read(&__get_cpu_var(rcu_ctr_set).ctr[!rcu_curset]) != 0) {
					/* yield CPU for a bit */
					continue;
				}
			}
		}
		spin_unlock(&rcu_mutex);
	}

In real life, you need a way to multiplex multiple calls to
_synchronize_kernel() into a single counter-flip event, by
setting up callbacks.  And so on...

The above stolen liberally from your patch and from my memories of
Dipankar's RCU patch for CONFIG_PREEMPT kernels.  Guaranteed to have
horrible bugs.  ;-)

						Thanx, Paul
