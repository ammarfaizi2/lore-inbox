Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVBQDSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVBQDSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 22:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVBQDSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 22:18:42 -0500
Received: from mail.renesas.com ([202.234.163.13]:62378 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262200AbVBQDSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 22:18:21 -0500
Date: Thu, 17 Feb 2005 12:18:09 +0900 (JST)
Message-Id: <20050217.121809.1044957935.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.11-rc4] m32r: build fix for SMP kernel
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to fix compile errors of 2.6.11-rc4 for the m32r SMP kernel.
I think this patch should be included in 2.6.11.
Please apply.

	* include/asm-m32r/spinlock.h:
	- Add read_can_lock() and write_can_lock() to fix build errors for SMP.
	- Rename 'lock' to 'slock'. (cf. Changesets 1.1966.85.1)

	* arch/m32r/kernel/smp.c:
	- Rename 'lock' to 'slock'. (cf. Changesets 1.1966.85.1)

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/smp.c      |    2 -
 include/asm-m32r/spinlock.h |   68 ++++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 34 deletions(-)


diff -ruNp a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
--- a/arch/m32r/kernel/smp.c	2005-02-16 20:57:19.000000000 +0900
+++ b/arch/m32r/kernel/smp.c	2005-02-16 21:19:35.000000000 +0900
@@ -953,7 +953,7 @@ unsigned long send_IPI_mask_phys(cpumask
 		"ldi	r4, #1			\n\t"
 		"st	r4, @%2			\n\t"
 		: "=&r"(ipicr_val)
-		: "r"(flags), "r"(&ipilock->lock), "r"(ipicr_addr),
+		: "r"(flags), "r"(&ipilock->slock), "r"(ipicr_addr),
 		  "r"(mask), "r"(try), "r"(my_physid_mask)
 		: "memory", "r4"
 #ifdef CONFIG_CHIP_M32700_TS1
diff -ruNp a/include/asm-m32r/spinlock.h b/include/asm-m32r/spinlock.h
--- a/include/asm-m32r/spinlock.h	2005-02-16 20:58:08.000000000 +0900
+++ b/include/asm-m32r/spinlock.h	2005-02-16 21:19:35.000000000 +0900
@@ -20,23 +20,13 @@ extern int printk(const char * fmt, ...)
 #define RW_LOCK_BIAS		 0x01000000
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
-/* It seems that people are forgetting to
- * initialize their spinlocks properly, tsk tsk.
- * Remember to turn this off in 2.4. -ben
- */
-#if defined(CONFIG_DEBUG_SPINLOCK)
-#define SPINLOCK_DEBUG	1
-#else
-#define SPINLOCK_DEBUG	0
-#endif
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
 
 typedef struct {
-	volatile int lock;
-#if SPINLOCK_DEBUG
+	volatile int slock;
+#ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
 #ifdef CONFIG_PREEMPT
@@ -46,7 +36,7 @@ typedef struct {
 
 #define SPINLOCK_MAGIC	0xdead4ead
 
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
 #else
 #define SPINLOCK_MAGIC_INIT	/* */
@@ -63,7 +53,7 @@ typedef struct {
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile int *)(&(x)->lock) <= 0)
+#define spin_is_locked(x)	(*(volatile int *)(&(x)->slock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
@@ -80,11 +70,11 @@ static inline int _raw_spin_trylock(spin
 	unsigned long tmp1, tmp2;
 
 	/*
-	 * lock->lock :  =1 : unlock
-	 *            : <=0 : lock
+	 * lock->slock :  =1 : unlock
+	 *             : <=0 : lock
 	 * {
-	 *   oldval = lock->lock; <--+ need atomic operation
-	 *   lock->lock = 0;      <--+
+	 *   oldval = lock->slock; <--+ need atomic operation
+	 *   lock->slock = 0;      <--+
 	 * }
 	 */
 	__asm__ __volatile__ (
@@ -97,7 +87,7 @@ static inline int _raw_spin_trylock(spin
 		"unlock	%1, @%3;		\n\t"
 		"mvtc	%2, psw;		\n\t"
 		: "=&r" (oldval), "=&r" (tmp1), "=&r" (tmp2)
-		: "r" (&lock->lock)
+		: "r" (&lock->slock)
 		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r6"
@@ -111,22 +101,22 @@ static inline void _raw_spin_lock(spinlo
 {
 	unsigned long tmp0, tmp1;
 
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	__label__ here;
 here:
 	if (lock->magic != SPINLOCK_MAGIC) {
-		printk("eip: %p\n", &&here);
+		printk("pc: %p\n", &&here);
 		BUG();
 	}
 #endif
 	/*
-	 * lock->lock :  =1 : unlock
-	 *            : <=0 : lock
+	 * lock->slock :  =1 : unlock
+	 *             : <=0 : lock
 	 *
 	 * for ( ; ; ) {
-	 *   lock->lock -= 1;  <-- need atomic operation
-	 *   if (lock->lock == 0) break;
-	 *   for ( ; lock->lock <= 0 ; );
+	 *   lock->slock -= 1;  <-- need atomic operation
+	 *   if (lock->slock == 0) break;
+	 *   for ( ; lock->slock <= 0 ; );
 	 * }
 	 */
 	__asm__ __volatile__ (
@@ -149,7 +139,7 @@ here:
 		"bra	2b;			\n\t"
 		LOCK_SECTION_END
 		: "=&r" (tmp0), "=&r" (tmp1)
-		: "r" (&lock->lock)
+		: "r" (&lock->slock)
 		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r6"
@@ -159,12 +149,12 @@ here:
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(lock->magic != SPINLOCK_MAGIC);
 	BUG_ON(!spin_is_locked(lock));
 #endif
 	mb();
-	lock->lock = 1;
+	lock->slock = 1;
 }
 
 /*
@@ -179,7 +169,7 @@ static inline void _raw_spin_unlock(spin
  */
 typedef struct {
 	volatile int lock;
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
 #ifdef CONFIG_PREEMPT
@@ -189,7 +179,7 @@ typedef struct {
 
 #define RWLOCK_MAGIC	0xdeaf1eed
 
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
 #else
 #define RWLOCK_MAGIC_INIT	/* */
@@ -199,6 +189,18 @@ typedef struct {
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
+/**
+ * read_can_lock - would read_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define read_can_lock(x) ((int)(x)->lock > 0)
+
+/**
+ * write_can_lock - would write_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
+
 /*
  * On x86, we implement read-write locks as a 32-bit counter
  * with the high bit (sign) being the "contended" bit.
@@ -214,7 +216,7 @@ static inline void _raw_read_lock(rwlock
 {
 	unsigned long tmp0, tmp1;
 
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(rw->magic != RWLOCK_MAGIC);
 #endif
 	/*
@@ -268,7 +270,7 @@ static inline void _raw_write_lock(rwloc
 {
 	unsigned long tmp0, tmp1, tmp2;
 
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(rw->magic != RWLOCK_MAGIC);
 #endif
 	/*

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
