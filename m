Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWBUUg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWBUUg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWBUUg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:36:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21153
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932699AbWBUUg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:36:27 -0500
Subject: Re: 2.6.15-rt17
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <6bffcb0e0602211053y143d9049g@mail.gmail.com>
References: <20060221155548.GA30146@elte.hu>
	 <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
	 <6bffcb0e0602211053y143d9049g@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-eNd9t3ns2Gy0Y7lqUdmv"
Date: Tue, 21 Feb 2006 21:37:29 +0100
Message-Id: <1140554250.2480.1042.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eNd9t3ns2Gy0Y7lqUdmv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-02-21 at 19:53 +0100, Michal Piotrowski wrote:
> On 21/02/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> [snip]
> > Here is config http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-config
> > Here is dmesg http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-dmesg
> 
> Here is updated config
> http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-config2
> Here is updated dmesg
> http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-dmesg2
> 
> BTW. thanks for fixing CONFIG_DEBUG_HIGHMEM=y

The stack maximum messages are harmless. They just report a new
watermark high quite verbose. You can turn them off by disabling
DEBUG_STACKOVERFLOW.

skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx
WARNING: softirq-tasklet/8 changed soft IRQ-flags.
 [<c0103b33>] dump_stack+0x1b/0x1f (20)
 [<c0134035>] illegal_API_call+0x41/0x46 (20)
 [<c0134084>] local_irq_disable+0x1d/0x1f (8)
 [<f8839bf3>] skge_extirq+0x117/0x138 [skge] (32)
 [<c0120a73>] __tasklet_action+0xb8/0xfd (28)
 [<c0120afc>] tasklet_action+0x44/0x4e (28)
 [<c0120ce8>] ksoftirqd+0x10f/0x19e (32)
 [<c012dfa6>] kthread+0x7b/0xa9 (36)
 [<c01010dd>] kernel_thread_helper+0x5/0xb (1037991964)

This one is interesting. It brought my attention to that piece of code
which is a long standing problem on one of my boxen anyway. Patch
attached.

	tglx







--=-eNd9t3ns2Gy0Y7lqUdmv
Content-Disposition: attachment; filename=skge-fix.patch
Content-Type: text/x-patch; name=skge-fix.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.15/drivers/net/skge.c
===================================================================
--- linux-2.6.15.orig/drivers/net/skge.c
+++ linux-2.6.15/drivers/net/skge.c
@@ -2820,10 +2820,10 @@ static void skge_extirq(unsigned long da
 	}
 	spin_unlock(&hw->phy_lock);
 
-	local_irq_disable();
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= IS_EXT_REG;
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
-	local_irq_enable();
+	spin_unlock_irq(&hw->hw_lock);
 }
 
 static inline void skge_wakeup(struct net_device *dev)
@@ -2842,6 +2842,8 @@ static irqreturn_t skge_intr(int irq, vo
 	if (status == 0 || status == ~0) /* hotplug or shared irq */
 		return IRQ_NONE;
 
+	spin_lock(&hw->hw_lock);
+
 	status &= hw->intr_mask;
 	if (status & IS_R1_F) {
 		hw->intr_mask &= ~IS_R1_F;
@@ -2893,6 +2895,8 @@ static irqreturn_t skge_intr(int irq, vo
 
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
 
+	spin_unlock(&hw->hw_lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -3249,6 +3253,7 @@ static int __devinit skge_probe(struct p
 	}
 
 	hw->pdev = pdev;
+	spin_lock_init(&hw->hw_lock);
 	spin_lock_init(&hw->phy_lock);
 	tasklet_init(&hw->ext_tasklet, skge_extirq, (unsigned long) hw);
 
Index: linux-2.6.15/drivers/net/skge.h
===================================================================
--- linux-2.6.15.orig/drivers/net/skge.h
+++ linux-2.6.15/drivers/net/skge.h
@@ -2472,6 +2472,7 @@ struct skge_hw {
 	u16		     phy_addr;
 
 	struct tasklet_struct ext_tasklet;
+	spinlock_t	     hw_lock;
 	spinlock_t	     phy_lock;
 };
 

--=-eNd9t3ns2Gy0Y7lqUdmv--

