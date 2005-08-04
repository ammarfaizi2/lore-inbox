Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVHDSDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVHDSDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVHDSDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:03:51 -0400
Received: from silver.veritas.com ([143.127.12.111]:28703 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262484AbVHDSDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:03:46 -0400
Date: Thu, 4 Aug 2005 19:05:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix VmSize and VmData after mremap
Message-ID: <Pine.LNX.4.61.0508041902310.6282@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Aug 2005 18:03:43.0096 (UTC) FILETIME=[D9BBCF80:01C5991E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mremap's move_vma is applying __vm_stat_account to the old vma which may
have already been freed: move it to just before the do_munmap.

mremapping to and fro with CONFIG_DEBUG_SLAB=y showed /proc/<pid>/status
VmSize and VmData wrapping just like in kernel bugzilla #4842, and fixed
by this patch - worth including in 2.6.13, though not yet confirmed that
it fixes that specific report from Frank van Maarseveen.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc5-git2/mm/mremap.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/mm/mremap.c	2005-08-03 16:22:33.000000000 +0100
@@ -229,6 +229,7 @@ static unsigned long move_vma(struct vm_
 	 * since do_munmap() will decrement it by old_len == new_len
 	 */
 	mm->total_vm += new_len >> PAGE_SHIFT;
+	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 
 	if (do_munmap(mm, old_addr, old_len) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
@@ -243,7 +244,6 @@ static unsigned long move_vma(struct vm_
 			vma->vm_next->vm_flags |= VM_ACCOUNT;
 	}
 
-	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		if (new_len > old_len)
