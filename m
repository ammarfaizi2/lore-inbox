Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbUKTALJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUKTALJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbUKTAIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:08:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21672 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261720AbUKTAER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:04:17 -0500
Date: Fri, 19 Nov 2004 17:46:28 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Task name handling for 2.4
Message-ID: <20041119194628.GC32474@logos.cnet>
References: <20041112173116.GA4365@w-mikek2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112173116.GA4365@w-mikek2.beaverton.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 09:31:16AM -0800, Mike Kravetz wrote:
> Hi Marcelo,
> 
> There is a problem with task name handling in the /proc fs.  See
> http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/0136.html
> for the patch that eventually made its way into the 2.6 tree.
> 
> We now have people experiencing the same problem/bug in 2.4.  Here
> is a patch for 2.4 that implements the same fix.  Please consider
> applying.

Applied, thanks.

> Thanks,
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 
> diff -Naur linux-2.4.28-rc2/fs/exec.c linux-2.4.28-rc2.work/fs/exec.c
> --- linux-2.4.28-rc2/fs/exec.c	2004-02-18 13:36:31.000000000 +0000
> +++ linux-2.4.28-rc2.work/fs/exec.c	2004-11-11 22:51:06.000000000 +0000
> @@ -563,12 +563,29 @@
>  	tsk->tgid = tsk->pid;
>  }
>  
> +void get_task_comm(char *buf, struct task_struct *tsk)
> +{
> +	/* buf must be at least sizeof(tsk->comm) in size */
> +	task_lock(tsk);
> +	memcpy(buf, tsk->comm, sizeof(tsk->comm));
> +	task_unlock(tsk);
> +}
> +
> +void set_task_comm(struct task_struct *tsk, char *buf)
> +{
> +	task_lock(tsk);
> +	strncpy(tsk->comm, buf, sizeof(tsk->comm));
> +	tsk->comm[sizeof(tsk->comm)-1]='\0';
> +	task_unlock(tsk);
> +}
> +
>  int flush_old_exec(struct linux_binprm * bprm)
>  {
>  	char * name;
>  	int i, ch, retval;
>  	struct signal_struct * oldsig;
>  	struct files_struct * files;
> +	char tcomm[sizeof(current->comm)];
>  
>  	/*
>  	 * Make sure we have a private signal table
> @@ -610,10 +627,11 @@
>  		if (ch == '/')
>  			i = 0;
>  		else
> -			if (i < 15)
> -				current->comm[i++] = ch;
> +			if (i < (sizeof(tcomm) - 1))
> +				tcomm[i++] = ch;
>  	}
> -	current->comm[i] = '\0';
> +	tcomm[i] = '\0';
> +	set_task_comm(current, tcomm);
>  
>  	flush_thread();
>  
> diff -Naur linux-2.4.28-rc2/fs/proc/array.c linux-2.4.28-rc2.work/fs/proc/array.c
> --- linux-2.4.28-rc2/fs/proc/array.c	2003-11-28 18:26:21.000000000 +0000
> +++ linux-2.4.28-rc2.work/fs/proc/array.c	2004-11-11 22:57:51.000000000 +0000
> @@ -86,10 +86,13 @@
>  {
>  	int i;
>  	char * name;
> +	char tcomm[sizeof(p->comm)];
> +
> +	get_task_comm(tcomm, p);
>  
>  	ADDBUF(buf, "Name:\t");
> -	name = p->comm;
> -	i = sizeof(p->comm);
> +	name = tcomm;
> +	i = sizeof(tcomm);
>  	do {
>  		unsigned char c = *name;
>  		name++;
> @@ -308,6 +311,7 @@
>  	int res;
>  	pid_t ppid;
>  	struct mm_struct *mm;
> +	char tcomm[sizeof(task->comm)];
>  
>  	state = *get_task_state(task);
>  	vsize = eip = esp = 0;
> @@ -333,6 +337,8 @@
>  		up_read(&mm->mmap_sem);
>  	}
>  
> +	get_task_comm(tcomm, task);
> +
>  	wchan = get_wchan(task);
>  
>  	collect_sigign_sigcatch(task, &sigign, &sigcatch);
> @@ -350,7 +356,7 @@
>  %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
>  %lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
>  		task->pid,
> -		task->comm,
> +		tcomm,
>  		state,
>  		ppid,
>  		task->pgrp,
> diff -Naur linux-2.4.28-rc2/include/linux/sched.h linux-2.4.28-rc2.work/include/linux/sched.h
> --- linux-2.4.28-rc2/include/linux/sched.h	2004-11-11 20:53:54.000000000 +0000
> +++ linux-2.4.28-rc2.work/include/linux/sched.h	2004-11-11 22:59:14.000000000 +0000
> @@ -800,6 +800,9 @@
>  extern int do_execve(char *, char **, char **, struct pt_regs *);
>  extern int do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
>  
> +extern void set_task_comm(struct task_struct *tsk, char *from);
> +extern void get_task_comm(char *to, struct task_struct *tsk);
> +
>  extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
>  extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
>  extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
