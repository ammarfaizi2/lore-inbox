Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161698AbWKEU1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161698AbWKEU1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161705AbWKEU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:27:53 -0500
Received: from mis011-2.exch011.intermedia.net ([64.78.21.129]:63568 "EHLO
	mis011-2.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161698AbWKEU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:27:52 -0500
Message-ID: <454E4941.7000108@qumranet.com>
Date: Sun, 05 Nov 2006 22:27:45 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2006 20:27:51.0688 (UTC) FILETIME=[DDE3B880:01C70118]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:

- detect msrs on host dynamically.  Avoids oopses on non-ia32e
  capable processors.
- web site: http://kvm.sourceforge.net
- slightly rediffed

Changes since v2:

- mailing list: kvm-devel@lists.sourceforge.net
  (http://lists.sourceforge.net/lists/listinfo/kvm-devel)
- applied code review comments
- fixed set_sregs() ioctl corrupting guest state if cr0.pe changed
  (a polite way of saying that loading a saved vm was broken)

---

The following patchset adds a driver for Intel's hardware
virtualization extensions to the x86 architecture.  The driver adds
a character device (/dev/kvm) that exposes the virtualization
capabilities to userspace.  Using this driver, a process can run a
virtual machine (a "guest") in a fully virtualized PC containing its
own virtual hard disks, network adapters, and display.

Using this driver, one can start multiple virtual machines on a host.
Each virtual machine is a process on the host; a virtual cpu is a thread
in that process.  kill(1), nice(1), top(1) work as expected.
   
In effect, the driver adds a third execution mode to the existing two:
we now have kernel mode, user mode, and guest mode.  Guest mode has its
own address space mapping guest physical memory (which is accessible to
user mode by mmap()ing /dev/kvm).  Guest mode has no access to any I/O
devices; any such access is intercepted and directed to user mode for
emulation.

The driver supports i386 and x86_64 hosts and guests.  All combinations
are allowed except x86_64 guest on i386 host.  For i386 guests and
hosts, both pae and non-pae paging modes are supported.

SMP hosts and UP guests are supported.  At the moment only Intel
hardware is supported, but AMD virtualization support is being worked on.

Performance currently is non-stellar due to the naive implementation
of the mmu virtualization, which throws away most of the shadow page
table entries every context switch.  We plan to address this in two ways:

- cache shadow page tables across tlv flushes
- wait until AMD and Intel release processors with nested page tables

Currently a virtual desktop is responsive but consumes a lot of CPU.
Under Windows I tried playing pinball and watching a few flash movies;
with a recent CPU one can hardly feel the virtualization.  Linux/X is
slower, probably due to X being in a separate process.

In addition to the driver, you need a slightly modified qemu to provide
I/O device emulation and the BIOS.

Caveats:

- The Windows install currently bluescreens due to a problem with the
  virtual APIC.  We are working on a fix.  A temporary workaround is to
  use an existing image or install through qemu
- Windows 64-bit does not work.  That's also true for qemu, so it's
  probably a problem with the device model.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

