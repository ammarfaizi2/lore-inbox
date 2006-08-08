Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWHHUO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWHHUO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWHHUO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:14:56 -0400
Received: from mga03.intel.com ([143.182.124.21]:43120 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030287AbWHHUOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:14:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="100455830:sNHT23060086"
Message-ID: <44D8F074.8060001@intel.com>
Date: Tue, 08 Aug 2006 13:13:40 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC][PATCH 4/9] e100 driver conversion
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193405.1396.14701.sendpatchset@lappy>
In-Reply-To: <20060808193405.1396.14701.sendpatchset@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2006 20:14:46.0096 (UTC) FILETIME=[4AE02500:01C6BB27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Update the driver to make use of the netdev_alloc_skb() API and the
> NETIF_F_MEMALLOC feature.

this should be done in two separate patches. I should take care of the netdev_alloc_skb()
part too for e100 (which I've already queued internally), also since ixgb still needs it.

do you have any plans to visit ixgb for this change too?

Cheers,

Auke


> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Daniel Phillips <phillips@google.com>
> 
> ---
>  drivers/net/e100.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/e100.c
> +++ linux-2.6/drivers/net/e100.c
> @@ -1763,7 +1763,7 @@ static inline void e100_start_receiver(s
>  #define RFD_BUF_LEN (sizeof(struct rfd) + VLAN_ETH_FRAME_LEN)
>  static int e100_rx_alloc_skb(struct nic *nic, struct rx *rx)
>  {
> -	if(!(rx->skb = dev_alloc_skb(RFD_BUF_LEN + NET_IP_ALIGN)))
> +	if(!(rx->skb = netdev_alloc_skb(nic->netdev, RFD_BUF_LEN + NET_IP_ALIGN)))
>  		return -ENOMEM;
>  
>  	/* Align, init, and map the RFD. */
> @@ -2143,7 +2143,7 @@ static int e100_loopback_test(struct nic
>  
>  	e100_start_receiver(nic, NULL);
>  
> -	if(!(skb = dev_alloc_skb(ETH_DATA_LEN))) {
> +	if(!(skb = netdev_alloc_skb(nic->netdev, ETH_DATA_LEN))) {
>  		err = -ENOMEM;
>  		goto err_loopback_none;
>  	}
> @@ -2573,6 +2573,7 @@ static int __devinit e100_probe(struct p
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  	netdev->poll_controller = e100_netpoll;
>  #endif
> +	netdev->features |= NETIF_F_MEMALLOC;
>  	strcpy(netdev->name, pci_name(pdev));
>  
>  	nic = netdev_priv(netdev);
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
