Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274754AbRIUEqY>; Fri, 21 Sep 2001 00:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274756AbRIUEqP>; Fri, 21 Sep 2001 00:46:15 -0400
Received: from [195.223.140.107] ([195.223.140.107]:54775 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274754AbRIUEqB>;
	Fri, 21 Sep 2001 00:46:01 -0400
Date: Fri, 21 Sep 2001 06:46:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921064621.C729@athlon.random>
In-Reply-To: <20010921003136.H729@athlon.random> <Pine.GSO.4.21.0109201835320.5631-100000@weyl.math.psu.edu> <20010921010340.L729@athlon.random> <20010921054749.Z729@athlon.random> <20010921060625.A729@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921060625.A729@athlon.random>; from andrea@suse.de on Fri, Sep 21, 2001 at 06:06:25AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 06:06:25AM +0200, Andrea Arcangeli wrote:
> On Fri, Sep 21, 2001 at 05:47:49AM +0200, Andrea Arcangeli wrote:
> > write and I cannot zero it out. It is getting harder to fix this one
> > just inside the ->make_request callback... Hints?
> 
> I think the best fix is to have the ramdisk using the same aops of ramfs
> and replace "Secure" with "Uptodate". We need to trap the security issue
> at the higher layer and also this will avoid us having to map useless
> bh, so it should be an improvement, only the filesystem will end
> triggering the ->make_request callback of the ramdisk. Then if the fs
> does I/O on stuff out of the physical address space we'll just clear it
> out.

ok, here it is, this obsoletes the previous patch (so again against
2.4.10pre12), initrd works again.

Al, feel free to expand over rd.c now.

diff -urN ramdisk-ref/drivers/block/rd.c ramdisk/drivers/block/rd.c
--- ramdisk-ref/drivers/block/rd.c	Fri Sep 21 06:39:28 2001
+++ ramdisk/drivers/block/rd.c	Fri Sep 21 06:26:37 2001
@@ -186,17 +186,77 @@
 
 #endif
 
+/*
+ * Copyright (C) 2000 Linus Torvalds.
+ *               2000 Transmeta Corp.
+ * aops copied from ramfs.
+ */
+static int ramdisk_readpage(struct file *file, struct page * page)
+{
+	if (!Page_Uptodate(page)) {
+		memset(kmap(page), 0, PAGE_CACHE_SIZE);
+		kunmap(page);
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+	}
+	UnlockPage(page);
+	return 0;
+}
+
+/*
+ * Writing: just make sure the page gets marked dirty, so that
+ * the page stealer won't grab it.
+ */
+static int ramdisk_writepage(struct page *page)
+{
+	SetPageDirty(page);
+	UnlockPage(page);
+	return 0;
+}
+
+static int ramdisk_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
+{
+	void *addr = kmap(page);
+	if (!Page_Uptodate(page)) {
+		memset(addr, 0, PAGE_CACHE_SIZE);
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+	}
+	SetPageDirty(page);
+	return 0;
+}
+
+static int ramdisk_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
+{
+	kunmap(page);
+	return 0;
+}
+
+struct address_space_operations ramdisk_aops = {
+	readpage: ramdisk_readpage,
+	writepage: ramdisk_writepage,
+	prepare_write: ramdisk_prepare_write,
+	commit_write: ramdisk_commit_write,
+};
+
 static int rd_blkdev_pagecache_IO(int rw, struct buffer_head * sbh, int minor)
 {
-	struct address_space * mapping = rd_inode[minor]->i_mapping;
+	struct address_space * mapping;
 	unsigned long index;
-	int offset, size, err = 0;
+	int offset, size, err;
 
-	if (sbh->b_page->mapping == mapping) {
-		if (rw != READ)
-			SetPageDirty(sbh->b_page);
+	err = -EIO;
+	/*
+	 * If we did BLKFLSBUF just before doing read/write,
+	 * we could see a rd_inode before the opener had a chance
+	 * to return from rd_open(), that's ok, as soon as we
+	 * see the inode we can use its i_mapping, and the inode
+	 * cannot go away from under us.
+	 */
+	if (!rd_inode[minor])
 		goto out;
-	}
+	err = 0;
+	mapping = rd_inode[minor]->i_mapping;
 
 	index = sbh->b_rsector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sbh->b_rsector << 9) & ~PAGE_CACHE_MASK;
@@ -206,8 +266,7 @@
 		int count;
 		struct page ** hash;
 		struct page * page;
-		const char * src;
-		char * dst;
+		char * src, * dst;
 		int unlock = 0;
 
 		count = PAGE_CACHE_SIZE - offset;
@@ -217,20 +276,24 @@
 
 		hash = page_hash(mapping, index);
 		page = __find_get_page(mapping, index, hash);
-		if (!page && rw != READ) {
+		if (!page) {
 			page = grab_cache_page(mapping, index);
 			err = -ENOMEM;
 			if (!page)
 				goto out;
 			err = 0;
+
+			if (!Page_Uptodate(page)) {
+				memset(kmap(page), 0, PAGE_CACHE_SIZE);
+				kunmap(page);
+				flush_dcache_page(page);
+				SetPageUptodate(page);
+			}
+
 			unlock = 1;
 		}
 
 		index++;
-		if (!page) {
-			offset = 0;
-			continue;
-		}
 
 		if (rw == READ) {
 			src = kmap(page);
@@ -321,6 +384,13 @@
 				struct block_device * bdev = inode->i_bdev;
 
 				down(&bdev->bd_sem);
+				/*
+				 * We're the only users here, protected by the
+				 * bd_sem, but first check if we didn't just
+				 * flushed the ramdisk.
+				 */
+				if (!rd_inode[minor])
+					goto unlock;
 				if (bdev->bd_openers > 2) {
 					up(&bdev->bd_sem);
 					return -EBUSY;
@@ -328,8 +398,16 @@
 				bdev->bd_openers--;
 				bdev->bd_cache_openers--;
 				iput(rd_inode[minor]);
+				/*
+				 * Make sure the cache is flushed from here
+				 * and not from close(2), somebody
+				 * could reopen the device before we have a
+				 * chance to close it ourself.
+				 */
+				truncate_inode_pages(rd_inode[minor]->i_mapping, 0);
 				rd_inode[minor] = NULL;
 				rd_blocksizes[minor] = rd_blocksize;
+			unlock:
 				up(&bdev->bd_sem);
 			}
 			break;
@@ -421,6 +499,8 @@
 			bdev->bd_openers++;
 			bdev->bd_cache_openers++;
 			bdev->bd_inode = inode;
+
+			inode->i_mapping->a_ops = &ramdisk_aops;
 		}
 	}
 

Andrea
