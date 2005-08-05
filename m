Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVHES1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVHES1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVHESYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:24:46 -0400
Received: from gold.veritas.com ([143.127.12.110]:41833 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262652AbVHESXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:23:01 -0400
Date: Fri, 5 Aug 2005 19:24:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Prasanna Meda <pmeda@akamai.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix madvise vma merging
Message-ID: <Pine.LNX.4.61.0508051911120.6203@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Aug 2005 18:22:58.0193 (UTC) FILETIME=[B4A36010:01C599EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Better late than never, I've at last reviewed the madvise vma merging
going into 2.6.13.  Remove a pointless check and fix two little bugs -
a simple test (with /proc/<pid>/maps hacked to show ReadHints) showed
both mismerges in practice: though being madvise, neither was disastrous.

1. Correct placement of the success label in madvise_behavior: as in
   mprotect_fixup and mlock_fixup, it is necessary to update vm_flags
   when vma_merge succeeds (to handle the exceptional Case 8 noted in
   the comments above vma_merge itself).

2. Correct initial value of prev when starting part way into a vma: as
   in sys_mprotect and do_mlock, it needs to be set to vma in this case
   (vma_merge handles only that minimum of cases shown in its comments).

3. If find_vma_prev sets prev, then the vma it returns is prev->vm_next,
   so it's pointless to make that same assignment again in sys_madvise.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc5-git3/mm/madvise.c	2005-08-02 12:07:23.000000000 +0100
+++ linux/mm/madvise.c	2005-08-05 18:06:47.000000000 +0100
@@ -37,7 +37,7 @@ static long madvise_behavior(struct vm_a
 
 	if (new_flags == vma->vm_flags) {
 		*prev = vma;
-		goto success;
+		goto out;
 	}
 
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
@@ -62,6 +62,7 @@ static long madvise_behavior(struct vm_a
 			goto out;
 	}
 
+success:
 	/*
 	 * vm_flags is protected by the mmap_sem held in write mode.
 	 */
@@ -70,7 +71,6 @@ static long madvise_behavior(struct vm_a
 out:
 	if (error == -ENOMEM)
 		error = -EAGAIN;
-success:
 	return error;
 }
 
@@ -237,8 +237,9 @@ asmlinkage long sys_madvise(unsigned lon
 	 * - different from the way of handling in mlock etc.
 	 */
 	vma = find_vma_prev(current->mm, start, &prev);
-	if (!vma && prev)
-		vma = prev->vm_next;
+	if (vma && start > vma->vm_start)
+		prev = vma;
+
 	for (;;) {
 		/* Still start < end. */
 		error = -ENOMEM;
