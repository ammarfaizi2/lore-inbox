Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUAXUVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUAXUVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:21:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261188AbUAXUVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:21:39 -0500
Message-ID: <4012D3C6.1050805@pobox.com>
Date: Sat, 24 Jan 2004 15:21:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
References: <4012BF44.9@colorfullife.com>
In-Reply-To: <4012BF44.9@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Jeff wrote:
> 
>> * Interrupt handler is SCARY.  You can potentially take and release 
>> the spinlock -many times- during a single interrupt.
>>
> I think that can happen only in theory: A new packet is completed while 
> the driver processes rx packets. I all normal cases there should be one 
> spinlock operation per tx irq, and 0 per rx irq.
> And error handling IMHO doesn't count: it should be rare.
> Or do I overlook a common case?

Any amount of load at all will lead to multiple interations of the 
master loop in the interrupt handler.


>>> +#define NV_MIIPHY_DELAY    10
>>> +#define NV_MIIPHY_DELAYMAX    10000
>>
>>
>> Style:  it's fairly silly to mix enums and constants.
>>  
>>
> Right now: enum for the nic registers, #define for the rest. If you 
> don't like it I can change it.

enums are definitely preferred...  communicates more type/symbol 
information to the compiler and more symbol info to the debugger.


>>> +/* General driver defaults */
>>> +#define NV_WATCHDOG_TIMEO    (2*HZ)
>>
>>
>> this seems too short, and might trigger on normal events?
>>  
>>
> I think I copied it from another driver - which value would you recommend?

5 seconds is the norm, but it also depends on whether your link 
interrupt is 100% reliable.  If you don't have to synchronize the link 
watchdog timeout with other driver-private timers, the task is easier.

Tangent -- you may wish to check for link in ->tx_timeout(), before 
resetting the NIC.  Again, this depends on link interrupt/timer setup as 
well.  The basic point is that TX timeout -may- occur because link went 
away.  One way to handle this is to ensure that link-down events are 
always noticed before the watchdog timer kicks.  Another way to handle 
this is to simply check for link when ->tx_timeout() is called.


>>> +static inline struct fe_priv *get_nvpriv(struct net_device *dev)
>>> +{
>>> +    return (struct fe_priv *) dev->priv;
>>> +}
>>
>>
>> What's the point of this wrapper?
>>
>> You don't need to cast from a void pointer, either.
>>  
>>
> I usually try to write code that compiles as cpp - is that a forbidden 
> in kernel modules?

It's pointless in C, and so I've been stripping such casts out of all 
net drivers when I find them.


>>> +/*
>>> + * alloc_rx: fill rx ring entries.
>>> + * Return 1 if the allocations for the skbs failed and the
>>> + * rx engine is without Available descriptors
>>> + */
>>> +static int alloc_rx(struct net_device *dev)
>>> +{
>>
>>
> [snip]
> 
>>> +    return 0;
>>> +}
>>
>>
>> skb_reserve() seems to be missing
>>  
>>
> Do you have specs that show that all nForce versions support unaligned 
> buffers? skb_reserve is a performance feature, I don't want to add it 
> yet. Testing that it works is on our TODO list.

hmmmm, is nForce ever found on non-x86 boxes?  I would think that 
skb_reserve might be -required- for some platforms.


>> I wonder about calling dev_kfree_skb() from dev->tx_timeout() with 
>> dev->xmit_lock held...
>>  
>>
> Is that bug in the networking core still not fixed?

I am not aware of a bug in this area.


>>> +    /* 2) check that the packets were not sent already: */
>>> +    tx_done(dev);
>>
>>
>> bug:  tx_done unconditionally calls dev_kfree_skb_irq(), but here we 
>> are not in an interrupt.
>>  
>>
> What is the xxx_kfree_skb_xxx function that just works?

dev_kfree_skb_any


>>> +        /*
>>> +         * the packet is for us - immediately tear down the pci 
>>> mapping, and
>>> +         * prefetch the first cacheline of the packet.
>>> +         */
>>> +        pci_unmap_single(np->pci_dev, np->rx_dma[i],
>>> +                np->rx_skbuff[i]->len,
>>> +                PCI_DMA_FROMDEVICE);
>>> +        prefetch(np->rx_skbuff[i]->data);
>>
>>
>> is this just guessing?  or has this actually shown some value?
>>
>> I would prefer not to put stuff like this in unless it shows a 
>> measureable CPU usage or cache miss impact.
>>  
>>
> Just guessing - it shouldn't hurt. CPU usage won't be important until 
> nForce supports GigE. Should I remove it for now?

I would rather remove it.  "premature optimization" and all that. 
Otherwise this guess will be cut-n-pasted into other drivers, I 
guarantee, all without any verification of the guess... :)


>>> +/*
>>> + * change_mtu: dev->change_mtu function
>>> + * Called with dev_base_lock held for read.
>>> + */
>>> +static int change_mtu(struct net_device *dev, int new_mtu)
>>> +{
>>> +    if (new_mtu > DEFAULT_MTU)
>>> +        return -EINVAL;
>>> +    dev->mtu = new_mtu;
>>> +    return 0;
>>> +}
>>
>>
>> bug #1:  have you tested changing the MTU while the NIC is actually 
>> running?
>>
> What should the nic do? I'll continue to allocate 1.8 kB buffers because 
> I don't know how to reconfigure the nic hardware to reject large packets.

Fair enough.  You may wish to (after testing!) increase DEFAULT_MTU by 4 
bytes, to support VLAN.

>> bug #2:  need a minimum bound for the MTU as well
>>  
>>
> What is the minimum MTU? I remember a flamewar lkml about 200 byte MTU 
> for noisy radio links.

Usually the ethernet standard 60 is fine.


>>> +    for (i=0; ; i++) {
>>> +        events = readl(base + NvRegIrqStatus) & NVREG_IRQSTAT_MASK;
>>> +        writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
>>> +        pci_push(base);
>>> +        dprintk(KERN_DEBUG "%s: irq: %08x\n", dev->name, events);
>>> +        if (!(events & np->irqmask))
>>> +            break;
>>
>>
>> bug:  check for 0xffffffff
>>  
>>
> What causes 0xfffffff? Hotplug? I think the irq handler could leave 
> immediately if a reserved bit is set. I'll add that.

Yes, hot unplug or hardware fault.


>>> +    if (i == 32) {
>>> +        printk(KERN_INFO "%s: open: failing due to lack of suitable 
>>> PHY.\n",
>>> +                dev->name);
>>> +        ret = -EINVAL;
>>> +        goto out_drain;
>>> +    }
>>
>>
>> bug:  check #0 after checking #1, before giving up
>>
>>  
>>
> MII id 0 a valid mii address? Or is that broadcast to all?

It's usually something akin to an alias of one of the other phy id's, 
but if you found -no- phys at all, it wouldn't hurt to try zero.

Thanks,

	Jeff




