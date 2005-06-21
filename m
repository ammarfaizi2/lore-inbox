Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVFUTMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVFUTMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVFUTMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:12:03 -0400
Received: from unused.mind.net ([69.9.134.98]:33973 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262212AbVFUTLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:11:41 -0400
Date: Tue, 21 Jun 2005 12:08:48 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050621131009.GA22691@elte.hu>
Message-ID: <Pine.LNX.4.58.0506211200130.16701@echo.lysdexia.org>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com>
 <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com>
 <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
 <20050621131009.GA22691@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Ingo Molnar wrote:

> i'm not sure it's related to the lockup - but there is a generic bug in 
> the driver, which in ns83820_tx_timeout() does:
> 
> 	local_irq_save(flags);
> 	...
> 	CALL do_tx_done()
> 
> 		spin_lock_irq(&dev->tx_lock);
> 		...
> 		spin_unlock_irq(&dev->tx_lock); // [1]
> 	...
> 	local_irq_restore(flags); // [2]
> 
> this leads to interrupts being enabled at [1], while the intention was 
> to enable them at [2]. To solve this bug we can do the tx-locking in 
> ns83820_tx_timeout(). (local_irq_disable() use in ns83820_tx_timeout() 
> was probably SMP-unsafe too, but needs a rare race.)
> 
> find the patch below - it's also included in the -50-05 -RT tree i just 
> uploaded. Can you confirm that you dont get the warnings in the -50-05 
> (and later) -RT kernels?
> 
> 	Ingo

-48-37 still gave the warnings on ns83820_tx_timeout(), but otherwise ran
for a day without any lockups or loss of network or keyboard.  No warnings 
so far with -50-06.  I'll keep you posted.


--ww <weston@sysex.net>


> Index: drivers/net/ns83820.c
> ===================================================================
> --- drivers/net/ns83820.c.orig
> +++ drivers/net/ns83820.c
> @@ -1013,8 +1013,6 @@ static void do_tx_done(struct net_device
>  	struct ns83820 *dev = PRIV(ndev);
>  	u32 cmdsts, tx_done_idx, *desc;
>  
> -	spin_lock_irq(&dev->tx_lock);
> -
>  	dprintk("do_tx_done(%p)\n", ndev);
>  	tx_done_idx = dev->tx_done_idx;
>  	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
> @@ -1070,7 +1068,6 @@ static void do_tx_done(struct net_device
>  		netif_start_queue(ndev);
>  		netif_wake_queue(ndev);
>  	}
> -	spin_unlock_irq(&dev->tx_lock);
>  }
>  
>  static void ns83820_cleanup_tx(struct ns83820 *dev)
> @@ -1371,7 +1368,9 @@ static void ns83820_do_isr(struct net_de
>  	 * work has accumulated
>  	 */
>  	if ((ISR_TXDESC | ISR_TXIDLE | ISR_TXOK | ISR_TXERR) & isr) {
> +		spin_lock_irq(&dev->tx_lock);
>  		do_tx_done(ndev);
> +		spin_unlock_irq(&dev->tx_lock);
>  
>  		/* Disable TxOk if there are no outstanding tx packets.
>  		 */
> @@ -1456,7 +1455,7 @@ static void ns83820_tx_timeout(struct ne
>          u32 tx_done_idx, *desc;
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&dev->tx_lock, flags);
>  
>  	tx_done_idx = dev->tx_done_idx;
>  	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
> @@ -1483,7 +1482,7 @@ static void ns83820_tx_timeout(struct ne
>  		ndev->name,
>  		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[DESC_CMDSTS]));
>  
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&dev->tx_lock, flags);
>  }
>  
> 
