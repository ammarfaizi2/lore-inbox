Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274873AbRIZIRm>; Wed, 26 Sep 2001 04:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274881AbRIZIRd>; Wed, 26 Sep 2001 04:17:33 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:54162 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S274873AbRIZIR1>; Wed, 26 Sep 2001 04:17:27 -0400
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
MIME-Version: 1.0
Subject: [patch] 2.4.10: hardcoded BUFFERED_BLOCKSIZE breaks S/390 with 4k hardsect_size
Cc: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>,
        "Horst Hummel" <Horst.Hummel@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        alan@LXORGUK.UKUU.ORG.UK
To: linux-kernel@vger.kernel.org
Message-ID: <OFEE36B3A6.F55AA278-ONC1256AD3.002CFF0E@de.ibm.com>
From: "Holger Smolinski" <HSmolinski@de.ibm.com>
Date: Wed, 26 Sep 2001 10:16:40 +0200
X-MIMETrack: Serialize by Router on D12ML014/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 26/09/2001 10:17:47
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
with S/390, which usually has 4k hardsect size, and a device driver which
is
unable to gather multiple bhs into one block, the 2.4.10 approach to
BUFFERED_BLOCKSIZE breaks blkdev_readpage, which is dividing
the requested page into bhs of BUFFERED_BLOCKSIZE each.

My understanding is, that the intention of BUFFERED_BLOCKSIZE is, to
divide any page in the page cache into bhs of an appropriate size to be
handled by the upper layer (e.g. FS), right. As a consquence it should be
dependent on the blocksize of the upper layer as represented by the
inode->i_sb->s_blocksize.

Please review the attached patch for incompatibilities to other
architectures
or contradictionary effects to the intended purpose of introducing
BUFFERED_BLOCKSIZE and consider to apply.

happy hacking,
     Holger

diff -ur linux-2.3/fs/block_dev.c linux-2.3.HSM/fs/block_dev.c
--- linux-2.3/fs/block_dev.c  Tue Sep 25 13:49:56 2001
+++ linux-2.3.HSM/fs/block_dev.c   Tue Sep 25 18:24:43 2001
@@ -27,9 +27,9 @@
     int err;

     err = -EIO;
-    if (iblock >= buffered_blk_size(inode->i_rdev) >>
(BUFFERED_BLOCKSIZE_BITS - BLOCK_SIZE_BITS))
+    if (iblock >=
buffered_blk_size(inode->i_rdev,BUFFERED_BLOCKSIZE(inode)) *
(BUFFERED_BLOCKSIZE(inode) >> BLOCK_SIZE_BITS))
          goto out;
-
+
     bh_result->b_blocknr = iblock;
     bh_result->b_state |= 1UL << BH_Mapped;
     err = 0;
@@ -42,11 +42,12 @@
 {
     int i, nr_blocks, retval, dev = inode->i_rdev;
     unsigned long * blocks = iobuf->blocks;
+    unsigned long buffered_blocksize = BUFFERED_BLOCKSIZE(inode);

-    if (blocksize != BUFFERED_BLOCKSIZE)
+    if (blocksize != buffered_blocksize)
          BUG();

-    nr_blocks = iobuf->length >> BUFFERED_BLOCKSIZE_BITS;
+    nr_blocks = iobuf->length / buffered_blocksize;
     /* build the blocklist */
     for (i = 0; i < nr_blocks; i++, blocknr++) {
          struct buffer_head bh;
@@ -75,10 +76,10 @@
          BUG();

     if (!page->buffers)
-         create_empty_buffers(page, inode->i_rdev, BUFFERED_BLOCKSIZE);
+         create_empty_buffers(page, inode->i_rdev,
BUFFERED_BLOCKSIZE(inode));
     head = page->buffers;

-    block = page->index << (PAGE_CACHE_SHIFT - BUFFERED_BLOCKSIZE_BITS);
+    block = (page->index << (PAGE_CACHE_SHIFT)) /
BUFFERED_BLOCKSIZE(inode);

     bh = head;
     i = 0;
@@ -132,19 +133,19 @@
     struct inode *inode = page->mapping->host;
     kdev_t dev = inode->i_rdev;
     unsigned long iblock, lblock;
-    struct buffer_head *bh, *head, *arr[1 << (PAGE_CACHE_SHIFT -
BUFFERED_BLOCKSIZE_BITS)];
+    struct buffer_head *bh, *head, *arr[(1 << PAGE_CACHE_SHIFT ) /
BUFFERED_BLOCKSIZE(inode)];
     unsigned int blocks;
     int nr, i;

     if (!PageLocked(page))
          PAGE_BUG(page);
     if (!page->buffers)
-         create_empty_buffers(page, dev, BUFFERED_BLOCKSIZE);
+         create_empty_buffers(page, dev, BUFFERED_BLOCKSIZE(inode));
     head = page->buffers;

-    blocks = PAGE_CACHE_SIZE >> BUFFERED_BLOCKSIZE_BITS;
-    iblock = page->index << (PAGE_CACHE_SHIFT - BUFFERED_BLOCKSIZE_BITS);
-    lblock = buffered_blk_size(dev) >> (BUFFERED_BLOCKSIZE_BITS -
BLOCK_SIZE_BITS);
+    blocks = PAGE_CACHE_SIZE / BUFFERED_BLOCKSIZE(inode);
+    iblock = (page->index << PAGE_CACHE_SHIFT) /
BUFFERED_BLOCKSIZE(inode);
+    lblock = buffered_blk_size(dev,BUFFERED_BLOCKSIZE(inode)) /
(BUFFERED_BLOCKSIZE(inode) >> BLOCK_SIZE_BITS);
     bh = head;
     nr = 0;
     i = 0;
@@ -159,7 +160,7 @@
                         continue;
               }
               if (!buffer_mapped(bh)) {
-                   memset(kmap(page) + i * BUFFERED_BLOCKSIZE, 0,
BUFFERED_BLOCKSIZE);
+                   memset(kmap(page) + i * BUFFERED_BLOCKSIZE(inode), 0,
BUFFERED_BLOCKSIZE(inode));
                    flush_dcache_page(page);
                    kunmap(page);
                    set_bit(BH_Uptodate, &bh->b_state);
@@ -209,16 +210,16 @@
     kmap(page);

     if (!page->buffers)
-         create_empty_buffers(page, dev, BUFFERED_BLOCKSIZE);
+         create_empty_buffers(page, dev, BUFFERED_BLOCKSIZE(inode));
     head = page->buffers;

-    block = page->index << (PAGE_CACHE_SHIFT - BUFFERED_BLOCKSIZE_BITS);
+    block = (page->index << PAGE_CACHE_SHIFT) / BUFFERED_BLOCKSIZE(inode);

     for(bh = head, block_start = 0; bh != head || !block_start;
         block++, block_start=block_end, bh = bh->b_this_page) {
          if (!bh)
               BUG();
-         block_end = block_start + BUFFERED_BLOCKSIZE;
+         block_end = block_start + BUFFERED_BLOCKSIZE(inode);
          if (block_end <= from)
               continue;
          if (block_start >= to)
@@ -273,7 +274,7 @@
     for(bh = head = page->buffers, block_start = 0;
         bh != head || !block_start;
         block_start=block_end, bh = bh->b_this_page) {
-         block_end = block_start + BUFFERED_BLOCKSIZE;
+         block_end = block_start + BUFFERED_BLOCKSIZE(inode);
          if (block_end <= from || block_start >= to) {
               if (!buffer_uptodate(bh))
                    partial = 1;
@@ -378,7 +379,7 @@
     root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
     root->i_uid = root->i_gid = 0;
     root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
-    sb->s_blocksize = 1024;
-    sb->s_blocksize_bits = 10;
+    sb->s_blocksize = PAGE_SIZE;
+    sb->s_blocksize_bits = PAGE_SHIFT;
     sb->s_magic = 0x62646576;
     sb->s_op = &sops;
diff -ur linux-2.3/include/linux/blkdev.h
linux-2.3.HSM/include/linux/blkdev.h
--- linux-2.3/include/linux/blkdev.h     Tue Sep 25 13:49:56 2001
+++ linux-2.3.HSM/include/linux/blkdev.h      Tue Sep 25 18:08:24 2001
@@ -203,14 +203,14 @@
 #define blk_finished_io(nsects)   do { } while (0)
 #define blk_started_io(nsects)    do { } while (0)

-static inline int buffered_blk_size(kdev_t dev)
+static inline int buffered_blk_size(kdev_t dev, int buffered_size)
 {
     int ret = INT_MAX;
     int major = MAJOR(dev);
-
+    int rval = (buffered_size >> BLOCK_SIZE_BITS) - 1;
     if (blk_size[major])
-         ret = blk_size[major][MINOR(dev)] + ((BUFFERED_BLOCKSIZE-1) >>
BLOCK_SIZE_BITS);
-
+         ret = (blk_size[major][MINOR(dev)] + rval) & ~rval;
+
     return ret;
 }

diff -ur linux-2.3/include/linux/fs.h linux-2.3.HSM/include/linux/fs.h
--- linux-2.3/include/linux/fs.h   Tue Sep 25 13:49:56 2001
+++ linux-2.3.HSM/include/linux/fs.h     Tue Sep 25 18:00:38 2001
@@ -47,8 +47,7 @@
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)

 /* buffer header fixed size for the blkdev I/O through pagecache */
-#define BUFFERED_BLOCKSIZE_BITS 10
-#define BUFFERED_BLOCKSIZE (1 << BUFFERED_BLOCKSIZE_BITS)
+#define BUFFERED_BLOCKSIZE(inode) (inode->i_sb->s_blocksize)

 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
diff -ur linux-2.3/mm/filemap.c linux-2.3.HSM/mm/filemap.c
--- linux-2.3/mm/filemap.c    Tue Sep 25 13:49:56 2001
+++ linux-2.3.HSM/mm/filemap.c     Tue Sep 25 18:27:30 2001
@@ -963,7 +963,7 @@
     if (!S_ISBLK(inode->i_mode))
          end_index = inode->i_size >> PAGE_CACHE_SHIFT;
     else
-         end_index = buffered_blk_size(inode->i_rdev) >> (PAGE_CACHE_SHIFT
- BLOCK_SIZE_BITS);
+         end_index =
buffered_blk_size(inode->i_rdev,BUFFERED_BLOCKSIZE(inode)) >>
(PAGE_CACHE_SHIFT - BLOCK_SIZE_BITS);

     return end_index;
 }
@@ -975,7 +975,7 @@
     if (!S_ISBLK(inode->i_mode))
          rsize = inode->i_size;
     else
-         rsize = (loff_t) buffered_blk_size(inode->i_rdev) <<
BLOCK_SIZE_BITS;
+         rsize = (loff_t)
buffered_blk_size(inode->i_rdev,BUFFERED_BLOCKSIZE(inode)) <<
BLOCK_SIZE_BITS;

     return rsize;
 }
@@ -1339,11 +1339,11 @@

     if (!S_ISBLK(inode->i_mode)) {
          blocksize = inode->i_sb->s_blocksize;
-         blocksize_bits = inode->i_sb->s_blocksize_bits;
     } else {
-         blocksize = BUFFERED_BLOCKSIZE;
-         blocksize_bits = BUFFERED_BLOCKSIZE_BITS;
+         kdev_t kdev = inode->i_rdev;
+         blocksize = blksize_size[MAJOR(kdev)][MINOR(kdev)];
     }
+    for (blocksize_bits = BLOCK_SIZE_BITS; blocksize >>
(blocksize_bits+1); blocksize_bits ++);
     blocksize_mask = blocksize - 1;
     chunk_size = KIO_MAX_ATOMIC_IO << 10;




