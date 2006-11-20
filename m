Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933957AbWKTGON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933957AbWKTGON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933954AbWKTGON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:14:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933953AbWKTGOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:14:12 -0500
Message-ID: <45614769.4020005@redhat.com>
Date: Mon, 20 Nov 2006 01:12:57 -0500
From: Chris Snook <csnook@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
References: <20061119203050.GD29736@osprey.hogchain.net> <200611200057.45274.arnd@arndb.de>
In-Reply-To: <200611200057.45274.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Sunday 19 November 2006 21:30, Jay Cliburn wrote:
>> This patch contains the main C file for the Attansic L1 gigabit ethernet
>> adapter driver.
> 
> Just a few style comments:
> 
>> +	/* PCI config space info */
>> +	hw->vendor_id = pdev->vendor;
>> +	hw->device_id = pdev->device;
>> +	hw->subsystem_vendor_id = pdev->subsystem_vendor;
>> +	hw->subsystem_id = pdev->subsystem_device;
> 
> Do you actually need the copies of these fields? I guess you can
> always access the data from pdev.

Probably not.  Thanks for pointing this out.

>> +	size = sizeof(struct at_buffer) * (tpd_ring->count + rfd_ring->count);
>> +	tpd_ring->buffer_info = kmalloc(size, GFP_KERNEL);
>> +	if (unlikely(!tpd_ring->buffer_info)) {
>> +		printk(KERN_WARNING "%s: kmalloc failed , size = D%d\n", 
>> +			at_driver_name, size);
>> +		return -ENOMEM;
>> +	}
>> +	rfd_ring->buffer_info =
>> +	    (struct at_buffer *)(tpd_ring->buffer_info + tpd_ring->count);
>> +
>> +	memset(tpd_ring->buffer_info, 0, size);
> 
> Use kzalloc or kcalloc here.

Good point.  I guess we should check the whole driver over for that.

>> +	ring_header->desc =
>> +	    pci_alloc_consistent(pdev, ring_header->size, &ring_header->dma);
>> +	if (unlikely(!ring_header->desc)) {
>> +		kfree(tpd_ring->buffer_info);
>> +		printk(KERN_WARNING 
>> +			"%s: pci_alloc_consistent failed, size = D%d\n", 
>> +			at_driver_name, size);
>> +		return -ENOMEM;
>> +	}
> 
> Your cleanup path gets simpler if you use goto, and only one
> instance of kfree at the end, instead of multiple return statements
> in this function.
> 
> 
>> +	while (!buffer_info->alloced && !next_info->alloced) {
>> +		if (NULL != buffer_info->skb) {
>> +			buffer_info->alloced = 1;
>> +			goto next;
>> +		}
> 
> Instead of 'if (NULL != buffer_info->skb)', you should write
> 'if (buffer_info->skb)', like you do elsewhere.

Thanks for pointing this out.  Seeing as this code is a ripoff of e1000, 
hacked up by Attansic, and then heavily reworked by Jay and I, there are 
some stylistic differences, but we'll try to make it more consistent.

>> +	      next:
>> +		rfd_next_to_use = next_next;
>> +		if (unlikely(++next_next == rfd_ring->count))
>> +			next_next = 0;
> 
> Labels go to the start of a line.

I blame Attansic.

>> +#ifdef NETIF_F_HW_VLAN_TX
>> +		if (adapter->vlgrp && (rrd->pkt_flg & PACKET_FLAG_VLAN_INS)) {
>> +			u16 vlan_tag = (rrd->vlan_tag >> 4) |
>> +			    		((rrd->vlan_tag & 7) << 13) | 
>> +					((rrd->vlan_tag & 8) << 9);
>> +			vlan_hwaccel_rx(skb, adapter->vlgrp, vlan_tag);
>> +		} else
>> +#endif
> 
> No need for the #ifdef when submitting the driver for inclusion.
> In this kernel version, NETIF_F_HW_VLAN_TX is always defined.

Thanks.  There are a lot of ifdefs that we're not sure are always 
defined.  Removing those would make this code much easier to review. 
More eyes on those ifdefs would be appreciated.

>> +static int at_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>> +{
>> +	struct at_adapter *adapter = netdev_priv(netdev);
>> +/*	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;*/
>> +	struct mii_ioctl_data *data = if_mii(ifr);
>> +	unsigned long flags;
>> +
>> +	switch (cmd) {
>> +	case SIOCGMIIPHY:
>> +		data->phy_id = 0;
>> +		break;
>> +	case SIOCGMIIREG:
>> +		if (!capable(CAP_NET_ADMIN))
>> +			return -EPERM;
>> +		spin_lock_irqsave(&adapter->stats_lock, flags);
>> +		if (at_read_phy_reg
>> +		    (&adapter->hw, data->reg_num & 0x1F, &data->val_out)) {
>> +			spin_unlock_irqrestore(&adapter->stats_lock, flags);
>> +			return -EIO;
>> +		}
>> +		spin_unlock_irqrestore(&adapter->stats_lock, flags);
>> +		break;
>> +	case SIOCSMIIREG:
>> +		if (!capable(CAP_NET_ADMIN))
>> +			return -EPERM;
>> +		if (data->reg_num & ~(0x1F))
>> +			return -EFAULT;
>> +		spin_lock_irqsave(&adapter->stats_lock, flags);
>> +		printk(KERN_DEBUG "%s: at_mii_ioctl write %x %x\n", 
>> +			at_driver_name, data->reg_num,
>> +			  data->val_in);
>> +		if (at_write_phy_reg(&adapter->hw, data->reg_num, data->val_in)) {
>> +			spin_unlock_irqrestore(&adapter->stats_lock, flags);
>> +			return -EIO;
>> +		}
>> +		spin_unlock_irqrestore(&adapter->stats_lock, flags);
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +	return AT_SUCCESS;
>> +}
>> +#endif				/* SIOCGMIIPHY */
> 
> Any reason why you can't use generic_mii_ioctl?

I decided to mostly leave this code alone, in the hope that we could 
just rip out MII support entirely and nobody would mind.  What do you think?

	-- Chris

>> +      err_init_hw:
>> +      err_reset:
>> +      err_register:
>> +      err_sw_init:
>> +      err_eeprom:
>> +	iounmap(adapter->hw.hw_addr);
>> +      err_ioremap:
>> +	free_netdev(netdev);
>> +      err_alloc_etherdev:
>> +	pci_release_regions(pdev);
>> +	return err;
> 
> It's more common to have a single label with multiple gotos instead
> of multiple labels that all go to one statement.

