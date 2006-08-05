Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWHEAsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWHEAsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 20:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWHEAsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 20:48:33 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:40876 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1422685AbWHEAsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 20:48:32 -0400
Date: Fri, 4 Aug 2006 20:41:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 3/8] Allow a kernel to not be in ring 0.
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Message-ID: <200608042045_MC3-1-C721-8608@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060803002518.190834642@xensource.com>

On Wed, 02 Aug 2006 17:25:13 -0700, Jeremy Fitzhardinge wrote:

> We allow for the fact that the guest kernel may not run in ring 0.
> This requires some abstraction in a few places when setting %cs or
> checking privilege level (user vs kernel).

I made some changes:

a. Added some comments about the SEGMENT_IS_*_CODE() macros.
b. Added a USER_RPL macro.  (You were comparing a value to a mask
   in some places and to the magic number 3 in other places.)
c. Changed the entry.S tests for LDT stack segment to use the macros.



From: Jeremy Fitzhardinge <jeremy@xensource.com>

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
3) Use USER_RPL macro instead of hardcoded 3

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/entry.S   |    9 +++++----
 arch/i386/kernel/process.c |    2 +-
 arch/i386/mm/extable.c     |    2 +-
 arch/i386/mm/fault.c       |   11 ++++-------
 include/asm-i386/ptrace.h  |    5 +++--
 include/asm-i386/segment.h |   12 ++++++++++++
 6 files changed, 26 insertions(+), 15 deletions(-)

--- 2.6.18-rc3-32.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc3-32/arch/i386/kernel/entry.S
@@ -229,8 +229,9 @@ ret_from_intr:
 check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernel
+	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
+	cmpl $USER_RPL, %eax
+	jb resume_kernel		# not returning to v8086 or userspace
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -367,8 +368,8 @@ restore_all:
 	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
-	andl $(VM_MASK | (4 << 8) | 3), %eax
-	cmpl $((4 << 8) | 3), %eax
+	andl $(VM_MASK | (4 << 8) | SEGMENT_RPL_MASK), %eax
+	cmpl $((4 << 8) | USER_RPL), %eax
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
--- 2.6.18-rc3-32.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc3-32/arch/i386/kernel/process.c
@@ -346,7 +346,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = __KERNEL_CS | get_kernel_rpl();
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
--- 2.6.18-rc3-32.orig/arch/i386/mm/extable.c
+++ 2.6.18-rc3-32/arch/i386/mm/extable.c
@@ -11,7 +11,7 @@ int fixup_exception(struct pt_regs *regs
 	const struct exception_table_entry *fixup;
 
 #ifdef CONFIG_PNPBIOS
-	if (unlikely((regs->xcs & ~15) == (GDT_ENTRY_PNPBIOS_BASE << 3)))
+	if (unlikely(SEGMENT_IS_PNP_CODE(regs->xcs)))
 	{
 		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
 		extern u32 pnp_bios_is_utter_crap;
--- 2.6.18-rc3-32.orig/arch/i386/mm/fault.c
+++ 2.6.18-rc3-32/arch/i386/mm/fault.c
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
--- 2.6.18-rc3-32.orig/include/asm-i386/ptrace.h
+++ 2.6.18-rc3-32/include/asm-i386/ptrace.h
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
+	return (regs->xcs & SEGMENT_RPL_MASK) == USER_RPL;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+	return ((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >= USER_RPL;
 }
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
--- 2.6.18-rc3-32.orig/include/asm-i386/segment.h
+++ 2.6.18-rc3-32/include/asm-i386/segment.h
@@ -83,6 +83,11 @@
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
+/* Matches __KERNEL_CS and __USER_CS (they must be 2 entries apart) */
+#define SEGMENT_IS_FLAT_CODE(x)  (((x) & 0xec) == GDT_ENTRY_KERNEL_CS * 8)
+/* Matches PNP_CS32 and PNP_CS16 (they must be consecutive) */
+#define SEGMENT_IS_PNP_CODE(x)   (((x) & 0xf4) == GDT_ENTRY_PNPBIOS_BASE * 8)
+
 /* Simple and small GDT entries for booting only */
 
 #define GDT_ENTRY_BOOT_CS		2
@@ -112,4 +117,11 @@
  */
 #define IDT_ENTRIES 256
 
+/* Bottom three bits of xcs give the ring privilege level */
+#define SEGMENT_RPL_MASK	0x3
+
+/* User mode is privilege level 3 */
+#define USER_RPL		0x3
+
+#define get_kernel_rpl()  0
 #endif
-- 
Chuck
