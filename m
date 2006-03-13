Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWCMSnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWCMSnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCMSmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:42:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17413 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751578AbWCMSl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:41:56 -0500
Date: Mon, 13 Mar 2006 10:41:54 -0800
Message-Id: <200603131841.k2DIfsoF005889@zach-dev.vmware.com>
Subject: [RFC, PATCH 4/24] i386 Vmi inline implementation
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
X-OriginalArrivalTime: 13 Mar 2006 18:41:55.0125 (UTC) FILETIME=[CD2E6E50:01C646CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macros to use VMI calls from assembly and C languages are introduced.
The macros are quite complex, but the end result is rather impressive.
The result is that when compiling a VMI kernel, the native code is
emitted inline, with no function call overhead, and some wiggle room
for register allocation.  The hypervisor compatibility code is emitted
out of line into a separate section, and patched dynamically during the
process of preparing the kernel for boot.  In the end, this task is
envisioned as being done by a loader agent outside of the kernel proper,
allowing for a completely transparent kernel start of day.

Please forgive some of the historical and clearly in-transition 
definitions in vmi.h; in particular, the MMU VMI calls have not
yet been adapted to the inline interface, and the naming convention
has not yet been Linux-ified.  Also, there are artifacts remaining
here from the compile time ability to choose a register convention.
There are also some bugs with non-regparm compilation.

The set of calls in the VMI interface here needs some minor adjustments
for Xen compatibility.  In particular, a method to convert machine to
physical mappings in PTEs is one missing interface, and with that and
some other rather small changes, a VMI kernel is perfectly capable of
running in a Xen hypervisor.

Many thanks to Joshua LeVasseur at the University of Karlsruhe, and
Volkmar Uhlig, now at IBM, who verified this claim on a slightly
different form of the interface.  We are actively working on assembling
all of those bits together right now to work on the Xen 3.0 interface.
The end result is that the exact same kernel binary can run on native
hardware as well as multiple hypervisors with near zero overhead, and
absolutely minimal impact of the hypervisor based idioms on the native
code base.

Note that hypervisor specific drivers need not ever be a part of the
core interface, as drivers are already very well encapsulated by
kernel modules, and are free to use any interface they wish to talk
to the hardware (in this case, the hypervisor).  Imposing an interface
such as this on the driver is somewhat non-productive, and needlessly
complicates both the driver and the core interface.  There is a little
bit of blending room for devices like timers, interrupt controllers,
and other components that are closely coupled with the CPU, but with
good modularization in the kernel, these devices can largely be
factored out as well.

Forgive the strangeness introduced by compile time options for
controlling the calling convention; currently, non-REGPARM builds
are actually broken.  I plan on fixing this so that smart inliners
can take advantage of known constants; these constants are
available in the decoded call stream as push immediate instructions,
but they are not generated for the first three arguments if the
regparm calling convention is used, since the register allocation
causes that data to go out of our scope.  The exact call ABI is
still up for debate, so this is supposed to allow some tinkering
for CPI and code overhead measurement.  Eventually, one ABI will
be chosen, and the macros can get a bit simpler.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_asm.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_asm.h	2006-03-08 10:52:43.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_asm.h	2006-03-08 10:52:43.000000000 -0800
@@ -0,0 +1,191 @@
+#ifndef __MACH_ASM_H
+#define __MACH_ASM_H
+
+/*
+ * Take care to ensure that these labels do not overlap any in parent scope,
+ * as the breakage can be difficult to detect.  I haven't found a flawless
+ * way to avoid collision because local \@ can not be saved for a future
+ * macro definitions, and we are stuck running cpp -traditional on entry.S 
+ *
+ * To work around gas bugs, we must emit the native sequence here into a
+ * separate section first to measure the length.  Some versions of gas have
+ * difficulty resolving vmi_native_end - vmi_native_begin during evaluation
+ * of an assembler conditional, which we use during the .rept directive
+ * below to generate the nop padding -- Zach
+ */
+
+/* First, measure the native instruction sequence length */
+#define vmi_native_start			\
+	.pushsection .vmi.native,"ax";		\
+	771:;
+#define vmi_native_finish			\
+	772:;					\
+	.popsection;
+#define vmi_native_begin	771b
+#define vmi_native_end		772b
+#define vmi_native_len		(vmi_native_end - vmi_native_begin)
+
+/* Now, measure and emit the vmi translation sequence */
+#define vmi_translation_start			\
+	.pushsection .vmi.translation,"ax";	\
+	781:;
+#define vmi_translation_finish			\
+	782:;					\
+	.popsection;
+#define vmi_translation_begin	781b
+#define vmi_translation_end	782b
+#define vmi_translation_len	(vmi_translation_end - vmi_translation_begin)
+
+/* Finally, emit the padded native sequence */
+#define vmi_padded_start				\
+	791:;
+#define vmi_padded_finish				\
+	792:;
+#define vmi_padded_begin	791b
+#define vmi_padded_end		792b
+#define vmi_padded_len		(vmi_padded_end - vmi_padded_begin)
+
+#define vmi_call(name)						\
+	call .+5+name
+
+/*
+ * Pad out the current native instruction sequence with a series of nops;
+ * the nop used is 0x66* 0x90 which is data16 nop or xchg %ax, %ax.  We
+ * pad out with up to 11 bytes of prefix at a time because beyond that
+ * both AMD and Intel processors start to show inefficiencies.
+ */
+#define vmi_nop_pad						\
+.equ vmi_pad_total, vmi_translation_len - vmi_native_len;	\
+.equ vmi_pad, vmi_pad_total;					\
+.rept (vmi_pad+11)/12;						\
+	.if vmi_pad > 12;					\
+		.equ vmi_cur_pad, 12;				\
+	.else;							\
+		.equ vmi_cur_pad, vmi_pad;			\
+	.endif;							\
+	.if vmi_cur_pad > 1;					\
+		.fill vmi_cur_pad-1, 1, 0x66;			\
+	.endif;							\
+	.byte 0x90;						\
+	.equ vmi_pad, vmi_pad - vmi_cur_pad;			\
+.endr;
+
+/*
+ * Create an annotation for a VMI call; the VMI call currently must be
+ * wrapped in one of the vmi_raw_call (for assembler) or one of the
+ * family of defined wrappers for C code.
+ * XXXPara - use local labels
+ */
+#define vmi_annotate(name)				\
+	.pushsection .vmi.annotation,"a";		\
+	.align 4;					\
+	.long name;					\
+	.long vmi_padded_begin;				\
+	.long vmi_translation_begin;			\
+	.byte vmi_padded_len;				\
+	.byte vmi_translation_len;			\
+	.byte vmi_pad_total;				\
+	.byte 0;					\
+	.popsection;
+
+#define vmi_raw_call(name, native)			\
+	vmi_native_start;				\
+	native;						\
+	vmi_native_finish;				\
+							\
+	vmi_translation_start;				\
+	vmi_call(name);					\
+	vmi_translation_finish;				\
+							\
+	vmi_padded_start;				\
+	native;						\
+	vmi_nop_pad;					\
+	vmi_padded_finish;				\
+							\
+	vmi_annotate(name);
+
+#include <vmiCalls.h>
+#ifdef __ASSEMBLY__
+/*
+ * Create VMI_CALL_FuncName definitions for assembly code using
+ * equates; the C enumerations can not be used without propagating
+ * them in some fashion, and rather the obfuscate asm-offsets.c, it
+ * seems reasonable to confine this here.
+ */
+.equ VMI_CALL_CUR, 0;
+#define VDEF(call)				\
+	.equ VMI_CALL_/**/call, VMI_CALL_CUR;	\
+	.equ VMI_CALL_CUR, VMI_CALL_CUR+1;
+VMI_CALLS
+#undef VDEF
+#endif /* __ASSEMBLY__ */
+
+#define IRET		vmi_raw_call(VMI_CALL_IRET,	iret)
+#define CLI		vmi_raw_call(VMI_CALL_DisableInterrupts, cli)
+#define STI		vmi_raw_call(VMI_CALL_EnableInterrupts,	sti)
+#define STI_SYSEXIT	vmi_raw_call(VMI_CALL_SYSEXIT,	sti; sysexit)
+
+/*
+ * Due to the presence of "," in the instruction, and the use of
+ * -traditional to compile entry.S, we can not use a macro to
+ * encapsulate (mov %cr0, %eax); the full expansion must be
+ * written.
+ */
+#define GET_CR0		vmi_native_start;		\
+			mov %cr0, %eax;			\
+			vmi_native_finish;		\
+			vmi_translation_start;		\
+			vmi_call(VMI_CALL_GetCR0);	\
+			vmi_translation_finish;		\
+			vmi_padded_start;		\
+			mov %cr0, %eax;			\
+			vmi_nop_pad;			\
+			vmi_padded_finish;		\
+			vmi_annotate(VMI_CALL_GetCR0);
+
+#ifndef __ASSEMBLY__
+/*
+ * Several handy macro definitions used to convert the raw assembler
+ * definitions here into quoted strings for use in inline assembler
+ * from C code.
+ *
+ * To convert the value of a defined token to a string, XSTR(x)
+ * To concatenate multiple parameters separated by commas, XCONC()
+ * To convert the value of a defined value with commas, XCSTR()
+ *
+ * These macros are incompatible with -traditional
+ */
+#define MAKESTR(x)              #x
+#define XSTR(x)                 MAKESTR(x)
+#define XCONC(args...)		args
+#define CONCSTR(x...)		#x
+#define XCSTR(x...)		CONCSTR(x)
+
+/*
+ * Propagate these definitions as strings up to C code for convenient use
+ * in stringized assembler as pseudo-mnemonics; we must emit assembler
+ * directives to generate equates for the VMI_CALL_XXX symbols, since they
+ * will not be available otherwise to the assembler, and we can't emit
+ * the C versions of these functions from within an inline assembler
+ * string.
+ */
+asm(".equ VMI_CALL_CUR, 0;\n\t");
+#define VDEF(call)						\
+	asm (".equ VMI_CALL_" #call ", VMI_CALL_CUR;\n\t");	\
+	asm (".equ VMI_CALL_CUR, VMI_CALL_CUR+1;\n\t");
+VMI_CALLS
+#undef VDEF
+
+/*
+ * Sti and Cli are special cases, used in raw inline assembler strings;
+ * they do not need much of the machinery provided by C-code to do type
+ * checking or push arguments onto the stack, which means we can simply
+ * quote the assembler versions defined above rather than try to pry
+ * apart the call sites which use these raw strings.
+ */
+#define CLI_STRING	XCSTR(CLI)
+#define STI_STRING	XCSTR(STI)
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __MACH_ASM_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/vmi.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/vmi.h	2006-03-08 10:52:43.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/vmi.h	2006-03-08 10:53:35.000000000 -0800
@@ -0,0 +1,249 @@
+
+/*
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
+#ifndef __MACH_VMI_H
+#define __MACH_VMI_H
+
+/* Linux type system definitions */
+#include <linux/types.h>
+struct tss_struct;
+struct Xgt_desc_struct;
+typedef struct tss_struct VMI_TASK;
+typedef struct Xgt_desc_struct VMI_DTR;
+typedef uint64_t VMI_UINT64;
+typedef uint32_t VMI_UINT32;
+typedef uint16_t VMI_UINT16;
+typedef uint16_t VMI_SELECTOR;
+typedef uint8_t VMI_UINT8;
+typedef int8_t VMI_INT8;
+typedef uint8_t VMI_BOOL;
+typedef uint64_t VMI_CYCLES;
+
+#include <paravirtualInterface.h>
+#include <mach_asm.h>
+
+#if defined(CONFIG_VMI_C_CONVENTION)
+#define VMI_CLOBBER_ZERO_RETURNS	"cc", "eax", "edx", "ecx"
+#define VMI_CLOBBER_ONE_RETURN		"cc", "edx", "ecx"
+#define VMI_CLOBBER_TWO_RETURNS		"cc", "ecx"
+#define VMI_CLOBBER_FOUR_RETURNS	"cc"
+#elif defined(CONFIG_VMI_CALL_SAVED_ECX)
+#define VMI_CLOBBER_ZERO_RETURNS	"cc", "eax", "edx"
+#define VMI_CLOBBER_ONE_RETURN		"cc", "edx"
+#define VMI_CLOBBER_TWO_RETURNS		"cc"
+#define VMI_CLOBBER_FOUR_RETURNS	"cc"
+#else
+#error "No VMI calling convention defined"
+#endif
+
+#define VMI_CLOBBER(saved) XCONC(VMI_CLOBBER_##saved)
+#define VMI_CLOBBER_EXTENDED(saved, extras...) XCONC(VMI_CLOBBER_##saved, extras)
+
+#if defined(CONFIG_VMI_REGPARM)
+#define VMI_IREG1 "a"
+#define VMI_IREG2 "d"
+#define VMI_IREG3 "c"
+#else
+#define VMI_IREG1 "ir"
+#define VMI_IREG2 "ir"
+#define VMI_IREG3 "ir"
+#endif
+#define VMI_IREG4 "ir"
+#define VMI_IREG5 "ir"
+
+#if (__GNUC__ == 4) 
+#define VMI_IMM	  "i"
+#else
+#define VMI_IMM	  "iV"
+#endif
+
+#define VMI_OREG1 "=a"
+#define VMI_OREG2 "=d"
+#define VMI_OREG64 "=A"
+
+#define vmi_input(arg)			\
+	"push %" XSTR(arg) ";"
+
+#if defined(CONFIG_VMI_REGPARM)
+#define vmi_input_early(arg)
+#else
+#define vmi_input_early(arg)		\
+	"push %" XSTR(arg) ";"
+#endif
+
+#define vmi_input0
+
+#define vmi_input1		\
+	vmi_input_early(0)
+
+#define vmi_input2 		\
+	vmi_input_early(1)	\
+	vmi_input_early(0)
+
+#define vmi_input3		\
+	vmi_input_early(2)	\
+	vmi_input_early(1)	\
+	vmi_input_early(0)
+
+#define vmi_input4		\
+	vmi_input(3)		\
+	vmi_input_early(2)	\
+	vmi_input_early(1)	\
+	vmi_input_early(0)
+
+#define vmi_input5		\
+	vmi_input(4)		\
+	vmi_input(3)		\
+	vmi_input_early(2)	\
+	vmi_input_early(1)	\
+	vmi_input_early(0)
+
+#define vmi_preamble(num_inputs)\
+	vmi_input##num_inputs
+
+#define vmi_postamble0
+#if defined(CONFIG_VMI_REGPARM)
+#define vmi_postamble1
+#define vmi_postamble2
+#define vmi_postamble3
+#define vmi_postamble4 "lea 4(%%esp), %%esp"
+#define vmi_postamble5 "lea 8(%%esp), %%esp"
+#define vmi_postamble6 "lea 12(%%esp), %%esp"
+#define vmi_postamble7 "lea 16(%%esp), %%esp"
+#else
+#define vmi_postamble1 "lea 4(%%esp), %%esp"
+#define vmi_postamble2 "lea 8(%%esp), %%esp"
+#define vmi_postamble3 "lea 12(%%esp), %%esp"
+#define vmi_postamble4 "lea 16(%%esp), %%esp"
+#define vmi_postamble5 "lea 20(%%esp), %%esp"
+#define vmi_postamble6 "lea 24(%%esp), %%esp"
+#define vmi_postamble7 "lea 28(%%esp), %%esp"
+#endif
+
+#if defined(CONFIG_VMI_STDCALL)
+#define vmi_postamble(num_inputs)
+#else
+#define vmi_postamble(num_inputs) vmi_postamble##num_inputs
+#endif
+
+/*
+ * VMI inline assembly with input, output, and clobbers.
+ *
+ * Pecularities:
+ * Input and output must be wrapped using XCONC(...)
+ * Best is to use constraints that are fixed size (like (%1) ... "r")
+ * If you use variable sized constraints like "m" or "g" in the
+ * replacement make sure to pad to the worst case length.
+ */
+
+#define vmi_wrap_call(call, native, output, num_inputs, input, clobber)		\
+do {										\
+	asm volatile (XCSTR(vmi_native_start) 				"\n\t"	\
+		      native						"\n\t"	\
+		      XCSTR(vmi_native_finish)				"\n\t"	\
+										\
+		      XCSTR(vmi_translation_start)			"\n\t"	\
+		      vmi_preamble(num_inputs)				"\n\t"	\
+		      XCSTR(vmi_call(VMI_CALL_##call))			"\n\t"	\
+		      vmi_postamble(num_inputs)				"\n\t"	\
+		      XCSTR(vmi_translation_finish)			"\n\t"	\
+										\
+		      XCSTR(vmi_padded_start) 				"\n\t"	\
+		      native						"\n\t"	\
+		      XCSTR(vmi_nop_pad)				"\n\t"	\
+		      XCSTR(vmi_padded_finish)				"\n\t"	\
+										\
+		      XCSTR(vmi_annotate(VMI_CALL_##call))		"\n\t"	\
+										\
+		      :: input );						\
+	asm volatile ( "" : output :: clobber );				\
+} while (0)
+
+#define VMI_NO_INPUT
+#define VMI_NO_OUTPUT
+
+struct vmi_annotation {
+	unsigned long	vmi_call;
+	unsigned char 	*nativeEIP;
+	unsigned char	*translationEIP;
+	unsigned char	native_size;
+	unsigned char	translation_size;
+	char		nop_size;
+	unsigned char	pad;
+};
+
+extern VMI_UINT8 hypervisor_found;
+extern VMI_UINT8 hypervisor_timer_found;
+extern struct vmi_annotation __vmi_annotation[], __vmi_annotation_end[];
+
+/* VMI function prototypes */
+#define VMICALL extern __attribute__((regparm(3))) 
+
+VMICALL void		VMI_SetPxE(VMI_UINT32 *ptep, VMI_UINT32 pte);
+VMICALL void		VMI_SetPxELong(VMI_UINT64 pte, VMI_UINT64 *ptep);
+VMICALL VMI_UINT32	VMI_GetPxE(VMI_UINT32 *ptep);
+VMICALL VMI_UINT32	VMI_SwapPxE(VMI_UINT32 *ptep, VMI_UINT32 pte);
+VMICALL VMI_UINT64	VMI_SwapPxELongAtomic(VMI_UINT64 pte, VMI_UINT64 *ptep);
+VMICALL VMI_UINT64	VMI_DeactivatePxELongAtomic(VMI_UINT64 *ptep);
+VMICALL int		VMI_TestAndSetPxEBit(VMI_UINT32 *ptep, int bit);
+VMICALL int		VMI_TestAndClearPxEBit(VMI_UINT32 *ptep, int bit);
+VMICALL void		VMI_AllocatePage(VMI_UINT32 ppn, int flags, VMI_UINT32 orig, int base,
+                                 int count);
+VMICALL void		VMI_ReleasePage(VMI_UINT32 ppn, int flags);
+VMICALL int		VMI_FlushDeferredCalls(VMI_UINT32 mode);
+VMICALL int		VMI_TestAndSetPxELongBit(VMI_UINT64 *ptep, int bit);
+VMICALL int		VMI_TestAndClearPxELongBit(VMI_UINT64 *ptep, int bit);
+VMICALL void            VMI_SetInitialAPState(VMI_UINT32 apState,
+                                              VMI_UINT32 apicId);
+
+/* Linux name convention shims */
+#define vmi_set_pxe(p,v)		VMI_SetPxE((VMI_UINT32 *)(p),v)
+#define vmi_set_pxe_long(v,p)		VMI_SetPxELong(v, (VMI_UINT64 *)(p))
+#define vmi_set_pxe_long_atomic(v,p)	VMI_SetPxELongAtomic(v, (VMI_UINT64 *)(p))
+#define vmi_get_pxe(p,v)		VMI_GetPxE((VMI_UINT32 *)(p),v)
+#define vmi_swap_pxe(p,v)		VMI_SwapPxE((VMI_UINT32 *)(p),v)
+#define vmi_test_and_set_pxe_bit(p,b)	VMI_TestAndSetPxEBit((VMI_UINT32 *)(p),b)
+#define vmi_test_and_clear_pxe_bit(p,b)	VMI_TestAndClearPxEBit((VMI_UINT32 *)(p),b)
+#define vmi_test_and_set_pxe_long_bit(p,b)	VMI_TestAndSetPxELongBit((VMI_UINT64 *)(p),b)
+#define vmi_test_and_clear_pxe_long_bit(p,b)	VMI_TestAndClearPxELongBit((VMI_UINT64 *)(p),b)
+#define vmi_allocate_page(p,f,r,b,c)    VMI_AllocatePage(p,f,r,b,c)
+#define vmi_release_page(p,f)		VMI_ReleasePage(p,f)
+#define vmi_flush_deferred_calls(m)	VMI_FlushDeferredCalls(m)
+#define vmi_flush_pt_updates()		VMI_FlushDeferredCalls(VMI_FLUSH_PT_UPDATES)
+#define vmi_set_initial_ap_state(s,a)   VMI_SetInitialAPState(s,a)
+
+static inline VMI_UINT8 vmi_hypervisor_found(void)
+{
+	return hypervisor_found;
+}
+
+extern void probe_vmi_timer(void);
+
+static inline VMI_UINT8 vmi_timer_used(void)
+{
+	return hypervisor_timer_found;
+}
+
+#endif /* __MACH_VMI_H */
Index: linux-2.6.16-rc5/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/Kconfig	2006-03-08 10:52:41.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/Kconfig	2006-03-08 10:53:47.000000000 -0800
@@ -145,6 +145,47 @@ endchoice
 menu "VMI configurable support"
 	depends on X86_VMI
 
+choice 
+	prompt "VMI call convention"
+	default VMI_C_CONVENTION
+
+config VMI_C_CONVENTION
+	bool "Use standard C calling convention"
+	help
+	   Use standard C calling convention with stack passing and
+	   normal scratch registers (eax, ecx, edx).  Returns are in
+	   eax, edx as usual.
+
+config VMI_CALL_SAVED_ECX
+	bool "Use call saved ECX calling convention"
+	help
+	   Use non-C convention, with stack passing and only eax, edx as
+	   scratch registers.  Caller must save ECX if used.  Returns are
+	   unchanged.  VMI code may be written in C using -fcall-saved-ecx.
+
+endchoice
+
+config VMI_REGPARM
+	bool "Use regparm calling convention"
+	default y
+	help
+	   Use regparm parameter passing convention with register passing in
+	   eax, edx, ecx.  Returns are in eax, edx as usual.  This generates
+	   the most efficient VMI calls, but requires forcing kernel register
+	   allocation.
+
+config VMI_STDCALL
+	bool "Use stdcall return convention"
+	default n
+	help
+	   Normally caller removes arguments from the stack.  Using stdcall
+	   convention the callee removes arguments from the stack.  This may
+	   help alleviate performance issues on Opteron due to use of 3
+	   byte ret instructions from VMI calls, and reduces the amount of
+	   nop padding required in the kernel.  It prevents the use of
+	   variadic argument functions, which may be useful for some VMI
+	   implementations that choose to discard extra constant annotations.
+
 config VMI_REQUIRE_HYPERVISOR
         bool "Require hypervisor"
         default n
