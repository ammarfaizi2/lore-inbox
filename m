Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSHJLCA>; Sat, 10 Aug 2002 07:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSHJLCA>; Sat, 10 Aug 2002 07:02:00 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60173 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316853AbSHJLBt>; Sat, 10 Aug 2002 07:01:49 -0400
Message-ID: <3D54F344.9040303@namesys.com>
Date: Sat, 10 Aug 2002 15:04:36 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, mason <mason@namesys.com>,
       green@thebsh.namesys.com, "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: [patch 7/12] use atomic kmaps in generic_file_write
References: <3D5464E8.28CA1AF4@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Green and Vladimir Saveliev will work with you on nicely 
integrating this into ReiserFS, and into the patches we have in flight 
at the moment (we have a whole bunch in queue to go out over the next 
three weeks that improve reiserfs v3 performance substantially). 
 Vladimir has some questions which he will email you privately. 
 Vladimir will also adapt V4 to this once Linus puts your patch in.

Hans



Andrew Morton wrote:

>This patch uses the kmap_copy_user() API across generic_file_write()'s
>copy_*_user().
>
>This required a change in the prepare_write/commit_write API
>definition.  It is no longer the case that these functions will kmap
>the page for you.
>
>If any part of the kernel wants to get at the page in the write path,
>it now has to kmap it for itself.  The best way to do this is with
>kmap_atomic(KM_USER0).
>
>This patch updates all callers.  It also converts several places which
>were unnecessarily using kmap() over to using kmap_atomic().
>
>I made a bit of a mess of reiserfs.  It works OK, but I suspect it's
>performing unnecessary kmaps.
>
>The patch has been tested with loop, ext2, ext3, reiserfs, jfs,
>minixfs, vfat, iso9660, nfs and the ramdisk driver.
>
>
>
> drivers/block/loop.c  |    5 ++--
> drivers/block/rd.c    |   19 +++++++++++-----
> fs/affs/file.c        |   11 ++++++++-
> fs/buffer.c           |   57 ++++++++++++++++++++++++++++----------------------
> fs/driverfs/inode.c   |    6 ++---
> fs/ext2/dir.c         |   11 ++++-----
> fs/ext3/inode.c       |   30 +++++---------------------
> fs/fat/inode.c        |   17 +++++++++++++-
> fs/jffs/inode-v23.c   |   11 ++++++---
> fs/jffs2/file.c       |    4 ++-
> fs/jfs/jfs_metapage.c |    1 
> fs/minix/dir.c        |   12 ++++++----
> fs/namei.c            |    3 +-
> fs/ramfs/inode.c      |   14 +++++++-----
> fs/reiserfs/inode.c   |   27 ++++++++++++++++-------
> fs/sysv/dir.c         |    3 ++
> mm/filemap.c          |    6 ++---
> 17 files changed, 140 insertions, 97 deletions
>
>--- 2.5.30/mm/filemap.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/mm/filemap.c	Fri Aug  9 17:36:45 2002
>@@ -1969,6 +1969,7 @@ generic_file_write(struct file *file, co
> 		unsigned long offset;
> 		long page_fault;
> 		char *kaddr;
>+		struct copy_user_state copy_user_state;
> 
> 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
> 		index = pos >> PAGE_CACHE_SHIFT;
>@@ -1993,22 +1994,22 @@ generic_file_write(struct file *file, co
> 			break;
> 		}
> 
>-		kaddr = kmap(page);
> 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
> 		if (unlikely(status)) {
> 			/*
> 			 * prepare_write() may have instantiated a few blocks
> 			 * outside i_size.  Trim these off again.
> 			 */
>-			kunmap(page);
> 			unlock_page(page);
> 			page_cache_release(page);
> 			if (pos + bytes > inode->i_size)
> 				vmtruncate(inode, inode->i_size);
> 			break;
> 		}
>+		kaddr = kmap_copy_user(&copy_user_state, page, KM_FILEMAP, 0);
> 		page_fault = __copy_from_user(kaddr + offset, buf, bytes);
> 		flush_dcache_page(page);
>+		kunmap_copy_user(&copy_user_state);
> 		status = a_ops->commit_write(file, page, offset, offset+bytes);
> 		if (unlikely(page_fault)) {
> 			status = -EFAULT;
>@@ -2023,7 +2024,6 @@ generic_file_write(struct file *file, co
> 				buf += status;
> 			}
> 		}
>-		kunmap(page);
> 		if (!PageReferenced(page))
> 			SetPageReferenced(page);
> 		unlock_page(page);
>--- 2.5.30/fs/buffer.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/buffer.c	Fri Aug  9 17:37:01 2002
>@@ -1798,7 +1798,6 @@ static int __block_prepare_write(struct 
> 	int err = 0;
> 	unsigned blocksize, bbits;
> 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
>-	char *kaddr = kmap(page);
> 
> 	BUG_ON(!PageLocked(page));
> 	BUG_ON(from > PAGE_CACHE_SIZE);
>@@ -1839,13 +1838,19 @@ static int __block_prepare_write(struct 
> 					set_buffer_uptodate(bh);
> 					continue;
> 				}
>-				if (block_end > to)
>-					memset(kaddr+to, 0, block_end-to);
>-				if (block_start < from)
>-					memset(kaddr+block_start,
>-						0, from-block_start);
>-				if (block_end > to || block_start < from)
>+				if (block_end > to || block_start < from) {
>+					void *kaddr;
>+
>+					kaddr = kmap_atomic(page, KM_USER0);
>+					if (block_end > to)
>+						memset(kaddr+to, 0,
>+							block_end-to);
>+					if (block_start < from)
>+						memset(kaddr+block_start,
>+							0, from-block_start);
> 					flush_dcache_page(page);
>+					kunmap_atomic(kaddr, KM_USER0);
>+				}
> 				continue;
> 			}
> 		}
>@@ -1884,10 +1889,14 @@ out:
> 		if (block_start >= to)
> 			break;
> 		if (buffer_new(bh)) {
>+			void *kaddr;
>+
> 			clear_buffer_new(bh);
> 			if (buffer_uptodate(bh))
> 				buffer_error();
>+			kaddr = kmap_atomic(page, KM_USER0);
> 			memset(kaddr+block_start, 0, bh->b_size);
>+			kunmap_atomic(kaddr, KM_USER0);
> 			set_buffer_uptodate(bh);
> 			mark_buffer_dirty(bh);
> 		}
>@@ -1973,9 +1982,10 @@ int block_read_full_page(struct page *pa
> 					SetPageError(page);
> 			}
> 			if (!buffer_mapped(bh)) {
>-				memset(kmap(page) + i*blocksize, 0, blocksize);
>+				void *kaddr = kmap_atomic(page, KM_USER0);
>+				memset(kaddr + i * blocksize, 0, blocksize);
> 				flush_dcache_page(page);
>-				kunmap(page);
>+				kunmap_atomic(kaddr, KM_USER0);
> 				set_buffer_uptodate(bh);
> 				continue;
> 			}
>@@ -2083,7 +2093,7 @@ int cont_prepare_write(struct page *page
> 	long status;
> 	unsigned zerofrom;
> 	unsigned blocksize = 1 << inode->i_blkbits;
>-	char *kaddr;
>+	void *kaddr;
> 
> 	while(page->index > (pgpos = *bytes>>PAGE_CACHE_SHIFT)) {
> 		status = -ENOMEM;
>@@ -2105,12 +2115,12 @@ int cont_prepare_write(struct page *page
> 						PAGE_CACHE_SIZE, get_block);
> 		if (status)
> 			goto out_unmap;
>-		kaddr = page_address(new_page);
>+		kaddr = kmap_atomic(new_page, KM_USER0);
> 		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
> 		flush_dcache_page(new_page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		__block_commit_write(inode, new_page,
> 				zerofrom, PAGE_CACHE_SIZE);
>-		kunmap(new_page);
> 		unlock_page(new_page);
> 		page_cache_release(new_page);
> 	}
>@@ -2135,21 +2145,20 @@ int cont_prepare_write(struct page *page
> 	status = __block_prepare_write(inode, page, zerofrom, to, get_block);
> 	if (status)
> 		goto out1;
>-	kaddr = page_address(page);
> 	if (zerofrom < offset) {
>+		kaddr = kmap_atomic(page, KM_USER0);
> 		memset(kaddr+zerofrom, 0, offset-zerofrom);
> 		flush_dcache_page(page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		__block_commit_write(inode, page, zerofrom, offset);
> 	}
> 	return 0;
> out1:
> 	ClearPageUptodate(page);
>-	kunmap(page);
> 	return status;
> 
> out_unmap:
> 	ClearPageUptodate(new_page);
>-	kunmap(new_page);
> 	unlock_page(new_page);
> 	page_cache_release(new_page);
> out:
>@@ -2161,10 +2170,8 @@ int block_prepare_write(struct page *pag
> {
> 	struct inode *inode = page->mapping->host;
> 	int err = __block_prepare_write(inode, page, from, to, get_block);
>-	if (err) {
>+	if (err)
> 		ClearPageUptodate(page);
>-		kunmap(page);
>-	}
> 	return err;
> }
> 
>@@ -2172,7 +2179,6 @@ int block_commit_write(struct page *page
> {
> 	struct inode *inode = page->mapping->host;
> 	__block_commit_write(inode,page,from,to);
>-	kunmap(page);
> 	return 0;
> }
> 
>@@ -2182,7 +2188,6 @@ int generic_commit_write(struct file *fi
> 	struct inode *inode = page->mapping->host;
> 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> 	__block_commit_write(inode,page,from,to);
>-	kunmap(page);
> 	if (pos > inode->i_size) {
> 		inode->i_size = pos;
> 		mark_inode_dirty(inode);
>@@ -2199,6 +2204,7 @@ int block_truncate_page(struct address_s
> 	struct inode *inode = mapping->host;
> 	struct page *page;
> 	struct buffer_head *bh;
>+	void *kaddr;
> 	int err;
> 
> 	blocksize = 1 << inode->i_blkbits;
>@@ -2251,9 +2257,10 @@ int block_truncate_page(struct address_s
> 			goto unlock;
> 	}
> 
>-	memset(kmap(page) + offset, 0, length);
>+	kaddr = kmap_atomic(page, KM_USER0);
>+	memset(kaddr + offset, 0, length);
> 	flush_dcache_page(page);
>-	kunmap(page);
>+	kunmap_atomic(kaddr, KM_USER0);
> 
> 	mark_buffer_dirty(bh);
> 	err = 0;
>@@ -2273,7 +2280,7 @@ int block_write_full_page(struct page *p
> 	struct inode * const inode = page->mapping->host;
> 	const unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
> 	unsigned offset;
>-	char *kaddr;
>+	void *kaddr;
> 
> 	/* Is the page fully inside i_size? */
> 	if (page->index < end_index)
>@@ -2293,10 +2300,10 @@ int block_write_full_page(struct page *p
> 	 * the  page size, the remaining memory is zeroed when mapped, and
> 	 * writes to that region are not written out to the file."
> 	 */
>-	kaddr = kmap(page);
>+	kaddr = kmap_atomic(page, KM_USER0);
> 	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
> 	flush_dcache_page(page);
>-	kunmap(page);
>+	kunmap_atomic(page, KM_USER0);
> 	return __block_write_full_page(inode, page, get_block);
> }
> 
>--- 2.5.30/fs/ext3/inode.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/ext3/inode.c	Fri Aug  9 17:36:45 2002
>@@ -1048,16 +1048,6 @@ static int ext3_prepare_write(struct fil
> 	if (ext3_should_journal_data(inode)) {
> 		ret = walk_page_buffers(handle, page_buffers(page),
> 				from, to, NULL, do_journal_get_write_access);
>-		if (ret) {
>-			/*
>-			 * We're going to fail this prepare_write(),
>-			 * so commit_write() will not be called.
>-			 * We need to undo block_prepare_write()'s kmap().
>-			 * AKPM: Do we need to clear PageUptodate?  I don't
>-			 * think so.
>-			 */
>-			kunmap(page);
>-		}
> 	}
> prepare_write_failed:
> 	if (ret)
>@@ -1117,7 +1107,6 @@ static int ext3_commit_write(struct file
> 			from, to, &partial, commit_write_fn);
> 		if (!partial)
> 			SetPageUptodate(page);
>-		kunmap(page);
> 		if (pos > inode->i_size)
> 			inode->i_size = pos;
> 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
>@@ -1128,17 +1117,8 @@ static int ext3_commit_write(struct file
> 		}
> 		/* Be careful here if generic_commit_write becomes a
> 		 * required invocation after block_prepare_write. */
>-		if (ret == 0) {
>+		if (ret == 0)
> 			ret = generic_commit_write(file, page, from, to);
>-		} else {
>-			/*
>-			 * block_prepare_write() was called, but we're not
>-			 * going to call generic_commit_write().  So we
>-			 * need to perform generic_commit_write()'s kunmap
>-			 * by hand.
>-			 */
>-			kunmap(page);
>-		}
> 	}
> 	if (inode->i_size > EXT3_I(inode)->i_disksize) {
> 		EXT3_I(inode)->i_disksize = inode->i_size;
>@@ -1433,6 +1413,7 @@ static int ext3_block_truncate_page(hand
> 	struct page *page;
> 	struct buffer_head *bh;
> 	int err;
>+	void *kaddr;
> 
> 	blocksize = inode->i_sb->s_blocksize;
> 	length = offset & (blocksize - 1);
>@@ -1488,10 +1469,11 @@ static int ext3_block_truncate_page(hand
> 		if (err)
> 			goto unlock;
> 	}
>-	
>-	memset(kmap(page) + offset, 0, length);
>+
>+	kaddr = kmap_atomic(page, KM_USER0);
>+	memset(kaddr + offset, 0, length);
> 	flush_dcache_page(page);
>-	kunmap(page);
>+	kunmap_atomic(kaddr, KM_USER0);
> 
> 	BUFFER_TRACE(bh, "zeroed end of block");
> 
>--- 2.5.30/fs/ext2/dir.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/ext2/dir.c	Fri Aug  9 17:36:45 2002
>@@ -571,8 +571,8 @@ int ext2_make_empty(struct inode *inode,
> 	struct page *page = grab_cache_page(mapping, 0);
> 	unsigned chunk_size = ext2_chunk_size(inode);
> 	struct ext2_dir_entry_2 * de;
>-	char *base;
> 	int err;
>+	void *kaddr;
> 
> 	if (!page)
> 		return -ENOMEM;
>@@ -581,22 +581,21 @@ int ext2_make_empty(struct inode *inode,
> 		unlock_page(page);
> 		goto fail;
> 	}
>-	base = page_address(page);
>-
>-	de = (struct ext2_dir_entry_2 *) base;
>+	kaddr = kmap_atomic(page, KM_USER0);
>+	de = (struct ext2_dir_entry_2 *)kaddr;
> 	de->name_len = 1;
> 	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(1));
> 	memcpy (de->name, ".\0\0", 4);
> 	de->inode = cpu_to_le32(inode->i_ino);
> 	ext2_set_de_type (de, inode);
> 
>-	de = (struct ext2_dir_entry_2 *) (base + EXT2_DIR_REC_LEN(1));
>+	de = (struct ext2_dir_entry_2 *)(kaddr + EXT2_DIR_REC_LEN(1));
> 	de->name_len = 2;
> 	de->rec_len = cpu_to_le16(chunk_size - EXT2_DIR_REC_LEN(1));
> 	de->inode = cpu_to_le32(parent->i_ino);
> 	memcpy (de->name, "..\0", 4);
> 	ext2_set_de_type (de, inode);
>-
>+	kunmap_atomic(kaddr, KM_USER0);
> 	err = ext2_commit_chunk(page, 0, chunk_size);
> fail:
> 	page_cache_release(page);
>--- 2.5.30/fs/namei.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/namei.c	Fri Aug  9 17:36:45 2002
>@@ -2200,8 +2200,9 @@ int page_symlink(struct inode *inode, co
> 	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
> 	if (err)
> 		goto fail_map;
>-	kaddr = page_address(page);
>+	kaddr = kmap_atomic(page, KM_USER0);
> 	memcpy(kaddr, symname, len-1);
>+	kunmap_atomic(kaddr, KM_USER0);
> 	mapping->a_ops->commit_write(NULL, page, 0, len-1);
> 	/*
> 	 * Notice that we are _not_ going to block here - end of page is
>--- 2.5.30/drivers/block/loop.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/drivers/block/loop.c	Fri Aug  9 17:36:45 2002
>@@ -210,8 +210,7 @@ do_lo_send(struct loop_device *lo, struc
> 			goto fail;
> 		if (aops->prepare_write(file, page, offset, offset+size))
> 			goto unlock;
>-		kaddr = page_address(page);
>-		flush_dcache_page(page);
>+		kaddr = kmap(page);
> 		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
> 		if (transfer_result) {
> 			/*
>@@ -221,6 +220,8 @@ do_lo_send(struct loop_device *lo, struc
> 			printk(KERN_ERR "loop: transfer error block %ld\n", index);
> 			memset(kaddr + offset, 0, size);
> 		}
>+		flush_dcache_page(page);
>+		kunmap(page);
> 		if (aops->commit_write(file, page, offset, offset+size))
> 			goto unlock;
> 		if (transfer_result)
>--- 2.5.30/drivers/block/rd.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/drivers/block/rd.c	Fri Aug  9 17:36:45 2002
>@@ -109,9 +109,11 @@ int rd_blocksize = BLOCK_SIZE;			/* bloc
> static int ramdisk_readpage(struct file *file, struct page * page)
> {
> 	if (!PageUptodate(page)) {
>-		memset(kmap(page), 0, PAGE_CACHE_SIZE);
>-		kunmap(page);
>+		void *kaddr = kmap_atomic(page, KM_USER0);
>+
>+		memset(kaddr, 0, PAGE_CACHE_SIZE);
> 		flush_dcache_page(page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		SetPageUptodate(page);
> 	}
> 	unlock_page(page);
>@@ -121,9 +123,11 @@ static int ramdisk_readpage(struct file 
> static int ramdisk_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
> {
> 	if (!PageUptodate(page)) {
>-		void *addr = page_address(page);
>-		memset(addr, 0, PAGE_CACHE_SIZE);
>+		void *kaddr = kmap_atomic(page, KM_USER0);
>+
>+		memset(kaddr, 0, PAGE_CACHE_SIZE);
> 		flush_dcache_page(page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		SetPageUptodate(page);
> 	}
> 	SetPageDirty(page);
>@@ -178,8 +182,11 @@ static int rd_blkdev_pagecache_IO(int rw
> 			err = 0;
> 
> 			if (!PageUptodate(page)) {
>-				memset(kmap(page), 0, PAGE_CACHE_SIZE);
>-				kunmap(page);
>+				void *kaddr = kmap_atomic(page, KM_USER0);
>+
>+				memset(kaddr, 0, PAGE_CACHE_SIZE);
>+				flush_dcache_page(page);
>+				kunmap_atomic(kaddr, KM_USER0);
> 				SetPageUptodate(page);
> 			}
> 
>--- 2.5.30/fs/affs/file.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/affs/file.c	Fri Aug  9 17:36:45 2002
>@@ -27,6 +27,7 @@
> #include <linux/fs.h>
> #include <linux/amigaffs.h>
> #include <linux/mm.h>
>+#include <linux/highmem.h>
> #include <linux/pagemap.h>
> #include <linux/buffer_head.h>
> 
>@@ -518,6 +519,7 @@ affs_do_readpage_ofs(struct file *file, 
> 	pr_debug("AFFS: read_page(%u, %ld, %d, %d)\n", (u32)inode->i_ino, page->index, from, to);
> 	if (from > to || to > PAGE_CACHE_SIZE)
> 		BUG();
>+	kmap(page);
> 	data = page_address(page);
> 	bsize = AFFS_SB(sb)->s_data_blksize;
> 	tmp = (page->index << PAGE_CACHE_SHIFT) + from;
>@@ -532,11 +534,14 @@ affs_do_readpage_ofs(struct file *file, 
> 		if (from + tmp > to || tmp > bsize)
> 			BUG();
> 		memcpy(data + from, AFFS_DATA(bh) + boff, tmp);
>+		flush_dcache_page(page);
> 		affs_brelse(bh);
> 		bidx++;
> 		from += tmp;
> 		boff = 0;
> 	}
>+	flush_dcache_page(page);
>+	kunmap(page);
> 	return 0;
> }
> 
>@@ -656,7 +661,11 @@ static int affs_prepare_write_ofs(struct
> 			return err;
> 	}
> 	if (to < PAGE_CACHE_SIZE) {
>-		memset(page_address(page) + to, 0, PAGE_CACHE_SIZE - to);
>+		char *kaddr = kmap_atomic(page, KM_USER0);
>+
>+		memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
>+		flush_dcache_page(page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		if (size > offset + to) {
> 			if (size < offset + PAGE_CACHE_SIZE)
> 				tmp = size & ~PAGE_CACHE_MASK;
>--- 2.5.30/fs/driverfs/inode.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/driverfs/inode.c	Fri Aug  9 17:36:45 2002
>@@ -71,10 +71,11 @@ static int driverfs_readpage(struct file
> 
> static int driverfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
> {
>-	void *addr = kmap(page);
> 	if (!PageUptodate(page)) {
>-		memset(addr, 0, PAGE_CACHE_SIZE);
>+		void *kaddr = kmap_atomic(page, KM_USER0);
>+		memset(kaddr, 0, PAGE_CACHE_SIZE);
> 		flush_dcache_page(page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		SetPageUptodate(page);
> 	}
> 	return 0;
>@@ -86,7 +87,6 @@ static int driverfs_commit_write(struct 
> 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> 
> 	set_page_dirty(page);
>-	kunmap(page);
> 	if (pos > inode->i_size)
> 		inode->i_size = pos;
> 	return 0;
>--- 2.5.30/fs/jffs/inode-v23.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/jffs/inode-v23.c	Fri Aug  9 17:36:45 2002
>@@ -47,6 +47,7 @@
> #include <linux/stat.h>
> #include <linux/blkdev.h>
> #include <linux/quotaops.h>
>+#include <linux/highmem.h>
> #include <linux/smp_lock.h>
> #include <asm/semaphore.h>
> #include <asm/byteorder.h>
>@@ -751,7 +752,6 @@ jffs_do_readpage_nolock(struct file *fil
> 
> 	get_page(page);
> 	/* Don't SetPageLocked(page), should be locked already */
>-	buf = page_address(page);
> 	ClearPageUptodate(page);
> 	ClearPageError(page);
> 
>@@ -760,8 +760,10 @@ jffs_do_readpage_nolock(struct file *fil
> 
> 	read_len = 0;
> 	result = 0;
>-
> 	offset = page->index << PAGE_CACHE_SHIFT;
>+
>+	kmap(page);
>+	buf = page_address(page);
> 	if (offset < inode->i_size) {
> 		read_len = min_t(long, inode->i_size - offset, PAGE_SIZE);
> 		r = jffs_read_data(f, buf, offset, read_len);
>@@ -779,6 +781,8 @@ jffs_do_readpage_nolock(struct file *fil
> 	/* This handles the case of partial or no read in above */
> 	if(read_len < PAGE_SIZE)
> 	        memset(buf + read_len, 0, PAGE_SIZE - read_len);
>+	flush_dcache_page(page);
>+	kunmap(page);
> 
> 	D3(printk (KERN_NOTICE "readpage(): up biglock\n"));
> 	up(&c->fmc->biglock);
>@@ -788,9 +792,8 @@ jffs_do_readpage_nolock(struct file *fil
> 	}else {
> 	        SetPageUptodate(page);	        
> 	}
>-	flush_dcache_page(page);
> 
>-	put_page(page);
>+	page_cache_release(page);
> 
> 	D3(printk("jffs_readpage(): Leaving...\n"));
> 
>--- 2.5.30/fs/jffs2/file.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/jffs2/file.c	Fri Aug  9 17:36:45 2002
>@@ -17,6 +17,7 @@
> #include <linux/fs.h>
> #include <linux/time.h>
> #include <linux/pagemap.h>
>+#include <linux/highmem.h>
> #include <linux/crc32.h>
> #include <linux/jffs2.h>
> #include "nodelist.h"
>@@ -381,9 +382,10 @@ int jffs2_commit_write (struct file *fil
> 	ri->isize = (uint32_t)inode->i_size;
> 	ri->atime = ri->ctime = ri->mtime = CURRENT_TIME;
> 
>-	/* We rely on the fact that generic_file_write() currently kmaps the page for us. */
>+	kmap(pg);
> 	ret = jffs2_write_inode_range(c, f, ri, page_address(pg) + start,
> 				      (pg->index << PAGE_CACHE_SHIFT) + start, end - start, &writtenlen);
>+	kunmap(pg);
> 
> 	if (ret) {
> 		/* There was an error writing. */
>--- 2.5.30/fs/jfs/jfs_metapage.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/jfs/jfs_metapage.c	Fri Aug  9 17:36:45 2002
>@@ -467,7 +467,6 @@ static void __write_metapage(metapage_t 
> 	if (rc) {
> 		jERROR(1, ("prepare_write return %d!\n", rc));
> 		ClearPageUptodate(mp->page);
>-		kunmap(mp->page);
> 		unlock_page(mp->page);
> 		clear_bit(META_dirty, &mp->flag);
> 		return;
>--- 2.5.30/fs/minix/dir.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/minix/dir.c	Fri Aug  9 17:36:45 2002
>@@ -7,6 +7,7 @@
>  */
> 
> #include "minix.h"
>+#include <linux/highmem.h>
> #include <linux/smp_lock.h>
> 
> typedef struct minix_dir_entry minix_dirent;
>@@ -261,7 +262,7 @@ int minix_delete_entry(struct minix_dir_
> {
> 	struct address_space *mapping = page->mapping;
> 	struct inode *inode = (struct inode*)mapping->host;
>-	char *kaddr = (char*)page_address(page);
>+	char *kaddr = page_address(page);
> 	unsigned from = (char*)de - kaddr;
> 	unsigned to = from + minix_sb(inode->i_sb)->s_dirsize;
> 	int err;
>@@ -286,7 +287,7 @@ int minix_make_empty(struct inode *inode
> 	struct page *page = grab_cache_page(mapping, 0);
> 	struct minix_sb_info * sbi = minix_sb(inode->i_sb);
> 	struct minix_dir_entry * de;
>-	char *base;
>+	char *kaddr;
> 	int err;
> 
> 	if (!page)
>@@ -297,15 +298,16 @@ int minix_make_empty(struct inode *inode
> 		goto fail;
> 	}
> 
>-	base = (char*)page_address(page);
>-	memset(base, 0, PAGE_CACHE_SIZE);
>+	kaddr = kmap_atomic(page, KM_USER0);
>+	memset(kaddr, 0, PAGE_CACHE_SIZE);
> 
>-	de = (struct minix_dir_entry *) base;
>+	de = (struct minix_dir_entry *)kaddr;
> 	de->inode = inode->i_ino;
> 	strcpy(de->name,".");
> 	de = minix_next_entry(de, sbi);
> 	de->inode = dir->i_ino;
> 	strcpy(de->name,"..");
>+	kunmap_atomic(kaddr, KM_USER0);
> 
> 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
> fail:
>--- 2.5.30/fs/ramfs/inode.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/ramfs/inode.c	Fri Aug  9 17:36:45 2002
>@@ -26,6 +26,7 @@
> #include <linux/module.h>
> #include <linux/fs.h>
> #include <linux/pagemap.h>
>+#include <linux/highmem.h>
> #include <linux/init.h>
> #include <linux/string.h>
> #include <linux/smp_lock.h>
>@@ -47,8 +48,10 @@ static struct inode_operations ramfs_dir
> static int ramfs_readpage(struct file *file, struct page * page)
> {
> 	if (!PageUptodate(page)) {
>-		memset(kmap(page), 0, PAGE_CACHE_SIZE);
>-		kunmap(page);
>+		char *kaddr = kmap_atomic(page, KM_USER0);
>+
>+		memset(kaddr, 0, PAGE_CACHE_SIZE);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		flush_dcache_page(page);
> 		SetPageUptodate(page);
> 	}
>@@ -58,10 +61,12 @@ static int ramfs_readpage(struct file *f
> 
> static int ramfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
> {
>-	void *addr = kmap(page);
> 	if (!PageUptodate(page)) {
>-		memset(addr, 0, PAGE_CACHE_SIZE);
>+		char *kaddr = kmap_atomic(page, KM_USER0);
>+
>+		memset(kaddr, 0, PAGE_CACHE_SIZE);
> 		flush_dcache_page(page);
>+		kunmap_atomic(kaddr, KM_USER0);
> 		SetPageUptodate(page);
> 	}
> 	SetPageDirty(page);
>@@ -73,7 +78,6 @@ static int ramfs_commit_write(struct fil
> 	struct inode *inode = page->mapping->host;
> 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> 
>-	kunmap(page);
> 	if (pos > inode->i_size)
> 		inode->i_size = pos;
> 	return 0;
>--- 2.5.30/fs/reiserfs/inode.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/reiserfs/inode.c	Fri Aug  9 17:36:45 2002
>@@ -7,6 +7,7 @@
> #include <linux/reiserfs_fs.h>
> #include <linux/smp_lock.h>
> #include <linux/pagemap.h>
>+#include <linux/highmem.h>
> #include <asm/uaccess.h>
> #include <asm/unaligned.h>
> #include <linux/buffer_head.h>
>@@ -485,8 +486,10 @@ static int convert_tail_for_hole(struct 
>     ** won't trigger a get_block in this case.
>     */
>     fix_tail_page_for_writing(tail_page) ;
>+    kmap(tail_page);
>     retval = block_prepare_write(tail_page, tail_start, tail_end, 
>                                  reiserfs_get_block) ; 
>+    kunmap(tail_page);
>     if (retval)
>         goto unlock ;
> 
>@@ -1687,12 +1690,13 @@ static int grab_tail_page(struct inode *
>     /* start within the page of the last block in the file */
>     start = (offset / blocksize) * blocksize ;
> 
>+    kmap(page);
>     error = block_prepare_write(page, start, offset, 
> 				reiserfs_get_block_create_0) ;
>     if (error)
> 	goto unlock ;
> 
>-    kunmap(page) ; /* mapped by block_prepare_write */
>+    kunmap(page) ;
> 
>     head = page_buffers(page) ;      
>     bh = head;
>@@ -1788,10 +1792,13 @@ void reiserfs_truncate_file(struct inode
>         length = offset & (blocksize - 1) ;
> 	/* if we are not on a block boundary */
> 	if (length) {
>+	    char *kaddr;
>+
> 	    length = blocksize - length ;
>-	    memset((char *)kmap(page) + offset, 0, length) ;   
>+	    kaddr = kmap_atomic(page, KM_USER0) ;
>+	    memset(kaddr + offset, 0, length) ;   
> 	    flush_dcache_page(page) ;
>-	    kunmap(page) ;
>+	    kunmap_atomic(kaddr, KM_USER0) ;
> 	    if (buffer_mapped(bh) && bh->b_blocknr != 0) {
> 	        mark_buffer_dirty(bh) ;
> 	    }
>@@ -1941,23 +1948,25 @@ static int reiserfs_write_full_page(stru
>     struct buffer_head *arr[PAGE_CACHE_SIZE/512] ;
>     int nr = 0 ;
> 
>-    if (!page_has_buffers(page)) {
>+    if (!page_has_buffers(page))
>         block_prepare_write(page, 0, 0, NULL) ;
>-	kunmap(page) ;
>-    }
>+
>     /* last page in the file, zero out any contents past the
>     ** last byte in the file
>     */
>     if (page->index >= end_index) {
>+	char *kaddr;
>+
>         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
> 	/* no file contents in this page */
> 	if (page->index >= end_index + 1 || !last_offset) {
> 	    error =  -EIO ;
> 	    goto fail ;
> 	}
>-	memset((char *)kmap(page)+last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
>+	kaddr = kmap_atomic(page, KM_USER0);
>+	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
> 	flush_dcache_page(page) ;
>-	kunmap(page) ;
>+	kunmap_atomic(kaddr, KM_USER0) ;
>     }
>     head = page_buffers(page) ;
>     bh = head ;
>@@ -2040,6 +2049,7 @@ int reiserfs_prepare_write(struct file *
> 			   unsigned from, unsigned to) {
>     struct inode *inode = page->mapping->host ;
>     reiserfs_wait_on_write_block(inode->i_sb) ;
>+    kmap(page);
>     fix_tail_page_for_writing(page) ;
>     return block_prepare_write(page, from, to, reiserfs_get_block) ;
> }
>@@ -2082,6 +2092,7 @@ static int reiserfs_commit_write(struct 
>  	reiserfs_commit_for_inode(inode) ;
> 	reiserfs_write_unlock(inode->i_sb);
>     }
>+    kunmap(page);
>     return ret ;
> }
> 
>--- 2.5.30/fs/sysv/dir.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/sysv/dir.c	Fri Aug  9 17:36:45 2002
>@@ -14,6 +14,7 @@
>  */
> 
> #include <linux/pagemap.h>
>+#include <linux/highmem.h>
> #include <linux/smp_lock.h>
> #include "sysv.h"
> 
>@@ -273,6 +274,7 @@ int sysv_make_empty(struct inode *inode,
> 
> 	if (!page)
> 		return -ENOMEM;
>+	kmap(page);
> 	err = mapping->a_ops->prepare_write(NULL, page, 0, 2 * SYSV_DIRSIZE);
> 	if (err) {
> 		unlock_page(page);
>@@ -291,6 +293,7 @@ int sysv_make_empty(struct inode *inode,
> 
> 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
> fail:
>+	kunmap(page);
> 	page_cache_release(page);
> 	return err;
> }
>--- 2.5.30/fs/fat/inode.c~kmap_atomic_writes	Fri Aug  9 17:36:45 2002
>+++ 2.5.30-akpm/fs/fat/inode.c	Fri Aug  9 17:36:45 2002
>@@ -982,11 +982,24 @@ static int fat_readpage(struct file *fil
> {
> 	return block_read_full_page(page,fat_get_block);
> }
>-static int fat_prepare_write(struct file *file, struct page *page, unsigned from, unsigned to)
>+
>+static int
>+fat_prepare_write(struct file *file, struct page *page,
>+			unsigned from, unsigned to)
> {
>+	kmap(page);
> 	return cont_prepare_write(page,from,to,fat_get_block,
> 		&MSDOS_I(page->mapping->host)->mmu_private);
> }
>+
>+static int
>+fat_commit_write(struct file *file, struct page *page,
>+			unsigned from, unsigned to)
>+{
>+	kunmap(page);
>+	return generic_commit_write(file, page, from, to);
>+}
>+
> static int _fat_bmap(struct address_space *mapping, long block)
> {
> 	return generic_block_bmap(mapping,block,fat_get_block);
>@@ -996,7 +1009,7 @@ static struct address_space_operations f
> 	writepage: fat_writepage,
> 	sync_page: block_sync_page,
> 	prepare_write: fat_prepare_write,
>-	commit_write: generic_commit_write,
>+	commit_write: fat_commit_write,
> 	bmap: _fat_bmap
> };
> 
>
>.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans



