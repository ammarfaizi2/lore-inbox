Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVA3SML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVA3SML (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVA3SMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:12:10 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:4362 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261756AbVA3SH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:07:58 -0500
Date: Sun, 30 Jan 2005 19:07:55 +0100
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, michal@logix.cz, jmorris@redhat.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
Message-ID: <20050130180723.GA2786@ghanima.endorphin.org>
References: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com> <1107022416.25076.21.camel@ghanima> <20050129102310.4bad9553.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129102310.4bad9553.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 10:23:10AM -0800, Andrew Morton wrote:
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
> >
> > My advise is, drop Michaels patches
> >  for now, merge scatterwalker and add an ability to change the stepsize
> >  dynamically in the run. Then I will finish my port and post it.
> > 
> >  If we can agree on this "agenda", I'll shift my focus to scatterwalker
> >  testing.
> 
> Sure.  Just work against Linus's tree.
> 

Ok, here comes a reworked scatterwalk patch. Instead of making
scatterwalk_walk controllable via another additional function or interface,
I decided to make scatterwalk_walk quickly restartable. Therefore, I had to
move an initialization responsibility to the client.

I first planed to this with nice C99 designed structs and compound literals,
but in fact this C99 extension just sucks. It's useless, as compound
literals can't be used as initializers, making this concept at least half
useless. The worst thing of all is, gcc doesn't spill out an error, but just
does random things to your variables. 

GCC C99 ranting aside, this patch also fixes some failing test cases for
chunking across pages.

James, please test it against ipsec. I'm confident, that everything will
work as expected and we can proceed to merge padlock-multiblock against this
scatterwalker, so please Andrew, merge after a successful test of James.

This patch is diffed against 2.6.11-rc2 (Linus) + cipher mode context patch
http://lkml.org/lkml/2005/1/24/54 

 cipher.c      |  267 +++++++++++++++++++++++++++++++++-------------------------
 scatterwalk.c |  137 +++++++++++++++++++++--------
 scatterwalk.h |   37 +++++---
 3 files changed, 277 insertions(+), 164 deletions(-)

Signed-Off-By: Fruhwirth Clemens <clemens@endorphin.org>
--- 1/crypto/cipher.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/cipher.c	2005-01-30 18:45:55.332427200 +0100
@@ -38,94 +38,6 @@
 	((u32 *)a)[3] ^= ((u32 *)b)[3];
 }
 
-
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
-
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
-}
-
 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 {
 	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
@@ -138,43 +50,172 @@
 		                       &tfm->crt_flags);
 }
 
-static int ecb_encrypt(struct crypto_tfm *tfm,
-		       struct scatterlist *dst,
-                       struct scatterlist *src, unsigned int nbytes)
+/* 
+ * Electronic Code Book (ECB) mode implementation 
+ */
+
+struct ecb_process_priv {
+	struct crypto_tfm	*tfm;
+	cryptfn_t		*crfn;
+};
+
+static int ecb_process_gw(void *_priv, int nsg, void **buf) 
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             ecb_process, 1, NULL);
+	struct ecb_process_priv *priv = (struct ecb_process_priv *)_priv;
+	priv->crfn(crypto_tfm_ctx(priv->tfm), buf[0], buf[1]);
+	return 0;
 }
 
-static int ecb_decrypt(struct crypto_tfm *tfm,
+static inline int ecb_template(struct crypto_tfm *tfm,
+	               struct scatterlist *dst,
+                       struct scatterlist *src, unsigned int nbytes, cryptfn_t crfn)
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
+
+	if(!nbytes)
+		return 0;
+	if(nbytes % bsize) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
+		return -EINVAL;
+	}
+
+	return scatterwalk_walk(ecb_process_gw, &priv, nbytes/bsize, ecb_info);
+}
+
+static int ecb_encrypt(struct crypto_tfm *tfm,
                        struct scatterlist *dst,
                        struct scatterlist *src,
 		       unsigned int nbytes)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             ecb_process, 1, NULL);
+	return ecb_template(tfm,dst,src,nbytes,tfm->__crt_alg->cra_cipher.cia_encrypt);
 }
 
-static int cbc_encrypt(struct crypto_tfm *tfm,
+static int ecb_decrypt(struct crypto_tfm *tfm,
                        struct scatterlist *dst,
                        struct scatterlist *src,
 		       unsigned int nbytes)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, tfm->crt_cipher.cit_iv);
+	return ecb_template(tfm,dst,src,nbytes,tfm->__crt_alg->cra_cipher.cia_decrypt);
 }
 
+/* Cipher Block Chaining (CBC) mode implementation */
+
+struct cbc_process_priv {
+	struct crypto_tfm *tfm;
+	int enc;
+	cryptfn_t *crfn;
+	u8 *curIV;
+	u8 *nextIV;
+};
+
+static int cbc_process_gw(void *_priv, int nsg, void **buf) 
+{
+	struct cbc_process_priv *priv = (struct cbc_process_priv *)_priv;
+	u8 *iv = priv->curIV;
+	struct crypto_tfm *tfm = priv->tfm;
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	u8 *dst = buf[0];
+	u8 *src = buf[1];
+	
+	/* Null encryption */
+	if (!iv)
+		return 0;
+
+	if (priv->enc == CRYPTO_DIR_ENCRYPT) {
+		tfm->crt_u.cipher.cit_xor_block(iv, src);
+		priv->crfn(crypto_tfm_ctx(tfm), dst, iv);
+		memcpy(iv, dst, bsize);
+	} else {
+		memcpy(priv->nextIV,src,bsize);
+		priv->crfn(crypto_tfm_ctx(tfm), dst, src);
+		tfm->crt_u.cipher.cit_xor_block(dst, iv);
+		priv->curIV = priv->nextIV;
+		priv->nextIV = iv;
+	}
+	return 0;
+}
+
+
 static int cbc_encrypt_iv(struct crypto_tfm *tfm,
                           struct scatterlist *dst,
                           struct scatterlist *src,
                           unsigned int nbytes, u8 *iv)
 {
-	return crypt(tfm, dst, src, nbytes,
-	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, iv);
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+
+	struct cbc_process_priv priv = {
+		.tfm = tfm,
+		.enc = CRYPTO_DIR_ENCRYPT,
+		.curIV = iv,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_encrypt
+	};
+
+	struct walk_info cbc_info[3];
+
+	if(!nbytes)
+		return 0;
+	if(nbytes % bsize) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_BLOCK_LEN;
+		return -EINVAL;
+	}
+
+	scatterwalk_info_init(cbc_info+0, dst, bsize, (char[bsize]){}, 
+			      SCATTERWALK_IO_OUTPUT);
+	scatterwalk_info_init(cbc_info+1, src, bsize, (char[bsize]){}, 
+			      SCATTERWALK_IO_INPUT); 
+	scatterwalk_info_endtag(cbc_info+2);
+
+ 	return scatterwalk_walk(cbc_process_gw, &priv, nbytes/bsize, cbc_info);
+}
+
+static int cbc_decrypt_iv(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, u8 *iv)
+{
+	int bsize = crypto_tfm_alg_blocksize(tfm);
+	int r = -EINVAL;
+
+	char scratch1[bsize]; 
+
+	struct cbc_process_priv priv = {
+		.tfm = tfm,
+		.enc = CRYPTO_DIR_DECRYPT,
+		.curIV = iv,
+		.nextIV = scratch1,
+		.crfn = tfm->__crt_alg->cra_cipher.cia_decrypt,
+	};
+	struct walk_info cbc_info[3];
+
+	if(!nbytes)
+		return 0;
+	if(nbytes % bsize) {
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
+	if(priv.curIV != iv) 
+		memcpy(iv,priv.curIV,bsize);
+	return r;
 }
 
 static int cbc_decrypt(struct crypto_tfm *tfm,
@@ -182,19 +223,15 @@
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
--- 1/crypto/scatterwalk.h	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/scatterwalk.h	2005-01-30 18:40:42.820936168 +0100
@@ -4,6 +4,7 @@
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  * Copyright (c) 2002 Adam J. Richter <adam@yggdrasil.com>
  * Copyright (c) 2004 Jean-Luc Cooke <jlcooke@certainkey.com>
+ * Copyright (c) 2005 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -16,6 +17,7 @@
 #define _CRYPTO_SCATTERWALK_H
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
+#include <linux/pagemap.h>
 
 struct scatter_walk {
 	struct scatterlist	*sg;
@@ -26,6 +28,21 @@
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
+#define scatterwalk_needscratch(walk, nbytes) 						\
+	((nbytes) <= (walk)->len_this_page &&						\
+	    (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) + (nbytes) <=	\
+	    PAGE_CACHE_SIZE)								\
+
 /* Define sg_next is an inline routine now in case we want to change
    scatterlist to a linked list later. */
 static inline struct scatterlist *sg_next(struct scatterlist *sg)
@@ -33,19 +50,13 @@
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
+int scatterwalk_walk(sw_proc_func_t function, void *priv, int steps, struct walk_info *walk_info_l);
+
+#define scatterwalk_info_endtag(winfo) (winfo)->sw.sg = NULL;
+
+void scatterwalk_info_init(struct walk_info *winfo, struct scatterlist *sg, int stepsize, void *buf, int io);
 
-void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
-void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
-int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);
-void scatterwalk_map(struct scatter_walk *walk, int out);
-void scatterwalk_done(struct scatter_walk *walk, int out, int more);
 
 #endif  /* _CRYPTO_SCATTERWALK_H */
--- 1/crypto/scatterwalk.c	2005-01-20 10:15:40.000000000 +0100
+++ 2/crypto/scatterwalk.c	2005-01-30 18:45:15.489484248 +0100
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
 
@@ -60,11 +51,17 @@
 	walk->offset = sg->offset;
 }
 
-void scatterwalk_map(struct scatter_walk *walk, int out)
+void scatterwalk_info_init(struct walk_info *winfo, struct scatterlist *sg, int stepsize, void *buf, int io)
 {
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+	scatterwalk_start(&winfo->sw, sg);
+	winfo->stepsize = stepsize;
+	winfo->ioflag = io;
+	winfo->buf = buf;
 }
 
+#define scatterwalk_map(walk,out) \
+	(walk)->data = crypto_kmap((walk)->page, (out)) + (walk)->offset; 
+
 static void scatterwalk_pagedone(struct scatter_walk *walk, int out,
 				 unsigned int more)
 {
@@ -89,36 +86,104 @@
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
+void scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
 			   size_t nbytes, int out)
 {
 	if (buf != walk->data) {
 		while (nbytes > walk->len_this_page) {
-			memcpy_dir(buf, walk->data, walk->len_this_page, out);
-			buf += walk->len_this_page;
-			nbytes -= walk->len_this_page;
-
+			if(walk->len_this_page) {
+				memcpy_dir(buf, walk->data, walk->len_this_page, out);
+				buf += walk->len_this_page;
+				nbytes -= walk->len_this_page;
+                        }
 			crypto_kunmap(walk->data, out);
-			scatterwalk_pagedone(walk, out, 1);
+			scatterwalk_pagedone(walk, 
+					     out, 
+					     1); /* more processing steps */
 			scatterwalk_map(walk, out);
-		}
-
-		memcpy_dir(buf, walk->data, nbytes, out);
+		}			       
+		memcpy_dir(buf, walk->data, nbytes, out);			
 	}
-
+        walk->data += nbytes;
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
+ */
+
+int scatterwalk_walk(sw_proc_func_t pf, void *priv, int steps,
+			       struct walk_info *walk_infos) 
+{
+	int r = -EINVAL;
+	
+	int i;
+
+	struct walk_info *csg;
+	int nsl = 0;
+
+	void **cbuf;
+	void **dispatch_list;
+
+        for(csg = walk_infos; csg->sw.sg; csg++) {
+		scatterwalk_map(&csg->sw, csg->ioflag);
+		nsl++;
+	}
+
+	dispatch_list = (void *[nsl]){}; /* This alien thing is a C99 compound literal */
+
+	while(steps--) {
+		for(csg = walk_infos, cbuf = dispatch_list; csg->sw.sg; i--, csg++, cbuf++) {
+			/* If a scratch is needed, do a lazy kmallocation */
+			*cbuf =	scatterwalk_needscratch(&csg->sw,csg->stepsize)?csg->sw.data:csg->buf;
+
+			if(csg->ioflag == 0)
+				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize,0);
+		}
+		
+		r = pf(priv, nsl, dispatch_list);
+		if(unlikely(r < 0))
+			goto out;
+
+		for(csg = walk_infos, cbuf = dispatch_list; csg->sw.sg; csg++, cbuf++) {	
+			if(csg->ioflag == 1) 
+				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize,1);
+		}
+	}
+
+	r = 0;
+ out:
+	for(csg = walk_infos; csg->sw.sg; csg++) {
+		crypto_kunmap(csg->sw.data, csg->ioflag);
+		scatterwalk_pagedone(&csg->sw, csg->ioflag, 0);
+	}
+	return r;
 }
