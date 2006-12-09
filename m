Return-Path: <linux-kernel-owner+w=401wt.eu-S936677AbWLIJaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936677AbWLIJaH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936649AbWLIJaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:30:07 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:59562 "EHLO
	adicia.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936615AbWLIJaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:30:03 -0500
Date: Sat, 9 Dec 2006 10:29:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-net@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/HP300: HP LANCE updates
Message-ID: <Pine.LNX.4.64.0612091028520.11192@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kars de Jong <jongk@linux-m68k.org>

- 7990: request_irq() should have SA_SHIRQ flag set
- hplance_init() printed dev->name before register_netdev() had filled it in

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 drivers/net/7990.c    |    2 +-
 drivers/net/hplance.c |   14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

--- linux-m68k-2.6.19.orig/drivers/net/7990.c
+++ linux-m68k-2.6.19/drivers/net/7990.c
@@ -500,7 +500,7 @@ int lance_open (struct net_device *dev)
 	int res;
 
         /* Install the Interrupt handler. Or we could shunt this out to specific drivers? */
-        if (request_irq(lp->irq, lance_interrupt, 0, lp->name, dev))
+        if (request_irq(lp->irq, lance_interrupt, SA_SHIRQ, lp->name, dev))
                 return -EAGAIN;
 
         res = lance_reset(dev);
--- linux-m68k-2.6.19.orig/drivers/net/hplance.c
+++ linux-m68k-2.6.19/drivers/net/hplance.c
@@ -77,6 +77,7 @@ static int __devinit hplance_init_one(st
 {
 	struct net_device *dev;
 	int err = -ENOMEM;
+	int i;
 
 	dev = alloc_etherdev(sizeof(struct hplance_private));
 	if (!dev)
@@ -93,6 +94,15 @@ static int __devinit hplance_init_one(st
 		goto out_release_mem_region;
 
 	dio_set_drvdata(d, dev);
+
+	printk(KERN_INFO "%s: %s; select code %d, addr %2.2x", dev->name, d->name, d->scode, dev->dev_addr[0]);
+
+	for (i=1; i<6; i++) {
+		printk(":%2.2x", dev->dev_addr[i]);
+	}
+
+	printk(", irq %d\n", d->ipl);
+
 	return 0;
 
  out_release_mem_region:
@@ -119,8 +129,6 @@ static void __init hplance_init(struct n
         struct hplance_private *lp;
         int i;
 
-        printk(KERN_INFO "%s: %s; select code %d, addr", dev->name, d->name, d->scode);
-
         /* reset the board */
         out_8(va+DIO_IDOFF, 0xff);
         udelay(100);                              /* ariba! ariba! udelay! udelay! */
@@ -143,7 +151,6 @@ static void __init hplance_init(struct n
                  */
                 dev->dev_addr[i] = ((in_8(va + HPLANCE_NVRAMOFF + i*4 + 1) & 0xF) << 4)
                         | (in_8(va + HPLANCE_NVRAMOFF + i*4 + 3) & 0xF);
-                printk("%c%2.2x", i == 0 ? ' ' : ':', dev->dev_addr[i]);
         }
 
         lp = netdev_priv(dev);
@@ -160,7 +167,6 @@ static void __init hplance_init(struct n
         lp->lance.lance_log_tx_bufs = LANCE_LOG_TX_BUFFERS;
         lp->lance.rx_ring_mod_mask = RX_RING_MOD_MASK;
         lp->lance.tx_ring_mod_mask = TX_RING_MOD_MASK;
-	printk(", irq %d\n", lp->lance.irq);
 }
 
 /* This is disgusting. We have to check the DIO status register for ack every

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
