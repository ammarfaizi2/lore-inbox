Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276981AbRJCVJf>; Wed, 3 Oct 2001 17:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276980AbRJCVJZ>; Wed, 3 Oct 2001 17:09:25 -0400
Received: from dermis.amis.com ([207.141.5.253]:20100 "HELO dermis.amis.com")
	by vger.kernel.org with SMTP id <S276981AbRJCVJN>;
	Wed, 3 Oct 2001 17:09:13 -0400
Message-ID: <3BBB7E8C.89B78444@amis.com>
Date: Wed, 03 Oct 2001 15:09:32 -0600
From: Eric Whiting <ewhiting@amis.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
        "jfs-discussion@oss.software.ibm.com" 
	<jfs-discussion@www-124.southbury.usf.ibm.com>
CC: reiserfs-list@namesys.com, Chris Mason <mason@suse.com>
Subject: Buffer cache confusion? Re: [reiserfs-list] bug? in using generic 
 read/write functions to read/write block devices in 2.4.11-pre2
In-Reply-To: <3BBB01F2.F82BDB46@namesys.com>
X-MIMETrack: Itemize by SMTP Server on mx1/amis(Release 5.0.8 |June 18, 2001) at 10/03/2001
 03:09:34 PM,
	Serialize by Router on mx1/amis(Release 5.0.8 |June 18, 2001) at 10/03/2001
 03:09:37 PM,
	Serialize complete at 10/03/2001 03:09:37 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I see a similar odd failure with jfs in 2.4.11pre1. Is this related to
the 2.4.11preX buffer cache improvements?

eric


# uname -a
2.4.11-pre1 #1 SMP Tue Oct 2 12:28:07 MDT 2001 i686
# mkfs.jfs /dev/hdc3
mkfs.jfs development version: $Name: v1_0_6 $
Warning!  All data on device /dev/hdc3 will be lost!
Continue? (Y/N) Y
Format completed successfully.
10241436 kilobytes total disk space.
# mount -t jfs /dev/hdc3 /mnt
mount: wrong fs type, bad option, bad superblock on /dev/hdc3,
        or too many mounted file systems


"Vladimir V. Saveliev" wrote:
> 
> Hi
> 
> It looks like something wrong happens with writing/reading to block
> device using generic read/write functions when one does:
> 
> mke2fs /dev/hda1 (blocksize is 4096)
> mount /dev/hda1
> umount /dev/hda1
> mke2fs /dev/hda1 - FAILS with
> Warning: could not write 8 blocks in inode table starting at 492004:
> Attempt to write block from filesystem resulted in short write
> 
> (note that /dev/hda1 should be big enough - 3gb is enogh for example)
> 
> Explanation of what happens (could be wrong and unclear):
> 
> blocksize of /dev/hda1 was 1024. So, /dev/hda1's inode->i_blkbits is set
> to 10.
> mount-ing used set_blocksize() to change blocksize to 4096 in
> blk_size[][].
> But inode of /dev/hda1 still has i_blkbits which makes
> block_prepare_write to create buffers of 1024 bytes and call
> blkdev_get_block for each of them.
> fs/block_dev.c:/max_block calculates number of blocks on the device
> using blk_size[][] and thinks that there are 4 times less blocks on the
> device.
> 
> Thanks,
> vs
> 
> PS: thanks to Elena <grev@namesys.botik.ru> for finding that
