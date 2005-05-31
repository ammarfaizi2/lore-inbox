Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVEaUqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVEaUqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVEaUqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:46:53 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19207
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261443AbVEaUp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:45:56 -0400
Date: Tue, 31 May 2005 22:45:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531204544.GU5413@g5.random>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531183627.GA1880@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 11:36:27AM -0700, Paul E. McKenney wrote:
> This is key.  Although there may well be some realtime application
> that requires -all- of Linux's syscalls and drivers, it seems that a
> large number of them are happy with a small subset.  Some are even OK
> with user-mode execution as the only realtime service.  One example
> of this would be an application that maps the device registers into
> user space and that pins the memory that it needs.  In these cases,

Yes, this is exactly what RTAI does AFIK, it runs userland in real
time from irqs, and in turn it can't provide syscalls to avoid risking
blocking anywhere.

If you don't need to run syscalls, you don't need CONFIG_PREEMT_RT AFIK,
but only a nanokernel or the cli trick and then you're much safer and
much simpler.

Audio is an enterly different beast, audio doesn't need hard-RT (if they
miss a deadline they'll have to record again, no big deal) and they just
need a better lowlatency patch to hide the badness in the usb irq and
ide irq (instead of fixing the source of those long irqs by simply
offloading them to softirq and by adding a sysctl or some other tweak to
always run softirqs within the softirqd context instead of running
softirqs from irq context like today [to improve performance]).

> the "rest of the kernel" need not provide services deterministically.
> Instead, it need only be able to give up the CPU deterministically.
> As I understand it, this last is the point of CONFIG_PREEMPT_RT.

For preempt-RT to be equivalent to RTAI, the "rest of the kernel" will
require all places that disables preempt temporarily, to be demonstrated
to be deterministic. It's not like RTAI that depends on the _hardware_
to raise an high prio irq.

RTAI == hardware guarantee (kernel code must not be deterministic at
all, embedded developer takes almost no risks)

preempt-RT == software guarantee (kernel code under preempt_disable
definitely has to be deterministic, embedded developer must be able to
evaluate all kernel code paths in drivers that disable preempt and irqs)

Plus with RTAI we don't depend on scheduler to do the right thing etc...
that suff can break when somebody tweak the scheduler for some smp
scalability bit or something like that (just watch currently Linus and
Ingo going after a scheduler bug that hangs the system, that would crash
a system with preempt-RT but RTAI would keep going without noticing
since it gets irq even when irqs are locally disabled), while it sounds
harder to break the nanokernel thing that depends on hardware feature
and unmaskable irqs.

The point where preempt-RT enters the hard-RT equation, is only if you need
syscall execution in realtime (like audio, but audio doesn't need
hard-RT, so preempt-RT can only do good from an audio standpoint, it
makes perfect sense that jack is used as argument for preempt-RT). If
you need syscalls with hard-RT, the whole thing gets an order of
magnitude more complicated and software becomes involved anyways, so
then one can just hope that preempt-RT will get everything right and
that somebody will demonstrate it.

> I agree that making each and every component of Linux provide realtime
> services (as opposed to just staying out of the way of realtime tasks)
> would take quite a bit of time and effort.  For example, keeping (say)
> TCP/IP from interfering with realtime user-mode execution is not all
> that difficult, but getting realtime response from a TCP/IP connection
> across Internet is another matter.

Definitely agreed ;)

> There are (at least!) two competing definitions for "hard real time":
> 
> 1.	Absolute guarantee of meeting the deadlines.

That's the one I meant with hard-RT.

> 2.	Any failure to meet the deadline results in failure of the
> 	application.

Well, this is doable with any linux kernel out there by just having the
application use gettimeofday before the deadline should have expired, or
by measuring the cycles in the scheduler. 2 doesn't require any RT
feature at all from the kernel.  Most apps in class 2 will work just
fine if their deadline is on the order of hundred msec.

> #1 is that there are other sources of failure.  For example, if all of
> the CPUs die, you are not going to meet your deadline no matter how the
> software is coded.  Not even hard-coded assembly language on bare metal
> can save you in this situation.

Yes, but that's a fault tolerance problem, it's possible to verify the
results of the cpu executions in software, I plan to add that with
future versions of CPUShare too (not on a cycle basis, but over time by
comparing the address space using the dirty bit of the pte and by
comparing the output generated through the network, though the dirty bit
tracking will require more kernel changes) with cpus spread across the
globe in different countries, since the seccomp environment is fully
deterministic.

As long as a software or hardware hits no bugs, class #1 is guaranteed
to keep going without missing the deadline. Hardware failure can always
happen anyway.

> Definition #2 is in some sense more practical, but one must also supply
> a required probability of success.  Otherwise, one can make -any- app
> be "hard realtime" as follows:
> 
> 	my_deadline = time(0) + TIME_ALLOWED_FOR_SOMETHING;
> 	/* do something that has a deadline */
> 	if (missed_deadline(my_deadline)) {
> 		abort();
> 	}
> 
> I suspect that Linux can meet definition #1 for only a very restricted
> set of services (e.g., user-mode execution for an app that has pinned
> memory).  I expect that Linux would be able to meet definition #2 for
> a larger set of services.  But this can be done incrementally, adding
> deterministic implementations of services as needed.

Class #2 can be implemented in userland too, it doesn't need to be the
scheduler that invokes exit, the app can do it too IMHO.

> Agreed, I certainly would not trust a hand-made proof of determinism!

eheh ;)

> Even an automated proof has the possibility of bugs in the proof software.
> But it would be necessary to specify which parts of the kernel needed
> to meet realtime scheduling guarantees.  If the application does not
> use a VGA driver, then it is only necessary to show that the VGA driver
> does not interfere with realtime processes -- one does not have to
> make the VGA driver itself deterministic.  Instead, one only has to
> make sure that the VGA driver lets go of the CPU deterministically.

Agreed.

What scares me a bit, is that the RT developers will have to do the
auditing themself for every driver they use in their embedded apps that
hasn't been verified yet. It's quite different from an hardware
guarantee that won't change depending on the underlying kernel code.

The nice thing of using linux with a class #1 app (one that requires
hard-RT to never miss a deadline but that won't cause a disaster if it
fails and in turn that doesn't require demonstration that all the linux
kernel is perfect), is that all the cpu can be used for rendering and
for GUI (with a full blown QT configuration on a LCD display and full
network stack with firewall too) without risking the hard-RT part to
skip a beat.  All sort of robots fits this area for example, a robot
could crash and damage itself or damage other goods if it misses a
deadline, but you want to configure and monitor it through the network
and you want a firewall and nice GUI on it etc..

Even better, even when the kernel crashes, often ping keeps working,
scheduler is completely dead, but the hard-RT part would still run
without skipping a beat.

> For the really critical stuff, some projects have assigned three different
> teams to implement in three different languages and runtime environments,
> and then coupled the resulting systems into a triple-module-redundancy
> configuration.  Horribly expensive, but worth it in some cases.

I agree it's worth it, and at least reinventing the wheel sometime is
useful ;)
