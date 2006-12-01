Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758987AbWLAFIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758987AbWLAFIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758996AbWLAFIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:08:55 -0500
Received: from ns.suse.de ([195.135.220.2]:5802 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758987AbWLAFIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:08:54 -0500
Date: Fri, 1 Dec 2006 06:08:52 +0100
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061201050852.GA31347@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp> <20061201020910.GC455@wotan.suse.de> <87mz68xoyi.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mz68xoyi.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 12:41:25PM +0900, OGAWA Hirofumi wrote:
> 
> Yes, this patch doesn't pass zero-length to prepare_write. However,
> I'm not checking this patch is ok for reiserfs...

OK, vfat wasn't working correctly for me -- I needed the following patch:

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2006-12-01 15:31:22.000000000 +1100
+++ linux-2.6/fs/buffer.c	2006-12-01 16:02:23.000000000 +1100
@@ -2102,6 +2102,7 @@
 			*bytes |= (blocksize-1);
 			(*bytes)++;
 		}
+
 		status = __block_prepare_write(inode, new_page, zerofrom,
 						PAGE_CACHE_SIZE, get_block);
 		if (status)
@@ -2110,7 +2111,7 @@
 		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
 		flush_dcache_page(new_page);
 		kunmap_atomic(kaddr, KM_USER0);
-		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
+		__block_commit_write(inode, new_page, zerofrom, PAGE_CACHE_SIZE);
 		unlock_page(new_page);
 		page_cache_release(new_page);
 	}
@@ -2142,6 +2143,7 @@
 		kunmap_atomic(kaddr, KM_USER0);
 		__block_commit_write(inode, page, zerofrom, offset);
 	}
+
 	return 0;
 out1:
 	ClearPageUptodate(page);
Index: linux-2.6/fs/fat/inode.c
===================================================================
--- linux-2.6.orig/fs/fat/inode.c	2006-12-01 15:31:22.000000000 +1100
+++ linux-2.6/fs/fat/inode.c	2006-12-01 16:02:08.000000000 +1100
@@ -151,7 +151,8 @@
 {
 	struct inode *inode = page->mapping->host;
 	int err;
-	if (to - from > 0)
+
+	if (to - from == 0)
 		return 0;
 
 	err = generic_commit_write(file, page, from, to);

And reiserfs has some creative uses of generic_cont_expand, which I
think I've fixed in the following way. I'll send out the full patch
if you (and others) agree with the changes.


Index: linux-2.6/fs/reiserfs/file.c
===================================================================
--- linux-2.6.orig/fs/reiserfs/file.c	2006-12-01 16:01:17.000000000 +1100
+++ linux-2.6/fs/reiserfs/file.c	2006-12-01 16:03:34.000000000 +1100
@@ -892,6 +892,34 @@
 	return retval;
 }
 
+static int reiserfs_convert_tail(struct inode *inode, loff_t offset)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t index;
+	struct page *page;
+	int err = -ENOMEM;
+
+	index = offset >> PAGE_CACHE_SHIFT;
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		goto out;
+
+	offset = offset & ~PAGE_CACHE_MASK;
+	WARN_ON(!offset); /* shouldn't pass zero length to prepare/commit */
+
+	err = mapping->a_ops->prepare_write(NULL, page, 0, offset);
+	if (err)
+		goto out_unlock;
+
+	err = mapping->a_ops->commit_write(NULL, page, 0, offset);
+
+out_unlock:
+	unlock_page(page);
+	page_cache_release(page);
+out:
+	return err;
+}
+
 /* Look if passed writing region is going to touch file's tail
    (if it is present). And if it is, convert the tail to unformatted node */
 static int reiserfs_check_for_tail_and_convert(struct inode *inode,	/* inode to deal with */
@@ -937,7 +965,8 @@
 		    le_key_k_offset(get_inode_item_key_version(inode),
 				    &(ih->ih_key));
 		pathrelse(&path);
-		res = generic_cont_expand(inode, cont_expand_offset);
+
+		res = reiserfs_convert_tail(inode, cont_expand_offset);
 	} else
 		pathrelse(&path);
 
