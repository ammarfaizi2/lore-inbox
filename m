Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVCYOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVCYOew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVCYOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:34:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42391 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261645AbVCYOet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:34:49 -0500
Date: Fri, 25 Mar 2005 15:34:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] xfrm_policy destructor fix
Message-ID: <20050325143440.GA4516@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below fixes a bug that i encountered while running a 
PREEMPT_RT kernel, but i believe it should be fixed in the generic 
kernel too. xfrm_policy_kill() queues a destroyed policy structure to 
the GC list, and unlocks the policy->lock spinlock _after_ that point.  
This created a scenario where GC processing got to the new structure 
first, and kfree()d it - then the write_unlock_bh() was done on the 
already kfreed structure. There is no guarantee that GC processing will 
be done after policy->lock has been dropped and softirq processing has 
been enabled.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/net/xfrm/xfrm_policy.c.orig
+++ linux/net/xfrm/xfrm_policy.c
@@ -301,18 +301,22 @@ static void xfrm_policy_gc_task(void *da
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
 	write_lock_bh(&policy->lock);
-	if (policy->dead)
-		goto out;
-
+	if (policy->dead) {
+		write_unlock_bh(&policy->lock);
+		return;
+	}
 	policy->dead = 1;
 
 	spin_lock(&xfrm_policy_gc_lock);
 	list_add(&policy->list, &xfrm_policy_gc_list);
+	/*
+	 * Unlock the policy (out of order unlocking), to make sure
+	 * the GC context does not free it with an active lock:
+	 */
+	write_unlock_bh(&policy->lock);
 	spin_unlock(&xfrm_policy_gc_lock);
-	schedule_work(&xfrm_policy_gc_work);
 
-out:
-	write_unlock_bh(&policy->lock);
+	schedule_work(&xfrm_policy_gc_work);
 }
 
 /* Generate new index... KAME seems to generate them ordered by cost
