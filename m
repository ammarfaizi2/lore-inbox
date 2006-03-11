Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWCKI6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWCKI6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWCKI6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:58:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932436AbWCKI63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:58:29 -0500
Date: Sat, 11 Mar 2006 00:56:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] [I/OAT] Setup the networking subsystem as a DMA
 client
Message-Id: <20060311005619.70dad219.akpm@osdl.org>
In-Reply-To: <20060311022924.3950.33580.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
	<20060311022924.3950.33580.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>

There seems to be a small race here.

> +static void net_dma_rebalance(void)
>  +{
>  +	unsigned int cpu, i, n;
>  +	struct dma_chan *chan;
>  +
>  +	lock_cpu_hotplug();
>  +
>  +	if (net_dma_count == 0) {
>  +		for_each_online_cpu(cpu)
>  +			rcu_assign_pointer(per_cpu(softnet_data.net_dma, cpu), NULL);
>  +		unlock_cpu_hotplug();
>  +		return;
>  +	}

If some other CPU does netdev_dma_event(DMA_RESOURCE_REMOVED) now

>  +	i = 0;
>  +	cpu = first_cpu(cpu_online_map);
>  +
>  +	rcu_read_lock();
>  +	list_for_each_entry(chan, &net_dma_client->channels, client_node) {
>  +		n = ((num_online_cpus() / net_dma_count)
>  +		   + (i < (num_online_cpus() % net_dma_count) ? 1 : 0));

This will get a divide-by-zero.

>  +		while(n) {
>  +			per_cpu(softnet_data.net_dma, cpu) = chan;
>  +			cpu = next_cpu(cpu, cpu_online_map);
>  +			n--;
>  +		}
>  +		i++;
>  +	}
>  +	rcu_read_unlock();
>  +
>  +	unlock_cpu_hotplug();
>  +}
>  +
>  +/**
>  + * netdev_dma_event - event callback for the net_dma_client
>  + * @client: should always be net_dma_client
>  + * @chan:
>  + * @event:
>  + */
>  +static void netdev_dma_event(struct dma_client *client, struct dma_chan *chan,
>  +	enum dma_event event)
>  +{
>  +	switch (event) {
>  +	case DMA_RESOURCE_ADDED:
>  +		net_dma_count++;
>  +		net_dma_rebalance();
>  +		break;
>  +	case DMA_RESOURCE_REMOVED:
>  +		net_dma_count--;
>  +		net_dma_rebalance();
>  +		break;
>  +	default:
>  +		break;
>  +	}
>  +}
