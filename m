Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274738AbRJAIDl>; Mon, 1 Oct 2001 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274736AbRJAIDc>; Mon, 1 Oct 2001 04:03:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9133 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274738AbRJAIDR>;
	Mon, 1 Oct 2001 04:03:17 -0400
Date: Mon, 1 Oct 2001 04:03:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <20011001000446.A24245@codepoet.org>
Message-ID: <Pine.GSO.4.21.0110010345110.14660-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Oct 2001, Erik Andersen wrote:

> Note the ll_rw_block msg from where the acorn stuff is not reading in units
> of the physical sector size?  Also notice the "unable to read..." msg, which
> is where acorn chokes the partition table scanning...
> 
> 
> So now, while fdisk is still able to see that partitions exist
> 
> 	[andersen@dillweed andersen]$ fdisk -l /dev/sda
> 	Note: sector size is 2048 (not 512)
> 
> 	Disk /dev/sda: 64 heads, 32 sectors, 151 cylinders
> 	Units = cylinders of 2048 * 2048 bytes
> 
> 	   Device Boot    Start       End    Blocks   Id  System
> 	/dev/sda1   *         1       151    618432   83  Linux
> 
> the acorn stuff has caused the partition scan to abort prematurely, such that
> proc partitions (and Linux) know nothing about the device's partitions.  I can
> give you a dd from one of these disks, but I doubt that would show the error... 

	OK, first of all, it's _not_ an acorn partition table at all.
It's a garden-variety DOS partition table.

	Actually, you've found a rather nasty bug in acorn.c - code in
the current tree fails if it tries to look for acorn-style partition
table on a large-sector disk.  Fails with IO error, and reports that
to high-level code in check_partitions().  Which decides to stop.
msdos_partition() would be called after acorn_partition(), so it
doesn't get called at all.

	Lovely...  OK, there are two possible fixes - one is to
add check for block size into acorn_partition() (it's checked on
almost all branches, but there's one where it's missing).  Another
is to switch to new partition code, which works with any physical
sector size.

	I'm putting the new patch on anonftp -
ftp.math.psu.edu/pub/viro/partition-c-S11-pre1

	News:
* massaged into form that should be easy to backport.
* acorn.c converted (_completely_ untested)

	Folks, please help to test that sucker. 

