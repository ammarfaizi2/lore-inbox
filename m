Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbULINNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbULINNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 08:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbULINNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 08:13:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64713 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261246AbULINNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 08:13:50 -0500
Date: Thu, 9 Dec 2004 14:13:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041209131317.GA31573@elte.hu>
References: <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <1102526018.25841.308.camel@localhost.localdomain> <32950.192.168.1.5.1102529664.squirrel@192.168.1.5> <1102532625.25841.327.camel@localhost.localdomain> <32788.192.168.1.5.1102541960.squirrel@192.168.1.5> <1102543904.25841.356.camel@localhost.localdomain> <20041209093211.GC14516@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209093211.GC14516@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> SLAB draining was an oversight - it's mainly called when there is VM
> pressure (which is not a stricly necessary feature, so i disabled it),
> but i forgot about the module-unload case where it's a correctness
> feature. Your patch is a good starting point, i'll try to fix it on
> SMP too.

here's the full patch against a recent tree, or download the -32-12
patch from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

Rui, Gene, does this fix the module unload crash you are seeing?

	Ingo

--- linux/mm/slab.c.orig
+++ linux/mm/slab.c
@@ -1509,22 +1509,26 @@ static void smp_call_function_all_cpus(v
 static void drain_array_locked(kmem_cache_t* cachep,
 				struct array_cache *ac, int force);
 
-#ifndef CONFIG_PREEMPT_RT
-/*
- * Executes in an IRQ context:
- */
-static void do_drain(void *arg)
+static void do_drain_cpu(kmem_cache_t *cachep, int cpu)
 {
-	kmem_cache_t *cachep = (kmem_cache_t*)arg;
 	struct array_cache *ac;
-	int cpu = smp_processor_id();
 
 	check_irq_off();
-	ac = ac_data(cachep, cpu);
+
 	spin_lock(&cachep->spinlock);
+	ac = ac_data(cachep, cpu);
 	free_block(cachep, &ac_entry(ac)[0], ac->avail);
-	spin_unlock(&cachep->spinlock);
 	ac->avail = 0;
+	spin_unlock(&cachep->spinlock);
+}
+
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Executes in an IRQ context:
+ */
+static void do_drain(void *arg)
+{
+	do_drain_cpu((kmem_cache_t*)arg, smp_processor_id());
 }
 #endif
 
@@ -1532,6 +1536,11 @@ static void drain_cpu_caches(kmem_cache_
 {
 #ifndef CONFIG_PREEMPT_RT
 	smp_call_function_all_cpus(do_drain, cachep);
+#else
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		do_drain_cpu(cachep, cpu);
 #endif
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
