Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSJNHOt>; Mon, 14 Oct 2002 03:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSJNHOt>; Mon, 14 Oct 2002 03:14:49 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:37131 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id <S261854AbSJNHOm> convert rfc822-to-8bit;
	Mon, 14 Oct 2002 03:14:42 -0400
Message-ID: <000501c27355$3c40f6a0$5fa864c2@windows>
From: "Matti Annala" <gval@mbnet.fi>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/asm-*/spinlock.h cleanup
Date: Mon, 14 Oct 2002 10:42:21 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-OriginalArrivalTime: 14 Oct 2002 08:17:10.0146 (UTC) FILETIME=[17B00E20:01C2735A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the spinlock.h headers in some of the include/asm-* folders more readable by removing redundant defines and simplifying the #ifdef logic a bit.

diff -ur --strip-trailing-cr difflinux/include/asm-i386/spinlock.h linux-2.5.41/include/asm-i386/spinlock.h
--- difflinux/include/asm-i386/spinlock.h 2002-10-08 22:31:00.000000000 +0300
+++ linux-2.5.41/include/asm-i386/spinlock.h 2002-10-09 22:32:20.000000000 +0300
@@ -23,13 +23,11 @@
 #define SPINLOCK_MAGIC 0xdead4ead
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT , SPINLOCK_MAGIC
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1, SPINLOCK_MAGIC }
 #else
-#define SPINLOCK_MAGIC_INIT /* */
+#define SPIN_LOCK_UNLOCKED (spinlock_t) 1
 #endif
 
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
 #define spin_lock_init(x) do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 
 /*
@@ -61,32 +59,17 @@
  */
  
 #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
-
 #define spin_unlock_string \
  "movb $1,%0" \
   :"=m" (lock->lock) : : "memory"
-
-
-static inline void _raw_spin_unlock(spinlock_t *lock)
-{
-#ifdef CONFIG_DEBUG_SPINLOCK
- if (lock->magic != SPINLOCK_MAGIC)
-  BUG();
- if (!spin_is_locked(lock))
-  BUG();
-#endif
- __asm__ __volatile__(
-  spin_unlock_string
- );
-}
-
 #else
-
 #define spin_unlock_string \
  "xchgb %b0, %1" \
   :"=q" (oldval), "=m" (lock->lock) \
   :"0" (oldval) : "memory"
+#endif
 
+/* oldval is optimized away by compiler when not needed */
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
  char oldval = 1;
@@ -101,8 +84,6 @@
  );
 }
 
-#endif
-
 static inline int _raw_spin_trylock(spinlock_t *lock)
 {
  char oldval;
@@ -149,13 +130,11 @@
 #define RWLOCK_MAGIC 0xdeaf1eed
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT , RWLOCK_MAGIC
+#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS, RWLOCK_MAGIC }
 #else
-#define RWLOCK_MAGIC_INIT /* */
+#define RW_LOCK_UNLOCKED (rwlock_t) RW_LOCK_BIAS
 #endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
@@ -189,7 +168,7 @@
  __build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)  asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
+#define _raw_read_unlock(rw) asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
 #define _raw_write_unlock(rw) asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
 static inline int _raw_write_trylock(rwlock_t *lock)

diff -ur --strip-trailing-cr difflinux/include/asm-ia64/spinlock.h linux-2.5.41/include/asm-ia64/spinlock.h
--- difflinux/include/asm-ia64/spinlock.h 2002-10-09 23:20:24.000000000 +0300
+++ linux-2.5.41/include/asm-ia64/spinlock.h 2002-10-09 22:41:02.000000000 +0300
@@ -17,14 +17,18 @@
 
 #undef NEW_LOCK
 
-#ifdef NEW_LOCK
-
 typedef struct {
  volatile unsigned int lock;
 } spinlock_t;
 
-#define SPIN_LOCK_UNLOCKED   (spinlock_t) { 0 }
-#define spin_lock_init(x)   ((x)->lock = 0)
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#define spin_lock_init(x) ((x)->lock = 0)
+#define spin_is_locked(x) ((x)->lock != 0)
+#define _raw_spin_unlock(x) do { barrier(); ((spinlock_t *) x)->lock = 0;} while (0)
+#define spin_unlock_wait(x) do { barrier(); } while ((x)->lock)
+
+
+#ifdef NEW_LOCK
 
 /*
  * Streamlined test_and_set_bit(0, (x)).  We use test-and-test-and-set
@@ -49,31 +53,20 @@
   : "ar.ccv", "ar.pfs", "b7", "p15", "r28", "r29", "r30", "memory"); \
 }
 
-#define _raw_spin_trylock(x)        \
-({           \
- register long result;        \
-           \
- __asm__ __volatile__ (        \
-  "mov ar.ccv=r0\n"       \
-  ";;\n"         \
-  "cmpxchg4.acq %0=[%2],%1,ar.ccv\n"     \
-  : "=r"(result) : "r"(1), "r"(&(x)->lock) : "ar.ccv", "memory");  \
- (result == 0);         \
+#define _raw_spin_trylock(x)       \
+({          \
+ register long result;       \
+          \
+ __asm__ __volatile__ (       \
+  "mov ar.ccv=r0\n"      \
+  ";;\n"        \
+  "cmpxchg4.acq %0=[%2],%1,ar.ccv\n"    \
+  : "=r"(result) : "r"(1), "r"(&(x)->lock) : "ar.ccv", "memory"); \
+ (result == 0);        \
 })
 
-#define spin_is_locked(x) ((x)->lock != 0)
-#define _raw_spin_unlock(x) do { barrier(); ((spinlock_t *) x)->lock = 0;} while (0)
-#define spin_unlock_wait(x) do { barrier(); } while ((x)->lock)
-
 #else /* !NEW_LOCK */
 
-typedef struct {
- volatile unsigned int lock;
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED   (spinlock_t) { 0 }
-#define spin_lock_init(x)   ((x)->lock = 0)
-
 /*
  * Streamlined test_and_set_bit(0, (x)).  We use test-and-test-and-set
  * rather than a simple xchg to avoid writing the cache-line when
@@ -95,10 +88,7 @@
  ";;\n"       \
  :: "r"(&(x)->lock) : "ar.ccv", "p7", "r2", "r29", "memory")
 
-#define spin_is_locked(x) ((x)->lock != 0)
-#define _raw_spin_unlock(x) do { barrier(); ((spinlock_t *) x)->lock = 0; } while (0)
 #define _raw_spin_trylock(x) (cmpxchg_acq(&(x)->lock, 0, 1) == 0)
-#define spin_unlock_wait(x) do { barrier(); } while ((x)->lock)
 
 #endif /* !NEW_LOCK */
 
@@ -111,59 +101,60 @@
 #define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x) (*(volatile int *) (x) != 0)
 
-#define _raw_read_lock(rw)       \
-do {          \
- int tmp = 0;        \
- __asm__ __volatile__ ("1:\tfetchadd4.acq %0 = [%1], 1\n"  \
-         ";;\n"      \
-         "tbit.nz p6,p0 = %0, 31\n"   \
-         "(p6) br.cond.sptk.few 2f\n"   \
-         ".section .text.lock,\"ax\"\n"   \
-         "2:\tfetchadd4.rel %0 = [%1], -1\n"  \
-         ";;\n"      \
-         "3:\tld4.acq %0 = [%1]\n"    \
-         ";;\n"      \
-         "tbit.nz p6,p0 = %0, 31\n"   \
-         "(p6) br.cond.sptk.few 3b\n"   \
-         "br.cond.sptk.few 1b\n"    \
-         ";;\n"      \
-         ".previous\n"     \
-         : "=&r" (tmp)     \
-         : "r" (rw) : "p6", "memory");   \
+#define _raw_read_lock(rw)      \
+do {         \
+ int tmp = 0;       \
+ __asm__ __volatile__ ("1:\tfetchadd4.acq %0 = [%1], 1\n" \
+         ";;\n"     \
+         "tbit.nz p6,p0 = %0, 31\n"  \
+         "(p6) br.cond.sptk.few 2f\n"  \
+         ".section .text.lock,\"ax\"\n"  \
+         "2:\tfetchadd4.rel %0 = [%1], -1\n" \
+         ";;\n"     \
+         "3:\tld4.acq %0 = [%1]\n"   \
+         ";;\n"     \
+         "tbit.nz p6,p0 = %0, 31\n"  \
+         "(p6) br.cond.sptk.few 3b\n"  \
+         "br.cond.sptk.few 1b\n"   \
+         ";;\n"     \
+         ".previous\n"    \
+         : "=&r" (tmp)    \
+         : "r" (rw) : "p6", "memory");  \
 } while(0)
 
-#define _raw_read_unlock(rw)       \
-do {          \
- int tmp = 0;        \
- __asm__ __volatile__ ("fetchadd4.rel %0 = [%1], -1\n"   \
-         : "=r" (tmp)     \
-         : "r" (rw)     \
-         : "memory");     \
+#define _raw_read_unlock(rw)     \
+do {        \
+ int tmp = 0;      \
+ __asm__ __volatile__ ("fetchadd4.rel %0 = [%1], -1\n" \
+         : "=r" (tmp)   \
+         : "r" (rw)   \
+         : "memory");   \
 } while(0)
 
-#define _raw_write_lock(rw)       \
-do {          \
-  __asm__ __volatile__ (       \
-  "mov ar.ccv = r0\n"      \
-  "dep r29 = -1, r0, 31, 1\n"     \
-  ";;\n"        \
-  "1:\n"        \
-  "ld4 r2 = [%0]\n"      \
-  ";;\n"        \
-  "cmp4.eq p0,p7 = r0,r2\n"     \
-  "(p7) br.cond.spnt.few 1b \n"     \
-  "cmpxchg4.acq r2 = [%0], r29, ar.ccv\n"    \
-  ";;\n"        \
-  "cmp4.eq p0,p7 = r0, r2\n"     \
-  "(p7) br.cond.spnt.few 1b\n"     \
-  ";;\n"        \
-  :: "r"(rw) : "ar.ccv", "p7", "r2", "r29", "memory");  \
+#define _raw_write_lock(rw)      \
+do {         \
+  __asm__ __volatile__ (      \
+  "mov ar.ccv = r0\n"     \
+  "dep r29 = -1, r0, 31, 1\n"    \
+  ";;\n"       \
+  "1:\n"       \
+  "ld4 r2 = [%0]\n"     \
+  ";;\n"       \
+  "cmp4.eq p0,p7 = r0,r2\n"    \
+  "(p7) br.cond.spnt.few 1b \n"    \
+  "cmpxchg4.acq r2 = [%0], r29, ar.ccv\n"   \
+  ";;\n"       \
+  "cmp4.eq p0,p7 = r0, r2\n"    \
+  "(p7) br.cond.spnt.few 1b\n"    \
+  ";;\n"       \
+  :: "r"(rw) : "ar.ccv", "p7", "r2", "r29", "memory"); \
 } while(0)
 
-#define _raw_write_unlock(x)        \
-({           \
- smp_mb__before_clear_bit(); /* need barrier before releasing lock... */ \
- clear_bit(31, (x));        \
+#define _raw_write_unlock(x)    \
+({       \
+ /* need barrier before releasing lock... */ \          \
+ smp_mb__before_clear_bit();   \
+ clear_bit(31, (x));    \
 })
 
 #endif /*  _ASM_IA64_SPINLOCK_H */

diff -ur --strip-trailing-cr difflinux/include/asm-ppc/spinlock.h linux-2.5.41/include/asm-ppc/spinlock.h
--- difflinux/include/asm-ppc/spinlock.h 2002-10-09 22:48:40.000000000 +0300
+++ linux-2.5.41/include/asm-ppc/spinlock.h 2002-10-09 22:48:26.000000000 +0300
@@ -18,13 +18,11 @@
 
 #ifdef __KERNEL__
 #if CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_DEBUG_INIT     , 0, 0
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 0, 0 }
 #else
-#define SPINLOCK_DEBUG_INIT     /* */
+#define SPIN_LOCK_UNLOCKED (spinlock_t) 0
 #endif
 
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
-
 #define spin_lock_init(x)  do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 #define spin_is_locked(x) ((x)->lock != 0)
 #define spin_unlock_wait(x) do { barrier(); } while(spin_is_locked(x))
@@ -89,14 +87,12 @@
 } rwlock_t;
 
 #if CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_DEBUG_INIT     , 0
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 #else
-#define RWLOCK_DEBUG_INIT     /* */
+#define RW_LOCK_UNLOCKED (rwlock_t) 0
 #endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 RWLOCK_DEBUG_INIT }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
-
+#define rwlock_init(lp)  do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x) ((x)->lock != 0)
 
 #ifndef CONFIG_DEBUG_SPINLOCK

diff -ur --strip-trailing-cr difflinux/include/asm-sparc/spinlock.h linux-2.5.41/include/asm-sparc/spinlock.h
--- difflinux/include/asm-sparc/spinlock.h 2002-10-09 22:54:02.000000000 +0300
+++ linux-2.5.41/include/asm-sparc/spinlock.h 2002-10-09 22:55:30.000000000 +0300
@@ -13,11 +13,10 @@
 #include <asm/psr.h>
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-struct _spinlock_debug {
+typedef struct {
  unsigned char lock;
  unsigned long owner_pc;
-};
-typedef struct _spinlock_debug spinlock_t;
+} spinlock_t;
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 0 }
 #define spin_lock_init(lp) do { *(lp)= SPIN_LOCK_UNLOCKED; } while(0)
@@ -32,12 +31,11 @@
 #define _raw_spin_lock(lock) _do_spin_lock(lock, "spin_lock")
 #define _raw_spin_unlock(lock) _do_spin_unlock(lock)
 
-struct _rwlock_debug {
+typedef struct {
  volatile unsigned int lock;
  unsigned long owner_pc;
  unsigned long reader_pc[NR_CPUS];
-};
-typedef struct _rwlock_debug rwlock_t;
+} rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0, {0} }
 
diff -ur --strip-trailing-cr difflinux/include/asm-x86_64/spinlock.h linux-2.5.41/include/asm-x86_64/spinlock.h
--- difflinux/include/asm-x86_64/spinlock.h 2002-10-09 22:58:10.000000000 +0300
+++ linux-2.5.41/include/asm-x86_64/spinlock.h 2002-10-09 22:59:20.000000000 +0300
@@ -23,13 +23,11 @@
 #define SPINLOCK_MAGIC 0xdead4ead
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT , SPINLOCK_MAGIC
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1, SPINLOCK_MAGIC }
 #else
-#define SPINLOCK_MAGIC_INIT /* */
+#define SPIN_LOCK_UNLOCKED (spinlock_t) 1
 #endif
 
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
 #define spin_lock_init(x) do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 
 /*
@@ -118,13 +116,11 @@
 #define RWLOCK_MAGIC 0xdeaf1eed
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT , RWLOCK_MAGIC
+#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS, RWLOCK_MAGIC }
 #else
-#define RWLOCK_MAGIC_INIT /* */
+#define RW_LOCK_UNLOCKED (rwlock_t) RW_LOCK_BIAS
 #endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 /*
@@ -156,7 +152,7 @@
  __build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)  asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
+#define _raw_read_unlock(rw) asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
 #define _raw_write_unlock(rw) asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
 static inline int _raw_write_trylock(rwlock_t *lock)


