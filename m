Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWFCUjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWFCUjH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 16:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWFCUjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 16:39:06 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:24217 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030333AbWFCUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 16:39:05 -0400
Subject: Re: [patch 3/5] [PREEMPT_RT] Changing interrupt handlers from
	running in thread to hardirq and back runtime.
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0606022322010.9307@localhost>
References: <20060602165336.147812000@localhost>
	 <Pine.LNX.4.64.0606022322010.9307@localhost>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 16:39:00 -0400
Message-Id: <1149367140.13993.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 23:23 +0100, Esben Nielsen wrote:
> Makes it possible for the e100 ethernet driver to have it's interrupt handler
> in both hard-irq and threaded context under PREEMPT_RT.
> 
> Index: linux-2.6.16-rt23.spin_mutex/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.16-rt23.spin_mutex.orig/drivers/net/e100.c
> +++ linux-2.6.16-rt23.spin_mutex/drivers/net/e100.c
> @@ -530,7 +530,7 @@ struct nic {
>   	enum ru_state ru_running;
> 
>   	spinlock_t cb_lock			____cacheline_aligned;
> -	spinlock_t cmd_lock;
> +	spin_mutex_t cmd_lock;
>   	struct csr __iomem *csr;
>   	enum scb_cmd_lo cuc_cmd;
>   	unsigned int cbs_avail;
> @@ -1950,6 +1950,30 @@ static int e100_rx_alloc_list(struct nic
>   	return 0;
>   }
> 
> +static int e100_change_context(int irq, void *dev_id,
> +			       enum change_context_cmd cmd)
> +{
> +	struct net_device *netdev = dev_id;
> +	struct nic *nic = netdev_priv(netdev);
> +
> +	switch(cmd)
> +	{
> +	case IRQ_TO_HARDIRQ:
> +		if(!spin_mutexes_can_spin())
> +			return -ENOSYS;
> +
> +		spin_mutex_to_spin(&nic->cmd_lock);
> +		break;
> +	case IRQ_CAN_THREAD:
> +		/* Ok - return 0 */
> +		break;

Why even bother with the IRQ_CAN_THREAD.  If this would be anything
other than OK, then we shouldn't be using that request_irq2 (yuck!) call
in the first place.

-- Steve

> +	case IRQ_TO_THREADED:
> +		spin_mutex_to_mutex(&nic->cmd_lock);
> +		break;
> +	}
> +	return 0; /* Ok */
> +}
> +
>   static irqreturn_t e100_intr(int irq, void *dev_id, struct pt_regs *regs)
>   {
>   	struct net_device *netdev = dev_id;
> @@ -2064,9 +2088,12 @@ static int e100_up(struct nic *nic)
>   	e100_set_multicast_list(nic->netdev);
>   	e100_start_receiver(nic, NULL);
>   	mod_timer(&nic->watchdog, jiffies);
> -	if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
> -		nic->netdev->name, nic->netdev)))
> +	if((err = request_irq2(nic->pdev->irq, e100_intr,
> +			       SA_SHIRQ|SA_MUST_THREAD_RT,
> +			       nic->netdev->name, nic->netdev,
> +			       e100_change_context)))
>   		goto err_no_irq;
> +
>   	netif_wake_queue(nic->netdev);
>   	netif_poll_enable(nic->netdev);
>   	/* enable ints _after_ enabling poll, preventing a race between
> 


