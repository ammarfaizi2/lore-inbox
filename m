Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314658AbSEKK1f>; Sat, 11 May 2002 06:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314659AbSEKK1d>; Sat, 11 May 2002 06:27:33 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:20741 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314658AbSEKK12>; Sat, 11 May 2002 06:27:28 -0400
Date: Sat, 11 May 2002 12:27:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3/6: 64 bit process start times
Message-ID: <Pine.LNX.4.33.0205111226400.26626-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bump up the start_time value of processes to 64 bit. This actually is overkill,
since "borrowing" a few bits from some other variable would suffice.
I just didn't know were to steal them and how to make access less ugly then.

Without this patch, processes that survive 32 bit jiffies wraparound are
reported as having started in the future.


--- linux-2.5.15/include/linux/sched.h	Thu May  9 17:47:15 2002
+++ linux-2.5.15-j64/include/linux/sched.h	Thu May  9 17:48:20 2002
@@ -294,7 +294,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;

--- linux-2.5.15/kernel/fork.c	Sun May  5 08:30:40 2002
+++ linux-2.5.15-j64/kernel/fork.c	Thu May  9 17:48:21 2002
@@ -709,7 +709,7 @@
 #endif
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies64();
 
 	INIT_LIST_HEAD(&p->local_pages);
 

--- linux-2.5.15/fs/proc/array.c	Thu May  9 17:47:15 2002
+++ linux-2.5.15-j64/fs/proc/array.c	Thu May  9 17:48:21 2002
@@ -345,7 +345,7 @@
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
 		task->pid,
 		task->comm,
@@ -368,7 +368,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		task->start_time,
+		(unsigned long long)(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,


