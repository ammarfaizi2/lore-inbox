Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbTGDBku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbTGDBku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:40:50 -0400
Received: from dp.samba.org ([66.70.73.150]:18357 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265620AbTGDBks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:40:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Per-cpuification of mm/slab.c reap_timers
Date: Fri, 04 Jul 2003 11:54:23 +1000
Message-Id: <20030704015516.7B6352C078@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  From Zwane.

Name: Make slab.c reap_timers per-cpu
Author: Zwane Mwaikambo
Status: Tested on 2.5.74-bk1

D: Rather trivial conversion.  Tested on SMP.

Index: linux-2.5/mm/slab.c
===================================================================
RCS file: /home/cvs/linux-2.5/mm/slab.c,v
retrieving revision 1.91
diff -u -p -B -r1.91 slab.c
--- linux-2.5/mm/slab.c	28 Jun 2003 21:10:44 -0000	1.91
+++ linux-2.5/mm/slab.c	3 Jul 2003 01:34:36 -0000
@@ -441,7 +441,7 @@ enum {
 	FULL
 } g_cpucache_up;
 
-static struct timer_list reap_timers[NR_CPUS];
+static DEFINE_PER_CPU(struct timer_list, reap_timers);
 
 static void reap_timer_fnc(unsigned long data);
 
@@ -491,7 +491,7 @@ static void __slab_error(const char *fun
  */
 static void start_cpu_timer(int cpu)
 {
-	struct timer_list *rt = &reap_timers[cpu];
+	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
 	if (rt->function == NULL) {
 		init_timer(rt);
@@ -2382,7 +2382,7 @@ next:
 static void reap_timer_fnc(unsigned long data)
 {
 	int cpu = smp_processor_id();
-	struct timer_list *rt = &reap_timers[cpu];
+	struct timer_list *rt = &__get_cpu_var(reap_timers);
 
 	cache_reap();
 	mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
