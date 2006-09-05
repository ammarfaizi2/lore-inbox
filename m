Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbWIESF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbWIESF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWIESF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:05:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:15066 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965262AbWIESF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:05:57 -0400
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
From: Badari Pulavarty <pbadari@gmail.com>
To: Will Simoneau <simoneau@ele.uri.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060905171049.GB27433@ele.uri.edu>
References: <20060905171049.GB27433@ele.uri.edu>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 11:09:15 -0700
Message-Id: <1157479756.23501.18.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 13:10 -0400, Will Simoneau wrote:
> Has anyone seen this before? These three traces occured at different times
> today when three new user accounts (and associated quotas) were created. This
> machine is an NFS server which uses quotas on an ext3 fs (dir_index is on).
> Kernel is 2.6.17.11 on an x86 smp w/64G highmem; 4G ram is installed. The
> affected filesystem is on a software raid1 of two hardware raid0 volumes from a
> megaraid card.
> 
> BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
>  <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread+0x26/0x2a
>  <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
>  <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
>  <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
>  <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
>  <c01c7986> ext3_setattr+0xc3/0x240  <c0120f66> current_fs_time+0x52/0x6a
>  <c017320e> notify_change+0x2bd/0x30d  <c0159246> chown_common+0x9c/0xc5
>  <c02a222c> strncpy_from_user+0x3b/0x68  <c0167fe6> do_path_lookup+0xdf/0x266
>  <c016841b> __user_walk_fd+0x44/0x5a  <c01592b9> sys_chown+0x4a/0x55
>  <c015a43c> vfs_write+0xe7/0x13c  <c01695d4> sys_mkdir+0x1f/0x23
>  <c0102a97> syscall_call+0x7/0xb 

I think its a bogus warning. 

ext3_getblk() is calling ext3_get_blocks_handle() to map "1" block for
read. But for *some* reason ext3_get_blocks_handle() more than 1 block.
ext3_get_blocks_handle() return "positive #of blocks" is a valid case.
So needs to be fixed.

I did search for callers of ext3_get_blocks_handle() and found that
ext3_readdir() seems to do wrong thing all the time with error check :(
Need to take a closer look..

	err = ext3_get_blocks_handle(NULL, inode, blk, 1,
                                                &map_bh, 0, 0);
        if (err > 0) {  <<<< BAD
                  page_cache_readahead(sb->s_bdev->bd_inode->i_mapping,
                                &filp->f_ra,
                                filp,
                                map_bh.b_blocknr >>
                                (PAGE_CACHE_SHIFT - inode->i_blkbits),
                                1);
                        bh = ext3_bread(NULL, inode, blk, 0, &err);
       }



Thanks,
Badari

