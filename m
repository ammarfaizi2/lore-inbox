Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSHDR2w>; Sun, 4 Aug 2002 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHDR2w>; Sun, 4 Aug 2002 13:28:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:517 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316185AbSHDR2v>;
	Sun, 4 Aug 2002 13:28:51 -0400
Message-ID: <3D4D6527.8080405@mandrakesoft.com>
Date: Sun, 04 Aug 2002 13:32:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for dl2k
References: <20020804170747.M24631@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> synchronise_irq now takes an argument.
> it was using set_bit / test_bit inappropriately.
> 
> diff -urpNX dontdiff linux-2.5.30/drivers/net/dl2k.c linux-2.5.30-willy/drivers/net/dl2k.c
> --- linux-2.5.30/drivers/net/dl2k.c	2002-06-20 16:53:51.000000000 -0600
> +++ linux-2.5.30-willy/drivers/net/dl2k.c	2002-08-04 08:23:47.000000000 -0600
> @@ -1108,7 +1108,6 @@ set_multicast (struct net_device *dev)
>  	u16 rx_mode = 0;
>  	int i;
>  	int bit;
> -	int index, crc;
>  	struct dev_mc_list *mclist;
>  	struct netdev_private *np = dev->priv;
>  	
> @@ -1130,13 +1129,14 @@ set_multicast (struct net_device *dev)
>  		for (i=0, mclist = dev->mc_list; mclist && i < dev->mc_count; 
>  			i++, mclist=mclist->next) {
>  
> -			crc = ether_crc_le (ETH_ALEN, mclist->dmi_addr);
> +			int index = 0;
> +			int crc = ether_crc_le (ETH_ALEN, mclist->dmi_addr);
>  
>  			/* The inverted high significant 6 bits of CRC are
>  			   used as an index to hashtable */
> -			for (index = 0, bit = 0; bit < 6; bit++)
> -				if (test_bit(31 - bit, &crc))
> -					set_bit(bit, &index);
> +			for (bit = 0; bit < 6; bit++)
> +				if (crc & (1 << (31 - bit)))
> +					index |= (1 << bit);
>  
>  			hash_table[index / 32] |= (1 << (index % 32));
>  		}

patch applied


> @@ -1635,7 +1635,7 @@ rio_close (struct net_device *dev)
>  
>  	/* Stop Tx and Rx logics */
>  	writel (TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl);
> -	synchronize_irq ();
> +	synchronize_irq (dev->irq);
>  	free_irq (dev->irq, dev);
>  	del_timer_sync (&np->timer);


patch already applied, dropping hunk

	Jeff


