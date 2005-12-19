Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVLSBi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVLSBi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVLSBi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:38:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57987 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030227AbVLSBiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:38:55 -0500
Date: Mon, 19 Dec 2005 02:38:16 +0100
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
Subject: [patch 08/15] Generic Mutex Subsystem, mutex-migration-helper-i386.patch
Message-ID: <20051219013816.GD28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


introduce the arch_semaphore type on i386, to ease migration to mutexes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/i386/Kconfig            |    4 +++
 include/asm-i386/semaphore.h |   52 +++++++++++++++++++++++++++----------------
 2 files changed, 37 insertions(+), 19 deletions(-)

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -18,6 +18,10 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
+config ARCH_SEMAPHORES
+	bool
+	default y
+
 config X86
 	bool
 	default y
Index: linux/include/asm-i386/semaphore.h
===================================================================
--- linux.orig/include/asm-i386/semaphore.h
+++ linux/include/asm-i386/semaphore.h
@@ -1,10 +1,9 @@
 #ifndef _I386_SEMAPHORE_H
 #define _I386_SEMAPHORE_H
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 
-#ifdef __KERNEL__
-
 /*
  * SMP- and interrupt-safe semaphores..
  *
@@ -41,30 +40,40 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
+/*
+ * On !DEBUG_MUTEX_FULL, all semaphores map to the arch implementation:
+ */
+#ifndef CONFIG_DEBUG_MUTEX_FULL
+# define arch_semaphore semaphore
+#endif
+
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
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define __ARCH_DECLARE_SEMAPHORE_GENERIC(name,count) \
+	struct arch_semaphore name = __ARCH_SEMAPHORE_INITIALIZER(name,count)
 
-static inline void sema_init (struct semaphore *sem, int val)
+#define ARCH_DECLARE_MUTEX(name) __ARCH_DECLARE_SEMAPHORE_GENERIC(name,1)
+#define ARCH_DECLARE_MUTEX_LOCKED(name) __ARCH_DECLARE_SEMAPHORE_GENERIC(name,0)
+
+static inline void arch_sema_init (struct arch_semaphore *sem, int val)
 {
 /*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
+ *	*sem = (struct arch_semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
  *
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
@@ -74,14 +83,14 @@ static inline void sema_init (struct sem
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
 
 fastcall void __down_failed(void /* special register calling convention */);
@@ -94,7 +103,7 @@ fastcall void __up_wakeup(void /* specia
  * "__down_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/i386/kernel/semaphore.c
  */
-static inline void down(struct semaphore * sem)
+static inline void arch_down(struct arch_semaphore * sem)
 {
 	might_sleep();
 	__asm__ __volatile__(
@@ -116,7 +125,7 @@ static inline void down(struct semaphore
  * Interruptible try to acquire a semaphore.  If we obtained
  * it, return zero.  If we were interrupted, returns -EINTR
  */
-static inline int down_interruptible(struct semaphore * sem)
+static inline int arch_down_interruptible(struct arch_semaphore * sem)
 {
 	int result;
 
@@ -142,7 +151,7 @@ static inline int down_interruptible(str
  * Non-blockingly attempt to down() a semaphore.
  * Returns zero if we acquired it
  */
-static inline int down_trylock(struct semaphore * sem)
+static inline int arch_down_trylock(struct arch_semaphore * sem)
 {
 	int result;
 
@@ -169,7 +178,7 @@ static inline int down_trylock(struct se
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-static inline void up(struct semaphore * sem)
+static inline void arch_up(struct arch_semaphore * sem)
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
@@ -187,5 +196,10 @@ static inline void up(struct semaphore *
 		:"memory","ax");
 }
 
-#endif
+extern int FASTCALL(arch_sem_is_locked(struct arch_semaphore *sem));
+
+#define arch_sema_count(sem) atomic_read(&(sem)->count)
+
+#include <linux/semaphore.h>
+
 #endif
