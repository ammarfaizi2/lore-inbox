Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUCFSsq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 13:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUCFSsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 13:48:46 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:6528 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S261702AbUCFSs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 13:48:29 -0500
Date: Sat, 6 Mar 2004 10:46:23 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040306184623.GB3963@jm.kir.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current Linux crypto API does not seem to have generic mechanism for
adding keyed digest algorithms that are not using HMAC construction.
IEEE 802.11i/WPA uses such an algorithm in TKIP and getting this to
crypto API would be useful in order to be able to share more code of
TKIP implementation.

One straightforward way of adding support for Michael MIC is to add an
optional setkey operation for digest algorithms. The included patch
(against Linux 2.6.4-rc2) does exactly this and also includes an
implementation of Michael MIC. Another option would be to add a new
algorithm type for keyed hash algorithms, but that seemed unnecessary
for this purpose. Is the modification of digest type acceptable way of
adding support for a keyed digest algorithm that does not use HMAC?

The patch includes test vectors for Michael MIC and I have tested this
with the Host AP driver and TKIP. Getting this into crypto API is one of
the first steps in replacing the internal crypto algorithm
implementation in the Host AP driver code and I would appreciate it if
this would be applied to Linux 2.6 tree.



diff -upr linux-2.6.4-rc2.orig/Documentation/crypto/api-intro.txt linux-2.6.4-rc2/Documentation/crypto/api-intro.txt
--- linux-2.6.4-rc2.orig/Documentation/crypto/api-intro.txt	2004-03-05 21:55:12.000000000 -0800
+++ linux-2.6.4-rc2/Documentation/crypto/api-intro.txt	2004-03-05 22:28:38.090693088 -0800
@@ -186,6 +186,7 @@ Original developers of the crypto algori
   Dag Arne Osvik (Serpent)
   Brian Gladman (AES)
   Kartikey Mahendra Bhatt (CAST6)
+  Jouni Malinen (Michael MIC)
 
 SHA1 algorithm contributors:
   Jean-Francois Dive
diff -upr linux-2.6.4-rc2.orig/crypto/Kconfig linux-2.6.4-rc2/crypto/Kconfig
--- linux-2.6.4-rc2.orig/crypto/Kconfig	2004-03-05 22:12:13.347396824 -0800
+++ linux-2.6.4-rc2/crypto/Kconfig	2004-03-05 22:11:00.152524136 -0800
@@ -151,6 +151,15 @@ config CRYPTO_DEFLATE
 	  
 	  You will most probably want this if using IPSec.
 
+config CRYPTO_MICHAEL_MIC
+	tristate "Michael MIC keyed digest algorithm"
+	depends on CRYPTO
+	help
+	  Michael MIC is used for message integrity protection in TKIP
+	  (IEEE 802.11i). This algorithm is required for TKIP, but it
+	  should not be used for other purposes because of the weakness
+	  of the algorithm.
+
 config CRYPTO_TEST
 	tristate "Testing module"
 	depends on CRYPTO
diff -upr linux-2.6.4-rc2.orig/crypto/Makefile linux-2.6.4-rc2/crypto/Makefile
--- linux-2.6.4-rc2.orig/crypto/Makefile	2004-03-05 22:13:30.891608312 -0800
+++ linux-2.6.4-rc2/crypto/Makefile	2004-03-05 22:07:55.211639424 -0800
@@ -22,5 +22,6 @@ obj-$(CONFIG_CRYPTO_AES) += aes.o
 obj-$(CONFIG_CRYPTO_CAST5) += cast5.o
 obj-$(CONFIG_CRYPTO_CAST6) += cast6.o
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
+obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
diff -upr linux-2.6.4-rc2.orig/crypto/digest.c linux-2.6.4-rc2/crypto/digest.c
--- linux-2.6.4-rc2.orig/crypto/digest.c	2004-02-17 19:57:12.000000000 -0800
+++ linux-2.6.4-rc2/crypto/digest.c	2004-03-05 22:18:14.429504000 -0800
@@ -42,6 +42,15 @@ static void final(struct crypto_tfm *tfm
 	tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
 }
 
+static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+{
+	u32 flags;
+	if (tfm->__crt_alg->cra_digest.dia_setkey == NULL)
+		return -1;
+	return tfm->__crt_alg->cra_digest.dia_setkey(crypto_tfm_ctx(tfm),
+						     key, keylen, &flags);
+}
+
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
@@ -72,6 +81,7 @@ int crypto_init_digest_ops(struct crypto
 	ops->dit_update	= update;
 	ops->dit_final	= final;
 	ops->dit_digest	= digest;
+	ops->dit_setkey	= setkey;
 	
 	return crypto_alloc_hmac_block(tfm);
 }
diff -upr linux-2.6.4-rc2.orig/crypto/tcrypt.c linux-2.6.4-rc2/crypto/tcrypt.c
--- linux-2.6.4-rc2.orig/crypto/tcrypt.c	2004-02-17 19:59:11.000000000 -0800
+++ linux-2.6.4-rc2/crypto/tcrypt.c	2004-03-05 22:53:14.400259920 -0800
@@ -112,6 +112,10 @@ test_hash (char * algo, struct hash_test
 		sg[0].length = hash_tv[i].psize;
 
 		crypto_digest_init (tfm);
+		if (tfm->crt_u.digest.dit_setkey) {
+			crypto_digest_setkey (tfm, hash_tv[i].key,
+					      hash_tv[i].ksize);
+		}
 		crypto_digest_update (tfm, sg, 1);
 		crypto_digest_final (tfm, result);
 
@@ -564,6 +568,8 @@ do_test(void)
 		test_hmac("sha1", hmac_sha1_tv_template, HMAC_SHA1_TEST_VECTORS);		
 		test_hmac("sha256", hmac_sha256_tv_template, HMAC_SHA256_TEST_VECTORS);
 #endif		
+
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
 	case 1:
@@ -638,6 +644,10 @@ do_test(void)
 		test_cipher ("cast6", MODE_ECB, DECRYPT, cast6_dec_tv_template, CAST6_DEC_TEST_VECTORS);
 		break;
 
+	case 16:
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
+		break;
+
 #ifdef CONFIG_CRYPTO_HMAC
 	case 100:
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
diff -upr linux-2.6.4-rc2.orig/crypto/tcrypt.h linux-2.6.4-rc2/crypto/tcrypt.h
--- linux-2.6.4-rc2.orig/crypto/tcrypt.h	2004-02-17 19:59:27.000000000 -0800
+++ linux-2.6.4-rc2/crypto/tcrypt.h	2004-03-05 22:53:36.807853448 -0800
@@ -30,6 +30,8 @@ struct hash_testvec {
 	char digest[MAX_DIGEST_SIZE];
 	unsigned char np;
 	unsigned char tap[MAX_TAP];		
+	char key[128]; /* only used with keyed hash algorithms */
+	unsigned char ksize;
 };
 
 struct hmac_testvec {	
@@ -1578,4 +1580,54 @@ struct comp_testvec deflate_decomp_tv_te
 	},
 };
 
+/*
+ * Michael MIC test vectors from IEEE 802.11i
+ */
+#define MICHAEL_MIC_TEST_VECTORS 6
+
+struct hash_testvec michael_mic_tv_template[] =
+{
+	{
+		.key = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+		.ksize = 8,
+		.plaintext = { },
+		.psize = 0,
+		.digest = { 0x82, 0x92, 0x5c, 0x1c, 0xa1, 0xd1, 0x30, 0xb8 }
+	},
+	{
+		.key = { 0x82, 0x92, 0x5c, 0x1c, 0xa1, 0xd1, 0x30, 0xb8 },
+		.ksize = 8,
+		.plaintext = { 'M' },
+		.psize = 1,
+		.digest = { 0x43, 0x47, 0x21, 0xca, 0x40, 0x63, 0x9b, 0x3f }
+	},
+	{
+		.key = { 0x43, 0x47, 0x21, 0xca, 0x40, 0x63, 0x9b, 0x3f },
+		.ksize = 8,
+		.plaintext = { 'M', 'i' },
+		.psize = 2,
+		.digest = { 0xe8, 0xf9, 0xbe, 0xca, 0xe9, 0x7e, 0x5d, 0x29 }
+	},
+	{
+		.key = { 0xe8, 0xf9, 0xbe, 0xca, 0xe9, 0x7e, 0x5d, 0x29 },
+		.ksize = 8,
+		.plaintext = { 'M', 'i', 'c' },
+		.psize = 3,
+		.digest = { 0x90, 0x03, 0x8f, 0xc6, 0xcf, 0x13, 0xc1, 0xdb }
+	},
+	{
+		.key = { 0x90, 0x03, 0x8f, 0xc6, 0xcf, 0x13, 0xc1, 0xdb },
+		.ksize = 8,
+		.plaintext = { 'M', 'i', 'c', 'h' },
+		.psize = 4,
+		.digest = { 0xd5, 0x5e, 0x10, 0x05, 0x10, 0x12, 0x89, 0x86 }
+	},
+	{
+		.key = { 0xd5, 0x5e, 0x10, 0x05, 0x10, 0x12, 0x89, 0x86 },
+		.ksize = 8,
+		.plaintext = { 'M', 'i', 'c', 'h', 'a', 'e', 'l' },
+		.psize = 7,
+		.digest = { 0x0a, 0x94, 0x2b, 0x12, 0x4e, 0xca, 0xa5, 0x46 },
+	}
+};
 #endif	/* _CRYPTO_TCRYPT_H */
diff -upr linux-2.6.4-rc2.orig/include/linux/crypto.h linux-2.6.4-rc2/include/linux/crypto.h
--- linux-2.6.4-rc2.orig/include/linux/crypto.h	2004-02-17 19:57:21.000000000 -0800
+++ linux-2.6.4-rc2/include/linux/crypto.h	2004-03-05 22:15:16.142607728 -0800
@@ -76,6 +76,8 @@ struct digest_alg {
 	void (*dia_init)(void *ctx);
 	void (*dia_update)(void *ctx, const u8 *data, unsigned int len);
 	void (*dia_final)(void *ctx, u8 *out);
+	int (*dia_setkey)(void *ctx, const u8 *key,
+	                  unsigned int keylen, u32 *flags);
 };
 
 struct compress_alg {
@@ -157,6 +159,8 @@ struct digest_tfm {
 	void (*dit_final)(struct crypto_tfm *tfm, u8 *out);
 	void (*dit_digest)(struct crypto_tfm *tfm, struct scatterlist *sg,
 	                   unsigned int nsg, u8 *out);
+	int (*dit_setkey)(struct crypto_tfm *tfm,
+	                  const u8 *key, unsigned int keylen);
 #ifdef CONFIG_CRYPTO_HMAC
 	void *dit_hmac_block;
 #endif
@@ -282,6 +286,15 @@ static inline void crypto_digest_digest(
 	tfm->crt_digest.dit_digest(tfm, sg, nsg, out);
 }
 
+static inline int crypto_digest_setkey(struct crypto_tfm *tfm,
+                                       const u8 *key, unsigned int keylen)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
+	if (tfm->crt_digest.dit_setkey == NULL)
+		return -1;
+	return tfm->crt_digest.dit_setkey(tfm, key, keylen);
+}
+
 static inline int crypto_cipher_setkey(struct crypto_tfm *tfm,
                                        const u8 *key, unsigned int keylen)
 {
--- linux-2.6.4-rc2.orig/crypto/michael_mic.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.4-rc2/crypto/michael_mic.c	2004-03-05 22:07:06.956975248 -0800
@@ -0,0 +1,193 @@
+/*
+ * Cryptographic API
+ *
+ * Michael MIC (IEEE 802.11i/TKIP) keyed digest
+ *
+ * Copyright (c) 2004 Jouni Malinen <jkmaline@cc.hut.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/crypto.h>
+
+
+struct michael_mic_ctx {
+	u8 pending[4];
+	size_t pending_len;
+
+	u32 l, r;
+};
+
+
+static inline u32 rotl(u32 val, int bits)
+{
+	return (val << bits) | (val >> (32 - bits));
+}
+
+
+static inline u32 rotr(u32 val, int bits)
+{
+	return (val >> bits) | (val << (32 - bits));
+}
+
+
+static inline u32 xswap(u32 val)
+{
+	return ((val & 0x00ff00ff) << 8) | ((val & 0xff00ff00) >> 8);
+}
+
+
+#define michael_block(l, r)	\
+do {				\
+	r ^= rotl(l, 17);	\
+	l += r;			\
+	r ^= xswap(l);		\
+	l += r;			\
+	r ^= rotl(l, 3);	\
+	l += r;			\
+	r ^= rotr(l, 2);	\
+	l += r;			\
+} while (0)
+
+
+static inline u32 get_le32(const u8 *p)
+{
+	return p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24);
+}
+
+
+static inline void put_le32(u8 *p, u32 v)
+{
+	p[0] = v;
+	p[1] = v >> 8;
+	p[2] = v >> 16;
+	p[3] = v >> 24;
+}
+
+
+static void michael_init(void *ctx)
+{
+	struct michael_mic_ctx *mctx = ctx;
+	mctx->pending_len = 0;
+}
+
+
+static void michael_update(void *ctx, const u8 *data, unsigned int len)
+{
+	struct michael_mic_ctx *mctx = ctx;
+
+	if (mctx->pending_len) {
+		int flen = 4 - mctx->pending_len;
+		if (flen > len)
+			flen = len;
+		memcpy(&mctx->pending[mctx->pending_len], data, flen);
+		mctx->pending_len += flen;
+		data += flen;
+		len -= flen;
+
+		if (mctx->pending_len < 4)
+			return;
+
+		mctx->l ^= get_le32(mctx->pending);
+		michael_block(mctx->l, mctx->r);
+		mctx->pending_len = 0;
+	}
+
+	while (len >= 4) {
+		mctx->l ^= get_le32(data);
+		michael_block(mctx->l, mctx->r);
+		data += 4;
+		len -= 4;
+	}
+
+	if (len > 0) {
+		mctx->pending_len = len;
+		memcpy(mctx->pending, data, len);
+	}
+}
+
+
+static void michael_final(void *ctx, u8 *out)
+{
+	struct michael_mic_ctx *mctx = ctx;
+	u8 *data = mctx->pending;
+
+	/* Last block and padding (0x5a, 4..7 x 0) */
+	switch (mctx->pending_len) {
+	case 0:
+		mctx->l ^= 0x5a;
+		break;
+	case 1:
+		mctx->l ^= data[0] | 0x5a00;
+		break;
+	case 2:
+		mctx->l ^= data[0] | (data[1] << 8) | 0x5a0000;
+		break;
+	case 3:
+		mctx->l ^= data[0] | (data[1] << 8) | (data[2] << 16) |
+			0x5a000000;
+		break;
+	}
+	michael_block(mctx->l, mctx->r);
+	/* l ^= 0; */
+	michael_block(mctx->l, mctx->r);
+
+	put_le32(out, mctx->l);
+	put_le32(out + 4, mctx->r);
+}
+
+
+static int michael_setkey(void *ctx, const u8 *key, unsigned int keylen,
+			  u32 *flags)
+{
+	struct michael_mic_ctx *mctx = ctx;
+	if (keylen != 8) {
+		if (flags)
+			*flags = CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -1;
+	}
+	mctx->l = get_le32(key);
+	mctx->r = get_le32(key + 4);
+	return 0;
+}
+
+
+static struct crypto_alg michael_mic_alg = {
+	.cra_name	= "michael_mic",
+	.cra_flags	= CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	= 8,
+	.cra_ctxsize	= sizeof(struct michael_mic_ctx),
+	.cra_module	= THIS_MODULE,
+	.cra_list	= LIST_HEAD_INIT(michael_mic_alg.cra_list),
+	.cra_u		= { .digest = {
+	.dia_digestsize	= 8,
+	.dia_init	= michael_init,
+	.dia_update	= michael_update,
+	.dia_final	= michael_final,
+	.dia_setkey	= michael_setkey } }
+};
+
+
+static int __init michael_mic_init(void)
+{
+	return crypto_register_alg(&michael_mic_alg);
+}
+
+
+static void __exit michael_mic_exit(void)
+{
+	crypto_unregister_alg(&michael_mic_alg);
+}
+
+
+module_init(michael_mic_init);
+module_exit(michael_mic_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Michael MIC");
+MODULE_AUTHOR("Jouni Malinen <jkmaline@cc.hut.fi>");



-- 
Jouni Malinen                                            PGP id EFC895FA
