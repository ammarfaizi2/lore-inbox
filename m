Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135586AbRDXW5E>; Tue, 24 Apr 2001 18:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135593AbRDXW45>; Tue, 24 Apr 2001 18:56:57 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:50370 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S135586AbRDXW4q>;
	Tue, 24 Apr 2001 18:56:46 -0400
Date: Tue, 24 Apr 2001 15:56:37 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: orinoco_cs & IrDA
Message-ID: <20010424155637.D31898@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010424113920.B31666@bougret.hpl.hp.com> <E14s8mc-0002n9-00@the-village.bc.nu> <20010424151508.C31898@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424151508.C31898@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Apr 24, 2001 at 03:15:08PM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 24, 2001 at 03:15:08PM -0700, Jean Tourrilhes wrote:
> 
[...]
> 	Downloaded the patch again (patch-2.4.4-pre6), checked that it
> was complete, my patch is in. Oups ! Do I feel stupid...

	Let's finish this story. As indicated above, the first
fragment of the patch I sent on month ago is in the kernel. The two
other fragments didn't make it. They are attached...

wireless.v11b.diff :
------------------
	Update the various wireless LAN driver in the kernel to
version 11 (definition already in the kernel). This update is
necessary to avoid crashes in the user space utilities.

orinoco_w11.diff :
----------------
	Same deal for the new orinoco_cs driver.
	I've also added the retry limit setting, but this feature is
not enabled (priv->has_retry = 0).


	Alan : those two are already in your last kernel, please ignore.

	Linus : those are not in your kernel.

	That's it...

	Jean

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wireless.v11b.diff"

diff -u -p linux/drivers/net/wireless.25/wavelan.c linux/drivers/net/wavelan.c
--- linux/drivers/net/wireless.25/wavelan.c	Wed Mar 28 17:27:27 2001
+++ linux/drivers/net/wavelan.c	Wed Mar 28 17:28:34 2001
@@ -2028,8 +2028,17 @@ static int wavelan_ioctl(struct net_devi
 		if (wrq->u.data.pointer != (caddr_t) 0) {
 			struct iw_range range;
 
-			/* Set the length (useless:  it's constant). */
+			/* Set the length (very important for backward
+			 * compatibility) */
 			wrq->u.data.length = sizeof(struct iw_range);
+
+			/* Set all the info we don't care or don't know
+			 * about to zero */
+			memset(&range, 0, sizeof(range));
+
+			/* Set the Wireless Extension versions */
+			range.we_version_compiled = WIRELESS_EXT;
+			range.we_version_source = 9;
 
 			/* Set information in the range struct.  */
 			range.throughput = 1.6 * 1000 * 1000;	/* don't argue on this ! */
diff -u -p linux/drivers/net/pcmcia/wireless.25/wavelan_cs.c linux/drivers/net/pcmcia/wavelan_cs.c
--- linux/drivers/net/pcmcia/wireless.25/wavelan_cs.c	Wed Mar 28 17:21:02 2001
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Wed Mar 28 17:23:19 2001
@@ -2239,8 +2239,15 @@ wavelan_ioctl(struct net_device *	dev,	/
 	{
 	  struct iw_range	range;
 
-	  /* Set the length (useless : its constant...) */
+	  /* Set the length (very important for backward compatibility) */
 	  wrq->u.data.length = sizeof(struct iw_range);
+
+	  /* Set all the info we don't care or don't know about to zero */
+	  memset(&range, 0, sizeof(range));
+
+	  /* Set the Wireless Extension versions */
+	  range.we_version_compiled = WIRELESS_EXT;
+	  range.we_version_source = 9;	/* Nothing for us in v10 and v11 */
 
 	  /* Set information in the range struct */
 	  range.throughput = 1.4 * 1000 * 1000;	/* don't argue on this ! */
diff -u -p linux/drivers/net/pcmcia/wireless.25/netwave_cs.c linux/drivers/net/pcmcia/netwave_cs.c
--- linux/drivers/net/pcmcia/wireless.25/netwave_cs.c	Wed Mar 28 17:24:40 2001
+++ linux/drivers/net/pcmcia/netwave_cs.c	Wed Mar 28 17:29:39 2001
@@ -710,8 +710,17 @@ static int netwave_ioctl(struct net_devi
        if(wrq->u.data.pointer != (caddr_t) 0) {
 	   struct iw_range	range;
 		   
-	   /* Set the length (useless : its constant...) */
+	   /* Set the length (very important for backward compatibility) */
 	   wrq->u.data.length = sizeof(struct iw_range);
+
+	   /* Set all the info we don't care or don't know about to zero */
+	   memset(&range, 0, sizeof(range));
+
+#if WIRELESS_EXT > 10
+	   /* Set the Wireless Extension versions */
+	   range.we_version_compiled = WIRELESS_EXT;
+	   range.we_version_source = 9;	/* Nothing for us in v10 and v11 */
+#endif /* WIRELESS_EXT > 10 */
 		   
 	   /* Set information in the range struct */
 	   range.throughput = 450 * 1000;	/* don't argue on this ! */
diff -u -p linux/drivers/net/pcmcia/wireless.25/ray_cs.c linux/drivers/net/pcmcia/ray_cs.c
--- linux/drivers/net/pcmcia/wireless.25/ray_cs.c	Wed Mar 28 17:21:57 2001
+++ linux/drivers/net/pcmcia/ray_cs.c	Wed Mar 28 17:30:16 2001
@@ -1332,8 +1332,14 @@ static int ray_dev_ioctl(struct net_devi
 	  struct iw_range	range;
 	  memset((char *) &range, 0, sizeof(struct iw_range));
 
-	  /* Set the length (useless : its constant...) */
+	  /* Set the length (very important for backward compatibility) */
 	  wrq->u.data.length = sizeof(struct iw_range);
+
+#if WIRELESS_EXT > 10
+	  /* Set the Wireless Extension versions */
+	  range.we_version_compiled = WIRELESS_EXT;
+	  range.we_version_source = 9;
+#endif /* WIRELESS_EXT > 10 */
 
 	  /* Set information in the range struct */
 	  range.throughput = 1.1 * 1000 * 1000;	/* Put the right number here */

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="orinoco_w11.diff"

diff -u -p linux/drivers/net/pcmcia/wireless.25/hermes.h linux/drivers/net/pcmcia/hermes.h
--- linux/drivers/net/pcmcia/wireless.25/hermes.h	Wed Mar 28 10:31:35 2001
+++ linux/drivers/net/pcmcia/hermes.h	Wed Mar 28 10:43:20 2001
@@ -196,6 +196,9 @@
 #define		HERMES_RID_CURRENT_BSSID	((uint16_t)0xfd42)
 #define		HERMES_RID_COMMSQUALITY		((uint16_t)0xfd43)
 #define 	HERMES_RID_CURRENT_TX_RATE	((uint16_t)0xfd44)
+#define 	HERMES_RID_SHORT_RETRY_LIMIT	((uint16_t)0xfd48)
+#define 	HERMES_RID_LONG_RETRY_LIMIT	((uint16_t)0xfd49)
+#define 	HERMES_RID_MAX_TX_LIFETIME	((uint16_t)0xfd4A)
 #define		HERMES_RID_WEP_AVAIL		((uint16_t)0xfd4f)
 #define		HERMES_RID_CURRENT_CHANNEL	((uint16_t)0xfdc1)
 #define		HERMES_RID_DATARATES		((uint16_t)0xfdc6)
diff -u -p linux/drivers/net/pcmcia/wireless.25/orinoco_cs.c linux/drivers/net/pcmcia/orinoco_cs.c
--- linux/drivers/net/pcmcia/wireless.25/orinoco_cs.c	Wed Mar 28 10:31:35 2001
+++ linux/drivers/net/pcmcia/orinoco_cs.c	Wed Mar 28 17:16:36 2001
@@ -239,6 +239,7 @@ typedef struct dldwd_priv {
 	int has_wep, has_big_wep;
 	int has_mwo;
 	int has_pm;
+	int has_retry;
 	int broken_reset, broken_allocate;
 	uint16_t channel_mask;
 
@@ -254,6 +255,7 @@ typedef struct dldwd_priv {
 	uint16_t ap_density, rts_thresh;
 	uint16_t tx_rate_ctrl;
 	uint16_t pm_on, pm_mcast, pm_period, pm_timeout;
+	uint16_t retry_short, retry_long, retry_time;
 
 	int promiscuous, allmulti, mc_count;
 
@@ -645,6 +647,24 @@ ESSID in IBSS-Ad-Hoc mode.\n", dev->name
 			goto out;
 	}
 
+	/* Set retry settings - will fail on lot's of firmwares */
+	if (priv->has_retry) {
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_SHORT_RETRY_LIMIT,
+					   priv->retry_short);
+		if (err) {
+			printk(KERN_WARNING "%s: Can't set retry limit!\n", dev->name);
+			goto out;
+		}
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_LONG_RETRY_LIMIT,
+					   priv->retry_long);
+		if (err)
+			goto out;
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_MAX_TX_LIFETIME,
+					   priv->retry_time);
+		if (err)
+			goto out;
+	}
+
 	/* Set promiscuity / multicast*/
 	priv->promiscuous = 0;
 	priv->allmulti = 0;
@@ -1267,6 +1287,7 @@ static int dldwd_init(struct net_device 
 					  Gold cards from the others? */
 		priv->has_mwo = (firmver >= 0x60000);
 		priv->has_pm = (firmver >= 0x40020);
+		priv->has_retry = 0;
 		/* Tested with Lucent firmware :
 		 *	1.16 ; 4.08 ; 4.52 ; 6.04 ; 6.16 => Jean II
 		 * Tested CableTron firmware : 4.32 => Anton */
@@ -1285,6 +1306,7 @@ static int dldwd_init(struct net_device 
 		priv->has_big_wep = 1;
 		priv->has_mwo = 0;
 		priv->has_pm = (firmver >= 0x20000);
+		priv->has_retry = 0;
 		/* Tested with Intel firmware : 1.01 => Jean II */
 		/* Note : firmware 1.01 is *seriously* broken */
 		break;
@@ -1301,6 +1323,7 @@ static int dldwd_init(struct net_device 
 		priv->has_big_wep = 0; /* FIXME */
 		priv->has_mwo = 0;
 		priv->has_pm = (firmver >= 0x20000); /* FIXME */
+		priv->has_retry = 0;
 		break;
 	case 0x6:
 		vendor_str = "LinkSys/D-Link";
@@ -1315,6 +1338,7 @@ static int dldwd_init(struct net_device 
 		priv->has_big_wep = 0;
 		priv->has_mwo = 0;
 		priv->has_pm = (firmver >= 0x20000); /* FIXME */
+		priv->has_retry = 0;
 		break;
 #if 0
 	case 0x???:		/* Could someone help here ??? */
@@ -1330,6 +1354,7 @@ static int dldwd_init(struct net_device 
 		priv->has_big_wep = 1;	/* Probably RID_SYMBOL_KEY_LENGTH */
 		priv->has_mwo = 0;
 		priv->has_pm = (firmver >= 0x20000);
+		priv->has_retry = 0;
 		break;
 #endif
 	default:
@@ -1344,6 +1369,7 @@ static int dldwd_init(struct net_device 
 		priv->has_big_wep = 0;
 		priv->has_mwo = 0;
 		priv->has_pm = 0;
+		priv->has_retry = 0;
 	}
 
 	printk(KERN_INFO "%s: Firmware ID %02X vendor 0x%x (%s) version %d.%02d\n",
@@ -1453,6 +1479,21 @@ static int dldwd_init(struct net_device 
 		}
 	}
 		
+	/* Retry setup */
+	if (priv->has_retry) {
+		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_SHORT_RETRY_LIMIT, &priv->retry_short);
+		if (err)
+			goto out;
+
+		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_LONG_RETRY_LIMIT, &priv->retry_long);
+		if (err)
+			goto out;
+
+		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_MAX_TX_LIFETIME, &priv->retry_time);
+		if (err)
+			goto out;
+	}
+		
 	/* Set up the default configuration */
 	priv->iw_mode = IW_MODE_INFRA;
 	/* By default use IEEE/IBSS ad-hoc mode if we have it */
@@ -1802,6 +1843,11 @@ static int dldwd_ioctl_getiwrange(struct
 
 	/* Much of this shamelessly taken from wvlan_cs.c. No idea
 	 * what it all means -dgibson */
+#if WIRELESS_EXT > 10
+	range.we_version_compiled = WIRELESS_EXT;
+	range.we_version_source = 11;
+#endif /* WIRELESS_EXT > 10 */
+
 	range.min_nwid = range.max_nwid = 0; /* We don't use nwids */
 
 	/* Set available channels/frequencies */
@@ -1881,6 +1927,16 @@ static int dldwd_ioctl_getiwrange(struct
 	range.txpower[0] = 15; /* 15dBm */
 	range.txpower_capa = IW_TXPOW_DBM;
 
+#if WIRELESS_EXT > 10
+	range.retry_capa = IW_RETRY_LIMIT | IW_RETRY_LIFETIME;
+	range.retry_flags = IW_RETRY_LIMIT;
+	range.r_time_flags = IW_RETRY_LIFETIME;
+	range.min_retry = 0;
+	range.max_retry = 65535;	/* ??? */
+	range.min_r_time = 0;
+	range.max_r_time = 65535 * 1000;	/* ??? */
+#endif /* WIRELESS_EXT > 10 */
+
 	if (copy_to_user(rrq->pointer, &range, sizeof(range)))
 		return -EFAULT;
 
@@ -2520,6 +2576,92 @@ static int dldwd_ioctl_getpower(struct n
 	return err;
 }
 
+#if WIRELESS_EXT > 10
+static int dldwd_ioctl_setretry(struct net_device *dev, struct iw_param *rrq)
+{
+	dldwd_priv_t *priv = dev->priv;
+	int err = 0;
+
+
+	dldwd_lock(priv);
+
+	if ((rrq->disabled) || (!priv->has_retry)){
+		err = -EOPNOTSUPP;
+		goto out;
+	} else {
+		if (rrq->flags & IW_RETRY_LIMIT) {
+			if (rrq->flags & IW_RETRY_MAX)
+				priv->retry_long = rrq->value;
+			else if (rrq->flags & IW_RETRY_MIN)
+				priv->retry_short = rrq->value;
+			else {
+				/* No modifier : set both */
+				priv->retry_long = rrq->value;
+				priv->retry_short = rrq->value;
+			}
+		}
+		if (rrq->flags & IW_RETRY_LIFETIME) {
+			priv->retry_time = rrq->value / 1000;
+		}
+		if ((rrq->flags & IW_RETRY_TYPE) == 0) {
+			err = -EINVAL;
+			goto out;
+		}			
+	}
+
+ out:
+	dldwd_unlock(priv);
+
+	return err;
+}
+
+static int dldwd_ioctl_getretry(struct net_device *dev, struct iw_param *rrq)
+{
+	dldwd_priv_t *priv = dev->priv;
+	hermes_t *hw = &priv->hw;
+	int err = 0;
+	uint16_t short_limit, long_limit, lifetime;
+
+	dldwd_lock(priv);
+	
+	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_SHORT_RETRY_LIMIT, &short_limit);
+	if (err)
+		goto out;
+
+	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_LONG_RETRY_LIMIT, &long_limit);
+	if (err)
+		goto out;
+
+	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_MAX_TX_LIFETIME, &lifetime);
+	if (err)
+		goto out;
+
+	rrq->disabled = 0;		/* Can't be disabled */
+
+	/* Note : by default, display the retry number */
+	if ((rrq->flags & IW_RETRY_TYPE) == IW_RETRY_LIFETIME) {
+		rrq->flags = IW_RETRY_LIFETIME;
+		rrq->value = lifetime * 1000;	/* ??? */
+	} else {
+		/* By default, display the min number */
+		if ((rrq->flags & IW_RETRY_MAX)) {
+			rrq->flags = IW_RETRY_LIMIT | IW_RETRY_MAX;
+			rrq->value = long_limit;
+		} else {
+			rrq->flags = IW_RETRY_LIMIT;
+			rrq->value = short_limit;
+			if(short_limit != long_limit)
+				rrq->flags |= IW_RETRY_MIN;
+		}
+	}
+
+ out:
+	dldwd_unlock(priv);
+
+	return err;
+}
+#endif /* WIRELESS_EXT > 10 */
+
 static int dldwd_ioctl_setport3(struct net_device *dev, struct iwreq *wrq)
 {
 	dldwd_priv_t *priv = dev->priv;
@@ -2857,6 +2999,20 @@ static int dldwd_ioctl(struct net_device
 		wrq->u.txpower.disabled = 0;
 		wrq->u.txpower.flags = IW_TXPOW_DBM;
 		break;
+
+#if WIRELESS_EXT > 10
+	case SIOCSIWRETRY:
+		DEBUG(1, "%s: SIOCSIWRETRY\n", dev->name);
+		err = dldwd_ioctl_setretry(dev, &wrq->u.retry);
+		if (! err)
+			changed = 1;
+		break;
+
+	case SIOCGIWRETRY:
+		DEBUG(1, "%s: SIOCGIWRETRY\n", dev->name);
+		err = dldwd_ioctl_getretry(dev, &wrq->u.retry);
+		break;
+#endif /* WIRELESS_EXT > 10 */
 
 	case SIOCSIWSPY:
 		DEBUG(1, "%s: SIOCSIWSPY\n", dev->name);

--0ntfKIWw70PvrIHh--
