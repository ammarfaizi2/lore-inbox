Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSJQLuz>; Thu, 17 Oct 2002 07:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSJQLuY>; Thu, 17 Oct 2002 07:50:24 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:6784 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261386AbSJQLe4>; Thu, 17 Oct 2002 07:34:56 -0400
Date: Thu, 17 Oct 2002 20:40:06 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] add support for PC-9800 architecture (14/26) network device
Message-ID: <20021017204006.A1229@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 14/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 network card modules
  - add support for PC-9800 legacy bus network cards.

diffstat:
 drivers/net/3c509.c      |   47 ++++
 drivers/net/8390.h       |    3 
 drivers/net/Config.in    |   24 ++
 drivers/net/Makefile     |    4 
 drivers/net/Makefile.lib |    1 
 drivers/net/Space.c      |    2 
 drivers/net/at1700.c     |  142 ++++++++++++
 drivers/net/ne.c         |  517 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ne2k_cbus.h  |  473 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1189 insertions(+), 24 deletions(-)

patch:
diff -Nru linux-2.5.42/drivers/net/3c509.c linux98-2.5.42/drivers/net/3c509.c
--- linux-2.5.42/drivers/net/3c509.c	Sat Oct 12 13:21:05 2002
+++ linux98-2.5.42/drivers/net/3c509.c	Tue Oct 15 23:03:22 2002
@@ -52,6 +52,10 @@
 		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
 			- Additional ethtool features
 */
+/*
+  FIXES for PC-9800:
+  Shu Iwanaga: 3c569B(PC-9801 C-bus) support
+*/
 
 #define DRV_NAME	"3c509"
 #define DRV_VERSION	"1.19"
@@ -168,11 +172,17 @@
 	struct pm_dev *pmdev;
 #endif
 };
+#ifdef CONFIG_PC9800
+static int id_port __initdata = 0x71d0;
+#else
 static int id_port __initdata = 0x110;	/* Start with 0x110 to avoid new sound cards.*/
+#endif
 static struct net_device *el3_root_dev;
 
 static ushort id_read_eeprom(int index);
+#ifndef CONFIG_PC9800
 static ushort read_eeprom(int ioaddr, int index);
+#endif
 static int el3_open(struct net_device *dev);
 static int el3_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void el3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -251,6 +261,7 @@
 
 	if (dev) SET_MODULE_OWNER(dev);
 
+#ifndef CONFIG_PC9800 /* PC-9800 never have EISA bus */
 	/* First check all slots of the EISA bus.  The next slot address to
 	   probe is kept in 'eisa_addr' to support multiple probe() calls. */
 	if (EISA_bus) {
@@ -286,6 +297,7 @@
 			goto found;
 		}
 	}
+#endif /* CONFIG_PC9800 : PC-9800 never have EISA bus */
 
 #ifdef CONFIG_MCA
 	/* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch, heavily
@@ -350,6 +362,7 @@
 		return -ENODEV;
 	}
 #endif /* CONFIG_MCA */
+#ifndef CONFIG_PC9800 /* ISA PnP is not supported yet ... */
 
 #ifdef __ISAPNP__
 	if (nopnp == 1)
@@ -407,6 +420,7 @@
 	   ID_PORT.  We find cards past the first by setting the 'current_tag'
 	   on cards as they are found.  Cards with their tag set will not
 	   respond to subsequent ID sequences. */
+#endif /* CONFIG_PC9800 : ISA PnP is not supported yet ... */
 
 	outb(0x00, id_port);
 	outb(0x00, id_port);
@@ -458,7 +472,11 @@
 	{
 		unsigned int iobase = id_read_eeprom(8);
 		if_port = iobase >> 14;
+#ifndef CONFIG_PC9800
 		ioaddr = 0x200 + ((iobase & 0x1f) << 4);
+#else
+		ioaddr = 0x40d0 + ((iobase & 0x1f) << 8);
+#endif
 	}
 	irq = id_read_eeprom(9) >> 12;
 
@@ -475,6 +493,14 @@
 		}
 	}
 
+#ifdef CONFIG_PC9800
+	if(irq==7){
+		irq = 6;
+	}else if(irq==15){
+		irq = 13;
+	}
+#endif
+
 	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509"))
 		return -EBUSY;
 
@@ -482,7 +508,11 @@
 	outb(0xd0 + ++current_tag, id_port);
 
 	/* Activate the adaptor at the EEPROM location. */
+#ifndef CONFIG_PC9800
 	outb((ioaddr >> 4) | 0xe0, id_port);
+#else
+	outb((ioaddr >> 8) | 0xe0, id_port);
+#endif
 
 	EL3WINDOW(0);
 	if (inw(ioaddr) != 0x6d50) {
@@ -492,7 +522,9 @@
 
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
+#if !defined(CONFIG_PC9800) || defined(CONFIG_MCA)
  found:
+#endif
 	if (dev == NULL) {
 		dev = init_etherdev(dev, sizeof(struct el3_private));
 		if (dev == NULL) {
@@ -564,6 +596,7 @@
 	return 0;
 }
 
+#ifndef CONFIG_PC9800 /* not used */
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
  */
@@ -574,6 +607,7 @@
 	udelay (500);
 	return inw(ioaddr + 12);
 }
+#endif /* CONFIG_PC9800 : not used */
 
 /* Read a word from the EEPROM when in the ISA ID probe state. */
 static ushort __init id_read_eeprom(int index)
@@ -1253,7 +1287,20 @@
 	outw(0x0001, ioaddr + 4);
 
 	/* Set the IRQ line. */
+#ifdef CONFIG_PC9800
+	switch(dev->irq){
+	case 6:
+		outw(0x7000|0x0f00,ioaddr+WN0_IRQ);
+		break;
+	case 13:
+		outw(0xf000|0x0f00,ioaddr+WN0_IRQ);
+		break;
+	default:
+#endif
 	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
+#ifdef CONFIG_PC9800
+	}
+#endif
 
 	/* Set the station address in window 2 each time opened. */
 	EL3WINDOW(2);
diff -Nru linux-2.5.42/drivers/net/8390.h linux98-2.5.42/drivers/net/8390.h
--- linux-2.5.42/drivers/net/8390.h	Sat Oct 12 13:22:14 2002
+++ linux98-2.5.42/drivers/net/8390.h	Tue Oct 15 23:03:22 2002
@@ -123,7 +123,8 @@
 #define inb_p(port)   in_8(port)
 #define outb_p(val,port)  out_8(port,val)
 
-#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE)
+#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE) || \
+      defined(CONFIG_NET_CBUS)
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #else
 #define EI_SHIFT(x)	(x)
diff -Nru linux-2.5.42/drivers/net/Config.in linux98-2.5.42/drivers/net/Config.in
--- linux-2.5.42/drivers/net/Config.in	Sat Oct 12 13:21:30 2002
+++ linux98-2.5.42/drivers/net/Config.in	Tue Oct 15 23:03:22 2002
@@ -112,7 +112,11 @@
       source drivers/net/tulip/Config.in
    fi
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_MCA" = "y" ]; then
+    if [ "$CONFIG_PC9800" != "y" ]; then
          dep_tristate '  AT1700/1720 support (EXPERIMENTAL)' CONFIG_AT1700 $CONFIG_EXPERIMENTAL
+    else
+         dep_tristate '  Allied Telesis RE1000Plus support (EXPERIMENTAL)' CONFIG_AT1700 $CONFIG_EXPERIMENTAL
+    fi
    fi
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_MCA" = "y" ]; then
       tristate '  DEPCA, DE10x, DE200, DE201, DE202, DE422 support' CONFIG_DEPCA
@@ -120,6 +124,7 @@
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
       tristate '  HP 10/100VG PCLAN (ISA, EISA, PCI) support' CONFIG_HP100
    fi
+  if [ "$CONFIG_PC9800" != "y" ]; then
    dep_bool '  Other ISA cards' CONFIG_NET_ISA $CONFIG_ISA
    if [ "$CONFIG_NET_ISA" = "y" ]; then
       tristate '    Cabletron E21xx support' CONFIG_E2100
@@ -146,6 +151,25 @@
       tristate '  NE/2 (ne2000 MCA version) support' CONFIG_NE2_MCA
       tristate '  IBM LAN Adapter/A support' CONFIG_IBMLANA
    fi
+  else	# CONFIG_PC9800 = y
+   bool '  NEC PC-9800 C-bus cards' CONFIG_NET_CBUS
+   if [ "$CONFIG_NET_CBUS" = "y" ]; then
+      tristate '    Most NE2000-based Ethernet support' CONFIG_NE2K_CBUS
+      if [ "$CONFIG_NE2K_CBUS" != "n" ]; then
+	 bool '      Melco EGY-98 support' CONFIG_NE2K_CBUS_EGY98
+	 bool '      Melco LGY-98 support' CONFIG_NE2K_CBUS_LGY98
+	 bool '      ICM IF-27xxET support' CONFIG_NE2K_CBUS_ICM
+	 bool '      I-O DATA LA-98 support (NOT TESTED!)' CONFIG_NE2K_CBUS_IOLA98
+	 bool '      Contec C-NET(98)E/L support (NOT TESTED!)' CONFIG_NE2K_CBUS_CNET98EL
+	 if [ "$CONFIG_NE2K_CBUS_CNET98EL" != "n" ]; then
+	    hex '        C-NET(98)E/L I/O base address (aaed or 55ed)' CONFIG_NE2K_CBUS_CNET98EL_IO_BASE aaed
+	 fi
+	 bool '      Allied Telesis LA-98 Support (NOT TESTED!)' CONFIG_NE2K_CBUS_ATLA98
+	 bool '      ELECOM Laneed LD-BDN[123]A Support (NOT TESTED!)' CONFIG_NE2K_CBUS_BDN
+	 bool '      NEC PC-9801-108 Support (NOT TESTED!)' CONFIG_NE2K_CBUS_NEC108
+      fi
+   fi
+  fi	# CONFIG_PC9800
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
      bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
    else
diff -Nru linux-2.5.42/drivers/net/Makefile linux98-2.5.42/drivers/net/Makefile
--- linux-2.5.42/drivers/net/Makefile	Sat Oct 12 13:21:36 2002
+++ linux98-2.5.42/drivers/net/Makefile	Tue Oct 15 23:03:22 2002
@@ -87,7 +87,11 @@
 obj-$(CONFIG_ARM_ETHERH) += 8390.o
 obj-$(CONFIG_WD80x3) += wd.o 8390.o
 obj-$(CONFIG_EL2) += 3c503.o 8390.o
+ifneq ($(CONFIG_PC9800),y)
 obj-$(CONFIG_NE2000) += ne.o 8390.o
+else
+obj-$(CONFIG_NE2K_CBUS) += ne.o 8390.o
+endif
 obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
 obj-$(CONFIG_HPLAN) += hp.o 8390.o
 obj-$(CONFIG_HPLAN_PLUS) += hp-plus.o 8390.o
diff -Nru linux-2.5.42/drivers/net/Makefile.lib linux98-2.5.42/drivers/net/Makefile.lib
--- linux-2.5.42/drivers/net/Makefile.lib	Sat Oct 12 13:22:18 2002
+++ linux98-2.5.42/drivers/net/Makefile.lib	Tue Oct 15 23:03:22 2002
@@ -19,6 +19,7 @@
 obj-$(CONFIG_MACMACE)		+= crc32.o
 obj-$(CONFIG_MIPS_AU1000_ENET)	+= crc32.o
 obj-$(CONFIG_NATSEMI)		+= crc32.o	
+obj-$(CONFIG_NE2K_CBUS)		+= crc32.o
 obj-$(CONFIG_PCMCIA_FMVJ18X)	+= crc32.o
 obj-$(CONFIG_PCMCIA_SMC91C92)	+= crc32.o
 obj-$(CONFIG_PCMCIA_XIRTULIP)	+= crc32.o
diff -Nru linux-2.5.42/drivers/net/Space.c linux98-2.5.42/drivers/net/Space.c
--- linux-2.5.42/drivers/net/Space.c	Sat Oct 12 13:21:32 2002
+++ linux98-2.5.42/drivers/net/Space.c	Tue Oct 15 23:03:22 2002
@@ -243,7 +243,7 @@
 #ifdef CONFIG_E2100		/* Cabletron E21xx series. */
 	{e2100_probe, 0},
 #endif
-#ifdef CONFIG_NE2000		/* ISA (use ne2k-pci for PCI cards) */
+#if defined(CONFIG_NE2000) || defined(CONFIG_NE2K_CBUS)	/* ISA & PC-9800 CBUS (use ne2k-pci for PCI cards) */
 	{ne_probe, 0},
 #endif
 #ifdef CONFIG_LANCE		/* ISA/VLB (use pcnet32 for PCI cards) */
diff -Nru linux-2.5.42/drivers/net/at1700.c linux98-2.5.42/drivers/net/at1700.c
--- linux-2.5.42/drivers/net/at1700.c	Sat Oct 12 13:21:41 2002
+++ linux98-2.5.42/drivers/net/at1700.c	Tue Oct 15 23:03:22 2002
@@ -34,6 +34,10 @@
 	only is it difficult to detect, it also moves around in I/O space in
 	response to inb()s from other device probes!
 */
+/*
+	99/03/03  Allied Telesis RE1000 Plus support by T.Hagawa
+	99/12/30	port to 2.3.35 by K.Takai
+*/
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -69,6 +73,8 @@
 /* When to switch from the 64-entry multicast filter to Rx-all-multicast. */
 #define MC_FILTERBREAK 64
 
+#ifndef CONFIG_PC9800
+
 /* These unusual address orders are used to verify the CONFIG register. */
 
 static int fmv18x_probe_list[] __initdata = {
@@ -101,6 +107,14 @@
 };
 #endif
 
+#else /* CONFIG_PC9800 */
+
+static int at1700_probe_list[] = {
+	0x1d6, 0x1d8, 0x1da, 0x1d4, 0xd4, 0xd2, 0xd8, 0xd0, 0
+};
+
+#endif /* CONFIG_PC9800 */
+
 /* use 0 for production, 1 for verification, >2 for debug */
 #ifndef NET_DEBUG
 #define NET_DEBUG 1
@@ -125,6 +139,7 @@
 
 
 /* Offsets from the base address. */
+#ifndef CONFIG_PC9800
 #define STATUS			0
 #define TX_STATUS		0
 #define RX_STATUS		1
@@ -139,6 +154,7 @@
 #define TX_START		10
 #define COL16CNTL		11		/* Controll Reg for 16 collisions */
 #define MODE13			13
+#define RX_CTRL			14
 /* Configuration registers only on the '865A/B chips. */
 #define EEPROM_Ctrl 	16
 #define EEPROM_Data 	17
@@ -147,8 +163,36 @@
 #define IOCONFIG		18		/* Either read the jumper, or move the I/O. */
 #define IOCONFIG1		19
 #define	SAPROM			20		/* The station address PROM, if no EEPROM. */
+#define MODE24			24
 #define RESET			31		/* Write to reset some parts of the chip. */
 #define AT1700_IO_EXTENT	32
+#else /* CONFIG_PC9800 */
+#define STATUS			(0x0000)
+#define TX_STATUS		(0x0000)
+#define RX_STATUS		(0x0001)
+#define TX_INTR			(0x0200)/* Bit-mapped interrupt enable registers. */
+#define RX_INTR			(0x0201)
+#define TX_MODE			(0x0400)
+#define RX_MODE			(0x0401)
+#define CONFIG_0		(0x0600)/* Misc. configuration settings. */
+#define CONFIG_1		(0x0601)
+/* Run-time register bank 2 definitions. */
+#define DATAPORT		(0x0800)/* Word-wide DMA or programmed-I/O dataport. */
+#define TX_START		(0x0a00)
+#define COL16CNTL		(0x0a01)/* Controll Reg for 16 collisions */
+#define MODE13			(0x0c01)
+#define RX_CTRL			(0x0e00)
+/* Configuration registers only on the '865A/B chips. */
+#define EEPROM_Ctrl 	(0x1000)
+#define EEPROM_Data 	(0x1200)
+#define IOCONFIG		(0x1400)/* Either read the jumper, or move the I/O. */
+#define IOCONFIG1		(0x1600)
+#define	MODE24			(0x1800)/* The station address PROM, if no EEPROM. */
+#define RESET			(0x1e01)/* Write to reset some parts of the chip. */
+#undef AT1700_IO_EXTENT
+#define RE1000P_OFFSET(o) ({ int _o_ = (o); (_o_ & ~1) * 0x100 + (_o_ & 1); })
+#endif /* CONFIG_PC9800 */
+
 
 #define TX_TIMEOUT		10
 
@@ -184,6 +228,7 @@
 };
 #endif
 
+
 /* Check for a network adaptor of this type, and return '0' iff one exists.
    If dev->base_addr == 0, probe all likely locations.
    If dev->base_addr == 1, always return failure.
@@ -198,13 +243,34 @@
 
 	SET_MODULE_OWNER(dev);
 
+	printk(KERN_DEBUG "at1700: probing...\n");
+#ifndef CONFIG_PC9800
 	if (base_addr > 0x1ff)		/* Check a single specified location. */
 		return at1700_probe1(dev, base_addr);
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
+#else
+	if (base_addr) {
+		for (i = 0; at1700_probe_list[i]; i++)
+			if (base_addr == at1700_probe_list[i])
+				return at1700_probe1(dev, base_addr);
+		return -ENXIO;
+	}
+#endif
 
 	for (i = 0; at1700_probe_list[i]; i++) {
 		int ioaddr = at1700_probe_list[i];
+#ifndef CONFIG_PC9800
+#else
+		int j;
+		for (j = 0; j < 0x2000 && !check_region (ioaddr + j, 2); j += 0x0200)
+			;
+		if (j < 0x2000) {
+			printk(KERN_DEBUG "re1000plus: check_region on %#x (base %#x)"
+					" failed\n", ioaddr + j, ioaddr);
+			continue;
+		}
+#endif
 		if (at1700_probe1(dev, ioaddr) == 0)
 			return 0;
 	}
@@ -221,9 +287,13 @@
 
 static int __init at1700_probe1(struct net_device *dev, int ioaddr)
 {
+#ifndef CONFIG_PC9800
 	char fmv_irqmap[4] = {3, 7, 10, 15};
 	char fmv_irqmap_pnp[8] = {3, 4, 5, 7, 9, 10, 11, 15};
 	char at1700_irqmap[8] = {3, 4, 5, 9, 10, 11, 14, 15};
+#else
+	static char re1000plus_irqmap[4] = {3, 5, 6, 12};
+#endif
 	unsigned int i, irq, is_fmv18x = 0, is_at1700 = 0;
 	int slot, ret = -ENODEV;
 	struct net_local *lp;
@@ -305,10 +375,12 @@
 		&& read_eeprom(ioaddr, 4) == 0x0000
 		&& (read_eeprom(ioaddr, 5) & 0xff00) == 0xF400)
 		is_at1700 = 1;
+#ifndef CONFIG_PC9800
 	else if (inb(ioaddr   + SAPROM    ) == 0x00
 		&& inb(ioaddr + SAPROM + 1) == 0x00
 		&& inb(ioaddr + SAPROM + 2) == 0x0e)
 		is_fmv18x = 1;
+#endif
 	else {
 		goto err_out;
 	}
@@ -320,6 +392,7 @@
 		/* Reset the internal state machines. */
 	outb(0, ioaddr + RESET);
 
+#ifndef CONFIG_PC9800
 	if (is_at1700)
 		irq = at1700_irqmap[(read_eeprom(ioaddr, 12)&0x04)
 						   | (read_eeprom(ioaddr, 0)>>14)];
@@ -341,9 +414,20 @@
 			irq = fmv_irqmap[(inb(ioaddr + IOCONFIG)>>6) & 0x03];
 		}
 	}
+#else
+# if 0
+	printk("%s: BMPR19 = %#x\n", dev->name, inb (ioaddr + IOCONFIG1));
+# endif
+	irq = re1000plus_irqmap[inb(ioaddr + IOCONFIG1) >> 6];
+#endif
 
+#ifndef CONFIG_PC9800
 	printk("%s: %s found at %#3x, IRQ %d, address ", dev->name,
 		   is_at1700 ? "AT1700" : "FMV-18X", ioaddr, irq);
+#else
+	printk("%s: RE1000plus found at %#3x, IRQ %d, address ", dev->name,
+			ioaddr, irq);
+#endif
 
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
@@ -354,12 +438,14 @@
 			printk("%04x", eeprom_val);
 			((unsigned short *)dev->dev_addr)[i] = ntohs(eeprom_val);
 		}
+#ifndef CONFIG_PC9800
 	} else {
 		for(i = 0; i < 6; i++) {
 			unsigned char val = inb(ioaddr + SAPROM + i);
 			printk("%02x", val);
 			dev->dev_addr[i] = val;
 		}
+#endif
 	}
 
 	/* The EEPROM word 12 bit 0x0400 means use regular 100 ohm 10baseT signals,
@@ -373,6 +459,7 @@
 		if (is_at1700) {
 			ushort setup_value = read_eeprom(ioaddr, 12);
 			dev->if_port = setup_value >> 8;
+#ifndef CONFIG_PC9800
 		} else {
 			ushort setup_value = inb(ioaddr + CARDSTATUS);
 			switch (setup_value & 0x07) {
@@ -384,6 +471,7 @@
 			default:   /* auto-sense */
 				dev->if_port = 0x00; break;
 			}
+#endif
 		}
 		printk(" %s interface.\n", porttype[(dev->if_port>>3) & 3]);
 	}
@@ -395,18 +483,30 @@
 	/* Set the station address in bank zero. */
 	outb(0x00, ioaddr + CONFIG_1);
 	for (i = 0; i < 6; i++)
+#ifndef CONFIG_PC9800
 		outb(dev->dev_addr[i], ioaddr + 8 + i);
+#else
+		outb(dev->dev_addr[i], ioaddr + RE1000P_OFFSET(8 + i));
+#endif
 
 	/* Switch to bank 1 and set the multicast table to accept none. */
 	outb(0x04, ioaddr + CONFIG_1);
 	for (i = 0; i < 8; i++)
+#ifndef CONFIG_PC9800
 		outb(0x00, ioaddr + 8 + i);
+#else
+		outb(0x00, ioaddr + RE1000P_OFFSET(8 + i));
+#endif
 
 
 	/* Switch to bank 2 */
 	/* Lock our I/O address, and set manual processing mode for 16 collisions. */
 	outb(0x08, ioaddr + CONFIG_1);
+#ifndef CONFIG_PC9800
 	outb(dev->if_port, ioaddr + MODE13);
+#else
+	outb(0, ioaddr + MODE13);
+#endif
 	outb(0x00, ioaddr + COL16CNTL);
 
 	if (net_debug)
@@ -450,7 +550,12 @@
 	kfree(dev->priv);
 	dev->priv = NULL;
 err_out:
+#ifndef CONFIG_PC9800
 	release_region(ioaddr, AT1700_IO_EXTENT);
+#else
+	for (i = 0; i < 0x2000; i += 0x0200)
+		release_region(ioaddr + i, 2);
+#endif
 	return ret;
 }
 
@@ -462,7 +567,11 @@
 #define EE_DATA_READ	0x80	/* EEPROM chip data out, in reg. 17. */
 
 /* Delay between EEPROM clock transitions. */
+#ifndef CONFIG_PC9800
 #define eeprom_delay()	do { } while (0)
+#else
+#define eeprom_delay()	__asm__ ("out%B0 %%al,%0" :: "N"(0x5f))
+#endif
 
 /* The EEPROM commands include the alway-set leading bit. */
 #define EE_WRITE_CMD	(5 << 6)
@@ -545,12 +654,12 @@
 		inw (ioaddr + STATUS), inb (ioaddr + TX_STATUS) & 0x80
 		? "IRQ conflict" : "network cable problem");
 	printk ("%s: timeout registers: %04x %04x %04x %04x %04x %04x %04x %04x.\n",
-	 dev->name, inw (ioaddr + 0), inw (ioaddr + 2), inw (ioaddr + 4),
-		inw (ioaddr + 6), inw (ioaddr + 8), inw (ioaddr + 10),
-		inw (ioaddr + 12), inw (ioaddr + 14));
+	 dev->name, inw(ioaddr + TX_STATUS), inw(ioaddr + TX_INTR), inw(ioaddr + TX_MODE),
+		inw(ioaddr + CONFIG_0), inw(ioaddr + DATAPORT), inw(ioaddr + TX_START),
+		inw(ioaddr + MODE13 - 1), inw(ioaddr + RX_CTRL));
 	lp->stats.tx_errors++;
 	/* ToDo: We should try to restart the adaptor... */
-	outw (0xffff, ioaddr + 24);
+	outw(0xffff, ioaddr + MODE24);
 	outw (0xffff, ioaddr + TX_STATUS);
 	outb (0x5a, ioaddr + CONFIG_0);
 	outb (0xe8, ioaddr + CONFIG_1);
@@ -696,7 +805,7 @@
 				   dev->name, inb(ioaddr + RX_MODE), status);
 #ifndef final_version
 		if (status == 0) {
-			outb(0x05, ioaddr + 14);
+			outb(0x05, ioaddr + RX_CTRL);
 			break;
 		}
 #endif
@@ -716,7 +825,7 @@
 					   dev->name, pkt_len);
 				/* Prime the FIFO and then flush the packet. */
 				inw(ioaddr + DATAPORT); inw(ioaddr + DATAPORT);
-				outb(0x05, ioaddr + 14);
+				outb(0x05, ioaddr + RX_CTRL);
 				lp->stats.rx_errors++;
 				break;
 			}
@@ -726,7 +835,7 @@
 					   dev->name, pkt_len);
 				/* Prime the FIFO and then flush the packet. */
 				inw(ioaddr + DATAPORT); inw(ioaddr + DATAPORT);
-				outb(0x05, ioaddr + 14);
+				outb(0x05, ioaddr + RX_CTRL);
 				lp->stats.rx_dropped++;
 				break;
 			}
@@ -753,7 +862,7 @@
 			if ((inb(ioaddr + RX_MODE) & 0x40) == 0x40)
 				break;
 			inw(ioaddr + DATAPORT);				/* dummy status read */
-			outb(0x05, ioaddr + 14);
+			outb(0x05, ioaddr + RX_CTRL);
 		}
 
 		if (net_debug > 5)
@@ -843,7 +952,11 @@
 		/* Switch to bank 1 and set the multicast table. */
 		outw((saved_bank & ~0x0C00) | 0x0480, ioaddr + CONFIG_0);
 		for (i = 0; i < 8; i++)
+#ifndef CONFIG_PC9800
 			outb(mc_filter[i], ioaddr + 8 + i);
+#else
+			outb(mc_filter[i], ioaddr + RE1000P_OFFSET (8 + i));
+#endif
 		memcpy(lp->mc_filter, mc_filter, sizeof(mc_filter));
 		outw(saved_bank, ioaddr + CONFIG_0);
 	}
@@ -853,7 +966,12 @@
 
 #ifdef MODULE
 static struct net_device dev_at1700;
+#ifndef CONFIG_PC9800
 static int io = 0x260;
+#else
+static int io = 0xd0;
+#endif
+
 static int irq;
 
 MODULE_PARM(io, "i");
@@ -893,7 +1011,15 @@
 
 	/* If we don't do this, we can't re-insmod it later. */
 	free_irq(dev_at1700.irq, NULL);
+#ifndef CONFIG_PC9800
 	release_region(dev_at1700.base_addr, AT1700_IO_EXTENT);
+#else
+	{
+		int i;
+		for (i = 0; i < 0x2000; i += 0x200)
+			release_region(dev_at1700.base_addr + i, 2);
+	}
+#endif
 }
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
diff -Nru linux-2.5.42/drivers/net/ne.c linux98-2.5.42/drivers/net/ne.c
--- linux-2.5.42/drivers/net/ne.c	Sat Oct 12 13:22:07 2002
+++ linux98-2.5.42/drivers/net/ne.c	Tue Oct 15 23:03:22 2002
@@ -54,6 +54,26 @@
 #include <linux/etherdevice.h>
 #include "8390.h"
 
+/* backword compatibility for kernel version 2.1.57 */
+#include <linux/version.h>
+#ifndef LINUX_VERSION_CODE
+#warning LINUX_VERSION_CODE is no defined!
+#endif
+#if LINUX_VERSION_CODE < 0x20200
+#ifdef CONFIG_PCI
+#undef CONFIG_PCI
+#endif
+#ifdef CONFIG_PC98
+#define CONFIG_PC9800
+#endif
+#define mdelay(n) ({unsigned long msec=(n); while (msec--) udelay(1000);})
+#endif
+
+#ifdef CONFIG_NET_CBUS
+#undef ei_debug
+#define ei_debug 9
+#endif /* CONFIG_NET_CBUS */
+
 /* Some defines that people can play with if so inclined. */
 
 /* Do we support clones that don't adhere to 14,15 of the SAprom ? */
@@ -69,11 +89,13 @@
 /* #define PACKETBUF_MEMSIZE	0x40 */
 
 /* A zero-terminated list of I/O addresses to be probed at boot. */
+#ifndef CONFIG_NET_CBUS
 #ifndef MODULE
 static unsigned int netcard_portlist[] __initdata = {
 	0x300, 0x280, 0x320, 0x340, 0x360, 0x380, 0
 };
 #endif
+#endif
 
 static struct isapnp_device_id isapnp_clone_list[] __initdata = {
 	{	ISAPNP_CARD_ID('A','X','E',0x2011),
@@ -94,6 +116,7 @@
 /* A list of bad clones that we none-the-less recognize. */
 static struct { const char *name8, *name16; unsigned char SAprefix[4];}
 bad_clone_list[] __initdata = {
+#ifndef CONFIG_NET_CBUS
     {"DE100", "DE200", {0x00, 0xDE, 0x01,}},
     {"DE120", "DE220", {0x00, 0x80, 0xc8,}},
     {"DFI1000", "DFI2000", {'D', 'F', 'I',}}, /* Original, eh?  */
@@ -108,26 +131,54 @@
     {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */
     {"REALTEK", "RTL8019", {0x00, 0x00, 0xe8}}, /* no-name with Realtek chip */
     {"LCS-8834", "LCS-8836", {0x04, 0x04, 0x37}}, /* ShinyNet (SET) */
+#else /* CONFIG_NET_CBUS */
+    {"LA/T-98?", "LA/T-98", {0x00,0xa0,0xb0}},		/* I/O Data */
+    {"EGY-98?", "EGY-98", {0x00,0x40,0x26}},		/* Melco EGY98 */
+    {"ICM?", "ICM-27xx-ET", {0x00,0x80,0xc8}},		/* ICM IF-27xx-ET */
+    {"CNET-98/EL?", "CNET(98)E/L", {0x00,0x80,0x4C}},	/* Contec CNET-98/EL */
+#endif
     {0,}
 };
 #endif
 
 /* ---- No user-serviceable parts below ---- */
 
+#define NE_SHIFT(x) EI_SHIFT(x)
 #define NE_BASE	 (dev->base_addr)
-#define NE_CMD	 	0x00
-#define NE_DATAPORT	0x10	/* NatSemi-defined port window offset. */
-#define NE_RESET	0x1f	/* Issue a read to reset, a write to clear. */
+#define NE_CMD	 	NE_SHIFT(0x00)
+#define NE_DATAPORT	NE_SHIFT(0x10)	/* NatSemi-defined port window offset. */
+#ifndef CONFIG_NET_CBUS
+#define NE_RESET	NE_SHIFT(0x1f) /* Issue a read to reset, a write to clear. */
+#else
+#define NE_RESET	NE_SHIFT(0x11) /* Issue a read to reset, a write to clear. */
+#endif
+
 #define NE_IO_EXTENT	0x20
 
 #define NE1SM_START_PG	0x20	/* First page of TX buffer */
 #define NE1SM_STOP_PG 	0x40	/* Last page +1 of RX ring */
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+#ifndef CONFIG_NE2K_CBUS_CNET98EL_IO_BASE
+#warning CONFIG_NE2K_CBUS_CNET98EL_IO_BASE is not defined(config error?)
+#warning use 0xaaed as default
+#define CONFIG_NE2K_CBUS_CNET98EL_IO_BASE 0xaaed /* or 0x55ed */
+#endif
+#define CNET98EL_START_PG 0x00
+#define CNET98EL_STOP_PG 0x40
+#endif
+
+#ifdef CONFIG_NET_CBUS
+#include "ne2k_cbus.h"
+#endif
 
 int ne_probe(struct net_device *dev);
 static int ne_probe1(struct net_device *dev, int ioaddr);
 static int ne_probe_isapnp(struct net_device *dev);
+#ifdef CONFIG_NET_CBUS
+static int ne_probe_cbus(struct net_device *dev, const struct ne2k_cbus_hwinfo *hw, int ioaddr);
+#endif
 
 static int ne_open(struct net_device *dev);
 static int ne_close(struct net_device *dev);
@@ -162,6 +213,8 @@
 	E2010	 starts at 0x100 and ends at 0x4000.
 	E2010-x starts at 0x100 and ends at 0xffff.  */
 
+#ifndef CONFIG_NET_CBUS
+
 int __init ne_probe(struct net_device *dev)
 {
 	unsigned int base_addr = dev->base_addr;
@@ -190,6 +243,95 @@
 	return -ENODEV;
 }
 
+#else /* CONFIG_NET_CBUS */
+
+int __init ne_probe(struct net_device *dev)
+{
+	unsigned int base_addr = dev->base_addr;
+
+	SET_MODULE_OWNER(dev);
+
+	if (ei_debug > 2)
+		printk(KERN_DEBUG "ne_probe(): entered.\n");
+
+	/* If CONFIG_NET_CBUS,
+	   we need dev->priv->reg_offset BEFORE to probe */
+	if (ne2k_cbus_init(dev) != 0) {
+		return -ENOMEM;
+	}
+
+	/* First check any supplied i/o locations. User knows best. <cough> */
+	if (base_addr > 0) {
+		int result;
+		const struct ne2k_cbus_hwinfo *hw = ne2k_cbus_get_hwinfo((int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+
+		if (ei_debug > 2)
+			printk(KERN_DEBUG "ne_probe(): call ne_probe_cbus(base_addr=0x%x)\n", base_addr);
+
+		result = ne_probe_cbus(dev, hw, base_addr);
+		if (result != 0)
+			ne2k_cbus_destroy(dev);
+
+		return result;
+	}
+
+	if (ei_debug > 2)
+		printk(KERN_DEBUG "ne_probe(): base_addr is not specified.\n");
+
+#ifndef MODULE
+	/* Last resort. The semi-risky C-Bus auto-probe. */
+	if (ei_debug > 2)
+		printk(KERN_DEBUG "ne_probe(): auto-probe start.\n");
+
+	{
+		const struct ne2k_cbus_hwinfo *hw = ne2k_cbus_get_hwinfo((int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+
+		if (hw && hw->hwtype) {
+			const unsigned short *plist;
+			for (plist = hw->portlist; *plist; plist++) {
+				const struct ne2k_cbus_region *rlist;
+				for (rlist = hw->regionlist; rlist->range; rlist++) {
+					if (check_region(*plist+rlist->start, rlist->range))
+						break;
+				}
+				if (rlist->range) {
+					/* check_region() failed */ 
+					continue; /* try next base port */
+				}
+				/* check_region() succeeded */
+				if (ne_probe_cbus(dev,hw,*plist) == 0)
+					return 0;
+			}
+		}else{
+			for (hw = &ne2k_cbus_hwinfo_list[0]; hw->hwtype; hw++) {
+				const unsigned short *plist;
+				for(plist=hw->portlist; *plist; plist++){
+					const struct ne2k_cbus_region *rlist;
+
+					for (rlist = hw->regionlist; rlist->range; rlist++) {
+						if (check_region(*plist+rlist->start, rlist->range))
+							break;
+					}
+					if (rlist->range) {
+						/* check_region() failed */ 
+						continue; /* try next base port */
+					}
+					/* check_region() succeeded */
+					if (ne_probe_cbus(dev,hw,*plist) == 0)
+						return 0;
+				}
+			}
+		}
+	}
+#endif
+
+	ne2k_cbus_destroy(dev);
+
+	return -ENODEV;
+}
+
+#endif /* CONFIG_NET_CBUS */
+
 static int __init ne_probe_isapnp(struct net_device *dev)
 {
 	int i;
@@ -231,42 +373,127 @@
 	return -ENODEV;
 }
 
+#ifdef CONFIG_NET_CBUS
+static int __init ne_probe_cbus(struct net_device *dev, const struct ne2k_cbus_hwinfo *hw, int ioaddr)
+{
+	if (ei_debug > 2)
+		printk(KERN_DEBUG "ne_probe_cbus(): entered. (called from %p)\n",
+		       __builtin_return_address(0));
+
+	if (hw && hw->hwtype) {
+		ne2k_cbus_set_hwtype(dev, hw, ioaddr);
+		return ne_probe1(dev, ioaddr);
+	} else {
+		/* auto detect */
+
+		printk(KERN_DEBUG "ne_probe_cbus(): try to determine hardware types.\n");
+		for (hw = &ne2k_cbus_hwinfo_list[0]; hw->hwtype; hw++) {
+			ne2k_cbus_set_hwtype(dev, hw, ioaddr);
+			if (ne_probe1(dev, ioaddr)==0)
+				return 0;
+		}
+	}
+	return ENODEV;
+}
+#endif /* CONFIG_NET_CBUS */
+
 static int __init ne_probe1(struct net_device *dev, int ioaddr)
 {
 	int i;
 	unsigned char SA_prom[32];
+#ifndef CONFIG_NET_CBUS /* if CONFIG_NET_CBUS, wordlength is always 2! */
 	int wordlength = 2;
+#endif
 	const char *name = NULL;
 	int start_page, stop_page;
+#ifndef CONFIG_NET_CBUS
 	int neX000, ctron, copam, bad_card;
+#else
+	int neX000, bad_card;
+#endif
 	int reg0, ret;
 	static unsigned version_printed;
+#ifdef CONFIG_NET_CBUS
+	const struct ne2k_cbus_hwinfo *hw = ne2k_cbus_get_hwinfo((int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+#endif
 
+#ifdef CONFIG_NET_CBUS
+	if (ei_debug > 2) {
+		printk(KERN_DEBUG "ne_probe1(): entered\n"
+			   "ioaddr=0x%x, hardware_type = %d(%s)\n"
+			   "ei_local->reg_offset = \n"
+			   "{ 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, \n"
+			   "  0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, 0x%04x, \n"
+			   "  0x%04x, 0x%04x }\n",
+			   ioaddr, hw->hwtype, hw->hwident,
+			   ei_local->reg_offset[0],  ei_local->reg_offset[1],
+			   ei_local->reg_offset[2],  ei_local->reg_offset[3],
+			   ei_local->reg_offset[4],  ei_local->reg_offset[5],
+			   ei_local->reg_offset[6],  ei_local->reg_offset[7],
+			   ei_local->reg_offset[8],  ei_local->reg_offset[9],
+			   ei_local->reg_offset[10], ei_local->reg_offset[11],
+			   ei_local->reg_offset[12], ei_local->reg_offset[13],
+			   ei_local->reg_offset[14], ei_local->reg_offset[15],
+			   ei_local->reg_offset[16], ei_local->reg_offset[17]);
+	}
+#endif
+
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_CNET98EL) {
+		outb_p(0, CONFIG_NE2K_CBUS_CNET98EL_IO_BASE);
+		/* udelay(5000);	*/
+		outb_p(1, CONFIG_NE2K_CBUS_CNET98EL_IO_BASE);
+		/* udelay(5000);	*/
+		outb_p((ioaddr & 0xf000) >> 8 | 0x08 | 0x01, CONFIG_NE2K_CBUS_CNET98EL_IO_BASE + 2);
+		/* udelay(5000); */
+	}
+#endif
+
+#ifndef CONFIG_NET_CBUS
 	if (!request_region(ioaddr, NE_IO_EXTENT, dev->name))
 		return -EBUSY;
+#else /* CONFIG_NET_CBUS */
+	{
+		const struct ne2k_cbus_region *rlist;
+		for (rlist = hw->regionlist; rlist->range; rlist++) {
+			if (!request_region(ioaddr + rlist->start,
+						rlist->range, dev->name))
+				return -EBUSY;
+		}
+	}
+#endif /* !CONFIG_NET_CBUS */
 
-	reg0 = inb_p(ioaddr);
+	reg0 = inb_p(ioaddr + NE_SHIFT(0));
 	if (reg0 == 0xFF) {
 		ret = -ENODEV;
 		goto err_out;
 	}
 
 	/* Do a preliminary verification that we have a 8390. */
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	if (hw->hwtype != NE2K_CBUS_HARDWARE_TYPE_CNET98EL)
+#endif
 	{
 		int regd;
 		outb_p(E8390_NODMA+E8390_PAGE1+E8390_STOP, ioaddr + E8390_CMD);
-		regd = inb_p(ioaddr + 0x0d);
-		outb_p(0xff, ioaddr + 0x0d);
+		regd = inb_p(ioaddr + NE_SHIFT(0x0d));
+		outb_p(0xff, ioaddr + NE_SHIFT(0x0d));
 		outb_p(E8390_NODMA+E8390_PAGE0, ioaddr + E8390_CMD);
 		inb_p(ioaddr + EN0_COUNTER0); /* Clear the counter by reading. */
 		if (inb_p(ioaddr + EN0_COUNTER0) != 0) {
 			outb_p(reg0, ioaddr);
-			outb_p(regd, ioaddr + 0x0d);	/* Restore the old values. */
+			outb_p(regd, ioaddr + NE_SHIFT(0x0d));	/* Restore the old values. */
 			ret = -ENODEV;
 			goto err_out;
 		}
 	}
 
+#ifdef CONFIG_NET_CBUS
+	if (ei_debug > 2)
+		printk(KERN_DEBUG "ne_probe1(): 8390 verification passed.\n");
+#endif
+
 	if (ei_debug  &&  version_printed++ == 0)
 		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 
@@ -285,6 +512,11 @@
 	{
 		unsigned long reset_start_time = jiffies;
 
+#ifdef CONFIG_NET_CBUS
+		/* derived from CNET98EL-patch for bad clones */
+		outb_p(E8390_NODMA | E8390_STOP, ioaddr+E8390_CMD);
+#endif
+
 		/* DON'T change these to inb_p/outb_p or reset will fail on clones. */
 		outb(inb(ioaddr + NE_RESET), ioaddr + NE_RESET);
 
@@ -303,15 +535,130 @@
 		outb_p(0xff, ioaddr + EN0_ISR);		/* Ack all intr. */
 	}
 
+#ifdef CONFIG_NE2K_CBUS_ICM
+#if 0 /* obsoleted */
+	if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_ICM) {
+		static const char pat[32] ="AbcdeFghijKlmnoPqrstUvwxyZ789012";
+		char buf[sizeof(pat)];
+		int maxwait = 200;
+
+		if (ei_debug > 2) {
+			printk(" [ICM-specific initialize...");
+		}
+
+		inb(ioaddr + EN0_ISR);
+		outb_p(E8390_RXOFF, ioaddr+EN0_RXCR);
+		outb_p(0x1| 0x40 | 0x8, ioaddr+EN0_DCFG); /* ENDCFG_WTS|ENDCFG_FT1|ENDCFG_LS */
+		outb_p(16384 / 256, ioaddr + EN0_STARTPG);
+		outb_p(32768 / 256, ioaddr + EN0_STOPPG);
+		ne2k_cbus_writemem(dev, ioaddr, 16384, pat, sizeof(pat));
+		while ((inb(ioaddr+EN0_ISR) & ENISR_RDC) != ENISR_RDC
+			  && --maxwait)
+			;
+		if (ei_debug > 2) {
+			printk("write pat...");
+		}
+		ne2k_cbus_readmem(dev, ioaddr, 16384, buf, sizeof(pat));
+		if (ei_debug>2) {
+			printk("read pat...");
+		}
+		if (memcmp(pat, buf, sizeof(pat))) {
+			if (ei_debug > 2) {
+				printk("compare failed.)");
+			}
+			printk(" memory failure\n");
+			return ENODEV;
+		}
+		if (ei_debug > 2) {
+			printk("compare ok...");
+		}
+		ne2k_cbus_readmem(dev, ioaddr, 0, SA_prom, 32);
+		outb(0xff, ioaddr+EN0_ISR);
+		printk("done)");
+	}
+	else
+#endif
+#endif /* CONFIG_NE2K_CBUS_ICM */
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_CNET98EL) {
+		static const char pat[32] ="AbcdeFghijKlmnoPqrstUvwxyZ789012";
+		char buf[32];
+		int maxwait = 200;
+
+		if (ei_debug > 2) {
+			printk(" [CNET98EL-specific initialize...");
+		}
+		outb_p(E8390_NODMA | E8390_STOP, ioaddr+E8390_CMD); /* 0x20|0x1 */
+		i=inb(ioaddr);
+		if ((i & ~0x2) != (0x20 | 0x01))
+			return ENODEV;
+		if ((inb(ioaddr + 0x7) & 0x80) != 0x80)
+			return ENODEV;
+		outb_p(E8390_RXOFF, ioaddr+EN0_RXCR); /* out(ioaddr+0xc, 0x20) */
+		/* outb_p(ENDCFG_WTS|ENDCFG_FT1|ENDCFG_LS, ioaddr+EN0_DCFG); */
+		outb_p(ENDCFG_WTS|0x48, ioaddr+EN0_DCFG); /* 0x49 */
+		outb_p(CNET98EL_START_PG, ioaddr+EN0_STARTPG);
+		outb_p(CNET98EL_STOP_PG, ioaddr+EN0_STOPPG);
+		if (ei_debug > 2) {
+			printk("memory check");
+		}
+		for (i = 0; i < 65536; i += 1024) {
+			if (ei_debug > 2) {
+				printk(" %04x",i);
+			}
+			ne2k_cbus_writemem(dev,ioaddr, i, pat, 32);
+			while (((inb(ioaddr + EN0_ISR) & ENISR_RDC) != ENISR_RDC) && --maxwait)
+				;
+			ne2k_cbus_readmem(dev, ioaddr, i, buf, 32);
+			if (memcmp(pat, buf, 32)) {
+				if (ei_debug > 2) {
+					printk(" failed.");
+				}
+				break;
+			}
+		}
+		if (i != 16384) {
+			if (ei_debug > 2) {
+				printk("] ");
+			}
+			printk("memory failure at %x\n", i);
+			return ENODEV;
+		}
+		if (ei_debug > 2) {
+			printk(" good...");
+		}
+		if (!dev->irq) {
+			if (ei_debug > 2) {
+				printk("] ");
+			}
+			printk("IRQ must be specified for C-NET(98)E/L. probe failed.\n");
+			return ENODEV;
+		}
+		outb((dev->irq>5) ? (dev->irq&4):(dev->irq>>1), ioaddr + (0x2 | 0x400));
+		outb(0x7e, ioaddr + (0x4 | 0x400));
+		ne2k_cbus_readmem(dev, ioaddr, 16384, SA_prom, 32);
+		outb(0xff, ioaddr + EN0_ISR);
+		if (ei_debug > 2) {
+			printk("done]");
+		}
+	} else
+#endif /* CONFIG_NE2K_CBUS_CNET98EL */
 	/* Read the 16 bytes of station address PROM.
 	   We must first initialize registers, similar to NS8390_init(eifdev, 0).
 	   We can't reliably read the SAPROM address without this.
 	   (I learned the hard way!). */
 	{
-		struct {unsigned char value, offset; } program_seq[] =
+		struct {unsigned char value; unsigned short offset;} program_seq[] = 
 		{
 			{E8390_NODMA+E8390_PAGE0+E8390_STOP, E8390_CMD}, /* Select page 0*/
+#ifndef CONFIG_NET_CBUS
 			{0x48,	EN0_DCFG},	/* Set byte-wide (0x48) access. */
+#else
+			/* NEC PC-9800: some board can only handle word-wide access? */
+			{0x48 | ENDCFG_WTS,	EN0_DCFG},	/* Set word-wide (0x48) access. */
+			{16384 / 256, EN0_STARTPG},
+			{32768 / 256, EN0_STOPPG},
+#endif
 			{0x00,	EN0_RCNTLO},	/* Clear the count regs. */
 			{0x00,	EN0_RCNTHI},
 			{0x00,	EN0_IMR},	/* Mask completion irq. */
@@ -325,17 +672,44 @@
 			{E8390_RREAD+E8390_START, E8390_CMD},
 		};
 
+#ifdef CONFIG_NET_CBUS
+		if (ei_debug > 2) {
+			printk(" [outb_p");
+		}
+#endif
+
 		for (i = 0; i < sizeof(program_seq)/sizeof(program_seq[0]); i++)
+#ifdef CONFIG_NET_CBUS
+		{
+			if (ei_debug > 2)
+				printk("(0x%x,0x%x)",program_seq[i].value, ioaddr + program_seq[i].offset);
+#endif
 			outb_p(program_seq[i].value, ioaddr + program_seq[i].offset);
-
-	}
+#ifdef CONFIG_NET_CBUS
+		}
+		if (ei_debug > 2)
+			printk("]");
+#endif
+#ifndef CONFIG_NET_CBUS
 	for(i = 0; i < 32 /*sizeof(SA_prom)*/; i+=2) {
 		SA_prom[i] = inb(ioaddr + NE_DATAPORT);
 		SA_prom[i+1] = inb(ioaddr + NE_DATAPORT);
 		if (SA_prom[i] != SA_prom[i+1])
 			wordlength = 1;
 	}
+#else
+	insw(ioaddr + NE_DATAPORT, SA_prom, 32 >> 1);
+#endif
 
+	}
+
+	if (ei_debug > 2) {
+		printk("[SA_prom[]={ ");
+		for (i = 0; i < 32; i++) printk("%02x ", SA_prom[i]);
+		printk("}]");
+	}
+
+#ifndef CONFIG_NET_CBUS
 	if (wordlength == 2)
 	{
 		for (i = 0; i < 16; i++)
@@ -348,8 +722,24 @@
 		start_page = NE1SM_START_PG;
 		stop_page = NE1SM_STOP_PG;
 	}
+#else
+	for (i = 0; i < 16; i++)
+		SA_prom[i] = SA_prom[i + i];
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_CNET98EL) {
+		start_page = CNET98EL_START_PG;
+		stop_page = CNET98EL_STOP_PG;
+	} else {
+#endif
+		start_page = NESM_START_PG;
+		stop_page = NESM_STOP_PG;
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	}
+#endif
+#endif
 
 	neX000 = (SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57);
+#ifndef CONFIG_NET_CBUS
 	ctron =  (SA_prom[0] == 0x00 && SA_prom[1] == 0x00 && SA_prom[2] == 0x1d);
 	copam =  (SA_prom[14] == 0x49 && SA_prom[15] == 0x00);
 
@@ -363,6 +753,11 @@
 		start_page = 0x01;
 		stop_page = (wordlength == 2) ? 0x40 : 0x20;
 	}
+#else
+	if (neX000){
+		name = "NE2000-compat";
+	}
+#endif
 	else
 	{
 #ifdef SUPPORT_NE_BAD_CLONES
@@ -374,12 +769,16 @@
 				SA_prom[1] == bad_clone_list[i].SAprefix[1] &&
 				SA_prom[2] == bad_clone_list[i].SAprefix[2])
 			{
+#ifndef CONFIG_NET_CBUS
 				if (wordlength == 2)
 				{
 					name = bad_clone_list[i].name16;
 				} else {
 					name = bad_clone_list[i].name8;
 				}
+#else
+				name = bad_clone_list[i].name16;
+#endif
 				break;
 			}
 		}
@@ -387,6 +786,12 @@
 		{
 			printk(" not found (invalid signature %2.2x %2.2x).\n",
 				SA_prom[14], SA_prom[15]);
+#ifdef CONFIG_NET_CBUS
+			if (ei_debug > 2) {
+				printk(KERN_DEBUG "PROM prefix is: %2.2x %2.2x %2.2x\n",
+					   SA_prom[0], SA_prom[1], SA_prom[2]);
+			}
+#endif
 			ret = -ENXIO;
 			goto err_out;
 		}
@@ -409,10 +814,18 @@
 		dev->irq = probe_irq_off(cookie);
 		if (ei_debug > 2)
 			printk(" autoirq is %d\n", dev->irq);
-	} else if (dev->irq == 2)
+	} else
+#ifndef CONFIG_PC9800
+	if (dev->irq == 2)
 		/* Fixup for users that don't know that IRQ 2 is really IRQ 9,
 		   or don't know which one to set. */
 		dev->irq = 9;
+#else
+	if (dev->irq == 7)
+		/* Fixup for users that don't know that IRQ 7 is really IRQ 11,
+		   or don't know which one to set. */
+		dev->irq = 11;
+#endif
 
 	if (! dev->irq) {
 		printk(" failed to detect IRQ line.\n");
@@ -443,13 +856,22 @@
 		dev->dev_addr[i] = SA_prom[i];
 	}
 
+#ifndef CONFIG_NET_CBUS
 	printk("\n%s: %s found at %#x, using IRQ %d.\n",
 		dev->name, name, ioaddr, dev->irq);
+#else
+	printk("\n%s: %s found at %#x, hardware type %d(%s), using IRQ %d.\n",
+		   dev->name, name, ioaddr, hw->hwtype, hw->hwident, dev->irq);
+#endif
 
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
+#ifndef CONFIG_NET_CBUS
 	ei_status.word16 = (wordlength == 2);
+#else
+	ei_status.word16 = (2 == 2); /* wordlength is always 2 */
+#endif
 
 	ei_status.rx_start_page = start_page + TX_PAGES;
 #ifdef PACKETBUF_MEMSIZE
@@ -468,10 +890,23 @@
 	return 0;
 
 err_out_kfree:
+#ifndef CONFIG_NET_CBUS
 	kfree(dev->priv);
 	dev->priv = NULL;
+#else
+	ne2k_cbus_destroy(dev);
+#endif
 err_out:
+#ifndef CONFIG_NET_CBUS
 	release_region(ioaddr, NE_IO_EXTENT);
+#else
+	{
+		const struct ne2k_cbus_region *rlist;
+		for (rlist = hw->regionlist; rlist->range; rlist++) {
+			release_region(ioaddr + rlist->start, rlist->range);
+		}
+	}
+#endif
 	return ret;
 }
 
@@ -495,10 +930,18 @@
 static void ne_reset_8390(struct net_device *dev)
 {
 	unsigned long reset_start_time = jiffies;
+#ifdef CONFIG_NET_CBUS
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+#endif
 
 	if (ei_debug > 1)
 		printk(KERN_DEBUG "resetting the 8390 t=%ld...", jiffies);
 
+#ifdef CONFIG_NET_CBUS
+	/* derived from CNET98EL-patch for bad clones... */
+	outb_p(E8390_NODMA | E8390_STOP, NE_BASE + E8390_CMD);  /* 0x20 | 0x1 */
+#endif
+
 	/* DON'T change these to inb_p/outb_p or reset will fail on clones. */
 	outb(inb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);
 
@@ -521,6 +964,9 @@
 static void ne_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr, int ring_page)
 {
 	int nic_base = dev->base_addr;
+#ifdef CONFIG_NET_CBUS
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+#endif
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
 
@@ -563,6 +1009,9 @@
 #endif
 	int nic_base = dev->base_addr;
 	char *buf = skb->data;
+#ifdef CONFIG_NET_CBUS
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+#endif
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
 	if (ei_status.dmaing)
@@ -573,6 +1022,15 @@
 		return;
 	}
 	ei_status.dmaing |= 0x01;
+
+#ifdef CONFIG_NET_CBUS
+	/* derived from ICM-patch */
+	/* round up count to a word */
+	if (count & 1) {
+	    count++;
+	}
+#endif
+
 	outb_p(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
 	outb_p(count & 0xff, nic_base + EN0_RCNTLO);
 	outb_p(count >> 8, nic_base + EN0_RCNTHI);
@@ -630,6 +1088,9 @@
 #ifdef NE_SANITY_CHECK
 	int retries = 0;
 #endif
+#ifdef CONFIG_NET_CBUS
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+#endif
 
 	/* Round the count up for word writes.  Do we need to do this?
 	   What effect will an odd byte count have on the 8390?
@@ -730,16 +1191,25 @@
 #ifdef MODULE
 #define MAX_NE_CARDS	4	/* Max number of NE cards per module */
 static struct net_device dev_ne[MAX_NE_CARDS];
-static int io[MAX_NE_CARDS];
-static int irq[MAX_NE_CARDS];
-static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
+static int __initdata io[MAX_NE_CARDS];
+static int __initdata irq[MAX_NE_CARDS];
+static int __initdata bad[MAX_NE_CARDS];  /* 0xbad = bad sig or no reset ack */
+#ifdef CONFIG_PC9800
+static int __initdata hwtype[MAX_NE_CARDS] = { 0, }; /* board type */
+#endif
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+#ifdef CONFIG_PC9800
+MODULE_PARM(hwtype, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+#endif
 MODULE_PARM_DESC(io, "I/O base address(es),required");
 MODULE_PARM_DESC(irq, "IRQ number(s)");
 MODULE_PARM_DESC(bad, "Accept card(s) with bad signatures");
+#ifdef CONFIG_PC9800
+MODULE_PARM_DESC(hwtype, "Board type of PC-9800 C-Bus NIC");
+#endif
 MODULE_DESCRIPTION("NE1000/NE2000 ISA/PnP Ethernet driver");
 MODULE_LICENSE("GPL");
 
@@ -757,6 +1227,9 @@
 		dev->irq = irq[this_dev];
 		dev->mem_end = bad[this_dev];
 		dev->base_addr = io[this_dev];
+#ifdef CONFIG_PC9800
+		dev->mem_start = hwtype[this_dev];
+#endif
 		dev->init = ne_probe;
 		if (register_netdev(dev) == 0) {
 			found++;
@@ -781,14 +1254,30 @@
 	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
 		struct net_device *dev = &dev_ne[this_dev];
 		if (dev->priv != NULL) {
+#ifndef CONFIG_NET_CBUS
 			void *priv = dev->priv;
+#endif
 			struct pci_dev *idev = (struct pci_dev *)ei_status.priv;
 			if (idev)
 				idev->deactivate(idev);
 			free_irq(dev->irq, dev);
+#ifndef CONFIG_NET_CBUS
 			release_region(dev->base_addr, NE_IO_EXTENT);
+#else /* CONFIG_NET_CBUS */
+			{
+				const struct ne2k_cbus_hwinfo *hw = ne2k_cbus_get_hwinfo((int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+				const struct ne2k_cbus_region *rlist;
+				for (rlist = hw->regionlist; rlist->range; rlist++) {
+					release_region(dev->base_addr + rlist->start, rlist->range);
+				}
+			}
+#endif /* !CONFIG_NET_CBUS */
 			unregister_netdev(dev);
+#ifndef CONFIG_NET_CBUS
 			kfree(priv);
+#else
+			ne2k_cbus_destroy(dev);
+#endif
 		}
 	}
 }
diff -Nru linux-2.5.42/drivers/net/ne2k_cbus.h linux98-2.5.42/drivers/net/ne2k_cbus.h
--- linux-2.5.42/drivers/net/ne2k_cbus.h	Thu Jan  1 09:00:00 1970
+++ linux98-2.5.42/drivers/net/ne2k_cbus.h	Tue Oct 15 23:03:22 2002
@@ -0,0 +1,473 @@
+/* ne2k_cbus.h: 
+   vender-specific information definition for NEC PC-9800
+   C-bus Ethernet Cards
+   Used in ne.c 
+
+   (C)1998,1999 KITAGWA Takurou & Linux/98 project
+*/
+
+#include <linux/config.h>
+
+#if LINUX_VERSION_CODE >= 0x2030b /* KERNEL_VERSION(2,3,11) */
+#define CONFIG_RESOURCE98
+#endif
+
+#ifdef CONFIG_RESOURCE98
+#define SPARSE_REGION(n) (-n)
+#else
+#define SPARSE_REGION(n) (n)
+#endif
+
+/* Hardware type definition (derived from *BSD) */
+#define NE2K_CBUS_HARDWARE_TYPE_MASK 0xff
+
+/* 0: reserved for auto-detect */
+/* 1: (not tested)
+   Allied Telesis CentreCom LA-98-T */
+#define NE2K_CBUS_HARDWARE_TYPE_ATLA98 1
+/* 2: (not tested)
+   ELECOM Laneed
+   LD-BDN[123]A
+   PLANET SMART COM 98 EN-2298-C
+   MACNICA ME98 */
+#define NE2K_CBUS_HARDWARE_TYPE_BDN 2
+/* 3:
+   Melco EGY-98
+   Contec C-NET(98)E*A/L*A,C-NET(98)P */
+#define NE2K_CBUS_HARDWARE_TYPE_EGY98 3
+/* 4:
+   Melco LGY-98,IND-SP,IND-SS
+   MACNICA NE2098 */
+#define NE2K_CBUS_HARDWARE_TYPE_LGY98 4
+/* 5:
+   ICM DT-ET-25,DT-ET-T5,IF-2766ET,IF-2771ET
+   PLANET SMART COM 98 EN-2298-T,EN-2298P-T
+   D-Link DE-298PT,DE-298PCAT
+   ELECOM Laneed LD-98P */
+#define NE2K_CBUS_HARDWARE_TYPE_ICM 5
+/* 6: (reserved for SIC-98, which is not supported in this driver.) */
+/* 7: (unused in *BSD?)
+   <Original NE2000 compatible>
+   <for PCI/PCMCIA cards>
+*/
+#define NE2K_CBUS_HARDWARE_TYPE_NE2K 7
+/* 8: (not tested)
+   NEC PC-9801-108 */
+#define NE2K_CBUS_HARDWARE_TYPE_NEC108 8
+/* 9:
+   I-O DATA LA-98,LA/T-98 */
+#define NE2K_CBUS_HARDWARE_TYPE_IOLA98 9
+/* 10: (reserved for C-NET(98), which is not supported in this driver.) */
+/* 11:
+   Contec C-NET(98)E,L */
+#define NE2K_CBUS_HARDWARE_TYPE_CNET98EL 11
+
+#define NE2K_CBUS_HARDWARE_TYPE_MAX 11
+
+/* HARDWARE TYPE ID 12-31: reserved */
+
+struct ne2k_cbus_offsetinfo {
+	unsigned short skip;
+	unsigned short offset8; /* +0x8 - +0xf */
+	unsigned short offset10; /* +0x10 */
+	unsigned short offset1f; /* +0x1f */
+};
+
+struct ne2k_cbus_region {
+	unsigned short start;
+	short range;
+};
+
+struct ne2k_cbus_hwinfo {
+	const unsigned short hwtype;
+	const unsigned char *hwident;
+#ifndef MODULE
+	const unsigned short *portlist;
+#endif
+	const struct ne2k_cbus_offsetinfo *offsetinfo;
+	const struct ne2k_cbus_region *regionlist;
+};
+
+/* XXX */
+/* we can't use first __initdata with const? */
+static struct {} ne2k_cbus_dummy_for_initdata __attribute__((unused)) __initdata = {};
+
+#ifdef CONFIG_NE2K_CBUS_ATLA98
+#ifndef MODULE
+static const unsigned short atla98_portlist[] __initdata = {
+	0xd0,
+	0
+};
+#endif
+#define atla98_offsetinfo ne2k_offsetinfo
+#define atla98_regionlist ne2k_regionlist
+#endif /* CONFIG_NE2K_CBUS_ATLA98 */
+
+#ifdef CONFIG_NE2K_CBUS_BDN
+#ifndef MODULE
+static const unsigned short bdn_portlist[] __initdata = {
+	0xd0,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo bdn_offsetinfo __initdata = {
+#if 0
+	/* comes from FreeBSD(98) ed98.h */
+	0x1000, 0x8000, 0x100, 0xc200 /* ??? */
+#else
+	/* comes from NetBSD/pc98 if_ne_isa.c */
+	0x1000, 0x8000, 0x100, 0x7f00 /* ??? */
+#endif
+};
+static const struct ne2k_cbus_region bdn_regionlist[] __initdata = {
+	{0x0,1},{0x1000,1},{0x2000,1},{0x3000,1},
+	{0x4000,1},{0x5000,1},{0x6000,1},{0x7000,1},
+	{0x8000,1},{0x9000,1},{0xa000,1},{0xb000,1},
+	{0xc000,1},{0xd000,1},{0xe000,1},{0xf000,1},{0x100,1},{0x7f00,1},
+	{0x0,0}
+};
+#endif /* CONFIG_NE2K_CBUS_BDN */
+
+#ifdef CONFIG_NE2K_CBUS_EGY98
+#ifndef MODULE
+static const unsigned short egy98_portlist[] __initdata = {
+	0xd0,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo egy98_offsetinfo __initdata = {
+	0x02, 0x100, 0x200, 0x300
+};
+static const struct ne2k_cbus_region egy98_regionlist[] __initdata = {
+	{0x0,SPARSE_REGION(16)}, {0x100,SPARSE_REGION(16)},
+	{0x200,1}, {0x300,1},
+	{0x0,0}
+};
+#endif /* CONFIG_NE2K_CBUS_EGY98 */
+
+#ifdef CONFIG_NE2K_CBUS_LGY98
+#ifndef MODULE
+static const unsigned short lgy98_portlist[] __initdata = {
+	0xd0, 0x10d0, 0x20d0, 0x30d0, 0x40d0, 0x50d0, 0x60d0, 0x70d0,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo lgy98_offsetinfo __initdata = {
+	0x01, 0x08, 0x200, 0x300
+};
+static const struct ne2k_cbus_region lgy98_regionlist[] __initdata = {
+	{0x0,16}, {0x200,1}, {0x300,1},
+	{0x0,0}
+};
+#endif /* CONFIG_NE2K_CBUS_LGY98 */
+
+#ifdef CONFIG_NE2K_CBUS_ICM
+#ifndef MODULE
+static const unsigned short icm_portlist[] __initdata = {
+	/* ICM */
+	0x56d0,
+	/* LD-98PT */
+	0x46d0, 0x66d0, 0x76d0, 0x86d0, 0x96d0, 0xa6d0, 0xb6d0, 0xc6d0,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo icm_offsetinfo __initdata = {
+	0x01, 0x08, 0x100, 0x10f
+};
+static const struct ne2k_cbus_region icm_regionlist[] __initdata = {
+	{0x0,16}, {0x100,16},
+	{0x0,0}
+};
+#endif /* CONFIG_NE2K_CBUS_ICM */
+
+#if defined(CONFIG_NE2K_CBUS_NE2K) && !defined(MODULE)
+static const unsigned short ne2k_portlist[] __initdata = {
+	0xd0, 0x300, 0x280, 0x320, 0x340, 0x360, 0x380,
+	0
+};
+#endif
+#if defined(CONFIG_NE2K_CBUS_NE2K) || defined(CONFIG_NE2K_CBUS_ATLA98)
+static const struct ne2k_cbus_offsetinfo ne2k_offsetinfo __initdata = {
+	0x01, 0x08, 0x10, 0x1f
+};
+static const struct ne2k_cbus_region ne2k_regionlist[] __initdata = {
+	{0x0,32},
+	{0x0,0}
+};
+#endif
+
+#ifdef CONFIG_NE2K_CBUS_NEC108
+#ifndef MODULE
+static const unsigned short nec108_portlist[] __initdata = {
+    0x770, 0x2770, 0x4770, 0x6770,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo nec108_offsetinfo __initdata = {
+	0x02, 0x1000, 0x888, 0x88a
+};
+static const struct ne2k_cbus_region nec108_regionlist[] __initdata = {
+	{0x0,SPARSE_REGION(16)}, {0x1000,SPARSE_REGION(16)},
+	{0x118,SPARSE_REGION(8)},
+	{0x0,0}
+};
+#endif
+
+#ifdef CONFIG_NE2K_CBUS_IOLA98
+#ifndef MODULE
+static const unsigned short iola98_portlist[] __initdata = {
+	0xd0, 0xd2, 0xd4, 0xd6, 0xd8, 0xda, 0xdc, 0xde,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo iola98_offsetinfo __initdata = {
+	0x1000, 0x8000, 0x100, 0xf100
+};
+static const struct ne2k_cbus_region iola98_regionlist[] __initdata = {
+	{0x0,1},{0x1000,1},{0x2000,1},{0x3000,1},
+	{0x4000,1},{0x5000,1},{0x6000,1},{0x7000,1},
+	{0x8000,1},{0x9000,1},{0xa000,1},{0xb000,1},
+	{0xc000,1},{0xd000,1},{0xe000,1},{0xf000,1},{0x100,1},{0xf100,1},
+	{0x0,0}
+};
+#endif /* CONFIG_NE2K_CBUS_IOLA98 */
+
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+#ifndef MODULE
+static const unsigned short cnet98el_portlist[] __initdata = {
+	0x3d0, 0x13d0, 0x23d0, 0x33d0, 0x43d0, 0x53d0, 0x60d0, 0x70d0,
+	0
+};
+#endif
+static const struct ne2k_cbus_offsetinfo cnet98el_offsetinfo __initdata = {
+	0x01, 0x08, 0x40e, 0x400
+};
+static const struct ne2k_cbus_region cnet98el_regionlist[] __initdata = {
+	{0x0, 16}, {0x400, 16},
+	{0x0,0}
+};
+#endif
+
+
+/* port information table (for ne.c initialize/probe process) */
+
+static const struct ne2k_cbus_hwinfo ne2k_cbus_hwinfo_list[] __initdata = {
+#ifdef CONFIG_NE2K_CBUS_ATLA98
+/* NOT TESTED */
+	{
+		NE2K_CBUS_HARDWARE_TYPE_ATLA98,
+		"LA-98-T",
+#ifndef MODULE
+		atla98_portlist,
+#endif
+		&atla98_offsetinfo, atla98_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_BDN
+/* NOT TESTED */
+	{
+		NE2K_CBUS_HARDWARE_TYPE_BDN,
+		"LD-BDN[123]A",
+#ifndef MODULE
+		bdn_portlist,
+#endif
+		&bdn_offsetinfo, bdn_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_ICM
+	{
+		NE2K_CBUS_HARDWARE_TYPE_ICM,
+		"IF-27xxET",
+#ifndef MODULE
+		icm_portlist,
+#endif
+		&icm_offsetinfo, icm_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_NE2K
+	{
+		NE2K_CBUS_HARDWARE_TYPE_NE2K,
+		"NE2000 compat.",
+#ifndef MODULE
+		ne2k_portlist,
+#endif
+		&ne2k_offsetinfo, ne2k_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_NEC108
+/* NOT supported yet! */
+	{
+		NE2K_CBUS_HARDWARE_TYPE_NEC108,
+		"PC-9801-108",
+#ifndef MODULE
+		nec108_portlist,
+#endif
+		&nec108_offsetinfo, nec108_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_IOLA98
+	{
+		NE2K_CBUS_HARDWARE_TYPE_IOLA98,
+		"LA-98",
+#ifndef MODULE
+		iola98_portlist,
+#endif
+		&iola98_offsetinfo, iola98_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	{
+		NE2K_CBUS_HARDWARE_TYPE_CNET98EL,
+		"C-NET(98)E/L",
+#ifndef MODULE
+		cnet98el_portlist,
+#endif
+		&cnet98el_offsetinfo, cnet98el_regionlist
+	},
+#endif
+/* NOTE: LGY98 must be probed before EGY98, or system stalled!? */
+#ifdef CONFIG_NE2K_CBUS_LGY98
+	{
+		NE2K_CBUS_HARDWARE_TYPE_LGY98,
+		"LGY-98",
+#ifndef MODULE
+		lgy98_portlist,
+#endif
+		&lgy98_offsetinfo, lgy98_regionlist
+	},
+#endif
+#ifdef CONFIG_NE2K_CBUS_EGY98
+	{
+		NE2K_CBUS_HARDWARE_TYPE_EGY98,
+		"EGY-98",
+#ifndef MODULE
+		egy98_portlist,
+#endif
+		&egy98_offsetinfo, egy98_regionlist
+	},
+#endif
+	{
+		0,"unsupported hardware",
+#ifndef MODULE
+		NULL,
+#endif
+		NULL,NULL
+	}
+};
+
+static int __init ne2k_cbus_init(struct net_device *dev)
+{
+	struct ei_device *ei_local;
+	if(dev->priv == NULL) {
+		ei_local = kmalloc(sizeof(struct ei_device), GFP_KERNEL);
+		if (ei_local == NULL)
+			return -ENOMEM;
+		memset(ei_local, 0, sizeof(struct ei_device));
+		ei_local->reg_offset = kmalloc(sizeof(typeof(*ei_local->reg_offset))*18, GFP_KERNEL);
+		if (ei_local->reg_offset == NULL){
+			kfree(ei_local);
+			return -ENOMEM;
+		}
+		spin_lock_init(&ei_local->page_lock);
+		dev->priv = ei_local;
+	}
+	return 0;
+}
+
+static void ne2k_cbus_destroy(struct net_device *dev)
+{
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+	if(ei_local != NULL){
+		if(ei_local->reg_offset)
+			kfree(ei_local->reg_offset);
+		kfree(dev->priv);
+		dev->priv=NULL;
+	}
+}
+
+static const struct ne2k_cbus_hwinfo * __init ne2k_cbus_get_hwinfo(int hwtype)
+{
+	const struct ne2k_cbus_hwinfo *hw;
+
+	for(hw=&ne2k_cbus_hwinfo_list[0]; hw->hwtype; hw++){
+		if(hw->hwtype==hwtype) break;
+	}
+	return hw;
+}
+
+static void __init ne2k_cbus_set_hwtype(struct net_device *dev, const struct ne2k_cbus_hwinfo *hw, int ioaddr)
+{
+	struct ei_device *ei_local=(struct ei_device *)(dev->priv);
+	int i;
+	int hwtype_old=(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK);
+
+	if (!ei_local)
+		panic("Gieee! ei_local == NULL!! (from %p)",
+		       __builtin_return_address(0));
+
+	dev->mem_start &= (~NE2K_CBUS_HARDWARE_TYPE_MASK);
+	dev->mem_start |= (hw->hwtype & NE2K_CBUS_HARDWARE_TYPE_MASK);
+
+	if(ei_debug>2){
+		printk(KERN_DEBUG "hwtype changed: %d -> %d\n",hwtype_old,(int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+	}
+
+	if(hw->offsetinfo){
+		for(i=0;i<8;i++){
+			ei_local->reg_offset[i] = hw->offsetinfo->skip * i;
+		}
+		for(i=8;i<16;i++){
+			ei_local->reg_offset[i] =
+				hw->offsetinfo->skip*(i-8) + hw->offsetinfo->offset8;
+		}
+#ifdef CONFIG_NE2K_CBUS_NEC108
+		if(hw->hwtype==NE2K_CBUS_HARDWARE_TYPE_NEC108){
+			int adj = (ioaddr & 0xf000) /2;
+			ei_local->reg_offset[16] = 
+				(hw->offsetinfo->offset10 | adj) - ioaddr;
+			ei_local->reg_offset[17] = 
+				(hw->offsetinfo->offset1f | adj) - ioaddr;
+		}else{
+#endif /* CONFIG_NE2K_CBUS_NEC108 */
+			ei_local->reg_offset[16] = hw->offsetinfo->offset10;
+			ei_local->reg_offset[17] = hw->offsetinfo->offset1f;
+#ifdef CONFIG_NE2K_CBUS_NEC108
+		}
+#endif
+	}else{
+		/* make dummmy offset list */
+		for(i=0;i<16;i++){
+			ei_local->reg_offset[i] = i;
+		}
+		ei_local->reg_offset[16] = 0x10;
+		ei_local->reg_offset[17] = 0x1f;
+	}
+}
+
+#if defined(CONFIG_NE2K_CBUS_ICM) || defined(CONFIG_NE2K_CBUS_CNET98EL)
+static void __init ne2k_cbus_readmem(struct net_device *dev, int ioaddr, unsigned short memaddr, char *buf, unsigned short len)
+{
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+	outb_p(E8390_NODMA | E8390_START, ioaddr+E8390_CMD);
+	outb_p(               len & 0xff, ioaddr+EN0_RCNTLO);
+	outb_p(               len >> 8  , ioaddr+EN0_RCNTHI);
+	outb_p(           memaddr & 0xff, ioaddr+EN0_RSARLO);
+	outb_p(           memaddr >> 8  , ioaddr+EN0_RSARHI);
+	outb_p(E8390_RREAD | E8390_START, ioaddr+E8390_CMD);
+	insw(ioaddr+NE_DATAPORT, buf, len>>1);
+}
+static void __init ne2k_cbus_writemem(struct net_device *dev, int ioaddr, unsigned short memaddr, const char *buf, unsigned short len)
+{
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+	outb_p(E8390_NODMA | E8390_START, ioaddr+E8390_CMD);
+	outb_p(                ENISR_RDC, ioaddr+EN0_ISR);
+	outb_p(              len & 0xff , ioaddr+EN0_RCNTLO);
+	outb_p(              len >> 8   , ioaddr+EN0_RCNTHI);
+	outb_p(          memaddr & 0xff , ioaddr+EN0_RSARLO);
+	outb_p(          memaddr >> 8   , ioaddr+EN0_RSARHI);
+	outb_p(E8390_RWRITE | E8390_START, ioaddr+E8390_CMD);
+	outsw(ioaddr+NE_DATAPORT, buf, len>>1);
+}
+#endif
+
+/* End of ne2k_cbus.h */
