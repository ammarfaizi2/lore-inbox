Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbTHaI2m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 04:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTHaI2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 04:28:42 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:27307 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262014AbTHaI2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 04:28:40 -0400
Message-ID: <3F51B1A3.4080307@colorfullife.com>
Date: Sun, 31 Aug 2003 10:28:19 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
CC: linux-kernel@vger.kernel.org, rnp@netlink.co.nz
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe wrote:

>Also, the down/up function doesn't seem to be 
>used in interrupt context, so I think it will work.
>  
>
[snip]

> static int mc32_send_packet(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
>-	unsigned long flags;
> 
> 	volatile struct skb_header *p, *np;
> 
> 	netif_stop_queue(dev);
> 
>-	save_flags(flags);
>-	cli();
>+	down(&lp->mc32_sem);
>  
>
No, that's wrong. mc32_send_packet is the hard_start_xmit function, 
called from bottom half context, with the dev_xmit_lock spinlock held.
Additionally, you must replace the sleep_on calls with wait_event, or an 
open-coded wait queue: sleep_on is racy, it only works with cli().

IMHO the right way to fix cli() is
- add a single spinlock to the driver or the device structure. Do not 
forget the spin_lock_init().
- replace cli/sti with spin_lock_irqsave/spin_unlock_irqsave.
- Additionally acquire the spinlock in every interrupt handler (cli() 
stops all interrupts, spinlocks only stop interrupt on the current cpu).
- check if there were recursive cli() calls. Fix them.
- replace all sleep_on calls with wait queue calls.
- check if there are any kmalloc or schedule calls in the area now under 
the spinlock, and reorganize the code.

And please add a changelog entry that code was converted without testing.

--
    Manfred

