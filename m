Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVATMTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVATMTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVATMTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:19:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34768 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262134AbVATMTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:19:25 -0500
Date: Thu, 20 Jan 2005 13:18:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] stricter type-checking rwlock primitives, x86
Message-ID: <20050120121813.GA4838@elte.hu>
References: <20050120114317.GA29876@elte.hu> <20050120115947.GA31305@elte.hu> <20050120120905.GA3493@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120120905.GA3493@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


turn x86 rwlock macros into inline functions, to get stricter
type-checking. Test-built/booted on x86. (patch comes after all
previous spinlock patches.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -198,21 +198,33 @@ typedef struct {
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+static inline void rwlock_init(rwlock_t *rw)
+{
+	*rw = RW_LOCK_UNLOCKED;
+}
 
-#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
+static inline int rwlock_is_locked(rwlock_t *rw)
+{
+	return rw->lock != RW_LOCK_BIAS;
+}
 
 /**
  * read_trylock_test - would read_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define read_trylock_test(x) (atomic_read((atomic_t *)&(x)->lock) > 0)
+static inline int read_trylock_test(rwlock_t *rw)
+{
+	return atomic_read((atomic_t *)&rw->lock) > 0;
+}
 
 /**
  * write_trylock_test - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_trylock_test(x) ((x)->lock == RW_LOCK_BIAS)
+static inline int write_trylock_test(rwlock_t *rw)
+{
+	return atomic_read((atomic_t *)&rw->lock) == RW_LOCK_BIAS;
+}
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
@@ -241,8 +253,16 @@ static inline void _raw_write_lock(rwloc
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
+static inline void _raw_read_unlock(rwlock_t *rw)
+{
+	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+}
+
+static inline void _raw_write_unlock(rwlock_t *rw)
+{
+	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR
+				",%0":"=m" (rw->lock) : : "memory");
+}
 
 static inline int _raw_read_trylock(rwlock_t *lock)
 {
