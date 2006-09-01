Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWIAA3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWIAA3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWIAA3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:29:14 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:55871 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964835AbWIAA3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:29:13 -0400
X-IronPort-AV: i="4.08,195,1154934000"; 
   d="scan'208"; a="442198360:sNHT32065524"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 31 Aug 2006 17:29:09 -0700
Message-ID: <ada8xl4jup6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 00:29:10.0568 (UTC) FILETIME=[A4B5FA80:01C6CD5D]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

to get a fix for a locking bug found by lockdep:

Roland Dreier:
      IB/mthca: Use IRQ safe locks to protect allocation bitmaps

 drivers/infiniband/hw/mthca/mthca_allocator.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)


diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index 25157f5..f930e55 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -41,9 +41,11 @@ #include "mthca_dev.h"
 /* Trivial bitmap-based allocator */
 u32 mthca_alloc(struct mthca_alloc *alloc)
 {
+	unsigned long flags;
 	u32 obj;
 
-	spin_lock(&alloc->lock);
+	spin_lock_irqsave(&alloc->lock, flags);
+
 	obj = find_next_zero_bit(alloc->table, alloc->max, alloc->last);
 	if (obj >= alloc->max) {
 		alloc->top = (alloc->top + alloc->max) & alloc->mask;
@@ -56,19 +58,24 @@ u32 mthca_alloc(struct mthca_alloc *allo
 	} else
 		obj = -1;
 
-	spin_unlock(&alloc->lock);
+	spin_unlock_irqrestore(&alloc->lock, flags);
 
 	return obj;
 }
 
 void mthca_free(struct mthca_alloc *alloc, u32 obj)
 {
+	unsigned long flags;
+
 	obj &= alloc->max - 1;
-	spin_lock(&alloc->lock);
+
+	spin_lock_irqsave(&alloc->lock, flags);
+
 	clear_bit(obj, alloc->table);
 	alloc->last = min(alloc->last, obj);
 	alloc->top = (alloc->top + alloc->max) & alloc->mask;
-	spin_unlock(&alloc->lock);
+
+	spin_unlock_irqrestore(&alloc->lock, flags);
 }
 
 int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
