Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSKRNZP>; Mon, 18 Nov 2002 08:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSKRNZO>; Mon, 18 Nov 2002 08:25:14 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:34731 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262371AbSKRNZI>;
	Mon, 18 Nov 2002 08:25:08 -0500
Date: Mon, 18 Nov 2002 14:30:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [2.5 patch] fix compile breakage in drivers/input/gameport
Message-ID: <20021118143019.B15642@ucw.cz>
References: <20021118125710.GA11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021118125710.GA11952@fs.tum.de>; from bunk@fs.tum.de on Mon, Nov 18, 2002 at 01:57:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 01:57:10PM +0100, Adrian Bunk wrote:
> Hi Matthew,
> 
> could you check whether the patch below that does a name -> dev.name to
> fix the following compile errors is correct?

Looks Ok to me. Should I merge it in?

> 
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,drivers/input/gameport/.fm801-gp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fm801_gp -DKBUILD_MODNAME=fm801_gp   -c -o drivers/input/gameport/fm801-gp.o drivers/input/gameport/fm801-gp.c
> drivers/input/gameport/fm801-gp.c: In function `fm801_gp_probe':
> drivers/input/gameport/fm801-gp.c:119: structure has no member named `name'
> make[2]: *** [drivers/input/gameport/fm801-gp.o] Error 1
> ...
>   gcc -Wp,-MD,drivers/input/gameport/.ns558.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ns558 -DKBUILD_MODNAME=ns558
>    -c -o drivers/input/gameport/ns558.o drivers/input/gameport/ns558.c
> drivers/input/gameport/ns558.c: In function `ns558_pnp_probe':
> drivers/input/gameport/ns558.c:239: structure has no member named `name'
> drivers/input/gameport/ns558.c:239: structure has no member named `name'
> make[2]: *** [drivers/input/gameport/ns558.o] Error 1
> ...
>   gcc -Wp,-MD,drivers/input/gameport/.vortex.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vortex -DKBUILD_MODNAME=vor
> tex   -c -o drivers/input/gameport/vortex.o drivers/input/gameport/vortex.c
> drivers/input/gameport/vortex.c: In function `vortex_probe':
> drivers/input/gameport/vortex.c:130: structure has no member named `name'
> drivers/input/gameport/vortex.c:149: structure has no member named `name'
> make[2]: *** [drivers/input/gameport/vortex.o] Error 1
> 
> <--  snip  -->
> 
> 
> TIA
> Adrian
> 
> 
> --- linux-2.5.48/drivers/input/gameport/fm801-gp.c.old	2002-11-18 13:39:24.000000000 +0100
> +++ linux-2.5.48/drivers/input/gameport/fm801-gp.c	2002-11-18 13:46:45.000000000 +0100
> @@ -116,7 +116,7 @@
>  	gameport_register_port(&gp->gameport);
>  
>  	printk(KERN_INFO "gameport: %s at pci%s speed %d kHz\n",
> -		pci->name, pci->slot_name, gp->gameport.speed);
> +		pci->dev.name, pci->slot_name, gp->gameport.speed);
>  
>  	return 0;
>  }
> --- linux-2.5.48/drivers/input/gameport/ns558.c.old	2002-11-18 13:48:45.000000000 +0100
> +++ linux-2.5.48/drivers/input/gameport/ns558.c	2002-11-18 13:49:06.000000000 +0100
> @@ -236,7 +236,7 @@
>  	port->gameport.id.version = 0x100;
>  
>  	sprintf(port->phys, "isapnp%d.%d/gameport0", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> -	sprintf(port->name, "%s", dev->name[0] ? dev->name : "NS558 PnP Gameport");
> +	sprintf(port->name, "%s", dev->dev.name[0] ? dev->dev.name : "NS558 PnP Gameport");
>  
>  	gameport_register_port(&port->gameport);
>  
> --- linux-2.5.48/drivers/input/gameport/vortex.c.old	2002-11-18 13:51:06.000000000 +0100
> +++ linux-2.5.48/drivers/input/gameport/vortex.c	2002-11-18 13:51:25.000000000 +0100
> @@ -127,7 +127,7 @@
>  	vortex->gameport.cooked_read = vortex_cooked_read;
>  	vortex->gameport.open = vortex_open;
>  
> -	vortex->gameport.name = dev->name;
> +	vortex->gameport.name = dev->dev.name;
>  	vortex->gameport.phys = vortex->phys;
>  	vortex->gameport.id.bustype = BUS_PCI;
>  	vortex->gameport.id.vendor = dev->vendor;
> @@ -146,7 +146,7 @@
>  	gameport_register_port(&vortex->gameport);
>  	
>  	printk(KERN_INFO "gameport: %s at pci%s speed %d kHz\n",
> -		dev->name, dev->slot_name, vortex->gameport.speed);
> +		dev->dev.name, dev->slot_name, vortex->gameport.speed);
>  
>  	return 0;
>  }

-- 
Vojtech Pavlik
SuSE Labs
