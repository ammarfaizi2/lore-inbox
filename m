Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTBTQXy>; Thu, 20 Feb 2003 11:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTBTQXy>; Thu, 20 Feb 2003 11:23:54 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60037 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265777AbTBTQXt>;
	Thu, 20 Feb 2003 11:23:49 -0500
Date: Thu, 20 Feb 2003 17:33:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, Alex Larsson <alexl@redhat.com>,
       <procps-list@redhat.com>
Subject: [patch] procfs/procps threading performance speedup, 2.5.62
Message-ID: <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of people have requested that threads should show up in /proc again,
to be able to look at per-thread CPU usage, activity, and generally, to
ease the debugging of threaded apps.

the main problem with threads in /proc is that there's a big slowdown when
using lots of threads. Here are some runtime numbers in seconds, under
2.5.62, on a 525MHz PIII box:

   # of threads (*):  1000    2000    4000    8000    16000
   --------------------------------------------------------
   ps                 0.77    1.52    3.13    6.44    13.81
   ps -axm            0.93    1.85    3.78    7.73    18.37
   top -d 0 -n 0      0.75    1.53    3.23    7.60    22.12

[ (*): the system is completely idle, all threads are sleeping. Overhead
is combined system and userspace overhead measured via 'time'.]

ie. the overhead is really massive, eg. with 16K threads running, procps
is basically unusable for any administration or debugging work. And there
are users that want 50K or more threads. So clearly, this state of procfs
and procps is unacceptable - who would use 'top' to check a system's state
if a single screen-refresh takes 22 seconds?!

in the above timings, only 'ps -axm' is actually displaying every thread,
all other commands produce only a few lines of output. The reason of the
overhead is two-fold:

1) there's significant kernel overhead in reading large /proc directories,
   the overhead of many readdir()'s is O(N^2). The main overhead is in
   get_pid_list(), which has to loop over an increasing number of threads
   to find the next intended batch of PIDs.

to fix this overhead i've introduced a 'lookup cursor' cookie, which is
cached in filp->private_data, across readdir() [getdents64()] calls. If
the cursor matches then we skip all the overhead of skipping threads. If
the cursor is not available then we fall back to the old-style skipping
algorithm.

2) procps is forced to parse every thread in /proc to build up accurate
   'process CPU usage' counters. The parsing and accessing of every
   /proc/PID/stat file is necessary because CPU statistics are scattered
   across all threads.

the fix for this is two-fold. First, it must be possible for procps to
separate 'threads' from 'processes' without having to go into 16 thousand
directories. I solved this by prefixing 'threads' (ie. non-group-leader
threads) with a dot ('.') character in the /proc listing:

 $ ls -a /proc
 .      16994   .17078  412  7          execdomains  locks       stat
 ..     16995   .17079  460  8          filesystems  meminfo     swaps
 1      17031   .17080  469  9          fs           misc        sys
 16864  17033   .17081  5    92         ide          mounts      sysvipc
 16866  17034   .17082  515  buddyinfo  interrupts   mtrr        tty
 16867  17072   17113   516  bus        iomem        net         uptime
 16946  .17073  2       517  cmdline    ioports      partitions  version
 16948  .17074  3       518  cpuinfo    irq          profile     vmstat
 16949  .17075  390     519  devices    kcore        scsi
 16989  .17076  4       520  dma        kmsg         self
 16992  .17077  400     6    driver     loadavg      slabinfo

the .17073 ... .17082 entries belong to the thread-group 17072.

The key here is for procps to be able to parse threads without having to
call into the kernel 16K times. The dot-approach also has the added
benefit of 'hiding' threads in the default 'ls /proc' listing.

the other change needed was the ability to read comulative CPU usage
statistics from the thread group leader. I've introduced 4 new fields in
/proc/PID/stat for that purpose, the kernel keeps those uptodate across
fork/exit and in the timer interrupt - it's very low-overhead.

the attached patch, against 2.5.62-BK, implements these kernel features.

Alex Larsson has modified procps for these new kernel capabilities, the
new procps package (or the patch against upstream procps) can be
downloaded from:

	http://people.redhat.com/alexl/procps/

here are the performance measurements (with stock procps+procfs numbers in
paranthesis)

   # of threads:       1000     2000     4000      8000      16000
   ----------------------------------------------------------------
   ps                  0.02     0.03     0.03      0.03       0.04
                      (0.77)   (1.52)   (3.13)    (6.44)    (13.81)

   ps -axm             0.89     1.72     3.40      6.87      15.57
                      (0.93)   (1.85)   (3.78)    (7.73)    (18.37)

   top -d 0 -n 0       0.11     0.12     0.12      0.13       0.16
                      (0.75)   (1.53)   (3.23)    (7.60)    (22.12)

eg. with 16K threads running in the background, a single 'top'
screen-refresh got more than 130 times faster. A simple 'ps' got more than
340 times faster ... Even the 'ps -axm' (which displays all threads)  
command got faster, due to the pid-cursor. But even with just 1000 threads
running a simple 'ps' is 30 times faster, and top refresh is 6 times
faster.

another advantage of this approach is that old procps is fully compatible
with the new kernel, and new procps is fully compatible with old kernels.  
Plus everything is still encoded in the ASCII namespace, no binary
interfaces are used.

the patch works just fine on my boxes. (the patch is also included in the
threading backport, in the rawhide 2.4 kernel, and has been in use for a
couple of weeks already.)

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -359,6 +359,7 @@ struct task_struct {
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
+	unsigned long group_utime, group_stime, group_cutime, group_cstime;
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
@@ -640,6 +641,9 @@ extern void kick_if_running(task_t * p);
  * Careful: do_each_thread/while_each_thread is a double loop so
  *          'break' will not work as expected - use goto instead.
  */
+#define __do_each_thread(g, t) \
+	for ( ; (g = t = next_task(g)) != &init_task ; ) do
+
 #define do_each_thread(g, t) \
 	for (g = t = &init_task ; (g = t = next_task(g)) != &init_task ; ) do
 
--- linux/fs/proc/array.c.orig	
+++ linux/fs/proc/array.c	
@@ -336,7 +336,7 @@ int proc_pid_stat(struct task_struct *ta
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %lu %lu %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -381,8 +381,12 @@ int proc_pid_stat(struct task_struct *ta
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
-	if(mm)
+		task->policy,
+		task->group_utime,
+		task->group_stime,
+		task->group_cutime,
+		task->group_cstime);
+	if (mm)
 		mmput(mm);
 	return res;
 }
--- linux/fs/proc/base.c.orig	
+++ linux/fs/proc/base.c	
@@ -876,6 +876,12 @@ static unsigned name_to_int(struct dentr
 
 	if (len > 1 && *name == '0')
 		goto out;
+	/*
+	 * Deal with dot-aliases for threads.
+	 */
+	if (name[0] == '.')
+		name++, len--;
+
 	while (len-- > 0) {
 		unsigned c = *name++ - '0';
 		if (c > 9)
@@ -1155,31 +1161,50 @@ out:
  * tasklist lock while doing this, and we must release it before
  * we actually do the filldir itself, so we use a temp buffer..
  */
-static int get_pid_list(int index, unsigned int *pids)
+static int get_pid_list(int index, int *pids, struct file *filp)
 {
-	struct task_struct *p;
-	int nr_pids = 0;
+	int nr_pids = 0, pid = 0, pid_cursor = (int)filp->private_data;
+	struct task_struct *g = NULL, *p = NULL;
 
-	index--;
 	read_lock(&tasklist_lock);
-	for_each_process(p) {
-		int pid = p->pid;
-		if (!pid)
-			continue;
+	if (pid_cursor) {
+		p = find_task_by_pid(pid_cursor);
+		g = p->group_leader;
+	}
+	if (!p) {
+		g = p = &init_task;
+		index--;
+	} else
+		index = 0;
+
+	goto inside;
+
+	__do_each_thread(g, p) {
 		if (--index >= 0)
 			continue;
-		pids[nr_pids] = pid;
+		pid = p->pid;
+		if (!pid)
+			BUG();
+		if (p->tgid != p->pid)
+			pids[nr_pids] = -pid;
+		else
+			pids[nr_pids] = pid;
 		nr_pids++;
 		if (nr_pids >= PROC_MAXPIDS)
-			break;
-	}
+			goto out;
+inside:
+		;
+	} while_each_thread(g, p);
+out:
+	filp->private_data = (void *)pid;
 	read_unlock(&tasklist_lock);
+
 	return nr_pids;
 }
 
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	unsigned int pid_array[PROC_MAXPIDS];
+	int pid_array[PROC_MAXPIDS];
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
 	unsigned int nr_pids, i;
@@ -1192,14 +1217,16 @@ int proc_pid_readdir(struct file * filp,
 		nr++;
 	}
 
-	nr_pids = get_pid_list(nr, pid_array);
+	nr_pids = get_pid_list(nr, pid_array, filp);
 
 	for (i = 0; i < nr_pids; i++) {
-		int pid = pid_array[i];
+		int pid = abs(pid_array[i]);
 		ino_t ino = fake_ino(pid,PROC_PID_INO);
 		unsigned long j = PROC_NUMBUF;
 
 		do buf[--j] = '0' + (pid % 10); while (pid/=10);
+		if (pid_array[i] < 0)
+			buf[--j] = '.';
 
 		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0)
 			break;
--- linux/kernel/timer.c.orig	
+++ linux/kernel/timer.c	
@@ -657,7 +657,10 @@ static inline void do_process_times(stru
 	unsigned long psecs;
 
 	psecs = (p->utime += user);
+	p->group_leader->group_utime += user;
 	psecs += (p->stime += system);
+	p->group_leader->group_stime += system;
+
 	if (psecs / HZ > p->rlim[RLIMIT_CPU].rlim_cur) {
 		/* Send SIGXCPU every second.. */
 		if (!(psecs % HZ))
--- linux/kernel/exit.c.orig	
+++ linux/kernel/exit.c	
@@ -92,6 +92,8 @@ void release_task(struct task_struct * p
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
+	p->parent->group_leader->group_cutime += p->utime + p->cutime;
+	p->parent->group_leader->group_cstime += p->stime + p->cstime;
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnswap += p->nswap + p->cnswap;
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -830,6 +830,9 @@ static struct task_struct *copy_process(
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->group_utime = p->group_stime = 0;
+	p->group_cutime = p->group_cstime = 0;
+
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();

