Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311348AbSCLVCo>; Tue, 12 Mar 2002 16:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311346AbSCLVC0>; Tue, 12 Mar 2002 16:02:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37126 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311345AbSCLVCH>;
	Tue, 12 Mar 2002 16:02:07 -0500
Message-ID: <3C8E6C63.E8B72195@zip.com.au>
Date: Tue, 12 Mar 2002 13:00:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>,
		<3C8D9999.83F991DB@zip.com.au> <E16kkcq-0001rV-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On March 12, 2002 07:00 am, Andrew Morton wrote:
> > dallocbase-15-pageprivate
> >
> >   page->buffers is a bit of a layering violation.  Not all address_spaces
> >   have pages which are backed by buffers.
> >
> >   The exclusive use of page->buffers for buffers means that a piece of prime
> >   real estate in struct page is unavailable to other forms of address_space.
> >
> >   This patch turns page->buffers into `unsigned long page->private' and sets
> >   in place all the infrastructure which is needed to allow other address_spaces
> >   to use this storage.
> >
> >   With this change in place, the multipage-bio no-buffer_head code can use
> >   page->private to cache the results of an earlier get_block(), so repeated
> >   calls into the filesystem are not needed in the case of file overwriting.
> 
> That's pragmatic, a good short term solution.  Getting rid of page->buffers
> entirely will be nicer, and in that case you want to cache the physical block
> only for those pages that have one, e.g., not for swap-backed pages, which
> keep that information in the page table.

Really, I don't think we can lose page->buffers for *enough* users
of address_spaces to make it worthwhile.

If it was only being used for, say, blockdev inodes then we could
perhaps take it out and hash for it, but there are a ton of
filesystems out there...


The main problem I see with this patch series is that it introduces
a new way of performing writeback while leaving the old way in place.
The new way is better, I think - it's just a_ops->write_many_pages().
But at present, there are some address_spaces which support write_many_pages(),
and others which still use ->writepage() and sync_page_buffers().

This will make VM development harder, because the VM now needs to cope
with the nice, uniform, does-clustering-for-you writeback as well as
the crufty old write-little-bits-of-crap-all-over-the-disk writeback :)

I need to give the VM a uniform way of performing writeback for
all address_spaces.  My current thinking there is that all
address_spaces (even the non-delalloc, buffer_head-backed ones)
need to be taught to perform multipage clustered writeback
based on the address_space, not the dirty buffer LRU.

This is pretty deep surgery.  If it can be made to work, it'll
be nice - it will heavily deprecate the buffer_head layer and will
unify the current two-or-three different ways of performing
writeback (I've already unified all ways of performing writeback
for delalloc filesystems - my version of kupdate writeback, bdflush
writeback, vm-writeback and write(2) writeback are all unified).

> I've been playing with the idea of caching the physical block in the radix
> tree, which imposes the cost only on cache pages.  This forces you to do a
> tree probe at IO time, but that cost is probably insignificant against the
> cost of the IO.  This arrangement could make it quite convenient for the
> filesystem to exploit the structure by doing opportunistic map-ahead, i.e.,
> when ->get_block consults the metadata to fill in one physical address, why
> not fill in several more, if it's convenient?

That would be fairly easy to do.  My current writeback interface
into the filesytem is, basically, "write back N pages from your
mapping->dirty_pages list" [1].  The address_space could quite simply
whizz through that list and map all the required pages in a batched
manner.

[1] Problem with the current implementation is that I've taken
    out the guarantee that the page which the VM wanted to free
    actually has I/O started against it.  So if the VM wants to
    free something from ZONE_NORMAL, the address_space may just
    go and start writeback against 1000 ZONE_HIGHMEM pages instead.
    In practice, I suspect this doesn't matter much.  But it needs
    fixing.

    (Our current behaviour in this scenario is terrible.  Suppose
    a mapping has a mixture of dirty pages from two or more zones,
    and the VM is trying to free up a particular zone: the VM will
    *selectively* perform writepage against *some* of the dirty
    pages, and will skip writeback of pages from other zones.

    This means that we're submitting great chunks of discontiguous
    I/O.  It'll fragment the layout of sparse files and will
    greatly decrease writeout bandwidth.  We should be opportunistically
    submitting writeback against disk-contiguous and file-offset-contiguous
    pages from other zones at the same time!  I'm doing that now, but
    with the present VM design [2] I do need to provide a way to
    ensure that writeback has commenced against the target page).

[2] The more I think about it, the less I like it.  I have a feeling
    that I'll end up having to, umm, redesign the VM.  Damn.

-
