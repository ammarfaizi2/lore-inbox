Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266920AbUHDAli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266920AbUHDAli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHDAli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:41:38 -0400
Received: from palrel13.hp.com ([156.153.255.238]:6625 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266917AbUHDAkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:40:40 -0400
Date: Tue, 3 Aug 2004 17:40:35 -0700
To: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] Wireless drivers update for WE-17
Message-ID: <20040804004035.GA26633@bougret.hpl.hp.com>
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

	This patch complement the main WE-17 patch I just sent you. It
updates a few driver to take advantage of WE-17. You should queue it
along with the other patch.

	o Aironet driver :
		o iwspy data can be shared between eth0 and wifi0 if needed
		o allow arbitrarily large scan results (no longer limited)
		o export wireless event capabilities
	o Wavelan drivers :
		o export wireless event capabilities

	Have fun...

	Jean

-------------------------------------------------------------

diff -u -p -r linux/drivers/net/wireless.we16/airo.c linux/drivers/net/wireless/airo.c
--- linux/drivers/net/wireless.we16/airo.c	Mon Aug  2 14:35:54 2004
+++ linux/drivers/net/wireless/airo.c	Tue Aug  3 11:33:26 2004
@@ -1188,6 +1188,7 @@ struct airo_info {
 	struct iw_statistics	wstats;		// wireless stats
 	unsigned long		scan_timestamp;	/* Time started to scan */
 	struct iw_spy_data	spy_data;
+	struct iw_public_data	wireless_data;
 #endif /* WIRELESS_EXT */
 #ifdef MICSUPPORT
 	/* MIC stuff */
@@ -2626,8 +2627,7 @@ static void wifi_setup(struct net_device
 	dev->set_mac_address = &airo_set_mac_address;
 	dev->do_ioctl = &airo_ioctl;
 #ifdef WIRELESS_EXT
-	dev->get_wireless_stats = airo_get_wireless_stats;
-	dev->wireless_handlers = (struct iw_handler_def *)&airo_handler_def;
+	dev->wireless_handlers = &airo_handler_def;
 #endif /* WIRELESS_EXT */
 	dev->change_mtu = &airo_change_mtu;
 	dev->open = &airo_open;
@@ -2654,6 +2654,9 @@ static struct net_device *init_wifidev(s
 	dev->priv = ethdev->priv;
 	dev->irq = ethdev->irq;
 	dev->base_addr = ethdev->base_addr;
+#ifdef WIRELESS_EXT
+	dev->wireless_data = ethdev->wireless_data;
+#endif /* WIRELESS_EXT */
 	memcpy(dev->dev_addr, ethdev->dev_addr, dev->addr_len);
 	err = register_netdev(dev);
 	if (err<0) {
@@ -2733,8 +2736,9 @@ struct net_device *_init_airo_card( unsi
 	dev->set_mac_address = &airo_set_mac_address;
 	dev->do_ioctl = &airo_ioctl;
 #ifdef WIRELESS_EXT
-	dev->get_wireless_stats = airo_get_wireless_stats;
-	dev->wireless_handlers = (struct iw_handler_def *)&airo_handler_def;
+	dev->wireless_handlers = &airo_handler_def;
+	ai->wireless_data.spy_data = &ai->spy_data;
+	dev->wireless_data = &ai->wireless_data;
 #endif /* WIRELESS_EXT */
 	dev->change_mtu = &airo_change_mtu;
 	dev->open = &airo_open;
@@ -3217,7 +3221,7 @@ badrx:
 					goto exitrx;
 				}
 			}
-#ifdef IW_WIRELESS_SPY		/* defined in iw_handler.h */
+#ifdef WIRELESS_SPY
 			if (apriv->spy_data.spy_number > 0) {
 				char *sa;
 				struct iw_quality wstats;
@@ -3237,7 +3241,7 @@ badrx:
 				/* Update spy records */
 				wireless_spy_update(dev, sa, &wstats);
 			}
-#endif /* IW_WIRELESS_SPY */
+#endif /* WIRELESS_SPY */
 			OUT4500( apriv, EVACK, EV_RX);
 
 			if (test_bit(FLAG_802_11, &apriv->flags)) {
@@ -3467,7 +3471,7 @@ badmic:
 #else
 		memcpy(buffer, ai->rxfids[0].virtual_host_addr, len);
 #endif
-#ifdef IW_WIRELESS_SPY		/* defined in iw_handler.h */
+#ifdef WIRELESS_SPY
 		if (ai->spy_data.spy_number > 0) {
 			char *sa;
 			struct iw_quality wstats;
@@ -3479,7 +3483,7 @@ badmic:
 			/* Update spy records */
 			wireless_spy_update(ai->dev, sa, &wstats);
 		}
-#endif /* IW_WIRELESS_SPY */
+#endif /* WIRELESS_SPY */
 
 		skb->dev = ai->dev;
 		skb->ip_summed = CHECKSUM_NONE;
@@ -6505,6 +6509,13 @@ static int airo_get_range(struct net_dev
 		range->avg_qual.level = 176;	/* -80 dBm */
 	range->avg_qual.noise = 0;
 
+	/* Event capability (kernel + driver) */
+	range->event_capa[0] = (IW_EVENT_CAPA_K_0 |
+				IW_EVENT_CAPA_MASK(SIOCGIWTHRSPY) |
+				IW_EVENT_CAPA_MASK(SIOCGIWAP) |
+				IW_EVENT_CAPA_MASK(SIOCGIWSCAN));
+	range->event_capa[1] = IW_EVENT_CAPA_K_1;
+	range->event_capa[4] = IW_EVENT_CAPA_MASK(IWEVTXDROP);
 	return 0;
 }
 
@@ -6872,9 +6883,15 @@ static int airo_get_scan(struct net_devi
 	while((!rc) && (BSSList.index != 0xffff)) {
 		/* Translate to WE format this entry */
 		current_ev = airo_translate_scan(dev, current_ev,
-						 extra + IW_SCAN_MAX_DATA,
+						 extra + dwrq->length,
 						 &BSSList);
 
+		/* Check if there is space for one more entry */
+		if((extra + dwrq->length - current_ev) <= IW_EV_ADDR_LEN) {
+			/* Ask user space to try again with a bigger buffer */
+			return -E2BIG;
+		}
+
 		/* Read next entry */
 		rc = PC4500_readrid(ai, RID_BSSLISTNEXT,
 				    &BSSList, sizeof(BSSList), 1);
@@ -7010,12 +7027,10 @@ static const struct iw_handler_def	airo_
 	.num_standard	= sizeof(airo_handler)/sizeof(iw_handler),
 	.num_private	= sizeof(airo_private_handler)/sizeof(iw_handler),
 	.num_private_args = sizeof(airo_private_args)/sizeof(struct iw_priv_args),
-	.standard	= (iw_handler *) airo_handler,
-	.private	= (iw_handler *) airo_private_handler,
-	.private_args	= (struct iw_priv_args *) airo_private_args,
-	.spy_offset	= ((void *) (&((struct airo_info *) NULL)->spy_data) -
-			   (void *) NULL),
-
+	.standard	= airo_handler,
+	.private	= airo_private_handler,
+	.private_args	= airo_private_args,
+	.get_wireless_stats = airo_get_wireless_stats,
 };
 
 #endif /* WIRELESS_EXT */
diff -u -p -r linux/drivers/net/wireless.we16/wavelan.c linux/drivers/net/wireless/wavelan.c
--- linux/drivers/net/wireless.we16/wavelan.c	Mon Aug  2 14:23:02 2004
+++ linux/drivers/net/wireless/wavelan.c	Tue Aug  3 11:35:52 2004
@@ -2172,6 +2172,11 @@ static int wavelan_get_range(struct net_
 	range->num_bitrates = 1;
 	range->bitrate[0] = 2000000;	/* 2 Mb/s */
 
+	/* Event capability (kernel + driver) */
+	range->event_capa[0] = (IW_EVENT_CAPA_MASK(0x8B02) |
+				IW_EVENT_CAPA_MASK(0x8B04));
+	range->event_capa[1] = IW_EVENT_CAPA_K_1;
+
 	/* Disable interrupts and save flags. */
 	spin_lock_irqsave(&lp->spinlock, flags);
 	
@@ -2403,11 +2408,10 @@ static const struct iw_handler_def	wavel
 	.num_standard	= sizeof(wavelan_handler)/sizeof(iw_handler),
 	.num_private	= sizeof(wavelan_private_handler)/sizeof(iw_handler),
 	.num_private_args = sizeof(wavelan_private_args)/sizeof(struct iw_priv_args),
-	.standard	= (iw_handler *) wavelan_handler,
-	.private	= (iw_handler *) wavelan_private_handler,
-	.private_args	= (struct iw_priv_args *) wavelan_private_args,
-	.spy_offset	= ((void *) (&((net_local *) NULL)->spy_data) -
-			   (void *) NULL),
+	.standard	= wavelan_handler,
+	.private	= wavelan_private_handler,
+	.private_args	= wavelan_private_args,
+	.get_wireless_stats = wavelan_get_wireless_stats,
 };
 
 /*------------------------------------------------------------------*/
@@ -4190,8 +4194,9 @@ static int __init wavelan_config(struct 
 #endif				/* SET_MAC_ADDRESS */
 
 #ifdef WIRELESS_EXT		/* if wireless extension exists in the kernel */
-	dev->get_wireless_stats = wavelan_get_wireless_stats;
-	dev->wireless_handlers = (struct iw_handler_def *)&wavelan_handler_def;
+	dev->wireless_handlers = &wavelan_handler_def;
+	lp->wireless_data.spy_data = &lp->spy_data;
+	dev->wireless_data = &lp->wireless_data;
 #endif
 
 	dev->mtu = WAVELAN_MTU;
diff -u -p -r linux/drivers/net/wireless.we16/wavelan.p.h linux/drivers/net/wireless/wavelan.p.h
--- linux/drivers/net/wireless.we16/wavelan.p.h	Mon Aug  2 14:23:02 2004
+++ linux/drivers/net/wireless/wavelan.p.h	Tue Aug  3 11:32:06 2004
@@ -510,6 +510,7 @@ struct net_local
   iw_stats	wstats;		/* Wireless-specific statistics */
 
   struct iw_spy_data	spy_data;
+  struct iw_public_data	wireless_data;
 #endif
 
 #ifdef HISTOGRAM
@@ -614,6 +615,8 @@ static inline void
 /* ------------------- IOCTL, STATS & RECONFIG ------------------- */
 static en_stats	*
 	wavelan_get_stats(struct net_device *);	/* Give stats /proc/net/dev */
+static iw_stats *
+	wavelan_get_wireless_stats(struct net_device *);
 static void
 	wavelan_set_multicast_list(struct net_device *);
 /* ----------------------- PACKET RECEPTION ----------------------- */
diff -u -p -r linux/drivers/net/wireless.we16/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless.we16/wavelan_cs.c	Mon Aug  2 14:28:32 2004
+++ linux/drivers/net/wireless/wavelan_cs.c	Tue Aug  3 11:37:31 2004
@@ -1550,7 +1550,6 @@ wavelan_set_mac_address(struct net_devic
 /*
  * Frequency setting (for hardware able of it)
  * It's a bit complicated and you don't really want to look into it...
- * (called in wavelan_ioctl)
  */
 static inline int
 wv_set_frequency(u_long		base,	/* i/o port of the card */
@@ -2438,6 +2437,12 @@ static int wavelan_get_range(struct net_
 	range->num_bitrates = 1;
 	range->bitrate[0] = 2000000;	/* 2 Mb/s */
 
+	/* Event capability (kernel + driver) */
+	range->event_capa[0] = (IW_EVENT_CAPA_MASK(0x8B02) |
+				IW_EVENT_CAPA_MASK(0x8B04) |
+				IW_EVENT_CAPA_MASK(0x8B06));
+	range->event_capa[1] = IW_EVENT_CAPA_K_1;
+
 	/* Disable interrupts and save flags. */
 	spin_lock_irqsave(&lp->spinlock, flags);
 	
@@ -2737,11 +2742,10 @@ static const struct iw_handler_def	wavel
 	.num_standard	= sizeof(wavelan_handler)/sizeof(iw_handler),
 	.num_private	= sizeof(wavelan_private_handler)/sizeof(iw_handler),
 	.num_private_args = sizeof(wavelan_private_args)/sizeof(struct iw_priv_args),
-	.standard	= (iw_handler *) wavelan_handler,
-	.private	= (iw_handler *) wavelan_private_handler,
-	.private_args	= (struct iw_priv_args *) wavelan_private_args,
-	.spy_offset	= ((void *) (&((net_local *) NULL)->spy_data) -
-			   (void *) NULL),
+	.standard	= wavelan_handler,
+	.private	= wavelan_private_handler,
+	.private_args	= wavelan_private_args,
+	.get_wireless_stats = wavelan_get_wireless_stats,
 };
 
 /*------------------------------------------------------------------*/
@@ -4720,9 +4724,10 @@ wavelan_attach(void)
   dev->watchdog_timeo	= WATCHDOG_JIFFIES;
 
 #ifdef WIRELESS_EXT	/* If wireless extension exist in the kernel */
-  dev->wireless_handlers = (struct iw_handler_def *)&wavelan_handler_def;
-  dev->do_ioctl = wavelan_ioctl;	/* old wireless extensions */
-  dev->get_wireless_stats = wavelan_get_wireless_stats;
+  dev->wireless_handlers = &wavelan_handler_def;
+  dev->do_ioctl = wavelan_ioctl;	/* ethtool */
+  lp->wireless_data.spy_data = &lp->spy_data;
+  dev->wireless_data = &lp->wireless_data;
 #endif
 
   /* Other specific data */
diff -u -p -r linux/drivers/net/wireless.we16/wavelan_cs.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net/wireless.we16/wavelan_cs.p.h	Mon Aug  2 14:23:02 2004
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Tue Aug  3 11:32:06 2004
@@ -629,6 +629,7 @@ struct net_local
   iw_stats	wstats;		/* Wireless specific stats */
 
   struct iw_spy_data	spy_data;
+  struct iw_public_data	wireless_data;
 #endif
 
 #ifdef HISTOGRAM
@@ -725,6 +726,8 @@ static inline void
 /* ------------------- IOCTL, STATS & RECONFIG ------------------- */
 static en_stats	*
 	wavelan_get_stats(struct net_device *);	/* Give stats /proc/net/dev */
+static iw_stats *
+	wavelan_get_wireless_stats(struct net_device *);
 /* ----------------------- PACKET RECEPTION ----------------------- */
 static inline int
 	wv_start_of_frame(struct net_device *,	/* Seek beggining of current frame */
