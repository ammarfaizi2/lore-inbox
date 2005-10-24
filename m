Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVJXR6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVJXR6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJXR6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:58:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18928 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751207AbVJXR6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:58:10 -0400
Date: Mon, 24 Oct 2005 13:57:52 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/5] crypto/sha1.c: move related code together
In-reply-to: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510241357110.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The final length buffer construction in sha1_final() is moved just before
where it is used. This makes for slightly more readable code and actually
more efficient as well since the compiler doesn't have to bother preserving
the bits array across the first call to sha1_update(). In fact it makes for
slightly smaller stack usage on i386 or slightly smaller code size on ARM
(depending on your GCC version that could vary of course).

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/crypto/sha1.c
===================================================================
--- linux-2.6.orig/crypto/sha1.c
+++ linux-2.6/crypto/sha1.c
@@ -76,11 +76,17 @@
 {
 	struct sha1_ctx *sctx = ctx;
 	u32 i, j, index, padlen;
-	u64 t;
-	u8 bits[8] = { 0, };
+	u64 t, count = sctx->count;
+	u8 bits[8];
 	static const u8 padding[64] = { 0x80, };
 
-	t = sctx->count << 3;
+	/* Pad out to 56 mod 64 */
+	index = count & 0x3f;
+	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
+	sha1_update(sctx, padding, padlen);
+
+	/* Append length */
+	t = count << 3;
 	bits[7] = 0xff & t; t>>=8;
 	bits[6] = 0xff & t; t>>=8;
 	bits[5] = 0xff & t; t>>=8;
@@ -89,13 +95,6 @@
 	bits[2] = 0xff & t; t>>=8;
 	bits[1] = 0xff & t; t>>=8;
 	bits[0] = 0xff & t;
-
-	/* Pad out to 56 mod 64 */
-	index = sctx->count & 0x3f;
-	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
-	sha1_update(sctx, padding, padlen);
-
-	/* Append length */
 	sha1_update(sctx, bits, sizeof bits); 
 
 	/* Store state in digest */
