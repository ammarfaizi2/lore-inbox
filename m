Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWJWN3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWJWN3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWJWN3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:29:06 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:63376 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S964844AbWJWN3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:29:04 -0400
Message-ID: <453CC390.9080508@qumranet.com>
Date: Mon, 23 Oct 2006 15:28:48 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] KVM: Kernel-based Virtual Machine (v2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 13:28:53.0683 (UTC) FILETIME=[2F19D030:01C6F6A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:

- fixed a lockup on i386 with host memory >= 4GB
- finer patch split to conform to vger limits
- minor fixes
- send through script to avoid mailer damage

TODO:

- drivers/ or arch/ ?
- filesystem + syscalls or ioctl() ?

I'll also reply to this mail with a sample userspace so people can see 
how it works.

---

The following patchset adds a driver for Intel's hardware virtualization
extensions to the x86 architecture.  The driver adds a character device
(/dev/kvm) that exposes the virtualization capabilities to userspace.  Using
this driver, a process can run a virtual machine (a "guest") in a fully
virtualized PC containing its own virtual hard disks, network adapters, and
display.

Using this driver, one can start multiple virtual machines on a host.  Each
virtual machine is a process on the host; a virtual cpu is a thread in that
process.  kill(1), nice(1), top(1) work as expected.
   
In effect, the driver adds a third execution mode to the existing two: 
we now
have kernel mode, user mode, and guest mode.  Guest mode has its own address
space mapping guest physical memory (which is accessible to user mode by
mmap()ing /dev/kvm).  Guest mode has no access to any I/O devices; any such
access is intercepted and directed to user mode for emulation.

The driver supports i386 and x86_64 hosts and guests.  All combinations are
allowed except x86_64 guest on i386 host.  For i386 guests and hosts, both
pae and non-pae paging modes are supported.

SMP hosts and UP guests are supported.  At the moment only Intel hardware is
supported, but AMD virtualization support is being worked on.

Performance currently is non-stellar due to the naive implementation of the
mmu virtualization, which throws away most of the shadow page table entries
every context switch.  We plan to address this in two ways:

- cache shadow page tables across tlv flushes
- wait until AMD and Intel release processors with nested page tables

Currently a virtual desktop is responsive but consumes a lot of CPU.  Under
Windows I tried playing pinball and watching a few flash movies; with a 
recent
CPU one can hardly feel the virtualization.  Linux/X is slower, probably due
to X being in a separate process.

In addition to the driver, you need a slightly modified qemu to provide I/O
device emulation and the BIOS.

Caveats:

- The Windows install currently bluescreens due to a problem with the 
virtual
  APIC.  We are working on a fix.  A temporary workaround is to use an 
existing
  image or install through qemu
- Windows 64-bit does not work.  That's also true for qemu, so it's probably
  a problem with the device model.

-- 
error compiling committee.c: too many arguments to function

