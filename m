Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbUJ2VW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUJ2VW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUJ2VR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:17:59 -0400
Received: from inx.pm.waw.pl ([195.116.170.20]:33477 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263519AbUJ2VPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:15:06 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: net: generic netdev_ioaddr
References: <1099044244.9566.0.camel@localhost>
	<20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	<courier.418290EC.00002E85@courier.cs.helsinki.fi>
	<m3y8hpbaf9.fsf@defiant.pm.waw.pl>
	<20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 29 Oct 2004 23:13:24 +0200
In-Reply-To: <20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk> (Al
 Viro's message of "Fri, 29 Oct 2004 20:38:27 +0100")
Message-ID: <m3u0sdb53f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:

> What uses ->base_addr from the data returned by SIOCGIFMAP?

ifconfig I think:

eth0      Link encap:Ethernet  HWaddr 00:50:BA:70:68:3E  
          inet addr:10.0.0.2  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2796430 errors:1 dropped:0 overruns:0 frame:0
          TX packets:4056563 errors:3 dropped:0 overruns:0 carrier:3
          collisions:0 txqueuelen:1000 
          RX bytes:285233613 (272.0 Mb)  TX bytes:1252627624 (1194.5 Mb)
          Interrupt:10 Base address:0x4000 

With this driver it happens to be MMIO address.

I understand presenting this value to users might have some value:
it can help determine the physical port/card for a given netdev.
But it should be something like a description text set by the driver
(ie. containing PCI bus/device, or even ISA address for ISA non-PnP
card, possibly with other information).

It seems while some devices use SIOCGIFMAP (ie. by setting the fields
in netdev struct), support for SIOCSIFMAP doesn't make sense for most
hardware.

Drivers using SIOCSIFMAP (selecting media only?):
arch/cris/arch-v10/drivers/ethernet.c:    dev->set_config = e100_set_config;
drivers/net/au1000_eth.c:     dev->set_config = &au1000_set_config;
drivers/net/sis900.c: net_dev->set_config = &sis900_set_config;
drivers/net/arm/etherh.c:     dev->set_config         = etherh_set_config;
drivers/net/pcmcia/3c589_cs.c:    dev->set_config = &el3_config;
drivers/net/pcmcia/fmvj18x_cs.c:    dev->set_config = &fjn_config;
drivers/net/pcmcia/nmclan_cs.c:    dev->set_config = &mace_config;
drivers/net/pcmcia/pcnet_cs.c:    dev->set_config = &set_config;
drivers/net/pcmcia/smc91c92_cs.c:    dev->set_config = &s9k_config;
drivers/net/pcmcia/xirc2ps_cs.c:    dev->set_config = &do_config;
drivers/net/wan/sdla.c:       dev->set_config         = sdla_set_config;
drivers/net/wireless/ray_cs.c:    dev->set_config = &ray_dev_config;

I think I would mark this stuff obsolete, and remove when the drivers
are updated (if they need an update at all, they may support
ethtool/mii-tool already).
-- 
Krzysztof Halasa
