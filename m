Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVATPTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVATPTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVATPTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:19:04 -0500
Received: from modemcable240.48-200-24.mc.videotron.ca ([24.200.48.240]:58501
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262085AbVATPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:18:54 -0500
Date: Thu, 20 Jan 2005 10:18:43 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Ian Campbell <icampbell@arcom.com>
cc: akpm@osdl.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smc91x: power down PHY on suspend
In-Reply-To: <1106223217.19123.26.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0501201018040.5315@localhost.localdomain>
References: <1106223217.19123.26.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, Ian Campbell wrote:

> Hi,
> 
> Powering down the PHY saves something like 100mA at 5V on my platform.
> Currently it is only done when the interface is brought down but it
> makes sense to do it on suspend as well. 
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>

Signed-off-by: Nicolas Pitre <nico@cam.org>

> 
> Index: 2.6/drivers/net/smc91x.c
> ===================================================================
> --- 2.6.orig/drivers/net/smc91x.c	2005-01-17 11:04:43.000000000 +0000
> +++ 2.6/drivers/net/smc91x.c	2005-01-20 12:11:09.292758475 +0000
> @@ -1013,13 +1008,29 @@
>  /*
>   * smc_phy_powerdown - powerdown phy
>   * @dev: net device
> - * @phy: phy address
>   *
>   * Power down the specified PHY
>   */
> -static void smc_phy_powerdown(struct net_device *dev, int phy)
> +static void smc_phy_powerdown(struct net_device *dev)
>  {
> +	struct smc_local *lp = netdev_priv(dev);
>  	unsigned int bmcr;
> +	int phy = lp->mii.phy_id;
> +
> +	if (lp->phy_type == 0)
> +		return;
> +
> +	/* We need to ensure that no calls to smc_phy_configure are
> +	   pending.
> +
> +	   flush_scheduled_work() cannot be called because we are
> +	   running with the netlink semaphore held (from
> +	   devinet_ioctl()) and the pending work queue contains
> +	   linkwatch_event() (scheduled by netif_carrier_off()
> +	   above). linkwatch_event() also wants the netlink semaphore.
> +	*/
> +	while(lp->work_pending)
> +		schedule();
>  
>  	bmcr = smc_phy_read(dev, phy, MII_BMCR);
>  	smc_phy_write(dev, phy, MII_BMCR, bmcr | BMCR_PDOWN);
> @@ -1544,21 +1555,7 @@
>  	/* clear everything */
>  	smc_shutdown(dev);
>  
> -	if (lp->phy_type != 0) {
> -		/* We need to ensure that no calls to
> -		   smc_phy_configure are pending.
> -
> -		   flush_scheduled_work() cannot be called because we
> -		   are running with the netlink semaphore held (from
> -		   devinet_ioctl()) and the pending work queue
> -		   contains linkwatch_event() (scheduled by
> -		   netif_carrier_off() above). linkwatch_event() also
> -		   wants the netlink semaphore.
> -		*/
> -		while(lp->work_pending)
> -			schedule();
> -		smc_phy_powerdown(dev, lp->mii.phy_id);
> -	}
> +	smc_phy_powerdown(dev);
>  
>  	if (lp->pending_tx_skb) {
>  		dev_kfree_skb(lp->pending_tx_skb);
> @@ -2176,6 +2179,7 @@
>  		if (netif_running(ndev)) {
>  			netif_device_detach(ndev);
>  			smc_shutdown(ndev);
> +			smc_phy_powerdown(ndev);
>  		}
>  	}
>  	return 0;
> 
> 
> 
> -- 
> Ian Campbell, Senior Design Engineer
>                                         Web: http://www.arcom.com
> Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
> Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200
> 


Nicolas
