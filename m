Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264014AbTCXAPR>; Sun, 23 Mar 2003 19:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264015AbTCXAPR>; Sun, 23 Mar 2003 19:15:17 -0500
Received: from imspcml002.netvigator.com ([203.198.23.216]:10692 "EHLO
	imspcml002.netvigator.com") by vger.kernel.org with ESMTP
	id <S264014AbTCXAPN>; Sun, 23 Mar 2003 19:15:13 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "M.H.VanLeeuwen" <vanl@megsinet.net>
Subject: Re: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
Date: Mon, 24 Mar 2003 08:24:43 +0800
User-Agent: KMail/1.5
Cc: ambx1@neo.rr.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E7DE01B.2B6985DF@megsinet.net> <3E7E0A73.3D00B9CB@megsinet.net> <1048452010.10712.69.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1048452010.10712.69.camel@irongate.swansea.linux.org.uk>
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303240824.45391.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original 2.5.65. Put some printks in.

Two tries with service network start. Success on the second try.

Here are the messages

First try
Mar 24 08:01:16 mhfl1 network: Setting network parameters:  succeeded
Mar 24 08:01:17 mhfl1 ifup: Cannot find device "eth0"
Mar 24 08:01:18 mhfl1 network: Bringing up loopback interface:  succeeded
Mar 24 08:01:19 mhfl1 kernel: ne: ne_probe
Mar 24 08:01:19 mhfl1 kernel: ne: ne_probe_isapnp

It seems that pnp does not work the first try:

Mar 24 08:01:19 mhfl1 kernel: pnp: res: The PnP device '01:01.00' is already active.

Mar 24 08:01:19 mhfl1 kernel: ne.c: You must supply "io=0xNNN" value(s) for ISA cards.
Mar 24 08:01:19 mhfl1 ifup: ne device eth0 does not seem to be present, delaying initialization.
Mar 24 08:01:19 mhfl1 network: Bringing up interface eth0:  failed

Second try
Mar 24 08:01:20 mhfl1 network: Setting network parameters:  succeeded
Mar 24 08:01:21 mhfl1 ifup: Cannot find device "eth0"
Mar 24 08:01:22 mhfl1 network: Bringing up loopback interface:  succeeded
Mar 24 08:01:23 mhfl1 kernel: ne: ne_probe
Mar 24 08:01:23 mhfl1 kernel: ne: ne_probe_isapnp
Mar 24 08:01:23 mhfl1 kernel: ne.c: ISAPnP reports Generic PNP at i/o 0x2a0, irq 15.
Mar 24 08:01:23 mhfl1 kernel: ne: ne_probe1
Mar 24 08:01:23 mhfl1 kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Mar 24 08:01:23 mhfl1 kernel: Last modified Nov 1, 2000 by Paul Gortmaker
Mar 24 08:01:23 mhfl1 kernel: NE*000 ethercard probe at 0x2a0: 00 00 ff ff 27 ef
Mar 24 08:01:23 mhfl1 kernel: eth0: NE2000 found at 0x2a0, using IRQ 15.
Mar 24 08:01:23 mhfl1 kernel: ne: ne_probe_isapnp == 0
Mar 24 08:01:23 mhfl1 kernel: ne: ne_probe
Mar 24 08:01:23 mhfl1 kernel: ne: ne_probe_isapnp
Mar 24 08:01:26 mhfl1 network: Bringing up interface eth0:  succeeded

---------

ne_probe1 and ne_probe_isapnp have only a printk at their top

---------

int __init ne_probe(struct net_device *dev)
{
  unsigned int base_addr = dev->base_addr;

  printk("ne: ne_probe\n");
  SET_MODULE_OWNER(dev);

/* First check any supplied i/o locations. User knows best. <cough> */
  if (base_addr > 0x1ff)	/* Check a single specified location. */
    return ne_probe1(dev, base_addr);
  else if (base_addr != 0)	/* Don't probe at all. */
    return -ENXIO;

/* Then look for any installed ISAPnP clones */
  if (isapnp_present() == 0)
    printk("ne: no isapnp found\n");
  else if (ne_probe_isapnp(dev) == 0) {
    printk("ne: ne_probe_isapnp == 0\n");
    return 0;
  }

#ifndef MODULE
/* Last resort. The semi-risky ISA auto-probe. */
  for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
    int ioaddr = netcard_portlist[base_addr];
    if (ne_probe1(dev, ioaddr) == 0)
      return 0;
  }
#endif
  
  return -ENODEV;
}

--------


On Monday 24 March 2003 04:40, Alan Cox wrote:
> On Sun, 2003-03-23 at 19:26, M.H.VanLeeuwen wrote:
> > Here is the ordering of initcall from System.map file w/ my
> > change. I take it that you want isapnp_init after pci*_init
> > also, or is it sufficient like it is, after the acpi*_init?
>
> pci and pnpbios must come before isapnp as well. Otherwise IGP
> based systems will MCE on boot

