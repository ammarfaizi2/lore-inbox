Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVIMJR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVIMJR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVIMJR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:17:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:492 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751170AbVIMJRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:17:25 -0400
Date: Tue, 13 Sep 2005 11:17:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.14-rc1 BUG: spinlock wrong owner on CPU#0
Message-ID: <20050913091759.GA11485@elte.hu>
References: <26068.1126598310@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26068.1126598310@kao2.melbourne.sgi.com>
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


* Keith Owens <kaos@sgi.com> wrote:

> Booting 2.6.14-rc1 on ia64, I sometimes get
> 
> BUG: spinlock wrong owner on CPU#0, swapper/1
>  lock: e000003003014940, .magic: dead4ead, .owner: pdflush/75, .owner_cpu: 0

hm, ia64 uses __ARCH_WANT_UNLOCKED_CTXSW and thus it releases the 
runqueue lock early - so a certain assumption in the new, improved 
spinlock debugging code does not apply. Does the patch below help?

	Ingo

----

fix up the runqueue lock owner only if we truly did a context-switch 
with the runqueue lock held. Impacts ia64, mips, sparc64 and arm.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -294,6 +294,10 @@ static inline void prepare_lock_switch(r
 
 static inline void finish_lock_switch(runqueue_t *rq, task_t *prev)
 {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	/* this is a valid case when another task releases the spinlock */
+	rq->lock.owner = current;
+#endif
 	spin_unlock_irq(&rq->lock);
 }
 
@@ -1529,10 +1533,6 @@ static inline void finish_task_switch(ru
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
 	prev_task_flags = prev->flags;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = current;
-#endif
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
 	if (mm)
