Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266759AbUF3QQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266759AbUF3QQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266769AbUF3QPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:15:45 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:46292 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266766AbUF3QNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:13:02 -0400
Message-ID: <40E2E618.5020601@colorfullife.com>
Date: Wed, 30 Jun 2004 18:11:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
References: <40E25328.8020102@colorfullife.com> <40E25944.8010200@pobox.com>
In-Reply-To: <40E25944.8010200@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Manfred Spraul wrote:
>
>> -#define FORCEDETH_VERSION        "0.25"
>> +#define FORCEDETH_VERSION        "0.28"
>
>
> does this mean that .26 and .27 will be submitted as separate patches?
>
I think they were internal patches from Carl-Daniel. I think one of them 
was for wol support, the other one a bugfix.

> what is the goal for a 1.0.0 version?
>
At least
- wol support
- ethtool support

> These days I try to encourage moving to a 1.0 version once things seem 
> to be working and stable.
>
Ok.

>>  /* limited to 1 packet until we understand NV_TX_LASTPACKET */
>> -#define TX_LIMIT_STOP    10
>> -#define TX_LIMIT_START    5
>> +#define TX_LIMIT_STOP    63
>> +#define TX_LIMIT_START    62
>
>
> what's with the "limited to 1 packet" comment?
>
It's probably stale, I must check my docs. I'll remove it after some 
more testing.

>>  #define RX_NIC_BUFSIZE        (DEFAULT_MTU + 64)
>
>
> definition of DEFAULT_MTU is a bit silly ... why not just use 
> ETH_DATA_LEN?
>
Ok, I'll fix that.

>> -    u16 tx_flags;
>> +    u32 tx_flags;
>>  };
>
>
> has this driver been tested with the case where ethtool is used to 
> force the media to a specific speed (such as 100mbit full duplex)?
>
The driver doesn't support ethtool, so this was not tested.
I have tested it with a cross-over cable to a natsemi nic and then 
forced link speeds on the natsemi nic with ethtool.

>>  
>> -        prd = &np->tx_ring[i];
>> +        Flags = cpu_to_le32(np->tx_ring[i].FlagLen);
>
>
> shouldn't this be le32_to_cpu() ?
>
Ups. You are right. I'll fix it and send you an updated patch.

>> +    dprintk(KERN_INFO "%s: reconfiguration for multicast lists.\n",
>> +        dev->name);
>>      nv_start_rx(dev);
>>      spin_unlock_irq(&np->lock);
>
>
> some of these dprintk() would be more appropriate as verbose printks 
> enabled and disabled using netif_msg_xxx bitmaps.
>
I agree - dprintk on is too verbose and dprintk off is too quiet. I'll 
fix it in another patch.

>> -    /* 4) continue setup */
>> +    /* 4) give hw rings */
>> +    writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
>> +    writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), 
>> base + NvRegTxRingPhysAddr);
>> +    writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << 
>> NVREG_RINGSZ_TXSHIFT),
>> +        base + NvRegRingSizes);
>
>
> your driver needs to call pci_set_dma_mask() and 
> pci_set_consistent_dma_mask().
>
I'll add that.

>> +        np->tx_flags = NV_TX2_LASTPACKET|NV_TX2_VALID;
>> +        if (id->driver_data & DEV_NEED_LASTPACKET1)
>> +            np->tx_flags |= NV_TX2_LASTPACKET1;
>> +    }
>
>
> would it be faster to simply ensure that np->tx_flags is fixed-endian?
>
Not really: the only use is
ring_flags = cpu_to_le32( (skb->len-1) | tx_flags);
Pre-swapping it would change that to
ring_flags = cpu_to_le32(skb->len-1) | np->tx_flags;

>> +    if (i == 32) {
>> +        /* PHY in isolate mode? No phy attached and user wants to
>> +         * test loopback? Very odd, but can be correct.
>> +         */
>> +        printk(KERN_INFO "%s: open: Could not find a valid PHY.\n",
>> +                pci_name(pci_dev));
>> +    }
>
>
> I recommend trying phy 0 after phy 31, _iff_ the scan found nothing.
>
A phy with id 0 is in isolate mode. It must be reconfigured before it 
can be used, and this is not yet handled.

>>  
>>  MODULE_PARM(max_interrupt_work, "i");
>>  MODULE_PARM_DESC(max_interrupt_work, "forcedeth maximum events 
>> handled per interrupt");
>> - +
>>  MODULE_AUTHOR("Manfred Spraul <manfred@colorfullife.com>");
>>  MODULE_DESCRIPTION("Reverse Engineered nForce ethernet driver");
>>  MODULE_LICENSE("GPL");
>
>
> module_param() use would be nice :)
>
Ok.

--
    Manfred
