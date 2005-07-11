Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVGKO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVGKO7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVGKO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:57:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14039 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261917AbVGKOzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:55:19 -0400
Date: Mon, 11 Jul 2005 07:55:52 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Attempted summary of "RT patch acceptance" thread, take 2
Message-ID: <20050711145552.GA1489@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

As promised/threatened, here is an updated attempted summary.

						Thanx, Paul

------------------------------------------------------------------------

CONTENTS

A.	INTRODUCTION
B.	DESIRABLE PROPERTIES
C.	LINUX REALTIME APPROACHES
D.	OTHER ASPECTS OF REALTIME
E.	SUMMARY
F.	RESOURCES

Search for a line beginning with the corresponding capital letter followed
by a period to jump to the corresponding section.


A.  INTRODUCTION

Common wisdom dictates that realtime operating systems, particularly
hard-realtime operating systems, must be designed from ground up; that
serious realtime support cannot be simply grafted onto an existing
general-purpose operating system.  Although this common wisdom was
not arrived at lightly, it is often worthwhile to look for important
exceptions to this sort of general rule of thumb.  Candidate exceptions
include:

1.	Many realtime applications use a very restricted subset of
	the services provided by a general-purpose OS like Linux.
	Some applications require realtime support only for scheduling
	user-mode code, for example, an application that directly accesses
	MMIO registers mapped into its address space.  This observation
	leads to the possibility of providing very limited realtime
	support.

2.	Computer performance and capacity has increased dramatically
	over the past few decades, quite literally by multiple orders
	of magnitude.  A small embedded system can easily be much more
	capable than a mid-70s supercomputer, for example, the vaunted
	Cray-1, introduced in 1976, ran at 160MFLOPs and sported 8MB of
	main memory.  In today's terms, this would be a modest embedded
	system -- and just you try running Linux on an 8MB system!
	This dramatic increase in performance permits some applications
	that would have required heavy-duty RTOS support in the 70s to
	run reasonably well on unmodified general-purpose OSes.

There are still limits to the degree of realtime support that one can
expect from a general-purpose OS -- there are some extremely demanding
applications that can be satisfied only by hand-coded assembly running
on bare metal.  In fact, there are applications that can be satisfied
only by custom hardware implementations.  For example, standard DRAM is
only so fast, and large CPU caches help only the common case, not the
worst case that is important for hard realtime.  In this case, the
custom hardware might be a small CPU core with a modest amount of static
RAM.  In still more demanding situations, custom logic might be required.

Nevertheless, it is clear that Linux can support significant realtime
requirements, as it is already being used heavily in the realtime arena.
But how far should Linux extend its realtime support, and what is the
best way to extend Linux in this direction?  Can one approach to realtime
satisfy all reasonable requirements, or would it be better to support
multiple approaches, each with its area of applicability?

The answers to these questions are not yet clear, and have been the
subject of much spirited discussion, for example, see the more than
300 messages in the following LKML thread:

	http://lkml.org/lkml/2005/5/23/156
	http://marc.theaimsgroup.com/?l=linux-kernel&m=111689227213061&w=2

This document looks at some strategies that have been proposed for
realtime Linux, comparing and contrasting their capabilities.  But, to
evaluate these strategies, it is first necessary to determine what exactly
one might want in a realtime Linux.  If you would rather skip straight to
the comparing and contrasting, search for "LINUX REALTIME APPROACHES".


B.  DESIRABLE PROPERTIES

As usual, there are conflicting desires, at least they conflict given
the current state of the art.  These desires fall into the following
categories:

1.	Quality of service
2.	Amount of code that must be inspected to assure quality of service
3.	API provided
4.	Relative complexity of OS and applications
5.	Fault isolation: what non-RT failures endanger RT code?
6.	What hardware and software configurations are supported?

Each of these categories is expanded upon below, and later used to compare
a number of proposed realtime approaches for Linux.  The discussion does
go for some time, which is not surprising given that it is summarizing
many hundreds of email messages.  ;-)  Search for the corresponding
number at the beginning of a line to skip directly to the discussion of
a given category.


1.  Quality of Service

The traditional view is that the entire operating system is either
hard realtime, soft realtime, or non-realtime, but this viewpoint
is too coarse grained.  Different workloads have different needs,
and there is disagreement over the exact definitions of these three
categories of realtime.  For example, (at least) the following two
definitions of "hard realtime" are in use:

a.	In absence of hardware failures, software provably meets
	the specified deadlines.  This is fine and good, but many
	applications simply do not need this "diamond hard" realtime.

b.	Failure to meet the specified deadline results in application
	failure.  This is OK, but -only- if there is a corresponding
	required probability of success.  Otherwise, one could claim
	"hard realtime" by simply failing the application every time it
	tries to do anything, which is clearly not useful.

A better approach is to simply specified the required probability
of meeting the specified deadline in absence of hardware failure.
A probability of 1.0 is consistent with definition (a).  Other
applications will be satisfied with a probability such as 0.999999,
which might be sufficiently high that the probability of software
scheduling failure is "in the noise" compared with the probability
of hardware failure.  A recent LKML thread called this "metal hard"
realtime.  Or was it "ruby hard"?  ;-)

Of course, one can increase the reliability of hardware through
redundancy, but no hardware configuration provides perfect reliability.
For example, clusters can increase reliability, so that the probability
of failure of the cluster is p^n, where "p" is the probability of a
single node failing and "n" is the number of nodes.  Note that this
expression never reaches a probability of 0, no matter how large "n" is.
In addition, this mathematical expression assumes that the failover
software is perfectly reliable and perfectly configured.  This assumption
conflicts sharply with my own experience, in which there has always been
a point beyond which adding nodes -decreased- cluster reliability.
So one can argue that effort put into making software more reliable
than is the underlying hardware is effort wasted.  That said, there
are situations, such as when human life is on the line, where such
effort might be an extremely wise investment.

The timeframe is just as important as is the probability of meeting the
deadline.  Any system can provide hard realtime guarantees if the deadline
is an infinite amount of time in the future.  No computer system that I am
aware of at this writing is capable of meeting a 1-picosecond scheduling
deadline for any task of non-zero duration, but then neither can dedicated
digital hardware.  Some applications have definite response-time goals,
for example, industrial process-control applications tend to have
response-time goals ranging from 100s of microseconds to small numbers
of seconds, while non-interactive applications such as graphics playback
(movies and the like) are said to need no better than about 7 milliseconds
scheduling jitter.  Other applications can benefit from any improvement in
response-time goals -- faster is better, think in terms of Doom players --
but even in these cases there is normally a point of diminishing returns.

The services used by the realtime application also figure in.  Given
current disk technology, it is not possible to meet a 100-microsecond
deadline for a 1GB synchronous write to disk.  Not even if you cheat
and supply the disk with a battery-backed-up DRAM cache.  However, many
realtime applications need only a few of the services that an operating
system might provide.  This list might include interrupt handling, process
scheduling, disk I/O, network I/O, process creation/destruction, VM
operations, and so on.  Keep in mind that many popular RTOSes provide very
little in the way of services!  They frequently leave the complex stuff
(e.g., web serving) to general-purpose operating systems.  This situation
raises the possibility of providing a single Linux operating-system
instance that provides some services with realtime guarantees and other
services in a non-realtime fashion, with no guarantees of any sort.

Note that each service can have an associated deadline that it can
meet.  The interrupt system might be able to meet a 1-microsecond
deadline, the real-time process scheduler a 10-microsecond deadline,
the disk I/O system a 10-millisecond deadline for moderate-sized
I/Os, and so on.  The deadline that a service can meet might also
depend on the parameters, so that the disk-I/O system would be
expected to take longer for larger I/Os.

Furthermore, the probability might vary from service to service or with
the parameters to that service.  For example, the probability of network
I/O completing successfully in minimal time might well be a function
of the number of packets transmitted (to account for the probability of
packet loss) as well as of packet size (to account for bit-error rate).
To make things even more complicated, the probability of meeting the
deadline will vary depending on the length of time allowed.  Considering
the networking example, a very short deadline might not allow the data
transmission to complete, even if it proceeds at wire speed.  A longer
deadline might allow transmission to complete, but only if there are
no transmission errors.  An even longer deadline might allow time for
a limited number of retransmissions, in order to recover from packet
loss due to transmission errors.  Of course, a deadline infinitely far
into the future would allow guaranteed completion, but I for one am not
that patient.

Finally, the performance and scalability of both realtime and non-realtime
applications running on the system can be important.  Given the current
state of the art, one must pay a performance penalty for realtime support,
but the smaller the penalty, the better.

So, to sum up, here are the components of a quality-of-service metric
for realtime OSes:

a.	List of services for which realtime response is supported.

b.	For each service:

	i.	Probability of meeting a deadline in absence of hardware
		failure, ranging from 0 to 1, with the value of 1
		corresponding to the hardest possible hard realtime.

	ii.	Allowable deadline, measured from the time that
		the request is initiated to the time by which the
		response must be received.

c.	Performance and scalability provided to both realtime and
	non-realtime applications.


2.  Amount of Code Inspection Required

So you add a new feature to a realtime operating system.  How much of
the rest of the system must you inspect and understand in order to be
able to guarantee that your new feature provides the required level
of realtime response?  The smaller this amount of code, the easier it
is to add new features and fix bugs, and the greater the number of
people who will be able to contribute to the project.  In addition,
the smaller the amount of such code, the smaller the probability that
some well-intentioned bug fix will break realtime response.

Each of the following categories of code might need to be inspected:

a.	The low-level interrupt-handing code.

b.	The realtime process scheduler.

c.	Any code that disables interrupts.

d.	Any code that disables preemption.

e.	Any code that holds a lock, mutex, semaphore, or other resource
	that is needed by the code implementing your new feature, as
	well as the code that actually implements the lock, mutex,
	semaphore, or other resource.

f.	Any code that manipulates hardware that can stall the bus,
	delay interrupts, or otherwise interfere with forward progress.
	Note that it is also necessary to inspect user-level code that
	directly manipulates such hardware.

Of course, use of automated tools could make such inspection much more
reliable and less onerous, but one would want such tools to deal with
the very large number of CPU architectures and configuration options
that Linux supports.  The smaller the amount of code that must be
inspected, the less chance there is that such a tool will fall victim to
configuration-architecture combinatorial explosion.  Of course, a tool
that supported only a specific CPU architecture with a limited set of
configuration options might still be useful, but the wider the coverage,
the more useful the tool.

The hardware connection called out in point "f" above is quite important,
and much more difficult to deal with, since machine-inspectable source
code for firmware and for hardware (e.g., VHDL code) are typically not
readily available.  These sorts of problems are anything but theoretical,
for example, see section 4.5 of:

	http://www.cs.utah.edu/~regehr/papers/hotos7/hotos7.html

which describes some problems that were triggered by X-windows (not
kernel!) driver bugs that resulted in hardware stalls.  Similar problems
have been triggered in other chipsets:

	http://www.rme-audio.de/english/techinfo/nforce4_tests.htm

At present, there is no known way of finding these problems other than
exhaustive testing.

Each of Linux realtime approaches uses a different strategy to
minimize the amount of code in these categories.  These differences
are surprisingly important, and will be discussed in more detail
when going over the various approaches to Linux realtime.


3.  API Provided

I never have learned to -really- like the POSIX API, with the gets()
primitive being a particular cause of heartburn, but given the huge
amount of software out there that relies on it and the equally huge
number of developers who are familiar with it, one should certainly
strive to provide it, or at least a sizeable subset of it.

Other popular APIs include the various Java runtime environments,
and of course the feared and loathed, but quite ubiquitous, Windows
API.

There are a lot of developers and a lot of software out there.  The
more of these existing developers and software your API supports,
the more successful your realtime facility is likely to be.


4.  Relative Complexity

How much realtime capability should be added to the operating system?
How much of this burden should the applications take on?  Is it better
to push some of the complexity into a nanokernel, hypervisor, or other
software or firmware layer?  Let's first look at the tradeoff between
OS and application.

For example, although it is certainly possible to program for separate
realtime and non-realtime operating-system instances, doing so adds
complexity to the application.  Complexity is particularly deadly in the
hard realtime arena, and can be literally so if human lives are at risk.

Balancing this consideration is the need for simplicity in the
operating-system kernel.  This balancing act must be carefully considered,
taking both the relative complexities and the number of uses into
account.  Some would argue that it is worthwhile adding 1,000 lines
to the OS if that saves 100 lines in each of 1,000 applications.
Others would disagree, perhaps citing the greater fault isolation
that might be provided by the separation.

But this balance clearly must be struck somewhere between writing the
application to bare metal on the one hand (but achieving a perfectly
simple zero-size operating system) and bloating the operating system
beyond the limits of maintainability on the other hand.

Similar arguments can be made for moving some functionality into a
hypervisor or nanokernel layer, though fault isolation also comes
into play here.

Many of the most vociferous arguments seem to revolve around this
complexity issue.  It is quite possible that there never will be a single
agreed-upon solution, since different people place different emphasis on
different aspects of this design choice.  Nonetheless, a well-thought-out
discussion is very likely to turn up better design choices.


5.  Fault Isolation

Can a programming error in a non-realtime application or in a non-realtime
portion of the OS harm a realtime application?

Some applications do not care: in these cases, a failure anywhere
causes a user-visible failure, so it is not important to isolate
faults.  Of course, even in these cases, it may be valuable to isolate
faults in order to aid debugging, but, other than that, the fault
isolation does not help overall application reliability -- regardless
of where the bug occurs, the user sees a failure.

In other cases, the realtime portion of the application is protecting
someone's life and limb, but the non-realtime portion is only compiling
statistics and reports.  In this case, fault isolation can be of the
utmost importance.

What sorts of faults need isolating?

o	Excessive disabling of interrupts.

o	Excessive disabling of preemption.

o	Holding a lock, mutex, or semaphore for too long, when that
	resource must be acquired by realtime code.

o	Memory corruption, either via wild pointers or via wild DMA.

These faults might occur in the main kernel, in a loadable module, or in
some debugging tool, such as a kprobe procedure or a kernel-debugger
breakpoint script.  Though in the latter case, perhaps realtime
deadlines should not be guaranteed when actively debugging.  After all,
straightforward debugging techniques, such as use of kprint(), can cause
response-time problems even in non-realtime environments.


6.  Hardware and Software Configurations

Is SMP required?  If so, how many CPUs?  How many tasks?  How many
disks?  How many HBAs?

If all the code in the kernel were O(1), it might not matter, but
the Linux kernel has not yet reached this goal, and perhaps never
will completely reach it.  Therefore, some applications may choose to
restrict the software or the hardware configuration of the platform in
order to meet the realtime deadlines.  This approach is consistent with
traditional RTOS methodology, as RTOS vendors have been known to restrict
the configurations in which they will support hard realtime guarantees.


C.  LINUX REALTIME APPROACHES

The following general approaches to Linux realtime have been proposed,
along with many variations on each of these themes:

1.	non-CONFIG_PREEMPT
2.	CONFIG_PREEMPT
3.	CONFIG_PREEMPT_RT
4.	Nested OS
5.	Dual-OS/Dual-Core
6.	Migration Between OSes
7.	Migration Within OS

Each of these general approaches is discussed in the following sections.
Each section ends with a brief (but perhaps controversial) summary of
the corresponding approach's strengths and weaknesses.  I do not address
"strength of community", even though this may well be the decisive factor.
After all, the technical comparision will provide sufficient flame-bait.
That said, if you are working on realtime extensions to Linux, you really
really should be posting regularly on LKML.  Yes, the resulting flames
can be painful at times, but a little heat is needed for a patchset to
get "well done" (sorry for the pun, but the point is nonetheless serious).

This document does not present measured comparisons among all of the
approaches, despite the fact that such comparisons would be extremely
useful.  The reason for this, aside from gross laziness, is that it is
wise to agree on the metrics beforehand.  Therefore, the comparisons
in this document are for the most part qualitative.  In some cases,
they are based on actual measurements, but these measurements were
taken by different people on different configurations using different
benchmarks.  This is a prime area for future improvement.


1.  non-CONFIG_PREEMPT

This is the stock kernel, without even preemption.  Why would -anyone-
think of using stock 2.6 for a realtime task?  Because some realtime
applications have very forgiving scheduling deadlines.  One project
I worked on in the early 1980s had 2-second response-time deadlines.
This was quite a challenge, given that it was running on a 4MHz Z80 CPU --
though, to be fair, the Z80 was accompanied by a hardware floating-point
processor that was able to compute a 32-bit floating-point multiply in
well under a millisecond.  Modern hardware running a stock Linux 2.6 
kernel would have no problem with this application.  Hey, just having
32 address bits rather than only 16 would have helped a lot!

a.	Quality of service: "soft realtime", with timeframe of 10s of
	milliseconds for most services.  Some I/O requests can take
	longer.  Provides full performance and scalability to both
	realtime and non-realtime applications.

b.	Amount of code that must be inspected to assure quality of service
	for a new feature: the entire kernel, every little bit of it,
	since the entire kernel runs with preemption disabled.

c.	API provided: POSIX with limited realtime extensions.
	Realtime and non-realtime applications can interact using
	the normal POSIX services.

d.	Relative complexity of OS and applications: everything is
	stock, and all the normal system calls operate as expected.

e.	Fault isolation: none.

f.	Hardware and software configurations supported: all of them.
	Larger hardware configurations and some device drivers can
	result in degraded response time.

Strengths:  Simplicity and robustness.  "Good enough" realtime support
	for undemanding realtime applications.  Excellent performance
	and scalability for both realtime and non-realtime applications.
	Applications and administrators see a single OS instance.

Weaknesses:  Poor realtime response, need to inspect the entire kernel
	to find issues that degrade realtime response.


2.  CONFIG_PREEMPT

The CONFIG_PREEMPT option renders much of the kernel code preemptible,
with the exception of spinlock critical sections, RCU read-side critical
sections, code with interrupts disabled, code that accesses per-CPU
variables, and other code that explicitly disables preemption.

a.	Quality of service: "soft realtime", with timeframe of 100s of
	microseconds for task scheduling and interrupt handling, but
	-only- for very carefully restricted hardware configurations
	that exclude problematic devices and drivers (such as VGA)
	that can cause latency bumps of tens or even hundreds of
	milliseconds (-not- microseconds).  Furthermore, the software
	configuration of such systems must be carefully controlled,
	for example, doing a "kill -1" traverses the entire task list
	with tasklist_lock held (see kill_something_info()), which might
	result in disappointing latencies in systems with very large
	numbers of tasks.  System services providing I/O, networking,
	task creation, and VM manipulation can take much longer.  A very
	small performance penalty is exacted, since spinlocks and RCU
	must suppress preemption.

	Kristian Benoit and Karim Yaghmour measured CONFIG_PREEMPT
	at a maximum interrupt-response-time latency of about 555
	microseconds, see:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112086443319815&w=2

	The machine under test was a Dell PowerEdge SC420 with a P4
	2.8GHz CPU and 256MB RAM running a UP build of Fedora Core 3.

b.	Amount of code that must be inspected to assure quality of service
	for a new feature:

	i.	The low-level interrupt-handing code.

	ii.	The process scheduler.

	iii.	Any code that disables interrupts, which includes
		all interrupt handlers, both hardware and softirq.

	iv.	Any code that disables preemption, including spinlock
		critical sections, RCU read-side critical sections,
		code with interrupts disabled, code that accesses
		per-CPU variables, and other code that explicitly
		disables preemption.

	v.	Any code that holds a lock, mutex, semaphore, or other
		resource that is needed by the code implementing your
		new feature, as well as the code that actually implements
		the lock, mutex, semaphore, or other resource.

	vi.	Any code that manipulates hardware that can stall the
		bus, delay interrupts, or otherwise interfere with
		forward progress.  Note that it is also necessary to
		inspect user-level code that directly manipulates such
		hardware.

c.	API provided: POSIX with limited realtime extensions.

d.	Relative complexity of OS and applications: all the normal system
	calls operate as expected, so realtime and non-realtime processes
	can interact normally.

e.	Fault isolation: none.

f.	Hardware and software configurations supported: all of them.
	Larger hardware configurations and some device drivers can
	result in degraded response time.

Strengths:  Simplicity.  Available now, even from distributions.
	Provides "good enough" realtime support for a large number
	of applications.  Applications and administrators see a
	single OS instance.

Weaknesses:  Limited testing, so that some robustness issues remain.
	Need to inspect large portions of the kernel in order
	to find issues that degrade realtime response.


3.  CONFIG_PREEMPT_RT

The CONFIG_PREEMPT_RT patch by Ingo Molnar introduces additional
preemption, allowing most spinlock (now "mutexes") critical sections,
RCU read-side critical sections, and interrupt handlers to be preempted.
Preemption of spinlock critical sections requires that priority
inheritance be added to prevent the "priority inversion" problem where
a low-priority task holding a lock is preempted by a medium-priority
task, while a high-priority task is blocked waiting on the lock.
The CONFIG_PREEMPT_RT patch addresses this via "priority inheritance",
where a task waiting on a lock "donates" its priority to the task holding
that lock, but only until it releases the lock.  In the example above,
the low-priority task would run at high priority until it released the
lock, preempting the medium-priority task, so that the high-priority
task gets the lock in a timely fashion.  Priority inheritance has been
used in a number of realtime OS environments over the past few decades,
so it is a well-tested concept.

One problem with priority inheritance is that it is difficult to implement
for reader-writer locks, where a high-priority writer might wish to
donate its high priority to a large number of low-priority readers.
The CONFIG_PREEMPT_RT patch addresses this by allowing only one task at
a time to read-acquire a reader-writer lock, although it is permitted
to do so recursively.  This can limit the scalability of reader-writer
locks, but one would not expect any change unless and until someone finds
a serious scalability limit that affected a significant fraction of
realtime users.

Note that a few critical spinlocks remain non-preemptible, using the
"raw spinlock" implementation.

a.	Quality of service: "soft realtime", with timeframe of a few 10s
	of microseconds for task scheduling and interrupt-handler entry.
	System services providing I/O, networking, task creation, and
	VM manipulation can take much longer, though some subsystems
	(e.g., ALSA) have been reworked to obtain good latencies.
	Since spinlocks are replaced by blocking mutexes, the performance
	penalty can be significant (up to 40%) for some system calls,
	but user-mode execution runs at full speed.  There is likely to
	be some performance penalty exacted from RCU, but, with luck,
	this penalty will be minimal.

	Kristian Benoit and Karim Yaghmour have run an impressive set of
	benchmarks comparing CONFIG_PREEMPT_RT with CONFIG_PREEMPT(?) and
	Ipipe, see the LKML threads starting with:

	1. http://marc.theaimsgroup.com/?l=linux-kernel&m=111846495403131&w=2
	2. http://marc.theaimsgroup.com/?l=linux-kernel&m=111928813818151&w=2
	3. http://marc.theaimsgroup.com/?l=linux-kernel&m=112008491422956&w=2
	4. http://marc.theaimsgroup.com/?l=linux-kernel&m=112086443319815&w=2

	This last run put CONFIG_PREEMPT_RT at about 70 microseconds
	interrupt-response-time latency.  The machine under test was a
	Dell PowerEdge SC420 with a P4 2.8GHz CPU and 256MB RAM running
	a UP build of Fedora Core 3.

b.	Amount of code that must be inspected to assure quality of service
	by a new feature:

	i.	The low-level interrupt-handing code.

	ii.	The process scheduler.

	iii.	Any code that disables interrupts, but -not- including
		interrupt handlers, which now run in process context.

	iv.	Any code that disables preemption, including raw-spinlock
		critical sections, code with interrupts disabled, code
		that accesses per-CPU variables, and other code that
		explicitly disables preemption.

	v.	Any code that holds a lock, mutex, semaphore, or other
		resource that is needed by the code implementing your
		new feature, as well as the code that actually implements
		the lock, mutex, semaphore, or other resource.

	vi.	Any code that manipulates hardware that can stall the
		bus, delay interrupts, or otherwise interfere with
		forward progress.  Note that it is also necessary to
		inspect user-level code that directly manipulates such
		hardware.

c.	API provided: POSIX with limited realtime extensions.

d.	Relative complexity of OS and applications: all the normal system
	calls operate as expected, so realtime and non-realtime processes
	can interact normally.

e.	Fault isolation: none.

f.	Hardware and software configurations supported: most of them.
	SMP support is a bit rough, and a number of drivers have not yet
	been upgraded to work properly in the CONFIG_PREEMPT_RT environment.
	It is likely that larger hardware configurations and some device
	drivers can result in degraded scheduling latency, but given that
	normal spinlocks are now preemptible, this effect should be much
	less of an issue than for CONFIG_PREEMPT.

Strengths:  Excellent scheduling latencies, potential for hard
	realtime for some services (e.g., user-mode execution) in
	some configurations.  A number of aspects of this approach
	might be incrementally added to Linux (e.g., priority
	inheritance for semaphores to prevent semaphore priority
	inversion, see "other aspects of realtime" for more discussion
	of this).  Applications and administrators see a single
	OS instance.

Weaknesses:  Limited testing, so that robustness issues remain.
	Large patch to Linux (~31K lines of context diff as of
	V0.7.51-23).  Both realtime and non-realtime applications pay
	performance and scalability penalties for the realtime service.


4.  Nested OS

The Linux instance runs as a user process in an enclosing RTOS.  Realtime
service is provided by the RTOS, and a richer set of non-realtime services
is provided by the Linux instance.  Note that there is considerable
variety in RTOSes, and this section defines this term in its broadest
possible meaning, including full OSes, hypervisors, nanokernels, and
interrupt pipelines.  At some point, it may make sense to split this
section based on the type of the enclosing "OS", but there does not
seem to be much reason to break it up at this point.

a.	Quality of service: hard realtime, with timeframe of about 10
	microseconds for services provided by the underlying RTOS.
	More complex services (I/O, task creation, and so on) will
	likely take longer to execute, which may impose a significant
	performance and scalability penalty.

	Philippe Gerum's interrupt-pipeline layer, named Ipipe, is an
	example of an extreme case of a minimal RTOS.  Kristian Benoit
	and Karim Yaghmour measured Ipipe's CONFIG_PREEMPT at a maximum
	interrupt-response-time latency of about 50 microseconds, see:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112086443319815&w=2

	This result was the best of the three alternatives tested
	(CONFIG_PREEMPT, CONFIG_PREEMPT_RT, and Ipipe in conjunction
	with Linux 2.6.12).  It is believed that hardware limitations
	prevent much improvement in this result.

	The machine under test was a Dell PowerEdge SC420 with a P4
	2.8GHz CPU and 256MB RAM running a UP build of Fedora Core 3.

b.	Amount of code that must be inspected to assure quality of service
	by a new feature:

	i.	All of the RTOS.  One would strive to keep the RTOS
		quite small, the greater the number of realtime services
		provided, the larger the RTOS must be.

	ii.	Any Linux-kernel code that disables interrupts.
		Note that in many implementations, the Linux kernel
		will be prevented from disabling interrupts, since
		any attempt to disable interrupts will trap into
		the RTOS.

		If the Linux kernel runs in privileged mode, however,
		all bets are off.  In this case, special care must be
		used to avoid disabling the real hardware interrupts,
		including such disabling within any kernel modules
		that might be loaded.

	iii.	Any code that manipulates hardware that can stall the
		bus, delay interrupts, or otherwise interfere with
		forward progress.  Note that it is also necessary to
		inspect user-level code that directly manipulates such
		hardware.

c.	API provided: Whatever the RTOS wants to provide, often a
	subset of POSIX with realtime extensions.

d.	Relative complexity of OS and applications: there are now two
	operating systems, both of which must be configured and
	administered.  Applications that contain both realtime and
	non-realtime components must be explicitly aware of both OS
	instances, and of their respective APIs.

e.	Fault isolation: the following faults may propagate from the
	Linux OS to the underlying RTOS, or not, depending on the
	implementation:

	i.	Excessive disabling of interrupts, if the Linux instance
		is permitted to disable them (hopefully not).

	ii.	Memory corruption, if the Linux instance is given direct
		access to the hardware MMU or to DMA-capable I/O devices.

f.	Hardware and software configurations supported: depends on
	the implementation, however, there are products with this
	architecture that support SMP and a reasonable variety of devices.
	Note that supporting a large variety of devices either requires
	that this support be present in the RTOS, or that Linux be
	granted access to the devices.  In the latter case, Linux will
	likely have the ability to DMA over the top of the RTOS.

Strengths:  Excellent scheduling latencies.  Hard-realtime support for
	some services in some configurations.  Reasonable fault isolation
	for some implementations.  Well-tested and robust implementations
	are available (I-pipe, L4Linux, RT-Linux, ...).

Weaknesses:  Realtime application software must deal with two separate
	OS instances and their respective APIs, with explicit
	communication.	Administrators must deal with two OS instances.
	Non-realtime applications are likely to suffer significant
	performance and scalability penalties.


5.  Dual-OS/Dual-Core

Linux and RTOS instances run side-by-side on different CPUs in the
same system.  The CPUs might be different physical CPUs, different
hardware threads in the same CPU, or different virtual CPUs provided by
a virtualizing layer, such as Xen.  The two instances might or might not share
memory, and, if they do share memory, there might or might not be hardware
protection to prevent one OS from overwriting the other OS's memory.

a.	Quality of service: hard realtime, with timeframe of about 10
	microseconds for services provided by the RTOS.  Extremely simple
	polling-loop "RTOSes" could potentially provide sub-microsecond
	latencies.  More complex services (I/O, task creation, and so on)
	will likely take longer to execute.  Since the Linux instance
	runs on a separate core, there need not be any performance or
	scalability penalty for non-realtime tasks.

b.	Amount of code that must be inspected to assure quality of service
	by a new feature: all of the RTOS, but only the RTOS.  One would
	strive to keep the RTOS quite small, but the greater the number
	of realtime services provided, the larger the RTOS must be.

	One important exception: if the RTOS and the Linux kernel access
	a shared hardware device (including memory!), it may be possible
	for Linux accesses to that hardware device to stall the RTOS.

c.	API provided: Whatever the RTOS wants to provide, often a
	subset of POSIX with realtime extensions.

d.	Relative complexity of OS and applications: there are now two
	operating systems, both of which must be configured and
	administered.  Applications that contain both realtime and
	non-realtime components must be explicitly aware of both
	OS instances and APIs, and must also be aware of whatever
	hardware facility is used to communicate between the realtime
	and non-realtime CPUs.

e.	Fault isolation: the following faults may propagate from the
	Linux OS to the underlying RTOS, or not, depending on the
	implementation:

	i.	Memory corruption, but only if the Linux instance is given
		direct access to the RTOS's memory or to DMA-capable
		I/O devices that can access the RTOS's memory.

f.	Hardware and software configurations supported: depends on
	the implementation, however, there are products based on this
	approach that support SMP and a reasonable variety of devices.

Strengths:  Best possible scheduling latencies with the hardest reasonable
	realtime -- just as good as bare metal in some implementations.
	Best possible fault isolation for some implementations.
	Well-tested and robust implementations are available.
	Linux can be used as is, so full performance and scalability
	can be provided to non-realtime tasks.

Weaknesses:  Realtime application software must deal with two separate
	OS instances, with explicit communication.  Administrators must
	deal with two OS instances.  "RTOSes" that provide the best
	latencies offer the least services -- in extreme cases, the only
	service is execution of raw code on bare metal.  The pair of cores
	will be more expensive than a single core, though one might
	use virtualization to emulate the two CPUs.


6.  Migration Between OSes

A Linux and RTOS instance run side-by-side in the same system.  The two
OSes might run on different physical CPUs, different hardware threads
in the same CPU, different virtual CPUs provided by a virtualizing
layer like Xen, or alternatively, the two OSes might use some sort
of interrupt-pipeline scheme (such as Adeos) to share a single CPU.

However, applications see a single unified environment.  Applications
run on the RTOS, but the RTOS provides Linux-compatible system calls and
memory layout.  If the application invokes a non-realtime system call,
the task is transparently migrated to the Linux OS instance for the
duration of that system call.  This differs from the other dual-OS
approaches, where the applications must be explicitly aware of the
different OSes.

At this writing, it appears that the two instances need to share memory,
since tasks can migrate from one OS to the other.

a.	Quality of service: hard realtime, with timeframe of about 10
	microseconds for services provided by the RTOS.  More complex
	services (I/O, task creation, and so on) will likely take longer
	to execute.  It is also possible for tasks to be "trapped"
	in the Linux instance, for example, if they are sleeping, but
	have not yet been given a chance to respond to some event that
	should wake them up.  The performance and scalability penalties
	to non-realtime tasks can be expected to depend on the amount
	of protection provided for realtime tasks against non-realtime
	misbehavior -- the greater the protection, the greater the
	expected penalty.  It may be possible to provide hardware
	support to improve this tradeoff.

b.	Amount of code that must be inspected to assure quality of service
	by a new feature:

	i.	All of the RTOS.  One would strive to keep the RTOS
		quite small, but the greater the number of realtime
		services provided, the larger the RTOS must be.

	ii.	Any Linux-kernel code that disables interrupts.
		Note that in many implementations, the Linux kernel
		will be prevented from disabling interrupts, since
		any attempt to disable interrupts will trap into
		the RTOS or into the underlying software/firmware
		layer (e.g., Xen or Adeos).

		If the Linux kernel runs in privileged mode, however,
		all bets are off.  In this case, special care must be
		used to avoid disabling the real hardware interrupts,
		including such disabling within any kernel modules
		that might be loaded.

	iii.	Any code that manipulates hardware that can stall the
		bus, delay interrupts, or otherwise interfere with
		forward progress.  Note that it is also necessary to
		inspect user-level code that directly manipulates such
		hardware.

	iv.	Any Linux code that manipulates a data structure that
		the RTOS accesses.  If the Linux and RTOS code
		share any sort of lock, then all critical sections
		of that lock must be inspected, as must the implementation
		of the lock itself.  The same is true of any shared mutex,
		shared semaphore, or other shared resource.

c.	API provided: Full POSIX with realtime extensions.  Anytime
	a task running in the context of the RTOS attempts to execute
	a non-realtime system call, it is migrated to the Linux instance.

d.	Relative complexity of OS and applications: there are now two
	operating systems, both of which must be configured and
	administered.  However, applications can be written as if
	there was only one OS instance that provided the full set
	of services, some realtime and some not.

e.	Fault isolation: the following faults may propagate from the
	Linux OS to the underlying RTOS, or not, depending on the
	implementation:

	i	Excessive disabling of interrupts, if the Linux OS
		is permitted to disable hardware interrupts (hopefully
		not, though preventing this may require special hardware).

	ii.	Memory corruption, either due to wild pointer or
		via wild DMA.

f.	Hardware and software configurations supported: depends on
	the implementation, however, it is reasonable to believe that
	SMP and a reasonable variety of devices could be supported.
	Note that supporting a large variety of devices either requires
	that this support be present in the RTOS, or that Linux be
	granted access to the devices.  In the latter case, Linux will
	likely have the ability to DMA over the RTOS.

Strengths:  Excellent scheduling latencies.  Hard-realtime support for
	some services in some configurations.  Applications see a
	single OS.

Weaknesses:  Administrators must deal with two OS instances.
	The two OSes will be extremely sensitive to each other's
	version and patch level, since they access each other's
	data structures.


7.  Migration Within OS

A Linux instance runs on multiple CPUs, either different physical CPUs,
different hardware threads in the same CPU, or different virtual CPUs
provided by a virtualizing layer such as Xen.  Some (but not all!) of
the CPUs are designated as realtime CPUs.  If a task running on a
realtime CPU executes a trap or system call that contains non-deterministic
code sequences, the task is migrated to a non-realtime CPU to complete
execution of the trap or system call, then migrated back.  This prevents
any non-realtime execution of a given realtime task from interfering
with that of other realtime tasks.

Interrupts can be directed away from realtime CPUs.  Such interrupt
redirection is supported on a few architectures, and has in fact been
used for realtime support since at least the 2.4 kernel.

a.	Quality of service: ~40 microseconds for ARTiS, with restricted
	hard/firm realtime supported for user-mode execution.  More
	complex services (I/O, task creation, and so on) will likely take
	longer to execute.  It is also possible for tasks to be "trapped"
	on the non-realtime CPUs, for example, if they are sleeping,
	but have not yet been given a chance to respond to some event
	that should wake them up.  Since a stock non-CONFIG_PREEMPT Linux
	may be used, there need be no performance or scalability penalty
	for non-realtime tasks, nor for realtime tasks that execute only
	realtime operations.  There can be a significant migration penalty
	when realtime tasks frequently execute non-realtime operations.

b.	Amount of code that must be inspected to assure quality of service
	by a new feature:

	i.	Any part of the Linux kernel that is permitted to execute
		on the realtime CPUs.  This would normally be only the
		realtime portions of the scheduler and the low-level
		interrupt and trap handling code (the actual interrupts
		and traps would be migrated, if necessary).

	ii.	Any critical section of any lock acquired by the portion
		of the Linux kernel that is permitted to execute on the
		realtime CPUs.

	iii.	Any code that manipulates hardware that can stall the
		bus, delay interrupts, or otherwise interfere with
		forward progress, but only if that hardware can affect
		or is used by both the realtime and the non-realtime
		CPUs.

		That said, note that it is also necessary to inspect
		user-level code that directly manipulates such hardware.

c.	API provided: Full POSIX with realtime extensions.

d.	Relative complexity of OS and applications: There is but
	one OS, though it has a bit of added complexity due to the
	migration capability.  Applications see only one OS.

e.	Fault isolation: the following faults may propagate from the
	non-realtime CPUs to the realtime CPUs:

	i	Holding a lock, mutex, or semaphore for too long, when
		that resource must be acquired by code that is permitted
		to run on the realtime CPUs.

	ii.	Memory corruption, either due to wild pointer or
		via wild DMA.

f.	Hardware and software configurations supported: all configurations,
	though single-CPU systems must have some sort of virtualizing
	facility so that the OS sees at least two virtual CPUs.

Strengths:  Excellent scheduling latencies.  Hard-realtime support for
	some services in some configurations.  Applications and
	administrators see a single OS and API.  Full performance and
	scalability for non-realtime and for pure-realtime tasks.

Weaknesses:  Migration overhead.  Requires multiple CPUs, either real or
	virtual.


D.  OTHER ASPECTS OF REALTIME

1.	PRIORITY INVERSION PROBLEM STATEMENT
2.	PRIORITY INVERSION SOLUTIONS
3.	PRIORITY INVERSION AND PTHREADS


1.  PRIORITY INVERSION PROBLEM STATEMENT

Priority inversion is a situation where a low-priority thread is holding
a resource that a high-priority task needs.  Priority inversion can
result in indefinite delay of the high-priority task, so is fatal for
realtime applications, and, in extreme cases, can be intolerable even
for non-realtime applications.

To see how priority inversion can happen, consider the following sequence
of events:

a.	Low-priority thread A acquires a pthread_mutex.

b.	Medium-priority thread B starts executing CPU-bound, preempting
	thread A.

c.	High-priority thread C attempts to acquire the pthread_mutex,
	but is blocked because A holds it.

Suppose that thread B is a realtime thread and that it will execute
CPU-bound indefinitely.  Since it is a realtime thread, its priority
will never age down, so low-priority thread A will never get to execute.
Thread A will therefore never release the pthread_mutex, so high-priority
thread C will never be able to proceed.  This situation is fatal for
realtime systems, and can be literally so if thread C is controlling
a life-support system.

Note that although this example used a pthread_mutex, many other types
of resources can be involved in a priority-inversion situation.  For
a second example, consider the following sequence of events:

a.	Low-priority task A holds a large block of memory, which
	it is about to free up.

b.	Medium-priority task B starts executing CPU-bound, preempting
	task A.

c.	High-priority task C attempts to allocate some memory, but
	is blocked because the system is short on memory, and A has
	not yet freed up its large block.

Different type of resource, but very similar result.  This problem is
not limited to mutexes and memory, some other types of resources that
can be involved in priority inversion include:

a.	Communications packets.  Low-priority task A is prevented
	from transmitting by medium-priority task B, thereby blocking
	high-priority task C, which needs to receive the packet that
	task A is being prevented from sending.  In the case of things
	like TCP/IP, the priority inversion can span multiple systems,
	for example, tasks A and B might be on one system and task C
	on another system on the same LAN.

b.	Signals and/or events.  Low-priority task A is prevented from
	posting by medium-priority task B, thereby blocking
	high-priority task C, which needs to receive the signal/event
	that task A is being prevented from sending.

c.	File data.  Low-priority task A is prevented from writing out
	data to a file by task B, thereby blocking task C, which needs
	this data in order to proceed with its own processing.

The hard cold fact is that pretty much any resource that can cause a
task to block can be involved in a priority inversion situation.


2.  PRIORITY INVERSION SOLUTIONS

There are a number of ways of preventing priority inversion:

a.	Disable preemption while a resource is held.
b.	Forbid resources to be acquired by tasks of different priorities.
c.	Priority inheritance.

These are each covered in the following sections.


a.  Disable preemption while a resource is held.

A simple, but effective, way to prevent priority inheritance is to
simply disable preemption during the time that the resource is held.
This works very well for some sorts of resources, particularly
locks.  The CONFIG_PREEMPT option in the Linux kernel uses this for
all spinlocks and also for RCU read-side critical sections.  However,
this approach is impractical for resources that may be held while
blocked, such as sema_t sleeplocks, memory, and communications,
the latter of which might involve memory allocation, which might
block if the system is low on memory.

Even where disabling preemption does work well, it can degrade
scheduling latencies.  Since a major goal of extreme realtime
support is to -reduce- scheduling latencies, other approaches are
needed.


b.  Forbid resources to be acquired by tasks of different priorities.

The "diamond-hard" realtime approach is to simply prohibit tasks of
different priorities from sharing any blocking resources.  This is
simple in principle, but can become quite complex in practice.  In some
cases, non-blocking mechanisms can be used, such as asynchronous I/O
or non-blocking synchronization.  However, although non-blocking mechanisms
can prevent the high-priority task from blocking, they are of no
help if the high-priority task really needs the information held
by the low-priority task.  In such cases, it may be necessary to
dynamically adjust priorities, perhaps via schemes such as deadline
scheduling.

There is a huge body of literature on realtime scheduling mechanisms at
all levels of complexity and effectiveness, which cannot be reproduced
here.  However, a conceptually simple approach would be to increase the
priority of "supplier" tasks so that "consumer" tasks get what they
need when they need it.  If this is automated, it is called "priority
inheritance".


c.  Priority inheritance.

With priority inheritance, the holder of a given resource is temporarily
boosted to the maximum priority of all tasks waiting for that
resource.  This temporary priority-boost is removed as soon as the resource
is released.

Of course, there can be complications, for example, a given low-priority
task might be holding multiple locks, each of which is being waited on
by different high-priority tasks.  While the low-priority holds all of
these locks, its priority is boosted to that of the highest-priority
task waiting on any of the locks, but when it releases one of the locks,
it might be necessary to decrease (but not eliminate) the boost to allow
for the smaller set of high-priority tasks still waiting.

Another complication is "transitivity", where a low-priority task A
holds one lock needed by medium-priority task B, which in turns holds
a second lock needed by high-priority task C.  In this case, task A
needs to inherit task C's priority in a transitive manner through
both of the locks.  Such a priority inheritance chain could be
arbitrarily long.

Furthermore, avoiding blocking does not necessarily make the underlying
problem go away, for example, suppose that the high-priority task was
executing the following loop:

	for (;;) {
		spin_trylock(&my_mutex);
		set_current_state(TASK_UNINTERRUPTIBLE);
		schedule_timeout(HZ / 100);
	}

The standard priority-inheritance mechanisms would not understand the
need to priority boost in this case.  But suppose that they did.  Then
what would they make of the following code?

	for (;;) {
		spin_trylock(&my_mutex);
		if ((random() & 0xfff) == 0)
			break;
		set_current_state(TASK_UNINTERRUPTIBLE);
		schedule_timeout(HZ / 100);
	}

How is the priority-inheritance mechanism going to figure out that it
should remove the priority boost when the high-priority task breaks
out of the loop?

Despite such complications, priority inheritance works reasonably
well for exclusive locks, and is a major component of Ingo Molnar's
CONFIG_PREEMPT_RT patch.  There are strongly held opinions both for and
against priority inheritance, for example:

	http://www.linuxdevices.com/articles/AT7168794919.html

in which Victor Yodaiken considers priority inheritance to be
harmful, and, as near as I can tell, soft realtime to be irrelevant.
Doug Locke posted a rebuttal at:

	http://www.linuxdevices.com/articles/AT5698775833.html

The big advantage of priority inheritance is that it is simple for
its users.  Use of priority inheritance does degrade scheduling
latency compared to a carefully hand-crafted solution, and priority
inheritance's implementation is difficult for reader-writer locks,
to say nothing of memory allocation or communications primitives.

Nevertheless, priority inheritance does seem to have a significant
role to play in mainstream "metal hard" realtime.  It is not perfect,
but, then again, what is?


3.  PRIORITY INVERSION AND PTHREADS

Inaky Perez-Gonzalez's "fusyn" project is intended to bring priority
inheritance to user-level pthread_mutex primitives, although it (perhaps
wisely) leaves reader-writer primitives alone.  More information on
fusyn may be found at the following web sites and LKML threads:

	http://developer.osdl.org/dev/robustmutexes/fusyn/20040510
	http://marc.theaimsgroup.com/?l=linux-kernel&m=111362457509145&w=2
	http://marc.theaimsgroup.com/?t=111333601400001&r=1&w=2

Interestingly enough, the complexity of pthread_mutex priority
inheritance depends strongly on the threading model in use.  Linux
NPTL uses a 1:1 threading model, so that each user-visible pthread
has its own kernel task.  In this threading model, priority inheritance
can be carried out entirely by the Linux kernel, since all pthreads
are visible to it.

However, some pthreads implementers choose an m:n threading model, where
a user-level thread scheduler multiplexes multiple user-visible pthreads
onto a potentially smaller set of kernel tasks.  In this m:n case, the
Linux kernel has no idea which of multiple tasks it should priority-boost,
and it might well be that the pthread in need of a boost is currently
not assigned to a task.  Therefore, m:n priority boosting must involve
both the kernel and the user-level schedulers, making it quite complex
and fragile.

Therefore, use of 1:1 user-level thread scheduling is recommended in
the strongest possible terms.

Why use m:n user-level thread scheduling in the first place?  It turns
out that some application benefit from the extremely efficient
user-level context switches that m:n scheduling provides.  However,
every optimization has its price, and the price of m:n user-level thread
scheduling becomes apparent in realtime systems.


E.  SUMMARY

At this point, it does not appear that any one approach can be all things
to all realtime applications.  It is therefore too early to pick a winner.
Advocates of a given approach are therefore advised to concentrate their
energy on implementations of their favorite approach, rather than engaging
in flamewars with advocates of other approaches.  ;-)

After all, in the end, the approaches that best meet the needs of the
user community will win out.  In fact, given that the Linux community
has come up with no fewer than seven classes of solutions to a problem
that is commonly thought to be unsolvable, it seems quite reasonable
to expect that yet more classes of solutions will yet appear.

So, which of these approaches can be combined?  The first three can
be thought of as elaborations on the general preemption theme, and
can be combined with each of the remaining four.  The nested-OS and
dual-OS/dual-core ideas can be combined by having one of the OSes
on one of the cores have another OS nested within it.   The
dual-core/dual-OS approach can be combined with either of the
migration approaches, simply by having one of the cores implement
the migration approach.  It should be possible to combine the two
migration approaches, though it is not clear that this is useful.

Regardless of whether Linux's direction ends up being a single one of
these approaches, a yet-as-unknown approach, some combination, or one
of several approaches depending on the workload, realtime Linux looks
to remain an exciting area.


F.  RESOURCES

1.  General Discussion

http://marc.theaimsgroup.com/?l=linux-kernel&m=111689227213061&w=2

	Spirited LKML debate on realtime Linux that inspired this
	document.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111846495403131&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=111928813818151&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=112008491422956&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=112086443319815&w=2

	Kristian Benoit's and Karim Yaghmour's realtime-latency
	measurement LKML threads.

http://www.cs.utah.edu/~regehr/papers/hotos7/hotos7.html
http://www.rme-audio.de/english/techinfo/nforce4_tests.htm

	Description of how hardware latencies can impact response time.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111362457509145&w=2
http://marc.theaimsgroup.com/?t=111333601400001&r=1&w=2

	LKML discussions of "fusyn" priority-inheritance implementation
	of pthread_mutex.


2.  Example Realtime Approaches

ftp://kernel.org/pub/linux/kernel/v2.6

	Linux kernel source for non-CONFIG_PREEMPT and CONFIG_PREEMPT
	kernels.

http://people.redhat.com/mingo/realtime-preempt/

	Ingo Molnar's CONFIG_PREEMPT_RT patch.

http://marc.theaimsgroup.com/?l=linux-kernel&m=112051169508144&w=2

	Philippe Gerum's I-pipe patch 2.6.12-v0.9-00.  This is an
	example of the nested-OS approach, with I-pipe being an
	extreme example of an lightweight enclosing OS.

http://download.gna.org/rtai/documentation/fusion/pdf/Life-with-Adeos.pdf
http://download.gna.org/rtai/documentation/fusion/pdf/Introduction-to-UVMs.pdf
http://download.gna.org/rtai/documentation/fusion/pdf/Native-API-Tour.pdf

	Documents describing Philippe Gerum's RTAI/fusion approach,
	which is an example of migration between OSes.

http://www.lifl.fr/west/publi/MPSD04rtlws.pdf
http://lkml.org/lkml/2005/5/3/50

	Paper describing ARTiS (Asymmetric RealTime SMP), an example
	of the migration-within-OS approach, along with an LKML posting
	of the corresponding Linu patch.  Additional ARTiS publications
	may be found at http://www.lifl.fr/west/artis/.


ACKNOWLEDGEMENTS

This document was extracted from the emails and code of a large number
of people, including those listed below in alphabetic order.  Please
accept my apologies if I left you out, and please let me know of this
or any other error or omission so that I can generate the fix.

Andi Kleen
Andrea Arcangeli
Andrew Morton
Bill Davidsen
Bill Huey
Brian O'Mahoney
Chris Friesen
Con Kolivas
Daniel Walker
Darren Hart
David Lang
Duncan Sands
Elladan
Eric Piel
Esben Nielsen
Gene Heskett
Giuseppe Bilotta
Hari N
Henry Kingman
Ingo Molnar
James R Bruce
John Alvord
Jonathan Corbet
K.R. Foley
Karim Yaghmour
Kristian Benoit
Kusche Klau
Lee Revell
Manas Saksena
Marcelo Tosatti
NZG
Nick Piggin
Nicolas Pitre
Paul G. Allen
Paulo Marques
Peter Chubb
Philippe Gerum
Steven Rostedt
Sven-Thorsten Dietrich
Takashi Iwai
Theodore Y Tso
Thomas Gleixner
Tim Bird
Tom Vier
Valdis Kletniek
William Lee Irwin III
Zan Lynx
Zwane Mwaikambo
john cooper
