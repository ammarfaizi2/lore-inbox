Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRLHNy5>; Sat, 8 Dec 2001 08:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRLHNyw>; Sat, 8 Dec 2001 08:54:52 -0500
Received: from dsl-213-023-038-245.arcor-ip.net ([213.23.38.245]:65039 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S280588AbRLHNya>;
	Sat, 8 Dec 2001 08:54:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Quinn Harris <quinn@nmt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Date: Sat, 8 Dec 2001 14:57:17 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu> <9us387$poh$1@cesium.transmeta.com> <1007791439.355.7.camel@quinn.rcn.nmt.edu>
In-Reply-To: <1007791439.355.7.camel@quinn.rcn.nmt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Chyk-0000zH-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 8, 2001 07:03 am, Quinn Harris wrote:
> On Fri, 2001-12-07 at 21:00, H. Peter Anvin wrote:
> > > Commands like cp and install open the source and destination file using
> > > the open sys call.  The data from the source is copied to the
> > > destination by repeatedly calling the read then write sys calls.  This
> > > process involves copying the data in the file from kernel memory space
> > > to the user memory space and back again.  Note that all this copying is
> > > done by the kernel upon calling read or write.  I would expect if this
> > > can be moved completely into the kernel no memory copy operations would
> > > be performed by the processor by using hardware DMA.
> > 
> > mmap(source file);
> > write(target file, mmap region);
>
> mmap will indeed get a file into user mem space without any memcopy
> operation.  But as far as I can tell from examining generic_file_write
> (in mm/filemap.c) used by ext2 and I asume many others, a write will
> copy the memory even if it was mapped via mmap.  Am I missing
> something?  This isn't true if kiobuf is used but as I understand it,
> this bypasses the buffer cache.
                    ^^^^^^---page

> I would like to see a zero-memcopy file copy.  A file copy that would
> read  the file into the buffer cache if its not already there similar to
> a normal read then write it back to disk from the cache without
> duplicating the pages.  This would probably lead to modifying the buffer
> cache to allow multiple buffer_heads to refer to the same data which
                          ^^^^^^^^^^^^---struct page
> might not be worth the overhead.
> 
> One might implement such a thing by attempting in the generic_file_read
                                   generic_file_write---^^^^^^^^^^^^^^^^^
> to determine if the memory range is an actual page or pages that can be
> eventually written to the disk without a memcopy.

There's some merit to this idea.  As Peter pointed out, an in-kernel cp isn't 
needed: mmap+write does the job.  The question is, how to avoid the 
copy_from_user and double caching of data?

Generic_file_write would have to determine that the source range is an mmap, 
then do the required xxx_get_block's (somehow) to determine the physical 
destination of the write, then finally use kio to dma the in-memory data to 
the destination.  (Never mind that get_block isn't a vfs method, that's a 
detail ;-)

The obvious problem is that, should somebody subsequently read the file, it's 
not in cache.  Oops, so much for the performance gain.  So some mechanism 
would have to be devised to get hold of the original page data by way of the 
destination inode, and to keep that consistent through the various 
combinations of events that can occur to the two files involved.  This is 
where things start to diverge quite a lot from the current page cache design, 
so if you're interested in pursuing this idea, a good way to start would be 
to find out why.

Before you put a lot of energy into it, you might consider measuring the 
actual cost of the memory copy versus the two disk transfers.

--
Daniel
