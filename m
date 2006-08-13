Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWHMKSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWHMKSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWHMKSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:18:17 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:48993 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750928AbWHMKSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:18:16 -0400
Date: Sun, 13 Aug 2006 18:18:10 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] check return value of cpu_callback
Message-ID: <20060813101810.GC8703@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spawing ksoftirqd, migration, or watchdog, and calling init_timers_cpu() may
fail with small memory. If it happens in initcalls, kernel NULL pointer
dereference happens later. This patch makes crash happen immediately in
such cases. It seems a bit better than getting kernel NULL pointer
dereference later.

CC: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 kernel/sched.c      |    4 +++-
 kernel/softirq.c    |    4 +++-
 kernel/softlockup.c |    3 ++-
 kernel/timer.c      |    4 +++-
 4 files changed, 11 insertions(+), 4 deletions(-)

Index: work-failmalloc/kernel/softirq.c
===================================================================
--- work-failmalloc.orig/kernel/softirq.c
+++ work-failmalloc/kernel/softirq.c
@@ -612,7 +612,9 @@ static struct notifier_block __cpuinitda
 __init int spawn_ksoftirqd(void)
 {
 	void *cpu = (void *)(long)smp_processor_id();
-	cpu_callback(&cpu_nfb, CPU_UP_PREPARE, cpu);
+	int err = cpu_callback(&cpu_nfb, CPU_UP_PREPARE, cpu);
+
+	BUG_ON(err == NOTIFY_BAD);
 	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
 	register_cpu_notifier(&cpu_nfb);
 	return 0;
Index: work-failmalloc/kernel/softlockup.c
===================================================================
--- work-failmalloc.orig/kernel/softlockup.c
+++ work-failmalloc/kernel/softlockup.c
@@ -149,8 +149,9 @@ static struct notifier_block __cpuinitda
 __init void spawn_softlockup_task(void)
 {
 	void *cpu = (void *)(long)smp_processor_id();
+	int err = cpu_callback(&cpu_nfb, CPU_UP_PREPARE, cpu);
 
-	cpu_callback(&cpu_nfb, CPU_UP_PREPARE, cpu);
+	BUG_ON(err == NOTIFY_BAD);
 	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
 	register_cpu_notifier(&cpu_nfb);
 
Index: work-failmalloc/kernel/sched.c
===================================================================
--- work-failmalloc.orig/kernel/sched.c
+++ work-failmalloc/kernel/sched.c
@@ -5237,9 +5237,11 @@ static struct notifier_block __cpuinitda
 int __init migration_init(void)
 {
 	void *cpu = (void *)(long)smp_processor_id();
+	int err;
 
 	/* Start one for the boot CPU: */
-	migration_call(&migration_notifier, CPU_UP_PREPARE, cpu);
+	err = migration_call(&migration_notifier, CPU_UP_PREPARE, cpu);
+	BUG_ON(err == NOTIFY_BAD);
 	migration_call(&migration_notifier, CPU_ONLINE, cpu);
 	register_cpu_notifier(&migration_notifier);
 
Index: work-failmalloc/kernel/timer.c
===================================================================
--- work-failmalloc.orig/kernel/timer.c
+++ work-failmalloc/kernel/timer.c
@@ -1715,8 +1715,10 @@ static struct notifier_block __cpuinitda
 
 void __init init_timers(void)
 {
-	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
+	int err = timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
 				(void *)(long)smp_processor_id());
+
+	BUG_ON(err == NOTIFY_BAD);
 	register_cpu_notifier(&timers_nb);
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
 }
