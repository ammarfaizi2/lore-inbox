Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUHLHY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUHLHY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbUHLHY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:24:58 -0400
Received: from holomorphy.com ([207.189.100.168]:58249 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268440AbUHLHVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:21:39 -0400
Date: Thu, 12 Aug 2004 00:20:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Keith Owens <kaos@ocs.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040812072058.GH11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com> <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com> <20040812020424.GB11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812020424.GB11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:04:24PM -0700, William Lee Irwin III wrote:
> Odd, it was either you or mpm who told me the results. I personally
> never even tried running the thing. I was merely told some other, prior
> attempt at doing some kind of spinlock uninlining failed to run, this
> thing did, and that it shaved that memorable amount off of .text size.
> I recall I compiled it myself and saw about half as much reduction
> (120KB instead of 220KB), possibly due to .config or compiler differences.
> I'll dust things off and so on.

Okay, the results on 2.6.8-rc4 (COOL had a bit of porting, basically
dropping the hunks associated with spin_lock_flags_string or whatever
it is). Chose the .config largely to be vaguely deterministic, but had
to nuke the "System is too big" check in arch/x86_64/boot/tools/build.c.

              text    data     bss     dec     hex filename
mainline: 20708323        6603052 1878448 29189823        1bd66bf vmlinux
cool:     20619594        6588166 1878448 29086208        1bbd200 vmlinux
C-func:   19969264        6583128 1878384 28430776        1b1d1b8 vmlinux

x86-64, -O2, allyesconfig minus the following:

# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_IDE_ARM is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
# CONFIG_HPET_RTC_IRQ is not set
# CONFIG_AEDSP16_SBPRO is not set
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_SA1100 is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_DEBUG_SPINLOCK is not set

-- wli

Index: spinlock-2.6.8-rc1/include/linux/spinlock.h
===================================================================
--- spinlock-2.6.8-rc1.orig/include/linux/spinlock.h	2004-07-11 10:34:38.000000000 -0700
+++ spinlock-2.6.8-rc1/include/linux/spinlock.h	2004-07-14 21:38:47.000000000 -0700
@@ -60,90 +60,35 @@
 } spinlock_t;
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
 
-#define spin_lock_init(x) \
-	do { \
-		(x)->magic = SPINLOCK_MAGIC; \
-		(x)->lock = 0; \
-		(x)->babble = 5; \
-		(x)->module = __FILE__; \
-		(x)->owner = NULL; \
-		(x)->oline = 0; \
-	} while (0)
-
-#define CHECK_LOCK(x) \
-	do { \
-	 	if ((x)->magic != SPINLOCK_MAGIC) { \
-			printk(KERN_ERR "%s:%d: spin_is_locked on uninitialized spinlock %p.\n", \
-					__FILE__, __LINE__, (x)); \
-		} \
-	} while(0)
-
-#define _raw_spin_lock(x)		\
-	do { \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		(x)->lock = 1; \
-		(x)->owner = __FILE__; \
-		(x)->oline = __LINE__; \
-	} while (0)
+#define spin_lock_init(x)	__spin_lock_init(x, __FILE__)
+#define _raw_spin_lock(x)	__raw_spin_lock(x, __FILE__, __LINE__)
 
 /* without debugging, spin_is_locked on UP always says
  * FALSE. --> printk if already locked. */
-#define spin_is_locked(x) \
-	({ \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		0; \
-	})
+#define spin_is_locked(x)	__spin_is_locked(x, __FILE__, __LINE__)
 
 /* without debugging, spin_trylock on UP always says
  * TRUE. --> printk if already locked. */
-#define _raw_spin_trylock(x) \
-	({ \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		(x)->lock = 1; \
-		(x)->owner = __FILE__; \
-		(x)->oline = __LINE__; \
-		1; \
-	})
-
-#define spin_unlock_wait(x)	\
-	do { \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, (x), \
-					(x)->owner, (x)->oline); \
-		}\
-	} while (0)
-
-#define _raw_spin_unlock(x) \
-	do { \
-	 	CHECK_LOCK(x); \
-		if (!(x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
-					__FILE__,__LINE__, (x)->module, (x));\
-		} \
-		(x)->lock = 0; \
-	} while (0)
+#define _raw_spin_trylock(x)	__raw_spin_trylock(x, __FILE__, __LINE__)
+#define spin_unlock_wait(x)	__spin_unlock_wait(x, __FILE__, __LINE__)
+#define _raw_spin_unlock(x)	__raw_spin_unlock(x, __FILE__, __LINE__)
+#define spin_trylock(x)		__spin_trylock(x, __FILE__, __LINE__)
+#define spin_lock(x)		__spin_lock(x, __FILE__, __LINE__)
+#define spin_unlock(x)		__spin_unlock(x, __FILE__, __LINE__)
+
+int __spin_trylock(spinlock_t *, const char *, int);
+void __spin_lock(spinlock_t *, const char *, int);
+void __spin_lock_irq(spinlock_t *, const char *, int);
+void __spin_lock_irqsave(spinlock_t *, unsigned long *, const char *, int);
+void __spin_unlock(spinlock_t *, const char *, int);
+void __spin_unlock_irq(spinlock_t *, const char *, int);
+void __spin_unlock_irqrestore(spinlock_t *, unsigned long *, const char *, int);
+void __spin_lock_init(spinlock_t *, const char *);
+void __raw_spin_lock(spinlock_t *, const char *, int);
+int __spin_is_locked(spinlock_t *, const char *, int);
+int __raw_spin_trylock(spinlock_t *, const char *, int);
+void __spin_unlock_wait(spinlock_t *, const char *, int);
+void __raw_spin_unlock(spinlock_t *, const char *, int);
 #else
 /*
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
@@ -176,226 +121,78 @@
   typedef struct { int gcc_is_buggy; } rwlock_t;
   #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 #endif
+#endif /* !SMP */
 
+#if (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)) || \
+					defined(CONFIG_DEBUG_SPINLOCK)
 #define rwlock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_read_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_trylock(lock) ({ (void)(lock); (1); })
+#endif
 
-#endif /* !SMP */
+/* "lock on reference count zero" */
+#if (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT) || \
+	defined(CONFIG_DEBUG_SPINLOCK)) && !defined(ATOMIC_DEC_AND_LOCK)
+#include <asm/atomic.h>
+int atomic_dec_and_lock(atomic_t *, spinlock_t *);
+#endif
 
 /*
  * Define the various spin_lock and rw_lock methods.  Note we define these
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+int spin_trylock(spinlock_t *);
+int write_trylock(rwlock_t *);
 /* Where's read_trylock? */
 
+void spin_lock(spinlock_t *);
+void write_lock(rwlock_t *);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
 void __preempt_spin_lock(spinlock_t *lock);
 void __preempt_write_lock(rwlock_t *lock);
-
-#define spin_lock(lock) \
-do { \
-	preempt_disable(); \
-	if (unlikely(!_raw_spin_trylock(lock))) \
-		__preempt_spin_lock(lock); \
-} while (0)
-
-#define write_lock(lock) \
-do { \
-	preempt_disable(); \
-	if (unlikely(!_raw_write_trylock(lock))) \
-		__preempt_write_lock(lock); \
-} while (0)
-
-#else
-#define spin_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-} while(0)
-
-#define write_lock(lock) \
-do { \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-} while(0)
 #endif
 
-#define read_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-} while(0)
-
-#define spin_unlock(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable(); \
-} while (0)
-
-#define write_unlock(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	preempt_enable(); \
-} while(0)
-
-#define read_unlock(lock) \
-do { \
-	_raw_read_unlock(lock); \
-	preempt_enable(); \
-} while(0)
-
-#define spin_lock_irqsave(lock, flags) \
-do { \
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_spin_lock_flags(lock, flags); \
-} while (0)
-
-#define spin_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-} while (0)
-
-#define spin_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-} while (0)
-
-#define read_lock_irqsave(lock, flags) \
-do { \
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-} while (0)
-
-#define read_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-} while (0)
-
-#define read_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-} while (0)
-
-#define write_lock_irqsave(lock, flags) \
-do { \
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-} while (0)
-
-#define write_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-} while (0)
-
-#define write_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-} while (0)
-
-#define spin_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-} while (0)
-
-#define _raw_spin_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_restore(flags); \
-} while (0)
-
-#define spin_unlock_irq(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_enable(); \
-	preempt_enable(); \
-} while (0)
-
-#define spin_unlock_bh(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable(); \
-	local_bh_enable(); \
-} while (0)
-
-#define read_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_read_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-} while (0)
-
-#define read_unlock_irq(lock) \
-do { \
-	_raw_read_unlock(lock); \
-	local_irq_enable(); \
-	preempt_enable(); \
-} while (0)
-
-#define read_unlock_bh(lock) \
-do { \
-	_raw_read_unlock(lock); \
-	preempt_enable(); \
-	local_bh_enable(); \
-} while (0)
-
-#define write_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_write_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-} while (0)
-
-#define write_unlock_irq(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	local_irq_enable(); \
-	preempt_enable(); \
-} while (0)
-
-#define write_unlock_bh(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	preempt_enable(); \
-	local_bh_enable(); \
-} while (0)
-
-#define spin_trylock_bh(lock)	({ local_bh_disable(); preempt_disable(); \
-				_raw_spin_trylock(lock) ? 1 : \
-				({preempt_enable(); local_bh_enable(); 0;});})
-
-/* "lock on reference count zero" */
-#ifndef ATOMIC_DEC_AND_LOCK
-#include <asm/atomic.h>
-extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
-#endif
+void read_lock(rwlock_t *);
+void spin_unlock(spinlock_t *);
+void write_unlock(rwlock_t *);
+void read_unlock(rwlock_t *);
+void __spin_lock_irqsave(spinlock_t *, unsigned long *);
+void spin_lock_irq(spinlock_t *);
+void spin_lock_bh(spinlock_t *);
+void __read_lock_irqsave(rwlock_t *, unsigned long *);
+void read_lock_irq(rwlock_t *);
+void read_lock_bh(rwlock_t *);
+void __write_lock_irqsave(rwlock_t *, unsigned long *);
+void write_lock_irq(rwlock_t *);
+void write_lock_bh(rwlock_t *);
+void __spin_unlock_irqrestore(spinlock_t *, unsigned long *);
+void __raw_spin_unlock_irqrestore(spinlock_t *, unsigned long *);
+void spin_unlock_irq(spinlock_t *);
+void spin_unlock_bh(spinlock_t *);
+void __read_unlock_irqrestore(rwlock_t *, unsigned long *);
+void read_unlock_irq(rwlock_t *);
+void read_unlock_bh(rwlock_t *);
+void __write_unlock_irqrestore(rwlock_t *, unsigned long *);
+void write_unlock_irq(rwlock_t *);
+void write_unlock_bh(rwlock_t *);
+int spin_trylock_bh(spinlock_t *);
+
+#define spin_lock_irqsave(lock, flags)	__spin_lock_irqsave(lock, &(flags))
+#define read_lock_irqsave(lock, flags)	__read_lock_irqsave(lock, &(flags))
+#define write_lock_irqsave(lock, flags)	__write_lock_irqsave(lock, &(flags))
+#define spin_unlock_irqrestore(lock, flags) __spin_unlock_irqrestore(lock, &(flags))
+#define _raw_spin_unlock_irqrestore(lock, flags)			\
+	__raw_spin_unlock_irqrestore(lock, &(flags))
+#define read_unlock_irqrestore(lock, flags)				\
+	__read_unlock_irqrestore(lock, &(flags))
+#define write_unlock_irqrestore(lock, flags)				\
+	__write_unlock_irqrestore(lock, &(flags))
 
 /*
  *  bit-based spin_lock()
@@ -403,68 +200,48 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (test_and_set_bit(bitnum, addr)) {
-		while (test_bit(bitnum, addr))
-			cpu_relax();
-	}
-#endif
-}
-
-/*
- * Return true if it was acquired
- */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	int ret;
-
-	preempt_disable();
-	ret = !test_and_set_bit(bitnum, addr);
-	if (!ret)
-		preempt_enable();
-	return ret;
-#else
-	preempt_disable();
-	return 1;
-#endif
-}
-
-/*
- *  bit-based spin_unlock()
- */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	BUG_ON(!test_bit(bitnum, addr));
-	smp_mb__before_clear_bit();
-	clear_bit(bitnum, addr);
-#endif
-	preempt_enable();
-}
-
-/*
- * Return true if the lock is held.
- */
-static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT
-	return preempt_count();
-#else
-	return 1;
+void bit_spin_lock(int, unsigned long *);
+int bit_spin_trylock(int, unsigned long *);
+void bit_spin_unlock(int, unsigned long *);
+int bit_spin_is_locked(int, unsigned long *);
+#else
+#define bit_spin_lock(bit, lock)	do { (void)(bit); (void)(lock); } while (0)
+#define bit_spin_unlock(bit, lock)	do { (void)(bit); (void)(lock); } while (0)
+#define bit_spin_trylock(bit, lock)	({ (void)(bit); (void)(lock); 1; })
+#define bit_spin_is_locked(bit, lock)	({ (void)(bit); (void)(lock); 1; })
+
+#ifndef CONFIG_DEBUG_SPINLOCK
+#define spin_trylock(lock)		_raw_spin_trylock(lock)
+#define spin_lock(lock)			_raw_spin_lock(lock)
+#define spin_unlock(lock)		_raw_spin_lock(lock)
+#endif
+
+#define read_lock(lock)			_raw_read_lock(lock)
+#define read_unlock(lock)		_raw_read_lock(lock)
+#define write_lock(lock)		_raw_write_lock(lock)
+#define write_unlock(lock)		_raw_write_lock(lock)
+
+#define spin_lock_irq(lock)		do { local_irq_disable(); _raw_spin_lock(lock); } while (0)
+#define spin_unlock_irq(lock)		do { _raw_spin_lock(lock); local_irq_disable(); } while (0)
+#define read_lock_irq(lock)		do { local_irq_disable(); _raw_read_lock(lock); } while (0)
+#define read_unlock_irq(lock)		do { _raw_read_lock(lock); local_irq_enable(); } while (0)
+#define write_lock_irq(lock)		do { local_irq_disable(); _raw_write_lock(lock); } while (0)
+#define write_unlock_irq(lock)		do { _raw_write_lock(lock); local_irq_enable(); } while (0)
+
+#define spin_lock_irqsave(lock, flags)	do { local_irq_save(flags); _raw_spin_lock(lock); } while (0)
+#define spin_unlock_irqrestore(lock, flags) do { _raw_spin_lock(lock); local_irq_restore(flags); } while (0)
+#define read_lock_irqsave(lock, flags)	do { _raw_read_lock(lock); local_irq_save(flags); } while (0)
+#define read_unlock_irqrestore(lock, flags) do { _raw_read_lock(lock); local_irq_restore(flags); } while (0)
+#define write_lock_irqsave(lock, flags)	do { local_irq_save(flags); _raw_write_lock(lock); } while (0)
+#define write_unlock_irqrestore(lock, flags) do { _raw_write_lock(lock); local_irq_restore(flags); } while (0)
+
+#define spin_trylock_bh(lock)		({ local_bh_disable(); _raw_spin_trylock(lock); })
+#define spin_lock_bh(lock)		do { local_bh_disable(); _raw_spin_lock(lock); } while (0)
+#define spin_unlock_bh(lock)		do { _raw_spin_lock(lock); local_bh_enable(); } while (0)
+#define read_lock_bh(lock)		do { local_bh_disable(); _raw_read_lock(lock); } while (0)
+#define read_unlock_bh(lock)		do { _raw_read_lock(lock); local_bh_enable(); } while (0)
+#define write_lock_bh(lock)		do { local_bh_disable(); _raw_write_lock(lock); } while (0)
+#define write_unlock_bh(lock)		do { _raw_write_lock(lock); local_bh_enable(); } while (0)
 #endif
-}
 
 #endif /* __LINUX_SPINLOCK_H */
Index: spinlock-2.6.8-rc1/kernel/spinlock.c
===================================================================
--- spinlock-2.6.8-rc1.orig/kernel/spinlock.c	2004-06-07 00:42:31.000000000 -0700
+++ spinlock-2.6.8-rc1/kernel/spinlock.c	2004-07-14 18:23:46.000000000 -0700
@@ -0,0 +1,448 @@
+/*
+ * kernel/spinlock.c - generic locking
+ * (c) William Irwin, Oracle, July 2004
+ */
+#include <linux/config.h>
+#include <linux/preempt.h>
+#include <linux/linkage.h>
+#include <linux/compiler.h>
+#include <linux/thread_info.h>
+#include <linux/kernel.h>
+#include <linux/stringify.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+
+#include <asm/processor.h>	/* for cpu relax */
+#include <asm/system.h>
+
+/*
+ * If CONFIG_SMP is set, pull in the _raw_* definitions
+ */
+#ifdef CONFIG_SMP
+#include <asm/spinlock.h>
+
+#else
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+void __spin_lock_init(spinlock_t *lock, const char *file)
+{
+	lock->magic = SPINLOCK_MAGIC;
+	lock->lock = 0;
+	lock->babble = 5;
+	lock->module = (char *)file;
+	lock->owner = NULL;
+	lock->oline = 0;
+}
+EXPORT_SYMBOL(__spin_lock_init);
+
+static void check_lock(spinlock_t *lock, const char *file, int line)
+{
+ 	if (lock->magic != SPINLOCK_MAGIC)
+		printk(KERN_ERR "%s:%d: spin_is_locked on "
+			"uninitialized spinlock %p.\n",
+			file, line, lock);
+}
+EXPORT_SYMBOL(check_lock);
+
+void __raw_spin_lock(spinlock_t *lock, const char *file, int line)
+{
+	check_lock(lock, file, line);
+	if (lock->lock && lock->babble) {
+		lock->babble--;
+		printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n",
+				file, line, lock->module,
+				lock, lock->owner, lock->oline);
+	}
+	lock->lock = 1;
+	lock->owner = (char *)file;
+	lock->oline = line;
+}
+
+/* without debugging, spin_is_locked on UP always says
+ * FALSE. --> printk if already locked. */
+int __spin_is_locked(spinlock_t *lock, const char *file, int line)
+{
+	check_lock(lock, file, line);
+	if (lock->lock && lock->babble) {
+		lock->babble--;
+		printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n",
+			file, line, lock->module,
+			lock, lock->owner, lock->oline);
+		}
+		return 0;
+}
+EXPORT_SYMBOL(__spin_is_locked);
+
+/* without debugging, spin_trylock on UP always says
+ * TRUE. --> printk if already locked. */
+int __raw_spin_trylock(spinlock_t *lock, const char *file, int line)
+{
+	check_lock(lock, file, line);
+	if (lock->lock && lock->babble) {
+		lock->babble--;
+		printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n",
+				file, line, lock->module,
+				lock, lock->owner, lock->oline);
+	}
+	lock->lock = 1;
+	lock->owner = (char *)file;
+	lock->oline = line;
+	return 1;
+}
+EXPORT_SYMBOL(__raw_spin_trylock);
+
+void __spin_unlock_wait(spinlock_t *lock, const char *file, int line)
+{
+ 	check_lock(lock, file, line);
+	if (lock->lock && lock->babble) {
+		lock->babble--;
+		printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n",
+				file, line, lock->module, lock,
+				lock->owner, lock->oline);
+	}
+}
+EXPORT_SYMBOL(__spin_unlock_wait);
+
+void __raw_spin_unlock(spinlock_t *lock, const char *file, int line)
+{
+ 	check_lock(lock, file, line);
+	if (!lock->lock && lock->babble) {
+		lock->babble--;
+		printk("%s:%d: spin_unlock(%s:%p) not locked\n",
+				file, line, lock->module, lock);
+	}
+	lock->lock = 0;
+}
+EXPORT_SYMBOL(__raw_spin_unlock);
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
+#endif /* !SMP */
+
+/*
+ * Define the various spin_lock and rw_lock methods.  Note we define these
+ * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
+ * methods are defined as nops in the case they are not required.
+ */
+int spin_trylock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_spin_trylock(lock))
+		return 1;
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(spin_trylock);
+
+int write_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_write_trylock(lock))
+		return 1;
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(write_trylock);
+
+/* Where's read_trylock? */
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+void __preempt_spin_lock(spinlock_t *lock);
+void __preempt_write_lock(rwlock_t *lock);
+
+void spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_raw_spin_trylock(lock)))
+		__preempt_spin_lock(lock);
+}
+EXPORT_SYMBOL(spin_lock);
+
+void write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_raw_write_trylock(lock)))
+		__preempt_write_lock(lock);
+}
+EXPORT_SYMBOL(write_lock);
+
+#else
+void spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+EXPORT_SYMBOL(spin_lock);
+
+void write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+EXPORT_SYMBOL(write_lock);
+#endif
+
+void read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(read_lock);
+
+void spin_unlock(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(spin_unlock);
+
+void write_unlock(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(write_unlock);
+
+void read_unlock(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(read_unlock);
+
+void __spin_lock_irqsave(spinlock_t *lock, unsigned long *flags)
+{
+	local_irq_save(*flags);
+	preempt_disable();
+	_raw_spin_lock_flags(lock, *flags);
+}
+EXPORT_SYMBOL(__spin_lock_irqsave);
+
+void spin_lock_irq(spinlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+EXPORT_SYMBOL(spin_lock_irq);
+
+void spin_lock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+EXPORT_SYMBOL(spin_lock_bh);
+
+void __read_lock_irqsave(rwlock_t *lock, unsigned long *flags)
+{
+	local_irq_save(*flags);
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(__read_lock_irqsave);
+
+void read_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(read_lock_irq);
+
+void read_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(read_lock_bh);
+
+void __write_lock_irqsave(rwlock_t *lock, unsigned long *flags)
+{
+	local_irq_save(*flags);
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+EXPORT_SYMBOL(__write_lock_irqsave);
+
+void write_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+EXPORT_SYMBOL(write_lock_irq);
+
+void write_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+EXPORT_SYMBOL(write_lock_bh);
+
+void __spin_unlock_irqrestore(spinlock_t *lock, unsigned long *flags)
+{
+	_raw_spin_unlock(lock);
+	local_irq_restore(*flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(__spin_unlock_irqrestore);
+
+void __raw_spin_unlock_irqrestore(spinlock_t *lock, unsigned long *flags)
+{
+	_raw_spin_unlock(lock);
+	local_irq_restore(*flags);
+}
+EXPORT_SYMBOL(__raw_spin_unlock_irqrestore);
+
+void spin_unlock_irq(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(spin_unlock_irq);
+
+void spin_unlock_bh(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(spin_unlock_bh);
+
+void __read_unlock_irqrestore(rwlock_t *lock, unsigned long *flags)
+{
+	_raw_read_unlock(lock);
+	local_irq_restore(*flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(__read_unlock_irqrestore);
+
+void read_unlock_irq(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(read_unlock_irq);
+
+void read_unlock_bh(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(read_unlock_bh);
+
+void __write_unlock_irqrestore(rwlock_t *lock, unsigned long *flags)
+{
+	_raw_write_unlock(lock);
+	local_irq_restore(*flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(__write_unlock_irqrestore);
+
+void write_unlock_irq(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(write_unlock_irq);
+
+void write_unlock_bh(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(write_unlock_bh);
+
+int spin_trylock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	if (_raw_spin_trylock(lock))
+		return 1;
+	preempt_enable();
+	local_bh_enable();
+	return 0;
+}
+EXPORT_SYMBOL(spin_trylock_bh);
+
+/*
+ *  bit-based spin_lock()
+ *
+ * Don't use this unless you really need to: spin_lock() and spin_unlock()
+ * are significantly faster.
+ */
+void bit_spin_lock(int bitnum, unsigned long *addr)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	while (test_and_set_bit(bitnum, addr)) {
+		while (test_bit(bitnum, addr))
+			cpu_relax();
+	}
+#endif
+}
+EXPORT_SYMBOL(bit_spin_lock);
+
+/*
+ * Return true if it was acquired
+ */
+int bit_spin_trylock(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	int ret;
+
+	preempt_disable();
+	ret = !test_and_set_bit(bitnum, addr);
+	if (!ret)
+		preempt_enable();
+	return ret;
+#else
+	preempt_disable();
+	return 1;
+#endif
+}
+EXPORT_SYMBOL(bit_spin_trylock);
+
+/*
+ *  bit-based spin_unlock()
+ */
+void bit_spin_unlock(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	BUG_ON(!test_bit(bitnum, addr));
+	smp_mb__before_clear_bit();
+	clear_bit(bitnum, addr);
+#endif
+	preempt_enable();
+}
+EXPORT_SYMBOL(bit_spin_unlock);
+
+/*
+ * Return true if the lock is held.
+ */
+int bit_spin_is_locked(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	return test_bit(bitnum, addr);
+#elif defined CONFIG_PREEMPT
+	return preempt_count();
+#else
+	return 1;
+#endif
+}
+EXPORT_SYMBOL(bit_spin_is_locked);
Index: spinlock-2.6.8-rc1/kernel/Makefile
===================================================================
--- spinlock-2.6.8-rc1.orig/kernel/Makefile	2004-07-11 10:34:10.000000000 -0700
+++ spinlock-2.6.8-rc1/kernel/Makefile	2004-07-14 05:00:48.000000000 -0700
@@ -23,6 +23,17 @@
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+ifeq ($(CONFIG_PREEMPT),y)
+	obj-y += spinlock.o
+else
+	ifeq ($(CONFIG_SMP),y)
+		obj-y += spinlock.o
+	else
+		ifeq ($(CONFIG_DEBUG_SPINLOCK),y)
+			obj-y += spinlock.o
+		endif
+	endif
+endif
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
