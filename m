Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280833AbRKGPxu>; Wed, 7 Nov 2001 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKGPxc>; Wed, 7 Nov 2001 10:53:32 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:1284 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S280830AbRKGPxV>; Wed, 7 Nov 2001 10:53:21 -0500
Date: Wed, 7 Nov 2001 16:53:19 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>
Subject: [PATCH] 802.1q-support for 3c59x.c
Message-ID: <20011107165318.A15577@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	VLAN Mailing List <vlan@Scry.WANfear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was very pleased that 802.1q VLAN tagging support has been included
into the kernel recently :-)

Though this is only part of the work needed.

Let me start from the beginning, for those not familiar with 802.1q
tagging. The tag adds an additional header field (4 Bytes) to the
ethernet header, so that the maximum frame size is 1518 Octets instead
of 1514 (with a standard MTU of 1500).

The problem is that most network cards by default will flag those
frames as oversized and drop them (though /sending/ tagged frames is
not a problem with any card I know of). There are several
possibilities to resolve this problem:

- reduce the MTU on all servers connected to the VLAN (not always
  possible)
- patch the NIC driver so that it doesn't drop oversized frames
- set the MTU on the physical interface to 1504, which is a) not
  possible with every driver, and b) untagged frames sent via the
  interface will be oversized now.

Below my signature you will find a patch that adds the necessary bits
to the 3c59x.c driver. It sets up the NIC to receive VLAN tagged
frames and (if supported by the NIC) correctly checksum them.

Newer cards (those with HW checksumming support) have a register to
configure the maximum frame size. Older cards don't have this
register, but they have a flag that lets the NIC receive FDDI sized
frames (4500 Octets IIRC).

It was discussed on the VLAN mailinglist if (at least in the case of
hardware like the old 3Com NICs where you can basically only disable
checking the frame size) it is feasible to only enable the large
frame receipt if VLAN tags are really used on the NIC. We have come to
the conclusion that uncoditionally enabling it should not pose any
performance penalties with any sane hardware implementation, so we
decided to not introduce a VLAN enable callback into NIC drivers.

Just to be sure, the 3c59x patch only enables the new parts if 802.1q
support has been enabled in the kernel configuration. Testing proved
the patch quite stable (no problem reports so far).

There is no maintainer mentioned for the 3c59x driver in the
MAINTAINERS file, so I send this directly to the list. Please consider
the patch for kernel inclusion.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net

--- linux.orig/drivers/net/3c59x.c	Sun Sep 30 21:26:06 2001
+++ linux/drivers/net/3c59x.c	Wed Oct 24 21:52:10 2001
@@ -308,6 +308,9 @@
    code size of a per-interface flag is not worthwhile. */
 static char mii_preamble_required;
 
+/* The Ethernet Type used for 802.1q tagged frames */
+#define VLAN_ETHER_TYPE 0x8100
+
 #define PFX DRV_NAME ": "
 
 
@@ -651,7 +654,7 @@
 	Wn2_ResetOptions=12,
 };
 enum Window3 {			/* Window 3: MAC/config bits. */
-	Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
+	Wn3_Config=0, Wn3_MaxPktSize=4, Wn3_MAC_Ctrl=6, Wn3_Options=8,
 };
 
 #define BFEXT(value, offset, bitcount)  \
@@ -679,7 +682,8 @@
 	Media_LnkBeat = 0x0800,
 };
 enum Window7 {					/* Window 7: Bus Master control. */
-	Wn7_MasterAddr = 0, Wn7_MasterLen = 6, Wn7_MasterStatus = 12,
+	Wn7_MasterAddr = 0, Wn7_VlanEtherType=4, Wn7_MasterLen = 6,
+	Wn7_MasterStatus = 12,
 };
 /* Boomerang bus master control registers. */
 enum MasterCtrl {
@@ -776,7 +780,8 @@
 		pm_state_valid:1,				/* power_state[] has sane contents */
 		open:1,
 		medialock:1,
-		must_free_region:1;				/* Flag: if zero, Cardbus owns the I/O region */
+		must_free_region:1,				/* Flag: if zero, Cardbus owns the I/O region */
+		large_frames:1;			/* accept large frames */
 	int drv_flags;
 	u16 status_enable;
 	u16 intr_enable;
@@ -844,6 +849,9 @@
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void vortex_tx_timeout(struct net_device *dev);
 static void acpi_set_WOL(struct net_device *dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+static void set_8021q_mode(struct net_device *dev, int enable);
+#endif
 
 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
 /* Option count limit only -- unlimited interfaces are supported. */
@@ -1030,6 +1038,7 @@
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 	dev->mtu = mtu;
+	vp->large_frames = mtu > 1500;
 	vp->drv_flags = vci->drv_flags;
 	vp->has_nway = (vci->drv_flags & HAS_NWAY) ? 1 : 0;
 	vp->io_size = vci->io_size;
@@ -1461,7 +1470,7 @@
 
 	/* Set the full-duplex bit. */
 	outw(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
-		 	(dev->mtu > 1500 ? 0x40 : 0) |
+		 	(vp->large_frames ? 0x40 : 0) |
 			((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 			ioaddr + Wn3_MAC_Ctrl);
 
@@ -1545,6 +1554,10 @@
 	}
 	/* Set receiver mode: presumably accept b-case and phys addr only. */
 	set_rx_mode(dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	/* enable 802.1q tagged frames */
+	set_8021q_mode(dev, 1);
+#endif
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
 //	issue_and_wait(dev, SetTxStart|0x07ff);
@@ -1680,7 +1693,7 @@
 						/* Set the full-duplex bit. */
 						EL3WINDOW(3);
 						outw(	(vp->full_duplex ? 0x20 : 0) |
-								(dev->mtu > 1500 ? 0x40 : 0) |
+								(vp->large_frames ? 0x40 : 0) |
 								((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 								ioaddr + Wn3_MAC_Ctrl);
 						if (vortex_debug > 1)
@@ -1900,6 +1913,10 @@
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
@@ -2497,6 +2514,11 @@
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
@@ -2760,6 +2782,50 @@
 
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
