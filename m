Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315922AbSEGRyH>; Tue, 7 May 2002 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSEGRyG>; Tue, 7 May 2002 13:54:06 -0400
Received: from zero.tech9.net ([209.61.188.187]:5648 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315923AbSEGRx4>;
	Tue, 7 May 2002 13:53:56 -0400
Subject: [PATCH] 2.4-ac: migration_init improvements
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-0sSFwAKPXbFZCGKfC/fC"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-3) 
Date: 07 May 2002 10:53:57 -0700
Message-Id: <1020794038.806.25.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0sSFwAKPXbFZCGKfC/fC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

The attached patch simplifies the migration_init code (an ugly lot) with
a simpler mechanism.  This is Erich Focht's version which is now in
2.5.  It has proved stable both there and in my testing.

The new method is to bring up the first migration_thread, and then use
it to migrate the remaining threads to their respective CPUs.  The
method makes sense and removes a lot of code.

This patch also includes a boot hang fix demonstrated on arches where
logical CPU mapping != physical CPU mapping.  The bug was reported and
fixed by James Bottomley in 2.5.

Patch is against 2.4.19-pre7-ac4, please apply.

	Robert Love


--=-0sSFwAKPXbFZCGKfC/fC
Content-Disposition: attachment; filename=sched-migration-init-rml-2.4.19-pre7-ac4-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-migration-init-rml-2.4.19-pre7-ac4-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre7-ac4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre7-ac4/kernel/sched.c	Mon Apr 29 12:33:23 2002
+++ linux/kernel/sched.c	Mon Apr 29 12:57:00 2002
@@ -1536,80 +1536,34 @@
 	down(&req.sem);
 }
=20
-/*
- * Treat the bits of migration_mask as lock bits.
- * If the bit corresponding to the cpu a migration_thread is
- * running on then we have failed to claim our cpu and must
- * yield in order to find another.
- */
-static volatile unsigned long migration_mask;
-static atomic_t migration_threads_seeking_cpu;
-static struct completion migration_complete
-			=3D COMPLETION_INITIALIZER(migration_complete);
-
-static int migration_thread(void * unused)
+static int migration_thread(void * bind_cpu)
 {
-	struct sched_param param =3D { sched_priority: MAX_RT_PRIO - 1 };
+	int cpu =3D cpu_logical_map((int) (long) bind_cpu);
+	struct sched_param param =3D { sched_priority: MAX_RT_PRIO-1 };
 	runqueue_t *rq;
 	int ret;
=20
 	daemonize();
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
-	ret =3D setscheduler(0, SCHED_FIFO, &param);
=20
 	/*
-	 * We have to migrate manually - there is no migration thread
-	 * to do this for us yet :-)
-	 *
-	 * We use the following property of the Linux scheduler. At
-	 * this point no other task is running, so by keeping all
-	 * migration threads running, the load-balancer will distribute
-	 * them between all CPUs equally. At that point every migration
-	 * task binds itself to the current CPU.
+	 * The first migration thread is started on CPU #0. This one can
+	 * migrate the other migration threads to their destination CPUs.
 	 */
+	if (cpu !=3D 0) {
+		while (!cpu_rq(cpu_logical_map(0))->migration_thread)
+			yield();
+		set_cpus_allowed(current, 1UL << cpu);
+	}
+	printk("migration_task %d on cpu=3D%d\n", cpu, smp_processor_id());
+	ret =3D setscheduler(0, SCHED_FIFO, &param);
=20
-	/*
-	 * Enter the loop with preemption disabled so that
-	 * smp_processor_id() remains valid through the check. The
-	 * interior of the wait loop re-enables preemption in an
-	 * attempt to get scheduled off the current cpu. When the
-	 * loop is exited the lock bit in migration_mask is acquired
-	 * and preemption is disabled on the way out. This way the
-	 * cpu acquired remains valid when ->cpus_allowed is set.
-	 */
-	while (test_and_set_bit(smp_processor_id(), &migration_mask))
-		yield();
-
-	current->cpus_allowed =3D 1 << smp_processor_id();
 	rq =3D this_rq();
 	rq->migration_thread =3D current;
=20
-	/*
-	 * Now that we've bound ourselves to a cpu, post to
-	 * migration_threads_seeking_cpu and wait for everyone else.
-	 * Preemption should remain disabled and the cpu should remain
-	 * in busywait. Yielding the cpu will allow the livelock
-	 * where where a timing pattern causes an idle task seeking a
-	 * migration_thread to always find the unbound migration_thread=20
-	 * running on the cpu's it tries to steal tasks from.
-	 */
-	atomic_dec(&migration_threads_seeking_cpu);
-	while (atomic_read(&migration_threads_seeking_cpu))
-		cpu_relax();
-
 	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
=20
-	/*
-	 * Everyone's found their cpu, so now wake migration_init().
-	 * Multiple wakeups are harmless; removal from the waitqueue
-	 * has locking built-in, and waking an empty queue is valid.
-	 */
-	complete(&migration_complete);
-
-	/*
-	 * Initiate the event loop.
-	 */
 	for (;;) {
 		runqueue_t *rq_src, *rq_dest;
 		struct list_head *head;
@@ -1634,25 +1588,25 @@
 		cpu_dest =3D __ffs(p->cpus_allowed);
 		rq_dest =3D cpu_rq(cpu_dest);
 repeat:
-		cpu_src =3D p->cpu;
+		cpu_src =3D p->thread_info->cpu;
 		rq_src =3D cpu_rq(cpu_src);
=20
 		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
-		if (p->cpu !=3D cpu_src) {
-			local_irq_restore(flags);
+		if (p->thread_info->cpu !=3D cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
+			local_irq_restore(flags);
 			goto repeat;
 		}
 		if (rq_src =3D=3D rq) {
-			p->cpu =3D cpu_dest;
+			p->thread_info->cpu =3D cpu_dest;
 			if (p->array) {
 				deactivate_task(p, rq_src);
 				activate_task(p, rq_dest);
 			}
 		}
-		local_irq_restore(flags);
 		double_rq_unlock(rq_src, rq_dest);
+		local_irq_restore(flags);
=20
 		up(&req->sem);
 	}
@@ -1660,28 +1614,19 @@
=20
 void __init migration_init(void)
 {
-	unsigned long orig_cache_decay_ticks;
 	int cpu;
=20
-	atomic_set(&migration_threads_seeking_cpu, smp_num_cpus);
-
-	orig_cache_decay_ticks =3D cache_decay_ticks;
-	cache_decay_ticks =3D 0;
-
-	for (cpu =3D 0; cpu < smp_num_cpus; cpu++)
-		if (kernel_thread(migration_thread, NULL,
+	current->cpus_allowed =3D 1UL << cpu_logical_map(0);
+	for (cpu =3D 0; cpu < smp_num_cpus; cpu++) {
+		if (kernel_thread(migration_thread, (void *) (long) cpu,
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
+	}
+	current->cpus_allowed =3D -1L;
=20
-	/*
-	 * We cannot have missed the wakeup for the migration_thread
-	 * bound for the cpu migration_init() is running on cannot
-	 * acquire this cpu until migration_init() has yielded it by
-	 * means of wait_for_completion().
-	 */
-	wait_for_completion(&migration_complete);
-
-	cache_decay_ticks =3D orig_cache_decay_ticks;
+	for (cpu =3D 0; cpu < smp_num_cpus; cpu++)
+		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
+			schedule_timeout(2);
 }
=20
 #endif /* CONFIG_SMP */

--=-0sSFwAKPXbFZCGKfC/fC--

