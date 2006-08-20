Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWHTIEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWHTIEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWHTIEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:04:40 -0400
Received: from 1wt.eu ([62.212.114.60]:42512 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932500AbWHTIEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:04:38 -0400
Date: Sun, 20 Aug 2006 10:04:03 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Message-ID: <20060820080403.GA602@1wt.eu>
References: <20060820002346.GA16995@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820002346.GA16995@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Sun, Aug 20, 2006 at 04:23:46AM +0400, Solar Designer wrote:
> Willy and all,
> 
> Attached is a patch (extracted from 2.4.33-ow1) that works around an
> unfortunate problem with patch-cryptoloop-jari-2.4.22.0 (and its other
> revisions).  I am not sure whether the problem should be worked around
> in the main Linux kernel like that, but this is what I did in -ow
> patches for now.

You definitely provide interesting cases :-)


> Basically, crypto/cipher.c: crypto_init_cipher_ops() in Linux 2.4 (I did
> not check 2.6 for this) did not initialize cit_encrypt_iv/cit_decrypt_iv
> for ECB mode at all.  While IV makes no sense for ECB mode, I would
> think that a safer approach would be to initialize those pointers to
> nocrypt_iv.

That's what I thought after reading the code too. BTW, 2.6 does not
initialize the pointers either.


> patch-cryptoloop-jari-2.4.22.0 calls cit_encrypt_iv/cit_decrypt_iv
> directly, ignoring their return value.  Thus, when these pointers are
> not initialized (as they are not in vanilla Linux 2.4.33) and we request
> ECB mode encryption via cryptoloop (a bad idea, but anyway), the kernel
> most likely Oopses.  When these pointers are initialized to nocrypt_iv
> (due to a "correct" patch), there's no Oops, but the kernel leaks
> uninitialized memory contents via the loop device (that's because
> patch-cryptoloop-jari-2.4.22.0 ignores the -ENOSYS returns).  Neither
> behavior is any good.

Indeed, that's bad too.

> The attached patch actually defines ecb_encrypt_iv() and
> ecb_decrypt_iv() functions that perform ECB encryption/decryption
> ignoring the IV, yet return -ENOSYS (just like nocrypt_iv would).
> The result is no more Oopses and no infoleaks either.

Can the cryptoloop patch use CRYPTO_TFM_MODE_CFB or CRYPTO_TFM_MODE_CTR
and so be redirected to nocrypt() which will leave uninitialized memory
too ?

> (Yes, I understand that ECB mode should be avoided and that this
> cryptoloop patch does not address watermarking.  But the security of
> block device encryption offered by cryptoloop is irrelevant to the
> point that I am making.)
> 
> Opinions are welcome.

I wonder whether we shouldn't consider that those functions must at
least clear the memory area that was submitted to them, such as
proposed below. It would also fix the problem for potential other
users. I don't think we need to check whether dst is valid given
the small amount of tests performed in crypt().

Opinions are welcome too.
Willy


diff --git a/crypto/cipher.c b/crypto/cipher.c
index 6ab56eb..cdf650b 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -202,6 +202,9 @@ static int nocrypt(struct crypto_tfm *tf
                    struct scatterlist *src,
 		   unsigned int nbytes)
 {
+	/* do not leak uninitialized data in the return buffer */
+	if (nbytes)
+		memset(dst, 0, nbytes);
 	return -ENOSYS;
 }
 
@@ -210,6 +213,9 @@ static int nocrypt_iv(struct crypto_tfm 
                       struct scatterlist *src,
                       unsigned int nbytes, u8 *iv)
 {
+	/* do not leak uninitialized data in the return buffer */
+	if (nbytes)
+		memset(dst, 0, nbytes);
 	return -ENOSYS;
 }
 
@@ -235,6 +241,8 @@ int crypto_init_cipher_ops(struct crypto
 	case CRYPTO_TFM_MODE_ECB:
 		ops->cit_encrypt = ecb_encrypt;
 		ops->cit_decrypt = ecb_decrypt;
+		ops->cit_encrypt_iv = nocrypt_iv;
+		ops->cit_decrypt_iv = nocrypt_iv;
 		break;
 		
 	case CRYPTO_TFM_MODE_CBC:


