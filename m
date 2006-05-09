Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWEIIsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWEIIsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWEIIsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:48:35 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47235 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751478AbWEIIsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:35 -0400
Message-Id: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 01:49:45 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: [RFC PATCH 00/35] Xen i386 paravirtualization support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike full virtualization in which the virtual machine provides 
the same platform interface as running natively on the hardware,
paravirtualization requires modification to the guest operating system
to work with the platform interface provided by the hypervisor.

Xen was designed with performance in mind.  Calls to the hypervisor
are minimized, batched if necessary, and non-critical codepaths are left
unmodified in the case where the privileged instruction can be trapped and
emulated by the hypervisor.  The Xen API is designed to be OS agnostic and
has had Linux, NetBSD, FreeBSD, Solaris, Plan9 and Netware ported to it.
Xen also provides support for running directly on native hardware.

The following patch series provides the minimal support required to
launch Xen paravirtual guests on standard x86 hardware running the Xen
hypervisor.  These patches effectively port the Linux kernel to run on the
platform interface provided by Xen.  This port is done as an i386 subarch.
In the future, we will break this patchset up to place the general
infrastrcture and subarch bits that may have common users at the
beginning of the series, ripe for picking off and pushing upstream.

With these patches you will be able to launch an unprivileged guest
running the modified Linux kernel and unmodified userspace.  This guest
is x86, UP only, runs in shadow translated mode, and has no direct access
to hardware.  This simplifies the patchset to the minimum functionality
needed to support a paravirtualized guest.  It's worth noting that
a fair amount of this patchset deals with paravirtualizing I/O, not
just CPU-only.  The additional missing functionality is primarily about
full SMP support, optimizations such as direct writable page tables,
and the management interface.

At a high-level, the patches provide the following:

- Kconfig and Makefile changes required to support Xen
- subarch changes to allow more platform functionality to be
  implemented by an i386 subarch
- Xen subarch implementation
- start of day code for running in the hypervisor provided environment (paging
  enabled)
- basic Xen drivers to provide a fully functional guest

The Xen platform API encapsulates the following types of requirements:

- idt, gdt, ldt (descriptor table handling)
- cr2, fpu_taskswitch, debug registers (privileged register handling)
- mmu (page table, tlb, and cache handling)
- memory reservations
- time and timer
- vcpu (init, up/down vcpu)
- schedule (processor yield, shutdown, etc)
- event channel (generalized virtual interrupt handling)
- grant table (shared memory interface for high speed interdomain communication)
- block device I/O
- network device I/O
- console device I/O
- Xen feature map
- Xen version info

Thanks to all have reviewed earlier versions of these patches.
-chris
--
