Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbRCTWcr>; Tue, 20 Mar 2001 17:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCTWci>; Tue, 20 Mar 2001 17:32:38 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:8275 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131231AbRCTWcZ>; Tue, 20 Mar 2001 17:32:25 -0500
Message-ID: <3AB7D949.FC508065@mvista.com>
Date: Tue, 20 Mar 2001 14:27:21 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10103201333590.26772-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Tue, 20 Mar 2001, Roger Larsson wrote:
> > One little readability thing I found.
> > The prev->state TASK_ value is mostly used as a plain value
> > but the new TASK_PREEMPTED is or:ed together with whatever was there.
> > Later when we switch to check the state it is checked against TASK_PREEMPTED
> > only. Since TASK_RUNNING is 0 it works OK but...
> 
> Yes, you're right.  I had forgotten that TASK_RUNNING is 0 and I think I
> was assuming that there could be (rare) cases where a task was preempted
> while prev->state was in transition such that no other flags were set.
> This is, of course, impossible given that TASK_RUNNING is 0.  So your
> change makes the common case more obvious (to me, at least!)
> 
> > --- sched.c.nigel       Tue Mar 20 18:52:43 2001
> > +++ sched.c.roger       Tue Mar 20 19:03:28 2001
> > @@ -553,7 +553,7 @@
> >  #endif
> >                         del_from_runqueue(prev);
> >  #ifdef CONFIG_PREEMPT
> > -               case TASK_PREEMPTED:
> > +               case TASK_RUNNING | TASK_PREEMPTED:
> >  #endif
> >                 case TASK_RUNNING:
> >         }
> >
> >
> > We could add all/(other common) combinations as cases
> >
> >       switch (prev->state) {
> >               case TASK_INTERRUPTIBLE:
> >                       if (signal_pending(prev)) {
> >                               prev->state = TASK_RUNNING;
> >                               break;
> >                       }
> >               default:
> > #ifdef CONFIG_PREEMPT
> >                       if (prev->state & TASK_PREEMPTED)
> >                               break;
> > #endif
> >                       del_from_runqueue(prev);
> > #ifdef CONFIG_PREEMPT
> >               case TASK_RUNNING               | TASK_PREEMPTED:
> >               case TASK_INTERRUPTIBLE | TASK_PREEMPTED:
> >               case TASK_UNINTERRUPTIBLE       | TASK_PREEMPTED:
> > #endif
> >               case TASK_RUNNING:
> >       }
> >
> >
> > Then the break in default case could almost be replaced with a BUG()...
> > (I have not checked the generated code)
> 
> The other cases are not very common, as they only happen if a task is
> preempted during the short time that it is running while in the process
> of changing state while going to sleep or waking up, so the default case
> is probably OK for them; and I'd be happier to leave the default case
> for reliability reasons anyway.

Especially since he forgot:

TASK_ZOMBIE
TASK_STOPPED
TASK_SWAPPING

I don't know about the last two but TASK_ZOMBIE must be handled
correctly or the task will never clear.

In general, a task must run till it gets to schedule() before the actual
state is "real" so the need for the TASK_PREEMPT.  

The actual code generated with what you propose should be the same (even
if TASK_RUNNING != 0, except for the constant).

George
