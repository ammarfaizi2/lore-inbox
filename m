Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWBPTTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWBPTTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWBPTTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:19:01 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:11396 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932352AbWBPTTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:19:00 -0500
Date: Thu, 16 Feb 2006 11:19:32 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] fix kill_proc_info() vs CLONE_THREAD race
Message-ID: <20060216191932.GE1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D54.4D0AAEFD@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F37D54.4D0AAEFD@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 10:13:24PM +0300, Oleg Nesterov wrote:
> There is a window after copy_process() unlocks ->sighand.siglock
> and before it adds the new thread to the thread list.
> 
> In that window __group_complete_signal(SIGKILL) will not see the
> new thread yet, so this thread will start running while the whole
> thread group was supposed to exit.

The fix looks good to me!

> I beleive we have another good reason to place attach_pid(PID/TGID)
> under ->sighand.siglock. We can do the same for
> 
> 	release_task()->__unhash_process()
> 
> 	de_thread()->switch_exec_pids()
> 
> After that we don't need tasklist_lock to iterate over the thread
> list, and we can simplify things, see for example do_sigaction()
> or sys_times().

The above proposal would require that we hold siglock during the
traversal, correct?  Is that reasonable for non-signal-related traversals?
Or were you thinking of making this change only for signal code?

						Thanx, Paul

Acked-by: <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.16-rc3/kernel/fork.c~1_KILL	2006-02-15 22:52:07.000000000 +0300
> +++ 2.6.16-rc3/kernel/fork.c	2006-02-15 23:21:51.000000000 +0300
> @@ -1123,8 +1123,8 @@ static task_t *copy_process(unsigned lon
>  		p->real_parent = current;
>  	p->parent = p->real_parent;
>  
> +	spin_lock(&current->sighand->siglock);
>  	if (clone_flags & CLONE_THREAD) {
> -		spin_lock(&current->sighand->siglock);
>  		/*
>  		 * Important: if an exit-all has been started then
>  		 * do not create this new thread - the whole thread
> @@ -1162,8 +1162,6 @@ static task_t *copy_process(unsigned lon
>  			 */
>  			p->it_prof_expires = jiffies_to_cputime(1);
>  		}
> -
> -		spin_unlock(&current->sighand->siglock);
>  	}
>  
>  	/*
> @@ -1189,6 +1187,7 @@ static task_t *copy_process(unsigned lon
>  
>  	nr_threads++;
>  	total_forks++;
> +	spin_unlock(&current->sighand->siglock);
>  	write_unlock_irq(&tasklist_lock);
>  	proc_fork_connector(p);
>  	return p;
> 
