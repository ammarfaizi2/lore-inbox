Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312951AbSCZExC>; Mon, 25 Mar 2002 23:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312952AbSCZEwm>; Mon, 25 Mar 2002 23:52:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312951AbSCZEwb>;
	Mon, 25 Mar 2002 23:52:31 -0500
Message-ID: <3C9FFE1E.F9F766FF@zip.com.au>
Date: Mon, 25 Mar 2002 20:50:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9FC76F.6050900@mandrakesoft.com> <20020326014050.GP1853@ufies.org> <3C9FF4B3.3070408@mandrakesoft.com> <20020326043943.GR1853@ufies.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've added three new module options:

	global_enable_wol=N
	global_options=N
	global_full_duplex=N

If you set one of these, they apply to all 3c59x NICs
in the machine.  If you also set an entry in the corresponding
array, that will override the global_* option.

How does that sound?

Oh look, it compiled :)  Wanna test it?


--- linux-2.4.19-pre4/drivers/net/3c59x.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/net/3c59x.c	Mon Mar 25 20:42:19 2002
@@ -166,7 +166,15 @@
     - Rename wait_for_completion() to issue_and_wait() to avoid completion.h
       clash.
 
-    - See http://www.uow.edu.au/~andrewm/linux/#3c59x-2.3 for more details.
+   LK1.1.17 18Dec01 akpm
+    - PCI ID 9805 is a Python-T, not a dual-port Cyclone.  Apparently.
+      And it has NWAY.
+    - Mask our advertised modes (vp->advertising) with our capabilities
+	  (MII reg5) when deciding which duplex mode to use.
+    - Add `global_options' as default for options[].  Ditto global_enable_wol,
+      global_full_duplex.
+
+    - See http://www.zip.com.au/~akpm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 */
 
@@ -181,8 +189,8 @@
 
 
 #define DRV_NAME	"3c59x"
-#define DRV_VERSION	"LK1.1.16"
-#define DRV_RELDATE	"19 July 2001"
+#define DRV_VERSION	"LK1.1.17"
+#define DRV_RELDATE	"18 Dec 2001"
 
 
 
@@ -270,10 +278,13 @@ MODULE_DESCRIPTION("3Com 3c59x/3c9xx eth
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(debug, "i");
+MODULE_PARM(global_options, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(8) "i");
+MODULE_PARM(global_full_duplex, "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(hw_checksums, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(flow_ctrl, "1-" __MODULE_STRING(8) "i");
+MODULE_PARM(global_enable_wol, "i");
 MODULE_PARM(enable_wol, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
@@ -283,10 +294,13 @@ MODULE_PARM(compaq_device_id, "i");
 MODULE_PARM(watchdog, "i");
 MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
 MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
+MODULE_PARM_DESC(global_options, "3c59x: same as options, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(full_duplex, "3c59x full duplex setting(s) (1)");
+MODULE_PARM_DESC(global_full_duplex, "3c59x: same as full_duplex, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(hw_checksums, "3c59x Hardware checksum checking by adapter(s) (0-1)");
 MODULE_PARM_DESC(flow_ctrl, "3c59x 802.3x flow control usage (PAUSE only) (0-1)");
 MODULE_PARM_DESC(enable_wol, "3c59x: Turn on Wake-on-LAN for adapter(s) (0-1)");
+MODULE_PARM_DESC(global_enable_wol, "3c59x: same as enable_wol, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(rx_copybreak, "3c59x copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "3c59x maximum events handled per interrupt");
 MODULE_PARM_DESC(compaq_ioaddr, "3c59x PCI I/O base address (Compaq BIOS problem workaround)");
@@ -473,7 +487,7 @@ static struct vortex_chip_info {
 	{"3c900 Boomerang 10Mbps Combo",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG, 64, },
 	{"3c900 Cyclone 10Mbps TPO",						/* AKPM: from Don's 0.99M */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c900 Cyclone 10Mbps Combo",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 
@@ -496,8 +510,8 @@ static struct vortex_chip_info {
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c980 Cyclone",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
-	{"3c982 Dual Port Server Cyclone",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	{"3c980C Python-T",
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 
 	{"3cSOHO100-TX Hurricane",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
@@ -853,6 +867,9 @@ static int full_duplex[MAX_UNITS] = {-1,
 static int hw_checksums[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int flow_ctrl[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int enable_wol[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int global_options = -1;
+static int global_full_duplex = -1;
+static int global_enable_wol = -1;
 
 /* #define dev_alloc_skb dev_alloc_skb_debug */
 
@@ -995,6 +1012,8 @@ static int __devinit vortex_probe1(struc
 	SET_MODULE_OWNER(dev);
 	vp = dev->priv;
 
+	option = global_options;
+
 	/* The lower four bits are the media type. */
 	if (dev->mem_start) {
 		/*
@@ -1003,10 +1022,10 @@ static int __devinit vortex_probe1(struc
 		 */
 		option = dev->mem_start;
 	}
-	else if (card_idx < MAX_UNITS)
-		option = options[card_idx];
-	else
-		option = -1;
+	else if (card_idx < MAX_UNITS) {
+		if (options[card_idx] >= 0)
+			option = options[card_idx];
+	}
 
 	if (option > 0) {
 		if (option & 0x8000)
@@ -1099,6 +1118,11 @@ static int __devinit vortex_probe1(struc
 		vp->bus_master = (option & 16) ? 1 : 0;
 	}
 
+	if (global_full_duplex > 0)
+		vp->full_duplex = 1;
+	if (global_enable_wol > 0)
+		vp->enable_wol = 1;
+
 	if (card_idx < MAX_UNITS) {
 		if (full_duplex[card_idx] > 0)
 			vp->full_duplex = 1;
@@ -1244,11 +1268,12 @@ static int __devinit vortex_probe1(struc
 	} else
 		dev->if_port = vp->default_media;
 
-	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
+	if ((vp->available_media & 0x4b) || (vci->drv_flags & HAS_NWAY) ||
+		dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
 		int phy, phy_idx = 0;
 		EL3WINDOW(4);
 		mii_preamble_required++;
-		mii_preamble_required++;
+		mdio_sync(ioaddr, 32);
 		mdio_read(dev, 24, 1);
 		for (phy = 0; phy < 32 && phy_idx < 1; phy++) {
 			int mii_status, phyx;
@@ -1264,6 +1289,8 @@ static int __devinit vortex_probe1(struc
 			else
 				phyx = phy;
 			mii_status = mdio_read(dev, phyx, 1);
+		printk("phy=%d, phyx=%d, mii_status=0x%04x\n",
+			phy, phyx, mii_status);
 			if (mii_status  &&  mii_status != 0xffff) {
 				vp->phys[phy_idx++] = phyx;
 				if (print_info) {
@@ -1444,11 +1471,14 @@ vortex_up(struct net_device *dev)
 		/* Read BMSR (reg1) only to clear old status. */
 		mii_reg1 = mdio_read(dev, vp->phys[0], 1);
 		mii_reg5 = mdio_read(dev, vp->phys[0], 5);
-		if (mii_reg5 == 0xffff  ||  mii_reg5 == 0x0000)
+		if (mii_reg5 == 0xffff  ||  mii_reg5 == 0x0000) {
 			;					/* No MII device or no link partner report */
-		else if ((mii_reg5 & 0x0100) != 0	/* 100baseTx-FD */
+		} else {
+			mii_reg5 &= vp->advertising;
+			if ((mii_reg5 & 0x0100) != 0	/* 100baseTx-FD */
 				 || (mii_reg5 & 0x00C0) == 0x0040) /* 10T-FD, but not 100-HD */
 			vp->full_duplex = 1;
+		}
 		vp->partner_flow_ctrl = ((mii_reg5 & 0x0400) != 0);
 		if (vortex_debug > 1)
 			printk(KERN_INFO "%s: MII #%d status %4.4x, link partner capability %4.4x,"
@@ -1669,8 +1699,10 @@ vortex_timer(unsigned long data)
 			if (mii_status & 0x0004) {
 				int mii_reg5 = mdio_read(dev, vp->phys[0], 5);
 				if (! vp->force_fd  &&  mii_reg5 != 0xffff) {
-					int duplex = (mii_reg5&0x0100) ||
-						(mii_reg5 & 0x01C0) == 0x0040;
+					int duplex;
+
+					mii_reg5 &= vp->advertising;
+					duplex = (mii_reg5&0x0100) || (mii_reg5 & 0x01C0) == 0x0040;
 					if (vp->full_duplex != duplex) {
 						vp->full_duplex = duplex;
 						printk(KERN_INFO "%s: Setting %s-duplex based on MII "
@@ -1753,9 +1785,11 @@ static void vortex_tx_timeout(struct net
 		   dev->name, inb(ioaddr + TxStatus),
 		   inw(ioaddr + EL3_STATUS));
 	EL3WINDOW(4);
-	printk(KERN_ERR "  diagnostics: net %04x media %04x dma %8.8x.\n",
-		   inw(ioaddr + Wn4_NetDiag), inw(ioaddr + Wn4_Media),
-		   inl(ioaddr + PktStatus));
+	printk(KERN_ERR "  diagnostics: net %04x media %04x dma %08x fifo %04x\n",
+			inw(ioaddr + Wn4_NetDiag),
+			inw(ioaddr + Wn4_Media),
+			inl(ioaddr + PktStatus),
+			inw(ioaddr + Wn4_FIFODiag));
 	/* Slight code bloat to be user friendly. */
 	if ((inb(ioaddr + TxStatus) & 0x88) == 0x88)
 		printk(KERN_ERR "%s: Transmitter encountered 16 collisions --"
@@ -2538,7 +2572,6 @@ vortex_close(struct net_device *dev)
 			((vp->drv_flags & HAS_HWCKSM) == 0) &&
 			(hw_checksums[vp->card_idx] == -1)) {
 		printk(KERN_WARNING "%s supports hardware checksums, and we're not using them!\n", dev->name);
-		printk(KERN_WARNING "Please see http://www.uow.edu.au/~andrewm/zerocopy.html\n");
 	}
 #endif
 		
--- linux-2.4.19-pre4/Documentation/networking/vortex.txt	Sun Aug 12 12:27:36 2001
+++ linux-akpm/Documentation/networking/vortex.txt	Mon Mar 25 20:45:35 2002
@@ -117,6 +117,12 @@ options=N1,N2,N3,...
   will force full-duplex 100base-TX, rather than allowing the usual
   autonegotiation.
 
+global_options=N
+
+  Sets the `options' parameter for all 3c59x NICs in the machine. 
+  Entries in the `options' array above will override any setting of
+  this.
+
 full_duplex=N1,N2,N3...
 
   Similar to bit 9 of 'options'.  Forces the corresponding card into
@@ -126,6 +132,11 @@ full_duplex=N1,N2,N3...
   In fact, please don't use this at all! You're better off getting
   autonegotiation working properly.
 
+global_full_duplex=N1
+
+  Sets full duplex mode for all 3c59x NICs in the machine.  Entries
+  in the `full_duplex' array above will override any setting of this.
+
 flow_ctrl=N1,N2,N3...
 
   Use 802.3x MAC-layer flow control.  The 3com cards only support the
@@ -211,6 +222,12 @@ enable_wol=N1,N2,N3,...
   Becker's `ether-wake' application may be used to wake suspended
   machines.
 
+  Also enables the NIC's power management support.
+
+global_enable_wol=N
+
+  Sets enable_wol mode for all 3c59x NICs in the machine.  Entries in
+  the `enable_wol' array above will override any setting of this.
 
 Media selection
 ---------------


-
