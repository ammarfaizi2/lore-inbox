Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290074AbSAWUvI>; Wed, 23 Jan 2002 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290072AbSAWUu7>; Wed, 23 Jan 2002 15:50:59 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:28683 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290074AbSAWUuw>; Wed, 23 Jan 2002 15:50:52 -0500
Message-ID: <3C4F20A5.F88EA471@zip.com.au>
Date: Wed, 23 Jan 2002 12:44:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: Martin Eriksson <nitrax@giron.wox.org>, Justin A <justin@bouncybouncy.net>,
        Andy Carlson <naclos@swbell.net>, linux-kernel@vger.kernel.org,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: via-rhine timeouts
In-Reply-To: <004101c1a3f9$dea1bb90$0201a8c0@HOMER> <Pine.LNX.4.33.0201231255180.6354-100000@cola.teststation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
>     writeb(readb(ioaddr + TxConfig) | 0x80, ioaddr + TxConfig);
>     np->tx_thresh = 0x20;
> (linuxfet.c)
> 
>         writeb(0x20, ioaddr + TxConfig);
>         np->tx_thresh = 0x20;
> (via-rhine.c)
> 
> Note how the linuxfet driver sets a higher value but does not make the
> tx_thresh follow, so if it later gets a "IntrTxUnderrun" it will lower the
> threshold. But the chosen value is probably large enough.
> 
> Those of you with this problem could try changing the 0x80 to 0x20 in the
> linuxfet.c driver and see if the problem returns (or the other way around
> in the via-rhine.c driver).
> 

That would certainly explain why people are seeing success
with linuxfet.

Here's the test patch which you describe.  It would be
useful if people could try it..

--- linux-2.4.18-pre6/drivers/net/via-rhine.c	Tue Jan 22 12:38:30 2002
+++ linux-akpm/drivers/net/via-rhine.c	Wed Jan 23 12:42:18 2002
@@ -965,7 +965,7 @@ static void init_registers(struct net_de
 	/* Initialize other registers. */
 	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
 	/* Configure the FIFO thresholds. */
-	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
+	writeb(0x80, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
 	np->tx_thresh = 0x20;
 	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
 
-
