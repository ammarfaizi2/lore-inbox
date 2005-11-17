Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVKQTkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVKQTkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVKQTkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:40:23 -0500
Received: from silver.veritas.com ([143.127.12.111]:58401 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964821AbVKQTkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:40:22 -0500
Date: Thu, 17 Nov 2005 19:38:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] unpaged: ZERO_PAGE in VM_UNPAGED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171938080.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:39:58.0680 (UTC) FILETIME=[B19FBD80:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's strange enough to be looking out for anonymous pages in VM_UNPAGED
areas, let's not insert the ZERO_PAGE there - though whether it would
matter will depend on what we decide about ZERO_PAGE refcounting.

But whereas do_anonymous_page may (exceptionally) be called on a
VM_UNPAGED area, do_no_page should never be: just BUG_ON.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 drivers/char/mem.c |    2 +-
 mm/memory.c        |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

--- unpaged08/drivers/char/mem.c	2005-11-12 09:00:39.000000000 +0000
+++ unpaged09/drivers/char/mem.c	2005-11-17 15:11:57.000000000 +0000
@@ -591,7 +591,7 @@ static inline size_t read_zero_pagealign
 
 		if (vma->vm_start > addr || (vma->vm_flags & VM_WRITE) == 0)
 			goto out_up;
-		if (vma->vm_flags & (VM_SHARED | VM_HUGETLB))
+		if (vma->vm_flags & (VM_SHARED | VM_HUGETLB | VM_UNPAGED))
 			break;
 		count = vma->vm_end - addr;
 		if (count > size)
--- unpaged08/mm/memory.c	2005-11-17 15:11:43.000000000 +0000
+++ unpaged09/mm/memory.c	2005-11-17 15:11:57.000000000 +0000
@@ -1812,7 +1812,16 @@ static int do_anonymous_page(struct mm_s
 	spinlock_t *ptl;
 	pte_t entry;
 
-	if (write_access) {
+	/*
+	 * A VM_UNPAGED vma will normally be filled with present ptes
+	 * by remap_pfn_range, and never arrive here; but it might have
+	 * holes, or if !VM_DONTEXPAND, mremap might have expanded it.
+	 * It's weird enough handling anon pages in unpaged vmas, we do
+	 * not want to worry about ZERO_PAGEs too (it may or may not
+	 * matter if their counts wrap): just give them anon pages.
+	 */
+
+	if (write_access || (vma->vm_flags & VM_UNPAGED)) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
 
@@ -1887,6 +1896,7 @@ static int do_no_page(struct mm_struct *
 	int anon = 0;
 
 	pte_unmap(page_table);
+	BUG_ON(vma->vm_flags & VM_UNPAGED);
 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1962,7 +1972,7 @@ retry:
 			inc_mm_counter(mm, anon_rss);
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
-		} else if (!(vma->vm_flags & VM_UNPAGED)) {
+		} else {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
 		}
