Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSKTWek>; Wed, 20 Nov 2002 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKTWek>; Wed, 20 Nov 2002 17:34:40 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:3795 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S262887AbSKTWei>; Wed, 20 Nov 2002 17:34:38 -0500
Date: Wed, 20 Nov 2002 16:43:19 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
Message-ID: <20021120164319.A26918@vger.timpanogas.org>
References: <15835.56316.564937.169193@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15835.56316.564937.169193@robur.slu.se>; from Robert.Olsson@data.slu.se on Wed, Nov 20, 2002 at 08:01:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Need another fix.  You need to reinstrument the tasklet schedule in the 
fill_rx_ring instread of doing the whole thing from interrupt.  When the 
system is loaded at 100% saturation on gigbit with 300 byte packets or 
smaller, the driver does not allow any processes to run, and you cannot 
log in via ssh or any user space apps.  This is severely busted.   

The later versions of the driver > 4.3.15 all exhibit this behavior and 
are extremely broken.

Jeff



On Wed, Nov 20, 2002 at 08:01:16PM +0100, Robert Olsson wrote:
> 
> 
> Two fixes the NAPI branch of e1000.
> 
> 
> 1) e1000_irq_disable was used to disable irqs which called synchronize_irq
>    which in turn caused a solid hang on SMP systems.
> 
> 2) Interrupt acking patch previously sent by DaveM.
> 
> Cheers.
> 						--ro
> 
> 
> 
> --- linux/drivers/net/e1000.vanilla/e1000.h	2002-11-13 12:54:49.000000000 +0100
> +++ linux/drivers/net/e1000/e1000.h	2002-11-20 15:00:14.000000000 +0100
> @@ -181,6 +181,10 @@
>  	uint32_t tx_abs_int_delay;
>  	int max_data_per_txd;
>  
> +#ifdef CONFIG_E1000_NAPI
> +        uint32_t icr_pending;
> +#endif
> +
>  	/* RX */
>  	struct e1000_desc_ring rx_ring;
>  	uint64_t hw_csum_err;
> --- linux/drivers/net/e1000.vanilla/e1000_main.c	2002-11-13 12:54:49.000000000 +0100
> +++ linux/drivers/net/e1000/e1000_main.c	2002-11-20 17:37:55.000000000 +0100
> @@ -1896,15 +1896,29 @@
>  {
>  	struct net_device *netdev = data;
>  	struct e1000_adapter *adapter = netdev->priv;
> +	uint32_t icr;
> +	int i = E1000_MAX_INTR;
> +
>  	
>  #ifdef CONFIG_E1000_NAPI
> -	if (netif_rx_schedule_prep(netdev)) {
> -		e1000_irq_disable(adapter);
> +	icr = E1000_READ_REG(&adapter->hw, ICR);
> +	if (icr && netif_rx_schedule_prep(netdev)) {
> +
> +	        /* Disable interrupts */
> +                atomic_inc(&adapter->irq_sem);
> +                E1000_WRITE_REG(&adapter->hw, IMC, ~0);
> +
> +		/*      E1000_WRITE_FLUSH(&adapter->hw); 
> +		 * E1000_READ below syncs it  --ro
> +		 */
> +
>  		__netif_rx_schedule(netdev);
> + 
> +		adapter->icr_pending = icr;
> +		while (i-- && (icr = E1000_READ_REG(&adapter->hw, ICR)) != 0)
> +		         adapter->icr_pending |= icr;
>  	}
>  #else
> -	uint32_t icr;
> -	int i = E1000_MAX_INTR;
>  
>  	while(i && (icr = E1000_READ_REG(&adapter->hw, ICR))) {
>  
> @@ -1930,7 +1944,15 @@
>  	int i = E1000_MAX_INTR;
>  	int hasReceived = 0;
>  
> -	while(i && (icr = E1000_READ_REG(&adapter->hw, ICR))) {
> +        while(i) {
> +                if (adapter->icr_pending) {
> +                        icr = adapter->icr_pending;
> +                        adapter->icr_pending = 0;
> +                } else
> +                        icr = E1000_READ_REG(&adapter->hw, ICR);
> +                if (!icr)
> +                        break;
> +
>  		if (icr & E1000_ICR_RXT0)
>  			hasReceived = 1;
>   
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
