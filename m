Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbTC2FPB>; Sat, 29 Mar 2003 00:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263385AbTC2FPB>; Sat, 29 Mar 2003 00:15:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9862 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263384AbTC2FPA>;
	Sat, 29 Mar 2003 00:15:00 -0500
Message-ID: <3E852E93.9090404@pobox.com>
Date: Sat, 29 Mar 2003 00:26:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: misc au1000 cleanups.
References: <200303241642.h2OGg035008226@deviant.impure.org.uk>
In-Reply-To: <200303241642.h2OGg035008226@deviant.impure.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@codemonkey.org.uk wrote:
> - Missing release region
> - Unneeded initialisation of private struct
>   (already done in init_etherdev)
> - Remove unneeded freeing of dev->priv
>   (auto-free'd by kfree(dev)
> - actually kfree (dev), plugging leak.
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/au1000_eth.c linux-2.5/drivers/net/au1000_eth.c
> --- bk-linus/drivers/net/au1000_eth.c	2003-03-08 09:57:14.000000000 +0000
> +++ linux-2.5/drivers/net/au1000_eth.c	2003-02-20 12:16:32.000000000 +0000
> @@ -675,37 +675,24 @@ au1000_probe1(struct net_device *dev, lo
>  	char *pmac, *argptr;
>  	char ethaddr[6];
>  
> -	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET")) {
> +	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET"))
>  		 return -ENODEV;
> -	}
>  
>  	if (version_printed++ == 0) printk(version);
>  
> -	if (!dev) {
> +	if (!dev)
>  		dev = init_etherdev(0, sizeof(struct au1000_private));
> -	}
> +
>  	if (!dev) {
> -		 printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
> -		 return -ENODEV;
> +		printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
> +		release_region(ioaddr, MAC_IOSIZE);
> +		return -ENODEV;
>  	}


'dev' is always NULL as passed to the function... just kill the argument 
to the function.  Otherwise, looks ok.

	Jeff



