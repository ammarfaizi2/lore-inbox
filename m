Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266055AbUFEEsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUFEEsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 00:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUFEEsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 00:48:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:9940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264582AbUFEEsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 00:48:31 -0400
Date: Fri, 4 Jun 2004 21:47:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       surendrai@esntechnologies.co.in
Subject: Re: removable media support on 2.6.x
Message-Id: <20040604214739.61232c26.akpm@osdl.org>
In-Reply-To: <1118873EE1755348B4812EA29C55A9722AF016@esnmail.esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A9722AF016@esnmail.esntechnologies.co.in>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jinu M." <jinum@esntechnologies.co.in> wrote:
>
> Hi All,
> 
> We are developing a storage driver (block driver) on 2.6.x kernel. The 
> hardware we are using supports media removal on the fly. We are facing
> some problem when the media is removed while the disk is mounted. The
> system freezes and the module count never goes to zero.
> 
> This is what we do when the disk is removed on the fly.
> 
> disk_removed(...)
> {
> 	/* invalidate disk */
> 	if(gDisk->bdev) {
> 		invalidate_bdev(gDisk->bdev, 1);
> 		bdput(gDisk->bdev);
> 	}
> 
> 	/* indicates that no disk present */
> 	set_capacity(gDisk->gd, 0);
> 
> 	/* cleanup gendisk */
> 	del_gendisk(gDisk->gd);
> 	put_disk(gDisk->gd);
> 
> 	/* clean up blkqueue */
> 	blk_cleanup_queue(gDisk->blkqueue);
> }
> 
> disk_removed() is called from the workqueue that is initiated from the
> tasklet()<=isr() on card removal.
> 
> We guess invalidate_bdev() is the culprit ;) but would like to know
> from you all if we are doing some mistake. Is there something missing
> or something wrong in the way we are trying to provide removable media
> support?
> 

afaik we don't really support hot unplug like this.

Changes were made a few months ago (make the VFS use file->f_mapping rather
than file->f_dentry->d_inode->i_mapping) which set some of the pieces in
place but I think there's a way to go yet.

umm, the general idea is that when the disk vanishes your driver should
then return -EIO for all future I/O requests.  The block_device, the queue,
the inode and all that stuff remains in-core.

After device hot unplug we need to do <something> to disassociate the
defunct blockdev inode from the /dev/hdXX node.  I think <something> hasn't
been coded yet.

Later, someone puts in new media and you can then access that via /dev/hdXX
- you get a brand new inode, blockdev, queue, etc.  The old defunct one is
still alive, returning -EIO.

Eventually, all references to the old inode/blockdev/queue go away (due to
applications hitting EIO, etc).  The old mountpoint can be unmounted and
this drops the final ref, so the old inode/blockdev/queue get freed up.

As I say, I don't think all of this is implemented yet, but perhaps a lot
of it is.
