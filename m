Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVLCM1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVLCM1W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVLCM1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:27:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61444 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751242AbVLCM1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:27:20 -0500
Date: Sat, 3 Dec 2005 13:27:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [-mm patch] remove code for WIRELESS_EXT < 18
Message-ID: <20051203122720.GF31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WIRELESS_EXT < 18 will never be true in the kernel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/ipw2100.c           |  434 ----------------------
 drivers/net/wireless/tiacx/acx_struct.h  |    5 
 drivers/net/wireless/tiacx/common.c      |    4 
 drivers/net/wireless/tiacx/conv.c        |    2 
 drivers/net/wireless/tiacx/ioctl.c       |  441 -----------------------
 drivers/net/wireless/tiacx/pci.c         |    8 
 drivers/net/wireless/tiacx/usb.c         |    6 
 drivers/net/wireless/tiacx/wlan.c        |    2 
 drivers/net/wireless/tiacx/wlan_compat.h |    9 
 9 files changed, 1 insertion(+), 910 deletions(-)

--- linux-2.6.15-rc3-mm1/drivers/net/wireless/ipw2100.c.old	2005-12-03 02:56:37.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/ipw2100.c	2005-12-03 02:58:09.000000000 +0100
@@ -5735,70 +5735,6 @@
 	return &priv->ieee->stats;
 }
 
-#if WIRELESS_EXT < 18
-/* Support for wpa_supplicant before WE-18, deprecated. */
-
-/* following definitions must match definitions in driver_ipw.c */
-
-#define IPW2100_IOCTL_WPA_SUPPLICANT		SIOCIWFIRSTPRIV+30
-
-#define IPW2100_CMD_SET_WPA_PARAM		1
-#define	IPW2100_CMD_SET_WPA_IE			2
-#define IPW2100_CMD_SET_ENCRYPTION		3
-#define IPW2100_CMD_MLME			4
-
-#define IPW2100_PARAM_WPA_ENABLED		1
-#define IPW2100_PARAM_TKIP_COUNTERMEASURES	2
-#define IPW2100_PARAM_DROP_UNENCRYPTED		3
-#define IPW2100_PARAM_PRIVACY_INVOKED		4
-#define IPW2100_PARAM_AUTH_ALGS			5
-#define IPW2100_PARAM_IEEE_802_1X		6
-
-#define IPW2100_MLME_STA_DEAUTH			1
-#define IPW2100_MLME_STA_DISASSOC		2
-
-#define IPW2100_CRYPT_ERR_UNKNOWN_ALG		2
-#define IPW2100_CRYPT_ERR_UNKNOWN_ADDR		3
-#define IPW2100_CRYPT_ERR_CRYPT_INIT_FAILED	4
-#define IPW2100_CRYPT_ERR_KEY_SET_FAILED	5
-#define IPW2100_CRYPT_ERR_TX_KEY_SET_FAILED	6
-#define IPW2100_CRYPT_ERR_CARD_CONF_FAILED	7
-
-#define	IPW2100_CRYPT_ALG_NAME_LEN		16
-
-struct ipw2100_param {
-	u32 cmd;
-	u8 sta_addr[ETH_ALEN];
-	union {
-		struct {
-			u8 name;
-			u32 value;
-		} wpa_param;
-		struct {
-			u32 len;
-			u8 reserved[32];
-			u8 data[0];
-		} wpa_ie;
-		struct {
-			u32 command;
-			u32 reason_code;
-		} mlme;
-		struct {
-			u8 alg[IPW2100_CRYPT_ALG_NAME_LEN];
-			u8 set_tx;
-			u32 err;
-			u8 idx;
-			u8 seq[8];	/* sequence counter (set: RX, get: TX) */
-			u16 key_len;
-			u8 key[0];
-		} crypt;
-
-	} u;
-};
-
-/* end of driver_ipw.c code */
-#endif				/* WIRELESS_EXT < 18 */
-
 static int ipw2100_wpa_enable(struct ipw2100_priv *priv, int value)
 {
 	/* This is called when wpa_supplicant loads and closes the driver
@@ -5807,11 +5743,6 @@
 	return 0;
 }
 
-#if WIRELESS_EXT < 18
-#define IW_AUTH_ALG_OPEN_SYSTEM			0x1
-#define IW_AUTH_ALG_SHARED_KEY			0x2
-#endif
-
 static int ipw2100_wpa_set_auth_algs(struct ipw2100_priv *priv, int value)
 {
 
@@ -5855,360 +5786,6 @@
 	ipw2100_set_wpa_ie(priv, &frame, 0);
 }
 
-#if WIRELESS_EXT < 18
-static int ipw2100_wpa_set_param(struct net_device *dev, u8 name, u32 value)
-{
-	struct ipw2100_priv *priv = ieee80211_priv(dev);
-	struct ieee80211_crypt_data *crypt;
-	unsigned long flags;
-	int ret = 0;
-
-	switch (name) {
-	case IPW2100_PARAM_WPA_ENABLED:
-		ret = ipw2100_wpa_enable(priv, value);
-		break;
-
-	case IPW2100_PARAM_TKIP_COUNTERMEASURES:
-		crypt = priv->ieee->crypt[priv->ieee->tx_keyidx];
-		if (!crypt || !crypt->ops->set_flags || !crypt->ops->get_flags)
-			break;
-
-		flags = crypt->ops->get_flags(crypt->priv);
-
-		if (value)
-			flags |= IEEE80211_CRYPTO_TKIP_COUNTERMEASURES;
-		else
-			flags &= ~IEEE80211_CRYPTO_TKIP_COUNTERMEASURES;
-
-		crypt->ops->set_flags(flags, crypt->priv);
-
-		break;
-
-	case IPW2100_PARAM_DROP_UNENCRYPTED:{
-			/* See IW_AUTH_DROP_UNENCRYPTED handling for details */
-			struct ieee80211_security sec = {
-				.flags = SEC_ENABLED,
-				.enabled = value,
-			};
-			priv->ieee->drop_unencrypted = value;
-			/* We only change SEC_LEVEL for open mode. Others
-			 * are set by ipw_wpa_set_encryption.
-			 */
-			if (!value) {
-				sec.flags |= SEC_LEVEL;
-				sec.level = SEC_LEVEL_0;
-			} else {
-				sec.flags |= SEC_LEVEL;
-				sec.level = SEC_LEVEL_1;
-			}
-			if (priv->ieee->set_security)
-				priv->ieee->set_security(priv->ieee->dev, &sec);
-			break;
-		}
-
-	case IPW2100_PARAM_PRIVACY_INVOKED:
-		priv->ieee->privacy_invoked = value;
-		break;
-
-	case IPW2100_PARAM_AUTH_ALGS:
-		ret = ipw2100_wpa_set_auth_algs(priv, value);
-		break;
-
-	case IPW2100_PARAM_IEEE_802_1X:
-		priv->ieee->ieee802_1x = value;
-		break;
-
-	default:
-		printk(KERN_ERR DRV_NAME ": %s: Unknown WPA param: %d\n",
-		       dev->name, name);
-		ret = -EOPNOTSUPP;
-	}
-
-	return ret;
-}
-
-static int ipw2100_wpa_mlme(struct net_device *dev, int command, int reason)
-{
-
-	struct ipw2100_priv *priv = ieee80211_priv(dev);
-	int ret = 0;
-
-	switch (command) {
-	case IPW2100_MLME_STA_DEAUTH:
-		// silently ignore
-		break;
-
-	case IPW2100_MLME_STA_DISASSOC:
-		ipw2100_disassociate_bssid(priv);
-		break;
-
-	default:
-		printk(KERN_ERR DRV_NAME ": %s: Unknown MLME request: %d\n",
-		       dev->name, command);
-		ret = -EOPNOTSUPP;
-	}
-
-	return ret;
-}
-
-static int ipw2100_wpa_set_wpa_ie(struct net_device *dev,
-				  struct ipw2100_param *param, int plen)
-{
-
-	struct ipw2100_priv *priv = ieee80211_priv(dev);
-	struct ieee80211_device *ieee = priv->ieee;
-	u8 *buf;
-
-	if (!ieee->wpa_enabled)
-		return -EOPNOTSUPP;
-
-	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
-	    (param->u.wpa_ie.len && param->u.wpa_ie.data == NULL))
-		return -EINVAL;
-
-	if (param->u.wpa_ie.len) {
-		buf = kmalloc(param->u.wpa_ie.len, GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
-
-		memcpy(buf, param->u.wpa_ie.data, param->u.wpa_ie.len);
-
-		kfree(ieee->wpa_ie);
-		ieee->wpa_ie = buf;
-		ieee->wpa_ie_len = param->u.wpa_ie.len;
-
-	} else {
-		kfree(ieee->wpa_ie);
-		ieee->wpa_ie = NULL;
-		ieee->wpa_ie_len = 0;
-	}
-
-	ipw2100_wpa_assoc_frame(priv, ieee->wpa_ie, ieee->wpa_ie_len);
-
-	return 0;
-}
-
-/* implementation borrowed from hostap driver */
-
-static int ipw2100_wpa_set_encryption(struct net_device *dev,
-				      struct ipw2100_param *param,
-				      int param_len)
-{
-	int ret = 0;
-	struct ipw2100_priv *priv = ieee80211_priv(dev);
-	struct ieee80211_device *ieee = priv->ieee;
-	struct ieee80211_crypto_ops *ops;
-	struct ieee80211_crypt_data **crypt;
-
-	struct ieee80211_security sec = {
-		.flags = 0,
-	};
-
-	param->u.crypt.err = 0;
-	param->u.crypt.alg[IPW2100_CRYPT_ALG_NAME_LEN - 1] = '\0';
-
-	if (param_len !=
-	    (int)((char *)param->u.crypt.key - (char *)param) +
-	    param->u.crypt.key_len) {
-		IPW_DEBUG_INFO("Len mismatch %d, %d\n", param_len,
-			       param->u.crypt.key_len);
-		return -EINVAL;
-	}
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		if (param->u.crypt.idx >= WEP_KEYS)
-			return -EINVAL;
-		crypt = &ieee->crypt[param->u.crypt.idx];
-	} else {
-		return -EINVAL;
-	}
-
-	sec.flags |= SEC_ENABLED | SEC_ENCRYPT;
-	if (strcmp(param->u.crypt.alg, "none") == 0) {
-		if (crypt) {
-			sec.enabled = 0;
-			sec.encrypt = 0;
-			sec.level = SEC_LEVEL_0;
-			sec.flags |= SEC_LEVEL;
-			ieee80211_crypt_delayed_deinit(ieee, crypt);
-		}
-		goto done;
-	}
-	sec.enabled = 1;
-	sec.encrypt = 1;
-
-	ops = ieee80211_get_crypto_ops(param->u.crypt.alg);
-	if (ops == NULL && strcmp(param->u.crypt.alg, "WEP") == 0) {
-		request_module("ieee80211_crypt_wep");
-		ops = ieee80211_get_crypto_ops(param->u.crypt.alg);
-	} else if (ops == NULL && strcmp(param->u.crypt.alg, "TKIP") == 0) {
-		request_module("ieee80211_crypt_tkip");
-		ops = ieee80211_get_crypto_ops(param->u.crypt.alg);
-	} else if (ops == NULL && strcmp(param->u.crypt.alg, "CCMP") == 0) {
-		request_module("ieee80211_crypt_ccmp");
-		ops = ieee80211_get_crypto_ops(param->u.crypt.alg);
-	}
-	if (ops == NULL) {
-		IPW_DEBUG_INFO("%s: unknown crypto alg '%s'\n",
-			       dev->name, param->u.crypt.alg);
-		param->u.crypt.err = IPW2100_CRYPT_ERR_UNKNOWN_ALG;
-		ret = -EINVAL;
-		goto done;
-	}
-
-	if (*crypt == NULL || (*crypt)->ops != ops) {
-		struct ieee80211_crypt_data *new_crypt;
-
-		ieee80211_crypt_delayed_deinit(ieee, crypt);
-
-		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data), GFP_KERNEL);
-		if (new_crypt == NULL) {
-			ret = -ENOMEM;
-			goto done;
-		}
-		new_crypt->ops = ops;
-		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
-			new_crypt->priv =
-			    new_crypt->ops->init(param->u.crypt.idx);
-
-		if (new_crypt->priv == NULL) {
-			kfree(new_crypt);
-			param->u.crypt.err =
-			    IPW2100_CRYPT_ERR_CRYPT_INIT_FAILED;
-			ret = -EINVAL;
-			goto done;
-		}
-
-		*crypt = new_crypt;
-	}
-
-	if (param->u.crypt.key_len > 0 && (*crypt)->ops->set_key &&
-	    (*crypt)->ops->set_key(param->u.crypt.key,
-				   param->u.crypt.key_len, param->u.crypt.seq,
-				   (*crypt)->priv) < 0) {
-		IPW_DEBUG_INFO("%s: key setting failed\n", dev->name);
-		param->u.crypt.err = IPW2100_CRYPT_ERR_KEY_SET_FAILED;
-		ret = -EINVAL;
-		goto done;
-	}
-
-	if (param->u.crypt.set_tx) {
-		ieee->tx_keyidx = param->u.crypt.idx;
-		sec.active_key = param->u.crypt.idx;
-		sec.flags |= SEC_ACTIVE_KEY;
-	}
-
-	if (ops->name != NULL) {
-
-		if (strcmp(ops->name, "WEP") == 0) {
-			memcpy(sec.keys[param->u.crypt.idx],
-			       param->u.crypt.key, param->u.crypt.key_len);
-			sec.key_sizes[param->u.crypt.idx] =
-			    param->u.crypt.key_len;
-			sec.flags |= (1 << param->u.crypt.idx);
-			sec.flags |= SEC_LEVEL;
-			sec.level = SEC_LEVEL_1;
-		} else if (strcmp(ops->name, "TKIP") == 0) {
-			sec.flags |= SEC_LEVEL;
-			sec.level = SEC_LEVEL_2;
-		} else if (strcmp(ops->name, "CCMP") == 0) {
-			sec.flags |= SEC_LEVEL;
-			sec.level = SEC_LEVEL_3;
-		}
-	}
-      done:
-	if (ieee->set_security)
-		ieee->set_security(ieee->dev, &sec);
-
-	/* Do not reset port if card is in Managed mode since resetting will
-	 * generate new IEEE 802.11 authentication which may end up in looping
-	 * with IEEE 802.1X.  If your hardware requires a reset after WEP
-	 * configuration (for example... Prism2), implement the reset_port in
-	 * the callbacks structures used to initialize the 802.11 stack. */
-	if (ieee->reset_on_keychange &&
-	    ieee->iw_mode != IW_MODE_INFRA &&
-	    ieee->reset_port && ieee->reset_port(dev)) {
-		IPW_DEBUG_INFO("%s: reset_port failed\n", dev->name);
-		param->u.crypt.err = IPW2100_CRYPT_ERR_CARD_CONF_FAILED;
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-static int ipw2100_wpa_supplicant(struct net_device *dev, struct iw_point *p)
-{
-
-	struct ipw2100_param *param;
-	int ret = 0;
-
-	IPW_DEBUG_IOCTL("wpa_supplicant: len=%d\n", p->length);
-
-	if (p->length < sizeof(struct ipw2100_param) || !p->pointer)
-		return -EINVAL;
-
-	param = (struct ipw2100_param *)kmalloc(p->length, GFP_KERNEL);
-	if (param == NULL)
-		return -ENOMEM;
-
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		return -EFAULT;
-	}
-
-	switch (param->cmd) {
-
-	case IPW2100_CMD_SET_WPA_PARAM:
-		ret = ipw2100_wpa_set_param(dev, param->u.wpa_param.name,
-					    param->u.wpa_param.value);
-		break;
-
-	case IPW2100_CMD_SET_WPA_IE:
-		ret = ipw2100_wpa_set_wpa_ie(dev, param, p->length);
-		break;
-
-	case IPW2100_CMD_SET_ENCRYPTION:
-		ret = ipw2100_wpa_set_encryption(dev, param, p->length);
-		break;
-
-	case IPW2100_CMD_MLME:
-		ret = ipw2100_wpa_mlme(dev, param->u.mlme.command,
-				       param->u.mlme.reason_code);
-		break;
-
-	default:
-		printk(KERN_ERR DRV_NAME
-		       ": %s: Unknown WPA supplicant request: %d\n", dev->name,
-		       param->cmd);
-		ret = -EOPNOTSUPP;
-
-	}
-
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
-
-	kfree(param);
-	return ret;
-}
-
-static int ipw2100_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct iwreq *wrq = (struct iwreq *)rq;
-	int ret = -1;
-	switch (cmd) {
-	case IPW2100_IOCTL_WPA_SUPPLICANT:
-		ret = ipw2100_wpa_supplicant(dev, &wrq->u.data);
-		return ret;
-
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return -EOPNOTSUPP;
-}
-#endif				/* WIRELESS_EXT < 18 */
-
 static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 				    struct ethtool_drvinfo *info)
 {
@@ -6337,9 +5914,6 @@
 	dev->open = ipw2100_open;
 	dev->stop = ipw2100_close;
 	dev->init = ipw2100_net_init;
-#if WIRELESS_EXT < 18
-	dev->do_ioctl = ipw2100_ioctl;
-#endif
 	dev->get_stats = ipw2100_stats;
 	dev->ethtool_ops = &ipw2100_ethtool_ops;
 	dev->tx_timeout = ipw2100_tx_timeout;
@@ -7852,7 +7426,6 @@
 	return 0;
 }
 
-#if WIRELESS_EXT > 17
 /*
  * WE-18 WPA support
  */
@@ -8114,7 +7687,6 @@
 	}
 	return 0;
 }
-#endif				/* WIRELESS_EXT > 17 */
 
 /*
  *
@@ -8347,11 +7919,7 @@
 	NULL,			/* SIOCWIWTHRSPY */
 	ipw2100_wx_set_wap,	/* SIOCSIWAP */
 	ipw2100_wx_get_wap,	/* SIOCGIWAP */
-#if WIRELESS_EXT > 17
 	ipw2100_wx_set_mlme,	/* SIOCSIWMLME */
-#else
-	NULL,			/* -- hole -- */
-#endif
 	NULL,			/* SIOCGIWAPLIST -- deprecated */
 	ipw2100_wx_set_scan,	/* SIOCSIWSCAN */
 	ipw2100_wx_get_scan,	/* SIOCGIWSCAN */
@@ -8375,7 +7943,6 @@
 	ipw2100_wx_get_encode,	/* SIOCGIWENCODE */
 	ipw2100_wx_set_power,	/* SIOCSIWPOWER */
 	ipw2100_wx_get_power,	/* SIOCGIWPOWER */
-#if WIRELESS_EXT > 17
 	NULL,			/* -- hole -- */
 	NULL,			/* -- hole -- */
 	ipw2100_wx_set_genie,	/* SIOCSIWGENIE */
@@ -8385,7 +7952,6 @@
 	ipw2100_wx_set_encodeext,	/* SIOCSIWENCODEEXT */
 	ipw2100_wx_get_encodeext,	/* SIOCGIWENCODEEXT */
 	NULL,			/* SIOCSIWPMKSA */
-#endif
 };
 
 #define IPW2100_PRIV_SET_MONITOR	SIOCIWFIRSTPRIV
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/acx_struct.h.old	2005-12-03 02:58:36.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/acx_struct.h	2005-12-03 02:59:36.000000000 +0100
@@ -1053,9 +1053,8 @@
 						 * the struct net_device. */
 	/*** Device statistics ***/
 	struct net_device_stats	stats;		/* net device statistics */
-#ifdef WIRELESS_EXT
 	struct iw_statistics	wstats;		/* wireless statistics */
-#endif
+
 	/*** Power managment ***/
 	struct pm_dev		*pm;		/* PM crap */
 
@@ -1103,9 +1102,7 @@
 	u8		scan_rate;
 	u16		scan_duration;
 	u16		scan_probe_delay;
-#if WIRELESS_EXT > 15
 	struct iw_spy_data	spy_data;	/* FIXME: needs to be implemented! */
-#endif
 
 	/*** Wireless network settings ***/
 	/* copy of the device address (ifconfig hw ether) that we actually use
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/common.c.old	2005-12-03 02:59:47.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/common.c	2005-12-03 03:00:04.000000000 +0100
@@ -46,9 +46,7 @@
 #include <linux/wireless.h>
 #include <linux/pm.h>
 #include <linux/vmalloc.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif /* WE >= 13 */
 
 #include "acx.h"
 
@@ -2707,7 +2705,6 @@
 	acxlog(L_ASSOC, "%s(%d):%s\n",
 	       __func__, new_status, acx_get_status_name(new_status));
 
-#if WIRELESS_EXT > 13 /* wireless_send_event() and SIOCGIWSCAN */
 	/* wireless_send_event never sleeps */
 	if (ACX_STATUS_4_ASSOCIATED == new_status) {
 		union iwreq_data wrqu;
@@ -2729,7 +2726,6 @@
 		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 		wireless_send_event(priv->netdev, SIOCGIWAP, &wrqu, NULL);
 	}
-#endif
 
 	priv->status = new_status;
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/conv.c.old	2005-12-03 03:00:17.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/conv.c	2005-12-03 03:00:26.000000000 +0100
@@ -36,9 +36,7 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 
 #include "acx.h"
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/ioctl.c.old	2005-12-03 03:00:37.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/ioctl.c	2005-12-03 03:02:07.000000000 +0100
@@ -39,9 +39,7 @@
 
 #include <linux/if_arp.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif /* WE >= 13 */
 
 #include "acx.h"
 
@@ -329,11 +327,9 @@
 	case IW_MODE_AUTO:
 		priv->mode = ACX_MODE_OFF;
 		break;
-#if WIRELESS_EXT > 14
 	case IW_MODE_MONITOR:
 		priv->mode = ACX_MODE_MONITOR;
 		break;
-#endif /* WIRELESS_EXT > 14 */
 	case IW_MODE_ADHOC:
 		priv->mode = ACX_MODE_0_ADHOC;
 		break;
@@ -381,10 +377,8 @@
 	switch (priv->mode) {
 	case ACX_MODE_OFF:
 		*uwrq = IW_MODE_AUTO; break;
-#if WIRELESS_EXT > 14
 	case ACX_MODE_MONITOR:
 		*uwrq = IW_MODE_MONITOR; break;
-#endif /* WIRELESS_EXT > 14 */
 	case ACX_MODE_0_ADHOC:
 		*uwrq = IW_MODE_ADHOC; break;
 	case ACX_MODE_2_STA:
@@ -616,7 +610,6 @@
 }
 
 
-#if WIRELESS_EXT > 13
 /***********************************************************************
 ** acx_s_scan_add_station
 */
@@ -778,7 +771,6 @@
 	FN_EXIT1(result);
 	return result;
 }
-#endif /* WIRELESS_EXT > 13 */
 
 
 /*----------------------------------------------------------------
@@ -1480,39 +1472,6 @@
 }
 
 
-/*================================================================*/
-/* Private functions						  */
-/*================================================================*/
-
-#if WIRELESS_EXT < 13
-/*----------------------------------------------------------------
-* acx_ioctl_get_iw_priv
-*
-* Comment: I added the monitor mode and changed the stuff below
-* to look more like the orinoco driver
-*----------------------------------------------------------------*/
-static int
-acx_ioctl_get_iw_priv(struct iwreq *iwr)
-{
-	int result = -EINVAL;
-
-	if (!iwr->u.data.pointer)
-		return -EINVAL;
-	result = verify_area(VERIFY_WRITE, iwr->u.data.pointer,
-			sizeof(acx_ioctl_private_args));
-	if (result)
-		return result;
-
-	iwr->u.data.length = VEC_SIZE(acx_ioctl_private_args);
-	if (copy_to_user(iwr->u.data.pointer,
-	    acx_ioctl_private_args, sizeof(acx_ioctl_private_args)) != 0)
-		result = -EFAULT;
-
-	return result;
-}
-#endif
-
-
 /*----------------------------------------------------------------
 * acx_ioctl_get_nick
 *----------------------------------------------------------------*/
@@ -2585,7 +2544,6 @@
 
 /***********************************************************************
 */
-#if WIRELESS_EXT >= 13
 static const iw_handler acx_ioctl_handler[] =
 {
 	(iw_handler) acx_ioctl_commit,		/* SIOCSIWCOMMIT */
@@ -2624,13 +2582,8 @@
 	(iw_handler) acx_ioctl_get_ap,		/* SIOCGIWAP */
 	(iw_handler) NULL,			/* [nothing] */
 	(iw_handler) acx_ioctl_get_aplist,	/* SIOCGIWAPLIST */
-#if WIRELESS_EXT > 13
 	(iw_handler) acx_ioctl_set_scan,	/* SIOCSIWSCAN */
 	(iw_handler) acx_ioctl_get_scan,	/* SIOCGIWSCAN */
-#else /* WE > 13 */
-	(iw_handler) NULL,			/* SIOCSIWSCAN */
-	(iw_handler) NULL,			/* SIOCGIWSCAN */
-#endif /* WE > 13 */
 	(iw_handler) acx_ioctl_set_essid,	/* SIOCSIWESSID */
 	(iw_handler) acx_ioctl_get_essid,	/* SIOCGIWESSID */
 	(iw_handler) acx_ioctl_set_nick,	/* SIOCSIWNICKN */
@@ -2694,397 +2647,3 @@
 	.private_args = (struct iw_priv_args *) acx_ioctl_private_args,
 };
 
-#endif /* WE >= 13 */
-
-
-#if WIRELESS_EXT < 13
-/*================================================================*/
-/* Main function						  */
-/*================================================================*/
-/*----------------------------------------------------------------
-* acx_e_ioctl_old
-*
-* Comment:
-* This is the *OLD* ioctl handler.
-* Make sure to not only place your additions here, but instead mainly
-* in the new one (acx_ioctl_handler[])!
-*----------------------------------------------------------------*/
-int
-acx_e_ioctl_old(netdevice_t *dev, struct ifreq *ifr, int cmd)
-{
-	wlandevice_t *priv = netdev_priv(dev);
-	int result = 0;
-	struct iwreq *iwr = (struct iwreq *)ifr;
-
-	acxlog(L_IOCTL, "%s cmd = 0x%04X\n", __func__, cmd);
-
-	/* This is the way it is done in the orinoco driver.
-	 * Check to see if device is present.
-	 */
-	if (0 == netif_device_present(dev)) {
-		return -ENODEV;
-	}
-
-	switch (cmd) {
-/* WE 13 and higher will use acx_ioctl_handler_def */
-	case SIOCGIWNAME:
-		/* get name == wireless protocol */
-		result = acx_ioctl_get_name(dev, NULL,
-					       (char *)&(iwr->u.name), NULL);
-		break;
-
-	case SIOCSIWNWID: /* pre-802.11, */
-	case SIOCGIWNWID: /* not supported. */
-		result = -EOPNOTSUPP;
-		break;
-
-	case SIOCSIWFREQ:
-		/* set channel/frequency (Hz)
-		   data can be frequency or channel :
-		   0-1000 = channel
-		   > 1000 = frequency in Hz */
-		result = acx_ioctl_set_freq(dev, NULL, &(iwr->u.freq), NULL);
-		break;
-
-	case SIOCGIWFREQ:
-		/* get channel/frequency (Hz) */
-		result = acx_ioctl_get_freq(dev, NULL, &(iwr->u.freq), NULL);
-		break;
-
-	case SIOCSIWMODE:
-		/* set operation mode */
-		result = acx_ioctl_set_mode(dev, NULL, &(iwr->u.mode), NULL);
-		break;
-
-	case SIOCGIWMODE:
-		/* get operation mode */
-		result = acx_ioctl_get_mode(dev, NULL, &(iwr->u.mode), NULL);
-		break;
-
-	case SIOCSIWSENS:
-		/* Set sensitivity */
-		result = acx_ioctl_set_sens(dev, NULL, &(iwr->u.sens), NULL);
-		break;
-
-	case SIOCGIWSENS:
-		/* Get sensitivity */
-		result = acx_ioctl_get_sens(dev, NULL, &(iwr->u.sens), NULL);
-		break;
-
-#if WIRELESS_EXT > 10
-	case SIOCGIWRANGE:
-		/* Get range of parameters */
-		{
-			struct iw_range range;
-			result = acx_ioctl_get_range(dev, NULL,
-					&(iwr->u.data), (char *)&range);
-			if (copy_to_user(iwr->u.data.pointer, &range,
-					 sizeof(struct iw_range)))
-				result = -EFAULT;
-		}
-		break;
-#endif
-
-	case SIOCGIWPRIV:
-		result = acx_ioctl_get_iw_priv(iwr);
-		break;
-
-	/* FIXME: */
-	/* case SIOCSIWSPY: */
-	/* case SIOCGIWSPY: */
-	/* case SIOCSIWTHRSPY: */
-	/* case SIOCGIWTHRSPY: */
-
-	case SIOCSIWAP:
-		/* set access point by MAC address */
-		result = acx_ioctl_set_ap(dev, NULL, &(iwr->u.ap_addr),
-					     NULL);
-		break;
-
-	case SIOCGIWAP:
-		/* get access point MAC address */
-		result = acx_ioctl_get_ap(dev, NULL, &(iwr->u.ap_addr),
-					     NULL);
-		break;
-
-	case SIOCGIWAPLIST:
-		/* get list of access points in range */
-		result = acx_ioctl_get_aplist(dev, NULL, &(iwr->u.data),
-						 NULL);
-		break;
-
-#if NOT_FINISHED_YET
-	/* FIXME: do proper interfacing to activate that! */
-	case SIOCSIWSCAN:
-		/* start a station scan */
-		result = acx_ioctl_set_scan(iwr, priv);
-		break;
-
-	case SIOCGIWSCAN:
-		/* get list of stations found during scan */
-		result = acx_ioctl_get_scan(iwr, priv);
-		break;
-#endif
-
-	case SIOCSIWESSID:
-		/* set ESSID (network name) */
-		{
-			char essid[IW_ESSID_MAX_SIZE+1];
-
-			if (iwr->u.essid.length > IW_ESSID_MAX_SIZE)
-			{
-				result = -E2BIG;
-				break;
-			}
-			if (copy_from_user(essid, iwr->u.essid.pointer,
-						iwr->u.essid.length))
-			{
-				result = -EFAULT;
-				break;
-			}
-			result = acx_ioctl_set_essid(dev, NULL,
-					&(iwr->u.essid), essid);
-		}
-		break;
-
-	case SIOCGIWESSID:
-		/* get ESSID */
-		{
-			char essid[IW_ESSID_MAX_SIZE+1];
-			if (iwr->u.essid.pointer)
-				result = acx_ioctl_get_essid(dev, NULL,
-					&(iwr->u.essid), essid);
-			if (copy_to_user(iwr->u.essid.pointer, essid,
-						iwr->u.essid.length))
-				result = -EFAULT;
-		}
-		break;
-
-	case SIOCSIWNICKN:
-		/* set nick */
-		{
-			char nick[IW_ESSID_MAX_SIZE+1];
-
-			if (iwr->u.data.length > IW_ESSID_MAX_SIZE)
-			{
-				result = -E2BIG;
-				break;
-			}
-			if (copy_from_user(nick, iwr->u.data.pointer,
-						iwr->u.data.length))
-			{
-				result = -EFAULT;
-				break;
-			}
-			result = acx_ioctl_set_nick(dev, NULL,
-					&(iwr->u.data), nick);
-		}
-		break;
-
-	case SIOCGIWNICKN:
-		/* get nick */
-		{
-			char nick[IW_ESSID_MAX_SIZE+1];
-			if (iwr->u.data.pointer)
-				result = acx_ioctl_get_nick(dev, NULL,
-						&(iwr->u.data), nick);
-			if (copy_to_user(iwr->u.data.pointer, nick,
-						iwr->u.data.length))
-				result = -EFAULT;
-		}
-		break;
-
-	case SIOCSIWRATE:
-		/* set default bit rate (bps) */
-		result = acx_ioctl_set_rate(dev, NULL, &(iwr->u.bitrate),
-					       NULL);
-		break;
-
-	case SIOCGIWRATE:
-		/* get default bit rate (bps) */
-		result = acx_ioctl_get_rate(dev, NULL, &(iwr->u.bitrate),
-					       NULL);
-		break;
-
-	case  SIOCSIWRTS:
-		/* set RTS threshold value */
-		result = acx_ioctl_set_rts(dev, NULL, &(iwr->u.rts), NULL);
-		break;
-	case  SIOCGIWRTS:
-		/* get RTS threshold value */
-		result = acx_ioctl_get_rts(dev, NULL,  &(iwr->u.rts), NULL);
-		break;
-
-	/* FIXME: */
-	/* case  SIOCSIWFRAG: */
-	/* case  SIOCGIWFRAG: */
-
-#if WIRELESS_EXT > 9
-	case SIOCGIWTXPOW:
-		/* get tx power */
-		result = acx_ioctl_get_txpow(dev, NULL, &(iwr->u.txpower),
-						NULL);
-		break;
-
-	case SIOCSIWTXPOW:
-		/* set tx power */
-		result = acx_ioctl_set_txpow(dev, NULL, &(iwr->u.txpower),
-						NULL);
-		break;
-#endif
-
-	case SIOCSIWRETRY:
-		result = acx_ioctl_set_retry(dev, NULL, &(iwr->u.retry), NULL);
-		break;
-
-	case SIOCGIWRETRY:
-		result = acx_ioctl_get_retry(dev, NULL, &(iwr->u.retry), NULL);
-		break;
-
-	case SIOCSIWENCODE:
-		{
-			/* set encoding token & mode */
-			u8 key[29];
-			if (iwr->u.encoding.pointer) {
-				if (iwr->u.encoding.length > 29) {
-					result = -E2BIG;
-					break;
-				}
-				if (copy_from_user(key, iwr->u.encoding.pointer,
-						iwr->u.encoding.length)) {
-					result = -EFAULT;
-					break;
-				}
-			}
-			else
-			if (iwr->u.encoding.length) {
-				result = -EINVAL;
-				break;
-			}
-			result = acx_ioctl_set_encode(dev, NULL,
-					&(iwr->u.encoding), key);
-		}
-		break;
-
-	case SIOCGIWENCODE:
-		{
-			/* get encoding token & mode */
-			u8 key[29];
-
-			result = acx_ioctl_get_encode(dev, NULL,
-					&(iwr->u.encoding), key);
-			if (iwr->u.encoding.pointer) {
-				if (copy_to_user(iwr->u.encoding.pointer,
-						key, iwr->u.encoding.length))
-					result = -EFAULT;
-			}
-		}
-		break;
-
-	/******************** iwpriv ioctls below ********************/
-#if ACX_DEBUG
-	case ACX100_IOCTL_DEBUG:
-		acx_ioctl_set_debug(dev, NULL, NULL, iwr->u.name);
-		break;
-#endif
-
-	case ACX100_IOCTL_SET_PLED:
-		acx100_ioctl_set_led_power(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_PLED:
-		acx100_ioctl_get_led_power(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_LIST_DOM:
-		acx_ioctl_list_reg_domain(dev, NULL, NULL, NULL);
-		break;
-
-	case ACX100_IOCTL_SET_DOM:
-		acx_ioctl_set_reg_domain(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_DOM:
-		acx_ioctl_get_reg_domain(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_SCAN_PARAMS:
-		acx_ioctl_set_scan_params(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_SCAN_PARAMS:
-		acx_ioctl_get_scan_params(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_PREAMB:
-		acx_ioctl_set_short_preamble(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_PREAMB:
-		acx_ioctl_get_short_preamble(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_ANT:
-		acx_ioctl_set_antenna(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_ANT:
-		acx_ioctl_get_antenna(dev, NULL, NULL, NULL);
-		break;
-
-	case ACX100_IOCTL_RX_ANT:
-		acx_ioctl_set_rx_antenna(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_TX_ANT:
-		acx_ioctl_set_tx_antenna(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_ED:
-		acx_ioctl_set_ed_threshold(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_CCA:
-		acx_ioctl_set_cca(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_MONITOR:	/* set sniff (monitor) mode */
-		acxlog(L_IOCTL, "%s: IWPRIV monitor\n", dev->name);
-
-		/* can only be done by admin */
-		if (!capable(CAP_NET_ADMIN)) {
-			result = -EPERM;
-			break;
-		}
-		result = acx_ioctl_wlansniff(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_TEST:
-		acx_ioctl_unknown11(dev, NULL, NULL, NULL);
-		break;
-
-	case ACX111_IOCTL_INFO:
-		acx111_ioctl_info(dev, NULL, NULL, NULL);
-		break;
-
-	default:
-		acxlog(L_IOCTL, "wireless ioctl 0x%04X queried "
-				"but not implemented yet\n", cmd);
-		result = -EOPNOTSUPP;
-		break;
-	}
-
-	if ((priv->dev_state_mask & ACX_STATE_IFACE_UP) && priv->set_mask) {
-		acx_sem_lock(priv);
-		acx_s_update_card_settings(priv, 0, 0);
-		acx_sem_unlock(priv);
-	}
-
-	/* older WEs don't have a commit handler,
-	 * so we need to fix return code in this case */
-	if (-EINPROGRESS == result)
-		result = 0;
-
-	return result;
-}
-#endif /* WE < 13 */
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/pci.c.old	2005-12-03 03:02:16.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/pci.c	2005-12-03 03:02:30.000000000 +0100
@@ -45,9 +45,7 @@
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 #include <linux/netdevice.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
@@ -1820,11 +1818,7 @@
 	dev->hard_start_xmit = &acx_i_start_xmit;
 	dev->get_stats = &acx_e_get_stats;
 	dev->get_wireless_stats = &acx_e_get_wireless_stats;
-#if WIRELESS_EXT >= 13
 	dev->wireless_handlers = (struct iw_handler_def *)&acx_ioctl_handler_def;
-#else
-	dev->do_ioctl = &acx_e_ioctl_old;
-#endif
 	dev->set_multicast_list = &acxpci_i_set_multicast_list;
 	dev->tx_timeout = &acxpci_i_tx_timeout;
 	dev->change_mtu = &acx_e_change_mtu;
@@ -3842,7 +3836,6 @@
 		r100 = txdesc->u.r1.rate;
 		r111 = txdesc->u.r2.rate111;
 
-#if WIRELESS_EXT > 13 /* wireless_send_event() and IWEVTXDROP are WE13 */
 		/* need to check for certain error conditions before we
 		 * clean the descriptor: we still need valid descr data here */
 		if (unlikely(0x30 & error)) {
@@ -3857,7 +3850,6 @@
 			MAC_COPY(wrqu.addr.sa_data, hdr->a1);
 			wireless_send_event(priv->netdev, IWEVTXDROP, &wrqu, NULL);
 		}
-#endif
 		/* ...and free the desc */
 		txdesc->error = 0;
 		txdesc->ack_failures = 0;
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/usb.c.old	2005-12-03 03:02:40.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/usb.c	2005-12-03 03:02:49.000000000 +0100
@@ -61,9 +61,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 #include <linux/vmalloc.h>
 
 #include "acx.h"
@@ -871,11 +869,7 @@
 	dev->hard_start_xmit = (void *)&acx_i_start_xmit;
 	dev->get_stats = (void *)&acx_e_get_stats;
 	dev->get_wireless_stats = (void *)&acx_e_get_wireless_stats;
-#if WIRELESS_EXT >= 13
 	dev->wireless_handlers = (struct iw_handler_def *)&acx_ioctl_handler_def;
-#else
-	dev->do_ioctl = (void *)&acx_e_ioctl_old;
-#endif
 	dev->set_multicast_list = (void *)&acx100usb_i_set_rx_mode;
 #ifdef HAVE_TX_TIMEOUT
 	dev->tx_timeout = &acx100usb_i_tx_timeout;
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan.c.old	2005-12-03 03:02:58.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan.c	2005-12-03 03:03:02.000000000 +0100
@@ -43,9 +43,7 @@
 #include <linux/types.h>
 #include <linux/if_arp.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 
 #include "acx.h"
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan_compat.h.old	2005-12-03 03:03:11.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan_compat.h	2005-12-03 03:03:19.000000000 +0100
@@ -228,15 +228,6 @@
  typedef struct net_device netdevice_t;
 #endif
 
-#ifdef WIRELESS_EXT
-#if (WIRELESS_EXT < 13)
-struct iw_request_info {
-	__u16 cmd;		/* Wireless Extension command */
-	__u16 flags;		/* More to come ;-) */
-};
-#endif
-#endif
-
 /* Interrupt handler backwards compatibility stuff */
 #ifndef IRQ_NONE
 #define IRQ_NONE

