Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSGRXdT>; Thu, 18 Jul 2002 19:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318364AbSGRXdT>; Thu, 18 Jul 2002 19:33:19 -0400
Received: from zok.SGI.COM ([204.94.215.101]:9863 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318357AbSGRXdS>;
	Thu, 18 Jul 2002 19:33:18 -0400
Date: Thu, 18 Jul 2002 16:36:13 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH] spinlock assertion macros for 2.5.26
Message-ID: <20020718233613.GC763939@sgi.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17T4Qj-0002fN-00@starship> <20020717022213.GA734386@sgi.com> <E17UiO0-0004Jn-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17UiO0-0004Jn-00@starship>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 08:34:05AM +0200, Daniel Phillips wrote:
> You could create linux/semaphore.h which includes asm/semaphore.h, making
> the whole arrangement more similar to spinlocks.  That would be the manly
> thing to do, however, manliness not necessarily being the fashion at the
> moment, putting them in the arch-specific headers seems like the route of
> least resistance.  One day, a prince on a white horse will come along and
> clean up all the header files...

Well, I'll at least take a stab at it, but I won't have time until
next week.  Here's the current version of the macros against 2.5.26
though, in case someone wants to add support for architectures other
than ia64.

> > I thought Oliver's suggestion for tracking the order of spinlock
> > acquisition was good, hopefully someone will take a stab at it along
> > with Dave's FUNCTION_SLEEPS() implementation.

It doesn't look like it would be too hard to do, but seems like it
should be a seperate patch (maybe with more header file tweaking).

> On the minor niggle side, I think "MUST_HOLD" scans better than
> "MUST_HOLD_SPIN", since the former is closer to the way we say it when
> we're talking amongst ourselves.

Sure thing.  I fixed it up in this version.

Thanks,
Jesse

diff -Naur -X /home/jbarnes/dontdiff linux-2.5.26/fs/inode.c linux-2.5.26-lockassert/fs/inode.c
--- linux-2.5.26/fs/inode.c	Tue Jul 16 16:49:38 2002
+++ linux-2.5.26-lockassert/fs/inode.c	Thu Jul 18 10:21:13 2002
@@ -183,6 +183,8 @@
  */
 void __iget(struct inode * inode)
 {
+	MUST_HOLD(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.26/include/asm-ia64/spinlock.h linux-2.5.26-lockassert/include/asm-ia64/spinlock.h
--- linux-2.5.26/include/asm-ia64/spinlock.h	Tue Jul 16 16:49:25 2002
+++ linux-2.5.26-lockassert/include/asm-ia64/spinlock.h	Thu Jul 18 16:30:49 2002
@@ -109,6 +109,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x) ((x)->read_counter != 0 || (x)->write_lock != 0)
 
 #define _raw_read_lock(rw)							\
 do {										\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.26/include/linux/spinlock.h linux-2.5.26-lockassert/include/linux/spinlock.h
--- linux-2.5.26/include/linux/spinlock.h	Tue Jul 16 16:49:33 2002
+++ linux-2.5.26-lockassert/include/linux/spinlock.h	Thu Jul 18 16:31:13 2002
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
+#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
+#define MUST_HOLD_RW(lock)		BUG_ON(!rwlock_is_locked(lock))
+#else
+#define MUST_HOLD(lock)			do { } while(0)
+#define MUST_HOLD_RW(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
