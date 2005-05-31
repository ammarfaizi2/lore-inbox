Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVEaShr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVEaShr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVEaShK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:37:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35507 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261175AbVEaSgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:36:16 -0400
Date: Tue, 31 May 2005 11:36:27 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531183627.GA1880@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531161157.GQ5413@g5.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 06:11:57PM +0200, Andrea Arcangeli wrote:

Quite the party going on with this thread!!!

> At best I think you could hope to execute a subset of syscalls with a
> hard-RT behaviour with a subset of drivers and architectures, but whole
> OS hard-RT sounds not very realistic to me with all sort of drivers
> involved. Anybody with less than a 10 year release cycle probably
> shouldn't depend on a hard-RT provided by preempt-RT with all possible
> syscalls and drivers involved.

This is key.  Although there may well be some realtime application
that requires -all- of Linux's syscalls and drivers, it seems that a
large number of them are happy with a small subset.  Some are even OK
with user-mode execution as the only realtime service.  One example
of this would be an application that maps the device registers into
user space and that pins the memory that it needs.  In these cases,
the "rest of the kernel" need not provide services deterministically.
Instead, it need only be able to give up the CPU deterministically.
As I understand it, this last is the point of CONFIG_PREEMPT_RT.

I agree that making each and every component of Linux provide realtime
services (as opposed to just staying out of the way of realtime tasks)
would take quite a bit of time and effort.  For example, keeping (say)
TCP/IP from interfering with realtime user-mode execution is not all
that difficult, but getting realtime response from a TCP/IP connection
across Internet is another matter.

> > I hope people will stop making such broad statements and reallize that
> > Linux can become a hard-RT OS (if not by "proof", at least by
> > meassurement). There is no conflict between a timesharing system scaling
> > to a lot of CPUs and a hard-RT system just because they are catogarized as
> > different in the text-books.
> 
> In theory I agree, in practice I think you've overstimating what it
> means to make all critical sections deterministic (making the VM system
> real time might be easier by using some huge reservation of ram, i.e.
> absolutely non-generic kernel behaviour, and closer to a hard-RT OS than
> a timesharing system, but doable).
> 
> For the determinism, you could do what Ingo did so far, that is to
> "measure" but there's no way a "measurement" can provide an hard-RT
> guarantee. The "measure" way is great for the lowlatency patches, and to
> try to eliminate the bad-latencies paths, but it _can't_ guarantee a
> "worst-case-latency".

There are (at least!) two competing definitions for "hard real time":

1.	Absolute guarantee of meeting the deadlines.

2.	Any failure to meet the deadline results in failure of the
	application.

Definition #1 is attractive, especially for applications where human life
is at stake.  However, for less critical applications, the problem with
#1 is that there are other sources of failure.  For example, if all of
the CPUs die, you are not going to meet your deadline no matter how the
software is coded.  Not even hard-coded assembly language on bare metal
can save you in this situation.

Definition #2 is in some sense more practical, but one must also supply
a required probability of success.  Otherwise, one can make -any- app
be "hard realtime" as follows:

	my_deadline = time(0) + TIME_ALLOWED_FOR_SOMETHING;
	/* do something that has a deadline */
	if (missed_deadline(my_deadline)) {
		abort();
	}

I suspect that Linux can meet definition #1 for only a very restricted
set of services (e.g., user-mode execution for an app that has pinned
memory).  I expect that Linux would be able to meet definition #2 for
a larger set of services.  But this can be done incrementally, adding
deterministic implementations of services as needed.

> If you're developing a medical system or an airplane, you can't risk
> to kill people just because your measurement didn't accounted for a
> certain workload.
> 
> Providing a math proof of "determinism" of the critical sections of a
> system as large as linux is not feasible IMHO. If something you'd have
> to create a software system that will provide the math proof.
> I wouldn't trust humans for such a math work anyway, even if you could
> afford to hire enough people. An automated system would be more
> trustable, and that way you could hope to verify different linux kernel
> versions in a reasonable amount of time, instead of just one.

Agreed, I certainly would not trust a hand-made proof of determinism!
Even an automated proof has the possibility of bugs in the proof software.
But it would be necessary to specify which parts of the kernel needed
to meet realtime scheduling guarantees.  If the application does not
use a VGA driver, then it is only necessary to show that the VGA driver
does not interfere with realtime processes -- one does not have to
make the VGA driver itself deterministic.  Instead, one only has to
make sure that the VGA driver lets go of the CPU deterministically.

> So for hart-RT IMHO the only way is to never invoke syscalls and to run
> always in irq context without sharing anything, with irqs going at max
> prio using nanokernel or the patented way of redernining cli, that
> people were doing for years before filing the patent. It's harder to
> code that way, but that's the the price you pay to be guaranteed that
> you won't block for an unknown amount of time, and I don't see other way
> around it.
> 
> It scares me if people will use preemt-RT for hard-RT requirements. Ok,
> if a cellphone crashes it's no big deal, but for real critical stuff
> you can't play the measurement-russian-roulette.

For the really critical stuff, some projects have assigned three different
teams to implement in three different languages and runtime environments,
and then coupled the resulting systems into a triple-module-redundancy
configuration.  Horribly expensive, but worth it in some cases.

							Thanx, Paul
