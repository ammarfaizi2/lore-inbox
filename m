Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVFUNSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFUNSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVFUNPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:15:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38059 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261376AbVFUNMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:12:41 -0400
Date: Tue, 21 Jun 2005 15:10:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050621131009.GA22691@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> Fortunately, there were some dumps (all ns83820 tx related) left in 
> the logs before the machine locked:

i'm not sure it's related to the lockup - but there is a generic bug in 
the driver, which in ns83820_tx_timeout() does:

	local_irq_save(flags);
	...
	CALL do_tx_done()

		spin_lock_irq(&dev->tx_lock);
		...
		spin_unlock_irq(&dev->tx_lock); // [1]
	...
	local_irq_restore(flags); // [2]

this leads to interrupts being enabled at [1], while the intention was 
to enable them at [2]. To solve this bug we can do the tx-locking in 
ns83820_tx_timeout(). (local_irq_disable() use in ns83820_tx_timeout() 
was probably SMP-unsafe too, but needs a rare race.)

find the patch below - it's also included in the -50-05 -RT tree i just 
uploaded. Can you confirm that you dont get the warnings in the -50-05 
(and later) -RT kernels?

	Ingo

Index: drivers/net/ns83820.c
===================================================================
--- drivers/net/ns83820.c.orig
+++ drivers/net/ns83820.c
@@ -1013,8 +1013,6 @@ static void do_tx_done(struct net_device
 	struct ns83820 *dev = PRIV(ndev);
 	u32 cmdsts, tx_done_idx, *desc;
 
-	spin_lock_irq(&dev->tx_lock);
-
 	dprintk("do_tx_done(%p)\n", ndev);
 	tx_done_idx = dev->tx_done_idx;
 	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
@@ -1070,7 +1068,6 @@ static void do_tx_done(struct net_device
 		netif_start_queue(ndev);
 		netif_wake_queue(ndev);
 	}
-	spin_unlock_irq(&dev->tx_lock);
 }
 
 static void ns83820_cleanup_tx(struct ns83820 *dev)
@@ -1371,7 +1368,9 @@ static void ns83820_do_isr(struct net_de
 	 * work has accumulated
 	 */
 	if ((ISR_TXDESC | ISR_TXIDLE | ISR_TXOK | ISR_TXERR) & isr) {
+		spin_lock_irq(&dev->tx_lock);
 		do_tx_done(ndev);
+		spin_unlock_irq(&dev->tx_lock);
 
 		/* Disable TxOk if there are no outstanding tx packets.
 		 */
@@ -1456,7 +1455,7 @@ static void ns83820_tx_timeout(struct ne
         u32 tx_done_idx, *desc;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&dev->tx_lock, flags);
 
 	tx_done_idx = dev->tx_done_idx;
 	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
@@ -1483,7 +1482,7 @@ static void ns83820_tx_timeout(struct ne
 		ndev->name,
 		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[DESC_CMDSTS]));
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dev->tx_lock, flags);
 }
 
