Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274093AbRIXRr0>; Mon, 24 Sep 2001 13:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274092AbRIXRrH>; Mon, 24 Sep 2001 13:47:07 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:33518 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274091AbRIXRrA>; Mon, 24 Sep 2001 13:47:00 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 24 Sep 2001 11:47:08 -0600
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924114707.Z14526@turbolinux.com>
Mail-Followup-To: Santiago Garcia Mantinan <manty@manty.net>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BAECC4F.EF25393@zip.com.au> <20010924141638.A2275@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010924141638.A2275@man.beta.es>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2001  14:16 +0200, Santiago Garcia Mantinan wrote:
> After testing this new patch on 2.4.10 I have detected a problem when trying
> to convert mounted partitions to ext3.
> 
> The problem is that on umounting the partition, with 2.4.10 kernel, the
> has_journal feature mark is removed, so the device is not detected as having
> journal on next mount.
> 
> Creating journals (converting to ext3) on partitions that are not mounted
> works ok.
> 
> Following is a practical demonstration of this in case I didn't explain
> myself well...
> 
> pul:/# grep var /etc/fstab
> /dev/hda7 /var auto rw 0 2
> pul:/# mount|grep var
> /dev/hda7 on /var type ext2 (rw)
> pul:~# tune2fs -l /dev/hda7|grep -i journal
> pul:~# ls -l /var/.journal
> ls: /var/.journal: No such file or directory
> pul:~# tune2fs -j /dev/hda7
> tune2fs 1.24a (02-Sep-2001)
> Creating journal inode: done
> This filesystem will be automatically checked every 20 mounts or
> 180 days, whichever comes first.  Use tune2fs -c or -i to override.
> pul:~# tune2fs -l /dev/hda7|grep -i journal
> Filesystem features:      has_journal filetype sparse_super
> Journal UUID:             <none>
> Journal inode:            12
> Journal device:           0x0000
> pul:~# ls -l /var/.journal
> -rw-------    1 root     root      8388608 sep 24 13:39 /var/.journal
> pul:/# umount /var
> pul:/# tune2fs -l /dev/hda7|grep -i journal
> pul:/# mount /var
> pul:/# mount|grep var
> /dev/hda7 on /var type ext2 (rw)
> pul:/# ls -l /var/.journal
> -rw-------    1 root     root      8388608 Sep 24 13:39 /var/.journal

This is because the block devices have moved to page cache, but the
internal filesystem code is still using the buffer cache - this means
that changes from user space are not seen in the kernel, and are lost
the next time that the superblock is written by the kernel.

When the block-devices-in-pagecache issue came up last, I had advocated
waiting for 2.5 to do this so that we can move ext2/ext3 into pagecache
as well (the superblock at least).  This could be done by changing the
bread/getblk stuff to be backed by pagecache as well, but nobody has
has time to do this yet.

For now, you need to do the tune2fs on an unmounted filesystem.  Since
this does not immediately "convert" the mounted filesystem to ext3
right away (you need to remount it as ext3 to get journaling to start),
then you need to unmount the fs at some time anyways.  It _does_ pose a
bit of a problem for converting the root fs, however - you will need to
boot from a rescue disk to run tune2fs on the unmounted filesystem, but
it is a one-time effort for the root fs, and it also ensures that you
have a rescue disk you can use in case of problems ;-).

The presence or absence of the ".journal" file does not indicate whether
or not the filesystem is journaled.  It is "tune2fs -l" which matters.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

