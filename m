Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbUBQFtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUBQFtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:49:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:59040 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266030AbUBQFtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:49:12 -0500
Date: Mon, 16 Feb 2004 21:49:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Linux-MM@kvack.org
Subject: Re: [PATCH] mremap NULL pointer dereference fix
In-Reply-To: <Pine.LNX.4.58.0402162127220.30742@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402162144510.30742@home.osdl.org>
References: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
 <Pine.LNX.4.58.0402162127220.30742@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Linus Torvalds wrote:
> 
> Ugly, but yes. The "!page_table_present(mm, new_addr))" code just before
> the "alloc_one_pte_map()" should already have done this, but while the 
> page tables themselves are safe due to us holding the mm semaphore, the 
> pte entry itself at "src" is not.
> 
> I hate that code, and your patch makes it even uglier. This code could do 
> with a real clean-up, but for now I think your patch will do.

Hmm.. Looking a bit more at it, does this alternate patch work? It's 
_slightly_ less ugly, and it also removes the nonsensical TLB invalidate 
instead of moving it around together with the comment that says that it 
shouldn't exist.

The TLB is (properly) invalidated by "copy_one_pte()" if the mapping 
actually changes.

Did I miss anything?

		Linus

---
===== mm/mremap.c 1.38 vs edited =====
--- 1.38/mm/mremap.c	Wed Feb  4 00:04:56 2004
+++ edited/mm/mremap.c	Mon Feb 16 21:44:26 2004
@@ -133,17 +133,21 @@
 			src = NULL;
 		}
 		dst = alloc_one_pte_map(mm, new_addr);
-		if (src == NULL)
+		if (src == NULL) {
 			src = get_one_pte_map_nested(mm, old_addr);
+			/*
+			 * "src" could be NULL now, because somebody
+			 * might have dropped the (clean) pte entry
+			 * while we did the destination pmd allocation.
+			 */
+			if (!src)
+				goto out_unmap_dst;
+		}
 		error = copy_one_pte(vma, old_addr, src, dst, &pte_chain);
 		pte_unmap_nested(src);
+out_unmap_dst:
 		pte_unmap(dst);
-	} else
-		/*
-		 * Why do we need this flush ? If there is no pte for
-		 * old_addr, then there must not be a pte for it as well.
-		 */
-		flush_tlb_page(vma, old_addr);
+	}
 	spin_unlock(&mm->page_table_lock);
 	pte_chain_free(pte_chain);
 out:
