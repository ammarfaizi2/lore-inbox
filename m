Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSG2X6N>; Mon, 29 Jul 2002 19:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSG2X6N>; Mon, 29 Jul 2002 19:58:13 -0400
Received: from zero.tech9.net ([209.61.188.187]:3082 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313743AbSG2X6K>;
	Mon, 29 Jul 2002 19:58:10 -0400
Subject: [PATCH] spinlock.h cleanup
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 29 Jul 2002 17:01:30 -0700
Message-Id: <1027987291.1016.221.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Ingo's IRQ rewrite cleaned up include/linux/spinlock.h a bit but it
still resembles a dying albatross.  Some of the defines are redundant,
the coding style used by the remaining defines is likely drug induced,
and there are a couple other issues...

	- cleanup #defines: I do not follow the rationale behind the odd
	  line-wrapped defines at the beginning of the file.  If we have 	  to
use multiple lines, then we might as well do so cleanly and
	  according to normal practice...

	- we do not need to define the spin_lock functions twice, once
	  for CONFIG_PREEMPT and once for !CONFIG_PREEMPT.  Defining
	  them once with the preempt macros will optimize away fine.

	- remove the egcs compiler workarounds: we do not need them

	- other misc. minor cleanup, improved comments, et cetera

Tested on UP, SMP, and preempt.  Object code is unchanged.  Patch is
against 2.5-bk but should apply to 2.5.29.  Please, apply.

	Robert Love

diff -urN linux-2.5.29-bk/include/linux/preempt.h linux/include/linux/preempt.h
--- linux-2.5.29-bk/include/linux/preempt.h	Mon Jul 29 15:59:01 2002
+++ linux/include/linux/preempt.h	Mon Jul 29 16:34:12 2002
@@ -1,6 +1,11 @@
 #ifndef __LINUX_PREEMPT_H
 #define __LINUX_PREEMPT_H
 
+/*
+ * include/linux/preempt.h - macros for accessing and manipulating
+ * preempt_count (used for kernel preemption, interrupt count, etc.)
+ */
+
 #include <linux/config.h>
 
 #define preempt_count() (current_thread_info()->preempt_count)
@@ -37,7 +42,7 @@
 #else
 
 #define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
diff -urN linux-2.5.29-bk/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.29-bk/include/linux/spinlock.h	Mon Jul 29 15:59:01 2002
+++ linux/include/linux/spinlock.h	Mon Jul 29 16:34:33 2002
@@ -11,39 +11,80 @@
 #include <asm/system.h>
 
 /*
- * These are the generic versions of the spinlocks and read-write
- * locks..
+ * These are the generic versions of the spinlocks and read-write locks..
  */
-#define spin_lock_irqsave(lock, flags)		do { local_irq_save(flags);       spin_lock(lock); } while (0)
-#define spin_lock_irq(lock)			do { local_irq_disable();         spin_lock(lock); } while (0)
-#define spin_lock_bh(lock)			do { local_bh_disable();          spin_lock(lock); } while (0)
-
-#define read_lock_irqsave(lock, flags)		do { local_irq_save(flags);       read_lock(lock); } while (0)
-#define read_lock_irq(lock)			do { local_irq_disable();         read_lock(lock); } while (0)
-#define read_lock_bh(lock)			do { local_bh_disable();          read_lock(lock); } while (0)
-
-#define write_lock_irqsave(lock, flags)		do { local_irq_save(flags);      write_lock(lock); } while (0)
-#define write_lock_irq(lock)			do { local_irq_disable();        write_lock(lock); } while (0)
-#define write_lock_bh(lock)			do { local_bh_disable();         write_lock(lock); } while (0)
-
-#define spin_unlock_irqrestore(lock, flags)	do { _raw_spin_unlock(lock);  local_irq_restore(flags); preempt_enable(); } while (0)
-#define _raw_spin_unlock_irqrestore(lock, flags) do { _raw_spin_unlock(lock);  local_irq_restore(flags); } while (0)
-#define spin_unlock_irq(lock)			do { _raw_spin_unlock(lock);  local_irq_enable(); preempt_enable();       } while (0)
-#define spin_unlock_bh(lock)			do { spin_unlock(lock); local_bh_enable(); } while (0)
-
-#define read_unlock_irqrestore(lock, flags)	do { _raw_read_unlock(lock);  local_irq_restore(flags); preempt_enable(); } while (0)
-#define read_unlock_irq(lock)			do { _raw_read_unlock(lock);  local_irq_enable(); preempt_enable(); } while (0)
-#define read_unlock_bh(lock)			do { read_unlock(lock);  local_bh_enable();        } while (0)
-
-#define write_unlock_irqrestore(lock, flags)	do { _raw_write_unlock(lock); local_irq_restore(flags); preempt_enable(); } while (0)
-#define write_unlock_irq(lock)			do { _raw_write_unlock(lock); local_irq_enable(); preempt_enable();       } while (0)
-#define write_unlock_bh(lock)			do { write_unlock(lock); local_bh_enable();        } while (0)
-#define spin_trylock_bh(lock)			({ int __r; local_bh_disable();\
-						__r = spin_trylock(lock);      \
-						if (!__r) local_bh_enable();   \
-						__r; })
+#define spin_lock_irqsave(lock, flags) \
+	do { local_irq_save(flags); spin_lock(lock); } while (0)
 
-/* Must define these before including other files, inline functions need them */
+#define spin_lock_irq(lock) \
+	do { local_irq_disable(); spin_lock(lock); } while (0)
+
+#define spin_lock_bh(lock) \
+	do { local_bh_disable(); spin_lock(lock); } while (0)
+
+#define read_lock_irqsave(lock, flags) \
+	do { local_irq_save(flags); read_lock(lock); } while (0)
+
+#define read_lock_irq(lock) \
+	do { local_irq_disable(); read_lock(lock); } while (0)
+
+#define read_lock_bh(lock) \
+	do { local_bh_disable(); read_lock(lock); } while (0)
+
+#define write_lock_irqsave(lock, flags) \
+	do { local_irq_save(flags); write_lock(lock); } while (0)
+
+#define write_lock_irq(lock) \
+	do { local_irq_disable(); write_lock(lock); } while (0)
+
+#define write_lock_bh(lock) \
+	do { local_bh_disable(); write_lock(lock); } while (0)
+
+#define spin_unlock_irqrestore(lock, flags) do { \
+	_raw_spin_unlock(lock); local_irq_restore(flags); preempt_enable(); \
+} while (0)
+
+#define _raw_spin_unlock_irqrestore(lock, flags) \
+	do { _raw_spin_unlock(lock); local_irq_restore(flags); } while (0)
+
+#define spin_unlock_irq(lock) do { \
+	_raw_spin_unlock(lock);  local_irq_enable(); preempt_enable(); \
+} while (0)
+
+#define spin_unlock_bh(lock) \
+	do { spin_unlock(lock); local_bh_enable(); } while (0)
+
+#define read_unlock_irqrestore(lock, flags) do {\
+	_raw_read_unlock(lock); local_irq_restore(flags); preempt_enable(); \
+} while (0)
+
+#define read_unlock_irq(lock) do { \
+	_raw_read_unlock(lock); local_irq_enable(); preempt_enable(); \
+} while (0)
+
+#define read_unlock_bh(lock) do { \
+	read_unlock(lock); local_bh_enable(); \
+} while (0)
+
+#define write_unlock_irqrestore(lock, flags) do { \
+	_raw_write_unlock(lock); local_irq_restore(flags); preempt_enable(); \
+} while (0)
+
+#define write_unlock_irq(lock) do { \
+	_raw_write_unlock(lock); local_irq_enable(); preempt_enable(); \
+} while (0)
+
+#define write_unlock_bh(lock) \
+	do { write_unlock(lock); local_bh_enable(); } while (0)
+
+#define spin_trylock_bh(lock)	({ int __r; local_bh_disable();\
+				__r = spin_trylock(lock);      \
+				if (!__r) local_bh_enable();   \
+				__r; })
+
+/*
+ * Must define these before including other files, inline functions need them
+ */
 
 #include <linux/stringify.h>
 
@@ -63,8 +104,11 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
-#elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
-                                  defined (e.g. by including asm/spinlock.h */
+/*
+ * !CONFIG_SMP and spin_lock_init not previously defined
+ * (e.g. by including include/asm/spinlock.h)
+ */
+#elif !defined(spin_lock_init)
 
 #ifndef CONFIG_PREEMPT
 # define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
@@ -73,16 +117,9 @@
 
 /*
  * Your basic spinlocks, allowing only a single CPU anywhere
- *
- * Most gcc versions have a nasty bug with empty initializers.
  */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
+typedef struct { } spinlock_t;
 # define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-# define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#endif
 
 #define spin_lock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_lock(lock)	(void)(lock) /* Not "unused variable". */
@@ -100,16 +137,9 @@
  * can "mix" irq-safe locks - any writer needs to get a
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
- *
- * Most gcc versions have a nasty bug with empty initializers.
  */
-#if (__GNUC__ > 2)
-  typedef struct { } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-#endif
+typedef struct { } rwlock_t;
+#define RW_LOCK_UNLOCKED (rwlock_t) { }
 
 #define rwlock_init(lock)	do { } while(0)
 #define _raw_read_lock(lock)	(void)(lock) /* Not "unused variable". */
@@ -119,8 +149,6 @@
 
 #endif /* !SMP */
 
-#ifdef CONFIG_PREEMPT
-
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
@@ -129,6 +157,7 @@
 
 #define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
+
 #define spin_unlock(lock) \
 do { \
 	_raw_spin_unlock(lock); \
@@ -142,19 +171,6 @@
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
-#else
-
-#define spin_lock(lock)			_raw_spin_lock(lock)
-#define spin_trylock(lock)		_raw_spin_trylock(lock)
-#define spin_unlock(lock)		_raw_spin_unlock(lock)
-
-#define read_lock(lock)			_raw_read_lock(lock)
-#define read_unlock(lock)		_raw_read_unlock(lock)
-#define write_lock(lock)		_raw_write_lock(lock)
-#define write_unlock(lock)		_raw_write_unlock(lock)
-#define write_trylock(lock)		_raw_write_trylock(lock)
-#endif
-
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>

