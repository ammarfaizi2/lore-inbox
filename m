Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVCIWfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVCIWfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVCIWcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:32:09 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37204 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262443AbVCIWOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:14:08 -0500
Date: Wed, 9 Mar 2005 22:13:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] ptwalk: copy_pte_range hang
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092212440.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the odd-one-out of the sequence.  The one before adjusted
copy_pte_range from a for loop to a do while loop, and it was therefore
simplest to check for lockbreak before copying pte: possibility that it
might keep getting preempted without making progress under some loads.

Some loads such as startup: 2*HT*P4 with preemption cannot even reach
multiuser login.  Suspect needs_lockbreak is broken, can get in a state
when it remains forever true.  Investigate that later: for now, and for
all time, it makes sense to aim for a little progress before breaking
out; and we can manage more pte_nones than copies.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

--- ptwalk10/mm/memory.c	2005-03-09 01:38:12.000000000 +0000
+++ ptwalk11/mm/memory.c	2005-03-09 01:38:54.000000000 +0000
@@ -328,6 +328,7 @@ static int copy_pte_range(struct mm_stru
 {
 	pte_t *src_pte, *dst_pte;
 	unsigned long vm_flags = vma->vm_flags;
+	int progress;
 
 again:
 	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
@@ -335,19 +336,23 @@ again:
 		return -ENOMEM;
 	src_pte = pte_offset_map_nested(src_pmd, addr);
 
+	progress = 0;
 	spin_lock(&src_mm->page_table_lock);
 	do {
 		/*
 		 * We are holding two locks at this point - either of them
 		 * could generate latencies in another task on another CPU.
 		 */
-		if (need_resched() ||
+		if (progress >= 32 && (need_resched() ||
 		    need_lockbreak(&src_mm->page_table_lock) ||
-		    need_lockbreak(&dst_mm->page_table_lock))
+		    need_lockbreak(&dst_mm->page_table_lock)))
 			break;
-		if (pte_none(*src_pte))
+		if (pte_none(*src_pte)) {
+			progress++;
 			continue;
+		}
 		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 	spin_unlock(&src_mm->page_table_lock);
 
