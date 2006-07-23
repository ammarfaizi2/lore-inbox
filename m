Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWGWASI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWGWASI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWGWASI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:18:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7399 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750778AbWGWASC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:18:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:subject:message-id:references:mime-version:content-type;
        b=mf0m1lUjjNoMB6Gc56MbQz+Qk6ZBIqzvsMAGAVDPTyMRtjaDR7fYfmdNDf2ImYxvDUyIpjDZQxIHXEGEjvc3bN/TF61T+pTRyBzS+I3iAAajsDTFnf/YbDx7jfUFKTsjRYfNjiEYWG2cy0eZgJAdOv1snOoE/GvHVah/H71eOrg=
Date: Sun, 23 Jul 2006 02:18:27 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [patch 2/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <Pine.LNX.4.64.0607230217170.11861@localhost.localdomain>
References: <20060723005210.973833000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
  8 files changed, 228 insertions(+), 15 deletions(-)

Index: linux-2.6.17-rt7/kernel/rtmutex-tester.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/rtmutex-tester.c
+++ linux-2.6.17-rt7/kernel/rtmutex-tester.c
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
Index: linux-2.6.17-rt7/scripts/rt-tester/reset-tester.py
===================================================================
--- /dev/null
+++ linux-2.6.17-rt7/scripts/rt-tester/reset-tester.py
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
Index: linux-2.6.17-rt7/scripts/rt-tester/t2-l1-signal.tst
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/t2-l1-signal.tst
+++ linux-2.6.17-rt7/scripts/rt-tester/t2-l1-signal.tst
@@ -77,3 +77,6 @@ T: opcodeeq:		1:	-4
  # Unlock and exit
  C: unlock:		0: 	0
  W: unlocked:		0: 	0
+
+# Reset the -4 opcode from the signal
+C: reset:               1:      0
\ No newline at end of file
Index: linux-2.6.17-rt7/scripts/rt-tester/t3-l1-pi-signal.tst
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/t3-l1-pi-signal.tst
+++ linux-2.6.17-rt7/scripts/rt-tester/t3-l1-pi-signal.tst
@@ -98,4 +98,5 @@ C: unlock:		1: 	0
  W: unlocked:		1: 	0


-
+# Reset the -4 opcode from the signal
+C: reset:               2:      0
\ No newline at end of file
Index: linux-2.6.17-rt7/scripts/rt-tester/t4-l2-pi-deboost.tst
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/t4-l2-pi-deboost.tst
+++ linux-2.6.17-rt7/scripts/rt-tester/t4-l2-pi-deboost.tst
@@ -125,3 +125,5 @@ W: unlocked:		2:	1
  C: unlock:		0:	0
  W: unlocked:		0:	0

+# Reset the -4 opcode from the signal
+C: reset:               3:      0
\ No newline at end of file
Index: linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
===================================================================
--- /dev/null
+++ linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst
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
Index: linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
+++ linux-2.6.17-rt7/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
@@ -146,3 +146,5 @@ W: unlocked:		2:	2
  W: unlocked:		1:	1
  W: unlocked:		0:	0

+# Reset the -4 opcode from the signal
+C: reset:               4:      0
\ No newline at end of file
Index: linux-2.6.17-rt7/scripts/rt-tester/check-all.sh
===================================================================
--- linux-2.6.17-rt7.orig/scripts/rt-tester/check-all.sh
+++ linux-2.6.17-rt7/scripts/rt-tester/check-all.sh
@@ -18,4 +18,4 @@ testit t3-l1-pi-steal.tst
  testit t3-l2-pi.tst
  testit t4-l2-pi-deboost.tst
  testit t5-l4-pi-boost-deboost.tst
-
+testit t5-l4-pi-boost-deboost-setsched.tst
\ No newline at end of file

--
