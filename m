Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264716AbUEJOla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264716AbUEJOla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUEJOla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:41:30 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:29826 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264716AbUEJOkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:40:08 -0400
Date: Mon, 10 May 2004 16:40:05 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Support for VIA PadLock crypto engine
Message-ID: <Pine.LNX.4.53.0405101637340.27527@maxipes.logix.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for reposting - before I incidentally sent the patch in base64
 encoding]

Hi,

this is the generic part of the patch that enables use of the
hardware cryptography engine in VIA C3 Nehemiah CPUs (so called PadLock
ACE).

The changes here provide a way to encrypt/decrypt the whole buffer of data
(e.g. a disk sector or a network packet), here called multiblock, without
the need to split them to single units and process block-by-block (where
block is e.g. 16 Bytes for AES algorithm). This way PadLock ACE can
encrypt/decrypt in much higher speed.

I also added some support for other modes than ECB and CBC (i.e. new are
CFB, OFB and CTR).

The next mail will contain the changes for crypto/aes.c

Michal Ludvig

diff -urp linux-2.6.5.patched/crypto/cipher.c linux-2.6.5/crypto/cipher.c
--- linux-2.6.5.patched/crypto/cipher.c	2004-04-29 10:33:05.000000000 +0200
+++ linux-2.6.5/crypto/cipher.c	2004-05-10 15:21:56.101879632 +0200
@@ -20,7 +20,31 @@
 #include "internal.h"
 #include "scatterwalk.h"

+#define CRA_CIPHER(tfm)	(tfm)->__crt_alg->cra_cipher
+
+#define DEF_TFM_FUNCTION(name,mode,encdec,iv)	\
+static int name(struct crypto_tfm *tfm,		\
+                struct scatterlist *dst,	\
+                struct scatterlist *src,	\
+		unsigned int nbytes)		\
+{						\
+	return crypt(tfm, dst, src, nbytes,	\
+		     mode, encdec, iv);		\
+}
+
+#define DEF_TFM_FUNCTION_IV(name,mode,encdec,iv)	\
+static int name(struct crypto_tfm *tfm,		\
+                struct scatterlist *dst,	\
+                struct scatterlist *src,	\
+		unsigned int nbytes, u8 *iv)	\
+{						\
+	return crypt(tfm, dst, src, nbytes,	\
+		     mode, encdec, iv);		\
+}
+
 typedef void (cryptfn_t)(void *, u8 *, const u8 *);
+typedef void (cryptblkfn_t)(void *, u8 *, const u8 *, const u8 *,
+			    size_t, int, int);
 typedef void (procfn_t)(struct crypto_tfm *, u8 *,
                         u8*, cryptfn_t, int enc, void *, int);

@@ -38,6 +62,36 @@ static inline void xor_128(u8 *a, const
 	((u32 *)a)[3] ^= ((u32 *)b)[3];
 }

+static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
+			cryptfn_t *fn, int enc, void *info, int in_place)
+{
+	u8 *iv = info;
+
+	/* Null encryption */
+	if (!iv)
+		return;
+
+	if (enc) {
+		tfm->crt_u.cipher.cit_xor_block(iv, src);
+		(*fn)(crypto_tfm_ctx(tfm), dst, iv);
+		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
+	} else {
+		u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
+		u8 *buf = in_place ? stack : dst;
+
+		(*fn)(crypto_tfm_ctx(tfm), buf, src);
+		tfm->crt_u.cipher.cit_xor_block(buf, iv);
+		memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
+		if (buf != dst)
+			memcpy(dst, buf, crypto_tfm_alg_blocksize(tfm));
+	}
+}
+
+static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
+			cryptfn_t fn, int enc, void *info, int in_place)
+{
+	(*fn)(crypto_tfm_ctx(tfm), dst, src);
+}

 /*
  * Generic encrypt/decrypt wrapper for ciphers, handles operations across
@@ -47,20 +101,92 @@ static inline void xor_128(u8 *a, const
 static int crypt(struct crypto_tfm *tfm,
 		 struct scatterlist *dst,
 		 struct scatterlist *src,
-                 unsigned int nbytes, cryptfn_t crfn,
-                 procfn_t prfn, int enc, void *info)
+		 unsigned int nbytes,
+		 int mode, int enc, void *info)
 {
+	cryptfn_t *cryptofn = NULL;
+	procfn_t *processfn = NULL;
+	cryptblkfn_t *cryptomultiblockfn = NULL;
+
 	struct scatter_walk walk_in, walk_out;
-	const unsigned int bsize = crypto_tfm_alg_blocksize(tfm);
-	u8 tmp_src[nbytes > src->length ? bsize : 0];
-	u8 tmp_dst[nbytes > dst->length ? bsize : 0];
+	size_t max_nbytes = crypto_tfm_alg_max_nbytes(tfm);
+	size_t bsize = crypto_tfm_alg_blocksize(tfm);
+	int req_align = crypto_tfm_alg_req_align(tfm);
+	int ret = 0;
+	void *index_src = NULL, *index_dst = NULL;
+	u8 *iv = info;
+	u8 *tmp_src, *tmp_dst;

 	if (!nbytes)
-		return 0;
+		return ret;

 	if (nbytes % bsize) {
 		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (mode) {
+		case CRYPTO_TFM_MODE_ECB:
+			if (CRA_CIPHER(tfm).cia_ecb)
+				cryptomultiblockfn = CRA_CIPHER(tfm).cia_ecb;
+			else {
+				cryptofn = (enc == CRYPTO_DIR_ENCRYPT) ? CRA_CIPHER(tfm).cia_encrypt : CRA_CIPHER(tfm).cia_decrypt;
+				processfn = ecb_process;
+			}
+			break;
+
+		case CRYPTO_TFM_MODE_CBC:
+			if (CRA_CIPHER(tfm).cia_cbc)
+				cryptomultiblockfn = CRA_CIPHER(tfm).cia_cbc;
+			else {
+				cryptofn = (enc == CRYPTO_DIR_ENCRYPT) ? CRA_CIPHER(tfm).cia_encrypt : CRA_CIPHER(tfm).cia_decrypt;
+				processfn = cbc_process;
+			}
+			break;
+
+		/* Until we have the appropriate {ofb,cfb,ctr}_process() functions,
+		   the following cases will return -ENOSYS if there is no HW support
+		   for the mode. */
+		case CRYPTO_TFM_MODE_OFB:
+			if (CRA_CIPHER(tfm).cia_ofb)
+				cryptomultiblockfn = CRA_CIPHER(tfm).cia_ofb;
+			else
+				return -ENOSYS;
+			break;
+
+		case CRYPTO_TFM_MODE_CFB:
+			if (CRA_CIPHER(tfm).cia_cfb)
+				cryptomultiblockfn = CRA_CIPHER(tfm).cia_cfb;
+			else
+				return -ENOSYS;
+			break;
+
+		case CRYPTO_TFM_MODE_CTR:
+			if (CRA_CIPHER(tfm).cia_ctr)
+				cryptomultiblockfn = CRA_CIPHER(tfm).cia_ctr;
+			else
+				return -ENOSYS;
+			break;
+
+		default:
+			BUG();
+	}
+
+	if (cryptomultiblockfn)
+		bsize = (max_nbytes > nbytes) ? nbytes : max_nbytes;
+
+	/* Some hardware crypto engines may require a specific
+	   alignment of the buffers. We will align the buffers
+	   already here to avoid their reallocating later. */
+	tmp_src = crypto_aligned_kmalloc(bsize, GFP_KERNEL,
+					 req_align, &index_src);
+	tmp_dst = crypto_aligned_kmalloc(bsize, GFP_KERNEL,
+					 req_align, &index_dst);
+
+	if (!index_src || !index_dst) {
+		ret = -ENOMEM;
+		goto out;
 	}

 	scatterwalk_start(&walk_in, src);
@@ -71,16 +197,23 @@ static int crypt(struct crypto_tfm *tfm,

 		scatterwalk_map(&walk_in, 0);
 		scatterwalk_map(&walk_out, 1);
+
 		src_p = scatterwalk_whichbuf(&walk_in, bsize, tmp_src);
 		dst_p = scatterwalk_whichbuf(&walk_out, bsize, tmp_dst);

-		nbytes -= bsize;
-
 		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);

-		prfn(tfm, dst_p, src_p, crfn, enc, info,
-		     scatterwalk_samebuf(&walk_in, &walk_out,
-					 src_p, dst_p));
+		nbytes -= bsize;
+
+		if (cryptomultiblockfn)
+			(*cryptomultiblockfn)(crypto_tfm_ctx(tfm),
+					   dst_p, src_p, iv, bsize, enc,
+					   scatterwalk_samebuf(&walk_in, &walk_out,
+							       src_p, dst_p));
+		else
+			(*processfn)(tfm, dst_p, src_p, cryptofn, enc, info,
+				  scatterwalk_samebuf(&walk_in, &walk_out,
+						      src_p, dst_p));

 		scatterwalk_done(&walk_in, 0, nbytes);

@@ -88,46 +221,23 @@ static int crypt(struct crypto_tfm *tfm,
 		scatterwalk_done(&walk_out, 1, nbytes);

 		if (!nbytes)
-			return 0;
+			goto out;

 		crypto_yield(tfm);
 	}
-}

-static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
-{
-	u8 *iv = info;
-
-	/* Null encryption */
-	if (!iv)
-		return;
-
-	if (enc) {
-		tfm->crt_u.cipher.cit_xor_block(iv, src);
-		fn(crypto_tfm_ctx(tfm), dst, iv);
-		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
-	} else {
-		u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
-		u8 *buf = in_place ? stack : dst;
+out:
+	if (index_src)
+		kfree(index_src);
+	if (index_dst)
+		kfree(index_dst);

-		fn(crypto_tfm_ctx(tfm), buf, src);
-		tfm->crt_u.cipher.cit_xor_block(buf, iv);
-		memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
-		if (buf != dst)
-			memcpy(dst, buf, crypto_tfm_alg_blocksize(tfm));
-	}
-}
-
-static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
-{
-	fn(crypto_tfm_ctx(tfm), dst, src);
+	return ret;
 }

 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 {
-	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg *cia = &CRA_CIPHER(tfm);

 	if (keylen < cia->cia_min_keysize || keylen > cia->cia_max_keysize) {
 		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
@@ -137,80 +247,28 @@ static int setkey(struct crypto_tfm *tfm
 		                       &tfm->crt_flags);
 }

-static int ecb_encrypt(struct crypto_tfm *tfm,
-		       struct scatterlist *dst,
-                       struct scatterlist *src, unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             ecb_process, 1, NULL);
-}
-
-static int ecb_decrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
-		       unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             ecb_process, 1, NULL);
-}
-
-static int cbc_encrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
-		       unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, tfm->crt_cipher.cit_iv);
-}
-
-static int cbc_encrypt_iv(struct crypto_tfm *tfm,
-                          struct scatterlist *dst,
-                          struct scatterlist *src,
-                          unsigned int nbytes, u8 *iv)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, iv);
-}
+DEF_TFM_FUNCTION(ecb_encrypt, CRYPTO_TFM_MODE_ECB, CRYPTO_DIR_ENCRYPT, NULL);
+DEF_TFM_FUNCTION(ecb_decrypt, CRYPTO_TFM_MODE_ECB, CRYPTO_DIR_DECRYPT, NULL);

-static int cbc_decrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
-		       unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, tfm->crt_cipher.cit_iv);
-}
-
-static int cbc_decrypt_iv(struct crypto_tfm *tfm,
-                          struct scatterlist *dst,
-                          struct scatterlist *src,
-                          unsigned int nbytes, u8 *iv)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, iv);
-}
-
-static int nocrypt(struct crypto_tfm *tfm,
-                   struct scatterlist *dst,
-                   struct scatterlist *src,
-		   unsigned int nbytes)
-{
-	return -ENOSYS;
-}
-
-static int nocrypt_iv(struct crypto_tfm *tfm,
-                      struct scatterlist *dst,
-                      struct scatterlist *src,
-                      unsigned int nbytes, u8 *iv)
-{
-	return -ENOSYS;
-}
+DEF_TFM_FUNCTION(cbc_encrypt, CRYPTO_TFM_MODE_CBC, CRYPTO_DIR_ENCRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(cbc_encrypt_iv, CRYPTO_TFM_MODE_CBC, CRYPTO_DIR_ENCRYPT, iv);
+DEF_TFM_FUNCTION(cbc_decrypt, CRYPTO_TFM_MODE_CBC, CRYPTO_DIR_DECRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(cbc_decrypt_iv, CRYPTO_TFM_MODE_CBC, CRYPTO_DIR_DECRYPT, iv);
+
+DEF_TFM_FUNCTION(cfb_encrypt, CRYPTO_TFM_MODE_CFB, CRYPTO_DIR_ENCRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(cfb_encrypt_iv, CRYPTO_TFM_MODE_CFB, CRYPTO_DIR_ENCRYPT, iv);
+DEF_TFM_FUNCTION(cfb_decrypt, CRYPTO_TFM_MODE_CFB, CRYPTO_DIR_DECRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(cfb_decrypt_iv, CRYPTO_TFM_MODE_CFB, CRYPTO_DIR_DECRYPT, iv);
+
+DEF_TFM_FUNCTION(ofb_encrypt, CRYPTO_TFM_MODE_OFB, CRYPTO_DIR_ENCRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(ofb_encrypt_iv, CRYPTO_TFM_MODE_OFB, CRYPTO_DIR_ENCRYPT, iv);
+DEF_TFM_FUNCTION(ofb_decrypt, CRYPTO_TFM_MODE_OFB, CRYPTO_DIR_DECRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(ofb_decrypt_iv, CRYPTO_TFM_MODE_OFB, CRYPTO_DIR_DECRYPT, iv);
+
+DEF_TFM_FUNCTION(ctr_encrypt, CRYPTO_TFM_MODE_CTR, CRYPTO_DIR_ENCRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(ctr_encrypt_iv, CRYPTO_TFM_MODE_CTR, CRYPTO_DIR_ENCRYPT, iv);
+DEF_TFM_FUNCTION(ctr_decrypt, CRYPTO_TFM_MODE_CTR, CRYPTO_DIR_DECRYPT, tfm->crt_cipher.cit_iv);
+DEF_TFM_FUNCTION_IV(ctr_decrypt_iv, CRYPTO_TFM_MODE_CTR, CRYPTO_DIR_DECRYPT, iv);

 int crypto_init_cipher_flags(struct crypto_tfm *tfm, u32 flags)
 {
@@ -244,17 +302,24 @@ int crypto_init_cipher_ops(struct crypto
 		break;

 	case CRYPTO_TFM_MODE_CFB:
-		ops->cit_encrypt = nocrypt;
-		ops->cit_decrypt = nocrypt;
-		ops->cit_encrypt_iv = nocrypt_iv;
-		ops->cit_decrypt_iv = nocrypt_iv;
+		ops->cit_encrypt = cfb_encrypt;
+		ops->cit_decrypt = cfb_decrypt;
+		ops->cit_encrypt_iv = cfb_encrypt_iv;
+		ops->cit_decrypt_iv = cfb_decrypt_iv;
+		break;
+
+	case CRYPTO_TFM_MODE_OFB:
+		ops->cit_encrypt = ofb_encrypt;
+		ops->cit_decrypt = ofb_decrypt;
+		ops->cit_encrypt_iv = ofb_encrypt_iv;
+		ops->cit_decrypt_iv = ofb_decrypt_iv;
 		break;

 	case CRYPTO_TFM_MODE_CTR:
-		ops->cit_encrypt = nocrypt;
-		ops->cit_decrypt = nocrypt;
-		ops->cit_encrypt_iv = nocrypt_iv;
-		ops->cit_decrypt_iv = nocrypt_iv;
+		ops->cit_encrypt = ctr_encrypt;
+		ops->cit_decrypt = ctr_decrypt;
+		ops->cit_encrypt_iv = ctr_encrypt_iv;
+		ops->cit_decrypt_iv = ctr_decrypt_iv;
 		break;

 	default:
diff -urp linux-2.6.5.patched/crypto/api.c linux-2.6.5/crypto/api.c
--- linux-2.6.5.patched/crypto/api.c	2004-04-29 10:33:05.000000000 +0200
+++ linux-2.6.5/crypto/api.c	2004-05-10 15:20:41.040290728 +0200
@@ -213,6 +213,19 @@ int crypto_alg_available(const char *nam
 	return ret;
 }

+void *crypto_aligned_kmalloc (size_t size, int mode, size_t alignment, void **index)
+{
+	char *ptr;
+
+	ptr = kmalloc(size + alignment, mode);
+	*index = ptr;
+	if (alignment > 1 && ((long)ptr & (alignment - 1))) {
+		ptr += alignment - ((long)ptr & (alignment - 1));
+	}
+
+	return ptr;
+}
+
 static int __init init_crypto(void)
 {
 	printk(KERN_INFO "Initializing Cryptographic API\n");
@@ -227,3 +240,4 @@ EXPORT_SYMBOL_GPL(crypto_unregister_alg)
 EXPORT_SYMBOL_GPL(crypto_alloc_tfm);
 EXPORT_SYMBOL_GPL(crypto_free_tfm);
 EXPORT_SYMBOL_GPL(crypto_alg_available);
+EXPORT_SYMBOL_GPL(crypto_aligned_kmalloc);
diff -urp linux-2.6.5.patched/include/linux/crypto.h linux-2.6.5/include/linux/crypto.h
--- linux-2.6.5.patched/include/linux/crypto.h	2004-04-29 10:32:25.000000000 +0200
+++ linux-2.6.5/include/linux/crypto.h	2004-05-10 13:21:22.000000000 +0200
@@ -42,6 +42,7 @@
 #define CRYPTO_TFM_MODE_CBC		0x00000002
 #define CRYPTO_TFM_MODE_CFB		0x00000004
 #define CRYPTO_TFM_MODE_CTR		0x00000008
+#define CRYPTO_TFM_MODE_OFB		0x00000010

 #define CRYPTO_TFM_REQ_WEAK_KEY		0x00000100
 #define CRYPTO_TFM_RES_WEAK_KEY		0x00100000
@@ -56,6 +57,9 @@
 #define CRYPTO_UNSPEC			0
 #define CRYPTO_MAX_ALG_NAME		64

+#define CRYPTO_DIR_ENCRYPT		1
+#define CRYPTO_DIR_DECRYPT		0
+
 struct scatterlist;

 /*
@@ -69,6 +73,18 @@ struct cipher_alg {
 	                  unsigned int keylen, u32 *flags);
 	void (*cia_encrypt)(void *ctx, u8 *dst, const u8 *src);
 	void (*cia_decrypt)(void *ctx, u8 *dst, const u8 *src);
+	size_t cia_max_nbytes;
+	size_t cia_req_align;
+	void (*cia_ecb)(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			size_t nbytes, int encdec, int inplace);
+	void (*cia_cbc)(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			size_t nbytes, int encdec, int inplace);
+	void (*cia_cfb)(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			size_t nbytes, int encdec, int inplace);
+	void (*cia_ofb)(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			size_t nbytes, int encdec, int inplace);
+	void (*cia_ctr)(void *ctx, u8 *dst, const u8 *src, const u8 *iv,
+			size_t nbytes, int encdec, int inplace);
 };

 struct digest_alg {
@@ -121,6 +137,11 @@ int crypto_unregister_alg(struct crypto_
 int crypto_alg_available(const char *name, u32 flags);

 /*
+ * Helper function.
+ */
+void *crypto_aligned_kmalloc (size_t size, int mode, size_t alignment, void **index);
+
+/*
  * Transforms: user-instantiated objects which encapsulate algorithms
  * and core processing logic.  Managed via crypto_alloc_tfm() and
  * crypto_free_tfm(), as well as the various helpers below.
@@ -255,6 +276,18 @@ static inline unsigned int crypto_tfm_al
 	return tfm->__crt_alg->cra_digest.dia_digestsize;
 }

+static inline unsigned int crypto_tfm_alg_max_nbytes(struct crypto_tfm *tfm)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
+	return tfm->__crt_alg->cra_cipher.cia_max_nbytes;
+}
+
+static inline unsigned int crypto_tfm_alg_req_align(struct crypto_tfm *tfm)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
+	return tfm->__crt_alg->cra_cipher.cia_req_align;
+}
+
 /*
  * API wrappers.
  */
