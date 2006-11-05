Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWKEHYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWKEHYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 02:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWKEHYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 02:24:51 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:63912 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161196AbWKEHYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 02:24:50 -0500
Date: Sun, 5 Nov 2006 02:18:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [rfc patch] i386: only restore eflags if necessary on task
  switch
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>
Message-ID: <200611050221_MC3-1-D06D-E00D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Save eflags during task switch but only restore them if the next
task has different values that affect system operation.

Original idea by Zach Amsden.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/ioport.c    |    8 ++++----
 arch/i386/kernel/process.c   |    6 +++---
 include/asm-i386/processor.h |   30 ++++++++++++++++++++----------
 include/asm-i386/system.h    |   12 +++++++-----
 4 files changed, 34 insertions(+), 22 deletions(-)

--- 2.6.19-rc4-32smp.orig/include/asm-i386/processor.h
+++ 2.6.19-rc4-32smp/include/asm-i386/processor.h
@@ -143,6 +143,12 @@ static inline void detect_ht(struct cpui
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
+/*
+ * EFLAGS bits that affect system operation
+ */
+#define X86_EFLAGS_SYSTEM ~(X86_EFLAGS_OF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
+			    X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_ZF)
+
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
@@ -449,6 +455,7 @@ struct thread_struct {
 	unsigned long	sysenter_cs;
 	unsigned long	eip;
 	unsigned long	esp;
+ 	unsigned long	eflags;
 	unsigned long	fs;
 	unsigned long	gs;
 /* Hardware debugging registers */
@@ -464,7 +471,6 @@ struct thread_struct {
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
- 	unsigned long	iopl;
 /* max allowed port in the bitmap, in bytes: */
 	unsigned long	io_bitmap_max;
 };
@@ -521,20 +527,24 @@ static inline void load_esp0(struct tss_
 			: /* no output */			\
 			:"r" (value))
 
+static inline unsigned get_eflags(void) {
+	unsigned eflags;
+
+	asm volatile ("pushfl ; popl %0" : "=g" (eflags));
+
+	return eflags;
+}
+
+static inline void set_eflags(unsigned eflags) {
+	asm volatile ("pushl %0 ; popfl" : : "g" (eflags));
+}
+
 /*
  * Set IOPL bits in EFLAGS from given mask
  */
 static inline void set_iopl_mask(unsigned mask)
 {
-	unsigned int reg;
-	__asm__ __volatile__ ("pushfl;"
-			      "popl %0;"
-			      "andl %1, %0;"
-			      "orl %2, %0;"
-			      "pushl %0;"
-			      "popfl"
-				: "=&r" (reg)
-				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+	set_eflags((get_eflags() & ~X86_EFLAGS_IOPL) | (mask & X86_EFLAGS_IOPL));
 }
 
 /* Forward declaration, a strange C thing */
--- 2.6.19-rc4-32smp.orig/arch/i386/kernel/process.c
+++ 2.6.19-rc4-32smp/arch/i386/kernel/process.c
@@ -681,10 +681,10 @@ struct task_struct fastcall * __switch_t
 		loadsegment(gs, next->gs);
 
 	/*
-	 * Restore IOPL if needed.
+	 * Restore eflags if system flags are different in next task.
 	 */
-	if (unlikely(prev->iopl != next->iopl))
-		set_iopl_mask(next->iopl);
+	if (unlikely((get_eflags() ^ next->eflags) & X86_EFLAGS_SYSTEM))
+		set_eflags(next->eflags);
 
 	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
--- 2.6.19-rc4-32smp.orig/include/asm-i386/system.h
+++ 2.6.19-rc4-32smp/include/asm-i386/system.h
@@ -14,23 +14,25 @@ extern struct task_struct * FASTCALL(__s
 /*
  * Saving eflags is important. It switches not only IOPL between tasks,
  * it also protects other tasks from NT leaking through sysenter etc.
+ * (eflags will be restored in __switch_to() only if necessary.)
  */
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
 	asm volatile("pushfl\n\t"		/* Save flags */	\
+		     "popl %2\n\t"					\
 		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
-		     "movl %5,%%esp\n\t"	/* restore ESP */	\
+		     "movl %6,%%esp\n\t"	/* restore ESP */	\
 		     "movl $1f,%1\n\t"		/* save EIP */		\
-		     "pushl %6\n\t"		/* restore EIP */	\
+		     "pushl %7\n\t"		/* restore EIP */	\
 		     "jmp __switch_to\n"				\
 		     "1:\t"						\
-		     "popl %%ebp\n\t"					\
-		     "popfl"						\
+		     "popl %%ebp"					\
 		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
+		      "=m" (prev->thread.eflags),			\
 		      "=a" (last),"=S" (esi),"=D" (edi)			\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
-		      "2" (prev), "d" (next));				\
+		      "3" (prev), "d" (next));				\
 } while (0)
 
 #define _set_base(addr,base) do { unsigned long __pr; \
--- 2.6.19-rc4-32smp.orig/arch/i386/kernel/ioport.c
+++ 2.6.19-rc4-32smp/arch/i386/kernel/ioport.c
@@ -137,7 +137,7 @@ asmlinkage long sys_iopl(unsigned long u
 	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
 	unsigned int level = regs->ebx;
 	unsigned int old = (regs->eflags >> 12) & 3;
-	struct thread_struct *t = &current->thread;
+	unsigned int iopl;
 
 	if (level > 3)
 		return -EINVAL;
@@ -146,8 +146,8 @@ asmlinkage long sys_iopl(unsigned long u
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	t->iopl = level << 12;
-	regs->eflags = (regs->eflags & ~X86_EFLAGS_IOPL) | t->iopl;
-	set_iopl_mask(t->iopl);
+	iopl = level << 12;
+	regs->eflags = (regs->eflags & ~X86_EFLAGS_IOPL) | iopl;
+	set_iopl_mask(iopl);
 	return 0;
 }
-- 
Chuck
