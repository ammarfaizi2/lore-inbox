Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752317AbWCKClc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWCKClc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbWCKClc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:41:32 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:20238
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1752315AbWCKClb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:41:31 -0500
Date: Sat, 11 Mar 2006 13:41:16 +1100
To: Adrian Bunk <bunk@stusta.de>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/aes.c: array overrun
Message-ID: <20060311024116.GA21856@gondor.apana.org.au>
References: <20060311010339.GF21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311010339.GF21864@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 02:03:39AM +0100, Adrian Bunk wrote:
>
> ...
> #define loop8(i)                                    \

...

>     t ^= E_KEY[8 * i + 7]; E_KEY[8 * i + 15] = t;   \
> }
> 
> static int
> aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
> {
> ...
>         case 32:
> ...
>                 for (i = 0; i < 7; ++i)
>                         loop8 (i);

OK this is not pretty but it is actually correct.  Notice how we only
overstep the mark for E_KEY but never for D_KEY.  Since D_KEY is only
initialised after this, it is OK for us to trash the start of D_KEY.

It's just a trick that makes the code slightly nicer (and no I didn't
write this nor am I necessarily condoning it :)

Thanks for reporting this though.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
