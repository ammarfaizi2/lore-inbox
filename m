Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318901AbSIIV7L>; Mon, 9 Sep 2002 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSIIV7L>; Mon, 9 Sep 2002 17:59:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:43732 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318901AbSIIV7K>;
	Mon, 9 Sep 2002 17:59:10 -0400
Message-ID: <3D7D1AB4.B465ABE8@digeo.com>
Date: Mon, 09 Sep 2002 15:03:32 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Rik van Riel <riel@conectiva.com.br>, trond.myklebust@fys.uio.no,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <E17natE-0006OB-00@starship> <Pine.LNX.4.44L.0209071547250.1857-100000@imladris.surriel.com> <3D7A8718.E626D3C7@digeo.com> <E17oWKH-0006uw-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 22:03:48.0149 (UTC) FILETIME=[C5F17650:01C2584C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> > I'm very unkeen about using the inaccurate invalidate_inode_pages
> > for anything which matters, really.   And the consistency of pagecache
> > data matters.
> >
> > NFS should be using something stronger.  And that's basically
> > vmtruncate() without the i_size manipulation.
> 
> Yes, that looks good.  Semantics are basically "and don't come back
> until every damm page is gone" which is enforced by the requirement
> that we hold the mapping->page_lock though one entire scan of the
> truncated region.  (Yes, I remember sweating this one out a year
> or two ago so it doesn't eat 100% CPU on regular occasions.)
> 
> So, specifically, we want:
> 
> void invalidate_inode_pages(struct inode *inode)
> {
>         truncate_inode_pages(mapping, 0);
> }
> 
> Is it any harder than that?

Pretty much - need to leave i_size where it was.  But there are
apparently reasons why NFS cannot sleepingly lock pages in this particular
context.

> By the way, now that we're all happy with the radix tree, we might
> as well just go traverse that instead of all the mapping->*_pages.
> (Not that I'm seriously suggesting rocking the boat that way just
> now, but it might yield some interesting de-crufting possibilities.)

Oh absolutely.

 unsigned long radix_tree_gang_lookup(void **pointers,
		unsiged long starting_from_here, unsigned long this_many);

could be used nicely in readahead, drop_behind, truncate, invalidate
and invalidate2.  But to use it in writeback (desirable) we would need
additional metadata in radix_tree_node.  One bit per page, which means
"this page is dirty" or "this subtree has dirty pages".

I keep saying this in the hope that someone will take pity and write it.

> ...
> Now, what is this invalidate_inode_pages2 seepage about?  Called from
> one place.  Sheesh.

heh.  We still do have some O_DIRECT/pagecache coherency problems.
