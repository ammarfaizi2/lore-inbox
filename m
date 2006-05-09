Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWEIU0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWEIU0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWEIU0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:26:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWEIU0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:26:04 -0400
Date: Tue, 9 May 2006 13:25:56 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060509132556.76deaa91@localhost.localdomain>
In-Reply-To: <20060509085201.446830000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085201.446830000@sous-sol.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int setup_device(struct xenbus_device *dev, struct
> netfront_info *info) +{
> +	struct netif_tx_sring *txs;
> +	struct netif_rx_sring *rxs;
> +	int err;
> +	struct net_device *netdev = info->netdev;
> +
> +	info->tx_ring_ref = GRANT_INVALID_REF;
> +	info->rx_ring_ref = GRANT_INVALID_REF;
> +	info->rx.sring = NULL;
> +	info->tx.sring = NULL;
> +	info->irq = 0;
> +
> +	txs = (struct netif_tx_sring *)get_zeroed_page(GFP_KERNEL);
> +	if (!txs) {
> +		err = -ENOMEM;
> +		xenbus_dev_fatal(dev, err, "allocating tx ring
> page");
> +		goto fail;
> +	}
> +	rxs = (struct netif_rx_sring *)get_zeroed_page(GFP_KERNEL);
> +	if (!rxs) {
> +		err = -ENOMEM;
> +		xenbus_dev_fatal(dev, err, "allocating rx ring
> page");
> +		free_page((unsigned long)txs);
> +		goto fail;
> +	}
> +	info->backend_state = BEST_DISCONNECTED;
> +
> +	SHARED_RING_INIT(txs);
> +	FRONT_RING_INIT(&info->tx, txs, PAGE_SIZE);
> +
> +	SHARED_RING_INIT(rxs);
> +	FRONT_RING_INIT(&info->rx, rxs, PAGE_SIZE);
> +
> +	err = xenbus_grant_ring(dev, virt_to_mfn(txs));
> +	if (err < 0)
> +		goto fail;
> +	info->tx_ring_ref = err;
> +
> +	err = xenbus_grant_ring(dev, virt_to_mfn(rxs));
> +	if (err < 0)
> +		goto fail;
> +	info->rx_ring_ref = err;
> +
> +	err = xenbus_alloc_evtchn(dev, &info->evtchn);
> +	if (err)
> +		goto fail;
> +
> +	memcpy(netdev->dev_addr, info->mac, ETH_ALEN);
> +	network_connect(netdev);
> +	info->irq = bind_evtchn_to_irqhandler(
> +		info->evtchn, netif_int, SA_SAMPLE_RANDOM,
> netdev->name,
> 

This doesn't look like a real random entropy source. packets
arriving from another domain are easily timed.
