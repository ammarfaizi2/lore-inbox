Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUELB5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUELB5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUELB5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:57:52 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:4226 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264540AbUELBzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:55:21 -0400
Date: Tue, 11 May 2004 18:55:16 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: mc@cs.Stanford.EDU, <madan@cs.Stanford.EDU>
Subject: [CHECKER] Dereference of NULL pointer in VFS (2.4.19)
Message-ID: <Pine.GSO.4.44.0405111853360.4621-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We came accross this warning in fs/super.c.  Please confirm or clarify,
thanks!

-Junfeng


[BUG] bd_acquire's returns -ENOMEM when it fails to acquire the bdev.
get_sb_bdev does not check the return of bd_acquire.  It then dereferens
the potential NULL pointer inode->i_bdev.

fs/super.c
static struct super_block *get_sb_bdev(struct file_system_type *fs_type,
	int flags, char *dev_name, void * data)
{
	...
Alloc-->
	bd_acquire(inode);
	bdev = inode->i_bdev;
	de = devfs_get_handle_from_inode (inode);
	bdops = devfs_get_ops (de);         /*  Increments module use count  */
	if (bdops) bdev->bd_op = bdops;
	/* Done with lookups, semaphore down */
Deref-->
	dev = to_kdev_t(bdev->bd_dev);
	...
}


fs/block_dev.c
int bd_acquire(struct inode *inode)
{
	struct block_device *bdev;
	spin_lock(&bdev_lock);
	if (inode->i_bdev) {
		atomic_inc(&inode->i_bdev->bd_count);
		spin_unlock(&bdev_lock);
		return 0;
	}
	spin_unlock(&bdev_lock);
	bdev = bdget(kdev_t_to_nr(inode->i_rdev));
	if (!bdev)
		return -ENOMEM;
	spin_lock(&bdev_lock);
	if (!inode->i_bdev) {
		inode->i_bdev = bdev;
		inode->i_mapping = bdev->bd_inode->i_mapping;
		list_add(&inode->i_devices, &bdev->bd_inodes);
	} else if (inode->i_bdev != bdev)
		BUG();
	spin_unlock(&bdev_lock);
	return 0;
}

