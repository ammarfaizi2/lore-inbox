Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSGKFLX>; Thu, 11 Jul 2002 01:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317769AbSGKFLW>; Thu, 11 Jul 2002 01:11:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6930 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317767AbSGKFKC>;
	Thu, 11 Jul 2002 01:10:02 -0400
Message-ID: <3D2D1566.CD04CA29@zip.com.au>
Date: Wed, 10 Jul 2002 22:19:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Keith Mannthey <mannthey@us.ibm.com>, haveblue@us.ibm.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: scalable kmap (was Re: vm lock contention reduction) (fwd)
References: <237170000.1026317715@flay> <40740000.1026339488@w-hlinder> <3D2CF62E.949F20B4@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Not taking a kmap in generic_file_write is a biggish patch

OK, so I'm full of it.  It's actually quite simple and clean.

This patch is incremental to the one which you just tested.  It
takes an atomic kmap across generic_file_write().

There's a copy of these patches at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.25/

The patch also teaches ext2 and ext3 about the new API. If you're
using any other filesystems they will probably oops.

ext2 is still using regular kmap() for directory operations.

And this time, it actually buys 3% improvement on my lumbering hulk,
so your machine will hopefully see nice improvements.

Profile looks better too.  kmap_high and the IPI have vanished.


c013c164 304      0.50923     __set_page_dirty_nobuffers 
c0141008 355      0.59466     __block_commit_write    
c013e004 382      0.639887    vfs_write               
c01402fc 410      0.68679     __find_get_block        
c017fd70 471      0.788971    ext2_get_block          
c01e8eec 530      0.887802    radix_tree_lookup       
c012cef0 542      0.907903    unlock_page             
c013eeb0 562      0.941405    fget                    
c013dac0 585      0.979932    generic_file_llseek     
c01514e4 600      1.00506     __d_lookup              
c0106ff8 635      1.06369     system_call             
c01483b8 872      1.46069     link_path_walk          
c0134700 1014     1.69855     rmqueue                 
c0140b30 1191     1.99504     __block_prepare_write   
c0105368 4029     6.74897     poll_idle               
c012d8a8 9520     15.9469     file_read_actor         
c012ea70 23301    39.0315     generic_file_write      


 fs/buffer.c     |   57 +++++++++++++++++++++++++++++++-------------------------
 fs/ext2/inode.c |   16 +++++++++++++--
 fs/ext3/inode.c |   30 +++++------------------------
 mm/filemap.c    |    6 ++---
 4 files changed, 55 insertions(+), 54 deletions(-)

--- 2.5.25/mm/filemap.c~kmap_atomic_writes	Wed Jul 10 21:18:19 2002
+++ 2.5.25-akpm/mm/filemap.c	Wed Jul 10 21:24:41 2002
@@ -2228,6 +2228,7 @@ generic_file_write(struct file *file, co
 		unsigned long offset;
 		long page_fault;
 		char *kaddr;
+		struct copy_user_state copy_user_state;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
@@ -2252,22 +2253,22 @@ generic_file_write(struct file *file, co
 			break;
 		}
 
-		kaddr = kmap(page);
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
 			/*
 			 * prepare_write() may have instantiated a few blocks
 			 * outside i_size.  Trim these off again.
 			 */
-			kunmap(page);
 			unlock_page(page);
 			page_cache_release(page);
 			if (pos + bytes > inode->i_size)
 				vmtruncate(inode, inode->i_size);
 			break;
 		}
+		kaddr = kmap_copy_user(&copy_user_state, page, KM_FILEMAP, 0);
 		page_fault = __copy_from_user(kaddr + offset, buf, bytes);
 		flush_dcache_page(page);
+		kunmap_copy_user(&copy_user_state);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (unlikely(page_fault)) {
 			status = -EFAULT;
@@ -2282,7 +2283,6 @@ generic_file_write(struct file *file, co
 				buf += status;
 			}
 		}
-		kunmap(page);
 		if (!PageReferenced(page))
 			SetPageReferenced(page);
 		unlock_page(page);
--- 2.5.25/fs/buffer.c~kmap_atomic_writes	Wed Jul 10 21:25:11 2002
+++ 2.5.25-akpm/fs/buffer.c	Wed Jul 10 21:33:06 2002
@@ -1804,7 +1804,6 @@ static int __block_prepare_write(struct 
 	int err = 0;
 	unsigned blocksize, bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
-	char *kaddr = kmap(page);
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(from > PAGE_CACHE_SIZE);
@@ -1845,13 +1844,19 @@ static int __block_prepare_write(struct 
 					set_buffer_uptodate(bh);
 					continue;
 				}
-				if (block_end > to)
-					memset(kaddr+to, 0, block_end-to);
-				if (block_start < from)
-					memset(kaddr+block_start,
-						0, from-block_start);
-				if (block_end > to || block_start < from)
+				if (block_end > to || block_start < from) {
+					void *kaddr;
+
+					kaddr = kmap_atomic(page, KM_USER0);
+					if (block_end > to)
+						memset(kaddr+to, 0,
+							block_end-to);
+					if (block_start < from)
+						memset(kaddr+block_start,
+							0, from-block_start);
 					flush_dcache_page(page);
+					kunmap_atomic(kaddr, KM_USER0);
+				}
 				continue;
 			}
 		}
@@ -1890,10 +1895,14 @@ out:
 		if (block_start >= to)
 			break;
 		if (buffer_new(bh)) {
+			void *kaddr;
+
 			clear_buffer_new(bh);
 			if (buffer_uptodate(bh))
 				buffer_error();
+			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr+block_start, 0, bh->b_size);
+			kunmap_atomic(kaddr, KM_USER0);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 		}
@@ -1979,9 +1988,10 @@ int block_read_full_page(struct page *pa
 					SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
-				memset(kmap(page) + i*blocksize, 0, blocksize);
+				void *kaddr = kmap_atomic(page, KM_USER0);
+				memset(kaddr + i * blocksize, 0, blocksize);
 				flush_dcache_page(page);
-				kunmap(page);
+				kunmap_atomic(kaddr, KM_USER0);
 				set_buffer_uptodate(bh);
 				continue;
 			}
@@ -2089,7 +2099,7 @@ int cont_prepare_write(struct page *page
 	long status;
 	unsigned zerofrom;
 	unsigned blocksize = 1 << inode->i_blkbits;
-	char *kaddr;
+	void *kaddr;
 
 	while(page->index > (pgpos = *bytes>>PAGE_CACHE_SHIFT)) {
 		status = -ENOMEM;
@@ -2111,12 +2121,12 @@ int cont_prepare_write(struct page *page
 						PAGE_CACHE_SIZE, get_block);
 		if (status)
 			goto out_unmap;
-		kaddr = page_address(new_page);
+		kaddr = kmap_atomic(new_page, KM_USER0);
 		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
 		flush_dcache_page(new_page);
+		kunmap_atomic(kaddr, KM_USER0);
 		__block_commit_write(inode, new_page,
 				zerofrom, PAGE_CACHE_SIZE);
-		kunmap(new_page);
 		unlock_page(new_page);
 		page_cache_release(new_page);
 	}
@@ -2141,21 +2151,20 @@ int cont_prepare_write(struct page *page
 	status = __block_prepare_write(inode, page, zerofrom, to, get_block);
 	if (status)
 		goto out1;
-	kaddr = page_address(page);
 	if (zerofrom < offset) {
+		kaddr = kmap_atomic(page, KM_USER0);
 		memset(kaddr+zerofrom, 0, offset-zerofrom);
 		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
 		__block_commit_write(inode, page, zerofrom, offset);
 	}
 	return 0;
 out1:
 	ClearPageUptodate(page);
-	kunmap(page);
 	return status;
 
 out_unmap:
 	ClearPageUptodate(new_page);
-	kunmap(new_page);
 	unlock_page(new_page);
 	page_cache_release(new_page);
 out:
@@ -2167,10 +2176,8 @@ int block_prepare_write(struct page *pag
 {
 	struct inode *inode = page->mapping->host;
 	int err = __block_prepare_write(inode, page, from, to, get_block);
-	if (err) {
+	if (err)
 		ClearPageUptodate(page);
-		kunmap(page);
-	}
 	return err;
 }
 
@@ -2178,7 +2185,6 @@ int block_commit_write(struct page *page
 {
 	struct inode *inode = page->mapping->host;
 	__block_commit_write(inode,page,from,to);
-	kunmap(page);
 	return 0;
 }
 
@@ -2188,7 +2194,6 @@ int generic_commit_write(struct file *fi
 	struct inode *inode = page->mapping->host;
 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 	__block_commit_write(inode,page,from,to);
-	kunmap(page);
 	if (pos > inode->i_size) {
 		inode->i_size = pos;
 		mark_inode_dirty(inode);
@@ -2205,6 +2210,7 @@ int block_truncate_page(struct address_s
 	struct inode *inode = mapping->host;
 	struct page *page;
 	struct buffer_head *bh;
+	void *kaddr;
 	int err;
 
 	blocksize = 1 << inode->i_blkbits;
@@ -2257,9 +2263,10 @@ int block_truncate_page(struct address_s
 			goto unlock;
 	}
 
-	memset(kmap(page) + offset, 0, length);
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + offset, 0, length);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 
 	mark_buffer_dirty(bh);
 	err = 0;
@@ -2279,7 +2286,7 @@ int block_write_full_page(struct page *p
 	struct inode * const inode = page->mapping->host;
 	const unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
-	char *kaddr;
+	void *kaddr;
 
 	/* Is the page fully inside i_size? */
 	if (page->index < end_index)
@@ -2293,10 +2300,10 @@ int block_write_full_page(struct page *p
 	}
 
 	/* The page straddles i_size */
-	kaddr = kmap(page);
+	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return __block_write_full_page(inode, page, get_block);
 }
 
--- 2.5.25/fs/ext3/inode.c~kmap_atomic_writes	Wed Jul 10 21:34:16 2002
+++ 2.5.25-akpm/fs/ext3/inode.c	Wed Jul 10 21:35:08 2002
@@ -1048,16 +1048,6 @@ static int ext3_prepare_write(struct fil
 	if (ext3_should_journal_data(inode)) {
 		ret = walk_page_buffers(handle, page_buffers(page),
 				from, to, NULL, do_journal_get_write_access);
-		if (ret) {
-			/*
-			 * We're going to fail this prepare_write(),
-			 * so commit_write() will not be called.
-			 * We need to undo block_prepare_write()'s kmap().
-			 * AKPM: Do we need to clear PageUptodate?  I don't
-			 * think so.
-			 */
-			kunmap(page);
-		}
 	}
 prepare_write_failed:
 	if (ret)
@@ -1117,7 +1107,6 @@ static int ext3_commit_write(struct file
 			from, to, &partial, commit_write_fn);
 		if (!partial)
 			SetPageUptodate(page);
-		kunmap(page);
 		if (pos > inode->i_size)
 			inode->i_size = pos;
 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
@@ -1128,17 +1117,8 @@ static int ext3_commit_write(struct file
 		}
 		/* Be careful here if generic_commit_write becomes a
 		 * required invocation after block_prepare_write. */
-		if (ret == 0) {
+		if (ret == 0)
 			ret = generic_commit_write(file, page, from, to);
-		} else {
-			/*
-			 * block_prepare_write() was called, but we're not
-			 * going to call generic_commit_write().  So we
-			 * need to perform generic_commit_write()'s kunmap
-			 * by hand.
-			 */
-			kunmap(page);
-		}
 	}
 	if (inode->i_size > EXT3_I(inode)->i_disksize) {
 		EXT3_I(inode)->i_disksize = inode->i_size;
@@ -1433,6 +1413,7 @@ static int ext3_block_truncate_page(hand
 	struct page *page;
 	struct buffer_head *bh;
 	int err;
+	void *kaddr;
 
 	blocksize = inode->i_sb->s_blocksize;
 	length = offset & (blocksize - 1);
@@ -1488,10 +1469,11 @@ static int ext3_block_truncate_page(hand
 		if (err)
 			goto unlock;
 	}
-	
-	memset(kmap(page) + offset, 0, length);
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + offset, 0, length);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 
 	BUFFER_TRACE(bh, "zeroed end of block");
 
--- 2.5.25/fs/ext2/inode.c~kmap_atomic_writes	Wed Jul 10 21:35:31 2002
+++ 2.5.25-akpm/fs/ext2/inode.c	Wed Jul 10 21:42:34 2002
@@ -595,12 +595,24 @@ ext2_readpages(struct address_space *map
 }
 
 static int
-ext2_prepare_write(struct file *file, struct page *page,
+ext2_prepare_write(struct file *file_may_be_null, struct page *page,
 			unsigned from, unsigned to)
 {
+	if (S_ISDIR(page->mapping->host->i_mode))
+		kmap(page);
 	return block_prepare_write(page,from,to,ext2_get_block);
 }
 
+static int ext2_commit_write(struct file *file, struct page *page,
+			unsigned from, unsigned to)
+{
+	int ret = generic_commit_write(file, page, from, to);
+
+	if (S_ISDIR(page->mapping->host->i_mode))
+		kunmap(page);
+	return ret;
+}
+
 static int ext2_bmap(struct address_space *mapping, long block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
@@ -633,7 +645,7 @@ struct address_space_operations ext2_aop
 	writepage:		ext2_writepage,
 	sync_page:		block_sync_page,
 	prepare_write:		ext2_prepare_write,
-	commit_write:		generic_commit_write,
+	commit_write:		ext2_commit_write,
 	bmap:			ext2_bmap,
 	direct_IO:		ext2_direct_IO,
 	writepages:		ext2_writepages,

-
