Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265088AbUFGWA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265088AbUFGWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbUFGWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:00:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48315 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265088AbUFGWAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:00:21 -0400
Subject: Re: [PATCH 1/3] mull'ify multiplication with HZ in
	__const_udelay() [Was: Re: Too much error in __const_udelay() ?]
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>,
       garloff@suse.de
In-Reply-To: <20040607212058.GA23106@dominikbrodowski.de>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com>
	 <20040605152326.GA11239@dominikbrodowski.de>
	 <1086635568.2234.171.camel@cog.beaverton.ibm.com>
	 <20040607212058.GA23106@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1086645655.2234.182.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 07 Jun 2004 15:00:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 14:20, Dominik Brodowski wrote:
> Move the multiplication of (loops_per_jiffy * xloops) with HZ into
> the "mull" asm operation. This increases the accuracy of the delay functions
> largely:
> 
[snip]
> diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
> --- linux-original/arch/i386/lib/delay.c	2004-06-07 22:01:46.608351088 +0200
> +++ linux/arch/i386/lib/delay.c	2004-06-07 22:05:03.299449496 +0200
> @@ -33,8 +33,8 @@
>  	int d0;
>  	__asm__("mull %0"
>  		:"=d" (xloops), "=&a" (d0)
> -		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
> -        __delay(xloops * HZ);
> +		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * HZ));
> +        __delay(xloops);
>  }

Kurt Garloff brought up a good point that loops_per_jiffy*HZ is only
good up to 4Ghz time sources. The workaround he suggested was to
multiply xloops by 4 first and divide HZ by 4. This will allow for
frequencies up to 16Ghz. 

So something like:

	xloops *= 4;
	__asm__("mull %0"
		:"=d" (xloops), "=&a" (d0)
		:"1" (xloops),"0" (LPJ*(HZ/4)));

-john

