Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSIKAaJ>; Tue, 10 Sep 2002 20:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318243AbSIKAaJ>; Tue, 10 Sep 2002 20:30:09 -0400
Received: from dsl-213-023-020-046.arcor-ip.net ([213.23.20.46]:38108 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318240AbSIKAaF>;
	Tue, 10 Sep 2002 20:30:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Wed, 11 Sep 2002 02:27:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu> <E17orzf-0007Gn-00@starship> <3D7E8936.9882E929@digeo.com>
In-Reply-To: <3D7E8936.9882E929@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ovLv-0007JB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 02:07, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > ...
> > Andrew, did I miss something, or does the current code really ignore
> > the pte dirty bits?
> 
> Sure.  pte_dirty -> PageDirty propagation happens in page reclaim,
> and in msync.
> 
> We _could_ walk the pte chain in writeback.  But that would involve
> visiting every page in the mapping, basically.  That could hurt.

I wasn't suggesting that, I was confirming you're not going looking at
the ptes somewhere I didn't notice.

> But if a page is already dirty, and we're going to write it anyway,
> it makes tons of sense to run around and clean all the ptes which
> point at it.

Really.  Since that is what the PG_dirty bit is supposed to be telling us.

> It especially makes sense for fielmap_sync() to do that. (quickly
> edits the todo file).
>
> I'm not sure that MAP_SHARED is a good way of performing file writing,
> really.

It sure isn't just now, and it's likely to remain that way for quite some 
time.

> And not many things seem to use it for that. It's more there
> as a way for unrelated processes to find a chunk of common memory via
> the usual namespace.  Not sure about that, but I am sure that it's a
> damn pest.

One day, in a perfect world, you will dirty a mmap, fsync it, and the data  
will appear in the blink of an eye, somewhere else.  Till then it would be 
nice just to get mmaps of NFS files doing something reasonable.  We do get 
around to walking the ptes at file close I believe.  Is that not driven by 
zap_page_range, which moves any orphaned pte dirty bits down into the struct 
page?

-- 
Daniel
