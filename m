Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDIAQU>; Sun, 8 Apr 2001 20:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRDIAQF>; Sun, 8 Apr 2001 20:16:05 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:13496 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131317AbRDIAPl>; Sun, 8 Apr 2001 20:15:41 -0400
Message-ID: <3AD0FE54.D335499A@uow.edu.au>
Date: Sun, 08 Apr 2001 17:12:04 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: David Howells <dhowells@cambridge.redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] read/write semaphores
Content-Type: multipart/mixed;
 boundary="------------364AE251FC3F076C21D042B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------364AE251FC3F076C21D042B8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is a new implementation.  After ~20 hours effort I couldn't get
the current x86 rwsem code to work.

This patch breaks all architechtures, but it's a good break and trivial
to fix.  It removes the `RW_LOCK_BIAS' arg in include/linux/sched.h:INIT_MM().

This code is architecture-independent.  It is intended (by me) that
all architectures dump their existing rwsem implementation and use
this one.  It creates include/linux/rw_semaphore.h and lib/rw_semaphore.c.
If other architectures are to use this implementation of rwsems then the
following must be done:

1: delete the existing rwsem code
2: in include/asm/semaphore.h, add:

	#define ARCH_USES_GENERIC_RWSEM
	#include <linux/rw_semaphore.h>

It would be better to split rw_semaphore.h away from semaphore.h
altogether, but that's a lot of mangling.


There are several ways of designing rwsems.  This patch takes
a simple approach:

- If a writer wants the lock and it's free, grant.
- If a reader wants the lock and it's not held by a writer
  and there are no writers waiting for it, grant.
- when the lock is being released, and there are both
  readers and writers waiting on it, we grant it to
  writers.

So writers-starved-by-readers cannot occur.  This is because
new readers block when they see a writer is requesting the rwsem.

Writers *can* starve readers.  If a task is hammering away
on down_write()/up_write() then readers never manage to get
a hold of the semaphore.  Hopefully this won't be a problem.
It's fixable by introducing more state into the rwsem.

It is not legal to do an up_read() or up_write() from
interrupt context.  See the comments in rw_semaphore.c

It is not legal for one task to do more than one concurrent
down_read() on an rwsem.  You can't do:

	down_read(sem);
	...
	down_read(sem);

because an intervening down_write() by another task will cause
deadlock.  See comments in rw_semaphore.c

Patches against 2.4.3-ac2 and 2.4.3 are attached.

There's some rwsem testing code at

	http://www.uow.edu.au/~andrewm/linux/rwsem.tar.gz

which may be used to verify this patch.  rwsem-4.c is the
most useful.

-
--------------364AE251FC3F076C21D042B8
Content-Type: text/plain; charset=us-ascii;
 name="2.4.3-ac2-new-rwsem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.3-ac2-new-rwsem.patch"

--- linux-2.4.3-ac2/include/linux/sched.h	Tue Apr  3 21:47:31 2001
+++ ac/include/linux/sched.h	Sun Apr  8 15:47:54 2001
@@ -241,7 +241,7 @@
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
 	map_count:	1, 				\
-	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem, RW_LOCK_BIAS), \
+	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
 }
--- linux-2.4.3-ac2/include/linux/rw_semaphore.h	Thu Jan  1 00:00:00 1970
+++ ac/include/linux/rw_semaphore.h	Sun Apr  8 15:43:14 2001
@@ -0,0 +1,136 @@
+/*
+ * include/linux/rw_semaphore.h
+ *
+ * An implementation of many reader/one writer sleeping locks
+ *
+ * 08Apr01		Andrew Morton <andrewm@uow.edu.au>
+ *	Created
+ */
+
+#ifdef __KERNEL__
+
+#ifndef __RW_SEMAPHORE_H_INCLUDED
+#define __RW_SEMAPHORE_H_INCLUDED
+
+#ifdef ARCH_USES_GENERIC_RWSEM
+
+//#define DEBUG_RWSEM		/* See lib/rw_semaphore.c */
+
+struct rw_semaphore {
+	/*
+	 * lock protects the integer counter and the waitqueues.
+	 */
+	spinlock_t	lock;
+	/*
+	 * The number of tasks which currently hold a write
+	 * lock or a read lock.  If -1, it is held by a writer.
+	 * If +N, it is held by N readers.  If 0 it is free.
+	 */
+	int nr_holders;
+	/*
+	 * Waitqueues for readers and writers.  The writer queue
+	 * is exclusive.
+	 */
+	wait_queue_head_t	writers_wait;
+	wait_queue_head_t	readers_wait;
+};
+
+#define __RWSEM_INITIALIZER(_name)						\
+{										\
+	lock:		SPIN_LOCK_UNLOCKED,					\
+	nr_holders:	0,							\
+	writers_wait:	__WAIT_QUEUE_HEAD_INITIALIZER((_name).writers_wait),	\
+	readers_wait:	__WAIT_QUEUE_HEAD_INITIALIZER((_name).readers_wait),	\
+}
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+extern void down_write_wait(struct rw_semaphore *sem);
+extern void down_read_wait(struct rw_semaphore *sem);
+extern void rwsem_wake_up(wait_queue_head_t *wq);
+
+#ifdef DEBUG_RWSEM
+extern struct rw_semaphore *rwsem_to_monitor;
+extern void dump_rwsem(const char *msg, struct rw_semaphore *sem);
+#else
+#define dump_rwsem(msg, sem) do {} while (0)
+#endif
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	spin_lock_init(&sem->lock);
+	sem->nr_holders = 0;
+	init_waitqueue_head(&sem->writers_wait);
+	init_waitqueue_head(&sem->readers_wait);
+}
+
+/*
+ * If there are no readers or writers, down_write() acquires the rwsem
+ */
+static inline void down_write(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	if (sem->nr_holders)
+		down_write_wait(sem);
+	sem->nr_holders = -1;
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+/*
+ * If there are no writers and no waiting writers, down_read()
+ * acquires the rwsem
+ */
+static inline void down_read(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	if (sem->nr_holders < 0 || waitqueue_active(&sem->writers_wait))
+		down_read_wait(sem);
+	sem->nr_holders++;
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+/*
+ * If there are writers waiting, up_write() tries to give the rwsem
+ * to them.
+ */
+static inline void up_write(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	sem->nr_holders = 0;
+	if (waitqueue_active(&sem->writers_wait)) {
+		rwsem_wake_up(&sem->writers_wait);
+	} else if (waitqueue_active(&sem->readers_wait)) {
+		rwsem_wake_up(&sem->readers_wait);
+	}
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+/*
+ * If there are writers waiting and no readers hold the rswem,
+ * up_read() tries to give the rwsem to the writers.  If there
+ * are some readers who hold the rwsem, no action is needed.
+ */
+static inline void up_read(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	sem->nr_holders--;
+	if (sem->nr_holders == 0) {
+		if (waitqueue_active(&sem->writers_wait))
+			rwsem_wake_up(&sem->writers_wait);
+	}
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+#endif	/* ARCH_USES_GENERIC_RWSEM */
+#endif	/* __RW_SEMAPHORE_H_INCLUDED */
+#endif	/* __KERNEL__ */
+
--- linux-2.4.3-ac2/arch/i386/kernel/semaphore.c	Sat Nov 18 17:31:25 2000
+++ ac/arch/i386/kernel/semaphore.c	Sun Apr  8 03:02:21 2001
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 #include <asm/semaphore.h>
 
@@ -230,200 +231,13 @@
 	"ret"
 );
 
-asm(
-"
-.align 4
-.globl __down_read_failed
-__down_read_failed:
-	pushl	%edx
-	pushl	%ecx
-	jnc	2f
-
-3:	call	down_read_failed_biased
-
-1:	popl	%ecx
-	popl	%edx
-	ret
-
-2:	call	down_read_failed
-	" LOCK "subl	$1,(%eax)
-	jns	1b
-	jnc	2b
-	jmp	3b
-"
-);
-
-asm(
-"
-.align 4
-.globl __down_write_failed
-__down_write_failed:
-	pushl	%edx
-	pushl	%ecx
-	jnc	2f
-
-3:	call	down_write_failed_biased
-
-1:	popl	%ecx
-	popl	%edx
-	ret
-
-2:	call	down_write_failed
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jz	1b
-	jnc	2b
-	jmp	3b
-"
-);
-
-struct rw_semaphore *FASTCALL(rwsem_wake_readers(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(rwsem_wake_writer(struct rw_semaphore *sem));
-
-struct rw_semaphore *FASTCALL(down_read_failed_biased(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_write_failed_biased(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_read_failed(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_write_failed(struct rw_semaphore *sem));
-
-struct rw_semaphore *down_read_failed_biased(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	add_wait_queue(&sem->wait, &wait);	/* put ourselves at the head of the list */
-
-	for (;;) {
-		if (sem->read_bias_granted && xchg(&sem->read_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->read_bias_granted)
-			schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-struct rw_semaphore *down_write_failed_biased(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	add_wait_queue_exclusive(&sem->write_bias_wait, &wait);	/* put ourselves at the end of the list */
-
-	for (;;) {
-		if (sem->write_bias_granted && xchg(&sem->write_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->write_bias_granted)
-			schedule();
-	}
-
-	remove_wait_queue(&sem->write_bias_wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	/* if the lock is currently unbiased, awaken the sleepers
-	 * FIXME: this wakes up the readers early in a bit of a
-	 * stampede -> bad!
-	 */
-	if (atomic_read(&sem->count) >= 0)
-		wake_up(&sem->wait);
-
-	return sem;
-}
-
-/* Wait for the lock to become unbiased.  Readers
- * are non-exclusive. =)
- */
-struct rw_semaphore *down_read_failed(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	__up_read(sem);	/* this takes care of granting the lock */
-
-	add_wait_queue(&sem->wait, &wait);
-
-	while (atomic_read(&sem->count) < 0) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
-			break;
-		schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-/* Wait for the lock to become unbiased. Since we're
- * a writer, we'll make ourselves exclusive.
- */
-struct rw_semaphore *down_write_failed(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	__up_write(sem);	/* this takes care of granting the lock */
-
-	add_wait_queue_exclusive(&sem->wait, &wait);
-
-	while (atomic_read(&sem->count) < 0) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
-			break;	/* we must attempt to acquire or bias the lock */
-		schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-asm(
-"
-.align 4
-.globl __rwsem_wake
-__rwsem_wake:
-	pushl	%edx
-	pushl	%ecx
-
-	jz	1f
-	call	rwsem_wake_readers
-	jmp	2f
-
-1:	call	rwsem_wake_writer
-
-2:	popl	%ecx
-	popl	%edx
-	ret
-"
-);
-
-/* Called when someone has done an up that transitioned from
- * negative to non-negative, meaning that the lock has been
- * granted to whomever owned the bias.
- */
-struct rw_semaphore *rwsem_wake_readers(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->read_bias_granted, 1))
-		BUG();
-	wake_up(&sem->wait);
-	return sem;
-}
-
-struct rw_semaphore *rwsem_wake_writer(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->write_bias_granted, 1))
-		BUG();
-	wake_up(&sem->write_bias_wait);
-	return sem;
-}
+/***************************************/
+/* read_lock/write_lock implementation */
+/***************************************/
 
 #if defined(CONFIG_SMP)
+extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
+extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
 asm(
 "
 .align	4
@@ -450,5 +264,20 @@
 	ret
 "
 );
-#endif
+EXPORT_SYMBOL_NOVERS(__write_lock_failed);
+EXPORT_SYMBOL_NOVERS(__read_lock_failed);
+#endif	/* CONFIG_SMP */
+
+/*
+ * It's nicer to put these EXPORT statements near the site of definition,
+ * but when gcc compiles an EXPORT_SYMBOL it leaves code generation in
+ * the __ksymtab section.  So if one of the above global asm statments
+ * comes next, it gets assembled into __ksymtab and things die horridly.
+ * It's safer to put these here, unless we're sure that an EXPORT_SYMBOL
+ * is to be followed by a C function.
+ */
+EXPORT_SYMBOL_NOVERS(__down_failed);
+EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
+EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
+EXPORT_SYMBOL_NOVERS(__up_wakeup);
 
--- linux-2.4.3-ac2/include/asm-i386/semaphore.h	Tue Apr  3 21:47:31 2001
+++ ac/include/asm-i386/semaphore.h	Sun Apr  8 15:43:32 2001
@@ -41,6 +41,10 @@
 #include <asm/rwlock.h>
 #include <linux/wait.h>
 
+/* For legacy reasons, you get rw_semaphores when you include semaphore.h */
+#define ARCH_USES_GENERIC_RWSEM
+#include <linux/rw_semaphore.h>
+
 struct semaphore {
 	atomic_t count;
 	int sleepers;
@@ -212,183 +216,5 @@
 		:"memory");
 }
 
-/* rw mutexes (should that be mutices? =) -- throw rw
- * spinlocks and semaphores together, and this is what we
- * end up with...
- *
- * The lock is initialized to BIAS.  This way, a writer
- * subtracts BIAS ands gets 0 for the case of an uncontended
- * lock.  Readers decrement by 1 and see a positive value
- * when uncontended, negative if there are writers waiting
- * (in which case it goes to sleep).
- *
- * The value 0x01000000 supports up to 128 processors and
- * lots of processes.  BIAS must be chosen such that subl'ing
- * BIAS once per CPU will result in the long remaining
- * negative.
- *
- * In terms of fairness, this should result in the lock
- * flopping back and forth between readers and writers
- * under heavy use.
- *
- *		-ben
- */
-struct rw_semaphore {
-	atomic_t		count;
-	volatile unsigned char	write_bias_granted;
-	volatile unsigned char	read_bias_granted;
-	volatile unsigned char	pad1;
-	volatile unsigned char	pad2;
-	wait_queue_head_t	wait;
-	wait_queue_head_t	write_bias_wait;
-#if WAITQUEUE_DEBUG
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-#define __RWSEM_DEBUG_INIT	, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, 0, 0, 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait), \
-	__WAIT_QUEUE_HEAD_INITIALIZER((name).write_bias_wait) \
-	__SEM_DEBUG_INIT(name) __RWSEM_DEBUG_INIT }
-
-#define __DECLARE_RWSEM_GENERIC(name,count) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name,count)
-
-#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS)
-#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS-1)
-#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,0)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	atomic_set(&sem->count, RW_LOCK_BIAS);
-	sem->read_bias_granted = 0;
-	sem->write_bias_granted = 0;
-	init_waitqueue_head(&sem->wait);
-	init_waitqueue_head(&sem->write_bias_wait);
-#if WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-	atomic_set(&sem->readers, 0);
-	atomic_set(&sem->writers, 0);
-#endif
-}
-
-/* we use FASTCALL convention for the helpers */
-extern struct rw_semaphore *FASTCALL(__down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
-
-static inline void down_read(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-	__build_read_lock(sem, "__down_read_failed");
-#if WAITQUEUE_DEBUG
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_inc(&sem->readers);
-#endif
-}
-
-static inline void down_write(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-	__build_write_lock(sem, "__down_write_failed");
-#if WAITQUEUE_DEBUG
-	if (atomic_read(&sem->writers))
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (sem->read_bias_granted)
-		BUG();
-	if (sem->write_bias_granted)
-		BUG();
-	atomic_inc(&sem->writers);
-#endif
-}
-
-/* When a reader does a release, the only significant
- * case is when there was a writer waiting, and we've
- * bumped the count to 0: we must wake the writer up.
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# up_read\n\t"
-		LOCK "incl %0\n\t"
-		"jz 2f\n"			/* only do the wake if result == 0 (ie, a writer) */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
-}
-
-/* releasing the writer is easy -- just release it and
- * wake up any sleepers.
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# up_write\n\t"
-		LOCK "addl $" RW_LOCK_BIAS_STR ",%0\n"
-		"jc 2f\n"			/* only do the wake if the result was -'ve to 0/+'ve */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
-}
-
-static inline void up_read(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_dec(&sem->readers);
-#endif
-	__up_read(sem);
-}
-
-static inline void up_write(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->read_bias_granted)
-		BUG();
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (atomic_read(&sem->writers) != 1)
-		BUG();
-	atomic_dec(&sem->writers);
-#endif
-	__up_write(sem);
-}
-
-#endif
-#endif
+#endif	/* __KERNEL */
+#endif	/* _I386_SEMAPHORE_H */
--- linux-2.4.3-ac2/arch/i386/kernel/i386_ksyms.c	Tue Apr  3 21:47:25 2001
+++ ac/arch/i386/kernel/i386_ksyms.c	Sun Apr  8 02:40:40 2001
@@ -38,11 +38,6 @@
 EXPORT_SYMBOL(machine_real_restart);
 #endif
 
-#ifdef CONFIG_SMP
-extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
-extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
-#endif
-
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
 extern struct drive_info_struct drive_info;
 EXPORT_SYMBOL(drive_info);
@@ -76,13 +71,6 @@
 EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(gdt);
 
-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
-EXPORT_SYMBOL_NOVERS(__down_write_failed);
-EXPORT_SYMBOL_NOVERS(__down_read_failed);
-EXPORT_SYMBOL_NOVERS(__rwsem_wake);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
@@ -128,8 +116,6 @@
 EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL_NOVERS(__write_lock_failed);
-EXPORT_SYMBOL_NOVERS(__read_lock_failed);
 
 /* Global SMP irq stuff */
 EXPORT_SYMBOL(synchronize_irq);
--- linux-2.4.3-ac2/arch/i386/kernel/Makefile	Tue Apr  3 21:47:25 2001
+++ ac/arch/i386/kernel/Makefile	Sun Apr  8 02:40:40 2001
@@ -14,7 +14,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o semaphore.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
--- linux-2.4.3-ac2/lib/rw_semaphore.c	Thu Jan  1 00:00:00 1970
+++ ac/lib/rw_semaphore.c	Sun Apr  8 16:26:21 2001
@@ -0,0 +1,135 @@
+/*
+ * lib/rw_semaphore.c
+ *
+ * Many reader/one writer sleeping locks
+ *
+ * 08Apr01		Andrew Morton <andrewm@uow.edu.au>
+ *	Created
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/semaphore.h>
+
+#ifdef ARCH_USES_GENERIC_RWSEM
+/*
+ * This is a simple implementation of rwsems.
+ *
+ * If a writer requests the rwsem and there are no readers or writers
+ * holding it, the writer is granted access.
+ *
+ * If a reader requests the rwsem and there are no writers holding it,
+ * and there are no writers waiting on it, the reader is granted access.
+ *
+ * up_write() prefers to grant the rwsem to writers.
+ *
+ * It is NOT legal to call up_read() or up_write() from interrupt
+ * context.  This is because we do a bare spin_lock(&sem->lock).
+ * This is fixable - change the spin_lock() calls into spin_lock_irqsave()
+ * and uninline everything (for SPARC).
+ *
+ * It is NOT legal for one task to down_read() an rwsem multiple times.
+ * This can cause a deadlock:
+ *
+ *	TaskA:	down_read(sem);
+ *	TaskB:	down_write(sem);
+ *	TaskA:	down_read(sem);
+ *
+ *	TaskB's down_write() is blocking on TaskA's down_read(),
+ *	and TaskA's down_read() is blocking because there is a waiting
+ *	writer.
+ *
+ * This is fixable, but the cost would be either considerable complexity,
+ * or the creation of rwsems which are prone to reader-starves-writer.
+ *
+ */
+
+/*
+ * We can use the unlocked versions of add_wait_queue() because whenever
+ * we touch the waitqueue we hold the rwsem's spinlock.
+ */
+
+#ifndef __add_wait_queue_exclusive
+#define __add_wait_queue_exclusive __add_wait_queue_tail
+#endif
+
+/*
+ * If DEBUG_RWSEM is defined then rwsem test code can
+ * set the global pointer `rwsem_to_monitor' to point
+ * to an rwsem.  Then the debugging information will be
+ * produced for that rwsem.
+ */
+
+#ifdef DEBUG_RWSEM
+struct rw_semaphore *rwsem_to_monitor;
+void dump_rwsem(const char *msg, struct rw_semaphore *sem)
+{
+	if (sem == rwsem_to_monitor) {
+		printk("%d: %s\n", current->pid, msg);
+		printk("  nr_h:%d wqa_w:%d wqa_r:%d\n",
+			sem->nr_holders,
+			waitqueue_active(&sem->writers_wait),
+			waitqueue_active(&sem->readers_wait));
+	}
+}
+EXPORT_SYMBOL(rwsem_to_monitor);
+EXPORT_SYMBOL(dump_rwsem);
+#endif
+
+/*
+ * down_write() failed to acquire the rwsem.  So we sleep
+ * until it is free and we can acquire it.
+ */
+void down_write_wait(struct rw_semaphore *sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	dump_rwsem(__FUNCTION__ " in", sem);
+	__add_wait_queue_exclusive(&sem->writers_wait, &wait);
+	do {
+		/* spin_unlock is a barrier, so use __set_task_state() here */
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
+		schedule();
+		spin_lock(&sem->lock);
+	} while (sem->nr_holders);
+	__remove_wait_queue(&sem->writers_wait, &wait);
+	dump_rwsem(__FUNCTION__ " out", sem);
+}
+EXPORT_SYMBOL_NOVERS(down_write_wait);
+
+/*
+ * down_read() failed to acquire the rwsem.  We sleep
+ * until there are no writers holding it and no writers
+ * requesting it.
+ */
+void down_read_wait(struct rw_semaphore *sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	dump_rwsem(__FUNCTION__ " in", sem);
+	__add_wait_queue(&sem->readers_wait, &wait);
+	do {
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
+		schedule();
+		spin_lock(&sem->lock);
+	} while (sem->nr_holders < 0 || waitqueue_active(&sem->writers_wait));
+	__remove_wait_queue(&sem->readers_wait, &wait);
+	dump_rwsem(__FUNCTION__ " out", sem);
+}
+EXPORT_SYMBOL_NOVERS(down_read_wait);
+
+/*
+ * This could perhaps be inline, but sched.h includes semaphore.h,
+ * so semaphore.h can't get at the wake_up() macro definition.
+ */
+void rwsem_wake_up(wait_queue_head_t *wq)
+{
+	wake_up(wq);
+}
+EXPORT_SYMBOL_NOVERS(rwsem_wake_up);
+
+#endif	/* ARCH_USES_GENERIC_RWSEM */
--- linux-2.4.3-ac2/lib/Makefile	Tue Apr  3 21:47:31 2001
+++ ac/lib/Makefile	Sun Apr  8 03:30:52 2001
@@ -8,9 +8,11 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o
+export-objs := cmdline.o rw_semaphore.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
+	bust_spinlocks.o rw_semaphore.o
+	
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o


--------------364AE251FC3F076C21D042B8
Content-Type: text/plain; charset=us-ascii;
 name="2.4.3-new-rwsem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.3-new-rwsem.patch"

--- linux-2.4.3/include/linux/sched.h	Tue Apr  3 21:21:23 2001
+++ linux-akpm/include/linux/sched.h	Sun Apr  8 16:18:05 2001
@@ -239,7 +239,7 @@
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
 	map_count:	1, 				\
-	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem, RW_LOCK_BIAS), \
+	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
 }
--- linux-2.4.3/include/linux/rw_semaphore.h	Thu Jan  1 00:00:00 1970
+++ linux-akpm/include/linux/rw_semaphore.h	Sun Apr  8 16:16:07 2001
@@ -0,0 +1,136 @@
+/*
+ * include/linux/rw_semaphore.h
+ *
+ * An implementation of many reader/one writer sleeping locks
+ *
+ * 08Apr01		Andrew Morton <andrewm@uow.edu.au>
+ *	Created
+ */
+
+#ifdef __KERNEL__
+
+#ifndef __RW_SEMAPHORE_H_INCLUDED
+#define __RW_SEMAPHORE_H_INCLUDED
+
+#ifdef ARCH_USES_GENERIC_RWSEM
+
+//#define DEBUG_RWSEM		/* See lib/rw_semaphore.c */
+
+struct rw_semaphore {
+	/*
+	 * lock protects the integer counter and the waitqueues.
+	 */
+	spinlock_t	lock;
+	/*
+	 * The number of tasks which currently hold a write
+	 * lock or a read lock.  If -1, it is held by a writer.
+	 * If +N, it is held by N readers.  If 0 it is free.
+	 */
+	int nr_holders;
+	/*
+	 * Waitqueues for readers and writers.  The writer queue
+	 * is exclusive.
+	 */
+	wait_queue_head_t	writers_wait;
+	wait_queue_head_t	readers_wait;
+};
+
+#define __RWSEM_INITIALIZER(_name)						\
+{										\
+	lock:		SPIN_LOCK_UNLOCKED,					\
+	nr_holders:	0,							\
+	writers_wait:	__WAIT_QUEUE_HEAD_INITIALIZER((_name).writers_wait),	\
+	readers_wait:	__WAIT_QUEUE_HEAD_INITIALIZER((_name).readers_wait),	\
+}
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+extern void down_write_wait(struct rw_semaphore *sem);
+extern void down_read_wait(struct rw_semaphore *sem);
+extern void rwsem_wake_up(wait_queue_head_t *wq);
+
+#ifdef DEBUG_RWSEM
+extern struct rw_semaphore *rwsem_to_monitor;
+extern void dump_rwsem(const char *msg, struct rw_semaphore *sem);
+#else
+#define dump_rwsem(msg, sem) do {} while (0)
+#endif
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	spin_lock_init(&sem->lock);
+	sem->nr_holders = 0;
+	init_waitqueue_head(&sem->writers_wait);
+	init_waitqueue_head(&sem->readers_wait);
+}
+
+/*
+ * If there are no readers or writers, down_write() acquires the rwsem
+ */
+static inline void down_write(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	if (sem->nr_holders)
+		down_write_wait(sem);
+	sem->nr_holders = -1;
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+/*
+ * If there are no writers and no waiting writers, down_read()
+ * acquires the rwsem
+ */
+static inline void down_read(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	if (sem->nr_holders < 0 || waitqueue_active(&sem->writers_wait))
+		down_read_wait(sem);
+	sem->nr_holders++;
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+/*
+ * If there are writers waiting, up_write() tries to give the rwsem
+ * to them.
+ */
+static inline void up_write(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	sem->nr_holders = 0;
+	if (waitqueue_active(&sem->writers_wait)) {
+		rwsem_wake_up(&sem->writers_wait);
+	} else if (waitqueue_active(&sem->readers_wait)) {
+		rwsem_wake_up(&sem->readers_wait);
+	}
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+/*
+ * If there are writers waiting and no readers hold the rswem,
+ * up_read() tries to give the rwsem to the writers.  If there
+ * are some readers who hold the rwsem, no action is needed.
+ */
+static inline void up_read(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	dump_rwsem(__FUNCTION__ " in", sem);
+	sem->nr_holders--;
+	if (sem->nr_holders == 0) {
+		if (waitqueue_active(&sem->writers_wait))
+			rwsem_wake_up(&sem->writers_wait);
+	}
+	dump_rwsem(__FUNCTION__ " out", sem);
+	spin_unlock(&sem->lock);
+}
+
+#endif	/* ARCH_USES_GENERIC_RWSEM */
+#endif	/* __RW_SEMAPHORE_H_INCLUDED */
+#endif	/* __KERNEL__ */
+
--- linux-2.4.3/arch/i386/kernel/semaphore.c	Sat Nov 18 17:31:25 2000
+++ linux-akpm/arch/i386/kernel/semaphore.c	Sun Apr  8 16:16:07 2001
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 #include <asm/semaphore.h>
 
@@ -230,200 +231,13 @@
 	"ret"
 );
 
-asm(
-"
-.align 4
-.globl __down_read_failed
-__down_read_failed:
-	pushl	%edx
-	pushl	%ecx
-	jnc	2f
-
-3:	call	down_read_failed_biased
-
-1:	popl	%ecx
-	popl	%edx
-	ret
-
-2:	call	down_read_failed
-	" LOCK "subl	$1,(%eax)
-	jns	1b
-	jnc	2b
-	jmp	3b
-"
-);
-
-asm(
-"
-.align 4
-.globl __down_write_failed
-__down_write_failed:
-	pushl	%edx
-	pushl	%ecx
-	jnc	2f
-
-3:	call	down_write_failed_biased
-
-1:	popl	%ecx
-	popl	%edx
-	ret
-
-2:	call	down_write_failed
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jz	1b
-	jnc	2b
-	jmp	3b
-"
-);
-
-struct rw_semaphore *FASTCALL(rwsem_wake_readers(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(rwsem_wake_writer(struct rw_semaphore *sem));
-
-struct rw_semaphore *FASTCALL(down_read_failed_biased(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_write_failed_biased(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_read_failed(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_write_failed(struct rw_semaphore *sem));
-
-struct rw_semaphore *down_read_failed_biased(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	add_wait_queue(&sem->wait, &wait);	/* put ourselves at the head of the list */
-
-	for (;;) {
-		if (sem->read_bias_granted && xchg(&sem->read_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->read_bias_granted)
-			schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-struct rw_semaphore *down_write_failed_biased(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	add_wait_queue_exclusive(&sem->write_bias_wait, &wait);	/* put ourselves at the end of the list */
-
-	for (;;) {
-		if (sem->write_bias_granted && xchg(&sem->write_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->write_bias_granted)
-			schedule();
-	}
-
-	remove_wait_queue(&sem->write_bias_wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	/* if the lock is currently unbiased, awaken the sleepers
-	 * FIXME: this wakes up the readers early in a bit of a
-	 * stampede -> bad!
-	 */
-	if (atomic_read(&sem->count) >= 0)
-		wake_up(&sem->wait);
-
-	return sem;
-}
-
-/* Wait for the lock to become unbiased.  Readers
- * are non-exclusive. =)
- */
-struct rw_semaphore *down_read_failed(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	__up_read(sem);	/* this takes care of granting the lock */
-
-	add_wait_queue(&sem->wait, &wait);
-
-	while (atomic_read(&sem->count) < 0) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
-			break;
-		schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-/* Wait for the lock to become unbiased. Since we're
- * a writer, we'll make ourselves exclusive.
- */
-struct rw_semaphore *down_write_failed(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	__up_write(sem);	/* this takes care of granting the lock */
-
-	add_wait_queue_exclusive(&sem->wait, &wait);
-
-	while (atomic_read(&sem->count) < 0) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
-			break;	/* we must attempt to acquire or bias the lock */
-		schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-asm(
-"
-.align 4
-.globl __rwsem_wake
-__rwsem_wake:
-	pushl	%edx
-	pushl	%ecx
-
-	jz	1f
-	call	rwsem_wake_readers
-	jmp	2f
-
-1:	call	rwsem_wake_writer
-
-2:	popl	%ecx
-	popl	%edx
-	ret
-"
-);
-
-/* Called when someone has done an up that transitioned from
- * negative to non-negative, meaning that the lock has been
- * granted to whomever owned the bias.
- */
-struct rw_semaphore *rwsem_wake_readers(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->read_bias_granted, 1))
-		BUG();
-	wake_up(&sem->wait);
-	return sem;
-}
-
-struct rw_semaphore *rwsem_wake_writer(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->write_bias_granted, 1))
-		BUG();
-	wake_up(&sem->write_bias_wait);
-	return sem;
-}
+/***************************************/
+/* read_lock/write_lock implementation */
+/***************************************/
 
 #if defined(CONFIG_SMP)
+extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
+extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
 asm(
 "
 .align	4
@@ -450,5 +264,20 @@
 	ret
 "
 );
-#endif
+EXPORT_SYMBOL_NOVERS(__write_lock_failed);
+EXPORT_SYMBOL_NOVERS(__read_lock_failed);
+#endif	/* CONFIG_SMP */
+
+/*
+ * It's nicer to put these EXPORT statements near the site of definition,
+ * but when gcc compiles an EXPORT_SYMBOL it leaves code generation in
+ * the __ksymtab section.  So if one of the above global asm statments
+ * comes next, it gets assembled into __ksymtab and things die horridly.
+ * It's safer to put these here, unless we're sure that an EXPORT_SYMBOL
+ * is to be followed by a C function.
+ */
+EXPORT_SYMBOL_NOVERS(__down_failed);
+EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
+EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
+EXPORT_SYMBOL_NOVERS(__up_wakeup);
 
--- linux-2.4.3/include/asm-i386/semaphore.h	Mon Jan 29 23:24:56 2001
+++ linux-akpm/include/asm-i386/semaphore.h	Sun Apr  8 16:16:07 2001
@@ -41,6 +41,10 @@
 #include <asm/rwlock.h>
 #include <linux/wait.h>
 
+/* For legacy reasons, you get rw_semaphores when you include semaphore.h */
+#define ARCH_USES_GENERIC_RWSEM
+#include <linux/rw_semaphore.h>
+
 struct semaphore {
 	atomic_t count;
 	int sleepers;
@@ -204,183 +208,5 @@
 		:"memory");
 }
 
-/* rw mutexes (should that be mutices? =) -- throw rw
- * spinlocks and semaphores together, and this is what we
- * end up with...
- *
- * The lock is initialized to BIAS.  This way, a writer
- * subtracts BIAS ands gets 0 for the case of an uncontended
- * lock.  Readers decrement by 1 and see a positive value
- * when uncontended, negative if there are writers waiting
- * (in which case it goes to sleep).
- *
- * The value 0x01000000 supports up to 128 processors and
- * lots of processes.  BIAS must be chosen such that subl'ing
- * BIAS once per CPU will result in the long remaining
- * negative.
- *
- * In terms of fairness, this should result in the lock
- * flopping back and forth between readers and writers
- * under heavy use.
- *
- *		-ben
- */
-struct rw_semaphore {
-	atomic_t		count;
-	volatile unsigned char	write_bias_granted;
-	volatile unsigned char	read_bias_granted;
-	volatile unsigned char	pad1;
-	volatile unsigned char	pad2;
-	wait_queue_head_t	wait;
-	wait_queue_head_t	write_bias_wait;
-#if WAITQUEUE_DEBUG
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-#define __RWSEM_DEBUG_INIT	, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, 0, 0, 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait), \
-	__WAIT_QUEUE_HEAD_INITIALIZER((name).write_bias_wait) \
-	__SEM_DEBUG_INIT(name) __RWSEM_DEBUG_INIT }
-
-#define __DECLARE_RWSEM_GENERIC(name,count) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name,count)
-
-#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS)
-#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS-1)
-#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,0)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	atomic_set(&sem->count, RW_LOCK_BIAS);
-	sem->read_bias_granted = 0;
-	sem->write_bias_granted = 0;
-	init_waitqueue_head(&sem->wait);
-	init_waitqueue_head(&sem->write_bias_wait);
-#if WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-	atomic_set(&sem->readers, 0);
-	atomic_set(&sem->writers, 0);
-#endif
-}
-
-/* we use FASTCALL convention for the helpers */
-extern struct rw_semaphore *FASTCALL(__down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
-
-static inline void down_read(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-	__build_read_lock(sem, "__down_read_failed");
-#if WAITQUEUE_DEBUG
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_inc(&sem->readers);
-#endif
-}
-
-static inline void down_write(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-	__build_write_lock(sem, "__down_write_failed");
-#if WAITQUEUE_DEBUG
-	if (atomic_read(&sem->writers))
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (sem->read_bias_granted)
-		BUG();
-	if (sem->write_bias_granted)
-		BUG();
-	atomic_inc(&sem->writers);
-#endif
-}
-
-/* When a reader does a release, the only significant
- * case is when there was a writer waiting, and we've
- * bumped the count to 0: we must wake the writer up.
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# up_read\n\t"
-		LOCK "incl %0\n\t"
-		"jz 2f\n"			/* only do the wake if result == 0 (ie, a writer) */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
-}
-
-/* releasing the writer is easy -- just release it and
- * wake up any sleepers.
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# up_write\n\t"
-		LOCK "addl $" RW_LOCK_BIAS_STR ",%0\n"
-		"jc 2f\n"			/* only do the wake if the result was -'ve to 0/+'ve */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
-}
-
-static inline void up_read(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_dec(&sem->readers);
-#endif
-	__up_read(sem);
-}
-
-static inline void up_write(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->read_bias_granted)
-		BUG();
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (atomic_read(&sem->writers) != 1)
-		BUG();
-	atomic_dec(&sem->writers);
-#endif
-	__up_write(sem);
-}
-
-#endif
-#endif
+#endif	/* __KERNEL */
+#endif	/* _I386_SEMAPHORE_H */
--- linux-2.4.3/arch/i386/kernel/i386_ksyms.c	Tue Apr  3 21:21:16 2001
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Sun Apr  8 16:16:07 2001
@@ -37,11 +37,6 @@
 EXPORT_SYMBOL(machine_real_restart);
 #endif
 
-#ifdef CONFIG_SMP
-extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
-extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
-#endif
-
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
 extern struct drive_info_struct drive_info;
 EXPORT_SYMBOL(drive_info);
@@ -73,13 +68,6 @@
 EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(gdt);
 
-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
-EXPORT_SYMBOL_NOVERS(__down_write_failed);
-EXPORT_SYMBOL_NOVERS(__down_read_failed);
-EXPORT_SYMBOL_NOVERS(__rwsem_wake);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
@@ -124,8 +112,6 @@
 EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL_NOVERS(__write_lock_failed);
-EXPORT_SYMBOL_NOVERS(__read_lock_failed);
 
 /* Global SMP irq stuff */
 EXPORT_SYMBOL(synchronize_irq);
--- linux-2.4.3/arch/i386/kernel/Makefile	Fri Dec 29 14:35:47 2000
+++ linux-akpm/arch/i386/kernel/Makefile	Sun Apr  8 16:16:07 2001
@@ -14,7 +14,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o semaphore.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
--- linux-2.4.3/lib/rw_semaphore.c	Thu Jan  1 00:00:00 1970
+++ linux-akpm/lib/rw_semaphore.c	Sun Apr  8 16:26:03 2001
@@ -0,0 +1,135 @@
+/*
+ * lib/rw_semaphore.c
+ *
+ * Many reader/one writer sleeping locks
+ *
+ * 08Apr01		Andrew Morton <andrewm@uow.edu.au>
+ *	Created
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <asm/semaphore.h>
+
+#ifdef ARCH_USES_GENERIC_RWSEM
+/*
+ * This is a simple implementation of rwsems.
+ *
+ * If a writer requests the rwsem and there are no readers or writers
+ * holding it, the writer is granted access.
+ *
+ * If a reader requests the rwsem and there are no writers holding it,
+ * and there are no writers waiting on it, the reader is granted access.
+ *
+ * up_write() prefers to grant the rwsem to writers.
+ *
+ * It is NOT legal to call up_read() or up_write() from interrupt
+ * context.  This is because we do a bare spin_lock(&sem->lock).
+ * This is fixable - change the spin_lock() calls into spin_lock_irqsave()
+ * and uninline everything (for SPARC).
+ *
+ * It is NOT legal for one task to down_read() an rwsem multiple times.
+ * This can cause a deadlock:
+ *
+ *	TaskA:	down_read(sem);
+ *	TaskB:	down_write(sem);
+ *	TaskA:	down_read(sem);
+ *
+ *	TaskB's down_write() is blocking on TaskA's down_read(),
+ *	and TaskA's down_read() is blocking because there is a waiting
+ *	writer.
+ *
+ * This is fixable, but the cost would be either considerable complexity,
+ * or the creation of rwsems which are prone to reader-starves-writer.
+ *
+ */
+
+/*
+ * We can use the unlocked versions of add_wait_queue() because whenever
+ * we touch the waitqueue we hold the rwsem's spinlock.
+ */
+
+#ifndef __add_wait_queue_exclusive
+#define __add_wait_queue_exclusive __add_wait_queue_tail
+#endif
+
+/*
+ * If DEBUG_RWSEM is defined then rwsem test code can
+ * set the global pointer `rwsem_to_monitor' to point
+ * to an rwsem.  Then the debugging information will be
+ * produced for that rwsem.
+ */
+
+#ifdef DEBUG_RWSEM
+struct rw_semaphore *rwsem_to_monitor;
+void dump_rwsem(const char *msg, struct rw_semaphore *sem)
+{
+	if (sem == rwsem_to_monitor) {
+		printk("%d: %s\n", current->pid, msg);
+		printk("  nr_h:%d wqa_w:%d wqa_r:%d\n",
+			sem->nr_holders,
+			waitqueue_active(&sem->writers_wait),
+			waitqueue_active(&sem->readers_wait));
+	}
+}
+EXPORT_SYMBOL(rwsem_to_monitor);
+EXPORT_SYMBOL(dump_rwsem);
+#endif
+
+/*
+ * down_write() failed to acquire the rwsem.  So we sleep
+ * until it is free and we can acquire it.
+ */
+void down_write_wait(struct rw_semaphore *sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	dump_rwsem(__FUNCTION__ " in", sem);
+	__add_wait_queue_exclusive(&sem->writers_wait, &wait);
+	do {
+		/* spin_unlock is a barrier, so use __set_task_state() here */
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
+		schedule();
+		spin_lock(&sem->lock);
+	} while (sem->nr_holders);
+	__remove_wait_queue(&sem->writers_wait, &wait);
+	dump_rwsem(__FUNCTION__ " out", sem);
+}
+EXPORT_SYMBOL_NOVERS(down_write_wait);
+
+/*
+ * down_read() failed to acquire the rwsem.  We sleep
+ * until there are no writers holding it and no writers
+ * requesting it.
+ */
+void down_read_wait(struct rw_semaphore *sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	dump_rwsem(__FUNCTION__ " in", sem);
+	__add_wait_queue(&sem->readers_wait, &wait);
+	do {
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
+		schedule();
+		spin_lock(&sem->lock);
+	} while (sem->nr_holders < 0 || waitqueue_active(&sem->writers_wait));
+	__remove_wait_queue(&sem->readers_wait, &wait);
+	dump_rwsem(__FUNCTION__ " out", sem);
+}
+EXPORT_SYMBOL_NOVERS(down_read_wait);
+
+/*
+ * This could perhaps be inline, but sched.h includes semaphore.h,
+ * so semaphore.h can't get at the wake_up() macro definition.
+ */
+void rwsem_wake_up(wait_queue_head_t *wq)
+{
+	wake_up(wq);
+}
+EXPORT_SYMBOL_NOVERS(rwsem_wake_up);
+
+#endif	/* ARCH_USES_GENERIC_RWSEM */
--- linux-2.4.3/lib/Makefile	Fri Dec 29 14:07:24 2000
+++ linux-akpm/lib/Makefile	Sun Apr  8 16:16:41 2001
@@ -8,9 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o
+export-objs := cmdline.o rw_semaphore.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o rw_semaphore.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o


--------------364AE251FC3F076C21D042B8--

