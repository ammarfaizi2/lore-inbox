Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVBXEag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVBXEag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVBXE20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:28:26 -0500
Received: from ozlabs.org ([203.10.76.45]:17334 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261794AbVBXENZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:25 -0500
Date: Thu, 24 Feb 2005 15:03:19 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [12/14] Orinoco driver updates - WEP updates
Message-ID: <20050224040319.GN32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224040153.GK32001@localhost.localdomain> <20050224040228.GL32001@localhost.localdomain> <20050224040258.GM32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040258.GM32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the WEP configuration code.  This adds support for shared
key authentication on Agere firmwares.  It also adds support (in some
cases) for changing the WEP keys without disabling the MAC port (thus
triggering a reassociation by the firmware).  This is needed by 802.1x
implementations, although it's not clear if the code so far is
sufficient to allow working 802.1x.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-24 14:50:55.904651256 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-24 14:50:57.300439064 +1100
@@ -1437,55 +1437,46 @@
 	return err;
 }
 
-static int __orinoco_hw_setup_wep(struct orinoco_private *priv)
+/* Change the WEP keys and/or the current keys.  Can be called
+ * either from __orinoco_hw_setup_wep() or directly from
+ * orinoco_ioctl_setiwencode().  In the later case the association
+ * with the AP is not broken (if the firmware can handle it),
+ * which is needed for 802.1x implementations. */
+static int __orinoco_hw_setup_wepkeys(struct orinoco_private *priv)
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
-	int	master_wep_flag;
-	int	auth_flag;
 
 	switch (priv->firmware_type) {
-	case FIRMWARE_TYPE_AGERE: /* Agere style WEP */
-		if (priv->wep_on) {
-			err = hermes_write_wordrec(hw, USER_BAP,
-						   HERMES_RID_CNFTXKEY_AGERE,
-						   priv->tx_key);
-			if (err)
-				return err;
-			
-			err = HERMES_WRITE_RECORD(hw, USER_BAP,
-						  HERMES_RID_CNFWEPKEYS_AGERE,
-						  &priv->keys);
-			if (err)
-				return err;
-		}
+	case FIRMWARE_TYPE_AGERE:
+		err = HERMES_WRITE_RECORD(hw, USER_BAP,
+					  HERMES_RID_CNFWEPKEYS_AGERE,
+					  &priv->keys);
+		if (err)
+			return err;
 		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFWEPENABLED_AGERE,
-					   priv->wep_on);
+					   HERMES_RID_CNFTXKEY_AGERE,
+					   priv->tx_key);
 		if (err)
 			return err;
 		break;
-
-	case FIRMWARE_TYPE_INTERSIL: /* Intersil style WEP */
-	case FIRMWARE_TYPE_SYMBOL: /* Symbol style WEP */
-		master_wep_flag = 0;		/* Off */
-		if (priv->wep_on) {
+	case FIRMWARE_TYPE_INTERSIL:
+	case FIRMWARE_TYPE_SYMBOL:
+		{
 			int keylen;
 			int i;
 
-			/* Fudge around firmware weirdness */
+			/* Force uniform key length to work around firmware bugs */
 			keylen = le16_to_cpu(priv->keys[priv->tx_key].len);
 			
+			if (keylen > LARGE_KEY_SIZE) {
+				printk(KERN_ERR "%s: BUG: Key %d has oversize length %d.\n",
+				       priv->ndev->name, priv->tx_key, keylen);
+				return -E2BIG;
+			}
+
 			/* Write all 4 keys */
 			for(i = 0; i < ORINOCO_MAX_KEYS; i++) {
-/*  				int keylen = le16_to_cpu(priv->keys[i].len); */
-				
-				if (keylen > LARGE_KEY_SIZE) {
-					printk(KERN_ERR "%s: BUG: Key %d has oversize length %d.\n",
-					       priv->ndev->name, i, keylen);
-					return -E2BIG;
-				}
-
 				err = hermes_write_ltv(hw, USER_BAP,
 						       HERMES_RID_CNFDEFAULTKEY0 + i,
 						       HERMES_BYTES_TO_RECLEN(keylen),
@@ -1500,27 +1491,63 @@
 						   priv->tx_key);
 			if (err)
 				return err;
-			
-			if (priv->wep_restrict) {
-				auth_flag = 2;
-				master_wep_flag = 3;
-			} else {
-				/* Authentication is where Intersil and Symbol
-				 * firmware differ... */
-				auth_flag = 1;
-				if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL)
-					master_wep_flag = 3; /* Symbol */ 
-				else 
-					master_wep_flag = 1; /* Intersil */
-			}
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static int __orinoco_hw_setup_wep(struct orinoco_private *priv)
+{
+	hermes_t *hw = &priv->hw;
+	int err = 0;
+	int master_wep_flag;
+	int auth_flag;
 
+	if (priv->wep_on)
+		__orinoco_hw_setup_wepkeys(priv);
+
+	if (priv->wep_restrict)
+		auth_flag = HERMES_AUTH_SHARED_KEY;
+	else
+		auth_flag = HERMES_AUTH_OPEN;
+
+	switch (priv->firmware_type) {
+	case FIRMWARE_TYPE_AGERE: /* Agere style WEP */
+		if (priv->wep_on) {
+			/* Enable the shared-key authentication. */
+			err = hermes_write_wordrec(hw, USER_BAP,
+						   HERMES_RID_CNFAUTHENTICATION_AGERE,
+						   auth_flag);
+		}
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFWEPENABLED_AGERE,
+					   priv->wep_on);
+		if (err)
+			return err;
+		break;
+
+	case FIRMWARE_TYPE_INTERSIL: /* Intersil style WEP */
+	case FIRMWARE_TYPE_SYMBOL: /* Symbol style WEP */
+		if (priv->wep_on) {
+			if (priv->wep_restrict ||
+			    (priv->firmware_type == FIRMWARE_TYPE_SYMBOL))
+				master_wep_flag = HERMES_WEP_PRIVACY_INVOKED |
+						  HERMES_WEP_EXCL_UNENCRYPTED;
+			else
+				master_wep_flag = HERMES_WEP_PRIVACY_INVOKED;
 
 			err = hermes_write_wordrec(hw, USER_BAP,
 						   HERMES_RID_CNFAUTHENTICATION,
 						   auth_flag);
 			if (err)
 				return err;
-		}
+		} else
+			master_wep_flag = 0;
+
+		if (priv->iw_mode == IW_MODE_MONITOR)
+			master_wep_flag |= HERMES_WEP_HOST_DECRYPT;
 
 		/* Master WEP setting : on/off */
 		err = hermes_write_wordrec(hw, USER_BAP,
@@ -1530,13 +1557,6 @@
 			return err;	
 
 		break;
-
-	default:
-		if (priv->wep_on) {
-			printk(KERN_ERR "%s: WEP enabled, although not supported!\n",
-			       priv->ndev->name);
-			return -EINVAL;
-		}
 	}
 
 	return 0;
@@ -2702,11 +2722,17 @@
 	int err = 0;
 	char keybuf[ORINOCO_MAX_KEY_SIZE];
 	unsigned long flags;
-	
+
+	if (! priv->has_wep)
+		return -EOPNOTSUPP;
+
 	if (erq->pointer) {
-		/* We actually have a key to set */
-		if ( (erq->length < SMALL_KEY_SIZE) || (erq->length > ORINOCO_MAX_KEY_SIZE) )
-			return -EINVAL;
+		/* We actually have a key to set - check its length */
+		if (erq->length > LARGE_KEY_SIZE)
+			return -E2BIG;
+
+		if ( (erq->length > SMALL_KEY_SIZE) && !priv->has_big_wep )
+			return -E2BIG;
 		
 		if (copy_from_user(keybuf, erq->pointer, erq->length))
 			return -EFAULT;
@@ -2714,19 +2740,8 @@
 
 	if (orinoco_lock(priv, &flags) != 0)
 		return -EBUSY;
-	
+
 	if (erq->pointer) {
-		if (erq->length > ORINOCO_MAX_KEY_SIZE) {
-			err = -E2BIG;
-			goto out;
-		}
-		
-		if ( (erq->length > LARGE_KEY_SIZE)
-		     || ( ! priv->has_big_wep && (erq->length > SMALL_KEY_SIZE))  ) {
-			err = -EINVAL;
-			goto out;
-		}
-		
 		if ((index < 0) || (index >= ORINOCO_MAX_KEYS))
 			index = priv->tx_key;
 
@@ -2737,7 +2752,7 @@
 			xlen = SMALL_KEY_SIZE;
 		} else
 			xlen = 0;
-		
+
 		/* Switch on WEP if off */
 		if ((!enable) && (xlen > 0)) {
 			setindex = index;
@@ -2761,10 +2776,9 @@
 			setindex = index;
 		}
 	}
-	
+
 	if (erq->flags & IW_ENCODE_DISABLED)
 		enable = 0;
-	/* Only for Prism2 & Symbol cards (so far) - Jean II */
 	if (erq->flags & IW_ENCODE_OPEN)
 		restricted = 0;
 	if (erq->flags & IW_ENCODE_RESTRICTED)
@@ -2777,6 +2791,15 @@
 		memcpy(priv->keys[index].data, keybuf, erq->length);
 	}
 	priv->tx_key = setindex;
+
+	/* Try fast key change if connected and only keys are changed */
+	if (priv->wep_on && enable && (priv->wep_restrict == restricted) &&
+	    netif_carrier_ok(dev)) {
+		err = __orinoco_hw_setup_wepkeys(priv);
+		/* No need to commit if successful */
+		goto out;
+	}
+
 	priv->wep_on = enable;
 	priv->wep_restrict = restricted;
 
@@ -2794,6 +2817,9 @@
 	char keybuf[ORINOCO_MAX_KEY_SIZE];
 	unsigned long flags;
 
+	if (! priv->has_wep)
+		return -EOPNOTSUPP;
+
 	if (orinoco_lock(priv, &flags) != 0)
 		return -EBUSY;
 
@@ -2804,23 +2830,18 @@
 	if (! priv->wep_on)
 		erq->flags |= IW_ENCODE_DISABLED;
 	erq->flags |= index + 1;
-	
-	/* Only for symbol cards - Jean II */
-	if (priv->firmware_type != FIRMWARE_TYPE_AGERE) {
-		if(priv->wep_restrict)
-			erq->flags |= IW_ENCODE_RESTRICTED;
-		else
-			erq->flags |= IW_ENCODE_OPEN;
-	}
+
+	if (priv->wep_restrict)
+		erq->flags |= IW_ENCODE_RESTRICTED;
+	else
+		erq->flags |= IW_ENCODE_OPEN;
 
 	xlen = le16_to_cpu(priv->keys[index].len);
 
 	erq->length = xlen;
 
-	if (erq->pointer) {
-		memcpy(keybuf, priv->keys[index].data, ORINOCO_MAX_KEY_SIZE);
-	}
-	
+	memcpy(keybuf, priv->keys[index].data, ORINOCO_MAX_KEY_SIZE);
+
 	orinoco_unlock(priv, &flags);
 
 	if (erq->pointer) {
@@ -3626,22 +3647,12 @@
 		break;
 
 	case SIOCSIWENCODE:
-		if (! priv->has_wep) {
-			err = -EOPNOTSUPP;
-			break;
-		}
-
 		err = orinoco_ioctl_setiwencode(dev, &wrq->u.encoding);
 		if (! err)
 			changed = 1;
 		break;
 
 	case SIOCGIWENCODE:
-		if (! priv->has_wep) {
-			err = -EOPNOTSUPP;
-			break;
-		}
-
 		if (! capable(CAP_NET_ADMIN)) {
 			err = -EPERM;
 			break;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
