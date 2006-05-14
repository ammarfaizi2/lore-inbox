Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWENP5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWENP5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWENP5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:57:18 -0400
Received: from [63.81.120.158] ([63.81.120.158]:64466 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751473AbWENP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:57:17 -0400
Date: Sun, 14 May 2006 08:57:05 -0700
Message-Id: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH -rt 2/2] arm update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - Fixed arm mcount/arm_return_addr so they aren't under OABI_COMPAT ifdefs .
 - adds a new NR_syscalls macro, converts the old one into __NR_syscalls for
   calculating the table padding .
 - removes old semaphore __MUTEX_INITIALIZER()
 - depends blocker on X86 
 - updates clockfw_lock to a raw_spinlock_t


Looks like arm hasn't been compiled in a while .. Needs an updated for 
generic irqs too. There's still some struct semaphore usage , shouldn't 
they be either compat_semaphore or mutex types now ?

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/include/linux/plist.h
===================================================================
--- linux-2.6.16.orig/include/linux/plist.h
+++ linux-2.6.16/include/linux/plist.h
@@ -73,6 +73,7 @@
 #ifndef _LINUX_PLIST_H_
 #define _LINUX_PLIST_H_
 
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 
Index: linux-2.6.16/include/asm-arm/semaphore.h
===================================================================
--- linux-2.6.16.orig/include/asm-arm/semaphore.h
+++ linux-2.6.16/include/asm-arm/semaphore.h
@@ -19,7 +19,6 @@
  */
 #ifndef CONFIG_PREEMPT_RT
 # define semaphore compat_semaphore
-#define __MUTEX_INITIALIZER(name) __COMPAT_MUTEX_INITIALIZER(name)
 #endif
 
 #include <asm/atomic.h>
Index: linux-2.6.16/drivers/char/Kconfig
===================================================================
--- linux-2.6.16.orig/drivers/char/Kconfig
+++ linux-2.6.16/drivers/char/Kconfig
@@ -730,6 +730,7 @@ config RTC_HISTOGRAM
 
 config BLOCKER
 	tristate "Priority Inheritance Debugging (Blocker) Device Support"
+	depends on X86
 	default y
 	---help---
 	  If you say Y here then a device will be created that the userspace
Index: linux-2.6.16/include/asm-arm/arch/clock.h
===================================================================
--- linux-2.6.16.orig/include/asm-arm/arch/clock.h
+++ linux-2.6.16/include/asm-arm/arch/clock.h
@@ -48,7 +48,7 @@ struct clk_functions {
 
 extern unsigned int mpurate;
 extern struct list_head clocks;
-extern spinlock_t clockfw_lock;
+extern raw_spinlock_t clockfw_lock;
 
 extern int clk_init(struct clk_functions * custom_clocks);
 extern int clk_register(struct clk *clk);
Index: linux-2.6.16/arch/arm/kernel/calls.S
===================================================================
--- linux-2.6.16.orig/arch/arm/kernel/calls.S
+++ linux-2.6.16/arch/arm/kernel/calls.S
@@ -332,7 +332,7 @@
 /* 320 */	CALL(sys_get_mempolicy)
 		CALL(sys_set_mempolicy)
 #ifndef syscalls_counted
-.equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
+.equ syscalls_padding, ((__NR_syscalls + 3) & ~3) - __NR_syscalls
 #define syscalls_counted
 #endif
 .rept syscalls_padding
Index: linux-2.6.16/arch/arm/kernel/entry-common.S
===================================================================
--- linux-2.6.16.orig/arch/arm/kernel/entry-common.S
+++ linux-2.6.16/arch/arm/kernel/entry-common.S
@@ -90,8 +90,8 @@ ENTRY(ret_from_fork)
 	b	ret_slow_syscall
 	
 
-	.equ NR_syscalls,0
-#define CALL(x) .equ NR_syscalls,NR_syscalls+1
+	.equ __NR_syscalls,0			@ Used to determine syscall table padding.
+#define CALL(x) .equ __NR_syscalls,__NR_syscalls+1
 #include "calls.S"
 #undef CALL
 #define CALL(x) .long x
@@ -205,7 +205,7 @@ ENTRY(vector_swi)
 	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
 	bne	__sys_trace
 
-	cmp	scno, #NR_syscalls		@ check upper syscall limit
+	cmp	scno, #__NR_syscalls		@ check upper syscall limit
 	adr	lr, ret_fast_syscall		@ return address
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 
@@ -229,7 +229,7 @@ __sys_trace:
 	adr	lr, __sys_trace_return		@ return address
 	mov	scno, r0			@ syscall number (possibly new)
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	cmp	scno, #NR_syscalls		@ check upper syscall limit
+	cmp	scno, #__NR_syscalls		@ check upper syscall limit
 	ldmccia	r1, {r0 - r3}			@ have to reload r0 - r3
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 	b	2b
@@ -276,7 +276,7 @@ ENTRY(sys_call_table)
 sys_syscall:
 		eor	scno, r0, #__NR_OABI_SYSCALL_BASE
 		cmp	scno, #__NR_syscall - __NR_SYSCALL_BASE
-		cmpne	scno, #NR_syscalls	@ check range
+		cmpne	scno, #__NR_syscalls	@ check range
 		stmloia	sp, {r5, r6}		@ shuffle args
 		movlo	r0, r1
 		movlo	r1, r2
@@ -391,6 +391,7 @@ ENTRY(sys_oabi_call_table)
 #include "calls.S"
 #undef ABI
 #undef OBSOLETE
+#endif
 
 #ifdef CONFIG_FRAME_POINTER
 
@@ -499,5 +500,3 @@ arm_return_addr:
 
 #endif
 
-#endif
-
Index: linux-2.6.16/include/asm-arm/unistd.h
===================================================================
--- linux-2.6.16.orig/include/asm-arm/unistd.h
+++ linux-2.6.16/include/asm-arm/unistd.h
@@ -361,6 +361,9 @@
 #define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
 #define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
 
+// FIXME: check this number ...
+#define NR_syscalls			322
+
 /*
  * The following SWIs are ARM private.
  */
@@ -534,9 +537,6 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_SOCKETCALL
 #endif
 
-// FIXME: check this number ...
-#define NR_syscalls	328
-
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
