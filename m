Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbRLUBti>; Thu, 20 Dec 2001 20:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286522AbRLUBt3>; Thu, 20 Dec 2001 20:49:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26736 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286521AbRLUBtV>; Thu, 20 Dec 2001 20:49:21 -0500
Date: Fri, 21 Dec 2001 02:49:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Message-ID: <20011221024910.L1477@athlon.random>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011221004251.K1477@athlon.random>; from andrea@suse.de on Fri, Dec 21, 2001 at 12:42:51AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I diffed a more advanced version of it. It's not very well tested.

--- 2.4.17rc2aa1/drivers/block/rd.c.~1~	Wed Dec 19 03:01:04 2001
+++ 2.4.17rc2aa1/drivers/block/rd.c	Fri Dec 21 01:39:15 2001
@@ -191,26 +191,44 @@
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
+			memset(address, 0, PAGE_SIZE);
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
@@ -233,10 +251,18 @@
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
@@ -262,11 +288,7 @@
 				goto out;
 			err = 0;
 
-			if (!Page_Uptodate(page)) {
-				memset(kmap(page), 0, PAGE_CACHE_SIZE);
-				kunmap(page);
-				SetPageUptodate(page);
-			}
+			ramdisk_updatepage(page, 1);
 
 			unlock = 1;
 		}

actually while testing it I unfortunately found also an fs corruption
bug in the ->prepare_write/commit_write/writepage/direct_IO callbacks.
It's a longstanding one, since get_block born.  In short, if get_block
fails while mapping on a certain page during
prepare_write/writepage/direct_IO (like it can happen with a full
filesystem, incidentally ext2 on /dev/ram0 during my testing that is
only 4M and so it overflows fast), the blocks before the ENOSPC failure
will be allocated, but the i_size won't be update accordingly (no commit
write, because prepare_write failed in the middle). for the
generic_file_write users it's easily fixable with an hack (truncating
backwards because we don't know how far we got allocating blocks when we
return from prepare_write), similar hack for the direct_IO one (that
commits only once at the end in function of the direct_IO generated).
But for writepage is quite a pain, infact I believe the writepage blocks
should be reserved in-core, to guarantee we will never fail a truncate
with ENOSPC.  With the shared mappings we're effectively doing allocate
on flush...  but with the lack of space reservation that makes it
unreliable :)

So for now I did an hack to cure the other two (writepage can still
corrupt the fs as said). I think the right fix (ala 2.5) is to change
the API so we can use the last blocks too, but the below will cure 2.4
and for writepage the right fix IMHO is to do the reservation of the
space.

both holds the i_sem so calling truncate from there cannot race with
any other inode-writer.

--- 2.4.17rc2aa2/mm/filemap.c.~1~	Wed Dec 19 03:43:23 2001
+++ 2.4.17rc2aa2/mm/filemap.c	Fri Dec 21 02:21:07 2001
@@ -3026,8 +3025,14 @@
 
 		kaddr = kmap(page);
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
-		if (status)
+		if (status) {
+			if (status == -ENOSPC && inode->i_op && inode->i_op->truncate) {
+				lock_kernel();
+				inode->i_op->truncate(inode);
+				unlock_kernel();
+			}
 			goto unlock;
+		}
 		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
@@ -3090,6 +3095,14 @@
 		if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
 			inode->i_size = end;
 			mark_inode_dirty(inode);
+		}
+		/* there's the possibility that some get_block left some leftover */
+		if (written != count) {
+			if (inode->i_op && inode->i_op->truncate) {
+				lock_kernel();
+				inode->i_op->truncate(inode);
+				unlock_kernel();
+			}
 		}
 		*ppos = end;
 		invalidate_inode_pages2(mapping);


ah, and of course, other workaround is to use fs-blocksize == PAGE_SIZE 8)

btw, I'll be away the next few days, so I will not be very responsive
until after Christmas.

Andrea
