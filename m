Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVCVL0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVCVL0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVCVL0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:26:19 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:54541 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262629AbVCVLYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:24:39 -0500
Date: Tue, 22 Mar 2005 22:24:16 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz, linux-crypto@vger.kernel.org
Subject: [8/*] [CRYPTO] Split cbc_process into encrypt/decrypt
Message-ID: <20050322112416.GB7224@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050322112231.GA7224@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20050322112231.GA7224@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Rather than taking a branch on the fast path, we might as well split
cbc_process into encrypt and decrypt since they don't share anything
in common.

We can get rid of the cryptfn argument too.  I'll do that next.
  
Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-8

===== cipher.c 1.25 vs edited =====
--- 1.25/crypto/cipher.c	2005-03-22 21:33:25 +11:00
+++ edited/cipher.c	2005-03-22 21:47:09 +11:00
@@ -24,7 +24,7 @@
 
 typedef void (cryptfn_t)(void *, u8 *, const u8 *);
 typedef void (procfn_t)(struct crypto_tfm *, u8 *,
-                        u8*, cryptfn_t, int enc, void *);
+                        u8*, cryptfn_t, void *);
 
 static inline void xor_64(u8 *a, const u8 *b)
 {
@@ -90,7 +90,7 @@
 		 struct scatterlist *dst,
 		 struct scatterlist *src,
                  unsigned int nbytes, cryptfn_t crfn,
-                 procfn_t prfn, int enc, void *info)
+                 procfn_t prfn, void *info)
 {
 	struct scatter_walk walk_in, walk_out;
 	const unsigned int bsize = crypto_tfm_alg_blocksize(tfm);
@@ -123,7 +123,7 @@
 			dst_p = prepare_dst(&walk_out, bsize, tmp_dst,
 					    in_place);
 
-			prfn(tfm, dst_p, src_p, crfn, enc, info);
+			prfn(tfm, dst_p, src_p, crfn, info);
 
 			complete_src(&walk_in, bsize, src_p, in_place);
 			complete_dst(&walk_out, bsize, dst_p, in_place);
@@ -141,24 +141,28 @@
 	}
 }
 
-static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info)
+static void cbc_process_encrypt(struct crypto_tfm *tfm, u8 *dst, u8 *src,
+				cryptfn_t fn, void *info)
 {
 	u8 *iv = info;
 
-	if (enc) {
-		tfm->crt_u.cipher.cit_xor_block(iv, src);
-		fn(crypto_tfm_ctx(tfm), dst, iv);
-		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
-	} else {
-		fn(crypto_tfm_ctx(tfm), dst, src);
-		tfm->crt_u.cipher.cit_xor_block(dst, iv);
-		memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
-	}
+	tfm->crt_u.cipher.cit_xor_block(iv, src);
+	fn(crypto_tfm_ctx(tfm), dst, iv);
+	memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
+}
+
+static void cbc_process_decrypt(struct crypto_tfm *tfm, u8 *dst, u8 *src,
+				cryptfn_t fn, void *info)
+{
+	u8 *iv = info;
+
+	fn(crypto_tfm_ctx(tfm), dst, src);
+	tfm->crt_u.cipher.cit_xor_block(dst, iv);
+	memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
 }
 
 static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info)
+			cryptfn_t fn, void *info)
 {
 	fn(crypto_tfm_ctx(tfm), dst, src);
 }
@@ -181,7 +185,7 @@
 {
 	return crypt(tfm, dst, src, nbytes,
 	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             ecb_process, 1, NULL);
+	             ecb_process, NULL);
 }
 
 static int ecb_decrypt(struct crypto_tfm *tfm,
@@ -191,7 +195,7 @@
 {
 	return crypt(tfm, dst, src, nbytes,
 	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             ecb_process, 1, NULL);
+	             ecb_process, NULL);
 }
 
 static int cbc_encrypt(struct crypto_tfm *tfm,
@@ -201,7 +205,7 @@
 {
 	return crypt(tfm, dst, src, nbytes,
 	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, tfm->crt_cipher.cit_iv);
+	             cbc_process_encrypt, tfm->crt_cipher.cit_iv);
 }
 
 static int cbc_encrypt_iv(struct crypto_tfm *tfm,
@@ -211,7 +215,7 @@
 {
 	return crypt(tfm, dst, src, nbytes,
 	             tfm->__crt_alg->cra_cipher.cia_encrypt,
-	             cbc_process, 1, iv);
+	             cbc_process_encrypt, iv);
 }
 
 static int cbc_decrypt(struct crypto_tfm *tfm,
@@ -221,7 +225,7 @@
 {
 	return crypt(tfm, dst, src, nbytes,
 	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, tfm->crt_cipher.cit_iv);
+	             cbc_process_decrypt, tfm->crt_cipher.cit_iv);
 }
 
 static int cbc_decrypt_iv(struct crypto_tfm *tfm,
@@ -231,7 +235,7 @@
 {
 	return crypt(tfm, dst, src, nbytes,
 	             tfm->__crt_alg->cra_cipher.cia_decrypt,
-	             cbc_process, 0, iv);
+	             cbc_process_decrypt, iv);
 }
 
 static int nocrypt(struct crypto_tfm *tfm,

--0eh6TmSyL6TZE2Uz--
