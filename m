Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUHXVIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUHXVIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUHXVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:08:41 -0400
Received: from holomorphy.com ([207.189.100.168]:14214 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268326AbUHXVGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:06:25 -0400
Date: Tue, 24 Aug 2004 14:06:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: WAITQUEUE_DEBUG crapectomy
Message-ID: <20040824210616.GW2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 01:34:02AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/
> - Added the kexec code.  Again.  This was in -mm a year or so ago but didn't
>   make it.
> - This kernel has an x86 patch which alters the copy_*_user() functions so
>   they will return -EFAULT on a fault rather than the number of bytes which
>   remain to be copied.  This is a bit of an experiment, because this seems to
>   be the preferred API for those functions.   It's a see-what-breaks thing.
>   And things will break.  If weird behaviour is observed, please revert
>   usercopy-return-EFAULT.patch and send a report.

While trying out compiling of reiser4 on sparc64, ppc64, alpha, and
ia64, I discovered that WAITQUEUE_DEBUG is nowhere defined in 2.6.x,
and various compiler versions spew copious warnings at #if on it.
Convert __SEMAPHORE_INITIALIZER() to C99 initializers while in the area.

$ diffstat waitqueue-debug-crapectomy.patch 
 asm-alpha/semaphore.h     |   23 ++++++-----------------
 asm-arm/semaphore.h       |   30 ++----------------------------
 asm-arm26/semaphore.h     |   37 ++++++-------------------------------
 asm-cris/semaphore.h      |   33 ++++++---------------------------
 asm-h8300/semaphore.h     |   33 ++++++---------------------------
 asm-i386/semaphore.h      |   34 ++++++----------------------------
 asm-ia64/semaphore.h      |   30 +++++-------------------------
 asm-m68k/semaphore.h      |   33 ++++++---------------------------
 asm-m68knommu/semaphore.h |   33 ++++++---------------------------
 asm-mips/semaphore.h      |   36 +++++-------------------------------
 asm-parisc/semaphore.h    |   31 ++++++-------------------------
 asm-ppc/semaphore.h       |   36 +++++-------------------------------
 asm-ppc64/semaphore.h     |   36 +++++-------------------------------
 asm-sh/semaphore.h        |   35 ++++++-----------------------------
 asm-sh64/semaphore.h      |   35 ++++++-----------------------------
 asm-sparc/semaphore.h     |   36 ++++++------------------------------
 asm-x86_64/semaphore.h    |   35 ++++++-----------------------------
 17 files changed, 94 insertions(+), 472 deletions(-)

Index: mm4-2.6.8.1/include/asm-alpha/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-alpha/semaphore.h	2004-08-14 03:55:59.000000000 -0700
+++ mm4-2.6.8.1/include/asm-alpha/semaphore.h	2004-08-24 13:10:31.044736698 -0700
@@ -18,21 +18,13 @@
 struct semaphore {
 	atomic_t count;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count)		\
-	{ ATOMIC_INIT(count),				\
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-	  __SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)			\
+{								\
+	.count	= ATOMIC_INIT(n),				\
+  	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+}
 
 #define __MUTEX_INITIALIZER(name)			\
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -53,9 +45,6 @@
 
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -142,7 +131,7 @@
 		__up_wakeup(sem);
 }
 
-#if !defined(WAITQUEUE_DEBUG) && !defined(CONFIG_DEBUG_SEMAPHORE)
+#if !defined(CONFIG_DEBUG_SEMAPHORE)
 extern inline void down(struct semaphore *sem)
 {
 	__down(sem);
Index: mm4-2.6.8.1/include/asm-arm/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-arm/semaphore.h	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/include/asm-arm/semaphore.h	2004-08-24 13:13:42.156062482 -0700
@@ -16,21 +16,12 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)	.__magic = (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INIT(name,cnt) {				\
+#define __SEMAPHORE_INIT(name, cnt)				\
+{								\
 	.count	= ATOMIC_INIT(cnt),				\
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
-	__SEM_DEBUG_INIT(name)					\
 }
 
 #define __MUTEX_INITIALIZER(name) __SEMAPHORE_INIT(name,1)
@@ -46,9 +37,6 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX(struct semaphore *sem)
@@ -85,9 +73,6 @@
  */
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__down_op(sem, __down_failed);
 }
@@ -98,19 +83,12 @@
  */
 static inline int down_interruptible (struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	return __down_op_ret(sem, __down_interruptible_failed);
 }
 
 static inline int down_trylock(struct semaphore *sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	return __down_op_ret(sem, __down_trylock_failed);
 }
 
@@ -122,10 +100,6 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__up_op(sem, __up_wakeup);
 }
 
Index: mm4-2.6.8.1/include/asm-arm26/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-arm26/semaphore.h	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/include/asm-arm26/semaphore.h	2004-08-24 13:12:43.761531947 -0700
@@ -16,22 +16,14 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INIT(name,count)			\
-	{ ATOMIC_INIT(count), 0,			\
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-	  __SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INIT(name, n)					\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INIT(name,1)
@@ -47,9 +39,6 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#if WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX(struct semaphore *sem)
@@ -81,9 +70,6 @@
  */
 static inline void down(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__down_op(sem, __down_failed);
 }
@@ -94,19 +80,12 @@
  */
 static inline int down_interruptible (struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	return __down_op_ret(sem, __down_interruptible_failed);
 }
 
 static inline int down_trylock(struct semaphore *sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	return __down_op_ret(sem, __down_trylock_failed);
 }
 
@@ -118,10 +97,6 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__up_op(sem, __up_wakeup);
 }
 
Index: mm4-2.6.8.1/include/asm-cris/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-cris/semaphore.h	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/include/asm-cris/semaphore.h	2004-08-24 13:14:59.530084971 -0700
@@ -24,21 +24,14 @@
 	atomic_t count;
 	atomic_t waking;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)         , (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count)             \
-        { ATOMIC_INIT(count), ATOMIC_INIT(0),           \
-          __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
-          __SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.waking		= ATOMIC_INIT(0),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
+}
 
 #define __MUTEX_INITIALIZER(name) \
         __SEMAPHORE_INITIALIZER(name,1)
@@ -76,9 +69,6 @@
 	unsigned long flags;
 	int failed;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	/* atomically decrement the semaphores count, and if its negative, we wait */
@@ -102,9 +92,6 @@
 	unsigned long flags;
 	int failed;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	/* atomically decrement the semaphores count, and if its negative, we wait */
@@ -122,10 +109,6 @@
 	unsigned long flags;
 	int failed;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	local_save_flags(flags);
 	local_irq_disable();
 	failed = --(sem->count.counter) < 0;
@@ -146,10 +129,6 @@
 	unsigned long flags;
 	int wakeup;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	/* atomically increment the semaphores count, and if it was negative, we wake people */
 	local_save_flags(flags);
 	local_irq_disable();
Index: mm4-2.6.8.1/include/asm-h8300/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-h8300/semaphore.h	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/include/asm-h8300/semaphore.h	2004-08-24 13:16:10.001763795 -0700
@@ -26,21 +26,14 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -87,9 +80,6 @@
 {
 	register atomic_t *count asm("er0");
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	count = &(sem->count);
@@ -116,9 +106,6 @@
 {
 	register atomic_t *count asm("er0");
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	count = &(sem->count);
@@ -147,10 +134,6 @@
 {
 	register atomic_t *count asm("er0");
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	count = &(sem->count);
 	__asm__ __volatile__(
 		"stc ccr,r3l\n\t"
@@ -187,10 +170,6 @@
 {
 	register atomic_t *count asm("er0");
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	count = &(sem->count);
 	__asm__ __volatile__(
 		"stc ccr,r3l\n\t"
Index: mm4-2.6.8.1/include/asm-i386/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-i386/semaphore.h	2004-08-14 03:55:09.000000000 -0700
+++ mm4-2.6.8.1/include/asm-i386/semaphore.h	2004-08-24 13:17:16.696098916 -0700
@@ -45,21 +45,15 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
 
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -81,9 +75,6 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (int)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -113,9 +104,6 @@
  */
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
@@ -139,9 +127,6 @@
 {
 	int result;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
@@ -167,10 +152,6 @@
 {
 	int result;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
@@ -195,9 +176,6 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
 		LOCK "incl %0\n\t"     /* ++sem->count */
Index: mm4-2.6.8.1/include/asm-ia64/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-ia64/semaphore.h	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/include/asm-ia64/semaphore.h	2004-08-24 14:03:57.562275543 -0700
@@ -15,21 +15,13 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;		/* initialized by __SEM_DEBUG_INIT() */
-#endif
 };
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)		, (long) &(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count)					\
-{										\
-	ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-	__SEM_DEBUG_INIT(name)							\
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
 #define __MUTEX_INITIALIZER(name)	__SEMAPHORE_INITIALIZER(name,1)
@@ -70,9 +62,6 @@
 static inline void
 down (struct semaphore *sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		__down(sem);
@@ -87,9 +76,6 @@
 {
 	int ret = 0;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_interruptible(sem);
@@ -101,9 +87,6 @@
 {
 	int ret = 0;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_trylock(sem);
 	return ret;
@@ -112,9 +95,6 @@
 static inline void
 up (struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	if (atomic_inc_return(&sem->count) <= 0)
 		__up(sem);
 }
Index: mm4-2.6.8.1/include/asm-m68k/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-m68k/semaphore.h	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/include/asm-m68k/semaphore.h	2004-08-24 13:19:17.357230250 -0700
@@ -27,21 +27,14 @@
 	atomic_t count;
 	atomic_t waking;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.waking		= ATOMIC_INIT(0),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -86,9 +79,6 @@
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__asm__ __volatile__(
 		"| atomic down operation\n\t"
@@ -109,9 +99,6 @@
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__asm__ __volatile__(
 		"| atomic interruptible down operation\n\t"
@@ -134,10 +121,6 @@
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__asm__ __volatile__(
 		"| atomic down trylock operation\n\t"
 		"subql #1,%1@\n\t"
@@ -164,10 +147,6 @@
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__asm__ __volatile__(
 		"| atomic up operation\n\t"
 		"addql #1,%0@\n\t"
Index: mm4-2.6.8.1/include/asm-m68knommu/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-m68knommu/semaphore.h	2004-08-14 03:55:34.000000000 -0700
+++ mm4-2.6.8.1/include/asm-m68knommu/semaphore.h	2004-08-24 13:18:25.314262138 -0700
@@ -26,21 +26,14 @@
 	atomic_t count;
 	atomic_t waking;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.waking		= ATOMIC_INIT(0),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -85,9 +78,6 @@
  */
 extern inline void down(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__asm__ __volatile__(
 		"| atomic down operation\n\t"
@@ -105,9 +95,6 @@
 {
 	int ret;
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	__asm__ __volatile__(
 		"| atomic down operation\n\t"
@@ -128,10 +115,6 @@
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
 
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__asm__ __volatile__(
 		"| atomic down trylock operation\n\t"
 		"subql #1,%1@\n\t"
@@ -157,10 +140,6 @@
  */
 extern inline void up(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__asm__ __volatile__(
 		"| atomic up operation\n\t"
 		"movel	%0, %%a1\n\t"
Index: mm4-2.6.8.1/include/asm-mips/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-mips/semaphore.h	2004-08-14 03:55:19.000000000 -0700
+++ mm4-2.6.8.1/include/asm-mips/semaphore.h	2004-08-24 13:20:10.099417104 -0700
@@ -37,22 +37,13 @@
 	 */
 	atomic_t count;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	  __SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name, 1)
@@ -67,9 +58,6 @@
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -88,9 +76,6 @@
 
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	/*
@@ -104,9 +89,6 @@
 {
 	int ret = 0;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	if (unlikely(atomic_dec_return(&sem->count) < 0))
@@ -116,19 +98,11 @@
 
 static inline int down_trylock(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	return atomic_dec_if_positive(&sem->count) < 0;
 }
 
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	if (unlikely(atomic_inc_return(&sem->count) <= 0))
 		__up(sem);
 }
Index: mm4-2.6.8.1/include/asm-parisc/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-parisc/semaphore.h	2004-08-14 03:54:46.000000000 -0700
+++ mm4-2.6.8.1/include/asm-parisc/semaphore.h	2004-08-24 13:21:04.951955495 -0700
@@ -40,21 +40,14 @@
 	spinlock_t	sentry;
 	int		count;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ SPIN_LOCK_UNLOCKED, count, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.sentry		= SPIN_LOCK_UNLOCKED,				\
+	.count		= n,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -95,9 +88,6 @@
 
 extern __inline__ void down(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	spin_lock_irq(&sem->sentry);
 	if (sem->count > 0) {
@@ -111,9 +101,6 @@
 extern __inline__ int down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 	spin_lock_irq(&sem->sentry);
 	if (sem->count > 0) {
@@ -132,9 +119,6 @@
 extern __inline__ int down_trylock(struct semaphore * sem)
 {
 	int flags, count;
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 
 	spin_lock_irqsave(&sem->sentry, flags);
 	count = sem->count - 1;
@@ -151,9 +135,6 @@
 extern __inline__ void up(struct semaphore * sem)
 {
 	int flags;
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	spin_lock_irqsave(&sem->sentry, flags);
 	if (sem->count < 0) {
 		__up(sem);
Index: mm4-2.6.8.1/include/asm-ppc/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-ppc/semaphore.h	2004-08-14 03:55:33.000000000 -0700
+++ mm4-2.6.8.1/include/asm-ppc/semaphore.h	2004-08-24 13:22:53.375782292 -0700
@@ -29,22 +29,13 @@
 	 */
 	atomic_t count;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	  __SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name, 1)
@@ -59,9 +50,6 @@
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -80,9 +68,6 @@
 
 extern inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	/*
@@ -97,9 +82,6 @@
 {
 	int ret = 0;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	if (atomic_dec_return(&sem->count) < 0)
@@ -112,10 +94,6 @@
 {
 	int ret;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	ret = atomic_dec_if_positive(&sem->count) < 0;
 	smp_wmb();
 	return ret;
@@ -123,10 +101,6 @@
 
 extern inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	smp_wmb();
 	if (atomic_inc_return(&sem->count) <= 0)
 		__up(sem);
Index: mm4-2.6.8.1/include/asm-ppc64/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-ppc64/semaphore.h	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/include/asm-ppc64/semaphore.h	2004-08-24 13:22:02.968556347 -0700
@@ -23,22 +23,13 @@
 	 */
 	atomic_t count;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	  __SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name, 1)
@@ -53,9 +44,6 @@
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -74,9 +62,6 @@
 
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	/*
@@ -90,9 +75,6 @@
 {
 	int ret = 0;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	if (unlikely(atomic_dec_return(&sem->count) < 0))
@@ -102,19 +84,11 @@
 
 static inline int down_trylock(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	return atomic_dec_if_positive(&sem->count) < 0;
 }
 
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	if (unlikely(atomic_inc_return(&sem->count) <= 0))
 		__up(sem);
 }
Index: mm4-2.6.8.1/include/asm-sh/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-sh/semaphore.h	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/include/asm-sh/semaphore.h	2004-08-24 13:24:49.772265241 -0700
@@ -24,21 +24,14 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -60,9 +53,6 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (int)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -91,10 +81,6 @@
 
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		__down(sem);
@@ -103,9 +89,6 @@
 static inline int down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 
 	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
@@ -116,9 +99,6 @@
 static inline int down_trylock(struct semaphore * sem)
 {
 	int ret = 0;
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_trylock(sem);
@@ -131,9 +111,6 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	if (atomic_inc_return(&sem->count) <= 0)
 		__up(sem);
 }
Index: mm4-2.6.8.1/include/asm-sh64/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-sh64/semaphore.h	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/include/asm-sh64/semaphore.h	2004-08-24 13:23:53.169726872 -0700
@@ -31,21 +31,14 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -67,9 +60,6 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (int)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -98,10 +88,6 @@
 
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	if (atomic_dec_return(&sem->count) < 0)
 		__down(sem);
 }
@@ -109,9 +95,6 @@
 static inline int down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_interruptible(sem);
@@ -121,9 +104,6 @@
 static inline int down_trylock(struct semaphore * sem)
 {
 	int ret = 0;
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_trylock(sem);
@@ -136,9 +116,6 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	if (atomic_inc_return(&sem->count) <= 0)
 		__up(sem);
 }
Index: mm4-2.6.8.1/include/asm-sparc/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-sparc/semaphore.h	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/include/asm-sparc/semaphore.h	2004-08-24 13:25:53.080858215 -0700
@@ -13,21 +13,14 @@
 	atomic24_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC24_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC24_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -43,9 +36,6 @@
 	atomic24_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -68,9 +58,6 @@
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	ptr = &(sem->count.counter);
@@ -105,9 +92,6 @@
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	ptr = &(sem->count.counter);
@@ -145,10 +129,6 @@
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	ptr = &(sem->count.counter);
 	increment = 1;
 
@@ -184,10 +164,6 @@
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	ptr = &(sem->count.counter);
 	increment = 1;
 
Index: mm4-2.6.8.1/include/asm-x86_64/semaphore.h
===================================================================
--- mm4-2.6.8.1.orig/include/asm-x86_64/semaphore.h	2004-08-14 03:54:46.000000000 -0700
+++ mm4-2.6.8.1/include/asm-x86_64/semaphore.h	2004-08-24 13:27:26.352341448 -0700
@@ -47,21 +47,14 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
 };
 
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
 
 #define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
@@ -83,9 +76,6 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#ifdef WAITQUEUE_DEBUG
-	sem->__magic = (int)&sem->__magic;
-#endif
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -115,9 +105,6 @@
  */
 static inline void down(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	__asm__ __volatile__(
@@ -142,9 +129,6 @@
 {
 	int result;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	might_sleep();
 
 	__asm__ __volatile__(
@@ -171,10 +155,6 @@
 {
 	int result;
 
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
@@ -199,9 +179,6 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#ifdef WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
 		LOCK "incl %0\n\t"     /* ++sem->count */
