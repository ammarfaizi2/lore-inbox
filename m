Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVKHEmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVKHEmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKHEmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:42:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:36100 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030301AbVKHEmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:42:06 -0500
Date: Mon, 7 Nov 2005 20:39:44 -0800
Message-Id: <200511080439.jA84diI6009951@zach-dev.vmware.com>
Subject: [PATCH 19/21] i386 Kprobes semaphore fix
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:39:44.0664 (UTC) FILETIME=[710B3980:01C5E41E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA-32 linear address translation is loads of fun.

While cleaning up the LDT code, I noticed that kprobes code was very bogus
with respect to segment handling.  Many, many bugs are fixed here.  I chose
to combine the three separate functions that try to do linear address
conversion into one, nice and working functions.  All of the versions had
bugs.

1) Taking an int3 from v8086 mode could cause the kprobes code to read a
   non-existent LDT.

2) The CS value was not truncated to 16 bit, which could cause an access
   beyond the bounds of the LDT.

3) The LDT was being read without taking the mm->context semaphore, which
   means bogus and or non-existent vmalloc()ed pages could be read.

4) 16-bit code segments do not truncate EIP to 16-bit, it is perfectly
   valid to issue an instruction at 0xffff, and there is no wraparound
   of EIP in protected mode.

5) V8086 mode does truncate EIP to 16-bit.

6) Taking the mm->context semaphore requires interrupts to be enabled.

7) Do not assume the GDT TLS descriptors are flat.

8) Raceful testing of segment access rights without LDT semaphore

9) Segment limit for V8086 code is USER limit.

Kprobes was still broken; it would try to read userspace directly;
since I'm already here, might as well fix that too.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/kprobes.c	2005-11-04 19:25:27.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/kprobes.c	2005-11-04 19:26:37.000000000 -0800
@@ -156,23 +156,25 @@ static int __kprobes kprobe_handler(stru
 	struct kprobe *p;
 	int ret = 0;
 	kprobe_opcode_t *addr = NULL;
-	unsigned long *lp;
+	unsigned long limit;
 
-	/* We're in an interrupt, but this is clear and BUG()-safe. */
-	preempt_disable();
-	/* Check if the application is using LDT entry for its code segment and
-	 * calculate the address by reading the base address from the LDT entry.
+	/*
+	 * Getting the address may require getting the LDT semaphore, so
+	 * wait to disable preempt since we may take interrupts here.
 	 */
-	if ((regs->xcs & 4) && (current->mm)) {
-		lp = (unsigned long *) ((unsigned long)((regs->xcs >> 3) * 8)
-					+ (char *) current->mm->context.ldt);
-		addr = (kprobe_opcode_t *) (get_desc_base(lp) + regs->eip -
-						sizeof(kprobe_opcode_t));
-	} else {
-		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
-	}
-	/* Check we're not actually recursing */
-	if (kprobe_running()) {
+	addr = (kprobe_opcode_t *)convert_eip_to_linear(regs,
+					regs->eip - sizeof(kprobe_opcode_t),
+					&current->mm->context, &limit);
+
+	/* Don't let userspace races re-address into kernel space */
+	if ((unsigned long)addr > limit)
+		return 0;
+
+ 	/* We're in an interrupt, but this is clear and BUG()-safe. */
+ 	preempt_disable();
+
+  	/* Check we're not actually recursing */
+  	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
@@ -209,13 +211,20 @@ static int __kprobes kprobe_handler(stru
 	lock_kprobes();
 	p = get_kprobe(addr);
 	if (!p) {
+		unsigned char instr;
 		unlock_kprobes();
 		if (regs->eflags & VM_MASK) {
 			/* We are in virtual-8086 mode. Return 0 */
 			goto no_kprobe;
 		}
 
-		if (*addr != BREAKPOINT_INSTRUCTION) {
+		instr = BREAKPOINT_INSTRUCTION;
+		if (user_mode(regs))
+			__get_user(instr, (unsigned char __user *) addr);
+		else
+			instr = *addr;
+			
+		if (instr != BREAKPOINT_INSTRUCTION) {
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
Index: linux-2.6.14-zach-work/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/ptrace.c	2005-11-04 19:25:27.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/ptrace.c	2005-11-04 19:26:37.000000000 -0800
@@ -146,46 +146,76 @@ static unsigned long getreg(struct task_
 	return retval;
 }
 
-static unsigned long convert_eip_to_linear(struct task_struct *child, struct pt_regs *regs)
+/*
+ * Get the GDT/LDT descriptor base.  When you look for races in this code
+ * remember that LDT and other horrors are only used in user space.  Must
+ * disable pre-emption to reading the GDT, and must take the LDT semaphore
+ * for LDT segments.  The fast path handles standard kernel and user CS
+ * as well as V8086 mode.
+ */
+unsigned long convert_eip_to_linear_slow(unsigned long eip, unsigned long seg,
+ 	mm_context_t *context, unsigned long *eip_limit)
 {
-	unsigned long addr, seg;
+	unsigned long base, seg_limit;
+ 	u32 seg_ar;
+	struct desc_struct *desc;
+	unsigned long flags;
 
-	addr = regs->eip;
-	seg = regs->xcs & 0xffff;
-	if (regs->eflags & VM_MASK) {
-		addr = (addr & 0xffff) + (seg << 4);
-		return addr;
+	if (segment_from_ldt(seg)) {
+		/*
+		 * Horrors abound.  Must enable IRQs to take the LDT
+		 * semaphore.  Ok, since LDT from a faulting CS can only
+		 * be from userspace, or this is from ptrace operating
+		 * on a child context directly from a system call.
+		 * This unfortunate mess is needed to deal with int3
+		 * kprobes which enter with IRQs disabled.
+		 */
+		local_save_flags(flags);
+		local_irq_enable();
+		down(&context->sem);
+		desc = get_ldt_desc(context, seg);
+	} else {
+		/* Must disable preemption while reading the GDT. */
+ 		desc = get_gdt_desc(get_cpu(), seg);
+		flags = 0; /* silence compiler */
 	}
 
-	/*
-	 * We'll assume that the code segments in the GDT
-	 * are all zero-based. That is largely true: the
-	 * TLS segments are used for data, and the PNPBIOS
-	 * and APM bios ones we just ignore here.
-	 */
-	if (seg & LDT_SEGMENT) {
-		u32 *desc;
-		unsigned long base;
-
-		down(&child->mm->context.sem);
-		desc = child->mm->context.ldt + (seg & ~7);
-		base = (desc[0] >> 16) | ((desc[1] & 0xff) << 16) | (desc[1] & 0xff000000);
-
-		/* 16-bit code segment? */
-		if (!((desc[1] >> 22) & 1))
-			addr &= 0xffff;
-		addr += base;
-		up(&child->mm->context.sem);
+	/* Check the segment exists, is within the current LDT/GDT size,
+	   that kernel/user (ring 0..3) has the appropriate privilege,
+	   that it's a code segment, and get the limit. */
+	asm ("larl %3,%0; lsll %3,%1"
+		 : "=&r" (seg_ar), "=r" (seg_limit) : "0" (0), "rm" (seg));
+	if ((~seg_ar & 0x9800) || eip > seg_limit) {
+		if (eip_limit)
+			*eip_limit = 0;
+		eip = 1;	 /* So that returned eip > *eip_limit. */
+		base = 0;
+	} else {
+		base = get_desc_base(desc);
+		eip += base;
+		seg_limit += base;
+	}
+
+	if (segment_from_ldt(seg)) {
+		up(&context->sem);
+		local_irq_restore(flags);
+	} else {
+		put_cpu();
 	}
-	return addr;
+
+	/* Adjust EIP and segment limit, and clamp at the kernel limit.
+	   It's legitimate for segments to wrap at 0xffffffff. */
+	if (eip_limit && seg_limit < *eip_limit && seg_limit >= base)
+		*eip_limit = seg_limit;
+
+	return eip;
 }
 
 static inline int is_at_popf(struct task_struct *child, struct pt_regs *regs)
 {
 	int i, copied;
 	unsigned char opcode[16];
-	unsigned long addr = convert_eip_to_linear(child, regs);
-
+ 	unsigned long addr = convert_eip_to_linear(regs, regs->eip, &child->mm->context, NULL);
 	copied = access_process_vm(child, addr, opcode, sizeof(opcode), 0);
 	for (i = 0; i < copied; i++) {
 		switch (opcode[i]) {
Index: linux-2.6.14-zach-work/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/mm/fault.c	2005-11-04 19:25:27.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/mm/fault.c	2005-11-04 19:26:37.000000000 -0800
@@ -56,77 +56,6 @@ void bust_spinlocks(int yes)
 	console_loglevel = loglevel_save;
 }
 
-/*
- * Return EIP plus the CS segment base.  The segment limit is also
- * adjusted, clamped to the kernel/user address space (whichever is
- * appropriate), and returned in *eip_limit.
- *
- * The segment is checked, because it might have been changed by another
- * task between the original faulting instruction and here.
- *
- * If CS is no longer a valid code segment, or if EIP is beyond the
- * limit, or if it is a kernel address when CS is not a kernel segment,
- * then the returned value will be greater than *eip_limit.
- * 
- * This is slow, but is very rarely executed.
- */
-static inline unsigned long get_segment_eip(struct pt_regs *regs,
-					    unsigned long *eip_limit)
-{
-	unsigned long eip = regs->eip;
-	unsigned seg = regs->xcs & 0xffff;
-	u32 seg_ar, seg_limit, base, *desc;
-
-	/* The standard kernel/user address space limit. */
-	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
-
-	/* Unlikely, but must come before segment checks. */
-	if (unlikely((regs->eflags & VM_MASK) != 0))
-		return eip + (seg << 4);
-	
-	/* By far the most common cases. */
-	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
-		return eip;
-
-	/* Check the segment exists, is within the current LDT/GDT size,
-	   that kernel/user (ring 0..3) has the appropriate privilege,
-	   that it's a code segment, and get the limit. */
-	__asm__ ("larl %3,%0; lsll %3,%1"
-		 : "=&r" (seg_ar), "=r" (seg_limit) : "0" (0), "rm" (seg));
-	if ((~seg_ar & 0x9800) || eip > seg_limit) {
-		*eip_limit = 0;
-		return 1;	 /* So that returned eip > *eip_limit. */
-	}
-
-	/* Get the GDT/LDT descriptor base. 
-	   When you look for races in this code remember that
-	   LDT and other horrors are only used in user space. */
-	if (seg & (1<<2)) {
-		/* Must lock the LDT while reading it. */
-		down(&current->mm->context.sem);
-		desc = current->mm->context.ldt;
-		desc = (void *)desc + (seg & ~7);
-	} else {
-		/* Must disable preemption while reading the GDT. */
- 		desc = (u32 *)get_cpu_gdt_table(get_cpu());
-		desc = (void *)desc + (seg & ~7);
-	}
-
-	/* Decode the code segment base from the descriptor */
-	base = get_desc_base(desc);
-
-	if (seg & (1<<2)) { 
-		up(&current->mm->context.sem);
-	} else
-		put_cpu();
-
-	/* Adjust EIP and segment limit, and clamp at the kernel limit.
-	   It's legitimate for segments to wrap at 0xffffffff. */
-	seg_limit += base;
-	if (seg_limit < *eip_limit && seg_limit >= base)
-		*eip_limit = seg_limit;
-	return eip + base;
-}
 
 /* 
  * Sometimes AMD Athlon/Opteron CPUs report invalid exceptions on prefetch.
@@ -135,7 +64,8 @@ static inline unsigned long get_segment_
 static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
 { 
 	unsigned long limit;
-	unsigned long instr = get_segment_eip (regs, &limit);
+	unsigned long instr = convert_eip_to_linear (regs, regs->eip,
+				&current->mm->context, &limit);
 	int scan_more = 1;
 	int prefetch = 0; 
 	int i;
Index: linux-2.6.14-zach-work/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/ptrace.h	2005-11-04 19:25:27.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/ptrace.h	2005-11-04 19:26:37.000000000 -0800
@@ -54,9 +54,11 @@ struct pt_regs {
 #define PTRACE_GET_THREAD_AREA    25
 #define PTRACE_SET_THREAD_AREA    26
 
-#ifdef __KERNEL__
+#if defined(__KERNEL__) && !defined(__arch_um__)
 
 #include <asm/vm86.h>
+#include <asm/mmu.h>
+#include <asm/uaccess.h>
 
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
@@ -82,6 +84,45 @@ extern unsigned long profile_pc(struct p
 #else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
-#endif /* __KERNEL__ */
+
+/*
+ * Return EIP plus the CS segment base.  The segment limit is also
+ * adjusted, clamped to the kernel/user address space (whichever is
+ * appropriate), and returned in *eip_limit.
+ *
+ * The segment is checked, because it might have been changed by another
+ * task between the original faulting instruction and here.
+ *
+ * If CS is no longer a valid code segment, or if EIP is beyond the
+ * limit, or if it is a kernel address when CS is not a kernel segment,
+ * then the returned value will be greater than *eip_limit.
+ * 
+ * This is slow, but is very rarely executed.
+ */
+extern unsigned long convert_eip_to_linear_slow(unsigned long addr, unsigned long seg, mm_context_t *context, unsigned long *eip_limit);
+
+static inline unsigned long convert_eip_to_linear(struct pt_regs *regs, unsigned long addr, mm_context_t *context, unsigned long * const eip_limit)
+{
+	unsigned long seg;
+
+	seg = regs->xcs & 0xffff;
+
+	/* The standard kernel/user address space limit. */
+	if (eip_limit)
+		*eip_limit = user_mode(regs) ? USER_DS.seg : KERNEL_DS.seg;
+
+	if (regs->eflags & VM_MASK) {
+		addr = (addr & 0xffff) + (seg << 4);
+		return addr;
+	}
+
+	/* By far the most common cases. */
+	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
+		return addr;
+
+	return convert_eip_to_linear_slow(addr, seg, context, eip_limit);
+}
+
+#endif /* defined(__KERNEL__) && !defined(__arch_um__) */
 
 #endif
