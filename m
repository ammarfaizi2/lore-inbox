Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268189AbTALAst>; Sat, 11 Jan 2003 19:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTALAst>; Sat, 11 Jan 2003 19:48:49 -0500
Received: from havoc.daloft.com ([64.213.145.173]:8665 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268189AbTALAsq>;
	Sat, 11 Jan 2003 19:48:46 -0500
Date: Sat, 11 Jan 2003 19:57:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Jean-Daniel Pauget <jd@disjunkt.com>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com, davem@redhat.com
Subject: [PATCH] Re: Another holiday, another set of tg3 releases.
Message-ID: <20030112005727.GB17545@gtf.org>
References: <Pine.LNX.4.51.0301120101210.1290@mint>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0301120101210.1290@mint>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2003 at 01:14:03AM +0100, Jean-Daniel Pauget wrote:
> 
> on 2002-12-30, Jeff Garzik <jgarzik@pobox.com> wrote :
> 
> > Another holiday, another set of tg3 releases.
> 
>     in my seek for unexpected freeze of my box (not yet figured which
>     hardware is involved exactly) I updated to tg3-1.2a and applied
>     both tg3-1.2a-00_irqsave and tg3-1.2a-01_mask_rewrite.
>     as a result, after working a few seconds the network card freezes, and
>     no ifupdown would permit any recovery.
> 
>     on the other hand, with only the first patch tg3-1.2a-00_irqsave, things
>     seems ok and I'm waiting for my machine to freeze... ...or not. (the freeze
>     frequency is ~10hours )...

Thanks, please do keep us posted.

I have attached two patches, with accompanying descriptions, that I have
been testing locally on UP and SMP.  They are a bit more conservative
than tg3-1.2a-01_mask_rewrite while still addressing the same issue.

Right now my plan for tg3 version 1.3 (next release) is:
	tg3-1.2a-00_irqsave
	tg3-irq-mask-2.patch (attached), and
	tg3-irq-flush.patch (attached)
	and maybe the MTU stuff [more on that below]

The first patch, 00_irqsave, is a bit too paranoid for DaveM's liking,
so even though I will to apply 00_irqsave, that area will get further
attention once existing bug reports are resolved.

[Note to DaveM -- tg3_timer is not a fast path, so extra paranoia there
won't hurt]


>     though, on your page you mention a fifth patch concerning mtu, as I'm
>     running with an unusual mtu of 1452 because of internet over internet
>     encapsulation on my DSL, maybe I'm concerned ?

MTU of 1452 should not be a problem.  The issue is more of correcting
handling of change-MTU condition that rarely happens.

	Jeff




--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tg3-irq-mask-2.patch"

# --------------------------------------------
# 03/01/05	jgarzik@redhat.com	1.926.1.2
# [netdrvr tg3] Better interrupt masking
# 
# The bcm570x chips provide a register that disables (masks) or enables
# interrupts, and as a side effect, each write to this register regardless 
# of value clears various PCI and internal interrupt-pending flags.  This
# register, intr-mbox-0, provides a superset of the function provided
# by the mask-pci-int and clear-pci-int bits in the misc-host-ctrl register.
# 
# Furthermore, the documentation clearly implies use of this register,
# as an indicator that the host [tg3 driver] is in its interrupt handler.
# 
# The new tg3 logic, taking this knowledge into account, masks-and-clears
# irqs using intr-mbox-0 [only] when a hard irq is received, and
# unmasks-and-clears irqs at the end of tg3_poll after all NAPI events
# have been exhausted.
# 
# The old logic twiddled the misc-host-ctrl irq masking bits separately
# from intr-mbox-0 bits, which was not only inconsistent but also
# a few additional I/Os that were not needed.
# --------------------------------------------
#
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Sat Jan 11 19:42:56 2003
+++ b/drivers/net/tg3.c	Sat Jan 11 19:42:56 2003
@@ -217,22 +217,6 @@
 	tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
 }
 
-static inline void tg3_mask_ints(struct tg3 *tp)
-{
-	tw32(TG3PCI_MISC_HOST_CTRL,
-	     (tp->misc_host_ctrl | MISC_HOST_CTRL_MASK_PCI_INT));
-}
-
-static inline void tg3_unmask_ints(struct tg3 *tp)
-{
-	tw32(TG3PCI_MISC_HOST_CTRL,
-	     (tp->misc_host_ctrl & ~MISC_HOST_CTRL_MASK_PCI_INT));
-	if (tp->hw_status->status & SD_STATUS_UPDATED) {
-		tw32(GRC_LOCAL_CTRL,
-		     tp->grc_local_ctrl | GRC_LCLCTRL_SETINT);
-	}
-}
-
 static void tg3_switch_clocks(struct tg3 *tp)
 {
 	if (tr32(TG3PCI_CLOCK_CTRL) & CLOCK_CTRL_44MHZ_CORE) {
@@ -2052,7 +2036,7 @@
 
 	if (done) {
 		netif_rx_complete(netdev);
-		tg3_unmask_ints(tp);
+		tg3_enable_ints(tp);
 	}
 
 	spin_unlock_irq(&tp->lock);
@@ -2060,10 +2044,10 @@
 	return (done ? 0 : 1);
 }
 
-static __inline__ void tg3_interrupt_main_work(struct net_device *dev, struct tg3 *tp)
+static inline unsigned int tg3_has_work(struct net_device *dev, struct tg3 *tp)
 {
 	struct tg3_hw_status *sblk = tp->hw_status;
-	int work_exists = 0;
+	unsigned int work_exists = 0;
 
 	if (!(tp->tg3_flags &
 	      (TG3_FLAG_USE_LINKCHG_REG |
@@ -2075,19 +2059,7 @@
 	    sblk->idx[0].rx_producer != tp->rx_rcb_ptr)
 		work_exists = 1;
 
-	if (!work_exists)
-		return;
-
-	if (netif_rx_schedule_prep(dev)) {
-		/* NOTE: These writes are posted by the readback of
-		 *       the mailbox register done by our caller.
-		 */
-		tg3_mask_ints(tp);
-		__netif_rx_schedule(dev);
-	} else {
-		printk(KERN_ERR PFX "%s: Error, poll already scheduled\n",
-		       dev->name);
-	}
+	return work_exists;
 }
 
 static void tg3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -2102,13 +2074,16 @@
 	if (sblk->status & SD_STATUS_UPDATED) {
 		tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW,
 			     0x00000001);
+		tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
 		sblk->status &= ~SD_STATUS_UPDATED;
 
-		tg3_interrupt_main_work(dev, tp);
-
-		tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW,
-			     0x00000000);
-		tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
+		if (likely(tg3_has_work(dev, tp)))
+			netif_rx_schedule(dev);
+		else {
+			tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW,
+			     	0x00000000);
+			tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
+		}
 	}
 
 	spin_unlock_irqrestore(&tp->lock, flags);

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tg3-irq-flush.patch"

# --------------------------------------------
# 03/01/05	jgarzik@redhat.com	1.926.1.3
# [netdrvr tg3] flush irq-mask reg write before checking hw status block,
# in tg3_enable_ints.
# --------------------------------------------
#
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Sat Jan 11 19:43:21 2003
+++ b/drivers/net/tg3.c	Sat Jan 11 19:43:21 2003
@@ -209,12 +209,11 @@
 	tw32(TG3PCI_MISC_HOST_CTRL,
 	     (tp->misc_host_ctrl & ~MISC_HOST_CTRL_MASK_PCI_INT));
 	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0x00000000);
+	tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
 
-	if (tp->hw_status->status & SD_STATUS_UPDATED) {
+	if (tp->hw_status->status & SD_STATUS_UPDATED)
 		tw32(GRC_LOCAL_CTRL,
 		     tp->grc_local_ctrl | GRC_LCLCTRL_SETINT);
-	}
-	tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
 }
 
 static void tg3_switch_clocks(struct tg3 *tp)

--yrj/dFKFPuw6o+aM--
