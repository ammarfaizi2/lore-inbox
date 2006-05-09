Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWEIIyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWEIIyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWEIItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:21 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44675 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751534AbWEIItB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:01 -0400
Message-Id: <20060509085154.802230000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:17 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 17/35] Segment register changes for Xen
Content-Disposition: inline; filename=i386-segments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. We clear FS/GS before changing TLS entries and switching LDT, as
otherwise the hypervisor will fail to restore thread-local values on
return to the guest kernel and we take a slow exception path.

2. We allow for the fact that the guest kernel may not run in ring 0.
This requires some abstraction in a few places when setting %cs or
checking privilege level (user vs kernel).

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/process.c                   |    4 +++-
 arch/i386/mm/fault.c                         |    8 +++++---
 include/asm-i386/mach-default/mach_segment.h |    8 ++++++++
 include/asm-i386/mach-default/mach_system.h  |    2 ++
 include/asm-i386/mach-xen/mach_segment.h     |    9 +++++++++
 include/asm-i386/mach-xen/mach_system.h      |    2 ++
 include/asm-i386/mach-xen/setup_arch_post.h  |    2 ++
 include/asm-i386/ptrace.h                    |    6 ++++--
 include/asm-i386/segment.h                   |    2 ++
 9 files changed, 37 insertions(+), 6 deletions(-)

--- linus-2.6.orig/arch/i386/kernel/process.c
+++ linus-2.6/arch/i386/kernel/process.c
@@ -347,7 +347,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = get_kernel_cs();
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
@@ -647,6 +647,8 @@ struct task_struct fastcall * __switch_t
 	 */
 	savesegment(fs, prev->fs);
 	savesegment(gs, prev->gs);
+	clearsegment(fs);
+	clearsegment(gs);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
--- linus-2.6.orig/arch/i386/mm/fault.c
+++ linus-2.6/arch/i386/mm/fault.c
@@ -28,6 +28,8 @@
 #include <asm/desc.h>
 #include <asm/kdebug.h>
 
+#include <mach_segment.h>
+
 extern void die(const char *,struct pt_regs *,long);
 
 /*
@@ -78,14 +80,14 @@ static inline unsigned long get_segment_
 	u32 seg_ar, seg_limit, base, *desc;
 
 	/* The standard kernel/user address space limit. */
-	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
+	*eip_limit = (seg & USER_MODE_MASK) ? USER_DS.seg : KERNEL_DS.seg;
 
 	/* Unlikely, but must come before segment checks. */
 	if (unlikely((regs->eflags & VM_MASK) != 0))
 		return eip + (seg << 4);
 	
 	/* By far the most common cases. */
-	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
+	if (likely(seg == __USER_CS || seg == get_kernel_cs()))
 		return eip;
 
 	/* Check the segment exists, is within the current LDT/GDT size,
@@ -400,7 +402,7 @@ good_area:
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
 #ifdef TEST_VERIFY_AREA
-			if (regs->cs == KERNEL_CS)
+			if (regs->cs == get_kernel_cs())
 				printk("WP fault at %08lx\n", regs->eip);
 #endif
 			/* fall through */
--- linus-2.6.orig/include/asm-i386/mach-default/mach_system.h
+++ linus-2.6/include/asm-i386/mach-default/mach_system.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_SYSTEM_H
 #define __ASM_MACH_SYSTEM_H
 
+#define clearsegment(seg)
+
 /* interrupt control.. */
 #define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
 #define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
--- linus-2.6.orig/include/asm-i386/mach-xen/mach_system.h
+++ linus-2.6/include/asm-i386/mach-xen/mach_system.h
@@ -5,6 +5,8 @@
 
 #include <asm/hypervisor.h>
 
+#define clearsegment(seg) loadsegment(seg, 0)
+
 #ifdef CONFIG_SMP
 #define __vcpu_id smp_processor_id()
 #else
--- linus-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ linus-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -26,6 +26,8 @@ static void __init machine_specific_arch
 		(struct shared_info *)__va(xen_start_info->shared_info);
 	memset(empty_zero_page, 0, sizeof(empty_zero_page));
 
+	HYPERVISOR_vm_assist(VMASST_CMD_enable, VMASST_TYPE_4gb_segments);
+
 	HYPERVISOR_set_callbacks(
 	    __KERNEL_CS, (unsigned long)hypervisor_callback,
 	    __KERNEL_CS, (unsigned long)failsafe_callback);
--- linus-2.6.orig/include/asm-i386/ptrace.h
+++ linus-2.6/include/asm-i386/ptrace.h
@@ -1,6 +1,8 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H
 
+#include <mach_segment.h>
+
 #define EBX 0
 #define ECX 1
 #define EDX 2
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
--- linus-2.6.orig/include/asm-i386/segment.h
+++ linus-2.6/include/asm-i386/segment.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
+#include <mach_segment.h>
+
 /*
  * The layout of the per-CPU GDT under Linux:
  *
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_segment.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_SEGMENT_H
+#define __ASM_MACH_SEGMENT_H
+
+#define USER_MODE_MASK 3
+
+#define get_kernel_cs() __KERNEL_CS
+
+#endif /* __ASM_MACH_SEGMENT_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_segment.h
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
