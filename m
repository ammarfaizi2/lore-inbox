Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSD2R30>; Mon, 29 Apr 2002 13:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313635AbSD2R3Z>; Mon, 29 Apr 2002 13:29:25 -0400
Received: from imladris.infradead.org ([194.205.184.45]:5640 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313477AbSD2R3X>; Mon, 29 Apr 2002 13:29:23 -0400
Date: Mon, 29 Apr 2002 18:29:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sb_set_blocksize/sb_min_blocksize
Message-ID: <20020429182913.A22344@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two have been in 2.5 for ages and also in the VxFS compat header.
Make the global so other filesystems can used them aswell.  ACKed by Al.

diff -uNr -Xdontdiff linux-2.4.19-pre7/fs/block_dev.c linux/fs/block_dev.c
--- linux-2.4.19-pre7/fs/block_dev.c	Tue Apr 16 20:50:07 2002
+++ linux/fs/block_dev.c	Mon Apr 29 16:35:04 2002
@@ -102,6 +102,26 @@
 	return 0;
 }
 
+int sb_set_blocksize(struct super_block *sb, int size)
+{
+	int bits;
+	if (set_blocksize(sb->s_dev, size) < 0)
+		return 0;
+	sb->s_blocksize = size;
+	for (bits = 9, size >>= 9; size >>= 1; bits++)
+		;
+	sb->s_blocksize_bits = bits;
+	return sb->s_blocksize;
+}
+
+int sb_min_blocksize(struct super_block *sb, int size)
+{
+	int minsize = get_hardsect_size(sb->s_dev);
+	if (size < minsize)
+		size = minsize;
+	return sb_set_blocksize(sb, size);
+}
+
 static int blkdev_get_block(struct inode * inode, long iblock, struct buffer_head * bh, int create)
 {
 	if (iblock >= max_block(inode->i_rdev))
diff -uNr -Xdontdiff linux-2.4.19-pre7/fs/freevxfs/vxfs_kcompat.h linux/fs/freevxfs/vxfs_kcompat.h
--- linux-2.4.19-pre7/fs/freevxfs/vxfs_kcompat.h	Tue Apr 16 20:48:11 2002
+++ linux/fs/freevxfs/vxfs_kcompat.h	Mon Apr 29 16:33:07 2002
@@ -17,27 +17,5 @@
 	bh->b_blocknr = block;
 }
 
-/* From fs/block_dev.c (Linux 2.5.2-pre2)  */
-static inline int sb_set_blocksize(struct super_block *sb, int size)
-{
-	int bits;
-	if (set_blocksize(sb->s_dev, size) < 0)
-		return 0;
-	sb->s_blocksize = size;
-	for (bits = 9, size >>= 9; size >>= 1; bits++)
-		;
-	sb->s_blocksize_bits = bits;
-	return sb->s_blocksize;
-}
-
-/* Dito.  */
-static inline int sb_min_blocksize(struct super_block *sb, int size)
-{
-	int minsize = get_hardsect_size(sb->s_dev);
-	if (size < minsize)
-		size = minsize;
-	return sb_set_blocksize(sb, size);
-}
-
 #endif /* Kernel 2.4 */
 #endif /* _VXFS_KCOMPAT_H */
diff -uNr -Xdontdiff linux-2.4.19-pre7/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.19-pre7/include/linux/fs.h	Tue Apr 16 20:48:18 2002
+++ linux/include/linux/fs.h	Mon Apr 29 16:32:42 2002
@@ -1375,6 +1375,8 @@
 		__bforget(buf);
 }
 extern int set_blocksize(kdev_t, int);
+extern int sb_set_blocksize(struct super_block *, int);
+extern int sb_min_blocksize(struct super_block *, int);
 extern struct buffer_head * bread(kdev_t, int, int);
 static inline struct buffer_head * sb_bread(struct super_block *sb, int block)
 {
diff -uNr -Xdontdiff linux-2.4.19-pre7/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.19-pre7/kernel/ksyms.c	Tue Apr 16 20:46:39 2002
+++ linux/kernel/ksyms.c	Mon Apr 29 16:35:30 2002
@@ -188,6 +188,8 @@
 EXPORT_SYMBOL(write_inode_now);
 EXPORT_SYMBOL(notify_change);
 EXPORT_SYMBOL(set_blocksize);
+EXPORT_SYMBOL(sb_set_blocksize);
+EXPORT_SYMBOL(sb_min_blocksize);
 EXPORT_SYMBOL(getblk);
 EXPORT_SYMBOL(cdget);
 EXPORT_SYMBOL(cdput);
