Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317531AbSGTVRX>; Sat, 20 Jul 2002 17:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSGTVRX>; Sat, 20 Jul 2002 17:17:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24311 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317531AbSGTVRL>; Sat, 20 Jul 2002 17:17:11 -0400
Subject: Re: [PATCH] generalized spin_lock_bit
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@conectiva.com.br,
       wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.44.0207201335560.1492-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207201335560.1492-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 14:20:16 -0700
Message-Id: <1027200016.1086.800.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 13:40, Linus Torvalds wrote:

> I'm not entirely convinced.
>
> Some architectures simply aren't good at doing bitwise locking, and we may
> have to change the current "pte_chain_lock()" to a different
> implementation.

My assumption was similar - that the bit locking may be inefficient on
other architectures - so I put the spin_lock_bit code in per-arch
headers.

In other words, I assumed we may need to make some changes but to
bit-locking in general and not rip out the whole design.

> So I would suggest (at least for now) to _not_ get rid of the
> pte_chain_lock() abstraction, and re-doing your patch with that in mind.
> Gettign rid of the (unnecessary) UP locking is good, but getting rid of
> the abstraction doesn't look like a wonderful idea to me.

OK.  Attached patch still implements spin_lock_bit in the same manner,
but keeps the pte_chain_lock() abstraction.

If we decide to how we do the locking it will be easy - and for now we
get the cleaner interface and no more UP locking.

Look good?

	Robert Love

diff -urN linux-2.5.27/include/asm-i386/spinlock.h linux/include/asm-i386/spinlock.h
--- linux-2.5.27/include/asm-i386/spinlock.h	Sat Jul 20 12:11:11 2002
+++ linux/include/asm-i386/spinlock.h	Sat Jul 20 14:08:32 2002
@@ -128,6 +128,30 @@
 		:"=m" (lock->lock) : : "memory");
 }
 
+/*
+ * Bit-sized spinlocks.  Introduced by the VM code to fit locks
+ * where no lock has gone before.
+ */
+static inline void _raw_spin_lock_bit(int nr, unsigned long * lock)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	while (test_and_set_bit(nr, lock)) {
+		while (test_bit(nr, lock))
+			cpu_relax();
+	}
+}
+
+static inline void _raw_spin_unlock_bit(int nr, unsigned long * lock)
+{
+	clear_bit(nr, lock);
+}
+
 
 /*
  * Read-write spinlocks, allowing multiple readers
diff -urN linux-2.5.27/include/linux/page-flags.h linux/include/linux/page-flags.h
--- linux-2.5.27/include/linux/page-flags.h	Sat Jul 20 12:11:09 2002
+++ linux/include/linux/page-flags.h	Sat Jul 20 14:10:37 2002
@@ -230,27 +230,18 @@
 
 /*
  * inlines for acquisition and release of PG_chainlock
+ *
+ * Right now PG_chainlock is implemented as a bitwise spin_lock
+ * using the general spin_lock_bit interface.  That may change.
  */
 static inline void pte_chain_lock(struct page *page)
 {
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
+	spin_lock_bit(PG_chainlock, &page->flags);
 }
 
 static inline void pte_chain_unlock(struct page *page)
 {
-	clear_bit(PG_chainlock, &page->flags);
-	preempt_enable();
+	spin_unlock_bit(PG_chainlock, &page->flags);
 }
 
 /*
diff -urN linux-2.5.27/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.27/include/linux/spinlock.h	Sat Jul 20 12:11:19 2002
+++ linux/include/linux/spinlock.h	Sat Jul 20 14:08:32 2002
@@ -83,12 +83,15 @@
 # define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 #endif
 
-#define spin_lock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_lock(lock)	(void)(lock) /* Not "unused variable". */
-#define spin_is_locked(lock)	((void)(lock), 0)
-#define _raw_spin_trylock(lock)	((void)(lock), 1)
-#define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
+#define spin_lock_init(lock)		do { (void)(lock); } while(0)
+#define _raw_spin_lock(lock)		(void)(lock) /* no "unused variable" */
+#define spin_is_locked(lock)		((void)(lock), 0)
+#define _raw_spin_trylock(lock)		((void)(lock), 1)
+#define spin_unlock_wait(lock)		do { (void)(lock); } while(0)
+#define _raw_spin_unlock(lock)		do { (void)(lock); } while(0)
+
+#define _raw_spin_lock_bit(nr, lock)	do { (void)(lock); } while(0)
+#define _raw_spin_unlock_bit(nr, lock)	do { (void)(lock); } while(0)
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -177,11 +180,23 @@
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
+#define spin_lock_bit(nr, lock) \
+do { \
+	preempt_disable(); \
+	_raw_spin_lock_bit(nr, lock); \
+} while(0)
+
+#define spin_unlock_bit(nr, lock) \
+do { \
+	_raw_spin_unlock_bit(nr, lock); \
+	preempt_enable(); \
+} while(0)
+
 #else
 
 #define preempt_get_count()		(0)
 #define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable_no_resched()	do { } while(0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
@@ -190,6 +205,9 @@
 #define spin_unlock(lock)		_raw_spin_unlock(lock)
 #define spin_unlock_no_resched(lock)	_raw_spin_unlock(lock)
 
+#define spin_lock_bit(lock, nr)		_raw_spin_lock_bit(nr, lock)
+#define spin_unlock_bit(lock, nr)	_raw_spin_unlock_bit(nr, lock)
+
 #define read_lock(lock)			_raw_read_lock(lock)
 #define read_unlock(lock)		_raw_read_unlock(lock)
 #define write_lock(lock)		_raw_write_lock(lock)

