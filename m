Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbRLZW3G>; Wed, 26 Dec 2001 17:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRLZW26>; Wed, 26 Dec 2001 17:28:58 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:37391 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284966AbRLZW2t>; Wed, 26 Dec 2001 17:28:49 -0500
Date: Wed, 26 Dec 2001 14:30:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Time Slice Split Scheduler 2nd ...
Message-ID: <Pine.LNX.4.40.0112261403500.1549-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the second version of the Time Slice Split Scheduler that
separates the concept of time slice from the concept of dynamic priority.
The patch is very simple and splits the actual 'counter' field in two, a
field named 'dyn_prio' that is the dynamic priority and a field named
'time_slice' that is the actual time slice of a task. The dynamic priority
is increased every time a task misses a recalculation loop :

    if (unlikely(!c)) {
        ++rcl_curr;
        list_for_each(tmp, &runqueue_head) {
            p = list_entry(tmp, struct task_struct, run_list);
            p->time_slice = NICE_TO_TICKS(p->nice);
            p->rcl_last = rcl_curr;
        }
        goto repeat_schedule;
    }

A new variable 'rcl_curr' ( protected by runqueue_lock ) is incremented at
every recalc loop and the loop is performed _only_ for running tasks. This
will dramatically decrease the worst case scenario of scheduler latency.
In my machine for example a typical context switch takes 1000-2500 cycles
while, having about 100 tasks listed by `ps`, the recalc loop takes about
40000-50000 cycles. Tasks are going to get their dynamic priority 'bonus'
when they're reinjected inside the run queue :

static inline void add_to_runqueue(struct task_struct * p)
{
    p->dyn_prio += rcl_curr - p->rcl_last;
    p->rcl_last = rcl_curr;
    if (p->dyn_prio > MAX_DYNPRIO) p->dyn_prio = MAX_DYNPRIO;
    list_add(&p->run_list, &runqueue_head);
    nr_running++;
}

and they'll keep it until they're going to claim it ( only one slice ) :

void expire_task(struct task_struct *p)
{
    if (!p->time_slice)
        p->need_resched = 1;
    else {
        if (!--p->time_slice) {
            if (p->dyn_prio > 0) {
                --p->time_slice;
                --p->dyn_prio;
            }
            p->need_resched = 1;
        } else if (p->time_slice < -NICE_TO_TICKS(p->nice)) {
            p->time_slice = 0;
            p->need_resched = 1;
        }
    }
}

This function is called from update_process_times() ( in kernel/timer.c )
and, if the dynamic priority is greater then zero, another time slice will
be granted to the task. This differ from the current scheduler where woke
up I/O bound tasks can claim the whole 'counter' accumulation all at a
time w/out interruption by potentially freezing the system for several ms.
Another advantage is that CPU bound tasks will probably sits to dynamic
priority zero and the mm affinity bonus given inside goodness() is
sufficent to correctly sort out this kind of processes. An immediate fix
for sys_sched_yield() is done by :

        ctsk->time_slice = 0;
        ++ctsk->dyn_prio;

where the time_slice is zeroed but is accumulated inside the dynamic
priority by having the task to be able to claim it back at later time.
This will prevent the 'infinite' switch behavior of the current scheduler
when more than one task is yield()ing.
Linus, when you'll go idle() for a couple of ms pls take a look at this
one.



The patch is described here :

http://www.xmailserver.org/linux-patches/lnxsched.html#TsSplit



- Davide






Makefile                      |    2 -
arch/alpha/kernel/process.c   |    1
arch/arm/kernel/process.c     |    1
arch/cris/kernel/process.c    |    1
arch/i386/kernel/process.c    |    1
arch/ia64/kernel/process.c    |    2 -
arch/m68k/kernel/process.c    |    1
arch/mips/kernel/process.c    |    1
arch/mips64/kernel/process.c  |    1
arch/parisc/kernel/process.c  |    1
arch/ppc/8260_io/uart.c       |    2 -
arch/ppc/8xx_io/uart.c        |    2 -
arch/ppc/kernel/idle.c        |    1
arch/s390/kernel/process.c    |    1
arch/s390x/kernel/process.c   |    1
arch/sh/kernel/process.c      |    1
arch/sparc/kernel/process.c   |    2 -
arch/sparc64/kernel/process.c |    2 -
drivers/net/slip.c            |    2 -
fs/proc/array.c               |    3 -
fs/reiserfs/buffer2.c         |    4 +-
fs/reiserfs/namei.c           |    2 -
include/linux/sched.h         |   17 ++++++--
kernel/exit.c                 |    6 +--
kernel/fork.c                 |    6 +--
kernel/sched.c                |   83 ++++++++++++++++++++++++++----------------
kernel/timer.c                |    5 --
mm/oom_kill.c                 |    3 +
28 files changed, 82 insertions, 73 deletions







diff -Nru linux-2.5.1-pre11.vanilla/Makefile linux-2.5.1-pre11.psch/Makefile
--- linux-2.5.1-pre11.vanilla/Makefile	Thu Dec 13 11:05:02 2001
+++ linux-2.5.1-pre11.psch/Makefile	Sat Dec 22 16:20:01 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 1
-EXTRAVERSION =-pre11
+EXTRAVERSION = -pre11-psch

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

diff -Nru linux-2.5.1-pre11.vanilla/arch/alpha/kernel/process.c linux-2.5.1-pre11.psch/arch/alpha/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/alpha/kernel/process.c	Sun Sep 30 12:26:08 2001
+++ linux-2.5.1-pre11.psch/arch/alpha/kernel/process.c	Sun Dec 23 12:28:23 2001
@@ -75,7 +75,6 @@
 {
 	/* An endless idle loop with no priority at all.  */
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		/* FIXME -- EV6 and LCA45 know how to power down
diff -Nru linux-2.5.1-pre11.vanilla/arch/arm/kernel/process.c linux-2.5.1-pre11.psch/arch/arm/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/arm/kernel/process.c	Sun Sep 30 12:26:08 2001
+++ linux-2.5.1-pre11.psch/arch/arm/kernel/process.c	Sun Dec 23 12:32:47 2001
@@ -85,7 +85,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		void (*idle)(void) = pm_idle;
diff -Nru linux-2.5.1-pre11.vanilla/arch/cris/kernel/process.c linux-2.5.1-pre11.psch/arch/cris/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/cris/kernel/process.c	Fri Nov  9 13:58:02 2001
+++ linux-2.5.1-pre11.psch/arch/cris/kernel/process.c	Sun Dec 23 12:35:15 2001
@@ -119,7 +119,6 @@
 int cpu_idle(void *unused)
 {
 	while(1) {
-		current->counter = -100;
 		schedule();
 	}
 }
diff -Nru linux-2.5.1-pre11.vanilla/arch/i386/kernel/process.c linux-2.5.1-pre11.psch/arch/i386/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.5.1-pre11.psch/arch/i386/kernel/process.c	Sat Dec 22 17:59:22 2001
@@ -125,7 +125,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		void (*idle)(void) = pm_idle;
diff -Nru linux-2.5.1-pre11.vanilla/arch/ia64/kernel/process.c linux-2.5.1-pre11.psch/arch/ia64/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/ia64/kernel/process.c	Fri Nov  9 14:26:17 2001
+++ linux-2.5.1-pre11.psch/arch/ia64/kernel/process.c	Sun Dec 23 12:33:24 2001
@@ -114,8 +114,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;
-

 	while (1) {
 #ifdef CONFIG_SMP
diff -Nru linux-2.5.1-pre11.vanilla/arch/m68k/kernel/process.c linux-2.5.1-pre11.psch/arch/m68k/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/m68k/kernel/process.c	Sun Sep 30 12:26:08 2001
+++ linux-2.5.1-pre11.psch/arch/m68k/kernel/process.c	Sun Dec 23 12:31:51 2001
@@ -81,7 +81,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	idle();
 }

diff -Nru linux-2.5.1-pre11.vanilla/arch/mips/kernel/process.c linux-2.5.1-pre11.psch/arch/mips/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/mips/kernel/process.c	Sun Sep  9 10:43:01 2001
+++ linux-2.5.1-pre11.psch/arch/mips/kernel/process.c	Sun Dec 23 12:29:28 2001
@@ -36,7 +36,6 @@
 {
 	/* endless idle loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();

 	while (1) {
diff -Nru linux-2.5.1-pre11.vanilla/arch/mips64/kernel/process.c linux-2.5.1-pre11.psch/arch/mips64/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/mips64/kernel/process.c	Fri Feb  9 11:29:44 2001
+++ linux-2.5.1-pre11.psch/arch/mips64/kernel/process.c	Sun Dec 23 12:33:39 2001
@@ -34,7 +34,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	while (1) {
 		while (!current->need_resched)
 			if (wait_available)
diff -Nru linux-2.5.1-pre11.vanilla/arch/parisc/kernel/process.c linux-2.5.1-pre11.psch/arch/parisc/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/parisc/kernel/process.c	Fri Feb  9 11:29:44 2001
+++ linux-2.5.1-pre11.psch/arch/parisc/kernel/process.c	Sun Dec 23 12:34:15 2001
@@ -71,7 +71,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		while (!current->need_resched) {
diff -Nru linux-2.5.1-pre11.vanilla/arch/ppc/8260_io/uart.c linux-2.5.1-pre11.psch/arch/ppc/8260_io/uart.c
--- linux-2.5.1-pre11.vanilla/arch/ppc/8260_io/uart.c	Mon May 21 17:04:46 2001
+++ linux-2.5.1-pre11.psch/arch/ppc/8260_io/uart.c	Sun Dec 23 12:31:28 2001
@@ -1732,7 +1732,7 @@
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
 		current->state = TASK_INTERRUPTIBLE;
-/*		current->counter = 0;	 make us low-priority */
+/*		current->dyn_prio = 0;	 make us low-priority */
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
diff -Nru linux-2.5.1-pre11.vanilla/arch/ppc/8xx_io/uart.c linux-2.5.1-pre11.psch/arch/ppc/8xx_io/uart.c
--- linux-2.5.1-pre11.vanilla/arch/ppc/8xx_io/uart.c	Fri Nov  2 17:43:54 2001
+++ linux-2.5.1-pre11.psch/arch/ppc/8xx_io/uart.c	Sun Dec 23 12:30:56 2001
@@ -1798,7 +1798,7 @@
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
 		current->state = TASK_INTERRUPTIBLE;
-/*		current->counter = 0;	 make us low-priority */
+/*		current->dyn_prio = 0;	 make us low-priority */
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
diff -Nru linux-2.5.1-pre11.vanilla/arch/ppc/kernel/idle.c linux-2.5.1-pre11.psch/arch/ppc/kernel/idle.c
--- linux-2.5.1-pre11.vanilla/arch/ppc/kernel/idle.c	Fri Nov  2 17:43:54 2001
+++ linux-2.5.1-pre11.psch/arch/ppc/kernel/idle.c	Sun Dec 23 12:29:52 2001
@@ -54,7 +54,6 @@

 	/* endless loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();
 	for (;;) {
 #ifdef CONFIG_SMP
diff -Nru linux-2.5.1-pre11.vanilla/arch/s390/kernel/process.c linux-2.5.1-pre11.psch/arch/s390/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/s390/kernel/process.c	Thu Oct 11 09:04:57 2001
+++ linux-2.5.1-pre11.psch/arch/s390/kernel/process.c	Sun Dec 23 12:33:58 2001
@@ -57,7 +57,6 @@
 	/* endless idle loop with no priority at all */
         init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup | 0x80000000L;
 	while(1) {
diff -Nru linux-2.5.1-pre11.vanilla/arch/s390x/kernel/process.c linux-2.5.1-pre11.psch/arch/s390x/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/s390x/kernel/process.c	Thu Oct 11 09:04:57 2001
+++ linux-2.5.1-pre11.psch/arch/s390x/kernel/process.c	Sun Dec 23 12:35:30 2001
@@ -57,7 +57,6 @@
 	/* endless idle loop with no priority at all */
         init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup;
 	while(1) {
diff -Nru linux-2.5.1-pre11.vanilla/arch/sh/kernel/process.c linux-2.5.1-pre11.psch/arch/sh/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/sh/kernel/process.c	Mon Oct 15 13:36:48 2001
+++ linux-2.5.1-pre11.psch/arch/sh/kernel/process.c	Sun Dec 23 12:33:01 2001
@@ -41,7 +41,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		if (hlt_counter) {
diff -Nru linux-2.5.1-pre11.vanilla/arch/sparc/kernel/process.c linux-2.5.1-pre11.psch/arch/sparc/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/sparc/kernel/process.c	Tue Nov 13 09:16:05 2001
+++ linux-2.5.1-pre11.psch/arch/sparc/kernel/process.c	Sun Dec 23 12:28:58 2001
@@ -61,7 +61,6 @@

 	/* endless idle loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();

 	for (;;) {
@@ -110,7 +109,6 @@
 {
 	/* endless idle loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();

 	while(1) {
diff -Nru linux-2.5.1-pre11.vanilla/arch/sparc64/kernel/process.c linux-2.5.1-pre11.psch/arch/sparc64/kernel/process.c
--- linux-2.5.1-pre11.vanilla/arch/sparc64/kernel/process.c	Sun Oct 21 10:36:54 2001
+++ linux-2.5.1-pre11.psch/arch/sparc64/kernel/process.c	Sun Dec 23 12:32:25 2001
@@ -54,7 +54,6 @@

 	/* endless idle loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();

 	for (;;) {
@@ -84,7 +83,6 @@
 int cpu_idle(void)
 {
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();

 	while(1) {
diff -Nru linux-2.5.1-pre11.vanilla/drivers/net/slip.c linux-2.5.1-pre11.psch/drivers/net/slip.c
--- linux-2.5.1-pre11.vanilla/drivers/net/slip.c	Sun Sep 30 12:26:07 2001
+++ linux-2.5.1-pre11.psch/drivers/net/slip.c	Sat Dec 22 16:18:21 2001
@@ -1394,7 +1394,7 @@
 		 */
 		do {
 			if (busy) {
-				current->counter = 0;
+				current->time_slice = 0;
 				schedule();
 			}

diff -Nru linux-2.5.1-pre11.vanilla/fs/proc/array.c linux-2.5.1-pre11.psch/fs/proc/array.c
--- linux-2.5.1-pre11.vanilla/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux-2.5.1-pre11.psch/fs/proc/array.c	Sat Dec 22 16:10:30 2001
@@ -335,8 +335,7 @@

 	/* scale priority and nice values from timeslices to -20..20 */
 	/* to make it look like a "normal" Unix priority/nice value  */
-	priority = task->counter;
-	priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
+	priority = task->dyn_prio;
 	nice = task->nice;

 	read_lock(&tasklist_lock);
diff -Nru linux-2.5.1-pre11.vanilla/fs/reiserfs/buffer2.c linux-2.5.1-pre11.psch/fs/reiserfs/buffer2.c
--- linux-2.5.1-pre11.vanilla/fs/reiserfs/buffer2.c	Fri Nov  9 14:18:25 2001
+++ linux-2.5.1-pre11.psch/fs/reiserfs/buffer2.c	Sat Dec 22 16:12:20 2001
@@ -47,7 +47,7 @@
     }
     run_task_queue(&tq_disk);
     current->policy |= SCHED_YIELD;
-    /*current->counter = 0;*/
+	/* current->dyn_prio = 0; */
     schedule();
   }
   if (repeat_counter > 30000000) {
@@ -149,7 +149,7 @@
 	printk("get_new_buffer(%u): counter(%d) too big", current->pid, repeat_counter);
 #endif

-      current->counter = 0;
+      current->time_slice = 0;
       schedule();
     }

diff -Nru linux-2.5.1-pre11.vanilla/fs/reiserfs/namei.c linux-2.5.1-pre11.psch/fs/reiserfs/namei.c
--- linux-2.5.1-pre11.vanilla/fs/reiserfs/namei.c	Fri Nov  9 14:18:25 2001
+++ linux-2.5.1-pre11.psch/fs/reiserfs/namei.c	Sat Dec 22 16:12:53 2001
@@ -1168,7 +1168,7 @@
 	    // FIXME: do we need this? shouldn't we simply continue?
 	    run_task_queue(&tq_disk);
 	    current->policy |= SCHED_YIELD;
-	    /*current->counter = 0;*/
+	    /*current->time_slice = 0;*/
 	    schedule();
 #endif
 	    continue;
diff -Nru linux-2.5.1-pre11.vanilla/include/linux/sched.h linux-2.5.1-pre11.psch/include/linux/sched.h
--- linux-2.5.1-pre11.vanilla/include/linux/sched.h	Thu Dec 13 14:28:40 2001
+++ linux-2.5.1-pre11.psch/include/linux/sched.h	Wed Dec 26 12:05:30 2001
@@ -149,6 +149,7 @@
 extern void update_process_times(int user);
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
+extern void expire_task(struct task_struct *p);

 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
@@ -299,7 +300,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	long counter;
+	long dyn_prio;
 	long nice;
 	unsigned long policy;
 	struct mm_struct *mm;
@@ -318,7 +319,10 @@
 	 * that's just fine.)
 	 */
 	struct list_head run_list;
+	long time_slice;
 	unsigned long sleep_time;
+	/* recalculation loop checkpoint */
+	unsigned long rcl_last;

 	struct task_struct *next_task, *prev_task;
 	struct mm_struct *active_mm;
@@ -444,8 +448,9 @@
  */
 #define _STK_LIM	(8*1024*1024)

-#define DEF_COUNTER	(10*HZ/100)	/* 100 ms time slice */
-#define MAX_COUNTER	(20*HZ/100)
+#define MAX_DYNPRIO	100
+#define DEF_TSLICE	(6 * HZ / 100)
+#define MAX_TSLICE	(20 * HZ / 100)
 #define DEF_NICE	(0)


@@ -466,14 +471,16 @@
     addr_limit:		KERNEL_DS,					\
     exec_domain:	&default_exec_domain,				\
     lock_depth:		-1,						\
-    counter:		DEF_COUNTER,					\
+    dyn_prio:		0,					\
     nice:		DEF_NICE,					\
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     cpus_runnable:	-1,						\
     cpus_allowed:	-1,						\
-    run_list:		LIST_HEAD_INIT(tsk.run_list),			\
+    run_list:		{ NULL, NULL },			\
+    rcl_last:		0,					\
+    time_slice:		DEF_TSLICE,					\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
     p_opptr:		&tsk,						\
diff -Nru linux-2.5.1-pre11.vanilla/kernel/exit.c linux-2.5.1-pre11.psch/kernel/exit.c
--- linux-2.5.1-pre11.vanilla/kernel/exit.c	Thu Dec 13 11:05:12 2001
+++ linux-2.5.1-pre11.psch/kernel/exit.c	Sat Dec 22 16:14:32 2001
@@ -62,9 +62,9 @@
 		 * timeslices, because any timeslice recovered here
 		 * was given away by the parent in the first place.)
 		 */
-		current->counter += p->counter;
-		if (current->counter >= MAX_COUNTER)
-			current->counter = MAX_COUNTER;
+		current->time_slice += p->time_slice;
+		if (current->time_slice > MAX_TSLICE)
+			current->time_slice = MAX_TSLICE;
 		p->pid = 0;
 		free_task_struct(p);
 	} else {
diff -Nru linux-2.5.1-pre11.vanilla/kernel/fork.c linux-2.5.1-pre11.psch/kernel/fork.c
--- linux-2.5.1-pre11.vanilla/kernel/fork.c	Thu Dec 13 11:05:12 2001
+++ linux-2.5.1-pre11.psch/kernel/fork.c	Sat Dec 22 16:15:26 2001
@@ -682,9 +682,9 @@
 	 * more scheduling fairness. This is only important in the first
 	 * timeslice, on the long run the scheduling behaviour is unchanged.
 	 */
-	p->counter = (current->counter + 1) >> 1;
-	current->counter >>= 1;
-	if (!current->counter)
+	p->time_slice = (current->time_slice + 1) >> 1;
+	current->time_slice >>= 1;
+	if (!current->time_slice)
 		current->need_resched = 1;

 	/*
diff -Nru linux-2.5.1-pre11.vanilla/kernel/sched.c linux-2.5.1-pre11.psch/kernel/sched.c
--- linux-2.5.1-pre11.vanilla/kernel/sched.c	Wed Nov 21 16:25:48 2001
+++ linux-2.5.1-pre11.psch/kernel/sched.c	Tue Dec 25 11:45:03 2001
@@ -94,6 +94,8 @@

 static LIST_HEAD(runqueue_head);

+static unsigned long rcl_curr = 0;
+
 /*
  * We align per-CPU scheduling data on cacheline boundaries,
  * to prevent cacheline ping-pong.
@@ -165,10 +167,11 @@
 		 * Don't do any other calculations if the time slice is
 		 * over..
 		 */
-		weight = p->counter;
-		if (!weight)
-			goto out;
-
+		if (!p->time_slice)
+			return 0;
+
+		weight = p->dyn_prio + 1;
+
 #ifdef CONFIG_SMP
 		/* Give a largish advantage to the same processor...   */
 		/* (this is equivalent to penalizing other processors) */
@@ -309,6 +312,9 @@
  */
 static inline void add_to_runqueue(struct task_struct * p)
 {
+	p->dyn_prio += rcl_curr - p->rcl_last;
+	p->rcl_last = rcl_curr;
+	if (p->dyn_prio > MAX_DYNPRIO) p->dyn_prio = MAX_DYNPRIO;
 	list_add(&p->run_list, &runqueue_head);
 	nr_running++;
 }
@@ -521,6 +527,24 @@
 	__schedule_tail(prev);
 }

+void expire_task(struct task_struct *p)
+{
+	if (!p->time_slice)
+		p->need_resched = 1;
+	else {
+		if (!--p->time_slice) {
+			if (p->dyn_prio > 0) {
+				--p->time_slice;
+				--p->dyn_prio;
+			}
+			p->need_resched = 1;
+		} else if (p->time_slice < -NICE_TO_TICKS(p->nice)) {
+			p->time_slice = 0;
+			p->need_resched = 1;
+		}
+	}
+}
+
 /*
  *  'schedule()' is the scheduler function. It's a very simple and nice
  * scheduler: it's not perfect, but certainly works for most things.
@@ -563,20 +587,20 @@

 	/* move an exhausted RR process to be last.. */
 	if (unlikely(prev->policy == SCHED_RR))
-		if (!prev->counter) {
-			prev->counter = NICE_TO_TICKS(prev->nice);
+		if (!prev->time_slice) {
+			prev->time_slice = NICE_TO_TICKS(prev->nice);
 			move_last_runqueue(prev);
 		}

 	switch (prev->state) {
-		case TASK_INTERRUPTIBLE:
-			if (signal_pending(prev)) {
-				prev->state = TASK_RUNNING;
-				break;
-			}
-		default:
-			del_from_runqueue(prev);
-		case TASK_RUNNING:;
+	case TASK_INTERRUPTIBLE:
+		if (signal_pending(prev)) {
+			prev->state = TASK_RUNNING;
+			break;
+		}
+	default:
+		del_from_runqueue(prev);
+	case TASK_RUNNING:;
 	}
 	prev->need_resched = 0;

@@ -601,14 +625,12 @@

 	/* Do we need to re-calculate counters? */
 	if (unlikely(!c)) {
-		struct task_struct *p;
-
-		spin_unlock_irq(&runqueue_lock);
-		read_lock(&tasklist_lock);
-		for_each_task(p)
-			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
-		read_unlock(&tasklist_lock);
-		spin_lock_irq(&runqueue_lock);
+		++rcl_curr;
+		list_for_each(tmp, &runqueue_head) {
+			p = list_entry(tmp, struct task_struct, run_list);
+			p->time_slice = NICE_TO_TICKS(p->nice);
+			p->rcl_last = rcl_curr;
+		}
 		goto repeat_schedule;
 	}

@@ -1041,17 +1063,17 @@
 	nr_pending--;
 #endif
 	if (nr_pending) {
+		struct task_struct *ctsk = current;
 		/*
 		 * This process can only be rescheduled by us,
 		 * so this is safe without any locking.
 		 */
-		if (current->policy == SCHED_OTHER)
-			current->policy |= SCHED_YIELD;
-		current->need_resched = 1;
-
-		spin_lock_irq(&runqueue_lock);
-		move_last_runqueue(current);
-		spin_unlock_irq(&runqueue_lock);
+		if (ctsk->policy == SCHED_OTHER)
+			ctsk->policy |= SCHED_YIELD;
+		ctsk->need_resched = 1;
+
+		ctsk->time_slice = 0;
+		++ctsk->dyn_prio;
 	}
 	return 0;
 }
@@ -1291,9 +1313,10 @@

 	if (current != &init_task && task_on_runqueue(current)) {
 		printk("UGH! (%d:%d) was on the runqueue, removing.\n",
-			smp_processor_id(), current->pid);
+			   smp_processor_id(), current->pid);
 		del_from_runqueue(current);
 	}
+	current->dyn_prio = 0;
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
 	clear_bit(current->processor, &wait_init_idle);
diff -Nru linux-2.5.1-pre11.vanilla/kernel/timer.c linux-2.5.1-pre11.psch/kernel/timer.c
--- linux-2.5.1-pre11.vanilla/kernel/timer.c	Mon Oct  8 10:41:41 2001
+++ linux-2.5.1-pre11.psch/kernel/timer.c	Sun Dec 23 11:39:44 2001
@@ -583,10 +583,7 @@

 	update_one_process(p, user_tick, system, cpu);
 	if (p->pid) {
-		if (--p->counter <= 0) {
-			p->counter = 0;
-			p->need_resched = 1;
-		}
+		expire_task(p);
 		if (p->nice > 0)
 			kstat.per_cpu_nice[cpu] += user_tick;
 		else
diff -Nru linux-2.5.1-pre11.vanilla/mm/oom_kill.c linux-2.5.1-pre11.psch/mm/oom_kill.c
--- linux-2.5.1-pre11.vanilla/mm/oom_kill.c	Sat Nov  3 17:05:25 2001
+++ linux-2.5.1-pre11.psch/mm/oom_kill.c	Sat Dec 22 16:18:00 2001
@@ -149,7 +149,8 @@
 	 * all the memory it needs. That way it should be able to
 	 * exit() and clear out its resources quickly...
 	 */
-	p->counter = 5 * HZ;
+	p->time_slice = 2 * MAX_TSLICE;
+	p->dyn_prio = MAX_DYNPRIO + 1;
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;

 	/* This process has hardware access, be more careful. */





