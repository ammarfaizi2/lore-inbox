Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSGKBH5>; Wed, 10 Jul 2002 21:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317697AbSGKBH4>; Wed, 10 Jul 2002 21:07:56 -0400
Received: from zok.SGI.COM ([204.94.215.101]:12931 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317695AbSGKBHz>;
	Wed, 10 Jul 2002 21:07:55 -0400
Date: Wed, 10 Jul 2002 18:10:36 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Daniel Phillips <phillips@arcor.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020711011036.GA706772@sgi.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship> <20020710233616.GA696482@sgi.com> <20020711005424.GE1045@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020711005424.GE1045@clusterfs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 06:54:24PM -0600, Andreas Dilger wrote:
> You can use CPP to add in the lock name like:
> 
> #define spin_assert_locked(lock)	if (!spin_is_locked(lock))	\
> 	printk("lock assertion error: %s:%d: " #lock			\
> 	       " should be locked!\n", __FILE__, __LINE__)
> 
> #define spin_assert_unlocked(lock)	if (!spin_is_locked(lock))	\
> 	printk("lock assertion error: %s:%d: " #lock			\
> 	       " should be unlocked!\n", __FILE__, __LINE__)

Oh yeah, I should have done that the first time.  How does this look?

Thanks,
Jesse


diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/fs/inode.c linux-2.5.25-spinassert/fs/inode.c
--- linux-2.5.25/fs/inode.c	Fri Jul  5 16:42:38 2002
+++ linux-2.5.25-spinassert/fs/inode.c	Wed Jul 10 16:30:18 2002
@@ -183,6 +183,8 @@
  */
 void __iget(struct inode * inode)
 {
+	spin_assert_locked(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/include/linux/spinlock.h linux-2.5.25-spinassert/include/linux/spinlock.h
--- linux-2.5.25/include/linux/spinlock.h	Fri Jul  5 16:42:24 2002
+++ linux-2.5.25-spinassert/include/linux/spinlock.h	Wed Jul 10 18:05:13 2002
@@ -118,6 +118,22 @@
 
 #endif /* !SMP */
 
+/*
+ * Simple lock assertions for debugging and documenting where locks need
+ * to be locked/unlocked.
+ */
+#if defined(CONFIG_DEBUG_SPINLOCK) && defined(SMP)
+#define spin_assert_locked(lock)		if (!spin_is_locked(lock)) { \
+	printk("lock assertion failure: %s:%d lock " #lock \
+		"should be locked!\n", __FILE__, __LINE__); }
+#define spin_assert_unlocked(lock)		if (spin_is_locked(lock)) { \
+	printk("lock assertion failure: %s:%d lock " #lock \
+		"should be unlocked!\n", __FILE__, __LINE__); }
+#else
+#define spin_assert_locked(lock)		do { } while(0)
+#define spin_assert_unlocked(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && SMP */
+
 #ifdef CONFIG_PREEMPT
 
 asmlinkage void preempt_schedule(void);
