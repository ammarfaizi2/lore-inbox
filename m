Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVJaVEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVJaVEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVJaVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:00:36 -0500
Received: from waste.org ([216.27.176.166]:8344 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932529AbVJaVAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:30 -0500
Date: Mon, 31 Oct 2005 14:54:46 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <6.196662837@selenic.com>
Message-Id: <7.196662837@selenic.com>
Subject: [PATCH 6/20] inflate: internalize CRC calculation, cleanup table calculation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: cleanup CRC calculation

Move CRC calculation into inflate code
Cleanup table calculation code

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 22:01:17.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 22:01:18.000000000 -0700
@@ -109,6 +109,10 @@
 
 #include <asm/types.h>
 
+static u32 crc_32_tab[256];
+static u32 crc;		/* dummy var until users get cleaned up */
+#define CRCPOLY_LE 0xedb88320
+
 /* Huffman code lookup table entry--this entry is four bytes for machines
    that have 16-bit pointers (e.g. PC's in the small or medium model).
    Valid extra bits are 0..13.  e == 15 is EOB (end of block), e == 16
@@ -128,7 +132,7 @@ struct huft {
 struct iostate {
 	u8 *window;
 	int opos, osize, bits;
-	u32 buf;
+	u32 buf, crc;
 };
 
 /* Function prototypes */
@@ -154,6 +158,12 @@ static int INIT inflate(struct iostate *
 
 static void flush_output(struct iostate *io)
 {
+	int i;
+
+	for (i = 0; i < io->opos; i++)
+		io->crc = crc_32_tab[(io->window[i] ^ (int)io->crc) & 0xff]
+			^ (io->crc >> 8);
+
 	outcnt = io->opos;
 	flush_window();
 	io->opos = 0;
@@ -906,47 +916,16 @@ static int INIT inflate(struct iostate *
  *
  **********************************************************************/
 
-static u32 crc_32_tab[256];
-static u32 crc;		/* initialized in makecrc() so it'll reside in bss */
-#define CRC_VALUE (crc ^ 0xffffffffUL)
-
-/*
- * Code to compute the CRC-32 table. Borrowed from
- * gzip-1.0.3/makecrc.c.
- * Not copyrighted 1990 Mark Adler
- */
-
 static void INIT makecrc(void)
 {
+	unsigned i, j;
+	u32 c = 1;
 
-	unsigned long c;	/* crc shift register */
-	unsigned long e;	/* polynomial exclusive-or pattern */
-	int i;			/* counter for all possible eight bit values */
-	int k;			/* byte being shifted into crc apparatus */
-
-	/* terms of polynomial defining this crc (except x^32): */
-	static const int p[] =
-	    { 0, 1, 2, 4, 5, 7, 8, 10, 11, 12, 16, 22, 23, 26 };
-
-	/* Make exclusive-or pattern from polynomial */
-	e = 0;
-	for (i = 0; i < sizeof(p) / sizeof(int); i++)
-		e |= 1L << (31 - p[i]);
-
-	crc_32_tab[0] = 0;
-
-	for (i = 1; i < 256; i++) {
-		c = 0;
-		for (k = i | 256; k != 1; k >>= 1) {
-			c = c & 1 ? (c >> 1) ^ e : c >> 1;
-			if (k & 1)
-				c ^= e;
-		}
-		crc_32_tab[i] = c;
+	for (i = 128; i; i >>= 1) {
+		c = (c >> 1) ^ ((c & 1) ? CRCPOLY_LE : 0);
+		for (j = 0; j < 256; j += 2 * i)
+			crc_32_tab[i + j] = c ^ crc_32_tab[j];
 	}
-
-	/* this is initialized here so this code could reside in ROM */
-	crc = 0xffffffffUL;	/* shift register contents */
 }
 
 /* gzip flag byte */
@@ -966,14 +945,15 @@ static int INIT gunzip(void)
 	u8 flags;
 	unsigned char magic[2];	/* magic header */
 	char method;
-	u32 orig_crc = 0;	/* original crc */
-	u32 orig_len = 0;	/* original uncompressed length */
+	u32 orig_crc;
+	u32 orig_len;
 	int res;
 	struct iostate io;
 
 	io.window = window;
 	io.osize = WSIZE;
 	io.opos = io.bits = io.buf = 0;
+	io.crc = 0xffffffffUL;
 
 	magic[0] = get_byte();
 	magic[1] = get_byte();
@@ -1051,8 +1031,7 @@ static int INIT gunzip(void)
 		return -1;
 	}
 
-	/* Get the crc and original length */
-	/* crc32  (see algorithm.doc)
+	/* Get the crc and original length
 	 * uncompressed input size modulo 2^32
 	 */
 	orig_crc = (u32)get_byte();
@@ -1066,7 +1045,7 @@ static int INIT gunzip(void)
 	orig_len |= (u32)get_byte() << 24;
 
 	/* Validate decompression */
-	if (orig_crc != CRC_VALUE) {
+	if (orig_crc != ~io.crc) {
 		error("crc error");
 		return -1;
 	}
