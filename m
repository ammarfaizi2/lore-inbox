Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWAXXDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWAXXDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWAXXDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:03:51 -0500
Received: from host233.omnispring.com ([69.44.168.233]:41301 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1750815AbWAXXDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:03:51 -0500
Message-ID: <43D6B231.30702@cfl.rr.com>
Date: Tue, 24 Jan 2006 18:03:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Stefan Rompf <stefan@loplof.de>
CC: Andrew Morton <akpm@osdl.org>, Clemens Fruhwirth <clemens@endorphin.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
References: <200601042108.04544.stefan@loplof.de>
In-Reply-To: <200601042108.04544.stefan@loplof.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2006 23:04:06.0244 (UTC) FILETIME=[79D4B240:01C6213A]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14226.000
X-TM-AS-Result: No--9.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once the page is placed on the free list, doesn't that prevent it from 
being swapped out?  swsusp doesn't bother saving free pages and before 
the pages can be recycled, the kernel zeros them right?

Stefan Rompf wrote:
> Hi Andrew,
>
> dm-crypt does not clear struct crypt_config before freeing it. Thus, 
> information on the key could leak f.e. to a swsusp image even after the 
> encrypted device has been removed. The attached patch against 2.6.14 / 2.6.15 
> fixes it.
>
> Signed-off-by: Stefan Rompf <stefan@loplof.de>
> Acked-by: Clemens Fruhwirth <clemens@endorphin.org>
>
> --- linux-2.6.14.4/drivers/md/dm-crypt.c.old	2005-12-16 18:27:05.000000000 +0100
> +++ linux-2.6.14.4/drivers/md/dm-crypt.c	2005-12-28 12:49:13.000000000 +0100
> @@ -694,6 +694,7 @@ bad3:
>  bad2:
>  	crypto_free_tfm(tfm);
>  bad1:
> +	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
>  	kfree(cc);
>  	return -EINVAL;
>  }
> @@ -710,6 +711,7 @@ static void crypt_dtr(struct dm_target *
>  		cc->iv_gen_ops->dtr(cc);
>  	crypto_free_tfm(cc->tfm);
>  	dm_put_device(ti, cc->dev);
> +	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
>  	kfree(cc);
>  }
>  
>
> -
>
>   

