Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWCIDgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWCIDgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWCIDgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:36:13 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:48837 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751527AbWCIDgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:36:12 -0500
Date: Thu, 09 Mar 2006 12:36:08 +0900 (JST)
Message-Id: <20060309.123608.08076793.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, akpm@osdl.org
Subject: [PATCH] crypto: add alignment handling to digest layer
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some hash modules load/store data words directly.  The digest layer
should pass properly aligned buffer to update()/final() method.  This
patch also add cra_alignmask to some hash modules.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 digest.c      |   42 +++++++++++++++++++++++++++---------------
 michael_mic.c |    1 +
 sha1.c        |    1 +
 sha256.c      |    1 +
 sha512.c      |    2 ++
 tgr192.c      |    3 +++
 6 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/crypto/digest.c b/crypto/digest.c
index d9b6ac9..062d0a5 100644
--- a/crypto/digest.c
+++ b/crypto/digest.c
@@ -27,6 +27,7 @@ static void update(struct crypto_tfm *tf
                    struct scatterlist *sg, unsigned int nsg)
 {
 	unsigned int i;
+	unsigned int alignmask = crypto_tfm_alg_alignmask(tfm);
 
 	for (i = 0; i < nsg; i++) {
 
@@ -38,12 +39,24 @@ static void update(struct crypto_tfm *tf
 			unsigned int bytes_from_page = min(l, ((unsigned int)
 							   (PAGE_SIZE)) - 
 							   offset);
-			char *p = crypto_kmap(pg, 0) + offset;
+			char *src = crypto_kmap(pg, 0);
+			char *p = src + offset;
 
+			if (unlikely(offset & alignmask)) {
+				unsigned int bytes =
+					alignmask + 1 - (offset & alignmask);
+				bytes = min(bytes, bytes_from_page);
+				tfm->__crt_alg->cra_digest.dia_update
+						(crypto_tfm_ctx(tfm), p,
+						 bytes);
+				p += bytes;
+				bytes_from_page -= bytes;
+				l -= bytes;
+			}
 			tfm->__crt_alg->cra_digest.dia_update
 					(crypto_tfm_ctx(tfm), p,
 					 bytes_from_page);
-			crypto_kunmap(p, 0);
+			crypto_kunmap(src, 0);
 			crypto_yield(tfm);
 			offset = 0;
 			pg++;
@@ -54,7 +67,15 @@ static void update(struct crypto_tfm *tf
 
 static void final(struct crypto_tfm *tfm, u8 *out)
 {
-	tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
+	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
+	if (unlikely((unsigned long)out & alignmask)) {
+		unsigned int size = crypto_tfm_alg_digestsize(tfm);
+		u8 buffer[size + alignmask];
+		u8 *dst = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
+		tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), dst);
+		memcpy(out, dst, size);
+	} else
+		tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
 }
 
 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
@@ -69,18 +90,9 @@ static int setkey(struct crypto_tfm *tfm
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
-	unsigned int i;
-
-	tfm->crt_digest.dit_init(tfm);
-		
-	for (i = 0; i < nsg; i++) {
-		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
-		tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
-		                                      p, sg[i].length);
-		crypto_kunmap(p, 0);
-		crypto_yield(tfm);
-	}
-	crypto_digest_final(tfm, out);
+	init(tfm);
+	update(tfm, sg, nsg);
+	final(tfm, out);
 }
 
 int crypto_init_digest_flags(struct crypto_tfm *tfm, u32 flags)
diff --git a/crypto/michael_mic.c b/crypto/michael_mic.c
index 4f6ab23..701f859 100644
--- a/crypto/michael_mic.c
+++ b/crypto/michael_mic.c
@@ -145,6 +145,7 @@ static struct crypto_alg michael_mic_alg
 	.cra_blocksize	= 8,
 	.cra_ctxsize	= sizeof(struct michael_mic_ctx),
 	.cra_module	= THIS_MODULE,
+	.cra_alignmask	= 3,
 	.cra_list	= LIST_HEAD_INIT(michael_mic_alg.cra_list),
 	.cra_u		= { .digest = {
 	.dia_digestsize	= 8,
diff --git a/crypto/sha1.c b/crypto/sha1.c
index 21571ed..b96f57d 100644
--- a/crypto/sha1.c
+++ b/crypto/sha1.c
@@ -112,6 +112,7 @@ static struct crypto_alg alg = {
 	.cra_blocksize	=	SHA1_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=	sizeof(struct sha1_ctx),
 	.cra_module	=	THIS_MODULE,
+	.cra_alignmask	=	3,
 	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	SHA1_DIGEST_SIZE,
diff --git a/crypto/sha256.c b/crypto/sha256.c
index 9d5ef67..d62264a 100644
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -313,6 +313,7 @@ static struct crypto_alg alg = {
 	.cra_blocksize	=	SHA256_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=	sizeof(struct sha256_ctx),
 	.cra_module	=	THIS_MODULE,
+	.cra_alignmask	=	3,
 	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	SHA256_DIGEST_SIZE,
diff --git a/crypto/sha512.c b/crypto/sha512.c
index 3e6e939..7dbec4f 100644
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -281,6 +281,7 @@ static struct crypto_alg sha512 = {
         .cra_blocksize  = SHA512_HMAC_BLOCK_SIZE,
         .cra_ctxsize    = sizeof(struct sha512_ctx),
         .cra_module     = THIS_MODULE,
+	.cra_alignmask	= 3,
         .cra_list       = LIST_HEAD_INIT(sha512.cra_list),
         .cra_u          = { .digest = {
                                 .dia_digestsize = SHA512_DIGEST_SIZE,
@@ -295,6 +296,7 @@ static struct crypto_alg sha384 = {
         .cra_flags      = CRYPTO_ALG_TYPE_DIGEST,
         .cra_blocksize  = SHA384_HMAC_BLOCK_SIZE,
         .cra_ctxsize    = sizeof(struct sha512_ctx),
+	.cra_alignmask	= 3,
         .cra_module     = THIS_MODULE,
         .cra_list       = LIST_HEAD_INIT(sha384.cra_list),
         .cra_u          = { .digest = {
diff --git a/crypto/tgr192.c b/crypto/tgr192.c
index 2d8e44f..1eae1bb 100644
--- a/crypto/tgr192.c
+++ b/crypto/tgr192.c
@@ -627,6 +627,7 @@ static struct crypto_alg tgr192 = {
 	.cra_blocksize = TGR192_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct tgr192_ctx),
 	.cra_module = THIS_MODULE,
+	.cra_alignmask = 7,
 	.cra_list = LIST_HEAD_INIT(tgr192.cra_list),
 	.cra_u = {.digest = {
 			     .dia_digestsize = TGR192_DIGEST_SIZE,
@@ -641,6 +642,7 @@ static struct crypto_alg tgr160 = {
 	.cra_blocksize = TGR192_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct tgr192_ctx),
 	.cra_module = THIS_MODULE,
+	.cra_alignmask = 7,
 	.cra_list = LIST_HEAD_INIT(tgr160.cra_list),
 	.cra_u = {.digest = {
 			     .dia_digestsize = TGR160_DIGEST_SIZE,
@@ -655,6 +657,7 @@ static struct crypto_alg tgr128 = {
 	.cra_blocksize = TGR192_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct tgr192_ctx),
 	.cra_module = THIS_MODULE,
+	.cra_alignmask = 7,
 	.cra_list = LIST_HEAD_INIT(tgr128.cra_list),
 	.cra_u = {.digest = {
 			     .dia_digestsize = TGR128_DIGEST_SIZE,
