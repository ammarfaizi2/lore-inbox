Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbRFFQE2>; Wed, 6 Jun 2001 12:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263521AbRFFQES>; Wed, 6 Jun 2001 12:04:18 -0400
Received: from 119-CORU-X34.libre.retevision.es ([62.83.57.119]:28546 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S263517AbRFFQEL>;
	Wed, 6 Jun 2001 12:04:11 -0400
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for initrd panic in 2.4.5
In-Reply-To: <200106060408.AAA03634@localhost.localdomain>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200106060408.AAA03634@localhost.localdomain>
Date: 06 Jun 2001 18:03:32 +0200
Message-ID: <m266e9wq7f.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "james" == James Bottomley <James.Bottomley@SteelEye.com> writes:

james> Not many people have seen this, but the i_bdev field in fake_inode in 
james> ioctl_by_bdev() is uninitialised.  Since this field is dereferenced by 
james> BLKFLSBUF in rd_ioctl, it can lead to a panic (depending on what happens to be 
james> on the stack).  The attached fixes the problem and clears all the fields in 
james> fake_inode to make any other problems like this show up.

see the fix in ac kernels,  you have a bdev there to put in the
fake_inode.

Later, Juan.


james> Index: fs/block_dev.c
james> ===================================================================
james> RCS file: /home/jejb/CVSROOT/linux/2.4/fs/block_dev.c,v
james> retrieving revision 1.1.1.10
james> diff -u -r1.1.1.10 block_dev.c
james> --- fs/block_dev.c	2001/05/26 15:33:37	1.1.1.10
james> +++ fs/block_dev.c	2001/06/02 13:14:35
james> @@ -596,13 +596,14 @@
james> int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
james> {
james> kdev_t rdev = to_kdev_t(bdev->bd_dev);
james> -	struct inode inode_fake;
james> +	struct inode inode_fake = { 0 };
james> int res;
james> mm_segment_t old_fs = get_fs();
 
james> if (!bdev->bd_op->ioctl)
james> return -EINVAL;
james> inode_fake.i_rdev=rdev;
james> +	inode_fake.i_bdev = bdev;
james> init_waitqueue_head(&inode_fake.i_wait);
james> set_fs(KERNEL_DS);
james> res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
