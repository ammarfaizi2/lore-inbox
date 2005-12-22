Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVLVSbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVLVSbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVLVS2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:39 -0500
Received: from waste.org ([64.81.244.121]:5072 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030260AbVLVS1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:54 -0500
Date: Thu, 22 Dec 2005 12:26:28 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <3.150843412@selenic.com>
Message-Id: <4.150843412@selenic.com>
Subject: [PATCH 3/20] inflate: clean up input logic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: cleanup input logic

Transform ugly macros to inlines
Kill mask_bits table
Eliminate magic underrun handling (dealt with by getbyte())

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/lib/inflate.c
===================================================================
--- tiny.orig/lib/inflate.c	2005-09-28 18:21:30.000000000 -0700
+++ tiny/lib/inflate.c	2005-09-28 18:22:39.000000000 -0700
@@ -183,24 +183,23 @@ static const u16 cpdext[] = {
 	12, 12, 13, 13
 };
 
-/* Macros for inflate() bit peeking and grabbing.
+/* Inlines for inflate() bit peeking and grabbing.
    The usage is:
 
-        NEEDBITS(j)
-        x = b & mask_bits[j];
-        DUMPBITS(j)
-
-   where NEEDBITS makes sure that b has at least j bits in it, and
-   DUMPBITS removes the bits from b. The macros use the variable k for
-   the number of bits in b. Normally, b and k are initialized at the
-   beginning of a routine that uses these macros from a global bit
-   buffer and count.
+        x = readbits(&b, &k, j);
+	dumpbits(&b, &k, j);
+
+	x = pullbits(&b, &k, j);
+
+   where readbits makes sure that b has at least j bits in it, and
+   dumpbits removes the bits from b, while k tracks the number of bits
+   in b.
 
    If we assume that EOB will be the longest code, then we will never
-   ask for bits with NEEDBITS that are beyond the end of the stream.
-   So, NEEDBITS should not read any more bytes than are needed to
-   meet the request.  Then no bytes need to be "returned" to the buffer
-   at the end of the last block.
+   ask for bits that are beyond the end of the stream. So, readbits
+   should not read any more bytes than are needed to meet the request.
+   Then no bytes need to be "returned" to the buffer at the end of the
+   last block.
 
    However, this assumption is not true for fixed blocks--the EOB code
    is 7 bits, but the other literal/length codes can be 8 or 9 bits.
@@ -216,15 +215,25 @@ static const u16 cpdext[] = {
 static u32 bb;			/* bit buffer */
 static unsigned bk;		/* bits in bit buffer */
 
-static const u16 mask_bits[] = {
-	0x0000,
-	0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
-	0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
-};
+static inline u32 readbits(u32 *b, u32 *k, int n)
+{
+	for( ; *k < n; *k += 8)
+		*b |= (u32)get_byte() << *k;
+	return *b & ((1 << n) - 1);
+}
 
-#define NEXTBYTE()  ({ int v = get_byte(); if (v < 0) goto underrun; (u8)v; })
-#define NEEDBITS(n) do {while(k<(n)){b|=((u32)NEXTBYTE())<<k;k+=8;}} while(0)
-#define DUMPBITS(n) do {b>>=(n);k-=(n);} while(0)
+static inline void dumpbits(u32 *b, u32 *k, int n)
+{
+	*b >>= n;
+	*k -= n;
+}
+
+static inline u32 pullbits(u32 *b, u32 *k, int n)
+{
+	u32 r = readbits(b, k, n);
+	dumpbits(b, k, n);
+	return r;
+}
 
 /*
    Huffman code decoding is performed using a multi-level table lookup.
@@ -541,7 +550,6 @@ static int inflate_codes(struct huft *tl
 	unsigned n, d;		/* length and index for copy */
 	unsigned w;		/* current window position */
 	struct huft *t;		/* pointer to table entry */
-	unsigned ml, md;	/* masks for bl and bd bits */
 	u32 b;		/* bit buffer */
 	unsigned k;	/* number of bits in bit buffer */
 
@@ -551,20 +559,17 @@ static int inflate_codes(struct huft *tl
 	w = outcnt;			/* initialize window position */
 
 	/* inflate the coded data */
-	ml = mask_bits[bl];	/* precompute masks for speed */
-	md = mask_bits[bd];
 	for (;;) {		/* do until end of block */
-		NEEDBITS((unsigned)bl);
-		if ((e = (t = tl + ((unsigned)b & ml))->e) > 16)
-			do {
-				if (e == 99)
-					return 1;
-				DUMPBITS(t->b);
-				e -= 16;
-				NEEDBITS(e);
-			} while ((e = (t = t->v.t + ((unsigned)b &
-						     mask_bits[e]))->e) > 16);
-		DUMPBITS(t->b);
+		t = tl + readbits(&b, &k, bl);
+		e = t->e;
+		while (e > 16) {
+			if (e == 99)
+				return 1;
+			dumpbits(&b, &k, t->b);
+			t = t->v.t + readbits(&b, &k, e - 16);
+			e = t->e;
+		}
+		dumpbits(&b, &k, t->b);
 		if (e == 16) {	/* then it's a literal */
 			window[w++] = (u8)t->v.n;
 			if (w == WSIZE) {
@@ -577,25 +582,21 @@ static int inflate_codes(struct huft *tl
 				break;
 
 			/* get length of block to copy */
-			NEEDBITS(e);
-			n = t->v.n + ((unsigned)b & mask_bits[e]);
-			DUMPBITS(e);
+			n = t->v.n + pullbits(&b, &k, e);
 
 			/* decode distance of block to copy */
-			NEEDBITS((unsigned)bd);
-			if ((e = (t = td + ((unsigned)b & md))->e) > 16)
-				do {
-					if (e == 99)
-						return 1;
-					DUMPBITS(t->b);
-					e -= 16;
-					NEEDBITS(e);
-				} while ((e = (t = t->v.t + ((unsigned)b
-					   & mask_bits[e]))->e) > 16);
-			DUMPBITS(t->b);
-			NEEDBITS(e);
-			d = w - t->v.n - ((unsigned)b & mask_bits[e]);
-			DUMPBITS(e)
+			t = td + readbits(&b, &k, bd);
+			e = t->e;
+			while (e > 16) {
+				if (e == 99)
+					return 1;
+				dumpbits(&b, &k, t->b);
+				t = t->v.t + readbits(&b, &k, e - 16);
+				e = t->e;
+			}
+			dumpbits(&b, &k, t->b);
+
+			d = w - t->v.n - pullbits(&b, &k, e);
 
 			/* do the copy */
 			do {
@@ -628,9 +629,6 @@ static int inflate_codes(struct huft *tl
 
 	/* done */
 	return 0;
-
-      underrun:
-	return 4;		/* Input underrun */
 }
 
 /* inflate_stored - "decompress" an inflated type 0 (stored) block. */
@@ -649,27 +647,20 @@ static int INIT inflate_stored(void)
 	w = outcnt;			/* initialize window position */
 
 	/* go to byte boundary */
-	n = k & 7;
-	DUMPBITS(n);
+	dumpbits(&b, &k, k & 7);
 
 	/* get the length and its complement */
-	NEEDBITS(16);
-	n = ((unsigned)b & 0xffff);
-	DUMPBITS(16);
-	NEEDBITS(16);
-	if (n != (unsigned)((~b) & 0xffff))
+	n = pullbits(&b, &k, 16);
+	if (n != (~pullbits(&b, &k, 16) & 0xffff))
 		return 1;	/* error in compressed data */
-	DUMPBITS(16);
 
 	/* read and output the compressed data */
 	while (n--) {
-		NEEDBITS(8);
-		window[w++] = (u8)b;
+		window[w++] = (u8)get_byte();
 		if (w == WSIZE) {
 			flush_output(w);
 			w = 0;
 		}
-		DUMPBITS(8);
 	}
 
 	/* restore the globals from the locals */
@@ -679,9 +670,6 @@ static int INIT inflate_stored(void)
 
 	DEBG(">");
 	return 0;
-
-      underrun:
-	return 4;		/* Input underrun */
 }
 
 
@@ -748,7 +736,6 @@ static int noinline INIT inflate_dynamic
 	int i;			/* temporary variables */
 	unsigned j;
 	unsigned l;		/* last length */
-	unsigned m;		/* mask for bit lengths table */
 	unsigned n;		/* number of lengths to get */
 	struct huft *tl;	/* literal/length code table */
 	struct huft *td;	/* distance code table */
@@ -768,26 +755,17 @@ static int noinline INIT inflate_dynamic
 	k = bk;
 
 	/* read in table lengths */
-	NEEDBITS(5);
-	nl = 257 + ((unsigned)b & 0x1f); /* number of literal/length codes */
-	DUMPBITS(5);
-	NEEDBITS(5);
-	nd = 1 + ((unsigned)b & 0x1f);	/* number of distance codes */
-	DUMPBITS(5);
-	NEEDBITS(4);
-	nb = 4 + ((unsigned)b & 0xf);	/* number of bit length codes */
-	DUMPBITS(4);
+	nl = 257 + pullbits(&b, &k, 5); /* number of literal/length codes */
+	nd = 1 + pullbits(&b, &k, 5); /* number of distance codes */
+	nb = 4 + pullbits(&b, &k, 4); /* number of bit length codes */
 	if (nl > 286 || nd > 30)
 		return 1;	/* bad lengths */
 
 	DEBG("dyn1 ");
 
 	/* read in bit-length-code lengths */
-	for (j = 0; j < nb; j++) {
-		NEEDBITS(3);
-		ll[border[j]] = (unsigned)b & 7;
-		DUMPBITS(3);
-	}
+	for (j = 0; j < nb; j++)
+		ll[border[j]] = pullbits(&b, &k, 3);
 	for (; j < 19; j++)
 		ll[border[j]] = 0;
 
@@ -805,36 +783,28 @@ static int noinline INIT inflate_dynamic
 
 	/* read in literal and distance code lengths */
 	n = nl + nd;
-	m = mask_bits[bl];
 	i = l = 0;
 	while ((unsigned)i < n) {
-		NEEDBITS((unsigned)bl);
-		j = (td = tl + ((unsigned)b & m))->b;
-		DUMPBITS(j);
+		td = tl + readbits(&b, &k, bl);
+		dumpbits(&b, &k, td->b);
 		j = td->v.n;
 		if (j < 16)	/* length of code in bits (0..15) */
 			ll[i++] = l = j;	/* save last length in l */
 		else if (j == 16) {	/* repeat last length 3 to 6 times */
-			NEEDBITS(2);
-			j = 3 + ((unsigned)b & 3);
-			DUMPBITS(2);
-			    if ((unsigned)i + j > n)
+			j = 3 + pullbits(&b, &k, 2);
+			if ((unsigned)i + j > n)
 				return 1;
 			while (j--)
 				ll[i++] = l;
 		} else if (j == 17) {	/* 3 to 10 zero length codes */
-			NEEDBITS(3);
-			j = 3 + ((unsigned)b & 7);
-			DUMPBITS(3);
+			j = 3 + pullbits(&b, &k, 3);
 			if ((unsigned)i + j > n)
 				return 1;
 			while (j--)
 				ll[i++] = 0;
 			l = 0;
 		} else {	/* j == 18: 11 to 138 zero length codes */
-			NEEDBITS(7);
-			j = 11 + ((unsigned)b & 0x7f);
-			DUMPBITS(7);
+			j = 11 + pullbits(&b, &k, 7);
 			if ((unsigned)i + j > n)
 				return 1;
 			while (j--)
@@ -892,9 +862,6 @@ static int noinline INIT inflate_dynamic
 
 	DEBG(">");
 	return 0;
-
-      underrun:
-	return 4;		/* Input underrun */
 }
 
 /* inflate_block - decompress a deflated block
@@ -903,28 +870,11 @@ static int noinline INIT inflate_dynamic
 static int INIT inflate_block(int *e)
 {
 	unsigned t;		/* block type */
-	u32 b;		/* bit buffer */
-	unsigned k;	/* number of bits in bit buffer */
 
 	DEBG("<blk");
 
-	/* make local bit buffer */
-	b = bb;
-	k = bk;
-
-	/* read in last block bit */
-	NEEDBITS(1);
-	*e = (int)b & 1;
-	DUMPBITS(1);
-
-	/* read in block type */
-	NEEDBITS(2);
-	t = (unsigned)b & 3;
-	DUMPBITS(2);
-
-	/* restore the global bit buffer */
-	bb = b;
-	bk = k;
+	*e = pullbits(&bb, &bk, 1); /* read in last block bit */
+	t = pullbits(&bb, &bk, 2); /* read in block type */
 
 	/* inflate that block type */
 	if (t == 2)
@@ -938,9 +888,6 @@ static int INIT inflate_block(int *e)
 
 	/* bad block type */
 	return 2;
-
-      underrun:
-	return 4;		/* Input underrun */
 }
 
 /* inflate - decompress an inflated entry */
@@ -1050,9 +997,9 @@ static int INIT gunzip(void)
 	u32 orig_len = 0;	/* original uncompressed length */
 	int res;
 
-	magic[0] = NEXTBYTE();
-	magic[1] = NEXTBYTE();
-	method = NEXTBYTE();
+	magic[0] = get_byte();
+	magic[1] = get_byte();
+	method = get_byte();
 
 	if (magic[0] != 037 || ((magic[1] != 0213) && (magic[1] != 0236))) {
 		error("bad gzip magic numbers");
@@ -1078,29 +1025,29 @@ static int INIT gunzip(void)
 		error("Input has invalid flags");
 		return -1;
 	}
-	NEXTBYTE();		/* Get timestamp */
-	NEXTBYTE();
-	NEXTBYTE();
-	NEXTBYTE();
+	get_byte();		/* Get timestamp */
+	get_byte();
+	get_byte();
+	get_byte();
 
-	(void)NEXTBYTE();	/* Ignore extra flags for the moment */
-	(void)NEXTBYTE();	/* Ignore OS type for the moment */
+	get_byte();	/* Ignore extra flags for the moment */
+	get_byte();	/* Ignore OS type for the moment */
 
 	if (flags & EXTRA_FIELD) {
-		unsigned len = (unsigned)NEXTBYTE();
-		len |= ((unsigned)NEXTBYTE()) << 8;
+		unsigned len = (unsigned)get_byte();
+		len |= ((unsigned)get_byte()) << 8;
 		while (len--)
-			(void)NEXTBYTE();
+			get_byte();
 	}
 
 	/* Discard original file name if it was truncated */
 	if (flags & ORIG_NAME)
-		while (NEXTBYTE())
+		while (get_byte())
 			;
 
 	/* Discard file comment if any */
 	if (flags & COMMENT)
-		while (NEXTBYTE())
+		while (get_byte())
 			;
 
 	/* Decompress */
@@ -1130,15 +1077,15 @@ static int INIT gunzip(void)
 	/* crc32  (see algorithm.doc)
 	 * uncompressed input size modulo 2^32
 	 */
-	orig_crc = (u32)NEXTBYTE();
-	orig_crc |= (u32)NEXTBYTE() << 8;
-	orig_crc |= (u32)NEXTBYTE() << 16;
-	orig_crc |= (u32)NEXTBYTE() << 24;
-
-	orig_len = (u32)NEXTBYTE();
-	orig_len |= (u32)NEXTBYTE() << 8;
-	orig_len |= (u32)NEXTBYTE() << 16;
-	orig_len |= (u32)NEXTBYTE() << 24;
+	orig_crc = (u32)get_byte();
+	orig_crc |= (u32)get_byte() << 8;
+	orig_crc |= (u32)get_byte() << 16;
+	orig_crc |= (u32)get_byte() << 24;
+
+	orig_len = (u32)get_byte();
+	orig_len |= (u32)get_byte() << 8;
+	orig_len |= (u32)get_byte() << 16;
+	orig_len |= (u32)get_byte() << 24;
 
 	/* Validate decompression */
 	if (orig_crc != CRC_VALUE) {
@@ -1150,8 +1097,4 @@ static int INIT gunzip(void)
 		return -1;
 	}
 	return 0;
-
-      underrun:		/* NEXTBYTE() goto's here if needed */
-	error("out of input data");
-	return -1;
 }
