Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVCWGdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVCWGdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVCWGdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:33:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38020 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262820AbVCWGdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:33:38 -0500
Date: Wed, 23 Mar 2005 07:33:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323063317.GB31626@elte.hu>
References: <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323061601.GE1294@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> +#ifdef CONFIG_PREEMPT_RCU
> +
> +void rcu_read_lock(void)
> +{
> +	if (current->rcu_read_lock_nesting++ == 0) {
> +		current->rcu_data = &get_cpu_var(rcu_data);
> +		atomic_inc(&current->rcu_data->active_readers);
> +		put_cpu_var(rcu_data);
> 
> Need an smp_mb() here for non-x86 CPUs.  Otherwise, the CPU can
> re-order parts of the critical section to precede the rcu_read_lock().
> Could precede the put_cpu_var(), but why increase latency?

ok. It's enough to put a barrier into the else branch here, because the
atomic op in the main brain is a barrier by itself.

> +void rcu_read_unlock(void)
> +{
[...]
> And need an smp_mb() here, again for non-x86 CPUs.

ok.

> Assuming that the memory barriers are added, I can see a bunch of ways
> for races to extend grace periods, but none so far that result in the
> fatal too-short grace period.  Since rcu_qsctr_inc() refuses to
> increment the quiescent-state counter on any CPU that started an RCU
> read-side critical section that has not yet completed, any long
> critical section will have a corresponding CPU that will refuse to go
> through a quiescent state.  And that will prevent the grace period
> from completing.

i'm worried about the following scenario: what happens when a task is
migrated from CPU#1 to CPU#2, while in an RCU read section that it
acquired on CPU#1, and queues a callback. E.g. d_free() does a
call_rcu(), to queue the freeing of the dentry.

That callback will be queued on CPU#2 - while the task still keeps
current->rcu_data of CPU#1. It also means that CPU#2's read counter did
_not_ get increased - and a too short grace period may occur.

it seems to me that that only safe method is to pick an 'RCU CPU' when
first entering the read section, and then sticking to it, no matter
where the task gets migrated to. Or to 'migrate' the +1 read count from
one CPU to the other, within the scheduler.

the 'migrate read count' solution seems more promising, as it would keep
other parts of the RCU code unchanged. [ But it seems to break the nice
'flip pointers' method you found to force a grace period. If a 'read
section' can migrate from one CPU to another then it can migrate back as
well, at which point it cannot have the 'old' pointer. Maybe it would
still work better than no flip pointers. ]

	Ingo
