Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932193AbWFDIa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWFDIa4 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFDIa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:30:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57324 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932193AbWFDIaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:30:55 -0400
Date: Sun, 4 Jun 2006 10:30:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Barry K. Nathan" <barryn@pobox.com>,
        Arjan van de Ven <arjan@infradead.org>
Subject: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags bug
Message-ID: <20060604083017.GA8241@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: fix ns83820.c irq-flags bug
From: Ingo Molnar <mingo@elte.hu>

Barry K. Nathan reported the following lockdep warning:

[  197.343948] BUG: warning at kernel/lockdep.c:1856/trace_hardirqs_on()
[  197.345928]  [<c010329b>] show_trace_log_lvl+0x5b/0x105
[  197.346359]  [<c0103896>] show_trace+0x1b/0x20
[  197.346759]  [<c01038ed>] dump_stack+0x1f/0x24
[  197.347159]  [<c012efa2>] trace_hardirqs_on+0xfb/0x185
[  197.348873]  [<c029b009>] _spin_unlock_irq+0x24/0x2d
[  197.350620]  [<e09034e8>] do_tx_done+0x171/0x179 [ns83820]
[  197.350895]  [<e090445c>] ns83820_irq+0x149/0x20b [ns83820]
[  197.351166]  [<c013b4b8>] handle_IRQ_event+0x1d/0x52
[  197.353216]  [<c013c6c2>] handle_level_irq+0x97/0xe1
[  197.355157]  [<c01048c3>] do_IRQ+0x8b/0xac
[  197.355612]  [<c0102d9d>] common_interrupt+0x25/0x2c

this is caused because the ns83820 driver re-enables irq flags
in hardirq context.

While legal in theory, in practice it should only be done if the
hardware is really old and has some very high overhead in its ISR.
(such as PIO IDE)

For modern hardware, running ISRs with irqs enabled is discouraged,
because 1) new hardware is fast enough to not cause latency problems
2) allowing the nesting of hardware interrupts only 'spreads out'
the handling of the current ISR, causing extra cachemisses that would
otherwise not happen. Furthermore, on architectures where ISRs share
the kernel stacks, enabling interrupts in ISRs introduces a much
higher kernel-stack-nesting and thus kernel-stack-overflow risk.
3) not managing irq-flags via the _irqsave / _irqrestore variants
is dangerous: it's easy to forget whether one function nests inside
another, and irq flags might be mismanaged.

In the few cases where re-enabling interrupts in an ISR is considered
useful (and unavoidable), it has to be taught to the lock validator
explicitly (because the lock validator needs the "no ISR ever enables
hardirqs" artificial simplification to keep the IRQ/softirq locking
dependencies manageable).

This teaching is done via the explicit use local_irq_enable_in_hardirq().
On a stock kernel this maps to local_irq_enable(). If the lock validator
is enabled then this does not enable interrupts.

Now, the analysis of drivers/net/ns83820.c's irq flags use: the
irq-enabling in irq context seems intentional, but i dont think it's
justified. Furthermore, the driver suffers from problem #3 above too,
in ns83820_tx_timeout() it disables irqs via local_irq_save(), but
then it calls do_tx_done() which does a spin_unlock_irq(),
re-enabling for a function that does not expect it! While currently
this bug seems harmless (only some debug printout seems to be
affected by it), it's nevertheless something to be fixed.

So this patch makes the ns83820 ISR irq-flags-safe, and cleans up
do_tx_done() use and locking to avoid the ns83820_tx_timeout() bug.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/net/ns83820.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: v/drivers/net/ns83820.c
===================================================================
--- v.orig/drivers/net/ns83820.c
+++ v/drivers/net/ns83820.c
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
@@ -1308,6 +1305,8 @@ static irqreturn_t ns83820_irq(int foo, 
 static void ns83820_do_isr(struct net_device *ndev, u32 isr)
 {
 	struct ns83820 *dev = PRIV(ndev);
+	unsigned long flags;
+
 #ifdef DEBUG
 	if (isr & ~(ISR_PHY | ISR_RXDESC | ISR_RXEARLY | ISR_RXOK | ISR_RXERR | ISR_TXIDLE | ISR_TXOK | ISR_TXDESC))
 		Dprintk("odd isr? 0x%08x\n", isr);
@@ -1322,10 +1321,10 @@ static void ns83820_do_isr(struct net_de
 	if ((ISR_RXDESC | ISR_RXOK) & isr) {
 		prefetch(dev->rx_info.next_rx_desc);
 
-		spin_lock_irq(&dev->misc_lock);
+		spin_lock_irqsave(&dev->misc_lock, flags);
 		dev->IMR_cache &= ~(ISR_RXDESC | ISR_RXOK);
 		writel(dev->IMR_cache, dev->base + IMR);
-		spin_unlock_irq(&dev->misc_lock);
+		spin_unlock_irqrestore(&dev->misc_lock, flags);
 
 		tasklet_schedule(&dev->rx_tasklet);
 		//rx_irq(ndev);
@@ -1371,16 +1370,18 @@ static void ns83820_do_isr(struct net_de
 	 * work has accumulated
 	 */
 	if ((ISR_TXDESC | ISR_TXIDLE | ISR_TXOK | ISR_TXERR) & isr) {
+		spin_lock_irqsave(&dev->tx_lock, flags);
 		do_tx_done(ndev);
+		spin_unlock_irqrestore(&dev->tx_lock, flags);
 
 		/* Disable TxOk if there are no outstanding tx packets.
 		 */
 		if ((dev->tx_done_idx == dev->tx_free_idx) &&
 		    (dev->IMR_cache & ISR_TXOK)) {
-			spin_lock_irq(&dev->misc_lock);
+			spin_lock_irqsave(&dev->misc_lock, flags);
 			dev->IMR_cache &= ~ISR_TXOK;
 			writel(dev->IMR_cache, dev->base + IMR);
-			spin_unlock_irq(&dev->misc_lock);
+			spin_unlock_irqrestore(&dev->misc_lock, flags);
 		}
 	}
 
@@ -1391,10 +1392,10 @@ static void ns83820_do_isr(struct net_de
 	 * nature are expected, we must enable TxOk.
 	 */
 	if ((ISR_TXIDLE & isr) && (dev->tx_done_idx != dev->tx_free_idx)) {
-		spin_lock_irq(&dev->misc_lock);
+		spin_lock_irqsave(&dev->misc_lock, flags);
 		dev->IMR_cache |= ISR_TXOK;
 		writel(dev->IMR_cache, dev->base + IMR);
-		spin_unlock_irq(&dev->misc_lock);
+		spin_unlock_irqrestore(&dev->misc_lock, flags);
 	}
 
 	/* MIB interrupt: one of the statistics counters is about to overflow */
@@ -1456,7 +1457,7 @@ static void ns83820_tx_timeout(struct ne
         u32 tx_done_idx, *desc;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&dev->tx_lock, flags);
 
 	tx_done_idx = dev->tx_done_idx;
 	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
@@ -1483,7 +1484,7 @@ static void ns83820_tx_timeout(struct ne
 		ndev->name,
 		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[DESC_CMDSTS]));
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dev->tx_lock, flags);
 }
 
 static void ns83820_tx_watch(unsigned long data)
