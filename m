Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWDJNqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWDJNqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWDJNqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:46:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:52696 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751000AbWDJNqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:46:45 -0400
Date: Mon, 10 Apr 2006 21:43:46 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
Message-ID: <20060410174346.GA100@oleg>
References: <434E906E.85BD86BF@tv-sign.ru> <20060410013651.4D1791809D1@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410013651.4D1791809D1@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Roland McGrath wrote:
>
> [PATCH] Fix race between exec and fatal signals

I'll try to study this patch carefully tomorrow, but now I have
the feeling it is not right (probably my misunderstanding after
the quick reading).

> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -606,15 +606,16 @@ static int de_thread(struct task_struct 
>
> ... [snip] ...
>
> -	zap_other_threads(current);
> +	zap_other_threads(current, SIGNAL_GROUP_EXEC);
>
> ... [snip] ...
>
> -void zap_other_threads(struct task_struct *p)
> +void zap_other_threads(struct task_struct *p, int flag)
>  {
>  	struct task_struct *t;
>
> -	p->signal->flags = SIGNAL_GROUP_EXIT;
> +	if (unlikely(p->signal->flags & SIGNAL_GROUP_EXEC)) {
> +		/*
> +		 * We are cancelling an exec that is in progress, to let
> +		 * the thread group die instead.  We need to wake the
> +		 * exec'ing thread up from uninterruptible wait.
> +		 */
> +		BUG_ON(flag != SIGNAL_GROUP_EXIT);
> +		t = p->signal->group_exit_task;
> +		p->signal->group_exit_task = NULL;
> +		p->signal->notify_count = 0;
> +		wake_up_process(t);
> +	}
> +
> +	p->signal->flags = flag;
>  	p->signal->group_stop_count = 0;

So, de_thread() sets SIGNAL_GROUP_EXEC and sends SIGKILL to other thereads.

Sub-thread receives the signal, and calls get_signal_to_deliver->do_group_exit.
do_group_exit() calls zap_other_threads(SIGNAL_GROUP_EXIT) because there is no
SIGNAL_GROUP_EXIT set. zap_other_threads() notices SIGNAL_GROUP_EXEC, wakes up
execer, and changes ->signal->flags to SIGNAL_GROUP_EXIT.

de_thread() re-locks sighand, sees !SIGNAL_GROUP_EXEC and goes to 'dying:'.

No?

Another problem. de_thread() sets '->group_exit_task = current' _only_ if
'atomic_read(&sig->count) > count', so wake_up_process(->group_exit_task)
in zap_other_threads() is unsafe.

Oleg.

