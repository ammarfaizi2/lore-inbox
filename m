Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSHHRUE>; Thu, 8 Aug 2002 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSHHRUE>; Thu, 8 Aug 2002 13:20:04 -0400
Received: from rj.SGI.COM ([192.82.208.96]:11237 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317673AbSHHRUC>;
	Thu, 8 Aug 2002 13:20:02 -0400
Date: Thu, 8 Aug 2002 10:23:35 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, jmacd@namesys.com, phillips@arcor.de,
       rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808172335.GA29509@sgi.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org, jmacd@namesys.com, phillips@arcor.de,
	rml@tech9.net
References: <20020807221532.GA20469@sgi.com> <Pine.LNX.4.44L.0208071918440.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208071918440.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 07:19:21PM -0300, Rik van Riel wrote:
> Looks good to me. Would be even better if you removed MUST_NOT_HOLD ;)

Ok, here's yet another version.  I've removed the conversion of the
scsi layer's ASSERT_LOCK macros as well as the silly version of
MUST_NOT_HOLD.  Other things people seem interested in:
  o sleeping function assertions
  o lock ordering enforcement
  o lock recursion detection
  o more assertion checks in other parts of the kernel

Should any of the above be included in this patch?  If so, I can try
to hack one or more of them together, otherwise maybe this is ok to go
in?

Thanks,
Jesse


diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/fs/inode.c linux-2.5.30-lockassert/fs/inode.c
--- linux-2.5.30/fs/inode.c	Thu Aug  1 14:16:45 2002
+++ linux-2.5.30-lockassert/fs/inode.c	Thu Aug  8 10:03:13 2002
@@ -193,6 +193,8 @@
  */
 void __iget(struct inode * inode)
 {
+	MUST_HOLD(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/asm-i386/semaphore.h linux-2.5.30-lockassert/include/asm-i386/semaphore.h
--- linux-2.5.30/include/asm-i386/semaphore.h	Thu Aug  1 14:16:16 2002
+++ linux-2.5.30-lockassert/include/asm-i386/semaphore.h	Thu Aug  8 10:03:13 2002
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
+# define MUST_HOLD_SEM(sem)		do { BUG_ON(atomic_read(&((sem)->count))); } while(0)
+#else
+# define MUST_HOLD_SEM(sem)		do { } while(0)
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count) \
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/asm-i386/spinlock.h linux-2.5.30-lockassert/include/asm-i386/spinlock.h
--- linux-2.5.30/include/asm-i386/spinlock.h	Thu Aug  1 14:16:14 2002
+++ linux-2.5.30-lockassert/include/asm-i386/spinlock.h	Thu Aug  8 10:03:13 2002
@@ -157,6 +157,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/asm-ia64/semaphore.h linux-2.5.30-lockassert/include/asm-ia64/semaphore.h
--- linux-2.5.30/include/asm-ia64/semaphore.h	Thu Aug  1 14:16:24 2002
+++ linux-2.5.30-lockassert/include/asm-ia64/semaphore.h	Thu Aug  8 10:03:13 2002
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
+# define MUST_HOLD_SEM(sem)		do { BUG_ON(atomic_read(&((sem)->count)); } while(0)
+#else
+# define MUST_HOLD_SEM(sem)		do { } while(0)
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count)					\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/asm-ia64/spinlock.h linux-2.5.30-lockassert/include/asm-ia64/spinlock.h
--- linux-2.5.30/include/asm-ia64/spinlock.h	Thu Aug  1 14:16:06 2002
+++ linux-2.5.30-lockassert/include/asm-ia64/spinlock.h	Thu Aug  8 10:03:13 2002
@@ -109,6 +109,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->read_counter != 0 || (x)->write_lock != 0)
 
 #define _raw_read_lock(rw)							\
 do {										\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/linux/rwsem-spinlock.h linux-2.5.30-lockassert/include/linux/rwsem-spinlock.h
--- linux-2.5.30/include/linux/rwsem-spinlock.h	Thu Aug  1 14:16:28 2002
+++ linux-2.5.30-lockassert/include/linux/rwsem-spinlock.h	Thu Aug  8 10:03:13 2002
@@ -46,6 +46,12 @@
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define MUST_HOLD_RWSEM(sem)		BUG_ON(!(sem)->activity))
+#else
+#define MUST_HOLD_RWSEM(sem)		do { } while (0)
+#endif
+
 #define __RWSEM_INITIALIZER(name) \
 { 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/linux/rwsem.h linux-2.5.30-lockassert/include/linux/rwsem.h
--- linux-2.5.30/include/linux/rwsem.h	Thu Aug  1 14:16:18 2002
+++ linux-2.5.30-lockassert/include/linux/rwsem.h	Thu Aug  8 10:03:13 2002
@@ -7,6 +7,7 @@
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 
 #define RWSEM_DEBUG 0
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/linux/spinlock.h linux-2.5.30-lockassert/include/linux/spinlock.h
--- linux-2.5.30/include/linux/spinlock.h	Thu Aug  1 14:16:25 2002
+++ linux-2.5.30-lockassert/include/linux/spinlock.h	Thu Aug  8 10:04:23 2002
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
+#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
+#define MUST_HOLD_RW(lock)		BUG_ON(!rwlock_is_locked(lock))
+#else
+#define MUST_HOLD(lock)			do { } while(0)
+#define MUST_HOLD_RW(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/kernel/acct.c linux-2.5.30-lockassert/kernel/acct.c
--- linux-2.5.30/kernel/acct.c	Thu Aug  1 14:16:27 2002
+++ linux-2.5.30-lockassert/kernel/acct.c	Thu Aug  8 10:03:13 2002
@@ -160,6 +160,8 @@
 {
 	struct file *old_acct = NULL;
 
+	MUST_HOLD(&acct_globals.lock);
+
 	if (acct_globals.file) {
 		old_acct = acct_globals.file;
 		del_timer(&acct_globals.timer);
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/kernel/printk.c linux-2.5.30-lockassert/kernel/printk.c
--- linux-2.5.30/kernel/printk.c	Thu Aug  1 14:16:25 2002
+++ linux-2.5.30-lockassert/kernel/printk.c	Thu Aug  8 10:03:13 2002
@@ -337,6 +337,8 @@
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
+	MUST_HOLD_SEM(&console_sem);
+
 	if (((long)(start - end)) > 0)
 		BUG();
 
