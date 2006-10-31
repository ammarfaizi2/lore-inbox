Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161535AbWJaDKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161535AbWJaDKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161536AbWJaDKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:10:44 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:57052 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161535AbWJaDKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:10:43 -0500
Date: Mon, 30 Oct 2006 19:06:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: rtcvb32@yahoo.com
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18] crypto/api:  optional cleanup functionalitiy
Message-Id: <20061030190627.f513ecc3.randy.dunlap@oracle.com>
In-Reply-To: <20061031021655.20510.qmail@web55412.mail.re4.yahoo.com>
References: <20061031021655.20510.qmail@web55412.mail.re4.yahoo.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 18:16:55 -0800 (PST) Era Scarecrow wrote:

> From: Ryan Cecil <rtcvb32@coffey.com>
> 
>  Adds the function call cleanup to all crypto/cipher/digest calls. Certain
> select ciphers require a larger dynamic memory allocation, which isn't cleaned
> when closed. The cleanup code will be called to clean those up before being
> released.
> 
>  Signed-off-by: Ryan Cecil <rtcvb32@coffey.com>
> ---
>  I made this patch primarily because i was developing a cipher and it would
> crash the UML/kernel. But when it did memory allocation using tcrypt
> it sucked all the memory out. This fixes that problem.

Please fix the coding style as indicated below.
Thanks.

> diff -ur linux-2.6.18/crypto/api.c linux-2.6.18-modified/crypto/api.c
> --- linux-2.6.18/crypto/api.c   2006-09-19 23:42:06.000000000 -0400
> +++ linux-2.6.18-modified/crypto/api.c  2006-10-08 22:27:37.000000000 -0400
> @@ -211,10 +211,26 @@
>  {
>         struct crypto_alg *alg;
>         int size;
> +       void (*misc_cleanup)(struct crypto_tfm *)=NULL;

s/=/ = /

> 
>         if (unlikely(!tfm))
>                 return;
> 
> +       switch(crypto_tfm_alg_type(tfm))
> +       {

Align 'case' with 'switch'.  Space after 'switch'.

> +               case CRYPTO_ALG_TYPE_CIPHER:
> +               misc_cleanup = tfm->__crt_alg->cra_u.cipher.cia_cleanup;
> +               break;
> +               case CRYPTO_ALG_TYPE_DIGEST:
> +               misc_cleanup = tfm->__crt_alg->cra_u.digest.dia_cleanup;
> +               break;
> +               case CRYPTO_ALG_TYPE_COMPRESS:
> +               misc_cleanup = tfm->__crt_alg->cra_u.compress.coa_cleanup;
> +               break;
> +       }
> +       if (misc_cleanup)       //only a select few need this.

Use /* ... */ instead of // style comments.

> +               (*misc_cleanup)(tfm);
> +
>         alg = tfm->__crt_alg;
>         size = sizeof(*tfm) + alg->cra_ctxsize;
> 
> diff -ur linux-2.6.18/include/linux/crypto.h
> linux-2.6.18-modified/include/linux/crypto.h
> --- linux-2.6.18/include/linux/crypto.h 2006-09-19 23:42:06.000000000 -0400
> +++ linux-2.6.18-modified/include/linux/crypto.h        2006-10-08
> 22:17:26.000000000 -0400
> @@ -83,6 +83,7 @@
>                           unsigned int keylen, u32 *flags);
>         void (*cia_encrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
>         void (*cia_decrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
> +       void (*cia_cleanup)(struct crypto_tfm *tfm);
> 
>         unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
>                                         u8 *dst, const u8 *src,
> @@ -104,6 +105,8 @@
>         void (*dia_update)(struct crypto_tfm *tfm, const u8 *data,
>                            unsigned int len);
>         void (*dia_final)(struct crypto_tfm *tfm, u8 *out);
> +       void (*dia_cleanup)(struct crypto_tfm *tfm);
> +
>         int (*dia_setkey)(struct crypto_tfm *tfm, const u8 *key,
>                           unsigned int keylen, u32 *flags);
>  };
> @@ -113,6 +116,7 @@
>                             unsigned int slen, u8 *dst, unsigned int *dlen);
>         int (*coa_decompress)(struct crypto_tfm *tfm, const u8 *src,
>                               unsigned int slen, u8 *dst, unsigned int *dlen);
> +       void (*coa_cleanup)(struct crypto_tfm *tfm);
>  };
> 
>  #define cra_cipher     cra_u.cipher

---
~Randy
