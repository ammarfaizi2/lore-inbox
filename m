Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbSLLJEe>; Thu, 12 Dec 2002 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSLLJEc>; Thu, 12 Dec 2002 04:04:32 -0500
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:60178 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267446AbSLLJEW>; Thu, 12 Dec 2002 04:04:22 -0500
Date: Thu, 12 Dec 2002 09:12:09 +0000
To: Wil Reichert <wilreichert@yahoo.com>
Cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: "bio too big" error
Message-ID: <20021212091209.GA1299@reti>
References: <20021211234557.GF16615@kroah.com> <20021212001542.51940.qmail@web40109.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021212001542.51940.qmail@web40109.mail.yahoo.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 04:15:42PM -0800, Wil Reichert wrote:
> Ok, 2.5.51 plus dm patches result in the following:
> 
> Initializing LVM: device-mapper: device
> /dev/ide/host2/bus1/target0/lun0/disc too small for target
> device-mapper: internal error adding target to table
> device-mapper: destroying table
>   device-mapper ioctl cmd 2 failed: Invalid argument
>   Couldn't load device 'cheese_vg-blah'.
>   0 logical volume(s) in volume group "cheese_vg" now active
> lvm2.
> 
> Was fine (minus of course the entire bio thing) in 50, did something
> break in 51 or is it just my box?

I've had a couple of reports of this problem.  The offending patch is:

http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/2.5.51-dm-1/00005.patch

back it out if necc.


All it does is:

--- diff/drivers/md/dm-table.c	2002-12-11 11:59:51.000000000 +0000
+++ source/drivers/md/dm-table.c	2002-12-11 12:00:00.000000000 +0000
@@ -388,7 +388,7 @@
 static int check_device_area(struct dm_dev *dd, sector_t start, sector_t len)
 {
 	sector_t dev_size;
-	dev_size = dd->bdev->bd_inode->i_size;
+	dev_size = dd->bdev->bd_inode->i_size >> SECTOR_SHIFT;
 	return ((start < dev_size) && (len <= (dev_size - start)));
 }


ie. previously we were accidentally comparing bytes with sectors to
verify the device sizes.  So either I'm being very stupid (likely) and
the above patch is bogus, or you really don't have room for this lv.
Can you send me 3 bits of information please:

1) disk/partition sizes for your PVs
2) an LVM2 backup of the metadata (the nice readable ascii one).
3) The version of LVM that *created* the lv.

Thanks,

- Joe
