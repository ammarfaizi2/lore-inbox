Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbRB0B4k>; Mon, 26 Feb 2001 20:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRB0B4c>; Mon, 26 Feb 2001 20:56:32 -0500
Received: from mail3.atl.bellsouth.net ([205.152.0.38]:58291 "EHLO
	mail3.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129434AbRB0B4Y>; Mon, 26 Feb 2001 20:56:24 -0500
Message-ID: <3A9B0936.17170236@mandrakesoft.com>
Date: Mon, 26 Feb 2001 20:56:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, dahinds@users.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c589_cs: don't reference skb after passing it to netif_rx
In-Reply-To: <20010226211058.M8692@conectiva.com.br>
Content-Type: multipart/mixed;
 boundary="------------02D4E90087C9DB5CDB0296CB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------02D4E90087C9DB5CDB0296CB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Arnaldo Carvalho de Melo wrote:
> --- linux-2.4.2/drivers/net/pcmcia/3c589_cs.c   Tue Feb 13 19:15:05 2001
> +++ linux-2.4.2.acme/drivers/net/pcmcia/3c589_cs.c      Mon Feb 26 22:44:00 2001
> @@ -992,9 +992,9 @@
>                         (pkt_len+3)>>2);
>                 skb->protocol = eth_type_trans(skb, dev);
> 
> +               lp->stats.rx_bytes += skb->len;
>                 netif_rx(skb);
>                 lp->stats.rx_packets++;
> -               lp->stats.rx_bytes += skb->len;

I prefer the attached patch instead.  It makes use of the existing local
'pkt_len', and it checks off another item that should probably be on the
janitor's todo list:  Set 'dev->last_rx=jiffies' immediately after
netif_rx.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------02D4E90087C9DB5CDB0296CB
Content-Type: text/plain; charset=us-ascii;
 name="3c589-cs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c589-cs.patch"

Index: drivers/net/pcmcia/3c589_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/3c589_cs.c,v
retrieving revision 1.1.1.10.18.1
diff -u -r1.1.1.10.18.1 3c589_cs.c
--- drivers/net/pcmcia/3c589_cs.c	2001/02/25 15:20:31	1.1.1.10.18.1
+++ drivers/net/pcmcia/3c589_cs.c	2001/02/27 01:54:28
@@ -993,8 +993,9 @@
 		skb->protocol = eth_type_trans(skb, dev);
 		
 		netif_rx(skb);
+		dev->last_rx = jiffies;
 		lp->stats.rx_packets++;
-		lp->stats.rx_bytes += skb->len;
+		lp->stats.rx_bytes += pkt_len;
 	    } else {
 		DEBUG(1, "%s: couldn't allocate a sk_buff of"
 		      " size %d.\n", dev->name, pkt_len);

--------------02D4E90087C9DB5CDB0296CB--

