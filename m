Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVAXMGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVAXMGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVAXMGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:06:08 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:6153 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261506AbVAXL6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:58:00 -0500
Date: Mon, 24 Jan 2005 12:57:50 +0100
To: akpm@osdl.org, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 04/04] Add LRW
Message-ID: <20050124115750.GA21883@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1107431870.41eb@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the core of my LRW patch. Added test vectors.
http://grouper.ieee.org/groups/1619/email/pdf00017.pdf
Please notice, that this is not a patch for dm-crypt. I will
post a nice splitted patch set for dm later that day.

Signed-off-by: Fruhwirth Clemens <clemens@endorphin.org>

--- 3/crypto/cipher.c	2005-01-24 11:35:58.994317520 +0100
+++ final/crypto/cipher.c	2005-01-24 11:42:16.682900128 +0100
@@ -20,10 +20,7 @@
 #include <asm/scatterlist.h>
 #include "internal.h"
 #include "scatterwalk.h"
-
-typedef void (cryptfn_t)(void *, u8 *, const u8 *);
-typedef void (procfn_t)(struct crypto_tfm *, u8 *,
-                        u8*, cryptfn_t, int enc, void *, int);
+#include "lrw.h"
 
 static inline void xor_64(u8 *a, const u8 *b)
 {
@@ -39,7 +36,6 @@
 	((u32 *)a)[3] ^= ((u32 *)b)[3];
 }
 
-
 struct cbc_process_priv {
 	struct crypto_tfm *tfm;
 	int enc;
@@ -85,7 +81,7 @@
 	priv->crfn(crypto_tfm_ctx(priv->tfm), buf[0], buf[1]);
 }
 
-static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+static int setkey_generic(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 {
 	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
 	
@@ -258,15 +254,15 @@
 	int ret = 0;
 	struct cipher_tfm *ops = &tfm->crt_cipher;
 
-	ops->cit_setkey = setkey;
-
 	switch (tfm->crt_cipher.cit_mode) {
 	case CRYPTO_TFM_MODE_ECB:
+		ops->cit_setkey = setkey_generic;
 		ops->cit_encrypt = ecb_encrypt;
 		ops->cit_decrypt = ecb_decrypt;
 		break;
 		
 	case CRYPTO_TFM_MODE_CBC:
+		ops->cit_setkey = setkey_generic;
 		ops->cit_encrypt = cbc_encrypt;
 		ops->cit_decrypt = cbc_decrypt;
 		ops->cit_encrypt_iv = cbc_encrypt_iv;
@@ -280,6 +276,7 @@
 		break;
 		
 	case CRYPTO_TFM_MODE_CFB:
+		ops->cit_setkey = setkey_generic;
 		ops->cit_encrypt = nocrypt;
 		ops->cit_decrypt = nocrypt;
 		ops->cit_encrypt_iv = nocrypt_iv;
@@ -289,6 +286,7 @@
 		break;
 	
 	case CRYPTO_TFM_MODE_CTR:
+		ops->cit_setkey = setkey_generic;
 		ops->cit_encrypt = nocrypt;
 		ops->cit_decrypt = nocrypt;
 		ops->cit_encrypt_iv = nocrypt_iv;
@@ -297,11 +295,35 @@
 		ops->cit_decrypt_tweaks = nocrypt_tweaks;
 		break;
 
+	case CRYPTO_TFM_MODE_LRW:
+	case CRYPTO_TFM_MODE_LRW_RAW:
+		if(crypto_tfm_alg_blocksize(tfm) != 16) {
+			printk(KERN_WARNING "LRW can't be used with non-128-bit ciphers\n");
+			return -EINVAL;
+		}
+		ops->cit_tweaksize = crypto_tfm_alg_blocksize(tfm);
+		ops->cit_bytes_per_tweak = crypto_tfm_alg_blocksize(tfm);
+		ops->cit_setkey = setkey_lrw;
+		ops->cit_encrypt = nocrypt;
+		ops->cit_decrypt = nocrypt;
+		ops->cit_encrypt_iv = nocrypt_iv;
+		ops->cit_decrypt_iv = nocrypt_iv;
+		if(tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_LRW) {
+			ops->cit_encrypt_tweaks = lrw_encrypt;
+			ops->cit_decrypt_tweaks = lrw_decrypt;
+		} else if(tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_LRW_RAW) {
+			ops->cit_encrypt_tweaks = lrw_raw_encrypt;
+			ops->cit_decrypt_tweaks = lrw_raw_decrypt;	
+		} else {
+			BUG();
+		}
+		break;
 	default:
 		BUG();
 	}
 	
-	if (ops->cit_mode == CRYPTO_TFM_MODE_CBC) {
+	if (ops->cit_mode == CRYPTO_TFM_MODE_CBC || ops->cit_mode == CRYPTO_TFM_MODE_LRW 
+	    || ops->cit_mode == CRYPTO_TFM_MODE_LRW_RAW) {
 	    	
 	    	switch (crypto_tfm_alg_blocksize(tfm)) {
 	    	case 8:
--- 3/crypto/api.c	2005-01-20 10:16:06.000000000 +0100
+++ final/crypto/api.c	2005-01-24 11:42:16.683899976 +0100
@@ -27,6 +27,9 @@
 static inline int crypto_cmctx_size(u32 flags) 
 {
 	switch(flags & CRYPTO_TFM_MODE_MASK) {
+		case CRYPTO_TFM_MODE_LRW:
+		case CRYPTO_TFM_MODE_LRW_RAW:
+			return 2048;
 		default:
 			return 0;
 	}
--- 3/crypto/internal.h	2005-01-20 10:16:06.000000000 +0100
+++ final/crypto/internal.h	2005-01-24 11:42:16.684899824 +0100
@@ -19,6 +19,10 @@
 #include <linux/kmod.h>
 #include <asm/kmap_types.h>
 
+typedef void (cryptfn_t)(void *, u8 *, const u8 *);
+typedef void (procfn_t)(struct crypto_tfm *, u8 *,
+                        u8*, cryptfn_t, int enc, void *, int);
+
 extern enum km_type crypto_km_types[];
 
 static inline enum km_type crypto_kmap_type(int out)
--- 3/include/linux/crypto.h	2005-01-24 11:33:34.498284256 +0100
+++ final/include/linux/crypto.h	2005-01-24 11:42:16.684899824 +0100
@@ -48,6 +48,8 @@
 #define CRYPTO_TFM_MODE_CBC		0x00000002
 #define CRYPTO_TFM_MODE_CFB		0x00000004
 #define CRYPTO_TFM_MODE_CTR		0x00000008
+#define CRYPTO_TFM_MODE_LRW		0x00000020
+#define CRYPTO_TFM_MODE_LRW_RAW	0x00000040
 
 #define CRYPTO_TFM_REQ_WEAK_KEY		0x00000100
 #define CRYPTO_TFM_RES_WEAK_KEY		0x00100000
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ final/crypto/lrw.c	2005-01-24 12:50:41.620854704 +0100
@@ -0,0 +1,262 @@
+/*
+ * Cryptographic API.
+ *
+ * LRW cipher mode implementation
+ * 
+ * Copyright (c) 2004, Clemens Fruhwirth <clemens@endorphin.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <asm/scatterlist.h>
+#include "internal.h"
+#include "scatterwalk.h"
+#include "gfmulseq.h"
+
+#ifndef DEBUG
+#define LRW_DEBUG_DUMP(x,y,z) 
+#else
+#define LRW_DEBUG_DUMP(t,b,l) hexdumpTitle(t,b,l);
+
+static void
+hexdumpTitle(char *title, unsigned char *buf, unsigned int len)
+{
+	printk("%s",title);
+        while (len--)
+                printk("%02x", *buf++);
+
+        printk("\n");
+}
+#endif
+
+struct lrw_info {
+	struct crypto_tfm *tfm;
+	cryptfn_t *fn;
+};
+
+struct lrw_tweak_cooks_info {
+	u128 startN;
+	u128 currentN;
+	int stripesize;
+	u64 *cooked_tweaks;
+	int cooked_tweaks_idx;
+	u64 *negTab;
+};
+
+static void lrw_generate_table(const char *xkey2, u64 *negTab) {
+	u64 rpol[] = { 0x0ULL, 0x87ULL }; /* reduction polynomial as defined by LRW specs */
+	u64 *key2 = (u64 *)xkey2;
+	key2[0] = be64_to_cpu(key2[0]);
+	key2[1] = be64_to_cpu(key2[1]);
+	GFMulGenTab(key2,rpol,negTab);
+}
+
+static void lrw_tweak_cook(void *priv, int sg, void **dpatchlist) 
+{
+	struct lrw_tweak_cooks_info *lta = (struct lrw_tweak_cooks_info *)priv;
+	u64 *raw_tweak = dpatchlist[0];
+	
+	if(lta->stripesize == 0) {
+		copy128(lta->startN,raw_tweak);
+		copy128(lta->currentN,raw_tweak);
+		lta->stripesize = 1;
+		return;
+	}
+	add128(lta->currentN,1);
+	if(equal128(lta->currentN, raw_tweak)) {
+		lta->stripesize++;	
+	} else {
+		GFMulSeq(lta->startN, (lta->cooked_tweaks)+lta->cooked_tweaks_idx, lta->stripesize, lta->negTab);
+		copy128(lta->startN,raw_tweak);
+		copy128(lta->currentN,raw_tweak);
+		lta->cooked_tweaks_idx += I1(lta->stripesize);
+		lta->stripesize = 1;
+	}	
+}
+
+/* Helper for clients of this mode */
+void lrw_generate_tweak_seq(struct crypto_tfm *tfm, u64 *start, u64 *buf, u32 length)
+{
+	GFMulSeq(start, buf, length, (u64 *)crypto_tfm_cmctx(tfm));
+}
+EXPORT_SYMBOL_GPL(lrw_generate_tweak_seq);
+
+static void lrw_one_pass(void *priv,int sg, void **dpatchlist)
+{
+	struct lrw_info *lrw = (struct lrw_info *)priv;
+	u8 *src = dpatchlist[0];
+	u8 *dst = dpatchlist[1];
+	u8 *tweaks = dpatchlist[2];
+	LRW_DEBUG_DUMP("P:",src,16);
+	LRW_DEBUG_DUMP("T:",tweaks,16);
+
+	((u64 *)dst)[0] = ((u64 *)src)[0] ^ ((u64 *)tweaks)[0];
+	((u64 *)dst)[1] = ((u64 *)src)[1] ^ ((u64 *)tweaks)[1];
+
+	LRW_DEBUG_DUMP("P^T:",dst,16);
+
+	lrw->fn(crypto_tfm_ctx(lrw->tfm),dst,dst);
+
+	LRW_DEBUG_DUMP("Enc(P^T):",dst,16);
+
+	((u64 *)dst)[0] ^= ((u64 *)tweaks)[0];
+	((u64 *)dst)[1] ^= ((u64 *)tweaks)[1];
+}
+
+int lrw_raw_encrypt(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaksg)
+{
+	struct walk_info lrw_walk_infos[3] = {
+		[0].sg = src, 
+		[0].stepsize = 16, 
+		[0].ioflag = 0, 
+		[0].buf = (char[16]){},
+		[1].sg = dst, 
+		[1].stepsize = 16, 
+		[1].ioflag = 1, 
+		[1].buf = (char[16]){},
+		[2].sg = tweaksg, 
+		[2].stepsize = 16, 
+		[2].ioflag = 0, 
+		[2].buf = (char[16]){},
+	};
+	     
+	struct lrw_info callinfo = {
+		.tfm = tfm,
+		.fn = tfm->__crt_alg->cra_cipher.cia_encrypt,
+	};
+	scatterwalk_walker_generic(lrw_one_pass, &callinfo, nbytes/16, 3, lrw_walk_infos);
+	return 0;
+}
+
+int lrw_raw_decrypt(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaksg)
+{
+	struct walk_info lrw_walk_infos[3] = {
+		[0].sg = src, 
+		[0].stepsize = 16, 
+		[0].ioflag = 0, 
+		[0].buf = (char[16]){},
+		[1].sg = dst, 
+		[1].stepsize = 16, 
+		[1].ioflag = 1, 
+		[1].buf = (char[16]){},
+		[2].sg = tweaksg, 
+		[2].stepsize = 16, 
+		[2].ioflag = 0, 
+		[2].buf = (char[16]){},
+	};
+	struct lrw_info callinfo = {
+		.tfm = tfm,
+		.fn = tfm->__crt_alg->cra_cipher.cia_decrypt,
+	};
+	scatterwalk_walker_generic(lrw_one_pass, &callinfo, nbytes/16, 3, lrw_walk_infos);
+	return 0;
+}
+
+int lrw_template(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *raw_tweaks,
+                          int (*rawfunction)(struct crypto_tfm *,
+                                             struct scatterlist *,
+                                             struct scatterlist *,
+                                             unsigned int, 
+                                             struct scatterlist *))
+{
+	int r;
+	struct scatterlist cooked_tweaks_sg = {NULL, };
+	u128_alloc(currentN);
+	u128_alloc(startN);
+	u64 *cooked_tweaks = kmalloc(nbytes,GFP_KERNEL);
+	
+	struct walk_info cook_walk_info[1] = {
+		[0].sg = raw_tweaks,
+		[0].stepsize = 16,
+		[0].ioflag = 0,
+		[0].buf = (char[16]){},
+	};
+
+	struct lrw_tweak_cooks_info recipe = {
+		.startN = startN,
+		.currentN = currentN,
+		.stripesize = 0,
+		.cooked_tweaks = cooked_tweaks,
+		.cooked_tweaks_idx = 0,
+		.negTab = crypto_tfm_cmctx(tfm),
+	};
+	
+	if(cooked_tweaks == NULL)
+		return -ENOMEM;
+	
+	scatterwalk_walker_generic(lrw_tweak_cook, &recipe, nbytes/16, 1, cook_walk_info);
+	GFMulSeq(recipe.startN, recipe.cooked_tweaks+recipe.cooked_tweaks_idx, recipe.stripesize, recipe.negTab);
+		
+	cooked_tweaks_sg.page = virt_to_page(cooked_tweaks);
+	cooked_tweaks_sg.offset = offset_in_page(cooked_tweaks);
+	cooked_tweaks_sg.length = nbytes;
+	
+	r = rawfunction(tfm,dst,src,nbytes,&cooked_tweaks_sg);
+	kfree(cooked_tweaks);
+	
+	return r;
+}
+
+int lrw_encrypt(struct crypto_tfm *tfm, struct scatterlist *dst,
+                    struct scatterlist *src, unsigned int nbytes, 
+                    struct scatterlist *tweaksg)
+{
+	return lrw_template(tfm,dst,src,nbytes,tweaksg,lrw_raw_encrypt);
+}
+
+int lrw_decrypt(struct crypto_tfm *tfm, struct scatterlist *dst,
+                    struct scatterlist *src, unsigned int nbytes, 
+                    struct scatterlist *tweaksg)
+{
+	return lrw_template(tfm,dst,src,nbytes,tweaksg,lrw_raw_decrypt);
+}
+
+int setkey_lrw(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+{
+	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	int r = -EINVAL;
+
+#ifdef DEBUG
+	printk(KERN_DEBUG "setkey_lrw: given keylen %d, wanted min %d, wanted max %d\n",keylen,cia->cia_min_keysize + bsize,cia->cia_max_keysize + bsize);
+#endif
+	if (keylen < (cia->cia_min_keysize + bsize)
+		|| keylen > (cia->cia_max_keysize + bsize)) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	}
+
+	r = cia->cia_setkey(crypto_tfm_ctx(tfm), key, keylen-bsize,
+                            &tfm->crt_flags);
+	if (r < 0) 
+		return r;
+
+	lrw_generate_table(key+keylen-bsize,crypto_tfm_cmctx(tfm));
+	return r;
+}
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ final/crypto/lrw.h	2005-01-24 12:51:03.290560408 +0100
@@ -0,0 +1,45 @@
+/*
+ * Cryptographic API.
+ *
+ * LRW cipher mode implementation
+ * 
+ * Copyright (c) 2004, Clemens Fruhwirth <clemens@endorphin.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */    
+    
+int lrw_raw_encrypt(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaksg);
+int lrw_encrypt(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaks);  
+int lrw_raw_decrypt(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaksg);
+int lrw_decrypt(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaksg);
+int setkey_lrw(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen);
+
+/* 
+ * Unfortunately LRW requires spaghetti coding otherwise the performance of 
+ * this mode is unreasonable 
+ */
+void lrw_generate_tweak_seq(struct crypto_tfm *tfm, u64 *start, u64 *buf, u32 length);
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ final/crypto/gfmulseq.c	2005-01-24 12:44:51.627061848 +0100
@@ -0,0 +1,219 @@
+/*
+ * Efficient Generation Of Arithmetic Sequences of Multiplications in GF(2^128)
+ *
+ * Copyright 2004, Clemens Fruhwirth <clemens@endorphin.org>
+ *
+ * Go to http://clemens.endorphin.org/publications for documentation.
+ * Otherwise, you will have no chance to understand the mathematical
+ * background behind this code.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include "gfmulseq.h"
+
+#define u64msbmask (1ULL << 63)
+
+#define xor128(op, arg) 				\
+	do { 						\
+		(op)[0] = (op)[0] ^ (arg)[0]; 		\
+		(op)[1] = (op)[1] ^ (arg)[1]; 		\
+	} while(0)
+
+#define lsr128(n,shift) 							\
+	do {									\
+		(n)[1] = (n)[1] >> shift | (n)[0] << (bits/2-(shift));		\
+		(n)[0] = (n)[0] >> shift;					\
+	} while(0)
+
+#define lsl128(n,shift)							\
+	do {								\
+		(n)[0] = (n)[0] << shift | (n)[1] >> (bits/2-(shift));	\
+		(n)[1] = (n)[1] << 1;					\
+	} while(0)
+
+#define msb128(n) (((n)[0] & u64msbmask)?0x1:0x0)
+
+#define lsb128(n) ((n)[1] & 0x1)
+
+#define zero128(pointer) memset((void *)(pointer),0,sizeof(u64)*u64factor);
+	
+#define setN(negTab,i,value)					\
+	do {							\
+		(negTab)[I1(i)] = cpu_to_be64((value)[0]);	\
+		(negTab)[I2(i)] = cpu_to_be64((value)[1]);	\
+	} while(0)
+
+/* 
+ * GF Multiplication Base Algorithm 
+ */
+	
+void GFMulBase(u128 callersN, u128 GF, u128_t negTab) {
+	int want=1;
+	int i=0;
+	/* Copy N, so lsl does not destroy caller's copy */
+	u128_alloc(N);
+	copy128(N,callersN);
+
+	zero128(GF);
+	for(i=0;i<bits;i++) {
+		if (msb128(N) == want) {
+			xor128(GF,&negTab[I1(bits-1-i)]);
+			want = want?0:1;
+		}
+		lsl128(N,1);
+	}
+}
+
+static inline void findAlignment(u128 callersN, int value, int *align) {
+	int i;
+	/* Copy N, so lsr does not destroy caller's copy */
+	u128_alloc(N);
+	copy128(N,callersN);
+
+	lsr128(N,*align);
+	for(i=*align;i<bits;i++) {
+		if (lsb128(N) != value) {
+			*align = i;
+			return;
+		}
+		lsr128(N,1);
+	}
+	*align = bits;
+}
+
+/* GF Multiplication Aligned 
+ * Generates min(length,1<<pow2) GF multiplication results,
+ * GF_i = GF_0/n*(n+i), when pow2 is the alignment of N in base 2.
+ */
+
+void GFMulAligned(u128 currentN, u64 **callersCurrentGF, u64 *negTab, int pow2, int *length) {
+	int i;			// Outer control loop counter
+	int j;			// Inner control loop counter
+	int revp;		// Inner control loop reverse pointer
+	int curp=0;		// Destination pointer for next computation
+	u64 *currentGF = *callersCurrentGF;	// pointer to base GF
+	u64 addPoly[2];		// Inner loop's addition polynomial 
+	
+#ifdef DEBUG
+	printf("bulk: %d %d\n",pow2,*length);
+	print128(currentN);
+#endif
+	for(i=0; i<pow2 && *length; i++) {
+		/* Reverse pointer */
+		revp = 1 << i;
+
+#define min(a,b) (a)<(b)?(a):(b)
+		/* 
+		 * Inner loop control variable, either exhaust all data
+		 * available by the reverse pointer, or clip by the length
+		 */
+		j = min(revp, *length);
+#undef min
+		/* processing polynomial */
+		addPoly[0] = negTab[I1(i)];
+		addPoly[1] = negTab[I2(i)];
+
+		/* subtract before loop, otherwise j would be zero */
+		*length -= j;
+
+		while(j--) {
+			curp++;
+			revp--;
+			currentGF[I1(curp)] = currentGF[I1(revp)] ^ addPoly[0];
+			currentGF[I2(curp)] = currentGF[I2(revp)] ^ addPoly[1];
+		}
+	}
+	/* Update callers variables */	
+	/* set pointer of the caller to the new base GF */
+	*callersCurrentGF = &currentGF[I1(curp)];
+	/* update N by adding total number of generated GFs */
+	add128(currentN,curp);
+#ifdef DEBUG
+	printf("bulk generated %d\n",curp);
+#endif
+}
+
+/*
+ * GF Multiplication Negative Step
+ * computes GF_2 = GF_1 / n * (n+1)
+ */
+
+void GFMulNStep(u64 *currentN, u64 *currentGF, u64 *negTab, int align) {
+#ifdef DEBUG
+	printf("negative step at:");
+	print128(currentN);
+#endif
+	currentGF[I1(1)] = currentGF[I1(0)] ^ negTab[I1(align)];
+	currentGF[I2(1)] = currentGF[I2(0)] ^ negTab[I2(align)];
+}
+
+/*
+ * GF Multiplication Sequence
+ * Generates an arithmetic sequence of GF multiplications
+ */
+
+void GFMulSeq(u64 *callersN, u64 *dst, int length, u64 *negTab)
+{
+	u64 *currentGF = dst;
+	u128_alloc(currentN);
+	int alignOfN=0;
+
+	copy128(currentN,callersN);
+	GFMulBase(currentN, currentGF, negTab);
+	length--;
+	
+	if(!length) return;
+	
+	findAlignment(currentN,0,&alignOfN);
+	if(alignOfN != 0) {
+		GFMulAligned(currentN, &currentGF, negTab, alignOfN, &length);
+	}
+	while(1) {
+		if(!length) return;
+			findAlignment(currentN,1,&alignOfN);
+			
+			GFMulNStep(currentN, currentGF, negTab, alignOfN);
+			add128(currentN,1);
+			currentGF = &currentGF[I1(1)];	
+			length--;
+		if(!length) return;
+			/* 
+			 * alignedBulk takes alignment of Zero at end as parameter,
+			 * but we don't need to recompute the value since after a negative
+			 * step the previously aligned ones are guaranteed to become zeros,
+			 * so alignOfN == findAlignment(current,0).
+			 */
+			GFMulAligned(currentN, &currentGF, negTab, alignOfN, &length);
+		alignOfN++; /* Hint our knowledge to findAlignment */
+	}
+}
+
+/* 
+ * genNegTab: generate negative-logic table, that is: 
+ * Table with GF multiplication results from 2^(i+1)-1, or in otherwords, all
+ * bits set till bit i.
+ */
+
+void GFMulGenTab(u128 key2, u128 rpol, u128_t negTab) {
+	u128_alloc(key2Control);
+	u128_alloc(res);
+	int i;
+		
+	copy128(key2Control,key2);
+	copy128(res,key2);
+
+	setN(negTab,0,key2);
+	for(i=1; i < bits; i++) {
+		if(msb128(key2Control)) {
+			lsl128(key2Control,1);
+			xor128(key2Control,rpol);
+		}
+		else
+			lsl128(key2Control,1);
+		xor128(res,key2Control);
+		setN(negTab,i,res);
+	}
+}
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ final/crypto/gfmulseq.h	2005-01-24 11:42:16.687899368 +0100
@@ -0,0 +1,74 @@
+/*
+ * Efficient Generation Of Arithmetic Sequences of Multiplications in GF(2^128)
+ *
+ * Copyright 2004, Clemens Fruhwirth <clemens@endorphin.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * Go to http://clemens.endorphin.org/publications for documentation.
+ * Otherwise, you will have no chance to understand the mathematical
+ * background behind this code.
+ */
+
+#ifndef __GFMULSEQ_H__
+#define __GFMULSEQ_H__
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+
+#define print128(n) do { 						\
+	char *__print128_p = (char *)n;					\
+	int __print128_i;						\
+	for(__print128_i = 0; __print128_i<16; __print128_i++)	\
+		printk("%02hhx",*(__print128_p+__print128_i));		\
+	printk("\n"); 							\
+} while(0) 
+
+typedef u64 *u128;
+typedef u64 *u128_t;
+
+#define u128_alloc(VAR) u64 _ ## VAR ## _[2]; u128 VAR = _ ## VAR ## _
+
+#define bits 128
+#define u64factor 2
+#define I1(x) ((x)*u64factor)
+#define I2(x) ((x)*u64factor+1)
+
+#define copy128(dst,src)			\
+	do {					\
+		(dst)[0] = (src)[0];		\
+		(dst)[1] = (src)[1];		\
+	} while(0)
+
+#define add128(dst,oper)						\
+	do {								\
+		u64 scratch = (dst)[1] + (oper);			\
+		if(scratch < (dst)[1] && scratch < (oper)) 		\
+			(dst)[0]++;					\
+		(dst)[1] = scratch;					\
+	} while(0)
+	
+#define equal128(op1,op2) \
+	(((op1)[0] == (op2)[0]) && ((op1)[1] == (op2)[1]))
+	
+#define cpu_to_be128(op1) \
+	do { 			\
+		(op1)[0] = cpu_to_be64((op1)[0]); \
+		(op1)[1] = cpu_to_be64((op1)[1]); \
+	} while(0)
+
+#define be128_to_cpu(op1) \
+	do { 			\
+		(op1)[0] = be64_to_cpu((op1)[0]); \
+		(op1)[1] = be64_to_cpu((op1)[1]); \
+	} while(0)
+
+
+void GFMulBase(u128 callersN, u128 GF, u128_t negTab);
+void GFMulSeq(u64 *currentN, u64 *dst, int length, u64 *negTab);
+void GFMulGenTab(u128 key2, u128 rpol, u128_t negTab);
+
+#endif
--- 3/crypto/Makefile	2005-01-20 10:16:06.000000000 +0100
+++ final/crypto/Makefile	2005-01-24 11:42:16.688899216 +0100
@@ -4,7 +4,7 @@
 
 proc-crypto-$(CONFIG_PROC_FS) = proc.o
 
-obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \
+obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o lrw.o gfmulseq.o \
 			$(proc-crypto-y)
 
 obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
--- 3/crypto/tcrypt.c	2005-01-20 10:16:06.000000000 +0100
+++ final/crypto/tcrypt.c	2005-01-24 11:42:16.689899064 +0100
@@ -50,8 +50,9 @@
 */
 #define ENCRYPT 1
 #define DECRYPT 0
-#define MODE_ECB 1
-#define MODE_CBC 0
+#define MODE_ECB 0
+#define MODE_CBC 1
+#define MODE_LRW 2
 
 static unsigned int IDX[8] = { IDX1, IDX2, IDX3, IDX4, IDX5, IDX6, IDX7, IDX8 };
 
@@ -265,19 +266,38 @@
 	char *key;
 	struct cipher_testvec *cipher_tv;
 	struct scatterlist sg[8];
+	struct scatterlist tweaks[1];
 	char e[11], m[4];
 
 	if (enc == ENCRYPT)
 	        strncpy(e, "encryption", 11);
 	else
         	strncpy(e, "decryption", 11);
-	if (mode == MODE_ECB)
-        	strncpy(m, "ECB", 4);
-	else
-        	strncpy(m, "CBC", 4);
-
+	
+	switch (mode) {
+	case MODE_ECB:
+		tfm = crypto_alloc_tfm (algo, CRYPTO_TFM_MODE_ECB);
+		strncpy(m, "ECB", 4);
+		break;
+	case MODE_CBC:
+		tfm = crypto_alloc_tfm (algo, CRYPTO_TFM_MODE_CBC);
+		strncpy(m, "CBC", 4);
+		break;
+        case MODE_LRW:
+		tfm = crypto_alloc_tfm (algo, CRYPTO_TFM_MODE_LRW);
+		strncpy(m,"LRW",4);
+		break;
+	default:
+		BUG();
+		return;
+	}
 	printk("\ntesting %s %s %s \n", algo, m, e);
 
+	if (tfm == NULL) {
+		printk("failed to load transform for %s %s\n", algo, m);
+		return;
+	}
+
 	tsize = sizeof (struct cipher_testvec);	
 	tsize *= tcount;
 	
@@ -286,19 +306,8 @@
 		       TVMEMSIZE);
 		return;
 	}
-
 	memcpy(tvmem, template, tsize);
 	cipher_tv = (void *) tvmem;
-
-	if (mode) 
-		tfm = crypto_alloc_tfm (algo, 0);
-	else 
-		tfm = crypto_alloc_tfm (algo, CRYPTO_TFM_MODE_CBC);
-	
-	if (tfm == NULL) {
-		printk("failed to load transform for %s %s\n", algo, m);
-		return;
-	}
 	
 	j = 0;
 	for (i = 0; i < tcount; i++) {
@@ -324,18 +333,34 @@
 			sg[0].page = virt_to_page(p);
 			sg[0].offset = offset_in_page(p);
 			sg[0].length = cipher_tv[i].ilen;
-	
-			if (!mode) {
+
+			switch(mode) {
+			case MODE_CBC:
 				crypto_cipher_set_iv(tfm, cipher_tv[i].iv,
-					crypto_tfm_alg_ivsize (tfm));
+						     crypto_tfm_alg_ivsize (tfm));
+				/* fall-through intentional */
+			case MODE_ECB:
+				if (enc)
+					ret = crypto_cipher_encrypt(tfm, sg, sg, cipher_tv[i].ilen);
+				else
+					ret = crypto_cipher_decrypt(tfm, sg, sg, cipher_tv[i].ilen);
+				break;
+			case MODE_LRW:
+				{
+					u64 *hosttweak = (u64 *)cipher_tv[i].tweak;
+					hosttweak[0] = be64_to_cpu(hosttweak[0]);
+					hosttweak[1] = be64_to_cpu(hosttweak[1]);
+					tweaks[0].page = virt_to_page(cipher_tv[i].tweak);
+					tweaks[0].offset = offset_in_page(cipher_tv[i].tweak);
+					tweaks[0].length = cipher_tv[i].tlen;
+					if (enc)
+						ret = crypto_cipher_encrypt_tweaks(tfm, sg, sg, cipher_tv[i].ilen, tweaks);
+					else
+						ret = crypto_cipher_decrypt_tweaks(tfm, sg, sg, cipher_tv[i].ilen, tweaks);
+					break;
+				}
 			}
-		
-			if (enc)
-				ret = crypto_cipher_encrypt(tfm, sg, sg, cipher_tv[i].ilen);
-			else
-				ret = crypto_cipher_decrypt(tfm, sg, sg, cipher_tv[i].ilen);
-			
-				
+
 			if (ret) {
 				printk("%s () failed flags=%x\n", e, tfm->crt_flags);
 				goto out;
@@ -384,16 +409,28 @@
 				sg[k].length = cipher_tv[i].tap[k];
 			}
 			
-			if (!mode) {
+			switch(mode) {
+			case MODE_CBC:
 				crypto_cipher_set_iv(tfm, cipher_tv[i].iv,
-						crypto_tfm_alg_ivsize (tfm));
+						     crypto_tfm_alg_ivsize (tfm));
+				/* fall-through intentional */
+			case MODE_ECB:
+				if (enc)
+					ret = crypto_cipher_encrypt(tfm, sg, sg, cipher_tv[i].ilen);
+				else
+					ret = crypto_cipher_decrypt(tfm, sg, sg, cipher_tv[i].ilen);
+				break;
+			case MODE_LRW:
+				tweaks[0].page = virt_to_page(cipher_tv[i].tweak);
+				tweaks[0].offset = offset_in_page(cipher_tv[i].tweak);
+				tweaks[0].length = cipher_tv[i].tlen;
+				if (enc)
+					ret = crypto_cipher_encrypt_tweaks(tfm, sg, sg, cipher_tv[i].ilen, tweaks);
+				else
+					ret = crypto_cipher_decrypt_tweaks(tfm, sg, sg, cipher_tv[i].ilen, tweaks);
+				break;
 			}
-			
-			if (enc)
-				ret = crypto_cipher_encrypt(tfm, sg, sg, cipher_tv[i].ilen);
-			else
-				ret = crypto_cipher_decrypt(tfm, sg, sg, cipher_tv[i].ilen);
-			
+
 			if (ret) {
 				printk("%s () failed flags=%x\n", e, tfm->crt_flags);
 				goto out;
@@ -659,6 +696,9 @@
 		test_cipher ("aes", MODE_ECB, ENCRYPT, aes_enc_tv_template, AES_ENC_TEST_VECTORS);
 		test_cipher ("aes", MODE_ECB, DECRYPT, aes_dec_tv_template, AES_DEC_TEST_VECTORS);
 
+		//AES-LRW
+		test_cipher ("aes", MODE_LRW, ENCRYPT, aes_lrw_enc_tv_template, AES_LRW_ENC_TEST_VECTORS);
+
 		//CAST5
 		test_cipher ("cast5", MODE_ECB, ENCRYPT, cast5_enc_tv_template, CAST5_ENC_TEST_VECTORS);
 		test_cipher ("cast5", MODE_ECB, DECRYPT, cast5_dec_tv_template, CAST5_DEC_TEST_VECTORS);
--- 3/crypto/tcrypt.h	2005-01-20 10:16:06.000000000 +0100
+++ final/crypto/tcrypt.h	2005-01-24 11:42:16.692898608 +0100
@@ -52,6 +52,8 @@
 	char iv[MAX_IVLEN];
 	char input[48];
 	unsigned char ilen;
+	char tweak[48];
+	unsigned char tlen;
 	char result[48];
 	unsigned char rlen;
 	int np;
@@ -1780,6 +1782,82 @@
 	},
 };
 
+#define AES_LRW_ENC_TEST_VECTORS 7
+
+struct cipher_testvec aes_lrw_enc_tv_template[] = {
+	{
+		.key = { 0x45, 0x62, 0xac, 0x25, 0xf8, 0x28, 0x17, 0x6d, 0x4c, 0x26, 0x84, 0x14, 0xb5, 0x68, 0x01, 0x85,
+			 0x25, 0x8e, 0x2a, 0x05, 0xe7, 0x3e, 0x9d, 0x03, 0xee, 0x5a, 0x83, 0x0c, 0xcc, 0x09, 0x4c, 0x87 },
+		.klen = 32,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0xf1, 0xb2, 0x73, 0xcd, 0x65, 0xa3, 0xdf, 0x5f, 0xe9, 0x5d, 0x48, 0x92, 0x54, 0x63, 0x4e, 0xb8 },
+		.rlen = 16,
+	}, {
+		.key = { 0x59, 0x70, 0x47, 0x14, 0xf5, 0x57, 0x47, 0x8c, 0xd7, 0x79, 0xe8, 0x0f, 0x54, 0x88, 0x79, 0x44,
+			 0x0d, 0x48, 0xf0, 0xb7, 0xb1, 0x5a, 0x53, 0xea, 0x1c, 0xaa, 0x6b, 0x29, 0xc2, 0xca, 0xfb, 0xaf },
+		.klen = 32,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0x00, 0xc8, 0x2b, 0xae, 0x95, 0xbb, 0xcd, 0xe5, 0x27, 0x4f, 0x07, 0x69, 0xb2, 0x60, 0xe1, 0x36 },
+		.rlen = 16,
+	}, {
+		.key = { 0xd8, 0x2a, 0x91, 0x34, 0xb2, 0x6a, 0x56, 0x50, 0x30, 0xfe, 0x69, 0xe2, 0x37, 0x7f, 0x98, 0x47,
+			 0xcd, 0xf9, 0x0b, 0x16, 0x0c, 0x64, 0x8f, 0xb6, 0xb0, 0x0d, 0x0d, 0x1b, 0xae, 0x85, 0x87, 0x1f },
+		.klen = 32,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0x76, 0x32, 0x21, 0x83, 0xed, 0x8f, 0xf1, 0x82, 0xf9, 0x59, 0x62, 0x03, 0x69, 0x0e, 0x5e, 0x01 },
+		.rlen = 16,
+	}, {
+		.key = { 0x0f, 0x6a, 0xef, 0xf8, 0xd3, 0xd2, 0xbb, 0x15, 0x25, 0x83, 0xf7, 0x3c, 0x1f, 0x01, 0x28, 0x74, 0xca, 0xc6, 0xbc, 0x35, 0x4d, 0x4a, 0x65, 0x54,
+			 0x90, 0xae, 0x61, 0xcf, 0x7b, 0xae, 0xbd, 0xcc, 0xad, 0xe4, 0x94, 0xc5, 0x4a, 0x29, 0xae, 0x70 },
+		.klen = 40,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0x9c, 0x0f, 0x15, 0x2f, 0x55, 0xa2, 0xd8, 0xf0, 0xd6, 0x7b, 0x8f, 0x9e, 0x28, 0x22, 0xbc, 0x41 },
+		.rlen = 16,
+	}, {
+		.key = { 0x8a, 0xd4, 0xee, 0x10, 0x2f, 0xbd, 0x81, 0xff, 0xf8, 0x86, 0xce, 0xac, 0x93, 0xc5, 0xad, 0xc6, 0xa0, 0x19, 0x07, 0xc0, 0x9d, 0xf7, 0xbb, 0xdd,
+			 0x52, 0x13, 0xb2, 0xb7, 0xf0, 0xff, 0x11, 0xd8, 0xd6, 0x08, 0xd0, 0xcd, 0x2e, 0xb1, 0x17, 0x6f },
+		.klen = 40,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0xd4, 0x27, 0x6a, 0x7f, 0x14, 0x91, 0x3d, 0x65, 0xc8, 0x60, 0x48, 0x02, 0x87, 0xe3, 0x34, 0x06 },
+		.rlen = 16,
+	}, {
+		.key = { 0xf8, 0xd4, 0x76, 0xff, 0xd6, 0x46, 0xee, 0x6c, 0x23, 0x84, 0xcb, 0x1c, 0x77, 0xd6, 0x19, 0x5d, 0xfe, 0xf1, 0xa9, 0xf3, 0x7b, 0xbc, 0x8d, 0x21, 0xa7, 0x9c, 0x21, 0xf8, 0xcb, 0x90, 0x02, 0x89,
+		 	 0xa8, 0x45, 0x34, 0x8e, 0xc8, 0xc5, 0xb5, 0xf1, 0x26, 0xf5, 0x0e, 0x76, 0xfe, 0xfd, 0x1b, 0x1e },
+		.klen = 48,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0xbd, 0x06, 0xb8, 0xe1, 0xdb, 0x98, 0x89, 0x9e, 0xc4, 0x98, 0xe4, 0x91, 0xcf, 0x1c, 0x70, 0x2b },
+		.rlen = 16,
+	}, {
+		.key = { 0xfb, 0x76, 0x15, 0xb2, 0x3d, 0x80, 0x89, 0x1d, 0xd4, 0x70, 0x98, 0x0b, 0xc7, 0x95, 0x84, 0xc8, 0xb2, 0xfb, 0x64, 0xce, 0x60, 0x97, 0x87, 0x8d, 0x17, 0xfc, 0xe4, 0x5a, 0x49, 0xe8, 0x30, 0xb7,
+			 0x6e, 0x78, 0x17, 0xe7, 0x2d, 0x5e, 0x12, 0xd4, 0x60, 0x64, 0x04, 0x7a, 0xf1, 0x2f, 0x9e, 0x0c },
+		.klen = 48,
+		.tweak = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00 },
+		.tlen = 16,
+		.input = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 },
+		.ilen = 16,
+		.result = { 0x5b, 0x90, 0x8e, 0xc1, 0xab, 0xdd, 0x67, 0x5f, 0x3d, 0x69, 0x8a, 0x95, 0x53, 0xc8, 0x9c, 0xe5 },
+		.rlen = 16,
+	}
+};
+
 /* Cast5 test vectors from RFC 2144 */
 #define CAST5_ENC_TEST_VECTORS	3
 #define CAST5_DEC_TEST_VECTORS	3
@@ -2613,3 +2691,4 @@
 };
 
 #endif	/* _CRYPTO_TCRYPT_H */
+
