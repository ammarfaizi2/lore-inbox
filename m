Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSFAWew>; Sat, 1 Jun 2002 18:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317084AbSFAWev>; Sat, 1 Jun 2002 18:34:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17928 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317083AbSFAWeu>;
	Sat, 1 Jun 2002 18:34:50 -0400
Message-ID: <3CF94CDE.40A55D69@zip.com.au>
Date: Sat, 01 Jun 2002 15:38:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <garzik@gtf.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 10/16] give swapper_space a set_page_dirty a_op
In-Reply-To: <3CF88908.179B10BF@zip.com.au> <20020601161424.A4535@gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> On Sat, Jun 01, 2002 at 01:42:48AM -0700, Andrew Morton wrote:
> >
> >
> > Give swapper_space a ->set_page_dirty() address_space_operation.
> 
> Remember that we don't need swapper_space at all?

swapper_space makes some sense...

> All the underlying inodes have their own address spaces, and the
> SWP_ENTRY tells us what we need to know, to find the underlying address
> spaces.
> 
> swapper_space is just a master address space that overlays the
> underlying multiple address spaces.  We can just look directly at the
> underlying ones...

Nope.  swapper_space is a single, standalone mapping which implements
its own (striped) I/O direct to block devices.  To locate the blockdev
it goes:

	swap_files[type]->f_dentry->d_inode->i_bdev

Swap never talks to d_inode->i_mapping.  If someone else is accessing that
device then their view of the device will be via bdinode->i_mapping and
is not coherent with swapper_space.

swapper_space can get at the underlying device via its own block
mapping function or via a swapfile's bmap() function.   But either
way, it goes direct to the blockdev via brw_page().

All those inodes and file*'s are just a way for swap to get directly
at the blockdev, which is a good thing for swap to be doing.

Yes, possibly we could stripe swap at the address_space level, and
switch anon pages in and out of the individual blockdev mappings.

But that's more complex, and means that swap would have to be able to
deal with external agents coming in and randomly locking its buffers
and pages (it'll oops at present if that happens, but it can't because
nobody can get at swapper_space's pages and buffers).

Plus the blockdev mapping uses PAGE_CACHE_SIZE pages, and swap
uses PAGE_SIZE pages.   I do think the design is OK as-is.

-
