Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264193AbUEHWJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbUEHWJO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUEHWIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:08:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63720 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264193AbUEHWFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:05:47 -0400
Date: Sat, 8 May 2004 23:05:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 31 unlikely bad memory
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082304210.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>

Sprinkle unlikelys throughout mm/memory.c, wherever we see a
pgd_bad or a pmd_bad; likely or unlikely on pte_same or !pte_same.
Put the jump in the error return from do_no_page, not in the fast path.

 memory.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

--- rmap30/mm/memory.c	2004-05-05 13:29:09.000000000 +0100
+++ rmap31/mm/memory.c	2004-05-08 20:55:49.588839808 +0100
@@ -97,7 +97,7 @@ static inline void free_one_pmd(struct m
 
 	if (pmd_none(*dir))
 		return;
-	if (pmd_bad(*dir)) {
+	if (unlikely(pmd_bad(*dir))) {
 		pmd_ERROR(*dir);
 		pmd_clear(dir);
 		return;
@@ -115,7 +115,7 @@ static inline void free_one_pgd(struct m
 
 	if (pgd_none(*dir))
 		return;
-	if (pgd_bad(*dir)) {
+	if (unlikely(pgd_bad(*dir))) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
 		return;
@@ -232,7 +232,7 @@ int copy_page_range(struct mm_struct *ds
 		
 		if (pgd_none(*src_pgd))
 			goto skip_copy_pmd_range;
-		if (pgd_bad(*src_pgd)) {
+		if (unlikely(pgd_bad(*src_pgd))) {
 			pgd_ERROR(*src_pgd);
 			pgd_clear(src_pgd);
 skip_copy_pmd_range:	address = (address + PGDIR_SIZE) & PGDIR_MASK;
@@ -253,7 +253,7 @@ skip_copy_pmd_range:	address = (address 
 		
 			if (pmd_none(*src_pmd))
 				goto skip_copy_pte_range;
-			if (pmd_bad(*src_pmd)) {
+			if (unlikely(pmd_bad(*src_pmd))) {
 				pmd_ERROR(*src_pmd);
 				pmd_clear(src_pmd);
 skip_copy_pte_range:
@@ -355,7 +355,7 @@ static void zap_pte_range(struct mmu_gat
 
 	if (pmd_none(*pmd))
 		return;
-	if (pmd_bad(*pmd)) {
+	if (unlikely(pmd_bad(*pmd))) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
@@ -436,7 +436,7 @@ static void zap_pmd_range(struct mmu_gat
 
 	if (pgd_none(*dir))
 		return;
-	if (pgd_bad(*dir)) {
+	if (unlikely(pgd_bad(*dir))) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
 		return;
@@ -617,7 +617,7 @@ follow_page(struct mm_struct *mm, unsign
 		return page;
 
 	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || pgd_bad(*pgd))
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		goto out;
 
 	pmd = pmd_offset(pgd, address);
@@ -625,7 +625,7 @@ follow_page(struct mm_struct *mm, unsign
 		goto out;
 	if (pmd_huge(*pmd))
 		return follow_huge_pmd(mm, address, pmd, write);
-	if (pmd_bad(*pmd))
+	if (unlikely(pmd_bad(*pmd)))
 		goto out;
 
 	ptep = pte_offset_map(pmd, address);
@@ -682,12 +682,12 @@ untouched_anonymous_page(struct mm_struc
 
 	/* Check if page directory entry exists. */
 	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || pgd_bad(*pgd))
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		return 1;
 
 	/* Check if page middle directory entry exists. */
 	pmd = pmd_offset(pgd, address);
-	if (pmd_none(*pmd) || pmd_bad(*pmd))
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return 1;
 
 	/* There is a pte slot for 'address' in 'mm'. */
@@ -1092,7 +1092,7 @@ static int do_wp_page(struct mm_struct *
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
-	if (pte_same(*page_table, pte)) {
+	if (likely(pte_same(*page_table, pte))) {
 		if (PageReserved(old_page))
 			++mm->rss;
 		else
@@ -1323,7 +1323,7 @@ static int do_swap_page(struct mm_struct
 			 */
 			spin_lock(&mm->page_table_lock);
 			page_table = pte_offset_map(pmd, address);
-			if (pte_same(*page_table, orig_pte))
+			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
 			else
 				ret = VM_FAULT_MINOR;
@@ -1346,7 +1346,7 @@ static int do_swap_page(struct mm_struct
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
-	if (!pte_same(*page_table, orig_pte)) {
+	if (unlikely(!pte_same(*page_table, orig_pte))) {
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 		unlock_page(page);
@@ -1552,12 +1552,12 @@ retry:
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	spin_unlock(&mm->page_table_lock);
-	goto out;
+out:
+	return ret;
 oom:
 	page_cache_release(new_page);
 	ret = VM_FAULT_OOM;
-out:
-	return ret;
+	goto out;
 }
 
 /*

