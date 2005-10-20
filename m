Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVJTW0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVJTW0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVJTW0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:26:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63973 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750862AbVJTW0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:26:40 -0400
Date: Fri, 21 Oct 2005 00:27:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
Message-ID: <20051020222703.GA28221@elte.hu>
References: <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org> <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org> <434BEA0D.9010802@cosmosbay.com> <20051017000343.782d46fc.akpm@osdl.org> <1129533603.2907.12.camel@laptopd505.fenrus.org> <20051020215047.GA24178@elte.hu> <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org> <20051020220228.GA26247@elte.hu> <Pine.LNX.4.64.0510201512480.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510201512480.10477@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 21 Oct 2005, Ingo Molnar wrote:
> > 
> > the unlock is simple even in the preemption case
> 
> No it's not. It needs to decrement the preemption counter and test it.

arghhh. Right you are. I even had the proper solution coded up initially 
(i had || defined(CONFIG_PREEMPT)) but dropped it due to fatal brain 
error. Been hacking on way too much ktimer code today ... Hopefully 
better patch attached. Booted on SMP+PREEMPT x86. But i'd really advise 
you against taking patches from me tonight :-|

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
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
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
