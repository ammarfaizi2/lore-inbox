Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUIBWRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUIBWRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUIBWPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:15:13 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:55169 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S269204AbUIBVlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:41:50 -0400
Message-ID: <F12B6443B4A38748AFA644D1F8EF353215110E@bos-ex-01.adprod.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix rusage semantics
Date: Thu, 2 Sep 2004 16:41:41 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending because of botched LKML address]

>  -----Original Message-----
> From: 	Makhlis, Lev  
> Sent:	Thursday, September 02, 2004 5:29 PM
> To:	'roland@redhat.com'; 'akpm@osdl.org'; 'vger.kernel.org'
> Subject:	Re: [PATCH] fix rusage semantics
> 
> Roland,
> 
> I think I've found a problem with the rusage patch:
> The resource counters for terminated threads (signal->utime et al) are
> accounted in rusage, but not in /proc/PID/stat.  Previously they were
> aggregated in cutime etc., which was incorrect semantics, but now
> they are completely invisible to procps until the entire process dies.
> I've tested this with a program that spawns cpu-bound threads and
> kills them after a while.  With 2.6.9-rc1-bk9, its shows
> utime=stime=cutime=cstime=0.  (With 2.6.9-rc1, cutime has the time.)
> 
> I'm not sure what the best solution here is.  It would be trivial to add
> task->signal->{utime,stime,maj_flt,min_flt} in proc_pid_stat(), but that
> would also be wrong, because there would be no way for a procps
> tool accurately to report the agregate resource usage for a process:
> If it just reads utime (et al) from /proc/PID/stat, it will underreport
> (will not count utime (et al) for live threads), and if it adds up utime
> (et al) from all /proc/PID/task/TID/stat files, then it will overreport
> (will count signal->utime (et al) multiple times).
> 
> In an ideal world, I think /proc/PID/stat would report aggregate resource
> usage for the process, and /proc/PID/task/TID/stat would have resource
> usage for individual threads (in case anyone cares).  I'm including a
> patch against 2.6.9-rc1-bk9 that does just that.  The problem with it is
> that /proc/PID/stat is no longer O(1).  Is that unacceptable?  It's the
> same
> thing that rusage now does, and arguably a procps tool would incur
> a much higher overhead if it needed to read /proc/PID/task/*/stat instead.
> 
> If the overhead is unacceptable, here are some other ideas:
> 
> 1. Report task->signal->utime + task->signal->cutime as cutime
> in proc_pid_stat().  This partially restores the old (incorrect)
> semantics.
> 2. Report task->utime + task->signal->utime as utime in /proc/PID/stat,
> but only task->utime in /proc/PID/task/TID/stat.  This ensures that
> numbers
> aren't lost, but the semantics aren't logically justified.
> 
> What do you think?
> 
> Lev
> 
> 
> Signed-off-by: Lev Makhlis <mlev@despammed.com>
> 
> diff -Nur linux-2.6.9-rc1-bk9/fs/proc/array.c linux/fs/proc/array.c
> --- linux-2.6.9-rc1-bk9/fs/proc/array.c	2004-09-02
> 16:16:01.617644504 -0400
> +++ linux/fs/proc/array.c	2004-09-02 16:18:31.250896792 -0400
> @@ -298,7 +298,7 @@
>  	return buffer - orig;
>  }
>  
> -int proc_pid_stat(struct task_struct *task, char * buffer)
> +static int proc_pid_stat(struct task_struct *task, char * buffer, int
> is_tgid)
>  {
>  	unsigned long vsize, eip, esp, wchan;
>  	long priority, nice;
> @@ -310,7 +310,9 @@
>  	int num_threads = 0;
>  	struct mm_struct *mm;
>  	unsigned long long start_time;
> +	unsigned long min_flt = 0, maj_flt = 0, utime = 0, stime = 0;
>  	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
> +	struct task_struct *t;
>  	char tcomm[sizeof(task->comm)];
>  
>  	state = *get_task_state(task);
> @@ -341,11 +343,32 @@
>  		}
>  		pgid = process_group(task);
>  		sid = task->signal->session;
> +		if (is_tgid) {
> +			min_flt = task->signal->min_flt;
> +			maj_flt = task->signal->maj_flt;
> +			utime = task->signal->utime;
> +			stime = task->signal->stime;
> +		}
>  		cmin_flt = task->signal->cmin_flt;
>  		cmaj_flt = task->signal->cmaj_flt;
>  		cutime = task->signal->cutime;
>  		cstime = task->signal->cstime;
>  	}
> +	if (is_tgid) {
> +		t = task;
> +		do {
> +			min_flt += t->min_flt;
> +			maj_flt += t->maj_flt;
> +			utime += t->utime;
> +			stime += t->stime;
> +			t = next_thread(t);
> +		} while (t != task);
> +	} else {
> +		min_flt = task->min_flt;
> +		maj_flt = task->maj_flt;
> +		utime = task->utime;
> +		stime = task->stime;
> +	}
>  	read_unlock(&tasklist_lock);
>  
>  	/* scale priority and nice values from timeslices to -20..20 */
> @@ -372,12 +395,12 @@
>  		tty_nr,
>  		tty_pgrp,
>  		task->flags,
> -		task->min_flt,
> +		min_flt,
>  		cmin_flt,
> -		task->maj_flt,
> +		maj_flt,
>  		cmaj_flt,
> -		jiffies_to_clock_t(task->utime),
> -		jiffies_to_clock_t(task->stime),
> +		jiffies_to_clock_t(utime),
> +		jiffies_to_clock_t(stime),
>  		jiffies_to_clock_t(cutime),
>  		jiffies_to_clock_t(cstime),
>  		priority,
> @@ -413,6 +436,16 @@
>  	return res;
>  }
>  
> +int proc_tid_stat(struct task_struct *task, char *buffer)
> +{
> +	return proc_pid_stat(task, buffer, 0);
> +}
> +
> +int proc_tgid_stat(struct task_struct *task, char *buffer)
> +{
> +	return proc_pid_stat(task, buffer, 1);
> +}
> +
>  int proc_pid_statm(struct task_struct *task, char *buffer)
>  {
>  	int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data = 0;
> diff -Nur linux-2.6.9-rc1-bk9/fs/proc/base.c linux/fs/proc/base.c
> --- linux-2.6.9-rc1-bk9/fs/proc/base.c	2004-09-02
> 16:16:01.622643744 -0400
> +++ linux/fs/proc/base.c	2004-09-02 16:18:35.390267512 -0400
> @@ -189,7 +189,8 @@
>  	return PROC_I(inode)->type;
>  }
>  
> -int proc_pid_stat(struct task_struct*,char*);
> +int proc_tid_stat(struct task_struct*,char*);
> +int proc_tgid_stat(struct task_struct*,char*);
>  int proc_pid_status(struct task_struct*,char*);
>  int proc_pid_statm(struct task_struct*,char*);
>  
> @@ -1315,9 +1316,12 @@
>  			ei->op.proc_read = proc_pid_status;
>  			break;
>  		case PROC_TID_STAT:
> +			inode->i_fop = &proc_info_file_operations;
> +			ei->op.proc_read = proc_tid_stat;
> +			break;
>  		case PROC_TGID_STAT:
>  			inode->i_fop = &proc_info_file_operations;
> -			ei->op.proc_read = proc_pid_stat;
> +			ei->op.proc_read = proc_tgid_stat;
>  			break;
>  		case PROC_TID_CMDLINE:
>  		case PROC_TGID_CMDLINE:
