Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289048AbSAFXzX>; Sun, 6 Jan 2002 18:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAFXzR>; Sun, 6 Jan 2002 18:55:17 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:36877 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289048AbSAFXzD>; Sun, 6 Jan 2002 18:55:03 -0500
Date: Sun, 6 Jan 2002 15:59:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jens Axboe <axboe@suse.de>
cc: Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre
 performance degradation on an old 486 )
In-Reply-To: <20020106112129.D8673@suse.de>
Message-ID: <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Jens Axboe wrote:

> On Sat, Jan 05 2002, Davide Libenzi wrote:
> > > > (*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
> > > > small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.
> > >
> > > Is this ISA (maybe it has something to do with ISA bouncing)? Mine is:
> > >
> > > 486 DX/2 ISA, Adaptec 1542, two slow scsi disks and a self-made
> > > slackware-based system.
> > >
> > > Can you also backout the scheduler changes to verify this? I have a
> > > backout patch for 2.5.2-pre6, if you don't want to do this for yourself.
> >
> > There should be some part of the kernel that assume a certain scheduler
> > behavior. There was a guy that reported a bad  hdparm  performance and i
> > tried it. By running  hdparm -t  my system has a context switch of 20-30
> > and an irq load of about 100-110.
> > The scheduler itself, even if you code it in visual basic, cannot make
> > this with such loads.
> > Did you try to profile the kernel ?
>
> Davide,
>
> If this is caused by ISA bounce problems, then you should be able to
> reproduce by doing something ala
>
> [ drivers/ide/ide-dma.c ]
>
> ide_toggle_bounce()
> {
> 	...
>
> +	addr = BLK_BOUNCE_ISA;
> 	blk_queue_bounce_limit(&drive->queue, addr);
> }
>
> pseudo-diff, just add the addr = line. Now compare performance with and
> without your scheduler changes.

I fail to understand where the scheduler code can influence this.
There's basically nothing inside blk_queue_bounce_limit()
I made this patch for Andrea and it's the scheduler code for 2.4.18-pre1
Could someone give it a try on old 486s




- Davide





diff -Nru linux-2.4.18-pre1.vanilla/arch/alpha/kernel/process.c linux-2.4.18-pre1.tsss/arch/alpha/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/alpha/kernel/process.c	Sun Sep 30 12:26:08 2001
+++ linux-2.4.18-pre1.tsss/arch/alpha/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -75,7 +75,6 @@
 {
 	/* An endless idle loop with no priority at all.  */
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		/* FIXME -- EV6 and LCA45 know how to power down
diff -Nru linux-2.4.18-pre1.vanilla/arch/arm/kernel/process.c linux-2.4.18-pre1.tsss/arch/arm/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/arm/kernel/process.c	Sun Sep 30 12:26:08 2001
+++ linux-2.4.18-pre1.tsss/arch/arm/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -85,7 +85,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		void (*idle)(void) = pm_idle;
diff -Nru linux-2.4.18-pre1.vanilla/arch/cris/kernel/process.c linux-2.4.18-pre1.tsss/arch/cris/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/cris/kernel/process.c	Fri Nov  9 13:58:02 2001
+++ linux-2.4.18-pre1.tsss/arch/cris/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -119,7 +119,6 @@
 int cpu_idle(void *unused)
 {
 	while(1) {
-		current->counter = -100;
 		schedule();
 	}
 }
diff -Nru linux-2.4.18-pre1.vanilla/arch/i386/kernel/process.c linux-2.4.18-pre1.tsss/arch/i386/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.4.18-pre1.tsss/arch/i386/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -125,7 +125,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		void (*idle)(void) = pm_idle;
diff -Nru linux-2.4.18-pre1.vanilla/arch/ia64/kernel/process.c linux-2.4.18-pre1.tsss/arch/ia64/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/ia64/kernel/process.c	Fri Nov  9 14:26:17 2001
+++ linux-2.4.18-pre1.tsss/arch/ia64/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -114,8 +114,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;
-

 	while (1) {
 #ifdef CONFIG_SMP
diff -Nru linux-2.4.18-pre1.vanilla/arch/m68k/kernel/process.c linux-2.4.18-pre1.tsss/arch/m68k/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/m68k/kernel/process.c	Sun Sep 30 12:26:08 2001
+++ linux-2.4.18-pre1.tsss/arch/m68k/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -81,7 +81,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	idle();
 }

diff -Nru linux-2.4.18-pre1.vanilla/arch/mips/kernel/process.c linux-2.4.18-pre1.tsss/arch/mips/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/mips/kernel/process.c	Sun Sep  9 10:43:01 2001
+++ linux-2.4.18-pre1.tsss/arch/mips/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -36,7 +36,6 @@
 {
 	/* endless idle loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();

 	while (1) {
diff -Nru linux-2.4.18-pre1.vanilla/arch/mips64/kernel/process.c linux-2.4.18-pre1.tsss/arch/mips64/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/mips64/kernel/process.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.18-pre1.tsss/arch/mips64/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -34,7 +34,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	while (1) {
 		while (!current->need_resched)
 			if (wait_available)
diff -Nru linux-2.4.18-pre1.vanilla/arch/parisc/kernel/process.c linux-2.4.18-pre1.tsss/arch/parisc/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/parisc/kernel/process.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.18-pre1.tsss/arch/parisc/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -71,7 +71,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		while (!current->need_resched) {
diff -Nru linux-2.4.18-pre1.vanilla/arch/ppc/8260_io/uart.c linux-2.4.18-pre1.tsss/arch/ppc/8260_io/uart.c
--- linux-2.4.18-pre1.vanilla/arch/ppc/8260_io/uart.c	Sat Jan  5 19:34:50 2002
+++ linux-2.4.18-pre1.tsss/arch/ppc/8260_io/uart.c	Sat Jan  5 19:38:57 2002
@@ -1732,7 +1732,7 @@
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
 		current->state = TASK_INTERRUPTIBLE;
-/*		current->counter = 0;	 make us low-priority */
+/*		current->dyn_prio = 0;	 make us low-priority */
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
diff -Nru linux-2.4.18-pre1.vanilla/arch/ppc/8xx_io/uart.c linux-2.4.18-pre1.tsss/arch/ppc/8xx_io/uart.c
--- linux-2.4.18-pre1.vanilla/arch/ppc/8xx_io/uart.c	Sat Jan  5 19:34:50 2002
+++ linux-2.4.18-pre1.tsss/arch/ppc/8xx_io/uart.c	Sat Jan  5 19:38:57 2002
@@ -1798,7 +1798,7 @@
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
 		current->state = TASK_INTERRUPTIBLE;
-/*		current->counter = 0;	 make us low-priority */
+/*		current->dyn_prio = 0;	 make us low-priority */
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
diff -Nru linux-2.4.18-pre1.vanilla/arch/ppc/kernel/idle.c linux-2.4.18-pre1.tsss/arch/ppc/kernel/idle.c
--- linux-2.4.18-pre1.vanilla/arch/ppc/kernel/idle.c	Sat Jan  5 19:34:50 2002
+++ linux-2.4.18-pre1.tsss/arch/ppc/kernel/idle.c	Sat Jan  5 19:38:57 2002
@@ -54,7 +54,6 @@

 	/* endless loop with no priority at all */
 	current->nice = 20;
-	current->counter = -100;
 	init_idle();
 	for (;;) {
 #ifdef CONFIG_SMP
diff -Nru linux-2.4.18-pre1.vanilla/arch/s390/kernel/process.c linux-2.4.18-pre1.tsss/arch/s390/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/s390/kernel/process.c	Sat Jan  5 19:34:51 2002
+++ linux-2.4.18-pre1.tsss/arch/s390/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -57,7 +57,6 @@
 	/* endless idle loop with no priority at all */
         init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup | 0x80000000L;
 	while(1) {
diff -Nru linux-2.4.18-pre1.vanilla/arch/s390x/kernel/process.c linux-2.4.18-pre1.tsss/arch/s390x/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/s390x/kernel/process.c	Sat Jan  5 19:34:51 2002
+++ linux-2.4.18-pre1.tsss/arch/s390x/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -57,7 +57,6 @@
 	/* endless idle loop with no priority at all */
         init_idle();
 	current->nice = 20;
-	current->counter = -100;
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup;
 	while(1) {
diff -Nru linux-2.4.18-pre1.vanilla/arch/sh/kernel/process.c linux-2.4.18-pre1.tsss/arch/sh/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/sh/kernel/process.c	Mon Oct 15 13:36:48 2001
+++ linux-2.4.18-pre1.tsss/arch/sh/kernel/process.c	Sat Jan  5 19:38:57 2002
@@ -41,7 +41,6 @@
 	/* endless idle loop with no priority at all */
 	init_idle();
 	current->nice = 20;
-	current->counter = -100;

 	while (1) {
 		if (hlt_counter) {
diff -Nru linux-2.4.18-pre1.vanilla/arch/sparc/kernel/process.c linux-2.4.18-pre1.tsss/arch/sparc/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/sparc/kernel/process.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18-pre1.tsss/arch/sparc/kernel/process.c	Sat Jan  5 19:38:57 2002
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
diff -Nru linux-2.4.18-pre1.vanilla/arch/sparc64/kernel/process.c linux-2.4.18-pre1.tsss/arch/sparc64/kernel/process.c
--- linux-2.4.18-pre1.vanilla/arch/sparc64/kernel/process.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18-pre1.tsss/arch/sparc64/kernel/process.c	Sat Jan  5 19:38:57 2002
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
diff -Nru linux-2.4.18-pre1.vanilla/drivers/net/slip.c linux-2.4.18-pre1.tsss/drivers/net/slip.c
--- linux-2.4.18-pre1.vanilla/drivers/net/slip.c	Sun Sep 30 12:26:07 2001
+++ linux-2.4.18-pre1.tsss/drivers/net/slip.c	Sat Jan  5 19:38:57 2002
@@ -1394,7 +1394,7 @@
 		 */
 		do {
 			if (busy) {
-				current->counter = 0;
+				current->time_slice = 0;
 				schedule();
 			}

diff -Nru linux-2.4.18-pre1.vanilla/fs/proc/array.c linux-2.4.18-pre1.tsss/fs/proc/array.c
--- linux-2.4.18-pre1.vanilla/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux-2.4.18-pre1.tsss/fs/proc/array.c	Sat Jan  5 19:38:57 2002
@@ -335,8 +335,7 @@

 	/* scale priority and nice values from timeslices to -20..20 */
 	/* to make it look like a "normal" Unix priority/nice value  */
-	priority = task->counter;
-	priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
+	priority = task->dyn_prio;
 	nice = task->nice;

 	read_lock(&tasklist_lock);
diff -Nru linux-2.4.18-pre1.vanilla/include/linux/sched.h linux-2.4.18-pre1.tsss/include/linux/sched.h
--- linux-2.4.18-pre1.vanilla/include/linux/sched.h	Fri Dec 21 09:42:03 2001
+++ linux-2.4.18-pre1.tsss/include/linux/sched.h	Sat Jan  5 19:56:14 2002
@@ -150,6 +150,7 @@
 extern void update_process_times(int user);
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
+extern void expire_task(struct task_struct *p);

 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
@@ -300,7 +301,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	long counter;
+	unsigned long dyn_prio;
 	long nice;
 	unsigned long policy;
 	struct mm_struct *mm;
@@ -319,7 +320,9 @@
 	 * that's just fine.)
 	 */
 	struct list_head run_list;
-	unsigned long sleep_time;
+	long time_slice;
+	/* recalculation loop checkpoint */
+	unsigned long rcl_last;

 	struct task_struct *next_task, *prev_task;
 	struct mm_struct *active_mm;
@@ -446,8 +449,9 @@
  */
 #define _STK_LIM	(8*1024*1024)

-#define DEF_COUNTER	(10*HZ/100)	/* 100 ms time slice */
-#define MAX_COUNTER	(20*HZ/100)
+#define MAX_DYNPRIO	40
+#define DEF_TSLICE	(5 * HZ / 100)
+#define MAX_TSLICE	(20 * HZ / 100)
 #define DEF_NICE	(0)


@@ -468,14 +472,16 @@
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
@@ -876,7 +882,6 @@
 static inline void del_from_runqueue(struct task_struct * p)
 {
 	nr_running--;
-	p->sleep_time = jiffies;
 	list_del(&p->run_list);
 	p->run_list.next = NULL;
 }
diff -Nru linux-2.4.18-pre1.vanilla/kernel/exit.c linux-2.4.18-pre1.tsss/kernel/exit.c
--- linux-2.4.18-pre1.vanilla/kernel/exit.c	Sat Jan  5 19:34:51 2002
+++ linux-2.4.18-pre1.tsss/kernel/exit.c	Sat Jan  5 19:38:57 2002
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
diff -Nru linux-2.4.18-pre1.vanilla/kernel/fork.c linux-2.4.18-pre1.tsss/kernel/fork.c
--- linux-2.4.18-pre1.vanilla/kernel/fork.c	Wed Nov 21 10:18:42 2001
+++ linux-2.4.18-pre1.tsss/kernel/fork.c	Sat Jan  5 19:38:57 2002
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
diff -Nru linux-2.4.18-pre1.vanilla/kernel/sched.c linux-2.4.18-pre1.tsss/kernel/sched.c
--- linux-2.4.18-pre1.vanilla/kernel/sched.c	Fri Dec 21 09:42:04 2001
+++ linux-2.4.18-pre1.tsss/kernel/sched.c	Sat Jan  5 19:52:29 2002
@@ -51,24 +51,16 @@
  * NOTE! The unix "nice" value influences how long a process
  * gets. The nice value ranges from -20 to +19, where a -20
  * is a "high-priority" task, and a "+10" is a low-priority
- * task.
- *
- * We want the time-slice to be around 50ms or so, so this
- * calculation depends on the value of HZ.
+ * task. The default time slice for zero-nice tasks will be 37ms.
  */
-#if HZ < 200
-#define TICK_SCALE(x)	((x) >> 2)
-#elif HZ < 400
-#define TICK_SCALE(x)	((x) >> 1)
-#elif HZ < 800
-#define TICK_SCALE(x)	(x)
-#elif HZ < 1600
-#define TICK_SCALE(x)	((x) << 1)
-#else
-#define TICK_SCALE(x)	((x) << 2)
-#endif
+#define NICE_RANGE	40
+#define MIN_NICE_TSLICE	10000
+#define MAX_NICE_TSLICE	90000
+#define TASK_TIMESLICE(p)	((int) ts_table[19 - (p)->nice])
+
+static unsigned char ts_table[NICE_RANGE];

-#define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)
+#define MM_AFFINITY_BONUS	1


 /*
@@ -94,6 +86,8 @@

 static LIST_HEAD(runqueue_head);

+static unsigned long rcl_curr = 0;
+
 /*
  * We align per-CPU scheduling data on cacheline boundaries,
  * to prevent cacheline ping-pong.
@@ -165,10 +159,11 @@
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
@@ -178,7 +173,7 @@

 		/* .. and a slight advantage to the current MM */
 		if (p->mm == this_mm || !p->mm)
-			weight += 1;
+			weight += MM_AFFINITY_BONUS;
 		weight += 20 - p->nice;
 		goto out;
 	}
@@ -324,6 +319,9 @@
  */
 static inline void add_to_runqueue(struct task_struct * p)
 {
+	p->dyn_prio += rcl_curr - p->rcl_last;
+	p->rcl_last = rcl_curr;
+	if (p->dyn_prio > MAX_DYNPRIO) p->dyn_prio = MAX_DYNPRIO;
 	list_add(&p->run_list, &runqueue_head);
 	nr_running++;
 }
@@ -536,6 +534,19 @@
 	__schedule_tail(prev);
 }

+void expire_task(struct task_struct *p)
+{
+	if (unlikely(!p->time_slice))
+		goto need_resched;
+
+	if (!--p->time_slice) {
+		if (p->dyn_prio)
+			p->dyn_prio--;
+	need_resched:
+		p->need_resched = 1;
+	}
+}
+
 /*
  *  'schedule()' is the scheduler function. It's a very simple and nice
  * scheduler: it's not perfect, but certainly works for most things.
@@ -578,20 +589,20 @@

 	/* move an exhausted RR process to be last.. */
 	if (unlikely(prev->policy == SCHED_RR))
-		if (!prev->counter) {
-			prev->counter = NICE_TO_TICKS(prev->nice);
+		if (!prev->time_slice) {
+			prev->time_slice = TASK_TIMESLICE(prev);
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

@@ -616,14 +627,12 @@

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
+			p->time_slice = TASK_TIMESLICE(p);
+			p->rcl_last = rcl_curr;
+		}
 		goto repeat_schedule;
 	}

@@ -1056,17 +1065,17 @@
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
@@ -1115,7 +1124,7 @@
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
 	if (p)
-		jiffies_to_timespec(p->policy & SCHED_FIFO ? 0 : NICE_TO_TICKS(p->nice),
+		jiffies_to_timespec(p->policy & SCHED_FIFO ? 0 : TASK_TIMESLICE(p),
 				    &t);
 	read_unlock(&tasklist_lock);
 	if (p)
@@ -1306,9 +1315,10 @@

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
@@ -1316,6 +1326,18 @@

 extern void init_timervecs (void);

+static void fill_tslice_map(void)
+{
+	int i;
+
+	for (i = 0; i < NICE_RANGE; i++) {
+		ts_table[i] = ((MIN_NICE_TSLICE +
+						((MAX_NICE_TSLICE -
+						  MIN_NICE_TSLICE) / (NICE_RANGE - 1)) * i) * HZ) / 1000000;
+		if (!ts_table[i]) ts_table[i] = 1;
+	}
+}
+
 void __init sched_init(void)
 {
 	/*
@@ -1329,6 +1351,8 @@

 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;
+
+	fill_tslice_map();

 	init_timervecs();

diff -Nru linux-2.4.18-pre1.vanilla/kernel/timer.c linux-2.4.18-pre1.tsss/kernel/timer.c
--- linux-2.4.18-pre1.vanilla/kernel/timer.c	Mon Oct  8 10:41:41 2001
+++ linux-2.4.18-pre1.tsss/kernel/timer.c	Sat Jan  5 19:38:57 2002
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
diff -Nru linux-2.4.18-pre1.vanilla/mm/oom_kill.c linux-2.4.18-pre1.tsss/mm/oom_kill.c
--- linux-2.4.18-pre1.vanilla/mm/oom_kill.c	Sat Nov  3 17:05:25 2001
+++ linux-2.4.18-pre1.tsss/mm/oom_kill.c	Sat Jan  5 19:38:57 2002
@@ -149,7 +149,8 @@
 	 * all the memory it needs. That way it should be able to
 	 * exit() and clear out its resources quickly...
 	 */
-	p->counter = 5 * HZ;
+	p->time_slice = 2 * MAX_TSLICE;
+	p->dyn_prio = MAX_DYNPRIO + 1;
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;

 	/* This process has hardware access, be more careful. */


