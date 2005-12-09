Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVLIP1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVLIP1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLIP1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:27:00 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:31423 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932340AbVLIP0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:26:48 -0500
Date: Fri, 9 Dec 2005 16:26:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 8/17] s390: sha256 support.
Message-ID: <20051209152636.GI6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 8/17] s390: sha256 support.

Add support for the hardware accelerated sha256 crypto algorithm.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/Makefile           |    1 
 arch/s390/crypto/crypt_s390.h       |    2 
 arch/s390/crypto/crypt_s390_query.c |    6 +
 arch/s390/crypto/sha256_s390.c      |  151 ++++++++++++++++++++++++++++++++++++
 arch/s390/defconfig                 |    1 
 crypto/Kconfig                      |   11 ++
 6 files changed, 171 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/crypto/crypt_s390.h linux-2.6-patched/arch/s390/crypto/crypt_s390.h
--- linux-2.6/arch/s390/crypto/crypt_s390.h	2005-12-09 14:25:09.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390.h	2005-12-09 14:25:09.000000000 +0100
@@ -61,6 +61,7 @@ enum crypt_s390_kmc_func {
 enum crypt_s390_kimd_func {
 	KIMD_QUERY   = CRYPT_S390_KIMD | 0,
 	KIMD_SHA_1   = CRYPT_S390_KIMD | 1,
+	KIMD_SHA_256 = CRYPT_S390_KIMD | 2,
 };
 
 /* function codes for KLMD (COMPUTE LAST MESSAGE DIGEST)
@@ -69,6 +70,7 @@ enum crypt_s390_kimd_func {
 enum crypt_s390_klmd_func {
 	KLMD_QUERY   = CRYPT_S390_KLMD | 0,
 	KLMD_SHA_1   = CRYPT_S390_KLMD | 1,
+	KLMD_SHA_256 = CRYPT_S390_KLMD | 2,
 };
 
 /* function codes for KMAC (COMPUTE MESSAGE AUTHENTICATION CODE)
diff -urpN linux-2.6/arch/s390/crypto/crypt_s390_query.c linux-2.6-patched/arch/s390/crypto/crypt_s390_query.c
--- linux-2.6/arch/s390/crypto/crypt_s390_query.c	2005-12-09 14:25:09.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390_query.c	2005-12-09 14:25:09.000000000 +0100
@@ -48,16 +48,20 @@ static void query_available_functions(vo
 		crypt_s390_func_available(KIMD_QUERY));
 	printk(KERN_INFO "KIMD_SHA_1: %d\n",
 		crypt_s390_func_available(KIMD_SHA_1));
+	printk(KERN_INFO "KIMD_SHA_256: %d\n",
+		crypt_s390_func_available(KIMD_SHA_256));
 
 	/* query available KLMD functions */
 	printk(KERN_INFO "KLMD_QUERY: %d\n",
 		crypt_s390_func_available(KLMD_QUERY));
 	printk(KERN_INFO "KLMD_SHA_1: %d\n",
 		crypt_s390_func_available(KLMD_SHA_1));
+	printk(KERN_INFO "KLMD_SHA_256: %d\n",
+		crypt_s390_func_available(KLMD_SHA_256));
 
 	/* query available KMAC functions */
 	printk(KERN_INFO "KMAC_QUERY: %d\n",
-		crypt_s3990_func_available(KMAC_QUERY));
+		crypt_s390_func_available(KMAC_QUERY));
 	printk(KERN_INFO "KMAC_DEA: %d\n",
 		crypt_s390_func_available(KMAC_DEA));
 	printk(KERN_INFO "KMAC_TDEA_128: %d\n",
diff -urpN linux-2.6/arch/s390/crypto/Makefile linux-2.6-patched/arch/s390/crypto/Makefile
--- linux-2.6/arch/s390/crypto/Makefile	2005-12-09 14:25:09.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/Makefile	2005-12-09 14:25:09.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_CRYPTO_SHA1_S390) += sha1_s390.o
+obj-$(CONFIG_CRYPTO_SHA256_S390) += sha256_s390.o
 obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o des_check_key.o
 
 obj-$(CONFIG_CRYPTO_TEST) += crypt_s390_query.o
diff -urpN linux-2.6/arch/s390/crypto/sha256_s390.c linux-2.6-patched/arch/s390/crypto/sha256_s390.c
--- linux-2.6/arch/s390/crypto/sha256_s390.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/sha256_s390.c	2005-12-09 14:25:09.000000000 +0100
@@ -0,0 +1,151 @@
+/*
+ * Cryptographic API.
+ *
+ * s390 implementation of the SHA256 Secure Hash Algorithm.
+ *
+ * s390 Version:
+ *   Copyright (C) 2005 IBM Deutschland GmbH, IBM Corporation
+ *   Author(s): Jan Glauber (jang@de.ibm.com)
+ *
+ * Derived from "crypto/sha256.c"
+ * and "arch/s390/crypto/sha1_s390.c"
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/crypto.h>
+
+#include "crypt_s390.h"
+
+#define SHA256_DIGEST_SIZE	32
+#define SHA256_BLOCK_SIZE	64
+
+struct s390_sha256_ctx {
+	u64 count;
+	u32 state[8];
+	u8 buf[2 * SHA256_BLOCK_SIZE];
+};
+
+static void sha256_init(void *ctx)
+{
+	struct s390_sha256_ctx *sctx = ctx;
+
+	sctx->state[0] = 0x6a09e667;
+	sctx->state[1] = 0xbb67ae85;
+	sctx->state[2] = 0x3c6ef372;
+	sctx->state[3] = 0xa54ff53a;
+	sctx->state[4] = 0x510e527f;
+	sctx->state[5] = 0x9b05688c;
+	sctx->state[6] = 0x1f83d9ab;
+	sctx->state[7] = 0x5be0cd19;
+	sctx->count = 0;
+	memset(sctx->buf, 0, sizeof(sctx->buf));
+}
+
+static void sha256_update(void *ctx, const u8 *data, unsigned int len)
+{
+	struct s390_sha256_ctx *sctx = ctx;
+	unsigned int index;
+
+	/* how much is already in the buffer? */
+	index = sctx->count / 8 & 0x3f;
+
+	/* update message bit length */
+	sctx->count += len * 8;
+
+	/* process one block */
+	if ((index + len) >= SHA256_BLOCK_SIZE) {
+		memcpy(sctx->buf + index, data, SHA256_BLOCK_SIZE - index);
+		crypt_s390_kimd(KIMD_SHA_256, sctx->state, sctx->buf,
+				SHA256_BLOCK_SIZE);
+		data += SHA256_BLOCK_SIZE - index;
+		len -= SHA256_BLOCK_SIZE - index;
+	}
+
+	/* anything left? */
+	if (len)
+		memcpy(sctx->buf + index , data, len);
+}
+
+static void pad_message(struct s390_sha256_ctx* sctx)
+{
+	int index, end;
+
+	index = sctx->count / 8 & 0x3f;
+	end = index < 56 ? SHA256_BLOCK_SIZE : 2 * SHA256_BLOCK_SIZE;
+
+	/* start pad with 1 */
+	sctx->buf[index] = 0x80;
+
+	/* pad with zeros */
+	index++;
+	memset(sctx->buf + index, 0x00, end - index - 8);
+
+	/* append message length */
+	memcpy(sctx->buf + end - 8, &sctx->count, sizeof sctx->count);
+
+	sctx->count = end * 8;
+}
+
+/* Add padding and return the message digest */
+static void sha256_final(void* ctx, u8 *out)
+{
+	struct s390_sha256_ctx *sctx = ctx;
+
+	/* must perform manual padding */
+	pad_message(sctx);
+
+	crypt_s390_kimd(KIMD_SHA_256, sctx->state, sctx->buf,
+			sctx->count / 8);
+
+	/* copy digest to out */
+	memcpy(out, sctx->state, SHA256_DIGEST_SIZE);
+
+	/* wipe context */
+	memset(sctx, 0, sizeof *sctx);
+}
+
+static struct crypto_alg alg = {
+	.cra_name	=	"sha256",
+	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	=	SHA256_BLOCK_SIZE,
+	.cra_ctxsize	=	sizeof(struct s390_sha256_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{ .digest = {
+	.dia_digestsize	=	SHA256_DIGEST_SIZE,
+	.dia_init   	= 	sha256_init,
+	.dia_update 	=	sha256_update,
+	.dia_final  	=	sha256_final } }
+};
+
+static int init(void)
+{
+	int ret;
+
+	if (!crypt_s390_func_available(KIMD_SHA_256))
+		return -ENOSYS;
+
+	ret = crypto_register_alg(&alg);
+	if (ret != 0)
+		printk(KERN_INFO "crypt_s390: sha256_s390 couldn't be loaded.");
+	return ret;
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_ALIAS("sha256");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA256 Secure Hash Algorithm");
diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-12-09 14:25:09.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-12-09 14:25:18.000000000 +0100
@@ -634,6 +634,7 @@ CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA1_S390 is not set
 # CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA256_S390 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
diff -urpN linux-2.6/crypto/Kconfig linux-2.6-patched/crypto/Kconfig
--- linux-2.6/crypto/Kconfig	2005-12-09 14:25:09.000000000 +0100
+++ linux-2.6-patched/crypto/Kconfig	2005-12-09 14:25:09.000000000 +0100
@@ -44,6 +44,7 @@ config CRYPTO_SHA1_S390
 	tristate "SHA1 digest algorithm (s390)"
 	depends on CRYPTO && ARCH_S390
 	help
+	  This is the s390 hardware accelerated implementation of the
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
 config CRYPTO_SHA256
@@ -55,6 +56,16 @@ config CRYPTO_SHA256
 	  This version of SHA implements a 256 bit hash with 128 bits of
 	  security against collision attacks.
 
+config CRYPTO_SHA256_S390
+	tristate "SHA256 digest algorithm (s390)"
+	depends on CRYPTO && ARCH_S390
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA256 secure hash standard (DFIPS 180-2).
+
+	  This version of SHA implements a 256 bit hash with 128 bits of
+	  security against collision attacks.
+
 config CRYPTO_SHA512
 	tristate "SHA384 and SHA512 digest algorithms"
 	depends on CRYPTO
