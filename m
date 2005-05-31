Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVEaQZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVEaQZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVEaQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:19:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15141
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261932AbVEaQMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:12:06 -0400
Date: Tue, 31 May 2005 18:11:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: James Bruce <bruce@andrew.cmu.edu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531161157.GQ5413@g5.random>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 05:07:45PM +0200, Esben Nielsen wrote:
> There is no "simple lock" as spinlock (or very very few). All locks are
> mutexes - with priority inheritance! Ofcourse, hitting a lock which can be

You mean all locks "will be" mutex? I'd rather prefer a mechanism to
handle priority inheritance in the spinlocks that disable preemption
temporarily during the deterministic (see below) critical section. Going
to sleep every time there' a contention can cause overscheduling and is
expensive if the critical section is small (especially when it's
deterministic).

> The whole point of PREEMPT_RT is that what _other_, lower priority threads
> are doing isn't going to affect you. They are _not_ disabling preemption
> or locking you away. Ofcourse, as soon as you start to share resources
> with other threads you have to be carefull. But priority inheritance
> even makes that deterministic - provided that all code used under the lock
> is deterministic. Same as for any RTOS.

"all code used under the lock is deterministic.", that means all linux
source in all critical sections has to be deterministic to provided
hard-RT. Of course if all critical sections were deterministic, even
spinlocks that disable preemption and disable local irq, would be
acceptable.

> Please, tell me why you think mlockall() doesn't protect my RT thread
> against that problem. In the testcode I have made and run I have no

mlockall only works with userspace memory, it doesn't affect kernel
memory allocated with kmalloc. kmalloc is called during select and
most other syscalls. mlockall won't prevent a silly parallel task from
doing mmap(MAP_SHARED) and forcing kmalloc to pageout stuff in order to
allocate memory.

One could change that to prevent a real time kmalloc/slab-allocator, 
but it's quite enormous changes we're talking about here not just a
locking change (assuming you solve the above part of the deterministic
critical sections which is actually harder to provide than the VM side).

At best I think you could hope to execute a subset of syscalls with a
hard-RT behaviour with a subset of drivers and architectures, but whole
OS hard-RT sounds not very realistic to me with all sort of drivers
involved. Anybody with less than a 10 year release cycle probably
shouldn't depend on a hard-RT provided by preempt-RT with all possible
syscalls and drivers involved.

> I hope people will stop making such broad statements and reallize that
> Linux can become a hard-RT OS (if not by "proof", at least by
> meassurement). There is no conflict between a timesharing system scaling
> to a lot of CPUs and a hard-RT system just because they are catogarized as
> different in the text-books.

In theory I agree, in practice I think you've overstimating what it
means to make all critical sections deterministic (making the VM system
real time might be easier by using some huge reservation of ram, i.e.
absolutely non-generic kernel behaviour, and closer to a hard-RT OS than
a timesharing system, but doable).

For the determinism, you could do what Ingo did so far, that is to
"measure" but there's no way a "measurement" can provide an hard-RT
guarantee. The "measure" way is great for the lowlatency patches, and to
try to eliminate the bad-latencies paths, but it _can't_ guarantee a
"worst-case-latency".

If you're developing a medical system or an airplane, you can't risk
to kill people just because your measurement didn't accounted for a
certain workload.

Providing a math proof of "determinism" of the critical sections of a
system as large as linux is not feasible IMHO. If something you'd have
to create a software system that will provide the math proof.
I wouldn't trust humans for such a math work anyway, even if you could
afford to hire enough people. An automated system would be more
trustable, and that way you could hope to verify different linux kernel
versions in a reasonable amount of time, instead of just one.

So for hart-RT IMHO the only way is to never invoke syscalls and to run
always in irq context without sharing anything, with irqs going at max
prio using nanokernel or the patented way of redernining cli, that
people were doing for years before filing the patent. It's harder to
code that way, but that's the the price you pay to be guaranteed that
you won't block for an unknown amount of time, and I don't see other way
around it.

It scares me if people will use preemt-RT for hard-RT requirements. Ok,
if a cellphone crashes it's no big deal, but for real critical stuff
you can't play the measurement-russian-roulette.
