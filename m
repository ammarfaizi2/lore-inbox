Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWIFKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWIFKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIFKN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:13:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22933 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750753AbWIFKN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:13:26 -0400
Date: Wed, 6 Sep 2006 12:05:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060906100507.GA12799@elte.hu>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <20060905181241.GC16207@elte.hu> <20060905190807.GA27171@elte.hu> <20060905193742.GA1566@elte.hu> <20060906065451.GA6898@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906065451.GA6898@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> That seems to be code that isn't upstream. 2.6.18-rc5-mm1 as well as 
> Linus' current git tree have this:
> 
> /*
>  * If lockdep is enabled then we use the non-preemption spin-ops
>  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
>  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
>  */
> #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
>         defined(CONFIG_PROVE_LOCKING)
> 
> And yes, using CONFIG_DEBUG_LOCK_ALLOC instead of CONFIG_PROVE_LOCKING 
> fixes this for me :)

indeed, this is a very recent fix from Jarek Poplawski - not yet in 
Linus' tree but already in Andrew's.

	Ingo

---------->
From: Jarek Poplawski <jarkao2@o2.pl>

With

CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set

spin_unlock_irqrestore() goes through lockdep but spin_lock_irqsave() doesn't.
Apparently, bad things happen.

Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/spinlock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/spinlock.c~lockdep-ifdef-fix kernel/spinlock.c
--- a/kernel/spinlock.c~lockdep-ifdef-fix
+++ a/kernel/spinlock.c
@@ -72,7 +72,7 @@ EXPORT_SYMBOL(_write_trylock);
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
-	defined(CONFIG_PROVE_LOCKING)
+	defined(CONFIG_DEBUG_LOCK_ALLOC)
 
 void __lockfunc _read_lock(rwlock_t *lock)
 {
_
