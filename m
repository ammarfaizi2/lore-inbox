Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbULUXiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbULUXiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbULUXiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:38:52 -0500
Received: from gprs214-215.eurotel.cz ([160.218.214.215]:29057 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261896AbULUXib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:38:31 -0500
Date: Wed, 22 Dec 2004 00:37:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041221233742.GC1218@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com> <20041218000920.GE29084@elf.ucw.cz> <20041221200401.GB9577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221200401.GB9577@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Alright, I've applied this, and it will show up in the next -mm release.
> > > I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> > > functions.
> > > 
> > > Now, care to send patches to fix up all of the new sparse warnings in
> > > the drivers/pci/* directory?
> > 
> > This should fix warnings in drivers/net/* and bttv (with exception of
> > via-rhine, which I'll do separately). Do you think you could apply it,
> > or shall I ask Andrew, or... ?
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> What kernel tree is this against?  I get lots of rejects against the
> latest -bk tree.

It was against 2.6.9. pci_{save,restore}_state(), therefore it rejects
in surrounding text. Here's version against latest -bk.

This should fix sparse warnings in drivers/net/* and bttv. Please
apply,

								Pavel


Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/drivers/media/video/bttv-driver.c	2004-12-09 21:46:07.000000000 +0100
+++ linux-greg/drivers/media/video/bttv-driver.c	2004-12-22 00:30:21.000000000 +0100
@@ -3942,7 +3942,7 @@
 
 	/* save pci state */
 	pci_save_state(pci_dev);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, device_to_pci_power(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
 	}
@@ -3961,7 +3961,7 @@
 		pci_enable_device(pci_dev);
 		btv->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
 	/* restore bt878 state */
--- clean-cvs/drivers/net/3c59x.c	2004-11-19 12:19:53.000000000 +0100
+++ linux-greg/drivers/net/3c59x.c	2004-12-22 00:32:24.000000000 +0100
@@ -1549,7 +1549,7 @@
 	int i;
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		pci_restore_state(VORTEX_PCI(vp));
 	}
 
@@ -2941,7 +2941,7 @@
 	/* The kernel core really should have pci_get_power_state() */
 
 	if(state != 0)
-		pci_set_power_state(VORTEX_PCI(vp), 0);
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);
 	err = vortex_do_ioctl(dev, rq, cmd);
 	if(state != 0)
 		pci_set_power_state(VORTEX_PCI(vp), state);
@@ -3140,7 +3140,7 @@
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
 	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
-	pci_set_power_state(VORTEX_PCI(vp), 3);
+	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
 }
 
 
@@ -3163,7 +3163,7 @@
 	unregister_netdev(dev);
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(VORTEX_PCI(vp));
 	}
--- clean-cvs/drivers/net/8139cp.c	2004-11-19 12:19:53.000000000 +0100
+++ linux-greg/drivers/net/8139cp.c	2004-12-22 00:32:48.000000000 +0100
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
 		pci_restore_state (cp->pdev);
 	}
 	
--- clean-cvs/drivers/net/8139too.c	2004-11-19 12:19:53.000000000 +0100
+++ linux-greg/drivers/net/8139too.c	2004-12-22 00:29:11.000000000 +0100
@@ -2607,7 +2607,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -2620,7 +2620,7 @@
 	pci_restore_state (pdev);
 	if (!netif_running (dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	netif_device_attach (dev);
--- clean-cvs/drivers/net/amd8111e.c	2004-11-19 12:19:54.000000000 +0100
+++ linux-greg/drivers/net/amd8111e.c	2004-12-22 00:33:46.000000000 +0100
@@ -1826,17 +1826,17 @@
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
 	
 	pci_save_state(pci_dev);
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 
 	return 0;
 }
@@ -1848,11 +1848,11 @@
 	if (!netif_running(dev))
 		return 0;
 
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
-	pci_enable_wake(pci_dev, 3, 0);
-	pci_enable_wake(pci_dev, 4, 0); /* D3 cold */
+	pci_enable_wake(pci_dev, PCI_D3hot, 0);
+	pci_enable_wake(pci_dev, PCI_D3cold, 0); /* D3 cold */
 
 	netif_device_attach(dev);
 
--- clean-cvs/drivers/net/e100.c	2004-12-09 21:46:08.000000000 +0100
+++ linux-greg/drivers/net/e100.c	2004-12-22 00:34:04.000000000 +0100
@@ -2326,7 +2326,7 @@
 	pci_save_state(pdev);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -2336,7 +2336,7 @@
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	e100_hw_init(nic);
 
--- clean-cvs/drivers/net/eepro100.c	2004-12-13 21:18:25.000000000 +0100
+++ linux-greg/drivers/net/eepro100.c	2004-12-22 00:29:11.000000000 +0100
@@ -1014,7 +1014,7 @@
 	if (netif_msg_ifup(sp))
 		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", dev->name, dev->irq);
 
-	pci_set_power_state(sp->pdev, 0);
+	pci_set_power_state(sp->pdev, PCI_D0);
 
 	/* Set up the Tx queue early.. */
 	sp->cur_tx = 0;
@@ -1963,7 +1963,7 @@
 	if (netif_msg_ifdown(sp))
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	pci_set_power_state(sp->pdev, PCI_D2);
 
 	return 0;
 }
@@ -2088,7 +2088,7 @@
 		   access from the timeout handler.
 		   They are currently serialized only with MDIO access from the
 		   timer routine.  2000/05/09 SAW */
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		if (t)
@@ -2099,7 +2099,7 @@
 	case SIOCSMIIREG:		/* Write MII PHY register. */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		mdio_write(dev, data->phy_id, data->reg_num, data->val_in);
 		if (t)
--- clean-cvs/drivers/net/pci-skeleton.c	2004-11-19 12:19:56.000000000 +0100
+++ linux-greg/drivers/net/pci-skeleton.c	2004-12-22 00:34:18.000000000 +0100
@@ -1921,7 +1921,7 @@
 	spin_unlock_irqrestore (&tp->lock, flags);
 
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -1934,7 +1934,7 @@
 
 	if (!netif_running(dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state (pdev);
 	netif_device_attach (dev);
 	netdrv_hw_start (dev);
--- clean-cvs/drivers/net/sis900.c	2004-11-19 12:19:57.000000000 +0100
+++ linux-greg/drivers/net/sis900.c	2004-12-22 00:34:43.000000000 +0100
@@ -2238,7 +2238,7 @@
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3);
 	pci_save_state(pci_dev);
 
 	return 0;
@@ -2253,7 +2253,7 @@
 	if(!netif_running(net_dev))
 		return 0;
 	pci_restore_state(pci_dev);
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 
 	sis900_init_rxfilter(net_dev);
 
--- clean-cvs/drivers/net/starfire.c	2004-10-20 17:32:59.000000000 +0200
+++ linux-greg/drivers/net/starfire.c	2004-12-22 00:29:11.000000000 +0100
@@ -2159,7 +2159,7 @@
 
 
 	/* XXX: add wakeup code -- requires firmware for MagicPacket */
-	pci_set_power_state(pdev, 3);	/* go to sleep in D3 mode */
+	pci_set_power_state(pdev, PCI_D3hot);	/* go to sleep in D3 mode */
 	pci_disable_device(pdev);
 
 	iounmap((char *)dev->base_addr);
--- clean-cvs/drivers/net/typhoon.c	2004-11-19 12:19:58.000000000 +0100
+++ linux-greg/drivers/net/typhoon.c	2004-12-22 00:34:59.000000000 +0100
@@ -1890,7 +1890,7 @@
 
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, state);
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int
@@ -1899,7 +1899,7 @@
 	struct pci_dev *pdev = tp->pdev;
 	void __iomem *ioaddr = tp->ioaddr;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
 	/* Post 2.x.x versions of the Sleep Image require a reset before
@@ -2553,7 +2553,7 @@
 	struct typhoon *tp = netdev_priv(dev);
 
 	unregister_netdev(dev);
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	typhoon_reset(tp->ioaddr, NoWait);
 	iounmap(tp->ioaddr);
--- clean-cvs/drivers/net/via-rhine.c	2004-11-19 12:19:58.000000000 +0100
+++ linux-greg/drivers/net/via-rhine.c	2004-12-22 00:29:20.000000000 +0100
@@ -1974,7 +1974,7 @@
         if (request_irq(dev->irq, rhine_interrupt, SA_SHIRQ, dev->name, dev))
 		printk(KERN_ERR "via-rhine %s: request_irq failed\n", dev->name);
 
-	ret = pci_set_power_state(pdev, 0);
+	ret = pci_set_power_state(pdev, PCI_D0);
 	if (debug > 1)
 		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",
 			dev->name, ret ? "failed" : "succeeded", ret);
--- clean-cvs/drivers/net/via-velocity.c	2004-10-20 03:26:30.000000000 +0200
+++ linux-greg/drivers/net/via-velocity.c	2004-12-22 00:29:11.000000000 +0100
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
 	pci_restore_state(pdev);
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
