Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVLVS3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVLVS3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVLVS2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:48 -0500
Received: from waste.org ([64.81.244.121]:27344 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030267AbVLVS2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:30 -0500
Date: Thu, 22 Dec 2005 12:27:13 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <20.150843412@selenic.com>
Message-Id: <21.150843412@selenic.com>
Subject: [PATCH 20/20] inflate: make in-core inflate share common CRC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: make in-core inflate share common CRC code

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-12-21 21:19:36.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-12-21 21:20:51.000000000 -0600
@@ -142,24 +142,46 @@ static void free(void *where)
 
 static u8 window[0x8000]; /* use a statically allocated window */
 
+/* simple CRC calculation */
+static u32 crc_32_tab[256];
+#define CRCPOLY_LE 0xedb88320
+
 #define INIT
 #define INITDATA const
 
+static void makecrc(void)
+{
+	unsigned i, j;
+	u32 c = 1;
+
+	for (i = 128; i; i >>= 1) {
+		c = (c >> 1) ^ ((c & 1) ? CRCPOLY_LE : 0);
+		for (j = 0; j < 256; j += 2 * i)
+			crc_32_tab[i + j] = c ^ crc_32_tab[j];
+	}
+}
+
+static u32 crc32_le(u32 crc, unsigned char const *p, size_t len)
+{
+	while (len--)
+		crc = crc_32_tab[(*p++ ^ crc) & 0xff] ^ (crc >> 8);
+
+	return crc;
+}
 #else
 
 #include <linux/module.h>
+#include <linux/crc32.h>
 
 static u8 *window; /* dynamically allocate */
 #define malloc(a) kmalloc(a, GFP_KERNEL)
 #define free(a) kfree(a)
+#define makecrc()
 #define INIT __init
 #define INITDATA __initdata
 
 #endif
 
-static u32 crc_32_tab[256];
-#define CRCPOLY_LE 0xedb88320
-
 /* Huffman code lookup table entry--this entry is four bytes for machines
    that have 16-bit pointers (e.g. PC's in the small or medium model).
    Valid extra bits are 0..13.  e == 15 is EOB (end of block), e == 16
@@ -204,12 +226,7 @@ static int INIT inflate(struct iostate *
 
 static void flush_output(struct iostate *io)
 {
-	int i;
-
-	for (i = 0; i < io->opos; i++)
-		io->crc = crc_32_tab[(io->window[i] ^ (int)io->crc) & 0xff]
-			^ (io->crc >> 8);
-
+	io->crc = crc32_le(io->crc, io->window, io->opos);
 	io->flush(io->window, io->opos);
 	io->ototal += io->opos;
 	io->opos = 0;
@@ -905,24 +922,6 @@ static int INIT inflate(struct iostate *
 	return 0;
 }
 
-/**********************************************************************
- *
- * The following are support routines for inflate.c
- *
- **********************************************************************/
-
-static void INIT makecrc(void)
-{
-	unsigned i, j;
-	u32 c = 1;
-
-	for (i = 128; i; i >>= 1) {
-		c = (c >> 1) ^ ((c & 1) ? CRCPOLY_LE : 0);
-		for (j = 0; j < 256; j += 2 * i)
-			crc_32_tab[i + j] = c ^ crc_32_tab[j];
-	}
-}
-
 /* gzip flag byte */
 #define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
 #define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
