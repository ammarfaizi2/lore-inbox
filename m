Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUJIFxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUJIFxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUJIFxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:53:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22512 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266513AbUJIFrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:47:32 -0400
Message-ID: <41677E6B.7070503@mvista.com>
Date: Fri, 08 Oct 2004 23:00:11 -0700
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ext-rt-dev@mvista.com
Subject: [ANNOUNCE] Linux 2.6 Real Time Kernel - 2 (Mutex Patch)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  RT Prototype 2004 (C) MontaVista Software, Inc.
  This file is licensed under the terms of the GNU
  General Public License version 2. This program
  is licensed "as is" without any warranty of any kind,
  whether express or implied.
 
                                                                               
Linux-2.6.9-rc3_RT_mutex.patch
==============================
                                                                                
                                                                                
This patch includes the (modified) PMutex from
the Universitaet der Bundeswehr, Germany.
                                                                                
(see: http://inf3-www.informatik.unibw-muenchen.de/research/linux/mutex/)
                                                                                
In addition, we have included an abstraction layer
for timing and debugging instrumentation, and to
allow using other mutex implementation for spinlock
substitution. We have considered using the OSDL fusyn
project, and the Linux system semaphore.
                                                                                
This patch alone does not provide any real-time
functionality, until the subsequent spinlock
patches have been applied.
                                                                                
This patch also includes the rttReleaseNotes file
for addition to the kernel's Documentation directory.
This file describes in detail the modifications,
requirements and issues related to the RT kernel
modifications.
                                                                                
Sign-off: Sven-Thorsten Dietrich (sdietrich@mvista.com)


diff -pruN a/Documentation/rttReleaseNotes b/Documentation/rttReleaseNotes
--- a/Documentation/rttReleaseNotes	1970-01-01 03:00:00.000000000 +0300
+++ b/Documentation/rttReleaseNotes	2004-10-09 05:26:30.000000000 +0400
@@ -0,0 +1,652 @@
+Copyright (C) 2004 MontaVista Software, Inc.
+
+
+Real-Time Linux 2.6
+===================
+
+Purpose of the Project
+----------------------
+The purpose of this project is to identify and implement
+technology enhancements to further reduce interrupt latency 
+and task preemption latency in the current 2.6 kernel series.
+
+
+Contact
+-------
+Please direct any correspondence regarding this
+kernel project to: ext-rt-dev@mvista.com 
+
+
+Download
+--------
+The kernel is available via rsync at source.mvista.com::LinuxRT 
+
+
+Key Technologies
+----------------
+- IRQ Handlers executing in process context 
+- Priority Interiting Kernel Mutex substituting spinlocks in critical regions.
+- Mutex abstraction layer allowing substitution
+
+
+Release Notes
+-------------
+
+WARNING:
+
+This kernel is a research kernel, and as such, is known to be unstable at 
+this time. Do not use this kernel on a production system or a system that 
+has unique data stored on it.
+
+
+
+CURRENT PROJECT STATUS
+======================
+
+X86 Support only.
+Based on Linux 2.6.7 from kernel.org. 
+Port to the 2.6.9-rc3-mm kernel series in progress.
+
+The kernel is fairly stable, failing under high loads 
+in low memory conditions. 
+
+
+
+
+Known Problems and Areas subject to Improvement
+-----------------------------------------------
+- Port to 2.6.9-rc3-mm series in progress
+- Incomplete mutex partitioning (mutex inside spinlock)
+- Lack of optimization and performance impact of preliminary code
+- Incomplete mutex performance instrumentation
+- Traps / system calls locking mutex may violate "sleeping in interrupt rule"
+- R/W lock implementation incomplete
+- PMutex leaves room for improvement in several areas, see below.
+- Kernel without RT enhancements is currently broken. "scheduling while atomic"
+- RCU patch is a work-around and requires redesign
+- 4K IRQ stacks not supported
+- Hyperthreading is not supported and will cause a crash
+- "spin_undefs.h" is a temporary solution to reduce patch size
+
+
+Mutex implementation Issues
+
+
+  PMUTEX
+  ------
+  -  Priority list static initialization macro must replace
+     the SPIN_LOCK_UNLOCKED macro. Standard linux list implementation
+     for static initialization requires passing a (x) parameter.
+     This is problematic for static MUTEX initialization
+  - existing owner patch in pmutex.h needs debugging
+  - at wake-up time blocked threads must verify that they are the owner 
+    of the mutex, before proceeding into a critical section.
+  - Does not currently detect when a mutex is locked with IRQs disabled
+  - race condition associated with owner assignment
+
+
+BACKGROUND and INTRODUCTION
+===========================
+
+Before Linux became generally accepted as a full-fledged operating
+system, other factors contributed to its evolution.
+
+Open source is at the root, from which grew versatility, reliability,
+and refined performance.
+
+The latter are quantifiable metrics that ultimately led to Linux's
+proliferation throughout the technologically advanced world, and
+elsewhere.
+
+Many of the first Linux installations were Windows PCs, retired for
+faster models, but useful under Linux due to the efficiency of the
+fledgling O/S. These early Linux PCs outperformed their former Windows
+heritage in network throughput, processing efficiency, and uptime.
+
+A majority of the basic design decisions that governed and contributed
+to the development and subsequent rise of Linux have favored the
+traditional Unix principles of fairness, resource sharing, and progress.
+
+The fairness- and resource-sharing design objectives contributed to
+make Linux competitive and popular in the enterprise-server and
+development-application environments, giving rise to RedHat and others.
+
+Fairness and resource sharing are thus essential to the evolution
+of Linux, and endemic of the UNIX legacy in general.
+
+Linux and its UNIX legacy are inherently NOT real-time operating
+environments.
+
+Far to the contrary, fairness and resource sharing stand in stark
+contrast with the requirements of embedded or time-critical applications.
+
+Today, applications for the embedded Linux kernel are expanding into
+multimedia appliances (settop boxes and audio boxes), as well as
+Internet appliances. Increasingly PDA and communications accessories,
+including cellular devices, are adopting Linux as core operating system,
+to leverage the robust IP technology for connectivity and
+application features.
+
+Embedded systems design often pits hardware material costs, power
+consumption and performance against one another, in an effort to
+provide reliable, time-critical functionality in highly competitive,
+and often high volume, and low-margin markets.
+
+Testing is crucial, and overlooked software defects can
+quickly be terminal to a product line.
+
+Embedded devices are thus typically designed with minimal CPU and memory,
+are highly integrated and compact, demand low power consumption, and
+require the maximum possible feature set from a versatile,
+multi-programmed, highly reliable, low maintenance real-time operating
+system.
+
+Linux meets a majority of these criteria, but it falls short in the
+real-time performance area.  Real-time requirements, like VIP treatment,
+are not generally compatible with fairness and resource sharing in the
+sense of general admission.
+
+Real-time requirements will never be alleviated by improvements in
+hardware performance, or by breakthroughs in integration or hardware
+density, because the demands on software that utilizes latest
+hardware technologies will easily keep up or outpace the advances
+in hardware technology.
+
+
+The O(1) scheduler and kernel preemption have dramatically distanced
+Linux from its UNIX legacy, but significant performance enhancements
+remain possible.
+
+Following through on examples set by kernel preemption and the adaptive
+design of the O(1) scheduler, Linux can become a reliable real-time O/S
+for a class of real-time applications that co-exist with a wealth of
+general-purpose tasks common to Unix.
+
+
+PRECEDENT CONTRIBUTIONS
+=======================
+
+The Linux 2.6 RT kernel builds on top of recent patches
+contributed by Ingo Molnar, Scott Wood, and the Universitaet 
+der Bundeswehr (UNI-BW), Muenchen, Germany.
+
+	- UNI-BW P-Mutex source code
+	- Voluntary Preemption by Ingo Molnar
+	- IRQ thread patches by Scott Wood and Ingo Molnar
+	- BKL mutex patch by Ingo Molnar (with MV extensions)
+
+We would like to thank Dirk Grambow, Arnd Heursch,
+and Witold Jaworski of the Universitaet der Bundeswehr,
+Muenchen, Germany for their P-Mutex contribution.
+ 
+
+
+TECHNOLOGY ENHANCEMENTS
+=======================
+
+INTERRUPTS IN THREADS
+=====================
+
+  Interrupts executing in thread context provide low-impact priority
+  management of interrupts and tasks in scheduling context.
+
+  Exisiting Implementations
+  -------------------------
+  1. Scott Wood / LKML Interrupt Patch
+  2. Ingo Molnar's ISRd patch (voluntary preempt series)
+
+
+  General Requirements:
+  ---------------------
+  - Top Level interrupt handlers run in threads.
+  - SoftIRQs run in threads.
+  - IRQ threads must run to completion before another interrupt is handled.
+    Irq threads can block on mutexes.
+    When an interrupt occurs while an IRQ thread is sleeping on a mutex,
+    that thread must not be activated as a result of the same IRQ 
+    occurring again.
+  - IRQ threads (top and bottom halves) must run with preemption enabled.
+
+
+PRIORITY INHERITING KERNEL MUTEX
+================================
+
+  Several open source implementations exist which partly satisfy the
+  requirements for a priority inheriting mutex and its adaptation to
+  a user-space mutex. These open source mutexes could be used as potential
+  starting points.
+
+  - Dirk Grambow's PMutexes (UNI-BW Muenchen, Germany)
+  - OSDL Robust Mutexes (Inaky Gonzales, Intel)
+  - TimeSys Kernel Mutexes from TimeSys 2.4 kernel
+  - Native kernel mutex implementation for kernel semaphores
+
+  The properties of the various implementations should be evaluated to
+  determine which one of the implementations has the best characteristics 
+  for use as a base to replace spinlocks.
+
+  Possibly extensive header file extensins are necessary for any
+  general purpose mutex utilized to substitute spinlocks in the kernel.
+
+  General Requirements:
+  ---------------------
+  - An abstraction layer for kernel mutexes has been designed to allow easy
+    switching between mutex implementations for evaluation.
+  - Simple header declarations / minimal include files in order to reduce 
+    header file cycling.
+  - Compatibility with existing spinlock debugging primitives.
+  - A thread blocked on a mutex must only be woken up if it has acquired 
+    ownership of the mutex. If the thread is woken while blocked on a mutex, 
+    it is up to the robustness of the mutex to prevent the thread from 
+    entering a critical section if it is not the owner of the thread.
+
+
+Specific Functional Requirements:
+---------------------------------
+        - SMP compatible
+        - POSIX conformant
+        - Minimal overhead
+        - Service for pending waiters with respect to task priority
+        - Priority inheritance for blocking tasks.
+        - Mutex release in constant time, not affected by waiter queue size.
+        - Mutex release from interrupt context.
+        - Mutex release from signal handler.
+        - Deadlock checking mechanism.
+	- Mutex may not be locked twice by the same task.
+        - Supports piggybacked R/W lock implementation.
+        - Process cannot be swapped while sleeping on a mutex.
+        - Plugin compatible with spinlock definitions:
+                o Static initialization without PARAMETER
+                o see also SPINLOCK_UNLOCKED macro.
+        - Robustness / Debugging (avoid halting kernel on failure):
+                o trap locking mutex in IRQ context 
+                o MAGIC / non-initialized mutex trap
+                o lock before unlock trap
+        - Conditional-compile architecture-independent mutex
+        - Performance benchmarking and statistics (possibly via /proc)
+
+  Optional (Deferred) Functional Requirements:
+  -------------------------------------------
+        - Timeout support
+        - Mutex flush operation support - wake up all waiters simultaneously
+        - Robustness / handling owner death
+        - Act as counting semaphore
+        - Priority ceiling
+
+
+        Deadlock Detection Requirements
+        -------------------------------
+        - Thread and SMP safe.
+        - deadlock_pending: functions check for deadlock without locking mutex.
+        - Function is inline and optimal (n*n tasks or better).
+        - When deadlock occurs, failure is reported, and deadlock is
+          allowed to occur. Optional switch halts kernel for debugging.
+
+  
+  
+
+SPINLOCK SUBSTITUTION
+=====================
+
+  This section identifies problem areas and functional requirements related
+  to running the kernel with mutexes subtituting for spinlocks.
+
+  Prerequisites:
+  -------------
+  Interrupts in threads eliminate the need for locking interrupts in 
+  spinlock-protected regions. The spinlock_irq{save}/_irqrestore functions 
+  can be substituted with simple mutex-protected critical sections.
+
+  Interrupts handled by vectored (classic) interrupt handlers cannot obtain
+  mutexes, because blocking on a mutex in interrupt context is not a defined 
+  operation in the Linux kernel.  If a hardware IRQ handler attempts to lock 
+  a contended mutex, a debug crash will occur.
+
+  Method for spinlock substitution:
+  ----------------------------------
+  - redefine spinlock* operations to mutex_lock operations.
+  - conditionally include redefinitions in spinlock.h.
+  - split header files to emulate existing spinlock.h environment
+  
+	 
+
+
+  Wake Up of threads by * task_struct.
+  - Kernel daemons are often woken by the system they are servicing.
+    It is possible that the kernel daemon is blocked on a mutex,
+    and proper recovery action must prevent the thread from running 
+    while blocked. Transfer of priority (inheritance) should be
+    allowed if a thread is indeed blocked by a mutex.
+
+
+READ-WRITE LOCK SUBSTITUTION
+============================
+
+  Not currently under development.
+
+
+BUILDING THE KERNEL
+===================
+
+We have enabled most of the configuration options to get broad coverage 
+when compiling (and even running the code). 
+We suggest that you test and build a known good configuration for 
+your system, configuring the RT enhancements as per the defaults
+found in the kernel configuration section.
+
+
+
+IMPLEMENTATION DETAILS
+======================
+
+We have substituted the definition of kernel spinlocks with
+a mutex abstraction that uses the P-mutex from the Bundeswehr 
+University in Munich, Germany:
+
+http://inf3-www.informatik.unibw-muenchen.de/research/linux/mutex/
+
+The old spinlock definitions have been temporarily moved into a 
+file called old_spinlock.h, and a new spinlock.h file invokes 
+a crude but effective #define-based substitution.
+
+This methodology was first published in a 2.4 Linux kernel
+by TimeSys Corporation, however we have abstracted the mutex layer,
+providing selectable mutex implementations.
+
+
+Partitioning the Critical Sections:
+
+A partitioning between critical sections protected by spinlocks 
+and critical sections protected by mutexes has been established.
+
+Mutexes inside spinlocks
+------------------------
+
+There are currently some overlaps (or holes) in the partitioning.
+It is possible for a task holding a spinlock to block
+on a mutex, causing a deadlock. This deadlock is resolved for
+interactive tasks on UP only by grace of the interactive scheduler. 
+
+We have 2 choices to deal with these:
+
+1.	replace mutexes with old spinlock type
+2.	replace outer spinlock with mutex, moving spinlock lower in the nesting.
+
+We are continuing to eliminate up the nesting of mutex-protected
+sections inside of spinlock-protected critical sections. 
+Only a minimal set (teens) of the spinlocks will remain. 
+This set will be composed of spinlocks necessary to protect 
+immediate hardware, as well as minimal critical sections that 
+would not benefit from mutex-based preemptability.
+
+We expect to eventually bound preemption latency within
+the aggregate or worst-case IRQ-disable plus longest possible 
+spinlock-protected critical section.
+
+
+
+Configuration Options added to the RT kernel:
+--------------------------------------------
+We have added the following new configuration options to the kernel:
+
+
+config KMUTEX (required for RT kernel)
+        bool "Kernel mutexes replace spinlocks"
+        depends on (PREEMPT && (IRQ_THREADS || INGO_IRQ_THREADS))
+        default y
+        ---help---
+          Substituting spinlocks with mutexes reduces the average preemption
+          latency
+
+config KMUTEX_STATS (recommended)
+        bool "Keep kmutex performance stats"
+        depends on (PMUTEX || FMUTEX)
+        default y
+        ---help---
+          Log min, max, average locking times for each kmutex.
+
+config KMUTEX_DEBUGa(recommended)
+        bool "Enable KMUTEX debugging output"
+        depends on (PMUTEX || FMUTEX)
+        default y
+        ---help---
+          Reports status, state changes and possible error conditions.
+
+config KMUTEX_ATOMIC_DEBUG (not recommended)
+        bool "Report KMUTEX access while atomic"
+        depends on (KMUTEX_DEBUG)
+        default n
+        ---help---
+          Reports when a kmutex is locked while the process is atomic.
+
+config INGO_BKL (required for RT kernel)
+        bool "Replace the BKL with a sleeping lock"
+        default y
+        ---help---
+           Uses Ingo Molnars code to replace the BKL with
+           a semaphore.
+
+choice
+        prompt "Select lock"
+        depends on INGO_BKL
+        default BKL_SEM
+
+config BKL_SEM (recommended)
+        bool "BKL becomes the system semaphore."
+	default y
+        ---help---
+          Use the system semaphore to replace the BKL instead of
+          the kmutex.
+
+config BKL_MTX (untested)
+        bool "BKL becomes a mutex"
+        ---help---
+          Use the kmutex to replace the BKL instead of
+          the system semaphore.
+endchoice
+
+config KRCU_LOCKS (not recommended)
+        bool "Use rcu lock workaround"
+        depends on KMUTEX
+        default n
+        ---help---
+          Emulates rw-locks using mutex-based subsystem.
+
+config FMUTEX (not supported)
+        bool "Use Robust Mutexes (unsupported)"
+        default n
+
+config PMUTEX (required for RT kernel)
+        bool "Use Dirk Grambow's PMutexes"
+        default y
+
+config PMUTEX_PI (recommended for RT kernel)
+        bool "PMutex with simple priority inheritance"
+        depends on (PMUTEX)
+        default y
+
+config PMUTEX_PI_DEBUG (recommended)
+        bool "Enable PMUTEX priority inheritance debugging output"
+        depends on (PMUTEX_PI)
+        default y
+        ---help---
+          Reports PI events.
+
+config SOFTIRQ_THREADS (required for RT kernel)
+        bool "Run all softirqs in threads"
+        default y
+        depends on PREEMPT
+        help
+          This option creates a second softirq thread per CPU, which
+          runs at high real-time priority, to replace the softirqs
+          which were previously run immediately.  This allows these
+          softirqs to be prioritized, so as to avoid preempting
+          very high priority real-time tasks.  This also allows
+          certain spinlocks to be converted into sleeping mutexes,
+          for futher reduction of scheduling latency.
+
+config INGO_IRQ_THREADS (recommended)
+        bool "Support for Ingo Molnar's version of IRQ Threads."
+        default y
+        depends on !IRQ_THREADS && SOFTIRQ_THREADS
+        help
+          Interrupts are redirected to high priority threads.
+
+config IRQ_THREADS (deprecated)
+        bool "Run all IRQs in threads by default"
+        depends on PREEMPT && SOFTIRQ_THREADS
+        help
+          This option creates a thread for each IRQ, which runs at
+          high real-time priority, unless the SA_NOTHREAD option is
+          passed to request_irq().  This allows these IRQs to be
+          prioritized, so as to avoid preempting very high priority
+          real-time tasks.  This also allows certain spinlocks to be
+          converted into sleeping mutexes, for futher reduction of
+          scheduling latency (however, this is not done automatically).
+
+
+Patch Descriptions
+------------------
+
+Linux-2.6.9-rc3_RT_irqthreads.patch
+===================================
+This patch is a hybrid of several IRQ threads implementations, 
+as cited above.
+We have made some modifications to adapt wake-up to handle 
+the scenario where an IRQ thread could be blocked on a mutex 
+at transition of an interrupt.
+ 
+We expect to revise this IRQ thread code after moving to 
+the mm kernel series, and while incorporating the voluntary 
+preemption code.
+
+This patch adds options to the 'General setup' section of 
+the kernel configuration. Running irqs in threads is 
+prerequisite for the subsequent patches. We have provided 
+defaults for running softirqs in threads, and have selected 
+Ingo Molnar's IRQ thread implementation as default. 
+
+
+CONFIG_SOFTIRQ_THREADS
+
+- required for RT kernel. Runs all softirqs in softirqd
+
+CONFIG_INGO_THREADS
+
+- enable Ingo Molnar's version of IRQ threads. This is not
+  in sync with the latest releases in the voluntary preempt
+  series.
+
+CONFIG_IRQ_THREADS
+- version of IRQ threads posted to LKML by Scott Wood.
+  This appears to have been superceded by Ingo Molnar's changes.
+
+
+In addition, this patch includes a port of Ingo Molnar's 
+proposed substitution of the BKL into the kernel semaphore. 
+
+
+Linux-2.6.9-rc3_RT_mutex.patch
+==============================
+
+
+This patch includes the (modified) PMutex from 
+the Universitaet der Bundeswehr, Germany.
+
+(see: http://inf3-www.informatik.unibw-muenchen.de/research/linux/mutex/)
+
+In addition, we have included an abstraction layer
+for timing and debugging instrumentation, and to
+allow using other mutex implementation for spinlock
+substitution. We have considered using the OSDL fusyn
+project, and the Linux system semaphore. 
+
+This patch alone does not provide any real-time 
+functionality, until the subsequent spinlock 
+patches have been applied.
+
+This patch also includes the rttReleaseNotes file
+for addition to the kernel's Documentation directory. 
+This file describes in detail the modifications,
+requirements and issues related to the RT kernel 
+modifications.
+
+
+Linux-2.6.9-rc3_RT_spinlock[12].patch
+=====================================
+
+These are 2 patches substituting mutexes with spinlocks
+in the kernel.
+
+A number of spinlocks, especially those protecting scheduler
+run queues, and some protecting hardware, notably the system timer,
+cannot be substituted with mutexes.
+
+These patches create a partitioning between low-level spinlocks
+and mutexes in the kernel. There are some holes existing in this
+partitioning in the current release.
+
+As discussed in the introductory email, this can result in deadlock
+situations, if a process first locks a spinlock, and then suspends
+on a contended mutex. We are in the process of resolving these issues.
+
+New configuration options include:
+
+CONFIG_KMUTEX 
+
+Substitutes mutexes for the spinlock_t, and remaps corresponding
+operations to mutex_lock, and mutex_unlock.
+
+CONFIG_KMUTEX_STATS
+
+This enables locking time tracing and other (incomplete) analysis
+features.
+
+CONFIG_KMUTEX_DEBUG
+
+Enables additional debugging output
+
+CONFIG_KMUTEX_ATOMIC_DEBUG
+
+Warns while locking a mutex when the process is running with
+preemption disabled ("bad: scheduling while atomic")
+
+PMutex configuration:
+
+CONFIG_PMUTEX
+
+Enable PMutex subsystem
+
+CONFIG_PMUTEX_PI
+
+Enable priority inheritance
+
+CONFIG_PMUTEX_PI_DEBUG
+
+Report PI events (noisy)
+
+
+
+Contributors and References
+---------------------------
+
+UNIBW-Muenchen PMutex project
+http://inf3-www.informatik.unibw-muenchen.de/research/linux/mutex/
+
+
+We hope that this will help and inspire those who hope to 
+eventually be able to provision reliably timed multimedia 
+or control functions in Linux tasks.
+
+
+Credits
+-------
+
+Sven-Thorsten Dietrich	sdietrich@mvista.com
+Alexander Batyrshin	abatyrshin@ru.mvista.com
+Aleksey Makarov		amakarov@ru.mvista.com
+Eugeny S. Mints		emints@ru.mvista.com
+Daniel Walker		dwalker@mvista.com
+Yi Yang			yyang@ch.mvista.com
+Haitao Zhang		hzhang@ch.mvista.com
+
diff -pruN a/include/linux/kmutex.h b/include/linux/kmutex.h
--- a/include/linux/kmutex.h	1970-01-01 03:00:00.000000000 +0300
+++ b/include/linux/kmutex.h	2004-10-09 00:46:12.000000000 +0400
@@ -0,0 +1,134 @@
+#ifndef __LINUX_KMUTEX_H
+#define __LINUX_KMUTEX_H
+
+/*
+ * include/linux/kmutex.h - generic locking declarations
+ *
+ *  2004-07-01  RT Prototype 2004 (c) MontaVista Software, Inc.
+ *              This file is licensed under the terms of the GNU
+ *              General Public License version 2. This program
+ *              is licensed "as is" without any warranty of any kind,
+ *              whether express or implied.
+ *
+ * This file abstracts the kernel mutex operations associated with
+ * spinlocks and read-write locks into a specific function library.
+ * 
+ *
+ */
+
+#include <linux/config.h>
+
+/* ----------------------------------------------------------------------*/
+
+/* The PMutex from  UNIBW-Muenchen, Dirk Grambow
+ */
+
+# if defined CONFIG_PMUTEX 
+#   include <linux/pmutex.h>
+  /* _kmutex_t is the raw mutex lock. kmutex itself contains this */
+#define _kmutex_t struct p_mutex
+
+#   define _KMUTEX_INIT 		PMUTEX_PARTIAL_INIT
+
+# endif
+
+/* 
+ * Generic Mutex definitions */
+
+  struct kmutex_stat {
+	unsigned long long sleep_start;
+	unsigned long long sleep_end; 
+	unsigned long long longest_sleep;
+	unsigned long lock_count;
+	unsigned long sleep_count;
+	unsigned long long sleep_average;
+  };
+
+  struct kmutex {
+	_kmutex_t kmtx;
+# if defined CONFIG_KMUTEX_DEBUG
+	unsigned long magic;	 
+# endif
+# ifdef CONFIG_KMUTEX_STATS
+	struct kmutex_stat mstat;
+# endif
+  };
+
+  typedef struct kmutex kmutex_t;
+
+  extern void kmutex_init	(struct kmutex * lock);
+  extern void kmutex_lock	(struct kmutex * lock);
+  extern void kmutex_unlock	(struct kmutex * lock);
+  extern void kmutex_unlock_wait(struct kmutex * lock);
+  extern int  kmutex_trylock	(struct kmutex * lock);
+  extern int  kmutex_is_locked	(struct kmutex * lock);
+
+//extern int  atomic_dec_and_kmutex_lock(atomic_t *atomic, struct kmutex *mtx);
+
+
+# if defined CONFIG_KMUTEX_DEBUG
+#  define KMUTEX_MAGIC 0xACE1480f
+#  define KMUTEX_MAGIC_INIT ,  KMUTEX_MAGIC
+# else
+#  define KMUTEX_MAGIC_INIT 
+# endif
+
+# if defined CONFIG_KMUTEX_STATS 
+#   define KMUTEX_STAT_ZERO      { 0, 0, 0, 0, 0, 0 }
+#   define KMUTEX_STAT_INIT  , KMUTEX_STAT_ZERO
+# else
+#   define KMUTEX_STAT_INIT 
+# endif
+
+#   define KMUTEX_INIT (kmutex_t) { _KMUTEX_INIT KMUTEX_MAGIC_INIT \
+					KMUTEX_STAT_INIT }
+
+/* kmutex-based read locks - under construction */
+/* read-lock:  lock mutex, increment read count, unlock mutex */
+/* write-lock: lock mutex, check read count.
+	- if 0, mutex is locked for writing: return
+	- if 1, writer must wait:
+		- unlock mutex
+		- sleep
+ */
+  struct krw_lock {
+	_kmutex_t mtx;
+	int read_count; /* number of readers */
+	struct list_head rlist; /* reader list-replace with priolist */
+	// diags:
+	// max number of readers
+	// avg num readers
+	// lock access count read and write
+	// number of times write blocks
+	// number of times readers blocked 
+	// (expand to count reader on max readers / writers)
+  };
+
+  typedef struct krw_lock krw_lock_t;
+
+	
+# define KRW_LOCK_INIT   (struct krw_lock)  {_KMUTEX_INIT, 0, { NULL, NULL } }
+
+  extern void krwlock_init  (struct krw_lock *lock);
+  extern void kread_lock    (struct krw_lock *lock);
+  extern void kread_unlock  (struct krw_lock *lock);
+  extern void kwrite_lock   (struct krw_lock *lock);
+  extern void kwrite_unlock (struct krw_lock *lock);
+  extern int  krw_is_locked (struct krw_lock *lock);
+
+
+# if defined CONFIG_KMUTEX & defined CONFIG_KRW_LOCKS
+
+/* The generic KMUTEX spinlock substitution mappings.
+ * These mappings actually substitute spinlocks for
+  * kernel mutexes. They depend upon definitions set 
+  * in the mutex-specific sections above */
+
+#   define rwlock_t            	struct krw_lock
+#   define rwlock_init 		krwlock_init
+#   define RW_LOCK_UNLOCKED 	KRW_LOCK_INIT
+
+# endif /* KMUTEX spinlock substitution */
+
+#endif   /* __LINUX_KMUTEX_H */
+
diff -pruN a/include/linux/pmutex.h b/include/linux/pmutex.h
--- a/include/linux/pmutex.h	1970-01-01 03:00:00.000000000 +0300
+++ b/include/linux/pmutex.h	2004-10-09 00:45:40.000000000 +0400
@@ -0,0 +1,188 @@
+/*
+ *      pmutex.h  -- mutex implementation with priority inheritance
+ *
+ *      See
+ *      http://inf33-www.informatik.unibw-muenchen.de/research/linux/mutex.html
+ *      for details of the used priority inheritance protocol.
+ *
+ *      Copyright (C) 2002, 2003, 2004 Dirk Grambow
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation; either version 2 of the License, or
+ *      (at your option) any later version.
+ *
+ *      This program is distributed in the hope that it will be useful,
+ *      but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *      GNU General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public License
+ *      along with this program; if not, write to the Free Software
+ *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ */
+
+#ifndef __LINUX_PMUTEX_H
+#define __LINUX_PMUTEX_H
+
+#include <asm/atomic.h>
+#include <linux/list.h>
+
+#ifdef CONFIG_PMUTEX_PI
+# define CONFIG_MTX_PI 1
+#endif
+
+struct p_sleeper_list {
+	struct list_head list;
+	unsigned long priority;
+	struct task_struct *task;
+};
+
+typedef struct p_sleeper_list p_sleeper_list_t;
+
+struct p_mutex {
+	int m_lock, m_missed;
+	struct list_head m_sleepers;
+	struct task_struct **owner;
+#ifdef CONFIG_MTX_PI
+	unsigned long initial_prio;
+#endif
+};
+
+typedef struct p_mutex p_mutex_t;
+
+extern int atomic_dec_and_pmutex_lock(atomic_t *atomic, p_mutex_t *mtx);
+
+#ifdef CONFIG_MTX_PI
+#define MAX_PRIORI 100
+
+#define DECLARE_P_MUTEX(x) \
+p_mutex_t (x) = { 1, 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((x).m_sleepers) \
+			, 0, MAX_PRIORI}
+#define PMUTEX_PARTIAL_INIT { 1, -1, { NULL, NULL}, 0, MAX_PRIORI}
+#else
+
+#define DECLARE_P_MUTEX(x) \
+p_mutex_t (x) = { 1, 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((x).m_sleepers)}
+#define PMUTEX_PARTIAL_INIT { 1, -1, { NULL, NULL }}
+#endif
+
+
+
+/* m_lock field value corresponds to unlocked mutex */
+#define PMUTEX_LOCK_UNLOCKED    1
+/* m_missed field value corresponds to unlocked mutex */
+#define PMUTEX_MISSED_SET       1
+
+/* macro to determine whether the given mutex is locked */
+#define p_mutex_is_locked(x)     (((x)->m_lock != PMUTEX_LOCK_UNLOCKED) && \
+                                  ((x)->m_missed != PMUTEX_MISSED_SET))
+
+
+static inline void p_mutex_init(p_mutex_t *mtx)
+{	
+	mtx->m_lock = 1;
+	mtx->m_missed = 0;
+	INIT_LIST_HEAD(&mtx->m_sleepers);
+	mtx->owner = 0;
+#ifdef CONFIG_MTX_PI
+	mtx->initial_prio = MAX_PRIORI;
+#endif
+}
+
+extern void __p_mutex_down(p_mutex_t *mtx);
+extern void __p_mutex_up(p_mutex_t *mtx);
+
+/*
+ *   The following i386 p_mutex_down() and p_mutex_up() implementations are
+ *   based on their include/asm/semaphore.h counterparts.
+ */
+
+static inline void p_mutex_down(p_mutex_t *mtx)
+{
+	/* This is here to initialize the sleepers list
+         * for statically declared spinlocks that use
+	 * the SPINLOCK_UNLOCKED initializer, which we
+	 * cannot emulate. A priority list with insertion 
+	 * < O(n) should be used here to eliminate the
+	 * static initialization */
+	if (mtx->m_missed < 0)
+        {
+                INIT_LIST_HEAD(&mtx->m_sleepers);
+                mtx->m_missed= 0;
+        }
+
+	__asm__ __volatile__ (
+		"\t"
+		"pushfl\n\t"
+		"cli\n\t"
+		LOCK "decl %0\n\t"
+		"js 2f\n"
+		"\tmovl %%esp, %1\n\t"
+		"andl $-8192, %1\n\t"
+		"popfl\n"
+		"1:\n"
+		".subsection 1\n"
+		"2:\t"
+		"popfl\n\t"
+		"pushl %%eax\n\t"
+		"pushl %%edx\n\t"
+		"pushl %%ecx\n\t"
+		"call __p_mutex_down\n\t"
+		"popl %%ecx\n\t"
+		"popl %%edx\n\t"
+		"popl %%eax\n\t"
+		"jmp 1b\n"
+		".subsection 0\n"
+		:"=m" (mtx->m_lock)
+		, "=m" (mtx->owner)
+		:"c" (mtx)
+		:"memory");
+}
+
+
+static inline void p_mutex_up(p_mutex_t *mtx)
+{
+	if (mtx->m_missed < 0)
+        {
+                BUG();
+        }
+
+	__asm__ __volatile__ (
+		"\t"
+		LOCK "incl %0\n\t"
+		"jle 2f\n"
+		"1:\n"
+		".subsection 1\n"
+		"2:\tpushl %%eax\n\t"
+		"pushl %%edx\n\t"
+		"pushl %%ecx\n\t"
+		"call __p_mutex_up\n\t"
+		"popl %%ecx\n\t"
+		"popl %%edx\n\t"
+		"popl %%eax\n\t"
+		"jmp 1b\n"
+		".subsection 0\n"
+		:"=m" (mtx->m_lock)
+		:"c" (mtx)
+		:"memory");
+}
+
+/* p_mutex_trylock --
+ *     Attempts to obtain the given mutex. Returns immediatly if the
+ *     mutex is contended or grabs the mutex otherwise.
+ *
+ * PARAMETERS:
+ *     mtx - mutex
+ *
+ * RETURNS:
+ *     nonzero if the mutex obtained successfully, 0 otherwise
+ */
+
+
+/* trylock does not assign the owner */
+inline int p_mutex_trylock(p_mutex_t *mtx);
+
+#endif
diff -pruN a/include/linux/spin_undefs.h b/include/linux/spin_undefs.h
--- a/include/linux/spin_undefs.h	1970-01-01 03:00:00.000000000 +0300
+++ b/include/linux/spin_undefs.h	2004-10-09 00:36:59.000000000 +0400
@@ -0,0 +1,67 @@
+
+/*
+ * include/linux/spin_undefs.h - spinlock un-substitution
+ *
+ *  2004-08-12  RT Prototype 2004 (c) MontaVista Software, Inc.
+ *              This file is licensed under the terms of the GNU
+ *              General Public License version 2. This program
+ *              is licensed "as is" without any warranty of any kind,
+ *              whether express or implied.
+ *
+ * This file unmaps the kernel mutex operations associated with
+ * spinlocks. This file is used when all the spinlocks in a file
+ * are of the old type. It redefines existing definitions for
+ * spinlocks back to the old type.
+ * The file should be included using the following construct:
+ * #ifdef KMUTEX
+ * # include <linux/spin_undefs.h>
+ * #endif
+ *
+ *
+ * This is a dirty dirty hack, but it helps to compress the
+ * patch for mutexes down to 1 line in some files, which
+ * is essential for making a portable prototype.
+ * 
+ */
+
+/* use this include only in C files where all spinlock calls
+   are replaced with _spin... */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_KMUTEX
+# undef  spin_lock
+# define spin_lock              _spin_lock
+
+# undef  spin_unlock
+# define spin_unlock            _spin_unlock
+
+# undef  spin_lock_bh
+# define spin_lock_bh   	_spin_lock_bh
+
+# undef  spin_unlock_bh
+# define spin_unlock_bh 	_spin_unlock_bh
+
+# undef  spin_lock_irq
+# define spin_lock_irq   	_spin_lock_irq
+
+# undef  spin_unlock_irq
+# define spin_unlock_irq 	_spin_unlock_irq
+
+# undef  spin_lock_irqsave
+# define spin_lock_irqsave      _spin_lock_irqsave
+
+# undef  spin_unlock_irqrestore
+# define spin_unlock_irqrestore _spin_unlock_irqrestore
+
+# undef  spin_is_locked
+# define spin_is_locked		_spin_is_locked
+
+
+# undef  spinlock_t
+# define spinlock_t             _spinlock_t
+
+# undef  SPIN_LOCK_UNLOCKED
+# define SPIN_LOCK_UNLOCKED _SPIN_LOCK_UNLOCKED
+#endif
+
diff -pruN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2004-10-09 00:36:39.000000000 +0400
+++ b/init/Kconfig	2004-10-09 00:37:00.000000000 +0400
@@ -224,6 +224,35 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
+config KMUTEX
+        bool "Kernel mutexes replace spinlocks"
+        depends on (PREEMPT && (IRQ_THREADS || INGO_IRQ_THREADS))
+        default y
+        ---help---
+          Substituting spinlocks with mutexes reduces the average preemption
+	  latency
+
+config KMUTEX_STATS
+        bool "Keep kmutex performance stats"
+        depends on (PMUTEX || FMUTEX)
+        default y
+        ---help---
+          Log min, max, average locking times for each kmutex.
+
+config KMUTEX_DEBUG
+        bool "Enable KMUTEX debugging output"
+        depends on (PMUTEX || FMUTEX)
+        default y
+        ---help---
+          Reports status, state changes and possible error conditions.
+
+config KMUTEX_ATOMIC_DEBUG
+        bool "Report KMUTEX access while atomic"
+        depends on (KMUTEX_DEBUG)
+        default n 
+        ---help---
+          Reports when a kmutex is locked while the process is atomic.
+
 config INGO_BKL
 	bool "Replace the BKL with a sleeping lock"
 	default y 
@@ -249,6 +278,38 @@ config BKL_MTX
           the system semaphore.
 endchoice
 
+config KRCU_LOCKS
+        bool "Use rcu lock workaround"
+        depends on KMUTEX
+        default n
+	---help---
+	  Emulates rw-locks using mutex-based subsystem.
+
+config FMUTEX
+        bool "Use Robust Mutexes (unsupported)"
+        default n
+
+config PMUTEX
+        bool "Use Dirk Grambow's PMutexes"
+        default y
+
+config PMUTEX_DEADLOCK_DETECTION
+        bool "PMutex Deadlock detection mechanism"
+        depends on (PMUTEX)
+        default n
+
+config PMUTEX_PI
+        bool "PMutex with simple priority inheritance"
+        depends on (PMUTEX)
+        default y
+
+config PMUTEX_PI_DEBUG
+        bool "Enable PMUTEX priority inheritance debugging output"
+        depends on (PMUTEX_PI)
+        default y
+        ---help---
+          Reports PI events. 
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
diff -pruN a/kernel/kmutex.c b/kernel/kmutex.c
--- a/kernel/kmutex.c	1970-01-01 03:00:00.000000000 +0300
+++ b/kernel/kmutex.c	2004-10-09 00:46:29.000000000 +0400
@@ -0,0 +1,114 @@
+
+/*
+ * kernel/kmutex.c - generic locking functions to replace spinlocks
+ *		     and rw locks.
+ *
+ *  2004-07-01  RT Prototype 2004 (c) MontaVista Software, Inc.
+ *              This file is licensed under the terms of the GNU
+ *              General Public License version 2. This program
+ *              is licensed "as is" without any warranty of any kind,
+ *              whether express or implied.
+ *
+ * This file maps the kernel mutex operations associated with
+ * spinlocks and read-write locks into a specific function library.
+ * 
+ * By default, the old spinlocks are retained.
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/kmutex.h>
+#include <linux/sched.h>
+
+# if defined CONFIG_PMUTEX
+#   include <linux/pmutex.h>
+
+#   define _kmutex_init(lock)           p_mutex_init    (lock)
+#   define _kmutex_lock(lock)           p_mutex_down    (lock)
+#   define _kmutex_unlock(lock)         p_mutex_up      (lock)
+
+
+inline int atomic_dec_and_kmutex_lock(atomic_t *atomic, struct kmutex *lock)
+{ 
+	return atomic_dec_and_pmutex_lock(atomic, &(lock->kmtx)); 
+}
+
+
+inline int kmutex_trylock(struct kmutex *lock)
+{
+        return p_mutex_trylock(&(lock->kmtx));
+}
+
+
+inline int kmutex_is_locked(struct kmutex *lock)
+{
+	return p_mutex_is_locked(&(lock->kmtx));
+}
+# endif
+
+
+
+void kmutex_init(struct kmutex * lock)
+{ 
+                _kmutex_init(&(lock->kmtx));                             
+#if defined CONFIG_KMUTEX_DEBUG
+                lock->magic = KMUTEX_MAGIC;      
+#endif
+#if defined CONFIG_KMUTEX_STATS
+                lock->mstat = (struct kmutex_stat) KMUTEX_STAT_ZERO;  
+#endif
+} 
+
+
+/*
+ * print warning is case kmutex_lock is called while preempt count is
+ * non-zero
+ */
+void kmutex_lock(struct kmutex * lock) 
+{ 
+#if defined CONFIG_KMUTEX_DEBUG
+                if (lock->magic != KMUTEX_MAGIC) BUG(); 
+# if defined(CONFIG_KMUTEX_ATOMIC_DEBUG)
+                if (preempt_count()) {
+                        printk("kmutex_lock: call at %s:%d " 
+                               "while preempt_count is %d\n",  
+                        __FILE__, __LINE__, 
+                        preempt_count());
+                        dump_stack(); 
+                } 
+# endif
+#endif
+#if defined CONFIG_KMUTEX_STATS
+                lock->mstat.sleep_start = sched_clock(); 
+#endif
+                _kmutex_lock(&(lock->kmtx));                                
+#if defined CONFIG_KMUTEX_STATS
+                lock->mstat.sleep_end = sched_clock();   
+#endif
+} 
+
+void kmutex_unlock(struct kmutex *lock) 
+{ 
+#if defined CONFIG_KMUTEX_DEBUG
+                if (lock->magic != KMUTEX_MAGIC) BUG();  
+#endif
+#if defined CONFIG_KMUTEX_STATS
+                lock->mstat.sleep_start = sched_clock();  
+#endif
+                _kmutex_unlock(&(lock->kmtx));                               
+#if defined CONFIG_KMUTEX_STATS
+                lock->mstat.sleep_end = sched_clock();    
+#endif
+}
+
+
+void kmutex_unlock_wait(struct kmutex * lock)
+{ 
+                if (kmutex_is_locked(lock)) {  
+                        kmutex_lock(lock); 
+                        kmutex_unlock(lock); 
+                }  
+}
+
+
diff -pruN a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-10-09 00:36:39.000000000 +0400
+++ b/kernel/Makefile	2004-10-09 00:37:00.000000000 +0400
@@ -24,6 +24,8 @@ obj-$(CONFIG_STOP_MACHINE) += stop_machi
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_PMUTEX) += pmutex.o
+obj-$(CONFIG_KMUTEX) += kmutex.o
 
 
 ifneq ($(CONFIG_IA64),y)
diff -pruN a/kernel/pmutex.c b/kernel/pmutex.c
--- a/kernel/pmutex.c	1970-01-01 03:00:00.000000000 +0300
+++ b/kernel/pmutex.c	2004-10-09 00:47:08.000000000 +0400
@@ -0,0 +1,229 @@
+/*
+ *      pmutex.c  -- mutex implementation with priority inheritance
+ *
+ *      See
+ *      http://inf33-www.informatik.unibw-muenchen.de/research/linux/mutex.html
+ *      for details of the used priority inheritance protocol.
+ *
+ *      Copyright (C) 2002, 2003, 2004 Dirk Grambow
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation; either version 2 of the License, or
+ *      (at your option) any later version.
+ *
+ *      This program is distributed in the hope that it will be useful,
+ *      but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *      GNU General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public License
+ *      along with this program; if not, write to the Free Software
+ *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/pmutex.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/thread_info.h>
+
+#include <linux/spin_undefs.h>
+
+#ifdef CONFIG_PMUTEX_PI
+# define CONFIG_MTX_PI 1
+#endif
+
+/* Enable debugging */
+#define DEBUG_MTX 1
+
+static spinlock_t m_spin_lock = SPIN_LOCK_UNLOCKED;
+
+#ifdef CONFIG_MTX_PI
+extern void setscheduler_pi(task_t *p, int policy, unsigned long prio);
+#endif
+
+
+int atomic_dec_and_pmutex_lock(atomic_t *atomic, p_mutex_t *mtx)
+{
+        p_mutex_down(mtx);
+        if (atomic_dec_and_test(atomic))
+                return 1;
+        p_mutex_up(mtx);
+        return 0;
+}
+
+
+/* this function returns 1 if the  process is on the waitrers list */
+#ifdef DEBUG_MTX
+static inline int check_current_on_waiters_list(p_mutex_t *mtx)
+{
+        struct list_head *pos;
+
+        list_for_each(pos, &mtx->m_sleepers) {
+                if (current == (list_entry(pos, p_sleeper_list_t, list)->task))
+			return 1;
+	}
+	return 0;
+}
+#endif /* DEBUG_MTX */
+
+__attribute__((regparm(0)))
+void __p_mutex_down(p_mutex_t *mtx)
+{
+	struct list_head *pos;
+	p_sleeper_list_t new, *entry;
+	task_t *owner;
+	
+	INIT_LIST_HEAD(&new.list);	
+	new.task = current; // get_current();//???
+	new.priority = new.task->rt_priority;
+	
+	_spin_lock(&m_spin_lock);
+
+	if (unlikely(mtx->m_missed)) {
+		mtx->m_missed = 0;
+                mtx->owner = (task_t **)current_thread_info();
+		_spin_unlock(&m_spin_lock);
+#ifdef DEBUG_MTX
+		printk("__p_mutex_down: Mtx %08x task [%d] missed task!!!\n",
+				(int) mtx, current->pid);
+#endif
+		return;
+	}
+#ifdef DEBUG_MTX
+	/* is this not part of deadlock detect? */
+	if (check_current_on_waiters_list(mtx) == 1)
+	{
+		printk("__p_mutex_down: mtx 0x%x; process 0x%x already in "
+			"waiters list!\n", (int) mtx, (int) current);
+		BUG();
+	}
+
+#endif /* DEBUG_MTX */
+	list_for_each(pos, &mtx->m_sleepers) {
+		entry = list_entry(pos, p_sleeper_list_t, list);
+		if (entry->priority < new.priority)
+			break;
+	}
+	list_add_tail(&new.list, pos);
+	
+        owner = *(mtx->owner);
+
+#ifdef CONFIG_MTX_PI
+	if (current->rt_priority >  owner->rt_priority) {
+		if (mtx->initial_prio == MAX_PRIORI) {
+			if (owner->rt_priority == 0)
+				owner->policy = SCHED_FIFO;
+			mtx->initial_prio = owner->rt_priority;
+		}
+#ifdef CONFIG_PMUTEX_PI_DEBUG
+		printk("Mtx: %08x [%d] pri (%lu) inherit from [%d] "
+				"pri(%lu)\n", 
+			mtx, owner->pid, owner->rt_priority, 
+			current->pid, current->rt_priority);
+#endif
+		setscheduler_pi(owner, owner->rt_priority ? -1 : SCHED_FIFO, 
+					current->rt_priority);		
+	}
+#endif	
+	current->state = TASK_UNINTERRUPTIBLE;
+	
+	_spin_unlock(&m_spin_lock);
+	schedule();
+
+        mtx->owner = (struct task_struct**)current_thread_info();
+	
+}
+
+ __attribute__((regparm(0)))
+void __p_mutex_up(p_mutex_t *mtx)
+{
+	struct list_head *first;	
+	task_t *owner;
+
+	_spin_lock(&m_spin_lock);
+	
+	if (unlikely(list_empty(&mtx->m_sleepers))) {
+		mtx->m_missed = 1;
+		mtx->owner = 0;
+#ifdef DEBUG_MTX
+		printk("__p_mutex_up: Mtx %08x task [%d] list is empty\n",
+				(int) mtx, current->pid);
+#endif
+		_spin_unlock(&m_spin_lock);
+		return;
+	}
+
+#ifdef DEBUG_MTX
+	owner = *(mtx->owner);
+	if (!(*(mtx->owner)))
+		{
+                printk("*** MUTEX (0x%x), thread %s[%d] on up() no owner ", 
+			(int) mtx, current->comm, current->pid);
+		dump_stack();
+		}
+	else {
+
+		if (unlikely(owner != current)) {
+        	        printk("*** MUTEX (0x%x), thread %s[%d] on up() "
+				"owner (0x%x) is %s[%d]\n", (int) mtx, 
+				current->comm, current->pid, (int) owner, 
+				owner->comm, owner->pid);
+			dump_stack();
+		}
+	}
+#endif
+
+	first = mtx->m_sleepers.next;
+
+        mtx->owner = &(list_entry(first, p_sleeper_list_t, list)->task);
+
+#ifdef CONFIG_MTX_PI
+	if (mtx->initial_prio != MAX_PRIORI) {
+		if (current->rt_priority > mtx->initial_prio) {
+#ifdef CONFIG_PMUTEX_PI_DEBUG
+			task_t *owner;
+                        owner = *(mtx->owner);
+
+			printk("Mtx %08x task [%d] pri (%lu) restored "
+				"pri(%lu). Next owner [%d] pri (%lu)\n", 	
+				mtx, current->pid, current->rt_priority,
+				mtx->initial_prio, owner->pid,
+				 owner->rt_priority); 
+#endif
+			setscheduler_pi(current, mtx->initial_prio ? -1 : SCHED_NORMAL, mtx->initial_prio);					
+		}
+		mtx->initial_prio = MAX_PRIORI;
+	}
+#endif
+
+	list_del(first);
+	wake_up_process(list_entry(first, p_sleeper_list_t, list)->task);
+		
+	_spin_unlock(&m_spin_lock);
+}
+
+inline int p_mutex_trylock(p_mutex_t *mtx)
+{
+
+        if (mtx->m_missed < 0) {
+                INIT_LIST_HEAD(&mtx->m_sleepers);
+                mtx->m_missed= 0;
+        }
+
+        if (cmpxchg(&mtx->m_lock, 1, 0) == 1) {
+                mtx->owner = (task_t **)current_thread_info();
+                return 1;
+        } else {
+                return 0;
+        }
+}
+
+
+EXPORT_SYMBOL(__p_mutex_down);
+EXPORT_SYMBOL(__p_mutex_up);
diff -pruN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-10-09 00:36:39.000000000 +0400
+++ b/kernel/sched.c	2004-10-09 01:11:25.000000000 +0400
@@ -3439,6 +3439,57 @@ out_nounlock:
 	return retval;
 }
 
+#ifdef CONFIG_PMUTEX_PI
+/**
+ * setscheduler_pi - used by pmutex.c's priority inheritance mechanism to
+ * set/change the scheduler policy and RT priority
+ */
+void setscheduler_pi(task_t *p, int policy, unsigned long prio)
+{
+       int oldprio;
+       prio_array_t *array;
+       unsigned long flags;
+       runqueue_t *rq;
+                                                                                                                    
+       /*
+        * We play safe to avoid deadlocks.
+        */
+       read_lock_irq(&tasklist_lock);
+                                                                                                                    
+       /*
+        * To be able to change p->policy safely, the apropriate
+        * runqueue lock must be held.
+        */
+       rq = task_rq_lock(p, &flags);
+                                                                                                                    
+       if (policy < 0)
+               policy = p->policy;
+                                                                                                                    
+       array = p->array;
+       if (array)
+               deactivate_task(p, task_rq(p));
+       oldprio = p->prio;
+       __setscheduler(p, policy, prio);
+                                                                                                                    
+       if (array) {
+               __activate_task(p, task_rq(p));
+               /*
+                * Reschedule if we are currently running on this runqueue and
+                * our priority decreased, or if we are not currently running on
+                * this runqueue and our priority is higher than the current's
+                */
+               if (rq->curr == p) {
+                       if (p->prio > oldprio)
+                               resched_task(rq->curr);
+               } else if (p->prio < rq->curr->prio)
+                       resched_task(rq->curr);
+       }
+                                                                                                                    
+       task_rq_unlock(rq, &flags);
+       read_unlock_irq(&tasklist_lock);
+}
+#endif
+
 /**
  * sys_sched_setscheduler - set/change the scheduler policy and RT priority
  * @pid: the pid in question.
diff -pruN a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	2004-10-08 16:07:58.000000000 -0700
+++ b/drivers/char/Kconfig	2004-10-08 11:42:54.000000000 -0700
@@ -183,6 +183,7 @@ config ESPSERIAL
 
 config MOXA_INTELLIO
 	tristate "Moxa Intellio support"
+	default n
 	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa Intellio multiport serial card.
diff -pruN a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	2004-08-13 22:37:25.000000000 -0700
+++ b/arch/i386/defconfig	2004-10-08 14:27:33.000000000 -0700
@@ -1221,7 +1221,7 @@ CONFIG_OPROFILE=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_FRAME_POINTER is not set
-CONFIG_4KSTACKS=y
+# CONFIG_4KSTACKS is not set
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
 



