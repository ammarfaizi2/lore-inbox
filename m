Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270132AbUJSXBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270132AbUJSXBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270181AbUJSWys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:54:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:60041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269613AbUJSWqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:20 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225737284@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <10982257382525@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.46, 2004/10/06 13:20:13-07:00, rl@hellgate.ch

[PATCH] PCI: remove driver private PCI state, 1 arg for pci_{save,restore}_state

This is the second (and hopefully final) iteration of the interface
change we talked about a while ago. The patch applies cleanly against
2.6.9-rc2-mm4.

This removes the second argument (buffer for storing PCI state) from
pci_{save,restore}_state since pci_dev contains such a buffer now.
Fixed all callers.

Three drivers used to pass a buffer of 256 bytes, one only 48(!). The
rest was correct. Changes were compile tested, except for Alpha.

Signed-off-by: Roger Luethi <rl@hellgate.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/alpha/kernel/pci.c                       |    4 +--
 arch/alpha/kernel/pci_impl.h                  |    1 
 drivers/char/agp/intel-agp.c                  |    2 -
 drivers/char/agp/intel-mch-agp.c              |    2 -
 drivers/media/video/bttv-driver.c             |    4 +--
 drivers/media/video/bttvp.h                   |    1 
 drivers/media/video/cx88/cx88-video.c         |    4 +--
 drivers/media/video/cx88/cx88.h               |    1 
 drivers/media/video/meye.c                    |    4 +--
 drivers/media/video/meye.h                    |    1 
 drivers/message/fusion/mptbase.c              |    4 +--
 drivers/message/fusion/mptbase.h              |    3 --
 drivers/net/3c59x.c                           |   11 ++++-----
 drivers/net/8139cp.c                          |    5 +---
 drivers/net/8139too.c                         |    6 +----
 drivers/net/amd8111e.c                        |    4 +--
 drivers/net/amd8111e.h                        |    1 
 drivers/net/b44.c                             |    4 +--
 drivers/net/b44.h                             |    1 
 drivers/net/e100.c                            |    5 +---
 drivers/net/e1000/e1000.h                     |    1 
 drivers/net/e1000/e1000_main.c                |    4 +--
 drivers/net/eepro100.c                        |    7 +----
 drivers/net/irda/vlsi_ir.c                    |    4 +--
 drivers/net/irda/vlsi_ir.h                    |    1 
 drivers/net/ixgb/ixgb.h                       |    1 
 drivers/net/ixgb/ixgb_main.c                  |    2 -
 drivers/net/pci-skeleton.c                    |    5 +---
 drivers/net/s2io.c                            |    4 +--
 drivers/net/s2io.h                            |    1 
 drivers/net/sis900.c                          |    6 +----
 drivers/net/tg3.c                             |    8 +++---
 drivers/net/tg3.h                             |    1 
 drivers/net/tulip/xircom_tulip_cb.c           |    7 +----
 drivers/net/typhoon.c                         |    9 +++----
 drivers/net/via-rhine.c                       |    4 +--
 drivers/net/via-velocity.c                    |    4 +--
 drivers/net/via-velocity.h                    |    4 ---
 drivers/net/wireless/airo.c                   |    5 +---
 drivers/net/wireless/prism54/islpci_dev.h     |    1 
 drivers/net/wireless/prism54/islpci_hotplug.c |    4 +--
 drivers/pci/pci-driver.c                      |    4 +--
 drivers/pci/pci.c                             |   31 +++++---------------------
 drivers/pcmcia/yenta_socket.c                 |   12 +++++-----
 drivers/pcmcia/yenta_socket.h                 |    2 -
 drivers/scsi/ipr.c                            |    4 +--
 drivers/scsi/ipr.h                            |    1 
 drivers/scsi/nsp32.c                          |    5 +---
 drivers/scsi/nsp32.h                          |    3 --
 drivers/usb/core/hcd-pci.c                    |    4 +--
 drivers/usb/core/hcd.h                        |    1 
 drivers/video/i810/i810.h                     |    1 
 drivers/video/i810/i810_main.c                |    4 +--
 include/linux/pci.h                           |    8 +++---
 sound/core/init.c                             |    2 -
 sound/oss/ali5455.c                           |    5 +---
 sound/oss/i810_audio.c                        |    5 +---
 57 files changed, 91 insertions(+), 152 deletions(-)


diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	2004-10-19 15:23:29 -07:00
+++ b/arch/alpha/kernel/pci.c	2004-10-19 15:23:29 -07:00
@@ -227,7 +227,7 @@
 	tmp->next = srm_saved_configs;
 	tmp->dev = dev;
 
-	pci_save_state(dev, tmp->regs);
+	pci_save_state(dev);
 
 	srm_saved_configs = tmp;
 }
@@ -243,7 +243,7 @@
 
 	/* Restore SRM config. */
 	for (tmp = srm_saved_configs; tmp; tmp = tmp->next) {
-		pci_restore_state(tmp->dev, tmp->regs);
+		pci_restore_state(tmp->dev);
 	}
 }
 #endif
diff -Nru a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
--- a/arch/alpha/kernel/pci_impl.h	2004-10-19 15:23:29 -07:00
+++ b/arch/alpha/kernel/pci_impl.h	2004-10-19 15:23:29 -07:00
@@ -166,7 +166,6 @@
 {
 	struct pdev_srm_saved_conf *next;
 	struct pci_dev *dev;
-	u32 regs[16];
 };
 
 extern void pci_restore_srm_config(void);
diff -Nru a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
--- a/drivers/char/agp/intel-agp.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/char/agp/intel-agp.c	2004-10-19 15:23:29 -07:00
@@ -1723,7 +1723,7 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	pci_restore_state(pdev, pdev->saved_config_space);
+	pci_restore_state(pdev);
 
 	if (bridge->driver == &intel_generic_driver)
 		intel_configure();
diff -Nru a/drivers/char/agp/intel-mch-agp.c b/drivers/char/agp/intel-mch-agp.c
--- a/drivers/char/agp/intel-mch-agp.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/char/agp/intel-mch-agp.c	2004-10-19 15:23:29 -07:00
@@ -573,7 +573,7 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 	
-	pci_restore_state(pdev, pdev->saved_config_space);
+	pci_restore_state(pdev);
 
 	if (bridge->driver == &intel_845_driver)
 		intel_845_configure();
diff -Nru a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/media/video/bttv-driver.c	2004-10-19 15:23:29 -07:00
@@ -3944,7 +3944,7 @@
 	btv->state.gpio_data   = gpio_read();
 
 	/* save pci state */
-	pci_save_state(pci_dev, btv->state.pci_cfg);
+	pci_save_state(pci_dev);
 	if (0 != pci_set_power_state(pci_dev, state)) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
@@ -3965,7 +3965,7 @@
 		btv->state.disabled = 0;
 	}
 	pci_set_power_state(pci_dev, 0);
-	pci_restore_state(pci_dev, btv->state.pci_cfg);
+	pci_restore_state(pci_dev);
 
 	/* restore bt878 state */
 	bttv_reinit_bt848(btv);
diff -Nru a/drivers/media/video/bttvp.h b/drivers/media/video/bttvp.h
--- a/drivers/media/video/bttvp.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/media/video/bttvp.h	2004-10-19 15:23:29 -07:00
@@ -277,7 +277,6 @@
 };
 
 struct bttv_suspend_state {
-	u32  pci_cfg[64 / sizeof(u32)];
 	u32  gpio_enable;
 	u32  gpio_data;
 	int  disabled;
diff -Nru a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
--- a/drivers/media/video/cx88/cx88-video.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/media/video/cx88/cx88-video.c	2004-10-19 15:23:29 -07:00
@@ -2545,7 +2545,7 @@
 	cx8800_shutdown(dev);
 	del_timer(&dev->vidq.timeout);
 	
-	pci_save_state(pci_dev, dev->state.pci_cfg);
+	pci_save_state(pci_dev);
 	if (0 != pci_set_power_state(pci_dev, state)) {
 		pci_disable_device(pci_dev);
 		dev->state.disabled = 1;
@@ -2564,7 +2564,7 @@
 		dev->state.disabled = 0;
 	}
 	pci_set_power_state(pci_dev, 0);
-	pci_restore_state(pci_dev, dev->state.pci_cfg);
+	pci_restore_state(pci_dev);
 
 	/* re-initialize hardware */
 	cx8800_reset(dev);
diff -Nru a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
--- a/drivers/media/video/cx88/cx88.h	2004-10-19 15:23:30 -07:00
+++ b/drivers/media/video/cx88/cx88.h	2004-10-19 15:23:30 -07:00
@@ -216,7 +216,6 @@
 };
 
 struct cx8800_suspend_state {
-	u32                        pci_cfg[64 / sizeof(u32)];
 	int                        disabled;
 };
 
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/media/video/meye.c	2004-10-19 15:23:29 -07:00
@@ -1236,7 +1236,7 @@
 #ifdef CONFIG_PM
 static int meye_suspend(struct pci_dev *pdev, u32 state)
 {
-	pci_save_state(pdev, meye.pm_state);
+	pci_save_state(pdev);
 	meye.pm_mchip_mode = meye.mchip_mode;
 	mchip_hic_stop();
 	mchip_set(MCHIP_MM_INTA, 0x0);
@@ -1245,7 +1245,7 @@
 
 static int meye_resume(struct pci_dev *pdev)
 {
-	pci_restore_state(pdev, meye.pm_state);
+	pci_restore_state(pdev);
 	pci_write_config_word(meye.mchip_dev, MCHIP_PCI_SOFTRESET_SET, 1);
 
 	mchip_delay(MCHIP_HIC_CMD, 0);
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/media/video/meye.h	2004-10-19 15:23:29 -07:00
@@ -315,7 +315,6 @@
 	struct video_picture picture;	/* video picture parameters */
 	struct meye_params params;	/* additional parameters */
 #ifdef CONFIG_PM
-	u32 pm_state[16];		/* PCI configuration space */
 	u8 pm_mchip_mode;		/* old mchip mode */
 #endif
 };
diff -Nru a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
--- a/drivers/message/fusion/mptbase.c	2004-10-19 15:23:30 -07:00
+++ b/drivers/message/fusion/mptbase.c	2004-10-19 15:23:30 -07:00
@@ -1517,7 +1517,7 @@
 		}
 	}
 
-	pci_save_state(pdev, ioc->PciState);
+	pci_save_state(pdev);
 
 	/* put ioc into READY_STATE */
 	if(SendIocReset(ioc, MPI_FUNCTION_IOC_MESSAGE_UNIT_RESET, CAN_SLEEP)) {
@@ -1557,7 +1557,7 @@
 		ioc->name, pdev, pci_name(pdev), device_state);
 
 	pci_set_power_state(pdev, 0);
-	pci_restore_state(pdev, ioc->PciState);
+	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 
 	/* enable interrupts */
diff -Nru a/drivers/message/fusion/mptbase.h b/drivers/message/fusion/mptbase.h
--- a/drivers/message/fusion/mptbase.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/message/fusion/mptbase.h	2004-10-19 15:23:29 -07:00
@@ -663,9 +663,6 @@
 	FCPortPage0_t		 fc_port_page0[2];
 	LANPage0_t		 lan_cnfg_page0;
 	LANPage1_t		 lan_cnfg_page1;
-#ifdef CONFIG_PM
-	u32           		 PciState[64];     /* save PCI state to this area */
-#endif
 	u8			 FirstWhoInit;
 	u8			 upload_fw;	/* If set, do a fw upload */
 	u8			 reload_fw;	/* Force a FW Reload on next reset */
diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/3c59x.c	2004-10-19 15:23:29 -07:00
@@ -817,7 +817,7 @@
 		partner_flow_ctrl:1,			/* Partner supports flow control */
 		has_nway:1,
 		enable_wol:1,					/* Wake-on-LAN is enabled */
-		pm_state_valid:1,				/* power_state[] has sane contents */
+		pm_state_valid:1,				/* pci_dev->saved_config_space has sane contents */
 		open:1,
 		medialock:1,
 		must_free_region:1,				/* Flag: if zero, Cardbus owns the I/O region */
@@ -834,7 +834,6 @@
 	u16 io_size;						/* Size of PCI region (for release_region) */
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
-	u32 power_state[16];
 };
 
 #ifdef CONFIG_PCI
@@ -1494,7 +1493,7 @@
 #endif
 	if (pdev && vp->enable_wol) {
 		vp->pm_state_valid = 1;
- 		pci_save_state(VORTEX_PCI(vp), vp->power_state);
+ 		pci_save_state(VORTEX_PCI(vp));
  		acpi_set_WOL(dev);
 	}
 	retval = register_netdev(dev);
@@ -1551,7 +1550,7 @@
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
-		pci_restore_state(VORTEX_PCI(vp), vp->power_state);
+		pci_restore_state(VORTEX_PCI(vp));
 	}
 
 	/* Before initializing select the active media port. */
@@ -2708,7 +2707,7 @@
 		outl(0, ioaddr + DownListPtr);
 
 	if (final_down && VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_save_state(VORTEX_PCI(vp), vp->power_state);
+		pci_save_state(VORTEX_PCI(vp));
 		acpi_set_WOL(dev);
 	}
 }
@@ -3166,7 +3165,7 @@
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		if (vp->pm_state_valid)
-			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
+			pci_restore_state(VORTEX_PCI(vp));
 	}
 	/* Should really use issue_and_wait() here */
 	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
diff -Nru a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/8139cp.c	2004-10-19 15:23:29 -07:00
@@ -366,7 +366,6 @@
 #endif
 
 	unsigned int		wol_enabled : 1; /* Is Wake-on-LAN enabled? */
-	u32			power_state[16];
 
 	struct mii_if_info	mii_if;
 };
@@ -1845,7 +1844,7 @@
 	spin_unlock_irqrestore (&cp->lock, flags);
 
 	if (cp->pdev && cp->wol_enabled) {
-		pci_save_state (cp->pdev, cp->power_state);
+		pci_save_state (cp->pdev);
 		cp_set_d3_state (cp);
 	}
 
@@ -1864,7 +1863,7 @@
 	
 	if (cp->pdev && cp->wol_enabled) {
 		pci_set_power_state (cp->pdev, 0);
-		pci_restore_state (cp->pdev, cp->power_state);
+		pci_restore_state (cp->pdev);
 	}
 	
 	cp_init_hw (cp);
diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/8139too.c	2004-10-19 15:23:29 -07:00
@@ -567,7 +567,6 @@
 	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
-	u32 pci_state[16];
 	u32 msg_enable;
 	struct net_device_stats stats;
 	unsigned char *rx_ring;
@@ -2589,7 +2588,7 @@
 	void *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
-	pci_save_state (pdev, tp->pci_state);
+	pci_save_state (pdev);
 
 	if (!netif_running (dev))
 		return 0;
@@ -2617,9 +2616,8 @@
 static int rtl8139_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
-	struct rtl8139_private *tp = dev->priv;
 
-	pci_restore_state (pdev, tp->pci_state);
+	pci_restore_state (pdev);
 	if (!netif_running (dev))
 		return 0;
 	pci_set_power_state (pdev, 0);
diff -Nru a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2004-10-19 15:23:30 -07:00
+++ b/drivers/net/amd8111e.c	2004-10-19 15:23:30 -07:00
@@ -1874,7 +1874,7 @@
 		pci_enable_wake(pci_dev, 4, 0); /* 4 == D3 cold */
 	}
 	
-	pci_save_state(pci_dev, lp->pm_state);
+	pci_save_state(pci_dev);
 	pci_set_power_state(pci_dev, 3);
 
 	return 0;
@@ -1888,7 +1888,7 @@
 		return 0;
 
 	pci_set_power_state(pci_dev, 0);
-	pci_restore_state(pci_dev, lp->pm_state);
+	pci_restore_state(pci_dev);
 
 	pci_enable_wake(pci_dev, 3, 0);
 	pci_enable_wake(pci_dev, 4, 0); /* D3 cold */
diff -Nru a/drivers/net/amd8111e.h b/drivers/net/amd8111e.h
--- a/drivers/net/amd8111e.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/amd8111e.h	2004-10-19 15:23:29 -07:00
@@ -780,7 +780,6 @@
 	
 	struct amd8111e_link_config link_config;
 	int pm_cap;
-	u32 pm_state[12];
 
 	struct net_device *next;
 	int mii;
diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/b44.c	2004-10-19 15:23:29 -07:00
@@ -1827,7 +1827,7 @@
 
 	pci_set_drvdata(pdev, dev);
 
-	pci_save_state(bp->pdev, bp->pci_cfg_state);
+	pci_save_state(bp->pdev);
 
 	printk(KERN_INFO "%s: Broadcom 4400 10/100BaseT Ethernet ", dev->name);
 	for (i = 0; i < 6; i++)
@@ -1893,7 +1893,7 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = dev->priv;
 
-	pci_restore_state(pdev, bp->pci_cfg_state);
+	pci_restore_state(pdev);
 
 	if (!netif_running(dev))
 		return 0;
diff -Nru a/drivers/net/b44.h b/drivers/net/b44.h
--- a/drivers/net/b44.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/b44.h	2004-10-19 15:23:29 -07:00
@@ -535,7 +535,6 @@
 
 	u32			rx_pending;
 	u32			tx_pending;
-	u32			pci_cfg_state[64 / sizeof(u32)];
 	u8			phy_addr;
 	u8			mdc_port;
 	u8			core_unit;
diff -Nru a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/e100.c	2004-10-19 15:23:29 -07:00
@@ -563,7 +563,6 @@
 	u16 leds;
 	u16 eeprom_wc;
 	u16 eeprom[256];
-	u32 pm_state[16];
 };
 
 static inline void e100_write_flush(struct nic *nic)
@@ -2310,7 +2309,7 @@
 	e100_hw_reset(nic);
 	netif_device_detach(netdev);
 
-	pci_save_state(pdev, nic->pm_state);
+	pci_save_state(pdev);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, state);
@@ -2324,7 +2323,7 @@
 	struct nic *nic = netdev_priv(netdev);
 
 	pci_set_power_state(pdev, 0);
-	pci_restore_state(pdev, nic->pm_state);
+	pci_restore_state(pdev);
 	e100_hw_init(nic);
 
 	netif_device_attach(netdev);
diff -Nru a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
--- a/drivers/net/e1000/e1000.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/e1000/e1000.h	2004-10-19 15:23:29 -07:00
@@ -254,7 +254,6 @@
 	struct e1000_desc_ring test_rx_ring;
 
 
-	uint32_t pci_state[16];
 	int msg_enable;
 };
 #endif /* _E1000_H_ */
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/e1000/e1000_main.c	2004-10-19 15:23:29 -07:00
@@ -2867,7 +2867,7 @@
 		pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
 	}
 
-	pci_save_state(pdev, adapter->pci_state);
+	pci_save_state(pdev);
 
 	if(adapter->hw.mac_type >= e1000_82540 &&
 	   adapter->hw.media_type == e1000_media_type_copper) {
@@ -2898,7 +2898,7 @@
 
 	pci_enable_device(pdev);
 	pci_set_power_state(pdev, 0);
-	pci_restore_state(pdev, adapter->pci_state);
+	pci_restore_state(pdev);
 
 	pci_enable_wake(pdev, 3, 0);
 	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/eepro100.c	2004-10-19 15:23:29 -07:00
@@ -490,9 +490,6 @@
 	unsigned short partner;			/* Link partner caps. */
 	struct mii_if_info mii_if;		/* MII API hooks, info */
 	u32 msg_enable;				/* debug message level */
-#ifdef CONFIG_PM
-	u32 pm_state[16];
-#endif
 };
 
 /* The parameters for a CmdConfigure operation.
@@ -2334,7 +2331,7 @@
 	struct speedo_private *sp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
-	pci_save_state(pdev, sp->pm_state);
+	pci_save_state(pdev);
 
 	if (!netif_running(dev))
 		return 0;
@@ -2354,7 +2351,7 @@
 	struct speedo_private *sp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
-	pci_restore_state(pdev, sp->pm_state);
+	pci_restore_state(pdev);
 
 	if (!netif_running(dev))
 		return 0;
diff -Nru a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/irda/vlsi_ir.c	2004-10-19 15:23:29 -07:00
@@ -1768,7 +1768,7 @@
 	if (netif_running(ndev)) {
 		netif_device_detach(ndev);
 		vlsi_stop_hw(idev);
-		pci_save_state(pdev, idev->cfg_space);
+		pci_save_state(pdev);
 		if (!idev->new_baud)
 			/* remember speed settings to restore on resume */
 			idev->new_baud = idev->baud;
@@ -1819,7 +1819,7 @@
 	}
 
 	if (netif_running(ndev)) {
-		pci_restore_state(pdev, idev->cfg_space);
+		pci_restore_state(pdev);
 		vlsi_start_hw(idev);
 		netif_device_attach(ndev);
 	}
diff -Nru a/drivers/net/irda/vlsi_ir.h b/drivers/net/irda/vlsi_ir.h
--- a/drivers/net/irda/vlsi_ir.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/irda/vlsi_ir.h	2004-10-19 15:23:29 -07:00
@@ -769,7 +769,6 @@
 	spinlock_t		lock;
 	struct semaphore	sem;
 
-	u32			cfg_space[64/sizeof(u32)];
 	u8			resume_ok;	
 	struct proc_dir_entry	*proc_entry;
 
diff -Nru a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
--- a/drivers/net/ixgb/ixgb.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/ixgb/ixgb.h	2004-10-19 15:23:29 -07:00
@@ -178,6 +178,5 @@
 	/* structs defined in ixgb_hw.h */
 	struct ixgb_hw hw;
 	struct ixgb_hw_stats stats;
-	uint32_t pci_state[16];
 };
 #endif				/* _IXGB_H_ */
diff -Nru a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/ixgb/ixgb_main.c	2004-10-19 15:23:29 -07:00
@@ -2117,7 +2117,7 @@
 	if (netif_running(netdev))
 		ixgb_down(adapter, TRUE);
 
-	pci_save_state(pdev, adapter->pci_state);
+	pci_save_state(pdev);
 
 	state = (state > 0) ? 3 : 0;
 	pci_set_power_state(pdev, state);
diff -Nru a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/pci-skeleton.c	2004-10-19 15:23:29 -07:00
@@ -481,7 +481,6 @@
 	unsigned int mediasense:1;	/* Media sensing in progress. */
 	spinlock_t lock;
 	chip_t chipset;
-	u32 pci_state[16];	/* Data saved during suspend */
 };
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
@@ -1921,7 +1920,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_save_state (pdev, tp->pci_state);
+	pci_save_state (pdev);
 	pci_set_power_state (pdev, 3);
 
 	return 0;
@@ -1936,7 +1935,7 @@
 	if (!netif_running(dev))
 		return 0;
 	pci_set_power_state (pdev, 0);
-	pci_restore_state (pdev, tp->pci_state);
+	pci_restore_state (pdev);
 	netif_device_attach (dev);
 	netdrv_hw_start (dev);
 
diff -Nru a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/s2io.c	2004-10-19 15:23:29 -07:00
@@ -1935,7 +1935,7 @@
 	schedule_timeout(HZ / 4);
 
 	/* Restore the PCI state saved during initializarion. */
-	pci_restore_state(sp->pdev, sp->config_space);
+	pci_restore_state(sp->pdev);
 	s2io_init_pci(sp);
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
@@ -4238,7 +4238,7 @@
 		goto register_failed;
 	}
 
-	pci_save_state(sp->pdev, sp->config_space);
+	pci_save_state(sp->pdev);
 
 	/* Setting swapper control on the NIC, for proper reset operation */
 	if (s2io_set_swapper(sp)) {
diff -Nru a/drivers/net/s2io.h b/drivers/net/s2io.h
--- a/drivers/net/s2io.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/s2io.h	2004-10-19 15:23:29 -07:00
@@ -667,7 +667,6 @@
 	u8 cache_line;
 	u32 rom_expansion;
 	u16 pcix_cmd;
-	u32 config_space[256 / sizeof(u32)];
 	u32 irq;
 	atomic_t rx_bufs_left[MAX_RX_RINGS];
 
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/sis900.c	2004-10-19 15:23:29 -07:00
@@ -172,7 +172,6 @@
 
 	unsigned int tx_full;			/* The Tx queue is full.    */
 	u8 host_bridge_rev;
-	u32 pci_state[16];
 };
 
 MODULE_AUTHOR("Jim Huang <cmhuang@sis.com.tw>, Ollie Lho <ollie@sis.com.tw>");
@@ -2200,7 +2199,6 @@
 static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
 {
 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
-	struct sis900_private *sis_priv = net_dev->priv;
 	long ioaddr = net_dev->base_addr;
 
 	if(!netif_running(net_dev))
@@ -2213,7 +2211,7 @@
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
 	pci_set_power_state(pci_dev, 3);
-	pci_save_state(pci_dev, sis_priv->pci_state);
+	pci_save_state(pci_dev);
 
 	return 0;
 }
@@ -2226,7 +2224,7 @@
 
 	if(!netif_running(net_dev))
 		return 0;
-	pci_restore_state(pci_dev, sis_priv->pci_state);
+	pci_restore_state(pci_dev);
 	pci_set_power_state(pci_dev, 0);
 
 	sis900_init_rxfilter(net_dev);
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/tg3.c	2004-10-19 15:23:29 -07:00
@@ -3788,7 +3788,7 @@
 		val |= PCISTATE_RETRY_SAME_DMA;
 	pci_write_config_dword(tp->pdev, TG3PCI_PCISTATE, val);
 
-	pci_restore_state(tp->pdev, tp->pci_cfg_state);
+	pci_restore_state(tp->pdev);
 
 	/* Make sure PCI-X relaxed ordering bit is clear. */
 	pci_read_config_dword(tp->pdev, TG3PCI_X_CAPS, &val);
@@ -8316,7 +8316,7 @@
 	 */
 	if ((tr32(HOSTCC_MODE) & HOSTCC_MODE_ENABLE) ||
 	    (tr32(WDMAC_MODE) & WDMAC_MODE_ENABLE)) {
-		pci_save_state(tp->pdev, tp->pci_cfg_state);
+		pci_save_state(tp->pdev);
 		tw32(MEMARB_MODE, MEMARB_MODE_ENABLE);
 		tg3_halt(tp);
 	}
@@ -8355,7 +8355,7 @@
 	 * of the PCI config space.  We need to restore this after
 	 * GRC_MISC_CFG core clock resets and some resume events.
 	 */
-	pci_save_state(tp->pdev, tp->pci_cfg_state);
+	pci_save_state(tp->pdev);
 
 	printk(KERN_INFO "%s: Tigon3 [partno(%s) rev %04x PHY(%s)] (PCI%s:%s:%s) %sBaseT Ethernet ",
 	       dev->name,
@@ -8474,7 +8474,7 @@
 	if (!netif_running(dev))
 		return 0;
 
-	pci_restore_state(tp->pdev, tp->pci_cfg_state);
+	pci_restore_state(tp->pdev);
 
 	err = tg3_set_power_state(tp, 0);
 	if (err)
diff -Nru a/drivers/net/tg3.h b/drivers/net/tg3.h
--- a/drivers/net/tg3.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/tg3.h	2004-10-19 15:23:29 -07:00
@@ -2120,7 +2120,6 @@
 	u8				pci_lat_timer;
 	u8				pci_hdr_type;
 	u8				pci_bist;
-	u32				pci_cfg_state[64 / sizeof(u32)];
 
 	int				pm_cap;
 
diff -Nru a/drivers/net/tulip/xircom_tulip_cb.c b/drivers/net/tulip/xircom_tulip_cb.c
--- a/drivers/net/tulip/xircom_tulip_cb.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/tulip/xircom_tulip_cb.c	2004-10-19 15:23:29 -07:00
@@ -329,9 +329,6 @@
 	int saved_if_port;
 	struct pci_dev *pdev;
 	spinlock_t lock;
-#ifdef CONFIG_PM
-	u32 pci_state[16];
-#endif
 };
 
 static int mdio_read(struct net_device *dev, int phy_id, int location);
@@ -1677,7 +1674,7 @@
 	if (tp->open)
 		xircom_down(dev);
 
-	pci_save_state(pdev, tp->pci_state);
+	pci_save_state(pdev);
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, 3);
 
@@ -1693,7 +1690,7 @@
 
 	pci_set_power_state(pdev,0);
 	pci_enable_device(pdev);
-	pci_restore_state(pdev, tp->pci_state);
+	pci_restore_state(pdev);
 
 	/* Bring the chip out of sleep mode.
 	   Caution: Snooze mode does not work with some boards! */
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/typhoon.c	2004-10-19 15:23:29 -07:00
@@ -279,7 +279,6 @@
 	u16			xcvr_select;
 	u16			wol_events;
 	u32			offload;
-	u32			pci_state[16];
 
 	/* unused stuff (future use) */
 	int			capabilities;
@@ -1894,7 +1893,7 @@
 	void __iomem *ioaddr = tp->ioaddr;
 
 	pci_set_power_state(pdev, 0);
-	pci_restore_state(pdev, tp->pci_state);
+	pci_restore_state(pdev);
 
 	/* Post 2.x.x versions of the Sleep Image require a reset before
 	 * we can download the Runtime Image. But let's not make users of
@@ -2309,7 +2308,7 @@
 	 * we lost our configuration and need to restore it to the
 	 * conditions at boot.
 	 */
-	pci_restore_state(pdev, NULL);
+	pci_restore_state(pdev);
 
 	err = pci_set_dma_mask(pdev, 0xffffffffULL);
 	if(err < 0) {
@@ -2377,7 +2376,7 @@
 	tp->dev = dev;
 
 	/* need to be able to restore PCI state after a suspend */
-	pci_save_state(pdev, tp->pci_state);
+	pci_save_state(pdev);
 
 	/* Init sequence:
 	 * 1) Reset the adapter to clear any bad juju
@@ -2542,7 +2541,7 @@
 
 	unregister_netdev(dev);
 	pci_set_power_state(pdev, 0);
-	pci_restore_state(pdev, tp->pci_state);
+	pci_restore_state(pdev);
 	typhoon_reset(tp->ioaddr, NoWait);
 	iounmap(tp->ioaddr);
 	pci_free_consistent(pdev, sizeof(struct typhoon_shared),
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/via-rhine.c	2004-10-19 15:23:29 -07:00
@@ -1951,7 +1951,7 @@
 		return 0;
 
 	netif_device_detach(dev);
-	pci_save_state(pdev, pdev->saved_config_space);
+	pci_save_state(pdev);
 
 	spin_lock_irqsave(&rp->lock, flags);
 	rhine_shutdown(&pdev->dev);
@@ -1975,7 +1975,7 @@
 		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",
 			dev->name, ret ? "failed" : "succeeded", ret);
 
-	pci_restore_state(pdev, pdev->saved_config_space);
+	pci_restore_state(pdev);
 
 	spin_lock_irqsave(&rp->lock, flags);
 #ifdef USE_MMIO
diff -Nru a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/via-velocity.c	2004-10-19 15:23:29 -07:00
@@ -3221,7 +3221,7 @@
 	netif_device_detach(vptr->dev);
 
 	spin_lock_irqsave(&vptr->lock, flags);
-	pci_save_state(pdev, vptr->pci_state);
+	pci_save_state(pdev);
 #ifdef ETHTOOL_GWOL
 	if (vptr->flags & VELOCITY_FLAGS_WOL_ENABLED) {
 		velocity_get_ip(vptr);
@@ -3254,7 +3254,7 @@
 
 	pci_set_power_state(pdev, 0);
 	pci_enable_wake(pdev, 0, 0);
-	pci_restore_state(pdev, vptr->pci_state);
+	pci_restore_state(pdev);
 
 	mac_wol_reset(vptr->mac_regs);
 
diff -Nru a/drivers/net/via-velocity.h b/drivers/net/via-velocity.h
--- a/drivers/net/via-velocity.h	2004-10-19 15:23:30 -07:00
+++ b/drivers/net/via-velocity.h	2004-10-19 15:23:30 -07:00
@@ -1739,10 +1739,6 @@
 	struct net_device *dev;
 	struct net_device_stats stats;
 
-#ifdef CONFIG_PM
-	u32 pci_state[16];
-#endif
-
 	dma_addr_t rd_pool_dma;
 	dma_addr_t td_pool_dma[TX_QUEUE_NO];
 
diff -Nru a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/wireless/airo.c	2004-10-19 15:23:29 -07:00
@@ -1210,7 +1210,6 @@
 	SsidRid			*SSID;
 	APListRid		*APList;
 #define	PCI_SHARED_LEN		2*MPI_MAX_FIDS*PKTSIZE+RIDSIZE
-	u32			pci_state[16];
 	char			proc_name[IFNAMSIZ];
 };
 
@@ -5492,7 +5491,7 @@
 	issuecommand(ai, &cmd, &rsp);
 
 	pci_enable_wake(pdev, state, 1);
-	pci_save_state(pdev, ai->pci_state);
+	pci_save_state(pdev);
 	return pci_set_power_state(pdev, state);
 }
 
@@ -5503,7 +5502,7 @@
 	Resp rsp;
 
 	pci_set_power_state(pdev, 0);
-	pci_restore_state(pdev, ai->pci_state);
+	pci_restore_state(pdev);
 	pci_enable_wake(pdev, ai->power, 0);
 
 	if (ai->power > 1) {
diff -Nru a/drivers/net/wireless/prism54/islpci_dev.h b/drivers/net/wireless/prism54/islpci_dev.h
--- a/drivers/net/wireless/prism54/islpci_dev.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/wireless/prism54/islpci_dev.h	2004-10-19 15:23:29 -07:00
@@ -106,7 +106,6 @@
 
 	/* PCI bus allocation & configuration members */
 	struct pci_dev *pdev;	/* PCI structure information */
-	u32 pci_state[16];	/* used for suspend/resume */
 	char firmware[33];
 
 	void __iomem *device_base;	/* ioremapped device base address */
diff -Nru a/drivers/net/wireless/prism54/islpci_hotplug.c b/drivers/net/wireless/prism54/islpci_hotplug.c
--- a/drivers/net/wireless/prism54/islpci_hotplug.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/net/wireless/prism54/islpci_hotplug.c	2004-10-19 15:23:29 -07:00
@@ -273,7 +273,7 @@
 	printk(KERN_NOTICE "%s: got suspend request (state %d)\n",
 	       ndev->name, state);
 
-	pci_save_state(pdev, priv->pci_state);
+	pci_save_state(pdev);
 
 	/* tell the device not to trigger interrupts for now... */
 	isl38xx_disable_interrupts(priv->device_base);
@@ -297,7 +297,7 @@
 
 	printk(KERN_NOTICE "%s: got resume request\n", ndev->name);
 
-	pci_restore_state(pdev, priv->pci_state);
+	pci_restore_state(pdev);
 
 	/* alright let's go into the PREBOOT state */
 	islpci_reset(priv, 1);
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/pci/pci-driver.c	2004-10-19 15:23:29 -07:00
@@ -309,7 +309,7 @@
 	if (drv && drv->suspend)
 		i = drv->suspend(pci_dev, dev_state);
 		
-	pci_save_state(pci_dev, pci_dev->saved_config_space);
+	pci_save_state(pci_dev);
 	return i;
 }
 
@@ -321,7 +321,7 @@
 static void pci_default_resume(struct pci_dev *pci_dev)
 {
 	/* restore the PCI config space */
-	pci_restore_state(pci_dev, pci_dev->saved_config_space);
+	pci_restore_state(pci_dev);
 	/* if the device was enabled before suspend, reenable */
 	if (pci_dev->is_enabled)
 		pci_enable_device(pci_dev);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/pci/pci.c	2004-10-19 15:23:29 -07:00
@@ -308,14 +308,12 @@
  * (>= 64 bytes).
  */
 int
-pci_save_state(struct pci_dev *dev, u32 *buffer)
+pci_save_state(struct pci_dev *dev)
 {
 	int i;
-	if (buffer) {
-		/* XXX: 100% dword access ok here? */
-		for (i = 0; i < 16; i++)
-			pci_read_config_dword(dev, i * 4,&buffer[i]);
-	}
+	/* XXX: 100% dword access ok here? */
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
 	return 0;
 }
 
@@ -326,27 +324,12 @@
  *
  */
 int 
-pci_restore_state(struct pci_dev *dev, u32 *buffer)
+pci_restore_state(struct pci_dev *dev)
 {
 	int i;
 
-	if (buffer) {
-		for (i = 0; i < 16; i++)
-			pci_write_config_dword(dev,i * 4, buffer[i]);
-	}
-	/*
-	 * otherwise, write the context information we know from bootup.
-	 * This works around a problem where warm-booting from Windows
-	 * combined with a D3(hot)->D0 transition causes PCI config
-	 * header data to be forgotten.
-	 */	
-	else {
-		for (i = 0; i < 6; i ++)
-			pci_write_config_dword(dev,
-					       PCI_BASE_ADDRESS_0 + (i * 4),
-					       dev->resource[i].start);
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-	}
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
 	return 0;
 }
 
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/pcmcia/yenta_socket.c	2004-10-19 15:23:29 -07:00
@@ -1023,9 +1023,9 @@
 			socket->type->save_state(socket);
 
 		/* FIXME: pci_save_state needs to have a better interface */
-		pci_save_state(dev, socket->saved_state);
-		pci_read_config_dword(dev, 16*4, &socket->saved_state[16]);
-		pci_read_config_dword(dev, 17*4, &socket->saved_state[17]);
+		pci_save_state(dev);
+		pci_read_config_dword(dev, 16*4, &socket->saved_state[0]);
+		pci_read_config_dword(dev, 17*4, &socket->saved_state[1]);
 		pci_set_power_state(dev, 3);
 	}
 
@@ -1040,9 +1040,9 @@
 	if (socket) {
 		pci_set_power_state(dev, 0);
 		/* FIXME: pci_restore_state needs to have a better interface */
-		pci_restore_state(dev, socket->saved_state);
-		pci_write_config_dword(dev, 16*4, socket->saved_state[16]);
-		pci_write_config_dword(dev, 17*4, socket->saved_state[17]);
+		pci_restore_state(dev);
+		pci_write_config_dword(dev, 16*4, socket->saved_state[0]);
+		pci_write_config_dword(dev, 17*4, socket->saved_state[1]);
 
 		if (socket->type && socket->type->restore_state)
 			socket->type->restore_state(socket);
diff -Nru a/drivers/pcmcia/yenta_socket.h b/drivers/pcmcia/yenta_socket.h
--- a/drivers/pcmcia/yenta_socket.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/pcmcia/yenta_socket.h	2004-10-19 15:23:29 -07:00
@@ -120,7 +120,7 @@
 	unsigned int private[8];
 
 	/* PCI saved state */
-	u32 saved_state[18];
+	u32 saved_state[2];
 };
 
 
diff -Nru a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
--- a/drivers/scsi/ipr.c	2004-10-19 15:23:30 -07:00
+++ b/drivers/scsi/ipr.c	2004-10-19 15:23:30 -07:00
@@ -4935,7 +4935,7 @@
 	int rc;
 
 	ENTER;
-	rc = pci_restore_state(ioa_cfg->pdev, ioa_cfg->pci_cfg_buf);
+	rc = pci_restore_state(ioa_cfg->pdev);
 
 	if (rc != PCIBIOS_SUCCESSFUL) {
 		ipr_cmd->ioasa.ioasc = cpu_to_be32(IPR_IOASC_PCI_ACCESS_ERROR);
@@ -5749,7 +5749,7 @@
 	}
 
 	/* Save away PCI config space for use following IOA reset */
-	rc = pci_save_state(pdev, ioa_cfg->pci_cfg_buf);
+	rc = pci_save_state(pdev);
 
 	if (rc != PCIBIOS_SUCCESSFUL) {
 		dev_err(&pdev->dev, "Failed to save PCI config space\n");
diff -Nru a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
--- a/drivers/scsi/ipr.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/scsi/ipr.h	2004-10-19 15:23:29 -07:00
@@ -889,7 +889,6 @@
 	unsigned long ioa_mailbox;
 	struct ipr_interrupts regs;
 
-	u32 pci_cfg_buf[64];
 	u16 saved_pcix_cmd_reg;
 	u16 reset_retries;
 
diff -Nru a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
--- a/drivers/scsi/nsp32.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/scsi/nsp32.c	2004-10-19 15:23:29 -07:00
@@ -3439,11 +3439,10 @@
 static int nsp32_suspend(struct pci_dev *pdev, u32 state)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
-	nsp32_hw_data    *data = (nsp32_hw_data *)host->hostdata;
 
 	nsp32_msg(KERN_INFO, "pci-suspend: pdev=0x%p, state=%ld, slot=%s, host=0x%p", pdev, state, pci_name(pdev), host);
 
-	pci_save_state     (pdev, data->PciState);
+	pci_save_state     (pdev);
 	pci_disable_device (pdev);
 	pci_set_power_state(pdev, state);
 
@@ -3461,7 +3460,7 @@
 
 	pci_set_power_state(pdev, 0);
 	pci_enable_wake    (pdev, 0, 0);
-	pci_restore_state  (pdev, data->PciState);
+	pci_restore_state  (pdev);
 
 	reg = nsp32_read2(data->BaseAddress, INDEX_REG);
 
diff -Nru a/drivers/scsi/nsp32.h b/drivers/scsi/nsp32.h
--- a/drivers/scsi/nsp32.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/scsi/nsp32.h	2004-10-19 15:23:29 -07:00
@@ -605,9 +605,6 @@
 	unsigned char msginbuf [MSGINBUF_MAX];	/* megin buffer     */
 	char	      msgin_len;		/* msginbuf length  */
 
-#ifdef CONFIG_PM
-	u32           PciState[16];     /* save PCI state to this area */
-#endif
 } nsp32_hw_data;
 
 /*
diff -Nru a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/usb/core/hcd-pci.c	2004-10-19 15:23:29 -07:00
@@ -305,7 +305,7 @@
 					retval);
 		else {
 			hcd->state = HCD_STATE_SUSPENDED;
-			pci_save_state (dev, hcd->pci_state);
+			pci_save_state (dev);
 #ifdef	CONFIG_USB_SUSPEND
 			pci_enable_wake (dev, state, hcd->remote_wakeup);
 			pci_enable_wake (dev, 4, hcd->remote_wakeup);
@@ -365,7 +365,7 @@
 		return retval;
 	}
 	pci_set_master (dev);
-	pci_restore_state (dev, hcd->pci_state);
+	pci_restore_state (dev);
 #ifdef	CONFIG_USB_SUSPEND
 	pci_enable_wake (dev, dev->current_state, 0);
 	pci_enable_wake (dev, 4, 0);
diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/usb/core/hcd.h	2004-10-19 15:23:29 -07:00
@@ -81,7 +81,6 @@
 
 #ifdef	CONFIG_PCI
 	int			region;		/* pci region for regs */
-	u32			pci_state [16];	/* for PM state save */
 #endif
 
 #define HCD_BUFFER_POOLS	4
diff -Nru a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
--- a/drivers/video/i810/i810.h	2004-10-19 15:23:29 -07:00
+++ b/drivers/video/i810/i810.h	2004-10-19 15:23:29 -07:00
@@ -254,7 +254,6 @@
 	drm_agp_t                *drm_agp;
 	atomic_t                 use_count;
 	u32 pseudo_palette[17];
-	u32 pci_state[16];
 	unsigned long mmio_start_phys;
 	u8 *mmio_start_virtual;
 	u32 pitch;
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-19 15:23:29 -07:00
+++ b/drivers/video/i810/i810_main.c	2004-10-19 15:23:29 -07:00
@@ -1517,7 +1517,7 @@
 		par->drm_agp->unbind_memory(par->i810_gtt.i810_cursor_memory);
 		pci_disable_device(dev);
 	}
-	pci_save_state(dev, par->pci_state);
+	pci_save_state(dev);
 	pci_set_power_state(dev, state);
 
 	return 0;
@@ -1531,7 +1531,7 @@
 	if (par->cur_state == 0)
 		return 0;
 
-	pci_restore_state(dev, par->pci_state);
+	pci_restore_state(dev);
 	pci_set_power_state(dev, 0);
 	pci_enable_device(dev);
 	par->drm_agp->bind_memory(par->i810_gtt.i810_fb_memory, 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:23:29 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:23:29 -07:00
@@ -777,8 +777,8 @@
 int pci_assign_resource(struct pci_dev *dev, int i);
 
 /* Power management related routines */
-int pci_save_state(struct pci_dev *dev, u32 *buffer);
-int pci_restore_state(struct pci_dev *dev, u32 *buffer);
+int pci_save_state(struct pci_dev *dev);
+int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
 
@@ -909,8 +909,8 @@
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 /* Power management related routines */
-static inline int pci_save_state(struct pci_dev *dev, u32 *buffer) { return 0; }
-static inline int pci_restore_state(struct pci_dev *dev, u32 *buffer) { return 0; }
+static inline int pci_save_state(struct pci_dev *dev) { return 0; }
+static inline int pci_restore_state(struct pci_dev *dev) { return 0; }
 static inline int pci_set_power_state(struct pci_dev *dev, int state) { return 0; }
 static inline int pci_enable_wake(struct pci_dev *dev, u32 state, int enable) { return 0; }
 
diff -Nru a/sound/core/init.c b/sound/core/init.c
--- a/sound/core/init.c	2004-10-19 15:23:29 -07:00
+++ b/sound/core/init.c	2004-10-19 15:23:29 -07:00
@@ -801,7 +801,7 @@
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		return 0;
 	/* restore the PCI config space */
-	pci_restore_state(dev, dev->saved_config_space);
+	pci_restore_state(dev);
 	/* FIXME: correct state value? */
 	return card->pm_resume(card, 0);
 }
diff -Nru a/sound/oss/ali5455.c b/sound/oss/ali5455.c
--- a/sound/oss/ali5455.c	2004-10-19 15:23:29 -07:00
+++ b/sound/oss/ali5455.c	2004-10-19 15:23:29 -07:00
@@ -311,7 +311,6 @@
 	u16 pci_id;
 #ifdef CONFIG_PM
 	u16 pm_suspended;
-	u32 pm_save_state[64 / sizeof(u32)];
 	int pm_saved_mixer_settings[SOUND_MIXER_NRDEVICES][NR_AC97];
 #endif
 	/* soundcore stuff */
@@ -3576,7 +3575,7 @@
 			}
 		}
 	}
-	pci_save_state(dev, card->pm_save_state);	/* XXX do we need this? */
+	pci_save_state(dev);	/* XXX do we need this? */
 	pci_disable_device(dev);	/* disable busmastering */
 	pci_set_power_state(dev, 3);	/* Zzz. */
 	return 0;
@@ -3588,7 +3587,7 @@
 	int num_ac97, i = 0;
 	struct ali_card *card = pci_get_drvdata(dev);
 	pci_enable_device(dev);
-	pci_restore_state(dev, card->pm_save_state);
+	pci_restore_state(dev);
 	/* observation of a toshiba portege 3440ct suggests that the 
 	   hardware has to be more or less completely reinitialized from
 	   scratch after an apm suspend.  Works For Me.   -dan */
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	2004-10-19 15:23:29 -07:00
+++ b/sound/oss/i810_audio.c	2004-10-19 15:23:29 -07:00
@@ -406,7 +406,6 @@
 	u16 pci_id_internal; /* used to access card_cap[] */
 #ifdef CONFIG_PM	
 	u16 pm_suspended;
-	u32 pm_save_state[64/sizeof(u32)];
 	int pm_saved_mixer_settings[SOUND_MIXER_NRDEVICES][NR_AC97];
 #endif
 	/* soundcore stuff */
@@ -3385,7 +3384,7 @@
 			}
 		}
 	}
-	pci_save_state(dev,card->pm_save_state); /* XXX do we need this? */
+	pci_save_state(dev); /* XXX do we need this? */
 	pci_disable_device(dev); /* disable busmastering */
 	pci_set_power_state(dev,3); /* Zzz. */
 
@@ -3398,7 +3397,7 @@
 	int num_ac97,i=0;
 	struct i810_card *card=pci_get_drvdata(dev);
 	pci_enable_device(dev);
-	pci_restore_state (dev,card->pm_save_state);
+	pci_restore_state (dev);
 
 	/* observation of a toshiba portege 3440ct suggests that the 
 	   hardware has to be more or less completely reinitialized from

