Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWFXUup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWFXUup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFXUup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 16:50:45 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:9622 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751095AbWFXUuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 16:50:44 -0400
Date: Sun, 25 Jun 2006 04:50:45 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
Message-ID: <20060625005045.GA155@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
>
> There is no need to hold tasklist_lock across the setscheduler call, when we
> pin the task structure with get_task_struct(). Interrupts are disabled in 
> setscheduler anyway and the permission checks do not need interrupts disabled.
>
> --- linux-2.6.17-mm.orig/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> +++ linux-2.6.17-mm/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> @@ -4140,8 +4140,10 @@
>  		read_unlock_irq(&tasklist_lock);
>  		return -ESRCH;
>  	}
> -	retval = sched_setscheduler(p, policy, &lparam);
> +	get_task_struct(p);
>  	read_unlock_irq(&tasklist_lock);
> +	retval = sched_setscheduler(p, policy, &lparam);
> +	put_task_struct(p);
>  	return retval;
>  }

But we don't need read_lock(tasklist) and get_task_struct(p) at all?

rcu_read_lock/rcu_read_unlock is enough, no?

Oleg.

