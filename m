Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129565AbRB0GQ5>; Tue, 27 Feb 2001 01:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRB0GQr>; Tue, 27 Feb 2001 01:16:47 -0500
Received: from mail.isis.co.za ([196.15.218.226]:63241 "EHLO mail.isis.co.za")
	by vger.kernel.org with ESMTP id <S129565AbRB0GQg>;
	Tue, 27 Feb 2001 01:16:36 -0500
Message-Id: <4.3.2.7.0.20010227081118.00aa1b80@192.168.0.18>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 27 Feb 2001 08:16:11 +0200
To: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
From: Pat Verner <pat@isis.co.za>
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear
  (Lite-On)
Cc: linux-kernel@vger.kernel.org, Alan@redhat.com
In-Reply-To: <3A9AC372.A86DC6C7@colorfullife.com>
In-Reply-To: <3A9A30C7.3C62E34@colorfullife.com>
 <3A9AB84C.A17D20AE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning all.

First thing this morning I applied Jeff's patch, as below.  Started off 
well, ran for about 20 minutes (and 40 MBytes) before hanging.

Reversed out Jeff's change and applied Manfred's patch to the same lines in 
pnic.c.  Ran for about 15 minutes (28 Mbytes) before hanging.  It is still 
early, and the network is still quiet, so the volume of data received is 
still low, but the hanging problem is unfortunately still there.

=Pat

At 09:58 PM 26/02/2001 +0100, Manfred Spraul wrote:
>Jeff Garzik wrote:
> > Pat, Manfred, in pnic_check_duplex, make this change:
> > > -        negotiated = mii_reg5 & tp->advertising[0];
> > > +        negotiated = mii_reg5 & tulip_mdio_read(dev, tp->phys[0], 4);
> >
>The changed fixed the problem.
>
> >
> > Manfred Spraul wrote:
> > >
> > > I think I found the bug:
> > >
> > > Someone (Jeff?) removed the line
> > >
> > >         tp->advertising[phy_idx++] = reg4;
> > >
> > > from tulip/tulip_core.c
> > >
> > > pnic_check_duplex uses that variable :-(
> > >
> > > There are 2 workarounds:
> > >
> > > * change pnic_check_duplex:
> > > s/tp->advertising[0]/tp->mii_advertise/g
> > >
> > > * remove the new mii_advertise variable and replace it with
> > > 'tp->advertising[i]'.
> >
> > mii_advertise is what MII is currently advertising on the current
> > media.  tp->advertising is per-phy, on the other hand.
> >
>
>Could you double check the code in tulip_core.c, around line 1450?
>IMHO it's bogus.
>
>1) if the network card contains multiple mii's, then the the advertised
>value of all mii's is changed to the advertised value of the first mii.
>
>2) the new driver starts with the current advertised value, the previous
>driver recalculated the value from mii_status
>
>[ mii_status = tulip_mdio_read(dev,phy,1); ]
>
>- reg4 = ((mii_status>>6)& tp->to_advertise) | 1;
>
>That could trigger 2 problems:
>* I tested with 'options=11', and the new driver announces '100baseT4'
>support, but the PHY doesn't support 100baseT4.
>* If the mii is incorrectly initialized, then a wrong advertised value
>is not corrected.
>
>--
>         Manfred

--
Pat Verner				E-Mail:  pat@isis.co.za
           Isis Information Systems (Pty) Ltd
           PO Box 281, Irene, 0062, South Africa
Phone: +27-12-667-1411	      	Fax: +27-12-667-3800

