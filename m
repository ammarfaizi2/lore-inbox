Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318886AbSIIWOo>; Mon, 9 Sep 2002 18:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSIIWOo>; Mon, 9 Sep 2002 18:14:44 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:3778 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318886AbSIIWOl>;
	Mon, 9 Sep 2002 18:14:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 10 Sep 2002 00:12:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D77C8B7.1534A2DB@zip.com.au> <E17oVm2-0006uh-00@starship> <3D7D1442.1B36E65C@digeo.com>
In-Reply-To: <3D7D1442.1B36E65C@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oWlM-0006vI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 23:36, Andrew Morton wrote:
> Daniel Phillips wrote:
> Yes, there are still reasons for delayed allocation, the space reservation
> API, etc.  But they are not compelling.  They are certainly not compelling
> when writeback continues to use the (randomly-ordered) mapping->dirty_pages
> walk.
> 
> With radix-tree enhancements to permit a pgoff_t-order walk of the
> dirty pages then yeah, order-of-magnitude gains in the tiobench
> random write pass.

Right.  Coincidently, our emails both drawing the same conclusion just
passed each other on the way through vger.

> > ...
> > In general, I think we'd be better off if page->buffers was not opaque,
> 
> Disagree.   There is zero computational cost to the current setup,

It's not a computational cost, at least not directly, it's an
organizational cost.

> and it's a little cleaner, and it permits things such as the removal
> of ->private from the pageframes, and hashing for it.

That's not really an argument, you can do that with ->buffers too,
and there is zero cost for doing it with both, separately.

> And there is plenty of precedent for putting fs-private hooks into
> core VFS data structures.

But you have to have a clear argument why.  I don't see one yet, and I
do see why the vfs wants to know about them.  None of your reasons for
wanting ->private have anything to do with buffers, they are all about
other fancy features that somebody might want to add.

> > and that it should remain non-opaque until we are definitely ready to
> > get rid of them.
> 
> There is nothing wrong with buffers, except the name.  They no longer
> buffer anything.

Understood.  However, the spelling patch to correct that would touch
the kernel in a few hundred places and break an indeterminate-but-large
number of pending patches.

> They _used_ to be the buffering entity, and an IO container, and
> the abstraction of a disk block.
>
> They are now just the abstraction of a disk block.  s/buffer_head/block/g
> should make things clearer.

Oooh, yes, that would be nice, but see above spelling patch objection.

> And there is no way in which the kernel can get along without
> some structure which represents a disk block.  It does one thing,
> and it does it well.
> 
> The page is the buffering entity.
> 
> The buffer_head is a disk block.
> 
> The BIO is the IO container.
> 
> Sometimes, for efficiency, we bypass the "block" part and go direct
> page-into-BIO.  That's a conceptually-wrong performance hack.

Right, and what I *want* to do is introduce sub-page struct pages,
along with generalizing struct page via mapping->page_size_shift, so
that we can use struct page as a handle for a block, solving a number
of nasty structural problems.  The patch to do this will be less
intrusive than you'd think at first blush, especially after
Christoph has been in there for a while longer, dunging out filemap.c.

> Yes, one could try to graft the "block" abstraction up into struct
> page, or down into struct BIO.

Err, right ;-)

> But one would be mistaken, I expect.

I expect not, but it falls to me to prove that, doesn't it?  I was
definitely not contemplating putting this forward for halloween, but
instead to undertake the grunt work when the new stable series opens
(and while *you* are busy chasing all the new bugs you made, *cackle*
*cackle*).

> >  Doing otherwise will just allow various applications
> > to start growing tendrils into the field, making it that much harder
> > to get rid of when the time comes.
> > 
> > So the question is, does anyone *really* need (void *) page->private
> > instead of page->buffers?
> 
> Don't know.  But leaving it as-is tells the world that this is
> per-fs metadata which the VM/VFS supports.  This has no cost.

It has a creeping-rot cost, because filesystems will invitably come up
with large numbers of mostly-bogus reasons for using it.  I think the
solution to this is to introduce a hashed ->private_frob_me structure
and restore ->buffers to visibility by the vfs, which needs all the
help it can get to survive the current misfit between page and block
size.

On second thought, your name change sounds really attractive, how
about:

-	struct buffer_head *buffers;
+	struct block *blocks;

Unfortunately, I can't think of any nice macro way to ease the pain
of the patch.

-- 
Daniel
