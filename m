Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUCVSKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUCVSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:10:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:35246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261897AbUCVSKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:10:21 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
From: Daniel McNeil <daniel@osdl.org>
To: Chris Mason <mason@suse.com>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1079879799.11062.348.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	 <1079474312.4186.927.camel@watt.suse.com>
	 <20040316152106.22053934.akpm@osdl.org>
	 <20040316152843.667a623d.akpm@osdl.org>
	 <20040316153900.1e845ba2.akpm@osdl.org>
	 <1079485055.4181.1115.camel@watt.suse.com>
	 <1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	 <20040316180043.441e8150.akpm@osdl.org>
	 <1079554288.4183.1938.camel@watt.suse.com>
	 <20040317123324.46411197.akpm@osdl.org>
	 <1079563568.4185.1947.camel@watt.suse.com>
	 <20040317150909.7fd121bd.akpm@osdl.org>
	 <1079566076.4186.1959.camel@watt.suse.com>
	 <20040317155111.49d09a87.akpm@osdl.org>
	 <1079568387.4186.1964.camel@watt.suse.com>
	 <20040317161338.28b21c35.akpm@osdl.org>
	 <1079569870.4186.1967.camel@watt.suse.com>
	 <20040317163332.0385d665.akpm@osdl.org>
	 <1079572511.6930.5.camel@ibm-c.pdx.osdl.net>
	 <1079632431.6930.30.camel@ibm-c.pdx.osdl.net>
	 <1079635678.4185.2100.camel@watt.suse.com>
	 <1079637004.6930.42.camel@ibm-c.pdx.osdl.net>
	 <1079714990.6930.49.camel@ibm-c.pdx.osdl.net>
	 <1079715901.6930.52.camel@ibm-c.pdx.osdl.net>
	 <1079879799.11062.348.camel@watt.suse.com>
Content-Type: multipart/mixed; boundary="=-byUSt4bAAPKVPJZ3BATe"
Organization: 
Message-Id: <1079979016.6930.62.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2004 10:10:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-byUSt4bAAPKVPJZ3BATe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew and Chris,

I re-ran the direct_read_under tests over the weekend on ext3 with
the attached wb_rwsema patch and ran without errors.

It looks like the same thing as before -- async writebacks are causing
the sync writebacks to miss pages.

Thoughts?

Daniel

On Sun, 2004-03-21 at 06:36, Chris Mason wrote:
> On Fri, 2004-03-19 at 12:05, Daniel McNeil wrote:
> > Can't type this morning -- 2.6.5-rc1-mm2 is what I ran on.
> >                            =============
> > 
> > Daniel
> > On Fri, 2004-03-19 at 08:49, Daniel McNeil wrote:
> > > I re-ran direct_read_under test (6 copies) on 2.6.4-rc1-mm2:
> > > 
> > > ext3 failed within 2 hours.
> > > 
> > > ext2 ran overnight without errors.
> > > 
> [ ... a slightly different kernel, but numbers are probably good ]
> 
> > > > 
> > > > Still have the data:
> > > > 		 63 pages (258048 bytes)
> > > > 		 90 pages (368640 bytes)
> > > > 		139 pages (569344 bytes)
> > > > 		 30 pages (122880 bytes)
> > > > 		 87 pages (356352 bytes)
> > > > 		
> > > 
> 
> That seems like a lot of pages for a small race, it feels like we have a
> bigger problem.  If nobody else has ideas, and you've got an available
> disk for mkreiserfs, could I talk you into trying with reiserfs
> data=ordered?
> 
> ftp.suse.com/pub/people/mason/patches/data-logging/experimental/2.6.4
> 
> (use series.mm for a list of files to apply to 2.6.5-rc-mm)
> 
> data=ordered is the default with those patches, so just mkreiserfs and
> mount.  reiserfs is using a different writepage and different code to
> submit the ordered buffers, so you'll be using completely different code
> paths.
> 
> I'll try to get some time on an 8way here for some tests as well.
> 
> -chris
> 

--=-byUSt4bAAPKVPJZ3BATe
Content-Disposition: attachment; filename=265-rc1-mm2.wb_rwsema.patch
Content-Type: text/x-patch; name=265-rc1-mm2.wb_rwsema.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rup linux-2.6.5-rc1-mm2.orig/fs/buffer.c linux-2.6.5-rc1-mm2/fs/buffer.c
--- linux-2.6.5-rc1-mm2.orig/fs/buffer.c	2004-03-22 09:51:08.780141187 -0800
+++ linux-2.6.5-rc1-mm2/fs/buffer.c	2004-03-19 16:24:57.000000000 -0800
@@ -1814,8 +1814,7 @@ static int __block_write_full_page(struc
 			lock_buffer(bh);
 		} else {
 			if (test_set_buffer_locked(bh)) {
-				if (buffer_dirty(bh))
-					__set_page_dirty_nobuffers(page);
+				__set_page_dirty_nobuffers(page);
 				continue;
 			}
 		}
diff -rup linux-2.6.5-rc1-mm2.orig/fs/fs-writeback.c linux-2.6.5-rc1-mm2/fs/fs-writeback.c
--- linux-2.6.5-rc1-mm2.orig/fs/fs-writeback.c	2004-03-22 09:51:36.444272668 -0800
+++ linux-2.6.5-rc1-mm2/fs/fs-writeback.c	2004-03-19 16:49:57.000000000 -0800
@@ -132,6 +132,7 @@ __sync_single_inode(struct inode *inode,
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	int wait = wbc->sync_mode == WB_SYNC_ALL;
+	int blkdev = inode->i_sb == blockdev_superblock;
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -148,8 +149,26 @@ __sync_single_inode(struct inode *inode,
 
 	spin_unlock(&inode_lock);
 
+	if (!blkdev) {
+		if (wait) {
+			down_write(&mapping->wb_rwsema);
+		} else {
+			if (!down_read_trylock(&mapping->wb_rwsema)) {
+				wbc->encountered_congestion = 1;
+				goto skip_writeback;
+			}
+		}
+	}
+
 	do_writepages(mapping, wbc);
 
+	if (!blkdev) {
+		if (wait)
+			up_write(&mapping->wb_rwsema);
+		else
+			up_read(&mapping->wb_rwsema);
+	}
+skip_writeback:
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 		write_inode(inode, wait);
@@ -263,7 +282,12 @@ sync_sb_inodes(struct super_block *sb, s
 			break;
 		}
 
-		if (wbc->nonblocking && bdi_write_congested(bdi)) {
+		/*
+		 * wbc->encountered_congestion is set if we cannot get
+		 * the wb_rwsema.
+		 */
+		if (wbc->nonblocking &&
+		    (bdi_write_congested(bdi) || wbc->encountered_congestion)) {
 			wbc->encountered_congestion = 1;
 			if (sb != blockdev_superblock)
 				break;		/* Skip a congested fs */
diff -rup linux-2.6.5-rc1-mm2.orig/fs/inode.c linux-2.6.5-rc1-mm2/fs/inode.c
--- linux-2.6.5-rc1-mm2.orig/fs/inode.c	2004-03-22 09:51:21.299937974 -0800
+++ linux-2.6.5-rc1-mm2/fs/inode.c	2004-03-19 16:25:42.000000000 -0800
@@ -190,6 +190,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
+	init_rwsem(&inode->i_data.wb_rwsema);
 }
 
 EXPORT_SYMBOL(inode_init_once);
diff -rup linux-2.6.5-rc1-mm2.orig/include/linux/fs.h linux-2.6.5-rc1-mm2/include/linux/fs.h
--- linux-2.6.5-rc1-mm2.orig/include/linux/fs.h	2004-03-22 09:52:00.125104495 -0800
+++ linux-2.6.5-rc1-mm2/include/linux/fs.h	2004-03-19 16:26:30.000000000 -0800
@@ -338,6 +338,7 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	struct rw_semaphore	wb_rwsema;	/* serialize SYNC writebacks */
 };
 
 struct block_device {
diff -rup linux-2.6.5-rc1-mm2.orig/mm/filemap.c linux-2.6.5-rc1-mm2/mm/filemap.c
--- linux-2.6.5-rc1-mm2.orig/mm/filemap.c	2004-03-22 09:50:34.895103358 -0800
+++ linux-2.6.5-rc1-mm2/mm/filemap.c	2004-03-19 16:46:28.000000000 -0800
@@ -140,16 +140,32 @@ static inline int sync_page(struct page 
  */
 static int __filemap_fdatawrite(struct address_space *mapping, int sync_mode)
 {
+	extern struct super_block *blockdev_superblock;
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
 	};
+	int blkdev = mapping->host->i_sb == blockdev_superblock;
 
 	if (mapping->backing_dev_info->memory_backed)
 		return 0;
 
+	if (!blkdev) {
+		if (sync_mode == WB_SYNC_NONE) {
+			if (!down_read_trylock(&mapping->wb_rwsema))
+				return 0;
+		} else {
+			down_write(&mapping->wb_rwsema);
+		}
+	}
 	ret = do_writepages(mapping, &wbc);
+	if (!blkdev) {
+		if (sync_mode == WB_SYNC_NONE)
+			up_read(&mapping->wb_rwsema);
+		else
+			up_write(&mapping->wb_rwsema);
+	}
 	return ret;
 }
 
diff -rup linux-2.6.5-rc1-mm2.orig/mm/swap_state.c linux-2.6.5-rc1-mm2/mm/swap_state.c
--- linux-2.6.5-rc1-mm2.orig/mm/swap_state.c	2004-03-22 09:50:49.363557747 -0800
+++ linux-2.6.5-rc1-mm2/mm/swap_state.c	2004-03-19 16:28:06.000000000 -0800
@@ -35,6 +35,7 @@ struct address_space swapper_space = {
 	.truncate_count  = ATOMIC_INIT(0),
 	.private_lock	= SPIN_LOCK_UNLOCKED,
 	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
+	.wb_rwsema	= __RWSEM_INITIALIZER(swapper_space.wb_rwsema)
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

--=-byUSt4bAAPKVPJZ3BATe--

