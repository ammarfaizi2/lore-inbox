Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWHRLR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHRLR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWHRLR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:17:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2520 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932401AbWHRLR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:17:56 -0400
Message-ID: <44E5A1E1.1060500@pobox.com>
Date: Fri, 18 Aug 2006 07:17:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 6/6] IP100A Solve host error problem when in low	performance
 embedded
References: <1155841780.4532.21.camel@localhost.localdomain>
In-Reply-To: <1155841780.4532.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Solve host error problem when in low performance embedded
> 
> Change Logs:
>     Solve host error problem when in low performance embedded
> 
> ---
> 
>  drivers/net/sundance.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
> 
> 78ff57ea887c19b7552342e990375f5e2bb10af9
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> index c7c22f0..94ba6ca 100755
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -1075,7 +1075,7 @@ reset_tx (struct net_device *dev)
>  	struct sk_buff *skb;
>  	int i;
>  	int irq = in_interrupt();
> -	
> +	tasklet_kill(&np->tx_tasklet);

NAK, it is a bug to call tasklet_kill() from inside an interrupt.


> @@ -1646,6 +1646,13 @@ static int netdev_close(struct net_devic
>  	struct sk_buff *skb;
>  	int i;
>  
> +	/* Wait and kill tasklet */
> +	tasklet_kill(&np->rx_tasklet);
> +	tasklet_kill(&np->tx_tasklet);
> +   np->cur_tx = np->dirty_tx = 0;

fix source code indent


> +	np->cur_task = 0;
> +	np->last_tx=0;

needs whitespace:  s/=/ = /


>  	netif_stop_queue(dev);
>  
>  	if (netif_msg_ifdown(np)) {
> @@ -1666,9 +1673,19 @@ static int netdev_close(struct net_devic
>  	/* Stop the chip's Tx and Rx processes. */
>  	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
>  
> -	/* Wait and kill tasklet */
> -	tasklet_kill(&np->rx_tasklet);
> -	tasklet_kill(&np->tx_tasklet);
> +    for(i=2000;i> 0;i--) {
> +		if((readl(ioaddr + DMACtrl)&0xC000) == 0)break;
> +		mdelay(1);
> +    }	

(1) fix indentation

(2) add whitespace to 'for' loop

(3) use ioread32(), not readl()

(4) are you certain that DMACtrl should be read as a 32-bit register? 
In other code, you treat it as a 16-bit register.



> +    writew(GlobalReset | DMAReset | FIFOReset |NetworkReset, ioaddr +ASICCtrl + 2);

(5) use iowrite16() not writew()


> +    for(i=2000;i >0;i--)
> +    {
> +		if((readw(ioaddr + ASICCtrl +2)&ResetBusy) == 0)
> +	    	break;
> +		mdelay(1);
> +    }

(6) fix indentation to match the rest of the driver

(7) use ioread16(), not readw()

(8) add whitespace to 'for' loop


>  #ifdef __i386__
>  	if (netif_msg_hw(np)) {
> @@ -1706,6 +1723,7 @@ #endif /* __i386__ debugging only */
>  		}
>  	}
>  	for (i = 0; i < TX_RING_SIZE; i++) {
> +		np->tx_ring[i].next_desc=0;		

(9) add whitespace to assignment:  s/=/ = /


>  		skb = np->tx_skbuff[i];
>  		if (skb) {
>  			pci_unmap_single(np->pci_dev,

