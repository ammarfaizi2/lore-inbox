Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVAVVDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVAVVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVAVVDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:03:08 -0500
Received: from gprs214-39.eurotel.cz ([160.218.214.39]:17028 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262747AbVAVUwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:52:11 -0500
Date: Sat, 22 Jan 2005 21:51:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: driver model: more pm_message_t conversion
Message-ID: <20050122205126.GA30540@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes few more types, mostly switching u32s into
pm_message_ts. It does not actually change any code. With this plus
few small patches, I can actually switch pm_message_t to struct and
still have it compile/work on my system. Please apply,
								Pavel


--- clean/Documentation/power/devices.txt	2005-01-22 21:24:50.000000000 +0100
+++ linux-delme/Documentation/power/devices.txt	2005-01-22 21:44:18.000000000 +0100
@@ -15,7 +15,7 @@
 
 struct bus_type {
        ...
-       int             (*suspend)(struct device * dev, u32 state);
+       int             (*suspend)(struct device * dev, pm_message_t state);
        int             (*resume)(struct device * dev);
 };
 
--- clean/drivers/char/agp/via-agp.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/char/agp/via-agp.c	2005-01-22 21:44:18.000000000 +0100
@@ -440,10 +440,10 @@
 
 #ifdef CONFIG_PM
 
-static int agp_via_suspend(struct pci_dev *pdev, u32 state)
+static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -452,7 +452,7 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state(pdev);
 
 	if (bridge->driver == &via_agp3_driver)
--- clean/drivers/i2c/i2c-core.c	2004-12-25 13:34:59.000000000 +0100
+++ linux-delme/drivers/i2c/i2c-core.c	2005-01-22 21:44:18.000000000 +0100
@@ -530,7 +530,7 @@
 	return 1;
 }
 
-static int i2c_bus_suspend(struct device * dev, u32 state)
+static int i2c_bus_suspend(struct device * dev, pm_message_t state)
 {
 	int rc = 0;
 
--- clean/drivers/ide/ide-disk.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/ide/ide-disk.c	2005-01-22 21:44:37.000000000 +0100
@@ -1157,7 +1157,7 @@
 	}
 
 	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
 /*
--- clean/drivers/ieee1394/ohci1394.c	2004-12-25 13:34:59.000000000 +0100
+++ linux-delme/drivers/ieee1394/ohci1394.c	2005-01-22 21:44:19.000000000 +0100
@@ -3510,7 +3510,7 @@
 }
 
 
-static int ohci1394_pci_suspend (struct pci_dev *pdev, u32 state)
+static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 #ifdef CONFIG_PMAC_PBOOK
 	{
--- clean/drivers/input/serio/i8042.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/input/serio/i8042.c	2005-01-22 21:44:19.000000000 +0100
@@ -860,7 +860,7 @@
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_suspend(struct device *dev, u32 state, u32 level)
+static int i8042_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		del_timer_sync(&i8042_timer);
--- clean/drivers/mmc/mmc_block.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/mmc/mmc_block.c	2005-01-22 21:44:19.000000000 +0100
@@ -437,7 +437,7 @@
 }
 
 #ifdef CONFIG_PM
-static int mmc_blk_suspend(struct mmc_card *card, u32 state)
+static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
 {
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
--- clean/drivers/mmc/mmc_sysfs.c	2004-10-01 00:30:15.000000000 +0200
+++ linux-delme/drivers/mmc/mmc_sysfs.c	2005-01-22 21:44:19.000000000 +0100
@@ -74,7 +74,7 @@
 	return 0;
 }
 
-static int mmc_bus_suspend(struct device *dev, u32 state)
+static int mmc_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = dev_to_mmc_card(dev);
--- clean/drivers/net/8139too.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/net/8139too.c	2005-01-22 21:44:19.000000000 +0100
@@ -2581,7 +2581,7 @@
 
 #ifdef CONFIG_PM
 
-static int rtl8139_suspend (struct pci_dev *pdev, u32 state)
+static int rtl8139_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = dev->priv;
--- clean/drivers/net/amd8111e.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/net/amd8111e.c	2005-01-22 21:44:19.000000000 +0100
@@ -1797,7 +1797,7 @@
 	if(!err)
 		netif_wake_queue(dev);
 }
-static int amd8111e_suspend(struct pci_dev *pci_dev, u32 state)
+static int amd8111e_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {	
 	struct net_device *dev = pci_get_drvdata(pci_dev);
 	struct amd8111e_priv *lp = netdev_priv(dev);
--- clean/drivers/net/b44.c	2004-12-25 13:35:00.000000000 +0100
+++ linux-delme/drivers/net/b44.c	2005-01-22 21:44:19.000000000 +0100
@@ -1903,7 +1903,7 @@
 	}
 }
 
-static int b44_suspend(struct pci_dev *pdev, u32 state)
+static int b44_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = netdev_priv(dev);
--- clean/drivers/net/eepro100.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/net/eepro100.c	2005-01-22 21:44:19.000000000 +0100
@@ -2281,7 +2281,7 @@
 }
 
 #ifdef CONFIG_PM
-static int eepro100_suspend(struct pci_dev *pdev, u32 state)
+static int eepro100_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct speedo_private *sp = netdev_priv(dev);
@@ -2299,7 +2299,7 @@
 	
 	/* XXX call pci_set_power_state ()? */
 	pci_disable_device(pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 	return 0;
 }
 
@@ -2309,7 +2309,7 @@
 	struct speedo_private *sp = netdev_priv(dev);
 	void __iomem *ioaddr = sp->regs;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
--- clean/drivers/net/irda/donauboe.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/net/irda/donauboe.c	2005-01-22 21:44:19.000000000 +0100
@@ -1712,7 +1712,7 @@
 }
 
 static int
-toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
+toshoboe_gotosleep (struct pci_dev *pci_dev, pm_message_t crap)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
   unsigned long flags;
--- clean/drivers/net/tg3.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/net/tg3.c	2005-01-22 21:44:19.000000000 +0100
@@ -8448,7 +8448,7 @@
 	}
 }
 
-static int tg3_suspend(struct pci_dev *pdev, u32 state)
+static int tg3_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(dev);
--- clean/drivers/net/tulip/tulip_core.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/net/tulip/tulip_core.c	2005-01-22 21:44:19.000000000 +0100
@@ -1749,7 +1749,7 @@
 
 #ifdef CONFIG_PM
 
-static int tulip_suspend (struct pci_dev *pdev, u32 state)
+static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
--- clean/drivers/net/via-rhine.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/net/via-rhine.c	2005-01-22 21:44:19.000000000 +0100
@@ -1937,7 +1937,7 @@
 }
 
 #ifdef CONFIG_PM
-static int rhine_suspend(struct pci_dev *pdev, u32 state)
+static int rhine_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rhine_private *rp = netdev_priv(dev);
--- clean/drivers/pci/pci.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/pci/pci.c	2005-01-22 21:44:19.000000000 +0100
@@ -318,7 +318,7 @@
  * message.
  */
 
-pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
--- clean/drivers/pcmcia/cs.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/pcmcia/cs.c	2005-01-22 21:44:19.000000000 +0100
@@ -140,7 +140,7 @@
 static int socket_resume(struct pcmcia_socket *skt);
 static int socket_suspend(struct pcmcia_socket *skt);
 
-int pcmcia_socket_dev_suspend(struct device *dev, u32 state)
+int pcmcia_socket_dev_suspend(struct device *dev, pm_message_t state)
 {
 	struct pcmcia_socket *socket;
 
--- clean/drivers/pcmcia/i82092.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/pcmcia/i82092.c	2005-01-22 21:44:19.000000000 +0100
@@ -42,7 +42,7 @@
 };
 MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
 
-static int i82092aa_socket_suspend (struct pci_dev *dev, u32 state)
+static int i82092aa_socket_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
--- clean/drivers/pcmcia/i82365.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/pcmcia/i82365.c	2005-01-22 21:44:19.000000000 +0100
@@ -1338,7 +1338,7 @@
 
 /*====================================================================*/
 
-static int i82365_suspend(struct device *dev, u32 state, u32 level)
+static int i82365_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean/drivers/pcmcia/tcic.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/pcmcia/tcic.c	2005-01-22 21:44:19.000000000 +0100
@@ -369,7 +369,7 @@
 
 /*====================================================================*/
 
-static int tcic_drv_suspend(struct device *dev, u32 state, u32 level)
+static int tcic_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean/drivers/pcmcia/yenta_socket.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-delme/drivers/pcmcia/yenta_socket.c	2005-01-22 21:44:19.000000000 +0100
@@ -1019,7 +1019,7 @@
 }
 
 
-static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
+static int yenta_dev_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	struct yenta_socket *socket = pci_get_drvdata(dev);
 	int ret;
--- clean/drivers/serial/8250.c	2005-01-12 11:07:40.000000000 +0100
+++ linux-delme/drivers/serial/8250.c	2005-01-22 21:44:19.000000000 +0100
@@ -2255,7 +2255,7 @@
 	return 0;
 }
 
-static int serial8250_suspend(struct device *dev, u32 state, u32 level)
+static int serial8250_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int i;
 
--- clean/drivers/serial/8250_pci.c	2004-12-25 13:35:01.000000000 +0100
+++ linux-delme/drivers/serial/8250_pci.c	2005-01-22 21:44:19.000000000 +0100
@@ -1759,7 +1759,7 @@
 	}
 }
 
-static int pciserial_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
--- clean/drivers/usb/core/hcd.h	2005-01-12 11:07:40.000000000 +0100
+++ linux-delme/drivers/usb/core/hcd.h	2005-01-22 21:44:19.000000000 +0100
@@ -223,7 +223,7 @@
 extern void usb_hcd_pci_remove (struct pci_dev *dev);
 
 #ifdef CONFIG_PM
-extern int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state);
+extern int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t state);
 extern int usb_hcd_pci_resume (struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
--- clean/drivers/usb/core/hub.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/usb/core/hub.c	2005-01-22 21:44:19.000000000 +0100
@@ -1636,7 +1636,7 @@
  *
  * Returns 0 on success, else negative errno.
  */
-int usb_suspend_device(struct usb_device *udev, u32 state)
+int usb_suspend_device(struct usb_device *udev, pm_message_t state)
 {
 	int	port1, status;
 
@@ -1951,7 +1951,7 @@
 
 #else	/* !CONFIG_USB_SUSPEND */
 
-int usb_suspend_device(struct usb_device *udev, u32 state)
+int usb_suspend_device(struct usb_device *udev, pm_message_t state)
 {
 	return 0;
 }
--- clean/drivers/usb/core/usb.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/usb/core/usb.c	2005-01-22 21:44:19.000000000 +0100
@@ -1348,7 +1348,7 @@
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static int usb_generic_suspend(struct device *dev, u32 state)
+static int usb_generic_suspend(struct device *dev, pm_message_t state)
 {
 	struct usb_interface *intf;
 	struct usb_driver *driver;
--- clean/drivers/usb/input/hid-core.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-delme/drivers/usb/input/hid-core.c	2005-01-22 21:44:19.000000000 +0100
@@ -1850,7 +1850,7 @@
 	return 0;
 }
 
-static int hid_suspend(struct usb_interface *intf, u32 state)
+static int hid_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct hid_device *hid = usb_get_intfdata (intf);
 
@@ -1865,7 +1865,7 @@
 	struct hid_device *hid = usb_get_intfdata (intf);
 	int status;
 
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 	if (hid->open)
 		status = usb_submit_urb(hid->urbin, GFP_NOIO);
 	else
--- clean/drivers/video/aty/radeon_pm.c	2004-12-25 13:35:01.000000000 +0100
+++ linux-delme/drivers/video/aty/radeon_pm.c	2005-01-22 21:44:19.000000000 +0100
@@ -13,12 +13,12 @@
  * On PowerMac, we assume any mobility chip based machine does D2
  */
 #ifdef CONFIG_PPC_PMAC
-static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, u32 state)
+static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, pm_message_t state)
 {
 	return rinfo->is_mobility;
 }
 #else
-static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, u32 state)
+static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, pm_message_t state)
 {
 	return 0;
 }
@@ -850,7 +850,7 @@
 	}
 }
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
@@ -935,7 +935,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	printk(KERN_DEBUG "radeonfb: resumed !\n");
 
--- clean/drivers/video/aty/radeonfb.h	2004-12-25 13:35:01.000000000 +0100
+++ linux-delme/drivers/video/aty/radeonfb.h	2005-01-22 21:44:19.000000000 +0100
@@ -526,7 +526,7 @@
 /* PM Functions */
 extern void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo);
 extern void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo);
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
+extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int radeonfb_pci_resume(struct pci_dev *pdev);
 
 /* Monitor probe functions */
--- clean/include/linux/device.h	2005-01-12 11:07:40.000000000 +0100
+++ linux-delme/include/linux/device.h	2005-01-22 21:44:19.000000000 +0100
@@ -111,7 +111,7 @@
 	int	(*probe)	(struct device * dev);
 	int 	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
-	int	(*suspend)	(struct device * dev, u32 state, u32 level);
+	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
 };
 
--- clean/include/linux/mmc/card.h	2004-10-01 00:30:30.000000000 +0200
+++ linux-delme/include/linux/mmc/card.h	2005-01-22 21:44:19.000000000 +0100
@@ -75,7 +75,7 @@
 	struct device_driver drv;
 	int (*probe)(struct mmc_card *);
 	void (*remove)(struct mmc_card *);
-	int (*suspend)(struct mmc_card *, u32);
+	int (*suspend)(struct mmc_card *, pm_message_t);
 	int (*resume)(struct mmc_card *);
 };
 
--- clean/include/linux/usb.h	2005-01-12 11:07:40.000000000 +0100
+++ linux-delme/include/linux/usb.h	2005-01-22 21:44:19.000000000 +0100
@@ -547,7 +547,7 @@
 
 	int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
 
-	int (*suspend) (struct usb_interface *intf, u32 state);
+	int (*suspend) (struct usb_interface *intf, pm_message_t state);
 	int (*resume) (struct usb_interface *intf);
 
 	const struct usb_device_id *id_table;
@@ -966,7 +966,7 @@
 	int timeout);
 
 /* selective suspend/resume */
-extern int usb_suspend_device(struct usb_device *dev, u32 state);
+extern int usb_suspend_device(struct usb_device *dev, pm_message_t state);
 extern int usb_resume_device(struct usb_device *dev);
 
 
--- clean/include/pcmcia/ss.h	2005-01-12 11:07:40.000000000 +0100
+++ linux-delme/include/pcmcia/ss.h	2005-01-22 21:44:19.000000000 +0100
@@ -250,7 +250,7 @@
 extern struct class pcmcia_socket_class;
 
 /* socket drivers are expected to use these callbacks in their .drv struct */
-extern int pcmcia_socket_dev_suspend(struct device *dev, u32 state);
+extern int pcmcia_socket_dev_suspend(struct device *dev, pm_message_t state);
 extern int pcmcia_socket_dev_resume(struct device *dev);
 
 #endif /* _LINUX_SS_H */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
