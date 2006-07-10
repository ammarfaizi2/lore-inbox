Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWGJTF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWGJTF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWGJTF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:05:56 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50877 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422775AbWGJTFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:05:55 -0400
Message-ID: <44B2A522.2080703@free.fr>
Date: Mon, 10 Jul 2006 21:06:10 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 inconsistent lock state in netpoll_send_skb
References: <20060709021106.9310d4d1.akpm@osdl.org>	 <44B17735.4060006@free.fr> <1152520823.4874.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1152520823.4874.0.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 10.07.2006 10:40, Arjan van de Ven a écrit :
> On Sun, 2006-07-09 at 23:37 +0200, Laurent Riffard wrote:
>> ei_start_xmit
> 
> please try this patch
> 
> ---
>  drivers/net/8390.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.17-mm4/drivers/net/8390.c
> ===================================================================
> --- linux-2.6.17-mm4.orig/drivers/net/8390.c
> +++ linux-2.6.17-mm4/drivers/net/8390.c
> @@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
>  	 *	Slow phase with lock held.
>  	 */
>  	 
> -	disable_irq_nosync(dev->irq);
> +	disable_irq_nosync_lockdep(dev->irq);
>  	
>  	spin_lock(&ei_local->page_lock);
>  	
> @@ -338,7 +338,7 @@ static int ei_start_xmit(struct sk_buff 
>  		netif_stop_queue(dev);
>  		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
>  		spin_unlock(&ei_local->page_lock);
> -		enable_irq(dev->irq);
> +		enable_irq_lockdep(dev->irq);
>  		ei_local->stat.tx_errors++;
>  		return 1;
>  	}
> @@ -379,7 +379,7 @@ static int ei_start_xmit(struct sk_buff 
>  	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
>  	
>  	spin_unlock(&ei_local->page_lock);
> -	enable_irq(dev->irq);
> +	enable_irq_lockdep(dev->irq);
>  
>  	dev_kfree_skb (skb);
>  	ei_local->stat.tx_bytes += send_length;
> @@ -505,9 +505,9 @@ irqreturn_t ei_interrupt(int irq, void *
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  void ei_poll(struct net_device *dev)
>  {
> -	disable_irq(dev->irq);
> +	disable_irq_lockdep(dev->irq);
>  	ei_interrupt(dev->irq, dev, NULL);
> -	enable_irq(dev->irq);
> +	enable_irq_lockdep(dev->irq);
>  }
>  #endif


Reversed (or previously applied) patch detected! 

Wrong patch ? This one won't apply, it seems to be already 
applied to 2.6.18-rc1-mm1.

-- 
laurent
