Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285312AbRLNBod>; Thu, 13 Dec 2001 20:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285309AbRLNBoP>; Thu, 13 Dec 2001 20:44:15 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:55025 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285312AbRLNBnD>;
	Thu, 13 Dec 2001 20:43:03 -0500
Date: Thu, 13 Dec 2001 17:43:00 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Sample implementation in orinoco.c
Message-ID: <20011213174300.G520@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi,

	And this is how it looks like in orinoco.c. Patch not readable
again.

	Jean

--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ori.8d.we13.diff"

diff -u -p -r linux/drivers/net/wireless-w12/orinoco.c linux/drivers/net/wireless/orinoco.c
--- linux/drivers/net/wireless-w12/orinoco.c	Tue Dec 11 15:36:06 2001
+++ linux/drivers/net/wireless/orinoco.c	Thu Dec 13 13:36:48 2001
@@ -263,8 +263,11 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
-#include <linux/wireless.h>
 #include <linux/list.h>
+#include <linux/wireless.h>
+#if WIRELESS_EXT > 12
+#include <net/iw_handler.h>
+#endif	/* WIRELESS_EXT > 12 */
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -279,10 +282,21 @@
 #include "orinoco.h"
 #include "ieee802_11.h"
 
-/* Wireless extensions backwares compatibility */
+#if WIRELESS_EXT <= 12
+/* Wireless extensions backward compatibility */
+
+/* Part of iw_handler prototype we need */
+struct iw_request_info
+{
+	__u16		cmd;		/* Wireless Extension command */
+	__u16		flags;		/* More to come ;-) */
+};
+
+/* Private ioctl is migrating to a new range... */
 #ifndef SIOCIWFIRSTPRIV
 #define SIOCIWFIRSTPRIV		SIOCDEVPRIVATE
 #endif /* SIOCIWFIRSTPRIV */
+#endif	/* WIRELESS_EXT <= 12 */
 
 static char version[] __initdata = "orinoco.c 0.08b (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
@@ -439,6 +453,8 @@ static void __orinoco_ev_txexc(struct or
 static void __orinoco_ev_tx(struct orinoco_private *priv, hermes_t *hw);
 static void __orinoco_ev_alloc(struct orinoco_private *priv, hermes_t *hw);
 
+#if 0
+/* Either we fix those prototypes or we get rid of them - Jean II */
 static int orinoco_ioctl_getiwrange(struct net_device *dev, struct iw_point *rrq);
 static int orinoco_ioctl_setiwencode(struct net_device *dev, struct iw_point *erq);
 static int orinoco_ioctl_getiwencode(struct net_device *dev, struct iw_point *erq);
@@ -458,6 +474,7 @@ static int orinoco_ioctl_setpower(struct
 static int orinoco_ioctl_getpower(struct net_device *dev, struct iw_param *prq);
 static int orinoco_ioctl_setport3(struct net_device *dev, struct iwreq *wrq);
 static int orinoco_ioctl_getport3(struct net_device *dev, struct iwreq *wrq);
+#endif
 static void __orinoco_set_multicast_list(struct net_device *dev);
 
 /* /proc debugging stuff */
@@ -909,7 +926,9 @@ static int __orinoco_hw_setup_wep(struct
 	return 0;
 }
 
-static int orinoco_hw_get_bssid(struct orinoco_private *priv, char buf[ETH_ALEN])
+/* This is called only once from orinoco_ioctl_getwap(). */
+static inline int orinoco_hw_get_bssid(struct orinoco_private *priv,
+				       char buf[ETH_ALEN])
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
@@ -924,8 +943,10 @@ static int orinoco_hw_get_bssid(struct o
 	return err;
 }
 
-static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
-			      char buf[IW_ESSID_MAX_SIZE+1])
+/* This is called only once from orinoco_ioctl_getessid(). */
+static inline int orinoco_hw_get_essid(struct orinoco_private *priv,
+				       int *active,
+				       char buf[IW_ESSID_MAX_SIZE+1])
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
@@ -979,7 +1000,8 @@ static int orinoco_hw_get_essid(struct o
 	return err;       
 }
 
-static long orinoco_hw_get_freq(struct orinoco_private *priv)
+/* This is called only once from orinoco_ioctl_getfreq(). */
+static inline long orinoco_hw_get_freq(struct orinoco_private *priv)
 {
 	
 	hermes_t *hw = &priv->hw;
@@ -1011,8 +1033,10 @@ static long orinoco_hw_get_freq(struct o
 	return err ? err : freq;
 }
 
-static int orinoco_hw_get_bitratelist(struct orinoco_private *priv, int *numrates,
-				    int32_t *rates, int max)
+/* This is called only once from orinoco_ioctl_getiwrange(). */
+static inline int orinoco_hw_get_bitratelist(struct orinoco_private *priv,
+					     int *numrates,
+					     int32_t *rates, int max)
 {
 	hermes_t *hw = &priv->hw;
 	struct hermes_idstring list;
@@ -2138,175 +2162,235 @@ orinoco_tx_timeout(struct net_device *de
 	}
 }
 
-static int orinoco_ioctl_getiwrange(struct net_device *dev, struct iw_point *rrq)
+static int orinoco_ioctl_getname(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
+{
+	strcpy(wrqu->name, "IEEE 802.11-DS");
+	return 0;
+}
+
+static int orinoco_ioctl_getwap(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	wrqu->ap_addr.sa_family = ARPHRD_ETHER;
+	return orinoco_hw_get_bssid(priv, wrqu->ap_addr.sa_data);
+}
+
+static int orinoco_ioctl_setmode(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+	int err = -EINPROGRESS;		/* Call commit handler */
+
+	orinoco_lock(priv);
+	switch (wrqu->mode) {
+		case IW_MODE_ADHOC:
+			if (! (priv->has_ibss || priv->has_port3) )
+				err = -EINVAL;
+			else {
+				priv->iw_mode = IW_MODE_ADHOC;
+			}
+			break;
+
+		case IW_MODE_INFRA:
+			priv->iw_mode = IW_MODE_INFRA;
+			break;
+
+		default:
+			err = -EINVAL;
+			break;
+		}
+	set_port_type(priv);
+	orinoco_unlock(priv);
+
+	return err;
+}
+
+static int orinoco_ioctl_getmode(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	/* No real need to lock here */
+	orinoco_lock(priv);
+	wrqu->mode = priv->iw_mode;
+	orinoco_unlock(priv);
+	return 0;
+}
+
+static int orinoco_ioctl_getiwrange(struct net_device *dev,
+				    struct iw_request_info *info,
+				    union iwreq_data *wrqu,
+				    char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	int err = 0;
 	int mode;
-	struct iw_range range;
+	struct iw_range *range = (struct iw_range *) extra;
 	int numrates;
 	int i, k;
 
 	TRACE_ENTER(dev->name);
 
-	err = verify_area(VERIFY_WRITE, rrq->pointer, sizeof(range));
-	if (err)
-		return err;
+	wrqu->data.length = sizeof(struct iw_range);
 
-	rrq->length = sizeof(range);
-
-	orinoco_lock(priv);
-	mode = priv->iw_mode;
-	orinoco_unlock(priv);
-
-	memset(&range, 0, sizeof(range));
+	memset(range, 0, sizeof(struct iw_range));
 
 	/* Much of this shamelessly taken from wvlan_cs.c. No idea
 	 * what it all means -dgibson */
 #if WIRELESS_EXT > 10
-	range.we_version_compiled = WIRELESS_EXT;
-	range.we_version_source = 11;
+	range->we_version_compiled = WIRELESS_EXT;
+	range->we_version_source = 13;
 #endif /* WIRELESS_EXT > 10 */
 
-	range.min_nwid = range.max_nwid = 0; /* We don't use nwids */
+	// Already done in memset, don't redo it
+	range->min_nwid = range->max_nwid = 0; /* We don't use nwids */
 
 	/* Set available channels/frequencies */
-	range.num_channels = NUM_CHANNELS;
+	range->num_channels = NUM_CHANNELS;
 	k = 0;
 	for (i = 0; i < NUM_CHANNELS; i++) {
 		if (priv->channel_mask & (1 << i)) {
-			range.freq[k].i = i + 1;
-			range.freq[k].m = channel_frequency[i] * 100000;
-			range.freq[k].e = 1;
+			range->freq[k].i = i + 1;
+			range->freq[k].m = channel_frequency[i] * 100000;
+			range->freq[k].e = 1;
 			k++;
 		}
 		
 		if (k >= IW_MAX_FREQUENCIES)
 			break;
 	}
-	range.num_frequency = k;
+	range->num_frequency = k;
+
+	range->sensitivity = 3;
+
+	orinoco_lock(priv);
+	/* Group all operation that need locking here - Jean II */
+	/* Actually, as we just read a bunch of ints, we don't really
+	 * need any locking (writing an int is atomic) - Jean II */
+	mode = priv->iw_mode;
+	if (priv->has_wep) {
+		range->max_encoding_tokens = ORINOCO_MAX_KEYS;
 
-	range.sensitivity = 3;
+		range->encoding_size[0] = SMALL_KEY_SIZE;
+		range->num_encoding_sizes = 1;
+
+		if (priv->has_big_wep) {
+			range->encoding_size[1] = LARGE_KEY_SIZE;
+			range->num_encoding_sizes = 2;
+		}
+	} else {
+		// Already done in memset, don't redo it
+		range->num_encoding_sizes = 0;
+		range->max_encoding_tokens = 0;
+	}
+	orinoco_unlock(priv);
 
 	if ((mode == IW_MODE_ADHOC) && (priv->spy_number == 0)){
 		/* Quality stats meaningless in ad-hoc mode */
-		range.max_qual.qual = 0;
-		range.max_qual.level = 0;
-		range.max_qual.noise = 0;
+		range->max_qual.qual = 0;
+		range->max_qual.level = 0;
+		range->max_qual.noise = 0;
+		// Already done in memset, don't redo it
 #if WIRELESS_EXT > 11
-		range.avg_qual.qual = 0;
-		range.avg_qual.level = 0;
-		range.avg_qual.noise = 0;
+		range->avg_qual.qual = 0;
+		range->avg_qual.level = 0;
+		range->avg_qual.noise = 0;
 #endif /* WIRELESS_EXT > 11 */
 
 	} else {
-		range.max_qual.qual = 0x8b - 0x2f;
-		range.max_qual.level = 0x2f - 0x95 - 1;
-		range.max_qual.noise = 0x2f - 0x95 - 1;
+		range->max_qual.qual = 0x8b - 0x2f;
+		range->max_qual.level = 0x2f - 0x95 - 1;
+		range->max_qual.noise = 0x2f - 0x95 - 1;
 #if WIRELESS_EXT > 11
 		/* Need to get better values */
-		range.avg_qual.qual = 0x24;
-		range.avg_qual.level = 0xC2;
-		range.avg_qual.noise = 0x9E;
+		range->avg_qual.qual = 0x24;
+		range->avg_qual.level = 0xC2;
+		range->avg_qual.noise = 0x9E;
 #endif /* WIRELESS_EXT > 11 */
 	}
 
 	err = orinoco_hw_get_bitratelist(priv, &numrates,
-				       range.bitrate, IW_MAX_BITRATES);
+				       range->bitrate, IW_MAX_BITRATES);
 	if (err)
 		return err;
-	range.num_bitrates = numrates;
+	range->num_bitrates = numrates;
 	
 	/* Set an indication of the max TCP throughput in bit/s that we can
 	 * expect using this interface. May be use for QoS stuff...
 	 * Jean II */
 	if(numrates > 2)
-		range.throughput = 5 * 1000 * 1000;	/* ~5 Mb/s */
+		range->throughput = 5 * 1000 * 1000;	/* ~5 Mb/s */
 	else
-		range.throughput = 1.5 * 1000 * 1000;	/* ~1.5 Mb/s */
-
-	range.min_rts = 0;
-	range.max_rts = 2347;
-	range.min_frag = 256;
-	range.max_frag = 2346;
+		range->throughput = 1.5 * 1000 * 1000;	/* ~1.5 Mb/s */
 
-	orinoco_lock(priv);
-	if (priv->has_wep) {
-		range.max_encoding_tokens = ORINOCO_MAX_KEYS;
-
-		range.encoding_size[0] = SMALL_KEY_SIZE;
-		range.num_encoding_sizes = 1;
-
-		if (priv->has_big_wep) {
-			range.encoding_size[1] = LARGE_KEY_SIZE;
-			range.num_encoding_sizes = 2;
-		}
-	} else {
-		range.num_encoding_sizes = 0;
-		range.max_encoding_tokens = 0;
-	}
-	orinoco_unlock(priv);
-		
-	range.min_pmp = 0;
-	range.max_pmp = 65535000;
-	range.min_pmt = 0;
-	range.max_pmt = 65535 * 1000;	/* ??? */
-	range.pmp_flags = IW_POWER_PERIOD;
-	range.pmt_flags = IW_POWER_TIMEOUT;
-	range.pm_capa = IW_POWER_PERIOD | IW_POWER_TIMEOUT | IW_POWER_UNICAST_R;
-
-	range.num_txpower = 1;
-	range.txpower[0] = 15; /* 15dBm */
-	range.txpower_capa = IW_TXPOW_DBM;
+	range->min_rts = 0;
+	range->max_rts = 2347;
+	range->min_frag = 256;
+	range->max_frag = 2346;
+
+	range->min_pmp = 0;
+	range->max_pmp = 65535000;
+	range->min_pmt = 0;
+	range->max_pmt = 65535 * 1000;	/* ??? */
+	range->pmp_flags = IW_POWER_PERIOD;
+	range->pmt_flags = IW_POWER_TIMEOUT;
+	range->pm_capa = IW_POWER_PERIOD | IW_POWER_TIMEOUT | IW_POWER_UNICAST_R;
+
+	range->num_txpower = 1;
+	range->txpower[0] = 15; /* 15dBm */
+	range->txpower_capa = IW_TXPOW_DBM;
 
 #if WIRELESS_EXT > 10
-	range.retry_capa = IW_RETRY_LIMIT | IW_RETRY_LIFETIME;
-	range.retry_flags = IW_RETRY_LIMIT;
-	range.r_time_flags = IW_RETRY_LIFETIME;
-	range.min_retry = 0;
-	range.max_retry = 65535;	/* ??? */
-	range.min_r_time = 0;
-	range.max_r_time = 65535 * 1000;	/* ??? */
+	range->retry_capa = IW_RETRY_LIMIT | IW_RETRY_LIFETIME;
+	range->retry_flags = IW_RETRY_LIMIT;
+	range->r_time_flags = IW_RETRY_LIFETIME;
+	range->min_retry = 0;
+	range->max_retry = 65535;	/* ??? */
+	range->min_r_time = 0;
+	range->max_r_time = 65535 * 1000;	/* ??? */
 #endif /* WIRELESS_EXT > 10 */
 
-	if (copy_to_user(rrq->pointer, &range, sizeof(range)))
-		return -EFAULT;
-
 	TRACE_EXIT(dev->name);
 
 	return 0;
 }
 
-static int orinoco_ioctl_setiwencode(struct net_device *dev, struct iw_point *erq)
+static int orinoco_ioctl_setiwencode(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu,
+				     char *keybuf)
 {
 	struct orinoco_private *priv = dev->priv;
-	int index = (erq->flags & IW_ENCODE_INDEX) - 1;
+	int index = (wrqu->encoding.flags & IW_ENCODE_INDEX) - 1;
 	int setindex = priv->tx_key;
 	int enable = priv->wep_on;
 	int restricted = priv->wep_restrict;
 	u16 xlen = 0;
-	int err = 0;
-	char keybuf[ORINOCO_MAX_KEY_SIZE];
+	int err = -EINPROGRESS;		/* Call commit handler */
 	
-	if (erq->pointer) {
-		/* We actually have a key to set */
-		if ( (erq->length < SMALL_KEY_SIZE) || (erq->length > ORINOCO_MAX_KEY_SIZE) )
-			return -EINVAL;
-		
-		if (copy_from_user(keybuf, erq->pointer, erq->length))
-			return -EFAULT;
+	if (! priv->has_wep) {
+		return -EOPNOTSUPP;
 	}
-	
+
 	orinoco_lock(priv);
 	
-	if (erq->pointer) {
-		if (erq->length > ORINOCO_MAX_KEY_SIZE) {
-			err = -E2BIG;
-			goto out;
-		}
-		
-		if ( (erq->length > LARGE_KEY_SIZE)
-		     || ( ! priv->has_big_wep && (erq->length > SMALL_KEY_SIZE))  ) {
+	if (wrqu->encoding.length > 0) {
+		/* Check key size. Either it's small size, or it large (but
+		 * only if the device support large keys) - Jean II */
+		if ( (wrqu->encoding.length > LARGE_KEY_SIZE)
+		     || ( ! priv->has_big_wep &&
+			  (wrqu->encoding.length > SMALL_KEY_SIZE))  ) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -2314,9 +2398,9 @@ static int orinoco_ioctl_setiwencode(str
 		if ((index < 0) || (index >= ORINOCO_MAX_KEYS))
 			index = priv->tx_key;
 		
-		if (erq->length > SMALL_KEY_SIZE) {
+		if (wrqu->encoding.length > SMALL_KEY_SIZE) {
 			xlen = LARGE_KEY_SIZE;
-		} else if (erq->length > 0) {
+		} else if (wrqu->encoding.length > 0) {
 			xlen = SMALL_KEY_SIZE;
 		} else
 			xlen = 0;
@@ -2331,7 +2415,7 @@ static int orinoco_ioctl_setiwencode(str
 		 * we will arrive there with an index of -1. This is valid
 		 * but need to be taken care off... Jean II */
 		if ((index < 0) || (index >= ORINOCO_MAX_KEYS)) {
-			if((index != -1) || (erq->flags == 0)) {
+			if((index != -1) || (wrqu->encoding.flags == 0)) {
 				err = -EINVAL;
 				goto out;
 			}
@@ -2345,18 +2429,18 @@ static int orinoco_ioctl_setiwencode(str
 		}
 	}
 	
-	if (erq->flags & IW_ENCODE_DISABLED)
+	if (wrqu->encoding.flags & IW_ENCODE_DISABLED)
 		enable = 0;
 	/* Only for Prism2 & Symbol cards (so far) - Jean II */
-	if (erq->flags & IW_ENCODE_OPEN)
+	if (wrqu->encoding.flags & IW_ENCODE_OPEN)
 		restricted = 0;
-	if (erq->flags & IW_ENCODE_RESTRICTED)
+	if (wrqu->encoding.flags & IW_ENCODE_RESTRICTED)
 		restricted = 1;
 
-	if (erq->pointer) {
+	if (wrqu->encoding.length > 0) {
 		priv->keys[index].len = cpu_to_le16(xlen);
 		memset(priv->keys[index].data, 0, sizeof(priv->keys[index].data));
-		memcpy(priv->keys[index].data, keybuf, erq->length);
+		memcpy(priv->keys[index].data, keybuf, wrqu->encoding.length);
 	}
 	priv->tx_key = setindex;
 	priv->wep_on = enable;
@@ -2365,87 +2449,88 @@ static int orinoco_ioctl_setiwencode(str
  out:
 	orinoco_unlock(priv);
 
-	return 0;
+	return err;
 }
 
-static int orinoco_ioctl_getiwencode(struct net_device *dev, struct iw_point *erq)
+static int orinoco_ioctl_getiwencode(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu,
+				     char *keybuf)
 {
 	struct orinoco_private *priv = dev->priv;
-	int index = (erq->flags & IW_ENCODE_INDEX) - 1;
+	int index = (wrqu->encoding.flags & IW_ENCODE_INDEX) - 1;
 	u16 xlen = 0;
-	char keybuf[ORINOCO_MAX_KEY_SIZE];
-
 	
+	if (! priv->has_wep) {
+		return -EOPNOTSUPP;
+	}
+
 	orinoco_lock(priv);
 
 	if ((index < 0) || (index >= ORINOCO_MAX_KEYS))
 		index = priv->tx_key;
 
-	erq->flags = 0;
+	wrqu->encoding.flags = 0;
 	if (! priv->wep_on)
-		erq->flags |= IW_ENCODE_DISABLED;
-	erq->flags |= index + 1;
+		wrqu->encoding.flags |= IW_ENCODE_DISABLED;
+	wrqu->encoding.flags |= index + 1;
 	
 	/* Only for symbol cards - Jean II */
 	if (priv->firmware_type != FIRMWARE_TYPE_AGERE) {
 		if(priv->wep_restrict)
-			erq->flags |= IW_ENCODE_RESTRICTED;
+			wrqu->encoding.flags |= IW_ENCODE_RESTRICTED;
 		else
-			erq->flags |= IW_ENCODE_OPEN;
+			wrqu->encoding.flags |= IW_ENCODE_OPEN;
 	}
 
 	xlen = le16_to_cpu(priv->keys[index].len);
 
-	erq->length = xlen;
+	wrqu->encoding.length = xlen;
 
-	if (erq->pointer) {
-		memcpy(keybuf, priv->keys[index].data, ORINOCO_MAX_KEY_SIZE);
-	}
+	memcpy(keybuf, priv->keys[index].data, ORINOCO_MAX_KEY_SIZE);
 	
 	orinoco_unlock(priv);
 
-	if (erq->pointer) {
-		if (copy_to_user(erq->pointer, keybuf, xlen))
-			return -EFAULT;
-	}
-
 	return 0;
 }
 
-static int orinoco_ioctl_setessid(struct net_device *dev, struct iw_point *erq)
+static int orinoco_ioctl_setessid(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *essidbuf)
 {
 	struct orinoco_private *priv = dev->priv;
-	char essidbuf[IW_ESSID_MAX_SIZE+1];
 
 	/* Note : ESSID is ignored in Ad-Hoc demo mode, but we can set it
 	 * anyway... - Jean II */
 
-	memset(&essidbuf, 0, sizeof(essidbuf));
-
-	if (erq->flags) {
-		if (erq->length > IW_ESSID_MAX_SIZE)
-			return -E2BIG;
+	/* Hum... Should not use Wireless Extension constant (may change),
+	 * should use our own... - Jean II */
+	if (wrqu->essid.length > IW_ESSID_MAX_SIZE)
+		return -E2BIG;
 		
-		if (copy_from_user(&essidbuf, erq->pointer, erq->length))
-			return -EFAULT;
-
-		essidbuf[erq->length] = '\0';
-	}
-
 	orinoco_lock(priv);
 
-	memcpy(priv->desired_essid, essidbuf, sizeof(priv->desired_essid));
+	/* NULL the string (for NULL termination & ESSID = ANY) - Jean II */
+	memset(priv->desired_essid, 0, sizeof(priv->desired_essid));
+
+	/* If not ANY, get the new ESSID */
+	if (wrqu->essid.flags) {
+		memcpy(priv->desired_essid, essidbuf, wrqu->essid.length);
+	}
 
 	orinoco_unlock(priv);
 
-	return 0;
+	return -EINPROGRESS;		/* Call commit handler */
 }
 
-static int orinoco_ioctl_getessid(struct net_device *dev, struct iw_point *erq)
+static int orinoco_ioctl_getessid(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *essidbuf)
 {
 	struct orinoco_private *priv = dev->priv;
-	char essidbuf[IW_ESSID_MAX_SIZE+1];
-	int active;
+	int active;	/* ??? */
 	int err = 0;
 
 	TRACE_ENTER(dev->name);
@@ -2454,59 +2539,55 @@ static int orinoco_ioctl_getessid(struct
 	if (err)
 		return err;
 
-	erq->flags = 1;
-	erq->length = strlen(essidbuf) + 1;
-	if (erq->pointer)
-		if ( copy_to_user(erq->pointer, essidbuf, erq->length) )
-			return -EFAULT;
+	wrqu->essid.flags = 1;
+	wrqu->essid.length = strlen(essidbuf) + 1;
 
 	TRACE_EXIT(dev->name);
 	
 	return 0;
 }
 
-static int orinoco_ioctl_setnick(struct net_device *dev, struct iw_point *nrq)
+static int orinoco_ioctl_setnick(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *nickbuf)
 {
 	struct orinoco_private *priv = dev->priv;
-	char nickbuf[IW_ESSID_MAX_SIZE+1];
 
-	if (nrq->length > IW_ESSID_MAX_SIZE)
+	if (wrqu->essid.length > IW_ESSID_MAX_SIZE)
 		return -E2BIG;
 
-	memset(nickbuf, 0, sizeof(nickbuf));
-
-	if (copy_from_user(nickbuf, nrq->pointer, nrq->length))
-		return -EFAULT;
-
-	nickbuf[nrq->length] = '\0';
-	
 	orinoco_lock(priv);
 
-	memcpy(priv->nick, nickbuf, sizeof(priv->nick));
+	memset(priv->nick, 0, sizeof(priv->nick));
+
+	memcpy(priv->nick, nickbuf, wrqu->essid.length);
 
 	orinoco_unlock(priv);
 
-	return 0;
+	return -EINPROGRESS;		/* Call commit handler */
 }
 
-static int orinoco_ioctl_getnick(struct net_device *dev, struct iw_point *nrq)
+static int orinoco_ioctl_getnick(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *nickbuf)
 {
 	struct orinoco_private *priv = dev->priv;
-	char nickbuf[IW_ESSID_MAX_SIZE+1];
 
 	orinoco_lock(priv);
 	memcpy(nickbuf, priv->nick, IW_ESSID_MAX_SIZE+1);
 	orinoco_unlock(priv);
 
-	nrq->length = strlen(nickbuf)+1;
-
-	if (copy_to_user(nrq->pointer, nickbuf, sizeof(nickbuf)))
-		return -EFAULT;
+	wrqu->essid.length = strlen(nickbuf) + 1;
 
 	return 0;
 }
 
-static int orinoco_ioctl_setfreq(struct net_device *dev, struct iw_freq *frq)
+static int orinoco_ioctl_setfreq(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	int chan = -1;
@@ -2517,19 +2598,19 @@ static int orinoco_ioctl_setfreq(struct 
 	if (priv->iw_mode != IW_MODE_ADHOC)
 		return -EOPNOTSUPP;
 
-	if ( (frq->e == 0) && (frq->m <= 1000) ) {
+	if ( (wrqu->freq.e == 0) && (wrqu->freq.m <= 1000) ) {
 		/* Setting by channel number */
-		chan = frq->m;
+		chan = wrqu->freq.m;
 	} else {
 		/* Setting by frequency - search the table */
 		int mult = 1;
 		int i;
 
-		for (i = 0; i < (6 - frq->e); i++)
+		for (i = 0; i < (6 - wrqu->freq.e); i++)
 			mult *= 10;
 
 		for (i = 0; i < NUM_CHANNELS; i++)
-			if (frq->m == (channel_frequency[i] * mult))
+			if (wrqu->freq.m == (channel_frequency[i] * mult))
 				chan = i+1;
 	}
 
@@ -2541,10 +2622,26 @@ static int orinoco_ioctl_setfreq(struct 
 	priv->channel = chan;
 	orinoco_unlock(priv);
 
+	return -EINPROGRESS;		/* Call commit handler */
+}
+
+static int orinoco_ioctl_getfreq(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	/* Locking done in there */
+	wrqu->freq.m = orinoco_hw_get_freq(priv);
+	wrqu->freq.e = 1;
 	return 0;
 }
 
-static int orinoco_ioctl_getsens(struct net_device *dev, struct iw_param *srq)
+static int orinoco_ioctl_getsens(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
@@ -2558,16 +2655,19 @@ static int orinoco_ioctl_getsens(struct 
 	if (err)
 		return err;
 
-	srq->value = val;
-	srq->fixed = 0; /* auto */
+	wrqu->sens.value = val;
+	wrqu->sens.fixed = 0; /* auto */
 
 	return 0;
 }
 
-static int orinoco_ioctl_setsens(struct net_device *dev, struct iw_param *srq)
+static int orinoco_ioctl_setsens(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int val = srq->value;
+	int val = wrqu->sens.value;
 
 	if ((val < 1) || (val > 3))
 		return -EINVAL;
@@ -2576,15 +2676,18 @@ static int orinoco_ioctl_setsens(struct 
 	priv->ap_density = val;
 	orinoco_unlock(priv);
 
-	return 0;
+	return -EINPROGRESS;		/* Call commit handler */
 }
 
-static int orinoco_ioctl_setrts(struct net_device *dev, struct iw_param *rrq)
+static int orinoco_ioctl_setrts(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int val = rrq->value;
+	int val = wrqu->rts.value;
 
-	if (rrq->disabled)
+	if (wrqu->rts.disabled)
 		val = 2347;
 
 	if ( (val < 0) || (val > 2347) )
@@ -2594,33 +2697,51 @@ static int orinoco_ioctl_setrts(struct n
 	priv->rts_thresh = val;
 	orinoco_unlock(priv);
 
+	return -EINPROGRESS;		/* Call commit handler */
+}
+
+static int orinoco_ioctl_getrts(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	wrqu->rts.value = priv->rts_thresh;
+	wrqu->rts.disabled = (wrqu->rts.value == 2347);
+	wrqu->rts.fixed = 1;
 	return 0;
 }
 
-static int orinoco_ioctl_setfrag(struct net_device *dev, struct iw_param *frq)
+static int orinoco_ioctl_setfrag(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int err = 0;
+	int err = -EINPROGRESS;		/* Call commit handler */
 
 	orinoco_lock(priv);
 
 	if (priv->has_mwo) {
-		if (frq->disabled)
+		if (wrqu->frag.disabled)
 			priv->mwo_robust = 0;
 		else {
-			if (frq->fixed)
+			if (wrqu->frag.fixed)
 				printk(KERN_WARNING "%s: Fixed fragmentation not \
 supported on this firmware. Using MWO robust instead.\n", dev->name);
 			priv->mwo_robust = 1;
 		}
 	} else {
-		if (frq->disabled)
+		if (wrqu->frag.disabled)
 			priv->frag_thresh = 2346;
 		else {
-			if ( (frq->value < 256) || (frq->value > 2346) )
+			if ( (wrqu->frag.value < 256) ||
+			     (wrqu->frag.value > 2346) )
 				err = -EINVAL;
 			else
-				priv->frag_thresh = frq->value & ~0x1; /* must be even */
+				/* value must be even */
+				priv->frag_thresh = wrqu->frag.value & ~0x1;
 		}
 	}
 
@@ -2629,7 +2750,10 @@ supported on this firmware. Using MWO ro
 	return err;
 }
 
-static int orinoco_ioctl_getfrag(struct net_device *dev, struct iw_param *frq)
+static int orinoco_ioctl_getfrag(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
@@ -2645,18 +2769,18 @@ static int orinoco_ioctl_getfrag(struct 
 		if (err)
 			val = 0;
 
-		frq->value = val ? 2347 : 0;
-		frq->disabled = ! val;
-		frq->fixed = 0;
+		wrqu->frag.value = val ? 2347 : 0;
+		wrqu->frag.disabled = ! val;
+		wrqu->frag.fixed = 0;
 	} else {
 		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CNFFRAGMENTATIONTHRESHOLD,
 					  &val);
 		if (err)
 			val = 0;
 
-		frq->value = val;
-		frq->disabled = (val >= 2346);
-		frq->fixed = 1;
+		wrqu->frag.value = val;
+		wrqu->frag.disabled = (val >= 2346);
+		wrqu->frag.fixed = 1;
 	}
 
 	orinoco_unlock(priv);
@@ -2664,21 +2788,24 @@ static int orinoco_ioctl_getfrag(struct 
 	return err;
 }
 
-static int orinoco_ioctl_setrate(struct net_device *dev, struct iw_param *rrq)
+static int orinoco_ioctl_setrate(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int err = 0;
+	int err = -EINPROGRESS;		/* Call commit handler */
 	int ratemode = -1;
 	int bitrate; /* 100s of kilobits */
 	int i;
 	
 	/* As the user space doesn't know our highest rate, it uses
 	 * -1 to ask us to set the highest rate - Jean II */
-	if(rrq->value == -1)
+	if(wrqu->bitrate.value == -1)
 		bitrate = 110;
 	else {
-		bitrate = rrq->value / 100000;
-		if (rrq->value % 100000)
+		bitrate = wrqu->bitrate.value / 100000;
+		if (wrqu->bitrate.value % 100000)
 			return -EINVAL;
 	}
 
@@ -2688,7 +2815,7 @@ static int orinoco_ioctl_setrate(struct 
 
 	for (i = 0; i < BITRATE_TABLE_SIZE; i++)
 		if ( (bitrate_table[i].bitrate == bitrate) &&
-		     (bitrate_table[i].automatic == ! rrq->fixed) ) {
+		     (bitrate_table[i].automatic == ! wrqu->bitrate.fixed) ) {
 			ratemode = i;
 			break;
 		}
@@ -2703,7 +2830,10 @@ static int orinoco_ioctl_setrate(struct 
 	return err;
 }
 
-static int orinoco_ioctl_getrate(struct net_device *dev, struct iw_param *rrq)
+static int orinoco_ioctl_getrate(struct net_device *dev,
+				 struct iw_request_info *info,
+				 union iwreq_data *wrqu,
+				 char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
@@ -2722,9 +2852,9 @@ static int orinoco_ioctl_getrate(struct 
 	/* The firmware will tell us the current rate, but won't tell
 	 * us if it's automatic or not, so we need to remember what we
 	 * set - Jean II */
-	rrq->fixed = ! bitrate_table[ratemode].automatic;
-	rrq->value = bitrate_table[ratemode].bitrate * 100000;
-	rrq->disabled = 0;
+	wrqu->bitrate.fixed = ! bitrate_table[ratemode].automatic;
+	wrqu->bitrate.value = bitrate_table[ratemode].bitrate * 100000;
+	wrqu->bitrate.disabled = 0;
 
 	if (netif_running(dev)) {
 		/* If the device is actually operation we try to find more,
@@ -2742,9 +2872,9 @@ static int orinoco_ioctl_getrate(struct 
 			 * encoding of HERMES_RID_CNFTXRATECONTROL.
 			 * Don't forget that 6Mb/s is really 5.5Mb/s */
 			if(val == 6)
-				rrq->value = 5500000;
+				wrqu->bitrate.value = 5500000;
 			else
-				rrq->value = val * 1000000;
+				wrqu->bitrate.value = val * 1000000;
 			break;
 		case FIRMWARE_TYPE_INTERSIL: /* Intersil style rate */
 		case FIRMWARE_TYPE_SYMBOL: /* Symbol style rate */
@@ -2756,7 +2886,7 @@ static int orinoco_ioctl_getrate(struct 
 			if (i >= BITRATE_TABLE_SIZE)
 				printk(KERN_INFO "%s: Unable to determine current bitrate (0x%04hx)\n",
 				       dev->name, val);
-			rrq->value = bitrate_table[ratemode].bitrate * 100000;
+			wrqu->bitrate.value = bitrate_table[ratemode].bitrate * 100000;
 			break;
 		default:
 			BUG();
@@ -2769,18 +2899,20 @@ static int orinoco_ioctl_getrate(struct 
 	return err;
 }
 
-static int orinoco_ioctl_setpower(struct net_device *dev, struct iw_param *prq)
+static int orinoco_ioctl_setpower(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int err = 0;
-
+	int err = -EINPROGRESS;		/* Call commit handler */
 
 	orinoco_lock(priv);
 
-	if (prq->disabled) {
+	if (wrqu->power.disabled) {
 		priv->pm_on = 0;
 	} else {
-		switch (prq->flags & IW_POWER_MODE) {
+		switch (wrqu->power.flags & IW_POWER_MODE) {
 		case IW_POWER_UNICAST_R:
 			priv->pm_mcast = 0;
 			priv->pm_on = 1;
@@ -2798,13 +2930,13 @@ static int orinoco_ioctl_setpower(struct
 		if (err)
 			goto out;
 		
-		if (prq->flags & IW_POWER_TIMEOUT) {
+		if (wrqu->power.flags & IW_POWER_TIMEOUT) {
 			priv->pm_on = 1;
-			priv->pm_timeout = prq->value / 1000;
+			priv->pm_timeout = wrqu->power.value / 1000;
 		}
-		if (prq->flags & IW_POWER_PERIOD) {
+		if (wrqu->power.flags & IW_POWER_PERIOD) {
 			priv->pm_on = 1;
-			priv->pm_period = prq->value / 1000;
+			priv->pm_period = wrqu->power.value / 1000;
 		}
 		/* It's valid to not have a value if we are just toggling
 		 * the flags... Jean II */
@@ -2820,7 +2952,10 @@ static int orinoco_ioctl_setpower(struct
 	return err;
 }
 
-static int orinoco_ioctl_getpower(struct net_device *dev, struct iw_param *prq)
+static int orinoco_ioctl_getpower(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
@@ -2846,19 +2981,19 @@ static int orinoco_ioctl_getpower(struct
 	if (err)
 		goto out;
 
-	prq->disabled = !enable;
+	wrqu->power.disabled = !enable;
 	/* Note : by default, display the period */
-	if ((prq->flags & IW_POWER_TYPE) == IW_POWER_TIMEOUT) {
-		prq->flags = IW_POWER_TIMEOUT;
-		prq->value = timeout * 1000;
+	if ((wrqu->power.flags & IW_POWER_TYPE) == IW_POWER_TIMEOUT) {
+		wrqu->power.flags = IW_POWER_TIMEOUT;
+		wrqu->power.value = timeout * 1000;
 	} else {
-		prq->flags = IW_POWER_PERIOD;
-		prq->value = period * 1000;
+		wrqu->power.flags = IW_POWER_PERIOD;
+		wrqu->power.value = period * 1000;
 	}
 	if (mcast)
-		prq->flags |= IW_POWER_ALL_R;
+		wrqu->power.flags |= IW_POWER_ALL_R;
 	else
-		prq->flags |= IW_POWER_UNICAST_R;
+		wrqu->power.flags |= IW_POWER_UNICAST_R;
 
  out:
 	orinoco_unlock(priv);
@@ -2866,8 +3001,24 @@ static int orinoco_ioctl_getpower(struct
 	return err;
 }
 
+static int orinoco_ioctl_gettxpower(struct net_device *dev,
+				    struct iw_request_info *info,
+				    union iwreq_data *wrqu,
+				    char *extra)
+{
+	/* The card only supports one tx power, so this is easy */
+	wrqu->txpower.value = 15; /* dBm */
+	wrqu->txpower.fixed = 1;
+	wrqu->txpower.disabled = 0;
+	wrqu->txpower.flags = IW_TXPOW_DBM;
+	return 0;
+}
+
 #if WIRELESS_EXT > 10
-static int orinoco_ioctl_getretry(struct net_device *dev, struct iw_param *rrq)
+static int orinoco_ioctl_getretry(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
@@ -2891,22 +3042,22 @@ static int orinoco_ioctl_getretry(struct
 	if (err)
 		goto out;
 
-	rrq->disabled = 0;		/* Can't be disabled */
+	wrqu->retry.disabled = 0;		/* Can't be disabled */
 
 	/* Note : by default, display the retry number */
-	if ((rrq->flags & IW_RETRY_TYPE) == IW_RETRY_LIFETIME) {
-		rrq->flags = IW_RETRY_LIFETIME;
-		rrq->value = lifetime * 1000;	/* ??? */
+	if ((wrqu->retry.flags & IW_RETRY_TYPE) == IW_RETRY_LIFETIME) {
+		wrqu->retry.flags = IW_RETRY_LIFETIME;
+		wrqu->retry.value = lifetime * 1000;	/* ??? */
 	} else {
 		/* By default, display the min number */
-		if ((rrq->flags & IW_RETRY_MAX)) {
-			rrq->flags = IW_RETRY_LIMIT | IW_RETRY_MAX;
-			rrq->value = long_limit;
+		if ((wrqu->retry.flags & IW_RETRY_MAX)) {
+			wrqu->retry.flags = IW_RETRY_LIMIT | IW_RETRY_MAX;
+			wrqu->retry.value = long_limit;
 		} else {
-			rrq->flags = IW_RETRY_LIMIT;
-			rrq->value = short_limit;
+			wrqu->retry.flags = IW_RETRY_LIMIT;
+			wrqu->retry.value = short_limit;
 			if(short_limit != long_limit)
-				rrq->flags |= IW_RETRY_MIN;
+				wrqu->retry.flags |= IW_RETRY_MIN;
 		}
 	}
 
@@ -2917,10 +3068,36 @@ static int orinoco_ioctl_getretry(struct
 }
 #endif /* WIRELESS_EXT > 10 */
 
-static int orinoco_ioctl_setibssport(struct net_device *dev, struct iwreq *wrq)
+static int orinoco_ioctl_reset(struct net_device *dev,
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu,
+			       char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	if (! capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	printk(KERN_DEBUG "%s: Forcing reset!\n", dev->name);
+
+	/* COR reset as needed */
+	if((info->cmd == (SIOCIWFIRSTPRIV + 0x1)) &&
+	   (priv->card_reset_handler != NULL))
+		priv->card_reset_handler(priv);
+
+	/* Firmware reset */
+	orinoco_reset(priv);
+
+	return 0;
+}
+
+static int orinoco_ioctl_setibssport(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu,
+				     char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int val = *( (int *) wrq->u.name );
+	int val = *( (int *) extra );
 
 	orinoco_lock(priv);
 	priv->ibss_port = val ;
@@ -2929,13 +3106,16 @@ static int orinoco_ioctl_setibssport(str
 	set_port_type(priv);
 
 	orinoco_unlock(priv);
-	return 0;
+	return -EINPROGRESS;		/* Call commit handler */
 }
 
-static int orinoco_ioctl_getibssport(struct net_device *dev, struct iwreq *wrq)
+static int orinoco_ioctl_getibssport(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu,
+				     char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int *val = (int *)wrq->u.name;
+	int *val = (int *) extra;
 
 	orinoco_lock(priv);
 	*val = priv->ibss_port;
@@ -2944,11 +3124,14 @@ static int orinoco_ioctl_getibssport(str
 	return 0;
 }
 
-static int orinoco_ioctl_setport3(struct net_device *dev, struct iwreq *wrq)
+static int orinoco_ioctl_setport3(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int val = *( (int *) wrq->u.name );
-	int err = 0;
+	int val = *( (int *) extra );
+	int err = -EINPROGRESS;		/* Call commit handler */
 
 	orinoco_lock(priv);
 	switch (val) {
@@ -2984,10 +3167,13 @@ static int orinoco_ioctl_setport3(struct
 	return err;
 }
 
-static int orinoco_ioctl_getport3(struct net_device *dev, struct iwreq *wrq)
+static int orinoco_ioctl_getport3(struct net_device *dev,
+				  struct iw_request_info *info,
+				  union iwreq_data *wrqu,
+				  char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	int *val = (int *)wrq->u.name;
+	int *val = (int *) extra;
 
 	orinoco_lock(priv);
 	*val = priv->prefer_port3;
@@ -2996,26 +3182,64 @@ static int orinoco_ioctl_getport3(struct
 	return 0;
 }
 
+static int orinoco_ioctl_setpreamble(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu,
+				     char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	/* 802.11b has recently defined some short preamble.
+	 * Basically, the Phy header has been reduced in size.
+	 * This increase performance, especially at high rates
+	 * (the preamble is transmitted at 1Mb/s), unfortunately
+	 * this give compatibility troubles... - Jean II */
+	if(priv->has_preamble) {
+		int val = *( (int *) extra );
+
+		orinoco_lock(priv);
+		if(val)
+			priv->preamble = 1;
+		else
+			priv->preamble = 0;
+		orinoco_unlock(priv);
+
+		return -EINPROGRESS;		/* Call commit handler */
+	} else
+		return -EOPNOTSUPP;
+}
+
+static int orinoco_ioctl_getpreamble(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu,
+				     char *extra)
+{
+	struct orinoco_private *priv = dev->priv;
+
+	if(priv->has_preamble) {
+		int *val = (int *) extra;
+
+		orinoco_lock(priv);
+		*val = priv->preamble;
+		orinoco_unlock(priv);
+
+		return 0;
+	} else
+		return -EOPNOTSUPP;
+}
+
 /* Spy is used for link quality/strength measurements in Ad-Hoc mode
  * Jean II */
-static int orinoco_ioctl_setspy(struct net_device *dev, struct iw_point *srq)
+static int orinoco_ioctl_setspy(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	struct sockaddr address[IW_MAX_SPY];
-	int number = srq->length;
+	struct sockaddr *address = (struct sockaddr *) extra;
+	int number = wrqu->data.length;
 	int i;
-	int err = 0;
-
-	/* Check the number of addresses */
-	if (number > IW_MAX_SPY)
-		return -E2BIG;
-
-	/* Get the data in the driver */
-	if (srq->pointer) {
-		if (copy_from_user(address, srq->pointer,
-				   sizeof(struct sockaddr) * number))
-			return -EFAULT;
-	}
+	int err = 0;	/* Do NOT call commit handler */
 
 	/* Make sure nobody mess with the structure while we do */
 	orinoco_lock(priv);
@@ -3052,55 +3276,176 @@ static int orinoco_ioctl_setspy(struct n
 	return err;
 }
 
-static int orinoco_ioctl_getspy(struct net_device *dev, struct iw_point *srq)
+static int orinoco_ioctl_getspy(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *extra)
 {
 	struct orinoco_private *priv = dev->priv;
-	struct sockaddr address[IW_MAX_SPY];
-	struct iw_quality spy_stat[IW_MAX_SPY];
+	struct sockaddr *address = (struct sockaddr *) extra;
 	int number;
 	int i;
 
 	orinoco_lock(priv);
 
 	number = priv->spy_number;
-	if ((number > 0) && (srq->pointer)) {
-		/* Create address struct */
-		for (i = 0; i < number; i++) {
-			memcpy(address[i].sa_data, priv->spy_address[i],
-			       ETH_ALEN);
-			address[i].sa_family = AF_UNIX;
-		}
+	/* Create address struct */
+	for (i = 0; i < number; i++) {
+		memcpy(address[i].sa_data, priv->spy_address[i],
+		       ETH_ALEN);
+		address[i].sa_family = AF_UNIX;
+	}
+	if (number > 0) {
 		/* Copy stats */
 		/* In theory, we should disable irqs while copying the stats
 		 * because the rx path migh update it in the middle...
 		 * Bah, who care ? - Jean II */
-		memcpy(&spy_stat, priv->spy_stat,
-		       sizeof(struct iw_quality) * IW_MAX_SPY);
-		for (i=0; i < number; i++)
-			priv->spy_stat[i].updated = 0;
+		memcpy(extra  + (sizeof(struct sockaddr) * number),
+		        priv->spy_stat, sizeof(struct iw_quality) * number);
 	}
+	/* Reset updated flags. */
+	for (i=0; i < number; i++)
+		priv->spy_stat[i].updated = 0;
 
 	orinoco_unlock(priv);
 
-	/* Push stuff to user space */
-	srq->length = number;
-	if(copy_to_user(srq->pointer, address,
-			 sizeof(struct sockaddr) * number))
-		return -EFAULT;
-	if(copy_to_user(srq->pointer + (sizeof(struct sockaddr)*number),
-			&spy_stat, sizeof(struct iw_quality) * number))
-		return -EFAULT;
+	wrqu->data.length = number;
 
 	return 0;
 }
 
+/* Commit handler, called after a bunch of SET operation */
+static int orinoco_ioctl_commit(struct net_device *dev,
+				struct iw_request_info *info,	/* NULL */
+				union iwreq_data *wrqu,		/* NULL */
+				char *extra)			/* NULL */
+{
+	struct orinoco_private *priv = dev->priv;
+	int err = 0;
+
+	DEBUG(1, "%s: commit\n", dev->name);
+
+	err = orinoco_reset(priv);
+	if (err) {
+		/* Ouch ! What are we supposed to do ? */
+		printk(KERN_ERR "orinoco_cs: Failed to set parameters on %s\n",
+		       dev->name);
+		netif_stop_queue(dev);
+		orinoco_shutdown(priv);
+		priv->hw_ready = 0;
+	}
+
+	return err;
+}
+
+static const struct iw_priv_args orinoco_privtab[] = {
+	{ SIOCIWFIRSTPRIV + 0x0, 0, 0, "force_reset" },
+	{ SIOCIWFIRSTPRIV + 0x1, 0, 0, "card_reset" },
+	{ SIOCIWFIRSTPRIV + 0x2,
+	  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	  0, "set_port3" },
+	{ SIOCIWFIRSTPRIV + 0x3, 0,
+	  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	  "get_port3" },
+	{ SIOCIWFIRSTPRIV + 0x4,
+	  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	  0, "set_preamble" },
+	{ SIOCIWFIRSTPRIV + 0x5, 0,
+	  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	  "get_preamble" },
+	{ SIOCIWFIRSTPRIV + 0x6,
+	  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	  0, "set_ibssport" },
+	{ SIOCIWFIRSTPRIV + 0x7, 0,
+	  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	  "get_ibssport" }
+};
+
+#if WIRELESS_EXT > 12
+
+/*
+ * Structures to export the Wireless Handlers
+ */
+
+static const iw_handler		orinoco_handler[] =
+{
+	orinoco_ioctl_commit,		/* SIOCSIWCOMMIT */
+	orinoco_ioctl_getname,		/* SIOCGIWNAME */
+	NULL,				/* SIOCSIWNWID */
+	NULL,				/* SIOCGIWNWID */
+	orinoco_ioctl_setfreq,		/* SIOCSIWFREQ */
+	orinoco_ioctl_getfreq,		/* SIOCGIWFREQ */
+	orinoco_ioctl_setmode,		/* SIOCSIWMODE */
+	orinoco_ioctl_getmode,		/* SIOCGIWMODE */
+	orinoco_ioctl_setsens,		/* SIOCSIWSENS */
+	orinoco_ioctl_getsens,		/* SIOCGIWSENS */
+	NULL,				/* SIOCSIWRANGE */
+	orinoco_ioctl_getiwrange,	/* SIOCGIWRANGE */
+	NULL,				/* SIOCSIWPRIV */
+	NULL,				/* SIOCGIWPRIV */
+	NULL,				/* SIOCSIWSTATS */
+	NULL,				/* SIOCGIWSTATS */
+	orinoco_ioctl_setspy,		/* SIOCSIWSPY */
+	orinoco_ioctl_getspy,		/* SIOCGIWSPY */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCSIWAP */
+	orinoco_ioctl_getwap,		/* SIOCGIWAP */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCGIWAPLIST */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	orinoco_ioctl_setessid,		/* SIOCSIWESSID */
+	orinoco_ioctl_getessid,		/* SIOCGIWESSID */
+	orinoco_ioctl_setnick,		/* SIOCSIWNICKN */
+	orinoco_ioctl_getnick,		/* SIOCGIWNICKN */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	orinoco_ioctl_setrate,		/* SIOCSIWRATE */
+	orinoco_ioctl_getrate,		/* SIOCGIWRATE */
+	orinoco_ioctl_setrts,		/* SIOCSIWRTS */
+	orinoco_ioctl_getrts,		/* SIOCGIWRTS */
+	orinoco_ioctl_setfrag,		/* SIOCSIWFRAG */
+	orinoco_ioctl_getfrag,		/* SIOCGIWFRAG */
+	NULL,				/* SIOCSIWTXPOW */
+	orinoco_ioctl_gettxpower,	/* SIOCGIWTXPOW */
+	NULL,				/* SIOCSIWRETRY */
+	orinoco_ioctl_getretry,		/* SIOCGIWRETRY */
+	orinoco_ioctl_setiwencode,	/* SIOCSIWENCODE */
+	orinoco_ioctl_getiwencode,	/* SIOCGIWENCODE */
+	orinoco_ioctl_setpower,		/* SIOCSIWPOWER */
+	orinoco_ioctl_getpower,		/* SIOCGIWPOWER */
+};
+
+static const iw_handler		orinoco_private_handler[] =
+{
+	orinoco_ioctl_reset,		/* SIOCIWFIRSTPRIV */
+	orinoco_ioctl_reset,		/* SIOCIWFIRSTPRIV + 1 */
+	orinoco_ioctl_setport3,		/* SIOCIWFIRSTPRIV + 2 */
+	orinoco_ioctl_getport3,		/* SIOCIWFIRSTPRIV + 3 */
+	orinoco_ioctl_setpreamble,	/* SIOCIWFIRSTPRIV + 4 */
+	orinoco_ioctl_getpreamble,	/* SIOCIWFIRSTPRIV + 5 */
+	orinoco_ioctl_setibssport,	/* SIOCIWFIRSTPRIV + 6 */
+	orinoco_i
--5p8PegU4iirBW1oA--
