Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQLFIeB>; Wed, 6 Dec 2000 03:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbQLFIdv>; Wed, 6 Dec 2000 03:33:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45463 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129593AbQLFIdj>;
	Wed, 6 Dec 2000 03:33:39 -0500
Date: Wed, 6 Dec 2000 03:03:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012060254280.14974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If get_block() fails in block_prepare_write() we should zero
the blocks we've allocated and mark them dirty. We don't (i.e. we leave
the random junk in file in that case). Fix: do it. Moreover, if
->prepare_write() fails generic_file_write() is not going to write the user's
data into that page. It's OK if we were in hole (we got zeroes in all
new blocks, so it's equivalent to doing nothing with that page), but it's
not OK if we extended the file (we would get the file silently extended
with zeroes we've never intended to write there or we would get blocks
allocated past the ->i_size - the former screws applications, the latter
makes fsck unhappy).  Fix: if the failed call extended the file call
vmtruncate() to clean the mess up.

	Please, apply.

diff -urN rc12-pre6/fs/buffer.c rc12-pre6-get_block/fs/buffer.c
--- rc12-pre6/fs/buffer.c	Tue Dec  5 02:03:14 2000
+++ rc12-pre6-get_block/fs/buffer.c	Tue Dec  5 14:56:20 2000
@@ -1710,6 +1710,15 @@
 	}
 	return 0;
 out:
+	bh = head;
+	do {
+		if (buffer_new(bh) && !buffer_uptodate(bh)) {
+			memset(bh->b_data, 0, bh->b_size);
+			set_bit(BH_Uptodate, &bh->b_state);
+			mark_buffer_dirty(bh);
+		}
+		bh = bh->b_this_page;
+	} while (bh != head);
 	return err;
 }
 
diff -urN rc12-pre6/mm/filemap.c rc12-pre6-get_block/mm/filemap.c
--- rc12-pre6/mm/filemap.c	Tue Dec  5 02:03:20 2000
+++ rc12-pre6-get_block/mm/filemap.c	Tue Dec  5 14:56:20 2000
@@ -2382,6 +2382,7 @@
 	unsigned long	written;
 	long		status;
 	int		err;
+	unsigned	bytes;
 
 	cached_page = NULL;
 
@@ -2426,7 +2427,7 @@
 	}
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long index, offset;
 		char *kaddr;
 
 		/*
@@ -2451,7 +2452,7 @@
 
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
-			goto unlock;
+			goto sync_failure;
 		kaddr = page_address(page);
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
@@ -2476,6 +2477,7 @@
 		if (status < 0)
 			break;
 	}
+done:
 	*ppos = pos;
 
 	if (cached_page)
@@ -2496,6 +2498,13 @@
 	ClearPageUptodate(page);
 	kunmap(page);
 	goto unlock;
+sync_failure:
+	UnlockPage(page);
+	deactivate_page(page);
+	page_cache_release(page);
+	if (pos + bytes > inode->i_size)
+		vmtruncate(inode, inode->i_size);
+	goto done;
 }
 
 void __init page_cache_init(unsigned long mempages)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
