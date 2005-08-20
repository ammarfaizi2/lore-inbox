Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932799AbVHTC6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbVHTC6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 22:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbVHTC6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 22:58:47 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:50570 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932799AbVHTC6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 22:58:46 -0400
Date: Fri, 19 Aug 2005 22:54:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc6] i386: semaphore ownership tracking
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Message-ID: <200508192258_MC3-1-A7A8-D72@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch enables tracking semaphore ownership.  It saves a pointer to the
thread_info struct of the last process that got a semaphore.  I couldn't
think of a better way to print out the info, so I hacked up the code that
dumps a process's kernel stack so it prints out the PID of the owning process
when it finds another process waiting for a semaphore.

  So far it has worked under some light testing and should be fairly safe to use.
In general, if a process is sleeping on a semaphore, that semaphore shouldn't
disappear while this code is referencing it and neither should the owner.
Since this is really meant for finding deadlocks and not for general use I
think it should be OK.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/semaphore.c |   16 ++++++++++
 arch/i386/kernel/traps.c     |   10 ++++++
 include/asm-i386/semaphore.h |   66 ++++++++++++++++++++++++++++++++++++++-----
 lib/Kconfig.debug            |    9 +++++
 4 files changed, 94 insertions(+), 7 deletions(-)

--- 2.6.13-rc6c.orig/include/asm-i386/semaphore.h
+++ 2.6.13-rc6c/include/asm-i386/semaphore.h
@@ -45,15 +45,29 @@ struct semaphore {
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
+#ifdef CONFIG_SEMAPHORE_OWNER
+	struct thread_info *owner;
+#endif
 };
 
-
+#ifdef CONFIG_SEMAPHORE_OWNER
+void __down_return(void);
+void __down_intr_return(void);
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+	.owner		= NULL,						\
+}
+#else
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
+#endif /* CONFIG_SEMAPHORE_OWNER */
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -75,6 +89,9 @@ static inline void sema_init (struct sem
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
+#ifdef CONFIG_SEMAPHORE_OWNER
+	sem->owner = NULL;
+#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -105,13 +122,22 @@ static inline void down(struct semaphore
 		LOCK "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
+#ifdef CONFIG_SEMAPHORE_OWNER
+		"andl %%esp,%1\n"
+#endif
 		LOCK_SECTION_START("")
 		"2:\tlea %0,%%eax\n\t"
 		"call __down_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=m" (sem->count)
+#ifdef CONFIG_SEMAPHORE_OWNER
+			, "=r" (sem->owner)
+#endif
 		:
+#ifdef CONFIG_SEMAPHORE_OWNER
+		 "1" (~(THREAD_SIZE - 1))
+#endif
 		:"memory","ax");
 }
 
@@ -127,16 +153,29 @@ static inline int down_interruptible(str
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
-		"js 2f\n\t"
+		"js 3f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
+#ifdef CONFIG_SEMAPHORE_OWNER
+		"or %0,%0\n"
+		"jnz 2f\n"
+		"andl %%esp,%3\n"
+		"movl %3,%2\n"
+		"2:\n"
+#endif
 		LOCK_SECTION_START("")
-		"2:\tlea %1,%%eax\n\t"
+		"3:\tlea %1,%%eax\n\t"
 		"call __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=&a" (result), "=m" (sem->count)
+#ifdef CONFIG_SEMAPHORE_OWNER
+			, "=m" (sem->owner)
+#endif
 		:
+#ifdef CONFIG_SEMAPHORE_OWNER
+		 "r" (~(THREAD_SIZE - 1))
+#endif
 		:"memory");
 	return result;
 }
@@ -152,16 +191,29 @@ static inline int down_trylock(struct se
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
-		"js 2f\n\t"
+		"js 3f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
+#ifdef CONFIG_SEMAPHORE_OWNER
+		"or %0,%0\n"
+		"jnz 2f\n"
+		"andl %%esp,%3\n"
+		"movl %3,%2\n"
+		"2:\n"
+#endif
 		LOCK_SECTION_START("")
-		"2:\tlea %1,%%eax\n\t"
+		"3:\tlea %1,%%eax\n\t"
 		"call __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=&a" (result), "=m" (sem->count)
+#ifdef CONFIG_SEMAPHORE_OWNER
+			, "=m" (sem->owner)
+#endif
 		:
+#ifdef CONFIG_SEMAPHORE_OWNER
+		 "r" (~(THREAD_SIZE - 1))
+#endif
 		:"memory");
 	return result;
 }
--- 2.6.13-rc6c.orig/arch/i386/kernel/semaphore.c
+++ 2.6.13-rc6c/arch/i386/kernel/semaphore.c
@@ -198,7 +198,15 @@ asm(
 #endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
+#if defined(CONFIG_SEMAPHORE_OWNER)
+	"pushl %eax\n\t"
+#endif
 	"call __down\n\t"
+#if defined(CONFIG_SEMAPHORE_OWNER)
+"\n.globl __down_return\n"
+"__down_return:\n\t"
+	"popl %ecx\n\t"
+#endif
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 #if defined(CONFIG_FRAME_POINTER)
@@ -219,7 +227,15 @@ asm(
 #endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
+#if defined(CONFIG_SEMAPHORE_OWNER)
+	"pushl %eax\n\t"
+#endif
 	"call __down_interruptible\n\t"
+#if defined(CONFIG_SEMAPHORE_OWNER)
+"\n.globl __down_intr_return\n"
+"__down_intr_return:\n\t"
+	"popl %ecx\n\t"
+#endif
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 #if defined(CONFIG_FRAME_POINTER)
--- 2.6.13-rc6c.orig/lib/Kconfig.debug
+++ 2.6.13-rc6c/lib/Kconfig.debug
@@ -159,3 +159,12 @@ config FRAME_POINTER
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
+config SEMAPHORE_OWNER
+	bool "Track semaphore owners"
+	depends on DEBUG_KERNEL && FRAME_POINTER && (X86 && !X86_64)
+	default n
+	help
+	  Say Y to enable tracking of semaphore owners.
+
+	  If unsure, say N.
+
--- 2.6.13-rc6c.orig/arch/i386/kernel/traps.c
+++ 2.6.13-rc6c/arch/i386/kernel/traps.c
@@ -123,6 +123,16 @@ static inline unsigned long print_contex
 		addr = *(unsigned long *)(ebp + 4);
 		printk(" [<%08lx>] ", addr);
 		print_symbol("%s", addr);
+#ifdef CONFIG_SEMAPHORE_OWNER
+		if (addr == (unsigned long)__down_return
+		    || addr == (unsigned long)__down_intr_return) {
+			struct semaphore *sem = *(struct semaphore **)(ebp + 8);
+			if (sem && !((unsigned long)sem->owner & (THREAD_SIZE - 1)))
+				printk(" sem owner %s %d",
+					sem->owner ? "pid" : "(none)",
+					sem->owner ? sem->owner->task->pid : 0);
+		}
+#endif
 		printk("\n");
 		ebp = *(unsigned long *)ebp;
 	}
__
Chuck
