Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRBZU6s>; Mon, 26 Feb 2001 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBZU6i>; Mon, 26 Feb 2001 15:58:38 -0500
Received: from colorfullife.com ([216.156.138.34]:14352 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129091AbRBZU6Z>;
	Mon, 26 Feb 2001 15:58:25 -0500
Message-ID: <3A9AC372.A86DC6C7@colorfullife.com>
Date: Mon, 26 Feb 2001 21:58:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: pat@isis.co.za, linux-kernel@vger.kernel.org, Alan@redhat.com
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
In-Reply-To: <3A9A30C7.3C62E34@colorfullife.com> <3A9AB84C.A17D20AE@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pat, Manfred, in pnic_check_duplex, make this change:
> > -        negotiated = mii_reg5 & tp->advertising[0];
> > +        negotiated = mii_reg5 & tulip_mdio_read(dev, tp->phys[0], 4);
>
The changed fixed the problem.

> 
> Manfred Spraul wrote:
> >
> > I think I found the bug:
> >
> > Someone (Jeff?) removed the line
> >
> >         tp->advertising[phy_idx++] = reg4;
> >
> > from tulip/tulip_core.c
> >
> > pnic_check_duplex uses that variable :-(
> >
> > There are 2 workarounds:
> >
> > * change pnic_check_duplex:
> > s/tp->advertising[0]/tp->mii_advertise/g
> >
> > * remove the new mii_advertise variable and replace it with
> > 'tp->advertising[i]'.
> 
> mii_advertise is what MII is currently advertising on the current
> media.  tp->advertising is per-phy, on the other hand.
>

Could you double check the code in tulip_core.c, around line 1450?
IMHO it's bogus.

1) if the network card contains multiple mii's, then the the advertised
value of all mii's is changed to the advertised value of the first mii.

2) the new driver starts with the current advertised value, the previous
driver recalculated the value from mii_status

[ mii_status = tulip_mdio_read(dev,phy,1); ]

- reg4 = ((mii_status>>6)& tp->to_advertise) | 1;

That could trigger 2 problems:
* I tested with 'options=11', and the new driver announces '100baseT4'
support, but the PHY doesn't support 100baseT4.
* If the mii is incorrectly initialized, then a wrong advertised value
is not corrected.

--
	Manfred
