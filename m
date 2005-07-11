Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVGKSRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVGKSRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGKSPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:15:33 -0400
Received: from silver.veritas.com ([143.127.12.111]:32407 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262025AbVGKSNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:13:07 -0400
Date: Mon, 11 Jul 2005 19:14:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lower VM_DONTCOPY total_vm
Message-ID: <Pine.LNX.4.61.0507111912140.1522@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jul 2005 18:13:06.0488 (UTC) FILETIME=[2FA09B80:01C58644]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dup_mmap of a VM_DONTCOPY vma forgot to lower the child's total_vm.  (But
no way does this account for the recent report of total_vm seen too low.)

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/fork.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 2.6.13-rc2-mm1/kernel/fork.c	2005-07-07 12:33:21.000000000 +0100
+++ linux/kernel/fork.c	2005-07-11 18:47:33.000000000 +0100
@@ -210,8 +210,10 @@ static inline int dup_mmap(struct mm_str
 		struct file *file;
 
 		if (mpnt->vm_flags & VM_DONTCOPY) {
+			long pages = vma_pages(mpnt);
+			mm->total_vm -= pages;
 			__vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
-							-vma_pages(mpnt));
+								-pages);
 			continue;
 		}
 		charge = 0;
