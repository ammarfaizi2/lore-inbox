Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVJXSEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVJXSEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJXSEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:04:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36903 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751212AbVJXSEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:04:00 -0400
Date: Mon, 24 Oct 2005 14:03:59 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/5] crypto/sha1.c: final cleanup
In-reply-to: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510241403310.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We don't need j nor t2.  Simplify the code a bit by reusing t and
incrementing the 'out' pointer (it is a bit easier on the compiler
as it reduce register pressure).

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/crypto/sha1.c
===================================================================
--- linux-2.6.orig/crypto/sha1.c
+++ linux-2.6/crypto/sha1.c
@@ -76,7 +76,7 @@
 {
 	struct sha1_ctx *sctx = ctx;
 	u64 count = sctx->count;
-	u32 i, j, index, padlen, t;
+	u32 i, index, padlen, t;
 	u8 bits[8];
 	static const u8 padding[64] = { 0x80, };
 
@@ -99,12 +99,13 @@
 	sha1_update(sctx, bits, sizeof bits); 
 
 	/* Store state in digest */
-	for (i = j = 0; i < 5; i++, j += 4) {
-		u32 t2 = sctx->state[i];
-		out[j+3] = t2 & 0xff; t2>>=8;
-		out[j+2] = t2 & 0xff; t2>>=8;
-		out[j+1] = t2 & 0xff; t2>>=8;
-		out[j  ] = t2 & 0xff;
+	for (i = 0; i < 5; i++) {
+		t = sctx->state[i];
+		out[3] = t & 0xff; t>>=8;
+		out[2] = t & 0xff; t>>=8;
+		out[1] = t & 0xff; t>>=8;
+		out[0] = t & 0xff;
+		out += 4;
 	}
 
 	/* Wipe context */
