Return-Path: <linux-kernel-owner+w=401wt.eu-S937658AbWLIU2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937658AbWLIU2p (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937666AbWLIU2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:28:45 -0500
Received: from smtp-01.mandic.com.br ([200.225.81.132]:40559 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937658AbWLIU2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:28:44 -0500
Message-ID: <457B1C76.3080008@cesarb.net>
Date: Sat, 09 Dec 2006 18:28:38 -0200
From: Cesar Eduardo Barros <cesarb@cesarb.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 driver for Silan SC92031 (second try)
References: <4579C842.5000809@cesarb.net> <20061208220114.b531bee0.akpm@osdl.org>
In-Reply-To: <20061208220114.b531bee0.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton escreveu:
> On Fri, 08 Dec 2006 18:17:06 -0200
> Cesar Eduardo Barros <cesarb@cesarb.net> wrote:
> 
>> From: Cesar Eduardo Barros <cesarb@cesarb.net>
>>
>> +	} while(unlikely(cmpxchg(&priv->intr_status,
> 
> You'll have the arm maintainer after you with a pointy stick.
> 
> cmpxchg is only available on certain architectures.  It would be acceptable
> to make this driver depend on X86 (or something).  Better to rewrite this
> code so it doesn't use cmpxchg.

Fixed. As long as I make sure the interrupt and the tasklet never run at the
same time, I do not need to protect intr_status against concurrent modification.

Also fixed a potential bug where the tasklet could end up permanently disabled.

Apply on top of the previous (2.0b) patch (if you prefer a merged patch, just
ask and I'll make one).

It has received the same testing as the previous one, only for less time (I'm
using it right now).

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>

---

diff -uprN -X linux-2.6.19.orig/Documentation/dontdiff linux-2.6.19-2.0b/drivers/net/sc92031.c linux-2.6.19/drivers/net/sc92031.c
--- linux-2.6.19-2.0b/drivers/net/sc92031.c	2006-12-09 17:53:22.000000000 -0200
+++ linux-2.6.19/drivers/net/sc92031.c	2006-12-09 17:55:20.000000000 -0200
@@ -34,7 +34,7 @@

 #define SC92031_NAME "sc92031"
 #define SC92031_DESCRIPTION "Silan SC92031 PCI Fast Ethernet Adapter driver"
-#define SC92031_VERSION "2.0b"
+#define SC92031_VERSION "2.0c"

 /* BAR 0 is MMIO, BAR 1 is PIO */
 #ifndef SC92031_USE_BAR
@@ -261,6 +261,12 @@ enum PMConfigBits {
  * Use mmiowb() before unlocking if the hardware was written to.
  */

+/* Locking rules for the interrupt:
+ * - the interrupt and the tasklet never run at the same time
+ * - neither run between sc92031_disable_interrupts and
+ *   sc92031_enable_interrupt
+ */
+
 struct sc92031_priv {
 	spinlock_t		lock;
 	/* iomap.h cookie */
@@ -288,6 +294,7 @@ struct sc92031_priv {

 	/* copies of some hardware registers */
 	u32			intr_status;
+	atomic_t		intr_mask;
 	u32			rx_config;
 	u32			tx_config;
 	u32			pm_config;
@@ -304,6 +311,13 @@ struct sc92031_priv {
 	struct net_device_stats	stats;
 };

+/* I don't know which registers can be safely read; however, I can guess
+ * MAC0 is one of them. */
+static inline void _sc92031_dummy_read(void __iomem *port_base)
+{
+	ioread32(port_base + MAC0);
+}
+
 static u32 _sc92031_mii_wait(void __iomem *port_base)
 {
 	u32 mii_status;
@@ -348,12 +362,18 @@ static void sc92031_disable_interrupts(s
 	struct sc92031_priv *priv = netdev_priv(dev);
 	void __iomem *port_base = priv->port_base;

-	tasklet_disable(&priv->tasklet);
+	/* tell the tasklet/interrupt not to enable interrupts */
+	atomic_set(&priv->intr_mask, 0);
+	wmb();

+	/* stop interrupts */
 	iowrite32(0, port_base + IntrMask);
+	_sc92031_dummy_read(port_base);
 	mmiowb();

+	/* wait for any concurrent interrupt/tasklet to finish */
 	synchronize_irq(dev->irq);
+	tasklet_disable(&priv->tasklet);
 }

 static void sc92031_enable_interrupts(struct net_device *dev)
@@ -363,6 +383,9 @@ static void sc92031_enable_interrupts(st

 	tasklet_enable(&priv->tasklet);

+	atomic_set(&priv->intr_mask, IntrBits);
+	wmb();
+
 	iowrite32(IntrBits, port_base + IntrMask);
 	mmiowb();
 }
@@ -608,6 +631,7 @@ static void _sc92031_reset(struct net_de

 	/* clear old register values */
 	priv->intr_status = 0;
+	atomic_set(&priv->intr_mask, 0);
 	priv->rx_config = 0;
 	priv->tx_config = 0;
 	priv->mc_flags = 0;
@@ -824,9 +848,9 @@ static void sc92031_tasklet(unsigned lon
 	struct net_device *dev = (struct net_device *)data;
 	struct sc92031_priv *priv = netdev_priv(dev);
 	void __iomem *port_base = priv->port_base;
-	u32 intr_status;
+	u32 intr_status, intr_mask;

-	intr_status = xchg(&priv->intr_status, 0);
+	intr_status = priv->intr_status;

 	spin_lock(&priv->lock);

@@ -851,7 +875,10 @@ static void sc92031_tasklet(unsigned lon
 		_sc92031_link_tasklet(dev);

 out:
-	iowrite32(IntrBits, port_base + IntrMask);
+	intr_mask = atomic_read(&priv->intr_mask);
+	rmb();
+
+	iowrite32(intr_mask, port_base + IntrMask);
 	mmiowb();

 	spin_unlock(&priv->lock);
@@ -862,29 +889,33 @@ static irqreturn_t sc92031_interrupt(int
 	struct net_device *dev = dev_id;
 	struct sc92031_priv *priv = netdev_priv(dev);
 	void __iomem *port_base = priv->port_base;
-	u32 intr_status, old_intr_status, new_intr_status;
+	u32 intr_status, intr_mask;
+
+	/* mask interrupts before clearing IntrStatus */
+	iowrite32(0, port_base + IntrMask);
+	_sc92031_dummy_read(port_base);

 	intr_status = ioread32(port_base + IntrStatus);
 	if (unlikely(intr_status == 0xffffffff))
-		return IRQ_NONE;
+		return IRQ_NONE;	// hardware has gone missing

 	intr_status &= IntrBits;
 	if (!intr_status)
-		return IRQ_NONE;
-
-	do {
-		old_intr_status = priv->intr_status;
-		new_intr_status = old_intr_status | intr_status;
-	} while(unlikely(cmpxchg(&priv->intr_status,
-					old_intr_status, new_intr_status)
-			!= old_intr_status));
-
-	iowrite32(0, port_base + IntrMask);
-	mmiowb();
+		goto out_none;

+	priv->intr_status = intr_status;
 	tasklet_schedule(&priv->tasklet);

 	return IRQ_HANDLED;
+
+out_none:
+	intr_mask = atomic_read(&priv->intr_mask);
+	rmb();
+
+	iowrite32(intr_mask, port_base + IntrMask);
+	mmiowb();
+
+	return IRQ_NONE;
 }

 static struct net_device_stats *sc92031_get_stats(struct net_device *dev)
@@ -1007,7 +1038,7 @@ static int sc92031_open(struct net_devic

 	priv->pm_config = 0;

-	sc92031_disable_interrupts(dev);
+	/* Interrupts already disabled by sc92031_stop or sc92031_probe */
 	spin_lock(&priv->lock);

 	_sc92031_reset(dev);
@@ -1442,6 +1473,9 @@ static int __devinit sc92031_probe(struc
 	priv->port_base = port_base;
 	priv->pdev = pdev;
 	tasklet_init(&priv->tasklet, sc92031_tasklet, (unsigned long)dev);
+	/* Fudge tasklet count so the call to sc92031_enable_interrupts at
+	 * sc92031_open will work correctly */
+	tasklet_disable_nosync(&priv->tasklet);

 	/* PCI PM Wakeup */
 	iowrite32((~PM_LongWF & ~PM_LWPTN) | PM_Enable, port_base + PMConfig);
@@ -1527,7 +1561,7 @@ static int sc92031_resume(struct pci_dev
 	if (!netif_running(dev))
 		goto out;

-	sc92031_disable_interrupts(dev);
+	/* Interrupts already disabled by sc92031_suspend */
 	spin_lock(&priv->lock);

 	_sc92031_reset(dev);


-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
