Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946482AbWJTUsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946482AbWJTUsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946481AbWJTUsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:48:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946457AbWJTUsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:48:30 -0400
Date: Fri, 20 Oct 2006 13:48:26 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020134826.75dd1cba@freekitty>
In-Reply-To: <20061020.134209.85688168.davem@davemloft.net>
References: <20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
	<20061020084015.5c559326@localhost.localdomain>
	<20061020.134209.85688168.davem@davemloft.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 13:42:09 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 20 Oct 2006 08:40:15 -0700
> 
> > -static void queue_process(void *p)
> > +static void netpoll_run(unsigned long arg)
> >  {
>  ...
> > -		spin_unlock_irqrestore(&queue_lock, flags);
> > +		netif_tx_lock(dev);
> > +		if (netif_queue_stopped(dev) ||
> > +		    dev->hard_start_xmit(skb, dev) != NETDEV_TX_OK) {
> > +			skb_queue_head(&npinfo->tx_q, skb);
> > +			netif_tx_unlock(dev);
> > +			tasklet_schedule(&npinfo->tx_task);
> > +			return;
> > +		}
> 
> We really can't handle TX stopped this way from the netpoll_send_skb()
> path.  All that old retry logic in netpoll_send_skb() is really
> necessary.
> 
> If we are in deep IRQ context, took an OOPS, and are trying to get a
> netpoll packet out for the kernel log message, we have to try as hard
> as possible to get the packet out then and there, even if that means
> waiting some amount of time for netif_queue_stopped() to become false.
> 

But, it also violates the assumptions of the network devices.
It calls NAPI poll back with IRQ's disabled and potentially doesn't
obey the semantics about only running on the same CPU as the
received packet.

> That is what the existing code is trying to do.
> 
> If you defer to a tasklet, the kernel state from the OOPS can be so
> corrupted that the tasklet will never run and we'll never get the
> netconsole message needed to debug the problem.

So we can try once and if that fails we have to defer to tasklet.
We can't call NAPI, we can't try and cleanup the device will need
an IRQ to get unblocked.  

Or add another device callback that just to handle that case.

> Also, if we tasklet schedule from the tasklet, we'll just keep looping
> in the tasklet and never leave softirq context, which is also bad
> behavior.  Even in the tasklet, we should spin and poll when possible
> like the current netpoll_send_skb() code does.
> 
> So we really can't apply this patch.


-- 
Stephen Hemminger <shemminger@osdl.org>
