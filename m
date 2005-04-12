Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVDLPn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVDLPn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVDLLC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:02:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:32714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262262AbVDLKdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:17 -0400
Message-Id: <200504121033.j3CAX9nb005793@shell0.pdx.osdl.net>
Subject: [patch 159/198] IB: Fix FMR pool crash
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Mask bits correctly from jhash result in ib_fmr_hash() so that the
computed bucket index is within our hash table.  This fixes an SDP
crash.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/core/fmr_pool.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN drivers/infiniband/core/fmr_pool.c~ib-fix-fmr-pool-crash drivers/infiniband/core/fmr_pool.c
--- 25/drivers/infiniband/core/fmr_pool.c~ib-fix-fmr-pool-crash	2005-04-12 03:21:41.546820824 -0700
+++ 25-akpm/drivers/infiniband/core/fmr_pool.c	2005-04-12 03:21:41.549820368 -0700
@@ -103,9 +103,8 @@ struct ib_fmr_pool {
 
 static inline u32 ib_fmr_hash(u64 first_page)
 {
-	return jhash_2words((u32) first_page,
-			    (u32) (first_page >> 32),
-			    0);
+	return jhash_2words((u32) first_page, (u32) (first_page >> 32), 0) &
+		(IB_FMR_HASH_SIZE - 1);
 }
 
 /* Caller must hold pool_lock */
_
