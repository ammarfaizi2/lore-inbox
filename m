Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTGBQCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTGBQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:02:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10117 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264455AbTGBQCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:02:32 -0400
Date: Wed, 2 Jul 2003 09:16:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
cc: Andrea Arcangeli <andrea@suse.de>, Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
In-Reply-To: <200307020852.17782.bernie@develer.com>
Message-ID: <Pine.LNX.4.44.0307020914210.4380-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Jul 2003, Bernardo Innocenti wrote:
> +#elif BITS_PER_LONG == 32
> +
> +# define do_div(n,base)	({					\
> +								\
> +	uint32_t __low, __low2, __high, __rem;			\
> +	__low  = (n) & 0xffffffff;				\
> +	__high = (n) >> 32;					\
> +	if (__high) {						\
> +		__rem   = __high % (uint32_t)(base);		\
> +		__high  = __high / (uint32_t)(base);		\
> +		__low2  = __low >> 16;				\
> +		__low2 += __rem << 16;				\
> +		__rem   = __low2 % (uint32_t)(base);		\
> +		__low2  = __low2 / (uint32_t)(base);		\
> +		__low   = __low & 0xffff;			\
> +		__low  += __rem << 16;				\
> +		__rem   = __low  % (uint32_t)(base);		\
> +		__low   = __low  / (uint32_t)(base);		\
> +		(n) = __low  + ((uint64_t)__low2 << 16) +	\
> +			((uint64_t) __high << 32);		\
> +	} else {						\
> +		__rem = __low % (uint32_t)(base);		\
> +		(n) = (__low / (uint32_t)(base));		\
> +	}							\
> +	__rem;							\
> + })

Don't do this as a in-line thing. Do it as an out-of-line function, 
something like

	#define do_div64(n,base) ({			\
		u32 __rem;				\
		n = lib_do_div64(n, base, &__rem);	\
		__rem; })

instead. Add the out-of-line thing to lib/lib.a or something.

		Linus

