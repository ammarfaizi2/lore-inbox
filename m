Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRCAPKR>; Thu, 1 Mar 2001 10:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRCAPKI>; Thu, 1 Mar 2001 10:10:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34992 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129631AbRCAPJ4>;
	Thu, 1 Mar 2001 10:09:56 -0500
Date: Thu, 1 Mar 2001 10:09:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: fat problem in 2.4.2
In-Reply-To: <Pine.LNX.4.30.0103011502050.23650-100000@swamp.bayern.net>
Message-ID: <Pine.GSO.4.21.0103010944001.11577-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, Peter Daum wrote:

> In that case, why was it changed for FAT only? Ext2 will still
> happily enlarge a file by truncating it.

Basically, the program depends on behaviour that was never guaranteed to
be there.

> Staroffice (the binary-only version; the new "open source"
> version is not yet ready for real-world use) for example
> currently doesn't write to FAT filesystems anymore - which is
> pretty annoying for people who need it.

Staroffice is non-portable and badly written, film at 11...

BTW, _some_ subset is doable on FAT. You can't always do it (bloody
thing doesn't support holes), but you can try the following (warning -
untested patch):

diff -urN S2/fs/fat/inode.c S2-fat/fs/fat/inode.c
--- S2/fs/fat/inode.c	Fri Feb 16 22:52:07 2001
+++ S2-fat/fs/fat/inode.c	Thu Mar  1 10:02:45 2001
@@ -897,6 +897,36 @@
 	unlock_kernel();
 }
 
+int generic_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	unsigned long index, offset, limit;
+	int err;
+
+	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	if (limit != RLIM_INFINITY) {
+		if (size > limit) {
+			send_sig(SIGXFSZ, current, 0);
+			size = limit;
+		}
+	}
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
 
 int fat_notify_change(struct dentry * dentry, struct iattr * attr)
 {
@@ -904,11 +934,17 @@
 	struct inode *inode = dentry->d_inode;
-	int error;
+	int error = 0;
 
-	/* FAT cannot truncate to a longer file */
+	/*
+	 * On FAT truncate to a longer file may fail with -ENOSPC. No
+	 * way to report it from fat_truncate(), so...
+	 */
 	if (attr->ia_valid & ATTR_SIZE) {
 		if (attr->ia_size > inode->i_size)
-			return -EPERM;
+			error = generic_cont_expand(inode, attr->ia_size);
 	}
+
+	if (error)
+		return error;
 
 	error = inode_change_ok(inode, attr);
 	if (error)

That said, if your only problem is Staroffice... <shrug> I would rather
rm the crapware and forget about it, but YMMV.
							Cheers,
								Al

