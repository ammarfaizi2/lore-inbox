Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQKNBmp>; Mon, 13 Nov 2000 20:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbQKNBmf>; Mon, 13 Nov 2000 20:42:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20229 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129786AbQKNBmZ>;
	Mon, 13 Nov 2000 20:42:25 -0500
Message-ID: <3A10916A.A53DBE7B@mandrakesoft.com>
Date: Mon, 13 Nov 2000 20:12:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] acenic driver update
In-Reply-To: <200011140031.TAA13437@plonk.linuxcare.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You would think it would be easier to maintain a separate 2.2.x and
2.4.x version of acenic.c at this point :)


Jes Sorensen wrote:
> @@ -2307,14 +2337,10 @@
>         u32 idx, flagsize;
> 
>         /*
> -        * ARGH, there is just no pretty way to do this
> +        * This only happens with pre-softnet, ie. 2.2.x kernels.
>          */
> -#if (LINUX_VERSION_CODE < 0x02032b)
> -       if (test_and_set_bit(0, &dev->tbusy))
> +       if (early_stop_netif_stop_queue(dev))
>                 return 1;
> -#else
> -       netif_stop_queue(dev);
> -#endif
> 
>         idx = ap->tx_prd;
> 
> @@ -2358,7 +2384,8 @@
>                  */
>                 mod_timer(&ap->timer, jiffies + (3 * HZ));
> 
> -               /* The following check will fix a race between the interrupt
> +               /*
> +                * The following check will fix a race between the interrupt
>                  * handler increasing the tx_ret_csm and testing for tx_full
>                  * and this tx routine's testing the tx_ret_csm and setting
>                  * the tx_full; note that this fix makes assumptions on the
> @@ -2369,13 +2396,17 @@
>                 if (((idx + 2) % TX_RING_ENTRIES != ap->tx_ret_csm)
>                         && xchg(&ap->tx_full, 0)) {
>                         del_timer(&ap->timer);
> +                       /*
> +                        * We may not need this one in the post softnet era
> +                        * in this case this can be changed to a
> +                        * early_stop_netif_wake_queue(dev);
> +                        */
>                         netif_wake_queue(dev);

nope, you don't need that.  if you are start_xmit, and you didn't stop
the queue yourself, there's no need to start it, and definitely no need
to wake...

you can probably remove 'tx_full' as well, as it is usually redundant to
tbusy/netif_{start,stop}_queue.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
