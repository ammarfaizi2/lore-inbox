Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266786AbRGFS0U>; Fri, 6 Jul 2001 14:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266785AbRGFS0K>; Fri, 6 Jul 2001 14:26:10 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:25475
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S266784AbRGFSZ7>; Fri, 6 Jul 2001 14:25:59 -0400
Message-ID: <3B4602BA.91C5DAD3@nortelnetworks.com>
Date: Fri, 06 Jul 2001 14:26:02 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com, root@chaos.analogic.com
Subject: why this 1ms delay in mdio_read?  (cont'd from "are ioctl calls supposed 
 to take this long?")
In-Reply-To: <Pine.LNX.3.95.1010706112457.1472A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The beginning of mdio_read() in tulip.c goes like this:

static int mdio_read(struct device *dev, int phy_id, int location)
{
	struct tulip_private *tp = (struct tulip_private *)dev->priv;
	int i;
	int read_cmd = (0xf6 << 10) | (phy_id << 5) | location;
	int retval = 0;
	long ioaddr = dev->base_addr;
	long mdio_addr = ioaddr + CSR9;

	if (tp->chip_id == LC82C168) {
		int i = 1000;
		outl(0x60020000 + (phy_id<<23) + (location<<18), ioaddr + 0xA0);
		inl(ioaddr + 0xA0);
		inl(ioaddr + 0xA0);
		while (--i > 0)
			if ( ! ((retval = inl(ioaddr + 0xA0)) & 0x80000000))
				return retval & 0xffff;
		return 0xffff;
	}

	if (tp->chip_id == COMET) {
		if (phy_id == 1) {
			if (location < 7)
				return inl(ioaddr + 0xB4 + (location<<2));
			else if (location == 17)
				return inl(ioaddr + 0xD0);
			else if (location >= 29 && location <= 31)
				return inl(ioaddr + 0xD4 + ((location-29)<<2));
		}
		return 0xffff;
	}

	mdelay(1); /* One ms delay... */

	...rest of code...


The chip I'm using is the DEC 21143, which means that we skip over the two
conditional blocks, so the first thing that happens when we call this is to
wait around doing nothing for a millisecond.  Is there some subtle reason why we
would want to wait around for a millisecond before doing anything?

Thanks for your help,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
