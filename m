Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWCMSEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWCMSEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWCMSEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:04:24 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:6156 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751380AbWCMSED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:04:03 -0500
Date: Mon, 13 Mar 2006 10:02:49 -0800
Message-Id: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
Subject: [RFC, PATCH 5/24] i386 Vmi code patching
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:02:49.0779 (UTC) FILETIME=[573F0830:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VMI ROM detection and code patching mechanism is illustrated in
setup.c.  There ROM is a binary block published by the hypervisor, and
and there are certainly implications of this.  ROMs certainly have a
history of being proprietary, very differently licensed pieces of
software, and mostly under non-free licenses.  Before jumping to the
conclusion that this is a bad thing, let us consider more carefully
why hiding the interface layer to the hypervisor is actually a good
thing.

The fact that this code is in a ROM is a design choice we made based on
the ease of the delivery vehicle for our implementation, but there is
nothing fundamentally different between this and a hyper-support (or
vsyscall) page based approach.  They are both merely mechanisms to
inject hypervisor code into the guest that allows transparent
virtualization of the native architecture, with design costs chosen by
the hypervisor.  In many cases, the calls into this support layer need
not have a one to one mapping to the vendor defined hypercall interface;
in fact, it is beneficial if they do not.  Many of the calls can be
optimized into local function calls which do not require an expensive
privilege transition into the hypervisor.  Many of the calls are
obsolete when running under a VT/Pacifica based hypervisor.  This is by
design, and in cases when more virtualization capabilities are available
in hardware, they can be taken advantage of instantly by simply doing
nothing - there is no need to patch the guest code for classes of
instructions which are efficiently and properly supported.  But the fact
remains that for in-use hardware today, these encapsulations are
necessary, and in fact some will continue to allow for more efficient
optimizations even with hardware virtualization.

Currently, the system is designed to boot under a fully virtualized
(or native) environment, then switch into paravirtual mode.  It does
this by detecting the presence of a ROM code page, invoking the
hypervisor initialization function, followed by switching the code
annotations to the versions which call the VMI ROM code.  There are
some remnant stub implementations here from when the original approach
was to make native functional equivalents for each of the ROM calls.
This approach was unwieldy, and had a significant performance impact
on critical paths in the system, so the stubs are being deprecated in
favor of native inline code that allows for more native optimization
potential.

Currently, the kernel does all the fancy code patching, but this
step will eventually be done inside of the initialization routine
of the hypervisor.  Not only does this free the guest from this
tedious responsibility (note the tricky code which disassembles the
VMI call regions), but it allows the hypervisor to make further choices
about inlining the code, eliminating the call/return overhead altogether.
This overhead is non-trivial in the native case, which is why the
native code must be preferentially inlined for a kernel which gets
measurably near-identical native performance in microbenchmarks.

The fact that the ROM hides this interface code is deliberate, and is
intended to allow the hypervisor vendor flexibility to change the
underlying interface without the kernel needing to change.  If the
raw hypercall interface were presented to the kernel, it could look
quite ugly and inflexible.  It does not allow the system to evolve
over time.  On the other hand, if the layer is hidden, it gives the
benefit of allowing alternative implementations to develop.  Different
versions of the interface can be supported, perhaps tailored with
optimizations for different kernels, or adding statistics gathering
and debugging code into the layer.  The very value of the interface
is not in it being visible, but by making it hidden.

The question of licensing of such ROM code is a completely separate
issue.  We are not trying to hide some proprietary code by putting it
inside of a ROM to keep it hidden.  In fact, you can disassemble the
ROM code and see it quite readily - and you know all of the entry points.
Whether we can distribute our ROM code under a GPL compatible license
is not something I know at this time.  Just as you can't compile a
binary using Linux kernel headers and claim that your binary is not
subject to the GPL, our ROM code includes headers from other parts of
our system that are specifically not under the GPL.  How this affects
the final license under which the ROM is distributed is not something
I think we know at this time.  But there is no reason we can't rewrite
those headers and make the ROM a separate and freely distributable
entity.  Even so, the usefulness of it is extremely limited; the
interface to the hypervisor is proprietary, and subject to change,
so the code merely serves as a sample implementation of one possible
way to interface the layer to a hypervisor.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/Makefile
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/Makefile	2006-03-08 16:53:19.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/Makefile	2006-03-08 16:53:32.000000000 -0800
@@ -78,6 +78,10 @@ mflags-$(CONFIG_X86_ES7000)	:= -Iinclude
 mcore-$(CONFIG_X86_ES7000)	:= mach-default
 core-$(CONFIG_X86_ES7000)	:= arch/i386/mach-es7000/
 
+# VMI subarch support
+mflags-$(CONFIG_X86_VMI)	:= -Iinclude/asm-i386/mach-vmi
+mcore-$(CONFIG_X86_VMI)		:= mach-vmi
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
@@ -95,6 +99,7 @@ drivers-$(CONFIG_OPROFILE)		+= arch/i386
 drivers-$(CONFIG_PM)			+= arch/i386/power/
 
 CFLAGS += $(mflags-y)
+CPPFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/setup.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/setup.c	2006-03-08 16:53:32.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/setup.c	2006-03-08 16:55:59.000000000 -0800
@@ -0,0 +1,309 @@
+/*
+ * Machine specific setup for generic
+ *
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <asm/acpi.h>
+#include <asm/arch_hooks.h>
+#include <asm/processor.h>
+#include <asm/desc.h>
+#include <asm/io.h>
+#include <asm/highmem.h>
+#include <asm/pgtable.h>
+#include <vmi.h>
+
+extern char __VMI_END;
+extern char __VMI_START;
+extern char __VMI_SHARED;
+VROMHeader *vmi_rom = NULL;
+
+VMI_UINT8 hypervisor_found;
+
+/* Convenient macro for calling VMI functions indirectly in the ROM */
+typedef VMI_UINT32 __attribute__((regparm(1))) (VROMFUNC)(void);
+
+#define VROMFunc(table,func) \
+   (((VROMFUNC *)&(((VROMCallTable *)(table))->vromCall[(func)].f)) \
+       ())
+
+#define MNEM_PUSH_I	0x68
+#define MNEM_PUSH_IB	0x6a
+#define MNEM_PUSH_EAX	0x50
+#define MNEM_PUSH_ECX	0x51
+#define MNEM_PUSH_EDX	0x52
+#define MNEM_PUSH_EBX	0x53
+#define MNEM_PUSH_ESP	0x54
+#define MNEM_PUSH_EBP	0x55
+#define MNEM_PUSH_ESI	0x56
+#define MNEM_PUSH_EDI	0x57
+#define MNEM_OPSIZE	0x66
+#define MNEM_LEA	0x8d
+#define MNEM_NOP	0x90
+#define MNEM_CALL_NEAR	0xe8
+
+static inline void patch_call_site(struct vmi_annotation *a, unsigned char *eip)
+{
+	unsigned long call = a->vmi_call;
+	unsigned char *dest = (unsigned char *)(&((VROMCallTable *)vmi_rom)->vromCall[call]);
+	*(unsigned long *)(eip+1) = dest-eip-5;
+}
+
+static void fixup_translation(struct vmi_annotation *a)
+{
+	unsigned char *c, *start, *end;
+	int left;
+
+	memcpy(a->nativeEIP, a->translationEIP, a->translation_size);
+	start = a->nativeEIP;
+	end = a->nativeEIP + a->translation_size;
+
+	for (c = start; c < end;) {
+		switch(*c) {
+			case MNEM_CALL_NEAR:
+				patch_call_site(a, c);
+				c+=5;
+				break;
+
+			case MNEM_PUSH_I:
+				c+=5;
+				break;
+
+			case MNEM_PUSH_IB:
+				c+=2;
+				break;
+
+			case MNEM_PUSH_EAX:
+			case MNEM_PUSH_ECX:
+			case MNEM_PUSH_EDX:
+			case MNEM_PUSH_EBX:
+			case MNEM_PUSH_EBP:
+			case MNEM_PUSH_ESI:
+			case MNEM_PUSH_EDI: 
+				c+=1;
+				break;
+
+			case MNEM_LEA:
+				BUG_ON(*(c+1) != 0x64);  /* [--][--]+disp8, %esp */
+				BUG_ON(*(c+2) != 0x24);  /* none + %esp */
+				c+=4;
+				break;
+
+			default:
+				/*
+				 * Don't printk - it may acquire spinlocks with
+				 * partially completed VMI translations, causing
+				 * nuclear meltdown of the core.
+ 				 */
+				BUG();
+				return;
+		}
+	}
+
+	/* If the native size exceeded the translation size, pad the rest with nops */
+	for (left = a->native_size - a->translation_size; left > 0; left -= 12) {
+		int cur = left - 1;
+		int i;
+		cur = cur > 11 ? 11 : cur;
+		for (i = 0; i < cur; i++)
+			*c++ = MNEM_OPSIZE;
+		*c++ = MNEM_NOP;
+	}
+
+	for (c = start; c < end; c+= 8)
+		asm volatile ("clflush %0" ::"m" (c));
+}
+
+static void scan_annotations(void *start, void *end) 
+{ 
+	struct vmi_annotation *a; 
+	unsigned long nop_size = 0, translation_size = 0, extra_native_bytes = 0;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	for (a = start; (void *)a < end; a++) { 
+		BUG_ON(a->vmi_call >= NUM_VMI_CALLS);
+		translation_size += a->translation_size;
+		if (a->nop_size > 0)
+			nop_size += a->nop_size;
+		else
+			extra_native_bytes -= a->nop_size;
+		fixup_translation(a);
+	}
+	local_irq_restore(flags);
+	printk(KERN_WARNING "VMI %d annotations=%ld, translations=%ld, nops=%ld, extra native = %ld bytes\n",
+		a - (struct vmi_annotation *)start + 1, (unsigned long)(end-start),
+		translation_size, nop_size, extra_native_bytes);
+} 
+
+static void scan_builtin_annotations(void)
+{
+	scan_annotations(__vmi_annotation, __vmi_annotation_end);
+}
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+	setup_irq(2, &irq2);
+}
+
+
+/*
+ * Probe for the VMI option ROM
+ */
+void __init probe_vmi_rom(void)
+{
+	unsigned long base;
+
+        hypervisor_found = 0;
+
+	/* VMI ROM is in option ROM area, check signature */
+	for (base = 0xC0000; base < 0xE0000; base += 2048) {
+		VROMHeader *romstart;
+		romstart = (VROMHeader *)isa_bus_to_virt(base);
+		if (romstart->romSignature != 0xaa55)
+			continue;
+		if (romstart->vRomSignature == VMI_SIGNATURE && !vmi_rom) {
+			printk(KERN_WARNING "Detected VMI ROM version %d.%d\n",
+				romstart->APIVersionMajor,
+				romstart->APIVersionMinor);
+			vmi_rom = romstart;
+			if (romstart->APIVersionMajor != VMI_API_REV_MAJOR ||
+			    romstart->APIVersionMinor+1 < MIN_VMI_API_REV_MINOR+1)
+				continue;
+			if (romstart->romLength * 512 > 
+					&__VMI_END - &__VMI_START)
+				panic("VMI OPROM size exceeds mappable space\n");
+			hypervisor_found = 1;
+			break;
+		}
+	}
+}
+
+
+/*
+ * Activate the VMI interfaces
+ */
+void __init vmi_init(void)
+{
+	int romsize;
+
+	/*
+	 * Setup optional callback functions if we found the VMI ROM
+	 */
+	if (hypervisor_found) {
+		romsize = vmi_rom->romLength * 512;
+		if (VROMFunc(vmi_rom, VMI_CALL_Init)) {
+			printk(KERN_WARNING "VMI ROM failed to initialize\n");
+			hypervisor_found = 0;
+		} else {
+			memcpy(&__VMI_START, (char *)vmi_rom, romsize);
+			scan_builtin_annotations();
+		}
+	}
+	if (!vmi_rom) 
+		printk(KERN_WARNING "VMI ROM not found"
+		       " - falling back to native mode\n");
+	else if (!hypervisor_found)
+		printk(KERN_WARNING "VMI ROM version mismatch "
+		       "(kernel requires version >= %d.%d) "
+		       " - falling back to native mode\n",
+		       VMI_API_REV_MAJOR, MIN_VMI_API_REV_MINOR);
+}
+
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs. 
+ *      We probe for various component option ROMs here.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+	probe_vmi_rom();
+	vmi_init();
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/stubs.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/stubs.c	2006-03-08 16:53:32.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/stubs.c	2006-03-08 16:53:32.000000000 -0800
@@ -0,0 +1,102 @@
+/*
+ * Stub implementation of hardware features for transparent
+ * virtualization.
+ *
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/desc.h>
+#include <asm/bitops.h>
+#include <vmi.h>
+#include <asm/system.h>
+#include <asm/apic.h>
+
+/* Init gets called on APs during SMP boot, so a stub is needed. */
+VMICALL void VMI_Init(VMI_UINT32 data)
+{
+
+}
+
+VMICALL VMI_UINT32 VMI_GetPxE(VMI_UINT32 *pte)
+{
+	return (*pte);
+}
+
+VMICALL void VMI_SetPxE(VMI_UINT32 *pte, VMI_UINT32 pteval)
+{
+	*pte = pteval;
+}
+
+VMICALL VMI_UINT32 VMI_SwapPxE(VMI_UINT32 *pte, VMI_UINT32 pteval)
+{
+	VMI_UINT32 val;
+
+	val = xchg(pte, pteval);
+	return val;
+}
+
+VMICALL int VMI_TestAndClearPxEBit(VMI_UINT32 *pte, int bit)
+{
+	VMI_UINT32 val;
+
+	val = test_and_clear_bit(bit, (volatile unsigned long *)pte);
+	return val;
+}
+
+VMICALL int VMI_TestAndSetPxEBit(VMI_UINT32 *pte, int bit)
+{
+	VMI_UINT32 val;
+
+	val = test_and_set_bit(bit, (volatile unsigned long *)pte);
+	return val;
+}
+
+VMICALL int VMI_TestAndClearPxELongBit(VMI_UINT64 *pte, int bit)
+{
+   return VMI_TestAndClearPxEBit((VMI_UINT32 *)pte, bit);
+}
+
+VMICALL int VMI_TestAndSetPxELongBit(VMI_UINT64 *pte, int bit)
+{
+   return VMI_TestAndSetPxEBit((VMI_UINT32 *)pte, bit);
+}
+
+VMICALL void VMI_AllocatePage(VMI_UINT32 ppn, int flags, VMI_UINT32 orig, int base,
+                              int count)
+{
+}
+
+VMICALL void VMI_ReleasePage(VMI_UINT32 ppn, int flags)
+{
+}
+
+VMICALL int VMI_FlushDeferredCalls(VMI_UINT32 mode)
+{
+	return 0;
+}
+
+VMICALL void VMI_SetInitialAPState(VMI_UINT32 apState, VMI_UINT32 apicId)
+{
+}
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/stubs-asm.S
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/stubs-asm.S	2006-03-08 16:53:32.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/stubs-asm.S	2006-03-08 16:53:32.000000000 -0800
@@ -0,0 +1,34 @@
+#include <linux/linkage.h>
+
+.section .text.VMI_SetPxELong,"ax"
+ENTRY(VMI_SetPxELong)
+	mov %edx, 4(%ecx)
+	/* sfence */
+	mov %eax, (%ecx)
+	ret
+
+.section .text.VMI_DeactivatePxELongAtomic,"ax"
+ENTRY(VMI_DeactivatePxELongAtomic)
+	push %ecx
+	mov  %eax, %ecx
+	xor  %eax, %eax
+	xchg %eax, (%ecx)
+	mov  4(%ecx), %edx
+	movl $0, 4(%ecx)
+	pop  %ecx
+	ret
+
+.section .text.VMI_SwapPxELongAtomic,"ax"
+ENTRY(VMI_SwapPxELongAtomic)
+	push %edi
+	mov  %ecx, %edi
+	push %ebx
+	mov  %eax, %ebx
+	mov  %edx, %ecx
+	mov  (%edi), %eax
+	mov  4(%edi), %edx
+1:	lock; cmpxchg8b (%edi)
+	jne  1b
+	pop  %ebx
+	pop  %edi
+	ret
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/Makefile
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/Makefile	2006-03-08 16:53:32.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/Makefile	2006-03-08 16:55:46.000000000 -0800
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+export CFLAGS_stubs.o += -ffunction-sections
+
+obj-y				:= setup.o stubs.o stubs-asm.o
Index: linux-2.6.16-rc5/include/asm-i386/bugs.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/bugs.h	2006-03-08 16:53:19.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/bugs.h	2006-03-08 16:53:32.000000000 -0800
@@ -175,6 +175,11 @@ static void __init check_config(void)
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
 		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
 #endif
+
+#ifdef CONFIG_VMI_REQUIRE_HYPERVISOR
+        if (!vmi_hypervisor_found()) 
+                panic("No hypervisor found, aborting!\n");
+#endif
 }
 
 extern void alternative_instructions(void);
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/setup_arch_pre.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/setup_arch_pre.h	2006-03-08 16:53:32.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/setup_arch_pre.h	2006-03-08 16:53:32.000000000 -0800
@@ -0,0 +1,6 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for generic */
+
+#define ARCH_SETUP
+extern void vmi_init(void);
