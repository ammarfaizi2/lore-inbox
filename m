Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWDKH31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWDKH31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDKH31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:29:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13743 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932308AbWDKH30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:29:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Dave Dillow <dave@thedillows.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
Date: Tue, 11 Apr 2006 10:28:54 +0300
User-Agent: KMail/1.8.2
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604101716.58463.vda@ilport.com.ua> <1144682807.12177.22.camel@dillow.idleaire.com>
In-Reply-To: <1144682807.12177.22.camel@dillow.idleaire.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111028.54813.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > block? For example, typhoon.c:
> > > > 
> > > >                 spin_lock(&tp->state_lock);
> > > > +#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> > > >                 if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
> > > >                         vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
> > > >                                                  ntohl(rx->vlanTag) & 0xffff);
> > > >                 else
> > > > +#endif
> > > >                         netif_receive_skb(new_skb);
> > > >                 spin_unlock(&tp->state_lock);
> > > > 
> > > > Same for s2io.c, chelsio/sge.c, etc...
> > > 
> > > Very likely yes.  tp->vlgrp will never be non-NULL in such situations
> > > so it's not a correctness issue, but rather an optimization :-)
> 
> I see this as a minor optimization, at the cost uglifying the body of a
> function.

But it saves some text (~5k total in all network drivers)
and removes a branch on rx path on non-VLAN enabled kernels...

> Besides, if you're going to do this, you can get rid of the 
> spin_lock functions around it to, since they only protect tp->vlgrp in
> this instance.

Done.

> Please don't apply this to typhoon.c

Please comment on the below patch fragment, is it ok with you?

diff -urpN linux-2.6.16.org/drivers/net/typhoon.c linux-2.6.16.vlan/drivers/net/typhoon.c
--- linux-2.6.16.org/drivers/net/typhoon.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/typhoon.c	Tue Apr 11 10:21:19 2006
@@ -285,7 +285,9 @@ struct typhoon {
 	struct pci_dev *	pdev;
 	struct net_device *	dev;
 	spinlock_t		state_lock;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_group *	vlgrp;
+#endif
 	struct basic_ring	rxHiRing;
 	struct basic_ring	rxBuffRing;
 	struct rxbuff_ent	rxbuffers[RXENT_ENTRIES];
@@ -707,6 +709,7 @@ out:
 	return err;
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void
 typhoon_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
@@ -754,6 +757,7 @@ typhoon_vlan_rx_kill_vid(struct net_devi
 		tp->vlgrp->vlan_devices[vid] = NULL;
 	spin_unlock_bh(&tp->state_lock);
 }
+#endif
 
 static inline void
 typhoon_tso_fill(struct sk_buff *skb, struct transmit_ring *txRing,
@@ -837,6 +841,7 @@ typhoon_start_tx(struct sk_buff *skb, st
 		first_txd->processFlags |= TYPHOON_TX_PF_IP_CHKSUM;
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if(vlan_tx_tag_present(skb)) {
 		first_txd->processFlags |=
 		    TYPHOON_TX_PF_INSERT_VLAN | TYPHOON_TX_PF_VLAN_PRIORITY;
@@ -844,6 +849,7 @@ typhoon_start_tx(struct sk_buff *skb, st
 		    cpu_to_le32(htons(vlan_tx_tag_get(skb)) <<
 				TYPHOON_TX_PF_VLAN_TAG_SHIFT);
 	}
+#endif
 
 	if(skb_tso_size(skb)) {
 		first_txd->processFlags |= TYPHOON_TX_PF_TCP_SEGMENT;
@@ -1744,13 +1750,15 @@ typhoon_rx(struct typhoon *tp, struct ba
 		} else
 			new_skb->ip_summed = CHECKSUM_NONE;
 
-		spin_lock(&tp->state_lock);
-		if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+		if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN) {
+			spin_lock(&tp->state_lock);
 			vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
 						 ntohl(rx->vlanTag) & 0xffff);
-		else
+			spin_unlock(&tp->state_lock);
+		} else
+#endif
 			netif_receive_skb(new_skb);
-		spin_unlock(&tp->state_lock);
 
 		tp->dev->last_rx = jiffies;
 		received++;
@@ -2232,6 +2240,7 @@ typhoon_suspend(struct pci_dev *pdev, pm
 	if(!netif_running(dev))
 		return 0;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	spin_lock_bh(&tp->state_lock);
 	if(tp->vlgrp && tp->wol_events & TYPHOON_WAKE_MAGIC_PKT) {
 		spin_unlock_bh(&tp->state_lock);
@@ -2240,6 +2249,7 @@ typhoon_suspend(struct pci_dev *pdev, pm
 		return -EBUSY;
 	}
 	spin_unlock_bh(&tp->state_lock);
+#endif
 
 	netif_device_detach(dev);
 
@@ -2549,8 +2559,10 @@ typhoon_init_one(struct pci_dev *pdev, c
 	dev->watchdog_timeo	= TX_TIMEOUT;
 	dev->get_stats		= typhoon_get_stats;
 	dev->set_mac_address	= typhoon_set_mac_address;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	dev->vlan_rx_register	= typhoon_vlan_rx_register;
 	dev->vlan_rx_kill_vid	= typhoon_vlan_rx_kill_vid;
+#endif
 	SET_ETHTOOL_OPS(dev, &typhoon_ethtool_ops);
 
 	/* We can handle scatter gather, up to 16 entries, and

--
vda
