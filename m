Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUBBXsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUBBXsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:48:39 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:62697 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S261950AbUBBXsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:48:36 -0500
Date: Mon, 2 Feb 2004 15:48:32 -0800
Message-Id: <200402022348.i12NmWcK016232@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: Andrew Morton's message of  Monday, 2 February 2004 14:46:42 -0800 <20040202144642.50ea0468.akpm@osdl.org>
X-Windows: even your dog won't like it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's a bit ugly, isn't it?  We don't want to modify the pte permissions
> in this case.  We just want the page frame.  But we do still want to call
> handle_mm_fault() if the page isn't there at all, or to COW it.

I quite agree.  My first crack was ugliness in isolation, because I
anticipated resistance to changing the function signatures in the fault
path and it seemed like a fair bit of twiddling would be required.

> One way to handle that would be to give the `write' arg to
> handle_mm_fault() a third value which means "give us a writeable page, but
> don't make the pte writeable".  Maybe that isn't warranted for this special
> case.  But it would be better, really.

It would be ideal.  However, it would also require changing the interfaces
further.  Currently handle_mm_fault just says what happened, and doesn't
give back the page directly.  get_user_pages then retakes
mm->page_table_lock and calls follow_page to look up the page.
So either handle_mm_fault would need to be able to return the page
directly, or else follow_page would need to be changed to do "force"
lookups that don't bail out when the pte is unwritable.  i.e.:

--- memory.c	20 Jan 2004 05:12:38 -0000	1.141
+++ memory.c	2 Feb 2004 23:38:57 -0000
@@ -621,7 +621,7 @@ void zap_page_range(struct vm_area_struc
  * mm->page_table_lock must be held.
  */
 struct page *
-follow_page(struct mm_struct *mm, unsigned long address, int write) 
+follow_page(struct mm_struct *mm, unsigned long address, int write, int force)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -652,7 +652,7 @@ follow_page(struct mm_struct *mm, unsign
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_write(pte))
+		if (write && !force && !pte_write(pte))
 			goto out;
 		if (write && !pte_dirty(pte)) {
 			struct page *page = pte_page(pte);


Off hand I'm not positive that is sufficient to get all the cases right
once the fault installs the proper permissions, though perhaps it is.
Remember, there is not only the writing unreadable case, but the case of
reading and writing unreadable (PROT_NONE) as well.

Then there is the issue of not making the pte writable in the first place.
pte_mkwrite is used to construct the pte in a variety of places I can see
off hand in memory.c (break_cow, do_wp_page, do_swap_page,
do_anonymous_page, do_no_page), and I haven't traced all the hugetlbpage
code paths that are also written this way.  Perhaps it would be sufficient
to change all these pte_mkwrite(pte) into pte_modify(pte, vma->vm_page_prot).
But I am not really confident right off that I know everything that's going
on here.

I've outlined the changes that I think would be sufficient (plus figuring
out the analogous changes to hugetlb stuff).  I'd be happy to give it a
try.  But I'm not at all confident to begin with that I'm aware of all the
pitfalls.


Thanks,
Roland
