Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRJCMDr>; Wed, 3 Oct 2001 08:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275608AbRJCMDh>; Wed, 3 Oct 2001 08:03:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:4108 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S276021AbRJCMDW>; Wed, 3 Oct 2001 08:03:22 -0400
Message-ID: <3BBB01F2.F82BDB46@namesys.com>
Date: Wed, 03 Oct 2001 16:17:54 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.11-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: bug? in using generic read/write functions to read/write block devices 
 in 2.4.11-pre2
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It looks like something wrong happens with writing/reading to block
device using generic read/write functions when one does:

mke2fs /dev/hda1 (blocksize is 4096)
mount /dev/hda1
umount /dev/hda1
mke2fs /dev/hda1 - FAILS with
Warning: could not write 8 blocks in inode table starting at 492004:
Attempt to write block from filesystem resulted in short write

(note that /dev/hda1 should be big enough - 3gb is enogh for example)


Explanation of what happens (could be wrong and unclear):

blocksize of /dev/hda1 was 1024. So, /dev/hda1's inode->i_blkbits is set
to 10.
mount-ing used set_blocksize() to change blocksize to 4096 in
blk_size[][].
But inode of /dev/hda1 still has i_blkbits which makes
block_prepare_write to create buffers of 1024 bytes and call
blkdev_get_block for each of them.
fs/block_dev.c:/max_block calculates number of blocks on the device
using blk_size[][] and thinks that there are 4 times less blocks on the
device.

Thanks,
vs

PS: thanks to Elena <grev@namesys.botik.ru> for finding that


