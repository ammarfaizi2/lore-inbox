Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVGMRsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVGMRsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVGMRhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:37:00 -0400
Received: from gold.veritas.com ([143.127.12.110]:1337 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262155AbVGMRf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:35:57 -0400
Date: Wed, 13 Jul 2005 18:37:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] fix page-becoming-writable in do_file_page
In-Reply-To: <Pine.LNX.4.61.0507131831100.5735@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507131836250.5735@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507131831100.5735@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Jul 2005 17:35:55.0653 (UTC) FILETIME=[52C5B350:01C587D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_user_pages force write case (from ptrace) expects that a single
call to handle_mm_fault is enough to give it a page it can safely write
to.  This implies that when handling a write access to a page_mkwrite
area, do_file_page must now itself call do_wp_page to call page_mkwrite
and (probably) make the pte writable: that cannot safely be left to a
subsequent fault.

Clarify today's flow of control in do_file_page: it is only called for a
pte_file entry, which only appears in a non-linear vma, which is always
shared and must have a populate: so the do_no_page path is never taken.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

--- 2.6.13-rc2-mm2/mm/memory.c	2005-07-07 12:33:21.000000000 +0100
+++ linux/mm/memory.c	2005-07-11 20:01:28.000000000 +0100
@@ -1968,27 +1968,38 @@ static int do_file_page(struct mm_struct
 	unsigned long pgoff;
 	int err;
 
-	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
-	/*
-	 * Fall back to the linear mapping if the fs does not support
-	 * ->populate:
-	 */
-	if (!vma->vm_ops || !vma->vm_ops->populate || 
-			(write_access && !(vma->vm_flags & VM_SHARED))) {
-		pte_clear(mm, address, pte);
-		return do_no_page(mm, vma, address, write_access, pte, pmd);
-	}
+	BUG_ON(!vma->vm_ops || !vma->vm_ops->populate);
+	BUG_ON(!(vma->vm_flags & VM_SHARED));
 
 	pgoff = pte_to_pgoff(*pte);
-
+again:
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 
-	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
+	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE,
+					vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
 	if (err)
 		return VM_FAULT_SIGBUS;
+
+	/*
+	 * For the get_user_pages force write case, we must make sure that
+	 * page_mkwrite is called by this invocation of handle_mm_fault.
+	 */
+	if (write_access && vma->vm_ops->page_mkwrite) {
+		pte_t entry;
+		int ret;
+
+		spin_lock(&mm->page_table_lock);
+		pte = pte_offset_map(pmd, address);
+		entry = *pte;
+		if (!pte_present(entry))
+			goto again;
+		ret = do_wp_page(mm, vma, address, pte, pmd, entry);
+		if (ret != VM_FAULT_MINOR)
+			return ret;
+	}
 	return VM_FAULT_MAJOR;
 }
 
