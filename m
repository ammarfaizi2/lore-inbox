Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbULRAQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbULRAQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbULRAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:16:42 -0500
Received: from gprs215-176.eurotel.cz ([160.218.215.176]:52365 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262249AbULRAKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:10:03 -0500
Date: Sat, 18 Dec 2004 01:09:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041218000920.GE29084@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217220208.GA22752@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Alright, I've applied this, and it will show up in the next -mm release.
> I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> functions.
> 
> Now, care to send patches to fix up all of the new sparse warnings in
> the drivers/pci/* directory?

This should fix warnings in drivers/net/* and bttv (with exception of
via-rhine, which I'll do separately). Do you think you could apply it,
or shall I ask Andrew, or... ?

Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- clean/drivers/media/video/bttv-driver.c	2004-10-01 00:30:14.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-11-01 21:25:09.000000000 +0100
@@ -3945,7 +3945,7 @@
 
 	/* save pci state */
 	pci_save_state(pci_dev, btv->state.pci_cfg);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, device_to_pci_power(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
 	}
@@ -3964,7 +3964,7 @@
 		pci_enable_device(pci_dev);
 		btv->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev, btv->state.pci_cfg);
 
 	/* restore bt878 state */
--- clean/drivers/net/3c59x.c	2004-10-19 14:16:28.000000000 +0200
+++ linux/drivers/net/3c59x.c	2004-11-14 23:36:46.000000000 +0100
@@ -1550,7 +1550,7 @@
 	int i;
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 
@@ -2942,7 +2942,7 @@
 	/* The kernel core really should have pci_get_power_state() */
 
 	if(state != 0)
-		pci_set_power_state(VORTEX_PCI(vp), 0);
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);
 	err = vortex_do_ioctl(dev, rq, cmd);
 	if(state != 0)
 		pci_set_power_state(VORTEX_PCI(vp), state);
@@ -3141,7 +3141,7 @@
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
 	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
-	pci_set_power_state(VORTEX_PCI(vp), 3);
+	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
 }
 
 
@@ -3164,7 +3164,7 @@
 	unregister_netdev(dev);
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
--- clean/drivers/net/8139cp.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/8139cp.c	2004-11-14 23:36:46.000000000 +0100
@@ -1623,7 +1623,7 @@
 static void cp_set_d3_state (struct cp_private *cp)
 {
 	pci_enable_wake (cp->pdev, 0, 1); /* Enable PME# generation */
-	pci_set_power_state (cp->pdev, 3);
+	pci_set_power_state (cp->pdev, PCI_D3hot);
 }
 
 static int cp_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1813,7 +1813,7 @@
 		BUG();
 	unregister_netdev(dev);
 	iounmap(cp->regs);
-	if (cp->wol_enabled) pci_set_power_state (pdev, 0);
+	if (cp->wol_enabled) pci_set_power_state (pdev, PCI_D0);
 	pci_release_regions(pdev);
 	pci_clear_mwi(pdev);
 	pci_disable_device(pdev);
@@ -1863,7 +1863,7 @@
 	netif_device_attach (dev);
 	
 	if (cp->pdev && cp->wol_enabled) {
-		pci_set_power_state (cp->pdev, 0);
+		pci_set_power_state (cp->pdev, PCI_D0);
 		pci_restore_state (cp->pdev, cp->power_state);
 	}
 	
--- clean/drivers/net/8139too.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/8139too.c	2004-11-01 20:41:29.000000000 +0100
@@ -2608,7 +2608,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -2622,7 +2622,7 @@
 	pci_restore_state (pdev, tp->pci_state);
 	if (!netif_running (dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	netif_device_attach (dev);
--- clean/drivers/net/amd8111e.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/amd8111e.c	2004-11-14 23:48:04.000000000 +0100
@@ -1865,17 +1865,17 @@
 		if(lp->options & OPTION_WAKE_PHY_ENABLE)
 			amd8111e_enable_link_change(lp);	
 		
-		pci_enable_wake(pci_dev, 3, 1);
-		pci_enable_wake(pci_dev, 4, 1); /* D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 1);
+		pci_enable_wake(pci_dev, PCI_D3cold, 1);
 
 	}
 	else{		
-		pci_enable_wake(pci_dev, 3, 0);
-		pci_enable_wake(pci_dev, 4, 0); /* 4 == D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 0);
+		pci_enable_wake(pci_dev, PCI_D3cold, 0);
 	}
 	
 	pci_save_state(pci_dev, lp->pm_state);
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 
 	return 0;
 }
@@ -1887,11 +1887,11 @@
 	if (!netif_running(dev))
 		return 0;
 
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev, lp->pm_state);
 
-	pci_enable_wake(pci_dev, 3, 0);
-	pci_enable_wake(pci_dev, 4, 0); /* D3 cold */
+	pci_enable_wake(pci_dev, PCI_D3hot, 0);
+	pci_enable_wake(pci_dev, PCI_D3cold, 0);
 
 	netif_device_attach(dev);
 
--- clean/drivers/net/e100.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/e100.c	2004-11-14 23:36:46.000000000 +0100
@@ -2313,7 +2313,7 @@
 	pci_save_state(pdev, nic->pm_state);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -2323,7 +2323,7 @@
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, nic->pm_state);
 	e100_hw_init(nic);
 
--- clean/drivers/net/eepro100.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/eepro100.c	2004-11-14 23:36:46.000000000 +0100
@@ -1015,7 +1005,7 @@
 	if (netif_msg_ifup(sp))
 		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", dev->name, dev->irq);
 
-	pci_set_power_state(sp->pdev, 0);
+	pci_set_power_state(sp->pdev, PCI_D0);
 
 	/* Set up the Tx queue early.. */
 	sp->cur_tx = 0;
@@ -1964,7 +1954,7 @@
 	if (netif_msg_ifdown(sp))
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	pci_set_power_state(sp->pdev, PCI_D2);
 
 	return 0;
 }
@@ -2103,7 +2093,7 @@
 		   access from the timeout handler.
 		   They are currently serialized only with MDIO access from the
 		   timer routine.  2000/05/09 SAW */
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		if (t)
@@ -2114,7 +2104,7 @@
 	case SIOCSMIIREG:		/* Write MII PHY register. */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		mdio_write(dev, data->phy_id, data->reg_num, data->val_in);
 		if (t)
--- clean/drivers/net/pci-skeleton.c	2004-08-15 19:14:58.000000000 +0200
+++ linux/drivers/net/pci-skeleton.c	2004-11-14 23:36:46.000000000 +0100
@@ -1922,7 +1922,7 @@
 	spin_unlock_irqrestore (&tp->lock, flags);
 
 	pci_save_state (pdev, tp->pci_state);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -1935,7 +1935,7 @@
 
 	if (!netif_running(dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state (pdev, tp->pci_state);
 	netif_device_attach (dev);
 	netdrv_hw_start (dev);
--- clean/drivers/net/sis900.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/sis900.c	2004-11-14 23:36:46.000000000 +0100
@@ -2212,7 +2212,7 @@
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 	pci_save_state(pci_dev, sis_priv->pci_state);
 
 	return 0;
@@ -2227,7 +2227,7 @@
 	if(!netif_running(net_dev))
 		return 0;
 	pci_restore_state(pci_dev, sis_priv->pci_state);
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 
 	sis900_init_rxfilter(net_dev);
 
--- clean/drivers/net/starfire.c	2004-08-15 19:14:58.000000000 +0200
+++ linux/drivers/net/starfire.c	2004-11-14 23:36:46.000000000 +0100
@@ -2186,7 +2186,7 @@
 	unregister_netdev(dev);
 
 	/* XXX: add wakeup code -- requires firmware for MagicPacket */
-	pci_set_power_state(pdev, 3);	/* go to sleep in D3 mode */
+	pci_set_power_state(pdev, PCI_D3hot);	/* go to sleep in D3 mode */
 	pci_disable_device(pdev);
 
 	iounmap((char *)dev->base_addr);
--- clean/drivers/net/typhoon.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/net/typhoon.c	2004-11-14 23:36:46.000000000 +0100
@@ -1884,7 +1884,7 @@
 
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, state);
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int
@@ -1893,7 +1893,7 @@
 	struct pci_dev *pdev = tp->pdev;
 	void __iomem *ioaddr = tp->ioaddr;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, tp->pci_state);
 
 	/* Post 2.x.x versions of the Sleep Image require a reset before
@@ -2541,7 +2541,7 @@
 	struct typhoon *tp = (struct typhoon *) (dev->priv);
 
 	unregister_netdev(dev);
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, tp->pci_state);
 	typhoon_reset(tp->ioaddr, NoWait);
 	iounmap(tp->ioaddr);
--- clean/drivers/net/via-velocity.c	2004-10-19 14:16:28.000000000 +0200
+++ linux/drivers/net/via-velocity.c	2004-11-14 23:36:46.000000000 +0100
@@ -804,7 +804,7 @@
 	
 	/* and leave the chip powered down */
 	
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 #ifdef CONFIG_PM
 	{
 		unsigned long flags;
@@ -1742,7 +1742,7 @@
 		goto err_free_rd_ring;
 	
 	/* Ensure chip is running */	
-	pci_set_power_state(vptr->pdev, 0);
+	pci_set_power_state(vptr->pdev, PCI_D0);
 	
 	velocity_init_registers(vptr, VELOCITY_INIT_COLD);
 
@@ -1750,7 +1750,7 @@
 			  dev->name, dev);
 	if (ret < 0) {
 		/* Power down the chip */
-		pci_set_power_state(vptr->pdev, 3);
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 		goto err_free_td_ring;
 	}
 
@@ -1868,7 +1868,7 @@
 		free_irq(dev->irq, dev);
 		
 	/* Power down the chip */
-	pci_set_power_state(vptr->pdev, 3);
+	pci_set_power_state(vptr->pdev, PCI_D3hot);
 	
 	/* Free the resources */
 	velocity_free_td_ring(vptr);
@@ -2194,8 +2194,8 @@
 	/* If we are asked for information and the device is power
 	   saving then we need to bring the device back up to talk to it */
 	   	
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 0);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D0);
 		
 	switch (cmd) {
 	case SIOCGMIIPHY:	/* Get address of MII PHY in use. */
@@ -2207,8 +2207,8 @@
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 3);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 		
 		
 	return ret;
@@ -2818,8 +2818,8 @@
 static int velocity_ethtool_up(struct net_device *dev)
 {
 	struct velocity_info *vptr = dev->priv;
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 0);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D0);
 	return 0;
 }	
 
@@ -2834,8 +2834,8 @@
 static void velocity_ethtool_down(struct net_device *dev)
 {
 	struct velocity_info *vptr = dev->priv;
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 3);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 }
 
 static int velocity_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
@@ -3229,15 +3229,15 @@
 		velocity_shutdown(vptr);
 		velocity_set_wol(vptr);
 		pci_enable_wake(pdev, 3, 1);
-		pci_set_power_state(pdev, 3);
+		pci_set_power_state(pdev, PCI_D3hot);
 	} else {
 		velocity_save_context(vptr, &vptr->context);
 		velocity_shutdown(vptr);
 		pci_disable_device(pdev);
-		pci_set_power_state(pdev, state);
+		pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	}
 #else
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 #endif
 	spin_unlock_irqrestore(&vptr->lock, flags);
 	return 0;
@@ -3252,7 +3252,7 @@
 	if(!netif_running(vptr->dev))
 		return 0;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_enable_wake(pdev, 0, 0);
 	pci_restore_state(pdev, vptr->pci_state);
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
