Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUCJFiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUCJFiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:38:14 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:30592
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S262035AbUCJFgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:36:40 -0500
Date: Tue, 9 Mar 2004 21:34:11 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040310053411.GB4346@jm.kir.nu>
References: <20040310034014.GA3739@jm.kir.nu> <Xine.LNX.4.44.0403092318370.29034-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403092318370.29034-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 11:21:03PM -0500, James Morris wrote:

> In both patches, these 'return -1' statements should be -EINVAL, or 
> whatever is appropriate (probably -ENOSYS for this one).

Fixed. The included patch combines changesets for both the setkey
addition and Michael MIC. Please let me know if you want to get these as
separate patch files.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1692, 2004-03-09 21:12:44-08:00, jkmaline@cc.hut.fi
  Fixed the error return value for Michael MIC.

ChangeSet@1.1691, 2004-03-09 21:08:17-08:00, jkmaline@cc.hut.fi
  Fixed error codes in return values of the digest setkey handler.

ChangeSet@1.1690, 2004-03-09 19:17:59-08:00, jkmaline@cc.hut.fi
  Added Michael MIC keyed digest for TKIP (IEEE 802.11i/WPA). This algorithm
  is quite weak due to the requirements for compatibility with old legacy
  wireless LAN hardware that does not have much CPU power. Consequently, this
  should not really be used with anything else than TKIP.
  
  Michael MIC is calculated over the payload of the IEEE 802.11 header which
  makes it easier to add TKIP support for old wireless LAN cards. An additional
  authenticated data area is used (but not send separately) to authenticate
  source and destination addresses.

ChangeSet@1.1689, 2004-03-09 18:54:50-08:00, jkmaline@cc.hut.fi
  Added support for using keyed digest with an optional dit_setkey handler.
  This does not change the behavior of the existing digest algorithms, but
  allows new ones to add setkey handler that can be used to initialize the
  algorithm with a key or seed. setkey is to be called after init, but before
  any of the update call(s).


 Documentation/crypto/api-intro.txt |    1 
 crypto/Kconfig                     |    9 +
 crypto/Makefile                    |    1 
 crypto/digest.c                    |   10 +
 crypto/michael_mic.c               |  193 +++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c                    |   12 ++
 crypto/tcrypt.h                    |   52 +++++++++
 include/linux/crypto.h             |   13 ++
 8 files changed, 290 insertions(+), 1 deletion(-)


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
diff -Nru a/crypto/digest.c b/crypto/digest.c
--- a/crypto/digest.c	Tue Mar  9 21:25:13 2004
+++ b/crypto/digest.c	Tue Mar  9 21:25:13 2004
@@ -42,6 +42,15 @@
 	tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
 }
 
+static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+{
+	u32 flags;
+	if (tfm->__crt_alg->cra_digest.dia_setkey == NULL)
+		return -ENOSYS;
+	return tfm->__crt_alg->cra_digest.dia_setkey(crypto_tfm_ctx(tfm),
+						     key, keylen, &flags);
+}
+
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
@@ -72,6 +81,7 @@
 	ops->dit_update	= update;
 	ops->dit_final	= final;
 	ops->dit_digest	= digest;
+	ops->dit_setkey	= setkey;
 	
 	return crypto_alloc_hmac_block(tfm);
 }
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
@@ -112,6 +112,10 @@
 		sg[0].length = hash_tv[i].psize;
 
 		crypto_digest_init (tfm);
+		if (tfm->crt_u.digest.dit_setkey) {
+			crypto_digest_setkey (tfm, hash_tv[i].key,
+					      hash_tv[i].ksize);
+		}
 		crypto_digest_update (tfm, sg, 1);
 		crypto_digest_final (tfm, result);
 
@@ -568,6 +572,8 @@
 		test_hmac("sha1", hmac_sha1_tv_template, HMAC_SHA1_TEST_VECTORS);		
 		test_hmac("sha256", hmac_sha256_tv_template, HMAC_SHA256_TEST_VECTORS);
 #endif		
+
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
 	case 1:
@@ -645,6 +651,10 @@
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
@@ -30,6 +30,8 @@
 	char digest[MAX_DIGEST_SIZE];
 	unsigned char np;
 	unsigned char tap[MAX_TAP];		
+	char key[128]; /* only used with keyed hash algorithms */
+	unsigned char ksize;
 };
 
 struct hmac_testvec {	
@@ -1719,4 +1721,54 @@
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
diff -Nru a/include/linux/crypto.h b/include/linux/crypto.h
--- a/include/linux/crypto.h	Tue Mar  9 21:25:13 2004
+++ b/include/linux/crypto.h	Tue Mar  9 21:25:13 2004
@@ -76,6 +76,8 @@
 	void (*dia_init)(void *ctx);
 	void (*dia_update)(void *ctx, const u8 *data, unsigned int len);
 	void (*dia_final)(void *ctx, u8 *out);
+	int (*dia_setkey)(void *ctx, const u8 *key,
+	                  unsigned int keylen, u32 *flags);
 };
 
 struct compress_alg {
@@ -157,6 +159,8 @@
 	void (*dit_final)(struct crypto_tfm *tfm, u8 *out);
 	void (*dit_digest)(struct crypto_tfm *tfm, struct scatterlist *sg,
 	                   unsigned int nsg, u8 *out);
+	int (*dit_setkey)(struct crypto_tfm *tfm,
+	                  const u8 *key, unsigned int keylen);
 #ifdef CONFIG_CRYPTO_HMAC
 	void *dit_hmac_block;
 #endif
@@ -280,6 +284,15 @@
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
 	tfm->crt_digest.dit_digest(tfm, sg, nsg, out);
+}
+
+static inline int crypto_digest_setkey(struct crypto_tfm *tfm,
+                                       const u8 *key, unsigned int keylen)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
+	if (tfm->crt_digest.dit_setkey == NULL)
+		return -ENOSYS;
+	return tfm->crt_digest.dit_setkey(tfm, key, keylen);
 }
 
 static inline int crypto_cipher_setkey(struct crypto_tfm *tfm,

===================================================================


This BitKeeper patch contains the following changesets:
1.1688..
## Wrapped with gzip_uu ##


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
)/Y!&5#P>0P  
 

-- 
Jouni Malinen                                            PGP id EFC895FA
