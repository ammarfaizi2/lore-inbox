Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVHJR1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVHJR1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVHJR1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:27:36 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:55711 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965225AbVHJR1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:27:35 -0400
Date: Wed, 10 Aug 2005 18:27:26 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
In-Reply-To: <20050810101714.147e1333.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508101819340.11984@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet> <20050808160844.04d1f7ac.akpm@osdl.org>
 <Pine.LNX.4.58.0508101730441.11984@skynet> <20050810101714.147e1333.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Andrew Morton wrote:

> Mel Gorman <mel@csn.ul.ie> wrote:
> >
> > On Mon, 8 Aug 2005, Andrew Morton wrote:
> >
> > > Mel Gorman <mel@csn.ul.ie> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I am working on a direct reclaim strategy to free up large blocks of
> > > > contiguous pages. The part I have is working fine, but I am finding a
> > > > hundreds of pages that are being used for inodes that I need to reclaim. I
> > > > tried purging the inode lists using a variation of prune_icache() but it
> > > > is not working out.
> > > >
> > > > Given a struct page, that one knows is an inode, can anyone suggest the
> > > > best way to find the inode using it and free it?
> > >
> > > Simple answer: invalidate_mapping_pages(page->mapping, start, end).
> > >
> >
> > The majority of pages I am seeing no longer have page->mapping set. Does
> > this mean they are in the process of being cleared up?
>
> They're just anonymous pages, aren't they?  But you said "pages that are
> being used for inodes".  Confused.
>

So am I, I'm missing something really stupid.

What I have is the following;

1. Add a new flag GFP_INODE to mark inode pages
2. Add a GFP_INODE to the flags passed to mapping_set_gfp_mask() in
   fs/inode.c#alloc_inode(). This means that the page allocator will now
   know when it is allocating pages for inodes
3. Added a PG_inode flag for page->flags which will flag all pages that
   were allocated for inodes

(Note, I don't intend to use this flags in the long term, I've added them
for investigation purposes).

I later linearly scan the mem_map looking for pages that can be freed up
(usually LRU pages). I was expecting any page with PG_inode set to have a
page->mapping but not all of them do. It is the pages without a ->mapping
that are confusing the hell out of me.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
