Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVBHQli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVBHQli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVBHQli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:41:38 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:35857 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261580AbVBHQjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:39:24 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <1107878930.15942.103.camel@ghanima>
References: <Xine.LNX.4.44.0502080926380.32035-100000@thoron.boston.redhat.com>
	 <1107878930.15942.103.camel@ghanima>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Feb 2005 17:39:19 +0100
Message-Id: <1107880759.15942.109.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 17:08 +0100, Fruhwirth Clemens wrote:
> On Tue, 2005-02-08 at 09:48 -0500, James Morris wrote:
> > On Sat, 5 Feb 2005, Fruhwirth Clemens wrote:
> >
> > > + * The generic scatterwalker applies a certain function, pf, utilising
> > > + * an arbitrary number of scatterlist data as it's arguments. These
> > > + * arguments are supplied as an array of pointers to buffers. These
> > > + * buffers are prepared and processed block-wise by the function
> > > + * (stepsize) and might be input or output buffers.
> > 
> > This is not going to work generically, as there number of atomic kmaps
> > available is limited.  You have four: one for input and one for output,
> > each in user in softirq context (hence the list in crypto_km_types).  A
> > thread of execution can only use two at once (input & output).  The crypto
> > code is written around this: processing a cleartext and ciphertext block
> > simultaneously.
> 
> I added a usemap, keeping track of what slots are used, so we do have
> the speed gain of kmap_atomic, if possible, and the option to fall-back
> to kmap (regular) when the slots are exhausted.

I shot out the last patch too quickly. Having reviewed the mapping one
more time I noticed, that there as the possibility of "off-by-one"
unmapping, and instead of doing doubtful guesses, if that's the case, I
added a base pointer to scatter_walk, which is the pointer returned by
kmap. Exactly this pointer will be unmapped again, so the vaddr
comparison in crypto_kunmap doesn't have to do any masking.

--- 1/crypto/cipher.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/cipher.c	2005-02-05 09:52:30.000000000 +0100
@@ -22,7 +22,7 @@
 
 typedef void (cryptfn_t)(void *, u8 *, const u8 *);
 typedef void (procfn_t)(struct crypto_tfm *, u8 *,
-                        u8*, cryptfn_t, int enc, void *, int);
+			u8*, cryptfn_t, int enc, void *, int);
 
 static inline void xor_64(u8 *a, const u8 *b)
 {
@@ -38,177 +38,219 @@
 	((u32 *)a)[3] ^= ((u32 *)b)[3];
 }
 
+static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+{
+	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
+	
+	if (keylen < cia->cia_min_keysize || keylen > cia->cia_max_keysize) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	} else
+		return cia->cia_setkey(crypto_tfm_ctx(tfm), key, keylen,
+				       &tfm->crt_flags);
+}
 
 /* 
- * Generic encrypt/decrypt wrapper for ciphers, handles operations across
- * multiple page boundaries by using temporary blocks.  In user context,
- * the kernel is given a chance to schedule us once per block.
+ * Electronic Code Book (ECB) mode implementation 
  */
-static int crypt(struct crypto_tfm *tfm,
-		 struct scatterlist *dst,
-		 struct scatterlist *src,
-                 unsigned int nbytes, cryptfn_t crfn,
-                 procfn_t prfn, int enc, void *info)
-{
-	struct scatter_walk walk_in, walk_out;
-	const unsigned int bsize = crypto_tfm_alg_blocksize(tfm);
-	u8 tmp_src[bsize];
-	u8 tmp_dst[bsize];
+
+struct ecb_process_priv {
+	struct crypto_tfm	*tfm;
+	cryptfn_t		*crfn;
+};
+
+static int ecb_process_gw(void *priv, int nsg, void **buf) 
+{
+	struct ecb_process_priv *ecb_priv = priv;
+	ecb_priv->crfn(crypto_tfm_ctx(ecb_priv->tfm), buf[0], buf[1]);
+	return 0;
+}
+
+static inline int ecb_template(struct crypto_tfm *tfm,
+			       struct scatterlist *dst,
+			       struct scatterlist *src, unsigned int nbytes, cryptfn_t crfn)
+{
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+
+	struct ecb_process_priv priv = { 
+		.tfm = tfm,
+		.crfn = crfn,
+	};
+
+	struct walk_info ecb_info[3];
+
+	scatterwalk_info_init(ecb_info+0, dst, bsize, (char[bsize]){}, 
+			      SCATTERWALK_IO_OUTPUT);
+	scatterwalk_info_init(ecb_info+1, src, bsize, (char[bsize]){}, 
+			      SCATTERWALK_IO_INPUT);
+	scatterwalk_info_endtag(ecb_info+2);
 
 	if (!nbytes)
 		return 0;
-
 	if (nbytes % bsize) {
 		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
 		return -EINVAL;
 	}
 
-	scatterwalk_start(&walk_in, src);
-	scatterwalk_start(&walk_out, dst);
-
-	for(;;) {
-		u8 *src_p, *dst_p;
-		int in_place;
-
-		scatterwalk_map(&walk_in, 0);
-		scatterwalk_map(&walk_out, 1);
-		src_p = scatterwalk_whichbuf(&walk_in, bsize, tmp_src);
-		dst_p = scatterwalk_whichbuf(&walk_out, bsize, tmp_dst);
-		in_place = scatterwalk_samebuf(&walk_in, &walk_out,
-					       src_p, dst_p);
-
-		nbytes -= bsize;
-
-		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
-
-		prfn(tfm, dst_p, src_p, crfn, enc, info, in_place);
-
-		scatterwalk_done(&walk_in, 0, nbytes);
-
-		scatterwalk_copychunks(dst_p, &walk_out, bsize, 1);
-		scatterwalk_done(&walk_out, 1, nbytes);
-
-		if (!nbytes)
-			return 0;
+	return scatterwalk_walk(ecb_process_gw, &priv, nbytes/bsize, ecb_info);
+}
 
-		crypto_yield(tfm);
-	}
+static int ecb_encrypt(struct crypto_tfm *tfm,
+		       struct scatterlist *dst,
+		       struct scatterlist *src,
+		       unsigned int nbytes)
+{
+	return ecb_template(tfm,dst,src,nbytes,tfm->__crt_alg->cra_cipher.cia_encrypt);
 }
 
-static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
+static int ecb_decrypt(struct crypto_tfm *tfm,
+		       struct scatterlist *dst,
+		       struct scatterlist *src,
+		       unsigned int nbytes)
 {
-	u8 *iv = info;
+	return ecb_template(tfm,dst,src,nbytes,tfm->__crt_alg->cra_cipher.cia_decrypt);
+}
+
+/* Cipher Block Chaining (CBC) mode implementation */
+
+struct cbc_process_priv {
+	struct crypto_tfm *tfm;
+	int enc;
+	cryptfn_t *crfn;
+	u8 *curr_iv;
+	u8 *next_iv;
+};
+
+static int cbc_process_gw(void *priv, int nsg, void **buf) 
+{
+	struct cbc_process_priv *cbc_priv = priv;
+	u8 *iv = cbc_priv->curr_iv;
+	struct crypto_tfm *tfm = cbc_priv->tfm;
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	u8 *dst = buf[0];
+	u8 *src = buf[1];
 	
 	/* Null encryption */
 	if (!iv)
-		return;
-		
-	if (enc) {
+		return 0;
+
+	if (cbc_priv->enc == CRYPTO_DIR_ENCRYPT) {
+		/* Encryption can be done in place */
 		tfm->crt_u.cipher.cit_xor_block(iv, src);
-		fn(crypto_tfm_ctx(tfm), dst, iv);
-		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
+		cbc_priv->crfn(crypto_tfm_ctx(tfm), dst, iv);
+		memcpy(iv, dst, bsize);
 	} else {
-		u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
-		u8 *buf = in_place ? stack : dst;
-
-		fn(crypto_tfm_ctx(tfm), buf, src);
-		tfm->crt_u.cipher.cit_xor_block(buf, iv);
-		memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
-		if (buf != dst)
-			memcpy(dst, buf, crypto_tfm_alg_blocksize(tfm));
+		/* Current cipher text in "src" needs to be saved, as
+		 * it's going to be the next iv, exchange IV buffers
+		 * after processing
+		 */
+		memcpy(cbc_priv->next_iv,src,bsize);
+		cbc_priv->crfn(crypto_tfm_ctx(tfm), dst, src);
+		tfm->crt_u.cipher.cit_xor_block(dst, iv);
+		cbc_priv->curr_iv = cbc_priv->next_iv;
+		cbc_priv->next_iv = iv;
 	}
+	return 0;
 }
 
-static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
-{
-	fn(crypto_tfm_ctx(tfm), dst, src);
-}
 
-static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
-{
-	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
-	
-	if (keylen < cia->cia_min_keysize || keylen > cia->cia_max_keysize) {
-		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+static int cbc_encrypt_iv(struct crypto_tfm *tfm,
+			  struct scatterlist *dst,
+			  struct scatterlist *src,
+			  unsigned int nbytes, u8 *iv)
+{
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+
+	struct cbc_process_priv priv = {
+		.tfm = tfm,
+		.enc = CRYPTO_DIR_ENCRYPT,
+		.curr_iv = iv,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_encrypt
+	};
+
+	struct walk_info cbc_info[3];
+
+	if (!nbytes)
+		return 0;
+	if (nbytes % bsize) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
 		return -EINVAL;
-	} else
-		return cia->cia_setkey(crypto_tfm_ctx(tfm), key, keylen,
-		                       &tfm->crt_flags);
-}
+	}
 
-static int ecb_encrypt(struct crypto_tfm *tfm,
-		       struct scatterlist *dst,
-                       struct scatterlist *src, unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             ecb_process, 1, NULL);
-}
+	scatterwalk_info_init(cbc_info+0, dst, bsize, (char[bsize]){}, 
+			      SCATTERWALK_IO_OUTPUT);
+	scatterwalk_info_init(cbc_info+1, src, bsize, (char[bsize]){}, 
+			      SCATTERWALK_IO_INPUT); 
+	scatterwalk_info_endtag(cbc_info+2);
 
-static int ecb_decrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
-		       unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             ecb_process, 1, NULL);
+	return scatterwalk_walk(cbc_process_gw, &priv, nbytes/bsize, cbc_info);
 }
 
-static int cbc_encrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
-		       unsigned int nbytes)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, tfm->crt_cipher.cit_iv);
-}
+static int cbc_decrypt_iv(struct crypto_tfm *tfm,
+			  struct scatterlist *dst,
+			  struct scatterlist *src,
+			  unsigned int nbytes, u8 *iv)
+{
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	int r = -EINVAL;
+
+	char scratch1[bsize]; 
+
+	struct cbc_process_priv priv = {
+		.tfm = tfm,
+		.enc = CRYPTO_DIR_DECRYPT,
+		.curr_iv = iv,
+		.next_iv = scratch1,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_decrypt,
+	};
+	struct walk_info cbc_info[3];
 
-static int cbc_encrypt_iv(struct crypto_tfm *tfm,
-                          struct scatterlist *dst,
-                          struct scatterlist *src,
-                          unsigned int nbytes, u8 *iv)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, iv);
+	if (!nbytes)
+		return 0;
+	if (nbytes % bsize) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
+		return -EINVAL;
+	}
+
+	scatterwalk_info_init(cbc_info+0, dst, bsize, (char[bsize]){}, SCATTERWALK_IO_OUTPUT);
+	scatterwalk_info_init(cbc_info+1, src, bsize, (char[bsize]){}, SCATTERWALK_IO_INPUT);
+	scatterwalk_info_endtag(cbc_info+2);
+
+	r = scatterwalk_walk(cbc_process_gw, &priv, nbytes/bsize, cbc_info);
+
+	if (priv.curr_iv != iv) 
+		memcpy(iv,priv.curr_iv,bsize);
+	return r;
 }
 
 static int cbc_decrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
+		       struct scatterlist *dst,
+		       struct scatterlist *src,
 		       unsigned int nbytes)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, tfm->crt_cipher.cit_iv);
+	return cbc_decrypt_iv(tfm, dst, src, nbytes, tfm->crt_cipher.cit_iv);
 }
 
-static int cbc_decrypt_iv(struct crypto_tfm *tfm,
-                          struct scatterlist *dst,
-                          struct scatterlist *src,
-                          unsigned int nbytes, u8 *iv)
-{
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, iv);
+static int cbc_encrypt(struct crypto_tfm *tfm,
+		       struct scatterlist *dst,
+		       struct scatterlist *src,
+		       unsigned int nbytes)
+{
+	return cbc_encrypt_iv(tfm, dst, src, nbytes, tfm->crt_cipher.cit_iv);
 }
 
 static int nocrypt(struct crypto_tfm *tfm,
-                   struct scatterlist *dst,
-                   struct scatterlist *src,
+		   struct scatterlist *dst,
+		   struct scatterlist *src,
 		   unsigned int nbytes)
 {
 	return -ENOSYS;
 }
 
 static int nocrypt_iv(struct crypto_tfm *tfm,
-                      struct scatterlist *dst,
-                      struct scatterlist *src,
-                      unsigned int nbytes, u8 *iv)
+		      struct scatterlist *dst,
+		      struct scatterlist *src,
+		      unsigned int nbytes, u8 *iv)
 {
 	return -ENOSYS;
 }
@@ -263,26 +305,26 @@
 	}
 	
 	if (ops->cit_mode == CRYPTO_TFM_MODE_CBC) {
-	    	
-	    	switch (crypto_tfm_alg_blocksize(tfm)) {
-	    	case 8:
-	    		ops->cit_xor_block = xor_64;
-	    		break;
-	    		
-	    	case 16:
-	    		ops->cit_xor_block = xor_128;
-	    		break;
-	    		
-	    	default:
-	    		printk(KERN_WARNING "%s: block size %u not supported\n",
-	    		       crypto_tfm_alg_name(tfm),
-	    		       crypto_tfm_alg_blocksize(tfm));
-	    		ret = -EINVAL;
-	    		goto out;
-	    	}
-	    	
+		
+		switch (crypto_tfm_alg_blocksize(tfm)) {
+		case 8:
+			ops->cit_xor_block = xor_64;
+			break;
+			
+		case 16:
+			ops->cit_xor_block = xor_128;
+			break;
+			
+		default:
+			printk(KERN_WARNING "%s: block size %u not supported\n",
+			       crypto_tfm_alg_name(tfm),
+			       crypto_tfm_alg_blocksize(tfm));
+			ret = -EINVAL;
+			goto out;
+		}
+		
 		ops->cit_ivsize = crypto_tfm_alg_blocksize(tfm);
-	    	ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
+		ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
 		if (ops->cit_iv == NULL)
 			ret = -ENOMEM;
 	}
--- 1/crypto/scatterwalk.h	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/scatterwalk.h	2005-02-08 17:29:58.000000000 +0100
@@ -4,6 +4,7 @@
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  * Copyright (c) 2002 Adam J. Richter <adam@yggdrasil.com>
  * Copyright (c) 2004 Jean-Luc Cooke <jlcooke@certainkey.com>
+ * Copyright (c) 2005 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -16,16 +17,28 @@
 #define _CRYPTO_SCATTERWALK_H
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
+#include <linux/pagemap.h>
 
 struct scatter_walk {
 	struct scatterlist	*sg;
 	struct page		*page;
 	void			*data;
+	void                    *base;
 	unsigned int		len_this_page;
 	unsigned int		len_this_segment;
 	unsigned int		offset;
 };
 
+struct walk_info {
+	struct scatter_walk   sw;
+	int                   stepsize;
+	int                   ioflag;
+	char                  *buf;
+};
+
+#define SCATTERWALK_IO_OUTPUT  1
+#define SCATTERWALK_IO_INPUT   0
+
 /* Define sg_next is an inline routine now in case we want to change
    scatterlist to a linked list later. */
 static inline struct scatterlist *sg_next(struct scatterlist *sg)
@@ -33,19 +46,16 @@
 	return sg + 1;
 }
 
-static inline int scatterwalk_samebuf(struct scatter_walk *walk_in,
-				      struct scatter_walk *walk_out,
-				      void *src_p, void *dst_p)
-{
-	return walk_in->page == walk_out->page &&
-	       walk_in->offset == walk_out->offset &&
-	       walk_in->data == src_p && walk_out->data == dst_p;
-}
+typedef int (*sw_proc_func_t)(void *priv, int length, void **buflist);
+
+/* If the following functions are ever going to be exported symbols, I 
+ * request them to be GPL-only symbols. Thanks, -- clemens@endorphin.org */
+
+int scatterwalk_walk(sw_proc_func_t function, void *priv, int steps, struct walk_info *walk_info_l);
+
+void scatterwalk_info_endtag(struct walk_info *);
+
+void scatterwalk_info_init(struct walk_info *winfo, struct scatterlist *sg, int stepsize, void *buf, int io);
 
-void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
-void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
-int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
-void scatterwalk_map(struct scatter_walk *walk, int out);
-void scatterwalk_done(struct scatter_walk *walk, int out, int more);
 
 #endif  /* _CRYPTO_SCATTERWALK_H */
--- 1/crypto/scatterwalk.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/scatterwalk.c	2005-02-08 17:35:00.000000000 +0100
@@ -6,6 +6,7 @@
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  *               2002 Adam J. Richter <adam@yggdrasil.com>
  *               2004 Jean-Luc Cooke <jlcooke@certainkey.com>
+ *               2005 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -28,17 +29,7 @@
 	KM_SOFTIRQ1,
 };
 
-void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
-{
-	if (nbytes <= walk->len_this_page &&
-	    (((unsigned long)walk->data) & (PAGE_CACHE_SIZE - 1)) + nbytes <=
-	    PAGE_CACHE_SIZE)
-		return walk->data;
-	else
-		return scratch;
-}
-
-static void memcpy_dir(void *buf, void *sgdata, size_t nbytes, int out)
+static inline void memcpy_dir(void *buf, void *sgdata, size_t nbytes, int out)
 {
 	if (out)
 		memcpy(sgdata, buf, nbytes);
@@ -46,7 +37,12 @@
 		memcpy(buf, sgdata, nbytes);
 }
 
-void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
+static inline int scatterwalk_noscratch(struct scatter_walk *walk, int nbytes) 
+{
+	return (nbytes <= walk->len_this_page);
+}
+
+static inline void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
 {
 	unsigned int rest_of_page;
 
@@ -55,23 +51,43 @@
 	walk->page = sg->page;
 	walk->len_this_segment = sg->length;
 
-	rest_of_page = PAGE_CACHE_SIZE - (sg->offset & (PAGE_CACHE_SIZE - 1));
+	rest_of_page = PAGE_SIZE - sg->offset;
 	walk->len_this_page = min(sg->length, rest_of_page);
 	walk->offset = sg->offset;
 }
 
-void scatterwalk_map(struct scatter_walk *walk, int out)
+/*
+ * The scatterwalk_info_init function initialzes a walk_info struct 
+ * sg       .. pointer to the scatterlist to be processed 
+ * stepsize .. size of the data processed by one step of scatterwalk_walk
+ * buf      .. scratch buffer at least as stepsize-wide.
+ * io       .. set to SCATTERWALK_IO_INPUT or SCATTERWALK_IO_OUTPUT
+ */
+
+void scatterwalk_info_init(struct walk_info *winfo, struct scatterlist *sg, 
+			   int stepsize, void *buf, int io)
 {
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+	scatterwalk_start(&winfo->sw, sg);
+	winfo->stepsize = stepsize;
+	winfo->ioflag = io;
+	winfo->buf = buf;
 }
 
-static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
-				 unsigned int more)
+void scatterwalk_info_endtag(struct walk_info *winfo)
 {
-	/* walk->data may be pointing the first byte of the next page;
-	   however, we know we transfered at least one byte.  So,
-	   walk->data - 1 will be a virtual address in the mapped page. */
+	winfo->sw.sg = NULL;
+}
+
+
+static void scatterwalk_map(struct scatter_walk *walk, int out, void *usemap[]) 
+{
+	walk->base = crypto_kmap(walk->page, out, usemap);
+	walk->data = walk->base + walk->offset; 
+}
 
+static inline void scatterwalk_pagedone(struct scatter_walk *walk, int out,
+				 unsigned int more)
+{
 	if (out)
 		flush_dcache_page(walk->page);
 
@@ -81,7 +97,7 @@
 		if (walk->len_this_segment) {
 			walk->page++;
 			walk->len_this_page = min(walk->len_this_segment,
-						  (unsigned)PAGE_CACHE_SIZE);
+						  (unsigned)PAGE_SIZE);
 			walk->offset = 0;
 		}
 		else
@@ -89,36 +105,109 @@
 	}
 }
 
-void scatterwalk_done(struct scatter_walk *walk, int out, int more)
-{
-	crypto_kunmap(walk->data, out);
-	if (walk->len_this_page == 0 || !more)
-		scatterwalk_pagedone(walk, out, more);
-}
-
-/*
- * Do not call this unless the total length of all of the fragments
- * has been verified as multiple of the block size.
- */
-int scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
-			   size_t nbytes, int out)
+static inline void scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
+			    size_t nbytes, int out, void *usemap[])
 {
 	if (buf != walk->data) {
 		while (nbytes > walk->len_this_page) {
-			memcpy_dir(buf, walk->data, walk->len_this_page, out);
-			buf += walk->len_this_page;
-			nbytes -= walk->len_this_page;
-
-			crypto_kunmap(walk->data, out);
-			scatterwalk_pagedone(walk, out, 1);
-			scatterwalk_map(walk, out);
+			if (walk->len_this_page) {
+				memcpy_dir(buf, walk->data, walk->len_this_page, out);
+				buf += walk->len_this_page;
+				nbytes -= walk->len_this_page;
+			}
+			crypto_kunmap(walk->base, walk->page, out, usemap);
+			scatterwalk_pagedone(walk, 
+					     out, 
+					     1); /* more processing steps */
+			scatterwalk_map(walk, out, usemap);
 		}
-
 		memcpy_dir(buf, walk->data, nbytes, out);
 	}
-
+	walk->data += nbytes;
 	walk->offset += nbytes;
 	walk->len_this_page -= nbytes;
 	walk->len_this_segment -= nbytes;
-	return 0;
+}
+
+/*  
+ * The generic scatterwalker can manipulate data associated with one
+ * or more scatterlist with a processing function, pf. It's purpose is
+ * to hide the mapping, unalignment and page switching logic.
+ * 
+ * The generic scatterwalker applies a certain function, pf, utilising
+ * an arbitrary number of scatterlist data as it's arguments. The scatterlist data 
+ * is handed to the pf function as an array of pointers, **buf. The pointers
+ * of buf point either directly into the kmapping of a scatterlist, or
+ * to a scratch buffer, if the scatterlist data is fragmented over a 
+ * more scatterlist vectors. All this logic is hidden in the scatterwalk_walk
+ * function, and the user of this function does not have to worry about
+ * unaligned scatterlists.
+ *
+ * Every scatterlist to be processed has to be supplied to scatterwalk_walk
+ * in a walk_info struct. There are also other information attached to
+ * this walk_info struct, such as step size or if the scatterlist is used as 
+ * input or output.
+ *
+ * The information about all scatterlists and their auxillary
+ * information is handed to scatterwalk_walk as a walk_info
+ * array. Every element of this array is initialized with
+ * scatterwalk_init_walk(..). The last element must be a terminator
+ * element and must be supplied to scatterwalk_info_endtag(..).
+ *
+ * See scatterwalk_info_init how the walk_info struct is initialized.
+ * scatterwalk_walk can be called multiple times after an initialization, 
+ * then the processing will pick up, where the previous one quitted.
+ *
+ * A list of buffers are compiled and handed to the function, as char
+ * **buf, with buf[0] corresponds to the first walk_info descriptor,
+ * buf[1] to the second, and so on. The function is also handed a priv
+ * object, which does not change. Think of it as a "this" object, to
+ * collect/store processing information.
+ */
+
+int scatterwalk_walk(sw_proc_func_t pf, void *priv, int steps,
+		     struct walk_info *walk_infos) 
+{
+	int r = -EINVAL;
+	
+	void *kmap_usage[4];
+
+	struct walk_info *csg;
+	int nsl = 0;
+
+	void **cbuf;
+	void **dispatch_list;
+
+	for (csg = walk_infos; csg->sw.sg; csg++) {
+		scatterwalk_map(&csg->sw, csg->ioflag, kmap_usage);
+		nsl++;
+	}
+
+	dispatch_list = (void *[nsl]){}; /* This alien thing is a C99 compound literal */
+
+	while (steps--) {
+		for (csg = walk_infos, cbuf = dispatch_list; csg->sw.sg; csg++, cbuf++) {
+			*cbuf = scatterwalk_noscratch(&csg->sw,csg->stepsize)?csg->sw.data:csg->buf;
+
+			if (csg->ioflag == 0)
+				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize, SCATTERWALK_IO_INPUT, kmap_usage);
+		}
+
+		r = pf(priv, nsl, dispatch_list);
+		if (unlikely(r < 0))
+			goto out;
+
+		for (csg = walk_infos, cbuf = dispatch_list; csg->sw.sg; csg++, cbuf++) {	
+			if (csg->ioflag == 1) 
+				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize, SCATTERWALK_IO_OUTPUT, kmap_usage);
+		}
+	}
+
+	r = 0;
+out:
+	for (csg = walk_infos; csg->sw.sg; csg++) {
+		crypto_kunmap(csg->sw.base, csg->sw.page, csg->ioflag, kmap_usage);
+		scatterwalk_pagedone(&csg->sw, csg->ioflag, 0);
+	}
+	return r;
 }
--- 1/crypto/internal.h	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/internal.h	2005-02-08 17:32:09.000000000 +0100
@@ -26,14 +26,26 @@
 	return crypto_km_types[(in_softirq() ? 2 : 0) + out];
 }
 
-static inline void *crypto_kmap(struct page *page, int out)
+static inline void *crypto_kmap(struct page *page, int out, void *usemap[])
 {
-	return kmap_atomic(page, crypto_kmap_type(out));
-}
-
-static inline void crypto_kunmap(void *vaddr, int out)
-{
-	kunmap_atomic(vaddr, crypto_kmap_type(out));
+	enum km_type type = crypto_kmap_type(out);
+	if(usemap[type] == NULL) {
+		void *mapping = kmap_atomic(page, type);
+		usemap[type] = mapping;
+		return mapping;
+	}
+	return kmap(page);
+}
+
+static inline void crypto_kunmap(void *vaddr, struct page *page, int out, void *usemap[])
+{
+	enum km_type type = crypto_kmap_type(out);
+	if(usemap[type] == vaddr) {
+		kunmap_atomic(vaddr, type);
+		usemap[type] = NULL;
+		return;
+	}
+	kunmap(page);
 }
 
 static inline void crypto_yield(struct crypto_tfm *tfm)
--- 1/crypto/digest.c	2005-02-08 17:04:33.000000000 +0100
+++ 2/crypto/digest.c	2005-02-08 17:04:50.000000000 +0100
@@ -27,6 +27,7 @@
                    struct scatterlist *sg, unsigned int nsg)
 {
 	unsigned int i;
+	void *kmap_usage[4];
 
 	for (i = 0; i < nsg; i++) {
 
@@ -38,12 +39,12 @@
 			unsigned int bytes_from_page = min(l, ((unsigned int)
 							   (PAGE_SIZE)) - 
 							   offset);
-			char *p = crypto_kmap(pg, 0) + offset;
+			char *p = crypto_kmap(pg, 0, kmap_usage) + offset;
 
 			tfm->__crt_alg->cra_digest.dia_update
 					(crypto_tfm_ctx(tfm), p,
 					 bytes_from_page);
-			crypto_kunmap(p, 0);
+			crypto_kunmap(p, pg, 0, kmap_usage);
 			crypto_yield(tfm);
 			offset = 0;
 			pg++;
@@ -69,15 +70,16 @@
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
+	void *kmap_usage[4];
 	unsigned int i;
 
 	tfm->crt_digest.dit_init(tfm);
 		
 	for (i = 0; i < nsg; i++) {
-		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
+		char *p = crypto_kmap(sg[i].page, 0, kmap_usage) + sg[i].offset;
 		tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
 		                                      p, sg[i].length);
-		crypto_kunmap(p, 0);
+		crypto_kunmap(p, sg[i].page, 0, kmap_usage);
 		crypto_yield(tfm);
 	}
 	crypto_digest_final(tfm, out);

