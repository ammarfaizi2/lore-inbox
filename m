Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbREXLgr>; Thu, 24 May 2001 07:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbREXLgh>; Thu, 24 May 2001 07:36:37 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:18191 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261547AbREXLgg>; Thu, 24 May 2001 07:36:36 -0400
Date: Thu, 24 May 2001 12:36:27 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010524123627.L27177@redhat.com>
In-Reply-To: <20010523205748.L8080@redhat.com> <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, May 23, 2001 at 01:01:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 23, 2001 at 01:01:56PM -0700, Linus Torvalds wrote:
 
> On Wed, 23 May 2001, Stephen C. Tweedie wrote:
> > > that the filesystems already do. And you can do it a lot _better_ than the
> > > current buffer-cache-based approach. Done right, you can actually do all
> > > IO in page-sized chunks, BUT fall down on sector-sized things for the
> > > cases where you want to.
> >
> > Right, but you still lose the caching in that case.  The write works,
> > but the "cache" becomes nothing more than a buffer.
> 
> No. It is still cached. You find the buffer with "page->buffer", and when
> all of them are up-to-date (whether from read-in or from having written
> to them all), you just mark the whole page up-to-date.

It works, but *only* if the application writes a whole page worth of
data.  From the previous emails I had the understanding that this
application is writing small data items in random 512-byte blocks.  It
is not writing the rest of the page.  The page never becomes uptodate.
That in itself isn't a problem, but readpage() can't tell the
underlying layers that only a part of the page is wanted, so there's
no way to tell readpage that the page is in fact partially uptodate.

And just telling the application to write the rest of the page too
isn't going to cut it, because the rest of the page may contain other
objects which aren't in cache so we can't write them without first
reading the page.  The only alternative is to change the on-disk
layout, forcing a minimum PAGESIZE on the IO chunks.

> This _works_. Try it on ext2 or NFS today.

Not for this workload.  Now, maybe it's not an interesting workload.
But shifting the uptodate granularity from buffer to page sized _does_
impact the effectiveness of the cache for such an application. 

> So in short: the page cache supports _today_ all the optimizations.

For write, perhaps; but for subsequent read, generic_read_page
doesn't see any of the data in the page unless the whole page has been
written.

--Stephen
