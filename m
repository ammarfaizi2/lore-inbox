Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWDESFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWDESFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWDESFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:05:24 -0400
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:13075
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751313AbWDESFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:05:24 -0400
Date: Thu, 6 Apr 2006 04:05:20 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
Message-ID: <20060405180520.GA15151@gondor.apana.org.au>
References: <20060309.123608.08076793.nemoto@toshiba-tops.co.jp> <20060404.000407.41198995.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.000407.41198995.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 12:04:07AM +0900, Atsushi Nemoto wrote:
>
> @@ -38,12 +39,24 @@ static void update(struct crypto_tfm *tf
>  			unsigned int bytes_from_page = min(l, ((unsigned int)
>  							   (PAGE_SIZE)) - 
>  							   offset);
> -			char *p = crypto_kmap(pg, 0) + offset;
> +			char *src = crypto_kmap(pg, 0);
> +			char *p = src + offset;
>  
> +			if (unlikely(offset & alignmask)) {
> +				unsigned int bytes =
> +					alignmask + 1 - (offset & alignmask);
> +				bytes = min(bytes, bytes_from_page);
> +				tfm->__crt_alg->cra_digest.dia_update
> +						(crypto_tfm_ctx(tfm), p,
> +						 bytes);

Don't we need to copy this to an aligned buffer?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
