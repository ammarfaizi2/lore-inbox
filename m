Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUJCSZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUJCSZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJCSZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:25:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24855 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268049AbUJCSYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:24:54 -0400
Date: Sun, 3 Oct 2004 19:24:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] vmtrunc: restore unmap_vmas zap_bytes
In-Reply-To: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410031923390.2755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The low-latency unmap_vmas patch silently moved the zap_bytes test
after the TLB finish and lockbreak and regather: why?  That not only
makes zap_bytes redundant (might as well use ZAP_BLOCK_SIZE), it makes
the unmap_vmas level redundant too - it's all about saving TLB flushes
when unmapping a series of small vmas.

Move zap_bytes test back before the lockbreak, and delete the curious
comment that a small zap block size doesn't matter: it's true need_flush
prevents TLB flush when no page has been unmapped, but unmapping pages
in small blocks involves many more TLB flushes than in large blocks.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

--- trunc1/mm/memory.c	2004-10-03 01:07:01.396013328 +0100
+++ trunc2/mm/memory.c	2004-10-03 01:07:12.957255752 +0100
@@ -506,10 +506,6 @@ static void unmap_page_range(struct mmu_
 }
 
 #ifdef CONFIG_PREEMPT
-/*
- * It's not an issue to have a small zap block size - TLB flushes
- * only happen once normally, due to the tlb->need_flush optimization.
- */
 # define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
 #else
 /* No preempt: go for improved straight-line efficiency */
@@ -588,6 +584,9 @@ int unmap_vmas(struct mmu_gather **tlbp,
 
 			start += block;
 			zap_bytes -= block;
+			if ((long)zap_bytes > 0)
+				continue;
+
 			if (!atomic) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
@@ -595,8 +594,6 @@ int unmap_vmas(struct mmu_gather **tlbp,
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
-			if ((long)zap_bytes > 0)
-				continue;
 			zap_bytes = ZAP_BLOCK_SIZE;
 		}
 	}

