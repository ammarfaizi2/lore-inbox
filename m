Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131091AbRA2Wiq>; Mon, 29 Jan 2001 17:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRA2Wig>; Mon, 29 Jan 2001 17:38:36 -0500
Received: from maile.telia.com ([194.22.190.16]:16907 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S131091AbRA2Wid>;
	Mon, 29 Jan 2001 17:38:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Joe deBlaquiere <jadb@redhat.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Date: Mon, 29 Jan 2001 23:31:56 +0100
X-Mailer: KMail [version 1.2]
Cc: yodaiken@fsmlabs.com, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com>
In-Reply-To: <3A74462A.80804@redhat.com>
MIME-Version: 1.0
Message-Id: <01012923315600.01404@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 January 2001 17:17, Joe deBlaquiere wrote:
> Andrew Morton wrote:
> > There has been surprisingly little discussion here about the
> > desirability of a preemptible kernel.
>
> And I think that is a very intersting topic... (certainly more
> interesting than hotmail's firewalling policy ;o)
>
> Alright, so suppose I dream up an application which I think really
> really needs preemption (linux heart pacemaker project? ;o) I'm just not
> convinced that linux would ever be the correct codebase to start with.
> The fundamental design of every driver in the system presumes that there
> is no preemption.

please, no linux heart pacemaker at sourceforge... :-)

>
> A recent example I came across is in the MTD code which invokes the
> erase algorithm for CFI memory. This algorithm spews a command sequence
> to the flash chips followed by a list of sectors to erase. Following
> each sector adress, the chip will wait for 50usec for another address,
> after which timeout it begins the erase cycle. With a RTLinux-style
> approach the driver is eventually going to fail to issue the command in
> time. There isn't any logic to detect and correct the preemption case,
> so it just gets confused and thinks the erase failed. Ergo, RTLinux and
> MTD are mutually exclusive. (I should probably note that I do not intend
> this as an indictment of RTLinux or MTD, but just an example of why
> preemption breaks the Linux driver model).

Can't that happen in the 2.4.0 kernel too?
If interrupts are not disabled during the command queuing any (with more than 
50 us execution time) interrupt might disturb the setup.
That part of the code should either:
a) accept partial success, and continue (can it check current success)
b) disable interrupts, then shouldn't it use
     spin_lock_irq(...) instead of spin_lock_bh(...)

Where is the code BTW? (file:line)
is it the functions named do_erase_1_by_16_oneblock?


>
> So what is the solution in the preemption case? Should we re-write every
> driver to handle the preemption? Do we need a cli_yes_i_mean_it() for
> the cases where disabling interrupts is _absolutely_ required? 

the problem will be drivers requiring a maximum execution time of a part
of its code...
Most drivers use spin_lock_irq to get mutual exclusivetly with their interrupt
handlers - lets keep it that way.

What about introducing a  timecritical_lock()
#define timecritical_lock(int maxtime_us)  {__cli(); } 
	/* local processor only */


Any driver using the timecritical_lock are not 100% RTLinux compatible,
but should be ok in a preemtive kernel where timecritical_locks are 
short compared to "guarantees".
The parameter maxtime_us is a hint to system integrators - don't use drivers 
with high maxtime in a RT system.

But it will be extremly hart to make any guarantees...
If the driver needs the PCI bus, it might be locked for burst transfer...
SMP issues...

> Do we
> push drivers like MTD down into preemptable-Linux? Do we push all
> drivers down?

All drivers should be compatible with preemtive-Linux, they who are not are
unlikely to be compatible with the current Linux.

> In the meantime, fixing the few places where the kernel spends an
> extended period of time performing a task makes sense to me. If you're
> going to be busy for a while it is 'courteous' to allow the scheduler a
> chance to give some time to other threads. Of course it's hard to know
> when to draw the line.
>
> So now I am starting to wonder about what needs to be profiled. Is there
> a mechanism in place now to measure the time spent with interrupts off,
> for instance? I know this has to have been quantified to some extent,
> right?

-- 
Home page:
  none currently
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
