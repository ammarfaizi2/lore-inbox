Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbUB0Sr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUB0SqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:46:15 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:214 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263018AbUB0Shp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:37:45 -0500
Date: Fri, 27 Feb 2004 19:37:27 +0100
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040227183718.GA1880@leto.cs.pocnet.net>
References: <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040221021724.GA8841@leto.cs.pocnet.net> <20040224191142.GT3883@waste.org> <1077651839.11170.4.camel@leto.cs.pocnet.net> <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org> <1077824146.14794.8.camel@leto.cs.pocnet.net> <20040226200244.GH3883@waste.org> <1077897901.29711.44.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077897901.29711.44.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just hacked together what I wrote. Compiles but untested.

diff -Nur linux.orig/crypto/api.c linux/crypto/api.c
--- linux.orig/crypto/api.c	2004-02-27 19:25:58.445326056 +0100
+++ linux/crypto/api.c	2004-02-27 19:26:44.451332080 +0100
@@ -96,6 +96,26 @@
 	return -EINVAL;
 }
 
+static int crypto_copy_ops(struct crypto_tfm *tfm)
+{
+	switch (crypto_tfm_alg_type(tfm)) {
+	case CRYPTO_ALG_TYPE_CIPHER:
+		return crypto_copy_cipher_ops(tfm);
+		
+	case CRYPTO_ALG_TYPE_DIGEST:
+		return crypto_copy_digest_ops(tfm);
+		
+	case CRYPTO_ALG_TYPE_COMPRESS:
+		return crypto_copy_compress_ops(tfm);
+
+	default:
+		break;
+	}
+
+	BUG();
+	return -EINVAL;
+}
+
 static void crypto_exit_ops(struct crypto_tfm *tfm)
 {
 	switch (crypto_tfm_alg_type(tfm)) {
@@ -117,6 +137,62 @@
 	}
 }
 
+static int __crypto_init_tfm(struct crypto_tfm *tfm, struct crypto_alg *alg,
+			     u32 flags)
+{
+	memset(tfm, 0, crypto_alg_tfm_size(alg));
+
+	tfm->__crt_alg = alg;
+
+	if (crypto_init_flags(tfm, flags))
+		return -EINVAL;
+
+	if (crypto_init_ops(tfm)) {
+		crypto_exit_ops(tfm);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+unsigned int crypto_lookup_alg_tfm_size(const char *name, u32 flags)
+{
+	struct crypto_alg *alg;
+	unsigned int size;
+
+	alg = crypto_alg_mod_lookup(name);
+	if (alg == NULL)
+		return 0;
+
+	size = crypto_alg_tfm_size(alg);
+
+	crypto_alg_put(alg);
+	/* hmm, there's a window to race between here and crypto_init_tfm */
+
+	return size;
+}
+
+int crypto_init_tfm(struct crypto_tfm *tfm, const char *name, u32 flags)
+{
+	struct crypto_alg *alg;
+	int ret = -EINVAL;
+
+	alg = crypto_alg_mod_lookup(name);
+	if (alg == NULL)
+		goto out;
+
+	ret = __crypto_init_tfm(tfm, alg, flags);
+	if (ret < 0)
+		goto out_put;
+
+	goto out;
+
+out_put:
+	crypto_alg_put(alg);
+out:
+	return ret;
+}
+
 struct crypto_tfm *crypto_alloc_tfm(const char *name, u32 flags)
 {
 	struct crypto_tfm *tfm = NULL;
@@ -126,21 +202,12 @@
 	if (alg == NULL)
 		goto out;
 	
-	tfm = kmalloc(sizeof(*tfm) + alg->cra_ctxsize, GFP_KERNEL);
+	tfm = kmalloc(crypto_alg_tfm_size(alg), GFP_KERNEL);
 	if (tfm == NULL)
 		goto out_put;
 
-	memset(tfm, 0, sizeof(*tfm) + alg->cra_ctxsize);
-	
-	tfm->__crt_alg = alg;
-	
-	if (crypto_init_flags(tfm, flags))
+	if (__crypto_init_tfm(tfm, alg, flags) < 0)
 		goto out_free_tfm;
-		
-	if (crypto_init_ops(tfm)) {
-		crypto_exit_ops(tfm);
-		goto out_free_tfm;
-	}
 
 	goto out;
 
@@ -153,13 +220,52 @@
 	return tfm;
 }
 
-void crypto_free_tfm(struct crypto_tfm *tfm)
+void crypto_exit_tfm(struct crypto_tfm *tfm)
 {
 	crypto_exit_ops(tfm);
 	crypto_alg_put(tfm->__crt_alg);
+}
+
+void crypto_free_tfm(struct crypto_tfm *tfm)
+{
+	crypto_exit_tfm(tfm);
 	kfree(tfm);
 }
 
+int crypto_copy_tfm(struct crypto_tfm *dst, struct crypto_tfm *src)
+{
+	int ret;
+
+	memcpy(dst, src, crypto_tfm_size(src));
+	crypto_alg_get(dst->__crt_alg);
+
+	ret = crypto_copy_ops(dst);
+	if (ret < 0)
+		crypto_alg_put(dst->__crt_alg);
+
+	return ret;
+}
+
+struct crypto_tfm *crypto_clone_tfm(struct crypto_tfm *orig)
+{
+	struct crypto_tfm *clone = NULL;
+
+	clone = kmalloc(crypto_tfm_size(orig), GFP_KERNEL);
+	if (clone == NULL)
+		goto out;
+
+	if (crypto_copy_tfm(clone, orig) < 0)
+		goto out_free_tfm;
+
+	goto out;
+
+out_free_tfm:
+	kfree(clone);
+	clone = NULL;
+out:
+	return clone;
+}
+
 int crypto_register_alg(struct crypto_alg *alg)
 {
 	int ret = 0;
diff -Nur linux.orig/crypto/cipher.c linux/crypto/cipher.c
--- linux.orig/crypto/cipher.c	2004-02-27 19:25:58.513315720 +0100
+++ linux/crypto/cipher.c	2004-02-27 19:26:44.457331168 +0100
@@ -281,7 +281,7 @@
 	    	}
 	    	
 		ops->cit_ivsize = crypto_tfm_alg_blocksize(tfm);
-	    	ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
+		ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
 		if (ops->cit_iv == NULL)
 			ret = -ENOMEM;
 	}
@@ -290,6 +290,24 @@
 	return ret;
 }
 
+int crypto_copy_cipher_ops(struct crypto_tfm *tfm)
+{
+	struct cipher_tfm *ops = &tfm->crt_cipher;
+
+	if (tfm->crt_cipher.cit_iv) {
+		void *new_cit_iv;
+
+		new_cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
+		if (new_cit_iv == NULL)
+			return -ENOMEM;
+
+		memcpy(new_cit_iv, ops->cit_iv, ops->cit_ivsize);
+		ops->cit_iv = new_cit_iv;
+	}
+
+	return 0;
+}
+
 void crypto_exit_cipher_ops(struct crypto_tfm *tfm)
 {
 	if (tfm->crt_cipher.cit_iv)
diff -Nur linux.orig/crypto/compress.c linux/crypto/compress.c
--- linux.orig/crypto/compress.c	2004-02-27 19:25:58.514315568 +0100
+++ linux/crypto/compress.c	2004-02-27 19:26:44.457331168 +0100
@@ -57,6 +57,11 @@
 	return ret;
 }
 
+int crypto_copy_compress_ops(struct crypto_tfm *tfm)
+{
+	return tfm->__crt_alg->cra_compress.coa_copy(crypto_tfm_ctx(tfm));
+}
+
 void crypto_exit_compress_ops(struct crypto_tfm *tfm)
 {
 	tfm->__crt_alg->cra_compress.coa_exit(crypto_tfm_ctx(tfm));
diff -Nur linux.orig/crypto/deflate.c linux/crypto/deflate.c
--- linux.orig/crypto/deflate.c	2004-02-27 19:25:58.515315416 +0100
+++ linux/crypto/deflate.c	2004-02-27 19:26:44.458331016 +0100
@@ -55,6 +55,40 @@
 	return 0;
 }
 
+static int deflate_copy(void *ctx)
+{
+	struct deflate_ctx *dctx = ctx;
+	struct z_stream_s *stream = &dctx->comp_stream;
+	unsigned int size;
+	void *new_workspace;
+
+	if (dctx->comp_initialized) {
+		new_workspace = __vmalloc(size = zlib_deflate_workspacesize(),
+		                          deflate_gfp()|__GFP_HIGHMEM,
+		                          PAGE_KERNEL);
+		if (!new_workspace)
+			return -ENOMEM;
+
+		memcpy(new_workspace, stream->workspace, size);
+		stream->workspace = new_workspace;
+	}
+	if (dctx->decomp_initialized) {
+		new_workspace = kmalloc(size = zlib_inflate_workspacesize(),
+		                        deflate_gfp());
+		if (!new_workspace) {
+			if (dctx->comp_initialized)
+				vfree(stream->workspace);
+
+			return -ENOMEM;
+		}
+
+		memcpy(new_workspace, stream->workspace, size);
+		stream->workspace = new_workspace;
+	}
+
+	return 0;
+}
+
 static void deflate_exit(void *ctx)
 {
 	struct deflate_ctx *dctx = ctx;
@@ -77,7 +111,7 @@
 	stream->workspace = __vmalloc(zlib_deflate_workspacesize(),
 	                              deflate_gfp()|__GFP_HIGHMEM,
 	                              PAGE_KERNEL);
-	if (!stream->workspace ) {
+	if (!stream->workspace) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -212,6 +246,7 @@
 	.cra_list		= LIST_HEAD_INIT(alg.cra_list),
 	.cra_u			= { .compress = {
 	.coa_init		= deflate_init,
+	.coa_copy		= deflate_copy,
 	.coa_exit		= deflate_exit,
 	.coa_compress 		= deflate_compress,
 	.coa_decompress  	= deflate_decompress } }
diff -Nur linux.orig/crypto/digest.c linux/crypto/digest.c
--- linux.orig/crypto/digest.c	2004-02-27 19:25:58.517315112 +0100
+++ linux/crypto/digest.c	2004-02-27 19:26:44.459330864 +0100
@@ -76,6 +76,11 @@
 	return crypto_alloc_hmac_block(tfm);
 }
 
+int crypto_copy_digest_ops(struct crypto_tfm *tfm)
+{
+	return crypto_clone_hmac_block(tfm);
+}
+
 void crypto_exit_digest_ops(struct crypto_tfm *tfm)
 {
 	crypto_free_hmac_block(tfm);
diff -Nur linux.orig/crypto/hmac.c linux/crypto/hmac.c
--- linux.orig/crypto/hmac.c	2004-02-27 19:25:58.517315112 +0100
+++ linux/crypto/hmac.c	2004-02-27 19:26:44.459330864 +0100
@@ -44,7 +44,24 @@
 		ret = -ENOMEM;
 
 	return ret;
-		
+}
+
+int crypto_clone_hmac_block(struct crypto_tfm *tfm)
+{
+	void *new_hmac_block;
+	int ret = 0;
+
+	BUG_ON(!crypto_tfm_alg_blocksize(tfm));
+
+	new_hmac_block = kmalloc(crypto_tfm_alg_blocksize(tfm), GFP_KERNEL);
+	if (new_hmac_block != NULL) {
+		memcpy(new_hmac_block, tfm->crt_digest.dit_hmac_block,
+		       crypto_tfm_alg_blocksize(tfm));
+		tfm->crt_digest.dit_hmac_block = new_hmac_block;
+	} else
+		ret = -ENOMEM;
+
+	return ret;
 }
 
 void crypto_free_hmac_block(struct crypto_tfm *tfm)
diff -Nur linux.orig/crypto/internal.h linux/crypto/internal.h
--- linux.orig/crypto/internal.h	2004-02-27 19:25:58.518314960 +0100
+++ linux/crypto/internal.h	2004-02-27 19:26:44.459330864 +0100
@@ -59,6 +59,7 @@
 
 #ifdef CONFIG_CRYPTO_HMAC
 int crypto_alloc_hmac_block(struct crypto_tfm *tfm);
+int crypto_copy_hmac_block(struct crypto_tfm *tfm);
 void crypto_free_hmac_block(struct crypto_tfm *tfm);
 #else
 static inline int crypto_alloc_hmac_block(struct crypto_tfm *tfm)
@@ -85,6 +86,10 @@
 int crypto_init_cipher_ops(struct crypto_tfm *tfm);
 int crypto_init_compress_ops(struct crypto_tfm *tfm);
 
+int crypto_copy_digest_ops(struct crypto_tfm *tfm);
+int crypto_copy_cipher_ops(struct crypto_tfm *tfm);
+int crypto_copy_compress_ops(struct crypto_tfm *tfm);
+
 void crypto_exit_digest_ops(struct crypto_tfm *tfm);
 void crypto_exit_cipher_ops(struct crypto_tfm *tfm);
 void crypto_exit_compress_ops(struct crypto_tfm *tfm);
diff -Nur linux.orig/include/linux/crypto.h linux/include/linux/crypto.h
--- linux.orig/include/linux/crypto.h	2004-02-27 19:25:51.934315880 +0100
+++ linux/include/linux/crypto.h	2004-02-27 19:26:32.639127808 +0100
@@ -80,6 +80,7 @@
 
 struct compress_alg {
 	int (*coa_init)(void *ctx);
+	int (*coa_copy)(void *ctx);
 	void (*coa_exit)(void *ctx);
 	int (*coa_compress)(void *ctx, const u8 *src, unsigned int slen,
 	                    u8 *dst, unsigned int *dlen);
@@ -191,7 +192,13 @@
 /* 
  * Transform user interface.
  */
- 
+
+#define crypto_alg_tfm_size(alg)	(sizeof(struct crypto_tfm) + \
+					(alg)->cra_ctxsize)
+#define crypto_tfm_size(tfm)		crypto_alg_tfm_size((tfm)->__crt_alg)
+
+unsigned int crypto_lookup_alg_tfm_size(const char *alg_name, u32 tfm_flags);
+
 /*
  * crypto_alloc_tfm() will first attempt to locate an already loaded algorithm.
  * If that fails and the kernel supports dynamically loadable modules, it
@@ -200,10 +207,20 @@
  *
  * crypto_free_tfm() frees up the transform and any associated resources,
  * then drops the refcount on the associated algorithm.
+ *
+ * crypto_init_tfm() and crypto_exit_tfm() do the same except that the user
+ * has to do the memory allocation.
  */
+int crypto_init_tfm(struct crypto_tfm *tfm, const char *alg_name,
+                    u32 tfm_flags);
 struct crypto_tfm *crypto_alloc_tfm(const char *alg_name, u32 tfm_flags);
+
+void crypto_exit_tfm(struct crypto_tfm *tfm);
 void crypto_free_tfm(struct crypto_tfm *tfm);
 
+int crypto_copy_tfm(struct crypto_tfm *dst_tfm, struct crypto_tfm *src_tfm);
+struct crypto_tfm *crypto_clone_tfm(struct crypto_tfm *orig_tfm);
+
 /*
  * Transform helpers which query the underlying algorithm.
  */
