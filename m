Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVGaDk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVGaDk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVGaDk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:40:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:42256 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261585AbVGaDk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:40:26 -0400
Date: Sun, 31 Jul 2005 13:40:10 +1000
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix cryptoapi deflate not handling PAGE_SIZE chunks.
Message-ID: <20050731034010.GA5564@gondor.apana.org.au>
References: <1121657195.13487.36.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121657195.13487.36.camel@localhost>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2005 at 01:26:35PM +1000, Nigel Cunningham wrote:
> 
> Here's a resend of a patch I'm using in Suspend2's new cryptoapi
> support, which is needed for us to successfully compress pages using
> deflate. It's along the lines of the existing fix in the decompression
> code.
>
> diff -ruNp 190-cryptoapi-deflate.patch-old/crypto/deflate.c 190-cryptoapi-deflate.patch-new/crypto/deflate.c
> --- 190-cryptoapi-deflate.patch-old/crypto/deflate.c	2005-06-20 11:46:49.000000000 +1000
> +++ 190-cryptoapi-deflate.patch-new/crypto/deflate.c	2005-07-04 23:14:20.000000000 +1000
> @@ -143,8 +143,15 @@ static int deflate_compress(void *ctx, c
>  
>  	ret = zlib_deflate(stream, Z_FINISH);
>  	if (ret != Z_STREAM_END) {
> -		ret = -EINVAL;
> -		goto out;
> +	    	if (!(ret == Z_OK && !stream->avail_in && !stream->avail_out)) {
> +			ret = -EINVAL;
> +			goto out;
> +		} else {
> +			u8 zerostuff = 0;
> +			stream->next_out = &zerostuff;
> +			stream->avail_out = 1; 
> +			ret = zlib_deflate(stream, Z_FINISH);
> +		}
>  	}
>  	ret = 0;
>  	*dlen = stream->total_out;

Hi Nigel, I need a bit more information about this patch.
Do you have a specific input stream that requires a fix like
this?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
