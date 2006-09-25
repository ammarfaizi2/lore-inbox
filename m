Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWIYUOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWIYUOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWIYUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:14:29 -0400
Received: from 17.sub-70-199-97.myvzw.com ([70.199.97.17]:46239 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751058AbWIYUOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:14:19 -0400
Message-Id: <20060925184638.888070606@goop.org>
References: <20060925184540.601971833@goop.org>
User-Agent: quilt/0.45-1
Date: Mon, 25 Sep 2006 11:45:44 -0700
From: jeremy@goop.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Jason Baron <jbaron@redhat.com>, Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 4/6] Update sys_vm86 to cope with changed pt_regs and %gs usage.
Content-Disposition: inline; filename=pda/i386-pda-fix-vm86.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_vm86 uses a struct kernel_vm86_regs, which is identical to
pt_regs, but adds an extra space for all the segment registers.
Previously this structure was completely independent, so changes in
pt_regs had to be reflected in kernel_vm86_regs.  This changes just
embeds pt_regs in kernel_vm86_regs, and makes the appropriate changes
to vm86.c to deal with the new naming.

Also, since %gs is dealt with differently in the kernel, this change
adjusts vm86.c to reflect this.

While making these changes, I also cleaned up some frankly bizarre
code which was added when auditing was added to sys_vm86.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jason Baron <jbaron@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/vm86.c |  125 ++++++++++++++++++++++++++++-------------------
 include/asm-i386/vm86.h |   17 ------
 2 files changed, 78 insertions(+), 64 deletions(-)

diff -r 448ac068c03f arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	Sun Sep 24 19:26:47 2006 -0700
+++ b/arch/i386/kernel/vm86.c	Sun Sep 24 19:26:50 2006 -0700
@@ -43,6 +43,7 @@
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
 #include <linux/audit.h>
+#include <linux/stddef.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -72,10 +73,10 @@
 /*
  * 8- and 16-bit register defines..
  */
-#define AL(regs)	(((unsigned char *)&((regs)->eax))[0])
-#define AH(regs)	(((unsigned char *)&((regs)->eax))[1])
-#define IP(regs)	(*(unsigned short *)&((regs)->eip))
-#define SP(regs)	(*(unsigned short *)&((regs)->esp))
+#define AL(regs)	(((unsigned char *)&((regs)->pt.eax))[0])
+#define AH(regs)	(((unsigned char *)&((regs)->pt.eax))[1])
+#define IP(regs)	(*(unsigned short *)&((regs)->pt.eip))
+#define SP(regs)	(*(unsigned short *)&((regs)->pt.esp))
 
 /*
  * virtual flags (16 and 32-bit versions)
@@ -89,10 +90,37 @@
 #define SAFE_MASK	(0xDD5)
 #define RETURN_MASK	(0xDFF)
 
-#define VM86_REGS_PART2 orig_eax
-#define VM86_REGS_SIZE1 \
-        ( (unsigned)( & (((struct kernel_vm86_regs *)0)->VM86_REGS_PART2) ) )
-#define VM86_REGS_SIZE2 (sizeof(struct kernel_vm86_regs) - VM86_REGS_SIZE1)
+/* convert kernel_vm86_regs to vm86_regs */
+static int copy_vm86_regs_to_user(struct vm86_regs __user *user,
+				  const struct kernel_vm86_regs *regs)
+{
+	int ret = 0;
+
+	/* kernel_vm86_regs is missing xfs, so copy everything up to
+	   (but not including) xgs, and then rest after xgs. */
+	ret += copy_to_user(user, regs, offsetof(struct kernel_vm86_regs, pt.xgs));
+	ret += copy_to_user(&user->__null_gs, &regs->pt.xgs,
+			    sizeof(struct kernel_vm86_regs) -
+			    offsetof(struct kernel_vm86_regs, pt.xgs));
+
+	return ret;
+}
+
+/* convert vm86_regs to kernel_vm86_regs */
+static int copy_vm86_regs_from_user(struct kernel_vm86_regs *regs,
+				    const struct vm86_regs __user *user,
+				    unsigned extra)
+{
+	int ret = 0;
+
+	ret += copy_from_user(regs, user, offsetof(struct kernel_vm86_regs, pt.xgs));
+	ret += copy_from_user(&regs->pt.xgs, &user->__null_gs,
+			      sizeof(struct kernel_vm86_regs) -
+			      offsetof(struct kernel_vm86_regs, pt.xgs) +
+			      extra);
+
+	return ret;
+}
 
 struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
 struct pt_regs * fastcall save_v86_state(struct kernel_vm86_regs * regs)
@@ -112,10 +140,8 @@ struct pt_regs * fastcall save_v86_state
 		printk("no vm86_info: BAD\n");
 		do_exit(SIGSEGV);
 	}
-	set_flags(regs->eflags, VEFLAGS, VIF_MASK | current->thread.v86mask);
-	tmp = copy_to_user(&current->thread.vm86_info->regs,regs, VM86_REGS_SIZE1);
-	tmp += copy_to_user(&current->thread.vm86_info->regs.VM86_REGS_PART2,
-		&regs->VM86_REGS_PART2, VM86_REGS_SIZE2);
+	set_flags(regs->pt.eflags, VEFLAGS, VIF_MASK | current->thread.v86mask);
+	tmp = copy_vm86_regs_to_user(&current->thread.vm86_info->regs,regs);
 	tmp += put_user(current->thread.screen_bitmap,&current->thread.vm86_info->screen_bitmap);
 	if (tmp) {
 		printk("vm86: could not access userspace vm86_info\n");
@@ -129,9 +155,11 @@ struct pt_regs * fastcall save_v86_state
 	current->thread.saved_esp0 = 0;
 	put_cpu();
 
+	ret = KVM86->regs32;
+
 	loadsegment(fs, current->thread.saved_fs);
-	loadsegment(gs, current->thread.saved_gs);
-	ret = KVM86->regs32;
+	ret->xgs = current->thread.saved_gs;
+
 	return ret;
 }
 
@@ -183,9 +211,9 @@ asmlinkage int sys_vm86old(struct pt_reg
 	tsk = current;
 	if (tsk->thread.saved_esp0)
 		goto out;
-	tmp  = copy_from_user(&info, v86, VM86_REGS_SIZE1);
-	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
-		(long)&info.vm86plus - (long)&info.regs.VM86_REGS_PART2);
+	tmp = copy_vm86_regs_from_user(&info.regs, &v86->regs,
+				       offsetof(struct kernel_vm86_struct, vm86plus) -
+				       sizeof(info.regs));
 	ret = -EFAULT;
 	if (tmp)
 		goto out;
@@ -233,9 +261,9 @@ asmlinkage int sys_vm86(struct pt_regs r
 	if (tsk->thread.saved_esp0)
 		goto out;
 	v86 = (struct vm86plus_struct __user *)regs.ecx;
-	tmp  = copy_from_user(&info, v86, VM86_REGS_SIZE1);
-	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
-		(long)&info.regs32 - (long)&info.regs.VM86_REGS_PART2);
+	tmp = copy_vm86_regs_from_user(&info.regs, &v86->regs,
+				       offsetof(struct kernel_vm86_struct, regs32) -
+				       sizeof(info.regs));
 	ret = -EFAULT;
 	if (tmp)
 		goto out;
@@ -252,15 +280,15 @@ static void do_sys_vm86(struct kernel_vm
 static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_struct *tsk)
 {
 	struct tss_struct *tss;
-	long eax;
 /*
  * make sure the vm86() system call doesn't try to do anything silly
  */
-	info->regs.__null_ds = 0;
-	info->regs.__null_es = 0;
-
-/* we are clearing fs,gs later just before "jmp resume_userspace",
- * because starting with Linux 2.1.x they aren't no longer saved/restored
+	info->regs.pt.xds = 0;
+	info->regs.pt.xes = 0;
+	info->regs.pt.xgs = 0;
+
+/* we are clearing fs later just before "jmp resume_userspace",
+ * because it is not saved/restored.
  */
 
 /*
@@ -268,10 +296,10 @@ static void do_sys_vm86(struct kernel_vm
  * has set it up safely, so this makes sure interrupt etc flags are
  * inherited from protected mode.
  */
- 	VEFLAGS = info->regs.eflags;
-	info->regs.eflags &= SAFE_MASK;
-	info->regs.eflags |= info->regs32->eflags & ~SAFE_MASK;
-	info->regs.eflags |= VM_MASK;
+ 	VEFLAGS = info->regs.pt.eflags;
+	info->regs.pt.eflags &= SAFE_MASK;
+	info->regs.pt.eflags |= info->regs32->eflags & ~SAFE_MASK;
+	info->regs.pt.eflags |= VM_MASK;
 
 	switch (info->cpu_type) {
 		case CPU_286:
@@ -294,7 +322,7 @@ static void do_sys_vm86(struct kernel_vm
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
 	savesegment(fs, tsk->thread.saved_fs);
-	savesegment(gs, tsk->thread.saved_gs);
+	tsk->thread.saved_gs = info->regs32->xgs;
 
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
@@ -306,19 +334,18 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
-	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
-	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
 
 	/*call audit_syscall_exit since we do not exit via the normal paths */
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(AUDITSC_RESULT(eax), eax);
+		audit_syscall_exit(AUDITSC_RESULT(0), 0);
 
 	__asm__ __volatile__(
 		"movl %0,%%esp\n\t"
 		"movl %1,%%ebp\n\t"
+		"mov  %2, %%fs\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (task_thread_info(tsk)));
+		:"r" (&info->regs), "r" (task_thread_info(tsk)), "r" (0));
 	/* we never return here */
 }
 
@@ -348,12 +375,12 @@ static inline void clear_IF(struct kerne
 
 static inline void clear_TF(struct kernel_vm86_regs * regs)
 {
-	regs->eflags &= ~TF_MASK;
+	regs->pt.eflags &= ~TF_MASK;
 }
 
 static inline void clear_AC(struct kernel_vm86_regs * regs)
 {
-	regs->eflags &= ~AC_MASK;
+	regs->pt.eflags &= ~AC_MASK;
 }
 
 /* It is correct to call set_IF(regs) from the set_vflags_*
@@ -370,7 +397,7 @@ static inline void set_vflags_long(unsig
 static inline void set_vflags_long(unsigned long eflags, struct kernel_vm86_regs * regs)
 {
 	set_flags(VEFLAGS, eflags, current->thread.v86mask);
-	set_flags(regs->eflags, eflags, SAFE_MASK);
+	set_flags(regs->pt.eflags, eflags, SAFE_MASK);
 	if (eflags & IF_MASK)
 		set_IF(regs);
 	else
@@ -380,7 +407,7 @@ static inline void set_vflags_short(unsi
 static inline void set_vflags_short(unsigned short flags, struct kernel_vm86_regs * regs)
 {
 	set_flags(VFLAGS, flags, current->thread.v86mask);
-	set_flags(regs->eflags, flags, SAFE_MASK);
+	set_flags(regs->pt.eflags, flags, SAFE_MASK);
 	if (flags & IF_MASK)
 		set_IF(regs);
 	else
@@ -389,7 +416,7 @@ static inline void set_vflags_short(unsi
 
 static inline unsigned long get_vflags(struct kernel_vm86_regs * regs)
 {
-	unsigned long flags = regs->eflags & RETURN_MASK;
+	unsigned long flags = regs->pt.eflags & RETURN_MASK;
 
 	if (VEFLAGS & VIF_MASK)
 		flags |= IF_MASK;
@@ -493,7 +520,7 @@ static void do_int(struct kernel_vm86_re
 	unsigned long __user *intr_ptr;
 	unsigned long segoffs;
 
-	if (regs->cs == BIOSSEG)
+	if (regs->pt.xcs == BIOSSEG)
 		goto cannot_handle;
 	if (is_revectored(i, &KVM86->int_revectored))
 		goto cannot_handle;
@@ -505,9 +532,9 @@ static void do_int(struct kernel_vm86_re
 	if ((segoffs >> 16) == BIOSSEG)
 		goto cannot_handle;
 	pushw(ssp, sp, get_vflags(regs), cannot_handle);
-	pushw(ssp, sp, regs->cs, cannot_handle);
+	pushw(ssp, sp, regs->pt.xcs, cannot_handle);
 	pushw(ssp, sp, IP(regs), cannot_handle);
-	regs->cs = segoffs >> 16;
+	regs->pt.xcs = segoffs >> 16;
 	SP(regs) -= 6;
 	IP(regs) = segoffs & 0xffff;
 	clear_TF(regs);
@@ -524,7 +551,7 @@ int handle_vm86_trap(struct kernel_vm86_
 	if (VMPI.is_vm86pus) {
 		if ( (trapno==3) || (trapno==1) )
 			return_to_32bit(regs, VM86_TRAP + (trapno << 8));
-		do_int(regs, trapno, (unsigned char __user *) (regs->ss << 4), SP(regs));
+		do_int(regs, trapno, (unsigned char __user *) (regs->pt.xss << 4), SP(regs));
 		return 0;
 	}
 	if (trapno !=1)
@@ -560,10 +587,10 @@ void handle_vm86_fault(struct kernel_vm8
 		handle_vm86_trap(regs, 0, 1); \
 	return; } while (0)
 
-	orig_flags = *(unsigned short *)&regs->eflags;
-
-	csp = (unsigned char __user *) (regs->cs << 4);
-	ssp = (unsigned char __user *) (regs->ss << 4);
+	orig_flags = *(unsigned short *)&regs->pt.eflags;
+
+	csp = (unsigned char __user *) (regs->pt.xcs << 4);
+	ssp = (unsigned char __user *) (regs->pt.xss << 4);
 	sp = SP(regs);
 	ip = IP(regs);
 
@@ -650,7 +677,7 @@ void handle_vm86_fault(struct kernel_vm8
 			SP(regs) += 6;
 		}
 		IP(regs) = newip;
-		regs->cs = newcs;
+		regs->pt.xcs = newcs;
 		CHECK_IF_IN_TRAP;
 		if (data32) {
 			set_vflags_long(newflags, regs);
diff -r 448ac068c03f include/asm-i386/vm86.h
--- a/include/asm-i386/vm86.h	Sun Sep 24 19:26:47 2006 -0700
+++ b/include/asm-i386/vm86.h	Sun Sep 24 22:33:53 2006 -0700
@@ -145,26 +145,13 @@ struct vm86plus_struct {
  * at the end of the structure. Look at ptrace.h to see the "normal"
  * setup. For user space layout see 'struct vm86_regs' above.
  */
+#include <asm/ptrace.h>
 
 struct kernel_vm86_regs {
 /*
  * normal regs, with special meaning for the segment descriptors..
  */
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	long __null_ds;
-	long __null_es;
-	long orig_eax;
-	long eip;
-	unsigned short cs, __csh;
-	long eflags;
-	long esp;
-	unsigned short ss, __ssh;
+	struct pt_regs pt;
 /*
  * these are specific to v86 mode:
  */

--

