Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265317AbRGBPnT>; Mon, 2 Jul 2001 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbRGBPnJ>; Mon, 2 Jul 2001 11:43:09 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:46240 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265317AbRGBPmy>; Mon, 2 Jul 2001 11:42:54 -0400
Message-ID: <3B4096D9.36F40BF4@uow.edu.au>
Date: Tue, 03 Jul 2001 01:44:25 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@unhappy.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL with 3c59x and 2.4.6-pre6 breaks WOL
In-Reply-To: <Pine.LNX.4.33.0106291257180.3935-200000@boris.prodako.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> I just tried 2.4.6-pre6 this morning, and found out that when I enable
> WOL (using enable_wol=1), my 3c905c-tx does not work at all any more.
> It worked just fine with 2.4.5.  Without enable_wol=1, I have no problems.
> 
> It is my guess that this is very easy to reproduce, but if not, please ask
> me for more details.  I'm attaching the dmesg output.  I'll be gone until
> monday.

Seems that the new PM code has broken the driver.  It
wasn't doing the right thing in the first place.

Please use 2.4.6-pre8 plus this patch, let me know.

--- linux-2.4.6-pre8/drivers/pci/pci.c	Sun Jul  1 16:11:25 2001
+++ linux-akpm/drivers/pci/pci.c	Tue Jul  3 01:28:35 2001
@@ -425,7 +425,7 @@ int pci_enable_wake(struct pci_dev *dev,
 
 	if (enable) value |= PCI_PM_CTRL_PME_STATUS;
 	else value &= ~PCI_PM_CTRL_PME_STATUS;
-
+	value |= PCI_PM_CTRL_PME_ENABLE;
 	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
 	
 	return 0;
--- linux-2.4.6-pre8/drivers/net/3c59x.c	Sun Jul  1 16:11:24 2001
+++ linux-akpm/drivers/net/3c59x.c	Tue Jul  3 01:29:08 2001
@@ -760,6 +760,7 @@ struct vortex_private {
 	u16 io_size;						/* Size of PCI region (for release_region) */
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
+	u32 power_state[16];
 };
 
 /* The action to take with a media selection timer tick.
@@ -1239,9 +1240,6 @@ static int __devinit vortex_probe1(struc
 		}
 	}
 
-	if (pdev && vp->enable_wol && (vp->capabilities & CapPwrMgmt))
-		acpi_set_WOL(dev);
-
 	if (vp->capabilities & CapBusMaster) {
 		vp->full_bus_master_tx = 1;
 		printk(KERN_INFO"  Enabling bus-master transmits and %s receives.\n",
@@ -1279,6 +1277,10 @@ static int __devinit vortex_probe1(struc
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
+	if (pdev && vp->enable_wol) {
+		pci_save_state(vp->pdev, vp->power_state);
+		acpi_set_WOL(dev);
+	}
 	retval = register_netdev(dev);
 	if (retval == 0)
 		return 0;
@@ -1331,8 +1333,10 @@ vortex_up(struct net_device *dev)
 	unsigned int config;
 	int i;
 
-	if (vp->pdev && vp->enable_wol)			/* AKPM: test not needed? */
+	if (vp->pdev && vp->enable_wol) {
 		pci_set_power_state(vp->pdev, 0);	/* Go active */
+		pci_restore_state(vp->pdev, vp->power_state);
+	}
 
 	/* Before initializing select the active media port. */
 	EL3WINDOW(3);
@@ -1516,9 +1520,6 @@ vortex_open(struct net_device *dev)
 	int i;
 	int retval;
 
-	if (vp->pdev && vp->enable_wol)				/* AKPM: test not needed? */
-		pci_set_power_state(vp->pdev, 0);		/* Go active */
-
 	/* Use the now-standard shared IRQ implementation. */
 	if ((retval = request_irq(dev->irq, vp->full_bus_master_rx ?
 				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev))) {
@@ -2452,8 +2453,10 @@ vortex_down(struct net_device *dev)
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (vp->pdev && vp->enable_wol && (vp->capabilities & CapPwrMgmt))
+	if (vp->pdev && vp->enable_wol) {
+		pci_save_state(vp->pdev, vp->power_state);
 		acpi_set_WOL(dev);
+	}
 }
 
 static int
@@ -2808,8 +2811,10 @@ static void acpi_set_WOL(struct net_devi
 	/* The RxFilter must accept the WOL frames. */
 	outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
 	outw(RxEnable, ioaddr + EL3_CMD);
+
 	/* Change the power state to D3; RxEnable doesn't take effect. */
-	pci_set_power_state(vp->pdev, 0x8103);
+	pci_enable_wake(vp->pdev, 0, 1);
+	pci_set_power_state(vp->pdev, 3);
 }
