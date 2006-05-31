Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWEaCrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWEaCrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 22:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWEaCrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 22:47:03 -0400
Received: from sccrmhc12.comcast.net ([204.127.200.82]:22436 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751414AbWEaCrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 22:47:02 -0400
Date: Tue, 30 May 2006 21:46:55 -0500
From: Corey Minyard <minyard@acm.org>
To: Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] orinoco: Add ioctls so wpa_supplicant will work.
Message-ID: <20060531024655.GA25281@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some ioctls to the orinoco driver so wpa_supplicant will work on
this driver.  These ioctls don't do much on this driver, but
wpa_supplicant won't work without them and it sets the future for
WPA support.  Maybe later, if I get a access point that supports it.

Index: linux-source-2.6.16/drivers/net/wireless/orinoco.c
===================================================================
--- linux-source-2.6.16.orig/drivers/net/wireless/orinoco.c	2006-05-28 19:10:17.400477195 -0500
+++ linux-source-2.6.16/drivers/net/wireless/orinoco.c	2006-05-28 23:22:34.384498316 -0500
@@ -3588,6 +3588,194 @@
 	return err;
 }
 
+static int orinoco_set_encodeext(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct iw_point *encoding = &wrqu->encoding;
+	struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
+	int idx, key_len, alg = ext->alg, set_key = 1;
+	unsigned long flags;
+	int err;
+
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
+
+	/* Determine and validate the key index */
+	err = -EINVAL;
+	idx = encoding->flags & IW_ENCODE_INDEX;
+	if (idx) {
+		if (idx < 1 || idx > WEP_KEYS)
+			goto out;
+		idx--;
+	} else
+		idx = priv->tx_key;
+
+	if (encoding->flags & IW_ENCODE_DISABLED)
+	    alg = IW_ENCODE_ALG_NONE;
+
+	if (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY) {
+		priv->tx_key = idx;
+		set_key = ext->key_len > 0 ? 1 : 0;
+	}
+
+	if (set_key) {
+		/* Set the requested key first */
+		switch (alg) {
+		case IW_ENCODE_ALG_NONE:
+			priv->wep_on = 0;
+			priv->keys[idx].len = 0;
+			break;
+		case IW_ENCODE_ALG_WEP:
+			if (ext->key_len > SMALL_KEY_SIZE) {
+				priv->keys[idx].len = LARGE_KEY_SIZE;
+			} else if (ext->key_len > 0) {
+				priv->keys[idx].len = SMALL_KEY_SIZE;
+			} else {
+				goto out;
+			}
+			priv->wep_on = 1;
+			memset(priv->keys[idx].data, 0, ORINOCO_MAX_KEY_SIZE);
+			key_len = min(ext->key_len, priv->keys[idx].len);
+			memcpy(priv->keys[idx].data, ext->key, key_len);
+			break;
+		default:
+			goto out;
+		}
+	}
+
+	err = -EINPROGRESS;
+ out:
+	orinoco_unlock(priv, &flags);
+
+	return err;
+}
+
+static int orinoco_get_encodeext(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct iw_point *encoding = &wrqu->encoding;
+	struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
+	int idx, max_key_len;
+	unsigned long flags;
+	int err;
+
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
+
+	err = -EINVAL;
+	max_key_len = encoding->length - sizeof(*ext);
+	if (max_key_len < 0)
+		goto out;
+
+	idx = encoding->flags & IW_ENCODE_INDEX;
+	if (idx) {
+		if (idx < 1 || idx > WEP_KEYS)
+			goto out;
+		idx--;
+	} else
+		idx = priv->tx_key;
+
+	encoding->flags = idx + 1;
+	memset(ext, 0, sizeof(*ext));
+
+	if (!priv->wep_on) {
+		ext->alg = IW_ENCODE_ALG_NONE;
+		ext->key_len = 0;
+		encoding->flags |= IW_ENCODE_DISABLED;
+	} else {
+		ext->alg = IW_ENCODE_ALG_WEP;
+		ext->key_len = priv->keys[idx].len;
+		memcpy(ext->key, priv->keys[idx].data, ext->key_len);
+		encoding->flags |= IW_ENCODE_ENABLED;
+	}
+
+	err = 0;
+ out:
+	orinoco_unlock(priv, &flags);
+
+	return err;
+}
+
+static int orinoco_set_auth(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
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
+		 * orinoco does not use these parameters
+		 */
+		break;
+
+	case IW_AUTH_DROP_UNENCRYPTED:
+		priv->wep_restrict = param->value ? 1 : 0;
+		break;
+
+	case IW_AUTH_80211_AUTH_ALG: {
+			if (param->value & IW_AUTH_ALG_SHARED_KEY) {
+				priv->wep_restrict = 1;
+			} else if (param->value & IW_AUTH_ALG_OPEN_SYSTEM) {
+				priv->wep_restrict = 0;
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
+static int orinoco_get_auth(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct iw_param *param = &wrqu->param;
+
+	switch (param->flags & IW_AUTH_INDEX) {
+	case IW_AUTH_DROP_UNENCRYPTED:
+		param->value = priv->wep_restrict;
+		break;
+
+	case IW_AUTH_80211_AUTH_ALG:
+		if (priv->wep_restrict)
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
 static int orinoco_ioctl_getretry(struct net_device *dev,
 				  struct iw_request_info *info,
 				  struct iw_param *rrq,
@@ -4299,6 +4487,10 @@
 	[SIOCGIWENCODE-SIOCIWFIRST] = (iw_handler) orinoco_ioctl_getiwencode,
 	[SIOCSIWPOWER -SIOCIWFIRST] = (iw_handler) orinoco_ioctl_setpower,
 	[SIOCGIWPOWER -SIOCIWFIRST] = (iw_handler) orinoco_ioctl_getpower,
+	[SIOCSIWAUTH  -SIOCIWFIRST] = (iw_handler) orinoco_set_auth,
+	[SIOCGIWAUTH  -SIOCIWFIRST] = (iw_handler) orinoco_get_auth,
+	[SIOCSIWENCODEEXT-SIOCIWFIRST] = (iw_handler) orinoco_set_encodeext,
+	[SIOCGIWENCODEEXT-SIOCIWFIRST] = (iw_handler) orinoco_get_encodeext,
 };
 
 
