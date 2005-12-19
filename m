Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVLSBjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVLSBjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVLSBjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:39:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63875 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030227AbVLSBjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:39:22 -0500
Date: Mon, 19 Dec 2005 02:38:37 +0100
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
Subject: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
Message-ID: <20051219013837.GF28038@elte.hu>
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


introduce the mutex_debug type, and switch the semaphore APIs to it in a 
type-sensitive way. Plain semaphores will still use the proper 
arch-semaphore calls.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/mutex.h     |  116 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/semaphore.h |   64 +++++++++++++++++++++++++
 kernel/mutex.c            |   73 ++++++++++++++++++++++++++++
 lib/Kconfig.debug         |   28 +++++++++++
 lib/semaphore-sleepers.c  |   16 ++++--
 5 files changed, 293 insertions(+), 4 deletions(-)

Index: linux/include/linux/mutex.h
===================================================================
--- linux.orig/include/linux/mutex.h
+++ linux/include/linux/mutex.h
@@ -99,4 +99,120 @@ extern int FASTCALL(mutex_trylock(struct
 extern void FASTCALL(mutex_unlock(struct mutex *lock));
 extern int FASTCALL(mutex_is_locked(struct mutex *lock));
 
+/*
+ * Debugging variant of mutexes. The only difference is that they accept
+ * the semaphore APIs too:
+ */
+struct mutex_debug {
+	struct mutex lock;
+};
+
+#define DEFINE_MUTEX_DEBUG(mutexname) \
+	struct mutex_debug mutexname = \
+		{ .lock = __MUTEX_INITIALIZER(mutexname.lock) }
+
+extern void FASTCALL(mutex_debug_down(struct mutex_debug *lock));
+extern int FASTCALL(mutex_debug_down_interruptible(struct mutex_debug *lock));
+extern int FASTCALL(mutex_debug_down_trylock(struct mutex_debug *lock));
+extern void FASTCALL(mutex_debug_up(struct mutex_debug *lock));
+extern int FASTCALL(mutex_debug_sem_is_locked(struct mutex_debug *lock));
+
+/*
+ * The down()/up() type-safe wrappers, for debug mutexes:
+ */
+
+extern int __bad_mutex_debug_func_type(void);
+
+#undef TYPE_EQUAL
+#define TYPE_EQUAL(var, type) \
+		__builtin_types_compatible_p(typeof(var), type *)
+
+#define PICK_FUNC_1ARG(type1, type2, func1, func2, arg)			\
+do {									\
+	if (TYPE_EQUAL((arg), type1))					\
+		func1((type1 *)(arg));					\
+	else if (TYPE_EQUAL((arg), type2))				\
+		func2((type2 *)(arg));					\
+	else __bad_mutex_debug_func_type();				\
+} while (0)
+
+#define PICK_FUNC_1ARG_RET(type1, type2, func1, func2, arg)		\
+({									\
+	unsigned long __ret;						\
+									\
+	if (TYPE_EQUAL((arg), type1))					\
+		__ret = func1((type1 *)(arg));				\
+	else if (TYPE_EQUAL((arg), type2))				\
+		__ret = func2((type2 *)(arg));				\
+	else __ret = __bad_mutex_debug_func_type();			\
+									\
+	__ret;								\
+})
+
+#define PICK_FUNC_2ARG(type1, type2, func1, func2, arg0, arg1)		\
+do {									\
+	if (TYPE_EQUAL((arg0), type1))					\
+		func1((type1 *)(arg0), arg1);				\
+	else if (TYPE_EQUAL((arg0), type2))				\
+		func2((type2 *)(arg0), arg1);				\
+	else __bad_mutex_debug_func_type();				\
+} while (0)
+
+#define sema_init(sem, val) \
+	PICK_FUNC_2ARG(struct arch_semaphore, struct mutex_debug, \
+		arch_sema_init, mutex_debug_sema_init, sem, val)
+
+#define init_MUTEX(sem) \
+	PICK_FUNC_1ARG(struct arch_semaphore, struct mutex_debug, \
+		arch_init_MUTEX, mutex_debug_init_MUTEX, sem)
+
+#define init_MUTEX_LOCKED(sem) \
+	PICK_FUNC_1ARG(struct arch_semaphore, struct mutex_debug, \
+		arch_init_MUTEX_LOCKED, mutex_debug_init_MUTEX_LOCKED, sem)
+
+#define down(sem) \
+	PICK_FUNC_1ARG(struct arch_semaphore, struct mutex_debug, \
+		arch_down, mutex_debug_down, sem)
+
+#define down_interruptible(sem) \
+	PICK_FUNC_1ARG_RET(struct arch_semaphore, struct mutex_debug, \
+		arch_down_interruptible, mutex_debug_down_interruptible, sem)
+
+#define down_trylock(sem) \
+	PICK_FUNC_1ARG_RET(struct arch_semaphore, struct mutex_debug, \
+		arch_down_trylock, mutex_debug_down_trylock, sem)
+
+#define up(sem) \
+	PICK_FUNC_1ARG(struct arch_semaphore, struct mutex_debug, \
+		arch_up, mutex_debug_up, sem)
+
+#define sem_is_locked(sem) \
+	PICK_FUNC_1ARG_RET(struct arch_semaphore, struct mutex_debug, \
+		arch_sem_is_locked, mutex_debug_sem_is_locked, sem)
+
+#define sema_count(sem) \
+	PICK_FUNC_1ARG_RET(struct arch_semaphore, struct mutex_debug, \
+		arch_sema_count, mutex_debug_sema_count, sem)
+
+#ifdef CONFIG_DEBUG_MUTEXESS
+  extern FASTCALL(void __mutex_debug_sema_init(struct mutex_debug *lock,
+		  int val, char *name, char *file, int line));
+# define mutex_debug_sema_init(sem, val) \
+		__mutex_debug_sema_init(sem, val, #sem, __FILE__, __LINE__)
+#else
+  extern FASTCALL(void __mutex_debug_sema_init(struct mutex_debug *lock, int val));
+# define mutex_debug_sema_init(sem, val) \
+		__mutex_debug_sema_init(sem, val)
+#endif
+
+#define mutex_debug_init_MUTEX(sem) mutex_debug_sema_init(sem, 1)
+
+/*
+ * No locked initialization for mutexes:
+ */
+extern void there_is_no_init_MUTEX_LOCKED_for_mutexes(void);
+
+#define mutex_debug_init_MUTEX_LOCKED(sem) \
+		there_is_no_init_MUTEX_LOCKED_for_mutexes()
+
 #endif
Index: linux/include/linux/semaphore.h
===================================================================
--- /dev/null
+++ linux/include/linux/semaphore.h
@@ -0,0 +1,64 @@
+#ifndef _LINUX_SEMAPHORE_H
+#define _LINUX_SEMAPHORE_H
+
+#include <linux/config.h>
+#include <linux/mutex.h>
+
+#ifdef CONFIG_DEBUG_MUTEX_FULL
+# define semaphore		mutex_debug
+# define DECLARE_MUTEX		DEFINE_MUTEX_DEBUG
+#else
+# define DECLARE_MUTEX		ARCH_DECLARE_MUTEX
+#endif
+
+# define DECLARE_MUTEX_LOCKED	ARCH_DECLARE_MUTEX_LOCKED
+
+#if 0
+#ifdef CONFIG_GENERIC_MUTEXES
+# include <linux/mutex.h>
+#else
+
+#define DECLARE_MUTEX		ARCH_DECLARE_MUTEX
+#define DECLARE_MUTEX_LOCKED	ARCH_DECLARE_MUTEX_LOCKED
+
+static inline void sema_init(struct arch_semaphore *sem, int val)
+{
+	arch_sema_init(sem, val);
+}
+static inline void init_MUTEX(struct arch_semaphore *sem)
+{
+	arch_init_MUTEX(sem);
+}
+static inline void init_MUTEX_LOCKED(struct arch_semaphore *sem)
+{
+	arch_init_MUTEX_LOCKED(sem);
+}
+static inline void down(struct arch_semaphore *sem)
+{
+	arch_down(sem);
+}
+static inline int down_interruptible(struct arch_semaphore *sem)
+{
+	return arch_down_interruptible(sem);
+}
+static inline int down_trylock(struct arch_semaphore *sem)
+{
+	return arch_down_trylock(sem);
+}
+static inline void up(struct arch_semaphore *sem)
+{
+	arch_up(sem);
+}
+static inline int sem_is_locked(struct arch_semaphore *sem)
+{
+	return arch_sem_is_locked(sem);
+}
+static inline int sema_count(struct arch_semaphore *sem)
+{
+	return arch_sema_count(sem);
+}
+
+#endif /* CONFIG_GENERIC_MUTEXES */
+#endif
+
+#endif /* _LINUX_SEMAPHORE_H */
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -562,3 +562,76 @@ void fastcall __mutex_init(struct mutex 
 
 }
 EXPORT_SYMBOL_GPL(__mutex_init);
+
+/*
+ * Semaphore-compatible API wrappers:
+ */
+
+#ifdef CONFIG_DEBUG_MUTEXESS
+void fastcall
+__mutex_debug_sema_init(struct mutex_debug *lock, int val, char *name,
+			char *file, int line)
+{
+	__mutex_init(&lock->lock, name, file, line);
+
+	DEBUG_WARN_ON(val != 0 && val != 1);
+	if (!val)
+		__mutex_lock(&lock->lock __CALLER_IP__);
+}
+#else
+void fastcall __mutex_debug_sema_init(struct mutex_debug *lock, int val)
+{
+	__mutex_init(&lock->lock);
+
+	DEBUG_WARN_ON(val != 0 && val != 1);
+	if (!val)
+		__mutex_lock(&lock->lock __CALLER_IP__);
+}
+#endif
+
+EXPORT_SYMBOL(__mutex_debug_sema_init);
+
+void fastcall mutex_debug_down(struct mutex_debug *lock)
+{
+	DEBUG_WARN_ON(in_interrupt());
+	__mutex_lock(&lock->lock __CALLER_IP__);
+}
+EXPORT_SYMBOL(mutex_debug_down);
+
+int fastcall mutex_debug_down_interruptible(struct mutex_debug *lock)
+{
+	DEBUG_WARN_ON(in_interrupt());
+	return __mutex_lock_interruptible(&lock->lock, 0 __CALLER_IP__);
+}
+EXPORT_SYMBOL(mutex_debug_down_interruptible);
+
+/*
+ * try to down the mutex, 0 on success and 1 on failure. (inverted)
+ */
+int fastcall mutex_debug_down_trylock(struct mutex_debug *lock)
+{
+	DEBUG_WARN_ON(in_interrupt());
+	/*
+	 * Trylock semantics of semaphores are inverted that of spinlocks
+	 * and mutexes:
+	 */
+	if (__mutex_trylock(&lock->lock __CALLER_IP__))
+		return 0;
+	return 1;
+}
+EXPORT_SYMBOL(mutex_debug_down_trylock);
+
+void fastcall mutex_debug_up(struct mutex_debug *lock)
+{
+	DEBUG_WARN_ON(in_interrupt());
+	__mutex_unlock(&lock->lock __CALLER_IP__);
+}
+EXPORT_SYMBOL(mutex_debug_up);
+
+int fastcall mutex_debug_sem_is_locked(struct mutex_debug *lock)
+{
+	DEBUG_WARN_ON(in_interrupt());
+	return mutex_is_locked(&lock->lock);
+}
+EXPORT_SYMBOL(mutex_debug_sem_is_locked);
+
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -95,6 +95,34 @@ config DEBUG_PREEMPT
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+config GENERIC_MUTEXES
+	bool
+	depends on ARCH_SEMAPHORES
+	default y
+
+choice
+	prompt "Mutex Debugging Mode"
+	default DEBUG_NONE
+	depends on ARCH_SEMAPHORES
+
+config DEBUG_MUTEX_NONE
+	bool "Off"
+	help
+	  No runtime checking of semaphores. Fastest mode.
+
+config DEBUG_MUTEX_PARTIAL
+	bool "Partial"
+	help
+	  Check mutexes that have been marked as mutexes explicitly.
+
+config DEBUG_MUTEX_FULL
+	bool "Full"
+	help
+	  Check all mutexes and semaphores. (except the handful of
+	  semaphores that have been explicitly marked as non-debug)
+
+endchoice
+
 config DEBUG_MUTEXESS
         bool "Mutex debugging, deadlock detection"
         default y
Index: linux/lib/semaphore-sleepers.c
===================================================================
--- linux.orig/lib/semaphore-sleepers.c
+++ linux/lib/semaphore-sleepers.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <asm/semaphore.h>
 
 /*
@@ -49,12 +50,12 @@
  *    we cannot lose wakeup events.
  */
 
-fastcall void __up(struct semaphore *sem)
+fastcall void __up(struct arch_semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
 
-fastcall void __sched __down(struct semaphore * sem)
+fastcall void __sched __down(struct arch_semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -91,7 +92,7 @@ fastcall void __sched __down(struct sema
 	tsk->state = TASK_RUNNING;
 }
 
-fastcall int __sched __down_interruptible(struct semaphore * sem)
+fastcall int __sched __down_interruptible(struct arch_semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -154,7 +155,7 @@ fastcall int __sched __down_interruptibl
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-fastcall int __down_trylock(struct semaphore * sem)
+fastcall int __down_trylock(struct arch_semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;
@@ -175,3 +176,10 @@ fastcall int __down_trylock(struct semap
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
 	return 1;
 }
+
+int fastcall arch_sem_is_locked(struct arch_semaphore *sem)
+{
+	return (int) atomic_read(&sem->count) < 0;
+}
+
+EXPORT_SYMBOL(arch_sem_is_locked);
