Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265516AbUFIKEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUFIKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 06:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUFIKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 06:04:09 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:54144 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265516AbUFIKEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 06:04:05 -0400
Date: Wed, 9 Jun 2004 12:03:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH 3/3] fix for small xloops [Was: Re: Too much error in __const_udelay() ?]
Message-ID: <20040609100347.GA28128@elf.ucw.cz>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com> <20040605152326.GA11239@dominikbrodowski.de> <1086635568.2234.171.camel@cog.beaverton.ibm.com> <20040607212303.GC23106@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607212303.GC23106@dominikbrodowski.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The const_udelay calculation relies on the "overflow" of the lower 32 bits
> of the mull operation. What's in the lower 32 bits is "cut off", so that a
> "rounding down" phenomenon exists. For large arguments to {n,u}delay, this does
> not matter, as udelay and ndelay round _up_ themselves. However, for small
> delays (for cyclone timer: up to 20ns; for pmtmr-based delay timer it's even
> up to 1500ns or 1us) it _is_ a critical error. Empirical testing has shown that
> it happens only (for usual values of loops_per_jiffies) if xloops is lower or
> equal to six. Let's be safe, and double that value, and add one xloop if
> xloop is smaller than 13.

Should not you just xloops++, always? Better safe than sorry. Plus you
have one less test and branch...

									Pavel

> Signed-off-by: Dominik Brodowski <linux@brodo.de>
> 
> diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
> --- linux-original/arch/i386/lib/delay.c	2004-06-07 23:02:02.472656160 +0200
> +++ linux/arch/i386/lib/delay.c	2004-06-07 22:55:40.063791144 +0200
> @@ -34,6 +34,8 @@
>  	__asm__("mull %0"
>  		:"=d" (xloops), "=&a" (d0)
>  		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * HZ));
> +	if (unlikely(xloops < 13))
> +		xloops++;
>          __delay(xloops);
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
934a471f20d6580d5aad759bf0d97ddc
