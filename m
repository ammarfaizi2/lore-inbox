Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWIUEqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWIUEqn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIUEqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:46:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5771 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750797AbWIUEqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:46:40 -0400
Message-ID: <45121924.4000200@pobox.com>
Date: Thu, 21 Sep 2006 00:46:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
CC: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>	 <1157962200.10526.10.camel@localhost.localdomain>	 <1158051351.14448.97.camel@localhost.localdomain>	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com> <1158749825.7973.9.camel@localhost.localdomain>
In-Reply-To: <1158749825.7973.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zang Roy-r61911 wrote:
> +struct tsi108_prv_data {
> +	void  __iomem *regs;	/* Base of normal regs */
> +	void  __iomem *phyregs;	/* Base of register bank used for PHY access */
> +	
> +	int phy;		/* Index of PHY for this interface */
> +	int irq_num;
> +	int id;
> +
> +	struct timer_list timer;/* Timer that triggers the check phy function */
> +	int rxtail;		/* Next entry in rxring to read */
> +	int rxhead;		/* Next entry in rxring to give a new buffer */
> +	int rxfree;		/* Number of free, allocated RX buffers */
> +
> +	int rxpending;		/* Non-zero if there are still descriptors
> +				 * to be processed from a previous descriptor
> +				 * interrupt condition that has been cleared */
> +
> +	int txtail;		/* Next TX descriptor to check status on */
> +	int txhead;		/* Next TX descriptor to use */

most of these should be unsigned, to prevent bugs.


> +	/* Number of free TX descriptors.  This could be calculated from
> +	 * rxhead and rxtail if one descriptor were left unused to disambiguate
> +	 * full and empty conditions, but it's simpler to just keep track
> +	 * explicitly. */
> +
> +	int txfree;
> +
> +	int phy_ok;		/* The PHY is currently powered on. */
> +
> +	/* PHY status (duplex is 1 for half, 2 for full,
> +	 * so that the default 0 indicates that neither has
> +	 * yet been configured). */
> +
> +	int link_up;
> +	int speed;
> +	int duplex;
> +
> +	tx_desc *txring;
> +	rx_desc *rxring;
> +	struct sk_buff *txskbs[TSI108_TXRING_LEN];
> +	struct sk_buff *rxskbs[TSI108_RXRING_LEN];
> +
> +	dma_addr_t txdma, rxdma;
> +
> +	/* txlock nests in misclock and phy_lock */
> +
> +	spinlock_t txlock, misclock;
> +
> +	/* stats is used to hold the upper bits of each hardware counter,
> +	 * and tmpstats is used to hold the full values for returning
> +	 * to the caller of get_stats().  They must be separate in case
> +	 * an overflow interrupt occurs before the stats are consumed.
> +	 */
> +
> +	struct net_device_stats stats;
> +	struct net_device_stats tmpstats;
> +
> +	/* These stats are kept separate in hardware, thus require individual
> +	 * fields for handling carry.  They are combined in get_stats.
> +	 */
> +
> +	unsigned long rx_fcs;	/* Add to rx_frame_errors */
> +	unsigned long rx_short_fcs;	/* Add to rx_frame_errors */
> +	unsigned long rx_long_fcs;	/* Add to rx_frame_errors */
> +	unsigned long rx_underruns;	/* Add to rx_length_errors */
> +	unsigned long rx_overruns;	/* Add to rx_length_errors */
> +
> +	unsigned long tx_coll_abort;	/* Add to tx_aborted_errors/collisions */
> +	unsigned long tx_pause_drop;	/* Add to tx_aborted_errors */
> +
> +	unsigned long mc_hash[16];
> +};
> +
> +/* Structure for a device driver */
> +
> +static struct platform_driver tsi_eth_driver = {
> +	.probe = tsi108_init_one,
> +	.remove = tsi108_ether_remove,
> +	.driver	= {
> +		.name = "tsi-ethernet",
> +	},
> +};
> +
> +static void tsi108_timed_checker(unsigned long dev_ptr);
> +
> +static void dump_eth_one(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	printk("Dumping %s...\n", dev->name);
> +	printk("intstat %x intmask %x phy_ok %d"
> +	       " link %d speed %d duplex %d\n",
> +	       TSI108_ETH_READ_REG(TSI108_EC_INTSTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_INTMASK), data->phy_ok,
> +	       data->link_up, data->speed, data->duplex);
> +
> +	printk("TX: head %d, tail %d, free %d, stat %x, estat %x, err %x\n",
> +	       data->txhead, data->txtail, data->txfree,
> +	       TSI108_ETH_READ_REG(TSI108_EC_TXSTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_TXESTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_TXERR));
> +
> +	printk("RX: head %d, tail %d, free %d, stat %x,"
> +	       " estat %x, err %x, pending %d\n\n",
> +	       data->rxhead, data->rxtail, data->rxfree,
> +	       TSI108_ETH_READ_REG(TSI108_EC_RXSTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_RXESTAT),
> +	       TSI108_ETH_READ_REG(TSI108_EC_RXERR), data->rxpending);
> +}
> +
> +/* Synchronization is needed between the thread and up/down events.
> + * Note that the PHY is accessed through the same registers for both
> + * interfaces, so this can't be made interface-specific.
> + */
> +
> +static DEFINE_SPINLOCK(phy_lock);

you should have a chip structure, that contains two structs (one for 
each interface/port)


> +static u16 tsi108_read_mii(struct tsi108_prv_data *data, int reg, int *status)
> +{
> +	int i;
> +	u16 ret;
> +
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_ADDR,
> +				(data->phy << TSI108_MAC_MII_ADDR_PHY) |
> +				(reg << TSI108_MAC_MII_ADDR_REG));
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_CMD, 0);
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_CMD, TSI108_MAC_MII_CMD_READ);
> +	for (i = 0; i < 100; i++) {
> +		if (!(TSI108_ETH_READ_PHYREG(TSI108_MAC_MII_IND) &
> +		      (TSI108_MAC_MII_IND_NOTVALID | TSI108_MAC_MII_IND_BUSY)))
> +			break;
> +		udelay(10);
> +	}
> +
> +	if (i == 100) {
> +		if (status)
> +			*status = -EBUSY;
> +
> +		ret = 0xffff;
> +	} else {
> +		if (status)
> +			*status = 0;
> +
> +		ret = TSI108_ETH_READ_PHYREG(TSI108_MAC_MII_DATAIN);
> +	}
> +
> +	return ret;
> +}
> +
> +static void tsi108_write_mii(struct tsi108_prv_data *data, 
> +				int reg, u16 val)
> +{
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_ADDR,
> +				(data->phy << TSI108_MAC_MII_ADDR_PHY) |
> +				(reg << TSI108_MAC_MII_ADDR_REG));
> +	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_DATAOUT, val);
> +	while (TSI108_ETH_READ_PHYREG(TSI108_MAC_MII_IND) &
> +	       TSI108_MAC_MII_IND_BUSY)
> +		cpu_relax();

NAK, potential infinite loop if there is a hardware fault or other 
highly exceptional event

it should time out after a reasonable period of time.


> +static inline void tsi108_write_tbi(struct tsi108_prv_data *data,
> +					int reg, u16 val)
> +{
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_ADDR,
> +			     (0x1e << TSI108_MAC_MII_ADDR_PHY)
> +			     | (reg << TSI108_MAC_MII_ADDR_REG));
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_DATAOUT, val);
> +	while (TSI108_ETH_READ_REG(TSI108_MAC_MII_IND) &
> +	       TSI108_MAC_MII_IND_BUSY)
> +		cpu_relax();

ditto


> +static void tsi108_check_phy(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u16 sumstat;
> +	u32 mac_cfg2_reg, portctrl_reg;
> +	u32 fdx_flag = 0, reg_update = 0;
> +
> +	/* Do a dummy read, as for some reason the first read
> +	 * after a link becomes up returns link down, even if
> +	 * it's been a while since the link came up.
> +	 */
> +
> +	spin_lock(&phy_lock);
> +
> +	if (!data->phy_ok)
> +		goto out;
> +
> +	tsi108_read_mii(data, PHY_STAT, NULL);
> +
> +	if (!(tsi108_read_mii(data, PHY_STAT, NULL) & PHY_STAT_LINKUP)) {

you should use mii.h constants rather than invent your own PHY_xxx



> +		if (data->link_up == 1) {
> +			netif_stop_queue(dev);
> +			data->link_up = 0;
> +			printk(KERN_NOTICE "%s : link is down\n", dev->name);
> +			netif_carrier_off(dev);

this looks suspiciously similar to mii_check_media() in drivers/net/mii.c


> +		goto out;
> +	}
> +
> +	mac_cfg2_reg = TSI108_ETH_READ_REG(TSI108_MAC_CFG2);
> +	portctrl_reg = TSI108_ETH_READ_REG(TSI108_EC_PORTCTRL);
> +
> +	sumstat = tsi108_read_mii(data, PHY_SUM_STAT, NULL);
> +
> +	switch (sumstat & PHY_SUM_STAT_SPEED_MASK) {
> +	case PHY_SUM_STAT_1000T_FD:
> +		fdx_flag++;
> +	case PHY_SUM_STAT_1000T_HD:
> +		if (data->speed != 1000) {
> +			mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
> +			mac_cfg2_reg |= TSI108_MAC_CFG2_GIG;
> +			portctrl_reg &= ~TSI108_EC_PORTCTRL_NOGIG;
> +			data->speed = 1000;
> +			reg_update++;
> +		}
> +		break;
> +	case PHY_SUM_STAT_100TX_FD:
> +		fdx_flag++;
> +	case PHY_SUM_STAT_100TX_HD:
> +		if (data->speed != 100) {
> +			mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
> +			mac_cfg2_reg |= TSI108_MAC_CFG2_NOGIG;
> +			portctrl_reg |= TSI108_EC_PORTCTRL_NOGIG;
> +			data->speed = 100;
> +			reg_update++;
> +		}
> +		break;
> +
> +	case PHY_SUM_STAT_10T_FD:
> +		fdx_flag++;
> +	case PHY_SUM_STAT_10T_HD:
> +		if (data->speed != 10) {
> +			mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
> +			mac_cfg2_reg |= TSI108_MAC_CFG2_NOGIG;
> +			portctrl_reg |= TSI108_EC_PORTCTRL_NOGIG;
> +			data->speed = 10;
> +			reg_update++;
> +		}
> +		break;
> +
> +	default:
> +		if (net_ratelimit())
> +			printk(KERN_ERR "PHY reported invalid speed,"
> +			       KERN_ERR " summary status %x\n",
> +			       sumstat);
> +		goto out;
> +	}
> +
> +	if (fdx_flag || (sumstat & PHY_SUM_STAT_FULLDUPLEX)) {
> +		if (data->duplex != 2) {
> +			mac_cfg2_reg |= TSI108_MAC_CFG2_FULLDUPLEX;
> +			portctrl_reg &= ~TSI108_EC_PORTCTRL_HALFDUPLEX;
> +			data->duplex = 2;
> +			reg_update++;
> +		}
> +	} else {
> +		if (data->duplex != 1) {
> +			mac_cfg2_reg &= ~TSI108_MAC_CFG2_FULLDUPLEX;
> +			portctrl_reg |= TSI108_EC_PORTCTRL_HALFDUPLEX;
> +			data->duplex = 1;
> +			reg_update++;
> +		}
> +	}
> +
> +	if (reg_update) {
> +		TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, mac_cfg2_reg);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, portctrl_reg);
> +		
> +	}
> +
> +	if (data->link_up == 0) {
> +		/* The manual says it can take 3-4 usecs for the speed change
> +		 * to take effect.
> +		 */
> +		udelay(5);
> +
> +		spin_lock(&data->txlock);
> +		if (netif_queue_stopped(dev)
> +		    && is_valid_ether_addr(dev->dev_addr) && data->txfree)
> +			netif_wake_queue(dev);
> +
> +		data->link_up = 1;
> +		spin_unlock(&data->txlock);
> +		printk("%s : link is up: %dMb %s-duplex\n",
> +		       dev->name, data->speed,
> +		       (data->duplex == 2) ? "full" : "half");
> +		netif_carrier_on(dev);
> +	}
> +
> +      out:
> +	spin_unlock(&phy_lock);
> +}
> +
> +static inline void
> +tsi108_stat_carry_one(int carry, int carry_bit, int carry_shift,
> +		      unsigned long *upper)
> +{
> +	if (carry & carry_bit)
> +		*upper += carry_shift;
> +}
> +
> +static void tsi108_stat_carry(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 carry1, carry2;
> +
> +	spin_lock_irq(&data->misclock);
> +
> +	carry1 = TSI108_ETH_READ_REG(TSI108_STAT_CARRY1);
> +	carry2 = TSI108_ETH_READ_REG(TSI108_STAT_CARRY2);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRY1, carry1);
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRY2, carry2);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXBYTES,
> +			      TSI108_STAT_RXBYTES_CARRY, &data->stats.rx_bytes);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXPKTS,
> +			      TSI108_STAT_RXPKTS_CARRY,
> +			      &data->stats.rx_packets);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXFCS,
> +			      TSI108_STAT_RXFCS_CARRY, &data->rx_fcs);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXMCAST,
> +			      TSI108_STAT_RXMCAST_CARRY,
> +			      &data->stats.multicast);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXALIGN,
> +			      TSI108_STAT_RXALIGN_CARRY,
> +			      &data->stats.rx_frame_errors);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXLENGTH,
> +			      TSI108_STAT_RXLENGTH_CARRY,
> +			      &data->stats.rx_length_errors);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXRUNT,
> +			      TSI108_STAT_RXRUNT_CARRY, &data->rx_underruns);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXJUMBO,
> +			      TSI108_STAT_RXJUMBO_CARRY, &data->rx_overruns);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXFRAG,
> +			      TSI108_STAT_RXFRAG_CARRY, &data->rx_short_fcs);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXJABBER,
> +			      TSI108_STAT_RXJABBER_CARRY, &data->rx_long_fcs);
> +
> +	tsi108_stat_carry_one(carry1, TSI108_STAT_CARRY1_RXDROP,
> +			      TSI108_STAT_RXDROP_CARRY,
> +			      &data->stats.rx_missed_errors);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXBYTES,
> +			      TSI108_STAT_TXBYTES_CARRY, &data->stats.tx_bytes);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXPKTS,
> +			      TSI108_STAT_TXPKTS_CARRY,
> +			      &data->stats.tx_packets);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXEXDEF,
> +			      TSI108_STAT_TXEXDEF_CARRY,
> +			      &data->stats.tx_aborted_errors);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXEXCOL,
> +			      TSI108_STAT_TXEXCOL_CARRY, &data->tx_coll_abort);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXTCOL,
> +			      TSI108_STAT_TXTCOL_CARRY,
> +			      &data->stats.collisions);
> +
> +	tsi108_stat_carry_one(carry2, TSI108_STAT_CARRY2_TXPAUSE,
> +			      TSI108_STAT_TXPAUSEDROP_CARRY,
> +			      &data->tx_pause_drop);
> +
> +	spin_unlock_irq(&data->misclock);
> +}
> +
> +/* Read a stat counter atomically with respect to carries.
> + * data->misclock must be held.
> + */
> +static inline unsigned long
> +tsi108_read_stat(struct tsi108_prv_data * data, int reg, int carry_bit,
> +		 int carry_shift, unsigned long *upper)
> +{
> +	int carryreg;
> +	unsigned long val;
> +
> +	if (reg < 0xb0)
> +		carryreg = TSI108_STAT_CARRY1;
> +	else
> +		carryreg = TSI108_STAT_CARRY2;
> +
> +      again:
> +	val = TSI108_ETH_READ_REG(reg) | *upper;
> +
> +	/* Check to see if it overflowed, but the interrupt hasn't
> +	 * been serviced yet.  If so, handle the carry here, and
> +	 * try again.
> +	 */
> +
> +	if (unlikely(TSI108_ETH_READ_REG(carryreg) & carry_bit)) {
> +		*upper += carry_shift;
> +		TSI108_ETH_WRITE_REG(carryreg, carry_bit);
> +		goto again;
> +	}
> +
> +	return val;
> +}
> +
> +static struct net_device_stats *tsi108_get_stats(struct net_device *dev)
> +{
> +	unsigned long excol;
> +
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	spin_lock_irq(&data->misclock);
> +
> +	data->tmpstats.rx_packets =
> +	    tsi108_read_stat(data, TSI108_STAT_RXPKTS,
> +			     TSI108_STAT_CARRY1_RXPKTS,
> +			     TSI108_STAT_RXPKTS_CARRY, &data->stats.rx_packets);
> +
> +	data->tmpstats.tx_packets =
> +	    tsi108_read_stat(data, TSI108_STAT_TXPKTS,
> +			     TSI108_STAT_CARRY2_TXPKTS,
> +			     TSI108_STAT_TXPKTS_CARRY, &data->stats.tx_packets);
> +
> +	data->tmpstats.rx_bytes =
> +	    tsi108_read_stat(data, TSI108_STAT_RXBYTES,
> +			     TSI108_STAT_CARRY1_RXBYTES,
> +			     TSI108_STAT_RXBYTES_CARRY, &data->stats.rx_bytes);
> +
> +	data->tmpstats.tx_bytes =
> +	    tsi108_read_stat(data, TSI108_STAT_TXBYTES,
> +			     TSI108_STAT_CARRY2_TXBYTES,
> +			     TSI108_STAT_TXBYTES_CARRY, &data->stats.tx_bytes);
> +
> +	data->tmpstats.multicast =
> +	    tsi108_read_stat(data, TSI108_STAT_RXMCAST,
> +			     TSI108_STAT_CARRY1_RXMCAST,
> +			     TSI108_STAT_RXMCAST_CARRY, &data->stats.multicast);
> +
> +	excol = tsi108_read_stat(data, TSI108_STAT_TXEXCOL,
> +				 TSI108_STAT_CARRY2_TXEXCOL,
> +				 TSI108_STAT_TXEXCOL_CARRY,
> +				 &data->tx_coll_abort);
> +
> +	data->tmpstats.collisions =
> +	    tsi108_read_stat(data, TSI108_STAT_TXTCOL,
> +			     TSI108_STAT_CARRY2_TXTCOL,
> +			     TSI108_STAT_TXTCOL_CARRY, &data->stats.collisions);
> +
> +	data->tmpstats.collisions += excol;
> +
> +	data->tmpstats.rx_length_errors =
> +	    tsi108_read_stat(data, TSI108_STAT_RXLENGTH,
> +			     TSI108_STAT_CARRY1_RXLENGTH,
> +			     TSI108_STAT_RXLENGTH_CARRY,
> +			     &data->stats.rx_length_errors);
> +
> +	data->tmpstats.rx_length_errors +=
> +	    tsi108_read_stat(data, TSI108_STAT_RXRUNT,
> +			     TSI108_STAT_CARRY1_RXRUNT,
> +			     TSI108_STAT_RXRUNT_CARRY, &data->rx_underruns);
> +
> +	data->tmpstats.rx_length_errors +=
> +	    tsi108_read_stat(data, TSI108_STAT_RXJUMBO,
> +			     TSI108_STAT_CARRY1_RXJUMBO,
> +			     TSI108_STAT_RXJUMBO_CARRY, &data->rx_overruns);
> +
> +	data->tmpstats.rx_frame_errors =
> +	    tsi108_read_stat(data, TSI108_STAT_RXALIGN,
> +			     TSI108_STAT_CARRY1_RXALIGN,
> +			     TSI108_STAT_RXALIGN_CARRY,
> +			     &data->stats.rx_frame_errors);
> +
> +	data->tmpstats.rx_frame_errors +=
> +	    tsi108_read_stat(data, TSI108_STAT_RXFCS,
> +			     TSI108_STAT_CARRY1_RXFCS, TSI108_STAT_RXFCS_CARRY,
> +			     &data->rx_fcs);
> +
> +	data->tmpstats.rx_frame_errors +=
> +	    tsi108_read_stat(data, TSI108_STAT_RXFRAG,
> +			     TSI108_STAT_CARRY1_RXFRAG,
> +			     TSI108_STAT_RXFRAG_CARRY, &data->rx_short_fcs);
> +
> +	data->tmpstats.rx_missed_errors =
> +	    tsi108_read_stat(data, TSI108_STAT_RXDROP,
> +			     TSI108_STAT_CARRY1_RXDROP,
> +			     TSI108_STAT_RXDROP_CARRY,
> +			     &data->stats.rx_missed_errors);
> +
> +	/* These three are maintained by software. */
> +	data->tmpstats.rx_fifo_errors = data->stats.rx_fifo_errors;
> +	data->tmpstats.rx_crc_errors = data->stats.rx_crc_errors;
> +
> +	data->tmpstats.tx_aborted_errors =
> +	    tsi108_read_stat(data, TSI108_STAT_TXEXDEF,
> +			     TSI108_STAT_CARRY2_TXEXDEF,
> +			     TSI108_STAT_TXEXDEF_CARRY,
> +			     &data->stats.tx_aborted_errors);
> +
> +	data->tmpstats.tx_aborted_errors +=
> +	    tsi108_read_stat(data, TSI108_STAT_TXPAUSEDROP,
> +			     TSI108_STAT_CARRY2_TXPAUSE,
> +			     TSI108_STAT_TXPAUSEDROP_CARRY,
> +			     &data->tx_pause_drop);
> +
> +	data->tmpstats.tx_aborted_errors += excol;
> +
> +	data->tmpstats.tx_errors = data->tmpstats.tx_aborted_errors;
> +	data->tmpstats.rx_errors = data->tmpstats.rx_length_errors +
> +	    data->tmpstats.rx_crc_errors +
> +	    data->tmpstats.rx_frame_errors +
> +	    data->tmpstats.rx_fifo_errors + data->tmpstats.rx_missed_errors;
> +
> +	spin_unlock_irq(&data->misclock);
> +	return &data->tmpstats;
> +}
> +
> +static void tsi108_restart_rx(struct tsi108_prv_data * data, struct net_device *dev)
> +{
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_PTRHIGH,
> +			     TSI108_EC_RXQ_PTRHIGH_VALID);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCTRL, TSI108_EC_RXCTRL_GO
> +			     | TSI108_EC_RXCTRL_QUEUE0);
> +}
> +
> +static void tsi108_restart_tx(struct tsi108_prv_data * data)
> +{
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_PTRHIGH,
> +			     TSI108_EC_TXQ_PTRHIGH_VALID);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCTRL, TSI108_EC_TXCTRL_IDLEINT |
> +			     TSI108_EC_TXCTRL_GO | TSI108_EC_TXCTRL_QUEUE0);
> +}
> +
> +/* txlock must be held by caller, with IRQs disabled, and
> + * with permission to re-enable them when the lock is dropped.
> + */
> +static void tsi108_check_for_completed_tx(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	int tx;
> +	struct sk_buff *skb;
> +	int release = 0;
> +
> +	while (!data->txfree || data->txhead != data->txtail) {
> +		tx = data->txtail;
> +
> +		if (data->txring[tx].misc & TSI108_TX_OWN)
> +			break;
> +
> +		skb = data->txskbs[tx];
> +
> +		if (!(data->txring[tx].misc & TSI108_TX_OK))
> +			printk("%s: bad tx packet, misc %x\n",
> +			       dev->name, data->txring[tx].misc);
> +
> +		data->txtail = (data->txtail + 1) % TSI108_TXRING_LEN;
> +		data->txfree++;
> +
> +		if (data->txring[tx].misc & TSI108_TX_EOF) {
> +			dev_kfree_skb_any(skb);
> +			release++;
> +		}
> +	}
> +
> +	if (release) {
> +		if (netif_queue_stopped(dev)
> +		    && is_valid_ether_addr(dev->dev_addr) && data->link_up)
> +			netif_wake_queue(dev);

this is a screwup of mine, copied to many other net drivers.

you don't need to check netif_queue_stopped() before calling 
netif_wake_queue()


> +static int tsi108_send_packet(struct sk_buff * skb, struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	int frags = skb_shinfo(skb)->nr_frags + 1;
> +	int i;
> +
> +	if (!data->phy_ok && net_ratelimit())
> +		printk(KERN_ERR "%s: Transmit while PHY is down!\n", dev->name);
> +
> +	if (!data->link_up) {
> +		printk(KERN_ERR "%s: Transmit while link is down!\n",
> +		       dev->name);
> +		netif_stop_queue(dev);
> +		return 1;
> +	}

use proper NETDEV_TX_xxx return codes


> +	if (data->txfree < MAX_SKB_FRAGS + 1) {
> +		netif_stop_queue(dev);
> +
> +		if (net_ratelimit())
> +			printk(KERN_ERR "%s: Transmit with full tx ring!\n",
> +			       dev->name);
> +		return 1;
> +	}
> +
> +	if (data->txfree - frags < MAX_SKB_FRAGS + 1) {
> +		netif_stop_queue(dev);
> +	}
> +
> +	spin_lock_irq(&data->txlock);
> +
> +	for (i = 0; i < frags; i++) {
> +		int misc = 0;
> +		int tx = data->txhead;
> +
> +		/* This is done to mark every TSI108_TX_INT_FREQ tx buffers with
> +		 * the interrupt bit.  TX descriptor-complete interrupts are
> +		 * enabled when the queue fills up, and masked when there is
> +		 * still free space.  This way, when saturating the outbound
> +		 * link, the tx interrupts are kept to a reasonable level. 
> +		 * When the queue is not full, reclamation of skbs still occurs
> +		 * as new packets are transmitted, or on a queue-empty
> +		 * interrupt.
> +		 */
> +
> +		if ((tx % TSI108_TX_INT_FREQ == 0) &&
> +		    ((TSI108_TXRING_LEN - data->txfree) >= TSI108_TX_INT_FREQ))
> +			misc = TSI108_TX_INT;
> +
> +		data->txskbs[tx] = skb;
> +
> +		if (i == 0) {
> +			data->txring[tx].buf0 = virt_to_phys(skb->data);
> +			data->txring[tx].len = skb->len - skb->data_len;
> +			misc |= TSI108_TX_SOF;
> +		} else {
> +			skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
> +
> +			data->txring[tx].buf0 =
> +			    page_to_phys(frag->page) + frag->page_offset;
> +			data->txring[tx].len = frag->size;

use dma mapping, not virt_to_phys

(of course, on some platforms, dma mapping devolves into virt_to_phy 
under the hood)


> +		if (i == frags - 1)
> +			misc |= TSI108_TX_EOF;
> +
> +#ifdef TSI108_PRINT_TX_FRAME
> +		{
> +			int i;
> +			printk("%s: Tx Frame contents (%d)\n", dev->name,
> +			       skb->len);
> +			for (i = 0; i < skb->len; i++)
> +				printk(" %2.2x", skb->data[i]);
> +			printk(".\n");
> +		}
> +#endif				/* TSI108_PRINT_TX_FRAME */


rather than ifdef, test netif_msg_pktdata() at runtime


> +		data->txring[tx].misc = misc | TSI108_TX_OWN;
> +
> +		data->txhead = (data->txhead + 1) % TSI108_TXRING_LEN;
> +		data->txfree--;
> +	}
> +
> +	tsi108_check_for_completed_tx(dev);
> +
> +	/* This must be done after the check for completed tx descriptors,
> +	 * so that the tail pointer is correct.
> +	 */
> +
> +	if (!(TSI108_ETH_READ_REG(TSI108_EC_TXSTAT) & TSI108_EC_TXSTAT_QUEUE0))
> +		tsi108_restart_tx(data);
> +
> +	spin_unlock_irq(&data->txlock);
> +	return 0;
> +}
> +
> +static int tsi108_check_for_completed_rx(struct net_device *dev, int budget)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	int done = 0;
> +
> +	while (data->rxfree && done != budget) {
> +		int rx = data->rxtail;
> +		struct sk_buff *skb;
> +
> +		if (data->rxring[rx].misc & TSI108_RX_OWN)
> +			break;
> +
> +		skb = data->rxskbs[rx];
> +		data->rxtail = (data->rxtail + 1) % TSI108_RXRING_LEN;
> +		data->rxfree--;
> +		done++;
> +
> +		if (data->rxring[rx].misc & TSI108_RX_BAD) {
> +			spin_lock_irq(&data->misclock);
> +
> +			if (data->rxring[rx].misc & TSI108_RX_CRC)
> +				data->stats.rx_crc_errors++;
> +			if (data->rxring[rx].misc & TSI108_RX_OVER)
> +				data->stats.rx_fifo_errors++;
> +
> +			spin_unlock_irq(&data->misclock);
> +
> +			dev_kfree_skb_any(skb);
> +			continue;
> +		}
> +#ifdef TSI108_PRINT_RX_FRAME
> +		{
> +			int i;
> +			printk("%s: Rx Frame contents (%d)\n",
> +			       dev->name, data->rxring[rx].len);
> +			for (i = 0; i < data->rxring[rx].len; i++)
> +				printk(" %2.2x", skb->data[i]);
> +			printk(".\n");
> +		}
> +#endif				/* TSI108_PRINT_RX_FRAME */

ditto


> +		skb->dev = dev;
> +		skb_put(skb, data->rxring[rx].len);
> +		skb->protocol = eth_type_trans(skb, dev);
> +		netif_receive_skb(skb);
> +		dev->last_rx = jiffies;
> +	}
> +
> +	return done;
> +}
> +
> +static int tsi108_refill_rx(struct net_device *dev, int budget)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	int done = 0;
> +
> +	while (data->rxfree != TSI108_RXRING_LEN && done != budget) {
> +		int rx = data->rxhead;
> +		struct sk_buff *skb;
> +
> +		data->rxskbs[rx] = skb = dev_alloc_skb(TSI108_RXBUF_SIZE + 2);
> +		if (!skb)
> +			break;
> +
> +		skb_reserve(skb, 2); /* Align the data on a 4-byte boundary. */
> +
> +		data->rxring[rx].buf0 = virt_to_phys(skb->data);

use dma mapping


> +		/* Sometimes the hardware sets blen to zero after packet
> +		 * reception, even though the manual says that it's only ever
> +		 * modified by the driver.
> +		 */
> +
> +		data->rxring[rx].blen = 1536;
> +		data->rxring[rx].misc = TSI108_RX_OWN | TSI108_RX_INT;
> +
> +		data->rxhead = (data->rxhead + 1) % TSI108_RXRING_LEN;
> +		data->rxfree++;
> +		done++;
> +	}
> +
> +	if (done != 0 && !(TSI108_ETH_READ_REG(TSI108_EC_RXSTAT) &
> +			   TSI108_EC_RXSTAT_QUEUE0))
> +		tsi108_restart_rx(data, dev);
> +
> +	return done;
> +}
> +
> +static int tsi108_poll(struct net_device *dev, int *budget)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 estat = TSI108_ETH_READ_REG(TSI108_EC_RXESTAT);
> +	u32 intstat = TSI108_ETH_READ_REG(TSI108_EC_INTSTAT);
> +	int total_budget = min(*budget, dev->quota);
> +	int num_received = 0, num_filled = 0, budget_used;
> +
> +	intstat &= TSI108_INT_RXQUEUE0 | TSI108_INT_RXTHRESH |
> +	    TSI108_INT_RXOVERRUN | TSI108_INT_RXERROR | TSI108_INT_RXWAIT;
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXESTAT, estat);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, intstat);
> +
> +	if (data->rxpending || (estat & TSI108_EC_RXESTAT_Q0_DESCINT))
> +		num_received = tsi108_check_for_completed_rx(dev, total_budget);
> +
> +	/* This should normally fill no more slots than the number of
> +	 * packets received in tsi108_check_for_completed_rx().  The exception
> +	 * is when we previously ran out of memory for RX SKBs.  In that
> +	 * case, it's helpful to obey the budget, not only so that the
> +	 * CPU isn't hogged, but so that memory (which may still be low)
> +	 * is not hogged by one device.
> +	 *
> +	 * A work unit is considered to be two SKBs to allow us to catch
> +	 * up when the ring has shrunk due to out-of-memory but we're
> +	 * still removing the full budget's worth of packets each time.
> +	 */
> +
> +	if (data->rxfree < TSI108_RXRING_LEN)
> +		num_filled = tsi108_refill_rx(dev, total_budget * 2);
> +
> +	if (intstat & TSI108_INT_RXERROR) {
> +		u32 err = TSI108_ETH_READ_REG(TSI108_EC_RXERR);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_RXERR, err);
> +
> +		if (err) {
> +			if (net_ratelimit())
> +				printk(KERN_DEBUG "%s: RX error %x\n",
> +				       dev->name, err);
> +
> +			if (!(TSI108_ETH_READ_REG(TSI108_EC_RXSTAT) &
> +			      TSI108_EC_RXSTAT_QUEUE0))
> +				tsi108_restart_rx(data, dev);
> +		}
> +	}
> +
> +	if (intstat & TSI108_INT_RXOVERRUN) {
> +		spin_lock_irq(&data->misclock);
> +		data->stats.rx_fifo_errors++;
> +		spin_unlock_irq(&data->misclock);
> +	}
> +
> +	budget_used = max(num_received, num_filled / 2);
> +
> +	*budget -= budget_used;
> +	dev->quota -= budget_used;
> +
> +	if (budget_used != total_budget) {
> +		data->rxpending = 0;
> +		netif_rx_complete(dev);
> +
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +				     TSI108_ETH_READ_REG(TSI108_EC_INTMASK)
> +				     & ~(TSI108_INT_RXQUEUE0
> +					 | TSI108_INT_RXTHRESH |
> +					 TSI108_INT_RXOVERRUN |
> +					 TSI108_INT_RXERROR |
> +					 TSI108_INT_RXWAIT));
> +
> +		/* IRQs are level-triggered, so no need to re-check */
> +		return 0;
> +	} else {
> +		data->rxpending = 1;
> +	}
> +
> +	return 1;
> +}
> +
> +static void tsi108_rx_int(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	/* A race could cause dev to already be scheduled, so it's not an
> +	 * error if that happens (and interrupts shouldn't be re-masked,
> +	 * because that can cause harmful races, if poll has already
> +	 * unmasked them but not cleared LINK_STATE_SCHED).  
> +	 *
> +	 * This can happen if this code races with tsi108_poll(), which masks
> +	 * the interrupts after tsi108_irq_one() read the mask, but before
> +	 * netif_rx_schedule is called.  It could also happen due to calls
> +	 * from tsi108_check_rxring().
> +	 */
> +
> +	if (netif_rx_schedule_prep(dev)) {
> +		/* Mask, rather than ack, the receive interrupts.  The ack
> +		 * will happen in tsi108_poll().
> +		 */
> +
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +				     TSI108_ETH_READ_REG(TSI108_EC_INTMASK) |
> +				     TSI108_INT_RXQUEUE0
> +				     | TSI108_INT_RXTHRESH |
> +				     TSI108_INT_RXOVERRUN | TSI108_INT_RXERROR |
> +				     TSI108_INT_RXWAIT);
> +		__netif_rx_schedule(dev);
> +	} else {
> +		if (!netif_running(dev)) {
> +			/* This can happen if an interrupt occurs while the
> +			 * interface is being brought down, as the START
> +			 * bit is cleared before the stop function is called.
> +			 *
> +			 * In this case, the interrupts must be masked, or
> +			 * they will continue indefinitely.
> +			 *
> +			 * There's a race here if the interface is brought down
> +			 * and then up in rapid succession, as the device could
> +			 * be made running after the above check and before
> +			 * the masking below.  This will only happen if the IRQ
> +			 * thread has a lower priority than the task brining
> +			 * up the interface.  Fixing this race would likely
> +			 * require changes in generic code.
> +			 */
> +
> +			TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +					     TSI108_ETH_READ_REG
> +					     (TSI108_EC_INTMASK) |
> +					     TSI108_INT_RXQUEUE0 |
> +					     TSI108_INT_RXTHRESH |
> +					     TSI108_INT_RXOVERRUN |
> +					     TSI108_INT_RXERROR |
> +					     TSI108_INT_RXWAIT);
> +		}
> +	}
> +}
> +
> +/* If the RX ring has run out of memory, try periodically
> + * to allocate some more, as otherwise poll would never
> + * get called (apart from the initial end-of-queue condition).
> + *
> + * This is called once per second (by default) from the thread.
> + */
> +
> +static void tsi108_check_rxring(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	/* A poll is scheduled, as opposed to caling tsi108_refill_rx 
> +	 * directly, so as to keep the receive path single-threaded
> +	 * (and thus not needing a lock).
> +	 */
> +
> +	if (netif_running(dev) && data->rxfree < TSI108_RXRING_LEN / 4)
> +		tsi108_rx_int(dev);
> +}
> +
> +static void tsi108_tx_int(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 estat = TSI108_ETH_READ_REG(TSI108_EC_TXESTAT);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXESTAT, estat);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, TSI108_INT_TXQUEUE0 |
> +			     TSI108_INT_TXIDLE | TSI108_INT_TXERROR);
> +	if (estat & TSI108_EC_TXESTAT_Q0_ERR) {
> +		u32 err = TSI108_ETH_READ_REG(TSI108_EC_TXERR);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_TXERR, err);
> +
> +		if (err && net_ratelimit())
> +			printk(KERN_ERR "%s: TX error %x\n", dev->name, err);
> +	}
> +
> +	if (estat & (TSI108_EC_TXESTAT_Q0_DESCINT | TSI108_EC_TXESTAT_Q0_EOQ)) {
> +		spin_lock(&data->txlock);
> +		tsi108_check_for_completed_tx(dev);
> +		spin_unlock(&data->txlock);

function names like tsi108_check_for_completed_tx() are just way too 
long.  tsi_complete_tx() would be better.


> +static irqreturn_t tsi108_irq_one(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 stat = TSI108_ETH_READ_REG(TSI108_EC_INTSTAT);
> +
> +	if (!(stat & TSI108_INT_ANY))
> +		return IRQ_NONE;	/* Not our interrupt */
> +
> +	stat &= ~TSI108_ETH_READ_REG(TSI108_EC_INTMASK);
> +
> +	if (stat & (TSI108_INT_TXQUEUE0 | TSI108_INT_TXIDLE |
> +		    TSI108_INT_TXERROR))
> +		tsi108_tx_int(dev);
> +	if (stat & (TSI108_INT_RXQUEUE0 | TSI108_INT_RXTHRESH |
> +		    TSI108_INT_RXWAIT | TSI108_INT_RXOVERRUN |
> +		    TSI108_INT_RXERROR))
> +		tsi108_rx_int(dev);
> +
> +	if (stat & TSI108_INT_SFN) {
> +		if (net_ratelimit())
> +			printk(KERN_DEBUG "%s: SFN error\n", dev->name);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, TSI108_INT_SFN);
> +	}
> +
> +	if (stat & TSI108_INT_STATCARRY) {
> +		tsi108_stat_carry(dev);
> +		TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, TSI108_INT_STATCARRY);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t tsi108_irq(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +
> +	return tsi108_irq_one(dev_id);

why create a separate function just for this one line?


> +static void tsi108_stop_ethernet(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	/* Disable all TX and RX queues ... */
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCTRL, 0);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCTRL, 0);
> +
> +	/* ...and wait for them to become idle */
> +	while (TSI108_ETH_READ_REG(TSI108_EC_TXSTAT) &
> +	       TSI108_EC_TXSTAT_ACTIVE) 
> +		cpu_relax();
> +	while (TSI108_ETH_READ_REG(TSI108_EC_RXSTAT) &
> +	       TSI108_EC_RXSTAT_ACTIVE)
> +		cpu_relax();

infinite loops with no timeout


> +static void tsi108_reset_ether(struct tsi108_prv_data * data)
> +{
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, TSI108_MAC_CFG1_SOFTRST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, 0);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, TSI108_EC_PORTCTRL_STATRST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL,
> +			     TSI108_ETH_READ_REG(TSI108_EC_PORTCTRL) &
> +			     ~TSI108_EC_PORTCTRL_STATRST);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCFG, TSI108_EC_TXCFG_RST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXCFG,
> +			     TSI108_ETH_READ_REG(TSI108_EC_TXCFG) &
> +			     ~TSI108_EC_TXCFG_RST);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG, TSI108_EC_RXCFG_RST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG,
> +			     TSI108_ETH_READ_REG(TSI108_EC_RXCFG) &
> +			     ~TSI108_EC_RXCFG_RST);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_MGMT_CFG,
> +			     TSI108_ETH_READ_REG(TSI108_MAC_MII_MGMT_CFG) |
> +			     TSI108_MAC_MII_MGMT_RST);
> +	udelay(100);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_MGMT_CFG,
> +			     TSI108_ETH_READ_REG(TSI108_MAC_MII_MGMT_CFG) &
> +			     ~(TSI108_MAC_MII_MGMT_RST |
> +			       TSI108_MAC_MII_MGMT_CLK));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_MGMT_CFG,
> +			     TSI108_ETH_READ_REG(TSI108_MAC_MII_MGMT_CFG) |
> +			     TSI108_MAC_MII_MGMT_CLK);

bus write posting bugs?


> +static int tsi108_get_mac(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 word1 = TSI108_ETH_READ_REG(TSI108_MAC_ADDR1);
> +	u32 word2 = TSI108_ETH_READ_REG(TSI108_MAC_ADDR2);
> +
> +	/* Note that the octets are reversed from what the manual says,
> +	 * producing an even weirder ordering...
> +	 */
> +	if (word2 == 0 && word1 == 0) {
> +		dev->dev_addr[0] = 0x00;
> +		dev->dev_addr[1] = 0x06;
> +		dev->dev_addr[2] = 0xd2;
> +		dev->dev_addr[3] = 0x00;
> +		dev->dev_addr[4] = 0x00;
> +		if (0x8 == data->phy)
> +			dev->dev_addr[5] = 0x01;
> +		else
> +			dev->dev_addr[5] = 0x02;
> +
> +		word2 = (dev->dev_addr[0] << 16) | (dev->dev_addr[1] << 24);
> +
> +		word1 = (dev->dev_addr[2] << 0) | (dev->dev_addr[3] << 8) |
> +		    (dev->dev_addr[4] << 16) | (dev->dev_addr[5] << 24);
> +
> +		TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR1, word1);
> +		TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR2, word2);
> +	} else {
> +		dev->dev_addr[0] = (word2 >> 16) & 0xff;
> +		dev->dev_addr[1] = (word2 >> 24) & 0xff;
> +		dev->dev_addr[2] = (word1 >> 0) & 0xff;
> +		dev->dev_addr[3] = (word1 >> 8) & 0xff;
> +		dev->dev_addr[4] = (word1 >> 16) & 0xff;
> +		dev->dev_addr[5] = (word1 >> 24) & 0xff;
> +	}
> +
> +	if (!is_valid_ether_addr(dev->dev_addr)) {
> +		printk("KERN_ERR: word1: %08x, word2: %08x\n", word1, word2);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tsi108_set_mac(struct net_device *dev, void *addr)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 word1, word2;
> +	int i;
> +
> +	if (!is_valid_ether_addr(addr))
> +		return -EINVAL;
> +
> +	for (i = 0; i < 6; i++)
> +		/* +2 is for the offset of the HW addr type */
> +		dev->dev_addr[i] = ((unsigned char *)addr)[i + 2];
> +
> +	word2 = (dev->dev_addr[0] << 16) | (dev->dev_addr[1] << 24);
> +
> +	word1 = (dev->dev_addr[2] << 0) | (dev->dev_addr[3] << 8) |
> +	    (dev->dev_addr[4] << 16) | (dev->dev_addr[5] << 24);
> +
> +	spin_lock_irq(&data->misclock);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR1, word1);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_ADDR2, word2);
> +	spin_lock(&data->txlock);
> +
> +	if (netif_queue_stopped(dev) && data->txfree && data->link_up)
> +		netif_wake_queue(dev);

no need to test netif_queue_stopped()


> +	spin_unlock(&data->txlock);
> +	spin_unlock_irq(&data->misclock);
> +	return 0;
> +}
> +
> +/* Protected by dev->xmit_lock. */
> +static void tsi108_set_rx_mode(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 rxcfg = TSI108_ETH_READ_REG(TSI108_EC_RXCFG);
> +
> +	if (dev->flags & IFF_PROMISC) {
> +		rxcfg &= ~(TSI108_EC_RXCFG_UC_HASH | TSI108_EC_RXCFG_MC_HASH);
> +		rxcfg |= TSI108_EC_RXCFG_UFE | TSI108_EC_RXCFG_MFE;
> +		goto out;
> +	}
> +
> +	rxcfg &= ~(TSI108_EC_RXCFG_UFE | TSI108_EC_RXCFG_MFE);
> +
> +	if (dev->mc_count) {

need to test for ALLMULTI


> +		int i;
> +		struct dev_mc_list *mc = dev->mc_list;
> +		rxcfg |= TSI108_EC_RXCFG_MFE | TSI108_EC_RXCFG_MC_HASH;
> +
> +		memset(data->mc_hash, 0, sizeof(data->mc_hash));
> +
> +		while (mc) {
> +			u32 hash, crc;
> +
> +			if (mc->dmi_addrlen == 6) {
> +				crc = ether_crc(6, mc->dmi_addr);
> +				hash = crc >> 23;
> +
> +				__set_bit(hash, &data->mc_hash[0]);
> +			} else {
> +				printk(KERN_ERR
> +				       "%s: got multicast address of length %d "
> +				       "instead of 6.\n", dev->name,
> +				       mc->dmi_addrlen);
> +			}
> +
> +			mc = mc->next;
> +		}
> +
> +		TSI108_ETH_WRITE_REG(TSI108_EC_HASHADDR,
> +				     TSI108_EC_HASHADDR_AUTOINC |
> +				     TSI108_EC_HASHADDR_MCAST);
> +
> +		for (i = 0; i < 16; i++) {
> +			/* The manual says that the hardware may drop
> +			 * back-to-back writes to the data register.
> +			 */
> +			udelay(1);
> +			TSI108_ETH_WRITE_REG(TSI108_EC_HASHDATA,
> +					     data->mc_hash[i]);
> +		}
> +	}
> +
> +      out:
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG, rxcfg);
> +}
> +
> +static void tsi108_init_phy(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	u32 i = 0;
> +	u16 phyVal = 0;
> +
> +	spin_lock_irq(&phy_lock);
> +
> +	tsi108_write_mii(data, PHY_CTRL, PHY_CTRL_RESET);
> +	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_RESET)
> +		cpu_relax();

infinite loop with no timeout

> +#if (TSI108_PHY_TYPE == PHY_BCM54XX)	/* Broadcom BCM54xx PHY */
> +	tsi108_write_mii(data, 0x09, 0x0300);
> +	tsi108_write_mii(data, 0x10, 0x1020);
> +	tsi108_write_mii(data, 0x1c, 0x8c00);
> +#endif
> +
> +	tsi108_write_mii(data,
> +			 PHY_CTRL,
> +			 PHY_CTRL_AUTONEG_EN | PHY_CTRL_AUTONEG_START);
> +	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_AUTONEG_START)
> +		cpu_relax();

ditto


> +	/* Set G/MII mode and receive clock select in TBI control #2.  The
> +	 * second port won't work if this isn't done, even though we don't
> +	 * use TBI mode.
> +	 */
> +
> +	tsi108_write_tbi(data, 0x11, 0x30);
> +
> +	/* FIXME: It seems to take more than 2 back-to-back reads to the
> +	 * PHY_STAT register before the link up status bit is set.
> +	 */
> +
> +	data->link_up = 1;
> +
> +	while (!((phyVal = tsi108_read_mii(data, PHY_STAT, NULL)) &
> +		 PHY_STAT_LINKUP)) {
> +		if (i++ > (MII_READ_DELAY / 10)) {
> +			data->link_up = 0;
> +			break;
> +		}
> +		spin_unlock_irq(&phy_lock);
> +		msleep(10);
> +		spin_lock_irq(&phy_lock);
> +	}
> +
> +	printk(KERN_DEBUG "PHY_STAT reg contains %08x\n", phyVal);
> +	data->phy_ok = 1;
> +	spin_unlock_irq(&phy_lock);
> +}
> +
> +static void tsi108_kill_phy(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	spin_lock_irq(&phy_lock);
> +	tsi108_write_mii(data, PHY_CTRL, PHY_CTRL_POWERDOWN);
> +	data->phy_ok = 0;
> +	spin_unlock_irq(&phy_lock);
> +}
> +
> +static int tsi108_open(struct net_device *dev)
> +{
> +	int i;
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	unsigned int rxring_size = TSI108_RXRING_LEN * sizeof(rx_desc);
> +	unsigned int txring_size = TSI108_TXRING_LEN * sizeof(tx_desc);
> +
> +	printk(KERN_DEBUG "Inside tsi108_open()!\n");

kill debugging printk, or use netif_msg_xxx properly


> +	i = request_irq(data->irq_num, tsi108_irq, 0, dev->name, dev);
> +	if (i != 0) {
> +		printk(KERN_ERR "tsi108_eth%d: Could not allocate IRQ%d.\n",
> +		       data->id, data->irq_num);
> +		return i;
> +	} else {
> +		dev->irq = data->irq_num;
> +		printk(KERN_NOTICE
> +		       "tsi108_open : Port %d Assigned IRQ %d to %s\n",
> +		       data->id, dev->irq, dev->name);
> +	}
> +
> +	data->rxring = pci_alloc_consistent(NULL, rxring_size, &data->rxdma);
> +
> +	if (!data->rxring) {
> +		printk(KERN_DEBUG
> +		       "TSI108_ETH: failed to allocate memory for rxring!\n");
> +		return -ENOMEM;
> +	} else {
> +		memset(data->rxring, 0, rxring_size);
> +	}
> +
> +	data->txring = pci_alloc_consistent(NULL, txring_size, &data->txdma);

since this is a platform driver, you should be using 
dma_alloc_coherent(), passing in the struct device*


> +	if (!data->txring) {
> +		printk(KERN_DEBUG
> +		       "TSI108_ETH: failed to allocate memory for txring!\n");
> +		pci_free_consistent(0, rxring_size, data->rxring, data->rxdma);

ditto


> +		return -ENOMEM;
> +	} else {
> +		memset(data->txring, 0, txring_size);
> +	}
> +
> +	for (i = 0; i < TSI108_RXRING_LEN; i++) {
> +		data->rxring[i].next0 = data->rxdma + (i + 1) * sizeof(rx_desc);
> +		data->rxring[i].blen = TSI108_RXBUF_SIZE;
> +		data->rxring[i].vlan = 0;
> +	}
> +
> +	data->rxring[TSI108_RXRING_LEN - 1].next0 = data->rxdma;
> +
> +	data->rxtail = 0;
> +	data->rxhead = 0;
> +
> +	for (i = 0; i < TSI108_RXRING_LEN; i++) {
> +		struct sk_buff *skb = dev_alloc_skb(TSI108_RXBUF_SIZE + NET_IP_ALIGN);
> +
> +		if (!skb) {
> +			/* Bah.  No memory for now, but maybe we'll get
> +			 * some more later.
> +			 * For now, we'll live with the smaller ring.
> +			 */
> +			printk(KERN_WARNING
> +			       "%s: Could only allocate %d receive skb(s).\n",
> +			       dev->name, i);
> +			data->rxhead = i;
> +			break;
> +		}
> +
> +		data->rxskbs[i] = skb;
> +		/* Align the payload on a 4-byte boundary */
> +		skb_reserve(skb, 2);
> +		data->rxskbs[i] = skb;
> +		data->rxring[i].buf0 = virt_to_phys(data->rxskbs[i]->data);

use dma mapping


> +		data->rxring[i].misc = TSI108_RX_OWN | TSI108_RX_INT;
> +	}
> +
> +	data->rxfree = i;
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_PTRLOW, data->rxdma);
> +
> +	for (i = 0; i < TSI108_TXRING_LEN; i++) {
> +		data->txring[i].next0 = data->txdma + (i + 1) * sizeof(tx_desc);
> +		data->txring[i].misc = 0;
> +	}
> +
> +	data->txring[TSI108_TXRING_LEN - 1].next0 = data->txdma;
> +	data->txtail = 0;
> +	data->txhead = 0;
> +	data->txfree = TSI108_TXRING_LEN;
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_PTRLOW, data->txdma);
> +	tsi108_init_phy(dev);
> +
> +	setup_timer(&data->timer, tsi108_timed_checker, (unsigned long)dev);
> +	mod_timer(&data->timer, jiffies + 1);
> +
> +	tsi108_restart_rx(data, dev);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTSTAT, ~0);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK,
> +			     ~(TSI108_INT_TXQUEUE0 | TSI108_INT_RXERROR |
> +			       TSI108_INT_RXTHRESH | TSI108_INT_RXQUEUE0 |
> +			       TSI108_INT_RXOVERRUN | TSI108_INT_RXWAIT |
> +			       TSI108_INT_SFN | TSI108_INT_STATCARRY));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1,
> +			     TSI108_MAC_CFG1_RXEN | TSI108_MAC_CFG1_TXEN);
> +	netif_start_queue(dev);
> +	return 0;
> +}
> +
> +static int tsi108_close(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	netif_stop_queue(dev);
> +
> +	del_timer_sync(&data->timer);
> +
> +	printk(KERN_DEBUG "Inside tsi108_ifdown!\n");

kill debugging printk, or use netif_msg_xxx properly


> +	tsi108_stop_ethernet(dev);
> +	tsi108_kill_phy(dev);
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK, ~0);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, 0);
> +
> +	/* Check for any pending TX packets, and drop them. */
> +
> +	while (!data->txfree || data->txhead != data->txtail) {
> +		int tx = data->txtail;
> +		struct sk_buff *skb;
> +		skb = data->txskbs[tx];
> +		data->txtail = (data->txtail + 1) % TSI108_TXRING_LEN;
> +		data->txfree++;
> +		dev_kfree_skb(skb);
> +	}
> +
> +	synchronize_irq(data->irq_num);
> +	free_irq(data->irq_num, dev);
> +
> +	/* Discard the RX ring. */
> +
> +	while (data->rxfree) {
> +		int rx = data->rxtail;
> +		struct sk_buff *skb;
> +
> +		skb = data->rxskbs[rx];
> +		data->rxtail = (data->rxtail + 1) % TSI108_RXRING_LEN;
> +		data->rxfree--;
> +		dev_kfree_skb(skb);
> +	}
> +
> +	pci_free_consistent(0,
> +			    TSI108_RXRING_LEN * sizeof(rx_desc),
> +			    data->rxring, data->rxdma);
> +	pci_free_consistent(0,
> +			    TSI108_TXRING_LEN * sizeof(tx_desc),
> +			    data->txring, data->txdma);

dma_free_coherent


> +	return 0;
> +}
> +
> +static void tsi108_init_mac(struct net_device *dev)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, TSI108_MAC_CFG2_DFLT_PREAMBLE |
> +			     TSI108_MAC_CFG2_PADCRC);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXTHRESH,
> +			     (192 << TSI108_EC_TXTHRESH_STARTFILL) |
> +			     (192 << TSI108_EC_TXTHRESH_STOPFILL));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRYMASK1,
> +			     ~(TSI108_STAT_CARRY1_RXBYTES |
> +			       TSI108_STAT_CARRY1_RXPKTS |
> +			       TSI108_STAT_CARRY1_RXFCS |
> +			       TSI108_STAT_CARRY1_RXMCAST |
> +			       TSI108_STAT_CARRY1_RXALIGN |
> +			       TSI108_STAT_CARRY1_RXLENGTH |
> +			       TSI108_STAT_CARRY1_RXRUNT |
> +			       TSI108_STAT_CARRY1_RXJUMBO |
> +			       TSI108_STAT_CARRY1_RXFRAG |
> +			       TSI108_STAT_CARRY1_RXJABBER |
> +			       TSI108_STAT_CARRY1_RXDROP));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_STAT_CARRYMASK2,
> +			     ~(TSI108_STAT_CARRY2_TXBYTES |
> +			       TSI108_STAT_CARRY2_TXPKTS |
> +			       TSI108_STAT_CARRY2_TXEXDEF |
> +			       TSI108_STAT_CARRY2_TXEXCOL |
> +			       TSI108_STAT_CARRY2_TXTCOL |
> +			       TSI108_STAT_CARRY2_TXPAUSE));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, TSI108_EC_PORTCTRL_STATEN);
> +	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, 0);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG,
> +			     TSI108_EC_RXCFG_SE | TSI108_EC_RXCFG_BFE);
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_CFG, TSI108_EC_TXQ_CFG_DESC_INT |
> +			     TSI108_EC_TXQ_CFG_EOQ_OWN_INT |
> +			     TSI108_EC_TXQ_CFG_WSWP | (TSI108_PBM_PORT <<
> +						TSI108_EC_TXQ_CFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_CFG, TSI108_EC_RXQ_CFG_DESC_INT |
> +			     TSI108_EC_RXQ_CFG_EOQ_OWN_INT |
> +			     TSI108_EC_RXQ_CFG_WSWP | (TSI108_PBM_PORT <<
> +						TSI108_EC_RXQ_CFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_BUFCFG,
> +			     TSI108_EC_TXQ_BUFCFG_BURST256 |
> +			     TSI108_EC_TXQ_BUFCFG_BSWP | (TSI108_PBM_PORT <<
> +						TSI108_EC_TXQ_BUFCFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_BUFCFG,
> +			     TSI108_EC_RXQ_BUFCFG_BURST256 |
> +			     TSI108_EC_RXQ_BUFCFG_BSWP | (TSI108_PBM_PORT <<
> +						TSI108_EC_RXQ_BUFCFG_SFNPORT));
> +
> +	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK, ~0);
> +}
> +
> +static int tsi108_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +{
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +	struct mii_ioctl_data *mii_data =
> +			(struct mii_ioctl_data *)&rq->ifr_data;
> +	int ret;
> +
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +		mii_data->phy_id = data->phy;
> +		ret = 0;
> +		break;
> +
> +	case SIOCGMIIREG:
> +		spin_lock_irq(&phy_lock);
> +		mii_data->val_out =
> +		    tsi108_read_mii(data, mii_data->reg_num, &ret);
> +		spin_unlock_irq(&phy_lock);
> +		break;

use generic_mii_ioctl from drivers/net/mii.c


> +	default:
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +tsi108_init_one(struct platform_device *pdev)
> +{
> +	struct net_device *dev = NULL;
> +	struct tsi108_prv_data *data = NULL;
> +	hw_info *einfo;
> +	int ret;
> +	
> +	einfo = pdev->dev.platform_data;
> +	
> +	if (NULL == einfo) {
> +		printk(KERN_ERR "tsi-eth %d: Missing additional data!\n",
> +		       pdev->id);
> +		return -ENODEV;
> +	}
> +
> +	/* Create an ethernet device instance */
> +
> +	dev = alloc_etherdev(sizeof(struct tsi108_prv_data));
> +	if (!dev) {
> +		printk("tsi108_eth: Could not allocate a device structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	printk("tsi108_eth%d: probe...\n", pdev->id);
> +	data = netdev_priv(dev);
> +
> +	pr_debug("tsi108_eth%d:regs:phyresgs:phy:irq_num=0x%x:0x%x:0x%x:0x%x\n",
> +			pdev->id, einfo->regs, einfo->phyregs,
> +			einfo->phy, einfo->irq_num);
> +	
> +	data->regs = ioremap(einfo->regs, 0x400);
> +	data->phyregs = ioremap(einfo->phyregs, 0x400);

check for failure (==NULL)


> +	data->phy = einfo->phy;
> +	data->irq_num = einfo->irq_num;
> +	data->id = pdev->id;
> +	dev->open = tsi108_open;
> +	dev->stop = tsi108_close;
> +	dev->hard_start_xmit = tsi108_send_packet;
> +	dev->set_mac_address = tsi108_set_mac;
> +	dev->set_multicast_list = tsi108_set_rx_mode;
> +	dev->get_stats = tsi108_get_stats;
> +	dev->poll = tsi108_poll;
> +	dev->do_ioctl = tsi108_ioctl;
> +	dev->weight = 64;  /* 64 is more suitable for GigE interface - klai */
> +
> +	/* Apparently, the Linux networking code won't use scatter-gather
> +	 * if the hardware doesn't do checksums.  However, it's faster
> +	 * to checksum in place and use SG, as (among other reasons)
> +	 * the cache won't be dirtied (which then has to be flushed
> +	 * before DMA).  The checksumming is done by the driver (via
> +	 * a new function skb_csum_dev() in net/core/skbuff.c).
> +	 */
> +
> +	dev->features = NETIF_F_HIGHDMA;
> +	SET_MODULE_OWNER(dev);
> +
> +	spin_lock_init(&data->txlock);
> +	spin_lock_init(&data->misclock);
> +
> +	tsi108_reset_ether(data);
> +	tsi108_kill_phy(dev);
> +
> +	if (tsi108_get_mac(dev) != 0)
> +		printk(KERN_ERR "%s: Invalid MAC address.  Please correct.\n",
> +		       dev->name);

handle failure


> +	tsi108_init_mac(dev);
> +	ret = register_netdev(dev);
> +	if (ret < 0) {
> +		free_netdev(dev);
> +		return ret;

leak:  need to iounmap on error


> +	}
> +
> +	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: "
> +	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
> +	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
> +	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
> +#ifdef DEBUG
> +	dump_eth_one(dev);
> +#endif
> +
> +	return 0;
> +}
> +
> +/* There's no way to either get interrupts from the PHY when
> + * something changes, or to have the Tsi108 automatically communicate
> + * with the PHY to reconfigure itself.
> + *
> + * Thus, we have to do it using a timer. 
> + */
> +
> +static void tsi108_timed_checker(unsigned long dev_ptr)
> +{
> +	struct net_device *dev = (struct net_device *)dev_ptr;
> +	struct tsi108_prv_data *data = netdev_priv(dev);
> +
> +	tsi108_check_phy(dev);
> +	tsi108_check_rxring(dev);
> +	mod_timer(&data->timer, jiffies + CHECK_PHY_INTERVAL);
> +}
> +
> +static int tsi108_ether_init(void)
> +{
> +	int ret;
> +	ret = platform_driver_register (&tsi_eth_driver);
> +	if (ret < 0){
> +		printk("tsi108_ether_init: error initializing ethernet "
> +		       "device\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int tsi108_ether_remove(struct platform_device *pdev)
> +{
> +	struct net_device *dev = platform_get_drvdata(pdev);
> +	struct tsi108_prv_data *priv = netdev_priv(dev);
> +	
> +	unregister_netdev(dev);
> +	tsi108_stop_ethernet(dev);
> +	platform_set_drvdata(pdev, NULL);
> +	iounmap((void __iomem *)priv->regs);
> +	iounmap((void __iomem *)priv->phyregs);

delete casts

