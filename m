Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVLUXtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVLUXtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVLUXtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:49:47 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:23827 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S964998AbVLUXtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:49:46 -0500
Date: Wed, 21 Dec 2005 23:48:50 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tim Hockin <thockin@hockin.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Resubmit: [PATCH] natsemi: NAPI support
Message-ID: <20051221234850.GC5274@sirena.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Tim Hockin <thockin@hockin.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk> <20051206001934.GA18329@electric-eye.fr.zoreil.com> <20051206211729.GB3709@sirena.org.uk> <20051206215619.GB3425@electric-eye.fr.zoreil.com> <20051209104832.GA3677@sirena.org.uk> <20051212235531.GB3714@sirena.org.uk> <439E14F0.4040001@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <439E14F0.4040001@pobox.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  This patch against 2.6.14 converts the natsemi driver 
	to use NAPI. It was originally based on one written by Harald Welte, 
	though it has since been modified quite a bit, most extensively in 
	order to remove the ability to disable NAPI since none of the other 
	drivers seem to provide that functionality any more. [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch against 2.6.14 converts the natsemi driver to use NAPI.  It
was originally based on one written by Harald Welte, though it has since
been modified quite a bit, most extensively in order to remove the
ability to disable NAPI since none of the other drivers seem to provide
that functionality any more.

Signed-off-by: Mark Brown <broonie@sirena.org.uk>

---

This revision of the patch:
 - Doesn't sleep with the device spinlock held in suspend().
 - Improves the synchronisation between poll() and the shutdown paths.

and should address all the issues people previously raised.

--- linux-2.6.14/drivers/net/natsemi.c.orig	2005-11-29 19:29:12.000000000 +=
0000
+++ linux/drivers/net/natsemi.c	2005-12-11 14:55:48.000000000 +0000
@@ -3,6 +3,7 @@
 	Written/copyright 1999-2001 by Donald Becker.
 	Portions copyright (c) 2001,2002 Sun Microsystems (thockin@sun.com)
 	Portions copyright 2001,2002 Manfred Spraul (manfred@colorfullife.com)
+	Portions copyright 2004 Harald Welte <laforge@gnumonks.org>
=20
 	This software may be used and distributed according to the terms of
 	the GNU General Public License (GPL), incorporated herein by reference.
@@ -135,8 +136,6 @@
=20
 	TODO:
 	* big endian support with CFG:BEM instead of cpu_to_le32
-	* support for an external PHY
-	* NAPI
 */
=20
 #include <linux/config.h>
@@ -160,6 +159,7 @@
 #include <linux/mii.h>
 #include <linux/crc32.h>
 #include <linux/bitops.h>
+#include <linux/prefetch.h>
 #include <asm/processor.h>	/* Processor type for cache alignment. */
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -183,8 +183,6 @@
 				 NETIF_MSG_TX_ERR)
 static int debug =3D -1;
=20
-/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-static int max_interrupt_work =3D 20;
 static int mtu;
=20
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
@@ -251,14 +249,11 @@ MODULE_AUTHOR("Donald Becker <becker@scy
 MODULE_DESCRIPTION("National Semiconductor DP8381x series PCI Ethernet dri=
ver");
 MODULE_LICENSE("GPL");
=20
-module_param(max_interrupt_work, int, 0);
 module_param(mtu, int, 0);
 module_param(debug, int, 0);
 module_param(rx_copybreak, int, 0);
 module_param_array(options, int, NULL, 0);
 module_param_array(full_duplex, int, NULL, 0);
-MODULE_PARM_DESC(max_interrupt_work,=20
-	"DP8381x maximum events handled per interrupt");
 MODULE_PARM_DESC(mtu, "DP8381x MTU (all boards)");
 MODULE_PARM_DESC(debug, "DP8381x default debug level");
 MODULE_PARM_DESC(rx_copybreak,=20
@@ -691,6 +686,8 @@ struct netdev_private {
 	/* Based on MTU+slack. */
 	unsigned int rx_buf_sz;
 	int oom;
+	/* Interrupt status */
+	u32 intr_status;
 	/* Do not touch the nic registers */
 	int hands_off;
 	/* external phy that is used: only valid if dev->if_port !=3D PORT_TP */
@@ -748,7 +745,8 @@ static void init_registers(struct net_de
 static int start_tx(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t intr_handler(int irq, void *dev_instance, struct pt_reg=
s *regs);
 static void netdev_error(struct net_device *dev, int intr_status);
-static void netdev_rx(struct net_device *dev);
+static int natsemi_poll(struct net_device *dev, int *budget);
+static void netdev_rx(struct net_device *dev, int *work_done, int work_to_=
do);
 static void netdev_tx_done(struct net_device *dev);
 static int natsemi_change_mtu(struct net_device *dev, int new_mtu);
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -776,6 +774,18 @@ static inline void __iomem *ns_ioaddr(st
 	return (void __iomem *) dev->base_addr;
 }
=20
+static inline void natsemi_irq_enable(struct net_device *dev)
+{
+	writel(1, ns_ioaddr(dev) + IntrEnable);
+	readl(ns_ioaddr(dev) + IntrEnable);
+}
+
+static inline void natsemi_irq_disable(struct net_device *dev)
+{
+	writel(0, ns_ioaddr(dev) + IntrEnable);
+	readl(ns_ioaddr(dev) + IntrEnable);
+}
+
 static void move_int_phy(struct net_device *dev, int addr)
 {
 	struct netdev_private *np =3D netdev_priv(dev);
@@ -879,6 +889,7 @@ static int __devinit natsemi_probe1 (str
 	spin_lock_init(&np->lock);
 	np->msg_enable =3D (debug >=3D 0) ? (1<<debug)-1 : NATSEMI_DEF_MSG;
 	np->hands_off =3D 0;
+	np->intr_status =3D 0;
=20
 	/* Initial port:
 	 * - If the nic was configured to use an external phy and if find_mii
@@ -932,6 +943,9 @@ static int __devinit natsemi_probe1 (str
 	dev->do_ioctl =3D &netdev_ioctl;
 	dev->tx_timeout =3D &tx_timeout;
 	dev->watchdog_timeo =3D TX_TIMEOUT;
+	dev->poll =3D natsemi_poll;
+	dev->weight =3D 64;
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller =3D &natsemi_poll_controller;
 #endif
@@ -2158,68 +2172,92 @@ static void netdev_tx_done(struct net_de
 	}
 }
=20
-/* The interrupt handler does all of the Rx thread work and cleans up
-   after the Tx thread. */
+/* The interrupt handler doesn't actually handle interrupts itself, it
+ * schedules a NAPI poll if there is anything to do. */
 static irqreturn_t intr_handler(int irq, void *dev_instance, struct pt_reg=
s *rgs)
 {
 	struct net_device *dev =3D dev_instance;
 	struct netdev_private *np =3D netdev_priv(dev);
 	void __iomem * ioaddr =3D ns_ioaddr(dev);
-	int boguscnt =3D max_interrupt_work;
-	unsigned int handled =3D 0;
=20
 	if (np->hands_off)
 		return IRQ_NONE;
-	do {
-		/* Reading automatically acknowledges all int sources. */
-		u32 intr_status =3D readl(ioaddr + IntrStatus);
+=09
+	/* Reading automatically acknowledges. */
+	np->intr_status =3D readl(ioaddr + IntrStatus);
=20
-		if (netif_msg_intr(np))
-			printk(KERN_DEBUG
-				"%s: Interrupt, status %#08x, mask %#08x.\n",
-				dev->name, intr_status,
-				readl(ioaddr + IntrMask));
+	if (netif_msg_intr(np))
+		printk(KERN_DEBUG
+		       "%s: Interrupt, status %#08x, mask %#08x.\n",
+		       dev->name, np->intr_status,
+		       readl(ioaddr + IntrMask));
=20
-		if (intr_status =3D=3D 0)
-			break;
-		handled =3D 1;
+	if (!np->intr_status)=20
+		return IRQ_NONE;
=20
-		if (intr_status &
-		   (IntrRxDone | IntrRxIntr | RxStatusFIFOOver |
-		    IntrRxErr | IntrRxOverrun)) {
-			netdev_rx(dev);
-		}
+	prefetch(&np->rx_skbuff[np->cur_rx % RX_RING_SIZE]);
+
+	if (netif_rx_schedule_prep(dev)) {
+		/* Disable interrupts and register for poll */
+		natsemi_irq_disable(dev);
+		__netif_rx_schedule(dev);
+	}
+	return IRQ_HANDLED;
+}
=20
-		if (intr_status &
-		   (IntrTxDone | IntrTxIntr | IntrTxIdle | IntrTxErr)) {
+/* This is the NAPI poll routine.  As well as the standard RX handling
+ * it also handles all other interrupts that the chip might raise.
+ */
+static int natsemi_poll(struct net_device *dev, int *budget)
+{
+	struct netdev_private *np =3D netdev_priv(dev);
+	void __iomem * ioaddr =3D ns_ioaddr(dev);
+
+	int work_to_do =3D min(*budget, dev->quota);
+	int work_done =3D 0;
+
+	do {
+		if (np->intr_status &
+		    (IntrTxDone | IntrTxIntr | IntrTxIdle | IntrTxErr)) {
 			spin_lock(&np->lock);
 			netdev_tx_done(dev);
 			spin_unlock(&np->lock);
 		}
=20
 		/* Abnormal error summary/uncommon events handlers. */
-		if (intr_status & IntrAbnormalSummary)
-			netdev_error(dev, intr_status);
-
-		if (--boguscnt < 0) {
-			if (netif_msg_intr(np))
-				printk(KERN_WARNING
-					"%s: Too much work at interrupt, "
-					"status=3D%#08x.\n",
-					dev->name, intr_status);
-			break;
+		if (np->intr_status & IntrAbnormalSummary)
+			netdev_error(dev, np->intr_status);
+	=09
+		if (np->intr_status &
+		    (IntrRxDone | IntrRxIntr | RxStatusFIFOOver |
+		     IntrRxErr | IntrRxOverrun)) {
+			netdev_rx(dev, &work_done, work_to_do);
 		}
-	} while (1);
+	=09
+		*budget -=3D work_done;
+		dev->quota -=3D work_done;
=20
-	if (netif_msg_intr(np))
-		printk(KERN_DEBUG "%s: exiting interrupt.\n", dev->name);
+		if (work_done >=3D work_to_do)
+			return 1;
+
+		np->intr_status =3D readl(ioaddr + IntrStatus);
+	} while (np->intr_status);
=20
-	return IRQ_RETVAL(handled);
+	netif_rx_complete(dev);
+
+	/* Reenable interrupts providing nothing is trying to shut
+	 * the chip down. */
+	spin_lock(&np->lock);
+	if (!np->hands_off && netif_running(dev))
+		natsemi_irq_enable(dev);
+	spin_unlock(&np->lock);
+
+	return 0;
 }
=20
 /* This routine is logically part of the interrupt handler, but separated
    for clarity and better register allocation. */
-static void netdev_rx(struct net_device *dev)
+static void netdev_rx(struct net_device *dev, int *work_done, int work_to_=
do)
 {
 	struct netdev_private *np =3D netdev_priv(dev);
 	int entry =3D np->cur_rx % RX_RING_SIZE;
@@ -2237,6 +2275,12 @@ static void netdev_rx(struct net_device=20
 				entry, desc_status);
 		if (--boguscnt < 0)
 			break;
+
+		if (*work_done >=3D work_to_do)
+			break;
+
+		(*work_done)++;
+
 		pkt_len =3D (desc_status & DescSizeMask) - 4;
 		if ((desc_status&(DescMore|DescPktOK|DescRxLong)) !=3D DescPktOK){
 			if (desc_status & DescMore) {
@@ -2293,7 +2337,7 @@ static void netdev_rx(struct net_device=20
 				np->rx_skbuff[entry] =3D NULL;
 			}
 			skb->protocol =3D eth_type_trans(skb, dev);
-			netif_rx(skb);
+			netif_receive_skb(skb);
 			dev->last_rx =3D jiffies;
 			np->stats.rx_packets++;
 			np->stats.rx_bytes +=3D pkt_len;
@@ -3074,9 +3118,7 @@ static int netdev_close(struct net_devic
 	del_timer_sync(&np->timer);
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
-	/* Disable interrupts, and flush posted writes */
-	writel(0, ioaddr + IntrEnable);
-	readl(ioaddr + IntrEnable);
+	natsemi_irq_disable(dev);
 	np->hands_off =3D 1;
 	spin_unlock_irq(&np->lock);
 	enable_irq(dev->irq);
@@ -3158,6 +3200,9 @@ static void __devexit natsemi_remove1 (s
  *	* netdev_timer: timer stopped by natsemi_suspend.
  *	* intr_handler: doesn't acquire the spinlock. suspend calls
  *		disable_irq() to enforce synchronization.
+ *      * natsemi_poll: checks before reenabling interrupts.  suspend
+ *              sets hands_off, disables interrupts and then waits with
+ *              netif_poll_disable().
  *
  * Interrupts must be disabled, otherwise hands_off can cause irq storms.
  */
@@ -3183,6 +3228,8 @@ static int natsemi_suspend (struct pci_d
 		spin_unlock_irq(&np->lock);
 		enable_irq(dev->irq);
=20
+		netif_poll_disable(dev);
+
 		/* Update the error counts. */
 		__get_stats(dev);
=20
@@ -3235,6 +3282,7 @@ static int natsemi_resume (struct pci_de
 		mod_timer(&np->timer, jiffies + 1*HZ);
 	}
 	netif_device_attach(dev);
+	netif_poll_enable(dev);
 out:
 	rtnl_unlock();
 	return 0;

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ6np2w2erOLNe+68AQJBvgP/chF1FX+sFiWGDFSNuOPUhnbj88TijoYg
j2nTipkuPvXDXCr1kWCLfdU74a8FqzamW54AwRpeTR/suhNcrvzHpNqa4c4blRvv
61vP03UQCz7+UFFjRxmU1UI+rRzYk2PftqDsmuUAUKgRLmv8p/OHPmGHVrlZtnsr
DXomvquXxsI=
=d6PW
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
