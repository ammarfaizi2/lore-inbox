Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266724AbRGFPPQ>; Fri, 6 Jul 2001 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266726AbRGFPO4>; Fri, 6 Jul 2001 11:14:56 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:13187
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S266724AbRGFPOk>; Fri, 6 Jul 2001 11:14:40 -0400
Message-ID: <3B45D5DF.17D2B3F8@nortelnetworks.com>
Date: Fri, 06 Jul 2001 11:14:39 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "Friesen, Christopher [CAR:VS16:EXCH]" <cfriesen@americasm01.nt.com>,
        linux-kernel@vger.kernel.org
Subject: Re: are ioctl calls supposed to take this long?
In-Reply-To: <Pine.LNX.3.95.1010706103248.519B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 6 Jul 2001, Chris Friesen wrote:
> 
> > I am using the following snippet of code to find out some information about the
> > MII PHY interface of my ethernet device (which uses the tulip driver).  When I
> > did some timing measurements with gettimeofday() I found that the ioctl call
> > takes a bit over a millisecond to complete.  This seems to me to be an awfully
> > long time for what should be (as far as I can see) a very simple operation.

> It's not ioctl() overhead, it's what has to be done in the driver to
> get the information you request.
> 
> (1)     Stop the chip
> (2)     Read the media interface using an awful SERIAL protocol in which
>         you manipulate 3 bits using multiple instructions, to send
>         or receive a single BIT (not BYTE) of data. You do the 8 times
>         per byte.
> (3)     Restart the chip.

Are you sure about this?  In the tulip.c driver the following appears to be the
salient code:

static int private_ioctl(struct device *dev, struct ifreq *rq, int cmd)
{
	struct tulip_private *tp = (struct tulip_private *)dev->priv;
	long ioaddr = dev->base_addr;
	u16 *data = (u16 *)&rq->ifr_data;
	int phy = tp->phys[0] & 0x1f;
	long flags;

	switch(cmd) {
	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
		if (tp->mii_cnt)
			data[0] = phy;
		else if (tp->flags & HAS_NWAY143)
			data[0] = 32;
		else if (tp->chip_id == COMET)
			data[0] = 1;
		else
			return -ENODEV;


I don't see any device stopping or reading of the media interface here.  Now
there may be something very subtle hidden somewhere that I'm not seeing, but
this looks like some relatively straightforward comparisons.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
