Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWG0Ly3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWG0Ly3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWG0Ly2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:54:28 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:48652 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932551AbWG0Ly1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:54:27 -0400
Date: Thu, 27 Jul 2006 07:53:16 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] Create IP100A Driver
Message-ID: <20060727115316.GA8794@hmsreliant.homelinux.net>
References: <1154030065.5967.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154030065.5967.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:54:25PM -0400, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> This is the first version of IP100A Linux Driver.
> 
> Change Logs:
> 
> ---
> 
Thanks for the driver.  Comments in line

Regards
Neil

<snip>
> +MODULE_PARM_DESC(debug, "IC+ IP100A debug level (0-5)");
> +MODULE_PARM_DESC(rx_copybreak, "IC+ IP100A copy breakpoint for
> copy-only-tiny-frames");
> +MODULE_PARM_DESC(flowctrl, "IC+ IP100A flow control [0|1]");
> +
> +
> +#ifndef __KERNEL__
> +#define __KERNEL__
> +#endif

Do you really need this?  If __KERNEL__ isn't defined, something would seem to
be in my mind horribly wrong, and you would want to error out of the build,
rather than just trying to fix it up.

<snip>
> +
> +
> +static int netdev_open(struct net_device *dev)
> +{
> +       struct netdev_private *np = dev->priv;
> +       void __iomem * ioaddr = ipf_ioaddr(dev);
> +       int i;
> +
> +   for(i=0;i<10;i++)
> +   {
> +       if(np->ProbeDone==1)break;//For Mandrake10.x multi-cpu
> +       mdelay(1000);
> +   }

Indentation should be consistent.

<snip>
+
> +       /* On some architectures: explicitly flush cache lines here. */
> +       if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1
> +                       && !netif_queue_stopped(dev)) {
> +               /* do nothing */
> +       } else {
> +               netif_stop_queue (dev);
> +       }

Can you invert the logic of the if clause here to avoid having to have a do
nothing path?

<snip>
> +
> +#ifdef __i386__
> +       if (netif_msg_hw(np)) {
> +               printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
> +                          (int)(np->tx_ring_dma));
> +               for (i = 0; i < TX_RING_SIZE; i++)
> +                       printk(" #%d desc. %4.4x %8.8x %8.8x.\n",
> +                                  i, np->tx_ring[i].status,
> np->tx_ring[i].frag[0].addr,
> +                                  np->tx_ring[i].frag[0].length);
> +               printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
> +                          (int)(np->rx_ring_dma));
> +               for (i = 0; i < /*RX_RING_SIZE*/4 ; i++) {
> +                       printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x
> \n",
> +                                  i, np->rx_ring[i].status,
> np->rx_ring[i].frag[0].addr,
> +                                  np->rx_ring[i].frag[0].length);
> +               }
> +       }
> +#endif /* __i386__ debugging only */

If this is really for debugging on i386 only (which I don't think is actually
the case), you probably want to change the ifdef to be something more meaningful
like #ifdef DEBUG, or some such.


<snip>
> 0x0400);
> +       //mdio_write (dev, np->phys[0], MII_BMCR, BMCR_ANENABLE|
> BMCR_ANRESTART);//20040817Jesse_ChangeSpeed: Remove
> +       /* Force media type */
> +       if (!np->an_enable) {
> +               mii_ctl=(mdio_read(dev,np->phys[0],MII_BMCR)&0x0000ffff);
> +
> mii_avt=(mdio_read(dev,np->phys[0],MII_ADVERTISE)&~(ADVERTISE_100FULL
> +ADVERTISE_100HALF+ADVERTISE_10FULL+ADVERTISE_10HALF));
> +        if(np->speed==100)
> +               {
> +                  mii_avt|
> =(np->mii_if.full_duplex)?ADVERTISE_100FULL:ADVERTISE_100HALF;
> +               }
> +               else
> +               {
> +                  mii_avt|
> =(np->mii_if.full_duplex)?ADVERTISE_10FULL:ADVERTISE_10HALF;
> +               }
> +                mdio_write(dev,np->phys[0],MII_ADVERTISE,mii_avt);
> +                mdio_write(dev,np->phys[0],MII_BMCR,mii_ctl|0x1000|
> 0x200);
> +       }
> +       else
> +   {
> +       mdio_write (dev, np->phys[0], MII_BMCR, BMCR_ANENABLE|
> BMCR_ANRESTART);//20040817Jesse_ChangeSpeed: move to here
> +   }
> +   //20040817Jesse_ChangeSpeed: Add

Probably want to change all the comments to be C style, like the others in the
file


<snip>
> +       struct netdev_desc *last_tx;            /* Last Tx descriptor
> used. */
> +       UINT cur_tx, dirty_tx;
> +       /* These values are keep track of the transceiver/media in use.
> */
> +       UINT flowctrl:1;
> +       UINT default_port:4;            /* Last dev->if_port value. */
> +       UINT an_enable:1;
> +       UINT speed;
> +       struct tasklet_struct rx_tasklet;
> +       struct tasklet_struct tx_tasklet;
> +       INT budget;
> +       INT cur_task;
> +       /* Multicast and receive mode. */
> +       spinlock_t mcastlock;                   /* SMP lock multicast
> updates. */
> +       u16 mcast_filter[4];

You seem to have some extraneous data in your private structure.  Haven't
checked them all, but mcastlock and mcast_filter appear to be unused.  You
probably want to scrub this structure to only include things you are currently
using.

> +       /* MII transceiver section. */
> +       struct mutex       mii_mutex;
> +       struct mii_if_info mii_if;
> +
> +       INT mii_preamble_required;
> +       UCHAR phys[MII_CNT];            /* MII device address, only
> first one used.*/
> +       struct pci_dev *pci_dev;
> +       UCHAR pci_rev_id;
> +       UCHAR ProbeDone;


Definately need to use the kernel internal types, and may want to change
ProbeDone to be stylistically in line with the other variables in this struct
(i.e. probe_done).


-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
