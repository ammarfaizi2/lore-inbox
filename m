Return-Path: <linux-kernel-owner+w=401wt.eu-S1751707AbWLMWpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWLMWpw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWLMWpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:45:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58738 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbWLMWpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:45:52 -0500
Date: Wed, 13 Dec 2006 23:43:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, vatsa@in.ibm.com, clameter@sgi.com,
       tglx@linutronix.de, arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061213224317.GA2986@elte.hu>
References: <20061211155304.A31760@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211155304.A31760@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> Appended patch attempts to fix the process idle load balancing in the 
> presence of dynticks. cpus for which ticks are stopped will sleep till 
> the next event wakes it up. Potentially these sleeps can be for large 
> durations and during which today, there is no idle load balancing 
> being done. There was some discussion happened(last year) on this 
> topic on lkml, where two main approaches were gettting debated. One is 
> to back off the idle load balancing for bigger intervals and the 
> second is a watchdog mechanism where the busy cpu will trigger the 
> load balance on an idle cpu.  Both of these mechanisms have its 
> drawbacks.

nice work! I have added your patch to -rt. Btw., it needs the patch 
below to work on 64-bit.

	Ingo

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1170,7 +1170,7 @@ static void resched_task(struct task_str
 static void resched_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned int flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&rq->lock, flags);
 	resched_task(cpu_curr(cpu));
