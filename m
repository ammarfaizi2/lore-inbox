Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967177AbWLEIaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967177AbWLEIaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937496AbWLEIaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:30:08 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:18381 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937494AbWLEIaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:30:07 -0500
Message-ID: <45752DF9.50002@chelsio.com>
Date: Tue, 05 Dec 2006 00:29:45 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Divy Le Ray <None@chelsio.com>, jeff@garzik.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/10] cxgb3 - main source file
References: <20061204194421.9061.66228.stgit@localhost.localdomain> <20061204130934.21b26a74@freekitty>
In-Reply-To: <20061204130934.21b26a74@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2006 08:29:48.0416 (UTC) FILETIME=[86A6A000:01C71847]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Thanks for the review. Please see my replies inline.

Stephen Hemminger wrote:

> O
>   
>> + * If we have multiple receive queues per port serviced by NAPI we need one
>> + * netdevice per queue as NAPI operates on netdevices.  We already have one
>> + * netdevice, namely the one associated with the interface, so we use dummy
>> + * ones for any additional queues.  Note that these netdevices exist purely
>> + * so that NAPI has something to work with, they do not represent network
>> + * ports and are not registered.
>> + */
>> +static int init_dummy_netdevs(struct adapter *adap)
>> +{
>> +	int i, j, dummy_idx = 0;
>> +	struct net_device *nd;
>> +
>> +	for_each_port(adap, i) {
>> +		const struct port_info *pi = &adap->port[i];
>> +
>> +		for (j = 0; j < pi->nqsets - 1; j++) {
>> +			if (!adap->dummy_netdev[dummy_idx]) {
>> +				nd = alloc_netdev(0, "", ether_setup);
>> +				if (!nd)
>> +					goto free_all;
>> +
>> +				nd->priv = adap;
>> +				nd->weight = 64;
>> +				set_bit(__LINK_STATE_START, &nd->state);
>> +				adap->dummy_netdev[dummy_idx] = nd;
>> +			}
>> +			strcpy(adap->dummy_netdev[dummy_idx]->name,
>> +			       pi->dev->name);
>> +			dummy_idx++;
>> +		}
>> +	}
>> +	return 0;
>> +
>> +free_all:
>> +	while (--dummy_idx >= 0) {
>> +		free_netdev(adap->dummy_netdev[dummy_idx]);
>> +		adap->dummy_netdev[dummy_idx] = NULL;
>> +	}
>> +	return -ENOMEM;
>> +}
>>     
>
>
> I understand this, but it seems more trouble than it is worth
> and adds longterm maintance burden to NAPI and receive management code.
>
> You would be better off doing your own scheduling in a tasklet.
>
>   
This code is directly inspired from the backlog_dev mechanism in 
net/core/dev.c.
NAPI provides fairness between adapters. Using our own scheduling would 
conflict with this.
>
>   
>> +	case SIOCCHIOCTL:
>> +		return cxgb_extension_ioctl(dev, req->ifr_data);
>>     
>
>
> Adding a chelsio specific ioctl value isn't going to get accepted.
> You need to use SIOCDEVPRIVATE, and figure out how to do 32bit/64bit
> ioctl compatibility for it.
>   
SIOCCHIOCTL is defined as SIOCDEVPRIVATE in cxgb3_ioctl.h.
>   
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +static void cxgb_netpoll(struct net_device *dev)
>> +{
>> +	unsigned long flags;
>> +	struct adapter *adapter = dev->priv;
>> +	struct sge_qset *qs = dev2qset(dev);
>> +
>> +	local_irq_save(flags);
>> +	t3_intr_handler(adapter, qs->rspq.polling) (adapter->pdev->irq,
>> +						    adapter);
>> +	local_irq_restore(flags);
>> +}
>> +#endif
>>     
>
> IRQ's are always disabled when netpoll is called.
>   
Okay, will fix.
>   
>> +	for (i = 0; i < ai->nports; ++i) {
>> +		struct net_device *netdev;
>> +
>> +		netdev = alloc_etherdev(adapter ? 0 : sizeof(*adapter));
>> +		if (!netdev) {
>> +			err = -ENOMEM;
>> +			goto out_free_dev;
>> +		}
>> +
>> +		if (!adapter) {
>> +			adapter = netdev->priv;
>> +
>> +			adapter->pdev = pdev;
>> +			adapter->port[0].dev = netdev;	// so we don't leak it
>> +
>> +			adapter->regs = ioremap_nocache(mmio_start, mmio_len);
>> +			if (!adapter->regs) {
>> +				CH_ERR("%s: cannot map device registers\n",
>> +				       pci_name(pdev));
>> +				err = -ENOMEM;
>> +				goto out_free_dev;
>> +			}
>> +
>> +			adapter->name = pci_name(pdev);
>> +			adapter->msg_enable = dflt_msg_enable;
>> +			adapter->mmio_len = mmio_len;
>> +			INIT_LIST_HEAD(&adapter->adapter_list);
>> +			mutex_init(&adapter->mdio_lock);
>> +			spin_lock_init(&adapter->work_lock);
>> +			spin_lock_init(&adapter->stats_lock);
>> +
>> +			INIT_WORK(&adapter->ext_intr_handler_task,
>> +				  ext_intr_task, adapter);
>> +			INIT_WORK(&adapter->adap_check_task, t3_adap_check_task,
>> +				  adapter);
>> +
>> +			pci_set_drvdata(pdev, netdev);
>> +		}
>>
>>     
>
> It looks like you are repeating the same method of doing multi-port that you
> did on cxgb2. It was wrong then, and it is wrong now:
>
> DON'T
> 	use if_port to distinguish port. if_port is legacy field see IF_PORT_XXX
> 	allocate adapter as part of 1st interface
> 	set dev->priv differently on each port
> 	don't use array in adapter structure for each port
> DO
> 	allocate adapter separately
> 	use netdev_priv() for per port data
> 	use port->adapter for adapter access
>   
We're fixing it.

Cheers,
Divy

