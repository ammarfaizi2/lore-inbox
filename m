Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266718AbUBMH5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 02:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUBMH5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 02:57:34 -0500
Received: from dp.samba.org ([66.70.73.150]:11915 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266718AbUBMH5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 02:57:31 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Booting when CPUs fail to come up.
Date: Fri, 13 Feb 2004 18:57:03 +1100
Message-Id: <20040213075743.7D1332C12A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently played with setting a bit in cpu_possible_map that wasn't
in cpu_online_map: this can happen without hotplug CPU when a CPU
fails to boot, for example.

1) i386 should use cpu_callin_map for num_booting_cpus() (an x86-ism
   anyway): if a CPU doesn't come up, it will be set in
   cpu_possible_map (aka cpu_callout_map) but not cpu_callin_map.

2) When the cpu fails to come up, some callbacks do kthread_stop(),
   which doesn't work without keventd (which hasn't started yet).
   Call it directly, and take care that it restores signal state
   (note: do_sigaction does a flush on blocked signals, so we don't
   need to repeat it).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13580-linux-2.6.3-rc2-mm1/arch/i386/kernel/smpboot.c .13580-linux-2.6.3-rc2-mm1.updated/arch/i386/kernel/smpboot.c
--- .13580-linux-2.6.3-rc2-mm1/arch/i386/kernel/smpboot.c	2004-02-13 17:28:16.000000000 +1100
+++ .13580-linux-2.6.3-rc2-mm1.updated/arch/i386/kernel/smpboot.c	2004-02-13 17:28:17.000000000 +1100
@@ -67,7 +67,7 @@ int smp_num_siblings = 1;
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 
-static cpumask_t cpu_callin_map;
+cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13580-linux-2.6.3-rc2-mm1/include/asm-i386/smp.h .13580-linux-2.6.3-rc2-mm1.updated/include/asm-i386/smp.h
--- .13580-linux-2.6.3-rc2-mm1/include/asm-i386/smp.h	2004-02-13 17:28:15.000000000 +1100
+++ .13580-linux-2.6.3-rc2-mm1.updated/include/asm-i386/smp.h	2004-02-13 17:28:17.000000000 +1100
@@ -58,7 +58,8 @@ extern cpumask_t cpu_callout_map;
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
 {
-	return cpus_weight(cpu_callout_map);
+	extern cpumask_t cpu_callin_map;
+	return cpus_weight(cpu_callin_map);
 }
 
 extern void map_cpu_to_logical_apicid(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13580-linux-2.6.3-rc2-mm1/kernel/kthread.c .13580-linux-2.6.3-rc2-mm1.updated/kernel/kthread.c
--- .13580-linux-2.6.3-rc2-mm1/kernel/kthread.c	2004-02-13 17:28:12.000000000 +1100
+++ .13580-linux-2.6.3-rc2-mm1.updated/kernel/kthread.c	2004-02-13 17:32:05.000000000 +1100
@@ -100,15 +100,16 @@ static void keventd_stop_kthread(void *_
 {
 	struct kthread_stop_info *stop = _stop;
 	int status, pid;
-	sigset_t blocked;
-	struct k_sigaction sa;
+	sigset_t chldonly, oldset;
+	struct k_sigaction sa, oldsa;
 
 	/* Install a handler so SIGCHLD is actually delivered */
 	sa.sa.sa_handler = SIG_DFL;
 	sa.sa.sa_flags = 0;
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
-	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
-	allow_signal(SIGCHLD);
+	siginitset(&chldonly, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, &oldsa);
+	sigprocmask(SIG_UNBLOCK, &chldonly, &oldset);
 
 	adopt_kthread(stop->k);
 	/* Grab pid now: after waitpid(), stop->k is invalid. */
@@ -123,12 +124,9 @@ static void keventd_stop_kthread(void *_
 	stop->result = -((status >> 8) & 0xFF);
 	complete(&stop->done);
 
-	/* Back to normal: block and flush all signals */
-	sigfillset(&blocked);
-	sigprocmask(SIG_BLOCK, &blocked, NULL);
-	flush_signals(current);
-	sa.sa.sa_handler = SIG_IGN;
-	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+	/* Return to normal, then reap any children who died in the race. */
+	sigprocmask(SIG_SETMASK, &oldset, NULL);
+	do_sigaction(SIGCHLD, &oldsa, NULL);
 	while (waitpid(-1, &status, __WALL|WNOHANG) > 0);
 }
 
@@ -179,7 +177,12 @@ int kthread_stop(struct task_struct *k)
 	stop.k = k;
 	init_completion(&stop.done);
 
-	schedule_work(&work);
-	wait_for_completion(&stop.done);
+	/* At boot, if CPUs fail to come up, this happens. */
+	if (!keventd_up())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		wait_for_completion(&stop.done);
+	}
 	return stop.result;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
