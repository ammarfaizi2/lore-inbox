Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754411AbWKMKlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbWKMKlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbWKMKlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:41:05 -0500
Received: from mx03.stofanet.dk ([212.10.10.13]:49538 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S1754411AbWKMKlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:41:02 -0500
Date: Mon, 13 Nov 2006 11:39:27 +0100 (CET)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/5] Fix timeout bug in rtmutex in 2.6.18-rt
In-Reply-To: <20061110180252.GA25694@elte.hu>
Message-ID: <Pine.LNX.4.64.0611131057000.13569@frodo.shire>
References: <20061001112829.630288000@frodo> <Pine.LNX.4.64.0610011336400.29459@frodo.shire>
 <20061110144916.GA19152@elte.hu> <20061110161657.GA19407@elte.hu>
 <20061110180252.GA25694@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006, Ingo Molnar wrote:

>
> on SMP i had to remove this assert:
>
> Index: linux/kernel/rtmutex.c
> ===================================================================
> --- linux.orig/kernel/rtmutex.c
> +++ linux/kernel/rtmutex.c
> @@ -823,7 +823,7 @@ rt_spin_lock_slowunlock(struct rt_mutex
> 	}
> 	wakeup_next_waiter(lock, 1);
> 	spin_unlock_irqrestore(&lock->wait_lock, flags);
> -	BUG_ON(current->boosting_prio != MAX_PRIO);
> +//	BUG_ON(current->boosting_prio != MAX_PRIO);
> 	/* Undo pi boosting.when necessary */
> 	rt_mutex_adjust_prio(current);
> }
>
> because it triggered almost immediately after bootup.
>


Hmm, boosting_prio should be MAX_PRIO at that point. boosting_prio should
only be different from MAX_PRIO while a task is trying to lock a mutex - 
i.e. while it is in a *_slowlock() function.

On which kernel have you applied the patch?


I am looking at 2.6.18-rt6 and trying to see if there is a race conditions.
I can't see it that easily (or I would probably have seen it already :-). 
task->boosting_prio is not set when task->pi_lock is not taken. And then 
it is only set to something else than MAX_PRIO if task->pi_blocked_on is 
set.


> 	Ingo
>

Esben
