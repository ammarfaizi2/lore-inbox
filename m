Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTIVUCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTIVUCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:02:34 -0400
Received: from f16.mail.ru ([194.67.57.46]:7430 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S263118AbTIVUCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:02:14 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: gerg@snapgear.com
Cc: davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix memory leaks in binfmt_flat.c
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [193.124.225.253]
Date: Tue, 23 Sep 2003 00:01:50 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1A1WsY-000Gjr-00.adobriyan-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leaks in /fs/binfmt_flat.c::decompress_exec()

diff -urN a/fs/binfmt_flat.c b/fs/binfmt_flat.c
--- a/fs/binfmt_flat.c	2003-09-08 23:49:50.000000000 +0400
+++ b/fs/binfmt_flat.c	2003-09-22 22:48:52.000000000 +0400
@@ -179,7 +179,7 @@
 	unsigned char *buf;
 	z_stream strm;
 	loff_t fpos;
-	int ret;
+	int ret, retval;
 
 	DBG_FLT("decompress_exec(offset=%x,buf=%x,len=%x)\n",(int)offset, (int)dst, (int)len);
 
@@ -192,7 +192,8 @@
 	buf = kmalloc(LBUFSIZE, GFP_KERNEL);
 	if (buf == NULL) {
 		DBG_FLT("binfmt_flat: no memory for read buffer\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto out_free;
 	}
 
 	/* Read in first chunk of data and parse gzip header. */
@@ -203,28 +204,30 @@
 	strm.avail_in = ret;
 	strm.total_in = 0;
 
+	retval = -ENOEXEC;
+
 	/* Check minimum size -- gzip header */
 	if (ret < 10) {
 		DBG_FLT("binfmt_flat: file too small?\n");
-		return -ENOEXEC;
+		goto out_free_buf;
 	}
 
 	/* Check gzip magic number */
 	if ((buf[0] != 037) || ((buf[1] != 0213) && (buf[1] != 0236))) {
 		DBG_FLT("binfmt_flat: unknown compression magic?\n");
-		return -ENOEXEC;
+		goto out_free_buf;
 	}
 
 	/* Check gzip method */
 	if (buf[2] != 8) {
 		DBG_FLT("binfmt_flat: unknown compression method?\n");
-		return -ENOEXEC;
+		goto out_free_buf;
 	}
 	/* Check gzip flags */
 	if ((buf[3] & ENCRYPTED) || (buf[3] & CONTINUATION) ||
 	    (buf[3] & RESERVED)) {
 		DBG_FLT("binfmt_flat: unknown flags?\n");
-		return -ENOEXEC;
+		goto out_free_buf;
 	}
 
 	ret = 10;
@@ -232,7 +235,7 @@
 		ret += 2 + buf[10] + (buf[11] << 8);
 		if (unlikely(LBUFSIZE == ret)) {
 			DBG_FLT("binfmt_flat: buffer overflow (EXTRA)?\n");
-			return -ENOEXEC;
+			goto out_free_buf;
 		}
 	}
 	if (buf[3] & ORIG_NAME) {
@@ -240,7 +243,7 @@
 			;
 		if (unlikely(LBUFSIZE == ret)) {
 			DBG_FLT("binfmt_flat: buffer overflow (ORIG_NAME)?\n");
-			return -ENOEXEC;
+			goto out_free_buf;
 		}
 	}
 	if (buf[3] & COMMENT) {
@@ -248,7 +251,7 @@
 			;
 		if (unlikely(LBUFSIZE == ret)) {
 			DBG_FLT("binfmt_flat: buffer overflow (COMMENT)?\n");
-			return -ENOEXEC;
+			goto out_free_buf;
 		}
 	}
 
@@ -261,7 +264,7 @@
 
 	if (zlib_inflateInit2(&strm, -MAX_WBITS) != Z_OK) {
 		DBG_FLT("binfmt_flat: zlib init failed?\n");
-		return -ENOEXEC;
+		goto out_free_buf;
 	}
 
 	while ((ret = zlib_inflate(&strm, Z_NO_FLUSH)) == Z_OK) {
@@ -280,13 +283,17 @@
 	if (ret < 0) {
 		DBG_FLT("binfmt_flat: decompression failed (%d), %s\n",
 			ret, strm.msg);
-		return -ENOEXEC;
+		goto out_free_buf;
 	}
 
 	zlib_inflateEnd(&strm);
+	retval = 0;
+out_free_buf:
 	kfree(buf);
+out_free:
 	kfree(strm.workspace);
-	return 0;
+out:
+	return retval;
 }
 
 #endif /* CONFIG_BINFMT_ZFLAT */

