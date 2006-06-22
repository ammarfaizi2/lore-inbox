Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWFVJCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWFVJCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWFVJCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:02:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60587 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932519AbWFVJCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:02:04 -0400
Date: Thu, 22 Jun 2006 10:57:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] lock validator: rtmutex unlock order annotation
Message-ID: <20060622085706.GA29136@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5049]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: rtmutex unlock order annotation
From: Ingo Molnar <mingo@elte.hu>

rtmutex.c does a tricky piece of 'lock chain' logic spiced with trylock,
which has one particular codepath where we intentionally release the
locks in a different order as acquired. Annotate this for the lock
validator to not complain if CONFIG_DEBUG_NON_NESTED_UNLOCKS=y.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/rtmutex.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux/kernel/rtmutex.c
===================================================================
--- linux.orig/kernel/rtmutex.c
+++ linux/kernel/rtmutex.c
@@ -243,7 +243,8 @@ static int rt_mutex_adjust_prio_chain(ta
 	plist_add(&waiter->list_entry, &lock->wait_list);
 
 	/* Release the task */
-	spin_unlock_irqrestore(&task->pi_lock, flags);
+	spin_unlock_non_nested(&task->pi_lock);
+	local_irq_restore(flags);
 	put_task_struct(task);
 
 	/* Grab the next task */
