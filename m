Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTJQQVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTJQQVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:21:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:65271 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263553AbTJQQVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:21:34 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Joe Thornber <thornber@sistina.com>
Subject: Re: online resizing of devices/filesystems (2.6)
Date: Fri, 17 Oct 2003 11:16:07 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171116.07362.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2003, Joe Thornber wrote:
> Hi,
> 
> Should genhd.h:set_capacity() find and update the i_size field of the
> inode for the device ?
> 
> The BLKGETSIZE and BLKGETSIZE64 ioctls report the size in the devices
> inode:
> 
> 	case BLKGETSIZE:
> 		if ((bdev->bd_inode->i_size >> 9) > ~0UL)
> 			return -EFBIG;
> 		return put_ulong(arg, bdev->bd_inode->i_size >> 9);
> 	case BLKGETSIZE64:
> 		return put_u64(arg, bdev->bd_inode->i_size);
> 
> Currently people have to close and reopen the device in order for a
> size change to take effect.  This is a problem if people want to do
> online resizing of a filesystem (supported by xfs and resier).

Has anyone had any thoughts about this issue?

To recap, in drivers/md/dm.c:__bind(), there is a call to set_capacity(), 
which sets the device size in the gendisk entry. But if the device is already 
open (e.g., mounted, or in use by another device (loop, raid, other 
device-mapper)), then the bdev->bd_inode->i_size field for that gendisk entry 
also needs to be updated to reflect this new size to the VFS.

My initial thoughts were to add something like this to the __bind() function 
mentioned above:

bdev = bdget_disk(md->disk, 0);
if (bdev) {
	bd_set_size(bdev, size << 9);
	bdput(bdev);
}

Of course, bd_set_size() is static to fs/block_dev.c, but it does seem to do 
exactly what we need in this situation. The only user of bd_set_size() is 
do_open(), which does quite a bit of locking before making modifications to 
the block_device entry.

Does anyone have any advice as to whether this is the correct approach, or 
what additional locking is necessary? Or is there a different approach that 
I'm overlooking?

Thanks!
-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

