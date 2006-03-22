Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWCVGtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWCVGtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWCVGtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:49:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17794 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750872AbWCVGhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:33 -0500
Message-Id: <20060322063748.490176000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:50 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 10/35] Add a new head.S start-of-day file for booting on Xen.
Content-Disposition: inline; filename=09-i386-head.S
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running on Xen, the kernel is started with paging enabled.  Also
don't check for cpu features which are present on all cpus supported
by Xen.

Don't define segments which are not supported when running on Xen.

Define the __xen_guest section which exports information about the
kernel to the domain builder.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/Makefile          |    7 +
 arch/i386/mach-xen/Makefile |    2 
 arch/i386/mach-xen/head.S   |  184 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)

--- xen-subarch-2.6.orig/arch/i386/Makefile
+++ xen-subarch-2.6/arch/i386/Makefile
@@ -45,6 +45,9 @@ CFLAGS				+= $(shell if [ $(call cc-vers
 
 CFLAGS += $(cflags-y)
 
+# Default subarch head files
+head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
+
 # Default subarch .c files
 mcore-y  := mach-default
 
@@ -71,6 +74,8 @@ mcore-$(CONFIG_X86_SUMMIT)  := mach-defa
 # Xen subarch support
 mflags-$(CONFIG_X86_XEN)	:= -Iinclude/asm-i386/mach-xen
 mcore-$(CONFIG_X86_XEN)		:= mach-xen
+head-$(CONFIG_X86_XEN)		:= arch/i386/mach-xen/head.o \
+				   arch/i386/kernel/init_task.o
 
 # generic subarchitecture
 mflags-$(CONFIG_X86_GENERICARCH) := -Iinclude/asm-i386/mach-generic
@@ -85,8 +90,6 @@ core-$(CONFIG_X86_ES7000)	:= arch/i386/m
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
-head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
-
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
--- xen-subarch-2.6.orig/arch/i386/mach-xen/Makefile
+++ xen-subarch-2.6/arch/i386/mach-xen/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+extra-y				:= head.o
+
 obj-y				:= setup.o
  
 setup-y				:= ../mach-default/setup.o
--- /dev/null
+++ xen-subarch-2.6/arch/i386/mach-xen/head.S
@@ -0,0 +1,184 @@
+
+
+.text
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+#include <xen/interface/arch-x86_32.h>
+
+/*
+ * References to members of the new_cpu_data structure.
+ */
+
+#define X86		new_cpu_data+CPUINFO_x86
+#define X86_VENDOR	new_cpu_data+CPUINFO_x86_vendor
+#define X86_MODEL	new_cpu_data+CPUINFO_x86_model
+#define X86_MASK	new_cpu_data+CPUINFO_x86_mask
+#define X86_HARD_MATH	new_cpu_data+CPUINFO_hard_math
+#define X86_CPUID	new_cpu_data+CPUINFO_cpuid_level
+#define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
+#define X86_VENDOR_ID	new_cpu_data+CPUINFO_x86_vendor_id
+
+ENTRY(startup_32)
+	movl %esi,xen_start_info
+	cld
+
+	/* Set up the stack pointer */
+	movl $(init_thread_union+THREAD_SIZE),%esp
+
+	/* get vendor info */
+	xorl %eax,%eax			# call CPUID with 0 -> return vendor ID
+	cpuid
+	movl %eax,X86_CPUID		# save CPUID level
+	movl %ebx,X86_VENDOR_ID		# lo 4 chars
+	movl %edx,X86_VENDOR_ID+4	# next 4 chars
+	movl %ecx,X86_VENDOR_ID+8	# last 4 chars
+
+	movl $1,%eax		# Use the CPUID instruction to get CPU type
+	cpuid
+	movb %al,%cl		# save reg for future use
+	andb $0x0f,%ah		# mask processor family
+	movb %ah,X86
+	andb $0xf0,%al		# mask model
+	shrb $4,%al
+	movb %al,X86_MODEL
+	andb $0x0f,%cl		# mask mask revision
+	movb %cl,X86_MASK
+	movl %edx,X86_CAPABILITY
+
+	movb $1,X86_HARD_MATH
+
+	xorl %eax,%eax			# Clear FS/GS and LDT
+	movl %eax,%fs
+	movl %eax,%gs
+	cld			# gcc2 wants the direction flag cleared at all times
+
+	call start_kernel
+L6:
+	jmp L6			# main should never return here, but
+				# just in case, we know what happens.
+
+#define HYPERCALL_PAGE_OFFSET 0x1000
+.org HYPERCALL_PAGE_OFFSET
+ENTRY(hypercall_page)
+.skip 0x1000
+
+/*
+ * Real beginning of normal "text" segment
+ */
+ENTRY(stext)
+ENTRY(_stext)
+
+/*
+ * BSS section
+ */
+.section ".bss.page_aligned","w"
+ENTRY(swapper_pg_dir)
+	.fill 1024,4,0
+ENTRY(empty_zero_page)
+	.fill 4096,1,0
+
+/*
+ * This starts the data section.
+ */
+.data
+
+	ALIGN
+	.word 0				# 32 bit align gdt_desc.address
+	.globl cpu_gdt_descr
+cpu_gdt_descr:
+	.word GDT_SIZE
+	.long cpu_gdt_table
+
+	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
+
+/*
+ * The Global Descriptor Table contains 28 quadwords, per-CPU.
+ */
+	.align PAGE_SIZE_asm
+ENTRY(cpu_gdt_table)
+	.quad 0x0000000000000000	/* NULL descriptor */
+	.quad 0x0000000000000000	/* 0x0b reserved */
+	.quad 0x0000000000000000	/* 0x13 reserved */
+	.quad 0x0000000000000000	/* 0x1b reserved */
+	.quad 0x0000000000000000	/* 0x20 unused */
+	.quad 0x0000000000000000	/* 0x28 unused */
+	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
+	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
+	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
+	.quad 0x0000000000000000	/* 0x4b reserved */
+	.quad 0x0000000000000000	/* 0x53 reserved */
+	.quad 0x0000000000000000	/* 0x5b reserved */
+
+	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
+	.quad 0x00cffa000000ffff	/* 0x73 user 4GB code at 0x00000000 */
+	.quad 0x00cff2000000ffff	/* 0x7b user 4GB data at 0x00000000 */
+
+	.quad 0x0000000000000000	/* 0x80 TSS descriptor */
+	.quad 0x0000000000000000	/* 0x88 LDT descriptor */
+
+	/*
+	 * Segments used for calling PnP BIOS have byte granularity.
+	 * They code segments and data segments have fixed 64k limits,
+	 * the transfer segment sizes are set at run time.
+	 */
+	.quad 0x0000000000000000	/* 0x90 32-bit code */
+	.quad 0x0000000000000000	/* 0x98 16-bit code */
+	.quad 0x0000000000000000	/* 0xa0 16-bit data */
+	.quad 0x0000000000000000	/* 0xa8 16-bit data */
+	.quad 0x0000000000000000	/* 0xb0 16-bit data */
+
+	/*
+	 * The APM segments have byte granularity and their bases
+	 * are set at run time.  All have 64k limits.
+	 */
+	.quad 0x0000000000000000	/* 0xb8 APM CS    code */
+	.quad 0x0000000000000000	/* 0xc0 APM CS 16 code (16 bit) */
+	.quad 0x0000000000000000	/* 0xc8 APM DS    data */
+
+	.quad 0x0000000000000000	/* 0xd0 - ESPFIX 16-bit SS */
+	.quad 0x0000000000000000	/* 0xd8 - unused */
+	.quad 0x0000000000000000	/* 0xe0 - unused */
+	.quad 0x0000000000000000	/* 0xe8 - unused */
+	.quad 0x0000000000000000	/* 0xf0 - unused */
+	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
+
+	/* Be sure this is zeroed to avoid false validations in Xen */
+	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
+
+
+/*
+ * __xen_guest information
+ */
+.macro utoa value
+ .if (\value) < 0 || (\value) >= 0x10
+	utoa (((\value)>>4)&0x0fffffff)
+ .endif
+ .if ((\value) & 0xf) < 10
+  .byte '0' + ((\value) & 0xf)
+ .else
+  .byte 'A' + ((\value) & 0xf) - 10
+ .endif
+.endm
+
+.section __xen_guest
+	.ascii	"GUEST_OS=linux,GUEST_VER=2.6"
+	.ascii	",XEN_VER=xen-3.0"
+	.ascii	",VIRT_BASE=0x"
+		utoa __PAGE_OFFSET
+	.ascii	",HYPERCALL_PAGE=0x"
+		utoa ((__PHYSICAL_START+HYPERCALL_PAGE_OFFSET)>>PAGE_SHIFT)
+	.ascii  ",FEATURES=!writable_page_tables"
+	.ascii	         "|!auto_translated_physmap"
+#ifdef CONFIG_X86_PAE
+	.ascii	",PAE=yes"
+#else
+	.ascii	",PAE=no"
+#endif
+	.ascii	",LOADER=generic"
+	.byte	0

--
