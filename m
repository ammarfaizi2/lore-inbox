Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293251AbSCAQ2R>; Fri, 1 Mar 2002 11:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293249AbSCAQ2F>; Fri, 1 Mar 2002 11:28:05 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:44992 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S293245AbSCAQ1q>;
	Fri, 1 Mar 2002 11:27:46 -0500
Message-ID: <3C7FAC00.4010402@candelatech.com>
Date: Fri, 01 Mar 2002 09:27:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com>	<3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

> Your mail client wraps long lines so the patches are totally
> unusuable, please resend without line wrapping.  Thanks.


Hopefully this will work better.


> 
> Most of the diffs haven't been applied because they still
> need some work.  At least that is what Jeff told me about
> the 3c59x changes.


I don't have hardware to test with this driver, so I can't really
vouch for the patch.  However, it does work for some people, and
there are definate problems with the stock driver, so we should try
to get some kind of patch in there eventually...

Resend of the patches:

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
- 
Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
+ 
Wn3_Config=0, Wn3_MaxPktSize=4, Wn3_MAC_Ctrl=6, Wn3_Options=8,
  };

  #define BFEXT(value, offset, bitcount)  \
@@ -679,7 +682,8 @@
  	Media_LnkBeat = 0x0800,
  };
  enum Window7 {					/* Window 7: Bus Master control. */
- 
Wn7_MasterAddr = 0, Wn7_MasterLen = 6, Wn7_MasterStatus = 12,
+ 
Wn7_MasterAddr = 0, Wn7_VlanEtherType=4, Wn7_MasterLen = 6,
+ 
Wn7_MasterStatus = 12,
  };
  /* Boomerang bus master control registers. */
  enum MasterCtrl {
@@ -776,7 +780,8 @@
  		pm_state_valid:1, 
			/* power_state[] has sane contents */
  		open:1,
  		medialock:1,
- 
	must_free_region:1;				/* Flag: if zero, Cardbus owns the I/O region */
+ 
	must_free_region:1,				/* Flag: if zero, Cardbus owns the I/O region */
+ 
	large_frames:1;			/* accept large frames */
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
+ 
vp->large_frames = mtu > 1500;
  	vp->drv_flags = vci->drv_flags;
  	vp->has_nway = (vci->drv_flags & HAS_NWAY) ? 1 : 0;
  	vp->io_size = vci->io_size;
@@ -1461,7 +1470,7 @@

  	/* Set the full-duplex bit. */
  	outw(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
- 
	 
	(dev->mtu > 1500 ? 0x40 : 0) |
+ 
	 
	(vp->large_frames ? 0x40 : 0) |
  	 
	((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
  	 
	ioaddr + Wn3_MAC_Ctrl);

@@ -1545,6 +1554,10 @@
  	}
  	/* Set receiver mode: presumably accept b-case and phys addr only. */
  	set_rx_mode(dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+ 
/* enable 802.1q tagged frames */
+ 
set_8021q_mode(dev, 1);
+#endif
  	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */

  //	issue_and_wait(dev, SetTxStart|0x07ff);
@@ -1680,7 +1693,7 @@
  	 
				/* Set the full-duplex bit. */
  	 
				EL3WINDOW(3);
  	 
				outw(	(vp->full_duplex ? 0x20 : 0) |
- 
							(dev->mtu > 1500 ? 0x40 : 0) |
+ 
							(vp->large_frames ? 0x40 : 0) |
  	 
						((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
  	 
						ioaddr + Wn3_MAC_Ctrl);
  	 
				if (vortex_debug > 1)
@@ -1900,6 +1913,10 @@
  	 
	issue_and_wait(dev, RxReset|0x07);
  	 
	/* Set the Rx filter to the current state. */
  	 
	set_rx_mode(dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+ 
		/* enable 802.1q VLAN tagged frames */
+ 
		set_8021q_mode(dev, 1);
+#endif
  	 
	outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
  	 
	outw(AckIntr | HostError, ioaddr + EL3_CMD);
  		}
@@ -2497,6 +2514,11 @@
  	outw(RxDisable, ioaddr + EL3_CMD);
  	outw(TxDisable, ioaddr + EL3_CMD);

+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+ 
/* Disable receiving 802.1q tagged frames */
+ 
set_8021q_mode(dev, 0);
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
+ 
struct vortex_private *vp = (struct vortex_private *)dev->priv;
+ 
long ioaddr = dev->base_addr;
+ 
int old_window = inw(ioaddr + EL3_CMD);
+ 
int mac_ctrl;
+ 

+ 
if (vp->drv_flags&IS_CYCLONE || vp->drv_flags&IS_TORNADO) {
+ 
	/* cyclone and tornado chipsets can recognize 802.1q
+ 
	 * tagged frames and treat them correctly */
+
+ 
	int max_pkt_size = dev->mtu+14;	/* MTU+Ethernet header */
+ 
	if (enable)
+ 
		max_pkt_size += 4;	/* 802.1Q VLAN tag */
+
+ 
	EL3WINDOW(3);
+ 
	outw(max_pkt_size, ioaddr+Wn3_MaxPktSize);
+
+ 
	/* set VlanEtherType to let the hardware checksumming
+ 
	   treat tagged frames correctly */
+ 
	EL3WINDOW(7);
+ 
	outw(VLAN_ETHER_TYPE, ioaddr+Wn7_VlanEtherType);
+ 
} else {
+ 
	/* on older cards we have to enable large frames */
+
+ 
	vp->large_frames = dev->mtu > 1500 || enable;
+
+ 
	EL3WINDOW(3);
+ 
	mac_ctrl = inw(ioaddr+Wn3_MAC_Ctrl);
+ 
	if (vp->large_frames)
+ 
		mac_ctrl |= 0x40;
+ 
	else
+ 
		mac_ctrl &= ~0x40;
+ 
	outw(mac_ctrl, ioaddr+Wn3_MAC_Ctrl);
+ 
}
+
+ 
EL3WINDOW(old_window);
+}
+#endif

  /* MII transceiver control section.
     Read and write the MII registers using software-generated serial


diff -urN linux-2.4.16/drivers/net/eepro100.c linux/drivers/net/eepro100.c
--- linux-2.4.16/drivers/net/eepro100.c	Mon Nov 12 18:47:18 2001
+++ linux/drivers/net/eepro100.c	Tue Dec 18 11:36:11 2001
@@ -510,12 +510,12 @@
  static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
  	22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
  	0, 0x2E, 0,  0x60, 0,
- 
0xf2, 0x48,   0, 0x40, 0xf2, 0x80, 		/* 0x40=Force full-duplex */
+ 
0xf2, 0x48,   0, 0x40, 0xfa, 0x80, 		/* 0x40=Force full-duplex */
  	0x3f, 0x05, };
  static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
  	22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
  	0, 0x2E, 0,  0x60, 0x08, 0x88,
- 
0x68, 0, 0x40, 0xf2, 0x84,		/* Disable FC */
+ 
0x68, 0, 0x40, 0xfa, 0x84,		/* Disable FC */
  	0x31, 0x05, };

  /* PHY media interface chips. */


diff -u --recursive --new-file linux/drivers/net/tulip/interrupt.c linux.dev/drivers/net/tulip/interrupt.c
--- linux/drivers/net/tulip/interrupt.c	Fri Nov  9 22:45:35 2001
+++ linux.dev/drivers/net/tulip/interrupt.c	Tue Dec 11 09:24:36 2001
@@ -128,8 +128,8 @@
  	 
		   dev->name, entry, status);
  		if (--rx_work_limit < 0)
  	 
	break;
- 
	if ((status & 0x38008300) != 0x0300) {
- 
		if ((status & 0x38000300) != 0x0300) {
+ 
	if ((status & (0x38000000 | RxDescFatalErr | RxWholePkt)) != RxWholePkt) {
+ 
		if ((status & (0x38000000 | RxWholePkt)) != RxWholePkt) {
  	 
		/* Ingore earlier buffers. */
  	 
		if ((status & 0xffff) != 0x7fff) {
  	 
			if (tulip_debug > 1)
@@ -155,10 +155,10 @@
  	 
	struct sk_buff *skb;

  #ifndef final_version
- 
		if (pkt_len > 1518) {
+ 
		if (pkt_len > 1522) {
  	 
		printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\n",
  	 
			   dev->name, pkt_len, pkt_len);
- 
			pkt_len = 1518;
+ 
			pkt_len = 1522;
  	 
		tp->stats.rx_length_errors++;
  	 
	}
  #endif
diff -u --recursive --new-file linux/drivers/net/tulip/tulip.h linux.dev/drivers/net/tulip/tulip.h
--- linux/drivers/net/tulip/tulip.h	Fri Nov  9 22:45:35 2001
+++ linux.dev/drivers/net/tulip/tulip.h	Tue Dec 11 09:24:36 2001
@@ -186,7 +186,7 @@

  enum desc_status_bits {
  	DescOwned = 0x80000000,
- 
RxDescFatalErr = 0x8000,
+ 
RxDescFatalErr = 0x4842,
  	RxWholePkt = 0x0300,
  };

diff -u --recursive --new-file linux/drivers/net/tulip/tulip_core.c linux.dev/drivers/net/tulip/tulip_core.c
--- linux/drivers/net/tulip/tulip_core.c	Tue Nov 20 00:19:42 2001
+++ linux.dev/drivers/net/tulip/tulip_core.c	Tue Dec 11 09:24:36 2001
@@ -63,7 +63,7 @@
  #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
  	|| defined(__sparc_) || defined(__ia64__) \
  	|| defined(__sh__) || defined(__mips__)
-static int rx_copybreak = 1518;
+static int rx_copybreak = 1522;
  #else
  static int rx_copybreak = 100;
  #endif







-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


