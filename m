Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSIFPX0>; Fri, 6 Sep 2002 11:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSIFPX0>; Fri, 6 Sep 2002 11:23:26 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:15114 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S318714AbSIFPXY>; Fri, 6 Sep 2002 11:23:24 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Jacobowitz <dan@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
References: <Pine.LNX.4.44.0209060058040.20904-100000@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 07 Sep 2002 00:27:39 +0900
In-Reply-To: <Pine.LNX.4.44.0209060058040.20904-100000@localhost.localdomain>
Message-ID: <87vg5j2l5g.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> i've attached a combined patch of your two patches, against BK-curr. Looks
> good to me, and since it passed your more complex ptrace tests ...
> 
> 	Ingo
> 
> --- linux/kernel/exit.c.orig	Fri Sep  6 00:55:02 2002
> +++ linux/kernel/exit.c	Fri Sep  6 00:57:58 2002
> @@ -66,6 +66,11 @@
>  	atomic_dec(&p->user->processes);
>  	security_ops->task_free_security(p);
>  	free_uid(p->user);
> +	if (unlikely(p->ptrace)) {
> +		write_lock_irq(&tasklist_lock);
> +		__ptrace_unlink(p);
> +		write_unlock_irq(&tasklist_lock);
> +	}
>  	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));

Looks like it's need the only CLONE_DETACH process. Why it's here?

	 * Search them and reparent children.
	 */
	list_for_each(_p, &father->children) {
		p = list_entry(_p,struct task_struct,sibling);
		reparent_thread(p, reaper, child_reaper);
	}

Looks like that tracer deprive a process from real parent.

	list_for_each(_p, &father->ptrace_children) {
		p = list_entry(_p,struct task_struct,ptrace_list);
		reparent_thread(p, reaper, child_reaper);
	}

Thread group makes the child which links both ->children and
->ptrace_children.

>  {
> -	ptrace_unlink(p);
> -	list_del_init(&p->sibling);
> -	p->ptrace = 0;
> +	/* If we were tracing the thread, release it; otherwise preserve the
> +	   ptrace links.  */
> +	if (unlikely(traced)) {
> +		task_t *trace_task = p->parent;
> +		__ptrace_unlink(p);
> +		p->ptrace = 1;

Unexpected change of ptrace flag.

> +		__ptrace_link(p, trace_task);
> +	} else {
> +		p->ptrace = 0;
> +		list_del_init(&p->sibling);
> +		p->parent = p->real_parent;
> +		list_add_tail(&p->sibling, &p->parent->children);

Looks like that tracing child still link ->ptrace_list.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
