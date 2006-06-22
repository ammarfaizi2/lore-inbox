Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWFVJKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWFVJKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWFVJKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:10:21 -0400
Received: from www.osadl.org ([213.239.205.134]:65245 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161012AbWFVJJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:09:57 -0400
Message-Id: <20060622082812.721695000@cruncher.tec.linutronix.de>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
Date: Thu, 22 Jun 2006 09:08:40 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 3/3] rtmutex: Modify rtmutex-tester to test the setscheduler
	propagation
Content-Disposition: inline;
	filename=rt-mutex-fix-tester-for-setsched-tests.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make test suite setscheduler calls asynchronously. Remove the waits in the test
cases and add a new testcase to verify the correctness of the setscheduler
priority propagation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/rtmutex-tester.c                               |   32 +--
 scripts/rt-tester/check-all.sh                        |    1 
 scripts/rt-tester/t2-l1-2rt-sameprio.tst              |    2 
 scripts/rt-tester/t2-l1-pi.tst                        |    2 
 scripts/rt-tester/t2-l1-signal.tst                    |    2 
 scripts/rt-tester/t2-l2-2rt-deadlock.tst              |    2 
 scripts/rt-tester/t3-l1-pi-1rt.tst                    |    3 
 scripts/rt-tester/t3-l1-pi-2rt.tst                    |    3 
 scripts/rt-tester/t3-l1-pi-3rt.tst                    |    3 
 scripts/rt-tester/t3-l1-pi-signal.tst                 |    3 
 scripts/rt-tester/t3-l1-pi-steal.tst                  |    3 
 scripts/rt-tester/t3-l2-pi.tst                        |    3 
 scripts/rt-tester/t4-l2-pi-deboost.tst                |    4 
 scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |  183 ++++++++++++++++++
 scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |    5 
 15 files changed, 202 insertions(+), 49 deletions(-)

Index: linux-2.6.17-mm/scripts/rt-tester/check-all.sh
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/check-all.sh	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/check-all.sh	2006-06-22 10:26:11.000000000 +0200
@@ -18,4 +18,5 @@
 testit t3-l2-pi.tst
 testit t4-l2-pi-deboost.tst
 testit t5-l4-pi-boost-deboost.tst
+testit t5-l4-pi-boost-deboost-setsched.tst
 
Index: linux-2.6.17-mm/kernel/rtmutex-tester.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/rtmutex-tester.c	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/kernel/rtmutex-tester.c	2006-06-22 10:26:11.000000000 +0200
@@ -46,7 +46,7 @@
 	RTTEST_LOCKINTNOWAIT,	/* 6 Lock interruptible no wait in wakeup, data = lockindex */
 	RTTEST_LOCKCONT,	/* 7 Continue locking after the wakeup delay */
 	RTTEST_UNLOCK,		/* 8 Unlock, data = lockindex */
-	RTTEST_LOCKBKL, 	/* 9 Lock BKL */
+	RTTEST_LOCKBKL,		/* 9 Lock BKL */
 	RTTEST_UNLOCKBKL,	/* 10 Unlock BKL */
 	RTTEST_SIGNAL,		/* 11 Signal other test thread, data = thread id */
 	RTTEST_RESETEVENT = 98,	/* 98 Reset event counter */
@@ -55,7 +55,6 @@
 
 static int handle_op(struct test_thread_data *td, int lockwakeup)
 {
-	struct sched_param schedpar;
 	int i, id, ret = -EINVAL;
 
 	switch(td->opcode) {
@@ -63,17 +62,6 @@
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
@@ -310,9 +298,10 @@
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
@@ -334,6 +323,21 @@
 		return -EINVAL;
 
 	switch (op) {
+	case RTTEST_SCHEDOT:
+		schedpar.sched_priority = 0;
+		ret = sched_setscheduler(threads[tid], SCHED_NORMAL, &schedpar);
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
Index: linux-2.6.17-mm/scripts/rt-tester/t2-l1-2rt-sameprio.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t2-l1-2rt-sameprio.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t2-l1-2rt-sameprio.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,9 +57,7 @@
 
 # Set schedulers
 C: schedfifo:		0: 	80
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	80
-W: opcodeeq:		1: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t2-l1-pi.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t2-l1-pi.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t2-l1-pi.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,9 +57,7 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	80
-W: opcodeeq:		1: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t2-l1-signal.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t2-l1-signal.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t2-l1-signal.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,9 +57,7 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedother:		1: 	0
-W: opcodeeq:		1: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t2-l2-2rt-deadlock.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t2-l2-2rt-deadlock.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t2-l2-2rt-deadlock.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,9 +57,7 @@
 
 # Set schedulers
 C: schedfifo:		0: 	80
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	80
-W: opcodeeq:		1: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-1rt.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t3-l1-pi-1rt.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-1rt.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,11 +57,8 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedother:		1: 	0
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	82
-W: opcodeeq:		2: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-2rt.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t3-l1-pi-2rt.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-2rt.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,11 +57,8 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	81
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	82
-W: opcodeeq:		2: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-3rt.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t3-l1-pi-3rt.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-3rt.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,11 +57,8 @@
 
 # Set schedulers
 C: schedfifo:		0: 	80
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	81
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	82
-W: opcodeeq:		2: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-signal.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t3-l1-pi-signal.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-signal.tst	2006-06-22 10:26:11.000000000 +0200
@@ -55,11 +55,8 @@
 
 # Set priorities
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	80
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	81
-W: opcodeeq:		2: 	0
 
 # T0 lock L0
 C: lock:		0:	0
Index: linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-steal.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t3-l1-pi-steal.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t3-l1-pi-steal.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,11 +57,8 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	80
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	81
-W: opcodeeq:		2: 	0
 
 # T0 lock L0
 C: lock:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t3-l2-pi.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t3-l2-pi.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t3-l2-pi.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,11 +57,8 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedother:		1: 	0
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	82
-W: opcodeeq:		2: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t4-l2-pi-deboost.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t4-l2-pi-deboost.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t4-l2-pi-deboost.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,13 +57,9 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedother:		1: 	0
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	82
-W: opcodeeq:		2: 	0
 C: schedfifo:		3: 	83
-W: opcodeeq:		3: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0
Index: linux-2.6.17-mm/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-mm/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst	2006-06-22 10:26:11.000000000 +0200
@@ -0,0 +1,183 @@
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
+
Index: linux-2.6.17-mm/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-2.6.17-mm.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst	2006-06-22 10:26:10.000000000 +0200
+++ linux-2.6.17-mm/scripts/rt-tester/t5-l4-pi-boost-deboost.tst	2006-06-22 10:26:11.000000000 +0200
@@ -57,15 +57,10 @@
 
 # Set schedulers
 C: schedother:		0: 	0
-W: opcodeeq:		0: 	0
 C: schedfifo:		1: 	81
-W: opcodeeq:		1: 	0
 C: schedfifo:		2: 	82
-W: opcodeeq:		2: 	0
 C: schedfifo:		3: 	83
-W: opcodeeq:		3: 	0
 C: schedfifo:		4: 	84
-W: opcodeeq:		4: 	0
 
 # T0 lock L0
 C: locknowait:		0: 	0

--

