Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHGUsa>; Wed, 7 Aug 2002 16:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSHGUs2>; Wed, 7 Aug 2002 16:48:28 -0400
Received: from zok.SGI.COM ([204.94.215.101]:29093 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S311749AbSHGUsH>;
	Wed, 7 Aug 2002 16:48:07 -0400
Date: Wed, 7 Aug 2002 13:51:34 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
Subject: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020807205134.GA27013@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, jmacd@namesys.com,
	phillips@arcor.de, rml@tech9.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the latest revision of the lock assertion macros patch.  I've
converted over the ASSERT_LOCK stuff in the scsi layer and added a few
other MUST_HOLD_* assertions elsewhere.

Joshua, do you think this will work for the reiserfs stuff you were
talking about?  If not, let me know what else I should add.

Please check it out and let me know if you think it's ready for 2.5
inclusion, or maybe it should be part of your spinlock.h cleanup,
Robert?

Thanks,
Jesse

diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/drivers/scsi/aha152x.c linux-2.5.30-lockassert/drivers/scsi/aha152x.c
--- linux-2.5.30/drivers/scsi/aha152x.c	Thu Aug  1 14:16:04 2002
+++ linux-2.5.30-lockassert/drivers/scsi/aha152x.c	Wed Aug  7 11:33:38 2002
@@ -1435,7 +1435,7 @@
  */ 
 static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 {
-	ASSERT_LOCK(&QLOCK,1);
+	MUST_HOLD(&QLOCK);
 
 	if(CURRENT_SC) {
 		CURRENT_SC->SCp.phase |= 1 << 16;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/drivers/scsi/scsi.c linux-2.5.30-lockassert/drivers/scsi/scsi.c
--- linux-2.5.30/drivers/scsi/scsi.c	Thu Aug  1 14:16:26 2002
+++ linux-2.5.30-lockassert/drivers/scsi/scsi.c	Wed Aug  7 11:35:32 2002
@@ -262,7 +262,7 @@
         struct request_queue *q = &SCpnt->device->request_queue;
         unsigned long flags;
 
-        ASSERT_LOCK(q->queue_lock, 0);
+        MUST_NOT_HOLD(q->queue_lock);
 	req->rq_status = RQ_SCSI_DONE;	/* Busy, but indicate request done */
 
         spin_lock_irqsave(q->queue_lock, flags);
@@ -669,7 +669,7 @@
 
 	host = SCpnt->host;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 	/* Assign a unique nonzero serial_number. */
 	if (++serial_number == 0)
@@ -827,7 +827,7 @@
 	Scsi_Device * SDpnt = SRpnt->sr_device;
 	struct Scsi_Host *host = SDpnt->host;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 	SCSI_LOG_MLQUEUE(4,
 			 {
@@ -924,7 +924,7 @@
 {
 	struct Scsi_Host *host = SCpnt->host;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 	SCpnt->owner = SCSI_OWNER_MIDLEVEL;
 	SRpnt->sr_command = SCpnt;
@@ -1013,7 +1013,7 @@
 {
 	struct Scsi_Host *host = SCpnt->host;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 	SCpnt->pid = scsi_pid++;
 	SCpnt->owner = SCSI_OWNER_MIDLEVEL;
@@ -1339,7 +1339,7 @@
 	host = SCpnt->host;
 	device = SCpnt->device;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
         /*
          * We need to protect the decrement, as otherwise a race condition
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/drivers/scsi/scsi.h linux-2.5.30-lockassert/drivers/scsi/scsi.h
--- linux-2.5.30/drivers/scsi/scsi.h	Thu Aug  1 14:16:15 2002
+++ linux-2.5.30-lockassert/drivers/scsi/scsi.h	Wed Aug  7 11:32:25 2002
@@ -99,21 +99,6 @@
 #endif
 
 /*
- * Used for debugging the new queueing code.  We want to make sure
- * that the lock state is consistent with design.  Only do this in
- * the user space simulator.
- */
-#define ASSERT_LOCK(_LOCK, _COUNT)
-
-#if defined(CONFIG_SMP) && defined(CONFIG_USER_DEBUG)
-#undef ASSERT_LOCK
-#define ASSERT_LOCK(_LOCK,_COUNT)       \
-        { if( (_LOCK)->lock != _COUNT )   \
-                panic("Lock count inconsistent %s %d\n", __FILE__, __LINE__); \
-                                                                                       }
-#endif
-
-/*
  *  Use these to separate status msg and our bytes
  *
  *  These are set by:
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/drivers/scsi/scsi_error.c linux-2.5.30-lockassert/drivers/scsi/scsi_error.c
--- linux-2.5.30/drivers/scsi/scsi_error.c	Thu Aug  1 14:16:02 2002
+++ linux-2.5.30-lockassert/drivers/scsi/scsi_error.c	Wed Aug  7 11:33:08 2002
@@ -581,7 +581,7 @@
 	unsigned long flags;
 	struct Scsi_Host *host = SCpnt->host;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 retry:
 	/*
@@ -1251,7 +1251,7 @@
 	Scsi_Device *SDpnt;
 	unsigned long flags;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 	/*
 	 * Next free up anything directly waiting upon the host.  This will be
@@ -1328,7 +1328,7 @@
 	Scsi_Cmnd *SCdone;
 	int timed_out;
 
-	ASSERT_LOCK(host->host_lock, 0);
+	MUST_NOT_HOLD(host->host_lock);
 
 	SCdone = NULL;
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/drivers/scsi/scsi_lib.c linux-2.5.30-lockassert/drivers/scsi/scsi_lib.c
--- linux-2.5.30/drivers/scsi/scsi_lib.c	Thu Aug  1 14:16:26 2002
+++ linux-2.5.30-lockassert/drivers/scsi/scsi_lib.c	Wed Aug  7 11:34:39 2002
@@ -202,7 +202,7 @@
 	Scsi_Device *SDpnt;
 	struct Scsi_Host *SHpnt;
 
-	ASSERT_LOCK(q->queue_lock, 0);
+	MUST_NOT_HOLD(q->queue_lock);
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (SCpnt != NULL) {
@@ -315,7 +315,7 @@
 	struct request *req = SCpnt->request;
 	unsigned long flags;
 
-	ASSERT_LOCK(q->queue_lock, 0);
+	MUST_NOT_HOLD(q->queue_lock);
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	/*
@@ -402,7 +402,7 @@
 {
 	struct request *req = SCpnt->request;
 
-	ASSERT_LOCK(SCpnt->host->host_lock, 0);
+	MUST_NOT_HOLD(SCpnt->host->host_lock);
 
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
@@ -465,7 +465,7 @@
 	 *	would be used if we just wanted to retry, for example.
 	 *
 	 */
-	ASSERT_LOCK(q->queue_lock, 0);
+	MUST_NOT_HOLD(q->queue_lock);
 
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
@@ -733,7 +733,7 @@
 	struct Scsi_Host *SHpnt;
 	struct Scsi_Device_Template *STpnt;
 
-	ASSERT_LOCK(q->queue_lock, 1);
+	MUST_HOLD(q->queue_lock);
 
 	SDpnt = (Scsi_Device *) q->queuedata;
 	if (!SDpnt) {
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/fs/inode.c linux-2.5.30-lockassert/fs/inode.c
--- linux-2.5.30/fs/inode.c	Thu Aug  1 14:16:45 2002
+++ linux-2.5.30-lockassert/fs/inode.c	Wed Aug  7 11:10:48 2002
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
+++ linux-2.5.30-lockassert/include/asm-i386/semaphore.h	Wed Aug  7 13:39:00 2002
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
+++ linux-2.5.30-lockassert/include/asm-i386/spinlock.h	Wed Aug  7 11:14:49 2002
@@ -157,6 +157,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/asm-ia64/semaphore.h linux-2.5.30-lockassert/include/asm-ia64/semaphore.h
--- linux-2.5.30/include/asm-ia64/semaphore.h	Thu Aug  1 14:16:24 2002
+++ linux-2.5.30-lockassert/include/asm-ia64/semaphore.h	Wed Aug  7 13:41:14 2002
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
+++ linux-2.5.30-lockassert/include/asm-ia64/spinlock.h	Wed Aug  7 11:10:48 2002
@@ -109,6 +109,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->read_counter != 0 || (x)->write_lock != 0)
 
 #define _raw_read_lock(rw)							\
 do {										\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/linux/rwsem-spinlock.h linux-2.5.30-lockassert/include/linux/rwsem-spinlock.h
--- linux-2.5.30/include/linux/rwsem-spinlock.h	Thu Aug  1 14:16:28 2002
+++ linux-2.5.30-lockassert/include/linux/rwsem-spinlock.h	Wed Aug  7 13:42:03 2002
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
+++ linux-2.5.30-lockassert/include/linux/rwsem.h	Wed Aug  7 11:10:48 2002
@@ -7,6 +7,7 @@
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
+#include <linux/config.h>
 #include <linux/linkage.h>
 
 #define RWSEM_DEBUG 0
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/include/linux/spinlock.h linux-2.5.30-lockassert/include/linux/spinlock.h
--- linux-2.5.30/include/linux/spinlock.h	Thu Aug  1 14:16:25 2002
+++ linux-2.5.30-lockassert/include/linux/spinlock.h	Wed Aug  7 11:31:45 2002
@@ -117,7 +117,21 @@
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
+#define MUST_NOT_HOLD(lock)		BUG_ON(spin_is_locked(lock))
+#define MUST_HOLD_RW(lock)		BUG_ON(!rwlock_is_locked(lock))
+#else
+#define MUST_HOLD(lock)			do { } while(0)
+#define MUST_NOT_HOLD(lock)		do { } while(0)
+#define MUST_HOLD_RW(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.30/kernel/acct.c linux-2.5.30-lockassert/kernel/acct.c
--- linux-2.5.30/kernel/acct.c	Thu Aug  1 14:16:27 2002
+++ linux-2.5.30-lockassert/kernel/acct.c	Wed Aug  7 11:47:14 2002
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
+++ linux-2.5.30-lockassert/kernel/printk.c	Wed Aug  7 11:46:22 2002
@@ -337,6 +337,8 @@
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
+	MUST_HOLD_SEM(&console_sem);
+
 	if (((long)(start - end)) > 0)
 		BUG();
 
