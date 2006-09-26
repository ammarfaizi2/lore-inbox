Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWIZOgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWIZOgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWIZOgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:36:24 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:46074 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932087AbWIZOgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:36:23 -0400
Date: Tue, 26 Sep 2006 07:34:20 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
Subject: 2.6.18 perfmon new code base + libpfm + pfmon
Message-ID: <20060926143420.GF14550@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new code base package.
This version of the kernel patch is relative to 2.6.18. This longer
than usual delay between releases comes from the large amount of changes
than went into this new release following the feedback I got on LKML. As
a result, the code has improved.

The kernel patch is split between infrastructure work and perfmon2 proper.
The infrastructure contains the following changes which will be integrated
into mainline before perfmon2 is. They are provided in the base.diff file.
The infrastructure changes include:
	- x86_64: fix idle_notifier to cover all interrupts entry/exit for idle thread
	- i386  : add idle notifier (copy of x86_64 notifier)
	- ia64  : idle notifier (copy of x86_64 notifier)
	- i386  : add smp_call_function_single()
	- i386  : add CPU_HAS_PEBS to cpufeature.h
	- x86_64: add CPU_HAS_PEBS to cpufeature.h
	- x86_64: use TIF flags for debug registers + IO bitmap lazy context switching
	- ia64  : add is_multithreading_enabled() to detect whether threads could be activated (HOTPLUG)
	- i386  : add is_multithreading_enabled() to detect whether threads could be activated (HOTPLUG)
	- x86-64: add is_multithreading_enabled() to detect whether threads could be activated (HOTPLUG)


The perfmon2 kernel patch includes:
	- updated to 2.6.18. System call numbers have once again changed (non IA-64)
	- leverage TIF mechanism for context switch on i386/x86-64/MIPS
	- leverage TIF mechanism for kernel exit work (TIF_PERFMON_WORK)
	- system-wide monitoring is turned off when entering the low level idle loop
	- removed PFM_EXCL_IDLE (use idle notifier)
	- removed perfmon_kapi.c, need to make a stronger case or find alternatives
	- improved checking on vector arguments to avoid overflows
	- corrected RLIMIT_MEMLOCK accounting
	- using sched_clock() for all duration calculation and default format timestamp
	- merged 32-bit and 64-bit PEBS support for P4 (two distinct UUID still)
	- removed insecure mode (cr4.pce) for i386, x86_64
	- fixed P4 ESCR/CCCR register mappings when HyperThreading is enabled (Kevin Corry)
	- added license on all files
	- reinforced error checking in sysfs related code
	- rewritten sysfs register mapping, now have  one file = one value
	- PMU description table exposes hardware address/idx through sysfs
	- enforced use of ptrace to block a thread in per-thread mode
	- added CPU HOTPLUG support (system-wide mode)
	- MIPS updates by Phil Mucci
	- fixed locking issues
	- renamed perfmon_amd64.c to perfmon_k8.c
	- Support sharing of PMU with NMI watchdog (AMD K8 processors ONLY)
	- split perfmon.c some more: read/write support in perfmon_rw.c
	- changed API for pfm_load_context(): load_pid indicated CPU to monitor in system-wide
	- Kconfig perfmon2 options turned off by default
	- Intel architectural PMU supported in 32 and 64bit mode
	- many other changes and cleanups

I have also released a new libpfm, libpfm-3.2-060926, with lots of
changes. Here are some of the most important ones:

	- added support for Intel Core Duo/Core Solo
	- added support for MIPS 20KC, 24K, 25KF, 34K, 5KC, 74K, R10000, R12000, RM7000, RM9000, SB1/SB1A, VR5432, VR5500 (Phil Mucci)
	- merged 32-bit and 64-bit PEBS support (mtach 2.6.18 kernel)
	- rewritten most CPU detection routines to /proc/cpuinfo instead of cpuid instruction
	- updated i386_p6 event table to expose unit masks
	- added a few i386_p6 events to exploit unit masks mechansim
	- modified pfm_load_context() load_pid to match 2.6.18 kernel expectation
	- removed EXCL_IDLE (flag is gone from 2.6.18 interface)
	- move all destination directories variable setup to config.mk (Phil Mucci)
	- split destination directories between lib, inc, and man (Phil Mucci)
	- added pfm_get_full_event_name() to build event+unit mask string. pfm_get_event_name() is deprecated
	- added pfm_find_full_event() to return event+unit masks descriptors. pfm_find_event() is deprecated
	- pfm_dispatch_events() returns list of PMC AND list of PMD registers used
	- pfm_dispatch_events() returns perfmon2 logical PMC/PMD indexes AND hardware address/index
	- fixed ESCR/CCCR mapping issues in Pentium 4 support
	- changed interface for pfm_get_cycle_event() and pfm_get_inst_retired_event() to use pfmlib_event_t
	- added support for MESI as unit masks for Montecito cache events
	- added PFMLIB_I386_PM_PMU to separate P6 from Pentium M as they use different event tables
	- Intel architectural perfmon (GEN_IA32) compiles in x86-64 mode
	- modified noploop() to avoid being optimized away by compiler (e.g., gcc-4.1)
	- updated man pages
	- rewritten showreginfo.c to match new /sysfs layout for register mappings
	- updated all examples to use pfm_get_full_event_name() and pfm_find_full_event()

With those changes, all common exampes now work for Pentium 4 (HT restrictions may caused
certain examples to fail, though). This version of the library works only when 2.6.18.

Also a new version of pfmon, pfmon-3.2-060926, to take advantage of the
update in libpfm:
	- added Intel Core Duo/Core Solo support
	- imporved Pentium 4 support due to libpfm changes
	- replaced sysconf(_SC_CLK_TCK) with clock_getres() to report correct clock tick
	- removed exclude idle support (gone from 2.6.18 kernel)
	- updated to use the new interface for pfm_get_cycle_event()
	- uses new pfm_get_full_event_name(), pfm_find_full_event() interfaces
	- changed pfmon_system.c to gracefully deal with hotplug CPU support
	- print maximum number of counters per set with -I option
	- fixed bugs with --inv and --edge (pfmlib_gen_ia32.c) option whereby this option would not be
	- added PREFIX, BINDIR, MANDIR, DATADIR to Makefil (Phil Mucci)

This version requires libpfm-3.2-060926.

You can get a more detailed log of changes the the CVS tree.

You can grab the new packages at our web site:

	 http://perfmon2.sf.net

Enjoy,

PS: I will post a kernel patch to LKML and a diffstat on the perfmon mailing list.
-- 
-Stephane
