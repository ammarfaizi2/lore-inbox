Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267196AbTGLAgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbTGLAgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:36:19 -0400
Received: from dp.samba.org ([66.70.73.150]:15827 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267196AbTGLAgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:36:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.23320.180064.599815@cargo.ozlabs.ibm.com>
Date: Sat, 12 Jul 2003 10:49:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, axboe@suse.de, bernie@develer.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 as-iosched.c & asm-generic/div64.h breakage
In-Reply-To: <20030711140158.0b27117e.akpm@osdl.org>
References: <200307112048.h6BKmUQj003987@harpo.it.uu.se>
	<20030711140158.0b27117e.akpm@osdl.org>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >
> > drivers/block/as-iosched.c: In function `as_update_iohist':
> > drivers/block/as-iosched.c:840: warning: right shift count >= width of type
> > drivers/block/as-iosched.c:840: warning: passing arg 1 of `__div64_32' from incompatible pointer type
> 
> You mean that code was in -mm for all those months and no ppc32 person
> bothered testing it?  Bah.

We've only been getting those warnings since the changeover to the new
asm-generic/div64.h.  Settle down. :)

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

There are several interesting aspects to this:

1. For some reason the LBD config option in drivers/block/Kconfig
   depends on X86.  (CONFIG_LBD is what makes sector_t an unsigned
   long long instead of an unsigned long).  I think the LBD option
   should be available on all 32-bit platforms.  Working out a neat
   way to tell the config system that is left as an exercise for the
   reader. :)

2. It seems to me that seek_total is bounded above by 1024 * the
   maximum seek distance.  I'm a bit concerned about that overflowing
   32 bits - AFAICS I would only need a > 2GB disk (or do I mean
   partition?) for that to happen.  Could we make seek_total be a u64
   unconditionally please?

3. I guess that adding 128 on to the seek_total is to get a
   round-to-nearest effect in the division.  In fact you need to add
   on (seek_samples >> 1) to get that effect.

Regards,
Paul.
