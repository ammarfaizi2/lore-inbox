Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132641AbQLHUP0>; Fri, 8 Dec 2000 15:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132663AbQLHUPU>; Fri, 8 Dec 2000 15:15:20 -0500
Received: from cs.columbia.edu ([128.59.16.20]:42115 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S132641AbQLHUPH>;
	Fri, 8 Dec 2000 15:15:07 -0500
Date: Fri, 8 Dec 2000 11:44:34 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001206202313.A26438@saw.sw.com.sg>
Message-ID: <Pine.LNX.4.21.0012081130420.26353-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Andrey Savochkin wrote:

> > > The sympthomes are that the card triggers Flow Control Pause condition (and
> > > interrupt) on the last stages of the initialization or right after.
> > > And it happens with flow control being explicitly turned off.
> > > High network load considerably increase the chances of the event.
> > > After that the card stops to behave sane and reports status 0x7048.
> > 
> > Cool, I'll try to go over the driver init sequence by the end of the
> > weekend and let you know if I see anything wrong.
> 
> May be, there is a mandatory delay missing somewhere..

Or it may be something else. The manual states that one of the differences
between 82558 and 82559 is that the latter defaults to advertising its
flow-control capability through NWay, whereas the former does not. Both
*do* support flow-control, though.

> > Do you know if only one specific chip revision exhibits this problem? It
> > would really help track down the problem. If I remember correctly, 82557
> > doesn't have flow control at all, and 82558/9 have different 
> > implementations -- one is proprietary (82558) and one is standard (82559).
> 
> I personally have seen it with 82559ER only.
> But there have been some reports about 82559, too.

The fact that apparently only the people using 82559 chips are seeing this
seems to confirm my analysis above.

If you could try the attached patch (and maybe pass it onto the other
people who are experiencing this problem), that would be great.

There is some other problem I haven't yet tracked down: if an 82559 is set
to autonegotiate and it successfully gets 100FDX, detaching and then
re-attaching the cable leaves the switch believing that the connection is
100HDX -- which obviously doesn't work. I solved this problem in the BSDI
driver by monitoring the link status and forcing a renegotiation whenever
it comes back up, but there should be an easier way to do this.

BTW, you were right: rev 9 is an 82559ER A-step. They changed it
afterwards to have its own PCI id.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
--------------------------
--- linux-2.4/drivers/net/eepro100.c.old	Fri Dec  8 11:22:18 2000
+++ linux-2.4/drivers/net/eepro100.c	Fri Dec  8 11:29:28 2000
@@ -965,8 +965,12 @@
 	sp->flow_ctrl = sp->partner = 0;
 	sp->rx_mode = -1;			/* Invalid -> always reset the mode. */
 	set_rx_mode(dev);
-	if ((sp->phy[0] & 0x8000) == 0)
+	if ((sp->phy[0] & 0x8000) == 0) {
 		sp->advertising = mdio_read(ioaddr, sp->phy[0] & 0x1f, 4);
+		/* disable advertising the flow-control capability */
+		sp->advertising &= ~0x0400;
+		mdio_write(ioaddr, sp->phy[0] & 0x1f, sp->advertising);
+	}
 
 	if (speedo_debug > 2) {
 		printk(KERN_DEBUG "%s: Done speedo_open(), status %8.8x.\n",
@@ -1249,6 +1253,8 @@
 #else
 		mdio_read(ioaddr, phy_addr, 0);
 		mdio_write(ioaddr, phy_addr, 0, mii_bmcr);
+		/* disable advertising the flow control capability */
+		advertising &= ~0x0400;
 		mdio_write(ioaddr, phy_addr, 4, advertising);
 #endif
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
