Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSIIVqo>; Mon, 9 Sep 2002 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSIIVqo>; Mon, 9 Sep 2002 17:46:44 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:51137 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318915AbSIIVqn>;
	Mon, 9 Sep 2002 17:46:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Mon, 9 Sep 2002 23:44:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E17natE-0006OB-00@starship> <Pine.LNX.4.44L.0209071547250.1857-100000@imladris.surriel.com> <3D7A8718.E626D3C7@digeo.com>
In-Reply-To: <3D7A8718.E626D3C7@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oWKH-0006uw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm very unkeen about using the inaccurate invalidate_inode_pages
> for anything which matters, really.   And the consistency of pagecache
> data matters.
> 
> NFS should be using something stronger.  And that's basically
> vmtruncate() without the i_size manipulation.

Yes, that looks good.  Semantics are basically "and don't come back
until every damm page is gone" which is enforced by the requirement
that we hold the mapping->page_lock though one entire scan of the
truncated region.  (Yes, I remember sweating this one out a year
or two ago so it doesn't eat 100% CPU on regular occasions.)

So, specifically, we want:

void invalidate_inode_pages(struct inode *inode)
{
	truncate_inode_pages(mapping, 0);
}

Is it any harder than that?

By the way, now that we're all happy with the radix tree, we might
as well just go traverse that instead of all the mapping->*_pages.
(Not that I'm seriously suggesting rocking the boat that way just
now, but it might yield some interesting de-crufting possibilities.)

> Hold i_sem,
> vmtruncate_list() for assured pagetable takedown, proper page
> locking to take the pages out of pagecache, etc.
> 
> Sure, we could replace the page_count() heuristic with a
> page->pte.direct heuristic.  Which would work just as well.  Or
> better.  Or worse.  Who knows?
> 
> Guys, can we sort out the NFS locking so that it is possible to
> take the correct locks to get the 100% behaviour?

Trond, will the above work?

Now, what is this invalidate_inode_pages2 seepage about?  Called from
one place.  Sheesh.

-- 
Daniel
