Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264311AbSITCsd>; Thu, 19 Sep 2002 22:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271140AbSITCsd>; Thu, 19 Sep 2002 22:48:33 -0400
Received: from holomorphy.com ([66.224.33.161]:44677 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264311AbSITCsc>;
	Thu, 19 Sep 2002 22:48:32 -0400
Date: Thu, 19 Sep 2002 19:47:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920024709.GE3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D8A6EC1.1010809@redhat.com> <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com> <20020919221546.A30103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020919221546.A30103@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:01:33PM -0300, Rik van Riel wrote:
>> So, where did you put those 800 MB of kernel stacks needed for
>> 100,000 threads ?

On Thu, Sep 19, 2002 at 10:15:46PM -0400, Benjamin LaHaise wrote:
> That's what the 4KB stack patch is for. ;-)
> 		-ben

The task_struct isn't particularly slim either. I heard rumblings
that way back when it was shared with the stack the NR_CPUS arrays
filled (and overflowed) the entire stack... It's also enough to
put a wee bit of pressure on ZONE_NORMAL even on smaller task count
workloads.

Perhaps something like this is in order? vs. 2.5.33:

 fs/proc/array.c       |   22 ----------------------
 fs/proc/base.c        |   11 +----------
 include/linux/sched.h |    1 -
 kernel/fork.c         |   11 +----------
 kernel/timer.c        |    3 ---
 5 files changed, 2 insertions(+), 46 deletions(-)



Cheers,
Bill


===== fs/proc/array.c 1.24 vs edited =====
--- 1.24/fs/proc/array.c	Thu Jul  4 22:54:38 2002
+++ edited/fs/proc/array.c	Tue Jul 16 00:35:26 2002
@@ -592,25 +592,3 @@
 out:
 	return retval;
 }
-
-#ifdef CONFIG_SMP
-int proc_pid_cpu(struct task_struct *task, char * buffer)
-{
-	int i, len;
-
-	len = sprintf(buffer,
-		"cpu  %lu %lu\n",
-		jiffies_to_clock_t(task->utime),
-		jiffies_to_clock_t(task->stime));
-		
-	for (i = 0 ; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
-			i,
-			jiffies_to_clock_t(task->per_cpu_utime[i]),
-			jiffies_to_clock_t(task->per_cpu_stime[i]));
-
-	}
-	return len;
-}
-#endif
===== fs/proc/base.c 1.26 vs edited =====
--- 1.26/fs/proc/base.c	Wed May 22 08:48:14 2002
+++ edited/fs/proc/base.c	Tue Jul 16 00:36:12 2002
@@ -52,7 +52,6 @@
 	PROC_PID_STAT,
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
-	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
@@ -72,9 +71,6 @@
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
-#ifdef CONFIG_SMP
-  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
-#endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
@@ -1003,12 +999,7 @@
 		case PROC_PID_MAPS:
 			inode->i_fop = &proc_maps_operations;
 			break;
-#ifdef CONFIG_SMP
-		case PROC_PID_CPU:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_cpu;
-			break;
-#endif
+
 		case PROC_PID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
===== include/linux/sched.h 1.70 vs edited =====
--- 1.70/include/linux/sched.h	Thu Jul  4 22:33:26 2002
+++ edited/include/linux/sched.h	Tue Jul 16 00:35:26 2002
@@ -325,7 +325,6 @@
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
-	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
===== kernel/fork.c 1.49 vs edited =====
--- 1.49/kernel/fork.c	Mon Jul  1 14:41:36 2002
+++ edited/kernel/fork.c	Tue Jul 16 00:35:26 2002
@@ -725,16 +725,7 @@
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
-#ifdef CONFIG_SMP
-	{
-		int i;
-
-		/* ?? should we just memset this ?? */
-		for(i = 0; i < NR_CPUS; i++)
-			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
-		spin_lock_init(&p->sigmask_lock);
-	}
-#endif
+	spin_lock_init(&p->sigmask_lock);
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
===== kernel/timer.c 1.17 vs edited =====
--- 1.17/kernel/timer.c	Mon Jul  1 14:41:36 2002
+++ edited/kernel/timer.c	Tue Jul 16 00:35:26 2002
@@ -569,8 +569,6 @@
 void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
-	p->per_cpu_utime[cpu] += user;
-	p->per_cpu_stime[cpu] += system;
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
