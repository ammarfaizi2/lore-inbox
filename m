Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317856AbSFSLtd>; Wed, 19 Jun 2002 07:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSFSLtc>; Wed, 19 Jun 2002 07:49:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47539 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317856AbSFSLta>;
	Wed, 19 Jun 2002 07:49:30 -0400
Date: Wed, 19 Jun 2002 13:47:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: scheduler timeslice distribution, threads, processes. [was: Re:
 Question about sched_yield()]
In-Reply-To: <Pine.LNX.3.96.1020619071221.1119C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0206191329020.11234-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Bill Davidsen wrote:

> Clearly your fix is subtle enough that a quick reading, at least by me,
> can't follow all the nuances, but it looks on first reading as if your
> patch fixes this too well, and will now starve the threaded process by
> only giving one turn at the CPU per full pass through the queue, rather
> than sharing the timeslice between threads of a process.

the important point is that to the Linux scheduler there is only one
context of execution that matters: one Linux thread. The kernel itself is
deeply threaded - in kernel mode all threads access all data structures of
each other. Whether threads share certain resources (the VM or files) at
the userspace level is irrelevant to the scheduler. My strong point is
that this is not an accidental property of Linux, it's very intentional.  
CPU time partitioning and VM-sharing are two distinct concepts and they
should not be artificially connected.

> I posted some thoughts on this to Robert, if you would comment I would
> appreciate. My thought is that if you have N processes and one is
> threaded, the aggregate of all threads should be 1/N of the CPU(s), not
> vastly more or less. I think with your change it will be less if they
> are sharing a resource. Feel free to tell me I misread what it does, or
> my desired behaviour is not correct.

'processes' are threads that have an isolated set of resources. The
possible sharing relationships between threads is much more complex than
what can be expressed via a simplicistic 'lightweight process' vs.
'heavyweight process' picture. [or the 'container process/shell' and
'member threads' concept used in a particular OS, designed in the early
90s ;-) ] It's a fundamental property of the scheduler that it shares
timeslices between threads of execution - regardless of the
resource-sharing done by those threads.

[in fact it's almost impossible to get an accurate picture of resource
sharing that can be used by the scheduler, the resource sharing
capabilities of Linux are very finegrained. It's possible to share just a
single file descriptor between two threads, and it's possible to share a
given segment of virtual memory as well.]

so in your example, if you have 10 isolated threads ('normal processes'),
and a 'process' that has 5 shared-all threads, the scheduler only sees
that there are 15 threads in the system - and each thread will get 1/15th
of the CPU resources [if all threads have the same priority].

but i'm not fundamentally against enabling users to partition their CPU
resource usage better - ie. to be able to tell which particular set of
threads should get a given percentage of CPU time. What i'm against is to
tie, hardcode this to the 'all VM sharing' property of threads - like
other OSs do. Why shouldnt it be possible to give the 10 isolated threads
30% of all CPU time, and the remaining 5 shared-all threads 70% CPU time?
By decoupling the ability to partition CPU time in a finegrained way we
not only can do what you describe, but we also win lots of flexibility,
and the whole model becomes much cleaner.

> I do run 15 machines with long running a threaded server application and
> periodic CPU hog things like log roll and compress, stats generation,
> certain database cleanup, etc, and I have more than intelectual
> curiousity on this behaviour.

right now you cannot set specific hard percentages for given jobs, but you
can give them a relative priority via nice(). While nice() isnt exactly a
partitioning tool (eg. the CPU time used up increases with the number of
threads), it's pretty close. But being able to partition timeslices more
accurately is something that will happen eventually - and the scheduler is
ready for it.

	Ingo

