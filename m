Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbUKCDqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUKCDqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUKCDqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:46:55 -0500
Received: from ozlabs.org ([203.10.76.45]:7089 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261402AbUKCDpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:45:55 -0500
Date: Wed, 3 Nov 2004 14:44:33 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Roskin <proski@gnu.org>,
       orinoco-deve@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Another trivial orinoco update
Message-ID: <20041103034433.GB5441@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	Pavel Roskin <proski@gnu.org>, orinoco-deve@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff/Andrew please apply:

This patch alters the convention with which orinoco_lock() is invoked
in the orinoco driver.  This should cause no behavioural change, but
reduces meaningless diffs between the mainline and CVS version of the
driver.  Another small step towards a merge.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-11-03 12:08:34.464080384 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-11-03 13:34:38.339052064 +1100
@@ -617,9 +617,8 @@
 	unsigned long flags;
 	int err;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	err = __orinoco_up(dev);
 
@@ -671,10 +670,9 @@
 		return NULL; /* FIXME: Can we do better than this? */
 	}
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return NULL; /* FIXME: Erg, we've been signalled, how
-			      * do we propagate this back up? */
+	if (orinoco_lock(priv, &flags) != 0)
+		return NULL;  /* FIXME: Erg, we've been signalled, how
+			       * do we propagate this back up? */
 
 	if (priv->iw_mode == IW_MODE_ADHOC) {
 		memset(&wstats->qual, 0, sizeof(wstats->qual));
@@ -1822,10 +1820,8 @@
 		return 0;
 	}
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
-
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 		
 	err = hermes_disable_port(hw, 0);
 	if (err) {
@@ -1867,11 +1863,10 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	struct hermes *hw = &priv->hw;
-	int err;
+	int err = 0;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
+	if (orinoco_lock(priv, &flags) != 0)
 		/* When the hardware becomes available again, whatever
 		 * detects that is responsible for re-initializing
 		 * it. So no need for anything further */
@@ -2414,9 +2409,8 @@
 	int err = 0;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_CURRENTBSSID,
 			      ETH_ALEN, NULL, buf);
@@ -2436,9 +2430,8 @@
 	int len;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	if (strlen(priv->desired_essid) > 0) {
 		/* We read the desired SSID from the hardware rather
@@ -2489,9 +2482,8 @@
 	long freq = 0;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	
 	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CURRENTCHANNEL, &channel);
 	if (err)
@@ -2531,9 +2523,8 @@
 	int i;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_SUPPORTEDDATARATES,
 			      sizeof(list), NULL, &list);
@@ -2571,9 +2562,8 @@
 
 	rrq->length = sizeof(range);
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	mode = priv->iw_mode;
 	orinoco_unlock(priv, &flags);
@@ -2642,9 +2632,8 @@
 	range.min_frag = 256;
 	range.max_frag = 2346;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	if (priv->has_wep) {
 		range.max_encoding_tokens = ORINOCO_MAX_KEYS;
 
@@ -2709,10 +2698,9 @@
 		if (copy_from_user(keybuf, erq->pointer, erq->length))
 			return -EFAULT;
 	}
-	
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	
 	if (erq->pointer) {
 		if (erq->length > ORINOCO_MAX_KEY_SIZE) {
@@ -2791,12 +2779,10 @@
 	int index = (erq->flags & IW_ENCODE_INDEX) - 1;
 	u16 xlen = 0;
 	char keybuf[ORINOCO_MAX_KEY_SIZE];
-	int err;
 	unsigned long flags;
-	
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	if ((index < 0) || (index >= ORINOCO_MAX_KEYS))
 		index = priv->tx_key;
@@ -2836,7 +2822,6 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	char essidbuf[IW_ESSID_MAX_SIZE+1];
-	int err;
 	unsigned long flags;
 
 	/* Note : ESSID is ignored in Ad-Hoc demo mode, but we can set it
@@ -2854,9 +2839,8 @@
 		essidbuf[erq->length] = '\0';
 	}
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	memcpy(priv->desired_essid, essidbuf, sizeof(priv->desired_essid));
 
@@ -2880,9 +2864,8 @@
 		if (err)
 			return err;
 	} else {
-		err = orinoco_lock(priv, &flags);
-		if (err)
-			return err;
+		if (orinoco_lock(priv, &flags) != 0)
+			return -EBUSY;
 		memcpy(essidbuf, priv->desired_essid, sizeof(essidbuf));
 		orinoco_unlock(priv, &flags);
 	}
@@ -2902,7 +2885,6 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	char nickbuf[IW_ESSID_MAX_SIZE+1];
-	int err;
 	unsigned long flags;
 
 	if (nrq->length > IW_ESSID_MAX_SIZE)
@@ -2915,9 +2897,8 @@
 
 	nickbuf[nrq->length] = '\0';
 	
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	memcpy(priv->nick, nickbuf, sizeof(priv->nick));
 
@@ -2930,12 +2911,10 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	char nickbuf[IW_ESSID_MAX_SIZE+1];
-	int err;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	memcpy(nickbuf, priv->nick, IW_ESSID_MAX_SIZE+1);
 	orinoco_unlock(priv, &flags);
@@ -2952,7 +2931,6 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int chan = -1;
-	int err;
 	unsigned long flags;
 
 	/* We can only use this in Ad-Hoc demo mode to set the operating
@@ -2981,9 +2959,8 @@
 	     ! (priv->channel_mask & (1 << (chan-1)) ) )
 		return -EINVAL;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	priv->channel = chan;
 	orinoco_unlock(priv, &flags);
 
@@ -3001,9 +2978,8 @@
 	if (!priv->has_sensitivity)
 		return -EOPNOTSUPP;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	err = hermes_read_wordrec(hw, USER_BAP,
 				  HERMES_RID_CNFSYSTEMSCALE, &val);
 	orinoco_unlock(priv, &flags);
@@ -3021,7 +2997,6 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int val = srq->value;
-	int err;
 	unsigned long flags;
 
 	if (!priv->has_sensitivity)
@@ -3030,9 +3005,8 @@
 	if ((val < 1) || (val > 3))
 		return -EINVAL;
 	
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	priv->ap_density = val;
 	orinoco_unlock(priv, &flags);
 
@@ -3043,7 +3017,6 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int val = rrq->value;
-	int err;
 	unsigned long flags;
 
 	if (rrq->disabled)
@@ -3052,9 +3025,8 @@
 	if ( (val < 0) || (val > 2347) )
 		return -EINVAL;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	priv->rts_thresh = val;
 	orinoco_unlock(priv, &flags);
@@ -3068,9 +3040,8 @@
 	int err = 0;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	if (priv->has_mwo) {
 		if (frq->disabled)
@@ -3106,9 +3077,8 @@
 	u16 val;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	
 	if (priv->has_mwo) {
 		err = hermes_read_wordrec(hw, USER_BAP,
@@ -3170,9 +3140,8 @@
 	if (ratemode == -1)
 		return -EINVAL;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	priv->bitratemode = ratemode;
 	orinoco_unlock(priv, &flags);
 
@@ -3189,9 +3158,8 @@
 	u16 val;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	ratemode = priv->bitratemode;
 
@@ -3251,9 +3219,8 @@
 	int err = 0;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	if (prq->disabled) {
 		priv->pm_on = 0;
@@ -3306,9 +3273,8 @@
 	u16 enable, period, timeout, mcast;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	
 	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CNFPMENABLED, &enable);
 	if (err)
@@ -3355,9 +3321,8 @@
 	u16 short_limit, long_limit, lifetime;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 	
 	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_SHORTRETRYLIMIT,
 				  &short_limit);
@@ -3403,12 +3368,10 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int val = *( (int *) wrq->u.name );
-	int err;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	priv->ibss_port = val ;
 
@@ -3423,12 +3386,10 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int *val = (int *)wrq->u.name;
-	int err;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	*val = priv->ibss_port;
 	orinoco_unlock(priv, &flags);
@@ -3443,9 +3404,8 @@
 	int err = 0;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	switch (val) {
 	case 0: /* Try to do IEEE ad-hoc mode */
@@ -3482,12 +3442,10 @@
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int *val = (int *)wrq->u.name;
-	int err;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	*val = priv->prefer_port3;
 	orinoco_unlock(priv, &flags);
@@ -3517,9 +3475,8 @@
 	}
 
 	/* Make sure nobody mess with the structure while we do */
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	/* orinoco_lock() doesn't disable interrupts, so make sure the
 	 * interrupt rx path don't get confused while we copy */
@@ -3550,12 +3507,10 @@
 	struct iw_quality spy_stat[IW_MAX_SPY];
 	int number;
 	int i;
-	int err;
 	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	if (orinoco_lock(priv, &flags) != 0)
+		return -EBUSY;
 
 	number = priv->spy_number;
 	if ((number > 0) && (srq->pointer)) {
@@ -3625,9 +3580,8 @@
 		break;
 
 	case SIOCSIWMODE:
-		err = orinoco_lock(priv, &flags);
-		if (err)
-			return err;
+		if (orinoco_lock(priv, &flags) != 0)
+			return -EBUSY;
 		switch (wrq->u.mode) {
 		case IW_MODE_ADHOC:
 			if (! (priv->has_ibss || priv->has_port3) )
@@ -3652,9 +3606,8 @@
 		break;
 
 	case SIOCGIWMODE:
-		err = orinoco_lock(priv, &flags);
-		if (err)
-			return err;
+		if (orinoco_lock(priv, &flags) != 0)
+			return -EBUSY;
 		wrq->u.mode = priv->iw_mode;
 		orinoco_unlock(priv, &flags);
 		break;
@@ -3869,9 +3822,8 @@
 		if(priv->has_preamble) {
 			int val = *( (int *) wrq->u.name );
 
-			err = orinoco_lock(priv, &flags);
-			if (err)
-				return err;
+			if (orinoco_lock(priv, &flags) != 0)
+				return -EBUSY;
 			if (val)
 				priv->preamble = 1;
 			else
@@ -3886,9 +3838,8 @@
 		if(priv->has_preamble) {
 			int *val = (int *)wrq->u.name;
 
-			err = orinoco_lock(priv, &flags);
-			if (err)
-				return err;
+			if (orinoco_lock(priv, &flags) != 0)
+				return -EBUSY;
 			*val = priv->preamble;
 			orinoco_unlock(priv, &flags);
 		} else


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
