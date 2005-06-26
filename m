Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFZMls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFZMls (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 08:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFZMls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 08:41:48 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:27398 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261205AbVFZMj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 08:39:59 -0400
X-ME-UUID: 20050626123954921.E0DD01C0015E@mwinf0907.wanadoo.fr
Message-ID: <20935204.1119789594907.JavaMail.www@wwinf0901>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com, pascal.chapperon@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.14.41.59]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Sun, 26 Jun 2005 14:39:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 22/06/05 01:02
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
> I have copied the sis190 patches at http://www.zoreil.com/~romieu/sis190
> if someone wants to hack them in the meantime.

1) sis190 freezes the box when kernel PREEMPT is enabled :

I made many tries, but i could not solve it;
- it does not occur while receiving huge files.
- it does not occur when only a few packets are
  transmitted (remote connection, ls, find)
- it occurs only while transmiting huge files AND
  trying to do someting else (open a new term,...)
- I could transfer a huge file (700MB) several times
  as i was at the console (and i could switch to another
console to perform find, ls,... during the transfer).

I managed the system so the sis190 had its own IRQ, but it
made no difference.

As i suspected nvidia driver, i switched to nv driver : no result.

It seems to me that a task inside the sis190_tx_interrupt() is 
not protected against preemption (and it is probably the same
on a SMP not prempted).

I tried to play with spinlocks, but with no result :
@@ -621,6 +621,7 @@ static irqreturn_t sis190_interrupt(int
        void __iomem *ioaddr = tp->mmio_addr;
        int handled = 0;
        int boguscnt;
+       unsigned long flags;

        for (boguscnt = max_interrupt_work; boguscnt > 0; boguscnt--) {
                u32 status = SIS_R32(IntrStatus);
@@ -651,9 +652,9 @@ static irqreturn_t sis190_interrupt(int
                        sis190_rx_interrupt(dev, tp, ioaddr);

                if (status & TxQ0Int) {
-                       spin_lock(&tp->lock);
+                       spin_lock_irqsave(&tp->lock, flags);
                        sis190_tx_interrupt(dev, tp, ioaddr);
-                       spin_unlock(&tp->lock);
+                       spin_unlock_irqrestore(&tp->lock, flags);
                }
        }


or :



@@ -581,6 +581,7 @@ static void sis190_tx_interrupt(struct n
                                struct sis190_private *tp, void __iomem *ioaddr)
 {
        unsigned int tx_left, dirty_tx = tp->dirty_tx;
+       unsigned long flags;

        for (tx_left = tp->cur_tx - dirty_tx; tx_left > 0; tx_left--) {
                unsigned int entry = dirty_tx % NUM_TX_DESC;
@@ -604,10 +605,12 @@ static void sis190_tx_interrupt(struct n
                dirty_tx++;
        }

+       spin_lock_irqsave(&tp->lock, flags);
        if (tp->dirty_tx != dirty_tx) {
                tp->dirty_tx = dirty_tx;
                netif_wake_queue(dev);
        }
+       spin_unlock_irqrestore(&tp->lock, flags);
 }

 /*
@@ -651,9 +654,7 @@ static irqreturn_t sis190_interrupt(int
                        sis190_rx_interrupt(dev, tp, ioaddr);

                if (status & TxQ0Int) {
-                       spin_lock(&tp->lock);
                        sis190_tx_interrupt(dev, tp, ioaddr);
-                       spin_unlock(&tp->lock);
                }
        }




In fact, i don't know where are the critical sections...

2) sis190 freezes the box when the link partner is
a r8169 forced in 10 full autoneg off (preempted or not
preempted kernel) :

it is probably for the same reason, as it occurs only when 
transmitting a big file.

3) poor TX performances when link partner is forced to 
autoneg off (not preempted kernel):

Once again it seems that something goes wrong with TX tasks...


Regards
Pascal


