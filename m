Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVATQ0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVATQ0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVATQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:25:24 -0500
Received: from mx1.elte.hu ([157.181.1.137]:56529 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262265AbVATQXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:23:24 -0500
Date: Thu, 20 Jan 2005 17:23:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Peter Chubb <peterc@gelato.unsw.edu.au>,
       Tony Luck <tony.luck@intel.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
Message-ID: <20050120162309.GB14002@elte.hu>
References: <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu> <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <Pine.LNX.4.58.0501200812300.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501200812300.8178@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> what the _heck_ is that "atomic_read((atomic_t *)&(x)->lock)", and why is 
> it not just a "(int)(x)->lock" instead?
> 
> So I think it would be much better as
> 
> 	#define read_can_lock(x) ((int)(x)->lock > 0)
> 
> which seems simple and straightforward.

right. Replace patch #4 with:

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
+	return rw->lock > 0;
+}
 
 /**
  * write_can_lock - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
+static inline int write_can_lock(rwlock_t *rw)
+{
+	return rw->lock == RW_LOCK_BIAS;
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

