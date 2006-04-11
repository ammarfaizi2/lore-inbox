Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWDKHnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWDKHnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDKHnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:43:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5078 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932323AbWDKHnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:43:49 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH 1/3] deinline a few large functions in vlan code - v3
Date: Tue, 11 Apr 2006 10:43:13 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R41OExOQIOf27ad"
Message-Id: <200604111043.13605.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_R41OExOQIOf27ad
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

After davem and Dave Dillow comments I realized that
a lot of drivers try to do VLAN-related things even on
non-VLAN-enabled kernels.

These patches exclude VLAN code from netdevice drivers
and from bonding module, and even remove vlan-related
members of struct netdevice if VLAN is not configured.

Compile tested on allyesconfig kernel with CONFIG_8021Q=y,m,n.

Below is a patch which takes care of drivers/net/*.

Please comment.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_R41OExOQIOf27ad
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.16.vlan_inline5_drivers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.vlan_inline5_drivers.patch"

diff -urpN linux-2.6.16.org/drivers/net/bnx2.c linux-2.6.16.vlan/drivers/net/bnx2.c
--- linux-2.6.16.org/drivers/net/bnx2.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/bnx2.c	Tue Apr 11 10:15:58 2006
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
+++ linux-2.6.16.vlan/drivers/net/bnx2.h	Tue Apr 11 10:15:58 2006
@@ -40,7 +40,9 @@
 #include <linux/mii.h>
 #ifdef NETIF_F_HW_VLAN_TX
 #include <linux/if_vlan.h>
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 #define BCM_VLAN 1
+#endif
 #endif
 #ifdef NETIF_F_TSO
 #include <net/ip.h>
diff -urpN linux-2.6.16.org/drivers/net/chelsio/sge.c linux-2.6.16.vlan/drivers/net/chelsio/sge.c
--- linux-2.6.16.org/drivers/net/chelsio/sge.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/chelsio/sge.c	Tue Apr 11 10:15:58 2006
@@ -978,6 +978,7 @@ static int sge_rx(struct sge *sge, struc
 	} else
 		skb->ip_summed = CHECKSUM_NONE;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (unlikely(adapter->vlan_grp && p->vlan_valid)) {
 		sge->port_stats[p->iff].vlan_xtract++;
 		if (adapter->params.sge.polling)
@@ -986,7 +987,9 @@ static int sge_rx(struct sge *sge, struc
 		else
 			vlan_hwaccel_rx(skb, adapter->vlan_grp,
 					ntohs(p->vlan));
-	} else if (adapter->params.sge.polling)
+	} else
+#endif
+	if (adapter->params.sge.polling)
 		netif_receive_skb(skb);
 	else
 		netif_rx(skb);
diff -urpN linux-2.6.16.org/drivers/net/e1000/e1000.h linux-2.6.16.vlan/drivers/net/e1000/e1000.h
--- linux-2.6.16.org/drivers/net/e1000/e1000.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/e1000/e1000.h	Tue Apr 11 10:15:58 2006
@@ -254,8 +254,10 @@ struct e1000_adapter {
 	struct timer_list tx_fifo_stall_timer;
 	struct timer_list watchdog_timer;
 	struct timer_list phy_info_timer;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_group *vlgrp;
     	uint16_t mng_vlan_id;
+#endif
 	uint32_t bd_number;
 	uint32_t rx_buffer_len;
 	uint32_t part_num;
diff -urpN linux-2.6.16.org/drivers/net/e1000/e1000_main.c linux-2.6.16.vlan/drivers/net/e1000/e1000_main.c
--- linux-2.6.16.org/drivers/net/e1000/e1000_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/e1000/e1000_main.c	Tue Apr 11 10:15:59 2006
@@ -250,10 +250,12 @@ static void e1000_smartspeed(struct e100
 static inline int e1000_82547_fifo_workaround(struct e1000_adapter *adapter,
 					      struct sk_buff *skb);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void e1000_vlan_rx_register(struct net_device *netdev, struct vlan_group *grp);
 static void e1000_vlan_rx_add_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
+#endif
 
 #ifdef CONFIG_PM
 static int e1000_suspend(struct pci_dev *pdev, pm_message_t state);
@@ -361,6 +363,7 @@ e1000_irq_enable(struct e1000_adapter *a
 	}
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void
 e1000_update_mng_vlan(struct e1000_adapter *adapter)
 {
@@ -383,6 +386,7 @@ e1000_update_mng_vlan(struct e1000_adapt
 		}
 	}
 }
+#endif
 
 /**
  * e1000_release_hw_control - release control of the h/w to f/w
@@ -470,7 +474,9 @@ e1000_up(struct e1000_adapter *adapter)
 
 	e1000_set_multi(netdev);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	e1000_restore_vlan(adapter);
+#endif
 
 	e1000_configure_tx(adapter);
 	e1000_setup_rctl(adapter);
@@ -629,9 +635,12 @@ e1000_reset(struct e1000_adapter *adapte
 		E1000_WRITE_REG(&adapter->hw, WUC, 0);
 	if (e1000_init_hw(&adapter->hw))
 		DPRINTK(PROBE, ERR, "Hardware Error\n");
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	e1000_update_mng_vlan(adapter);
 	/* Enable h/w to recognize an 802.1Q VLAN Ethernet packet */
 	E1000_WRITE_REG(&adapter->hw, VET, ETHERNET_IEEE_VLAN_TYPE);
+#endif
 
 	e1000_reset_adaptive(&adapter->hw);
 	e1000_phy_get_info(&adapter->hw, &adapter->phy_info);
@@ -733,9 +742,11 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->poll = &e1000_clean;
 	netdev->weight = 64;
 #endif
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	netdev->vlan_rx_register = e1000_vlan_rx_register;
 	netdev->vlan_rx_add_vid = e1000_vlan_rx_add_vid;
 	netdev->vlan_rx_kill_vid = e1000_vlan_rx_kill_vid;
+#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	netdev->poll_controller = e1000_netpoll;
 #endif
@@ -1228,11 +1239,14 @@ e1000_open(struct net_device *netdev)
 
 	if ((err = e1000_up(adapter)))
 		goto err_up;
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
 	if ((adapter->hw.mng_cookie.status &
 			  E1000_MNG_DHCP_COOKIE_STATUS_VLAN_SUPPORT)) {
 		e1000_update_mng_vlan(adapter);
 	}
+#endif
 
 	/* If AMT is enabled, let the firmware know that the network
 	 * interface is now open */
@@ -1274,10 +1288,12 @@ e1000_close(struct net_device *netdev)
 	e1000_free_all_tx_resources(adapter);
 	e1000_free_all_rx_resources(adapter);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if ((adapter->hw.mng_cookie.status &
 			  E1000_MNG_DHCP_COOKIE_STATUS_VLAN_SUPPORT)) {
 		e1000_vlan_rx_kill_vid(netdev, adapter->mng_vlan_id);
 	}
+#endif
 
 	/* If AMT is enabled, let the firmware know that the network
 	 * interface is now closed */
@@ -2397,8 +2413,10 @@ e1000_watchdog_task(struct e1000_adapter
 	e1000_check_for_link(&adapter->hw);
 	if (adapter->hw.mac_type == e1000_82573) {
 		e1000_enable_tx_pkt_filtering(&adapter->hw);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (adapter->mng_vlan_id != adapter->hw.mng_cookie.vlan_id)
 			e1000_update_mng_vlan(adapter);
+#endif
 	}
 
 	if ((adapter->hw.media_type == e1000_media_type_internal_serdes) &&
@@ -2985,10 +3003,12 @@ e1000_xmit_frame(struct sk_buff *skb, st
 		}
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (unlikely(adapter->vlgrp && vlan_tx_tag_present(skb))) {
 		tx_flags |= E1000_TX_FLAGS_VLAN;
 		tx_flags |= (vlan_tx_tag_get(skb) << E1000_TX_FLAGS_VLAN_SHIFT);
 	}
+#endif
 
 	first = tx_ring->next_to_use;
 
@@ -3714,23 +3734,25 @@ e1000_clean_rx_irq(struct e1000_adapter 
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_E1000_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp &&
 			    (status & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 						 le16_to_cpu(rx_desc->special) &
 						 E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_receive_skb(skb);
-		}
 #else /* CONFIG_E1000_NAPI */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp &&
 			    (status & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 					le16_to_cpu(rx_desc->special) &
 					E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_rx(skb);
-		}
 #endif /* CONFIG_E1000_NAPI */
 		netdev->last_rx = jiffies;
 #ifdef CONFIG_E1000_MQ
@@ -3861,21 +3883,23 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 			   cpu_to_le16(E1000_RXDPS_HDRSTAT_HDRSP)))
 			adapter->rx_hdr_split++;
 #ifdef CONFIG_E1000_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->wb.middle.vlan) &
 				E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_receive_skb(skb);
-		}
 #else /* CONFIG_E1000_NAPI */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->wb.middle.vlan) &
 				E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_rx(skb);
-		}
 #endif /* CONFIG_E1000_NAPI */
 		netdev->last_rx = jiffies;
 #ifdef CONFIG_E1000_MQ
@@ -4351,6 +4375,7 @@ e1000_io_write(struct e1000_hw *hw, unsi
 	outl(value, port);
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void
 e1000_vlan_rx_register(struct net_device *netdev, struct vlan_group *grp)
 {
@@ -4382,10 +4407,12 @@ e1000_vlan_rx_register(struct net_device
 		rctl = E1000_READ_REG(&adapter->hw, RCTL);
 		rctl &= ~E1000_RCTL_VFE;
 		E1000_WRITE_REG(&adapter->hw, RCTL, rctl);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (adapter->mng_vlan_id != (uint16_t)E1000_MNG_VLAN_NONE) {
 			e1000_vlan_rx_kill_vid(netdev, adapter->mng_vlan_id);
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
 		}
+#endif
 	}
 
 	e1000_irq_enable(adapter);
@@ -4450,6 +4477,7 @@ e1000_restore_vlan(struct e1000_adapter 
 		}
 	}
 }
+#endif
 
 int
 e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx)
diff -urpN linux-2.6.16.org/drivers/net/gianfar.c linux-2.6.16.vlan/drivers/net/gianfar.c
--- linux-2.6.16.org/drivers/net/gianfar.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/gianfar.c	Tue Apr 11 10:15:59 2006
@@ -270,6 +270,7 @@ static int gfar_probe(struct platform_de
 	} else
 		priv->rx_csum_enable = 0;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	priv->vlgrp = NULL;
 
 	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_VLAN) {
@@ -280,6 +281,7 @@ static int gfar_probe(struct platform_de
 
 		priv->vlan_enable = 1;
 	}
+#endif
 
 	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_EXTENDED_HASH) {
 		priv->extended_hash = 1;
@@ -792,8 +794,10 @@ int startup_gfar(struct net_device *dev)
 		rctrl |= RCTRL_EMEN;
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (priv->vlan_enable)
 		rctrl |= RCTRL_VLAN;
+#endif
 
 	if (priv->padding) {
 		rctrl &= ~RCTRL_PAL_MASK;
@@ -945,6 +949,7 @@ static int gfar_start_xmit(struct sk_buf
 		gfar_tx_checksum(skb, fcb);
 	}
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (priv->vlan_enable &&
 			unlikely(priv->vlgrp && vlan_tx_tag_present(skb))) {
 		if (unlikely(NULL == fcb)) {
@@ -954,6 +959,7 @@ static int gfar_start_xmit(struct sk_buf
 
 		gfar_tx_vlan(skb, fcb);
 	}
+#endif
 
 	/* Set buffer length and pointer */
 	txbdp->length = skb->len;
@@ -1037,6 +1043,7 @@ int gfar_set_mac_address(struct net_devi
 }
 
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 /* Enables and disables VLAN insertion/extraction */
 static void gfar_vlan_rx_register(struct net_device *dev,
 		struct vlan_group *grp)
@@ -1074,8 +1081,10 @@ static void gfar_vlan_rx_register(struct
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
+#endif
 
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void gfar_vlan_rx_kill_vid(struct net_device *dev, uint16_t vid)
 {
 	struct gfar_private *priv = netdev_priv(dev);
@@ -1088,6 +1097,7 @@ static void gfar_vlan_rx_kill_vid(struct
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
+#endif
 
 
 static int gfar_change_mtu(struct net_device *dev, int new_mtu)
@@ -1097,8 +1107,10 @@ static int gfar_change_mtu(struct net_de
 	int oldsize = priv->rx_buffer_size;
 	int frame_size = new_mtu + ETH_HLEN;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (priv->vlan_enable)
 		frame_size += VLAN_ETH_HLEN;
+#endif
 
 	if (gfar_uses_fcb(priv))
 		frame_size += GMAC_FCB_LEN;
@@ -1343,6 +1355,7 @@ irqreturn_t gfar_receive(int irq, void *
 	return IRQ_HANDLED;
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static inline int gfar_rx_vlan(struct sk_buff *skb,
 		struct vlan_group *vlgrp, unsigned short vlctl)
 {
@@ -1352,6 +1365,7 @@ static inline int gfar_rx_vlan(struct sk
 	return vlan_hwaccel_rx(skb, vlgrp, vlctl);
 #endif
 }
+#endif
 
 static inline void gfar_rx_checksum(struct sk_buff *skb, struct rxfcb *fcb)
 {
@@ -1409,9 +1423,11 @@ static int gfar_process_frame(struct net
 		skb->protocol = eth_type_trans(skb, dev);
 
 		/* Send the packet up the stack */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(priv->vlgrp && (fcb->flags & RXFCB_VLN)))
 			ret = gfar_rx_vlan(skb, priv->vlgrp, fcb->vlctl);
 		else
+#endif
 			ret = RECEIVE(skb);
 
 		if (NET_RX_DROP == ret)
diff -urpN linux-2.6.16.org/drivers/net/gianfar.h linux-2.6.16.vlan/drivers/net/gianfar.h
--- linux-2.6.16.org/drivers/net/gianfar.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/gianfar.h	Tue Apr 11 10:15:59 2006
@@ -702,7 +702,9 @@ struct gfar_private {
 		extended_hash:1,
 		bd_stash_en:1;
 	unsigned short padding;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_group *vlgrp;
+#endif
 	/* Info structure initialized by board setup code */
 	unsigned int interruptTransmit;
 	unsigned int interruptReceive;
diff -urpN linux-2.6.16.org/drivers/net/ixgb/ixgb.h linux-2.6.16.vlan/drivers/net/ixgb/ixgb.h
--- linux-2.6.16.org/drivers/net/ixgb/ixgb.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/ixgb/ixgb.h	Tue Apr 11 10:15:59 2006
@@ -155,7 +155,9 @@ struct ixgb_desc_ring {
 
 struct ixgb_adapter {
 	struct timer_list watchdog_timer;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_group *vlgrp;
+#endif
 	uint32_t bd_number;
 	uint32_t rx_buffer_len;
 	uint32_t part_num;
diff -urpN linux-2.6.16.org/drivers/net/ixgb/ixgb_main.c linux-2.6.16.vlan/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.16.org/drivers/net/ixgb/ixgb_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/ixgb/ixgb_main.c	Tue Apr 11 10:15:59 2006
@@ -121,11 +121,13 @@ static void ixgb_alloc_rx_buffers(struct
 void ixgb_set_ethtool_ops(struct net_device *netdev);
 static void ixgb_tx_timeout(struct net_device *dev);
 static void ixgb_tx_timeout_task(struct net_device *dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void ixgb_vlan_rx_register(struct net_device *netdev,
 				  struct vlan_group *grp);
 static void ixgb_vlan_rx_add_vid(struct net_device *netdev, uint16_t vid);
 static void ixgb_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void ixgb_restore_vlan(struct ixgb_adapter *adapter);
+#endif
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /* for netdump / net console */
@@ -233,7 +235,9 @@ ixgb_up(struct ixgb_adapter *adapter)
 
 	ixgb_set_multi(netdev);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	ixgb_restore_vlan(adapter);
+#endif
 
 	ixgb_configure_tx(adapter);
 	ixgb_setup_rctl(adapter);
@@ -419,9 +423,11 @@ ixgb_probe(struct pci_dev *pdev,
 	netdev->poll = &ixgb_clean;
 	netdev->weight = 64;
 #endif
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	netdev->vlan_rx_register = ixgb_vlan_rx_register;
 	netdev->vlan_rx_add_vid = ixgb_vlan_rx_add_vid;
 	netdev->vlan_rx_kill_vid = ixgb_vlan_rx_kill_vid;
+#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	netdev->poll_controller = ixgb_netpoll;
 #endif
@@ -1398,10 +1404,12 @@ ixgb_xmit_frame(struct sk_buff *skb, str
 	}
 	spin_unlock_irqrestore(&adapter->tx_lock, flags);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if(adapter->vlgrp && vlan_tx_tag_present(skb)) {
 		tx_flags |= IXGB_TX_FLAGS_VLAN;
 		vlan_id = vlan_tx_tag_get(skb);
 	}
+#endif
 
 	first = adapter->tx_ring.next_to_use;
 	
@@ -1905,21 +1913,23 @@ ixgb_clean_rx_irq(struct ixgb_adapter *a
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_IXGB_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if(adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->special) &
 					IXGB_RX_DESC_SPECIAL_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_receive_skb(skb);
-		}
 #else /* CONFIG_IXGB_NAPI */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if(adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->special) &
 					IXGB_RX_DESC_SPECIAL_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_rx(skb);
-		}
 #endif /* CONFIG_IXGB_NAPI */
 		netdev->last_rx = jiffies;
 
@@ -2014,6 +2024,7 @@ ixgb_alloc_rx_buffers(struct ixgb_adapte
 	rx_ring->next_to_use = i;
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 /**
  * ixgb_vlan_rx_register - enables or disables vlan tagging/stripping.
  * 
@@ -2107,6 +2118,7 @@ ixgb_restore_vlan(struct ixgb_adapter *a
 		}
 	}
 }
+#endif /* defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE) */
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /*
diff -urpN linux-2.6.16.org/drivers/net/s2io.c linux-2.6.16.vlan/drivers/net/s2io.c
--- linux-2.6.16.org/drivers/net/s2io.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/s2io.c	Tue Apr 11 10:15:59 2006
@@ -182,6 +182,7 @@ static char ethtool_stats_keys[][ETH_GST
 			timer.data = (unsigned long) arg;	\
 			mod_timer(&timer, (jiffies + exp))	\
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
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
@@ -3469,8 +3471,10 @@ static int s2io_xmit(struct sk_buff *skb
 #ifdef NETIF_F_TSO
 	int mss;
 #endif
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	u16 vlan_tag = 0;
 	int vlan_priority = 0;
+#endif
 	mac_info_t *mac_control;
 	struct config_param *config;
 
@@ -3489,12 +3493,14 @@ static int s2io_xmit(struct sk_buff *skb
 
 	queue = 0;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	/* Get Fifo number to Transmit based on vlan priority */
 	if (sp->vlgrp && vlan_tx_tag_present(skb)) {
 		vlan_tag = vlan_tx_tag_get(skb);
 		vlan_priority = vlan_tag >> 13;
 		queue = config->fifo_mapping[vlan_priority];
 	}
+#endif
 
 	put_off = (u16) mac_control->fifos[queue].tx_curr_put_info.offset;
 	get_off = (u16) mac_control->fifos[queue].tx_curr_get_info.offset;
@@ -3537,10 +3543,12 @@ static int s2io_xmit(struct sk_buff *skb
 	txdp->Control_1 |= TXD_LIST_OWN_XENA;
 	txdp->Control_2 |= config->tx_intr_type;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (sp->vlgrp && vlan_tx_tag_present(skb)) {
 		txdp->Control_2 |= TXD_VLAN_ENABLE;
 		txdp->Control_2 |= TXD_VLAN_TAG(vlan_tag);
 	}
+#endif
 
 	frg_len = skb->len - skb->data_len;
 	if (skb_shinfo(skb)->ufo_size) {
@@ -5680,21 +5688,23 @@ static int rx_osm_handler(ring_info_t *r
 
 	skb->protocol = eth_type_trans(skb, dev);
 #ifdef CONFIG_S2IO_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
 		/* Queueing the vlan frame to the upper layer */
 		vlan_hwaccel_receive_skb(skb, sp->vlgrp,
 			RXD_GET_VLAN_TAG(rxdp->Control_2));
-	} else {
+	} else
+#endif
 		netif_receive_skb(skb);
-	}
 #else
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
 		/* Queueing the vlan frame to the upper layer */
 		vlan_hwaccel_rx(skb, sp->vlgrp,
 			RXD_GET_VLAN_TAG(rxdp->Control_2));
-	} else {
+	} else
+#endif
 		netif_rx(skb);
-	}
 #endif
 	dev->last_rx = jiffies;
 	atomic_dec(&sp->rx_bufs_left[ring_no]);
@@ -6051,9 +6061,11 @@ Defaulting to INTA\n");
 	dev->do_ioctl = &s2io_ioctl;
 	dev->change_mtu = &s2io_change_mtu;
 	SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
 	dev->vlan_rx_register = s2io_vlan_rx_register;
 	dev->vlan_rx_kill_vid = (void *)s2io_vlan_rx_kill_vid;
+#endif
 
 	/*
 	 * will use eth_mac_addr() for  dev->set_mac_address
diff -urpN linux-2.6.16.org/drivers/net/s2io.h linux-2.6.16.vlan/drivers/net/s2io.h
--- linux-2.6.16.org/drivers/net/s2io.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/drivers/net/s2io.h	Tue Apr 11 10:15:59 2006
@@ -771,7 +771,9 @@ struct s2io_nic {
 #define CARD_UP 2
 	atomic_t card_state;
 	volatile unsigned long link_state;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_group *vlgrp;
+#endif
 #define MSIX_FLG                0xA5
 	struct msix_entry *entries;
 	struct s2io_msix_entry *s2io_entries;
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

--Boundary-00=_R41OExOQIOf27ad--
