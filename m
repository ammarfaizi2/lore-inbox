Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVDRJC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVDRJC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVDRJC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:02:58 -0400
Received: from hermes.domdv.de ([193.102.202.1]:43269 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261987AbVDRJBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:01:41 -0400
Message-ID: <42637775.8000904@domdv.de>
Date: Mon, 18 Apr 2005 11:01:41 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: Re: [RFC][PATCH 2/4] AES assembler implementation for x86_64
References: <4262B6E9.8040400@domdv.de> <200504181118.50594.vda@ilport.com.ua>
In-Reply-To: <200504181118.50594.vda@ilport.com.ua>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Sunday 17 April 2005 22:20, Andreas Steinmetz wrote:
> 
>>The attached patch contains Gladman's in-kernel code for key schedule
>>and table generation modified to fit to my assembler implementation,
>>-- 
>>Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
> 
> 
> Patch contains a mix of several coding styles:
>  
> +/*
> + * #define byte(x, nr) ((unsigned char)((x) >> (nr*8))) 
> + */
> +inline static u8
> +byte(const u32 x, const unsigned n)
> +{
> +       return x >> (n << 3);
> +}
> 
> what does const do here?

Taken 'as is' from current kernel sources, i,e, crypto/aes.c

> 
> +static inline u32 ror32(u32 word, unsigned int shift)
> +{
> +       return (word >> shift) | (word << (32 - shift));
> +}
> +
> +static inline u8 __init
> +f_mult (u8 a, u8 b)
> +{
> +       u8 aa = log_tab[a], cc = aa + log_tab[b];
> +
> +       return pow_tab[cc + (cc < aa ? 1 : 0)];
> +}
> 
> Can you stick to either
> 	type f()
> or
> 	type
> 	f()
> style, but not both at once?

As above.

> 
> +#define ls_box(x)                              \
> +    ( aes_fl_tab[0][byte(x, 0)] ^              \
> +      aes_fl_tab[1][byte(x, 1)] ^              \
> +      aes_fl_tab[2][byte(x, 2)] ^              \
> +      aes_fl_tab[3][byte(x, 3)] )
> 
> +#define star_x(x) (((x) & 0x7f7f7f7f) << 1) ^ ((((x) & 0x80808080) >> 7) * 0x1b)
> 
> You used inlines for complex function-like calls above, why not here?

As above.

> 
> +#define imix_col(y,x)       \
> +    u   = star_x(x);        \
> +    v   = star_x(u);        \
> +    w   = star_x(v);        \
> +    t   = w ^ (x);          \
> +   (y)  = u ^ v ^ w;        \
> +   (y) ^= ror32(u ^ t,  8) ^ \
> +          ror32(v ^ t, 16) ^ \
> +          ror32(t,24)
> 
> this #define is bad, bad, BAD. Imagine: if(...) imix_col(a,b);
> Also I'm not sure that usage of "hidden" params (u,v,w,t) is ok.

As above.

> --
> vda
> 

The thing is I didn't want to modify the existing source code of
crpto/aes.c except where necessary.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
