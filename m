Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTHYOOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTHYOOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:14:40 -0400
Received: from postman4.arcor-online.net ([151.189.0.189]:12781 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261946AbTHYOOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:14:25 -0400
Date: Mon, 25 Aug 2003 16:11:33 +0200
From: Juergen Quade <quade@hsnr.de>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030825141133.GA17305@hsnr.de>
References: <Pine.LNX.4.44.0308250518380.26988-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308250518380.26988-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 	While going thru the code for tasklet_kill(), I cannot figure out 
> how recursive tasklets (tasklets that schedule themselves from within 
> their tasklet handler) can be killed by this function. To me it looks that 
> tasklet_kill will never complete for such tasklets.

It is realy a sophisticated piece of code! I think it is not
the only bug you found. Some weeks ago I pointed out another
problem with tasklet_kill but got no answer.

To work our questions out is not done in just 1 minute :-(
And I was not able to find the person, who is responsible for the code.

As far as I can see, you missed nothing.
The tasklet enters itself to the "task_vec" list, because the
SCHED-Bit is always resetted, when "tasklet_schedule" is called.
It will always succeed.

Maybe you have a look to another (my) problem:

The function "tasklet_schedule" schedules a tasklet only, if the SCHED-Bit
ist _not_ set. So the trick is, to _set_ the SCHED-Bit and
to _not_ enter the tasklet in the "task_vec" list (ok, you showed
that this trick can fail). But anyway, if you look at the
code, tasklet_kill resets the bit in any case!!! It would have to
set the bit, not to reset it. Any comments?

void tasklet_kill(struct tasklet_struct *t)
{
	...
	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
		do
			yield();
		while (test_bit(TASKLET_STATE_SCHED, &t->state));
	}
	tasklet_unlock_wait(t);
	clear_bit(TASKLET_STATE_SCHED, &t->state);
}


> void tasklet_kill(struct tasklet_struct *t)
> {
> 	...
>  	...
> 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> 		current->state = TASK_RUNNING;
> 		do
> 			sys_sched_yield();
> 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
> 	}
> 	...
> 	...
> }
> 
> The above while loop will only exit if TASKLET_STATE_SCHED is not set 
> (tasklet is not scheduled).
> Now if we see tasklet_action
> 
> static void tasklet_action(struct softirq_action *a)
> {
> 	...
> 	...
> 	if (!atomic_read(&t->count)) {
> 	--> TASKLET_STATE_SCHED is set here
> 		if(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> 			BUG();
> 		t->func(t->data);
> 	--> if we schedule the tasklet inside its handler, 
> 	--> TASKLET_STATE_SCHED will be set here also
> 		tasklet_unlock(t);
> 		continue;
> 	}
> 	...
> 	...
> }
> 
> The only small window when TASKLET_STATE_SCHED is not set is between the 
> time when test_and_clear_bit above clears it and by the time the tasklet 
> handler again calls tasklet_schedule(). But since tasklet_kill is called 
> from user context the while loop in tasklet_kill checking for 
> TASKLET_STATE_SCHED to be cleared  cannot interleave between the above two 
> lines in tasklet_action and hence tasklet_kill will never come out of the 
> while loop.
> This is true only for UP machines.
> 
> Pleae point me out if I am missing something.
> 
> Thanx
> tomar
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
