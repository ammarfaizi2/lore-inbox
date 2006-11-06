Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423329AbWKFDIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423329AbWKFDIy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 22:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423333AbWKFDIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 22:08:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423329AbWKFDIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 22:08:53 -0500
Date: Sun, 5 Nov 2006 19:08:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0611051906040.25218@g5.osdl.org>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
 <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Steven Rostedt wrote:
> 
> This whole situation is very theoretical, but I think this actually can
> happen *theoretically*.
> 
> OK, the spin_lock doesn't do any serialization, but the unlock does. But
> the problem can happen before the unlock. Because of the loop.
> 
> CPU 1                                    CPU 2
> 
>     task_rq_lock()
> 
>     p->state = TASK_RUNNING;
> 
> 
>                                       (from bottom of for loop)
>                                       set_current_state(TASK_INTERRUPTIBLE);
> 
>                                     for (;;) {  (looping)
> 
>                                       if (timeout && !timeout->task)
> 
> 
>    (now CPU implements)
>    t->task = NULL
> 
>    task_rq_unlock();
> 
>                                    schedule() (with state == TASK_INTERRUPTIBLE)

Yeah, that seems a real bug. You _always_ need to actually do the thing 
that you wait for _before_ you want it up. That's what all the scheduling 
primitives depend on - you can't wake people up first, and then set the 
condition variable.

So if a rt_mutex depeds on something that is set inside the rq-lock, it 
needs to get the task rw-lock in order to check it.

		Linus
