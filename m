Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935436AbWLDKH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935436AbWLDKH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935457AbWLDKH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:07:28 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:30392 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S935416AbWLDKHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:07:23 -0500
Date: Mon, 4 Dec 2006 11:06:07 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch][rfc] rwsem: generic rwsem
Message-ID: <20061204100607.GA20529@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resending with correct ML addresses, sorry)

Hi,

This patch needs review and testing from the architecture guys, but
I would like to consider it because of the obvious maintenance benefits.

I know people will want to scream because it costs 3 more cycles on some
obscure architecture, but please try to stay in perspective. If it is
a real problem, we could look at extending the asm/mutex.h locking helpers
to make them usable for rwsem as well. It isn't a big deal.

Anyway, I hope this patch is a good starting point. Comments?

Thanks,
Nick

--
Move to an architecture independent rwsem implementation, using the
better of the two rwsem implementations (ie. the one which doesn't
take a spinlock to take an uncontested rwsem) as a basis. This gives
us a single rwsem design instead of two.

Use high level atomic primitives for the implementation, rather than
open coded assembly. This gives us a single implementation, rather
than a handful.

Use atomic_long_t rather than atomic_t for the count, which solves
the parallelism limitation for those architectures (actually found
to be a problem with ia64, powerpc and x86-64 may not be far behind).

Remove one level of indirection (kernel/rwsem.c -> lib/rwsem.c), and
give a bit of a cleanup (eg remove the fastcall junk) to make the
code a bit easier to read.

Out-of-line the fastpaths, to bring rw-semaphores into line with
mutexes and spinlocks WRT our icache vs function call policy.

Signed-off-by: Nick Piggin <npiggin@suse.de>

 include/asm-alpha/rwsem.h         |  259 -------------------------
 include/asm-i386/rwsem.h          |  296 -----------------------------
 include/asm-ia64/rwsem.h          |  178 -----------------
 include/asm-powerpc/rwsem.h       |  152 --------------
 include/asm-s390/rwsem.h          |  387 -------------------------------------- include/asm-sh/rwsem.h            |  159 ---------------
 include/asm-sparc64/rwsem-const.h |   12 -
 include/asm-sparc64/rwsem.h       |   66 ------
 include/asm-um/rwsem.h            |    6
 include/asm-xtensa/rwsem.h        |  164 ----------------
 lib/rwsem-spinlock.c              |  316 -------------------------------
 lib/rwsem.c                       |  257 -------------------------
 linux-2.6/arch/alpha/Kconfig      |    7
 linux-2.6/arch/arm/Kconfig        |    7
 linux-2.6/arch/arm26/Kconfig      |    7
 linux-2.6/arch/cris/Kconfig       |    7
 linux-2.6/arch/frv/Kconfig        |    7
 linux-2.6/arch/h8300/Kconfig      |    8
 linux-2.6/arch/i386/Kconfig.cpu   |   10
 linux-2.6/arch/ia64/Kconfig       |    4
 linux-2.6/arch/m32r/Kconfig       |    9
 linux-2.6/arch/m68k/Kconfig       |    7
 linux-2.6/arch/m68knommu/Kconfig  |    8
 linux-2.6/arch/mips/Kconfig       |   11 -
 linux-2.6/arch/parisc/Kconfig     |    6
 linux-2.6/arch/powerpc/Kconfig    |    7
 linux-2.6/arch/ppc/Kconfig        |    7
 linux-2.6/arch/s390/Kconfig       |    7
 linux-2.6/arch/sh/Kconfig         |    7
 linux-2.6/arch/sh64/Kconfig       |    7
 linux-2.6/arch/sparc/Kconfig      |    7
 linux-2.6/arch/sparc64/Kconfig    |    7
 linux-2.6/arch/um/Kconfig.x86_64  |    4
 linux-2.6/arch/v850/Kconfig       |    6
 linux-2.6/arch/x86_64/Kconfig     |    7
 linux-2.6/arch/xtensa/Kconfig     |    4
 linux-2.6/include/linux/rwsem.h   |   76 ++++++-
 linux-2.6/kernel/rwsem.c          |  292 +++++++++++++++++++++++++++-
 linux-2.6/lib/Makefile            |    2
 39 files changed, 351 insertions(+), 2439 deletions(-)

Index: linux-2.6/include/asm-powerpc/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,152 +0,0 @@
-#ifndef _ASM_POWERPC_RWSEM_H
-#define _ASM_POWERPC_RWSEM_H
-
-#ifdef __KERNEL__
-
-/*
- * include/asm-powerpc/rwsem.h: R/W semaphores for PPC using the stuff
- * in lib/rwsem.c.  Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
- */
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	/* XXX this should be able to be an atomic_t  -- paulus */
-	signed int		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_inc_return((atomic_t *)(&sem->count)) <= 0))
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	while ((tmp = sem->count) >= 0) {
-		if (tmp == cmpxchg(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
-				(atomic_t *)(&sem->count));
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_dec_return((atomic_t *)(&sem->count));
-	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
-			      (atomic_t *)(&sem->count)) < 0))
-		rwsem_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(-RWSEM_WAITING_BIAS, (atomic_t *)(&sem->count));
-	if (tmp < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_RWSEM_H */
Index: linux-2.6/include/linux/rwsem.h
===================================================================
--- linux-2.6.orig/include/linux/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/include/linux/rwsem.h	2006-12-04 20:48:17.000000000 +1100
@@ -1,9 +1,19 @@
-/* rwsem.h: R/W semaphores, public interface
+/*
+ * rwsem.h: R/W semaphores, public interface
  *
  * Written by David Howells (dhowells@redhat.com).
  * Derived from asm-i386/semaphore.h
+ *
+ * Also by:
+ * Paul Mackerras <paulus@samba.org>
+ * Nick Piggin <npiggin@suse.de>
+ *
+ * These semaphores are strictly FIFO - if anything is waiting, a process that
+ * wants a lock will go to the back of the queue. When the currently active
+ * lock is released, if there's a writer at the front of the queue, then that
+ * and only that will be woken up; if there's a bunch of consecutive readers at
+ * the front, then they'll all be woken up, but no other readers will be.
  */
-
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
@@ -16,14 +26,49 @@
 #include <asm/system.h>
 #include <asm/atomic.h>
 
-struct rw_semaphore;
+#define RWSEM_UNLOCKED_VALUE		0x00000000L
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	atomic_long_t		count;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+};
 
-#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
-#include <linux/rwsem-spinlock.h> /* use a generic implementation */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname) .dep_map = { .name = #lockname }
 #else
-#include <asm/rwsem.h> /* use an arch-specific implementation */
+# define __RWSEM_DEP_MAP_INIT(lockname)
 #endif
 
+
+#define __RWSEM_INITIALIZER(name) \
+{ ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE), SPIN_LOCK_UNLOCKED,	\
+	LIST_HEAD_INIT((name).wait_list),  __RWSEM_DEP_MAP_INIT(name) }
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
+			 struct lock_class_key *key);
+
+#define init_rwsem(sem)						\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	__init_rwsem((sem), #sem, &__key);			\
+} while (0)
+
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
+{
+	return (atomic_long_read(&sem->count) != 0);
+}
+
 /*
  * lock for reading
  */
Index: linux-2.6/lib/rwsem-spinlock.c
===================================================================
--- linux-2.6.orig/lib/rwsem-spinlock.c	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,316 +0,0 @@
-/* rwsem-spinlock.c: R/W semaphores: contention handling functions for
- * generic spinlock implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-#include <linux/rwsem.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-struct rwsem_waiter {
-	struct list_head list;
-	struct task_struct *task;
-	unsigned int flags;
-#define RWSEM_WAITING_FOR_READ	0x00000001
-#define RWSEM_WAITING_FOR_WRITE	0x00000002
-};
-
-/*
- * initialise the semaphore
- */
-void __init_rwsem(struct rw_semaphore *sem, const char *name,
-		  struct lock_class_key *key)
-{
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	/*
-	 * Make sure we are not reinitializing a held semaphore:
-	 */
-	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
-	lockdep_init_map(&sem->dep_map, name, key, 0);
-#endif
-	sem->activity = 0;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-/*
- * handle the lock release when processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active count' _reached_ zero
- *   - the 'waiting count' is non-zero
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having task zeroed
- * - writers are only woken if wakewrite is non-zero
- */
-static inline struct rw_semaphore *
-__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
-{
-	struct rwsem_waiter *waiter;
-	struct task_struct *tsk;
-	int woken;
-
-	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
-
-	if (!wakewrite) {
-		if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
-			goto out;
-		goto dont_wake_writers;
-	}
-
-	/* if we are allowed to wake writers try to grant a single write lock
-	 * if there's a writer at the front of the queue
-	 * - we leave the 'waiting count' incremented to signify potential
-	 *   contention
-	 */
-	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
-		sem->activity = -1;
-		list_del(&waiter->list);
-		tsk = waiter->task;
-		/* Don't touch waiter after ->task has been NULLed */
-		smp_mb();
-		waiter->task = NULL;
-		wake_up_process(tsk);
-		put_task_struct(tsk);
-		goto out;
-	}
-
-	/* grant an infinite number of read locks to the front of the queue */
- dont_wake_writers:
-	woken = 0;
-	while (waiter->flags & RWSEM_WAITING_FOR_READ) {
-		struct list_head *next = waiter->list.next;
-
-		list_del(&waiter->list);
-		tsk = waiter->task;
-		smp_mb();
-		waiter->task = NULL;
-		wake_up_process(tsk);
-		put_task_struct(tsk);
-		woken++;
-		if (list_empty(&sem->wait_list))
-			break;
-		waiter = list_entry(next, struct rwsem_waiter, list);
-	}
-
-	sem->activity += woken;
-
- out:
-	return sem;
-}
-
-/*
- * wake a single writer
- */
-static inline struct rw_semaphore *
-__rwsem_wake_one_writer(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-	struct task_struct *tsk;
-
-	sem->activity = -1;
-
-	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
-	list_del(&waiter->list);
-
-	tsk = waiter->task;
-	smp_mb();
-	waiter->task = NULL;
-	wake_up_process(tsk);
-	put_task_struct(tsk);
-	return sem;
-}
-
-/*
- * get a read lock on the semaphore
- */
-void fastcall __sched __down_read(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-	struct task_struct *tsk;
-
-	spin_lock_irq(&sem->wait_lock);
-
-	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity++;
-		spin_unlock_irq(&sem->wait_lock);
-		goto out;
-	}
-
-	tsk = current;
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-	get_task_struct(tsk);
-
-	list_add_tail(&waiter.list, &sem->wait_list);
-
-	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock_irq(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.task)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
- out:
-	;
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-int fastcall __down_read_trylock(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-	int ret = 0;
-
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity++;
-		ret = 1;
-	}
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return ret;
-}
-
-/*
- * get a write lock on the semaphore
- * - we increment the waiting count anyway to indicate an exclusive lock
- */
-void fastcall __sched __down_write_nested(struct rw_semaphore *sem, int subclass)
-{
-	struct rwsem_waiter waiter;
-	struct task_struct *tsk;
-
-	spin_lock_irq(&sem->wait_lock);
-
-	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity = -1;
-		spin_unlock_irq(&sem->wait_lock);
-		goto out;
-	}
-
-	tsk = current;
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-	get_task_struct(tsk);
-
-	list_add_tail(&waiter.list, &sem->wait_list);
-
-	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock_irq(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.task)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
- out:
-	;
-}
-
-void fastcall __sched __down_write(struct rw_semaphore *sem)
-{
-	__down_write_nested(sem, 0);
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-int fastcall __down_write_trylock(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity = -1;
-		ret = 1;
-	}
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return ret;
-}
-
-/*
- * release a read lock on the semaphore
- */
-void fastcall __up_read(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (--sem->activity == 0 && !list_empty(&sem->wait_list))
-		sem = __rwsem_wake_one_writer(sem);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-}
-
-/*
- * release a write lock on the semaphore
- */
-void fastcall __up_write(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	sem->activity = 0;
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 1);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-}
-
-/*
- * downgrade a write lock into a read lock
- * - just wake up any readers at the front of the queue
- */
-void fastcall __downgrade_write(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	sem->activity = 1;
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 0);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-}
-
-EXPORT_SYMBOL(__init_rwsem);
-EXPORT_SYMBOL(__down_read);
-EXPORT_SYMBOL(__down_read_trylock);
-EXPORT_SYMBOL(__down_write_nested);
-EXPORT_SYMBOL(__down_write);
-EXPORT_SYMBOL(__down_write_trylock);
-EXPORT_SYMBOL(__up_read);
-EXPORT_SYMBOL(__up_write);
-EXPORT_SYMBOL(__downgrade_write);
Index: linux-2.6/include/asm-alpha/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,259 +0,0 @@
-#ifndef _ALPHA_RWSEM_H
-#define _ALPHA_RWSEM_H
-
-/*
- * Written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
- * Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
- */
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/compiler.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	long			count;
-#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
-#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count += RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(oldcount < 0))
-		rwsem_down_read_failed(sem);
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	long old, new, res;
-
-	res = sem->count;
-	do {
-		new = res + RWSEM_ACTIVE_READ_BIAS;
-		if (new <= 0)
-			break;
-		old = res;
-		res = cmpxchg(&sem->count, old, new);
-	} while (res != old);
-	return res >= 0 ? 1 : 0;
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(oldcount))
-		rwsem_down_write_failed(sem);
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	long ret = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-			   RWSEM_ACTIVE_WRITE_BIAS);
-	if (ret == RWSEM_UNLOCKED_VALUE)
-		return 1;
-	return 0;
-}
-
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count -= RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(oldcount < 0))
-		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
-			rwsem_wake(sem);
-}
-
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	long count;
-#ifndef	CONFIG_SMP
-	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
-	count = sem->count;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	subq	%0,%3,%0\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(count))
-		if ((int)count == 0)
-			rwsem_wake(sem);
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count -= RWSEM_WAITING_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (-RWSEM_WAITING_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(oldcount < 0))
-		rwsem_downgrade_wake(sem);
-}
-
-static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
-{
-#ifndef	CONFIG_SMP
-	sem->count += val;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%2,%0\n"
-	"	stq_c	%0,%1\n"
-	"	beq	%0,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (temp), "=m" (sem->count)
-	:"Ir" (val), "m" (sem->count));
-#endif
-}
-
-static inline long rwsem_atomic_update(long val, struct rw_semaphore *sem)
-{
-#ifndef	CONFIG_SMP
-	sem->count += val;
-	return sem->count;
-#else
-	long ret, temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq 	%0,%3,%2\n"
-	"	addq	%0,%3,%0\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (val), "m" (sem->count));
-
-	return ret;
-#endif
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ALPHA_RWSEM_H */
Index: linux-2.6/include/asm-i386/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-i386/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,258 +0,0 @@
-/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for i486+
- *
- * Written by David Howells (dhowells@redhat.com).
- *
- * Derived from asm-i386/semaphore.h
- *
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
- * front, then they'll all be woken up, but no other readers will be.
- */
-
-#ifndef _I386_RWSEM_H
-#define _I386_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/lockdep.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
-extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct rw_semaphore *sem));
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-};
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEP_MAP_INIT(name) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
-			 struct lock_class_key *key);
-
-#define init_rwsem(sem)						\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	__init_rwsem((sem), #sem, &__key);			\
-} while (0)
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-		"  jns        1f\n"
-		"  call call_rwsem_down_read_failed\n"
-		"1:\n\t"
-		"# ending down_read\n\t"
-		: "+m" (sem->count)
-		: "a" (sem)
-		: "memory", "cc");
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	__s32 result, tmp;
-	__asm__ __volatile__(
-		"# beginning __down_read_trylock\n\t"
-		"  movl      %0,%1\n\t"
-		"1:\n\t"
-		"  movl	     %1,%2\n\t"
-		"  addl      %3,%2\n\t"
-		"  jle	     2f\n\t"
-LOCK_PREFIX	"  cmpxchgl  %2,%0\n\t"
-		"  jnz	     1b\n\t"
-		"2:\n\t"
-		"# ending __down_read_trylock\n\t"
-		: "+m" (sem->count), "=&a" (result), "=&r" (tmp)
-		: "i" (RWSEM_ACTIVE_READ_BIAS)
-		: "memory", "cc");
-	return result>=0 ? 1 : 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write_nested(struct rw_semaphore *sem, int subclass)
-{
-	int tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	__asm__ __volatile__(
-		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
-		"  testl     %%edx,%%edx\n\t" /* was the count 0 before? */
-		"  jz        1f\n"
-		"  call call_rwsem_down_write_failed\n"
-		"1:\n"
-		"# ending down_write"
-		: "+m" (sem->count), "=d" (tmp)
-		: "a" (sem), "1" (tmp)
-		: "memory", "cc");
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	__down_write_nested(sem, 0);
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	signed long ret = cmpxchg(&sem->count,
-				  RWSEM_UNLOCKED_VALUE, 
-				  RWSEM_ACTIVE_WRITE_BIAS);
-	if (ret == RWSEM_UNLOCKED_VALUE)
-		return 1;
-	return 0;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
-	__asm__ __volatile__(
-		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
-		"  jns        1f\n\t"
-		"  call call_rwsem_wake\n"
-		"1:\n"
-		"# ending __up_read\n"
-		: "+m" (sem->count), "=d" (tmp)
-		: "a" (sem), "1" (tmp)
-		: "memory", "cc");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __up_write\n\t"
-		"  movl      %2,%%edx\n\t"
-LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
-		"  jz       1f\n"
-		"  call call_rwsem_wake\n"
-		"1:\n\t"
-		"# ending __up_write\n"
-		: "+m" (sem->count)
-		: "a" (sem), "i" (-RWSEM_ACTIVE_WRITE_BIAS)
-		: "memory", "cc", "edx");
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __downgrade_write\n\t"
-LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* transitions 0xZZZZ0001 -> 0xYYYY0001 */
-		"  jns       1f\n\t"
-		"  call call_rwsem_downgrade_wake\n"
-		"1:\n\t"
-		"# ending __downgrade_write\n"
-		: "+m" (sem->count)
-		: "a" (sem), "i" (-RWSEM_WAITING_BIAS)
-		: "memory", "cc");
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-LOCK_PREFIX	"addl %1,%0"
-		: "+m" (sem->count)
-		: "ir" (delta));
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-	__asm__ __volatile__(
-LOCK_PREFIX	"xadd %0,%1"
-		: "+r" (tmp), "+m" (sem->count)
-		: : "memory");
-
-	return tmp+delta;
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _I386_RWSEM_H */
Index: linux-2.6/include/asm-ia64/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,178 +0,0 @@
-/*
- * asm-ia64/rwsem.h: R/W semaphores for ia64
- *
- * Copyright (C) 2003 Ken Chen <kenneth.w.chen@intel.com>
- * Copyright (C) 2003 Asit Mallick <asit.k.mallick@intel.com>
- * Copyright (C) 2005 Christoph Lameter <clameter@sgi.com>
- *
- * Based on asm-i386/rwsem.h and other architecture implementation.
- *
- * The MSW of the count is the negated number of active writers and
- * waiting lockers, and the LSW is the total number of active locks.
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffffffff00000001 for
- * the case of an uncontended lock. Readers increment by 1 and see a positive
- * value when uncontended, negative if there are writers (and maybe) readers
- * waiting (in which case it goes to sleep).
- */
-
-#ifndef _ASM_IA64_RWSEM_H
-#define _ASM_IA64_RWSEM_H
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-#include <asm/intrinsics.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define RWSEM_UNLOCKED_VALUE		__IA64_UL_CONST(0x0000000000000000)
-#define RWSEM_ACTIVE_BIAS		__IA64_UL_CONST(0x0000000000000001)
-#define RWSEM_ACTIVE_MASK		__IA64_UL_CONST(0x00000000ffffffff)
-#define RWSEM_WAITING_BIAS		-__IA64_UL_CONST(0x0000000100000000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-static inline void
-init_rwsem (struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-/*
- * lock for reading
- */
-static inline void
-__down_read (struct rw_semaphore *sem)
-{
-	long result = ia64_fetchadd8_acq((unsigned long *)&sem->count, 1);
-
-	if (result < 0)
-		rwsem_down_read_failed(sem);
-}
-
-/*
- * lock for writing
- */
-static inline void
-__down_write (struct rw_semaphore *sem)
-{
-	long old, new;
-
-	do {
-		old = sem->count;
-		new = old + RWSEM_ACTIVE_WRITE_BIAS;
-	} while (cmpxchg_acq(&sem->count, old, new) != old);
-
-	if (old != 0)
-		rwsem_down_write_failed(sem);
-}
-
-/*
- * unlock after reading
- */
-static inline void
-__up_read (struct rw_semaphore *sem)
-{
-	long result = ia64_fetchadd8_rel((unsigned long *)&sem->count, -1);
-
-	if (result < 0 && (--result & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void
-__up_write (struct rw_semaphore *sem)
-{
-	long old, new;
-
-	do {
-		old = sem->count;
-		new = old - RWSEM_ACTIVE_WRITE_BIAS;
-	} while (cmpxchg_rel(&sem->count, old, new) != old);
-
-	if (new < 0 && (new & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline int
-__down_read_trylock (struct rw_semaphore *sem)
-{
-	long tmp;
-	while ((tmp = sem->count) >= 0) {
-		if (tmp == cmpxchg_acq(&sem->count, tmp, tmp+1)) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline int
-__down_write_trylock (struct rw_semaphore *sem)
-{
-	long tmp = cmpxchg_acq(&sem->count, RWSEM_UNLOCKED_VALUE,
-			      RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void
-__downgrade_write (struct rw_semaphore *sem)
-{
-	long old, new;
-
-	do {
-		old = sem->count;
-		new = old - RWSEM_WAITING_BIAS;
-	} while (cmpxchg_rel(&sem->count, old, new) != old);
-
-	if (old < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * Implement atomic add functionality.  These used to be "inline" functions, but GCC v3.1
- * doesn't quite optimize this stuff right and ends up with bad calls to fetchandadd.
- */
-#define rwsem_atomic_add(delta, sem)	atomic64_add(delta, (atomic64_t *)(&(sem)->count))
-#define rwsem_atomic_update(delta, sem)	atomic64_add_return(delta, (atomic64_t *)(&(sem)->count))
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif /* _ASM_IA64_RWSEM_H */
Index: linux-2.6/include/asm-s390/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-s390/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,387 +0,0 @@
-#ifndef _S390_RWSEM_H
-#define _S390_RWSEM_H
-
-/*
- *  include/asm-s390/rwsem.h
- *
- *  S390 version
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- *  Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
- */
-
-/*
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
- * front, then they'll all be woken up, but no other readers will be.
- */
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_write(struct rw_semaphore *);
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
-#ifndef __s390x__
-#define RWSEM_UNLOCKED_VALUE	0x00000000
-#define RWSEM_ACTIVE_BIAS	0x00000001
-#define RWSEM_ACTIVE_MASK	0x0000ffff
-#define RWSEM_WAITING_BIAS	(-0x00010000)
-#else /* __s390x__ */
-#define RWSEM_UNLOCKED_VALUE	0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS	0x0000000000000001L
-#define RWSEM_ACTIVE_MASK	0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS	(-0x0000000100000000L)
-#endif /* __s390x__ */
-#define RWSEM_ACTIVE_READ_BIAS	RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS	(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-/*
- * initialisation
- */
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-  __RWSEM_DEP_MAP_INIT(name) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
-			 struct lock_class_key *key);
-
-#define init_rwsem(sem)				\
-do {						\
-	static struct lock_class_key __key;	\
-						\
-	__init_rwsem((sem), #sem, &__key);	\
-} while (0)
-
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	signed long old, new;
-
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	ahi	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	aghi	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "i" (RWSEM_ACTIVE_READ_BIAS) : "cc", "memory");
-	if (old < 0)
-		rwsem_down_read_failed(sem);
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	signed long old, new;
-
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	ltr	%1,%0\n"
-		"	jm	1f\n"
-		"	ahi	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b\n"
-		"1:"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	ltgr	%1,%0\n"
-		"	jm	1f\n"
-		"	aghi	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b\n"
-		"1:"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "i" (RWSEM_ACTIVE_READ_BIAS) : "cc", "memory");
-	return old >= 0 ? 1 : 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write_nested(struct rw_semaphore *sem, int subclass)
-{
-	signed long old, new, tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	a	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	ag	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "m" (tmp)
-		: "cc", "memory");
-	if (old != 0)
-		rwsem_down_write_failed(sem);
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	__down_write_nested(sem, 0);
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	signed long old;
-
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%2)\n"
-		"0:	ltr	%0,%0\n"
-		"	jnz	1f\n"
-		"	cs	%0,%4,0(%2)\n"
-		"	jl	0b\n"
-#else /* __s390x__ */
-		"	lg	%0,0(%2)\n"
-		"0:	ltgr	%0,%0\n"
-		"	jnz	1f\n"
-		"	csg	%0,%4,0(%2)\n"
-		"	jl	0b\n"
-#endif /* __s390x__ */
-		"1:"
-		: "=&d" (old), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "d" (RWSEM_ACTIVE_WRITE_BIAS) : "cc", "memory");
-	return (old == RWSEM_UNLOCKED_VALUE) ? 1 : 0;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	signed long old, new;
-
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	ahi	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	aghi	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "i" (-RWSEM_ACTIVE_READ_BIAS)
-		: "cc", "memory");
-	if (new < 0)
-		if ((new & RWSEM_ACTIVE_MASK) == 0)
-			rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	signed long old, new, tmp;
-
-	tmp = -RWSEM_ACTIVE_WRITE_BIAS;
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	a	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	ag	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "m" (tmp)
-		: "cc", "memory");
-	if (new < 0)
-		if ((new & RWSEM_ACTIVE_MASK) == 0)
-			rwsem_wake(sem);
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	signed long old, new, tmp;
-
-	tmp = -RWSEM_WAITING_BIAS;
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	a	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	ag	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "m" (tmp)
-		: "cc", "memory");
-	if (new > 1)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(long delta, struct rw_semaphore *sem)
-{
-	signed long old, new;
-
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	ar	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	agr	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "d" (delta)
-		: "cc", "memory");
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline long rwsem_atomic_update(long delta, struct rw_semaphore *sem)
-{
-	signed long old, new;
-
-	asm volatile(
-#ifndef __s390x__
-		"	l	%0,0(%3)\n"
-		"0:	lr	%1,%0\n"
-		"	ar	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
-		"	jl	0b"
-#else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
-		"0:	lgr	%1,%0\n"
-		"	agr	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
-		"	jl	0b"
-#endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "d" (delta)
-		: "cc", "memory");
-	return new;
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _S390_RWSEM_H */
Index: linux-2.6/include/asm-sh/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-sh/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,159 +0,0 @@
-/*
- * include/asm-ppc/rwsem.h: R/W semaphores for SH using the stuff
- * in lib/rwsem.c.
- */
-
-#ifndef _ASM_SH_RWSEM_H
-#define _ASM_SH_RWSEM_H
-
-#ifdef __KERNEL__
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (atomic_inc_return((atomic_t *)(&sem->count)) > 0)
-		smp_wmb();
-	else
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	while ((tmp = sem->count) >= 0) {
-		if (tmp == cmpxchg(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
-			smp_wmb();
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
-				(atomic_t *)(&sem->count));
-	if (tmp == RWSEM_ACTIVE_WRITE_BIAS)
-		smp_wmb();
-	else
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
-	smp_wmb();
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_dec_return((atomic_t *)(&sem->count));
-	if (tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	smp_wmb();
-	if (atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
-			      (atomic_t *)(&sem->count)) < 0)
-		rwsem_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_add_return(-RWSEM_WAITING_BIAS, (atomic_t *)(&sem->count));
-	if (tmp < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	smp_mb();
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_SH_RWSEM_H */
Index: linux-2.6/include/asm-sparc64/rwsem-const.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/rwsem-const.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,12 +0,0 @@
-/* rwsem-const.h: RW semaphore counter constants.  */
-#ifndef _SPARC64_RWSEM_CONST_H
-#define _SPARC64_RWSEM_CONST_H
-
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		0xffff0000
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-#endif /* _SPARC64_RWSEM_CONST_H */
Index: linux-2.6/include/asm-sparc64/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,66 +0,0 @@
-/* $Id: rwsem.h,v 1.5 2001/11/18 00:12:56 davem Exp $
- * rwsem.h: R/W semaphores implemented using CAS
- *
- * Written by David S. Miller (davem@redhat.com), 2001.
- * Derived from asm-i386/rwsem.h
- */
-#ifndef _SPARC64_RWSEM_H
-#define _SPARC64_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/rwsem-const.h>
-
-struct rwsem_waiter;
-
-struct rw_semaphore {
-	signed int count;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static __inline__ void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-extern void __down_read(struct rw_semaphore *sem);
-extern int __down_read_trylock(struct rw_semaphore *sem);
-extern void __down_write(struct rw_semaphore *sem);
-extern int __down_write_trylock(struct rw_semaphore *sem);
-extern void __up_read(struct rw_semaphore *sem);
-extern void __up_write(struct rw_semaphore *sem);
-extern void __downgrade_write(struct rw_semaphore *sem);
-
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* _SPARC64_RWSEM_H */
Index: linux-2.6/include/asm-um/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-um/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,6 +0,0 @@
-#ifndef __UM_RWSEM_H__
-#define __UM_RWSEM_H__
-
-#include "asm/arch/rwsem.h"
-
-#endif
Index: linux-2.6/include/asm-xtensa/rwsem.h
===================================================================
--- linux-2.6.orig/include/asm-xtensa/rwsem.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,164 +0,0 @@
-/*
- * include/asm-xtensa/rwsem.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Largely copied from include/asm-ppc/rwsem.h
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_RWSEM_H
-#define _XTENSA_RWSEM_H
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (atomic_add_return(1,(atomic_t *)(&sem->count)) > 0)
-		smp_wmb();
-	else
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	while ((tmp = sem->count) >= 0) {
-		if (tmp == cmpxchg(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
-			smp_wmb();
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
-				(atomic_t *)(&sem->count));
-	if (tmp == RWSEM_ACTIVE_WRITE_BIAS)
-		smp_wmb();
-	else
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
-	smp_wmb();
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_sub_return(1,(atomic_t *)(&sem->count));
-	if (tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	smp_wmb();
-	if (atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
-			      (atomic_t *)(&sem->count)) < 0)
-		rwsem_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_add_return(-RWSEM_WAITING_BIAS, (atomic_t *)(&sem->count));
-	if (tmp < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	smp_mb();
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->count != 0);
-}
-
-#endif	/* _XTENSA_RWSEM_H */
Index: linux-2.6/kernel/rwsem.c
===================================================================
--- linux-2.6.orig/kernel/rwsem.c	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/kernel/rwsem.c	2006-12-04 20:48:17.000000000 +1100
@@ -13,6 +13,276 @@
 #include <asm/atomic.h>
 
 /*
+ * The MSW of the count is the negated number of active writers and waiting
+ * lockers, and the LSW is the total number of active locks
+ *
+ * The lock count is initialized to 0 (no active and no waiting lockers).
+ *
+ * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
+ * uncontended lock. This can be determined because atomic_add_return returns
+ * the old value.  Readers increment by 1 and see a positive value when
+ * uncontended, negative if there are writers (and maybe) readers waiting (in
+ * which case it goes to sleep).
+ *
+ * On 32-bit architectures, the value of WAITING_BIAS supports up to 32766
+ * waiting processes. The value of ACTIVE_BIAS supports up to 65535 active
+ * processes. On 64-bit, these are much larger.
+ */
+#define RWSEM_ACTIVE_BIAS		0x00000001L
+#if BITS_PER_LONG == 32
+#define RWSEM_ACTIVE_MASK		0x0000ffffL
+#define RWSEM_WAITING_BIAS		0xffff0000L
+#elif BITS_PER_LONG == 64
+#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
+#define RWSEM_WAITING_BIAS		0xffffffff00000000L
+#endif
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+
+/*
+ * Initialize an rwsem:
+ */
+void __init_rwsem(struct rw_semaphore *sem, const char *name,
+		  struct lock_class_key *key)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held semaphore:
+	 */
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
+	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
+	spin_lock_init(&sem->wait_lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+}
+
+EXPORT_SYMBOL(__init_rwsem);
+
+struct rwsem_waiter {
+	struct list_head list;
+	struct task_struct *task;
+	unsigned int flags;
+#define RWSEM_WAITING_FOR_READ	0x00000001
+#define RWSEM_WAITING_FOR_WRITE	0x00000002
+};
+
+/*
+ * handle the lock release when processes blocked on it that can now run
+ * - if we come here from up_xxxx(), then:
+ *   - the 'active part' of count (&0x0000ffff) reached 0 (but may have changed)
+ *   - the 'waiting part' of count (&0xffff0000) is -ve (and will still be so)
+ *   - there must be someone on the queue
+ * - the spinlock must be held by the caller
+ * - woken process blocks are discarded from the list after having task zeroed
+ * - writers are only woken if downgrading is false
+ */
+static struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem,
+							int downgrading)
+{
+	struct rwsem_waiter *waiter;
+	struct task_struct *tsk;
+	struct list_head *next;
+	long oldcount, woken, loop;
+
+	if (downgrading)
+		goto dont_wake_writers;
+
+	/* if we came through an up_xxxx() call, we only only wake someone up
+	 * if we can transition the active part of the count from 0 -> 1
+	 */
+ try_again:
+	oldcount = atomic_long_add_return(RWSEM_ACTIVE_BIAS, &sem->count)
+						- RWSEM_ACTIVE_BIAS;
+	if (oldcount & RWSEM_ACTIVE_MASK)
+		goto undo;
+
+	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
+
+	/* try to grant a single write lock if there's a writer at the front
+	 * of the queue - note we leave the 'active part' of the count
+	 * incremented by 1 and the waiting part incremented by 0x00010000
+	 */
+	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
+		goto readers_only;
+
+	/* We must be careful not to touch 'waiter' after we set ->task = NULL.
+	 * It is an allocated on the waiter's stack and may become invalid at
+	 * any time after that point (due to a wakeup from another source).
+	 */
+	list_del(&waiter->list);
+	tsk = waiter->task;
+	smp_mb();
+	waiter->task = NULL;
+	wake_up_process(tsk);
+	put_task_struct(tsk);
+	goto out;
+
+	/* don't want to wake any writers */
+ dont_wake_writers:
+	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
+	if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
+		goto out;
+
+	/* grant an infinite number of read locks to the readers at the front
+	 * of the queue
+	 * - note we increment the 'active part' of the count by the number of
+	 *   readers before waking any processes up
+	 */
+ readers_only:
+	woken = 0;
+	do {
+		woken++;
+
+		if (waiter->list.next == &sem->wait_list)
+			break;
+
+		waiter = list_entry(waiter->list.next,
+					struct rwsem_waiter, list);
+
+	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
+
+	loop = woken;
+	woken *= RWSEM_ACTIVE_BIAS - RWSEM_WAITING_BIAS;
+	if (!downgrading)
+		/* we'd already done one increment earlier */
+		woken -= RWSEM_ACTIVE_BIAS;
+
+	atomic_long_add(woken, &sem->count);
+
+	next = sem->wait_list.next;
+	for (; loop > 0; loop--) {
+		waiter = list_entry(next, struct rwsem_waiter, list);
+		next = waiter->list.next;
+		tsk = waiter->task;
+		smp_mb();
+		waiter->task = NULL;
+		wake_up_process(tsk);
+		put_task_struct(tsk);
+	}
+
+	sem->wait_list.next = next;
+	next->prev = &sem->wait_list;
+
+ out:
+	return sem;
+
+	/* undo the change to count, but check for a transition 1->0 */
+ undo:
+	if (atomic_long_add_return(-RWSEM_ACTIVE_BIAS, &sem->count) != 0)
+		goto out;
+	goto try_again;
+}
+
+/*
+ * wait for a lock to be granted
+ */
+static struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
+			struct rwsem_waiter *waiter, signed long adjustment)
+{
+	struct task_struct *tsk = current;
+	long count;
+
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+
+	/* set up my own style of waitqueue */
+	spin_lock_irq(&sem->wait_lock);
+	waiter->task = tsk;
+	get_task_struct(tsk);
+
+	list_add_tail(&waiter->list, &sem->wait_list);
+
+	/* we're now waiting on the lock, but no longer actively read-locking */
+	count = atomic_long_add_return(adjustment, &sem->count);
+
+	/* if there are no active locks, wake the front queued process(es) up */
+	if (!(count & RWSEM_ACTIVE_MASK))
+		sem = __rwsem_do_wake(sem, 0);
+
+	spin_unlock_irq(&sem->wait_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter->task)
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+
+	return sem;
+}
+
+/*
+ * wait for the read lock to be granted
+ */
+static struct rw_semaphore __sched *rwsem_down_read_failed(
+					struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+
+	waiter.flags = RWSEM_WAITING_FOR_READ;
+	rwsem_down_failed_common(sem, &waiter,
+				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);
+	return sem;
+}
+
+/*
+ * wait for the write lock to be granted
+ */
+static struct rw_semaphore __sched *rwsem_down_write_failed(
+					struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+
+	waiter.flags = RWSEM_WAITING_FOR_WRITE;
+	rwsem_down_failed_common(sem, &waiter, -RWSEM_ACTIVE_BIAS);
+
+	return sem;
+}
+
+/*
+ * handle waking up a waiter on the semaphore
+ * - up_read/up_write has decremented the active part of count if we come here
+ */
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sem->wait_lock, flags);
+
+	/* do nothing if list empty */
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem, 0);
+
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+
+	return sem;
+}
+
+/*
+ * downgrade a write lock into a read lock
+ * - caller incremented waiting part of count and discovered it still negative
+ * - just wake up any readers at the front of the queue
+ */
+static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sem->wait_lock, flags);
+
+	/* do nothing if list empty */
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem, 1);
+
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+
+	return sem;
+}
+
+
+/*
  * lock for reading
  */
 void down_read(struct rw_semaphore *sem)
@@ -20,7 +290,8 @@ void down_read(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
-	__down_read(sem);
+	if (unlikely(atomic_long_inc_return(&sem->count) <= 0))
+		rwsem_down_read_failed(sem);
 }
 
 EXPORT_SYMBOL(down_read);
@@ -30,11 +301,16 @@ EXPORT_SYMBOL(down_read);
  */
 int down_read_trylock(struct rw_semaphore *sem)
 {
-	int ret = __down_read_trylock(sem);
+	long tmp;
 
-	if (ret == 1)
-		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
-	return ret;
+	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
+		if (tmp == atomic_long_cmpxchg(&sem->count, tmp,
+				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
+			rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
+			return 1;
+		}
+	}
+	return 0;
 }
 
 EXPORT_SYMBOL(down_read_trylock);
@@ -44,10 +320,14 @@ EXPORT_SYMBOL(down_read_trylock);
  */
 void down_write(struct rw_semaphore *sem)
 {
+	long tmp;
+
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
-	__down_write(sem);
+	tmp = atomic_long_add_return(RWSEM_ACTIVE_WRITE_BIAS, &sem->count);
+	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+		rwsem_down_write_failed(sem);
 }
 
 EXPORT_SYMBOL(down_write);
@@ -57,11 +337,15 @@ EXPORT_SYMBOL(down_write);
  */
 int down_write_trylock(struct rw_semaphore *sem)
 {
-	int ret = __down_write_trylock(sem);
+	long tmp;
 
-	if (ret == 1)
+	tmp = atomic_long_cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
+		      RWSEM_ACTIVE_WRITE_BIAS);
+	if (tmp == RWSEM_UNLOCKED_VALUE) {
 		rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
-	return ret;
+		return 1;
+	}
+	return 0;
 }
 
 EXPORT_SYMBOL(down_write_trylock);
@@ -71,9 +355,13 @@ EXPORT_SYMBOL(down_write_trylock);
  */
 void up_read(struct rw_semaphore *sem)
 {
+	long tmp;
+
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 
-	__up_read(sem);
+	tmp = atomic_long_dec_return(&sem->count);
+	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
+		rwsem_wake(sem);
 }
 
 EXPORT_SYMBOL(up_read);
@@ -85,7 +373,9 @@ void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 
-	__up_write(sem);
+	if (unlikely(atomic_long_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
+			      &sem->count) < 0))
+		rwsem_wake(sem);
 }
 
 EXPORT_SYMBOL(up_write);
@@ -95,11 +385,16 @@ EXPORT_SYMBOL(up_write);
  */
 void downgrade_write(struct rw_semaphore *sem)
 {
+	long tmp;
+
 	/*
 	 * lockdep: a downgraded write will live on as a write
 	 * dependency.
 	 */
-	__downgrade_write(sem);
+
+	tmp = atomic_long_add_return(-RWSEM_WAITING_BIAS, &sem->count);
+	if (tmp < 0)
+		rwsem_downgrade_wake(sem);
 }
 
 EXPORT_SYMBOL(downgrade_write);
Index: linux-2.6/lib/rwsem.c
===================================================================
--- linux-2.6.orig/lib/rwsem.c	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,257 +0,0 @@
-/* rwsem.c: R/W semaphores: contention handling functions
- *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from arch/i386/kernel/semaphore.c
- */
-#include <linux/rwsem.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/module.h>
-
-/*
- * Initialize an rwsem:
- */
-void __init_rwsem(struct rw_semaphore *sem, const char *name,
-		  struct lock_class_key *key)
-{
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	/*
-	 * Make sure we are not reinitializing a held semaphore:
-	 */
-	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
-	lockdep_init_map(&sem->dep_map, name, key, 0);
-#endif
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-EXPORT_SYMBOL(__init_rwsem);
-
-struct rwsem_waiter {
-	struct list_head list;
-	struct task_struct *task;
-	unsigned int flags;
-#define RWSEM_WAITING_FOR_READ	0x00000001
-#define RWSEM_WAITING_FOR_WRITE	0x00000002
-};
-
-/*
- * handle the lock release when processes blocked on it that can now run
- * - if we come here from up_xxxx(), then:
- *   - the 'active part' of count (&0x0000ffff) reached 0 (but may have changed)
- *   - the 'waiting part' of count (&0xffff0000) is -ve (and will still be so)
- *   - there must be someone on the queue
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having task zeroed
- * - writers are only woken if downgrading is false
- */
-static inline struct rw_semaphore *
-__rwsem_do_wake(struct rw_semaphore *sem, int downgrading)
-{
-	struct rwsem_waiter *waiter;
-	struct task_struct *tsk;
-	struct list_head *next;
-	signed long oldcount, woken, loop;
-
-	if (downgrading)
-		goto dont_wake_writers;
-
-	/* if we came through an up_xxxx() call, we only only wake someone up
-	 * if we can transition the active part of the count from 0 -> 1
-	 */
- try_again:
-	oldcount = rwsem_atomic_update(RWSEM_ACTIVE_BIAS, sem)
-						- RWSEM_ACTIVE_BIAS;
-	if (oldcount & RWSEM_ACTIVE_MASK)
-		goto undo;
-
-	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
-
-	/* try to grant a single write lock if there's a writer at the front
-	 * of the queue - note we leave the 'active part' of the count
-	 * incremented by 1 and the waiting part incremented by 0x00010000
-	 */
-	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
-		goto readers_only;
-
-	/* We must be careful not to touch 'waiter' after we set ->task = NULL.
-	 * It is an allocated on the waiter's stack and may become invalid at
-	 * any time after that point (due to a wakeup from another source).
-	 */
-	list_del(&waiter->list);
-	tsk = waiter->task;
-	smp_mb();
-	waiter->task = NULL;
-	wake_up_process(tsk);
-	put_task_struct(tsk);
-	goto out;
-
-	/* don't want to wake any writers */
- dont_wake_writers:
-	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
-	if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
-		goto out;
-
-	/* grant an infinite number of read locks to the readers at the front
-	 * of the queue
-	 * - note we increment the 'active part' of the count by the number of
-	 *   readers before waking any processes up
-	 */
- readers_only:
-	woken = 0;
-	do {
-		woken++;
-
-		if (waiter->list.next == &sem->wait_list)
-			break;
-
-		waiter = list_entry(waiter->list.next,
-					struct rwsem_waiter, list);
-
-	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
-
-	loop = woken;
-	woken *= RWSEM_ACTIVE_BIAS - RWSEM_WAITING_BIAS;
-	if (!downgrading)
-		/* we'd already done one increment earlier */
-		woken -= RWSEM_ACTIVE_BIAS;
-
-	rwsem_atomic_add(woken, sem);
-
-	next = sem->wait_list.next;
-	for (; loop > 0; loop--) {
-		waiter = list_entry(next, struct rwsem_waiter, list);
-		next = waiter->list.next;
-		tsk = waiter->task;
-		smp_mb();
-		waiter->task = NULL;
-		wake_up_process(tsk);
-		put_task_struct(tsk);
-	}
-
-	sem->wait_list.next = next;
-	next->prev = &sem->wait_list;
-
- out:
-	return sem;
-
-	/* undo the change to count, but check for a transition 1->0 */
- undo:
-	if (rwsem_atomic_update(-RWSEM_ACTIVE_BIAS, sem) != 0)
-		goto out;
-	goto try_again;
-}
-
-/*
- * wait for a lock to be granted
- */
-static struct rw_semaphore *
-rwsem_down_failed_common(struct rw_semaphore *sem,
-			struct rwsem_waiter *waiter, signed long adjustment)
-{
-	struct task_struct *tsk = current;
-	signed long count;
-
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	spin_lock_irq(&sem->wait_lock);
-	waiter->task = tsk;
-	get_task_struct(tsk);
-
-	list_add_tail(&waiter->list, &sem->wait_list);
-
-	/* we're now waiting on the lock, but no longer actively read-locking */
-	count = rwsem_atomic_update(adjustment, sem);
-
-	/* if there are no active locks, wake the front queued process(es) up */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		sem = __rwsem_do_wake(sem, 0);
-
-	spin_unlock_irq(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter->task)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-/*
- * wait for the read lock to be granted
- */
-struct rw_semaphore fastcall __sched *
-rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-	rwsem_down_failed_common(sem, &waiter,
-				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);
-	return sem;
-}
-
-/*
- * wait for the write lock to be granted
- */
-struct rw_semaphore fastcall __sched *
-rwsem_down_write_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-	rwsem_down_failed_common(sem, &waiter, -RWSEM_ACTIVE_BIAS);
-
-	return sem;
-}
-
-/*
- * handle waking up a waiter on the semaphore
- * - up_read/up_write has decremented the active part of count if we come here
- */
-struct rw_semaphore fastcall *rwsem_wake(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	/* do nothing if list empty */
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 0);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return sem;
-}
-
-/*
- * downgrade a write lock into a read lock
- * - caller incremented waiting part of count and discovered it still negative
- * - just wake up any readers at the front of the queue
- */
-struct rw_semaphore fastcall *rwsem_downgrade_wake(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait_lock, flags);
-
-	/* do nothing if list empty */
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 1);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return sem;
-}
-
-EXPORT_SYMBOL(rwsem_down_read_failed);
-EXPORT_SYMBOL(rwsem_down_write_failed);
-EXPORT_SYMBOL(rwsem_wake);
-EXPORT_SYMBOL(rwsem_downgrade_wake);
Index: linux-2.6/arch/alpha/Kconfig
===================================================================
--- linux-2.6.orig/arch/alpha/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/alpha/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -18,13 +18,6 @@ config MMU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/arm/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -67,13 +67,6 @@ config GENERIC_IRQ_PROBE
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/arm26/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm26/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/arm26/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -34,13 +34,6 @@ config FORCE_MAX_ZONEORDER
         int
         default 9
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/cris/Kconfig
===================================================================
--- linux-2.6.orig/arch/cris/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/cris/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -9,13 +9,6 @@ config MMU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/frv/Kconfig
===================================================================
--- linux-2.6.orig/arch/frv/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/frv/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -6,13 +6,6 @@ config FRV
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/h8300/Kconfig
===================================================================
--- linux-2.6.orig/arch/h8300/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/h8300/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -21,14 +21,6 @@ config FPU
 	bool
 	default n
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default n
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/ia64/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -30,10 +30,6 @@ config SWIOTLB
        bool
        default y
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/m32r/Kconfig
===================================================================
--- linux-2.6.orig/arch/m32r/Kconfig	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/arch/m32r/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -205,15 +205,6 @@ config IRAM_SIZE
 # Define implied options from the CPU selection here
 #
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	depends on M32R
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default n
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/m68k/Kconfig
===================================================================
--- linux-2.6.orig/arch/m68k/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/m68k/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -10,13 +10,6 @@ config MMU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/m68knommu/Kconfig
===================================================================
--- linux-2.6.orig/arch/m68knommu/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/m68knommu/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -17,14 +17,6 @@ config FPU
 	bool
 	default n
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default n
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/mips/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -782,13 +782,6 @@ source "arch/mips/cobalt/Kconfig"
 
 endmenu
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
@@ -1786,10 +1779,6 @@ config MIPS_INSANE_LARGE
 
 endmenu
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
Index: linux-2.6/arch/parisc/Kconfig
===================================================================
--- linux-2.6.orig/arch/parisc/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/parisc/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -19,12 +19,6 @@ config MMU
 config STACK_GROWSUP
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/powerpc/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -34,13 +34,6 @@ config IRQ_PER_CPU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/ppc/Kconfig
===================================================================
--- linux-2.6.orig/arch/ppc/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/ppc/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -12,13 +12,6 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/s390/Kconfig
===================================================================
--- linux-2.6.orig/arch/s390/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/s390/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -15,13 +15,6 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/sh/Kconfig
===================================================================
--- linux-2.6.orig/arch/sh/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/sh/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -15,13 +15,6 @@ config SUPERH
 	  gaming console.  The SuperH port has a home page at
 	  <http://www.linux-sh.org/>.
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/sh64/Kconfig
===================================================================
--- linux-2.6.orig/arch/sh64/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/sh64/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -17,10 +17,6 @@ config MMU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
@@ -33,9 +29,6 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_ISA_DMA
 	bool
 
Index: linux-2.6/arch/sparc/Kconfig
===================================================================
--- linux-2.6.orig/arch/sparc/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/sparc/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -143,13 +143,6 @@ config SUN_IO
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.orig/arch/sparc64/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/sparc64/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -163,13 +163,6 @@ config US2E_FREQ
 	  If in doubt, say N.
 
 # Global things across all Sun machines.
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/v850/Kconfig
===================================================================
--- linux-2.6.orig/arch/v850/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/v850/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -10,12 +10,6 @@ mainmenu "uClinux/v850 (w/o MMU) Kernel 
 config MMU
        	bool
 	default n
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default n
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86_64/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/x86_64/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -50,13 +50,6 @@ config ISA
 config SBUS
 	bool
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux-2.6/arch/xtensa/Kconfig
===================================================================
--- linux-2.6.orig/arch/xtensa/Kconfig	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/xtensa/Kconfig	2006-12-04 20:48:17.000000000 +1100
@@ -18,10 +18,6 @@ config XTENSA
 	  with reasonable minimum requirements.  The Xtensa Linux project has
 	  a home page at <http://xtensa.sourceforge.net/>.
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-2.6/arch/i386/Kconfig.cpu
===================================================================
--- linux-2.6.orig/arch/i386/Kconfig.cpu	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/i386/Kconfig.cpu	2006-12-04 20:48:17.000000000 +1100
@@ -231,16 +231,6 @@ config X86_L1_CACHE_SHIFT
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 	default "6" if MK7 || MK8 || MPENTIUMM
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	depends on M386
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	depends on !M386
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Index: linux-2.6/arch/um/Kconfig.x86_64
===================================================================
--- linux-2.6.orig/arch/um/Kconfig.x86_64	2006-12-04 20:48:03.000000000 +1100
+++ linux-2.6/arch/um/Kconfig.x86_64	2006-12-04 20:48:17.000000000 +1100
@@ -7,10 +7,6 @@ config 64BIT
 	default y
 
 #XXX: this is so in the underlying arch, but it's wrong!!!
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
Index: linux-2.6/lib/Makefile
===================================================================
--- linux-2.6.orig/lib/Makefile	2006-12-04 20:48:02.000000000 +1100
+++ linux-2.6/lib/Makefile	2006-12-04 20:48:17.000000000 +1100
@@ -21,8 +21,6 @@ endif
 
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
-lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
-lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
Index: linux-2.6/include/linux/rwsem-spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/rwsem-spinlock.h	2006-12-04 20:48:02.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,77 +0,0 @@
-/* rwsem-spinlock.h: fallback C implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-
-#ifndef _LINUX_RWSEM_SPINLOCK_H
-#define _LINUX_RWSEM_SPINLOCK_H
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead"
-#endif
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-struct rwsem_waiter;
-
-/*
- * the rw-semaphore definition
- * - if activity is 0 then there are no active readers or writers
- * - if activity is +ve then that is the number of active readers
- * - if activity is -1 then there is one active writer
- * - if wait_list is not empty, then there are processes waiting for the semaphore
- */
-struct rw_semaphore {
-	__s32			activity;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-};
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEP_MAP_INIT(name) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
-			 struct lock_class_key *key);
-
-#define init_rwsem(sem)						\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	__init_rwsem((sem), #sem, &__key);			\
-} while (0)
-
-extern void FASTCALL(__down_read(struct rw_semaphore *sem));
-extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
-extern void FASTCALL(__down_write(struct rw_semaphore *sem));
-extern void FASTCALL(__down_write_nested(struct rw_semaphore *sem, int subclass));
-extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
-extern void FASTCALL(__up_read(struct rw_semaphore *sem));
-extern void FASTCALL(__up_write(struct rw_semaphore *sem));
-extern void FASTCALL(__downgrade_write(struct rw_semaphore *sem));
-
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	return (sem->activity != 0);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _LINUX_RWSEM_SPINLOCK_H */
Index: linux-2.6/arch/sparc/lib/rwsem.S
===================================================================
--- linux-2.6.orig/arch/sparc/lib/rwsem.S	2006-12-04 20:48:03.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,204 +0,0 @@
-/* $Id: rwsem.S,v 1.5 2000/05/09 17:40:13 davem Exp $
- * Assembly part of rw semaphores.
- *
- * Copyright (C) 1999 Jakub Jelinek (jakub@redhat.com)
- */
-
-#include <asm/ptrace.h>
-#include <asm/psr.h>
-
-	.section .sched.text
-	.align	4
-
-	.globl		___down_read
-___down_read:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	nop
-	nop
-	nop
-#ifdef CONFIG_SMP
-1:	ldstub		[%g1 + 4], %g7
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	sub		%g7, 1, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	sub		%g7, 1, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	add		%g7, 1, %g7
-	nop
-	nop
-	subcc		%g7, 1, %g7
-	bneg		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	bcs		4f
-	 mov		%g5, %l5
-	call		down_read_failed
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		___down_read
-	 restore	%l5, %g0, %g5
-4:	call		down_read_failed_biased
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-
-	.globl		___down_write
-___down_write:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	sethi		%hi(0x01000000), %g2
-	nop
-	nop
-#ifdef CONFIG_SMP
-1:	ldstub		[%g1 + 4], %g7
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	sub		%g7, %g2, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	sub		%g7, %g2, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	add		%g7, %g2, %g7
-	nop
-	nop
-	subcc		%g7, %g2, %g7
-	bne		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	bcs		4f
-	 mov		%g5, %l5
-	call		down_write_failed
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		___down_write
-	 restore	%l5, %g0, %g5
-4:	call		down_write_failed_biased
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-
-	.text
-	.globl		___up_read
-___up_read:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	nop
-	nop
-	nop
-#ifdef CONFIG_SMP
-1:	ldstub		[%g1 + 4], %g7
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	add		%g7, 1, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	add		%g7, 1, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	nop
-	nop
-	nop
-	cmp		%g7, 0
-	be		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	mov		%g5, %l5
-	clr		%o1
-	call		__rwsem_wake
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-
-	.globl		___up_write
-___up_write:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	sethi		%hi(0x01000000), %g2
-	nop
-	nop
-#ifdef CONFIG_SMP
-1:	ldstub		[%g1 + 4], %g7
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	add		%g7, %g2, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	add		%g7, %g2, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	sub		%g7, %g2, %g7
-	nop
-	nop
-	addcc		%g7, %g2, %g7
-	bcs		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	mov		%g5, %l5
-	mov		%g7, %o1
-	call		__rwsem_wake
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
Index: linux-2.6/arch/sparc64/lib/rwsem.S
===================================================================
--- linux-2.6.orig/arch/sparc64/lib/rwsem.S	2006-12-04 20:48:03.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,170 +0,0 @@
-/* rwsem.S: RW semaphore assembler.
- *
- * Written by David S. Miller (davem@redhat.com), 2001.
- * Derived from asm-i386/rwsem.h
- */
-
-#include <asm/rwsem-const.h>
-
-	.section	.sched.text
-
-	.globl		__down_read
-__down_read:
-1:	lduw		[%o0], %g1
-	add		%g1, 1, %g7
-	cas		[%o0], %g1, %g7
-	cmp		%g1, %g7
-	bne,pn		%icc, 1b
-	 add		%g7, 1, %g7
-	cmp		%g7, 0
-	membar		#StoreLoad | #StoreStore
-	bl,pn		%icc, 3f
-	 nop
-2:
-	retl
-	 nop
-3:
-	save		%sp, -192, %sp
-	call		rwsem_down_read_failed
-	 mov		%i0, %o0
-	ret
-	 restore
-	.size		__down_read, .-__down_read
-
-	.globl		__down_read_trylock
-__down_read_trylock:
-1:	lduw		[%o0], %g1
-	add		%g1, 1, %g7
-	cmp		%g7, 0
-	bl,pn		%icc, 2f
-	 mov		0, %o1
-	cas		[%o0], %g1, %g7
-	cmp		%g1, %g7
-	bne,pn		%icc, 1b
-	 mov		1, %o1
-	membar		#StoreLoad | #StoreStore
-2:	retl
-	 mov		%o1, %o0
-	.size		__down_read_trylock, .-__down_read_trylock
-
-	.globl		__down_write
-__down_write:
-	sethi		%hi(RWSEM_ACTIVE_WRITE_BIAS), %g1
-	or		%g1, %lo(RWSEM_ACTIVE_WRITE_BIAS), %g1
-1:
-	lduw		[%o0], %g3
-	add		%g3, %g1, %g7
-	cas		[%o0], %g3, %g7
-	cmp		%g3, %g7
-	bne,pn		%icc, 1b
-	 cmp		%g7, 0
-	membar		#StoreLoad | #StoreStore
-	bne,pn		%icc, 3f
-	 nop
-2:	retl
-	 nop
-3:
-	save		%sp, -192, %sp
-	call		rwsem_down_write_failed
-	 mov		%i0, %o0
-	ret
-	 restore
-	.size		__down_write, .-__down_write
-
-	.globl		__down_write_trylock
-__down_write_trylock:
-	sethi		%hi(RWSEM_ACTIVE_WRITE_BIAS), %g1
-	or		%g1, %lo(RWSEM_ACTIVE_WRITE_BIAS), %g1
-1:
-	lduw		[%o0], %g3
-	cmp		%g3, 0
-	bne,pn		%icc, 2f
-	 mov		0, %o1
-	add		%g3, %g1, %g7
-	cas		[%o0], %g3, %g7
-	cmp		%g3, %g7
-	bne,pn		%icc, 1b
-	 mov		1, %o1
-	membar		#StoreLoad | #StoreStore
-2:	retl
-	 mov		%o1, %o0
-	.size		__down_write_trylock, .-__down_write_trylock
-
-	.globl		__up_read
-__up_read:
-1:
-	lduw		[%o0], %g1
-	sub		%g1, 1, %g7
-	cas		[%o0], %g1, %g7
-	cmp		%g1, %g7
-	bne,pn		%icc, 1b
-	 cmp		%g7, 0
-	membar		#StoreLoad | #StoreStore
-	bl,pn		%icc, 3f
-	 nop
-2:	retl
-	 nop
-3:	sethi		%hi(RWSEM_ACTIVE_MASK), %g1
-	sub		%g7, 1, %g7
-	or		%g1, %lo(RWSEM_ACTIVE_MASK), %g1
-	andcc		%g7, %g1, %g0
-	bne,pn		%icc, 2b
-	 nop
-	save		%sp, -192, %sp
-	call		rwsem_wake
-	 mov		%i0, %o0
-	ret
-	 restore
-	.size		__up_read, .-__up_read
-
-	.globl		__up_write
-__up_write:
-	sethi		%hi(RWSEM_ACTIVE_WRITE_BIAS), %g1
-	or		%g1, %lo(RWSEM_ACTIVE_WRITE_BIAS), %g1
-1:
-	lduw		[%o0], %g3
-	sub		%g3, %g1, %g7
-	cas		[%o0], %g3, %g7
-	cmp		%g3, %g7
-	bne,pn		%icc, 1b
-	 sub		%g7, %g1, %g7
-	cmp		%g7, 0
-	membar		#StoreLoad | #StoreStore
-	bl,pn		%icc, 3f
-	 nop
-2:
-	retl
-	 nop
-3:
-	save		%sp, -192, %sp
-	call		rwsem_wake
-	 mov		%i0, %o0
-	ret
-	 restore
-	.size		__up_write, .-__up_write
-
-	.globl		__downgrade_write
-__downgrade_write:
-	sethi		%hi(RWSEM_WAITING_BIAS), %g1
-	or		%g1, %lo(RWSEM_WAITING_BIAS), %g1
-1:
-	lduw		[%o0], %g3
-	sub		%g3, %g1, %g7
-	cas		[%o0], %g3, %g7
-	cmp		%g3, %g7
-	bne,pn		%icc, 1b
-	 sub		%g7, %g1, %g7
-	cmp		%g7, 0
-	membar		#StoreLoad | #StoreStore
-	bl,pn		%icc, 3f
-	 nop
-2:
-	retl
-	 nop
-3:
-	save		%sp, -192, %sp
-	call		rwsem_downgrade_wake
-	 mov		%i0, %o0
-	ret
-	 restore
-	.size		__downgrade_write, .-__downgrade_write



----- End forwarded message -----
