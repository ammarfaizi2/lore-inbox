Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSG3Wtd>; Tue, 30 Jul 2002 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSG3Wtd>; Tue, 30 Jul 2002 18:49:33 -0400
Received: from zero.tech9.net ([209.61.188.187]:35597 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S316880AbSG3Wt0>;
	Tue, 30 Jul 2002 18:49:26 -0400
Subject: [PATCH] even more spinlock.h cleanup
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207291906160.989-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207291906160.989-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 30 Jul 2002 15:52:36 -0700
Message-Id: <1028069557.1314.117.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 19:10, Linus Torvalds wrote:

> Last comment, then I promise to shut up..

Yah, sure, right...

> How about making those #define spin_lock_xxx() things be fully expanded,
> ie including the preempt disabling?
> [...]
> so that there aren't two levels of #define expansion? Especially since at
> some point we may make the irq versions not do the preempt_disable at all.

Good idea.

This patch, against 2.5 BK, includes the previous cleanups with your
suggestion above sans the compiler workaround.

Changes:

	- cleanup #defines: I do not follow the rationale behind the
	  odd line-wrapped defines at the beginning of the file.  If
	  we have to use multiple lines, then we might as well do so
          cleanly and according to normal practice...

	- Remove a level of indirection: do not have spin_lock_foo
	  use spin_lock - just explicitly call what is needed.

        - we do not need to define the spin_lock functions twice, once
          for CONFIG_PREEMPT and once for !CONFIG_PREEMPT.  Defining
          them once with the preempt macros will optimize away fine.

        - other misc. cleanup, improved comments, reordering, etc.

The net result is we define each method once, with no extra levels of
indirection or conditional statements. The various methods include each
needed piece and those pieces are nops in the case they are not needed.

The patch is probably fairly confusing to look at since I reordered
everything, but I suspect you will like the resulting spinlock.h.  If
so, please apply.

	Robert Love

diff -urN linux-2.5.29-bk/include/linux/preempt.h linux/include/linux/preempt.h
--- linux-2.5.29-bk/include/linux/preempt.h	Mon Jul 29 15:59:01 2002
+++ linux/include/linux/preempt.h	Tue Jul 30 14:52:42 2002
@@ -1,9 +1,14 @@
 #ifndef __LINUX_PREEMPT_H
 #define __LINUX_PREEMPT_H
 
+/*
+ * include/linux/preempt.h - macros for accessing and manipulating
+ * preempt_count (used for kernel preemption, interrupt count, etc.)
+ */
+
 #include <linux/config.h>
 
-#define preempt_count() (current_thread_info()->preempt_count)
+#define preempt_count()	(current_thread_info()->preempt_count)
 
 #ifdef CONFIG_PREEMPT
 
@@ -21,23 +26,22 @@
 	barrier(); \
 } while (0)
 
-#define preempt_enable() \
+#define preempt_check_resched() \
 do { \
-	preempt_enable_no_resched(); \
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
 		preempt_schedule(); \
 } while (0)
 
-#define preempt_check_resched() \
+#define preempt_enable() \
 do { \
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
+	preempt_enable_no_resched(); \
+	preempt_check_resched(); \
 } while (0)
 
 #else
 
 #define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
diff -urN linux-2.5.29-bk/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.29-bk/include/linux/spinlock.h	Mon Jul 29 15:59:01 2002
+++ linux/include/linux/spinlock.h	Tue Jul 30 14:52:36 2002
@@ -1,52 +1,23 @@
 #ifndef __LINUX_SPINLOCK_H
 #define __LINUX_SPINLOCK_H
 
+/*
+ * include/linux/spinlock.h - generic locking declarations
+ */
+
 #include <linux/config.h>
 #include <linux/preempt.h>
 #include <linux/linkage.h>
 #include <linux/compiler.h>
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
+#include <linux/stringify.h>
 
 #include <asm/system.h>
 
 /*
- * These are the generic versions of the spinlocks and read-write
- * locks..
+ * Must define these before including other files, inline functions need them
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
-
-/* Must define these before including other files, inline functions need them */
-
-#include <linux/stringify.h>
-
 #define LOCK_SECTION_NAME			\
 	".text.lock." __stringify(KBUILD_BASENAME)
 
@@ -60,11 +31,17 @@
 #define LOCK_SECTION_END			\
 	".previous\n\t"
 
+/*
+ * If CONFIG_SMP is set, pull in the _raw_* definitions
+ */
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
@@ -72,55 +49,42 @@
 #endif
 
 /*
- * Your basic spinlocks, allowing only a single CPU anywhere
- *
- * Most gcc versions have a nasty bug with empty initializers.
+ * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
 #if (__GNUC__ > 2)
   typedef struct { } spinlock_t;
-# define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+  typedef struct { } rwlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+  #define RW_LOCK_UNLOCKED (rwlock_t) { }
 #else
   typedef struct { int gcc_is_buggy; } spinlock_t;
-# define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+  typedef struct { int gcc_is_buggy; } rwlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 #endif
 
+/*
+ * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
+ */
 #define spin_lock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_spin_lock(lock)	(void)(lock)
 #define spin_is_locked(lock)	((void)(lock), 0)
 #define _raw_spin_trylock(lock)	((void)(lock), 1)
 #define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
-
-/*
- * Read-write spinlocks, allowing multiple readers
- * but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts
- * but no interrupt writers. For those circumstances we
- * can "mix" irq-safe locks - any writer needs to get a
- * irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- *
- * Most gcc versions have a nasty bug with empty initializers.
- */
-#if (__GNUC__ > 2)
-  typedef struct { } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-#endif
-
 #define rwlock_init(lock)	do { } while(0)
-#define _raw_read_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_read_lock(lock)	(void)(lock)
 #define _raw_read_unlock(lock)	do { } while(0)
-#define _raw_write_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_write_lock(lock)	(void)(lock)
 #define _raw_write_unlock(lock)	do { } while(0)
 
 #endif /* !SMP */
 
-#ifdef CONFIG_PREEMPT
-
+/*
+ * Define the various spin_lock and rw_lock methods.  Note we define these
+ * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
+ * methods are defined as nops in the case they are not required.
+ */
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
@@ -129,31 +93,175 @@
 
 #define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
+
 #define spin_unlock(lock) \
 do { \
 	_raw_spin_unlock(lock); \
 	preempt_enable(); \
 } while (0)
 
-#define read_lock(lock)		({preempt_disable(); _raw_read_lock(lock);})
-#define read_unlock(lock)	({_raw_read_unlock(lock); preempt_enable();})
-#define write_lock(lock)	({preempt_disable(); _raw_write_lock(lock);})
-#define write_unlock(lock)	({_raw_write_unlock(lock); preempt_enable();})
+#define read_lock(lock)	\
+do { \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+} while(0)
+
+#define read_unlock(lock) \
+do { \
+	_raw_read_unlock(lock); \
+	preempt_enable(); \
+} while(0)
+
+#define write_lock(lock) \
+do { \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+} while(0)
+
+#define write_unlock(lock) \
+do { \
+	_raw_write_unlock(lock); \
+	preempt_enable(); \
+} while(0)
+
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
-#else
+#define spin_lock_irqsave(lock, flags) \
+do { \
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+} while (0)
 
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
+#define spin_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+} while (0)
+
+#define spin_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+} while (0)
+
+#define read_lock_irqsave(lock, flags) \
+do { \
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+} while (0)
+
+#define read_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+} while (0)
+
+#define read_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+} while (0)
+
+#define write_lock_irqsave(lock, flags) \
+do { \
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+} while (0)
+
+#define write_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+} while (0)
+
+#define write_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+} while (0)
+
+#define spin_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_spin_unlock(lock); \
+	local_irq_restore(flags); \
+	preempt_enable(); \
+} while (0)
+
+#define _raw_spin_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_spin_unlock(lock); \
+	local_irq_restore(flags); \
+} while (0)
+
+#define spin_unlock_irq(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	local_irq_enable(); \
+	preempt_enable(); \
+} while (0)
+
+#define spin_unlock_bh(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	preempt_enable(); \
+	local_bh_enable(); \
+} while (0)
+
+#define read_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_read_unlock(lock); \
+	local_irq_restore(flags); \
+	preempt_enable(); \
+} while (0)
+
+#define read_unlock_irq(lock) \
+do { \
+	_raw_read_unlock(lock); \
+	local_irq_enable(); \
+	preempt_enable(); \
+} while (0)
+
+#define read_unlock_bh(lock) \
+do { \
+	_raw_read_unlock(lock); \
+	preempt_enable(); \
+	local_bh_enable(); \
+} while (0)
+
+#define write_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_write_unlock(lock); \
+	local_irq_restore(flags); \
+	preempt_enable(); \
+} while (0)
+
+#define write_unlock_irq(lock) \
+do { \
+	_raw_write_unlock(lock); \
+	local_irq_enable(); \
+	preempt_enable(); \
+} while (0)
+
+#define write_unlock_bh(lock) \
+do { \
+	_raw_write_unlock(lock); \
+	preempt_enable(); \
+	local_bh_enable(); \
+} while (0)
+
+#define spin_trylock_bh(lock)	({ local_bh_disable(); preempt_disable(); \
+				_raw_spin_trylock(lock) ? 1 : \
+				({preempt_enable(); local_bh_enable(); 0;});})
 
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK

