Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278339AbRJMSIG>; Sat, 13 Oct 2001 14:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278341AbRJMSH5>; Sat, 13 Oct 2001 14:07:57 -0400
Received: from h00010256f583.ne.mediaone.net ([66.31.45.67]:734 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S278339AbRJMSHp>; Sat, 13 Oct 2001 14:07:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Lev Makhlis <mlev@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: Bug or feature? Priority in /proc/<pid>/stat for RT processes
Date: Sat, 13 Oct 2001 14:09:12 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101314091204.09135@portent.dyndns.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that when the scheduling policy of a process is SCHED_FIFO
or SCHED_RR, proc_pid_stat() in fs/proc/array.c still uses the counter field
in the task structure to calculate the priority in /proc/<pid>/stat.
For such processes, the counter field is ignored by the scheduler in favour
of the rt_priority field.  Thus, even though the actual priority is available
via sched_getparam(2), the priority in /proc/<pid>/stat -- and, consequently,
in the output of ps(1) and top(1) -- seems to be, for SCHED_FIFO/SCHED_RR
processes, a value that is not representative at all of how the process is
scheduled.

I have thrown together a patch to address this, but I can't say I feel
entirely comfortable about scaling from 1..99 to -20..20.

Any comments would be appreciated.

Lev Makhlis

-------------------------------CUT HERE---------------------------------
--- linux-2.4.12/fs/proc/array.c	Sat Oct 13 13:09:29 2001
+++ linux/fs/proc/array.c	Sat Oct 13 13:21:05 2001
@@ -334,8 +334,13 @@
 
 	/* scale priority and nice values from timeslices to -20..20 */
 	/* to make it look like a "normal" Unix priority/nice value  */
-	priority = task->counter;
-	priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
+	if ((task->policy & ~SCHED_YIELD) == SCHED_OTHER) {
+		priority = task->counter;
+		priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
+	} else {
+		priority = task->rt_priority;
+		priority = 20 - (priority * 40 + 50) / 100;
+	}
 	nice = task->nice;
 
 	read_lock(&tasklist_lock);
