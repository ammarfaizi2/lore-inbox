Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbRGFPd6>; Fri, 6 Jul 2001 11:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266734AbRGFPdj>; Fri, 6 Jul 2001 11:33:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266726AbRGFPdd>; Fri, 6 Jul 2001 11:33:33 -0400
Date: Fri, 6 Jul 2001 11:32:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Friesen, Christopher [CAR:VS16:EXCH]" <cfriesen@americasm01.nt.com>,
        linux-kernel@vger.kernel.org
Subject: Re: are ioctl calls supposed to take this long?
In-Reply-To: <3B45D5DF.17D2B3F8@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1010706112457.1472A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Chris Friesen wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Fri, 6 Jul 2001, Chris Friesen wrote:
> > 
> > > I am using the following snippet of code to find out some information about the
> > > MII PHY interface of my ethernet device (which uses the tulip driver).  When I
> > > did some timing measurements with gettimeofday() I found that the ioctl call
> > > takes a bit over a millisecond to complete.  This seems to me to be an awfully
> > > long time for what should be (as far as I can see) a very simple operation.
> 
> > It's not ioctl() overhead, it's what has to be done in the driver to
> > get the information you request.
> > 
> > (1)     Stop the chip
> > (2)     Read the media interface using an awful SERIAL protocol in which
> >         you manipulate 3 bits using multiple instructions, to send
> >         or receive a single BIT (not BYTE) of data. You do the 8 times
> >         per byte.
> > (3)     Restart the chip.
> 
> Are you sure about this?  In the tulip.c driver the following appears to be the
> salient code:
> 
> static int private_ioctl(struct device *dev, struct ifreq *rq, int cmd)
> {
> 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
> 	long ioaddr = dev->base_addr;
> 	u16 *data = (u16 *)&rq->ifr_data;
> 	int phy = tp->phys[0] & 0x1f;
> 	long flags;
> 
> 	switch(cmd) {
> 	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
> 		if (tp->mii_cnt)
> 			data[0] = phy;
> 		else if (tp->flags & HAS_NWAY143)
> 			data[0] = 32;
> 		else if (tp->chip_id == COMET)
> 			data[0] = 1;
> 		else
> 			return -ENODEV;
>
               ..... This falls through to 
	SIOCDEVPRIVATE+1
 
> 
> I don't see any device stopping or reading of the media interface here.  Now
> there may be something very subtle hidden somewhere that I'm not seeing, but
> this looks like some relatively straightforward comparisons.

Look at tulip_mdio_read() and the zillions of times it's called.
It's called in SIOCDEVPRIVATE+1 when SIOCDEVPRIVATE falls through.
It falls through always, unless there is the -ENODEV error.
tulip_mdio_read() does the bit-banging junk.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


