Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290893AbSASBB7>; Fri, 18 Jan 2002 20:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290894AbSASBBk>; Fri, 18 Jan 2002 20:01:40 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:62968 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S290893AbSASBBe>; Fri, 18 Jan 2002 20:01:34 -0500
Message-ID: <3C48C557.E793D9AC@austin.ibm.com>
Date: Fri, 18 Jan 2002 19:01:11 -0600
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mingo@elte.hu, lse-tech@lists.sourceforge.net
Subject: [PATCH] 2.4.18-pre4 sys_sched_yield and goodness optimization
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo's sched cleanup code in 2.4.15 added move_last_runqueue() to
sys_sched_yield().  This change should improve performance of user
code that uses yield to implement user level locking.  Should help
fairness too.

This patch moves the move_last_runqueue() from sys_sched_yield() to
schedule() and removes the SCHED_YIELD specific code from goodness().
Overall, it is a reduction of code path + the removal of the runqueue
lock in sys_sched_yield().

There are about 40 or 50 places in the kernel where SCHED_YIELD is used.
Those yields will also be moved to the end of the run queue with this
patch.

The patch was tested on lmbench and VolanoMark.
VolanoMark does a lot of yields and showed a 34 % improvement on an 8-way.
The test results and patch are below.

Bill Hartner
IBM Linux Technology Center

-----

We tested using the LMBench latency tests and VolanoMark on an
8-way 700 Mhz PIII, 1 GB mem.

LMBench results (best of 3 runs) :

2.4.18-pre4 (UP)
 
   ./lat_proc fork
   Process fork+exit: 118.7021 microseconds
   ./lat_proc exec
   Process fork+execve: 836.7143 microseconds
   ./lat_proc shell
   Process fork+/bin/sh -c: 3481.5000 microseconds
 
2.4.18-pre4 + patch (UP)
 
   ./lat_proc fork
   Process fork+exit: 118.5957 microseconds
   ./lat_proc exec
   Process fork+execve: 838.0000 microseconds
   ./lat_proc shell
   Process fork+/bin/sh -c: 3464.5000 microseconds

2.4.18-pre4 (2P)
 
   ./lat_proc fork
   Process fork+exit: 480.0833 microseconds
   ./lat_proc exec
   Process fork+execve: 1342.6000 microseconds
   ./lat_proc shell
   Process fork+/bin/sh -c: 4778.5000 microseconds
 
2.4.18-pre4 + patch (2P)
 
   ./lat_proc fork
   Process fork+exit: 474.9090 microseconds
   ./lat_proc exec
   Process fork+execve: 1327.8000 microseconds
   ./lat_proc shell
   Process fork+/bin/sh -c: 4680.5000 microseconds

-----

VolanoMark 10/100 loopback test results :

8-way 700 Mhz PIII, 1 GB mem
IBM JVM 1.3 (20010621), 64 MB initial heap size

			UP	4P	8P
2.4.18-pre4		11022	16022	11535 msg/sec
2.4.18-pre4 + patch	11252	15222	15550 msg/sec
---------------------------------------------
			+2.1%	-5.0%	+34.8%

The patch is on 2.4.18-pre4.

--- linux2417/kernel/sched.c.orig       Fri Jan 18 13:13:08 2002
+++ linux2417/kernel/sched.c    Fri Jan 18 13:14:27 2002
@@ -146,15 +146,6 @@
        int weight;
 
        /*
-        * select the current process after every other
-        * runnable process, but before the idle thread.
-        * Also, dont trigger a counter recalculation.
-        */
-       weight = -1;
-       if (p->policy & SCHED_YIELD)
-               goto out;
-
-       /*
         * Non-RT process - normal case first.
         */
        if (p->policy == SCHED_OTHER) {
@@ -603,8 +594,15 @@
        /*
         * Default process to select..
         */
-       next = idle_task(this_cpu);
-       c = -1000;
+
+       if (unlikely(prev->policy & SCHED_YIELD)) {
+               next = prev;
+               c = -1;
+               move_last_runqueue(prev);
+       } else {
+               next = idle_task(this_cpu);
+               c = -1000;
+       }
        list_for_each(tmp, &runqueue_head) {
                p = list_entry(tmp, struct task_struct, run_list);
                if (can_schedule(p, this_cpu)) {
@@ -1064,9 +1062,6 @@
                        current->policy |= SCHED_YIELD;
                current->need_resched = 1;
 
-               spin_lock_irq(&runqueue_lock);
-               move_last_runqueue(current);
-               spin_unlock_irq(&runqueue_lock);
        }
        return 0;
 }
