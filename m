Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVCZEqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVCZEqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVCZEqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:46:34 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:36358 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261996AbVCZEpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 23:45:43 -0500
Date: Sat, 26 Mar 2005 15:44:22 +1100
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050326044421.GA24358@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Artem:

On Fri, Mar 25, 2005 at 04:08:20PM +0000, Artem B. Bityuckiy wrote:
> 
> I'm working on cleaning-up the JFFS3 compression stuff. JFFS3 contains a
> number of compressors which actually shouldn't be there as they are
> platform-independent and generic. So we want to move them to the generic
> part of the Linux kernel instead of storing them in fs/jffs2/. And we
> were going to use CryptoAPI to access the compressors.

Sounds good.
 
> In JFFS2 we need something more flexible. Te following is what we want:
> 
> int crypto_compress_ext(struct crypto_tfm *tfm,
>                     const u8 *src, unsigned int *slen,
>                     u8 *dst, unsigned int *dlen);

Compressing part of the input could be significantly different from
compressing all of the input depending on the algorithm.  In particular
it could be most costly to do so and/or result in worse compression.

So while I'm happy to add such an interface I think we should keep
crypto_comp_compress as well for full compression.

I've whipped up something quick and called it crypto_comp_pcompress.
How does this interface look to you?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pcompress-1

===== crypto/compress.c 1.7 vs edited =====
--- 1.7/crypto/compress.c	2003-03-29 22:16:58 +11:00
+++ edited/crypto/compress.c	2005-03-26 15:33:19 +11:00
@@ -18,6 +18,17 @@
 #include <linux/string.h>
 #include "internal.h"
 
+static int crypto_pcompress(struct crypto_tfm *tfm,
+			    const u8 *src, unsigned int *slen,
+			    u8 *dst, unsigned int *dlen)
+{
+	if (!tfm->__crt_alg->cra_compress.coa_pcompress)
+		return -ENOSYS;
+	return tfm->__crt_alg->cra_compress.coa_pcompress(crypto_tfm_ctx(tfm),
+							  src, slen, dst,
+							  dlen);
+}
+
 static int crypto_compress(struct crypto_tfm *tfm,
                             const u8 *src, unsigned int slen,
                             u8 *dst, unsigned int *dlen)
@@ -50,6 +61,7 @@
 	if (ret)
 		goto out;
 
+	ops->cot_pcompress = crypto_pcompress;
 	ops->cot_compress = crypto_compress;
 	ops->cot_decompress = crypto_decompress;
 	
===== include/linux/crypto.h 1.32 vs edited =====
--- 1.32/include/linux/crypto.h	2005-01-26 16:53:19 +11:00
+++ edited/include/linux/crypto.h	2005-03-26 15:25:39 +11:00
@@ -87,6 +87,8 @@
 struct compress_alg {
 	int (*coa_init)(void *ctx);
 	void (*coa_exit)(void *ctx);
+	int (*coa_pcompress)(void *ctx, const u8 *src, unsigned int *slen,
+			     u8 *dst, unsigned int *dlen);
 	int (*coa_compress)(void *ctx, const u8 *src, unsigned int slen,
 	                    u8 *dst, unsigned int *dlen);
 	int (*coa_decompress)(void *ctx, const u8 *src, unsigned int slen,
@@ -178,6 +180,9 @@
 };
 
 struct compress_tfm {
+	int (*cot_pcompress)(struct crypto_tfm *tfm,
+			     const u8 *src, unsigned int *slen,
+			     u8 *dst, unsigned int *dlen);
 	int (*cot_compress)(struct crypto_tfm *tfm,
 	                    const u8 *src, unsigned int slen,
 	                    u8 *dst, unsigned int *dlen);
@@ -363,6 +368,14 @@
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
 	memcpy(dst, tfm->crt_cipher.cit_iv, len);
+}
+
+static inline int crypto_comp_pcompress(struct crypto_tfm *tfm,
+					const u8 *src, unsigned int *slen,
+					u8 *dst, unsigned int *dlen)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_COMPRESS);
+	return tfm->crt_compress.cot_pcompress(tfm, src, slen, dst, dlen);
 }
 
 static inline int crypto_comp_compress(struct crypto_tfm *tfm,

--VbJkn9YxBvnuCH5J--
