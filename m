Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269579AbUHZUPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269579AbUHZUPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbUHZUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:14:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44515 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269561AbUHZUHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:07:45 -0400
Date: Thu, 26 Aug 2004 22:07:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org,
       Francois Romieu <romieu@cogenit.fr>
Subject: [2.4 patch][6/6] dscc4.c: fix gcc 3.4 compilation
Message-ID: <20040826200737.GH12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195133.GB12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got compile errors starting with the following when trying to build  
2.4.28-pre2 using gcc 3.4:

<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-modular/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time -DMODULE -DMODVERSIONS -include 
/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-modular/include/linux/modversions.h  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=dscc4  -c -o dscc4.o 
dscc4.c
dscc4.c: In function `dscc4_found1':
dscc4.c:369: sorry, unimplemented: inlining failed in call to 
'dscc4_set_quartz': function body not available
dscc4.c:921: sorry, unimplemented: called from here
make[3]: *** [dscc4.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-modular/drivers/net/wan'

<--  snip  -->


The patch below fixes this issue (similar to how it was done in 2.6).


diffstat output:
 drivers/net/wan/dscc4.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre2-modular/drivers/net/wan/dscc4.c.old	2004-08-26 20:14:02.000000000 +0200
+++ linux-2.4.28-pre2-modular/drivers/net/wan/dscc4.c	2004-08-26 20:18:53.000000000 +0200
@@ -351,8 +351,8 @@
 #endif
 
 /* Functions prototypes */
-static inline void dscc4_rx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
-static inline void dscc4_tx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
+static void dscc4_rx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
+static void dscc4_tx_irq(struct dscc4_pci_priv *, struct dscc4_dev_priv *);
 static int dscc4_found1(struct pci_dev *, unsigned long ioaddr);
 static int dscc4_init_one(struct pci_dev *, const struct pci_device_id *ent);
 static int dscc4_open(struct net_device *);
@@ -366,7 +366,6 @@
 static void dscc4_irq(int irq, void *dev_id, struct pt_regs *ptregs);
 static int dscc4_hdlc_attach(hdlc_device *, unsigned short, unsigned short);
 static int dscc4_set_iface(struct dscc4_dev_priv *, struct net_device *);
-static inline int dscc4_set_quartz(struct dscc4_dev_priv *, int);
 #ifdef DSCC4_POLLING
 static int dscc4_tx_poll(struct dscc4_dev_priv *, struct net_device *);
 #endif
@@ -857,6 +856,18 @@
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
@@ -1325,18 +1336,6 @@
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
@@ -1512,7 +1511,7 @@
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static inline void dscc4_tx_irq(struct dscc4_pci_priv *ppriv,
+static void dscc4_tx_irq(struct dscc4_pci_priv *ppriv,
 				struct dscc4_dev_priv *dpriv)
 {
 	struct net_device *dev = hdlc_to_dev(&dpriv->hdlc);
@@ -1681,7 +1680,7 @@
 	goto try;
 }
 
-static inline void dscc4_rx_irq(struct dscc4_pci_priv *priv,
+static void dscc4_rx_irq(struct dscc4_pci_priv *priv,
 				    struct dscc4_dev_priv *dpriv)
 {
 	struct net_device *dev = hdlc_to_dev(&dpriv->hdlc);

