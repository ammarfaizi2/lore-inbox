Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269599AbUHZUx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269599AbUHZUx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269642AbUHZUvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:51:16 -0400
Received: from gobio2.net ([82.225.138.2]:40642 "EHLO gobio.gobio2.net")
	by vger.kernel.org with ESMTP id S269645AbUHZUq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:46:59 -0400
Subject: Re: Problem with SiS900 - Unknown PHY
From: Laurent <laurent@gobio2.net>
To: linux-kernel@vger.kernel.org
Cc: webvenza@libero.it
In-Reply-To: <1093383367.11744.0.camel@caribou.gobio2.net>
References: <1093383367.11744.0.camel@caribou.gobio2.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 26 Aug 2004 22:47:28 +0200
Message-Id: <1093553248.5718.17.camel@caribou.gobio2.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93-3mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Because I was  a bit surprise that my problem was just with one easy
line in the driver, I did more investigations about this problem. 
With the two versions of the driver, it's the same PHY component which
is used by the driver. But, if the PHY type is marked as UNKNOWN, 
the driver send this command to it :

(from drivers/net/sis900 in sis900_default_phy() function)

mdio_write(net_dev, phy->phy_addr, MII_CONTROL,
				status | MII_CNTL_AUTO |MII_CNTL_ISOLATE);



According to the PHY documentation (which can be found at the following
page : http://www.national.com/pf/DP/DP83847.html), it sets the PHY in
auto-negotiation mode (which is quite normal) and in Isolate mode (which
I don't understand why) :

"When in the MII isolate mode, the DP83847 does not respond to packet
data present at TXD[3:0], TX_EN, and TX_ER inputs and presents a high
impedance on the TX_CLK, RX_CLK, RX_DV, RX_ER, RXD[3:0], COL, and CRS
outputs. The DP83847 will continue to respond to all management
transactions.

While in Isolate mode the TD+- outputs will not transmit packet data but
will continue to source 100BASE-TX scrambled idles or 10BASE-T normal
link pulses" 

Could someone give me a hint about this setting ?

Laurent

Le mardi 24 août 2004 à 23:36 +0200, Laurent a écrit :
> Some time ago, I sent on this list a mail about my strange problem with
> my SiS900 network card (Subject was Sluggish performances with FreeBSD)
> 
> To sum up, when my card is in 100Mb mode, I have poor throughput but in
> 10Mb, all seems normal.
> 
> After some tests, it seems these results was due to a misdetection of
> the PHY device. mii-tool reports :
>  product info: vendor 08:00:17, model 3 rev 0
> 
> and after some search on the web, I found it's a NS DP83847 which is
> very similar
> 
> Here is the patch :
> 
> --- linux/drivers/net/sis900.c.old      2004-08-24 20:51:43.865086208
> +0200
> +++ linux/drivers/net/sis900.c  2004-08-24 20:21:48.000000000 +0200
> @@ -124,6 +124,7 @@
>         { "AMD 79C901 HomePNA PHY",             0x0000, 0x6B90, HOME},
>         { "ICS LAN PHY",                        0x0015, 0xF440, LAN },
>         { "NS 83851 PHY",                       0x2000, 0x5C20, MIX },
> +       { "NS 83847 PHY",                       0x2000, 0x5C30, MIX },
>         { "Realtek RTL8201 PHY",                0x0000, 0x8200, LAN },
>         { "VIA 6103 PHY",                       0x0101, 0x8f20, LAN },
>         {NULL,},
> 
> Hope it can help some people
> 
> Laurent Goujon
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

