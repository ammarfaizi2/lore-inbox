Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVDCKZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVDCKZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDCKZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:25:57 -0400
Received: from [213.170.72.194] ([213.170.72.194]:46039 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261638AbVDCKXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:23:44 -0400
Message-ID: <424FC42E.80503@yandex.ru>
Date: Sun, 03 Apr 2005 14:23:42 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au>
In-Reply-To: <20050403101752.GA20866@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> You might be right.  But I'm not sure yet.
> 
> If we use the current code and supply zlib_deflate with 1048576-12 bytes
> of (incompressible) input and 1048576 bytes of output buffer, wouldn't
> zlib keep writing incompressible blocks and return when it can't do that
> anymore because the output buffer has been exhausted?
It must not. Look at the algoritm closer.

stream->next_in = (u8 *)src;
stream->next_out = dst;

while (stream->total_in < *slen
        && stream->total_out < *dlen - DEFLATE_PCOMPR_RESERVE) {

         stream->avail_out = *dlen - DEFLATE_PCOMPR_RESERVE - 
stream->total_out;
         stream->avail_in = min((unsigned int)(*slen - 
stream->total_in), stream->avail_out);

         ret = zlib_deflate(stream, Z_SYNC_FLUSH);
         if (ret != Z_OK)
                 return -EINVAL;
}

stream->avail_out += DEFLATE_PCOMPR_RESERVE;
stream->avail_in = 0; /* <------ no more input ! ---------- */

ret = zlib_deflate(stream, Z_FINISH);
if (ret != Z_STREAM_END)
         return -EINVAL;



> 
> When it does return it has to finish writing the last block it's on.
No, it must only put EOB and adler32, we won't give it more input.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
