Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318073AbSGYA1o>; Wed, 24 Jul 2002 20:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSGYA1G>; Wed, 24 Jul 2002 20:27:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24825 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318061AbSGYA0i>; Wed, 24 Jul 2002 20:26:38 -0400
Subject: [PATCH] generalized spin_lock_bit, take two
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 17:29:49 -0700
Message-Id: <1027556989.927.1646.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Linus, 

The attached patch implements bit-sized spinlocks via the following
interfaces:

        spin_lock_bit(int nr, unsigned long * lock)
        spin_unlock_bit(int nr, unsigned long * lock)

to abstract the current VM pte_chain locking and to fix the problem
where the locks are not compiled away on UP.

Per Linus's suggestion, the pte_chain_lock() methods still exist - they
just call the new spin_lock_bit() methods.  In the future we may scrap
the bitwise locking altogether.  The approach in this patch makes things
clean and abstract but keeps future overhaul easy.

Patch is against 2.5.28, please apply.

	Robert Love

diff -urN linux-2.5.28/include/asm-i386/spinlock.h linux/include/asm-i386/spinlock.h
--- linux-2.5.28/include/asm-i386/spinlock.h	Wed Jul 24 14:03:22 2002
+++ linux/include/asm-i386/spinlock.h	Wed Jul 24 15:18:42 2002
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
diff -urN linux-2.5.28/include/linux/page-flags.h linux/include/linux/page-flags.h
--- linux-2.5.28/include/linux/page-flags.h	Wed Jul 24 14:03:21 2002
+++ linux/include/linux/page-flags.h	Wed Jul 24 15:18:42 2002
@@ -230,27 +230,18 @@
 
 /*
  * inlines for acquisition and release of PG_chainlock
+ *
+ * Right now PG_chainlock is implemented as a bit-sized spin_lock
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
diff -urN linux-2.5.28/include/linux/preempt.h linux/include/linux/preempt.h
--- linux-2.5.28/include/linux/preempt.h	Wed Jul 24 14:03:23 2002
+++ linux/include/linux/preempt.h	Wed Jul 24 16:13:57 2002
@@ -37,7 +37,7 @@
 #else
 
 #define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
diff -urN linux-2.5.28/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.28/include/linux/spinlock.h	Wed Jul 24 14:03:28 2002
+++ linux/include/linux/spinlock.h	Wed Jul 24 16:13:21 2002
@@ -43,6 +43,18 @@
 						if (!__r) local_bh_enable();   \
 						__r; })
 
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
 /* Must define these before including other files, inline functions need them */
 
 #include <linux/stringify.h>
@@ -84,12 +96,15 @@
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
@@ -148,6 +163,9 @@
 #define spin_trylock(lock)		_raw_spin_trylock(lock)
 #define spin_unlock(lock)		_raw_spin_unlock(lock)
 
+#define spin_lock_bit(lock, nr)		_raw_spin_lock_bit(nr, lock)
+#define spin_unlock_bit(lock, nr)	_raw_spin_unlock_bit(nr, lock)
+
 #define read_lock(lock)			_raw_read_lock(lock)
 #define read_unlock(lock)		_raw_read_unlock(lock)
 #define write_lock(lock)		_raw_write_lock(lock)

