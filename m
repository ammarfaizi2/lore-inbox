Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270295AbTGMQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270296AbTGMQ4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:56:48 -0400
Received: from ip008.siteplanet.com.br ([200.245.54.8]:55819 "EHLO
	plutao.siteplanet.com.br") by vger.kernel.org with ESMTP
	id S270295AbTGMQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:56:32 -0400
Subject: [PATCH] RealTek(R) RTL-8169 PCI Gigabit Ethernet Card
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Donald Becker <becker@scyld.com>,
       RealTek Mailing List <realtek@scyld.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-jAmswXl8yk1zhej6jSTK"
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Jul 2003 14:00:12 -0300
Message-Id: <1058115615.887.85.camel@nitrogenium>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jAmswXl8yk1zhej6jSTK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

Here's a patch for the new RealTek(R) RTL-8169 PCI Gigabit driver
(drivers/net/r8169.c) in the 2.4.22-pre5 kernel. This patch fixes
severals functions, add new PCI suspend and resume stuff and cleanup
code.

The patch applies against 2.4.22-pre5 and 2.5.75. I've tested the=20
compilation with 2.4.22-pre5.


Cheers!

--=20
Fernando Alencar Mar=F3stica
Graduate Student, Computer Science
Linux Register User Id #281457

University Methodist of Piracicaba
Departament of Computer Science
email: famarost@unimep.br
homepage: http://www.unimep.br/~famarost

--=-jAmswXl8yk1zhej6jSTK
Content-Disposition: attachment; filename=r8169-linux-2.4.22-pre5.pach
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=r8169-linux-2.4.22-pre5.pach; charset=ISO-8859-1

--- r8169.c.orig	Sun Jul 13 13:32:55 2003
+++ r8169.c	Sun Jul 13 13:55:02 2003
@@ -32,7 +32,15 @@
 	- Use ether_crc in stock kernel (linux/crc32.h)
 	- Copy mc_filter setup code from 8139cp
 	  (includes an optimization, and avoids set_bit use)
-
+=09
+	<2003/07/13>
+	Fernando Alencar Marostica <famarost@unimep.br>
+		- Fix rtl8169_init_one()=09
+		- Fix rtl8169_get_stats()
+		- Fix rtl8169_remove_one()
+		- Add new rtl8169_resume() support
+		- Add new rtl8169_suspend() support
+		- Several fixes and cleanup code
 */
=20
 #include <linux/module.h>
@@ -46,9 +54,9 @@
 #include <asm/io.h>
=20
 #define RTL8169_VERSION "1.2"
-#define MODULENAME "r8169"
-#define RTL8169_DRIVER_NAME   MODULENAME " Gigabit Ethernet driver " RTL81=
69_VERSION
-#define PFX MODULENAME ": "
+#define MODULE_NAME "r8169"
+#define RTL8169_DRIVER_NAME   MODULE_NAME " Realtek(R) RTL-8169 PCI Gigabi=
t Ethernet Card " RTL8169_VERSION
+#define PFX MODULE_NAME ": "
=20
 #ifdef RTL8169_DEBUG
 #define assert(expr) \
@@ -101,11 +109,17 @@
 #define RTL_R16(reg)		readw (ioaddr + (reg))
 #define RTL_R32(reg)		((unsigned long) readl (ioaddr + (reg)))
=20
-static struct {
+
+struct rtl8169_card_info {
 	const char *name;
-} board_info[] __devinitdata =3D {
-	{
-"RealTek RTL8169 Gigabit Ethernet"},};
+	u8 mac_version;		/* depend on RTL8169 docs */
+	u32 RxConfigMask;	/* should clear the bits supported by this chip */
+};
+
+struct rtl8169_card_info rtl8169_card_info_tbl[] __devinitdata =3D {
+	{ "RealTek RTL8169 Gigabit Ethernet", 0x02, 0xff7e1880 },
+	{ "RealTek RTL8169s/8110s Gigabit Ethernet", 0x03, 0xff7e1880 },
+};
=20
 static struct pci_device_id rtl8169_pci_tbl[] __devinitdata =3D {
 	{0x10ec, 0x8169, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -287,16 +301,19 @@
 	unsigned char *RxBufferRings;	/* Index of Rx Buffer  */
 	unsigned char *RxBufferRing[NUM_RX_DESC];	/* Index of Rx Buffer array */
 	struct sk_buff *Tx_skbuff[NUM_TX_DESC];	/* Index of Transmit data buffer =
*/
+#ifdef CONFIG_PM
+	u32 power_state[16];
+#endif
 };
=20
 MODULE_AUTHOR("Realtek");
-MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
+MODULE_DESCRIPTION("RealTek(R) RTL-8169 PCI Gigabit Ethernet Card");
+MODULE_LICENSE("GPL");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "i");
=20
 static int rtl8169_open(struct net_device *dev);
-static int rtl8169_start_xmit(struct sk_buff *skb, struct net_device *dev)=
;
-static void rtl8169_interrupt(int irq, void *dev_instance,
-			      struct pt_regs *regs);
+static int rtl8169_start_xmit(struct sk_buff *skb,struct net_device *dev);
+static void rtl8169_interrupt(int irq,void *dev_instance,struct pt_regs *r=
egs);
 static void rtl8169_init_ring(struct net_device *dev);
 static void rtl8169_hw_start(struct net_device *dev);
 static int rtl8169_close(struct net_device *dev);
@@ -358,6 +375,7 @@
 	int rc, i;
 	unsigned long mmio_start, mmio_end, mmio_flags, mmio_len;
 	u32 tmp;
+	int acpi_idle_state =3D 0, pm_cap;
=20
 	assert(pdev !=3D NULL);
 	assert(ioaddr_out !=3D NULL);
@@ -365,20 +383,34 @@
 	*ioaddr_out =3D NULL;
 	*dev_out =3D NULL;
=20
-	// dev zeroed in alloc_etherdev=20
+	/* dev zeroed in alloc_etherdev */
 	dev =3D alloc_etherdev(sizeof (*tp));
-	if (dev =3D=3D NULL) {
-		printk(KERN_ERR PFX "unable to alloc new ethernet\n");
+	if (!dev) {
+		printk(KERN_ERR PFX "%s: Could not allocate new ethernet device.\n", pde=
v->slot_name);
 		return -ENOMEM;
 	}
=20
 	SET_MODULE_OWNER(dev);
 	tp =3D dev->priv;
=20
-	// enable device (incl. PCI PM wakeup and hotplug setup)
+	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc =3D pci_enable_device(pdev);
-	if (rc)
+	if(rc) {
+		printk(KERN_ERR PFX "%s: unable to enable device\n", pdev->slot_name);
 		goto err_out;
+	}
+
+	/* save power state before pci_enable_device overwrites it */
+	pm_cap =3D pci_find_capability(pdev, PCI_CAP_ID_PM);
+	if (pm_cap) {
+		u16 pwr_command;
+		pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pwr_command);
+		acpi_idle_state =3D pwr_command & PCI_PM_CTRL_STATE_MASK;
+	}
+	else {
+		printk(KERN_ERR PFX "Cannot find PowerManagement capability, aborting.\n=
");
+		goto err_out_free_res;
+	}
=20
 	mmio_start =3D pci_resource_start(pdev, 1);
 	mmio_end =3D pci_resource_end(pdev, 1);
@@ -400,10 +432,12 @@
 	}
=20
 	rc =3D pci_request_regions(pdev, dev->name);
-	if (rc)
+	if(rc) {
+		printk(KERN_ERR PFX "%s: Could not request regions.\n", pdev->slot_name)=
;
 		goto err_out_disable;
-
-	// enable PCI bus-mastering
+    }
+	=09
+	/* enable PCI bus-mastering */
 	pci_set_master(pdev);
=20
 	// ioremap MMIO region=20
@@ -464,7 +498,6 @@
 	struct rtl8169_private *tp =3D NULL;
 	void *ioaddr =3D NULL;
 	static int board_idx =3D -1;
-	static int printed_version =3D 0;
 	int i, rc;
 	int option =3D -1, Cap10_100 =3D 0, Cap1000 =3D 0;
=20
@@ -473,10 +506,15 @@
=20
 	board_idx++;
=20
-	if (!printed_version) {
-		printk(KERN_INFO RTL8169_DRIVER_NAME " loaded\n");
-		printed_version =3D 1;
+#ifndef MODULE
+	{
+		/* when built-in, we only print version if device is found */
+		static int did_version;
+	=09
+		if (!did_version++)
+			printk(KERN_INFO RTL8169_DRIVER_NAME " loaded\n");
 	}
+#endif
=20
 	rc =3D rtl8169_init_board(pdev, &dev, &ioaddr);
 	if (rc)
@@ -500,7 +538,7 @@
 	dev->watchdog_timeo =3D TX_TIMEOUT;
 	dev->irq =3D pdev->irq;
 	dev->base_addr =3D (unsigned long) ioaddr;
-//      dev->do_ioctl           =3D mii_ioctl;
+	//dev->do_ioctl           =3D mii_ioctl;
=20
 	tp =3D dev->priv;		// private data //
 	tp->pci_dev =3D pdev;
@@ -526,7 +564,7 @@
 	       "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, "
 	       "IRQ %d\n",
 	       dev->name,
-	       board_info[ent->driver_data].name,
+	       rtl8169_card_info_tbl[ent->driver_data].name,
 	       dev->base_addr,
 	       dev->dev_addr[0], dev->dev_addr[1],
 	       dev->dev_addr[2], dev->dev_addr[3],
@@ -627,28 +665,104 @@
 	return 0;
 }
=20
-static void __devexit
-rtl8169_remove_one(struct pci_dev *pdev)
+/**
+ *  rtl8169_get_stats: - Get rtl8169 read/write statistics
+ *  @ethernet_device: The Ethernet Device to get statistics for
+ *
+ *  Get TX/RX statistics for rtl8169
+ */
+struct net_device_stats *rtl8169_get_stats (struct net_device *ethernet_de=
vice)
 {
-	struct net_device *dev =3D pci_get_drvdata(pdev);
-	struct rtl8169_private *tp =3D dev->priv;
+	struct rtl8169_private *tp =3D ethernet_device->priv;
+	void *ioaddr =3D tp->mmio_addr;
+	unsigned long flags;
=20
-	assert(dev !=3D NULL);
-	assert(tp !=3D NULL);
+	if (netif_running(ethernet_device)) {
+		spin_lock_irqsave (&tp->lock, flags);
+		tp->stats.rx_missed_errors +=3D ((unsigned long) readl (ioaddr + (RxMiss=
ed)));
+		writel ((0), ioaddr + (RxMissed));
+		spin_unlock_irqrestore (&tp->lock, flags);
+	}
=20
-	unregister_netdev(dev);
-	iounmap(tp->mmio_addr);
-	pci_release_regions(pdev);
+	return &tp->stats;
+}
=20
-	// poison memory before freeing=20
-	memset(dev, 0xBC,
-	       sizeof (struct net_device) + sizeof (struct rtl8169_private));
+/**
+ *  rtl8169_remove_one: - Remove rtl8169 device=20
+ *  @pci_device: The PCI Device to be removed
+ *
+ *  Remove and release rtl8169 PCI Ethernet Device
+ */
+static void __devexit rtl8169_remove_one (struct pci_dev *pci_device)
+{
+	struct net_device *ethernet_device =3D pci_get_drvdata (pci_device);
+	struct rtl8169_private *tp =3D (struct rtl8169_private *) (ethernet_devic=
e->priv);
=20
-	pci_disable_device(pdev);
-	kfree(dev);
-	pci_set_drvdata(pdev, NULL);
+	if (!ethernet_device)
+		BUG();
+
+	unregister_netdev(ethernet_device);
+	iounmap((char *) (tp->mmio_addr));
+=09
+#ifdef CONFIG_PM
+	pci_set_power_state (pci_device, 0);
+	pci_restore_state (pci_device, tp->power_state);
+#endif
+=09
+	pci_release_regions(pci_device);
+	pci_disable_device(pci_device);
+	pci_set_drvdata(pci_device, NULL);
+=09
+	/* poison memory before freeing */
+	memset(ethernet_device, 0xBC, sizeof(struct net_device) + sizeof(struct r=
tl8169_private));
+	kfree(ethernet_device);
+}
+
+
+#ifdef CONFIG_PM
+
+static int rtl8169_suspend (struct pci_dev *pci_device, u32 state)
+{
+	struct net_device *ethernet_device =3D pci_get_drvdata (pci_device);
+	struct rtl8169_private *tp =3D (struct rtl8169_private *) (ethernet_devic=
e->priv);
+	void *ioaddr =3D tp->mmio_addr;
+	unsigned long flags;
+						   =20
+	if (!netif_running (ethernet_device))
+		return 0;
+
+	netif_device_detach (ethernet_device);
+	netif_stop_queue (ethernet_device);
+	spin_lock_irqsave (&tp->lock, flags);
+
+	/* Disable interrupts, stop Rx and Tx */
+	writew ((0), ioaddr + (IntrMask));
+	writeb ((0), ioaddr + (ChipCmd));=09
+
+	/* Update the error counts. */
+	tp->stats.rx_missed_errors +=3D RTL_R32 (RxMissed);
+	writel ((0), ioaddr + (RxMissed));
+	spin_unlock_irqrestore (&tp->lock, flags);
+
+	return 0;
+}
+
+static int rtl8169_resume (struct pci_dev *pci_device)
+{  =20
+	struct net_device *ethernet_device =3D pci_get_drvdata (pci_device);
+			   =20
+	if (!netif_running (ethernet_device))
+		return 0;
+				   =20
+	netif_device_attach (ethernet_device);
+	rtl8169_hw_start (ethernet_device);
+	netif_start_queue (ethernet_device);
+=09
+	return 0;
 }
=20
+#endif /* CONFIG_PM */
+
 static int
 rtl8169_open(struct net_device *dev)
 {
@@ -696,6 +810,7 @@
=20
 	rtl8169_init_ring(dev);
 	rtl8169_hw_start(dev);
+	netif_start_queue(dev);
=20
 	return 0;
=20
@@ -752,9 +867,6 @@
=20
 	/* Enable all known interrupts by setting the interrupt mask. */
 	RTL_W16(IntrMask, rtl8169_intr_mask);
-
-	netif_start_queue(dev);
-
 }
=20
 static void
@@ -1108,21 +1220,17 @@
 	spin_unlock_irqrestore(&tp->lock, flags);
 }
=20
-struct net_device_stats *
-rtl8169_get_stats(struct net_device *dev)
-{
-	struct rtl8169_private *tp =3D dev->priv;
=20
-	return &tp->stats;
-}
=20
 static struct pci_driver rtl8169_pci_driver =3D {
-	.name		=3D MODULENAME,
+	.name		=3D MODULE_NAME,
 	.id_table	=3D rtl8169_pci_tbl,
 	.probe		=3D rtl8169_init_one,
 	.remove		=3D __devexit_p(rtl8169_remove_one),
-	.suspend	=3D NULL,
-	.resume		=3D NULL,
+#ifdef CONFIG_PM
+	.suspend	=3D rtl8169_suspend,
+	.resume		=3D rtl8169_resume,
+#endif
 };
=20
 static int __init

--=-jAmswXl8yk1zhej6jSTK--

