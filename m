Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135813AbRDZXyv>; Thu, 26 Apr 2001 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135890AbRDZXyl>; Thu, 26 Apr 2001 19:54:41 -0400
Received: from nrg.org ([216.101.165.106]:4876 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S135813AbRDZXyd>;
	Thu, 26 Apr 2001 19:54:33 -0400
Date: Thu, 26 Apr 2001 16:54:32 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: linux-kernel@vger.kernel.org
Subject: Viewing SCHED_FIFO, SCHED_RR stats in /proc
Message-ID: <Pine.LNX.4.05.10104261628120.1213-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just noticed that the priority and nice values listed in
/proc/<pid>/stat aren't very useful for SCHED_FIFO or SCHED_RR tasks.
I'd like to be able to distinguish tasks with these policies from
SCHED_OTHER tasks, and to view task->rt_priority.

Am I correct that this information is not currently available through
/proc?

Here is one way to expose this information that should be compatible
with existing tools like top and ps.  For SCHED_OTHER, the values are
unchanged.  For SCHED_RR and SCHED_FIFO, the priority value displayed is
(20 + task->rt_priority), which distinguishes them for SCHED_OTHER
priorities which can't be greater than 20.  And SCHED_FIFO tasks, whose
nice value is ignored by the scheduler, are distinguished from SCHED_RR
tasks by begin displayed with a nice value of -99.

diff -u -r1.2 array.c
--- linux/fs/proc/array.c	2001/04/16 23:26:41	1.2
+++ linux/fs/proc/array.c	2001/04/26 22:37:56
@@ -336,11 +336,18 @@
 
 	collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
-	/* scale priority and nice values from timeslices to -20..20 */
-	/* to make it look like a "normal" Unix priority/nice value  */
-	priority = task->counter;
-	priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
-	nice = task->nice;
+	if (task->policy == SCHED_OTHER) {
+		/* scale priority and nice values from timeslices to -20..20 */
+		/* to make it look like a "normal" Unix priority/nice value  */
+		priority = task->counter;
+		priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
+	} else {
+		priority = 20 + task->rt_priority;
+	}
+	if (task->policy == SCHED_FIFO)
+		nice = -99;
+	else
+		nice = task->nice;
 
 	read_lock(&tasklist_lock);
 	ppid = task->p_opptr->pid;

Can anyone think of a better way of doing this?

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

