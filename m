Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWHCA0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWHCA0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWHCAZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:55 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:44249 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750911AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002518.190834642@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:13 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Subject: [patch 3/8] Allow a kernel to not be in ring 0.
Content-Disposition: inline; filename=003-remove-ring0-assumptions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We allow for the fact that the guest kernel may not run in ring 0.
This requires some abstraction in a few places when setting %cs or
checking privilege level (user vs kernel).

This is Chris' [RFC PATCH 15/33] move segment checks to subarch,
except rather than using #define USER_MODE_MASK which depends on a
config option, we use Zach's more flexible approach of assuming ring 3
== userspace.  I also used "get_kernel_rpl()" over "get_kernel_cs()"
because I think it reads better in the code...

1) Remove the hardcoded 3 and introduce #define SEGMENT_RPL_MASK 3
2) Add a get_kernel_rpl() macro, and don't assume it's zero.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/entry.S   |    5 +++--
 arch/i386/kernel/process.c |    2 +-
 arch/i386/mm/extable.c     |    2 +-
 arch/i386/mm/fault.c       |   11 ++++-------
 include/asm-i386/ptrace.h  |    5 +++--
 include/asm-i386/segment.h |   10 ++++++++++
 6 files changed, 22 insertions(+), 13 deletions(-)


===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -229,8 +229,9 @@ check_userspace:
 check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernel
+	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
+	cmpl $SEGMENT_RPL_MASK, %eax
+	jb resume_kernel		# not returning to v8086 or userspace
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
===================================================================
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -346,7 +346,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = __KERNEL_CS | get_kernel_rpl();
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
===================================================================
--- a/arch/i386/mm/extable.c
+++ b/arch/i386/mm/extable.c
@@ -11,7 +11,7 @@ int fixup_exception(struct pt_regs *regs
 	const struct exception_table_entry *fixup;
 
 #ifdef CONFIG_PNPBIOS
-	if (unlikely((regs->xcs & ~15) == (GDT_ENTRY_PNPBIOS_BASE << 3)))
+	if (unlikely(SEGMENT_IS_PNP_CODE(regs->xcs)))
 	{
 		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
 		extern u32 pnp_bios_is_utter_crap;
===================================================================
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -27,6 +27,7 @@
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 #include <asm/kdebug.h>
+#include <asm/segment.h>
 
 extern void die(const char *,struct pt_regs *,long);
 
@@ -119,10 +120,10 @@ static inline unsigned long get_segment_
 	}
 
 	/* The standard kernel/user address space limit. */
-	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
+	*eip_limit = user_mode(regs) ? USER_DS.seg : KERNEL_DS.seg;
 	
 	/* By far the most common cases. */
-	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
+	if (likely(SEGMENT_IS_FLAT_CODE(seg)))
 		return eip;
 
 	/* Check the segment exists, is within the current LDT/GDT size,
@@ -436,11 +437,7 @@ good_area:
 	write = 0;
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
-#ifdef TEST_VERIFY_AREA
-			if (regs->cs == KERNEL_CS)
-				printk("WP fault at %08lx\n", regs->eip);
-#endif
-			/* fall through */
+				/* fall through */
 		case 2:		/* write, not present */
 			if (!(vma->vm_flags & VM_WRITE))
 				goto bad_area;
===================================================================
--- a/include/asm-i386/ptrace.h
+++ b/include/asm-i386/ptrace.h
@@ -60,6 +60,7 @@ struct pt_regs {
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
+#include <asm/segment.h>
 
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
@@ -73,11 +74,11 @@ extern void send_sigtrap(struct task_str
  */
 static inline int user_mode(struct pt_regs *regs)
 {
-	return (regs->xcs & 3) != 0;
+	return (regs->xcs & SEGMENT_RPL_MASK) == 3;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+	return (((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >= 3);
 }
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
===================================================================
--- a/include/asm-i386/segment.h
+++ b/include/asm-i386/segment.h
@@ -83,6 +83,12 @@
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
+/*
+ * Some tricky tests to match code segments after a fault
+ */
+#define SEGMENT_IS_FLAT_CODE(x)  (((x) & 0xec) == GDT_ENTRY_KERNEL_CS * 8)
+#define SEGMENT_IS_PNP_CODE(x)   (((x) & 0xf4) == GDT_ENTRY_PNPBIOS_BASE * 8)
+
 /* Simple and small GDT entries for booting only */
 
 #define GDT_ENTRY_BOOT_CS		2
@@ -112,4 +118,8 @@
  */
 #define IDT_ENTRIES 256
 
+/* Bottom three bits of xcs give the ring privilege level */
+#define SEGMENT_RPL_MASK 0x3
+
+#define get_kernel_rpl()  0
 #endif

--

