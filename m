Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbULFJvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbULFJvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbULFJvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:51:35 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:222 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261476AbULFJvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:51:02 -0500
Date: Mon, 6 Dec 2004 02:47:11 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: dipankar@in.ibm.com, rusty@au1.ibm.com, ak@suse.de, gareth@valinux.com,
       davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Strange code in cpu_idle()
In-Reply-To: <20041204231149.GA1591@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0412060244350.1036@montezuma.fsmlabs.com>
References: <20041204231149.GA1591@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sat, 4 Dec 2004, Paul E. McKenney wrote:

> Unless idle_cpu() is busted, it seems like the above is, given the code in
> rcu_check_callbacks():
> 
> 	void rcu_check_callbacks(int cpu, int user)
> 	{
> 		if (user || 
> 		    (idle_cpu(cpu) && !in_softirq() && 
> 					hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
> 			rcu_qsctr_inc(cpu);
> 			rcu_bh_qsctr_inc(cpu);
> 		} else if (!in_softirq())
> 			rcu_bh_qsctr_inc(cpu);
> 		tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
> 	}
> 
> And idle_cpu() is pretty straightforward:
> 
> 	int idle_cpu(int cpu)
> 	{
> 		return cpu_curr(cpu) == cpu_rq(cpu)->idle;
> 	}
> 
> So I would say that the rcu_read_lock() in cpu_idle() is having no
> effect, because any timer interrupt from cpu_idle() will mark a
> quiescent state notwithstanding.  What am I missing here?

What about the hardirq_count check since we're coming in from the timer 
interrupt?

> Note that we really, really do want the idle loop to be an extended
> quiescent state, otherwise one gets indefinite grace periods and
> runs out of memory...

I've (hopefully) covered this in another email.

Thanks,
	Zwane
