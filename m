Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSFDWLC>; Tue, 4 Jun 2002 18:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSFDWK0>; Tue, 4 Jun 2002 18:10:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316878AbSFDWKG>;
	Tue, 4 Jun 2002 18:10:06 -0400
Message-ID: <3CFD3A6D.6DC93964@zip.com.au>
Date: Tue, 04 Jun 2002 15:08:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CFD25A2.FCC7F66A@zip.com.au> <Pine.LNX.4.44.0206041428080.983-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 4 Jun 2002, Andrew Morton wrote:
> >
> > There's a patch at
> > http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre10/ext3-reloc-page.patch
> > which provides a simple `relocate page' ioctl for ext3 files.
> 
> That's a good start, but before even egtting that far there is some need
> for a way to get a picture of the FS layout in a reasonably fs-independent
> way.
> 
> Sure, bmap() actually does part of this (the "where are my blocks" part),
> but right now there is no way to query the FS for the "where can I put
> blocks" part.

Jeff Garzik was working on that a while back - a separate filesystem
which provides a "metadata view" of a real filesytem.  So you can
poke around and find all these things out.  In theory, different
filesystems should be able to offer the same view.

> You can do it with direct disk access and knowledge of the FS internals,
> but it should not be all that hard to add some simple interface to get a
> "block usage byte array" kind of thing (more efficient than doing bmap on
> all files, _and_ can tell about blocks reserved for inodes, superblocks
> and other special uses), which together with a user-level interface to
> "preallocate" and your "relocate page" should actually make it possible to
> make a fairly FS-independent defragmenter.

The e2fsprogs package includes a `libe2fs' library which offers
APIs for accessing the fs internals.  It's exactly what you
say - direct disk access and knowledge of internals.  So
that plus the try_to_relocate_page() ioctl is a shortest-path
route to a defragmenter for ext3, and only ext3.  I wasn't
aiming very high here ;)

A totally different way of performing defrag could be to
copy the entire fs from one partition to a different one,
with kernel support for providing coherency while the copy
is in progress.  It's basically a union/translucent mount
with COW.  Swizzle the backing blockdev, drop the disk
mappings from all incore pages, renumber the inode without
breaking stuff...  (OK, I've talked myself out of it ;/) It's
not super efficient, and it does require the provisioning of a
bounce disk, but it would use infrastructure which would be
useful for other stuff and it is fs-agnostic.

-
