Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266981AbUBRBCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267056AbUBRBCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:02:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:3466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266981AbUBRBCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:02:40 -0500
Subject: [PATCH 2.6.3-rc2-mm1] address_space_serialize_writeback patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040213154815.42e74cb5.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	 <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	 <20040213143836.0a5fdabb.akpm@osdl.org>
	 <1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
	 <20040213154815.42e74cb5.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-KYFs0VCOgFm0mVMIqoln"
Organization: 
Message-Id: <1077066147.1956.136.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Feb 2004 17:02:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KYFs0VCOgFm0mVMIqoln
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Here is the patch that does what you suggested.  It adds a rwsema to
the address_space and do_writepages() uses it serialize writebacks.
It allows multiple WB_SYNC_NONE and only 1 WB_SYNC_ALL writebacks.
It also change __block_write_full_page() to not check buffer_dirty()
before calling __set_page_dirty_nobuffers(page) since a locked buffer
might already have dirty_buffer cleared.

This patch also applies to 2.6.3-rc3-mm1.

I've tested this patch on an 8-proc machine running 6 copies of the
direct_read_under tests and have not hit any uninitialized data.
It has been running almost 2 hours -- I usually hit a problem within
30 minutes.   I'll leave the test running overnight.

Daniel

On Fri, 2004-02-13 at 15:48, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > My only concern is that a racing mpage_writepages(WB_SYNC_NONE)
> > with a mpage_write_pages(WB_SYNC_ALL) from a filemap_write_and_wait. 
> > Both could be processing the io_pages list, if the
> > mpage_writepages(WB_SYNC_NONE) moves a page that has locked buffers 
> > back to the dirty_pages list, then when the filemap_write_and_wait()
> > calls filemap_fdatawait, it will not wait for the page moved back
> > to the dirty list.
> 
> Yes.  I suspect we simply cannot get this right without insane locking. 
> We're trying to do something here which the writeback code simply does not
> and cannot generally do, namely write and wait upon IO and dirtyings which
> are initiated by other processes.
> 
> The best way to handle *all* this crap is to remove the address_space page
> lists completely and replace all these things with radix tree walks, but I
> never got onto that.  Sad.
> 
> Maybe we could implement some form of per-address_space serialisation which
> permts multiple WB_SYNC_NONE writers, but exclusive WB_SYNC_ALL writers. 
> That's basically an rwsem, but we don't want to block WB_SYNC_NONE
> processes if there's a sync in progress.
> 
> So WB_SYNC_NONE callers would use down_read_trylock() and WB_SYNC_ALL
> callers would use down_write().   That just fixes all this stuff up.

--=-KYFs0VCOgFm0mVMIqoln
Content-Disposition: attachment; filename=address_space_serialize_writeback.2.6.3-rc2-mm1.patch
Content-Type: text/x-patch; name=address_space_serialize_writeback.2.6.3-rc2-mm1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rup linux-2.6.3-rc2-mm1.orig/fs/buffer.c linux-2.6.3-rc2-mm1/fs/buffer.c
--- linux-2.6.3-rc2-mm1.orig/fs/buffer.c	2004-02-12 11:43:39.000000000 -0800
+++ linux-2.6.3-rc2-mm1/fs/buffer.c	2004-02-17 08:57:18.396196425 -0800
@@ -1816,8 +1816,7 @@ static int __block_write_full_page(struc
 			lock_buffer(bh);
 		} else {
 			if (test_set_buffer_locked(bh)) {
-				if (buffer_dirty(bh))
-					__set_page_dirty_nobuffers(page);
+				__set_page_dirty_nobuffers(page);
 				continue;
 			}
 		}
diff -rup linux-2.6.3-rc2-mm1.orig/fs/inode.c linux-2.6.3-rc2-mm1/fs/inode.c
--- linux-2.6.3-rc2-mm1.orig/fs/inode.c	2004-02-16 17:32:18.000000000 -0800
+++ linux-2.6.3-rc2-mm1/fs/inode.c	2004-02-16 17:39:29.000000000 -0800
@@ -195,6 +195,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
+	init_rwsem(&inode->i_data.wb_rwsema);
 }
 
 EXPORT_SYMBOL(inode_init_once);
diff -rup linux-2.6.3-rc2-mm1.orig/include/linux/fs.h linux-2.6.3-rc2-mm1/include/linux/fs.h
--- linux-2.6.3-rc2-mm1.orig/include/linux/fs.h	2004-02-16 17:01:17.000000000 -0800
+++ linux-2.6.3-rc2-mm1/include/linux/fs.h	2004-02-16 17:08:13.000000000 -0800
@@ -338,6 +338,7 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	struct rw_semaphore	wb_rwsema;	/* serialize SYNC writebacks */
 };
 
 struct block_device {
diff -rup linux-2.6.3-rc2-mm1.orig/mm/page-writeback.c linux-2.6.3-rc2-mm1/mm/page-writeback.c
--- linux-2.6.3-rc2-mm1.orig/mm/page-writeback.c	2004-02-16 17:03:26.000000000 -0800
+++ linux-2.6.3-rc2-mm1/mm/page-writeback.c	2004-02-17 15:02:11.004475189 -0800
@@ -497,9 +497,32 @@ void __init page_writeback_init(void)
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
+	int ret;
+	if (wbc->sync_mode == WB_SYNC_NONE) {
+		if (!down_read_trylock(&mapping->wb_rwsema))
+			/*
+			 * SYNC writeback in progress
+			 */
+			return 0;
+	} else {
+		/*
+		 * Only allow 1 SYNC writeback at a time, to be able
+		 * to wait for all i/o without worrying about racing
+		 * WB_SYNC_NONE writers.
+		 */
+		down_write(&mapping->wb_rwsema);
+	}
+		
 	if (mapping->a_ops->writepages)
-		return mapping->a_ops->writepages(mapping, wbc);
-	return generic_writepages(mapping, wbc);
+		ret = mapping->a_ops->writepages(mapping, wbc);
+	else 
+		ret = generic_writepages(mapping, wbc);
+	if (wbc->sync_mode == WB_SYNC_NONE) {
+		up_read(&mapping->wb_rwsema);
+	} else {
+		up_write(&mapping->wb_rwsema);
+	}
+	return ret;
 }
 
 /**
diff -rup linux-2.6.3-rc2-mm1.orig/mm/swap_state.c linux-2.6.3-rc2-mm1/mm/swap_state.c
--- linux-2.6.3-rc2-mm1.orig/mm/swap_state.c	2004-02-16 17:31:57.000000000 -0800
+++ linux-2.6.3-rc2-mm1/mm/swap_state.c	2004-02-17 09:00:54.881899941 -0800
@@ -38,6 +38,7 @@ struct address_space swapper_space = {
 	.truncate_count  = ATOMIC_INIT(0),
 	.private_lock	= SPIN_LOCK_UNLOCKED,
 	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
+	.wb_rwsema	= __RWSEM_INITIALIZER(swapper_space.wb_rwsema)
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

--=-KYFs0VCOgFm0mVMIqoln--

