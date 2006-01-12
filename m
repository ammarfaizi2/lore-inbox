Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWALWNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWALWNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWALWNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:13:33 -0500
Received: from havoc.gtf.org ([69.61.125.42]:61927 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964793AbWALWNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:13:31 -0500
Date: Thu, 12 Jan 2006 17:13:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20060112221322.GA25470@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/bonding/bond_alb.c |    4 
 drivers/net/bonding/bonding.h  |    4 
 drivers/net/e100.c             |   32 +++++
 drivers/net/gianfar.c          |    6 -
 drivers/net/gianfar_mii.c      |    5 
 drivers/net/phy/mdio_bus.c     |    2 
 drivers/net/phy/phy.c          |    2 
 drivers/net/tulip/uli526x.c    |    6 -
 drivers/net/via-velocity.c     |    2 
 drivers/net/wireless/Kconfig   |    2 
 drivers/net/wireless/atmel.c   |  227 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl_devices.h    |    6 -
 include/linux/phy.h            |    3 
 include/net/ieee80211.h        |    6 -
 14 files changed, 281 insertions(+), 26 deletions(-)

Dan Williams:
      wireless/atmel: add IWENCODEEXT, IWAUTH, and association event support

dann frazier:
      CONFIG_AIRO needs CONFIG_CRYPTO

Eric Sesterhenn / snakebyte:
      replace MODULE_PARM in tulip/uli526x.c

Jay Vosburgh:
      bonding: UPDATED hash-table corruption in bond_alb.c

Johannes Berg:
      fix wrong comments in ieee80211.h

John W. Linville:
      via-velocity: use NETIF_F_IP_CSUM (hardware only support IPv4)

Kumar Gala:
      gfar: fix compile error
      gianfar mii: Use proper resource for MII memory region
      phy: Added a macro to represent the string format used to match a phy device
      gianfar: Use new PHY_ID_FMT macro

ODonnell, Michael:
      corruption during e100 MDI register access

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 854ddfb..f2a6318 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -169,9 +169,9 @@ static void tlb_clear_slave(struct bondi
 		index = next_index;
 	}
 
-	_unlock_tx_hashtbl(bond);
-
 	tlb_init_slave(slave);
+
+	_unlock_tx_hashtbl(bond);
 }
 
 /* Must be called before starting the monitor timer */
diff --git a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
index f20bb85..3dd78d0 100644
--- a/drivers/net/bonding/bonding.h
+++ b/drivers/net/bonding/bonding.h
@@ -22,8 +22,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
-#define DRV_VERSION	"3.0.0"
-#define DRV_RELDATE	"November 8, 2005"
+#define DRV_VERSION	"3.0.1"
+#define DRV_RELDATE	"January 9, 2006"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 22cd045..23de226 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -132,6 +132,10 @@
  * 	TODO:
  * 	o several entry points race with dev->close
  * 	o check for tx-no-resources/stop Q races with tx clean/wake Q
+ *
+ *	FIXES:
+ * 2005/12/02 - Michael O'Donnell <Michael.ODonnell at stratus dot com>
+ *	- Stratus87247: protect MDI control register manipulations
  */
 
 #include <linux/config.h>
@@ -578,6 +582,7 @@ struct nic {
 	u16 leds;
 	u16 eeprom_wc;
 	u16 eeprom[256];
+	spinlock_t mdio_lock;
 };
 
 static inline void e100_write_flush(struct nic *nic)
@@ -876,15 +881,35 @@ static u16 mdio_ctrl(struct nic *nic, u3
 {
 	u32 data_out = 0;
 	unsigned int i;
+	unsigned long flags;
+
 
+	/*
+	 * Stratus87247: we shouldn't be writing the MDI control
+	 * register until the Ready bit shows True.  Also, since
+	 * manipulation of the MDI control registers is a multi-step
+	 * procedure it should be done under lock.
+	 */
+	spin_lock_irqsave(&nic->mdio_lock, flags);
+	for (i = 100; i; --i) {
+		if (readl(&nic->csr->mdi_ctrl) & mdi_ready)
+			break;
+		udelay(20);
+	}
+	if (unlikely(!i)) {
+		printk("e100.mdio_ctrl(%s) won't go Ready\n",
+			nic->netdev->name );
+		spin_unlock_irqrestore(&nic->mdio_lock, flags);
+		return 0;		/* No way to indicate timeout error */
+	}
 	writel((reg << 16) | (addr << 21) | dir | data, &nic->csr->mdi_ctrl);
 
-	for(i = 0; i < 100; i++) {
+	for (i = 0; i < 100; i++) {
 		udelay(20);
-		if((data_out = readl(&nic->csr->mdi_ctrl)) & mdi_ready)
+		if ((data_out = readl(&nic->csr->mdi_ctrl)) & mdi_ready)
 			break;
 	}
-
+	spin_unlock_irqrestore(&nic->mdio_lock, flags);
 	DPRINTK(HW, DEBUG,
 		"%s:addr=%d, reg=%d, data_in=0x%04X, data_out=0x%04X\n",
 		dir == mdi_read ? "READ" : "WRITE", addr, reg, data, data_out);
@@ -2562,6 +2587,7 @@ static int __devinit e100_probe(struct p
 	/* locks must be initialized before calling hw_reset */
 	spin_lock_init(&nic->cb_lock);
 	spin_lock_init(&nic->cmd_lock);
+	spin_lock_init(&nic->mdio_lock);
 
 	/* Reset the device before pci_set_master() in case device is in some
 	 * funky state and has an interrupt pending - hint: we don't have the
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 146f951..0c18dbd 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -84,6 +84,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <linux/in.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -398,12 +399,15 @@ static int init_phy(struct net_device *d
 		priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT ?
 		SUPPORTED_1000baseT_Full : 0;
 	struct phy_device *phydev;
+	char phy_id[BUS_ID_SIZE];
 
 	priv->oldlink = 0;
 	priv->oldspeed = 0;
 	priv->oldduplex = -1;
 
-	phydev = phy_connect(dev, priv->einfo->bus_id, &adjust_link, 0);
+	snprintf(phy_id, BUS_ID_SIZE, PHY_ID_FMT, priv->einfo->bus_id, priv->einfo->phy_id);
+
+	phydev = phy_connect(dev, phy_id, &adjust_link, 0);
 
 	if (IS_ERR(phydev)) {
 		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index 04a462c..74e52fc 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -128,6 +128,7 @@ int gfar_mdio_probe(struct device *dev)
 	struct gianfar_mdio_data *pdata;
 	struct gfar_mii *regs;
 	struct mii_bus *new_bus;
+	struct resource *r;
 	int err = 0;
 
 	if (NULL == dev)
@@ -151,8 +152,10 @@ int gfar_mdio_probe(struct device *dev)
 		return -ENODEV;
 	}
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
 	/* Set the PHY base address */
-	regs = (struct gfar_mii *) ioremap(pdata->paddr, 
+	regs = (struct gfar_mii *) ioremap(r->start,
 			sizeof (struct gfar_mii));
 
 	if (NULL == regs) {
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 02940c0..459443b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -81,7 +81,7 @@ int mdiobus_register(struct mii_bus *bus
 
 			phydev->dev.parent = bus->dev;
 			phydev->dev.bus = &mdio_bus_type;
-			sprintf(phydev->dev.bus_id, "phy%d:%d", bus->id, i);
+			snprintf(phydev->dev.bus_id, BUS_ID_SIZE, PHY_ID_FMT, bus->id, i);
 
 			phydev->bus = bus;
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b8686e4..1474b7c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -42,7 +42,7 @@
  */
 void phy_print_status(struct phy_device *phydev)
 {
-	pr_info("%s: Link is %s", phydev->dev.bus_id,
+	pr_info("PHY: %s - Link is %s", phydev->dev.bus_id,
 			phydev->link ? "Up" : "Down");
 	if (phydev->link)
 		printk(" - %d/%s", phydev->speed,
diff --git a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
index 1a43163..9839816 100644
--- a/drivers/net/tulip/uli526x.c
+++ b/drivers/net/tulip/uli526x.c
@@ -1689,9 +1689,9 @@ MODULE_AUTHOR("Peer Chen, peer.chen@uli.
 MODULE_DESCRIPTION("ULi M5261/M5263 fast ethernet driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(debug, "i");
-MODULE_PARM(mode, "i");
-MODULE_PARM(cr6set, "i");
+module_param(debug, int, 0644);
+module_param(mode, int, 0);
+module_param(cr6set, int, 0);
 MODULE_PARM_DESC(debug, "ULi M5261/M5263 enable debugging (0-1)");
 MODULE_PARM_DESC(mode, "ULi M5261/M5263: Bit 0: 10/100Mbps, bit 2: duplex, bit 8: HomePNA");
 
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index 82c6b75..c2d5907 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -791,7 +791,7 @@ static int __devinit velocity_found1(str
 #endif
 
 	if (vptr->flags & VELOCITY_FLAGS_TX_CSUM) {
-		dev->features |= NETIF_F_HW_CSUM;
+		dev->features |= NETIF_F_IP_CSUM;
 	}
 
 	ret = register_netdev(dev);
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 24f7967..c1a6e69 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -243,7 +243,7 @@ config IPW2200_DEBUG
 
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
-	depends on NET_RADIO && ISA_DMA_API && (PCI || BROKEN)
+	depends on NET_RADIO && ISA_DMA_API && CRYPTO && (PCI || BROKEN)
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet ISA and
 	  PCI 802.11 wireless cards.
diff --git a/drivers/net/wireless/atmel.c b/drivers/net/wireless/atmel.c
index e4729dd..f0ccfef 100644
--- a/drivers/net/wireless/atmel.c
+++ b/drivers/net/wireless/atmel.c
@@ -1407,6 +1407,17 @@ static int atmel_close(struct net_device
 {
 	struct atmel_private *priv = netdev_priv(dev);
 
+	/* Send event to userspace that we are disassociating */
+	if (priv->station_state == STATION_STATE_READY) {
+		union iwreq_data wrqu;
+
+		wrqu.data.length = 0;
+		wrqu.data.flags = 0;
+		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+		memset(wrqu.ap_addr.sa_data, 0, ETH_ALEN);
+		wireless_send_event(priv->dev, SIOCGIWAP, &wrqu, NULL);
+	}
+
 	atmel_enter_state(priv, STATION_STATE_DOWN);
 
 	if (priv->bus_type == BUS_TYPE_PCCARD)
@@ -1780,10 +1791,10 @@ static int atmel_set_encode(struct net_d
 			priv->wep_is_on = 1;
 			priv->exclude_unencrypted = 1;
 			if (priv->wep_key_len[index] > 5) {
-				priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_64;
+				priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_128;
 				priv->encryption_level = 2;
 			} else {
-				priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_128;
+				priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_64;
 				priv->encryption_level = 1;
 			}
 		}
@@ -1853,6 +1864,181 @@ static int atmel_get_encode(struct net_d
 	return 0;
 }
 
+static int atmel_set_encodeext(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	struct atmel_private *priv = netdev_priv(dev);
+	struct iw_point *encoding = &wrqu->encoding;
+	struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
+	int idx, key_len;
+
+	/* Determine and validate the key index */
+	idx = encoding->flags & IW_ENCODE_INDEX;
+	if (idx) {
+		if (idx < 1 || idx > WEP_KEYS)
+			return -EINVAL;
+		idx--;
+	} else
+		idx = priv->default_key;
+
+	if ((encoding->flags & IW_ENCODE_DISABLED) ||
+	    ext->alg == IW_ENCODE_ALG_NONE) {
+		priv->wep_is_on = 0;
+		priv->encryption_level = 0;
+		priv->pairwise_cipher_suite = CIPHER_SUITE_NONE;
+	}
+
+	if (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
+		priv->default_key = idx;
+
+	/* Set the requested key */
+	switch (ext->alg) {
+	case IW_ENCODE_ALG_NONE:
+		break;
+	case IW_ENCODE_ALG_WEP:
+		if (ext->key_len > 5) {
+			priv->wep_key_len[idx] = 13;
+			priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_128;
+			priv->encryption_level = 2;
+		} else if (ext->key_len > 0) {
+			priv->wep_key_len[idx] = 5;
+			priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_64;
+			priv->encryption_level = 1;
+		} else {
+			return -EINVAL;
+		}
+		priv->wep_is_on = 1;
+		memset(priv->wep_keys[idx], 0, 13);
+		key_len = min ((int)ext->key_len, priv->wep_key_len[idx]);
+		memcpy(priv->wep_keys[idx], ext->key, key_len);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINPROGRESS;
+}
+
+static int atmel_get_encodeext(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	struct atmel_private *priv = netdev_priv(dev);
+	struct iw_point *encoding = &wrqu->encoding;
+	struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
+	int idx, max_key_len;
+
+	max_key_len = encoding->length - sizeof(*ext);
+	if (max_key_len < 0)
+		return -EINVAL;
+
+	idx = encoding->flags & IW_ENCODE_INDEX;
+	if (idx) {
+		if (idx < 1 || idx > WEP_KEYS)
+			return -EINVAL;
+		idx--;
+	} else
+		idx = priv->default_key;
+
+	encoding->flags = idx + 1;
+	memset(ext, 0, sizeof(*ext));
+	
+	if (!priv->wep_is_on) {
+		ext->alg = IW_ENCODE_ALG_NONE;
+		ext->key_len = 0;
+		encoding->flags |= IW_ENCODE_DISABLED;
+	} else {
+		if (priv->encryption_level > 0)
+			ext->alg = IW_ENCODE_ALG_WEP;
+		else
+			return -EINVAL;
+
+		ext->key_len = priv->wep_key_len[idx];
+		memcpy(ext->key, priv->wep_keys[idx], ext->key_len);
+		encoding->flags |= IW_ENCODE_ENABLED;
+	}
+
+	return 0;
+}
+
+static int atmel_set_auth(struct net_device *dev,
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu, char *extra)
+{
+	struct atmel_private *priv = netdev_priv(dev);
+	struct iw_param *param = &wrqu->param;
+
+	switch (param->flags & IW_AUTH_INDEX) {
+	case IW_AUTH_WPA_VERSION:
+	case IW_AUTH_CIPHER_PAIRWISE:
+	case IW_AUTH_CIPHER_GROUP:
+	case IW_AUTH_KEY_MGMT:
+	case IW_AUTH_RX_UNENCRYPTED_EAPOL:
+	case IW_AUTH_PRIVACY_INVOKED:
+		/*
+		 * atmel does not use these parameters
+		 */
+		break;
+
+	case IW_AUTH_DROP_UNENCRYPTED:
+		priv->exclude_unencrypted = param->value ? 1 : 0;
+		break;
+
+	case IW_AUTH_80211_AUTH_ALG: {
+			if (param->value & IW_AUTH_ALG_SHARED_KEY) {
+				priv->exclude_unencrypted = 1;
+			} else if (param->value & IW_AUTH_ALG_OPEN_SYSTEM) {
+				priv->exclude_unencrypted = 0;
+			} else
+				return -EINVAL;
+			break;
+		}
+
+	case IW_AUTH_WPA_ENABLED:
+		/* Silently accept disable of WPA */
+		if (param->value > 0)
+			return -EOPNOTSUPP;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+	return -EINPROGRESS;
+}
+
+static int atmel_get_auth(struct net_device *dev,
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu, char *extra)
+{
+	struct atmel_private *priv = netdev_priv(dev);
+	struct iw_param *param = &wrqu->param;
+
+	switch (param->flags & IW_AUTH_INDEX) {
+	case IW_AUTH_DROP_UNENCRYPTED:
+		param->value = priv->exclude_unencrypted;
+		break;
+
+	case IW_AUTH_80211_AUTH_ALG:
+		if (priv->exclude_unencrypted == 1)
+			param->value = IW_AUTH_ALG_SHARED_KEY;
+		else
+			param->value = IW_AUTH_ALG_OPEN_SYSTEM;
+		break;
+
+	case IW_AUTH_WPA_ENABLED:
+		param->value = 0;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+
 static int atmel_get_name(struct net_device *dev,
 			  struct iw_request_info *info,
 			  char *cwrq,
@@ -2289,13 +2475,15 @@ static int atmel_set_wap(struct net_devi
 {
 	struct atmel_private *priv = netdev_priv(dev);
 	int i;
-	static const u8 bcast[] = { 255, 255, 255, 255, 255, 255 };
+	static const u8 any[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
+	static const u8 off[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	unsigned long flags;
 
 	if (awrq->sa_family != ARPHRD_ETHER)
 		return -EINVAL;
 
-	if (memcmp(bcast, awrq->sa_data, 6) == 0) {
+	if (!memcmp(any, awrq->sa_data, 6) ||
+	    !memcmp(off, awrq->sa_data, 6)) {
 		del_timer_sync(&priv->management_timer);
 		spin_lock_irqsave(&priv->irqlock, flags);
 		atmel_scan(priv, 1);
@@ -2378,6 +2566,15 @@ static const iw_handler atmel_handler[] 
 	(iw_handler) atmel_get_encode,		/* SIOCGIWENCODE */
 	(iw_handler) atmel_set_power,		/* SIOCSIWPOWER */
 	(iw_handler) atmel_get_power,		/* SIOCGIWPOWER */
+	(iw_handler) NULL,			/* -- hole -- */
+	(iw_handler) NULL,			/* -- hole -- */
+	(iw_handler) NULL,			/* SIOCSIWGENIE */
+	(iw_handler) NULL,			/* SIOCGIWGENIE */
+	(iw_handler) atmel_set_auth,		/* SIOCSIWAUTH */
+	(iw_handler) atmel_get_auth,		/* SIOCGIWAUTH */
+	(iw_handler) atmel_set_encodeext,	/* SIOCSIWENCODEEXT */
+	(iw_handler) atmel_get_encodeext,	/* SIOCGIWENCODEEXT */
+	(iw_handler) NULL,			/* SIOCSIWPMKSA */
 };
 
 static const iw_handler atmel_private_handler[] =
@@ -2924,6 +3121,8 @@ static void associate(struct atmel_priva
 	u16 ass_id = le16_to_cpu(ass_resp->ass_id);
 	u16 rates_len = ass_resp->length > 4 ? 4 : ass_resp->length;
 
+	union iwreq_data wrqu;
+
 	if (frame_len < 8 + rates_len)
 		return;
 
@@ -2954,6 +3153,14 @@ static void associate(struct atmel_priva
 		priv->station_is_associated = 1;
 		priv->station_was_associated = 1;
 		atmel_enter_state(priv, STATION_STATE_READY);
+
+		/* Send association event to userspace */
+		wrqu.data.length = 0;
+		wrqu.data.flags = 0;
+		memcpy(wrqu.ap_addr.sa_data, priv->CurrentBSSID, ETH_ALEN);
+		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+		wireless_send_event(priv->dev, SIOCGIWAP, &wrqu, NULL);
+
 		return;
 	}
 
@@ -3632,6 +3839,7 @@ static int reset_atmel_card(struct net_d
 
 	struct atmel_private *priv = netdev_priv(dev);
 	u8 configuration;
+	int old_state = priv->station_state;
 
 	/* data to add to the firmware names, in priority order
 	   this implemenents firmware versioning */
@@ -3792,6 +4000,17 @@ static int reset_atmel_card(struct net_d
 	else
 		build_wep_mib(priv);
 
+	if (old_state == STATION_STATE_READY)
+	{
+		union iwreq_data wrqu;
+
+		wrqu.data.length = 0;
+		wrqu.data.flags = 0;
+		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+		memset(wrqu.ap_addr.sa_data, 0, ETH_ALEN);
+		wireless_send_event(priv->dev, SIOCGIWAP, &wrqu, NULL);
+	}
+
 	return 1;
 }
 
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 934aa9b..a9f1cfd 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -50,14 +50,12 @@ struct gianfar_platform_data {
 
 	/* board specific information */
 	u32 board_flags;
-	const char *bus_id;
+	u32 bus_id;
+	u32 phy_id;
 	u8 mac_addr[6];
 };
 
 struct gianfar_mdio_data {
-	/* device specific information */
-	u32 paddr;
-
 	/* board specific information */
 	int irq[32];
 };
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 92a9696..331521a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -53,6 +53,9 @@
 
 #define PHY_MAX_ADDR 32
 
+/* Used when trying to connect to a specific phy (mii bus id:phy device id) */
+#define PHY_ID_FMT "%x:%02x"
+
 /* The Bus class for PHYs.  Devices which provide access to
  * PHYs should register using this structure */
 struct mii_bus {
diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
index cde2f4f..df05f46 100644
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -363,8 +363,9 @@ enum ieee80211_reasoncode {
 #define IEEE80211_OFDM_SHIFT_MASK_A         4
 
 /* NOTE: This data is for statistical purposes; not all hardware provides this
- *       information for frames received.  Not setting these will not cause
- *       any adverse affects. */
+ *       information for frames received.
+ *       For ieee80211_rx_mgt, you need to set at least the 'len' parameter.
+ */
 struct ieee80211_rx_stats {
 	u32 mac_time;
 	s8 rssi;
@@ -1088,6 +1089,7 @@ extern int ieee80211_tx_frame(struct iee
 /* ieee80211_rx.c */
 extern int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 			struct ieee80211_rx_stats *rx_stats);
+/* make sure to set stats->len */
 extern void ieee80211_rx_mgt(struct ieee80211_device *ieee,
 			     struct ieee80211_hdr_4addr *header,
 			     struct ieee80211_rx_stats *stats);
