Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWHFKpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWHFKpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 06:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWHFKpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 06:45:20 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:55301 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932538AbWHFKpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 06:45:19 -0400
Date: Sun, 6 Aug 2006 20:45:16 +1000
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CRYPTO] api: Fixed crypto_tfm context alignment
Message-ID: <20060806104516.GA30043@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

[CRYPTO] api: Fixed crypto_tfm context alignment

Previously the __aligned__ attribute was added to the crypto_tfm context
member to ensure it is alinged correctly on architectures such as arm.
Unfortunately kmalloc does not use the same minimum alignment rules as
gcc so this is useless.

This patch changes it to use kmalloc's minimum alignment.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 7f94624..5e2ff73 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -21,8 +21,9 @@ #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/slab.h>
 #include <linux/string.h>
-#include <asm/page.h>
+#include <linux/uaccess.h>
 
 /*
  * Algorithm masks and types.
@@ -61,6 +62,14 @@ #define CRYPTO_MAX_ALG_NAME		64
 #define CRYPTO_DIR_ENCRYPT		1
 #define CRYPTO_DIR_DECRYPT		0
 
+#if defined(ARCH_KMALLOC_MINALIGN)
+#define CRYPTO_MINALIGN_ATTR __attribute__ ((ARCH_KMALLOC_MINALIGN))
+#elif defined(ARCH_SLAB_MINALIGN)
+#define CRYPTO_MINALIGN_ATTR __attribute__ ((ARCH_SLAB_MINALIGN))
+#else
+#define CRYPTO_MINALIGN_ATTR
+#endif
+
 struct scatterlist;
 struct crypto_tfm;
 
@@ -231,7 +240,7 @@ struct crypto_tfm {
 	
 	struct crypto_alg *__crt_alg;
 
-	char __crt_ctx[] __attribute__ ((__aligned__));
+	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
 /* 
