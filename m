Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264423AbRFIRdQ>; Sat, 9 Jun 2001 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264427AbRFIRdH>; Sat, 9 Jun 2001 13:33:07 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2574 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264423AbRFIRc4>; Sat, 9 Jun 2001 13:32:56 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
Date: 9 Jun 2001 10:32:48 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9ftmk0$pdh$1@penguin.transmeta.com>
In-Reply-To: <200106090759.AAA15771@csl.Stanford.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200106090759.AAA15771@csl.Stanford.EDU>,
Dawson Engler  <engler@csl.Stanford.EDU> wrote:
>
>we're starting to develop a checker that finds deadlocks by (1)
>computing all lock acquisition paths and (2) checking if two paths
>violate a partial order.

Looks good. 

>The checker is pretty primitive.  In particular:
>	- lots of false negatives come from the fact that it does not 
>	  track interrupt disabling.  A missed deadlock:
>		foo acquires A
>		bar interrupts foo, disables interrupts, tries to acquire A
>	  (Is this the most common deadlock?)

You actually find something like this at all? I would have assumed that
you would never see this as a path, as interrupts aren't explicit calls.

>	- many potential false positives since it does not realize when
>	two kernel call traces are mutually exclusive.

On the other hand, they should be mutually exclusive only by virtue of
using some kind of locking, so this should show up in your locking order
thing.

The rule is

 - A -> B can deadlock with B -> A

BUT

 - A -> B -> C	cannot deadlock with A -> C -> B

by wirtue of "A" acting as the master lock.  So you should be able to
see these things (arguably the "cannot deadlock" case is still a very
ugly case, and also implies that B and C are irrelevant, as A already
took care of exclusivity.  So getting a warning for this might be fine). 

>To check it's mechanics I've enclosed what look to me to be two potential
>deadlocks --- given the limits of the tool and my understanding of what
>can happen when, these could be (likely be?) false positive, so I'd
>appreciate any corrective feedback.

They are, but for a very special reason: the big kernel lock is special.

The big kernel lock rules are that it's a "normal spinlock" in many
regards, BUT you can block while holding it, and the BKL will magically
be released during the blocking.  This means, for example, that the BKL
can never deadlock with a semaphore - if a BKL holder blocks on sombody
elses semaphore (and that somebody else wants the BKL), then the act of
blocking on the semaphore will release the BKL, and allow the original
semaphore holder to continue. 

The same is currently true of the global irq lock too (with the caveat
that we don't even re-aquire it after a schedule()), but that is going
to change, so I would suggest you _not_ special-case the global irq
lock.

But the big kernel lock is so special that I suspect it needs some
special casing to avoid too many false reports.

			Linus
