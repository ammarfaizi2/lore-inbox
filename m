Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFVNB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFVNB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 09:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFVNB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 09:01:29 -0400
Received: from gold.veritas.com ([143.127.12.110]:1312 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261257AbVFVNB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 09:01:27 -0400
Date: Wed, 22 Jun 2005 14:02:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "Richard B. Johnson" <linux-os@analogic.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix remap_pte_range BUG
Message-ID: <Pine.LNX.4.61.0506221348540.13520@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2005 13:01:26.0291 (UTC) FILETIME=[7F97BE30:01C5772A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Out-of-tree user of remap_pfn_range hit kernel BUG at mm/memory.c:1112!
It passes an unrounded size to remap_pfn_range, which was okay before
2.6.12, but misses remap_pte_range's new end condition.  An audit of
all the other ptwalks confirms that this is the only one so exposed.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.12/mm/memory.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/mm/memory.c	2005-06-21 20:31:42.000000000 +0100
@@ -1164,7 +1164,7 @@ int remap_pfn_range(struct vm_area_struc
 {
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long end = addr + size;
+	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
 
