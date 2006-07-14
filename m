Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWGNHAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWGNHAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWGNHAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:00:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161033AbWGNHAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:00:38 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: x86_64 kernel stack organization
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Jul 2006 17:00:23 +1000
Message-ID: <16644.1152860423@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could not find a document that described the x86_64 kernel stack
organization so I wrote this one.  Sending to lkml for a sanity check
before doing a patch against linux/Documentation, plus trying to get
answers to some questions.

x86_64 page size (PAGE_SIZE) is 4K.

Like all other architectures, x86_64 has a kernel stack for every
active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
These stacks contain useful data as long as a thread is alive or a
zombie, no matter whether the thread is in user space or in the kernel.

In addition to the per thread stacks, there are specialized stacks
associated with each cpu.  These stacks are only used while the kernel
is in control on that cpu, when a cpu returns to user space the
specialized stacks contain no useful data.  The main cpu stacks is

* Interrupt stack.  IRQSTACKSIZE (4*PAGE_SIZE).

  Used for external hardware interrupts.  If this is the first external
  hardware interrupt (i.e. not a nested hardware interrupt) then the
  kernel switches from the current task to the interrupt stack.  Like
  the split thread and interrupt stacks on i386 (with CONFIG_4KSTACKS),
  this gives more room for kernel interrupt processing without having
  to increase the size of every per thread stack.

  The interrupt stack is also used when processing a softirq.  Unlike
  the hardware interrupt code which allows nested interrupts, softirq
  processing unconditionally switches to using the interrupt stack.
  Soft irqs cannot be nested.

Switching to the kernel interrupt stack is done by software, allowing
the kernel to decide when to switch.  x86_64 also has a feature which
is not available on i386, the ability to automatically switch to a new
stack for designated events such as double fault or NMI, which makes it
easier to handle these unusual events on x86_64.  This feature is
called the Interrupt Stack Table (IST).  There can be up to 7 IST
entries per cpu.  The IST code is an index into the Task State Segment
(TSS), the IST entries in the TSS point to dedicated stacks, each stack
can be a different size.

An IST is selected by an non-zero value in the IST field of an
interrupt-gate descriptor.  When an interrupt occurs and the hardware
loads such a descriptor, the hardware automatically sets the new stack
pointer based on the IST value, then invokes the interrupt handler.  If
software wants to allow nested IST interrupts then the handler must
adjust the IST values on entry to and exit from the interrupt handler.

Events with different IST codes (i.e. with different stacks) can be
nested.  For example, a debug interrupt can safely be interrupted by an
NMI.  arch/x86_64/kernel/entry.S::paranoidentry adjusts the stack
pointers on entry to and exit from all IST events, in theory allowing
IST events with the same code to be nested.  However in most cases, the
stack size allocated to an IST assumes no nesting for the same code.
If that assumption is ever broken then the stacks will become corrupt.

The currently assigned IST stacks are :-

* STACKFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).

  Used for interrupt 12 - Stack Fault Exception (#SS).

  Question: Why use an IST for this event instead of the normal
  hardware interrupt stack?  Is this an attempt to detect kernel stack
  overflow?  AFAICT it is ineffective, x86_64 does not check segment
  limits in 64bit mode.

* DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).

  Used for interrupt 8 - Double Fault Exception (#DF).

  The hardware called the kernel to handle a fault (either user space
  or kernel), while doing so the kernel generated another fault.  Using
  an IST removes the previous kernel stack from being a contributing
  factor when reporting the double fault.

* NMI_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).

  Used for non-maskable interrupts (NMI).

  NMI can be delivered at any time, including when the kernel is in the
  middle of switching stacks.  Using IST for NMI events avoids making
  assumptions about the previous state of the kernel stack.

* DEBUG_STACK.  DEBUG_STKSZ (Same as EXCEPTION_STKSZ, PAGE_SIZE).

  Used for hardware debug interrupts (interrupt 1) and for software
  debug interrupts (INT3).

  When debugging a kernel, debug interrupts (both hardware and
  software) can occur at any time.  Using IST for these interrupts
  avoids making assumptions about the previous state of the kernel
  stack.

  Question: The kernel code allows for DEBUG_STKSZ to be different from
  EXCEPTION_STKSZ, but currently they are the same value.  This
  prevents debug interrupts from being nested.  Hardware debug events
  cannot be nested, but software debug interrupts have the potential to
  be nested.  Macro paranoid adjusts the TSS entry by EXCEPTION_STKSZ
  which only allows one level of debug interrupt.  Is this intentional?
  I note that http://lkml.org/lkml/2006/5/10/22 tries to address this.

* MCE_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).

  Used for interrupt 18 - Machine Check Exception (#MC).

  MCE can be delivered at any time, including when the kernel is in the
  middle of switching stacks.  Using IST for MCE events avoids making
  assumptions about the previous state of the kernel stack.

