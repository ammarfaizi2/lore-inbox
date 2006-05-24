Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWEXBN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWEXBN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWEXBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:13:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36480
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S932524AbWEXBNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:13:55 -0400
Date: Tue, 23 May 2006 18:13:55 -0700 (PDT)
Message-Id: <20060523.181355.115913162.davem@davemloft.net>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/9] [I/OAT] Setup the networking subsystem as a DMA
 client
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060524002014.19403.93371.stgit@gitlost.site>
References: <20060524001653.19403.31396.stgit@gitlost.site>
	<20060524002014.19403.93371.stgit@gitlost.site>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Leech <christopher.leech@intel.com>
Date: Tue, 23 May 2006 17:20:15 -0700

> +static void net_dma_rebalance(void)
> +{
> +	unsigned int cpu, i, n;
> +	struct dma_chan *chan;
> +
> +	lock_cpu_hotplug();

You can't call lock_cpu_hotplug(), because that sleeps and takes
semaphores and we currently hold a spinlock taken here:

> +static void netdev_dma_event(struct dma_client *client, struct dma_chan *chan,
> +	enum dma_event event)
> +{
> +	spin_lock(&net_dma_event_lock);
> +	switch (event) {
> +	case DMA_RESOURCE_ADDED:
> +		net_dma_count++;
> +		net_dma_rebalance();
> +		break;

You'll need to run this DMA rebalancing asynchronously in process
context via keventd or similar to deal with this locking bug.
