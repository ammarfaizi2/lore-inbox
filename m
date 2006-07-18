Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWGRJaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWGRJaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWGRJ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:29:54 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35969 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932108AbWGRJUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:20 -0400
Message-Id: <20060718091952.263186000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 15/33] move segment checks to subarch
Content-Disposition: inline; filename=i386-segments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We allow for the fact that the guest kernel may not run in ring 0.
This requires some abstraction in a few places when setting %cs or
checking privilege level (user vs kernel).

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/process.c                   |    2 +-
 arch/i386/mm/fault.c                         |    8 +++++---
 include/asm-i386/mach-default/mach_segment.h |    8 ++++++++
 include/asm-i386/mach-xen/mach_segment.h     |    9 +++++++++
 include/asm-i386/mach-xen/mach_system.h      |    1 +
 include/asm-i386/ptrace.h                    |    6 ++++--
 include/asm-i386/segment.h                   |    2 ++
 include/asm-i386/system.h                    |    1 +
 8 files changed, 31 insertions(+), 6 deletions(-)

diff -r 0bc9790d1ce3 arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Tue Jul 18 04:04:39 2006 -0400
+++ b/arch/i386/kernel/process.c	Tue Jul 18 04:33:57 2006 -0400
@@ -346,7 +346,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = get_kernel_cs();
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
diff -r 0bc9790d1ce3 arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c	Tue Jul 18 04:04:39 2006 -0400
+++ b/arch/i386/mm/fault.c	Tue Jul 18 04:33:57 2006 -0400
@@ -28,6 +28,8 @@
 #include <asm/desc.h>
 #include <asm/kdebug.h>
 
+#include <mach_segment.h>
+
 extern void die(const char *,struct pt_regs *,long);
 
 #ifdef CONFIG_KPROBES
@@ -119,10 +121,10 @@ static inline unsigned long get_segment_
 	}
 
 	/* The standard kernel/user address space limit. */
-	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
+	*eip_limit = (seg & USER_MODE_MASK) ? USER_DS.seg : KERNEL_DS.seg;
 	
 	/* By far the most common cases. */
-	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
+	if (likely(seg == __USER_CS || seg == get_kernel_cs()))
 		return eip;
 
 	/* Check the segment exists, is within the current LDT/GDT size,
@@ -437,7 +439,7 @@ good_area:
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
 #ifdef TEST_VERIFY_AREA
-			if (regs->cs == KERNEL_CS)
+			if (regs->cs == get_kernel_cs())
 				printk("WP fault at %08lx\n", regs->eip);
 #endif
 			/* fall through */
diff -r 0bc9790d1ce3 include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	Tue Jul 18 04:04:39 2006 -0400
+++ b/include/asm-i386/ptrace.h	Tue Jul 18 04:33:57 2006 -0400
@@ -1,5 +1,7 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H
+
+#include <mach_segment.h>
 
 #define EBX 0
 #define ECX 1
@@ -73,11 +75,11 @@ extern void send_sigtrap(struct task_str
  */
 static inline int user_mode(struct pt_regs *regs)
 {
-	return (regs->xcs & 3) != 0;
+	return (regs->xcs & USER_MODE_MASK) != 0;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+	return ((regs->xcs & USER_MODE_MASK) | (regs->eflags & VM_MASK)) != 0;
 }
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
diff -r 0bc9790d1ce3 include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Tue Jul 18 04:04:39 2006 -0400
+++ b/include/asm-i386/segment.h	Tue Jul 18 04:33:57 2006 -0400
@@ -1,5 +1,7 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
+
+#include <mach_segment.h>
 
 /*
  * The layout of the per-CPU GDT under Linux:
diff -r 0bc9790d1ce3 include/asm-i386/system.h
--- a/include/asm-i386/system.h	Tue Jul 18 04:04:39 2006 -0400
+++ b/include/asm-i386/system.h	Tue Jul 18 04:33:57 2006 -0400
@@ -487,6 +487,7 @@ static inline unsigned long long __cmpxc
 #endif
 
 #include <linux/irqflags.h>
+#include <mach_system.h>
 
 /*
  * disable hlt during certain critical i/o operations
diff -r 0bc9790d1ce3 include/asm-i386/mach-xen/mach_system.h
--- a/include/asm-i386/mach-xen/mach_system.h	Tue Jul 18 04:04:39 2006 -0400
+++ b/include/asm-i386/mach-xen/mach_system.h	Tue Jul 18 04:33:57 2006 -0400
@@ -1,5 +1,6 @@
 #ifndef __ASM_MACH_SYSTEM_H
 #define __ASM_MACH_SYSTEM_H
 
+#include <asm/hypervisor.h>
 
 #endif /* __ASM_MACH_SYSTEM_H */
diff -r 0bc9790d1ce3 include/asm-i386/mach-default/mach_segment.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_segment.h	Tue Jul 18 04:33:57 2006 -0400
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_SEGMENT_H
+#define __ASM_MACH_SEGMENT_H
+
+#define USER_MODE_MASK 3
+
+#define get_kernel_cs() __KERNEL_CS
+
+#endif /* __ASM_MACH_SEGMENT_H */
diff -r 0bc9790d1ce3 include/asm-i386/mach-xen/mach_segment.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_segment.h	Tue Jul 18 04:33:57 2006 -0400
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_SEGMENT_H
+#define __ASM_MACH_SEGMENT_H
+
+#define USER_MODE_MASK 2
+
+#define get_kernel_cs() \
+	(__KERNEL_CS + (xen_feature(XENFEAT_supervisor_mode_kernel) ? 0 : 1))
+
+#endif /* __ASM_MACH_SEGMENT_H */

--
