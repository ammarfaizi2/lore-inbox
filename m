Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbUDNGC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUDNGC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:02:56 -0400
Received: from ozlabs.org ([203.10.76.45]:23211 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263902AbUDNGCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:02:35 -0400
Subject: Re: [PATCH] Minor __sched cleanups
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040414022712.GV726@holomorphy.com>
References: <1081906686.22908.31.camel@bach>
	 <20040414022712.GV726@holomorphy.com>
Content-Type: text/plain
Message-Id: <1081922545.30226.102.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 16:02:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 12:27, William Lee Irwin III wrote:
> On Wed, Apr 14, 2004 at 11:38:06AM +1000, Rusty Russell wrote:
> > Fairly minor cleanups to wli's recent __sched implementation:
> > Name: Minor __sched Cleanups
> > Status: Tested on 2.6.5-mm4
> > Version: -mm
> > 1) __sched_text_start and __sched_test_end are more normal section
> >    marker names, and can be used directly.
> > 2) There is no comment and no reason for __sched to be in linux/init.h:
> >    linux/sched.h would be preferable.
> 
> Hmm, why not consolidate first_sched/last_sched while we're at it?

s/consolidate/remove/ perhaps?

Agreed that they're kinda silly.  This moves the test into sched.c.

How's this instead?

Name: in_sched_functions()
Status: Booted on 2.6.5-mm4
Version: -mm

1) Create an in_sched_functions() function in sched.c and make the
   archs use it.  (Two archs have wchan #if 0'd out: left them alone).

2) Move __sched from linux/init.h to linux/sched.h and add comment.

3) Rename __scheduling_functions_start_here/end_here to __sched_text_start/end.

Thanks to wli and Sam Ravnborg for clue donation.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/alpha/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/alpha/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/alpha/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -510,12 +510,6 @@ thread_saved_pc(task_t *t)
 	return 0;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long
 get_wchan(struct task_struct *p)
 {
@@ -534,7 +528,7 @@ get_wchan(struct task_struct *p)
 	 */
 
 	pc = thread_saved_pc(p);
-	if (pc >= first_sched && pc < last_sched) {
+	if (in_sched_functions(pc)) {
 		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
 		return ((unsigned long *)schedule_frame)[12];
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/arm/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/arm/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/arm/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/arm/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -411,12 +411,6 @@ pid_t kernel_thread(int (*fn)(void *), v
 	return do_fork(flags|CLONE_VM|CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
@@ -431,7 +425,7 @@ unsigned long get_wchan(struct task_stru
 		if (fp < stack_page || fp > 4092+stack_page)
 			return 0;
 		lr = pc_pointer (((unsigned long *)fp)[-1]);
-		if (lr < first_sched || lr > last_sched)
+		if (!in_sched_functions(lr))
 			return lr;
 		fp = *(unsigned long *) (fp - 12);
 	} while (count ++ < 16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/arm26/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/arm26/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/arm26/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/arm26/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -397,12 +397,6 @@ pid_t kernel_thread(int (*fn)(void *), v
         return __ret;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
@@ -417,7 +411,7 @@ unsigned long get_wchan(struct task_stru
 		if (fp < stack_page || fp > 4092+stack_page)
 			return 0;
 		lr = pc_pointer (((unsigned long *)fp)[-1]);
-		if (lr < first_sched || lr > last_sched)
+		if (!in_sched_functions(lr))
 			return lr;
 		fp = *(unsigned long *) (fp - 12);
 	} while (count ++ < 16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/cris/arch-v10/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/cris/arch-v10/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/cris/arch-v10/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/cris/arch-v10/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -217,8 +217,8 @@ asmlinkage int sys_execve(const char *fn
  * These bracket the sleeping functions..
  */
 
-#define first_sched     ((unsigned long) scheduling_functions_start_here)
-#define last_sched      ((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/h8300/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/h8300/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/h8300/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/h8300/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -261,12 +261,6 @@ out:
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
 	return ((struct pt_regs *)tsk->thread.esp0)->pc;
@@ -287,7 +281,7 @@ unsigned long get_wchan(struct task_stru
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		if (pc < first_sched || pc >= last_sched)
+		if (!in_sched_functions(pc))
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/i386/kernel/kgdb_stub.c .31487-linux-2.6.5-mm4.updated/arch/i386/kernel/kgdb_stub.c
--- .31487-linux-2.6.5-mm4/arch/i386/kernel/kgdb_stub.c	2004-04-13 10:36:42.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/i386/kernel/kgdb_stub.c	2004-04-14 15:23:18.000000000 +1000
@@ -654,8 +654,6 @@ gdb_regs_to_regs(int *gdb_regs, struct p
 #endif
 
 }				/* gdb_regs_to_regs */
-#define first_sched	scheduling_functions_start_here
-#define last_sched	scheduling_functions_end_here
 
 int thread_list = 0;
 
@@ -716,7 +714,7 @@ get_gdb_regs(struct task_struct *p, stru
 		gdb_regs[_PC] = *(unsigned long *) (gdb_regs[_EBP] + 4);
 		gdb_regs[_ESP] = gdb_regs[_EBP] + 8;
 		gdb_regs[_EBP] = *(unsigned long *) gdb_regs[_EBP];
-		if (gdb_regs[_PC] < first_sched || gdb_regs[_PC] >= last_sched)
+		if (!in_sched_functions(gdb_regs[_PC]))
 			return;
 	} while (count++ < 16);
 	return;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/i386/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/i386/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/i386/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/i386/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -629,11 +629,6 @@ out:
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
 #define top_esp                (THREAD_SIZE - sizeof(unsigned long))
 #define top_ebp                (THREAD_SIZE - 2*sizeof(unsigned long))
 
@@ -654,14 +649,12 @@ unsigned long get_wchan(struct task_stru
 		if (ebp < stack_page || ebp > top_ebp+stack_page)
 			return 0;
 		eip = *(unsigned long *) (ebp+4);
-		if (eip < first_sched || eip >= last_sched)
+		if (!in_sched_functions(eip))
 			return eip;
 		ebp = *(unsigned long *) ebp;
 	} while (count++ < 16);
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
 /*
  * sys_alloc_thread_area: get a yet unused TLS descriptor index.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/ia64/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/ia64/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/ia64/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/ia64/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -657,11 +657,6 @@ get_wchan (struct task_struct *p)
 	struct unw_frame_info info;
 	unsigned long ip;
 	int count = 0;
-	/*
-	 * These bracket the sleeping functions..
-	 */
-#	define first_sched	((unsigned long) scheduling_functions_start_here)
-#	define last_sched	((unsigned long) scheduling_functions_end_here)
 
 	/*
 	 * Note: p may not be a blocked task (it could be current or
@@ -676,12 +671,10 @@ get_wchan (struct task_struct *p)
 		if (unw_unwind(&info) < 0)
 			return 0;
 		unw_get_ip(&info, &ip);
-		if (ip < first_sched || ip >= last_sched)
+		if (!in_sched_functions(ip))
 			return ip;
 	} while (count++ < 16);
 	return 0;
-#	undef first_sched
-#	undef last_sched
 }
 
 void
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/m68k/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/m68k/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/m68k/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/m68k/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -67,8 +67,8 @@ unsigned long thread_saved_pc(struct tas
 {
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > (unsigned long)__sched_text_start &&
+	    sw->retpc < (unsigned long)__sched_text_end)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
@@ -382,12 +382,6 @@ out:
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
@@ -403,7 +397,7 @@ unsigned long get_wchan(struct task_stru
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		if (pc < first_sched || pc >= last_sched)
+		if (!in_sched_functions(pc))
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/m68knommu/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/m68knommu/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/m68knommu/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/m68knommu/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -404,12 +404,6 @@ out:
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
@@ -425,7 +419,7 @@ unsigned long get_wchan(struct task_stru
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		if (pc < first_sched || pc >= last_sched)
+		if (!in_sched_functions(pc))
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
@@ -440,8 +434,8 @@ unsigned long thread_saved_pc(struct tas
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > (unsigned long)__sched_text_start &&
+	    sw->retpc < (unsigned long)__sched_text_end)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/mips/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/mips/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/mips/kernel/process.c	2004-04-13 10:36:43.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/mips/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -280,12 +280,6 @@ unsigned long thread_saved_pc(struct tas
 	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -297,7 +291,7 @@ unsigned long get_wchan(struct task_stru
 	if (!mips_frame_info_initialized)
 		return 0;
 	pc = thread_saved_pc(p);
-	if (pc < first_sched || pc >= last_sched)
+	if (!in_sched_functions(pc))
 		goto out;
 
 	if (pc >= (unsigned long) sleep_on_timeout)
@@ -331,7 +325,7 @@ schedule_timeout_caller:
 	 */
 	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
 
-	if (pc >= first_sched && pc < last_sched) {
+	if (in_sched_functions(pc)) {
 		/* schedule_timeout called by [interruptible_]sleep_on_timeout */
 		frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
 		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/ppc/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/ppc/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/ppc/kernel/process.c	2004-04-13 10:36:43.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/ppc/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -658,12 +658,6 @@ void __init ll_puts(const char *s)
 }
 #endif
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched    ((unsigned long) scheduling_functions_start_here)
-#define last_sched     ((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
@@ -678,7 +672,7 @@ unsigned long get_wchan(struct task_stru
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 4);
-			if (ip < first_sched || ip >= last_sched)
+			if (!in_sched_functions(ip))
 				return ip;
 		}
 	} while (count++ < 16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/ppc64/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/ppc64/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/ppc64/kernel/process.c	2004-04-13 10:36:43.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/ppc64/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -472,12 +472,6 @@ static inline int validate_sp(unsigned l
 	return 1;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched    (*(unsigned long *)scheduling_functions_start_here)
-#define last_sched     (*(unsigned long *)scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
@@ -496,7 +490,7 @@ unsigned long get_wchan(struct task_stru
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 16);
-			if (ip < first_sched || ip >= last_sched)
+			if (!in_sched_functions(ip))
 				return ip;
 		}
 	} while (count++ < 16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/s390/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/s390/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/s390/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/s390/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -381,12 +381,6 @@ void dump_thread(struct pt_regs * regs, 
 	dump->regs.per_info = current->thread.per_info;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long r14, r15, bc;
@@ -409,12 +403,10 @@ unsigned long get_wchan(struct task_stru
 #else
 		r14 = *(unsigned long *) (bc+112);
 #endif
-		if (r14 < first_sched || r14 >= last_sched)
+		if (!in_sched_functions(r14))
 			return r14;
 		bc = (*(unsigned long *) bc) & PSW_ADDR_INSN;
 	} while (count++ < 16);
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/sh/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/sh/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/sh/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/sh/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -461,12 +461,6 @@ out:
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
@@ -479,7 +473,7 @@ unsigned long get_wchan(struct task_stru
 	 * The same comment as on the Alpha applies here, too ...
 	 */
 	pc = thread_saved_pc(p);
-	if (pc >= first_sched && pc < last_sched) {
+	if (in_sched_functions(pc)) {
 		schedule_frame = ((unsigned long *)(long)p->thread.sp)[1];
 		return (unsigned long)((unsigned long *)schedule_frame)[1];
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/sparc/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/sparc/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/sparc/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/sparc/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -715,8 +715,8 @@ unsigned long get_wchan(struct task_stru
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-                    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < ((unsigned long)__sched_text_start) ||
+                    pc >= ((unsigned long)__sched_text_end)) {
 			ret = pc;
 			goto out;
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/sparc64/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/sparc64/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/sparc64/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/sparc64/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -847,8 +847,8 @@ unsigned long get_wchan(struct task_stru
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-		    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < ((unsigned long)__sched_text_start) ||
+		    pc >= ((unsigned long)__sched_text_end)) {
 			ret = pc;
 			goto out;
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/v850/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/v850/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/v850/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/v850/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -203,8 +203,8 @@ int sys_execve (char *name, char **argv,
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan (struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/x86_64/kernel/kgdb_stub.c .31487-linux-2.6.5-mm4.updated/arch/x86_64/kernel/kgdb_stub.c
--- .31487-linux-2.6.5-mm4/arch/x86_64/kernel/kgdb_stub.c	2004-04-13 10:36:46.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/x86_64/kernel/kgdb_stub.c	2004-04-14 15:23:18.000000000 +1000
@@ -667,9 +667,6 @@ gdb_regs_to_regs(unsigned long *gdb_regs
 #endif
 }				/* gdb_regs_to_regs */
 
-#define first_sched	scheduling_functions_start_here
-#define last_sched	scheduling_functions_end_here
-
 int thread_list = 0;
 extern void thread_return(void);
 
@@ -730,7 +727,7 @@ get_gdb_regs(struct task_struct *p, stru
 		rsp = (unsigned long *)rbp;
 		pc = rsp[1];
 
-		if (pc < first_sched || pc >= last_sched)
+		if (!in_sched_functions(pc))
 			break;
 		gdb_regs[_PC] = (unsigned long)pc;
 		gdb_regs[_RSP] = (unsigned long)rsp;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/arch/x86_64/kernel/process.c .31487-linux-2.6.5-mm4.updated/arch/x86_64/kernel/process.c
--- .31487-linux-2.6.5-mm4/arch/x86_64/kernel/process.c	2004-04-13 10:36:46.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/arch/x86_64/kernel/process.c	2004-04-14 15:23:18.000000000 +1000
@@ -573,12 +573,6 @@ asmlinkage long sys_vfork(struct pt_regs
 		    NULL, NULL);
 }
 
-/*
- * These bracket the sleeping functions..
- */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long stack;
@@ -595,14 +589,12 @@ unsigned long get_wchan(struct task_stru
 		if (fp < (unsigned long)stack || fp > (unsigned long)stack+THREAD_SIZE)
 			return 0; 
 		rip = *(u64 *)(fp+8); 
-		if (rip < first_sched || rip >= last_sched)
+		if (!in_sched_functions(rip))
 			return rip; 
 		fp = *(u64 *)fp; 
 	} while (count++ < 16); 
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
 long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
 { 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/include/asm-generic/vmlinux.lds.h .31487-linux-2.6.5-mm4.updated/include/asm-generic/vmlinux.lds.h
--- .31487-linux-2.6.5-mm4/include/asm-generic/vmlinux.lds.h	2004-04-13 10:37:08.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/include/asm-generic/vmlinux.lds.h	2004-04-14 15:23:18.000000000 +1000
@@ -53,6 +53,6 @@
 	}
 
 #define SCHED_TEXT							\
-		__scheduling_functions_start_here = .;			\
+		__sched_text_start = .;					\
 		*(.sched.text)						\
-		__scheduling_functions_end_here = .;
+		__sched_text_end = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/include/linux/init.h .31487-linux-2.6.5-mm4.updated/include/linux/init.h
--- .31487-linux-2.6.5-mm4/include/linux/init.h	2004-04-13 10:37:09.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/include/linux/init.h	2004-04-14 15:23:18.000000000 +1000
@@ -47,8 +47,6 @@
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
-#define __sched		__attribute__((__section__(".sched.text")))
-
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/include/linux/sched.h .31487-linux-2.6.5-mm4.updated/include/linux/sched.h
--- .31487-linux-2.6.5-mm4/include/linux/sched.h	2004-04-13 10:37:12.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/include/linux/sched.h	2004-04-14 15:23:18.000000000 +1000
@@ -172,9 +172,11 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
-extern const unsigned long scheduling_functions_start_here;
-extern const unsigned long scheduling_functions_end_here;
 
+/* Attach to any functions which should be ignored in wchan output. */
+#define __sched		__attribute__((__section__(".sched.text")))
+/* Is this address in the __sched functions? */
+extern int in_sched_functions(unsigned long addr);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31487-linux-2.6.5-mm4/kernel/sched.c .31487-linux-2.6.5-mm4.updated/kernel/sched.c
--- .31487-linux-2.6.5-mm4/kernel/sched.c	2004-04-13 10:37:13.000000000 +1000
+++ .31487-linux-2.6.5-mm4.updated/kernel/sched.c	2004-04-14 15:23:18.000000000 +1000
@@ -252,13 +252,6 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
-extern unsigned long __scheduling_functions_start_here;
-extern unsigned long __scheduling_functions_end_here;
-const unsigned long scheduling_functions_start_here =
-			(unsigned long)&__scheduling_functions_start_here;
-const unsigned long scheduling_functions_end_here =
-			(unsigned long)&__scheduling_functions_end_here;
-
 /*
  * Default context-switch locking:
  */
@@ -3676,6 +3669,14 @@ void __init sched_init_smp(void)
 }
 #endif /* CONFIG_SMP */
 
+int in_sched_functions(unsigned long addr)
+{
+	/* Linker adds these: start and end of __sched functions */
+	extern char __sched_text_start[], __sched_text_end[];
+	return addr >= (unsigned long)__sched_text_start
+		&& addr < (unsigned long)__sched_text_end;
+}
+
 void __init sched_init(void)
 {
 	runqueue_t *rq;

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

