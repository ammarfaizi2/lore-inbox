Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318988AbSIIVLZ>; Mon, 9 Sep 2002 17:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318989AbSIIVLY>; Mon, 9 Sep 2002 17:11:24 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:28609 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318988AbSIIVLX>;
	Mon, 9 Sep 2002 17:11:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Mon, 9 Sep 2002 23:08:46 +0200
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D77C8B7.1534A2DB@zip.com.au> <E17natE-0006OB-00@starship> <3D7A2410.168668CC@digeo.com>
In-Reply-To: <3D7A2410.168668CC@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oVm2-0006uh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 September 2002 18:06, Andrew Morton wrote:
> Daniel Phillips wrote:
> > > If the VM wants to reclaim a page, and it has PG_private set then
> > > the vm will run mapping->releasepage() against the page.  The mapping's
> > > releasepage must try to clear away whatever is held at ->private.  If
> > > that was successful then releasepage() must clear PG_private, decrement
> > > page->count and return non-zero.  If the info at ->private is not
> > > freeable, releasepage returns zero.  ->releasepage() may not sleep in
> > > 2.5.
> > >
> > > So.  NFS can put anything it likes at page->private.  If you're not
> > > doing that then you don't need a releasepage.  If you are doing that
> > > then you must have a releasepage().
> > 
> > Right now, there are no filesystems actually doing anything filesystem
> > specific here, are there?  I really wonder if making this field, formerly
> > known as buffers, opaque to the vfs is the right idea.
> 
> That's right - it is only used for buffers at present.  I was using
> page->private in the delayed-allocate code for directly holding the
> disk mapping information.

It's worth taking a deep breath at this point and considering whether that
part of delalloc can be written generically, supposing that page->buffers
were restored to its former non-opaque status.

> There was some talk of using it for <mumble> in XFS.

Christoph would be familiar with that issue, if there is one.

> Also it may be used in the NFS server for storing credential
> information.

The NFS server is still a deep, black hole in the kernel from my point of
view and I'd like that situation to end as soon as possible, so it might
as well start ending now.  Can you provide me a pointer to go start
digging at that specific question?

(And strongly agreed about the invalidate_inode_pages(2) issue: at some
point it would behoove VM and NFS developers to reach a mutual
understanding of what that interface is supposed to do, because it is
growing new warts and tentacles at an alarming rate, and still seems to
be, at best, a heuristic.  I currently have the impression that the
intent is to make files sort-of coherent between clients, for some
slippery definition of sort-of.)

> Also it could be used for MAP_SHARED pages for credential
> information - to fix the problem wherein kswapd (ie: root) is the
> one who instantiates the page's blocks, thus allowing non-root programs
> to consume the root-only reserved ext2/ext3 blocks.

OK, well I have four action items:

  - Listen to Christoph wax poetic about how XFS handles buffers and
    whether he needs them to be opaque to the vfs.

  - Think about delalloc with the goal of providing the mechanism at
    the vfs level, subject to somebody proving it actually has some
    benefit (maybe XFS already proves this?  Come to think of it, if
    XFS already supports delayed allocation and doesn't rely on
    page->private...)

  - Find out what NFS really thinks invalidate_inode_pages(2) is
    supposed to do.

  - Start to sniff at the credential issue, with a view to
    ascertaining whether that subsystem ultimately relies on the
    buffer field being opaque.  Intuitively I think 'no', the
    credential mechanism is supposed to be a generic vfs mechanism,
    and so for NFS or anyone else to bury credential state in the
    field formerly known as buffers is fundamentally wrong.

In general, I think we'd be better off if page->buffers was not opaque,
and that it should remain non-opaque until we are definitely ready to
get rid of them.  Doing otherwise will just allow various applications
to start growing tendrils into the field, making it that much harder
to get rid of when the time comes.

So the question is, does anyone *really* need (void *) page->private
instead of page->buffers?

-- 
Daniel
