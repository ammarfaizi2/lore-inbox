Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRB0C43>; Mon, 26 Feb 2001 21:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRB0C4W>; Mon, 26 Feb 2001 21:56:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50576 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129525AbRB0C4Q>;
	Mon, 26 Feb 2001 21:56:16 -0500
Message-ID: <3A9B16E3.CB4CECAE@mandrakesoft.com>
Date: Mon, 26 Feb 2001 21:54:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cycx_x25: update last_rx after netif_rx
In-Reply-To: <20010226220620.W8692@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> --- linux-2.4.2/drivers/net/wan/cycx_x25.c      Tue Feb 13 19:15:05 2001
> +++ linux-2.4.2.acme/drivers/net/wan/cycx_x25.c Mon Feb 26 23:38:48 2001
> @@ -812,7 +812,6 @@
>         if (bitm)
>                 return; /* more data is coming */
> 
> -       dev->last_rx = jiffies;         /* timestamp */
>         chan->rx_skb = NULL;            /* dequeue packet */
> 
>         ++chan->ifstats.rx_packets;
> @@ -820,6 +819,7 @@
> 
>         skb->mac.raw = skb->data;
>         netif_rx(skb);
> +       dev->last_rx = jiffies;         /* timestamp */
>  }
> 
>  /* Connect interrupt handler. */

looks ok


> @@ -1454,11 +1454,12 @@
>          *ptr = event;
> 
>          skb->dev = dev;
> -        skb->protocol = htons(ETH_P_X25);
> +        skb->protocol = __constant_htons(ETH_P_X25);

The kernel definition for the htons macro should cover this..


>          skb->mac.raw = skb->data;
>          skb->pkt_type = PACKET_HOST;
> 
>          netif_rx(skb);
> +       dev->last_rx = jiffies;         /* timestamp */

I wonder about this... For this function it is sending an event, not
really a packet.  So should we really timestamp it like a real packet? 
If so, you should increase rx_packets and rx_bytes stats too, as well as
update last_rx here.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
