Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUG1Hc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUG1Hc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUG1Hc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:32:26 -0400
Received: from ozlabs.org ([203.10.76.45]:394 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266793AbUG1HLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:48 -0400
Date: Wed, 28 Jul 2004 16:53:45 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [2/15] orinoco merge preliminaries - rearrange code
Message-ID: <20040728065345.GE16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065308.GD16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange functions in the orinoco driver in a more logical order.
This patch is large and looks complicated, but in fact only moves code
around (within or between files) without changing it.  The only
exceptions are some extra comments describing the file's layout, and
updated prototypes for the new function order.

This makes the order of functions match the 0.15rc1 version, so later
patches have a fighting chance of being meaningful.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 14:56:32.924732992 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 14:57:00.030612272 +1000
@@ -496,6 +496,10 @@
   HERMES_MAX_MULTICAST : 0)*/
 #define MAX_MULTICAST(priv)	(HERMES_MAX_MULTICAST)
 
+#define ORINOCO_INTEN	 	( HERMES_EV_RX | HERMES_EV_ALLOC | HERMES_EV_TX | \
+				HERMES_EV_TXEXC | HERMES_EV_WTERR | HERMES_EV_INFO | \
+				HERMES_EV_INFDROP )
+
 /********************************************************************/
 /* Data tables                                                      */
 /********************************************************************/
@@ -548,133 +552,55 @@
 
 #define ENCAPS_OVERHEAD		(sizeof(encaps_hdr) + 2)
 
+struct hermes_rx_descriptor {
+	u16 status;
+	u32 time;
+	u8 silence;
+	u8 signal;
+	u8 rate;
+	u8 rxflow;
+	u32 reserved;
+} __attribute__ ((packed));
+
 /********************************************************************/
 /* Function prototypes                                              */
 /********************************************************************/
 
-static void orinoco_stat_gather(struct net_device *dev,
-				struct sk_buff *skb,
-				struct hermes_rx_descriptor *desc);
-
-static struct net_device_stats *orinoco_get_stats(struct net_device *dev);
-static struct iw_statistics *orinoco_get_wireless_stats(struct net_device *dev);
-
-/* Hardware control routines */
-
+static int orinoco_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int __orinoco_program_rids(struct net_device *dev);
-
-static int __orinoco_hw_set_bitrate(struct orinoco_private *priv);
-static int __orinoco_hw_setup_wep(struct orinoco_private *priv);
-static int orinoco_hw_get_bssid(struct orinoco_private *priv, char buf[ETH_ALEN]);
-static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
-				char buf[IW_ESSID_MAX_SIZE+1]);
-static long orinoco_hw_get_freq(struct orinoco_private *priv);
-static int orinoco_hw_get_bitratelist(struct orinoco_private *priv, int *numrates,
-				      s32 *rates, int max);
 static void __orinoco_set_multicast_list(struct net_device *dev);
-
-/* Interrupt handling routines */
-static void __orinoco_ev_tick(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_wterr(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_infdrop(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_info(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_rx(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_txexc(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_tx(struct net_device *dev, hermes_t *hw);
-static void __orinoco_ev_alloc(struct net_device *dev, hermes_t *hw);
-
-/* ioctl() routines */
 static int orinoco_debug_dump_recs(struct net_device *dev);
 
 /********************************************************************/
-/* Function prototypes                                              */
+/* Internal helper functions                                        */
 /********************************************************************/
 
-int __orinoco_up(struct net_device *dev)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct hermes *hw = &priv->hw;
-	int err;
-
-	err = __orinoco_program_rids(dev);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d configuring card\n",
-		       dev->name, err);
-		return err;
-	}
-
-	/* Fire things up again */
-	hermes_set_irqmask(hw, ORINOCO_INTEN);
-	err = hermes_enable_port(hw, 0);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d enabling MAC port\n",
-		       dev->name, err);
-		return err;
-	}
-
-	netif_start_queue(dev);
-
-	return 0;
-}
-
-int __orinoco_down(struct net_device *dev)
+static inline void
+set_port_type(struct orinoco_private *priv)
 {
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct hermes *hw = &priv->hw;
-	int err;
-
-	netif_stop_queue(dev);
-
-	if (! priv->hw_unavailable) {
-		if (! priv->broken_disableport) {
-			err = hermes_disable_port(hw, 0);
-			if (err) {
-				/* Some firmwares (e.g. Intersil 1.3.x) seem
-				 * to have problems disabling the port, oh
-				 * well, too bad. */
-				printk(KERN_WARNING "%s: Error %d disabling MAC port\n",
-				       dev->name, err);
-				priv->broken_disableport = 1;
-			}
+	switch (priv->iw_mode) {
+	case IW_MODE_INFRA:
+		priv->port_type = 1;
+		priv->createibss = 0;
+		break;
+	case IW_MODE_ADHOC:
+		if (priv->prefer_port3) {
+			priv->port_type = 3;
+			priv->createibss = 0;
+		} else {
+			priv->port_type = priv->ibss_port;
+			priv->createibss = 1;
 		}
-		hermes_set_irqmask(hw, 0);
-		hermes_write_regn(hw, EVACK, 0xffff);
+		break;
+	default:
+		printk(KERN_ERR "%s: Invalid priv->iw_mode in set_port_type()\n",
+		       priv->ndev->name);
 	}
-	
-	/* firmware will have to reassociate */
-	priv->last_linkstatus = 0xffff;
-	priv->connected = 0;
-
-	return 0;
 }
 
-int orinoco_reinit_firmware(struct net_device *dev)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct hermes *hw = &priv->hw;
-	int err;
-
-	err = hermes_init(hw);
-	if (err)
-		return err;
-
-	err = hermes_allocate(hw, priv->nicbuf_size, &priv->txfid);
-	if (err == -EIO) {
-		/* Try workaround for old Symbol firmware bug */
-		printk(KERN_WARNING "%s: firmware ALLOC bug detected "
-		       "(old Symbol firmware?). Trying to work around... ",
-		       dev->name);
-		
-		priv->nicbuf_size = TX_NICBUF_SIZE_BUG;
-		err = hermes_allocate(hw, priv->nicbuf_size, &priv->txfid);
-		if (err)
-			printk("failed!\n");
-		else
-			printk("ok.\n");
-	}
-
-	return err;
-}
+/********************************************************************/
+/* Device methods                                                   */
+/********************************************************************/
 
 static int orinoco_open(struct net_device *dev)
 {
@@ -715,337 +641,323 @@
 	return err;
 }
 
-static int __orinoco_program_rids(struct net_device *dev)
+struct net_device_stats *
+orinoco_get_stats(struct net_device *dev)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	
+	return &priv->stats;
+}
+
+struct iw_statistics *
+orinoco_get_wireless_stats(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	hermes_t *hw = &priv->hw;
-	int err;
-	struct hermes_idstring idbuf;
+	struct iw_statistics *wstats = &priv->wstats;
+	int err = 0;
+	unsigned long flags;
 
-	/* Set the MAC address */
-	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFOWNMACADDR,
-			       HERMES_BYTES_TO_RECLEN(ETH_ALEN), dev->dev_addr);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting MAC address\n", dev->name, err);
-		return err;
+	if (! netif_device_present(dev)) {
+		printk(KERN_WARNING "%s: get_wireless_stats() called while device not present\n",
+		       dev->name);
+		return NULL; /* FIXME: Can we do better than this? */
 	}
 
-	/* Set up the link mode */
-	err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFPORTTYPE, priv->port_type);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting port type\n", dev->name, err);
-		return err;
-	}
-	/* Set the channel/frequency */
-	if (priv->channel == 0) {
-		printk(KERN_DEBUG "%s: Channel is 0 in __orinoco_program_rids()\n", dev->name);
-		if (priv->createibss)
-			priv->channel = 10;
-	}
-	err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFOWNCHANNEL, priv->channel);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting channel\n", dev->name, err);
-		return err;
-	}
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return NULL; /* FIXME: Erg, we've been signalled, how
+			      * do we propagate this back up? */
 
-	if (priv->has_ibss) {
-		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFCREATEIBSS,
-					   priv->createibss);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting CREATEIBSS\n", dev->name, err);
-			return err;
+	if (priv->iw_mode == IW_MODE_ADHOC) {
+		memset(&wstats->qual, 0, sizeof(wstats->qual));
+		/* If a spy address is defined, we report stats of the
+		 * first spy address - Jean II */
+		if (SPY_NUMBER(priv)) {
+			wstats->qual.qual = priv->spy_stat[0].qual;
+			wstats->qual.level = priv->spy_stat[0].level;
+			wstats->qual.noise = priv->spy_stat[0].noise;
+			wstats->qual.updated = priv->spy_stat[0].updated;
 		}
+	} else {
+		struct {
+			u16 qual, signal, noise;
+		} __attribute__ ((packed)) cq;
 
-		if ((strlen(priv->desired_essid) == 0) && (priv->createibss)
-		   && (!priv->has_ibss_any)) {
-			printk(KERN_WARNING "%s: This firmware requires an \
-ESSID in IBSS-Ad-Hoc mode.\n", dev->name);
-			/* With wvlan_cs, in this case, we would crash.
-			 * hopefully, this driver will behave better...
-			 * Jean II */
-		}
+		err = HERMES_READ_RECORD(hw, USER_BAP,
+					 HERMES_RID_COMMSQUALITY, &cq);
+		
+		wstats->qual.qual = (int)le16_to_cpu(cq.qual);
+		wstats->qual.level = (int)le16_to_cpu(cq.signal) - 0x95;
+		wstats->qual.noise = (int)le16_to_cpu(cq.noise) - 0x95;
+		wstats->qual.updated = 7;
 	}
 
-	/* Set the desired ESSID */
-	idbuf.len = cpu_to_le16(strlen(priv->desired_essid));
-	memcpy(&idbuf.val, priv->desired_essid, sizeof(idbuf.val));
-	/* WinXP wants partner to configure OWNSSID even in IBSS mode. (jimc) */
-	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFOWNSSID,
-			       HERMES_BYTES_TO_RECLEN(strlen(priv->desired_essid)+2),
-			       &idbuf);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting OWNSSID\n", dev->name, err);
-		return err;
-	}
-	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFDESIREDSSID,
-			       HERMES_BYTES_TO_RECLEN(strlen(priv->desired_essid)+2),
-			       &idbuf);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting DESIREDSSID\n", dev->name, err);
-		return err;
-	}
+	/* We can't really wait for the tallies inquiry command to
+	 * complete, so we just use the previous results and trigger
+	 * a new tallies inquiry command for next time - Jean II */
+	/* FIXME: We're in user context (I think?), so we should just
+           wait for the tallies to come through */
+	err = hermes_inquire(hw, HERMES_INQ_TALLIES);
+               
+	orinoco_unlock(priv, &flags);
 
-	/* Set the station name */
-	idbuf.len = cpu_to_le16(strlen(priv->nick));
-	memcpy(&idbuf.val, priv->nick, sizeof(idbuf.val));
-	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFOWNNAME,
-			       HERMES_BYTES_TO_RECLEN(strlen(priv->nick)+2),
-			       &idbuf);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting nickname\n", dev->name, err);
-		return err;
-	}
+	if (err)
+		return NULL;
+		
+	return wstats;
+}
 
-	/* Set AP density */
-	if (priv->has_sensitivity) {
-		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFSYSTEMSCALE,
-					   priv->ap_density);
-		if (err) {
-			printk(KERN_WARNING "%s: Error %d setting SYSTEMSCALE.  "
-			       "Disabling sensitivity control\n", dev->name, err);
+static void
+orinoco_set_multicast_list(struct net_device *dev)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	unsigned long flags;
 
-			priv->has_sensitivity = 0;
-		}
+	if (orinoco_lock(priv, &flags) != 0) {
+		printk(KERN_DEBUG "%s: orinoco_set_multicast_list() "
+		       "called when hw_unavailable\n", dev->name);
+		return;
 	}
 
-	/* Set RTS threshold */
-	err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFRTSTHRESHOLD, priv->rts_thresh);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting RTS threshold\n", dev->name, err);
-		return err;
-	}
-
-	/* Set fragmentation threshold or MWO robustness */
-	if (priv->has_mwo)
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFMWOROBUST_AGERE,
-					   priv->mwo_robust);
-	else
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFFRAGMENTATIONTHRESHOLD,
-					   priv->frag_thresh);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting framentation\n", dev->name, err);
-		return err;
-	}
-
-	/* Set bitrate */
-	err = __orinoco_hw_set_bitrate(priv);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d setting bitrate\n", dev->name, err);
-		return err;
-	}
-
-	/* Set power management */
-	if (priv->has_pm) {
-		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFPMENABLED,
-					   priv->pm_on);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting up PM\n",
-			       dev->name, err);
-			return err;
-		}
+	__orinoco_set_multicast_list(dev);
+	orinoco_unlock(priv, &flags);
+}
 
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFMULTICASTRECEIVE,
-					   priv->pm_mcast);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting up PM\n",
-			       dev->name, err);
-			return err;
-		}
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFMAXSLEEPDURATION,
-					   priv->pm_period);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting up PM\n",
-			       dev->name, err);
-			return err;
-		}
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFPMHOLDOVERDURATION,
-					   priv->pm_timeout);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting up PM\n",
-			       dev->name, err);
-			return err;
-		}
-	}
+static int
+orinoco_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
 
-	/* Set preamble - only for Symbol so far... */
-	if (priv->has_preamble) {
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFPREAMBLE_SYMBOL,
-					   priv->preamble);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting preamble\n",
-			       dev->name, err);
-			return err;
-		}
-	}
+	if ( (new_mtu < ORINOCO_MIN_MTU) || (new_mtu > ORINOCO_MAX_MTU) )
+		return -EINVAL;
 
-	/* Set up encryption */
-	if (priv->has_wep) {
-		err = __orinoco_hw_setup_wep(priv);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d activating WEP\n",
-			       dev->name, err);
-			return err;
-		}
-	}
+	if ( (new_mtu + ENCAPS_OVERHEAD + IEEE802_11_HLEN) >
+	     (priv->nicbuf_size - ETH_HLEN) )
+		return -EINVAL;
 
-	/* Set promiscuity / multicast*/
-	priv->promiscuous = 0;
-	priv->mc_count = 0;
-	__orinoco_set_multicast_list(dev); /* FIXME: what about the xmit_lock */
+	dev->mtu = new_mtu;
 
 	return 0;
 }
 
-/* xyzzy */
-static int orinoco_reconfigure(struct net_device *dev)
+/********************************************************************/
+/* Tx path                                                          */
+/********************************************************************/
+
+static int
+orinoco_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
-	struct hermes *hw = &priv->hw;
-	unsigned long flags;
+	struct net_device_stats *stats = &priv->stats;
+	hermes_t *hw = &priv->hw;
 	int err = 0;
+	u16 txfid = priv->txfid;
+	char *p;
+	struct ethhdr *eh;
+	int len, data_len, data_off;
+	struct hermes_tx_descriptor desc;
+	unsigned long flags;
 
-	if (priv->broken_disableport) {
-		schedule_work(&priv->reset_work);
+	TRACE_ENTER(dev->name);
+
+	if (! netif_running(dev)) {
+		printk(KERN_ERR "%s: Tx on stopped device!\n",
+		       dev->name);
+		TRACE_EXIT(dev->name);
+		return 1;
+	}
+	
+	if (netif_queue_stopped(dev)) {
+		printk(KERN_DEBUG "%s: Tx while transmitter busy!\n", 
+		       dev->name);
+		TRACE_EXIT(dev->name);
+		return 1;
+	}
+	
+	if (orinoco_lock(priv, &flags) != 0) {
+		printk(KERN_ERR "%s: orinoco_xmit() called while hw_unavailable\n",
+		       dev->name);
+		TRACE_EXIT(dev->name);
+/*  		BUG(); */
+		return 1;
+	}
+
+	if (! priv->connected) {
+		/* Oops, the firmware hasn't established a connection,
+                   silently drop the packet (this seems to be the
+                   safest approach). */
+		stats->tx_errors++;
+		orinoco_unlock(priv, &flags);
+		dev_kfree_skb(skb);
+		TRACE_EXIT(dev->name);
 		return 0;
 	}
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	/* Length of the packet body */
+	/* FIXME: what if the skb is smaller than this? */
+	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
 
-		
-	err = hermes_disable_port(hw, 0);
+	eh = (struct ethhdr *)skb->data;
+
+	memset(&desc, 0, sizeof(desc));
+ 	desc.tx_control = cpu_to_le16(HERMES_TXCTRL_TX_OK | HERMES_TXCTRL_TX_EX);
+	err = hermes_bap_pwrite(hw, USER_BAP, &desc, sizeof(desc), txfid, 0);
 	if (err) {
-		printk(KERN_WARNING "%s: Unable to disable port while reconfiguring card\n",
-		       dev->name);
-		priv->broken_disableport = 1;
-		goto out;
+		printk(KERN_ERR "%s: Error %d writing Tx descriptor to BAP\n",
+		       dev->name, err);
+		stats->tx_errors++;
+		goto fail;
 	}
 
-	err = __orinoco_program_rids(dev);
-	if (err) {
-		printk(KERN_WARNING "%s: Unable to reconfigure card\n",
-		       dev->name);
-		goto out;
+	/* Clear the 802.11 header and data length fields - some
+	 * firmwares (e.g. Lucent/Agere 8.xx) appear to get confused
+	 * if this isn't done. */
+	hermes_clear_words(hw, HERMES_DATA0,
+			   HERMES_802_3_OFFSET - HERMES_802_11_OFFSET);
+
+	/* Encapsulate Ethernet-II frames */
+	if (ntohs(eh->h_proto) > 1500) { /* Ethernet-II frame */
+		struct header_struct hdr;
+		data_len = len;
+		data_off = HERMES_802_3_OFFSET + sizeof(hdr);
+		p = skb->data + ETH_HLEN;
+
+		/* 802.3 header */
+		memcpy(hdr.dest, eh->h_dest, ETH_ALEN);
+		memcpy(hdr.src, eh->h_source, ETH_ALEN);
+		hdr.len = htons(data_len + ENCAPS_OVERHEAD);
+		
+		/* 802.2 header */
+		memcpy(&hdr.dsap, &encaps_hdr, sizeof(encaps_hdr));
+			
+		hdr.ethertype = eh->h_proto;
+		err  = hermes_bap_pwrite(hw, USER_BAP, &hdr, sizeof(hdr),
+					 txfid, HERMES_802_3_OFFSET);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d writing packet header to BAP\n",
+			       dev->name, err);
+			stats->tx_errors++;
+			goto fail;
+		}
+	} else { /* IEEE 802.3 frame */
+		data_len = len + ETH_HLEN;
+		data_off = HERMES_802_3_OFFSET;
+		p = skb->data;
 	}
 
-	err = hermes_enable_port(hw, 0);
+	/* Round up for odd length packets */
+	err = hermes_bap_pwrite(hw, USER_BAP, p, RUP_EVEN(data_len), txfid, data_off);
 	if (err) {
-		printk(KERN_WARNING "%s: Unable to enable port while reconfiguring card\n",
-		       dev->name);
-		goto out;
+		printk(KERN_ERR "%s: Error %d writing packet to BAP\n",
+		       dev->name, err);
+		stats->tx_errors++;
+		goto fail;
 	}
 
- out:
+	/* Finally, we actually initiate the send */
+	netif_stop_queue(dev);
+
+	err = hermes_docmd_wait(hw, HERMES_CMD_TX | HERMES_CMD_RECL, txfid, NULL);
 	if (err) {
-		printk(KERN_WARNING "%s: Resetting instead...\n", dev->name);
-		schedule_work(&priv->reset_work);
-		err = 0;
+		netif_start_queue(dev);
+		printk(KERN_ERR "%s: Error %d transmitting packet\n", dev->name, err);
+		stats->tx_errors++;
+		goto fail;
 	}
 
+	dev->trans_start = jiffies;
+	stats->tx_bytes += data_off + data_len;
+
 	orinoco_unlock(priv, &flags);
-	return err;
 
+	dev_kfree_skb(skb);
+
+	TRACE_EXIT(dev->name);
+
+	return 0;
+ fail:
+	TRACE_EXIT(dev->name);
+
+	orinoco_unlock(priv, &flags);
+	return err;
 }
 
-/* This must be called from user context, without locks held - use
- * schedule_work() */
-static void orinoco_reset(struct net_device *dev)
+static void __orinoco_ev_alloc(struct net_device *dev, hermes_t *hw)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
-	struct hermes *hw = &priv->hw;
-	int err;
-	unsigned long flags;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		/* When the hardware becomes available again, whatever
-		 * detects that is responsible for re-initializing
-		 * it. So no need for anything further*/
-		return;
+	u16 fid = hermes_read_regn(hw, ALLOCFID);
 
-	netif_stop_queue(dev);
+	if (fid != priv->txfid) {
+		if (fid != DUMMY_FID)
+			printk(KERN_WARNING "%s: Allocate event on unexpected fid (%04X)\n",
+			       dev->name, fid);
+		return;
+	} else {
+		netif_wake_queue(dev);
+	}
 
-	/* Shut off interrupts.  Depending on what state the hardware
-	 * is in, this might not work, but we'll try anyway */
-	hermes_set_irqmask(hw, 0);
-	hermes_write_regn(hw, EVACK, 0xffff);
+	hermes_write_regn(hw, ALLOCFID, DUMMY_FID);
+}
 
-	priv->hw_unavailable++;
-	priv->last_linkstatus = 0xffff; /* firmware will have to reassociate */
-	priv->connected = 0;
+static void __orinoco_ev_tx(struct net_device *dev, hermes_t *hw)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &priv->stats;
 
-	orinoco_unlock(priv, &flags);
+	stats->tx_packets++;
 
-	if (priv->hard_reset)
-		err = (*priv->hard_reset)(priv);
-	if (err) {
-		printk(KERN_ERR "%s: orinoco_reset: Error %d performing hard reset\n",
-		       dev->name, err);
-		/* FIXME: shutdown of some sort */
-		return;
-	}
+	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
+}
 
-	err = orinoco_reinit_firmware(dev);
+static void __orinoco_ev_txexc(struct net_device *dev, hermes_t *hw)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &priv->stats;
+	u16 fid = hermes_read_regn(hw, TXCOMPLFID);
+	struct hermes_tx_descriptor desc;
+	int err = 0;
+
+	if (fid == DUMMY_FID)
+		return; /* Nothing's really happened */
+
+	err = hermes_bap_pread(hw, IRQ_BAP, &desc, sizeof(desc), fid, 0);
 	if (err) {
-		printk(KERN_ERR "%s: orinoco_reset: Error %d re-initializing firmware\n",
-		       dev->name, err);
-		return;
+		printk(KERN_WARNING "%s: Unable to read descriptor on Tx error "
+		       "(FID=%04X error %d)\n",
+		       dev->name, fid, err);
+	} else {
+		DEBUG(1, "%s: Tx error, status %d\n",
+		      dev->name, le16_to_cpu(desc.status));
 	}
+	
+	stats->tx_errors++;
 
-	spin_lock_irq(&priv->lock); /* This has to be called from user context */
+	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
+}
 
-	priv->hw_unavailable--;
+static void
+orinoco_tx_timeout(struct net_device *dev)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &priv->stats;
+	struct hermes *hw = &priv->hw;
 
-	/* priv->open or priv->hw_unavailable might have changed while
-	 * we dropped the lock */
-	if (priv->open && (! priv->hw_unavailable)) {
-		err = __orinoco_up(dev);
-		if (err) {
-			printk(KERN_ERR "%s: orinoco_reset: Error %d reenabling card\n",
-			       dev->name, err);
-		} else
-			dev->trans_start = jiffies;
-	}
+	printk(KERN_WARNING "%s: Tx timeout! "
+	       "ALLOCFID=%04x, TXCOMPLFID=%04x, EVSTAT=%04x\n",
+	       dev->name, hermes_read_regn(hw, ALLOCFID),
+	       hermes_read_regn(hw, TXCOMPLFID), hermes_read_regn(hw, EVSTAT));
 
-	spin_unlock_irq(&priv->lock);
+	stats->tx_errors++;
 
-	return;
+	schedule_work(&priv->reset_work);
 }
 
 /********************************************************************/
-/* Internal helper functions                                        */
+/* Rx path (data frames)                                            */
 /********************************************************************/
 
-static inline void
-set_port_type(struct orinoco_private *priv)
-{
-	switch (priv->iw_mode) {
-	case IW_MODE_INFRA:
-		priv->port_type = 1;
-		priv->createibss = 0;
-		break;
-	case IW_MODE_ADHOC:
-		if (priv->prefer_port3) {
-			priv->port_type = 3;
-			priv->createibss = 0;
-		} else {
-			priv->port_type = priv->ibss_port;
-			priv->createibss = 1;
-		}
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid priv->iw_mode in set_port_type()\n",
-		       priv->ndev->name);
-	}
-}
-
 /* Does the frame have a SNAP header indicating it should be
  * de-encapsulated to Ethernet-II? */
 static inline int
@@ -1060,804 +972,1033 @@
 		&& ( (hdr->oui[2] == 0x00) || (hdr->oui[2] == 0xf8) );
 }
 
-static void
-orinoco_set_multicast_list(struct net_device *dev)
+static inline void orinoco_spy_gather(struct net_device *dev, u_char *mac,
+				    int level, int noise)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
-	unsigned long flags;
-
-	if (orinoco_lock(priv, &flags) != 0) {
-		printk(KERN_DEBUG "%s: orinoco_set_multicast_list() "
-		       "called when hw_unavailable\n", dev->name);
-		return;
-	}
+	int i;
 
-	__orinoco_set_multicast_list(dev);
-	orinoco_unlock(priv, &flags);
+	/* Gather wireless spy statistics: for each packet, compare the
+	 * source address with out list, and if match, get the stats... */
+	for (i = 0; i < priv->spy_number; i++)
+		if (!memcmp(mac, priv->spy_address[i], ETH_ALEN)) {
+			priv->spy_stat[i].level = level - 0x95;
+			priv->spy_stat[i].noise = noise - 0x95;
+			priv->spy_stat[i].qual = (level > noise) ? (level - noise) : 0;
+			priv->spy_stat[i].updated = 7;
+		}
 }
 
-/********************************************************************/
-/* Hardware control functions                                       */
-/********************************************************************/
+void
+orinoco_stat_gather(struct net_device *dev,
+		    struct sk_buff *skb,
+		    struct hermes_rx_descriptor *desc)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
 
+	/* Using spy support with lots of Rx packets, like in an
+	 * infrastructure (AP), will really slow down everything, because
+	 * the MAC address must be compared to each entry of the spy list.
+	 * If the user really asks for it (set some address in the
+	 * spy list), we do it, but he will pay the price.
+	 * Note that to get here, you need both WIRELESS_SPY
+	 * compiled in AND some addresses in the list !!!
+	 */
+	/* Note : gcc will optimise the whole section away if
+	 * WIRELESS_SPY is not defined... - Jean II */
+	if (SPY_NUMBER(priv)) {
+		orinoco_spy_gather(dev, skb->mac.raw + ETH_ALEN,
+				   desc->signal, desc->silence);
+	}
+}
 
-static int __orinoco_hw_set_bitrate(struct orinoco_private *priv)
+static void __orinoco_ev_rx(struct net_device *dev, hermes_t *hw)
 {
-	hermes_t *hw = &priv->hw;
-	int err = 0;
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &priv->stats;
+	struct iw_statistics *wstats = &priv->wstats;
+	struct sk_buff *skb = NULL;
+	u16 rxfid, status;
+	int length, data_len, data_off;
+	char *p;
+	struct hermes_rx_descriptor desc;
+	struct header_struct hdr;
+	struct ethhdr *eh;
+	int err;
 
-	if (priv->bitratemode >= BITRATE_TABLE_SIZE) {
-		printk(KERN_ERR "%s: BUG: Invalid bitrate mode %d\n",
-		       priv->ndev->name, priv->bitratemode);
-		return -EINVAL;
+	rxfid = hermes_read_regn(hw, RXFID);
+
+	err = hermes_bap_pread(hw, IRQ_BAP, &desc, sizeof(desc),
+			       rxfid, 0);
+	if (err) {
+		printk(KERN_ERR "%s: error %d reading Rx descriptor. "
+		       "Frame dropped.\n", dev->name, err);
+		stats->rx_errors++;
+		goto drop;
 	}
 
-	switch (priv->firmware_type) {
-	case FIRMWARE_TYPE_AGERE:
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFTXRATECONTROL,
-					   bitrate_table[priv->bitratemode].agere_txratectrl);
-		break;
-	case FIRMWARE_TYPE_INTERSIL:
-	case FIRMWARE_TYPE_SYMBOL:
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFTXRATECONTROL,
-					   bitrate_table[priv->bitratemode].intersil_txratectrl);
-		break;
-	default:
-		BUG();
+	status = le16_to_cpu(desc.status);
+	
+	if (status & HERMES_RXSTAT_ERR) {
+		if (status & HERMES_RXSTAT_UNDECRYPTABLE) {
+			wstats->discard.code++;
+			DEBUG(1, "%s: Undecryptable frame on Rx. Frame dropped.\n",
+			       dev->name);
+		} else {
+			stats->rx_crc_errors++;
+			DEBUG(1, "%s: Bad CRC on Rx. Frame dropped.\n", dev->name);
+		}
+		stats->rx_errors++;
+		goto drop;
 	}
 
-	return err;
-}
+	/* For now we ignore the 802.11 header completely, assuming
+           that the card's firmware has handled anything vital */
 
+	err = hermes_bap_pread(hw, IRQ_BAP, &hdr, sizeof(hdr),
+			       rxfid, HERMES_802_3_OFFSET);
+	if (err) {
+		printk(KERN_ERR "%s: error %d reading frame header. "
+		       "Frame dropped.\n", dev->name, err);
+		stats->rx_errors++;
+		goto drop;
+	}
 
-static int __orinoco_hw_setup_wep(struct orinoco_private *priv)
-{
-	hermes_t *hw = &priv->hw;
-	int err = 0;
-	int	master_wep_flag;
-	int	auth_flag;
+	length = ntohs(hdr.len);
+	
+	/* Sanity checks */
+	if (length < 3) { /* No for even an 802.2 LLC header */
+		/* At least on Symbol firmware with PCF we get quite a
+                   lot of these legitimately - Poll frames with no
+                   data. */
+		stats->rx_dropped++;
+		goto drop;
+	}
+	if (length > IEEE802_11_DATA_LEN) {
+		printk(KERN_WARNING "%s: Oversized frame received (%d bytes)\n",
+		       dev->name, length);
+		stats->rx_length_errors++;
+		stats->rx_errors++;
+		goto drop;
+	}
 
-	switch (priv->firmware_type) {
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
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFWEPENABLED_AGERE,
-					   priv->wep_on);
-		if (err)
-			return err;
-		break;
-
-	case FIRMWARE_TYPE_INTERSIL: /* Intersil style WEP */
-	case FIRMWARE_TYPE_SYMBOL: /* Symbol style WEP */
-		master_wep_flag = 0;		/* Off */
-		if (priv->wep_on) {
-			int keylen;
-			int i;
-
-			/* Fudge around firmware weirdness */
-			keylen = le16_to_cpu(priv->keys[priv->tx_key].len);
-			
-			/* Write all 4 keys */
-			for(i = 0; i < ORINOCO_MAX_KEYS; i++) {
-/*  				int keylen = le16_to_cpu(priv->keys[i].len); */
-				
-				if (keylen > LARGE_KEY_SIZE) {
-					printk(KERN_ERR "%s: BUG: Key %d has oversize length %d.\n",
-					       priv->ndev->name, i, keylen);
-					return -E2BIG;
-				}
-
-				err = hermes_write_ltv(hw, USER_BAP,
-						       HERMES_RID_CNFDEFAULTKEY0 + i,
-						       HERMES_BYTES_TO_RECLEN(keylen),
-						       priv->keys[i].data);
-				if (err)
-					return err;
-			}
+	/* We need space for the packet data itself, plus an ethernet
+	   header, plus 2 bytes so we can align the IP header on a
+	   32bit boundary, plus 1 byte so we can read in odd length
+	   packets from the card, which has an IO granularity of 16
+	   bits */  
+	skb = dev_alloc_skb(length+ETH_HLEN+2+1);
+	if (!skb) {
+		printk(KERN_WARNING "%s: Can't allocate skb for Rx\n",
+		       dev->name);
+		goto drop;
+	}
 
-			/* Write the index of the key used in transmission */
-			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFWEPDEFAULTKEYID,
-						   priv->tx_key);
-			if (err)
-				return err;
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
+	skb_reserve(skb, 2); /* This way the IP header is aligned */
 
+	/* Handle decapsulation
+	 * In most cases, the firmware tell us about SNAP frames.
+	 * For some reason, the SNAP frames sent by LinkSys APs
+	 * are not properly recognised by most firmwares.
+	 * So, check ourselves */
+	if(((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_1042) ||
+	   ((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_TUNNEL) ||
+	   is_ethersnap(&hdr)) {
+		/* These indicate a SNAP within 802.2 LLC within
+		   802.11 frame which we'll need to de-encapsulate to
+		   the original EthernetII frame. */
 
-			err = hermes_write_wordrec(hw, USER_BAP,
-						   HERMES_RID_CNFAUTHENTICATION, auth_flag);
-			if (err)
-				return err;
+		if (length < ENCAPS_OVERHEAD) { /* No room for full LLC+SNAP */
+			stats->rx_length_errors++;
+			goto drop;
 		}
-		
-		/* Master WEP setting : on/off */
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFWEPFLAGS_INTERSIL,
-					   master_wep_flag);
-		if (err)
-			return err;	
 
-		break;
+		/* Remove SNAP header, reconstruct EthernetII frame */
+		data_len = length - ENCAPS_OVERHEAD;
+		data_off = HERMES_802_3_OFFSET + sizeof(hdr);
 
-	default:
-		if (priv->wep_on) {
-			printk(KERN_ERR "%s: WEP enabled, although not supported!\n",
-			       priv->ndev->name);
-			return -EINVAL;
-		}
+		eh = (struct ethhdr *)skb_put(skb, ETH_HLEN);
+
+		memcpy(eh, &hdr, 2 * ETH_ALEN);
+		eh->h_proto = hdr.ethertype;
+	} else {
+		/* All other cases indicate a genuine 802.3 frame.  No
+		   decapsulation needed.  We just throw the whole
+		   thing in, and hope the protocol layer can deal with
+		   it as 802.3 */
+		data_len = length;
+		data_off = HERMES_802_3_OFFSET;
+		/* FIXME: we re-read from the card data we already read here */
 	}
 
-	return 0;
-}
+	p = skb_put(skb, data_len);
+	err = hermes_bap_pread(hw, IRQ_BAP, p, RUP_EVEN(data_len),
+			       rxfid, data_off);
+	if (err) {
+		printk(KERN_ERR "%s: error %d reading frame. "
+		       "Frame dropped.\n", dev->name, err);
+		stats->rx_errors++;
+		goto drop;
+	}
 
-static int orinoco_hw_get_bssid(struct orinoco_private *priv,
-				char buf[ETH_ALEN])
-{
-	hermes_t *hw = &priv->hw;
-	int err = 0;
-	unsigned long flags;
+	dev->last_rx = jiffies;
+	skb->dev = dev;
+	skb->protocol = eth_type_trans(skb, dev);
+	skb->ip_summed = CHECKSUM_NONE;
+	
+	/* Process the wireless stats if needed */
+	orinoco_stat_gather(dev, skb, &desc);
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	/* Pass the packet to the networking stack */
+	netif_rx(skb);
+	stats->rx_packets++;
+	stats->rx_bytes += length;
 
-	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_CURRENTBSSID,
-			      ETH_ALEN, NULL, buf);
+	return;
 
-	orinoco_unlock(priv, &flags);
+ drop:	
+	stats->rx_dropped++;
 
-	return err;
+	if (skb)
+		dev_kfree_skb_irq(skb);
+	return;
 }
 
-static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
-				char buf[IW_ESSID_MAX_SIZE+1])
-{
-	hermes_t *hw = &priv->hw;
-	int err = 0;
-	struct hermes_idstring essidbuf;
-	char *p = (char *)(&essidbuf.val);
-	int len;
-	unsigned long flags;
-
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
-
-	if (strlen(priv->desired_essid) > 0) {
-		/* We read the desired SSID from the hardware rather
-		   than from priv->desired_essid, just in case the
-		   firmware is allowed to change it on us. I'm not
-		   sure about this */
-		/* My guess is that the OWNSSID should always be whatever
-		 * we set to the card, whereas CURRENT_SSID is the one that
-		 * may change... - Jean II */
-		u16 rid;
+/********************************************************************/
+/* Rx path (info frames)                                            */
+/********************************************************************/
 
-		*active = 1;
+static void print_linkstatus(struct net_device *dev, u16 status)
+{
+	char * s;
 
-		rid = (priv->port_type == 3) ? HERMES_RID_CNFOWNSSID :
-			HERMES_RID_CNFDESIREDSSID;
-		
-		err = hermes_read_ltv(hw, USER_BAP, rid, sizeof(essidbuf),
-				      NULL, &essidbuf);
-		if (err)
-			goto fail_unlock;
-	} else {
-		*active = 0;
+	if (suppress_linkstatus)
+		return;
 
-		err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_CURRENTSSID,
-				      sizeof(essidbuf), NULL, &essidbuf);
-		if (err)
-			goto fail_unlock;
+	switch (status) {
+	case HERMES_LINKSTATUS_NOT_CONNECTED:
+		s = "Not Connected";
+		break;
+	case HERMES_LINKSTATUS_CONNECTED:
+		s = "Connected";
+		break;
+	case HERMES_LINKSTATUS_DISCONNECTED:
+		s = "Disconnected";
+		break;
+	case HERMES_LINKSTATUS_AP_CHANGE:
+		s = "AP Changed";
+		break;
+	case HERMES_LINKSTATUS_AP_OUT_OF_RANGE:
+		s = "AP Out of Range";
+		break;
+	case HERMES_LINKSTATUS_AP_IN_RANGE:
+		s = "AP In Range";
+		break;
+	case HERMES_LINKSTATUS_ASSOC_FAILED:
+		s = "Association Failed";
+		break;
+	default:
+		s = "UNKNOWN";
 	}
-
-	len = le16_to_cpu(essidbuf.len);
-
-	memset(buf, 0, IW_ESSID_MAX_SIZE+1);
-	memcpy(buf, p, len);
-	buf[len] = '\0';
-
- fail_unlock:
-	orinoco_unlock(priv, &flags);
-
-	return err;       
+	
+	printk(KERN_INFO "%s: New link status: %s (%04x)\n",
+	       dev->name, s, status);
 }
 
-static long orinoco_hw_get_freq(struct orinoco_private *priv)
+static void __orinoco_ev_info(struct net_device *dev, hermes_t *hw)
 {
-	
-	hermes_t *hw = &priv->hw;
-	int err = 0;
-	u16 channel;
-	long freq = 0;
-	unsigned long flags;
+	struct orinoco_private *priv = netdev_priv(dev);
+	u16 infofid;
+	struct {
+		u16 len;
+		u16 type;
+	} __attribute__ ((packed)) info;
+	int len, type;
+	int err;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	/* This is an answer to an INQUIRE command that we did earlier,
+	 * or an information "event" generated by the card
+	 * The controller return to us a pseudo frame containing
+	 * the information in question - Jean II */
+	infofid = hermes_read_regn(hw, INFOFID);
+
+	/* Read the info frame header - don't try too hard */
+	err = hermes_bap_pread(hw, IRQ_BAP, &info, sizeof(info),
+			       infofid, 0);
+	if (err) {
+		printk(KERN_ERR "%s: error %d reading info frame. "
+		       "Frame dropped.\n", dev->name, err);
+		return;
+	}
 	
-	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CURRENTCHANNEL, &channel);
-	if (err)
-		goto out;
+	len = HERMES_RECLEN_TO_BYTES(le16_to_cpu(info.len));
+	type = le16_to_cpu(info.type);
 
-	/* Intersil firmware 1.3.5 returns 0 when the interface is down */
-	if (channel == 0) {
-		err = -EBUSY;
-		goto out;
+	switch (type) {
+	case HERMES_INQ_TALLIES: {
+		struct hermes_tallies_frame tallies;
+		struct iw_statistics *wstats = &priv->wstats;
+		
+		if (len > sizeof(tallies)) {
+			printk(KERN_WARNING "%s: Tallies frame too long (%d bytes)\n",
+			       dev->name, len);
+			len = sizeof(tallies);
+		}
+		
+		/* Read directly the data (no seek) */
+		hermes_read_words(hw, HERMES_DATA1, (void *) &tallies,
+				  len / 2); /* FIXME: blech! */
+		
+		/* Increment our various counters */
+		/* wstats->discard.nwid - no wrong BSSID stuff */
+		wstats->discard.code +=
+			le16_to_cpu(tallies.RxWEPUndecryptable);
+		if (len == sizeof(tallies))  
+			wstats->discard.code +=
+				le16_to_cpu(tallies.RxDiscards_WEPICVError) +
+				le16_to_cpu(tallies.RxDiscards_WEPExcluded);
+		wstats->discard.misc +=
+			le16_to_cpu(tallies.TxDiscardsWrongSA);
+		wstats->discard.fragment +=
+			le16_to_cpu(tallies.RxMsgInBadMsgFragments);
+		wstats->discard.retries +=
+			le16_to_cpu(tallies.TxRetryLimitExceeded);
+		/* wstats->miss.beacon - no match */
 	}
+	break;
+	case HERMES_INQ_LINKSTATUS: {
+		struct hermes_linkstatus linkstatus;
+		u16 newstatus;
+		
+		if (len != sizeof(linkstatus)) {
+			printk(KERN_WARNING "%s: Unexpected size for linkstatus frame (%d bytes)\n",
+			       dev->name, len);
+			break;
+		}
 
-	if ( (channel < 1) || (channel > NUM_CHANNELS) ) {
-		printk(KERN_WARNING "%s: Channel out of range (%d)!\n",
-		       priv->ndev->name, channel);
-		err = -EBUSY;
-		goto out;
+		hermes_read_words(hw, HERMES_DATA1, (void *) &linkstatus,
+				  len / 2);
+		newstatus = le16_to_cpu(linkstatus.linkstatus);
 
-	}
-	freq = channel_frequency[channel-1] * 100000;
+		if ( (newstatus == HERMES_LINKSTATUS_CONNECTED)
+		     || (newstatus == HERMES_LINKSTATUS_AP_CHANGE)
+		     || (newstatus == HERMES_LINKSTATUS_AP_IN_RANGE) )
+			priv->connected = 1;
+		else if ( (newstatus == HERMES_LINKSTATUS_NOT_CONNECTED)
+			  || (newstatus == HERMES_LINKSTATUS_DISCONNECTED)
+			  || (newstatus == HERMES_LINKSTATUS_AP_OUT_OF_RANGE)
+			  || (newstatus == HERMES_LINKSTATUS_ASSOC_FAILED) )
+			priv->connected = 0;
 
- out:
-	orinoco_unlock(priv, &flags);
+		if (newstatus != priv->last_linkstatus)
+			print_linkstatus(dev, newstatus);
 
-	if (err > 0)
-		err = -EBUSY;
-	return err ? err : freq;
+		priv->last_linkstatus = newstatus;
+	}
+	break;
+	default:
+		printk(KERN_DEBUG "%s: Unknown information frame received (type %04x).\n",
+		      dev->name, type);
+		/* We don't actually do anything about it */
+		break;
+	}
 }
 
-static int orinoco_hw_get_bitratelist(struct orinoco_private *priv,
-				      int *numrates, s32 *rates, int max)
+static void __orinoco_ev_infdrop(struct net_device *dev, hermes_t *hw)
 {
-	hermes_t *hw = &priv->hw;
-	struct hermes_idstring list;
-	unsigned char *p = (unsigned char *)&list.val;
-	int err = 0;
-	int num;
-	int i;
-	unsigned long flags;
+	if (net_ratelimit())
+		printk(KERN_WARNING "%s: Information frame lost.\n", dev->name);
+}
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+/********************************************************************/
+/* Internal hardware control routines                               */
+/********************************************************************/
 
-	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_SUPPORTEDDATARATES,
-			      sizeof(list), NULL, &list);
-	orinoco_unlock(priv, &flags);
+int __orinoco_up(struct net_device *dev)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct hermes *hw = &priv->hw;
+	int err;
 
-	if (err)
+	err = __orinoco_program_rids(dev);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d configuring card\n",
+		       dev->name, err);
 		return err;
-	
-	num = le16_to_cpu(list.len);
-	*numrates = num;
-	num = min(num, max);
+	}
 
-	for (i = 0; i < num; i++) {
-		rates[i] = (p[i] & 0x7f) * 500000; /* convert to bps */
+	/* Fire things up again */
+	hermes_set_irqmask(hw, ORINOCO_INTEN);
+	err = hermes_enable_port(hw, 0);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d enabling MAC port\n",
+		       dev->name, err);
+		return err;
 	}
 
+	netif_start_queue(dev);
+
 	return 0;
 }
 
-#if 0
-static void show_rx_frame(struct orinoco_rxframe_hdr *frame)
+int __orinoco_down(struct net_device *dev)
 {
-	printk(KERN_DEBUG "RX descriptor:\n");
-	printk(KERN_DEBUG "  status      = 0x%04x\n", frame->desc.status);
-	printk(KERN_DEBUG "  time        = 0x%08x\n", frame->desc.time);
-	printk(KERN_DEBUG "  silence     = 0x%02x\n", frame->desc.silence);
-	printk(KERN_DEBUG "  signal      = 0x%02x\n", frame->desc.signal);
-	printk(KERN_DEBUG "  rate        = 0x%02x\n", frame->desc.rate);
-	printk(KERN_DEBUG "  rxflow      = 0x%02x\n", frame->desc.rxflow);
-	printk(KERN_DEBUG "  reserved    = 0x%08x\n", frame->desc.reserved);
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct hermes *hw = &priv->hw;
+	int err;
 
-	printk(KERN_DEBUG "IEEE 802.11 header:\n");
-	printk(KERN_DEBUG "  frame_ctl   = 0x%04x\n",
-	       frame->p80211.frame_ctl);
-	printk(KERN_DEBUG "  duration_id = 0x%04x\n",
-	       frame->p80211.duration_id);
-	printk(KERN_DEBUG "  addr1       = %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       frame->p80211.addr1[0], frame->p80211.addr1[1],
-	       frame->p80211.addr1[2], frame->p80211.addr1[3],
-	       frame->p80211.addr1[4], frame->p80211.addr1[5]);
-	printk(KERN_DEBUG "  addr2       = %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       frame->p80211.addr2[0], frame->p80211.addr2[1],
-	       frame->p80211.addr2[2], frame->p80211.addr2[3],
-	       frame->p80211.addr2[4], frame->p80211.addr2[5]);
-	printk(KERN_DEBUG "  addr3       = %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       frame->p80211.addr3[0], frame->p80211.addr3[1],
-	       frame->p80211.addr3[2], frame->p80211.addr3[3],
-	       frame->p80211.addr3[4], frame->p80211.addr3[5]);
-	printk(KERN_DEBUG "  seq_ctl     = 0x%04x\n",
-	       frame->p80211.seq_ctl);
-	printk(KERN_DEBUG "  addr4       = %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       frame->p80211.addr4[0], frame->p80211.addr4[1],
-	       frame->p80211.addr4[2], frame->p80211.addr4[3],
-	       frame->p80211.addr4[4], frame->p80211.addr4[5]);
-	printk(KERN_DEBUG "  data_len    = 0x%04x\n",
-	       frame->p80211.data_len);
+	netif_stop_queue(dev);
 
-	printk(KERN_DEBUG "IEEE 802.3 header:\n");
-	printk(KERN_DEBUG "  dest        = %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       frame->p8023.h_dest[0], frame->p8023.h_dest[1],
-	       frame->p8023.h_dest[2], frame->p8023.h_dest[3],
-	       frame->p8023.h_dest[4], frame->p8023.h_dest[5]);
-	printk(KERN_DEBUG "  src         = %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       frame->p8023.h_source[0], frame->p8023.h_source[1],
-	       frame->p8023.h_source[2], frame->p8023.h_source[3],
-	       frame->p8023.h_source[4], frame->p8023.h_source[5]);
-	printk(KERN_DEBUG "  len         = 0x%04x\n", frame->p8023.h_proto);
+	if (! priv->hw_unavailable) {
+		if (! priv->broken_disableport) {
+			err = hermes_disable_port(hw, 0);
+			if (err) {
+				/* Some firmwares (e.g. Intersil 1.3.x) seem
+				 * to have problems disabling the port, oh
+				 * well, too bad. */
+				printk(KERN_WARNING "%s: Error %d disabling MAC port\n",
+				       dev->name, err);
+				priv->broken_disableport = 1;
+			}
+		}
+		hermes_set_irqmask(hw, 0);
+		hermes_write_regn(hw, EVACK, 0xffff);
+	}
+	
+	/* firmware will have to reassociate */
+	priv->last_linkstatus = 0xffff;
+	priv->connected = 0;
 
-	printk(KERN_DEBUG "IEEE 802.2 LLC/SNAP header:\n");
-	printk(KERN_DEBUG "  DSAP        = 0x%02x\n", frame->p8022.dsap);
-	printk(KERN_DEBUG "  SSAP        = 0x%02x\n", frame->p8022.ssap);
-	printk(KERN_DEBUG "  ctrl        = 0x%02x\n", frame->p8022.ctrl);
-	printk(KERN_DEBUG "  OUI         = %02x:%02x:%02x\n",
-	       frame->p8022.oui[0], frame->p8022.oui[1], frame->p8022.oui[2]);
-	printk(KERN_DEBUG "  ethertype  = 0x%04x\n", frame->ethertype);
+	return 0;
 }
-#endif /* 0 */
 
-/*
- * Interrupt handler
- */
-irqreturn_t orinoco_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+int orinoco_reinit_firmware(struct net_device *dev)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
 	struct orinoco_private *priv = netdev_priv(dev);
-	hermes_t *hw = &priv->hw;
-	int count = MAX_IRQLOOPS_PER_IRQ;
-	u16 evstat, events;
-	/* These are used to detect a runaway interrupt situation */
-	/* If we get more than MAX_IRQLOOPS_PER_JIFFY iterations in a jiffy,
-	 * we panic and shut down the hardware */
-	static int last_irq_jiffy = 0; /* jiffies value the last time we were called */
-	static int loops_this_jiffy = 0;
-	unsigned long flags;
+	struct hermes *hw = &priv->hw;
+	int err;
 
-	if (orinoco_lock(priv, &flags) != 0) {
-		/* If hw is unavailable - we don't know if the irq was
-		 * for us or not */
-		return IRQ_HANDLED;
-	}
+	err = hermes_init(hw);
+	if (err)
+		return err;
 
-	evstat = hermes_read_regn(hw, EVSTAT);
-	events = evstat & hw->inten;
-	if (! events) {
-		orinoco_unlock(priv, &flags);
-		return IRQ_NONE;
-	}
-	
-	if (jiffies != last_irq_jiffy)
-		loops_this_jiffy = 0;
-	last_irq_jiffy = jiffies;
+	err = hermes_allocate(hw, priv->nicbuf_size, &priv->txfid);
+	if (err == -EIO) {
+		/* Try workaround for old Symbol firmware bug */
+		printk(KERN_WARNING "%s: firmware ALLOC bug detected "
+		       "(old Symbol firmware?). Trying to work around... ",
+		       dev->name);
+		
+		priv->nicbuf_size = TX_NICBUF_SIZE_BUG;
+		err = hermes_allocate(hw, priv->nicbuf_size, &priv->txfid);
+		if (err)
+			printk("failed!\n");
+		else
+			printk("ok.\n");
+	}
 
-	while (events && count--) {
-		if (++loops_this_jiffy > MAX_IRQLOOPS_PER_JIFFY) {
-			printk(KERN_WARNING "%s: IRQ handler is looping too "
-			       "much! Resetting.\n", dev->name);
-			/* Disable interrupts for now */
-			hermes_set_irqmask(hw, 0);
-			schedule_work(&priv->reset_work);
-			break;
-		}
+	return err;
+}
 
-		/* Check the card hasn't been removed */
-		if (! hermes_present(hw)) {
-			DEBUG(0, "orinoco_interrupt(): card removed\n");
-			break;
-		}
+static int __orinoco_hw_set_bitrate(struct orinoco_private *priv)
+{
+	hermes_t *hw = &priv->hw;
+	int err = 0;
 
-		if (events & HERMES_EV_TICK)
-			__orinoco_ev_tick(dev, hw);
-		if (events & HERMES_EV_WTERR)
-			__orinoco_ev_wterr(dev, hw);
-		if (events & HERMES_EV_INFDROP)
-			__orinoco_ev_infdrop(dev, hw);
-		if (events & HERMES_EV_INFO)
-			__orinoco_ev_info(dev, hw);
-		if (events & HERMES_EV_RX)
-			__orinoco_ev_rx(dev, hw);
-		if (events & HERMES_EV_TXEXC)
-			__orinoco_ev_txexc(dev, hw);
-		if (events & HERMES_EV_TX)
-			__orinoco_ev_tx(dev, hw);
-		if (events & HERMES_EV_ALLOC)
-			__orinoco_ev_alloc(dev, hw);
-		
-		hermes_write_regn(hw, EVACK, events);
+	if (priv->bitratemode >= BITRATE_TABLE_SIZE) {
+		printk(KERN_ERR "%s: BUG: Invalid bitrate mode %d\n",
+		       priv->ndev->name, priv->bitratemode);
+		return -EINVAL;
+	}
 
-		evstat = hermes_read_regn(hw, EVSTAT);
-		events = evstat & hw->inten;
-	};
+	switch (priv->firmware_type) {
+	case FIRMWARE_TYPE_AGERE:
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFTXRATECONTROL,
+					   bitrate_table[priv->bitratemode].agere_txratectrl);
+		break;
+	case FIRMWARE_TYPE_INTERSIL:
+	case FIRMWARE_TYPE_SYMBOL:
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFTXRATECONTROL,
+					   bitrate_table[priv->bitratemode].intersil_txratectrl);
+		break;
+	default:
+		BUG();
+	}
 
-	orinoco_unlock(priv, &flags);
-	return IRQ_HANDLED;
+	return err;
 }
 
-static void __orinoco_ev_tick(struct net_device *dev, hermes_t *hw)
+static int __orinoco_hw_setup_wep(struct orinoco_private *priv)
 {
-	printk(KERN_DEBUG "%s: TICK\n", dev->name);
-}
+	hermes_t *hw = &priv->hw;
+	int err = 0;
+	int	master_wep_flag;
+	int	auth_flag;
 
-static void __orinoco_ev_wterr(struct net_device *dev, hermes_t *hw)
-{
-	/* This seems to happen a fair bit under load, but ignoring it
-	   seems to work fine...*/
-	printk(KERN_DEBUG "%s: MAC controller error (WTERR). Ignoring.\n",
-	       dev->name);
-}
+	switch (priv->firmware_type) {
+	case FIRMWARE_TYPE_AGERE: /* Agere style WEP */
+		if (priv->wep_on) {
+			err = hermes_write_wordrec(hw, USER_BAP,
+						   HERMES_RID_CNFTXKEY_AGERE,
+						   priv->tx_key);
+			if (err)
+				return err;
+			
+			err = HERMES_WRITE_RECORD(hw, USER_BAP,
+						  HERMES_RID_CNFWEPKEYS_AGERE,
+						  &priv->keys);
+			if (err)
+				return err;
+		}
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFWEPENABLED_AGERE,
+					   priv->wep_on);
+		if (err)
+			return err;
+		break;
 
-static void __orinoco_ev_infdrop(struct net_device *dev, hermes_t *hw)
-{
-	if (net_ratelimit())
-		printk(KERN_WARNING "%s: Information frame lost.\n", dev->name);
-}
+	case FIRMWARE_TYPE_INTERSIL: /* Intersil style WEP */
+	case FIRMWARE_TYPE_SYMBOL: /* Symbol style WEP */
+		master_wep_flag = 0;		/* Off */
+		if (priv->wep_on) {
+			int keylen;
+			int i;
 
-static void print_linkstatus(struct net_device *dev, u16 status)
-{
-	char * s;
+			/* Fudge around firmware weirdness */
+			keylen = le16_to_cpu(priv->keys[priv->tx_key].len);
+			
+			/* Write all 4 keys */
+			for(i = 0; i < ORINOCO_MAX_KEYS; i++) {
+/*  				int keylen = le16_to_cpu(priv->keys[i].len); */
+				
+				if (keylen > LARGE_KEY_SIZE) {
+					printk(KERN_ERR "%s: BUG: Key %d has oversize length %d.\n",
+					       priv->ndev->name, i, keylen);
+					return -E2BIG;
+				}
 
-	if (suppress_linkstatus)
-		return;
+				err = hermes_write_ltv(hw, USER_BAP,
+						       HERMES_RID_CNFDEFAULTKEY0 + i,
+						       HERMES_BYTES_TO_RECLEN(keylen),
+						       priv->keys[i].data);
+				if (err)
+					return err;
+			}
+
+			/* Write the index of the key used in transmission */
+			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFWEPDEFAULTKEYID,
+						   priv->tx_key);
+			if (err)
+				return err;
+			
+			if (priv->wep_restrict) {
+				auth_flag = 2;
+				master_wep_flag = 3;
+			} else {
+				/* Authentication is where Intersil and Symbol
+				 * firmware differ... */
+				auth_flag = 1;
+				if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL)
+					master_wep_flag = 3; /* Symbol */ 
+				else 
+					master_wep_flag = 1; /* Intersil */
+			}
+
+
+			err = hermes_write_wordrec(hw, USER_BAP,
+						   HERMES_RID_CNFAUTHENTICATION, auth_flag);
+			if (err)
+				return err;
+		}
+		
+		/* Master WEP setting : on/off */
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFWEPFLAGS_INTERSIL,
+					   master_wep_flag);
+		if (err)
+			return err;	
 
-	switch (status) {
-	case HERMES_LINKSTATUS_NOT_CONNECTED:
-		s = "Not Connected";
-		break;
-	case HERMES_LINKSTATUS_CONNECTED:
-		s = "Connected";
-		break;
-	case HERMES_LINKSTATUS_DISCONNECTED:
-		s = "Disconnected";
-		break;
-	case HERMES_LINKSTATUS_AP_CHANGE:
-		s = "AP Changed";
-		break;
-	case HERMES_LINKSTATUS_AP_OUT_OF_RANGE:
-		s = "AP Out of Range";
-		break;
-	case HERMES_LINKSTATUS_AP_IN_RANGE:
-		s = "AP In Range";
-		break;
-	case HERMES_LINKSTATUS_ASSOC_FAILED:
-		s = "Association Failed";
 		break;
+
 	default:
-		s = "UNKNOWN";
+		if (priv->wep_on) {
+			printk(KERN_ERR "%s: WEP enabled, although not supported!\n",
+			       priv->ndev->name);
+			return -EINVAL;
+		}
 	}
-	
-	printk(KERN_INFO "%s: New link status: %s (%04x)\n",
-	       dev->name, s, status);
+
+	return 0;
 }
 
-static void __orinoco_ev_info(struct net_device *dev, hermes_t *hw)
+static int __orinoco_program_rids(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
-	u16 infofid;
-	struct {
-		u16 len;
-		u16 type;
-	} __attribute__ ((packed)) info;
-	int len, type;
+	hermes_t *hw = &priv->hw;
 	int err;
+	struct hermes_idstring idbuf;
 
-	/* This is an answer to an INQUIRE command that we did earlier,
-	 * or an information "event" generated by the card
-	 * The controller return to us a pseudo frame containing
-	 * the information in question - Jean II */
-	infofid = hermes_read_regn(hw, INFOFID);
+	/* Set the MAC address */
+	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFOWNMACADDR,
+			       HERMES_BYTES_TO_RECLEN(ETH_ALEN), dev->dev_addr);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting MAC address\n", dev->name, err);
+		return err;
+	}
 
-	/* Read the info frame header - don't try too hard */
-	err = hermes_bap_pread(hw, IRQ_BAP, &info, sizeof(info),
-			       infofid, 0);
+	/* Set up the link mode */
+	err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFPORTTYPE, priv->port_type);
 	if (err) {
-		printk(KERN_ERR "%s: error %d reading info frame. "
-		       "Frame dropped.\n", dev->name, err);
-		return;
+		printk(KERN_ERR "%s: Error %d setting port type\n", dev->name, err);
+		return err;
+	}
+	/* Set the channel/frequency */
+	if (priv->channel == 0) {
+		printk(KERN_DEBUG "%s: Channel is 0 in __orinoco_program_rids()\n", dev->name);
+		if (priv->createibss)
+			priv->channel = 10;
+	}
+	err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFOWNCHANNEL, priv->channel);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting channel\n", dev->name, err);
+		return err;
+	}
+
+	if (priv->has_ibss) {
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFCREATEIBSS,
+					   priv->createibss);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting CREATEIBSS\n", dev->name, err);
+			return err;
+		}
+
+		if ((strlen(priv->desired_essid) == 0) && (priv->createibss)
+		   && (!priv->has_ibss_any)) {
+			printk(KERN_WARNING "%s: This firmware requires an \
+ESSID in IBSS-Ad-Hoc mode.\n", dev->name);
+			/* With wvlan_cs, in this case, we would crash.
+			 * hopefully, this driver will behave better...
+			 * Jean II */
+		}
+	}
+
+	/* Set the desired ESSID */
+	idbuf.len = cpu_to_le16(strlen(priv->desired_essid));
+	memcpy(&idbuf.val, priv->desired_essid, sizeof(idbuf.val));
+	/* WinXP wants partner to configure OWNSSID even in IBSS mode. (jimc) */
+	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFOWNSSID,
+			       HERMES_BYTES_TO_RECLEN(strlen(priv->desired_essid)+2),
+			       &idbuf);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting OWNSSID\n", dev->name, err);
+		return err;
+	}
+	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFDESIREDSSID,
+			       HERMES_BYTES_TO_RECLEN(strlen(priv->desired_essid)+2),
+			       &idbuf);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting DESIREDSSID\n", dev->name, err);
+		return err;
+	}
+
+	/* Set the station name */
+	idbuf.len = cpu_to_le16(strlen(priv->nick));
+	memcpy(&idbuf.val, priv->nick, sizeof(idbuf.val));
+	err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFOWNNAME,
+			       HERMES_BYTES_TO_RECLEN(strlen(priv->nick)+2),
+			       &idbuf);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting nickname\n", dev->name, err);
+		return err;
+	}
+
+	/* Set AP density */
+	if (priv->has_sensitivity) {
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFSYSTEMSCALE,
+					   priv->ap_density);
+		if (err) {
+			printk(KERN_WARNING "%s: Error %d setting SYSTEMSCALE.  "
+			       "Disabling sensitivity control\n", dev->name, err);
+
+			priv->has_sensitivity = 0;
+		}
+	}
+
+	/* Set RTS threshold */
+	err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFRTSTHRESHOLD, priv->rts_thresh);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting RTS threshold\n", dev->name, err);
+		return err;
+	}
+
+	/* Set fragmentation threshold or MWO robustness */
+	if (priv->has_mwo)
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFMWOROBUST_AGERE,
+					   priv->mwo_robust);
+	else
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFFRAGMENTATIONTHRESHOLD,
+					   priv->frag_thresh);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting framentation\n", dev->name, err);
+		return err;
+	}
+
+	/* Set bitrate */
+	err = __orinoco_hw_set_bitrate(priv);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d setting bitrate\n", dev->name, err);
+		return err;
+	}
+
+	/* Set power management */
+	if (priv->has_pm) {
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNFPMENABLED,
+					   priv->pm_on);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting up PM\n",
+			       dev->name, err);
+			return err;
+		}
+
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFMULTICASTRECEIVE,
+					   priv->pm_mcast);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting up PM\n",
+			       dev->name, err);
+			return err;
+		}
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFMAXSLEEPDURATION,
+					   priv->pm_period);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting up PM\n",
+			       dev->name, err);
+			return err;
+		}
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFPMHOLDOVERDURATION,
+					   priv->pm_timeout);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting up PM\n",
+			       dev->name, err);
+			return err;
+		}
+	}
+
+	/* Set preamble - only for Symbol so far... */
+	if (priv->has_preamble) {
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFPREAMBLE_SYMBOL,
+					   priv->preamble);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting preamble\n",
+			       dev->name, err);
+			return err;
+		}
 	}
-	
-	len = HERMES_RECLEN_TO_BYTES(le16_to_cpu(info.len));
-	type = le16_to_cpu(info.type);
 
-	switch (type) {
-	case HERMES_INQ_TALLIES: {
-		struct hermes_tallies_frame tallies;
-		struct iw_statistics *wstats = &priv->wstats;
-		
-		if (len > sizeof(tallies)) {
-			printk(KERN_WARNING "%s: Tallies frame too long (%d bytes)\n",
-			       dev->name, len);
-			len = sizeof(tallies);
+	/* Set up encryption */
+	if (priv->has_wep) {
+		err = __orinoco_hw_setup_wep(priv);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d activating WEP\n",
+			       dev->name, err);
+			return err;
 		}
-		
-		/* Read directly the data (no seek) */
-		hermes_read_words(hw, HERMES_DATA1, (void *) &tallies,
-				  len / 2); /* FIXME: blech! */
-		
-		/* Increment our various counters */
-		/* wstats->discard.nwid - no wrong BSSID stuff */
-		wstats->discard.code +=
-			le16_to_cpu(tallies.RxWEPUndecryptable);
-		if (len == sizeof(tallies))  
-			wstats->discard.code +=
-				le16_to_cpu(tallies.RxDiscards_WEPICVError) +
-				le16_to_cpu(tallies.RxDiscards_WEPExcluded);
-		wstats->discard.misc +=
-			le16_to_cpu(tallies.TxDiscardsWrongSA);
-		wstats->discard.fragment +=
-			le16_to_cpu(tallies.RxMsgInBadMsgFragments);
-		wstats->discard.retries +=
-			le16_to_cpu(tallies.TxRetryLimitExceeded);
-		/* wstats->miss.beacon - no match */
 	}
-	break;
-	case HERMES_INQ_LINKSTATUS: {
-		struct hermes_linkstatus linkstatus;
-		u16 newstatus;
-		
-		if (len != sizeof(linkstatus)) {
-			printk(KERN_WARNING "%s: Unexpected size for linkstatus frame (%d bytes)\n",
-			       dev->name, len);
-			break;
-		}
 
-		hermes_read_words(hw, HERMES_DATA1, (void *) &linkstatus,
-				  len / 2);
-		newstatus = le16_to_cpu(linkstatus.linkstatus);
+	/* Set promiscuity / multicast*/
+	priv->promiscuous = 0;
+	priv->mc_count = 0;
+	__orinoco_set_multicast_list(dev); /* FIXME: what about the xmit_lock */
 
-		if ( (newstatus == HERMES_LINKSTATUS_CONNECTED)
-		     || (newstatus == HERMES_LINKSTATUS_AP_CHANGE)
-		     || (newstatus == HERMES_LINKSTATUS_AP_IN_RANGE) )
-			priv->connected = 1;
-		else if ( (newstatus == HERMES_LINKSTATUS_NOT_CONNECTED)
-			  || (newstatus == HERMES_LINKSTATUS_DISCONNECTED)
-			  || (newstatus == HERMES_LINKSTATUS_AP_OUT_OF_RANGE)
-			  || (newstatus == HERMES_LINKSTATUS_ASSOC_FAILED) )
-			priv->connected = 0;
+	return 0;
+}
 
-		if (newstatus != priv->last_linkstatus)
-			print_linkstatus(dev, newstatus);
+/* FIXME: return int? */
+static void
+__orinoco_set_multicast_list(struct net_device *dev)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	hermes_t *hw = &priv->hw;
+	int err = 0;
+	int promisc, mc_count;
 
-		priv->last_linkstatus = newstatus;
+	/* The Hermes doesn't seem to have an allmulti mode, so we go
+	 * into promiscuous mode and let the upper levels deal. */
+	if ( (dev->flags & IFF_PROMISC) || (dev->flags & IFF_ALLMULTI) ||
+	     (dev->mc_count > MAX_MULTICAST(priv)) ) {
+		promisc = 1;
+		mc_count = 0;
+	} else {
+		promisc = 0;
+		mc_count = dev->mc_count;
 	}
-	break;
-	default:
-		printk(KERN_DEBUG "%s: Unknown information frame received (type %04x).\n",
-		      dev->name, type);
-		/* We don't actually do anything about it */
-		break;
+
+	if (promisc != priv->promiscuous) {
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFPROMISCUOUSMODE,
+					   promisc);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting PROMISCUOUSMODE to 1.\n",
+			       dev->name, err);
+		} else 
+			priv->promiscuous = promisc;
+	}
+
+	if (! promisc && (mc_count || priv->mc_count) ) {
+		struct dev_mc_list *p = dev->mc_list;
+		hermes_multicast_t mclist;
+		int i;
+
+		for (i = 0; i < mc_count; i++) {
+			/* Paranoia: */
+			if (! p)
+				BUG(); /* Multicast list shorter than mc_count */
+			if (p->dmi_addrlen != ETH_ALEN)
+				BUG(); /* Bad address size in multicast list */
+			
+			memcpy(mclist.addr[i], p->dmi_addr, ETH_ALEN);
+			p = p->next;
+		}
+		
+		if (p)
+			printk(KERN_WARNING "Multicast list is longer than mc_count\n");
+
+		err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFGROUPADDRESSES,
+				       HERMES_BYTES_TO_RECLEN(priv->mc_count * ETH_ALEN),
+				       &mclist);
+		if (err)
+			printk(KERN_ERR "%s: Error %d setting multicast list.\n",
+			       dev->name, err);
+		else
+			priv->mc_count = mc_count;
 	}
+
+	/* Since we can set the promiscuous flag when it wasn't asked
+	   for, make sure the net_device knows about it. */
+	if (priv->promiscuous)
+		dev->flags |= IFF_PROMISC;
+	else
+		dev->flags &= ~IFF_PROMISC;
 }
 
-static void __orinoco_ev_rx(struct net_device *dev, hermes_t *hw)
+static int orinoco_reconfigure(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &priv->stats;
-	struct iw_statistics *wstats = &priv->wstats;
-	struct sk_buff *skb = NULL;
-	u16 rxfid, status;
-	int length, data_len, data_off;
-	char *p;
-	struct hermes_rx_descriptor desc;
-	struct header_struct hdr;
-	struct ethhdr *eh;
-	int err;
+	struct hermes *hw = &priv->hw;
+	unsigned long flags;
+	int err = 0;
 
-	rxfid = hermes_read_regn(hw, RXFID);
+	if (priv->broken_disableport) {
+		schedule_work(&priv->reset_work);
+		return 0;
+	}
 
-	err = hermes_bap_pread(hw, IRQ_BAP, &desc, sizeof(desc),
-			       rxfid, 0);
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return err;
+
+		
+	err = hermes_disable_port(hw, 0);
 	if (err) {
-		printk(KERN_ERR "%s: error %d reading Rx descriptor. "
-		       "Frame dropped.\n", dev->name, err);
-		stats->rx_errors++;
-		goto drop;
+		printk(KERN_WARNING "%s: Unable to disable port while reconfiguring card\n",
+		       dev->name);
+		priv->broken_disableport = 1;
+		goto out;
 	}
 
-	status = le16_to_cpu(desc.status);
-	
-	if (status & HERMES_RXSTAT_ERR) {
-		if (status & HERMES_RXSTAT_UNDECRYPTABLE) {
-			wstats->discard.code++;
-			DEBUG(1, "%s: Undecryptable frame on Rx. Frame dropped.\n",
-			       dev->name);
-		} else {
-			stats->rx_crc_errors++;
-			DEBUG(1, "%s: Bad CRC on Rx. Frame dropped.\n", dev->name);
-		}
-		stats->rx_errors++;
-		goto drop;
+	err = __orinoco_program_rids(dev);
+	if (err) {
+		printk(KERN_WARNING "%s: Unable to reconfigure card\n",
+		       dev->name);
+		goto out;
 	}
 
-	/* For now we ignore the 802.11 header completely, assuming
-           that the card's firmware has handled anything vital */
-
-	err = hermes_bap_pread(hw, IRQ_BAP, &hdr, sizeof(hdr),
-			       rxfid, HERMES_802_3_OFFSET);
+	err = hermes_enable_port(hw, 0);
 	if (err) {
-		printk(KERN_ERR "%s: error %d reading frame header. "
-		       "Frame dropped.\n", dev->name, err);
-		stats->rx_errors++;
-		goto drop;
+		printk(KERN_WARNING "%s: Unable to enable port while reconfiguring card\n",
+		       dev->name);
+		goto out;
 	}
 
-	length = ntohs(hdr.len);
-	
-	/* Sanity checks */
-	if (length < 3) { /* No for even an 802.2 LLC header */
-		/* At least on Symbol firmware with PCF we get quite a
-                   lot of these legitimately - Poll frames with no
-                   data. */
-		stats->rx_dropped++;
-		goto drop;
-	}
-	if (length > IEEE802_11_DATA_LEN) {
-		printk(KERN_WARNING "%s: Oversized frame received (%d bytes)\n",
-		       dev->name, length);
-		stats->rx_length_errors++;
-		stats->rx_errors++;
-		goto drop;
+ out:
+	if (err) {
+		printk(KERN_WARNING "%s: Resetting instead...\n", dev->name);
+		schedule_work(&priv->reset_work);
+		err = 0;
 	}
 
-	/* We need space for the packet data itself, plus an ethernet
-	   header, plus 2 bytes so we can align the IP header on a
-	   32bit boundary, plus 1 byte so we can read in odd length
-	   packets from the card, which has an IO granularity of 16
-	   bits */  
-	skb = dev_alloc_skb(length+ETH_HLEN+2+1);
-	if (!skb) {
-		printk(KERN_WARNING "%s: Can't allocate skb for Rx\n",
-		       dev->name);
-		goto drop;
-	}
+	orinoco_unlock(priv, &flags);
+	return err;
 
-	skb_reserve(skb, 2); /* This way the IP header is aligned */
+}
+
+/* This must be called from user context, without locks held - use
+ * schedule_work() */
+static void orinoco_reset(struct net_device *dev)
+{
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct hermes *hw = &priv->hw;
+	int err;
+	unsigned long flags;
+
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		/* When the hardware becomes available again, whatever
+		 * detects that is responsible for re-initializing
+		 * it. So no need for anything further*/
+		return;
 
-	/* Handle decapsulation
-	 * In most cases, the firmware tell us about SNAP frames.
-	 * For some reason, the SNAP frames sent by LinkSys APs
-	 * are not properly recognised by most firmwares.
-	 * So, check ourselves */
-	if(((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_1042) ||
-	   ((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_TUNNEL) ||
-	   is_ethersnap(&hdr)) {
-		/* These indicate a SNAP within 802.2 LLC within
-		   802.11 frame which we'll need to de-encapsulate to
-		   the original EthernetII frame. */
+	netif_stop_queue(dev);
 
-		if (length < ENCAPS_OVERHEAD) { /* No room for full LLC+SNAP */
-			stats->rx_length_errors++;
-			goto drop;
-		}
+	/* Shut off interrupts.  Depending on what state the hardware
+	 * is in, this might not work, but we'll try anyway */
+	hermes_set_irqmask(hw, 0);
+	hermes_write_regn(hw, EVACK, 0xffff);
 
-		/* Remove SNAP header, reconstruct EthernetII frame */
-		data_len = length - ENCAPS_OVERHEAD;
-		data_off = HERMES_802_3_OFFSET + sizeof(hdr);
+	priv->hw_unavailable++;
+	priv->last_linkstatus = 0xffff; /* firmware will have to reassociate */
+	priv->connected = 0;
 
-		eh = (struct ethhdr *)skb_put(skb, ETH_HLEN);
+	orinoco_unlock(priv, &flags);
 
-		memcpy(eh, &hdr, 2 * ETH_ALEN);
-		eh->h_proto = hdr.ethertype;
-	} else {
-		/* All other cases indicate a genuine 802.3 frame.  No
-		   decapsulation needed.  We just throw the whole
-		   thing in, and hope the protocol layer can deal with
-		   it as 802.3 */
-		data_len = length;
-		data_off = HERMES_802_3_OFFSET;
-		/* FIXME: we re-read from the card data we already read here */
+	if (priv->hard_reset)
+		err = (*priv->hard_reset)(priv);
+	if (err) {
+		printk(KERN_ERR "%s: orinoco_reset: Error %d performing hard reset\n",
+		       dev->name, err);
+		/* FIXME: shutdown of some sort */
+		return;
 	}
 
-	p = skb_put(skb, data_len);
-	err = hermes_bap_pread(hw, IRQ_BAP, p, RUP_EVEN(data_len),
-			       rxfid, data_off);
+	err = orinoco_reinit_firmware(dev);
 	if (err) {
-		printk(KERN_ERR "%s: error %d reading frame. "
-		       "Frame dropped.\n", dev->name, err);
-		stats->rx_errors++;
-		goto drop;
+		printk(KERN_ERR "%s: orinoco_reset: Error %d re-initializing firmware\n",
+		       dev->name, err);
+		return;
 	}
 
-	dev->last_rx = jiffies;
-	skb->dev = dev;
-	skb->protocol = eth_type_trans(skb, dev);
-	skb->ip_summed = CHECKSUM_NONE;
-	
-	/* Process the wireless stats if needed */
-	orinoco_stat_gather(dev, skb, &desc);
+	spin_lock_irq(&priv->lock); /* This has to be called from user context */
 
-	/* Pass the packet to the networking stack */
-	netif_rx(skb);
-	stats->rx_packets++;
-	stats->rx_bytes += length;
+	priv->hw_unavailable--;
 
-	return;
+	/* priv->open or priv->hw_unavailable might have changed while
+	 * we dropped the lock */
+	if (priv->open && (! priv->hw_unavailable)) {
+		err = __orinoco_up(dev);
+		if (err) {
+			printk(KERN_ERR "%s: orinoco_reset: Error %d reenabling card\n",
+			       dev->name, err);
+		} else
+			dev->trans_start = jiffies;
+	}
 
- drop:	
-	stats->rx_dropped++;
+	spin_unlock_irq(&priv->lock);
 
-	if (skb)
-		dev_kfree_skb_irq(skb);
 	return;
 }
 
-static void __orinoco_ev_txexc(struct net_device *dev, hermes_t *hw)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &priv->stats;
-	u16 fid = hermes_read_regn(hw, TXCOMPLFID);
-	struct hermes_tx_descriptor desc;
-	int err = 0;
-
-	if (fid == DUMMY_FID)
-		return; /* Nothing's really happened */
-
-	err = hermes_bap_pread(hw, IRQ_BAP, &desc, sizeof(desc), fid, 0);
-	if (err) {
-		printk(KERN_WARNING "%s: Unable to read descriptor on Tx error "
-		       "(FID=%04X error %d)\n",
-		       dev->name, fid, err);
-	} else {
-		DEBUG(1, "%s: Tx error, status %d\n",
-		      dev->name, le16_to_cpu(desc.status));
-	}
-	
-	stats->tx_errors++;
+/********************************************************************/
+/* Interrupt handler                                                */
+/********************************************************************/
 
-	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
+static void __orinoco_ev_tick(struct net_device *dev, hermes_t *hw)
+{
+	printk(KERN_DEBUG "%s: TICK\n", dev->name);
 }
 
-static void __orinoco_ev_tx(struct net_device *dev, hermes_t *hw)
+static void __orinoco_ev_wterr(struct net_device *dev, hermes_t *hw)
 {
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &priv->stats;
-
-	stats->tx_packets++;
-
-	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
+	/* This seems to happen a fair bit under load, but ignoring it
+	   seems to work fine...*/
+	printk(KERN_DEBUG "%s: MAC controller error (WTERR). Ignoring.\n",
+	       dev->name);
 }
 
-static void __orinoco_ev_alloc(struct net_device *dev, hermes_t *hw)
+irqreturn_t orinoco_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	struct net_device *dev = (struct net_device *)dev_id;
 	struct orinoco_private *priv = netdev_priv(dev);
+	hermes_t *hw = &priv->hw;
+	int count = MAX_IRQLOOPS_PER_IRQ;
+	u16 evstat, events;
+	/* These are used to detect a runaway interrupt situation */
+	/* If we get more than MAX_IRQLOOPS_PER_JIFFY iterations in a jiffy,
+	 * we panic and shut down the hardware */
+	static int last_irq_jiffy = 0; /* jiffies value the last time we were called */
+	static int loops_this_jiffy = 0;
+	unsigned long flags;
 
-	u16 fid = hermes_read_regn(hw, ALLOCFID);
+	if (orinoco_lock(priv, &flags) != 0) {
+		/* If hw is unavailable - we don't know if the irq was
+		 * for us or not */
+		return IRQ_HANDLED;
+	}
 
-	if (fid != priv->txfid) {
-		if (fid != DUMMY_FID)
-			printk(KERN_WARNING "%s: Allocate event on unexpected fid (%04X)\n",
-			       dev->name, fid);
-		return;
-	} else {
-		netif_wake_queue(dev);
+	evstat = hermes_read_regn(hw, EVSTAT);
+	events = evstat & hw->inten;
+	if (! events) {
+		orinoco_unlock(priv, &flags);
+		return IRQ_NONE;
 	}
+	
+	if (jiffies != last_irq_jiffy)
+		loops_this_jiffy = 0;
+	last_irq_jiffy = jiffies;
 
-	hermes_write_regn(hw, ALLOCFID, DUMMY_FID);
+	while (events && count--) {
+		if (++loops_this_jiffy > MAX_IRQLOOPS_PER_JIFFY) {
+			printk(KERN_WARNING "%s: IRQ handler is looping too "
+			       "much! Resetting.\n", dev->name);
+			/* Disable interrupts for now */
+			hermes_set_irqmask(hw, 0);
+			schedule_work(&priv->reset_work);
+			break;
+		}
+
+		/* Check the card hasn't been removed */
+		if (! hermes_present(hw)) {
+			DEBUG(0, "orinoco_interrupt(): card removed\n");
+			break;
+		}
+
+		if (events & HERMES_EV_TICK)
+			__orinoco_ev_tick(dev, hw);
+		if (events & HERMES_EV_WTERR)
+			__orinoco_ev_wterr(dev, hw);
+		if (events & HERMES_EV_INFDROP)
+			__orinoco_ev_infdrop(dev, hw);
+		if (events & HERMES_EV_INFO)
+			__orinoco_ev_info(dev, hw);
+		if (events & HERMES_EV_RX)
+			__orinoco_ev_rx(dev, hw);
+		if (events & HERMES_EV_TXEXC)
+			__orinoco_ev_txexc(dev, hw);
+		if (events & HERMES_EV_TX)
+			__orinoco_ev_tx(dev, hw);
+		if (events & HERMES_EV_ALLOC)
+			__orinoco_ev_alloc(dev, hw);
+		
+		hermes_write_regn(hw, EVACK, events);
+
+		evstat = hermes_read_regn(hw, EVSTAT);
+		events = evstat & hw->inten;
+	};
+
+	orinoco_unlock(priv, &flags);
+	return IRQ_HANDLED;
 }
 
+/********************************************************************/
+/* Initialization                                                   */
+/********************************************************************/
+
 struct sta_id {
 	u16 id, variant, major, minor;
 } __attribute__ ((packed));
@@ -2009,10 +2150,6 @@
 	}
 }
 
-/*
- * struct net_device methods
- */
-
 static int
 orinoco_init(struct net_device *dev)
 {
@@ -2180,370 +2317,215 @@
 		goto out;
 	}
 
-	/* Make the hardware available, as long as it hasn't been
-	 * removed elsewhere (e.g. by PCMCIA hot unplug) */
-	spin_lock_irq(&priv->lock);
-	priv->hw_unavailable--;
-	spin_unlock_irq(&priv->lock);
+	/* Make the hardware available, as long as it hasn't been
+	 * removed elsewhere (e.g. by PCMCIA hot unplug) */
+	spin_lock_irq(&priv->lock);
+	priv->hw_unavailable--;
+	spin_unlock_irq(&priv->lock);
+
+	printk(KERN_DEBUG "%s: ready\n", dev->name);
+
+ out:
+	TRACE_EXIT(dev->name);
+	return err;
+}
+
+struct net_device *alloc_orinocodev(int sizeof_card, int (*hard_reset)(struct orinoco_private *))
+{
+	struct net_device *dev;
+	struct orinoco_private *priv;
+
+	dev = alloc_etherdev(sizeof(struct orinoco_private) + sizeof_card);
+	if (!dev)
+		return NULL;
+	priv = netdev_priv(dev);
+	priv->ndev = dev;
+	if (sizeof_card)
+		priv->card = (void *)((unsigned long)dev->priv + sizeof(struct orinoco_private));
+	else
+		priv->card = NULL;
+
+	/* Setup / override net_device fields */
+	dev->init = orinoco_init;
+	dev->hard_start_xmit = orinoco_xmit;
+	dev->tx_timeout = orinoco_tx_timeout;
+	dev->watchdog_timeo = HZ; /* 1 second timeout */
+	dev->get_stats = orinoco_get_stats;
+	dev->get_wireless_stats = orinoco_get_wireless_stats;
+	dev->do_ioctl = orinoco_ioctl;
+	dev->change_mtu = orinoco_change_mtu;
+	dev->set_multicast_list = orinoco_set_multicast_list;
+	/* we use the default eth_mac_addr for setting the MAC addr */
+
+	/* Set up default callbacks */
+	dev->open = orinoco_open;
+	dev->stop = orinoco_stop;
+	priv->hard_reset = hard_reset;
+
+	spin_lock_init(&priv->lock);
+	priv->open = 0;
+	priv->hw_unavailable = 1; /* orinoco_init() must clear this
+				   * before anything else touches the
+				   * hardware */
+	INIT_WORK(&priv->reset_work, (void (*)(void *))orinoco_reset, dev);
+
+	priv->last_linkstatus = 0xffff;
+	priv->connected = 0;
 
-	printk(KERN_DEBUG "%s: ready\n", dev->name);
+	return dev;
 
- out:
-	TRACE_EXIT(dev->name);
-	return err;
 }
 
-struct net_device_stats *
-orinoco_get_stats(struct net_device *dev)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-	
-	return &priv->stats;
-}
+/********************************************************************/
+/* Wireless extensions                                              */
+/********************************************************************/
 
-struct iw_statistics *
-orinoco_get_wireless_stats(struct net_device *dev)
+static int orinoco_hw_get_bssid(struct orinoco_private *priv,
+				char buf[ETH_ALEN])
 {
-	struct orinoco_private *priv = netdev_priv(dev);
 	hermes_t *hw = &priv->hw;
-	struct iw_statistics *wstats = &priv->wstats;
 	int err = 0;
 	unsigned long flags;
 
-	if (! netif_device_present(dev)) {
-		printk(KERN_WARNING "%s: get_wireless_stats() called while device not present\n",
-		       dev->name);
-		return NULL; /* FIXME: Can we do better than this? */
-	}
-
 	err = orinoco_lock(priv, &flags);
 	if (err)
-		return NULL; /* FIXME: Erg, we've been signalled, how
-			      * do we propagate this back up? */
-
-	if (priv->iw_mode == IW_MODE_ADHOC) {
-		memset(&wstats->qual, 0, sizeof(wstats->qual));
-		/* If a spy address is defined, we report stats of the
-		 * first spy address - Jean II */
-		if (SPY_NUMBER(priv)) {
-			wstats->qual.qual = priv->spy_stat[0].qual;
-			wstats->qual.level = priv->spy_stat[0].level;
-			wstats->qual.noise = priv->spy_stat[0].noise;
-			wstats->qual.updated = priv->spy_stat[0].updated;
-		}
-	} else {
-		struct {
-			u16 qual, signal, noise;
-		} __attribute__ ((packed)) cq;
+		return err;
 
-		err = HERMES_READ_RECORD(hw, USER_BAP,
-					 HERMES_RID_COMMSQUALITY, &cq);
-		
-		wstats->qual.qual = (int)le16_to_cpu(cq.qual);
-		wstats->qual.level = (int)le16_to_cpu(cq.signal) - 0x95;
-		wstats->qual.noise = (int)le16_to_cpu(cq.noise) - 0x95;
-		wstats->qual.updated = 7;
-	}
+	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_CURRENTBSSID,
+			      ETH_ALEN, NULL, buf);
 
-	/* We can't really wait for the tallies inquiry command to
-	 * complete, so we just use the previous results and trigger
-	 * a new tallies inquiry command for next time - Jean II */
-	/* FIXME: We're in user context (I think?), so we should just
-           wait for the tallies to come through */
-	err = hermes_inquire(hw, HERMES_INQ_TALLIES);
-               
 	orinoco_unlock(priv, &flags);
 
-	if (err)
-		return NULL;
-		
-	return wstats;
-}
-
-static inline void orinoco_spy_gather(struct net_device *dev, u_char *mac,
-				    int level, int noise)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-	int i;
-
-	/* Gather wireless spy statistics: for each packet, compare the
-	 * source address with out list, and if match, get the stats... */
-	for (i = 0; i < priv->spy_number; i++)
-		if (!memcmp(mac, priv->spy_address[i], ETH_ALEN)) {
-			priv->spy_stat[i].level = level - 0x95;
-			priv->spy_stat[i].noise = noise - 0x95;
-			priv->spy_stat[i].qual = (level > noise) ? (level - noise) : 0;
-			priv->spy_stat[i].updated = 7;
-		}
-}
-
-void
-orinoco_stat_gather(struct net_device *dev,
-		    struct sk_buff *skb,
-		    struct hermes_rx_descriptor *desc)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-
-	/* Using spy support with lots of Rx packets, like in an
-	 * infrastructure (AP), will really slow down everything, because
-	 * the MAC address must be compared to each entry of the spy list.
-	 * If the user really asks for it (set some address in the
-	 * spy list), we do it, but he will pay the price.
-	 * Note that to get here, you need both WIRELESS_SPY
-	 * compiled in AND some addresses in the list !!!
-	 */
-	/* Note : gcc will optimise the whole section away if
-	 * WIRELESS_SPY is not defined... - Jean II */
-	if (SPY_NUMBER(priv)) {
-		orinoco_spy_gather(dev, skb->mac.raw + ETH_ALEN,
-				   desc->signal, desc->silence);
-	}
+	return err;
 }
 
-static int
-orinoco_xmit(struct sk_buff *skb, struct net_device *dev)
+static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
+				char buf[IW_ESSID_MAX_SIZE+1])
 {
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &priv->stats;
 	hermes_t *hw = &priv->hw;
 	int err = 0;
-	u16 txfid = priv->txfid;
-	char *p;
-	struct ethhdr *eh;
-	int len, data_len, data_off;
-	struct hermes_tx_descriptor desc;
+	struct hermes_idstring essidbuf;
+	char *p = (char *)(&essidbuf.val);
+	int len;
 	unsigned long flags;
 
-	TRACE_ENTER(dev->name);
-
-	if (! netif_running(dev)) {
-		printk(KERN_ERR "%s: Tx on stopped device!\n",
-		       dev->name);
-		TRACE_EXIT(dev->name);
-		return 1;
-	}
-	
-	if (netif_queue_stopped(dev)) {
-		printk(KERN_DEBUG "%s: Tx while transmitter busy!\n", 
-		       dev->name);
-		TRACE_EXIT(dev->name);
-		return 1;
-	}
-	
-	if (orinoco_lock(priv, &flags) != 0) {
-		printk(KERN_ERR "%s: orinoco_xmit() called while hw_unavailable\n",
-		       dev->name);
-		TRACE_EXIT(dev->name);
-/*  		BUG(); */
-		return 1;
-	}
-
-	if (! priv->connected) {
-		/* Oops, the firmware hasn't established a connection,
-                   silently drop the packet (this seems to be the
-                   safest approach). */
-		stats->tx_errors++;
-		orinoco_unlock(priv, &flags);
-		dev_kfree_skb(skb);
-		TRACE_EXIT(dev->name);
-		return 0;
-	}
-
-	/* Length of the packet body */
-	/* FIXME: what if the skb is smaller than this? */
-	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
-
-	eh = (struct ethhdr *)skb->data;
-
-	memset(&desc, 0, sizeof(desc));
- 	desc.tx_control = cpu_to_le16(HERMES_TXCTRL_TX_OK | HERMES_TXCTRL_TX_EX);
-	err = hermes_bap_pwrite(hw, USER_BAP, &desc, sizeof(desc), txfid, 0);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d writing Tx descriptor to BAP\n",
-		       dev->name, err);
-		stats->tx_errors++;
-		goto fail;
-	}
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return err;
 
-	/* Clear the 802.11 header and data length fields - some
-	 * firmwares (e.g. Lucent/Agere 8.xx) appear to get confused
-	 * if this isn't done. */
-	hermes_clear_words(hw, HERMES_DATA0,
-			   HERMES_802_3_OFFSET - HERMES_802_11_OFFSET);
+	if (strlen(priv->desired_essid) > 0) {
+		/* We read the desired SSID from the hardware rather
+		   than from priv->desired_essid, just in case the
+		   firmware is allowed to change it on us. I'm not
+		   sure about this */
+		/* My guess is that the OWNSSID should always be whatever
+		 * we set to the card, whereas CURRENT_SSID is the one that
+		 * may change... - Jean II */
+		u16 rid;
 
-	/* Encapsulate Ethernet-II frames */
-	if (ntohs(eh->h_proto) > 1500) { /* Ethernet-II frame */
-		struct header_struct hdr;
-		data_len = len;
-		data_off = HERMES_802_3_OFFSET + sizeof(hdr);
-		p = skb->data + ETH_HLEN;
+		*active = 1;
 
-		/* 802.3 header */
-		memcpy(hdr.dest, eh->h_dest, ETH_ALEN);
-		memcpy(hdr.src, eh->h_source, ETH_ALEN);
-		hdr.len = htons(data_len + ENCAPS_OVERHEAD);
+		rid = (priv->port_type == 3) ? HERMES_RID_CNFOWNSSID :
+			HERMES_RID_CNFDESIREDSSID;
 		
-		/* 802.2 header */
-		memcpy(&hdr.dsap, &encaps_hdr, sizeof(encaps_hdr));
-			
-		hdr.ethertype = eh->h_proto;
-		err  = hermes_bap_pwrite(hw, USER_BAP, &hdr, sizeof(hdr),
-					 txfid, HERMES_802_3_OFFSET);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d writing packet header to BAP\n",
-			       dev->name, err);
-			stats->tx_errors++;
-			goto fail;
-		}
-	} else { /* IEEE 802.3 frame */
-		data_len = len + ETH_HLEN;
-		data_off = HERMES_802_3_OFFSET;
-		p = skb->data;
-	}
-
-	/* Round up for odd length packets */
-	err = hermes_bap_pwrite(hw, USER_BAP, p, RUP_EVEN(data_len), txfid, data_off);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d writing packet to BAP\n",
-		       dev->name, err);
-		stats->tx_errors++;
-		goto fail;
-	}
-
-	/* Finally, we actually initiate the send */
-	netif_stop_queue(dev);
-
-	err = hermes_docmd_wait(hw, HERMES_CMD_TX | HERMES_CMD_RECL, txfid, NULL);
-	if (err) {
-		netif_start_queue(dev);
-		printk(KERN_ERR "%s: Error %d transmitting packet\n", dev->name, err);
-		stats->tx_errors++;
-		goto fail;
-	}
-
-	dev->trans_start = jiffies;
-	stats->tx_bytes += data_off + data_len;
-
-	orinoco_unlock(priv, &flags);
+		err = hermes_read_ltv(hw, USER_BAP, rid, sizeof(essidbuf),
+				      NULL, &essidbuf);
+		if (err)
+			goto fail_unlock;
+	} else {
+		*active = 0;
 
-	dev_kfree_skb(skb);
+		err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_CURRENTSSID,
+				      sizeof(essidbuf), NULL, &essidbuf);
+		if (err)
+			goto fail_unlock;
+	}
 
-	TRACE_EXIT(dev->name);
+	len = le16_to_cpu(essidbuf.len);
 
-	return 0;
- fail:
-	TRACE_EXIT(dev->name);
+	memset(buf, 0, IW_ESSID_MAX_SIZE+1);
+	memcpy(buf, p, len);
+	buf[len] = '\0';
 
+ fail_unlock:
 	orinoco_unlock(priv, &flags);
-	return err;
+
+	return err;       
 }
 
-static void
-orinoco_tx_timeout(struct net_device *dev)
+static long orinoco_hw_get_freq(struct orinoco_private *priv)
 {
-	struct orinoco_private *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &priv->stats;
-	struct hermes *hw = &priv->hw;
-
-	printk(KERN_WARNING "%s: Tx timeout! "
-	       "ALLOCFID=%04x, TXCOMPLFID=%04x, EVSTAT=%04x\n",
-	       dev->name, hermes_read_regn(hw, ALLOCFID),
-	       hermes_read_regn(hw, TXCOMPLFID), hermes_read_regn(hw, EVSTAT));
-
-	stats->tx_errors++;
+	
+	hermes_t *hw = &priv->hw;
+	int err = 0;
+	u16 channel;
+	long freq = 0;
+	unsigned long flags;
 
-	schedule_work(&priv->reset_work);
-}
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return err;
+	
+	err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CURRENTCHANNEL, &channel);
+	if (err)
+		goto out;
 
-static int
-orinoco_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
+	/* Intersil firmware 1.3.5 returns 0 when the interface is down */
+	if (channel == 0) {
+		err = -EBUSY;
+		goto out;
+	}
 
-	if ( (new_mtu < ORINOCO_MIN_MTU) || (new_mtu > ORINOCO_MAX_MTU) )
-		return -EINVAL;
+	if ( (channel < 1) || (channel > NUM_CHANNELS) ) {
+		printk(KERN_WARNING "%s: Channel out of range (%d)!\n",
+		       priv->ndev->name, channel);
+		err = -EBUSY;
+		goto out;
 
-	if ( (new_mtu + ENCAPS_OVERHEAD + IEEE802_11_HLEN) >
-	     (priv->nicbuf_size - ETH_HLEN) )
-		return -EINVAL;
+	}
+	freq = channel_frequency[channel-1] * 100000;
 
-	dev->mtu = new_mtu;
+ out:
+	orinoco_unlock(priv, &flags);
 
-	return 0;
+	if (err > 0)
+		err = -EBUSY;
+	return err ? err : freq;
 }
 
-/* FIXME: return int? */
-static void
-__orinoco_set_multicast_list(struct net_device *dev)
+static int orinoco_hw_get_bitratelist(struct orinoco_private *priv,
+				      int *numrates, s32 *rates, int max)
 {
-	struct orinoco_private *priv = netdev_priv(dev);
 	hermes_t *hw = &priv->hw;
+	struct hermes_idstring list;
+	unsigned char *p = (unsigned char *)&list.val;
 	int err = 0;
-	int promisc, mc_count;
-
-	/* The Hermes doesn't seem to have an allmulti mode, so we go
-	 * into promiscuous mode and let the upper levels deal. */
-	if ( (dev->flags & IFF_PROMISC) || (dev->flags & IFF_ALLMULTI) ||
-	     (dev->mc_count > MAX_MULTICAST(priv)) ) {
-		promisc = 1;
-		mc_count = 0;
-	} else {
-		promisc = 0;
-		mc_count = dev->mc_count;
-	}
+	int num;
+	int i;
+	unsigned long flags;
 
-	if (promisc != priv->promiscuous) {
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFPROMISCUOUSMODE,
-					   promisc);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting PROMISCUOUSMODE to 1.\n",
-			       dev->name, err);
-		} else 
-			priv->promiscuous = promisc;
-	}
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return err;
 
-	if (! promisc && (mc_count || priv->mc_count) ) {
-		struct dev_mc_list *p = dev->mc_list;
-		hermes_multicast_t mclist;
-		int i;
+	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_SUPPORTEDDATARATES,
+			      sizeof(list), NULL, &list);
+	orinoco_unlock(priv, &flags);
 
-		for (i = 0; i < mc_count; i++) {
-			/* Paranoia: */
-			if (! p)
-				BUG(); /* Multicast list shorter than mc_count */
-			if (p->dmi_addrlen != ETH_ALEN)
-				BUG(); /* Bad address size in multicast list */
-			
-			memcpy(mclist.addr[i], p->dmi_addr, ETH_ALEN);
-			p = p->next;
-		}
-		
-		if (p)
-			printk(KERN_WARNING "Multicast list is longer than mc_count\n");
+	if (err)
+		return err;
+	
+	num = le16_to_cpu(list.len);
+	*numrates = num;
+	num = min(num, max);
 
-		err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFGROUPADDRESSES,
-				       HERMES_BYTES_TO_RECLEN(priv->mc_count * ETH_ALEN),
-				       &mclist);
-		if (err)
-			printk(KERN_ERR "%s: Error %d setting multicast list.\n",
-			       dev->name, err);
-		else
-			priv->mc_count = mc_count;
+	for (i = 0; i < num; i++) {
+		rates[i] = (p[i] & 0x7f) * 500000; /* convert to bps */
 	}
 
-	/* Since we can set the promiscuous flag when it wasn't asked
-	   for, make sure the net_device knows about it. */
-	if (priv->promiscuous)
-		dev->flags |= IFF_PROMISC;
-	else
-		dev->flags &= ~IFF_PROMISC;
+	return 0;
 }
 
-/********************************************************************/
-/* Wireless extensions support                                      */
-/********************************************************************/
-
 static int orinoco_ioctl_getiwrange(struct net_device *dev, struct iw_point *rrq)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
@@ -4102,51 +4084,68 @@
 	return 0;
 }
 
-struct net_device *alloc_orinocodev(int sizeof_card, int (*hard_reset)(struct orinoco_private *))
-{
-	struct net_device *dev;
-	struct orinoco_private *priv;
-
-	dev = alloc_etherdev(sizeof(struct orinoco_private) + sizeof_card);
-	if (!dev)
-		return NULL;
-	priv = netdev_priv(dev);
-	priv->ndev = dev;
-	if (sizeof_card)
-		priv->card = (void *)((unsigned long)dev->priv + sizeof(struct orinoco_private));
-	else
-		priv->card = NULL;
-
-	/* Setup / override net_device fields */
-	dev->init = orinoco_init;
-	dev->hard_start_xmit = orinoco_xmit;
-	dev->tx_timeout = orinoco_tx_timeout;
-	dev->watchdog_timeo = HZ; /* 1 second timeout */
-	dev->get_stats = orinoco_get_stats;
-	dev->get_wireless_stats = orinoco_get_wireless_stats;
-	dev->do_ioctl = orinoco_ioctl;
-	dev->change_mtu = orinoco_change_mtu;
-	dev->set_multicast_list = orinoco_set_multicast_list;
-	/* we use the default eth_mac_addr for setting the MAC addr */
-
-	/* Set up default callbacks */
-	dev->open = orinoco_open;
-	dev->stop = orinoco_stop;
-	priv->hard_reset = hard_reset;
+/********************************************************************/
+/* Debugging                                                        */
+/********************************************************************/
 
-	spin_lock_init(&priv->lock);
-	priv->open = 0;
-	priv->hw_unavailable = 1; /* orinoco_init() must clear this
-				   * before anything else touches the
-				   * hardware */
-	INIT_WORK(&priv->reset_work, (void (*)(void *))orinoco_reset, dev);
+#if 0
+static void show_rx_frame(struct orinoco_rxframe_hdr *frame)
+{
+	printk(KERN_DEBUG "RX descriptor:\n");
+	printk(KERN_DEBUG "  status      = 0x%04x\n", frame->desc.status);
+	printk(KERN_DEBUG "  time        = 0x%08x\n", frame->desc.time);
+	printk(KERN_DEBUG "  silence     = 0x%02x\n", frame->desc.silence);
+	printk(KERN_DEBUG "  signal      = 0x%02x\n", frame->desc.signal);
+	printk(KERN_DEBUG "  rate        = 0x%02x\n", frame->desc.rate);
+	printk(KERN_DEBUG "  rxflow      = 0x%02x\n", frame->desc.rxflow);
+	printk(KERN_DEBUG "  reserved    = 0x%08x\n", frame->desc.reserved);
 
-	priv->last_linkstatus = 0xffff;
-	priv->connected = 0;
+	printk(KERN_DEBUG "IEEE 802.11 header:\n");
+	printk(KERN_DEBUG "  frame_ctl   = 0x%04x\n",
+	       frame->p80211.frame_ctl);
+	printk(KERN_DEBUG "  duration_id = 0x%04x\n",
+	       frame->p80211.duration_id);
+	printk(KERN_DEBUG "  addr1       = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       frame->p80211.addr1[0], frame->p80211.addr1[1],
+	       frame->p80211.addr1[2], frame->p80211.addr1[3],
+	       frame->p80211.addr1[4], frame->p80211.addr1[5]);
+	printk(KERN_DEBUG "  addr2       = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       frame->p80211.addr2[0], frame->p80211.addr2[1],
+	       frame->p80211.addr2[2], frame->p80211.addr2[3],
+	       frame->p80211.addr2[4], frame->p80211.addr2[5]);
+	printk(KERN_DEBUG "  addr3       = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       frame->p80211.addr3[0], frame->p80211.addr3[1],
+	       frame->p80211.addr3[2], frame->p80211.addr3[3],
+	       frame->p80211.addr3[4], frame->p80211.addr3[5]);
+	printk(KERN_DEBUG "  seq_ctl     = 0x%04x\n",
+	       frame->p80211.seq_ctl);
+	printk(KERN_DEBUG "  addr4       = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       frame->p80211.addr4[0], frame->p80211.addr4[1],
+	       frame->p80211.addr4[2], frame->p80211.addr4[3],
+	       frame->p80211.addr4[4], frame->p80211.addr4[5]);
+	printk(KERN_DEBUG "  data_len    = 0x%04x\n",
+	       frame->p80211.data_len);
 
-	return dev;
+	printk(KERN_DEBUG "IEEE 802.3 header:\n");
+	printk(KERN_DEBUG "  dest        = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       frame->p8023.h_dest[0], frame->p8023.h_dest[1],
+	       frame->p8023.h_dest[2], frame->p8023.h_dest[3],
+	       frame->p8023.h_dest[4], frame->p8023.h_dest[5]);
+	printk(KERN_DEBUG "  src         = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       frame->p8023.h_source[0], frame->p8023.h_source[1],
+	       frame->p8023.h_source[2], frame->p8023.h_source[3],
+	       frame->p8023.h_source[4], frame->p8023.h_source[5]);
+	printk(KERN_DEBUG "  len         = 0x%04x\n", frame->p8023.h_proto);
 
+	printk(KERN_DEBUG "IEEE 802.2 LLC/SNAP header:\n");
+	printk(KERN_DEBUG "  DSAP        = 0x%02x\n", frame->p8022.dsap);
+	printk(KERN_DEBUG "  SSAP        = 0x%02x\n", frame->p8022.ssap);
+	printk(KERN_DEBUG "  ctrl        = 0x%02x\n", frame->p8022.ctrl);
+	printk(KERN_DEBUG "  OUI         = %02x:%02x:%02x\n",
+	       frame->p8022.oui[0], frame->p8022.oui[1], frame->p8022.oui[2]);
+	printk(KERN_DEBUG "  ethertype  = 0x%04x\n", frame->ethertype);
 }
+#endif /* 0 */
 
 /********************************************************************/
 /* Module initialization                                            */
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2004-07-28 14:56:32.926732688 +1000
+++ working-2.6/drivers/net/wireless/orinoco.h	2004-07-28 14:56:33.743608504 +1000
@@ -27,11 +27,6 @@
 	char data[ORINOCO_MAX_KEY_SIZE];
 } __attribute__ ((packed));
 
-#define ORINOCO_INTEN	 	( HERMES_EV_RX | HERMES_EV_ALLOC | HERMES_EV_TX | \
-				HERMES_EV_TXEXC | HERMES_EV_WTERR | HERMES_EV_INFO | \
-				HERMES_EV_INFDROP )
-
-
 struct orinoco_private {
 	void *card;	/* Pointer to card dependent structure */
 	int (*hard_reset)(struct orinoco_private *);
Index: working-2.6/drivers/net/wireless/hermes.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.h	2004-05-24 11:20:52.000000000 +1000
+++ working-2.6/drivers/net/wireless/hermes.h	2004-07-28 14:56:48.180413776 +1000
@@ -157,16 +157,6 @@
 #define HERMES_802_3_OFFSET		(14+32)
 #define HERMES_802_2_OFFSET		(14+32+14)
 
-struct hermes_rx_descriptor {
-	u16 status;
-	u32 time;
-	u8 silence;
-	u8 signal;
-	u8 rate;
-	u8 rxflow;
-	u32 reserved;
-} __attribute__ ((packed));
-
 #define HERMES_RXSTAT_ERR		(0x0003)
 #define	HERMES_RXSTAT_BADCRC		(0x0001)
 #define	HERMES_RXSTAT_UNDECRYPTABLE	(0x0002)
@@ -262,6 +252,20 @@
 	u16 linkstatus;         /* Link status */
 } __attribute__ ((packed));
 
+typedef struct hermes_response {
+	u16 status, resp0, resp1, resp2;
+} hermes_response_t;
+
+/* "ID" structure - used for ESSID and station nickname */
+struct hermes_idstring {
+	u16 len;
+	u16 val[16];
+} __attribute__ ((packed));
+
+typedef struct hermes_multicast {
+	u8 addr[HERMES_MAX_MULTICAST][ETH_ALEN];
+} __attribute__ ((packed)) hermes_multicast_t;
+
 // #define HERMES_DEBUG_BUFFER 1
 #define HERMES_DEBUG_BUFSIZE 4096
 struct hermes_debug_entry {
@@ -294,10 +298,6 @@
 #endif
 } hermes_t;
 
-typedef struct hermes_response {
-	u16 status, resp0, resp1, resp2;
-} hermes_response_t;
-
 /* Register access convenience macros */
 #define hermes_read_reg(hw, off) ((hw)->io_space ? \
 	inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
Index: working-2.6/drivers/net/wireless/hermes_rid.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes_rid.h	2004-05-20 12:58:17.000000000 +1000
+++ working-2.6/drivers/net/wireless/hermes_rid.h	2004-07-28 14:56:33.745608200 +1000
@@ -140,14 +140,4 @@
 #define HERMES_RID_BUILDSEQ			0xFFFE
 #define HERMES_RID_FWID				0xFFFF
 
-/* "ID" structure - used for ESSID and station nickname */
-struct hermes_idstring {
-	u16 len;
-	u16 val[16];
-} __attribute__ ((packed));
-
-typedef struct hermes_multicast {
-	u8 addr[HERMES_MAX_MULTICAST][ETH_ALEN];
-} __attribute__ ((packed)) hermes_multicast_t;
-
 #endif

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
