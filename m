Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319362AbSIKWRV>; Wed, 11 Sep 2002 18:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319363AbSIKWRH>; Wed, 11 Sep 2002 18:17:07 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:25098
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319362AbSIKWQ6>; Wed, 11 Sep 2002 18:16:58 -0400
Subject: [PATCH] 2.4-ac task->cpu abstraction and optimization
From: Robert Love <rml@tech9.net>
To: alan@redhat.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-AYUtQjtlaoZx4Eb9QB7e"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 18:21:46 -0400
Message-Id: <1031782906.982.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AYUtQjtlaoZx4Eb9QB7e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Implement "task_cpu()" and "set_task_cpu()" as wrappers for reading and
writing task->cpu, respectively.

Additionally, introduce a nice optimization: on UP, task_cpu() can
hard-code to "0" and set_task_cpu() can be a no-op.

Patch is against 2.4.20-pre5-ac4, please apply.

	Robert Love


--=-AYUtQjtlaoZx4Eb9QB7e
Content-Disposition: attachment; filename=220-task_cpu.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=220-task_cpu.patch; charset=ISO-8859-1

diff -urN linux-2.4.20-pre5-ac4-rml/Documentation/sched-coding.txt linux/Do=
cumentation/sched-coding.txt
--- linux-2.4.20-pre5-ac4-rml/Documentation/sched-coding.txt	Wed Sep 11 17:=
39:05 2002
+++ linux/Documentation/sched-coding.txt	Wed Sep 11 17:39:25 2002
@@ -88,12 +88,13 @@
 	Returns the runqueue of the specified cpu.
 this_rq()
 	Returns the runqueue of the current cpu.
-task_rq(pid)
-	Returns the runqueue which holds the specified pid.
+task_rq(task)
+	Returns the runqueue which holds the specified task.
 cpu_curr(cpu)
 	Returns the task currently running on the given cpu.
-rt_task(pid)
-	Returns true if pid is real-time, false if not.
+rt_task(task)
+	Returns true if task is real-time, false if not.
+task_cpu(task)
=20
=20
 Process Control Methods
@@ -117,6 +118,8 @@
 	Clears need_resched in the given task.
 void set_need_resched()
 	Sets need_resched in the current task.
+void set_task_cpu(task, cpu)
+	Sets task->cpu to cpu on SMP.  Noop on UP.
 void clear_need_resched()
 	Clears need_resched in the current task.
 int need_resched()
diff -urN linux-2.4.20-pre5-ac4-rml/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.4.20-pre5-ac4-rml/fs/proc/array.c	Wed Sep 11 17:38:21 2002
+++ linux/fs/proc/array.c	Wed Sep 11 17:39:25 2002
@@ -389,7 +389,7 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->cpu);
+		task_cpu(task));
 	if(mm)
 		mmput(mm);
 	return res;
diff -urN linux-2.4.20-pre5-ac4-rml/include/linux/sched.h linux/include/lin=
ux/sched.h
--- linux-2.4.20-pre5-ac4-rml/include/linux/sched.h	Wed Sep 11 17:40:52 200=
2
+++ linux/include/linux/sched.h	Wed Sep 11 17:39:25 2002
@@ -976,6 +976,34 @@
 	return unlikely(current->need_resched);
 }
=20
+/*
+ * Wrappers for p->cpu access. No-op on UP.
+ */
+#ifdef CONFIG_SMP
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return p->cpu;
+}
+
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+	p->cpu =3D cpu;
+}
+
+#else
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+}
+
+#endif /* CONFIG_SMP */
+
 #endif /* __KERNEL__ */
=20
 #endif
diff -urN linux-2.4.20-pre5-ac4-rml/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.20-pre5-ac4-rml/kernel/sched.c	Wed Sep 11 17:40:57 2002
+++ linux/kernel/sched.c	Wed Sep 11 17:40:33 2002
@@ -148,7 +148,7 @@
=20
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
-#define task_rq(p)		cpu_rq((p)->cpu)
+#define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
=20
@@ -311,8 +311,8 @@
 	need_resched =3D p->need_resched;
 	wmb();
 	set_tsk_need_resched(p);
-	if (!need_resched && (p->cpu !=3D smp_processor_id()))
-		smp_send_reschedule(p->cpu);
+	if (!need_resched && (task_cpu(p) !=3D smp_processor_id()))
+		smp_send_reschedule(task_cpu(p));
 #else
 	set_tsk_need_resched(p);
 #endif
@@ -391,10 +391,10 @@
 		 * currently. Do not violate hard affinity.
 		 */
 		if (unlikely(sync && (rq->curr !=3D p) &&
-			(p->cpu !=3D smp_processor_id()) &&
+			(task_cpu(p) !=3D smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
=20
-			p->cpu =3D smp_processor_id();
+			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
 			goto repeat_lock_task;
 		}
@@ -437,7 +437,7 @@
 		p->sleep_avg =3D p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio =3D effective_prio(p);
 	}
-	p->cpu =3D smp_processor_id();
+	set_task_cpu(p, smp_processor_id());
 	activate_task(p, rq);
=20
 	rq_unlock(rq);
@@ -727,7 +727,7 @@
 	 */
 	dequeue_task(next, array);
 	busiest->nr_running--;
-	next->cpu =3D this_cpu;
+	set_task_cpu(next, this_cpu);
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
 	if (next->prio < current->prio)
@@ -1718,7 +1718,7 @@
=20
 void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq =3D cpu_rq(cpu), *rq =3D cpu_rq(idle->cpu);
+	runqueue_t *idle_rq =3D cpu_rq(cpu), *rq =3D cpu_rq(task_cpu(idle));
 	unsigned long flags;
=20
 	__save_flags(flags);
@@ -1730,7 +1730,7 @@
 	idle->array =3D NULL;
 	idle->prio =3D MAX_PRIO;
 	idle->state =3D TASK_RUNNING;
-	idle->cpu =3D cpu;
+	set_task_cpu(idle, cpu);
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
@@ -1835,7 +1835,7 @@
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << p->cpu)) {
+	if (new_mask & (1UL << task_cpu(p))) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1844,7 +1844,7 @@
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && (p !=3D rq->curr)) {
-		p->cpu =3D __ffs(p->cpus_allowed);
+		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1914,18 +1914,18 @@
 		cpu_dest =3D __ffs(p->cpus_allowed);
 		rq_dest =3D cpu_rq(cpu_dest);
 repeat:
-		cpu_src =3D p->cpu;
+		cpu_src =3D task_cpu(p);
 		rq_src =3D cpu_rq(cpu_src);
=20
 		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
-		if (p->cpu !=3D cpu_src) {
+		if (task_cpu(p) !=3D cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
 			local_irq_restore(flags);
 			goto repeat;
 		}
 		if (rq_src =3D=3D rq) {
-			p->cpu =3D cpu_dest;
+			set_task_cpu(p, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
 				activate_task(p, rq_dest);

--=-AYUtQjtlaoZx4Eb9QB7e--

