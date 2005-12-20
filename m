Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVLTLBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVLTLBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVLTLBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:01:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750922AbVLTLBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:01:54 -0500
Date: Tue, 20 Dec 2005 02:51:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: quick overview of the perfmon2 interface
Message-Id: <20051220025156.a86b418f.akpm@osdl.org>
In-Reply-To: <20051219113140.GC2690@frankl.hpl.hp.com>
References: <20051219113140.GC2690@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@hpl.hp.com> wrote:
> 	or create full sampling measurements.
> ...
> 
> 	Sampling is supported at the user level and also at the kernel level with
> 	the ability to use a kernel-level sampling buffer. The format of the kernel
> 	sampling buffer is implemented by a kernel pluggable module. As such it is
> 	very easy to develop a custom format without any modification to the
> 	interface nor its implementation.

Why would one want to change the format of the sampling buffer?

Would much simplification be realised if we were to remove this option?

> 	To compensate for limitations of many PMU, such as a small number of
> 	counters, the interface also exports the notion of event sets and allows
> 	applications to multiplex sets, thereby allowing more events to be
> 	measured in a single run than there are actual counters.
> 
> 	The PMU register description is implemented by a kernel pluggable module
> 	thereby allowing new hardware to be supported without the need to wait
> 	for the next release of the kernel.

Is that option important, or likely to be useful?  Are you sure there isn't
some overdesign here?


> II/ BASE INTERFACE
>     ---------------
> 
> 	PMU registers are accessed by reading/writing PMC and PMD registers.
> 	The interface exposes a logical view of the PMU. The logical PMD/PMC
> 	registers are mapped onto the actual PMU registers (be them PMD/PMC or
> 	actual MSR) by the kernel. The mapping table is implemented by a kernel
> 	module and can thus easily be updated without a kernel recompile. This
> 	mechanism also makes it easy to add new PMU support inside a processor
> 	family.

Ditto.

> 	The interface is implemented using a system call interface rather than
> 	a device driver. There are several reasons for this choice, the most
> 	important being that we do want to support per-thread monitoring and
> 	that requires access to the context switch code of the kernel to
> 	save/restore the PMU state. Another reason is to reinforce the fact
> 	that the interface must be an integral part of the kernel. Lastly, we
> 	think it give us more flexibility in terms of how arguments can be
> 	passed to/from the kernel.
> 
> 	Whenever possible, the interface leverages existing kernel mechanisms.
> 	As such, we use a file descriptor to identify a perfmon context.
> 
> 	The interface defines the following set of system calls:
> 
> 	- int pfm_create_context(pfarg_ctx_t *ctx, void *smpl_arg, size_t smpl_size)

pfarg_ctx_t __user *ctx, I assume?

void __user *smpl_arg, I assume?

What is at *smpl_arg?  Anonymous pointers to userspace like this aren't
very popular - strongly typed interfaces are preferred.

> 
> 	    creates  a per-thread or system-wide perfmon context. It returns a
> 	    file descriptor that uniquely identifies the context. The regular
> 	    file descriptor semantics w.r.t. to access control, sharing are
> 	    supported.
> 
> 	- pfm_write_pmds(int fd, pfarg_pmd_t *pmds, int n)
> 
> 	    Write one or more PMD registers.
> 
> 	- pfm_read_pmds(int fd, pfarg_pmd_t *pmds, int n)
> 
> 	    Read the one or more PMD registers.
> 
> 	- pfm_write_pmcs(int fd, pfarg_pmc_t*pmcs, int n)
> 
> 	    Write the one or more PMC registers.
> 
> 	- pfm_load_context(int fd, pfarg_load_t *load)
> 
> 	   Attach a perfmon context to either a thread or a processor. In the
> 	   case of a thread, the thread id is passed. In the case of a
> 	   processor, the context is bound to the CPU on which the call is
> 	   performed.

Why should userspace concern itself with a particular CPU?  That's really
only valid if the process has bound itself to a single CPU?  If the CPU is
fully virtuialised by perfmon (it is) then why do we care about individual
CPU instances?


> 	- pfm_start(int fd, pfarg_start_t *start)
> 
> 	   Start active monitoring.
> 
> 	- pfm_stop(int fd)
> 
> 	   Stop active monitoring.
> 
> 	- pfm_restart(int fd)
> 
> 	   Resume monitoring after a user level overflow notification. This
> 	   call is used in conjunction with kernel-level sampling.
> 
> 	- pfm_create_evtsets(int fd, pfarg_setdesc_t *sets, int n)
> 
> 	    Create/Modify one or more PMU event set. Each set encapsulates the
> 	    full PMU sets.
> 
> 	- pfm_delete_evtsets(int fd, pfarg_setdesc_t *sets, int n)
> 
> 	    Delete a PMU event set. It is possible to delete one or more sets
> 	    in a single call.
> 
> 	- pfm_getinfo_evtsets(int fd, pfarg_setinfo_t *infos, int n):
> 
> 	    Return information about an event set. It is possible to get
> 	    information about one or more sets in a single call. The call
> 	    returns, for instance, the number of times a set has been activated,
> 	    i.e., loaded onto the actual PMU.
> 
> 	- pfm_unload_context(int fd)
> 
> 	    Detach a context from a thread or a processor.
> 
> 	By default, all counters are exported as 64-bit registers even when the
> 	underlying hardware implements less. This makes it much easier for
> 	applications that are doing event-based sampling because they don't
> 	need to worry about the width of counters. It is possible to turn the
> 	"virtualization" off.
> 
> 	A system-wide context allows a tool to monitor all activities on one
> 	processor, i.e, across all threads. Full System-wide monitoring in an
> 	SMP system is achieved by creating and binding a perfmon context on
> 	each processor. By construction, a perfmon context can only be bound
> 	to one processor at a time.  This design choice is motivated by the
> 	desire to enforce locality and to simplify the kernel implementation.

hm.  I'm surprised at such a CPU-centric approach.  I'd have expected to
see a more task-centric model.
	
> 	Multiple per-thread contexts can coexist at the same time on a system.
> 	Multiple system-wide can co-exist as long as they do not monitor the
> 	same set of processors. The existing implementation does not allow
> 	per-thread and system-wide context to exist at the same time. The
> 	restriction is not inherent to the interface but come from the
> 	existing implementation.
> 	
> 3/ SAMPLING SUPPORT
>    ----------------
> 
> 	The interface supports event-based sampling (EBS), where the sampling
> 	period is determined by the number of occurrences of an event rather
> 	than by time. Note that time-based sampling (TBS) can be emulated by
> 	using an event with some correlation to time.
> 
> 	The EBS is based on the ability for PMU to generate an interrupt when
> 	a counter overflows. All modern PMU support this mode.
> 
> 	Because counters are virtualized to 64 bits. A sampling period p,
> 	is setup by writing a PMD to 2^{64}-p -1 = -p.
> 
> 	The interface does have the notion of a sampling period, it only
> 	manipulates PMD values. When a counter overflows, it is possible
> 	for a tool to request a notification. By construction, the interface
> 	supports as many sampling periods as there are counters on the host
> 	PMU making it possible to overlap distinct sampling measurements in
> 	one run. The notification can be requested per counter.
> 
> 	The notification is sent as a message and can be extracted by invoking
> 	read() on the file descriptor of the context. The overflow message
> 	contains information about the overflow, such as the index of the
> 	overflowed PMD.
> 
> 	The interface supports using select/poll on contexts file descriptors.
> 	Similarly, it is possible to get an asynchronous notification via SIGIO
> 	using the regular sequence of fcntl().

So the kernel buffers these messages for the read()er.  How does it handle
the case of a process which requests the messages but never gets around to
read()ing them?

> 	By default, during a notification, monitoring is masked, i.e., nothing
> 	is captured. A tool uses the pfm_restart() call to resume monitoring.
> 
> 	It is possible to request that on overflow notification, the monitoring
> 	thread be blocked. By default, it keeps on running with monitoring
> 	masked. Blocking is not supported in system-wide mode nor when a thread
> 	is self-monitoring.
> 
> 4/ SAMPLING BUFFER SUPPORT
>    -----------------------
> 
> 	User level sampling works but it is quite expensive especially when for
> 	non self-monitoring threads. To minimize the overhead, the interface also
> 	supports a kernel level sampling buffer. The idea is simple: on overflow
> 	the kernel record a sample, and only when the buffer becomes full is the
> 	user level notification generated. Thus, we amortize the cost of the
> 	notification by simply calling the user when lots of samples are available.
> 
> 	This is not such a new idea, it is present in OProfile or perfctr.
> 	However, the interface needs to remains generic and flexible. If
> 	the sampling buffer is in kernel, its format and what gets recorded
> 	becomes somehow locked by the implementation. Every tool has different
> 	needs. For instance, a tool such as Oprofile may want to aggregate
> 	samples in the kernel, others such as VTUNE want to record all samples
> 	sequentially. Furthermore, some tools may want to combine in each sample
> 	PMU information with other kernel level information, such as a kernel
> 	call stack for instance. It is hard to design a generic buffer format
> 	that can handle all possible request. Instead, the interface provides
> 	an infrastructure  in which the buffer format is implemented by a kernel
> 	module. Each module controls, what gets recorded, how it is recorded,
> 	how the information is exported to user, when a 'buffer full'
> 	notification must be sent. The perfmon core has an interface to
> 	dynamically register new formats. Each format is uniquely identified by
> 	a 128-bit UUID which is passed by the tool when the context is created.
> 	Arguments for the buffer format are also passed during this call.

Well that addresses my earlier questions I guess.

Is this actually useful?  oprofile is there and works OK.  Again, is there
overdesign here?

And why is it necessary to make the presentation of the samples to
userspace pluggable?  I'd have thought that a single relayfs-based
implementation would suit all sampling buffer formats.

> 	As part of the infrastructure, the interface provides a buffer allocation
> 	and remapping service to the buffer format modules. Format may use this
> 	service when the context is created. The kernel memory will be reserved
> 	and the tool will be able to get access to the buffer via remapping
> 	using the mmap() system call. This provides an efficient way of
> 	exporting samples without the need for copying large amount of data
> 	between the kernel and user space. But a format may choose to export
> 	its samples via another way, such as a device driver interface for
> 	instance.

It doesn't sound like perfmon is using relayfs for the sampling buffer. 
Why not?

> 	The current implementation comes with a simple default format builtin.
> 	This format records samples in a sequential order. Each sample has a
> 	fixed sized header which include the interrupted instruction pointer,
> 	which PMD overflowed, the PID and TID of the thread among other things.
> 	The header is followed by an optional variable size body where
> 	additional PMD values can be recorded.
> 	
> 	We have successfully hooked the Oprofile kernel infrastructure to
> 	our interface using a simple buffer format module on Linux/ia64.

Neat, but do we actually *need* this?

> 	We have released a buffer format that implements n-way buffering to
> 	show how blind spots may be minimized. both modules required absolutely
> 	no change to the interface nor perfmon core implementation. We have also
> 	developed a buffer format module to support P4/Xeon Precise Event-Based
> 	Sampling (PEBS).
> 
> 	Because sampling can happen in the kernel without user intervention,
> 	the kernel must have all the information to figure out what to record,
> 	how to restart the sampling period. This information is passed when
> 	the PMD used as the sampling period is programmed. For each such PMD,
> 	it is possible to indicate using bitvector, which PMDs to record on
> 	overflow, which PMDs to reset on overflow.
> 
> 	For each PMD, the interface provides three possible values which are
> 	used when sampling. The initial value is that is first loaded into the
> 	PMD, i.e., the first sampling period. On overflow which does not
> 	trigger a user level notification, a so-called short reset value is
> 	used by the kernel to reload the PMD. After an overflow with a user
> 	level notification, the kernel uses the so-called long reset value.
> 	This mechanism can be exploited to hide the noise induced by the
> 	recovery after a user notification.
> 
> 	The interface also supports automatic randomization of the reset value
> 	for a PMD after an overflow.

Why would one want to randomise the PMD after an overflow?

> Randomization is indicated per PMD and is
> 	controlled by a seed value. The range of variation is specified by a
> 	bitmask per PMD.
> 
> 5/ EVENT SETS AND MULTIPLEXING:
>    ----------------------------
>
> ... 
> 
> 6/ PMU DESCRIPTION MODULES
>    -----------------------
> 
> 	The logical PMU is driven by a PMU description table. The table
> 	is implemented by a kernel pluggable module. As such, it can be
> 	updated at will without recompiling the kernel, waiting for the next
> 	release of a Linux kernel or distribution, and without rebooting the
> 	machine as long as the PMU model belongs to the same PMU family. For
> 	instance, for the Itanium Processor Family, the architecture specifies
> 	the framework for the PMU. Thus the Itanium PMU specific code is common
> 	across all processor implementations. This is not the case for IA-32.

I think the usefulness of this needs justification.  CPUs are updated all
the time, and we release new kernels all the time to exploit the new CPU
features.  What's so special about performance counters that they need such
special treatment?

>
> ...
> 
> 7/ IMPLEMENTATION
>    ---------------
> 
> 	We have developed an implementation for the 2.6.x kernel series.
> 	We do have support for the following processors:
> 
> 		- All Itanium processors (Itanium, McKinley/Madison, Montecito)
> 		- Intel EM64T/Xeon. Includes support for PEBS and HyperThreading (produced by Intel)
> 		- Intel P4/Xeon (32-bit). Includes support for PEBS and HyperThreading
> 		- Intel Pentium M and P6 processors
> 		- AMD 64-bit Opteron
> 		- preliminary support for IBM Power 5 (produced by IBM)
> 		- preliminary support for MIPS R5000 (produced by Phil Mucci)

Which achitectures does perfctr support?   More, I think?

> -Stephane

Thanks for putting this together.  It helps.

Overall: I worry about excessive configurability, excessive features.

