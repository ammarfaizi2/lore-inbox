Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWI3MZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWI3MZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWI3MZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:25:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60616 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750811AbWI3MZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:25:26 -0400
Date: Sat, 30 Sep 2006 17:55:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 08/23] dynticks: prepare the RCU code
Message-ID: <20060930122514.GC8763@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060929234435.330586000@cruncher.tec.linutronix.de> <20060929234439.721237000@cruncher.tec.linutronix.de> <20060930013641.263a1cc3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930013641.263a1cc3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 01:36:41AM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 23:58:27 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > prepare the RCU code for dynticks/nohz. Since on nohz kernels there
> > is no guaranteed timer IRQ that processes RCU callbacks, the idle
> > code has to make sure that all RCU callbacks that can be finished
> > off are indeed finished off. This patch adds the necessary APIs:
> > rcu_advance_callbacks() [to register quiescent state] and
> > rcu_process_callbacks() [to finish finishable RCU callbacks].
> > 
> > ...
> >  
> > +void rcu_advance_callbacks(int cpu, int user)
> > +{
> > +	if (user ||
> > +	    (idle_cpu(cpu) && !in_softirq() &&
> > +				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
> > +		rcu_qsctr_inc(cpu);
> > +		rcu_bh_qsctr_inc(cpu);
> > +	} else if (!in_softirq())
> > +		rcu_bh_qsctr_inc(cpu);
> > +}
> > +
> 
> I hope this function is immediately clear to the RCU maintainers, because it's
> complete mud to me.
> 

Ingo,

It is duplicating code. That can be easily fixed, but we need to figure
out what we really want from RCU when we are about to switch off
the ticks. It is hard if you want to finish off all the pending
RCUs and go to nohz state. Can you live with backing out if
there are pending RCUs ?

Thanks
Dipankar
