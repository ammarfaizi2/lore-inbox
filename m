Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266595AbRGLVPJ>; Thu, 12 Jul 2001 17:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266603AbRGLVOR>; Thu, 12 Jul 2001 17:14:17 -0400
Received: from L0180P18.dipool.highway.telekom.at ([62.46.86.114]:444 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S266595AbRGLVOK>;
	Thu, 12 Jul 2001 17:14:10 -0400
Date: Thu, 12 Jul 2001 23:18:30 +0200
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
        linux-kernel@vger.kernel.org
Subject: Re: vfat: attempt to access beyond end of device
Message-ID: <20010712231830.A17654@aon.at>
In-Reply-To: <20010712141653.A483@c239-1.fem.tu-ilmenau.de> <87hewi2bgh.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87hewi2bgh.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 04:29:02AM +0900, you wrote:
> This bug will be fixed by the following change.
> 
> diff -urN linux-2.4.7-pre6.orig/fs/fat/inode.c linux-2.4.7-pre6/fs/fat/inode.c
> --- linux-2.4.7-pre6.orig/fs/fat/inode.c	Tue Jun 12 11:15:27 2001
> +++ linux-2.4.7-pre6/fs/fat/inode.c	Fri Jul 13 04:20:04 2001
> @@ -842,7 +842,7 @@
>  	struct super_block *sb = inode->i_sb;
>  	struct buffer_head *bh;
>  	struct msdos_dir_entry *raw_entry;
> -	int i_pos;
> +	unsigned int i_pos;
>  
>  retry:
>  	i_pos = MSDOS_I(inode)->i_location;
> 
> 
> But, should change ino/i_location/i_pos to unsigned long in
> fat/vfat/msdos/umsdos, IMHO.

When I try to write new files on it, I get:
kernel: attempt to access beyond end of device
kernel: 16:01: rw=0, want=2081231810, limit=80035798

According to his Problewm:
Shouldn't an "int" be enough?

2^31 = 2147483648
And he "wants": 2081231810

Should do, or did I miss something?



When I was tracking down this bug, I found some maybe interesting stuff
in /usr/src/linux-2.4.6/drivers/block/ll_rw_blk.c:


void generic_make_request (int rw, struct buffer_head * bh)
{
        int major = MAJOR(bh->b_rdev);
        int minorsize = 0;
        request_queue_t *q;

        if (!bh->b_end_io)
                BUG();

        /* Test device size, when known. */
        if (blk_size[major])
                minorsize = blk_size[major][MINOR(bh->b_rdev)];
        if (minorsize) {
                unsigned long maxsector = (minorsize << 1) + 1;
                unsigned long sector = bh->b_rsector;
                unsigned int count = bh->b_size >> 9;
                        ^^^^^
      /************** Shouldn't that be long? *****************/

                if (maxsector < count || maxsector - count < sector) {
                        /* Yecch */
                        bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);

                        /* This may well happen - the kernel calls bread()
                           without checking the size of the device, e.g.,
                           when mounting a device. */


      /************** Here's his error message ****************/
                        printk(KERN_INFO
                               "attempt to access beyond end of device\n");
                        printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%d\n",
                               kdevname(bh->b_rdev), rw,
                               (sector + count)>>1, minorsize);

                        /* Yecch again */
                        bh->b_end_io(bh, 0);
                        return;
                }
        }


regards, alexx
PS.: Please don't flame, if this is absolutely crap ;)
-- 
|    .-.    |   CCNAIA Alexander Griesser <tuxx@aon.at>  |   .''`.  |
|    /v\    |  http://www.tuxx-home.at -=- ICQ:63180135  |  : :' :  |
|  /(   )\  |    echo "K..?f{1,2}e[nr]böck" >>~/.score   |  `. `'   |
|   ^^ ^^   |    Linux Version 2.4.6 - Debian Unstable   |    `-    |
