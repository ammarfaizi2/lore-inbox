Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVAUWD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVAUWD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAUWDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:03:03 -0500
Received: from waste.org ([216.27.176.166]:26329 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262521AbVAUVlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:18 -0500
Date: Fri, 21 Jan 2005 15:41:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.314297600@selenic.com>
Message-Id: <3.314297600@selenic.com>
Subject: [PATCH 2/12] random pt4: Use them throughout the tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move users of private rotl/rotr functions to rol32/ror32. Crypto bits
verified with tcrypt.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/crypto/michael_mic.c
===================================================================
--- rnd2.orig/crypto/michael_mic.c	2004-04-03 19:37:36.000000000 -0800
+++ rnd2/crypto/michael_mic.c	2005-01-20 09:20:50.000000000 -0800
@@ -24,18 +24,6 @@
 };
 
 
-static inline u32 rotl(u32 val, int bits)
-{
-	return (val << bits) | (val >> (32 - bits));
-}
-
-
-static inline u32 rotr(u32 val, int bits)
-{
-	return (val >> bits) | (val << (32 - bits));
-}
-
-
 static inline u32 xswap(u32 val)
 {
 	return ((val & 0x00ff00ff) << 8) | ((val & 0xff00ff00) >> 8);
@@ -44,13 +32,13 @@
 
 #define michael_block(l, r)	\
 do {				\
-	r ^= rotl(l, 17);	\
+	r ^= rol32(l, 17);	\
 	l += r;			\
 	r ^= xswap(l);		\
 	l += r;			\
-	r ^= rotl(l, 3);	\
+	r ^= rol32(l, 3);	\
 	l += r;			\
-	r ^= rotr(l, 2);	\
+	r ^= ror32(l, 2);	\
 	l += r;			\
 } while (0)
 
Index: rnd2/fs/ncpfs/ncpsign_kernel.c
===================================================================
--- rnd2.orig/fs/ncpfs/ncpsign_kernel.c	2004-04-03 19:36:55.000000000 -0800
+++ rnd2/fs/ncpfs/ncpsign_kernel.c	2005-01-20 09:20:50.000000000 -0800
@@ -11,10 +11,9 @@
 
 #include <linux/string.h>
 #include <linux/ncp.h>
+#include <linux/bitops.h>
 #include "ncpsign_kernel.h"
 
-#define rol32(i,c) (((((i)&0xffffffff)<<c)&0xffffffff)| \
-                    (((i)&0xffffffff)>>(32-c)))
 /* i386: 32-bit, little endian, handles mis-alignment */
 #ifdef __i386__
 #define GET_LE32(p) (*(int *)(p))
Index: rnd2/crypto/cast5.c
===================================================================
--- rnd2.orig/crypto/cast5.c	2004-04-03 19:37:07.000000000 -0800
+++ rnd2/crypto/cast5.c	2005-01-20 09:20:50.000000000 -0800
@@ -567,14 +567,11 @@
 	0xeaee6801, 0x8db2a283, 0xea8bf59e
 };
 
-
-#define rol(n,x) ( ((x) << (n)) | ((x) >> (32-(n))) )
-
-#define F1(D,m,r)  (  (I = ((m) + (D))), (I=rol((r),I)),   \
+#define F1(D,m,r)  (  (I = ((m) + (D))), (I=rol32(I,(r))),   \
     (((s1[I >> 24] ^ s2[(I>>16)&0xff]) - s3[(I>>8)&0xff]) + s4[I&0xff]) )
-#define F2(D,m,r)  (  (I = ((m) ^ (D))), (I=rol((r),I)),   \
+#define F2(D,m,r)  (  (I = ((m) ^ (D))), (I=rol32(I,(r))),   \
     (((s1[I >> 24] - s2[(I>>16)&0xff]) + s3[(I>>8)&0xff]) ^ s4[I&0xff]) )
-#define F3(D,m,r)  (  (I = ((m) - (D))), (I=rol((r),I)),   \
+#define F3(D,m,r)  (  (I = ((m) - (D))), (I=rol32(I,(r))),   \
     (((s1[I >> 24] + s2[(I>>16)&0xff]) ^ s3[(I>>8)&0xff]) - s4[I&0xff]) )
 
 
Index: rnd2/crypto/aes.c
===================================================================
--- rnd2.orig/crypto/aes.c	2005-01-19 22:50:34.000000000 -0800
+++ rnd2/crypto/aes.c	2005-01-20 09:20:50.000000000 -0800
@@ -64,23 +64,6 @@
 
 #define AES_BLOCK_SIZE		16
 
-static inline 
-u32 generic_rotr32 (const u32 x, const unsigned bits)
-{
-	const unsigned n = bits % 32;
-	return (x >> n) | (x << (32 - n));
-}
-
-static inline 
-u32 generic_rotl32 (const u32 x, const unsigned bits)
-{
-	const unsigned n = bits % 32;
-	return (x << n) | (x >> (32 - n));
-}
-
-#define rotl generic_rotl32
-#define rotr generic_rotr32
-
 /*
  * #define byte(x, nr) ((unsigned char)((x) >> (nr*8))) 
  */
@@ -191,26 +174,26 @@
 
 		t = p;
 		fl_tab[0][i] = t;
-		fl_tab[1][i] = rotl (t, 8);
-		fl_tab[2][i] = rotl (t, 16);
-		fl_tab[3][i] = rotl (t, 24);
+		fl_tab[1][i] = rol32(t, 8);
+		fl_tab[2][i] = rol32(t, 16);
+		fl_tab[3][i] = rol32(t, 24);
 
 		t = ((u32) ff_mult (2, p)) |
 		    ((u32) p << 8) |
 		    ((u32) p << 16) | ((u32) ff_mult (3, p) << 24);
 
 		ft_tab[0][i] = t;
-		ft_tab[1][i] = rotl (t, 8);
-		ft_tab[2][i] = rotl (t, 16);
-		ft_tab[3][i] = rotl (t, 24);
+		ft_tab[1][i] = rol32(t, 8);
+		ft_tab[2][i] = rol32(t, 16);
+		ft_tab[3][i] = rol32(t, 24);
 
 		p = isb_tab[i];
 
 		t = p;
 		il_tab[0][i] = t;
-		il_tab[1][i] = rotl (t, 8);
-		il_tab[2][i] = rotl (t, 16);
-		il_tab[3][i] = rotl (t, 24);
+		il_tab[1][i] = rol32(t, 8);
+		il_tab[2][i] = rol32(t, 16);
+		il_tab[3][i] = rol32(t, 24);
 
 		t = ((u32) ff_mult (14, p)) |
 		    ((u32) ff_mult (9, p) << 8) |
@@ -218,9 +201,9 @@
 		    ((u32) ff_mult (11, p) << 24);
 
 		it_tab[0][i] = t;
-		it_tab[1][i] = rotl (t, 8);
-		it_tab[2][i] = rotl (t, 16);
-		it_tab[3][i] = rotl (t, 24);
+		it_tab[1][i] = rol32(t, 8);
+		it_tab[2][i] = rol32(t, 16);
+		it_tab[3][i] = rol32(t, 24);
 	}
 }
 
@@ -232,14 +215,14 @@
     w   = star_x(v);        \
     t   = w ^ (x);          \
    (y)  = u ^ v ^ w;        \
-   (y) ^= rotr(u ^ t,  8) ^ \
-          rotr(v ^ t, 16) ^ \
-          rotr(t,24)
+   (y) ^= ror32(u ^ t,  8) ^ \
+          ror32(v ^ t, 16) ^ \
+          ror32(t,24)
 
 /* initialise the key schedule from the user supplied key */
 
 #define loop4(i)                                    \
-{   t = rotr(t,  8); t = ls_box(t) ^ rco_tab[i];    \
+{   t = ror32(t,  8); t = ls_box(t) ^ rco_tab[i];    \
     t ^= E_KEY[4 * i];     E_KEY[4 * i + 4] = t;    \
     t ^= E_KEY[4 * i + 1]; E_KEY[4 * i + 5] = t;    \
     t ^= E_KEY[4 * i + 2]; E_KEY[4 * i + 6] = t;    \
@@ -247,7 +230,7 @@
 }
 
 #define loop6(i)                                    \
-{   t = rotr(t,  8); t = ls_box(t) ^ rco_tab[i];    \
+{   t = ror32(t,  8); t = ls_box(t) ^ rco_tab[i];    \
     t ^= E_KEY[6 * i];     E_KEY[6 * i + 6] = t;    \
     t ^= E_KEY[6 * i + 1]; E_KEY[6 * i + 7] = t;    \
     t ^= E_KEY[6 * i + 2]; E_KEY[6 * i + 8] = t;    \
@@ -257,7 +240,7 @@
 }
 
 #define loop8(i)                                    \
-{   t = rotr(t,  8); ; t = ls_box(t) ^ rco_tab[i];  \
+{   t = ror32(t,  8); ; t = ls_box(t) ^ rco_tab[i];  \
     t ^= E_KEY[8 * i];     E_KEY[8 * i + 8] = t;    \
     t ^= E_KEY[8 * i + 1]; E_KEY[8 * i + 9] = t;    \
     t ^= E_KEY[8 * i + 2]; E_KEY[8 * i + 10] = t;   \
Index: rnd2/crypto/cast6.c
===================================================================
--- rnd2.orig/crypto/cast6.c	2004-04-03 19:36:27.000000000 -0800
+++ rnd2/crypto/cast6.c	2005-01-20 09:20:50.000000000 -0800
@@ -33,13 +33,11 @@
 	u8 Kr[12][4];
 };
 
-#define rol(n,x) ( ((x) << (n)) | ((x) >> (32-(n))) )
-
-#define F1(D,r,m)  (  (I = ((m) + (D))), (I=rol((r),I)),   \
+#define F1(D,r,m)  (  (I = ((m) + (D))), (I=rol32(I,(r))),   \
     (((s1[I >> 24] ^ s2[(I>>16)&0xff]) - s3[(I>>8)&0xff]) + s4[I&0xff]) )
-#define F2(D,r,m)  (  (I = ((m) ^ (D))), (I=rol((r),I)),   \
+#define F2(D,r,m)  (  (I = ((m) ^ (D))), (I=rol32(I,(r))),   \
     (((s1[I >> 24] - s2[(I>>16)&0xff]) + s3[(I>>8)&0xff]) ^ s4[I&0xff]) )
-#define F3(D,r,m)  (  (I = ((m) - (D))), (I=rol((r),I)),   \
+#define F3(D,r,m)  (  (I = ((m) - (D))), (I=rol32(I,(r))),   \
     (((s1[I >> 24] + s2[(I>>16)&0xff]) ^ s3[(I>>8)&0xff]) - s4[I&0xff]) )
 
 static const u32 s1[256] = {
Index: rnd2/fs/xfs/xfs_da_btree.c
===================================================================
--- rnd2.orig/fs/xfs/xfs_da_btree.c	2005-01-19 22:51:17.000000000 -0800
+++ rnd2/fs/xfs/xfs_da_btree.c	2005-01-20 09:20:51.000000000 -0800
@@ -1627,40 +1627,38 @@
 {
 	xfs_dahash_t hash;
 
-#define	ROTL(x,y)	(((x) << (y)) | ((x) >> (32 - (y))))
 #ifdef SLOWVERSION
 	/*
 	 * This is the old one-byte-at-a-time version.
 	 */
-	for (hash = 0; namelen > 0; namelen--) {
-		hash = *name++ ^ ROTL(hash, 7);
-	}
+	for (hash = 0; namelen > 0; namelen--)
+		hash = *name++ ^ rol32(hash, 7);
+
 	return(hash);
 #else
 	/*
 	 * Do four characters at a time as long as we can.
 	 */
-	for (hash = 0; namelen >= 4; namelen -= 4, name += 4) {
+	for (hash = 0; namelen >= 4; namelen -= 4, name += 4)
 		hash = (name[0] << 21) ^ (name[1] << 14) ^ (name[2] << 7) ^
-		       (name[3] << 0) ^ ROTL(hash, 7 * 4);
-	}
+		       (name[3] << 0) ^ rol32(hash, 7 * 4);
+
 	/*
 	 * Now do the rest of the characters.
 	 */
 	switch (namelen) {
 	case 3:
 		return (name[0] << 14) ^ (name[1] << 7) ^ (name[2] << 0) ^
-		       ROTL(hash, 7 * 3);
+		       rol32(hash, 7 * 3);
 	case 2:
-		return (name[0] << 7) ^ (name[1] << 0) ^ ROTL(hash, 7 * 2);
+		return (name[0] << 7) ^ (name[1] << 0) ^ rol32(hash, 7 * 2);
 	case 1:
-		return (name[0] << 0) ^ ROTL(hash, 7 * 1);
+		return (name[0] << 0) ^ rol32(hash, 7 * 1);
 	case 0:
 		return hash;
 	}
 	/* NOTREACHED */
 #endif
-#undef ROTL
 	return 0; /* keep gcc happy */
 }
 
Index: rnd2/crypto/serpent.c
===================================================================
--- rnd2.orig/crypto/serpent.c	2005-01-19 22:52:24.000000000 -0800
+++ rnd2/crypto/serpent.c	2005-01-20 14:28:18.000000000 -0800
@@ -31,11 +31,9 @@
 #define SERPENT_BLOCK_SIZE		 16
 
 #define PHI 0x9e3779b9UL
-#define ROL(x,r) ((x) = ((x) << (r)) | ((x) >> (32-(r))))
-#define ROR(x,r) ((x) = ((x) >> (r)) | ((x) << (32-(r))))
 
 #define keyiter(a,b,c,d,i,j) \
-        b ^= d; b ^= c; b ^= a; b ^= PHI ^ i; ROL(b,11); k[j] = b;
+        b ^= d; b ^= c; b ^= a; b ^= PHI ^ i; b = rol32(b,11); k[j] = b;
 
 #define loadkeys(x0,x1,x2,x3,i) \
 	x0=k[i]; x1=k[i+1]; x2=k[i+2]; x3=k[i+3];
@@ -48,24 +46,24 @@
 	x1 ^= k[4*(i)+1];        x0 ^= k[4*(i)+0];
 
 #define LK(x0,x1,x2,x3,x4,i)				\
-					ROL(x0,13);	\
-	ROL(x2,3);	x1 ^= x0;	x4  = x0 << 3;	\
+					x0=rol32(x0,13);\
+	x2=rol32(x2,3);	x1 ^= x0;	x4  = x0 << 3;	\
 	x3 ^= x2;	x1 ^= x2;			\
-	ROL(x1,1);	x3 ^= x4;			\
-	ROL(x3,7);	x4  = x1;			\
+	x1=rol32(x1,1);	x3 ^= x4;			\
+	x3=rol32(x3,7);	x4  = x1;			\
 	x0 ^= x1;	x4 <<= 7;	x2 ^= x3;	\
 	x0 ^= x3;	x2 ^= x4;	x3 ^= k[4*i+3];	\
-	x1 ^= k[4*i+1];	ROL(x0,5);	ROL(x2,22);	\
+	x1 ^= k[4*i+1];	x0=rol32(x0,5);	x2=rol32(x2,22);\
 	x0 ^= k[4*i+0];	x2 ^= k[4*i+2];
 
 #define KL(x0,x1,x2,x3,x4,i)				\
 	x0 ^= k[4*i+0];	x1 ^= k[4*i+1];	x2 ^= k[4*i+2];	\
-	x3 ^= k[4*i+3];	ROR(x0,5);	ROR(x2,22);	\
+	x3 ^= k[4*i+3];	x0=ror32(x0,5);	x2=ror32(x2,22);\
 	x4 =  x1;	x2 ^= x3;	x0 ^= x3;	\
-	x4 <<= 7;	x0 ^= x1;	ROR(x1,1);	\
-	x2 ^= x4;	ROR(x3,7);	x4 = x0 << 3;	\
-	x1 ^= x0;	x3 ^= x4;	ROR(x0,13);	\
-	x1 ^= x2;	x3 ^= x2;	ROR(x2,3);
+	x4 <<= 7;	x0 ^= x1;	x1=ror32(x1,1);	\
+	x2 ^= x4;	x3=ror32(x3,7);	x4 = x0 << 3;	\
+	x1 ^= x0;	x3 ^= x4;	x0=ror32(x0,13);\
+	x1 ^= x2;	x3 ^= x2;	x2=ror32(x2,3);
 
 #define S0(x0,x1,x2,x3,x4)				\
 					x4  = x3;	\
Index: rnd2/crypto/sha1.c
===================================================================
--- rnd2.orig/crypto/sha1.c	2005-01-20 12:20:13.000000000 -0800
+++ rnd2/crypto/sha1.c	2005-01-20 14:28:35.000000000 -0800
@@ -27,27 +27,22 @@
 #define SHA1_DIGEST_SIZE	20
 #define SHA1_HMAC_BLOCK_SIZE	64
 
-static inline u32 rol(u32 value, u32 bits)
-{
-	return (((value) << (bits)) | ((value) >> (32 - (bits))));
-}
-
 /* blk0() and blk() perform the initial expand. */
 /* I got the idea of expanding during the round function from SSLeay */
 # define blk0(i) block32[i]
 
-#define blk(i) (block32[i&15] = rol(block32[(i+13)&15]^block32[(i+8)&15] \
+#define blk(i) (block32[i&15] = rol32(block32[(i+13)&15]^block32[(i+8)&15] \
     ^block32[(i+2)&15]^block32[i&15],1))
 
 /* (R0+R1), R2, R3, R4 are the different operations used in SHA1 */
-#define R0(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk0(i)+0x5A827999+rol(v,5); \
-                        w=rol(w,30);
-#define R1(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk(i)+0x5A827999+rol(v,5); \
-                        w=rol(w,30);
-#define R2(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0x6ED9EBA1+rol(v,5);w=rol(w,30);
-#define R3(v,w,x,y,z,i) z+=(((w|x)&y)|(w&x))+blk(i)+0x8F1BBCDC+rol(v,5); \
-                        w=rol(w,30);
-#define R4(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0xCA62C1D6+rol(v,5);w=rol(w,30);
+#define R0(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk0(i)+0x5A827999+rol32(v,5); \
+                        w=rol32(w,30);
+#define R1(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk(i)+0x5A827999+rol32(v,5); \
+                        w=rol32(w,30);
+#define R2(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0x6ED9EBA1+rol32(v,5);w=rol32(w,30);
+#define R3(v,w,x,y,z,i) z+=(((w|x)&y)|(w&x))+blk(i)+0x8F1BBCDC+rol32(v,5); \
+                        w=rol32(w,30);
+#define R4(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0xCA62C1D6+rol32(v,5);w=rol32(w,30);
 
 struct sha1_ctx {
         u64 count;
Index: rnd2/crypto/sha256.c
===================================================================
--- rnd2.orig/crypto/sha256.c	2005-01-19 22:52:24.000000000 -0800
+++ rnd2/crypto/sha256.c	2005-01-20 12:27:36.000000000 -0800
@@ -42,15 +42,10 @@
 	return (x & y) | (z & (x | y));
 }
 
-static inline u32 RORu32(u32 x, u32 y)
-{
-	return (x >> y) | (x << (32 - y));
-}
-
-#define e0(x)       (RORu32(x, 2) ^ RORu32(x,13) ^ RORu32(x,22))
-#define e1(x)       (RORu32(x, 6) ^ RORu32(x,11) ^ RORu32(x,25))
-#define s0(x)       (RORu32(x, 7) ^ RORu32(x,18) ^ (x >> 3))
-#define s1(x)       (RORu32(x,17) ^ RORu32(x,19) ^ (x >> 10))
+#define e0(x)       (ror32(x, 2) ^ ror32(x,13) ^ ror32(x,22))
+#define e1(x)       (ror32(x, 6) ^ ror32(x,11) ^ ror32(x,25))
+#define s0(x)       (ror32(x, 7) ^ ror32(x,18) ^ (x >> 3))
+#define s1(x)       (ror32(x,17) ^ ror32(x,19) ^ (x >> 10))
 
 #define H0         0x6a09e667
 #define H1         0xbb67ae85
