Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270939AbUJVDvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270939AbUJVDvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270856AbUJVDtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:49:24 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:28574 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S270937AbUJUVFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:05:16 -0400
Date: Thu, 21 Oct 2004 23:01:21 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Scott Wood <scott@timesys.com>
Cc: john cooper <john.cooper@timesys.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
In-Reply-To: <20041021184742.GB26530@yoda.timesys>
Message-Id: <Pine.OSF.4.05.10410212232050.26965-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Esben Nielsen
Work:
 Cotas Computer Technology A/S
 Paludan Mullersvej 82
 8200 Aarhus N 
Private
 Moellegade 7A, 3., 4
 8000 Aarhus C
Phone: 
 +45 86 12 73 79
Mobile:
 +45 27 13 10 05


On Thu, 21 Oct 2004, Scott Wood wrote:

> On Thu, Oct 21, 2004 at 02:09:19PM -0400, john cooper wrote:
> > Scott Wood wrote:
> > >If you keep it in priority order, then you're paying the O(n) cost
> > >every time you acquire a lock. 
> 
> I partially take this back; depending on how it's implemented, you
> can get away with only adding it to the list once contention occurs.
>

You can implement the full scheduler structure in each mutex. That would
be O(1) but would take take quite a lot of memory.

On the other hand a sorted list will not take more memory than now but
will appear to be O(n) when inserting into the list. However, on a UP
machine no lower priority task will run when higher priority tasks runs.
I.e. you will always add to the beginning of the list. That is assuming
ofcourse that nobody will sleep while holding a mutex - which is a bad
bahaviour. And if you try to take another mutex, while holding one already
and you have to block, the holder of the second mutex will be moved up to
your priority. I.e. it will block the CPU for any lower priority task...

I don't know what it would be on SMP systems though...

 
> > That's true for the case whe~re the current priority is
> > somewhere else handy (likely) and we don't need to traverse
> > the list for other reasons such as allowing/disallowing
> > recursive acquisition of a mutex by a given task.
> 
> How would maintaining priority order make it faster to check for
> recursive usage?  You'd be looking for a specific mutex rather than
> the highest priority blocker.  You could also check the per-mutex
> list of owners (which you'll need to implement PI on rwlocks), to
> avoid needing to add to the locks-held list in non-contended cases.
> 
> On uniprocessor, one may wish to turn rwlocks into recursive non-rw
> mutexes, where recursion checking would use a single owner field.
>


Why not use a simple counter? The mutex protects it's own memory area.
Anyway, I am not sure recursive acquisition is such a good idea: It will
make the mutex more expensive to use and promote sloppy coding where you
don't really know what mutexes are held right now. When you are building a
subsystem you can send around a flag in the argument saying whether you
have taken the lock or not. If you call into other systems, where you
can't add a parameter to each function, you should release your mutex(es)
anyway! I think it is better that the sloppy coder discoveres that he
deadlocks on himself before getting other sub-systems involved :-)

> Also, keeping it in priority order would introduce yet another place
> that assumes of a linear priority scheme.  At some point, it may be
> desireable to implement other schemes, such as maintaining per-CPU
> priorities to deal with inheriting from CPU-bound tasks without
> introducing said tasks' priorities on other CPUs.
>

I am not sure this at all make sense on a SMP system. For performance
reasons I think that one should stick to ordinary semaphores and in a lot
of places spin-locks on such a system. Even with a dedicated RTOS you have
to design your system from the bottum up to get a good real-time
behaviour - and it depends a lot on the application of which you can only
have one! That is very far from the world of SMP servers.

The ones who can use all the fancy mutexes are really embedded developer
(like myself) who need a robust RTOS but also drivers for a lot of
hardware, a good TCP/IP stack, firewall, good filesystems etc. which the
commercial vendors have a hard time delivering all at once. 

On the desktop it can lead to good performance of multimedia but as soon
as you want to use two applications, which considers themselves multimedia
and thus gives themselves high priority, it wont work.

I must also say, that from my perspective low latencies is not the issue.
The issue is predictability: I must be able to create threads and know
they can't all the sudden be preempted by all kinds of things. I.e. if I
give them higher priority than all the "normal" stuff and all shared
resources between my tasks and the "normal" stuff are locked with mutexes
using prirority inheritance and only for fixed amount of time, I am in the
clear. It is also important that all interrupts and spin-locks are only
held for a fixed amount of time - but as long as that time is lower than
the maximum latency and is bounded in occurance I don't really
care. Forinstance a driver servicing a serial channel wont hurt being run
in interrupt context as it is really limited how much CPU it can take
overall.

> -Scott

Esben

