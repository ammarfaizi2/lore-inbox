Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWGZJCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWGZJCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 05:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWGZJCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 05:02:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11494 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030417AbWGZJCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 05:02:03 -0400
Date: Wed, 26 Jul 2006 10:55:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <20060726085556.GA19501@elte.hu>
References: <Pine.LNX.4.64.0607230215480.11861@localhost.localdomain> <20060726084152.GA15909@elte.hu> <20060726085404.GA19151@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20060726085404.GA19151@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5145]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> and i also had to do the fixes below to get it to build.

then it crashed with the assert below. I'll skip this one for now. I've 
attached the patches (cleaned up for whitespaces) plus the 
build-fixpatch.

	Ingo

Brought up 2 CPUs
BUG at kernel/rtmutex.c:773!
------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:773!
invalid opcode: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c03e407c>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rt7 #14)
EIP is at rt_lock_slowlock+0x21e/0x231
eax: 00000020   ebx: c31d7000   ecx: c0477be4   edx: c31d97f0
esi: 00000000   edi: c31d7d34   ebp: c31d7cdc   esp: c31d7c70
ds: 007b   es: 007b   ss: 0068   preempt: 00000001


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt-timeout-prio-bug-1.patch"

This patch adds a new interface to the scheduler: A task can be scheduled in 
LIFO order for a while instead of the usual FIFO order. This is more or less 
equivalent to raising it's priority by 1/2.

This property is now needed by the rtmutexes to solve the last few issues, but
I can imagine it can be usefull for other subsystems too.

  include/linux/init_task.h |    1
 include/linux/init_task.h |    1 
 include/linux/sched.h     |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c            |   29 +++++++++++++++++----
 3 files changed, 87 insertions(+), 5 deletions(-)

Index: linux-rt.q/include/linux/init_task.h
===================================================================
--- linux-rt.q.orig/include/linux/init_task.h
+++ linux-rt.q/include/linux/init_task.h
@@ -89,6 +89,7 @@ extern struct group_info init_groups;
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.normal_prio	= MAX_PRIO-20,					\
+	.sched_lifo	= 0,						\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
Index: linux-rt.q/include/linux/sched.h
===================================================================
--- linux-rt.q.orig/include/linux/sched.h
+++ linux-rt.q/include/linux/sched.h
@@ -853,6 +853,7 @@ struct task_struct {
 	int prio, static_prio, normal_prio;
 	struct list_head run_list;
 	prio_array_t *array;
+	int sched_lifo;
 
 	unsigned short ioprio;
 	unsigned int btrace_seq;
@@ -1223,6 +1224,67 @@ extern task_t *idle_task(int cpu);
 extern task_t *curr_task(int cpu);
 extern void set_curr_task(int cpu, task_t *p);
 
+/*
+ * sched_lifo: A task can be sched-lifo mode and be sure to be scheduled before
+ * any other task with the same or lower priority - except for later arriving
+ * tasks with the sched_lifo property set.
+ *
+ * It is supposed to work similar to irq-flags:
+ *
+ *          int old_sched_lifo;
+ *          ...
+ *          old_sched_lifo = enter_sched_lifo();
+ *          ...
+ *          leave_sched_lifo(old_sched_lifo);
+ *
+ * The purpose is that the sched-lifo sections can be easily nested.
+ *
+ * With the get/enter/leave_sched_lifo_other() the lifo status on another task
+ * can be manipulated, The status is neither atomic, nor protected by any lock.
+ * Therefore it is up to the user of those function to ensure that the
+ * operations a properly serialized. The easiest will be not to use
+ * *_sched_lifo_other() functions.
+ */
+
+static inline int get_sched_lifo_other(struct task_struct *task)
+{
+	return task->sched_lifo;
+}
+
+static inline int get_sched_lifo(void)
+{
+	return get_sched_lifo_other(current);
+}
+
+static inline int enter_sched_lifo_other(struct task_struct *task)
+{
+	int old = task->sched_lifo;
+	task->sched_lifo = 1;
+	return old;
+}
+
+static inline int enter_sched_lifo(void)
+{
+	return enter_sched_lifo_other(current);
+}
+
+
+static inline void leave_sched_lifo_other(struct task_struct *task,
+					  int old_value)
+{
+	task->sched_lifo = old_value;
+  /*
+   * if sched_lifo == 0 should we move to the tail of the runqueue ?
+   * what if we never sleeped while in sched_lifo  ?
+   */
+}
+
+static inline void leave_sched_lifo(int old_value)
+{
+	leave_sched_lifo_other(current, old_value);
+}
+
+
 void yield(void);
 void __yield(void);
 
Index: linux-rt.q/kernel/sched.c
===================================================================
--- linux-rt.q.orig/kernel/sched.c
+++ linux-rt.q/kernel/sched.c
@@ -162,8 +162,8 @@
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
+#define TASK_PREEMPTS(p,q) task_preempts(p,q)
+#define TASK_PREEMPTS_CURR(p, rq)	TASK_PREEMPTS(p,(rq)->curr)
 
 /*
  * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
@@ -646,6 +646,17 @@ static inline void sched_info_switch(tas
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
+int task_preempts(struct task_struct *p, struct task_struct *q)
+{
+	if (p->prio < q->prio)
+		return 1;
+
+	if (p->prio > q->prio)
+		return 0;
+
+	return p->sched_lifo;
+}
+
 static __cacheline_aligned_in_smp atomic_t rt_overload;
 
 static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
@@ -710,7 +721,12 @@ static void enqueue_task(struct task_str
 		dump_stack();
 	}
 	sched_info_queued(p);
-	list_add_tail(&p->run_list, array->queue + p->prio);
+
+	if (p->sched_lifo)
+		list_add(&p->run_list, array->queue + p->prio);
+	else
+		list_add_tail(&p->run_list, array->queue + p->prio);
+
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
@@ -723,7 +739,10 @@ static void enqueue_task(struct task_str
  */
 static void requeue_task(struct task_struct *p, prio_array_t *array)
 {
-	list_move_tail(&p->run_list, array->queue + p->prio);
+	if (p->sched_lifo)
+		list_move(&p->run_list, array->queue + p->prio);
+	else
+		list_move_tail(&p->run_list, array->queue + p->prio);
 }
 
 static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
@@ -1313,7 +1332,7 @@ static void balance_rt_tasks(runqueue_t 
 		 * Do we have an RT task that preempts
 		 * the to-be-scheduled task?
 		 */
-		if (p && (p->prio < next->prio)) {
+		if (p && TASK_PREEMPTS(p,next)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!p->array);
 			schedstat_inc(this_rq, rto_pulled);

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt-timeout-prio-bug-2.patch"

This is based on and almost identical to the one Thomas Gleixner sent out 
earlier. His description was:

Make test suite setscheduler calls asynchronously. Remove the waits in the test
cases and add a new testcase to verify the correctness of the setscheduler
priority propagation

 kernel/rtmutex-tester.c                               |   31 +--
 scripts/rt-tester/check-all.sh                        |    2
 scripts/rt-tester/reset-tester.py                     |   18 +
 scripts/rt-tester/t2-l1-signal.tst                    |    3
 scripts/rt-tester/t3-l1-pi-signal.tst                 |    3
 scripts/rt-tester/t4-l2-pi-deboost.tst                |    2
 scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |  182 ++++++++++++++++++
 scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |    2
 kernel/rtmutex-tester.c                               |   31 +--
 scripts/rt-tester/check-all.sh                        |    2 
 scripts/rt-tester/reset-tester.py                     |   18 +
 scripts/rt-tester/t2-l1-signal.tst                    |    3 
 scripts/rt-tester/t3-l1-pi-signal.tst                 |    3 
 scripts/rt-tester/t4-l2-pi-deboost.tst                |    2 
 scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |  182 ++++++++++++++++++
 scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |    2 
 8 files changed, 228 insertions(+), 15 deletions(-)

Index: linux-rt.q/kernel/rtmutex-tester.c
===================================================================
--- linux-rt.q.orig/kernel/rtmutex-tester.c
+++ linux-rt.q/kernel/rtmutex-tester.c
@@ -55,7 +55,6 @@ enum test_opcodes {
 
 static int handle_op(struct test_thread_data *td, int lockwakeup)
 {
-	struct sched_param schedpar;
 	int i, id, ret = -EINVAL;
 
 	switch(td->opcode) {
@@ -63,17 +62,6 @@ static int handle_op(struct test_thread_
 	case RTTEST_NOP:
 		return 0;
 
-	case RTTEST_SCHEDOT:
-		schedpar.sched_priority = 0;
-		ret = sched_setscheduler(current, SCHED_NORMAL, &schedpar);
-		if (!ret)
-			set_user_nice(current, 0);
-		return ret;
-
-	case RTTEST_SCHEDRT:
-		schedpar.sched_priority = td->opdata;
-		return sched_setscheduler(current, SCHED_FIFO, &schedpar);
-
 	case RTTEST_LOCKCONT:
 		td->mutexes[td->opdata] = 1;
 		td->event = atomic_add_return(1, &rttest_event);
@@ -310,9 +298,10 @@ static int test_func(void *data)
 static ssize_t sysfs_test_command(struct sys_device *dev, const char *buf,
 				  size_t count)
 {
+	struct sched_param schedpar;
 	struct test_thread_data *td;
 	char cmdbuf[32];
-	int op, dat, tid;
+	int op, dat, tid, ret;
 
 	td = container_of(dev, struct test_thread_data, sysdev);
 	tid = td->sysdev.id;
@@ -334,6 +323,22 @@ static ssize_t sysfs_test_command(struct
 		return -EINVAL;
 
 	switch (op) {
+	case RTTEST_SCHEDOT:
+		schedpar.sched_priority = 0;
+		ret = sched_setscheduler(threads[tid], SCHED_NORMAL,
+					 &schedpar);
+		if (ret)
+			return ret;
+		set_user_nice(current, 0);
+		break;
+
+	case RTTEST_SCHEDRT:
+		schedpar.sched_priority = dat;
+		ret = sched_setscheduler(threads[tid], SCHED_FIFO, &schedpar);
+		if (ret)
+			return ret;
+		break;
+
 	case RTTEST_SIGNAL:
 		send_sig(SIGHUP, threads[tid], 0);
 		break;
Index: linux-rt.q/scripts/rt-tester/check-all.sh
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/check-all.sh
+++ linux-rt.q/scripts/rt-tester/check-all.sh
@@ -18,4 +18,4 @@ testit t3-l1-pi-steal.tst
 testit t3-l2-pi.tst
 testit t4-l2-pi-deboost.tst
 testit t5-l4-pi-boost-deboost.tst
-
+testit t5-l4-pi-boost-deboost-setsched.tst
\ No newline at end of file
Index: linux-rt.q/scripts/rt-tester/reset-tester.py
===================================================================
--- /dev/null
+++ linux-rt.q/scripts/rt-tester/reset-tester.py
@@ -0,0 +1,18 @@
+#!/usr/bin/env python
+
+sysfsprefix = "/sys/devices/system/rttest/rttest"
+statusfile = "/status"
+commandfile = "/command"
+
+for i in range(0,8):
+    cmdstr = "%s:%s" %("99", "0")
+    fname = "%s%d%s" %(sysfsprefix, i, commandfile)
+
+    try:
+        fcmd = open(fname, 'w')
+        fcmd.write(cmdstr)
+        fcmd.close()
+    except Exception,ex:
+        print i
+        print ex
+
Index: linux-rt.q/scripts/rt-tester/t2-l1-signal.tst
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/t2-l1-signal.tst
+++ linux-rt.q/scripts/rt-tester/t2-l1-signal.tst
@@ -77,3 +77,6 @@ T: opcodeeq:		1:	-4
 # Unlock and exit
 C: unlock:		0: 	0
 W: unlocked:		0: 	0
+
+# Reset the -4 opcode from the signal
+C: reset:               1:      0
\ No newline at end of file
Index: linux-rt.q/scripts/rt-tester/t3-l1-pi-signal.tst
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/t3-l1-pi-signal.tst
+++ linux-rt.q/scripts/rt-tester/t3-l1-pi-signal.tst
@@ -98,4 +98,5 @@ C: unlock:		1: 	0
 W: unlocked:		1: 	0
 
 
-
+# Reset the -4 opcode from the signal
+C: reset:               2:      0
\ No newline at end of file
Index: linux-rt.q/scripts/rt-tester/t4-l2-pi-deboost.tst
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/t4-l2-pi-deboost.tst
+++ linux-rt.q/scripts/rt-tester/t4-l2-pi-deboost.tst
@@ -125,3 +125,5 @@ W: unlocked:		2:	1
 C: unlock:		0:	0
 W: unlocked:		0:	0
 
+# Reset the -4 opcode from the signal
+C: reset:               3:      0
\ No newline at end of file
Index: linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
===================================================================
--- /dev/null
+++ linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
@@ -0,0 +1,182 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 5 threads 4 lock PI - modify priority of blocked threads
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+C: schedfifo:		1: 	81
+C: schedfifo:		2: 	82
+C: schedfifo:		3: 	83
+C: schedfifo:		4: 	84
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L1
+C: locknowait:		1: 	1
+W: locked:		1: 	1
+
+# T1 lock L0
+C: lockintnowait:	1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	81
+
+# T2 lock L2
+C: locknowait:		2: 	2
+W: locked:		2: 	2
+
+# T2 lock L1
+C: lockintnowait:	2: 	1
+W: blocked:		2: 	1
+T: prioeq:		0: 	82
+T: prioeq:		1:	82
+
+# T3 lock L3
+C: locknowait:		3: 	3
+W: locked:		3: 	3
+
+# T3 lock L2
+C: lockintnowait:	3: 	2
+W: blocked:		3: 	2
+T: prioeq:		0: 	83
+T: prioeq:		1:	83
+T: prioeq:		2:	83
+
+# T4 lock L3
+C: lockintnowait:	4:	3
+W: blocked:		4: 	3
+T: prioeq:		0: 	84
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+
+# Reduce prio of T4
+C: schedfifo:		4: 	80
+T: prioeq:		0: 	83
+T: prioeq:		1:	83
+T: prioeq:		2:	83
+T: prioeq:		3:	83
+T: prioeq:		4:	80
+
+# Increase prio of T4
+C: schedfifo:		4: 	84
+T: prioeq:		0: 	84
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+T: prioeq:		4:	84
+
+# Reduce prio of T3
+C: schedfifo:		3: 	80
+T: prioeq:		0: 	84
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+T: prioeq:		4:	84
+
+# Increase prio of T3
+C: schedfifo:		3: 	85
+T: prioeq:		0: 	85
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	85
+T: prioeq:		4:	84
+
+# Reduce prio of T3
+C: schedfifo:		3: 	83
+T: prioeq:		0: 	84
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+T: prioeq:		4:	84
+
+# Signal T4
+C: signal:		4: 	0
+W: unlocked:		4: 	3
+T: prioeq:		0: 	83
+T: prioeq:		1:	83
+T: prioeq:		2:	83
+T: prioeq:		3:	83
+
+# Signal T3
+C: signal:		3: 	0
+W: unlocked:		3: 	2
+T: prioeq:		0: 	82
+T: prioeq:		1:	82
+T: prioeq:		2:	82
+
+# Signal T2
+C: signal:		2: 	0
+W: unlocked:		2: 	1
+T: prioeq:		0: 	81
+T: prioeq:		1:	81
+
+# Signal T1
+C: signal:		1: 	0
+W: unlocked:		1: 	0
+T: priolt:		0: 	1
+
+# Unlock and exit
+C: unlock:		3:	3
+C: unlock:		2:	2
+C: unlock:		1:	1
+C: unlock:		0:	0
+
+W: unlocked:		3:	3
+W: unlocked:		2:	2
+W: unlocked:		1:	1
+W: unlocked:		0:	0
Index: linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
+++ linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
@@ -146,3 +146,5 @@ W: unlocked:		2:	2
 W: unlocked:		1:	1
 W: unlocked:		0:	0
 
+# Reset the -4 opcode from the signal
+C: reset:               4:      0
\ No newline at end of file

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt-timeout-prio-bug-3.patch"

This patch fixes

1) The timeout bug in rtmutexes and PI futexes: When a task is blocked on a 
lock with timeout and times out it will not wakeup until the owner of the lock
is done. This is because the owner is boosted to the same priority as the 
blocked task and therefore has the CPU such the blocked task never gets around 
to de-boost it!

2) setscheduler() now does the PI walking - but defers the work to the blocked
task.

3) In general it makes sure that a task, which is boosting another has enough
priority to do the de-boosting no matter how complicated the lock structure is, 
or how many times the priorities have changed.

The idea behind the patch is simple:
If a task is boosting another it is scheduled in LIFO order and it will never
loose it's priority. This property lasts until it has left the lock operation
(successfully or not).

The needed priority to do the unboosting is stored in task->boosting_prio.
In the current patch this is always increasing (numerically decreasing) while
trying to take a lock. In a future it might be found safe to decrease
boosting_prio before finally leaving the lock operation.

  include/linux/rtmutex.h                               |    1
  include/linux/sched.h                                 |    7
  kernel/fork.c                                         |    1
  kernel/rtmutex.c                                      |  151 +++++++++++++-----
  kernel/rtmutex_common.h                               |    1
 include/linux/rtmutex.h                               |    1 
 include/linux/sched.h                                 |    7 
 kernel/fork.c                                         |    1 
 kernel/rtmutex.c                                      |  149 +++++++++++++-----
 kernel/rtmutex_common.h                               |    1 
 kernel/sched.c                                        |   14 +
 scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |   42 +++--
 scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |   12 -
 8 files changed, 166 insertions(+), 61 deletions(-)

Index: linux-rt.q/include/linux/rtmutex.h
===================================================================
--- linux-rt.q.orig/include/linux/rtmutex.h
+++ linux-rt.q/include/linux/rtmutex.h
@@ -116,6 +116,7 @@ extern void rt_mutex_unlock(struct rt_mu
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
 	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
+	.boosting_prio	= MAX_PRIO					\
 	INIT_RT_MUTEX_DEBUG(tsk)
 #else
 # define INIT_RT_MUTEXES(tsk)
Index: linux-rt.q/include/linux/sched.h
===================================================================
--- linux-rt.q.orig/include/linux/sched.h
+++ linux-rt.q/include/linux/sched.h
@@ -995,6 +995,13 @@ struct task_struct {
 	struct plist_head pi_waiters;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
+
+	/*
+	 * Priority to which this task is boosting something. Don't lower the
+	 * priority below this before the boosting is resolved;
+	 */
+	int boosting_prio;
+
 # ifdef CONFIG_DEBUG_RT_MUTEXES
 	raw_spinlock_t held_list_lock;
 	struct list_head held_list_head;
Index: linux-rt.q/kernel/fork.c
===================================================================
--- linux-rt.q.orig/kernel/fork.c
+++ linux-rt.q/kernel/fork.c
@@ -934,6 +934,7 @@ static inline void rt_mutex_init_task(st
 	spin_lock_init(&p->pi_lock);
 	plist_head_init(&p->pi_waiters, &p->pi_lock);
 	p->pi_blocked_on = NULL;
+	p->boosting_prio = MAX_PRIO;
 # ifdef CONFIG_DEBUG_RT_MUTEXES
 	spin_lock_init(&p->held_list_lock);
 	INIT_LIST_HEAD(&p->held_list_head);
Index: linux-rt.q/kernel/rtmutex.c
===================================================================
--- linux-rt.q.orig/kernel/rtmutex.c
+++ linux-rt.q/kernel/rtmutex.c
@@ -121,7 +121,7 @@ static inline void init_lists(struct rt_
  * Return task->normal_prio when the waiter list is empty or when
  * the waiter is not allowed to do priority boosting
  */
-int rt_mutex_getprio(struct task_struct *task)
+static int rt_mutex_getprio_real(struct task_struct *task)
 {
 	if (likely(!task_has_pi_waiters(task)))
 		return task->normal_prio;
@@ -130,6 +130,11 @@ int rt_mutex_getprio(struct task_struct 
 		   task->normal_prio);
 }
 
+int rt_mutex_getprio(struct task_struct *task)
+{
+	return min(rt_mutex_getprio_real(task), task->boosting_prio);
+}
+
 /*
  * Adjust the priority of a task, after its pi_waiters got modified.
  *
@@ -144,6 +149,20 @@ static void __rt_mutex_adjust_prio(struc
 }
 
 /*
+ * Adjust the priority of a task, after its pi_waiters got modified.
+ *
+ * This can be both boosting and unboosting.
+ */
+static void rt_mutex_adjust_prio(struct task_struct *task)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->pi_lock, flags);
+	__rt_mutex_adjust_prio(task);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
+}
+
+/*
  * Adjust task priority (undo boosting). Called from the exit path of
  * rt_mutex_slowunlock() and rt_mutex_slowlock().
  *
@@ -152,11 +171,14 @@ static void __rt_mutex_adjust_prio(struc
  * of task. We do not use the spin_xx_mutex() variants here as we are
  * outside of the debug path.)
  */
-static void rt_mutex_adjust_prio(struct task_struct *task)
+static void rt_mutex_adjust_prio_final(struct task_struct *task,
+				       int old_sched_lifo)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&task->pi_lock, flags);
+	task->boosting_prio = MAX_PRIO;
+	leave_sched_lifo_other(task, old_sched_lifo);
 	__rt_mutex_adjust_prio(task);
 	spin_unlock_irqrestore(&task->pi_lock, flags);
 }
@@ -232,7 +254,8 @@ static int rt_mutex_adjust_prio_chain(ta
 	 * When deadlock detection is off then we check, if further
 	 * priority adjustment is necessary.
 	 */
-	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
+	if (!detect_deadlock &&
+	    waiter->list_entry.prio == rt_mutex_getprio_real(task))
 		goto out_unlock_pi;
 
 	lock = waiter->lock;
@@ -254,7 +277,9 @@ static int rt_mutex_adjust_prio_chain(ta
 
 	/* Requeue the waiter */
 	plist_del(&waiter->list_entry, &lock->wait_list);
-	waiter->list_entry.prio = task->prio;
+	waiter->list_entry.prio = rt_mutex_getprio_real(task);
+	task->boosting_prio = min(task->boosting_prio,
+				  waiter->list_entry.prio);
 	plist_add(&waiter->list_entry, &lock->wait_list);
 
 	/* Release the task */
@@ -300,6 +325,18 @@ static int rt_mutex_adjust_prio_chain(ta
 }
 
 /*
+ * Calls the rt_mutex_adjust_prio_chain() above
+ * whith unlocking and locking lock->wait_lock.
+ */
+static void rt_mutex_adjust_prio_chain_unlock(struct rt_mutex *lock)
+{
+	spin_unlock(&lock->wait_lock);
+	get_task_struct(current);
+	rt_mutex_adjust_prio_chain(current, 0, NULL, NULL __IP__);
+	spin_lock(&lock->wait_lock);
+}
+
+/*
  * Optimization: check if we can steal the lock from the
  * assigned pending owner [which might not have taken the
  * lock yet]:
@@ -309,6 +346,7 @@ static inline int try_to_steal_lock(stru
 	struct task_struct *pendowner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *next;
 	unsigned long flags;
+	int current_prio;
 
 	if (!rt_mutex_owner_pending(lock))
 		return 0;
@@ -316,8 +354,12 @@ static inline int try_to_steal_lock(stru
 	if (pendowner == current)
 		return 1;
 
+	spin_lock_irqsave(&current->pi_lock, flags);
+	current_prio = rt_mutex_getprio_real(current);
+	spin_unlock_irqrestore(&current->pi_lock, flags);
+
 	spin_lock_irqsave(&pendowner->pi_lock, flags);
-	if (current->prio >= pendowner->prio) {
+	if (current_prio >= rt_mutex_getprio_real(pendowner)) {
 		spin_unlock_irqrestore(&pendowner->pi_lock, flags);
 		return 0;
 	}
@@ -426,8 +468,8 @@ static int task_blocks_on_rt_mutex(struc
 	__rt_mutex_adjust_prio(current);
 	waiter->task = current;
 	waiter->lock = lock;
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
+	plist_node_init(&waiter->list_entry, rt_mutex_getprio_real(current));
+	plist_node_init(&waiter->pi_list_entry, waiter->list_entry.prio);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -435,7 +477,9 @@ static int task_blocks_on_rt_mutex(struc
 	plist_add(&waiter->list_entry, &lock->wait_list);
 
 	current->pi_blocked_on = waiter;
-
+	current->boosting_prio = min(current->boosting_prio,
+				     waiter->list_entry.prio);
+	enter_sched_lifo();
 	spin_unlock_irqrestore(&current->pi_lock, flags);
 
 	if (waiter == rt_mutex_top_waiter(lock)) {
@@ -499,7 +543,6 @@ static void wakeup_next_waiter(struct rt
 	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
 	pendowner = waiter->task;
 	waiter->task = NULL;
-
 	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);
 
 	spin_unlock_irqrestore(&current->pi_lock, flags);
@@ -518,6 +561,8 @@ static void wakeup_next_waiter(struct rt
 	WARN_ON(pendowner->pi_blocked_on->lock != lock);
 
 	pendowner->pi_blocked_on = NULL;
+	pendowner->boosting_prio = MAX_PRIO;
+	leave_sched_lifo_other(pendowner, waiter->old_sched_lifo);
 
 	if (rt_mutex_has_waiters(lock)) {
 		struct rt_mutex_waiter *next;
@@ -525,6 +570,7 @@ static void wakeup_next_waiter(struct rt
 		next = rt_mutex_top_waiter(lock);
 		plist_add(&next->pi_list_entry, &pendowner->pi_waiters);
 	}
+	__rt_mutex_adjust_prio(pendowner);
 	spin_unlock_irqrestore(&pendowner->pi_lock, flags);
 
 	if (savestate)
@@ -539,7 +585,8 @@ static void wakeup_next_waiter(struct rt
  * Must be called with lock->wait_lock held
  */
 static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter  __IP_DECL__)
+			  struct rt_mutex_waiter *waiter
+			  __IP_DECL__)
 {
 	int first = (waiter == rt_mutex_top_waiter(lock));
 	int boost = 0;
@@ -621,7 +668,8 @@ static void fastcall noinline __sched
 rt_lock_slowlock(struct rt_mutex *lock __IP_DECL__)
 {
 	struct rt_mutex_waiter waiter;
-	unsigned long saved_state, state;      ;
+	unsigned long saved_state, state;
+	int adjust_prio_final = 0;
 
 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
@@ -648,6 +696,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
 	 * then we return with the saved state.
 	 */
 	saved_state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
+	waiter.old_sched_lifo = get_sched_lifo();
 
 	for (;;) {
 		unsigned long saved_flags;
@@ -661,12 +710,17 @@ rt_lock_slowlock(struct rt_mutex *lock _
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by an higher prio task.
 		 */
-		if (!waiter.task) {
+		if (!waiter.task)
 			task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
 			/* Wakeup during boost ? */
-			if (unlikely(!waiter.task))
+		else
+			rt_mutex_adjust_prio_chain_unlock(lock);
+
+		/*
+		 * We got it while lock->wait_lock was unlocked ?
+		 */
+		if (unlikely(!waiter.task))
 				continue;
-		}
 
 		/*
 		 * Prevent schedule() to drop BKL, while waiting for
@@ -699,8 +753,10 @@ rt_lock_slowlock(struct rt_mutex *lock _
 	 * highest-prio waiter (due to SCHED_OTHER changing prio), then we
 	 * can end up with a non-NULL waiter.task:
 	 */
-	if (unlikely(waiter.task))
+	if (unlikely(waiter.task)) {
 		remove_waiter(lock, &waiter __IP__);
+		adjust_prio_final = 1;
+	}
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit
 	 * unconditionally. We might have to fix that up:
@@ -709,7 +765,12 @@ rt_lock_slowlock(struct rt_mutex *lock _
 
 	spin_unlock(&lock->wait_lock);
 
+	if (adjust_prio_final)
+		rt_mutex_adjust_prio_final(current, waiter.old_sched_lifo);
+
 	debug_rt_mutex_free_waiter(&waiter);
+	BUG_ON(current->boosting_prio != MAX_PRIO);
+	BUG_ON(waiter.old_sched_lifo != get_sched_lifo());
 }
 
 /*
@@ -719,21 +780,16 @@ static void fastcall noinline __sched
 rt_lock_slowunlock(struct rt_mutex *lock)
 {
 	spin_lock(&lock->wait_lock);
-
 	debug_rt_mutex_unlock(lock);
-
 	rt_mutex_deadlock_account_unlock(current);
-
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		spin_unlock(&lock->wait_lock);
 		return;
 	}
-
 	wakeup_next_waiter(lock, 1);
-
 	spin_unlock(&lock->wait_lock);
-
+	BUG_ON(current->boosting_prio != MAX_PRIO);
 	/* Undo pi boosting.when necessary */
 	rt_mutex_adjust_prio(current);
 }
@@ -795,6 +851,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 {
 	int ret = 0, saved_lock_depth = -1;
 	struct rt_mutex_waiter waiter;
+	int adjust_prio_final = 0;
 
 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
@@ -817,6 +874,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		saved_lock_depth = rt_release_bkl(lock);
 
 	set_current_state(state);
+	waiter.old_sched_lifo = get_sched_lifo();
 
 	/* Setup the timer, when timeout != NULL */
 	if (unlikely(timeout))
@@ -848,21 +906,28 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		 * waiter.task is NULL the first time we come here and
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by a higher prio task.
+		 *
+		 * If we get another kind of wakeup but can't get the lock
+		 * we should try to adjust the priorities
 		 */
-		if (!waiter.task) {
+		if (!waiter.task)
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
-			/*
-			 * If we got woken up by the owner then start loop
-			 * all over without going into schedule to try
-			 * to get the lock now:
-			 */
-			if (unlikely(!waiter.task))
-				continue;
+		else
+			rt_mutex_adjust_prio_chain_unlock(lock);
+
+
+		/*
+		 * If we got woken up by the owner then start loop
+		 * all over without going into schedule to try
+		 * to get the lock now:
+		 */
+		if (unlikely(!waiter.task))
+			continue;
+
+		if (unlikely(ret))
+			break;
 
-			if (unlikely(ret))
-				break;
-		}
 		saved_flags = current->flags & PF_NOSCHED;
 		current->flags &= ~PF_NOSCHED;
 
@@ -881,8 +946,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 
 	set_current_state(TASK_RUNNING);
 
-	if (unlikely(waiter.task))
+	if (unlikely(waiter.task)) {
 		remove_waiter(lock, &waiter __IP__);
+		adjust_prio_final = 1;
+	}
+	else if (unlikely(ret))
+		adjust_prio_final = 1;
+
 
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit
@@ -892,17 +962,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 
 	spin_unlock(&lock->wait_lock);
 
+	if (adjust_prio_final)
+		rt_mutex_adjust_prio_final(current, waiter.old_sched_lifo);
+
 	/* Remove pending timer: */
 	if (unlikely(timeout))
 		hrtimer_cancel(&timeout->timer);
 
-	/*
-	 * Readjust priority, when we did not get the lock. We might
-	 * have been the pending owner and boosted. Since we did not
-	 * take the lock, the PI boost has to go.
-	 */
-	if (unlikely(ret))
-		rt_mutex_adjust_prio(current);
 
 	/* Must we reaquire the BKL? */
 	if (unlikely(saved_lock_depth >= 0))
@@ -910,6 +976,8 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 
 	debug_rt_mutex_free_waiter(&waiter);
 
+	BUG_ON(current->boosting_prio != MAX_PRIO);
+
 	return ret;
 }
 
@@ -962,6 +1030,7 @@ rt_mutex_slowunlock(struct rt_mutex *loc
 	spin_unlock(&lock->wait_lock);
 
 	/* Undo pi boosting if necessary: */
+	BUG_ON(current->boosting_prio != MAX_PRIO);
 	rt_mutex_adjust_prio(current);
 }
 
Index: linux-rt.q/kernel/rtmutex_common.h
===================================================================
--- linux-rt.q.orig/kernel/rtmutex_common.h
+++ linux-rt.q/kernel/rtmutex_common.h
@@ -49,6 +49,7 @@ struct rt_mutex_waiter {
 	struct plist_node	pi_list_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
+	int			old_sched_lifo;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 	unsigned long		ip;
 	pid_t			deadlock_task_pid;
Index: linux-rt.q/kernel/sched.c
===================================================================
--- linux-rt.q.orig/kernel/sched.c
+++ linux-rt.q/kernel/sched.c
@@ -657,7 +657,9 @@ int task_preempts(struct task_struct *p,
 	return p->sched_lifo;
 }
 
+#ifdef CONFIG_SMP
 static __cacheline_aligned_in_smp atomic_t rt_overload;
+#endif
 
 static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
 {
@@ -1492,10 +1494,11 @@ static inline int wake_idle(int cpu, tas
 static int try_to_wake_up(task_t *p, unsigned int state, int sync, int mutex)
 {
 	int cpu, this_cpu, success = 0;
-	runqueue_t *this_rq, *rq;
+	runqueue_t *rq;
 	unsigned long flags;
 	long old_state;
 #ifdef CONFIG_SMP
+	runqueue_t *this_rq;
 	unsigned long load, this_load;
 	struct sched_domain *sd, *this_sd = NULL;
 	int new_cpu;
@@ -4370,6 +4373,14 @@ int setscheduler(struct task_struct *p, 
 			resched_task(rq->curr);
 	}
 	task_rq_unlock(rq, &flags);
+
+	/*
+	 * If the process is blocked on rt-mutex, it will now wake up and
+	 * reinsert itself into the wait list and boost the owner correctly
+	 */
+	if (p->pi_blocked_on)
+		wake_up_process_mutex(p);
+
 	spin_unlock_irqrestore(&p->pi_lock, fp);
 	return 0;
 }
@@ -7105,4 +7116,3 @@ void notrace preempt_enable_no_resched(v
 
 EXPORT_SYMBOL(preempt_enable_no_resched);
 #endif
-
Index: linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
+++ linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
@@ -107,10 +107,10 @@ T: prioeq:		3:	84
 # Reduce prio of T4
 C: schedfifo:		4: 	80
 T: prioeq:		0: 	83
-T: prioeq:		1:	83
-T: prioeq:		2:	83
-T: prioeq:		3:	83
-T: prioeq:		4:	80
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+T: prioeq:		4:	84
 
 # Increase prio of T4
 C: schedfifo:		4: 	84
@@ -139,36 +139,46 @@ T: prioeq:		4:	84
 # Reduce prio of T3
 C: schedfifo:		3: 	83
 T: prioeq:		0: 	84
-T: prioeq:		1:	84
-T: prioeq:		2:	84
-T: prioeq:		3:	84
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	85
 T: prioeq:		4:	84
 
 # Signal T4
 C: signal:		4: 	0
 W: unlocked:		4: 	3
 T: prioeq:		0: 	83
-T: prioeq:		1:	83
-T: prioeq:		2:	83
-T: prioeq:		3:	83
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	85
+T: prioeq:		4:	84
 
 # Signal T3
 C: signal:		3: 	0
 W: unlocked:		3: 	2
 T: prioeq:		0: 	82
-T: prioeq:		1:	82
-T: prioeq:		2:	82
+T: prioeq:		1:	85
+T: prioeq:		2:	85
+T: prioeq:		3:	83
+T: prioeq:		4:	84
 
 # Signal T2
 C: signal:		2: 	0
 W: unlocked:		2: 	1
 T: prioeq:		0: 	81
-T: prioeq:		1:	81
+T: prioeq:		1:	85
+T: prioeq:		2:	82
+T: prioeq:		3:	83
+T: prioeq:		4:	84
 
 # Signal T1
 C: signal:		1: 	0
 W: unlocked:		1: 	0
 T: priolt:		0: 	1
+T: prioeq:		1:	81
+T: prioeq:		2:	82
+T: prioeq:		3:	83
+T: prioeq:		4:	84
 
 # Unlock and exit
 C: unlock:		3:	3
@@ -180,3 +190,9 @@ W: unlocked:		3:	3
 W: unlocked:		2:	2
 W: unlocked:		1:	1
 W: unlocked:		0:	0
+
+# Reset the -4 opcode from the signal
+C: reset:		1:	0
+C: reset:		2:	0
+C: reset:		3:	0
+C: reset:		4:	0
\ No newline at end of file
Index: linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-rt.q.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
+++ linux-rt.q/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
@@ -113,22 +113,22 @@ T: prioeq:		3:	84
 C: signal:		4: 	0
 W: unlocked:		4: 	3
 T: prioeq:		0: 	83
-T: prioeq:		1:	83
-T: prioeq:		2:	83
-T: prioeq:		3:	83
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
 
 # Signal T3
 C: signal:		3: 	0
 W: unlocked:		3: 	2
 T: prioeq:		0: 	82
-T: prioeq:		1:	82
-T: prioeq:		2:	82
+T: prioeq:		1:	84
+T: prioeq:		2:	84
 
 # Signal T2
 C: signal:		2: 	0
 W: unlocked:		2: 	1
 T: prioeq:		0: 	81
-T: prioeq:		1:	81
+T: prioeq:		1:	84
 
 # Signal T1
 C: signal:		1: 	0

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt-timeout-prio-bug-fixes.patch"

---
 include/linux/rtmutex.h |    2 +-
 kernel/rtmutex.c        |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-rt.q/include/linux/rtmutex.h
===================================================================
--- linux-rt.q.orig/include/linux/rtmutex.h
+++ linux-rt.q/include/linux/rtmutex.h
@@ -116,7 +116,7 @@ extern void rt_mutex_unlock(struct rt_mu
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
 	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
-	.boosting_prio	= MAX_PRIO					\
+	.boosting_prio	= MAX_PRIO,					\
 	INIT_RT_MUTEX_DEBUG(tsk)
 #else
 # define INIT_RT_MUTEXES(tsk)
Index: linux-rt.q/kernel/rtmutex.c
===================================================================
--- linux-rt.q.orig/kernel/rtmutex.c
+++ linux-rt.q/kernel/rtmutex.c
@@ -328,7 +328,7 @@ static int rt_mutex_adjust_prio_chain(ta
  * Calls the rt_mutex_adjust_prio_chain() above
  * whith unlocking and locking lock->wait_lock.
  */
-static void rt_mutex_adjust_prio_chain_unlock(struct rt_mutex *lock)
+static void rt_mutex_adjust_prio_chain_unlock(struct rt_mutex *lock __IP_DECL__)
 {
 	spin_unlock(&lock->wait_lock);
 	get_task_struct(current);
@@ -714,7 +714,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
 			task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
 			/* Wakeup during boost ? */
 		else
-			rt_mutex_adjust_prio_chain_unlock(lock);
+			rt_mutex_adjust_prio_chain_unlock(lock __IP__);
 
 		/*
 		 * We got it while lock->wait_lock was unlocked ?
@@ -914,7 +914,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
 		else
-			rt_mutex_adjust_prio_chain_unlock(lock);
+			rt_mutex_adjust_prio_chain_unlock(lock __IP__);
 
 
 		/*

--qDbXVdCdHGoSgWSk--
