Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVDCLlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDCLlW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDCLlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:41:22 -0400
Received: from [213.170.72.194] ([213.170.72.194]:46812 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261683AbVDCLlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:41:12 -0400
Message-ID: <424FD653.7020204@yandex.ru>
Date: Sun, 03 Apr 2005 15:41:07 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au>
In-Reply-To: <20050331095151.GA13992@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

I also wonder, does it at all correct to use negative windowBits in 
crypto API? I mean, if windowBits is negative, zlib doesn't produce the 
proper zstream header, which is incorrect according to RFC-1950. It also 
doesn't calculate adler32.

For example, if we work over an IP network (RFC-2384), the receiving 
side may be confused by such a "stripped" zstream.

Isn't it conceptually right to produce *correct* zstream, with the 
header and the proper adler32 ?

Yes, for JFFS2 we would like to have no adler32, we anyway protect our 
data by CRC32. But I suppose this should be an additional feature.

Comments?

Herbert Xu wrote:
>>I made the changes to deflate_decompr() because the old version doesn't
>>work properly for me. There are 2 changes.
>>
>>1. I've added the following code:
>>
>>------------------------------------------------------------------------
>>if (slen > 2 && !(src[1] & PRESET_DICT) /* No preset dictionary */
>>    && ((src[0] & 0x0f) == Z_DEFLATED)  /* Comp. method byte is OK */
>>    && !(((src[0] << 8) + src[1]) % 31)) {      /* CMF*256 + FLG */
>>    stream->next_in += 2;
>>    stream->avail_in -= 2;
>>}
>>------------------------------------------------------------------------
> 
> The reason you need to add this is because the window bits that
> was used to produce the compressed data is positive while the window
> bits crypto/deflate is using to perform the decompression isn't.
> 
> So what we should do here is turn window bits into a configurable
> parameter.
> 
> Once you supply the correct window bits information, the above is
> then simply an optimisation.
> 
> Rather than keeping the above optimisation, JFFS should simply do
> the compression with a negative window bits value.
> 
> Of course to maintain backwards compatibility you'll need to do this
> as a new compression type.
>  


-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
