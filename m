Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290212AbSAWXmB>; Wed, 23 Jan 2002 18:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290215AbSAWXln>; Wed, 23 Jan 2002 18:41:43 -0500
Received: from h225-81.adirondack.albany.edu ([169.226.225.80]:56028 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S290214AbSAWXla>;
	Wed, 23 Jan 2002 18:41:30 -0500
Date: Wed, 23 Jan 2002 18:41:38 -0500
From: Justin A <justin@bouncybouncy.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Urban Widmark <urban@teststation.com>,
        Martin Eriksson <nitrax@giron.wox.org>,
        Andy Carlson <naclos@swbell.net>, linux-kernel@vger.kernel.org,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: via-rhine timeouts
Message-ID: <20020123234138.GA12264@bouncybouncy.net>
In-Reply-To: <004101c1a3f9$dea1bb90$0201a8c0@HOMER> <Pine.LNX.4.33.0201231255180.6354-100000@cola.teststation.com> <3C4F20A5.F88EA471@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C4F20A5.F88EA471@zip.com.au>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think thats the full problem, I just noticed I had been getting
errors too with the via driver, but it's been working fine otherwise:

(heres all of them, don't know what was going on at all the times, but I
was browsing the web for a bit at 9:50)

Jan 23 00:56:56 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 00:57:30 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 00:58:50 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 00:59:50 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 01:12:45 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 01:14:38 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 01:23:13 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 01:37:20 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 01:44:13 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 02:04:27 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 02:12:48 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 03:12:29 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 04:40:48 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 04:42:13 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 04:43:50 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 04:44:16 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 04:47:58 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 04:49:32 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 09:43:40 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 09:44:32 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 09:45:52 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 09:49:33 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 09:51:50 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
Jan 23 17:55:15 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.

the status makes sense from what I can tell, I could never figure out
what 782d was.
ifconfig reports:
TX packets:657170 errors:52 dropped:0 overruns:0 carrier:52

Is it possible that the problem is with the hub and via-rhine resetting
the card repetedly just makes it worse?

-Justin

On Wed, Jan 23, 2002 at 12:44:21PM -0800, Andrew Morton wrote:
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
