Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbULFLAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbULFLAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULFLAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:00:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:30937 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261489AbULFLAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:00:16 -0500
Date: Mon, 6 Dec 2004 16:32:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, rusty@au1.ibm.com, ak@suse.de,
       gareth@valinux.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Strange code in cpu_idle()
Message-ID: <20041206110246.GA5303@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20041204231149.GA1591@us.ibm.com> <Pine.LNX.4.61.0412060244350.1036@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412060244350.1036@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zwane,

On Mon, Dec 06, 2004 at 02:47:11AM -0700, Zwane Mwaikambo wrote:
> Hello Paul,
> 
> On Sat, 4 Dec 2004, Paul E. McKenney wrote:
> 
> > Unless idle_cpu() is busted, it seems like the above is, given the code in
> > rcu_check_callbacks():
> > 
> > 	void rcu_check_callbacks(int cpu, int user)
> > 	{
> > 		if (user || 
> > 		    (idle_cpu(cpu) && !in_softirq() && 
> > 					hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
> > 			rcu_qsctr_inc(cpu);
> > 			rcu_bh_qsctr_inc(cpu);
> > 		} else if (!in_softirq())
> > 			rcu_bh_qsctr_inc(cpu);
> > 		tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
> > 	}
> > 
> > So I would say that the rcu_read_lock() in cpu_idle() is having no
> > effect, because any timer interrupt from cpu_idle() will mark a
> > quiescent state notwithstanding.  What am I missing here?
> 
> What about the hardirq_count check since we're coming in from the timer 
> interrupt?

Look at the hardirq_count check closely - it only checks for reentrant
hardirqs. If the idle task gets interrupted by a timer interrupt,
the RCU quiscent state counter for the cpu will get incremented.
So, rcu_read_lock() in cpu_idle() is bogus.

Thanks
Dipankar
