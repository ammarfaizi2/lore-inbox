Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWHHU6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWHHU6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWHHU6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:58:44 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:17874 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965037AbWHHU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:58:43 -0400
Message-Id: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Rob Landley <rob@landley.net>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 1/2] Split i386 and x86_64 ptrace.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2006 16:58:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of SEGMENT_RPL_MASK in the i386 ptrace.h introduced by
x86-allow-a-kernel-to-not-be-in-ring-0.patch broke the UML build, as
UML includes the underlying architecture's ptrace.h, but has no easy
access to the x86 segment definitions.

Rather than kludging around this, as in the past, this patch splits
the userspace-usable parts, which are the bits that UML needs, of
ptrace.h into ptrace-abi.h, which is included back into ptrace.h.
Thus, there is no net effect on i386.

As a side-effect, this creates a ptrace header which is close to being
usable in /usr/include.

x86_64 is also treated in this way for consistency.

This patch was run by linux-arch yesterday with no comment.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/include/asm-i386/ptrace-abi.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-i386/ptrace-abi.h
@@ -0,0 +1,60 @@
+#ifndef I386_PTRACE_ABI_H
+#define I386_PTRACE_ABI_H
+
+#define EBX 0
+#define ECX 1
+#define EDX 2
+#define ESI 3
+#define EDI 4
+#define EBP 5
+#define EAX 6
+#define DS 7
+#define ES 8
+#define FS 9
+#define GS 10
+#define ORIG_EAX 11
+#define EIP 12
+#define CS  13
+#define EFL 14
+#define UESP 15
+#define SS   16
+#define FRAME_SIZE 17
+
+/* this struct defines the way the registers are stored on the
+   stack during a system call. */
+
+struct pt_regs {
+	long ebx;
+	long ecx;
+	long edx;
+	long esi;
+	long edi;
+	long ebp;
+	long eax;
+	int  xds;
+	int  xes;
+	long orig_eax;
+	long eip;
+	int  xcs;
+	long eflags;
+	long esp;
+	int  xss;
+};
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
+
+#endif
Index: linux-2.6.17/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.17.orig/include/asm-i386/ptrace.h
+++ linux-2.6.17/include/asm-i386/ptrace.h
@@ -1,61 +1,7 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H
 
-#define EBX 0
-#define ECX 1
-#define EDX 2
-#define ESI 3
-#define EDI 4
-#define EBP 5
-#define EAX 6
-#define DS 7
-#define ES 8
-#define FS 9
-#define GS 10
-#define ORIG_EAX 11
-#define EIP 12
-#define CS  13
-#define EFL 14
-#define UESP 15
-#define SS   16
-#define FRAME_SIZE 17
-
-/* this struct defines the way the registers are stored on the 
-   stack during a system call. */
-
-struct pt_regs {
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	int  xds;
-	int  xes;
-	long orig_eax;
-	long eip;
-	int  xcs;
-	long eflags;
-	long esp;
-	int  xss;
-};
-
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
-#define PTRACE_SYSEMU		  31
-#define PTRACE_SYSEMU_SINGLESTEP  32
+#include <asm/ptrace-abi.h>
 
 #ifdef __KERNEL__
 
Index: linux-2.6.17/include/asm-x86_64/ptrace-abi.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-x86_64/ptrace-abi.h
@@ -0,0 +1,83 @@
+#ifndef _X86_64_PTRACE_ABI_H
+#define _X86_64_PTRACE_ABI_H
+
+#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS)
+#define R15 0
+#define R14 8
+#define R13 16
+#define R12 24
+#define RBP 32
+#define RBX 40
+/* arguments: interrupts/non tracing syscalls only save upto here*/
+#define R11 48
+#define R10 56
+#define R9 64
+#define R8 72
+#define RAX 80
+#define RCX 88
+#define RDX 96
+#define RSI 104
+#define RDI 112
+#define ORIG_RAX 120       /* = ERROR */
+/* end of arguments */
+/* cpu exception frame or undefined in case of fast syscall. */
+#define RIP 128
+#define CS 136
+#define EFLAGS 144
+#define RSP 152
+#define SS 160
+#define ARGOFFSET R11
+#endif /* __ASSEMBLY__ */
+
+/* top of stack page */
+#define FRAME_SIZE 168
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long r15;
+	unsigned long r14;
+	unsigned long r13;
+	unsigned long r12;
+	unsigned long rbp;
+	unsigned long rbx;
+/* arguments: non interrupts/non tracing syscalls only save upto here*/
+ 	unsigned long r11;
+	unsigned long r10;
+	unsigned long r9;
+	unsigned long r8;
+	unsigned long rax;
+	unsigned long rcx;
+	unsigned long rdx;
+	unsigned long rsi;
+	unsigned long rdi;
+	unsigned long orig_rax;
+/* end of arguments */
+/* cpu exception frame or undefined */
+	unsigned long rip;
+	unsigned long cs;
+	unsigned long eflags;
+	unsigned long rsp;
+	unsigned long ss;
+/* top of stack page */
+};
+
+#endif
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+/* only useful for access 32bit programs */
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#define PTRACE_ARCH_PRCTL	  30	/* arch_prctl for child */
+
+#endif
Index: linux-2.6.17/include/asm-x86_64/ptrace.h
===================================================================
--- linux-2.6.17.orig/include/asm-x86_64/ptrace.h
+++ linux-2.6.17/include/asm-x86_64/ptrace.h
@@ -1,84 +1,7 @@
 #ifndef _X86_64_PTRACE_H
 #define _X86_64_PTRACE_H
 
-#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS) 
-#define R15 0
-#define R14 8
-#define R13 16
-#define R12 24
-#define RBP 32
-#define RBX 40
-/* arguments: interrupts/non tracing syscalls only save upto here*/
-#define R11 48
-#define R10 56	
-#define R9 64
-#define R8 72
-#define RAX 80
-#define RCX 88
-#define RDX 96
-#define RSI 104
-#define RDI 112
-#define ORIG_RAX 120       /* = ERROR */ 
-/* end of arguments */ 	
-/* cpu exception frame or undefined in case of fast syscall. */
-#define RIP 128
-#define CS 136
-#define EFLAGS 144
-#define RSP 152
-#define SS 160
-#define ARGOFFSET R11
-#endif /* __ASSEMBLY__ */
-
-/* top of stack page */ 
-#define FRAME_SIZE 168
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#ifndef __ASSEMBLY__ 
-
-struct pt_regs {
-	unsigned long r15;
-	unsigned long r14;
-	unsigned long r13;
-	unsigned long r12;
-	unsigned long rbp;
-	unsigned long rbx;
-/* arguments: non interrupts/non tracing syscalls only save upto here*/
- 	unsigned long r11;
-	unsigned long r10;	
-	unsigned long r9;
-	unsigned long r8;
-	unsigned long rax;
-	unsigned long rcx;
-	unsigned long rdx;
-	unsigned long rsi;
-	unsigned long rdi;
-	unsigned long orig_rax;
-/* end of arguments */ 	
-/* cpu exception frame or undefined */
-	unsigned long rip;
-	unsigned long cs;
-	unsigned long eflags; 
-	unsigned long rsp; 
-	unsigned long ss;
-/* top of stack page */ 
-};
-
-#endif
-
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-/* only useful for access 32bit programs */
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
-#define PTRACE_ARCH_PRCTL	  30	/* arch_prctl for child */
+#include <asm/ptrace-abi.h>
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) 
 #define user_mode(regs) (!!((regs)->cs & 3))

