Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWANPUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWANPUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWANPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:20:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62470 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751767AbWANPUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:20:54 -0500
Date: Sat, 14 Jan 2006 16:20:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: yi.zhu@intel.com, jketreno@linux.intel.com
Cc: "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/ipw2100.c: remove code for WIRELESS_EXT < 18
Message-ID: <20060114152053.GL29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WIRELESS_EXT < 18 will never be true in the kernel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/ipw2100.c |  434 ---------------------------------
 1 file changed, 434 deletions(-)

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

