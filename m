Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTBXL72>; Mon, 24 Feb 2003 06:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTBXL72>; Mon, 24 Feb 2003 06:59:28 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15538 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266865AbTBXL71>;
	Mon, 24 Feb 2003 06:59:27 -0500
Date: Mon, 24 Feb 2003 13:09:05 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, <procps-list@redhat.com>,
       Robert Love <rml@tech9.net>
Subject: [patch] procfs-utime-2.5.62-B0
Message-ID: <Pine.LNX.4.44.0302241258050.24263-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this split-out patch adds per-thread-group CPU statistics to
/proc/PID/stat. This functionality is needed for procps to be able to take
full advantage of thread-directories. Patch is tested, it works.

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -379,6 +379,7 @@ struct task_struct {
 	struct timer_list real_timer;
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
+	unsigned long group_utime, group_stime, group_cutime, group_cstime;
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
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
+		jiffies_to_clock_t(task->group_utime),
+		jiffies_to_clock_t(task->group_stime),
+		jiffies_to_clock_t(task->group_cutime),
+		jiffies_to_clock_t(task->group_cstime));
+	if (mm)
 		mmput(mm);
 	return res;
 }
--- linux/kernel/timer.c.orig	
+++ linux/kernel/timer.c	
@@ -659,7 +659,10 @@ static inline void do_process_times(stru
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
@@ -87,6 +87,8 @@ void release_task(struct task_struct * p
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
+	p->parent->group_leader->group_cutime += p->utime + p->cutime;
+	p->parent->group_leader->group_cstime += p->stime + p->cstime;
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnswap += p->nswap + p->cnswap;
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -846,6 +846,9 @@ static struct task_struct *copy_process(
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->group_utime = p->group_stime = 0;
+	p->group_cutime = p->group_cstime = 0;
+
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();



