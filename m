Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWHTA1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWHTA1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 20:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWHTA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 20:27:50 -0400
Received: from mother.openwall.net ([195.42.179.200]:14222 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751598AbWHTA1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 20:27:49 -0400
Date: Sun, 20 Aug 2006 04:23:46 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Message-ID: <20060820002346.GA16995@openwall.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Willy and all,

Attached is a patch (extracted from 2.4.33-ow1) that works around an
unfortunate problem with patch-cryptoloop-jari-2.4.22.0 (and its other
revisions).  I am not sure whether the problem should be worked around
in the main Linux kernel like that, but this is what I did in -ow
patches for now.

Basically, crypto/cipher.c: crypto_init_cipher_ops() in Linux 2.4 (I did
not check 2.6 for this) did not initialize cit_encrypt_iv/cit_decrypt_iv
for ECB mode at all.  While IV makes no sense for ECB mode, I would
think that a safer approach would be to initialize those pointers to
nocrypt_iv.

patch-cryptoloop-jari-2.4.22.0 calls cit_encrypt_iv/cit_decrypt_iv
directly, ignoring their return value.  Thus, when these pointers are
not initialized (as they are not in vanilla Linux 2.4.33) and we request
ECB mode encryption via cryptoloop (a bad idea, but anyway), the kernel
most likely Oopses.  When these pointers are initialized to nocrypt_iv
(due to a "correct" patch), there's no Oops, but the kernel leaks
uninitialized memory contents via the loop device (that's because
patch-cryptoloop-jari-2.4.22.0 ignores the -ENOSYS returns).  Neither
behavior is any good.

The attached patch actually defines ecb_encrypt_iv() and
ecb_decrypt_iv() functions that perform ECB encryption/decryption
ignoring the IV, yet return -ENOSYS (just like nocrypt_iv would).
The result is no more Oopses and no infoleaks either.

(Yes, I understand that ECB mode should be avoided and that this
cryptoloop patch does not address watermarking.  But the security of
block device encryption offered by cryptoloop is irrelevant to the
point that I am making.)

Opinions are welcome.

Thanks,

Alexander

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-crypto-ECB-Oops.diff"

diff -urpPX nopatch linux-2.4.33/crypto/cipher.c linux/crypto/cipher.c
--- linux-2.4.33/crypto/cipher.c	Sun Aug  8 03:26:04 2004
+++ linux/crypto/cipher.c	Sun Aug 13 20:33:57 2006
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
@@ -235,6 +253,11 @@ int crypto_init_cipher_ops(struct crypto
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

--IS0zKkzwUGydFO0o--
