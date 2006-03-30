Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWC3TW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWC3TW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWC3TW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:22:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:7367 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750775AbWC3TW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:22:57 -0500
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060330174008.GW5030@schatzie.adilger.int>
	 <1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 30 Mar 2006 11:22:41 -0800
Message-Id: <1143746561.3896.35.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 11:16 -0800, Mingming Cao wrote:
> On Thu, 2006-03-30 at 10:40 -0700, Andreas Dilger wrote:
> > On Mar 29, 2006  17:38 -0800, Mingming Cao wrote:
> > > Have verified these two patches on a 64 bit machine with 10TB ext3
> > > filesystem, fsx runs fine for a few hours. Also testes on 32 bit machine
> > > with <8TB ext3.
> > 
> > Have you done tests _near_ 8TB with a 32-bit machine, even without these
> > patches?
> No I haven't. The >8TB right now is attached to a 64 bit machine, but we
> should able to move it to a 32 bit machine.
> 
> >   In particular, filling up the filesystem to be close to full
> > so that we really depend on the > 2TB code to work properly?
> 
> I made a kernel patch to allow a file to specify which block group it
> wants it's blocks to allocate from(using ioctl to set the goal
> allocation block group). I set the goal block group falls to somewhere
> >8TB, and did dd tests on that file. Verified this with debugfs, the
> allocated block numbers are beyond 2**31.
> 
> Also before run fsx tests, created many directories (32768 at most:) and
> verified one directory's inode is located in block group >8TB space. So
> when we do fsx test on files under that directory, we are
> creating/testing files >8TB.
> 
> BTW, do you think this ioctl is useful in general for other users? I
> attached the patch here.
> 
---

 linux-2.6.16-ming/fs/ext3/balloc.c          |   24 ++++++++++++++---------
 linux-2.6.16-ming/fs/ext3/ioctl.c           |   29 ++++++++++++++++++++++++++++
 linux-2.6.16-ming/include/linux/ext3_fs.h   |    1 
 linux-2.6.16-ming/include/linux/ext3_fs_i.h |    1 
 4 files changed, 46 insertions(+), 9 deletions(-)

diff -puN fs/ext3/ioctl.c~ext3_set_alloc_blk_group_hack fs/ext3/ioctl.c
--- linux-2.6.16/fs/ext3/ioctl.c~ext3_set_alloc_blk_group_hack	2006-03-28 15:19:58.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/ioctl.c	2006-03-28 15:54:14.000000000 -0800
@@ -22,6 +22,7 @@ int ext3_ioctl (struct inode * inode, st
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	unsigned int flags;
 	unsigned short rsv_window_size;
+	unsigned int blk_group;
 
 	ext3_debug ("cmd = %u, arg = %lu\n", cmd, arg);
 
@@ -193,6 +194,34 @@ flags_err:
 		mutex_unlock(&ei->truncate_mutex);
 		return 0;
 	}
+	case EXT3_IOC_SETALLOCBLKGRP: {
+
+		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
+			return -ENOTTY;
+
+		if (IS_RDONLY(inode))
+			return -EROFS;
+
+		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+			return -EACCES;
+
+		if (get_user(blk_group, (int __user *)arg))
+			return -EFAULT;
+
+		/*
+		 * need to allocate reservation structure for this inode
+		 * before set the window size
+		 */
+		mutex_lock(&ei->truncate_mutex);
+		if (!ei->i_block_alloc_info)
+			ext3_init_block_alloc_info(inode);
+
+		if (ei->i_block_alloc_info){
+			ei->i_block_alloc_info->goal_block_group = blk_group;
+		}
+		mutex_unlock(&ei->truncate_mutex);
+		return 0;
+	}
 	case EXT3_IOC_GROUP_EXTEND: {
 		unsigned long n_blocks_count;
 		struct super_block *sb = inode->i_sb;
diff -puN include/linux/ext3_fs.h~ext3_set_alloc_blk_group_hack include/linux/ext3_fs.h
--- linux-2.6.16/include/linux/ext3_fs.h~ext3_set_alloc_blk_group_hack	2006-03-28 15:42:51.000000000 -0800
+++ linux-2.6.16-ming/include/linux/ext3_fs.h	2006-03-28 15:51:48.000000000 -0800
@@ -238,6 +238,7 @@ struct ext3_new_group_data {
 #endif
 #define EXT3_IOC_GETRSVSZ		_IOR('f', 5, long)
 #define EXT3_IOC_SETRSVSZ		_IOW('f', 6, long)
+#define EXT3_IOC_SETALLOCBLKGRP		_IOW('f', 9, long)
 
 /*
  *  Mount options
diff -puN include/linux/ext3_fs_i.h~ext3_set_alloc_blk_group_hack include/linux/ext3_fs_i.h
--- linux-2.6.16/include/linux/ext3_fs_i.h~ext3_set_alloc_blk_group_hack	2006-03-28 15:43:59.000000000 -0800
+++ linux-2.6.16-ming/include/linux/ext3_fs_i.h	2006-03-28 15:47:54.000000000 -0800
@@ -51,6 +51,7 @@ struct ext3_block_alloc_info {
 	 * allocation when we detect linearly ascending requests.
 	 */
 	__u32                   last_alloc_physical_block;
+	__u32			goal_block_group;
 };
 
 #define rsv_start rsv_window._rsv_start
diff -puN fs/ext3/balloc.c~ext3_set_alloc_blk_group_hack fs/ext3/balloc.c
--- linux-2.6.16/fs/ext3/balloc.c~ext3_set_alloc_blk_group_hack	2006-03-28 15:45:30.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/balloc.c	2006-03-28 16:03:55.000000000 -0800
@@ -285,6 +285,7 @@ void ext3_init_block_alloc_info(struct i
 		rsv->rsv_alloc_hit = 0;
 		block_i->last_alloc_logical_block = 0;
 		block_i->last_alloc_physical_block = 0;
+		block_i->goal_block_group = 0;
 	}
 	ei->i_block_alloc_info = block_i;
 }
@@ -1263,15 +1264,20 @@ unsigned long ext3_new_blocks(handle_t *
 		*errp = -ENOSPC;
 		goto out;
 	}
-
-	/*
-	 * First, test whether the goal block is free.
-	 */
-	if (goal < le32_to_cpu(es->s_first_data_block) ||
-	    goal >= le32_to_cpu(es->s_blocks_count))
-		goal = le32_to_cpu(es->s_first_data_block);
-	group_no = (goal - le32_to_cpu(es->s_first_data_block)) /
-			EXT3_BLOCKS_PER_GROUP(sb);
+	if (block_i->goal_block_group) {
+		group_no = block_i->goal_block_group;
+		goal = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +                                group_no * EXT3_BLOCKS_PER_GROUP(sb);
+		block_i->goal_block_group = 0;
+	} else {
+		/*
+		 * First, test whether the goal block is free.
+		 */
+		if (goal < le32_to_cpu(es->s_first_data_block) ||
+		    goal >= le32_to_cpu(es->s_blocks_count))
+			goal = le32_to_cpu(es->s_first_data_block);
+		group_no = (goal - le32_to_cpu(es->s_first_data_block)) /
+				EXT3_BLOCKS_PER_GROUP(sb);
+	}
 	gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
 	if (!gdp)
 		goto io_error;

_


