Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSIAT1f>; Sun, 1 Sep 2002 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSIAT1f>; Sun, 1 Sep 2002 15:27:35 -0400
Received: from crack.them.org ([65.125.64.184]:15378 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S317354AbSIAT1d>;
	Sun, 1 Sep 2002 15:27:33 -0400
Date: Sun, 1 Sep 2002 15:33:13 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BUG_ON(p->ptrace) in release_task()
Message-ID: <20020901193313.GA23985@nevyn.them.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <87fzwthapw.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzwthapw.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 02:38:03AM +0900, OGAWA Hirofumi wrote:
> Hi,
> 
> I think, BUG_ON(p->ptrace) will be called if the CLONE_DETACH process
> is traced.  This patch removes BUG_ON(p->ptrace), and also removes
> BUG_ON(p->ptrace) workaround in sys_wait4().

The BUG_ON is correct, and that isn't a workaround - if the list is not
empty, then it will be garbage after the task struct is freed.  Your
patch breaks tracing of normal processes again, because the ptrace_list
will not be empty.

It may be that the BUG_ON can be triggered for detached processes. In
that case a ptrace_unlink is necessary somewhere else.

> 
> Please apply.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> --- linux-2.5.33/kernel/exit.c~	2002-09-02 01:02:07.000000000 +0900
> +++ linux-2.5.33/kernel/exit.c	2002-09-02 00:54:47.000000000 +0900
> @@ -66,8 +66,7 @@
>  	atomic_dec(&p->user->processes);
>  	security_ops->task_free_security(p);
>  	free_uid(p->user);
> -	BUG_ON(p->ptrace || !list_empty(&p->ptrace_list) ||
> -					!list_empty(&p->ptrace_children));
> +	BUG_ON(!list_empty(&p->ptrace_list)||!list_empty(&p->ptrace_children));
>  	unhash_process(p);
>  
>  	release_thread(p);
> @@ -717,14 +716,8 @@
>  					ptrace_unlink(p);
>  					do_notify_parent(p, SIGCHLD);
>  					write_unlock_irq(&tasklist_lock);
> -				} else {
> -					if (p->ptrace) {
> -						write_lock_irq(&tasklist_lock);
> -						ptrace_unlink(p);
> -						write_unlock_irq(&tasklist_lock);
> -					}
> +				} else
>  					release_task(p);
> -				}
>  				goto end_wait4;
>  			default:
>  				continue;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
