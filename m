Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266793AbRGFSte>; Fri, 6 Jul 2001 14:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGFStO>; Fri, 6 Jul 2001 14:49:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17024 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266793AbRGFStL>; Fri, 6 Jul 2001 14:49:11 -0400
Date: Fri, 6 Jul 2001 14:48:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, becker@scyld.com
Subject: Re: why this 1ms delay in mdio_read?  (cont'd from "are ioctl calls supposed  to take this long?")
In-Reply-To: <3B4602BA.91C5DAD3@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1010706143953.5031A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Chris Friesen wrote:

> The beginning of mdio_read() in tulip.c goes like this:
> 
> static int mdio_read(struct device *dev, int phy_id, int location)
> {
> 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
> 	int i;
> 	int read_cmd = (0xf6 << 10) | (phy_id << 5) | location;
> 	int retval = 0;
> 	long ioaddr = dev->base_addr;
> 	long mdio_addr = ioaddr + CSR9;
> 
> 	if (tp->chip_id == LC82C168) {
> 		int i = 1000;
> 		outl(0x60020000 + (phy_id<<23) + (location<<18), ioaddr + 0xA0);
> 		inl(ioaddr + 0xA0);
> 		inl(ioaddr + 0xA0);
> 		while (--i > 0)
> 			if ( ! ((retval = inl(ioaddr + 0xA0)) & 0x80000000))
> 				return retval & 0xffff;
> 		return 0xffff;
> 	}
> 
> 	if (tp->chip_id == COMET) {
> 		if (phy_id == 1) {
> 			if (location < 7)
> 				return inl(ioaddr + 0xB4 + (location<<2));
> 			else if (location == 17)
> 				return inl(ioaddr + 0xD0);
> 			else if (location >= 29 && location <= 31)
> 				return inl(ioaddr + 0xD4 + ((location-29)<<2));
> 		}
> 		return 0xffff;
> 	}
> 
> 	mdelay(1); /* One ms delay... */
> 
> 	...rest of code...
> 

What? What kernel version? 
The code here says:
     /* Establish sync by sending at least 32 logic ones */
     for (i = 32; i >=0; i--) {..........}

There is a mdio_delay() between each of the bit operations. This
is required to give time for the chip's internals to set up.

There is no mdelay in any of the code in .../linux/drivers/net/tulip/.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


