Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWDKHok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDKHok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDKHok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:44:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6102 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932329AbWDKHoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:44:38 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/3] deinline a few large functions in vlan code - v3
Date: Tue, 11 Apr 2006 10:44:05 +0300
User-Agent: KMail/1.8.2
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
References: <200604111043.13605.vda@ilport.com.ua>
In-Reply-To: <200604111043.13605.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F51OEt1LDa5UdgE"
Message-Id: <200604111044.05847.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_F51OEt1LDa5UdgE
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 April 2006 10:43, Denis Vlasenko wrote:
> These patches exclude VLAN code from netdevice drivers
> and from bonding module, and even remove vlan-related
> members of struct netdevice if VLAN is not configured.
> 
> Compile tested on allyesconfig kernel with CONFIG_8021Q=y,m,n.

This one takes care of drivers/net/bonding/bonding.[ch]
--
vda

--Boundary-00=_F51OEt1LDa5UdgE
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.6.16.vlan_inline5_bonding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.vlan_inline5_bonding.patch"

diff -urpN linux-2.6.16.org/drivers/net/bonding/bond_alb.c linux-2.6.16.vlan/drivers/net/bonding/bond_alb.c
--- linux-2.6.16.org/drivers/net/bonding/bond_alb.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bonding/bond_alb.c	Tue Apr 11 10:15:58 2006
@@ -502,6 +502,7 @@ static void rlb_update_client(struct rlb
 
 		skb->dev = client_info->slave->dev;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (client_info->tag) {
 			skb = vlan_put_tag(skb, client_info->vlan_id);
 			if (!skb) {
@@ -511,7 +512,7 @@ static void rlb_update_client(struct rlb
 				continue;
 			}
 		}
-
+#endif
 		arp_xmit(skb);
 	}
 }
@@ -671,6 +672,7 @@ static struct slave *rlb_choose_channel(
 			client_info->ntt = 0;
 		}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (!list_empty(&bond->vlan_list)) {
 			unsigned short vlan_id;
 			int res = vlan_get_tag(skb, &vlan_id);
@@ -679,6 +681,7 @@ static struct slave *rlb_choose_channel(
 				client_info->vlan_id = vlan_id;
 			}
 		}
+#endif
 
 		if (!client_info->assigned) {
 			u32 prev_tbl_head = bond_info->rx_hashtbl_head;
@@ -833,6 +836,7 @@ static void rlb_deinitialize(struct bond
 	_unlock_rx_hashtbl(bond);
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void rlb_clear_vlan(struct bonding *bond, unsigned short vlan_id)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
@@ -865,12 +869,15 @@ static void rlb_clear_vlan(struct bondin
 
 	_unlock_rx_hashtbl(bond);
 }
+#endif
 
 /*********************** tlb/rlb shared functions *********************/
 
 static void alb_send_learning_packets(struct slave *slave, u8 mac_addr[])
 {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct bonding *bond = bond_get_bond_by_slave(slave);
+#endif
 	struct learning_pkt pkt;
 	int size = sizeof(struct learning_pkt);
 	int i;
@@ -898,6 +905,7 @@ static void alb_send_learning_packets(st
 		skb->priority = TC_PRIO_CONTROL;
 		skb->dev = slave->dev;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (!list_empty(&bond->vlan_list)) {
 			struct vlan_entry *vlan;
 
@@ -918,7 +926,7 @@ static void alb_send_learning_packets(st
 				continue;
 			}
 		}
-
+#endif
 		dev_queue_xmit(skb);
 	}
 }
@@ -1665,6 +1673,7 @@ int bond_alb_set_mac_address(struct net_
 	return 0;
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 void bond_alb_clear_vlan(struct bonding *bond, unsigned short vlan_id)
 {
 	if (bond->alb_info.current_alb_vlan &&
@@ -1676,4 +1685,4 @@ void bond_alb_clear_vlan(struct bonding 
 		rlb_clear_vlan(bond, vlan_id);
 	}
 }
-
+#endif
diff -urpN linux-2.6.16.org/drivers/net/bonding/bond_main.c linux-2.6.16.vlan/drivers/net/bonding/bond_main.c
--- linux-2.6.16.org/drivers/net/bonding/bond_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bonding/bond_main.c	Tue Apr 11 10:15:58 2006
@@ -199,6 +199,7 @@ const char *bond_mode_name(int mode)
 	}
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 /*---------------------------------- VLAN -----------------------------------*/
 
 /**
@@ -349,6 +350,7 @@ struct vlan_entry *bond_next_vlan(struct
 
 	return next;
 }
+#endif
 
 /**
  * bond_dev_queue_xmit - Prepare skb for xmit.
@@ -366,6 +368,7 @@ struct vlan_entry *bond_next_vlan(struct
  */
 int bond_dev_queue_xmit(struct bonding *bond, struct sk_buff *skb, struct net_device *slave_dev)
 {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	unsigned short vlan_id;
 
 	if (!list_empty(&bond->vlan_list) &&
@@ -380,9 +383,9 @@ int bond_dev_queue_xmit(struct bonding *
 			 */
 			return 0;
 		}
-	} else {
+	} else
+#endif
 		skb->dev = slave_dev;
-	}
 
 	skb->priority = 1;
 	dev_queue_xmit(skb);
@@ -390,6 +393,7 @@ int bond_dev_queue_xmit(struct bonding *
 	return 0;
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 /*
  * In the following 3 functions, bond_vlan_rx_register(), bond_vlan_rx_add_vid
  * and bond_vlan_rx_kill_vid, We don't protect the slave list iteration with a
@@ -555,6 +559,7 @@ unreg:
 out:
 	write_unlock_bh(&bond->lock);
 }
+#endif /* defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE) */
 
 /*------------------------------- Link status -------------------------------*/
 
@@ -1215,6 +1220,7 @@ int bond_enslave(struct net_device *bond
 		return -EBUSY;
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	/* vlan challenged mutual exclusion */
 	/* no need to lock since we're protected by rtnl_lock */
 	if (slave_dev->features & NETIF_F_VLAN_CHALLENGED) {
@@ -1244,6 +1250,7 @@ int bond_enslave(struct net_device *bond
 			bond_dev->features &= ~NETIF_F_VLAN_CHALLENGED;
 		}
 	}
+#endif
 
 	/*
 	 * Old ifenslave binaries are no longer supported.  These can
@@ -1356,7 +1363,9 @@ int bond_enslave(struct net_device *bond
 		dev_mc_add(slave_dev, lacpdu_multicast, ETH_ALEN, 0);
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	bond_add_vlans_on_slave(bond, slave_dev);
+#endif
 
 	write_lock_bh(&bond->lock);
 
@@ -1667,6 +1676,7 @@ int bond_release(struct net_device *bond
 		 */
 		memset(bond_dev->dev_addr, 0, bond_dev->addr_len);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (list_empty(&bond->vlan_list)) {
 			bond_dev->features |= NETIF_F_VLAN_CHALLENGED;
 		} else {
@@ -1686,6 +1696,7 @@ int bond_release(struct net_device *bond
 		       "left bond %s. VLAN blocking is removed\n",
 		       bond_dev->name, slave_dev->name, bond_dev->name);
 		bond_dev->features &= ~NETIF_F_VLAN_CHALLENGED;
+#endif
 	}
 
 	write_unlock_bh(&bond->lock);
@@ -1693,7 +1704,9 @@ int bond_release(struct net_device *bond
 	/* must do this from outside any spinlocks */
 	bond_destroy_slave_symlinks(bond_dev, slave_dev);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	bond_del_vlans_from_slave(bond, slave_dev);
+#endif
 
 	/* If the mode USES_PRIMARY, then we should only remove its
 	 * promisc and mc settings if it was the curr_active_slave, but that was
@@ -1785,8 +1798,9 @@ static int bond_release_all(struct net_d
 		write_unlock_bh(&bond->lock);
 
 		bond_destroy_slave_symlinks(bond_dev, slave_dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		bond_del_vlans_from_slave(bond, slave_dev);
-
+#endif
 		/* If the mode USES_PRIMARY, then we should only remove its
 		 * promisc and mc settings if it was the curr_active_slave, but that was
 		 * already taken care of above when we detached the slave
@@ -1835,6 +1849,7 @@ static int bond_release_all(struct net_d
 	 */
 	memset(bond_dev->dev_addr, 0, bond_dev->addr_len);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (list_empty(&bond->vlan_list)) {
 		bond_dev->features |= NETIF_F_VLAN_CHALLENGED;
 	} else {
@@ -1847,6 +1862,7 @@ static int bond_release_all(struct net_d
 		       "HW address matches its VLANs'.\n",
 		       bond_dev->name);
 	}
+#endif
 
 	printk(KERN_INFO DRV_NAME
 	       ": %s: released all slaves\n",
@@ -2234,11 +2250,14 @@ out:
 
 static int bond_has_ip(struct bonding *bond)
 {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_entry *vlan, *vlan_next;
+#endif
 
 	if (bond->master_ip)
 		return 1;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (list_empty(&bond->vlan_list))
 		return 0;
 
@@ -2247,6 +2266,7 @@ static int bond_has_ip(struct bonding *b
 		if (vlan->vlan_ip)
 			return 1;
 	}
+#endif
 
 	return 0;
 }
@@ -2270,6 +2290,7 @@ static void bond_arp_send(struct net_dev
 		printk(KERN_ERR DRV_NAME ": ARP packet allocation failed\n");
 		return;
 	}
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (vlan_id) {
 		skb = vlan_put_tag(skb, vlan_id);
 		if (!skb) {
@@ -2277,30 +2298,38 @@ static void bond_arp_send(struct net_dev
 			return;
 		}
 	}
+#endif
 	arp_xmit(skb);
 }
 
 
 static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
-	int i, vlan_id, rv;
+	int i;
 	u32 *targets = bond->params.arp_targets;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	int vlan_id, rv;
 	struct vlan_entry *vlan, *vlan_next;
 	struct net_device *vlan_dev;
 	struct flowi fl;
 	struct rtable *rt;
+#endif
 
 	for (i = 0; (i < BOND_MAX_ARP_TARGETS); i++) {
 		if (!targets[i])
 			continue;
 		dprintk("basa: target %x\n", targets[i]);
-		if (list_empty(&bond->vlan_list)) {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+		if (list_empty(&bond->vlan_list))
+#endif
+		{
 			dprintk("basa: empty vlan: arp_send\n");
 			bond_arp_send(slave->dev, ARPOP_REQUEST, targets[i],
 				      bond->master_ip, 0);
 			continue;
 		}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		/*
 		 * If VLANs are configured, we do a route lookup to
 		 * determine which VLAN interface would be used, so we
@@ -2357,6 +2386,7 @@ static void bond_arp_send_all(struct bon
 			       rt->u.dst.dev ? rt->u.dst.dev->name : "NULL");
 		}
 		ip_rt_put(rt);
+#endif
 	}
 }
 
@@ -2367,9 +2397,10 @@ static void bond_arp_send_all(struct bon
 static void bond_send_gratuitous_arp(struct bonding *bond)
 {
 	struct slave *slave = bond->curr_active_slave;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_entry *vlan;
 	struct net_device *vlan_dev;
-
+#endif
 	dprintk("bond_send_grat_arp: bond %s slave %s\n", bond->dev->name,
 				slave ? slave->dev->name : "NULL");
 	if (!slave)
@@ -2380,6 +2411,7 @@ static void bond_send_gratuitous_arp(str
 				  bond->master_ip, 0);
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	list_for_each_entry(vlan, &bond->vlan_list, vlan_list) {
 		vlan_dev = bond->vlgrp->vlan_devices[vlan->vlan_id];
 		if (vlan->vlan_ip) {
@@ -2387,6 +2419,7 @@ static void bond_send_gratuitous_arp(str
 				      vlan->vlan_ip, vlan->vlan_id);
 		}
 	}
+#endif
 }
 
 /*
@@ -3197,9 +3230,12 @@ static int bond_netdev_event(struct noti
 static int bond_inetaddr_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct in_ifaddr *ifa = ptr;
-	struct net_device *vlan_dev, *event_dev = ifa->ifa_dev->dev;
+	struct net_device *event_dev = ifa->ifa_dev->dev;
 	struct bonding *bond, *bond_next;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_entry *vlan, *vlan_next;
+	struct net_device *vlan_dev;
+#endif
 
 	list_for_each_entry_safe(bond, bond_next, &bond_dev_list, bond_list) {
 		if (bond->dev == event_dev) {
@@ -3215,6 +3251,7 @@ static int bond_inetaddr_event(struct no
 			}
 		}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (list_empty(&bond->vlan_list))
 			continue;
 
@@ -3235,6 +3272,7 @@ static int bond_inetaddr_event(struct no
 				}
 			}
 		}
+#endif
 	}
 	return NOTIFY_DONE;
 }
@@ -4120,7 +4158,9 @@ static int bond_init(struct net_device *
 	bond->current_arp_slave = NULL;
 	bond->primary_slave = NULL;
 	bond->dev = bond_dev;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	INIT_LIST_HEAD(&bond->vlan_list);
+#endif
 
 	/* Initialize the device entry points */
 	bond_dev->open = bond_open;
@@ -4151,6 +4191,7 @@ static int bond_init(struct net_device *
 	 * transmitting */
 	bond_dev->features |= NETIF_F_LLTX;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	/* By default, we declare the bond to be fully
 	 * VLAN hardware accelerated capable. Special
 	 * care is taken in the various xmit functions
@@ -4163,6 +4204,7 @@ static int bond_init(struct net_device *
 	bond_dev->features |= (NETIF_F_HW_VLAN_TX |
 			       NETIF_F_HW_VLAN_RX |
 			       NETIF_F_HW_VLAN_FILTER);
+#endif
 
 #ifdef CONFIG_PROC_FS
 	bond_create_proc_entry(bond);
diff -urpN linux-2.6.16.org/drivers/net/bonding/bonding.h linux-2.6.16.vlan/drivers/net/bonding/bonding.h
--- linux-2.6.16.org/drivers/net/bonding/bonding.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bonding/bonding.h	Tue Apr 11 10:15:58 2006
@@ -196,8 +196,10 @@ struct bonding {
 	struct   ad_bond_info ad_info;
 	struct   alb_bond_info alb_info;
 	struct   bond_params params;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct   list_head vlan_list;
 	struct   vlan_group *vlgrp;
+#endif
 };
 
 /**

--Boundary-00=_F51OEt1LDa5UdgE--
