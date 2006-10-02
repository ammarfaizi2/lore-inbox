Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWJBLBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWJBLBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWJBLBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:01:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58446 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750789AbWJBLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:00:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=tLwIqrYWjHReC5Lu0Kv9v0adFrpA2S+5lIqrLu7HUWQa4dmbckFuQQyV+NAI4A/i2oVtnfxDYRwq4zdaKLbnD5GtFINsXqKARmBkZtXCbugPHwFAFQtGMfNmmEbno+SUMALmGl7v599LdBQGiYv7L4oZdgcsmNEfKj2OMH8QRI0=
Date: Mon, 2 Oct 2006 12:59:29 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [PATCH 5/5] Solve host error problem in low performance embedded system when continune down and up.
Message-ID: <20061002125929.GB3003@slug>
References: <1159813596.2576.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159813596.2576.8.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 02:26:36PM -0400, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Change Logs:
> Solve host error problem in low performance embedded system when continune down and up.
> 
> Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
> ---
> 
>  drivers/net/sundance.c |   26 +++++++++++++++++++++++---
>  1 files changed, 23 insertions(+), 3 deletions(-)
> 
> c06c70e20a85facd640528ca66e0b579fc3ee745
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> index 14b4933..b4a6010 100755
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -1643,6 +1643,14 @@ static int netdev_close(struct net_devic
>  	struct sk_buff *skb;
>  	int i;
>  
> +	/* Wait and kill tasklet */
> +	tasklet_kill(&np->rx_tasklet);
> +	tasklet_kill(&np->tx_tasklet);
> +	np->cur_tx = 0;
> +	np->dirty_tx = 0;
> +	np->cur_task = 0;
> +	np->last_tx = 0;
> +
>  	netif_stop_queue(dev);
>  
>  	if (netif_msg_ifdown(np)) {
> @@ -1663,9 +1671,20 @@ static int netdev_close(struct net_devic
>  	/* Stop the chip's Tx and Rx processes. */
>  	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
>  
> -	/* Wait and kill tasklet */
> -	tasklet_kill(&np->rx_tasklet);
> -	tasklet_kill(&np->tx_tasklet);
> +    	for (i = 2000; i > 0; i--) {
> + 		if ((ioread32(ioaddr + DMACtrl) &0xC000) == 0)
                                                ^^^^^^^
Missing white space?
> +			break;
> +		mdelay(1);
> +    	}
> +
> +    	iowrite16(GlobalReset | DMAReset | FIFOReset | NetworkReset, ioaddr +ASICCtrl + 2);
                                                                            ^^^^^^^^^
Same here..
> +
> +    	for (i = 2000; i > 0; i--)
> +    	{
> + 		if ((ioread16(ioaddr + ASICCtrl +2) &ResetBusy) == 0)
                                                    ^^^^^^^^^^
.. and here
> +			break;
> +		mdelay(1);
> +    	}
>  
Regards,
Frederik
