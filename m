Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131647AbQKJVh5>; Fri, 10 Nov 2000 16:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131926AbQKJVhr>; Fri, 10 Nov 2000 16:37:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14840 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131647AbQKJVhb>;
	Fri, 10 Nov 2000 16:37:31 -0500
Date: Fri, 10 Nov 2000 16:37:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] more kmap fixes
Message-ID: <Pine.GSO.4.21.0011101635590.17943-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Couple of places missed in Jeff's patch:

diff -urN rc11-2/fs/ncpfs/mmap.c rc11-2-kmap/fs/ncpfs/mmap.c
--- rc11-2/fs/ncpfs/mmap.c	Sun Aug  6 13:43:18 2000
+++ rc11-2-kmap/fs/ncpfs/mmap.c	Fri Nov 10 16:31:01 2000
@@ -37,7 +37,7 @@
 	struct dentry *dentry = file->f_dentry;
 	struct inode *inode = dentry->d_inode;
 	struct page* page;
-	unsigned long pg_addr;
+	char *pg_addr;
 	unsigned int already_read;
 	unsigned int count;
 	int bufsize;
@@ -71,7 +71,7 @@
 			if (ncp_read_kernel(NCP_SERVER(inode),
 				     NCP_FINFO(inode)->file_handle,
 				     pos, to_read,
-				     (char *) (pg_addr + already_read),
+				     pg_addr + already_read,
 				     &read_this_time) != 0) {
 				read_this_time = 0;
 			}
@@ -87,8 +87,7 @@
 	}
 
 	if (already_read < PAGE_SIZE)
-		memset((char*)(pg_addr + already_read), 0, 
-		       PAGE_SIZE - already_read);
+		memset(pg_addr + already_read, 0, PAGE_SIZE - already_read);
 	flush_dcache_page(page);
 	kunmap(page);
 	return page;
diff -urN rc11-2/fs/udf/inode.c rc11-2-kmap/fs/udf/inode.c
--- rc11-2/fs/udf/inode.c	Tue Sep  5 16:07:30 2000
+++ rc11-2-kmap/fs/udf/inode.c	Fri Nov 10 16:32:09 2000
@@ -158,7 +158,6 @@
 {
 	struct buffer_head *bh = NULL;
 	struct page *page;
-	unsigned long kaddr = 0;
 	int block;
 
 	/* from now on we have normal address_space methods */
@@ -183,10 +182,10 @@
 		PAGE_BUG(page);
 	if (!Page_Uptodate(page))
 	{
-		kaddr = kmap(page);
-		memset((char *)kaddr + UDF_I_LENALLOC(inode), 0x00,
+		char *kaddr = kmap(page);
+		memset(kaddr + UDF_I_LENALLOC(inode), 0x00,
 			PAGE_CACHE_SIZE - UDF_I_LENALLOC(inode));
-		memcpy((char *)kaddr, bh->b_data + udf_file_entry_alloc_offset(inode),
+		memcpy(kaddr, bh->b_data + udf_file_entry_alloc_offset(inode),
 			UDF_I_LENALLOC(inode));
 		flush_dcache_page(page);
 		SetPageUptodate(page);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
