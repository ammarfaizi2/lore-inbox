Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTE3Oig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTE3Oig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:38:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:44007 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263723AbTE3Oi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:38:29 -0400
Date: Fri, 30 May 2003 16:51:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: matsunaga <matsunaga_kazuhisa@yahoo.co.jp>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH RFC] 2/2 convert jffs2, cramfs, zisofs to central workspace
Message-ID: <20030530145139.GA15609@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See 1/2 for the description.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster

--- linux-2.4.20/fs/jffs2/compr_zlib.c~zlib_users	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/fs/jffs2/compr_zlib.c	2003-05-30 16:16:26.000000000 +0200
@@ -56,33 +56,13 @@
 	*/
 #define STREAM_END_SPACE 12
 
-static DECLARE_MUTEX(deflate_sem);
-static DECLARE_MUTEX(inflate_sem);
-static void *deflate_workspace;
-static void *inflate_workspace;
-
 int __init jffs2_zlib_init(void)
 {
-	deflate_workspace = vmalloc(zlib_deflate_workspacesize());
-	if (!deflate_workspace) {
-		printk(KERN_WARNING "Failed to allocate %d bytes for deflate workspace\n", zlib_deflate_workspacesize());
-		return -ENOMEM;
-	}
-	D1(printk(KERN_DEBUG "Allocated %d bytes for deflate workspace\n", zlib_deflate_workspacesize()));
-	inflate_workspace = vmalloc(zlib_inflate_workspacesize());
-	if (!inflate_workspace) {
-		printk(KERN_WARNING "Failed to allocate %d bytes for inflate workspace\n", zlib_inflate_workspacesize());
-		vfree(deflate_workspace);
-		return -ENOMEM;
-	}
-	D1(printk(KERN_DEBUG "Allocated %d bytes for inflate workspace\n", zlib_inflate_workspacesize()));
 	return 0;
 }
 
 void jffs2_zlib_exit(void)
 {
-	vfree(deflate_workspace);
-	vfree(inflate_workspace);
 }
 
 int zlib_compress(unsigned char *data_in, unsigned char *cpage_out, 
@@ -94,12 +74,10 @@
 	if (*dstlen <= STREAM_END_SPACE)
 		return -1;
 
-	down(&deflate_sem);
-	strm.workspace = deflate_workspace;
+	strm.workspace = NULL;
 
 	if (Z_OK != zlib_deflateInit(&strm, 3)) {
 		printk(KERN_WARNING "deflateInit failed\n");
-		up(&deflate_sem);
 		return -1;
 	}
 
@@ -120,7 +98,6 @@
 		if (ret != Z_OK) {
 			D1(printk(KERN_DEBUG "deflate in loop returned %d\n", ret));
 			zlib_deflateEnd(&strm);
-			up(&deflate_sem);
 			return -1;
 		}
 	}
@@ -128,7 +105,6 @@
 	strm.avail_in = 0;
 	ret = zlib_deflate(&strm, Z_FINISH);
 	zlib_deflateEnd(&strm);
-	up(&deflate_sem);
 	if (ret != Z_STREAM_END) {
 		D1(printk(KERN_DEBUG "final deflate returned %d\n", ret));
 		return -1;
@@ -151,12 +127,10 @@
 	z_stream strm;
 	int ret;
 
-	down(&inflate_sem);
-	strm.workspace = inflate_workspace;
+	strm.workspace = NULL;
 
 	if (Z_OK != zlib_inflateInit(&strm)) {
 		printk(KERN_WARNING "inflateInit failed\n");
-		up(&inflate_sem);
 		return;
 	}
 	strm.next_in = data_in;
@@ -173,5 +147,4 @@
 		printk(KERN_NOTICE "inflate returned %d\n", ret);
 	}
 	zlib_inflateEnd(&strm);
-	up(&inflate_sem);
 }
--- linux-2.4.20/fs/cramfs/uncompress.c~zlib_users	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/fs/cramfs/uncompress.c	2003-05-30 16:17:22.000000000 +0200
@@ -34,19 +34,21 @@
 	stream.next_out = dst;
 	stream.avail_out = dstlen;
 
-	err = zlib_inflateReset(&stream);
-	if (err != Z_OK) {
-		printk("zlib_inflateReset error %d\n", err);
-		zlib_inflateEnd(&stream);
-		zlib_inflateInit(&stream);
-	}
+	stream.workspace = NULL;
+	stream.next_in = NULL;
+	stream.avail_in = 0;
+	err = zlib_inflateInit(&stream);
+	if (err != Z_OK)
+		goto err;
 
 	err = zlib_inflate(&stream, Z_FINISH);
 	if (err != Z_STREAM_END)
 		goto err;
+	zlib_inflateEnd(&stream);
 	return stream.total_out;
 
 err:
+	zlib_inflateEnd(&stream);
 	printk("Error %d while decompressing!\n", err);
 	printk("%p(%d)->%p(%d)\n", src, srclen, dst, dstlen);
 	return 0;
@@ -54,24 +56,10 @@
 
 int cramfs_uncompress_init(void)
 {
-	if (!initialized++) {
-		stream.workspace = vmalloc(zlib_inflate_workspacesize());
-		if ( !stream.workspace ) {
-			initialized = 0;
-			return -ENOMEM;
-		}
-		stream.next_in = NULL;
-		stream.avail_in = 0;
-		zlib_inflateInit(&stream);
-	}
 	return 0;
 }
 
 int cramfs_uncompress_exit(void)
 {
-	if (!--initialized) {
-		zlib_inflateEnd(&stream);
-		vfree(stream.workspace);
-	}
 	return 0;
 }
--- linux-2.4.20/fs/isofs/compress.c~zlib_users	2003-05-27 16:51:45.000000000 +0200
+++ linux-2.4.20/fs/isofs/compress.c	2003-05-30 16:16:26.000000000 +0200
@@ -48,13 +48,6 @@
 static char zisofs_sink_page[PAGE_CACHE_SIZE];
 
 /*
- * This contains the zlib memory allocation and the mutex for the
- * allocation; this avoids failures at block-decompression time.
- */
-static void *zisofs_zlib_workspace;
-static struct semaphore zisofs_zlib_semaphore;
-
-/*
  * When decompressing, we typically obtain more than one page
  * per reference.  We inject the additional pages into the page
  * cache as a form of readahead.
@@ -206,8 +199,7 @@
 		stream.avail_in = min(bufsize-(cstart & bufmask), csize);
 		csize -= stream.avail_in;
 
-		stream.workspace = zisofs_zlib_workspace;
-		down(&zisofs_zlib_semaphore);
+		stream.workspace = NULL;
 		
 		zerr = zlib_inflateInit(&stream);
 		if ( zerr != Z_OK ) {
@@ -215,7 +207,7 @@
 				err = -ENOMEM;
 			printk(KERN_DEBUG "zisofs: zisofs_inflateInit returned %d\n",
 			       zerr);
-			goto z_eio;
+			goto b_eio;
 		}
 
 		while ( !bail && fpage < maxpage ) {
@@ -293,9 +285,6 @@
 		}
 		zlib_inflateEnd(&stream);
 
-	z_eio:
-		up(&zisofs_zlib_semaphore);
-
 	b_eio:
 		for ( i = 0 ; i < haveblocks ; i++ ) {
 			if ( bhs[i] )
@@ -339,11 +328,6 @@
 		return 0;
 	}
 
-	zisofs_zlib_workspace = vmalloc(zlib_inflate_workspacesize());
-	if ( !zisofs_zlib_workspace )
-		return -ENOMEM;
-	init_MUTEX(&zisofs_zlib_semaphore);
-
 	initialized = 1;
 	return 0;
 }
@@ -355,6 +339,5 @@
 		return;
 	}
 
-	vfree(zisofs_zlib_workspace);
 	initialized = 0;
 }
