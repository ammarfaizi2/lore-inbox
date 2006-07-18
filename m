Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWGRJUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWGRJUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWGRJUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:20:52 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:11650 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932119AbWGRJUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:45 -0400
Message-Id: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 02:18:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>
Subject: [RFC PATCH 00/33] Xen i386 paravirtualization support
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
