Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268302AbTAMUbG>; Mon, 13 Jan 2003 15:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268307AbTAMUbF>; Mon, 13 Jan 2003 15:31:05 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:45456 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S268302AbTAMUbB>;
	Mon, 13 Jan 2003 15:31:01 -0500
Message-ID: <3E232393.1010702@colorfullife.com>
Date: Mon, 13 Jan 2003 21:37:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: any chance of 2.6.0-test*?
Content-Type: multipart/mixed;
 boundary="------------050300090307060208020608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300090307060208020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens wrote:

>On Mon, Jan 13 2003, Terje Eggestad wrote:
>> > > I have the console on a serial port, and a terminal server. With kdb,
>> > > you can enter the kernel i kdb even when deadlocked.
>> > 
>> > Even if spinning with interrupt disabled?
>> 
>> Haven't painted myself into that corner yet. Doubt it, very much.
>
>These are the nasty hangs, total lockup and no info at all if it wasn't
>for the nmi watchdog triggering. That alone is reason enough for me :-)
>  
>
One alternative are the UP debug spinlocks: They detect double-locks.
2.4 contains macros, but I'm not sure if they work.
The macros were removed in 2.5, but if anyone is interested, I've 
attached my debug spinlock patch: for double locks, it even prints the 
filename/lineno of the offender.

--
    Manfred

--------------050300090307060208020608
Content-Type: text/plain;
 name="patch-debug-sp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-debug-sp"

--- 2.5/include/linux/spinlock.h	2002-12-14 10:06:57.000000000 +0100
+++ build-2.5/include/linux/spinlock.h	2002-12-21 14:36:42.000000000 +0100
@@ -37,30 +37,120 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
-/*
- * !CONFIG_SMP and spin_lock_init not previously defined
- * (e.g. by including include/asm/spinlock.h)
- */
-#elif !defined(spin_lock_init)
+#else
 
-#ifndef CONFIG_PREEMPT
+#if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
 # define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
 # define ATOMIC_DEC_AND_LOCK
 #endif
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+ 
+#define SPINLOCK_MAGIC	0x1D244B3C
+typedef struct {
+	unsigned long magic;
+	volatile unsigned long lock;
+	volatile unsigned int babble;
+	const char *module;
+	char *owner;
+	int oline;
+} spinlock_t;
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
+
+#define spin_lock_init(x) \
+	do { \
+		(x)->magic = SPINLOCK_MAGIC; \
+		(x)->lock = 0; \
+		(x)->babble = 5; \
+		(x)->module = __FILE__; \
+		(x)->owner = NULL; \
+		(x)->oline = 0; \
+	} while (0)
+
+#define CHECK_LOCK(x) \
+	do { \
+	 	if ((x)->magic != SPINLOCK_MAGIC) { \
+			printk(KERN_ERR "%s:%d: spin_is_locked on uninitialized spinlock %p.\n", \
+					__FILE__, __LINE__, (x)); \
+		} \
+	} while(0)
+
+#define _raw_spin_lock(x)		\
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
+#define _raw_spin_trylock(x) \
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
+#define _raw_spin_unlock(x) \
+	do { \
+	 	CHECK_LOCK(x); \
+		if (!(x)->lock&&(x)->babble) { \
+			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
+					__FILE__,__LINE__, (x)->module, (x));\
+			(x)->babble--; \
+		} \
+		(x)->lock = 0; \
+	} while (0)
+#else
 /*
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
 #if (__GNUC__ > 2)
   typedef struct { } spinlock_t;
-  typedef struct { } rwlock_t;
   #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-  #define RW_LOCK_UNLOCKED (rwlock_t) { }
 #else
   typedef struct { int gcc_is_buggy; } spinlock_t;
-  typedef struct { int gcc_is_buggy; } rwlock_t;
   #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 #endif
 
 /*
@@ -72,6 +162,18 @@
 #define _raw_spin_trylock(lock)	((void)(lock), 1)
 #define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
+/* RW spinlocks: No debug version */
+
+#if (__GNUC__ > 2)
+  typedef struct { } rwlock_t;
+  #define RW_LOCK_UNLOCKED (rwlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } rwlock_t;
+  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+#endif
+
 #define rwlock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_read_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_read_unlock(lock)	do { (void)(lock); } while(0)

--------------050300090307060208020608--


