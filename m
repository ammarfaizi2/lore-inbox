Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131025AbRCTWH4>; Tue, 20 Mar 2001 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRCTWHr>; Tue, 20 Mar 2001 17:07:47 -0500
Received: from nrg.org ([216.101.165.106]:5224 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131025AbRCTWHb>;
	Tue, 20 Mar 2001 17:07:31 -0500
Date: Tue, 20 Mar 2001 14:06:46 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Roger Larsson <roger.larsson@norran.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <01032019253200.01487@jeloin>
Message-ID: <Pine.LNX.4.05.10103201333590.26772-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Roger Larsson wrote:
> One little readability thing I found.
> The prev->state TASK_ value is mostly used as a plain value
> but the new TASK_PREEMPTED is or:ed together with whatever was there.
> Later when we switch to check the state it is checked against TASK_PREEMPTED
> only. Since TASK_RUNNING is 0 it works OK but...

Yes, you're right.  I had forgotten that TASK_RUNNING is 0 and I think I
was assuming that there could be (rare) cases where a task was preempted
while prev->state was in transition such that no other flags were set.
This is, of course, impossible given that TASK_RUNNING is 0.  So your
change makes the common case more obvious (to me, at least!)

> --- sched.c.nigel       Tue Mar 20 18:52:43 2001
> +++ sched.c.roger       Tue Mar 20 19:03:28 2001
> @@ -553,7 +553,7 @@
>  #endif
>                         del_from_runqueue(prev);
>  #ifdef CONFIG_PREEMPT
> -               case TASK_PREEMPTED:
> +               case TASK_RUNNING | TASK_PREEMPTED:
>  #endif
>                 case TASK_RUNNING:
>         }
> 
> 
> We could add all/(other common) combinations as cases 
> 
> 	switch (prev->state) {
> 		case TASK_INTERRUPTIBLE:
> 			if (signal_pending(prev)) {
> 				prev->state = TASK_RUNNING;
> 				break;
> 			}
> 		default:
> #ifdef CONFIG_PREEMPT
> 			if (prev->state & TASK_PREEMPTED)
> 				break;
> #endif
> 			del_from_runqueue(prev);
> #ifdef CONFIG_PREEMPT
> 		case TASK_RUNNING		| TASK_PREEMPTED:
> 		case TASK_INTERRUPTIBLE	| TASK_PREEMPTED:
> 		case TASK_UNINTERRUPTIBLE	| TASK_PREEMPTED:
> #endif
> 		case TASK_RUNNING:
> 	}
> 
> 
> Then the break in default case could almost be replaced with a BUG()...
> (I have not checked the generated code)

The other cases are not very common, as they only happen if a task is
preempted during the short time that it is running while in the process
of changing state while going to sleep or waking up, so the default case
is probably OK for them; and I'd be happier to leave the default case
for reliability reasons anyway.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

