Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTH0SV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTH0SV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 14:21:57 -0400
Received: from postman4.arcor-online.net ([151.189.0.189]:58790 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261999AbTH0SVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 14:21:55 -0400
Date: Wed, 27 Aug 2003 20:21:49 +0200
From: Juergen Quade <quade@hsnr.de>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030827182149.GA23439@hsnr.de>
References: <20030825141133.GA17305@hsnr.de> <Pine.LNX.4.44.0308252233480.31393-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308252233480.31393-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	   Thanx for ur inputs. I think that I am missing something in ur 
> explanation. Can u please elaborate. In the meantime, the approach that I 

Maybe it is easier we make it the other way round.
If you look at the code of tasklet_kill:

	void tasklet_kill(struct tasklet_struct *t)
	{
		if (in_interrupt())
			printk("Attempt to kill tasklet from interrupt\n");

		while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
			do
				yield();
			while (test_bit(TASKLET_STATE_SCHED, &t->state));
		}
		tasklet_unlock_wait(t);
		clear_bit(TASKLET_STATE_SCHED, &t->state);
	}

Can you explain me, what the last statement 
	clear_bit(TASKLET_STATE_SCHED, &t->state);
is for?

> will like is to have another state TASKLET_STATE_KILLED so the code 
> changes that need to be done are
> 
> void tasklet_kill(struct tasklet_struct *t)
> {
> 
>      ...
>      ...
>      /*
>       * Mark the tasklet as killed, so the next time around
>       * tasklet_action does not call the handler for this tasklet
>       */
>      set_bit(TASKLET_STATE_KILLED, &t->state);  	<-- ADDED
> ...
> 

What I don't like on this approach is, to add another flag (=state) to
the tasklet, which might make the world more complicated as necessary.
I will take some time to think about it, but can't do that today :-(

Beside this, if you can't use a function without looking
at the code and without experimenting with it, that
must lead to bugs! IMHO, here is a call for action.

            Juergen.
