Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUJKVoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUJKVoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269283AbUJKVog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:44:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58357 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269277AbUJKVoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:44:22 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Daniel Walker" <dwalker@mvista.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <abatyrshin@ru.mvista.com>, <amakarov@ru.mvista.com>,
       <emints@ru.mvista.com>, <ext-rt-dev@mvista.com>, <hzhang@ch.mvista.com>,
       <yyang@ch.mvista.com>
Subject: RE: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Mon, 11 Oct 2004 14:44:36 -0700
Message-ID: <EOEGJOIIAIGENMKBPIAEAEIDDKAA.sdietrich@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041011204959.GB16366@elte.hu>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think Daniel has some separate thoughts,
here are mine:

Regarding the list walking stuff:

There are a lot of hashing options, indexing,
etc. that could be done. We thought of it 
as a future optimization. An easy fix would
be to insert RT processes at the front, non-RT
from the tail of the queue.


Regarding patch size: clearly this is
an issue. We are working on creating a
good map of spinlock nestings, to help
with this. 

Will publish that ASAP. 


IMO the number of raw_spinlocks should be 
lower, I said teens before. 

Theoretically, it should only need to be
around hardware registers and some memory maps
and cache code, plus interrupt controller
and other SMP-contended hardware.

Practically, its an efficiency judgement call.
Its not worth blocking for 5 instructions in
a critical section under any circumstance,
so the deepest nested locks should probably remain
spinlocks.

There are some concurrency issues in kernel threads,
and I think there is a lot of work here. 
The abstraction for LOCK_OPS is a good alternative,
but like the spin_undefs, its difficult to tell
in the code whether you are dealing with a mutex
or a spinlock. 

Regarding the use of the system semaphore:
We have WIP on PMUTEX modified to use atomic_t, 
thereby eliminating the assembly for instant 
portability.

Its slow, but optimizations are allowed for.

Of course for actual portability the 
IRQ threads must also be running on those
other platforms.

Your IRQ abstraction is ideal for that.

Eventually, I think that we will see
optimization - the last touches would have 
the final mutex code converted back to 
assembly, for performance reasons.

There are a whole lot of caveats and race
conditions that have not yet been unearthed
by the brief LKML testing. A lot of them
have to do with wakeups of tasks blocked
on a mutex, and differentiating between
blocked "ready" and blocked "mutex" states. 
Here the system semaphore may have an advantage.

With that, maybe we can work back towards
the abstraction, so that we can evaluate both
solutions for their specific advantages. 
 
I'll have to take a look at the new T4 patch
in detail, but at first glance it seems
that both mutexes could coexist in the 
abstraction.

We'll give it a test run, and look forward to
your thoughts.

Thanks,

Sven


> -----Original Message-----
> From: Ingo Molnar [mailto:mingo@elte.hu]
> Sent: Monday, October 11, 2004 1:50 PM
> To: Daniel Walker
> Cc: Andrew Morton; sdietrich@mvista.com; linux-kernel@vger.kernel.org;
> abatyrshin@ru.mvista.com; amakarov@ru.mvista.com; emints@ru.mvista.com;
> ext-rt-dev@mvista.com; hzhang@ch.mvista.com; yyang@ch.mvista.com
> Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
> 
> 
> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Sun, 2004-10-10 at 14:59, Ingo Molnar wrote:
> > > * Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > Lockmeter gets in the way of all this activity in a big way.  I'll
> > > > drop it.
> > > 
> > > great. Daniel, would you mind to merge your patchkit against the
> > > following base:
> > > 
> > > 	-mm3, minus lockmeter, plus the -T3 patch
> > 
> > 
> > No problem. Next release will be without lockmeter. Thanks for the
> > patches.
> 
> what do you think about the PREEMPT_REALTIME stuff in -T4? Ideally, if
> you agree with the generic approach, the next step would be to add your
> priority inheritance handling code to Linux semaphores and
> rw-semaphores. The sched.c bits for that looked pretty straightforward.
> The list walking is a bit ugly but probably unavoidable - the only other
> option would be 100 priority queues per semaphore -> yuck.
> 
> 	Ingo
> 
