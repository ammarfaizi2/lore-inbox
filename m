Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUCVGhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUCVGhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:37:48 -0500
Received: from ozlabs.org ([203.10.76.45]:60070 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261785AbUCVGhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:37:39 -0500
Subject: Re: [PATCH] cpu hotplug fix
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, Anton Blanchard <anton@samba.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040320151230.7527914a.akpm@osdl.org>
References: <20040320063642.GF1153@krispykreme>
	 <20040320074033.A21586@infradead.org> <1079780351.18972.48.camel@bach>
	 <20040320151230.7527914a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079937377.5759.45.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 17:36:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-21 at 10:12, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > Name: Remove Strange start_cpu_timer Code
> >  Status: Untested
> oy.
> 
> Program received signal SIGTRAP, Trace/breakpoint trap.

Yep.  This one is better, and actually tested.

Name: Remove Strange start_cpu_timer Code
Status: Tested on 2.6.5-rc2-bk1

start_cpu_timer is called once for every online CPU, then again in the
cpu up callback, hence the rt->function re-entrance check.  Just call
it manually for the boot cpu, and use the notifier for the others.

Perhaps at one stage this code was run before timers were available:
this is no longer true (timers are initialized as part of scheduler
startup).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.5-rc2-bk1/mm/slab.c working-2.6.5-rc2-bk1-start_cpu_timer-cleanup/mm/slab.c
--- linux-2.6.5-rc2-bk1/mm/slab.c	2004-03-20 21:21:33.000000000 +1100
+++ working-2.6.5-rc2-bk1-start_cpu_timer-cleanup/mm/slab.c	2004-03-22 14:41:07.000000000 +1100
@@ -576,13 +576,11 @@ static void __slab_error(const char *fun
 {
 	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
-	if (rt->function == NULL) {
-		init_timer(rt);
-		rt->expires = jiffies + HZ + 3*cpu;
-		rt->data = cpu;
-		rt->function = reap_timer_fnc;
-		add_timer_on(rt, cpu);
-	}
+	init_timer(rt);
+	rt->data = cpu;
+	rt->function = reap_timer_fnc;
+	rt->expires = jiffies + HZ + 3*cpu;
+	add_timer_on(rt, cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -594,11 +592,8 @@ static void stop_cpu_timer(int cpu)
 {
 	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
-	if (rt->function) {
-		del_timer_sync(rt);
-		WARN_ON(timer_pending(rt));
-		rt->function = NULL;
-	}
+	del_timer_sync(rt);
+	WARN_ON(timer_pending(rt));
 }
 #endif
 
@@ -779,35 +774,14 @@ void __init kmem_cache_init(void)
 	/* Done! */
 	g_cpucache_up = FULL;
 
+	start_cpu_timer(smp_processor_id());
+
 	/* Register a cpu startup notifier callback
 	 * that initializes ac_data for all new cpus
 	 */
 	register_cpu_notifier(&cpucache_notifier);
-	
-
-	/* The reap timers are started later, with a module init call:
-	 * That part of the kernel is not yet operational.
-	 */
 }
 
-int __init cpucache_init(void)
-{
-	int cpu;
-
-	/* 
-	 * Register the timers that return unneeded
-	 * pages to gfp.
-	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
-			start_cpu_timer(cpu);
-	}
-
-	return 0;
-}
-
-__initcall(cpucache_init);
-
 /*
  * Interface to system's page allocator. No need to hold the cache-lock.
  *


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

