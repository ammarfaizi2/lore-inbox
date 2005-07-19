Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVGSN56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVGSN56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVGSN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:56:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16070 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261372AbVGSNyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:54:38 -0400
Date: Tue, 19 Jul 2005 15:54:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LZF Cryptoapi support.
Message-ID: <20050719135441.GB2410@elf.ucw.cz>
References: <1121657429.13487.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121657429.13487.41.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's another resend, this time adding an lzf cryptoapi module.
> 
> LZF is a very fast compressor which typically achieves approximately 50%
> compression on a suspend image. The original author (Marc Alexander
> Lehmann) donated it to Suspend2. I have converted it to cryptoapi with a
> recent switch of Suspend2 to use cryptoapi.

And it is still that old, ugly code.

> +/*
> + * sacrifice some compression quality in favour of compression speed.
> + * (roughly 1-2% worse compression for large blocks and
> + * 9-10% for small, redundant, blocks and >>20% better speed in both cases)
> + * In short: enable this for binary data, disable this for text data.
> + */
> +#define ULTRA_FAST 1
> +
> +#define STRICT_ALIGN 0
> +#define USE_MEMCPY 1
> +#define INIT_HTAB 0

We do not want these options. It also allows you to kill ifdefs down
in the code.

> +#define HSIZE (1 << (HLOG))
> +
> +/*
> + * don't play with this unless you benchmark!
> + * decompression is not dependent on the hash function
> + * the hashing function might seem strange, just believe me
> + * it works ;)
> + */
> +#define FRST(p) (((p[0]) << 8) + p[1])
> +#define NEXT(v,p) (((v) << 8) + p[2])
> +#define IDX(h) ((((h ^ (h << 5)) >> (3*8 - HLOG)) + h*3) & (HSIZE - 1))
> +/*
> + * IDX works because it is very similar to a multiplicative hash, e.g.
> + * (h * 57321 >> (3*8 - HLOG))
> + * the next one is also quite good, albeit slow ;)
> + * (int)(cos(h & 0xffffff) * 1e6)
> + */
> +
> +#if 0
> +/* original lzv-like hash function */
> +# define FRST(p) (p[0] << 5) ^ p[1]
> +# define NEXT(v,p) ((v) << 5) ^ p[2]
> +# define IDX(h) ((h) & (HSIZE - 1))
> +#endif

And we do not want #if 0-ed code.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
