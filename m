Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274202AbRITCd5>; Wed, 19 Sep 2001 22:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274186AbRITCdt>; Wed, 19 Sep 2001 22:33:49 -0400
Received: from [195.223.140.107] ([195.223.140.107]:22518 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274202AbRITCdj>;
	Wed, 19 Sep 2001 22:33:39 -0400
Date: Thu, 20 Sep 2001 04:34:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010920043404.K720@athlon.random>
In-Reply-To: <20010919202539.E720@athlon.random> <Pine.GSO.4.21.0109191515200.901-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109191515200.901-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Sep 19, 2001 at 03:21:09PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 03:21:09PM -0400, Alexander Viro wrote:
> int fd = open("/dev/ram0", O_RDWR);
> ioctl(fd, BLKFLSBUF);
> ioctl(fd, BLKFLSBUF);

here it is the fix below.

actually it also notably fixes a subtle security problem with the
ramdisk. The fact is that we are asked to read/write from the same
pagecache page that also was the destination of the I/O (ramdisk is
zerocopy), so we actually need a new bitflag to know if this a page
secure, this way we know if we need to bother hiding its contents or
not, if it's a secure page we don't need to do anything. It is a zero
cost bitflag for the nonramdisk case so it shouldn't be a problem and I
cannot imagine a better fix.

Now the only bit left in the ramdisk is a race condition in rmmod, I can
now see why you were converting rd_inode to rd_bdev :).

--- 2.4.10pre11aa1/include/linux/mm.h.~1~	Thu Sep 20 01:20:38 2001
+++ 2.4.10pre11aa1/include/linux/mm.h	Thu Sep 20 03:57:25 2001
@@ -282,6 +282,7 @@
 #define PG_checked		12	/* kill me in 2.5.<early>. */
 #define PG_arch_1		13
 #define PG_reserved		14
+#define PG_secure		15
 
 /* Make it prettier to test the above... */
 #define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
@@ -295,6 +296,9 @@
 #define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+
+#define PageSecure(page)	test_bit(PG_secure, &(page)->flags)
+#define SetPageSecure(page)	set_bit(PG_secure, &(page)->flags)
 
 extern void __set_page_dirty(struct page *);
 
--- 2.4.10pre11aa1/mm/filemap.c.~1~	Tue Sep 18 15:39:51 2001
+++ 2.4.10pre11aa1/mm/filemap.c	Thu Sep 20 03:59:00 2001
@@ -621,7 +621,7 @@
 	if (PageLocked(page))
 		BUG();
 
-	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
+	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked | 1 << PG_secure);
 	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
 	page->index = offset;
--- 2.4.10pre11aa1/mm/shmem.c.~1~	Tue Sep 18 02:43:04 2001
+++ 2.4.10pre11aa1/mm/shmem.c	Thu Sep 20 03:59:09 2001
@@ -353,7 +353,7 @@
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
 		delete_from_swap_cache_nolock(page);
-		flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_referenced | 1 << PG_arch_1);
+		flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_secure);
 		page->flags = flags | (1 << PG_dirty);
 		add_to_page_cache_locked(page, mapping, idx);
 		info->swapped--;
--- 2.4.10pre11aa1/mm/swap_state.c.~1~	Tue Sep 18 02:43:04 2001
+++ 2.4.10pre11aa1/mm/swap_state.c	Thu Sep 20 03:59:20 2001
@@ -70,7 +70,7 @@
 		BUG();
 
 	/* clear PG_dirty so a subsequent set_page_dirty takes effect */
-	flags = page->flags & ~(1 << PG_error | 1 << PG_dirty | 1 << PG_arch_1 | 1 << PG_referenced);
+	flags = page->flags & ~(1 << PG_error | 1 << PG_dirty | 1 << PG_arch_1 | 1 << PG_referenced | 1 << PG_secure);
 	page->flags = flags | (1 << PG_uptodate);
 	add_to_page_cache_locked(page, &swapper_space, entry.val);
 }
--- 2.4.10pre11/drivers/block/rd.c	Tue Sep 18 02:42:23 2001
+++ 2.4.10pre11aa1/drivers/block/rd.c	Thu Sep 20 04:22:44 2001
@@ -188,11 +188,23 @@
 
 static int rd_blkdev_pagecache_IO(int rw, struct buffer_head * sbh, int minor)
 {
-	struct address_space * mapping = rd_inode[minor]->i_mapping;
+	struct address_space * mapping;
 	unsigned long index;
-	int offset, size, err = 0;
+	int offset, size, err;
 
-	if (sbh->b_page->mapping == mapping) {
+	err = -EIO;
+	/*
+	 * If we did BLKFLSBUF just before doing read/write,
+	 * we could see a rd_inode before the opener had a chance
+	 * to return from rd_open(), that's ok, as soon as we
+	 * see the inode we can use its i_mapping, and the inode
+	 * cannot go away from under us.
+	 */
+	if (!rd_inode[minor])
+		goto out;
+	err = 0;
+	mapping = rd_inode[minor]->i_mapping;
+	if (sbh->b_page->mapping == mapping && PageSecure(sbh->b_page)) {
 		if (rw != READ)
 			SetPageDirty(sbh->b_page);
 		goto out;
@@ -217,7 +229,7 @@
 
 		hash = page_hash(mapping, index);
 		page = __find_get_page(mapping, index, hash);
-		if (!page && rw != READ) {
+		if (!page) {
 			page = grab_cache_page(mapping, index);
 			err = -ENOMEM;
 			if (!page)
@@ -227,18 +239,40 @@
 		}
 
 		index++;
-		if (!page) {
-			offset = 0;
-			continue;
-		}
 
 		if (rw == READ) {
 			src = kmap(page);
+
+			if (!PageSecure(page)) {
+				clear_page(src);
+				SetPageSecure(page);
+			}
+
 			src += offset;
 			dst = bh_kmap(sbh);
 		} else {
 			dst = kmap(page);
 			dst += offset;
+
+			if (!PageSecure(page)) {
+				unsigned long addr, start, end;
+
+				/* clear around */
+				addr = (unsigned long) dst;
+				if (addr & ~PAGE_CACHE_MASK) {
+					start = addr & PAGE_CACHE_MASK;
+					end = addr;
+					memset((char *) start, 0, end - start);
+				}
+				addr = (unsigned long) dst + count;
+				if (addr & ~PAGE_CACHE_MASK) {
+					start = addr;
+					end = (addr + PAGE_CACHE_SIZE - 1) & PAGE_CACHE_MASK;
+					memset((char *) start, 0, end - start);
+				}
+				SetPageSecure(page);
+			}
+
 			src = bh_kmap(sbh);
 		}
 		offset = 0;
@@ -321,6 +355,13 @@
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
@@ -328,8 +369,16 @@
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



Andrea
