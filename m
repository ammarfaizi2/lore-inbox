Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946129AbWJSPvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946129AbWJSPvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946132AbWJSPvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:51:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10431 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946129AbWJSPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:51:09 -0400
Date: Thu, 19 Oct 2006 08:50:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
In-Reply-To: <20061018191900.D26521@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0610190736210.7337@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
 <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
 <45366DF0.6040702@yahoo.com.au> <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com>
 <45367D32.6090301@yahoo.com.au> <Pine.LNX.4.64.0610181457130.30795@schroedinger.engr.sgi.com>
 <20061018191900.D26521@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Siddha, Suresh B wrote:

> On Wed, Oct 18, 2006 at 02:59:07PM -0700, Christoph Lameter wrote:
> > load_balancing has the potential of running for some time if f.e.
> > sched_domains for a system with 1024 processors have to be balanced.
> > We currently do all of that with interrupts disabled. So we may be unable
> > to service interrupts for some time. Most of that time is potentially
> > spend in rebalance_tick.
> 
> Did you see an issue because of this or just theoretical?

Yes we actually had some livelocks when things got really busy and even 
missed timer interrupts. We have another workaround by enabling/disabling 
interrupts  in the timer tick on IA64 now but it would be good 
to address this issue in a general way.

> > +static void rebalance_tick(unsigned long dummy)
> >  {
> > +	int this_cpu = smp_processor_id();
> > +	struct rq *this_rq = cpu_rq(this_cpu);
> > +	enum idle_type idle;
> >  	unsigned long this_load, interval, j = cpu_offset(this_cpu);
> >  	struct sched_domain *sd;
> >  	int i, scale;
> >  
> > +	idle = (current == this_rq->idle) ? SCHED_IDLE : NOT_IDLE;
> 
> We need to add nr_running check too, to determine if we want to do
> idle/not-idle balancing. This is in the context of wake_priority_sleeper()

Ok. Thanks. Would this work?

Index: linux-2.6.19-rc2-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/kernel/sched.c	2006-10-19 09:39:08.000000000 -0500
+++ linux-2.6.19-rc2-mm1/kernel/sched.c	2006-10-19 09:42:10.733631242 -0500
@@ -2846,7 +2846,8 @@ static void rebalance_tick(unsigned long
 	struct sched_domain *sd;
 	int i, scale;
 
-	idle = (current == this_rq->idle) ? SCHED_IDLE : NOT_IDLE;
+	idle = (current == this_rq->idle && !this_rq->nr_running) ?
+				SCHED_IDLE : NOT_IDLE;
 	this_load = this_rq->raw_weighted_load;
 
 	/* Update our load: */
