Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUAaOT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 09:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUAaOT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 09:19:26 -0500
Received: from dp.samba.org ([66.70.73.150]:14524 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264604AbUAaOTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 09:19:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: [PATCH 1/4] 2.6.2-rc2-mm2 CPU Hotplug: cpu_active_map
Date: Sun, 01 Feb 2004 01:16:35 +1100
Message-Id: <20040131141937.EB2752C086@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew et al.

	Forward ported to -mm tree, so there might still be bugs.
Wanted to get these aired more widely.  Especially get Nick exposed to
the sched parts.

Name: Create cpu_active_map
Author: Rusty Russell
Status: Booted on 2.6.2-rc2-bk2

D: When CPUs are going down, there is a time when cpu_online(cpu) is
D: false, but they are still scheduling and responding to interrupts
D: (we are migrating things off the CPU, shutting down per-cpu
D: threads, etc).  It turns out that RCU cares about these CPUs, so
D: the decision was made to expose this mask (previously internal to x86,
D: and only used for IPIs).
D: 
D: The semantics of this mask are as follows:
D: 1) For platforms without hot unplug of CPUs: cpu_active_map ==
D:    cpu_online_map.
D: 2) For the others, they are equal except for a CPU which is going
D:    down: cpu_online_map gets cleared by __cpu_disable(), cpu_ipi_map
D:    gets cleared in __cpu_die() once the CPU is no longer responding
D:    to interrupts.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25707-linux-2.6.0-test11-bk7/include/linux/cpumask.h .25707-linux-2.6.0-test11-bk7.updated/include/linux/cpumask.h
--- .25707-linux-2.6.0-test11-bk7/include/linux/cpumask.h	2003-12-10 13:58:18.000000000 +1100
+++ .25707-linux-2.6.0-test11-bk7.updated/include/linux/cpumask.h	2003-12-10 14:01:29.000000000 +1100
@@ -43,6 +43,13 @@ typedef unsigned long cpumask_t;
 extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* Online, or on its way down but still receiving interrupts. */
+extern cpumask_t cpu_active_map;
+#else
+#define cpu_active_map cpu_online_map
+#endif
+
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25707-linux-2.6.0-test11-bk7/kernel/rcupdate.c .25707-linux-2.6.0-test11-bk7.updated/kernel/rcupdate.c
--- .25707-linux-2.6.0-test11-bk7/kernel/rcupdate.c	2003-12-10 13:58:19.000000000 +1100
+++ .25707-linux-2.6.0-test11-bk7.updated/kernel/rcupdate.c	2003-12-10 14:01:03.000000000 +1100
@@ -110,7 +110,7 @@ static void rcu_start_batch(long newbatc
 	    !cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
 		return;
 	}
-	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
+	rcu_ctrlblk.rcu_cpu_mask = cpu_active_map;
 }
 
 /*
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
