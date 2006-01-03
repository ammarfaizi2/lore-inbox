Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWACOJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWACOJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWACOJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:09:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63402 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751425AbWACOJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:09:06 -0500
Date: Tue, 3 Jan 2006 19:39:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>, vatsa@in.ibm.com
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20060103140942.GB5075@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe> <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org> <1135991732.31111.57.camel@mindpipe> <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org> <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com> <1136004855.3050.8.camel@mindpipe> <20051231201426.GD5124@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231201426.GD5124@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 12:14:26PM -0800, Paul E. McKenney wrote:
> So it seems to me that Linus's patch is part of the solution, but
> needs to also have a global component, perhaps as follows:
> 
> 	if (unlikely(rdp->count > 100)) {
> 		set_need_resched();
> 		if (unlikely(rdp->count - rdp->last_rs_count > 1000)) {
> 			int cpu;
> 
> 			rdp->last_rs_count = rdp->count;
> 			spin_lock_bh(&rcu_bh_state.lock);
> 			for_each_cpu_mask(cpu, rdp->rcu_bh_state.cpumask)
> 				smp_send_reschedule(cpu);
> 			spin_unlock_bh(&rcu_bh_state.lock);
> 		}
> 	}

Yes, something like this that covers corner cases and forces
queiscent state in all cpus, would be ideal.

> I am sure that I am missing some interaction or another with tickless
> idle and CPU hotplug covered.

It would be safe to miss a cpu or two while sending the resched
interrupt. So, I don't think we need to worry about tickless
idle and cpu hotplug.

> There also needs to be some adjustment in rcu_do_batch(), which will
> have to somehow get back to a quiescent state periodically.  Dipankar,
> Vatsa, thoughts?

My original thought was to make maxbatch dynamic and automatically
adjust it depending on the situation. I can try that approach.

Thanks
Dipankar
