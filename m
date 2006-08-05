Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161410AbWHEFqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWHEFqD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 01:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWHEFqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 01:46:03 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:931 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161410AbWHEFqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 01:46:02 -0400
Date: Sat, 5 Aug 2006 01:40:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 3/8] Allow a kernel to not be in ring 0.
To: Zachary Amsden <zach@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Xen-devel <xen-devel@lists.xensource.com>,
       virtualization <virtualization@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Message-ID: <200608050143_MC3-1-C721-98E2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44D41DEF.7040301@vmware.com>

On Fri, 04 Aug 2006 21:26:23 -0700, Zachary Amsden wrote:
>
> These changes look great.  Ack-ed.

I re-did it as a patch on top of the original so it's easier to see
what I changed.  Also added macros for table indicator.




Clean up of patch for letting kernel run other than ring 0:

a. Add some comments about the SEGMENT_IS_*_CODE() macros.
b. Add a USER_RPL macro.  (Code was comparing a value to a mask
   in some places and to the magic number 3 in other places.)
c. Add macros for table indicator field and use them.
d. Change the entry.S tests for LDT stack segment to use the macros.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Acked-by: Zachary Amsden <zach@vmware.com>

 arch/i386/kernel/entry.S   |    6 +++---
 include/asm-i386/ptrace.h  |    4 ++--
 include/asm-i386/segment.h |   17 ++++++++++++-----
 3 files changed, 17 insertions(+), 10 deletions(-)

--- 2.6.18-rc3-32.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc3-32/arch/i386/kernel/entry.S
@@ -230,7 +230,7 @@ check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
-	cmpl $SEGMENT_RPL_MASK, %eax
+	cmpl $USER_RPL, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
@@ -368,8 +368,8 @@ restore_all:
 	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
-	andl $(VM_MASK | (4 << 8) | 3), %eax
-	cmpl $((4 << 8) | 3), %eax
+	andl $(VM_MASK | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
+	cmpl $((SEGMENT_LDT << 8) | USER_RPL), %eax
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
--- 2.6.18-rc3-32.orig/include/asm-i386/ptrace.h
+++ 2.6.18-rc3-32/include/asm-i386/ptrace.h
@@ -74,11 +74,11 @@ extern void send_sigtrap(struct task_str
  */
 static inline int user_mode(struct pt_regs *regs)
 {
-	return (regs->xcs & SEGMENT_RPL_MASK) == 3;
+	return (regs->xcs & SEGMENT_RPL_MASK) == USER_RPL;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return (((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >= 3);
+	return ((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >= USER_RPL;
 }
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
--- 2.6.18-rc3-32.orig/include/asm-i386/segment.h
+++ 2.6.18-rc3-32/include/asm-i386/segment.h
@@ -83,10 +83,9 @@
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
-/*
- * Some tricky tests to match code segments after a fault
- */
+/* Matches __KERNEL_CS and __USER_CS (they must be 2 entries apart) */
 #define SEGMENT_IS_FLAT_CODE(x)  (((x) & 0xec) == GDT_ENTRY_KERNEL_CS * 8)
+/* Matches PNP_CS32 and PNP_CS16 (they must be consecutive) */
 #define SEGMENT_IS_PNP_CODE(x)   (((x) & 0xf4) == GDT_ENTRY_PNPBIOS_BASE * 8)
 
 /* Simple and small GDT entries for booting only */
@@ -118,8 +117,16 @@
  */
 #define IDT_ENTRIES 256
 
-/* Bottom three bits of xcs give the ring privilege level */
-#define SEGMENT_RPL_MASK 0x3
+/* Bottom two bits of selector give the ring privilege level */
+#define SEGMENT_RPL_MASK	0x3
+/* Bit 2 is table indicator (LDT/GDT) */
+#define SEGMENT_TI_MASK		0x4
+
+/* User mode is privilege level 3 */
+#define USER_RPL		0x3
+/* LDT segment has TI set, GDT has it cleared */
+#define SEGMENT_LDT		0x4
+#define SEGMENT_GDT		0x0
 
 #define get_kernel_rpl()  0
 #endif
-- 
Chuck
