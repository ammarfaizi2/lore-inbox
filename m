Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319045AbSILWqN>; Thu, 12 Sep 2002 18:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319153AbSILWqN>; Thu, 12 Sep 2002 18:46:13 -0400
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:7306 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319045AbSILWqM>;
	Thu, 12 Sep 2002 18:46:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Fri, 13 Sep 2002 00:43:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209121926310.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209121926310.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pcgD-0007m3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 00:30, Rik van Riel wrote:
> On Thu, 12 Sep 2002, Andrew Morton wrote:
> 
> > Well the lazy invalidation would be OK - defer that to the next
> > userspace access,
> 
> I think I have an idea on how to do that, here's some pseudocode:
> 
> invalidate_page(struct page * page) {
> 	SetPageInvalidated(page);
> 	rmap_lock(page);
> 	for_each_pte(pte, page) {
> 		make pte PROT_NONE;
> 		flush TLBs for this virtual address;
> 	}
> 	rmap_unlock(page);
> }
> 
> And in the page fault path:
> 
> if (pte_protection(pte) == PROT_NONE && PageInvalidated(pte_page_pte)) {
> 	clear_pte(ptep);
> 	page_cache_release(page);
> 	mm->rss--;
> }
> 
> What do you think, is this simple enough that it would work ? ;)

This is very promising.  Actually, we'd only need to do that for
pages that are currently skipped in invalidate_inode_pages.  Have
to think about possible interactions now...

-- 
Daniel
