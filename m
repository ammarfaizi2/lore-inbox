Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbULKJXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbULKJXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 04:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbULKJXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 04:23:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46224 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261923AbULKJXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 04:23:47 -0500
Date: Sat, 11 Dec 2004 09:23:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: clameter@sgi.com, <torvalds@osdl.org>, <benh@kernel.crashing.org>,
       <nickpiggin@yahoo.com.au>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <20041210165745.38c1930e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0412110914280.1535-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > My inclination would be simply to remove the mark_page_accessed
> > from do_anonymous_page; but I have no numbers to back that hunch.
> 
> With the current implementation of page_referenced() the
> software-referenced bit doesn't matter anyway, as long as the pte's
> referenced bit got set.  So as long as the thing is on the active list, we
> can simply remove the mark_page_accessed() call.

Yes, you're right.  So we don't need numbers, can just delete that line.

> Except one day the VM might get smarter about pages which are both
> software-referenced and pte-referenced.

And on that day, we'd be making other changes, which might well
involve restoring the mark_page_accessed to do_anonymous_page
and adding it in the similar places which currently lack it.

But for now...

--- 2.6.10-rc3/mm/memory.c	2004-12-05 12:56:12.000000000 +0000
+++ linux/mm/memory.c	2004-12-11 09:18:39.000000000 +0000
@@ -1464,7 +1464,6 @@ do_anonymous_page(struct mm_struct *mm, 
 							 vma->vm_page_prot)),
 				      vma);
 		lru_cache_add_active(page);
-		mark_page_accessed(page);
 		page_add_anon_rmap(page, vma, addr);
 	}
 

