Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTAXSRn>; Fri, 24 Jan 2003 13:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTAXSRn>; Fri, 24 Jan 2003 13:17:43 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:25866 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262871AbTAXSRl>; Fri, 24 Jan 2003 13:17:41 -0500
Date: Fri, 24 Jan 2003 21:26:08 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] 3c59x.c: pci_{save,restore}_extended_state
Message-ID: <20030124212608.B25285@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is kind of example of converting to new
pci_XX_extended_state stuff.
I used 3c905B to test the changes, but it has only
the PM capability and actually works fine with just
pci_{save,restore}_state.

Ivan.

--- 2.5.59/drivers/net/3c59x.c	Fri Jan 17 05:21:33 2003
+++ linux/drivers/net/3c59x.c	Tue Jan 21 15:55:20 2003
@@ -814,7 +814,7 @@ struct vortex_private {
 	u16 io_size;						/* Size of PCI region (for release_region) */
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
-	u32 power_state[16];
+	u32 *power_state;
 };
 
 #define DEVICE_PCI(dev) (((dev)->bus == &pci_bus_type) ? to_pci_dev((dev)) : NULL)
@@ -1142,6 +1142,13 @@ static int __devinit vortex_probe1(struc
 		if (request_region(ioaddr, vci->io_size, print_name) != NULL)
 			vp->must_free_region = 1;
 
+		vp->power_state = pci_alloc_extended_state(pdev);
+		if (!vp->power_state) {
+			printk (KERN_ERR PFX "unable to allocate "
+				"power_state buffer, aborting\n");
+			goto free_region;
+		}
+
 		/* enable bus-mastering if necessary */		
 		if (vci->flags & PCI_USES_MASTER)
 			pci_set_master (pdev);
@@ -1172,7 +1179,6 @@ static int __devinit vortex_probe1(struc
 	vp->rx_ring = pci_alloc_consistent(pdev, sizeof(struct boom_rx_desc) * RX_RING_SIZE
 					   + sizeof(struct boom_tx_desc) * TX_RING_SIZE,
 					   &vp->rx_ring_dma);
-	retval = -ENOMEM;
 	if (vp->rx_ring == 0)
 		goto free_region;
 
@@ -1435,7 +1441,7 @@ static int __devinit vortex_probe1(struc
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
 	if (pdev && vp->enable_wol) {
 		vp->pm_state_valid = 1;
- 		pci_save_state(VORTEX_PCI(vp), vp->power_state);
+ 		pci_save_extended_state(VORTEX_PCI(vp), vp->power_state);
  		acpi_set_WOL(dev);
 	}
 	retval = register_netdev(dev);
@@ -1492,7 +1498,7 @@ vortex_up(struct net_device *dev)
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
-		pci_restore_state(VORTEX_PCI(vp), vp->power_state);
+		pci_restore_extended_state(VORTEX_PCI(vp), vp->power_state);
 	}
 
 	/* Before initializing select the active media port. */
@@ -2632,7 +2638,7 @@ vortex_down(struct net_device *dev)
 		outl(0, ioaddr + DownListPtr);
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_save_state(VORTEX_PCI(vp), vp->power_state);
+		pci_save_extended_state(VORTEX_PCI(vp), vp->power_state);
 		acpi_set_WOL(dev);
 	}
 }
@@ -3024,7 +3030,9 @@ static void __devexit vortex_remove_one 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		if (vp->pm_state_valid)
-			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
+			pci_restore_extended_state(VORTEX_PCI(vp),
+						   vp->power_state);
+		kfree(vp->power_state);
 	}
 
 	pci_free_consistent(pdev,
