Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSEHV2x>; Wed, 8 May 2002 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSEHV2w>; Wed, 8 May 2002 17:28:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56827 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315207AbSEHV2u>; Wed, 8 May 2002 17:28:50 -0400
Subject: [PATCH] O(1) updates for 2.4.19-pre8-ac1
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-sig74+0n1PzEBzn7oMoX"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 08 May 2002 14:28:43 -0700
Message-Id: <1020893324.2147.163.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sig74+0n1PzEBzn7oMoX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Attached are the updates for O(1) resycned to 2.4.19-pre8-ac1.  The
previous patches still apply cleanly.  If you want the chunks, they are
at:

	http://www.kernel.org/pub/linux/kernel/people/rml/sched/for_alan/

Specifically, these patches:

	- final yield() abstractions (found some more in arch-dependent
	  code)
	- updated migration_init code, from 2.5, based on Erich Focht's
	  work.  Cleaner and simpler and works.  wli (author of current
	  implementation) signs off.
	- separate notion of max RT priority from max RT priority
	  exported to user-space.

Enjoy,

	Robert Love


--=-sig74+0n1PzEBzn7oMoX
Content-Disposition: attachment; filename=sched-updates-rml-2.4.19-pre8-ac1-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-updates-rml-2.4.19-pre8-ac1-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac1/arch/alpha/mm/fault.c linux/arch/alpha/mm/f=
ault.c
--- linux-2.4.19-pre8-ac1/arch/alpha/mm/fault.c	Wed May  8 12:03:59 2002
+++ linux/arch/alpha/mm/fault.c	Wed May  8 13:40:13 2002
@@ -196,8 +196,7 @@
  */
 out_of_memory:
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/arm/mm/fault-common.c linux/arch/arm/m=
m/fault-common.c
--- linux-2.4.19-pre8-ac1/arch/arm/mm/fault-common.c	Wed May  8 12:04:09 20=
02
+++ linux/arch/arm/mm/fault-common.c	Wed May  8 13:40:13 2002
@@ -225,8 +225,7 @@
 	 * If we are out of memory for pid1,
 	 * sleep for a while and retry
 	 */
-	tsk->policy |=3D SCHED_YIELD;
-	schedule();
+	yield();
 	goto survive;
=20
 check_stack:
diff -urN linux-2.4.19-pre8-ac1/arch/ia64/mm/fault.c linux/arch/ia64/mm/fau=
lt.c
--- linux-2.4.19-pre8-ac1/arch/ia64/mm/fault.c	Wed May  8 12:04:11 2002
+++ linux/arch/ia64/mm/fault.c	Wed May  8 13:40:13 2002
@@ -196,8 +196,7 @@
   out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/m68k/mm/fault.c linux/arch/m68k/mm/fau=
lt.c
--- linux-2.4.19-pre8-ac1/arch/m68k/mm/fault.c	Wed May  8 12:04:07 2002
+++ linux/arch/m68k/mm/fault.c	Wed May  8 13:40:13 2002
@@ -181,8 +181,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/mips/mm/fault.c linux/arch/mips/mm/fau=
lt.c
--- linux-2.4.19-pre8-ac1/arch/mips/mm/fault.c	Wed May  8 12:04:01 2002
+++ linux/arch/mips/mm/fault.c	Wed May  8 13:40:13 2002
@@ -211,8 +211,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/mips64/mm/fault.c linux/arch/mips64/mm=
/fault.c
--- linux-2.4.19-pre8-ac1/arch/mips64/mm/fault.c	Wed May  8 12:04:13 2002
+++ linux/arch/mips64/mm/fault.c	Wed May  8 13:40:13 2002
@@ -240,8 +240,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/ppc/mm/fault.c linux/arch/ppc/mm/fault=
.c
--- linux-2.4.19-pre8-ac1/arch/ppc/mm/fault.c	Wed May  8 12:04:04 2002
+++ linux/arch/ppc/mm/fault.c	Wed May  8 13:40:13 2002
@@ -197,8 +197,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/s390/mm/fault.c linux/arch/s390/mm/fau=
lt.c
--- linux-2.4.19-pre8-ac1/arch/s390/mm/fault.c	Wed May  8 12:04:13 2002
+++ linux/arch/s390/mm/fault.c	Wed May  8 13:40:13 2002
@@ -290,8 +290,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/s390x/mm/fault.c linux/arch/s390x/mm/f=
ault.c
--- linux-2.4.19-pre8-ac1/arch/s390x/mm/fault.c	Wed May  8 12:04:14 2002
+++ linux/arch/s390x/mm/fault.c	Wed May  8 13:40:13 2002
@@ -290,8 +290,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/arch/sh/mm/fault.c linux/arch/sh/mm/fault.c
--- linux-2.4.19-pre8-ac1/arch/sh/mm/fault.c	Wed May  8 12:04:10 2002
+++ linux/arch/sh/mm/fault.c	Wed May  8 13:40:13 2002
@@ -207,8 +207,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre8-ac1/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac1/kernel/sched.c	Wed May  8 12:03:14 2002
+++ linux/kernel/sched.c	Wed May  8 13:40:18 2002
@@ -22,13 +22,17 @@
 #include <linux/kernel_stat.h>
=20
 /*
- * Priority of a process goes from 0 to MAX_PRIO-1.  The
- * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
- * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
- * Priority values are inverted: lower p->prio value means higher
- * priority.
+ * Priority of a process goes from 0 to 139. The 0-99
+ * priority range is allocated to RT tasks, the 100-139
+ * range is for SCHED_OTHER tasks. Priority values are
+ * inverted: lower p->prio value means higher priority.
+ *=20
+ * MAX_USER_RT_PRIO allows the actual maximum RT priority
+ * to be separate from the value exported to user-space.
+ * NOTE: MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 #define MAX_RT_PRIO		100
+#define MAX_USER_RT_PRIO	100
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
=20
 /*
@@ -1025,7 +1029,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - MAX_RT_PRIO;
+	return p->prio - MAX_USER_RT_PRIO;
 }
=20
 int task_nice(task_t *p)
@@ -1082,11 +1086,11 @@
 	}
=20
 	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are 1..MAX_RT_PRIO-1,
-	 * valid priority for SCHED_OTHER is 0.
+	 * Valid priorities for SCHED_FIFO and SCHED_RR are
+	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
 	 */
 	retval =3D -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > MAX_RT_PRIO - 1)
+	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
 	if ((policy =3D=3D SCHED_OTHER) !=3D (lp.sched_priority =3D=3D 0))
 		goto out_unlock;
@@ -1106,7 +1110,7 @@
 	p->policy =3D policy;
 	p->rt_priority =3D lp.sched_priority;
 	if (policy !=3D SCHED_OTHER)
-		p->prio =3D (MAX_RT_PRIO - 1) - p->rt_priority;
+		p->prio =3D MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio =3D p->static_prio;
 	if (array)
@@ -1229,7 +1233,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret =3D MAX_RT_PRIO - 1;
+		ret =3D MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_OTHER:
 		ret =3D 0;
@@ -1536,80 +1540,34 @@
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
-
-	/*
-	 * We have to migrate manually - there is no migration thread
-	 * to do this for us yet :-)
-	 *
-	 * We use the following property of the Linux scheduler. At
-	 * this point no other task is running, so by keeping all
-	 * migration threads running, the load-balancer will distribute
-	 * them between all CPUs equally. At that point every migration
-	 * task binds itself to the current CPU.
-	 */
=20
 	/*
-	 * Enter the loop with preemption disabled so that
-	 * smp_processor_id() remains valid through the check. The
-	 * interior of the wait loop re-enables preemption in an
-	 * attempt to get scheduled off the current cpu. When the
-	 * loop is exited the lock bit in migration_mask is acquired
-	 * and preemption is disabled on the way out. This way the
-	 * cpu acquired remains valid when ->cpus_allowed is set.
+	 * The first migration thread is started on CPU #0. This one can
+	 * migrate the other migration threads to their destination CPUs.
 	 */
-	while (test_and_set_bit(smp_processor_id(), &migration_mask))
-		yield();
+	if (cpu !=3D 0) {
+		while (!cpu_rq(cpu_logical_map(0))->migration_thread)
+			yield();
+		set_cpus_allowed(current, 1UL << cpu);
+	}
+	printk("migration_task %d on cpu=3D%d\n", cpu, smp_processor_id());
+	ret =3D setscheduler(0, SCHED_FIFO, &param);
=20
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
@@ -1634,25 +1592,25 @@
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
@@ -1660,28 +1618,19 @@
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

--=-sig74+0n1PzEBzn7oMoX--

