Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311597AbSCTNoF>; Wed, 20 Mar 2002 08:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311599AbSCTNns>; Wed, 20 Mar 2002 08:43:48 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:44048 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311598AbSCTNnS>;
	Wed, 20 Mar 2002 08:43:18 -0500
Date: Wed, 20 Mar 2002 10:43:04 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-030-writeout_scheduling
In-Reply-To: <3C980855.C5A8CED8@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203201039510.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:

> 1: Introduces two new bdflush tunables:
>
>   ndirty
>
>     The maximum number of buffers which bdflush will attempt to
>     write out in response to a wakeup.  Previously, bdflush would write
>     out the whole world.
>
>     So this limits the amount of bdflush writeout in response to a
>     single wakeup_bdflush().
>
>     NOTE: this code appears to be broken.  If nfract_stop_bdflush
>           is set at zero, ndirty will not prevent bdflush from writing out
>           all dirty buffers.   IOW, ndirty doesn't do anything at present.

Indeed, I suspect you'll want to either fix this or remove
the code before submitting the patch.  Including dead code
right from the start seems kind of pointless.

Note that if you have the ndirty thing functional, the
nfract_stop_bdflush tunable isn't doing anything, since
kswapd would stop after ndirty pages ...



> @@ -2957,13 +2963,18 @@ int bdflush(void *startup)
>  	complete((struct completion *)startup);
>
>  	for (;;) {
> +		int ndirty = bdf_prm.b_un.ndirty;
> +
>  		CHECK_EMERGENCY_SYNC
>
> -		spin_lock(&lru_list_lock);
> -		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
> -			wait_for_some_buffers(NODEV);
> -			interruptible_sleep_on(&bdflush_wait);
> +		while (ndirty > 0) {
> +			spin_lock(&lru_list_lock);
> +			if (!write_some_buffers(NODEV))
> +				break;
> +			ndirty -= NRSYNC;
>  		}
> +		if (ndirty > 0 || bdflush_stop())
> +			interruptible_sleep_on(&bdflush_wait);
>  	}
>  }

To make ndirty functional, you could either make the sleep
unconditional, or change the if condition to the following:

if (bdf_prm.b_un.ndirty > 0 || bdflush_stop())
	interruptible_sleep_on(&bdflush_wait);

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

