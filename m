Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVHAT5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVHAT5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVHAT5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:57:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVHATzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:55:44 -0400
Date: Mon, 1 Aug 2005 12:57:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, nickpiggin@yahoo.com.au, holt@sgi.com,
       roland@redhat.com, schwidefsky@de.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-Id: <20050801125700.4ba0807b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0508012024330.5373@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
	<42EDDB82.1040900@yahoo.com.au>
	<Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
	<Pine.LNX.4.61.0508012024330.5373@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Mon, 1 Aug 2005, Linus Torvalds wrote:
> > 
> > that "continue" will continue without the spinlock held, and now do 
> 
> Yes, I was at last about to reply on that point and others.
> I'll make those comments in a separate mail to Nick and all.
> 
> > Instead, I'd suggest changing the logic for "lookup_write". Make it 
> > require that the page table entry is _dirty_ (not writable), and then 
> 
> Attractive, I very much wanted to do that rather than change all the
> arches, but I think s390 rules it out: its pte_mkdirty does nothing,
> its pte_dirty just says no.
> 
> Whether your patch suits all other uses of (__)follow_page I've not
> investigated (and I don't see how you can go without the set_page_dirty
> if it was necessary before);

That was introduced 19 months ago by the s390 guys (see patch below).  I
don't really see why Martin decided to mark the page software-dirty at that
stage.

It's a nice thing to do from the VM dirty-memory accounting POV, but I
don't see that it's essential.

> but at present see no alternative to
> something like Nick's patch, though I'd much prefer smaller.
> 
> Or should we change s390 to set a flag in the pte just for this purpose?

That would be a good approach IMO, if possible.


From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix endless loop in get_user_pages() on s390.  It happens only on s/390
because pte_dirty always returns 0.  For all other architectures this is an
optimization.

In the case of "write && !pte_dirty(pte)" follow_page() returns NULL.  On all
architectures except s390 handle_pte_fault() will then create a pte with
pte_dirty(pte)==1 because write_access==1.  In the following, second call to
follow_page() all is fine.  With the physical dirty bit patch pte_dirty() is
always 0 for s/390 because the dirty bit doesn't live in the pte.




---

 mm/memory.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff -puN mm/memory.c~s390-16-follow_page-lockup-fix mm/memory.c
--- 25/mm/memory.c~s390-16-follow_page-lockup-fix	2004-01-18 22:36:00.000000000 -0800
+++ 25-akpm/mm/memory.c	2004-01-18 22:36:00.000000000 -0800
@@ -651,14 +651,19 @@ follow_page(struct mm_struct *mm, unsign
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (!write || (pte_write(pte) && pte_dirty(pte))) {
-			pfn = pte_pfn(pte);
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-
-				mark_page_accessed(page);
-				return page;
-			}
+		if (write && !pte_write(pte))
+			goto out;
+		if (write && !pte_dirty(pte)) {
+			struct page *page = pte_page(pte);
+			if (!PageDirty(page))
+				set_page_dirty(page);
+		}
+		pfn = pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			struct page *page = pfn_to_page(pfn);
+			
+			mark_page_accessed(page);
+			return page;
 		}
 	}
 

_

