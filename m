Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbULIOYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbULIOYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULIOYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:24:07 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:57588 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261438AbULIOX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:23:29 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Date: Thu, 9 Dec 2004 09:23:24 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@raytheon.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <20041124101626.GA31788@elte.hu> <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
In-Reply-To: <20041209131317.GA31573@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412090923.25981.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.76.102] at Thu, 9 Dec 2004 08:23:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 December 2004 08:13, Ingo Molnar wrote:
>* Ingo Molnar <mingo@elte.hu> wrote:
>> SLAB draining was an oversight - it's mainly called when there is
>> VM pressure (which is not a stricly necessary feature, so i
>> disabled it), but i forgot about the module-unload case where it's
>> a correctness feature. Your patch is a good starting point, i'll
>> try to fix it on SMP too.
>
>here's the full patch against a recent tree, or download the -32-12
>patch from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
>Rui, Gene, does this fix the module unload crash you are seeing?

I'm still on -9 here Ingo, and I just rmmod'ed eeprom with no ill
effects.  I'd built -10 last night but as kde was trying to build,
didn't reboot.  I just got -12, so I'll do it and reboot to it next.

Or am I the wrong Gene?

>
> Ingo
>
>--- linux/mm/slab.c.orig
>+++ linux/mm/slab.c
>@@ -1509,22 +1509,26 @@ static void smp_call_function_all_cpus(v
> static void drain_array_locked(kmem_cache_t* cachep,
>     struct array_cache *ac, int force);
>
>-#ifndef CONFIG_PREEMPT_RT
>-/*
>- * Executes in an IRQ context:
>- */
>-static void do_drain(void *arg)
>+static void do_drain_cpu(kmem_cache_t *cachep, int cpu)
> {
>-	kmem_cache_t *cachep = (kmem_cache_t*)arg;
> 	struct array_cache *ac;
>-	int cpu = smp_processor_id();
>
> 	check_irq_off();
>-	ac = ac_data(cachep, cpu);
>+
> 	spin_lock(&cachep->spinlock);
>+	ac = ac_data(cachep, cpu);
> 	free_block(cachep, &ac_entry(ac)[0], ac->avail);
>-	spin_unlock(&cachep->spinlock);
> 	ac->avail = 0;
>+	spin_unlock(&cachep->spinlock);
>+}
>+
>+#ifndef CONFIG_PREEMPT_RT
>+/*
>+ * Executes in an IRQ context:
>+ */
>+static void do_drain(void *arg)
>+{
>+	do_drain_cpu((kmem_cache_t*)arg, smp_processor_id());
> }
> #endif
>
>@@ -1532,6 +1536,11 @@ static void drain_cpu_caches(kmem_cache_
> {
> #ifndef CONFIG_PREEMPT_RT
> 	smp_call_function_all_cpus(do_drain, cachep);
>+#else
>+	int cpu;
>+
>+	for_each_online_cpu(cpu)
>+		do_drain_cpu(cachep, cpu);
> #endif
> 	check_irq_on();
> 	spin_lock_irq(&cachep->spinlock);
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

