Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVJTVuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJTVuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVJTVue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:50:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31446 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932450AbVJTVue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:50:34 -0400
Date: Thu, 20 Oct 2005 23:50:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
Message-ID: <20051020215047.GA24178@elte.hu>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com> <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org> <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org> <434BEA0D.9010802@cosmosbay.com> <20051017000343.782d46fc.akpm@osdl.org> <1129533603.2907.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129533603.2907.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > Is that intentional though?  With <randon .config> my mm/swapfile.i has an
> > unreferenced
> > 
> > static inline void __raw_spin_unlock(raw_spinlock_t *lock)
> > {
> > 	__asm__ __volatile__(
> > 		"movb $1,%0" :"=m" (lock->slock) : : "memory" 
> > 	);
> > }
> > 
> > which either a) shouldn't be there or b) should be referenced.
> > 
> > Ingo, can you confirm that x86's spin_unlock is never inlined?  If so,
> > what's my __raw_spin_unlock() doing there?

__raw_spin_unlock is currently only inlined in the kernel/spinlock.c 
code.

> I would really want this one inlined!  A movb is a much shorter code 
> sequence than a call (esp if you factor in argument setup). 
> De-inlining to save space is nice and all, but it can go too far....

yeah, it makes sense to inline the single-instruction unlock operations: 
nondebug spin_unlock(), read_unlock() and write_unlock(). This gives a 
0.2% code-size reduction:

    text    data     bss     dec     hex filename
 4072031  858208  387196 5317435  51233b vmlinux-smp-uninlined
 4060671  858212  387196 5306079  50f6df vmlinux-smp-inlined

patch against -rc5. Boot-tested on a 4-way x86 SMP box.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/spinlock.h |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

Index: linux/include/linux/spinlock.h
===================================================================
--- linux.orig/include/linux/spinlock.h
+++ linux/include/linux/spinlock.h
@@ -171,9 +171,18 @@ extern int __lockfunc generic__raw_read_
 #define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
 
-#define spin_unlock(lock)		_spin_unlock(lock)
-#define write_unlock(lock)		_write_unlock(lock)
-#define read_unlock(lock)		_read_unlock(lock)
+/*
+ * We inline the unlock functions in the nondebug case:
+ */
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define spin_unlock(lock)		_spin_unlock(lock)
+# define read_unlock(lock)		_read_unlock(lock)
+# define write_unlock(lock)		_write_unlock(lock)
+#else
+# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
+# define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
+# define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
+#endif
 
 #define spin_unlock_irqrestore(lock, flags) \
 					_spin_unlock_irqrestore(lock, flags)
