Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWGLUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWGLUcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGLUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:32:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40384 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751134AbWGLUcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:32:10 -0400
Date: Wed, 12 Jul 2006 22:26:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org
Subject: [patch] lockdep: core, fix rq-lock handling on __ARCH_WANT_UNLOCKED_CTXSW
Message-ID: <20060712202639.GA7719@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lockdep: core, fix rq-lock handling on __ARCH_WANT_UNLOCKED_CTXSW
From: Ingo Molnar <mingo@elte.hu>

on platforms that have __ARCH_WANT_UNLOCKED_CTXSW set and want to 
implement lock validator support there's a bug in rq->lock handling: in 
this case we dont 'carry over' the runqueue lock into another task - but 
still we did a spinlock_release() of it. Fix this by making the 
spinlock_release() in context_switch() dependent on 
!__ARCH_WANT_UNLOCKED_CTXSW.

(Reported by Ralf Baechle on MIPS, which has __ARCH_WANT_UNLOCKED_CTXSW. 
This fixes a lockdep-internal BUG message on such platforms.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sched.c        |    8 ++++++++
 1 file changed, 9 insertions(+)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1788,7 +1788,15 @@ context_switch(struct rq *rq, struct tas
 		WARN_ON(rq->prev_mm);
 		rq->prev_mm = oldmm;
 	}
+	/*
+	 * Since the runqueue lock will be released by the next
+	 * task (which is an invalid locking op but in the case
+	 * of the scheduler it's an obvious special-case), so we
+	 * do an early lockdep release here:
+	 */
+#ifndef __ARCH_WANT_UNLOCKED_CTXSW
 	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
+#endif
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
