Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264830AbUEKR1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUEKR1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUEKR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:27:16 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:48832 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264903AbUEKQ4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:56:55 -0400
Date: Tue, 11 May 2004 18:56:54 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0405111854180.10474@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second patch - now the PadLock-specific part.

Michal Ludvig

diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/Kconfig linux-2.6.5/crypto/Kconfig
--- linux-2.6.5.patched/crypto/Kconfig	2004-04-29 10:33:05.000000000 +0200
+++ linux-2.6.5/crypto/Kconfig	2004-05-11 08:34:32.000000000 +0200
@@ -176,5 +176,6 @@ config CRYPTO_TEST
 	help
 	  Quick & dirty crypto test module.

+source "crypto/devices/Kconfig"
 endmenu

diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/Makefile linux-2.6.5/crypto/Makefile
--- linux-2.6.5.patched/crypto/Makefile	2004-04-29 10:33:05.000000000 +0200
+++ linux-2.6.5/crypto/Makefile	2004-05-11 08:34:49.000000000 +0200
@@ -26,3 +26,5 @@ obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o

 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
+
+obj-y += devices/
diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/devices/Kconfig linux-2.6.5/crypto/devices/Kconfig
--- linux-2.6.5.patched/crypto/devices/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5/crypto/devices/Kconfig	2004-05-11 10:59:16.000000000 +0200
@@ -0,0 +1,23 @@
+menu "Hardware crypto devices"
+
+config CRYPTO_DEV_PADLOCK
+	tristate "Support for VIA PadLock ACE"
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
+config CRYPTO_DEV_PADLOCK_AES
+	bool "Support for AES in VIA PadLock"
+	depends on CRYPTO_DEV_PADLOCK
+	default y
+	help
+	  Use VIA PadLock for AES algorithm.
+
+endmenu
diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/devices/Makefile linux-2.6.5/crypto/devices/Makefile
--- linux-2.6.5.patched/crypto/devices/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5/crypto/devices/Makefile	2004-05-11 10:59:33.000000000 +0200
@@ -0,0 +1,7 @@
+
+obj-$(CONFIG_CRYPTO_DEV_PADLOCK) += padlock.o
+
+padlock-objs-$(CONFIG_CRYPTO_DEV_PADLOCK_AES) += padlock-aes.o
+
+padlock-objs := padlock-generic.o $(padlock-objs-y)
+
diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/devices/padlock-aes.c linux-2.6.5/crypto/devices/padlock-aes.c
--- linux-2.6.5.patched/crypto/devices/padlock-aes.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5/crypto/devices/padlock-aes.c	2004-05-11 15:08:39.000000000 +0200
@@ -0,0 +1,493 @@
+/*
+ * Cryptographic API.
+ *
+ * Support for VIA PadLock hardware crypto engine.
+ *
+ * Linux developers:
+ *  Michal Ludvig <mludvig@suse.cz>
+ *
+ * Key expansion routine taken from crypto/aes.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * ---------------------------------------------------------------------------
+ * Copyright (c) 2002, Dr Brian Gladman <brg@gladman.me.uk>, Worcester, UK.
+ * All rights reserved.
+ *
+ * LICENSE TERMS
+ *
+ * The free distribution and use of this software in both source and binary
+ * form is allowed (with or without changes) provided that:
+ *
+ *   1. distributions of this source code include the above copyright
+ *      notice, this list of conditions and the following disclaimer;
+ *
+ *   2. distributions in binary form include the above copyright
+ *      notice, this list of conditions and the following disclaimer
+ *      in the documentation and/or other associated materials;
+ *
+ *   3. the copyright holder's name is not used to endorse products
+ *      built using this software without specific written permission.
+ *
+ * ALTERNATIVELY, provided that this notice is retained in full, this product
+ * may be distributed under the terms of the GNU General Public License (GPL),
+ * in which case the provisions of the GPL apply INSTEAD OF those given above.
+ *
+ * DISCLAIMER
+ *
+ * This software is provided 'as is' with no explicit or implied warranties
+ * in respect of its properties, including, but not limited to, correctness
+ * and/or fitness for purpose.
+ * ---------------------------------------------------------------------------
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/crypto.h>
+#include <asm/byteorder.h>
+#include "padlock.h"
+
+#define AES_MIN_KEY_SIZE	16	/* in u8 units */
+#define AES_MAX_KEY_SIZE	32	/* ditto */
+#define AES_BLOCK_SIZE		16	/* ditto */
+#define AES_EXTENDED_KEY_SIZE	64	/* in u32 units */
+#define AES_EXTENDED_KEY_SIZE_B	(AES_EXTENDED_KEY_SIZE * sizeof(u32))
+
+static inline int aes_hw_extkey_available (u8 key_len);
+
+static inline
+u32 generic_rotr32 (const u32 x, const unsigned bits)
+{
+	const unsigned n = bits % 32;
+	return (x >> n) | (x << (32 - n));
+}
+
+static inline
+u32 generic_rotl32 (const u32 x, const unsigned bits)
+{
+	const unsigned n = bits % 32;
+	return (x << n) | (x >> (32 - n));
+}
+
+#define rotl generic_rotl32
+#define rotr generic_rotr32
+
+/*
+ * #define byte(x, nr) ((unsigned char)((x) >> (nr*8)))
+ */
+inline static u8
+byte(const u32 x, const unsigned n)
+{
+	return x >> (n << 3);
+}
+
+#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
+#define u32_out(to, from) (*(u32 *)(to) = cpu_to_le32(from))
+
+struct aes_ctx {
+	u32 e_data[AES_EXTENDED_KEY_SIZE+4];
+	u32 d_data[AES_EXTENDED_KEY_SIZE+4];
+	int key_length;
+	u32 *E;
+	u32 *D;
+};
+
+#define E_KEY ctx->E
+#define D_KEY ctx->D
+
+static u8 pow_tab[256];
+static u8 log_tab[256];
+static u8 sbx_tab[256];
+static u8 isb_tab[256];
+static u32 rco_tab[10];
+static u32 ft_tab[4][256];
+static u32 it_tab[4][256];
+
+static u32 fl_tab[4][256];
+static u32 il_tab[4][256];
+
+static inline u8
+f_mult (u8 a, u8 b)
+{
+	u8 aa = log_tab[a], cc = aa + log_tab[b];
+
+	return pow_tab[cc + (cc < aa ? 1 : 0)];
+}
+
+#define ff_mult(a,b)    (a && b ? f_mult(a, b) : 0)
+
+#define f_rn(bo, bi, n, k)					\
+    bo[n] =  ft_tab[0][byte(bi[n],0)] ^				\
+             ft_tab[1][byte(bi[(n + 1) & 3],1)] ^		\
+             ft_tab[2][byte(bi[(n + 2) & 3],2)] ^		\
+             ft_tab[3][byte(bi[(n + 3) & 3],3)] ^ *(k + n)
+
+#define i_rn(bo, bi, n, k)					\
+    bo[n] =  it_tab[0][byte(bi[n],0)] ^				\
+             it_tab[1][byte(bi[(n + 3) & 3],1)] ^		\
+             it_tab[2][byte(bi[(n + 2) & 3],2)] ^		\
+             it_tab[3][byte(bi[(n + 1) & 3],3)] ^ *(k + n)
+
+#define ls_box(x)				\
+    ( fl_tab[0][byte(x, 0)] ^			\
+      fl_tab[1][byte(x, 1)] ^			\
+      fl_tab[2][byte(x, 2)] ^			\
+      fl_tab[3][byte(x, 3)] )
+
+#define f_rl(bo, bi, n, k)					\
+    bo[n] =  fl_tab[0][byte(bi[n],0)] ^				\
+             fl_tab[1][byte(bi[(n + 1) & 3],1)] ^		\
+             fl_tab[2][byte(bi[(n + 2) & 3],2)] ^		\
+             fl_tab[3][byte(bi[(n + 3) & 3],3)] ^ *(k + n)
+
+#define i_rl(bo, bi, n, k)					\
+    bo[n] =  il_tab[0][byte(bi[n],0)] ^				\
+             il_tab[1][byte(bi[(n + 3) & 3],1)] ^		\
+             il_tab[2][byte(bi[(n + 2) & 3],2)] ^		\
+             il_tab[3][byte(bi[(n + 1) & 3],3)] ^ *(k + n)
+
+static void
+gen_tabs (void)
+{
+	u32 i, t;
+	u8 p, q;
+
+	/* log and power tables for GF(2**8) finite field with
+	   0x011b as modular polynomial - the simplest prmitive
+	   root is 0x03, used here to generate the tables */
+
+	for (i = 0, p = 1; i < 256; ++i) {
+		pow_tab[i] = (u8) p;
+		log_tab[p] = (u8) i;
+
+		p ^= (p << 1) ^ (p & 0x80 ? 0x01b : 0);
+	}
+
+	log_tab[1] = 0;
+
+	for (i = 0, p = 1; i < 10; ++i) {
+		rco_tab[i] = p;
+
+		p = (p << 1) ^ (p & 0x80 ? 0x01b : 0);
+	}
+
+	for (i = 0; i < 256; ++i) {
+		p = (i ? pow_tab[255 - log_tab[i]] : 0);
+		q = ((p >> 7) | (p << 1)) ^ ((p >> 6) | (p << 2));
+		p ^= 0x63 ^ q ^ ((q >> 6) | (q << 2));
+		sbx_tab[i] = p;
+		isb_tab[p] = (u8) i;
+	}
+
+	for (i = 0; i < 256; ++i) {
+		p = sbx_tab[i];
+
+		t = p;
+		fl_tab[0][i] = t;
+		fl_tab[1][i] = rotl (t, 8);
+		fl_tab[2][i] = rotl (t, 16);
+		fl_tab[3][i] = rotl (t, 24);
+
+		t = ((u32) ff_mult (2, p)) |
+		    ((u32) p << 8) |
+		    ((u32) p << 16) | ((u32) ff_mult (3, p) << 24);
+
+		ft_tab[0][i] = t;
+		ft_tab[1][i] = rotl (t, 8);
+		ft_tab[2][i] = rotl (t, 16);
+		ft_tab[3][i] = rotl (t, 24);
+
+		p = isb_tab[i];
+
+		t = p;
+		il_tab[0][i] = t;
+		il_tab[1][i] = rotl (t, 8);
+		il_tab[2][i] = rotl (t, 16);
+		il_tab[3][i] = rotl (t, 24);
+
+		t = ((u32) ff_mult (14, p)) |
+		    ((u32) ff_mult (9, p) << 8) |
+		    ((u32) ff_mult (13, p) << 16) |
+		    ((u32) ff_mult (11, p) << 24);
+
+		it_tab[0][i] = t;
+		it_tab[1][i] = rotl (t, 8);
+		it_tab[2][i] = rotl (t, 16);
+		it_tab[3][i] = rotl (t, 24);
+	}
+}
+
+#define star_x(x) (((x) & 0x7f7f7f7f) << 1) ^ ((((x) & 0x80808080) >> 7) * 0x1b)
+
+#define imix_col(y,x)       \
+    u   = star_x(x);        \
+    v   = star_x(u);        \
+    w   = star_x(v);        \
+    t   = w ^ (x);          \
+   (y)  = u ^ v ^ w;        \
+   (y) ^= rotr(u ^ t,  8) ^ \
+          rotr(v ^ t, 16) ^ \
+          rotr(t,24)
+
+/* initialise the key schedule from the user supplied key */
+
+#define loop4(i)                                    \
+{   t = rotr(t,  8); t = ls_box(t) ^ rco_tab[i];    \
+    t ^= E_KEY[4 * i];     E_KEY[4 * i + 4] = t;    \
+    t ^= E_KEY[4 * i + 1]; E_KEY[4 * i + 5] = t;    \
+    t ^= E_KEY[4 * i + 2]; E_KEY[4 * i + 6] = t;    \
+    t ^= E_KEY[4 * i + 3]; E_KEY[4 * i + 7] = t;    \
+}
+
+#define loop6(i)                                    \
+{   t = rotr(t,  8); t = ls_box(t) ^ rco_tab[i];    \
+    t ^= E_KEY[6 * i];     E_KEY[6 * i + 6] = t;    \
+    t ^= E_KEY[6 * i + 1]; E_KEY[6 * i + 7] = t;    \
+    t ^= E_KEY[6 * i + 2]; E_KEY[6 * i + 8] = t;    \
+    t ^= E_KEY[6 * i + 3]; E_KEY[6 * i + 9] = t;    \
+    t ^= E_KEY[6 * i + 4]; E_KEY[6 * i + 10] = t;   \
+    t ^= E_KEY[6 * i + 5]; E_KEY[6 * i + 11] = t;   \
+}
+
+#define loop8(i)                                    \
+{   t = rotr(t,  8); ; t = ls_box(t) ^ rco_tab[i];  \
+    t ^= E_KEY[8 * i];     E_KEY[8 * i + 8] = t;    \
+    t ^= E_KEY[8 * i + 1]; E_KEY[8 * i + 9] = t;    \
+    t ^= E_KEY[8 * i + 2]; E_KEY[8 * i + 10] = t;   \
+    t ^= E_KEY[8 * i + 3]; E_KEY[8 * i + 11] = t;   \
+    t  = E_KEY[8 * i + 4] ^ ls_box(t);    \
+    E_KEY[8 * i + 12] = t;                \
+    t ^= E_KEY[8 * i + 5]; E_KEY[8 * i + 13] = t;   \
+    t ^= E_KEY[8 * i + 6]; E_KEY[8 * i + 14] = t;   \
+    t ^= E_KEY[8 * i + 7]; E_KEY[8 * i + 15] = t;   \
+}
+
+static int
+aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
+{
+	struct aes_ctx *ctx = ctx_arg;
+	u32 i, t, u, v, w;
+	u32 P[AES_EXTENDED_KEY_SIZE];
+	u32 rounds;
+
+	printk("%s() PadLock\n", __func__);
+	if (key_len != 16 && key_len != 24 && key_len != 32) {
+		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	}
+
+	ctx->key_length = key_len;
+
+	ctx->E = ctx->e_data;
+	ctx->D = ctx->d_data;
+
+	/* Ensure 16-Bytes alignmentation of keys for VIA PadLock. */
+	if ((int)(ctx->e_data) & 0x0F)
+		ctx->E += 4 - (((int)(ctx->e_data) & 0x0F) / sizeof (ctx->e_data[0]));
+
+	if ((int)(ctx->d_data) & 0x0F)
+		ctx->D += 4 - (((int)(ctx->d_data) & 0x0F) / sizeof (ctx->d_data[0]));
+
+	E_KEY[0] = u32_in (in_key);
+	E_KEY[1] = u32_in (in_key + 4);
+	E_KEY[2] = u32_in (in_key + 8);
+	E_KEY[3] = u32_in (in_key + 12);
+
+	/* Don't generate extended keys if the hardware can do it. */
+	if (aes_hw_extkey_available(key_len))
+		return 0;
+
+	switch (key_len) {
+	case 16:
+		t = E_KEY[3];
+		for (i = 0; i < 10; ++i)
+			loop4 (i);
+		break;
+
+	case 24:
+		E_KEY[4] = u32_in (in_key + 16);
+		t = E_KEY[5] = u32_in (in_key + 20);
+		for (i = 0; i < 8; ++i)
+			loop6 (i);
+		break;
+
+	case 32:
+		E_KEY[4] = u32_in (in_key + 16);
+		E_KEY[5] = u32_in (in_key + 20);
+		E_KEY[6] = u32_in (in_key + 24);
+		t = E_KEY[7] = u32_in (in_key + 28);
+		for (i = 0; i < 7; ++i)
+			loop8 (i);
+		break;
+	}
+
+	D_KEY[0] = E_KEY[0];
+	D_KEY[1] = E_KEY[1];
+	D_KEY[2] = E_KEY[2];
+	D_KEY[3] = E_KEY[3];
+
+	for (i = 4; i < key_len + 24; ++i) {
+		imix_col (D_KEY[i], E_KEY[i]);
+	}
+
+	/* PadLock needs a different format of the decryption key. */
+	rounds = 10 + (key_len - 16) / 4;
+
+	for (i = 0; i < rounds; i++) {
+		P[((i + 1) * 4) + 0] = D_KEY[((rounds - i - 1) * 4) + 0];
+		P[((i + 1) * 4) + 1] = D_KEY[((rounds - i - 1) * 4) + 1];
+		P[((i + 1) * 4) + 2] = D_KEY[((rounds - i - 1) * 4) + 2];
+		P[((i + 1) * 4) + 3] = D_KEY[((rounds - i - 1) * 4) + 3];
+	}
+
+	P[0] = E_KEY[(rounds * 4) + 0];
+	P[1] = E_KEY[(rounds * 4) + 1];
+	P[2] = E_KEY[(rounds * 4) + 2];
+	P[3] = E_KEY[(rounds * 4) + 3];
+
+	memcpy(D_KEY, P, AES_EXTENDED_KEY_SIZE_B);
+
+	return 0;
+}
+
+/* Tells whether the ACE is capable to generate
+   the extended key for a given key_len. */
+static inline int aes_hw_extkey_available(u8 key_len)
+{
+	/* TODO: We should check the actual CPU model/stepping
+	         as it's likely that the capability will be
+	         added in the next CPU revisions. */
+	if (key_len == 16)
+		return 1;
+	return 0;
+}
+
+static void aes_padlock(void *ctx_arg, u8 *out_arg, const u8 *in_arg,
+			const u8 *iv_arg, size_t nbytes, int encdec,
+			int mode)
+{
+	struct aes_ctx *ctx = ctx_arg;
+	char bigbuf[sizeof(union cword) + 16];
+	union cword *cword;
+	void *key;
+
+	/* Place 'data' at the first 16-Bytes aligned address in 'bigbuf'. */
+	if (((long)bigbuf) & 0x0F)
+		cword = (void*)(bigbuf + 16 - ((long)bigbuf & 0x0F));
+	else
+		cword = (void*)bigbuf;
+
+	/* Prepare Control word. */
+	memset (cword, 0, sizeof(union cword));
+	cword->b.encdec = !encdec;	/* in the rest of cryptoapi ENC=1/DEC=0 */
+	cword->b.rounds = 10 + (ctx->key_length - 16) / 4;
+	cword->b.ksize = (ctx->key_length - 16) / 8;
+
+	/* Is the hardware capable to generate the extended key? */
+	if (!aes_hw_extkey_available(ctx->key_length))
+		cword->b.keygen = 1;
+
+	/* ctx->E starts with a plain key - if the hardware is capable
+	   to generate the extended key itself we must supply
+	   the plain key for both Encryption and Decryption. */
+	if (encdec == CRYPTO_DIR_ENCRYPT || cword->b.keygen == 0)
+		key = ctx->E;
+	else
+		key = ctx->D;
+
+	padlock_aligner(out_arg, in_arg, iv_arg, key, cword,
+			nbytes, AES_BLOCK_SIZE, encdec, mode);
+}
+
+static void aes_padlock_ecb(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, NULL, nbytes, encdec,
+		    CRYPTO_TFM_MODE_ECB);
+}
+
+static void aes_padlock_cbc(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    CRYPTO_TFM_MODE_CBC);
+}
+
+static void aes_padlock_cfb(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    CRYPTO_TFM_MODE_CFB);
+}
+
+static void aes_padlock_ofb(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			    size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    CRYPTO_TFM_MODE_OFB);
+}
+
+static void aes_encrypt(void *ctx_arg, u8 *out, const u8 *in)
+{
+	aes_padlock(ctx_arg, out, in, NULL, AES_BLOCK_SIZE,
+		    CRYPTO_DIR_ENCRYPT, CRYPTO_TFM_MODE_ECB);
+}
+
+static void aes_decrypt(void *ctx_arg, u8 *out, const u8 *in)
+{
+	aes_padlock (ctx_arg, out, in, NULL, AES_BLOCK_SIZE,
+		     CRYPTO_DIR_DECRYPT, CRYPTO_TFM_MODE_ECB);
+}
+
+static struct crypto_alg aes_alg = {
+	.cra_name		=	"aes",
+	.cra_preference		=	CRYPTO_PREF_HARDWARE,
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	AES_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct aes_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(aes_alg.cra_list),
+	.cra_u			=	{
+		.cipher = {
+			.cia_min_keysize	=	AES_MIN_KEY_SIZE,
+			.cia_max_keysize	=	AES_MAX_KEY_SIZE,
+			.cia_setkey	   	= 	aes_set_key,
+			.cia_encrypt	 	=	aes_encrypt,
+			.cia_decrypt	  	=	aes_decrypt
+		}
+	}
+};
+
+static int disable_multiblock = 0;
+MODULE_PARM(disable_multiblock, "i");
+MODULE_PARM_DESC(disable_multiblock,
+		 "Disable encryption of whole multiblock buffers.");
+
+int __init padlock_init_aes(void)
+{
+	if (!disable_multiblock) {
+		aes_alg.cra_u.cipher.cia_max_nbytes = (size_t)-1;
+		aes_alg.cra_u.cipher.cia_req_align  = 16;
+		aes_alg.cra_u.cipher.cia_ecb        = aes_padlock_ecb;
+		aes_alg.cra_u.cipher.cia_cbc        = aes_padlock_cbc;
+		aes_alg.cra_u.cipher.cia_cfb        = aes_padlock_cfb;
+		aes_alg.cra_u.cipher.cia_ofb        = aes_padlock_ofb;
+	}
+
+	printk(KERN_NOTICE PFX
+		"Using VIA PadLock ACE for AES algorithm%s.\n",
+		disable_multiblock ? "" : " (multiblock)");
+
+	gen_tabs();
+	return crypto_register_alg(&aes_alg);
+}
+
+void __exit padlock_fini_aes(void)
+{
+	crypto_unregister_alg(&aes_alg);
+}
diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/devices/padlock-generic.c linux-2.6.5/crypto/devices/padlock-generic.c
--- linux-2.6.5.patched/crypto/devices/padlock-generic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5/crypto/devices/padlock-generic.c	2004-05-11 11:05:10.000000000 +0200
@@ -0,0 +1,175 @@
+/*
+ * Cryptographic API.
+ *
+ * Support for VIA PadLock hardware crypto engine.
+ *
+ * Linux developers:
+ *  Michal Ludvig <mludvig@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/crypto.h>
+#include <asm/byteorder.h>
+#include "padlock.h"
+
+#define PFX	"padlock: "
+
+typedef void (xcrypt_t)(u8 *input, u8 *output, u8 *key, u8 *iv,
+			void *control_word, u32 count);
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
+void padlock_aligner(u8 *out_arg, const u8 *in_arg, const u8 *iv_arg,
+		     void *key, union cword *cword,
+		     size_t nbytes, size_t blocksize,
+		     int encdec, int mode)
+{
+	/* Don't blindly modify this structure - the items must
+	   fit on 16-Bytes boundaries! */
+	struct padlock_xcrypt_data {
+		u8 iv[blocksize];		/* Initialization vector */
+	};
+
+	u8 *in, *out, *iv;
+	void *index = NULL;
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
+		memcpy(iv, iv_arg, blocksize);
+
+	switch (mode) {
+		case CRYPTO_TFM_MODE_ECB:
+			padlock_xcrypt_ecb(in, out, key, iv, cword, nbytes/blocksize);
+			break;
+
+		case CRYPTO_TFM_MODE_CBC:
+			padlock_xcrypt_cbc(in, out, key, iv, cword, nbytes/blocksize);
+			break;
+
+		case CRYPTO_TFM_MODE_CFB:
+			padlock_xcrypt_cfb(in, out, key, iv, cword, nbytes/blocksize);
+			break;
+
+		case CRYPTO_TFM_MODE_OFB:
+			padlock_xcrypt_ofb(in, out, key, iv, cword, nbytes/blocksize);
+			break;
+
+		default:
+			BUG();
+	}
+
+	/* Copy the 16-Byte aligned output to the caller's buffer. */
+	if (out != out_arg)
+		memcpy(out_arg, out, nbytes);
+
+	if (index)
+		kfree(index);
+}
+
+static int __init padlock_init(void)
+{
+	int ret = -ENOSYS;
+
+	if (!cpu_has_xcrypt) {
+		printk(KERN_ERR PFX "VIA PadLock not detected.\n");
+		return -ENODEV;
+	}
+
+	if (!cpu_has_xcrypt_enabled) {
+		printk(KERN_ERR PFX "VIA PadLock detected, but not enabled. Hmm, strange...\n");
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_CRYPTO_DEV_PADLOCK_AES
+	if ((ret = padlock_init_aes())) {
+		printk(KERN_ERR PFX "VIA PadLock AES initialization failed.\n");
+		return ret;
+	}
+#endif
+
+	if (ret == -ENOSYS)
+		printk(KERN_ERR PFX "Hmm, VIA PadLock was compiled without any algorithm.\n");
+
+	return ret;
+}
+
+static void __exit padlock_fini(void)
+{
+#ifdef CONFIG_CRYPTO_DEV_PADLOCK_AES
+	padlock_fini_aes();
+#endif
+}
+
+module_init(padlock_init);
+module_exit(padlock_fini);
+
+MODULE_DESCRIPTION("VIA PadLock crypto engine support.");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Michal Ludvig");
diff -X exclude.txt -rupN linux-2.6.5.patched/crypto/devices/padlock.h linux-2.6.5/crypto/devices/padlock.h
--- linux-2.6.5.patched/crypto/devices/padlock.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5/crypto/devices/padlock.h	2004-05-11 15:46:59.885953752 +0200
@@ -0,0 +1,41 @@
+/*
+ * Cryptographic API.
+ *
+ * Copyright (c) 2004 Michal Ludvig <mludvig@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+
+#ifndef _CRYPTO_PADLOCK_H
+#define _CRYPTO_PADLOCK_H
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
+#define PFX	"padlock: "
+
+void padlock_aligner(u8 *out_arg, const u8 *in_arg, const u8 *iv_arg,
+		     void *key, union cword *cword,
+		     size_t nbytes, size_t blocksize,
+		     int encdec, int mode);
+
+#ifdef CONFIG_CRYPTO_DEV_PADLOCK_AES
+int padlock_init_aes(void);
+void padlock_fini_aes(void);
+#endif
+
+#endif	/* _CRYPTO_PADLOCK_H */
