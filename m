Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287598AbSAEH7S>; Sat, 5 Jan 2002 02:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSAEH7J>; Sat, 5 Jan 2002 02:59:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30738 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287604AbSAEH7A>; Sat, 5 Jan 2002 02:59:00 -0500
Message-ID: <3C36B117.A56A33C4@zip.com.au>
Date: Fri, 04 Jan 2002 23:53:59 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern 
 el panic woes
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>,
		<20011221004251.K1477@athlon.random>; from andrea@suse.de on Fri, Dec 21, 2001 at 12:42:51AM +0100 <20011221024910.L1477@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> I diffed a more advanced version of it. It's not very well tested.
> 
> [ your rd.c patch ]
>

Your patch is working OK for me.  I made two changes:

- s/PAGE_SIZE/PAGE_CACHE_SIZE/ in ramdisk_updatepage()

- I think there's an SMP race in rd_blkdev_pagecache_IO() - it looks up
  the underlying page in the pagecache and if it is present, it simply
  proceeds, assuming that the page is uptodate.   But another CPU could have
  just added the page and may be in the middle of initialising it.
  So I changed rd_blkdev_pagecache_IO() to always lock the page.  It
  got simpler.

BTW, here's some fun: set up /dev/ram0 and /dev/ram1, both 128 megabytes.  Fill
each of them with a big file and then try to umount /dev/ram1.  The machine
locks up for sixty seconds running the quadratic search in write_some_buffers().
Sigh. In the lowlatency patch I simply brute-forced this by always setting
dev = NODEV in sync_buffers().

Please review - I'm trying to use the rd driver to test the truncate+ENOSPC
patch and there's just rampant filesystem corruption all over the place
without this patch.  It's unusable.


--- linux-2.4.18-pre1/drivers/block/rd.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/block/rd.c	Fri Jan  4 23:50:09 2002
@@ -191,26 +191,44 @@ __setup("ramdisk_blocksize=", ramdisk_bl
  *               2000 Transmeta Corp.
  * aops copied from ramfs.
  */
-static int ramdisk_readpage(struct file *file, struct page * page)
+static void ramdisk_updatepage(struct page * page, int need_kmap)
 {
 	if (!Page_Uptodate(page)) {
-		memset(kmap(page), 0, PAGE_CACHE_SIZE);
-		kunmap(page);
+		struct buffer_head *bh = page->buffers;
+		void * address;
+
+		if (need_kmap)
+			kmap(page);
+		address = page_address(page);
+		if (bh) {
+			struct buffer_head *tmp = bh;
+			do {
+				if (!buffer_uptodate(tmp)) {
+					memset(address, 0, tmp->b_size);
+					mark_buffer_uptodate(tmp, 1);
+				}
+				address += tmp->b_size;
+				tmp = tmp->b_this_page;
+			} while (tmp != bh);
+		} else
+			memset(address, 0, PAGE_CACHE_SIZE);
+		if (need_kmap)
+			kunmap(page);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
+}
+
+static int ramdisk_readpage(struct file *file, struct page * page)
+{
+	ramdisk_updatepage(page, 1);
 	UnlockPage(page);
 	return 0;
 }
 
 static int ramdisk_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
-	if (!Page_Uptodate(page)) {
-		void *addr = page_address(page);
-		memset(addr, 0, PAGE_CACHE_SIZE);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-	}
+	ramdisk_updatepage(page, 0);
 	SetPageDirty(page);
 	return 0;
 }
@@ -233,44 +251,40 @@ static int rd_blkdev_pagecache_IO(int rw
 	unsigned long index;
 	int offset, size, err;
 
-	err = -EIO;
 	err = 0;
 	mapping = rd_bdev[minor]->bd_inode->i_mapping;
 
+	/* writing a buffer cache not uptodate must not clear it */
+	if (sbh->b_page->mapping == mapping) {
+		if (rw == WRITE) {
+			mark_buffer_uptodate(sbh, 1);
+			SetPageDirty(sbh->b_page);
+		}
+		goto out;
+	}
+
 	index = sbh->b_rsector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sbh->b_rsector << 9) & ~PAGE_CACHE_MASK;
 	size = sbh->b_size;
 
 	do {
 		int count;
-		struct page ** hash;
 		struct page * page;
 		char * src, * dst;
-		int unlock = 0;
 
 		count = PAGE_CACHE_SIZE - offset;
 		if (count > size)
 			count = size;
 		size -= count;
 
-		hash = page_hash(mapping, index);
-		page = __find_get_page(mapping, index, hash);
+		page = grab_cache_page(mapping, index);
 		if (!page) {
-			page = grab_cache_page(mapping, index);
 			err = -ENOMEM;
-			if (!page)
-				goto out;
-			err = 0;
-
-			if (!Page_Uptodate(page)) {
-				memset(kmap(page), 0, PAGE_CACHE_SIZE);
-				kunmap(page);
-				SetPageUptodate(page);
-			}
-
-			unlock = 1;
+			goto out;
 		}
 
+		ramdisk_updatepage(page, 1);
+
 		index++;
 
 		if (rw == READ) {
@@ -294,8 +308,7 @@ static int rd_blkdev_pagecache_IO(int rw
 		} else {
 			SetPageDirty(page);
 		}
-		if (unlock)
-			UnlockPage(page);
+		UnlockPage(page);
 		__free_page(page);
 	} while (size);
