Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129963AbQKNVwJ>; Tue, 14 Nov 2000 16:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130704AbQKNVv6>; Tue, 14 Nov 2000 16:51:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58635 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129963AbQKNVvu>;
	Tue, 14 Nov 2000 16:51:50 -0500
Date: Tue, 14 Nov 2000 16:21:33 -0500
Message-Id: <200011142121.QAA01124@havoc.gtf.org>
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        William Stearns <wstearns@pobox.com>
Subject: PATCH 2.4.0.11.4: loopback block device fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I am not a block device expert, I am interested to know if
these fixes look ok, and if they fix the reported loopback deadlocks.

I added calls to deactive_page and flush_dcache_page, and made sure
that any error returns were propagated back to the caller.

This is UNTESTED but it looks ok to me [a blkdev newbie...]

Comments appreciated.

	Jeff




Index: drivers/block/loop.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/block/loop.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 loop.c
--- drivers/block/loop.c	2000/11/10 02:10:21	1.1.1.8
+++ drivers/block/loop.c	2000/11/14 21:17:27
@@ -56,7 +56,8 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/major.h>
-
+#include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 
@@ -178,6 +179,7 @@
 	char *kaddr;
 	unsigned long index;
 	unsigned size, offset;
+	int ret;
 
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
@@ -188,14 +190,23 @@
 			size = len;
 
 		page = grab_cache_page(mapping, index);
-		if (!page)
+		if (!page) {
+			ret = -ENOMEM;
 			goto fail;
-		if (aops->prepare_write(file, page, offset, offset+size))
+		}
+                /* We have exclusive IO access to the page.. */
+                if (!PageLocked(page))
+                        PAGE_BUG(page);
+		ret = aops->prepare_write(file, page, offset, offset+size);
+		if (ret)
 			goto unlock;
 		kaddr = page_address(page);
-		if ((lo->transfer)(lo, WRITE, kaddr+offset, data, size, IV))
+		ret = (lo->transfer)(lo, WRITE, kaddr+offset, data, size, IV);
+		flush_dcache_page(page);
+		if (ret)
 			goto write_fail;
-		if (aops->commit_write(file, page, offset, offset+size))
+		ret = aops->commit_write(file, page, offset, offset+size);
+		if (ret)
 			goto unlock;
 		data += size;
 		len -= size;
@@ -203,6 +214,7 @@
 		index++;
 		pos += size;
 		UnlockPage(page);
+		deactivate_page(page);
 		page_cache_release(page);
 	}
 	return 0;
@@ -213,9 +225,10 @@
 	kunmap(page);
 unlock:
 	UnlockPage(page);
+	deactivate_page(page);
 	page_cache_release(page);
 fail:
-	return -1;
+	return ret;
 }
 
 struct lo_read_data {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
