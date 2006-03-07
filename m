Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWCGXNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWCGXNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWCGXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:13:21 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:49547 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751343AbWCGXNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:13:21 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: yield during swap prefetching
Date: Wed, 8 Mar 2006 10:13:44 +1100
User-Agent: KMail/1.8.3
Cc: linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081013.44678.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swap prefetching doesn't use very much cpu but spends a lot of time waiting on 
disk in uninterruptible sleep. This means it won't get preempted often even at 
a low nice level since it is seen as sleeping most of the time. We want to 
minimise its cpu impact so yield where possible.

Signed-off-by: Con Kolivas <kernel@kolivas.org>
---
 mm/swap_prefetch.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.15-ck5/mm/swap_prefetch.c
===================================================================
--- linux-2.6.15-ck5.orig/mm/swap_prefetch.c	2006-03-02 14:00:46.000000000 +1100
+++ linux-2.6.15-ck5/mm/swap_prefetch.c	2006-03-08 08:49:32.000000000 +1100
@@ -421,6 +421,7 @@ static enum trickle_return trickle_swap(
 
 		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
 			break;
+		yield();
 	}
 
 	if (sp_stat.prefetched_pages) {
