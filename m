Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVATCjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVATCjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVATCjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:39:49 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:32678 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261916AbVATCjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:39:08 -0500
Date: Wed, 19 Jan 2005 18:34:46 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       Tony Luck <tony.luck@intel.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
Message-ID: <20050120023445.GA3475@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu> <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:43:30AM +1100, Paul Mackerras wrote:

> I suggest read_poll(), write_poll(), spin_poll(), which are like
> {read,write,spin}_trylock but don't do the atomic op to get the
> lock, that is, they don't change the lock value but return true if
> the trylock would succeed, assuming no other cpu takes the lock in
> the meantime.

I'm not personally convinced *_poll is any clearer really, I would if
this is vague prefer longer more obvious names but that's just me.

Because spin_is_locked is used in quite a few places I would leave
that one alone for now --- I'm not saying we can't change this name,
but it should be a separate issue IMO.

Because rwlock_is_locked isn't used in many places changing that isn't
a big deal.

As a compromise I have the following patch in my quilt tree based upon
what a few people have said in this thread already.  This is again the
"-CURRENT bk" tree as of a few minutes ago and seems to be working as
expected.

  * i386: rename spinlock_t -> lock to slock to catch possible
    macro abuse problems

  * i386, ia64: rename rwlock_is_locked to rwlock_write_locked as this
    is IMO a better name

  * i386, ia64: add rwlock_read_locked (if people are OK with these, I
    can do the other architectures)

  * generic: fix kernel/exit.c to use rwlock_write_locked

  * generic: fix kernel/spinlock.c

Comments?

---

 include/asm-i386/spinlock.h |   26 ++++++++++++++++++--------
 include/asm-ia64/spinlock.h |   12 +++++++++++-
 kernel/exit.c               |    2 +-
 kernel/spinlock.c           |    4 ++--
 4 files changed, 32 insertions(+), 12 deletions(-)



===== include/asm-i386/spinlock.h 1.16 vs edited =====
Index: cw-current/include/asm-i386/spinlock.h
===================================================================
--- cw-current.orig/include/asm-i386/spinlock.h	2005-01-19 17:37:27.497810394 -0800
+++ cw-current/include/asm-i386/spinlock.h	2005-01-19 17:37:30.044914512 -0800
@@ -15,7 +15,7 @@
  */
 
 typedef struct {
-	volatile unsigned int lock;
+	volatile unsigned int slock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
@@ -43,7 +43,7 @@
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
+#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 
 #define spin_lock_string \
@@ -83,7 +83,7 @@
 
 #define spin_unlock_string \
 	"movb $1,%0" \
-		:"=m" (lock->lock) : : "memory"
+		:"=m" (lock->slock) : : "memory"
 
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
@@ -101,7 +101,7 @@
 
 #define spin_unlock_string \
 	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->lock) \
+		:"=q" (oldval), "=m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
@@ -123,7 +123,7 @@
 	char oldval;
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->lock)
+		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
 	return oldval > 0;
 }
@@ -138,7 +138,7 @@
 #endif
 	__asm__ __volatile__(
 		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+		:"=m" (lock->slock) : : "memory");
 }
 
 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
@@ -151,7 +151,7 @@
 #endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+		:"=m" (lock->slock) : "r" (flags) : "memory");
 }
 
 /*
@@ -186,7 +186,17 @@
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
-#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
+/**
+ * rwlock_read_locked - would read_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define rwlock_read_locked(x) (atomic_read((atomic_t *)&(x)->lock) <= 0)
+
+/**
+ * rwlock_write_locked - would write_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define rwlock_write_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
Index: cw-current/include/asm-ia64/spinlock.h
===================================================================
--- cw-current.orig/include/asm-ia64/spinlock.h	2005-01-19 17:37:27.498810435 -0800
+++ cw-current/include/asm-ia64/spinlock.h	2005-01-19 17:37:30.044914512 -0800
@@ -126,7 +126,17 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-#define rwlock_is_locked(x)	(*(volatile int *) (x) != 0)
+
+/* rwlock_read_locked - would read_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define rwlock_read_locked(x)       (*(volatile int *) (x) < 0)
+
+/**
+ * rwlock_write_locked - would write_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define rwlock_write_locked(x)     (*(volatile int *) (x) != 0)
 
 #define _raw_read_lock(rw)								\
 do {											\
Index: cw-current/kernel/exit.c
===================================================================
--- cw-current.orig/kernel/exit.c	2005-01-19 17:37:27.498810435 -0800
+++ cw-current/kernel/exit.c	2005-01-19 18:14:21.601934388 -0800
@@ -862,7 +862,7 @@
 	if (!p->sighand)
 		BUG();
 	if (!spin_is_locked(&p->sighand->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
+				!rwlock_write_locked(&tasklist_lock))
 		BUG();
 #endif
 	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);
Index: cw-current/kernel/spinlock.c
===================================================================
--- cw-current.orig/kernel/spinlock.c	2005-01-19 17:37:27.498810435 -0800
+++ cw-current/kernel/spinlock.c	2005-01-19 17:37:30.048914675 -0800
@@ -247,8 +247,8 @@
  *         _[spin|read|write]_lock_bh()
  */
 BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
-BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
-BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
+BUILD_LOCK_OPS(read, rwlock_t, rwlock_read_locked);
+BUILD_LOCK_OPS(write, rwlock_t, rwlock_write_locked);
 
 #endif /* CONFIG_PREEMPT */
 
