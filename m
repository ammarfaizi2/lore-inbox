Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbULJWJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbULJWJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULJWJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:09:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:49614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261839AbULJWIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:08:47 -0500
Date: Fri, 10 Dec 2004 14:12:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041210141258.491f3d48.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0412102125210.32422-100000@localhost.localdomain>
References: <Pine.LNX.4.58.0412101006200.8714@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0412102125210.32422-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> > > (I do wonder why do_anonymous_page calls mark_page_accessed as well as
> > > lru_cache_add_active.  The other instances of lru_cache_add_active for
> > > an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
> > > why here?  But that's nothing new with your patch, and although you've
> > > reordered the calls, the final page state is the same as before.)
> > 
> > The mark_page_accessed is likely there avoid a future fault just to set
> > the accessed bit.
> 
> No, mark_page_accessed is an operation on the struct page
> (and the accessed bit of the pte is preset too anyway).

The point is a good one - I guess that code is a holdover from earlier
implementations.

This is equivalent, no?

--- 25/mm/memory.c~do_anonymous_page-use-setpagereferenced	Fri Dec 10 14:11:32 2004
+++ 25-akpm/mm/memory.c	Fri Dec 10 14:11:42 2004
@@ -1464,7 +1464,7 @@ do_anonymous_page(struct mm_struct *mm, 
 							 vma->vm_page_prot)),
 				      vma);
 		lru_cache_add_active(page);
-		mark_page_accessed(page);
+		SetPageReferenced(page);
 		page_add_anon_rmap(page, vma, addr);
 	}
 
_

