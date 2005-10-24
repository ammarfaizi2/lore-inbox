Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVJXR4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVJXR4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJXR4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:56:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8166 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751197AbVJXR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:56:21 -0400
Date: Mon, 24 Oct 2005 13:56:06 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/5] crypto/sha1.c: avoid useless memcpy()
In-reply-to: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510241355030.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current code unconditionally copy the first block for every call to
sha1_update().  This can be avoided if there is no pending partial block.
This is always the case on the first call to sha1_update() (if the length
is >= 64 of course0.

In the case where sha1_update() is called successively with len=64,
a 8.5% performance increase can be observed on i386, and 8.2% on ARm.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/crypto/sha1.c
===================================================================
--- linux-2.6.orig/crypto/sha1.c
+++ linux-2.6/crypto/sha1.c
@@ -48,23 +48,26 @@
 static void sha1_update(void *ctx, const u8 *data, unsigned int len)
 {
 	struct sha1_ctx *sctx = ctx;
-	unsigned int i, j;
+	unsigned int partial, done;
 	u32 temp[SHA_WORKSPACE_WORDS];
 
-	j = (sctx->count >> 3) & 0x3f;
+	partial = (sctx->count >> 3) & 0x3f;
 	sctx->count += len << 3;
+	done = 0;
 
-	if ((j + len) > 63) {
-		memcpy(&sctx->buffer[j], data, (i = 64-j));
-		sha_transform(sctx->state, sctx->buffer, temp);
-		for ( ; i + 63 < len; i += 64) {
-			sha_transform(sctx->state, &data[i], temp);
+	if ((partial + len) > 63) {
+		if (partial) {
+			done = 64 - partial;
+			memcpy(sctx->buffer + partial, data, done);
+			sha_transform(sctx->state, sctx->buffer, temp);
+			partial = 0;
 		}
-		j = 0;
+		for ( ; done + 63 < len; done += 64)
+			sha_transform(sctx->state, data + done, temp);
 	}
-	else i = 0;
+	if (len - done)
+		memcpy(sctx->buffer + partial, data + done, len - done);
 	memset(temp, 0, sizeof(temp));
-	memcpy(&sctx->buffer[j], &data[i], len - i);
 }
 
 
