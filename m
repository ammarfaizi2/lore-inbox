Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVAXL5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVAXL5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVAXL5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:57:49 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:4617 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261503AbVAXL4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:56:38 -0500
Date: Mon, 24 Jan 2005 12:56:32 +0100
To: akpm@osdl.org, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 02/04] Adding a generic scatterlist eater: generic scatterwalk
Message-ID: <20050124115632.GA21602@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1107431793.2b98@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This generic scatterwalker is an abstraction of the crypt(..) function. It
allows data to be processed by a processing function from an arbitrary
number of scatterlist which constitute the arguments to the function.

I felt the need to add a large comment explaining the use of this function.
This function is surely useful not only for the cryptoapi subsystem. Maybe
we should put it into a more common place. Of course, I replace the former
crypt clients with code for scatterwalk_walker_generic. While doing this,
I replaced the CBC logic for a short initial vector ring-buffer. This
reduces the number of IV memcpy's to 1 at most.

This patch is the one responsible for the performance increase
mentioned in http://lkml.org/lkml/2005/1/19/191

Signed-off-by: Fruhwirth Clemens <clemens@endorphin.org>

--- 1/crypto/cipher.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/cipher.c	2005-01-22 16:53:33.000000000 +0100
@@ -39,91 +39,49 @@
 }
 
 
-/* 
- * Generic encrypt/decrypt wrapper for ciphers, handles operations across
- * multiple page boundaries by using temporary blocks.  In user context,
- * the kernel is given a chance to schedule us once per block.
- */
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
-
-	if (!nbytes)
-		return 0;
-
-	if (nbytes % bsize) {
-		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
-		return -EINVAL;
-	}
-
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
-
-		crypto_yield(tfm);
-	}
-}
-
-static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
-{
-	u8 *iv = info;
+struct cbc_process_priv {
+	struct crypto_tfm *tfm;
+	int enc;
+	cryptfn_t *crfn;
+	u8 *curIV;
+	u8 *nextIV;
+};
+
+static void cbc_process_gw(void *_priv, int nsg, void **buf) 
+{
+	struct cbc_process_priv *priv = (struct cbc_process_priv *)_priv;
+	u8 *iv = priv->curIV;
+	struct crypto_tfm *tfm = priv->tfm;
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	u8 *dst = buf[0];
+	u8 *src = buf[1];
 	
 	/* Null encryption */
 	if (!iv)
 		return;
-		
-	if (enc) {
+
+	if (priv->enc) {
 		tfm->crt_u.cipher.cit_xor_block(iv, src);
-		fn(crypto_tfm_ctx(tfm), dst, iv);
-		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
+		priv->crfn(crypto_tfm_ctx(tfm), dst, iv);
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
+		memcpy(priv->nextIV,src,bsize);
+		priv->crfn(crypto_tfm_ctx(tfm), dst, src);
+		tfm->crt_u.cipher.cit_xor_block(dst, iv);
+		priv->curIV = priv->nextIV;
+		priv->nextIV = iv;
 	}
 }
 
-static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
+struct ecb_process_priv {
+	struct crypto_tfm	*tfm;
+	cryptfn_t		*crfn;
+};
+
+static void ecb_process_gw(void *_priv, int nsg, void **buf) 
 {
-	fn(crypto_tfm_ctx(tfm), dst, src);
+	struct ecb_process_priv *priv = (struct ecb_process_priv *)_priv;
+	priv->crfn(crypto_tfm_ctx(priv->tfm), buf[0], buf[1]);
 }
 
 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
@@ -142,9 +100,25 @@
 		       struct scatterlist *dst,
                        struct scatterlist *src, unsigned int nbytes)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             ecb_process, 1, NULL);
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+
+	struct walk_info ecb_info[2] = { 
+		[0].sg = dst,
+		[0].stepsize = bsize,
+		[0].ioflag = 1,
+		[0].buf = (char[bsize]){},
+		[1].sg = src,
+		[1].stepsize = bsize,
+		[1].ioflag = 0,
+		[1].buf = (char[bsize]){},
+	};
+		
+	struct ecb_process_priv priv = { 
+		.tfm = tfm,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_encrypt,
+	};
+      
+	return scatterwalk_walker_generic(ecb_process_gw, &priv, nbytes/bsize, 2, ecb_info);
 }
 
 static int ecb_decrypt(struct crypto_tfm *tfm,
@@ -152,29 +126,79 @@
                        struct scatterlist *src,
 		       unsigned int nbytes)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             ecb_process, 1, NULL);
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+
+	struct walk_info ecb_info[2] = { 
+		[0].sg = dst,
+		[0].stepsize = bsize,
+		[0].ioflag = 1,
+		[0].buf = (char[bsize]){},
+		[1].sg = src,
+		[1].stepsize = bsize,
+		[1].ioflag = 0,
+		[1].buf = (char[bsize]){},
+	};
+	struct ecb_process_priv priv = { 
+		.tfm = tfm,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_decrypt,
+	};
+
+	return scatterwalk_walker_generic(ecb_process_gw, &priv, nbytes/bsize, 2, ecb_info);
 }
 
-static int cbc_encrypt(struct crypto_tfm *tfm,
-                       struct scatterlist *dst,
-                       struct scatterlist *src,
-		       unsigned int nbytes)
+static int cbc_encrypt_iv(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, u8 *iv)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, tfm->crt_cipher.cit_iv);
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	struct walk_info cbc_walk_info[2] = { 
+		[0].sg = dst,
+		[0].stepsize = bsize,
+		[0].ioflag = 1,
+		[0].buf = (char[bsize]){},
+		[1].sg = src,
+		[1].stepsize = bsize,
+		[1].ioflag = 0,
+		[1].buf = (char[bsize]){},
+	};
+	struct cbc_process_priv priv = {
+		.tfm = tfm,
+		.enc = 1,
+		.curIV = iv,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_encrypt,
+	};
+	return scatterwalk_walker_generic(cbc_process_gw, &priv, nbytes/bsize, 2, cbc_walk_info);
 }
 
-static int cbc_encrypt_iv(struct crypto_tfm *tfm,
+static int cbc_decrypt_iv(struct crypto_tfm *tfm,
                           struct scatterlist *dst,
                           struct scatterlist *src,
                           unsigned int nbytes, u8 *iv)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, iv);
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	struct walk_info cbc_walk_info[2] = { 
+		[0].sg = dst,
+		[0].stepsize = bsize,
+		[0].ioflag = 1,
+		[0].buf = (char[bsize]){},
+		[1].sg = src,
+		[1].stepsize = bsize,
+		[1].ioflag = 0,
+		[1].buf = (char[bsize]){},
+	};
+	int r;
+	struct cbc_process_priv priv = {
+		.tfm = tfm,
+		.enc = 0,
+		.curIV = iv,
+		.nextIV = (char[bsize]){},
+		.crfn = tfm->__crt_alg->cra_cipher.cia_decrypt,
+	};
+	r = scatterwalk_walker_generic(cbc_process_gw, &priv, nbytes/bsize, 2, cbc_walk_info);
+	if(priv.curIV != iv) 
+		memcpy(iv,priv.curIV,bsize);
+	return r;
 }
 
 static int cbc_decrypt(struct crypto_tfm *tfm,
@@ -182,19 +206,15 @@
                        struct scatterlist *src,
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
+static int cbc_encrypt(struct crypto_tfm *tfm,
+                       struct scatterlist *dst,
+                       struct scatterlist *src,
+		       unsigned int nbytes)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, iv);
+	return cbc_encrypt_iv(tfm, dst, src, nbytes, tfm->crt_cipher.cit_iv);
 }
 
 static int nocrypt(struct crypto_tfm *tfm,
--- 1/crypto/api.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/api.c	2005-01-20 10:16:06.000000000 +0100
@@ -131,7 +131,7 @@
 	struct crypto_tfm *tfm = NULL;
 	struct crypto_alg *alg;
 	int tfm_size;
-
+	
 	alg = crypto_alg_mod_lookup(name);
 	if (alg == NULL)
 		goto out;
--- 1/crypto/scatterwalk.h	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/scatterwalk.h	2005-01-22 17:17:38.000000000 +0100
@@ -16,6 +16,7 @@
 #define _CRYPTO_SCATTERWALK_H
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
+#include <linux/pagemap.h>
 
 struct scatter_walk {
 	struct scatterlist	*sg;
@@ -26,6 +27,26 @@
 	unsigned int		offset;
 };
 
+struct walk_info {
+	struct scatterlist    *sg;
+	int                   stepsize;
+	int                   ioflag;
+	char                  *buf;
+	struct scatter_walk   sw;
+	int                   freebuf;
+	
+};
+
+
+#define scatterwalk_needscratch(walk, nbytes) 						\
+	((nbytes) <= (walk)->len_this_page &&						\
+	    (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) + (nbytes) <=	\
+	    PAGE_CACHE_SIZE)								\
+
+
+#define scatterwalk_whichbuf(walk,nbytes,scratch) \
+	    (scatterwalk_needscratch(walk,nbytes)?(walk)->data:(scratch))
+
 /* Define sg_next is an inline routine now in case we want to change
    scatterlist to a linked list later. */
 static inline struct scatterlist *sg_next(struct scatterlist *sg)
@@ -42,10 +63,8 @@
 	       walk_in->data == src_p && walk_out->data == dst_p;
 }
 
-void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
-void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
-int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
-void scatterwalk_map(struct scatter_walk *walk, int out);
-void scatterwalk_done(struct scatter_walk *walk, int out, int more);
+typedef void (*sw_proc_func_t)(void *priv, int length, void **buflist);
+
+int scatterwalk_walker_generic(sw_proc_func_t function, void *priv, int steps, int nsl, struct walk_info *walk_info_l);
 
 #endif  /* _CRYPTO_SCATTERWALK_H */
--- 1/crypto/scatterwalk.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/scatterwalk.c	2005-01-24 11:21:28.192699000 +0100
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
@@ -46,7 +37,7 @@
 		memcpy(buf, sgdata, nbytes);
 }
 
-void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
+static inline void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
 {
 	unsigned int rest_of_page;
 
@@ -60,10 +51,8 @@
 	walk->offset = sg->offset;
 }
 
-void scatterwalk_map(struct scatter_walk *walk, int out)
-{
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
-}
+#define scatterwalk_map(walk,out) \
+	(walk)->data = crypto_kmap((walk)->page, (out)) + (walk)->offset; 
 
 static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
 				 unsigned int more)
@@ -89,36 +78,118 @@
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
+#define scatterwalk_copychunks(xbuf, walk, xnbytes, out) do {			\
+	int nbytes = (xnbytes);							\
+	char *buf = (xbuf);							\
+	if (buf != (walk)->data) {						\
+		while (nbytes > (walk)->len_this_page) {			\
+			memcpy_dir(buf, (walk)->data, (walk)->len_this_page, (out));	\
+			buf += (walk)->len_this_page;				\
+			nbytes -= (walk)->len_this_page;			\
+										\
+			crypto_kunmap((walk)->data, (out));			\
+			scatterwalk_pagedone((walk), (out), 1);			\
+			scatterwalk_map((walk), (out));				\
+		}								\
+		memcpy_dir(buf, (walk)->data, nbytes, (out));			\
+	}									\
+										\
+	(walk)->offset += nbytes;						\
+	(walk)->len_this_page -= nbytes;					\
+	(walk)->len_this_segment -= nbytes;					\
+} while(0);
+
+/*  
+ * The generic scatterwalker can manipulate data associated with one
+ * or more scatterlist with a processing function, pf. It's purpose is
+ * to hide the mapping, unalignment and page switching logic.
+ * 
+ * The generic scatterwalker applies a certain function, pf, utilising
+ * an arbitrary number of scatterlist data as it's arguments. These
+ * arguments are supplied as an array of pointers to buffers. These
+ * buffers are prepared and processed block-wise by the function
+ * (stepsize) and might be input or output buffers.
+ *
+ * All this informations and the underlaying scatterlist is handed to
+ * the generic walker as an array of descriptors of type
+ * walk_info. The sg, stepsize, ioflag and buf field of this struct
+ * must be initialised.
+ *
+ * The sg field points to the scatterlist the function should work on,
+ * the stepsize is the number of successive bytes that should be
+ * handed to the function, ioflag denotes input or output scatterlist
+ * and the buf field is either null, or points to a stepsize-width
+ * byte block, which can be used as copy buffer, when the stepsize
+ * does not align with page or scatterlist boundaries.
+ *
+ * A list of buffers are compiled and handed to the function, as char
+ * **buf, with buf[0] corresponds to the first walk_info descriptor,
+ * buf[1] to the second, and so on. The function is also handed a priv
+ * object, which does not change. Think of it as a "this" object, to
+ * collect/store processing information.
  */
-int scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
-			   size_t nbytes, int out)
+
+int scatterwalk_walker_generic(sw_proc_func_t pf, void *priv, int steps,
+			       int nsl, struct walk_info *walk_infos) 
 {
-	if (buf != walk->data) {
-		while (nbytes > walk->len_this_page) {
-			memcpy_dir(buf, walk->data, walk->len_this_page, out);
-			buf += walk->len_this_page;
-			nbytes -= walk->len_this_page;
-
-			crypto_kunmap(walk->data, out);
-			scatterwalk_pagedone(walk, out, 1);
-			scatterwalk_map(walk, out);
-		}
+	int r = -EINVAL;
+	
+	int i;
 
-		memcpy_dir(buf, walk->data, nbytes, out);
+	struct walk_info *csg;
+
+	void *dispatch_list[nsl];
+	void **cbuf;
+
+        for(csg = walk_infos, i = nsl; i; csg++, i--) {
+		scatterwalk_start(&csg->sw,csg->sg);
+		scatterwalk_map(&csg->sw, csg->ioflag);
 	}
 
-	walk->offset += nbytes;
-	walk->len_this_page -= nbytes;
-	walk->len_this_segment -= nbytes;
-	return 0;
+	while(steps--) {
+		for(csg = walk_infos, cbuf = dispatch_list, i = nsl; i; i--, csg++, cbuf++) {
+			/* If a scratch is needed, do a lazy kmallocation */
+			*cbuf =	scatterwalk_needscratch(&csg->sw,csg->stepsize)?
+				csg->sw.data:(
+				csg->buf == NULL?
+				({
+					csg->buf = kmalloc(csg->stepsize,GFP_KERNEL);
+					if(csg->buf == NULL) {
+						r = -ENOMEM;
+						goto out_buffers;
+					}
+					csg->freebuf = 1;
+					csg->buf; 
+				}):csg->buf);
+
+			if(csg->ioflag == 0) 
+				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize,0);
+		}
+		
+		pf(priv, nsl, dispatch_list);
+		
+		for(csg = walk_infos, cbuf = dispatch_list, i = nsl; i; i--, csg++, cbuf++) {	
+			if(csg->ioflag == 1) 
+				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize,1);
+
+			/* Is page switch needed? Omit switch if this is the last step */
+			if (csg->sw.len_this_page == 0 && steps) {
+				crypto_kunmap(csg->sw.data, csg->ioflag);
+				scatterwalk_pagedone(&csg->sw, csg->ioflag, steps);
+				scatterwalk_map(&csg->sw,csg->ioflag);
+			} else {
+				csg->sw.data += csg->stepsize;
+			}
+		}
+	}
+
+	r = 0;
+out_buffers:
+	for(csg = walk_infos, i = nsl; i; i--, csg++) {
+		crypto_kunmap(csg->sw.data, csg->ioflag);
+		scatterwalk_pagedone(&csg->sw, csg->ioflag, 0);
+		if(csg->freebuf)
+			kfree(csg->buf);
+	}
+	return r;
 }
