Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTHYN5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTHYNz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:55:58 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:60840 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261877AbTHYNzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:55:13 -0400
Date: Mon, 25 Aug 2003 07:23:22 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
In-Reply-To: <Pine.LNX.4.44.0308250518380.26988-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0308250722400.26988-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to mention my kernel version.
It is 2.14.18-14 (RH-8.0 stock kernel)

Thanx
tomar

On Mon, 25 Aug 2003, Tomar, Nagendra wrote:

> Hi,
> 	While going thru the code for tasklet_kill(), I cannot figure
> out 
> how recursive tasklets (tasklets that schedule themselves from within 
> their tasklet handler) can be killed by this function. To me it looks
> that 
> tasklet_kill will never complete for such tasklets.
> 
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
> 
> time when test_and_clear_bit above clears it and by the time the tasklet
> 
> handler again calls tasklet_schedule(). But since tasklet_kill is called
> 
> from user context the while loop in tasklet_kill checking for 
> TASKLET_STATE_SCHED to be cleared  cannot interleave between the above
> two 
> lines in tasklet_action and hence tasklet_kill will never come out of
> the 
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
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

