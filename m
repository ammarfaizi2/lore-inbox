Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWKDADU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWKDADU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWKDADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:03:20 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:11979 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932511AbWKDADT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:03:19 -0500
Date: Fri, 3 Nov 2006 19:00:12 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [rfc patch] i386: don't save eflags on task switch
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>
Message-ID: <200611031902_MC3-1-D042-CA1F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real need to save eflags in switch_to().  Instead,
we can keep a constant value in the thread_struct and always
restore that.

This will cause a behavior change, though.  If a user sets
NT in eflags and then enters the kernel via sysenter, and
another task runs before the syscall returns:

        (1) If we return via the iret path then no fault
        will occur (currently the user gets a fault.)

        (2) If we return via sysexit, NT will be cleared
        (currently it remains set.)

Users shouldn't be setting NT anyway, so this shouldn't be a
problem.

On a K8 CPU, this patch didn't lower the minimum task-switch
time, but it did lower the average and removed most of the
variability.  It really needs testing on a P4, where it should
have much more effect.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---

 arch/i386/kernel/ioport.c    |    7 ++++---
 include/asm-i386/processor.h |    5 +++--
 include/asm-i386/system.h    |    4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

--- 2.6.19-rc4-32smp.orig/arch/i386/kernel/ioport.c	2006-08-27 11:30:50.000000000 -0400
+++ 2.6.19-rc4-32smp/arch/i386/kernel/ioport.c	2006-11-02 00:46:03.925570520 -0500
@@ -146,8 +146,9 @@ asmlinkage long sys_iopl(unsigned long u
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	t->iopl = level << 12;
-	regs->eflags = (regs->eflags & ~X86_EFLAGS_IOPL) | t->iopl;
-	set_iopl_mask(t->iopl);
+	t->eflags = level << 12 | X86_EFLAGS_IF | 2;
+	regs->eflags = (regs->eflags & ~X86_EFLAGS_IOPL) |
+		       (t->eflags & X86_EFLAGS_IOPL);
+	set_iopl_mask(t->eflags);
 	return 0;
 }
--- 2.6.19-rc4-32smp.orig/include/asm-i386/processor.h	2006-11-01 22:05:55.760728595 -0500
+++ 2.6.19-rc4-32smp/include/asm-i386/processor.h	2006-11-02 00:50:06.899235722 -0500
@@ -449,6 +449,7 @@ struct thread_struct {
 	unsigned long	sysenter_cs;
 	unsigned long	eip;
 	unsigned long	esp;
+ 	unsigned long	eflags;
 	unsigned long	fs;
 	unsigned long	gs;
 /* Hardware debugging registers */
@@ -464,7 +465,6 @@ struct thread_struct {
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
- 	unsigned long	iopl;
 /* max allowed port in the bitmap, in bytes: */
 	unsigned long	io_bitmap_max;
 };
@@ -534,7 +534,8 @@ static inline void set_iopl_mask(unsigne
 			      "pushl %0;"
 			      "popfl"
 				: "=&r" (reg)
-				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+				: "i" (~X86_EFLAGS_IOPL),
+				  "r" (mask & X86_EFLAGS_IOPL));
 }
 
 /* Forward declaration, a strange C thing */
--- 2.6.19-rc4-32smp.orig/include/asm-i386/system.h	2006-11-01 22:05:55.870730255 -0500
+++ 2.6.19-rc4-32smp/include/asm-i386/system.h	2006-11-02 00:54:54.863579599 -0500
@@ -17,7 +17,7 @@ extern struct task_struct * FASTCALL(__s
  */
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
-	asm volatile("pushfl\n\t"		/* Save flags */	\
+	asm volatile("pushl %9\n\t"		/* Save flags */	\
 		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
@@ -30,7 +30,7 @@ extern struct task_struct * FASTCALL(__s
 		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
 		      "=a" (last),"=S" (esi),"=D" (edi)			\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
-		      "2" (prev), "d" (next));				\
+		      "2" (prev), "d" (next), "m" (prev->thread.eflags));				\
 } while (0)
 
 #define _set_base(addr,base) do { unsigned long __pr; \
-- 
Chuck
