Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbUBQElc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUBQEl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:41:29 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:13952 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S265980AbUBQElV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:41:21 -0500
Date: Mon, 16 Feb 2004 23:41:17 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@blue.engin.umich.edu
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, <Linux-MM@kvack.org>
Subject: [PATCH] mremap NULL pointer dereference fix
Message-ID: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This path fixes a NULL pointer dereference bug in mremap. In
move_one_page we need to re-check the src because an allocation
for the dst page table can drop page_table_lock, and somebody
else can invalidate the src.

In my old Quad Pentium II 200MHz 256MB, with 2.6.3-rc3-mm1-preempt,
I could hit the NULL pointer dereference bug with the program in the
following URL:

  http://www-personal.engin.umich.edu/~vrajesh/linux/mremap-nullptr/

Full trace of the bug can be found at the above URL. A partial call
trace is below.

kernel: PREEMPT SMP

kernel: EIP is at copy_one_pte+0x12/0xa0

kernel:  [<c01558a3>] move_one_page+0xa3/0x110
kernel:  [<c0155947>] move_page_tables+0x37/0x80
kernel:  [<c0155a1a>] move_vma+0x8a/0x5e0
kernel:  [<c015620c>] do_mremap+0x29c/0x3d0
kernel:  [<c015638d>] sys_mremap+0x4d/0x6d
kernel:  [<c03d5ee7>] syscall_call+0x7/0xb

Please apply.


 mm/mremap.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff -puN mm/mremap.c~nullptr mm/mremap.c
--- mmlinux-2.6/mm/mremap.c~nullptr	2004-02-16 17:24:00.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mremap.c	2004-02-16 17:24:00.000000000 -0500
@@ -135,17 +135,31 @@ move_one_page(struct vm_area_struct *vma
 		dst = alloc_one_pte_map(mm, new_addr);
 		if (src == NULL)
 			src = get_one_pte_map_nested(mm, old_addr);
+		/*
+		 * Since alloc_one_pte_map can drop and re-acquire
+		 * page_table_lock, we should re-check the src entry...
+		 */
+		if (src == NULL) {
+			pte_unmap(dst);
+			goto flush_out;
+		}
 		error = copy_one_pte(vma, old_addr, src, dst, &pte_chain);
 		pte_unmap_nested(src);
 		pte_unmap(dst);
-	} else
-		/*
-		 * Why do we need this flush ? If there is no pte for
-		 * old_addr, then there must not be a pte for it as well.
-		 */
-		flush_tlb_page(vma, old_addr);
+		goto unlock_out;
+	}
+
+flush_out:
+	/*
+	 * Why do we need this flush ? If there is no pte for
+	 * old_addr, then there must not be a pte for it as well.
+	 */
+	flush_tlb_page(vma, old_addr);
+
+unlock_out:
 	spin_unlock(&mm->page_table_lock);
 	pte_chain_free(pte_chain);
+
 out:
 	return error;
 }

_

