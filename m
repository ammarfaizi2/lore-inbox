Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVATQVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVATQVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVATQUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:20:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41382 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262220AbVATQPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:15:14 -0500
Date: Thu, 20 Jan 2005 17:14:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: [patch] stricter type-checking rwlock primitives, x86
Message-ID: <20050120161450.GC13812@elte.hu>
References: <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au> <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu> <20050120161116.GA13812@elte.hu> <20050120161259.GB13812@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120161259.GB13812@elte.hu>
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


[patch respun with s/trylock_test/can_lock/]
--

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
  * read_can_lock - would read_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define read_can_lock(x) (atomic_read((atomic_t *)&(x)->lock) > 0)
+static inline int read_can_lock(rwlock_t *rw)
+{
+	return atomic_read((atomic_t *)&rw->lock) > 0;
+}
 
 /**
  * write_can_lock - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
+static inline int write_can_lock(rwlock_t *rw)
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
