Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288622AbSAXB0H>; Wed, 23 Jan 2002 20:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289657AbSAXBZr>; Wed, 23 Jan 2002 20:25:47 -0500
Received: from adsl-64-123-56-106.dsl.stlsmo.swbell.net ([64.123.56.106]:3712
	"EHLO bigandy.naclos.org") by vger.kernel.org with ESMTP
	id <S288622AbSAXBZp>; Wed, 23 Jan 2002 20:25:45 -0500
Date: Wed, 23 Jan 2002 19:25:23 -0600 (CST)
From: Andy Carlson <naclos@swbell.net>
X-X-Sender: <naclos@bigandy.naclos.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Urban Widmark <urban@teststation.com>,
        Martin Eriksson <nitrax@giron.wox.org>,
        Justin A <justin@bouncybouncy.net>, <linux-kernel@vger.kernel.org>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: via-rhine timeouts
In-Reply-To: <3C4F20A5.F88EA471@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201231924410.269-100000@bigandy.naclos.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried this, and the problem did not go away.  I got about 300K/S
versus the 7-8M/S I get with the linuxfet driver.

Andy Carlson                                    |\      _,,,---,,_
naclos@swbell.net                         ZZZzz /,`.-'`'    -.  ;-;;,_
Cat Pics: http://andyc.dyndns.org/animal.html  |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                           '---''(_/--'  `-'\_)


On Wed, 23 Jan 2002, Andrew Morton wrote:

> Urban Widmark wrote:
> >
> >     writeb(readb(ioaddr + TxConfig) | 0x80, ioaddr + TxConfig);
> >     np->tx_thresh = 0x20;
> > (linuxfet.c)
> >
> >         writeb(0x20, ioaddr + TxConfig);
> >         np->tx_thresh = 0x20;
> > (via-rhine.c)
> >
> > Note how the linuxfet driver sets a higher value but does not make the
> > tx_thresh follow, so if it later gets a "IntrTxUnderrun" it will lower the
> > threshold. But the chosen value is probably large enough.
> >
> > Those of you with this problem could try changing the 0x80 to 0x20 in the
> > linuxfet.c driver and see if the problem returns (or the other way around
> > in the via-rhine.c driver).
> >
>
> That would certainly explain why people are seeing success
> with linuxfet.
>
> Here's the test patch which you describe.  It would be
> useful if people could try it..
>
> --- linux-2.4.18-pre6/drivers/net/via-rhine.c	Tue Jan 22 12:38:30 2002
> +++ linux-akpm/drivers/net/via-rhine.c	Wed Jan 23 12:42:18 2002
> @@ -965,7 +965,7 @@ static void init_registers(struct net_de
>  	/* Initialize other registers. */
>  	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
>  	/* Configure the FIFO thresholds. */
> -	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
> +	writeb(0x80, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
>  	np->tx_thresh = 0x20;
>  	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
>
> -
>

