Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWIEXH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWIEXH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWIEXH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:07:56 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:65498 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932206AbWIEXHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:07:55 -0400
Date: Wed, 6 Sep 2006 03:07:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com,
       arjan@linux.intel.com, viro@zeniv.linux.org.uk
Subject: Re: + audit-accounting-tty-locking.patch added to -mm tree
Message-ID: <20060905230753.GA613@oleg>
References: <200609052013.k85KDRWx010062@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609052013.k85KDRWx010062@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05, Andrew Morton wrote:
>
> Subject: audit/accounting: tty locking
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>
> Add tty locking around the audit and accounting code.
>
> The whole current->signal-> locking is all deeply strange but it's for
> someone else to sort out.  Add rather than replace the lock for acct.c

Historically ->signal/->sighand (both ptrs and their contents) were globally
protected by tasklist_lock. 'current' can use these pointers lockless, they
can't be changed under him.

Nowadays ->signal/->sighand are _also_ protected by ->sighand->siglock.
Unless you are current, you can't lock ->siglock directly (without holding
tasklist_lock), you should use lock_task_sighand().

But I don't understand ->signal->tty locking. I know nothing about job
control, looking into the tty_io.c for the first time.

tty_io.c:
	->tty is set under task_lock()

	->tty is cleared under lock_kernel() + tasklist_lock

	except TIOCNOTTY, cleared under task_lock()

Note that include/linux/sched.h doesn't document that ->alloc_lock
protects ->tty, it is only used in tty_io.c for that purpose, why?

daemonize:
	->tty is cleared under tty_mutex

sys_setsid:
	->tty is cleared under tty_mutex + tasklist_lock

Btw, I think tiocsctty()/tty_open() is racy wrt to sys_setsid().
tiocsctty() can see the result of '->signal->leader = 1' before
sys_setsid() changed ->session/->pgrp and passed '->tty = NULL'.

I think tiocsctty() and tty_open() need tty_mutex, no?

> --- a/kernel/acct.c~audit-accounting-tty-locking
> +++ a/kernel/acct.c
> @@ -483,10 +483,14 @@ static void do_acct_process(struct file
>  	ac.ac_ppid = current->parent->tgid;
>  #endif
>
> -	read_lock(&tasklist_lock);	/* pin current->signal */
> +	mutex_lock(&tty_mutex);
> +	/* FIXME: Whoever is responsible for current->signal locking needs
> +	   to use the same locking all over the kernel and document it */
> +	read_lock(&tasklist_lock);
>  	ac.ac_tty = current->signal->tty ?
>  		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
>  	read_unlock(&tasklist_lock);
> +	mutex_unlock(&tty_mutex);

I think the purpose of read_lock(&tasklist_lock) was to protect ->tty,
not ->signal, so I believe this comment is not correct.

Am I understand correctly? tasklist_lock is not enough, ->tty could be
cleared by ioctl(TIOCNOTTY). tty_mutex can't protect from changing ->tty
pointer, but it protects from releasing tty_struct, yes?

What about ->tty usage in do_task_stat() then ?

> --- a/kernel/auditsc.c~audit-accounting-tty-locking
> +++ a/kernel/auditsc.c
> @@ -766,6 +766,8 @@ static void audit_log_exit(struct audit_
>  		audit_log_format(ab, " success=%s exit=%ld",
>  				 (context->return_valid==AUDITSC_SUCCESS)?"yes":"no",
>  				 context->return_code);
> +
> +	mutex_lock(&tty_mutex);
>  	if (tsk->signal && tsk->signal->tty && tsk->signal->tty->name)

Ugh. I think this is ok, but I know nothing about audit.c. grep, grep ...
This 'tsk' should be == current. Probably we need a comment.

copy_process() calls audit_free() after cleanup_signal() (frees ->signal),
but in that case context->in_syscall can't be true, so audit_log_exit()
is not called, yes ?

Oleg.

