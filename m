Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVLVS3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVLVS3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVLVS2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:44 -0500
Received: from waste.org ([64.81.244.121]:3536 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030262AbVLVS1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:52 -0500
Date: Thu, 22 Dec 2005 12:26:33 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <5.150843412@selenic.com>
Message-Id: <6.150843412@selenic.com>
Subject: [PATCH 5/20] inflate: cleanup Huffman table code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: cleanup huffman table code

sensible names for huft struct members
get rid of assignment-in-expression usage

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 21:03:12.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 21:04:46.000000000 -0700
@@ -117,12 +117,12 @@
    an unused code.  If a code with e == 99 is looked up, this implies an
    error in the data. */
 struct huft {
-	u8 e;			/* number of extra bits or operation */
-	u8 b;			/* number of bits in this code or subcode */
 	union {
-		u16 n;		/* literal, length base, or distance base */
-		struct huft *t;	/* pointer to next level of table */
-	} v;
+		u16 val; /* literal, length base, or distance base */
+		struct huft *next; /* pointer to next level of table */
+	};
+	u8 extra; /* number of extra bits or operation */
+	u8 bits; /* number of bits in this code or subcode */
 };
 
 struct iostate {
@@ -393,11 +393,14 @@ static int INIT huft_build(unsigned *b, 
 	DEBG("huft3 ");
 
 	/* Adjust last length count to fill out codes, if needed */
-	for (y = 1 << j; j < i; j++, y <<= 1)
-		if ((y -= c[j]) < 0)
+	for (y = 1 << j; j < i; j++, y <<= 1) {
+		y -= c[j];
+		if (y < 0)
 			return 2; /* bad input: more codes than bits */
+	}
 
-	if ((y -= c[i]) < 0)
+	y -= c[i];
+	if (y < 0)
 		return 2;
 	c[i] += y;
 
@@ -408,8 +411,12 @@ static int INIT huft_build(unsigned *b, 
 	p = c + 1;
 	xp = x + 2;
 	/* note that i == g from above */
-	while (--i)
-		*xp++ = (j += *p++);
+	while (--i) {
+		j += *p;
+		*xp = j;
+		p++;
+		xp++;
+	}
 
 	DEBG("huft5 ");
 
@@ -417,7 +424,8 @@ static int INIT huft_build(unsigned *b, 
 	p = b;
 	i = 0;
 	do {
-		if ((j = *p++))
+		j = *p++;
+		if (j)
 			v[x[j]++] = i;
 	} while (++i < n);
 
@@ -450,10 +458,12 @@ static int INIT huft_build(unsigned *b, 
 
 				/* compute min size <= l bits */
 				/* upper limit on table size */
-				z = (z = g - w) > (unsigned)l ? l : z;
+				z = min(l, g - w);
 
 				/* try a k-w bit table */
-				if ((f = 1 << (j = k - w)) > a + 1) {
+				j = k - w;
+				f = 1 << j;
+				if (f > a + 1) {
 					/* too few codes for k-w bit table */
 					DEBG1("2 ");
 					/* deduct codes from patterns left */
@@ -463,7 +473,8 @@ static int INIT huft_build(unsigned *b, 
 					if (j < z) {
 						/* enough codes for j bits? */
 						while (++j < z) {
-							if ((f <<= 1) <= *++xp)
+							f <<= 1;
+							if (f <= *++xp)
 								break;
 							/* deduct from pats */
 							f -= *xp;
@@ -476,15 +487,17 @@ static int INIT huft_build(unsigned *b, 
 				z = 1 << j;
 
 				/* allocate and link in new table */
-				if (!(q = (struct huft *)malloc(
-					     (z + 1) * sizeof(struct huft)))) {
+				q = malloc((z + 1) * sizeof(struct huft));
+				if (!q) {
 					if (h)
 						huft_free(u[0]);
 					return 3;	/* not enough memory */
 				}
+
 				DEBG1("4 ");
 				*t = q + 1; /* link to list for huft_free */
-				*(t = &(q->v.t)) = 0;
+				t = &q->next;
+				*t = NULL;
 				u[h] = ++q;	/* table starts after link */
 
 				DEBG1("5 ");
@@ -493,11 +506,11 @@ static int INIT huft_build(unsigned *b, 
 					/* save pattern for backing up */
 					x[h] = i;
 					/* bits to dump before this table */
-					r.b = (u8)l;
+					r.bits = (u8)l;
 					/* bits in this table */
-					r.e = (u8)(16 + j);
+					r.extra = (u8)(16 + j);
 					/* pointer to this table */
-					r.v.t = q;
+					r.next = q;
 					/* (get around Turbo C bug) */
 					j = i >> (w - l);
 					/* connect to last table */
@@ -508,20 +521,20 @@ static int INIT huft_build(unsigned *b, 
 			DEBG("h6c ");
 
 			/* set up table entry in r */
-			r.b = (u8) (k - w);
+			r.bits = (u8)(k - w);
 			if (p >= v + n)
-				r.e = 99; /* out of values--invalid code */
+				r.extra = 99; /* out of values--invalid code */
 			else if (*p < s) {
 				/* 256 is end-of-block code */
-				r.e = (u8)(*p < 256 ? 16 : 15);
+				r.extra = (u8)(*p < 256 ? 16 : 15);
 				/* simple code is just the value */
-				r.v.n = (u16)(*p);
+				r.val = (u16)(*p);
 				/* one compiler does not like *p++ */
 				p++;
 			} else {
 				/* non-simple--look up in lists */
-				r.e = (u8)e[*p - s];
-				r.v.n = d[*p++ - s];
+				r.extra = (u8)e[*p - s];
+				r.val = d[*p++ - s];
 			}
 			DEBG("h6d ");
 
@@ -559,16 +572,16 @@ static int INIT huft_build(unsigned *b, 
  * linked list of the tables it made, with the links in a dummy first
  * entry of each table.
  */
-STATIC int INIT huft_free(struct huft *t)
+static int INIT huft_free(struct huft *t)
 {
-	struct huft *p, *q;
+	struct huft *q;
 
 	/* Go through list, freeing from the malloced (t[-1]) address. */
-	p = t;
-	while (p) {
-		q = (--p)->v.t;
-		free((char *)p);
-		p = q;
+	while (t) {
+		t -= 1;
+		q = t->next;
+		free(t);
+		t = q;
 	}
 	return 0;
 }
@@ -587,45 +600,40 @@ STATIC int INIT huft_free(struct huft *t
 static int INIT inflate_codes(struct iostate *io, struct huft *tl, struct huft *td,
 			 int bl, int bd)
 {
-	unsigned e;	/* table entry flag/number of extra bits */
 	unsigned len, dist;
 	struct huft *t;		/* pointer to table entry */
 
 	/* inflate the coded data */
 	for (;;) {		/* do until end of block */
 		t = tl + readbits(io, bl);
-		e = t->e;
-		while (e > 16) {
-			if (e == 99)
+		while (t->extra > 16) {
+			if (t->extra == 99)
 				return 1;
-			dumpbits(io, t->b);
-			t = t->v.t + readbits(io, e - 16);
-			e = t->e;
+			dumpbits(io, t->bits);
+			t = &t->next[readbits(io, t->extra - 16)];
 		}
-		dumpbits(io, t->b);
-		if (e == 16) {	/* then it's a literal */
-			put_byte(io, t->v.n);
+		dumpbits(io, t->bits);
+		if (t->extra == 16) {	/* then it's a literal */
+			put_byte(io, t->val);
 		} else {	/* it's an EOB or a length */
 			/* exit if end of block */
-			if (e == 15)
+			if (t->extra == 15)
 				break;
 
 			/* get length of block to copy */
-			len = t->v.n + pullbits(io, e);
+			len = t->val + pullbits(io, t->extra);
 
 			/* decode distance of block to copy */
 			t = td + readbits(io, bd);
-			e = t->e;
-			while (e > 16) {
-				if (e == 99)
+			while (t->extra > 16) {
+				if (t->extra == 99)
 					return 1;
-				dumpbits(io, t->b);
-				t = t->v.t + readbits(io, e - 16);
-				e = t->e;
+				dumpbits(io, t->bits);
+				t = &t->next[readbits(io, t->extra - 16)];
 			}
-			dumpbits(io, t->b);
+			dumpbits(io, t->bits);
 
-			dist = t->v.n + pullbits(io, e);
+			dist = t->val + pullbits(io, t->extra);
 			copy_bytes(io, len, dist);
 		}
 	}
@@ -767,8 +775,8 @@ static int noinline INIT inflate_dynamic
 	i = l = 0;
 	while ((unsigned)i < n) {
 		td = tl + readbits(io, bl);
-		dumpbits(io, td->b);
-		j = td->v.n;
+		dumpbits(io, td->bits);
+		j = td->val;
 		if (j < 16)	/* length of code in bits (0..15) */
 			ll[i++] = l = j;	/* save last length in l */
 		else if (j == 16) {	/* repeat last length 3 to 6 times */
