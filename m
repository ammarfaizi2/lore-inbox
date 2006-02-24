Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWBXC6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWBXC6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWBXC6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:58:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751821AbWBXC6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:58:09 -0500
Date: Thu, 23 Feb 2006 21:57:59 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Daniele Venzano <venza@brownhat.org>, Jeff Garzik <jgarzik@pobox.com>,
       jreiser@BitWagon.com
Subject: Re: [PATCH] Add Wake on LAN support to sis900 (2)
Message-ID: <20060224025759.GA14027@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniele Venzano <venza@brownhat.org>,
	Jeff Garzik <jgarzik@pobox.com>, jreiser@BitWagon.com
References: <200601050223.k052Ngu2003866@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601050223.k052Ngu2003866@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below applied on Jan 5th causes some systems to no longer boot.
See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=179601
for details.

Thanks go to John Reiser for his debugging with git bisect
to narrow this one down.

John got bitten by udev complaining about the kernel being
'too old', but I think that's just a side-effect. It's too
much of a coincidence for git to finger a SiS related patch,
and John's target system being SiS based.

		Dave



On Wed, Jan 04, 2006 at 06:23:42PM -0800, Linux Kernel wrote:
 > tree 93e543532a6c2959602d3d01384544c398b4f551
 > parent 7380a78a973a8109c13cb0e47617c456b6f6e1f5
 > author Daniele Venzano <venza@brownhat.org> Tue, 11 Oct 2005 09:44:30 +0200
 > committer Jeff Garzik <jgarzik@pobox.com> Sat, 29 Oct 2005 00:48:19 -0400
 > 
 > [PATCH] Add Wake on LAN support to sis900 (2)
 > 
 > Sorry, but that day I had smoked somthing too heavy for me, the patch
 > didn't apply. Here's a new one.
 > 
 > The patch availble below adds support for Wake on LAN to the sis900
 > driver. Some register addresses were added to sis900.h and two new
 > functions were implemented in sis900.c. WoL status is controlled by
 > ethtool.
 > Patch is against 2.6.13.
 > 
 > Comments are welcome, but also consider for inclusion in the -mm series.
 > 
 > Signed-off-by: Daniele Venzano <venza@brownhat.org>
 > 
 > --
 > Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
 > 
 >  drivers/net/sis900.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++--
 >  drivers/net/sis900.h |   45 +++++++++++++++++++++++++++++++
 >  2 files changed, 116 insertions(+), 2 deletions(-)
 > 
 > diff --git a/drivers/net/sis900.c b/drivers/net/sis900.c
 > index 1d4d886..3d95fa2 100644
 > --- a/drivers/net/sis900.c
 > +++ b/drivers/net/sis900.c
 > @@ -1,6 +1,6 @@
 >  /* sis900.c: A SiS 900/7016 PCI Fast Ethernet driver for Linux.
 >     Copyright 1999 Silicon Integrated System Corporation 
 > -   Revision:	1.08.08 Jan. 22 2005
 > +   Revision:	1.08.09 Sep. 19 2005
 >     
 >     Modified from the driver which is originally written by Donald Becker.
 >     
 > @@ -17,6 +17,7 @@
 >     SiS 7014 Single Chip 100BASE-TX/10BASE-T Physical Layer Solution,
 >     preliminary Rev. 1.0 Jan. 18, 1998
 >  
 > +   Rev 1.08.09 Sep. 19 2005 Daniele Venzano add Wake on LAN support
 >     Rev 1.08.08 Jan. 22 2005 Daniele Venzano use netif_msg for debugging messages
 >     Rev 1.08.07 Nov.  2 2003 Daniele Venzano <webvenza@libero.it> add suspend/resume support
 >     Rev 1.08.06 Sep. 24 2002 Mufasa Yang bug fix for Tx timeout & add SiS963 support
 > @@ -76,7 +77,7 @@
 >  #include "sis900.h"
 >  
 >  #define SIS900_MODULE_NAME "sis900"
 > -#define SIS900_DRV_VERSION "v1.08.08 Jan. 22 2005"
 > +#define SIS900_DRV_VERSION "v1.08.09 Sep. 19 2005"
 >  
 >  static char version[] __devinitdata =
 >  KERN_INFO "sis900.c: " SIS900_DRV_VERSION "\n";
 > @@ -538,6 +539,11 @@ static int __devinit sis900_probe(struct
 >  		printk("%2.2x:", (u8)net_dev->dev_addr[i]);
 >  	printk("%2.2x.\n", net_dev->dev_addr[i]);
 >  
 > +	/* Detect Wake on Lan support */
 > +	ret = inl(CFGPMC & PMESP);
 > +	if (netif_msg_probe(sis_priv) && (ret & PME_D3C) == 0)
 > +		printk(KERN_INFO "%s: Wake on LAN only available from suspend to RAM.", net_dev->name);
 > +
 >  	return 0;
 >  
 >   err_unmap_rx:
 > @@ -2015,6 +2021,67 @@ static int sis900_nway_reset(struct net_
 >  	return mii_nway_restart(&sis_priv->mii_info);
 >  }
 >  
 > +/**
 > + *	sis900_set_wol - Set up Wake on Lan registers
 > + *	@net_dev: the net device to probe
 > + *	@wol: container for info passed to the driver
 > + *
 > + *	Process ethtool command "wol" to setup wake on lan features.
 > + *	SiS900 supports sending WoL events if a correct packet is received,
 > + *	but there is no simple way to filter them to only a subset (broadcast,
 > + *	multicast, unicast or arp).
 > + */
 > + 
 > +static int sis900_set_wol(struct net_device *net_dev, struct ethtool_wolinfo *wol)
 > +{
 > +	struct sis900_private *sis_priv = net_dev->priv;
 > +	long pmctrl_addr = net_dev->base_addr + pmctrl;
 > +	u32 cfgpmcsr = 0, pmctrl_bits = 0;
 > +
 > +	if (wol->wolopts == 0) {
 > +		pci_read_config_dword(sis_priv->pci_dev, CFGPMCSR, &cfgpmcsr);
 > +		cfgpmcsr |= ~PME_EN;
 > +		pci_write_config_dword(sis_priv->pci_dev, CFGPMCSR, cfgpmcsr);
 > +		outl(pmctrl_bits, pmctrl_addr);
 > +		if (netif_msg_wol(sis_priv))
 > +			printk(KERN_DEBUG "%s: Wake on LAN disabled\n", net_dev->name);
 > +		return 0;
 > +	}
 > +
 > +	if (wol->wolopts & (WAKE_MAGICSECURE | WAKE_UCAST | WAKE_MCAST
 > +				| WAKE_BCAST | WAKE_ARP))
 > +		return -EINVAL;
 > +
 > +	if (wol->wolopts & WAKE_MAGIC)
 > +		pmctrl_bits |= MAGICPKT;
 > +	if (wol->wolopts & WAKE_PHY)
 > +		pmctrl_bits |= LINKON;
 > +	
 > +	outl(pmctrl_bits, pmctrl_addr);
 > +
 > +	pci_read_config_dword(sis_priv->pci_dev, CFGPMCSR, &cfgpmcsr);
 > +	cfgpmcsr |= PME_EN;
 > +	pci_write_config_dword(sis_priv->pci_dev, CFGPMCSR, cfgpmcsr);
 > +	if (netif_msg_wol(sis_priv))
 > +		printk(KERN_DEBUG "%s: Wake on LAN enabled\n", net_dev->name);
 > +
 > +	return 0;
 > +}
 > +
 > +static void sis900_get_wol(struct net_device *net_dev, struct ethtool_wolinfo *wol)
 > +{
 > +	long pmctrl_addr = net_dev->base_addr + pmctrl;
 > +	u32 pmctrl_bits;
 > +
 > +	pmctrl_bits = inl(pmctrl_addr);
 > +	if (pmctrl_bits & MAGICPKT)
 > +		wol->wolopts |= WAKE_MAGIC;
 > +	if (pmctrl_bits & LINKON)
 > +		wol->wolopts |= WAKE_PHY;
 > +
 > +	wol->supported = (WAKE_PHY | WAKE_MAGIC);
 > +}
 > +
 >  static struct ethtool_ops sis900_ethtool_ops = {
 >  	.get_drvinfo 	= sis900_get_drvinfo,
 >  	.get_msglevel	= sis900_get_msglevel,
 > @@ -2023,6 +2090,8 @@ static struct ethtool_ops sis900_ethtool
 >  	.get_settings	= sis900_get_settings,
 >  	.set_settings	= sis900_set_settings,
 >  	.nway_reset	= sis900_nway_reset,
 > +	.get_wol	= sis900_get_wol,
 > +	.set_wol	= sis900_set_wol
 >  };
 >  
 >  /**
 > diff --git a/drivers/net/sis900.h b/drivers/net/sis900.h
 > index de3c067..4233ea5 100644
 > --- a/drivers/net/sis900.h
 > +++ b/drivers/net/sis900.h
 > @@ -33,6 +33,7 @@ enum sis900_registers {
 >          rxcfg=0x34,             //Receive Configuration Register
 >          flctrl=0x38,            //Flow Control Register
 >          rxlen=0x3c,             //Receive Packet Length Register
 > +        cfgpmcsr=0x44,          //Configuration Power Management Control/Status Register
 >          rfcr=0x48,              //Receive Filter Control Register
 >          rfdr=0x4C,              //Receive Filter Data Register
 >          pmctrl=0xB0,            //Power Management Control Register
 > @@ -140,6 +141,50 @@ enum sis96x_eeprom_command {
 >  	EEREQ = 0x00000400, EEDONE = 0x00000200, EEGNT = 0x00000100
 >  };
 >  
 > +/* PCI Registers */
 > +enum sis900_pci_registers {
 > +	CFGPMC 	 = 0x40,
 > +	CFGPMCSR = 0x44
 > +};
 > +
 > +/* Power management capabilities bits */
 > +enum sis900_cfgpmc_register_bits {
 > +	PMVER	= 0x00070000, 
 > +	DSI	= 0x00100000,
 > +	PMESP	= 0xf8000000
 > +};
 > +
 > +enum sis900_pmesp_bits {
 > +	PME_D0 = 0x1,
 > +	PME_D1 = 0x2,
 > +	PME_D2 = 0x4,
 > +	PME_D3H = 0x8,
 > +	PME_D3C = 0x10
 > +};
 > +
 > +/* Power management control/status bits */
 > +enum sis900_cfgpmcsr_register_bits {
 > +	PMESTS = 0x00004000,
 > +	PME_EN = 0x00000100, // Power management enable
 > +	PWR_STA = 0x00000003 // Current power state
 > +};
 > +
 > +/* Wake-on-LAN support. */
 > +enum sis900_power_management_control_register_bits {
 > +	LINKLOSS  = 0x00000001,
 > +	LINKON    = 0x00000002,
 > +	MAGICPKT  = 0x00000400,
 > +	ALGORITHM = 0x00000800,
 > +	FRM1EN    = 0x00100000,
 > +	FRM2EN    = 0x00200000,
 > +	FRM3EN    = 0x00400000,
 > +	FRM1ACS   = 0x01000000,
 > +	FRM2ACS   = 0x02000000,
 > +	FRM3ACS   = 0x04000000,
 > +	WAKEALL   = 0x40000000,
 > +	GATECLK   = 0x80000000
 > +};
 > +
 >  /* Management Data I/O (mdio) frame */
 >  #define MIIread         0x6000
 >  #define MIIwrite        0x5002
 > -
 > To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
