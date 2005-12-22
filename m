Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVLVL6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVLVL6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVLVL6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:58:15 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:30920 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S964819AbVLVL6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:58:12 -0500
Date: Thu, 22 Dec 2005 03:56:32 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: quick overview of the perfmon2 interface
Message-ID: <20051222115632.GA8773@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051219113140.GC2690@frankl.hpl.hp.com> <20051220025156.a86b418f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220025156.a86b418f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Thanks for carefully reviewing this document.

On Tue, Dec 20, 2005 at 02:51:56AM -0800, Andrew Morton wrote:
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> > 
> > 	Sampling is supported at the user level and also at the kernel level with
> > 	the ability to use a kernel-level sampling buffer. The format of the kernel
> > 	sampling buffer is implemented by a kernel pluggable module. As such it is
> > 	very easy to develop a custom format without any modification to the
> > 	interface nor its implementation.
> 
> Why would one want to change the format of the sampling buffer?

The initial perfmon interface design as implemented in the 2.4 kernel series
did not have this feature. It was added to the 2nd generation for the following
reason:
	- allow support of existing kernel profiling infratructures such as
	  Oprofile or VTUNE (the VTUNE driver is open-source)

	- added flexibility in the way samples are recorded: what is recorded
	  how it is recorded. 

	- ability to support hardware sampling buffer

Take the example of earlier versions Oprofile, they already had all the kernel
infrastructure to record the interrupted instruction pointer + OS events such
as mmap/exit to help correlate samples with actual programs. Just looking
at their sampling buffer, they were aggregating samples instead of storing
them linearly. That is how the original DEC's DCPI implementation worked.
Our default sampling format stores samples sequentially, it would not have
been easy to adapt Oprofile-based tools to use this model. Another example
is the old VTUNE driver, they were using a single buffer to collect samples
across all CPUS. We have one buffer per CPU. 

But now you can imagine people wanting to record other type of information
beyond PMU registers. For instance we have developed that collect a full
kernel call stack on counter overflow. Oprofile today does this but it is
hardcoded in the core of Oprofile. We can do this without any change to
the core of perfmon.

On Linux/ia64, Oprofile is hooked up to perfmon by a custom sampling format.
This format does virtually nothing besides connecting the perfmon interrupt
handler to the rest of the Oprofile infrastructure. We re-use 99% of the
Oprofile kernel code without any modifications. They still export their buffer
the way they use to, i.e. their own driver interface. They moved the setup
of the PMU over to the perfmon interface in the user level code.

Custom formats come in handy to support hardware sampling buffers. Take the
example of the P4/Xeon PMU. The Precise Event Based Sampling (PEBS) support
lets the CPU directly stores samples in a designated memory area. This
has two advantages:
	- the CPU stores the actual instruction pointer of where the counter
	  overflowed, that where the precision comes from. Typically (and not
	  just on P4), there is a skew between where the counter overflow and
	  where the PMU interrupts. 

	- This is faster because you only take  a PMU interrupt when the CPU runs
	  out of space

How would you support this if the buffer format was hardcoded? As you can see it is
not just about speed but also about gaining in precision, i.e. attributing samples
to where they actually occurred. The PEBS is implementation specific. There is no
guarantee it will exist in future Intel processors, for instance it does not exist
on Pentium M. It quicly becomes hard to maintain if you have have to ifdef this in
or out based on CPUID. With out custom format, it took about 200 lines of code and
almost no modification to the perfmon generic code. This is the first time PEBS
is really exposed to applications inside a generic interface. Neither Oprofile
nor perfctr support this today.

We provide a builtin default format that is fairly generic and that stores
samples with PMU information in a linear buffer. It may be good enough
for many tools already. For instance HP Caliper uses it, I believe it may
be good enough for VTUNE. 

To comment on complexity, I don't think this adds much. It simply separates
existing code and adds some simple registration code.

> 
> Would much simplification be realised if we were to remove this option?
> 

I think it would be too limiting, for instance you would forfeit PEBS on
P4/Xeon.

> > 	   Attach a perfmon context to either a thread or a processor. In the
> > 	   case of a thread, the thread id is passed. In the case of a
> > 	   processor, the context is bound to the CPU on which the call is
> > 	   performed.
> 
> Why should userspace concern itself with a particular CPU?  That's really
> only valid if the process has bound itself to a single CPU?  If the CPU is
> fully virtuialised by perfmon (it is) then why do we care about individual
> CPU instances?
> 
See just below.

> 
> > 	A system-wide context allows a tool to monitor all activities on one
> > 	processor, i.e, across all threads. Full System-wide monitoring in an
> > 	SMP system is achieved by creating and binding a perfmon context on
> > 	each processor. By construction, a perfmon context can only be bound
> > 	to one processor at a time.  This design choice is motivated by the
> > 	desire to enforce locality and to simplify the kernel implementation.
> 
> hm.  I'm surprised at such a CPU-centric approach.  I'd have expected to
> see a more task-centric model.
> 
You need both modes. We support both modes using the same interface. There is
just a flag to speciy to create a CPU-centric perfmon context. In system-wide
mode you are interested in monitoring everything that is happening on one
processor. This is the mode in which OProfile, VTUNE works for instance.
They collect everything and then you can filter out samples per threads.
In per-thread mode, the PMU is actually virtualized, i.e., it becomes part
of the thread's machine state and is saved/restored on context switch.
The per-thread mode is more challenging to implement but allows more
specific measurements to be made. For instamce, I can measure how
many instructions where executed in function foo() of my thread.

How you design system-wide?

You have two choices:
	- allow a single thread to monitor multiple CPUs with a single
	  perfmon context
	- enforce that a thread can monitoring only one CPU. Full coverage
	  of SMP is achieved by creating and pinning a thread per-CPU.

We chose the second design because it is simpler to implement in the kernel
and scales much better because it enforces locality which is important when
sampling, i..e, the buffer is allocated on the monitored CPU. This also meshes
where well with hardware features such as P4/Xeon PEBS.

The pfm_load_context() call for a system-wide context, is using the current
CPU to bind to the context regardless of the calling thread affinity bitmask.
The user does not explicitly pass the CPU number he wants to monitor.

If a thread wants to monitoring CPU2, it must be sure to run on CPU2 when
making the call. That forces it to call sched_setaffinity() to allow only
CPU2. The pfm_load_context() does not change the affinity of the thread.
We did not want to add another mechanism to change affinity. We are simply
leveraging an existing interface. Similarly, we did not want to internally
enforce a particular affinity. That means that the thread can at any time
change its affinity again. But perfmon will reject any perfmon calls
read/write PMU registers if the thread is not running on CPU2. That we
can do easily and we do not have to change sched_setaffinity(). That leaves
the door open for a thread monitoring multiple CPU but by using multiple
contexts.

> > 3/ SAMPLING SUPPORT
> >    ----------------
> > 	The notification is sent as a message and can be extracted by invoking
> > 	read() on the file descriptor of the context. The overflow message
> > 	contains information about the overflow, such as the index of the
> > 	overflowed PMD.
> > 
> > 	The interface supports using select/poll on contexts file descriptors.
> > 	Similarly, it is possible to get an asynchronous notification via SIGIO
> > 	using the regular sequence of fcntl().
> 
> So the kernel buffers these messages for the read()er.  How does it handle
> the case of a process which requests the messages but never gets around to
> read()ing them?

Good question. Let's see what happens with the default sampling buffer format.
When the buffer fills up, monitoring is stopped and a notification message is
enqueued. If the tool never gets around to actually calling read(), a single
message will be queued forever. No other message is generated because monitoring
is stopped until the user issues a pfm_restart().

There needs to be a queue because some formats may implement a double buffering
scheme where monitoring is never actually stopped. The queue needs to be as
deep as the number of active buffers.

> > 4/ SAMPLING BUFFER SUPPORT
> >    -----------------------
> > 
> > 	User level sampling works but it is quite expensive especially when for
> > 	non self-monitoring threads. To minimize the overhead, the interface also
> > 	supports a kernel level sampling buffer. The idea is simple: on overflow
> > 	the kernel record a sample, and only when the buffer becomes full is the
> > 	user level notification generated. Thus, we amortize the cost of the
> > 	notification by simply calling the user when lots of samples are available.
> > 
> > 	This is not such a new idea, it is present in OProfile or perfctr.
> > 	However, the interface needs to remains generic and flexible. If
> > 	the sampling buffer is in kernel, its format and what gets recorded
> > 	becomes somehow locked by the implementation. Every tool has different
> > 	needs. For instance, a tool such as Oprofile may want to aggregate
> > 	samples in the kernel, others such as VTUNE want to record all samples
> > 	sequentially. Furthermore, some tools may want to combine in each sample
> > 	PMU information with other kernel level information, such as a kernel
> > 	call stack for instance. It is hard to design a generic buffer format
> > 	that can handle all possible request. Instead, the interface provides
> > 	an infrastructure  in which the buffer format is implemented by a kernel
> > 	module. Each module controls, what gets recorded, how it is recorded,
> > 	how the information is exported to user, when a 'buffer full'
> > 	notification must be sent. The perfmon core has an interface to
> > 	dynamically register new formats. Each format is uniquely identified by
> > 	a 128-bit UUID which is passed by the tool when the context is created.
> > 	Arguments for the buffer format are also passed during this call.
> 
> Well that addresses my earlier questions I guess.

You had this question earlier about:
	int pfm_create_context(pfarg_ctx_t __user *ctx, void *__user smpl_arg, size_t smpl_size);

> What is at *smpl_arg?  Anonymous pointers to userspace like this aren't
> very popular - strongly typed interfaces are preferred.
> 

Each sampling format may have options that must be passed when the context is created. There is
no predefined structure for such options. For the default format, for instance, you can pass the
size of the buffer you want. But you can imagine other things. As such the smpl_arg must be void *.
Now the smpl_size argument is NOT the size of the buffer but the size of the smpl_arg argument.
The format requested is identified by its UUID included in the ctx argument. The kernel takes
the UUID, checks that is is registered. If found, the kernel then checks if the smpl_size matches
with the format expected option size. If not, the call fails.

We have a set of protections to avoid abuses especially of the vector arguments for many of the
calls. The vector cannot be bigger than page. The same thing applies to sampling format options.

> Is this actually useful?  oprofile is there and works OK.  Again, is there
> overdesign here?

I think I answer this question at the beginning about sampling formats.

> 
> And why is it necessary to make the presentation of the samples to
> userspace pluggable?  I'd have thought that a single relayfs-based
> implementation would suit all sampling buffer formats.

What is pluggable: the policy code that decides what gets recorded and
how. The samples are exposed to user via mmap() on the file descriptor
identifying the context.

> 
> > 	As part of the infrastructure, the interface provides a buffer allocation
> > 	and remapping service to the buffer format modules. Format may use this
> > 	service when the context is created. The kernel memory will be reserved
> > 	and the tool will be able to get access to the buffer via remapping
> > 	using the mmap() system call. This provides an efficient way of
> > 	exporting samples without the need for copying large amount of data
> > 	between the kernel and user space. But a format may choose to export
> > 	its samples via another way, such as a device driver interface for
> > 	instance.
> 
> It doesn't sound like perfmon is using relayfs for the sampling buffer. 
> Why not?

Relay-fs was also suggested by David Gibson. I don't have anything against
it. The problem is that it is CPU-centric. So it would probably work for
system-wide monitoring where we do effectively measure on a per-CPU basis.
But for per-thread monitoring this does not work correctly. You don't really
want to have a relay-fs buffer per-CPU per-thread and NR_CPUS file descriptors opens
per thread. It also makes it hard to reconstruct a per-thread sequential buffer.

Note that to expose the samples, we have not invented any new mechanism. We simply
leverage the existing mmap() call and the fact that we use a file descritor to
identify a context.

> > 	For each PMD, the interface provides three possible values which are
> > 	used when sampling. The initial value is that is first loaded into the
> > 	PMD, i.e., the first sampling period. On overflow which does not
> > 	trigger a user level notification, a so-called short reset value is
> > 	used by the kernel to reload the PMD. After an overflow with a user
> > 	level notification, the kernel uses the so-called long reset value.
> > 	This mechanism can be exploited to hide the noise induced by the
> > 	recovery after a user notification.
> > 
> > 	The interface also supports automatic randomization of the reset value
> > 	for a PMD after an overflow.
> 
> Why would one want to randomise the PMD after an overflow?
> 

I think several people have already explained this. But I would add one
more thing. The phenomenom is somewhat aggravated when doing per-thread 
sampling using events that are not so much affected by what is going on
in the system overall. In an earlier E-mail about this, I mentioned sampling
on return branches. The number of return branches is not affected by where
you run, the number of competing threads, the rate of interrupts. So there
is not so much this kind of "implicit" randomization that you would get
is you were to sample on cycles for instance. Overall randomization is very
important feature. It needs to be in the kernel because of the kernel level
sampling buffer.


> > 
> > 6/ PMU DESCRIPTION MODULES
> >    -----------------------
> > 
> > 	The logical PMU is driven by a PMU description table. The table
> > 	is implemented by a kernel pluggable module. As such, it can be
> > 	updated at will without recompiling the kernel, waiting for the next
> > 	release of a Linux kernel or distribution, and without rebooting the
> > 	machine as long as the PMU model belongs to the same PMU family. For
> > 	instance, for the Itanium Processor Family, the architecture specifies
> > 	the framework for the PMU. Thus the Itanium PMU specific code is common
> > 	across all processor implementations. This is not the case for IA-32.
> 
> I think the usefulness of this needs justification.  CPUs are updated all
> the time, and we release new kernels all the time to exploit the new CPU
> features.  What's so special about performance counters that they need such
> special treatment?
> 
There are several issues that we are trying to solve with this feature:
	- evolving hardware
	- defining custom virtual registers
	- debugging and support

It is true that you produce kernels everyday. However most of the users don't
use your kernels but those of commercial vendors which evolve at a much slower
pace.

Let's take an example on Itanium. Take a user running a commercial distro
based on 2.6. This user is given early access to a Montecito machine. He wants
to do some early performance analysis and needs perfmon support for Montecito,
yet he wants to stay on his kernel because it includes features that his
application depends upon. With the PMU description module, it would simply be
a matter of shipping the kernel module + updated tools. Without this, the
customer needs to recompile his kernel. The reality is, very few people know
or even want to recompile their own kernels.

The PMU is very implementation specific and hard to debug. It can be updated
from one stepping to the next. Software release cycles may not necessarily
match hardware release cycles.

As Dan and Phil mentioned, there are other usage of this for special processor
registers, chipset counters and the likes.

It is also very attractive to be able to expose an OS resource as a PMD register.
Dan mentioned using this to export PID, TID, but you can extend this to other OS
resources such as the amount of free memory, the number of tasks and so on. What
is the advantage? At the user level, they look like regular PMU resources and they
become very easy to include into samples. In summary, it becomes possible to sample
on resources which would otherwise be hard to get to from user level.

> 
> Overall: I worry about excessive configurability, excessive features.
> 
In general I am not a big fan of putting stuff in the kernel just because it's
cool to be kernel developer. Quite to the contrary, if I could get out of
the kernel development, it would certainly make my work easier.
Every feature that is supported by perfmon was put in there because
of user needs and because there was no better way to implement them in
user space and yet provide the same level of efficiency or simplicity.

The best examples being:
	- the sampling buffer
	- event set and multiplexing

The best counter example being:
	- full coverage of an SMP system for system-wide measurement
	  is implemented at the user level by a collection of threads
	  pinned on each CPU. This was preferred over the model of a
	  single thread monitoring all CPUS with the kernel
	  sending IPI across all CPUs to program/start/stop.

Thanks to David, Dan and Phil for their comments.

-- 
-Stephane
