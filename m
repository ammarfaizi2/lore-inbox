Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTKRHpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 02:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTKRHpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 02:45:51 -0500
Received: from holomorphy.com ([199.26.172.102]:51366 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262422AbTKRHow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 02:44:52 -0500
Date: Mon, 17 Nov 2003 23:44:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: use ELF sections for get_wchan()
Message-ID: <20031118074448.GD19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a bunch of "FIXME: this depends on the order of these
functions" comments in/around wchan calculations.

So I decided I'd remove the dependency on the order of the functions by
dumping them all into an ELF section with clear delimiters.


-- wli


diff -prauN linux-2.6.0-test9-bk22/arch/alpha/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/alpha/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/alpha/kernel/process.c	2003-10-25 11:44:37.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/alpha/kernel/process.c	2003-11-17 23:20:01.000000000 -0800
@@ -513,11 +513,6 @@ thread_saved_pc(task_t *t)
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long
 get_wchan(struct task_struct *p)
 {
@@ -536,7 +531,8 @@ get_wchan(struct task_struct *p)
 	 */
 
 	pc = thread_saved_pc(p);
-	if (pc >= first_sched && pc < last_sched) {
+	if (pc >= scheduling_functions_start_here &&
+			pc < scheduling_functions_end_here) {
 		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
 		return ((unsigned long *)schedule_frame)[12];
 	}
diff -prauN linux-2.6.0-test9-bk22/arch/alpha/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/alpha/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/alpha/kernel/vmlinux.lds.S	2003-10-25 11:43:42.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/alpha/kernel/vmlinux.lds.S	2003-11-17 23:12:42.000000000 -0800
@@ -17,6 +17,9 @@ SECTIONS
   _text = .;					/* Text and read-only data */
   .text : { 
 	*(.text) 
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
   } :kernel
diff -prauN linux-2.6.0-test9-bk22/arch/arm/boot/compressed/vmlinux.lds.in wchan-2.6.0-test9-bk22-1/arch/arm/boot/compressed/vmlinux.lds.in
--- linux-2.6.0-test9-bk22/arch/arm/boot/compressed/vmlinux.lds.in	2003-10-25 11:43:32.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm/boot/compressed/vmlinux.lds.in	2003-11-17 23:14:03.000000000 -0800
@@ -21,6 +21,9 @@ SECTIONS
     _start = .;
     *(.start)
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.gnu.warning)
     *(.rodata)
diff -prauN linux-2.6.0-test9-bk22/arch/arm/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/arm/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/arm/kernel/process.c	2003-10-25 11:44:41.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm/kernel/process.c	2003-11-17 23:20:24.000000000 -0800
@@ -415,11 +415,6 @@ pid_t kernel_thread(int (*fn)(void *), v
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
@@ -434,7 +429,8 @@ unsigned long get_wchan(struct task_stru
 		if (fp < stack_page || fp > 4092+stack_page)
 			return 0;
 		lr = pc_pointer (((unsigned long *)fp)[-1]);
-		if (lr < first_sched || lr > last_sched)
+		if (lr < scheduling_functions_start_here ||
+				lr > scheduling_functions_end_here)
 			return lr;
 		fp = *(unsigned long *) (fp - 12);
 	} while (count ++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/arm/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/arm/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/arm/kernel/vmlinux.lds.S	2003-10-25 11:43:22.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm/kernel/vmlinux.lds.S	2003-11-17 23:13:36.000000000 -0800
@@ -73,6 +73,9 @@ SECTIONS
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			__scheduling_functions_start_here = .;
+			*(.text.sched)
+			__scheduling_functions_end_here = .;
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
diff -prauN linux-2.6.0-test9-bk22/arch/arm26/boot/compressed/vmlinux.lds.in wchan-2.6.0-test9-bk22-1/arch/arm26/boot/compressed/vmlinux.lds.in
--- linux-2.6.0-test9-bk22/arch/arm26/boot/compressed/vmlinux.lds.in	2003-10-25 11:42:57.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm26/boot/compressed/vmlinux.lds.in	2003-11-17 23:09:47.000000000 -0800
@@ -21,6 +21,9 @@ SECTIONS
     _start = .;
     *(.start)
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.gnu.warning)
     *(.rodata)
diff -prauN linux-2.6.0-test9-bk22/arch/arm26/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/arm26/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/arm26/kernel/process.c	2003-10-25 11:44:39.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm26/kernel/process.c	2003-11-17 23:20:47.000000000 -0800
@@ -400,11 +400,6 @@ pid_t kernel_thread(int (*fn)(void *), v
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
@@ -419,7 +414,8 @@ unsigned long get_wchan(struct task_stru
 		if (fp < stack_page || fp > 4092+stack_page)
 			return 0;
 		lr = pc_pointer (((unsigned long *)fp)[-1]);
-		if (lr < first_sched || lr > last_sched)
+		if (lr < scheduling_functions_start_here ||
+				lr > scheduling_functions_end_here)
 			return lr;
 		fp = *(unsigned long *) (fp - 12);
 	} while (count ++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/arm26/kernel/vmlinux-arm26-xip.lds.in wchan-2.6.0-test9-bk22-1/arch/arm26/kernel/vmlinux-arm26-xip.lds.in
--- linux-2.6.0-test9-bk22/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2003-10-25 11:44:34.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2003-11-17 23:11:07.000000000 -0800
@@ -66,6 +66,9 @@ SECTIONS
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			__scheduling_functions_start_here = .;
+			*(.text.sched)
+			__scheduling_functions_end_here = .;
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
diff -prauN linux-2.6.0-test9-bk22/arch/arm26/kernel/vmlinux-arm26.lds.in wchan-2.6.0-test9-bk22-1/arch/arm26/kernel/vmlinux-arm26.lds.in
--- linux-2.6.0-test9-bk22/arch/arm26/kernel/vmlinux-arm26.lds.in	2003-10-25 11:42:56.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/arm26/kernel/vmlinux-arm26.lds.in	2003-11-17 23:10:18.000000000 -0800
@@ -67,6 +67,9 @@ SECTIONS
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			__scheduling_functions_start_here = .;
+			*(.text.sched)
+			__scheduling_functions_end_here = .;
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
diff -prauN linux-2.6.0-test9-bk22/arch/cris/arch-v10/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/cris/arch-v10/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/cris/arch-v10/vmlinux.lds.S	2003-10-25 11:43:29.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/cris/arch-v10/vmlinux.lds.S	2003-11-17 23:08:52.000000000 -0800
@@ -25,6 +25,9 @@ SECTIONS
 	__stext = .;
 	.text : {
 		*(.text)
+		__scheduling_functions_start_here = .;
+		*(.text.sched)
+		__scheduling_functions_end_here = .;
 		*(.fixup)
 		*(.text.__*)
 	}
diff -prauN linux-2.6.0-test9-bk22/arch/h8300/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/h8300/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/h8300/kernel/process.c	2003-10-25 11:42:43.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/h8300/kernel/process.c	2003-11-17 23:21:15.000000000 -0800
@@ -264,11 +264,6 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
 	return ((struct pt_regs *)tsk->thread.esp0)->pc;
@@ -289,8 +284,8 @@ unsigned long get_wchan(struct task_stru
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/h8300/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/h8300/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/h8300/kernel/vmlinux.lds.S	2003-10-25 11:43:54.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/h8300/kernel/vmlinux.lds.S	2003-11-17 23:17:49.000000000 -0800
@@ -82,6 +82,9 @@ SECTIONS
 #endif
 	__stext = . ;
         	*(.text)
+	__scheduling_functions_start_here = .;
+		*(.text.sched)
+	__scheduling_functions_end_here = .;
 	. = ALIGN(0x4) ;
 		*(.exit.text)
 		*(.text.*)
diff -prauN linux-2.6.0-test9-bk22/arch/i386/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/i386/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/i386/kernel/process.c	2003-10-25 11:42:40.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/i386/kernel/process.c	2003-11-17 23:03:54.000000000 -0800
@@ -631,11 +631,6 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ebp, esp, eip;
@@ -653,14 +648,13 @@ unsigned long get_wchan(struct task_stru
 		if (ebp < stack_page || ebp > 8184+stack_page)
 			return 0;
 		eip = *(unsigned long *) (ebp+4);
-		if (eip < first_sched || eip >= last_sched)
+		if (eip < scheduling_functions_start_here ||
+				eip >= scheduling_functions_end_here)
 			return eip;
 		ebp = *(unsigned long *) ebp;
 	} while (count++ < 16);
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
 /*
  * sys_alloc_thread_area: get a yet unused TLS descriptor index.
diff -prauN linux-2.6.0-test9-bk22/arch/i386/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/i386/kernel/vmlinux.lds.S	2003-10-25 11:43:05.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/i386/kernel/vmlinux.lds.S	2003-11-17 23:01:42.000000000 -0800
@@ -15,6 +15,9 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
diff -prauN linux-2.6.0-test9-bk22/arch/ia64/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/ia64/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/ia64/kernel/process.c	2003-10-25 11:43:35.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/ia64/kernel/process.c	2003-11-17 23:31:04.000000000 -0800
@@ -638,11 +638,6 @@ get_wchan (struct task_struct *p)
 	/*
 	 * These bracket the sleeping functions..
 	 */
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
-#	define first_sched	((unsigned long) scheduling_functions_start_here)
-#	define last_sched	((unsigned long) scheduling_functions_end_here)
-
 	/*
 	 * Note: p may not be a blocked task (it could be current or
 	 * another process running on some other CPU.  Rather than
@@ -656,12 +651,11 @@ get_wchan (struct task_struct *p)
 		if (unw_unwind(&info) < 0)
 			return 0;
 		unw_get_ip(&info, &ip);
-		if (ip < first_sched || ip >= last_sched)
+		if (ip < scheduling_functions_start_here ||
+				ip >= scheduling_functions_end_here)
 			return ip;
 	} while (count++ < 16);
 	return 0;
-#	undef first_sched
-#	undef last_sched
 }
 
 void
diff -prauN linux-2.6.0-test9-bk22/arch/ia64/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/ia64/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/ia64/kernel/vmlinux.lds.S	2003-10-25 11:44:35.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/ia64/kernel/vmlinux.lds.S	2003-11-17 23:12:13.000000000 -0800
@@ -35,6 +35,9 @@ SECTIONS
     {
 	*(.text.ivt)
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
diff -prauN linux-2.6.0-test9-bk22/arch/m68k/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/m68k/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/m68k/kernel/process.c	2003-10-25 11:45:04.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/m68k/kernel/process.c	2003-11-17 23:22:49.000000000 -0800
@@ -65,12 +65,10 @@ asmlinkage void ret_from_fork(void);
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > scheduling_functions_start_here &&
+	    sw->retpc < scheduling_functions_end_here)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
@@ -387,11 +385,6 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
@@ -407,8 +400,8 @@ unsigned long get_wchan(struct task_stru
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/m68k/kernel/vmlinux-std.lds wchan-2.6.0-test9-bk22-1/arch/m68k/kernel/vmlinux-std.lds
--- linux-2.6.0-test9-bk22/arch/m68k/kernel/vmlinux-std.lds	2003-10-25 11:44:39.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/m68k/kernel/vmlinux-std.lds	2003-11-17 23:11:46.000000000 -0800
@@ -12,6 +12,9 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x4e75
diff -prauN linux-2.6.0-test9-bk22/arch/m68k/kernel/vmlinux-sun3.lds wchan-2.6.0-test9-bk22-1/arch/m68k/kernel/vmlinux-sun3.lds
--- linux-2.6.0-test9-bk22/arch/m68k/kernel/vmlinux-sun3.lds	2003-10-25 11:42:41.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/m68k/kernel/vmlinux-sun3.lds	2003-11-17 23:11:27.000000000 -0800
@@ -13,6 +13,9 @@ SECTIONS
   .text : {
 	*(.head)
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x4e75
diff -prauN linux-2.6.0-test9-bk22/arch/m68knommu/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/m68knommu/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/m68knommu/kernel/process.c	2003-10-25 11:43:07.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/m68knommu/kernel/process.c	2003-11-17 23:23:27.000000000 -0800
@@ -406,11 +406,6 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
@@ -426,8 +421,8 @@ unsigned long get_wchan(struct task_stru
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
@@ -439,13 +434,11 @@ unsigned long get_wchan(struct task_stru
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > scheduling_functions_start_here &&
+	    sw->retpc < scheduling_functions_end_here)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
diff -prauN linux-2.6.0-test9-bk22/arch/m68knommu/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/m68knommu/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/m68knommu/kernel/vmlinux.lds.S	2003-10-25 11:43:29.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/m68knommu/kernel/vmlinux.lds.S	2003-11-17 23:05:24.000000000 -0800
@@ -191,6 +191,9 @@ SECTIONS {
 	.text : {
 		_stext = . ;
         	*(.text)
+		__scheduling_functions_start_here = .;
+		*(.text.sched)
+		__scheduling_functions_end_here = .;
         	*(.text.lock)
 
 		. = ALIGN(16);          /* Exception table              */
diff -prauN linux-2.6.0-test9-bk22/arch/mips/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/mips/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/mips/kernel/process.c	2003-10-25 11:43:29.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/mips/kernel/process.c	2003-11-17 23:31:29.000000000 -0800
@@ -276,11 +276,6 @@ unsigned long thread_saved_pc(struct tas
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -292,7 +287,8 @@ unsigned long get_wchan(struct task_stru
 	if (!mips_frame_info_initialized)
 		return 0;
 	pc = thread_saved_pc(p);
-	if (pc < first_sched || pc >= last_sched)
+	if (pc < scheduling_functions_start_here ||
+			pc >= scheduling_functions_end_here)
 		goto out;
 
 	if (pc >= (unsigned long) sleep_on_timeout)
@@ -326,7 +322,8 @@ schedule_timeout_caller:
 	 */
 	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
 
-	if (pc >= first_sched && pc < last_sched) {
+	if (pc >= scheduling_functions_start_here &&
+			pc < scheduling_functions_end_here) {
 		/* schedule_timeout called by [interruptible_]sleep_on_timeout */
 		frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
 		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
diff -prauN linux-2.6.0-test9-bk22/arch/mips/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/mips/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/mips/kernel/vmlinux.lds.S	2003-10-25 11:43:21.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/mips/kernel/vmlinux.lds.S	2003-11-17 23:08:18.000000000 -0800
@@ -27,6 +27,9 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.gnu.warning)
   } =0
diff -prauN linux-2.6.0-test9-bk22/arch/parisc/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/parisc/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/parisc/kernel/vmlinux.lds.S	2003-10-25 11:43:05.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/parisc/kernel/vmlinux.lds.S	2003-11-17 23:14:31.000000000 -0800
@@ -24,6 +24,9 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text BLOCK(16) : {
 	*(.text*)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here =.;
 	*(.PARISC.unwind)
 	*(.fixup)
 	*(.lock.text)		/* out-of-line lock text */
diff -prauN linux-2.6.0-test9-bk22/arch/ppc/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/ppc/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/ppc/kernel/process.c	2003-10-25 11:43:35.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/ppc/kernel/process.c	2003-11-17 23:25:35.000000000 -0800
@@ -650,11 +650,6 @@ void __init ll_puts(const char *s)
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched    ((unsigned long) scheduling_functions_start_here)
-#define last_sched     ((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
@@ -669,7 +664,8 @@ unsigned long get_wchan(struct task_stru
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 4);
-			if (ip < first_sched || ip >= last_sched)
+			if (ip < scheduling_functions_start_here ||
+					ip >= scheduling_functions_end_here)
 				return ip;
 		}
 	} while (count++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/ppc/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/ppc/kernel/vmlinux.lds.S	2003-11-17 22:51:23.000000000 -0800
+++ wchan-2.6.0-test9-bk22-1/arch/ppc/kernel/vmlinux.lds.S	2003-11-17 23:07:08.000000000 -0800
@@ -31,6 +31,9 @@ SECTIONS
   .text      :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.got1)
     __got2_start = .;
diff -prauN linux-2.6.0-test9-bk22/arch/ppc64/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/ppc64/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/ppc64/kernel/process.c	2003-10-25 11:43:54.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/ppc64/kernel/process.c	2003-11-17 23:26:08.000000000 -0800
@@ -369,11 +369,6 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched    (*(unsigned long *)scheduling_functions_start_here)
-#define last_sched     (*(unsigned long *)scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
@@ -393,7 +388,8 @@ unsigned long get_wchan(struct task_stru
 			 * XXX we mask the upper 32 bits until procps
 			 * gets fixed.
 			 */
-			if (ip < first_sched || ip >= last_sched)
+			if (ip < scheduling_functions_start_here ||
+					ip >= scheduling_functions_end_here)
 				return (ip & 0xFFFFFFFF);
 		}
 	} while (count++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/ppc64/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/ppc64/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/ppc64/kernel/vmlinux.lds.S	2003-10-25 11:44:15.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/ppc64/kernel/vmlinux.lds.S	2003-11-17 23:13:13.000000000 -0800
@@ -33,6 +33,9 @@ SECTIONS
   .text      :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.got1)
   }
diff -prauN linux-2.6.0-test9-bk22/arch/s390/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/s390/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/s390/kernel/process.c	2003-10-25 11:44:17.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/s390/kernel/process.c	2003-11-17 23:26:43.000000000 -0800
@@ -371,11 +371,6 @@ void dump_thread(struct pt_regs * regs, 
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long r14, r15, bc;
@@ -398,12 +393,10 @@ unsigned long get_wchan(struct task_stru
 #else
 		r14 = *(unsigned long *) (bc+112);
 #endif
-		if (r14 < first_sched || r14 >= last_sched)
+		if (r14 < scheduling_functions_start_here ||
+				r14 >= scheduling_functions_end_here)
 			return r14;
 		bc = (*(unsigned long *) bc) & PSW_ADDR_INSN;
 	} while (count++ < 16);
 	return 0;
 }
-#undef last_sched
-#undef first_sched
-
diff -prauN linux-2.6.0-test9-bk22/arch/s390/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/s390/kernel/vmlinux.lds.S	2003-10-25 11:43:23.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/s390/kernel/vmlinux.lds.S	2003-11-17 23:18:44.000000000 -0800
@@ -23,6 +23,9 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
diff -prauN linux-2.6.0-test9-bk22/arch/sh/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/sh/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/sh/kernel/process.c	2003-10-25 11:44:08.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/sh/kernel/process.c	2003-11-17 23:28:29.000000000 -0800
@@ -375,11 +375,6 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
diff -prauN linux-2.6.0-test9-bk22/arch/sh/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/sh/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/sh/kernel/vmlinux.lds.S	2003-10-25 11:43:49.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/sh/kernel/vmlinux.lds.S	2003-11-17 23:09:23.000000000 -0800
@@ -22,6 +22,9 @@ SECTIONS
 	} = 0
   .text : {
 	*(.text)
+	__scheduling_functions_start_here =.;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0009
diff -prauN linux-2.6.0-test9-bk22/arch/sparc/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/sparc/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/sparc/kernel/process.c	2003-10-25 11:43:00.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/sparc/kernel/process.c	2003-11-17 23:29:13.000000000 -0800
@@ -692,9 +692,6 @@ pid_t kernel_thread(int (*fn)(void *), v
 	return retval;
 }
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
@@ -715,8 +712,8 @@ unsigned long get_wchan(struct task_stru
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-                    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < scheduling_functions_start_here ||
+                    pc >= scheduling_functions_end_here) {
 			ret = pc;
 			goto out;
 		}
diff -prauN linux-2.6.0-test9-bk22/arch/sparc/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/sparc/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/sparc/kernel/vmlinux.lds.S	2003-10-25 11:42:53.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/sparc/kernel/vmlinux.lds.S	2003-11-17 23:06:33.000000000 -0800
@@ -12,6 +12,9 @@ SECTIONS
   .text 0xf0004000 :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.gnu.warning)
   } =0
   _etext = .;
diff -prauN linux-2.6.0-test9-bk22/arch/sparc64/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/sparc64/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/sparc64/kernel/process.c	2003-10-25 11:43:30.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/sparc64/kernel/process.c	2003-11-17 23:29:28.000000000 -0800
@@ -824,9 +824,6 @@ out:
 	return error;
 }
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
@@ -850,8 +847,8 @@ unsigned long get_wchan(struct task_stru
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-		    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < scheduling_functions_start_here ||
+		    pc >= scheduling_functions_end_here) {
 			ret = pc;
 			goto out;
 		}
diff -prauN linux-2.6.0-test9-bk22/arch/sparc64/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/sparc64/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/sparc64/kernel/vmlinux.lds.S	2003-10-25 11:44:36.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/sparc64/kernel/vmlinux.lds.S	2003-11-17 23:06:07.000000000 -0800
@@ -15,6 +15,9 @@ SECTIONS
   .text 0x0000000000404000 :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.text.sched)
+    __scheduling_functions_end_here = .;
     *(.gnu.warning)
   } =0
   _etext = .;
diff -prauN linux-2.6.0-test9-bk22/arch/v850/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/v850/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/v850/kernel/process.c	2003-10-25 11:43:02.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/v850/kernel/process.c	2003-11-17 23:32:14.000000000 -0800
@@ -203,11 +203,6 @@ int sys_execve (char *name, char **argv,
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here (void);
-extern void scheduling_functions_end_here (void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan (struct task_struct *p)
 {
 #if 0  /* Barf.  Figure out the stack-layout later.  XXX  */
@@ -221,15 +216,16 @@ unsigned long get_wchan (struct task_str
 
 	/* This quite disgusting function walks up the stack, following
 	   saved return address, until it something that's out of bounds
-	   (as defined by `first_sched' and `last_sched').  It then
-	   returns the last PC that was in-bounds.  */
+	   (as defined by `scheduling_functions_start_here' and
+	   `scheduling_functions_end_here').  It then returns the last
+	   PC that was in-bounds.  */
 	do {
 		if (fp < stack_page + sizeof (struct task_struct) ||
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
diff -prauN linux-2.6.0-test9-bk22/arch/v850/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/v850/kernel/vmlinux.lds.S	2003-10-25 11:43:58.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/v850/kernel/vmlinux.lds.S	2003-11-17 23:18:13.000000000 -0800
@@ -64,6 +64,9 @@
 #define TEXT_CONTENTS							      \
 		__stext = . ;						      \
         	*(.text)						      \
+		__scheduling_functions_start_here = .;
+		*(.text.sched)
+		__scheduling_functions_end_here = .;
 			*(.exit.text)	/* 2.5 convention */		      \
 			*(.text.exit)	/* 2.4 convention */		      \
 			*(.text.lock)					      \
diff -prauN linux-2.6.0-test9-bk22/arch/x86_64/kernel/process.c wchan-2.6.0-test9-bk22-1/arch/x86_64/kernel/process.c
--- linux-2.6.0-test9-bk22/arch/x86_64/kernel/process.c	2003-10-25 11:43:49.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/x86_64/kernel/process.c	2003-11-17 23:30:38.000000000 -0800
@@ -528,11 +528,6 @@ asmlinkage long sys_vfork(struct pt_regs
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	u64 fp,rip;
@@ -547,14 +542,13 @@ unsigned long get_wchan(struct task_stru
 		if (fp < (unsigned long)p || fp > (unsigned long)p+THREAD_SIZE)
 			return 0; 
 		rip = *(u64 *)(fp+8); 
-		if (rip < first_sched || rip >= last_sched)
+		if (rip < scheduling_functions_start_here ||
+				rip >= scheduling_functions_end_here)
 			return rip; 
 		fp = *(u64 *)fp; 
 	} while (count++ < 16); 
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
 long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
 { 
diff -prauN linux-2.6.0-test9-bk22/arch/x86_64/kernel/vmlinux.lds.S wchan-2.6.0-test9-bk22-1/arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.0-test9-bk22/arch/x86_64/kernel/vmlinux.lds.S	2003-10-25 11:42:51.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/arch/x86_64/kernel/vmlinux.lds.S	2003-11-17 23:14:54.000000000 -0800
@@ -14,6 +14,9 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.text.sched)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
diff -prauN linux-2.6.0-test9-bk22/include/linux/init.h wchan-2.6.0-test9-bk22-1/include/linux/init.h
--- linux-2.6.0-test9-bk22/include/linux/init.h	2003-10-25 11:42:50.000000000 -0700
+++ wchan-2.6.0-test9-bk22-1/include/linux/init.h	2003-11-17 23:01:42.000000000 -0800
@@ -45,6 +45,8 @@
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
+#define __sched		__attribute__((__section__(".text.sched")))
+
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
diff -prauN linux-2.6.0-test9-bk22/include/linux/sched.h wchan-2.6.0-test9-bk22-1/include/linux/sched.h
--- linux-2.6.0-test9-bk22/include/linux/sched.h	2003-11-17 22:51:24.000000000 -0800
+++ wchan-2.6.0-test9-bk22-1/include/linux/sched.h	2003-11-17 23:01:42.000000000 -0800
@@ -169,6 +169,8 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
+extern const unsigned long scheduling_functions_start_here;
+extern const unsigned long scheduling_functions_end_here;
 
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
diff -prauN linux-2.6.0-test9-bk22/kernel/sched.c wchan-2.6.0-test9-bk22-1/kernel/sched.c
--- linux-2.6.0-test9-bk22/kernel/sched.c	2003-11-17 22:51:24.000000000 -0800
+++ wchan-2.6.0-test9-bk22-1/kernel/sched.c	2003-11-17 23:01:42.000000000 -0800
@@ -221,6 +221,13 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+extern unsigned long __scheduling_functions_start_here;
+extern unsigned long __scheduling_functions_end_here;
+const unsigned long scheduling_functions_start_here =
+			(unsigned long)&__scheduling_functions_start_here;
+const unsigned long scheduling_functions_end_here =
+			(unsigned long)&__scheduling_functions_end_here;
+
 /*
  * Default context-switch locking:
  */
@@ -1463,12 +1470,10 @@ out:
 	rebalance_tick(rq, 0);
 }
 
-void scheduling_functions_start_here(void) { }
-
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void schedule(void)
+asmlinkage __sched void schedule(void)
 {
 	task_t *prev, *next;
 	runqueue_t *rq;
@@ -1611,7 +1616,7 @@ EXPORT_SYMBOL(schedule);
  * off of preempt_enable.  Kernel preemptions off return from interrupt
  * occur there and call schedule directly.
  */
-asmlinkage void preempt_schedule(void)
+asmlinkage __sched void preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
 
@@ -1636,7 +1641,7 @@ need_resched:
 EXPORT_SYMBOL(preempt_schedule);
 #endif /* CONFIG_PREEMPT */
 
-int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
+__sched int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
 {
 	task_t *p = curr->task;
 	return try_to_wake_up(p, mode, sync);
@@ -1653,7 +1658,7 @@ EXPORT_SYMBOL(default_wake_function);
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
+static __sched void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp, *next;
 
@@ -1675,7 +1680,7 @@ static void __wake_up_common(wait_queue_
  * @mode: which threads
  * @nr_exclusive: how many wake-one or wake-many threads to wake up
  */
-void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+__sched void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	unsigned long flags;
 
@@ -1707,7 +1712,7 @@ void __wake_up_locked(wait_queue_head_t 
  *
  * On UP it can prevent extra preemption.
  */
-void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+__sched void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	unsigned long flags;
 
@@ -1724,7 +1729,7 @@ void __wake_up_sync(wait_queue_head_t *q
 
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
-void complete(struct completion *x)
+__sched void complete(struct completion *x)
 {
 	unsigned long flags;
 
@@ -1736,7 +1741,7 @@ void complete(struct completion *x)
 
 EXPORT_SYMBOL(complete);
 
-void complete_all(struct completion *x)
+__sched void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
@@ -1746,7 +1751,7 @@ void complete_all(struct completion *x)
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
-void wait_for_completion(struct completion *x)
+__sched void wait_for_completion(struct completion *x)
 {
 	might_sleep();
 	spin_lock_irq(&x->wait.lock);
@@ -1784,7 +1789,7 @@ EXPORT_SYMBOL(wait_for_completion);
 	__remove_wait_queue(q, &wait);				\
 	spin_unlock_irqrestore(&q->lock, flags);
 
-void interruptible_sleep_on(wait_queue_head_t *q)
+__sched void interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1797,7 +1802,7 @@ void interruptible_sleep_on(wait_queue_h
 
 EXPORT_SYMBOL(interruptible_sleep_on);
 
-long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+__sched long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1812,7 +1817,7 @@ long interruptible_sleep_on_timeout(wait
 
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 
-void sleep_on(wait_queue_head_t *q)
+__sched void sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1825,7 +1830,7 @@ void sleep_on(wait_queue_head_t *q)
 
 EXPORT_SYMBOL(sleep_on);
 
-long sleep_on_timeout(wait_queue_head_t *q, long timeout)
+__sched long sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1840,8 +1845,6 @@ long sleep_on_timeout(wait_queue_head_t 
 
 EXPORT_SYMBOL(sleep_on_timeout);
 
-void scheduling_functions_end_here(void) { }
-
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -2291,7 +2294,7 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-void __cond_resched(void)
+__sched void __cond_resched(void)
 {
 	set_current_state(TASK_RUNNING);
 	schedule();
@@ -2305,7 +2308,7 @@ EXPORT_SYMBOL(__cond_resched);
  * this is a shortcut for kernel-space yielding - it marks the
  * thread runnable and calls sys_sched_yield().
  */
-void yield(void)
+__sched void yield(void)
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
@@ -2320,7 +2323,7 @@ EXPORT_SYMBOL(yield);
  * But don't do that if it is a deliberate, throttling IO wait (this task
  * has set its backing_dev_info: the queue against which it should throttle)
  */
-void io_schedule(void)
+__sched void io_schedule(void)
 {
 	struct runqueue *rq = this_rq();
 
@@ -2331,7 +2334,7 @@ void io_schedule(void)
 
 EXPORT_SYMBOL(io_schedule);
 
-long io_schedule_timeout(long timeout)
+__sched long io_schedule_timeout(long timeout)
 {
 	struct runqueue *rq = this_rq();
 	long ret;
@@ -2881,7 +2884,7 @@ EXPORT_SYMBOL(__might_sleep);
  *
  * Called inside preempt_disable().
  */
-void __preempt_spin_lock(spinlock_t *lock)
+__sched void __preempt_spin_lock(spinlock_t *lock)
 {
 	if (preempt_count() > 1) {
 		_raw_spin_lock(lock);
@@ -2897,7 +2900,7 @@ void __preempt_spin_lock(spinlock_t *loc
 
 EXPORT_SYMBOL(__preempt_spin_lock);
 
-void __preempt_write_lock(rwlock_t *lock)
+__sched void __preempt_write_lock(rwlock_t *lock)
 {
 	if (preempt_count() > 1) {
 		_raw_write_lock(lock);
diff -prauN linux-2.6.0-test9-bk22/kernel/timer.c wchan-2.6.0-test9-bk22-1/kernel/timer.c
--- linux-2.6.0-test9-bk22/kernel/timer.c	2003-11-17 22:51:24.000000000 -0800
+++ wchan-2.6.0-test9-bk22-1/kernel/timer.c	2003-11-17 23:01:42.000000000 -0800
@@ -1000,7 +1000,7 @@ static void process_timeout(unsigned lon
  *
  * In all cases the return value is guaranteed to be non-negative.
  */
-signed long schedule_timeout(signed long timeout)
+__sched signed long schedule_timeout(signed long timeout)
 {
 	struct timer_list timer;
 	unsigned long expire;
@@ -1060,7 +1060,7 @@ asmlinkage long sys_gettid(void)
 	return current->pid;
 }
 
-static long nanosleep_restart(struct restart_block *restart)
+static __sched long nanosleep_restart(struct restart_block *restart)
 {
 	unsigned long expire = restart->arg0, now = jiffies;
 	struct timespec *rmtp = (struct timespec *) restart->arg1;
