Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVCWOwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVCWOwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCWOwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:52:39 -0500
Received: from are.twiddle.net ([64.81.246.98]:59779 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262572AbVCWOth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:49:37 -0500
Date: Wed, 23 Mar 2005 06:49:22 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Pawe__ Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: alpha spinlock.h update
Message-ID: <20050323144922.GA19677@twiddle.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Pawe__ Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org
References: <20050322130145.69915bea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322130145.69915bea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 01:01:45PM -0800, Andrew Morton wrote:
> I had the impression Richard planned on something more sophisticated
> than this??

Indeed.  I suppose I can pass it along to avoid repeated "it doesn't build"
messages, but an smp kernel doesn't run.  *All* processes spawned by init(1)
die with SIGILL very very shortly.  I can only guess that there's been some
change to flushing (icache or tlb) that went wrong.



r~



===== include/asm-alpha/spinlock.h 1.14 vs edited =====
--- 1.14/include/asm-alpha/spinlock.h	2005-01-20 08:21:23 -08:00
+++ edited/include/asm-alpha/spinlock.h	2005-03-20 13:53:46 -08:00
@@ -15,7 +15,7 @@
  */
 
 typedef struct {
-	volatile unsigned int lock /*__attribute__((aligned(32))) */;
+	volatile unsigned int lock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	int on_cpu;
 	int line_no;
@@ -23,40 +23,26 @@
 	struct task_struct * task;
 	const char *base_file;
 #endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
 } spinlock_t;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-#define SPIN_LOCK_UNLOCKED (spinlock_t) {0, -1, 0, NULL, NULL, NULL}
-#define spin_lock_init(x)						\
-	((x)->lock = 0, (x)->on_cpu = -1, (x)->previous = NULL, (x)->task = NULL)
+#define SPIN_LOCK_UNLOCKED	(spinlock_t){ 0, -1, 0, NULL, NULL, NULL }
 #else
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-#define spin_lock_init(x)	((x)->lock = 0)
+#define SPIN_LOCK_UNLOCKED	(spinlock_t){ 0 }
 #endif
 
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 #define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	({ do { barrier(); } while ((x)->lock); })
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 extern void _raw_spin_unlock(spinlock_t * lock);
 extern void debug_spin_lock(spinlock_t * lock, const char *, int);
 extern int debug_spin_trylock(spinlock_t * lock, const char *, int);
-
-#define _raw_spin_lock(LOCK) debug_spin_lock(LOCK, __BASE_FILE__, __LINE__)
-#define _raw_spin_trylock(LOCK) debug_spin_trylock(LOCK, __BASE_FILE__, __LINE__)
-
-#define spin_lock_own(LOCK, LOCATION)					\
-do {									\
-	if (!((LOCK)->lock && (LOCK)->on_cpu == smp_processor_id()))	\
-		printk("%s: called on %d from %p but lock %s on %d\n",	\
-		       LOCATION, smp_processor_id(),			\
-		       __builtin_return_address(0),			\
-		       (LOCK)->lock ? "taken" : "freed", (LOCK)->on_cpu); \
-} while (0)
+#define _raw_spin_lock(LOCK) \
+	debug_spin_lock(LOCK, __BASE_FILE__, __LINE__)
+#define _raw_spin_trylock(LOCK) \
+	debug_spin_trylock(LOCK, __BASE_FILE__, __LINE__)
 #else
 static inline void _raw_spin_unlock(spinlock_t * lock)
 {
@@ -68,19 +54,16 @@
 {
 	long tmp;
 
-	/* Use sub-sections to put the actual loop at the end
-	   of this object file's text section so as to perfect
-	   branch prediction.  */
 	__asm__ __volatile__(
 	"1:	ldl_l	%0,%1\n"
-	"	blbs	%0,2f\n"
-	"	or	%0,1,%0\n"
+	"	bne	%0,2f\n"
+	"	lda	%0,1\n"
 	"	stl_c	%0,%1\n"
 	"	beq	%0,2f\n"
 	"	mb\n"
 	".subsection 2\n"
 	"2:	ldl	%0,%1\n"
-	"	blbs	%0,2b\n"
+	"	bne	%0,2b\n"
 	"	br	1b\n"
 	".previous"
 	: "=&r" (tmp), "=m" (lock->lock)
@@ -91,22 +74,29 @@
 {
 	return !test_and_set_bit(0, &lock->lock);
 }
-
-#define spin_lock_own(LOCK, LOCATION)	((void)0)
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+
 /***********************************************************/
 
 typedef struct {
-	volatile unsigned int write_lock:1, read_counter:31;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} /*__attribute__((aligned(32)))*/ rwlock_t;
+	volatile unsigned int lock;
+} rwlock_t;
+
+#define RW_LOCK_UNLOCKED	(rwlock_t){ 0 }
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+static inline int read_can_lock(rwlock_t *lock)
+{
+	return (lock->lock & 1) == 0;
+}
+
+static inline int write_can_lock(rwlock_t *lock)
+{
+	return lock->lock == 0;
+}
 
 #ifdef CONFIG_DEBUG_RWLOCK
 extern void _raw_write_lock(rwlock_t * lock);
@@ -119,7 +109,7 @@
 	__asm__ __volatile__(
 	"1:	ldl_l	%1,%0\n"
 	"	bne	%1,6f\n"
-	"	or	$31,1,%1\n"
+	"	lda	%1,1\n"
 	"	stl_c	%1,%0\n"
 	"	beq	%1,6f\n"
 	"	mb\n"
@@ -142,7 +132,7 @@
 	"	subl	%1,2,%1\n"
 	"	stl_c	%1,%0\n"
 	"	beq	%1,6f\n"
-	"4:	mb\n"
+	"	mb\n"
 	".subsection 2\n"
 	"6:	ldl	%1,%0\n"
 	"	blbs	%1,6b\n"
@@ -153,6 +143,28 @@
 }
 #endif /* CONFIG_DEBUG_RWLOCK */
 
+static inline int _raw_read_trylock(rwlock_t * lock)
+{
+	long regx;
+	int success;
+
+	__asm__ __volatile__(
+	"1:	ldl_l	%1,%0\n"
+	"	lda	%2,0\n"
+	"	blbs	%1,2f\n"
+	"	subl	%1,2,%2\n"
+	"	stl_c	%2,%0\n"
+	"	beq	%2,6f\n"
+	"2:	mb\n"
+	".subsection 2\n"
+	"6:	br	1b\n"
+	".previous"
+	: "=m" (*lock), "=&r" (regx), "=&r" (success)
+	: "m" (*lock) : "memory");
+
+	return success;
+}
+
 static inline int _raw_write_trylock(rwlock_t * lock)
 {
 	long regx;
@@ -162,10 +174,9 @@
 	"1:	ldl_l	%1,%0\n"
 	"	lda	%2,0\n"
 	"	bne	%1,2f\n"
-	"	or	$31,1,%1\n"
-	"	stl_c	%1,%0\n"
-	"	beq	%1,6f\n"
 	"	lda	%2,1\n"
+	"	stl_c	%2,%0\n"
+	"	beq	%2,6f\n"
 	"2:	mb\n"
 	".subsection 2\n"
 	"6:	br	1b\n"
@@ -179,7 +190,7 @@
 static inline void _raw_write_unlock(rwlock_t * lock)
 {
 	mb();
-	*(volatile int *)lock = 0;
+	lock->lock = 0;
 }
 
 static inline void _raw_read_unlock(rwlock_t * lock)
