Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWAEWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWAEWjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWAEWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:39:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750893AbWAEWjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:39:02 -0500
Date: Thu, 5 Jan 2006 23:39:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] dump_thread() cleanup
Message-ID: <20060105223901.GI12313@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- create one common dump_thread() prototype in kernel.h
- dump_thread() is only used in fs/binfmt_aout.c and can therefore be
  removed on all architectures where CONFIG_BINFMT_AOUT is not
  available


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Nov 2005

 arch/alpha/kernel/alpha_ksyms.c     |    1 
 arch/arm26/kernel/armksyms.c        |    1 
 arch/cris/kernel/crisksyms.c        |    2 -
 arch/cris/kernel/process.c          |   28 -----------------
 arch/frv/kernel/frv_ksyms.c         |    2 -
 arch/frv/kernel/process.c           |   22 -------------
 arch/h8300/kernel/h8300_ksyms.c     |    3 -
 arch/h8300/kernel/process.c         |   28 -----------------
 arch/m32r/kernel/m32r_ksyms.c       |    3 -
 arch/m32r/kernel/process.c          |    8 ----
 arch/m68k/kernel/m68k_ksyms.c       |    2 -
 arch/m68knommu/kernel/m68k_ksyms.c  |    2 -
 arch/m68knommu/kernel/process.c     |   46 ----------------------------
 arch/s390/kernel/process.c          |   21 ------------
 arch/sh/kernel/process.c            |   20 ------------
 arch/sh/kernel/sh_ksyms.c           |    2 -
 arch/sh64/kernel/process.c          |   20 ------------
 arch/sh64/kernel/sh_ksyms.c         |    2 -
 arch/sparc/kernel/sparc_ksyms.c     |    2 -
 arch/sparc64/kernel/binfmt_aout32.c |    2 -
 arch/sparc64/kernel/sparc64_ksyms.c |    2 -
 arch/v850/kernel/process.c          |   24 --------------
 arch/v850/kernel/v850_ksyms.c       |    2 -
 fs/binfmt_aout.c                    |    2 -
 fs/binfmt_flat.c                    |    2 -
 include/asm-um/processor-generic.h  |    1 
 include/linux/kernel.h              |    4 ++
 27 files changed, 4 insertions(+), 250 deletions(-)

--- linux-2.6.15-rc2-mm1-full/include/linux/kernel.h.old	2005-11-23 16:17:42.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/include/linux/kernel.h	2005-11-23 16:43:18.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/user.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -123,6 +124,9 @@
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
+struct pt_regs;
+extern void dump_thread(struct pt_regs *regs, struct user *dump);
+
 #ifdef CONFIG_PRINTK
 asmlinkage int vprintk(const char *fmt, va_list args)
 	__attribute__ ((format (printf, 1, 0)));
--- linux-2.6.15-rc2-mm1-full/include/asm-um/processor-generic.h.old	2005-11-23 16:03:04.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/include/asm-um/processor-generic.h	2005-11-23 16:03:12.000000000 +0100
@@ -89,7 +89,6 @@
 
 extern void release_thread(struct task_struct *);
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
-extern void dump_thread(struct pt_regs *regs, struct user *u);
 
 static inline void prepare_to_copy(struct task_struct *tsk)
 {
--- linux-2.6.15-rc2-mm1-full/fs/binfmt_aout.c.old	2005-11-23 16:26:54.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/fs/binfmt_aout.c	2005-11-23 16:26:58.000000000 +0100
@@ -33,8 +33,6 @@
 static int load_aout_library(struct file*);
 static int aout_core_dump(long signr, struct pt_regs * regs, struct file *file);
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 static struct linux_binfmt aout_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_aout_binary,
--- linux-2.6.15-rc2-mm1-full/fs/binfmt_flat.c.old	2005-11-23 16:27:08.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/fs/binfmt_flat.c	2005-11-23 16:27:12.000000000 +0100
@@ -77,8 +77,6 @@
 static int load_flat_binary(struct linux_binprm *, struct pt_regs * regs);
 static int flat_core_dump(long signr, struct pt_regs * regs, struct file *file);
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 static struct linux_binfmt flat_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_flat_binary,
--- linux-2.6.15-rc2-mm1-full/arch/alpha/kernel/alpha_ksyms.c.old	2005-11-23 16:03:25.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/alpha/kernel/alpha_ksyms.c	2005-11-23 16:17:38.000000000 +0100
@@ -40,7 +40,6 @@
 #include <asm/unistd.h>
 
 extern struct hwrpb_struct *hwrpb;
-extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
 
 /* these are C runtime functions with special calling conventions: */
--- linux-2.6.15-rc2-mm1-full/arch/arm26/kernel/armksyms.c.old	2005-11-23 16:19:03.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/arm26/kernel/armksyms.c	2005-11-23 16:19:08.000000000 +0100
@@ -35,7 +35,6 @@
 #include <asm/checksum.h>
 #include <asm/mach-types.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, struct user_fp_struct *);
 extern void inswb(unsigned int port, void *to, int len);
 extern void outswb(unsigned int port, const void *to, int len);
--- linux-2.6.15-rc2-mm1-full/arch/cris/kernel/crisksyms.c.old	2005-11-23 16:19:42.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/cris/kernel/crisksyms.c	2005-11-23 16:19:46.000000000 +0100
@@ -21,7 +21,6 @@
 #include <asm/pgtable.h>
 #include <asm/fasttimer.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern unsigned long get_cmos_time(void);
 extern void __Udiv(void);
 extern void __Umod(void);
@@ -33,7 +32,6 @@
 extern void iounmap(volatile void * __iomem);
 
 /* Platform dependent support */
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(loops_per_usec);
--- linux-2.6.15-rc2-mm1-full/arch/cris/kernel/process.c.old	2005-11-23 16:19:57.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/cris/kernel/process.c	2005-11-23 16:20:08.000000000 +0100
@@ -257,34 +257,6 @@
 {
 }
 
-/*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-#if 0
-	int i;
-
-	/* changed the size calculations - should hopefully work better. lbt */
-	dump->magic = CMAGIC;
-	dump->start_code = 0;
-	dump->start_stack = regs->esp & ~(PAGE_SIZE - 1);
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
-	dump->u_dsize -= dump->u_tsize;
-	dump->u_ssize = 0;
-	for (i = 0; i < 8; i++)
-		dump->u_debugreg[i] = current->debugreg[i];  
-
-	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
-
-	dump->regs = *regs;
-
-	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
-#endif 
-}
-
 /* Fill in the fpu structure for a core dump. */
 int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 {
--- linux-2.6.15-rc2-mm1-full/arch/frv/kernel/frv_ksyms.c.old	2005-11-23 16:20:19.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/frv/kernel/frv_ksyms.c	2005-11-23 16:20:23.000000000 +0100
@@ -18,7 +18,6 @@
 #include <asm/hardirq.h>
 #include <asm/current.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern long __memcpy_user(void *dst, const void *src, size_t count);
 
 /* platform dependent support */
@@ -26,7 +25,6 @@
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
--- linux-2.6.15-rc2-mm1-full/arch/frv/kernel/process.c.old	2005-11-23 16:20:30.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/frv/kernel/process.c	2005-11-23 16:20:37.000000000 +0100
@@ -244,28 +244,6 @@
 } /* end copy_thread() */
 
 /*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs *regs, struct user *dump)
-{
-#if 0
-	/* changed the size calculations - should hopefully work better. lbt */
-	dump->magic = CMAGIC;
-	dump->start_code = 0;
-	dump->start_stack = user_stack(regs) & ~(PAGE_SIZE - 1);
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
-	dump->u_dsize -= dump->u_tsize;
-	dump->u_ssize = 0;
-
-	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
-
-	dump->regs = *(struct user_context *) regs;
-#endif
-}
-
-/*
  * sys_execve() executes a new program.
  */
 asmlinkage int sys_execve(char *name, char **argv, char **envp)
--- linux-2.6.15-rc2-mm1-full/arch/h8300/kernel/h8300_ksyms.c.old	2005-11-23 16:20:46.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/h8300/kernel/h8300_ksyms.c	2005-11-23 16:20:50.000000000 +0100
@@ -22,11 +22,8 @@
 //asmlinkage long long __lshrdi3 (long long, int);
 extern char h8300_debug_device[];
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 /* platform dependent support */
 
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
--- linux-2.6.15-rc2-mm1-full/arch/h8300/kernel/process.c.old	2005-11-23 16:20:57.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/h8300/kernel/process.c	2005-11-23 16:21:05.000000000 +0100
@@ -208,34 +208,6 @@
 }
 
 /*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-/* changed the size calculations - should hopefully work better. lbt */
-	dump->magic = CMAGIC;
-	dump->start_code = 0;
-	dump->start_stack = rdusp() & ~(PAGE_SIZE - 1);
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk +
-					  (PAGE_SIZE-1))) >> PAGE_SHIFT;
-	dump->u_dsize -= dump->u_tsize;
-	dump->u_ssize = 0;
-
-	dump->u_ar0 = (struct user_regs_struct *)(((int)(&dump->regs)) -((int)(dump)));
-	dump->regs.er0 = regs->er0;
-	dump->regs.er1 = regs->er1;
-	dump->regs.er2 = regs->er2;
-	dump->regs.er3 = regs->er3;
-	dump->regs.er4 = regs->er4;
-	dump->regs.er5 = regs->er5;
-	dump->regs.er6 = regs->er6;
-	dump->regs.orig_er0 = regs->orig_er0;
-	dump->regs.ccr = regs->ccr;
-	dump->regs.pc  = regs->pc;
-}
-
-/*
  * sys_execve() executes a new program.
  */
 asmlinkage int sys_execve(char *name, char **argv, char **envp,int dummy,...)
--- linux-2.6.15-rc2-mm1-full/arch/m32r/kernel/m32r_ksyms.c.old	2005-11-23 16:21:20.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/m32r/kernel/m32r_ksyms.c	2005-11-23 16:21:24.000000000 +0100
@@ -18,8 +18,6 @@
 #include <asm/irq.h>
 #include <asm/tlbflush.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
 extern struct drive_info_struct drive_info;
 EXPORT_SYMBOL(drive_info);
@@ -27,7 +25,6 @@
 
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
--- linux-2.6.15-rc2-mm1-full/arch/m32r/kernel/process.c.old	2005-11-23 16:21:35.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/m32r/kernel/process.c	2005-11-23 16:21:41.000000000 +0100
@@ -257,14 +257,6 @@
 }
 
 /*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-	/* M32R_FIXME */
-}
-
-/*
  * Capture the user space registers if the task is not running (in user space)
  */
 int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
--- linux-2.6.15-rc2-mm1-full/arch/m68k/kernel/m68k_ksyms.c.old	2005-11-23 16:22:15.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/m68k/kernel/m68k_ksyms.c	2005-11-23 16:22:18.000000000 +0100
@@ -23,8 +23,6 @@
 asmlinkage long long __muldi3 (long long, long long);
 extern char m68k_debug_device[];
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 /* platform dependent support */
 
 EXPORT_SYMBOL(m68k_machtype);
--- linux-2.6.15-rc2-mm1-full/arch/m68knommu/kernel/m68k_ksyms.c.old	2005-11-23 16:22:28.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/m68knommu/kernel/m68k_ksyms.c	2005-11-23 16:22:33.000000000 +0100
@@ -18,7 +18,6 @@
 #include <asm/checksum.h>
 #include <asm/current.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 
 /* platform dependent support */
@@ -26,7 +25,6 @@
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
--- linux-2.6.15-rc2-mm1-full/arch/m68knommu/kernel/process.c.old	2005-11-23 16:22:43.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/m68knommu/kernel/process.c	2005-11-23 16:22:52.000000000 +0100
@@ -276,52 +276,6 @@
 }
 
 /*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-	struct switch_stack *sw;
-
-	/* changed the size calculations - should hopefully work better. lbt */
-	dump->magic = CMAGIC;
-	dump->start_code = 0;
-	dump->start_stack = rdusp() & ~(PAGE_SIZE - 1);
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk +
-					  (PAGE_SIZE-1))) >> PAGE_SHIFT;
-	dump->u_dsize -= dump->u_tsize;
-	dump->u_ssize = 0;
-
-	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
-
-	dump->u_ar0 = (struct user_regs_struct *)((int)&dump->regs - (int)dump);
-	sw = ((struct switch_stack *)regs) - 1;
-	dump->regs.d1 = regs->d1;
-	dump->regs.d2 = regs->d2;
-	dump->regs.d3 = regs->d3;
-	dump->regs.d4 = regs->d4;
-	dump->regs.d5 = regs->d5;
-	dump->regs.d6 = sw->d6;
-	dump->regs.d7 = sw->d7;
-	dump->regs.a0 = regs->a0;
-	dump->regs.a1 = regs->a1;
-	dump->regs.a2 = regs->a2;
-	dump->regs.a3 = sw->a3;
-	dump->regs.a4 = sw->a4;
-	dump->regs.a5 = sw->a5;
-	dump->regs.a6 = sw->a6;
-	dump->regs.d0 = regs->d0;
-	dump->regs.orig_d0 = regs->orig_d0;
-	dump->regs.stkadj = regs->stkadj;
-	dump->regs.sr = regs->sr;
-	dump->regs.pc = regs->pc;
-	dump->regs.fmtvec = (regs->format << 12) | regs->vector;
-	/* dump floating point stuff */
-	dump->u_fpvalid = dump_fpu (regs, &dump->m68kfp);
-}
-
-/*
  *	Generic dumping code. Used for panic and debug.
  */
 void dump(struct pt_regs *fp)
--- linux-2.6.15-rc2-mm1-full/arch/s390/kernel/process.c.old	2005-11-23 16:23:03.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/s390/kernel/process.c	2005-11-23 16:23:09.000000000 +0100
@@ -352,27 +352,6 @@
 	return 1;
 }
 
-/*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-
-/* changed the size calculations - should hopefully work better. lbt */
-	dump->magic = CMAGIC;
-	dump->start_code = 0;
-	dump->start_stack = regs->gprs[15] & ~(PAGE_SIZE - 1);
-	dump->u_tsize = current->mm->end_code >> PAGE_SHIFT;
-	dump->u_dsize = (current->mm->brk + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	dump->u_dsize -= dump->u_tsize;
-	dump->u_ssize = 0;
-	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = (TASK_SIZE - dump->start_stack) >> PAGE_SHIFT;
-	memcpy(&dump->regs, regs, sizeof(s390_regs));
-	dump_fpu (regs, &dump->regs.fp_regs);
-	dump->regs.per_info = current->thread.per_info;
-}
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stack_frame *sf, *low, *high;
--- linux-2.6.15-rc2-mm1-full/arch/sh/kernel/process.c.old	2005-11-23 16:23:23.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sh/kernel/process.c	2005-11-23 16:23:29.000000000 +0100
@@ -305,26 +305,6 @@
 	return 0;
 }
 
-/*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-	dump->magic = CMAGIC;
-	dump->start_code = current->mm->start_code;
-	dump->start_data  = current->mm->start_data;
-	dump->start_stack = regs->regs[15] & ~(PAGE_SIZE - 1);
-	dump->u_tsize = (current->mm->end_code - dump->start_code) >> PAGE_SHIFT;
-	dump->u_dsize = (current->mm->brk + (PAGE_SIZE-1) - dump->start_data) >> PAGE_SHIFT;
-	dump->u_ssize = (current->mm->start_stack - dump->start_stack +
-			 PAGE_SIZE - 1) >> PAGE_SHIFT;
-	/* Debug registers will come here. */
-
-	dump->regs = *regs;
-
-	dump->u_fpvalid = dump_fpu(regs, &dump->fpu);
-}
-
 /* Tracing by user break controller.  */
 static void
 ubc_set_tracing(int asid, unsigned long pc)
--- linux-2.6.15-rc2-mm1-full/arch/sh/kernel/sh_ksyms.c.old	2005-11-23 16:23:37.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sh/kernel/sh_ksyms.c	2005-11-23 16:23:40.000000000 +0100
@@ -21,14 +21,12 @@
 #include <asm/cacheflush.h>
 #include <asm/checksum.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 extern struct hw_interrupt_type no_irq_type;
 
 EXPORT_SYMBOL(sh_mv);
 
 /* platform dependent support */
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(enable_irq);
--- linux-2.6.15-rc2-mm1-full/arch/sh64/kernel/process.c.old	2005-11-23 16:23:49.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sh64/kernel/process.c	2005-11-23 16:23:55.000000000 +0100
@@ -775,26 +775,6 @@
 	return 0;
 }
 
-/*
- * fill in the user structure for a core dump..
- */
-void dump_thread(struct pt_regs * regs, struct user * dump)
-{
-	dump->magic = CMAGIC;
-	dump->start_code = current->mm->start_code;
-	dump->start_data  = current->mm->start_data;
-	dump->start_stack = regs->regs[15] & ~(PAGE_SIZE - 1);
-	dump->u_tsize = (current->mm->end_code - dump->start_code) >> PAGE_SHIFT;
-	dump->u_dsize = (current->mm->brk + (PAGE_SIZE-1) - dump->start_data) >> PAGE_SHIFT;
-	dump->u_ssize = (current->mm->start_stack - dump->start_stack +
-			 PAGE_SIZE - 1) >> PAGE_SHIFT;
-	/* Debug registers will come here. */
-
-	dump->regs = *regs;
-
-	dump->u_fpvalid = dump_fpu(regs, &dump->fpu);
-}
-
 asmlinkage int sys_fork(unsigned long r2, unsigned long r3,
 			unsigned long r4, unsigned long r5,
 			unsigned long r6, unsigned long r7,
--- linux-2.6.15-rc2-mm1-full/arch/sh64/kernel/sh_ksyms.c.old	2005-11-23 16:24:03.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sh64/kernel/sh_ksyms.c	2005-11-23 16:24:07.000000000 +0100
@@ -29,7 +29,6 @@
 #include <asm/delay.h>
 #include <asm/irq.h>
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 
 #if 0
@@ -41,7 +40,6 @@
 #endif
 
 /* platform dependent support */
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(enable_irq);
--- linux-2.6.15-rc2-mm1-full/arch/sparc/kernel/sparc_ksyms.c.old	2005-11-23 16:24:15.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sparc/kernel/sparc_ksyms.c	2005-11-23 16:24:19.000000000 +0100
@@ -82,8 +82,6 @@
 extern int __muldi3(int, int);
 extern int __divdi3(int, int);
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 /* Private functions with odd calling conventions. */
 extern void ___atomic24_add(void);
 extern void ___atomic24_sub(void);
--- linux-2.6.15-rc2-mm1-full/arch/sparc64/kernel/binfmt_aout32.c.old	2005-11-23 16:25:23.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sparc64/kernel/binfmt_aout32.c	2005-11-23 16:25:27.000000000 +0100
@@ -36,8 +36,6 @@
 static int load_aout32_library(struct file*);
 static int aout32_core_dump(long signr, struct pt_regs * regs, struct file *file);
 
-extern void dump_thread(struct pt_regs *, struct user *);
-
 static struct linux_binfmt aout32_format = {
 	NULL, THIS_MODULE, load_aout32_binary, load_aout32_library, aout32_core_dump,
 	PAGE_SIZE
--- linux-2.6.15-rc2-mm1-full/arch/sparc64/kernel/sparc64_ksyms.c.old	2005-11-23 16:25:35.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/sparc64/kernel/sparc64_ksyms.c	2005-11-23 16:25:40.000000000 +0100
@@ -94,7 +94,6 @@
 
 extern int __ashrdi3(int, int);
 
-extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
 extern unsigned long phys_base;
@@ -241,7 +240,6 @@
 EXPORT_SYMBOL(_sigpause_common);
 EXPORT_SYMBOL(verify_compat_iovec);
 
-EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(pte_alloc_one_kernel);
 #ifndef CONFIG_SMP
--- linux-2.6.15-rc2-mm1-full/arch/v850/kernel/process.c.old	2005-11-23 16:26:04.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/v850/kernel/process.c	2005-11-23 16:26:10.000000000 +0100
@@ -164,30 +164,6 @@
 }
 
 /*
- * fill in the user structure for a core dump..
- */
-void dump_thread (struct pt_regs *regs, struct user *dump)
-{
-#if 0  /* Later.  XXX */
-	dump->magic = CMAGIC;
-	dump->start_code = 0;
-	dump->start_stack = regs->gpr[GPR_SP];
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk +
-					  (PAGE_SIZE-1))) >> PAGE_SHIFT;
-	dump->u_dsize -= dump->u_tsize;
-	dump->u_ssize = 0;
-
-	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
-
-	dump->u_ar0 = (struct user_regs_struct *)((int)&dump->regs - (int)dump);
-	dump->regs = *regs;
-	dump->u_fpvalid = 0;
-#endif
-}
-
-/*
  * sys_execve() executes a new program.
  */
 int sys_execve (char *name, char **argv, char **envp, struct pt_regs *regs)
--- linux-2.6.15-rc2-mm1-full/arch/v850/kernel/v850_ksyms.c.old	2005-11-23 16:26:17.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/v850/kernel/v850_ksyms.c	2005-11-23 16:26:33.000000000 +0100
@@ -21,8 +21,6 @@
 EXPORT_SYMBOL (trap_table);
 
 /* platform dependent support */
-extern void dump_thread (struct pt_regs *, struct user *);
-EXPORT_SYMBOL (dump_thread);
 EXPORT_SYMBOL (kernel_thread);
 EXPORT_SYMBOL (enable_irq);
 EXPORT_SYMBOL (disable_irq);

