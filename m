Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWBBL3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWBBL3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWBBL3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:29:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11436 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750701AbWBBL3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:29:01 -0500
Date: Thu, 2 Feb 2006 12:27:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202112731.GA11603@elte.hu>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au> <20060202074627.GA6805@elte.hu> <20060202084824.GA17299@gondor.apana.org.au> <20060202105429.GA4895@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202105429.GA4895@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> hm, i got a new one:
> 
> ============================================
> [ BUG: circular locking deadlock detected! ]
> --------------------------------------------
> sshd/28997 is trying to acquire lock:
>  (&sk->sk_lock.slock){-+}, at: [<c0c6be28>] packet_rcv+0xbf/0x34b
> 
> but task is already holding lock:
>  (&dev->xmit_lock){-+}, at: [<c0bb04ec>] qdisc_restart+0x46/0x207
> 
> which lock already depends on the new lock,
> which could lead to circular deadlocks!
> 
> the dependency chain (in reverse order) is:
> -> #2 (&dev->xmit_lock){-+}: [<c0bb04ec>] qdisc_restart+0x46/0x207
> -> #1 (&dev->queue_lock){-+}: [<c0b98137>] dev_queue_xmit+0xc3/0x21e
> -> #0 (&sk->sk_lock.slock){-+}: [<c0c6be28>] packet_rcv+0xbf/0x34b

i think this might be a false positive, caused by my (ill-advised) 
change below? [i did the change to clean up an unlock ordering 
assymetry, but apparently i thus also introduced the xmit_lock -> 
queue_lock dependency.]

	Ingo

Index: linux/net/sched/sch_generic.c
===================================================================
--- linux.orig/net/sched/sch_generic.c
+++ linux/net/sched/sch_generic.c
@@ -98,6 +98,8 @@ int qdisc_restart(struct net_device *dev
 	/* Dequeue packet */
 	if ((skb = q->dequeue(q)) != NULL) {
 		unsigned nolock = (dev->features & NETIF_F_LLTX);
+		/* release queue */
+		spin_unlock(&dev->queue_lock);
 		/*
 		 * When the driver has LLTX set it does its own locking
 		 * in start_xmit. No need to add additional overhead by
@@ -121,9 +123,11 @@ int qdisc_restart(struct net_device *dev
 					kfree_skb(skb);
 					if (net_ratelimit())
 						printk(KERN_DEBUG "Dead loop on netdevice %s, fix it urgently!\n", dev->name);
+					spin_lock(&dev->queue_lock);
 					return -1;
 				}
 				__get_cpu_var(netdev_rx_stat).cpu_collision++;
+				spin_lock(&dev->queue_lock);
 				goto requeue;
 			}
 			/* Remember that the driver is grabbed by us. */
@@ -131,8 +135,6 @@ int qdisc_restart(struct net_device *dev
 		}
 		
 		{
-			/* And release queue */
-			spin_unlock(&dev->queue_lock);
 
 			if (!netif_queue_stopped(dev)) {
 				int ret;
