Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUGKRbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUGKRbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 13:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUGKRbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 13:31:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:10452 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266626AbUGKRbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 13:31:11 -0400
Date: Sun, 11 Jul 2004 19:30:59 +0200 (MEST)
Message-Id: <200407111730.i6BHUxR2001832@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm7] perfctr documentation update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch updates perfctr's documentation:
- adds new Implementation Notes section to the x86 documentation
- some minor fixes in the x86 documentation
- adds new documentation on the per-process perfctrs
- adds new overview documentation

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 Documentation/perfctr/low-level-x86.txt |  124 ++++++++++-
 Documentation/perfctr/overview.txt      |  129 +++++++++++
 Documentation/perfctr/virtual.txt       |  355 ++++++++++++++++++++++++++++++++
 3 files changed, 603 insertions(+), 5 deletions(-)

diff -ruN linux-2.6.7-mm7/Documentation/perfctr/low-level-x86.txt linux-2.6.7-mm7.perfctr-documentation-update/Documentation/perfctr/low-level-x86.txt
--- linux-2.6.7-mm7/Documentation/perfctr/low-level-x86.txt	2004-07-11 19:08:25.000000000 +0200
+++ linux-2.6.7-mm7.perfctr-documentation-update/Documentation/perfctr/low-level-x86.txt	2004-07-11 19:15:14.000000000 +0200
@@ -1,4 +1,4 @@
-$Id: low-level-x86.txt,v 1.1 2004/07/02 18:57:05 mikpe Exp $
+$Id: low-level-x86.txt,v 1.2 2004/07/11 17:12:28 mikpe Exp $
 
 PERFCTRS X86 LOW-LEVEL API
 ==========================
@@ -8,6 +8,13 @@
 For detailed hardware control register layouts, see
 the manufacturers' documentation.
 
+Contents
+========
+- Supported processors
+- Contents of <asm-i386/perfctr.h>
+- Processor-specific Notes
+- Implementation Notes
+
 Supported processors
 ====================
 - Intel P5, P5MMX, P6, P4.
@@ -17,8 +24,8 @@
 - VIA C3. (bad P6 clone)
 - Any generic x86 with a TSC.
 
-Contents of <asm-$ARCH/perfctr.h>
-=================================
+Contents of <asm-i386/perfctr.h>
+================================
 
 "struct perfctr_sum_ctrs"
 -------------------------
@@ -116,7 +123,7 @@
 (T0 and T1) in a processor share the same perfctr registers.
 To prevent conflicts, only thread 0 in each processor is allowed
 to access the counters. perfctr_cpus_forbidden_mask contains the
-smp_processor_id()'s of each processor's thread 1, and it is the
+smp_processor_id()s of each processor's thread 1, and it is the
 responsibility of the high-level driver to ensure that it never
 accesses the perfctr state from a forbidden thread.
 
@@ -155,7 +162,7 @@
 control register, the CESR MSR. The evntsel values are
 limited to 16 bits each, and are combined by the low-level
 driver to form the value for the CESR. Apart from that,
-the evntsel values direct images of the CESR.
+the evntsel values are direct images of the CESR.
 
 Bits 0xFE00 in an evntsel value are reserved.
 At least one evntsel CPL bit (0x00C0) must be set.
@@ -244,3 +251,110 @@
 - at least one of bits 10, 9, 2, 1, or 0 must be set
 - in p4.pebs_matrix_vert, all bits except 1 and 0 must be clear,
   and at least one of bits 1 and 0 must be set
+
+Implementation Notes
+====================
+
+Caching
+-------
+Each 'struct perfctr_cpu_state' contains two cache-related fields:
+- 'id': a unique identifier for the control data contents
+- 'isuspend_cpu': the identity of the CPU on which a state containing
+  interrupt-mode counters was last suspended
+
+To this the driver adds a per-CPU cache, recording:
+- the 'id' of the control data currently in that CPU
+- the current contents of each control register
+
+When perfctr_cpu_update_control() has validated the new control data,
+it also updates the id field.
+
+The driver's internal 'write_control' function, called from the
+perfctr_cpu_resume() API function, first checks if the state's id
+matches that of the CPU's cache, and if so, returns. Otherwise
+it checks each control register in the state and updates those
+that do not match the cache. Finally, it writes the state's id
+to the cache. Tests on various x86 processor types have shown that
+MSR writes are very expensive: the purpose of these cache checks
+is to avoid MSR writes whenever possible.
+
+Unlike accumulation-mode counters, interrupt-mode counters must be
+physically stopped when suspended, primilarly to avoid overflow
+interrupts in contexts not expecting them, and secondarily to avoid
+increments to the counters themselves (see below).
+
+When suspending interrupt-mode counters, the driver:
+- records the CPU identity in the per-CPU cache
+- stops each interrupt-mode counter by disabling its control register
+- lets the cache and state id values remain the same
+
+Later, when resuming interrupt-mode counters, the driver:
+- if the state and cache id values match:
+  * the cache id is cleared, to force a reload of the control
+    registers stopped at suspend (see below)
+  * if the state's "suspend" CPU identity matches the current CPU,
+    the counter registers are still valid, and the procedure returns
+- if the procedure did not return above, it then loops over each
+  interrupt-mode counter:
+  * the counter's control register is physically disabled, unless
+    the cache indicates that it already is disabled; this is necessary
+    to prevent premature events and overflow interrupts if the CPU's
+    registers previously belonged to some other state
+  * then the counter register itself is restored
+After this interrupt-mode specific resume code is complete, the
+driver continues by calling 'write_control' as described above.
+The state and cache ids will not match, forcing write_control to
+reload the disabled interrupt-mode control registers.
+
+Call-site Backpatching
+----------------------
+The x86 family of processors is quite diverse in how their
+performance counters work and are accessed. There are three
+main designs (P5, P6, and P4) with several variations.
+To handle this the processor type detection and initialisation
+code sets up a number of function pointers to point to the
+correct procedures for the actual CPU type.
+
+Calls via function pointers are more expensive than direct calls,
+so the driver actually performs direct calls to wrappers that
+backpatch the original call sites to instead call the actual
+CPU-specific functions in the future.
+
+Unsynchronised code backpatching in SMP systems doesn't work
+on Intel P6 processors due to an erratum, so the driver performs
+a "finalise backpatching" step after the CPU-specific function
+pointers have been set up. This step invokes the API procedures
+on a temporary state object, set up to force every backpatchable
+call site to be invoked and adjusted.
+
+Several low-level API procedures are called in the context-switch
+path by the per-process perfctrs kernel extension, which motivates
+the efforts to reduce runtime overheads as much as possible.
+
+Overflow Interrupts
+-------------------
+The x86 hardware enables overflow interrupts via the local
+APIC's LVTPC entry, which is only present in P6/K7/K8/P4.
+
+The low-level driver supports overflow interrupts as follows:
+- It reserves a local APIC vector, 0xee, as LOCAL_PERFCTR_VECTOR.
+- It adds a local APIC exception handler to entry.S, which
+  invokes the driver's smp_perfctr_interrupt() procedure.
+- It adds code to i8259.c to bind the LOCAL_PERFCTR_VECTOR
+  interrupt gate to the exception handler in entry.S.
+- During processor type detection, it records whether the
+  processor supports the local APIC, and sets up function pointers
+  for the suspend and resume operations on interrupt-mode counters.
+- When the low-level driver is activated, it enables overflow
+  interrupts by writing LOCAL_PERFCTR_VECTOR to each CPU's APIC_LVTPC.
+- Overflow interrupts now end up in smp_perfctr_interrupt(), which
+  ACKs the interrupt and invokes the interrupt handler installed
+  by the high-level service/driver.
+- When the low-level driver is deactivated, it disables overflow
+  interrupts by masking APIC_LVTPC in each CPU. It then releases
+  the local APIC back to the NMI watchdog.
+
+At compile-time, the low-level driver indicates overflow interrupt
+support by enabling CONFIG_PERFCTR_INTERRUPT_SUPPORT. If the feature
+is also available at runtime, it sets the PERFCTR_FEATURE_PCINT flag
+in the perfctr_info object.
diff -ruN linux-2.6.7-mm7/Documentation/perfctr/overview.txt linux-2.6.7-mm7.perfctr-documentation-update/Documentation/perfctr/overview.txt
--- linux-2.6.7-mm7/Documentation/perfctr/overview.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-mm7.perfctr-documentation-update/Documentation/perfctr/overview.txt	2004-07-11 19:15:14.000000000 +0200
@@ -0,0 +1,129 @@
+$Id: overview.txt,v 1.1 2004/07/11 17:11:15 mikpe Exp $
+
+AN OVERVIEW OF PERFCTR
+======================
+The perfctr package adds support to the Linux kernel for using
+the performance-monitoring counters found in many processors.
+
+Perfctr is internally organised in three layers:
+
+- The low-level drivers, one for each supported architecture.
+  Currently there are two, one for 32 and 64-bit x86 processors,
+  and one for 32-bit PowerPC processors.
+
+  low-level-api.txt documents the model of the performance counters
+  used in this package, and the internal API to the low-level drivers.
+
+  low-level-{x86,ppc}.txt provide documentation specific for those
+  architectures and their low-level drivers.
+
+- The high-level services.
+  There is currently one, a kernel extension adding support for
+  virtualised per-process performance counters.
+  See virtual.txt for documentation on this kernel extension.
+
+  [There used to be a second high-level service, a simple driver
+  to control and access all performance counters in all processors.
+  This driver is currently removed, pending an acceptable new API.]
+
+- The top-level, which performs initialisation and implements
+  common procedures and system calls.  
+
+Rationale
+---------
+The perfctr package solves three problems:
+
+- Hardware invariably restricts programming of the performance
+  counter registers to kernel-level code, and sometimes also
+  restricts reading the counters to kernel-level code.
+
+  Perfctr adds APIs allowing user-space code access the counters.
+  In the case of the per-process counters kernel extension,
+  even non-privileged processes are allowed access.
+
+- Hardware often limits the precision of the hardware counters,
+  making them unsuitable for storing total event counts.
+
+  The counts are instead maintained as 64-bit values in software,
+  with the hardware counters used to derive increments over given
+  time periods.
+
+- In a non-modified kernel, the thread state does not include the
+  performance monitoring counters, and the context switch code
+  does not save and restore them. In this situation the counters
+  are system-wide, making them unreliable and inaccurate when used
+  for monitoring specific processes or specific segments of code.
+
+  The per-process counters kernel extension treats the counter state as
+  part of the thread state, solving the reliability and accuracy problems.
+
+Non-goals
+---------
+Providing high-level interfaces that abstract and hide the
+underlying hardware is a non-goal. Such abstractions can
+and should be implemented in user-space, for several reasons:
+
+- The complexity and variability of the hardware means that
+  any abstraction would be inaccurate. There would be both
+  loss of functionality, and presence of functionality which
+  isn't supportable on any given processor. User-space tools
+  and libraries can implement this, on top of the processor-
+  specific interfaces provided by the kernel.
+
+- The implementation of such an abstraction would be large
+  and complex. (Consider ESCR register assignment on P4.)
+  Performing complex actions in user-space simplifies the
+  kernel, allowing it to concentrate on validating control
+  data, managing processes, and driving the hardware.
+  (C.f. the role of compilers.)
+
+- The abstraction is purely a user-convenience thing. The
+  kernel-level components have no need for it.
+
+Common System Calls
+===================
+This lists those system calls that are not tied to
+a specific high-level service/driver.
+
+Querying CPU and Driver Information
+-----------------------------------
+int err = sys_perfctr_info(struct perfctr_info *info,
+			   struct perfctr_cpu_mask *cpus,
+			   struct perfctr_cpu_mask *forbidden);
+
+This operation retrieves information from the kernel about
+the processors in the system.
+
+If non-NULL, '*info' will be updated with information about the
+capabilities of the processor and the low-level driver.
+
+If non-NULL, '*cpus' will be updated with a bitmask listing the
+set of processors in the system. The size of this bitmask is not
+statically known, so the protocol is:
+
+1. User-space initialises cpus->nrwords to the number of elements
+   allocated for cpus->mask[].
+2. The kernel reads cpus->nrwords, and then writes the required
+   number of words to cpus->nrwords.
+3. If the required number of words is less than the original value
+   of cpus->nrwords, then an EOVERFLOW error is signalled.
+4. Otherwise, the kernel converts its internal cpumask_t value
+   to the external format and writes that to cpus->mask[].
+
+If non-NULL, '*forbidden' will be updated with a bitmask listing
+the set of processors in the system on which users must not try
+to use performance counters. This is currently only relevant for
+hyper-threaded Pentium 4/Xeon systems. The protocol is the same
+as for '*cpus'.
+   
+Notes:
+- The internal representation of a cpumask_t is as an array of
+  unsigned long. This representation is unsuitable for user-space,
+  because it is not binary-compatible between 32 and 64-bit
+  variants of a big-endian processor. The 'struct perfctr_cpu_mask'
+  type uses an array of unsigned 32-bit integers.
+- The protocol for retrieving a 'struct perfctr_cpu_mask' was
+  designed to allow user-space to quickly determine the correct
+  size of the 'mask[]' array. Other system calls use weaker protocols,
+  which force user-space to guess increasingly larger values in a
+  loop, until finally an acceptable value was guessed.
diff -ruN linux-2.6.7-mm7/Documentation/perfctr/virtual.txt linux-2.6.7-mm7.perfctr-documentation-update/Documentation/perfctr/virtual.txt
--- linux-2.6.7-mm7/Documentation/perfctr/virtual.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-mm7.perfctr-documentation-update/Documentation/perfctr/virtual.txt	2004-07-11 19:15:14.000000000 +0200
@@ -0,0 +1,355 @@
+$Id: virtual.txt,v 1.1 2004/07/11 17:11:02 mikpe Exp $
+
+VIRTUAL PER-PROCESS PERFORMANCE COUNTERS
+========================================
+This document describes the virtualised per-process performance
+counters kernel extension. See "General Model" in low-level-api.txt
+for the model of the processor's performance counters.
+
+Contents
+========
+- Summary
+- Design & Implementation Notes
+  * State
+  * Thread Management Hooks
+  * Synchronisation Rules
+  * The Pseudo File System
+- API For User-Space
+  * Opening/Creating the State
+  * Updating the Control
+  * Unlinking the State
+  * Reading the State
+  * Resuming After Handling Overflow Signal
+  * Reading the Counter Values
+- Limitations / TODO List
+
+Summary
+=======
+The virtualised per-process performance counters facility
+(virtual perfctrs) is a kernel extension which extends the
+thread state to record perfctr settings and values, and augments
+the context-switch code to save perfctr values at suspends and
+restore them at resumes. This "virtualises" the performance
+counters in much the same way as the kernel already virtualises
+general-purpose and floating-point registers.
+
+Virtual perfctrs also adds an API allowing non-privileged
+user-space processes to set up and access their perfctrs.
+
+As this facility is primarily intended to support developers
+of user-space code, both virtualisation and allowing access
+from non-privileged code are essential features.
+
+Design & Implementation Notes
+=============================
+
+State
+-----
+The state of a thread's perfctrs is packaged up in an object of
+type 'struct vperfctr'. It consists of CPU-dependent state, a
+sampling timer, and some auxiliary administrative data. This is
+an independent object, with its own lifetime and access rules.
+
+The state object is attached to the thread via a pointer in its
+thread_struct. While attached, the object records the identity
+of its owner thread: this is used for user-space API accesses
+from threads other than the owner.
+
+The state is separate from the thread_struct for several resons:
+- It's potentially large, hence it's allocated only when needed.
+- It can outlive its owner thread. The state can be opened as
+  a pseudo file: as long as that file is live, so is the object.
+- It can be mapped, via mmap() on the pseudo file's descriptor.
+  To facilitate this, a full page is allocated and reserved.
+
+Thread Management Hooks
+-----------------------
+Virtual perfctrs hooks into several thread management events:
+
+- exit_thread(): Calls perfctr_exit_thread() to stop the counters
+  and detach the thread's vperfctr object.
+
+- copy_thread(): Calls perfctr_copy_thread() to initialise
+  the child's vperfctr pointer. Currently the settings are
+  not inherited from parent to child, so the pointer is set
+  to NULL in the child's thread_struct.
+
+- switch_to():
+  * Calls perfctr_suspend_thread() on the previous thread, to
+    suspend its counters.
+  * Calls perfctr_resume_thread() on the next thread, to resume
+    its counters. Also resets the sampling timer (see below).
+
+- update_process_times(): Calls perfctr_sample_thread(), which
+  decrements the sampling timer and samples the counters if the
+  timer reaches zero.
+
+  Sampling is normally only done at switch_to(), but if too much
+  time passes before the next switch_to(), a hardware counter may
+  increment by more than its range (usually 2^32). If this occurs,
+  the difference from its start value will be incorrect, causing
+  its updated sum to also be incorrect. The sampling timer is used
+  to prevent this problem, which has been observed on SMP machines,
+  and on high clock frequency UP machines.
+
+- set_cpus_allowed(): Calls perfctr_set_cpus_allowed() to detect
+  attempts to migrate the thread to a "forbidden" CPU, in which
+  case a flag in the vperfctr object is set. perfctr_resume_thread()
+  checks this flag, and if set, marks the counters as stopped and
+  sends a SIGILL to the thread.
+
+  The notion of forbidden CPUs is a workaround for a design flaw
+  in hyper-threaded Pentium 4s and Xeons. See low-level-x86.txt
+  for details.
+
+To reduce overheads, these hooks are implemented as inline functions
+that check if the thread is using perfctrs before calling the code
+that implements the behaviour. The hooks also reduce to no-ops if
+CONFIG_PERFCTR_VIRTUAL is disabled.
+
+Synchronisation Rules
+---------------------
+There are four types of accesses to a thread's perfctr state:
+
+1. Thread management events (see above) done by the thread itself.
+   Suspend, resume, and sample are lock-less.
+
+2. API operations done by the thread itself.
+   These are lock-less, except when an individual operation
+   has specific synchronisation needs. For instance, preemption
+   is often disabled to prevent accesses due to context switches.
+
+3. API operations done by a different thread ("monitor thread").
+   The owner thread must be suspended for the duration of the operation.
+   This is ensured by requiring that the monitor thread is ptrace()ing
+   the owner thread, and that the owner thread is in TASK_STOPPED state.
+
+4. set_cpus_allowed().
+   The kernel does not lock the target during set_cpus_allowed(),
+   so it can execute concurrently with the owner thread or with
+   some monitor thread. In particular, the state may be deallocated.
+
+   To solve this problem, both perfctr_set_cpus_allowed() and the
+   operations that can change the owner thread's perfctr pointer
+   (creat, unlink, exit) perform a task_lock() on the owner thread
+   before accessing the perfctr pointer.
+
+   When concurrent set_cpus_allowed() isn't a problem (because the
+   architecture doesn't have a notion of forbidden CPUs), atomicity
+   of updates to the thread's perfctr pointer is ensured by disabling
+   preemption.
+
+The Pseudo File System
+----------------------
+The perfctr state is accessed from user-space via a file descriptor.
+
+The main reason for this is to enable mmap() on the file descriptor,
+which gives read-only access to the state.
+
+The file descriptor is a handle to the perfctr state object. This
+allows a very simple implementation of the user-space 'perfex'
+program, which runs another program with given perfctr settings
+and reports their final values. Without this handle, monitoring
+applications like perfex would have to be implemented like debuggers
+in order to catch the target thread's exit and retrieve the counter
+values before the exit completes and the state disappears.
+
+The file for a perfctr state object belongs to the vperfctrs pseudo
+file system. Files in this file system support only a few operations:
+- mmap()
+- release() decrements the perfctr object's reference count and
+  deallocates the object when no references remain
+- the listing of a thread's open file descriptors identifies
+  perfctr state file descriptors as belonging to "vperfctrfs"
+The implementation is based on the code for pipefs.
+
+In previous versions of the perfctr package, the file descriptors
+for perfctr state objects also supported the API's ioctl() method.
+
+API For User-Space
+==================
+
+Opening/Creating the State
+--------------------------
+int fd = sys_vperfctr_open(int tid, int creat);
+
+'tid' must be the id of a thread, or 0 which is interpreted as an
+alias for the current thread.
+
+This operation returns an open file descriptor which is a handle
+on the thread's perfctr state object.
+
+If 'creat' is non-zero and the object did not exist, then it is
+created and attached to the thread. The newly created state object
+is inactive, with all control fields disabled and all counters
+having the value zero. If 'creat' is non-zero and the object
+already existed, then an EEXIST error is signalled.
+
+If 'tid' does not denote the current thread, then it must denote a
+thread that is stopped and under ptrace control by the current thread.
+
+Notes:
+- The access rule in the non-self case is the same as for the
+  ptrace() system call. It ensures that no other thread, including
+  the target thread itself, can access or change the target thread's
+  perfctr state during the operation.
+- An open file descriptor for a perfctr state object counts as a
+  reference to that object; even if detached from its thread the
+  object will not be deallocated until the last reference is gone.
+- The file descriptor can be passed to mmap(), for low-overhead
+  counter sampling. See "READING THE COUNTER VALUES" for details.
+- The file descriptor can be passed to another thread. Accesses
+  from threads other than the owner are permitted as long as they
+  posses the file descriptor and use ptrace() for synchronisation.
+
+Updating the Control
+--------------------
+int err = sys_vperfctr_control(int fd, const struct vperfctr_control *control);
+
+'fd' must be the return value from a call to sys_vperfctr_open(),
+The perfctr object must still be attached to its owner thread.
+
+This operation stops and samples any currently running counters in
+the thread, and then updates the control settings. If the resulting
+state has any enabled counters, then the counters are restarted.
+
+Before restarting, the counter sums are reset to zero. However,
+if a counter's bit is set in the control object's 'preserve'
+bitmask field, then that counter's sum is not reset. The TSC's
+sum is only reset if the TSC is disabled in the new state.
+
+If any of the programmable counters are enabled, then the thread's
+CPU affinity mask is adjusted to exclude the set of forbidden CPUs.
+
+If the control data activates any interrupt-mode counters, then
+a signal (specified by the 'si_signo' control field) will be sent
+to the owner thread after an overflow interrupt. The documentation
+for sys_vperfctr_iresume() describes this mechanism.
+
+If 'fd' does not denote the current thread, then it must denote a
+thread that is stopped and under ptrace control by the current thread.
+The perfctr state object denoted by 'fd' must still be attached
+to its owner thread.
+
+Notes:
+- It is strongly recommended to memset() the vperfctr_control object
+  to all-bits-zero before setting the fields of interest.
+- Stopping the counters is done by invoking the control operation
+  with a control object that activates neither the TSC nor any PMCs.
+
+Unlinking the State
+-------------------
+int err = sys_vperfctr_unlink(int fd);
+
+'fd' must be the return value from a call to sys_vperfctr_open().
+
+This operation stops and samples the thread's counters, and then
+detaches the perfctr state object from the thread. If the object
+already had been detached, then no action is performed.
+
+If 'fd' does not denote the current thread, then it must denote a
+thread that is stopped and under ptrace control by the current thread.
+
+Reading the State
+-----------------
+int err = sys_vperfctr_read(int fd, struct perfctr_sum_ctrs *sum,
+			    struct vperfctr_control *control);
+
+'fd' must be the return value from a call to sys_vperfctr_open().
+
+This operation copies data from the perfctr state object to
+user-space. If 'sum' is non-NULL, then the counter sums are
+written to it. If 'control' is non-NULL, then the control data
+is written to it.
+
+If the perfctr state object is attached to the current thread,
+then the counters are sampled and updated first.
+
+If 'fd' does not denote the current thread, then it must denote a
+thread that is stopped and under ptrace control by the current thread.
+
+Notes:
+- An alternate and faster way to retrieve the counter sums is described
+  below. This system call can be used if the hardware does not permit
+  user-space reads of the counters.
+
+Resuming After Handling Overflow Signal
+---------------------------------------
+int err = sys_vperfctr_iresume(int fd);
+
+'fd' must be the return value from a call to sys_vperfctr_open().
+The perfctr object must still be attached to its owner thread.
+
+When an interrupt-mode counter has overflowed, the counters
+are sampled and suspended (TSC remains active). Then a signal,
+as specified by the 'si_signo' control field, is sent to the
+owner thread: the associated 'struct siginfo' has 'si_code'
+equal to 'SI_PMC_OVF', and 'si_pmc_ovf_mask' equal to the set
+of overflown counters.
+
+The counters are suspended to avoid generating new performance
+counter events during the execution of the signal handler, but
+the previous settings are saved. Calling sys_vperfctr_iresume()
+restores the previous settings and resumes the counters. Doing
+this is optional.
+
+If 'fd' does not denote the current thread, then it must denote a
+thread that is stopped and under ptrace control by the current thread.
+
+Reading the Counter Values
+--------------------------
+The value of a counter is computed from three components:
+
+	value = sum + (now - start);
+
+Two of these (sum and start) reside in the kernel's state object,
+and the third (now) is the contents of the hardware counter.
+To perform this computation in user-space requires access to
+the state object. This is achieved by passing the file descriptor
+from sys_vperfctr_open() to mmap():
+
+	volatile const struct vperfctr_state *kstate;
+	kstate = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
+
+Reading the three components is a non-atomic operation. If the
+thread is scheduled during the operation, the three values will
+not be consistent and the wrong result will be computed.
+To detect this situation, user-space should check the kernel
+state's TSC start value before and after the operation, and
+retry the operation in case of a mismatch.
+
+The algorithm for retrieving the value of counter 'i' is:
+
+	tsc0 = kstate->cpu_state.tsc_start;
+	for(;;) {
+		rdpmcl(kstate->cpu_state.pmc[i].map, now);
+		start = kstate->cpu_state.pmc[i].start;
+		sum = kstate->cpu_state.pmc[i].sum;
+		tsc1 = kstate->cpu_state.tsc_start;
+		if (likely(tsc1 == tsc0))
+			break;
+		tsc0 = tsc1;
+	}
+	return sum + (now - start);
+
+The algorithm for retrieving the value of the TSC is similar,
+as is the algorithm for retrieving the values of all counters.
+
+Notes:
+- Since the state's TSC time-stamps are used, the algorithm requires
+  that user-space enables TSC sampling.
+- The algorithm requires that the hardware allows user-space reads
+  of the counter registers. If this property isn't statically known
+  for the architecture, user-space should retrieve the kernel's
+  'struct perfctr_info' object and check that the PERFCTR_FEATURE_RDPMC
+  flag is set.
+
+Limitations / TODO List
+=======================
+- Perfctr settings are not inherited from parent to child at fork().
+  The issue is not fork() but propagating final counts from children
+  to parents, and allowing user-space to distinguish "self" counts
+  from "children" counts.
+  An implementation of this feature is being planned.
+- Buffering of overflow samples is not implemented. So far, not a
+  single user has requested it.
