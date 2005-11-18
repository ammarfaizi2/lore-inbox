Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKRO53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKRO53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVKRO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:57:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:919 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750756AbVKRO52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:57:28 -0500
Date: Fri, 18 Nov 2005 14:57:23 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jonathan E Brassow <jbrassow@redhat.com>
Subject: [PATCH] device-mapper raid1: drop mark_region spinlock fix
Message-ID: <20051118145723.GL11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jonathan E Brassow <jbrassow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spinlock region_lock is held while calling mark_region which can
sleep.  Drop the spinlock before calling that function.

A region's state and inclusion in the clean list are altered
by rh_inc and rh_dec.  The state variable is set to RH_CLEAN in rh_dec, 
but only if 'pending' is zero.  It is set to RH_DIRTY in rh_inc, but 
not if it is already so.  The changes to 'pending', the state, and 
the region's inclusion in the clean list need to be atomicly.

From: Jonathan E Brassow <jbrassow@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-raid1.c	2005-10-26 20:14:27.000000000 +0100
+++ linux-2.6.14/drivers/md/dm-raid1.c	2005-10-26 20:23:03.000000000 +0100
@@ -376,16 +376,18 @@ static void rh_inc(struct region_hash *r
 	read_lock(&rh->hash_lock);
 	reg = __rh_find(rh, region);
 
+	spin_lock_irq(&rh->region_lock);
 	atomic_inc(&reg->pending);
 
-	spin_lock_irq(&rh->region_lock);
 	if (reg->state == RH_CLEAN) {
-		rh->log->type->mark_region(rh->log, reg->key);
-
 		reg->state = RH_DIRTY;
 		list_del_init(&reg->list);	/* take off the clean list */
-	}
-	spin_unlock_irq(&rh->region_lock);
+		spin_unlock_irq(&rh->region_lock);
+
+		rh->log->type->mark_region(rh->log, reg->key);
+	} else
+		spin_unlock_irq(&rh->region_lock);
+
 
 	read_unlock(&rh->hash_lock);
 }
@@ -408,21 +410,17 @@ static void rh_dec(struct region_hash *r
 	reg = __rh_lookup(rh, region);
 	read_unlock(&rh->hash_lock);
 
+	spin_lock_irqsave(&rh->region_lock, flags);
 	if (atomic_dec_and_test(&reg->pending)) {
-		spin_lock_irqsave(&rh->region_lock, flags);
-		if (atomic_read(&reg->pending)) { /* check race */
-			spin_unlock_irqrestore(&rh->region_lock, flags);
-			return;
-		}
 		if (reg->state == RH_RECOVERING) {
 			list_add_tail(&reg->list, &rh->quiesced_regions);
 		} else {
 			reg->state = RH_CLEAN;
 			list_add(&reg->list, &rh->clean_regions);
 		}
-		spin_unlock_irqrestore(&rh->region_lock, flags);
 		should_wake = 1;
 	}
+	spin_unlock_irqrestore(&rh->region_lock, flags);
 
 	if (should_wake)
 		wake();
