Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317677AbSGJXdq>; Wed, 10 Jul 2002 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317678AbSGJXdp>; Wed, 10 Jul 2002 19:33:45 -0400
Received: from rj.SGI.COM ([192.82.208.96]:49364 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317677AbSGJXdo>;
	Wed, 10 Jul 2002 19:33:44 -0400
Date: Wed, 10 Jul 2002 16:36:16 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020710233616.GA696482@sgi.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SPsV-00028p-00@starship>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 12:24:06AM +0200, Daniel Phillips wrote:
> Acme, which is to replace all those above-the-function lock coverage
> comments with assert-like thingies:
> 
>    spin_assert(&pagemap_lru_lock);
> 
> And everbody knows what that does: when compiled with no spinlock
> debugging it does nothing, but with spinlock debugging enabled, it oopses
> unless pagemap_lru_lock is held at that point in the code.  The practical
> effect of this is that lots of 3 line comments get replaced with a
> one line assert that actually does something useful.  That is, besides
> documenting the lock coverage, this thing will actually check to see if
> you're telling the truth, if you ask it to.
> 
> Oh, and they will stay up to date much better than the comments do,
> because nobody needs to to be an ueber-hacker to turn on the option and
> post any resulting oopses to lkml.

Sounds like a great idea to me.  Were you thinking of something along
the lines of what I have below or perhaps something more
sophisticated?  I suppose it would be helpful to have the name of the
lock in addition to the file and line number...

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
+++ linux-2.5.25-spinassert/include/linux/spinlock.h	Wed Jul 10 16:20:06 2002
@@ -118,6 +118,18 @@
 
 #endif /* !SMP */
 
+/*
+ * Simple lock assertions for debugging and documenting where locks need
+ * to be locked/unlocked.
+ */
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define spin_assert_locked(lock)		if (!spin_is_locked(lock)) { printk("lock assertion failure: lock at %s:%d should be locked!\n", __FILE__, __LINE__); }
+#define spin_assert_unlocked(lock)		if (spin_is_locked(lock)) { printk("lock assertion failure: lock at %s:%d should be unlocked!\n", __FILE__, __LINE__); }
+#else
+#define spin_assert_locked(lock)		do { } while(0)
+#define spin_assert_unlocked(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
 #ifdef CONFIG_PREEMPT
 
 asmlinkage void preempt_schedule(void);
