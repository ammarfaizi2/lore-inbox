Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWBXH6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWBXH6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWBXH6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:58:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:38808 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750882AbWBXH6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:58:15 -0500
Date: Fri, 24 Feb 2006 08:58:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Show decompression status
Message-ID: <Pine.LNX.4.61.0602240855560.16630@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



I wrote this patch for a few-bogomips box (read: 3.09) to see some 
progress. It's actually a nice thing for faster ones too, anyone 
interested?


diff --fast -Ndpru linux-2.6.16-rc1-git3-SUSE20060124/arch/i386/boot/compressed/misc.c linux-2.6-AS24/arch/i386/boot/compressed/misc.c
--- linux-2.6.16-rc1-git3-SUSE20060124/arch/i386/boot/compressed/misc.c	2006-01-26 17:36:50.000000000 +0100
+++ linux-2.6-AS24/arch/i386/boot/compressed/misc.c	2006-01-28 19:02:37.670985000 +0100
@@ -374,7 +374,7 @@ asmlinkage int decompress_kernel(struct 
 
 	makecrc();
 	putstr("Uncompressing Linux... ");
-	gunzip();
+	gunzip(putstr);
 	putstr("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
diff --fast -Ndpru linux-2.6.16-rc1-git3-SUSE20060124/init/do_mounts_rd.c linux-2.6-AS24/init/do_mounts_rd.c
--- linux-2.6.16-rc1-git3-SUSE20060124/init/do_mounts_rd.c	2006-01-26 17:37:10.000000000 +0100
+++ linux-2.6-AS24/init/do_mounts_rd.c	2006-01-28 19:02:37.670985000 +0100
@@ -393,6 +393,11 @@ static void __init error(char *x)
 	unzip_error = 1;
 }
 
+static inline void putstr(const char *s) {
+    printk("%s", s);
+    return;
+}
+
 static int __init crd_load(int in_fd, int out_fd)
 {
 	int result;
@@ -418,7 +423,7 @@ static int __init crd_load(int in_fd, in
 		return -1;
 	}
 	makecrc();
-	result = gunzip();
+	result = gunzip(putstr);
 	if (unzip_error)
 		result = 1;
 	kfree(inbuf);
diff --fast -Ndpru linux-2.6.16-rc1-git3-SUSE20060124/init/initramfs.c linux-2.6-AS24/init/initramfs.c
--- linux-2.6.16-rc1-git3-SUSE20060124/init/initramfs.c	2006-01-26 17:37:24.000000000 +0100
+++ linux-2.6-AS24/init/initramfs.c	2006-01-28 19:02:37.670985000 +0100
@@ -413,6 +413,11 @@ static void __init flush_window(void)
 	outcnt = 0;
 }
 
+static inline void putstr(const char *s) {
+    printk("%s", s);
+    return;
+}
+
 static char * __init unpack_to_rootfs(char *buf, unsigned len, int check_only)
 {
 	int written;
@@ -449,7 +454,7 @@ static char * __init unpack_to_rootfs(ch
 		bytes_out = 0;
 		crc = (ulg)0xffffffffL; /* shift register contents */
 		makecrc();
-		gunzip();
+		gunzip(putstr);
 		if (state != Reset)
 			error("junk in gzipped archive");
 		this_header = saved_offset + inptr;
diff --fast -Ndpru linux-2.6.16-rc1-git3-SUSE20060124/lib/inflate.c linux-2.6-AS24/lib/inflate.c
--- linux-2.6.16-rc1-git3-SUSE20060124/lib/inflate.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-AS24/lib/inflate.c	2006-01-28 19:02:37.670985000 +0100
@@ -151,7 +151,7 @@ STATIC int INIT inflate_stored OF((void)
 STATIC int INIT inflate_fixed OF((void));
 STATIC int INIT inflate_dynamic OF((void));
 STATIC int INIT inflate_block OF((int *));
-STATIC int INIT inflate OF((void));
+STATIC int INIT inflate OF((void (*)(const char *)));
 
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
@@ -983,7 +983,7 @@ STATIC int INIT inflate_block(
 
 
 
-STATIC int INIT inflate(void)
+STATIC int INIT inflate(void (*putstr)(const char *))
 /* decompress an inflated entry */
 {
   int e;                /* last block flag */
@@ -1000,6 +1000,7 @@ STATIC int INIT inflate(void)
   /* decompress until the last block */
   h = 0;
   do {
+    if(putstr != NULL) putstr("*");
     hufts = 0;
     gzip_mark(&ptr);
     if ((r = inflate_block(&e)) != 0) {
@@ -1093,7 +1094,7 @@ makecrc(void)
 /*
  * Do the uncompression!
  */
-static int INIT gunzip(void)
+static int INIT gunzip(void (*putstr)(const char *))
 {
     uch flags;
     unsigned char magic[2]; /* magic header */
@@ -1157,7 +1158,7 @@ static int INIT gunzip(void)
     }
 
     /* Decompress */
-    if ((res = inflate())) {
+    if ((res = inflate(putstr))) {
 	    switch (res) {
 	    case 0:
 		    break;
#<<eof>>

Jan Engelhardt
-- 
