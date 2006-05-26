Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWEZTk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWEZTk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEZTk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:40:58 -0400
Received: from silver.veritas.com ([143.127.12.111]:46456 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751319AbWEZTk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:40:57 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,177,1146466800"; 
   d="scan'208"; a="38565034:sNHT20292740"
Date: Fri, 26 May 2006 19:28:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH] fix update_mmu_cache in fremap.c
Message-ID: <Pine.LNX.4.64.0605261926350.24818@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 May 2006 19:40:56.0915 (UTC) FILETIME=[4ED23230:01C680FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two calls to update_mmu_cache in fremap.c, both defective.
The one in install_page needs to be accompanied by lazy_mmu_prot_update
(some other cleanup time, move that into ia64 update_mmu_cache itself); and
the one in install_file_pte should be removed since the pte is not present.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 mm/fremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.17-rc5/mm/fremap.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/mm/fremap.c	2006-05-26 17:55:29.000000000 +0100
@@ -83,6 +83,7 @@ int install_page(struct mm_struct *mm, s
 	page_add_file_rmap(page);
 	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
+	lazy_mmu_prot_update(pte_val);
 	err = 0;
 unlock:
 	pte_unmap_unlock(pte, ptl);
@@ -114,7 +115,6 @@ int install_file_pte(struct mm_struct *m
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
-	update_mmu_cache(vma, addr, pte_val);
 	pte_unmap_unlock(pte, ptl);
 	err = 0;
 out:
