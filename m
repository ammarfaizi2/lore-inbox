Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUCKGOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUCKGOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:14:31 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:4992 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S261698AbUCKGOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:14:05 -0500
Date: Wed, 10 Mar 2004 22:11:36 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040311061136.GB3739@jm.kir.nu>
References: <20040311030035.GA3782@jm.kir.nu> <Xine.LNX.4.44.0403102302450.935-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403102302450.935-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Michael MIC part of the previous combined patch. This
requires the digest setkey patch from my previous email.



Added Michael MIC keyed digest for TKIP (IEEE 802.11i/WPA). This algorithm
is quite weak due to the requirements for compatibility with old legacy
wireless LAN hardware that does not have much CPU power. Consequently, this
should not really be used with anything else than TKIP.
  
Michael MIC is calculated over the payload of the IEEE 802.11 header which
makes it easier to add TKIP support for old wireless LAN cards. An additional
authenticated data area is used (but not send separately) to authenticate
source and destination addresses.



diff -Nru a/Documentation/crypto/api-intro.txt b/Documentation/crypto/api-intro.txt
--- a/Documentation/crypto/api-intro.txt	Tue Mar  9 21:25:13 2004
+++ b/Documentation/crypto/api-intro.txt	Tue Mar  9 21:25:13 2004
@@ -187,6 +187,7 @@
   Brian Gladman (AES)
   Kartikey Mahendra Bhatt (CAST6)
   Jon Oberheide (ARC4)
+  Jouni Malinen (Michael MIC)
 
 SHA1 algorithm contributors:
   Jean-Francois Dive
diff -Nru a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig	Tue Mar  9 21:25:13 2004
+++ b/crypto/Kconfig	Tue Mar  9 21:25:13 2004
@@ -161,6 +161,15 @@
 	  
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
diff -Nru a/crypto/Makefile b/crypto/Makefile
--- a/crypto/Makefile	Tue Mar  9 21:25:13 2004
+++ b/crypto/Makefile	Tue Mar  9 21:25:13 2004
@@ -23,5 +23,6 @@
 obj-$(CONFIG_CRYPTO_CAST6) += cast6.o
 obj-$(CONFIG_CRYPTO_ARC4) += arc4.o
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
+obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
diff -Nru a/crypto/michael_mic.c b/crypto/michael_mic.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/crypto/michael_mic.c	Tue Mar  9 21:25:13 2004
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
+		return -EINVAL;
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
diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	Tue Mar  9 21:25:13 2004
+++ b/crypto/tcrypt.c	Tue Mar  9 21:25:13 2004
@@ -61,7 +61,7 @@
 static char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
-	"arc4", "deflate", NULL
+	"arc4", "michael_mic", "deflate", NULL
 };
 
 static void
@@ -572,6 +576,8 @@
 		test_hmac("sha1", hmac_sha1_tv_template, HMAC_SHA1_TEST_VECTORS);		
 		test_hmac("sha256", hmac_sha256_tv_template, HMAC_SHA256_TEST_VECTORS);
 #endif		
+
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
 	case 1:
@@ -649,6 +655,10 @@
 	case 16:
 		test_cipher ("arc4", MODE_ECB, ENCRYPT, arc4_enc_tv_template, ARC4_ENC_TEST_VECTORS);
 		test_cipher ("arc4", MODE_ECB, DECRYPT, arc4_dec_tv_template, ARC4_DEC_TEST_VECTORS);
+		break;
+
+	case 17:
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
 #ifdef CONFIG_CRYPTO_HMAC
diff -Nru a/crypto/tcrypt.h b/crypto/tcrypt.h
--- a/crypto/tcrypt.h	Tue Mar  9 21:25:13 2004
+++ b/crypto/tcrypt.h	Tue Mar  9 21:25:13 2004
@@ -1721,4 +1723,54 @@
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


-- 
Jouni Malinen                                            PGP id EFC895FA
