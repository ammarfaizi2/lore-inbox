Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRKHXqo>; Thu, 8 Nov 2001 18:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278879AbRKHXqZ>; Thu, 8 Nov 2001 18:46:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29304 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278841AbRKHXqX>; Thu, 8 Nov 2001 18:46:23 -0500
Date: Fri, 9 Nov 2001 00:46:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011109004619.G17383@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>; from mingo@elte.hu on Thu, Nov 08, 2001 at 03:30:11PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 03:30:11PM +0100, Ingo Molnar wrote:
>  		current->counter += p->counter;
> -		if (current->counter >= MAX_COUNTER)
> +		current->timer_ticks += p->timer_ticks;
> +		if (current->counter >= MAX_COUNTER) {
>  			current->counter = MAX_COUNTER;
> +			if (current->timer_ticks >= current->counter) {
> +				current->counter = 0;
> +				current->timer_ticks = 0;
> +				current->need_resched = 1;
> +			}
> +		}
>  		p->pid = 0;
>  		free_task_struct(p);

Before changing this area I'd prefer if you would apply this very
longstanding important bugfix that is floating in my tree for ages (not
sure if it's related to your patch, I don't understand exactly the
semantics of timer_ticks at the moment).

diff -urN parent-timeslice-ref/include/linux/sched.h parent-timeslice/include/linux/sched.h
--- parent-timeslice-ref/include/linux/sched.h	Wed Oct 24 13:18:54 2001
+++ parent-timeslice/include/linux/sched.h	Wed Oct 24 13:19:00 2001
@@ -317,6 +317,7 @@
 #ifdef CONFIG_NUMA_SCHED
 	int nid;
 #endif
+	int get_child_timeslice;
 	struct task_struct *next_task, *prev_task;
 	struct mm_struct *active_mm;
 	struct rw_sem_recursor mm_recursor;
diff -urN parent-timeslice-ref/kernel/exit.c parent-timeslice/kernel/exit.c
--- parent-timeslice-ref/kernel/exit.c	Wed Oct 24 08:04:27 2001
+++ parent-timeslice/kernel/exit.c	Wed Oct 24 13:19:35 2001
@@ -61,9 +61,11 @@
 		 * timeslices, because any timeslice recovered here
 		 * was given away by the parent in the first place.)
 		 */
-		current->counter += p->counter;
-		if (current->counter >= MAX_COUNTER)
-			current->counter = MAX_COUNTER;
+		if (p->get_child_timeslice) {
+			current->counter += p->counter;
+			if (current->counter >= MAX_COUNTER)
+				current->counter = MAX_COUNTER;
+		}
 		p->pid = 0;
 		free_task_struct(p);
 	} else {
@@ -164,6 +166,7 @@
 			p->exit_signal = SIGCHLD;
 			p->self_exec_id++;
 			p->p_opptr = child_reaper;
+			p->get_child_timeslice = 0;
 			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
 		}
 	}
diff -urN parent-timeslice-ref/kernel/fork.c parent-timeslice/kernel/fork.c
--- parent-timeslice-ref/kernel/fork.c	Wed Oct 24 13:18:54 2001
+++ parent-timeslice/kernel/fork.c	Wed Oct 24 13:19:00 2001
@@ -682,6 +682,9 @@
 	if (!current->counter)
 		current->need_resched = 1;
 
+	/* Tell the parent if it can get back its timeslice when child exits */
+	p->get_child_timeslice = 1;
+
 	/*
 	 * Ok, add it to the run-queues and make it
 	 * visible to the rest of the system.
diff -urN parent-timeslice-ref/kernel/sched.c parent-timeslice/kernel/sched.c
--- parent-timeslice-ref/kernel/sched.c	Wed Oct 24 13:18:54 2001
+++ parent-timeslice/kernel/sched.c	Wed Oct 24 13:19:00 2001
@@ -758,6 +758,7 @@
 				continue;
 #endif
 			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+			p->get_child_timeslice = 0;
 		}
 		read_unlock(&tasklist_lock);
 		spin_lock_irq(&runqueue_lock);


And also the schedule-child-first logic (I use it all the time for ages,
the only bug we managed to trigger was a race in /sbin/init that I fixed
a few months ago and it should be merged in the latest sysvinit
package):

diff -urN parent-timeslice/include/linux/sched.h child-first/include/linux/sched.h
--- parent-timeslice/include/linux/sched.h	Thu May  3 18:17:56 2001
+++ child-first/include/linux/sched.h	Thu May  3 18:19:44 2001
@@ -301,7 +301,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	int counter;
+	volatile int counter;
 	int nice;
 	unsigned int policy;
 	struct mm_struct *mm;
diff -urN parent-timeslice/kernel/fork.c child-first/kernel/fork.c
--- parent-timeslice/kernel/fork.c	Thu May  3 18:18:31 2001
+++ child-first/kernel/fork.c	Thu May  3 18:20:40 2001
@@ -665,15 +665,18 @@
 	p->pdeath_signal = 0;
 
 	/*
-	 * "share" dynamic priority between parent and child, thus the
-	 * total amount of dynamic priorities in the system doesnt change,
-	 * more scheduling fairness. This is only important in the first
-	 * timeslice, on the long run the scheduling behaviour is unchanged.
+	 * Scheduling the child first is especially useful in avoiding a
+	 * lot of copy-on-write faults if the child for a fork() just wants
+	 * to do a few simple things and then exec().
 	 */
-	p->counter = (current->counter + 1) >> 1;
-	current->counter >>= 1;
-	if (!current->counter)
+	{
+		int counter = current->counter;
+		p->counter = (counter + 1) >> 1;
+		current->counter = counter >> 1;
+		p->policy &= ~SCHED_YIELD;
+		current->policy |= SCHED_YIELD;
 		current->need_resched = 1;
+	}
 
 	/* Tell the parent if it can get back its timeslice when child exits */
 	p->get_child_timeslice = 1;


Last thing, I guess slip should be fixed to use sched_yield instead of
zeroing the timeslice to enforce the reschedule.

Andrea
