Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTFMKnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTFMKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:43:25 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:30089 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265337AbTFMKnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:43:23 -0400
Date: Fri, 13 Jun 2003 12:55:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: tulip-users@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 21041 transmit timed out
In-Reply-To: <Pine.LNX.4.44.0305111148460.19415-100000@callisto>
Message-ID: <Pine.GSO.4.21.0306131251420.11546-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Geert Uytterhoeven wrote:
> On Sun, 20 Apr 2003, Geert Uytterhoeven wrote:
> > Under heavy network activity (e.g. downloading ISOs), my Tulip card (D-Link
> > DE-530+ with DECchip 21041) still goes down with 2.4.20.
> >
> > Suddenly I start getting messages of the form:
> > | NETDEV WATCHDOG: eth0: transmit timed out
> > | eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
> > | eth0: 21143 100baseTx sensed media.
> >
> > and the network no longer works. Sometimes it automatically recovers after a
> > while (without printing additional messages), but usually I need to do a manual
> > ifconfig down/up sequence to revive the network.

    [...]

> It still takes a few minutes to recover, but at least it recovers
> automatically, and within the TCP timeout limit, so no connections are lost.
> 
> I tested this by transfering several gigabytes across the network using netcat,
> and it always recovered without needing manual intervention.
> 
> So I suggest the following patch:
> 
> --- linux-2.4.20/drivers/net/tulip/tulip_core.c.orig	Tue Oct 29 18:41:48 2002
> +++ linux-2.4.20/drivers/net/tulip/tulip_core.c	Sun May 11 11:31:29 2003
> @@ -575,7 +575,7 @@
>  					dev->if_port = 2 - dev->if_port;
>  				} else
>  					dev->if_port = 0;
> -			else
> +			else if (dev->if_port != 0 || (csr12 & 0x0004) != 0)
>  				dev->if_port = 1;
>  			tulip_select_media(dev, 0);
>  		}
> 
> Any comments?

I can confirm that this patch fixed my problem. Sometimes transmission still
times out, but the driver recovers automatically within 3 minutes. The machine
has been up for more than one month.

Still no comments?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

