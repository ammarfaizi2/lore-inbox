Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287530AbSALVjG>; Sat, 12 Jan 2002 16:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287558AbSALVi7>; Sat, 12 Jan 2002 16:38:59 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:24583
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S287518AbSALViI>; Sat, 12 Jan 2002 16:38:08 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200201122111.g0CLBhK00442@www.hockin.org>
Subject: Re: [PATCH] Rx FIFO Overrun error found
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sat, 12 Jan 2002 13:11:43 -0800 (PST)
Cc: thockin@sun.com (Tim Hockin), linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com
In-Reply-To: <3C40A6F2.18A8C3E6@colorfullife.com> from "Manfred Spraul" at Jan 12, 2002 10:13:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if (dspcfg != DSPCFG_VAL) {
>  		if (!netif_queue_stopped(dev)) {
> +			spin_unlock_irq(&np->lock);
>  			printk(KERN_INFO 
>  				"%s: possible phy reset: re-initializing\n",
>  				dev->name);
>  			disable_irq(dev->irq);
>  			spin_lock_irq(&np->lock);
> +			natsemi_reset(dev);
> +			reinit_ring(dev);
>  			init_registers(dev);
>  			spin_unlock_irq(&np->lock);
>  			enable_irq(dev->irq);

I'm not sure you want or need a natsemi_reset here - I'll need to check my
notes on this when I get back to work.  Can I ask why this change was made?
This is a very hard case to reproduce, so I'm not very comfortable changing
the codepath :)  We've had National looking at this buggy behavior for
months now, with little result.

>  		/* enable the WOL interrupt.
>  		 * Could be used to send a netlink message.
>  		 */
> -		writel(readl(ioaddr + IntrMask) | WOLPkt, ioaddr + IntrMask);
> +		writel(WOLPkt, ioaddr + IntrMask);
> +		writel(1, ioaddr + IntrEnable);

is this intended to blow away the other bits in IntrMask?  Keep in mind
that Wake-On-Phy requires the PHY interrupt enabled, but I don't know if it
needs it on in intrmask or just in the Phy intr reg.

There are a few changes in here I want to double check, but all my
test-setup and notes for natsemi are at work - I may have more comments
next week.

Tim
