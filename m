Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVDCMIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVDCMIC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVDCMIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:08:02 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:2572 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261702AbVDCMHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:07:46 -0400
Date: Sun, 3 Apr 2005 22:07:09 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403120709.GB21388@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au> <424FD653.7020204@yandex.ru> <20050403114704.GC21255@gondor.apana.org.au> <424FDB0F.6000304@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FDB0F.6000304@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 04:01:19PM +0400, Artem B. Bityuckiy wrote:
> 
> >For instance for JFFS2 it's absolutely incorrect since it breaks
> >compatibility.  Incidentally, JFFS should create a new compression
> >type that doesn't include the zlib header so that we don't need the
> >head-skipping speed hack.
>
> Anyway, in JFFS2 we may do that "hack" before calling pcompress(), so it 
> isn't big problem.

It still makes sense to use a negative window bits for JFFS since it
means that you don't have to calculate the adler checksum in the
first place AND you don't have to store the zlib header/trailer on
disk.

BTW, that hack can only be applied when there is no preset dictionary.
Although the Linux implementation of JFFS probably never used a preset
dictionary, it is theoretically possible that someone out there may
have generated a JFFS image which contains a compressed stream that has
a preset dictionary.

In that case if you don't set the window bits to a postive value it
won't work at all.

> >Yes, I'd love to see a patch that makes windowBits configurable in
> >crypto/deflate.c.
>
> I wonder, do we really want this?

Yes since the the window bits determines the compression quality and
the amount of memory used.  This is going to differ depending on the
application.

> Imagine we have 100 different compressors, and each is differently 
> configurable. It may make cryptoAPI messy. May be it is better to stand 
> that user must use deflate (and the other 99 compressors) directly if he 
> wants something not standard/compliant?

Each crypto/deflate user gets their own private zlib instance.
Where is the problem?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
