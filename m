Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWALROq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWALROq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWALROp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:14:45 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:40109 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751436AbWALROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:14:44 -0500
Date: Thu, 12 Jan 2006 18:14:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/13] s390: des crypto code cleanup.
Message-ID: <20060112171404.GB16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 1/13] s390: des crypto code cleanup.

Beautify the s390 in-kernel-crypto des code.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/des_s390.c |  155 +++++++++++++++++++-------------------------
 1 files changed, 67 insertions(+), 88 deletions(-)

diff -urpN linux-2.6/arch/s390/crypto/des_s390.c linux-2.6-patched/arch/s390/crypto/des_s390.c
--- linux-2.6/arch/s390/crypto/des_s390.c	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/des_s390.c	2006-01-12 15:43:51.000000000 +0100
@@ -15,10 +15,8 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/errno.h>
-#include <asm/scatterlist.h>
 #include <linux/crypto.h>
+
 #include "crypt_s390.h"
 #include "crypto_des.h"
 
@@ -46,37 +44,30 @@ struct crypt_s390_des3_192_ctx {
 	u8 key[DES3_192_KEY_SIZE];
 };
 
-static int
-des_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int des_setkey(void *ctx, const u8 *key, unsigned int keylen,
+		      u32 *flags)
 {
-	struct crypt_s390_des_ctx *dctx;
+	struct crypt_s390_des_ctx *dctx = ctx;
 	int ret;
 
-	dctx = ctx;
-	//test if key is valid (not a weak key)
+	/* test if key is valid (not a weak key) */
 	ret = crypto_des_check_key(key, keylen, flags);
-	if (ret == 0){
+	if (ret == 0)
 		memcpy(dctx->key, key, keylen);
-	}
 	return ret;
 }
 
-
-static void
-des_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des_ctx *dctx;
+	struct crypt_s390_des_ctx *dctx = ctx;
 
-	dctx = ctx;
 	crypt_s390_km(KM_DEA_ENCRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
 }
 
-static void
-des_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des_ctx *dctx;
+	struct crypt_s390_des_ctx *dctx = ctx;
 
-	dctx = ctx;
 	crypt_s390_km(KM_DEA_DECRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
 }
 
@@ -87,12 +78,15 @@ static struct crypto_alg des_alg = {
 	.cra_ctxsize		=	sizeof(struct crypt_s390_des_ctx),
 	.cra_module		=	THIS_MODULE,
 	.cra_list		=	LIST_HEAD_INIT(des_alg.cra_list),
-	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	DES_KEY_SIZE,
-	.cia_max_keysize	=	DES_KEY_SIZE,
-	.cia_setkey		= 	des_setkey,
-	.cia_encrypt		=	des_encrypt,
-	.cia_decrypt		=	des_decrypt } }
+	.cra_u			=	{
+		.cipher = {
+			.cia_min_keysize	=	DES_KEY_SIZE,
+			.cia_max_keysize	=	DES_KEY_SIZE,
+			.cia_setkey		=	des_setkey,
+			.cia_encrypt		=	des_encrypt,
+			.cia_decrypt		=	des_decrypt
+		}
+	}
 };
 
 /*
@@ -107,20 +101,18 @@ static struct crypto_alg des_alg = {
  *   Implementers MUST reject keys that exhibit this property.
  *
  */
-static int
-des3_128_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int des3_128_setkey(void *ctx, const u8 *key, unsigned int keylen,
+			   u32 *flags)
 {
 	int i, ret;
-	struct crypt_s390_des3_128_ctx *dctx;
+	struct crypt_s390_des3_128_ctx *dctx = ctx;
 	const u8* temp_key = key;
 
-	dctx = ctx;
 	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE))) {
-
 		*flags |= CRYPTO_TFM_RES_BAD_KEY_SCHED;
 		return -EINVAL;
 	}
-	for (i = 0; i < 2; i++,	temp_key += DES_KEY_SIZE) {
+	for (i = 0; i < 2; i++, temp_key += DES_KEY_SIZE) {
 		ret = crypto_des_check_key(temp_key, DES_KEY_SIZE, flags);
 		if (ret < 0)
 			return ret;
@@ -129,24 +121,20 @@ des3_128_setkey(void *ctx, const u8 *key
 	return 0;
 }
 
-static void
-des3_128_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_128_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_128_ctx *dctx;
+	struct crypt_s390_des3_128_ctx *dctx = ctx;
 
-	dctx = ctx;
 	crypt_s390_km(KM_TDEA_128_ENCRYPT, dctx->key, dst, (void*)src,
-			DES3_128_BLOCK_SIZE);
+		      DES3_128_BLOCK_SIZE);
 }
 
-static void
-des3_128_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_128_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_128_ctx *dctx;
+	struct crypt_s390_des3_128_ctx *dctx = ctx;
 
-	dctx = ctx;
 	crypt_s390_km(KM_TDEA_128_DECRYPT, dctx->key, dst, (void*)src,
-			DES3_128_BLOCK_SIZE);
+		      DES3_128_BLOCK_SIZE);
 }
 
 static struct crypto_alg des3_128_alg = {
@@ -156,12 +144,15 @@ static struct crypto_alg des3_128_alg = 
 	.cra_ctxsize		=	sizeof(struct crypt_s390_des3_128_ctx),
 	.cra_module		=	THIS_MODULE,
 	.cra_list		=	LIST_HEAD_INIT(des3_128_alg.cra_list),
-	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	DES3_128_KEY_SIZE,
-	.cia_max_keysize	=	DES3_128_KEY_SIZE,
-	.cia_setkey		= 	des3_128_setkey,
-	.cia_encrypt		=	des3_128_encrypt,
-	.cia_decrypt		=	des3_128_decrypt } }
+	.cra_u			=	{
+		.cipher = {
+			.cia_min_keysize	=	DES3_128_KEY_SIZE,
+			.cia_max_keysize	=	DES3_128_KEY_SIZE,
+			.cia_setkey		=	des3_128_setkey,
+			.cia_encrypt		=	des3_128_encrypt,
+			.cia_decrypt		=	des3_128_decrypt
+		}
+	}
 };
 
 /*
@@ -177,50 +168,43 @@ static struct crypto_alg des3_128_alg = 
  *   property.
  *
  */
-static int
-des3_192_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int des3_192_setkey(void *ctx, const u8 *key, unsigned int keylen,
+			   u32 *flags)
 {
 	int i, ret;
-	struct crypt_s390_des3_192_ctx *dctx;
-	const u8* temp_key;
+	struct crypt_s390_des3_192_ctx *dctx = ctx;
+	const u8* temp_key = key;
 
-	dctx = ctx;
-	temp_key = key;
 	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) &&
 	    memcmp(&key[DES_KEY_SIZE], &key[DES_KEY_SIZE * 2],
-	    					DES_KEY_SIZE))) {
+		   DES_KEY_SIZE))) {
 
 		*flags |= CRYPTO_TFM_RES_BAD_KEY_SCHED;
 		return -EINVAL;
 	}
 	for (i = 0; i < 3; i++, temp_key += DES_KEY_SIZE) {
 		ret = crypto_des_check_key(temp_key, DES_KEY_SIZE, flags);
-		if (ret < 0){
+		if (ret < 0)
 			return ret;
-		}
 	}
 	memcpy(dctx->key, key, keylen);
 	return 0;
 }
 
-static void
-des3_192_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_192_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_192_ctx *dctx;
+	struct crypt_s390_des3_192_ctx *dctx = ctx;
 
-	dctx = ctx;
 	crypt_s390_km(KM_TDEA_192_ENCRYPT, dctx->key, dst, (void*)src,
-			DES3_192_BLOCK_SIZE);
+		      DES3_192_BLOCK_SIZE);
 }
 
-static void
-des3_192_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_192_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_192_ctx *dctx;
+	struct crypt_s390_des3_192_ctx *dctx = ctx;
 
-	dctx = ctx;
 	crypt_s390_km(KM_TDEA_192_DECRYPT, dctx->key, dst, (void*)src,
-			DES3_192_BLOCK_SIZE);
+		      DES3_192_BLOCK_SIZE);
 }
 
 static struct crypto_alg des3_192_alg = {
@@ -230,44 +214,39 @@ static struct crypto_alg des3_192_alg = 
 	.cra_ctxsize		=	sizeof(struct crypt_s390_des3_192_ctx),
 	.cra_module		=	THIS_MODULE,
 	.cra_list		=	LIST_HEAD_INIT(des3_192_alg.cra_list),
-	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	DES3_192_KEY_SIZE,
-	.cia_max_keysize	=	DES3_192_KEY_SIZE,
-	.cia_setkey		= 	des3_192_setkey,
-	.cia_encrypt		=	des3_192_encrypt,
-	.cia_decrypt		=	des3_192_decrypt } }
+	.cra_u			=	{
+		.cipher = {
+			.cia_min_keysize	=	DES3_192_KEY_SIZE,
+			.cia_max_keysize	=	DES3_192_KEY_SIZE,
+			.cia_setkey		=	des3_192_setkey,
+			.cia_encrypt		=	des3_192_encrypt,
+			.cia_decrypt		=	des3_192_decrypt
+		}
+	}
 };
 
-
-
-static int
-init(void)
+static int init(void)
 {
-	int ret;
+	int ret = 0;
 
 	if (!crypt_s390_func_available(KM_DEA_ENCRYPT) ||
 	    !crypt_s390_func_available(KM_TDEA_128_ENCRYPT) ||
-	    !crypt_s390_func_available(KM_TDEA_192_ENCRYPT)){
+	    !crypt_s390_func_available(KM_TDEA_192_ENCRYPT))
 		return -ENOSYS;
-	}
 
-	ret = 0;
-	ret |= (crypto_register_alg(&des_alg) == 0)? 0:1;
-	ret |= (crypto_register_alg(&des3_128_alg) == 0)? 0:2;
-	ret |= (crypto_register_alg(&des3_192_alg) == 0)? 0:4;
-	if (ret){
+	ret |= (crypto_register_alg(&des_alg) == 0) ? 0:1;
+	ret |= (crypto_register_alg(&des3_128_alg) == 0) ? 0:2;
+	ret |= (crypto_register_alg(&des3_192_alg) == 0) ? 0:4;
+	if (ret) {
 		crypto_unregister_alg(&des3_192_alg);
 		crypto_unregister_alg(&des3_128_alg);
 		crypto_unregister_alg(&des_alg);
 		return -EEXIST;
 	}
-
-	printk(KERN_INFO "crypt_s390: des_s390 loaded.\n");
 	return 0;
 }
 
-static void __exit
-fini(void)
+static void __exit fini(void)
 {
 	crypto_unregister_alg(&des3_192_alg);
 	crypto_unregister_alg(&des3_128_alg);
