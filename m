Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266988AbUAXSyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266994AbUAXSyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:54:22 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:19933 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266988AbUAXSyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:54:14 -0500
Message-ID: <4012BF44.9@colorfullife.com>
Date: Sat, 24 Jan 2004 19:53:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4] forcedeth network driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:

>* Interrupt handler is SCARY.  You can potentially take and release the 
>spinlock -many times- during a single interrupt.
>
I think that can happen only in theory: A new packet is completed while 
the driver processes rx packets. I all normal cases there should be one 
spinlock operation per tx irq, and 0 per rx irq.
And error handling IMHO doesn't count: it should be rare.
Or do I overlook a common case?

>> +#define NV_MIIPHY_DELAY	10
>> +#define NV_MIIPHY_DELAYMAX	10000
>
>Style:  it's fairly silly to mix enums and constants.
>  
>
Right now: enum for the nic registers, #define for the rest. If you 
don't like it I can change it.

>> +/* General driver defaults */
>> +#define NV_WATCHDOG_TIMEO	(2*HZ)
>
>this seems too short, and might trigger on normal events?
>  
>
I think I copied it from another driver - which value would you recommend?

>> +static inline struct fe_priv *get_nvpriv(struct net_device *dev)
>> +{
>> +	return (struct fe_priv *) dev->priv;
>> +}
>
>What's the point of this wrapper?
>
>You don't need to cast from a void pointer, either.
>  
>
I usually try to write code that compiles as cpp - is that a forbidden 
in kernel modules?

>Locking for this function and update_linkspeed() is a bit random... 
>sometimes it's called inside the lock, sometimes not.
>
Should be always inside the lock - I'll check for bugs.

>> +/*
>> + * nic_ioctl: dev->do_ioctl function
>> + * Called with rtnl_lock held.
>> + */
>> +static int nic_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>
>These days, I am very much not interested in merging drivers that do not 
>implement the stupid-simple ETHTOOL_GDRVINFO ioctl.
>  
>
Ok.

>> +/*
>> + * alloc_rx: fill rx ring entries.
>> + * Return 1 if the allocations for the skbs failed and the
>> + * rx engine is without Available descriptors
>> + */
>> +static int alloc_rx(struct net_device *dev)
>> +{
>
[snip]

>> +	return 0;
>> +}
>
>skb_reserve() seems to be missing
>  
>
Do you have specs that show that all nForce versions support unaligned 
buffers? skb_reserve is a performance feature, I don't want to add it 
yet. Testing that it works is on our TODO list.

>I wonder about calling dev_kfree_skb() from dev->tx_timeout() with 
>dev->xmit_lock held...
>  
>
Is that bug in the networking core still not fixed?

>> +	np->next_tx++;
>> +
>> +	dev->trans_start = jiffies;
>> +	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
>> +		netif_stop_queue(dev);
>> +	spin_unlock_irq(&np->lock);
>> +	writel(NVREG_TXRXCTL_KICK, get_hwbase(dev) + NvRegTxRxControl);
>
>need pci_push() here?
>  
>
Ok.

>> +	/* 2) check that the packets were not sent already: */
>> +	tx_done(dev);
>
>bug:  tx_done unconditionally calls dev_kfree_skb_irq(), but here we are 
>not in an interrupt.
>  
>
What is the xxx_kfree_skb_xxx function that just works?

>> +		/*
>> +		 * the packet is for us - immediately tear down the pci mapping, and
>> +		 * prefetch the first cacheline of the packet.
>> +		 */
>> +		pci_unmap_single(np->pci_dev, np->rx_dma[i],
>> +				np->rx_skbuff[i]->len,
>> +				PCI_DMA_FROMDEVICE);
>> +		prefetch(np->rx_skbuff[i]->data);
>
>is this just guessing?  or has this actually shown some value?
>
>I would prefer not to put stuff like this in unless it shows a 
>measureable CPU usage or cache miss impact.
>  
>
Just guessing - it shouldn't hurt. CPU usage won't be important until 
nForce supports GigE. Should I remove it for now?

>> +/*
>> + * change_mtu: dev->change_mtu function
>> + * Called with dev_base_lock held for read.
>> + */
>> +static int change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +	if (new_mtu > DEFAULT_MTU)
>> +		return -EINVAL;
>> +	dev->mtu = new_mtu;
>> +	return 0;
>> +}
>
>bug #1:  have you tested changing the MTU while the NIC is actually running?
>
What should the nic do? I'll continue to allocate 1.8 kB buffers because 
I don't know how to reconfigure the nic hardware to reject large packets.

>bug #2:  need a minimum bound for the MTU as well
>  
>
What is the minimum MTU? I remember a flamewar lkml about 200 byte MTU 
for noisy radio links.

>bug:  netif_carrier_xxx not unconditionally initialized in open()
>  
>
Ok.

>Further, I would really prefer that you use the lib functions in 
>drivers/net/mii.c instead of re-coding this stuff from scratch.
>  
>
Merging is on my TODO list.

>> +	for (i=0; ; i++) {
>> +		events = readl(base + NvRegIrqStatus) & NVREG_IRQSTAT_MASK;
>> +		writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
>> +		pci_push(base);
>> +		dprintk(KERN_DEBUG "%s: irq: %08x\n", dev->name, events);
>> +		if (!(events & np->irqmask))
>> +			break;
>
>bug:  check for 0xffffffff
>  
>
What causes 0xfffffff? Hotplug? I think the irq handler could leave 
immediately if a reserved bit is set. I'll add that.

>Don't reimplement NAPI yourself ;-(  this is just duplicating kernel 
>code....  in a worse fashion.  At least NAPI can load balance using an 
>idea of overall system load, not just load on a single NIC.
>
>  
>
This is not NAPI: on some hardware, the irq bit remained stuck on, 
forever. Instant lock-up. The code is a workaround against that. I'd 
like to leave that in - we get a good bug report, instead of a system 
that doesn't boot.

>> +		id2 = mii_rw(dev, i, MII_PHYSID2, MII_READ);
>> +		if (id2 < 0)
>> +			continue;
>
>also check for 0xffff returned from h/w
>  
>
Ok.

>> +	if (i == 32) {
>> +		printk(KERN_INFO "%s: open: failing due to lack of suitable PHY.\n",
>> +				dev->name);
>> +		ret = -EINVAL;
>> +		goto out_drain;
>> +	}
>
>bug:  check #0 after checking #1, before giving up
>
>  
>
MII id 0 a valid mii address? Or is that broadcast to all?

>> +	if ( (i & NVREG_POWERSTATE_POWEREDUP) == 0) {
>> +		writel(NVREG_POWERSTATE_POWEREDUP|i, base + NvRegPowerState);
>> +	}
>
>style:  useless brackets
>  
>
Ok.

>> +
>> +	spin_lock_irq(&np->lock);
>> +	np->in_shutdown = 1;
>> +	spin_unlock_irq(&np->lock);
>> +	synchronize_irq(dev->irq);
>
>bug:  eliminate in_shutdown, and directly test netif_running() elsewhere 
>in code.  Again, re-implementing something the net stack already did for 
>you :)
>  
>
I'll check if I can use netif_running.

>> +	np->rx_ring = pci_alloc_consistent(pci_dev, sizeof(struct ring_desc) * (RX_RING + \
>> TX_RING), +						&np->ring_addr);
>> +	if (!np->rx_ring)
>> +		goto out_unmap;
>
>to avoid wasting memory, rx ring should be allocated at ->open() time, 
>and freed at ->close() time.  Otherwise this just reserves memory 
>needlessly when the interface is down.
>  
>
Ok.

>> +out_freering:
>> +	pci_free_consistent(np->pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING),
>> +				np->rx_ring, np->ring_addr);
>> +out_unmap:
>> +	iounmap(get_hwbase(dev));
>> +out_relreg:
>> +	pci_release_regions(pci_dev);
>> +out_disable:
>> +	pci_disable_device(pci_dev);
>> +out_free:
>> +	free_netdev(dev);
>> +	pci_set_drvdata(pci_dev, NULL);
>> +out:
>
>The order here is weird...  when unwinding, pci_set_drvdata() call 
>should be first, before pci_free_consistent()
>  
>
Ok.

>> +static int __init init_nic(void)
>> +{
>> +	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version \
>> %s.\n", FORCEDETH_VERSION); +	return pci_module_init(&driver);
>> +}
>
>minor bug:  for built-in drivers, only print version if you actually 
>found an interface.  For modular drivers, the above is fine.
>
>That's why you see 'printed_version' logic in various net drivers.
>
Ok.

--
    Manfred


