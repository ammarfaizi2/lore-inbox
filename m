Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRCATjc>; Thu, 1 Mar 2001 14:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129837AbRCATjW>; Thu, 1 Mar 2001 14:39:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55171 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129835AbRCATjO>;
	Thu, 1 Mar 2001 14:39:14 -0500
Date: Thu, 1 Mar 2001 14:39:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: gator@cs.tu-berlin.de, linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] Re: fat problem in 2.4.2
In-Reply-To: <E14YXft-0008GK-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0103011345110.11577-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, Alan Cox wrote:

> > In that case, why was it changed for FAT only? Ext2 will still
> > happily enlarge a file by truncating it.
> 
> ftruncate() and truncate() may extend a file but they are not required to
> do so.
> 
> > If the behavior has to be changed, wouldn't it be better to first
> > give people a chance to get programs, that rely on the old
> > behavior fixed, before enforcing the change?
> 
> A program relying on the old behaviour was violating standards. Also its been
> this way for almost two years.
> 
> > Staroffice (the binary-only version; the new "open source"
> > version is not yet ready for real-world use) for example
> > currently doesn't write to FAT filesystems anymore - which is
> > pretty annoying for people who need it.
> > 
> > Is there somewhere a patch for the current kernel?
> 
> You might be able to fish it out of old -ac kernel trees and debug it further.
> Alternatively you could implement it in glibc of course, which is a nicer
> solution

Alan, fix is really quite simple. Especially if you have vmtruncate()
returning int (ac1 used to do it, I didn't check later ones). Actually
just a generic_cont_expand() done on expanding path in vmtruncate()
will be enough - it should be OK for all cases, including normal
filesystems. <grabbing -ac7>

OK, any brave soul to test that? All I can promise that it builds.
							Cheers,
								Al
diff -urN S2-ac7/fs/affs/file.c S2-ac7-truncate/fs/affs/file.c
--- S2-ac7/fs/affs/file.c	Fri Feb 16 22:52:08 2001
+++ S2-ac7-truncate/fs/affs/file.c	Thu Mar  1 14:22:54 2001
@@ -663,25 +663,6 @@
 	net_blocksize = blocksize - ((inode->i_sb->u.affs_sb.s_flags & SF_OFS) ? 24 : 0);
 	first = inode->i_size + net_blocksize -1;
 	do_div (first, net_blocksize);
-	if (inode->u.affs_i.i_lastblock < first - 1) {
-		/* There has to be at least one new block to be allocated */
-		if (!inode->u.affs_i.i_ec && alloc_ext_cache(inode)) {
-			/* XXX Fine! No way to indicate an error. */
-			return /* -ENOSPC */;
-		}
-		bh = affs_getblock(inode,first - 1);
-		if (!bh) {
-			affs_warning(inode->i_sb,"truncate","Cannot extend file");
-			inode->i_size = net_blocksize * (inode->u.affs_i.i_lastblock + 1);
-		} else if (inode->i_sb->u.affs_sb.s_flags & SF_OFS) {
-			tmp = inode->i_size;
-			rem = do_div(tmp, net_blocksize);
-			DATA_FRONT(bh)->data_size = cpu_to_be32(rem ? rem : net_blocksize);
-			affs_fix_checksum(blocksize,bh->b_data,5);
-			mark_buffer_dirty(bh);
-		}
-		goto out_truncate;
-	}
 	ekey = inode->i_ino;
 	ext  = 0;
 
diff -urN S2-ac7/fs/fat/inode.c S2-ac7-truncate/fs/fat/inode.c
--- S2-ac7/fs/fat/inode.c	Thu Mar  1 14:05:17 2001
+++ S2-ac7-truncate/fs/fat/inode.c	Thu Mar  1 14:21:45 2001
@@ -904,12 +904,6 @@
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	/* FAT cannot truncate to a longer file */
-	if (attr->ia_valid & ATTR_SIZE) {
-		if (attr->ia_size > inode->i_size)
-			return -EPERM;
-	}
-
 	error = inode_change_ok(inode, attr);
 	if (error)
 		return MSDOS_SB(sb)->options.quiet ? 0 : error;
diff -urN S2-ac7/mm/memory.c S2-ac7-truncate/mm/memory.c
--- S2-ac7/mm/memory.c	Thu Mar  1 14:05:20 2001
+++ S2-ac7-truncate/mm/memory.c	Thu Mar  1 14:21:05 2001
@@ -924,7 +924,32 @@
 		zap_page_range(mm, start, len);
 	} while ((mpnt = mpnt->vm_next_share) != NULL);
 }
-			      
+
+static int generic_vm_expand(struct address_space *mapping, loff_t size)
+{
+	struct page *page;
+	unsigned long index, offset;
+	int err;
+
+	if (!mapping->a_ops->prepare_write || !mapping->a_ops->commit_write)
+		return -ENOSYS;
+
+	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
+	index = size >> PAGE_CACHE_SHIFT;
+	err = -ENOMEM;
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		goto out;
+	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
+	if (!err)
+		err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+	UnlockPage(page);
+	page_cache_release(page);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+}
 
 /*
  * Handle all mappings that got truncated by a "truncate()"
@@ -939,6 +964,7 @@
 	unsigned long partial, pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	unsigned long limit;
+	int err;
 
 	if (inode->i_size < offset)
 		goto do_expand;
@@ -976,10 +1002,14 @@
 			offset = limit;
 		}
 	}
-	inode->i_size = offset;
-	if (inode->i_op && inode->i_op->truncate)
+	err = generic_vm_expand(mapping, offset);
+	if (err == -ENOSYS) {
+		err = 0;
+		inode->i_size = offset;
+	}
+	if (!err && inode->i_op && inode->i_op->truncate)
 		inode->i_op->truncate(inode);
-	return 0;
+	return err;
 out:
 	return -EFBIG;
 }

