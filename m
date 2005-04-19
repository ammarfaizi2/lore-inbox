Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVDSGX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDSGX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDSGX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:23:27 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:37637 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261334AbVDSGW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:22:28 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sha512: replace open-coded be64 conversions
Date: Tue, 19 Apr 2005 09:21:34 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uNKZC5QbjnCd98x"
Message-Id: <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_uNKZC5QbjnCd98x
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This + next patch were "modprobe tcrypt" tested.
See next mail.
--
vda

--Boundary-00=_uNKZC5QbjnCd98x
Content-Type: text/x-diff;
  charset="koi8-r";
  name="1.be.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1.be.patch"

diff -urpN 2.6.12-rc2.0.orig/crypto/sha512.c 2.6.12-rc2.1.be/crypto/sha512.c
--- 2.6.12-rc2.0.orig/crypto/sha512.c	Tue Apr 19 00:20:12 2005
+++ 2.6.12-rc2.1.be/crypto/sha512.c	Mon Apr 18 23:31:54 2005
@@ -105,7 +105,7 @@ static const u64 sha512_K[80] = {
 
 static inline void LOAD_OP(int I, u64 *W, const u8 *input)
 {
-	W[I] = __be64_to_cpu( ((__be64*)(input))[I] );
+	W[I] = __be64_to_cpu( ((__be64*)input)[I] );
 }
 
 static inline void BLEND_OP(int I, u64 *W)
@@ -124,9 +124,8 @@ sha512_transform(u64 *state, u64 *W, con
         for (i = 0; i < 16; i++)
                 LOAD_OP(i, W, input);
 
-        for (i = 16; i < 80; i++) {
+        for (i = 16; i < 80; i++)
                 BLEND_OP(i, W);
-        }
 
 	/* load the state into our registers */
 	a=state[0];   b=state[1];   c=state[2];   d=state[3];  
@@ -238,36 +237,17 @@ sha512_final(void *ctx, u8 *hash)
 	
         static u8 padding[128] = { 0x80, };
 
-        u32 t;
-	u64 t2;
         u8 bits[128];
 	unsigned int index, pad_len;
-	int i, j;
+	int i;
 
-        index = pad_len = t = i = j = 0;
-        t2 = 0;
+	index = pad_len = i = 0;
 
 	/* Save number of bits */
-	t = sctx->count[0];
-	bits[15] = t; t>>=8;
-	bits[14] = t; t>>=8;
-	bits[13] = t; t>>=8;
-	bits[12] = t; 
-	t = sctx->count[1];
-	bits[11] = t; t>>=8;
-	bits[10] = t; t>>=8;
-	bits[9 ] = t; t>>=8;
-	bits[8 ] = t; 
-	t = sctx->count[2];
-	bits[7 ] = t; t>>=8;
-	bits[6 ] = t; t>>=8;
-	bits[5 ] = t; t>>=8;
-	bits[4 ] = t; 
-	t = sctx->count[3];
-	bits[3 ] = t; t>>=8;
-	bits[2 ] = t; t>>=8;
-	bits[1 ] = t; t>>=8;
-	bits[0 ] = t; 
+	((__be32*)bits)[3] = __cpu_to_be32(sctx->count[0]);
+	((__be32*)bits)[2] = __cpu_to_be32(sctx->count[1]);
+	((__be32*)bits)[1] = __cpu_to_be32(sctx->count[2]);
+	((__be32*)bits)[0] = __cpu_to_be32(sctx->count[3]);
 
 	/* Pad out to 112 mod 128. */
 	index = (sctx->count[0] >> 3) & 0x7f;
@@ -278,17 +258,8 @@ sha512_final(void *ctx, u8 *hash)
 	sha512_update(sctx, bits, 16);
 
 	/* Store state in digest */
-	for (i = j = 0; i < 8; i++, j += 8) {
-		t2 = sctx->state[i];
-		hash[j+7] = (char)t2 & 0xff; t2>>=8;
-		hash[j+6] = (char)t2 & 0xff; t2>>=8;
-		hash[j+5] = (char)t2 & 0xff; t2>>=8;
-		hash[j+4] = (char)t2 & 0xff; t2>>=8;
-		hash[j+3] = (char)t2 & 0xff; t2>>=8;
-		hash[j+2] = (char)t2 & 0xff; t2>>=8;
-		hash[j+1] = (char)t2 & 0xff; t2>>=8;
-		hash[j  ] = (char)t2 & 0xff;
-	}
+	for (i = 0; i < 8; i++)
+		((__be64*)hash)[i] = __cpu_to_be64(sctx->state[i]);
 	
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(struct sha512_ctx));

--Boundary-00=_uNKZC5QbjnCd98x--

