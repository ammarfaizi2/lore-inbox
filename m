Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVK2Qzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVK2Qzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVK2Qzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:55:37 -0500
Received: from silver.veritas.com ([143.127.12.111]:52587 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932201AbVK2Qzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:55:36 -0500
Date: Tue, 29 Nov 2005 16:55:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pfnmap: do_no_page BUG_ON again
In-Reply-To: <Pine.LNX.4.61.0511291650400.5527@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511291654560.5527@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511291650400.5527@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Nov 2005 16:55:36.0335 (UTC) FILETIME=[B82A51F0:01C5F505]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use copy_user_highpage directly instead of cow_user_page in do_no_page:
in the immediately following page_cache_release, and elsewhere, it is
assuming that new_page is normal.  If any VM_PFNMAP driver can get to
do_no_page, it's just a BUG (but not in the case of do_anonymous_page).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 2.6.15-rc3/mm/memory.c	2005-11-29 08:40:07.000000000 +0000
+++ linux/mm/memory.c	2005-11-29 15:59:34.000000000 +0000
@@ -1909,6 +1922,8 @@ static int do_no_page(struct mm_struct *
 	int anon = 0;
 
 	pte_unmap(page_table);
+	BUG_ON(vma->vm_flags & VM_PFNMAP);
+
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
 		sequence = mapping->truncate_count;
@@ -1941,7 +1956,7 @@ retry:
 		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!page)
 			goto oom;
-		cow_user_page(page, new_page, address);
+		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		new_page = page;
 		anon = 1;
