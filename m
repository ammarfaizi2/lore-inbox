Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319453AbSIGH6S>; Sat, 7 Sep 2002 03:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319454AbSIGH6S>; Sat, 7 Sep 2002 03:58:18 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:14584 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S319453AbSIGH6Q>; Sat, 7 Sep 2002 03:58:16 -0400
Date: Sat, 7 Sep 2002 13:46:16 +0530 (IST)
From: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <Pine.LNX.4.33.0209071342400.2331-100000@ccvsbarc.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch tries to fix the max_pid hang problem. The
idea is to make use of find_task_by_pid(), rather than looping
over entire tasklist. We can make use of the fact that, the
maximum number of processes at any time does not exceed max value
of a 30-bit integer (last_pid).

As Manfred pointed out, pid allocation and inserting it into task
list should be atomic. But going by the range of pids available
in 2.5.33 (Linux made it 30-bits), it is unlikely that same pid
will be given to two processes, since last_pid is protected by
single lock. If a process gets a pid of x, all following processes
will get pids > x. So, another process getting pid x again means,
last_pid looped over it's maximum value and comes back to x while
the first process which got pid x is not yet inserted into the
list. This is definitely unlikely.


Given patch works as follows

get_pid starts by incrementing last_pid as usual. But when it
crosses PID_MAX, it sets a variable max_pid_cross to TRUE (1).
If last_pid is within PID_MAX and max_pid_cross is not set, we
are sure that we got a free pid, which is/was not yet allocated
to any process.

If last_pid is within PID_MAX and max_pid_cross is set, this
pid might have been given to another process. So, goto the
corresponding hashlist and check for its existence. If no task
with given pid found, then get_pid is free to return pid as the
available pid. If there is a process last_pid as its pid,
then increment last_pid, continue the looping in the respective
hashlist. get_pid() holds tasklist_lock before calling
find_task_by_pid() and releases it after find_task_by_pid()
returns. This ensures that any exiting processes will get
a chance to acquire the tasklist_lock and remove its entry
from tasklist. Since last_pid is protected by a single lock
we are sure that get_pid() will surely returns a free pid
without hang.

The patch applies to 2.5.33 kernel

Any comments/flames ? If nothing, please consider to apply.


~Hanumanthu
 Wipro Ltd.


diff -Nru linux-2.5.33/kernel/fork.c linux-2.5.33.1/kernel/fork.c

--- linux-2.5.33/kernel/fork.c	Sun Sep  1 03:34:49 2002
+++ linux-2.5.33.1/kernel/fork.c	Sat Sep  7 15:04:49 2002
@@ -76,7 +76,6 @@
 	}
 }

-/* Protects next_safe and last_pid. */
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -151,50 +150,34 @@
 	return tsk;
 }

+/* Protects next_safe and last_pid. */
 spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;

 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
-	struct task_struct *p;
+	static int  max_pid_cross;
 	int pid;

 	if (flags & CLONE_IDLETASK)
 		return 0;

 	spin_lock(&lastpid_lock);
-	if((++last_pid) & ~PID_MASK) {
+
+	if ((++last_pid) & ~PID_MASK) {
+		max_pid_cross = 1;
 		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-	if(last_pid >= next_safe) {
-inside:
-		next_safe = PID_MAX;
-		read_lock(&tasklist_lock);
-	repeat:
-		for_each_task(p) {
-			if(p->pid == last_pid	||
-			   p->pgrp == last_pid	||
-			   p->tgid == last_pid	||
-			   p->session == last_pid) {
-				if(++last_pid >= next_safe) {
-					if(last_pid & ~PID_MASK)
-						last_pid = 300;
-					next_safe = PID_MAX;
-				}
-				goto repeat;
-			}
-			if(p->pid > last_pid && next_safe > p->pid)
-				next_safe = p->pid;
-			if(p->pgrp > last_pid && next_safe > p->pgrp)
-				next_safe = p->pgrp;
-			if(p->tgid > last_pid && next_safe > p->tgid)
-				next_safe = p->tgid;
-			if(p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
-		}
+	} else if(!max_pid_cross)
+		goto get_out;
+repeat:
+	read_lock(&tasklist_lock);
+	if (find_task_by_pid(last_pid)) {
 		read_unlock(&tasklist_lock);
+		if ((++last_pid) & ~PID_MASK)
+			last_pid = 300;
+		goto repeat;
 	}
+	read_unlock(&tasklist_lock);
+get_out:
 	pid = last_pid;
 	spin_unlock(&lastpid_lock);


