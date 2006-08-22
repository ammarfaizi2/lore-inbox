Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWHVAaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWHVAaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHVAaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:30:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62609
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750942AbWHVAaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:30:01 -0400
Date: Mon, 21 Aug 2006 17:30:16 -0700 (PDT)
Message-Id: <20060821.173016.116359572.davem@davemloft.net>
To: linas@austin.ibm.com
Cc: benh@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com, arnd@arndb.de
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060822001311.GK5427@austin.ibm.com>
References: <20060818234532.GA8644@austin.ibm.com>
	<1155962022.5803.68.camel@localhost.localdomain>
	<20060822001311.GK5427@austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linas@austin.ibm.com (Linas Vepstas)
Date: Mon, 21 Aug 2006 19:13:11 -0500

> @@ -1495,16 +1500,16 @@ spider_net_interrupt(int irq, void *ptr,
>  	if (!status_reg)
>  		return IRQ_NONE;
>  
> -	if (status_reg & SPIDER_NET_RXINT ) {
> +	if (status_reg & SPIDER_NET_RXINT) {
>  		spider_net_rx_irq_off(card);
>  		netif_rx_schedule(netdev);
>  	}
> -	if (status_reg & SPIDER_NET_TXINT ) {
> -		spider_net_cleanup_tx_ring(card);
> -		netif_wake_queue(netdev);
> -	}
>  
> -	if (status_reg & SPIDER_NET_ERRINT )
> +	/* Call rx_schedule from the tx interrupt, so that NAPI poll runs. */
> +	if (status_reg & SPIDER_NET_TXINT)
> +		netif_rx_schedule(netdev);
> +
> +	if (status_reg & SPIDER_NET_ERRINT)

This should be:

	if ((status_reg & (SPIDET_NET_RXINT | SPIDET_NET_TXINT))) {
		spider_net_rx_and_tx_irq_off(card);
		netif_rx_schedule();
	}
