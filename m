Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVGRPbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVGRPbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVGRPbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:31:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53515 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261451AbVGRPbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:31:14 -0400
Date: Tue, 19 Jul 2005 01:30:55 +1000
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] no more need to check for NULL before calls to crypto_free_tfm
Message-ID: <20050718153055.GA14719@gondor.apana.org.au>
References: <200507170032.28174.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507170032.28174.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 12:32:27AM +0200, Jesper Juhl wrote:
> 
> --- linux-2.6.13-rc3-orig/drivers/block/cryptoloop.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.13-rc3/drivers/block/cryptoloop.c	2005-07-16 23:35:55.000000000 +0200
> @@ -227,14 +227,14 @@ cryptoloop_ioctl(struct loop_device *lo,
>  static int
>  cryptoloop_release(struct loop_device *lo)
>  {
> -	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
> -	if (tfm != NULL) {
> -		crypto_free_tfm(tfm);
> -		lo->key_data = NULL;
> -		return 0;
> +	struct crypto_tfm *tfm = lo->key_data;
> +	if (!tfm) {
> +		printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
> +		return -EINVAL;
>  	}
> -	printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
> -	return -EINVAL;
> +	crypto_free_tfm(tfm);
> +	lo->key_data = NULL;
> +	return 0;
>  }

This change looks rather pointless.

The rest of the patch looks good.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
