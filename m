Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292249AbSBOWgl>; Fri, 15 Feb 2002 17:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292235AbSBOWfX>; Fri, 15 Feb 2002 17:35:23 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5508 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292240AbSBOWeH>;
	Fri, 15 Feb 2002 17:34:07 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202152232.g1FMWZ809574@eng2.beaverton.ibm.com>
Subject: [PATCH] kiobuf size reduction for 2.4.17
To: linux-kernel@vger.kernel.org, sct@redhat.com, andrea@suse.de
Date: Fri, 15 Feb 2002 14:32:35 -0800 (PST)
Cc: gerrit@us.ibm.com (Gerrit Huizenga), hjt@us.ibm.com (Hans-J Tannenberger),
        pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my first attempt to reduce the size of the kiobuf.(2.4.17)
Idea is really simple.

1) Replace 

	struct buffer_head * bh[KIO_MAX_SECTORS];

   with

	 struct buffer_head * bh;

   And chain them in alloc_kiovec(). This will save 4K (almost).
   I am using b_next_free to chain them. Is it safe ? My testing
   proved so. Please let me know.

2) Replace

	unsigned long blocks[KIO_MAX_SECTORS];

   with

	unsigned long *blocks;

   RAW IO code does not need a block list. (since they are all sequential).
   No need to allocate block list for RAW IO. This will save 4K for RAW.


This should save 8K for RAW usage and 4K for other usages.
I can make a patch for 2.4.18preX, once I get some feedback.

NOTE:

We don't really need to allocate 1024 buffer heads if you are using
my mostly PAGE_SIZE_IO patch or for doing O_DIRECT on a filesystem.
All we need is 129 (KIO_STATIC_PAGES) buffer heads - since we use 
a buffer head per page. I have patch to reduce the number of buffer 
heads also, but I didn't want to include it here to make things simple.


Thanks,
Badari


diff -Naur -X dontdiff linux.2417org/drivers/char/raw.c linux.2417.badari/drivers/char/raw.c
--- linux.2417org/drivers/char/raw.c	Sat Sep 22 20:35:43 2001
+++ linux.2417.badari/drivers/char/raw.c	Fri Feb 15 17:43:28 2002
@@ -86,7 +86,7 @@
 	}
 	
 	if (!filp->f_iobuf) {
-		err = alloc_kiovec(1, &filp->f_iobuf);
+		err = alloc_kiovec_bhs(1, KIO_MAX_SECTORS, &filp->f_iobuf);
 		if (err)
 			return err;
 	}
@@ -297,7 +297,7 @@
 		 * A parallel read/write is using the preallocated iobuf
 		 * so just run slow and allocate a new one.
 		 */
-		err = alloc_kiovec(1, &iobuf);
+		err = alloc_kiovec_bhs(1, KIO_MAX_SECTORS, &iobuf);
 		if (err)
 			goto out;
 		new_iobuf = 1;
@@ -348,10 +348,9 @@
 		if (err)
 			break;
 
-		for (i=0; i < blocks; i++) 
-			iobuf->blocks[i] = blocknr++;
-		
-		err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks, sector_size);
+		iobuf->blkno = blocknr;
+
+		err = brw_kiovec(rw, 1, &iobuf, dev, NULL, sector_size);
 
 		if (rw == READ && err > 0)
 			mark_dirty_kiobuf(iobuf, err);
@@ -360,6 +359,7 @@
 			transferred += err;
 			size -= err;
 			buf += err;
+			blocknr += (err/sector_size);
 		}
 
 		unmap_kiobuf(iobuf);
diff -Naur -X dontdiff linux.2417org/fs/buffer.c linux.2417.badari/fs/buffer.c
--- linux.2417org/fs/buffer.c	Fri Feb 15 17:41:34 2002
+++ linux.2417.badari/fs/buffer.c	Fri Feb 15 17:48:15 2002
@@ -2061,29 +2061,25 @@
  * for them to complete.  Clean up the buffer_heads afterwards.  
  */
 
-static int wait_kio(int rw, int nr, struct buffer_head *bh[], int size)
+static int wait_kio(int rw, int nr, struct buffer_head *bh, int size)
 {
 	int iosize, err;
 	int i;
-	struct buffer_head *tmp;
+	struct buffer_head *tmp = bh;
 
 	iosize = 0;
 	err = 0;
 
 	for (i = nr; --i >= 0; ) {
-		iosize += size;
-		tmp = bh[i];
 		if (buffer_locked(tmp)) {
 			wait_on_buffer(tmp);
 		}
 		
 		if (!buffer_uptodate(tmp)) {
-			/* We are traversing bh'es in reverse order so
-                           clearing iosize on error calculates the
-                           amount of IO before the first error. */
-			iosize = 0;
 			err = -EIO;
 		}
+		if (!err) iosize += size; 
+		tmp = tmp->b_next_free;
 	}
 	
 	if (iosize)
@@ -2117,7 +2113,7 @@
 	unsigned long	blocknr;
 	struct kiobuf *	iobuf = NULL;
 	struct page *	map;
-	struct buffer_head *tmp, **bhs = NULL;
+	struct buffer_head *tmp, *bhs = NULL;
 
 	if (!nr)
 		return 0;
@@ -2143,6 +2139,7 @@
 		offset = iobuf->offset;
 		length = iobuf->length;
 		iobuf->errno = 0;
+		blocknr = iobuf->blkno;
 		if (!bhs)
 			bhs = iobuf->bh;
 		
@@ -2154,7 +2151,9 @@
 			}
 			
 			while (length > 0) {
-				blocknr = b[bufind++];
+				if (b) 
+					blocknr = b[bufind++];
+					
 				if (blocknr == -1UL) {
 					if (rw == READ) {
 						/* there was an hole in the filesystem */
@@ -2167,7 +2166,10 @@
 					} else
 						BUG();
 				}
-				tmp = bhs[bhind++];
+
+				tmp = bhs;
+				bhs = bhs->b_next_free;
+				bhind++;
 
 				tmp->b_size = size;
 				set_bh_page(tmp, map, offset);
@@ -2191,17 +2193,19 @@
 				 */
 				if (bhind >= KIO_MAX_SECTORS) {
 					kiobuf_wait_for_io(iobuf); /* wake-one */
-					err = wait_kio(rw, bhind, bhs, size);
+					err = wait_kio(rw, bhind, iobuf->bh, size);
 					if (err >= 0)
 						transferred += err;
 					else
 						goto finished;
 					bhind = 0;
+					bhs = iobuf->bh;
 				}
 
 			skip_block:
 				length -= size;
 				offset += size;
+				blocknr++;
 
 				if (offset >= PAGE_SIZE) {
 					offset = 0;
@@ -2214,7 +2218,7 @@
 	/* Is there any IO still left to submit? */
 	if (bhind) {
 		kiobuf_wait_for_io(iobuf); /* wake-one */
-		err = wait_kio(rw, bhind, bhs, size);
+		err = wait_kio(rw, bhind, iobuf->bh, size);
 		if (err >= 0)
 			transferred += err;
 		else
diff -Naur -X dontdiff linux.2417org/fs/iobuf.c linux.2417.badari/fs/iobuf.c
--- linux.2417org/fs/iobuf.c	Fri Apr 27 14:23:25 2001
+++ linux.2417.badari/fs/iobuf.c	Fri Feb 15 17:59:44 2002
@@ -30,29 +30,34 @@
 	iobuf->maplist   = iobuf->map_array;
 }
 
-int alloc_kiobuf_bhs(struct kiobuf * kiobuf)
+int alloc_kiobuf_bhs(struct kiobuf * kiobuf, int nr)
 {
 	int i;
+	struct buffer_head *bh;
 
-	for (i = 0; i < KIO_MAX_SECTORS; i++)
-		if (!(kiobuf->bh[i] = kmem_cache_alloc(bh_cachep, SLAB_KERNEL))) {
-			while (i--) {
-				kmem_cache_free(bh_cachep, kiobuf->bh[i]);
-				kiobuf->bh[i] = NULL;
-			}
+	for (i = 0; i < nr; i++) {
+		bh = kmem_cache_alloc(bh_cachep, SLAB_KERNEL);
+		if (!bh) {
+			free_kiobuf_bhs(kiobuf);
 			return -ENOMEM;
 		}
+		bh->b_next_free = kiobuf->bh;
+		kiobuf->bh = bh;
+	}
 	return 0;
 }
 
 void free_kiobuf_bhs(struct kiobuf * kiobuf)
 {
-	int i;
+	struct buffer_head *bh, *bh_next;
 
-	for (i = 0; i < KIO_MAX_SECTORS; i++) {
-		kmem_cache_free(bh_cachep, kiobuf->bh[i]);
-		kiobuf->bh[i] = NULL;
+	bh = kiobuf->bh;
+	while (bh) {
+		bh_next = bh->b_next_free;
+		kmem_cache_free(bh_cachep, bh);
+		bh = bh_next;
 	}
+	kiobuf->bh = NULL;
 }
 
 int alloc_kiovec(int nr, struct kiobuf **bufp)
@@ -61,13 +66,38 @@
 	struct kiobuf *iobuf;
 	
 	for (i = 0; i < nr; i++) {
+		iobuf = vmalloc(sizeof(struct kiobuf) +
+				 (KIO_MAX_SECTORS * sizeof(long)));
+		if (!iobuf) {
+			free_kiovec(i, bufp);
+			return -ENOMEM;
+		}
+		kiobuf_init(iobuf);
+		iobuf->blocks = iobuf + sizeof(struct kiobuf);
+ 		if (alloc_kiobuf_bhs(iobuf, KIO_MAX_SECTORS )) {
+			vfree(iobuf);
+ 			free_kiovec(i, bufp);
+ 			return -ENOMEM;
+ 		}
+		bufp[i] = iobuf;
+	}
+	
+	return 0;
+}
+
+int alloc_kiovec_bhs(int nr, int bhs, struct kiobuf **bufp)
+{
+	int i;
+	struct kiobuf *iobuf;
+	
+	for (i = 0; i < nr; i++) {
 		iobuf = vmalloc(sizeof(struct kiobuf));
 		if (!iobuf) {
 			free_kiovec(i, bufp);
 			return -ENOMEM;
 		}
 		kiobuf_init(iobuf);
- 		if (alloc_kiobuf_bhs(iobuf)) {
+ 		if (alloc_kiobuf_bhs(iobuf, bhs)) {
 			vfree(iobuf);
  			free_kiovec(i, bufp);
  			return -ENOMEM;
diff -Naur -X dontdiff linux.2417org/include/linux/fs.h linux.2417.badari/include/linux/fs.h
--- linux.2417org/include/linux/fs.h	Fri Feb 15 17:41:35 2002
+++ linux.2417.badari/include/linux/fs.h	Fri Feb 15 17:54:03 2002
@@ -1350,6 +1350,7 @@
 extern struct buffer_head * getblk(kdev_t, int, int);
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
 extern void submit_bh(int, struct buffer_head *);
+extern void submit_bh_blknr(int, struct buffer_head *);
 extern int is_read_only(kdev_t);
 extern void __brelse(struct buffer_head *);
 static inline void brelse(struct buffer_head *buf)
diff -Naur -X dontdiff linux.2417org/include/linux/iobuf.h linux.2417.badari/include/linux/iobuf.h
--- linux.2417org/include/linux/iobuf.h	Thu Nov 22 12:46:26 2001
+++ linux.2417.badari/include/linux/iobuf.h	Fri Feb 15 17:55:25 2002
@@ -36,6 +36,7 @@
 	int		array_len;	/* Space in the allocated lists */
 	int		offset;		/* Offset to start of valid data */
 	int		length;		/* Number of valid bytes of data */
+	int		blkno;		/* Block number for RAW IO */
 
 	/* Keep separate track of the physical addresses and page
 	 * structs involved.  If we do IO to a memory-mapped device
@@ -48,14 +49,15 @@
 	
 	/* Always embed enough struct pages for atomic IO */
 	struct page *	map_array[KIO_STATIC_PAGES];
-	struct buffer_head * bh[KIO_MAX_SECTORS];
-	unsigned long blocks[KIO_MAX_SECTORS];
+	struct buffer_head *bh;
 
 	/* Dynamic state for IO completion: */
 	atomic_t	io_count;	/* IOs still in progress */
 	int		errno;		/* Status of completed IO */
 	void		(*end_io) (struct kiobuf *); /* Completion callback */
 	wait_queue_head_t wait_queue;
+
+	unsigned long *blocks;
 };
 
 
@@ -72,10 +74,11 @@
 void	end_kio_request(struct kiobuf *, int);
 void	simple_wakeup_kiobuf(struct kiobuf *);
 int	alloc_kiovec(int nr, struct kiobuf **);
+int	alloc_kiovec_bhs(int nr, int bhs, struct kiobuf **);
 void	free_kiovec(int nr, struct kiobuf **);
 int	expand_kiobuf(struct kiobuf *, int);
 void	kiobuf_wait_for_io(struct kiobuf *);
-extern int alloc_kiobuf_bhs(struct kiobuf *);
+extern int alloc_kiobuf_bhs(struct kiobuf *, int);
 extern void free_kiobuf_bhs(struct kiobuf *);
 
 /* fs/buffer.c */
