Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965667AbWKGSCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965667AbWKGSCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965664AbWKGSCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:02:10 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:8923 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965326AbWKGSCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:02:06 -0500
Date: Tue, 7 Nov 2006 19:01:27 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107180127.GC29746@wohnheim.fh-wedel.de>
References: <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <20061107174217.GA29746@wohnheim.fh-wedel.de> <20061107175601.GB29746@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061107175601.GB29746@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the last one is xfs_mapping_buftarg().  I am completely at a loss.
As far as I can tell, inode allocated, partially initiated and -
leaked.  Am I missing something?

STATIC int
xfs_mapping_buftarg(
	xfs_buftarg_t		*btp,
	struct block_device	*bdev)
{
	struct backing_dev_info	*bdi;
	struct inode		*inode;
	struct address_space	*mapping;
	static const struct address_space_operations mapping_aops = {
		.sync_page = block_sync_page,
		.migratepage = fail_migrate_page,
	};

	inode = new_inode(bdev->bd_inode->i_sb);
	if (!inode) {
		printk(KERN_WARNING
			"XFS: Cannot allocate mapping inode for device %s\n",
			XFS_BUFTARG_NAME(btp));
		return ENOMEM;
	}
	inode->i_mode = S_IFBLK;
	inode->i_bdev = bdev;
	inode->i_rdev = bdev->bd_dev;
	bdi = blk_get_backing_dev_info(bdev);
	if (!bdi)
		bdi = &default_backing_dev_info;
	mapping = &inode->i_data;
	mapping->a_ops = &mapping_aops;
	mapping->backing_dev_info = bdi;
	mapping_set_gfp_mask(mapping, GFP_NOFS);
	btp->bt_mapping = mapping;
	return 0;
}


Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
