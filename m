Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbRB0EKV>; Mon, 26 Feb 2001 23:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRB0EKL>; Mon, 26 Feb 2001 23:10:11 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:63471 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129555AbRB0EKC>; Mon, 26 Feb 2001 23:10:02 -0500
Date: Mon, 26 Feb 2001 23:30:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike McLagan <mike.mclagan@linux.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlci: update last_rx after netif_rx
Message-ID: <20010226233055.H8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mike McLagan <mike.mclagan@linux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010226221151.X8692@conectiva.com.br> <3A9B174D.6B9A3C9C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A9B174D.6B9A3C9C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 26, 2001 at 09:56:13PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 26, 2001 at 09:56:13PM -0500, Jeff Garzik escreveu:
> Arnaldo Carvalho de Melo wrote:
> > --- linux-2.4.2/drivers/net/wan/dlci.c  Tue Feb 13 19:15:05 2001
> > +++ linux-2.4.2.acme/drivers/net/wan/dlci.c     Mon Feb 26 23:43:25 2001
> > @@ -229,6 +229,7 @@
> >                 skb_pull(skb, header);
> >                 netif_rx(skb);
> >                 dlp->stats.rx_packets++;
> > +               dev->last_rx = jiffies;
> 
> You need to update dlp->stats.rx_bytes too.

thanks, updated patch, there was no previous variable with  the pkt lenght,
so I've added one, hope is ok.

- Arnaldo


--- linux-2.4.2/drivers/net/wan/dlci.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/wan/dlci.c	Tue Feb 27 00:03:05 2001
@@ -205,7 +205,7 @@
 
 			case FRAD_P_IP:
 				header = sizeof(hdr->control) + sizeof(hdr->IP_NLPID);
-				skb->protocol = htons(ETH_P_IP);
+				skb->protocol = __constant_htons(ETH_P_IP);
 				process = 1;
 				break;
 
@@ -224,11 +224,14 @@
 
 	if (process)
 	{
+		int pktlen = skb->len;
 		/* we've set up the protocol, so discard the header */
 		skb->mac.raw = skb->data; 
 		skb_pull(skb, header);
 		netif_rx(skb);
 		dlp->stats.rx_packets++;
+		dlp->stats.rx_bytes += pktlen;
+		dev->last_rx = jiffies;
 	}
 	else
 		dev_kfree_skb(skb);
