Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271007AbRHODGW>; Tue, 14 Aug 2001 23:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271006AbRHODGN>; Tue, 14 Aug 2001 23:06:13 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:5 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S271007AbRHODF7>; Tue, 14 Aug 2001 23:05:59 -0400
Message-ID: <3B79E721.A2E63A92@freesoft.org>
Date: Tue, 14 Aug 2001 23:06:09 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: enhanced spinlock debugging for intel - take 2
Content-Type: multipart/mixed;
 boundary="------------9AD033A34BABEB02C78786E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9AD033A34BABEB02C78786E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi -

I've revised and improved the intel spinlock debugging I posted two
weeks ago.

Attached is the diff (against 2.4.8).  It moves the debugging routines
into a seperate C file (this is how sparc does it), fixes the race
condition noted by Tachino Nobuhiro, and adds debugging routines for
read-write spinlocks.

It compiles and runs fine on my single processor machine, and continues
to detect problems with the USB SCSI code.  Anybody want to try it on an
SMP box and make sure it's OK?

Make sure you do a "make dep" after applying the patch, since it exports
symbols...

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
--------------9AD033A34BABEB02C78786E0
Content-Type: text/plain; charset=us-ascii;
 name="linux-2.4.8-spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.8-spinlock.patch"

diff -Nur linux-2.4.8-dist/arch/i386/lib/Makefile linux-2.4.8/arch/i386/lib/Makefile
--- linux-2.4.8-dist/arch/i386/lib/Makefile	Thu Aug  9 23:30:36 2001
+++ linux-2.4.8/arch/i386/lib/Makefile	Tue Aug 14 01:37:14 2001
@@ -7,9 +7,11 @@
 
 L_TARGET = lib.a
 
+export-objs = debuglocks.o
+
 obj-y = checksum.o old-checksum.o delay.o \
 	usercopy.o getuser.o \
-	memcpy.o strstr.o
+	memcpy.o strstr.o debuglocks.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -Nur linux-2.4.8-dist/arch/i386/lib/debuglocks.c linux-2.4.8/arch/i386/lib/debuglocks.c
--- linux-2.4.8-dist/arch/i386/lib/debuglocks.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.8/arch/i386/lib/debuglocks.c	Tue Aug 14 14:18:19 2001
@@ -0,0 +1,183 @@
+/*
+ * debuglocks.c: Debugging versions of i386 SMP locking primitives.
+ *
+ * Aug 2001   Brent Baccala <baccala@freesoft.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <asm/page.h>
+
+/* The basic debugging operation is to add a field to the spinlock
+ * structure that contains the processor ID that set the lock.  Then,
+ * when we try to grab the lock, check to see if the current processor
+ * is the one that holds the lock, if so we've got a deadlock and a bug.
+ *
+ * There's no inter-processor race condition, since we only change the
+ * lock's saved processor ID while the lock is held, so there's no
+ * contention.  The invarient condition is that last_lock_processor
+ * never equals the current processor ID unless the current processor
+ * hold the lock.
+ *
+ * There's a slight race condition if interrupts are on and the current
+ * processor receives an interrupt and goes off to do something else
+ * between the time we grab the lock and set last_lock_processor, or
+ * between the time we clear last_lock_processor and release the lock.
+ * But, since the debugging fields aren't used for the actual locking,
+ * it shouldn't affect the operation of the spinlock itself, and while
+ * we may get a false negative (if the interrupt service routine tries
+ * to grab the lock, we won't catch it and the machine will deadlock),
+ * there won't be any false positives.  I can live with it.
+ *
+ * The unlock code checks to make sure the processor that grabbed the
+ * lock is the same one that's releasing it.  While you could imagine
+ * code that would hand off a lock from one processor to another,
+ * it's an unusual enough case that I've decided to flag it a bug.
+ *
+ * The code also adds fields to record the PC and current task_struct
+ * when the lock is grabbed, so if somebody comes along later and trys
+ * to grab it again, we can figure out who already has it.  This
+ * information doesn't show up in a oops, but is easily extracted
+ * using remote gdb.
+ *
+ * To enable this code, set SPINLOCK_DEBUG > 0 in asm/spinlock.h
+ */
+
+#if SPINLOCK_DEBUG
+
+void spin_lock(spinlock_t *lock)
+{
+	if (lock->magic != SPINLOCK_MAGIC)
+		BUG();
+	if (lock->last_lock_processor == smp_processor_id())
+		BUG();
+
+	__asm__ __volatile__(
+		spin_lock_string
+		:"=m" (lock->lock) : : "memory");
+
+	lock->last_lock_addr = __builtin_return_address(0);
+	lock->last_lock_current = current;
+	lock->last_lock_processor = smp_processor_id();
+}
+
+void spin_unlock(spinlock_t *lock)
+{
+	if (lock->magic != SPINLOCK_MAGIC)
+		BUG();
+	if (smp_processor_id() != lock->last_lock_processor)
+		BUG();
+	lock->last_lock_processor = -1;
+
+	__asm__ __volatile__(
+		spin_unlock_string
+		:"=m" (lock->lock) : : "memory");
+}
+
+int spin_trylock(spinlock_t *lock)
+{
+	char oldval;
+
+	if (lock->magic != SPINLOCK_MAGIC)
+		BUG();
+	if (lock->last_lock_processor == smp_processor_id())
+		BUG();
+
+	__asm__ __volatile__(
+		"xchgb %b0,%1"
+		:"=q" (oldval), "=m" (lock->lock)
+		:"0" (0) : "memory");
+
+	if (oldval > 0) {
+		lock->last_lock_processor = smp_processor_id();
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/* Debugging technique for r/w spinlocks is basically the same, but we
+ * have two fields - write_lock_processor that's just like the other
+ * code, and read_lock_count, an array with an atomic_t for each
+ * processor, set to the number of read locks that processor holds
+ */
+
+void read_lock(rwlock_t *rw)
+{
+	if (rw->magic != RWLOCK_MAGIC)
+		BUG();
+	if (rw->write_lock_processor == smp_processor_id())
+		BUG();
+
+	__build_read_lock(rw, "__read_lock_failed");
+
+	atomic_inc(&rw->read_lock_count[smp_processor_id()]);
+}
+
+void write_lock(rwlock_t *rw)
+{
+	if (rw->magic != RWLOCK_MAGIC)
+		BUG();
+	if (rw->write_lock_processor == smp_processor_id()
+	    || atomic_read(&rw->read_lock_count[smp_processor_id()]) > 0)
+		BUG();
+
+	__build_write_lock(rw, "__write_lock_failed");
+
+	rw->write_lock_processor = smp_processor_id();
+}
+
+void read_unlock(rwlock_t *rw)
+{
+	if (rw->magic != RWLOCK_MAGIC)
+		BUG();
+	if (atomic_add_negative(-1, &rw->read_lock_count[smp_processor_id()]))
+		BUG();
+
+	asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory");
+}
+
+void write_unlock(rwlock_t *rw)
+{
+	if (rw->magic != RWLOCK_MAGIC)
+		BUG();
+	if (smp_processor_id() != rw->write_lock_processor)
+		BUG();
+
+	rw->write_lock_processor = -1;
+
+	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0"
+		     :"=m" ((rw)->lock) : : "memory");
+}
+
+int write_trylock(rwlock_t *rw)
+{
+	atomic_t *count = (atomic_t *)rw;
+
+	if (rw->magic != RWLOCK_MAGIC)
+		BUG();
+	if (rw->write_lock_processor == smp_processor_id()
+	    || atomic_read(&rw->read_lock_count[smp_processor_id()]) > 0)
+		BUG();
+
+	if (atomic_sub_and_test(RW_LOCK_BIAS, count)) {
+		rw->write_lock_processor = smp_processor_id();
+		return 1;
+	}
+	atomic_add(RW_LOCK_BIAS, count);
+	return 0;
+}
+
+#include <linux/module.h>
+
+EXPORT_SYMBOL(spin_lock);
+EXPORT_SYMBOL(spin_unlock);
+EXPORT_SYMBOL(spin_trylock);
+EXPORT_SYMBOL(read_lock);
+EXPORT_SYMBOL(write_lock);
+EXPORT_SYMBOL(read_unlock);
+EXPORT_SYMBOL(write_unlock);
+EXPORT_SYMBOL(write_trylock);
+
+#endif /* SPINLOCK_DEBUG */
diff -Nur linux-2.4.8-dist/include/asm-i386/spinlock.h linux-2.4.8/include/asm-i386/spinlock.h
--- linux-2.4.8-dist/include/asm-i386/spinlock.h	Thu Aug  9 23:18:50 2001
+++ linux-2.4.8/include/asm-i386/spinlock.h	Tue Aug 14 14:23:34 2001
@@ -1,18 +1,15 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#include <linux/threads.h>
 #include <asm/atomic.h>
 #include <asm/rwlock.h>
-#include <asm/page.h>
-
-extern int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
 
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
  * Remember to turn this off in 2.4. -ben
  */
-#define SPINLOCK_DEBUG	0
+#define SPINLOCK_DEBUG	1
 
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
@@ -22,13 +19,16 @@
 	volatile unsigned int lock;
 #if SPINLOCK_DEBUG
 	unsigned magic;
+	void *last_lock_addr;
+	void *last_lock_current;
+	int last_lock_processor;
 #endif
 } spinlock_t;
 
 #define SPINLOCK_MAGIC	0xdead4ead
 
 #if SPINLOCK_DEBUG
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
+#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC, NULL, NULL, -1
 #else
 #define SPINLOCK_MAGIC_INIT	/* */
 #endif
@@ -65,26 +65,18 @@
 #define spin_unlock_string \
 	"movb $1,%0"
 
-static inline int spin_trylock(spinlock_t *lock)
-{
-	char oldval;
-	__asm__ __volatile__(
-		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->lock)
-		:"0" (0) : "memory");
-	return oldval > 0;
-}
+#if SPINLOCK_DEBUG
+
+/* Debugging versions of these routines are in arch/i386/lib/debuglocks.c */
+
+void spin_lock(spinlock_t *lock);
+void spin_unlock(spinlock_t *lock);
+int spin_trylock(spinlock_t *lock);
+
+#else
 
 static inline void spin_lock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
-	__label__ here;
-here:
-	if (lock->magic != SPINLOCK_MAGIC) {
-printk("eip: %p\n", &&here);
-		BUG();
-	}
-#endif
 	__asm__ __volatile__(
 		spin_lock_string
 		:"=m" (lock->lock) : : "memory");
@@ -92,17 +84,23 @@
 
 static inline void spin_unlock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
-#endif
 	__asm__ __volatile__(
 		spin_unlock_string
 		:"=m" (lock->lock) : : "memory");
 }
 
+static inline int spin_trylock(spinlock_t *lock)
+{
+	char oldval;
+	__asm__ __volatile__(
+		"xchgb %b0,%1"
+		:"=q" (oldval), "=m" (lock->lock)
+		:"0" (0) : "memory");
+	return oldval > 0;
+}
+
+#endif
+
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -117,13 +115,15 @@
 	volatile unsigned int lock;
 #if SPINLOCK_DEBUG
 	unsigned magic;
+	int write_lock_processor;
+	atomic_t read_lock_count[NR_CPUS];
 #endif
 } rwlock_t;
 
 #define RWLOCK_MAGIC	0xdeaf1eed
 
 #if SPINLOCK_DEBUG
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
+#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC, -1
 #else
 #define RWLOCK_MAGIC_INIT	/* */
 #endif
@@ -143,21 +143,25 @@
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
+#if SPINLOCK_DEBUG
+
+/* Debugging versions of these routines are in arch/i386/lib/debuglocks.c */
+
+void read_lock(rwlock_t *rw);
+void write_lock(rwlock_t *rw);
+void read_unlock(rwlock_t *rw);
+void write_unlock(rwlock_t *rw);
+int write_trylock(rwlock_t *rw);
+
+#else
+
 static inline void read_lock(rwlock_t *rw)
 {
-#if SPINLOCK_DEBUG
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
-#endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
 static inline void write_lock(rwlock_t *rw)
 {
-#if SPINLOCK_DEBUG
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
-#endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
@@ -172,5 +176,7 @@
 	atomic_add(RW_LOCK_BIAS, count);
 	return 0;
 }
+
+#endif /* SPINLOCK_DEBUG */
 
 #endif /* __ASM_SPINLOCK_H */

--------------9AD033A34BABEB02C78786E0--

