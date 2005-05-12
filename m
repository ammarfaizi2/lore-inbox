Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVELSZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVELSZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVELSZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:25:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55035 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262106AbVELSY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:24:29 -0400
Date: Thu, 12 May 2005 19:25:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kirill Korotaev <dev@sw.ru>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm acct accounting fix
In-Reply-To: <42830D0A.3090109@sw.ru>
Message-ID: <Pine.LNX.4.61.0505121912400.5204@goblin.wat.veritas.com>
References: <428223E0.2070200@sw.ru> 
    <Pine.LNX.4.61.0505111701110.7331@goblin.wat.veritas.com> 
    <42830D0A.3090109@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 12 May 2005 18:24:27.0305 (UTC) 
    FILETIME=[D4A40990:01C5571F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Kirill Korotaev wrote:
> 
> It would be nice to accept this small patch with a comment.

Adding such a comment is okay, but moving the total_vm += line
away from the __vm_stat_account and locked_vm += seems odd to me
- I'd rather you added your comment after the do_munmap(),
but no big deal (mmap_sem is held for writing throughout).

Hugh

--- ./mm/mremap.c.mmacct	2005-05-10 16:10:40.000000000 +0400
+++ ./mm/mremap.c	2005-05-12 11:56:17.000000000 +0400
@@ -224,6 +224,12 @@ static unsigned long move_vma(struct vm_
 			split = 1;
 	}
 
+	/*
+	 * if we failed to move page tables we still do total_vm increment
+	 * since do_munmap() will decrement it by old_len == new_len
+	 */
+	mm->total_vm += new_len >> PAGE_SHIFT;
+
 	if (do_munmap(mm, old_addr, old_len) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
@@ -237,7 +243,6 @@ static unsigned long move_vma(struct vm_
 			vma->vm_next->vm_flags |= VM_ACCOUNT;
 	}
 
-	mm->total_vm += new_len >> PAGE_SHIFT;
 	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
