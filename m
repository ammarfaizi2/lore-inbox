Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292372AbSBPM2k>; Sat, 16 Feb 2002 07:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292373AbSBPM2a>; Sat, 16 Feb 2002 07:28:30 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:58304 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S292372AbSBPM2Y>;
	Sat, 16 Feb 2002 07:28:24 -0500
Date: Sat, 16 Feb 2002 13:28:03 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Rajasekhar Inguva <irajasek@in.ibm.com>
cc: <girouard@us.ibm.com>, <ctindel@ieee.org>, <willy@meta-x.org>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]:Ethernet Bonding Driver-2.4.17
In-Reply-To: <3C6E462D.39039598@in.ibm.com>
Message-ID: <Pine.GSO.4.30.0202161326260.4511-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Feb 2002, Rajasekhar Inguva wrote:

> Hi all,
>
> The patch is WRT a problem with the Ethernet Bonding Driver when
> compiled as a module. Tested on 2.4.17
> and the patch is also against 2.4.17.
>
> # insmod bonding max_bonds=2
> Using /lib/modules/2.4.17/kernel/drivers/net/bonding.o
> Warning: /lib/modules/2.4.17/kernel/drivers/net/bonding.o parameter
> max_bonds
> has max < min!
> /lib/modules/2.4.17/kernel/drivers/net/bonding.o: unknown parameter type
> '(' for
> max_bonds
>
> and the module fails to load.
>
> The problem seems to be with the way MODULE_PARM was written for
> max_bonds.
>
> MODULE_PARM(max_bonds,"1-" __MODULE_STRING(INT_MAX) "i");
>
> INT_MAX is defined to be ((int)(~0U>>1)) and 'insmod' gets the string
> "1-((int)(~0U>>1))i" which it is failing to understand.
>
> As max_bonds is an integer and not an array, i feel omitting the min-max
> range would be a better option.
>
> And if a negative or zero value is supplied to max_bonds while loading,
> it can be taken care of in bonding_init() by setting it back to
> MAX_BONDS.
>
> Thx,
> Rajasekhar Inguva
>
>
> --- /usr/src/linux/drivers/net/bonding.c	Fri Dec 21 23:11:54 2001
> +++ /usr/src/linux/drivers/fixed/bonding.c	Sat Feb 16 17:03:48 2002
> @@ -226,7 +226,7 @@
>  static struct bonding *these_bonds =  NULL;
>  static struct net_device *dev_bonds = NULL;
>
> -MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
> +MODULE_PARM(max_bonds,"i");
>  MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
>  MODULE_PARM(miimon, "i");
>  MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
> @@ -1981,6 +1981,10 @@
>
>  	/* Find a name for this unit */
>  	static struct net_device *dev_bond = NULL;
> +
> +	/* If max_bonds <=0, set it to MAX_BONDS */
> +	if(max_bonds <=0)
> +		max_bonds = MAX_BONDS;


Imho you would need a check for the upper limit too. like:
	if(max_bonds > MAX_BONDS)
		max_bonds = MAX_BONDS;


>
>  	dev_bond = dev_bonds = kmalloc(max_bonds*sizeof(struct net_device),
>  					GFP_KERNEL);

-- 
pozsy

