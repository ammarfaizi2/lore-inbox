Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSFCXA4>; Mon, 3 Jun 2002 19:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSFCXAz>; Mon, 3 Jun 2002 19:00:55 -0400
Received: from [63.204.6.12] ([63.204.6.12]:21162 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S315720AbSFCXAz>;
	Mon, 3 Jun 2002 19:00:55 -0400
Date: Mon, 3 Jun 2002 19:00:53 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Lightweight patch manager <patch@luckynet.dynu.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [PATCH][2.5] Port opl3sa2 changes from 2.4
In-Reply-To: <Pine.LNX.4.44.0206031628050.11309-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.33.0206031846520.5598-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Lightweight patch manager wrote:

> opl3sa2 didn't accept dma=0 in 2.4 due to isapnp
>
> In a recent thread [1], someone described problems with opl3sa2 on
> Linux-2.4 when dma 0 was used, since isapnp didn't support dma 0. If it's
> necessary to patch this in Linux-2.5 either, please apply this one.
>
> [1] <URL:http://marc.theaimsgroup.com/?l=linux-kernel&m=102310599324992&w=2>

I think it would be better to wait until Zwane sends something to Alan
and/or Marcelo, as this patch is incorrect on a couple of levels.  See my
annotations below:

> --- linus-2.5/sound/oss/opl3sa2.c	Mon Jun  3 06:32:51 2002
> +++ thunder-2.5.20/sound/oss/opl3sa2.c	Mon Jun  3 16:26:38 2002
> @@ -874,8 +874,18 @@
>  		opl3sa2_activated[card] = 1;
>  	}
>  	else {
> +		/*
> +		 * isapnp.c disallows dma=0, but the opl3sa2 card itself
> +		 * accepts this value perfectly.
> +		 */
> +		if (dev->ro) {

This is wrong, it was:

+               if (!dev->ro) {

in Gerald's original patch, and that actually made sense.

> +			isapnp_resource_change(&dev->dma_resource[0], 0, 1);
> +			isapnp_resource_change(&dev->dma_resource[1], 1, 1);
> +		}
> +		opl3sa2_state[card].activated = 1;

This line should really be below the following if statement, as I believe
Zwane mentioned to Gerald.

> +
>  		if(dev->activate(dev) < 0) {
> -			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed\n");
> +			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed!\n");
>  			opl3sa2_activated[card] = 0;
>  			return -ENODEV;
>  		}

I think always blindly remapping the the DMA channels to 0 and 1 is a bad
idea and will likely break things for some people.  It would be better if
the core isapnp code could be made smarter, but a simple alternative would
be to rework the opl3sa2 module parameter parsing to allow using the DMA
parameters as an override when using PnP.

Scott

PS: Zwane, any chance you want to update MAINTAINERS to "officially" take
    over opl3sa2?


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com



