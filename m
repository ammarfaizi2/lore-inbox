Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264720AbUEJOmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbUEJOmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264715AbUEJOmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:42:35 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:31106 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264722AbUEJOkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:40:20 -0400
Date: Mon, 10 May 2004 16:40:18 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Support for VIA PadLock crypto engine
Message-ID: <Pine.LNX.4.53.0405101628080.27527@maxipes.logix.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the second part of the patch that enables use of the hardware
cryptography engine in VIA C3 Nehemiah CPUs (so called PadLock ACE)
for AES algorithm.

It adds two new config options in the Cryptography section and if
these are selected, aes.ko is built with the support for PadLock ACE.
It can always be disabled with 'disable_via_padlock=1' module option
in this case, or if the PadLock is not found in the CPU, aes.ko
reverts to the software encryption.

 Kconfig |   20 ++++
 aes.c   |  296 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 307 insertions(+), 9 deletions(-)

Please apply.

Michal Ludvig

diff -urp linux-2.6.5.patched/crypto/Kconfig linux-2.6.5/crypto/Kconfig
--- linux-2.6.5.patched/crypto/Kconfig	2004-04-29 10:33:05.000000000 +0200
+++ linux-2.6.5/crypto/Kconfig	2004-05-10 09:03:47.000000000 +0200
@@ -9,6 +9,19 @@ config CRYPTO
 	help
 	  This option provides the core Cryptographic API.

+config CRYPTO_VIA_PADLOCK
+	bool "Support for VIA PadLock ACE"
+	depends on CRYPTO && X86 && !X86_64
+	help
+	  Some VIA processors come with an integrated crypto engine
+	  (so called VIA PadLock ACE, Advanced Cryptography Engine)
+	  that provides instructions for very fast {en,de}cryption
+	  with some algorithms.
+
+	  The instructions are used only when the CPU supports them.
+	  Otherwise software encryption is used. If you are unsure,
+	  say Y.
+
 config CRYPTO_HMAC
 	bool "HMAC support"
 	depends on CRYPTO
@@ -126,6 +139,13 @@ config CRYPTO_AES

 	  See http://csrc.nist.gov/CryptoToolkit/aes/ for more information.

+config CRYPTO_AES_PADLOCK
+	bool "Support for AES in VIA PadLock"
+	depends on CRYPTO_AES && CRYPTO_VIA_PADLOCK
+	default y
+	help
+	  Use VIA PadLock for AES algorithm.
+
 config CRYPTO_CAST5
 	tristate "CAST5 (CAST-128) cipher algorithm"
 	depends on CRYPTO
diff -urp linux-2.6.5.patched/crypto/aes.c linux-2.6.5/crypto/aes.c
--- linux-2.6.5.patched/crypto/aes.c	2004-04-29 10:33:05.000000000 +0200
+++ linux-2.6.5/crypto/aes.c	2004-05-10 15:20:14.808278600 +0200
@@ -10,6 +10,7 @@
  *  Herbert Valerio Riedel <hvr@hvrlab.org>
  *  Kyle McMartin <kyle@debian.org>
  *  Adam J. Richter <adam@yggdrasil.com> (conversion to 2.5 API).
+ *  Michal Ludvig <mludvig@suse.cz> (support for VIA PadLock)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,10 +60,18 @@
 #include <linux/crypto.h>
 #include <asm/byteorder.h>

-#define AES_MIN_KEY_SIZE	16
-#define AES_MAX_KEY_SIZE	32
-
-#define AES_BLOCK_SIZE		16
+#define AES_MIN_KEY_SIZE	16	/* in u8 units */
+#define AES_MAX_KEY_SIZE	32	/* ditto */
+#define AES_BLOCK_SIZE		16	/* ditto */
+#define AES_EXTENDED_KEY_SIZE	64	/* in u32 units */
+#define AES_EXTENDED_KEY_SIZE_B	(AES_EXTENDED_KEY_SIZE * sizeof(u32))
+
+#define PFX	"aes: "
+
+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	static u8 use_padlock;
+	static inline int padlock_hw_extkey_available (u8 key_len);
+#endif

 static inline
 u32 generic_rotr32 (const u32 x, const unsigned bits)
@@ -94,9 +103,11 @@ byte(const u32 x, const unsigned n)
 #define u32_out(to, from) (*(u32 *)(to) = cpu_to_le32(from))

 struct aes_ctx {
+	u32 e_data[AES_EXTENDED_KEY_SIZE+4];
+	u32 d_data[AES_EXTENDED_KEY_SIZE+4];
 	int key_length;
-	u32 E[60];
-	u32 D[60];
+	u32 *E;
+	u32 *D;
 };

 #define E_KEY ctx->E
@@ -274,6 +285,10 @@ aes_set_key(void *ctx_arg, const u8 *in_
 {
 	struct aes_ctx *ctx = ctx_arg;
 	u32 i, t, u, v, w;
+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	u32 P[AES_EXTENDED_KEY_SIZE];
+	u32 rounds;
+#endif

 	if (key_len != 16 && key_len != 24 && key_len != 32) {
 		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
@@ -282,11 +297,31 @@ aes_set_key(void *ctx_arg, const u8 *in_

 	ctx->key_length = key_len;

+	ctx->E = ctx->e_data;
+	ctx->D = ctx->d_data;
+
+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	if (use_padlock) {
+		/* Ensure 16-Bytes alignmentation of keys for VIA PadLock. */
+		if ((int)(ctx->e_data) & 0x0F)
+			ctx->E += 4 - (((int)(ctx->e_data) & 0x0F) / sizeof (ctx->e_data[0]));
+
+		if ((int)(ctx->d_data) & 0x0F)
+			ctx->D += 4 - (((int)(ctx->d_data) & 0x0F) / sizeof (ctx->d_data[0]));
+	}
+#endif
+
 	E_KEY[0] = u32_in (in_key);
 	E_KEY[1] = u32_in (in_key + 4);
 	E_KEY[2] = u32_in (in_key + 8);
 	E_KEY[3] = u32_in (in_key + 12);

+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	/* Don't generate extended keys if the hardware can do it. */
+	if (use_padlock && padlock_hw_extkey_available(key_len))
+		return 0;
+#endif
+
 	switch (key_len) {
 	case 16:
 		t = E_KEY[3];
@@ -320,6 +355,27 @@ aes_set_key(void *ctx_arg, const u8 *in_
 		imix_col (D_KEY[i], E_KEY[i]);
 	}

+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	if (use_padlock) {
+		/* PadLock needs a different format of the decryption key. */
+		rounds = 10 + (key_len - 16) / 4;
+
+		for (i = 0; i < rounds; i++) {
+			P[((i + 1) * 4) + 0] = D_KEY[((rounds - i - 1) * 4) + 0];
+			P[((i + 1) * 4) + 1] = D_KEY[((rounds - i - 1) * 4) + 1];
+			P[((i + 1) * 4) + 2] = D_KEY[((rounds - i - 1) * 4) + 2];
+			P[((i + 1) * 4) + 3] = D_KEY[((rounds - i - 1) * 4) + 3];
+		}
+
+		P[0] = E_KEY[(rounds * 4) + 0];
+		P[1] = E_KEY[(rounds * 4) + 1];
+		P[2] = E_KEY[(rounds * 4) + 2];
+		P[3] = E_KEY[(rounds * 4) + 3];
+
+		memcpy(D_KEY, P, AES_EXTENDED_KEY_SIZE_B);
+	}
+#endif
+
 	return 0;
 }

@@ -338,7 +394,7 @@ aes_set_key(void *ctx_arg, const u8 *in_
     f_rl(bo, bi, 2, k);     \
     f_rl(bo, bi, 3, k)

-static void aes_encrypt(void *ctx_arg, u8 *out, const u8 *in)
+static void aes_encrypt_sw(void *ctx_arg, u8 *out, const u8 *in)
 {
 	const struct aes_ctx *ctx = ctx_arg;
 	u32 b0[4], b1[4];
@@ -391,7 +447,7 @@ static void aes_encrypt(void *ctx_arg, u
     i_rl(bo, bi, 2, k);     \
     i_rl(bo, bi, 3, k)

-static void aes_decrypt(void *ctx_arg, u8 *out, const u8 *in)
+static void aes_decrypt_sw(void *ctx_arg, u8 *out, const u8 *in)
 {
 	const struct aes_ctx *ctx = ctx_arg;
 	u32 b0[4], b1[4];
@@ -430,6 +486,198 @@ static void aes_decrypt(void *ctx_arg, u
 	u32_out (out + 12, b0[3]);
 }

+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+/*
+ * Support for VIA PadLock hardware crypto engine.
+ */
+
+/* Control word. */
+union cword {
+	u32 cword[4];
+	struct {
+		int rounds:4;
+		int algo:3;
+		int keygen:1;
+		int interm:1;
+		int encdec:1;
+		int ksize:2;
+	} b;
+};
+
+typedef void (xcrypt_t)(u8 *input, u8 *output, u8 *key, u8 *iv,
+			void *control_word, u32 count);
+
+/* Tells whether the ACE is capable to generate
+   the extended key for a given key_len. */
+static inline int padlock_hw_extkey_available(u8 key_len)
+{
+	/* TODO: We should check the actual CPU model/stepping
+	         as it's likely that the capability will be
+	         added in the next CPU revisions. */
+	if (key_len == 16)
+		return 1;
+	return 0;
+}
+
+static inline void padlock_xcrypt_ecb(u8 *input, u8 *output, u8 *key,
+				      u8 *iv, void *control_word, u32 count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xc8"	/* rep xcryptecb */
+		      : "=m"(*output), "+S"(input), "+D"(output)
+		      : "d"(control_word), "b"(key), "c"(count));
+}
+
+static inline void padlock_xcrypt_cbc(u8 *input, u8 *output, u8 *key,
+				      u8 *iv, void *control_word, u32 count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xd0"	/* rep xcryptcbc */
+		      : "=m"(*output), "+S"(input), "+D"(output)
+		      : "d"(control_word), "b"(key), "c"(count), "a"(iv));
+}
+
+static inline void padlock_xcrypt_cfb(u8 *input, u8 *output, u8 *key,
+				      u8 *iv, void *control_word, u32 count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xe0"	/* rep xcryptcfb */
+		      : "=m"(*output), "+S"(input), "+D"(output)
+		      : "d"(control_word), "b"(key), "c"(count), "a"(iv));
+}
+
+static inline void padlock_xcrypt_ofb(u8 *input, u8 *output, u8 *key,
+				      u8 *iv, void *control_word, u32 count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xe8"	/* rep xcryptofb */
+		      : "=m"(*output), "+S"(input), "+D"(output)
+		      : "d"(control_word), "b"(key), "c"(count), "a"(iv));
+}
+
+static void aes_padlock(void *ctx_arg, u8 *out_arg, const u8 *in_arg,
+			const u8 *iv_arg, size_t nbytes, int encdec,
+			xcrypt_t xcrypt_func)
+{
+	/* Don't blindly modify this structure - the items must
+	   fit on 16-Bytes boundaries! */
+	struct padlock_xcrypt_data {
+		u8 iv[AES_BLOCK_SIZE];		/* Initialization vector */
+		union cword cword;		/* Control word */
+	};
+
+	u8 *in, *out, *iv;
+	void *key;
+	void *index = NULL;
+	struct aes_ctx *ctx = ctx_arg;
+	char bigbuf[sizeof(struct padlock_xcrypt_data) + 16];
+	struct padlock_xcrypt_data *data;
+
+	/* Place 'data' at the first 16-Bytes aligned address in 'bigbuf'. */
+	if (((long)bigbuf) & 0x0F)
+		data = (void*)(bigbuf + 16 - ((long)bigbuf & 0x0F));
+	else
+		data = (void*)bigbuf;
+
+	if (((long)in_arg) & 0x0F) {
+		in = crypto_aligned_kmalloc(nbytes, GFP_KERNEL, 16, &index);
+		memcpy(in, in_arg, nbytes);
+	}
+	else
+		in = (u8*)in_arg;
+
+	if (((long)out_arg) & 0x0F) {
+		if (index)
+			out = in;	/* xcrypt can work "in place" */
+		else
+			out = crypto_aligned_kmalloc(nbytes, GFP_KERNEL, 16, &index);
+	}
+	else
+		out = out_arg;
+
+	/* Always make a local copy of IV - xcrypt may change it! */
+	iv = data->iv;
+	if (iv_arg)
+		memcpy(iv, iv_arg, AES_BLOCK_SIZE);
+
+	/* Prepare Control word. */
+	memset (&data->cword, 0, sizeof(union cword));
+	data->cword.b.encdec = !encdec;	/* in the rest of cryptoapi ENC=1/DEC=0 */
+	data->cword.b.rounds = 10 + (ctx->key_length - 16) / 4;
+	data->cword.b.ksize = (ctx->key_length - 16) / 8;
+
+	/* Is the hardware capable to generate the extended key? */
+	if (!padlock_hw_extkey_available(ctx->key_length))
+		data->cword.b.keygen = 1;
+
+	/* ctx->E starts with a plain key - if the hardware is capable
+	   to generate the extended key itself we must supply
+	   the plain key for both Encryption and Decryption. */
+	if (encdec == CRYPTO_DIR_ENCRYPT || data->cword.b.keygen == 0)
+		key = ctx->E;
+	else
+		key = ctx->D;
+
+	(xcrypt_func)(in, out, key, iv, &data->cword, nbytes/16);
+
+	/* Copy the 16-Byte aligned output to the caller's buffer. */
+	if (out != out_arg)
+		memcpy(out_arg, out, nbytes);
+
+	if (index)
+		kfree(index);
+}
+
+static void aes_padlock_ecb(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, NULL, nbytes, encdec,
+		    padlock_xcrypt_ecb);
+}
+
+static void aes_padlock_cbc(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    padlock_xcrypt_cbc);
+}
+
+static void aes_padlock_cfb(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    padlock_xcrypt_cfb);
+}
+
+static void aes_padlock_ofb(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    padlock_xcrypt_ofb);
+}
+#endif
+
+static void aes_encrypt(void *ctx_arg, u8 *out, const u8 *in)
+{
+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	if (use_padlock)
+		aes_padlock(ctx_arg, out, in, NULL, AES_BLOCK_SIZE,
+			    CRYPTO_DIR_ENCRYPT, padlock_xcrypt_ecb);
+	else
+#endif
+		aes_encrypt_sw(ctx_arg, out, in);
+}
+
+static void aes_decrypt(void *ctx_arg, u8 *out, const u8 *in)
+{
+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	if (use_padlock)
+		aes_padlock (ctx_arg, out, in, NULL, AES_BLOCK_SIZE,
+			     CRYPTO_DIR_DECRYPT, padlock_xcrypt_ecb);
+	else
+#endif
+		aes_decrypt_sw (ctx_arg, out, in);
+}

 static struct crypto_alg aes_alg = {
 	.cra_name		=	"aes",
@@ -449,8 +697,39 @@ static struct crypto_alg aes_alg = {
 	}
 };

+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+static int disable_via_padlock = 0;
+MODULE_PARM(disable_via_padlock, "i");
+MODULE_PARM_DESC(disable_via_padlock,
+		 "Disable use of VIA PadLock crypto engine even if it was available.");
+static int disable_multiblock = 0;
+MODULE_PARM(disable_multiblock, "i");
+MODULE_PARM_DESC(disable_multiblock,
+		 "Disable encryption of whole multiblock buffers.");
+#endif
+
 static int __init aes_init(void)
 {
+#ifdef CONFIG_CRYPTO_AES_PADLOCK
+	if (!disable_via_padlock)
+		use_padlock = cpu_has_xstore_enabled;
+	if (use_padlock) {
+		if (!disable_multiblock) {
+			aes_alg.cra_u.cipher.cia_max_nbytes = (size_t)-1;
+			aes_alg.cra_u.cipher.cia_req_align  = 16;
+			aes_alg.cra_u.cipher.cia_ecb        = aes_padlock_ecb;
+			aes_alg.cra_u.cipher.cia_cbc        = aes_padlock_cbc;
+			aes_alg.cra_u.cipher.cia_cfb        = aes_padlock_cfb;
+			aes_alg.cra_u.cipher.cia_ofb        = aes_padlock_ofb;
+		}
+		printk(KERN_NOTICE PFX
+			"Using VIA PadLock ACE for AES algorithm%s.\n",
+			disable_multiblock ? "" : " (multiblock)");
+	} else if (cpu_has_xstore_enabled)
+		printk(KERN_NOTICE PFX "VIA PadLock ACE is available but not used.\n");
+	else
+		printk(KERN_NOTICE PFX "Using software AES.\n");
+#endif
 	gen_tabs();
 	return crypto_register_alg(&aes_alg);
 }
@@ -465,4 +744,3 @@ module_exit(aes_fini);

 MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
 MODULE_LICENSE("Dual BSD/GPL");
-

