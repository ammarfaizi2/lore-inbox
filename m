Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310169AbSCMMEX>; Wed, 13 Mar 2002 07:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310170AbSCMMEK>; Wed, 13 Mar 2002 07:04:10 -0500
Received: from dsl-213-023-039-082.arcor-ip.net ([213.23.39.82]:25486 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310169AbSCMMDo>;
	Wed, 13 Mar 2002 07:03:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Date: Wed, 13 Mar 2002 12:58:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au> <E16kkcq-0001rV-00@starship> <3C8E6C63.E8B72195@zip.com.au>
In-Reply-To: <3C8E6C63.E8B72195@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16l7Oe-0000Dk-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 10:00 pm, Andrew Morton wrote:
> Daniel Phillips wrote:
> > On March 12, 2002 07:00 am, Andrew Morton wrote:
> > >   With this change in place, the multipage-bio no-buffer_head code can 
use
> > >   page->private to cache the results of an earlier get_block(), so 
repeated
> > >   calls into the filesystem are not needed in the case of file 
overwriting.
> > 
> > That's pragmatic, a good short term solution.  Getting rid of 
page->buffers
> > entirely will be nicer, and in that case you want to cache the physical 
block
> > only for those pages that have one, e.g., not for swap-backed pages, which
> > keep that information in the page table.
> 
> Really, I don't think we can lose page->buffers for *enough* users
> of address_spaces to make it worthwhile.
> 
> If it was only being used for, say, blockdev inodes then we could
> perhaps take it out and hash for it, but there are a ton of
> filesystems out there...

That's the thrust of my current work - massaging things into a form where 
struct page can be substituted for buffer_head as the block data handle for 
the mass of filesystems that use it.
 
> The main problem I see with this patch series is that it introduces
> a new way of performing writeback while leaving the old way in place.
> The new way is better, I think - it's just a_ops->write_many_pages().
> But at present, there are some address_spaces which support 
write_many_pages(),
> and others which still use ->writepage() and sync_page_buffers().
> 
> This will make VM development harder, because the VM now needs to cope
> with the nice, uniform, does-clustering-for-you writeback as well as
> the crufty old write-little-bits-of-crap-all-over-the-disk writeback :)
> 
> I need to give the VM a uniform way of performing writeback for
> all address_spaces.  My current thinking there is that all
> address_spaces (even the non-delalloc, buffer_head-backed ones)
> need to be taught to perform multipage clustered writeback
> based on the address_space, not the dirty buffer LRU.
>
> This is pretty deep surgery.  If it can be made to work, it'll
> be nice - it will heavily deprecate the buffer_head layer and will
> unify the current two-or-three different ways of performing
> writeback (I've already unified all ways of performing writeback
> for delalloc filesystems - my version of kupdate writeback, bdflush
> writeback, vm-writeback and write(2) writeback are all unified).

For me, the missing piece of the puzzle is how to recover the semantics of 
->b_flushtime.  The crude solution is just to put that in struct page for 
now.  At least that's a wash in terms of size because ->buffers goes out.

It's not right for the long term though, because flushtime is only needed for
cache-under-io.  It's annoying to bloat up all pages for the sake of the 
block cache.  Some kind of external structure is needed that can capture both 
flushtime ordering and physical ordering, and be readily accessible from 
struct page without costing a field in struct page.  Right now that structure 
is the buffer dirty list, though that fails the requirement of not bloating 
the struct page.  It falls short by other measures as well, such as offering 
no good way to search for physical adjacency for the purpose of clustering.

I don't know what kind of thing I'm searching for here, I thought I'd dump 
the problem on you and see what happens.

-- 
Daniel
