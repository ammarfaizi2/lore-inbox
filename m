Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755474AbWKODBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbWKODBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbWKODBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:01:20 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9863
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1755474AbWKODBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:01:19 -0500
Date: Tue, 14 Nov 2006 19:00:36 -0800 (PST)
Message-Id: <20061114.190036.30187059.davem@davemloft.net>
To: torvalds@osdl.org
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	<455A7E21.7020701@garzik.org>
	<Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Tue, 14 Nov 2006 18:49:43 -0800 (PST)

> In the meantime, I'm really tired of continually hearing about MSI 
> problems, when there really aren't that many advantages.
> 
> > It's nice not to have to deal with shared interrupts.
> 
> I don't think "nice" is enough of an advantage to overcome "doesn't work 
> on God knows how many systems".

>From what I see, that's not the advantage of MSI.  The following
doesn't apply so well to sound, but it does apply significantly
to the networking.

The big advantage is that it eliminates the ordering issue in
interrupt handlers that use a DMA'd status block.  Look at the Tigon3
driver for one good example.

If you take an INTX interrupt, it's over a pin on the motherboard and
thus can arrive before the DMA makes it to main memory, so you have to
have all of this fixup logic to handle that case and you don't even
know the interrupt is really for you so you have to actually check
the status block.

static irqreturn_t tg3_interrupt(int irq, void *dev_id)
{
	struct net_device *dev = dev_id;
	struct tg3 *tp = netdev_priv(dev);
	struct tg3_hw_status *sblk = tp->hw_status;
	unsigned int handled = 1;

	/* In INTx mode, it is possible for the interrupt to arrive at
	 * the CPU before the status block posted prior to the interrupt.
	 * Reading the PCI State register will confirm whether the
	 * interrupt is ours and will flush the status block.
	 */
	if ((sblk->status & SD_STATUS_UPDATED) ||
	    !(tr32(TG3PCI_PCISTATE) & PCISTATE_INT_NOT_ACTIVE)) {
		/*
		 * Writing any value to intr-mbox-0 clears PCI INTA# and
		 * chip-internal interrupt pending events.
		 * Writing non-zero to intr-mbox-0 additional tells the
		 * NIC to stop sending us irqs, engaging "in-intr-handler"
		 * event coalescing.
		 */
		tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW,
			     0x00000001);
		if (tg3_irq_sync(tp))
			goto out;
		sblk->status &= ~SD_STATUS_UPDATED;
		if (likely(tg3_has_work(tp))) {
			prefetch(&tp->rx_rcb[tp->rx_rcb_ptr]);
			netif_rx_schedule(dev);		/* schedule NAPI poll */
		} else {
			/* No work, shared interrupt perhaps?  re-enable
			 * interrupts, and flush that PCI write
			 */
			tw32_mailbox_f(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW,
			     	0x00000000);
		}
	} else {	/* shared interrupt */
		handled = 0;
	}
out:
	return IRQ_RETVAL(handled);
}

This whole initial if statement goes away with MSI, you don't even
need to check the status block, you know the interrupt is for you and
the device did generate it and has work pending.

/* MSI ISR - No need to check for interrupt sharing and no need to
 * flush status block and interrupt mailbox. PCI ordering rules
 * guarantee that MSI will arrive after the status block.
 */
static irqreturn_t tg3_msi(int irq, void *dev_id)
{
	struct net_device *dev = dev_id;
	struct tg3 *tp = netdev_priv(dev);

	prefetch(tp->hw_status);
	prefetch(&tp->rx_rcb[tp->rx_rcb_ptr]);
	/*
	 * Writing any value to intr-mbox-0 clears PCI INTA# and
	 * chip-internal interrupt pending events.
	 * Writing non-zero to intr-mbox-0 additional tells the
	 * NIC to stop sending us irqs, engaging "in-intr-handler"
	 * event coalescing.
	 */
	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0x00000001);
	if (likely(!tg3_irq_sync(tp)))
		netif_rx_schedule(dev);		/* schedule NAPI poll */

	return IRQ_RETVAL(1);
}

Taken to the next level MSI can be implemented in a "one-shot"
manner such that once the MSI is generated the chip shuts off
all further interrupts automatically.

This is perfect for networking devices since that is the first
thing we need to do in the interrupt handler for NAPI, and Tigon3
actually implements this.

/* One-shot MSI handler - Chip automatically disables interrupt
 * after sending MSI so driver doesn't have to do it.
 */
static irqreturn_t tg3_msi_1shot(int irq, void *dev_id)
{
	struct net_device *dev = dev_id;
	struct tg3 *tp = netdev_priv(dev);

	prefetch(tp->hw_status);
	prefetch(&tp->rx_rcb[tp->rx_rcb_ptr]);

	if (likely(!tg3_irq_sync(tp)))
		netif_rx_schedule(dev);		/* schedule NAPI poll */

	return IRQ_HANDLED;
}

It saves an MMIO write in the interrupt handler and makes a huge
different in performance.
