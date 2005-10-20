Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVJTX0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVJTX0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVJTX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:26:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40087 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964803AbVJTX0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:26:35 -0400
Date: Fri, 21 Oct 2005 01:26:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, arjan@infradead.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
Message-ID: <20051020232658.GA29923@elte.hu>
References: <20051017000343.782d46fc.akpm@osdl.org> <1129533603.2907.12.camel@laptopd505.fenrus.org> <20051020215047.GA24178@elte.hu> <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org> <20051020220228.GA26247@elte.hu> <Pine.LNX.4.64.0510201512480.10477@g5.osdl.org> <20051020222703.GA28221@elte.hu> <20051020154457.100b5565.akpm@osdl.org> <20051020225347.GA29303@elte.hu> <20051020160115.2b34cb8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020160115.2b34cb8e.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > > spin_lock is still uninlined.
> > 
> > yes, and that should stay so i believe, for text size reasons. The BTB 
> > should eliminate most effects of the call+ret itself.
> 
> The old
> 
> 	lock; decb
> 	js <different section>
> 	...
> 
> was pretty good.

yes, but that's 4-7+6==10-13 bytes of inline footprint, compared to 
fixed 5 bytes. That gives quite some icache footprint with thousands of 
call sites.

> > hm, with my patch, write_unlock should be inlined too.
> 
> So it is.  foo_unlock_irq() isn't though.

yes, that one should probably be inlined too, it's just 1 byte longer, 
still the network-effects on register allocations give a net win:

    text    data     bss     dec     hex filename
 4072031  858208  387196 5317435  51233b vmlinux-smp-uninlined
 4060671  858212  387196 5306079  50f6df vmlinux-smp-inlined
 4058543  858212  387196 5303951  50ee8f vmlinux-irqop-inlined-too

another 0.05% drop in text size. Add-on patch below, it is against -rc5 
plus prev_spinlock_patch. Boot-tested on 4-way x86 SMP. The box crashed 
and burned. Joking.

	Ingo

 include/linux/spinlock.h |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

Index: linux/include/linux/spinlock.h
===================================================================
--- linux.orig/include/linux/spinlock.h
+++ linux/include/linux/spinlock.h
@@ -184,19 +184,29 @@ extern int __lockfunc generic__raw_read_
 # define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
 #endif
 
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+# define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
+# define read_unlock_irq(lock)		_read_unlock_irq(lock)
+# define write_unlock_irq(lock)		_write_unlock_irq(lock)
+#else
+# define spin_unlock_irq(lock) \
+    do { __raw_spin_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
+# define read_unlock_irq(lock) \
+    do { __raw_read_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
+# define write_unlock_irq(lock) \
+    do { __raw_write_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
+#endif
+
 #define spin_unlock_irqrestore(lock, flags) \
 					_spin_unlock_irqrestore(lock, flags)
-#define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
 #define read_unlock_irqrestore(lock, flags) \
 					_read_unlock_irqrestore(lock, flags)
-#define read_unlock_irq(lock)		_read_unlock_irq(lock)
 #define read_unlock_bh(lock)		_read_unlock_bh(lock)
 
 #define write_unlock_irqrestore(lock, flags) \
 					_write_unlock_irqrestore(lock, flags)
-#define write_unlock_irq(lock)		_write_unlock_irq(lock)
 #define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
 #define spin_trylock_bh(lock)		__cond_lock(_spin_trylock_bh(lock))
