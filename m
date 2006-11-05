Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWKEWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWKEWyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWKEWyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:54:20 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:57298 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1422791AbWKEWx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:53:56 -0500
Date: Mon, 6 Nov 2006 01:53:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
Message-ID: <20061105225338.GA3122@oleg>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05, Linus Torvalds wrote:
> 
> 
> On Sun, 5 Nov 2006, Oleg Nesterov wrote:
> >
> > When task->array != NULL, try_to_wake_up() just goes to "out_running" and sets
> > task->state = TASK_RUNNING.
> > 
> > In that case hrtimer_wakeup() does:
> > 
> > 	timeout->task = NULL;		<----- [1]
> > 
> > 	spin_lock(runqueues->lock);
> > 
> > 	task->state = TASK_RUNNING;	<----- [2]
> > 
> > from Documentation/memory-barriers.txt
> > 
> > 	Memory operations that occur before a LOCK operation may appear to
> > 	happen after it completes.
> > 
> > This means that [2] may be completed before [1], and
> 
> Yes. On x86 (and x86-64) you'll never see this, because writes are always 
> seen in order regardless, and in addition, the spin_lock is actually 
> totally serializing anyway. On most other architectures, the spin_lock 
> will serialize all the writes too, but it's not guaranteed, so in theory 
> you're right. I suspect no actual architecture will do this, but hey, 
> when talking memory ordering, safe is a lot better than sorry.
> 
> That said, since "task->state" in only tested _inside_ the runqueue lock, 
> there is no race that I can see. Since we've gotten the runqueue lock in 
> order to even check task-state, the processor that _sets_ task state must 
> not only have done the "spin_lock()", it must also have done the 
> "spin_unlock()", and _that_ will not allow either the timeout or the task 
> state to haev leaked out from under it (because that would imply that the 
> critical region leaked out too).
> 
> So I don't think the race exists anyway - the schedule() will return 
> immediately (because it will see TASK_RUNNING), and we'll just retry.

schedule() will see TASK_INTERRUPTIBLE. hrtimer_wakeup() sets TASK_RUNNING,
rt_mutex_slowlock() does set_current_state(TASK_INTERRUPTIBLE) after that.
schedule() takes runqueue lock, yes, but we are testing timeout->task before.

Oleg.

