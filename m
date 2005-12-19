Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVLSBkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVLSBkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVLSBjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:39:40 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43751 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030225AbVLSBjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:39:08 -0500
Date: Mon, 19 Dec 2005 02:38:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: [patch 09/15] Generic Mutex Subsystem, mutex-migration-helper-x86_64.patch
Message-ID: <20051219013827.GE28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


introduce the arch_semaphore type on x86_64, to ease migration to 
mutexes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 arch/x86_64/Kconfig            |    4 ++
 include/asm-x86_64/semaphore.h |   61 ++++++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 22 deletions(-)

Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -28,6 +28,10 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
+config ARCH_SEMAPHORES
+	bool
+	default y
+
 config MMU
 	bool
 	default y
Index: linux/include/asm-x86_64/semaphore.h
===================================================================
--- linux.orig/include/asm-x86_64/semaphore.h
+++ linux/include/asm-x86_64/semaphore.h
@@ -1,9 +1,15 @@
 #ifndef _X86_64_SEMAPHORE_H
 #define _X86_64_SEMAPHORE_H
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 
-#ifdef __KERNEL__
+/*
+ * On !DEBUG_MUTEX_FULL, all semaphores map to the arch implementation:
+ */
+#ifndef CONFIG_DEBUG_MUTEX_FULL
+# define arch_semaphore semaphore
+#endif
 
 /*
  * SMP- and interrupt-safe semaphores..
@@ -43,29 +49,34 @@
 #include <linux/rwsem.h>
 #include <linux/stringify.h>
 
-struct semaphore {
+struct arch_semaphore {
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
-#define __SEMAPHORE_INITIALIZER(name, n)				\
+#define __ARCH_SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
+#define __ARCH_MUTEX_INITIALIZER(name) \
+	__ARCH_SEMAPHORE_INITIALIZER(name,1)
+
+#define __ARCH_DECLARE_SEMAPHORE_GENERIC(name,count) \
+	struct arch_semaphore name = __ARCH_SEMAPHORE_INITIALIZER(name,count)
+
+#define ARCH_DECLARE_MUTEX(name) __ARCH_DECLARE_SEMAPHORE_GENERIC(name,1)
+#define ARCH_DECLARE_MUTEX_LOCKED(name) __ARCH_DECLARE_SEMAPHORE_GENERIC(name,0)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define arch_sema_count(sem) atomic_read(&(sem)->count)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void arch_sema_init (struct arch_semaphore *sem, int val)
 {
 /*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
+ *	*sem = (struct arch_semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
  *
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
@@ -75,14 +86,14 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+static inline void arch_init_MUTEX (struct arch_semaphore *sem)
 {
-	sema_init(sem, 1);
+	arch_sema_init(sem, 1);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void arch_init_MUTEX_LOCKED (struct arch_semaphore *sem)
 {
-	sema_init(sem, 0);
+	arch_sema_init(sem, 0);
 }
 
 asmlinkage void __down_failed(void /* special register calling convention */);
@@ -90,17 +101,17 @@ asmlinkage int  __down_failed_interrupti
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
 asmlinkage void __up_wakeup(void /* special register calling convention */);
 
-asmlinkage void __down(struct semaphore * sem);
-asmlinkage int  __down_interruptible(struct semaphore * sem);
-asmlinkage int  __down_trylock(struct semaphore * sem);
-asmlinkage void __up(struct semaphore * sem);
+asmlinkage void __down(struct arch_semaphore * sem);
+asmlinkage int  __down_interruptible(struct arch_semaphore * sem);
+asmlinkage int  __down_trylock(struct arch_semaphore * sem);
+asmlinkage void __up(struct arch_semaphore * sem);
 
 /*
  * This is ugly, but we want the default case to fall through.
  * "__down_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/x86_64/kernel/semaphore.c
  */
-static inline void down(struct semaphore * sem)
+static inline void arch_down(struct arch_semaphore * sem)
 {
 	might_sleep();
 
@@ -122,7 +133,7 @@ static inline void down(struct semaphore
  * Interruptible try to acquire a semaphore.  If we obtained
  * it, return zero.  If we were interrupted, returns -EINTR
  */
-static inline int down_interruptible(struct semaphore * sem)
+static inline int arch_down_interruptible(struct arch_semaphore * sem)
 {
 	int result;
 
@@ -148,7 +159,7 @@ static inline int down_interruptible(str
  * Non-blockingly attempt to down() a semaphore.
  * Returns zero if we acquired it
  */
-static inline int down_trylock(struct semaphore * sem)
+static inline int arch_down_trylock(struct arch_semaphore * sem)
 {
 	int result;
 
@@ -174,7 +185,7 @@ static inline int down_trylock(struct se
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-static inline void up(struct semaphore * sem)
+static inline void arch_up(struct arch_semaphore * sem)
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
@@ -189,5 +200,11 @@ static inline void up(struct semaphore *
 		:"D" (sem)
 		:"memory");
 }
-#endif /* __KERNEL__ */
+
+extern int FASTCALL(arch_sem_is_locked(struct arch_semaphore *sem));
+
+#define arch_sema_count(sem) atomic_read(&(sem)->count)
+
+#include <linux/semaphore.h>
+
 #endif
