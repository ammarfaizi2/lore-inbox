Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSE1UJH>; Tue, 28 May 2002 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316901AbSE1UJG>; Tue, 28 May 2002 16:09:06 -0400
Received: from stingr.net ([212.193.32.15]:5806 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S316887AbSE1UJF>;
	Tue, 28 May 2002 16:09:05 -0400
Date: Wed, 29 May 2002 00:09:04 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Alexander Trotsai <mage@adamant.ua>
Subject: Re: vlan dotQ vs 2.4.19pre8-ac5 vs big packets trouble
Message-ID: <20020528200904.GJ422@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alexander Trotsai <mage@adamant.ua>
In-Reply-To: <20020528165918.GT1365@blackhole.adamant.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Alexander Trotsai:
> # My 3C59X has MTU problems.
> 
> Edit the 3C59x.c, find the place where it says:
> 
> static const int mtu = 1500;
> and replace 1500 with
> static const int mtu = 1504;
> 
> but I got same trouble with this patch

It seems that you use broken by design way. I believe that the following IS
correct (sigh)

===== 3c59x.c 1.14 vs 1.15 =====
--- 1.14/drivers/net/3c59x.c	Sat May 25 16:11:31 2002
+++ 1.15/drivers/net/3c59x.c	Mon May 27 19:49:49 2002
@@ -322,6 +322,9 @@
    code size of a per-interface flag is not worthwhile. */
 static char mii_preamble_required;
 
+/* The Ethernet Type used for 802.1q tagged frames */
+#define VLAN_ETHER_TYPE 0x8100
+
 #define PFX DRV_NAME ": "
 
 
@@ -665,7 +668,7 @@
 	Wn2_ResetOptions=12,
 };
 enum Window3 {			/* Window 3: MAC/config bits. */
-	Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
+	Wn3_Config=0, Wn3_MaxPktSize=4, Wn3_MAC_Ctrl=6, Wn3_Options=8,
 };
 
 #define BFEXT(value, offset, bitcount)  \
@@ -693,7 +696,8 @@
 	Media_LnkBeat = 0x0800,
 };
 enum Window7 {					/* Window 7: Bus Master control. */
-	Wn7_MasterAddr = 0, Wn7_MasterLen = 6, Wn7_MasterStatus = 12,
+	Wn7_MasterAddr = 0, Wn7_VlanEtherType=4, Wn7_MasterLen = 6,
+	Wn7_MasterStatus = 12,
 };
 /* Boomerang bus master control registers. */
 enum MasterCtrl {
@@ -790,7 +794,8 @@
 		pm_state_valid:1,				/* power_state[] has sane contents */
 		open:1,
 		medialock:1,
-		must_free_region:1;				/* Flag: if zero, Cardbus owns the I/O region */
+		must_free_region:1,				/* Flag: if zero, Cardbus owns the I/O region */
+		large_frames:1;			/* accept large frames */
 	int drv_flags;
 	u16 status_enable;
 	u16 intr_enable;
@@ -858,6 +863,9 @@
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void vortex_tx_timeout(struct net_device *dev);
 static void acpi_set_WOL(struct net_device *dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+static void set_8021q_mode(struct net_device *dev, int enable);
+#endif
 
 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
 /* Option count limit only -- unlimited interfaces are supported. */
@@ -1049,6 +1057,7 @@
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 	dev->mtu = mtu;
+	vp->large_frames = mtu > 1500;
 	vp->drv_flags = vci->drv_flags;
 	vp->has_nway = (vci->drv_flags & HAS_NWAY) ? 1 : 0;
 	vp->io_size = vci->io_size;
@@ -1489,7 +1498,7 @@
 
 	/* Set the full-duplex bit. */
 	outw(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
-		 	(dev->mtu > 1500 ? 0x40 : 0) |
+		 	(vp->large_frames ? 0x40 : 0) |
 			((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 			ioaddr + Wn3_MAC_Ctrl);
 
@@ -1573,6 +1582,10 @@
 	}
 	/* Set receiver mode: presumably accept b-case and phys addr only. */
 	set_rx_mode(dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	/* enable 802.1q tagged frames */
+	set_8021q_mode(dev, 1);
+#endif
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
 //	issue_and_wait(dev, SetTxStart|0x07ff);
@@ -1710,7 +1723,7 @@
 						/* Set the full-duplex bit. */
 						EL3WINDOW(3);
 						outw(	(vp->full_duplex ? 0x20 : 0) |
-								(dev->mtu > 1500 ? 0x40 : 0) |
+								(vp->large_frames ? 0x40 : 0) |
 								((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 								ioaddr + Wn3_MAC_Ctrl);
 						if (vortex_debug > 1)
@@ -1932,6 +1945,10 @@
 			issue_and_wait(dev, RxReset|0x07);
 			/* Set the Rx filter to the current state. */
 			set_rx_mode(dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+			/* enable 802.1q VLAN tagged frames */
+			set_8021q_mode(dev, 1);
+#endif
 			outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
 			outw(AckIntr | HostError, ioaddr + EL3_CMD);
 		}
@@ -2529,6 +2546,11 @@
 	outw(RxDisable, ioaddr + EL3_CMD);
 	outw(TxDisable, ioaddr + EL3_CMD);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	/* Disable receiving 802.1q tagged frames */
+	set_8021q_mode(dev, 0);
+#endif
+
 	if (dev->if_port == XCVR_10base2)
 		/* Turn off thinnet power.  Green! */
 		outw(StopCoax, ioaddr + EL3_CMD);
@@ -2791,6 +2813,50 @@
 
 	outw(new_mode, ioaddr + EL3_CMD);
 }
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+/* Setup the card so that it can receive frames with an 802.1q VLAN tag.
+   Note that this must be done after each RxReset due to some backwards
+   compatibility logic in the Cyclone and Tornado ASICs */
+static void set_8021q_mode(struct net_device *dev, int enable)
+{
+	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+	long ioaddr = dev->base_addr;
+	int old_window = inw(ioaddr + EL3_CMD);
+	int mac_ctrl;
+	
+	if (vp->drv_flags&IS_CYCLONE || vp->drv_flags&IS_TORNADO) {
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
+#endif
 
 /* MII transceiver control section.
    Read and write the MII registers using software-generated serial





> 
> -- 
> Best regard, Alexander Trotsai aka MAGE-RIPE aka MAGE-UANIC
> My PGP at ftp://blackhole.adamant.net/pgp/trotsai.key[.asc]
> Big trouble - Post-it Note Sludge leaked into the monitor.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
