Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317815AbSFSIkl>; Wed, 19 Jun 2002 04:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSFSIkk>; Wed, 19 Jun 2002 04:40:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33676 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317815AbSFSIkk>;
	Wed, 19 Jun 2002 04:40:40 -0400
Date: Wed, 19 Jun 2002 10:38:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] migration thread & hotplug fixes, 2.5.23
Message-ID: <Pine.LNX.4.44.0206191037480.5939-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the migration init code to deal with nonlinear 
enumeration of CPUs.

	Ingo

diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Jun 19 10:35:55 2002
+++ b/kernel/sched.c	Wed Jun 19 10:35:55 2002
@@ -1775,6 +1775,8 @@
 	preempt_enable();
 }
 
+static __initdata int master_migration_thread;
+
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = (int) (long) bind_cpu;
@@ -1786,14 +1788,12 @@
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	/* FIXME: First CPU may not be zero, but this crap code
-           vanishes with hotplug cpu patch anyway. --RR */
 	/*
-	 * The first migration thread is started on CPU #0. This one can
-	 * migrate the other migration threads to their destination CPUs.
+	 * The first migration thread is started on CPU #0, it migrates
+	 * the other migration threads to their destination CPUs.
 	 */
-	if (cpu != 0) {
-		while (!cpu_rq(0)->migration_thread)
+	if (cpu != master_migration_thread) {
+		while (!cpu_rq(master_migration_thread)->migration_thread)
 			yield();
 		set_cpus_allowed(current, 1UL << cpu);
 	}
@@ -1857,7 +1857,9 @@
 {
 	int cpu;
 
-	current->cpus_allowed = 1UL << 0;
+	master_migration_thread = smp_processor_id();
+	current->cpus_allowed = 1UL << master_migration_thread;
+	
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;

