Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbTEBBgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTEBBgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:36:50 -0400
Received: from palrel13.hp.com ([156.153.255.238]:30676 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262863AbTEBBfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:35:34 -0400
Date: Thu, 1 May 2003 18:47:56 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] WE-16 for Wavelan Pcmcia driver
Message-ID: <20030502014756.GD8753@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi Jeff,

        This patch update the Wavelan Pcmcia driver for Wireless
Extensions 16, and also remove all the backward compatibility cruft
that is broken anyway.

        Have fun...

        Jean


diff -u -p linux/drivers/net/wireless/wavelan_cs.15.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net/wireless/wavelan_cs.15.p.h	Thu May  1 18:31:34 2003
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Thu May  1 18:32:19 2003
@@ -443,9 +443,7 @@
 
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Wireless extensions */
-#if WIRELESS_EXT > 12
-#include <net/iw_handler.h>
-#endif	/* WIRELESS_EXT > 12 */
+#include <net/iw_handler.h>		/* New driver API */
 #endif
 
 /* Pcmcia headers that we need */
@@ -527,13 +525,6 @@ static const char *version = "wavelan_cs
 
 /* ------------------------ PRIVATE IOCTL ------------------------ */
 
-/* Wireless Extension Backward compatibility - Jean II
- * If the new wireless device private ioctl range is not defined,
- * default to standard device private ioctl range */
-#ifndef SIOCIWFIRSTPRIV
-#define SIOCIWFIRSTPRIV	SIOCDEVPRIVATE
-#endif /* SIOCIWFIRSTPRIV */
-
 #define SIOCSIPQTHR	SIOCIWFIRSTPRIV		/* Set quality threshold */
 #define SIOCGIPQTHR	SIOCIWFIRSTPRIV + 1	/* Get quality threshold */
 #define SIOCSIPROAM     SIOCIWFIRSTPRIV + 2	/* Set roaming state */
@@ -605,16 +596,6 @@ typedef struct iw_freq		iw_freq;
 typedef struct net_local	net_local;
 typedef struct timer_list	timer_list;
 
-#if WIRELESS_EXT <= 12
-/* Wireless extensions backward compatibility */
-/* Part of iw_handler prototype we need */
-struct iw_request_info
-{
-	__u16		cmd;		/* Wireless Extension command */
-	__u16		flags;		/* More to come ;-) */
-};
-#endif	/* WIRELESS_EXT <= 12 */
-
 /* Basic types */
 typedef u_char		mac_addr[WAVELAN_ADDR_SIZE];	/* Hardware address */
 
@@ -647,13 +628,10 @@ struct net_local
 
 #ifdef WIRELESS_EXT
   iw_stats	wstats;		/* Wireless specific stats */
+
+  struct iw_spy_data	spy_data;
 #endif
 
-#ifdef WIRELESS_SPY
-  int		spy_number;		/* Number of addresses to spy */
-  mac_addr	spy_address[IW_MAX_SPY];	/* The addresses to spy */
-  iw_qual	spy_stat[IW_MAX_SPY];		/* Statistics gathered */
-#endif	/* WIRELESS_SPY */
 #ifdef HISTOGRAM
   int		his_number;		/* Number of intervals */
   u_char	his_range[16];		/* Boundaries of interval ]n-1; n] */
diff -u -p linux/drivers/net/wireless/wavelan_cs.15.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless/wavelan_cs.15.c	Thu May  1 18:31:27 2003
+++ linux/drivers/net/wireless/wavelan_cs.c	Thu May  1 18:32:19 2003
@@ -1757,10 +1757,8 @@ wv_frequency_list(u_long	base,	/* i/o po
   u_short	table[10];	/* Authorized frequency table */
   long		freq = 0L;	/* offset to 2.4 GHz in .5 MHz + 12 MHz */
   int		i;		/* index in the table */
-#if WIRELESS_EXT > 7
   const int	BAND_NUM = 10;	/* Number of bands */
   int		c = 0;		/* Channel number */
-#endif /* WIRELESS_EXT */
 
   /* Read the frequency table */
   fee_read(base, 0x71 /* frequency table */,
@@ -1772,13 +1770,11 @@ wv_frequency_list(u_long	base,	/* i/o po
     /* Look in the table if the frequency is allowed */
     if(table[9 - (freq / 16)] & (1 << (freq % 16)))
       {
-#if WIRELESS_EXT > 7
 	/* Compute approximate channel number */
 	while((((channel_bands[c] >> 1) - 24) < freq) &&
 	      (c < BAND_NUM))
 	  c++;
 	list[i].i = c;	/* Set the list index */
-#endif /* WIRELESS_EXT */
 
 	/* put in the list */
 	list[i].m = (((freq + 24) * 5) + 24000L) * 10000;
@@ -1792,7 +1788,7 @@ wv_frequency_list(u_long	base,	/* i/o po
   return(i);
 }
 
-#ifdef WIRELESS_SPY
+#ifdef IW_WIRELESS_SPY
 /*------------------------------------------------------------------*/
 /*
  * Gather wireless spy statistics : for each packet, compare the source
@@ -1804,22 +1800,17 @@ wl_spy_gather(device *	dev,
 	      u_char *	mac,		/* MAC address */
 	      u_char *	stats)		/* Statistics to gather */
 {
-  net_local *	lp = (net_local *) dev->priv;
-  int		i;
+  struct iw_quality wstats;
 
-  /* Look all addresses */
-  for(i = 0; i < lp->spy_number; i++)
-    /* If match */
-    if(!memcmp(mac, lp->spy_address[i], WAVELAN_ADDR_SIZE))
-      {
-	/* Update statistics */
-	lp->spy_stat[i].qual = stats[2] & MMR_SGNL_QUAL;
-	lp->spy_stat[i].level = stats[0] & MMR_SIGNAL_LVL;
-	lp->spy_stat[i].noise = stats[1] & MMR_SILENCE_LVL;
-	lp->spy_stat[i].updated = 0x7;
-      }
+  wstats.qual = stats[2] & MMR_SGNL_QUAL;
+  wstats.level = stats[0] & MMR_SIGNAL_LVL;
+  wstats.noise = stats[1] & MMR_SILENCE_LVL;
+  wstats.updated = 0x7;
+
+  /* Update spy records */
+  wireless_spy_update(dev, mac, &wstats);
 }
-#endif	/* WIRELESS_SPY */
+#endif	/* IW_WIRELESS_SPY */
 
 #ifdef HISTOGRAM
 /*------------------------------------------------------------------*/
@@ -1904,17 +1895,10 @@ static int wavelan_set_nwid(struct net_d
 	spin_lock_irqsave(&lp->spinlock, flags);
 	
 	/* Set NWID in WaveLAN. */
-#if WIRELESS_EXT > 8
 	if (!wrqu->nwid.disabled) {
 		/* Set NWID in psa */
 		psa.psa_nwid[0] = (wrqu->nwid.value & 0xFF00) >> 8;
 		psa.psa_nwid[1] = wrqu->nwid.value & 0xFF;
-#else	/* WIRELESS_EXT > 8 */
-	if(wrq->u.nwid.on) {
-		/* Set NWID in psa */
-		psa.psa_nwid[0] = (wrq->u.nwid.nwid & 0xFF00) >> 8;
-		psa.psa_nwid[1] = wrq->u.nwid.nwid & 0xFF;
-#endif	/* WIRELESS_EXT > 8 */
 		psa.psa_nwid_select = 0x01;
 		psa_write(dev,
 			  (char *) psa.psa_nwid - (char *) &psa,
@@ -1971,14 +1955,9 @@ static int wavelan_get_nwid(struct net_d
 	psa_read(dev,
 		 (char *) psa.psa_nwid - (char *) &psa,
 		 (unsigned char *) psa.psa_nwid, 3);
-#if WIRELESS_EXT > 8
 	wrqu->nwid.value = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
 	wrqu->nwid.disabled = !(psa.psa_nwid_select);
 	wrqu->nwid.fixed = 1;	/* Superfluous */
-#else	/* WIRELESS_EXT > 8 */
-	wrq->u.nwid.nwid = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
-	wrq->u.nwid.on = psa.psa_nwid_select;
-#endif	/* WIRELESS_EXT > 8 */
 
 	/* Enable interrupts and restore flags. */
 	spin_unlock_irqrestore(&lp->spinlock, flags);
@@ -2081,13 +2060,9 @@ static int wavelan_set_sens(struct net_d
 	spin_lock_irqsave(&lp->spinlock, flags);
 	
 	/* Set the level threshold. */
-#if WIRELESS_EXT > 7
 	/* We should complain loudly if wrqu->sens.fixed = 0, because we
 	 * can't set auto mode... */
 	psa.psa_thr_pre_set = wrqu->sens.value & 0x3F;
-#else	/* WIRELESS_EXT > 7 */
-	psa.psa_thr_pre_set = wrq->u.sensitivity & 0x3F;
-#endif	/* WIRELESS_EXT > 7 */
 	psa_write(dev,
 		  (char *) &psa.psa_thr_pre_set - (char *) &psa,
 		  (unsigned char *) &psa.psa_thr_pre_set, 1);
@@ -2123,12 +2098,8 @@ static int wavelan_get_sens(struct net_d
 	psa_read(dev,
 		 (char *) &psa.psa_thr_pre_set - (char *) &psa,
 		 (unsigned char *) &psa.psa_thr_pre_set, 1);
-#if WIRELESS_EXT > 7
 	wrqu->sens.value = psa.psa_thr_pre_set & 0x3F;
 	wrqu->sens.fixed = 1;
-#else	/* WIRELESS_EXT > 7 */
-	wrq->u.sensitivity = psa.psa_thr_pre_set & 0x3F;
-#endif	/* WIRELESS_EXT > 7 */
 
 	/* Enable interrupts and restore flags. */
 	spin_unlock_irqrestore(&lp->spinlock, flags);
@@ -2136,7 +2107,6 @@ static int wavelan_get_sens(struct net_d
 	return ret;
 }
 
-#if WIRELESS_EXT > 8
 /*------------------------------------------------------------------*/
 /*
  * Wireless Handler : set encryption key
@@ -2253,10 +2223,8 @@ static int wavelan_get_encode(struct net
 
 	return ret;
 }
-#endif	/* WIRELESS_EXT > 8 */
 
 #ifdef WAVELAN_ROAMING_EXT
-#if WIRELESS_EXT > 5
 /*------------------------------------------------------------------*/
 /*
  * Wireless Handler : set ESSID (domain)
@@ -2367,10 +2335,8 @@ static int wavelan_get_wap(struct net_de
 
 	return -EOPNOTSUPP;
 }
-#endif	/* WIRELESS_EXT > 5 */
 #endif	/* WAVELAN_ROAMING_EXT */
 
-#if WIRELESS_EXT > 8
 #ifdef WAVELAN_ROAMING
 /*------------------------------------------------------------------*/
 /*
@@ -2429,7 +2395,6 @@ static int wavelan_get_mode(struct net_d
 	return 0;
 }
 #endif	/* WAVELAN_ROAMING */
-#endif /* WIRELESS_EXT > 8 */
 
 /*------------------------------------------------------------------*/
 /*
@@ -2452,11 +2417,9 @@ static int wavelan_get_range(struct net_
 	/* Set all the info we don't care or don't know about to zero */
 	memset(range, 0, sizeof(struct iw_range));
 
-#if WIRELESS_EXT > 10
 	/* Set the Wireless Extension versions */
 	range->we_version_compiled = WIRELESS_EXT;
 	range->we_version_source = 9;
-#endif /* WIRELESS_EXT > 10 */
 
 	/* Set information in the range struct.  */
 	range->throughput = 1.4 * 1000 * 1000;	/* don't argue on this ! */
@@ -2467,17 +2430,13 @@ static int wavelan_get_range(struct net_
 	range->max_qual.qual = MMR_SGNL_QUAL;
 	range->max_qual.level = MMR_SIGNAL_LVL;
 	range->max_qual.noise = MMR_SILENCE_LVL;
-#if WIRELESS_EXT > 11
 	range->avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
 	/* Need to get better values for those two */
 	range->avg_qual.level = 30;
 	range->avg_qual.noise = 8;
-#endif /* WIRELESS_EXT > 11 */
 
-#if WIRELESS_EXT > 7
 	range->num_bitrates = 1;
 	range->bitrate[0] = 2000000;	/* 2 Mb/s */
-#endif /* WIRELESS_EXT > 7 */
 
 	/* Disable interrupts and save flags. */
 	spin_lock_irqsave(&lp->spinlock, flags);
@@ -2491,7 +2450,6 @@ static int wavelan_get_range(struct net_
 	} else
 		range->num_channels = range->num_frequency = 0;
 
-#if WIRELESS_EXT > 8
 	/* Encryption supported ? */
 	if (mmc_encr(base)) {
 		range->encoding_size[0] = 8;	/* DES = 64 bits key */
@@ -2501,7 +2459,6 @@ static int wavelan_get_range(struct net_
 		range->num_encoding_sizes = 0;
 		range->max_encoding_tokens = 0;
 	}
-#endif /* WIRELESS_EXT > 8 */
 
 	/* Enable interrupts and restore flags. */
 	spin_unlock_irqrestore(&lp->spinlock, flags);
@@ -2509,93 +2466,6 @@ static int wavelan_get_range(struct net_
 	return ret;
 }
 
-#ifdef WIRELESS_SPY
-/*------------------------------------------------------------------*/
-/*
- * Wireless Handler : set spy list
- */
-static int wavelan_set_spy(struct net_device *dev,
-			   struct iw_request_info *info,
-			   union iwreq_data *wrqu,
-			   char *extra)
-{
-	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
-	struct sockaddr *address = (struct sockaddr *) extra;
-	int i;
-	int ret = 0;
-
-	/* Disable spy while we copy the addresses.
-	 * As we don't disable interrupts, we need to do this */
-	lp->spy_number = 0;
-
-	/* Are there are addresses to copy? */
-	if (wrqu->data.length > 0) {
-		/* Copy addresses to the lp structure. */
-		for (i = 0; i < wrqu->data.length; i++) {
-			memcpy(lp->spy_address[i], address[i].sa_data,
-			       WAVELAN_ADDR_SIZE);
-		}
-
-		/* Reset structure. */
-		memset(lp->spy_stat, 0x00, sizeof(iw_qual) * IW_MAX_SPY);
-
-#ifdef DEBUG_IOCTL_INFO
-		printk(KERN_DEBUG
-		       "SetSpy:  set of new addresses is: \n");
-		for (i = 0; i < wrqu->data.length; i++)
-			printk(KERN_DEBUG
-			       "%02X:%02X:%02X:%02X:%02X:%02X \n",
-			       lp->spy_address[i][0],
-			       lp->spy_address[i][1],
-			       lp->spy_address[i][2],
-			       lp->spy_address[i][3],
-			       lp->spy_address[i][4],
-			       lp->spy_address[i][5]);
-#endif			/* DEBUG_IOCTL_INFO */
-	}
-
-	/* Now we can set the number of addresses */
-	lp->spy_number = wrqu->data.length;
-
-	return ret;
-}
-
-/*------------------------------------------------------------------*/
-/*
- * Wireless Handler : get spy list
- */
-static int wavelan_get_spy(struct net_device *dev,
-			   struct iw_request_info *info,
-			   union iwreq_data *wrqu,
-			   char *extra)
-{
-	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
-	struct sockaddr *address = (struct sockaddr *) extra;
-	int i;
-
-	/* Set the number of addresses */
-	wrqu->data.length = lp->spy_number;
-
-	/* Copy addresses from the lp structure. */
-	for (i = 0; i < lp->spy_number; i++) {
-		memcpy(address[i].sa_data,
-		       lp->spy_address[i],
-		       WAVELAN_ADDR_SIZE);
-		address[i].sa_family = AF_UNIX;
-	}
-	/* Copy stats to the user buffer (just after). */
-	if(lp->spy_number > 0)
-		memcpy(extra  + (sizeof(struct sockaddr) * lp->spy_number),
-		       lp->spy_stat, sizeof(iw_qual) * lp->spy_number);
-
-	/* Reset updated flags. */
-	for (i = 0; i < lp->spy_number; i++)
-		lp->spy_stat[i].updated = 0x0;
-
-	return(0);
-}
-#endif			/* WIRELESS_SPY */
-
 /*------------------------------------------------------------------*/
 /*
  * Wireless Private Handler : set quality threshold
@@ -2781,8 +2651,6 @@ static const struct iw_priv_args wavelan
   { SIOCGIPHISTO, 0,                     IW_PRIV_TYPE_INT | 16, "gethisto" },
 };
 
-#if WIRELESS_EXT > 12
-
 static const iw_handler		wavelan_handler[] =
 {
 	NULL,				/* SIOCSIWNAME */
@@ -2806,15 +2674,10 @@ static const iw_handler		wavelan_handler
 	NULL,				/* SIOCGIWPRIV */
 	NULL,				/* SIOCSIWSTATS */
 	NULL,				/* SIOCGIWSTATS */
-#ifdef WIRELESS_SPY
-	wavelan_set_spy,		/* SIOCSIWSPY */
-	wavelan_get_spy,		/* SIOCGIWSPY */
-#else	/* WIRELESS_SPY */
-	NULL,				/* SIOCSIWSPY */
-	NULL,				/* SIOCGIWSPY */
-#endif	/* WIRELESS_SPY */
-	NULL,				/* -- hole -- */
-	NULL,				/* -- hole -- */
+	iw_handler_set_spy,		/* SIOCSIWSPY */
+	iw_handler_get_spy,		/* SIOCGIWSPY */
+	iw_handler_set_thrspy,		/* SIOCSIWTHRSPY */
+	iw_handler_get_thrspy,		/* SIOCGIWTHRSPY */
 #ifdef WAVELAN_ROAMING_EXT
 	wavelan_set_wap,		/* SIOCSIWAP */
 	wavelan_get_wap,		/* SIOCGIWAP */
@@ -2834,7 +2697,6 @@ static const iw_handler		wavelan_handler
 	NULL,				/* SIOCSIWESSID */
 	NULL,				/* SIOCGIWESSID */
 #endif	/* WAVELAN_ROAMING_EXT */
-#if WIRELESS_EXT > 8
 	NULL,				/* SIOCSIWNICKN */
 	NULL,				/* SIOCGIWNICKN */
 	NULL,				/* -- hole -- */
@@ -2851,7 +2713,6 @@ static const iw_handler		wavelan_handler
 	NULL,				/* SIOCGIWRETRY */
 	wavelan_set_encode,		/* SIOCSIWENCODE */
 	wavelan_get_encode,		/* SIOCGIWENCODE */
-#endif	/* WIRELESS_EXT > 8 */
 };
 
 static const iw_handler		wavelan_private_handler[] =
@@ -2879,8 +2740,9 @@ static const struct iw_handler_def	wavel
 	.standard	= (iw_handler *) wavelan_handler,
 	.private	= (iw_handler *) wavelan_private_handler,
 	.private_args	= (struct iw_priv_args *) wavelan_private_args,
+	.spy_offset	= ((void *) (&((net_local *) NULL)->spy_data) -
+			   (void *) NULL),
 };
-#endif /* WIRELESS_EXT > 12 */
 
 /*------------------------------------------------------------------*/
 /*
@@ -2892,9 +2754,6 @@ wavelan_ioctl(struct net_device *	dev,	/
 	      struct ifreq *	rq,	/* Data passed */
 	      int		cmd)	/* Ioctl number */
 {
-#if WIRELESS_EXT <= 12
-  struct iwreq *	wrq = (struct iwreq *) rq;
-#endif
   int			ret = 0;
 
 #ifdef DEBUG_IOCTL_TRACE
@@ -2908,284 +2767,6 @@ wavelan_ioctl(struct net_device *	dev,	/
       ret = wl_netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
       break;
 
-#if WIRELESS_EXT <= 12
-      /* --------------- WIRELESS EXTENSIONS --------------- */
-      /* Now done as iw_handler - Jean II */
-    case SIOCGIWNAME:
-      wavelan_get_name(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCSIWNWID:
-      ret = wavelan_set_nwid(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIWNWID:
-      ret = wavelan_get_nwid(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCSIWFREQ:
-      ret = wavelan_set_freq(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIWFREQ:
-      ret = wavelan_get_freq(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCSIWSENS:
-      ret = wavelan_set_sens(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIWSENS:
-      ret = wavelan_get_sens(dev, NULL, &(wrq->u), NULL);
-      break;
-
-#if WIRELESS_EXT > 8
-    case SIOCSIWENCODE:
-      {
-	char keybuf[8];
-	if (wrq->u.encoding.pointer) {
-	  /* We actually have a key to set */
-	  if (wrq->u.encoding.length != 8) {
-	    ret = -EINVAL;
-	    break;
-	  }
-	  if (copy_from_user(keybuf,
-			     wrq->u.encoding.pointer,
-			     wrq->u.encoding.length)) {
-	    ret = -EFAULT;
-	    break;
-	  }
-	} else if (wrq->u.encoding.length != 0) {
-	  ret = -EINVAL;
-	  break;
-	}
-	ret = wavelan_set_encode(dev, NULL, &(wrq->u), keybuf);
-      }
-      break;
-
-    case SIOCGIWENCODE:
-      if (! capable(CAP_NET_ADMIN)) {
-	ret = -EPERM;
-	break;
-      }
-      {
-	char keybuf[8];
-	ret = wavelan_get_encode(dev, NULL,
-				 &(wrq->u),
-				 keybuf);
-	if (wrq->u.encoding.pointer) {
-	  if (copy_to_user(wrq->u.encoding.pointer,
-			   keybuf,
-			   wrq->u.encoding.length))
-	    ret = -EFAULT;
-	}
-      }
-      break;
-#endif	/* WIRELESS_EXT > 8 */
-
-#ifdef WAVELAN_ROAMING_EXT
-#if WIRELESS_EXT > 5
-    case SIOCSIWESSID:
-      {
-	char essidbuf[IW_ESSID_MAX_SIZE+1];
-	if (wrq->u.essid.length > IW_ESSID_MAX_SIZE) {
-	  ret = -E2BIG;
-	  break;
-	}
-	if (copy_from_user(essidbuf, wrq->u.essid.pointer,
-			   wrq->u.essid.length)) {
-	  ret = -EFAULT;
-	  break;
-	}
-	ret = wavelan_set_essid(dev, NULL,
-				&(wrq->u),
-				essidbuf);
-      }
-      break;
-
-    case SIOCGIWESSID:
-      {
-	char essidbuf[IW_ESSID_MAX_SIZE+1];
-	ret = wavelan_get_essid(dev, NULL,
-				&(wrq->u),
-				essidbuf);
-	if (wrq->u.essid.pointer)
-	  if ( copy_to_user(wrq->u.essid.pointer,
-			    essidbuf,
-			    wrq->u.essid.length) )
-	    ret = -EFAULT;
-      }
-      break;
-
-    case SIOCSIWAP:
-      ret = wavelan_set_wap(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIWAP:
-      ret = wavelan_get_wap(dev, NULL, &(wrq->u), NULL);
-      break;
-#endif	/* WIRELESS_EXT > 5 */
-#endif	/* WAVELAN_ROAMING_EXT */
-
-#if WIRELESS_EXT > 8
-#ifdef WAVELAN_ROAMING
-    case SIOCSIWMODE:
-      ret = wavelan_set_mode(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIWMODE:
-      ret = wavelan_get_mode(dev, NULL, &(wrq->u), NULL);
-      break;
-#endif	/* WAVELAN_ROAMING */
-#endif /* WIRELESS_EXT > 8 */
-
-    case SIOCGIWRANGE:
-      {
-	struct iw_range range;
-	ret = wavelan_get_range(dev, NULL,
-				&(wrq->u),
-				(char *) &range);
-	if (copy_to_user(wrq->u.data.pointer, &range,
-			 sizeof(struct iw_range)))
-	  ret = -EFAULT;
-      }
-      break;
-
-    case SIOCGIWPRIV:
-      /* Basic checking... */
-      if(wrq->u.data.pointer != (caddr_t) 0)
-	{
-	  /* Set the number of ioctl available */
-	  wrq->u.data.length = sizeof(wavelan_private_args) / sizeof(wavelan_private_args[0]);
-
-	  /* Copy structure to the user buffer */
-	  if(copy_to_user(wrq->u.data.pointer, (u_char *) wavelan_private_args,
-		       sizeof(wavelan_private_args)))
-	    ret = -EFAULT;
-	}
-      break;
-
-#ifdef WIRELESS_SPY
-    case SIOCSIWSPY:
-      {
-	struct sockaddr address[IW_MAX_SPY];
-	/* Check the number of addresses */
-	if (wrq->u.data.length > IW_MAX_SPY) {
-	  ret = -E2BIG;
-	  break;
-	}
-	/* Get the data in the driver */
-	if (wrq->u.data.pointer) {
-	  if (copy_from_user((char *) address,
-			     wrq->u.data.pointer,
-			     sizeof(struct sockaddr) *
-			     wrq->u.data.length)) {
-	    ret = -EFAULT;
-	    break;
-	  }
-	} else if (wrq->u.data.length != 0) {
-	  ret = -EINVAL;
-	  break;
-	}
-	ret = wavelan_set_spy(dev, NULL, &(wrq->u),
-			      (char *) address);
-      }
-      break;
-
-    case SIOCGIWSPY:
-      {
-	char buffer[IW_MAX_SPY * (sizeof(struct sockaddr) +
-				  sizeof(struct iw_quality))];
-	ret = wavelan_get_spy(dev, NULL, &(wrq->u),
-			      buffer);
-	if (wrq->u.data.pointer) {
-	  if (copy_to_user(wrq->u.data.pointer,
-			   buffer,
-			   (wrq->u.data.length *
-			    (sizeof(struct sockaddr) +
-			     sizeof(struct iw_quality)))
-			   ))
-	    ret = -EFAULT;
-	}
-      }
-      break;
-#endif	/* WIRELESS_SPY */
-
-      /* ------------------ PRIVATE IOCTL ------------------ */
-
-    case SIOCSIPQTHR:
-      if(!capable(CAP_NET_ADMIN))
-	{
-	  ret = -EPERM;
-	  break;
-	}
-      ret = wavelan_set_qthr(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIPQTHR:
-      ret = wavelan_get_qthr(dev, NULL, &(wrq->u), NULL);
-      break;
-
-#ifdef WAVELAN_ROAMING
-    case SIOCSIPROAM:
-      /* Note : should check if user == root */
-      ret = wavelan_set_roam(dev, NULL, &(wrq->u), NULL);
-      break;
-
-    case SIOCGIPROAM:
-      ret = wavelan_get_roam(dev, NULL, &(wrq->u), NULL);
-      break;
-#endif	/* WAVELAN_ROAMING */
-
-#ifdef HISTOGRAM
-    case SIOCSIPHISTO:
-      /* Verif if the user is root */
-      if(!capable(CAP_NET_ADMIN))
-	{
-	  ret = -EPERM;
-	}
-      {
-	char buffer[16];
-	/* Check the number of intervals */
-	if(wrq->u.data.length > 16)
-	  {
-	    ret = -E2BIG;
-	    break;
-	}
-	/* Get the data in the driver */
-	if (wrq->u.data.pointer) {
-	  if (copy_from_user(buffer,
-			     wrq->u.data.pointer,
-			     sizeof(struct sockaddr) *
-			     wrq->u.data.length)) {
-	    ret = -EFAULT;
-	    break;
-	  }
-	} else if (wrq->u.data.length != 0) {
-	  ret = -EINVAL;
-	  break;
-	}
-	ret = wavelan_set_histo(dev, NULL, &(wrq->u),
-				buffer);
-      }
-      break;
-
-    case SIOCGIPHISTO:
-      {
-	long buffer[16];
-	ret = wavelan_get_histo(dev, NULL, &(wrq->u),
-				(char *) buffer);
-	if (wrq->u.data.pointer) {
-	  if (copy_to_user(wrq->u.data.pointer,
-			   buffer,
-			   (wrq->u.data.length * sizeof(long))))
-	    ret = -EFAULT;
-	}
-      }
-      break;
-#endif	/* HISTOGRAM */
-#endif /* WIRELESS_EXT <= 12 */
-
       /* ------------------- OTHER IOCTL ------------------- */
 
     default:
@@ -3368,9 +2949,9 @@ wv_packet_read(device *		dev,
   /* Statistics gathering & stuff associated.
    * It seem a bit messy with all the define, but it's really simple... */
   if(
-#ifdef WIRELESS_SPY
-     (lp->spy_number > 0) ||
-#endif	/* WIRELESS_SPY */
+#ifdef IW_WIRELESS_SPY
+     (lp->spy_data.spy_number > 0) ||
+#endif	/* IW_WIRELESS_SPY */
 #ifdef HISTOGRAM
      (lp->his_number > 0) ||
 #endif	/* HISTOGRAM */
@@ -5214,9 +4795,7 @@ wavelan_attach(void)
   dev->watchdog_timeo	= WATCHDOG_JIFFIES;
 
 #ifdef WIRELESS_EXT	/* If wireless extension exist in the kernel */
-#if WIRELESS_EXT > 12
   dev->wireless_handlers = (struct iw_handler_def *)&wavelan_handler_def;
-#endif /* WIRELESS_EXT > 12 */
   dev->do_ioctl = wavelan_ioctl;	/* old wireless extensions */
   dev->get_wireless_stats = wavelan_get_wireless_stats;
 #endif
