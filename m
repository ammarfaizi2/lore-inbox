Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVCPTdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVCPTdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVCPTdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:33:51 -0500
Received: from [205.233.219.253] ([205.233.219.253]:26764 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262763AbVCPTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:30:29 -0500
Date: Wed, 16 Mar 2005 14:27:09 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       willy@debian.org, nathans@sgi.com
Subject: [PATCH, RFC 1/4] Rename semaphore count variable to be arch specific
Message-ID: <20050316192709.GZ1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <20050311053144.GP1111@conscoop.ottawa.on.ca> <20050310215652.76c47856.akpm@osdl.org> <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk> <20050311170449.GS1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311170449.GS1111@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 12:04:49PM -0500, Jody McIntyre wrote:

> Therefore I propose:
> 
> 1. Adding sem_getcount() everywhere, as in my original patch.
> 2. Renaming count to count_$ARCH as willy suggested.
> 3. Anyone who abuses semaphores will now break.  Fix them to use
>    sem_getcount().

OK, here it is.  Tested 3. with 'make allyesconfig' on i386 to be sure
I've caught all abuses.

--

Rename semaphore "count" members to count_$ARCH, to emphasize that this is
an opaque type and sem_getcount() should be used to retrieve the current
up() count.

Tested on i386, ia64, parisc.  More testing would be good.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

 arch/sparc64/kernel/semaphore.c   |   36 ++++++++++++++++++------------------
 include/asm-alpha/semaphore.h     |   22 +++++++++++-----------
 include/asm-arm/semaphore.h       |   17 ++++++-----------
 include/asm-arm26/semaphore.h     |    6 +++---
 include/asm-cris/semaphore.h      |   12 ++++++------
 include/asm-frv/semaphore.h       |    5 -----
 include/asm-h8300/semaphore.h     |   12 ++++++------
 include/asm-i386/semaphore.h      |   22 +++++++++++-----------
 include/asm-ia64/semaphore.h      |   12 ++++++------
 include/asm-m32r/semaphore.h      |   14 +++++++-------
 include/asm-m68k/semaphore.h      |    4 ++--
 include/asm-m68knommu/semaphore.h |   12 ++++++------
 include/asm-mips/semaphore.h      |   14 +++++++-------
 include/asm-parisc/semaphore.h    |    5 -----
 include/asm-ppc/semaphore.h       |   14 +++++++-------
 include/asm-ppc64/semaphore.h     |   14 +++++++-------
 include/asm-s390/semaphore.h      |   12 ++++++------
 include/asm-sh/semaphore.h        |   14 +++++++-------
 include/asm-sh64/semaphore.h      |   14 +++++++-------
 include/asm-sparc/semaphore.h     |   14 +++++++-------
 include/asm-sparc64/semaphore.h   |    4 ++--
 include/asm-v850/semaphore.h      |   10 +++++-----
 include/asm-x86_64/semaphore.h    |   20 ++++++++++----------
 23 files changed, 147 insertions(+), 162 deletions(-)

Index: 1394-dev/include/asm-h8300/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-h8300/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-h8300/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -23,14 +23,14 @@
 
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_h8300;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_h8300		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -82,7 +82,7 @@ static inline void down(struct semaphore
 
 	might_sleep();
 
-	count = &(sem->count);
+	count = &(sem->count_h8300);
 	__asm__ __volatile__(
 		"stc ccr,r3l\n\t"
 		"orc #0x80,ccr\n\t"
@@ -108,7 +108,7 @@ static inline int down_interruptible(str
 
 	might_sleep();
 
-	count = &(sem->count);
+	count = &(sem->count_h8300);
 	__asm__ __volatile__(
 		"stc ccr,r1l\n\t"
 		"orc #0x80,ccr\n\t"
@@ -134,7 +134,7 @@ static inline int down_trylock(struct se
 {
 	register atomic_t *count asm("er0");
 
-	count = &(sem->count);
+	count = &(sem->count_h8300);
 	__asm__ __volatile__(
 		"stc ccr,r3l\n\t"
 		"orc #0x80,ccr\n\t"
@@ -170,7 +170,7 @@ static inline void up(struct semaphore *
 {
 	register atomic_t *count asm("er0");
 
-	count = &(sem->count);
+	count = &(sem->count_h8300);
 	__asm__ __volatile__(
 		"stc ccr,r3l\n\t"
 		"orc #0x80,ccr\n\t"
Index: 1394-dev/arch/sparc64/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/sparc64/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/sparc64/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -11,12 +11,12 @@
 #include <linux/init.h>
 
 /*
- * Atomically update sem->count.
+ * Atomically update sem->count_sparc64.
  * This does the equivalent of the following:
  *
- *	old_count = sem->count;
+ *	old_count = sem->count_sparc64;
  *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
+ *	sem->count_sparc64 = tmp;
  *	return old_count;
  */
 static __inline__ int __sem_update_count(struct semaphore *sem, int incr)
@@ -24,7 +24,7 @@ static __inline__ int __sem_update_count
 	int old_count, tmp;
 
 	__asm__ __volatile__("\n"
-"	! __sem_update_count old_count(%0) tmp(%1) incr(%4) &sem->count(%3)\n"
+"	! __sem_update_count old_count(%0) tmp(%1) incr(%4) &sem->count_sparc64(%3)\n"
 "1:	ldsw	[%3], %0\n"
 "	mov	%0, %1\n"
 "	cmp	%0, 0\n"
@@ -34,8 +34,8 @@ static __inline__ int __sem_update_count
 "	cmp	%0, %1\n"
 "	bne,pn	%%icc, 1b\n"
 "	 membar #StoreLoad | #StoreStore\n"
-	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-	: "r" (&sem->count), "r" (incr), "m" (sem->count)
+	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count_sparc64)
+	: "r" (&sem->count_sparc64), "r" (incr), "m" (sem->count_sparc64)
 	: "cc");
 
 	return old_count;
@@ -50,9 +50,9 @@ static void __up(struct semaphore *sem)
 void up(struct semaphore *sem)
 {
 	/* This atomically does:
-	 * 	old_val = sem->count;
-	 *	new_val = sem->count + 1;
-	 *	sem->count = new_val;
+	 * 	old_val = sem->count_sparc64;
+	 *	new_val = sem->count_sparc64 + 1;
+	 *	sem->count_sparc64 = new_val;
 	 *	if (old_val < 0)
 	 *		__up(sem);
 	 *
@@ -113,9 +113,9 @@ void __sched down(struct semaphore *sem)
 {
 	might_sleep();
 	/* This atomically does:
-	 * 	old_val = sem->count;
-	 *	new_val = sem->count - 1;
-	 *	sem->count = new_val;
+	 * 	old_val = sem->count_sparc64;
+	 *	new_val = sem->count_sparc64 - 1;
+	 *	sem->count_sparc64 = new_val;
 	 *	if (old_val < 1)
 	 *		__down(sem);
 	 *
@@ -158,12 +158,12 @@ int down_trylock(struct semaphore *sem)
 	int ret;
 
 	/* This atomically does:
-	 * 	old_val = sem->count;
-	 *	new_val = sem->count - 1;
+	 * 	old_val = sem->count_sparc64;
+	 *	new_val = sem->count_sparc64 - 1;
 	 *	if (old_val < 1) {
 	 *		ret = 1;
 	 *	} else {
-	 *		sem->count = new_val;
+	 *		sem->count_sparc64 = new_val;
 	 *		ret = 0;
 	 *	}
 	 *
@@ -223,9 +223,9 @@ int __sched down_interruptible(struct se
 	
 	might_sleep();
 	/* This atomically does:
-	 * 	old_val = sem->count;
-	 *	new_val = sem->count - 1;
-	 *	sem->count = new_val;
+	 * 	old_val = sem->count_sparc64;
+	 *	new_val = sem->count_sparc64 - 1;
+	 *	sem->count_sparc64 = new_val;
 	 *	if (old_val < 1)
 	 *		ret = __down_interruptible(sem);
 	 *
Index: 1394-dev/include/asm-sh64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sh64/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-sh64/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -28,14 +28,14 @@
 #include <asm/atomic.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_sh64;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_sh64	= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -57,7 +57,7 @@ static inline void sema_init (struct sem
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
  */
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_sh64, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
@@ -88,7 +88,7 @@ extern spinlock_t semaphore_wake_lock;
 
 static inline void down(struct semaphore * sem)
 {
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_sh64) < 0)
 		__down(sem);
 }
 
@@ -96,7 +96,7 @@ static inline int down_interruptible(str
 {
 	int ret = 0;
 
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_sh64) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
 }
@@ -105,7 +105,7 @@ static inline int down_trylock(struct se
 {
 	int ret = 0;
 
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_sh64) < 0)
 		ret = __down_trylock(sem);
 	return ret;
 }
@@ -116,7 +116,7 @@ static inline int down_trylock(struct se
  */
 static inline void up(struct semaphore * sem)
 {
-	if (atomic_inc_return(&sem->count) <= 0)
+	if (atomic_inc_return(&sem->count_sh64) <= 0)
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-m68knommu/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m68knommu/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-m68knommu/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -23,16 +23,16 @@
 
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_m68knommu;
 	atomic_t waking;
 	wait_queue_head_t wait;
 };
 
-#define __SEMAPHORE_INITIALIZER(name, n)				\
-{									\
-	.count		= ATOMIC_INIT(n),				\
-	.waking		= ATOMIC_INIT(0),				\
-	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+#define __SEMAPHORE_INITIALIZER(name, n)					\
+{										\
+	.count_m68knommu	= ATOMIC_INIT(n),				\
+	.waking			= ATOMIC_INIT(0),				\
+	.wait			= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
 #define __MUTEX_INITIALIZER(name) \
Index: 1394-dev/include/asm-m32r/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m32r/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-m32r/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -20,14 +20,14 @@
 #include <asm/atomic.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_m32r;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_m32r		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -49,7 +49,7 @@ static inline void sema_init (struct sem
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
  */
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_m32r, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
@@ -92,7 +92,7 @@ static inline void down(struct semaphore
 		"addi	%0, #-1;		\n\t"
 		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
-		: "r" (&sem->count)
+		: "r" (&sem->count_m32r)
 		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r4"
@@ -123,7 +123,7 @@ static inline int down_interruptible(str
 		"addi	%0, #-1;		\n\t"
 		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
-		: "r" (&sem->count)
+		: "r" (&sem->count_m32r)
 		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r4"
@@ -155,7 +155,7 @@ static inline int down_trylock(struct se
 		"addi	%0, #-1;		\n\t"
 		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
-		: "r" (&sem->count)
+		: "r" (&sem->count_m32r)
 		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r4"
@@ -188,7 +188,7 @@ static inline void up(struct semaphore *
 		"addi	%0, #1;			\n\t"
 		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
-		: "r" (&sem->count)
+		: "r" (&sem->count_m32r)
 		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r4"
Index: 1394-dev/include/asm-ia64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ia64/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-ia64/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -12,14 +12,14 @@
 #include <asm/atomic.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_ia64;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_ia64	= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -63,7 +63,7 @@ static inline void
 down (struct semaphore *sem)
 {
 	might_sleep();
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_ia64) < 0)
 		__down(sem);
 }
 
@@ -77,7 +77,7 @@ down_interruptible (struct semaphore * s
 	int ret = 0;
 
 	might_sleep();
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_ia64) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
 }
@@ -87,7 +87,7 @@ down_trylock (struct semaphore *sem)
 {
 	int ret = 0;
 
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_ia64) < 0)
 		ret = __down_trylock(sem);
 	return ret;
 }
@@ -95,7 +95,7 @@ down_trylock (struct semaphore *sem)
 static inline void
 up (struct semaphore * sem)
 {
-	if (atomic_inc_return(&sem->count) <= 0)
+	if (atomic_inc_return(&sem->count_ia64) <= 0)
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-i386/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-i386/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-i386/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -42,7 +42,7 @@
 #include <linux/rwsem.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_i386;
 	int sleepers;
 	wait_queue_head_t wait;
 };
@@ -50,7 +50,7 @@ struct semaphore {
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_i386	= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -72,7 +72,7 @@ static inline void sema_init (struct sem
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
  */
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_i386, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
@@ -107,7 +107,7 @@ static inline void down(struct semaphore
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
-		LOCK "decl %0\n\t"     /* --sem->count */
+		LOCK "decl %0\n\t"     /* --sem->count_i386 */
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
@@ -115,7 +115,7 @@ static inline void down(struct semaphore
 		"call __down_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=m" (sem->count)
+		:"=m" (sem->count_i386)
 		:
 		:"memory","ax");
 }
@@ -131,7 +131,7 @@ static inline int down_interruptible(str
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK "decl %1\n\t"     /* --sem->count_i386 */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -140,7 +140,7 @@ static inline int down_interruptible(str
 		"call __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=a" (result), "=m" (sem->count_i386)
 		:
 		:"memory");
 	return result;
@@ -156,7 +156,7 @@ static inline int down_trylock(struct se
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK "decl %1\n\t"     /* --sem->count_i386 */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -165,7 +165,7 @@ static inline int down_trylock(struct se
 		"call __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=a" (result), "=m" (sem->count_i386)
 		:
 		:"memory");
 	return result;
@@ -181,7 +181,7 @@ static inline void up(struct semaphore *
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
-		LOCK "incl %0\n\t"     /* ++sem->count */
+		LOCK "incl %0\n\t"     /* ++sem->count_i386 */
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
@@ -190,7 +190,7 @@ static inline void up(struct semaphore *
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		".subsection 0\n"
-		:"=m" (sem->count)
+		:"=m" (sem->count_i386)
 		:
 		:"memory","ax");
 }
Index: 1394-dev/include/asm-sparc/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sparc/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-sparc/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -10,14 +10,14 @@
 #include <linux/rwsem.h>
 
 struct semaphore {
-	atomic24_t count;
+	atomic24_t count_sparc;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC24_INIT(n),				\
+	.count_sparc		= ATOMIC24_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -33,7 +33,7 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic24_set(&sem->count, val);
+	atomic24_set(&sem->count_sparc, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
@@ -60,7 +60,7 @@ static inline void down(struct semaphore
 
 	might_sleep();
 
-	ptr = &(sem->count.counter);
+	ptr = &(sem->count_sparc.counter);
 	increment = 1;
 
 	__asm__ __volatile__(
@@ -94,7 +94,7 @@ static inline int down_interruptible(str
 
 	might_sleep();
 
-	ptr = &(sem->count.counter);
+	ptr = &(sem->count_sparc.counter);
 	increment = 1;
 
 	__asm__ __volatile__(
@@ -129,7 +129,7 @@ static inline int down_trylock(struct se
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
 
-	ptr = &(sem->count.counter);
+	ptr = &(sem->count_sparc.counter);
 	increment = 1;
 
 	__asm__ __volatile__(
@@ -164,7 +164,7 @@ static inline void up(struct semaphore *
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
 
-	ptr = &(sem->count.counter);
+	ptr = &(sem->count_sparc.counter);
 	increment = 1;
 
 	__asm__ __volatile__(
Index: 1394-dev/include/asm-x86_64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-x86_64/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-x86_64/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -44,14 +44,14 @@
 #include <linux/stringify.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_x86_64;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_x86_64	= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -73,7 +73,7 @@ static inline void sema_init (struct sem
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
  */
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_x86_64, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
@@ -116,7 +116,7 @@ static inline void down(struct semaphore
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=m" (sem->count)
+		:"=m" (sem->count_x86_64)
 		:"D" (sem)
 		:"memory");
 }
@@ -133,7 +133,7 @@ static inline int down_interruptible(str
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK "decl %1\n\t"     /* --sem->count_x86_64 */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -141,7 +141,7 @@ static inline int down_interruptible(str
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=a" (result), "=m" (sem->count_x86_64)
 		:"D" (sem)
 		:"memory");
 	return result;
@@ -157,7 +157,7 @@ static inline int down_trylock(struct se
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK "decl %1\n\t"     /* --sem->count_x86_64 */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -165,7 +165,7 @@ static inline int down_trylock(struct se
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=a" (result), "=m" (sem->count_x86_64)
 		:"D" (sem)
 		:"memory","cc");
 	return result;
@@ -181,14 +181,14 @@ static inline void up(struct semaphore *
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
-		LOCK "incl %0\n\t"     /* ++sem->count */
+		LOCK "incl %0\n\t"     /* ++sem->count_x86_64 */
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=m" (sem->count)
+		:"=m" (sem->count_x86_64)
 		:"D" (sem)
 		:"memory");
 }
Index: 1394-dev/include/asm-ppc/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ppc/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-ppc/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -27,13 +27,13 @@ struct semaphore {
 	 * but additionally indicates that some process(es) might be
 	 * sleeping on `wait'.
 	 */
-	atomic_t count;
+	atomic_t count_ppc;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_ppc	= ATOMIC_INIT(n),				\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
@@ -48,7 +48,7 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_ppc, val);
 	init_waitqueue_head(&sem->wait);
 }
 
@@ -73,7 +73,7 @@ extern inline void down(struct semaphore
 	/*
 	 * Try to get the semaphore, take the slow path if we fail.
 	 */
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_ppc) < 0)
 		__down(sem);
 	smp_wmb();
 }
@@ -84,7 +84,7 @@ extern inline int down_interruptible(str
 
 	might_sleep();
 
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_ppc) < 0)
 		ret = __down_interruptible(sem);
 	smp_wmb();
 	return ret;
@@ -94,7 +94,7 @@ extern inline int down_trylock(struct se
 {
 	int ret;
 
-	ret = atomic_dec_if_positive(&sem->count) < 0;
+	ret = atomic_dec_if_positive(&sem->count_ppc) < 0;
 	smp_wmb();
 	return ret;
 }
@@ -102,7 +102,7 @@ extern inline int down_trylock(struct se
 extern inline void up(struct semaphore * sem)
 {
 	smp_wmb();
-	if (atomic_inc_return(&sem->count) <= 0)
+	if (atomic_inc_return(&sem->count_ppc) <= 0)
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-ppc64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ppc64/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-ppc64/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -21,13 +21,13 @@ struct semaphore {
 	 * but additionally indicates that some process(es) might be
 	 * sleeping on `wait'.
 	 */
-	atomic_t count;
+	atomic_t count_ppc64;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_ppc64	= ATOMIC_INIT(n),				\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
@@ -42,7 +42,7 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_ppc64, val);
 	init_waitqueue_head(&sem->wait);
 }
 
@@ -67,7 +67,7 @@ static inline void down(struct semaphore
 	/*
 	 * Try to get the semaphore, take the slow path if we fail.
 	 */
-	if (unlikely(atomic_dec_return(&sem->count) < 0))
+	if (unlikely(atomic_dec_return(&sem->count_ppc64) < 0))
 		__down(sem);
 }
 
@@ -77,19 +77,19 @@ static inline int down_interruptible(str
 
 	might_sleep();
 
-	if (unlikely(atomic_dec_return(&sem->count) < 0))
+	if (unlikely(atomic_dec_return(&sem->count_ppc64) < 0))
 		ret = __down_interruptible(sem);
 	return ret;
 }
 
 static inline int down_trylock(struct semaphore * sem)
 {
-	return atomic_dec_if_positive(&sem->count) < 0;
+	return atomic_dec_if_positive(&sem->count_ppc64) < 0;
 }
 
 static inline void up(struct semaphore * sem)
 {
-	if (unlikely(atomic_inc_return(&sem->count) <= 0))
+	if (unlikely(atomic_inc_return(&sem->count_ppc64) <= 0))
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-arm26/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-arm26/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-arm26/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -13,14 +13,14 @@
 #include <asm/locks.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_arm;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INIT(name, n)					\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_arm	= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
@@ -36,7 +36,7 @@ struct semaphore {
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_arm, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
Index: 1394-dev/include/asm-s390/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-s390/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-s390/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -22,7 +22,7 @@ struct semaphore {
 	 * but additionally indicates that some process(es) might be
 	 * sleeping on `wait'.
 	 */
-	atomic_t count;
+	atomic_t count_s390;
 	wait_queue_head_t wait;
 };
 
@@ -61,7 +61,7 @@ asmlinkage void __up(struct semaphore * 
 static inline void down(struct semaphore * sem)
 {
 	might_sleep();
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_s390) < 0)
 		__down(sem);
 }
 
@@ -70,7 +70,7 @@ static inline int down_interruptible(str
 	int ret = 0;
 
 	might_sleep();
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_s390) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
 }
@@ -95,15 +95,15 @@ static inline int down_trylock(struct se
 		"   cs   %0,%1,0(%3)\n"
 		"   jl   0b\n"
 		"1:"
-		: "=&d" (old_val), "=&d" (new_val), "=m" (sem->count.counter)
-		: "a" (&sem->count.counter), "m" (sem->count.counter)
+		: "=&d" (old_val), "=&d" (new_val), "=m" (sem->count_s390.counter)
+		: "a" (&sem->count_s390.counter), "m" (sem->count_s390.counter)
 		: "cc", "memory" );
 	return old_val <= 0;
 }
 
 static inline void up(struct semaphore * sem)
 {
-	if (atomic_inc_return(&sem->count) <= 0)
+	if (atomic_inc_return(&sem->count_s390) <= 0)
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-m68k/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m68k/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-m68k/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -24,14 +24,14 @@
 
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_m68k;
 	atomic_t waking;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_m68k	= ATOMIC_INIT(n),				\
 	.waking		= ATOMIC_INIT(0),				\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
Index: 1394-dev/include/asm-arm/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-arm/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-arm/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -13,15 +13,15 @@
 #include <asm/locks.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_arm;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
-#define __SEMAPHORE_INIT(name, cnt)				\
-{								\
-	.count	= ATOMIC_INIT(cnt),				\
-	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+#define __SEMAPHORE_INIT(name, cnt)					\
+{									\
+	.count_arm	= ATOMIC_INIT(cnt),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
 
 #define __MUTEX_INITIALIZER(name) __SEMAPHORE_INIT(name,1)
@@ -34,7 +34,7 @@ struct semaphore {
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_arm, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
Index: 1394-dev/include/asm-sparc64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sparc64/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-sparc64/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -14,7 +14,7 @@
 #include <linux/rwsem.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_sparc64;
 	wait_queue_head_t wait;
 };
 
@@ -33,7 +33,7 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_sparc64, val);
 	init_waitqueue_head(&sem->wait);
 }
 
Index: 1394-dev/include/asm-sh/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sh/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-sh/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -21,14 +21,14 @@
 #include <asm/atomic.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_sh;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_sh	= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
@@ -50,7 +50,7 @@ static inline void sema_init (struct sem
  * i'd rather use the more flexible initialization above, but sadly
  * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
  */
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_sh, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
@@ -82,7 +82,7 @@ extern spinlock_t semaphore_wake_lock;
 static inline void down(struct semaphore * sem)
 {
 	might_sleep();
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_sh) < 0)
 		__down(sem);
 }
 
@@ -91,7 +91,7 @@ static inline int down_interruptible(str
 	int ret = 0;
 
 	might_sleep();
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_sh) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
 }
@@ -100,7 +100,7 @@ static inline int down_trylock(struct se
 {
 	int ret = 0;
 
-	if (atomic_dec_return(&sem->count) < 0)
+	if (atomic_dec_return(&sem->count_sh) < 0)
 		ret = __down_trylock(sem);
 	return ret;
 }
@@ -111,7 +111,7 @@ static inline int down_trylock(struct se
  */
 static inline void up(struct semaphore * sem)
 {
-	if (atomic_inc_return(&sem->count) <= 0)
+	if (atomic_inc_return(&sem->count_sh) <= 0)
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-mips/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-mips/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-mips/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -35,13 +35,13 @@ struct semaphore {
 	 * but additionally indicates that some process(es) might be
 	 * sleeping on `wait'.
 	 */
-	atomic_t count;
+	atomic_t count_mips;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_mips	= ATOMIC_INIT(n),				\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
@@ -56,7 +56,7 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_mips, val);
 	init_waitqueue_head(&sem->wait);
 }
 
@@ -81,7 +81,7 @@ static inline void down(struct semaphore
 	/*
 	 * Try to get the semaphore, take the slow path if we fail.
 	 */
-	if (unlikely(atomic_dec_return(&sem->count) < 0))
+	if (unlikely(atomic_dec_return(&sem->count_mips) < 0))
 		__down(sem);
 }
 
@@ -91,19 +91,19 @@ static inline int down_interruptible(str
 
 	might_sleep();
 
-	if (unlikely(atomic_dec_return(&sem->count) < 0))
+	if (unlikely(atomic_dec_return(&sem->count_mips) < 0))
 		ret = __down_interruptible(sem);
 	return ret;
 }
 
 static inline int down_trylock(struct semaphore * sem)
 {
-	return atomic_dec_if_positive(&sem->count) < 0;
+	return atomic_dec_if_positive(&sem->count_mips) < 0;
 }
 
 static inline void up(struct semaphore * sem)
 {
-	if (unlikely(atomic_inc_return(&sem->count) <= 0))
+	if (unlikely(atomic_inc_return(&sem->count_mips) <= 0))
 		__up(sem);
 }
 
Index: 1394-dev/include/asm-alpha/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-alpha/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-alpha/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -16,14 +16,14 @@
 #include <linux/rwsem.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_alpha;
 	wait_queue_head_t wait;
 };
 
-#define __SEMAPHORE_INITIALIZER(name, n)			\
-{								\
-	.count	= ATOMIC_INIT(n),				\
-  	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count_alpha	= ATOMIC_INIT(n),				\
+  	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
 
 #define __MUTEX_INITIALIZER(name)			\
@@ -43,7 +43,7 @@ static inline void sema_init(struct sema
 	 * except that gcc produces better initializing by parts yet.
 	 */
 
-	atomic_set(&sem->count, val);
+	atomic_set(&sem->count_alpha, val);
 	init_waitqueue_head(&sem->wait);
 }
 
@@ -75,7 +75,7 @@ static inline void __down(struct semapho
 {
 	long count;
 	might_sleep();
-	count = atomic_dec_return(&sem->count);
+	count = atomic_dec_return(&sem->count_alpha);
 	if (unlikely(count < 0))
 		__down_failed(sem);
 }
@@ -84,7 +84,7 @@ static inline int __down_interruptible(s
 {
 	long count;
 	might_sleep();
-	count = atomic_dec_return(&sem->count);
+	count = atomic_dec_return(&sem->count_alpha);
 	if (unlikely(count < 0))
 		return __down_failed_interruptible(sem);
 	return 0;
@@ -119,15 +119,15 @@ static inline int __down_trylock(struct 
 		".subsection 2\n"
 		"3:	br	1b\n"
 		".previous"
-		: "=&r" (ret), "=m" (sem->count)
-		: "m" (sem->count));
+		: "=&r" (ret), "=m" (sem->count_alpha)
+		: "m" (sem->count_alpha));
 
 	return ret < 0;
 }
 
 static inline void __up(struct semaphore *sem)
 {
-	if (unlikely(atomic_inc_return(&sem->count) <= 0))
+	if (unlikely(atomic_inc_return(&sem->count_alpha) <= 0))
 		__up_wakeup(sem);
 }
 
Index: 1394-dev/include/asm-frv/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-frv/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-frv/semaphore.h	2005-03-15 17:26:42.000000000 -0500
@@ -71,6 +71,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return sem->count_frv;
+}
+
 extern void __down(struct semaphore *sem, unsigned long flags);
 extern int  __down_interruptible(struct semaphore *sem, unsigned long flags);
 extern void __up(struct semaphore *sem);
@@ -151,11 +156,6 @@ static inline void up(struct semaphore *
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
 }
 
-static inline int sem_getcount(struct semaphore *sem)
-{
-	return sem->counter;
-}
-
 #endif /* __ASSEMBLY__ */
 
 #endif
Index: 1394-dev/include/asm-cris/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-cris/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-cris/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -21,14 +21,14 @@
 int printk(const char *fmt, ...);
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_cris;
 	atomic_t waking;
 	wait_queue_head_t wait;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
-	.count		= ATOMIC_INIT(n),				\
+	.count_cris	= ATOMIC_INIT(n),				\
 	.waking		= ATOMIC_INIT(0),				\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
 }
@@ -74,7 +74,7 @@ extern inline void down(struct semaphore
 	/* atomically decrement the semaphores count, and if its negative, we wait */
 	local_save_flags(flags);
 	local_irq_disable();
-	failed = --(sem->count.counter) < 0;
+	failed = --(sem->count_cris.counter) < 0;
 	local_irq_restore(flags);
 	if(failed) {
 		__down(sem);
@@ -97,7 +97,7 @@ extern inline int down_interruptible(str
 	/* atomically decrement the semaphores count, and if its negative, we wait */
 	local_save_flags(flags);
 	local_irq_disable();
-	failed = --(sem->count.counter) < 0;
+	failed = --(sem->count_cris.counter) < 0;
 	local_irq_restore(flags);
 	if(failed)
 		failed = __down_interruptible(sem);
@@ -111,7 +111,7 @@ extern inline int down_trylock(struct se
 
 	local_save_flags(flags);
 	local_irq_disable();
-	failed = --(sem->count.counter) < 0;
+	failed = --(sem->count_cris.counter) < 0;
 	local_irq_restore(flags);
 	if(failed)
 		failed = __down_trylock(sem);
@@ -132,7 +132,7 @@ extern inline void up(struct semaphore *
 	/* atomically increment the semaphores count, and if it was negative, we wake people */
 	local_save_flags(flags);
 	local_irq_disable();
-	wakeup = ++(sem->count.counter) <= 0;
+	wakeup = ++(sem->count_cris.counter) <= 0;
 	local_irq_restore(flags);
 	if(wakeup) {
 		__up(sem);
Index: 1394-dev/include/asm-v850/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-v850/semaphore.h	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/include/asm-v850/semaphore.h	2005-03-15 17:29:24.000000000 -0500
@@ -9,7 +9,7 @@
 #include <asm/atomic.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic_t count_v850;
 	int sleepers;
 	wait_queue_head_t wait;
 };
@@ -58,7 +58,7 @@ extern void __up (struct semaphore * sem
 extern inline void down (struct semaphore * sem)
 {
 	might_sleep();
-	if (atomic_dec_return (&sem->count) < 0)
+	if (atomic_dec_return (&sem->count_v850) < 0)
 		__down (sem);
 }
 
@@ -66,7 +66,7 @@ extern inline int down_interruptible (st
 {
 	int ret = 0;
 	might_sleep();
-	if (atomic_dec_return (&sem->count) < 0)
+	if (atomic_dec_return (&sem->count_v850) < 0)
 		ret = __down_interruptible (sem);
 	return ret;
 }
@@ -74,14 +74,14 @@ extern inline int down_interruptible (st
 extern inline int down_trylock (struct semaphore *sem)
 {
 	int ret = 0;
-	if (atomic_dec_return (&sem->count) < 0)
+	if (atomic_dec_return (&sem->count_v850) < 0)
 		ret = __down_trylock (sem);
 	return ret;
 }
 
 extern inline void up (struct semaphore * sem)
 {
-	if (atomic_inc_return (&sem->count) <= 0)
+	if (atomic_inc_return (&sem->count_v850) <= 0)
 		__up (sem);
 }
 
Index: 1394-dev/arch/i386/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/i386/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/i386/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -73,7 +73,7 @@ fastcall void __sched __down(struct sema
 		 * playing, because we own the spinlock in
 		 * the wait_queue_head.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_i386)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -116,7 +116,7 @@ fastcall int __sched __down_interruptibl
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_i386);
 			break;
 		}
 
@@ -126,7 +126,7 @@ fastcall int __sched __down_interruptibl
 		 * wait_queue_head. The "-1" is because we're
 		 * still hoping to get the semaphore.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_i386)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -168,7 +168,7 @@ fastcall int __down_trylock(struct semap
 	 * playing, because we own the spinlock in the
 	 * wait_queue_head.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count)) {
+	if (!atomic_add_negative(sleepers, &sem->count_i386)) {
 		wake_up_locked(&sem->wait);
 	}
 
Index: 1394-dev/arch/mips/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/mips/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/mips/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -24,16 +24,16 @@
 #include <asm/semaphore.h>
 #include <asm/war.h>
 /*
- * Atomically update sem->count.
+ * Atomically update sem->count_mips.
  * This does the equivalent of the following:
  *
- *	old_count = sem->count;
+ *	old_count = sem->count_mips;
  *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
+ *	sem->count_mips = tmp;
  *	return old_count;
  *
  * On machines without lld/scd we need a spinlock to make the manipulation of
- * sem->count and sem->waking atomic.  Scalability isn't an issue because
+ * sem->count_mips and sem->waking atomic.  Scalability isn't an issue because
  * this lock is used on UP only so it's just an empty variable.
  */
 static inline int __sem_update_count(struct semaphore *sem, int incr)
@@ -49,8 +49,8 @@ static inline int __sem_update_count(str
 		"	add	%1, %1, %3				\n"
 		"	sc	%1, %2					\n"
 		"	beqzl	%1, 1b					\n"
-		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-		: "r" (incr), "m" (sem->count));
+		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count_mips)
+		: "r" (incr), "m" (sem->count_mips));
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
 		"1:	ll	%0, %2					\n"
@@ -60,16 +60,16 @@ static inline int __sem_update_count(str
 		"	add	%1, %1, %3				\n"
 		"	sc	%1, %2					\n"
 		"	beqz	%1, 1b					\n"
-		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-		: "r" (incr), "m" (sem->count));
+		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count_mips)
+		: "r" (incr), "m" (sem->count_mips));
 	} else {
 		static DEFINE_SPINLOCK(semaphore_lock);
 		unsigned long flags;
 
 		spin_lock_irqsave(&semaphore_lock, flags);
-		old_count = atomic_read(&sem->count);
+		old_count = atomic_read(&sem->count_mips);
 		tmp = max_t(int, old_count, 0) + incr;
-		atomic_set(&sem->count, tmp);
+		atomic_set(&sem->count_mips, tmp);
 		spin_unlock_irqrestore(&semaphore_lock, flags);
 	}
 
@@ -144,7 +144,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			/*
 			 * A signal is pending - give up trying.
-			 * Set sem->count to 0 if it is negative,
+			 * Set sem->count_mips to 0 if it is negative,
 			 * since we are no longer sleeping.
 			 */
 			__sem_update_count(sem, 0);
Index: 1394-dev/arch/arm/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/arm/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/arm/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -72,7 +72,7 @@ void __sched __down(struct semaphore * s
 		 * Add "everybody else" into it. They aren't
 		 * playing, because we own the spinlock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_arm)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -112,7 +112,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_arm);
 			break;
 		}
 
@@ -122,7 +122,7 @@ int __sched __down_interruptible(struct 
 		 * "-1" is because we're still hoping to get
 		 * the lock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_arm)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -161,7 +161,7 @@ int __down_trylock(struct semaphore * se
 	 * Add "everybody else" and us into it. They aren't
 	 * playing, because we own the spinlock.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count))
+	if (!atomic_add_negative(sleepers, &sem->count_arm))
 		wake_up(&sem->wait);
 
 	spin_unlock_irqrestore(&semaphore_lock, flags);
Index: 1394-dev/arch/m68knommu/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/m68knommu/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/m68knommu/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -75,8 +75,8 @@ void __up(struct semaphore *sem)
 	add_wait_queue(&sem->wait, &wait);				\
 									\
 	/*								\
-	 * Ok, we're set up.  sem->count is known to be less than zero	\
-	 * so we must wait.						\
+	 * Ok, we're set up.  sem->count_m68knommu is known to be less	\
+	 * than zero so we must wait.					\
 	 *								\
 	 * We can let go the lock for purposes of waiting.		\
 	 * We re-acquire it after awaking so as to protect		\
Index: 1394-dev/arch/alpha/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/alpha/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/alpha/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -16,12 +16,12 @@
  */
 
 /*
- * Atomically update sem->count.
+ * Atomically update sem->count_alpha.
  * This does the equivalent of the following:
  *
- *	old_count = sem->count;
+ *	old_count = sem->count_alpha;
  *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
+ *	sem->count_alpha = tmp;
  *	return old_count;
  */
 static inline int __sem_update_count(struct semaphore *sem, int incr)
@@ -38,8 +38,8 @@ static inline int __sem_update_count(str
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
-	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-	: "Ir" (incr), "1" (tmp), "m" (sem->count));
+	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count_alpha)
+	: "Ir" (incr), "1" (tmp), "m" (sem->count_alpha));
 
 	return old_count;
 }
@@ -169,7 +169,7 @@ down(struct semaphore *sem)
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down(%p) <count=%d> from %p\n",
 	       current->comm, current->pid, sem,
-	       atomic_read(&sem->count), __builtin_return_address(0));
+	       atomic_read(&sem->count_alpha), __builtin_return_address(0));
 #endif
 	__down(sem);
 }
@@ -183,7 +183,7 @@ down_interruptible(struct semaphore *sem
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down(%p) <count=%d> from %p\n",
 	       current->comm, current->pid, sem,
-	       atomic_read(&sem->count), __builtin_return_address(0));
+	       atomic_read(&sem->count_alpha), __builtin_return_address(0));
 #endif
 	return __down_interruptible(sem);
 }
@@ -218,7 +218,7 @@ up(struct semaphore *sem)
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): up(%p) <count=%d> from %p\n",
 	       current->comm, current->pid, sem,
-	       atomic_read(&sem->count), __builtin_return_address(0));
+	       atomic_read(&sem->count_alpha), __builtin_return_address(0));
 #endif
 	__up(sem);
 }
Index: 1394-dev/arch/s390/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/s390/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/s390/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -16,10 +16,10 @@
 #include <asm/semaphore.h>
 
 /*
- * Atomically update sem->count. Equivalent to:
- *   old_val = sem->count.counter;
+ * Atomically update sem->count_s390. Equivalent to:
+ *   old_val = sem->count_s390.counter;
  *   new_val = ((old_val >= 0) ? old_val : 0) + incr;
- *   sem->count.counter = new_val;
+ *   sem->count_s390.counter = new_val;
  *   return old_val;
  */
 static inline int __sem_update_count(struct semaphore *sem, int incr)
@@ -34,8 +34,8 @@ static inline int __sem_update_count(str
                              "   cs    %0,%1,0(%3)\n"
                              "   jl    0b\n"
                              : "=&d" (old_val), "=&d" (new_val),
-			       "=m" (sem->count)
-			     : "a" (&sem->count), "d" (incr), "m" (sem->count)
+			       "=m" (sem->count_s390)
+			     : "a" (&sem->count_s390), "d" (incr), "m" (sem->count_s390)
 			     : "cc" );
 	return old_val;
 }
Index: 1394-dev/arch/h8300/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/h8300/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/h8300/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -74,8 +74,8 @@ void __up(struct semaphore *sem)
 	add_wait_queue(&sem->wait, &wait);				\
 									\
 	/*								\
-	 * Ok, we're set up.  sem->count is known to be less than zero	\
-	 * so we must wait.						\
+	 * Ok, we're set up.  sem->count_h8300 is known to be less than	\
+	 * zero so we must wait.					\
 	 *								\
 	 * We can let go the lock for purposes of waiting.		\
 	 * We re-acquire it after awaking so as to protect		\
Index: 1394-dev/arch/sh/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/sh/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/sh/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -82,8 +82,8 @@ void __up(struct semaphore *sem)
 	add_wait_queue(&sem->wait, &wait);				\
 									\
 	/*								\
-	 * Ok, we're set up.  sem->count is known to be less than zero	\
-	 * so we must wait.						\
+	 * Ok, we're set up.  sem->count_sh is known to be less than	\
+	 * zero so we must wait.					\
 	 *								\
 	 * We can let go the lock for purposes of waiting.		\
 	 * We re-acquire it after awaking so as to protect		\
Index: 1394-dev/arch/m68k/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/m68k/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/m68k/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -74,8 +74,8 @@ void __up(struct semaphore *sem)
 	add_wait_queue(&sem->wait, &wait);				\
 									\
 	/*								\
-	 * Ok, we're set up.  sem->count is known to be less than zero	\
-	 * so we must wait.						\
+	 * Ok, we're set up.  sem->count_m68k is known to be less than	\
+	 * zero so we must wait.					\
 	 *								\
 	 * We can let go the lock for purposes of waiting.		\
 	 * We re-acquire it after awaking so as to protect		\
Index: 1394-dev/arch/ia64/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/ia64/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/ia64/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -64,7 +64,7 @@ void __sched __down (struct semaphore *s
 		 * playing, because we own the spinlock in
 		 * the wait_queue_head.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_ia64)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -107,7 +107,7 @@ int __sched __down_interruptible (struct
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_ia64);
 			break;
 		}
 
@@ -117,7 +117,7 @@ int __sched __down_interruptible (struct
 		 * wait_queue_head. The "-1" is because we're
 		 * still hoping to get the semaphore.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_ia64)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -156,7 +156,7 @@ __down_trylock (struct semaphore *sem)
 	 * playing, because we own the spinlock in the
 	 * wait_queue_head.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count)) {
+	if (!atomic_add_negative(sleepers, &sem->count_ia64)) {
 		wake_up_locked(&sem->wait);
 	}
 
Index: 1394-dev/arch/cris/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/cris/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/cris/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -73,8 +73,8 @@ void __up(struct semaphore *sem)
 	add_wait_queue(&sem->wait, &wait);				\
 									\
 	/*								\
-	 * Ok, we're set up.  sem->count is known to be less than zero	\
-	 * so we must wait.						\
+	 * Ok, we're set up.  sem->count_cris is known to be less than	\
+	 * zero so we must wait.					\
 	 *								\
 	 * We can let go the lock for purposes of waiting.		\
 	 * We re-acquire it after awaking so as to protect		\
Index: 1394-dev/arch/sh64/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/sh64/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/sh64/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -83,8 +83,8 @@ void __up(struct semaphore *sem)
 	add_wait_queue(&sem->wait, &wait);				\
 									\
 	/*								\
-	 * Ok, we're set up.  sem->count is known to be less than zero	\
-	 * so we must wait.						\
+	 * Ok, we're set up.  sem->count_sh64 is known to be less than	\
+	 * zero so we must wait.					\
 	 *								\
 	 * We can let go the lock for purposes of waiting.		\
 	 * We re-acquire it after awaking so as to protect		\
Index: 1394-dev/arch/ppc64/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/ppc64/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/ppc64/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -25,12 +25,12 @@
 #include <asm/errno.h>
 
 /*
- * Atomically update sem->count.
+ * Atomically update sem->count_ppc64.
  * This does the equivalent of the following:
  *
- *	old_count = sem->count;
+ *	old_count = sem->count_ppc64;
  *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
+ *	sem->count_ppc64 = tmp;
  *	return old_count;
  */
 static inline int __sem_update_count(struct semaphore *sem, int incr)
@@ -44,8 +44,8 @@ static inline int __sem_update_count(str
 "	add	%1,%1,%4\n"
 "	stwcx.	%1,0,%3\n"
 "	bne	1b"
-	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-	: "r" (&sem->count), "r" (incr), "m" (sem->count)
+	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count_ppc64)
+	: "r" (&sem->count_ppc64), "r" (incr), "m" (sem->count_ppc64)
 	: "cc");
 
 	return old_count;
@@ -117,7 +117,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			/*
 			 * A signal is pending - give up trying.
-			 * Set sem->count to 0 if it is negative,
+			 * Set sem->count_ppc64 to 0 if it is negative,
 			 * since we are no longer sleeping.
 			 */
 			__sem_update_count(sem, 0);
Index: 1394-dev/arch/ppc/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/ppc/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/ppc/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -21,12 +21,12 @@
 #include <asm/errno.h>
 
 /*
- * Atomically update sem->count.
+ * Atomically update sem->count_ppc.
  * This does the equivalent of the following:
  *
- *	old_count = sem->count;
+ *	old_count = sem->count_ppc;
  *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
+ *	sem->count_ppc = tmp;
  *	return old_count;
  */
 static inline int __sem_update_count(struct semaphore *sem, int incr)
@@ -41,8 +41,8 @@ static inline int __sem_update_count(str
 	PPC405_ERR77(0,%3)
 "	stwcx.	%1,0,%3\n"
 "	bne	1b"
-	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-	: "r" (&sem->count), "r" (incr), "m" (sem->count)
+	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count_ppc)
+	: "r" (&sem->count_ppc), "r" (incr), "m" (sem->count_ppc)
 	: "cc");
 
 	return old_count;
@@ -114,7 +114,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			/*
 			 * A signal is pending - give up trying.
-			 * Set sem->count to 0 if it is negative,
+			 * Set sem->count_ppc to 0 if it is negative,
 			 * since we are no longer sleeping.
 			 */
 			__sem_update_count(sem, 0);
Index: 1394-dev/arch/v850/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/v850/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/v850/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -73,7 +73,7 @@ void __sched __down(struct semaphore * s
 		 * Add "everybody else" into it. They aren't
 		 * playing, because we own the spinlock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_v850)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -113,7 +113,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_v850);
 			break;
 		}
 
@@ -123,7 +123,7 @@ int __sched __down_interruptible(struct 
 		 * "-1" is because we're still hoping to get
 		 * the lock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_v850)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -158,7 +158,7 @@ int __down_trylock(struct semaphore * se
 	 * Add "everybody else" and us into it. They aren't
 	 * playing, because we own the spinlock.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count))
+	if (!atomic_add_negative(sleepers, &sem->count_v850))
 		wake_up(&sem->wait);
 
 	spin_unlock_irqrestore(&semaphore_lock, flags);
Index: 1394-dev/arch/m32r/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/m32r/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/m32r/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -82,7 +82,7 @@ asmlinkage void __sched __down(struct se
 		 * playing, because we own the spinlock in
 		 * the wait_queue_head.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_m32r)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -125,7 +125,7 @@ asmlinkage int __sched __down_interrupti
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_m32r);
 			break;
 		}
 
@@ -135,7 +135,7 @@ asmlinkage int __sched __down_interrupti
 		 * wait_queue_head. The "-1" is because we're
 		 * still hoping to get the semaphore.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_m32r)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -177,7 +177,7 @@ asmlinkage int __down_trylock(struct sem
 	 * playing, because we own the spinlock in the
 	 * wait_queue_head.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count)) {
+	if (!atomic_add_negative(sleepers, &sem->count_m32r)) {
 		wake_up_locked(&sem->wait);
 	}
 
Index: 1394-dev/arch/arm26/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/arm26/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/arm26/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -74,7 +74,7 @@ void __sched __down(struct semaphore * s
 		 * Add "everybody else" into it. They aren't
 		 * playing, because we own the spinlock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_arm26)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -114,7 +114,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_arm26);
 			break;
 		}
 
@@ -124,7 +124,7 @@ int __sched __down_interruptible(struct 
 		 * "-1" is because we're still hoping to get
 		 * the lock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_arm26)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -163,7 +163,7 @@ int __down_trylock(struct semaphore * se
 	 * Add "everybody else" and us into it. They aren't
 	 * playing, because we own the spinlock.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count))
+	if (!atomic_add_negative(sleepers, &sem->count_arm26))
 		wake_up(&sem->wait);
 
 	spin_unlock_irqrestore(&semaphore_lock, flags);
Index: 1394-dev/arch/x86_64/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/x86_64/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/x86_64/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -74,7 +74,7 @@ void __sched __down(struct semaphore * s
 		 * playing, because we own the spinlock in
 		 * the wait_queue_head.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_x86_64)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -117,7 +117,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic_add(sleepers, &sem->count_x86_64);
 			break;
 		}
 
@@ -127,7 +127,7 @@ int __sched __down_interruptible(struct 
 		 * wait_queue_head. The "-1" is because we're
 		 * still hoping to get the semaphore.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic_add_negative(sleepers - 1, &sem->count_x86_64)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -169,7 +169,7 @@ int __down_trylock(struct semaphore * se
 	 * playing, because we own the spinlock in the
 	 * wait_queue_head.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count)) {
+	if (!atomic_add_negative(sleepers, &sem->count_x86_64)) {
 		wake_up_locked(&sem->wait);
 	}
 
Index: 1394-dev/arch/sparc/kernel/semaphore.c
===================================================================
--- 1394-dev.orig/arch/sparc/kernel/semaphore.c	2005-03-15 17:24:10.000000000 -0500
+++ 1394-dev/arch/sparc/kernel/semaphore.c	2005-03-15 17:24:16.000000000 -0500
@@ -62,7 +62,7 @@ void __sched __down(struct semaphore * s
 		 * Add "everybody else" into it. They aren't
 		 * playing, because we own the spinlock.
 		 */
-		if (!atomic24_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic24_add_negative(sleepers - 1, &sem->count_sparc)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -102,7 +102,7 @@ int __sched __down_interruptible(struct 
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic24_add(sleepers, &sem->count);
+			atomic24_add(sleepers, &sem->count_sparc);
 			break;
 		}
 
@@ -112,7 +112,7 @@ int __sched __down_interruptible(struct 
 		 * "-1" is because we're still hoping to get
 		 * the lock.
 		 */
-		if (!atomic24_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic24_add_negative(sleepers - 1, &sem->count_sparc)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -147,7 +147,7 @@ int __down_trylock(struct semaphore * se
 	 * Add "everybody else" and us into it. They aren't
 	 * playing, because we own the spinlock.
 	 */
-	if (!atomic24_add_negative(sleepers, &sem->count))
+	if (!atomic24_add_negative(sleepers, &sem->count_sparc))
 		wake_up(&sem->wait);
 
 	spin_unlock_irqrestore(&semaphore_lock, flags);
