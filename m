Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273615AbRI3PRO>; Sun, 30 Sep 2001 11:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRI3PRF>; Sun, 30 Sep 2001 11:17:05 -0400
Received: from colorfullife.com ([216.156.138.34]:31243 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273615AbRI3PQ4>;
	Sun, 30 Sep 2001 11:16:56 -0400
Date: Sun, 30 Sep 2001 11:17:30 -0400
From: Manfred Spraul <manfred@colorfullife.com>
Message-Id: <200109301517.f8UFHUr17030@colorfullife.com>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] UP spinlock debugging
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the attached patch adds support for spinlock debugging with uniprocessor
kernels:

* new config option CONFIG_DEBUG_SPINLOCK_UP
* CONFIG_DEBUG_SPINLOCK only works on SMP, SMP added to config string
* support for directly including <asm/spinlock.h> removed from
		<linux/spinlock.h>
	Doesn't work anyway, probably the '!defined(spin_lock_init)'
	was overlooked.
* DEBUG_SPINLOCKS==2 macros indented
* spin_lock saves the current owner into the spinlock structure,
	file name+line printed on deadlock.
* stricter spin_trylock and spin_is_locked.

Patch against 2.4.10, tested with 2.4.10 i386

Could you apply it to the next -pre kernel?

--
	Manfred
<<<<<<<<<<<<<<
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 10
//  EXTRAVERSION =
--- 2.4/arch/i386/config.in	Sun Sep 23 21:20:24 2001
+++ build-2.4/arch/i386/config.in	Sun Sep 30 16:10:06 2001
@@ -396,7 +396,12 @@
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
-   bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   if [ "$CONFIG_SMP" = "y" ]; then
+      bool '  Spinlock debugging (SMP)' CONFIG_DEBUG_SPINLOCK
+   fi
+   if [ "$CONFIG_SMP" = "n" ]; then
+      bool '  Spinlock debugging (UP)' CONFIG_DEBUG_SPINLOCK_UP
+   fi
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
--- 2.4/include/linux/spinlock.h	Sat Jul 21 22:09:10 2001
+++ build-2.4/include/linux/spinlock.h	Sun Sep 30 16:58:22 2001
@@ -33,12 +33,13 @@
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
+#else
 
-#elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
-                                  defined (e.g. by including asm/spinlock.h */
-
-#define DEBUG_SPINLOCKS	0	/* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
-
+#ifdef CONFIG_DEBUG_SPINLOCK_UP
+#define DEBUG_SPINLOCKS	2	/* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
+#else
+#define DEBUG_SPINLOCKS	0
+#endif
 #if (DEBUG_SPINLOCKS < 1)
 
 #define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
@@ -84,18 +85,81 @@
 	volatile unsigned long lock;
 	volatile unsigned int babble;
 	const char *module;
+	char *owner;
+	int oline;
 } spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 25, __BASE_FILE__ }
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 10, __BASE_FILE__ , NULL, 0}
 
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
+		(x)->lock = 0; \
+		(x)->babble = 5; \
+		(x)->module = __BASE_FILE__; \
+		(x)->owner = NULL; \
+		(x)->oline = 0; \
+	} while (0)
+/* without debugging, spin_is_locked on UP always says
+ * FALSE. --> printk if already locked. */
+#define spin_is_locked(x) \
+	({ \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n", \
+					__BASE_FILE__,__LINE__, (x)->module, \
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
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n", \
+					__BASE_FILE__,__LINE__, (x)->module, \
+					(x), (x)->owner, (x)->oline); \
+			(x)->babble--; \
+		} \
+		(x)->lock = 1; \
+		(x)->owner = __BASE_FILE__; \
+		(x)->oline = __LINE__; \
+		1; \
+	})
+
+#define spin_lock(x)		\
+	do { \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n", \
+					__BASE_FILE__,__LINE__, (x)->module, \
+					(x), (x)->owner, (x)->oline); \
+			(x)->babble--; \
+		} \
+		(x)->lock = 1; \
+		(x)->owner = __BASE_FILE__; \
+		(x)->oline = __LINE__; \
+	} while (0)
+
+#define spin_unlock_wait(x)	\
+	do { \
+		if ((x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n", \
+					__BASE_FILE__,__LINE__, (x)->module, (x), \
+					(x)->owner, (x)->oline); \
+			(x)->babble--; \
+		}\
+	} while (0)
+#define spin_unlock(x) \
+	do { \
+		if (!(x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
+					__BASE_FILE__,__LINE__, (x)->module, (x));\
+			(x)->babble--; \
+		} \
+		(x)->lock = 0; \
+	} while (0)
 
 #endif	/* DEBUG_SPINLOCKS */
 
--- 2.4/kernel/ksyms.c	Sun Sep 23 21:20:55 2001
+++ build-2.4/kernel/ksyms.c	Sun Sep 30 17:07:53 2001
@@ -376,10 +376,12 @@
 EXPORT_SYMBOL(tq_timer);
 EXPORT_SYMBOL(tq_immediate);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK_UP)
 /* Various random spinlocks we want to export */
 EXPORT_SYMBOL(tqueue_lock);
+#endif
 
+#ifdef CONFIG_SMP
 /* Big-Reader lock implementation */
 EXPORT_SYMBOL(__brlock_array);
 #ifndef __BRLOCK_USE_ATOMICS
