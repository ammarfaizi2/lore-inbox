Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUDAJ4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDAJ4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:56:47 -0500
Received: from holomorphy.com ([207.189.100.168]:26795 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262418AbUDAJzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:55:32 -0500
Date: Thu, 1 Apr 2004 01:55:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: fix get_wchan() FIXME wrt. order of functions
Message-ID: <20040401095526.GB791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the issue with get_wchan() that the various functions
acting as scheduling-related primitives are not, in fact, contiguous
in the text segment. It creates an ELF section for scheduling primitives
to be placed in, and places currently-detected (i.e. skipped during stack
decoding) scheduling primitives and others like io_schedule() and down(),
which are currently missed by get_wchan() code, into this section also.

The net effects are more reliability of get_wchan()'s results and the
new ability, made use of by this code, to arbitrarily place scheduling
primitives in the source code without disturbing get_wchan()'s accuracy.

Suggestions by Arnd Bergmann and Matthew Wilcox regarding reducing the
invasiveness of the patch were incorporated during prior rounds of review.
I've at least tried to sweep all arches in this patch.

vs. 2.6.5-rc3. Rediffing vs. -mm would be easy for me.


-- wli


Index: sched-2.6.5-rc3/arch/alpha/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/alpha/kernel/process.c	2004-03-29 19:27:07.000000000 -0800
+++ sched-2.6.5-rc3/arch/alpha/kernel/process.c	2004-03-31 18:28:56.000000000 -0800
@@ -513,8 +513,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/alpha/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/alpha/kernel/semaphore.c	2004-03-29 19:26:17.000000000 -0800
+++ sched-2.6.5-rc3/arch/alpha/kernel/semaphore.c	2004-03-31 18:25:58.000000000 -0800
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 
 /*
  * This is basically the PPC semaphore scheme ported to use
@@ -60,7 +61,7 @@
  * Either form may be used in conjunction with "up()".
  */
 
-void
+void __sched
 __down_failed(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
@@ -101,7 +102,7 @@
 #endif
 }
 
-int
+int __sched
 __down_failed_interruptible(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
@@ -159,7 +160,7 @@
 	wake_up(&sem->wait);
 }
 
-void
+void __sched
 down(struct semaphore *sem)
 {
 #if WAITQUEUE_DEBUG
@@ -173,7 +174,7 @@
 	__down(sem);
 }
 
-int
+int __sched
 down_interruptible(struct semaphore *sem)
 {
 #if WAITQUEUE_DEBUG
Index: sched-2.6.5-rc3/arch/alpha/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/alpha/kernel/vmlinux.lds.S	2004-03-29 19:26:17.000000000 -0800
+++ sched-2.6.5-rc3/arch/alpha/kernel/vmlinux.lds.S	2004-03-31 17:40:49.000000000 -0800
@@ -17,6 +17,7 @@
   _text = .;					/* Text and read-only data */
   .text : { 
 	*(.text) 
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
   } :kernel
Index: sched-2.6.5-rc3/arch/arm/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm/kernel/process.c	2004-03-29 19:27:15.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm/kernel/process.c	2004-03-31 18:29:34.000000000 -0800
@@ -414,8 +414,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/arm/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm/kernel/semaphore.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm/kernel/semaphore.c	2004-03-31 18:27:13.000000000 -0800
@@ -13,6 +13,7 @@
  */
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -54,7 +55,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -87,7 +88,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -176,7 +177,8 @@
  * registers (r0 to r3 and lr), but not ip, as we use it as a return
  * value in some cases..
  */
-asm("	.align	5				\n\
+asm("	.section .sched.text			\n\
+	.align	5				\n\
 	.globl	__down_failed			\n\
 __down_failed:					\n\
 	stmfd	sp!, {r0 - r3, lr}		\n\
Index: sched-2.6.5-rc3/arch/arm/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm/kernel/vmlinux.lds.S	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm/kernel/vmlinux.lds.S	2004-03-31 17:41:00.000000000 -0800
@@ -73,6 +73,7 @@
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			SCHED_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: sched-2.6.5-rc3/arch/arm26/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/process.c	2004-03-29 19:27:14.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/process.c	2004-03-31 18:28:31.000000000 -0800
@@ -400,8 +400,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/arm26/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/semaphore.c	2004-03-29 19:25:38.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/semaphore.c	2004-03-31 18:30:05.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -56,7 +57,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -89,7 +90,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -178,7 +179,8 @@
  * registers (r0 to r3 and lr), but not ip, as we use it as a return
  * value in some cases..
  */
-asm("	.align	5				\n\
+asm("	.section .sched.text			\n\
+	.align	5				\n\
 	.globl	__down_failed			\n\
 __down_failed:					\n\
 	stmfd	sp!, {r0 - r3, lr}		\n\
Index: sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26-xip.lds.in
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2004-03-29 19:27:04.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2004-03-31 17:44:00.000000000 -0800
@@ -66,6 +66,7 @@
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			SCHED_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26.lds.in
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/vmlinux-arm26.lds.in	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26.lds.in	2004-03-31 17:44:16.000000000 -0800
@@ -67,6 +67,7 @@
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			SCHED_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: sched-2.6.5-rc3/arch/cris/arch-v10/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/cris/arch-v10/vmlinux.lds.S	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/cris/arch-v10/vmlinux.lds.S	2004-03-31 17:44:35.000000000 -0800
@@ -25,6 +25,7 @@
 	__stext = .;
 	.text : {
 		*(.text)
+		SCHED_TEXT
 		*(.fixup)
 		*(.text.__*)
 	}
Index: sched-2.6.5-rc3/arch/cris/arch-v10/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/cris/arch-v10/kernel/process.c	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/cris/arch-v10/kernel/process.c	2004-03-31 18:31:10.000000000 -0800
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_ETRAX_GPIO
 void etrax_gpio_wake_up_check(void); /* drivers/gpio.c */
@@ -216,8 +217,6 @@
  * These bracket the sleeping functions..
  */
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched     ((unsigned long) scheduling_functions_start_here)
 #define last_sched      ((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/cris/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/cris/kernel/semaphore.c	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/cris/kernel/semaphore.c	2004-03-31 18:30:29.000000000 -0800
@@ -4,6 +4,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 /*
@@ -94,7 +95,7 @@
 	tsk->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	DOWN_VAR
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
@@ -104,7 +105,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
 	DOWN_VAR
Index: sched-2.6.5-rc3/arch/h8300/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/h8300/kernel/process.c	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/h8300/kernel/process.c	2004-03-31 18:32:31.000000000 -0800
@@ -264,8 +264,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
@@ -289,7 +287,6 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
 		if (pc < first_sched || pc >= last_sched)
 			return pc;
 		fp = *(unsigned long *) fp;
Index: sched-2.6.5-rc3/arch/h8300/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/h8300/kernel/semaphore.c	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/h8300/kernel/semaphore.c	2004-03-31 18:32:53.000000000 -0800
@@ -5,6 +5,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 #ifndef CONFIG_RMW_INSNS
@@ -95,7 +96,7 @@
 	current->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -106,7 +107,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
Index: sched-2.6.5-rc3/arch/h8300/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/h8300/kernel/vmlinux.lds.S	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/h8300/kernel/vmlinux.lds.S	2004-03-31 17:41:17.000000000 -0800
@@ -82,6 +82,7 @@
 #endif
 	__stext = . ;
         	*(.text)
+	SCHED_TEXT
 	. = ALIGN(0x4) ;
 		*(.exit.text)
 		*(.text.*)
Index: sched-2.6.5-rc3/arch/i386/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/process.c	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/process.c	2004-03-31 18:50:27.000000000 -0800
@@ -632,8 +632,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 #define top_esp                (THREAD_SIZE - sizeof(unsigned long))
Index: sched-2.6.5-rc3/arch/i386/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/semaphore.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/semaphore.c	2004-03-31 18:34:02.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/init.h>
 #include <asm/semaphore.h>
 
 /*
@@ -53,7 +54,7 @@
 	wake_up(&sem->wait);
 }
 
-asmlinkage void __down(struct semaphore * sem)
+asmlinkage void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -90,7 +91,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-asmlinkage int __down_interruptible(struct semaphore * sem)
+asmlinkage int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -187,7 +188,7 @@
  * value..
  */
 asm(
-".text\n"
+".section sched.text\n"
 ".align 4\n"
 ".globl __down_failed\n"
 "__down_failed:\n\t"
@@ -210,7 +211,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align 4\n"
 ".globl __down_failed_interruptible\n"
 "__down_failed_interruptible:\n\t"
@@ -231,7 +232,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align 4\n"
 ".globl __down_failed_trylock\n"
 "__down_failed_trylock:\n\t"
@@ -252,7 +253,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align 4\n"
 ".globl __up_wakeup\n"
 "__up_wakeup:\n\t"
@@ -271,7 +272,7 @@
  */
 #if defined(CONFIG_SMP)
 asm(
-".text\n"
+".section .sched.text\n"
 ".align	4\n"
 ".globl	__write_lock_failed\n"
 "__write_lock_failed:\n\t"
@@ -285,7 +286,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align	4\n"
 ".globl	__read_lock_failed\n"
 "__read_lock_failed:\n\t"
Index: sched-2.6.5-rc3/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/vmlinux.lds.S	2004-03-29 19:25:34.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/vmlinux.lds.S	2004-03-31 17:41:26.000000000 -0800
@@ -16,6 +16,7 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: sched-2.6.5-rc3/arch/ia64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ia64/kernel/process.c	2004-03-29 19:26:13.000000000 -0800
+++ sched-2.6.5-rc3/arch/ia64/kernel/process.c	2004-03-31 18:51:36.000000000 -0800
@@ -660,8 +660,6 @@
 	/*
 	 * These bracket the sleeping functions..
 	 */
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 #	define first_sched	((unsigned long) scheduling_functions_start_here)
 #	define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/ia64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ia64/kernel/semaphore.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/ia64/kernel/semaphore.c	2004-03-31 18:35:32.000000000 -0800
@@ -24,6 +24,7 @@
  * <asm/semaphore.h> where we want to avoid any extra jumps and calls.
  */
 #include <linux/sched.h>
+#include <linux/init.h>
 
 #include <asm/errno.h>
 #include <asm/semaphore.h>
@@ -44,8 +45,7 @@
 	wake_up(&sem->wait);
 }
 
-void
-__down (struct semaphore *sem)
+void __sched __down (struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -82,8 +82,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-int
-__down_interruptible (struct semaphore * sem)
+int __sched __down_interruptible (struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/ia64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/ia64/kernel/vmlinux.lds.S	2004-03-29 19:27:05.000000000 -0800
+++ sched-2.6.5-rc3/arch/ia64/kernel/vmlinux.lds.S	2004-03-31 17:41:32.000000000 -0800
@@ -41,6 +41,7 @@
     {
 	*(.text.ivt)
 	*(.text)
+	SCHED_TEXT
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
Index: sched-2.6.5-rc3/arch/m68k/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/process.c	2004-03-29 19:27:46.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/process.c	2004-03-31 18:36:49.000000000 -0800
@@ -65,8 +65,6 @@
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 	/* Check whether the thread is blocked in resume() */
 	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
@@ -387,8 +385,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
@@ -407,7 +403,6 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
 		if (pc < first_sched || pc >= last_sched)
 			return pc;
 		fp = *(unsigned long *) fp;
Index: sched-2.6.5-rc3/arch/m68k/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/semaphore.c	2004-03-29 19:26:54.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/semaphore.c	2004-03-31 18:37:07.000000000 -0800
@@ -5,6 +5,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 #ifndef CONFIG_RMW_INSNS
@@ -95,7 +96,7 @@
 	current->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -106,7 +107,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
Index: sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-std.lds
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/vmlinux-std.lds	2004-03-29 19:27:14.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-std.lds	2004-03-31 17:44:55.000000000 -0800
@@ -12,6 +12,7 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x4e75
Index: sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-sun3.lds
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/vmlinux-sun3.lds	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-sun3.lds	2004-03-31 17:45:10.000000000 -0800
@@ -13,6 +13,7 @@
   .text : {
 	*(.head)
 	*(.text)
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x4e75
Index: sched-2.6.5-rc3/arch/m68knommu/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68knommu/kernel/process.c	2004-03-29 19:25:35.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68knommu/kernel/process.c	2004-03-31 18:38:01.000000000 -0800
@@ -406,8 +406,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
@@ -426,7 +424,6 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
 		if (pc < first_sched || pc >= last_sched)
 			return pc;
 		fp = *(unsigned long *) fp;
@@ -439,8 +436,6 @@
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 
 	/* Check whether the thread is blocked in resume() */
Index: sched-2.6.5-rc3/arch/m68knommu/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68knommu/kernel/semaphore.c	2004-03-29 19:27:46.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68knommu/kernel/semaphore.c	2004-03-31 18:38:14.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 #ifndef CONFIG_RMW_INSNS
@@ -96,7 +97,7 @@
 	current->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -107,7 +108,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
Index: sched-2.6.5-rc3/arch/m68knommu/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68knommu/kernel/vmlinux.lds.S	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68knommu/kernel/vmlinux.lds.S	2004-03-31 17:41:39.000000000 -0800
@@ -191,6 +191,7 @@
 	.text : {
 		_stext = . ;
         	*(.text)
+		SCHED_TEXT
         	*(.text.lock)
 
 		. = ALIGN(16);          /* Exception table              */
Index: sched-2.6.5-rc3/arch/mips/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/mips/kernel/process.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/mips/kernel/process.c	2004-03-31 18:39:10.000000000 -0800
@@ -283,8 +283,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/mips/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/mips/kernel/semaphore.c	2004-03-29 19:26:31.000000000 -0800
+++ sched-2.6.5-rc3/arch/mips/kernel/semaphore.c	2004-03-31 18:39:25.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/sched.h>
 
 #ifdef CONFIG_CPU_HAS_LLDSCD
@@ -104,7 +105,7 @@
  * Either form may be used in conjunction with "up()".
  */
 
-void __down_failed(struct semaphore * sem)
+void __sched __down_failed(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	wait_queue_t wait;
@@ -227,7 +228,7 @@
 
 #endif /* !CONFIG_CPU_HAS_LLDSCD */
 
-int __down_failed_interruptible(struct semaphore * sem)
+int __sched __down_failed_interruptible(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	wait_queue_t wait;
Index: sched-2.6.5-rc3/arch/mips/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/mips/kernel/vmlinux.lds.S	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/mips/kernel/vmlinux.lds.S	2004-03-31 17:41:57.000000000 -0800
@@ -28,6 +28,7 @@
   _text = .;			/* Text and read-only data */
   .text : {
     *(.text)
+    SCHED_TEXT
     *(.fixup)
     *(.gnu.warning)
   } =0
Index: sched-2.6.5-rc3/arch/parisc/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/parisc/kernel/semaphore.c	2004-03-29 19:26:56.000000000 -0800
+++ sched-2.6.5-rc3/arch/parisc/kernel/semaphore.c	2004-03-31 18:39:44.000000000 -0800
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 /*
  * Semaphores are complex as we wish to avoid using two variables.
@@ -58,7 +59,7 @@
 	sem->count += (sem->count < 0) ? 1 : - 1;
 	
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	DOWN_HEAD
 
@@ -74,7 +75,7 @@
 	UPDATE_COUNT
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	DOWN_HEAD
 
Index: sched-2.6.5-rc3/arch/parisc/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/parisc/kernel/vmlinux.lds.S	2004-03-29 19:25:35.000000000 -0800
+++ sched-2.6.5-rc3/arch/parisc/kernel/vmlinux.lds.S	2004-03-31 17:42:03.000000000 -0800
@@ -50,6 +50,7 @@
   _text = .;			/* Text and read-only data */
   .text ALIGN(16) : {
 	*(.text*)
+	SCHED_TEXT
 	*(.PARISC.unwind)
 	*(.fixup)
 	*(.lock.text)		/* out-of-line lock text */
Index: sched-2.6.5-rc3/arch/ppc/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc/kernel/process.c	2004-03-29 19:26:14.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc/kernel/process.c	2004-03-31 18:53:28.000000000 -0800
@@ -659,8 +659,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched    ((unsigned long) scheduling_functions_start_here)
 #define last_sched     ((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/ppc/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc/kernel/semaphore.c	2004-03-31 18:42:16.000000000 -0800
@@ -15,6 +15,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/errno.h>
@@ -69,7 +70,7 @@
  * Thus it is only when we decrement count from some value > 0
  * that we have actually got the semaphore.
  */
-void __down(struct semaphore *sem)
+void __sched __down(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -99,7 +100,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc/kernel/vmlinux.lds.S	2004-03-29 19:27:47.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc/kernel/vmlinux.lds.S	2004-03-31 17:42:10.000000000 -0800
@@ -31,6 +31,7 @@
   .text      :
   {
     *(.text)
+    SCHED_TEXT
     *(.fixup)
     *(.got1)
     __got2_start = .;
Index: sched-2.6.5-rc3/arch/ppc64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc64/kernel/process.c	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc64/kernel/process.c	2004-03-31 18:54:19.000000000 -0800
@@ -475,8 +475,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched    (*(unsigned long *)scheduling_functions_start_here)
 #define last_sched     (*(unsigned long *)scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/ppc64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc64/kernel/semaphore.c	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc64/kernel/semaphore.c	2004-03-31 18:43:15.000000000 -0800
@@ -17,6 +17,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/errno.h>
@@ -70,7 +71,7 @@
  * Thus it is only when we decrement count from some value > 0
  * that we have actually got the semaphore.
  */
-void __down(struct semaphore *sem)
+void __sched __down(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -99,7 +100,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/ppc64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc64/kernel/vmlinux.lds.S	2004-03-29 19:26:57.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc64/kernel/vmlinux.lds.S	2004-03-31 17:42:17.000000000 -0800
@@ -13,6 +13,7 @@
   /* Read-only sections, merged into text segment: */
   .text : {
 	*(.text .text.*)
+	SCHED_TEXT
 	*(.fixup)
 	. = ALIGN(4096);
 	_etext = .;
Index: sched-2.6.5-rc3/arch/s390/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/s390/kernel/process.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/s390/kernel/process.c	2004-03-31 19:41:53.000000000 -0800
@@ -384,8 +384,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/s390/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/s390/kernel/semaphore.c	2004-03-29 19:27:15.000000000 -0800
+++ sched-2.6.5-rc3/arch/s390/kernel/semaphore.c	2004-03-31 18:45:20.000000000 -0800
@@ -11,6 +11,7 @@
  */
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -60,7 +61,7 @@
  *   count > 0: decrement count, wake up queue and exit.
  *   count <= 0: set count to -1, go to sleep.
  */
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -82,7 +83,7 @@
  *   count > 0: wake up queue and exit.
  *   count <= 0: set count to 0, wake up queue and exit.
  */
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/s390/kernel/vmlinux.lds.S	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/s390/kernel/vmlinux.lds.S	2004-03-31 17:42:25.000000000 -0800
@@ -23,6 +23,7 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
Index: sched-2.6.5-rc3/arch/sh/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sh/kernel/process.c	2004-03-29 19:26:55.000000000 -0800
+++ sched-2.6.5-rc3/arch/sh/kernel/process.c	2004-03-31 18:46:24.000000000 -0800
@@ -464,8 +464,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
@@ -481,7 +479,7 @@
 	 * The same comment as on the Alpha applies here, too ...
 	 */
 	pc = thread_saved_pc(p);
-	if (pc >= (unsigned long) interruptible_sleep_on && pc < (unsigned long) add_timer) {
+	if (pc >= first_sched && pc < last_sched) {
 		schedule_frame = ((unsigned long *)(long)p->thread.sp)[1];
 		return (unsigned long)((unsigned long *)schedule_frame)[1];
 	}
Index: sched-2.6.5-rc3/arch/sh/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sh/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/sh/kernel/semaphore.c	2004-03-31 18:46:38.000000000 -0800
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/init.h>
 #include <asm/semaphore.h>
 #include <asm/semaphore-helper.h>
 
@@ -103,7 +104,7 @@
 	tsk->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	DOWN_VAR
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
@@ -113,7 +114,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
 	DOWN_VAR
Index: sched-2.6.5-rc3/arch/sh/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sh/kernel/vmlinux.lds.S	2004-03-29 19:26:28.000000000 -0800
+++ sched-2.6.5-rc3/arch/sh/kernel/vmlinux.lds.S	2004-03-31 17:42:31.000000000 -0800
@@ -22,6 +22,7 @@
 	} = 0
   .text : {
 	*(.text)
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0009
Index: sched-2.6.5-rc3/arch/sparc/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/kernel/process.c	2004-03-29 19:25:33.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/kernel/process.c	2004-03-31 18:55:24.000000000 -0800
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/init.h>
 
 #include <asm/auxio.h>
 #include <asm/oplib.h>
@@ -694,9 +695,6 @@
 	return retval;
 }
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
Index: sched-2.6.5-rc3/arch/sparc/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/kernel/semaphore.c	2004-03-29 19:27:18.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/kernel/semaphore.c	2004-03-31 18:47:30.000000000 -0800
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -45,7 +46,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -78,7 +79,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/sparc/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/kernel/vmlinux.lds.S	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/kernel/vmlinux.lds.S	2004-03-31 17:42:42.000000000 -0800
@@ -12,6 +12,7 @@
   .text 0xf0004000 :
   {
     *(.text)
+    SCHED_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;
Index: sched-2.6.5-rc3/arch/sparc/lib/rwsem.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/lib/rwsem.S	2004-03-29 19:26:40.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/lib/rwsem.S	2004-03-30 23:25:37.000000000 -0800
@@ -8,7 +8,7 @@
 #include <asm/ptrace.h>
 #include <asm/psr.h>
 
-	.text
+	.section .sched.text
 	.align	4
 
 	.globl		___down_read
@@ -113,6 +113,7 @@
 	ba		2b
 	 restore	%l5, %g0, %g5
 
+	.text
 	.globl		___up_read
 ___up_read:
 	rd		%psr, %g3
Index: sched-2.6.5-rc3/arch/sparc64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/kernel/process.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/kernel/process.c	2004-03-31 18:54:56.000000000 -0800
@@ -28,6 +28,7 @@
 #include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
@@ -823,9 +824,6 @@
 	return error;
 }
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
Index: sched-2.6.5-rc3/arch/sparc64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/kernel/semaphore.c	2004-03-31 18:48:26.000000000 -0800
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 /*
  * Atomically update sem->count.
@@ -90,7 +91,7 @@
 	: "g5", "g7", "memory", "cc");
 }
 
-static void __down(struct semaphore * sem)
+static void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -108,7 +109,7 @@
 	wake_up(&sem->wait);
 }
 
-void down(struct semaphore *sem)
+void __sched down(struct semaphore *sem)
 {
 	might_sleep();
 	/* This atomically does:
@@ -192,7 +193,7 @@
 	return ret;
 }
 
-static int __down_interruptible(struct semaphore * sem)
+static int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -216,7 +217,7 @@
 	return retval;
 }
 
-int down_interruptible(struct semaphore *sem)
+int __sched down_interruptible(struct semaphore *sem)
 {
 	int ret = 0;
 	
Index: sched-2.6.5-rc3/arch/sparc64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/kernel/vmlinux.lds.S	2004-03-29 19:27:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/kernel/vmlinux.lds.S	2004-03-31 17:42:49.000000000 -0800
@@ -15,6 +15,7 @@
   .text 0x0000000000404000 :
   {
     *(.text)
+    SCHED_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;
Index: sched-2.6.5-rc3/arch/sparc64/lib/rwsem.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/lib/rwsem.c	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/lib/rwsem.c	2004-03-31 18:48:52.000000000 -0800
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
+#include <linux/init.h>
 #include <linux/module.h>
 
 extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
@@ -13,7 +14,7 @@
 extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
 extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct rw_semaphore *));
 
-void __down_read(struct rw_semaphore *sem)
+void __sched __down_read(struct rw_semaphore *sem)
 {
 	__asm__ __volatile__(
 		"! beginning __down_read\n"
@@ -72,7 +73,7 @@
 }
 EXPORT_SYMBOL(__down_read_trylock);
 
-void __down_write(struct rw_semaphore *sem)
+void __sched __down_write(struct rw_semaphore *sem)
 {
 	__asm__ __volatile__(
 		"! beginning __down_write\n\t"
Index: sched-2.6.5-rc3/arch/v850/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/v850/kernel/process.c	2004-03-29 19:25:34.000000000 -0800
+++ sched-2.6.5-rc3/arch/v850/kernel/process.c	2004-03-31 19:26:57.000000000 -0800
@@ -203,8 +203,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here (void);
-extern void scheduling_functions_end_here (void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
@@ -228,7 +226,6 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
 		if (pc < first_sched || pc >= last_sched)
 			return pc;
 		fp = *(unsigned long *) fp;
Index: sched-2.6.5-rc3/arch/v850/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/v850/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/v850/kernel/semaphore.c	2004-03-31 18:57:11.000000000 -0800
@@ -15,6 +15,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -56,7 +57,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -89,7 +90,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/v850/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/v850/kernel/vmlinux.lds.S	2004-03-29 19:26:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/v850/kernel/vmlinux.lds.S	2004-03-31 17:43:01.000000000 -0800
@@ -64,6 +64,7 @@
 #define TEXT_CONTENTS							      \
 		__stext = . ;						      \
         	*(.text)						      \
+		SCHED_TEXT
 			*(.exit.text)	/* 2.5 convention */		      \
 			*(.text.exit)	/* 2.4 convention */		      \
 			*(.text.lock)					      \
Index: sched-2.6.5-rc3/arch/x86_64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/kernel/process.c	2004-03-29 19:26:28.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/kernel/process.c	2004-03-31 18:58:07.000000000 -0800
@@ -576,8 +576,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
Index: sched-2.6.5-rc3/arch/x86_64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/kernel/semaphore.c	2004-03-29 19:27:47.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/kernel/semaphore.c	2004-03-31 18:58:21.000000000 -0800
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/errno.h>
 
 #include <asm/semaphore.h>
@@ -54,7 +55,7 @@
 	wake_up(&sem->wait);
 }
 
-void __down(struct semaphore * sem)
+void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -91,7 +92,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-int __down_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/kernel/vmlinux.lds.S	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/kernel/vmlinux.lds.S	2004-03-31 17:43:07.000000000 -0800
@@ -15,6 +15,7 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: sched-2.6.5-rc3/arch/x86_64/lib/thunk.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/lib/thunk.S	2004-03-29 19:26:11.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/lib/thunk.S	2004-03-30 23:25:37.000000000 -0800
@@ -35,6 +35,7 @@
 	.endm
 	
 
+	.section .sched.text
 #ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 	thunk rwsem_down_read_failed_thunk,rwsem_down_read_failed
 	thunk rwsem_down_write_failed_thunk,rwsem_down_write_failed
@@ -65,7 +66,7 @@
 
 #ifdef CONFIG_SMP
 /* Support for read/write spinlocks. */
-	
+	.text
 /* rax:	pointer to rwlock_t */	
 ENTRY(__write_lock_failed)
 	lock
Index: sched-2.6.5-rc3/include/linux/init.h
===================================================================
--- sched-2.6.5-rc3.orig/include/linux/init.h	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/include/linux/init.h	2004-03-30 23:25:37.000000000 -0800
@@ -46,6 +46,8 @@
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
+#define __sched		__attribute__((__section__(".sched.text")))
+
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
Index: sched-2.6.5-rc3/include/linux/sched.h
===================================================================
--- sched-2.6.5-rc3.orig/include/linux/sched.h	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/include/linux/sched.h	2004-03-30 23:25:37.000000000 -0800
@@ -170,6 +170,8 @@
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
+extern const unsigned long scheduling_functions_start_here;
+extern const unsigned long scheduling_functions_end_here;
 
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
Index: sched-2.6.5-rc3/include/asm-generic/vmlinux.lds.h
===================================================================
--- sched-2.6.5-rc3.orig/include/asm-generic/vmlinux.lds.h	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/include/asm-generic/vmlinux.lds.h	2004-03-31 17:40:21.000000000 -0800
@@ -51,3 +51,8 @@
 		*(.security_initcall.init) 				\
 		__security_initcall_end = .;				\
 	}
+
+#define SCHED_TEXT							\
+		__scheduling_functions_start_here = .;			\
+		*(.sched.text)						\
+		__scheduling_functions_end_here = .;
Index: sched-2.6.5-rc3/kernel/sched.c
===================================================================
--- sched-2.6.5-rc3.orig/kernel/sched.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/kernel/sched.c	2004-03-31 18:59:37.000000000 -0800
@@ -225,6 +225,13 @@
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
@@ -1587,12 +1594,10 @@
 	rebalance_tick(rq, 0);
 }
 
-void scheduling_functions_start_here(void) { }
-
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void schedule(void)
+asmlinkage void __sched schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -1731,7 +1736,7 @@
  * off of preempt_enable.  Kernel preemptions off return from interrupt
  * occur there and call schedule directly.
  */
-asmlinkage void preempt_schedule(void)
+asmlinkage void __sched preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
 
@@ -1869,7 +1874,7 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
-void fastcall wait_for_completion(struct completion *x)
+void fastcall __sched wait_for_completion(struct completion *x)
 {
 	might_sleep();
 	spin_lock_irq(&x->wait.lock);
@@ -1907,7 +1912,7 @@
 	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
 
-void fastcall interruptible_sleep_on(wait_queue_head_t *q)
+void fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1920,7 +1925,7 @@
 
 EXPORT_SYMBOL(interruptible_sleep_on);
 
-long fastcall interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long fastcall __sched interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1935,7 +1940,7 @@
 
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 
-void fastcall sleep_on(wait_queue_head_t *q)
+void fastcall __sched sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1948,7 +1953,7 @@
 
 EXPORT_SYMBOL(sleep_on);
 
-long fastcall sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long fastcall __sched sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1963,8 +1968,6 @@
 
 EXPORT_SYMBOL(sleep_on_timeout);
 
-void scheduling_functions_end_here(void) { }
-
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -2424,7 +2427,7 @@
 	return 0;
 }
 
-void __cond_resched(void)
+void __sched __cond_resched(void)
 {
 	set_current_state(TASK_RUNNING);
 	schedule();
@@ -2438,7 +2441,7 @@
  * this is a shortcut for kernel-space yielding - it marks the
  * thread runnable and calls sys_sched_yield().
  */
-void yield(void)
+void __sched yield(void)
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
@@ -2453,7 +2456,7 @@
  * But don't do that if it is a deliberate, throttling IO wait (this task
  * has set its backing_dev_info: the queue against which it should throttle)
  */
-void io_schedule(void)
+void __sched io_schedule(void)
 {
 	struct runqueue *rq = this_rq();
 
@@ -2464,7 +2467,7 @@
 
 EXPORT_SYMBOL(io_schedule);
 
-long io_schedule_timeout(long timeout)
+long __sched io_schedule_timeout(long timeout)
 {
 	struct runqueue *rq = this_rq();
 	long ret;
@@ -3009,7 +3012,7 @@
  *
  * Called inside preempt_disable().
  */
-void __preempt_spin_lock(spinlock_t *lock)
+void __sched __preempt_spin_lock(spinlock_t *lock)
 {
 	if (preempt_count() > 1) {
 		_raw_spin_lock(lock);
@@ -3025,7 +3028,7 @@
 
 EXPORT_SYMBOL(__preempt_spin_lock);
 
-void __preempt_write_lock(rwlock_t *lock)
+void __sched __preempt_write_lock(rwlock_t *lock)
 {
 	if (preempt_count() > 1) {
 		_raw_write_lock(lock);
Index: sched-2.6.5-rc3/kernel/timer.c
===================================================================
--- sched-2.6.5-rc3.orig/kernel/timer.c	2004-03-29 19:27:04.000000000 -0800
+++ sched-2.6.5-rc3/kernel/timer.c	2004-03-31 19:00:09.000000000 -0800
@@ -996,7 +996,7 @@
  *
  * In all cases the return value is guaranteed to be non-negative.
  */
-fastcall signed long schedule_timeout(signed long timeout)
+fastcall signed long __sched schedule_timeout(signed long timeout)
 {
 	struct timer_list timer;
 	unsigned long expire;
@@ -1056,7 +1056,7 @@
 	return current->pid;
 }
 
-static long nanosleep_restart(struct restart_block *restart)
+static long __sched nanosleep_restart(struct restart_block *restart)
 {
 	unsigned long expire = restart->arg0, now = jiffies;
 	struct timespec *rmtp = (struct timespec *) restart->arg1;
Index: sched-2.6.5-rc3/lib/rwsem.c
===================================================================
--- sched-2.6.5-rc3.orig/lib/rwsem.c	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/lib/rwsem.c	2004-03-31 19:00:55.000000000 -0800
@@ -5,6 +5,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <linux/module.h>
 
 struct rwsem_waiter {
@@ -162,7 +163,7 @@
 /*
  * wait for the read lock to be granted
  */
-struct rw_semaphore fastcall *rwsem_down_read_failed(struct rw_semaphore *sem)
+struct rw_semaphore fastcall __sched *rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
@@ -178,7 +179,7 @@
 /*
  * wait for the write lock to be granted
  */
-struct rw_semaphore fastcall *rwsem_down_write_failed(struct rw_semaphore *sem)
+struct rw_semaphore fastcall __sched *rwsem_down_write_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
