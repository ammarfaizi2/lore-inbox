Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSJOPbF>; Tue, 15 Oct 2002 11:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264663AbSJOPbF>; Tue, 15 Oct 2002 11:31:05 -0400
Received: from smtp03.wxs.nl ([195.121.6.37]:23183 "EHLO smtp03.wxs.nl")
	by vger.kernel.org with ESMTP id <S264659AbSJOPac>;
	Tue, 15 Oct 2002 11:30:32 -0400
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
From: Thomas Hood <jdthood@yahoo.co.uk>
To: Adam Belay <ambx1@neo.rr.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       perex@suse.cz, boissiere@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20021014135452.GB444@neo.rr.com>
References: <20021014135452.GB444@neo.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Oct 2002 17:36:24 +0200
Message-Id: <1034696186.17943.255.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 15:54, Adam Belay wrote:
> Linux Plug and Play Rewrite V0.7

General:

   1. I would appreciate more carefully worded comments
   (or any comments, especially descriptions of interfaces
   to be used by other drivers)

   2. Please convert *all* initialisers to the new style.
   Not
          { tag: value, ... }
   but
          { .tag = value, ... }

In the configuration help:

> +  devices. You should then also say Y to all of the protocols below.
> +  Alternatively, you can say N here and configure your PnP devices
> +  using user space utilities such as the isapnptools package.
> +
> +  If unsure, say Y.

Can pnp support no longer be compiled as a module?

> +  system resources.  Say Y here if you want to reserve these resources.
> +  
> +  In most cases you should say Y.  If this is causing a conflict then
> +  say N.

What do you mean by "causing a conflict"?

> +  Some features (e.g. event notification, Docking station information,

"Docking" -> "docking"

For the device list ...

On my Thinkpad 600X, lspnp prints out: "PNP0680 mass storage device: IDE"

> +ID("PNP0802", "Microsoft Sound System or Compatible Device (obsolete)")

Why isn't this one in order?

> +ID("PNPcXXX", "Unkowwn Modem")

Typo.

Somewhere you might want to include these:
ID("IBM3780", "IBM pointing device")
ID("IBM0071", "IBM infrared communications device")
ID("IBM3760", "IBM DSP")
ID("CSC0000", "Crystal Semiconductor CS423x sound -- SB/WSS/OPL3 emulation")
ID("CSC0010", "Crystal Semiconductor CS423x sound -- control")
ID("CSC0001", "Crystal Semiconductor CS423x sound -- joystick")
ID("CSC0003", "Crystal Semiconductor CS423x sound -- MPU401")


> diff -ur --new-file --exclude *.flags a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
> --- a/drivers/pnp/pnpbios/core.c	Thu Jan  1 00:00:00 1970
> +++ b/drivers/pnp/pnpbios/core.c	Tue Oct  8 17:18:29 2002
> [...]
> +static void __init build_devlist(void)
> +{
> +	u8 nodenum;
> +	char id[7];
> +	unsigned char *pos;
> +	unsigned int nodes_got = 0;
> +	unsigned int devs = 0;
> +	struct pnp_bios_node *node;
> +	struct pnp_dev_node_info node_info;
> +	struct pnp_dev *dev;
> +	struct pnp_id *dev_id;
> +
> +	if (!pnp_bios_present())
> +		return;
> +
> +	if (pnp_bios_dev_node_info(&node_info) != 0)
> +		return;
> +
> +	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> +	if (!node)
> +		return;
> +
> +	for(nodenum=0; nodenum<0xff; ) {
> +		u8 thisnodenum = nodenum;
> +		/* We build the list from the "boot" config because
> +		 * asking for the "current" config causes some
> +		 * BIOSes to crash.
> +		 */
> +		if (pnp_bios_get_dev_node(&nodenum, (char )0 , node))
> +			break;
> +		nodes_got++;
> +		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
> +		if (!dev)
> +			break;
> +		memset(dev,0,sizeof(struct pnp_dev));
> +		dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
> +		if (!dev_id)
> +			break;
> +		memset(dev_id,0,sizeof(struct pnp_id));
> +		pnp_init_device(dev);
> +		dev->number = thisnodenum;
> +		memcpy(dev->name,"Unkown Device",13);
                                  ^^^^^^
Typo.  And is the length OK?

> +		pnpid32_to_pnpid(node->eisa_id,id);
> +		memcpy(dev_id->id,id,8);
> +		pnp_add_id(dev_id, dev);
> +		pos = node_current_resource_data_to_dev(node,dev);

