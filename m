Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVDVKLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVDVKLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDVKKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:10:06 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:45293 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262027AbVDVKAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:00:30 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Subject: [PATCH 3/3] crypto: reduce twofish.o size
Date: Fri, 22 Apr 2005 12:59:10 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_urMaC/MlQ2P/O5w"
Message-Id: <200504221259.10079.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_urMaC/MlQ2P/O5w
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Currently twofish is the largest crypto module (~38k).

Most of that is a result of unrolling in key setup routine.
Converting some of it to loop brings module size down to 15k while
slowing key setup only by 7%.

Patches 1-3 were tested with tcrypt. Please apply.
--
vda

--Boundary-00=_urMaC/MlQ2P/O5w
Content-Type: text/x-diff;
  charset="koi8-r";
  name="3.tf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3.tf.patch"

diff -urpN linux-2.6.12-rc2.2.wp/crypto/twofish.c linux-2.6.12-rc2.3.twofish/crypto/twofish.c
--- linux-2.6.12-rc2.2.wp/crypto/twofish.c	Thu Apr 21 23:35:04 2005
+++ linux-2.6.12-rc2.3.twofish/crypto/twofish.c	Fri Apr 22 00:14:34 2005
@@ -532,88 +532,95 @@ static const u8 calc_sb_tbl[512] = {
  * key byte to use.  CALC_K256 is identical to CALC_K but for using the
  * CALC_K256_2 macro instead of CALC_K_2. */
 
-#define CALC_K_2(a, b, c, d, j) \
-     mds[0][q0[a ^ key[(j) + 8]] ^ key[j]] \
-   ^ mds[1][q0[b ^ key[(j) + 9]] ^ key[(j) + 1]] \
-   ^ mds[2][q1[c ^ key[(j) + 10]] ^ key[(j) + 2]] \
-   ^ mds[3][q1[d ^ key[(j) + 11]] ^ key[(j) + 3]]
+#define CALC_K_2(a, b, c, d, j) ( \
+     mds[0][q0[(a) ^ key[(j) + 8]] ^ key[j]] \
+   ^ mds[1][q0[(b) ^ key[(j) + 9]] ^ key[(j) + 1]] \
+   ^ mds[2][q1[(c) ^ key[(j) + 10]] ^ key[(j) + 2]] \
+   ^ mds[3][q1[(d) ^ key[(j) + 11]] ^ key[(j) + 3]] \
+)
 
-#define CALC_K(a, j, k, l, m, n) \
+#define CALC_K(a, j, k, l, m, n) { \
    x = CALC_K_2 (k, l, k, l, 0); \
    y = CALC_K_2 (m, n, m, n, 4); \
    y = rol32(y, 8); \
-   x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = rol32(y, 9)
+   x += y; y += x; \
+   ctx->a[j] = x; \
+   ctx->a[(j) + 1] = rol32(y, 9); \
+}
 
 #define CALC_K192_2(a, b, c, d, j) \
-   CALC_K_2 (q0[a ^ key[(j) + 16]], \
-	     q1[b ^ key[(j) + 17]], \
-	     q0[c ^ key[(j) + 18]], \
-	     q1[d ^ key[(j) + 19]], j)
+   CALC_K_2 (q0[(a) ^ key[(j) + 16]], \
+	     q1[(b) ^ key[(j) + 17]], \
+	     q0[(c) ^ key[(j) + 18]], \
+	     q1[(d) ^ key[(j) + 19]], (j))
 
-#define CALC_K192(a, j, k, l, m, n) \
+#define CALC_K192(a, j, k, l, m, n) { \
    x = CALC_K192_2 (l, l, k, k, 0); \
    y = CALC_K192_2 (n, n, m, m, 4); \
    y = rol32(y, 8); \
-   x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = rol32(y, 9)
+   x += y; y += x; \
+   ctx->a[j] = x; \
+   ctx->a[(j) + 1] = rol32(y, 9); \
+}
 
 #define CALC_K256_2(a, b, j) \
-   CALC_K192_2 (q1[b ^ key[(j) + 24]], \
-	        q1[a ^ key[(j) + 25]], \
-	        q0[a ^ key[(j) + 26]], \
-	        q0[b ^ key[(j) + 27]], j)
+   CALC_K192_2 (q1[(b) ^ key[(j) + 24]], \
+	        q1[(a) ^ key[(j) + 25]], \
+	        q0[(a) ^ key[(j) + 26]], \
+	        q0[(b) ^ key[(j) + 27]], (j))
 
-#define CALC_K256(a, j, k, l, m, n) \
+#define CALC_K256(a, j, k, l, m, n) { \
    x = CALC_K256_2 (k, l, 0); \
    y = CALC_K256_2 (m, n, 4); \
    y = rol32(y, 8); \
-   x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = rol32(y, 9)
-
+   x += y; y += x; \
+   ctx->a[j] = x; \
+   ctx->a[(j) + 1] = rol32(y, 9); \
+}
 
 /* Macros to compute the g() function in the encryption and decryption
  * rounds.  G1 is the straight g() function; G2 includes the 8-bit
  * rotation for the high 32-bit word. */
 
-#define G1(a) \
-     (ctx->s[0][(a) & 0xFF]) ^ (ctx->s[1][((a) >> 8) & 0xFF]) \
-   ^ (ctx->s[2][((a) >> 16) & 0xFF]) ^ (ctx->s[3][(a) >> 24])
-
-#define G2(b) \
-     (ctx->s[1][(b) & 0xFF]) ^ (ctx->s[2][((b) >> 8) & 0xFF]) \
-   ^ (ctx->s[3][((b) >> 16) & 0xFF]) ^ (ctx->s[0][(b) >> 24])
+#define G1(a) ( \
+     (ctx->s[0][BYTE0(a)]) ^ (ctx->s[1][BYTE1(a)]) \
+   ^ (ctx->s[2][BYTE2(a)]) ^ (ctx->s[3][BYTE3(a)]) \
+)
+
+#define G2(b) ( \
+     (ctx->s[1][BYTE0(b)]) ^ (ctx->s[2][BYTE1(b)]) \
+   ^ (ctx->s[3][BYTE2(b)]) ^ (ctx->s[0][BYTE3(b)]) \
+)
 
 /* Encryption and decryption Feistel rounds.  Each one calls the two g()
  * macros, does the PHT, and performs the XOR and the appropriate bit
  * rotations.  The parameters are the round number (used to select subkeys),
  * and the four 32-bit chunks of the text. */
 
-#define ENCROUND(n, a, b, c, d) \
-   x = G1 (a); y = G2 (b); \
-   x += y; y += x + ctx->k[2 * (n) + 1]; \
-   (c) ^= x + ctx->k[2 * (n)]; \
-   (c) = ((c) >> 1) + ((c) << 31); \
-   (d) = (((d) << 1)+((d) >> 31)) ^ y
+#define ENCROUND(n, a, b, c, d) { \
+   y = G2 (b); x = y + G1 (a); y += x; \
+   (c) = ror32((c) ^ (x + ctx->k[2 * (n)]), 1); \
+   (d) = rol32((d), 1) ^ (y + ctx->k[2 * (n) + 1]); \
+}
 
-#define DECROUND(n, a, b, c, d) \
-   x = G1 (a); y = G2 (b); \
-   x += y; y += x; \
-   (d) ^= y + ctx->k[2 * (n) + 1]; \
-   (d) = ((d) >> 1) + ((d) << 31); \
-   (c) = (((c) << 1)+((c) >> 31)); \
-   (c) ^= (x + ctx->k[2 * (n)])
+#define DECROUND(n, a, b, c, d) { \
+   y = G2 (b); x = y + G1 (a); y += x; \
+   (d) = ror32((d) ^ (y + ctx->k[2 * (n) + 1]), 1); \
+   (c) = rol32((c), 1) ^ (x + ctx->k[2 * (n)]); \
+}
 
 /* Encryption and decryption cycles; each one is simply two Feistel rounds
  * with the 32-bit chunks re-ordered to simulate the "swap" */
 
-#define ENCCYCLE(n) \
+#define ENCCYCLE(n) { \
    ENCROUND (2 * (n), a, b, c, d); \
-   ENCROUND (2 * (n) + 1, c, d, a, b)
+   ENCROUND (2 * (n) + 1, c, d, a, b); \
+}
 
-#define DECCYCLE(n) \
+#define DECCYCLE(n) { \
    DECROUND (2 * (n) + 1, c, d, a, b); \
-   DECROUND (2 * (n), a, b, c, d)
+   DECROUND (2 * (n), a, b, c, d); \
+}
 
 /* Macros to convert the input and output bytes into 32-bit words,
  * and simultaneously perform the whitening step.  INPACK packs word
@@ -718,84 +725,47 @@ static int twofish_setkey(void *cx, cons
 			CALC_SB256_2( i, calc_sb_tbl[j], calc_sb_tbl[k] );
 		}
 
-		/* Calculate whitening and round subkeys.  The constants are
-		 * indices of subkeys, preprocessed through q0 and q1. */
-		CALC_K256 (w, 0, 0xA9, 0x75, 0x67, 0xF3);
-		CALC_K256 (w, 2, 0xB3, 0xC6, 0xE8, 0xF4);
-		CALC_K256 (w, 4, 0x04, 0xDB, 0xFD, 0x7B);
-		CALC_K256 (w, 6, 0xA3, 0xFB, 0x76, 0xC8);
-		CALC_K256 (k, 0, 0x9A, 0x4A, 0x92, 0xD3);
-		CALC_K256 (k, 2, 0x80, 0xE6, 0x78, 0x6B);
-		CALC_K256 (k, 4, 0xE4, 0x45, 0xDD, 0x7D);
-		CALC_K256 (k, 6, 0xD1, 0xE8, 0x38, 0x4B);
-		CALC_K256 (k, 8, 0x0D, 0xD6, 0xC6, 0x32);
-		CALC_K256 (k, 10, 0x35, 0xD8, 0x98, 0xFD);
-		CALC_K256 (k, 12, 0x18, 0x37, 0xF7, 0x71);
-		CALC_K256 (k, 14, 0xEC, 0xF1, 0x6C, 0xE1);
-		CALC_K256 (k, 16, 0x43, 0x30, 0x75, 0x0F);
-		CALC_K256 (k, 18, 0x37, 0xF8, 0x26, 0x1B);
-		CALC_K256 (k, 20, 0xFA, 0x87, 0x13, 0xFA);
-		CALC_K256 (k, 22, 0x94, 0x06, 0x48, 0x3F);
-		CALC_K256 (k, 24, 0xF2, 0x5E, 0xD0, 0xBA);
-		CALC_K256 (k, 26, 0x8B, 0xAE, 0x30, 0x5B);
-		CALC_K256 (k, 28, 0x84, 0x8A, 0x54, 0x00);
-		CALC_K256 (k, 30, 0xDF, 0xBC, 0x23, 0x9D);
+/* We do not unroll loops with CALC_Knnn macros: this would cost
+** x2.5 code size (+18k on i386) but will give only +7% speed.
+** unrolled: twofish_setkey/sec: 41128
+**     loop: twofish_setkey/sec: 38148
+** CALC_K256: ~100 insns each
+** CALC_K192: ~90 insns
+**    CALC_K: ~70 insns
+*/
+		/* Calculate whitening and round subkeys */
+		for ( i = 0; i < 8; i += 2 ) {
+			CALC_K256 (w, i, q0[i], q1[i], q0[i+1], q1[i+1]);
+		}
+		for ( i = 0; i < 32; i += 2 ) {
+			CALC_K256 (k, i, q0[i+8], q1[i+8], q0[i+9], q1[i+9]);
+		}
 	} else if (key_len == 24) { /* 192-bit key */
 		/* Compute the S-boxes. */
 		for ( i = j = 0, k = 1; i < 256; i++, j += 2, k += 2 ) {
 		        CALC_SB192_2( i, calc_sb_tbl[j], calc_sb_tbl[k] );
 		}
 
-		/* Calculate whitening and round subkeys.  The constants are
-		 * indices of subkeys, preprocessed through q0 and q1. */
-		CALC_K192 (w, 0, 0xA9, 0x75, 0x67, 0xF3);
-		CALC_K192 (w, 2, 0xB3, 0xC6, 0xE8, 0xF4);
-		CALC_K192 (w, 4, 0x04, 0xDB, 0xFD, 0x7B);
-		CALC_K192 (w, 6, 0xA3, 0xFB, 0x76, 0xC8);
-		CALC_K192 (k, 0, 0x9A, 0x4A, 0x92, 0xD3);
-		CALC_K192 (k, 2, 0x80, 0xE6, 0x78, 0x6B);
-		CALC_K192 (k, 4, 0xE4, 0x45, 0xDD, 0x7D);
-		CALC_K192 (k, 6, 0xD1, 0xE8, 0x38, 0x4B);
-		CALC_K192 (k, 8, 0x0D, 0xD6, 0xC6, 0x32);
-		CALC_K192 (k, 10, 0x35, 0xD8, 0x98, 0xFD);
-		CALC_K192 (k, 12, 0x18, 0x37, 0xF7, 0x71);
-		CALC_K192 (k, 14, 0xEC, 0xF1, 0x6C, 0xE1);
-		CALC_K192 (k, 16, 0x43, 0x30, 0x75, 0x0F);
-		CALC_K192 (k, 18, 0x37, 0xF8, 0x26, 0x1B);
-		CALC_K192 (k, 20, 0xFA, 0x87, 0x13, 0xFA);
-		CALC_K192 (k, 22, 0x94, 0x06, 0x48, 0x3F);
-		CALC_K192 (k, 24, 0xF2, 0x5E, 0xD0, 0xBA);
-		CALC_K192 (k, 26, 0x8B, 0xAE, 0x30, 0x5B);
-		CALC_K192 (k, 28, 0x84, 0x8A, 0x54, 0x00);
-		CALC_K192 (k, 30, 0xDF, 0xBC, 0x23, 0x9D);
+		/* Calculate whitening and round subkeys */
+		for ( i = 0; i < 8; i += 2 ) {
+			CALC_K192 (w, i, q0[i], q1[i], q0[i+1], q1[i+1]);
+		}
+		for ( i = 0; i < 32; i += 2 ) {
+			CALC_K192 (k, i, q0[i+8], q1[i+8], q0[i+9], q1[i+9]);
+		}
 	} else { /* 128-bit key */
 		/* Compute the S-boxes. */
 		for ( i = j = 0, k = 1; i < 256; i++, j += 2, k += 2 ) {
 			CALC_SB_2( i, calc_sb_tbl[j], calc_sb_tbl[k] );
 		}
 
-		/* Calculate whitening and round subkeys.  The constants are
-		 * indices of subkeys, preprocessed through q0 and q1. */
-		CALC_K (w, 0, 0xA9, 0x75, 0x67, 0xF3);
-		CALC_K (w, 2, 0xB3, 0xC6, 0xE8, 0xF4);
-		CALC_K (w, 4, 0x04, 0xDB, 0xFD, 0x7B);
-		CALC_K (w, 6, 0xA3, 0xFB, 0x76, 0xC8);
-		CALC_K (k, 0, 0x9A, 0x4A, 0x92, 0xD3);
-		CALC_K (k, 2, 0x80, 0xE6, 0x78, 0x6B);
-		CALC_K (k, 4, 0xE4, 0x45, 0xDD, 0x7D);
-		CALC_K (k, 6, 0xD1, 0xE8, 0x38, 0x4B);
-		CALC_K (k, 8, 0x0D, 0xD6, 0xC6, 0x32);
-		CALC_K (k, 10, 0x35, 0xD8, 0x98, 0xFD);
-		CALC_K (k, 12, 0x18, 0x37, 0xF7, 0x71);
-		CALC_K (k, 14, 0xEC, 0xF1, 0x6C, 0xE1);
-		CALC_K (k, 16, 0x43, 0x30, 0x75, 0x0F);
-		CALC_K (k, 18, 0x37, 0xF8, 0x26, 0x1B);
-		CALC_K (k, 20, 0xFA, 0x87, 0x13, 0xFA);
-		CALC_K (k, 22, 0x94, 0x06, 0x48, 0x3F);
-		CALC_K (k, 24, 0xF2, 0x5E, 0xD0, 0xBA);
-		CALC_K (k, 26, 0x8B, 0xAE, 0x30, 0x5B);
-		CALC_K (k, 28, 0x84, 0x8A, 0x54, 0x00);
-		CALC_K (k, 30, 0xDF, 0xBC, 0x23, 0x9D);
+		/* Calculate whitening and round subkeys */
+		for ( i = 0; i < 8; i += 2 ) {
+			CALC_K (w, i, q0[i], q1[i], q0[i+1], q1[i+1]);
+		}
+		for ( i = 0; i < 32; i += 2 ) {
+			CALC_K (k, i, q0[i+8], q1[i+8], q0[i+9], q1[i+9]);
+		}
 	}
 
 	return 0;
@@ -819,7 +789,7 @@ static void twofish_encrypt(void *cx, u8
 	INPACK (3, d, 3);
 	
 	/* Encryption Feistel cycles. */
-	ENCCYCLE (0);
+	ENCCYCLE (0); /* ~70 insns each */
 	ENCCYCLE (1);
 	ENCCYCLE (2);
 	ENCCYCLE (3);
@@ -854,7 +824,7 @@ static void twofish_decrypt(void *cx, u8
 	INPACK (3, b, 7);
 	
 	/* Encryption Feistel cycles. */
-	DECCYCLE (7);
+	DECCYCLE (7); /* ~70 insns each */
 	DECCYCLE (6);
 	DECCYCLE (5);
 	DECCYCLE (4);

--Boundary-00=_urMaC/MlQ2P/O5w--

