Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbRCVXja>; Thu, 22 Mar 2001 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbRCVXhm>; Thu, 22 Mar 2001 18:37:42 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:26621 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S132260AbRCVXhY>;
	Thu, 22 Mar 2001 18:37:24 -0500
Date: Thu, 22 Mar 2001 15:36:41 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Junfeng Yang <yjf@stanford.edu>
Subject: Re : [CHECKER] 28 potential interrupt errors
Message-ID: <20010322153641.B13162@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang wrote :
> Hi,
> 
> Here are yet more results from the MC project.  This checker looks for
> inconsistent usage of interrupt functions.
[...]
> ---------------------------------------------------------
> [BUG] error path
> 
> /u2/acc/oses/linux/2.4.1/drivers/net/irda/irport.c:943:irport_net_ioctl: ERROR:INTR:947:997: Interrupts inconsistent, severity `20':997
> 
>         /* Disable interrupts & save flags */
>         save_flags(flags);
> Start --->
>         cli();
> 
>         switch (cmd) {
>         case SIOCSBANDWIDTH: /* Set bandwidth */
>                 if (!capable(CAP_NET_ADMIN))
>                         return -EPERM;
>                 irda_task_execute(self, __irport_change_speed, NULL, NULL,
> 
>         ... DELETED 40 lines ...
> 
>         }
> 
>         restore_flags(flags);
> 
> Error --->
>         return ret;
> }
> 
> static struct net_device_stats *irport_net_get_stats(struct net_device *dev)
> {
> ---------------------------------------------------------

	I agree that the IrDA stack is full of irq/locking bugs (there
is a patch of mine waiting in Dag's mailbox), but this one is not a
bug, it's a false positive.
	The restore_flags(flags); will restore the state of the
interrupt register before the cli happened, so will automatically
reenable interrupts. The exact same code was used all over the kernel
before spinlock were introduced.

	So, if you see :
	        save_flags(flags);
	        cli();
		...
	        restore_flags(flags);
	It's correct (but a bit outdated).


> ---------------------------------------------------------
> [BUG] error path. this bug is interesting
> 
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:2561:wavelan_get_wireless_stats: ERROR:INTR:2528:2561: Interrupts inconsistent, severity `20':2561
> 
> 
>   /* Disable interrupts & save flags */
> Start --->
>   spin_lock_irqsave (&lp->lock, flags);
> 
>   if(lp == (net_local *) NULL)
>     return (iw_stats *) NULL;
>   wstats = &lp->wstats;
> 
>   /* Get data from the mmc */
> 
>         ... DELETED 23 lines ...
> 
> 
> #ifdef DEBUG_IOCTL_TRACE
>   printk(KERN_DEBUG "%s: <-wavelan_get_wireless_stats()\n", dev->name);
> #endif
> Error --->
>   return &lp->wstats;
> }
> #endif  /* WIRELESS_EXT */
> 
> ---------------------------------------------------------

	Didn't look into 2.4.1, but in 2.4.2 the irq_restore is just
above the printk, in the part that is "DELETED". It even has a nice
comments to that effect. Check the code by yourself.
	So, I guess it's another false positive and a bug in your
parser. That's why it's so "interesting" ;-)

	Good luck...

	Jean
