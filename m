Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSEJDgM>; Thu, 9 May 2002 23:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSEJDgL>; Thu, 9 May 2002 23:36:11 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:64750 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315783AbSEJDgK>; Thu, 9 May 2002 23:36:10 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.16423.930012.986750@wombat.chubb.wattle.id.au>
Date: Fri, 10 May 2002 13:36:07 +1000
To: linux-kernel@vger.kernel.org
CC: akpm@zip.com.au, martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: [PATCH] remove 2TB block device limit
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	At present, linux is limited to 2TB filesystems even on 64-bit
systems, because there are various places where the block offset on
disc are assigned to unsigned or int 32-bit variables.

There's a type, sector_t, that's meant to hold offsets in sectors and
blocks.  It's not used consistently (yet).

The patch at
    http://www.gelato.unsw.edu.au/patches/2.5.14-largefile-patch

(also available from bk://gelato.unsw.edu.au:2023/ for those using
bitkeeper)
has the following changes to address the problem:

	bmap() changes from int bmap(struct address_space *, long)
	to		    sector_t bmap(struct address_space *,
				     sector_t)

	The partitioning code takes sector_t everywhere that makes
	sense (to allow efi, for example, to create partitions on enormous
	discs).

	The block_sizes[] array is sector_t not int.

	get_nr_sectors() and get_start_sect() etc., now return a
	sector_t

	__bread() takes a sector_t as its second argument, and struct
	buffer_head contains a sector_t blocknumber field.

	struct scsi_disk and struct gendisk have a sector_t field for
	capacity.

	The scsi disc code now uses 16-byte commands if they're
	needed.

	ioctl(..GETBLKSZ..) now fails with EFBIG if the size won't fit
	in a long. (at least for devices using the generic version).

Plus a smattering of casts to avoid compilation warnings (mostly so
that printk() works whether sector_t is 64 or 32 bits) and a new
CONFIG_LFS option to turn on 64-bit sector_t on 32-bit platforms.

On an old pentium I now have a 15Tb file mounted as JFS on the loop
device -- and it seems to work for almost everything.  There are a few
user-mode programs that'll have to be fixed (notably parted, mkfs.???
etc) to cope with the new GETBLKSIZE failure (they should use
alternate mechanisms, e.g., GETBLKSIZE64, or just seek to the end of
the partition and look at the offset).

As this touches lots of places -- the generic block layer (Andrew?)
the IDE code (Martin?) and RAID (Neil?) and minor changes to the scsi
I've CCd a few people directly.

--
Peter Chubb
Gelato@UNSW http://www.gelato.unsw.edu.au/
