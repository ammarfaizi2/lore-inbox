Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUG1Mps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUG1Mps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUG1Mps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:45:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266901AbUG1Mnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:43:40 -0400
Date: Wed, 28 Jul 2004 08:42:56 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040728124256.GA31246@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds VLAN support to the 3c59x/90x series hardware.

Stefan de Konink ported this code from the 2.4 VLAN patches and tested it
extensively. I cleaned up the ifdefs and fixed a problem with bracketing
that made older cards fail.

--

Developer's Certificate of Origin 1.0

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I have the
right to submit it under the open source license indicated in the file; or

(b) The contribution is based upon previous work that, to the best of my
knowledge, is covered under an appropriate open source license and I have
the right under that license to submit that work with modifications,
whether created in whole or in part by me, under the same open source
license (unless I am permitted to submit under a different license), as
indicated in the file; or

(c) The contribution was provided directly to me by some other person who
certified (a), (b) or (c) and I have not modified it.


I, Stefan de Konink, certify that:
 The contribution is based upon previous work that, again is based on GPL
code and I have the right under that license to submit that work with
modifications, whether created in whole or in part by me, under the same
open source license.

I, Alan Cox, certify likewise.


---


--- drivers/net/3c59x.c.old	2004-07-28 12:54:03.048561056 +0100
+++ drivers/net/3c59x.c	2004-07-28 13:36:31.500137528 +0100
@@ -695,7 +695,7 @@
 	Wn2_ResetOptions=12,
 };
 enum Window3 {			/* Window 3: MAC/config bits. */
-	Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
+	Wn3_Config=0, Wn3_MaxPktSize=4, Wn3_MAC_Ctrl=6, Wn3_Options=8,
 };
 
 #define BFEXT(value, offset, bitcount)  \
@@ -723,7 +723,8 @@
 	Media_LnkBeat = 0x0800,
 };
 enum Window7 {					/* Window 7: Bus Master control. */
-	Wn7_MasterAddr = 0, Wn7_MasterLen = 6, Wn7_MasterStatus = 12,
+	Wn7_MasterAddr = 0, Wn7_VlanEtherType=4, Wn7_MasterLen = 6,
+	Wn7_MasterStatus = 12,
 };
 /* Boomerang bus master control registers. */
 enum MasterCtrl {
@@ -819,7 +820,8 @@
 		pm_state_valid:1,				/* power_state[] has sane contents */
 		open:1,
 		medialock:1,
-		must_free_region:1;				/* Flag: if zero, Cardbus owns the I/O region */
+		must_free_region:1,				/* Flag: if zero, Cardbus owns the I/O region */
+		large_frames:1;			/* accept large frames */
 	int drv_flags;
 	u16 status_enable;
 	u16 intr_enable;
@@ -904,6 +906,8 @@
 static void vortex_tx_timeout(struct net_device *dev);
 static void acpi_set_WOL(struct net_device *dev);
 static struct ethtool_ops vortex_ethtool_ops;
+static void set_8021q_mode(struct net_device *dev, int enable);
+
 
 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
 /* Option count limit only -- unlimited interfaces are supported. */
@@ -1164,6 +1168,7 @@
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 	dev->mtu = mtu;
+	vp->large_frames = mtu > 1500;
 	vp->drv_flags = vci->drv_flags;
 	vp->has_nway = (vci->drv_flags & HAS_NWAY) ? 1 : 0;
 	vp->io_size = vci->io_size;
@@ -1616,7 +1621,7 @@
 
 	/* Set the full-duplex bit. */
 	outw(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
-		 	(dev->mtu > 1500 ? 0x40 : 0) |
+		 	(vp->large_frames ? 0x40 : 0) |
 			((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 			ioaddr + Wn3_MAC_Ctrl);
 
@@ -1700,6 +1705,8 @@
 	}
 	/* Set receiver mode: presumably accept b-case and phys addr only. */
 	set_rx_mode(dev);
+	/* enable 802.1q tagged frames */
+	set_8021q_mode(dev, 1);
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
 //	issue_and_wait(dev, SetTxStart|0x07ff);
@@ -1842,7 +1849,7 @@
 						/* Set the full-duplex bit. */
 						EL3WINDOW(3);
 						outw(	(vp->full_duplex ? 0x20 : 0) |
-								(dev->mtu > 1500 ? 0x40 : 0) |
+								(vp->large_frames ? 0x40 : 0) |
 								((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 								ioaddr + Wn3_MAC_Ctrl);
 						if (vortex_debug > 1)
@@ -2068,6 +2075,8 @@
 			issue_and_wait(dev, RxReset|0x07);
 			/* Set the Rx filter to the current state. */
 			set_rx_mode(dev);
+			/* enable 802.1q VLAN tagged frames */
+			set_8021q_mode(dev, 1);
 			outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
 			outw(AckIntr | HostError, ioaddr + EL3_CMD);
 		}
@@ -2672,6 +2681,9 @@
 	outw(RxDisable, ioaddr + EL3_CMD);
 	outw(TxDisable, ioaddr + EL3_CMD);
 
+	/* Disable receiving 802.1q tagged frames */
+	set_8021q_mode(dev, 0);
+
 	if (dev->if_port == XCVR_10base2)
 		/* Turn off thinnet power.  Green! */
 		outw(StopCoax, ioaddr + EL3_CMD);
@@ -2947,6 +2959,61 @@
 	outw(new_mode, ioaddr + EL3_CMD);
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+/* Setup the card so that it can receive frames with an 802.1q VLAN tag.
+   Note that this must be done after each RxReset due to some backwards
+   compatibility logic in the Cyclone and Tornado ASICs */
+
+/* The Ethernet Type used for 802.1q tagged frames */
+#define VLAN_ETHER_TYPE 0x8100
+
+static void set_8021q_mode(struct net_device *dev, int enable)
+{
+	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	long ioaddr = dev->base_addr;
+	int old_window = inw(ioaddr + EL3_CMD);
+	int mac_ctrl;
+	
+	if ((vp->drv_flags&IS_CYCLONE) || (vp->drv_flags&IS_TORNADO)) {
+		/* cyclone and tornado chipsets can recognize 802.1q
+		 * tagged frames and treat them correctly */
+
+		int max_pkt_size = dev->mtu+14;	/* MTU+Ethernet header */
+		if (enable)
+			max_pkt_size += 4;	/* 802.1Q VLAN tag */
+
+		EL3WINDOW(3);
+		outw(max_pkt_size, ioaddr+Wn3_MaxPktSize);
+
+		/* set VlanEtherType to let the hardware checksumming
+		   treat tagged frames correctly */
+		EL3WINDOW(7);
+		outw(VLAN_ETHER_TYPE, ioaddr+Wn7_VlanEtherType);
+	} else {
+		/* on older cards we have to enable large frames */
+
+		vp->large_frames = dev->mtu > 1500 || enable;
+
+		EL3WINDOW(3);
+		mac_ctrl = inw(ioaddr+Wn3_MAC_Ctrl);
+		if (vp->large_frames)
+			mac_ctrl |= 0x40;
+		else
+			mac_ctrl &= ~0x40;
+		outw(mac_ctrl, ioaddr+Wn3_MAC_Ctrl);
+	}
+
+	EL3WINDOW(old_window);
+}
+#else
+
+static void set_8021q_mode(struct net_device *dev, int enable)
+{
+}
+
+
+#endif
+
 /* MII transceiver control section.
    Read and write the MII registers using software-generated serial
    MDIO protocol.  See the MII specifications or DP83840A data sheet

