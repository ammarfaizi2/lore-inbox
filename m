Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVA1SbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVA1SbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVA1SbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:31:17 -0500
Received: from gprs213-105.eurotel.cz ([160.218.213.105]:17026 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261504AbVA1Sa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:30:29 -0500
Date: Fri, 28 Jan 2005 19:29:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, linux-pm@osdl.org,
       Andrew Morton <akpm@zip.com.au>
Subject: driver-model: Type-checking for more drivers
Message-ID: <20050128182956.GA9100@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This corrects type-checking into more drivers. No code changes, apart
from pci_choose_state() which should not matter because we are only
ever passing 0 or 3 to suspend method. With this, and after fixing
sound, we should be able to switch pm_message_t into struct in early
2.6.12 (and solve long-term problems). Please apply,

From: Bernard Blackham <bernard@blackham.com.au>
Signed-off-by: Pavel Machek <pavel@suse.cz>
								Pavel

--- linux-2.6.11-rc2-pm-changes/drivers/media/video/bttv-driver.c	2005-01-22 14:20:56.000000000 +0800
+++ linux-2.6.11/drivers/media/video/bttv-driver.c	2005-01-28 22:39:28.000000000 +0800
@@ -3914,7 +3914,7 @@
         return;
 }
 
-static int bttv_suspend(struct pci_dev *pci_dev, u32 state)
+static int bttv_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
         struct bttv *btv = pci_get_drvdata(pci_dev);
 	struct bttv_buffer_set idle;
--- linux-2.6.11-rc2-pm-changes/drivers/net/3c59x.c	2005-01-28 22:45:28.000000000 +0800
+++ linux-2.6.11/drivers/net/3c59x.c	2005-01-28 22:45:35.000000000 +0800
@@ -962,7 +962,7 @@
 
 #ifdef CONFIG_PM
 
-static int vortex_suspend (struct pci_dev *pdev, u32 state)
+static int vortex_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
--- linux-2.6.11-rc2-pm-changes/drivers/net/e100.c	2005-01-22 14:20:56.000000000 +0800
+++ linux-2.6.11/drivers/net/e100.c	2005-01-28 22:57:31.000000000 +0800
@@ -2309,7 +2309,7 @@
 }
 
 #ifdef CONFIG_PM
-static int e100_suspend(struct pci_dev *pdev, u32 state)
+static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
@@ -2320,7 +2320,7 @@
 	netif_device_detach(netdev);
 
 	pci_save_state(pdev);
-	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
--- linux-2.6.11-rc2-pm-changes/drivers/net/epic100.c	2005-01-22 14:20:56.000000000 +0800
+++ linux-2.6.11/drivers/net/epic100.c	2005-01-28 22:58:48.000000000 +0800
@@ -1624,7 +1624,7 @@
 
 #ifdef CONFIG_PM
 
-static int epic_suspend (struct pci_dev *pdev, u32 state)
+static int epic_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	long ioaddr = dev->base_addr;
--- linux-2.6.11-rc2-pm-changes/drivers/net/natsemi.c	2005-01-22 14:20:57.000000000 +0800
+++ linux-2.6.11/drivers/net/natsemi.c	2005-01-28 23:01:12.000000000 +0800
@@ -3160,7 +3160,7 @@
  * Interrupts must be disabled, otherwise hands_off can cause irq storms.
  */
 
-static int natsemi_suspend (struct pci_dev *pdev, u32 state)
+static int natsemi_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
--- linux-2.6.11-rc2-pm-changes/drivers/net/ne2k-pci.c	2005-01-22 14:20:57.000000000 +0800
+++ linux-2.6.11/drivers/net/ne2k-pci.c	2005-01-28 22:56:34.000000000 +0800
@@ -654,13 +654,13 @@
 }
 
 #ifdef CONFIG_PM
-static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
+static int ne2k_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 
 	netif_device_detach(dev);
 	pci_save_state(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
--- linux-2.6.11-rc2-pm-changes/drivers/net/sis900.c	2005-01-22 14:20:57.000000000 +0800
+++ linux-2.6.11/drivers/net/sis900.c	2005-01-28 23:00:23.000000000 +0800
@@ -2226,7 +2226,7 @@
 
 #ifdef CONFIG_PM
 
-static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
+static int sis900_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
 	long ioaddr = net_dev->base_addr;
--- linux-2.6.11-rc2-pm-changes/drivers/net/sungem.c	2005-01-28 23:02:23.000000000 +0800
+++ linux-2.6.11/drivers/net/sungem.c	2005-01-28 22:44:55.000000000 +0800
@@ -2356,7 +2356,7 @@
 }
 
 #ifdef CONFIG_PM
-static int gem_suspend(struct pci_dev *pdev, u32 state)
+static int gem_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct gem *gp = dev->priv;
--- linux-2.6.11-rc2-pm-changes/drivers/net/typhoon.c	2005-01-22 14:20:57.000000000 +0800
+++ linux-2.6.11/drivers/net/typhoon.c	2005-01-28 23:04:07.000000000 +0800
@@ -2136,7 +2136,7 @@
 		goto out;
 	}
 
-	if(typhoon_sleep(tp, 3, 0) < 0) 
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) 
 		printk(KERN_ERR "%s: unable to go back to sleep\n", dev->name);
 
 out:
@@ -2163,7 +2163,7 @@
 	if(typhoon_boot_3XP(tp, TYPHOON_STATUS_WAITING_FOR_HOST) < 0)
 		printk(KERN_ERR "%s: unable to boot sleep image\n", dev->name);
 
-	if(typhoon_sleep(tp, 3, 0) < 0)
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0)
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 
 	return 0;
@@ -2203,7 +2203,7 @@
 }
 
 static int
-typhoon_suspend(struct pci_dev *pdev, u32 state)
+typhoon_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct typhoon *tp = netdev_priv(dev);
@@ -2255,7 +2255,7 @@
 		goto need_resume;
 	}
 
-	if(typhoon_sleep(tp, state, tp->wol_events) < 0) {
+	if(typhoon_sleep(tp, pci_choose_state(pdev, state), tp->wol_events) < 0) {
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 		goto need_resume;
 	}
@@ -2454,7 +2454,7 @@
 	if(xp_resp[0].numDesc != 0)
 		tp->capabilities |= TYPHOON_WAKEUP_NEEDS_RESET;
 
-	if(typhoon_sleep(tp, 3, 0) < 0) {
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) {
 		printk(ERR_PFX "%s: cannot put adapter to sleep\n",
 		       pci_name(pdev));
 		err = -EIO;
--- linux-2.6.11-rc2-pm-changes/drivers/net/via-velocity.c	2005-01-22 14:20:57.000000000 +0800
+++ linux-2.6.11/drivers/net/via-velocity.c	2005-01-28 23:01:48.000000000 +0800
@@ -263,7 +263,7 @@
 
 #ifdef CONFIG_PM
 
-static int velocity_suspend(struct pci_dev *pdev, u32 state);
+static int velocity_suspend(struct pci_dev *pdev, pm_message_t state);
 static int velocity_resume(struct pci_dev *pdev);
 
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
@@ -3210,7 +3210,7 @@
 	return 0;
 }
 
-static int velocity_suspend(struct pci_dev *pdev, u32 state)
+static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct velocity_info *vptr = pci_get_drvdata(pdev);
 	unsigned long flags;
--- linux-2.6.11-rc2-pm-changes/drivers/pcmcia/pd6729.c	2005-01-22 14:20:58.000000000 +0800
+++ linux-2.6.11/drivers/pcmcia/pd6729.c	2005-01-28 23:05:12.000000000 +0800
@@ -833,7 +833,7 @@
 	kfree(socket);
 }
 
-static int pd6729_socket_suspend(struct pci_dev *dev, u32 state)
+static int pd6729_socket_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
--- linux-2.6.11-rc2-pm-changes/drivers/usb/host/sl811-hcd.c	2005-01-22 14:20:59.000000000 +0800
+++ linux-2.6.11/drivers/usb/host/sl811-hcd.c	2005-01-28 23:20:39.000000000 +0800
@@ -103,12 +103,12 @@
 
 		sl811->port1 = (1 << USB_PORT_FEAT_POWER);
 		sl811->irq_enable = SL11H_INTMASK_INSRMV;
-		hcd->self.controller->power.power_state = PM_SUSPEND_ON;
+		hcd->self.controller->power.power_state = PMSG_ON;
 	} else {
 		sl811->port1 = 0;
 		sl811->irq_enable = 0;
 		hcd->state = USB_STATE_HALT;
-		hcd->self.controller->power.power_state = PM_SUSPEND_DISK;
+		hcd->self.controller->power.power_state = PMSG_SUSPEND;
 	}
 	sl811->ctrl1 = 0;
 	sl811_write(sl811, SL11H_IRQ_ENABLE, 0);
@@ -1799,7 +1799,7 @@
  */
 
 static int
-sl811h_suspend(struct device *dev, u32 state, u32 phase)
+sl811h_suspend(struct device *dev, pm_message_t state, u32 phase)
 {
 	struct sl811	*sl811 = dev_get_drvdata(dev);
 	int		retval = 0;
--- linux-2.6.11-rc2-pm-changes/drivers/usb/net/pegasus.c	2005-01-22 14:20:59.000000000 +0800
+++ linux-2.6.11/drivers/usb/net/pegasus.c	2005-01-28 23:22:14.000000000 +0800
@@ -1253,7 +1253,7 @@
 	free_netdev(pegasus->net);
 }
 
-static int pegasus_suspend (struct usb_interface *intf, u32 state)
+static int pegasus_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct pegasus *pegasus = usb_get_intfdata(intf);
 	
--- linux-2.6.11-rc2-pm-changes/drivers/video/aty/aty128fb.c	2005-01-22 14:20:59.000000000 +0800
+++ linux-2.6.11/drivers/video/aty/aty128fb.c	2005-01-28 23:31:09.000000000 +0800
@@ -165,7 +165,7 @@
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state);
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int aty128_pci_resume(struct pci_dev *pdev);
 
 /* supported Rage128 chipsets */
@@ -2309,7 +2309,7 @@
 	}
 }
 
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state)
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2396,7 +2396,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
 
--- linux-2.6.11-rc2-pm-changes/drivers/video/aty/atyfb_base.c	2005-01-22 14:20:59.000000000 +0800
+++ linux-2.6.11/drivers/video/aty/atyfb_base.c	2005-01-28 23:26:34.000000000 +0800
@@ -2016,7 +2016,7 @@
 	return timeout ? 0 : -EIO;
 }
 
-static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
+static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -2091,7 +2091,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
--- linux-2.6.11-rc2-pm-changes/drivers/video/cyber2000fb.c	2005-01-22 14:20:59.000000000 +0800
+++ linux-2.6.11/drivers/video/cyber2000fb.c	2005-01-28 23:39:42.000000000 +0800
@@ -1665,7 +1665,7 @@
 	}
 }
 
-static int cyberpro_pci_suspend(struct pci_dev *dev, u32 state)
+static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
--- linux-2.6.11-rc2-pm-changes/drivers/video/i810/i810_main.c	2005-01-22 14:20:59.000000000 +0800
+++ linux-2.6.11/drivers/video/i810/i810_main.c	2005-01-28 23:49:06.000000000 +0800
@@ -1524,7 +1524,7 @@
 		pci_disable_device(dev);
 	}
 	pci_save_state(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
--- linux-2.6.11-rc2-pm-changes/drivers/video/i810/i810_main.h	2004-12-25 05:35:00.000000000 +0800
+++ linux-2.6.11/drivers/video/i810/i810_main.h	2005-01-28 23:48:50.000000000 +0800
@@ -18,7 +18,7 @@
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
-static int i810fb_suspend(struct pci_dev *dev, u32 state);
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
 
 /*
  * voffset - framebuffer offset in MiB from aperture start address.  In order for


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
