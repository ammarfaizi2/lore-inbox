Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284722AbRLDAML>; Mon, 3 Dec 2001 19:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284714AbRLDAHO>; Mon, 3 Dec 2001 19:07:14 -0500
Received: from colorfullife.com ([216.156.138.34]:3852 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285088AbRLCULF>;
	Mon, 3 Dec 2001 15:11:05 -0500
Message-ID: <3C0BDC33.6E18C815@colorfullife.com>
Date: Mon, 03 Dec 2001 21:10:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] improve spinlock debugging
Content-Type: multipart/mixed;
 boundary="------------02AC15205F5591BC8C4BE0CE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------02AC15205F5591BC8C4BE0CE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

CONFIG_DEBUG_SPINLOCK only adds spinlock tests for SMP builds. The
attached patch adds runtime checks for uniprocessor builds.

Tested on i386/UP, but it should work on all platforms. It contains
runtime checks for:

- missing initialization
- recursive lock
- double unlock
- incorrect use of spin_is_locked() or spin_trylock() [both function
do not work as expected on uniprocessor builds]
The next step are checks for spinlock ordering mismatches.

Which other runtime checks are possible?
Tests for correct _irq usage are not possible, several drivers use
disable_irq().

--
	Manfred
--------------02AC15205F5591BC8C4BE0CE
Content-Type: text/plain; charset=us-ascii;
 name="patch-debug-sp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-debug-sp"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 1
//  EXTRAVERSION =-pre5
--- 2.5/include/linux/spinlock.h	Fri Oct 26 17:03:12 2001
+++ build-2.5/include/linux/spinlock.h	Mon Dec  3 19:45:58 2001
@@ -37,12 +37,13 @@
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
+#else
 
-#elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
-                                  defined (e.g. by including asm/spinlock.h */
-
-#define DEBUG_SPINLOCKS	0	/* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
-
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define DEBUG_SPINLOCKS	2	/* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
+#else
+#define DEBUG_SPINLOCKS	0
+#endif
 #if (DEBUG_SPINLOCKS < 1)
 
 #define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
@@ -85,22 +86,101 @@
 
 #else /* (DEBUG_SPINLOCKS >= 2) */
 
+#define SPINLOCK_MAGIC	0x1D244B3C
 typedef struct {
+	unsigned long magic;
 	volatile unsigned long lock;
 	volatile unsigned int babble;
 	const char *module;
+	char *owner;
+	int oline;
 } spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 25, __BASE_FILE__ }
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
 
 #include <linux/kernel.h>
 
-#define spin_lock_init(x)	do { (x)->lock = 0; } while (0)
-#define spin_is_locked(lock)	(test_bit(0,(lock)))
-#define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
-
-#define spin_lock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_lock(%s:%p) already locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 1; restore_flags(__spinflags);} while (0)
-#define spin_unlock_wait(x)	do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock_wait(%s:%p) deadlock\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} restore_flags(__spinflags);} while (0)
-#define spin_unlock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if (!(x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock(%s:%p) not locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 0; restore_flags(__spinflags);} while (0)
+#define spin_lock_init(x) \
+	do { \
+		(x)->magic = SPINLOCK_MAGIC; \
+		(x)->lock = 0; \
+		(x)->babble = 5; \
+		(x)->module = __FILE__; \
+		(x)->owner = NULL; \
+		(x)->oline = 0; \
+	} while (0)
+#define CHECK_LOCK(x) \
+	do { \
+	 	if ((x)->magic != SPINLOCK_MAGIC) { \
+			printk(KERN_ERR "%s:%d: spin_is_locked on uninitialized spinlock %p.\n", \
+					__FILE__, __LINE__, (x)); \
+		} \
+	} while(0)
+/* without debugging, spin_is_locked on UP always says
+ * FALSE. --> printk if already locked. */
+#define spin_is_locked(x) \
+	({ \
+	 	CHECK_LOCK(x); \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n", \
+					__FILE__,__LINE__, (x)->module, \
+					(x), (x)->owner, (x)->oline); \
+			(x)->babble--; \
+		} \
+		0; \
+	})
+
+/* without debugging, spin_trylock on UP always says
+ * TRUE. --> printk if already locked. */
+#define spin_trylock(x) \
+	({ \
+	 	CHECK_LOCK(x); \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n", \
+					__FILE__,__LINE__, (x)->module, \
+					(x), (x)->owner, (x)->oline); \
+			(x)->babble--; \
+		} \
+		(x)->lock = 1; \
+		(x)->owner = __FILE__; \
+		(x)->oline = __LINE__; \
+		1; \
+	})
+
+#define spin_lock(x)		\
+	do { \
+	 	CHECK_LOCK(x); \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n", \
+					__FILE__,__LINE__, (x)->module, \
+					(x), (x)->owner, (x)->oline); \
+			(x)->babble--; \
+		} \
+		(x)->lock = 1; \
+		(x)->owner = __FILE__; \
+		(x)->oline = __LINE__; \
+	} while (0)
+
+#define spin_unlock_wait(x)	\
+	do { \
+	 	CHECK_LOCK(x); \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n", \
+					__FILE__,__LINE__, (x)->module, (x), \
+					(x)->owner, (x)->oline); \
+			(x)->babble--; \
+		}\
+	} while (0)
+
+#define spin_unlock(x) \
+	do { \
+	 	CHECK_LOCK(x); \
+		if (!(x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
+					__FILE__,__LINE__, (x)->module, (x));\
+			(x)->babble--; \
+		} \
+		(x)->lock = 0; \
+	} while (0)
 
 #endif	/* DEBUG_SPINLOCKS */
 
--- 2.5/kernel/ksyms.c	Mon Dec  3 18:30:08 2001
+++ build-2.5/kernel/ksyms.c	Mon Dec  3 20:06:49 2001
@@ -381,10 +381,10 @@
 EXPORT_SYMBOL(tq_timer);
 EXPORT_SYMBOL(tq_immediate);
 
-#ifdef CONFIG_SMP
 /* Various random spinlocks we want to export */
 EXPORT_SYMBOL(tqueue_lock);
 
+#ifdef CONFIG_SMP
 /* Big-Reader lock implementation */
 EXPORT_SYMBOL(__brlock_array);
 #ifndef __BRLOCK_USE_ATOMICS
--- 2.5/Documentation/Configure.help	Mon Dec  3 18:30:07 2001
+++ build-2.5/Documentation/Configure.help	Mon Dec  3 20:31:40 2001
@@ -23565,8 +23565,10 @@
 
 Spinlock debugging
 CONFIG_DEBUG_SPINLOCK
-  Say Y here and build SMP to catch missing spinlock initialization
-  and certain other kinds of spinlock errors commonly made.  This is
+  Say Y here to add additional runtime checks into the spinlock
+  functions. On UP it detects missing initializations and simple
+  deadlocks. On SMP it finds missing initializations and certain other
+  kinds of spinlock errors commonly made, excluding deadlocks. This is
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
 



--------------02AC15205F5591BC8C4BE0CE--


