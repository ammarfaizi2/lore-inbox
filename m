Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVCUJuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVCUJuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCUJuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:50:22 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:55053 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261722AbVCUJt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:49:57 -0500
Date: Mon, 21 Mar 2005 20:49:39 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: [2/5] [CRYPTO] Handle in_place flag in crypt()
Message-ID: <20050321094939.GB23235@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au> <20050321094807.GA23235@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20050321094807.GA23235@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Move the handling of in_place into crypt() itself.  This means that we only
need two temporary buffers instead of three.  It also allows us to simplify
the check in scatterwalk_samebuf.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-2

diff -Nru a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c	2005-03-21 18:43:52 +11:00
+++ b/crypto/cipher.c	2005-03-21 18:43:52 +11:00
@@ -23,7 +23,7 @@
 
 typedef void (cryptfn_t)(void *, u8 *, const u8 *);
 typedef void (procfn_t)(struct crypto_tfm *, u8 *,
-                        u8*, cryptfn_t, int enc, void *, int);
+                        u8*, cryptfn_t, int enc, void *);
 
 static inline void xor_64(u8 *a, const u8 *b)
 {
@@ -74,22 +74,22 @@
 		scatterwalk_map(&walk_in, 0);
 		scatterwalk_map(&walk_out, 1);
 
+		in_place = scatterwalk_samebuf(&walk_in, &walk_out);
+
 		src_p = walk_in.data;
 		if (unlikely(scatterwalk_across_pages(&walk_in, bsize)))
 			src_p = tmp_src;
 
 		dst_p = walk_out.data;
-		if (unlikely(scatterwalk_across_pages(&walk_out, bsize)))
+		if (unlikely(scatterwalk_across_pages(&walk_out, bsize)) ||
+		    in_place)
 			dst_p = tmp_dst;
 
-		in_place = scatterwalk_samebuf(&walk_in, &walk_out,
-					       src_p, dst_p);
-
 		nbytes -= bsize;
 
 		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
 
-		prfn(tfm, dst_p, src_p, crfn, enc, info, in_place);
+		prfn(tfm, dst_p, src_p, crfn, enc, info);
 
 		scatterwalk_done(&walk_in, 0, nbytes);
 
@@ -104,7 +104,7 @@
 }
 
 static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
+			cryptfn_t fn, int enc, void *info)
 {
 	u8 *iv = info;
 	
@@ -117,19 +117,14 @@
 		fn(crypto_tfm_ctx(tfm), dst, iv);
 		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
 	} else {
-		u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
-		u8 *buf = in_place ? stack : dst;
-
-		fn(crypto_tfm_ctx(tfm), buf, src);
-		tfm->crt_u.cipher.cit_xor_block(buf, iv);
+		fn(crypto_tfm_ctx(tfm), dst, src);
+		tfm->crt_u.cipher.cit_xor_block(dst, iv);
 		memcpy(iv, src, crypto_tfm_alg_blocksize(tfm));
-		if (buf != dst)
-			memcpy(dst, buf, crypto_tfm_alg_blocksize(tfm));
 	}
 }
 
 static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
-			cryptfn_t fn, int enc, void *info, int in_place)
+			cryptfn_t fn, int enc, void *info)
 {
 	fn(crypto_tfm_ctx(tfm), dst, src);
 }
diff -Nru a/crypto/scatterwalk.h b/crypto/scatterwalk.h
--- a/crypto/scatterwalk.h	2005-03-21 18:43:52 +11:00
+++ b/crypto/scatterwalk.h	2005-03-21 18:43:52 +11:00
@@ -34,12 +34,10 @@
 }
 
 static inline int scatterwalk_samebuf(struct scatter_walk *walk_in,
-				      struct scatter_walk *walk_out,
-				      void *src_p, void *dst_p)
+				      struct scatter_walk *walk_out)
 {
 	return walk_in->page == walk_out->page &&
-	       walk_in->offset == walk_out->offset &&
-	       walk_in->data == src_p && walk_out->data == dst_p;
+	       walk_in->offset == walk_out->offset;
 }
 
 static inline int scatterwalk_across_pages(struct scatter_walk *walk,

--Fba/0zbH8Xs+Fj9o--
