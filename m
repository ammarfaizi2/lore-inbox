Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263239AbTCSXsY>; Wed, 19 Mar 2003 18:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbTCSXsY>; Wed, 19 Mar 2003 18:48:24 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:16276 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S263239AbTCSXsT>; Wed, 19 Mar 2003 18:48:19 -0500
Message-ID: <3E79043D.9020408@quark.didntduck.org>
Date: Wed, 19 Mar 2003 18:58:53 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] asm offsets for i386
Content-Type: multipart/mixed;
 boundary="------------080801090700040105010609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080801090700040105010609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch creates an asm-offsets.c file for i386, and removes the 
hardcoded constants from several files.

--
				Brian Gerst

--------------080801090700040105010609
Content-Type: text/plain;
 name="asm-offsets-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asm-offsets-1"

diff -urN linux-2.5.65-bk1/arch/i386/kernel/asm-offsets.c linux/arch/i386/kernel/asm-offsets.c
--- linux-2.5.65-bk1/arch/i386/kernel/asm-offsets.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/arch/i386/kernel/asm-offsets.c	2003-03-19 14:59:27.000000000 -0500
@@ -0,0 +1,60 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/thread_info.h>
+#include <linux/ptrace.h>
+#include <asm/processor.h>
+#include <asm/fixmap.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define ADDR(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "m" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+void foo(void)
+{
+	DEFINE(TI_TASK, offsetof(struct thread_info, task));
+	DEFINE(TI_EXEC_DOMAIN, offsetof(struct thread_info, exec_domain));
+	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_STATUS, offsetof(struct thread_info, status));
+	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
+	DEFINE(TI_PRE_COUNT, offsetof(struct thread_info, preempt_count));
+	DEFINE(TI_ADDR_LIMIT, offsetof(struct thread_info, addr_limit));
+	DEFINE(TI_RESTART_BLOCK, offsetof(struct thread_info, restart_block));
+	BLANK();
+
+	DEFINE(EBX, offsetof(struct pt_regs, ebx));
+	DEFINE(ECX, offsetof(struct pt_regs, ecx));
+	DEFINE(EDX, offsetof(struct pt_regs, edx));
+	DEFINE(ESI, offsetof(struct pt_regs, esi));
+	DEFINE(EDI, offsetof(struct pt_regs, edi));
+	DEFINE(EBP, offsetof(struct pt_regs, ebp));
+	DEFINE(EAX, offsetof(struct pt_regs, eax));
+	DEFINE(DS, offsetof(struct pt_regs, xds));
+	DEFINE(ES, offsetof(struct pt_regs, xes));
+	DEFINE(ORIG_EAX, offsetof(struct pt_regs, orig_eax));
+	DEFINE(EIP, offsetof(struct pt_regs, eip));
+	DEFINE(CS, offsetof(struct pt_regs, xcs));
+	DEFINE(EFLAGS, offsetof(struct pt_regs, eflags));
+	DEFINE(OLDESP, offsetof(struct pt_regs, esp));
+	DEFINE(OLDSS, offsetof(struct pt_regs, xss));
+	BLANK();
+
+	ADDR(X86, new_cpu_data.x86);
+	ADDR(X86_VENDOR, new_cpu_data.x86_vendor);
+	ADDR(X86_MODEL, new_cpu_data.x86_model);
+	ADDR(X86_MASK, new_cpu_data.x86_mask);
+	ADDR(X86_HARD_MATH, new_cpu_data.hard_math);
+	ADDR(X86_CPUID, new_cpu_data.cpuid_level);
+	ADDR(X86_CAPABILITY, new_cpu_data.x86_capability[0]);
+	ADDR(X86_VENDOR_ID, new_cpu_data.x86_vendor_id[0]);
+	BLANK();
+
+	DEFINE(SYSENTER_BASE, __fix_to_virt(FIX_VSYSCALL));
+}
diff -urN linux-2.5.65-bk1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.65-bk1/arch/i386/kernel/entry.S	2003-03-17 18:04:44.000000000 -0500
+++ linux/arch/i386/kernel/entry.S	2003-03-19 14:13:32.000000000 -0500
@@ -47,24 +47,9 @@
 #include <asm/segment.h>
 #include <asm/smp.h>
 #include <asm/page.h>
+#include <asm/asm_offsets.h>
 #include "irq_vectors.h"
 
-EBX		= 0x00
-ECX		= 0x04
-EDX		= 0x08
-ESI		= 0x0C
-EDI		= 0x10
-EBP		= 0x14
-EAX		= 0x18
-DS		= 0x1C
-ES		= 0x20
-ORIG_EAX	= 0x24
-EIP		= 0x28
-CS		= 0x2C
-EFLAGS		= 0x30
-OLDESP		= 0x34
-OLDSS		= 0x38
-
 CF_MASK		= 0x00000001
 TF_MASK		= 0x00000100
 IF_MASK		= 0x00000200
@@ -231,7 +216,7 @@
 #endif
 
 /* Points to after the "sysenter" instruction in the vsyscall page */
-#define SYSENTER_RETURN 0xffffe010
+#define SYSENTER_RETURN SYSENTER_BASE + 0x10
 
 	# sysenter call handler stub
 ENTRY(sysenter_entry)
diff -urN linux-2.5.65-bk1/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-2.5.65-bk1/arch/i386/kernel/head.S	2003-03-17 18:04:44.000000000 -0500
+++ linux/arch/i386/kernel/head.S	2003-03-19 14:23:43.000000000 -0500
@@ -16,6 +16,7 @@
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 #include <asm/cache.h>
+#include <asm/asm_offsets.h>
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -24,20 +25,6 @@
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
 /*
- * References to members of the new_cpu_data structure.
- */
-
-#define CPU_PARAMS	new_cpu_data
-#define X86		CPU_PARAMS+0
-#define X86_VENDOR	CPU_PARAMS+1
-#define X86_MODEL	CPU_PARAMS+2
-#define X86_MASK	CPU_PARAMS+3
-#define X86_HARD_MATH	CPU_PARAMS+6
-#define X86_CPUID	CPU_PARAMS+8
-#define X86_CAPABILITY	CPU_PARAMS+12
-#define X86_VENDOR_ID	CPU_PARAMS+28
-
-/*
  * Initialize page tables
  */
 #define INIT_PAGE_TABLES \
diff -urN linux-2.5.65-bk1/arch/i386/lib/getuser.S linux/arch/i386/lib/getuser.S
--- linux-2.5.65-bk1/arch/i386/lib/getuser.S	2002-12-24 00:19:24.000000000 -0500
+++ linux/arch/i386/lib/getuser.S	2003-03-19 13:18:42.000000000 -0500
@@ -9,6 +9,7 @@
  * return value.
  */
 #include <asm/thread_info.h>
+#include <asm/asm_offsets.h>
 
 
 /*
diff -urN linux-2.5.65-bk1/arch/i386/Makefile linux/arch/i386/Makefile
--- linux-2.5.65-bk1/arch/i386/Makefile	2003-03-17 18:04:43.000000000 -0500
+++ linux/arch/i386/Makefile	2003-03-19 13:18:42.000000000 -0500
@@ -92,6 +92,14 @@
 
 boot := arch/i386/boot
 
+prepare: include/asm-$(ARCH)/asm_offsets.h
+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+
+include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
+	$(call filechk,gen-asm-offsets)
+
 .PHONY: zImage bzImage compressed zlilo bzlilo \
 	zdisk bzdisk fdimage fdimage144 fdimage288 install
 
@@ -127,4 +135,5 @@
   echo  '  fdimage      - Create a boot floppy image'
 endef
 
-CLEAN_FILES += arch/$(ARCH)/boot/fdimage arch/$(ARCH)/boot/mtools.conf
+CLEAN_FILES += arch/$(ARCH)/boot/fdimage arch/$(ARCH)/boot/mtools.conf \
+	       include/asm-$(ARCH)/asm_offsets.h
diff -urN linux-2.5.65-bk1/include/asm-i386/thread_info.h linux/include/asm-i386/thread_info.h
--- linux-2.5.65-bk1/include/asm-i386/thread_info.h	2003-03-17 18:04:55.000000000 -0500
+++ linux/include/asm-i386/thread_info.h	2003-03-19 13:18:42.000000000 -0500
@@ -38,18 +38,6 @@
 	__u8			supervisor_stack[0];
 };
 
-#else /* !__ASSEMBLY__ */
-
-/* offsets into the thread_info struct for assembly code access */
-#define TI_TASK		0x00000000
-#define TI_EXEC_DOMAIN	0x00000004
-#define TI_FLAGS	0x00000008
-#define TI_STATUS	0x0000000C
-#define TI_CPU		0x00000010
-#define TI_PRE_COUNT	0x00000014
-#define TI_ADDR_LIMIT	0x00000018
-#define TI_RESTART_BLOCK 0x000001C
-
 #endif
 
 #define PREEMPT_ACTIVE		0x4000000

--------------080801090700040105010609--

