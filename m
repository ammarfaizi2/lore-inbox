Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWALRPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWALRPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWALRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:15:30 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61368 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751447AbWALRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:15:28 -0500
Date: Thu, 12 Jan 2006 18:14:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/13] s390: sha256 crypto code fix.
Message-ID: <20060112171451.GE16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 4/13] s390: sha256 crypto code fix.

Fix processing of messages larger than 2 * SHA256_BLOCK_SIZE.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/sha256_s390.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/arch/s390/crypto/sha256_s390.c linux-2.6-patched/arch/s390/crypto/sha256_s390.c
--- linux-2.6/arch/s390/crypto/sha256_s390.c	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/sha256_s390.c	2006-01-12 15:43:54.000000000 +0100
@@ -51,6 +51,7 @@ static void sha256_update(void *ctx, con
 {
 	struct s390_sha256_ctx *sctx = ctx;
 	unsigned int index;
+	int ret;
 
 	/* how much is already in the buffer? */
 	index = sctx->count / 8 & 0x3f;
@@ -58,15 +59,29 @@ static void sha256_update(void *ctx, con
 	/* update message bit length */
 	sctx->count += len * 8;
 
-	/* process one block */
-	if ((index + len) >= SHA256_BLOCK_SIZE) {
+	if ((index + len) < SHA256_BLOCK_SIZE)
+		goto store;
+
+	/* process one stored block */
+	if (index) {
 		memcpy(sctx->buf + index, data, SHA256_BLOCK_SIZE - index);
-		crypt_s390_kimd(KIMD_SHA_256, sctx->state, sctx->buf,
-				SHA256_BLOCK_SIZE);
+		ret = crypt_s390_kimd(KIMD_SHA_256, sctx->state, sctx->buf,
+				      SHA256_BLOCK_SIZE);
+		BUG_ON(ret != SHA256_BLOCK_SIZE);
 		data += SHA256_BLOCK_SIZE - index;
 		len -= SHA256_BLOCK_SIZE - index;
 	}
 
+	/* process as many blocks as possible */
+	if (len >= SHA256_BLOCK_SIZE) {
+		ret = crypt_s390_kimd(KIMD_SHA_256, sctx->state, data,
+				      len & ~(SHA256_BLOCK_SIZE - 1));
+		BUG_ON(ret != (len & ~(SHA256_BLOCK_SIZE - 1)));
+		data += ret;
+		len -= ret;
+	}
+
+store:
 	/* anything left? */
 	if (len)
 		memcpy(sctx->buf + index , data, len);
@@ -119,9 +134,9 @@ static struct crypto_alg alg = {
 	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	SHA256_DIGEST_SIZE,
-	.dia_init   	= 	sha256_init,
-	.dia_update 	=	sha256_update,
-	.dia_final  	=	sha256_final } }
+	.dia_init	=	sha256_init,
+	.dia_update	=	sha256_update,
+	.dia_final	=	sha256_final } }
 };
 
 static int init(void)
