Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWHVGcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWHVGcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWHVGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:32:12 -0400
Received: from mother.openwall.net ([195.42.179.200]:30411 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750907AbWHVGcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:32:10 -0400
Date: Tue, 22 Aug 2006 10:28:53 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Message-ID: <20060822062853.GA1673@openwall.com>
References: <20060820002346.GA16995@openwall.com> <20060820080403.GA602@1wt.eu> <20060820144908.GA19602@openwall.com> <20060820225830.GA31693@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20060820225830.GA31693@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2006 at 08:58:30AM +1000, Herbert Xu wrote:
> On Sun, Aug 20, 2006 at 06:49:08PM +0400, Solar Designer wrote:
> > 
> > Can we maybe define working but IV-ignoring functions for ECB (like I
> > did), but use memory-clearing nocrypt*() for CFB and CTR (as long as
> > these are not supported)?  Of course, all of these will return -ENOSYS.
> 
> In cryptodev-2.6, with block ciphers you can no longer select CFB/CTR
> until someone writes support for them so this is no longer an issue.
> 
> For 2.4, I don't really mind either way what nocrypt does.

OK, I've merged Willy's suggestion for the memset()s into the patch that
I had submitted previously.  The resulting patch is attached.

Alexander

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-nocrypt.diff"

diff -urp linux-2.4.33/crypto/cipher.c linux/crypto/cipher.c
--- linux-2.4.33/crypto/cipher.c	Sun Aug  8 03:26:04 2004
+++ linux/crypto/cipher.c	Tue Aug 22 09:53:35 2006
@@ -147,6 +147,15 @@ static int ecb_encrypt(struct crypto_tfm
 	             ecb_process, 1, NULL);
 }
 
+static int ecb_encrypt_iv(struct crypto_tfm *tfm,
+			  struct scatterlist *dst,
+			  struct scatterlist *src,
+			  unsigned int nbytes, u8 *iv)
+{
+	ecb_encrypt(tfm, dst, src, nbytes);
+	return -ENOSYS;
+}
+
 static int ecb_decrypt(struct crypto_tfm *tfm,
                        struct scatterlist *dst,
                        struct scatterlist *src,
@@ -157,6 +166,15 @@ static int ecb_decrypt(struct crypto_tfm
 	             ecb_process, 1, NULL);
 }
 
+static int ecb_decrypt_iv(struct crypto_tfm *tfm,
+			  struct scatterlist *dst,
+			  struct scatterlist *src,
+			  unsigned int nbytes, u8 *iv)
+{
+	ecb_decrypt(tfm, dst, src, nbytes);
+	return -ENOSYS;
+}
+
 static int cbc_encrypt(struct crypto_tfm *tfm,
                        struct scatterlist *dst,
                        struct scatterlist *src,
@@ -197,11 +215,20 @@ static int cbc_decrypt_iv(struct crypto_
 	             cbc_process, 0, iv);
 }
 
+/*
+ * nocrypt*() zeroize the destination buffer to make sure we don't leak
+ * uninitialized memory contents if the caller ignores the return value.
+ * This is bad since the data in the source buffer is unused and may be
+ * lost, but an infoleak would be even worse.  The performance cost of
+ * memset() is irrelevant since a well-behaved caller would not bump into
+ * the error repeatedly.
+ */
 static int nocrypt(struct crypto_tfm *tfm,
                    struct scatterlist *dst,
                    struct scatterlist *src,
 		   unsigned int nbytes)
 {
+	memset(dst, 0, nbytes);
 	return -ENOSYS;
 }
 
@@ -210,6 +237,7 @@ static int nocrypt_iv(struct crypto_tfm 
                       struct scatterlist *src,
                       unsigned int nbytes, u8 *iv)
 {
+	memset(dst, 0, nbytes);
 	return -ENOSYS;
 }
 
@@ -235,6 +263,11 @@ int crypto_init_cipher_ops(struct crypto
 	case CRYPTO_TFM_MODE_ECB:
 		ops->cit_encrypt = ecb_encrypt;
 		ops->cit_decrypt = ecb_decrypt;
+/* These should have been nocrypt_iv, but patch-cryptoloop-jari-2.4.22.0
+ * (and its other revisions) directly calls the *_iv() functions even in
+ * ECB mode and ignores their return value. */
+		ops->cit_encrypt_iv = ecb_encrypt_iv;
+		ops->cit_decrypt_iv = ecb_decrypt_iv;
 		break;
 		
 	case CRYPTO_TFM_MODE_CBC:

--h31gzZEtNLTqOjlF--
