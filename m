Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317808AbSGKSAo>; Thu, 11 Jul 2002 14:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSGKSAn>; Thu, 11 Jul 2002 14:00:43 -0400
Received: from rj.SGI.COM ([192.82.208.96]:16056 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317808AbSGKSAl>;
	Thu, 11 Jul 2002 14:00:41 -0400
Date: Thu, 11 Jul 2002 11:03:26 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020711180326.GH709072@sgi.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship> <20020710233616.GA696482@sgi.com> <E17SWXm-0002BL-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SWXm-0002BL-00@starship>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 07:31:09AM +0200, Daniel Phillips wrote:
> I was thinking of something as simple as:
> 
>    #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))
> 
> but in truth I'd be happy regardless of the internal implementation.  A note
> on names: Linus likes to shout the names of his BUG macros.  I've never been
> one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
> asserts.  I bet he'd like it more spelled like this though:
> 
>    MUST_HOLD(&lock);

I like lowercase better too, but you're right that Linus likes to
shout...

> And, dare I say it, what I'd *really* like to happen when the thing triggers
> is to get dropped into kdb.  Ah well, perhaps in a parallel universe...

As long as you've got kdb patched in, this _should_ happen on BUG().

How about this?  Are there simple *_is_locked() calls for the other
mutex mechanisms?  If so, I could add those too...

Thanks,
Jesse


diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/fs/inode.c linux-2.5.25-spinassert/fs/inode.c
--- linux-2.5.25/fs/inode.c	Fri Jul  5 16:42:38 2002
+++ linux-2.5.25-spinassert/fs/inode.c	Thu Jul 11 10:59:23 2002
@@ -183,6 +183,8 @@
  */
 void __iget(struct inode * inode)
 {
+	MUST_HOLD(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/include/linux/spinlock.h linux-2.5.25-spinassert/include/linux/spinlock.h
--- linux-2.5.25/include/linux/spinlock.h	Fri Jul  5 16:42:24 2002
+++ linux-2.5.25-spinassert/include/linux/spinlock.h	Thu Jul 11 11:02:17 2002
@@ -116,7 +116,19 @@
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
+#define MUST_HOLD(lock)		BUG_ON(!spin_is_locked(lock))
+#define MUST_NOT_HOLD(lock)	BUG_ON(spin_is_locked(lock))
+#else
+#define MUST_HOLD(lock)		do { } while(0)
+#define MUST_NOT_HOLD(lock)	do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
