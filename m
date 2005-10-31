Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVJaVHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVJaVHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVJaVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:07:04 -0500
Received: from waste.org ([216.27.176.166]:1944 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932511AbVJaVAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:16 -0500
Date: Mon, 31 Oct 2005 14:54:53 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <20.196662837@selenic.com>
Message-Id: <21.196662837@selenic.com>
Subject: [PATCH 20/20] inflate: make in-core inflate share common CRC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: make in-core inflate share common CRC code

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 22:04:32.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 22:04:35.000000000 -0700
@@ -144,23 +144,46 @@ static void free(void *where)
 		malloc_ptr = free_mem_ptr;
 }
 
-static u8 INITDATA window[0x8000]; /* use a statically allocated window */
+static u8 window[0x8000]; /* use a statically allocated window */
+
+/* simple CRC calculation */
+static u32 crc_32_tab[256];
+#define CRCPOLY_LE 0xedb88320
+
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
@@ -205,12 +228,7 @@ static int INIT inflate(struct iostate *
 
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
@@ -906,24 +924,6 @@ static int INIT inflate(struct iostate *
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
