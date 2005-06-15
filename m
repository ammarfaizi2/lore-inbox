Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVFORae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFORae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFORae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:30:34 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:57245 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261238AbVFORa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:30:28 -0400
Message-ID: <42B067BD.F4526CD@tv-sign.ru>
Date: Wed, 15 Jun 2005 21:39:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>
> +	try_again:
>  		spin_lock_irq(&tsk->sighand->siglock);
>  		interval = tsk->signal->it_real_incr;
>  		val = it_real_value(tsk->signal);
> -		if (val)
> +		if (val) {
> +			spin_unlock_irq(&tsk->sighand->siglock);
>  			del_timer_sync(&tsk->signal->real_timer);
> +			goto try_again;

I think we don't need del_timer_sync() at all, just del_timer().

Because it_real_value() returns 0 when timer is not pending. And
in this case the timer may still be running, but do_setitimer()
doesn't call del_timer_sync().

Oleg.
