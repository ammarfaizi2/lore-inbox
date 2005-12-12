Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVLLXrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVLLXrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLLXrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:47:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32931 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932240AbVLLXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:17 -0500
Date: Mon, 12 Dec 2005 23:45:46 GMT
Message-Id: <200512122345.jBCNjkP8009029@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 2/19] MUTEX: i386 arch mutex
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames the functions of the i386 traditional semaphore
implementation to include "_sem" in their names and to remove the MUTEX macros
that are now provided by the new mutex facility.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-i386-2615rc5.diff
 arch/i386/kernel/cpu/proc.c   |    2 -
 arch/i386/kernel/i386_ksyms.c |   12 ++++++---
 arch/i386/kernel/semaphore.c  |   24 +++++++++---------
 include/asm-i386/mmu.h        |    4 +--
 include/asm-i386/semaphore.h  |   55 ++++++++++++++++--------------------------
 include/asm-i386/voyager.h    |    2 -
 6 files changed, 45 insertions(+), 54 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/asm-i386/mmu.h linux-2.6.15-rc5-mutex/include/asm-i386/mmu.h
--- /warthog/kernels/linux-2.6.15-rc5/include/asm-i386/mmu.h	2004-06-18 13:42:21.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/asm-i386/mmu.h	2005-12-12 18:49:34.000000000 +0000
@@ -1,7 +1,7 @@
 #ifndef __i386_MMU_H
 #define __i386_MMU_H
 
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
@@ -10,7 +10,7 @@
  */
 typedef struct { 
 	int size;
-	struct semaphore sem;
+	struct mutex sem;
 	void *ldt;
 } mm_context_t;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/asm-i386/semaphore.h linux-2.6.15-rc5-mutex/include/asm-i386/semaphore.h
--- /warthog/kernels/linux-2.6.15-rc5/include/asm-i386/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-i386/semaphore.h	2005-12-12 17:02:03.000000000 +0000
@@ -58,9 +58,6 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
-
 static inline void sema_init (struct semaphore *sem, int val)
 {
 /*
@@ -74,37 +71,27 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
-{
-	sema_init(sem, 1);
-}
-
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
-{
-	sema_init(sem, 0);
-}
-
-fastcall void __down_failed(void /* special register calling convention */);
-fastcall int  __down_failed_interruptible(void  /* params in registers */);
-fastcall int  __down_failed_trylock(void  /* params in registers */);
-fastcall void __up_wakeup(void /* special register calling convention */);
+fastcall void __down_sem_failed(void /* special register calling convention */);
+fastcall int  __down_sem_failed_interruptible(void  /* params in registers */);
+fastcall int  __down_sem_failed_trylock(void  /* params in registers */);
+fastcall void __up_sem_wakeup(void /* special register calling convention */);
 
 /*
  * This is ugly, but we want the default case to fall through.
  * "__down_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/i386/kernel/semaphore.c
  */
-static inline void down(struct semaphore * sem)
+static inline void down_sem(struct semaphore * sem)
 {
 	might_sleep();
 	__asm__ __volatile__(
-		"# atomic down operation\n\t"
+		"# atomic down_sem operation\n\t"
 		LOCK "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
 		"2:\tlea %0,%%eax\n\t"
-		"call __down_failed\n\t"
+		"call __down_sem_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=m" (sem->count)
@@ -113,23 +100,23 @@ static inline void down(struct semaphore
 }
 
 /*
- * Interruptible try to acquire a semaphore.  If we obtained
- * it, return zero.  If we were interrupted, returns -EINTR
+ * Interrup_semtible try to acquire a semaphore.  If we obtained
+ * it, return zero.  If we were interrup_semted, returns -EINTR
  */
-static inline int down_interruptible(struct semaphore * sem)
+static inline int down_sem_interrup_semtible(struct semaphore * sem)
 {
 	int result;
 
 	might_sleep();
 	__asm__ __volatile__(
-		"# atomic interruptible down operation\n\t"
+		"# atomic interrup_semtible down_sem operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
 		"2:\tlea %1,%%eax\n\t"
-		"call __down_failed_interruptible\n\t"
+		"call __down_sem_failed_interrup_semtible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
@@ -139,22 +126,22 @@ static inline int down_interruptible(str
 }
 
 /*
- * Non-blockingly attempt to down() a semaphore.
+ * Non-blockingly attempt to down_sem() a semaphore.
  * Returns zero if we acquired it
  */
-static inline int down_trylock(struct semaphore * sem)
+static inline int down_sem_trylock(struct semaphore * sem)
 {
 	int result;
 
 	__asm__ __volatile__(
-		"# atomic interruptible down operation\n\t"
+		"# atomic interrup_semtible down_sem operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
 		"2:\tlea %1,%%eax\n\t"
-		"call __down_failed_trylock\n\t"
+		"call __down_sem_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
@@ -164,21 +151,21 @@ static inline int down_trylock(struct se
 }
 
 /*
- * Note! This is subtle. We jump to wake people up only if
+ * Note! This is subtle. We jump to wake people up_sem only if
  * the semaphore was negative (== somebody was waiting on it).
  * The default case (no contention) will result in NO
- * jumps for both down() and up().
+ * jumps for both down_sem() and up_sem().
  */
-static inline void up(struct semaphore * sem)
+static inline void up_sem(struct semaphore * sem)
 {
 	__asm__ __volatile__(
-		"# atomic up operation\n\t"
+		"# atomic up_sem operation\n\t"
 		LOCK "incl %0\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
 		"2:\tlea %0,%%eax\n\t"
-		"call __up_wakeup\n\t"
+		"call __up_sem_wakeup\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		".subsection 0\n"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/asm-i386/voyager.h linux-2.6.15-rc5-mutex/include/asm-i386/voyager.h
--- /warthog/kernels/linux-2.6.15-rc5/include/asm-i386/voyager.h	2004-06-18 13:42:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/asm-i386/voyager.h	2005-12-12 19:51:20.000000000 +0000
@@ -489,7 +489,7 @@ extern struct voyager_SUS *voyager_SUS;
 /* variables exported always */
 extern int voyager_level;
 extern int kvoyagerd_running;
-extern struct semaphore kvoyagerd_sem;
+extern struct mutex kvoyagerd_sem;
 extern struct voyager_status voyager_status;
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/i386/kernel/cpu/proc.c linux-2.6.15-rc5-mutex/arch/i386/kernel/cpu/proc.c
--- /warthog/kernels/linux-2.6.15-rc5/arch/i386/kernel/cpu/proc.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/i386/kernel/cpu/proc.c	2005-12-12 18:50:39.000000000 +0000
@@ -1,7 +1,7 @@
 #include <linux/smp.h>
 #include <linux/timex.h>
 #include <linux/string.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 #include <linux/seq_file.h>
 
 /*
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/i386/kernel/i386_ksyms.c linux-2.6.15-rc5-mutex/arch/i386/kernel/i386_ksyms.c
--- /warthog/kernels/linux-2.6.15-rc5/arch/i386/kernel/i386_ksyms.c	2005-08-30 13:56:11.000000000 +0100
+++ linux-2.6.15-rc5-mutex/arch/i386/kernel/i386_ksyms.c	2005-12-12 18:50:31.000000000 +0000
@@ -1,15 +1,19 @@
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <asm/checksum.h>
 #include <asm/desc.h>
 
 /* This is definitely a GPL-only symbol */
 EXPORT_SYMBOL_GPL(cpu_gdt_table);
 
-EXPORT_SYMBOL(__down_failed);
-EXPORT_SYMBOL(__down_failed_interruptible);
-EXPORT_SYMBOL(__down_failed_trylock);
-EXPORT_SYMBOL(__up_wakeup);
+EXPORT_SYMBOL(__down);
+EXPORT_SYMBOL(__down_interruptible);
+EXPORT_SYMBOL(__up);
+EXPORT_SYMBOL(__down_sem_failed);
+EXPORT_SYMBOL(__down_sem_failed_interruptible);
+EXPORT_SYMBOL(__down_sem_failed_trylock);
+EXPORT_SYMBOL(__up_sem_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/i386/kernel/semaphore.c linux-2.6.15-rc5-mutex/arch/i386/kernel/semaphore.c
--- /warthog/kernels/linux-2.6.15-rc5/arch/i386/kernel/semaphore.c	2005-11-01 13:18:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/i386/kernel/semaphore.c	2005-12-12 18:08:03.000000000 +0000
@@ -28,15 +28,15 @@
 asm(
 ".section .sched.text\n"
 ".align 4\n"
-".globl __down_failed\n"
-"__down_failed:\n\t"
+".globl __down_sem_failed\n"
+"__down_sem_failed:\n\t"
 #if defined(CONFIG_FRAME_POINTER)
 	"pushl %ebp\n\t"
 	"movl  %esp,%ebp\n\t"
 #endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
-	"call __down\n\t"
+	"call __down_sem\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 #if defined(CONFIG_FRAME_POINTER)
@@ -49,15 +49,15 @@ asm(
 asm(
 ".section .sched.text\n"
 ".align 4\n"
-".globl __down_failed_interruptible\n"
-"__down_failed_interruptible:\n\t"
+".globl __down_sem_failed_interruptible\n"
+"__down_sem_failed_interruptible:\n\t"
 #if defined(CONFIG_FRAME_POINTER)
 	"pushl %ebp\n\t"
 	"movl  %esp,%ebp\n\t"
 #endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
-	"call __down_interruptible\n\t"
+	"call __down_sem_interruptible\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 #if defined(CONFIG_FRAME_POINTER)
@@ -70,15 +70,15 @@ asm(
 asm(
 ".section .sched.text\n"
 ".align 4\n"
-".globl __down_failed_trylock\n"
-"__down_failed_trylock:\n\t"
+".globl __down_sem_failed_trylock\n"
+"__down_sem_failed_trylock:\n\t"
 #if defined(CONFIG_FRAME_POINTER)
 	"pushl %ebp\n\t"
 	"movl  %esp,%ebp\n\t"
 #endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
-	"call __down_trylock\n\t"
+	"call __down_sem_trylock\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 #if defined(CONFIG_FRAME_POINTER)
@@ -91,11 +91,11 @@ asm(
 asm(
 ".section .sched.text\n"
 ".align 4\n"
-".globl __up_wakeup\n"
-"__up_wakeup:\n\t"
+".globl __up_sem_wakeup\n"
+"__up_sem_wakeup:\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
-	"call __up\n\t"
+	"call __up_sem\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 	"ret"
