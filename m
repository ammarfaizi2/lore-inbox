Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTHZFQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbTHZFQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:16:14 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:428 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S262600AbTHZFQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:16:04 -0400
Date: Mon, 25 Aug 2003 22:44:17 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Juergen Quade <quade@hsnr.de>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
In-Reply-To: <20030825141133.GA17305@hsnr.de>
Message-ID: <Pine.LNX.4.44.0308252233480.31393-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,
	   Thanx for ur inputs. I think that I am missing something in ur 
explanation. Can u please elaborate. In the meantime, the approach that I 
will like is to have another state TASKLET_STATE_KILLED so the code 
changes that need to be done are

void tasklet_kill(struct tasklet_struct *t)
{

     ...
     ...
     /*
      * Mark the tasklet as killed, so the next time around
      * tasklet_action does not call the handler for this tasklet
      */
     set_bit(TASKLET_STATE_KILLED, &t->state);  	<-- ADDED

     while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
             current->state = TASK_RUNNING;
             do
                     sys_sched_yield();
             while (test_bit(TASKLET_STATE_SCHED, &t->state));
     }  
     ...
     ...
 }

Now inside tasklet_action if the state is killed we will not call the 
tasklet handler, thus not giving recursive tasklets to again schedule.

static void tasklet_action(struct softirq_action *a)
{
     ...
     ...
     if (!atomic_read(&t->count)) {
             if(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) 
                     BUG();
	     /*
	      * If the tasklet_kill has been called for this tasklet,
	      * don't run it again, else we have a hang
	      */
	     if(!test_bit(TASKLET_STATE_KILLED, &t->state))     <-- ADDED
             	t->func(t->data);
             tasklet_unlock(t);
             continue;
     }
     ...
     ...
 }




Thanx
tomar



On Mon, 25 Aug 2003, Juergen Quade wrote:

> > Hi,
> > 	While going thru the code for tasklet_kill(), I cannot figure
> out 
> > how recursive tasklets (tasklets that schedule themselves from within 
> > their tasklet handler) can be killed by this function. To me it looks
> that 
> > tasklet_kill will never complete for such tasklets.
> 
> It is realy a sophisticated piece of code! I think it is not
> the only bug you found. Some weeks ago I pointed out another
> problem with tasklet_kill but got no answer.
> 
> To work our questions out is not done in just 1 minute :-(
> And I was not able to find the person, who is responsible for the code.
> 
> As far as I can see, you missed nothing.
> The tasklet enters itself to the "task_vec" list, because the
> SCHED-Bit is always resetted, when "tasklet_schedule" is called.
> It will always succeed.
> 
> Maybe you have a look to another (my) problem:
> 
> The function "tasklet_schedule" schedules a tasklet only, if the
> SCHED-Bit
> ist _not_ set. So the trick is, to _set_ the SCHED-Bit and
> to _not_ enter the tasklet in the "task_vec" list (ok, you showed
> that this trick can fail). But anyway, if you look at the
> code, tasklet_kill resets the bit in any case!!! It would have to
> set the bit, not to reset it. Any comments?
> 
> void tasklet_kill(struct tasklet_struct *t)
> {
> 	...
> 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> 		do
> 			yield();
> 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
> 	}
> 	tasklet_unlock_wait(t);
> 	clear_bit(TASKLET_STATE_SCHED, &t->state);
> }
> 
> 
> > void tasklet_kill(struct tasklet_struct *t)
> > {
> > 	...
> >  	...
> > 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> > 		current->state = TASK_RUNNING;
> > 		do
> > 			sys_sched_yield();
> > 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
> > 	}
> > 	...
> > 	...
> > }
> > 
> > The above while loop will only exit if TASKLET_STATE_SCHED is not set 
> > (tasklet is not scheduled).
> > Now if we see tasklet_action
> > 
> > static void tasklet_action(struct softirq_action *a)
> > {
> > 	...
> > 	...
> > 	if (!atomic_read(&t->count)) {
> > 	--> TASKLET_STATE_SCHED is set here
> > 		if(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> > 			BUG();
> > 		t->func(t->data);
> > 	--> if we schedule the tasklet inside its handler, 
> > 	--> TASKLET_STATE_SCHED will be set here also
> > 		tasklet_unlock(t);
> > 		continue;
> > 	}
> > 	...
> > 	...
> > }
> > 
> > The only small window when TASKLET_STATE_SCHED is not set is between
> the 
> > time when test_and_clear_bit above clears it and by the time the
> tasklet 
> > handler again calls tasklet_schedule(). But since tasklet_kill is
> called 
> > from user context the while loop in tasklet_kill checking for 
> > TASKLET_STATE_SCHED to be cleared  cannot interleave between the above
> two 
> > lines in tasklet_action and hence tasklet_kill will never come out of
> the 
> > while loop.
> > This is true only for UP machines.
> > 
> > Pleae point me out if I am missing something.
> > 
> > Thanx
> > tomar
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

