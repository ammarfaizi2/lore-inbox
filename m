Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWCOJdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWCOJdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWCOJdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:33:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27062 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750984AbWCOJdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:33:42 -0500
Date: Wed, 15 Mar 2006 10:31:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Jan Altenberg <tb10alj@tglx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was:      realtime-preempt patch-2.6.15-rt18 issues)
Message-ID: <20060315093122.GA1682@elte.hu>
References: <36944.195.245.190.93.1141734835.squirrel@www.rncbc.org> <20060314231344.44688.qmail@web26506.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314231344.44688.qmail@web26506.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50,SUBJ_HAS_SPACES autolearn=no SpamAssassin version=3.0.3
	1.2 SUBJ_HAS_SPACES        Subject contains lots of white space
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* karsten wiese <annabellesgarden@yahoo.de> wrote:

> 
> --- Rui Nuno Capela <rncbc@rncbc.org> schrieb:
> > - The SLAB related usb-storage crash on disconnect is
> > still there:
> 
> and its still in up to rc6-rt3, unless you apply attached patch. My 
> uniprocessor behaves with it.

ah, indeed!

> Ingo, what exactly needs fixing here?

smp_call_function() will call things in a hardirq context, so calling 
do_drain() from there [which uses preemptible spinlocks, etc.] is 
unsafe. (it will work most of the time, but not all of the time) It 
should rather be done from some per-CPU task.

a better fix would be the one below - it still does the call on the 
current CPU, and skips other CPUs (on SMP). Does this solve the problem 
on your box too?

	Ingo

Index: linux-rt.q/mm/slab.c
===================================================================
--- linux-rt.q.orig/mm/slab.c
+++ linux-rt.q/mm/slab.c
@@ -2192,19 +2192,20 @@ static void check_spinlock_acquired_node
  */
 static void smp_call_function_all_cpus(void (*func)(void *arg), void *arg)
 {
-	unsigned long flags;
+	unsigned int this_cpu;
 
 	check_irq_on();
-	preempt_disable();
+//	preempt_disable();
 
-	slab_irq_disable(flags);
+	slab_irq_disable(this_cpu);
 	func(arg);
-	slab_irq_enable(flags);
+	slab_irq_enable(this_cpu);
 
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
+// FIXME
+//	if (smp_call_function(func, arg, 1, 1))
+//		BUG();
 
-	preempt_enable();
+//	preempt_enable();
 }
 
 static void drain_array_locked(struct kmem_cache *cachep, struct array_cache *ac,
@@ -2231,8 +2232,7 @@ static void drain_cpu_caches(struct kmem
 	int this_cpu;
 	int node;
 
-// FIXME:
-//	smp_call_function_all_cpus(do_drain, cachep);
+	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
