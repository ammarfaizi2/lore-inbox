Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTEBBev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTEBBev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:34:51 -0400
Received: from palrel13.hp.com ([156.153.255.238]:9939 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262860AbTEBBec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:34:32 -0400
Date: Thu, 1 May 2003 18:46:48 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] WE-16 for Wavelan ISA driver
Message-ID: <20030502014648.GC8753@bougret.hpl.hp.com>
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

        This update the Wavelan ISA driver for Wireless Extension 16 
(going with my previous patch).

        Have fun...

        Jean


diff -u -p linux/drivers/net/wireless/wavelan.p.15.h linux/drivers/net/wireless/wavelan.p.h
--- linux/drivers/net/wireless/wavelan.p.15.h	Fri Dec  6 18:02:53 2002
+++ linux/drivers/net/wireless/wavelan.p.h	Fri Dec  6 18:03:51 2002
@@ -509,13 +509,9 @@ struct net_local
 
 #ifdef WIRELESS_EXT
   iw_stats	wstats;		/* Wireless-specific statistics */
-#endif
 
-#ifdef WIRELESS_SPY
-  int		spy_number;			/* number of addresses to spy */
-  mac_addr	spy_address[IW_MAX_SPY];	/* the addresses to spy */
-  iw_qual	spy_stat[IW_MAX_SPY];		/* statistics gathered */
-#endif	/* WIRELESS_SPY */
+  struct iw_spy_data	spy_data;
+#endif
 
 #ifdef HISTOGRAM
   int		his_number;		/* number of intervals */
diff -u -p linux/drivers/net/wireless/wavelan.15.c linux/drivers/net/wireless/wavelan.c
--- linux/drivers/net/wireless/wavelan.15.c	Fri Dec  6 17:54:26 2002
+++ linux/drivers/net/wireless/wavelan.c	Fri Dec  6 18:10:13 2002
@@ -1717,31 +1717,28 @@ static inline int wv_frequency_list(unsi
 	return (i);
 }
 
-#ifdef WIRELESS_SPY
+#ifdef IW_WIRELESS_SPY
 /*------------------------------------------------------------------*/
 /*
  * Gather wireless spy statistics:  for each packet, compare the source
  * address with our list, and if they match, get the statistics.
  * Sorry, but this function really needs the wireless extensions.
  */
-static inline void wl_spy_gather(device * dev, u8 * mac,	/* MAC address */
-				 u8 * stats)
-{				/* Statistics to gather */
-	net_local *lp = (net_local *) dev->priv;
-	int i;
+static inline void wl_spy_gather(device * dev,
+				 u8 *	mac,	/* MAC address */
+				 u8 *	stats)	/* Statistics to gather */
+{
+	struct iw_quality wstats;
 
-	/* Check all addresses. */
-	for (i = 0; i < lp->spy_number; i++)
-		/* If match */
-		if (!memcmp(mac, lp->spy_address[i], WAVELAN_ADDR_SIZE)) {
-			/* Update statistics */
-			lp->spy_stat[i].qual = stats[2] & MMR_SGNL_QUAL;
-			lp->spy_stat[i].level = stats[0] & MMR_SIGNAL_LVL;
-			lp->spy_stat[i].noise = stats[1] & MMR_SILENCE_LVL;
-			lp->spy_stat[i].updated = 0x7;
-		}
+	wstats.qual = stats[2] & MMR_SGNL_QUAL;
+	wstats.level = stats[0] & MMR_SIGNAL_LVL;
+	wstats.noise = stats[1] & MMR_SILENCE_LVL;
+	wstats.updated = 0x7;
+
+	/* Update spy records */
+	wireless_spy_update(dev, mac, &wstats);
 }
-#endif				/* WIRELESS_SPY */
+#endif /* IW_WIRELESS_SPY */
 
 #ifdef HISTOGRAM
 /*------------------------------------------------------------------*/
@@ -1767,7 +1764,7 @@ static inline void wl_his_gather(device 
 	/* Increment interval counter. */
 	(lp->his_sum[i])++;
 }
-#endif				/* HISTOGRAM */
+#endif /* HISTOGRAM */
 
 /*------------------------------------------------------------------*/
 /*
@@ -2203,93 +2200,6 @@ static int wavelan_get_range(struct net_
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
@@ -2439,15 +2349,10 @@ static const iw_handler		wavelan_handler
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
 	NULL,				/* SIOCSIWAP */
 	NULL,				/* SIOCGIWAP */
 	NULL,				/* -- hole -- */
@@ -2501,6 +2406,8 @@ static const struct iw_handler_def	wavel
 	.standard	= (iw_handler *) wavelan_handler,
 	.private	= (iw_handler *) wavelan_private_handler,
 	.private_args	= (struct iw_priv_args *) wavelan_private_args,
+	.spy_offset	= ((void *) (&((net_local *) NULL)->spy_data) -
+			   (void *) NULL),
 };
 
 /*------------------------------------------------------------------*/
@@ -2618,22 +2525,23 @@ wv_packet_read(device * dev, u16 buf_off
 #endif				/* DEBUG_RX_INFO */
 
 	/* Statistics-gathering and associated stuff.
-	 * It seem a bit messy with all the define, but it's really simple... */
-#if defined(WIRELESS_SPY) || defined(HISTOGRAM)
+	 * It seem a bit messy with all the define, but it's really
+	 * simple... */
 	if (
-#ifdef WIRELESS_SPY
-		   (lp->spy_number > 0) ||
-#endif				/* WIRELESS_SPY */
+#ifdef IW_WIRELESS_SPY		/* defined in iw_handler.h */
+		   (lp->spy_data.spy_number > 0) ||
+#endif /* IW_WIRELESS_SPY */
 #ifdef HISTOGRAM
 		   (lp->his_number > 0) ||
-#endif				/* HISTOGRAM */
+#endif /* HISTOGRAM */
 		   0) {
 		u8 stats[3];	/* signal level, noise level, signal quality */
 
-		/* Read signal level, silence level and signal quality bytes. */
-		/* Note: in the PCMCIA hardware, these are part of the frame.  It seems
-		 * that for the ISA hardware, it's nowhere to be found in the frame,
-		 * so I'm obliged to do this (it has a side effect on /proc/net/wireless).
+		/* Read signal level, silence level and signal quality bytes */
+		/* Note: in the PCMCIA hardware, these are part of the frame.
+		 * It seems that for the ISA hardware, it's nowhere to be
+		 * found in the frame, so I'm obliged to do this (it has a
+		 * side effect on /proc/net/wireless).
 		 * Any ideas?
 		 */
 		mmc_out(ioaddr, mmwoff(0, mmw_freeze), 1);
@@ -2648,15 +2556,14 @@ wv_packet_read(device * dev, u16 buf_off
 #endif
 
 		/* Spying stuff */
-#ifdef WIRELESS_SPY
+#ifdef IW_WIRELESS_SPY
 		wl_spy_gather(dev, skb->mac.raw + WAVELAN_ADDR_SIZE,
 			      stats);
-#endif				/* WIRELESS_SPY */
+#endif /* IW_WIRELESS_SPY */
 #ifdef HISTOGRAM
 		wl_his_gather(dev, stats);
-#endif				/* HISTOGRAM */
+#endif /* HISTOGRAM */
 	}
-#endif				/* defined(WIRELESS_SPY) || defined(HISTOGRAM) */
 
 	/*
 	 * Hand the packet to the network module.
