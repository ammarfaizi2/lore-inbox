Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSFJMeY>; Mon, 10 Jun 2002 08:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSFJMeX>; Mon, 10 Jun 2002 08:34:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9735 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313113AbSFJMeW>;
	Mon, 10 Jun 2002 08:34:22 -0400
Message-ID: <3D048F0C.6060904@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:35:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 6/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060008030809030006050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008030809030006050809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix compilation warnings in cfbimgblt.c.

- Fix improper __FUNCTION__ usage in smb_debug.h.

It's all about giving the compiler a chance to coalesce
equal string constants - a good reason for the
C language standard to depricate the old semantics.

--------------060008030809030006050809
Content-Type: text/plain;
 name="warn-2.5.21-6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-6.diff"

diff -urN linux-2.5.21/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.21/drivers/video/cfbimgblt.c	2002-06-09 07:26:29.000000000 +0200
+++ linux/drivers/video/cfbimgblt.c	2002-06-09 19:39:17.000000000 +0200
@@ -43,12 +43,14 @@
 
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
-	int pad, ppw, shift, shift_right, shift_left, x2, y2, n, i, j, k, l = 7;
+	int pad, ppw;
+	int x2, y2, n, i, j, k, l = 7;
 	unsigned long tmp = ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
 	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;	
-	unsigned long end_index, end_mask;
+	unsigned long end_mask;
 	unsigned long *dst = NULL;
-	u8 *dst1, *src;
+	u8 *dst1;
+	u8 *src;
 
 	/* 
 	 * We could use hardware clipping but on many cards you get around hardware
@@ -97,8 +99,8 @@
 			for (j = image->width/ppw; j > 0; j--) {
 				end_mask = 0;
 		
-				for (k = ppw; k > 0; k--) {	
-					if (test_bit(l, src))
+				for (k = ppw; k > 0; k--) {
+					if (test_bit(l, (unsigned long *) src))
 						end_mask |= (tmp >> (p->var.bits_per_pixel*(k-1)));
 					l--;
 					if (l < 0) { l = 7; src++; }
@@ -110,7 +112,7 @@
 			if (n) {
 				end_mask = 0;	
 				for (j = n; j > 0; j--) {
-					if (test_bit(l, src))
+					if (test_bit(l, (unsigned long *) src))
 						end_mask |= (tmp >> (p->var.bits_per_pixel*(j-1)));
 					l--;
 					if (l < 0) { l = 7; src++; }
diff -urN linux-2.5.21/fs/smbfs/smb_debug.h linux/fs/smbfs/smb_debug.h
--- linux-2.5.21/fs/smbfs/smb_debug.h	2002-06-09 07:27:26.000000000 +0200
+++ linux/fs/smbfs/smb_debug.h	2002-06-09 19:12:14.000000000 +0200
@@ -7,20 +7,20 @@
 	(dentry)->d_parent->d_name.name,(dentry)->d_name.name
 
 /*
- * safety checks that should never happen ??? 
+ * safety checks that should never happen ???
  * these are normally enabled.
  */
 #ifdef SMBFS_PARANOIA
-#define PARANOIA(x...) printk(KERN_NOTICE __FUNCTION__ ": " x)
+# define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__, ## a)
 #else
-#define PARANOIA(x...) do { ; } while(0)
+# define PARANOIA(f, a...) do { ; } while(0)
 #endif
 
 /* lots of debug messages */
 #ifdef SMBFS_DEBUG_VERBOSE
-#define VERBOSE(x...) printk(KERN_DEBUG __FUNCTION__ ": " x)
+# define VERBOSE(f, a...) printk(KERN_DEBUG "%s: " f, __FUNCTION__, ## a)
 #else
-#define VERBOSE(x...) do { ; } while(0)
+# define VERBOSE(f, a...) do { ; } while(0)
 #endif
 
 /*

--------------060008030809030006050809--

