Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267676AbRGUPct>; Sat, 21 Jul 2001 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbRGUPcl>; Sat, 21 Jul 2001 11:32:41 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:13739 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267676AbRGUPcb>; Sat, 21 Jul 2001 11:32:31 -0400
Message-ID: <3B59A0D7.29CA7768@uow.edu.au>
Date: Sun, 22 Jul 2001 01:33:43 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Parag Warudkar <parag.warudkar@Wipro.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 3c59x Problems
In-Reply-To: <3B599DB7.7050602@Wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Parag Warudkar wrote:
> 
> Hello,
>             I have a 3c905C and get following errors under medium
> network loads.
> The hub, network, and all other stuff is quite good. Also on same
> machine Win2K gave
> no problems. When the error occurs, I get transfer speeds of 0.43 Kbps.
> I never experienced the
> same with Win2K.

You have a duplex mismatch.  Perhaps win2k is running at half duplex.

> DMESG OUTPUT
> 
> 3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others.
> http://www.scyld.com/network/vortex.html
> See Documentation/networking/vortex.txt
> 01:0c.0: 3Com PCI 3c905C Tornado at 0xec80,  00:b0:d0:69:77:71, IRQ 5
>   product code 0000 rev 00.14 date 07-16-104
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
>   MII transceiver found at address 24, status 782d.
>   Enabling bus-master transmits and whole-frame receives.
> 01:0c.0: scatter/gather disabled. h/w checksums enabled
> eth0: using NWAY device table, not 8
> 
> eth0: Transmit error, Tx status register 82.
> Probably a duplex mismatch.  See Documentation/networking/vortex.txt

Was this not helpful?

> Is there any update for the 3c59x driver for 2.4.x kernels?

Yes, there is.  It's below.

It could just conceivably help - it changes the driver so that
we no longer reset the transceiver at open/close time.  This
resetting has the potential to confuse autonegotiation, and it
can happen quite frequently as the dhcp client software likes
to open and close the interface rapidly.  The concept was
borrowed from Donald Becker's latest 3c59x.c.

Please test - if it helps, please let me know.  If it doesn't,
please send me a full report as per the final section of
Documentation/networking/vortex.txt.

Thanks.



--- linux-2.4.7/drivers/net/3c59x.c	Wed Jul  4 18:21:26 2001
+++ linux-akpm/drivers/net/3c59x.c	Sun Jul 22 01:36:21 2001
@@ -9,9 +9,13 @@
 	Members of the series include Fast EtherLink 3c590/3c592/3c595/3c597
 	and the EtherLink XL 3c900 and 3c905 cards.
 
+	Problem reports and questions should be directed to
+	vortex@scyld.com
+
 	The author may be reached as becker@scyld.com, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	Linux Kernel Additions:
 	
@@ -50,7 +54,7 @@
     - Put vortex_info_tbl into __devinitdata
     - In the vortex_error StatsFull HACK, disable stats in vp->intr_enable as well
       as in the hardware.
-    - Increased the loop counter in wait_for_completion from 2,000 to 4,000.
+    - Increased the loop counter in issue_and_wait from 2,000 to 4,000.
 
     LK1.1.5 28 April 2000, andrewm
     - Added powerpc defines (John Daniel <jdaniel@etresoft.com> said these work...)
@@ -121,7 +125,7 @@
    LK1.1.12 1 Jan 2001 andrewm (2.4.0-pre1)
     - Call pci_enable_device before we request our IRQ (Tobias Ringstrom)
     - Add 3c590 PCI latency timer hack to vortex_probe1 (from 0.99Ra)
-    - Added extended wait_for_completion for the 3c905CX.
+    - Added extended issue_and_wait for the 3c905CX.
     - Look for an MII on PHY index 24 first (3c905CX oddity).
     - Add HAS_NWAY to 3cSOHO100-TX (Brett Frankenberger)
     - Don't free skbs we don't own on oom path in vortex_open().
@@ -149,6 +153,19 @@
     - Implemented alloc_etherdev() API
     - Special-case the 'Tx error 82' message.
 
+   LK1.1.16 18 July 2001 akpm
+    - Make NETIF_F_SG dependent upon nr_free_highpages(), not on CONFIG_HIGHMEM
+    - Lessen verbosity of bootup messages
+    - Fix WOL - use new PM API functions.
+    - Use netif_running() instead of vp->open in suspend/resume.
+    - Don't reset the interface logic on open/close/rmmod.  It upsets
+      autonegotiation, and hence DHCP (from 0.99T).
+    - Back out EEPROM_NORESET flag because of the above (we do it for all
+      NICs).
+    - Correct 3c982 identification string
+    - Rename wait_for_completion() to issue_and_wait() to avoid completion.h
+      clash.
+
     - See http://www.uow.edu.au/~andrewm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 */
@@ -164,8 +181,8 @@
 
 
 #define DRV_NAME	"3c59x"
-#define DRV_VERSION	"LK1.1.15"
-#define DRV_RELDATE	"6 June 2001"
+#define DRV_VERSION	"LK1.1.16"
+#define DRV_RELDATE	"19 July 2001"
 
 
 
@@ -230,6 +247,7 @@ static int vortex_debug = 1;
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
+#include <linux/highmem.h>
 #include <asm/irq.h>			/* For NR_IRQS only. */
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -244,10 +262,11 @@ static int vortex_debug = 1;
 
 
 static char version[] __devinitdata =
-DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE "  Donald Becker and others. http://www.scyld.com/network/vortex.html\n";
+DRV_NAME ": Donald Becker and others. www.scyld.com/network/vortex.html\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
-MODULE_DESCRIPTION("3Com 3c59x/3c90x/3c575 series Vortex/Boomerang/Cyclone driver");
+MODULE_DESCRIPTION("3Com 3c59x/3c9xx ethernet driver "
+					DRV_VERSION " " DRV_RELDATE);
 MODULE_PARM(debug, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
@@ -379,7 +398,7 @@ enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_C
 	EEPROM_8BIT=0x10,	/* AKPM: Uses 0x230 as the base bitmaps for EEPROM reads */
 	HAS_PWR_CTRL=0x20, HAS_MII=0x40, HAS_NWAY=0x80, HAS_CB_FNS=0x100,
 	INVERT_MII_PWR=0x200, INVERT_LED_PWR=0x400, MAX_COLLISION_RESET=0x800,
-	EEPROM_OFFSET=0x1000, EEPROM_NORESET=0x2000, HAS_HWCKSM=0x4000 };
+	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000 };
 
 enum vortex_chips {
 	CH_3C590 = 0,
@@ -475,7 +494,7 @@ static struct vortex_chip_info {
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c980 Cyclone",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
-	{"3c980 10/100 Base-TX NIC(Python-T)",
+	{"3c982 Dual Port Server Cyclone",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 
 	{"3cSOHO100-TX Hurricane",
@@ -487,7 +506,7 @@ static struct vortex_chip_info {
 									HAS_HWCKSM, 128, },
 	{"3c556B Laptop Hurricane",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_OFFSET|HAS_CB_FNS|INVERT_MII_PWR|
-									EEPROM_NORESET|HAS_HWCKSM, 128, },
+									HAS_HWCKSM, 128, },
 	{"3c575 [Megahertz] 10/100 LAN 	CardBus",
 	PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
 
@@ -752,6 +771,7 @@ struct vortex_private {
 		partner_flow_ctrl:1,			/* Partner supports flow control */
 		has_nway:1,
 		enable_wol:1,					/* Wake-on-LAN is enabled */
+		pm_state_valid:1,				/* power_state[] has sane contents */
 		open:1,
 		medialock:1,
 		must_free_region:1;				/* Flag: if zero, Cardbus owns the I/O region */
@@ -767,6 +787,7 @@ struct vortex_private {
 	u16 io_size;						/* Size of PCI region (for release_region) */
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
+	u32 power_state[16];
 };
 
 /* The action to take with a media selection timer tick.
@@ -847,11 +868,8 @@ static int vortex_suspend (struct pci_de
 {
 	struct net_device *dev = pdev->driver_data;
 
-	printk(KERN_DEBUG "vortex_suspend(%s)\n", dev->name);
-
 	if (dev && dev->priv) {
-		struct vortex_private *vp = (struct vortex_private *)dev->priv;
-		if (vp->open) {
+		if (netif_running(dev)) {
 			netif_device_detach(dev);
 			vortex_down(dev);
 		}
@@ -863,11 +881,8 @@ static int vortex_resume (struct pci_dev
 {
 	struct net_device *dev = pdev->driver_data;
 
-	printk(KERN_DEBUG "vortex_resume(%s)\n", dev->name);
-
 	if (dev && dev->priv) {
-		struct vortex_private *vp = (struct vortex_private *)dev->priv;
-		if (vp->open) {
+		if (netif_running(dev)) {
 			vortex_up(dev);
 			netif_device_attach(dev);
 		}
@@ -958,13 +973,12 @@ static int __devinit vortex_probe1(struc
 	int i, step;
 	struct net_device *dev;
 	static int printed_version;
-	int retval;
+	int retval, print_info;
 	struct vortex_chip_info * const vci = &vortex_info_tbl[chip_idx];
 	char *print_name;
 
 	if (!printed_version) {
 		printk (KERN_INFO "%s", version);
-		printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
 		printed_version = 1;
 	}
 
@@ -977,14 +991,40 @@ static int __devinit vortex_probe1(struc
 		goto out;
 	}
 	SET_MODULE_OWNER(dev);
+	vp = dev->priv;
+
+	/* The lower four bits are the media type. */
+	if (dev->mem_start) {
+		/*
+		 * The 'options' param is passed in as the third arg to the
+		 * LILO 'ether=' argument for non-modular use
+		 */
+		option = dev->mem_start;
+	}
+	else if (card_idx < MAX_UNITS)
+		option = options[card_idx];
+	else
+		option = -1;
 
-	printk(KERN_INFO "%s: 3Com %s %s at 0x%lx, ",
+	if (option > 0) {
+		if (option & 0x8000)
+			vortex_debug = 7;
+		if (option & 0x4000)
+			vortex_debug = 2;
+		if (option & 0x0400)
+			vp->enable_wol = 1;
+	}
+
+	print_info = (vortex_debug > 1);
+	if (print_info)
+		printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
+
+	printk(KERN_INFO "%s: 3Com %s %s at 0x%lx. Vers " DRV_VERSION "\n",
 	       print_name,
 	       pdev ? "PCI" : "EISA",
 	       vci->name,
 	       ioaddr);
 
-	vp = dev->priv;
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 	dev->mtu = mtu;
@@ -1048,19 +1088,6 @@ static int __devinit vortex_probe1(struc
 	if (pdev)
 		pci_set_drvdata(pdev, dev);
 
-	/* The lower four bits are the media type. */
-	if (dev->mem_start) {
-		/*
-		 * AKPM: ewww..  The 'options' param is passed in as the third arg to the
-		 * LILO 'ether=' argument for non-modular use
-		 */
-		option = dev->mem_start;
-	}
-	else if (card_idx < MAX_UNITS)
-		option = options[card_idx];
-	else
-		option = -1;
-
 	vp->media_override = 7;
 	if (option >= 0) {
 		vp->media_override = ((option & 7) == 2)  ?  0  :  option & 15;
@@ -1117,27 +1144,33 @@ static int __devinit vortex_probe1(struc
 		printk(" ***INVALID CHECKSUM %4.4x*** ", checksum);
 	for (i = 0; i < 3; i++)
 		((u16 *)dev->dev_addr)[i] = htons(eeprom[i + 10]);
-	for (i = 0; i < 6; i++)
-		printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
+	if (print_info) {
+		for (i = 0; i < 6; i++)
+			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
+	}
 	EL3WINDOW(2);
 	for (i = 0; i < 6; i++)
 		outb(dev->dev_addr[i], ioaddr + i);
 
 #ifdef __sparc__
-	printk(", IRQ %s\n", __irq_itoa(dev->irq));
+	if (print_info)
+		printk(", IRQ %s\n", __irq_itoa(dev->irq));
 #else
-	printk(", IRQ %d\n", dev->irq);
+	if (print_info)
+		printk(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
-	if (vortex_debug && (dev->irq <= 0 || dev->irq >= NR_IRQS))
+	if (dev->irq <= 0 || dev->irq >= NR_IRQS)
 		printk(KERN_WARNING " *** Warning: IRQ %d is unlikely to work! ***\n",
 			   dev->irq);
 #endif
 
 	EL3WINDOW(4);
 	step = (inb(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
-	printk(KERN_INFO "  product code %02x%02x rev %02x.%d date %02d-"
-		   "%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
-		   step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+	if (print_info) {
+		printk(KERN_INFO "  product code %02x%02x rev %02x.%d date %02d-"
+			"%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
+			step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+	}
 
 
 	if (pdev && vci->drv_flags & HAS_CB_FNS) {
@@ -1151,8 +1184,10 @@ static int __devinit vortex_probe1(struc
 			if (!vp->cb_fn_base)
 				goto free_ring;
 		}
-		printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
-			   print_name, fn_st_addr, vp->cb_fn_base);
+		if (print_info) {
+			printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
+				print_name, fn_st_addr, vp->cb_fn_base);
+		}
 		EL3WINDOW(2);
 
 		n = inw(ioaddr + Wn2_ResetOptions) & ~0x4010;
@@ -1170,7 +1205,8 @@ static int __devinit vortex_probe1(struc
 
 	if (vp->info1 & 0x8000) {
 		vp->full_duplex = 1;
-		printk(KERN_INFO "Full duplex capable\n");
+		if (print_info)
+			printk(KERN_INFO "Full duplex capable\n");
 	}
 
 	{
@@ -1181,16 +1217,17 @@ static int __devinit vortex_probe1(struc
 		if ((vp->available_media & 0xff) == 0)		/* Broken 3c916 */
 			vp->available_media = 0x40;
 		config = inl(ioaddr + Wn3_Config);
-		if (vortex_debug > 1)
+		if (print_info) {
 			printk(KERN_DEBUG "  Internal config register is %4.4x, "
 				   "transceivers %#x.\n", config, inw(ioaddr + Wn3_Options));
-		printk(KERN_INFO "  %dK %s-wide RAM %s Rx:Tx split, %s%s interface.\n",
-			   8 << RAM_SIZE(config),
-			   RAM_WIDTH(config) ? "word" : "byte",
-			   ram_split[RAM_SPLIT(config)],
-			   AUTOSELECT(config) ? "autoselect/" : "",
-			   XCVR(config) > XCVR_ExtMII ? "<invalid transceiver>" :
-			   media_tbl[XCVR(config)].name);
+			printk(KERN_INFO "  %dK %s-wide RAM %s Rx:Tx split, %s%s interface.\n",
+				   8 << RAM_SIZE(config),
+				   RAM_WIDTH(config) ? "word" : "byte",
+				   ram_split[RAM_SPLIT(config)],
+				   AUTOSELECT(config) ? "autoselect/" : "",
+				   XCVR(config) > XCVR_ExtMII ? "<invalid transceiver>" :
+				   media_tbl[XCVR(config)].name);
+		}
 		vp->default_media = XCVR(config);
 		if (vp->default_media == XCVR_NWAY)
 			vp->has_nway = 1;
@@ -1198,8 +1235,9 @@ static int __devinit vortex_probe1(struc
 	}
 
 	if (vp->media_override != 7) {
-		printk(KERN_INFO "  Media override to transceiver type %d (%s).\n",
-			   vp->media_override, media_tbl[vp->media_override].name);
+		printk(KERN_INFO "%s:  Media override to transceiver type %d (%s).\n",
+				print_name, vp->media_override,
+				media_tbl[vp->media_override].name);
 		dev->if_port = vp->media_override;
 	} else
 		dev->if_port = vp->default_media;
@@ -1226,8 +1264,10 @@ static int __devinit vortex_probe1(struc
 			mii_status = mdio_read(dev, phyx, 1);
 			if (mii_status  &&  mii_status != 0xffff) {
 				vp->phys[phy_idx++] = phyx;
-				printk(KERN_INFO "  MII transceiver found at address %d,"
-					   " status %4x.\n", phyx, mii_status);
+				if (print_info) {
+					printk(KERN_INFO "  MII transceiver found at address %d,"
+						" status %4x.\n", phyx, mii_status);
+				}
 				if ((mii_status & 0x0040) == 0)
 					mii_preamble_required++;
 			}
@@ -1246,13 +1286,12 @@ static int __devinit vortex_probe1(struc
 		}
 	}
 
-	if (pdev && vp->enable_wol && (vp->capabilities & CapPwrMgmt))
-		acpi_set_WOL(dev);
-
 	if (vp->capabilities & CapBusMaster) {
 		vp->full_bus_master_tx = 1;
-		printk(KERN_INFO"  Enabling bus-master transmits and %s receives.\n",
-			   (vp->info2 & 1) ? "early" : "whole-frame" );
+		if (print_info) {
+			printk(KERN_INFO "  Enabling bus-master transmits and %s receives.\n",
+			(vp->info2 & 1) ? "early" : "whole-frame" );
+		}
 		vp->full_bus_master_rx = (vp->info2 & 1) ? 1 : 2;
 		vp->bus_master = 0;		/* AKPM: vortex only */
 	}
@@ -1261,10 +1300,10 @@ static int __devinit vortex_probe1(struc
 	dev->open = vortex_open;
 	if (vp->full_bus_master_tx) {
 		dev->hard_start_xmit = boomerang_start_xmit;
-#ifndef CONFIG_HIGHMEM
-		/* Actually, it still should work with iommu. */
-		dev->features |= NETIF_F_SG;
-#endif
+		if (nr_free_highpages() == 0) {
+			/* Actually, it still should work with iommu. */
+			dev->features |= NETIF_F_SG;
+		}
 		if (((hw_checksums[card_idx] == -1) && (vp->drv_flags & HAS_HWCKSM)) ||
 					(hw_checksums[card_idx] == 1)) {
 				dev->features |= NETIF_F_IP_CSUM;
@@ -1273,7 +1312,7 @@ static int __devinit vortex_probe1(struc
 		dev->hard_start_xmit = vortex_start_xmit;
 	}
 
-	if (vortex_debug > 0) {
+	if (print_info) {
 		printk(KERN_INFO "%s: scatter/gather %sabled. h/w checksums %sabled\n",
 				print_name,
 				(dev->features & NETIF_F_SG) ? "en":"dis",
@@ -1286,6 +1325,11 @@ static int __devinit vortex_probe1(struc
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
+	if (pdev && vp->enable_wol) {
+		vp->pm_state_valid = 1;
+ 		pci_save_state(vp->pdev, vp->power_state);
+ 		acpi_set_WOL(dev);
+	}
 	retval = register_netdev(dev);
 	if (retval == 0)
 		return 0;
@@ -1306,7 +1350,7 @@ out:
 }
 
 static void
-wait_for_completion(struct net_device *dev, int cmd)
+issue_and_wait(struct net_device *dev, int cmd)
 {
 	int i;
 
@@ -1338,8 +1382,10 @@ vortex_up(struct net_device *dev)
 	unsigned int config;
 	int i;
 
-	if (vp->pdev && vp->enable_wol)			/* AKPM: test not needed? */
+	if (vp->pdev && vp->enable_wol) {
 		pci_set_power_state(vp->pdev, 0);	/* Go active */
+		pci_restore_state(vp->pdev, vp->power_state);
+	}
 
 	/* Before initializing select the active media port. */
 	EL3WINDOW(3);
@@ -1352,19 +1398,23 @@ vortex_up(struct net_device *dev)
 		dev->if_port = vp->media_override;
 	} else if (vp->autoselect) {
 		if (vp->has_nway) {
-			printk(KERN_INFO "%s: using NWAY device table, not %d\n", dev->name, dev->if_port);
+			if (vortex_debug > 1)
+				printk(KERN_INFO "%s: using NWAY device table, not %d\n",
+								dev->name, dev->if_port);
 			dev->if_port = XCVR_NWAY;
 		} else {
 			/* Find first available media type, starting with 100baseTx. */
 			dev->if_port = XCVR_100baseTx;
 			while (! (vp->available_media & media_tbl[dev->if_port].mask))
 				dev->if_port = media_tbl[dev->if_port].next;
-			printk(KERN_INFO "%s: first available media type: %s\n",
+			if (vortex_debug > 1)
+				printk(KERN_INFO "%s: first available media type: %s\n",
 					dev->name, media_tbl[dev->if_port].name);
 		}
 	} else {
 		dev->if_port = vp->default_media;
-		printk(KERN_INFO "%s: using default media %s\n",
+		if (vortex_debug > 1)
+			printk(KERN_INFO "%s: using default media %s\n",
 				dev->name, media_tbl[dev->if_port].name);
 	}
 
@@ -1420,8 +1470,11 @@ vortex_up(struct net_device *dev)
 			dev->name, config);
 	}
 
-	wait_for_completion(dev, TxReset);
-	wait_for_completion(dev, RxReset);
+	issue_and_wait(dev, TxReset);
+	/*
+	 * Don't reset the PHY - that upsets autonegotiation during DHCP operations.
+	 */
+	issue_and_wait(dev, RxReset|0x04);
 
 	outw(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
 
@@ -1494,7 +1547,7 @@ vortex_up(struct net_device *dev)
 	set_rx_mode(dev);
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
-//	wait_for_completion(dev, SetTxStart|0x07ff);
+//	issue_and_wait(dev, SetTxStart|0x07ff);
 	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
 	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
 	/* Allow status bits to be seen. */
@@ -1523,9 +1576,6 @@ vortex_open(struct net_device *dev)
 	int i;
 	int retval;
 
-	if (vp->pdev && vp->enable_wol)				/* AKPM: test not needed? */
-		pci_set_power_state(vp->pdev, 0);		/* Go active */
-
 	/* Use the now-standard shared IRQ implementation. */
 	if ((retval = request_irq(dev->irq, vp->full_bus_master_rx ?
 				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev))) {
@@ -1566,7 +1616,6 @@ vortex_open(struct net_device *dev)
 	}
 
 	vortex_up(dev);
-	vp->open = 1;
 	return 0;
 
 out_free_irq:
@@ -1732,7 +1781,7 @@ static void vortex_tx_timeout(struct net
 	if (vortex_debug > 0)
 		dump_tx_ring(dev);
 
-	wait_for_completion(dev, TxReset);
+	issue_and_wait(dev, TxReset);
 
 	vp->stats.tx_errors++;
 	if (vp->full_bus_master_tx) {
@@ -1842,12 +1891,13 @@ vortex_error(struct net_device *dev, int
 
 			/* In this case, blow the card away */
 			vortex_down(dev);
-			wait_for_completion(dev, TotalReset | 0xff);
+			issue_and_wait(dev, TotalReset | 0xff);
 			vortex_up(dev);		/* AKPM: bug.  vortex_up() assumes that the rx ring is full. It may not be. */
 		} else if (fifo_diag & 0x0400)
 			do_tx_reset = 1;
 		if (fifo_diag & 0x3000) {
-			wait_for_completion(dev, RxReset);
+			/* Reset Rx fifo and upload logic */
+			issue_and_wait(dev, RxReset|0x07);
 			/* Set the Rx filter to the current state. */
 			set_rx_mode(dev);
 			outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
@@ -1856,7 +1906,7 @@ vortex_error(struct net_device *dev, int
 	}
 
 	if (do_tx_reset) {
-		wait_for_completion(dev, TxReset|reset_mask);
+		issue_and_wait(dev, TxReset|reset_mask);
 		outw(TxEnable, ioaddr + EL3_CMD);
 		if (!vp->full_bus_master_tx)
 			netif_wake_queue(dev);
@@ -1908,7 +1958,7 @@ vortex_start_xmit(struct sk_buff *skb, s
 				if (tx_status & 0x04) vp->stats.tx_fifo_errors++;
 				if (tx_status & 0x38) vp->stats.tx_aborted_errors++;
 				if (tx_status & 0x30) {
-					wait_for_completion(dev, TxReset);
+					issue_and_wait(dev, TxReset);
 				}
 				outw(TxEnable, ioaddr + EL3_CMD);
 			}
@@ -1985,7 +2035,7 @@ boomerang_start_xmit(struct sk_buff *skb
 
 	spin_lock_irqsave(&vp->lock, flags);
 	/* Wait for the stall to complete. */
-	wait_for_completion(dev, DownStall);
+	issue_and_wait(dev, DownStall);
 	prev_entry->next = cpu_to_le32(vp->tx_ring_dma + entry * sizeof(struct boom_tx_desc));
 	if (inl(ioaddr + DownListPtr) == 0) {
 		outl(vp->tx_ring_dma + entry * sizeof(struct boom_tx_desc), ioaddr + DownListPtr);
@@ -2306,7 +2356,7 @@ static int vortex_rx(struct net_device *
 					   "size %d.\n", dev->name, pkt_len);
 		}
 		vp->stats.rx_dropped++;
-		wait_for_completion(dev, RxDiscard);
+		issue_and_wait(dev, RxDiscard);
 	}
 
 	return 0;
@@ -2459,8 +2509,10 @@ vortex_down(struct net_device *dev)
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (vp->pdev && vp->enable_wol && (vp->capabilities & CapPwrMgmt))
+	if (vp->pdev && vp->enable_wol) {
+		pci_save_state(vp->pdev, vp->power_state);
 		acpi_set_WOL(dev);
+	}
 }
 
 static int
@@ -2522,7 +2574,6 @@ vortex_close(struct net_device *dev)
 		}
 	}
 
-	vp->open = 0;
 	return 0;
 }
 
@@ -2544,7 +2595,7 @@ dump_tx_ring(struct net_device *dev)
 			printk(KERN_ERR "  Transmit list %8.8x vs. %p.\n",
 				   inl(ioaddr + DownListPtr),
 				   &vp->tx_ring[vp->dirty_tx % TX_RING_SIZE]);
-			wait_for_completion(dev, DownStall);
+			issue_and_wait(dev, DownStall);
 			for (i = 0; i < TX_RING_SIZE; i++) {
 				printk(KERN_ERR "  %d: @%p  length %8.8x status %8.8x\n", i,
 					   &vp->tx_ring[i],
@@ -2821,8 +2872,10 @@ static void acpi_set_WOL(struct net_devi
 	/* The RxFilter must accept the WOL frames. */
 	outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
 	outw(RxEnable, ioaddr + EL3_CMD);
+
 	/* Change the power state to D3; RxEnable doesn't take effect. */
-	pci_set_power_state(vp->pdev, 0x8103);
+	pci_enable_wake(vp->pdev, 0, 1);
+	pci_set_power_state(vp->pdev, 3);
 }
 
 
@@ -2843,8 +2896,15 @@ static void __devexit vortex_remove_one 
 	 * here
 	 */
 	unregister_netdev(dev);
-	/* Should really use wait_for_completion() here */
-	outw((vp->drv_flags & EEPROM_NORESET) ? (TotalReset|0x10) : TotalReset, dev->base_addr + EL3_CMD);
+	/* Should really use issue_and_wait() here */
+	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
+
+	if (vp->pdev && vp->enable_wol) {
+		pci_set_power_state(vp->pdev, 0);	/* Go active */
+		if (vp->pm_state_valid)
+			pci_restore_state(vp->pdev, vp->power_state);
+	}
+
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
 							+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
--- linux-2.4.7/drivers/pci/pci.ids	Wed Jul  4 18:21:27 2001
+++ linux-akpm/drivers/pci/pci.ids	Sun Jul 22 01:36:21 2001
@@ -1561,8 +1561,8 @@
 		10b7 1000  3C905C-TX Fast Etherlink for PC Management NIC
 	9800  3c980-TX [Fast Etherlink XL Server Adapter]
 		10b7 9800  3c980-TX Fast Etherlink XL Server Adapter
-	9805  3c980-TX 10/100baseTX NIC [Python-T]
-		10b7 9805  3c980 10/100baseTX NIC [Python-T]
+	9805  3c982 Dual Port Server Cyclone
+		10b7 9805  3c982 Dual Port Server Cyclone
 10b8  Standard Microsystems Corp [SMC]
 	0005  83C170QF
 		1055 e000  LANEPIC
--- linux-2.4.7/Documentation/networking/vortex.txt	Wed Jul  4 18:21:24 2001
+++ linux-akpm/Documentation/networking/vortex.txt	Sun Jul 22 01:37:40 2001
@@ -88,7 +88,7 @@ options=N1,N2,N3,...
   The individual options are composed of a number of bitfields which
   have the following meanings:
 
-  ssible media type settings
+  Possible media type settings
 	0	10baseT
 	1	10Mbs AUI
 	2	undefined
@@ -104,8 +104,11 @@ options=N1,N2,N3,...
   When generating a value for the 'options' setting, the above media
   selection values may be OR'ed (or added to) the following:
 
-  512  (0x200)	Force full duplex mode.
-  16   (0x10)	Bus-master enable bit (Old Vortex cards only)
+  0x8000  Set driver debugging level to 7
+  0x4000  Set driver debugging level to 2
+  0x0400  Enable Wake-on-LAN
+  0x0200  Force full duplex mode.
+  0x0010  Bus-master enable bit (Old Vortex cards only)
 
   For example:
 
@@ -359,6 +362,11 @@ steps you should take:
      8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
      MII transceiver found at address 24, status 782d.
      Enabling bus-master transmits and whole-frame receives.
+
+     NOTE: You must provide the `debug=2' modprobe option to generate
+     a full detection message.  Please do this:
+
+	modprobe 3c59x debug=2
 
    o If it is a PCI device, the relevant output from 'lspci -vx', eg:
