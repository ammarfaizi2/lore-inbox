Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSFDQLH>; Tue, 4 Jun 2002 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFDQLG>; Tue, 4 Jun 2002 12:11:06 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:41954 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314514AbSFDQLE>; Tue, 4 Jun 2002 12:11:04 -0400
Date: Tue, 4 Jun 2002 17:42:35 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Gerald Teschl <gerald.teschl@univie.ac.at>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, <zwane@commfireservices.com>
Subject: Re: [PATCH] opl3sa2 isapnp activation fix
In-Reply-To: <3CFCE380.8070704@univie.ac.at>
Message-ID: <Pine.LNX.4.44.0206041737410.26634-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Gerald Teschl wrote:

> --- linux-2.4.18-4/drivers/sound/opl3sa2.c.orig    Thu May  2 23:36:45 2002
> +++ linux-2.4.18-4/drivers/sound/opl3sa2.c    Tue Jun  4 16:09:50 2002
> @@ -57,6 +57,7 @@
>   *                         (Jan 7, 2001)
>   * Zwane Mwaikambo       Added PM support. (Dec 4 2001)
>   * Zwane Mwaikambo       Code, data structure cleanups. (Feb 15 2002)
> + * Gerald Teschl       Fixed ISA PnP activate. (Jun 02 2002)
>   *
>   */
>  
> @@ -869,10 +870,24 @@
>      }
>      else {
>          if(dev->activate(dev) < 0) {
> -            printk(KERN_WARNING PFX "ISA PnP activate failed\n");
> -            opl3sa2_state[card].activated = 0;
> -            return -ENODEV;
> +            /*
> +             * isapnp.c disallows dma=0 but some opl3sa2 cards need it.
> +             * So we set dma by hand and try again
> +             */
> +            if (dma < 0 || dma > 7)
> +                dma= 0;
> +            if (dma2 < 0 || dma2 >7)
> +                dma2= 1;

Oops, that won't work on isapnp since dma = dma2 = -1 at this stage, how 
about;

if ((dma != -1) && (dma2 != -1)) frob();

you shouldn't hard set 0,1

> +            isapnp_resource_change(&dev->dma_resource[0], dma, 1);
> +            isapnp_resource_change(&dev->dma_resource[1], dma2, 1);
>          }
> +        if(!dev->active)
> +           if (dev->activate(dev) < 0) {
> +                printk(KERN_WARNING PFX "ISA PnP activate failed.\n");
> +                opl3sa2_state[card].activated = 0;
> +                return -ENODEV;
> +            }
> +        opl3sa2_state[card].activated = 1;
>  
>          printk(KERN_DEBUG
>                 PFX "Activated ISA PnP card %d (active=%d)\n",

The rest looks ok.

Cheers,
	Zwane
-- 
http://function.linuxpower.ca
		


