Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHATUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHATUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUHATUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 15:20:41 -0400
Received: from mail.dif.dk ([193.138.115.101]:16858 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266147AbUHATUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 15:20:16 -0400
Date: Sun, 1 Aug 2004 21:24:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: romieu@cogenit.fr
Cc: LKML <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: [PATCH] fix inline related gcc 3.4 build failures in drivers/net/wan/dscc4.c
Message-ID: <Pine.LNX.4.60.0408012113530.2535@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch against 2.6.8-rc2-mm1 to fix up some build errors due to 
function inlining failing with gcc 3.4.0


drivers/net/wan/dscc4.c: In function `dscc4_found1':
drivers/net/wan/dscc4.c:369: sorry, unimplemented: inlining failed in call to 'dscc4_set_quartz': function body not available
drivers/net/wan/dscc4.c:898: sorry, unimplemented: called from here

This one I fixed by moving the function before the point of its first use 
since it's quite small.

drivers/net/wan/dscc4.c: In function `dscc4_irq':
drivers/net/wan/dscc4.c:354: sorry, unimplemented: inlining failed in call to 'dscc4_rx_irq': function body not available
drivers/net/wan/dscc4.c:1518: sorry, unimplemented: called from here
drivers/net/wan/dscc4.c:355: sorry, unimplemented: inlining failed in call to 'dscc4_tx_irq': function body not available
drivers/net/wan/dscc4.c:1525: sorry, unimplemented: called from here

These two I fixed by un-inlining them since they are both very big 
functions. They are both only called from a single location though, so 
maybe they should just be moved, but I took the 'un-inline' approach in 
the patch below. If you want a patch to move them instead, then just let 
me know. The important thing is that with this patch the build no longer 
breaks.

Patch is compile tested only since I don't have the hardware, but I don't 
see how this could possibly break anything as there are no behavior 
changes.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8-rc2-mm1-orig/drivers/net/wan/dscc4.c linux-2.6.8-rc2-mm1/drivers/net/wan/dscc4.c
--- linux-2.6.8-rc2-mm1-orig/drivers/net/wan/dscc4.c	2004-07-31 13:09:41.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/net/wan/dscc4.c	2004-08-01 21:10:28.000000000 +0200
@@ -351,8 +351,9 @@ struct dscc4_dev_priv {
 #endif
 
 /* Functions prototypes */
-static inline void dscc4_rx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
-static inline void dscc4_tx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
+static void dscc4_rx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
+static void dscc4_tx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
+static inline int dscc4_set_quartz(struct dscc4_dev_priv *, int);
 static int dscc4_found1(struct pci_dev *, unsigned long ioaddr);
 static int dscc4_init_one(struct pci_dev *, const struct pci_device_id *ent);
 static int dscc4_open(struct net_device *);
@@ -366,7 +367,6 @@ static void dscc4_tx_timeout(struct net_
 static irqreturn_t dscc4_irq(int irq, void *dev_id, struct pt_regs *ptregs);
 static int dscc4_hdlc_attach(struct net_device *, unsigned short, unsigned short);
 static int dscc4_set_iface(struct dscc4_dev_priv *, struct net_device *);
-static inline int dscc4_set_quartz(struct dscc4_dev_priv *, int);
 #ifdef DSCC4_POLLING
 static int dscc4_tx_poll(struct dscc4_dev_priv *, struct net_device *);
 #endif
@@ -866,6 +866,18 @@ static void dscc4_init_registers(struct 
 	//scc_writel(0x00250008 & ~RxActivate, dpriv, dev, CCR2);
 }
 
+static inline int dscc4_set_quartz(struct dscc4_dev_priv *dpriv, int hz)
+{
+	int ret = 0;
+
+	if ((hz < 0) || (hz > DSCC4_HZ_MAX))
+		ret = -EOPNOTSUPP;
+	else
+		dpriv->pci_priv->xtal_hz = hz;
+
+	return ret;
+}
+
 static int dscc4_found1(struct pci_dev *pdev, unsigned long ioaddr)
 {
 	struct dscc4_pci_priv *ppriv;
@@ -1340,18 +1352,6 @@ static int dscc4_ioctl(struct net_device
 	return ret;
 }
 
-static inline int dscc4_set_quartz(struct dscc4_dev_priv *dpriv, int hz)
-{
-	int ret = 0;
-
-	if ((hz < 0) || (hz > DSCC4_HZ_MAX))
-		ret = -EOPNOTSUPP;
-	else
-		dpriv->pci_priv->xtal_hz = hz;
-
-	return ret;
-}
-
 static int dscc4_match(struct thingie *p, int value)
 {
 	int i;
@@ -1531,7 +1531,7 @@ out:
 	return IRQ_RETVAL(handled);
 }
 
-static inline void dscc4_tx_irq(struct dscc4_pci_priv *ppriv,
+static void dscc4_tx_irq(struct dscc4_pci_priv *ppriv,
 				struct dscc4_dev_priv *dpriv)
 {
 	struct net_device *dev = dscc4_to_dev(dpriv);
@@ -1700,7 +1700,7 @@ try:
 	goto try;
 }
 
-static inline void dscc4_rx_irq(struct dscc4_pci_priv *priv,
+static void dscc4_rx_irq(struct dscc4_pci_priv *priv,
 				    struct dscc4_dev_priv *dpriv)
 {
 	struct net_device *dev = dscc4_to_dev(dpriv);



Please CC me on replies from 'linux-net' as I'm not subscribed there.

--
Jesper Juhl <juhl-lkml@dif.dk>


