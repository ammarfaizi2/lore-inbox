Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSHCSOJ>; Sat, 3 Aug 2002 14:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317660AbSHCSNF>; Sat, 3 Aug 2002 14:13:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10512 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317643AbSHCSMz>; Sat, 3 Aug 2002 14:12:55 -0400
To: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 9: 2.5.29-rdunzip
Message-Id: <E17b3Rq-0006wd-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch ensures that we report failures when unzipping ramdisks and the
like, including if we fail to write to the ramdisk.

Unfortunately, there is no way to guarantee that the gunzip function will
ever terminate (gzip itself uses a setjmp and longjmp to achieve this).

 init/do_mounts.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions, 3 deletions

diff -urN orig/init/do_mounts.c linux/init/do_mounts.c
--- orig/init/do_mounts.c	Sat Jul 27 13:55:25 2002
+++ linux/init/do_mounts.c	Sat Jul 27 14:13:56 2002
@@ -877,6 +877,7 @@
 static unsigned inptr;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt;  /* bytes in output buffer */
 static int exit_code;
+static int unzip_error;
 static long bytes_out;
 static int crd_infd, crd_outfd;
 
@@ -924,13 +925,17 @@
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
+ * Returning -1 does not guarantee that gunzip() will ever return.
  */
 static int __init fill_inbuf(void)
 {
 	if (exit_code) return -1;
 	
 	insize = read(crd_infd, inbuf, INBUFSIZ);
-	if (insize == 0) return -1;
+	if (insize == 0) {
+		error("RAMDISK: ran out of compressed data\n");
+		return -1;
+	}
 
 	inptr = 1;
 
@@ -944,10 +949,15 @@
 static void __init flush_window(void)
 {
     ulg c = crc;         /* temporary variable */
-    unsigned n;
+    unsigned n, written;
     uch *in, ch;
     
-    write(crd_outfd, window, outcnt);
+    written = write(crd_outfd, window, outcnt);
+    if (written != outcnt && unzip_error == 0) {
+	printk(KERN_ERR "RAMDISK: incomplete write (%d != %d) %d\n",
+	       written, outcnt, bytes_out);
+	unzip_error = 1;
+    }
     in = window;
     for (n = 0; n < outcnt; n++) {
 	    ch = *in++;
@@ -962,6 +972,7 @@
 {
 	printk(KERN_ERR "%s", x);
 	exit_code = 1;
+	unzip_error = 1;
 }
 
 static int __init crd_load(int in_fd, int out_fd)
@@ -990,6 +1001,8 @@
 	}
 	makecrc();
 	result = gunzip();
+	if (unzip_error)
+		result = 1;
 	kfree(inbuf);
 	kfree(window);
 	return result;

