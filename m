Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWBPTZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWBPTZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWBPTZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:25:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37773 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932555AbWBPTZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:25:47 -0500
Date: Thu, 16 Feb 2006 11:26:17 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
Message-ID: <20060216192617.GF1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F37D56.2D7AB32F@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 10:13:26PM +0300, Oleg Nesterov wrote:
> copy_process:
> 
> 	attach_pid(p, PIDTYPE_PID, p->pid);
> 	attach_pid(p, PIDTYPE_TGID, p->tgid);
> 
> What if kill_proc_info(p->pid) happens in between?

Doesn't your patch 1/2 that expanded the scope of siglock in
copy_process() prevent this from happening?

o	A new process is being created on CPU 0, and does the first
	attach_pid() in copy_process(), but has not yet done
	the second attach_pid().

o	Meanwhile, on CPU 1, kill_proc_info() successfully looks up the
	new process via find_task_by_pid().

o	Also on CPU 1, kill_proc_info() calls group_send_sig_info(),
	which checks permissions, locates the sighand structure,
	then attempts to acquire siglock.

	Given your patch 1/2, CPU 1 cannot proceed until CPU 0 gets
	done with the remaining attach_pid() calls.

So, what am I missing this time?  ;-)

						Thanx, Paul

> copy_process() holds current->sighand.siglock, so we are safe
> in CLONE_THREAD case, because current->sighand == p->sighand.
> 
> Otherwise, p->sighand is unlocked, the new process is already
> visible to the find_task_by_pid(), but have a copy of parent's
> 'struct pid' in ->pids[PIDTYPE_TGID].
> 
> This means that __group_complete_signal() may hang while doing
> 
> 	do ... while (next_thread() != p)
> 
> We can solve this problem if we reverse these 2 attach_pid()s:
> 
> 	attach_pid() does wmb()
> 
> 	group_send_sig_info() calls spin_lock(), which
> 	provides a read barrier. // Yes ?
> 
> I don't think we can hit this race in practice, but still.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.16-rc3/kernel/fork.c~2_HANG	2006-02-15 23:21:51.000000000 +0300
> +++ 2.6.16-rc3/kernel/fork.c	2006-02-16 00:03:20.000000000 +0300
> @@ -1173,8 +1173,6 @@ static task_t *copy_process(unsigned lon
>  	if (unlikely(p->ptrace & PT_PTRACED))
>  		__ptrace_link(p, current->parent);
>  
> -	attach_pid(p, PIDTYPE_PID, p->pid);
> -	attach_pid(p, PIDTYPE_TGID, p->tgid);
>  	if (thread_group_leader(p)) {
>  		p->signal->tty = current->signal->tty;
>  		p->signal->pgrp = process_group(current);
> @@ -1184,6 +1182,8 @@ static task_t *copy_process(unsigned lon
>  		if (p->pid)
>  			__get_cpu_var(process_counts)++;
>  	}
> +	attach_pid(p, PIDTYPE_TGID, p->tgid);
> +	attach_pid(p, PIDTYPE_PID, p->pid);
>  
>  	nr_threads++;
>  	total_forks++;
> 
