Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWDTVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWDTVqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWDTVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:46:19 -0400
Received: from havoc.gtf.org ([69.61.125.42]:42419 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751347AbWDTVqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:46:17 -0400
Date: Thu, 20 Apr 2006 17:46:00 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060420214600.GA7754@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/ne.c                               |    2 
 drivers/net/wireless/Kconfig                   |    2 
 drivers/net/wireless/airo.c                    |   46 +++-------
 drivers/net/wireless/atmel.c                   |   11 ++
 drivers/net/wireless/bcm43xx/Kconfig           |    3 
 drivers/net/wireless/bcm43xx/bcm43xx.h         |   17 +++
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c |    8 -
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c     |   13 +-
 drivers/net/wireless/bcm43xx/bcm43xx_main.c    |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c     |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_power.c   |  115 ++++++++++++++-----------
 drivers/net/wireless/bcm43xx/bcm43xx_power.h   |    9 +
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c   |  115 ++++++++++++++-----------
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h   |   16 ---
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c      |    8 -
 drivers/net/wireless/orinoco.c                 |    2 
 include/net/ieee80211softmac.h                 |    3 
 net/core/dev.c                                 |    3 
 net/core/wireless.c                            |    8 +
 net/ieee80211/softmac/Kconfig                  |    1 
 net/ieee80211/softmac/ieee80211softmac_assoc.c |    5 -
 net/ieee80211/softmac/ieee80211softmac_event.c |   40 +++++++-
 net/ieee80211/softmac/ieee80211softmac_io.c    |   18 +++
 net/ieee80211/softmac/ieee80211softmac_scan.c  |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c    |   10 ++
 25 files changed, 289 insertions(+), 171 deletions(-)

Adrian Bunk:
      bcm43xx: fix dyn tssi2dbm memleak

Dan Williams:
      wireless/airo: clean up WEXT association and scan events
      wireless/atmel: send WEXT scan completion events

Erik Mouw:
      bcm43xx: iw_priv_args names should be <16 characters

Jean Tourrilhes:
      wext: Fix IWENCODEEXT security permissions
      Revert NET_RADIO Kconfig title change
      wext: Fix RtNetlink ENCODE security permissions

Johannes Berg:
      softmac: fix event sending
      softmac: report when scanning has finished

johannes@sipsolutions.net:
      softmac: return -EAGAIN from getscan while scanning
      softmac: dont send out packets while scanning
      softmac: handle iw_mode properly

Michael Buesch:
      softmac: fix spinlock recursion on reassoc
      bcm43xx: set trans_start on TX to prevent bogus timeouts
      bcm43xx: fix pctl slowclock limit calculation
      bcm43xx: sysfs code cleanup

Pavel Roskin:
      orinoco: fix truncating commsquality RID with the latest Symbol firmware

Randy Dunlap:
      softmac uses Wiress Ext.
      bcm43xx wireless: fix printk format warnings
      bcm43xx: fix config menu alignment

Sergei Shtylyov:
      NEx000: fix RTL8019AS base address for RBTX4938

diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index 08b218c..93c494b 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -226,7 +226,7 @@ struct net_device * __init ne_probe(int 
 	netdev_boot_setup_check(dev);
 
 #ifdef CONFIG_TOSHIBA_RBTX4938
-	dev->base_addr = 0x07f20280;
+	dev->base_addr = RBTX4938_RTL_8019_BASE;
 	dev->irq = RBTX4938_RTL_8019_IRQ;
 #endif
 	err = do_ne_probe(dev);
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index bad09eb..e0874cb 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -6,7 +6,7 @@ menu "Wireless LAN (non-hamradio)"
 	depends on NETDEVICES
 
 config NET_RADIO
-	bool "Wireless LAN drivers (non-hamradio)"
+	bool "Wireless LAN drivers (non-hamradio) & Wireless Extensions"
 	select WIRELESS_EXT
 	---help---
 	  Support for wireless LANs and everything having to do with radio,
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 108d9fe..00764dd 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -3139,6 +3139,7 @@ static irqreturn_t airo_interrupt ( int 
 		}
 		if ( status & EV_LINK ) {
 			union iwreq_data	wrqu;
+			int scan_forceloss = 0;
 			/* The link status has changed, if you want to put a
 			   monitor hook in, do it here.  (Remember that
 			   interrupts are still disabled!)
@@ -3157,7 +3158,8 @@ static irqreturn_t airo_interrupt ( int 
 			  code) */
 #define AUTHFAIL 0x0300 /* Authentication failure (low byte is reason
 			   code) */
-#define ASSOCIATED 0x0400 /* Assocatied */
+#define ASSOCIATED 0x0400 /* Associated */
+#define REASSOCIATED 0x0600 /* Reassociated?  Only on firmware >= 5.30.17 */
 #define RC_RESERVED 0 /* Reserved return code */
 #define RC_NOREASON 1 /* Unspecified reason */
 #define RC_AUTHINV 2 /* Previous authentication invalid */
@@ -3174,44 +3176,30 @@ static irqreturn_t airo_interrupt ( int 
 			  leaving BSS */
 #define RC_NOAUTH 9 /* Station requesting (Re)Association is not
 		       Authenticated with the responding station */
-			if (newStatus != ASSOCIATED) {
-				if (auto_wep && !apriv->expires) {
-					apriv->expires = RUN_AT(3*HZ);
-					wake_up_interruptible(&apriv->thr_wait);
-				}
-			} else {
-				struct task_struct *task = apriv->task;
+			if (newStatus == FORCELOSS && apriv->scan_timeout > 0)
+				scan_forceloss = 1;
+			if(newStatus == ASSOCIATED || newStatus == REASSOCIATED) {
 				if (auto_wep)
 					apriv->expires = 0;
-				if (task)
-					wake_up_process (task);
+				if (apriv->task)
+					wake_up_process (apriv->task);
 				set_bit(FLAG_UPDATE_UNI, &apriv->flags);
 				set_bit(FLAG_UPDATE_MULTI, &apriv->flags);
-			}
-			/* Question : is ASSOCIATED the only status
-			 * that is valid ? We want to catch handover
-			 * and reassociations as valid status
-			 * Jean II */
-			if(newStatus == ASSOCIATED) {
-#if 0
-				/* FIXME: Grabbing scan results here
-				 * seems to be too early???  Just wait for
-				 * timeout instead. */
-				if (apriv->scan_timeout > 0) {
-					set_bit(JOB_SCAN_RESULTS, &apriv->flags);
-					wake_up_interruptible(&apriv->thr_wait);
-				}
-#endif
+
 				if (down_trylock(&apriv->sem) != 0) {
 					set_bit(JOB_EVENT, &apriv->flags);
 					wake_up_interruptible(&apriv->thr_wait);
 				} else
 					airo_send_event(dev);
-			} else {
-				memset(wrqu.ap_addr.sa_data, '\0', ETH_ALEN);
-				wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+			} else if (!scan_forceloss) {
+				if (auto_wep && !apriv->expires) {
+					apriv->expires = RUN_AT(3*HZ);
+					wake_up_interruptible(&apriv->thr_wait);
+				}
 
 				/* Send event to user space */
+				memset(wrqu.ap_addr.sa_data, '\0', ETH_ALEN);
+				wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 				wireless_send_event(dev, SIOCGIWAP, &wrqu,NULL);
 			}
 		}
@@ -7136,10 +7124,10 @@ static int airo_set_scan(struct net_devi
 		goto out;
 
 	/* Initiate a scan command */
+	ai->scan_timeout = RUN_AT(3*HZ);
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd=CMD_LISTBSS;
 	issuecommand(ai, &cmd, &rsp);
-	ai->scan_timeout = RUN_AT(3*HZ);
 	wake = 1;
 
 out:
diff --git a/drivers/net/wireless/atmel.c b/drivers/net/wireless/atmel.c
index 87afa68..8606c88 100644
--- a/drivers/net/wireless/atmel.c
+++ b/drivers/net/wireless/atmel.c
@@ -3463,6 +3463,7 @@ static void atmel_command_irq(struct atm
 	u8 status = atmel_rmem8(priv, atmel_co(priv, CMD_BLOCK_STATUS_OFFSET));
 	u8 command = atmel_rmem8(priv, atmel_co(priv, CMD_BLOCK_COMMAND_OFFSET));
 	int fast_scan;
+	union iwreq_data wrqu;
 
 	if (status == CMD_STATUS_IDLE ||
 	    status == CMD_STATUS_IN_PROGRESS)
@@ -3487,6 +3488,7 @@ static void atmel_command_irq(struct atm
 			atmel_scan(priv, 1);
 		} else {
 			int bss_index = retrieve_bss(priv);
+			int notify_scan_complete = 1;
 			if (bss_index != -1) {
 				atmel_join_bss(priv, bss_index);
 			} else if (priv->operating_mode == IW_MODE_ADHOC &&
@@ -3495,8 +3497,14 @@ static void atmel_command_irq(struct atm
 			} else {
 				priv->fast_scan = !fast_scan;
 				atmel_scan(priv, 1);
+				notify_scan_complete = 0;
 			}
 			priv->site_survey_state = SITE_SURVEY_COMPLETED;
+			if (notify_scan_complete) {
+				wrqu.data.length = 0;
+				wrqu.data.flags = 0;
+				wireless_send_event(priv->dev, SIOCGIWSCAN, &wrqu, NULL);
+			}
 		}
 		break;
 
@@ -3509,6 +3517,9 @@ static void atmel_command_irq(struct atm
 		priv->site_survey_state = SITE_SURVEY_COMPLETED;
 		if (priv->station_is_associated) {
 			atmel_enter_state(priv, STATION_STATE_READY);
+			wrqu.data.length = 0;
+			wrqu.data.flags = 0;
+			wireless_send_event(priv->dev, SIOCGIWSCAN, &wrqu, NULL);
 		} else {
 			atmel_scan(priv, 1);
 		}
diff --git a/drivers/net/wireless/bcm43xx/Kconfig b/drivers/net/wireless/bcm43xx/Kconfig
index 4184656..25ea474 100644
--- a/drivers/net/wireless/bcm43xx/Kconfig
+++ b/drivers/net/wireless/bcm43xx/Kconfig
@@ -17,8 +17,11 @@ config BCM43XX_DEBUG
 
 config BCM43XX_DMA
 	bool
+	depends on BCM43XX
+
 config BCM43XX_PIO
 	bool
+	depends on BCM43XX
 
 choice
 	prompt "BCM43xx data transfer mode"
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx.h b/drivers/net/wireless/bcm43xx/bcm43xx.h
index dcadd29..2e83083 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx.h
@@ -15,7 +15,6 @@
 
 #include "bcm43xx_debugfs.h"
 #include "bcm43xx_leds.h"
-#include "bcm43xx_sysfs.h"
 
 
 #define PFX				KBUILD_MODNAME ": "
@@ -638,8 +637,6 @@ struct bcm43xx_key {
 };
 
 struct bcm43xx_private {
-	struct bcm43xx_sysfs sysfs;
-
 	struct ieee80211_device *ieee;
 	struct ieee80211softmac_device *softmac;
 
@@ -772,6 +769,20 @@ struct bcm43xx_private * bcm43xx_priv(st
 	return ieee80211softmac_priv(dev);
 }
 
+struct device;
+
+static inline
+struct bcm43xx_private * dev_to_bcm(struct device *dev)
+{
+	struct net_device *net_dev;
+	struct bcm43xx_private *bcm;
+
+	net_dev = dev_get_drvdata(dev);
+	bcm = bcm43xx_priv(net_dev);
+
+	return bcm;
+}
+
 
 /* Helper function, which returns a boolean.
  * TRUE, if PIO is used; FALSE, if DMA is used.
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c b/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
index d2c3401..35a4fcb 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
@@ -452,12 +452,12 @@ void bcm43xx_printk_dump(const char *dat
 	size_t i;
 	char c;
 
-	printk(KERN_INFO PFX "Data dump (%s, %u bytes):",
+	printk(KERN_INFO PFX "Data dump (%s, %zd bytes):",
 	       description, size);
 	for (i = 0; i < size; i++) {
 		c = data[i];
 		if (i % 8 == 0)
-			printk("\n" KERN_INFO PFX "0x%08x:  0x%02x, ", i, c & 0xff);
+			printk("\n" KERN_INFO PFX "0x%08zx:  0x%02x, ", i, c & 0xff);
 		else
 			printk("0x%02x, ", c & 0xff);
 	}
@@ -472,12 +472,12 @@ void bcm43xx_printk_bitdump(const unsign
 	int j;
 	const unsigned char *d;
 
-	printk(KERN_INFO PFX "*** Bitdump (%s, %u bytes, %s) ***",
+	printk(KERN_INFO PFX "*** Bitdump (%s, %zd bytes, %s) ***",
 	       description, bytes, msb_to_lsb ? "MSB to LSB" : "LSB to MSB");
 	for (i = 0; i < bytes; i++) {
 		d = data + i;
 		if (i % 8 == 0)
-			printk("\n" KERN_INFO PFX "0x%08x:  ", i);
+			printk("\n" KERN_INFO PFX "0x%08zx:  ", i);
 		if (msb_to_lsb) {
 			for (j = 7; j >= 0; j--) {
 				if (*d & (1 << j))
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_dma.c b/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
index c3681b8..bbecba0 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
@@ -196,8 +196,9 @@ static int alloc_ringmemory(struct bcm43
 	}
 	if (ring->dmabase + BCM43xx_DMA_RINGMEMSIZE > BCM43xx_DMA_BUSADDRMAX) {
 		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA RINGMEMORY >1G "
-				    "(0x%08x, len: %lu)\n",
-		       ring->dmabase, BCM43xx_DMA_RINGMEMSIZE);
+				    "(0x%llx, len: %lu)\n",
+				(unsigned long long)ring->dmabase,
+				BCM43xx_DMA_RINGMEMSIZE);
 		dma_free_coherent(dev, BCM43xx_DMA_RINGMEMSIZE,
 				  ring->vbase, ring->dmabase);
 		return -ENOMEM;
@@ -307,8 +308,8 @@ static int setup_rx_descbuffer(struct bc
 		unmap_descbuffer(ring, dmaaddr, ring->rx_buffersize, 0);
 		dev_kfree_skb_any(skb);
 		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA RX SKB >1G "
-				    "(0x%08x, len: %u)\n",
-		       dmaaddr, ring->rx_buffersize);
+				    "(0x%llx, len: %u)\n",
+			(unsigned long long)dmaaddr, ring->rx_buffersize);
 		return -ENOMEM;
 	}
 	meta->skb = skb;
@@ -729,8 +730,8 @@ static int dma_tx_fragment(struct bcm43x
 	if (unlikely(meta->dmaaddr + skb->len > BCM43xx_DMA_BUSADDRMAX)) {
 		return_slot(ring, slot);
 		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA TX SKB >1G "
-				    "(0x%08x, len: %u)\n",
-		       meta->dmaaddr, skb->len);
+				    "(0x%llx, len: %u)\n",
+			(unsigned long long)meta->dmaaddr, skb->len);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index c37371f..9a06e61 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -52,6 +52,7 @@
 #include "bcm43xx_wx.h"
 #include "bcm43xx_ethtool.h"
 #include "bcm43xx_xmit.h"
+#include "bcm43xx_sysfs.h"
 
 
 MODULE_DESCRIPTION("Broadcom BCM43xx wireless driver");
@@ -3522,6 +3523,7 @@ static inline int bcm43xx_tx(struct bcm4
 		err = bcm43xx_pio_tx(bcm, txb);
 	else
 		err = bcm43xx_dma_tx(bcm, txb);
+	bcm->net_dev->trans_start = jiffies;
 
 	return err;
 }
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_phy.c b/drivers/net/wireless/bcm43xx/bcm43xx_phy.c
index 0a66f43..3313716 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_phy.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_phy.c
@@ -2151,6 +2151,7 @@ int bcm43xx_phy_init_tssi2dbm_table(stru
 				phy->tssi2dbm = NULL;
 				printk(KERN_ERR PFX "Could not generate "
 						    "tssi2dBm table\n");
+				kfree(dyn_tssi2dbm);
 				return -ENODEV;
 			}
 		phy->tssi2dbm = dyn_tssi2dbm;
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_power.c b/drivers/net/wireless/bcm43xx/bcm43xx_power.c
index 3c92b62..6569da3 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_power.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_power.c
@@ -35,77 +35,101 @@
 #include "bcm43xx_main.h"
 
 
+/* Get the Slow Clock Source */
+static int bcm43xx_pctl_get_slowclksrc(struct bcm43xx_private *bcm)
+{
+	u32 tmp;
+	int err;
+
+	assert(bcm->current_core == &bcm->core_chipcommon);
+	if (bcm->current_core->rev < 6) {
+		if (bcm->bustype == BCM43xx_BUSTYPE_PCMCIA ||
+		    bcm->bustype == BCM43xx_BUSTYPE_SB)
+			return BCM43xx_PCTL_CLKSRC_XTALOS;
+		if (bcm->bustype == BCM43xx_BUSTYPE_PCI) {
+			err = bcm43xx_pci_read_config32(bcm, BCM43xx_PCTL_OUT, &tmp);
+			assert(!err);
+			if (tmp & 0x10)
+				return BCM43xx_PCTL_CLKSRC_PCI;
+			return BCM43xx_PCTL_CLKSRC_XTALOS;
+		}
+	}
+	if (bcm->current_core->rev < 10) {
+		tmp = bcm43xx_read32(bcm, BCM43xx_CHIPCOMMON_SLOWCLKCTL);
+		tmp &= 0x7;
+		if (tmp == 0)
+			return BCM43xx_PCTL_CLKSRC_LOPWROS;
+		if (tmp == 1)
+			return BCM43xx_PCTL_CLKSRC_XTALOS;
+		if (tmp == 2)
+			return BCM43xx_PCTL_CLKSRC_PCI;
+	}
+
+	return BCM43xx_PCTL_CLKSRC_XTALOS;
+}
+
 /* Get max/min slowclock frequency
  * as described in http://bcm-specs.sipsolutions.net/PowerControl
  */
 static int bcm43xx_pctl_clockfreqlimit(struct bcm43xx_private *bcm,
 				       int get_max)
 {
-	int limit = 0;
+	int limit;
+	int clocksrc;
 	int divisor;
-	int selection;
-	int err;
 	u32 tmp;
-	struct bcm43xx_coreinfo *old_core;
 
-	if (!(bcm->chipcommon_capabilities & BCM43xx_CAPABILITIES_PCTL))
-		goto out;
-	old_core = bcm->current_core;
-	err = bcm43xx_switch_core(bcm, &bcm->core_chipcommon);
-	if (err)
-		goto out;
+	assert(bcm->chipcommon_capabilities & BCM43xx_CAPABILITIES_PCTL);
+	assert(bcm->current_core == &bcm->core_chipcommon);
 
+	clocksrc = bcm43xx_pctl_get_slowclksrc(bcm);
 	if (bcm->current_core->rev < 6) {
-		if ((bcm->bustype == BCM43xx_BUSTYPE_PCMCIA) ||
-			(bcm->bustype == BCM43xx_BUSTYPE_SB)) {
-			selection = 1;
+		switch (clocksrc) {
+		case BCM43xx_PCTL_CLKSRC_PCI:
+			divisor = 64;
+			break;
+		case BCM43xx_PCTL_CLKSRC_XTALOS:
 			divisor = 32;
-		} else {
-			err = bcm43xx_pci_read_config32(bcm, BCM43xx_PCTL_OUT, &tmp);
-			if (err) {
-				printk(KERN_ERR PFX "clockfreqlimit pcicfg read failure\n");
-				goto out_switchback;
-			}
-			if (tmp & 0x10) {
-				/* PCI */
-				selection = 2;
-				divisor = 64;
-			} else {
-				/* XTAL */
-				selection = 1;
-				divisor = 32;
-			}
+			break;
+		default:
+			assert(0);
+			divisor = 1;
 		}
 	} else if (bcm->current_core->rev < 10) {
-		selection = (tmp & 0x07);
-		if (selection) {
+		switch (clocksrc) {
+		case BCM43xx_PCTL_CLKSRC_LOPWROS:
+			divisor = 1;
+			break;
+		case BCM43xx_PCTL_CLKSRC_XTALOS:
+		case BCM43xx_PCTL_CLKSRC_PCI:
 			tmp = bcm43xx_read32(bcm, BCM43xx_CHIPCOMMON_SLOWCLKCTL);
-			divisor = 4 * (1 + ((tmp & 0xFFFF0000) >> 16));
-		} else
+			divisor = ((tmp & 0xFFFF0000) >> 16) + 1;
+			divisor *= 4;
+			break;
+		default:
+			assert(0);
 			divisor = 1;
+		}
 	} else {
 		tmp = bcm43xx_read32(bcm, BCM43xx_CHIPCOMMON_SYSCLKCTL);
-		divisor = 4 * (1 + ((tmp & 0xFFFF0000) >> 16));
-		selection = 1;
+		divisor = ((tmp & 0xFFFF0000) >> 16) + 1;
+		divisor *= 4;
 	}
-	
-	switch (selection) {
-	case 0:
-		/* LPO */
+
+	switch (clocksrc) {
+	case BCM43xx_PCTL_CLKSRC_LOPWROS:
 		if (get_max)
 			limit = 43000;
 		else
 			limit = 25000;
 		break;
-	case 1:
-		/* XTAL */
+	case BCM43xx_PCTL_CLKSRC_XTALOS:
 		if (get_max)
 			limit = 20200000;
 		else
 			limit = 19800000;
 		break;
-	case 2:
-		/* PCI */
+	case BCM43xx_PCTL_CLKSRC_PCI:
 		if (get_max)
 			limit = 34000000;
 		else
@@ -113,17 +137,14 @@ static int bcm43xx_pctl_clockfreqlimit(s
 		break;
 	default:
 		assert(0);
+		limit = 0;
 	}
 	limit /= divisor;
 
-out_switchback:
-	err = bcm43xx_switch_core(bcm, old_core);
-	assert(err == 0);
-
-out:
 	return limit;
 }
 
+
 /* init power control
  * as described in http://bcm-specs.sipsolutions.net/PowerControl
  */
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_power.h b/drivers/net/wireless/bcm43xx/bcm43xx_power.h
index 5f63640..c966ab3 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_power.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_power.h
@@ -33,6 +33,15 @@
 
 #include <linux/types.h>
 
+/* Clock sources */
+enum {
+	/* PCI clock */
+	BCM43xx_PCTL_CLKSRC_PCI,
+	/* Crystal slow clock oscillator */
+	BCM43xx_PCTL_CLKSRC_XTALOS,
+	/* Low power oscillator */
+	BCM43xx_PCTL_CLKSRC_LOPWROS,
+};
 
 struct bcm43xx_private;
 
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c b/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c
index c44d890..b438f48 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c
@@ -71,14 +71,46 @@ static int get_boolean(const char *buf, 
 	return -EINVAL;
 }
 
+static int sprom2hex(const u16 *sprom, char *buf, size_t buf_len)
+{
+	int i, pos = 0;
+
+	for (i = 0; i < BCM43xx_SPROM_SIZE; i++) {
+		pos += snprintf(buf + pos, buf_len - pos - 1,
+				"%04X", swab16(sprom[i]) & 0xFFFF);
+	}
+	pos += snprintf(buf + pos, buf_len - pos - 1, "\n");
+
+	return pos + 1;
+}
+
+static int hex2sprom(u16 *sprom, const char *dump, size_t len)
+{
+	char tmp[5] = { 0 };
+	int cnt = 0;
+	unsigned long parsed;
+
+	if (len < BCM43xx_SPROM_SIZE * sizeof(u16) * 2)
+		return -EINVAL;
+
+	while (cnt < BCM43xx_SPROM_SIZE) {
+		memcpy(tmp, dump, 4);
+		dump += 4;
+		parsed = simple_strtoul(tmp, NULL, 16);
+		sprom[cnt++] = swab16((u16)parsed);
+	}
+
+	return 0;
+}
+
 static ssize_t bcm43xx_attr_sprom_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct bcm43xx_private *bcm = devattr_to_bcm(attr, attr_sprom);
+	struct bcm43xx_private *bcm = dev_to_bcm(dev);
 	u16 *sprom;
 	unsigned long flags;
-	int i, err;
+	int err;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -91,55 +123,53 @@ static ssize_t bcm43xx_attr_sprom_show(s
 	bcm43xx_lock_mmio(bcm, flags);
 	assert(bcm->initialized);
 	err = bcm43xx_sprom_read(bcm, sprom);
-	if (!err) {
-		for (i = 0; i < BCM43xx_SPROM_SIZE; i++) {
-			buf[i * 2] = sprom[i] & 0x00FF;
-			buf[i * 2 + 1] = (sprom[i] & 0xFF00) >> 8;
-		}
-	}
+	if (!err)
+		err = sprom2hex(sprom, buf, PAGE_SIZE);
 	bcm43xx_unlock_mmio(bcm, flags);
 	kfree(sprom);
 
-	return err ? err : BCM43xx_SPROM_SIZE * sizeof(u16);
+	return err;
 }
 
 static ssize_t bcm43xx_attr_sprom_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	struct bcm43xx_private *bcm = devattr_to_bcm(attr, attr_sprom);
+	struct bcm43xx_private *bcm = dev_to_bcm(dev);
 	u16 *sprom;
 	unsigned long flags;
-	int i, err;
+	int err;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	if (count != BCM43xx_SPROM_SIZE * sizeof(u16))
-		return -EINVAL;
 	sprom = kmalloc(BCM43xx_SPROM_SIZE * sizeof(*sprom),
 			GFP_KERNEL);
 	if (!sprom)
 		return -ENOMEM;
-	for (i = 0; i < BCM43xx_SPROM_SIZE; i++) {
-		sprom[i] = buf[i * 2] & 0xFF;
-		sprom[i] |= ((u16)(buf[i * 2 + 1] & 0xFF)) << 8;
-	}
+	err = hex2sprom(sprom, buf, count);
+	if (err)
+		goto out_kfree;
 	bcm43xx_lock_mmio(bcm, flags);
 	assert(bcm->initialized);
 	err = bcm43xx_sprom_write(bcm, sprom);
 	bcm43xx_unlock_mmio(bcm, flags);
+out_kfree:
 	kfree(sprom);
 
 	return err ? err : count;
 
 }
 
+static DEVICE_ATTR(sprom, 0600,
+		   bcm43xx_attr_sprom_show,
+		   bcm43xx_attr_sprom_store);
+
 static ssize_t bcm43xx_attr_interfmode_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	struct bcm43xx_private *bcm = devattr_to_bcm(attr, attr_interfmode);
+	struct bcm43xx_private *bcm = dev_to_bcm(dev);
 	unsigned long flags;
 	int err;
 	ssize_t count = 0;
@@ -175,7 +205,7 @@ static ssize_t bcm43xx_attr_interfmode_s
 					     struct device_attribute *attr,
 					     const char *buf, size_t count)
 {
-	struct bcm43xx_private *bcm = devattr_to_bcm(attr, attr_interfmode);
+	struct bcm43xx_private *bcm = dev_to_bcm(dev);
 	unsigned long flags;
 	int err;
 	int mode;
@@ -215,11 +245,15 @@ static ssize_t bcm43xx_attr_interfmode_s
 	return err ? err : count;
 }
 
+static DEVICE_ATTR(interference, 0644,
+		   bcm43xx_attr_interfmode_show,
+		   bcm43xx_attr_interfmode_store);
+
 static ssize_t bcm43xx_attr_preamble_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct bcm43xx_private *bcm = devattr_to_bcm(attr, attr_preamble);
+	struct bcm43xx_private *bcm = dev_to_bcm(dev);
 	unsigned long flags;
 	int err;
 	ssize_t count;
@@ -245,7 +279,7 @@ static ssize_t bcm43xx_attr_preamble_sto
 					   struct device_attribute *attr,
 					   const char *buf, size_t count)
 {
-	struct bcm43xx_private *bcm = devattr_to_bcm(attr, attr_preamble);
+	struct bcm43xx_private *bcm = dev_to_bcm(dev);
 	unsigned long flags;
 	int err;
 	int value;
@@ -267,56 +301,41 @@ static ssize_t bcm43xx_attr_preamble_sto
 	return err ? err : count;
 }
 
+static DEVICE_ATTR(shortpreamble, 0644,
+		   bcm43xx_attr_preamble_show,
+		   bcm43xx_attr_preamble_store);
+
 int bcm43xx_sysfs_register(struct bcm43xx_private *bcm)
 {
 	struct device *dev = &bcm->pci_dev->dev;
-	struct bcm43xx_sysfs *sysfs = &bcm->sysfs;
 	int err;
 
 	assert(bcm->initialized);
 
-	sysfs->attr_sprom.attr.name = "sprom";
-	sysfs->attr_sprom.attr.owner = THIS_MODULE;
-	sysfs->attr_sprom.attr.mode = 0600;
-	sysfs->attr_sprom.show = bcm43xx_attr_sprom_show;
-	sysfs->attr_sprom.store = bcm43xx_attr_sprom_store;
-	err = device_create_file(dev, &sysfs->attr_sprom);
+	err = device_create_file(dev, &dev_attr_sprom);
 	if (err)
 		goto out;
-
-	sysfs->attr_interfmode.attr.name = "interference";
-	sysfs->attr_interfmode.attr.owner = THIS_MODULE;
-	sysfs->attr_interfmode.attr.mode = 0600;
-	sysfs->attr_interfmode.show = bcm43xx_attr_interfmode_show;
-	sysfs->attr_interfmode.store = bcm43xx_attr_interfmode_store;
-	err = device_create_file(dev, &sysfs->attr_interfmode);
+	err = device_create_file(dev, &dev_attr_interference);
 	if (err)
 		goto err_remove_sprom;
-
-	sysfs->attr_preamble.attr.name = "shortpreamble";
-	sysfs->attr_preamble.attr.owner = THIS_MODULE;
-	sysfs->attr_preamble.attr.mode = 0600;
-	sysfs->attr_preamble.show = bcm43xx_attr_preamble_show;
-	sysfs->attr_preamble.store = bcm43xx_attr_preamble_store;
-	err = device_create_file(dev, &sysfs->attr_preamble);
+	err = device_create_file(dev, &dev_attr_shortpreamble);
 	if (err)
 		goto err_remove_interfmode;
 
 out:
 	return err;
 err_remove_interfmode:
-	device_remove_file(dev, &sysfs->attr_interfmode);
+	device_remove_file(dev, &dev_attr_interference);
 err_remove_sprom:
-	device_remove_file(dev, &sysfs->attr_sprom);
+	device_remove_file(dev, &dev_attr_sprom);
 	goto out;
 }
 
 void bcm43xx_sysfs_unregister(struct bcm43xx_private *bcm)
 {
 	struct device *dev = &bcm->pci_dev->dev;
-	struct bcm43xx_sysfs *sysfs = &bcm->sysfs;
 
-	device_remove_file(dev, &sysfs->attr_preamble);
-	device_remove_file(dev, &sysfs->attr_interfmode);
-	device_remove_file(dev, &sysfs->attr_sprom);
+	device_remove_file(dev, &dev_attr_shortpreamble);
+	device_remove_file(dev, &dev_attr_interference);
+	device_remove_file(dev, &dev_attr_sprom);
 }
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h b/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h
index 57f1451..cc701df 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h
@@ -1,22 +1,6 @@
 #ifndef BCM43xx_SYSFS_H_
 #define BCM43xx_SYSFS_H_
 
-#include <linux/device.h>
-
-
-struct bcm43xx_sysfs {
-	struct device_attribute attr_sprom;
-	struct device_attribute attr_interfmode;
-	struct device_attribute attr_preamble;
-};
-
-#define devattr_to_bcm(attr, attr_name)	({				\
-	struct bcm43xx_sysfs *__s; struct bcm43xx_private *__p;		\
-	__s = container_of((attr), struct bcm43xx_sysfs, attr_name);	\
-	__p = container_of(__s, struct bcm43xx_private, sysfs);		\
-	__p;								\
-					})
-
 struct bcm43xx_private;
 
 int bcm43xx_sysfs_register(struct bcm43xx_private *bcm);
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_wx.c b/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
index 3daee82..3edbb48 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
@@ -962,22 +962,22 @@ static const struct iw_priv_args bcm43xx
 	{
 		.cmd		= PRIV_WX_SET_SHORTPREAMBLE,
 		.set_args	= IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
-		.name		= "set_shortpreambl",
+		.name		= "set_shortpreamb",
 	},
 	{
 		.cmd		= PRIV_WX_GET_SHORTPREAMBLE,
 		.get_args	= IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | MAX_WX_STRING,
-		.name		= "get_shortpreambl",
+		.name		= "get_shortpreamb",
 	},
 	{
 		.cmd		= PRIV_WX_SET_SWENCRYPTION,
 		.set_args	= IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
-		.name		= "set_swencryption",
+		.name		= "set_swencrypt",
 	},
 	{
 		.cmd		= PRIV_WX_GET_SWENCRYPTION,
 		.get_args	= IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | MAX_WX_STRING,
-		.name		= "get_swencryption",
+		.name		= "get_swencrypt",
 	},
 	{
 		.cmd		= PRIV_WX_SPROM_WRITE,
diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
index 8dfdfbd..06523e2 100644
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -390,7 +390,7 @@ static struct iw_statistics *orinoco_get
 		}
 	} else {
 		struct {
-			__le16 qual, signal, noise;
+			__le16 qual, signal, noise, unused;
 		} __attribute__ ((packed)) cq;
 
 		err = HERMES_READ_RECORD(hw, USER_BAP,
diff --git a/include/net/ieee80211softmac.h b/include/net/ieee80211softmac.h
index b971d8c..6b3693f 100644
--- a/include/net/ieee80211softmac.h
+++ b/include/net/ieee80211softmac.h
@@ -267,8 +267,9 @@ extern void ieee80211softmac_stop(struct
 #define IEEE80211SOFTMAC_EVENT_AUTH_FAILED		5
 #define IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT		6
 #define IEEE80211SOFTMAC_EVENT_ASSOCIATE_NET_NOT_FOUND	7
+#define IEEE80211SOFTMAC_EVENT_DISASSOCIATED		8
 /* keep this updated! */
-#define IEEE80211SOFTMAC_EVENT_LAST			7
+#define IEEE80211SOFTMAC_EVENT_LAST			8
 /*
  * If you want to be notified of certain events, you can call
  * ieee80211softmac_notify[_atomic] with
diff --git a/net/core/dev.c b/net/core/dev.c
index 83231a2..3bad1af 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2698,7 +2698,8 @@ int dev_ioctl(unsigned int cmd, void __u
 				/* If command is `set a parameter', or
 				 * `get the encoding parameters', check if
 				 * the user has the right to do it */
-				if (IW_IS_SET(cmd) || cmd == SIOCGIWENCODE) {
+				if (IW_IS_SET(cmd) || cmd == SIOCGIWENCODE
+				    || cmd == SIOCGIWENCODEEXT) {
 					if (!capable(CAP_NET_ADMIN))
 						return -EPERM;
 				}
diff --git a/net/core/wireless.c b/net/core/wireless.c
index 81d6995..d2bc72d 100644
--- a/net/core/wireless.c
+++ b/net/core/wireless.c
@@ -1726,6 +1726,14 @@ int wireless_rtnetlink_get(struct net_de
 	if(!IW_IS_GET(request->cmd))
 		return -EOPNOTSUPP;
 
+	/* If command is `get the encoding parameters', check if
+	 * the user has the right to do it */
+	if (request->cmd == SIOCGIWENCODE ||
+	    request->cmd == SIOCGIWENCODEEXT) {
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+	}
+
 	/* Special cases */
 	if(request->cmd == SIOCGIWSTATS)
 		/* Get Wireless Stats */
diff --git a/net/ieee80211/softmac/Kconfig b/net/ieee80211/softmac/Kconfig
index 6cd9f34..f2a27cc 100644
--- a/net/ieee80211/softmac/Kconfig
+++ b/net/ieee80211/softmac/Kconfig
@@ -1,6 +1,7 @@
 config IEEE80211_SOFTMAC
 	tristate "Software MAC add-on to the IEEE 802.11 networking stack"
 	depends on IEEE80211 && EXPERIMENTAL
+	select WIRELESS_EXT
 	---help---
 	This option enables the hardware independent software MAC addon
 	for the IEEE 802.11 networking stack.
diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index be61de7..4498023 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -101,6 +101,7 @@ ieee80211softmac_disassoc(struct ieee802
 	/* Do NOT clear bssvalid as that will break ieee80211softmac_assoc_work! */
 	mac->associated = 0;
 	mac->associnfo.associating = 0;
+	ieee80211softmac_call_events_locked(mac, IEEE80211SOFTMAC_EVENT_DISASSOCIATED, NULL);
 	spin_unlock_irqrestore(&mac->lock, flags);
 }
 
@@ -373,6 +374,7 @@ ieee80211softmac_handle_disassoc(struct 
 	spin_lock_irqsave(&mac->lock, flags);
 	mac->associnfo.bssvalid = 0;
 	mac->associated = 0;
+	ieee80211softmac_call_events_locked(mac, IEEE80211SOFTMAC_EVENT_DISASSOCIATED, NULL);
 	schedule_work(&mac->associnfo.work);
 	spin_unlock_irqrestore(&mac->lock, flags);
 	
@@ -391,6 +393,7 @@ ieee80211softmac_handle_reassoc_req(stru
 		dprintkl(KERN_INFO PFX "reassoc request from unknown network\n");
 		return 0;
 	}
-	ieee80211softmac_assoc(mac, network);
+	schedule_work(&mac->associnfo.work);
+
 	return 0;
 }
diff --git a/net/ieee80211/softmac/ieee80211softmac_event.c b/net/ieee80211/softmac/ieee80211softmac_event.c
index 0a52bbd..8cc8f3f 100644
--- a/net/ieee80211/softmac/ieee80211softmac_event.c
+++ b/net/ieee80211/softmac/ieee80211softmac_event.c
@@ -67,6 +67,7 @@ static char *event_descriptions[IEEE8021
 	"authenticating failed",
 	"authenticating timed out",
 	"associating failed because no suitable network was found",
+	"disassociated",
 };
 
 
@@ -128,13 +129,42 @@ void
 ieee80211softmac_call_events_locked(struct ieee80211softmac_device *mac, int event, void *event_ctx)
 {
 	struct ieee80211softmac_event *eventptr, *tmp;
-	union iwreq_data wrqu;
-	char *msg;
+	struct ieee80211softmac_network *network;
 	
 	if (event >= 0) {
-		msg = event_descriptions[event];
-		wrqu.data.length = strlen(msg);
-		wireless_send_event(mac->dev, IWEVCUSTOM, &wrqu, msg);
+		union iwreq_data wrqu;
+		int we_event;
+		char *msg = NULL;
+
+		switch(event) {
+		case IEEE80211SOFTMAC_EVENT_ASSOCIATED:
+			network = (struct ieee80211softmac_network *)event_ctx;
+			wrqu.data.length = 0;
+			wrqu.data.flags = 0;
+			memcpy(wrqu.ap_addr.sa_data, &network->bssid[0], ETH_ALEN);
+			wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+			we_event = SIOCGIWAP;
+			break;
+		case IEEE80211SOFTMAC_EVENT_DISASSOCIATED:
+			wrqu.data.length = 0;
+			wrqu.data.flags = 0;
+			memset(&wrqu, '\0', sizeof (union iwreq_data));
+			wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+			we_event = SIOCGIWAP;
+			break;
+		case IEEE80211SOFTMAC_EVENT_SCAN_FINISHED:
+			wrqu.data.length = 0;
+			wrqu.data.flags = 0;
+			memset(&wrqu, '\0', sizeof (union iwreq_data));
+			we_event = SIOCGIWSCAN;
+			break;
+		default:
+			msg = event_descriptions[event];
+			wrqu.data.length = strlen(msg);
+			we_event = IWEVCUSTOM;
+			break;
+		}
+		wireless_send_event(mac->dev, we_event, &wrqu, msg);
 	}
 
 	if (!list_empty(&mac->events))
diff --git a/net/ieee80211/softmac/ieee80211softmac_io.c b/net/ieee80211/softmac/ieee80211softmac_io.c
index febc51d..cc6cd56 100644
--- a/net/ieee80211/softmac/ieee80211softmac_io.c
+++ b/net/ieee80211/softmac/ieee80211softmac_io.c
@@ -180,9 +180,21 @@ ieee80211softmac_assoc_req(struct ieee80
 	ieee80211softmac_hdr_3addr(mac, &((*pkt)->header), IEEE80211_STYPE_ASSOC_REQ, net->bssid, net->bssid);
 
 	/* Fill in capability Info */
-	(*pkt)->capability = (mac->ieee->iw_mode == IW_MODE_MASTER) || (mac->ieee->iw_mode == IW_MODE_INFRA) ?
-		cpu_to_le16(WLAN_CAPABILITY_ESS) :
-		cpu_to_le16(WLAN_CAPABILITY_IBSS);
+	switch (mac->ieee->iw_mode) {
+	case IW_MODE_INFRA:
+		(*pkt)->capability = cpu_to_le16(WLAN_CAPABILITY_ESS);
+		break;
+	case IW_MODE_ADHOC:
+		(*pkt)->capability = cpu_to_le16(WLAN_CAPABILITY_IBSS);
+		break;
+	case IW_MODE_AUTO:
+		(*pkt)->capability = net->capabilities & (WLAN_CAPABILITY_ESS|WLAN_CAPABILITY_IBSS);
+		break;
+	default:
+		/* bleh. we don't ever go to these modes */
+		printk(KERN_ERR PFX "invalid iw_mode!\n");
+		break;
+	}
 	/* Need to add this
 	(*pkt)->capability |= mac->ieee->short_slot ? 
 			cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME) : 0;
diff --git a/net/ieee80211/softmac/ieee80211softmac_scan.c b/net/ieee80211/softmac/ieee80211softmac_scan.c
index bb9ab8b..2b9e7ed 100644
--- a/net/ieee80211/softmac/ieee80211softmac_scan.c
+++ b/net/ieee80211/softmac/ieee80211softmac_scan.c
@@ -47,6 +47,7 @@ ieee80211softmac_start_scan(struct ieee8
 	sm->scanning = 1;
 	spin_unlock_irqrestore(&sm->lock, flags);
 
+	netif_tx_disable(sm->ieee->dev);
 	ret = sm->start_scan(sm->dev);
 	if (ret) {
 		spin_lock_irqsave(&sm->lock, flags);
@@ -239,6 +240,7 @@ void ieee80211softmac_scan_finished(stru
 		if (net)
 			sm->set_channel(sm->dev, net->channel);
 	}
+	netif_wake_queue(sm->ieee->dev);
 	ieee80211softmac_call_events(sm, IEEE80211SOFTMAC_EVENT_SCAN_FINISHED, NULL);
 }
 EXPORT_SYMBOL_GPL(ieee80211softmac_scan_finished);
diff --git a/net/ieee80211/softmac/ieee80211softmac_wx.c b/net/ieee80211/softmac/ieee80211softmac_wx.c
index b559aa9..00f0d4f 100644
--- a/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ b/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -41,13 +41,23 @@ ieee80211softmac_wx_trigger_scan(struct 
 EXPORT_SYMBOL_GPL(ieee80211softmac_wx_trigger_scan);
 
 
+/* if we're still scanning, return -EAGAIN so that userspace tools
+ * can get the complete scan results, otherwise return 0. */
 int
 ieee80211softmac_wx_get_scan_results(struct net_device *net_dev,
 				     struct iw_request_info *info,
 				     union iwreq_data *data,
 				     char *extra)
 {
+	unsigned long flags;
 	struct ieee80211softmac_device *sm = ieee80211_priv(net_dev);
+
+	spin_lock_irqsave(&sm->lock, flags);
+	if (sm->scanning) {
+		spin_unlock_irqrestore(&sm->lock, flags);
+		return -EAGAIN;
+	}
+	spin_unlock_irqrestore(&sm->lock, flags);
 	return ieee80211_wx_get_scan(sm->ieee, info, data, extra);
 }
 EXPORT_SYMBOL_GPL(ieee80211softmac_wx_get_scan_results);
