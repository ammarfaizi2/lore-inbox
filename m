Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbRB0Bxu>; Mon, 26 Feb 2001 20:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbRB0Bxl>; Mon, 26 Feb 2001 20:53:41 -0500
Received: from hisl29.room-net.com ([63.123.124.29]:45064 "EHLO vaio.greennet")
	by vger.kernel.org with ESMTP id <S129421AbRB0Bxa>;
	Mon, 26 Feb 2001 20:53:30 -0500
Date: Mon, 26 Feb 2001 20:52:39 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH] via-rhine.c: don't reference skb after passing it to
 netif_rx
In-Reply-To: <20010226210441.K8692@conectiva.com.br>
Message-ID: <Pine.LNX.4.10.10102262050220.1129-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Arnaldo Carvalho de Melo wrote:

> Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> 	I've just read davem's post at netdev about the brokeness of
> referencing skbs after passing it to netif_rx, so please consider applying
> this patch. Ah, this was just added to the Janitor's TODO list at

> --- linux-2.4.2/drivers/net/via-rhine.c	Mon Dec 11 19:38:29 2000
> +++ linux-2.4.2.acme/drivers/net/via-rhine.c	Mon Feb 26 22:36:18 2001
> @@ -1147,9 +1147,9 @@
>  								 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
>  			}
>  			skb->protocol = eth_type_trans(skb, dev);
> +			np->stats.rx_bytes += skb->len;
>  			netif_rx(skb);
>  			dev->last_rx = jiffies;
> -			np->stats.rx_bytes += skb->len;
>  			np->stats.rx_packets++;
>  		}

Easier fix: 
-			np->stats.rx_bytes += skb->len;
+			np->stats.rx_bytes += pkt_len;

Grouping the writes to np->stats results in better cache usage.


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

