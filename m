Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWHOGkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWHOGkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWHOGkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:40:05 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:61675 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S965217AbWHOGkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:40:04 -0400
Date: Tue, 15 Aug 2006 15:03:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup and remove some extra spinlocks from rtmutex
Message-ID: <20060815110353.GA111@oleg>
References: <1154439588.25445.31.camel@localhost.localdomain> <20060813190326.GA2276@oleg> <Pine.LNX.4.64.0608142217400.10597@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608142217400.10597@frodo.shire>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Esben Nielsen wrote:
> 
> Well, we are talking about small optimizations now, moving only a few 
> instructions outside the lock. Except for one of them it is correct, but 
> it is worth risking stability for now?

Yes, optimization is small, but I think this cleanups the code, which is (imho)
more important. That said, I don't suggest this patch, it was a question. I stiil
can't find a time to read the code hard and convince myself I can understand it :)

Also, I think such a change opens the possibility for further cleanups.

> >--- 2.6.18-rc3/kernel/rtmutex.c~2_rtm	2006-08-13 19:07:45.000000000 +0400
> >+++ 2.6.18-rc3/kernel/rtmutex.c	2006-08-13 22:09:45.000000000 +0400
> >@@ -236,6 +236,10 @@ static int rt_mutex_adjust_prio_chain(st
> >		goto out_unlock_pi;
> >	}
> >
> >+	/* Release the task */
> >+	spin_unlock_irqrestore(&task->pi_lock, flags);
> >+	put_task_struct(task);
> >+
> 
> So you want the task to go away here and use it below?

task->pi_blocked_on != NULL, we hold task->pi_blocked_on->lock->wait_lock.
Can it go away ?

> 
> >	top_waiter = rt_mutex_top_waiter(lock);
> >
> >	/* Requeue the waiter */
> >@@ -243,10 +247,6 @@ static int rt_mutex_adjust_prio_chain(st
> >	waiter->list_entry.prio = task->prio;
> >	plist_add(&waiter->list_entry, &lock->wait_list);
> >
> >-	/* Release the task */
> >-	spin_unlock_irqrestore(&task->pi_lock, flags);
> >-	put_task_struct(task);
> >-
> 
> No! It is used in the line just above, so we better be sure it still 
> exists!

See above. If I am wrong, we can move this line

	waiter->list_entry.prio = task->prio;

up, under ->pi_lock. plist_del() doesn't need a valid ->prio.

Thanks for your answer!

Oleg.

