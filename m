Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWDLI6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWDLI6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDLI6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:58:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41189 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932117AbWDLI6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:58:16 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
Date: Wed, 12 Apr 2006 11:55:55 +0300
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604111028.54813.vda@ilport.com.ua> <1144763984.16193.9.camel@dillow.idleaire.com>
In-Reply-To: <1144763984.16193.9.camel@dillow.idleaire.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bCMPEP9MeIYy4G5"
Message-Id: <200604121155.55561.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bCMPEP9MeIYy4G5
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 April 2006 16:59, Dave Dillow wrote:
> DaveM beat me to it, but as he said, it saves 5K only if you have all
> the drivers built in

I have most of network drivers built in.
I want network card to work right away in early boot,
and I prefer to not regenerate initrd with new nic modules for
each new kernel which I build for diskless stations.

> or loaded. And even if it saves 200 bytes in one 
> module, unless that module text was already less than 200 bytes into a
> page, you've saved no memory -- a 4300 byte module takes 2 pages on x86,
> as does a 4100 byte module.

Sometimes, those 200 bytes can bring module size just under 4096.
Thus on the average, on many modules you get the same size savings
as on built-in code. (Not that we have THAT many network modules...)

> The only savings is in instruction cache, and it would be better to
> perhaps uninline vlan_hwaccel_receive_skb() or __vlan_hwaccel_rx() and
> make vlan_tx_tag_present be
> 
> #if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> #define vlan_tx_tag_present(__skb) \
>         (VLAN_TX_SKB_CB(__skb)->magic == VLAN_TX_COOKIE_MAGIC)
> #else
> #define vlan_tx_tag_present(x) 	0
> #endif
> 
> to get the cache savings on the hot paths without the ugliness.

Good idea.

> > > Besides, if you're going to do this, you can get rid of the 
> > > spin_lock functions around it to, since they only protect tp->vlgrp in
> > > this instance.
> > 
> > Done.
> > 
> > > Please don't apply this to typhoon.c
> > 
> > Please comment on the below patch fragment, is it ok with you?
> 
> NAK. The #ifdefs are ugly, for no significant gain.
> 
> And you introduced a race condition when you moved the spin_locks. The
> test for tp->vlgrp is no longer protected.

See attached. Much less #ifdefs (most of the time I test for compile time
constant VLAN_ENABLED in the if()s instead), the race is fixed.

Please apply your ugli-o-meter to it...
--
vda

--Boundary-00=_bCMPEP9MeIYy4G5
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.6.16.vlan_inline8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.vlan_inline8.patch"

diff -urpN linux-2.6.16.org/drivers/net/bnx2.c linux-2.6.16.vlan/drivers/net/bnx2.c
--- linux-2.6.16.org/drivers/net/bnx2.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bnx2.c	Wed Apr 12 11:29:34 2006
@@ -4436,10 +4436,13 @@ bnx2_start_xmit(struct sk_buff *skb, str
 		vlan_tag_flags |= TX_BD_FLAGS_TCP_UDP_CKSUM;
 	}
 
+#ifdef BCM_VLAN
 	if (bp->vlgrp != 0 && vlan_tx_tag_present(skb)) {
 		vlan_tag_flags |=
 			(TX_BD_FLAGS_VLAN_TAG | (vlan_tx_tag_get(skb) << 16));
 	}
+#endif
+
 #ifdef BCM_TSO 
 	if ((mss = skb_shinfo(skb)->tso_size) &&
 		(skb->len > (bp->dev->mtu + ETH_HLEN))) {
diff -urpN linux-2.6.16.org/drivers/net/bnx2.h linux-2.6.16.vlan/drivers/net/bnx2.h
--- linux-2.6.16.org/drivers/net/bnx2.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bnx2.h	Wed Apr 12 11:29:34 2006
@@ -40,7 +40,9 @@
 #include <linux/mii.h>
 #ifdef NETIF_F_HW_VLAN_TX
 #include <linux/if_vlan.h>
+#if VLAN_ENABLED
 #define BCM_VLAN 1
+#endif
 #endif
 #ifdef NETIF_F_TSO
 #include <net/ip.h>
diff -urpN linux-2.6.16.org/drivers/net/bonding/bond_alb.c linux-2.6.16.vlan/drivers/net/bonding/bond_alb.c
--- linux-2.6.16.org/drivers/net/bonding/bond_alb.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bonding/bond_alb.c	Wed Apr 12 11:29:34 2006
@@ -502,7 +502,7 @@ static void rlb_update_client(struct rlb
 
 		skb->dev = client_info->slave->dev;
 
-		if (client_info->tag) {
+		if (VLAN_ENABLED && client_info->tag) {
 			skb = vlan_put_tag(skb, client_info->vlan_id);
 			if (!skb) {
 				printk(KERN_ERR DRV_NAME
@@ -511,7 +511,6 @@ static void rlb_update_client(struct rlb
 				continue;
 			}
 		}
-
 		arp_xmit(skb);
 	}
 }
@@ -671,7 +670,7 @@ static struct slave *rlb_choose_channel(
 			client_info->ntt = 0;
 		}
 
-		if (!list_empty(&bond->vlan_list)) {
+		if (VLAN_ENABLED && !list_empty(&bond->vlan_list)) {
 			unsigned short vlan_id;
 			int res = vlan_get_tag(skb, &vlan_id);
 			if (!res) {
@@ -833,6 +832,7 @@ static void rlb_deinitialize(struct bond
 	_unlock_rx_hashtbl(bond);
 }
 
+#if VLAN_ENABLED
 static void rlb_clear_vlan(struct bonding *bond, unsigned short vlan_id)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
@@ -865,16 +865,20 @@ static void rlb_clear_vlan(struct bondin
 
 	_unlock_rx_hashtbl(bond);
 }
+#endif
 
 /*********************** tlb/rlb shared functions *********************/
 
 static void alb_send_learning_packets(struct slave *slave, u8 mac_addr[])
 {
-	struct bonding *bond = bond_get_bond_by_slave(slave);
+	struct bonding *bond;
 	struct learning_pkt pkt;
 	int size = sizeof(struct learning_pkt);
 	int i;
 
+	if (VLAN_ENABLED)
+		bond = bond_get_bond_by_slave(slave);
+
 	memset(&pkt, 0, size);
 	memcpy(pkt.mac_dst, mac_addr, ETH_ALEN);
 	memcpy(pkt.mac_src, mac_addr, ETH_ALEN);
@@ -898,7 +902,7 @@ static void alb_send_learning_packets(st
 		skb->priority = TC_PRIO_CONTROL;
 		skb->dev = slave->dev;
 
-		if (!list_empty(&bond->vlan_list)) {
+		if (VLAN_ENABLED && !list_empty(&bond->vlan_list)) {
 			struct vlan_entry *vlan;
 
 			vlan = bond_next_vlan(bond,
@@ -918,7 +922,6 @@ static void alb_send_learning_packets(st
 				continue;
 			}
 		}
-
 		dev_queue_xmit(skb);
 	}
 }
@@ -1665,6 +1668,7 @@ int bond_alb_set_mac_address(struct net_
 	return 0;
 }
 
+#if VLAN_ENABLED
 void bond_alb_clear_vlan(struct bonding *bond, unsigned short vlan_id)
 {
 	if (bond->alb_info.current_alb_vlan &&
@@ -1676,4 +1680,4 @@ void bond_alb_clear_vlan(struct bonding 
 		rlb_clear_vlan(bond, vlan_id);
 	}
 }
-
+#endif
diff -urpN linux-2.6.16.org/drivers/net/bonding/bond_main.c linux-2.6.16.vlan/drivers/net/bonding/bond_main.c
--- linux-2.6.16.org/drivers/net/bonding/bond_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bonding/bond_main.c	Wed Apr 12 11:45:33 2006
@@ -199,6 +199,7 @@ const char *bond_mode_name(int mode)
 	}
 }
 
+#if VLAN_ENABLED
 /*---------------------------------- VLAN -----------------------------------*/
 
 /**
@@ -349,6 +350,10 @@ struct vlan_entry *bond_next_vlan(struct
 
 	return next;
 }
+#else
+/* never called */
+int bond_has_challenged_slaves(struct bonding *bond);
+#endif /* VLAN_ENABLED */
 
 /**
  * bond_dev_queue_xmit - Prepare skb for xmit.
@@ -368,7 +373,7 @@ int bond_dev_queue_xmit(struct bonding *
 {
 	unsigned short vlan_id;
 
-	if (!list_empty(&bond->vlan_list) &&
+	if (VLAN_ENABLED && !list_empty(&bond->vlan_list) &&
 	    !(slave_dev->features & NETIF_F_HW_VLAN_TX) &&
 	    vlan_get_tag(skb, &vlan_id) == 0) {
 		skb->dev = slave_dev;
@@ -390,6 +395,7 @@ int bond_dev_queue_xmit(struct bonding *
 	return 0;
 }
 
+#if VLAN_ENABLED
 /*
  * In the following 3 functions, bond_vlan_rx_register(), bond_vlan_rx_add_vid
  * and bond_vlan_rx_kill_vid, We don't protect the slave list iteration with a
@@ -555,6 +561,11 @@ unreg:
 out:
 	write_unlock_bh(&bond->lock);
 }
+#else
+/* never called */
+void bond_add_vlans_on_slave(struct bonding *bond, struct net_device *slave_dev);
+void bond_del_vlans_from_slave(struct bonding *bond, struct net_device *slave_dev);
+#endif /* VLAN_ENABLED */
 
 /*------------------------------- Link status -------------------------------*/
 
@@ -1217,7 +1228,7 @@ int bond_enslave(struct net_device *bond
 
 	/* vlan challenged mutual exclusion */
 	/* no need to lock since we're protected by rtnl_lock */
-	if (slave_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (VLAN_ENABLED && (slave_dev->features & NETIF_F_VLAN_CHALLENGED)) {
 		dprintk("%s: NETIF_F_VLAN_CHALLENGED\n", slave_dev->name);
 		if (!list_empty(&bond->vlan_list)) {
 			printk(KERN_ERR DRV_NAME
@@ -1235,7 +1246,7 @@ int bond_enslave(struct net_device *bond
 			       bond_dev->name);
 			bond_dev->features |= NETIF_F_VLAN_CHALLENGED;
 		}
-	} else {
+	} else if (VLAN_ENABLED) {
 		dprintk("%s: ! NETIF_F_VLAN_CHALLENGED\n", slave_dev->name);
 		if (bond->slave_cnt == 0) {
 			/* First slave, and it is not VLAN challenged,
@@ -1356,7 +1367,8 @@ int bond_enslave(struct net_device *bond
 		dev_mc_add(slave_dev, lacpdu_multicast, ETH_ALEN, 0);
 	}
 
-	bond_add_vlans_on_slave(bond, slave_dev);
+	if (VLAN_ENABLED)
+		bond_add_vlans_on_slave(bond, slave_dev);
 
 	write_lock_bh(&bond->lock);
 
@@ -1667,7 +1679,7 @@ int bond_release(struct net_device *bond
 		 */
 		memset(bond_dev->dev_addr, 0, bond_dev->addr_len);
 
-		if (list_empty(&bond->vlan_list)) {
+		if (!VLAN_ENABLED || list_empty(&bond->vlan_list)) {
 			bond_dev->features |= NETIF_F_VLAN_CHALLENGED;
 		} else {
 			printk(KERN_WARNING DRV_NAME
@@ -1679,7 +1691,7 @@ int bond_release(struct net_device *bond
 			       "HW address matches its VLANs'.\n",
 			       bond_dev->name);
 		}
-	} else if ((bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
+	} else if (VLAN_ENABLED && (bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 		   !bond_has_challenged_slaves(bond)) {
 		printk(KERN_INFO DRV_NAME
 		       ": %s: last VLAN challenged slave %s "
@@ -1693,7 +1705,8 @@ int bond_release(struct net_device *bond
 	/* must do this from outside any spinlocks */
 	bond_destroy_slave_symlinks(bond_dev, slave_dev);
 
-	bond_del_vlans_from_slave(bond, slave_dev);
+	if (VLAN_ENABLED)
+		bond_del_vlans_from_slave(bond, slave_dev);
 
 	/* If the mode USES_PRIMARY, then we should only remove its
 	 * promisc and mc settings if it was the curr_active_slave, but that was
@@ -1785,7 +1798,8 @@ static int bond_release_all(struct net_d
 		write_unlock_bh(&bond->lock);
 
 		bond_destroy_slave_symlinks(bond_dev, slave_dev);
-		bond_del_vlans_from_slave(bond, slave_dev);
+		if (VLAN_ENABLED)
+			bond_del_vlans_from_slave(bond, slave_dev);
 
 		/* If the mode USES_PRIMARY, then we should only remove its
 		 * promisc and mc settings if it was the curr_active_slave, but that was
@@ -1835,7 +1849,7 @@ static int bond_release_all(struct net_d
 	 */
 	memset(bond_dev->dev_addr, 0, bond_dev->addr_len);
 
-	if (list_empty(&bond->vlan_list)) {
+	if (!VLAN_ENABLED || list_empty(&bond->vlan_list)) {
 		bond_dev->features |= NETIF_F_VLAN_CHALLENGED;
 	} else {
 		printk(KERN_WARNING DRV_NAME
@@ -2239,7 +2253,7 @@ static int bond_has_ip(struct bonding *b
 	if (bond->master_ip)
 		return 1;
 
-	if (list_empty(&bond->vlan_list))
+	if (!VLAN_ENABLED || list_empty(&bond->vlan_list))
 		return 0;
 
 	list_for_each_entry_safe(vlan, vlan_next, &bond->vlan_list,
@@ -2270,7 +2284,7 @@ static void bond_arp_send(struct net_dev
 		printk(KERN_ERR DRV_NAME ": ARP packet allocation failed\n");
 		return;
 	}
-	if (vlan_id) {
+	if (VLAN_ENABLED && vlan_id) {
 		skb = vlan_put_tag(skb, vlan_id);
 		if (!skb) {
 			printk(KERN_ERR DRV_NAME ": failed to insert VLAN tag\n");
@@ -2283,7 +2297,7 @@ static void bond_arp_send(struct net_dev
 
 static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
-	int i, vlan_id, rv;
+	int i,vlan_id, rv;
 	u32 *targets = bond->params.arp_targets;
 	struct vlan_entry *vlan, *vlan_next;
 	struct net_device *vlan_dev;
@@ -2294,7 +2308,7 @@ static void bond_arp_send_all(struct bon
 		if (!targets[i])
 			continue;
 		dprintk("basa: target %x\n", targets[i]);
-		if (list_empty(&bond->vlan_list)) {
+		if (!VLAN_ENABLED || list_empty(&bond->vlan_list)) {
 			dprintk("basa: empty vlan: arp_send\n");
 			bond_arp_send(slave->dev, ARPOP_REQUEST, targets[i],
 				      bond->master_ip, 0);
@@ -2369,7 +2383,6 @@ static void bond_send_gratuitous_arp(str
 	struct slave *slave = bond->curr_active_slave;
 	struct vlan_entry *vlan;
 	struct net_device *vlan_dev;
-
 	dprintk("bond_send_grat_arp: bond %s slave %s\n", bond->dev->name,
 				slave ? slave->dev->name : "NULL");
 	if (!slave)
@@ -2380,11 +2393,13 @@ static void bond_send_gratuitous_arp(str
 				  bond->master_ip, 0);
 	}
 
-	list_for_each_entry(vlan, &bond->vlan_list, vlan_list) {
-		vlan_dev = bond->vlgrp->vlan_devices[vlan->vlan_id];
-		if (vlan->vlan_ip) {
-			bond_arp_send(slave->dev, ARPOP_REPLY, vlan->vlan_ip,
-				      vlan->vlan_ip, vlan->vlan_id);
+	if (VLAN_ENABLED) {
+		list_for_each_entry(vlan, &bond->vlan_list, vlan_list) {
+			vlan_dev = bond->vlgrp->vlan_devices[vlan->vlan_id];
+			if (vlan->vlan_ip) {
+				bond_arp_send(slave->dev, ARPOP_REPLY, vlan->vlan_ip,
+					      vlan->vlan_ip, vlan->vlan_id);
+			}
 		}
 	}
 }
@@ -3215,7 +3230,7 @@ static int bond_inetaddr_event(struct no
 			}
 		}
 
-		if (list_empty(&bond->vlan_list))
+		if (!VLAN_ENABLED || list_empty(&bond->vlan_list))
 			continue;
 
 		list_for_each_entry_safe(vlan, vlan_next, &bond->vlan_list,
@@ -4120,7 +4135,8 @@ static int bond_init(struct net_device *
 	bond->current_arp_slave = NULL;
 	bond->primary_slave = NULL;
 	bond->dev = bond_dev;
-	INIT_LIST_HEAD(&bond->vlan_list);
+	if (VLAN_ENABLED)
+		INIT_LIST_HEAD(&bond->vlan_list);
 
 	/* Initialize the device entry points */
 	bond_dev->open = bond_open;
@@ -4151,6 +4167,7 @@ static int bond_init(struct net_device *
 	 * transmitting */
 	bond_dev->features |= NETIF_F_LLTX;
 
+#if VLAN_ENABLED
 	/* By default, we declare the bond to be fully
 	 * VLAN hardware accelerated capable. Special
 	 * care is taken in the various xmit functions
@@ -4163,6 +4180,7 @@ static int bond_init(struct net_device *
 	bond_dev->features |= (NETIF_F_HW_VLAN_TX |
 			       NETIF_F_HW_VLAN_RX |
 			       NETIF_F_HW_VLAN_FILTER);
+#endif
 
 #ifdef CONFIG_PROC_FS
 	bond_create_proc_entry(bond);
diff -urpN linux-2.6.16.org/drivers/net/chelsio/sge.c linux-2.6.16.vlan/drivers/net/chelsio/sge.c
--- linux-2.6.16.org/drivers/net/chelsio/sge.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/chelsio/sge.c	Wed Apr 12 11:29:34 2006
@@ -978,7 +978,7 @@ static int sge_rx(struct sge *sge, struc
 	} else
 		skb->ip_summed = CHECKSUM_NONE;
 
-	if (unlikely(adapter->vlan_grp && p->vlan_valid)) {
+	if (VLAN_ENABLED && unlikely(adapter->vlan_grp && p->vlan_valid)) {
 		sge->port_stats[p->iff].vlan_xtract++;
 		if (adapter->params.sge.polling)
 			vlan_hwaccel_receive_skb(skb, adapter->vlan_grp,
diff -urpN linux-2.6.16.org/drivers/net/e1000/e1000_main.c linux-2.6.16.vlan/drivers/net/e1000/e1000_main.c
--- linux-2.6.16.org/drivers/net/e1000/e1000_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/e1000/e1000_main.c	Wed Apr 12 11:39:31 2006
@@ -250,10 +250,16 @@ static void e1000_smartspeed(struct e100
 static inline int e1000_82547_fifo_workaround(struct e1000_adapter *adapter,
 					      struct sk_buff *skb);
 
+#if VLAN_ENABLED
 static void e1000_vlan_rx_register(struct net_device *netdev, struct vlan_group *grp);
 static void e1000_vlan_rx_add_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
+#else
+/* never called */
+void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
+void e1000_restore_vlan(struct e1000_adapter *adapter);
+#endif
 
 #ifdef CONFIG_PM
 static int e1000_suspend(struct pci_dev *pdev, pm_message_t state);
@@ -361,6 +367,7 @@ e1000_irq_enable(struct e1000_adapter *a
 	}
 }
 
+#if VLAN_ENABLED
 static void
 e1000_update_mng_vlan(struct e1000_adapter *adapter)
 {
@@ -383,6 +390,10 @@ e1000_update_mng_vlan(struct e1000_adapt
 		}
 	}
 }
+#else
+/* never called */
+void e1000_update_mng_vlan(struct e1000_adapter *adapter);
+#endif
 
 /**
  * e1000_release_hw_control - release control of the h/w to f/w
@@ -470,7 +481,8 @@ e1000_up(struct e1000_adapter *adapter)
 
 	e1000_set_multi(netdev);
 
-	e1000_restore_vlan(adapter);
+	if (VLAN_ENABLED)
+		e1000_restore_vlan(adapter);
 
 	e1000_configure_tx(adapter);
 	e1000_setup_rctl(adapter);
@@ -629,9 +641,12 @@ e1000_reset(struct e1000_adapter *adapte
 		E1000_WRITE_REG(&adapter->hw, WUC, 0);
 	if (e1000_init_hw(&adapter->hw))
 		DPRINTK(PROBE, ERR, "Hardware Error\n");
-	e1000_update_mng_vlan(adapter);
-	/* Enable h/w to recognize an 802.1Q VLAN Ethernet packet */
-	E1000_WRITE_REG(&adapter->hw, VET, ETHERNET_IEEE_VLAN_TYPE);
+
+	if (VLAN_ENABLED) {
+		e1000_update_mng_vlan(adapter);
+		/* Enable h/w to recognize an 802.1Q VLAN Ethernet packet */
+		E1000_WRITE_REG(&adapter->hw, VET, ETHERNET_IEEE_VLAN_TYPE);
+	}
 
 	e1000_reset_adaptive(&adapter->hw);
 	e1000_phy_get_info(&adapter->hw, &adapter->phy_info);
@@ -733,9 +748,11 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->poll = &e1000_clean;
 	netdev->weight = 64;
 #endif
+#if VLAN_ENABLED
 	netdev->vlan_rx_register = e1000_vlan_rx_register;
 	netdev->vlan_rx_add_vid = e1000_vlan_rx_add_vid;
 	netdev->vlan_rx_kill_vid = e1000_vlan_rx_kill_vid;
+#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	netdev->poll_controller = e1000_netpoll;
 #endif
@@ -1228,10 +1245,13 @@ e1000_open(struct net_device *netdev)
 
 	if ((err = e1000_up(adapter)))
 		goto err_up;
-	adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
-	if ((adapter->hw.mng_cookie.status &
-			  E1000_MNG_DHCP_COOKIE_STATUS_VLAN_SUPPORT)) {
-		e1000_update_mng_vlan(adapter);
+
+	if (VLAN_ENABLED) {
+		adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
+		if ((adapter->hw.mng_cookie.status &
+				  E1000_MNG_DHCP_COOKIE_STATUS_VLAN_SUPPORT)) {
+			e1000_update_mng_vlan(adapter);
+		}
 	}
 
 	/* If AMT is enabled, let the firmware know that the network
@@ -1274,7 +1294,7 @@ e1000_close(struct net_device *netdev)
 	e1000_free_all_tx_resources(adapter);
 	e1000_free_all_rx_resources(adapter);
 
-	if ((adapter->hw.mng_cookie.status &
+	if (VLAN_ENABLED && (adapter->hw.mng_cookie.status &
 			  E1000_MNG_DHCP_COOKIE_STATUS_VLAN_SUPPORT)) {
 		e1000_vlan_rx_kill_vid(netdev, adapter->mng_vlan_id);
 	}
@@ -2397,7 +2417,7 @@ e1000_watchdog_task(struct e1000_adapter
 	e1000_check_for_link(&adapter->hw);
 	if (adapter->hw.mac_type == e1000_82573) {
 		e1000_enable_tx_pkt_filtering(&adapter->hw);
-		if (adapter->mng_vlan_id != adapter->hw.mng_cookie.vlan_id)
+		if (VLAN_ENABLED && adapter->mng_vlan_id != adapter->hw.mng_cookie.vlan_id)
 			e1000_update_mng_vlan(adapter);
 	}
 
@@ -3714,7 +3734,7 @@ e1000_clean_rx_irq(struct e1000_adapter 
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_E1000_NAPI
-		if (unlikely(adapter->vlgrp &&
+		if (VLAN_ENABLED && unlikely(adapter->vlgrp &&
 			    (status & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 						 le16_to_cpu(rx_desc->special) &
@@ -3723,7 +3743,7 @@ e1000_clean_rx_irq(struct e1000_adapter 
 			netif_receive_skb(skb);
 		}
 #else /* CONFIG_E1000_NAPI */
-		if (unlikely(adapter->vlgrp &&
+		if (VLAN_ENABLED && unlikely(adapter->vlgrp &&
 			    (status & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 					le16_to_cpu(rx_desc->special) &
@@ -3861,7 +3881,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 			   cpu_to_le16(E1000_RXDPS_HDRSTAT_HDRSP)))
 			adapter->rx_hdr_split++;
 #ifdef CONFIG_E1000_NAPI
-		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
+		if (VLAN_ENABLED && unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->wb.middle.vlan) &
 				E1000_RXD_SPC_VLAN_MASK);
@@ -3869,7 +3889,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 			netif_receive_skb(skb);
 		}
 #else /* CONFIG_E1000_NAPI */
-		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
+		if (VLAN_ENABLED && unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->wb.middle.vlan) &
 				E1000_RXD_SPC_VLAN_MASK);
@@ -4351,6 +4371,7 @@ e1000_io_write(struct e1000_hw *hw, unsi
 	outl(value, port);
 }
 
+#if VLAN_ENABLED
 static void
 e1000_vlan_rx_register(struct net_device *netdev, struct vlan_group *grp)
 {
@@ -4382,7 +4403,7 @@ e1000_vlan_rx_register(struct net_device
 		rctl = E1000_READ_REG(&adapter->hw, RCTL);
 		rctl &= ~E1000_RCTL_VFE;
 		E1000_WRITE_REG(&adapter->hw, RCTL, rctl);
-		if (adapter->mng_vlan_id != (uint16_t)E1000_MNG_VLAN_NONE) {
+		if (VLAN_ENABLED && adapter->mng_vlan_id != (uint16_t)E1000_MNG_VLAN_NONE) {
 			e1000_vlan_rx_kill_vid(netdev, adapter->mng_vlan_id);
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
 		}
@@ -4450,6 +4471,7 @@ e1000_restore_vlan(struct e1000_adapter 
 		}
 	}
 }
+#endif
 
 int
 e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx)
diff -urpN linux-2.6.16.org/drivers/net/gianfar.c linux-2.6.16.vlan/drivers/net/gianfar.c
--- linux-2.6.16.org/drivers/net/gianfar.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/gianfar.c	Wed Apr 12 11:41:09 2006
@@ -270,15 +270,17 @@ static int gfar_probe(struct platform_de
 	} else
 		priv->rx_csum_enable = 0;
 
-	priv->vlgrp = NULL;
+	if (VLAN_ENABLED) {
+		priv->vlgrp = NULL;
 
-	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_VLAN) {
-		dev->vlan_rx_register = gfar_vlan_rx_register;
-		dev->vlan_rx_kill_vid = gfar_vlan_rx_kill_vid;
+		if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_VLAN) {
+			dev->vlan_rx_register = gfar_vlan_rx_register;
+			dev->vlan_rx_kill_vid = gfar_vlan_rx_kill_vid;
 
-		dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
+			dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
 
-		priv->vlan_enable = 1;
+			priv->vlan_enable = 1;
+		}
 	}
 
 	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_EXTENDED_HASH) {
@@ -792,7 +794,7 @@ int startup_gfar(struct net_device *dev)
 		rctrl |= RCTRL_EMEN;
 	}
 
-	if (priv->vlan_enable)
+	if (VLAN_ENABLED && priv->vlan_enable)
 		rctrl |= RCTRL_VLAN;
 
 	if (priv->padding) {
@@ -1037,6 +1039,7 @@ int gfar_set_mac_address(struct net_devi
 }
 
 
+#if VLAN_ENABLED
 /* Enables and disables VLAN insertion/extraction */
 static void gfar_vlan_rx_register(struct net_device *dev,
 		struct vlan_group *grp)
@@ -1088,6 +1091,7 @@ static void gfar_vlan_rx_kill_vid(struct
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
+#endif
 
 
 static int gfar_change_mtu(struct net_device *dev, int new_mtu)
@@ -1097,7 +1101,7 @@ static int gfar_change_mtu(struct net_de
 	int oldsize = priv->rx_buffer_size;
 	int frame_size = new_mtu + ETH_HLEN;
 
-	if (priv->vlan_enable)
+	if (VLAN_ENABLED && priv->vlan_enable)
 		frame_size += VLAN_ETH_HLEN;
 
 	if (gfar_uses_fcb(priv))
@@ -1409,7 +1413,7 @@ static int gfar_process_frame(struct net
 		skb->protocol = eth_type_trans(skb, dev);
 
 		/* Send the packet up the stack */
-		if (unlikely(priv->vlgrp && (fcb->flags & RXFCB_VLN)))
+		if (VLAN_ENABLED && unlikely(priv->vlgrp && (fcb->flags & RXFCB_VLN)))
 			ret = gfar_rx_vlan(skb, priv->vlgrp, fcb->vlctl);
 		else
 			ret = RECEIVE(skb);
diff -urpN linux-2.6.16.org/drivers/net/gianfar.h linux-2.6.16.vlan/drivers/net/gianfar.h
--- linux-2.6.16.org/drivers/net/gianfar.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/gianfar.h	Wed Apr 12 11:29:34 2006
@@ -702,7 +702,9 @@ struct gfar_private {
 		extended_hash:1,
 		bd_stash_en:1;
 	unsigned short padding;
+#if VLAN_ENABLED
 	struct vlan_group *vlgrp;
+#endif
 	/* Info structure initialized by board setup code */
 	unsigned int interruptTransmit;
 	unsigned int interruptReceive;
diff -urpN linux-2.6.16.org/drivers/net/ixgb/ixgb_main.c linux-2.6.16.vlan/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.16.org/drivers/net/ixgb/ixgb_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/ixgb/ixgb_main.c	Wed Apr 12 11:39:25 2006
@@ -121,11 +121,16 @@ static void ixgb_alloc_rx_buffers(struct
 void ixgb_set_ethtool_ops(struct net_device *netdev);
 static void ixgb_tx_timeout(struct net_device *dev);
 static void ixgb_tx_timeout_task(struct net_device *dev);
+#if VLAN_ENABLED
 static void ixgb_vlan_rx_register(struct net_device *netdev,
 				  struct vlan_group *grp);
 static void ixgb_vlan_rx_add_vid(struct net_device *netdev, uint16_t vid);
 static void ixgb_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void ixgb_restore_vlan(struct ixgb_adapter *adapter);
+#else
+/* never called */
+void ixgb_restore_vlan(struct ixgb_adapter *adapter);
+#endif
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /* for netdump / net console */
@@ -233,7 +238,8 @@ ixgb_up(struct ixgb_adapter *adapter)
 
 	ixgb_set_multi(netdev);
 
-	ixgb_restore_vlan(adapter);
+	if (VLAN_ENABLED)
+		ixgb_restore_vlan(adapter);
 
 	ixgb_configure_tx(adapter);
 	ixgb_setup_rctl(adapter);
@@ -419,9 +425,11 @@ ixgb_probe(struct pci_dev *pdev,
 	netdev->poll = &ixgb_clean;
 	netdev->weight = 64;
 #endif
+#if VLAN_ENABLED
 	netdev->vlan_rx_register = ixgb_vlan_rx_register;
 	netdev->vlan_rx_add_vid = ixgb_vlan_rx_add_vid;
 	netdev->vlan_rx_kill_vid = ixgb_vlan_rx_kill_vid;
+#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	netdev->poll_controller = ixgb_netpoll;
 #endif
@@ -1905,7 +1913,7 @@ ixgb_clean_rx_irq(struct ixgb_adapter *a
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_IXGB_NAPI
-		if(adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
+		if(VLAN_ENABLED && adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->special) &
 					IXGB_RX_DESC_SPECIAL_VLAN_MASK);
@@ -1913,7 +1921,7 @@ ixgb_clean_rx_irq(struct ixgb_adapter *a
 			netif_receive_skb(skb);
 		}
 #else /* CONFIG_IXGB_NAPI */
-		if(adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
+		if(VLAN_ENABLED && adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->special) &
 					IXGB_RX_DESC_SPECIAL_VLAN_MASK);
@@ -2014,6 +2022,7 @@ ixgb_alloc_rx_buffers(struct ixgb_adapte
 	rx_ring->next_to_use = i;
 }
 
+#if VLAN_ENABLED
 /**
  * ixgb_vlan_rx_register - enables or disables vlan tagging/stripping.
  * 
@@ -2107,6 +2116,7 @@ ixgb_restore_vlan(struct ixgb_adapter *a
 		}
 	}
 }
+#endif /* VLAN_ENABLED */
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /*
diff -urpN linux-2.6.16.org/drivers/net/s2io.c linux-2.6.16.vlan/drivers/net/s2io.c
--- linux-2.6.16.org/drivers/net/s2io.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/s2io.c	Wed Apr 12 11:40:33 2006
@@ -182,6 +182,7 @@ static char ethtool_stats_keys[][ETH_GST
 			timer.data = (unsigned long) arg;	\
 			mod_timer(&timer, (jiffies + exp))	\
 
+#if VLAN_ENABLED
 /* Add the vlan */
 static void s2io_vlan_rx_register(struct net_device *dev,
 					struct vlan_group *grp)
@@ -205,6 +206,7 @@ static void s2io_vlan_rx_kill_vid(struct
 		nic->vlgrp->vlan_devices[vid] = NULL;
 	spin_unlock_irqrestore(&nic->tx_lock, flags);
 }
+#endif
 
 /*
  * Constants to be programmed into the Xena's registers, to configure
@@ -3470,7 +3472,6 @@ static int s2io_xmit(struct sk_buff *skb
 	int mss;
 #endif
 	u16 vlan_tag = 0;
-	int vlan_priority = 0;
 	mac_info_t *mac_control;
 	struct config_param *config;
 
@@ -3491,6 +3492,7 @@ static int s2io_xmit(struct sk_buff *skb
 
 	/* Get Fifo number to Transmit based on vlan priority */
 	if (sp->vlgrp && vlan_tx_tag_present(skb)) {
+		int vlan_priority;
 		vlan_tag = vlan_tx_tag_get(skb);
 		vlan_priority = vlan_tag >> 13;
 		queue = config->fifo_mapping[vlan_priority];
@@ -5680,7 +5682,7 @@ static int rx_osm_handler(ring_info_t *r
 
 	skb->protocol = eth_type_trans(skb, dev);
 #ifdef CONFIG_S2IO_NAPI
-	if (sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
+	if (VLAN_ENABLED && sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
 		/* Queueing the vlan frame to the upper layer */
 		vlan_hwaccel_receive_skb(skb, sp->vlgrp,
 			RXD_GET_VLAN_TAG(rxdp->Control_2));
@@ -5688,7 +5690,7 @@ static int rx_osm_handler(ring_info_t *r
 		netif_receive_skb(skb);
 	}
 #else
-	if (sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
+	if (VLAN_ENABLED && sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
 		/* Queueing the vlan frame to the upper layer */
 		vlan_hwaccel_rx(skb, sp->vlgrp,
 			RXD_GET_VLAN_TAG(rxdp->Control_2));
@@ -6051,9 +6053,11 @@ Defaulting to INTA\n");
 	dev->do_ioctl = &s2io_ioctl;
 	dev->change_mtu = &s2io_change_mtu;
 	SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
+#if VLAN_ENABLED
 	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
 	dev->vlan_rx_register = s2io_vlan_rx_register;
 	dev->vlan_rx_kill_vid = (void *)s2io_vlan_rx_kill_vid;
+#endif
 
 	/*
 	 * will use eth_mac_addr() for  dev->set_mac_address
diff -urpN linux-2.6.16.org/drivers/net/typhoon.c linux-2.6.16.vlan/drivers/net/typhoon.c
--- linux-2.6.16.org/drivers/net/typhoon.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/typhoon.c	Wed Apr 12 11:40:48 2006
@@ -707,6 +707,7 @@ out:
 	return err;
 }
 
+#if VLAN_ENABLED
 static void
 typhoon_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
@@ -754,6 +755,7 @@ typhoon_vlan_rx_kill_vid(struct net_devi
 		tp->vlgrp->vlan_devices[vid] = NULL;
 	spin_unlock_bh(&tp->state_lock);
 }
+#endif
 
 static inline void
 typhoon_tso_fill(struct sk_buff *skb, struct transmit_ring *txRing,
@@ -1744,13 +1746,15 @@ typhoon_rx(struct typhoon *tp, struct ba
 		} else
 			new_skb->ip_summed = CHECKSUM_NONE;
 
-		spin_lock(&tp->state_lock);
-		if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
-			vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
+		if(VLAN_ENABLED) {
+			spin_lock(&tp->state_lock);
+			if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN) {
+				vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
 						 ntohl(rx->vlanTag) & 0xffff);
-		else
+			}
+			spin_unlock(&tp->state_lock);
+		} else
 			netif_receive_skb(new_skb);
-		spin_unlock(&tp->state_lock);
 
 		tp->dev->last_rx = jiffies;
 		received++;
@@ -2232,14 +2236,16 @@ typhoon_suspend(struct pci_dev *pdev, pm
 	if(!netif_running(dev))
 		return 0;
 
-	spin_lock_bh(&tp->state_lock);
-	if(tp->vlgrp && tp->wol_events & TYPHOON_WAKE_MAGIC_PKT) {
+	if(VLAN_ENABLED) {
+		spin_lock_bh(&tp->state_lock);
+		if(tp->vlgrp && tp->wol_events & TYPHOON_WAKE_MAGIC_PKT) {
+			spin_unlock_bh(&tp->state_lock);
+			printk(KERN_ERR "%s: cannot do WAKE_MAGIC with VLANS\n",
+					dev->name);
+			return -EBUSY;
+		}
 		spin_unlock_bh(&tp->state_lock);
-		printk(KERN_ERR "%s: cannot do WAKE_MAGIC with VLANS\n",
-				dev->name);
-		return -EBUSY;
 	}
-	spin_unlock_bh(&tp->state_lock);
 
 	netif_device_detach(dev);
 
@@ -2549,8 +2555,10 @@ typhoon_init_one(struct pci_dev *pdev, c
 	dev->watchdog_timeo	= TX_TIMEOUT;
 	dev->get_stats		= typhoon_get_stats;
 	dev->set_mac_address	= typhoon_set_mac_address;
+#if VLAN_ENABLED
 	dev->vlan_rx_register	= typhoon_vlan_rx_register;
 	dev->vlan_rx_kill_vid	= typhoon_vlan_rx_kill_vid;
+#endif
 	SET_ETHTOOL_OPS(dev, &typhoon_ethtool_ops);
 
 	/* We can handle scatter gather, up to 16 entries, and
diff -urpN linux-2.6.16.org/include/linux/if_vlan.h linux-2.6.16.vlan/include/linux/if_vlan.h
--- linux-2.6.16.org/include/linux/if_vlan.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/include/linux/if_vlan.h	Wed Apr 12 11:38:14 2006
@@ -23,6 +23,12 @@ struct vlan_collection;
 struct vlan_dev_info;
 struct hlist_node;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+#define VLAN_ENABLED 1
+#else
+#define VLAN_ENABLED 0
+#endif
+
 #include <linux/proc_fs.h> /* for proc_dir_entry */
 #include <linux/netdevice.h>
 
@@ -144,54 +150,18 @@ struct vlan_skb_tx_cookie {
 
 #define VLAN_TX_COOKIE_MAGIC	0x564c414e	/* "VLAN" in ascii. */
 #define VLAN_TX_SKB_CB(__skb)	((struct vlan_skb_tx_cookie *)&((__skb)->cb[0]))
+#if VLAN_ENABLED 1
 #define vlan_tx_tag_present(__skb) \
 	(VLAN_TX_SKB_CB(__skb)->magic == VLAN_TX_COOKIE_MAGIC)
+#else
+#define vlan_tx_tag_present(__skb) 0
+#endif
 #define vlan_tx_tag_get(__skb)	(VLAN_TX_SKB_CB(__skb)->vlan_tag)
 
 /* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_skb}(). */
-static inline int __vlan_hwaccel_rx(struct sk_buff *skb,
+int __vlan_hwaccel_rx(struct sk_buff *skb,
 				    struct vlan_group *grp,
-				    unsigned short vlan_tag, int polling)
-{
-	struct net_device_stats *stats;
-
-	skb->dev = grp->vlan_devices[vlan_tag & VLAN_VID_MASK];
-	if (skb->dev == NULL) {
-		dev_kfree_skb_any(skb);
-
-		/* Not NET_RX_DROP, this is not being dropped
-		 * due to congestion.
-		 */
-		return 0;
-	}
-
-	skb->dev->last_rx = jiffies;
-
-	stats = vlan_dev_get_stats(skb->dev);
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len;
-
-	skb->priority = vlan_get_ingress_priority(skb->dev, vlan_tag);
-	switch (skb->pkt_type) {
-	case PACKET_BROADCAST:
-		break;
-
-	case PACKET_MULTICAST:
-		stats->multicast++;
-		break;
-
-	case PACKET_OTHERHOST:
-		/* Our lower layer thinks this is not local, let's make sure.
-		 * This allows the VLAN to have a different MAC than the underlying
-		 * device, and still route correctly.
-		 */
-		if (!memcmp(eth_hdr(skb)->h_dest, skb->dev->dev_addr, ETH_ALEN))
-			skb->pkt_type = PACKET_HOST;
-		break;
-	};
-
-	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
-}
+				    unsigned short vlan_tag, int polling);
 
 static inline int vlan_hwaccel_rx(struct sk_buff *skb,
 				  struct vlan_group *grp,
@@ -218,43 +188,7 @@ static inline int vlan_hwaccel_receive_s
  * Following the skb_unshare() example, in case of error, the calling function
  * doesn't have to worry about freeing the original skb.
  */
-static inline struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag)
-{
-	struct vlan_ethhdr *veth;
-
-	if (skb_headroom(skb) < VLAN_HLEN) {
-		struct sk_buff *sk_tmp = skb;
-		skb = skb_realloc_headroom(sk_tmp, VLAN_HLEN);
-		kfree_skb(sk_tmp);
-		if (!skb) {
-			printk(KERN_ERR "vlan: failed to realloc headroom\n");
-			return NULL;
-		}
-	} else {
-		skb = skb_unshare(skb, GFP_ATOMIC);
-		if (!skb) {
-			printk(KERN_ERR "vlan: failed to unshare skbuff\n");
-			return NULL;
-		}
-	}
-
-	veth = (struct vlan_ethhdr *)skb_push(skb, VLAN_HLEN);
-
-	/* Move the mac addresses to the beginning of the new header. */
-	memmove(skb->data, skb->data + VLAN_HLEN, 2 * VLAN_ETH_ALEN);
-
-	/* first, the ethernet type */
-	veth->h_vlan_proto = __constant_htons(ETH_P_8021Q);
-
-	/* now, the tag */
-	veth->h_vlan_TCI = htons(tag);
-
-	skb->protocol = __constant_htons(ETH_P_8021Q);
-	skb->mac.raw -= VLAN_HLEN;
-	skb->nh.raw -= VLAN_HLEN;
-
-	return skb;
-}
+struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag);
 
 /**
  * __vlan_hwaccel_put_tag - hardware accelerated VLAN inserting
diff -urpN linux-2.6.16.org/include/linux/netdevice.h linux-2.6.16.vlan/include/linux/netdevice.h
--- linux-2.6.16.org/include/linux/netdevice.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/include/linux/netdevice.h	Wed Apr 12 11:29:34 2006
@@ -475,12 +475,14 @@ struct net_device
 #define HAVE_TX_TIMEOUT
 	void			(*tx_timeout) (struct net_device *dev);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	void			(*vlan_rx_register)(struct net_device *dev,
 						    struct vlan_group *grp);
 	void			(*vlan_rx_add_vid)(struct net_device *dev,
 						   unsigned short vid);
 	void			(*vlan_rx_kill_vid)(struct net_device *dev,
 						    unsigned short vid);
+#endif
 
 	int			(*hard_header_parse)(struct sk_buff *skb,
 						     unsigned char *haddr);
diff -urpN linux-2.6.16.org/net/8021q/Makefile linux-2.6.16.vlan/net/8021q/Makefile
--- linux-2.6.16.org/net/8021q/Makefile	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/net/8021q/Makefile	Wed Apr 12 11:29:34 2006
@@ -2,6 +2,8 @@
 # Makefile for the Linux VLAN layer.
 #
 
+obj-y			 += if_vlan.o 
+
 obj-$(CONFIG_VLAN_8021Q) += 8021q.o
 
 8021q-objs := vlan.o vlan_dev.o
diff -urpN linux-2.6.16.org/net/8021q/if_vlan.c linux-2.6.16.vlan/net/8021q/if_vlan.c
--- linux-2.6.16.org/net/8021q/if_vlan.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.vlan/net/8021q/if_vlan.c	Wed Apr 12 11:29:34 2006
@@ -0,0 +1,111 @@
+/* 802.1q helpers.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
+
+#if VLAN_ENABLED
+
+/* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_skb}(). */
+int __vlan_hwaccel_rx(struct sk_buff *skb,
+				    struct vlan_group *grp,
+				    unsigned short vlan_tag, int polling)
+{
+	struct net_device_stats *stats;
+
+	skb->dev = grp->vlan_devices[vlan_tag & VLAN_VID_MASK];
+	if (skb->dev == NULL) {
+		dev_kfree_skb_any(skb);
+
+		/* Not NET_RX_DROP, this is not being dropped
+		 * due to congestion.
+		 */
+		return 0;
+	}
+
+	skb->dev->last_rx = jiffies;
+
+	stats = vlan_dev_get_stats(skb->dev);
+	stats->rx_packets++;
+	stats->rx_bytes += skb->len;
+
+	skb->priority = vlan_get_ingress_priority(skb->dev, vlan_tag);
+	switch (skb->pkt_type) {
+	case PACKET_BROADCAST:
+		break;
+
+	case PACKET_MULTICAST:
+		stats->multicast++;
+		break;
+
+	case PACKET_OTHERHOST:
+		/* Our lower layer thinks this is not local, let's make sure.
+		 * This allows the VLAN to have a different MAC than the underlying
+		 * device, and still route correctly.
+		 */
+		if (!memcmp(eth_hdr(skb)->h_dest, skb->dev->dev_addr, ETH_ALEN))
+			skb->pkt_type = PACKET_HOST;
+		break;
+	};
+
+	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
+}
+EXPORT_SYMBOL(__vlan_hwaccel_rx);
+
+/**
+ * __vlan_put_tag - regular VLAN tag inserting
+ * @skb: skbuff to tag
+ * @tag: VLAN tag to insert
+ *
+ * Inserts the VLAN tag into @skb as part of the payload
+ * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
+ * 
+ * Following the skb_unshare() example, in case of error, the calling function
+ * doesn't have to worry about freeing the original skb.
+ */
+struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag)
+{
+	struct vlan_ethhdr *veth;
+
+	if (skb_headroom(skb) < VLAN_HLEN) {
+		struct sk_buff *sk_tmp = skb;
+		skb = skb_realloc_headroom(sk_tmp, VLAN_HLEN);
+		kfree_skb(sk_tmp);
+		if (!skb) {
+			printk(KERN_ERR "vlan: failed to realloc headroom\n");
+			return NULL;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb) {
+			printk(KERN_ERR "vlan: failed to unshare skbuff\n");
+			return NULL;
+		}
+	}
+
+	veth = (struct vlan_ethhdr *)skb_push(skb, VLAN_HLEN);
+
+	/* Move the mac addresses to the beginning of the new header. */
+	memmove(skb->data, skb->data + VLAN_HLEN, 2 * VLAN_ETH_ALEN);
+
+	/* first, the ethernet type */
+	veth->h_vlan_proto = __constant_htons(ETH_P_8021Q);
+
+	/* now, the tag */
+	veth->h_vlan_TCI = htons(tag);
+
+	skb->protocol = __constant_htons(ETH_P_8021Q);
+	skb->mac.raw -= VLAN_HLEN;
+	skb->nh.raw -= VLAN_HLEN;
+
+	return skb;
+}
+EXPORT_SYMBOL(__vlan_put_tag);
+
+#endif
diff -urpN linux-2.6.16.org/net/Makefile linux-2.6.16.vlan/net/Makefile
--- linux-2.6.16.org/net/Makefile	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/net/Makefile	Wed Apr 12 11:29:34 2006
@@ -41,7 +41,7 @@ obj-$(CONFIG_RXRPC)		+= rxrpc/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_DECNET)		+= decnet/
 obj-$(CONFIG_ECONET)		+= econet/
-obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
+obj-y				+= 8021q/
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
 obj-$(CONFIG_IEEE80211)		+= ieee80211/

--Boundary-00=_bCMPEP9MeIYy4G5--
