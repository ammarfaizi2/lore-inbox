Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSHJNEN>; Sat, 10 Aug 2002 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSHJNEN>; Sat, 10 Aug 2002 09:04:13 -0400
Received: from angband.namesys.com ([212.16.7.85]:2944 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S316886AbSHJNEM>; Sat, 10 Aug 2002 09:04:12 -0400
Date: Sat, 10 Aug 2002 17:07:56 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: Re: [patch 7/12] use atomic kmaps in generic_file_write
Message-ID: <20020810170756.A975@namesys.com>
References: <3D5464E8.28CA1AF4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3D5464E8.28CA1AF4@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Aug 09, 2002 at 05:57:12PM -0700, Andrew Morton wrote:

> I made a bit of a mess of reiserfs.  It works OK, but I suspect it's
> performing unnecessary kmaps.

We have reviewed the fs/reiserfs/inode.c change you proposed and we think
that patch below should be applied instead of it.
Unfortunatelly we were not able to test it as 2.5.30 + your patches
locks up even before it have a chance to go to login prompt (and to even
touch reiserfs code, since I was booting off ext2 partition).

Bye,
    Oleg


===== stree.c 1.31 vs edited =====
--- 1.31/fs/reiserfs/stree.c	Tue Jul  9 18:28:17 2002
+++ edited/stree.c	Sat Aug 10 16:41:53 2002
@@ -1284,15 +1284,15 @@
         **
         ** p_s_un_bh is from the page cache (all unformatted nodes are
         ** from the page cache) and might be a highmem page.  So, we
-        ** can't use p_s_un_bh->b_data.  But, the page has already been
-        ** kmapped, so we can use page_address()
+        ** can't use p_s_un_bh->b_data.
 	** -clm
 	*/
 
-        data = page_address(p_s_un_bh->b_page) ;
+        data = kmap_atomic(p_s_un_bh->b_page, KM_USER0);
 	off = ((le_ih_k_offset (&s_ih) - 1) & (PAGE_CACHE_SIZE - 1));
 	memcpy(data + off,
 	       B_I_PITEM(PATH_PLAST_BUFFER(p_s_path), &s_ih), n_ret_value);
+	kunmap_atomic(p_s_un_bh->b_page, KM_USER0);
     }
 
     /* Perform balancing after all resources have been collected at once. */ 
===== inode.c 1.63 vs edited =====
--- 1.63/fs/reiserfs/inode.c	Thu May 30 18:37:30 2002
+++ edited/inode.c	Sat Aug 10 16:41:53 2002
@@ -7,6 +7,7 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
+#include <linux/highmem.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 #include <linux/buffer_head.h>
@@ -1692,8 +1693,6 @@
     if (error)
 	goto unlock ;
 
-    kunmap(page) ; /* mapped by block_prepare_write */
-
     head = page_buffers(page) ;      
     bh = head;
     do {
@@ -1788,10 +1787,13 @@
         length = offset & (blocksize - 1) ;
 	/* if we are not on a block boundary */
 	if (length) {
+	    char *kaddr;
+
 	    length = blocksize - length ;
-	    memset((char *)kmap(page) + offset, 0, length) ;   
+	    kaddr = kmap_atomic(page, KM_USER0) ;
+	    memset(kaddr + offset, 0, length) ;   
 	    flush_dcache_page(page) ;
-	    kunmap(page) ;
+	    kunmap_atomic(kaddr, KM_USER0) ;
 	    if (buffer_mapped(bh) && bh->b_blocknr != 0) {
 	        mark_buffer_dirty(bh) ;
 	    }
@@ -1941,23 +1943,25 @@
     struct buffer_head *arr[PAGE_CACHE_SIZE/512] ;
     int nr = 0 ;
 
-    if (!page_has_buffers(page)) {
+    if (!page_has_buffers(page))
         block_prepare_write(page, 0, 0, NULL) ;
-	kunmap(page) ;
-    }
+
     /* last page in the file, zero out any contents past the
     ** last byte in the file
     */
     if (page->index >= end_index) {
+	char *kaddr;
+
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
 	    error =  -EIO ;
 	    goto fail ;
 	}
-	memset((char *)kmap(page)+last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
 	flush_dcache_page(page) ;
-	kunmap(page) ;
+	kunmap_atomic(kaddr, KM_USER0) ;
     }
     head = page_buffers(page) ;
     bh = head ;
===== tail_conversion.c 1.22 vs edited =====
--- 1.22/fs/reiserfs/tail_conversion.c	Thu May 30 18:15:50 2002
+++ edited/tail_conversion.c	Sat Aug 10 16:41:53 2002
@@ -122,11 +122,12 @@
     }
     /* if we've copied bytes from disk into the page, we need to zero
     ** out the unused part of the block (it was not up to date before)
-    ** the page is still kmapped (by whoever called reiserfs_get_block)
     */
     if (up_to_date_bh) {
         unsigned pgoff = (tail_offset + total_tail - 1) & (PAGE_CACHE_SIZE - 1);
-	memset(page_address(unbh->b_page) + pgoff, 0, n_blk_size - total_tail) ;
+	char *kaddr=kmap_atomic(up_to_date_bh->b_page, KM_USER0);
+	memset(kaddr + pgoff, 0, n_blk_size - total_tail) ;
+	kunmap_atomic(up_to_date_bh->b_page, KM_USER0);
     }
 
     REISERFS_I(inode)->i_first_direct_byte = U32_MAX;
