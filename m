Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319017AbSIIVbo>; Mon, 9 Sep 2002 17:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319018AbSIIVbo>; Mon, 9 Sep 2002 17:31:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:48595 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319017AbSIIVbl>;
	Mon, 9 Sep 2002 17:31:41 -0400
Message-ID: <3D7D1442.1B36E65C@digeo.com>
Date: Mon, 09 Sep 2002 14:36:02 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77C8B7.1534A2DB@zip.com.au> <E17natE-0006OB-00@starship> <3D7A2410.168668CC@digeo.com> <E17oVm2-0006uh-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 21:36:18.0498 (UTC) FILETIME=[EEACB220:01C25848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Saturday 07 September 2002 18:06, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > > If the VM wants to reclaim a page, and it has PG_private set then
> > > > the vm will run mapping->releasepage() against the page.  The mapping's
> > > > releasepage must try to clear away whatever is held at ->private.  If
> > > > that was successful then releasepage() must clear PG_private, decrement
> > > > page->count and return non-zero.  If the info at ->private is not
> > > > freeable, releasepage returns zero.  ->releasepage() may not sleep in
> > > > 2.5.
> > > >
> > > > So.  NFS can put anything it likes at page->private.  If you're not
> > > > doing that then you don't need a releasepage.  If you are doing that
> > > > then you must have a releasepage().
> > >
> > > Right now, there are no filesystems actually doing anything filesystem
> > > specific here, are there?  I really wonder if making this field, formerly
> > > known as buffers, opaque to the vfs is the right idea.
> >
> > That's right - it is only used for buffers at present.  I was using
> > page->private in the delayed-allocate code for directly holding the
> > disk mapping information.
> 
> It's worth taking a deep breath at this point and considering whether that
> part of delalloc can be written generically, supposing that page->buffers
> were restored to its former non-opaque status.

The main motivation for that code was to fix the computational cost
of the buffer layer by doing a complete end-around.  That problem
was later solved by fixing the buffer layer.

Yes, there are still reasons for delayed allocation, the space reservation
API, etc.  But they are not compelling.  They are certainly not compelling
when writeback continues to use the (randomly-ordered) mapping->dirty_pages
walk.

With radix-tree enhancements to permit a pgoff_t-order walk of the
dirty pages then yeah, order-of-magnitude gains in the tiobench
random write pass.

> > Also it may be used in the NFS server for storing credential
> > information.
> 
> The NFS server is still a deep, black hole in the kernel from my point of
> view and I'd like that situation to end as soon as possible, so it might
> as well start ending now.  Can you provide me a pointer to go start
> digging at that specific question?

NFS client.  Me too.
 
> (And strongly agreed about the invalidate_inode_pages(2) issue: at some
> point it would behoove VM and NFS developers to reach a mutual
> understanding of what that interface is supposed to do, because it is
> growing new warts and tentacles at an alarming rate, and still seems to
> be, at best, a heuristic.  I currently have the impression that the
> intent is to make files sort-of coherent between clients, for some
> slippery definition of sort-of.)

I've been discussing that with Chuck.  I'd prefer that the NFS client
use a flavour of vmtruncate(), with its strong guarantees.  But we
won't know how horrid that is from a locking perspective until Trond
returns.
 
> ...
> In general, I think we'd be better off if page->buffers was not opaque,

Disagree.   There is zero computational cost to the current setup,
and it's a little cleaner, and it permits things such as the removal
of ->private from the pageframes, and hashing for it.

And there is plenty of precedent for putting fs-private hooks into
core VFS data structures.

> and that it should remain non-opaque until we are definitely ready to
> get rid of them.

There is nothing wrong with buffers, except the name.  They no longer
buffer anything.

They _used_ to be the buffering entity, and an IO container, and
the abstraction of a disk block.

They are now just the abstraction of a disk block.  s/buffer_head/block/g
should make things clearer.

And there is no way in which the kernel can get along without
some structure which represents a disk block.  It does one thing,
and it does it well.

The page is the buffering entity.

The buffer_head is a disk block.

The BIO is the IO container.

Sometimes, for efficiency, we bypass the "block" part and go direct
page-into-BIO.  That's a conceptually-wrong performance hack.

Yes, one could try to graft the "block" abstraction up into struct
page, or down into struct BIO.  But one would be mistaken, I expect.

>  Doing otherwise will just allow various applications
> to start growing tendrils into the field, making it that much harder
> to get rid of when the time comes.
> 
> So the question is, does anyone *really* need (void *) page->private
> instead of page->buffers?

Don't know.  But leaving it as-is tells the world that this is
per-fs metadata which the VM/VFS supports.  This has no cost.
