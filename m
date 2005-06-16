Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFPHfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFPHfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFPHfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:35:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:51915 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261180AbVFPHfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:35:39 -0400
Message-ID: <42B12DD6.7028CBAE@tv-sign.ru>
Date: Thu, 16 Jun 2005 11:44:22 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
References: <42B067BD.F4526CD@tv-sign.ru>
		 <1118860623.4508.70.camel@localhost.localdomain> <1118864043.4508.81.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>
> So, timer_pending tests if timer->base is NULL, but here we see that
> timer->base IS NULL before the function is called, and as I have said
> earlier, the it_real_arm can be called on two CPUS simultaneously. So
> here's another patch that should fix this race condition too.
>
> [...]
>
> +		/*
> +		 * Call del_timer_sync unconditionally, since we don't
> +		 * know if it is running or not. We also need to unlock
> +		 * the siglock so that the it_real_fn called by ksoftirqd
> +		 * doesn't wait for us.
> +		 */
> +		spin_unlock(&tsk->sighand->siglock);
> +		del_timer_sync(&tsk->signal->real_timer);
> +		spin_lock(&tsk->sighand->siglock);

I don't think this is 100% correct. After del_timer_sync() returns another
thread can come and call do_setitimer() and re-arm the timer (because with
your patch we are dropping tsk->sighand->siglock here). So this patch does
not garantees that the timer is not queued/running after del_timer_sync(),
and the it_real_arm can be called on two CPUS simultaneously again.

There is a try_to_del_timer_sync() in the -mm tree which is suitable here:

	again:
		spin_lock_irq(&tsk->sighand->siglock);
		if (try_to_del_timer_sync(&tsk->signal->real_timer) < 0) {
			spin_unlock_irq(&tsk->sighand->siglock);
			goto again;
		}

Oleg.
