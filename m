Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbTGKVWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266841AbTGKVWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:22:15 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:49314 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S266825AbTGKVWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:22:13 -0400
Date: Fri, 11 Jul 2003 23:36:51 +0200 (MEST)
Message-Id: <200307112136.h6BLapXt005156@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, mikpe@csd.uu.se
Subject: Re: 2.5.75 as-iosched.c & asm-generic/div64.h breakage
Cc: axboe@suse.de, bernie@develer.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003 14:01:58 -0700, Andrew Morton wrote:
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >
> > drivers/block/as-iosched.c: In function `as_update_iohist':
> > drivers/block/as-iosched.c:840: warning: right shift count >= width of type
> > drivers/block/as-iosched.c:840: warning: passing arg 1 of `__div64_32' from incompatible pointer type
> 
> You mean that code was in -mm for all those months and no ppc32 person
> bothered testing it?  Bah.

Apparently. I don't have time for anything but standard kernels.

> Something like this?  (Could be sped up for 32-bit sector_t)
> 
> diff -puN drivers/block/as-iosched.c~as-do_div-fix drivers/block/as-iosched.c
> --- 25/drivers/block/as-iosched.c~as-do_div-fix	Fri Jul 11 14:00:55 2003
> +++ 25-akpm/drivers/block/as-iosched.c	Fri Jul 11 14:00:58 2003
> @@ -836,8 +836,10 @@ static void as_update_iohist(struct as_i
>  		aic->seek_samples += 256;
>  		aic->seek_total += 256*seek_dist;
>  		if (aic->seek_samples) {
> -			aic->seek_mean = aic->seek_total + 128;
> -			do_div(aic->seek_mean, aic->seek_samples);
> +			u64 seek_mean = aic->seek_total + 128;
> +
> +			do_div(seek_mean, aic->seek_samples);
> +			aic->seek_mean = seek_mean;
>  		}
>  		aic->seek_samples = (aic->seek_samples>>1)
>  					+ (aic->seek_samples>>2);

Perhaps, but it's my opinion that do_div() needs to be made more robust,
since arch-specific data abstraction means that callers in generic code
don't always know if some value is u32 or u64.

So your change should be in do_div() itself, not in its callers.

/Mikael
