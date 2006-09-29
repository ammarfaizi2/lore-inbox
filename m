Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161476AbWI2Hgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161476AbWI2Hgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbWI2Hgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:36:55 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:30186 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1161476AbWI2Hgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:36:53 -0400
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45121924.4000200@pobox.com>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
	 <1158051351.14448.97.camel@localhost.localdomain>
	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com>
	 <1158749825.7973.9.camel@localhost.localdomain>
	 <45121924.4000200@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1159515406.13634.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Sep 2006 15:36:46 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2006 07:36:49.0938 (UTC) FILETIME=[06741F20:01C6E39A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 12:46, Jeff Garzik wrote:
> Zang Roy-r61911 wrote:
> > +struct tsi108_prv_data {
> > +     void  __iomem *regs;    /* Base of normal regs */
> > +     void  __iomem *phyregs; /* Base of register bank used for PHY
> access */
> > +     
> > +     int phy;                /* Index of PHY for this interface */
> > +     int irq_num;
> > +     int id;
> > +
> > +     struct timer_list timer;/* Timer that triggers the check phy
> function */
> > +     int rxtail;             /* Next entry in rxring to read */
> > +     int rxhead;             /* Next entry in rxring to give a new
> buffer */
> > +     int rxfree;             /* Number of free, allocated RX
> buffers */
> > +
> > +     int rxpending;          /* Non-zero if there are still
> descriptors
> > +                              * to be processed from a previous
> descriptor
> > +                              * interrupt condition that has been
> cleared */
> > +
> > +     int txtail;             /* Next TX descriptor to check status
> on */
> > +     int txhead;             /* Next TX descriptor to use */
> 
> most of these should be unsigned, to prevent bugs.
> 
> 
> > +     /* Number of free TX descriptors.  This could be calculated
> from
> > +      * rxhead and rxtail if one descriptor were left unused to
> disambiguate
> > +      * full and empty conditions, but it's simpler to just keep
> track
> > +      * explicitly. */
> > +
> > +     int txfree;
> > +
> > +     int phy_ok;             /* The PHY is currently powered on. */
> > +
> > +     /* PHY status (duplex is 1 for half, 2 for full,
> > +      * so that the default 0 indicates that neither has
> > +      * yet been configured). */
> > +
> > +     int link_up;
> > +     int speed;
> > +     int duplex;
> > +
> > +     tx_desc *txring;
> > +     rx_desc *rxring;
> > +     struct sk_buff *txskbs[TSI108_TXRING_LEN];
> > +     struct sk_buff *rxskbs[TSI108_RXRING_LEN];
> > +
> > +     dma_addr_t txdma, rxdma;
> > +
> > +     /* txlock nests in misclock and phy_lock */
> > +
> > +     spinlock_t txlock, misclock;
> > +
> > +     /* stats is used to hold the upper bits of each hardware
> counter,
> > +      * and tmpstats is used to hold the full values for returning
> > +      * to the caller of get_stats().  They must be separate in
> case
> > +      * an overflow interrupt occurs before the stats are consumed.
> > +      */
> > +
> > +     struct net_device_stats stats;
> > +     struct net_device_stats tmpstats;
> > +
> > +     /* These stats are kept separate in hardware, thus require
> individual
> > +      * fields for handling carry.  They are combined in get_stats.
> > +      */
> > +
> > +     unsigned long rx_fcs;   /* Add to rx_frame_errors */
> > +     unsigned long rx_short_fcs;     /* Add to rx_frame_errors */
> > +     unsigned long rx_long_fcs;      /* Add to rx_frame_errors */
> > +     unsigned long rx_underruns;     /* Add to rx_length_errors */
> > +     unsigned long rx_overruns;      /* Add to rx_length_errors */
> > +
> > +     unsigned long tx_coll_abort;    /* Add to
> tx_aborted_errors/collisions */
> > +     unsigned long tx_pause_drop;    /* Add to tx_aborted_errors */
> > +
> > +     unsigned long mc_hash[16];
> > +};
> > +
> > +/* Structure for a device driver */
> > +
> > +static struct platform_driver tsi_eth_driver = {
> > +     .probe = tsi108_init_one,
> > +     .remove = tsi108_ether_remove,
> > +     .driver = {
> > +             .name = "tsi-ethernet",
> > +     },
> > +};
> > +
> > +static void tsi108_timed_checker(unsigned long dev_ptr);
> > +
> > +static void dump_eth_one(struct net_device *dev)
> > +{
> > +     struct tsi108_prv_data *data = netdev_priv(dev);
> > +
> > +     printk("Dumping %s...\n", dev->name);
> > +     printk("intstat %x intmask %x phy_ok %d"
> > +            " link %d speed %d duplex %d\n",
> > +            TSI108_ETH_READ_REG(TSI108_EC_INTSTAT),
> > +            TSI108_ETH_READ_REG(TSI108_EC_INTMASK), data->phy_ok,
> > +            data->link_up, data->speed, data->duplex);
> > +
> > +     printk("TX: head %d, tail %d, free %d, stat %x, estat %x, err
> %x\n",
> > +            data->txhead, data->txtail, data->txfree,
> > +            TSI108_ETH_READ_REG(TSI108_EC_TXSTAT),
> > +            TSI108_ETH_READ_REG(TSI108_EC_TXESTAT),
> > +            TSI108_ETH_READ_REG(TSI108_EC_TXERR));
> > +
> > +     printk("RX: head %d, tail %d, free %d, stat %x,"
> > +            " estat %x, err %x, pending %d\n\n",
> > +            data->rxhead, data->rxtail, data->rxfree,
> > +            TSI108_ETH_READ_REG(TSI108_EC_RXSTAT),
> > +            TSI108_ETH_READ_REG(TSI108_EC_RXESTAT),
> > +            TSI108_ETH_READ_REG(TSI108_EC_RXERR), data->rxpending);
> > +}
> > +
> > +/* Synchronization is needed between the thread and up/down events.
> > + * Note that the PHY is accessed through the same registers for
> both
> > + * interfaces, so this can't be made interface-specific.
> > + */
> > +
> > +static DEFINE_SPINLOCK(phy_lock);
> 
> you should have a chip structure, that contains two structs (one for 
> each interface/port)
> 
> 
Could you interpret the chip structure in more detail?
Need I create two net_device struct for each port?
Thanks.
Roy

