Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293528AbSCCIcZ>; Sun, 3 Mar 2002 03:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293529AbSCCIcJ>; Sun, 3 Mar 2002 03:32:09 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:29920 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293528AbSCCIcE>; Sun, 3 Mar 2002 03:32:04 -0500
Date: Sun, 3 Mar 2002 10:18:35 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: David Ruggiero <jdavid@farfalle.com>, Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] 3c509 Update
Message-ID: <Pine.LNX.4.44.0203030914470.26828-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- 3c509 Full duplex support	(David Ruggiero)
- 3c509 Power management	(Zwane Mwaikambo)
- 3c509 Documentation		(David Ruggiero)

Regards,
	Zwane Mwaikambo

diff -urN linux-2.4.19-orig/Documentation/networking/3c509.txt linux-2.4.19/Documentation/networking/3c509.txt
--- linux-2.4.19-orig/Documentation/networking/3c509.txt	Thu Jan  1 02:00:00 1970
+++ linux-2.4.19/Documentation/networking/3c509.txt	Sun Mar  3 09:24:29 2002
@@ -0,0 +1,210 @@
+Linux and the 3Com EtherLink III Series Ethercards (driver v1.20 and higher)
+----------------------------------------------------------------------------
+
+This file contains the instructions and caveats for v1.20 and higher versions
+of the 3c509 driver. You should not use the driver without reading this file.
+
+release 1.0
+28 February 2002
+Current maintainer (corrections to):
+  David Ruggiero <jdr@farfalle.com>
+
+----------------------------------------------------------------------------
+
+(0) Introduction
+
+The following are notes and information on using the 3Com EtherLink III series
+ethercards in Linux. These cards are commonly known by the most widely-used
+card's 3Com model number, 3c509. They are all 10mb/s ISA-bus cards and shouldn't
+be (but sometimes are) confused with the similarly-numbered PCI-bus "3c905"
+(aka "Vortex" or "Boomerang") series.  Kernel support for the 3c509 family is
+provided by the module 3c509.c, which has code to support all of the following
+models:
+
+  3c509 (original ISA card)
+  3c509B (later revision of the ISA card; supports full-duplex)
+  3c589 (PCMCIA)
+  3c589B (later revision of the 3c589; supports full-duplex)
+  3c529 (MCA)
+  3c579 (EISA)
+
+Large portions of this documentation were heavily borrowed from the guide
+written the original author of the 3c509 driver, Donald Becker. The master
+copy of that document, which contains notes on older versions of the driver,
+currently resides on Scyld web server: http://www.scyld.com/network/3c509.html.
+
+
+(1) Special Driver Features
+
+Overriding card settings
+
+The driver allows boot- or load-time overriding of the card's detected IOADDR,
+IRQ, and transceiver settings, although this capability shouldn't generally be
+needed except to enable full-duplex mode (see below). An example of the syntax
+for LILO parameters for doing this:
+
+    ether=10,0x310,3,0x3c509,eth0 
+
+This configures the first found 3c509 card for IRQ 10, base I/O 0x310, and
+transceiver type 3 (10base2). The flag "0x3c509" must be set to avoid conflicts
+with other card types when overriding the I/O address. When the driver is
+loaded as a module, only the IRQ and transceiver setting may be overridden.
+For example, setting two cards to 10base2/IRQ10 and AUI/IRQ11 is done by using
+the xcvr and irq module options:
+
+   options 3c509 xcvr=3,3 irq=10,11
+
+
+(2) Full-duplex mode
+
+The v1.20 driver added support for the 3c509B's full-duplex capabilities.
+In order to enable and successfully use full-duplex mode, three conditions
+must be met: 
+
+(a) You must have a Etherlink III card model whose hardware supports full-
+duplex operations. Currently, the only members of the 3c509 family that are
+positively known to support full-duplex are the 3c509B (ISA bus) and 3c589B
+(PCMCIA) cards. Cards without the "B" model designation do *not* support
+full-duplex mode; these include the original 3c509 (no "B"), the original
+3c589, the 3c529 (MCA bus), and the 3c579 (EISA bus).
+
+(b) You must be using your card's 10baseT transceiver (i.e., the RJ-45
+connector), not its AUI (thick-net) or 10base2 (thin-net/coax) interfaces.
+AUI and 10base2 network cabling is physically incapable of full-duplex
+operation.
+
+(c) Most importantly, your 3c509B must be connected to a link partner that is
+itself full-duplex capable. This is almost certainly one of two things: a full-
+duplex-capable  Ethernet switch (*not* a hub), or a full-duplex-capable NIC on
+another system that's connected directly to the 3c509B via a crossover cable.
+ 
+/////Extremely important caution concerning full-duplex mode/////
+Understand that the 3c509B's hardware's full-duplex support is much more
+limited than that provide by more modern network interface cards. Although
+at the physical layer of the network it fully supports full-duplex operation,
+the card was designed before the current Ethernet auto-negotiation (N-way)
+spec was written. This means that the 3c509B family ***cannot and will not
+auto-negotiate a full-duplex connection with its link partner under any
+circumstances, no matter how it is initialized***. If the full-duplex mode
+of the 3c509B is enabled, its link partner will very likely need to be
+independently _forced_ into full-duplex mode as well; otherwise various nasty
+failures will occur - at the very least, you'll see massive numbers of packet
+collisions. This is one of very rare circumstances where disabling auto-
+negotiation and forcing the duplex mode of a network interface card or switch
+would ever be necessary or desirable.
+
+
+(3) Available Transceiver Types
+
+For versions of the driver v1.20 and above, the available transceiver types are:
+ 
+0  transceiver type from EEPROM config (normally 10baseT); force half-duplex
+1  AUI (thick-net / DB15 connector)
+2  (undefined)
+3  10base2 (thin-net == coax / BNC connector)
+4  10baseT (RJ-45 connector); force half-duplex mode
+8  transceiver type and duplex mode taken from card's EEPROM config settings
+12 10baseT (RJ-45 connector); force full-duplex mode
+
+Prior to driver version 1.20, only tranceiver codes 0-4 were supported. Note
+that the new transceiver codes 8 and 12 are the *only* ones that will enable
+full-duplex mode, no matter what the card's detected EEPROM settings might be.
+This insured that merely upgrading the driver from an earlier version would
+never automatically enable full-duplex mode in an existing installation;
+it must always be explicitly enabled via one of these code in order to be
+activated.
+  
+
+(4a) Interpretation of error messages and common problems
+
+Error Messages
+
+eth0: Infinite loop in interrupt, status 2011. 
+These are "mostly harmless" message indicating that the driver had too much
+work during that interrupt cycle. With a status of 0x2011 you are receiving
+packets faster than they can be removed from the card. This should be rare
+or impossible in normal operation. Possible causes of this error report are:
+ 
+   - a "green" mode enabled that slows the processor down when there is no
+     keyboard activitiy. 
+
+   - some other device or device driver hogging the bus or disabling interrupts.
+     Check /proc/interrupts for excessive interrupt counts. The timer tick
+     interrupt should always be incrementing faster than the others. 
+
+No received packets 
+If a 3c509, 3c562 or 3c589 can successfully transmit packets, but never
+receives packets (as reported by /proc/net/dev or 'ifconfig') you likely
+have an interrupt line problem. Check /proc/interrupts to verify that the
+card is actually generating interrupts. If the interrupt count is not
+increasing you likely have a physical conflict with two devices trying to
+use the same ISA IRQ line. The common conflict is with a sound card on IRQ10
+or IRQ5, and the easiest solution is to move the 3c509 to a different
+interrupt line. If the device is receiving packets but 'ping' doesn't work,
+you have a routing problem.
+
+Tx Carrier Errors Reported in /proc/net/dev 
+If an EtherLink III appears to transmit packets, but the "Tx carrier errors"
+field in /proc/net/dev increments as quickly as the Tx packet count, you
+likely have an unterminated network or the incorrect media tranceiver selected. 
+
+3c509B card is not detected on machines with an ISA PnP BIOS. 
+While the updated driver works with most PnP BIOS programs, it does not work
+with all. This can be fixed by disabling PnP support using the 3Com-supplied
+setup program. 
+
+3c509 card is not detected on overclocked machines 
+Increase the delay time in id_read_eeprom() from the current value, 500,
+to an absurdly high value, such as 5000. 
+
+
+(4b) Decoding Status and Error Messages
+
+The bits in the main status register are: 
+
+value 	description
+0x01 	Interrupt latch
+0x02 	Tx overrun, or Rx underrun
+0x04 	Tx complete
+0x08 	Tx FIFO room available
+0x10 	A complete Rx packet has arrived
+0x20 	A Rx packet has started to arrive
+0x40 	The driver has requested an interrupt
+0x80 	Statistics counter nearly full
+
+The bits in the transmit (Tx) status word are: 
+
+value 	description
+0x02 	Out-of-window collision.
+0x04 	Status stack overflow (normally impossible).
+0x08 	16 collisions.
+0x10 	Tx underrun (not enough PCI bus bandwidth).
+0x20 	Tx jabber.
+0x40 	Tx interrupt requested.
+0x80 	Status is valid (this should always be set).
+
+
+When a transmit error occurs the driver produces a status message such as 
+
+   eth0: Transmit error, Tx status register 82
+
+The two values typically seen here are:
+
+0x82 
+Out of window collision. This typically occurs when some other Ethernet
+host is incorrectly set to full duplex on a half duplex network. 
+
+0x88 
+16 collisions. This typically occurs when the network is exceptionally busy
+or when another host doesn't correctly back off after a collision. If this
+error is mixed with 0x82 errors it is the result of a host incorrectly set
+to full duplex (see above).
+
+Both of these errors are the result of network problems that should be
+corrected. They do not represent driver malfunction.
+
+
+(5) Revision history (this file)
+
+28Feb02 v1.0  DR   New; major portions based on Becker original 3c509 docs
+
Binary files linux-2.4.19-orig/drivers/net/.3c509.c.swp and linux-2.4.19/drivers/net/.3c509.c.swp differ
diff -urN linux-2.4.19-orig/drivers/net/3c509.c linux-2.4.19/drivers/net/3c509.c
--- linux-2.4.19-orig/drivers/net/3c509.c	Sun Mar  3 09:10:18 2002
+++ linux-2.4.19/drivers/net/3c509.c	Sun Mar  3 10:09:57 2002
@@ -45,11 +45,15 @@
 			- Reviewed against 1.18 from scyld.com
 		v1.18a 17Nov2001 Jeff Garzik <jgarzik@mandrakesoft.com>
 			- ethtool support
+		v1.18b 1Mar2002 Zwane Mwaikambo <zwane@commfireservices.com>
+			- Power Management support
+		v1.18c 1Mar2002 David Ruggiero <jdavid@farfalle.com>
+			- Full duplex support
 */
 
 #define DRV_NAME	"3c509"
-#define DRV_VERSION	"1.18a"
-#define DRV_RELDATE	"17Nov2001"
+#define DRV_VERSION	"1.18c"
+#define DRV_RELDATE	"1Mar2002"
 
 /* A few values that may be tweaked. */
 
@@ -82,8 +86,9 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <linux/pm.h>
 
-static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE "becker@scyld.com\n";
+static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
 static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";
 
 #ifdef EL3_DEBUG
@@ -116,7 +121,8 @@
 	FakeIntr = 12<<11, AckIntr = 13<<11, SetIntrEnb = 14<<11,
 	SetStatusEnb = 15<<11, SetRxFilter = 16<<11, SetRxThreshold = 17<<11,
 	SetTxThreshold = 18<<11, SetTxStart = 19<<11, StatsEnable = 21<<11,
-	StatsDisable = 22<<11, StopCoax = 23<<11,};
+	StatsDisable = 22<<11, StopCoax = 23<<11, PowerUp = 27<<11,
+	PowerDown = 28<<11, PowerAuto = 29<<11};
 
 enum c509status {
 	IntLatch = 0x0001, AdapterFailure = 0x0002, TxComplete = 0x0004,
@@ -136,7 +142,9 @@
 
 #define WN0_IRQ		0x08		/* Window 0: Set IRQ line in bits 12-15. */
 #define WN4_MEDIA	0x0A		/* Window 4: Various transcvr/media bits. */
-#define  MEDIA_TP	0x00C0		/* Enable link beat and jabber for 10baseT. */
+#define MEDIA_TP	0x00C0		/* Enable link beat and jabber for 10baseT. */
+#define WN4_NETDIAG	0x06            /* Window 4: Net diagnostic */
+#define FD_ENABLE	0x8000          /* Enable full-duplex ("external loopback") */  
 
 /*
  * Must be a power of two (we use a binary and in the
@@ -152,6 +160,9 @@
 	int head, size;
 	struct sk_buff *queue[SKB_QUEUE_SIZE];
 	char mca_slot;
+#ifdef CONFIG_PM
+	struct pm_dev *pmdev;
+#endif
 };
 static int id_port __initdata = 0x110;	/* Start with 0x110 to avoid new sound cards.*/
 static struct net_device *el3_root_dev;
@@ -168,6 +179,13 @@
 static void set_multicast_list(struct net_device *dev);
 static void el3_tx_timeout (struct net_device *dev);
 static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
+static void el3_down(struct net_device *dev);
+static void el3_up(struct net_device *dev);
+#ifdef CONFIG_PM
+static int el3_suspend(struct pm_dev *pdev);
+static int el3_resume(struct pm_dev *pdev);
+static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data);
+#endif
 
 #ifdef CONFIG_MCA
 struct el3_mca_adapters_struct {
@@ -219,7 +237,7 @@
 #endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 static int nopnp;
 
-int __init el3_probe(struct net_device *dev)
+int __init el3_probe(struct net_device *dev, int card_idx)
 {
 	struct el3_private *lp;
 	short lrs_state = 0xff, i;
@@ -486,12 +504,18 @@
 	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
-	dev->if_port = (dev->mem_start & 0x1f) ? dev->mem_start & 3 : if_port;
+	
+	if (dev->mem_start & 0x05) { /* xcvr codes 1/3/4/12 */
+		dev->if_port = (dev->mem_start & 0x0f);
+	} else { /* xcvr codes 0/8 */
+		/* use eeprom value, but save user's full-duplex selection */
+		dev->if_port = (if_port | (dev->mem_start & 0x08) );
+	}
 
 	{
 		const char *if_names[] = {"10baseT", "AUI", "undefined", "BNC"};
 		printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
-			   dev->name, dev->base_addr, if_names[dev->if_port]);
+			dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
 	}
 
 	/* Read in the station address. */
@@ -525,6 +549,16 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->do_ioctl = netdev_ioctl;
 
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
+#endif
+
 	/* Fill in the generic fields of the device structure. */
 	ether_setup(dev);
 	return 0;
@@ -581,53 +615,7 @@
 		printk("%s: Opening, IRQ %d	 status@%x %4.4x.\n", dev->name,
 			   dev->irq, ioaddr + EL3_STATUS, inw(ioaddr + EL3_STATUS));
 
-	/* Activate board: this is probably unnecessary. */
-	outw(0x0001, ioaddr + 4);
-
-	/* Set the IRQ line. */
-	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
-
-	/* Set the station address in window 2 each time opened. */
-	EL3WINDOW(2);
-
-	for (i = 0; i < 6; i++)
-		outb(dev->dev_addr[i], ioaddr + i);
-
-	if (dev->if_port == 3)
-		/* Start the thinnet transceiver. We should really wait 50ms...*/
-		outw(StartCoax, ioaddr + EL3_CMD);
-	else if (dev->if_port == 0) {
-		/* 10baseT interface, enabled link beat and jabber check. */
-		EL3WINDOW(4);
-		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
-	}
-
-	/* Switch to the stats window, and clear all stats by reading. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
-	EL3WINDOW(6);
-	for (i = 0; i < 9; i++)
-		inb(ioaddr + i);
-	inw(ioaddr + 10);
-	inw(ioaddr + 12);
-
-	/* Switch to register set 1 for normal use. */
-	EL3WINDOW(1);
-
-	/* Accept b-case and phys addr only. */
-	outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
-	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
-
-	netif_start_queue(dev);
-
-	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
-	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
-	/* Allow status bits to be seen. */
-	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
-	/* Ack all pending events, and set active indicator mask. */
-	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
-		 ioaddr + EL3_CMD);
-	outw(SetIntrEnb | IntLatch|TxAvailable|TxComplete|RxComplete|StatsFull,
-		 ioaddr + EL3_CMD);
+	el3_up(dev);
 
 	if (el3_debug > 3)
 		printk("%s: Opened 3c509  IRQ %d  status %4.4x.\n",
@@ -986,23 +974,7 @@
 	if (el3_debug > 2)
 		printk("%s: Shutting down ethercard.\n", dev->name);
 
-	netif_stop_queue(dev);
-
-	/* Turn off statistics ASAP.  We update lp->stats below. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
-
-	/* Disable the receiver and transmitter. */
-	outw(RxDisable, ioaddr + EL3_CMD);
-	outw(TxDisable, ioaddr + EL3_CMD);
-
-	if (dev->if_port == 3)
-		/* Turn off thinnet power.  Green! */
-		outw(StopCoax, ioaddr + EL3_CMD);
-	else if (dev->if_port == 0) {
-		/* Disable link beat and jabber, if_port may change ere next open(). */
-		EL3WINDOW(4);
-		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
-	}
+	el3_down(dev);
 
 	free_irq(dev->irq, dev);
 	/* Switching back to window 0 disables the IRQ. */
@@ -1010,7 +982,6 @@
 	/* But we explicitly zero the IRQ line select anyway. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
 
-	update_stats(dev);
 	return 0;
 }
 
@@ -1092,16 +1063,198 @@
 
 	return rc;
 }
- 
+
+static void el3_down(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+
+	netif_stop_queue(dev);
+
+	/* Turn off statistics ASAP.  We update lp->stats below. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+
+	/* Disable the receiver and transmitter. */
+	outw(RxDisable, ioaddr + EL3_CMD);
+	outw(TxDisable, ioaddr + EL3_CMD);
+
+	if (dev->if_port == 3)
+		/* Turn off thinnet power.  Green! */
+		outw(StopCoax, ioaddr + EL3_CMD);
+	else if (dev->if_port == 0) {
+		/* Disable link beat and jabber, if_port may change ere next open(). */
+		EL3WINDOW(4);
+		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
+	}
+
+	outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
+
+	update_stats(dev);
+}
+
+static void el3_up(struct net_device *dev)
+{
+	int i, sw_info, net_diag;
+	int ioaddr = dev->base_addr;
+	
+	/* Activating the board required and does no harm otherwise */
+	outw(0x0001, ioaddr + 4);
+
+	/* Set the IRQ line. */
+	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
+
+	/* Set the station address in window 2 each time opened. */
+	EL3WINDOW(2);
+
+	for (i = 0; i < 6; i++)
+		outb(dev->dev_addr[i], ioaddr + i);
+
+	if ((dev->if_port & 0x03) == 3) /* BNC interface */
+		/* Start the thinnet transceiver. We should really wait 50ms...*/
+		outw(StartCoax, ioaddr + EL3_CMD); 
+	else if ((dev->if_port & 0x03) == 0) { /* 10baseT interface */
+		/* Combine secondary sw_info word (the adapter level) and primary
+		   sw_info word (duplex setting plus other useless bits) */
+		EL3WINDOW(0);
+		sw_info = (read_eeprom(ioaddr, 0x14) & 0x400f) | 
+			(read_eeprom(ioaddr, 0x0d) & 0xBff0);
+
+		EL3WINDOW(4);
+		net_diag = inw(ioaddr + WN4_NETDIAG);
+		net_diag = (net_diag | FD_ENABLE); /* temporarily assume full-duplex will be set */
+		printk("%s: ", dev->name);
+		switch (dev->if_port & 0x0c) {
+			case 12:
+				/* force full-duplex mode if 3c5x9b */
+				if (sw_info & 0x000f) {
+					printk("Forcing 3c5x9b full-duplex mode");
+					break;
+				}
+			case 8:
+				/* set full-duplex mode based on eeprom config setting */
+				if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
+					printk("Setting 3c5x9b full-duplex mode (from EEPROM configuration bit)");
+					break;
+				}
+			default:
+				/* xcvr=(0 || 4) OR user has an old 3c5x9 non "B" model */
+				printk("Setting 3c5x9/3c5x9B half-duplex mode");
+				net_diag = (net_diag & ~FD_ENABLE); /* disable full duplex */
+		}
+
+		outw(net_diag, ioaddr + WN4_NETDIAG);
+		printk(" if_port: %d, sw_info: %4.4x\n", dev->if_port, sw_info);
+		if (el3_debug > 3)
+			printk("%s: 3c5x9 net diag word is now: %4.4x.\n", dev->name, net_diag);
+		/* Enable link beat and jabber check. */
+		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
+	}
+	
+	/* Switch to the stats window, and clear all stats by reading. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+	EL3WINDOW(6);
+	for (i = 0; i < 9; i++)
+		inb(ioaddr + i);
+	inw(ioaddr + 10);
+	inw(ioaddr + 12);
+
+	/* Switch to register set 1 for normal use. */
+	EL3WINDOW(1);
+
+	/* Accept b-case and phys addr only. */
+	outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
+	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
+
+	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
+	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
+	/* Allow status bits to be seen. */
+	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
+	/* Ack all pending events, and set active indicator mask. */
+	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
+		 ioaddr + EL3_CMD);
+	outw(SetIntrEnb | IntLatch|TxAvailable|TxComplete|RxComplete|StatsFull,
+		 ioaddr + EL3_CMD);
+
+	netif_start_queue(dev);
+}
+
+/* Power Management support functions */
+#ifdef CONFIG_PM
+
+static int el3_suspend(struct pm_dev *pdev)
+{
+	unsigned long flags;
+	struct net_device *dev;
+	struct el3_private *lp;
+	int ioaddr;
+	
+	if (!pdev && !pdev->data)
+		return -EINVAL;
+
+	dev = (struct net_device *)pdev->data;
+	lp = (struct el3_private *)dev->priv;
+	ioaddr = dev->base_addr;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	if (netif_running(dev))
+		netif_device_detach(dev);
+
+	el3_down(dev);
+	outw(PowerDown, ioaddr + EL3_CMD);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return 0;
+}
+
+static int el3_resume(struct pm_dev *pdev)
+{
+	unsigned long flags;
+	struct net_device *dev;
+	struct el3_private *lp;
+	int ioaddr;
+	
+	if (!pdev && !pdev->data)
+		return -EINVAL;
+
+	dev = (struct net_device *)pdev->data;
+	lp = (struct el3_private *)dev->priv;
+	ioaddr = dev->base_addr;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	outw(PowerUp, ioaddr + EL3_CMD);
+	el3_up(dev);
+
+	if (netif_running(dev))
+		netif_device_attach(dev);
+		
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return 0;
+}
+
+static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
+{
+	switch (rqst) {
+		case PM_SUSPEND:
+			return el3_suspend(pdev);
+
+		case PM_RESUME:
+			return el3_resume(pdev);
+	}
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 #ifdef MODULE
 /* Parameters that may be passed into the module. */
 static int debug = -1;
 static int irq[] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int xcvr[] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int xcvr[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
 
 MODULE_PARM(debug,"i");
 MODULE_PARM(irq,"1-8i");
-MODULE_PARM(xcvr,"1-8i");
+MODULE_PARM(xcvr,"1-12i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM_DESC(debug, "EtherLink III debug level (0-6)");
 MODULE_PARM_DESC(irq, "EtherLink III IRQ number(s) (assigned)");
@@ -1121,7 +1274,7 @@
 		el3_debug = debug;
 
 	el3_root_dev = NULL;
-	while (el3_probe(0) == 0) {
+	while (el3_probe(0, el3_cards) == 0) {
 		if (irq[el3_cards] > 1)
 			el3_root_dev->irq = irq[el3_cards];
 		if (xcvr[el3_cards] >= 0)
@@ -1143,7 +1296,12 @@
 #ifdef CONFIG_MCA		
 		if(lp->mca_slot!=-1)
 			mca_mark_as_unused(lp->mca_slot);
-#endif			
+#endif
+
+#ifdef CONFIG_PM
+		if (lp->pmdev)
+			pm_unregister(lp->pmdev);
+#endif
 		next_dev = lp->next_dev;
 		unregister_netdev(el3_root_dev);
 		release_region(el3_root_dev->base_addr, EL3_IO_EXTENT);


