Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265473AbSJXOxn>; Thu, 24 Oct 2002 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265474AbSJXOxn>; Thu, 24 Oct 2002 10:53:43 -0400
Received: from kim.it.uu.se ([130.238.12.178]:5826 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265473AbSJXOxl>;
	Thu, 24 Oct 2002 10:53:41 -0400
Date: Thu, 24 Oct 2002 16:59:49 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210241459.QAA03571@kim.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: overview [0/4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is perfctr-3.0-pre2 for 2.5.44. This is the 2.5-ready version
of the Linux/x86 performance-monitoring counters kernel extension.
Please consider it for inclusion in 2.5/2.6.

This is part 0 of 4: overview.

This adds support for user-space use of the x86 performance counters.
Major features include:
- CPU support for P5, P6, P4, K7, Centaur, VIA, and Cyrix.
- Overflow interrupts routed back as signals to user-space.
- Per-process virtualised performance counters. This is what makes it
  actually useful for user-space :-)
- Performance counter handles are file descriptors. Allows mmap()ing
  the counter sums for low-overhead sampling. Also used for a simple
  remote-control interface, which allows a monitor process to control
  the counters of another process, with ptrace-like access rules.
- Access via a new sys_perfctr() system call.
- Internal organisation as an architecture-specific low-level driver
  and one or more architecture-neutral higher-level drivers. It could
  easily support several other architectures.

Impact on the kernel:
- The x86 thread_struct is extended with a pointer to that process'
  performance counter state. The state is large so it's allocated lazily.
  (The state also needs to be a separate object for other reasons.)
- Callbacks in fork(), exec(), exit(), switch_to(), and update_one_process()
  to maintain the per-process counters. These callbacks do nothing if the
  process has no counters. Disabling CONFIG_PERFCTR_VIRTUAL eliminates
  the callback code altogether.
- Adds one system call.
- Adds an interrupt handler for the local APIC LVTPC vector.
- No #ifdefs added to the kernel's C source files.

Known limitations:
- Hyperthreaded P4s will require that processes using the counters have
  CPU affinity masks restricting them to even-numbered logical CPUs.
  I will take care of this once the basic code is in the kernel.
- The code is not preempt-safe. This is fixable.
- The NMI watchdog, oprofile, and perfctr all want to own the local APIC
  LVTPC vector and the CPU performance counter registers. I will implement
  a manager to ensure that only one driver at a time uses these resources.

Known design issues:
- The code exists mostly under drivers/perfctr/, partly because the
  driver can support other archs easily, and partly because I hate not
  having related code in one place.
- The system-call interface is NOT architecture neutral. There are lots
  of reasons for this:
  * Abstracting away HW details and inventing a "high-level" API is hard
    work and would bloat the kernel. User-space libraries can take care
    of the conversions when needed. (And current libraries do just that.)
  * For low-overhead sampling to work user-space needs to understand the
    HW state layout anyway.
  * Different CPUs have different capabilities. You can't count FLOPS on
    a K7 for instance. Again, user-space needs to know CPU-specific details.

Versions up to perfctr-2.0 were announced regularly on LKML. Since then,
discussions have been done mostly on the perfctr-devel list and directly
with users and user-space tool developers. (A contributing factor to this
was that VGER refused to distribute my perfctr-2.0 announcement post.) The
main differences between the external perfctr-2.x package and perctr-3.x are:

- Dropped unnecessary stuff like support for 2.2 kernels and modular builds.
- Changed from ioctl()s on special files to proper system call interface.
- Removed the global-mode performance counter driver, since the SMP CPU
  numbering changes in 2.5 utterly broke its API.

The perfctr-3.x patch files can also be obtained from
http://www.csd.uu.se/~mikpe/linux/perfctr/3.x/patchkit/.

/Mikael
