Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUHFOzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUHFOzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUHFOzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:55:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268064AbUHFOwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:52:46 -0400
Date: Fri, 6 Aug 2004 10:52:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Marc Ballarin <Ballarin.Marc@gmx.de>
cc: torvalds@osdl.org, <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <clemens@endorphin.org>
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
In-Reply-To: <20040806140012.2dbd92bd.Ballarin.Marc@gmx.de>
Message-ID: <Xine.LNX.4.44.0408061025320.22496-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Marc Ballarin wrote:

> Will this code work with CONFIG_REGPARM=y ?

Yes.

> This comment seems partly obsolete.

Ok, removed, updated patch below.

> Does it work on x86 CPUs without MMX?

Yes, Linus removed the MMX stuff.


Signed-off-by: James Morris <jmorris@redhat.com>


diff -urN -X dontdiff linux-2.6.8-rc3.w2/arch/i386/crypto/aes.c linux-2.6.8-rc3.w/arch/i386/crypto/aes.c
--- linux-2.6.8-rc3.w2/arch/i386/crypto/aes.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8-rc3.w/arch/i386/crypto/aes.c	2004-08-06 11:02:25.457711392 -0400
@@ -0,0 +1,520 @@
+/* 
+ * 
+ * Glue Code for optimized 586 assembler version of AES
+ *
+ * Copyright (c) 2002, Dr Brian Gladman <>, Worcester, UK.
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
+ *
+ * Copyright (c) 2003, Adam J. Richter <adam@yggdrasil.com> (conversion to
+ * 2.5 API).
+ * Copyright (c) 2003, 2004 Fruhwirth Clemens <clemens@endorphin.org>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/crypto.h>
+#include <linux/linkage.h>
+
+asmlinkage void aes_enc_blk(const u8 *src, u8 *dst, void *ctx);
+asmlinkage void aes_dec_blk(const u8 *src, u8 *dst, void *ctx);
+
+#define AES_MIN_KEY_SIZE	16
+#define AES_MAX_KEY_SIZE	32
+#define AES_BLOCK_SIZE		16
+#define AES_KS_LENGTH		4 * AES_BLOCK_SIZE
+#define RC_LENGTH		29
+
+struct aes_ctx {
+	u32 ekey[AES_KS_LENGTH];
+	u32 rounds;
+	u32 dkey[AES_KS_LENGTH];
+};
+
+#define WPOLY 0x011b
+#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
+#define bytes2word(b0, b1, b2, b3)  \
+	(((u32)(b3) << 24) | ((u32)(b2) << 16) | ((u32)(b1) << 8) | (b0))
+
+/* define the finite field multiplies required for Rijndael */
+#define f2(x) ((x) ? pow[log[x] + 0x19] : 0)
+#define f3(x) ((x) ? pow[log[x] + 0x01] : 0)
+#define f9(x) ((x) ? pow[log[x] + 0xc7] : 0)
+#define fb(x) ((x) ? pow[log[x] + 0x68] : 0)
+#define fd(x) ((x) ? pow[log[x] + 0xee] : 0)
+#define fe(x) ((x) ? pow[log[x] + 0xdf] : 0)
+#define fi(x) ((x) ?   pow[255 - log[x]]: 0)
+
+static inline u32 upr(u32 x, int n)
+{
+	return (x << 8 * n) | (x >> (32 - 8 * n));
+}
+
+static inline u8 bval(u32 x, int n)
+{
+	return x >> 8 * n;
+}
+
+/* The forward and inverse affine transformations used in the S-box */
+#define fwd_affine(x) \
+	(w = (u32)x, w ^= (w<<1)^(w<<2)^(w<<3)^(w<<4), 0x63^(u8)(w^(w>>8)))
+
+#define inv_affine(x) \
+	(w = (u32)x, w = (w<<1)^(w<<3)^(w<<6), 0x05^(u8)(w^(w>>8)))
+
+static u32 rcon_tab[RC_LENGTH];
+
+u32 ft_tab[4][256];
+u32 fl_tab[4][256];
+u32 ls_tab[4][256];
+u32 im_tab[4][256];
+u32 il_tab[4][256];
+u32 it_tab[4][256];
+
+void gen_tabs(void)
+{
+	u32 i, w;
+	u8 pow[512], log[256];
+
+	/*
+	 * log and power tables for GF(2^8) finite field with
+	 * WPOLY as modular polynomial - the simplest primitive
+	 * root is 0x03, used here to generate the tables.
+	 */
+	i = 0; w = 1; 
+	
+	do {
+		pow[i] = (u8)w;
+		pow[i + 255] = (u8)w;
+		log[w] = (u8)i++;
+		w ^=  (w << 1) ^ (w & 0x80 ? WPOLY : 0);
+	} while (w != 1);
+	
+	for(i = 0, w = 1; i < RC_LENGTH; ++i) {
+		rcon_tab[i] = bytes2word(w, 0, 0, 0);
+		w = f2(w);
+	}
+
+	for(i = 0; i < 256; ++i) {
+		u8 b;
+		
+		b = fwd_affine(fi((u8)i));
+		w = bytes2word(f2(b), b, b, f3(b));
+
+		/* tables for a normal encryption round */
+		ft_tab[0][i] = w;
+		ft_tab[1][i] = upr(w, 1);
+		ft_tab[2][i] = upr(w, 2);
+		ft_tab[3][i] = upr(w, 3);
+		w = bytes2word(b, 0, 0, 0);
+		
+		/*
+		 * tables for last encryption round
+		 * (may also be used in the key schedule)
+		 */
+		fl_tab[0][i] = w;
+		fl_tab[1][i] = upr(w, 1);
+		fl_tab[2][i] = upr(w, 2);
+		fl_tab[3][i] = upr(w, 3);
+		
+		/*
+		 * table for key schedule if fl_tab above is
+		 * not of the required form
+		 */
+		ls_tab[0][i] = w;
+		ls_tab[1][i] = upr(w, 1);
+		ls_tab[2][i] = upr(w, 2);
+		ls_tab[3][i] = upr(w, 3);
+		
+		b = fi(inv_affine((u8)i));
+		w = bytes2word(fe(b), f9(b), fd(b), fb(b));
+
+		/* tables for the inverse mix column operation  */
+		im_tab[0][b] = w;
+		im_tab[1][b] = upr(w, 1);
+		im_tab[2][b] = upr(w, 2);
+		im_tab[3][b] = upr(w, 3);
+
+		/* tables for a normal decryption round */
+		it_tab[0][i] = w;
+		it_tab[1][i] = upr(w,1);
+		it_tab[2][i] = upr(w,2);
+		it_tab[3][i] = upr(w,3);
+
+		w = bytes2word(b, 0, 0, 0);
+		
+		/* tables for last decryption round */
+		il_tab[0][i] = w;
+		il_tab[1][i] = upr(w,1);
+		il_tab[2][i] = upr(w,2);
+		il_tab[3][i] = upr(w,3);
+    }
+}
+
+#define four_tables(x,tab,vf,rf,c)		\
+(	tab[0][bval(vf(x,0,c),rf(0,c))]	^	\
+	tab[1][bval(vf(x,1,c),rf(1,c))] ^	\
+	tab[2][bval(vf(x,2,c),rf(2,c))] ^	\
+	tab[3][bval(vf(x,3,c),rf(3,c))]		\
+)
+
+#define vf1(x,r,c)  (x)
+#define rf1(r,c)    (r)
+#define rf2(r,c)    ((r-c)&3)
+
+#define inv_mcol(x) four_tables(x,im_tab,vf1,rf1,0)
+#define ls_box(x,c) four_tables(x,fl_tab,vf1,rf2,c)
+
+#define ff(x) inv_mcol(x)
+
+#define ke4(k,i)							\
+{									\
+	k[4*(i)+4] = ss[0] ^= ls_box(ss[3],3) ^ rcon_tab[i];		\
+	k[4*(i)+5] = ss[1] ^= ss[0];					\
+	k[4*(i)+6] = ss[2] ^= ss[1];					\
+	k[4*(i)+7] = ss[3] ^= ss[2];					\
+}
+
+#define kel4(k,i)							\
+{									\
+	k[4*(i)+4] = ss[0] ^= ls_box(ss[3],3) ^ rcon_tab[i];		\
+	k[4*(i)+5] = ss[1] ^= ss[0];					\
+	k[4*(i)+6] = ss[2] ^= ss[1]; k[4*(i)+7] = ss[3] ^= ss[2];	\
+}
+
+#define ke6(k,i)							\
+{									\
+	k[6*(i)+ 6] = ss[0] ^= ls_box(ss[5],3) ^ rcon_tab[i];		\
+	k[6*(i)+ 7] = ss[1] ^= ss[0];					\
+	k[6*(i)+ 8] = ss[2] ^= ss[1];					\
+	k[6*(i)+ 9] = ss[3] ^= ss[2];					\
+	k[6*(i)+10] = ss[4] ^= ss[3];					\
+	k[6*(i)+11] = ss[5] ^= ss[4];					\
+}
+
+#define kel6(k,i)							\
+{									\
+	k[6*(i)+ 6] = ss[0] ^= ls_box(ss[5],3) ^ rcon_tab[i];		\
+	k[6*(i)+ 7] = ss[1] ^= ss[0];					\
+	k[6*(i)+ 8] = ss[2] ^= ss[1];					\
+	k[6*(i)+ 9] = ss[3] ^= ss[2];					\
+}
+
+#define ke8(k,i)							\
+{									\
+	k[8*(i)+ 8] = ss[0] ^= ls_box(ss[7],3) ^ rcon_tab[i];		\
+	k[8*(i)+ 9] = ss[1] ^= ss[0];					\
+	k[8*(i)+10] = ss[2] ^= ss[1];					\
+	k[8*(i)+11] = ss[3] ^= ss[2];					\
+	k[8*(i)+12] = ss[4] ^= ls_box(ss[3],0);				\
+	k[8*(i)+13] = ss[5] ^= ss[4];					\
+	k[8*(i)+14] = ss[6] ^= ss[5];					\
+	k[8*(i)+15] = ss[7] ^= ss[6];					\
+}
+
+#define kel8(k,i)							\
+{									\
+	k[8*(i)+ 8] = ss[0] ^= ls_box(ss[7],3) ^ rcon_tab[i];		\
+	k[8*(i)+ 9] = ss[1] ^= ss[0];					\
+	k[8*(i)+10] = ss[2] ^= ss[1];					\
+	k[8*(i)+11] = ss[3] ^= ss[2];					\
+}
+
+#define kdf4(k,i)							\
+{									\
+	ss[0] = ss[0] ^ ss[2] ^ ss[1] ^ ss[3];				\
+	ss[1] = ss[1] ^ ss[3];						\
+	ss[2] = ss[2] ^ ss[3];						\
+	ss[3] = ss[3];							\
+	ss[4] = ls_box(ss[(i+3) % 4], 3) ^ rcon_tab[i];			\
+	ss[i % 4] ^= ss[4];						\
+	ss[4] ^= k[4*(i)];						\
+	k[4*(i)+4] = ff(ss[4]);						\
+	ss[4] ^= k[4*(i)+1];						\
+	k[4*(i)+5] = ff(ss[4]);						\
+	ss[4] ^= k[4*(i)+2];						\
+	k[4*(i)+6] = ff(ss[4]);						\
+	ss[4] ^= k[4*(i)+3];						\
+	k[4*(i)+7] = ff(ss[4]);						\
+}
+
+#define kd4(k,i)							\
+{									\
+	ss[4] = ls_box(ss[(i+3) % 4], 3) ^ rcon_tab[i];			\
+	ss[i % 4] ^= ss[4];						\
+	ss[4] = ff(ss[4]);						\
+	k[4*(i)+4] = ss[4] ^= k[4*(i)];					\
+	k[4*(i)+5] = ss[4] ^= k[4*(i)+1];				\
+	k[4*(i)+6] = ss[4] ^= k[4*(i)+2];				\
+	k[4*(i)+7] = ss[4] ^= k[4*(i)+3];				\
+}
+
+#define kdl4(k,i)							\
+{									\
+	ss[4] = ls_box(ss[(i+3) % 4], 3) ^ rcon_tab[i];			\
+	ss[i % 4] ^= ss[4];						\
+	k[4*(i)+4] = (ss[0] ^= ss[1]) ^ ss[2] ^ ss[3];			\
+	k[4*(i)+5] = ss[1] ^ ss[3];					\
+	k[4*(i)+6] = ss[0];						\
+	k[4*(i)+7] = ss[1];						\
+}
+
+#define kdf6(k,i)							\
+{									\
+	ss[0] ^= ls_box(ss[5],3) ^ rcon_tab[i];				\
+	k[6*(i)+ 6] = ff(ss[0]);					\
+	ss[1] ^= ss[0];							\
+	k[6*(i)+ 7] = ff(ss[1]);					\
+	ss[2] ^= ss[1];							\
+	k[6*(i)+ 8] = ff(ss[2]);					\
+	ss[3] ^= ss[2];							\
+	k[6*(i)+ 9] = ff(ss[3]);					\
+	ss[4] ^= ss[3];							\
+	k[6*(i)+10] = ff(ss[4]);					\
+	ss[5] ^= ss[4];							\
+	k[6*(i)+11] = ff(ss[5]);					\
+}
+
+#define kd6(k,i)							\
+{									\
+	ss[6] = ls_box(ss[5],3) ^ rcon_tab[i];				\
+	ss[0] ^= ss[6]; ss[6] = ff(ss[6]);				\
+	k[6*(i)+ 6] = ss[6] ^= k[6*(i)];				\
+	ss[1] ^= ss[0];							\
+	k[6*(i)+ 7] = ss[6] ^= k[6*(i)+ 1];				\
+	ss[2] ^= ss[1];							\
+	k[6*(i)+ 8] = ss[6] ^= k[6*(i)+ 2];				\
+	ss[3] ^= ss[2];							\
+	k[6*(i)+ 9] = ss[6] ^= k[6*(i)+ 3];				\
+	ss[4] ^= ss[3];							\
+	k[6*(i)+10] = ss[6] ^= k[6*(i)+ 4];				\
+	ss[5] ^= ss[4];							\
+	k[6*(i)+11] = ss[6] ^= k[6*(i)+ 5];				\
+}
+
+#define kdl6(k,i)							\
+{									\
+	ss[0] ^= ls_box(ss[5],3) ^ rcon_tab[i];				\
+	k[6*(i)+ 6] = ss[0];						\
+	ss[1] ^= ss[0];							\
+	k[6*(i)+ 7] = ss[1];						\
+	ss[2] ^= ss[1];							\
+	k[6*(i)+ 8] = ss[2];						\
+	ss[3] ^= ss[2];							\
+	k[6*(i)+ 9] = ss[3];						\
+}
+
+#define kdf8(k,i)							\
+{									\
+	ss[0] ^= ls_box(ss[7],3) ^ rcon_tab[i];				\
+	k[8*(i)+ 8] = ff(ss[0]);					\
+	ss[1] ^= ss[0];							\
+	k[8*(i)+ 9] = ff(ss[1]);					\
+	ss[2] ^= ss[1];							\
+	k[8*(i)+10] = ff(ss[2]);					\
+	ss[3] ^= ss[2];							\
+	k[8*(i)+11] = ff(ss[3]);					\
+	ss[4] ^= ls_box(ss[3],0);					\
+	k[8*(i)+12] = ff(ss[4]);					\
+	ss[5] ^= ss[4];							\
+	k[8*(i)+13] = ff(ss[5]);					\
+	ss[6] ^= ss[5];							\
+	k[8*(i)+14] = ff(ss[6]);					\
+	ss[7] ^= ss[6];							\
+	k[8*(i)+15] = ff(ss[7]);					\
+}
+
+#define kd8(k,i)							\
+{									\
+	u32 __g = ls_box(ss[7],3) ^ rcon_tab[i];			\
+	ss[0] ^= __g;							\
+	__g = ff(__g);							\
+	k[8*(i)+ 8] = __g ^= k[8*(i)];					\
+	ss[1] ^= ss[0];							\
+	k[8*(i)+ 9] = __g ^= k[8*(i)+ 1];				\
+	ss[2] ^= ss[1];							\
+	k[8*(i)+10] = __g ^= k[8*(i)+ 2];				\
+	ss[3] ^= ss[2];							\
+	k[8*(i)+11] = __g ^= k[8*(i)+ 3];				\
+	__g = ls_box(ss[3],0);						\
+	ss[4] ^= __g;							\
+	__g = ff(__g);							\
+	k[8*(i)+12] = __g ^= k[8*(i)+ 4];				\
+	ss[5] ^= ss[4];							\
+	k[8*(i)+13] = __g ^= k[8*(i)+ 5];				\
+	ss[6] ^= ss[5];							\
+	k[8*(i)+14] = __g ^= k[8*(i)+ 6];				\
+	ss[7] ^= ss[6];							\
+	k[8*(i)+15] = __g ^= k[8*(i)+ 7];				\
+}
+
+#define kdl8(k,i)							\
+{									\
+	ss[0] ^= ls_box(ss[7],3) ^ rcon_tab[i];				\
+	k[8*(i)+ 8] = ss[0];						\
+	ss[1] ^= ss[0];							\
+	k[8*(i)+ 9] = ss[1];						\
+	ss[2] ^= ss[1];							\
+	k[8*(i)+10] = ss[2];						\
+	ss[3] ^= ss[2];							\
+	k[8*(i)+11] = ss[3];						\
+}
+
+static int
+aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
+{
+	int i;
+	u32 ss[8];
+	struct aes_ctx *ctx = ctx_arg;
+
+	/* encryption schedule */
+	
+	ctx->ekey[0] = ss[0] = u32_in(in_key);
+	ctx->ekey[1] = ss[1] = u32_in(in_key + 4);
+	ctx->ekey[2] = ss[2] = u32_in(in_key + 8);
+	ctx->ekey[3] = ss[3] = u32_in(in_key + 12);
+
+	switch(key_len) {
+	case 16:
+		for (i = 0; i < 9; i++)
+			ke4(ctx->ekey, i);
+		kel4(ctx->ekey, 9);
+		ctx->rounds = 10;
+		break;
+		
+	case 24:
+		ctx->ekey[4] = ss[4] = u32_in(in_key + 16);
+		ctx->ekey[5] = ss[5] = u32_in(in_key + 20);
+		for (i = 0; i < 7; i++)
+			ke6(ctx->ekey, i);
+		kel6(ctx->ekey, 7); 
+		ctx->rounds = 12;
+		break;
+
+	case 32:
+		ctx->ekey[4] = ss[4] = u32_in(in_key + 16);
+		ctx->ekey[5] = ss[5] = u32_in(in_key + 20);
+		ctx->ekey[6] = ss[6] = u32_in(in_key + 24);
+		ctx->ekey[7] = ss[7] = u32_in(in_key + 28);
+		for (i = 0; i < 6; i++)
+			ke8(ctx->ekey, i);
+		kel8(ctx->ekey, 6);
+		ctx->rounds = 14;
+		break;
+
+	default:
+		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	}
+	
+	/* decryption schedule */
+	
+	ctx->dkey[0] = ss[0] = u32_in(in_key);
+	ctx->dkey[1] = ss[1] = u32_in(in_key + 4);
+	ctx->dkey[2] = ss[2] = u32_in(in_key + 8);
+	ctx->dkey[3] = ss[3] = u32_in(in_key + 12);
+
+	switch (key_len) {
+	case 16:
+		kdf4(ctx->dkey, 0);
+		for (i = 1; i < 9; i++)
+			kd4(ctx->dkey, i);
+		kdl4(ctx->dkey, 9);
+		break;
+		
+	case 24:
+		ctx->dkey[4] = ff(ss[4] = u32_in(in_key + 16));
+		ctx->dkey[5] = ff(ss[5] = u32_in(in_key + 20));
+		kdf6(ctx->dkey, 0);
+		for (i = 1; i < 7; i++)
+			kd6(ctx->dkey, i);
+		kdl6(ctx->dkey, 7);
+		break;
+
+	case 32:
+		ctx->dkey[4] = ff(ss[4] = u32_in(in_key + 16));
+		ctx->dkey[5] = ff(ss[5] = u32_in(in_key + 20));
+		ctx->dkey[6] = ff(ss[6] = u32_in(in_key + 24));
+		ctx->dkey[7] = ff(ss[7] = u32_in(in_key + 28));
+		kdf8(ctx->dkey, 0);
+		for (i = 1; i < 6; i++)
+			kd8(ctx->dkey, i);
+		kdl8(ctx->dkey, 6);
+		break;
+	}
+	return 0;
+}
+
+static inline void aes_encrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	aes_enc_blk(src, dst, ctx);
+}
+static inline void aes_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	aes_dec_blk(src, dst, ctx);
+}
+
+
+static struct crypto_alg aes_alg = {
+	.cra_name		=	"aes",
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
+static int __init aes_init(void)
+{
+	gen_tabs();
+	return crypto_register_alg(&aes_alg);
+}
+
+static void __exit aes_fini(void)
+{
+	crypto_unregister_alg(&aes_alg);
+}
+
+module_init(aes_init);
+module_exit(aes_fini);
+
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm, i586 asm optimized");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Fruhwirth Clemens, James Morris, Brian Gladman, Adam Richter");
+MODULE_ALIAS("aes");
diff -urN -X dontdiff linux-2.6.8-rc3.w2/arch/i386/crypto/aes-i586-asm.S linux-2.6.8-rc3.w/arch/i386/crypto/aes-i586-asm.S
--- linux-2.6.8-rc3.w2/arch/i386/crypto/aes-i586-asm.S	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8-rc3.w/arch/i386/crypto/aes-i586-asm.S	2004-08-06 10:51:43.820255112 -0400
@@ -0,0 +1,341 @@
+// -------------------------------------------------------------------------
+// Copyright (c) 2001, Dr Brian Gladman <                 >, Worcester, UK.
+// All rights reserved.
+//
+// LICENSE TERMS
+//
+// The free distribution and use of this software in both source and binary 
+// form is allowed (with or without changes) provided that:
+//
+//   1. distributions of this source code include the above copyright 
+//      notice, this list of conditions and the following disclaimer//
+//
+//   2. distributions in binary form include the above copyright
+//      notice, this list of conditions and the following disclaimer
+//      in the documentation and/or other associated materials//
+//
+//   3. the copyright holder's name is not used to endorse products 
+//      built using this software without specific written permission.
+//
+//
+// ALTERNATIVELY, provided that this notice is retained in full, this product
+// may be distributed under the terms of the GNU General Public License (GPL),
+// in which case the provisions of the GPL apply INSTEAD OF those given above.
+//
+// Copyright (c) 2004 Linus Torvalds <torvalds@osdl.org>
+// Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+
+// DISCLAIMER
+//
+// This software is provided 'as is' with no explicit or implied warranties
+// in respect of its properties including, but not limited to, correctness 
+// and fitness for purpose.
+// -------------------------------------------------------------------------
+// Issue Date: 29/07/2002
+
+.file "aes-i586-asm.S"
+.text
+
+// aes_rval aes_enc_blk(const unsigned char in_blk[], unsigned char out_blk[], const aes_ctx cx[1])//
+// aes_rval aes_dec_blk(const unsigned char in_blk[], unsigned char out_blk[], const aes_ctx cx[1])//
+	
+#define tlen 1024   // length of each of 4 'xor' arrays (256 32-bit words)
+
+// offsets to parameters with one register pushed onto stack
+
+#define in_blk    8  // input byte array address parameter
+#define out_blk  12  // output byte array address parameter
+#define ctx      16  // AES context structure
+
+// offsets in context structure
+
+#define ekey     0   // encryption key schedule base address
+#define nrnd   256   // number of rounds
+#define dkey   260   // decryption key schedule base address
+
+// register mapping for encrypt and decrypt subroutines
+
+#define r0  eax
+#define r1  ebx
+#define r2  ecx
+#define r3  edx
+#define r4  esi
+#define r5  edi
+#define r6  ebp
+
+#define eaxl  al
+#define eaxh  ah
+#define ebxl  bl
+#define ebxh  bh
+#define ecxl  cl
+#define ecxh  ch
+#define edxl  dl
+#define edxh  dh
+
+#define _h(reg) reg##h
+#define h(reg) _h(reg)
+
+#define _l(reg) reg##l
+#define l(reg) _l(reg)
+
+// This macro takes a 32-bit word representing a column and uses
+// each of its four bytes to index into four tables of 256 32-bit
+// words to obtain values that are then xored into the appropriate
+// output registers r0, r1, r4 or r5.  
+
+// Parameters:
+//   %1  out_state[0]
+//   %2  out_state[1]
+//   %3  out_state[2]
+//   %4  out_state[3]
+//   %5  table base address
+//   %6  input register for the round (destroyed)
+//   %7  scratch register for the round
+
+#define do_col(a1, a2, a3, a4, a5, a6, a7)	\
+	movzx   %l(a6),%a7;			\
+	xor     a5(,%a7,4),%a1;			\
+	movzx   %h(a6),%a7;			\
+	shr     $16,%a6;			\
+	xor     a5+tlen(,%a7,4),%a2;		\
+	movzx   %l(a6),%a7;			\
+	movzx   %h(a6),%a6;			\
+	xor     a5+2*tlen(,%a7,4),%a3;		\
+	xor     a5+3*tlen(,%a6,4),%a4;
+
+// initialise output registers from the key schedule
+
+#define do_fcol(a1, a2, a3, a4, a5, a6, a7, a8)	\
+	mov     0 a8,%a1;			\
+	movzx   %l(a6),%a7;			\
+	mov     12 a8,%a2;			\
+	xor     a5(,%a7,4),%a1;			\
+	mov     4 a8,%a4;			\
+	movzx   %h(a6),%a7;			\
+	shr     $16,%a6;			\
+	xor     a5+tlen(,%a7,4),%a2;		\
+	movzx   %l(a6),%a7;			\
+	movzx   %h(a6),%a6;			\
+	xor     a5+3*tlen(,%a6,4),%a4;		\
+	mov     %a3,%a6;			\
+	mov     8 a8,%a3;			\
+	xor     a5+2*tlen(,%a7,4),%a3;
+
+// initialise output registers from the key schedule
+
+#define do_icol(a1, a2, a3, a4, a5, a6, a7, a8)	\
+	mov     0 a8,%a1;			\
+	movzx   %l(a6),%a7;			\
+	mov     4 a8,%a2;			\
+	xor     a5(,%a7,4),%a1;			\
+	mov     12 a8,%a4;			\
+	movzx   %h(a6),%a7;			\
+	shr     $16,%a6;			\
+	xor     a5+tlen(,%a7,4),%a2;		\
+	movzx   %l(a6),%a7;			\
+	movzx   %h(a6),%a6;			\
+	xor     a5+3*tlen(,%a6,4),%a4;		\
+	mov     %a3,%a6;			\
+	mov     8 a8,%a3;			\
+	xor     a5+2*tlen(,%a7,4),%a3;
+
+
+// original Gladman had conditional saves to MMX regs.
+#define save(a1, a2)		\
+	mov     %a2,4*a1(%esp)
+
+#define restore(a1, a2)		\
+	mov     4*a2(%esp),%a1
+
+// This macro performs a forward encryption cycle. It is entered with
+// the first previous round column values in r0, r1, r4 and r5 and
+// exits with the final values in the same registers, using the MMX
+// registers mm0-mm1 or the stack for temporary storage
+
+// mov current column values into the MMX registers
+#define fwd_rnd(arg, table)					\
+	/* mov current column values into the MMX registers */	\
+	mov     %r0,%r2;					\
+	save   (0,r1);						\
+	save   (1,r5);						\
+								\
+	/* compute new column values */				\
+	do_fcol(r0,r5,r4,r1,table, r2,r3, arg);			\
+	do_col (r4,r1,r0,r5,table, r2,r3);			\
+	restore(r2,0);						\
+	do_col (r1,r0,r5,r4,table, r2,r3);			\
+	restore(r2,1);						\
+	do_col (r5,r4,r1,r0,table, r2,r3);
+
+// This macro performs an inverse encryption cycle. It is entered with
+// the first previous round column values in r0, r1, r4 and r5 and
+// exits with the final values in the same registers, using the MMX
+// registers mm0-mm1 or the stack for temporary storage
+
+#define inv_rnd(arg, table)					\
+	/* mov current column values into the MMX registers */	\
+	mov     %r0,%r2;					\
+	save    (0,r1);						\
+	save    (1,r5);						\
+								\
+	/* compute new column values */				\
+	do_icol(r0,r1,r4,r5, table, r2,r3, arg);		\
+	do_col (r4,r5,r0,r1, table, r2,r3);			\
+	restore(r2,0);						\
+	do_col (r1,r4,r5,r0, table, r2,r3);			\
+	restore(r2,1);						\
+	do_col (r5,r0,r1,r4, table, r2,r3);
+
+// AES (Rijndael) Encryption Subroutine
+
+.global  aes_enc_blk
+
+.extern  ft_tab
+.extern  fl_tab
+
+.align 4
+
+aes_enc_blk:
+	push    %ebp
+	mov     ctx(%esp),%ebp      // pointer to context
+	xor     %eax,%eax
+
+// CAUTION: the order and the values used in these assigns 
+// rely on the register mappings
+
+1:	push    %ebx
+	mov     in_blk+4(%esp),%r2
+	push    %esi
+	mov     nrnd(%ebp),%r3   // number of rounds
+	push    %edi
+	lea     ekey(%ebp),%r6   // key pointer
+
+// input four columns and xor in first round key
+
+	mov     (%r2),%r0
+	mov     4(%r2),%r1
+	mov     8(%r2),%r4
+	mov     12(%r2),%r5
+	xor     (%r6),%r0
+	xor     4(%r6),%r1
+	xor     8(%r6),%r4
+	xor     12(%r6),%r5
+
+	sub     $8,%esp           // space for register saves on stack
+	add     $16,%r6           // increment to next round key   
+	sub     $10,%r3          
+	je      4f              // 10 rounds for 128-bit key
+	add     $32,%r6
+	sub     $2,%r3
+	je      3f              // 12 rounds for 128-bit key
+	add     $32,%r6
+
+2:	fwd_rnd( -64(%r6) ,ft_tab)	// 14 rounds for 128-bit key
+	fwd_rnd( -48(%r6) ,ft_tab)
+3:	fwd_rnd( -32(%r6) ,ft_tab)	// 12 rounds for 128-bit key
+	fwd_rnd( -16(%r6) ,ft_tab)
+4:	fwd_rnd(    (%r6) ,ft_tab)	// 10 rounds for 128-bit key
+	fwd_rnd( +16(%r6) ,ft_tab)
+	fwd_rnd( +32(%r6) ,ft_tab)
+	fwd_rnd( +48(%r6) ,ft_tab)
+	fwd_rnd( +64(%r6) ,ft_tab)
+	fwd_rnd( +80(%r6) ,ft_tab)
+	fwd_rnd( +96(%r6) ,ft_tab)
+	fwd_rnd(+112(%r6) ,ft_tab)
+	fwd_rnd(+128(%r6) ,ft_tab)
+	fwd_rnd(+144(%r6) ,fl_tab)	// last round uses a different table
+
+// move final values to the output array.  CAUTION: the 
+// order of these assigns rely on the register mappings
+
+	add     $8,%esp
+	mov     out_blk+12(%esp),%r6
+	mov     %r5,12(%r6)
+	pop     %edi
+	mov     %r4,8(%r6)
+	pop     %esi
+	mov     %r1,4(%r6)
+	pop     %ebx
+	mov     %r0,(%r6)
+	pop     %ebp
+	mov     $1,%eax
+	ret
+
+// AES (Rijndael) Decryption Subroutine
+
+.global  aes_dec_blk
+
+.extern  it_tab
+.extern  il_tab
+
+.align 4
+
+aes_dec_blk:
+	push    %ebp
+	mov     ctx(%esp),%ebp       // pointer to context
+	xor     %eax,%eax
+
+// CAUTION: the order and the values used in these assigns 
+// rely on the register mappings
+
+1:	push    %ebx
+	mov     in_blk+4(%esp),%r2
+	push    %esi
+	mov     nrnd(%ebp),%r3   // number of rounds
+	push    %edi
+	lea     dkey(%ebp),%r6   // key pointer
+	mov     %r3,%r0
+	shl     $4,%r0
+	add     %r0,%r6
+	
+// input four columns and xor in first round key
+
+	mov     (%r2),%r0
+	mov     4(%r2),%r1
+	mov     8(%r2),%r4
+	mov     12(%r2),%r5
+	xor     (%r6),%r0
+	xor     4(%r6),%r1
+	xor     8(%r6),%r4
+	xor     12(%r6),%r5
+
+	sub     $8,%esp           // space for register saves on stack
+	sub     $16,%r6           // increment to next round key   
+	sub     $10,%r3          
+	je      4f              // 10 rounds for 128-bit key
+	sub     $32,%r6
+	sub     $2,%r3
+	je      3f              // 12 rounds for 128-bit key
+	sub     $32,%r6
+
+2:	inv_rnd( +64(%r6), it_tab)	// 14 rounds for 128-bit key 
+	inv_rnd( +48(%r6), it_tab)
+3:	inv_rnd( +32(%r6), it_tab)	// 12 rounds for 128-bit key
+	inv_rnd( +16(%r6), it_tab)
+4:	inv_rnd(    (%r6), it_tab)	// 10 rounds for 128-bit key
+	inv_rnd( -16(%r6), it_tab)
+	inv_rnd( -32(%r6), it_tab)
+	inv_rnd( -48(%r6), it_tab)
+	inv_rnd( -64(%r6), it_tab)
+	inv_rnd( -80(%r6), it_tab)
+	inv_rnd( -96(%r6), it_tab)
+	inv_rnd(-112(%r6), it_tab)
+	inv_rnd(-128(%r6), it_tab)
+	inv_rnd(-144(%r6), il_tab)	// last round uses a different table
+
+// move final values to the output array.  CAUTION: the 
+// order of these assigns rely on the register mappings
+
+	add     $8,%esp
+	mov     out_blk+12(%esp),%r6
+	mov     %r5,12(%r6)
+	pop     %edi
+	mov     %r4,8(%r6)
+	pop     %esi
+	mov     %r1,4(%r6)
+	pop     %ebx
+	mov     %r0,(%r6)
+	pop     %ebp
+	mov     $1,%eax
+	ret
+
diff -urN -X dontdiff linux-2.6.8-rc3.w2/arch/i386/crypto/Makefile linux-2.6.8-rc3.w/arch/i386/crypto/Makefile
--- linux-2.6.8-rc3.w2/arch/i386/crypto/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8-rc3.w/arch/i386/crypto/Makefile	2004-08-06 03:20:34.000000000 -0400
@@ -0,0 +1,9 @@
+# 
+# i386/crypto/Makefile 
+# 
+# Arch-specific CryptoAPI modules.
+# 
+
+obj-$(CONFIG_CRYPTO_AES_586) += aes-i586.o
+
+aes-i586-y := aes-i586-asm.o aes.o
diff -urN -X dontdiff linux-2.6.8-rc3.w2/arch/i386/Makefile linux-2.6.8-rc3.w/arch/i386/Makefile
--- linux-2.6.8-rc3.w2/arch/i386/Makefile	2004-08-05 11:28:21.000000000 -0400
+++ linux-2.6.8-rc3.w/arch/i386/Makefile	2004-08-04 19:43:16.000000000 -0400
@@ -104,7 +104,8 @@
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
-					   arch/i386/$(mcore-y)/
+					   arch/i386/$(mcore-y)/ \
+					   arch/i386/crypto/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
 # must be linked after kernel/
diff -urN -X dontdiff linux-2.6.8-rc3.w2/crypto/Kconfig linux-2.6.8-rc3.w/crypto/Kconfig
--- linux-2.6.8-rc3.w2/crypto/Kconfig	2004-08-05 11:28:21.000000000 -0400
+++ linux-2.6.8-rc3.w/crypto/Kconfig	2004-08-05 10:40:27.000000000 -0400
@@ -120,7 +120,7 @@
 
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
-	depends on CRYPTO
+	depends on CRYPTO && !(X86 && !X86_64)
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
 	  algorithm.
@@ -138,6 +138,26 @@
 
 	  See http://csrc.nist.gov/CryptoToolkit/aes/ for more information.
 
+config CRYPTO_AES_586
+	tristate "AES cipher algorithms (i586)"
+	depends on CRYPTO && (X86 && !X86_64)
+	help
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
+	  algorithm.
+
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing 
+	  environments regardless of its use in feedback or non-feedback 
+	  modes. Its key setup time is excellent, and its key agility is 
+	  good. Rijndael's very low memory requirements make it very well 
+	  suited for restricted-space environments, in which it also 
+	  demonstrates excellent performance. Rijndael's operations are 
+	  among the easiest to defend against power and timing attacks.	
+
+	  The AES specifies three key sizes: 128, 192 and 256 bits	  
+
+	  See http://csrc.nist.gov/encryption/aes/ for more information.
+
 config CRYPTO_CAST5
 	tristate "CAST5 (CAST-128) cipher algorithm"
 	depends on CRYPTO
diff -urN -X dontdiff linux-2.6.8-rc3.w2/Documentation/crypto/api-intro.txt linux-2.6.8-rc3.w/Documentation/crypto/api-intro.txt
--- linux-2.6.8-rc3.w2/Documentation/crypto/api-intro.txt	2004-08-05 11:28:21.000000000 -0400
+++ linux-2.6.8-rc3.w/Documentation/crypto/api-intro.txt	2004-08-05 13:00:40.000000000 -0400
@@ -215,6 +215,8 @@
   Herbert Valerio Riedel
   Kyle McMartin
   Adam J. Richter
+  Fruhwirth Clemens (i586)
+  Linus Torvalds (i586)
 
 CAST5 algorithm contributors:
   Kartikey Mahendra Bhatt (original developers unknown, FSF copyright).

