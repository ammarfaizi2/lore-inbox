Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRC2RWx>; Thu, 29 Mar 2001 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132800AbRC2RWo>; Thu, 29 Mar 2001 12:22:44 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:43047 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S132796AbRC2RWa>; Thu, 29 Mar 2001 12:22:30 -0500
Message-Id: <4.3.2.7.2.20010329080844.00b65380@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 29 Mar 2001 09:21:06 -0800
To: David Konerding <dek_ml@konerding.com>,
   Guest section DW <dwguest@win.tue.nl>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: OOM killer???
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AC357B8.72860494@konerding.com>
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int>
 <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de>
 <20010329130154.A8701@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:41 AM 3/29/01 -0800, David Konerding wrote:
>Now, if you're going to implement OOM, when it is absolutely necessary, at 
>the very
>least, move the policy implementation out of the kernel.  One of the general
>philosophies of Linux has been to move policy out of the kernel.  In this 
>case, you'd
>just have a root owned process with locked pages that can't be pre-empted, 
>which
>implemented the policy.  You'll never come up with an OOM policy that will fit
>everybody's needs unless it can be tuned for  particular system's usage, 
>and it's
>going to be far easier to come up with that policy if it's not in the kernel.

SUMMARY OF COMMENT:  We need kernel support for such a userland 
process.  At a minimum, I believe we would need a means to steer term 
signals and kill signals to the correct process in a process tree, a means 
for processes to receive notification that the system is in trouble, and 
that the policy be set and the OOM killer be implemented in a daemon that 
accepts input directly from the admin in a config file, from the memory 
system via suitable interfaces, and from the processes via communications 
(probably through the process control block).  SIGDANGER needs to be 
defined, but never raised by the kernel.  There also needs to be a means 
for the OOM daemon to request the release of non-critical cache buffers

Comment follows:

I'm in basic agreement with your sentiments, but I'm concerned about how a 
userland policy system will work without some support within the 
kernel.  The support also needs to be well-enough defined that applications 
can be written to work with the policy manager.

Let's start with Oracle, as one of the examples that keeps being brought 
up.  How does Oracle deal with the problem?  Part of the problem is that we 
have a late-commit policy and no way to clean up when the processes that 
are running exceed the capacity of the machine they are running on.  The 
AIX solution at first glance seems reasonable:  give the running processes 
a chance to "become part of the solution" by freeing memory space they have 
reserved but are not using, or that can be decommissioned [cached 
information] without destroying the process work.  The policy 
implementation can by default reward those processes by lowering their 
chances of being killed if the condition is not corrected.

Another characteristic of Oracle (shared by other mission-critical systems) 
is that the thing is not implemented as a single process, but as a 
collection of running processes working together.  Arbitrarily killing one 
process can corrupt the process work of several processes.  Currently there 
is no mechanism for a process to inform the system that any kills should 
really be directed at *this* parent, so that the whole thing shuts down 
reasonably.  If such a mechanism were to be provided, any signals to ANY 
process would be steered to the "top" process.  To prevent any subtle 
attacks, we would have to define bounds on which process is identified as 
the "top" process.  (Non-root process in the process tree would probably be 
fine for non-root subprocesses; any process in the process tree except init 
would be suitable for root subprocesses.)

Several people have identified that one of the current versions of the OOM 
killer doesn't cause the release of cache buffers within the Linux 
kernel.  I've seen mention of patches to correct this problem, but if you 
move the implementation of memory overcommittment recovery from the kernel 
to userland, you will need to have some way for that userland daemon to 
tell the various subsystems to release cached information that can be 
safely released.  This lets the daemon used a structured recovery technique 
where it does (A), check to see if that opens up enough room, does (B), 
check to see if that opens enough room, and so forth.  Note that some 
method needs to tell malloc() to fail all subsequent memory requests so 
that when the daemon takes a corrective action there isn't further 
overcommittment.

Which brings up another point:  why SIGKILL?  SIGTERM would appear to be 
the proper signal at a "yellow alert" so that the process has a chance of 
going through an orderly shutdown -- which might include check-pointing 
that week-long calculation of the 6,839,294,763,900,034th prime 
number.  This is especially important for process sets -- the first time 
that the top-level ORACLE module finds out there is trouble is to get a 
SIGCHILD signal from a troop when it isn't expecting one?

Finally, I want to bring up a sore subject:  beancounting.  When I was 
taking CS 306 (Operating System Principles) at UIUC in 1972 one issue that 
came up is the management of over-committment.  Our term project, a system 
resource manager, had to deal with a load that included just the behavior 
that has been discussed here:  programs that reserved resources that it 
never uses.  In our resource monitors, we were expected to keep track of 
allocations, deallocations, and actual usage such that we could CONTROL the 
overcommittment of resources, and therefore avoid deadlock.  From my 
reading of the threads and a glance at the source, the problem is that 
processes can ask for and receive resources virtually without limit...as 
long as nobody actually uses those resources.  It's only when the processes 
try to use the resources that the system has promised the processes it can 
use that the problem rears its ugly head.

Not only should there be beancounting, but there needs to be policy input 
to the kernel when to fail malloc() et. al.  If I want to avoid all 
overcommittment, I should be able to set a value in a file in the /proc 
filesystem to zero to say "0 percent overcommittment" -- which means fail 
malloc() calls when you reach a calculated high-water mark.  Higher values 
stored in this file means higher levels of overcommittment is allowed in 
memory allocation calls.  The default at boot would be zero; the 
distributions could then decide how to set the overcommittment value in the 
start-up scripts.  The userland policy process could even tweak this 
overcommittment value on the fly if so desired, to tune the system to 
current demand and to the admin's inputs.

This helps separate the prevention measure (failing mallocs()) from the 
recovery measure (killing processes).

I see no way that the beancounting can be relegated to a userland process 
-- it needs to be in the kernel.  To avoid excess bloat in the kernel, the 
kernel should only count the beans and trigger the userland process when 
thresholds are exceeded by the system.  In this manner, no OOM killer code 
need be in the kernel at all.  No OOM killer registered?  We then revert to 
Version 7 action:  panic.

Which leads to my final point:  I believe that the SIGDANGER signal should 
be defined in Linux.  The signal would not be raised by the kernel in any 
way -- that's left to the userland OOM daemon.  The response to SIGDANGER 
would be described.  The default action would be to ignore SIGDANGER.  One 
comment is that a denial of service could be launched by a process defining 
a SIGDANGER handler that would call malloc() -- I've already mentioned the 
requirement that the userland daemon have a way of causing all calls to 
malloc() to fail.  The Linux definition would differ from the AIX 
definition, but the net result would be the same and I believe that the 
Linux definition can be written such that existing AIX-based handlers will 
work with minimum modification.

I submit this as a strawman suggestion -- I'm not married to any of the 
ideas.  Feel free to suggest alternatives that solve the problem.

Stephen Satchell



