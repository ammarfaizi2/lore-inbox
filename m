Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbWJaCQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbWJaCQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 21:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965530AbWJaCQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 21:16:57 -0500
Received: from web55412.mail.re4.yahoo.com ([206.190.58.206]:15500 "HELO
	web55412.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S965284AbWJaCQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 21:16:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Hb6uW7TLJgG3ZdpDPAhhbCz5mPUvAIdPTDdJGqd9HLrhwquRw/hQ+ssdQS2NMtnxzzCLIJ96cx7HesziT7xCyOTG9cZoJ53+vFMptVK6uOWfLA2WSXuICIjFZPz0T6QIHaQA5FAdjGPrtNKvRWdysLmQ19zrZmlz6hCVy6EGElE=  ;
Message-ID: <20061031021655.20510.qmail@web55412.mail.re4.yahoo.com>
Date: Mon, 30 Oct 2006 18:16:55 -0800 (PST)
From: Era Scarecrow <rtcvb32@yahoo.com>
Reply-To: rtcvb32@yahoo.com
Subject: [PATCH 2.6.18] crypto/api:  optional cleanup functionalitiy
To: jmorris@intercode.com.au
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Cecil <rtcvb32@coffey.com>

 Adds the function call cleanup to all crypto/cipher/digest calls. Certain
select ciphers require a larger dynamic memory allocation, which isn't cleaned
when closed. The cleanup code will be called to clean those up before being
released.

 Signed-off-by: Ryan Cecil <rtcvb32@coffey.com>
---
 I made this patch primarily because i was developing a cipher and it would
crash the UML/kernel. But when it did memory allocation using tcrypt
it sucked all the memory out. This fixes that problem.

diff -ur linux-2.6.18/crypto/api.c linux-2.6.18-modified/crypto/api.c
--- linux-2.6.18/crypto/api.c   2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18-modified/crypto/api.c  2006-10-08 22:27:37.000000000 -0400
@@ -211,10 +211,26 @@
 {
        struct crypto_alg *alg;
        int size;
+       void (*misc_cleanup)(struct crypto_tfm *)=NULL;

        if (unlikely(!tfm))
                return;

+       switch(crypto_tfm_alg_type(tfm))
+       {
+               case CRYPTO_ALG_TYPE_CIPHER:
+               misc_cleanup = tfm->__crt_alg->cra_u.cipher.cia_cleanup;
+               break;
+               case CRYPTO_ALG_TYPE_DIGEST:
+               misc_cleanup = tfm->__crt_alg->cra_u.digest.dia_cleanup;
+               break;
+               case CRYPTO_ALG_TYPE_COMPRESS:
+               misc_cleanup = tfm->__crt_alg->cra_u.compress.coa_cleanup;
+               break;
+       }
+       if (misc_cleanup)       //only a select few need this.
+               (*misc_cleanup)(tfm);
+
        alg = tfm->__crt_alg;
        size = sizeof(*tfm) + alg->cra_ctxsize;

diff -ur linux-2.6.18/include/linux/crypto.h
linux-2.6.18-modified/include/linux/crypto.h
--- linux-2.6.18/include/linux/crypto.h 2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18-modified/include/linux/crypto.h        2006-10-08
22:17:26.000000000 -0400
@@ -83,6 +83,7 @@
                          unsigned int keylen, u32 *flags);
        void (*cia_encrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
        void (*cia_decrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
+       void (*cia_cleanup)(struct crypto_tfm *tfm);

        unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
                                        u8 *dst, const u8 *src,
@@ -104,6 +105,8 @@
        void (*dia_update)(struct crypto_tfm *tfm, const u8 *data,
                           unsigned int len);
        void (*dia_final)(struct crypto_tfm *tfm, u8 *out);
+       void (*dia_cleanup)(struct crypto_tfm *tfm);
+
        int (*dia_setkey)(struct crypto_tfm *tfm, const u8 *key,
                          unsigned int keylen, u32 *flags);
 };
@@ -113,6 +116,7 @@
                            unsigned int slen, u8 *dst, unsigned int *dlen);
        int (*coa_decompress)(struct crypto_tfm *tfm, const u8 *src,
                              unsigned int slen, u8 *dst, unsigned int *dlen);
+       void (*coa_cleanup)(struct crypto_tfm *tfm);
 };

 #define cra_cipher     cra_u.cipher





 
____________________________________________________________________________________
Access over 1 million songs - Yahoo! Music Unlimited 
(http://music.yahoo.com/unlimited)

