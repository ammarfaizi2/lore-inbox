Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVATSfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVATSfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVATSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:30:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62160 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261402AbVATSZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:25:27 -0500
Date: Thu, 20 Jan 2005 19:25:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: [patch, BK-curr] rename 'lock' to 'slock' in asm-i386/spinlock.h
Message-ID: <20050120182504.GB26985@elte.hu>
References: <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au> <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu> <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org> <20050120164038.GA15874@elte.hu> <Pine.LNX.4.58.0501200947440.8178@ppc970.osdl.org> <20050120175313.GA22782@elte.hu> <20050120182227.GA26985@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120182227.GA26985@elte.hu>
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


this x86 patch, against BK-curr, renames spinlock_t's 'lock' field to
'slock', to protect against spinlock_t/rwlock_t type mismatches.

build- and boot-tested on x86 SMP+PREEMPT and SMP+!PREEMPT.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -15,7 +15,7 @@ asmlinkage int printk(const char * fmt, 
  */
 
 typedef struct {
-	volatile unsigned int lock;
+	volatile unsigned int slock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
@@ -43,7 +43,7 @@ typedef struct {
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
+#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 
 #define spin_lock_string \
@@ -83,7 +83,7 @@ typedef struct {
 
 #define spin_unlock_string \
 	"movb $1,%0" \
-		:"=m" (lock->lock) : : "memory"
+		:"=m" (lock->slock) : : "memory"
 
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
@@ -101,7 +101,7 @@ static inline void _raw_spin_unlock(spin
 
 #define spin_unlock_string \
 	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->lock) \
+		:"=q" (oldval), "=m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
@@ -123,7 +123,7 @@ static inline int _raw_spin_trylock(spin
 	char oldval;
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->lock)
+		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
 	return oldval > 0;
 }
@@ -138,7 +138,7 @@ static inline void _raw_spin_lock(spinlo
 #endif
 	__asm__ __volatile__(
 		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+		:"=m" (lock->slock) : : "memory");
 }
 
 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
@@ -151,7 +151,7 @@ static inline void _raw_spin_lock_flags 
 #endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+		:"=m" (lock->slock) : "r" (flags) : "memory");
 }
 
 /*
