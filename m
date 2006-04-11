Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWDKQgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWDKQgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDKQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:36:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751324AbWDKQga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:36:30 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use atomic ops for file_nr accounting, not spinlock+irq
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 11 Apr 2006 17:36:15 +0100
Message-ID: <16476.1144773375@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make the kernel use atomic operations for files_stat.nr_files accounting
rather than using a spinlocked and interrupt-disabled critical section.  This
should improve reduce the latency of the critical section.

This patch is slightly problematic for a couple of reasons:

 (1) The sysctl code then implicitly casts the atomic value to an int, which
     I'm not sure is permissible.

 (2) linux/fs.h only includes asm/atomic.h if __KERNEL__ is defined, but the
     files_stat_struct is declared whether or not __KERNEL__ is defined.  To
     deal with this I've made the type of the nr_files member change to int if
     necessary.

     However, I'm not sure there's any need to present files_stat_struct to
     non-kernel code.

Additionally, I'm not sure that doing the accounting in the slab constructor
and destructor is a good idea: if ENFILE is returned, and then a whole bunch
of files are freed up thus permitting the next open to theoretically avoid
ENFILE, what's to say that the slab has actually recycled all those objects?

Under some conditions the destructors will only be invoked when the actual
slab pages are released, in which case the ENFILE condition won't necessarily
cease to be reported, even if it has actually gone away.

Consider where the files_cache has more than one object per slab, and after an
ENFILE condition a whole bunch of files are released, such as to leave all the
slab pages still allocated, with one struct file allocated in each...


Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/file-nr.diff
 fs/file_table.c    |   25 +++++++++----------------
 include/linux/fs.h |    8 +++++++-
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 1008050..67b0084 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -22,7 +22,8 @@
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
-	.max_files = NR_FILE
+	.max_files	= NR_FILE,
+	.nr_files	= ATOMIC_INIT(0),
 };
 
 EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
@@ -33,26 +34,18 @@ EXPORT_SYMBOL(files_stat); /* Needed by 
 static DEFINE_SPINLOCK(filp_count_lock);
 
 /* slab constructors and destructors are called from arbitrary
- * context and must be fully threaded - use a local spinlock
- * to protect files_stat.nr_files
+ * context and must be fully threaded
  */
 void filp_ctor(void *objp, struct kmem_cache *cachep, unsigned long cflags)
 {
 	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
-	}
+	    SLAB_CTOR_CONSTRUCTOR)
+		atomic_inc(&files_stat.nr_files);
 }
 
 void filp_dtor(void *objp, struct kmem_cache *cachep, unsigned long dflags)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
+	atomic_dec(&files_stat.nr_files);
 }
 
 static inline void file_free_rcu(struct rcu_head *head)
@@ -78,7 +71,7 @@ struct file *get_empty_filp(void)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (files_stat.nr_files >= files_stat.max_files &&
+	if (atomic_read(&files_stat.nr_files) >= files_stat.max_files &&
 				!capable(CAP_SYS_ADMIN))
 		goto over;
 
@@ -101,10 +94,10 @@ struct file *get_empty_filp(void)
 
 over:
 	/* Ran out of filps - report that */
-	if (files_stat.nr_files > old_max) {
+	if (atomic_read(&files_stat.nr_files) > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
 					files_stat.max_files);
-		old_max = files_stat.nr_files;
+		old_max = atomic_read(&files_stat.nr_files);
 	}
 	goto fail;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cc9ecc0..533fd18 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -9,6 +9,9 @@
 #include <linux/config.h>
 #include <linux/limits.h>
 #include <linux/ioctl.h>
+#ifdef __KERNEL__
+#include <asm/atomic.h>
+#endif
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -30,7 +33,11 @@
 
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
+#ifdef __KERNEL__
+	atomic_t nr_files;	/* read only */
+#else
 	int nr_files;		/* read only */
+#endif
 	int nr_free_files;	/* read only */
 	int max_files;		/* tunable */
 };
@@ -218,7 +225,6 @@ extern int dir_notify_enable;
 #include <linux/sched.h>
 #include <linux/mutex.h>
 
-#include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
