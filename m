Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263131AbTCUCom>; Thu, 20 Mar 2003 21:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTCUCol>; Thu, 20 Mar 2003 21:44:41 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:58240 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S263261AbTCUCl0>; Thu, 20 Mar 2003 21:41:26 -0500
Date: Fri, 21 Mar 2003 11:51:32 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (9/14) NIC
Message-ID: <20030321025132.GI1847@yuzuki.cinet.co.jp>
References: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321022850.GA1767@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac1. (9/14)

C-bus(PC98's legacy bus like ISA) network cards support.
Change IO port and IRQ assign.
Add NE2000 compatible driver for PC-9800.
  PCI netwwork card works fine without patch.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64/drivers/net/3c509.c linux98-2.5.64/drivers/net/3c509.c
--- linux-2.5.64/drivers/net/3c509.c	2003-03-05 11:22:46.000000000 +0900
+++ linux98-2.5.64/drivers/net/3c509.c	2003-03-05 11:45:08.000000000 +0900
@@ -56,6 +56,10 @@
 		v1.19b 08Nov2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
 		    - Introduce driver model for EISA cards.
 */
+/*
+  FIXES for PC-9800:
+  Shu Iwanaga: 3c569B(PC-9801 C-bus) support
+*/
 
 #define DRV_NAME	"3c509"
 #define DRV_VERSION	"1.19b"
@@ -257,7 +261,7 @@
 };
 #endif /* CONFIG_MCA */
 
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 static struct isapnp_device_id el3_isapnp_adapters[] __initdata = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5090),
@@ -350,7 +354,7 @@
 		if (lp->pmdev)
 			pm_unregister(lp->pmdev);
 #endif
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 		if (lp->type == EL3_PNP)
 			pnp_device_detach(to_pnp_dev(lp->dev));
 #endif
@@ -368,12 +372,12 @@
 	int ioaddr, irq, if_port;
 	u16 phys_addr[3];
 	static int current_tag;
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	static int pnp_cards;
 	struct pnp_dev *idev = NULL;
 #endif /* __ISAPNP__ */
 
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	if (nopnp == 1)
 		goto no_pnp;
 
@@ -421,6 +425,9 @@
 no_pnp:
 #endif /* __ISAPNP__ */
 
+#ifdef CONFIG_X86_PC9800
+	id_port = 0x71d0;
+#else
 	/* Select an open I/O location at 0x1*0 to do contention select. */
 	for ( ; id_port < 0x200; id_port += 0x10) {
 		if (check_region(id_port, 1))
@@ -435,6 +442,7 @@
 		printk(" WARNING: No I/O port available for 3c509 activation.\n");
 		return -ENODEV;
 	}
+#endif /* CONFIG_X86_PC9800 */
 	/* Next check for all ISA bus boards by sending the ID sequence to the
 	   ID_PORT.  We find cards past the first by setting the 'current_tag'
 	   on cards as they are found.  Cards with their tag set will not
@@ -465,7 +473,7 @@
 		phys_addr[i] = htons(id_read_eeprom(i));
 	}
 
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	if (nopnp == 0) {
 		/* The ISA PnP 3c509 cards respond to the ID sequence.
 		   This check is needed in order not to register them twice. */
@@ -490,9 +498,19 @@
 	{
 		unsigned int iobase = id_read_eeprom(8);
 		if_port = iobase >> 14;
+#ifdef CONFIG_X86_PC9800
+		ioaddr = 0x40d0 + ((iobase & 0x1f) << 8);
+#else
 		ioaddr = 0x200 + ((iobase & 0x1f) << 4);
+#endif
 	}
 	irq = id_read_eeprom(9) >> 12;
+#ifdef CONFIG_X86_PC9800
+	if (irq == 7)
+		irq = 6;
+	else if (irq == 15)
+		irq = 13;
+#endif
 
 	if (!(dev = init_etherdev(NULL, sizeof(struct el3_private))))
 			return -ENOMEM;
@@ -522,7 +540,11 @@
 	outb(0xd0 + ++current_tag, id_port);
 
 	/* Activate the adaptor at the EEPROM location. */
+#ifdef CONFIG_X86_PC9800
+	outb((ioaddr >> 8) | 0xe0, id_port);
+#else
 	outb((ioaddr >> 4) | 0xe0, id_port);
+#endif
 
 	EL3WINDOW(0);
 	if (inw(ioaddr) != 0x6d50) {
@@ -534,7 +556,7 @@
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
 
-#ifdef __ISAPNP__	
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
  found:							/* PNP jumps here... */
 #endif /* __ISAPNP__ */
 
@@ -543,7 +565,7 @@
 	dev->irq = irq;
 	dev->if_port = if_port;
 	lp = dev->priv;
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	lp->dev = &idev->dev;
 #endif
 
@@ -1388,6 +1410,12 @@
 	outw(0x0001, ioaddr + 4);
 
 	/* Set the IRQ line. */
+#ifdef CONFIG_X86_PC9800
+	if (dev->irq == 6)
+		dev->irq = 7;
+	else if (dev->irq == 13)
+		dev->irq = 15;
+#endif
 	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
 
 	/* Set the station address in window 2 each time opened. */
@@ -1550,7 +1578,7 @@
 MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
 MODULE_PARM_DESC(xcvr,"transceiver(s) (0=internal, 1=external)");
 MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt");
-#ifdef __ISAPNP__
+#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 MODULE_PARM(nopnp, "i");
 MODULE_PARM_DESC(nopnp, "disable ISA PnP support (0-1)");
 MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
diff -Nru linux-2.5.42/drivers/net/8390.h linux98-2.5.42/drivers/net/8390.h
--- linux-2.5.42/drivers/net/8390.h	2002-10-12 13:22:14.000000000 +0900
+++ linux98-2.5.42/drivers/net/8390.h	2002-10-15 23:03:22.000000000 +0900
@@ -123,7 +123,8 @@
 #define inb_p(port)   in_8(port)
 #define outb_p(val,port)  out_8(port,val)
 
-#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE)
+#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE) || \
+      defined(CONFIG_NET_CBUS)
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #else
 #define EI_SHIFT(x)	(x)
diff -Nru linux-2.5.62-ac1/drivers/net/Kconfig linux98-2.5.62-ac1/drivers/net/Kconfig
--- linux-2.5.62-ac1/drivers/net/Kconfig	2003-02-18 07:56:53.000000000 +0900
+++ linux98-2.5.62-ac1/drivers/net/Kconfig	2003-02-21 11:07:56.000000000 +0900
@@ -663,7 +663,7 @@
 	  as <file:Documentation/networking/net-modules.txt>.
 
 config EL3
-	tristate "3c509/3c529 (MCA)/3c579 \"EtherLink III\" support"
+	tristate "3c509/3c529 (MCA)/3c569B (98)/3c579 \"EtherLink III\" support"
 	depends on NET_VENDOR_3COM && (ISA || EISA || MCA)
 	---help---
 	  If you have a network (Ethernet) card belonging to the 3Com
@@ -932,7 +932,7 @@
 source "drivers/net/tulip/Kconfig"
 
 config AT1700
-	tristate "AT1700/1720 support (EXPERIMENTAL)"
+	tristate "AT1700/1720/RE1000Plus(C-Bus) support (EXPERIMENTAL)"
 	depends on NET_ETHERNET && (ISA || MCA) && EXPERIMENTAL
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
@@ -978,7 +978,7 @@
 
 config NET_ISA
 	bool "Other ISA cards"
-	depends on NET_ETHERNET && ISA
+	depends on NET_ETHERNET && ISA && !X86_PC9800
 	---help---
 	  If your network (Ethernet) card hasn't been mentioned yet and its
 	  bus system (that's the way the cards talks to the other components
@@ -1176,6 +1176,55 @@
 	  the Ethernet-HOWTO, available from
 	  <http://www.linuxdoc.org/docs.html#howto>.
 
+config NET_CBUS
+	bool "NEC PC-9800 C-bus cards"
+	depends on NET_ETHERNET && ISA && X86_PC9800
+	---help---
+	  If your network (Ethernet) card hasn't been mentioned yet and its
+	  bus system (that's the way the cards talks to the other components
+	  of your computer) is NEC PC-9800 C-Bus, say Y.
+
+config NE2K_CBUS
+	tristate "Most NE2000-based Ethernet support"
+	depends on NET_CBUS
+
+config NE2K_CBUS_EGY98
+	bool "Melco EGY-98 support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_LGY98
+	bool "Melco LGY-98 support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_ICM
+	bool "ICM IF-27xxET support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_IOLA98
+	bool "I-O DATA LA-98 support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_CNET98EL
+	bool "Contec C-NET(98)E/L support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_CNET98EL_IO_BASE
+	hex "C-NET(98)E/L I/O base address (0xaaed or 0x55ed)"
+	depends on NE2K_CBUS_CNET98EL
+	default "0xaaed"
+
+config NE2K_CBUS_ATLA98
+	bool "Allied Telesis LA-98 Support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_BDN
+	bool "ELECOM Laneed LD-BDN[123]A Support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_NEC108
+	bool "NEC PC-9801-108 Support"
+	depends on NE2K_CBUS
+
 config SKMC
 	tristate "SKnet MCA support"
 	depends on NET_ETHERNET && MCA
diff -Nru linux-2.5.64/drivers/net/Makefile linux98-2.5.64/drivers/net/Makefile
--- linux-2.5.64/drivers/net/Makefile	2003-03-05 12:29:04.000000000 +0900
+++ linux98-2.5.64/drivers/net/Makefile	2003-03-13 17:06:03.000000000 +0900
@@ -81,6 +81,7 @@
 obj-$(CONFIG_WD80x3) += wd.o 8390.o
 obj-$(CONFIG_EL2) += 3c503.o 8390.o
 obj-$(CONFIG_NE2000) += ne.o 8390.o
+obj-$(CONFIG_NE2K_CBUS) += ne2k_cbus.o 8390.o
 obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
 obj-$(CONFIG_HPLAN) += hp.o 8390.o
 obj-$(CONFIG_HPLAN_PLUS) += hp-plus.o 8390.o
diff -Nru linux-2.5.42/drivers/net/Makefile.lib linux98-2.5.42/drivers/net/Makefile.lib
--- linux-2.5.42/drivers/net/Makefile.lib	2002-10-12 13:22:18.000000000 +0900
+++ linux98-2.5.42/drivers/net/Makefile.lib	2002-10-15 23:03:22.000000000 +0900
@@ -19,6 +19,7 @@
 obj-$(CONFIG_MACMACE)		+= crc32.o
 obj-$(CONFIG_MIPS_AU1000_ENET)	+= crc32.o
 obj-$(CONFIG_NATSEMI)		+= crc32.o	
+obj-$(CONFIG_NE2K_CBUS)		+= crc32.o
 obj-$(CONFIG_PCMCIA_FMVJ18X)	+= crc32.o
 obj-$(CONFIG_PCMCIA_SMC91C92)	+= crc32.o
 obj-$(CONFIG_PCMCIA_XIRTULIP)	+= crc32.o
diff -Nru linux-2.5.64-ac1/drivers/net/Space.c linux98-2.5.64-ac1/drivers/net/Space.c
--- linux-2.5.64-ac1/drivers/net/Space.c	2003-03-07 08:52:03.000000000 +0900
+++ linux98-2.5.64-ac1/drivers/net/Space.c	2003-03-07 13:30:51.000000000 +0900
@@ -229,7 +229,7 @@
 #ifdef CONFIG_E2100		/* Cabletron E21xx series. */
 	{e2100_probe, 0},
 #endif
-#ifdef CONFIG_NE2000		/* ISA (use ne2k-pci for PCI cards) */
+#if defined(CONFIG_NE2000) || defined(CONFIG_NE2K_CBUS)	/* ISA & PC-9800 CBUS (use ne2k-pci for PCI cards) */
 	{ne_probe, 0},
 #endif
 #ifdef CONFIG_LANCE		/* ISA/VLB (use pcnet32 for PCI cards) */
diff -Nru linux-2.5.64/drivers/net/at1700.c linux98-2.5.64/drivers/net/at1700.c
--- linux-2.5.64/drivers/net/at1700.c	2003-03-05 12:29:16.000000000 +0900
+++ linux98-2.5.64/drivers/net/at1700.c	2003-03-15 12:54:58.000000000 +0900
@@ -34,6 +34,10 @@
 	only is it difficult to detect, it also moves around in I/O space in
 	response to inb()s from other device probes!
 */
+/*
+	99/03/03  Allied Telesis RE1000 Plus support by T.Hagawa
+	99/12/30	port to 2.3.35 by K.Takai
+*/
 
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -76,10 +80,17 @@
  *	ISA
  */
 
+#ifndef CONFIG_X86_PC9800
 static int at1700_probe_list[] __initdata = {
 	0x260, 0x280, 0x2a0, 0x240, 0x340, 0x320, 0x380, 0x300, 0
 };
 
+#else /* CONFIG_X86_PC9800 */
+static int at1700_probe_list[] __initdata = {
+	0x1d6, 0x1d8, 0x1da, 0x1d4, 0xd4, 0xd2, 0xd8, 0xd0, 0
+};
+
+#endif /* CONFIG_X86_PC9800 */
 /*
  *	MCA
  */
@@ -122,6 +133,7 @@
 
 
 /* Offsets from the base address. */
+#ifndef CONFIG_X86_PC9800
 #define STATUS			0
 #define TX_STATUS		0
 #define RX_STATUS		1
@@ -136,6 +148,7 @@
 #define TX_START		10
 #define COL16CNTL		11		/* Controll Reg for 16 collisions */
 #define MODE13			13
+#define RX_CTRL			14
 /* Configuration registers only on the '865A/B chips. */
 #define EEPROM_Ctrl 	16
 #define EEPROM_Data 	17
@@ -144,8 +157,39 @@
 #define IOCONFIG		18		/* Either read the jumper, or move the I/O. */
 #define IOCONFIG1		19
 #define	SAPROM			20		/* The station address PROM, if no EEPROM. */
+#define MODE24			24
 #define RESET			31		/* Write to reset some parts of the chip. */
 #define AT1700_IO_EXTENT	32
+#define PORT_OFFSET(o) (o)
+#else /* CONFIG_X86_PC9800 */
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
+#define CARDSTATUS	16			/* FMV-18x Card Status */
+#define CARDSTATUS1	17			/* FMV-18x Card Status */
+#define IOCONFIG		(0x1400)/* Either read the jumper, or move the I/O. */
+#define IOCONFIG1		(0x1600)
+#define	SAPROM			20		/* The station address PROM, if no EEPROM. */
+#define	MODE24			(0x1800)/* The station address PROM, if no EEPROM. */
+#define RESET			(0x1e01)/* Write to reset some parts of the chip. */
+#define PORT_OFFSET(o) ({ int _o_ = (o); (_o_ & ~1) * 0x100 + (_o_ & 1); })
+#endif /* CONFIG_X86_PC9800 */
+
 
 #define TX_TIMEOUT		10
 
@@ -225,8 +269,20 @@
 	int slot, ret = -ENODEV;
 	struct net_local *lp;
 	
+#ifndef CONFIG_X86_PC9800
 	if (!request_region(ioaddr, AT1700_IO_EXTENT, dev->name))
 		return -EBUSY;
+#else
+	for (i = 0; i < 0x2000; i += 0x0200) {
+		if (!request_region(ioaddr + i, 2, dev->name)) {
+			while (i > 0) {
+				i -= 0x0200;
+				release_region(ioaddr + i, 2);
+			}
+			return -EBUSY;
+		}
+	}
+#endif
 
 		/* Resetting the chip doesn't reset the ISA interface, so don't bother.
 	   That means we have to be careful with the register values we probe for.
@@ -317,10 +373,17 @@
 		/* Reset the internal state machines. */
 	outb(0, ioaddr + RESET);
 
-	if (is_at1700)
+	if (is_at1700) {
+#ifndef CONFIG_X86_PC9800
 		irq = at1700_irqmap[(read_eeprom(ioaddr, 12)&0x04)
 						   | (read_eeprom(ioaddr, 0)>>14)];
-	else {
+#else
+		{
+			char re1000plus_irqmap[4] = {3, 5, 6, 12};
+			irq = re1000plus_irqmap[inb(ioaddr + IOCONFIG1) >> 6];
+		}
+#endif
+	} else {
 		/* Check PnP mode for FMV-183/184/183A/184A. */
 		/* This PnP routine is very poor. IO and IRQ should be known. */
 		if (inb(ioaddr + CARDSTATUS1) & 0x20) {
@@ -392,18 +455,22 @@
 	/* Set the station address in bank zero. */
 	outb(0x00, ioaddr + CONFIG_1);
 	for (i = 0; i < 6; i++)
-		outb(dev->dev_addr[i], ioaddr + 8 + i);
+		outb(dev->dev_addr[i], ioaddr + PORT_OFFSET(8 + i));
 
 	/* Switch to bank 1 and set the multicast table to accept none. */
 	outb(0x04, ioaddr + CONFIG_1);
 	for (i = 0; i < 8; i++)
-		outb(0x00, ioaddr + 8 + i);
+		outb(0x00, ioaddr + PORT_OFFSET(8 + i));
 
 
 	/* Switch to bank 2 */
 	/* Lock our I/O address, and set manual processing mode for 16 collisions. */
 	outb(0x08, ioaddr + CONFIG_1);
+#ifndef CONFIG_X86_PC9800
 	outb(dev->if_port, ioaddr + MODE13);
+#else
+	outb(0, ioaddr + MODE13);
+#endif
 	outb(0x00, ioaddr + COL16CNTL);
 
 	if (net_debug)
@@ -447,7 +514,12 @@
 	kfree(dev->priv);
 	dev->priv = NULL;
 err_out:
+#ifndef CONFIG_X86_PC9800
 	release_region(ioaddr, AT1700_IO_EXTENT);
+#else
+	for (i = 0; i < 0x2000; i += 0x0200)
+		release_region(ioaddr + i, 2);
+#endif
 	return ret;
 }
 
@@ -459,7 +531,11 @@
 #define EE_DATA_READ	0x80	/* EEPROM chip data out, in reg. 17. */
 
 /* Delay between EEPROM clock transitions. */
+#ifndef CONFIG_X86_PC9800
 #define eeprom_delay()	do { } while (0)
+#else
+#define eeprom_delay()	__asm__ ("out%B0 %%al,%0" :: "N"(0x5f))
+#endif
 
 /* The EEPROM commands include the alway-set leading bit. */
 #define EE_WRITE_CMD	(5 << 6)
@@ -542,12 +618,12 @@
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
@@ -704,7 +780,7 @@
 				   dev->name, inb(ioaddr + RX_MODE), status);
 #ifndef final_version
 		if (status == 0) {
-			outb(0x05, ioaddr + 14);
+			outb(0x05, ioaddr + RX_CTRL);
 			break;
 		}
 #endif
@@ -724,7 +800,7 @@
 					   dev->name, pkt_len);
 				/* Prime the FIFO and then flush the packet. */
 				inw(ioaddr + DATAPORT); inw(ioaddr + DATAPORT);
-				outb(0x05, ioaddr + 14);
+				outb(0x05, ioaddr + RX_CTRL);
 				lp->stats.rx_errors++;
 				break;
 			}
@@ -734,7 +810,7 @@
 					   dev->name, pkt_len);
 				/* Prime the FIFO and then flush the packet. */
 				inw(ioaddr + DATAPORT); inw(ioaddr + DATAPORT);
-				outb(0x05, ioaddr + 14);
+				outb(0x05, ioaddr + RX_CTRL);
 				lp->stats.rx_dropped++;
 				break;
 			}
@@ -761,7 +837,7 @@
 			if ((inb(ioaddr + RX_MODE) & 0x40) == 0x40)
 				break;
 			inw(ioaddr + DATAPORT);				/* dummy status read */
-			outb(0x05, ioaddr + 14);
+			outb(0x05, ioaddr + RX_CTRL);
 		}
 
 		if (net_debug > 5)
@@ -844,24 +920,28 @@
 		outb(0x02, ioaddr + RX_MODE);	/* Use normal mode. */
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave (&lp->lock, flags);
 	if (memcmp(mc_filter, lp->mc_filter, sizeof(mc_filter))) {
 		int saved_bank = inw(ioaddr + CONFIG_0);
 		/* Switch to bank 1 and set the multicast table. */
 		outw((saved_bank & ~0x0C00) | 0x0480, ioaddr + CONFIG_0);
 		for (i = 0; i < 8; i++)
-			outb(mc_filter[i], ioaddr + 8 + i);
+			outb(mc_filter[i], ioaddr + PORT_OFFSET(8 + i));
 		memcpy(lp->mc_filter, mc_filter, sizeof(mc_filter));
 		outw(saved_bank, ioaddr + CONFIG_0);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore (&lp->lock, flags);
 	return;
 }
 
 #ifdef MODULE
 static struct net_device dev_at1700;
+#ifndef CONFIG_X86_PC9800
 static int io = 0x260;
+#else
+static int io = 0xd0;
+#endif
+
 static int irq;
 
 MODULE_PARM(io, "i");
@@ -901,7 +981,15 @@
 
 	/* If we don't do this, we can't re-insmod it later. */
 	free_irq(dev_at1700.irq, NULL);
+#ifndef CONFIG_X86_PC9800
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
diff -Nru linux/drivers/net/ne2k_cbus.c linux98/drivers/net/ne2k_cbus.c
--- linux/drivers/net/ne2k_cbus.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/net/ne2k_cbus.c	2003-03-15 12:37:35.000000000 +0900
@@ -0,0 +1,879 @@
+/* ne.c: A general non-shared-memory NS8390 ethernet driver for linux. */
+/*
+    Written 1992-94 by Donald Becker.
+
+    Copyright 1993 United States Government as represented by the
+    Director, National Security Agency.
+
+    This software may be used and distributed according to the terms
+    of the GNU General Public License, incorporated herein by reference.
+
+    The author may be reached as becker@scyld.com, or C/O
+    Scyld Computing Corporation, 410 Severn Ave., Suite 210, Annapolis MD 21403
+
+    This driver should work with many programmed-I/O 8390-based ethernet
+    boards.  Currently it supports the NE1000, NE2000, many clones,
+    and some Cabletron products.
+
+    Changelog:
+
+    Paul Gortmaker	: use ENISR_RDC to monitor Tx PIO uploads, made
+			  sanity checks and bad clone support optional.
+    Paul Gortmaker	: new reset code, reset card after probe at boot.
+    Paul Gortmaker	: multiple card support for module users.
+    Paul Gortmaker	: Support for PCI ne2k clones, similar to lance.c
+    Paul Gortmaker	: Allow users with bad cards to avoid full probe.
+    Paul Gortmaker	: PCI probe changes, more PCI cards supported.
+    rjohnson@analogic.com : Changed init order so an interrupt will only
+    occur after memory is allocated for dev->priv. Deallocated memory
+    last in cleanup_modue()
+    Richard Guenther    : Added support for ISAPnP cards
+    Paul Gortmaker	: Discontinued PCI support - use ne2k-pci.c instead.
+    Osamu Tomita	: Separate driver for NEC PC-9800.
+
+*/
+
+/* Routines for the NatSemi-based designs (NE[12]000). */
+
+static const char version1[] =
+"ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)\n";
+static const char version2[] =
+"Last modified Nov 1, 2000 by Paul Gortmaker\n";
+
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/isapnp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+
+#include "8390.h"
+
+/* Some defines that people can play with if so inclined. */
+
+/* Do we support clones that don't adhere to 14,15 of the SAprom ? */
+#define SUPPORT_NE_BAD_CLONES
+
+/* Do we perform extra sanity checks on stuff ? */
+/* #define NE_SANITY_CHECK */
+
+/* Do we implement the read before write bugfix ? */
+/* #define NE_RW_BUGFIX */
+
+/* Do we have a non std. amount of memory? (in units of 256 byte pages) */
+/* #define PACKETBUF_MEMSIZE	0x40 */
+
+#ifdef SUPPORT_NE_BAD_CLONES
+/* A list of bad clones that we none-the-less recognize. */
+static struct { const char *name8, *name16; unsigned char SAprefix[4];}
+bad_clone_list[] __initdata = {
+    {"LA/T-98?", "LA/T-98", {0x00, 0xa0, 0xb0}},	/* I/O Data */
+    {"EGY-98?", "EGY-98", {0x00, 0x40, 0x26}},		/* Melco EGY98 */
+    {"ICM?", "ICM-27xx-ET", {0x00, 0x80, 0xc8}},	/* ICM IF-27xx-ET */
+    {"CNET-98/EL?", "CNET(98)E/L", {0x00, 0x80, 0x4C}},	/* Contec CNET-98/EL */
+    {0,}
+};
+#endif
+
+/* ---- No user-serviceable parts below ---- */
+
+#define NE_BASE	 (dev->base_addr)
+#define NE_CMD	 	EI_SHIFT(0x00)
+#define NE_DATAPORT	EI_SHIFT(0x10)	/* NatSemi-defined port window offset. */
+#define NE_RESET	EI_SHIFT(0x1f) /* Issue a read to reset, a write to clear. */
+#define NE_IO_EXTENT	0x20
+
+#define NE1SM_START_PG	0x20	/* First page of TX buffer */
+#define NE1SM_STOP_PG 	0x40	/* Last page +1 of RX ring */
+#define NESM_START_PG	0x40	/* First page of TX buffer */
+#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
+
+#include "ne2k_cbus.h"
+
+int ne_probe(struct net_device *dev);
+static int ne_probe1(struct net_device *dev, int ioaddr);
+static int ne_open(struct net_device *dev);
+static int ne_close(struct net_device *dev);
+
+static void ne_reset_8390(struct net_device *dev);
+static void ne_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr,
+			  int ring_page);
+static void ne_block_input(struct net_device *dev, int count,
+			  struct sk_buff *skb, int ring_offset);
+static void ne_block_output(struct net_device *dev, const int count,
+		const unsigned char *buf, const int start_page);
+
+
+/*  Probe for various non-shared-memory ethercards.
+
+   NEx000-clone boards have a Station Address PROM (SAPROM) in the packet
+   buffer memory space.  NE2000 clones have 0x57,0x57 in bytes 0x0e,0x0f of
+   the SAPROM, while other supposed NE2000 clones must be detected by their
+   SA prefix.
+
+   Reading the SAPROM from a word-wide card with the 8390 set in byte-wide
+   mode results in doubled values, which can be detected and compensated for.
+
+   The probe is also responsible for initializing the card and filling
+   in the 'dev' and 'ei_status' structures.
+
+   We use the minimum memory size for some ethercard product lines, iff we can't
+   distinguish models.  You can increase the packet buffer size by setting
+   PACKETBUF_MEMSIZE.  Reported Cabletron packet buffer locations are:
+	E1010   starts at 0x100 and ends at 0x2000.
+	E1010-x starts at 0x100 and ends at 0x8000. ("-x" means "more memory")
+	E2010	 starts at 0x100 and ends at 0x4000.
+	E2010-x starts at 0x100 and ends at 0xffff.  */
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
+	if (ne2k_cbus_init(dev) != 0)
+		return -ENOMEM;
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
+			for (plist = hw->portlist; *plist; plist++)
+				if (ne_probe_cbus(dev, hw, *plist) == 0)
+					return 0;
+		} else {
+			for (hw = &ne2k_cbus_hwinfo_list[0]; hw->hwtype; hw++) {
+				const unsigned short *plist;
+				for (plist = hw->portlist; *plist; plist++)
+					if (ne_probe_cbus(dev, hw, *plist) == 0)
+						return 0;
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
+			if (ne_probe1(dev, ioaddr) == 0)
+				return 0;
+		}
+	}
+	return -ENODEV;
+}
+
+static int __init ne_probe1(struct net_device *dev, int ioaddr)
+{
+	int i;
+	unsigned char SA_prom[32];
+	int wordlength = 2;
+	const char *name = NULL;
+	int start_page, stop_page;
+	int neX000, bad_card;
+	int reg0, ret;
+	static unsigned version_printed;
+	const struct ne2k_cbus_region *rlist;
+	const struct ne2k_cbus_hwinfo *hw = ne2k_cbus_get_hwinfo((int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
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
+	for (rlist = hw->regionlist; rlist->range; rlist++)
+		if (!request_region(ioaddr + rlist->start,
+					rlist->range, dev->name)) {
+			ret = -EBUSY;
+			goto err_out;
+		}
+
+	reg0 = inb_p(ioaddr + EI_SHIFT(0));
+	if (reg0 == 0xFF) {
+		ret = -ENODEV;
+		goto err_out;
+	}
+
+	/* Do a preliminary verification that we have a 8390. */
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	if (hw->hwtype != NE2K_CBUS_HARDWARE_TYPE_CNET98EL)
+#endif
+	{
+		int regd;
+		outb_p(E8390_NODMA+E8390_PAGE1+E8390_STOP, ioaddr + E8390_CMD);
+		regd = inb_p(ioaddr + EI_SHIFT(0x0d));
+		outb_p(0xff, ioaddr + EI_SHIFT(0x0d));
+		outb_p(E8390_NODMA+E8390_PAGE0, ioaddr + E8390_CMD);
+		inb_p(ioaddr + EN0_COUNTER0); /* Clear the counter by reading. */
+		if (inb_p(ioaddr + EN0_COUNTER0) != 0) {
+			outb_p(reg0, ioaddr);
+			outb_p(regd, ioaddr + EI_SHIFT(0x0d));	/* Restore the old values. */
+			ret = -ENODEV;
+			goto err_out;
+		}
+	}
+
+	if (ei_debug  &&  version_printed++ == 0)
+		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
+
+	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
+
+	/* A user with a poor card that fails to ack the reset, or that
+	   does not have a valid 0x57,0x57 signature can still use this
+	   without having to recompile. Specifying an i/o address along
+	   with an otherwise unused dev->mem_end value of "0xBAD" will
+	   cause the driver to skip these parts of the probe. */
+
+	bad_card = ((dev->base_addr != 0) && (dev->mem_end == 0xbad));
+
+	/* Reset card. Who knows what dain-bramaged state it was left in. */
+
+	{
+		unsigned long reset_start_time = jiffies;
+
+		/* derived from CNET98EL-patch for bad clones */
+		outb_p(E8390_NODMA | E8390_STOP, ioaddr + E8390_CMD);
+
+		/* DON'T change these to inb_p/outb_p or reset will fail on clones. */
+		outb(inb(ioaddr + NE_RESET), ioaddr + NE_RESET);
+
+		while ((inb_p(ioaddr + EN0_ISR) & ENISR_RESET) == 0)
+		if (jiffies - reset_start_time > 2*HZ/100) {
+			if (bad_card) {
+				printk(" (warning: no reset ack)");
+				break;
+			} else {
+				printk(" not found (no reset ack).\n");
+				ret = -ENODEV;
+				goto err_out;
+			}
+		}
+
+		outb_p(0xff, ioaddr + EN0_ISR);		/* Ack all intr. */
+	}
+
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+	if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_CNET98EL) {
+		static const char pat[32] ="AbcdeFghijKlmnoPqrstUvwxyZ789012";
+		char buf[32];
+		int maxwait = 200;
+
+		if (ei_debug > 2)
+			printk(" [CNET98EL-specific initialize...");
+		outb_p(E8390_NODMA | E8390_STOP, ioaddr + E8390_CMD); /* 0x20|0x1 */
+		i = inb(ioaddr);
+		if ((i & ~0x2) != (0x20 | 0x01))
+			return -ENODEV;
+		if ((inb(ioaddr + 0x7) & 0x80) != 0x80)
+			return -ENODEV;
+		outb_p(E8390_RXOFF, ioaddr + EN0_RXCR); /* out(ioaddr+0xc, 0x20) */
+		/* outb_p(ENDCFG_WTS|ENDCFG_FT1|ENDCFG_LS, ioaddr+EN0_DCFG); */
+		outb_p(ENDCFG_WTS | 0x48, ioaddr + EN0_DCFG); /* 0x49 */
+		outb_p(CNET98EL_START_PG, ioaddr + EN0_STARTPG);
+		outb_p(CNET98EL_STOP_PG, ioaddr + EN0_STOPPG);
+		if (ei_debug > 2)
+			printk("memory check");
+		for (i = 0; i < 65536; i += 1024) {
+			if (ei_debug > 2)
+				printk(" %04x", i);
+			ne2k_cbus_writemem(dev, ioaddr, i, pat, 32);
+			while (((inb(ioaddr + EN0_ISR) & ENISR_RDC) != ENISR_RDC) && --maxwait)
+				;
+			ne2k_cbus_readmem(dev, ioaddr, i, buf, 32);
+			if (memcmp(pat, buf, 32)) {
+				if (ei_debug > 2)
+					printk(" failed.");
+				break;
+			}
+		}
+		if (i != 16384) {
+			if (ei_debug > 2)
+				printk("] ");
+			printk("memory failure at %x\n", i);
+			return -ENODEV;
+		}
+		if (ei_debug > 2)
+			printk(" good...");
+		if (!dev->irq) {
+			if (ei_debug > 2)
+				printk("] ");
+			printk("IRQ must be specified for C-NET(98)E/L. probe failed.\n");
+			return -ENODEV;
+		}
+		outb((dev->irq > 5) ? (dev->irq & 4):(dev->irq >> 1), ioaddr + (0x2 | 0x400));
+		outb(0x7e, ioaddr + (0x4 | 0x400));
+		ne2k_cbus_readmem(dev, ioaddr, 16384, SA_prom, 32);
+		outb(0xff, ioaddr + EN0_ISR);
+		if (ei_debug > 2)
+			printk("done]");
+	} else
+#endif /* CONFIG_NE2K_CBUS_CNET98EL */
+	/* Read the 16 bytes of station address PROM.
+	   We must first initialize registers, similar to NS8390_init(eifdev, 0).
+	   We can't reliably read the SAPROM address without this.
+	   (I learned the hard way!). */
+	{
+		struct {unsigned char value; unsigned short offset;} program_seq[] = 
+		{
+			{E8390_NODMA+E8390_PAGE0+E8390_STOP, E8390_CMD}, /* Select page 0*/
+			/* NEC PC-9800: some board can only handle word-wide access? */
+			{0x48 | ENDCFG_WTS,	EN0_DCFG},	/* Set word-wide (0x48) access. */
+			{16384 / 256, EN0_STARTPG},
+			{32768 / 256, EN0_STOPPG},
+			{0x00,	EN0_RCNTLO},	/* Clear the count regs. */
+			{0x00,	EN0_RCNTHI},
+			{0x00,	EN0_IMR},	/* Mask completion irq. */
+			{0xFF,	EN0_ISR},
+			{E8390_RXOFF, EN0_RXCR},	/* 0x20  Set to monitor */
+			{E8390_TXOFF, EN0_TXCR},	/* 0x02  and loopback mode. */
+			{32,	EN0_RCNTLO},
+			{0x00,	EN0_RCNTHI},
+			{0x00,	EN0_RSARLO},	/* DMA starting at 0x0000. */
+			{0x00,	EN0_RSARHI},
+			{E8390_RREAD+E8390_START, E8390_CMD},
+		};
+
+		for (i = 0; i < sizeof(program_seq)/sizeof(program_seq[0]); i++)
+			outb_p(program_seq[i].value, ioaddr + program_seq[i].offset);
+		insw(ioaddr + NE_DATAPORT, SA_prom, 32 >> 1);
+
+	}
+
+	if (wordlength == 2)
+	{
+		for (i = 0; i < 16; i++)
+			SA_prom[i] = SA_prom[i+i];
+		start_page = NESM_START_PG;
+		stop_page = NESM_STOP_PG;
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+		if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_CNET98EL) {
+			start_page = CNET98EL_START_PG;
+			stop_page = CNET98EL_STOP_PG;
+		}
+#endif
+	} else {
+		start_page = NE1SM_START_PG;
+		stop_page = NE1SM_STOP_PG;
+	}
+
+	neX000 = (SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57);
+	if (neX000) {
+		name = "C-Bus-NE2K-compat";
+	}
+	else
+	{
+#ifdef SUPPORT_NE_BAD_CLONES
+		/* Ack!  Well, there might be a *bad* NE*000 clone there.
+		   Check for total bogus addresses. */
+		for (i = 0; bad_clone_list[i].name8; i++)
+		{
+			if (SA_prom[0] == bad_clone_list[i].SAprefix[0] &&
+				SA_prom[1] == bad_clone_list[i].SAprefix[1] &&
+				SA_prom[2] == bad_clone_list[i].SAprefix[2])
+			{
+				if (wordlength == 2)
+				{
+					name = bad_clone_list[i].name16;
+				} else {
+					name = bad_clone_list[i].name8;
+				}
+				break;
+			}
+		}
+		if (bad_clone_list[i].name8 == NULL)
+		{
+			printk(" not found (invalid signature %2.2x %2.2x).\n",
+				SA_prom[14], SA_prom[15]);
+			ret = -ENXIO;
+			goto err_out;
+		}
+#else
+		printk(" not found.\n");
+		ret = -ENXIO;
+		goto err_out;
+#endif
+	}
+
+	if (dev->irq < 2)
+	{
+		unsigned long cookie = probe_irq_on();
+		outb_p(0x50, ioaddr + EN0_IMR);	/* Enable one interrupt. */
+		outb_p(0x00, ioaddr + EN0_RCNTLO);
+		outb_p(0x00, ioaddr + EN0_RCNTHI);
+		outb_p(E8390_RREAD+E8390_START, ioaddr); /* Trigger it... */
+		mdelay(10);		/* wait 10ms for interrupt to propagate */
+		outb_p(0x00, ioaddr + EN0_IMR); 		/* Mask it again. */
+		dev->irq = probe_irq_off(cookie);
+		if (ei_debug > 2)
+			printk(" autoirq is %d\n", dev->irq);
+	} else if (dev->irq == 7)
+		/* Fixup for users that don't know that IRQ 7 is really IRQ 11,
+		   or don't know which one to set. */
+		dev->irq = 11;
+
+	if (! dev->irq) {
+		printk(" failed to detect IRQ line.\n");
+		ret = -EAGAIN;
+		goto err_out;
+	}
+
+	/* Allocate dev->priv and fill in 8390 specific dev fields. */
+	if (ethdev_init(dev))
+	{
+        	printk (" unable to get memory for dev->priv.\n");
+        	ret = -ENOMEM;
+		goto err_out;
+	}
+
+	/* Snarf the interrupt now.  There's no point in waiting since we cannot
+	   share and the board will usually be enabled. */
+	ret = request_irq(dev->irq, ei_interrupt, 0, name, dev);
+	if (ret) {
+		printk (" unable to get IRQ %d (errno=%d).\n", dev->irq, ret);
+		goto err_out_kfree;
+	}
+
+	dev->base_addr = ioaddr;
+
+	for(i = 0; i < ETHER_ADDR_LEN; i++) {
+		printk(" %2.2x", SA_prom[i]);
+		dev->dev_addr[i] = SA_prom[i];
+	}
+
+	printk("\n%s: %s found at %#x, hardware type %d(%s), using IRQ %d.\n",
+		   dev->name, name, ioaddr, hw->hwtype, hw->hwident, dev->irq);
+
+	ei_status.name = name;
+	ei_status.tx_start_page = start_page;
+	ei_status.stop_page = stop_page;
+	ei_status.word16 = (wordlength == 2);
+
+	ei_status.rx_start_page = start_page + TX_PAGES;
+#ifdef PACKETBUF_MEMSIZE
+	 /* Allow the packet buffer size to be overridden by know-it-alls. */
+	ei_status.stop_page = ei_status.tx_start_page + PACKETBUF_MEMSIZE;
+#endif
+
+	ei_status.reset_8390 = &ne_reset_8390;
+	ei_status.block_input = &ne_block_input;
+	ei_status.block_output = &ne_block_output;
+	ei_status.get_8390_hdr = &ne_get_8390_hdr;
+	ei_status.priv = 0;
+	dev->open = &ne_open;
+	dev->stop = &ne_close;
+	NS8390_init(dev, 0);
+	return 0;
+
+err_out_kfree:
+	ne2k_cbus_destroy(dev);
+err_out:
+	while (rlist > hw->regionlist) {
+		rlist --;
+		release_region(ioaddr + rlist->start, rlist->range);
+	}
+	return ret;
+}
+
+static int ne_open(struct net_device *dev)
+{
+	ei_open(dev);
+	return 0;
+}
+
+static int ne_close(struct net_device *dev)
+{
+	if (ei_debug > 1)
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
+	ei_close(dev);
+	return 0;
+}
+
+/* Hard reset the card.  This used to pause for the same period that a
+   8390 reset command required, but that shouldn't be necessary. */
+
+static void ne_reset_8390(struct net_device *dev)
+{
+	unsigned long reset_start_time = jiffies;
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+
+	if (ei_debug > 1)
+		printk(KERN_DEBUG "resetting the 8390 t=%ld...", jiffies);
+
+	/* derived from CNET98EL-patch for bad clones... */
+	outb_p(E8390_NODMA | E8390_STOP, NE_BASE + E8390_CMD);  /* 0x20 | 0x1 */
+
+	/* DON'T change these to inb_p/outb_p or reset will fail on clones. */
+	outb(inb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);
+
+	ei_status.txing = 0;
+	ei_status.dmaing = 0;
+
+	/* This check _should_not_ be necessary, omit eventually. */
+	while ((inb_p(NE_BASE+EN0_ISR) & ENISR_RESET) == 0)
+		if (jiffies - reset_start_time > 2*HZ/100) {
+			printk(KERN_WARNING "%s: ne_reset_8390() did not complete.\n", dev->name);
+			break;
+		}
+	outb_p(ENISR_RESET, NE_BASE + EN0_ISR);	/* Ack intr. */
+}
+
+/* Grab the 8390 specific header. Similar to the block_input routine, but
+   we don't need to be concerned with ring wrap as the header will be at
+   the start of a page, so we optimize accordingly. */
+
+static void ne_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr, int ring_page)
+{
+	int nic_base = dev->base_addr;
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+
+	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
+
+	if (ei_status.dmaing)
+	{
+		printk(KERN_EMERG "%s: DMAing conflict in ne_get_8390_hdr "
+			"[DMAstat:%d][irqlock:%d].\n",
+			dev->name, ei_status.dmaing, ei_status.irqlock);
+		return;
+	}
+
+	ei_status.dmaing |= 0x01;
+	outb_p(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
+	outb_p(sizeof(struct e8390_pkt_hdr), nic_base + EN0_RCNTLO);
+	outb_p(0, nic_base + EN0_RCNTHI);
+	outb_p(0, nic_base + EN0_RSARLO);		/* On page boundary */
+	outb_p(ring_page, nic_base + EN0_RSARHI);
+	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+
+	if (ei_status.word16)
+		insw(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr)>>1);
+	else
+		insb(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr));
+
+	outb_p(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
+	ei_status.dmaing &= ~0x01;
+
+	le16_to_cpus(&hdr->count);
+}
+
+/* Block input and output, similar to the Crynwr packet driver.  If you
+   are porting to a new ethercard, look at the packet driver source for hints.
+   The NEx000 doesn't share the on-board packet memory -- you have to put
+   the packet out through the "remote DMA" dataport using outb. */
+
+static void ne_block_input(struct net_device *dev, int count, struct sk_buff *skb, int ring_offset)
+{
+#ifdef NE_SANITY_CHECK
+	int xfer_count = count;
+#endif
+	int nic_base = dev->base_addr;
+	char *buf = skb->data;
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+
+	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
+	if (ei_status.dmaing)
+	{
+		printk(KERN_EMERG "%s: DMAing conflict in ne_block_input "
+			"[DMAstat:%d][irqlock:%d].\n",
+			dev->name, ei_status.dmaing, ei_status.irqlock);
+		return;
+	}
+	ei_status.dmaing |= 0x01;
+
+	/* round up count to a word (derived from ICM-patch) */
+	count = (count + 1) & ~1;
+
+	outb_p(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
+	outb_p(count & 0xff, nic_base + EN0_RCNTLO);
+	outb_p(count >> 8, nic_base + EN0_RCNTHI);
+	outb_p(ring_offset & 0xff, nic_base + EN0_RSARLO);
+	outb_p(ring_offset >> 8, nic_base + EN0_RSARHI);
+	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+	if (ei_status.word16)
+	{
+		insw(NE_BASE + NE_DATAPORT,buf,count>>1);
+		if (count & 0x01)
+		{
+			buf[count-1] = inb(NE_BASE + NE_DATAPORT);
+#ifdef NE_SANITY_CHECK
+			xfer_count++;
+#endif
+		}
+	} else {
+		insb(NE_BASE + NE_DATAPORT, buf, count);
+	}
+
+#ifdef NE_SANITY_CHECK
+	/* This was for the ALPHA version only, but enough people have
+	   been encountering problems so it is still here.  If you see
+	   this message you either 1) have a slightly incompatible clone
+	   or 2) have noise/speed problems with your bus. */
+
+	if (ei_debug > 1)
+	{
+		/* DMA termination address check... */
+		int addr, tries = 20;
+		do {
+			/* DON'T check for 'inb_p(EN0_ISR) & ENISR_RDC' here
+			   -- it's broken for Rx on some cards! */
+			int high = inb_p(nic_base + EN0_RSARHI);
+			int low = inb_p(nic_base + EN0_RSARLO);
+			addr = (high << 8) + low;
+			if (((ring_offset + xfer_count) & 0xff) == low)
+				break;
+		} while (--tries > 0);
+	 	if (tries <= 0)
+			printk(KERN_WARNING "%s: RX transfer address mismatch,"
+				"%#4.4x (expected) vs. %#4.4x (actual).\n",
+				dev->name, ring_offset + xfer_count, addr);
+	}
+#endif
+	outb_p(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
+	ei_status.dmaing &= ~0x01;
+}
+
+static void ne_block_output(struct net_device *dev, int count,
+		const unsigned char *buf, const int start_page)
+{
+	int nic_base = NE_BASE;
+	unsigned long dma_start;
+#ifdef NE_SANITY_CHECK
+	int retries = 0;
+#endif
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+
+	/* Round the count up for word writes.  Do we need to do this?
+	   What effect will an odd byte count have on the 8390?
+	   I should check someday. */
+
+	if (ei_status.word16 && (count & 0x01))
+		count++;
+
+	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
+	if (ei_status.dmaing)
+	{
+		printk(KERN_EMERG "%s: DMAing conflict in ne_block_output."
+			"[DMAstat:%d][irqlock:%d]\n",
+			dev->name, ei_status.dmaing, ei_status.irqlock);
+		return;
+	}
+	ei_status.dmaing |= 0x01;
+	/* We should already be in page 0, but to be safe... */
+	outb_p(E8390_PAGE0+E8390_START+E8390_NODMA, nic_base + NE_CMD);
+
+#ifdef NE_SANITY_CHECK
+retry:
+#endif
+
+#ifdef NE8390_RW_BUGFIX
+	/* Handle the read-before-write bug the same way as the
+	   Crynwr packet driver -- the NatSemi method doesn't work.
+	   Actually this doesn't always work either, but if you have
+	   problems with your NEx000 this is better than nothing! */
+
+	outb_p(0x42, nic_base + EN0_RCNTLO);
+	outb_p(0x00,   nic_base + EN0_RCNTHI);
+	outb_p(0x42, nic_base + EN0_RSARLO);
+	outb_p(0x00, nic_base + EN0_RSARHI);
+	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+	/* Make certain that the dummy read has occurred. */
+	udelay(6);
+#endif
+
+	outb_p(ENISR_RDC, nic_base + EN0_ISR);
+
+	/* Now the normal output. */
+	outb_p(count & 0xff, nic_base + EN0_RCNTLO);
+	outb_p(count >> 8,   nic_base + EN0_RCNTHI);
+	outb_p(0x00, nic_base + EN0_RSARLO);
+	outb_p(start_page, nic_base + EN0_RSARHI);
+
+	outb_p(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
+	if (ei_status.word16) {
+		outsw(NE_BASE + NE_DATAPORT, buf, count>>1);
+	} else {
+		outsb(NE_BASE + NE_DATAPORT, buf, count);
+	}
+
+	dma_start = jiffies;
+
+#ifdef NE_SANITY_CHECK
+	/* This was for the ALPHA version only, but enough people have
+	   been encountering problems so it is still here. */
+
+	if (ei_debug > 1)
+	{
+		/* DMA termination address check... */
+		int addr, tries = 20;
+		do {
+			int high = inb_p(nic_base + EN0_RSARHI);
+			int low = inb_p(nic_base + EN0_RSARLO);
+			addr = (high << 8) + low;
+			if ((start_page << 8) + count == addr)
+				break;
+		} while (--tries > 0);
+
+		if (tries <= 0)
+		{
+			printk(KERN_WARNING "%s: Tx packet transfer address mismatch,"
+				"%#4.4x (expected) vs. %#4.4x (actual).\n",
+				dev->name, (start_page << 8) + count, addr);
+			if (retries++ == 0)
+				goto retry;
+		}
+	}
+#endif
+
+	while ((inb_p(nic_base + EN0_ISR) & ENISR_RDC) == 0)
+		if (jiffies - dma_start > 2*HZ/100) {		/* 20ms */
+			printk(KERN_WARNING "%s: timeout waiting for Tx RDC.\n", dev->name);
+			ne_reset_8390(dev);
+			NS8390_init(dev,1);
+			break;
+		}
+
+	outb_p(ENISR_RDC, nic_base + EN0_ISR);	/* Ack intr. */
+	ei_status.dmaing &= ~0x01;
+	return;
+}
+
+
+#ifdef MODULE
+#define MAX_NE_CARDS	4	/* Max number of NE cards per module */
+static struct net_device dev_ne[MAX_NE_CARDS];
+static int io[MAX_NE_CARDS];
+static int irq[MAX_NE_CARDS];
+static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
+static int hwtype[MAX_NE_CARDS] = { 0, }; /* board type */
+
+MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+MODULE_PARM(hwtype, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+MODULE_PARM_DESC(io, "I/O base address(es),required");
+MODULE_PARM_DESC(irq, "IRQ number(s)");
+MODULE_PARM_DESC(bad, "Accept card(s) with bad signatures");
+MODULE_PARM_DESC(hwtype, "Board type of PC-9800 C-Bus NIC");
+MODULE_DESCRIPTION("NE1000/NE2000 PC-9800 C-bus Ethernet driver");
+MODULE_LICENSE("GPL");
+
+/* This is set up so that no ISA autoprobe takes place. We can't guarantee
+that the ne2k probe is the last 8390 based probe to take place (as it
+is at boot) and so the probe will get confused by any other 8390 cards.
+ISA device autoprobes on a running machine are not recommended anyway. */
+
+int init_module(void)
+{
+	int this_dev, found = 0;
+
+	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
+		struct net_device *dev = &dev_ne[this_dev];
+		dev->irq = irq[this_dev];
+		dev->mem_end = bad[this_dev];
+		dev->base_addr = io[this_dev];
+		dev->mem_start = hwtype[this_dev];
+		dev->init = ne_probe;
+		if (register_netdev(dev) == 0) {
+			found++;
+			continue;
+		}
+		if (found != 0) { 	/* Got at least one. */
+			return 0;
+		}
+		if (io[this_dev] != 0)
+			printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[this_dev]);
+		else
+			printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for C-Bus cards.\n");
+		return -ENXIO;
+	}
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	int this_dev;
+
+	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
+		struct net_device *dev = &dev_ne[this_dev];
+		if (dev->priv != NULL) {
+			const struct ne2k_cbus_region *rlist;
+			const struct ne2k_cbus_hwinfo *hw = ne2k_cbus_get_hwinfo((int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+
+			free_irq(dev->irq, dev);
+			for (rlist = hw->regionlist; rlist->range; rlist++) {
+				release_region(dev->base_addr + rlist->start,
+						rlist->range);
+			}
+			unregister_netdev(dev);
+			ne2k_cbus_destroy(dev);
+		}
+	}
+}
+#endif /* MODULE */
+
+
+/*
+ * Local variables:
+ *  compile-command: "gcc -DKERNEL -Wall -O6 -fomit-frame-pointer -I/usr/src/linux/net/tcp -c ne.c"
+ *  version-control: t
+ *  kept-new-versions: 5
+ * End:
+ */
diff -Nru linux-2.5.50/drivers/net/ne2k_cbus.h linux98-2.5.50/drivers/net/ne2k_cbus.h
--- linux-2.5.42/drivers/net/ne2k_cbus.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.42/drivers/net/ne2k_cbus.h	2002-12-15 10:56:15.000000000 +0900
@@ -0,0 +1,481 @@
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
+#undef NE_RESET
+#define NE_RESET EI_SHIFT(0x11) /* Issue a read to reset, a write to clear. */
+
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
+/* 8:
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
+#ifdef CONFIG_NE2K_CBUS_ATLA98
+#ifndef MODULE
+static unsigned short atla98_portlist[] __initdata = {
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
+static unsigned short bdn_portlist[] __initdata = {
+	0xd0,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo bdn_offsetinfo __initdata = {
+#if 0
+	/* comes from FreeBSD(98) ed98.h */
+	0x1000, 0x8000, 0x100, 0xc200 /* ??? */
+#else
+	/* comes from NetBSD/pc98 if_ne_isa.c */
+	0x1000, 0x8000, 0x100, 0x7f00 /* ??? */
+#endif
+};
+static struct ne2k_cbus_region bdn_regionlist[] __initdata = {
+	{0x0, 1}, {0x1000, 1}, {0x2000, 1}, {0x3000,1},
+	{0x4000, 1}, {0x5000, 1}, {0x6000, 1}, {0x7000, 1},
+	{0x8000, 1}, {0x9000, 1}, {0xa000, 1}, {0xb000, 1},
+	{0xc000, 1}, {0xd000, 1}, {0xe000, 1}, {0xf000, 1},
+	{0x100, 1}, {0x7f00, 1},
+	{0x0, 0}
+};
+#endif /* CONFIG_NE2K_CBUS_BDN */
+
+#ifdef CONFIG_NE2K_CBUS_EGY98
+#ifndef MODULE
+static unsigned short egy98_portlist[] __initdata = {
+	0xd0,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo egy98_offsetinfo __initdata = {
+	0x02, 0x100, 0x200, 0x300
+};
+static struct ne2k_cbus_region egy98_regionlist[] __initdata = {
+	{0x0, 1}, {0x2, 1}, {0x4, 1}, {0x6, 1},
+	{0x8, 1}, {0xa, 1}, {0xc, 1}, {0xe, 1},
+	{0x100, 1}, {0x102, 1}, {0x104, 1}, {0x106, 1},
+	{0x108, 1}, {0x10a, 1}, {0x10c, 1}, {0x10e, 1},
+	{0x200, 1}, {0x300, 1},
+	{0x0, 0}
+};
+#endif /* CONFIG_NE2K_CBUS_EGY98 */
+
+#ifdef CONFIG_NE2K_CBUS_LGY98
+#ifndef MODULE
+static unsigned short lgy98_portlist[] __initdata = {
+	0xd0, 0x10d0, 0x20d0, 0x30d0, 0x40d0, 0x50d0, 0x60d0, 0x70d0,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo lgy98_offsetinfo __initdata = {
+	0x01, 0x08, 0x200, 0x300
+};
+static struct ne2k_cbus_region lgy98_regionlist[] __initdata = {
+	{0x0, 16}, {0x200, 1}, {0x300, 1},
+	{0x0, 0}
+};
+#endif /* CONFIG_NE2K_CBUS_LGY98 */
+
+#ifdef CONFIG_NE2K_CBUS_ICM
+#ifndef MODULE
+static unsigned short icm_portlist[] __initdata = {
+	/* ICM */
+	0x56d0,
+	/* LD-98PT */
+	0x46d0, 0x66d0, 0x76d0, 0x86d0, 0x96d0, 0xa6d0, 0xb6d0, 0xc6d0,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo icm_offsetinfo __initdata = {
+	0x01, 0x08, 0x100, 0x10f
+};
+static struct ne2k_cbus_region icm_regionlist[] __initdata = {
+	{0x0, 16}, {0x100, 16},
+	{0x0, 0}
+};
+#endif /* CONFIG_NE2K_CBUS_ICM */
+
+#if defined(CONFIG_NE2K_CBUS_NE2K) && !defined(MODULE)
+static unsigned short ne2k_portlist[] __initdata = {
+	0xd0, 0x300, 0x280, 0x320, 0x340, 0x360, 0x380,
+	0
+};
+#endif
+#if defined(CONFIG_NE2K_CBUS_NE2K) || defined(CONFIG_NE2K_CBUS_ATLA98)
+static struct ne2k_cbus_offsetinfo ne2k_offsetinfo __initdata = {
+	0x01, 0x08, 0x10, 0x1f
+};
+static struct ne2k_cbus_region ne2k_regionlist[] __initdata = {
+	{0x0, 32},
+	{0x0, 0}
+};
+#endif
+
+#ifdef CONFIG_NE2K_CBUS_NEC108
+#ifndef MODULE
+static unsigned short nec108_portlist[] __initdata = {
+	0x770, 0x2770, 0x4770, 0x6770,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo nec108_offsetinfo __initdata = {
+	0x02, 0x1000, 0x888, 0x88a
+};
+static struct ne2k_cbus_region nec108_regionlist[] __initdata = {
+	{0x0, 1}, {0x2, 1}, {0x4, 1}, {0x6, 1},
+	{0x8, 1}, {0xa, 1}, {0xc, 1}, {0xe, 1},
+	{0x1000, 1}, {0x1002, 1}, {0x1004, 1}, {0x1006, 1},
+	{0x1008, 1}, {0x100a, 1}, {0x100c, 1}, {0x100e, 1},
+	{0x888, 1}, {0x88a, 1}, {0x88c, 1}, {0x88e, 1},
+	{0x0, 0}
+};
+#endif
+
+#ifdef CONFIG_NE2K_CBUS_IOLA98
+#ifndef MODULE
+static unsigned short iola98_portlist[] __initdata = {
+	0xd0, 0xd2, 0xd4, 0xd6, 0xd8, 0xda, 0xdc, 0xde,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo iola98_offsetinfo __initdata = {
+	0x1000, 0x8000, 0x100, 0xf100
+};
+static struct ne2k_cbus_region iola98_regionlist[] __initdata = {
+	{0x0, 1}, {0x1000, 1}, {0x2000, 1}, {0x3000, 1},
+	{0x4000, 1}, {0x5000, 1}, {0x6000, 1}, {0x7000, 1},
+	{0x8000, 1}, {0x9000, 1}, {0xa000, 1}, {0xb000, 1},
+	{0xc000, 1}, {0xd000, 1}, {0xe000, 1}, {0xf000, 1},
+	{0x100, 1}, {0xf100, 1},
+	{0x0,0}
+};
+#endif /* CONFIG_NE2K_CBUS_IOLA98 */
+
+#ifdef CONFIG_NE2K_CBUS_CNET98EL
+#ifndef MODULE
+static unsigned short cnet98el_portlist[] __initdata = {
+	0x3d0, 0x13d0, 0x23d0, 0x33d0, 0x43d0, 0x53d0, 0x60d0, 0x70d0,
+	0
+};
+#endif
+static struct ne2k_cbus_offsetinfo cnet98el_offsetinfo __initdata = {
+	0x01, 0x08, 0x40e, 0x400
+};
+static struct ne2k_cbus_region cnet98el_regionlist[] __initdata = {
+	{0x0, 16}, {0x400, 16},
+	{0x0, 0}
+};
+#endif
+
+
+/* port information table (for ne.c initialize/probe process) */
+
+static struct ne2k_cbus_hwinfo ne2k_cbus_hwinfo_list[] __initdata = {
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
+		0,
+		"unsupported hardware",
+#ifndef MODULE
+		NULL,
+#endif
+		NULL, NULL
+	}
+};
+
+static int __init ne2k_cbus_init(struct net_device *dev)
+{
+	struct ei_device *ei_local;
+	if (dev->priv == NULL) {
+		ei_local = kmalloc(sizeof(struct ei_device), GFP_KERNEL);
+		if (ei_local == NULL)
+			return -ENOMEM;
+		memset(ei_local, 0, sizeof(struct ei_device));
+		ei_local->reg_offset = kmalloc(sizeof(typeof(*ei_local->reg_offset))*18, GFP_KERNEL);
+		if (ei_local->reg_offset == NULL) {
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
+	if (ei_local != NULL) {
+		if (ei_local->reg_offset)
+			kfree(ei_local->reg_offset);
+		kfree(dev->priv);
+		dev->priv = NULL;
+	}
+}
+
+static const struct ne2k_cbus_hwinfo * __init ne2k_cbus_get_hwinfo(int hwtype)
+{
+	const struct ne2k_cbus_hwinfo *hw;
+
+	for (hw = &ne2k_cbus_hwinfo_list[0]; hw->hwtype; hw++) {
+		if (hw->hwtype == hwtype) break;
+	}
+	return hw;
+}
+
+static void __init ne2k_cbus_set_hwtype(struct net_device *dev, const struct ne2k_cbus_hwinfo *hw, int ioaddr)
+{
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+	int i;
+	int hwtype_old = dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK;
+
+	if (!ei_local)
+		panic("Gieee! ei_local == NULL!! (from %p)",
+		       __builtin_return_address(0));
+
+	dev->mem_start &= ~NE2K_CBUS_HARDWARE_TYPE_MASK;
+	dev->mem_start |= hw->hwtype & NE2K_CBUS_HARDWARE_TYPE_MASK;
+
+	if (ei_debug > 2) {
+		printk(KERN_DEBUG "hwtype changed: %d -> %d\n",hwtype_old,(int)(dev->mem_start & NE2K_CBUS_HARDWARE_TYPE_MASK));
+	}
+
+	if (hw->offsetinfo) {
+		for (i = 0; i < 8; i++) {
+			ei_local->reg_offset[i] = hw->offsetinfo->skip * i;
+		}
+		for (i = 8; i < 16; i++) {
+			ei_local->reg_offset[i] =
+				hw->offsetinfo->skip*(i-8) + hw->offsetinfo->offset8;
+		}
+#ifdef CONFIG_NE2K_CBUS_NEC108
+		if (hw->hwtype == NE2K_CBUS_HARDWARE_TYPE_NEC108) {
+			int adj = (ioaddr & 0xf000) /2;
+			ei_local->reg_offset[16] = 
+				(hw->offsetinfo->offset10 | adj) - ioaddr;
+			ei_local->reg_offset[17] = 
+				(hw->offsetinfo->offset1f | adj) - ioaddr;
+		} else {
+#endif /* CONFIG_NE2K_CBUS_NEC108 */
+			ei_local->reg_offset[16] = hw->offsetinfo->offset10;
+			ei_local->reg_offset[17] = hw->offsetinfo->offset1f;
+#ifdef CONFIG_NE2K_CBUS_NEC108
+		}
+#endif
+	} else {
+		/* make dummmy offset list */
+		for (i = 0; i < 16; i++) {
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
+	outb_p(len & 0xff, ioaddr+EN0_RCNTLO);
+	outb_p(len >> 8, ioaddr+EN0_RCNTHI);
+	outb_p(memaddr & 0xff, ioaddr+EN0_RSARLO);
+	outb_p(memaddr >> 8, ioaddr+EN0_RSARHI);
+	outb_p(E8390_RREAD | E8390_START, ioaddr+E8390_CMD);
+	insw(ioaddr+NE_DATAPORT, buf, len >> 1);
+}
+static void __init ne2k_cbus_writemem(struct net_device *dev, int ioaddr, unsigned short memaddr, const char *buf, unsigned short len)
+{
+	struct ei_device *ei_local = (struct ei_device *)(dev->priv);
+	outb_p(E8390_NODMA | E8390_START, ioaddr+E8390_CMD);
+	outb_p(ENISR_RDC, ioaddr+EN0_ISR);
+	outb_p(len & 0xff, ioaddr+EN0_RCNTLO);
+	outb_p(len >> 8, ioaddr+EN0_RCNTHI);
+	outb_p(memaddr & 0xff, ioaddr+EN0_RSARLO);
+	outb_p(memaddr >> 8, ioaddr+EN0_RSARHI);
+	outb_p(E8390_RWRITE | E8390_START, ioaddr+E8390_CMD);
+	outsw(ioaddr+NE_DATAPORT, buf, len >> 1);
+}
+#endif
+
+static int ne_probe_cbus(struct net_device *dev, const struct ne2k_cbus_hwinfo *hw, int ioaddr);
+/* End of ne2k_cbus.h */
