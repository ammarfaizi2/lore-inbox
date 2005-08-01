Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVHAPpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVHAPpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVHAPnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:43:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262226AbVHAPmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:42:54 -0400
Date: Mon, 1 Aug 2005 08:42:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <42EDDB82.1040900@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Nick Piggin wrote:
> 
> Not sure if this should be fixed for 2.6.13. It can result in
> pagecache corruption: so I guess that answers my own question.

Hell no.

This patch is clearly untested and must _not_ be applied:

+                               case VM_FAULT_RACE:
+                                       /*
+                                        * Someone else got there first.
+                                        * Must retry before we can assume
+                                        * that we have actually performed
+                                        * the write fault (below).
+                                        */
+                                       if (write)
+                                               continue;
+                                       break;

that "continue" will continue without the spinlock held, and now do 
follow_page() will run without page_table_lock, _and_ it will release the 
spinlock once more afterwards, so if somebody else is racing on this, we 
might remove the spinlock for them too.

Don't do it.

Instead, I'd suggest changing the logic for "lookup_write". Make it 
require that the page table entry is _dirty_ (not writable), and then 
remove the line that says:

	lookup_write = write && !force;

and you're now done. A successful mm fault for write _should_ always have 
marked the PTE dirty (and yes, part of testing this would be to verify 
that this is true - but since architectures that don't have HW dirty 
bits depend on this anyway, I'm pretty sure it _is_ true).

Ie something like the below (which is totally untested, obviously, but I 
think conceptually is a lot more correct, and obviously a lot simpler).

		Linus

----
diff --git a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -811,18 +811,15 @@ static struct page *__follow_page(struct
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_write(pte))
+		if (write && !pte_dirty(pte))
 			goto out;
 		if (read && !pte_read(pte))
 			goto out;
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (accessed) {
-				if (write && !pte_dirty(pte) &&!PageDirty(page))
-					set_page_dirty(page);
+			if (accessed)
 				mark_page_accessed(page);
-			}
 			return page;
 		}
 	}
@@ -972,14 +969,6 @@ int get_user_pages(struct task_struct *t
 				default:
 					BUG();
 				}
-				/*
-				 * Now that we have performed a write fault
-				 * and surely no longer have a shared page we
-				 * shouldn't write, we shouldn't ignore an
-				 * unwritable page in the page table if
-				 * we are forcing write access.
-				 */
-				lookup_write = write && !force;
 				spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {
