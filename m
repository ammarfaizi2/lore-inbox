Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVCaJ5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVCaJ5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVCaJzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:55:23 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:46354 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261213AbVCaJxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:53:22 -0500
Date: Thu, 31 Mar 2005 19:51:51 +1000
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       svenning@post5.tele.dk, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050331095151.GA13992@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112030556.17983.35.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 05:22:36PM +0000, Artem B. Bityuckiy wrote:
> 
> I made the changes to deflate_decompr() because the old version doesn't
> work properly for me. There are 2 changes.
> 
> 1. I've added the following code:
> 
> ------------------------------------------------------------------------
> if (slen > 2 && !(src[1] & PRESET_DICT) /* No preset dictionary */
>     && ((src[0] & 0x0f) == Z_DEFLATED)  /* Comp. method byte is OK */
>     && !(((src[0] << 8) + src[1]) % 31)) {      /* CMF*256 + FLG */
>     stream->next_in += 2;
>     stream->avail_in -= 2;
> }
> ------------------------------------------------------------------------

The reason you need to add this is because the window bits that
was used to produce the compressed data is positive while the window
bits crypto/deflate is using to perform the decompression isn't.

So what we should do here is turn window bits into a configurable
parameter.

Once you supply the correct window bits information, the above is
then simply an optimisation.

Rather than keeping the above optimisation, JFFS should simply do
the compression with a negative window bits value.

Of course to maintain backwards compatibility you'll need to do this
as a new compression type.
 
> 2. I've removed the "strange" (for me) uncompress sequence:
> 
> ------------------------------------------------------------------------
> ret = zlib_inflate(stream, Z_SYNC_FLUSH);
> /*
>  * Work around a bug in zlib, which sometimes wants to taste an extra
>  * byte when being used in the (undocumented) raw deflate mode.
>  * (From USAGI).
>  */

I believe this bit of code originally came from FreeS/WAN and was
written by Svenning Sørensen.  Maybe he or Yoshifuji-san can tell
us why?

Unless we're sure that zlib has been fixed we should leave it in.
It should be a no-op if zlib has been fixed.  So this probably
isn't causing the breakage that you saw.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
