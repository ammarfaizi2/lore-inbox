Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSG3BCx>; Mon, 29 Jul 2002 21:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSG3BCx>; Mon, 29 Jul 2002 21:02:53 -0400
Received: from zero.tech9.net ([209.61.188.187]:16394 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S317536AbSG3BCu>;
	Mon, 29 Jul 2002 21:02:50 -0400
Subject: Re: [PATCH] spinlock.h cleanup
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027989220.1016.273.camel@sinai>
References: <Pine.LNX.4.33.0207291725580.1722-100000@penguin.transmeta.com>
	<1027989053.929.263.camel@sinai>  <1027989220.1016.273.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 29 Jul 2002 18:06:11 -0700
Message-Id: <1027991172.1617.351.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 17:33, Robert Love wrote:

> To better answer your question, I just checked and indeed it seems all
> gcc's >= 2.95 are OK.

I was informed by Andrew Morton that he uses egcs... normally I would
prefer to abandon an old compiler, but Andrew is an immediate exception
in my book :)

I do not know if egcs 1.1.2 has the bug or not.  For Andrew's sake, and
architectures that still recommend egcs-1.1.2, attached is a version of
the patch that keeps the compiler workaround.

We can either merge the original and see who screams or merge this
now... either is fine with me.  If the former, I will be prepared to
send of a patch to restore the workaround.

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

