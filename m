Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVF3XkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVF3XkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVF3XkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:40:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:47744 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263125AbVF3Xjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:39:54 -0400
Date: Fri, 1 Jul 2005 01:37:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050630233732.GA16886@electric-eye.fr.zoreil.com>
References: <20935204.1119789594907.JavaMail.www@wwinf0901>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20935204.1119789594907.JavaMail.www@wwinf0901>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> 1) sis190 freezes the box when kernel PREEMPT is enabled :
> 
> I made many tries, but i could not solve it;
> - it does not occur while receiving huge files.
> - it does not occur when only a few packets are
>   transmitted (remote connection, ls, find)
> - it occurs only while transmiting huge files AND
>   trying to do someting else (open a new term,...)
> - I could transfer a huge file (700MB) several times
>   as i was at the console (and i could switch to another
> console to perform find, ls,... during the transfer).

Are you saying that PREEMPT and X are both needed to freeze the box ?

If so, could you try preempt + console + rsync (+ dd from disk) ?

> I managed the system so the sis190 had its own IRQ, but it
> made no difference.
> 
> As i suspected nvidia driver, i switched to nv driver : no result.

Please keep binary modules out of the loop until the things are stable.
I do not want to try and diagnose a bug in a system wherein such an amount
of unknown code was loaded (even if it was unloaded later).

> It seems to me that a task inside the sis190_tx_interrupt() is 
> not protected against preemption (and it is probably the same
> on a SMP not prempted).
> 
> I tried to play with spinlocks, but with no result :
> @@ -621,6 +621,7 @@ static irqreturn_t sis190_interrupt(int
>         void __iomem *ioaddr = tp->mmio_addr;
>         int handled = 0;
>         int boguscnt;
> +       unsigned long flags;
> 
>         for (boguscnt = max_interrupt_work; boguscnt > 0; boguscnt--) {
>                 u32 status = SIS_R32(IntrStatus);
> @@ -651,9 +652,9 @@ static irqreturn_t sis190_interrupt(int
>                         sis190_rx_interrupt(dev, tp, ioaddr);
> 
>                 if (status & TxQ0Int) {
> -                       spin_lock(&tp->lock);
> +                       spin_lock_irqsave(&tp->lock, flags);
>                         sis190_tx_interrupt(dev, tp, ioaddr);
> -                       spin_unlock(&tp->lock);
> +                       spin_unlock_irqrestore(&tp->lock, flags);

Afaik the irq handler is already protected against reentrancy (see
kernel/irq.c::__do_IRQ) and softirq (see arch/xxx/kernel/irq.c::irq_exit).
So this change should not make a difference.

[...]
> @@ -581,6 +581,7 @@ static void sis190_tx_interrupt(struct n
>                                 struct sis190_private *tp, void __iomem *ioaddr)
>  {
>         unsigned int tx_left, dirty_tx = tp->dirty_tx;
> +       unsigned long flags;
> 
>         for (tx_left = tp->cur_tx - dirty_tx; tx_left > 0; tx_left--) {
>                 unsigned int entry = dirty_tx % NUM_TX_DESC;
> @@ -604,10 +605,12 @@ static void sis190_tx_interrupt(struct n
>                 dirty_tx++;
>         }
> 
> +       spin_lock_irqsave(&tp->lock, flags);
>         if (tp->dirty_tx != dirty_tx) {
>                 tp->dirty_tx = dirty_tx;
>                 netif_wake_queue(dev);
>         }
> +       spin_unlock_irqrestore(&tp->lock, flags);
>  }

The irqsave/restore should not be needed for the same reason as above.

> In fact, i don't know where are the critical sections...

In the Tx path the critical section is related to netif_{start/stop}_queue.

> 2) sis190 freezes the box when the link partner is
> a r8169 forced in 10 full autoneg off (preempted or not
> preempted kernel) :

The r8169 driver will not necessarily do what you would expect when you
autoneg it off and it faces an unstable driver. I'll send an update for it.

Any TX timeout message on the console ? Freeze == sysrq has no effect
and keyboard leds do not blink any more ?

There is an updated version at 
http://www.zoreil.com/~romieu/sis190/20050630-2.6.13-rc1-sis190-test.patch

It would be nice to know how it behaves wrt preempt (no need to experiment
with the media management), especially if you can describe the freeze more
specifically.

--
Ueimor
