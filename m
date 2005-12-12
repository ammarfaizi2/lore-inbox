Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVLLXr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVLLXr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVLLXrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:47:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932226AbVLLXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:17 -0500
Date: Mon, 12 Dec 2005 23:45:47 GMT
Message-Id: <200512122345.jBCNjlH9009031@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 3/19] MUTEX: x86_64 arch mutex
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames the functions of the x86_64 traditional semaphore
implementation to include "_sem" in their names and to remove the MUTEX macros
that are now provided by the new mutex facility.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-x86_64-2615rc5.diff
 arch/x86_64/kernel/x8664_ksyms.c |   10 +++----
 arch/x86_64/lib/thunk.S          |    8 +++---
 include/asm-x86_64/mmu.h         |    4 +--
 include/asm-x86_64/semaphore.h   |   49 ++++++++++++++-------------------------
 4 files changed, 29 insertions(+), 42 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/asm-x86_64/mmu.h linux-2.6.15-rc5-mutex/include/asm-x86_64/mmu.h
--- /warthog/kernels/linux-2.6.15-rc5/include/asm-x86_64/mmu.h	2004-06-18 13:42:14.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/asm-x86_64/mmu.h	2005-12-12 19:50:13.000000000 +0000
@@ -2,7 +2,7 @@
 #define __x86_64_MMU_H
 
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 /*
  * The x86_64 doesn't have a mmu context, but
@@ -14,7 +14,7 @@ typedef struct { 
 	void *ldt;
 	rwlock_t ldtlock; 
 	int size;
-	struct semaphore sem; 
+	struct mutex sem; 
 } mm_context_t;
 
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/asm-x86_64/semaphore.h linux-2.6.15-rc5-mutex/include/asm-x86_64/semaphore.h
--- /warthog/kernels/linux-2.6.15-rc5/include/asm-x86_64/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-x86_64/semaphore.h	2005-12-12 22:28:09.000000000 +0000
@@ -59,9 +59,6 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
-
 static inline void sema_init (struct semaphore *sem, int val)
 {
 /*
@@ -75,32 +72,22 @@ static inline void sema_init (struct sem
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
-asmlinkage void __down_failed(void /* special register calling convention */);
-asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
-asmlinkage int  __down_failed_trylock(void  /* params in registers */);
-asmlinkage void __up_wakeup(void /* special register calling convention */);
-
-asmlinkage void __down(struct semaphore * sem);
-asmlinkage int  __down_interruptible(struct semaphore * sem);
-asmlinkage int  __down_trylock(struct semaphore * sem);
-asmlinkage void __up(struct semaphore * sem);
+asmlinkage void __down_sem_failed(void /* special register calling convention */);
+asmlinkage int  __down_sem_failed_interruptible(void  /* params in registers */);
+asmlinkage int  __down_sem_failed_trylock(void  /* params in registers */);
+asmlinkage void __up_sem_wakeup(void /* special register calling convention */);
+
+asmlinkage void __down_sem(struct semaphore * sem);
+asmlinkage int  __down_sem_interruptible(struct semaphore * sem);
+asmlinkage int  __down_sem_trylock(struct semaphore * sem);
+asmlinkage void __up_sem(struct semaphore * sem);
 
 /*
  * This is ugly, but we want the default case to fall through.
- * "__down_failed" is a special asm handler that calls the C
+ * "__down_sem_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/x86_64/kernel/semaphore.c
  */
-static inline void down(struct semaphore * sem)
+static inline void down_sem(struct semaphore * sem)
 {
 	might_sleep();
 
@@ -110,7 +97,7 @@ static inline void down(struct semaphore
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed\n\t"
+		"2:\tcall __down_sem_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=m" (sem->count)
@@ -122,7 +109,7 @@ static inline void down(struct semaphore
  * Interruptible try to acquire a semaphore.  If we obtained
  * it, return zero.  If we were interrupted, returns -EINTR
  */
-static inline int down_interruptible(struct semaphore * sem)
+static inline int down_sem_interruptible(struct semaphore * sem)
 {
 	int result;
 
@@ -135,7 +122,7 @@ static inline int down_interruptible(str
 		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed_interruptible\n\t"
+		"2:\tcall __down_sem_failed_interruptible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
@@ -148,7 +135,7 @@ static inline int down_interruptible(str
  * Non-blockingly attempt to down() a semaphore.
  * Returns zero if we acquired it
  */
-static inline int down_trylock(struct semaphore * sem)
+static inline int down_sem_trylock(struct semaphore * sem)
 {
 	int result;
 
@@ -159,7 +146,7 @@ static inline int down_trylock(struct se
 		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed_trylock\n\t"
+		"2:\tcall __down_sem_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
@@ -174,7 +161,7 @@ static inline int down_trylock(struct se
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-static inline void up(struct semaphore * sem)
+static inline void up_sem(struct semaphore * sem)
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
@@ -182,7 +169,7 @@ static inline void up(struct semaphore *
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __up_wakeup\n\t"
+		"2:\tcall __up_sem_wakeup\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		:"=m" (sem->count)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.15-rc5-mutex/arch/x86_64/kernel/x8664_ksyms.c
--- /warthog/kernels/linux-2.6.15-rc5/arch/x86_64/kernel/x8664_ksyms.c	2005-12-08 16:23:37.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/x86_64/kernel/x8664_ksyms.c	2005-12-12 22:33:36.000000000 +0000
@@ -14,8 +14,8 @@
 #include <linux/syscalls.h>
 #include <linux/tty.h>
 #include <linux/ioctl32.h>
+#include <linux/semaphore.h>
 
-#include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/uaccess.h>
@@ -62,10 +62,10 @@ EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
 
-EXPORT_SYMBOL(__down_failed);
-EXPORT_SYMBOL(__down_failed_interruptible);
-EXPORT_SYMBOL(__down_failed_trylock);
-EXPORT_SYMBOL(__up_wakeup);
+EXPORT_SYMBOL(__down_sem_failed);
+EXPORT_SYMBOL(__down_sem_failed_interruptible);
+EXPORT_SYMBOL(__down_sem_failed_trylock);
+EXPORT_SYMBOL(__up_sem_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(ip_compute_csum);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/x86_64/lib/thunk.S linux-2.6.15-rc5-mutex/arch/x86_64/lib/thunk.S
--- /warthog/kernels/linux-2.6.15-rc5/arch/x86_64/lib/thunk.S	2004-06-18 13:41:13.000000000 +0100
+++ linux-2.6.15-rc5-mutex/arch/x86_64/lib/thunk.S	2005-12-12 22:32:51.000000000 +0000
@@ -44,10 +44,10 @@
 #endif	
 	thunk do_softirq_thunk,do_softirq
 	
-	thunk __down_failed,__down
-	thunk_retrax __down_failed_interruptible,__down_interruptible
-	thunk_retrax __down_failed_trylock,__down_trylock
-	thunk __up_wakeup,__up
+	thunk __down_sem_failed,__down_sem
+	thunk_retrax __down_sem_failed_interruptible,__down_sem_interruptible
+	thunk_retrax __down_sem_failed_trylock,__down_sem_trylock
+	thunk __up_sem_wakeup,__up_sem
 	
 	/* SAVE_ARGS below is used only for the .cfi directives it contains. */
 	CFI_STARTPROC
