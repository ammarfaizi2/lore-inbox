Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314051AbSDZOQK>; Fri, 26 Apr 2002 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSDZOQJ>; Fri, 26 Apr 2002 10:16:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44722 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314051AbSDZOQH>;
	Fri, 26 Apr 2002 10:16:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: get_pid fixes against 2.4.19pre7
Date: Fri, 26 Apr 2002 09:16:46 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Ihno Krumreich <ihno@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020426134409.C19278@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020426141541.096F13FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 April 2002 07:44 am, Andrea Arcangeli wrote:
> Hello,
>
> Could you have a look at these get_pid fixes? Besides the deadlocking
> while running out of pids and reducing from quadratic to linear the
> complexity of get_pids, it also addresses a longstanding non trivial
> race present in 2.2 too that can lead to pid collisions even on UP
> (noticed today while merging two more fixes from Ihno on the other
> part). the fix reduces a bit scalability of simultaneous forks from
> different cpus, but it's obviously right at least. Putting non-ready
> tasks into the tasklists asks for troubles (signals...).  For more
> details see the comment at the end of the patch. If you've suggestions
> they're welcome, thanks.
>
>

Andrea, is this a consolidation of some of the work that I posted earlier 
with the following patch for 2.4.17 and some of the discussions that followed
from that. 

At least from my prospect I ran some test and recognized that the
break even point between the two algorithms was about 22K pids.

Hence, I switched between the two algorithms at that break even point.

If you want I can send you the test program and you can measure
for yourself how your stuff is doing. The test program uses the
algo in user space and hence you can get some quick and decent answers.
Let me know if you like it.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)


diff -urbN linux-2.4.17/kernel/fork.c linux-2.4.17-pid/kernel/fork.c
--- linux-2.4.17/kernel/fork.c	Wed Nov 21 13:18:42 2001
+++ linux-2.4.17-pid/kernel/fork.c	Thu Mar 28 17:05:33 2002
@@ -81,23 +81,111 @@
 /* Protects next_safe and last_pid. */
 spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
 
+/* this should be provided in every architecture */
+#ifndef SHIFT_PER_LONG
+#if BITS_PER_LONG == 64
+#   define SHIFT_PER_LONG 6
+#elif BITS_PER_LONG == 32
+#   define SHIFT_PER_LONG 5
+#else
+#error "SHIFT_PER_LONG"
+#endif
+#endif
+
+#define RESERVED_PIDS       (300)
+#define GETPID_THRESHOLD    (22000)  /* when to switch to a mapped algo */
+#define PID_MAP_SIZE        (PID_MAX >> SHIFT_PER_LONG)
+static unsigned long pid_map[PID_MAP_SIZE];
+static int next_safe = PID_MAX;
+
+static inline void mark_pid(int pid)
+{
+	__set_bit(pid,pid_map);
+}
+
+static int get_pid_by_map(int lastpid) 
+{
+	static int mark_and_sweep = 0;
+
+	int round = 0;
+        struct task_struct *p;
+        int i;
+	unsigned long mask;
+	int fpos;
+
+
+	if (mark_and_sweep) {
+repeat:
+		mark_and_sweep = 0;
+		memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
+		lastpid = RESERVED_PIDS;
+	}
+	for_each_task(p) {
+		mark_pid(p->pid);
+		mark_pid(p->pgrp);
+		mark_pid(p->tgid);
+		mark_pid(p->session);
+	}
+
+	/* find next free pid */
+	i = (lastpid >> SHIFT_PER_LONG);
+	mask = pid_map[i] | ((1 << ((lastpid & (BITS_PER_LONG-1)))) - 1);   
+	
+	while ((mask == ~0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+	
+	if (i == PID_MAP_SIZE) { 
+		if (round == 0) {
+			round = 1;
+			goto repeat;
+		}
+		next_safe = RESERVED_PIDS;
+		mark_and_sweep = 1;  /* mark next time */
+		return 0; 
+	}
+
+	fpos = ffz(mask);
+	i &= (PID_MAX-1);
+	lastpid = (i << SHIFT_PER_LONG) + fpos;
+
+	/* find next save pid */
+	mask &= ~((1 << fpos) - 1);
+
+	while ((mask == 0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+
+	if (i==PID_MAP_SIZE) 
+		next_safe = PID_MAX;
+	else 
+		next_safe = (i << SHIFT_PER_LONG) + ffs(mask) - 1;
+	return lastpid;
+}
+
 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
 	struct task_struct *p;
+	int pid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
 
 	spin_lock(&lastpid_lock);
 	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
+		last_pid = RESERVED_PIDS;		/* Skip daemons etc. */
 		goto inside;
 	}
 	if(last_pid >= next_safe) {
 inside:
 		next_safe = PID_MAX;
 		read_lock(&tasklist_lock);
+		if (nr_threads > GETPID_THRESHOLD) {
+			last_pid = get_pid_by_map(last_pid);
+			if (last_pid == 0) {
+				last_pid = PID_MAX;
+				goto nomorepids; 
+			}
+		} else {
+			int beginpid = last_pid;
 	repeat:
 		for_each_task(p) {
 			if(p->pid == last_pid	||
@@ -106,9 +194,11 @@
 			   p->session == last_pid) {
 				if(++last_pid >= next_safe) {
 					if(last_pid & 0xffff8000)
-						last_pid = 300;
+							last_pid = RESERVED_PIDS;
 					next_safe = PID_MAX;
 				}
+					if(last_pid == beginpid)
+						goto nomorepids;
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)
@@ -117,12 +207,22 @@
 				next_safe = p->pgrp;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
+				if(p->tgid > last_pid && next_safe > p->tgid)
+					next_safe = p->tgid;
+			}
 		}
 		read_unlock(&tasklist_lock);
 	}
+	pid = last_pid;
 	spin_unlock(&lastpid_lock);
 
-	return last_pid;
+	return pid;
+
+nomorepids:
+        next_safe = last_pid = PID_MAX;
+        read_unlock(&tasklist_lock);
+        spin_unlock(&lastpid_lock);
+        return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
