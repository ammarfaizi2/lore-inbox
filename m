Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTA2NEr>; Wed, 29 Jan 2003 08:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbTA2NEr>; Wed, 29 Jan 2003 08:04:47 -0500
Received: from web11503.mail.yahoo.com ([216.136.172.35]:61204 "HELO
	web11503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265894AbTA2NEn>; Wed, 29 Jan 2003 08:04:43 -0500
Message-ID: <20030129131405.10865.qmail@web11503.mail.yahoo.com>
Date: Wed, 29 Jan 2003 05:14:05 -0800 (PST)
From: Brian Sullivan <brian_p_sully@yahoo.com>
Subject: Re: [PATCH] fix current->user->processes leak
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030128221346.GA7288@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric -

Thank you very much for your prompt and helpful
feedback. Since you gave me a patch I thought you
might be interested in a few more details of the
problem. The symptoms I described to you only happen
on my "server" class machines. On desktop PCs I get a
far more sinister problem, the kernel panic. I've
included the messages that go to the main console. Do
you see anything in the code that could be causing
this? Or maybe your patch already fixed it?

Brian


Message from console:
c012e9db
*pde = 00000000
Oops: 0002
loop sr_mod sb sb_lib vart401 sound soundcore mgq
agpgart autofs 8139too mii i
CPU:    0
EIP: 0010:[<c012e9db>] Not Tainted
EFLAGS: 00010046

EIP is at kmem_cache_free [kernel] 0x3b
eax: 00000000  ebx:c1009b10   ecx:06016204  
edx:00000004
esi: c11c54b0  edf:0000024e   ebp:00000011  
esp:c75fa5f64
ds: 0018   es:0018   cs:0018
process init(pid:1, stackpage c7fa5000)
stack: .....<bunch of stuff>

Call Trace: [<c011fb3d>]free_uid [kernel] 0x2d
[<c011a0b5>]release_task [kernel] 0x35
[<c011af86>]sys_wait4 [kernel] 0x316
[<c0108923>]system_call [kernel] 0x33

Code: 89 44 8b 18 89 4b 14 8b 53 10 8d 42 ff 89 43 10
85 c0 75 21
<0>Kernel panic: Attempted to killl init!

--- Eric Lammerts <eric@lammerts.org> wrote:
> 
> On Tue, 28 Jan 2003, Brian Sullivan wrote:
> > The problem I am experiencing is that after a
> certain number of mounts I
> > get the error message "fork: Resource temporarily
> unavailable" on the
> > command line.
> 
> > After much trouble shooting I realized that number
> of mounts/umount
> > sequences I am limited to is the max number of
> processes for my user id. I
> > confirmed this by using the "ulimit -u" command to
> lower my process limit.
> > It appears the mount command is leaving someting
> in some sort of process
> > table in kernel memory (nothing shows in ps or top
> or in /proc/#### as
> > being left behind). Has anybody any sort of
> experience with this at all?
> > Any suggestions?
> 
> It's a kernel bug (and easy to reproduce).
>          
> Every time you do a loop mount, a kernel thread is
> started (those
> processes are called "loop0", "loop1", etc.). The
> problem is that when
> it starts, it's counted as one of your processes *).
> Then, it's
> changed to be a root-owned process without
> correcting that count **).
> 
> Patch below fixes the problem. It moves the
> bookkeeping of changing
> current->user to a new function switch_uid() (which
> is now also used
> by exec_usermodehelper() in kmod.c). The patch is
> tested.
> 
> Eric
> 
> *)  "atomic_inc(&p->user->processes);" in do_fork().
> **) "this_task->user = INIT_USER;" in
> reparent_to_init().
> 
> 
> --- linux-2.4.21-pre3/include/linux/sched.h.orig
> 2003-01-28 21:39:29.000000000 +0100
> +++ linux-2.4.21-pre3/include/linux/sched.h
> 2003-01-28 22:26:29.000000000 +0100
> @@ -576,6 +576,7 @@
>  /* per-UID process charging. */
>  extern struct user_struct * alloc_uid(uid_t);
>  extern void free_uid(struct user_struct *);
> +extern void switch_uid(struct user_struct *);
>  
>  #include <asm/current.h>
>  
> --- linux-2.4.21-pre3/kernel/sys.c.orig	2003-01-28
> 21:21:20.000000000 +0100
> +++ linux-2.4.21-pre3/kernel/sys.c	2003-01-28
> 22:30:13.000000000 +0100
> @@ -492,19 +492,12 @@
>  
>  static int set_user(uid_t new_ruid, int dumpclear)
>  {
> -	struct user_struct *new_user, *old_user;
> +	struct user_struct *new_user;
>  
> -	/* What if a process setreuid()'s and this brings
> the
> -	 * new uid over his NPROC rlimit?  We can check
> this now
> -	 * cheaply with the new uid cache, so if it
> matters
> -	 * we should be checking for it.  -DaveM
> -	 */
>  	new_user = alloc_uid(new_ruid);
>  	if (!new_user)
>  		return -EAGAIN;
> -	old_user = current->user;
> -	atomic_dec(&old_user->processes);
> -	atomic_inc(&new_user->processes);
> +	switch_uid(new_user);
>  
>  	if(dumpclear)
>  	{
> @@ -512,8 +505,6 @@
>  		wmb();
>  	}
>  	current->uid = new_ruid;
> -	current->user = new_user;
> -	free_uid(old_user);
>  	return 0;
>  }
>  
> --- linux-2.4.21-pre3/kernel/sched.c.orig	2003-01-28
> 21:21:06.000000000 +0100
> +++ linux-2.4.21-pre3/kernel/sched.c	2003-01-28
> 22:30:41.000000000 +0100
> @@ -1274,7 +1274,7 @@
>  	this_task->cap_permitted = CAP_FULL_SET;
>  	this_task->keep_capabilities = 0;
>  	memcpy(this_task->rlim, init_task.rlim,
> sizeof(*(this_task->rlim)));
> -	this_task->user = INIT_USER;
> +	switch_uid(INIT_USER);
>  
>  	spin_unlock(&runqueue_lock);
>  	write_unlock_irq(&tasklist_lock);
> --- linux-2.4.21-pre3/kernel/kmod.c.orig	2003-01-28
> 22:29:02.000000000 +0100
> +++ linux-2.4.21-pre3/kernel/kmod.c	2003-01-28
> 22:29:36.000000000 +0100
> @@ -119,15 +119,7 @@
>  		if (curtask->files->fd[i]) close(i);
>  	}
>  
> -	/* Drop the "current user" thing */
> -	{
> -		struct user_struct *user = curtask->user;
> -		curtask->user = INIT_USER;
> -		atomic_inc(&INIT_USER->__count);
> -		atomic_inc(&INIT_USER->processes);
> -		atomic_dec(&user->processes);
> -		free_uid(user);
> -	}
> +	switch_uid(INIT_USER);
>  
>  	/* Give kmod all effective privileges.. */
>  	curtask->euid = curtask->fsuid = 0;
> --- linux-2.4.21-pre3/kernel/user.c.orig	2003-01-28
> 22:23:21.000000000 +0100
> +++ linux-2.4.21-pre3/kernel/user.c	2003-01-28
> 22:37:48.000000000 +0100
> @@ -120,6 +120,23 @@
>  	return up;
>  }
>  
> +void switch_uid(struct user_struct *new_user)
> +{
> +	struct user_struct *old_user;
> +
> +	/* What if a process setreuid()'s and this brings
> the
> +	 * new uid over his NPROC rlimit?  We can check
> this now
> +	 * cheaply with the new uid cache, so if it
> matters
> +	 * we should be checking for it.  -DaveM
> +	 */
> +	old_user = current->user;
> +	atomic_inc(&new_user->__count);
> +	atomic_inc(&new_user->processes);
> +	atomic_dec(&old_user->processes);
> +	current->user = new_user;
> +	free_uid(old_user);
> +}
> +
>  
>  static int __init uid_cache_init(void)
>  {
> 
> 
> -- 
> To UNSUBSCRIBE, email to
> cdwrite-request@other.debian.org
> with a subject of "unsubscribe". Trouble? Contact
> listmaster@other.debian.org
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
