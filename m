Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbTLaBb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbTLaBb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:31:27 -0500
Received: from dp.samba.org ([66.70.73.150]:35270 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266018AbTLaBat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:30:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH 2/2] Use for_each_cpu() Where It's Meant To Be
Date: Wed, 31 Dec 2003 12:28:51 +1100
Message-Id: <20031231013046.864102C291@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

Some places use cpu_online() where they should be using cpu_possible,
most commonly for tallying statistics.  This makes no difference without
hotplug CPU.

Use the for_each_cpu() macro in those places, providing good
examples (and making the external hotplug CPU patch smaller).

Name: Use for_each_cpu() where cpu_online() is incorrectly used.
Author: Rusty Russell
Status: Booted on 2.6.0
Depends: Hotcpu/cpu_iterator.patch.gz

D: Some places use cpu_online() where they should be using cpu_possible,
D: most commonly for tallying statistics.  This makes no difference without
D: hotplug CPU.
D: 
D: Use the for_each_cpu() macro in those places, providing good
D: examples (and making the external hotplug CPU patch smaller).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/fs/buffer.c .908-linux-2.6.0-test7-bk3.updated/fs/buffer.c
--- .908-linux-2.6.0-test7-bk3/fs/buffer.c	2003-10-09 18:02:57.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/fs/buffer.c	2003-10-13 08:45:09.000000000 +1000
@@ -2944,10 +2944,8 @@ static void recalc_bh_state(void)
 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
 		return;
 	__get_cpu_var(bh_accounting).ratelimit = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-			tot += per_cpu(bh_accounting, i).nr;
-	}
+	for_each_cpu(i)
+		tot += per_cpu(bh_accounting, i).nr;
 	buffer_heads_over_limit = (tot > max_buffer_heads);
 }
 	
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/fs/proc/proc_misc.c .908-linux-2.6.0-test7-bk3.updated/fs/proc/proc_misc.c
--- .908-linux-2.6.0-test7-bk3/fs/proc/proc_misc.c	2003-09-29 10:25:53.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/fs/proc/proc_misc.c	2003-10-13 08:45:09.000000000 +1000
@@ -378,10 +378,9 @@ int show_stat(struct seq_file *p, void *
 	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
 	do_div(jif, HZ);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		int j;
 
-		if (!cpu_online(i)) continue;
 		user += kstat_cpu(i).cpustat.user;
 		nice += kstat_cpu(i).cpustat.nice;
 		system += kstat_cpu(i).cpustat.system;
@@ -401,8 +400,7 @@ int show_stat(struct seq_file *p, void *
 		jiffies_to_clock_t(iowait),
 		jiffies_to_clock_t(irq),
 		jiffies_to_clock_t(softirq));
-	for (i = 0; i < NR_CPUS; i++){
-		if (!cpu_online(i)) continue;
+	for_each_online_cpu(i) {
 		seq_printf(p, "cpu%d %u %u %u %u %u %u %u\n",
 			i,
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/kernel/fork.c .908-linux-2.6.0-test7-bk3.updated/kernel/fork.c
--- .908-linux-2.6.0-test7-bk3/kernel/fork.c	2003-10-12 11:04:17.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/kernel/fork.c	2003-10-13 08:45:09.000000000 +1000
@@ -60,10 +60,9 @@ int nr_processes(void)
 	int cpu;
 	int total = 0;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
-			total += per_cpu(process_counts, cpu);
-	}
+	for_each_cpu(cpu)
+		total += per_cpu(process_counts, cpu);
+
 	return total;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/kernel/sched.c .908-linux-2.6.0-test7-bk3.updated/kernel/sched.c
--- .908-linux-2.6.0-test7-bk3/kernel/sched.c	2003-10-09 18:03:02.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/kernel/sched.c	2003-10-13 08:45:09.000000000 +1000
@@ -829,11 +829,9 @@ unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
-	}
+
 	return sum;
 }
 
@@ -841,11 +839,9 @@ unsigned long nr_context_switches(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_switches;
-	}
+
 	return sum;
 }
 
@@ -853,11 +849,9 @@ unsigned long nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i)
 		sum += atomic_read(&cpu_rq(i)->nr_iowait);
-	}
+
 	return sum;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/kernel/workqueue.c .908-linux-2.6.0-test7-bk3.updated/kernel/workqueue.c
--- .908-linux-2.6.0-test7-bk3/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/kernel/workqueue.c	2003-10-13 08:45:09.000000000 +1000
@@ -366,9 +366,7 @@ int current_is_keventd(void)
 
 	BUG_ON(!keventd_wq);
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
+	for_each_cpu(cpu) {
 		cwq = keventd_wq->cpu_wq + cpu;
 		if (current == cwq->thread)
 			return 1;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/mm/page_alloc.c .908-linux-2.6.0-test7-bk3.updated/mm/page_alloc.c
--- .908-linux-2.6.0-test7-bk3/mm/page_alloc.c	2003-10-09 18:03:02.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/mm/page_alloc.c	2003-10-13 08:49:27.000000000 +1000
@@ -867,14 +867,14 @@ void __get_page_state(struct page_state 
 	while (cpu < NR_CPUS) {
 		unsigned long *in, *out, off;
 
-		if (!cpu_online(cpu)) {
+		if (!cpu_possible(cpu)) {
 			cpu++;
 			continue;
 		}
 
 		in = (unsigned long *)&per_cpu(page_states, cpu);
 		cpu++;
-		if (cpu < NR_CPUS && cpu_online(cpu))
+		if (cpu < NR_CPUS && cpu_possible(cpu))
 			prefetch(&per_cpu(page_states, cpu));
 		out = (unsigned long *)ret;
 		for (off = 0; off < nr; off++)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/net/ipv4/route.c .908-linux-2.6.0-test7-bk3.updated/net/ipv4/route.c
--- .908-linux-2.6.0-test7-bk3/net/ipv4/route.c	2003-10-09 18:03:03.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/net/ipv4/route.c	2003-10-13 08:45:09.000000000 +1000
@@ -2703,12 +2703,9 @@ static int ip_rt_acct_read(char *buffer,
 		memcpy(dst, src, length);
 
 		/* Add the other cpus in, one int at a time */
-		for (i = 1; i < NR_CPUS; i++) {
+		for_each_cpu(i) {
 			unsigned int j;
 
-			if (!cpu_online(i))
-				continue;
-
 			src = ((u32 *) IP_RT_ACCT_CPU(i)) + offset;
 
 			for (j = 0; j < length/4; j++)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3441-2.6.0-test9-hotcpu-i386.pre/kernel/timer.c .3441-2.6.0-test9-hotcpu-i386/kernel/timer.c
--- .3441-2.6.0-test9-hotcpu-i386.pre/kernel/timer.c	2003-10-27 13:26:01.000000000 +1100
+++ .3441-2.6.0-test9-hotcpu-i386/kernel/timer.c	2003-10-27 13:26:02.000000000 +1100
@@ -332,10 +332,7 @@ int del_timer_sync(struct timer_list *ti
 del_again:
 	ret += del_timer(timer);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-
+	for_each_cpu(i) {
 		base = &per_cpu(tvec_bases, i);
 		if (base->running_timer == timer) {
 			while (base->running_timer == timer) {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
