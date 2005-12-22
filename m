Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVLVSbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVLVSbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVLVS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:36 -0500
Received: from waste.org ([64.81.244.121]:6096 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030264AbVLVS15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:57 -0500
Date: Thu, 22 Dec 2005 12:26:31 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <4.150843412@selenic.com>
Message-Id: <5.150843412@selenic.com>
Subject: [PATCH 4/20] inflate: start moving globals into iostate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: move globals into a state structure

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 20:41:17.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 21:16:13.000000000 -0700
@@ -125,16 +125,23 @@ struct huft {
 	} v;
 };
 
+struct iostate {
+	u8 *window;
+	int opos, osize, bits;
+	u32 buf;
+};
+
 /* Function prototypes */
 static int INIT huft_build(unsigned *, unsigned, unsigned,
 			  const u16 *, const u16 *, struct huft **, int *);
 static int INIT huft_free(struct huft *);
-static int INIT inflate_codes(struct huft *, struct huft *, int, int);
-static int INIT inflate_stored(void);
-static int INIT inflate_fixed(void);
-static int INIT inflate_dynamic(void);
-static int INIT inflate_block(int *);
-static int INIT inflate(void);
+static int INIT inflate_codes(struct iostate *, struct huft *, struct huft *,
+			 int, int);
+static int INIT inflate_stored(struct iostate *);
+static int INIT inflate_fixed(struct iostate *);
+static int INIT inflate_dynamic(struct iostate *);
+static int INIT inflate_block(struct iostate *, int *);
+static int INIT inflate(struct iostate *);
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
    stream to find repeated byte strings.  This is implemented here as a
@@ -145,7 +152,36 @@ static int INIT inflate(void);
    "u8 *window;" and then malloc'ed in the latter case.  The definition
    must be in unzip.h, included above. */
 
-#define flush_output(w) (outcnt=(w),flush_window())
+static void flush_output(struct iostate *io)
+{
+	outcnt = io->opos;
+	flush_window();
+	io->opos = 0;
+}
+
+static inline void put_byte(struct iostate *io, u8 byte)
+{
+	io->window[io->opos++] = byte;
+	if (io->opos == io->osize)
+		flush_output(io);
+}
+
+static void copy_bytes(struct iostate *io, int len, int dist)
+{
+	int part, pos = io->opos - dist;
+
+	do {
+		pos &= io->osize - 1;
+		part = min(len, io->osize - max(pos, io->opos));
+		len -= part;
+
+		while (part--)
+			io->window[io->opos++] = io->window[pos++];
+
+		if (io->opos == io->osize)
+			flush_output(io);
+	} while (len);
+}
 
 /* Tables for deflate from PKZIP's appnote.txt. */
 
@@ -186,10 +222,10 @@ static const u16 cpdext[] = {
 /* Inlines for inflate() bit peeking and grabbing.
    The usage is:
 
-        x = readbits(&b, &k, j);
-	dumpbits(&b, &k, j);
+        x = readbits(io, j);
+	dumpbits(io, j);
 
-	x = pullbits(&b, &k, j);
+	x = pullbits(io, j);
 
    where readbits makes sure that b has at least j bits in it, and
    dumpbits removes the bits from b, while k tracks the number of bits
@@ -212,29 +248,32 @@ static const u16 cpdext[] = {
    the stream.
  */
 
-static u32 bb;			/* bit buffer */
-static unsigned bk;		/* bits in bit buffer */
-
-static inline u32 readbits(u32 *b, u32 *k, int n)
+static inline u32 readbits(struct iostate *io, int n)
 {
-	for( ; *k < n; *k += 8)
-		*b |= (u32)get_byte() << *k;
-	return *b & ((1 << n) - 1);
+	for( ; io->bits < n; io->bits += 8)
+		io->buf |= (u32)get_byte() << io->bits;
+	return io->buf & ((1 << n) - 1);
 }
 
-static inline void dumpbits(u32 *b, u32 *k, int n)
+static inline void dumpbits(struct iostate *io, int n)
 {
-	*b >>= n;
-	*k -= n;
+	io->buf >>= n;
+	io->bits -= n;
 }
 
-static inline u32 pullbits(u32 *b, u32 *k, int n)
+static inline u32 pullbits(struct iostate *io, int n)
 {
-	u32 r = readbits(b, k, n);
-	dumpbits(b, k, n);
+	u32 r = readbits(io, n);
+	dumpbits(io, n);
 	return r;
 }
 
+static inline void popbytes(struct iostate *io)
+{
+	inptr -= (io->bits >> 3);
+	io->bits &= 7;
+}
+
 /*
    Huffman code decoding is performed using a multi-level table lookup.
    The fastest way to decode is to simply build a lookup table whose
@@ -536,6 +575,7 @@ STATIC int INIT huft_free(struct huft *t
 
 /*
  * inflate_codes - decompress the codes in a deflated block
+ * @io: current i/o state
  * @tl: literal/length decoder tables
  * @td: distance decoder tables
  * @bl: number of bits decoded by tl
@@ -544,129 +584,75 @@ STATIC int INIT huft_free(struct huft *t
  * inflate (decompress) the codes in a deflated (compressed) block.
  * Return an error code or zero if it all goes ok.
  */
-static int inflate_codes(struct huft *tl, struct huft *td, int bl, int bd)
+static int INIT inflate_codes(struct iostate *io, struct huft *tl, struct huft *td,
+			 int bl, int bd)
 {
 	unsigned e;	/* table entry flag/number of extra bits */
-	unsigned n, d;		/* length and index for copy */
-	unsigned w;		/* current window position */
+	unsigned len, dist;
 	struct huft *t;		/* pointer to table entry */
-	u32 b;		/* bit buffer */
-	unsigned k;	/* number of bits in bit buffer */
-
-	/* make local copies of globals */
-	b = bb;			/* initialize bit buffer */
-	k = bk;
-	w = outcnt;			/* initialize window position */
 
 	/* inflate the coded data */
 	for (;;) {		/* do until end of block */
-		t = tl + readbits(&b, &k, bl);
+		t = tl + readbits(io, bl);
 		e = t->e;
 		while (e > 16) {
 			if (e == 99)
 				return 1;
-			dumpbits(&b, &k, t->b);
-			t = t->v.t + readbits(&b, &k, e - 16);
+			dumpbits(io, t->b);
+			t = t->v.t + readbits(io, e - 16);
 			e = t->e;
 		}
-		dumpbits(&b, &k, t->b);
+		dumpbits(io, t->b);
 		if (e == 16) {	/* then it's a literal */
-			window[w++] = (u8)t->v.n;
-			if (w == WSIZE) {
-				flush_output(w);
-				w = 0;
-			}
+			put_byte(io, t->v.n);
 		} else {	/* it's an EOB or a length */
 			/* exit if end of block */
 			if (e == 15)
 				break;
 
 			/* get length of block to copy */
-			n = t->v.n + pullbits(&b, &k, e);
+			len = t->v.n + pullbits(io, e);
 
 			/* decode distance of block to copy */
-			t = td + readbits(&b, &k, bd);
+			t = td + readbits(io, bd);
 			e = t->e;
 			while (e > 16) {
 				if (e == 99)
 					return 1;
-				dumpbits(&b, &k, t->b);
-				t = t->v.t + readbits(&b, &k, e - 16);
+				dumpbits(io, t->b);
+				t = t->v.t + readbits(io, e - 16);
 				e = t->e;
 			}
-			dumpbits(&b, &k, t->b);
+			dumpbits(io, t->b);
 
-			d = w - t->v.n - pullbits(&b, &k, e);
-
-			/* do the copy */
-			do {
-				n -= (e = (e = WSIZE - ((d &= WSIZE - 1) > w ?
-							d : w)) > n ? n : e);
-#if !defined(NOMEMCPY) && !defined(DEBUG)
-				/* (this test assumes unsigned comparison) */
-				if (w - d >= e) {
-					memcpy(window + w, window + d, e);
-					w += e;
-					d += e;
-				} else
-#endif				/* !NOMEMCPY */
-					/* avoid memcpy() overlap */
-					do {
-						window[w++] = window[d++];
-					} while (--e);
-				if (w == WSIZE) {
-					flush_output(w);
-					w = 0;
-				}
-			} while (n);
+			dist = t->v.n + pullbits(io, e);
+			copy_bytes(io, len, dist);
 		}
 	}
 
-	/* restore the globals from the locals */
-	outcnt = w;			/* restore global window pointer */
-	bb = b;			/* restore global bit buffer */
-	bk = k;
-
-	/* done */
 	return 0;
 }
 
-/* inflate_stored - "decompress" an inflated type 0 (stored) block. */
-static int INIT inflate_stored(void)
+/* inflate_stored - "decompress" an inflated type 0 (stored) block.
+ * @io: current i/o state
+ */
+static int INIT inflate_stored(struct iostate *io)
 {
 	unsigned n;		/* number of bytes in block */
-	unsigned w;		/* current window position */
-	u32 b;		/* bit buffer */
-	unsigned k;	/* number of bits in bit buffer */
 
 	DEBG("<stor");
 
-	/* make local copies of globals */
-	b = bb;			/* initialize bit buffer */
-	k = bk;
-	w = outcnt;			/* initialize window position */
-
 	/* go to byte boundary */
-	dumpbits(&b, &k, k & 7);
+	dumpbits(io, io->bits & 7);
 
 	/* get the length and its complement */
-	n = pullbits(&b, &k, 16);
-	if (n != (~pullbits(&b, &k, 16) & 0xffff))
+	n = pullbits(io, 16);
+	if (n != (~pullbits(io, 16) & 0xffff))
 		return 1;	/* error in compressed data */
 
 	/* read and output the compressed data */
-	while (n--) {
-		window[w++] = (u8)get_byte();
-		if (w == WSIZE) {
-			flush_output(w);
-			w = 0;
-		}
-	}
-
-	/* restore the globals from the locals */
-	outcnt = w;			/* restore global window pointer */
-	bb = b;			/* restore global bit buffer */
-	bk = k;
+	while (n--)
+		put_byte(io, get_byte());
 
 	DEBG(">");
 	return 0;
@@ -674,6 +660,7 @@ static int INIT inflate_stored(void)
 
 
 /* inflate_fixed - decompress a block with fixed Huffman codes
+ * @io: current i/o state
  *
  * decompress an inflated type 1 (fixed Huffman codes) block. We
  * should either replace this with a custom decoder, or at least
@@ -681,7 +668,7 @@ static int INIT inflate_stored(void)
  *
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
-static int noinline INIT inflate_fixed(void)
+static int noinline INIT inflate_fixed(struct iostate *io)
 {
 	int i;			/* temporary variable */
 	struct huft *tl;	/* literal/length code table */
@@ -717,7 +704,7 @@ static int noinline INIT inflate_fixed(v
 	}
 
 	/* decompress until an end-of-block code */
-	if (inflate_codes(tl, td, bl, bd))
+	if (inflate_codes(io, tl, td, bl, bd))
 		return 1;
 
 	/* free the decoding tables, return */
@@ -731,7 +718,7 @@ static int noinline INIT inflate_fixed(v
  *
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
-static int noinline INIT inflate_dynamic(void)
+static int noinline INIT inflate_dynamic(struct iostate *io)
 {
 	int i;			/* temporary variables */
 	unsigned j;
@@ -745,19 +732,13 @@ static int noinline INIT inflate_dynamic
 	unsigned nl;		/* number of literal/length codes */
 	unsigned nd;		/* number of distance codes */
 	unsigned ll[286 + 30];	/* literal/length and distance code lengths */
-	u32 b;		/* bit buffer */
-	unsigned k;	/* number of bits in bit buffer */
 
 	DEBG("<dyn");
 
-	/* make local bit buffer */
-	b = bb;
-	k = bk;
-
 	/* read in table lengths */
-	nl = 257 + pullbits(&b, &k, 5); /* number of literal/length codes */
-	nd = 1 + pullbits(&b, &k, 5); /* number of distance codes */
-	nb = 4 + pullbits(&b, &k, 4); /* number of bit length codes */
+	nl = 257 + pullbits(io, 5); /* number of literal/length codes */
+	nd = 1 + pullbits(io, 5); /* number of distance codes */
+	nb = 4 + pullbits(io, 4); /* number of bit length codes */
 	if (nl > 286 || nd > 30)
 		return 1;	/* bad lengths */
 
@@ -765,7 +746,7 @@ static int noinline INIT inflate_dynamic
 
 	/* read in bit-length-code lengths */
 	for (j = 0; j < nb; j++)
-		ll[border[j]] = pullbits(&b, &k, 3);
+		ll[border[j]] = pullbits(io, 3);
 	for (; j < 19; j++)
 		ll[border[j]] = 0;
 
@@ -785,26 +766,26 @@ static int noinline INIT inflate_dynamic
 	n = nl + nd;
 	i = l = 0;
 	while ((unsigned)i < n) {
-		td = tl + readbits(&b, &k, bl);
-		dumpbits(&b, &k, td->b);
+		td = tl + readbits(io, bl);
+		dumpbits(io, td->b);
 		j = td->v.n;
 		if (j < 16)	/* length of code in bits (0..15) */
 			ll[i++] = l = j;	/* save last length in l */
 		else if (j == 16) {	/* repeat last length 3 to 6 times */
-			j = 3 + pullbits(&b, &k, 2);
+			j = 3 + pullbits(io, 2);
 			if ((unsigned)i + j > n)
 				return 1;
 			while (j--)
 				ll[i++] = l;
 		} else if (j == 17) {	/* 3 to 10 zero length codes */
-			j = 3 + pullbits(&b, &k, 3);
+			j = 3 + pullbits(io, 3);
 			if ((unsigned)i + j > n)
 				return 1;
 			while (j--)
 				ll[i++] = 0;
 			l = 0;
 		} else {	/* j == 18: 11 to 138 zero length codes */
-			j = 11 + pullbits(&b, &k, 7);
+			j = 11 + pullbits(io, 7);
 			if ((unsigned)i + j > n)
 				return 1;
 			while (j--)
@@ -820,10 +801,6 @@ static int noinline INIT inflate_dynamic
 
 	DEBG("dyn5 ");
 
-	/* restore the global bit buffer */
-	bb = b;
-	bk = k;
-
 	DEBG("dyn5a ");
 
 	/* build the decoding tables for literal/length and distance codes */
@@ -851,7 +828,7 @@ static int noinline INIT inflate_dynamic
 	DEBG("dyn6 ");
 
 	/* decompress until an end-of-block code */
-	if (inflate_codes(tl, td, bl, bd))
+	if (inflate_codes(io, tl, td, bl, bd))
 		return 1;
 
 	DEBG("dyn7 ");
@@ -865,24 +842,25 @@ static int noinline INIT inflate_dynamic
 }
 
 /* inflate_block - decompress a deflated block
+ * @io: current i/o state
  * @e: last block flag
  */
-static int INIT inflate_block(int *e)
+static int INIT inflate_block(struct iostate *io, int *e)
 {
 	unsigned t;		/* block type */
 
 	DEBG("<blk");
 
-	*e = pullbits(&bb, &bk, 1); /* read in last block bit */
-	t = pullbits(&bb, &bk, 2); /* read in block type */
+	*e = pullbits(io, 1); /* read in last block bit */
+	t = pullbits(io, 2); /* read in block type */
 
 	/* inflate that block type */
 	if (t == 2)
-		return inflate_dynamic();
+		return inflate_dynamic(io);
 	if (t == 0)
-		return inflate_stored();
+		return inflate_stored(io);
 	if (t == 1)
-		return inflate_fixed();
+		return inflate_fixed(io);
 
 	DEBG(">");
 
@@ -890,40 +868,27 @@ static int INIT inflate_block(int *e)
 	return 2;
 }
 
-/* inflate - decompress an inflated entry */
-static int INIT inflate(void)
+/* inflate - decompress an inflated entry
+ * @io: current i/o state
+ */
+static int INIT inflate(struct iostate *io)
 {
 	int e;			/* last block flag */
 	int r;			/* result code */
 	void *ptr;
 
-	/* initialize window, bit buffer */
-	outcnt = 0;
-	bk = 0;
-	bb = 0;
-
 	/* decompress until the last block */
 	do {
 		gzip_mark(&ptr);
-		if ((r = inflate_block(&e))) {
+		if ((r = inflate_block(io, &e))) {
 			gzip_release(&ptr);
 			return r;
 		}
 		gzip_release(&ptr);
 	} while (!e);
 
-	/* Undo too much lookahead. The next read will be byte aligned so we
-	 * can discard unused bits in the last meaningful byte.
-	 */
-	while (bk >= 8) {
-		bk -= 8;
-		inptr--;
-	}
-
-	/* flush out window */
-	flush_output(outcnt);
-
-	/* return success */
+	popbytes(io);
+	flush_output(io);
 	return 0;
 }
 
@@ -996,6 +961,11 @@ static int INIT gunzip(void)
 	u32 orig_crc = 0;	/* original crc */
 	u32 orig_len = 0;	/* original uncompressed length */
 	int res;
+	struct iostate io;
+
+	io.window = window;
+	io.osize = WSIZE;
+	io.opos = io.bits = io.buf = 0;
 
 	magic[0] = get_byte();
 	magic[1] = get_byte();
@@ -1051,7 +1021,7 @@ static int INIT gunzip(void)
 			;
 
 	/* Decompress */
-	if ((res = inflate())) {
+	if ((res = inflate(&io))) {
 		switch (res) {
 		case 0:
 			break;
