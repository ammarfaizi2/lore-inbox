Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVHGBR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVHGBR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVHGBPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:15:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261406AbVHGBOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:14:40 -0400
Date: Sat, 6 Aug 2005 18:14:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 7/8 Create accessors that allow the i386 kernel to run at CPLs 0-2
Message-ID: <20050807011433.GL7762@shell0.pdx.osdl.net>
References: <42F46506.4030304@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F46506.4030304@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> These changes allow a sub-architecture to change the notion of privilege
> by running the kernel at CPL 0, 1, or 2.  The make_kernel_segment() macro
> can be redefined by a subarchitecture to change the RPL on kernel segments
> to the appropriate value, and the tests user_mode() and user_mode_vm()
> may be similarly overridden.

No issue here, but there's some overlap from my side that needs merging
(note, as with all the others, mine are against 2.6.12, to user_mode(),
for example, has changed since then).  Also note, the segment bit is
still much too heavy handed on my side (looks like you are generally
further along than I am ;-) so I still have some refactoring to do.


--- linux-2.6.12-xen0-arch.orig/include/asm-i386/ptrace.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/ptrace.h
@@ -55,9 +55,9 @@ struct pt_regs {
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
+#include <mach_ptrace.h>
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
-#define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_ptrace.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PTRACE_H
+#define __ASM_MACH_PTRACE_H
+
+#define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
+
+#endif
--- linux-2.6.12-xen0-arch.orig/include/asm-i386/segment.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/segment.h
@@ -1,101 +1,6 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
-/*
- * The layout of the per-CPU GDT under Linux:
- *
- *   0 - null
- *   1 - reserved
- *   2 - reserved
- *   3 - reserved
- *
- *   4 - unused			<==== new cacheline
- *   5 - unused
- *
- *  ------- start of TLS (Thread-Local Storage) segments:
- *
- *   6 - TLS segment #1			[ glibc's TLS segment ]
- *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
- *   8 - TLS segment #3
- *   9 - reserved
- *  10 - reserved
- *  11 - reserved
- *
- *  ------- start of kernel segments:
- *
- *  12 - kernel code segment		<==== new cacheline
- *  13 - kernel data segment
- *  14 - default user CS
- *  15 - default user DS
- *  16 - TSS
- *  17 - LDT
- *  18 - PNPBIOS support (16->32 gate)
- *  19 - PNPBIOS support
- *  20 - PNPBIOS support
- *  21 - PNPBIOS support
- *  22 - PNPBIOS support
- *  23 - APM BIOS support
- *  24 - APM BIOS support
- *  25 - APM BIOS support 
- *
- *  26 - ESPFIX small SS
- *  27 - unused
- *  28 - unused
- *  29 - unused
- *  30 - unused
- *  31 - TSS for double fault handler
- */
-#define GDT_ENTRY_TLS_ENTRIES	3
-#define GDT_ENTRY_TLS_MIN	6
-#define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
-
-#define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
-
-#define GDT_ENTRY_DEFAULT_USER_CS	14
-#define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
-
-#define GDT_ENTRY_DEFAULT_USER_DS	15
-#define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
-
-#define GDT_ENTRY_KERNEL_BASE	12
-
-#define GDT_ENTRY_KERNEL_CS		(GDT_ENTRY_KERNEL_BASE + 0)
-#define __KERNEL_CS (GDT_ENTRY_KERNEL_CS * 8)
-
-#define GDT_ENTRY_KERNEL_DS		(GDT_ENTRY_KERNEL_BASE + 1)
-#define __KERNEL_DS (GDT_ENTRY_KERNEL_DS * 8)
-
-#define GDT_ENTRY_TSS			(GDT_ENTRY_KERNEL_BASE + 4)
-#define GDT_ENTRY_LDT			(GDT_ENTRY_KERNEL_BASE + 5)
-
-#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
-#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
-
-#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
-#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
-
-#define GDT_ENTRY_DOUBLEFAULT_TSS	31
-
-/*
- * The GDT has 32 entries
- */
-#define GDT_ENTRIES 32
-
-#define GDT_SIZE (GDT_ENTRIES * 8)
-
-/* Simple and small GDT entries for booting only */
-
-#define GDT_ENTRY_BOOT_CS		2
-#define __BOOT_CS	(GDT_ENTRY_BOOT_CS * 8)
-
-#define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
-#define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
-
-/*
- * The interrupt descriptor table has room for 256 idt's,
- * the global descriptor table is dependent on the number
- * of tasks we can have..
- */
-#define IDT_ENTRIES 256
+#include <mach_segment.h>
 
 #endif
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_segment.h
@@ -0,0 +1,101 @@
+#ifndef _ASM_MACH_SEGMENT_H
+#define _ASM_MACH_SEGMENT_H
+
+/*
+ * The layout of the per-CPU GDT under Linux:
+ *
+ *   0 - null
+ *   1 - reserved
+ *   2 - reserved
+ *   3 - reserved
+ *
+ *   4 - unused			<==== new cacheline
+ *   5 - unused
+ *
+ *  ------- start of TLS (Thread-Local Storage) segments:
+ *
+ *   6 - TLS segment #1			[ glibc's TLS segment ]
+ *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
+ *   8 - TLS segment #3
+ *   9 - reserved
+ *  10 - reserved
+ *  11 - reserved
+ *
+ *  ------- start of kernel segments:
+ *
+ *  12 - kernel code segment		<==== new cacheline
+ *  13 - kernel data segment
+ *  14 - default user CS
+ *  15 - default user DS
+ *  16 - TSS
+ *  17 - LDT
+ *  18 - PNPBIOS support (16->32 gate)
+ *  19 - PNPBIOS support
+ *  20 - PNPBIOS support
+ *  21 - PNPBIOS support
+ *  22 - PNPBIOS support
+ *  23 - APM BIOS support
+ *  24 - APM BIOS support
+ *  25 - APM BIOS support 
+ *
+ *  26 - ESPFIX small SS
+ *  27 - unused
+ *  28 - unused
+ *  29 - unused
+ *  30 - unused
+ *  31 - TSS for double fault handler
+ */
+#define GDT_ENTRY_TLS_ENTRIES	3
+#define GDT_ENTRY_TLS_MIN	6
+#define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
+
+#define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
+
+#define GDT_ENTRY_DEFAULT_USER_CS	14
+#define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
+
+#define GDT_ENTRY_DEFAULT_USER_DS	15
+#define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
+
+#define GDT_ENTRY_KERNEL_BASE	12
+
+#define GDT_ENTRY_KERNEL_CS		(GDT_ENTRY_KERNEL_BASE + 0)
+#define __KERNEL_CS (GDT_ENTRY_KERNEL_CS * 8)
+
+#define GDT_ENTRY_KERNEL_DS		(GDT_ENTRY_KERNEL_BASE + 1)
+#define __KERNEL_DS (GDT_ENTRY_KERNEL_DS * 8)
+
+#define GDT_ENTRY_TSS			(GDT_ENTRY_KERNEL_BASE + 4)
+#define GDT_ENTRY_LDT			(GDT_ENTRY_KERNEL_BASE + 5)
+
+#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
+#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
+
+#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
+#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
+#define GDT_ENTRY_DOUBLEFAULT_TSS	31
+
+/*
+ * The GDT has 32 entries
+ */
+#define GDT_ENTRIES 32
+
+#define GDT_SIZE (GDT_ENTRIES * 8)
+
+/* Simple and small GDT entries for booting only */
+
+#define GDT_ENTRY_BOOT_CS		2
+#define __BOOT_CS	(GDT_ENTRY_BOOT_CS * 8)
+
+#define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
+#define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
+
+/*
+ * The interrupt descriptor table has room for 256 idt's,
+ * the global descriptor table is dependent on the number
+ * of tasks we can have..
+ */
+#define IDT_ENTRIES 256
+
+#endif
