Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbUBLUdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUBLUdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:33:24 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:32937 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S266478AbUBLUdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:33:12 -0500
Date: Thu, 12 Feb 2004 21:33:07 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: 2.6.3-rc2-mm1 (dm)
Message-ID: <20040212203306.GA13192@cistron.nl>
References: <20040212015710.3b0dee67.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/
> +dm-01-export-dm_vcalloc.patch
> +dm-02-move-to_bytes-to_sectors.patch
> +dm-03-remove-dm_deferred_io.patch
> +dm-04-maintain-bio-ordering.patch
> +dm-05-alloc_dev-error-cleanup.patch
> +dm-07-dm_table_create-GFP-fix.patch
> +dm-08-zero-size-target-fix.patch
> +dm-09-dec_pending-locking-cleanup.patch
> +dm-10-drop-BIO_SEG_VALID.patch

The maintain-bio-ordering patch mostly fixes the performance problem
I was seeing on XFS-over-LVM-on-3ware-raid5. (See my earlier message
at http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0684.html )
Excellent!

However there's still one issue:

I created a LVM volume on /dev/sda2, called /dev/vg0/test. Then
I created and mounted an XFS partition on /dev/vg0/test. XFS uses
a 512 byte blocksize by default, but the underlying /dev/sda2
device had a soft blocksize of 4096 (default after boot is 1024,
but I had been mucking around with it so it got set to 4096).

As a result, I couldn't get more than 35 MB/sec write speed out
of XFS mounted on the LVM device.

I added this little patch:

--- drivers/md/dm-table.c.ORIG  2004-02-12 20:49:47.000000000 +0100
+++ drivers/md/dm-table.c       2004-02-12 20:56:59.000000000 +0100
@@ -361,7 +361,7 @@
                blkdev_put(bdev, BDEV_RAW);
        else {
                d->bdev = bdev;
-               set_blocksize(bdev, d->bdev->bd_block_size);
+               set_blocksize(bdev, 512);
        }
        return r;
 }

This forces the underlying device(s) to a soft blocksize of 512. And
I had my 80 MB/sec write speed back !

I'm not sure if setting the blocksize of the underlying device
always to 512 is the right solution. I think that set_blocksize
for dm devices should also set the size for the underlying devices,
but that probably means adding an extra hook so that
set_blocksize can call bdev->bd_disk->fops->set_blocksize(bdev, size).
Which, in the case of dm, would basically call set_blocksize for the
underlying devices again.

Correct ?

Mike.
