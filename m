Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270539AbRHHRcS>; Wed, 8 Aug 2001 13:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270532AbRHHRcI>; Wed, 8 Aug 2001 13:32:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20614 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S270537AbRHHRb5>;
	Wed, 8 Aug 2001 13:31:57 -0400
Importance: Normal
Subject: Re: [RFC][PATCH] Scalable Scheduling
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Kravetz <mkravetz@beaverton.ibm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF9CB2CBE.6FCCA7C5-ON85256AA2.005FE800@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 8 Aug 2001 13:32:40 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/08/2001 01:32:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, great input on the FLAME side, criticism accepted :-)

More importantly, we wanted to get some input (particular from you)
on whether our approach is actually an acceptable one, not
withstanding the #ifdef's :-),
These are easy to fix, but we wanted to follow up
on this topic after OLS ASAP, before the thoughts on this got lost due to
time.

We will clean this code up ASAP and resubmit.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Linus Torvalds <torvalds@transmeta.com> on 08/08/2001 12:40:07 PM

To:   Mike Kravetz <mkravetz@beaverton.ibm.com>
cc:   <linux-kernel@vger.kernel.org>
Subject:  Re: [RFC][PATCH] Scalable Scheduling




On Wed, 8 Aug 2001, Mike Kravetz wrote:
>
> I have been working on scheduler scalability.  Specifically,
> the concern is running Linux on bigger machines (higher CPU
> count, SMP only for now).

Note that there is no way I will ever apply this particular patch for a
very simple reason: #ifdef's in code.

Why do you have things like

     #ifdef CONFIG_SMP
          .. use nr_running() ..
     #else
          .. use nr_running ..
     #endif

and

     #ifdef CONFIG_SMP
            list_add(&p->run_list, &runqueue(task_to_runqueue(p)));
     #else
            list_add(&p->run_list, &runqueue_head);
     #endif

when it just shows that you did NOT properly abstract your thinking to
realize that the non-SMP case should be the same as the SMP case with 1
CPU (+ optimization).

I find code like the above physically disgusting.

What's wrong with using

     nr_running()

unconditionally, and make sure that it degrades gracefully to just the
single-CPU case?

What's wrong whit just using

     runqueue(task_to_runqueue(p))

and having the UP case realize that the "runqueue()" macro is a fixed
entry?

Same thing applies to that runqueue_lock stuff. That is some of the
ugliest code I've seen in a long time. Please use inline functions, sane
defines that work both ways, and take advantage of the fact that gcc will
optimize constant loops and numbers (it's ok to reference arrays in UP
with "array[smp_processor_id()]", and it's ok to have loops that look like
"for (i = 0; i < NR_CPUS; i++)" that will do the right thing on UP _and_
SMP.

And make your #ifdef's be _outside_ the code.

I hate code that has #ifdef's. It's a magjor design mistake, and shows
that the person who coded it didn't think of it as _one_ problem, but as
two.

So please spend some time cleaning it up, I can't look at it like this.

          Linus




