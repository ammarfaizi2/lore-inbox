Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285842AbRLHGHo>; Sat, 8 Dec 2001 01:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285841AbRLHGHf>; Sat, 8 Dec 2001 01:07:35 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:51726 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S285842AbRLHGH2>;
	Sat, 8 Dec 2001 01:07:28 -0500
Subject: Re: File copy system call proposal
From: Quinn Harris <quinn@nmt.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <9us387$poh$1@cesium.transmeta.com>
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu> 
	<9us387$poh$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 23:03:59 -0700
Message-Id: <1007791439.355.7.camel@quinn.rcn.nmt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 21:00, H. Peter Anvin wrote:
> Followup to:  <1007782956.355.2.camel@quinn.rcn.nmt.edu>
> By author:    Quinn Harris <quinn@nmt.edu>
> In newsgroup: linux.dev.kernel
> > 
> > All kernel copy:
> > Commands like cp and install open the source and destination file using
> > the open sys call.  The data from the source is copied to the
> > destination by repeatedly calling the read then write sys calls.  This
> > process involves copying the data in the file from kernel memory space
> > to the user memory space and back again.  Note that all this copying is
> > done by the kernel upon calling read or write.  I would expect if this
> > can be moved completely into the kernel no memory copy operations would
> > be performed by the processor by using hardware DMA.
> > 
> 
> mmap(source file);
> write(target file, mmap region);
> 
> 	-hpa

mmap will indeed get a file into user mem space without any memcopy
operation.  But as far as I can tell from examining generic_file_write
(in mm/filemap.c) used by ext2 and I asume many others, a write will
copy the memory even if it was mapped via mmap.  Am I missing
something?  This isn't true if kiobuf is used but as I understand it,
this bypasses the buffer cache.

I would like to see a zero-memcopy file copy.  A file copy that would
read  the file into the buffer cache if its not already there similar to
a normal read then write it back to disk from the cache without
duplicating the pages.  This would probably lead to modifying the buffer
cache to allow multiple buffer_heads to refer to the same data which
might not be worth the overhead.

One might implement such a thing by attempting in the generic_file_read
to determine if the memory range is an actual page or pages that can be
eventually written to the disk without a memcopy.  This could
conceivably make duplications between different files to not take up
duplicate pages.  But what is the chance that there are any sizeable
number of identical pages in the buffer cache do to anything but a file
copy?


