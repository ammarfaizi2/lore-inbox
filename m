Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbUBQFbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBQFbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:31:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:33687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265709AbUBQFa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:30:59 -0500
Date: Mon, 16 Feb 2004 21:31:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org, Linux-MM@kvack.org
Subject: Re: [PATCH] mremap NULL pointer dereference fix
Message-Id: <20040216213159.7835f010.akpm@osdl.org>
In-Reply-To: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
References: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian <vrajesh@umich.edu> wrote:
>
> This path fixes a NULL pointer dereference bug in mremap. In
>  move_one_page we need to re-check the src because an allocation
>  for the dst page table can drop page_table_lock, and somebody
>  else can invalidate the src.

OK.

>  In my old Quad Pentium II 200MHz 256MB, with 2.6.3-rc3-mm1-preempt,
>  I could hit the NULL pointer dereference bug with the program in the
>  following URL:
> 
>    http://www-personal.engin.umich.edu/~vrajesh/linux/mremap-nullptr/

I cannot make any oops happen with that test app.  On a 2-way,
CONFIG_PREEMPT=y.


I think we can simplify things in there a bit.  How does this look?


 mm/mremap.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -puN mm/mremap.c~mremap-oops-fix mm/mremap.c
--- 25/mm/mremap.c~mremap-oops-fix	2004-02-16 20:53:25.000000000 -0800
+++ 25-akpm/mm/mremap.c	2004-02-16 21:00:05.000000000 -0800
@@ -135,15 +135,17 @@ move_one_page(struct vm_area_struct *vma
 		dst = alloc_one_pte_map(mm, new_addr);
 		if (src == NULL)
 			src = get_one_pte_map_nested(mm, old_addr);
-		error = copy_one_pte(vma, old_addr, src, dst, &pte_chain);
-		pte_unmap_nested(src);
-		pte_unmap(dst);
-	} else
 		/*
-		 * Why do we need this flush ? If there is no pte for
-		 * old_addr, then there must not be a pte for it as well.
+		 * Since alloc_one_pte_map can drop and re-acquire
+		 * page_table_lock, we should re-check the src entry...
 		 */
-		flush_tlb_page(vma, old_addr);
+		if (src) {
+			error = copy_one_pte(vma, old_addr, src,
+						dst, &pte_chain);
+			pte_unmap_nested(src);
+		}
+		pte_unmap(dst);
+	}
 	spin_unlock(&mm->page_table_lock);
 	pte_chain_free(pte_chain);
 out:

_

