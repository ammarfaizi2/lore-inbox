Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265714AbRF1NNn>; Thu, 28 Jun 2001 09:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265716AbRF1NNe>; Thu, 28 Jun 2001 09:13:34 -0400
Received: from t2.redhat.com ([199.183.24.243]:45296 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265714AbRF1NNa>; Thu, 28 Jun 2001 09:13:30 -0400
To: linux-kernel@vger.kernel.org
Cc: dwmw2@redhat.com, arjanv@redhat.com, alan@redhat.com
Subject: [RFC] I/O Access Abstractions
Date: Thu, 28 Jun 2001 14:13:24 +0100
Message-ID: <30906.993734004@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In conjunction with David Woodhouse (dwmw2@redhat.com) and Arjan Van De Ven
(arjan@redhat.com), I've come up with a way to abstract I/O accesses in the
Linux kernel whilst trying to keep overheads minimal. These would be
particularly useful on many non-i386 platforms.

Any comments would be greatly appreciated.

The example code I've written can be downloaded from:

	ftp://infradead.org/pub/people/dwh/ioaccess.tar.bz2

Cheers,
David Howells
dhowells@redhat.com
_______________________________________________________________________________

			   I/O ACCESS ABSTRACTIONS
			   =======================

PURPOSES
========

 * Makes all peripheral input and output accesses look the same.

   - I/O ports
   - Memory-mapped I/O registers
   - PCI Configuration space
   - Device Specific registers

 * Can hide all the strange hoops that some architectures have to jump through
   to provide certain bus access services. For example:

   (1) The SH arch has no I/O port space in the same way that the i386 bus
       does. It instead maps a window in the physical memory space to PCI IO
       port accesses.

   (2) The AM33 arch also has no I/O port space, and likewise maps a window in
       memory space to PCI IO port addresses. Furthermore, the PCI _memory_
       space doesn't correspond on 1:1 basis with the CPU's memory space. At
       any one time, a 64Mb window is mapped from a fixed location in the CPU
       memory space into a mobile location on the PCI memory space. This can
       be moved by means of a control register on the host bridge.

 * Can hide the exact details of the layout of a devices register space as it
   varies from arch to arch. For instance, on the PC, a the 16550 compatible
   serial ports have 8 1-byte registers adjacent to each other in the I/O port
   space, whereas another arch may have the same 8 1-byte registers but at
   intervals of 4-bytes in memory space.

 * The operations by which a device can be accessed can be bound at runtime
   rather than at compile time without the need for conditional branches (this
   should simplify serial.c immensely).

 * Permit "iotrace" on specific resources by operation table substitution.

 * Provide a method of device emulation.

 * Potentially permit transparent byte swapping.


DISADVANTAGES
=============

 * Indirection. It will incur an overhead of a few extra cycles on the i386
   (for the call and return). This can be minimised by carefully crafting bits
   of inline assembly and carefully choosing what registers are used to pass
   what values. This may also be offset under certain circumstances by the
   removal of conditional branches (for example in serial.c).

   Also on an i386, the actual I/O instruction itself is going to take a
   comparatively long time anyway, given the speed differential between CPU
   and external buses.

   On other archs where the indirection exists anyway, there shouldn't be any
   overhead


IMPLEMENTATION
==============

 * The resource structure gains a pointer to a table of operations.

 * The table of resource operations includes 3 single-input functions, 3
   single-output functions, 3 string-input functions and 3 string-output
   functions. Each set of functions includes variation for byte, word and
   dword granularity.

 * Inline functions are provided on a per-arch basis that take a resource
   structure amongst their arguments, dereference it to pull out the
   appropriate function address, set up the registers and then call that
   function. For example:

	struct resource *csr;
	__u32 x = inputw(csr,0x10);
	outputw(cst,0x10,x|0x0020);

 * Macros are provided for generating and using calling convention translation
   stubs for making it possible to write operation functions in C (which if
   necessary will be assembly functions):

	__u16 __iocall pcnet32_inputw(struct resource *p, unsigned offset);
	__DECLARE_INPUT_CALLBACK(w,pcnet32_inputw);
	struct resource_ops pcnet32_ops = {
		__USE_INPUT_CALLBACK(b,pcnet32_inputb),
		__USE_INPUT_CALLBACK(w,pcnet32_inputw),
		__USE_INPUT_CALLBACK(l,pcnet32_inputl),
	};

   Note that on most archs (where there are enough registers) these macros
   will do nothing but plug the user-supplied function straight in.

 * There are three ops tables supplied for the i386:

   - I/O port accesses				[ioaccess-io.S]
   - memory-mapped I/O accesses			[ioaccess-mem.S]
   - PCI type 1 config space accesses		[ioaccess-pciconf1.S]

   Note that the PCI access example does not have the complete set of
   functions at the moment.


EXTENSIONS
==========

 * Driver-specific operations can be provided (for example CSR register access
   functions in the AMD PCnet32 driver).


ISSUES
======

Having discussed this with others the following points have been raised:

 * Some i386 support routines have been written in assembly and optimised to
   have the smallest latency possible. However:

   * These use a non-standard calling convention to call out to the backend
     functions - basically all the values to be passed are put in appropriate
     registers (including ESI/EDI), and some of these registers are clobbered
     or preserved in non-standard ways.

   * As a consequence, generic driver-supplied C functions require a small
     wrapper/thunk/stub to convert the calling convention back into the C one.

   * On an arch that passes sufficient arguments in registers with no
     particular purposes assigned to those registers, no stub will be
     required.

 * Opinion is divided as to whether an optimised assembly should be included
   in the first attempt. It may be better to use just standard C function
   pointers straight off.

 * If optimised assembly is used, it may be worth not immediately providing
   the ability to generate stubs for user-defined operations.

 * It may be worth adding mass register <-> memory transfer instructions
   (equivalent to memcpy).

 * It may be worth providing inline function or macros that, depending on the
   value of a global configuration setting, compile-time switch between doing,
   for example, inb and inputb or, say, between readb and inputb.
