Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTA3AkH>; Wed, 29 Jan 2003 19:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTA3AkG>; Wed, 29 Jan 2003 19:40:06 -0500
Received: from users.ccur.com ([208.248.32.211]:7300 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S266795AbTA3AkB>;
	Wed, 29 Jan 2003 19:40:01 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301300049.AAA25370@rudolph.ccur.com>
Subject: [PATCH] preemptive spin readlocks for 2.5
To: akpm@digeo.com (Andrew Morton)
Date: Wed, 29 Jan 2003 19:49:11 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
 This patch adds read_lock() to the list of lock services that drop
preemption while spinning.

This patch is against 2.5.59, so it re-applies the spinlock repair
work already in your trees but not yet pushed to Linus.

A 2.4 version of this patch has been running here on several test
stands for nearly a week.  The 2.5 version has been boot-tested.

Regards,
Joe

PS: I also have 2.4 versions of irq lock services that drop the irq
while spinning.  These have been running here since Monday.  I can
do a 2.5 port if you are interested in taking a look at them.


diff -ur 2.5.59-orig/include/asm-i386/atomic.h 2.5.59-rdlcks/include/asm-i386/atomic.h
--- 2.5.59-orig/include/asm-i386/atomic.h	2003-01-22 06:02:30.000000000 -0500
+++ 2.5.59-rdlcks/include/asm-i386/atomic.h	2003-01-29 08:51:31.000000000 -0500
@@ -146,6 +146,25 @@
 }
 
 /**
+ * atomic_dec_positive - decrement and test if positive
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1 and returns true if the
+ * result is greater than zero.  Note that the guaranteed
+ * useful range of an atomic_t is only 24 bits.
+ */ 
+static __inline__ int atomic_dec_positive(atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "decl %0; setg %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c !=0;
+}
+
+/**
  * atomic_inc_and_test - increment and test 
  * @v: pointer of type atomic_t
  * 
diff -ur 2.5.59-orig/include/asm-i386/spinlock.h 2.5.59-rdlcks/include/asm-i386/spinlock.h
--- 2.5.59-orig/include/asm-i386/spinlock.h	2003-01-22 06:02:29.000000000 -0500
+++ 2.5.59-rdlcks/include/asm-i386/spinlock.h	2003-01-29 18:03:21.000000000 -0500
@@ -159,6 +159,7 @@
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
+#define rwlock_is_wrlocked(x) ((x)->lock <= 0)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
@@ -201,4 +202,13 @@
 	return 0;
 }
 
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+	atomic_t *count = (atomic_t *)lock;
+	if (atomic_dec_positive(count))
+		return 1;
+	atomic_inc(count);
+	return 0;
+}
+
 #endif /* __ASM_SPINLOCK_H */
diff -ur 2.5.59-orig/include/linux/spinlock.h 2.5.59-rdlcks/include/linux/spinlock.h
--- 2.5.59-orig/include/linux/spinlock.h	2003-01-22 06:02:37.000000000 -0500
+++ 2.5.59-rdlcks/include/linux/spinlock.h	2003-01-29 18:04:28.000000000 -0500
@@ -91,11 +91,13 @@
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
-/* Where's read_trylock? */
+#define read_trylock(lock)	({preempt_disable();_raw_read_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
 void __preempt_spin_lock(spinlock_t *lock);
 void __preempt_write_lock(rwlock_t *lock);
+void __preempt_read_lock(rwlock_t *lock);
 
 #define spin_lock(lock) \
 do { \
@@ -111,6 +113,13 @@
 		__preempt_write_lock(lock); \
 } while (0)
 
+#define read_lock(lock) \
+do { \
+	preempt_disable(); \
+	if (unlikely(!_raw_read_trylock(lock))) \
+		__preempt_read_lock(lock); \
+} while (0)
+
 #else
 #define spin_lock(lock)	\
 do { \
@@ -123,13 +132,13 @@
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while(0)
-#endif
 
 #define read_lock(lock)	\
 do { \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while(0)
+#endif
 
 #define spin_unlock(lock) \
 do { \
diff -ur 2.5.59-orig/kernel/ksyms.c 2.5.59-rdlcks/kernel/ksyms.c
--- 2.5.59-orig/kernel/ksyms.c	2003-01-22 06:02:16.000000000 -0500
+++ 2.5.59-rdlcks/kernel/ksyms.c	2003-01-28 17:22:03.000000000 -0500
@@ -496,6 +496,7 @@
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
 EXPORT_SYMBOL(__preempt_spin_lock);
 EXPORT_SYMBOL(__preempt_write_lock);
+EXPORT_SYMBOL(__preempt_read_lock);
 #endif
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
diff -ur 2.5.59-orig/kernel/sched.c 2.5.59-rdlcks/kernel/sched.c
--- 2.5.59-orig/kernel/sched.c	2003-01-22 06:02:55.000000000 -0500
+++ 2.5.59-rdlcks/kernel/sched.c	2003-01-29 18:04:59.000000000 -0500
@@ -2465,15 +2465,13 @@
 		_raw_spin_lock(lock);
 		return;
 	}
-
-	while (!_raw_spin_trylock(lock)) {
-		if (need_resched()) {
-			preempt_enable_no_resched();
-			__cond_resched();
-			preempt_disable();
+	do {
+		preempt_enable();
+		while(spin_is_locked(lock)) {
+			cpu_relax();
 		}
-		cpu_relax();
-	}
+		preempt_disable();
+	} while (!_raw_spin_trylock(lock));
 }
 
 void __preempt_write_lock(rwlock_t *lock)
@@ -2482,14 +2480,27 @@
 		_raw_write_lock(lock);
 		return;
 	}
-
-	while (!_raw_write_trylock(lock)) {
-		if (need_resched()) {
-			preempt_enable_no_resched();
-			__cond_resched();
-			preempt_disable();
+	do {
+		preempt_enable();
+		while(rwlock_is_locked(lock)) {
+			cpu_relax();
 		}
-		cpu_relax();
+		preempt_disable();
+	} while (!_raw_write_trylock(lock));
+}
+
+void __preempt_read_lock(rwlock_t *lock)
+{
+	if (preempt_count() > 1) {
+		_raw_read_lock(lock);
+		return;
 	}
+	do {
+		preempt_enable();
+		while(rwlock_is_wrlocked(lock)) {
+			cpu_relax();
+		}
+		preempt_disable();
+	} while (!_raw_read_trylock(lock));
 }
 #endif
