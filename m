Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318193AbSGQCUT>; Tue, 16 Jul 2002 22:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318195AbSGQCUS>; Tue, 16 Jul 2002 22:20:18 -0400
Received: from rj.sgi.com ([192.82.208.96]:54727 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S318193AbSGQCUR>;
	Tue, 16 Jul 2002 22:20:17 -0400
Date: Tue, 16 Jul 2002 19:22:13 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: spinlock assertion macros
Message-ID: <20020717022213.GA734386@sgi.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17Szx2-0002es-00@starship> <200207121724.g6CHOU8100100@d12relay01.de.ibm.com> <E17T4Qj-0002fN-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17T4Qj-0002fN-00@starship>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 07:42:09PM +0200, Daniel Phillips wrote:
> So far, only the MUST_HOLD style of executable locking documentation has 
> really survived scrutiny.  It needs some variants: MUST_HOLD_READ, 
> MUST_HOLD_WRITE, MUST_HOLD_SEM, MUST_HOLD_READ_SEM and MUST_HOLD_WRITE_SEM, 
> or names to that effect.

I'm not quite sure where to put the semaphore versions of the MUST_*
macros, I guess they'd have to go in each of the arch-specific header
files?  Anyway, I've got spinlock and rwlock versions of them below,
maybe they're useful enough to go in as a start?  I only coded the
ia64 version of rwlock_is_*_locked since it was easy--the i386
versions were a little intimidating...

I thought Oliver's suggestion for tracking the order of spinlock
acquisition was good, hopefully someone will take a stab at it along
with Dave's FUNCTION_SLEEPS() implementation.

Jesse


diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/fs/inode.c linux-2.5.25-spinassert/fs/inode.c
--- linux-2.5.25/fs/inode.c	Fri Jul  5 16:42:38 2002
+++ linux-2.5.25-spinassert/fs/inode.c	Tue Jul 16 19:04:01 2002
@@ -183,6 +183,8 @@
  */
 void __iget(struct inode * inode)
 {
+	MUST_HOLD_SPIN(&inode_lock);
+
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/include/asm-ia64/spinlock.h linux-2.5.25-spinassert/include/asm-ia64/spinlock.h
--- linux-2.5.25/include/asm-ia64/spinlock.h	Fri Jul  5 16:42:03 2002
+++ linux-2.5.25-spinassert/include/asm-ia64/spinlock.h	Tue Jul 16 18:31:53 2002
@@ -109,6 +109,8 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_read_locked(x) ((x)->read_counter != 0 || (x)->write_lock != 0)
+#define rwlock_is_write_locked(x) ((x)->write_lock != 0)
 
 #define _raw_read_lock(rw)							\
 do {										\
diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/include/linux/spinlock.h linux-2.5.25-spinassert/include/linux/spinlock.h
--- linux-2.5.25/include/linux/spinlock.h	Fri Jul  5 16:42:24 2002
+++ linux-2.5.25-spinassert/include/linux/spinlock.h	Tue Jul 16 18:58:40 2002
@@ -116,7 +116,21 @@
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
+#define MUST_HOLD_SPIN(lock)		BUG_ON(!spin_is_locked(lock))
+#define MUST_HOLD_READ(lock)		BUG_ON(!rwlock_is_read_locked(lock))
+#define MUST_HOLD_WRITE(lock)		BUG_ON(!rwlock_is_write_locked(lock))
+#else
+#define MUST_HOLD_SPIN(lock)		do { } while(0)
+#define MUST_HOLD_READ(lock)		do { } while(0)
+#define MUST_HOLD_WRITE(lock)		do { } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 
