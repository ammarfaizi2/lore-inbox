Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266978AbUAXR7r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 12:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266980AbUAXR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 12:59:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266978AbUAXR7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 12:59:11 -0500
Message-ID: <4012B25B.9060706@pobox.com>
Date: Sat, 24 Jan 2004 12:58:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
References: <4012A738.2060009@gmx.net>
In-Reply-To: <4012A738.2060009@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Marcelo,
> 
> attached is the current version of forcedeth, a network driver for
> nForce{,2,3} chipsets which are fairly common today.
> So far, the only support for nForce chipsets has been a binary-only driver
> from NVidia.

> The patch is against your current bk tree.
> Please apply.

I wish you'd mailed me first...  let's not be so hasty.


General comments:

* This was suggested (and ignored), but IMO needs to be done -- the 
function names are -way- too generic.  If this driver oops's, people 
might see an oops in "open" or "close" functions, which is fairly 
useless information unless correlated with other info.  Please follow 
style and add a driver-specific prefix to your function names.

* Interrupt handler is SCARY.  You can potentially take and release the 
spinlock -many times- during a single interrupt.


> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,28))
> +static inline void synchronize_irq_wrapper(unsigned int irq) { synchronize_irq(); }
> +#undef synchronize_irq
> +#define synchronize_irq(irq)	synchronize_irq_wrapper(irq)
> +#endif

Just introduce a diff between 2.4 and 2.6 versions.


> +/*
> + * Hardware access:
> + */
> +
> +#define DEV_NEED_LASTPACKET1	0x0001
> +#define DEV_IRQMASK_1		0x0002
> +#define DEV_IRQMASK_2		0x0004
> +#define DEV_NEED_TIMERIRQ	0x0008
> +
> +enum {
> +	NvRegIrqStatus = 0x000,
> +#define NVREG_IRQSTAT_MIIEVENT	0x040
> +#define NVREG_IRQSTAT_MASK		0x1ff
> +	NvRegIrqMask = 0x004,
> +#define NVREG_IRQ_RX			0x0002
> +#define NVREG_IRQ_RX_NOBUF		0x0004
> +#define NVREG_IRQ_TX_ERR		0x0008
> +#define NVREG_IRQ_TX2			0x0010
> +#define NVREG_IRQ_TIMER			0x0020
> +#define NVREG_IRQ_LINK			0x0040
> +#define NVREG_IRQ_TX1			0x0100
> +#define NVREG_IRQMASK_WANTED_1		0x005f
> +#define NVREG_IRQMASK_WANTED_2		0x0147
> +#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
> +
> +	NvRegUnknownSetupReg6 = 0x008,
> +#define NVREG_UNKSETUP6_VAL		3
> +
> +/*
> + * NVREG_POLL_DEFAULT is the interval length of the timer source on the nic
> + * NVREG_POLL_DEFAULT=97 would result in an interval length of 1 ms
> + */
> +	NvRegPollingInterval = 0x00c,
> +#define NVREG_POLL_DEFAULT	970
> +	NvRegMisc1 = 0x080,
> +#define NVREG_MISC1_HD		0x02
> +#define NVREG_MISC1_FORCE	0x3b0f3c
> +
> +	NvRegTransmitterControl = 0x084,
> +#define NVREG_XMITCTL_START	0x01
> +	NvRegTransmitterStatus = 0x088,
> +#define NVREG_XMITSTAT_BUSY	0x01
> +
> +	NvRegPacketFilterFlags = 0x8c,
> +#define NVREG_PFF_ALWAYS	0x7F0008
> +#define NVREG_PFF_PROMISC	0x80
> +#define NVREG_PFF_MYADDR	0x20
> +
> +	NvRegOffloadConfig = 0x90,
> +#define NVREG_OFFLOAD_HOMEPHY	0x601
> +#define NVREG_OFFLOAD_NORMAL	0x5ee
> +	NvRegReceiverControl = 0x094,
> +#define NVREG_RCVCTL_START	0x01
> +	NvRegReceiverStatus = 0x98,
> +#define NVREG_RCVSTAT_BUSY	0x01
> +
> +	NvRegRandomSeed = 0x9c,
> +#define NVREG_RNDSEED_MASK	0x00ff
> +#define NVREG_RNDSEED_FORCE	0x7f00
> +
> +	NvRegUnknownSetupReg1 = 0xA0,
> +#define NVREG_UNKSETUP1_VAL	0x16070f
> +	NvRegUnknownSetupReg2 = 0xA4,
> +#define NVREG_UNKSETUP2_VAL	0x16
> +	NvRegMacAddrA = 0xA8,
> +	NvRegMacAddrB = 0xAC,
> +	NvRegMulticastAddrA = 0xB0,
> +#define NVREG_MCASTADDRA_FORCE	0x01
> +	NvRegMulticastAddrB = 0xB4,
> +	NvRegMulticastMaskA = 0xB8,
> +	NvRegMulticastMaskB = 0xBC,
> +
> +	NvRegTxRingPhysAddr = 0x100,
> +	NvRegRxRingPhysAddr = 0x104,
> +	NvRegRingSizes = 0x108,
> +#define NVREG_RINGSZ_TXSHIFT 0
> +#define NVREG_RINGSZ_RXSHIFT 16
> +	NvRegUnknownTransmitterReg = 0x10c,
> +	NvRegLinkSpeed = 0x110,
> +#define NVREG_LINKSPEED_FORCE 0x10000
> +#define NVREG_LINKSPEED_10	10
> +#define NVREG_LINKSPEED_100	100
> +#define NVREG_LINKSPEED_1000	1000
> +	NvRegUnknownSetupReg5 = 0x130,
> +#define NVREG_UNKSETUP5_BIT31	(1<<31)
> +	NvRegUnknownSetupReg3 = 0x134,
> +#define NVREG_UNKSETUP3_VAL1	0x200010
> +	NvRegTxRxControl = 0x144,
> +#define NVREG_TXRXCTL_KICK	0x0001
> +#define NVREG_TXRXCTL_BIT1	0x0002
> +#define NVREG_TXRXCTL_BIT2	0x0004
> +#define NVREG_TXRXCTL_IDLE	0x0008
> +#define NVREG_TXRXCTL_RESET	0x0010
> +	NvRegMIIStatus = 0x180,
> +#define NVREG_MIISTAT_ERROR		0x0001
> +#define NVREG_MIISTAT_LINKCHANGE	0x0008
> +#define NVREG_MIISTAT_MASK		0x000f
> +#define NVREG_MIISTAT_MASK2		0x000f
> +	NvRegUnknownSetupReg4 = 0x184,
> +#define NVREG_UNKSETUP4_VAL	8
> +
> +	NvRegAdapterControl = 0x188,
> +#define NVREG_ADAPTCTL_START	0x02
> +#define NVREG_ADAPTCTL_LINKUP	0x04
> +#define NVREG_ADAPTCTL_PHYVALID	0x4000
> +#define NVREG_ADAPTCTL_RUNNING	0x100000
> +#define NVREG_ADAPTCTL_PHYSHIFT	24
> +	NvRegMIISpeed = 0x18c,
> +#define NVREG_MIISPEED_BIT8	(1<<8)
> +#define NVREG_MIIDELAY	5
> +	NvRegMIIControl = 0x190,
> +#define NVREG_MIICTL_INUSE	0x10000
> +#define NVREG_MIICTL_WRITE	0x08000
> +#define NVREG_MIICTL_ADDRSHIFT	5
> +	NvRegMIIData = 0x194,
> +	NvRegWakeUpFlags = 0x200,
> +#define NVREG_WAKEUPFLAGS_VAL		0x7770
> +#define NVREG_WAKEUPFLAGS_BUSYSHIFT	24
> +#define NVREG_WAKEUPFLAGS_ENABLESHIFT	16
> +#define NVREG_WAKEUPFLAGS_D3SHIFT	12
> +#define NVREG_WAKEUPFLAGS_D2SHIFT	8
> +#define NVREG_WAKEUPFLAGS_D1SHIFT	4
> +#define NVREG_WAKEUPFLAGS_D0SHIFT	0
> +#define NVREG_WAKEUPFLAGS_ACCEPT_MAGPAT		0x01
> +#define NVREG_WAKEUPFLAGS_ACCEPT_WAKEUPPAT	0x02
> +#define NVREG_WAKEUPFLAGS_ACCEPT_LINKCHANGE	0x04
> +
> +	NvRegPatternCRC = 0x204,
> +	NvRegPatternMask = 0x208,
> +	NvRegPowerCap = 0x268,
> +#define NVREG_POWERCAP_D3SUPP	(1<<30)
> +#define NVREG_POWERCAP_D2SUPP	(1<<26)
> +#define NVREG_POWERCAP_D1SUPP	(1<<25)
> +	NvRegPowerState = 0x26c,
> +#define NVREG_POWERSTATE_POWEREDUP	0x8000
> +#define NVREG_POWERSTATE_VALID		0x0100
> +#define NVREG_POWERSTATE_MASK		0x0003
> +#define NVREG_POWERSTATE_D0		0x0000
> +#define NVREG_POWERSTATE_D1		0x0001
> +#define NVREG_POWERSTATE_D2		0x0002
> +#define NVREG_POWERSTATE_D3		0x0003
> +};
> +
> +struct ring_desc {
> +	u32 PacketBuffer;
> +	u16 Length;
> +	u16 Flags;
> +};
> +
> +#define NV_TX_LASTPACKET	(1<<0)
> +#define NV_TX_RETRYERROR	(1<<3)
> +#define NV_TX_LASTPACKET1	(1<<8)
> +#define NV_TX_DEFERRED		(1<<10)
> +#define NV_TX_CARRIERLOST	(1<<11)
> +#define NV_TX_LATECOLLISION	(1<<12)
> +#define NV_TX_UNDERFLOW		(1<<13)
> +#define NV_TX_ERROR		(1<<14)
> +#define NV_TX_VALID		(1<<15)
> +
> +#define NV_RX_DESCRIPTORVALID	(1<<0)
> +#define NV_RX_MISSEDFRAME	(1<<1)
> +#define NV_RX_SUBSTRACT1	(1<<3)
> +#define NV_RX_ERROR1		(1<<7)
> +#define NV_RX_ERROR2		(1<<8)
> +#define NV_RX_ERROR3		(1<<9)
> +#define NV_RX_ERROR4		(1<<10)
> +#define NV_RX_CRCERR		(1<<11)
> +#define NV_RX_OVERFLOW		(1<<12)
> +#define NV_RX_FRAMINGERR	(1<<13)
> +#define NV_RX_ERROR		(1<<14)
> +#define NV_RX_AVAIL		(1<<15)
> +
> +/* Miscelaneous hardware related defines: */
> +#define NV_PCI_REGSZ		0x270
> +
> +/* various timeout delays: all in usec */
> +#define NV_TXRX_RESET_DELAY	4
> +#define NV_TXSTOP_DELAY1	10
> +#define NV_TXSTOP_DELAY1MAX	500000
> +#define NV_TXSTOP_DELAY2	100
> +#define NV_RXSTOP_DELAY1	10
> +#define NV_RXSTOP_DELAY1MAX	500000
> +#define NV_RXSTOP_DELAY2	100
> +#define NV_SETUP5_DELAY		5
> +#define NV_SETUP5_DELAYMAX	50000
> +#define NV_POWERUP_DELAY	5
> +#define NV_POWERUP_DELAYMAX	5000
> +#define NV_MIIBUSY_DELAY	50
> +#define NV_MIIPHY_DELAY	10
> +#define NV_MIIPHY_DELAYMAX	10000

Style:  it's fairly silly to mix enums and constants.

(and you want to prefer enums, because they convey more type information 
to the compiler and symbol information to the debugger)


> +#define NV_WAKEUPPATTERNS	5
> +#define NV_WAKEUPMASKENTRIES	4
> +
> +/* General driver defaults */
> +#define NV_WATCHDOG_TIMEO	(2*HZ)

this seems too short, and might trigger on normal events?


> +#define DEFAULT_MTU		1500	/* also maximum supported, at least for now */
> +
> +#define RX_RING		128
> +#define TX_RING		16
> +/* limited to 1 packet until we understand NV_TX_LASTPACKET */
> +#define TX_LIMIT_STOP	10
> +#define TX_LIMIT_START	5
> +
> +/* rx/tx mac addr + type + vlan + align + slack*/
> +#define RX_NIC_BUFSIZE		(DEFAULT_MTU + 64)
> +/* even more slack */
> +#define RX_ALLOC_BUFSIZE	(DEFAULT_MTU + 128)
> +
> +#define OOM_REFILL	(1+HZ/20)
> +#define POLL_WAIT	(1+HZ/100)
> +
> +/*
> + * SMP locking:
> + * All hardware access under dev->priv->lock, except the performance
> + * critical parts:
> + * - rx is (pseudo-) lockless: it relies on the single-threading provided
> + * 	by the arch code for interrupts.
> + * - tx setup is lockless: it relies on dev->xmit_lock. Actual submission
> + *	needs dev->priv->lock :-(
> + * - set_multicast_list: preparation lockless, relies on dev->xmit_lock.
> + */
> +
> +/* in dev: base, irq */
> +struct fe_priv {
> +	spinlock_t lock;
> +
> +	/* General data:
> +	 * Locking: spin_lock(&np->lock); */
> +	struct net_device_stats stats;
> +	int in_shutdown;
> +	u32 linkspeed;
> +	int duplex;
> +	int phyaddr;
> +
> +	/* General data: RO fields */
> +	dma_addr_t ring_addr;
> +	struct pci_dev *pci_dev;
> +	u32 orig_mac[2];
> +	u32 irqmask;
> +
> +	/* rx specific fields.
> +	 * Locking: Within irq hander or disable_irq+spin_lock(&np->lock);
> +	 */
> +	struct ring_desc *rx_ring;
> +	unsigned int cur_rx, refill_rx;
> +	struct sk_buff *rx_skbuff[RX_RING];
> +	dma_addr_t rx_dma[RX_RING];
> +	unsigned int rx_buf_sz;
> +	struct timer_list oom_kick;
> +	struct timer_list nic_poll;
> +
> +	/*
> +	 * tx specific fields.
> +	 */
> +	struct ring_desc *tx_ring;
> +	unsigned int next_tx, nic_tx;
> +	struct sk_buff *tx_skbuff[TX_RING];
> +	dma_addr_t tx_dma[TX_RING];
> +	u16 tx_flags;
> +};
> +
> +/*
> + * Maximum number of loops until we assume that a bit in the irq mask
> + * is stuck. Overridable with module param.
> + */
> +static int max_interrupt_work = 5;
> +
> +static inline struct fe_priv *get_nvpriv(struct net_device *dev)
> +{
> +	return (struct fe_priv *) dev->priv;
> +}

What's the point of this wrapper?

You don't need to cast from a void pointer, either.


> +static int reg_delay(struct net_device *dev, int offset, u32 mask, u32 target,
> +				int delay, int delaymax, const char *msg)
> +{
> +	u8 *base = get_hwbase(dev);
> +
> +	pci_push(base);
> +	do {
> +		udelay(delay);
> +		delaymax -= delay;
> +		if (delaymax < 0) {
> +			if (msg)
> +				printk(msg);
> +			return 1;
> +		}
> +	} while ((readl(base + offset) & mask) != target);
> +	return 0;
> +}
> +
> +#define MII_READ	(-1)

MII_READ is used by callers, and shouldn't be buried near the function 
itself.


> +/* mii_rw: read/write a register on the PHY.
> + *
> + * Caller must guarantee serialization
> + */
> +static int mii_rw(struct net_device *dev, int addr, int miireg, int value)
> +{
> +	u8 *base = get_hwbase(dev);
> +	int was_running;
> +	u32 reg;
> +	int retval;
> +
> +	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
> +	was_running = 0;
> +	reg = readl(base + NvRegAdapterControl);
> +	if (reg & NVREG_ADAPTCTL_RUNNING) {
> +		was_running = 1;
> +		writel(reg & ~NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
> +	}
> +	reg = readl(base + NvRegMIIControl);
> +	if (reg & NVREG_MIICTL_INUSE) {
> +		writel(NVREG_MIICTL_INUSE, base + NvRegMIIControl);
> +		udelay(NV_MIIBUSY_DELAY);
> +	}
> +
> +	reg = NVREG_MIICTL_INUSE | (addr << NVREG_MIICTL_ADDRSHIFT) | miireg;
> +	if (value != MII_READ) {
> +		writel(value, base + NvRegMIIData);
> +		reg |= NVREG_MIICTL_WRITE;
> +	}
> +	writel(reg, base + NvRegMIIControl);
> +
> +	if (reg_delay(dev, NvRegMIIControl, NVREG_MIICTL_INUSE, 0,
> +			NV_MIIPHY_DELAY, NV_MIIPHY_DELAYMAX, NULL)) {
> +		dprintk(KERN_DEBUG "%s: mii_rw of reg %d at PHY %d timed out.\n",
> +				dev->name, miireg, addr);
> +		retval = -1;
> +	} else if (value != MII_READ) {
> +		/* it was a write operation - fewer failures are detectable */
> +		dprintk(KERN_DEBUG "%s: mii_rw wrote 0x%x to reg %d at PHY %d\n",
> +				dev->name, value, miireg, addr);
> +		retval = 0;
> +	} else if (readl(base + NvRegMIIStatus) & NVREG_MIISTAT_ERROR) {
> +		dprintk(KERN_DEBUG "%s: mii_rw of reg %d at PHY %d failed.\n",
> +				dev->name, miireg, addr);
> +		retval = -1;
> +	} else {
> +		/* FIXME: why is that required? */
> +		udelay(50);
> +		retval = readl(base + NvRegMIIData);
> +		dprintk(KERN_DEBUG "%s: mii_rw read from reg %d at PHY %d: 0x%x.\n",
> +				dev->name, miireg, addr, retval);
> +	}
> +	if (was_running) {
> +		reg = readl(base + NvRegAdapterControl);
> +		writel(reg | NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
> +	}
> +	return retval;
> +}

Locking for this function and update_linkspeed() is a bit random... 
sometimes it's called inside the lock, sometimes not.


> +/*
> + * nic_ioctl: dev->do_ioctl function
> + * Called with rtnl_lock held.
> + */
> +static int nic_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +{
> +	return -EOPNOTSUPP;
> +}

These days, I am very much not interested in merging drivers that do not 
implement the stupid-simple ETHTOOL_GDRVINFO ioctl.


> +/*
> + * alloc_rx: fill rx ring entries.
> + * Return 1 if the allocations for the skbs failed and the
> + * rx engine is without Available descriptors
> + */
> +static int alloc_rx(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	unsigned int refill_rx = np->refill_rx;
> +
> +	while (np->cur_rx != refill_rx) {
> +		int nr = refill_rx % RX_RING;
> +		struct sk_buff *skb;
> +
> +		if (np->rx_skbuff[nr] == NULL) {
> +
> +			skb = dev_alloc_skb(RX_ALLOC_BUFSIZE);
> +			if (!skb)
> +				break;
> +
> +			skb->dev = dev;
> +			np->rx_skbuff[nr] = skb;
> +		} else {
> +			skb = np->rx_skbuff[nr];
> +		}
> +		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
> +						PCI_DMA_FROMDEVICE);
> +		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
> +		np->rx_ring[nr].Length = cpu_to_le16(RX_NIC_BUFSIZE);
> +		wmb();
> +		np->rx_ring[nr].Flags = cpu_to_le16(NV_RX_AVAIL);
> +		dprintk(KERN_DEBUG "%s: alloc_rx: Packet  %d marked as Available\n",
> +					dev->name, refill_rx);
> +		refill_rx++;
> +	}
> +	np->refill_rx = refill_rx;
> +	if (np->cur_rx - refill_rx == RX_RING)
> +		return 1;
> +	return 0;
> +}

skb_reserve() seems to be missing


> +static void drain_tx(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	int i;
> +	for (i = 0; i < TX_RING; i++) {
> +		np->tx_ring[i].Flags = 0;
> +		if (np->tx_skbuff[i]) {
> +			pci_unmap_single(np->pci_dev, np->tx_dma[i],
> +						np->tx_skbuff[i]->len,
> +						PCI_DMA_TODEVICE);
> +			dev_kfree_skb(np->tx_skbuff[i]);
> +			np->tx_skbuff[i] = NULL;
> +			np->stats.tx_dropped++;
> +		}
> +	}
> +}

I wonder about calling dev_kfree_skb() from dev->tx_timeout() with 
dev->xmit_lock held...


> +static void drain_rx(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	int i;
> +	for (i = 0; i < RX_RING; i++) {
> +		np->rx_ring[i].Flags = 0;
> +		wmb();
> +		if (np->rx_skbuff[i]) {
> +			pci_unmap_single(np->pci_dev, np->rx_dma[i],
> +						np->rx_skbuff[i]->len,
> +						PCI_DMA_FROMDEVICE);
> +			dev_kfree_skb(np->rx_skbuff[i]);
> +			np->rx_skbuff[i] = NULL;
> +		}
> +	}
> +}
> +
> +static void drain_ring(struct net_device *dev)
> +{
> +	drain_tx(dev);
> +	drain_rx(dev);
> +}
> +
> +/*
> + * start_xmit: dev->hard_start_xmit function
> + * Called with dev->xmit_lock held.
> + */
> +static int start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	int nr = np->next_tx % TX_RING;
> +
> +	np->tx_skbuff[nr] = skb;
> +	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data,skb->len,
> +					PCI_DMA_TODEVICE);
> +
> +	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
> +	np->tx_ring[nr].Length = cpu_to_le16(skb->len-1);
> +
> +	spin_lock_irq(&np->lock);
> +	wmb();
> +	np->tx_ring[nr].Flags = np->tx_flags;
> +	dprintk(KERN_DEBUG "%s: start_xmit: packet packet %d queued for transmission.\n",
> +				dev->name, np->next_tx);
> +	{
> +		int j;
> +		for (j=0; j<64; j++) {
> +			if ((j%16) == 0)
> +				dprintk("\n%03x:", j);
> +			dprintk(" %02x", ((unsigned char*)skb->data)[j]);
> +		}
> +		dprintk("\n");
> +	}

would be nice if this loop was optimized out by the compiler.


> +	np->next_tx++;
> +
> +	dev->trans_start = jiffies;
> +	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
> +		netif_stop_queue(dev);
> +	spin_unlock_irq(&np->lock);
> +	writel(NVREG_TXRXCTL_KICK, get_hwbase(dev) + NvRegTxRxControl);

need pci_push() here?


> +	return 0;
> +}
> +
> +/*
> + * tx_done: check for completed packets, release the skbs.
> + *
> + * Caller must own np->lock.
> + */
> +static void tx_done(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +
> +	while (np->nic_tx < np->next_tx) {
> +		struct ring_desc *prd;
> +		int i = np->nic_tx % TX_RING;
> +
> +		prd = &np->tx_ring[i];
> +
> +		dprintk(KERN_DEBUG "%s: tx_done: looking at packet %d, Flags 0x%x.\n",
> +					dev->name, np->nic_tx, prd->Flags);
> +		if (prd->Flags & cpu_to_le16(NV_TX_VALID))
> +			break;
> +		if (prd->Flags & cpu_to_le16(NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
> +						NV_TX_UNDERFLOW|NV_TX_ERROR)) {
> +			if (prd->Flags & cpu_to_le16(NV_TX_UNDERFLOW))
> +				np->stats.tx_fifo_errors++;
> +			if (prd->Flags & cpu_to_le16(NV_TX_CARRIERLOST))
> +				np->stats.tx_carrier_errors++;
> +			np->stats.tx_errors++;
> +		} else {
> +			np->stats.tx_packets++;
> +			np->stats.tx_bytes += np->tx_skbuff[i]->len;
> +		}
> +		pci_unmap_single(np->pci_dev, np->tx_dma[i],
> +					np->tx_skbuff[i]->len,
> +					PCI_DMA_TODEVICE);
> +		dev_kfree_skb_irq(np->tx_skbuff[i]);
> +		np->tx_skbuff[i] = NULL;
> +		np->nic_tx++;
> +	}
> +	if (np->next_tx - np->nic_tx < TX_LIMIT_START)
> +		netif_wake_queue(dev);
> +}
> +
> +/*
> + * tx_timeout: dev->tx_timeout function
> + * Called with dev->xmit_lock held.
> + */
> +static void tx_timeout(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u8 *base = get_hwbase(dev);
> +
> +	dprintk(KERN_DEBUG "%s: Got tx_timeout. irq: %08x\n", dev->name,
> +			readl(base + NvRegIrqStatus) & NVREG_IRQSTAT_MASK);
> +
> +	spin_lock_irq(&np->lock);
> +
> +	/* 1) stop tx engine */
> +	stop_tx(dev);
> +
> +	/* 2) check that the packets were not sent already: */
> +	tx_done(dev);

bug:  tx_done unconditionally calls dev_kfree_skb_irq(), but here we are 
not in an interrupt.


> +	/* 3) if there are dead entries: clear everything */
> +	if (np->next_tx != np->nic_tx) {
> +		printk(KERN_DEBUG "%s: tx_timeout: dead entries!\n", dev->name);
> +		drain_tx(dev);
> +		np->next_tx = np->nic_tx = 0;
> +		writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
> +		netif_wake_queue(dev);
> +	}
> +
> +	/* 4) restart tx engine */
> +	start_tx(dev);
> +	spin_unlock_irq(&np->lock);
> +}
> +
> +static void rx_process(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +
> +	for (;;) {
> +		struct ring_desc *prd;
> +		struct sk_buff *skb;
> +		int len;
> +		int i;
> +		if (np->cur_rx - np->refill_rx >= RX_RING)
> +			break;	/* we scanned the whole ring - do not continue */
> +
> +		i = np->cur_rx % RX_RING;
> +		prd = &np->rx_ring[i];
> +		dprintk(KERN_DEBUG "%s: rx_process: looking at packet %d, Flags 0x%x.\n",
> +					dev->name, np->cur_rx, prd->Flags);
> +
> +		if (prd->Flags & cpu_to_le16(NV_RX_AVAIL))
> +			break;	/* still owned by hardware, */
> +
> +		/*
> +		 * the packet is for us - immediately tear down the pci mapping, and
> +		 * prefetch the first cacheline of the packet.
> +		 */
> +		pci_unmap_single(np->pci_dev, np->rx_dma[i],
> +				np->rx_skbuff[i]->len,
> +				PCI_DMA_FROMDEVICE);
> +		prefetch(np->rx_skbuff[i]->data);

is this just guessing?  or has this actually shown some value?

I would prefer not to put stuff like this in unless it shows a 
measureable CPU usage or cache miss impact.


> +		{
> +			int j;
> +			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->Flags);
> +			for (j=0; j<64; j++) {
> +				if ((j%16) == 0)
> +					dprintk("\n%03x:", j);
> +				dprintk(" %02x", ((unsigned char*)np->rx_skbuff[i]->data)[j]);
> +			}
> +			dprintk("\n");
> +		}
> +		/* look at what we actually got: */
> +		if (!(prd->Flags & cpu_to_le16(NV_RX_DESCRIPTORVALID)))
> +			goto next_pkt;
> +
> +
> +		len = le16_to_cpu(prd->Length);
> +
> +		if (prd->Flags & cpu_to_le16(NV_RX_MISSEDFRAME)) {
> +			np->stats.rx_missed_errors++;
> +			np->stats.rx_errors++;
> +			goto next_pkt;
> +		}
> +		if (prd->Flags & cpu_to_le16(NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
> +			np->stats.rx_errors++;
> +			goto next_pkt;
> +		}
> +		if (prd->Flags & cpu_to_le16(NV_RX_CRCERR)) {
> +			np->stats.rx_crc_errors++;
> +			np->stats.rx_errors++;
> +			goto next_pkt;
> +		}
> +		if (prd->Flags & cpu_to_le16(NV_RX_OVERFLOW)) {
> +			np->stats.rx_over_errors++;
> +			np->stats.rx_errors++;
> +			goto next_pkt;
> +		}
> +		if (prd->Flags & cpu_to_le16(NV_RX_ERROR)) {
> +			/* framing errors are soft errors, the rest is fatal. */
> +			if (prd->Flags & cpu_to_le16(NV_RX_FRAMINGERR)) {
> +				if (prd->Flags & cpu_to_le16(NV_RX_SUBSTRACT1)) {
> +					len--;
> +				}
> +			} else {
> +				np->stats.rx_errors++;
> +				goto next_pkt;
> +			}
> +		}
> +		/* got a valid packet - forward it to the network core */
> +		skb = np->rx_skbuff[i];
> +		np->rx_skbuff[i] = NULL;
> +
> +		skb_put(skb, len);
> +		skb->protocol = eth_type_trans(skb, dev);
> +		dprintk(KERN_DEBUG "%s: rx_process: packet %d with %d bytes, proto %d accepted.\n",
> +					dev->name, np->cur_rx, len, skb->protocol);
> +		netif_rx(skb);
> +		dev->last_rx = jiffies;
> +		np->stats.rx_packets++;
> +		np->stats.rx_bytes += len;
> +next_pkt:
> +		np->cur_rx++;
> +	}
> +}
> +
> +/*
> + * change_mtu: dev->change_mtu function
> + * Called with dev_base_lock held for read.
> + */
> +static int change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	if (new_mtu > DEFAULT_MTU)
> +		return -EINVAL;
> +	dev->mtu = new_mtu;
> +	return 0;
> +}

bug #1:  have you tested changing the MTU while the NIC is actually running?

bug #2:  need a minimum bound for the MTU as well



> +static void link_irq(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u8 *base = get_hwbase(dev);
> +	u32 miistat;
> +	int miival;
> +
> +	miistat = readl(base + NvRegMIIStatus);
> +	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
> +	printk(KERN_DEBUG "%s: link change notification, status 0x%x.\n", dev->name, miistat);
> +
> +	miival = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
> +	if (miival & BMSR_ANEGCOMPLETE) {
> +		update_linkspeed(dev);
> +
> +		if (netif_carrier_ok(dev)) {
> +			stop_rx(dev);
> +		} else {
> +			netif_carrier_on(dev);
> +			printk(KERN_INFO "%s: link up.\n", dev->name);
> +		}
> +		writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
> +					base + NvRegMisc1);
> +		start_rx(dev);
> +	} else {
> +		if (netif_carrier_ok(dev)) {
> +			netif_carrier_off(dev);
> +			printk(KERN_INFO "%s: link down.\n", dev->name);
> +			stop_rx(dev);
> +		}
> +		writel(np->linkspeed, base + NvRegLinkSpeed);
> +		pci_push(base);
> +	}
> +}

bug:  netif_carrier_xxx not unconditionally initialized in open()

Further, I would really prefer that you use the lib functions in 
drivers/net/mii.c instead of re-coding this stuff from scratch.


> +static irqreturn_t nic_irq(int foo, void *data, struct pt_regs *regs)
> +{
> +	struct net_device *dev = (struct net_device *) data;
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u8 *base = get_hwbase(dev);
> +	u32 events;
> +	int i;
> +
> +	dprintk(KERN_DEBUG "%s: nic_irq\n", dev->name);
> +
> +	for (i=0; ; i++) {
> +		events = readl(base + NvRegIrqStatus) & NVREG_IRQSTAT_MASK;
> +		writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
> +		pci_push(base);
> +		dprintk(KERN_DEBUG "%s: irq: %08x\n", dev->name, events);
> +		if (!(events & np->irqmask))
> +			break;

bug:  check for 0xffffffff


> +		if (events & (NVREG_IRQ_TX1|NVREG_IRQ_TX2|NVREG_IRQ_TX_ERR)) {
> +			spin_lock(&np->lock);
> +			tx_done(dev);
> +			spin_unlock(&np->lock);
> +		}
> +
> +		if (events & (NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
> +			rx_process(dev);
> +			if (alloc_rx(dev)) {
> +				spin_lock(&np->lock);
> +				if (!np->in_shutdown)
> +					mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
> +				spin_unlock(&np->lock);
> +			}
> +		}
> +
> +		if (events & NVREG_IRQ_LINK) {
> +			spin_lock(&np->lock);
> +			link_irq(dev);
> +			spin_unlock(&np->lock);
> +		}
> +		if (events & (NVREG_IRQ_TX_ERR)) {
> +			dprintk(KERN_DEBUG "%s: received irq with events 0x%x. Probably TX fail.\n",
> +						dev->name, events);
> +		}
> +		if (events & (NVREG_IRQ_UNKNOWN)) {
> +			printk(KERN_DEBUG "%s: received irq with unknown events 0x%x. Please report\n",
> +						dev->name, events);
> + 		}
> +		if (i > max_interrupt_work) {
> +			spin_lock(&np->lock);
> +			/* disable interrupts on the nic */
> +			writel(0, base + NvRegIrqMask);
> +			pci_push(base);
> +
> +			if (!np->in_shutdown)
> +				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
> +			printk(KERN_DEBUG "%s: too many iterations (%d) in nic_irq.\n", dev->name, i);
> +			spin_unlock(&np->lock);
> +			break;
> +		}

This is completely bogus.

Don't reimplement NAPI yourself ;-(  this is just duplicating kernel 
code....  in a worse fashion.  At least NAPI can load balance using an 
idea of overall system load, not just load on a single NIC.



> +	}
> +	dprintk(KERN_DEBUG "%s: nic_irq completed\n", dev->name);
> +
> +	return IRQ_RETVAL(i);
> +}
> +
> +static void do_nic_poll(unsigned long data)
> +{
> +	struct net_device *dev = (struct net_device *) data;
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u8 *base = get_hwbase(dev);
> +
> +	disable_irq(dev->irq);
> +	/*
> +	 * reenable interrupts on the nic, we have to do this before calling
> +	 * nic_irq because that may decide to do otherwise
> +	 */
> +	writel(np->irqmask, base + NvRegIrqMask);
> +	pci_push(base);
> +	nic_irq((int) 0, (void *) data, (struct pt_regs *) NULL);
> +	enable_irq(dev->irq);
> +}

The other half of the NAPI re-implementation...


> +static int open(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u8 *base = get_hwbase(dev);
> +	int ret, oom, i;
> +
> +	dprintk(KERN_DEBUG "forcedeth: open\n");
> +
> +	/* 1) erase previous misconfiguration */
> +	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */
> +	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
> +	writel(0, base + NvRegMulticastAddrB);
> +	writel(0, base + NvRegMulticastMaskA);
> +	writel(0, base + NvRegMulticastMaskB);
> +	writel(0, base + NvRegPacketFilterFlags);
> +	writel(0, base + NvRegAdapterControl);
> +	writel(0, base + NvRegLinkSpeed);
> +	writel(0, base + NvRegUnknownTransmitterReg);
> +	txrx_reset(dev);
> +	writel(0, base + NvRegUnknownSetupReg6);
> +
> +	/* 2) initialize descriptor rings */
> +	np->in_shutdown = 0;
> +	oom = init_ring(dev);
> +
> +	/* 3) set mac address */
> +	{
> +		u32 mac[2];
> +
> +		mac[0] = (dev->dev_addr[0] <<  0) + (dev->dev_addr[1] <<  8) +
> +				(dev->dev_addr[2] << 16) + (dev->dev_addr[3] << 24);
> +		mac[1] = (dev->dev_addr[4] << 0) + (dev->dev_addr[5] << 8);
> +
> +		writel(mac[0], base + NvRegMacAddrA);
> +		writel(mac[1], base + NvRegMacAddrB);
> +	}
> +
> +	/* 4) continue setup */
> +	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
> +	np->duplex = 0;
> +	writel(NVREG_UNKSETUP3_VAL1, base + NvRegUnknownSetupReg3);
> +	writel(0, base + NvRegTxRxControl);
> +	pci_push(base);
> +	writel(NVREG_TXRXCTL_BIT1, base + NvRegTxRxControl);
> +	reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
> +			NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
> +			KERN_INFO "open: SetupReg5, Bit 31 remained off\n");
> +	writel(0, base + NvRegUnknownSetupReg4);
> +
> +	/* 5) Find a suitable PHY */
> +	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
> +	for (i = 1; i < 32; i++) {
> +		int id1, id2;
> +
> +		id1 = mii_rw(dev, i, MII_PHYSID1, MII_READ);
> +		if (id1 < 0)
> +			continue;
> +		id2 = mii_rw(dev, i, MII_PHYSID2, MII_READ);
> +		if (id2 < 0)
> +			continue;

also check for 0xffff returned from h/w


> +		dprintk(KERN_DEBUG "%s: open: Found PHY %04x:%04x at address %d.\n",
> +				dev->name, id1, id2, i);
> +		np->phyaddr = i;
> +
> +		update_linkspeed(dev);
> +
> +		break;
> +	}
> +	if (i == 32) {
> +		printk(KERN_INFO "%s: open: failing due to lack of suitable PHY.\n",
> +				dev->name);
> +		ret = -EINVAL;
> +		goto out_drain;
> +	}

bug:  check #0 after checking #1, before giving up


> +	/* 6) continue setup */
> +	writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
> +				base + NvRegMisc1);
> +	writel(readl(base + NvRegTransmitterStatus), base + NvRegTransmitterStatus);
> +	writel(NVREG_PFF_ALWAYS, base + NvRegPacketFilterFlags);
> +	writel(NVREG_OFFLOAD_NORMAL, base + NvRegOffloadConfig);
> +
> +	writel(readl(base + NvRegReceiverStatus), base + NvRegReceiverStatus);
> +	get_random_bytes(&i, sizeof(i));
> +	writel(NVREG_RNDSEED_FORCE | (i&NVREG_RNDSEED_MASK), base + NvRegRandomSeed);
> +	writel(NVREG_UNKSETUP1_VAL, base + NvRegUnknownSetupReg1);
> +	writel(NVREG_UNKSETUP2_VAL, base + NvRegUnknownSetupReg2);
> +	writel(NVREG_POLL_DEFAULT, base + NvRegPollingInterval);
> +	writel(NVREG_UNKSETUP6_VAL, base + NvRegUnknownSetupReg6);
> +	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID,
> +			base + NvRegAdapterControl);
> +	writel(NVREG_UNKSETUP4_VAL, base + NvRegUnknownSetupReg4);
> +	writel(NVREG_WAKEUPFLAGS_VAL, base + NvRegWakeUpFlags);
> +
> +	/* 7) start packet processing */
> +	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
> +	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
> +	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
> +			base + NvRegRingSizes);
> +
> +	i = readl(base + NvRegPowerState);
> +	if ( (i & NVREG_POWERSTATE_POWEREDUP) == 0) {
> +		writel(NVREG_POWERSTATE_POWEREDUP|i, base + NvRegPowerState);
> +	}

style:  useless brackets


> +	pci_push(base);
> +	udelay(10);
> +	writel(readl(base + NvRegPowerState) | NVREG_POWERSTATE_VALID, base + NvRegPowerState);
> +	writel(NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
> +
> +
> +	writel(0, base + NvRegIrqMask);
> +	pci_push(base);
> +	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
> +	pci_push(base);
> +	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
> +	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
> +	pci_push(base);
> +
> +	ret = request_irq(dev->irq, &nic_irq, SA_SHIRQ, dev->name, dev);
> +	if (ret)
> +		goto out_drain;
> +
> +	writel(np->irqmask, base + NvRegIrqMask);
> +
> +	spin_lock_irq(&np->lock);
> +	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
> +	writel(0, base + NvRegMulticastAddrB);
> +	writel(0, base + NvRegMulticastMaskA);
> +	writel(0, base + NvRegMulticastMaskB);
> +	writel(NVREG_PFF_ALWAYS|NVREG_PFF_MYADDR, base + NvRegPacketFilterFlags);
> +	start_rx(dev);
> +	start_tx(dev);
> +	netif_start_queue(dev);
> +	if (oom)
> +		mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
> +	if (!(mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ) & BMSR_ANEGCOMPLETE)) {
> +		printk("%s: no link during initialization.\n", dev->name);
> +		netif_carrier_off(dev);
> +	}
> +
> +	spin_unlock_irq(&np->lock);
> +
> +	return 0;
> +out_drain:
> +	drain_ring(dev);
> +	return ret;
> +}
> +
> +static int close(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u8 *base;
> +
> +	spin_lock_irq(&np->lock);
> +	np->in_shutdown = 1;
> +	spin_unlock_irq(&np->lock);
> +	synchronize_irq(dev->irq);

bug:  eliminate in_shutdown, and directly test netif_running() elsewhere 
in code.  Again, re-implementing something the net stack already did for 
you :)


> +	del_timer_sync(&np->oom_kick);
> +	del_timer_sync(&np->nic_poll);
> +
> +	netif_stop_queue(dev);
> +	spin_lock_irq(&np->lock);
> +	stop_tx(dev);
> +	stop_rx(dev);
> +	base = get_hwbase(dev);
> +
> +	/* disable interrupts on the nic or we will lock up */
> +	writel(0, base + NvRegIrqMask);
> +	pci_push(base);
> +	dprintk(KERN_INFO "%s: Irqmask is zero again\n", dev->name);
> +
> +	spin_unlock_irq(&np->lock);
> +
> +	free_irq(dev->irq, dev);
> +
> +	drain_ring(dev);
> +
> +	/* FIXME: power down nic */
> +
> +	return 0;
> +}
> +
> +static int __devinit probe_nic(struct pci_dev *pci_dev, const struct pci_device_id *id)
> +{
> +	struct net_device *dev;
> +	struct fe_priv *np;
> +	unsigned long addr;
> +	u8 *base;
> +	int err, i;
> +
> +	dev = alloc_etherdev(sizeof(struct fe_priv));
> +	np = get_nvpriv(dev);
> +	err = -ENOMEM;
> +	if (!dev)
> +		goto out;
> +
> +	np->pci_dev = pci_dev;
> +	spin_lock_init(&np->lock);
> +	SET_MODULE_OWNER(dev);
> +	SET_NETDEV_DEV(dev, &pci_dev->dev);
> +
> +	init_timer(&np->oom_kick);
> +	np->oom_kick.data = (unsigned long) dev;
> +	np->oom_kick.function = &do_rx_refill;	/* timer handler */
> +	init_timer(&np->nic_poll);
> +	np->nic_poll.data = (unsigned long) dev;
> +	np->nic_poll.function = &do_nic_poll;	/* timer handler */
> +
> +	err = pci_enable_device(pci_dev);
> +	if (err) {
> +		printk(KERN_INFO "forcedeth: pci_enable_dev failed (%d) for device %s\n",
> +				err, pci_name(pci_dev));
> +		goto out_free;
> +	}
> +
> +	pci_set_master(pci_dev);
> +
> +	err = pci_request_regions(pci_dev, dev->name);
> +	if (err < 0)
> +		goto out_disable;
> +
> +	err = -EINVAL;
> +	addr = 0;
> +	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +		dprintk(KERN_DEBUG "%s: resource %d start %p len %ld flags 0x%08lx.\n",
> +				pci_name(pci_dev), i, (void*)pci_resource_start(pci_dev, i),
> +				pci_resource_len(pci_dev, i),
> +				pci_resource_flags(pci_dev, i));
> +		if (pci_resource_flags(pci_dev, i) & IORESOURCE_MEM &&
> +				pci_resource_len(pci_dev, i) >= NV_PCI_REGSZ) {
> +			addr = pci_resource_start(pci_dev, i);
> +			break;
> +		}
> +	}

Do nForce NICs really put the registers on random PCI BARs???

I would rather just hardcode is the PCI BAR if at all possible.



> +	if (i == DEVICE_COUNT_RESOURCE) {
> +		printk(KERN_INFO "forcedeth: Couldn't find register window for device %s.\n",
> +					pci_name(pci_dev));
> +		goto out_relreg;
> +	}
> +
> +	err = -ENOMEM;
> +	dev->base_addr = (unsigned long) ioremap(addr, NV_PCI_REGSZ);
> +	if (!dev->base_addr)
> +		goto out_disable;
> +	dev->irq = pci_dev->irq;
> +	np->rx_ring = pci_alloc_consistent(pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING),
> +						&np->ring_addr);
> +	if (!np->rx_ring)
> +		goto out_unmap;

to avoid wasting memory, rx ring should be allocated at ->open() time, 
and freed at ->close() time.  Otherwise this just reserves memory 
needlessly when the interface is down.


> +	np->tx_ring = &np->rx_ring[RX_RING];
> +
> +	dev->open = open;
> +	dev->stop = close;
> +	dev->hard_start_xmit = start_xmit;
> +	dev->get_stats = get_stats;
> +	dev->change_mtu = change_mtu;
> +	dev->set_multicast_list = set_multicast;
> +	dev->do_ioctl = nic_ioctl;
> +	dev->tx_timeout = tx_timeout;
> +	dev->watchdog_timeo = NV_WATCHDOG_TIMEO;
> +
> +	pci_set_drvdata(pci_dev, dev);
> +
> +
> +	/* read the mac address */
> +	base = get_hwbase(dev);
> +	np->orig_mac[0] = readl(base + NvRegMacAddrA);
> +	np->orig_mac[1] = readl(base + NvRegMacAddrB);
> +
> +	dev->dev_addr[0] = (np->orig_mac[1] >>  8) & 0xff;
> +	dev->dev_addr[1] = (np->orig_mac[1] >>  0) & 0xff;
> +	dev->dev_addr[2] = (np->orig_mac[0] >> 24) & 0xff;
> +	dev->dev_addr[3] = (np->orig_mac[0] >> 16) & 0xff;
> +	dev->dev_addr[4] = (np->orig_mac[0] >>  8) & 0xff;
> +	dev->dev_addr[5] = (np->orig_mac[0] >>  0) & 0xff;
> +
> +	if (!is_valid_ether_addr(dev->dev_addr)) {
> +		/*
> +		 * Bad mac address. At least one bios sets the mac address
> +		 * to 01:23:45:67:89:ab
> +		 */
> +		printk(KERN_ERR "%s: Invalid Mac address detected: %02x:%02x:%02x:%02x:%02x:%02x\n",
> +			pci_name(pci_dev),
> +			dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
> +			dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
> +		printk(KERN_ERR "Please complain to your hardware vendor. Switching to a random MAC.\n");
> +		dev->dev_addr[0] = 0x00;
> +		dev->dev_addr[1] = 0x00;
> +		dev->dev_addr[2] = 0x6c;
> +		get_random_bytes(&dev->dev_addr[3], 3);
> +	}

I don't like this random MAC address stuff.  Regardless of hardware 
behavior, this breaks MAC address uniqueness.

I would much rather that ->open() failed, if a valid MAC address were 
not present.  Then a simple userspace program can be run by the admin 
(policy!) that sets the MAC address, before bringing up the interface.


> +	dprintk(KERN_DEBUG "%s: MAC Address %02x:%02x:%02x:%02x:%02x:%02x\n", pci_name(pci_dev),
> +			dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
> +			dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
> +
> +	np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
> +	if (id->driver_data & DEV_NEED_LASTPACKET1)
> +		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
> +	if (id->driver_data & DEV_IRQMASK_1)
> +		np->irqmask = NVREG_IRQMASK_WANTED_1;
> +	if (id->driver_data & DEV_IRQMASK_2)
> +		np->irqmask = NVREG_IRQMASK_WANTED_2;
> +	if (id->driver_data & DEV_NEED_TIMERIRQ)
> +		np->irqmask |= NVREG_IRQ_TIMER;
> +
> +	err = register_netdev(dev);
> +	if (err) {
> +		printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", err);
> +		goto out_freering;
> +	}
> +	printk(KERN_INFO "%s: forcedeth.c: subsystem: %05x:%04x bound to %s\n",
> +			dev->name, pci_dev->subsystem_vendor, pci_dev->subsystem_device,
> +			pci_name(pci_dev));
> +
> +	return 0;
> +
> +out_freering:
> +	pci_free_consistent(np->pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING),
> +				np->rx_ring, np->ring_addr);
> +out_unmap:
> +	iounmap(get_hwbase(dev));
> +out_relreg:
> +	pci_release_regions(pci_dev);
> +out_disable:
> +	pci_disable_device(pci_dev);
> +out_free:
> +	free_netdev(dev);
> +	pci_set_drvdata(pci_dev, NULL);
> +out:

The order here is weird...  when unwinding, pci_set_drvdata() call 
should be first, before pci_free_consistent()



> +static struct pci_device_id pci_tbl[] = {
> +	{	/* nForce Ethernet Controller */
> +		.vendor = PCI_VENDOR_ID_NVIDIA,
> +		.device = 0x1C3,
> +		.subvendor = PCI_ANY_ID,
> +		.subdevice = PCI_ANY_ID,
> +		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ,
> +	},
> +	{	/* nForce2 Ethernet Controller */
> +		.vendor = PCI_VENDOR_ID_NVIDIA,
> +		.device = 0x0066,
> +		.subvendor = PCI_ANY_ID,
> +		.subdevice = PCI_ANY_ID,
> +		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
> +	},
> +	{	/* nForce3 Ethernet Controller */
> +		.vendor = PCI_VENDOR_ID_NVIDIA,
> +		.device = 0x00D6,
> +		.subvendor = PCI_ANY_ID,
> +		.subdevice = PCI_ANY_ID,
> +		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
> +	},
> +	{0,},
> +};

You'll note this structure is wildly larger than most net drivers... 
maintainer's preference, but I think this is way too verbose.


> +static struct pci_driver driver = {
> +	.name = "forcedeth",
> +	.id_table = pci_tbl,
> +	.probe = probe_nic,
> +	.remove = __devexit_p(remove_nic),
> +};
> +
> +
> +static int __init init_nic(void)
> +{
> +	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
> +	return pci_module_init(&driver);
> +}

minor bug:  for built-in drivers, only print version if you actually 
found an interface.  For modular drivers, the above is fine.

That's why you see 'printed_version' logic in various net drivers.

	Jeff



