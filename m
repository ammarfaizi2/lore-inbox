Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263488AbUJ2TtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbUJ2TtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUJ2Tqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:46:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:2008 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261772AbUJ2TVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:21:06 -0400
Date: Fri, 29 Oct 2004 12:20:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0410291217460.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here's a totally untested patch to make the semaphores use "fastcall" 
instead of "asmlinkage", and thus pass the argument in %eax instead of on 
the stack. Does it work? I have no idea. If it does, it should fix the 
particular bug that started this thread..

			Linus

---
===== arch/i386/kernel/semaphore.c 1.10 vs edited =====
--- 1.10/arch/i386/kernel/semaphore.c	2004-04-12 10:53:59 -07:00
+++ edited/arch/i386/kernel/semaphore.c	2004-10-29 12:19:22 -07:00
@@ -49,12 +49,12 @@
  *    we cannot lose wakeup events.
  */
 
-asmlinkage void __up(struct semaphore *sem)
+fastcall void __up(struct semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
 
-asmlinkage void __sched __down(struct semaphore * sem)
+fastcall void __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -91,7 +91,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-asmlinkage int __sched __down_interruptible(struct semaphore * sem)
+fastcall int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -154,7 +154,7 @@
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-asmlinkage int __down_trylock(struct semaphore * sem)
+fastcall int __down_trylock(struct semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;
@@ -183,9 +183,9 @@
  * need to convert that sequence back into the C sequence when
  * there is contention on the semaphore.
  *
- * %ecx contains the semaphore pointer on entry. Save the C-clobbered
- * registers (%eax, %edx and %ecx) except %eax when used as a return
- * value..
+ * %eax contains the semaphore pointer on entry. Save the C-clobbered
+ * registers (%eax, %edx and %ecx) except %eax whish is either a return
+ * value or just clobbered..
  */
 asm(
 ".section .sched.text\n"
@@ -196,13 +196,11 @@
 	"pushl %ebp\n\t"
 	"movl  %esp,%ebp\n\t"
 #endif
-	"pushl %eax\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
 	"call __down\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
-	"popl %eax\n\t"
 #if defined(CONFIG_FRAME_POINTER)
 	"movl %ebp,%esp\n\t"
 	"popl %ebp\n\t"
@@ -257,13 +255,11 @@
 ".align 4\n"
 ".globl __up_wakeup\n"
 "__up_wakeup:\n\t"
-	"pushl %eax\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
 	"call __up\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
-	"popl %eax\n\t"
 	"ret"
 );
 
===== include/asm-i386/linkage.h 1.4 vs edited =====
--- 1.4/include/asm-i386/linkage.h	2004-10-16 18:24:37 -07:00
+++ edited/include/asm-i386/linkage.h	2004-10-29 11:32:18 -07:00
@@ -1,7 +1,7 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
+#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(3)))
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 #define fastcall	__attribute__((regparm(3)))
 
===== include/asm-i386/semaphore.h 1.9 vs edited =====
--- 1.9/include/asm-i386/semaphore.h	2004-08-27 00:02:38 -07:00
+++ edited/include/asm-i386/semaphore.h	2004-10-29 12:06:48 -07:00
@@ -87,15 +87,15 @@
 	sema_init(sem, 0);
 }
 
-asmlinkage void __down_failed(void /* special register calling convention */);
-asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
-asmlinkage int  __down_failed_trylock(void  /* params in registers */);
-asmlinkage void __up_wakeup(void /* special register calling convention */);
-
-asmlinkage void __down(struct semaphore * sem);
-asmlinkage int  __down_interruptible(struct semaphore * sem);
-asmlinkage int  __down_trylock(struct semaphore * sem);
-asmlinkage void __up(struct semaphore * sem);
+fastcall void __down_failed(void /* special register calling convention */);
+fastcall int  __down_failed_interruptible(void  /* params in registers */);
+fastcall int  __down_failed_trylock(void  /* params in registers */);
+fastcall void __up_wakeup(void /* special register calling convention */);
+
+fastcall void __down(struct semaphore * sem);
+fastcall int  __down_interruptible(struct semaphore * sem);
+fastcall int  __down_trylock(struct semaphore * sem);
+fastcall void __up(struct semaphore * sem);
 
 /*
  * This is ugly, but we want the default case to fall through.
@@ -111,12 +111,13 @@
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed\n\t"
+		"2:\tlea %0,%%eax\n\t"
+		"call __down_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=m" (sem->count)
-		:"c" (sem)
-		:"memory");
+		:
+		:"memory","ax");
 }
 
 /*
@@ -135,11 +136,12 @@
 		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed_interruptible\n\t"
+		"2:\tlea %1,%%eax\n\t"
+		"call __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
-		:"c" (sem)
+		:
 		:"memory");
 	return result;
 }
@@ -159,11 +161,12 @@
 		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed_trylock\n\t"
+		"2:\tlea %1,%%eax\n\t"
+		"call __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
-		:"c" (sem)
+		:
 		:"memory");
 	return result;
 }
@@ -182,13 +185,14 @@
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __up_wakeup\n\t"
+		"2:\tlea %0,%%eax\n\t"
+		"call __up_wakeup\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		".subsection 0\n"
 		:"=m" (sem->count)
-		:"c" (sem)
-		:"memory");
+		:
+		:"memory","ax");
 }
 
 #endif
===== include/linux/spinlock.h 1.32 vs edited =====
--- 1.32/include/linux/spinlock.h	2004-10-24 16:24:20 -07:00
+++ edited/include/linux/spinlock.h	2004-10-29 12:08:14 -07:00
@@ -27,7 +27,7 @@
         extra                                   \
         ".ifndef " LOCK_SECTION_NAME "\n\t"     \
         LOCK_SECTION_NAME ":\n\t"               \
-        ".endif\n\t"
+        ".endif\n"
 
 #define LOCK_SECTION_END                        \
         ".previous\n\t"
