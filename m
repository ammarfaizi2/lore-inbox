Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWKEW3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWKEW3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWKEW3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:29:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422744AbWKEW3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:29:53 -0500
Date: Sun, 5 Nov 2006 14:29:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <20061105193457.GA3082@oleg>
Message-ID: <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
References: <20061105193457.GA3082@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Oleg Nesterov wrote:
>
> When task->array != NULL, try_to_wake_up() just goes to "out_running" and sets
> task->state = TASK_RUNNING.
> 
> In that case hrtimer_wakeup() does:
> 
> 	timeout->task = NULL;		<----- [1]
> 
> 	spin_lock(runqueues->lock);
> 
> 	task->state = TASK_RUNNING;	<----- [2]
> 
> from Documentation/memory-barriers.txt
> 
> 	Memory operations that occur before a LOCK operation may appear to
> 	happen after it completes.
> 
> This means that [2] may be completed before [1], and

Yes. On x86 (and x86-64) you'll never see this, because writes are always 
seen in order regardless, and in addition, the spin_lock is actually 
totally serializing anyway. On most other architectures, the spin_lock 
will serialize all the writes too, but it's not guaranteed, so in theory 
you're right. I suspect no actual architecture will do this, but hey, 
when talking memory ordering, safe is a lot better than sorry.

That said, since "task->state" in only tested _inside_ the runqueue lock, 
there is no race that I can see. Since we've gotten the runqueue lock in 
order to even check task-state, the processor that _sets_ task state must 
not only have done the "spin_lock()", it must also have done the 
"spin_unlock()", and _that_ will not allow either the timeout or the task 
state to haev leaked out from under it (because that would imply that the 
critical region leaked out too).

So I don't think the race exists anyway - the schedule() will return 
immediately (because it will see TASK_RUNNING), and we'll just retry.

		Linus
