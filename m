Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUBZTgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbUBZTgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:36:19 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:22695 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262956AbUBZTf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:35:59 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <20040225214308.GD3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
	 <20040219111835.192d2741.akpm@osdl.org>
	 <20040220171427.GD9266@certainkey.com>
	 <20040221021724.GA8841@leto.cs.pocnet.net>
	 <20040224191142.GT3883@waste.org>
	 <1077651839.11170.4.camel@leto.cs.pocnet.net>
	 <20040224203825.GV3883@waste.org>  <20040225214308.GD3883@waste.org>
Content-Type: text/plain
Message-Id: <1077824146.14794.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 20:35:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 25.02.2004 schrieb Matt Mackall um 22:43:

> Ok, here's my proposed API extension (currently untested). Christophe,
> care to give it a spin?
>
> diff -puN crypto/api.c~crypto-copy crypto/api.c
> --- tiny/crypto/api.c~crypto-copy	2004-02-25 15:12:43.000000000 -0600
> +++ tiny-mpm/crypto/api.c	2004-02-25 15:37:39.000000000 -0600
> @@ -161,6 +161,27 @@ void crypto_free_tfm(struct crypto_tfm *
>  	kfree(tfm);
>  }
>  
> +int crypto_copy_tfm(char *dst, const struct crypto_tfm *src, unsigned size)
> +{
> +	int s = crypto_tfm_size(src);
> +
> +	if (size < s)
> +		return 0;

Why the extra check?

> +void crypto_cleanup_copy_tfm(char *user_tfm)
> +{
> +	crypto_exit_ops((struct crypto_tfm *)user_tfm);

This looks dangerous. The algorithm might free a buffer. This is only
safe if we introduce per-algorithm copy methods that also duplicate
external buffers.

I'd like to avoid a kmalloc in crypto_copy_tfm. This function also does
the same as crypto_free_tfm except for the final kfree(tfm). So
crypto_free_tfm could call this function. And it could have a better
name.


