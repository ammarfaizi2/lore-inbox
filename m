Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbREYPNF>; Fri, 25 May 2001 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263761AbREYPMy>; Fri, 25 May 2001 11:12:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34136 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S263760AbREYPMs>; Fri, 25 May 2001 11:12:48 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <20010523205748.L8080@redhat.com> <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com> <20010524123627.L27177@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 May 2001 09:09:37 -0600
In-Reply-To: "Stephen C. Tweedie"'s message of "Thu, 24 May 2001 12:36:27 +0100"
Message-ID: <m1bsohh3da.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> writes:

> Hi,
> 
> On Wed, May 23, 2001 at 01:01:56PM -0700, Linus Torvalds wrote:
>  
> > On Wed, 23 May 2001, Stephen C. Tweedie wrote:
> > > > that the filesystems already do. And you can do it a lot _better_ than the
> 
> > > > current buffer-cache-based approach. Done right, you can actually do all
> > > > IO in page-sized chunks, BUT fall down on sector-sized things for the
> > > > cases where you want to.
> > >
> > > Right, but you still lose the caching in that case.  The write works,
> > > but the "cache" becomes nothing more than a buffer.
> > 
> > No. It is still cached. You find the buffer with "page->buffer", and when
> > all of them are up-to-date (whether from read-in or from having written
> > to them all), you just mark the whole page up-to-date.
> 
> It works, but *only* if the application writes a whole page worth of
> data.  From the previous emails I had the understanding that this
> application is writing small data items in random 512-byte blocks.  It
> is not writing the rest of the page.  The page never becomes uptodate.
> That in itself isn't a problem, but readpage() can't tell the
> underlying layers that only a part of the page is wanted, so there's
> no way to tell readpage that the page is in fact partially uptodate.
> 
> And just telling the application to write the rest of the page too
> isn't going to cut it, because the rest of the page may contain other
> objects which aren't in cache so we can't write them without first
> reading the page.  The only alternative is to change the on-disk
> layout, forcing a minimum PAGESIZE on the IO chunks.
> 
> > This _works_. Try it on ext2 or NFS today.
> 
> Not for this workload.  Now, maybe it's not an interesting workload.
> But shifting the uptodate granularity from buffer to page sized _does_
> impact the effectiveness of the cache for such an application. 
> 
> > So in short: the page cache supports _today_ all the optimizations.
> 
> For write, perhaps; but for subsequent read, generic_read_page
> doesn't see any of the data in the page unless the whole page has been
> written.

generic_read_page???

block_read_full_page seems to handle this correctly.  At least
with respect to keeping the data around, and not doing the I/O
on data we already have.  But it still reads in the unpopulated
parts of the page even if it is unnecessary.

The case we don't get quite right are partial reads that hit cached
data, on a page that doesn't have PG_Uptodate set.  We don't actually
need to do the I/O on the surrounding page to satisfy the read
request.  But we do because generic_file_read doesn't even think about
that case.

For the small random read case we could use a 
mapping->a_ops->readpartialpage 
function that sees if a request can be satisfied entirely 
from cached data.  But this is just to allow generic_file_read
to handle this, case. 

Eric
