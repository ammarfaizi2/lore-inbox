Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUJGTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUJGTvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUJGTsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:48:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267958AbUJGTpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:45:17 -0400
Date: Thu, 7 Oct 2004 12:45:08 -0700
Message-Id: <200410071945.i97Jj8lV016039@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, jbarnes@sgi.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: Christoph Lameter's message of  Tuesday, 5 October 2004 18:21:39 -0700 <Pine.LNX.4.58.0410051809590.30594@schroedinger.engr.sgi.com>
X-Zippy-Says: We just joined the civil hair patrol!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If clockid_t with your proposed bitfields would be restricted to glibc
> alone then we would not have to deal with these bits on the kernel level.
>
> The clock_gettime function calls would take a clock number, not a
> clockid_t  in the way that you want to use it. That would allow us to keep
> the interface clear of pids mixed with clock numbers.

That is true.  I am not convinced that it is worth adding this hassle based
on the purely academic concern about PID_MAX_LIMIT being raised to 2^29 on
32-bit machines or 2^61 on 64-bit machines.  That would be 2TB of 4k kernel
stacks alone on the 32-bit machine.  It's not going to happen.

Any plan that doesn't encode all the information into the clockid_t value
necessarily requires either adding new system calls or adding new
parameters to the existing ones.  Either way, it's a whole bunch of
annoyance to change, support binary compatibility properly, etc, etc.
There has to be an actually worthwhile reason not to just go with my scheme.

> The question is pretty acute. Currently glibc accesses CPU timers on its
> own bypassing the kernel. Most of the times it works but on lots of
> systems this is royally screwed up and CLOCK_*_CPUTIME_ID returns funky
> values.

This is what is no longer relevant with the kernel work I've now done.
In fact, it never works accurately if there are any context switches going on.

> User needs to be able to use the specialized clocks provided by the kernel.

All glibc users need is one definition of the most accurate CPU time clock
available, and that will be provided through the POSIX interfaces
(CLOCK_THREAD_CPUTIME_ID, CLOCK_PROCESS_CPUTIME_ID, clock_getcpuclockid,
and pthread_getcpuclockid).  We have no intention of providing detailed
access to different kinds of hardware clocks in a glibc interface.  If you
want that, write your own separate interface.  Users I know about are
interested in the most accurate CPU time tracking that is available on the
system they are using in a given instance.  This is what they get by
letting the kernel implementation, configuration, and hardware detection
choose the optimal way to implement sched_clock, which is what they now get.

By contrast, your patch provides a new way to access the
least-common-denominator low-resolution information already available by
other means, and nothing more.

> We have been trying to get a resolution on these issues for a long time
> from the glibc folks (I can trace the CPUTIME issue back at least 1 1/2
> years).
> 
> Would be possible to define a clean interface that would get glibc out of
> the business of accessing hardware directly and allow some sanity in terms
> of clock access?

This is exactly what I have done, as I have already said more than once.
I am glibc folks.  This kernel implementation is motivated by glibc's needs
to better implement the POSIX interfaces.  It is what we want.

Your characterization of what has happened on this issue is rather skewed,
but I won't go into that since it's moot.  We are trying to move forward
now on schemes that really work, and there has been no prior concrete
proposal from any quarter that met the functional requirements.  My kernel
implementation is intended to do so, but I am certainly open to meaningful
critique of its efficacy.

> Does this fit not into your context? I have stated the problem a gazillion
> times, I probably have no problem in explaining it another ten times to you.
> 
> I do not see that you are solving the most urgent problems. Instead we get
> funky forms of pid's mixed with clockid's.

I'm sorry that you do not see it.  "My context" is that the actual
problems, some of which you've talked about and some of which you seem to
have misunderstood, are indeed solved by the work I've done, and I've
explained more than once how that is the case.  I'm glad that you are not
unhappy continuing to discuss the issue.  I don't mind continuing any
discussion that is making any progress.  I hope you also don't have a
problem foregoing the ten repetitions of your understanding of the
situation, which I believe you have already communicated successfully so I
understand what you think about it, and addressing yourself instead to any
concrete concerns that remain given a clear understanding of what the new
situation will in fact be given my kernel implementation and appropriate
glibc support tailored for it.


Thanks,
Roland
