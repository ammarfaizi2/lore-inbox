Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVIZNGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVIZNGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIZNGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:06:37 -0400
Received: from adsl-ull-81-84.42-151.net24.it ([151.42.84.81]:47800 "HELO
	renditai.milesteg.arr") by vger.kernel.org with SMTP
	id S932122AbVIZNGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:06:36 -0400
In-Reply-To: <4337E76B.1090003@sw.ru>
References: <4337E76B.1090003@sw.ru>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8204E0D1-F30D-494F-8E97-CDCC26A82807@libero.it>
Cc: Vasily Averin <vvs@sw.ru>, Stanislav Protassov <st@sw.com.sg>,
       linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Daniele Venzano <webvenza@libero.it>
Subject: Re: [patch netdrvr sis900] net: come alive after temporary memory shortage
Date: Mon, 26 Sep 2005 15:06:32 +0200
To: Konstantin Khorenko <khorenko@sw.ru>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno 26/set/05, alle ore 14:19, Konstantin Khorenko ha scritto:
> Hope, you'll check this changes and find them usefull. :)
> Kernels with patches compile but untested.
> This patch is against mainstream 2.6.13.1 kernel.

> --- ./drivers/net/sis900.c.sis900    2005-08-29 03:41:01.000000000  
> +0400
> +++ ./drivers/net/sis900.c    2005-09-19 14:34:42.000000000 +0400

Please create the diff one directory above the root sources directory  
so that it is possible to apply with 'patch -p1'.

> @@ -1696,6 +1696,14 @@ static int sis900_rx(struct net_device *
>      long ioaddr = net_dev->base_addr;
>      unsigned int entry = sis_priv->cur_rx % NUM_RX_DESC;
>      u32 rx_status = sis_priv->rx_ring[entry].cmdsts;
> +    /*
> +     * If cur > dirty, then limit = NUM_RX_DESC - cur + dirty =
> +     *                NUM_RX_DESC + (dirty - cur)
> +     * If cur < dirty (cur overflowed, dirty - not), then
> +     *            limit = dirty - cur
> +     */
> +    int rx_work_limit =
> +        (sis_priv->dirty_rx - sis_priv->cur_rx) % NUM_RX_DESC;
Remove this comment, or move it to the description of the function  
above the sis900_rx() declaration.

>
>      if (netif_msg_rx_status(sis_priv))
>          printk(KERN_DEBUG "sis900_rx, cur_rx:%4.4d, dirty_rx:%4.4d "
> @@ -1705,6 +1713,8 @@ static int sis900_rx(struct net_device *
>      while (rx_status & OWN) {
>          unsigned int rx_size;
>
> +        if (--rx_work_limit < 0)
> +            break;
>          rx_size = (rx_status & DSIZE) - CRC_SIZE;
>
>          if (rx_status & (ABORT|OVERRUN|TOOLONG|RUNT|RXISERR|CRCERR| 
> FAERR)) {
> @@ -1770,6 +1780,7 @@ static int sis900_rx(struct net_device *
>                  sis_priv->rx_ring[entry].cmdsts = 0;
>                  sis_priv->rx_ring[entry].bufptr = 0;
>                  sis_priv->stats.rx_dropped++;
> +                sis_priv->cur_rx++;
>                  break;
>              }
>              skb->dev = net_dev;
> @@ -1787,7 +1798,7 @@ static int sis900_rx(struct net_device *
>
>      /* refill the Rx buffer, what if the rate of refilling is slower
>       * than consuming ?? */
> -    for (;sis_priv->cur_rx - sis_priv->dirty_rx > 0; sis_priv- 
> >dirty_rx++) {
> +    for (; sis_priv->cur_rx != sis_priv->dirty_rx; sis_priv- 
> >dirty_rx++) {
>          struct sk_buff *skb;
>
>          entry = sis_priv->dirty_rx % NUM_RX_DESC;

With those corrections, the patch should be resent to me, to Jeff  
Garzik and to the netdev mailing list for review and possibly inclusion.
Thanks for the contribution.

--
Daniele Venzano
http://www.brownhat.org

