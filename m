Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVCZBMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVCZBMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 20:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVCZBMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 20:12:38 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:12804 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261901AbVCZBMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 20:12:34 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David S. Miller)
Subject: Re: [patch] xfrm_policy destructor fix
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@osdl.org
Organization: Core
In-Reply-To: <20050325092813.20e00ef9.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DEzq5-0006Bf-00@gondolin.me.apana.org.au>
Date: Sat, 26 Mar 2005 12:11:45 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
> On Fri, 25 Mar 2005 15:34:41 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>> the patch below fixes a bug that i encountered while running a 
>> PREEMPT_RT kernel, but i believe it should be fixed in the generic 
>> kernel too. xfrm_policy_kill() queues a destroyed policy structure to 
>> the GC list, and unlocks the policy->lock spinlock _after_ that point.  
>> This created a scenario where GC processing got to the new structure 
>> first, and kfree()d it - then the write_unlock_bh() was done on the 
>> already kfreed structure. There is no guarantee that GC processing will 
>> be done after policy->lock has been dropped and softirq processing has 
>> been enabled.
> 
> Good catch Ingo, patch applied.  Thanks.

Sorry, that was my fault.  I dropped the GC code inside the locks
without thinking.

In fact, the GC list linking doesn't need to sit inside the locks
at all.  The locks are there to guard the setting of policy->dead
only.

So here is a patch to simplify xfrm_policy_kill() by moving the
GC linking after the write_unlock_bh().

Actually, as the code stands, xfrm_policy_kill() should/will never
be called twice on the same policy.  So we can add a warning to
catch that.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== net/xfrm/xfrm_policy.c 1.74 vs edited =====
--- 1.74/net/xfrm/xfrm_policy.c	2005-03-26 04:25:09 +11:00
+++ edited/net/xfrm/xfrm_policy.c	2005-03-26 12:07:08 +11:00
@@ -13,6 +13,7 @@
  * 	
  */
 
+#include <asm/bug.h>
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
@@ -300,20 +301,20 @@
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	int dead;
+
 	write_lock_bh(&policy->lock);
-	if (policy->dead) {
-		write_unlock_bh(&policy->lock);
+	dead = policy->dead;
+	policy->dead = 1;
+	write_unlock_bh(&policy->lock);
+
+	if (unlikely(dead)) {
+		WARN_ON(1);
 		return;
 	}
-	policy->dead = 1;
 
 	spin_lock(&xfrm_policy_gc_lock);
 	list_add(&policy->list, &xfrm_policy_gc_list);
-	/*
-	 * Unlock the policy (out of order unlocking), to make sure
-	 * the GC context does not free it with an active lock:
-	 */
-	write_unlock_bh(&policy->lock);
 	spin_unlock(&xfrm_policy_gc_lock);
 
 	schedule_work(&xfrm_policy_gc_work);
