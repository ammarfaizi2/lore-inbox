Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUDLQab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUDLQaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:30:30 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:30690 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262941AbUDLQ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:26:51 -0400
Message-ID: <407AC348.3000505@pacbell.net>
Date: Mon, 12 Apr 2004 09:26:48 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
CC: David T Hollis <dhollis@davehollis.com>
Subject: [patch/RFT 2.4.26-rc2] update usbnet matching 2.6.recent
Content-Type: multipart/mixed;
 boundary="------------010104040907030907010005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010104040907030907010005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Title says it all; the 2.4 "usbnet" is missing features and fixes,
this patch makes the delta from 2.6 be pretty small.

Its Config.in menu now looks more like 2.6, with per-minidriver
config options.  This matters mostly since the AX8817X driver will
no longer be hidden (it's good for getting good 100BaseT speeds
using EHCI).

On 2.6, "usbnet" handles CDC Ethernet ... so this patch disables
"CDCEther", which may exceed some folk's expectations of what
should happen in a "stable" kernel.  However:  (a) it's what Zaurus
users have needed to do anyway (Zaurus claims CDC support, but lies),
(b) this seems to work well on 2.6 systems, better on some hardware
than "CDCEther", and (c) the CDCEther maintainer (GregKH) seemed
to think making "usbnet" do this was OK last time this came up.

If you use "usbnet" or especially "CDCEther", and have the time
to apply, please give this a whirl ... I don't think there should
be many issues, there's not a lot of 2.4-specific code here.

- Dave


--------------010104040907030907010005
Content-Type: text/plain;
 name="usbnet-0412.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbnet-0412.patch"

The "usbnet" driver has gotten a bit out of sync with the newer
code (2.6.5+); this fixes that.  Notable changes:

    - Support more devices:  Zaurus C-860, ALi M5632, and the
      new Linux-USB Ethernet/RNDIS gadget.

    - Supports CDC Ethernet.  2.6 doesn't use CDCEther, and this
      probably supports some hardware that CDCEther won't.
    
    - The kernel config setup changed to match 2.6.  If in doubt, "y"
      for all the new options.  Among other things, this means that
      the ax8817x support is no longer invisible!

    - Disables the old "CDCEther.c" driver in Config.in; probably
      not the ideal solution, but it'll simplify testing.

    - Various chip-specific updates/fixes:  net1080 flushes fifos
      to recover after framing errors; ax8817x gets lots of ethtool
      support, including WOL, MII, and EEPROM access.

    - Cleanups, including using alloc_etherdev and ethtool_ops.
      Throttle down resubmit during temporary faults (and unplug).


--- 1.239/Documentation/Configure.help	Thu Apr  1 02:19:49 2004
+++ edited/Documentation/Configure.help	Mon Apr 12 08:16:38 2004
@@ -15847,24 +15847,35 @@
   The module will be called dabusb.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-Host-to-Host USB networking
+Multi-purpose USB Networking Framework
 CONFIG_USB_USBNET
-  This driver supports network links over USB with USB "Network"
-  or "data transfer" cables, often used to network laptops to PCs.
-  Such cables have chips from suppliers such as Belkin/eTEK, GeneSys
-  (GeneLink), NetChip and Prolific. Intelligent USB devices could also
-  use this approach to provide Internet access, using standard USB
-  cabling. You can find these chips also on some motherboards with
-  USB PC2PC support.
-
-  These links will have names like "usb0", "usb1", etc.  They act
-  like two-node Ethernets, so you can use 802.1d Ethernet Bridging
-  (CONFIG_BRIDGE) to simplify your network routing.
-
-  This code is also available as a kernel module (code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called usbnet.o. If you want to compile it as a
-  module, say M here and read <file:Documentation/modules.txt>.
+  This driver supports several kinds of network links over USB,
+  with "minidrivers" built around a common network driver core.
+  
+  The USB host runs "usbnet", and the other end of the link might be:
+
+  - Another USB host, when using USB "network" or "data transfer"
+    cables.  These are often used to network laptops to PCs, like
+    "Laplink" parallel cables or some motherboards.  These rely
+    on specialized chips from many suppliers.
+
+  - An intelligent USB gadget, perhaps embedding a Linux system.
+    These include PDAs running Linux (iPaq, Yopy, Zaurus, and
+    others), and devices that interoperate using the standard
+    CDC-Ethernet specification (including many cable modems).
+
+  - Network adapter hardware (like those for 10/100 Ethernet) which
+    uses this driver framework.
+
+  The link will appear with a name like "usb0", when the link is
+  a two-node link, or "eth0" for most Ethernet devices.  Those
+  two-node links are most easily managed with Ethernet Bridging
+  (CONFIG_BRIDGE) instead of routing.
+
+  For more information see <http://www.linux-usb.org/usbnet/>.
+
+  To compile this driver as a module, choose M here: the
+  module will be called usbnet.
 
 Freecom USB/ATAPI Bridge support
 CONFIG_USB_STORAGE_FREECOM
--- 1.41/drivers/usb/Config.in	Mon Jan 19 04:42:57 2004
+++ edited/drivers/usb/Config.in	Mon Apr 12 08:16:38 2004
@@ -92,8 +92,24 @@
       dep_tristate '  USB Realtek RTL8150 based ethernet device support (EXPERIMENTAL)' CONFIG_USB_RTL8150 $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
       dep_tristate '  USB KLSI KL5USB101-based ethernet device support (EXPERIMENTAL)' CONFIG_USB_KAWETH $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
       dep_tristate '  USB CATC NetMate-based Ethernet device support (EXPERIMENTAL)' CONFIG_USB_CATC $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
-      dep_tristate '  USB Communication Class Ethernet device support (EXPERIMENTAL)' CONFIG_USB_CDCETHER $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
-      dep_tristate '  USB-to-USB Networking cables, Linux PDAs, ... (EXPERIMENTAL)' CONFIG_USB_USBNET $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
+      # dep_tristate '  USB Communication Class Ethernet device support (EXPERIMENTAL)' CONFIG_USB_CDCETHER $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
+      dep_tristate '  Multi-purpose USB Networking Framework (EXPERIMENTAL)' CONFIG_USB_USBNET $CONFIG_USB $CONFIG_NET $CONFIG_EXPERIMENTAL
+      if [ "$CONFIG_USB_USBNET" = "y" -o "$CONFIG_USB_USBNET" = "m" ]; then
+	comment '   Host-to-Host cables'
+	bool    '    ALi M5632 USB 2.0' CONFIG_USB_ALI_5632
+	bool    '    AnchorChips 2720' CONFIG_USB_AN2720
+	bool    '    Belkin/ETek' CONFIG_USB_BELKIN
+	bool    '    GeneSys GL620USB-A' CONFIG_USB_GENESYS
+	bool    '    NetChip 1080' CONFIG_USB_NET1080
+	bool    '    Prolific PL-2301/2302' CONFIG_USB_PL2301
+	comment '   Embedded firmware'
+	bool    '    ARM (and other) embedded Linux' CONFIG_USB_ARMLINUX
+	bool    '    CDC Ethernet' CONFIG_USB_CDCETHER
+	bool    '    EPSON sample firmware' CONFIG_USB_EPSON2888
+	bool    '    Sharp Zaurus (many models)' CONFIG_USB_ZAURUS
+	comment '   Ethernet Adapters'
+	bool    '    ASIX AX8817X based USB 2.0' CONFIG_USB_AX8817X
+     fi
    fi
 
    comment 'USB port drivers'
--- 1.27/drivers/usb/usbnet.c	Thu Oct 23 08:02:44 2003
+++ edited/drivers/usb/usbnet.c	Mon Apr 12 08:16:38 2004
@@ -1,7 +1,9 @@
 /*
- * USB Host-to-Host Links
- * Copyright (C) 2000-2002 by David Brownell <dbrownell@users.sourceforge.net>
+ * USB Networking Links
+ * Copyright (C) 2000-2003 by David Brownell <dbrownell@users.sourceforge.net>
  * Copyright (C) 2002 Pavel Machek <pavel@ucw.cz>
+ * Copyright (C) 2003 David Hollis <dhollis@davehollis.com>
+ * Copyright (c) 2002-2003 TiVo Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,63 +21,38 @@
  */
 
 /*
- * This is used for "USB networking", connecting USB hosts as peers.
- *
- * It can be used with USB "network cables", for IP-over-USB communications;
- * Ethernet speeds without the Ethernet.  USB devices (including some PDAs)
- * can support such links directly, replacing device-specific protocols
- * with Internet standard ones.
- *
- * The links can be bridged using the Ethernet bridging (net/bridge)
- * support as appropriate.  Devices currently supported include:
+ * This is a generic "USB networking" framework that works with several
+ * kinds of full and high speed networking devices:
  *
+ *   + USB host-to-host "network cables", used for IP-over-USB links.
+ *     These are often used for Laplink style connectivity products.
  *	- AnchorChip 2720
  *	- Belkin, eTEK (interops with Win32 drivers)
- *	- EPSON USB clients
  *	- GeneSys GL620USB-A
  *	- NetChip 1080 (interoperates with NetChip Win32 drivers)
  *	- Prolific PL-2301/2302 (replaces "plusb" driver)
- *	- PXA-250 or SA-1100 Linux PDAs like iPAQ, Yopy, and Zaurus
+ *
+ *   + Smart USB devices can support such links directly, using Internet
+ *     standard protocols instead of proprietary host-to-device links.
+ *	- Linux PDAs like iPaq, Yopy, and Zaurus
+ *	- The BLOB boot loader (for diskless booting)
+ *	- Linux "gadgets", perhaps using PXA-2xx or Net2280 controllers
+ *	- Devices using EPSON's sample USB firmware
+ *	- CDC-Ethernet class devices, such as many cable modems
+ *
+ *   + Adapters to networks such as Ethernet.
+ *	- AX8817X based USB 2.0 products
+ *
+ * Links to these devices can be bridged using Linux Ethernet bridging.
+ * With minor exceptions, these all use similar USB framing for network
+ * traffic, but need different protocols for control traffic.
  *
  * USB devices can implement their side of this protocol at the cost
  * of two bulk endpoints; it's not restricted to "cable" applications.
  * See the SA1110, Zaurus, or EPSON device/client support in this driver;
- * slave/target drivers such as "usb-eth" (on most SA-1100 PDAs) are
- * used inside USB slave/target devices.
- *
- * 
- * Status:
- *
- * - AN2720 ... not widely available, but reportedly works well
- *
- * - Belkin/eTEK ... no known issues
- *
- * - Both GeneSys and PL-230x use interrupt transfers for driver-to-driver
- *   handshaking; it'd be worth implementing those as "carrier detect".
- *   Prefer generic hooks, not minidriver-specific hacks.
- *
- * - For Netchip, should use keventd to poll via control requests to detect
- *   hardware level "carrier detect". 
- *
- * - PL-230x ... the initialization protocol doesn't seem to match chip data
- *   sheets, sometimes it's not needed and sometimes it hangs.  Prolific has
- *   not responded to repeated support/information requests.
- *
- * - SA-1100 PDAs ... the standard ARM Linux SA-1100 support works nicely,
- *   as found in www.handhelds.org and other kernels.  The Sharp/Lineo
- *   kernels use different drivers, which also talk to this code.
- *
- * Interop with more Win32 drivers may be a good thing.
- *
- * Seems like reporting "peer connected" (carrier present) events may end
- * up going through the netlink event system, not hotplug ... so new links
- * would likely be handled with a link monitoring thread in some daemon.
- *
- * There are reports that bridging gives lower-than-usual throughput.
- *
- * Need smarter hotplug policy scripts ... ones that know how to arrange
- * bridging with "brctl", and can handle static and dynamic ("pump") setups.
- * Use those eventual "peer connected" events, and zeroconf.
+ * slave/target drivers such as "usb-eth" (on most SA-1100 PDAs) or
+ * "g_ether" (in the Linux "gadget" framework) implement that behavior
+ * within devices.
  *
  *
  * CHANGELOG:
@@ -118,12 +95,24 @@
  *		for USB 2.0 TTs) and memory shortages (potential) too. (db)
  *		Use "locally assigned" IEEE802 address space. (Brad Hards)
  * 18-oct-2002	Support for Zaurus (Pavel Machek), related cleanup (db).
- * 15-dec-2002	Partial sync with 2.5 code: cleanups and stubbed PXA-250
- * 		support (db), fix for framing issues on Z, net1080, and
- * 		gl620a (Toby Milne)
+ * 14-dec-2002	Remove Zaurus-private crc32 code (Pavel); 2.5 oops fix,
+ * 		cleanups and stubbed PXA-250 support (db), fix for framing
+ * 		issues on Z, net1080, and gl620a (Toby Milne)
+ *
+ * 31-mar-2003	Use endpoint descriptors:  high speed support, simpler sa1100
+ * 		vs pxa25x, and CDC Ethernet.  Throttle down log floods on
+ * 		disconnect; other cleanups. (db)  Flush net1080 fifos
+ * 		after several sequential framing errors. (Johannes Erdfelt)
+ * 22-aug-2003	AX8817X support (Dave Hollis).
+ *
+ * 12-apr-2004	Resync 2.4.26 with 2.6.6:  CDC Ethernet, C-860, M5632;
+ * 		alloc_etherdev, ethool_ops, net1080 flushes, ax8817x updates;
+ * 		cleanups, throttling, ether/rndis gadget.
  *
  *-------------------------------------------------------------------------*/
 
+// #define	DEBUG 	1
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kmod.h>
@@ -147,28 +136,18 @@
 #endif
 #include <linux/usb.h>
 
-/* in 2.5 these standard usb ops take mem_flags */
-#define ALLOC_URB(n,flags)	usb_alloc_urb(n)
-#define SUBMIT_URB(u,flags)	usb_submit_urb(u)
-
-/* and these got renamed (may move to usb.h) */
-#define usb_get_dev		usb_inc_dev_use
-#define usb_put_dev		usb_dec_dev_use
-
-
-/* minidrivers _could_ be individually configured */
-#define	CONFIG_USB_AN2720
-#define	CONFIG_USB_AX8817X
-#define	CONFIG_USB_BELKIN
-#define	CONFIG_USB_EPSON2888
-#define	CONFIG_USB_GENESYS
-#define	CONFIG_USB_NET1080
-#define	CONFIG_USB_PL2301
-#define	CONFIG_USB_ARMLINUX
-#define	CONFIG_USB_ZAURUS
+#define USB_DT_CS_INTERFACE	0x24
 
+/* in 2.6 these changed ... */
+#define usb_alloc_urb(n,flags)	usb_alloc_urb(n)
+#define usb_submit_urb(u,flags)	usb_submit_urb(u)
+#define usb_get_dev(udev)	({ usb_inc_dev_use(udev); udev; })
+#define usb_put_dev(udev)	usb_dec_dev_use(udev)
+#define usb_set_intfdata(intf,val) ((void)((intf)->private_data = val))
+#define URB_ASYNC_UNLINK	USB_ASYNC_UNLINK;
 
-#define DRIVER_VERSION		"18-Oct-2002"
+
+#define DRIVER_VERSION		"12-Apr-2003/2.4"
 
 /*-------------------------------------------------------------------------*/
 
@@ -180,11 +159,11 @@
  * Ethernet packets (so queues should be bigger).
  */
 #ifdef REALLY_QUEUE
-#define	RX_QLEN		4
-#define	TX_QLEN		4
+#define	RX_QLEN(dev) (((dev)->udev->speed == USB_SPEED_HIGH) ? 60 : 4)
+#define	TX_QLEN(dev) (((dev)->udev->speed == USB_SPEED_HIGH) ? 60 : 4)
 #else
-#define	RX_QLEN		1
-#define	TX_QLEN		1
+#define	RX_QLEN(dev)		1
+#define	TX_QLEN(dev)		1
 #endif
 
 // packets are always ethernet inside
@@ -195,6 +174,10 @@
 // reawaken network queue this soon after stopping; else watchdog barks
 #define TX_TIMEOUT_JIFFIES	(5*HZ)
 
+// throttle rx/tx briefly after some faults, so khubd might disconnect()
+// us (it polls at HZ/4 usually) before we report too many false errors.
+#define THROTTLE_JIFFIES	(HZ/8)
+
 // for vendor-specific control operations
 #define	CONTROL_TIMEOUT_MS	(500)			/* msec */
 #define CONTROL_TIMEOUT_JIFFIES ((CONTROL_TIMEOUT_MS * HZ)/1000)
@@ -204,10 +187,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-// list of all devices we manage
-static DECLARE_MUTEX (usbnet_mutex);
-static LIST_HEAD (usbnet_list);
-
 // randomly generated ethernet address
 static u8	node_id [ETH_ALEN];
 
@@ -216,24 +195,20 @@
 	// housekeeping
 	struct usb_device	*udev;
 	struct driver_info	*driver_info;
-	struct semaphore	mutex;
-	struct list_head	dev_list;
 	wait_queue_head_t	*wait;
 
 	// i/o info: pipes etc
 	unsigned		in, out;
 	unsigned		maxpacket;
-	//struct timer_list	delay;
+	struct timer_list	delay;
 
 	// protocol/interface state
-	struct net_device	net;
+	struct net_device	*net;
 	struct net_device_stats	stats;
 	int			msg_level;
-	struct mii_if_info	mii;
+	unsigned long		data [5];
 
-#ifdef CONFIG_USB_NET1080
-	u16			packet_id;
-#endif
+	struct mii_if_info	mii;
 
 	// various kinds of pending driver work
 	struct sk_buff_head	rxq;
@@ -253,14 +228,20 @@
 	char		*description;
 
 	int		flags;
+/* framing is CDC Ethernet, not writing ZLPs (hw issues), or optionally: */
 #define FLAG_FRAMING_NC	0x0001		/* guard against device dropouts */ 
 #define FLAG_FRAMING_GL	0x0002		/* genelink batches packets */
 #define FLAG_FRAMING_Z	0x0004		/* zaurus adds a trailer */
+#define FLAG_FRAMING_RN	0x0008		/* RNDIS batches, plus huge header */
+
 #define FLAG_NO_SETINT	0x0010		/* device can't set_interface() */
 #define FLAG_ETHER	0x0020		/* maybe use "eth%d" names */
 
 	/* init device ... can sleep, or cause probe() failure */
-	int	(*bind)(struct usbnet *, struct usb_device *);
+	int	(*bind)(struct usbnet *, struct usb_interface *);
+
+	/* cleanup device ... can sleep, but can't fail */
+	void	(*unbind)(struct usbnet *, struct usb_interface *);
 
 	/* reset device ... can sleep */
 	int	(*reset)(struct usbnet *);
@@ -277,11 +258,11 @@
 
 	// FIXME -- also an interrupt mechanism
 	// useful for at least PL2301/2302 and GL620USB-A
+	// and CDC; use them to report 'is it connected' changes
 
 	/* for new devices, use the descriptor-reading code instead */
 	int		in;		/* rx endpoint */
 	int		out;		/* tx endpoint */
-	int		epsize;
 
 	unsigned long	data;		/* Misc driver specific data */
 };
@@ -308,22 +289,39 @@
 MODULE_PARM_DESC (msg_level, "Initial message level (default = 1)");
 
 
-#define	mutex_lock(x)	down(x)
-#define	mutex_unlock(x)	up(x)
-
 #define	RUN_CONTEXT (in_irq () ? "in_irq" \
 			: (in_interrupt () ? "in_interrupt" : "can sleep"))
 
-static struct ethtool_ops usbnet_ethtool_ops;
+#ifdef DEBUG
+#define devdbg(usbnet, fmt, arg...) \
+	printk(KERN_DEBUG "%s: " fmt "\n" , (usbnet)->net->name , ## arg)
+#else
+#define devdbg(usbnet, fmt, arg...) do {} while(0)
+#endif
+
+#define deverr(usbnet, fmt, arg...) \
+	printk(KERN_ERR "%s: " fmt "\n" , (usbnet)->net->name , ## arg)
+#define devwarn(usbnet, fmt, arg...) \
+	printk(KERN_WARNING "%s: " fmt "\n" , (usbnet)->net->name , ## arg)
+
+#define devinfo(usbnet, fmt, arg...) \
+	do { if ((usbnet)->msg_level >= 1) \
+	printk(KERN_INFO "%s: " fmt "\n" , (usbnet)->net->name , ## arg); \
+	} while (0)
+
+/*-------------------------------------------------------------------------*/
 
-/* mostly for PDA style devices, which are always present */
+static void usbnet_get_drvinfo (struct net_device *, struct ethtool_drvinfo *);
+static u32 usbnet_get_link (struct net_device *);
+static u32 usbnet_get_msglevel (struct net_device *);
+static void usbnet_set_msglevel (struct net_device *, u32);
+
+/* mostly for PDA style devices, which are always connected if present */
 static int always_connected (struct usbnet *dev)
 {
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-
 /* handles CDC Ethernet and many other network "bulk data" interfaces */
 static int
 get_endpoints (struct usbnet *dev, struct usb_interface *intf)
@@ -377,22 +375,45 @@
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
+static void skb_return (struct usbnet *dev, struct sk_buff *skb)
+{
+	int	status;
 
-#ifdef DEBUG
-#define devdbg(usbnet, fmt, arg...) \
-	printk(KERN_DEBUG "%s: " fmt "\n" , (usbnet)->net.name , ## arg)
-#else
-#define devdbg(usbnet, fmt, arg...) do {} while(0)
+	skb->dev = dev->net;
+	skb->protocol = eth_type_trans (skb, dev->net);
+	dev->stats.rx_packets++;
+	dev->stats.rx_bytes += skb->len;
+
+#ifdef	VERBOSE
+	devdbg (dev, "< rx, len %d, type 0x%x",
+		skb->len + sizeof (struct ethhdr), skb->protocol);
 #endif
+	memset (skb->cb, 0, sizeof (struct skb_data));
+	status = netif_rx (skb);
+	if (status != NET_RX_SUCCESS)
+		devdbg (dev, "netif_rx status %d", status);
+}
+
+
+#ifdef	CONFIG_USB_ALI_M5632
+#define	HAVE_HARDWARE
+
+/*-------------------------------------------------------------------------
+ *
+ * ALi M5632 driver ... does high speed
+ *
+ *-------------------------------------------------------------------------*/
+
+static const struct driver_info	ali_m5632_info = {
+	.description =	"ALi M5632",
+};
 
-#define devinfo(usbnet, fmt, arg...) \
-	do { if ((usbnet)->msg_level >= 1) \
-	printk(KERN_INFO "%s: " fmt "\n" , (usbnet)->net.name , ## arg); \
-	} while (0)
+
+#endif
 
 
 #ifdef	CONFIG_USB_AN2720
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
@@ -411,7 +432,6 @@
 	// no check_connect available!
 
 	.in = 2, .out = 2,		// direction distinguishes these
-	.epsize =64,
 };
 
 #endif	/* CONFIG_USB_AN2720 */
@@ -429,6 +449,8 @@
 #define AX_CMD_READ_MII_REG		0x07
 #define AX_CMD_WRITE_MII_REG		0x08
 #define AX_CMD_SET_HW_MII		0x0a
+#define AX_CMD_READ_EEPROM		0x0b
+#define AX_CMD_WRITE_EEPROM		0x0c
 #define AX_CMD_WRITE_RX_CTL		0x10
 #define AX_CMD_READ_IPG012		0x11
 #define AX_CMD_WRITE_IPG0		0x12
@@ -438,8 +460,15 @@
 #define AX_CMD_READ_NODE_ID		0x17
 #define AX_CMD_READ_PHY_ID		0x19
 #define AX_CMD_WRITE_MEDIUM_MODE	0x1b
+#define AX_CMD_READ_MONITOR_MODE	0x1c
+#define AX_CMD_WRITE_MONITOR_MODE	0x1d
 #define AX_CMD_WRITE_GPIOS		0x1f
 
+#define AX_MONITOR_MODE			0x01
+#define AX_MONITOR_LINK			0x02
+#define AX_MONITOR_MAGIC		0x04
+#define AX_MONITOR_HSFS			0x10
+
 #define AX_MCAST_FILTER_SIZE		8
 #define AX_MAX_MCAST			64
 
@@ -492,13 +521,13 @@
 	int status;
 	struct urb *urb;
 
-	if ((urb = ALLOC_URB(0, GFP_ATOMIC)) == NULL) {
+	if ((urb = usb_alloc_urb(0, GFP_ATOMIC)) == NULL) {
 		devdbg(dev, "Error allocating URB in write_cmd_async!");
 		return;
 	}
 
 	if ((req = kmalloc(sizeof(struct usb_ctrlrequest), GFP_ATOMIC)) == NULL) {
-		devdbg(dev, "Failed to allocate memory for control request");
+		deverr(dev, "Failed to allocate memory for control request");
 		usb_free_urb(urb);
 		return;
 	}
@@ -514,8 +543,11 @@
 			     (void *)req, data, size,
 			     ax8817x_async_cmd_callback, req);
 
-	if((status = SUBMIT_URB(urb, GFP_ATOMIC)) < 0)
-		devdbg(dev, "Error submitting the control message: status=%d", status);
+	if((status = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
+		deverr(dev, "Error submitting the control message: status=%d", status);
+		kfree(req);
+		usb_free_urb(urb);
+	}
 }
 
 static void ax8817x_set_multicast(struct net_device *net)
@@ -531,34 +563,31 @@
 	} else if (net->mc_count == 0) {
 		/* just broadcast and directed */
 	} else {
+		/* We use the 20 byte dev->data
+		 * for our 8 byte filter buffer
+		 * to avoid allocating memory that
+		 * is tricky to free later */
+		u8 *multi_filter = (u8 *)&dev->data;
 		struct dev_mc_list *mc_list = net->mc_list;
-		u8 *multi_filter;
 		u32 crc_bits;
 		int i;
 
-		multi_filter = kmalloc(AX_MCAST_FILTER_SIZE, GFP_ATOMIC);
-		if (multi_filter == NULL) {
-			/* Oops, couldn't allocate a buffer for setting the multicast
-			   filter. Try all multi mode. */
-			rx_ctl |= 0x02;
-		} else {
-			memset(multi_filter, 0, AX_MCAST_FILTER_SIZE);
-
-			/* Build the multicast hash filter. */
-			for (i = 0; i < net->mc_count; i++) {
-				crc_bits =
-				    ether_crc(ETH_ALEN,
-					      mc_list->dmi_addr) >> 26;
-				multi_filter[crc_bits >> 3] |=
-				    1 << (crc_bits & 7);
-				mc_list = mc_list->next;
-			}
-
-			ax8817x_write_cmd_async(dev, AX_CMD_WRITE_MULTI_FILTER, 0, 0,
-					   AX_MCAST_FILTER_SIZE, multi_filter);
+		memset(multi_filter, 0, AX_MCAST_FILTER_SIZE);
 
-			rx_ctl |= 0x10;
+		/* Build the multicast hash filter. */
+		for (i = 0; i < net->mc_count; i++) {
+			crc_bits =
+			    ether_crc(ETH_ALEN,
+				      mc_list->dmi_addr) >> 26;
+			multi_filter[crc_bits >> 3] |=
+			    1 << (crc_bits & 7);
+			mc_list = mc_list->next;
 		}
+
+		ax8817x_write_cmd_async(dev, AX_CMD_WRITE_MULTI_FILTER, 0, 0,
+				   AX_MCAST_FILTER_SIZE, multi_filter);
+
+		rx_ctl |= 0x10;
 	}
 
 	ax8817x_write_cmd_async(dev, AX_CMD_WRITE_RX_CTL, rx_ctl, 0, 0, NULL);
@@ -568,7 +597,7 @@
 {
 	struct usbnet *dev = netdev->priv;
 	u16 res;
-	u8 buf[4];
+	u8 buf[1];
 
 	ax8817x_write_cmd(dev, AX_CMD_SET_SW_MII, 0, 0, 0, &buf);
 	ax8817x_read_cmd(dev, AX_CMD_READ_MII_REG, phy_id, (__u16)loc, 2, (u16 *)&res);
@@ -581,14 +610,120 @@
 {
 	struct usbnet *dev = netdev->priv;
 	u16 res = val;
-	u8 buf[4];
+	u8 buf[1];
 
 	ax8817x_write_cmd(dev, AX_CMD_SET_SW_MII, 0, 0, 0, &buf);
 	ax8817x_write_cmd(dev, AX_CMD_WRITE_MII_REG, phy_id, (__u16)loc, 2, (u16 *)&res);
 	ax8817x_write_cmd(dev, AX_CMD_SET_HW_MII, 0, 0, 0, &buf);
 }
 
-static int ax8817x_bind(struct usbnet *dev, struct usb_device *intf)
+void ax8817x_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
+{
+	struct usbnet *dev = (struct usbnet *)net->priv;
+	u8 opt;
+
+	if (ax8817x_read_cmd(dev, AX_CMD_READ_MONITOR_MODE, 0, 0, 1, &opt) < 0) {
+		wolinfo->supported = 0;
+		wolinfo->wolopts = 0;
+		return;
+	}
+	wolinfo->supported = WAKE_PHY | WAKE_MAGIC;
+	wolinfo->wolopts = 0;
+	if (opt & AX_MONITOR_MODE) {
+		if (opt & AX_MONITOR_LINK)
+			wolinfo->wolopts |= WAKE_PHY;
+		if (opt & AX_MONITOR_MAGIC)
+			wolinfo->wolopts |= WAKE_MAGIC;
+	}
+}
+
+int ax8817x_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
+{
+	struct usbnet *dev = (struct usbnet *)net->priv;
+	u8 opt = 0;
+	u8 buf[1];
+
+	if (wolinfo->wolopts & WAKE_PHY)
+		opt |= AX_MONITOR_LINK;
+	if (wolinfo->wolopts & WAKE_MAGIC)
+		opt |= AX_MONITOR_MAGIC;
+	if (opt != 0)
+		opt |= AX_MONITOR_MODE;
+
+	if (ax8817x_write_cmd(dev, AX_CMD_WRITE_MONITOR_MODE,
+			      opt, 0, 0, &buf) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int ax8817x_get_eeprom(struct net_device *net, 
+		       struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct usbnet *dev = (struct usbnet *)net->priv;
+	u16 *ebuf = (u16 *)data;
+	int i;
+
+	/* Crude hack to ensure that we don't overwrite memory
+	 * if an odd length is supplied
+	 */
+	if (eeprom->len % 2)
+		return -EINVAL;
+
+	/* ax8817x returns 2 bytes from eeprom on read */
+	for (i=0; i < eeprom->len / 2; i++) {
+		if (ax8817x_read_cmd(dev, AX_CMD_READ_EEPROM, 
+			eeprom->offset + i, 0, 2, &ebuf[i]) < 0)
+			return -EINVAL;
+	}
+	return i * 2;
+}
+
+static void ax8817x_get_drvinfo (struct net_device *net,
+				 struct ethtool_drvinfo *info)
+{
+	/* Inherit standard device info */
+	usbnet_get_drvinfo(net, info);
+	info->eedump_len = 0x3e;
+}
+
+static u32 ax8817x_get_link (struct net_device *net)
+{
+	struct usbnet *dev = (struct usbnet *)net->priv;
+
+	return (u32)mii_link_ok(&dev->mii);
+}
+
+static int ax8817x_get_settings(struct net_device *net, struct ethtool_cmd *cmd)
+{
+	struct usbnet *dev = (struct usbnet *)net->priv;
+
+	return mii_ethtool_gset(&dev->mii,cmd);
+}
+
+static int ax8817x_set_settings(struct net_device *net, struct ethtool_cmd *cmd)
+{
+	struct usbnet *dev = (struct usbnet *)net->priv;
+
+	return mii_ethtool_sset(&dev->mii,cmd);
+}
+
+/* We need to override some ethtool_ops so we require our
+   own structure so we don't interfere with other usbnet
+   devices that may be connected at the same time. */
+static struct ethtool_ops ax8817x_ethtool_ops = {
+	.get_drvinfo		= ax8817x_get_drvinfo,
+	.get_link		= ax8817x_get_link,
+	.get_msglevel		= usbnet_get_msglevel,
+	.set_msglevel		= usbnet_set_msglevel,
+	.get_wol		= ax8817x_get_wol,
+	.set_wol		= ax8817x_set_wol,
+	.get_eeprom		= ax8817x_get_eeprom,
+	.get_settings		= ax8817x_get_settings,
+	.set_settings		= ax8817x_set_settings,
+};
+
+static int ax8817x_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int ret;
 	u8 buf[6];
@@ -602,12 +737,12 @@
 	/* Toggle the GPIOs in a manufacturer/model specific way */
 	for (i = 2; i >= 0; i--) {
 		if ((ret = ax8817x_write_cmd(dev, AX_CMD_WRITE_GPIOS,
-				       (gpio_bits >> (i * 8)) & 0xff, 0, 0,
-				       buf)) < 0)
+					(gpio_bits >> (i * 8)) & 0xff, 0, 0,
+					buf)) < 0)
 			return ret;
 		wait_ms(5);
-        }
-                                                                                
+	}
+
 	if ((ret = ax8817x_write_cmd(dev, AX_CMD_WRITE_RX_CTL, 0x80, 0, 0, buf)) < 0) {
 		dbg("send AX_CMD_WRITE_RX_CTL failed: %d", ret);
 		return ret;
@@ -619,17 +754,7 @@
 		dbg("read AX_CMD_READ_NODE_ID failed: %d", ret);
 		return ret;
 	}
-	memcpy(dev->net.dev_addr, buf, ETH_ALEN);
-
-	/* Get IPG values */
-	if ((ret = ax8817x_read_cmd(dev, AX_CMD_READ_IPG012, 0, 0, 3, buf)) < 0) {
-		dbg("Error reading IPG values: %d", ret);
-		return ret;
-	}
-
-	for(i = 0;i < 3;i++) {
-		ax8817x_write_cmd(dev, AX_CMD_WRITE_IPG0 + i, 0, 0, 1, &buf[i]);
-	}
+	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
 
 	/* Get the PHY id */
 	if ((ret = ax8817x_read_cmd(dev, AX_CMD_READ_PHY_ID, 0, 0, 2, buf)) < 0) {
@@ -642,7 +767,7 @@
 	}
 
 	/* Initialize MII structure */
-	dev->mii.dev = &dev->net;
+	dev->mii.dev = dev->net;
 	dev->mii.mdio_read = ax8817x_mdio_read;
 	dev->mii.mdio_write = ax8817x_mdio_write;
 	dev->mii.phy_id_mask = 0x3f;
@@ -683,7 +808,8 @@
 		return ret;
 	}
 
-	dev->net.set_multicast_list = ax8817x_set_multicast;
+	dev->net->set_multicast_list = ax8817x_set_multicast;
+	dev->net->ethtool_ops = &ax8817x_ethtool_ops;
 
 	return 0;
 }
@@ -715,10 +841,13 @@
 	.flags =  FLAG_ETHER,
 	.data = 0x001f1d1f,
 };
+
 #endif /* CONFIG_USB_AX8817X */
 
+
 
 #ifdef	CONFIG_USB_BELKIN
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
@@ -736,7 +865,333 @@
 
 
 
+/*-------------------------------------------------------------------------
+ *
+ * Communications Device Class declarations.
+ * Used by CDC Ethernet, and some CDC variants
+ *
+ *-------------------------------------------------------------------------*/
+
+#ifdef	CONFIG_USB_CDCETHER
+#define NEED_GENERIC_CDC
+#endif
+
+#ifdef	CONFIG_USB_ZAURUS
+/* Ethernet variant uses funky framing, broken ethernet addressing */
+#define NEED_GENERIC_CDC
+#endif
+
+#ifdef	CONFIG_USB_RNDIS
+/* ACM variant uses even funkier framing, complex control RPC scheme */
+#define NEED_GENERIC_CDC
+#endif
+
+
+#ifdef	NEED_GENERIC_CDC
+
+/* "Header Functional Descriptor" from CDC spec  5.2.3.1 */
+struct header_desc {
+	u8	bLength;
+	u8	bDescriptorType;
+	u8	bDescriptorSubType;
+
+	u16	bcdCDC;
+} __attribute__ ((packed));
+
+/* "Union Functional Descriptor" from CDC spec 5.2.3.X */
+struct union_desc {
+	u8	bLength;
+	u8	bDescriptorType;
+	u8	bDescriptorSubType;
+
+	u8	bMasterInterface0;
+	u8	bSlaveInterface0;
+	/* ... and there could be other slave interfaces */
+} __attribute__ ((packed));
+
+/* "Ethernet Networking Functional Descriptor" from CDC spec 5.2.3.16 */
+struct ether_desc {
+	u8	bLength;
+	u8	bDescriptorType;
+	u8	bDescriptorSubType;
+
+	u8	iMACAddress;
+	u32	bmEthernetStatistics;
+	u16	wMaxSegmentSize;
+	u16	wNumberMCFilters;
+	u8	bNumberPowerFilters;
+} __attribute__ ((packed));
+
+struct cdc_state {
+	struct header_desc	*header;
+	struct union_desc	*u;
+	struct ether_desc	*ether;
+	struct usb_interface	*control;
+	struct usb_interface	*data;
+};
+
+static struct usb_driver usbnet_driver;
+
+/*
+ * probes control interface, claims data interface, collects the bulk
+ * endpoints, activates data interface (if needed), maybe sets MTU.
+ * all pure cdc, except for certain firmware workarounds.
+ */
+static int generic_cdc_bind (struct usbnet *dev, struct usb_interface *intf)
+{
+	u8				*buf = intf->altsetting->extra;
+	int				len = intf->altsetting->extralen;
+	struct usb_interface_descriptor	*d;
+	struct cdc_state		*info = (void *) &dev->data;
+	int				status;
+	int				rndis;
+
+	if (sizeof dev->data < sizeof *info)
+		return -EDOM;
+
+	/* expect strict spec conformance for the descriptors, but
+	 * cope with firmware which stores them in the wrong place
+	 */
+	if (len == 0 && dev->udev->actconfig->extralen) {
+		/* Motorola SB4100 (and others: Brad Hards says it's
+		 * from a Broadcom design) put CDC descriptors here
+		 */
+		buf = dev->udev->actconfig->extra;
+		len = dev->udev->actconfig->extralen;
+		if (len)
+			pr_debug ("CDC descriptors on config\n");
+	}
+
+	/* this assumes that if there's a non-RNDIS vendor variant
+	 * of cdc-acm, it'll fail RNDIS requests cleanly.
+	 */
+	rndis = (intf->altsetting->bInterfaceProtocol == 0xff);
+
+	memset (info, 0, sizeof *info);
+	info->control = intf;
+	while (len > 3) {
+		if (buf [1] != USB_DT_CS_INTERFACE)
+			goto next_desc;
+
+		/* use bDescriptorSubType to identify the CDC descriptors.
+		 * We expect devices with CDC header and union descriptors.
+		 * For CDC Ethernet we need the ethernet descriptor.
+		 * For RNDIS, ignore two (pointless) CDC modem descriptors
+		 * in favor of a complicated OID-based RPC scheme doing what
+		 * CDC Ethernet achieves more simply.
+		 */
+		switch (buf [2]) {
+		case 0x00:		/* Header, mostly useless */
+			if (info->header) {
+				pr_debug("extra CDC header\n");
+				goto bad_desc;
+			}
+			info->header = (void *) buf;
+			if (info->header->bLength != sizeof *info->header) {
+				pr_debug("CDC header len %u\n",
+					info->header->bLength);
+				goto bad_desc;
+			}
+			break;
+		case 0x06:		/* Union (groups interfaces) */
+			if (info->u) {
+				pr_debug("extra CDC union\n");
+				goto bad_desc;
+			}
+			info->u = (void *) buf;
+			if (info->u->bLength != sizeof *info->u) {
+				pr_debug("CDC union len %u\n",
+					info->u->bLength);
+				goto bad_desc;
+			}
+
+			/* we need a master/control interface (what we're
+			 * probed with) and a slave/data interface; union
+			 * descriptors sort this all out.
+			 */
+			info->control = usb_ifnum_to_if(dev->udev,
+						info->u->bMasterInterface0);
+			info->data = usb_ifnum_to_if(dev->udev,
+						info->u->bSlaveInterface0);
+			if (!info->control || !info->data) {
+				pr_debug("master #%u/%p slave #%u/%p\n",
+					info->u->bMasterInterface0,
+					info->control,
+					info->u->bSlaveInterface0,
+					info->data);
+				goto bad_desc;
+			}
+			if (info->control != intf) {
+				pr_debug("bogus CDC Union\n");
+				/* Ambit USB Cable Modem (and maybe others)
+				 * interchanges master and slave interface.
+				 */
+				if (info->data == intf) {
+					info->data = info->control;
+					info->control = intf;
+				} else
+					goto bad_desc;
+			}
+
+			/* a data interface altsetting does the real i/o */
+			d = info->data->altsetting;
+			if (d->bInterfaceClass != USB_CLASS_CDC_DATA) {
+				pr_debug("slave class %u\n",
+					d->bInterfaceClass);
+				goto bad_desc;
+			}
+			break;
+		case 0x0F:		/* Ethernet Networking */
+			if (info->ether) {
+				pr_debug("extra CDC ether\n");
+				goto bad_desc;
+			}
+			info->ether = (void *) buf;
+			if (info->ether->bLength != sizeof *info->ether) {
+				pr_debug("CDC ether len %u\n",
+					info->u->bLength);
+				goto bad_desc;
+			}
+			dev->net->mtu = cpu_to_le16p (
+						&info->ether->wMaxSegmentSize)
+					- ETH_HLEN;
+			/* because of Zaurus, we may be ignoring the host
+			 * side link address we were given.
+			 */
+			break;
+		}
+next_desc:
+		len -= buf [0];	/* bLength */
+		buf += buf [0];
+	}
+
+	if (!info->header || !info->u || (!rndis && !info->ether)) {
+		pr_debug("missing cdc %s%s%sdescriptor\n",
+			info->header ? "" : "header ",
+			info->u ? "" : "union ",
+			info->ether ? "" : "ether ");
+		goto bad_desc;
+	}
+
+	/* claim data interface and set it up ... with side effects.
+	 * network traffic can't flow until an altsetting is enabled.
+	 */
+	if (usb_interface_claimed(info->data))
+		return -EBUSY;
+	usb_driver_claim_interface (&usbnet_driver, info->data, dev);
+	status = get_endpoints (dev, info->data);
+	if (status < 0) {
+		/* ensure immediate exit from usbnet_disconnect */
+		usb_set_intfdata(info->data, NULL);
+		usb_driver_release_interface (&usbnet_driver, info->data);
+		return status;
+	}
+	return 0;
+
+bad_desc:
+	pr_info("bad CDC descriptors\n");
+	return -ENODEV;
+}
+
+static void cdc_unbind (struct usbnet *dev, struct usb_interface *_intf)
+{
+	struct cdc_state		*info = (void *) &dev->data;
+
+	if (info->data) {
+		usb_set_intfdata(info->data, NULL);
+		usb_driver_release_interface (&usbnet_driver, info->data);
+		info->data = 0;
+	}
+
+	if (info->control) {
+		usb_set_intfdata(info->control, NULL);
+		usb_driver_release_interface (&usbnet_driver, info->control);
+		info->control = 0;
+	}
+}
+
+#endif	/* NEED_GENERIC_CDC */
+
+
+#ifdef	CONFIG_USB_CDCETHER
+#define	HAVE_HARDWARE
+
+/*-------------------------------------------------------------------------
+ *
+ * Communications Device Class, Ethernet Control model
+ * 
+ * Takes two interfaces.  The DATA interface is inactive till an altsetting
+ * is selected.  Configuration data includes class descriptors.
+ *
+ * This should interop with whatever the 2.4 "CDCEther.c" driver
+ * (by Brad Hards) talked with.
+ *
+ *-------------------------------------------------------------------------*/
+
+#include <linux/ctype.h>
+
+static u8 nibble (unsigned char c)
+{
+	if (likely (isdigit (c)))
+		return c - '0';
+	c = toupper (c);
+	if (likely (isxdigit (c)))
+		return 10 + c - 'A';
+	return 0;
+}
+
+static inline int
+get_ethernet_addr (struct usbnet *dev, struct ether_desc *e)
+{
+	int 		tmp, i;
+	unsigned char	buf [13];
+
+	tmp = usb_string (dev->udev, e->iMACAddress, buf, sizeof buf);
+	if (tmp < 0)
+		return tmp;
+	else if (tmp != 12)
+		return -EINVAL;
+	for (i = tmp = 0; i < 6; i++, tmp += 2)
+		dev->net->dev_addr [i] =
+			 (nibble (buf [tmp]) << 4) + nibble (buf [tmp + 1]);
+	return 0;
+}
+
+static int cdc_bind (struct usbnet *dev, struct usb_interface *intf)
+{
+	int				status;
+	struct cdc_state		*info = (void *) &dev->data;
+
+	status = generic_cdc_bind (dev, intf);
+	if (status < 0)
+		return status;
+
+	status = get_ethernet_addr (dev, info->ether);
+	if (status < 0) {
+		usb_driver_release_interface (&usbnet_driver, info->data);
+		return status;
+	}
+
+	/* FIXME cdc-ether has some multicast code too, though it complains
+	 * in routine cases.  info->ether describes the multicast support.
+	 */
+	return 0;
+}
+
+static const struct driver_info	cdc_info = {
+	.description =	"CDC Ethernet Device",
+	.flags =	FLAG_ETHER,
+	// .check_connect = cdc_check_connect,
+	.bind =		cdc_bind,
+	.unbind =	cdc_unbind,
+};
+
+#endif	/* CONFIG_USB_CDCETHER */
+
+
+
 #ifdef	CONFIG_USB_EPSON2888
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
@@ -747,6 +1202,8 @@
  * implements this interface.  Product developers can reuse or modify that
  * code, such as by using their own product and vendor codes.
  *
+ * Support was from Juro Bystricky <bystricky.juro@erd.epson.com>
+ *
  *-------------------------------------------------------------------------*/
 
 static const struct driver_info	epson2888_info = {
@@ -754,13 +1211,13 @@
 	.check_connect = always_connected,
 
 	.in = 4, .out = 3,
-	.epsize = 64,
 };
 
 #endif	/* CONFIG_USB_EPSON2888 */
 
 
 #ifdef CONFIG_USB_GENESYS
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
@@ -778,6 +1235,9 @@
  *    the transfer direction.  (That's disabled here, partially coded.)
  *    A control URB would block until other side writes an interrupt.
  *
+ * Original code from Jiun-Jie Huang <huangjj@genesyslogic.com.tw>
+ * and merged into "usbnet" by Stanislav Brabec <utx@penguin.cz>.
+ *
  *-------------------------------------------------------------------------*/
 
 // control msg write command
@@ -869,7 +1329,7 @@
 	// issue usb interrupt read
 	if (priv && priv->irq_urb) {
 		// submit urb
-		if ((retval = SUBMIT_URB (priv->irq_urb, GFP_KERNEL)) != 0)
+		if ((retval = usb_submit_urb (priv->irq_urb, GFP_KERNEL)) != 0)
 			dbg ("gl_interrupt_read: submit fail - %X...", retval);
 		else
 			dbg ("gl_interrupt_read: submit success...");
@@ -888,18 +1348,18 @@
 	// detect whether another side is connected
 	if ((retval = gl_control_write (dev, GENELINK_CONNECT_WRITE, 0)) != 0) {
 		dbg ("%s: genelink_check_connect write fail - %X",
-			dev->net.name, retval);
+			dev->net->name, retval);
 		return retval;
 	}
 
 	// usb interrupt read to ack another side 
 	if ((retval = gl_interrupt_read (dev)) != 0) {
 		dbg ("%s: genelink_check_connect read fail - %X",
-			dev->net.name, retval);
+			dev->net->name, retval);
 		return retval;
 	}
 
-	dbg ("%s: genelink_check_connect read success", dev->net.name);
+	dbg ("%s: genelink_check_connect read success", dev->net->name);
 	return 0;
 }
 
@@ -911,14 +1371,14 @@
 	// allocate the private data structure
 	if ((priv = kmalloc (sizeof *priv, GFP_KERNEL)) == 0) {
 		dbg ("%s: cannot allocate private data per device",
-			dev->net.name);
+			dev->net->name);
 		return -ENOMEM;
 	}
 
 	// allocate irq urb
-	if ((priv->irq_urb = ALLOC_URB (0, GFP_KERNEL)) == 0) {
+	if ((priv->irq_urb = usb_alloc_urb (0, GFP_KERNEL)) == 0) {
 		dbg ("%s: cannot allocate private irq urb per device",
-			dev->net.name);
+			dev->net->name);
 		kfree (priv);
 		return -ENOMEM;
 	}
@@ -967,7 +1427,6 @@
 	struct gl_header	*header;
 	struct gl_packet	*packet;
 	struct sk_buff		*gl_skb;
-	int			status;
 	u32			size;
 
 	header = (struct gl_header *) skb->data;
@@ -976,7 +1435,7 @@
 	le32_to_cpus (&header->packet_count);
 	if ((header->packet_count > GL_MAX_TRANSMIT_PACKETS)
 			|| (header->packet_count < 0)) {
-		dbg ("genelink: illegal received packet count %d",
+		dbg ("genelink: invalid received packet count %d",
 			header->packet_count);
 		return 0;
 	}
@@ -993,7 +1452,7 @@
 
 		// this may be a broken packet
 		if (size > GL_MAX_PACKET_LEN) {
-			dbg ("genelink: illegal rx length %d", size);
+			dbg ("genelink: invalid rx length %d", size);
 			return 0;
 		}
 
@@ -1002,21 +1461,8 @@
 		if (gl_skb) {
 
 			// copy the packet data to the new skb
-			memcpy (gl_skb->data, packet->packet_data, size);
-
-			// set skb data size
-			gl_skb->len = size;
-			gl_skb->dev = &dev->net;
-
-			// determine the packet's protocol ID
-			gl_skb->protocol = eth_type_trans (gl_skb, &dev->net);
-
-			// update the status
-			dev->stats.rx_packets++;
-			dev->stats.rx_bytes += size;
-
-			// notify os of the received packet
-			status = netif_rx (gl_skb);
+			memcpy(skb_put(gl_skb, size), packet->packet_data, size);
+			skb_return (dev, skb);
 		}
 
 		// advance to the next packet
@@ -1032,7 +1478,7 @@
 	skb_pull (skb, 4);
 
 	if (skb->len > GL_MAX_PACKET_LEN) {
-		dbg ("genelink: illegal rx length %d", skb->len);
+		dbg ("genelink: invalid rx length %d", skb->len);
 		return 0;
 	}
 	return 1;
@@ -1063,6 +1509,8 @@
 		skb2 = skb_copy_expand (skb, (4 + 4*1) , padlen, flags);
 		dev_kfree_skb_any (skb);
 		skb = skb2;
+		if (!skb)
+			return NULL;
 	}
 
 	// attach the packet count to the header
@@ -1087,7 +1535,6 @@
 	.tx_fixup =	genelink_tx_fixup,
 
 	.in = 1, .out = 2,
-	.epsize =64,
 
 #ifdef	GENELINK_ACK
 	.check_connect =genelink_check_connect,
@@ -1099,6 +1546,7 @@
 
 
 #ifdef	CONFIG_USB_NET1080
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
@@ -1107,6 +1555,9 @@
  *
  *-------------------------------------------------------------------------*/
 
+#define dev_packet_id	data[0]
+#define frame_errors	data[1]
+
 /*
  * NetChip framing of ethernet packets, supporting additional error
  * checks for links that may drop bulk packets from inside messages.
@@ -1222,7 +1673,7 @@
 		return;
 	}
 
-	dbg ("%s registers:", dev->net.name);
+	dbg ("%s registers:", dev->net->name);
 	for (reg = 0; reg < 0x20; reg++) {
 		int retval;
 
@@ -1235,10 +1686,10 @@
 		retval = nc_register_read (dev, reg, vp);
 		if (retval < 0)
 			dbg ("%s reg [0x%x] ==> error %d",
-				dev->net.name, reg, retval);
+				dev->net->name, reg, retval);
 		else
 			dbg ("%s reg [0x%x] = 0x%x",
-				dev->net.name, reg, *vp);
+				dev->net->name, reg, *vp);
 	}
 	kfree (vp);
 }
@@ -1374,7 +1825,7 @@
 	// nc_dump_registers (dev);
 
 	if ((retval = nc_register_read (dev, REG_STATUS, vp)) < 0) {
-		dbg ("can't read %s-%s status: %d",
+		devdbg(dev, "can't read %s-%s status: %d",
 			dev->udev->bus->bus_name, dev->udev->devpath, retval);
 		goto done;
 	}
@@ -1382,7 +1833,7 @@
 	// nc_dump_status (dev, status);
 
 	if ((retval = nc_register_read (dev, REG_USBCTL, vp)) < 0) {
-		dbg ("can't read USBCTL, %d", retval);
+		devdbg(dev, "can't read USBCTL, %d", retval);
 		goto done;
 	}
 	usbctl = *vp;
@@ -1392,7 +1843,7 @@
 			USBCTL_FLUSH_THIS | USBCTL_FLUSH_OTHER);
 
 	if ((retval = nc_register_read (dev, REG_TTL, vp)) < 0) {
-		dbg ("can't read TTL, %d", retval);
+		devdbg(dev, "can't read TTL, %d", retval);
 		goto done;
 	}
 	ttl = *vp;
@@ -1400,7 +1851,7 @@
 
 	nc_register_write (dev, REG_TTL,
 			MK_TTL (NC_READ_TTL_MS, TTL_OTHER (ttl)) );
-	dbg ("%s: assigned TTL, %d ms", dev->net.name, NC_READ_TTL_MS);
+	devdbg(dev, "assigned TTL, %d ms", NC_READ_TTL_MS);
 
 	if (dev->msg_level >= 2)
 		devinfo (dev, "port %c, peer %sconnected",
@@ -1426,7 +1877,7 @@
 	status = *vp;
 	kfree (vp);
 	if (retval != 0) {
-		dbg ("%s net1080_check_conn read - %d", dev->net.name, retval);
+		devdbg (dev, "net1080_check_conn read - %d", retval);
 		return retval;
 	}
 	if ((status & STATUS_CONN_OTHER) != STATUS_CONN_OTHER)
@@ -1434,6 +1885,60 @@
 	return 0;
 }
 
+static void nc_flush_complete (struct urb *urb)
+{
+	kfree (urb->context);
+	usb_free_urb(urb);
+}
+
+static void nc_ensure_sync (struct usbnet *dev)
+{
+	dev->frame_errors++;
+	if (dev->frame_errors > 5) {
+		struct urb		*urb;
+		struct usb_ctrlrequest	*req;
+		int			status;
+
+		/* Send a flush */
+		urb = usb_alloc_urb (0, SLAB_ATOMIC);
+		if (!urb)
+			return;
+
+		req = kmalloc (sizeof *req, GFP_ATOMIC);
+		if (!req) {
+			usb_free_urb (urb);
+			return;
+		}
+
+		req->bRequestType = USB_DIR_OUT
+			| USB_TYPE_VENDOR
+			| USB_RECIP_DEVICE;
+		req->bRequest = REQUEST_REGISTER;
+		req->wValue = cpu_to_le16 (USBCTL_FLUSH_THIS
+				| USBCTL_FLUSH_OTHER);
+		req->wIndex = cpu_to_le16 (REG_USBCTL);
+		req->wLength = cpu_to_le16 (0);
+
+		/* queue an async control request, we don't need
+		 * to do anything when it finishes except clean up.
+		 */
+		usb_fill_control_urb (urb, dev->udev,
+			usb_sndctrlpipe (dev->udev, 0),
+			(unsigned char *) req,
+			NULL, 0,
+			nc_flush_complete, req);
+		status = usb_submit_urb (urb, GFP_ATOMIC);
+		if (status) {
+			kfree (req);
+			usb_free_urb (urb);
+			return;
+		}
+
+		devdbg (dev, "flush net1080; too many framing errors");
+		dev->frame_errors = 0;
+	}
+}
+
 static int net1080_rx_fixup (struct usbnet *dev, struct sk_buff *skb)
 {
 	struct nc_header	*header;
@@ -1441,11 +1946,12 @@
 
 	if (!(skb->len & 0x01)
 			|| MIN_FRAMED > skb->len
-			|| skb->len > FRAMED_SIZE (dev->net.mtu)) {
+			|| skb->len > FRAMED_SIZE (dev->net->mtu)) {
 		dev->stats.rx_frame_errors++;
-		dbg ("rx framesize %d range %d..%d mtu %d", skb->len,
-			(int)MIN_FRAMED, (int)FRAMED_SIZE (dev->net.mtu),
-			dev->net.mtu);
+		devdbg(dev, "rx framesize %d range %d..%d mtu %d", skb->len,
+			(int)MIN_FRAMED, (int)FRAMED_SIZE (dev->net->mtu),
+			dev->net->mtu);
+		nc_ensure_sync (dev);
 		return 0;
 	}
 
@@ -1454,16 +1960,19 @@
 	le16_to_cpus (&header->packet_len);
 	if (FRAMED_SIZE (header->packet_len) > MAX_PACKET) {
 		dev->stats.rx_frame_errors++;
-		dbg ("packet too big, %d", header->packet_len);
+		devdbg(dev, "packet too big, %d", header->packet_len);
+		nc_ensure_sync (dev);
 		return 0;
 	} else if (header->hdr_len < MIN_HEADER) {
 		dev->stats.rx_frame_errors++;
-		dbg ("header too short, %d", header->hdr_len);
+		devdbg(dev, "header too short, %d", header->hdr_len);
+		nc_ensure_sync (dev);
 		return 0;
 	} else if (header->hdr_len > MIN_HEADER) {
 		// out of band data for us?
-		dbg ("header OOB, %d bytes",
+		devdbg(dev, "header OOB, %d bytes",
 			header->hdr_len - MIN_HEADER);
+		nc_ensure_sync (dev);
 		// switch (vendor/product ids) { ... }
 	}
 	skb_pull (skb, header->hdr_len);
@@ -1475,20 +1984,21 @@
 	if ((header->packet_len & 0x01) == 0) {
 		if (skb->data [header->packet_len] != PAD_BYTE) {
 			dev->stats.rx_frame_errors++;
-			dbg ("bad pad");
+			devdbg(dev, "bad pad");
 			return 0;
 		}
 		skb_trim (skb, skb->len - 1);
 	}
 	if (skb->len != header->packet_len) {
 		dev->stats.rx_frame_errors++;
-		dbg ("bad packet len %d (expected %d)",
+		devdbg(dev, "bad packet len %d (expected %d)",
 			skb->len, header->packet_len);
+		nc_ensure_sync (dev);
 		return 0;
 	}
 	if (header->packet_id != get_unaligned (&trailer->packet_id)) {
 		dev->stats.rx_fifo_errors++;
-		dbg ("(2+ dropped) rx packet_id mismatch 0x%x 0x%x",
+		devdbg(dev, "(2+ dropped) rx packet_id mismatch 0x%x 0x%x",
 			header->packet_id, trailer->packet_id);
 		return 0;
 	}
@@ -1496,6 +2006,7 @@
 	devdbg (dev, "frame <rx h %d p %d id %d", header->hdr_len,
 		header->packet_len, header->packet_id);
 #endif
+	dev->frame_errors = 0;
 	return 1;
 }
 
@@ -1513,11 +2024,13 @@
 
 		if ((padlen + sizeof (struct nc_trailer)) <= tailroom
 			    && sizeof (struct nc_header) <= headroom)
+			/* There's enough head and tail room */
 			return skb;
 
 		if ((sizeof (struct nc_header) + padlen
 					+ sizeof (struct nc_trailer)) <
 				(headroom + tailroom)) {
+			/* There's enough total room, so just readjust */
 			skb->data = memmove (skb->head
 						+ sizeof (struct nc_header),
 					    skb->data, skb->len);
@@ -1525,6 +2038,8 @@
 			return skb;
 		}
 	}
+
+	/* Create a new skb to use with the correct size */
 	skb2 = skb_copy_expand (skb,
 				sizeof (struct nc_header),
 				sizeof (struct nc_trailer) + padlen,
@@ -1547,11 +2062,15 @@
 
 
 #ifdef CONFIG_USB_PL2301
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
  * Prolific PL-2301/PL-2302 driver ... http://www.prolifictech.com
  *
+ * The protocol and handshaking used here should be bug-compatible
+ * with the Linux 2.2 "plusb" driver, by Deti Fliegl.
+ *
  *-------------------------------------------------------------------------*/
 
 /*
@@ -1611,19 +2130,24 @@
 
 
 #ifdef	CONFIG_USB_ARMLINUX
+#define	HAVE_HARDWARE
 
 /*-------------------------------------------------------------------------
  *
- * Standard ARM kernels include a "usb-eth" driver, or a newer
- * "ethernet gadget" driver for basic USB connectivity.  The vendor
- * and product code may also be used for other non-CDC Linux devices,
- * if they all maintain protocol compatibility.
- *
- * That means lots of hardware could match here, possibly using
- * different endpoint numbers (and bcdVersion ids).  so we rely on
- * endpoint descriptors to sort that out for us.
- *
- * (Current Zaurus models need a different driver; see later.)
+ * Intel's SA-1100 chip integrates basic USB support, and is used
+ * in PDAs like some iPaqs, the Yopy, some Zaurus models, and more.
+ * When they run Linux, arch/arm/mach-sa1100/usb-eth.c may be used to
+ * network using minimal USB framing data.
+ *
+ * This describes the driver currently in standard ARM Linux kernels.
+ * For Linux 2.6, it's the standard "ethernet gadget" device ID used
+ * with non-ARM hardware that can't do CDC Ethernet for some reason.
+ * The Zaurus uses a different driver (see later).
+ *
+ * PXA25x and PXA210 use XScale cores (ARM v5TE) with better USB support
+ * and different USB endpoint numbering than the SA1100 devices.  The
+ * mach-pxa/usb-eth.c driver re-uses the device ids from mach-sa1100
+ * so we rely on the endpoint descriptors.
  *
  *-------------------------------------------------------------------------*/
 
@@ -1645,20 +2169,116 @@
 #endif	/* CONFIG_USB_ARMLINUX */
 
 
+/*
+ * Some devices are dual-configuration:  RNDIS first, then something
+ * else.  These 2.4-only hacks change to the non-RNDIS configuration;
+ * it's never the first configuration, which is the default on 2.4.
+ */
+
+#if	defined(CONFIG_USB_ARMLINUX) || defined(CONFIG_USB_CDCETHER)
+/*
+ * Linux Ethernet/RNDIS gadget supports either CDC Ethernet or the
+ * CDC subset, in addition to RNDIS.  Descriptors say which.
+ */
+static int ether_bind (struct usbnet *dev, struct usb_interface *intf)
+{
+	int	status;
+
+	/* firmware-specific: config #2/RNDIS at index 0 */
+	if (dev->udev->actconfig->bConfigurationValue != 1) {
+		status = usb_set_configuration(dev->udev, 1);
+		pr_info("%s: change usb-%s-%s to config #1 --> %d\n",
+				driver_name, dev->udev->bus->bus_name,
+				dev->udev->devpath, status);
+		if (status)
+			return status;
+		/* NOTE:  usbcore find_interface_driver() has a special
+		 * case for configs changing during probe(), which this
+		 * relies on (interface INDEX doesn't change)
+		 */
+	}
+
+	intf = usb_ifnum_to_if(dev->udev, 0);
+	if (intf->altsetting->bInterfaceClass == USB_CLASS_COMM) {
+#ifdef	CONFIG_USB_CDCETHER
+		status = cdc_bind(dev, intf);
+#else
+		pr_debug("CDC Ethernet not configured\n"):
+		status = -ENODEV;
+#endif
+	} else
+		status = get_endpoints (dev, intf);
+	return status;
+}
+
+static void ether_unbind (struct usbnet *dev, struct usb_interface *_intf)
+{
+#ifdef	CONFIG_USB_CDCETHER
+	struct usb_interface	*intf = usb_ifnum_to_if(dev->udev, 0);
+
+	if (intf->altsetting->bInterfaceClass == USB_CLASS_COMM)
+		cdc_unbind(dev, intf);
+#endif	/* CONFIG_USB_CDCETHER */
+}
+
+static const struct driver_info	ether_info = {
+	.description =	"Linux Ethernet/RNDIS gadget",
+	.flags =  FLAG_ETHER,
+	.check_connect = always_connected,
+	.bind = ether_bind,
+	.unbind = ether_unbind,
+};
+#endif	/* ARMLINUX or CDCETHER */
+
+#if	defined(CONFIG_USB_CDCETHER) || defined(CONFIG_USB_RNDIS)
+/*
+ * One DOCSIS cable modem profile has two configurations, first RNDIS
+ * then CDC Ethernet.  Others include RNDIS-only, and CDC-only.
+ */
+static int rndis_bind (struct usbnet *dev, struct usb_interface *intf)
+{
+	/* rndis-only? */
+	if (dev->udev->descriptor.bNumConfigurations == 1) {
+		pr_debug("no native RNDIS support yet...\n");
+		return -ENODEV;
+	}
+
+	/* FIXME find a cdc-ether configuration, switch to it,
+	 * then return cdc_bind(dev, new_intf)
+	 */
+
+	pr_info("no RNDIS config switching yet...\n");
+	return -ENODEV;
+}
+
+static const struct driver_info	rndis_info = {
+	.description =	"CDC/RNDIS device",
+	.flags =  FLAG_ETHER,
+	.bind = rndis_bind,
+	.unbind = cdc_unbind,
+};
+
+#endif	/* CDCETHER or RNDIS */
+
+
 #ifdef CONFIG_USB_ZAURUS
+#define	HAVE_HARDWARE
 
 #include <linux/crc32.h>
 
 /*-------------------------------------------------------------------------
  *
- * Zaurus PDAs are also ARM based, but currently use different drivers
- * (and framing) for USB slave/gadget controllers than the case above.
+ * Zaurus is also a SA-1110 based PDA, but one using a different driver
+ * (and framing) for its USB slave/gadget controller than the case above.
  *
  * For the current version of that driver, the main way that framing is
  * nonstandard (also from perspective of the CDC ethernet model!) is a
  * crc32, added to help detect when some sa1100 usb-to-memory DMA errata
  * haven't been fully worked around.
  *
+ * PXA based models use the same framing, and also can't implement
+ * set_interface properly.
+ *
  *-------------------------------------------------------------------------*/
 
 static struct sk_buff *
@@ -1690,26 +2310,22 @@
 	return skb;
 }
 
-/* SA-1100 based */
 static const struct driver_info	zaurus_sl5x00_info = {
 	.description =	"Sharp Zaurus SL-5x00",
 	.flags =	FLAG_FRAMING_Z,
 	.check_connect = always_connected,
+	.bind =		generic_cdc_bind,
+	.unbind =	cdc_unbind,
 	.tx_fixup = 	zaurus_tx_fixup,
-
-	.in = 2, .out = 1,
-	.epsize = 64,
 };
-
-/* PXA-2xx based */
-static const struct driver_info zaurus_pxa_info = {
+static const struct driver_info	zaurus_pxa_info = {
 	.description =	"Sharp Zaurus, PXA-2xx based",
 	.flags =	FLAG_FRAMING_Z,
 	.check_connect = always_connected,
 	.tx_fixup = 	zaurus_tx_fixup,
 
+	/* FIXME use generic_cdc bind/unbind; claim both interfaces */
 	.in = 1, .out = 2,
-	.epsize = 64,
 };
 
 #endif
@@ -1754,7 +2370,9 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* urb completions may be in_irq; avoid doing real work then. */
+/* some LK 2.4 HCDs oopsed if we freed or resubmitted urbs from
+ * completion callbacks.  2.6 should have fixed those bugs...
+ */
 
 static void defer_bh (struct usbnet *dev, struct sk_buff *skb)
 {
@@ -1780,10 +2398,9 @@
 {
 	set_bit (work, &dev->flags);
 	if (!schedule_task (&dev->kevent))
-		err ("%s: kevent %d may have been dropped",
-			dev->net.name, work);
+		deverr (dev, "kevent %d may have been dropped", work);
 	else
-		dbg ("%s: kevent %d scheduled", dev->net.name, work);
+		devdbg (dev, "kevent %d scheduled", work);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1800,7 +2417,7 @@
 
 #ifdef CONFIG_USB_NET1080
 	if (dev->driver_info->flags & FLAG_FRAMING_NC)
-		size = FRAMED_SIZE (dev->net.mtu);
+		size = FRAMED_SIZE (dev->net->mtu);
 	else
 #endif
 #ifdef CONFIG_USB_GENESYS
@@ -1810,13 +2427,18 @@
 #endif
 #ifdef CONFIG_USB_ZAURUS
 	if (dev->driver_info->flags & FLAG_FRAMING_Z)
-		size = 6 + (sizeof (struct ethhdr) + dev->net.mtu);
+		size = 6 + (sizeof (struct ethhdr) + dev->net->mtu);
+	else
+#endif
+#ifdef CONFIG_USB_RNDIS
+	if (dev->driver_info->flags & FLAG_FRAMING_RN)
+		size = RNDIS_MAX_TRANSFER;
 	else
 #endif
-		size = (sizeof (struct ethhdr) + dev->net.mtu);
+		size = (sizeof (struct ethhdr) + dev->net->mtu);
 
 	if ((skb = alloc_skb (size, flags)) == 0) {
-		dbg ("no rx skb");
+		devdbg (dev, "no rx skb");
 		defer_kevent (dev, EVENT_RX_MEMORY);
 		usb_free_urb (urb);
 		return;
@@ -1830,28 +2452,33 @@
 
 	usb_fill_bulk_urb (urb, dev->udev, dev->in,
 		skb->data, size, rx_complete, skb);
-	urb->transfer_flags |= USB_ASYNC_UNLINK;
+	urb->transfer_flags |= URB_ASYNC_UNLINK;
 
 	spin_lock_irqsave (&dev->rxq.lock, lockflags);
 
-	if (netif_running (&dev->net)
+	if (netif_running (dev->net)
+			&& netif_device_present (dev->net)
 			&& !test_bit (EVENT_RX_HALT, &dev->flags)) {
-		switch (retval = SUBMIT_URB (urb, GFP_ATOMIC)){ 
+		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)){ 
 		case -EPIPE:
 			defer_kevent (dev, EVENT_RX_HALT);
 			break;
 		case -ENOMEM:
 			defer_kevent (dev, EVENT_RX_MEMORY);
 			break;
+		case -ENODEV:
+			devdbg (dev, "device gone");
+			netif_device_detach (dev->net);
+			break;
 		default:
-			dbg ("%s rx submit, %d", dev->net.name, retval);
+			devdbg (dev, "rx submit, %d", retval);
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
 			__skb_queue_tail (&dev->rxq, skb);
 		}
 	} else {
-		dbg ("rx: stopped");
+		devdbg (dev, "rx: stopped");
 		retval = -ENOLINK;
 	}
 	spin_unlock_irqrestore (&dev->rxq.lock, lockflags);
@@ -1871,24 +2498,10 @@
 		goto error;
 	// else network stack removes extra byte if we forced a short packet
 
-	if (skb->len) {
-		int	status;
-
-		skb->dev = &dev->net;
-		skb->protocol = eth_type_trans (skb, &dev->net);
-		dev->stats.rx_packets++;
-		dev->stats.rx_bytes += skb->len;
-
-#ifdef	VERBOSE
-		devdbg (dev, "< rx, len %d, type 0x%x",
-			skb->len + sizeof (struct ethhdr), skb->protocol);
-#endif
-		memset (skb->cb, 0, sizeof (struct skb_data));
-		status = netif_rx (skb);
-		if (status != NET_RX_SUCCESS)
-			devdbg (dev, "netif_rx status %d", status);
-	} else {
-		dbg ("drop");
+	if (skb->len)
+		skb_return (dev, skb);
+	else {
+		devdbg (dev, "drop");
 error:
 		dev->stats.rx_errors++;
 		skb_queue_tail (&dev->done, skb);
@@ -1915,7 +2528,7 @@
 			entry->state = rx_cleanup;
 			dev->stats.rx_errors++;
 			dev->stats.rx_length_errors++;
-			dbg ("rx length %d", skb->len);
+			devdbg (dev, "rx length %d", skb->len);
 		}
 		break;
 
@@ -1924,13 +2537,30 @@
 	    // we avoid the highspeed version of the ETIMEOUT/EILSEQ
 	    // storm, recovering as needed.
 	    case -EPIPE:
+		dev->stats.rx_errors++;
 		defer_kevent (dev, EVENT_RX_HALT);
 		// FALLTHROUGH
 
 	    // software-driven interface shutdown
-	    case -ECONNRESET:		// according to API spec
-	    case -ECONNABORTED:		// some (now fixed?) UHCI bugs
-		dbg ("%s rx shutdown, code %d", dev->net.name, urb_status);
+	    case -ECONNRESET:		// async unlink
+	    case -ESHUTDOWN:		// hardware gone
+#ifdef	VERBOSE
+		devdbg (dev, "rx shutdown, code %d", urb_status);
+#endif
+		goto block;
+
+	    // we get controller i/o faults during khubd disconnect() delays.
+	    // throttle down resubmits, to avoid log floods; just temporarily,
+	    // so we still recover when the fault isn't a khubd delay.
+	    case -EPROTO:		// ehci
+	    case -ETIMEDOUT:		// ohci
+	    case -EILSEQ:		// uhci
+		dev->stats.rx_errors++;
+		if (!timer_pending (&dev->delay)) {
+			mod_timer (&dev->delay, jiffies + THROTTLE_JIFFIES);
+			devdbg (dev, "rx throttle %d", urb_status);
+		}
+block:
 		entry->state = rx_cleanup;
 		// do urb frees only in the tasklet (UHCI has oopsed ...)
 		entry->urb = urb;
@@ -1943,19 +2573,16 @@
 		// FALLTHROUGH
 	    
 	    default:
-		// on unplug we get ETIMEDOUT (ohci) or EILSEQ (uhci)
-		// until khubd sees its interrupt and disconnects us.
-		// that can easily be hundreds of passes through here.
 		entry->state = rx_cleanup;
 		dev->stats.rx_errors++;
-		dbg ("%s rx: status %d", dev->net.name, urb_status);
+		devdbg (dev, "rx status %d", urb_status);
 		break;
 	}
 
 	defer_bh (dev, skb);
 
 	if (urb) {
-		if (netif_running (&dev->net)
+		if (netif_running (dev->net)
 				&& !test_bit (EVENT_RX_HALT, &dev->flags)) {
 			rx_submit (dev, urb, GFP_ATOMIC);
 			return;
@@ -1963,7 +2590,7 @@
 		usb_free_urb (urb);
 	}
 #ifdef	VERBOSE
-	dbg ("no read resubmitted");
+	devdbg (dev, "no read resubmitted");
 #endif /* VERBOSE */
 }
 
@@ -1971,7 +2598,7 @@
 
 // unlink pending rx/tx; completion handlers do all other cleanup
 
-static int unlink_urbs (struct sk_buff_head *q)
+static int unlink_urbs (struct usbnet *dev, struct sk_buff_head *q)
 {
 	unsigned long		flags;
 	struct sk_buff		*skb, *skbnext;
@@ -1991,7 +2618,7 @@
 		// these (async) unlinks complete immediately
 		retval = usb_unlink_urb (urb);
 		if (retval != -EINPROGRESS && retval != 0)
-			dbg ("unlink urb err, %d", retval);
+			devdbg (dev, "unlink urb err, %d", retval);
 		else
 			count++;
 	}
@@ -2011,7 +2638,6 @@
 	DECLARE_WAIT_QUEUE_HEAD (unlink_wakeup); 
 	DECLARE_WAITQUEUE (wait, current);
 
-	mutex_lock (&dev->mutex);
 	netif_stop_queue (net);
 
 	if (dev->msg_level >= 2)
@@ -2023,7 +2649,7 @@
 	// ensure there are no more active urbs
 	add_wait_queue (&unlink_wakeup, &wait);
 	dev->wait = &unlink_wakeup;
-	temp = unlink_urbs (&dev->txq) + unlink_urbs (&dev->rxq);
+	temp = unlink_urbs (dev, &dev->txq) + unlink_urbs (dev, &dev->rxq);
 
 	// maybe wait for deletions to finish.
 	while (skb_queue_len (&dev->rxq)
@@ -2031,18 +2657,25 @@
 			&& skb_queue_len (&dev->done)) {
 		set_current_state (TASK_UNINTERRUPTIBLE);
 		schedule_timeout (UNLINK_TIMEOUT_JIFFIES);
-		dbg ("waited for %d urb completions", temp);
+		devdbg (dev, "waited for %d urb completions", temp);
 	}
 	dev->wait = 0;
 	remove_wait_queue (&unlink_wakeup, &wait); 
 
-	mutex_unlock (&dev->mutex);
+	/* deferred work (task, timer, softirq) must also stop.
+	 * can't flush_scheduled_work() until we drop rtnl (later),
+	 * else workers could deadlock; so make workers a NOP.
+	 */
+	dev->flags = 0;
+	del_timer_sync (&dev->delay);
+	tasklet_kill (&dev->bh);
+
 	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
 
-// posts reads, and enables write queing
+// posts reads, and enables write queuing
 
 // precondition: never called in_interrupt
 
@@ -2052,8 +2685,6 @@
 	int			retval = 0;
 	struct driver_info	*info = dev->driver_info;
 
-	mutex_lock (&dev->mutex);
-
 	// put into "known safe" state
 	if (info->reset && (retval = info->reset (dev)) < 0) {
 		devinfo (dev, "open reset fail (%d) usbnet usb-%s-%s, %s",
@@ -2070,21 +2701,29 @@
 	}
 
 	netif_start_queue (net);
-	if (dev->msg_level >= 2)
+	if (dev->msg_level >= 2) {
+		char	*framing;
+
+		if (dev->driver_info->flags & FLAG_FRAMING_NC)
+			framing = "NetChip";
+		else if (dev->driver_info->flags & FLAG_FRAMING_GL)
+			framing = "GeneSys";
+		else if (dev->driver_info->flags & FLAG_FRAMING_Z)
+			framing = "Zaurus";
+		else if (dev->driver_info->flags & FLAG_FRAMING_RN)
+			framing = "RNDIS";
+		else
+			framing = "simple";
+
 		devinfo (dev, "open: enable queueing "
 				"(rx %d, tx %d) mtu %d %s framing",
-			RX_QLEN, TX_QLEN, dev->net.mtu,
-			(info->flags & (FLAG_FRAMING_NC | FLAG_FRAMING_GL))
-			    ? ((info->flags & FLAG_FRAMING_NC)
-				? "NetChip"
-				: "GeneSys")
-			    : "raw"
-			);
+			RX_QLEN (dev), TX_QLEN (dev), dev->net->mtu,
+			framing);
+	}
 
 	// delay posting reads until we're fully open
 	tasklet_schedule (&dev->bh);
 done:
-	mutex_unlock (&dev->mutex);
 	return retval;
 }
 
@@ -2158,22 +2797,22 @@
 
 	/* usb_clear_halt() needs a thread context */
 	if (test_bit (EVENT_TX_HALT, &dev->flags)) {
-		unlink_urbs (&dev->txq);
+		unlink_urbs (dev, &dev->txq);
 		status = usb_clear_halt (dev->udev, dev->out);
 		if (status < 0)
-			err ("%s: can't clear tx halt, status %d",
-				dev->net.name, status);
+			deverr (dev, "can't clear tx halt, status %d",
+				status);
 		else {
 			clear_bit (EVENT_TX_HALT, &dev->flags);
-			netif_wake_queue (&dev->net);
+			netif_wake_queue (dev->net);
 		}
 	}
 	if (test_bit (EVENT_RX_HALT, &dev->flags)) {
-		unlink_urbs (&dev->rxq);
+		unlink_urbs (dev, &dev->rxq);
 		status = usb_clear_halt (dev->udev, dev->in);
 		if (status < 0)
-			err ("%s: can't clear rx halt, status %d",
-				dev->net.name, status);
+			deverr (dev, "can't clear rx halt, status %d",
+				status);
 		else {
 			clear_bit (EVENT_RX_HALT, &dev->flags);
 			tasklet_schedule (&dev->bh);
@@ -2184,8 +2823,8 @@
 	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
 		struct urb	*urb = 0;
 
-		if (netif_running (&dev->net))
-			urb = ALLOC_URB (0, GFP_KERNEL);
+		if (netif_running (dev->net))
+			urb = usb_alloc_urb (0, GFP_KERNEL);
 		else
 			clear_bit (EVENT_RX_MEMORY, &dev->flags);
 		if (urb != 0) {
@@ -2196,8 +2835,8 @@
 	}
 
 	if (dev->flags)
-		dbg ("%s: kevent done, flags = 0x%lx",
-			dev->net.name, dev->flags);
+		devdbg (dev, "kevent done, flags = 0x%lx",
+			dev->flags);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2208,8 +2847,35 @@
 	struct skb_data		*entry = (struct skb_data *) skb->cb;
 	struct usbnet		*dev = entry->dev;
 
-	if (urb->status == -EPIPE)
-		defer_kevent (dev, EVENT_TX_HALT);
+	if (urb->status == 0) {
+		dev->stats.tx_packets++;
+		dev->stats.tx_bytes += entry->length;
+	} else {
+		dev->stats.tx_errors++;
+
+		switch (urb->status) {
+		case -EPIPE:
+			defer_kevent (dev, EVENT_TX_HALT);
+			break;
+
+		// like rx, tx gets controller i/o faults during khubd delays
+		// and so it uses the same throttling mechanism.
+		case -EPROTO:		// ehci
+		case -ETIMEDOUT:	// ohci
+		case -EILSEQ:		// uhci
+			if (!timer_pending (&dev->delay)) {
+				mod_timer (&dev->delay,
+					jiffies + THROTTLE_JIFFIES);
+				devdbg (dev, "tx throttle %d", urb->status);
+			}
+			netif_stop_queue (dev->net);
+			break;
+		default:
+			devdbg (dev, "tx err %d", entry->urb->status);
+			break;
+		}
+	}
+
 	urb->dev = 0;
 	entry->state = tx_done;
 	defer_bh (dev, skb);
@@ -2221,7 +2887,7 @@
 {
 	struct usbnet		*dev = (struct usbnet *) net->priv;
 
-	unlink_urbs (&dev->txq);
+	unlink_urbs (dev, &dev->txq);
 	tasklet_schedule (&dev->bh);
 
 	// FIXME: device recovery -- reset?
@@ -2248,14 +2914,14 @@
 	if (info->tx_fixup) {
 		skb = info->tx_fixup (dev, skb, GFP_ATOMIC);
 		if (!skb) {
-			dbg ("can't tx_fixup skb");
+			devdbg (dev, "can't tx_fixup skb");
 			goto drop;
 		}
 	}
 	length = skb->len;
 
-	if (!(urb = ALLOC_URB (0, GFP_ATOMIC))) {
-		dbg ("no urb");
+	if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
+		devdbg (dev, "no urb");
 		goto drop;
 	}
 
@@ -2277,22 +2943,27 @@
 		if (!((skb->len + sizeof *trailer) & 0x01))
 			*skb_put (skb, 1) = PAD_BYTE;
 		trailer = (struct nc_trailer *) skb_put (skb, sizeof *trailer);
-	} else
+	}
 #endif	/* CONFIG_USB_NET1080 */
 
-	/* don't assume the hardware handles USB_ZERO_PACKET */
-	if ((length % dev->maxpacket) == 0)
-		skb->len++;
-
 	usb_fill_bulk_urb (urb, dev->udev, dev->out,
 			skb->data, skb->len, tx_complete, skb);
-	urb->transfer_flags |= USB_ASYNC_UNLINK;
+	urb->transfer_flags |= URB_ASYNC_UNLINK;
+
+	/* don't assume the hardware handles USB_ZERO_PACKET
+	 * NOTE:  strictly conforming cdc-ether devices should expect
+	 * the ZLP here, but ignore the one-byte packet.
+	 *
+	 * FIXME zero that byte, if it doesn't require a new skb.
+	 */
+	if ((length % dev->maxpacket) == 0)
+		urb->transfer_buffer_length++;
 
 	spin_lock_irqsave (&dev->txq.lock, flags);
 
 #ifdef	CONFIG_USB_NET1080
 	if (info->flags & FLAG_FRAMING_NC) {
-		header->packet_id = cpu_to_le16 (dev->packet_id++);
+		header->packet_id = cpu_to_le16 ((u16)dev->dev_packet_id++);
 		put_unaligned (header->packet_id, &trailer->packet_id);
 #if 0
 		devdbg (dev, "frame >tx h %d p %d id %d",
@@ -2302,18 +2973,18 @@
 	}
 #endif	/* CONFIG_USB_NET1080 */
 
-	switch ((retval = SUBMIT_URB (urb, GFP_ATOMIC))) {
+	switch ((retval = usb_submit_urb (urb, GFP_ATOMIC))) {
 	case -EPIPE:
 		netif_stop_queue (net);
 		defer_kevent (dev, EVENT_TX_HALT);
 		break;
 	default:
-		dbg ("%s tx: submit urb err %d", net->name, retval);
+		devdbg (dev, "tx: submit urb err %d", retval);
 		break;
 	case 0:
 		net->trans_start = jiffies;
 		__skb_queue_tail (&dev->txq, skb);
-		if (dev->txq.qlen >= TX_QLEN)
+		if (dev->txq.qlen >= TX_QLEN (dev))
 			netif_stop_queue (net);
 	}
 	spin_unlock_irqrestore (&dev->txq.lock, flags);
@@ -2338,7 +3009,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-// tasklet ... work that avoided running in_irq()
+// tasklet (work deferred from completions, in_irq) or timer
 
 static void usbnet_bh (unsigned long param)
 {
@@ -2354,23 +3025,12 @@
 			rx_process (dev, skb);
 			continue;
 		    case tx_done:
-			if (entry->urb->status) {
-				// can this statistic become more specific?
-				dev->stats.tx_errors++;
-				dbg ("%s tx: err %d", dev->net.name,
-					entry->urb->status);
-			} else {
-				dev->stats.tx_packets++;
-				dev->stats.tx_bytes += entry->length;
-			}
-			// FALLTHROUGH:
 		    case rx_cleanup:
 			usb_free_urb (entry->urb);
 			dev_kfree_skb (skb);
 			continue;
 		    default:
-			dbg ("%s: bogus skb state %d",
-				dev->net.name, entry->state);
+			devdbg (dev, "bogus skb state %d", entry->state);
 		}
 	}
 
@@ -2381,25 +3041,30 @@
 		}
 
 	// or are we maybe short a few urbs?
-	} else if (netif_running (&dev->net)
+	} else if (netif_running (dev->net)
+			&& netif_device_present (dev->net)
+			&& !timer_pending (&dev->delay)
 			&& !test_bit (EVENT_RX_HALT, &dev->flags)) {
 		int	temp = dev->rxq.qlen;
+		int	qlen = RX_QLEN (dev);
 
-		if (temp < RX_QLEN) {
+		if (temp < qlen) {
 			struct urb	*urb;
 			int		i;
-			for (i = 0; i < 3 && dev->rxq.qlen < RX_QLEN; i++) {
-				if ((urb = ALLOC_URB (0, GFP_ATOMIC)) != 0)
+
+			// don't refill the queue all at once
+			for (i = 0; i < 10 && dev->rxq.qlen < qlen; i++) {
+				if ((urb = usb_alloc_urb (0, GFP_ATOMIC)) != 0)
 					rx_submit (dev, urb, GFP_ATOMIC);
 			}
 			if (temp != dev->rxq.qlen)
 				devdbg (dev, "rxqlen %d --> %d",
 						temp, dev->rxq.qlen);
-			if (dev->rxq.qlen < RX_QLEN)
+			if (dev->rxq.qlen < qlen)
 				tasklet_schedule (&dev->bh);
 		}
-		if (dev->txq.qlen < TX_QLEN)
-			netif_wake_queue (&dev->net);
+		if (dev->txq.qlen < TX_QLEN (dev))
+			netif_wake_queue (dev->net);
 	}
 }
 
@@ -2413,100 +3078,80 @@
  
 // precondition: never called in_interrupt
 
-static void usbnet_disconnect (struct usb_device *udev, void *ptr)
+static void usbnet_disconnect (struct usb_device *xdev, void *ptr)
 {
 	struct usbnet	*dev = (struct usbnet *) ptr;
 
 	devinfo (dev, "unregister usbnet usb-%s-%s, %s",
-		udev->bus->bus_name, udev->devpath,
+		xdev->bus->bus_name, xdev->devpath,
 		dev->driver_info->description);
 	
-	unregister_netdev (&dev->net);
+	unregister_netdev (dev->net);
 
-	mutex_lock (&usbnet_mutex);
-	mutex_lock (&dev->mutex);
-	list_del (&dev->dev_list);
-	mutex_unlock (&usbnet_mutex);
-
-	// assuming we used keventd, it must quiesce too
+	/* we don't hold rtnl here ... */
 	flush_scheduled_tasks ();
 
-	kfree (dev);
-	usb_put_dev (udev);
+	if (dev->driver_info->unbind)
+		dev->driver_info->unbind (dev, 0);
+
+	free_netdev(dev->net);
+	usb_put_dev (xdev);
 }
 
 
 /*-------------------------------------------------------------------------*/
 
+static struct ethtool_ops usbnet_ethtool_ops;
+
 // precondition: never called in_interrupt
 
 static void *
-usbnet_probe (struct usb_device *udev, unsigned ifnum,
+usbnet_probe (struct usb_device *xdev, unsigned ifnum,
 			const struct usb_device_id *prod)
 {
 	struct usbnet			*dev;
 	struct net_device 		*net;
 	struct driver_info		*info;
-	int				altnum = 0;
+	struct usb_interface		*udev;
 	int				status;
 
 	info = (struct driver_info *) prod->driver_info;
-
-#ifdef CONFIG_USB_ZAURUS
-	if (info == &zaurus_sl5x00_info) {
-		int	status;
-
-		/* old ROMs have more than one config
-		 * so we have to make sure config="1" (?)
-		 */
-		status = usb_set_configuration (udev, 1);
-		if (status < 0) {
-			err ("set_config failed, %d", status);
-			return 0;
-		}
-		altnum = 1;
+	if (!info) {
+		pr_debug("blacklisted by %s\n", driver_name);
+		return 0;
 	}
-#endif
+	udev = usb_ifnum_to_if(xdev, ifnum);
 
-	// more sanity (unless the device is broken)
-	if (!(info->flags & FLAG_NO_SETINT)) {
-		if (usb_set_interface (udev, ifnum, altnum) < 0) {
-			err ("set_interface failed");
-			return 0;
-		}
+	/* one allocation handles both network and driver state */
+	net = alloc_etherdev (sizeof *dev);
+	if (!net) {
+		pr_debug("%s: can't alloc etherdev\n", driver_name);
+		return 0;
 	}
 
 	// set up our own records
-	if (!(dev = kmalloc (sizeof *dev, GFP_KERNEL))) {
-		dbg ("can't kmalloc dev");
-		return 0;
-	}
+	dev = net->priv;
 	memset (dev, 0, sizeof *dev);
 
-	init_MUTEX_LOCKED (&dev->mutex);
-	usb_get_dev (udev);
-	dev->udev = udev;
+	dev->udev = usb_get_dev (xdev);
 	dev->driver_info = info;
 	dev->msg_level = msg_level;
-	INIT_LIST_HEAD (&dev->dev_list);
 	skb_queue_head_init (&dev->rxq);
 	skb_queue_head_init (&dev->txq);
 	skb_queue_head_init (&dev->done);
 	dev->bh.func = usbnet_bh;
 	dev->bh.data = (unsigned long) dev;
 	INIT_TQUEUE (&dev->kevent, kevent, dev);
+	dev->delay.function = usbnet_bh;
+	dev->delay.data = (unsigned long) dev;
+	init_timer (&dev->delay);
 
 	// set up network interface records
-	net = &dev->net;
 	SET_MODULE_OWNER (net);
-	net->priv = dev;
+	dev->net = net;
 	strcpy (net->name, "usb%d");
 	memcpy (net->dev_addr, node_id, sizeof node_id);
 
-	// point-to-point link ... we always use Ethernet headers 
-	// supports win32 interop and the bridge driver.
-	ether_setup (net);
-
 	net->change_mtu = usbnet_change_mtu;
 	net->get_stats = usbnet_get_stats;
 	net->hard_start_xmit = usbnet_start_xmit;
@@ -2521,6 +3166,8 @@
 	// NOTE net->name still not usable ...
 	if (info->bind) {
 		status = info->bind (dev, udev);
+		/* NOTE (2.4-specific):  config may have changed !! */
+
 		// heuristic:  "usb%d" for links we know are two-host,
 		// else "eth%d" when there's reasonable doubt.  userspace
 		// can rename the link if it knows better.
@@ -2528,34 +3175,57 @@
 				&& (net->dev_addr [0] & 0x02) == 0)
 			strcpy (net->name, "eth%d");
 	} else if (!info->in || info->out)
-		status = get_endpoints (dev, udev->actconfig->interface + ifnum);
+		status = get_endpoints (dev, udev);
 	else {
-		dev->in = usb_rcvbulkpipe (udev, info->in);
-		dev->out = usb_sndbulkpipe (udev, info->out);
+		struct usb_interface_descriptor		*desc;
+
+		/* FIXME assumes sane descriptors! */
+		desc = udev->altsetting + udev->act_altsetting;
+
+		dev->in = usb_rcvbulkpipe (xdev, info->in);
+		dev->out = usb_sndbulkpipe (xdev, info->out);
+		if (!(info->flags & FLAG_NO_SETINT))
+			status = usb_set_interface (xdev,
+				desc->bInterfaceNumber,
+				desc->bAlternateSetting);
+		else
+			status = 0;
 	}
+	if (status < 0)
+		goto out1;
 
 	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
 
-	register_netdev (&dev->net);
-	devinfo (dev, "register usbnet usb-%s-%s, %s",
-		udev->bus->bus_name, udev->devpath,
+	status = register_netdev (dev->net);
+	if (status)
+		goto out3;
+	devinfo (dev, "register usbnet at usb-%s-%s, %s",
+		xdev->bus->bus_name, xdev->devpath,
 		dev->driver_info->description);
 
-	// ok, it's ready to go.
-	mutex_lock (&usbnet_mutex);
-	list_add (&dev->dev_list, &usbnet_list);
-	mutex_unlock (&dev->mutex);
-
 	// start as if the link is up
-	netif_device_attach (&dev->net);
+	netif_device_attach (dev->net);
 
-	mutex_unlock (&usbnet_mutex);
+	// return nonzero to claim interface with
+	// index ifnum in the now-active config
 	return dev;
+
+out3:
+	if (info->unbind)
+		info->unbind (dev, udev);
+out1:
+	free_netdev(net);
+	usb_put_dev(xdev);
+	return 0;
 }
 
 
 /*-------------------------------------------------------------------------*/
 
+#ifndef	HAVE_HARDWARE
+#error You need to configure some hardware for this driver
+#endif
+
 /*
  * chip vendor names won't normally be on the cables, and
  * may not be on the device.
@@ -2563,6 +3233,13 @@
 
 static const struct usb_device_id	products [] = {
 
+#ifdef	CONFIG_USB_ALI_M5632
+{
+	USB_DEVICE (0x0402, 0x5632),	// ALi defaults
+	.driver_info =	(unsigned long) &ali_m5632_info,
+},
+#endif
+
 #ifdef	CONFIG_USB_AN2720
 {
 	USB_DEVICE (0x0547, 0x2720),	// AnchorChips defaults
@@ -2573,6 +3250,19 @@
 },
 #endif
 
+#ifdef	CONFIG_USB_BELKIN
+{
+	USB_DEVICE (0x050d, 0x0004),	// Belkin
+	.driver_info =	(unsigned long) &belkin_info,
+}, {
+	USB_DEVICE (0x056c, 0x8100),	// eTEK
+	.driver_info =	(unsigned long) &belkin_info,
+}, {
+	USB_DEVICE (0x0525, 0x9901),	// Advance USBNET (eTEK)
+	.driver_info =	(unsigned long) &belkin_info,
+},
+#endif
+
 #ifdef CONFIG_USB_AX8817X
 {
 	// Linksys USB200M
@@ -2597,19 +3287,6 @@
 }, 
 #endif
 
-#ifdef	CONFIG_USB_BELKIN
-{
-	USB_DEVICE (0x050d, 0x0004),	// Belkin
-	.driver_info =	(unsigned long) &belkin_info,
-}, {
-	USB_DEVICE (0x056c, 0x8100),	// eTEK
-	.driver_info =	(unsigned long) &belkin_info,
-}, {
-	USB_DEVICE (0x0525, 0x9901),	// Advance USBNET (eTEK)
-	.driver_info =	(unsigned long) &belkin_info,
-},
-#endif
-
 #ifdef	CONFIG_USB_EPSON2888
 {
 	USB_DEVICE (0x0525, 0x2888),	// EPSON USB client
@@ -2647,22 +3324,36 @@
 },
 #endif
 
+#if	defined(CONFIG_USB_ARMLINUX) || defined(CONFIG_USB_CDCETHER)
+{
+	/* use the non-RNDIS configuration */
+	USB_DEVICE (0x0525, 0xa4a2),	// Ethernet/RNDIS gadget
+	.driver_info =	(unsigned long) &ether_info,
+},
+#endif
+
+#if	defined(CONFIG_USB_CDCETHER) || defined(CONFIG_USB_RNDIS)
+{
+	/* RNDIS is MSFT's un-official variant of CDC ACM */
+	/* sometimes paired with a CDC Ether configuration */
+	USB_INTERFACE_INFO (USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
+	.driver_info = (unsigned long) &rndis_info,
+},
+#endif	/* CDC || RNDIS */
+
 #ifdef	CONFIG_USB_ARMLINUX
 /*
  * SA-1100 using standard ARM Linux kernels, or compatible.
  * Often used when talking to Linux PDAs (iPaq, Yopy, etc).
  * The sa-1100 "usb-eth" driver handles the basic framing.
- * ARMv4.
  *
- * PXA2xx using usb "gadget" driver, or older "usb-eth" much like
- * the sa1100 one. (But PXA hardware uses different endpoints.)
- * ARMv5TE.
+ * PXA25x or PXA210 ...  these use a "usb-eth" driver much like
+ * the sa1100 one, but hardware uses different endpoint numbers.
  */
 {
 	// 1183 = 0x049F, both used as hex values?
 	// Compaq "Itsy" vendor/product id
-	// version numbers vary, along with endpoint usage
-	// but otherwise they're protocol-compatible
+	// ... used also for non-ARM linux, on cdc-incapable hardware
 	USB_DEVICE (0x049F, 0x505A),
 	.driver_info =	(unsigned long) &linuxdev_info,
 }, {
@@ -2678,15 +3369,19 @@
 /*
  * SA-1100 based Sharp Zaurus ("collie"), or compatible.
  * Same idea as above, but different framing.
+ *
+ * PXA-2xx based models are also lying-about-cdc.
  */
 {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE, 
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8004,
-	.bInterfaceClass	= 0x0a,
-	.bInterfaceSubClass	= 0x00,
-	.bInterfaceProtocol	= 0x00,
+	/* match the master interface */
+	.bInterfaceClass	= USB_CLASS_COMM,
+	.bInterfaceSubClass	= 6 /* Ethernet model */,
+	.bInterfaceProtocol	= 0,
+	// COLLIE
 	.driver_info =  (unsigned long) &zaurus_sl5x00_info,
 }, {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
@@ -2724,6 +3419,47 @@
 	.bInterfaceSubClass	= 0x0a,
 	.bInterfaceProtocol	= 0x00,
 	.driver_info =	(unsigned long) &zaurus_pxa_info,
+}, {
+	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE, 
+	.idVendor		= 0x04DD,
+	.idProduct              = 0x9050,	/* C-860 */
+	.bInterfaceClass        = 0x02,
+	.bInterfaceSubClass     = 0x0a,
+	.bInterfaceProtocol     = 0x00,
+	.driver_info =	(unsigned long) &zaurus_pxa_info,
+},
+#endif
+
+#ifdef	CONFIG_USB_CDCETHER
+
+#ifndef	CONFIG_USB_ZAURUS
+	/* if we couldn't whitelist Zaurus, we must blacklist it */
+{
+	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE, 
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8004,
+	/* match the master interface */
+	.bInterfaceClass	= USB_CLASS_COMM,
+	.bInterfaceSubClass	= 6 /* Ethernet model */,
+	.bInterfaceProtocol	= 0,
+	.driver_info 		= 0, /* BLACKLIST */
+},
+	// FIXME blacklist the other Zaurus models too, sigh
+#endif
+
+{
+	/* CDC Ether uses two interfaces, not necessarily consecutive.
+	 * We match the main interface, ignoring the optional device
+	 * class so we could handle devices that aren't exclusively
+	 * CDC ether.
+	 *
+	 * NOTE:  this match must come AFTER entries working around
+	 * bugs/quirks in a given product (like Zaurus, above).
+	 */
+	USB_INTERFACE_INFO (USB_CLASS_COMM, 6 /* Ethernet model */, 0),
+	.driver_info = (unsigned long) &cdc_info,
 },
 #endif
 
@@ -2732,6 +3468,7 @@
 MODULE_DEVICE_TABLE (usb, products);
 
 static struct usb_driver usbnet_driver = {
+	.owner =	THIS_MODULE,
 	.name =		driver_name,
 	.id_table =	products,
 	.probe =	usbnet_probe,
@@ -2745,22 +3482,24 @@
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
 };
+
 /*-------------------------------------------------------------------------*/
 
 static int __init usbnet_init (void)
 {
-	// compiler should optimize this out
-	if (sizeof (((struct sk_buff *)0)->cb) < sizeof (struct skb_data))
-		BUG ();
+	// compiler should optimize these out
+	BUG_ON (sizeof (((struct sk_buff *)0)->cb)
+			< sizeof (struct skb_data));
+#ifdef	CONFIG_USB_CDCETHER
+	BUG_ON ((sizeof (((struct usbnet *)0)->data)
+			< sizeof (struct cdc_state)));
+#endif
 
 	get_random_bytes (node_id, sizeof node_id);
 	node_id [0] &= 0xfe;	// clear multicast bit
 	node_id [0] |= 0x02;    // set local assignment bit (IEEE802)
 
- 	if (usb_register (&usbnet_driver) < 0)
- 		return -1;
-
-	return 0;
+ 	return usb_register(&usbnet_driver);
 }
 module_init (usbnet_init);
 

--------------010104040907030907010005--

