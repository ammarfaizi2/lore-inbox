Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319358AbSIKWQc>; Wed, 11 Sep 2002 18:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319361AbSIKWQc>; Wed, 11 Sep 2002 18:16:32 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:20490
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319358AbSIKWQa>; Wed, 11 Sep 2002 18:16:30 -0400
Subject: [PATCH] 2.4-ac: sched_yield()
From: Robert Love <rml@tech9.net>
To: alan@redhat.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-J3SVbYOMY6tt+Ll2GktB"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 18:21:18 -0400
Message-Id: <1031782879.937.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J3SVbYOMY6tt+Ll2GktB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alan,

Following is a set of scheduler updates from 2.5.  All should be sane
and safe.  I would prefer to toss you obviously correct/tested bits in
pieces than a large single update.  You can also get all of these at:
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/for_alan

Anyhow...

Attached patch gets sched_yield() right, fixing all outstanding issues.
Really. (from Ingo)

Also implement 2.5's yield() which sets task->state to be safe. (from
akpm)

Patch is against 2.4.20-pre5-ac4, please apply.

	Robert Love


--=-J3SVbYOMY6tt+Ll2GktB
Content-Disposition: attachment; filename=200-sched-yield.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=200-sched-yield.patch; charset=ISO-8859-1

diff -urN linux-2.4.20-pre5-ac4/include/linux/sched.h linux/include/linux/s=
ched.h
--- linux-2.4.20-pre5-ac4/include/linux/sched.h	Mon Sep  9 19:27:59 2002
+++ linux/include/linux/sched.h	Wed Sep 11 16:13:21 2002
@@ -486,9 +486,7 @@
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 extern int idle_cpu(int cpu);
-
-asmlinkage long sys_sched_yield(void);
-#define yield() sys_sched_yield()
+extern void yield(void);
=20
 /*
  * The default (Linux) execution domain.
diff -urN linux-2.4.20-pre5-ac4/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.20-pre5-ac4/kernel/ksyms.c	Mon Sep  9 19:27:58 2002
+++ linux/kernel/ksyms.c	Wed Sep 11 16:23:02 2002
@@ -455,7 +455,7 @@
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 EXPORT_SYMBOL(schedule);
 EXPORT_SYMBOL(schedule_timeout);
-EXPORT_SYMBOL(sys_sched_yield);
+EXPORT_SYMBOL(yield);
 EXPORT_SYMBOL(set_user_nice);
 EXPORT_SYMBOL(task_nice);
 EXPORT_SYMBOL_GPL(idle_cpu);
diff -urN linux-2.4.20-pre5-ac4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.20-pre5-ac4/kernel/sched.c	Mon Sep  9 19:27:58 2002
+++ linux/kernel/sched.c	Wed Sep 11 16:13:31 2002
@@ -1366,46 +1366,31 @@
 	return real_len;
 }
=20
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * this function yields the current CPU by moving the calling thread
+ * to the expired array. If there are no other threads running on this
+ * CPU then this function will return.
+ */
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq =3D this_rq_lock();
 	prio_array_t *array =3D current->array;
=20
 	/*
-	 * There are three levels of how a yielding task will give up
-	 * the current CPU:
+	 * We implement yielding by moving the task into the expired
+	 * queue.
 	 *
-	 *  #1 - it decreases its priority by one. This priority loss is
-	 *       temporary, it's recovered once the current timeslice
-	 *       expires.
-	 *
-	 *  #2 - once it has reached the lowest priority level,
-	 *       it will give up timeslices one by one. (We do not
-	 *       want to give them up all at once, it's gradual,
-	 *       to protect the casual yield()er.)
-	 *
-	 *  #3 - once all timeslices are gone we put the process into
-	 *       the expired array.
-	 *
-	 *  (special rule: RT tasks do not lose any priority, they just
-	 *  roundrobin on their current priority level.)
+	 * (special rule: RT tasks will just roundrobin in the active
+	 *  array.)
 	 */
-	if (likely(current->prio =3D=3D MAX_PRIO-1)) {
-		if (current->time_slice <=3D 1) {
-			dequeue_task(current, rq->active);
-			enqueue_task(current, rq->expired);
-		} else
-			current->time_slice--;
-	} else if (unlikely(rt_task(current))) {
-		list_del(&current->run_list);
-		list_add_tail(&current->run_list, array->queue + current->prio);
+	if (likely(!rt_task(current))) {
+		dequeue_task(current, array);
+		enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);
-		if (list_empty(array->queue + current->prio))
-			__clear_bit(current->prio, array->bitmap);
-		current->prio++;
 		list_add_tail(&current->run_list, array->queue + current->prio);
-		__set_bit(current->prio, array->bitmap);
 	}
 	spin_unlock(&rq->lock);
=20
@@ -1414,6 +1399,18 @@
 	return 0;
 }
=20
+/**
+ * yield - yield the current processor to other threads.
+ *
+ * this is a shortcut for kernel-space yielding - it marks the
+ * thread runnable and calls sys_sched_yield().
+ */
+void yield(void)
+{
+	set_current_state(TASK_RUNNING);
+	sys_sched_yield();
+}
+
 asmlinkage long sys_sched_get_priority_max(int policy)
 {
 	int ret =3D -EINVAL;

--=-J3SVbYOMY6tt+Ll2GktB--

