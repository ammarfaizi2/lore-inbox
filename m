Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbTH1Fv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTH1Ft4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:49:56 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:8089 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263734AbTH1Fst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:48:49 -0400
Date: Wed, 27 Aug 2003 23:16:52 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Juergen Quade <quade@hsnr.de>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
In-Reply-To: <20030827182149.GA23439@hsnr.de>
Message-ID: <Pine.LNX.4.44.0308272259120.13148-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen,
	The whole tasklet_kill function is a big confusion. It is a big 
misnomer as Werner rightly said. For non-recursive tasklets this  
function does not do anything. Its just an expensive "nop". If you simply 
call tasklet_schedule after tasklet_kill, it will execute as nothing had
happened. 
If we remove the line 

clear_bit(TASKLET_STATE_SCHED, &t->state);

from tasklet_kill then tasklet_kill will have the desired effect of 
"killing" the tasklet, tasklet_schedule() after tasklet_kill in that case, 
will not call __tasklet_kill and hence it will not be queued to the CPU
queue and hence it will not run (desired effect).

tasklet_kill I believe was written to kill recursive tasklets only 
(tasklets that schedule themseves from inside their handler), but as we 
have seen for that particular case it hangs. 
I feel either we remove tasklet_kill or fix it to do what it should.

Alexey, can u please comment on my observations.

Thanx,
tomar



On Wed, 27 Aug 2003, Juergen Quade wrote:

> > 	   Thanx for ur inputs. I think that I am missing something in
> ur 
> > explanation. Can u please elaborate. In the meantime, the approach
> that I 
> 
> Maybe it is easier we make it the other way round.
> If you look at the code of tasklet_kill:
> 
> 	void tasklet_kill(struct tasklet_struct *t)
> 	{
> 		if (in_interrupt())
> 			printk("Attempt to kill tasklet from
> interrupt\n");
> 
> 		while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
> {
> 			do
> 				yield();
> 			while (test_bit(TASKLET_STATE_SCHED,
> &t->state));
> 		}
> 		tasklet_unlock_wait(t);
> 		clear_bit(TASKLET_STATE_SCHED, &t->state);
> 	}
> 
> Can you explain me, what the last statement 
> 	clear_bit(TASKLET_STATE_SCHED, &t->state);
> is for?
> 
> > will like is to have another state TASKLET_STATE_KILLED so the code 
> > changes that need to be done are
> > 
> > void tasklet_kill(struct tasklet_struct *t)
> > {
> > 
> >      ...
> >      ...
> >      /*
> >       * Mark the tasklet as killed, so the next time around
> >       * tasklet_action does not call the handler for this tasklet
> >       */
> >      set_bit(TASKLET_STATE_KILLED, &t->state);  	<-- ADDED
> > ...
> > 
> 
> What I don't like on this approach is, to add another flag (=state) to
> the tasklet, which might make the world more complicated as necessary.
> I will take some time to think about it, but can't do that today :-(
> 
> Beside this, if you can't use a function without looking
> at the code and without experimenting with it, that
> must lead to bugs! IMHO, here is a call for action.
> 
>             Juergen.
> 

