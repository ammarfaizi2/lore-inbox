Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbUCTLAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 06:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbUCTLAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 06:00:39 -0500
Received: from ozlabs.org ([203.10.76.45]:25494 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263356AbUCTLAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 06:00:36 -0500
Subject: Re: [PATCH] cpu hotplug fix
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040320074033.A21586@infradead.org>
References: <20040320063642.GF1153@krispykreme>
	 <20040320074033.A21586@infradead.org>
Content-Type: text/plain
Message-Id: <1079780351.18972.48.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 21:59:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 18:40, Christoph Hellwig wrote:
> On Sat, Mar 20, 2004 at 05:36:42PM +1100, Anton Blanchard wrote:
> > 
> > start_cpu_timer was changed to __init a few hours before the cpu hotplug
> > patches went in. With cpu hotplug it can be called at any time, so fix
> > this.
> 
> So we're wasting memory due to the few machines supporting hot-plug cpus
> in slab now?  What about adding __cpuinit ala __devinit instead?

Just use __devinit.

More importantly, Christoph, you're missing the forest through the
trees: what the hell is start_cpu_timer trying to do?

Name: Remove Strange start_cpu_timer Code
Status: Untested

Why is start_cpu_timer checking for fn being NULL?  And why isn't
every CPU's reap_timer initialized in cpucache_init (which is an
__init function).

Clean up this mess by just starting the timer in start_cpu_timer.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15051-linux-2.6.5-rc2/mm/slab.c .15051-linux-2.6.5-rc2.updated/mm/slab.c
--- .15051-linux-2.6.5-rc2/mm/slab.c	2004-03-20 21:21:33.000000000 +1100
+++ .15051-linux-2.6.5-rc2.updated/mm/slab.c	2004-03-20 21:45:06.000000000 +1100
@@ -576,17 +576,12 @@ static void __slab_error(const char *fun
  * Add the CPU number into the expiry time to minimize the possibility of the
  * CPUs getting into lockstep and contending for the global cache chain lock.
  */
-static void __init start_cpu_timer(int cpu)
+static inline void start_cpu_timer(int cpu)
 {
 	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
-	if (rt->function == NULL) {
-		init_timer(rt);
-		rt->expires = jiffies + HZ + 3*cpu;
-		rt->data = cpu;
-		rt->function = reap_timer_fnc;
-		add_timer_on(rt, cpu);
-	}
+	rt->expires = jiffies + HZ + 3*cpu;
+	add_timer_on(rt, cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -798,7 +793,13 @@ int __init cpucache_init(void)
 	 * Register the timers that return unneeded
 	 * pages to gfp.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_cpu(cpu) {
+		struct timer_list *rt = &per_cpu(reap_timers, cpu);
+
+		init_timer(rt);
+		rt->data = cpu;
+		rt->function = reap_timer_fnc;
+		
 		if (cpu_online(cpu))
 			start_cpu_timer(cpu);
 	}



-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

