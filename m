Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSGVKwy>; Mon, 22 Jul 2002 06:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSGVKwx>; Mon, 22 Jul 2002 06:52:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:24840 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316705AbSGVKwq>; Mon, 22 Jul 2002 06:52:46 -0400
Message-ID: <3D3BE36E.3090001@evision.ag>
Date: Mon, 22 Jul 2002 12:50:22 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 spinlock
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030708030306010605050402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030708030306010605050402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Add missing _raw_write_trylock() definitions for the UP preemption case.

- Replace tons of georgeous macros for the UP preemption case with
static inline  functions. Much nicer to look at and more adequate then
({ xxxx }) in this case.

--------------030708030306010605050402
Content-Type: text/plain;
 name="spinlock-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spinlock-2.5.27.diff"

diff -urN linux-2.5.27/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.27/include/linux/spinlock.h	2002-07-20 21:11:19.000000000 +0200
+++ linux/include/linux/spinlock.h	2002-07-21 22:59:17.000000000 +0200
@@ -37,10 +37,10 @@
 #define write_unlock_irqrestore(lock, flags)	do { write_unlock(lock); local_irq_restore(flags); } while (0)
 #define write_unlock_irq(lock)			do { write_unlock(lock); local_irq_enable();       } while (0)
 #define write_unlock_bh(lock)			do { write_unlock(lock); local_bh_enable();        } while (0)
-#define spin_trylock_bh(lock)			({ int __r; local_bh_disable();\
+#define spin_trylock_bh(lock)			do { int __r; local_bh_disable();\
 						__r = spin_trylock(lock);      \
 						if (!__r) local_bh_enable();   \
-						__r; })
+						__r; } while (0)
 
 /* Must define these before including other files, inline functions need them */
 
@@ -89,6 +89,7 @@
 #define _raw_spin_trylock(lock)	((void)(lock), 1)
 #define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
+#define _raw_write_trylock(lock) ((void)(lock), 1)
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -124,64 +125,97 @@
 
 #define preempt_get_count() (current_thread_info()->preempt_count)
 
-#define preempt_disable() \
-do { \
-	++current_thread_info()->preempt_count; \
-	barrier(); \
-} while (0)
-
-#define preempt_enable_no_resched() \
-do { \
-	--current_thread_info()->preempt_count; \
-	barrier(); \
-} while (0)
-
-#define preempt_enable() \
-do { \
-	--current_thread_info()->preempt_count; \
-	barrier(); \
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
-} while (0)
-
-#define preempt_check_resched() \
-do { \
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
-} while (0)
-
-#define spin_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-} while(0)
-
-#define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-#define spin_unlock(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable(); \
-} while (0)
-
-#define spin_unlock_no_resched(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable_no_resched(); \
-} while (0)
-
-#define read_lock(lock)		({preempt_disable(); _raw_read_lock(lock);})
-#define read_unlock(lock)	({_raw_read_unlock(lock); preempt_enable();})
-#define write_lock(lock)	({preempt_disable(); _raw_write_lock(lock);})
-#define write_unlock(lock)	({_raw_write_unlock(lock); preempt_enable();})
-#define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
+static inline void preempt_disable(void)
+{
+	++current_thread_info()->preempt_count;
+	barrier();
+}
+
+static inline void preempt_enable_no_resched(void)
+{
+	--current_thread_info()->preempt_count;
+	barrier();
+}
+
+static inline void preempt_enable(void)
+{
+	--current_thread_info()->preempt_count;
+	barrier();
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		preempt_schedule();
+}
+
+static inline void preempt_check_resched(void)
+{
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		preempt_schedule();
+}
+
+static inline void spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+
+static inline int spin_trylock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_spin_trylock(lock))
+		return 1;
+	preempt_enable();
+	return 0;
+}
+
+static inline void spin_unlock(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+
+static inline void spin_unlock_no_resched(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable_no_resched();
+}
+
+static inline void read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+
+static inline void read_unlock(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+
+static inline void write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+
+static inline void write_unlock(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+}
+
+static inline int write_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_write_trylock(lock))
+		return 1;
+	preempt_enable();
+	return 0;
+}
 
 #else
 
 #define preempt_get_count()		(0)
 #define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
@@ -195,6 +229,7 @@
 #define write_lock(lock)		_raw_write_lock(lock)
 #define write_unlock(lock)		_raw_write_unlock(lock)
 #define write_trylock(lock)		_raw_write_trylock(lock)
+
 #endif
 
 /* "lock on reference count zero" */

--------------030708030306010605050402--

