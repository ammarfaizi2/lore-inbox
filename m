Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSHUSW1>; Wed, 21 Aug 2002 14:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSHUSW1>; Wed, 21 Aug 2002 14:22:27 -0400
Received: from zok.SGI.COM ([204.94.215.101]:52165 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318601AbSHUSWY>;
	Wed, 21 Aug 2002 14:22:24 -0400
Date: Wed, 21 Aug 2002 11:26:28 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.31
Message-ID: <20020821182627.GA62297@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>, phillips@arcor.de,
	linux-kernel@vger.kernel.org
References: <20020808172335.GA29509@sgi.com> <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva> <20020808173933.GA29474@sgi.com> <E17czxG-0000e8-00@starship> <20020812210336.GA40112@sgi.com> <3D5829B9.D281B855@zip.com.au> <20020812223645.GB40343@sgi.com> <3D5840E9.89C8680C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5840E9.89C8680C@zip.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 04:12:41PM -0700, Andrew Morton wrote:
> ...
> #define might_sleep()	BUG_ON(preempt_count())
> 
> _this_ would catch numerous bugs, including code which is not buggy
> in 2.4, but became buggy when wild-eyed loonies changed core kernel
> rules without even looking at what drivers were doing (rant).
> 
> I expect something like this will fall out of the wash soon, at
> least for preemptible kernels.

Is it really that simple?  Maybe it should go into sched.h sometime
soon?  I guess the real work is sprinkling it in all the places where
it needs to go.

Anyway, here's an updated version of the lock assertion patch.  Should
it be split into two patches, one that implements the macros and
another that puts checks everywhere?  Should I add a small doc to
Documentation/ (maybe the might_sleep() could be documented there
too)?

Thanks,
Jesse


diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/fs/inode.c linux-2.5.31-lockassert/fs/inode.c
--- linux-2.5.31/fs/inode.c	Sat Aug 10 18:42:05 2002
+++ linux-2.5.31-lockassert/fs/inode.c	Wed Aug 21 11:14:49 2002
@@ -193,6 +193,8 @@
  */
 void __iget(struct inode * inode)
 {
+	assert_locked(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/asm-i386/semaphore.h linux-2.5.31-lockassert/include/asm-i386/semaphore.h
--- linux-2.5.31/include/asm-i386/semaphore.h	Sat Aug 10 18:41:24 2002
+++ linux-2.5.31-lockassert/include/asm-i386/semaphore.h	Wed Aug 21 11:13:11 2002
@@ -40,6 +40,7 @@
 #include <asm/atomic.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/config.h>
 
 struct semaphore {
 	atomic_t count;
@@ -55,6 +56,12 @@
 		, (int)&(name).__magic
 #else
 # define __SEM_DEBUG_INIT(name)
+#endif
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define assert_sem_held(sem)		BUG_ON(!down_trylock(sem))
+#else
+# define assert_sem_held(sem)		do { } while(0)
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count) \
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/asm-i386/spinlock.h linux-2.5.31-lockassert/include/asm-i386/spinlock.h
--- linux-2.5.31/include/asm-i386/spinlock.h	Sat Aug 10 18:41:23 2002
+++ linux-2.5.31-lockassert/include/asm-i386/spinlock.h	Wed Aug 21 11:05:41 2002
@@ -157,6 +157,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/asm-ia64/semaphore.h linux-2.5.31-lockassert/include/asm-ia64/semaphore.h
--- linux-2.5.31/include/asm-ia64/semaphore.h	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-lockassert/include/asm-ia64/semaphore.h	Wed Aug 21 11:13:28 2002
@@ -6,6 +6,7 @@
  * Copyright (C) 1998-2000 David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
+#include <linux/config.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
@@ -24,6 +25,12 @@
 # define __SEM_DEBUG_INIT(name)		, (long) &(name).__magic
 #else
 # define __SEM_DEBUG_INIT(name)
+#endif
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define assert_sem_held(sem)		BUG_ON(!down_trylock(sem))
+#else
+# define assert_sem_held(sem)		do { } while(0)
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count)					\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/asm-ia64/spinlock.h linux-2.5.31-lockassert/include/asm-ia64/spinlock.h
--- linux-2.5.31/include/asm-ia64/spinlock.h	Sat Aug 10 18:41:19 2002
+++ linux-2.5.31-lockassert/include/asm-ia64/spinlock.h	Wed Aug 21 11:05:41 2002
@@ -109,6 +109,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->read_counter != 0 || (x)->write_lock != 0)
 
 #define _raw_read_lock(rw)							\
 do {										\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/linux/rwsem-spinlock.h linux-2.5.31-lockassert/include/linux/rwsem-spinlock.h
--- linux-2.5.31/include/linux/rwsem-spinlock.h	Sat Aug 10 18:41:38 2002
+++ linux-2.5.31-lockassert/include/linux/rwsem-spinlock.h	Wed Aug 21 11:12:43 2002
@@ -46,6 +46,14 @@
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define assert_rwsem_held_for_write(rwsem)	BUG_ON(__down_read_trylock(sem))
+#define assert_rwsem_held_for_read(rwsem)	BUG_ON(__down_write_trylock(rwsem))
+#else
+#define assert_rwsem_held_for_write(rwsem)	do { } while(0)
+#define assert_rwsem_held_for_read(rwsem)	do { } while(0)
+#endif
+
 #define __RWSEM_INITIALIZER(name) \
 { 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/linux/rwsem.h linux-2.5.31-lockassert/include/linux/rwsem.h
--- linux-2.5.31/include/linux/rwsem.h	Sat Aug 10 18:41:25 2002
+++ linux-2.5.31-lockassert/include/linux/rwsem.h	Wed Aug 21 11:05:41 2002
@@ -7,6 +7,7 @@
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 
 #define RWSEM_DEBUG 0
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/include/linux/spinlock.h linux-2.5.31-lockassert/include/linux/spinlock.h
--- linux-2.5.31/include/linux/spinlock.h	Sat Aug 10 18:41:29 2002
+++ linux-2.5.31-lockassert/include/linux/spinlock.h	Wed Aug 21 11:19:35 2002
@@ -117,7 +117,19 @@
 #define _raw_write_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define _raw_write_unlock(lock)	do { } while(0)
 
-#endif /* !SMP */
+#endif /* !CONFIG_SMP */
+
+/*
+ * Simple lock assertions for debugging and documenting where locks need
+ * to be held.
+ */
+#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
+#define assert_locked(lock)		BUG_ON(!spin_is_locked(lock))
+#define assert_rw_locked(lock)		BUG_ON(!rwlock_is_locked(lock))
+#else
+#define assert_locked(lock)		do { } while(0)
+#define assert_rw_locked(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/kernel/acct.c linux-2.5.31-lockassert/kernel/acct.c
--- linux-2.5.31/kernel/acct.c	Sat Aug 10 18:41:36 2002
+++ linux-2.5.31-lockassert/kernel/acct.c	Wed Aug 21 11:15:03 2002
@@ -160,6 +160,8 @@
 {
 	struct file *old_acct = NULL;
 
+	assert_locked(&acct_globals.lock);
+
 	if (acct_globals.file) {
 		old_acct = acct_globals.file;
 		del_timer(&acct_globals.timer);
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.31/kernel/printk.c linux-2.5.31-lockassert/kernel/printk.c
--- linux-2.5.31/kernel/printk.c	Sat Aug 10 18:41:29 2002
+++ linux-2.5.31-lockassert/kernel/printk.c	Wed Aug 21 11:15:18 2002
@@ -337,6 +337,8 @@
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
+	assert_sem_held(&console_sem);
+
 	if (((long)(start - end)) > 0)
 		BUG();
 
