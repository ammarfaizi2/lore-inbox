Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVLSLdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVLSLdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 06:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVLSLdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 06:33:09 -0500
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:60044 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1030299AbVLSLdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 06:33:07 -0500
Date: Mon, 19 Dec 2005 03:31:40 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: quick overview of the perfmon2 interface
Message-ID: <20051219113140.GC2690@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As suggested by Andrew, I wrote a quick overview of the perfmon2 interface
that we have implemented on several architectures now. The goal of this
introduction is to give you an idea of the key features of the interface.


------------------------------------------------------------------------------

	      ===========================================================

		  ----------------------------------------------------
		  A quick overview of the perfmon2 interface for Linux
		  ----------------------------------------------------

	       Copyright (c) 2005 Hewlett-Packard Development Company, L.P.
		   Contributed by Stephane Eranian <eranian@hpl.hp.com>

	      ===========================================================
	
I/ INTRODUCTION
   ------------

	The goal of the perfmon2 interface is to provide access to the hardware
	performance counters present in all modern processors.

	The interface is designed to be builtin, very generic, flexible and
	extensible. It is not designed to support a single application or a
	small class of monitoring tools. The goal is to avoid fragmentation
	where you have one tool using one interface. Because we want the
	interface to be an integral part of the kernel, special care is taken
	to make it robust and secure. The interface is uniform across all
	hardware platforms, i.e., it offers the same level of software
	functionalities on each platform. The nature of the captured data
	depends solely on the capabilities of the underlying hardware.

	Although, by nature the Performance Monitoring Unit (PMU) of each
	processor architecture can be quite different, it is possible to
	extrapolate a common hardware interface on which we can build a
	powerful kernel interface. All modern PMUs are implemented using a
	register interface. Two types of registers are typically present:
	configuration registers (PMC) and data registers (PMD). As such, the
	interface is simply exporting read/write operations on those registers.
	A minimal set of software abstractions is added, such as the notion of
	a perfmon context which is used to encapsulate the PMU state.

	The same interface provides support for per-thread AND system-wide
	measurements. For each mode, it is possible to collect simple counts
	or create full sampling measurements.

	Sampling is supported at the user level and also at the kernel level with
	the ability to use a kernel-level sampling buffer. The format of the kernel
	sampling buffer is implemented by a kernel pluggable module. As such it is
	very easy to develop a custom format without any modification to the
	interface nor its implementation.

	To compensate for limitations of many PMU, such as a small number of
	counters, the interface also exports the notion of event sets and allows
	applications to multiplex sets, thereby allowing more events to be
	measured in a single run than there are actual counters.

	The PMU register description is implemented by a kernel pluggable module
	thereby allowing new hardware to be supported without the need to wait
	for the next release of the kernel. The description table supports virtual
	PMD registers which can be tied to any kernel or hardware resource.

II/ BASE INTERFACE
    ---------------

	PMU registers are accessed by reading/writing PMC and PMD registers.
	The interface exposes a logical view of the PMU. The logical PMD/PMC
	registers are mapped onto the actual PMU registers (be them PMD/PMC or
	actual MSR) by the kernel. The mapping table is implemented by a kernel
	module and can thus easily be updated without a kernel recompile. This
	mechanism also makes it easy to add new PMU support inside a processor
	family. The mapping is exposed to users via a file in /proc
	(/proc/perfmon_map).


	The interface is implemented using a system call interface rather than
	a device driver. There are several reasons for this choice, the most
	important being that we do want to support per-thread monitoring and
	that requires access to the context switch code of the kernel to
	save/restore the PMU state. Another reason is to reinforce the fact
	that the interface must be an integral part of the kernel. Lastly, we
	think it give us more flexibility in terms of how arguments can be
	passed to/from the kernel.

	Whenever possible, the interface leverages existing kernel mechanisms.
	As such, we use a file descriptor to identify a perfmon context.

	The interface defines the following set of system calls:

	- int pfm_create_context(pfarg_ctx_t *ctx, void *smpl_arg, size_t smpl_size)

	    creates  a per-thread or system-wide perfmon context. It returns a
	    file descriptor that uniquely identifies the context. The regular
	    file descriptor semantics w.r.t. to access control, sharing are
	    supported.

	- pfm_write_pmds(int fd, pfarg_pmd_t *pmds, int n)

	    Write one or more PMD registers.

	- pfm_read_pmds(int fd, pfarg_pmd_t *pmds, int n)

	    Read the one or more PMD registers.

	- pfm_write_pmcs(int fd, pfarg_pmc_t*pmcs, int n)

	    Write the one or more PMC registers.

	- pfm_load_context(int fd, pfarg_load_t *load)

	   Attach a perfmon context to either a thread or a processor. In the
	   case of a thread, the thread id is passed. In the case of a
	   processor, the context is bound to the CPU on which the call is
	   performed.
	  
	- pfm_start(int fd, pfarg_start_t *start)

	   Start active monitoring.

	- pfm_stop(int fd)

	   Stop active monitoring.

	- pfm_restart(int fd)

	   Resume monitoring after a user level overflow notification. This
	   call is used in conjunction with kernel-level sampling.

	- pfm_create_evtsets(int fd, pfarg_setdesc_t *sets, int n)

	    Create/Modify one or more PMU event set. Each set encapsulates the
	    full PMU sets.

	- pfm_delete_evtsets(int fd, pfarg_setdesc_t *sets, int n)

	    Delete a PMU event set. It is possible to delete one or more sets
	    in a single call.

	- pfm_getinfo_evtsets(int fd, pfarg_setinfo_t *infos, int n):

	    Return information about an event set. It is possible to get
	    information about one or more sets in a single call. The call
	    returns, for instance, the number of times a set has been activated,
	    i.e., loaded onto the actual PMU.

	- pfm_unload_context(int fd)

	    Detach a context from a thread or a processor.

	By default, all counters are exported as 64-bit registers even when the
	underlying hardware implements less. This makes it much easier for
	applications that are doing event-based sampling because they don't
	need to worry about the width of counters. It is possible to turn the
	"virtualization" off.

	A system-wide context allows a tool to monitor all activities on one
	processor, i.e, across all threads. Full System-wide monitoring in an
	SMP system is achieved by creating and binding a perfmon context on
	each processor. By construction, a perfmon context can only be bound
	to one processor at a time.  This design choice is motivated by the
	desire to enforce locality and to simplify the kernel implementation.
	
	Multiple per-thread contexts can coexist at the same time on a system.
	Multiple system-wide can co-exist as long as they do not monitor the
	same set of processors. The existing implementation does not allow
	per-thread and system-wide context to exist at the same time. The
	restriction is not inherent to the interface but come from the
	existing implementation.
	
3/ SAMPLING SUPPORT
   ----------------

	The interface supports event-based sampling (EBS), where the sampling
	period is determined by the number of occurrences of an event rather
	than by time. Note that time-based sampling (TBS) can be emulated by
	using an event with some correlation to time.

	The EBS is based on the ability for PMU to generate an interrupt when
	a counter overflows. All modern PMU support this mode.

	Because counters are virtualized to 64 bits. A sampling period p,
	is setup by writing a PMD to 2^{64}-p -1 = -p.

	The interface does have the notion of a sampling period, it only
	manipulates PMD values. When a counter overflows, it is possible
	for a tool to request a notification. By construction, the interface
	supports as many sampling periods as there are counters on the host
	PMU making it possible to overlap distinct sampling measurements in
	one run. The notification can be requested per counter.

	The notification is sent as a message and can be extracted by invoking
	read() on the file descriptor of the context. The overflow message
	contains information about the overflow, such as the index of the
	overflowed PMD.

	The interface supports using select/poll on contexts file descriptors.
	Similarly, it is possible to get an asynchronous notification via SIGIO
	using the regular sequence of fcntl().

	By default, during a notification, monitoring is masked, i.e., nothing
	is captured. A tool uses the pfm_restart() call to resume monitoring.

	It is possible to request that on overflow notification, the monitoring
	thread be blocked. By default, it keeps on running with monitoring
	masked. Blocking is not supported in system-wide mode nor when a thread
	is self-monitoring.

4/ SAMPLING BUFFER SUPPORT
   -----------------------

	User level sampling works but it is quite expensive especially when for
	non self-monitoring threads. To minimize the overhead, the interface also
	supports a kernel level sampling buffer. The idea is simple: on overflow
	the kernel record a sample, and only when the buffer becomes full is the
	user level notification generated. Thus, we amortize the cost of the
	notification by simply calling the user when lots of samples are available.

	This is not such a new idea, it is present in OProfile or perfctr.
	However, the interface needs to remains generic and flexible. If
	the sampling buffer is in kernel, its format and what gets recorded
	becomes somehow locked by the implementation. Every tool has different
	needs. For instance, a tool such as Oprofile may want to aggregate
	samples in the kernel, others such as VTUNE want to record all samples
	sequentially. Furthermore, some tools may want to combine in each sample
	PMU information with other kernel level information, such as a kernel
	call stack for instance. It is hard to design a generic buffer format
	that can handle all possible request. Instead, the interface provides
	an infrastructure  in which the buffer format is implemented by a kernel
	module. Each module controls, what gets recorded, how it is recorded,
	how the information is exported to user, when a 'buffer full'
	notification must be sent. The perfmon core has an interface to
	dynamically register new formats. Each format is uniquely identified by
	a 128-bit UUID which is passed by the tool when the context is created.
	Arguments for the buffer format are also passed during this call.

	As part of the infrastructure, the interface provides a buffer allocation
	and remapping service to the buffer format modules. Format may use this
	service when the context is created. The kernel memory will be reserved
	and the tool will be able to get access to the buffer via remapping
	using the mmap() system call. This provides an efficient way of
	exporting samples without the need for copying large amount of data
	between the kernel and user space. But a format may choose to export
	its samples via another way, such as a device driver interface for
	instance.

	The current implementation comes with a simple default format builtin.
	This format records samples in a sequential order. Each sample has a
	fixed sized header which include the interrupted instruction pointer,
	which PMD overflowed, the PID and TID of the thread among other things.
	The header is followed by an optional variable size body where
	additional PMD values can be recorded.
	
	We have successfully hooked the Oprofile kernel infrastructure to
	our interface using a simple buffer format module on Linux/ia64.
	We have released a buffer format that implements n-way buffering to
	show how blind spots may be minimized. both modules required absolutely
	no change to the interface nor perfmon core implementation. We have also
	developed a buffer format module to support P4/Xeon Precise Event-Based
	Sampling (PEBS).

	Because sampling can happen in the kernel without user intervention,
	the kernel must have all the information to figure out what to record,
	how to restart the sampling period. This information is passed when
	the PMD used as the sampling period is programmed. For each such PMD,
	it is possible to indicate using bitvector, which PMDs to record on
	overflow, which PMDs to reset on overflow.

	For each PMD, the interface provides three possible values which are
	used when sampling. The initial value is that is first loaded into the
	PMD, i.e., the first sampling period. On overflow which does not
	trigger a user level notification, a so-called short reset value is
	used by the kernel to reload the PMD. After an overflow with a user
	level notification, the kernel uses the so-called long reset value.
	This mechanism can be exploited to hide the noise induced by the
	recovery after a user notification.

	The interface also supports automatic randomization of the reset value
	for a PMD after an overflow. Randomization is indicated per PMD and is
	controlled by a seed value. The range of variation is specified by a
	bitmask per PMD.

5/ EVENT SETS AND MULTIPLEXING:
   ----------------------------

	For many PMU models, the number of counters is fairly limited which
	makes it sometimes difficult to collect certain metric in a single run.
	But this is not always because you have a large number of counters that
	they all can measure any events at the same time. Such constraints can
	be alleviated by creating the notion of an event set. Each set
	encapsulates the full PMU state. At any one time only one set is loaded
	onto the actual PMU. Sets are then multiplexed. The counts collected
	by counters in each set can then be scaled to approximate what they
	would have been, had they run for the entire duration of the
	measurement. It is very important to keep in mind that this is an
	approximation. Its quality depends on the frequency at which sets can
	be switched and also the overhead involved.

	Event sets and multiplexing can be fully implemented at the user level
	but this is prohibitively expensive especially for non-self-monitoring
	threads.

	The interface exports the notion of event set. Each PMD/PMC can be
	assigned to a set when read/written.

	By default any perfmon context has a single set, namely set. Tools can
	create additional sets using pfm_create_evtsets(). A set is identified
	by a number between 0-65535. The number indicate the order in which
	sets are switched to and from. The kernel uses an ordered list managed
	in a round-robin fashion to determine the switch order.

	Switching can either be triggered by a timeout or by a counter overflow.
	The switch mode is set per set and it is possible to mix and match.

	The timeout is specified when the set is created (or modified for set0).
	It is limited by the granularity of the timer tick. The user timeout is
	rounded up to the nearest multiple of the timer tick frequency. The
	actual timeout is returned to the tool.

	For overflow switching, the interface does not require a dedicated
	counter. Each PMD has an overflow switch counter. On overflow the
	switch counter is decremented. When it reaches zero, switching occurs.
	There can be more than on "trigger" PMD per set.

	Overflow-based set switching can be used to implement counter
	cascading, where certain counters start measuring only when
	a certain threshold is reached on another event.

6/ PMU DESCRIPTION MODULES
   -----------------------

	The logical PMU is driven by a PMU description table. The table
	is implemented by a kernel pluggable module. As such, it can be
	updated at will without recompiling the kernel, waiting for the next
	release of a Linux kernel or distribution, and without rebooting the
	machine as long as the PMU model belongs to the same PMU family. For
	instance, for the Itanium Processor Family, the architecture specifies
	the framework for the PMU. Thus the Itanium PMU specific code is common
	across all processor implementations. This is not the case for IA-32.

	The interface and PMU description module support the notion of virtual
	PMU registers, i.e., register not necessarily tied to an actual PMU
	register. For instance, it may be interesting, especially when sampling,
	to export a kernel resource or a non-PMU hardware registers as a PMD.

	The actual read/write function for those virtual PMD is implemented by
	the PMU description module, allowing for maximum flexibility.

	It is important to understand that the interface, including the PMU
	description modules, do not know anything about PMU events. All event
	specific information, including event names and encodings has to be
	implemented at the user level.

7/ IMPLEMENTATION
   ---------------

	We have developed an implementation for the 2.6.x kernel series.
	We do have support for the following processors:

		- All Itanium processors (Itanium, McKinley/Madison, Montecito)
		- Intel EM64T/Xeon. Includes support for PEBS and HyperThreading (produced by Intel)
		- Intel P4/Xeon (32-bit). Includes support for PEBS and HyperThreading
		- Intel Pentium M and P6 processors
		- AMD 64-bit Opteron
		- preliminary support for IBM Power 5 (produced by IBM)
		- preliminary support for MIPS R5000 (produced by Phil Mucci)

	The so-called "new perfmon code base" incorporates all the features we describe here.
	At this point, this is a standalone patch for the 2.6.x kernels. The full patch can be
	downloaded from our project web site at:

		http://www.sf.net/projects/perfmon2

	On Linux/ia64, there is a older version (v2.0) of this interface that is currently
	provided on all 2.6.x based kernels. The "new code base" (v2.2) perfmon maintains
	backward compatibility with this version.

8/ EXISTING TOOLS
   --------------

	Several commercial products as well as open-source tools already exists for this
	interface (or previous incarnation) for Linux on Itanium where such interface has
	been available for quite some time:

		- HP Caliper for RHEL4, SLES9.
		- BEA JRockit with Dynamic Optimization
		- pfmon/libpfm by HPLabs
		- qtools/qprof by HPLabs
		- PerfSuite from NCSA
		- all PAPI-based tools
		- OProfile

	We think that once the interface is part of the mainline kernel, we will see even more
	tools being released and developed for the benefits of ALL users across ALL major
	hardware platforms.
-- 

-Stephane
