Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVLVS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVLVS1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVLVS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:27:52 -0500
Received: from waste.org ([64.81.244.121]:464 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030256AbVLVS1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:49 -0500
Date: Thu, 22 Dec 2005 12:26:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <2.150843412@selenic.com>
Message-Id: <3.150843412@selenic.com>
Subject: [PATCH 2/20] inflate: kill legacy bits
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: kill legacy bits

Kill RCSID
Kill old includes and defines
Kill screwy types
Kill unused memory usage tracking
Kill 'register' usage
Kill unused tracing calls

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/lib/inflate.c
===================================================================
--- tiny.orig/lib/inflate.c	2005-09-28 18:19:05.000000000 -0700
+++ tiny/lib/inflate.c	2005-09-28 18:25:25.000000000 -0700
@@ -103,26 +103,11 @@
  */
 #include <linux/compiler.h>
 
-#ifdef RCSID
-static char rcsid[] = "#Id: inflate.c,v 0.14 1993/06/10 13:27:04 jloup Exp #";
-#endif
-
-#ifndef STATIC
-
-#if defined(STDC_HEADERS) || defined(HAVE_STDLIB_H)
-#  include <sys/types.h>
-#  include <stdlib.h>
-#endif
-
-#include "gzip.h"
-#define STATIC
-#endif /* !STATIC */
-
 #ifndef INIT
 #define INIT
 #endif
 
-#define slide window
+#include <asm/types.h>
 
 /* Huffman code lookup table entry--this entry is four bytes for machines
    that have 16-bit pointers (e.g. PC's in the small or medium model).
@@ -132,36 +117,35 @@ static char rcsid[] = "#Id: inflate.c,v 
    an unused code.  If a code with e == 99 is looked up, this implies an
    error in the data. */
 struct huft {
-	uch e;			/* number of extra bits or operation */
-	uch b;			/* number of bits in this code or subcode */
+	u8 e;			/* number of extra bits or operation */
+	u8 b;			/* number of bits in this code or subcode */
 	union {
-		ush n;		/* literal, length base, or distance base */
+		u16 n;		/* literal, length base, or distance base */
 		struct huft *t;	/* pointer to next level of table */
 	} v;
 };
 
 /* Function prototypes */
-STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned,
-		const ush *, const ush *, struct huft **, int *));
-STATIC int INIT huft_free OF((struct huft *));
-STATIC int INIT inflate_codes OF((struct huft *, struct huft *, int, int));
-STATIC int INIT inflate_stored OF((void));
-STATIC int INIT inflate_fixed OF((void));
-STATIC int INIT inflate_dynamic OF((void));
-STATIC int INIT inflate_block OF((int *));
-STATIC int INIT inflate OF((void));
+static int INIT huft_build(unsigned *, unsigned, unsigned,
+			  const u16 *, const u16 *, struct huft **, int *);
+static int INIT huft_free(struct huft *);
+static int INIT inflate_codes(struct huft *, struct huft *, int, int);
+static int INIT inflate_stored(void);
+static int INIT inflate_fixed(void);
+static int INIT inflate_dynamic(void);
+static int INIT inflate_block(int *);
+static int INIT inflate(void);
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
    stream to find repeated byte strings.  This is implemented here as a
    circular buffer.  The index is updated simply by incrementing and then
    ANDing with 0x7fff (32K-1). */
 /* It is left to other modules to supply the 32 K area.  It is assumed
-   to be usable as if it were declared "uch slide[32768];" or as just
-   "uch *slide;" and then malloc'ed in the latter case.  The definition
+   to be usable as if it were declared "u8 window[32768];" or as just
+   "u8 *window;" and then malloc'ed in the latter case.  The definition
    must be in unzip.h, included above. */
-/* unsigned wp;             current position in slide */
-#define wp outcnt
-#define flush_output(w) (wp=(w),flush_window())
+
+#define flush_output(w) (outcnt=(w),flush_window())
 
 /* Tables for deflate from PKZIP's appnote.txt. */
 
@@ -171,7 +155,7 @@ static const unsigned border[] = {
 };
 
 /* Copy lengths for literal codes 257..285 */
-static const ush cplens[] = {
+static const u16 cplens[] = {
 	3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
 	35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0
 };
@@ -180,20 +164,20 @@ static const ush cplens[] = {
  * note: see note #13 above about the 258 in this list.
  * 99==invalid
  */
-static const ush cplext[] = {
+static const u16 cplext[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
 	3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 99, 99
 };
 
 /* Copy offsets for distance codes 0..29 */
-static const ush cpdist[] = {
+static const u16 cpdist[] = {
 	1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
 	257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
 	8193, 12289, 16385, 24577
 };
 
 /* Extra bits for distance codes */
-static const ush cpdext[] = {
+static const u16 cpdext[] = {
 	0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
 	7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
 	12, 12, 13, 13
@@ -207,10 +191,10 @@ static const ush cpdext[] = {
         DUMPBITS(j)
 
    where NEEDBITS makes sure that b has at least j bits in it, and
-   DUMPBITS removes the bits from b.  The macros use the variable k
-   for the number of bits in b.  Normally, b and k are register
-   variables for speed, and are initialized at the beginning of a
-   routine that uses these macros from a global bit buffer and count.
+   DUMPBITS removes the bits from b. The macros use the variable k for
+   the number of bits in b. Normally, b and k are initialized at the
+   beginning of a routine that uses these macros from a global bit
+   buffer and count.
 
    If we assume that EOB will be the longest code, then we will never
    ask for bits with NEEDBITS that are beyond the end of the stream.
@@ -229,17 +213,17 @@ static const ush cpdext[] = {
    the stream.
  */
 
-STATIC ulg bb;			/* bit buffer */
-STATIC unsigned bk;		/* bits in bit buffer */
+static u32 bb;			/* bit buffer */
+static unsigned bk;		/* bits in bit buffer */
 
-STATIC const ush mask_bits[] = {
+static const u16 mask_bits[] = {
 	0x0000,
 	0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
 	0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
 };
 
-#define NEXTBYTE()  ({ int v = get_byte(); if (v < 0) goto underrun; (uch)v; })
-#define NEEDBITS(n) do {while(k<(n)){b|=((ulg)NEXTBYTE())<<k;k+=8;}} while(0)
+#define NEXTBYTE()  ({ int v = get_byte(); if (v < 0) goto underrun; (u8)v; })
+#define NEEDBITS(n) do {while(k<(n)){b|=((u32)NEXTBYTE())<<k;k+=8;}} while(0)
 #define DUMPBITS(n) do {b>>=(n);k-=(n);} while(0)
 
 /*
@@ -274,15 +258,13 @@ STATIC const ush mask_bits[] = {
    possibly even between compilers.  Your mileage may vary.
  */
 
-STATIC const int lbits = 9;	/* bits in base literal/length lookup table */
-STATIC const int dbits = 6;	/* bits in base distance lookup table */
+static const int lbits = 9;	/* bits in base literal/length lookup table */
+static const int dbits = 6;	/* bits in base distance lookup table */
 
-/* If BMAX needs to be larger than 16, then h and x[] should be ulg. */
+/* If BMAX needs to be larger than 16, then h and x[] should be u32. */
 #define BMAX 16		/* maximum bit length of any code (16 for explode) */
 #define N_MAX 288	/* maximum number of codes in any set */
 
-STATIC unsigned hufts;		/* track memory usage */
-
 /*
  * huft-build - build a huffman decoding table
  * @b: code lengths in bits (all assumed <= BMAX)
@@ -300,24 +282,24 @@ STATIC unsigned hufts;		/* track memory 
  * an oversubscribed set of lengths), and three if not enough
  * memory.
  */
-STATIC int INIT huft_build(unsigned *b, unsigned n, unsigned s, const ush * d,
-		      const ush * e, struct huft **t, int *m)
+static int INIT huft_build(unsigned *b, unsigned n, unsigned s, const u16 * d,
+		      const u16 * e, struct huft **t, int *m)
 {
 	unsigned a;		/* counter for codes of length k */
 	unsigned c[BMAX + 1];	/* bit length count table */
 	unsigned f;		/* i repeats in table every f entries */
 	int g;			/* maximum code length */
 	int h;			/* table level */
-	register unsigned i;	/* counter, current code */
-	register unsigned j;	/* counter */
-	register int k;		/* number of bits in current code */
+	unsigned i;	/* counter, current code */
+	unsigned j;	/* counter */
+	int k;		/* number of bits in current code */
 	int l;			/* bits per table (returned in m) */
-	register unsigned *p;	/* pointer into c[], b[], or v[] */
-	register struct huft *q;	/* points to current table */
+	unsigned *p;	/* pointer into c[], b[], or v[] */
+	struct huft *q;	/* points to current table */
 	struct huft r;		/* table entry for structure assignment */
 	struct huft *u[BMAX];	/* table stack */
 	unsigned v[N_MAX];	/* values in order of bit length */
-	register int w;		/* bits before this table == (l * h) */
+	int w;		/* bits before this table == (l * h) */
 	unsigned x[BMAX + 1];	/* bit offsets, then code stack */
 	unsigned *xp;		/* pointer into x */
 	int y;			/* number of dummy codes added */
@@ -330,14 +312,12 @@ STATIC int INIT huft_build(unsigned *b, 
 	p = b;
 	i = n;
 	do {
-		Tracecv(*p, (stderr, (n - i >= ' ' && n - i <= '~' ?
-				      "%c %d\n" : "0x%x %d\n"), n - i, *p));
 		c[*p]++;	/* assume all entries <= BMAX */
 		p++;
 	} while (--i);
 
 	if (c[0] == n) {	/* null input--all zero length codes */
-		*t = (struct huft *)NULL;
+		*t = 0;
 		*m = 0;
 		return 2;
 	}
@@ -389,7 +369,7 @@ STATIC int INIT huft_build(unsigned *b, 
 	p = b;
 	i = 0;
 	do {
-		if ((j = *p++) != 0)
+		if ((j = *p++))
 			v[x[j]++] = i;
 	} while (++i < n);
 
@@ -402,8 +382,8 @@ STATIC int INIT huft_build(unsigned *b, 
 	p = v; /* grab values in bit order */
 	h = -1; /* no tables yet--level -1 */
 	w = -l;	/* bits decoded == (l * h) */
-	u[0] = (struct huft *)NULL; /* just to keep compilers happy */
-	q = (struct huft *)NULL; /* ditto */
+	u[0] = NULL; /* just to keep compilers happy */
+	q = NULL; /* ditto */
 	z = 0; /* ditto */
 	DEBG("h6a ");
 
@@ -448,17 +428,15 @@ STATIC int INIT huft_build(unsigned *b, 
 				z = 1 << j;
 
 				/* allocate and link in new table */
-				if ((q = (struct huft *)malloc(
-					     (z + 1) * sizeof(struct huft)))
-				    == (struct huft *)NULL) {
+				if (!(q = (struct huft *)malloc(
+					     (z + 1) * sizeof(struct huft)))) {
 					if (h)
 						huft_free(u[0]);
 					return 3;	/* not enough memory */
 				}
 				DEBG1("4 ");
-				hufts += z + 1;	/* track memory usage */
 				*t = q + 1; /* link to list for huft_free */
-				*(t = &(q->v.t)) = (struct huft *)NULL;
+				*(t = &(q->v.t)) = 0;
 				u[h] = ++q;	/* table starts after link */
 
 				DEBG1("5 ");
@@ -467,9 +445,9 @@ STATIC int INIT huft_build(unsigned *b, 
 					/* save pattern for backing up */
 					x[h] = i;
 					/* bits to dump before this table */
-					r.b = (uch)l;
+					r.b = (u8)l;
 					/* bits in this table */
-					r.e = (uch)(16 + j);
+					r.e = (u8)(16 + j);
 					/* pointer to this table */
 					r.v.t = q;
 					/* (get around Turbo C bug) */
@@ -482,19 +460,19 @@ STATIC int INIT huft_build(unsigned *b, 
 			DEBG("h6c ");
 
 			/* set up table entry in r */
-			r.b = (uch) (k - w);
+			r.b = (u8) (k - w);
 			if (p >= v + n)
 				r.e = 99; /* out of values--invalid code */
 			else if (*p < s) {
 				/* 256 is end-of-block code */
-				r.e = (uch) (*p < 256 ? 16 : 15);
+				r.e = (u8)(*p < 256 ? 16 : 15);
 				/* simple code is just the value */
-				r.v.n = (ush) (*p);
+				r.v.n = (u16)(*p);
 				/* one compiler does not like *p++ */
 				p++;
 			} else {
 				/* non-simple--look up in lists */
-				r.e = (uch)e[*p - s];
+				r.e = (u8)e[*p - s];
 				r.v.n = d[*p++ - s];
 			}
 			DEBG("h6d ");
@@ -522,7 +500,7 @@ STATIC int INIT huft_build(unsigned *b, 
 	DEBG("huft7 ");
 
 	/* Return true (1) if we were given an incomplete table */
-	return y != 0 && g != 1;
+	return y && g != 1;
 }
 
 /*
@@ -535,11 +513,11 @@ STATIC int INIT huft_build(unsigned *b, 
  */
 STATIC int INIT huft_free(struct huft *t)
 {
-	register struct huft *p, *q;
+	struct huft *p, *q;
 
 	/* Go through list, freeing from the malloced (t[-1]) address. */
 	p = t;
-	while (p != (struct huft *)NULL) {
+	while (p) {
 		q = (--p)->v.t;
 		free((char *)p);
 		p = q;
@@ -557,20 +535,20 @@ STATIC int INIT huft_free(struct huft *t
  * inflate (decompress) the codes in a deflated (compressed) block.
  * Return an error code or zero if it all goes ok.
  */
-STATIC int inflate_codes(struct huft *tl, struct huft *td, int bl, int bd)
+static int inflate_codes(struct huft *tl, struct huft *td, int bl, int bd)
 {
-	register unsigned e;	/* table entry flag/number of extra bits */
+	unsigned e;	/* table entry flag/number of extra bits */
 	unsigned n, d;		/* length and index for copy */
 	unsigned w;		/* current window position */
 	struct huft *t;		/* pointer to table entry */
 	unsigned ml, md;	/* masks for bl and bd bits */
-	register ulg b;		/* bit buffer */
-	register unsigned k;	/* number of bits in bit buffer */
+	u32 b;		/* bit buffer */
+	unsigned k;	/* number of bits in bit buffer */
 
 	/* make local copies of globals */
 	b = bb;			/* initialize bit buffer */
 	k = bk;
-	w = wp;			/* initialize window position */
+	w = outcnt;			/* initialize window position */
 
 	/* inflate the coded data */
 	ml = mask_bits[bl];	/* precompute masks for speed */
@@ -588,8 +566,7 @@ STATIC int inflate_codes(struct huft *tl
 						     mask_bits[e]))->e) > 16);
 		DUMPBITS(t->b);
 		if (e == 16) {	/* then it's a literal */
-			slide[w++] = (uch)t->v.n;
-			Tracevv((stderr, "%c", slide[w - 1]));
+			window[w++] = (u8)t->v.n;
 			if (w == WSIZE) {
 				flush_output(w);
 				w = 0;
@@ -619,7 +596,6 @@ STATIC int inflate_codes(struct huft *tl
 			NEEDBITS(e);
 			d = w - t->v.n - ((unsigned)b & mask_bits[e]);
 			DUMPBITS(e)
-			    Tracevv((stderr, "\\[%d,%d]", w - d, n));
 
 			/* do the copy */
 			do {
@@ -628,16 +604,14 @@ STATIC int inflate_codes(struct huft *tl
 #if !defined(NOMEMCPY) && !defined(DEBUG)
 				/* (this test assumes unsigned comparison) */
 				if (w - d >= e) {
-					memcpy(slide + w, slide + d, e);
+					memcpy(window + w, window + d, e);
 					w += e;
 					d += e;
 				} else
 #endif				/* !NOMEMCPY */
 					/* avoid memcpy() overlap */
 					do {
-						slide[w++] = slide[d++];
-						Tracevv((stderr, "%c",
-							 slide[w - 1]));
+						window[w++] = window[d++];
 					} while (--e);
 				if (w == WSIZE) {
 					flush_output(w);
@@ -648,7 +622,7 @@ STATIC int inflate_codes(struct huft *tl
 	}
 
 	/* restore the globals from the locals */
-	wp = w;			/* restore global window pointer */
+	outcnt = w;			/* restore global window pointer */
 	bb = b;			/* restore global bit buffer */
 	bk = k;
 
@@ -660,19 +634,19 @@ STATIC int inflate_codes(struct huft *tl
 }
 
 /* inflate_stored - "decompress" an inflated type 0 (stored) block. */
-STATIC int INIT inflate_stored(void)
+static int INIT inflate_stored(void)
 {
 	unsigned n;		/* number of bytes in block */
 	unsigned w;		/* current window position */
-	register ulg b;		/* bit buffer */
-	register unsigned k;	/* number of bits in bit buffer */
+	u32 b;		/* bit buffer */
+	unsigned k;	/* number of bits in bit buffer */
 
 	DEBG("<stor");
 
 	/* make local copies of globals */
 	b = bb;			/* initialize bit buffer */
 	k = bk;
-	w = wp;			/* initialize window position */
+	w = outcnt;			/* initialize window position */
 
 	/* go to byte boundary */
 	n = k & 7;
@@ -690,7 +664,7 @@ STATIC int INIT inflate_stored(void)
 	/* read and output the compressed data */
 	while (n--) {
 		NEEDBITS(8);
-		slide[w++] = (uch)b;
+		window[w++] = (u8)b;
 		if (w == WSIZE) {
 			flush_output(w);
 			w = 0;
@@ -699,7 +673,7 @@ STATIC int INIT inflate_stored(void)
 	}
 
 	/* restore the globals from the locals */
-	wp = w;			/* restore global window pointer */
+	outcnt = w;			/* restore global window pointer */
 	bb = b;			/* restore global bit buffer */
 	bk = k;
 
@@ -719,14 +693,14 @@ STATIC int INIT inflate_stored(void)
  *
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
-STATIC int noinline INIT inflate_fixed(void)
+static int noinline INIT inflate_fixed(void)
 {
 	int i;			/* temporary variable */
 	struct huft *tl;	/* literal/length code table */
 	struct huft *td;	/* distance code table */
 	int bl;			/* lookup bits for tl */
 	int bd;			/* lookup bits for td */
-	unsigned l[288];	/* length list for huft_build */
+	unsigned l[N_MAX];	/* length list for huft_build */
 
 	DEBG("<fix");
 
@@ -737,10 +711,10 @@ STATIC int noinline INIT inflate_fixed(v
 		l[i] = 9;
 	for (; i < 280; i++)
 		l[i] = 7;
-	for (; i < 288; i++)	/* make a complete, but wrong code set */
+	for (; i < N_MAX; i++)	/* make a complete, but wrong code set */
 		l[i] = 8;
 	bl = 7;
-	if ((i = huft_build(l, 288, 257, cplens, cplext, &tl, &bl)) != 0)
+	if ((i = huft_build(l, N_MAX, 257, cplens, cplext, &tl, &bl)))
 		return i;
 
 	/* set up distance table */
@@ -769,7 +743,7 @@ STATIC int noinline INIT inflate_fixed(v
  *
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
-STATIC int noinline INIT inflate_dynamic(void)
+static int noinline INIT inflate_dynamic(void)
 {
 	int i;			/* temporary variables */
 	unsigned j;
@@ -783,13 +757,9 @@ STATIC int noinline INIT inflate_dynamic
 	unsigned nb;		/* number of bit length codes */
 	unsigned nl;		/* number of literal/length codes */
 	unsigned nd;		/* number of distance codes */
-#ifdef PKZIP_BUG_WORKAROUND
-	unsigned ll[288 + 32];	/* literal/length and distance code lengths */
-#else
 	unsigned ll[286 + 30];	/* literal/length and distance code lengths */
-#endif
-	register ulg b;		/* bit buffer */
-	register unsigned k;	/* number of bits in bit buffer */
+	u32 b;		/* bit buffer */
+	unsigned k;	/* number of bits in bit buffer */
 
 	DEBG("<dyn");
 
@@ -807,11 +777,7 @@ STATIC int noinline INIT inflate_dynamic
 	NEEDBITS(4);
 	nb = 4 + ((unsigned)b & 0xf);	/* number of bit length codes */
 	DUMPBITS(4);
-#ifdef PKZIP_BUG_WORKAROUND
-	if (nl > 288 || nd > 32)
-#else
 	if (nl > 286 || nd > 30)
-#endif
 		return 1;	/* bad lengths */
 
 	DEBG("dyn1 ");
@@ -829,7 +795,7 @@ STATIC int noinline INIT inflate_dynamic
 
 	/* build decoding table for trees--single level, 7 bit lookup */
 	bl = 7;
-	if ((i = huft_build(ll, 19, 19, NULL, NULL, &tl, &bl)) != 0) {
+	if ((i = huft_build(ll, 19, 19, 0, 0, &tl, &bl))) {
 		if (i == 1)
 			huft_free(tl);
 		return i;	/* incomplete code set */
@@ -892,7 +858,7 @@ STATIC int noinline INIT inflate_dynamic
 
 	/* build the decoding tables for literal/length and distance codes */
 	bl = lbits;
-	if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl)) != 0) {
+	if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl))) {
 		DEBG("dyn5b ");
 		if (i == 1) {
 			error("incomplete literal tree");
@@ -902,19 +868,14 @@ STATIC int noinline INIT inflate_dynamic
 	}
 	DEBG("dyn5c ");
 	bd = dbits;
-	if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd)) != 0) {
+	if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd))) {
 		DEBG("dyn5d ");
 		if (i == 1) {
 			error("incomplete distance tree");
-#ifdef PKZIP_BUG_WORKAROUND
-			i = 0;
-		}
-#else
 			huft_free(td);
 		}
 		huft_free(tl);
 		return i;	/* incomplete code set */
-#endif
 	}
 
 	DEBG("dyn6 ");
@@ -939,11 +900,11 @@ STATIC int noinline INIT inflate_dynamic
 /* inflate_block - decompress a deflated block
  * @e: last block flag
  */
-STATIC int INIT inflate_block(int *e)
+static int INIT inflate_block(int *e)
 {
 	unsigned t;		/* block type */
-	register ulg b;		/* bit buffer */
-	register unsigned k;	/* number of bits in bit buffer */
+	u32 b;		/* bit buffer */
+	unsigned k;	/* number of bits in bit buffer */
 
 	DEBG("<blk");
 
@@ -983,30 +944,25 @@ STATIC int INIT inflate_block(int *e)
 }
 
 /* inflate - decompress an inflated entry */
-STATIC int INIT inflate(void)
+static int INIT inflate(void)
 {
 	int e;			/* last block flag */
 	int r;			/* result code */
-	unsigned h;		/* maximum struct huft's malloc'ed */
 	void *ptr;
 
 	/* initialize window, bit buffer */
-	wp = 0;
+	outcnt = 0;
 	bk = 0;
 	bb = 0;
 
 	/* decompress until the last block */
-	h = 0;
 	do {
-		hufts = 0;
 		gzip_mark(&ptr);
-		if ((r = inflate_block(&e)) != 0) {
+		if ((r = inflate_block(&e))) {
 			gzip_release(&ptr);
 			return r;
 		}
 		gzip_release(&ptr);
-		if (hufts > h)
-			h = hufts;
 	} while (!e);
 
 	/* Undo too much lookahead. The next read will be byte aligned so we
@@ -1017,13 +973,10 @@ STATIC int INIT inflate(void)
 		inptr--;
 	}
 
-	/* flush out slide */
-	flush_output(wp);
+	/* flush out window */
+	flush_output(outcnt);
 
 	/* return success */
-#ifdef DEBUG
-	fprintf(stderr, "<%u> ", h);
-#endif				/* DEBUG */
 	return 0;
 }
 
@@ -1033,8 +986,8 @@ STATIC int INIT inflate(void)
  *
  **********************************************************************/
 
-static ulg crc_32_tab[256];
-static ulg crc;		/* initialized in makecrc() so it'll reside in bss */
+static u32 crc_32_tab[256];
+static u32 crc;		/* initialized in makecrc() so it'll reside in bss */
 #define CRC_VALUE (crc ^ 0xffffffffUL)
 
 /*
@@ -1073,7 +1026,7 @@ static void INIT makecrc(void)
 	}
 
 	/* this is initialized here so this code could reside in ROM */
-	crc = (ulg)0xffffffffUL;	/* shift register contents */
+	crc = 0xffffffffUL;	/* shift register contents */
 }
 
 /* gzip flag byte */
@@ -1090,11 +1043,11 @@ static void INIT makecrc(void)
  */
 static int INIT gunzip(void)
 {
-	uch flags;
+	u8 flags;
 	unsigned char magic[2];	/* magic header */
 	char method;
-	ulg orig_crc = 0;	/* original crc */
-	ulg orig_len = 0;	/* original uncompressed length */
+	u32 orig_crc = 0;	/* original crc */
+	u32 orig_len = 0;	/* original uncompressed length */
 	int res;
 
 	magic[0] = NEXTBYTE();
@@ -1112,16 +1065,16 @@ static int INIT gunzip(void)
 		return -1;
 	}
 
-	flags = (uch)get_byte();
-	if ((flags & ENCRYPTED) != 0) {
+	flags = (u8)get_byte();
+	if (flags & ENCRYPTED) {
 		error("Input is encrypted");
 		return -1;
 	}
-	if ((flags & CONTINUATION) != 0) {
+	if (flags & CONTINUATION) {
 		error("Multi part input");
 		return -1;
 	}
-	if ((flags & RESERVED) != 0) {
+	if (flags & RESERVED) {
 		error("Input has invalid flags");
 		return -1;
 	}
@@ -1133,25 +1086,22 @@ static int INIT gunzip(void)
 	(void)NEXTBYTE();	/* Ignore extra flags for the moment */
 	(void)NEXTBYTE();	/* Ignore OS type for the moment */
 
-	if ((flags & EXTRA_FIELD) != 0) {
+	if (flags & EXTRA_FIELD) {
 		unsigned len = (unsigned)NEXTBYTE();
 		len |= ((unsigned)NEXTBYTE()) << 8;
 		while (len--)
 			(void)NEXTBYTE();
 	}
 
-	/* Get original file name if it was truncated */
-	if ((flags & ORIG_NAME) != 0) {
-		/* Discard the old name */
-		while (NEXTBYTE() != 0)	/* null */
+	/* Discard original file name if it was truncated */
+	if (flags & ORIG_NAME)
+		while (NEXTBYTE())
 			;
-	}
 
 	/* Discard file comment if any */
-	if ((flags & COMMENT) != 0) {
-		while (NEXTBYTE() != 0)	/* null */
+	if (flags & COMMENT)
+		while (NEXTBYTE())
 			;
-	}
 
 	/* Decompress */
 	if ((res = inflate())) {
@@ -1180,15 +1130,15 @@ static int INIT gunzip(void)
 	/* crc32  (see algorithm.doc)
 	 * uncompressed input size modulo 2^32
 	 */
-	orig_crc = (ulg)NEXTBYTE();
-	orig_crc |= (ulg)NEXTBYTE() << 8;
-	orig_crc |= (ulg)NEXTBYTE() << 16;
-	orig_crc |= (ulg)NEXTBYTE() << 24;
-
-	orig_len = (ulg)NEXTBYTE();
-	orig_len |= (ulg)NEXTBYTE() << 8;
-	orig_len |= (ulg)NEXTBYTE() << 16;
-	orig_len |= (ulg)NEXTBYTE() << 24;
+	orig_crc = (u32)NEXTBYTE();
+	orig_crc |= (u32)NEXTBYTE() << 8;
+	orig_crc |= (u32)NEXTBYTE() << 16;
+	orig_crc |= (u32)NEXTBYTE() << 24;
+
+	orig_len = (u32)NEXTBYTE();
+	orig_len |= (u32)NEXTBYTE() << 8;
+	orig_len |= (u32)NEXTBYTE() << 16;
+	orig_len |= (u32)NEXTBYTE() << 24;
 
 	/* Validate decompression */
 	if (orig_crc != CRC_VALUE) {
