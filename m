Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbVHJRmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbVHJRmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVHJRmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:42:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965232AbVHJRmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:42:01 -0400
Date: Wed, 10 Aug 2005 10:40:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
Message-Id: <20050810104044.1e0da3e6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508101819340.11984@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
	<20050808160844.04d1f7ac.akpm@osdl.org>
	<Pine.LNX.4.58.0508101730441.11984@skynet>
	<20050810101714.147e1333.akpm@osdl.org>
	<Pine.LNX.4.58.0508101819340.11984@skynet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> On Wed, 10 Aug 2005, Andrew Morton wrote:
> 
> > Mel Gorman <mel@csn.ul.ie> wrote:
> > >
> > > On Mon, 8 Aug 2005, Andrew Morton wrote:
> > >
> > > > Mel Gorman <mel@csn.ul.ie> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I am working on a direct reclaim strategy to free up large blocks of
> > > > > contiguous pages. The part I have is working fine, but I am finding a
> > > > > hundreds of pages that are being used for inodes that I need to reclaim. I
> > > > > tried purging the inode lists using a variation of prune_icache() but it
> > > > > is not working out.
> > > > >
> > > > > Given a struct page, that one knows is an inode, can anyone suggest the
> > > > > best way to find the inode using it and free it?
> > > >
> > > > Simple answer: invalidate_mapping_pages(page->mapping, start, end).
> > > >
> > >
> > > The majority of pages I am seeing no longer have page->mapping set. Does
> > > this mean they are in the process of being cleared up?
> >
> > They're just anonymous pages, aren't they?  But you said "pages that are
> > being used for inodes".  Confused.
> >
> 
> So am I, I'm missing something really stupid.
> 
> What I have is the following;
> 
> 1. Add a new flag GFP_INODE to mark inode pages
> 2. Add a GFP_INODE to the flags passed to mapping_set_gfp_mask() in
>    fs/inode.c#alloc_inode(). This means that the page allocator will now
>    know when it is allocating pages for inodes
> 3. Added a PG_inode flag for page->flags which will flag all pages that
>    were allocated for inodes
> 
> (Note, I don't intend to use this flags in the long term, I've added them
> for investigation purposes).
> 
> I later linearly scan the mem_map looking for pages that can be freed up
> (usually LRU pages). I was expecting any page with PG_inode set to have a
> page->mapping but not all of them do. It is the pages without a ->mapping
> that are confusing the hell out of me.

Well there are conditions in which mmapped file pages can get converted to
anonymous pages due to truncate(), but I have a feeling that we stopped
that from happening.

Also there are situations in which truncate of a still-committing ext3
pagecache page can cause the page to remain ont he page LRUs - it's been
truncated from the file, but ext4 still has a hold of it for journalling
purposes.

You cold lock the pages then check ->mapping.
