Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVIYQJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVIYQJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVIYQJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:09:35 -0400
Received: from silver.veritas.com ([143.127.12.111]:18871 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932243AbVIYQJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:09:34 -0400
Date: Sun, 25 Sep 2005 17:09:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] mm: dup_mmap use oldmm more
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251708290.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:09:34.0281 (UTC) FILETIME=[85009390:01C5C1EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the parent's oldmm throughout dup_mmap, instead of perversely going
back to current->mm.  (Can you hear the sigh of relief from those mpnts?
Usually I squash them, but not today.)

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/fork.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- mm17/kernel/fork.c	2005-09-24 19:29:53.000000000 +0100
+++ mm18/kernel/fork.c	2005-09-24 19:30:21.000000000 +0100
@@ -182,16 +182,16 @@ static struct task_struct *dup_task_stru
 }
 
 #ifdef CONFIG_MMU
-static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
+static inline int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	struct vm_area_struct * mpnt, *tmp, **pprev;
+	struct vm_area_struct *mpnt, *tmp, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge;
 	struct mempolicy *pol;
 
 	down_write(&oldmm->mmap_sem);
-	flush_cache_mm(current->mm);
+	flush_cache_mm(oldmm);
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
 	mm->mmap_cache = NULL;
@@ -204,7 +204,7 @@ static inline int dup_mmap(struct mm_str
 	rb_parent = NULL;
 	pprev = &mm->mmap;
 
-	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
+	for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
 		struct file *file;
 
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -265,7 +265,7 @@ static inline int dup_mmap(struct mm_str
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		retval = copy_page_range(mm, current->mm, tmp);
+		retval = copy_page_range(mm, oldmm, tmp);
 		spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
@@ -277,7 +277,7 @@ static inline int dup_mmap(struct mm_str
 	retval = 0;
 
 out:
-	flush_tlb_mm(current->mm);
+	flush_tlb_mm(oldmm);
 	up_write(&oldmm->mmap_sem);
 	return retval;
 fail_nomem_policy:
