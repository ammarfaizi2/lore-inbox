Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVIYQKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVIYQKm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVIYQKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:10:42 -0400
Received: from silver.veritas.com ([143.127.12.111]:22711 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932246AbVIYQKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:10:41 -0400
Date: Sun, 25 Sep 2005 17:10:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 19/21] mm: dup_mmap down new mmap_sem
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251709140.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:10:41.0056 (UTC) FILETIME=[ACCDA200:01C5C1EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One anomaly remains from when Andrea rationalized the responsibilities
of mmap_sem and page_table_lock: in dup_mmap we add vmas to the child
holding its page_table_lock, but not the mmap_sem which normally guards
the vma list and rbtree.  Which could be an issue for unuse_mm: though
since it just walks down the list (today with page_table_lock, tomorrow
not), it's probably okay.  Will need a memory barrier?  Oh, keep it
simple, Nick and I agreed, no harm in taking child's mmap_sem here.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/fork.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

--- mm18/kernel/fork.c	2005-09-24 19:30:21.000000000 +0100
+++ mm19/kernel/fork.c	2005-09-24 19:30:35.000000000 +0100
@@ -192,6 +192,8 @@ static inline int dup_mmap(struct mm_str
 
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(oldmm);
+	down_write(&mm->mmap_sem);
+
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
 	mm->mmap_cache = NULL;
@@ -251,10 +253,7 @@ static inline int dup_mmap(struct mm_str
 		}
 
 		/*
-		 * Link in the new vma and copy the page table entries:
-		 * link in first so that swapoff can see swap entries.
-		 * Note that, exceptionally, here the vma is inserted
-		 * without holding mm->mmap_sem.
+		 * Link in the new vma and copy the page table entries.
 		 */
 		spin_lock(&mm->page_table_lock);
 		*pprev = tmp;
@@ -275,8 +274,8 @@ static inline int dup_mmap(struct mm_str
 			goto out;
 	}
 	retval = 0;
-
 out:
+	up_write(&mm->mmap_sem);
 	flush_tlb_mm(oldmm);
 	up_write(&oldmm->mmap_sem);
 	return retval;
