Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbVKJC7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbVKJC7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbVKJC7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:59:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27379 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751678AbVKJC7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:59:11 -0500
Message-ID: <4372B7A8.5060904@mvista.com>
Date: Wed, 09 Nov 2005 18:59:52 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, dwmw2@infradead.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: latest mtd changes broke collie
References: <20051109221712.GA28385@elf.ucw.cz>
In-Reply-To: <20051109221712.GA28385@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Latest mtd changes break collie...it now oopses during boot. This
> reverts the bad patch.

What tree was this generated against?  It doesn't seem to match recent 
linux-mtd or kernel.org trees.  It looks like the tree used had 
different version of a couple fixes recently added to linux-mtd (removal 
of bogus udelays and 32-bit status datatype).

I'm guessing the important part is to add a missing spin_unlock_bh(), 
which is definitely a bug in the mtd code, but this code is so different 
than linux-mtd CVS that it seems more resyncing is needed.  As it stands 
now, force-fitting this patch would still leave an unbalanced 
spin_lock_bh() without other changes.  And it does look like this driver 
hasn't been converted to modern mtd apis.

> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/drivers/mtd/chips/sharp.c b/drivers/mtd/chips/sharp.c
> --- a/drivers/mtd/chips/sharp.c
> +++ b/drivers/mtd/chips/sharp.c
> @@ -4,7 +4,7 @@
>   * Copyright 2000,2001 David A. Schleef <ds@schleef.org>
>   *           2000,2001 Lineo, Inc.
>   *
> - * $Id: sharp.c,v 1.16 2005/11/07 11:14:23 gleixner Exp $
> + * $Id: sharp.c,v 1.14 2004/08/09 13:19:43 dwmw2 Exp $
>   *
>   * Devices supported:
>   *   LH28F016SCT Symmetrical block flash memory, 2Mx8
> @@ -32,7 +32,6 @@
>  #include <linux/mtd/cfi.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
> -#include <linux/slab.h>
>  
>  #define CMD_RESET		0xffffffff
>  #define CMD_READ_ID		0x90909090
> @@ -234,7 +233,7 @@ static int sharp_probe_map(struct map_in
>  /* This function returns with the chip->mutex lock held. */
>  static int sharp_wait(struct map_info *map, struct flchip *chip)
>  {
> -	int status, i;
> +	__u32 status;
>  	unsigned long timeo = jiffies + HZ;
>  	DECLARE_WAITQUEUE(wait, current);
>  	int adr = 0;
> @@ -247,11 +246,13 @@ retry:
>  		map_write32(map, CMD_READ_STATUS, adr);
>  		chip->state = FL_STATUS;
>  	case FL_STATUS:
> -		for(i=0;i<100;i++){
> -			status = map_read32(map,adr);
> -			if((status & SR_READY)==SR_READY)
> -				break;
> -			udelay(1);
> +		status = map_read32(map,adr);
> +		if ((status & SR_READY) == SR_READY)
> +			break;
> +		spin_unlock_bh(chip->mutex);
> +		if (time_after(jiffies, timeo)) {
> +			printk("Waiting for chip to be ready timed out in erase\n");
> +			return -EIO;
>  		}
>  		sharp_udelay(1);
>  		goto retry;
> @@ -491,11 +492,7 @@ static inline int sharp_do_wait_for_read
>  		spin_lock_bh(chip->mutex);
>  
>  		remove_wait_queue(&chip->wq, &wait);
> -
> -		if (signal_pending(current)){
> -			ret = -EINTR;
> -			goto out;
> -		}
> +		set_current_state(TASK_RUNNING);
>  	}
>  	ret = -ETIME;
>  out:
> 
> 
> 


-- 
Todd
