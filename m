Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSKVBXF>; Thu, 21 Nov 2002 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSKVBXE>; Thu, 21 Nov 2002 20:23:04 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:63480 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S264620AbSKVBXD>;
	Thu, 21 Nov 2002 20:23:03 -0500
Date: Thu, 21 Nov 2002 20:30:04 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Cafferkey <caffer@cs.ucc.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Setting MAC address in ewrk3 driver
Message-ID: <20021122013004.GA23061@www.kroptech.com>
References: <20021121195417.A18859@cuc.ucc.ie> <1037914095.9122.0.camel@irongate.swansea.linux.org.uk> <20021121233950.GB4654@www.kroptech.com> <1037924776.9122.7.camel@irongate.swansea.linux.org.uk> <3DDD7418.2010408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD7418.2010408@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 07:02:32PM -0500, Jeff Garzik wrote:
> Alan Cox wrote:
> 
> >On Thu, 2002-11-21 at 23:39, Adam Kropelin wrote:
> >
> >>Alan, could you clarify for me? I'm the last guy to diddle with ewrk3 so
> >>I'll track this down if there is indeed something to track down. ewrk3
> >>has a private ioctl for setting the mac address. By the "up" method do
> >>you mean the etherdev open method? Should there be a standard ioctl
> >>implemented for setting the mac address?
> >
> >
> >dev->set_mac_address()
> 
> To be more specific:
> 
> Read the MAC address in the probe phase.
> Write MAC address to NIC on _each_ dev->open().

Got it. Quick patch below. Works for me (TM). Against recent 2.5 but
should apply to 2.4 with offsets.

Neil, does this work for you?

> If you care about changing the MAC address while interface is up, 
> implement dev->set_mac_address().

Sounds like that is best avoided unless someone specifically needs it.
Even then it'll get implemented as a close/open sequence internally
anyway, so there's not much point.

--Adam

--- linux-2.5.47/drivers/net/ewrk3.c.orig	Thu Nov 21 20:24:00 2002
+++ linux-2.5.47/drivers/net/ewrk3.c	Thu Nov 21 20:22:24 2002
@@ -712,6 +712,7 @@
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
 	u_char csr, page;
 	u_long iobase = dev->base_addr;
+	int i;
 
 	/*
 	   ** Enable any multicasts
@@ -719,6 +720,13 @@
 	set_multicast_list(dev);
 
 	/*
+	** Set hardware MAC address. Address is initialized from the EEPROM
+	** during startup but may have since been changed by the user.
+	*/
+	for (i=0; i<ETH_ALEN; i++)
+		outb(dev->dev_addr[i], EWRK3_PAR0 + i);
+
+	/*
 	   ** Clean out any remaining entries in all the queues here
 	 */
 	while (inb(EWRK3_TQ));

