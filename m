Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264775AbSKJJaP>; Sun, 10 Nov 2002 04:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSKJJaP>; Sun, 10 Nov 2002 04:30:15 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:36526 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S264775AbSKJJaM>; Sun, 10 Nov 2002 04:30:12 -0500
Date: Sun, 10 Nov 2002 10:36:55 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use 64 bit jiffies 3/4
In-Reply-To: <Pine.LNX.4.33.0211101014120.12784-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0211101033400.12784-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3/4: 64 bit process start time

This prevents reporting processes as having started in the future, after 
32 bit jiffies wrap.
 

--- linux-2.5.46-bk4-j64a/include/linux/sched.h	Sat Nov  9 08:31:13 2002
+++ linux-2.5.46-bk4-j64b/include/linux/sched.h	Sun Nov 10 09:31:37 2002
@@ -336,7 +336,7 @@ struct task_struct {
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;

--- linux-2.5.46-bk4-j64a/kernel/fork.c	Sat Nov  9 08:31:13 2002
+++ linux-2.5.46-bk4-j64b/kernel/fork.c	Sun Nov 10 09:31:37 2002
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/jiffies.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 
@@ -772,7 +773,7 @@ static struct task_struct *copy_process(
 #endif
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies_64();
 	p->security = NULL;
 
 	p->core_waiter = 0;

--- linux-2.5.46-bk4-j64a/fs/proc/array.c	Mon Nov  4 23:30:32 2002
+++ linux-2.5.46-bk4-j64b/fs/proc/array.c	Sun Nov 10 09:31:37 2002
@@ -345,7 +345,7 @@ int proc_pid_stat(struct task_struct *ta
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
@@ -368,7 +368,7 @@ int proc_pid_stat(struct task_struct *ta
 		nice,
 		0UL /* removed */,
 		jiffies_to_clock_t(task->it_real_value),
-		jiffies_to_clock_t(task->start_time),
+		(unsigned long long) jiffies_64_to_user_HZ(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.5.46-bk4-j64a/kernel/acct.c	Mon Nov  4 23:30:31 2002
+++ linux-2.5.46-bk4-j64b/kernel/acct.c	Sun Nov 10 09:31:37 2002
@@ -49,7 +49,9 @@
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/tty.h>
+#include <linux/jiffies.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -304,6 +306,7 @@ static void do_acct_process(long exitcod
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -321,9 +324,11 @@ static void do_acct_process(long exitcod
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) +
-		(xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies_64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
+	                       (unsigned long) elapsed : (unsigned long) -1l);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->utime);
 	ac.ac_stime = encode_comp_t(current->stime);
 	ac.ac_uid = current->uid;

--- linux-2.5.46-bk4-j64a/mm/oom_kill.c	Mon Nov  4 23:30:30 2002
+++ linux-2.5.46-bk4-j64b/mm/oom_kill.c	Sun Nov 10 09:31:37 2002
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
+#include <linux/jiffies.h>
 
 /* #define DEBUG */
 
@@ -68,11 +69,10 @@ static int badness(struct task_struct *p
 	/*
 	 * CPU time is in seconds and run time is in minutes. There is no
 	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	 * very well in practice.
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));

