Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUKIAJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUKIAJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKIAJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:09:34 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44165 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261315AbUKIAEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:04:07 -0500
Date: Tue, 9 Nov 2004 01:00:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: seby@focomunicatii.ro
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, alan@redhat.com,
       jgarzik@pobox.com
Subject: Re: ZyXEL GN650-T
Message-ID: <20041109000006.GA14911@electric-eye.fr.zoreil.com>
References: <20041107214427.20301.qmail@focomunicatii.ro> <20041107224803.GA29248@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107224803.GA29248@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seby@focomunicatii.ro <seby@focomunicatii.ro> :
[...]
> I just bouth a zyxel GN650T network card .. and it sems that vlan's don't 
> work on this card .. anybody had this problems with this card .. 

Patch below against 2.6.10-rc1-bk15 + Jeff's netdev should convert the driver
to the in-kernel vlan API.

I'd be surprized it does from the first try though.

Please keep netdev CCed.

diff -puN drivers/net/via-velocity.c~via-velocity-300 drivers/net/via-velocity.c
--- linux-2.6.10-rc1/drivers/net/via-velocity.c~via-velocity-300	2004-11-08 00:59:23.000000000 +0100
+++ linux-2.6.10-rc1-fr/drivers/net/via-velocity.c	2004-11-09 00:56:08.000000000 +0100
@@ -73,6 +73,7 @@
 #include <linux/reboot.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/if_vlan.h>
 #include <linux/in.h>
 #include <linux/if_arp.h>
 #include <linux/ip.h>
@@ -114,15 +115,6 @@ VELOCITY_PARAM(RxDescriptors, "Number of
 #define TX_DESC_DEF     64
 VELOCITY_PARAM(TxDescriptors, "Number of transmit descriptors");
 
-#define VLAN_ID_MIN     0
-#define VLAN_ID_MAX     4095
-#define VLAN_ID_DEF     0
-/* VID_setting[] is used for setting the VID of NIC.
-   0: default VID.
-   1-4094: other VIDs.
-*/
-VELOCITY_PARAM(VID_setting, "802.1Q VLAN ID");
-
 #define RX_THRESH_MIN   0
 #define RX_THRESH_MAX   3
 #define RX_THRESH_DEF   0
@@ -150,13 +142,6 @@ VELOCITY_PARAM(rx_thresh, "Receive fifo 
 */
 VELOCITY_PARAM(DMA_length, "DMA length");
 
-#define TAGGING_DEF     0
-/* enable_tagging[] is used for enabling 802.1Q VID tagging.
-   0: disable VID seeting(default).
-   1: enable VID setting.
-*/
-VELOCITY_PARAM(enable_tagging, "Enable 802.1Q tagging");
-
 #define IP_ALIG_DEF     0
 /* IP_byte_align[] is used for IP header DWORD byte aligned
    0: indicate the IP header won't be DWORD byte aligned.(Default) .
@@ -275,6 +260,130 @@ static struct notifier_block velocity_in
 static spinlock_t velocity_dev_list_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(velocity_dev_list);
 
+#ifdef CONFIG_VIA_VELOCITY_VLAN
+
+static inline u16 velocity_tx_vlan_tag(struct velocity_info *vptr,
+				       struct sk_buff *skb)
+{
+	return (vptr->vlgrp && vlan_tx_tag_present(skb)) ?
+		vlan_tx_tag_get(skb) : 0x00;
+}
+
+static void velocity_vlan_rx_register(struct net_device *dev,
+				      struct vlan_group *grp)
+{
+	struct velocity_info *vptr = netdev_priv(dev);
+	struct mac_regs __iomem *regs = vptr->mac_regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vptr->lock, flags);
+	vptr->vlgrp = grp;
+	if (vptr->vlgrp)
+		WORD_REG_BITS_ON(MCFG_RTGOPT, &regs->MCFG);
+	else
+		WORD_REG_BITS_OFF(MCFG_RTGOPT, &regs->MCFG);
+	spin_unlock_irqrestore(&vptr->lock, flags);
+}
+
+static void velocity_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
+{
+	struct velocity_info *vptr = netdev_priv(dev);
+	struct mac_regs __iomem *regs = vptr->mac_regs;
+	unsigned long flags;
+	u16 slot;
+
+	spin_lock_irqsave(&vptr->lock, flags);
+
+	for (slot = 0; slot < VCAM_SIZE; slot++) {
+		u8 bit = vptr->mCAMmask[slot / 8] & (1 << (slot & 7));
+
+		if (!bit)
+			break;
+	}
+
+	if (slot == VCAM_SIZE) {
+		printk(KERN_ERR "%s: no free hardware filter for VLAN %04d\n",
+		       dev->name, vid);
+		goto out_unlock;
+	}
+
+	vptr->mCAMmask[slot / 8] |= 1 << (slot & 7);
+
+	mac_set_cam(regs, slot, (u8 *) &vid, VELOCITY_VLAN_ID_CAM);
+	mac_set_cam_mask(regs, vptr->vCAMmask, VELOCITY_VLAN_ID_CAM);
+
+out_unlock:
+	spin_unlock_irqrestore(&vptr->lock, flags);
+}
+
+static void velocity_vlan_rx_kill_vid(struct net_device *dev,
+				      unsigned short vid)
+{
+	struct velocity_info *vptr = netdev_priv(dev);
+	struct mac_regs __iomem *regs = vptr->mac_regs;
+	unsigned long flags;
+	u16 slot, hw_vid;
+
+	spin_lock_irqsave(&vptr->lock, flags);
+	if (!vptr->vlgrp)
+		goto out_unlock;
+
+	vptr->vlgrp->vlan_devices[vid] = NULL;
+
+	for (slot = 0; slot < VCAM_SIZE; slot++) {
+		u8 bit = vptr->mCAMmask[slot / 8] & (1 << (slot & 7));
+
+		if (!bit)
+			continue;
+		mac_get_cam(regs, slot, (u8 *) &hw_vid, VELOCITY_VLAN_ID_CAM);
+		if (hw_vid == vid)
+			break;
+	}
+
+	if (slot == VCAM_SIZE) {
+		printk(KERN_ERR "%s: no hardware filter found for VLAN %04d\n",
+		       dev->name, vid);
+		goto out_unlock;
+	}
+
+	vptr->mCAMmask[slot / 8] &= ~(1 << (slot & 7));
+	mac_set_cam_mask(regs, vptr->vCAMmask, VELOCITY_VLAN_ID_CAM);
+	
+out_unlock:
+	spin_unlock_irqrestore(&vptr->lock, flags);
+}
+
+static int velocity_rx_vlan_skb(struct velocity_info *vptr, struct rx_desc *rd,
+				struct sk_buff *skb)
+{
+	int ret;
+
+	if (vptr->vlgrp && (rd->rdesc0.RSR & RSR_VTAG)) {
+		u16 vlan_tag = rd->rdesc1.u.pqinf.VID;
+
+		/* FIXME: should be NAPI dependant */
+		vlan_hwaccel_receive_skb(skb, vptr->vlgrp, vlan_tag);
+		ret = 0;
+	} else
+		ret = -1;
+	return ret;
+}
+
+#else
+
+static inline u16 velocity_tx_vlan_tag(struct velocity_info *vptr,
+				       struct sk_buff *skb)
+{
+	return 0;
+}
+
+static int velocity_rx_vlan_skb(struct velocity_info *vptr, struct sk_buff *skb)
+{
+	return -1;
+}
+
+#endif
+
 static void velocity_register_notifier(void)
 {
 	register_inetaddr_notifier(&velocity_inetaddr_notifier);
@@ -440,8 +549,6 @@ static void __devinit velocity_get_optio
 	velocity_set_int_opt(&opts->DMA_length, DMA_length[index], DMA_LENGTH_MIN, DMA_LENGTH_MAX, DMA_LENGTH_DEF, "DMA_length", devname);
 	velocity_set_int_opt(&opts->numrx, RxDescriptors[index], RX_DESC_MIN, RX_DESC_MAX, RX_DESC_DEF, "RxDescriptors", devname);
 	velocity_set_int_opt(&opts->numtx, TxDescriptors[index], TX_DESC_MIN, TX_DESC_MAX, TX_DESC_DEF, "TxDescriptors", devname);
-	velocity_set_int_opt(&opts->vid, VID_setting[index], VLAN_ID_MIN, VLAN_ID_MAX, VLAN_ID_DEF, "VID_setting", devname);
-	velocity_set_bool_opt(&opts->flags, enable_tagging[index], TAGGING_DEF, VELOCITY_FLAGS_TAGGING, "enable_tagging", devname);
 	velocity_set_bool_opt(&opts->flags, txcsum_offload[index], TX_CSUM_DEF, VELOCITY_FLAGS_TX_CSUM, "txcsum_offload", devname);
 	velocity_set_int_opt(&opts->flow_cntl, flow_control[index], FLOW_CNTL_MIN, FLOW_CNTL_MAX, FLOW_CNTL_DEF, "flow_control", devname);
 	velocity_set_bool_opt(&opts->flags, IP_byte_align[index], IP_ALIG_DEF, VELOCITY_FLAGS_IP_ALIGN, "IP_byte_align", devname);
@@ -463,6 +570,7 @@ static void __devinit velocity_get_optio
 static void velocity_init_cam_filter(struct velocity_info *vptr)
 {
 	struct mac_regs __iomem * regs = vptr->mac_regs;
+	u16 temp = 0;
 
 	/* Turn on MCFG_PQEN, turn off MCFG_RTGOPT */
 	WORD_REG_BITS_SET(MCFG_PQEN, MCFG_RTGOPT, &regs->MCFG);
@@ -475,21 +583,9 @@ static void velocity_init_cam_filter(str
 	mac_set_cam_mask(regs, vptr->mCAMmask, VELOCITY_MULTICAST_CAM);
 
 	/* Enable first VCAM */
-	if (vptr->flags & VELOCITY_FLAGS_TAGGING) {
-		/* If Tagging option is enabled and VLAN ID is not zero, then
-		   turn on MCFG_RTGOPT also */
-		if (vptr->options.vid != 0)
-			WORD_REG_BITS_ON(MCFG_RTGOPT, &regs->MCFG);
-
-		mac_set_cam(regs, 0, (u8 *) & (vptr->options.vid), VELOCITY_VLAN_ID_CAM);
-		vptr->vCAMmask[0] |= 1;
-		mac_set_cam_mask(regs, vptr->vCAMmask, VELOCITY_VLAN_ID_CAM);
-	} else {
-		u16 temp = 0;
-		mac_set_cam(regs, 0, (u8 *) &temp, VELOCITY_VLAN_ID_CAM);
-		temp = 1;
-		mac_set_cam_mask(regs, (u8 *) &temp, VELOCITY_VLAN_ID_CAM);
-	}
+	mac_set_cam(regs, 0, (u8 *) &temp, VELOCITY_VLAN_ID_CAM);
+	temp++;
+	mac_set_cam_mask(regs, (u8 *) &temp, VELOCITY_VLAN_ID_CAM);
 }
 
 /**
@@ -791,6 +887,13 @@ static int __devinit velocity_found1(str
 	dev->features |= NETIF_F_SG;
 #endif
 
+#ifdef CONFIG_VIA_VELOCITY_VLAN
+	dev->vlan_rx_register = velocity_vlan_rx_register;
+	dev->vlan_rx_kill_vid = velocity_vlan_rx_kill_vid;
+	dev->vlan_rx_add_vid = velocity_vlan_rx_add_vid;
+	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
+#endif
+
 	if (vptr->flags & VELOCITY_FLAGS_TX_CSUM) {
 		dev->features |= NETIF_F_HW_CSUM;
 	}
@@ -1427,7 +1530,8 @@ static int velocity_receive_frame(struct
 	skb->protocol = eth_type_trans(skb, skb->dev);	
 
 	stats->rx_bytes += pkt_len;
-	netif_rx(skb);
+	if (velocity_rx_vlan_skb(vptr, rd, skb) < 0)
+		netif_rx(skb);
 
 	return 0;
 }
@@ -1985,12 +2089,10 @@ static int velocity_xmit(struct sk_buff 
 		td_ptr->tdesc1.CMDZ = 2;
 	}
 
-	if (vptr->flags & VELOCITY_FLAGS_TAGGING) {
-		td_ptr->tdesc1.pqinf.VID = (vptr->options.vid & 0xfff);
-		td_ptr->tdesc1.pqinf.priority = 0;
-		td_ptr->tdesc1.pqinf.CFI = 0;
-		td_ptr->tdesc1.TCR |= TCR0_VETAG;
-	}
+	td_ptr->tdesc1.u.pqinf.VID = velocity_tx_vlan_tag(vptr, skb);
+	td_ptr->tdesc1.u.pqinf.CFI = 0;
+	td_ptr->tdesc1.u.pqinf.priority = 0;
+	td_ptr->tdesc1.TCR |= vlan_tx_tag_present(skb) ? TCR0_VETAG : 0x00;
 
 	/*
 	 *	Handle hardware checksum
diff -puN drivers/net/via-velocity.h~via-velocity-300 drivers/net/via-velocity.h
--- linux-2.6.10-rc1/drivers/net/via-velocity.h~via-velocity-300	2004-11-08 00:59:23.000000000 +0100
+++ linux-2.6.10-rc1-fr/drivers/net/via-velocity.h	2004-11-09 00:57:13.000000000 +0100
@@ -201,8 +201,17 @@ struct rdesc0 {
 	u16 owner:1;		/* Who owns this buffer ? */
 };
 
+struct pqinf {			/* Priority queue info */
+	u16 VID:12;
+	u16 CFI:1;
+	u16 priority:3;
+} __attribute__ ((__packed__));
+
 struct rdesc1 {
-	u16 PQTAG;
+	union {
+		u16 vlan_tag;
+		struct pqinf pqinf;
+	} u;
 	u8 CSM;
 	u8 IPKT;
 };
@@ -227,14 +236,11 @@ struct tdesc0 {
 	u16 owner:1;		/* Who owns the buffer */
 };
 
-struct pqinf {			/* Priority queue info */
-	u16 VID:12;
-	u16 CFI:1;
-	u16 priority:3;
-} __attribute__ ((__packed__));
-
 struct tdesc1 {
-	struct pqinf pqinf;
+	union {
+		u16 vlan_tag;
+		struct pqinf pqinf;
+	} u;
 	u8 TCR;
 	u8 TCPLS:2;
 	u8 reserved:2;
@@ -1796,7 +1802,9 @@ struct velocity_info {
 
 	u32 ticks;
 	u32 rx_bytes;
-
+#ifdef CONFIG_VIA_VELOCITY_VLAN
+	struct vlan_group *vlgrp;
+#endif
 };
 
 /**
diff -puN drivers/net/Kconfig~via-velocity-300 drivers/net/Kconfig
--- linux-2.6.10-rc1/drivers/net/Kconfig~via-velocity-300	2004-11-08 00:59:23.000000000 +0100
+++ linux-2.6.10-rc1-fr/drivers/net/Kconfig	2004-11-08 01:00:20.000000000 +0100
@@ -2070,6 +2070,15 @@ config VIA_VELOCITY
 	  To compile this driver as a module, choose M here. The module
 	  will be called via-velocity.
 
+config VIA_VELOCITY_VLAN
+	bool "VLAN support"
+	depends on VIA_VELOCITY && VLAN_8021Q
+	---help---
+	  Say Y here for the via-velocity driver to support the functions
+	  required by the kernel 802.1Q code.
+	  
+	  If in doubt, say Y.
+
 config TIGON3
 	tristate "Broadcom Tigon3 support"
 	depends on PCI

_
