Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSGYX12>; Thu, 25 Jul 2002 19:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSGYX12>; Thu, 25 Jul 2002 19:27:28 -0400
Received: from zok.SGI.COM ([204.94.215.101]:28309 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316666AbSGYX11>;
	Thu, 25 Jul 2002 19:27:27 -0400
Date: Thu, 25 Jul 2002 16:30:47 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020725233047.GA782991@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the lastest version of the lockassert patch.  It includes:
  o MUST_HOLD for all architectures
  o MUST_HOLD_RW for architectures implementing rwlock_is_locked (only
    ia64 at the moment, as part of this patch)
  o MUST_HOLD_RWSEM for arcitectures that use rwsem-spinlock.h
  o MUST_HOLD_SEM for ia64
  o a call to MUST_HOLD(&inode_lock) in inode.c:__iget().

I'd be happy to take patches that implement the above routines for
other architectures and/or patches that sprinkle the macros where
they're needed.

Thanks,
Jesse


diff -Naur -X /home/jbarnes/dontdiff linux-2.5.28/fs/inode.c linux-2.5.28-lockassert/fs/inode.c
--- linux-2.5.28/fs/inode.c	Wed Jul 24 14:03:32 2002
+++ linux-2.5.28-lockassert/fs/inode.c	Thu Jul 25 16:17:41 2002
@@ -183,6 +183,8 @@
  */
 void __iget(struct inode * inode)
 {
+	MUST_HOLD(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.28/include/asm-ia64/semaphore.h linux-2.5.28-lockassert/include/asm-ia64/semaphore.h
--- linux-2.5.28/include/asm-ia64/semaphore.h	Wed Jul 24 14:03:27 2002
+++ linux-2.5.28-lockassert/include/asm-ia64/semaphore.h	Thu Jul 25 16:19:37 2002
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
+# define MUST_HOLD_SEM(sem)		do { BUG_ON(atomic_read(sem->count)); } while(0);
+#else
+# define MUST_HOLD_SEM(sem)		do { } while(0)
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count)					\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.28/include/asm-ia64/spinlock.h linux-2.5.28-lockassert/include/asm-ia64/spinlock.h
--- linux-2.5.28/include/asm-ia64/spinlock.h	Wed Jul 24 14:03:19 2002
+++ linux-2.5.28-lockassert/include/asm-ia64/spinlock.h	Thu Jul 25 16:17:41 2002
@@ -109,6 +109,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->read_counter != 0 || (x)->write_lock != 0)
 
 #define _raw_read_lock(rw)							\
 do {										\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.28/include/linux/rwsem-spinlock.h linux-2.5.28-lockassert/include/linux/rwsem-spinlock.h
--- linux-2.5.28/include/linux/rwsem-spinlock.h	Wed Jul 24 14:03:29 2002
+++ linux-2.5.28-lockassert/include/linux/rwsem-spinlock.h	Thu Jul 25 16:17:41 2002
@@ -46,6 +46,12 @@
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define MUST_HOLD_RWSEM(sem)		BUG_ON(!sem->activity))
+#else
+#define MUST_HOLD_RWSEM(sem)		do { } while (0)
+#endif
+
 #define __RWSEM_INITIALIZER(name) \
 { 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.28/include/linux/rwsem.h linux-2.5.28-lockassert/include/linux/rwsem.h
--- linux-2.5.28/include/linux/rwsem.h	Wed Jul 24 14:03:24 2002
+++ linux-2.5.28-lockassert/include/linux/rwsem.h	Thu Jul 25 16:17:41 2002
@@ -7,6 +7,7 @@
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 
 #define RWSEM_DEBUG 0
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.28/include/linux/spinlock.h linux-2.5.28-lockassert/include/linux/spinlock.h
--- linux-2.5.28/include/linux/spinlock.h	Wed Jul 24 14:03:28 2002
+++ linux-2.5.28-lockassert/include/linux/spinlock.h	Thu Jul 25 16:17:41 2002
@@ -117,7 +117,19 @@
 #define _raw_write_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define _raw_write_unlock(lock)	do { } while(0)
 
-#endif /* !SMP */
+#endif /* !CONFIG_SMP */
+
+/*
+ * Simple lock assertions for debugging and documenting where locks need
+ * to be locked/unlocked.
+ */
+#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
+#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
+#define MUST_HOLD_RW(lock)		BUG_ON(!rwlock_is_locked(lock))
+#else
+#define MUST_HOLD(lock)			do { } while(0)
+#define MUST_HOLD_RW(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
