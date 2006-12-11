Return-Path: <linux-kernel-owner+w=401wt.eu-S1762639AbWLKHqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762639AbWLKHqe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 02:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762640AbWLKHqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 02:46:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55518 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762639AbWLKHqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 02:46:34 -0500
Date: Sun, 10 Dec 2006 23:45:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       lenb@kernel.org, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org
Subject: Re: [patch] net: dev_watchdog() locking fix
Message-Id: <20061210234508.cd83a784.akpm@osdl.org>
In-Reply-To: <20061209.140205.126778911.davem@davemloft.net>
References: <20061207210657.GA23229@gondor.apana.org.au>
	<20061208151902.4c8bb012.akpm@osdl.org>
	<20061208235952.GA4693@gondor.apana.org.au>
	<20061209.140205.126778911.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Dec 2006 14:02:05 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Sat, 9 Dec 2006 10:59:52 +1100
> 
> > On Fri, Dec 08, 2006 at 03:19:02PM -0800, Andrew Morton wrote:
> > > 
> > > Like this?
> > > 
> > > 	/* don't get messages out of order, and no recursion */
> > > 	if (skb_queue_len(&npinfo->txq) == 0 &&
> > > 		    npinfo->poll_owner != smp_processor_id()) {
> > > 		local_bh_disable();	/* Where's netif_tx_trylock_bh()? */
> > > 		if (netif_tx_trylock(dev)) {
> > > 			/* try until next clock tick */
> > > 			for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
> > > 					tries > 0; --tries) {
> > > 				if (!netif_queue_stopped(dev))
> > > 					status = dev->hard_start_xmit(skb, dev);
> > > 
> > > 				if (status == NETDEV_TX_OK)
> > > 					break;
> > > 
> > > 				/* tickle device maybe there is some cleanup */
> > > 				netpoll_poll(np);
> > > 
> > > 				udelay(USEC_PER_POLL);
> > > 			}
> > > 			netif_tx_unlock(dev);
> > > 		}
> > > 		local_bh_enable();
> > > 	}
> > 
> > Looks good to me.  Thanks Andrew!
> 
> I've applied this patch, thanks a lot.

It spits a nasty during bringup

e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
netconsole: device eth0 not up yet, forcing it
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
WARNING (!__warned) at kernel/softirq.c:137 local_bh_enable()

Call Trace:
 [<ffffffff80235baf>] local_bh_enable+0x41/0xa3
 [<ffffffff8045ab8e>] netpoll_send_skb+0x116/0x144
 [<ffffffff8045b1ee>] netpoll_send_udp+0x263/0x271
 [<ffffffff803d41ec>] write_msg+0x42/0x5e
 [<ffffffff80230c9b>] __call_console_drivers+0x5f/0x70
 [<ffffffff80230d19>] _call_console_drivers+0x6d/0x71
 [<ffffffff802313f0>] release_console_sem+0x148/0x1ec
 [<ffffffff802316ce>] register_console+0x1b1/0x1ba
 [<ffffffff803d4178>] init_netconsole+0x54/0x68
 [<ffffffff802071ae>] init+0x152/0x308
 [<ffffffff804dac8b>] _spin_unlock_irq+0x14/0x30
 [<ffffffff8022c15e>] schedule_tail+0x43/0x9f
 [<ffffffff8020a758>] child_rip+0xa/0x12
 [<ffffffff8020705c>] init+0x0/0x308
 [<ffffffff8020a74e>] child_rip+0x0/0x12

because local irqs are disabled.  
