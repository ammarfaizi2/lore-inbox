Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSGPK5h>; Tue, 16 Jul 2002 06:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSGPK5g>; Tue, 16 Jul 2002 06:57:36 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:9737 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314149AbSGPK5e>; Tue, 16 Jul 2002 06:57:34 -0400
Date: Tue, 16 Jul 2002 13:00:29 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] Re: What is supposed to replace clock_t?
In-Reply-To: <Pine.LNX.4.33.0207161130100.31873-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0207161254420.32123-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - extend start_time in task_struct to 64 bits

Together with the previous patch the most obvious 49 day wraparounds 
should be gone now. For wraparounds to happen, a single process needs to 
get more that 49 days of cpu time.
Fixing this (i.e., the per-process statistics) will be a little bit more 
difficult because of the locking issues, so this will happen later.

Tim


--- linux-2.5.25/include/linux/sched.h	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-j64/include/linux/sched.h	Tue Jul 16 09:01:09 2002
@@ -310,7 +310,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
-	unsigned long start_time;
+	jiffies_t start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;

--- linux-2.5.25/kernel/fork.c	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-j64/kernel/fork.c	Tue Jul 16 09:42:02 2002
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/jiffies.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -700,7 +701,7 @@
 #endif
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies_64();
 
 	INIT_LIST_HEAD(&p->local_pages);
 

--- linux-2.5.25/fs/proc/array.c	Sat Jul 13 08:40:20 2002
+++ linux-2.5.25-j64/fs/proc/array.c	Tue Jul 16 09:02:46 2002
@@ -346,7 +346,7 @@
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
@@ -369,7 +369,7 @@
 		nice,
 		0UL /* removed */,
 		jiffies_to_clock_t(task->it_real_value),
-		jiffies_to_clock_t(task->start_time),
+		jiffies_to_user_HZ(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.5.25/mm/oom_kill.c	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-j64/mm/oom_kill.c	Tue Jul 16 08:37:52 2002
@@ -73,7 +73,7 @@
 	 * but we don't care _that_ much...
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (int)((get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10));
 
 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));

--- linux-2.5.25/kernel/acct.c	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-j64/kernel/acct.c	Tue Jul 16 09:56:08 2002
@@ -50,6 +50,7 @@
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -299,6 +300,7 @@
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -316,9 +318,11 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) +
-		(xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies_64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
+	                       (unsigned long) elapsed : (unsigned long) -1l);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - (__u32) elapsed;
 	ac.ac_utime = encode_comp_t(current->utime);
 	ac.ac_stime = encode_comp_t(current->stime);
 	ac.ac_uid = current->uid;

