Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264810AbUEPUQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbUEPUQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUEPUQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 16:16:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48639 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264733AbUEPUQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 16:16:07 -0400
Date: Sun, 16 May 2004 22:15:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.6-mm3: more PC9800 removal
Message-ID: <20040516201558.GQ22742@fs.tum.de>
References: <20040516025514.3fe93f0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please review the patch below that removes more PC9800 code from 
2.6.6-mm3.

diffstat output:
 arch/i386/kernel/i8259.c      |    5 -
 drivers/char/keyboard.c       |    5 -
 drivers/ide/ide-proc.c        |    1 
 drivers/net/3c509.c           |   45 +++--------------
 drivers/net/Space.c           |    4 -
 drivers/net/at1700.c          |   88 ----------------------------------
 drivers/pnp/isapnp/core.c     |    5 -
 drivers/serial/8250_pnp.c     |    3 -
 include/asm-i386/ide.h        |   34 -------------
 include/asm-i386/processor.h  |    6 --
 include/asm-i386/serial.h     |    7 --
 include/asm-i386/timex.h      |    4 -
 include/linux/ide.h           |    4 -
 include/linux/serial_core.h   |    8 ---
 include/linux/serio.h         |    1 
 sound/core/seq/Makefile       |    1 
 sound/core/seq/instr/Makefile |    1 
 sound/drivers/mpu401/mpu401.c |   11 ----
 sound/drivers/opl3/opl3_lib.c |   20 -------
 19 files changed, 15 insertions(+), 238 deletions(-)

additional commands:
  rm drivers/char/upd4990a.c
  rm drivers/net/ne2k_cbus.{c,h}

cu
Adrian

--- linux-2.6.6-mm3-full/arch/i386/kernel/i8259.c.old	2004-05-16 20:44:27.000000000 +0200
+++ linux-2.6.6-mm3-full/arch/i386/kernel/i8259.c	2004-05-16 20:44:43.000000000 +0200
@@ -317,16 +317,11 @@
  * be shot.
  */
  
-/*
- * =PC9800NOTE= In NEC PC-9800, we use irq8 instead of irq13!
- */
 
 static irqreturn_t math_error_irq(int cpl, void *dev_id, struct pt_regs *regs)
 {
 	extern void math_error(void *);
-#ifndef CONFIG_X86_PC9800
 	outb(0,0xF0);
-#endif
 	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
 		return IRQ_NONE;
 	math_error((void *)regs->eip);
--- linux-2.6.6-mm3-full/drivers/char/keyboard.c.old	2004-05-16 20:47:33.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/char/keyboard.c	2004-05-16 20:47:54.000000000 +0200
@@ -52,13 +52,12 @@
 
 /*
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
- * This seems a good reason to start with NumLock off. On PC9800 and HIL keyboards 
+ * This seems a good reason to start with NumLock off. On HIL keyboards 
  * of PARISC machines however there is no NumLock key and everyone expects the keypad 
  * to be used for numbers.
  */
 
-#if defined(CONFIG_X86_PC9800) || \
-    defined(CONFIG_PARISC) && (defined(CONFIG_KEYBOARD_HIL) || defined(CONFIG_KEYBOARD_HIL_OLD))
+#if defined(CONFIG_PARISC) && (defined(CONFIG_KEYBOARD_HIL) || defined(CONFIG_KEYBOARD_HIL_OLD))
 #define KBD_DEFLEDS (1 << VC_NUMLOCK)
 #else
 #define KBD_DEFLEDS 0
--- linux-2.6.6-mm3-full/drivers/net/3c509.c.old	2004-05-16 20:52:55.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/net/3c509.c	2004-05-16 20:55:00.000000000 +0200
@@ -56,10 +56,6 @@
 		v1.19b 08Nov2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
 		    - Introduce driver model for EISA cards.
 */
-/*
-  FIXES for PC-9800:
-  Shu Iwanaga: 3c569B(PC-9801 C-bus) support
-*/
 
 #define DRV_NAME	"3c509"
 #define DRV_VERSION	"1.19b"
@@ -265,7 +261,7 @@
 };
 #endif /* CONFIG_MCA */
 
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 static struct isapnp_device_id el3_isapnp_adapters[] __initdata = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5090),
@@ -362,7 +358,7 @@
 	if (lp->pmdev)
 		pm_unregister(lp->pmdev);
 #endif
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 	if (lp->type == EL3_PNP)
 		pnp_device_detach(to_pnp_dev(lp->dev));
 #endif
@@ -381,7 +377,7 @@
 	u16 phys_addr[3];
 	static int current_tag;
 	int err = -ENODEV;
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 	static int pnp_cards;
 	struct pnp_dev *idev = NULL;
 
@@ -436,9 +432,6 @@
 no_pnp:
 #endif /* __ISAPNP__ */
 
-#ifdef CONFIG_X86_PC9800
-	id_port = 0x71d0;
-#else
 	/* Select an open I/O location at 0x1*0 to do contention select. */
 	for ( ; id_port < 0x200; id_port += 0x10) {
 		if (!request_region(id_port, 1, "3c509"))
@@ -456,7 +449,7 @@
 		printk(" WARNING: No I/O port available for 3c509 activation.\n");
 		return -ENODEV;
 	}
-#endif /* CONFIG_X86_PC9800 */
+
 	/* Next check for all ISA bus boards by sending the ID sequence to the
 	   ID_PORT.  We find cards past the first by setting the 'current_tag'
 	   on cards as they are found.  Cards with their tag set will not
@@ -487,7 +480,7 @@
 		phys_addr[i] = htons(id_read_eeprom(i));
 	}
 
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 	if (nopnp == 0) {
 		/* The ISA PnP 3c509 cards respond to the ID sequence.
 		   This check is needed in order not to register them twice. */
@@ -512,19 +505,9 @@
 	{
 		unsigned int iobase = id_read_eeprom(8);
 		if_port = iobase >> 14;
-#ifdef CONFIG_X86_PC9800
-		ioaddr = 0x40d0 + ((iobase & 0x1f) << 8);
-#else
 		ioaddr = 0x200 + ((iobase & 0x1f) << 4);
-#endif
 	}
 	irq = id_read_eeprom(9) >> 12;
-#ifdef CONFIG_X86_PC9800
-	if (irq == 7)
-		irq = 6;
-	else if (irq == 15)
-		irq = 13;
-#endif
 
 	dev = alloc_etherdev(sizeof (struct el3_private));
 	if (!dev)
@@ -555,11 +538,7 @@
 	outb(0xd0 + ++current_tag, id_port);
 
 	/* Activate the adaptor at the EEPROM location. */
-#ifdef CONFIG_X86_PC9800
-	outb((ioaddr >> 8) | 0xe0, id_port);
-#else
 	outb((ioaddr >> 4) | 0xe0, id_port);
-#endif
 
 	EL3WINDOW(0);
 	if (inw(ioaddr) != 0x6d50)
@@ -568,7 +547,7 @@
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
 
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
  found:							/* PNP jumps here... */
 #endif /* __ISAPNP__ */
 
@@ -577,7 +556,7 @@
 	dev->irq = irq;
 	dev->if_port = if_port;
 	lp = netdev_priv(dev);
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 	lp->dev = &idev->dev;
 #endif
 	err = el3_common_init(dev);
@@ -601,7 +580,7 @@
 	return 0;
 
 out1:
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 	if (idev)
 		pnp_device_detach(idev);
 #endif
@@ -1461,12 +1440,6 @@
 	outw(0x0001, ioaddr + 4);
 
 	/* Set the IRQ line. */
-#ifdef CONFIG_X86_PC9800
-	if (dev->irq == 6)
-		dev->irq = 7;
-	else if (dev->irq == 13)
-		dev->irq = 15;
-#endif
 	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
 
 	/* Set the station address in window 2 each time opened. */
@@ -1629,7 +1602,7 @@
 MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
 MODULE_PARM_DESC(xcvr,"transceiver(s) (0=internal, 1=external)");
 MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt");
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
+#if defined(__ISAPNP__)
 MODULE_PARM(nopnp, "i");
 MODULE_PARM_DESC(nopnp, "disable ISA PnP support (0-1)");
 MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
--- linux-2.6.6-mm3-full/drivers/net/at1700.c.old	2004-05-16 20:57:37.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/net/at1700.c	2004-05-16 20:59:28.000000000 +0200
@@ -80,17 +80,10 @@
  *	ISA
  */
 
-#ifndef CONFIG_X86_PC9800
 static unsigned at1700_probe_list[] __initdata = {
 	0x260, 0x280, 0x2a0, 0x240, 0x340, 0x320, 0x380, 0x300, 0
 };
 
-#else /* CONFIG_X86_PC9800 */
-static unsigned at1700_probe_list[] __initdata = {
-	0x1d6, 0x1d8, 0x1da, 0x1d4, 0xd4, 0xd2, 0xd8, 0xd0, 0
-};
-
-#endif /* CONFIG_X86_PC9800 */
 /*
  *	MCA
  */
@@ -133,7 +126,6 @@
 
 
 /* Offsets from the base address. */
-#ifndef CONFIG_X86_PC9800
 #define STATUS			0
 #define TX_STATUS		0
 #define RX_STATUS		1
@@ -161,34 +153,6 @@
 #define RESET			31		/* Write to reset some parts of the chip. */
 #define AT1700_IO_EXTENT	32
 #define PORT_OFFSET(o) (o)
-#else /* CONFIG_X86_PC9800 */
-#define STATUS			(0x0000)
-#define TX_STATUS		(0x0000)
-#define RX_STATUS		(0x0001)
-#define TX_INTR			(0x0200)/* Bit-mapped interrupt enable registers. */
-#define RX_INTR			(0x0201)
-#define TX_MODE			(0x0400)
-#define RX_MODE			(0x0401)
-#define CONFIG_0		(0x0600)/* Misc. configuration settings. */
-#define CONFIG_1		(0x0601)
-/* Run-time register bank 2 definitions. */
-#define DATAPORT		(0x0800)/* Word-wide DMA or programmed-I/O dataport. */
-#define TX_START		(0x0a00)
-#define COL16CNTL		(0x0a01)/* Controll Reg for 16 collisions */
-#define MODE13			(0x0c01)
-#define RX_CTRL			(0x0e00)
-/* Configuration registers only on the '865A/B chips. */
-#define EEPROM_Ctrl 	(0x1000)
-#define EEPROM_Data 	(0x1200)
-#define CARDSTATUS	16			/* FMV-18x Card Status */
-#define CARDSTATUS1	17			/* FMV-18x Card Status */
-#define IOCONFIG		(0x1400)/* Either read the jumper, or move the I/O. */
-#define IOCONFIG1		(0x1600)
-#define	SAPROM			20		/* The station address PROM, if no EEPROM. */
-#define	MODE24			(0x1800)/* The station address PROM, if no EEPROM. */
-#define RESET			(0x1e01)/* Write to reset some parts of the chip. */
-#define PORT_OFFSET(o) ({ int _o_ = (o); (_o_ & ~1) * 0x100 + (_o_ & 1); })
-#endif /* CONFIG_X86_PC9800 */
 
 
 #define TX_TIMEOUT		10
@@ -230,11 +194,7 @@
    (detachable devices only).
    */
 
-#ifndef CONFIG_X86_PC9800
 static int io = 0x260;
-#else
-static int io = 0xd0;
-#endif
 
 static int irq;
 
@@ -246,15 +206,7 @@
 		mca_mark_as_unused(lp->mca_slot);
 #endif	
 	free_irq(dev->irq, NULL);
-#ifndef CONFIG_X86_PC9800
 	release_region(dev->base_addr, AT1700_IO_EXTENT);
-#else
-	{
-		int i;
-		for (i = 0; i < 0x2000; i += 0x200)
-			release_region(dev->base_addr + i, 2);
-	}
-#endif
 }
 
 struct net_device * __init at1700_probe(int unit)
@@ -321,20 +273,8 @@
 	int slot, ret = -ENODEV;
 	struct net_local *lp = netdev_priv(dev);
 
-#ifndef CONFIG_X86_PC9800
 	if (!request_region(ioaddr, AT1700_IO_EXTENT, dev->name))
 		return -EBUSY;
-#else
-	for (i = 0; i < 0x2000; i += 0x0200) {
-		if (!request_region(ioaddr + i, 2, dev->name)) {
-			while (i > 0) {
-				i -= 0x0200;
-				release_region(ioaddr + i, 2);
-			}
-			return -EBUSY;
-		}
-	}
-#endif
 
 	/* Resetting the chip doesn't reset the ISA interface, so don't bother.
 	   That means we have to be careful with the register values we probe
@@ -425,15 +365,8 @@
 	outb(0, ioaddr + RESET);
 
 	if (is_at1700) {
-#ifndef CONFIG_X86_PC9800
 		irq = at1700_irqmap[(read_eeprom(ioaddr, 12)&0x04)
 						   | (read_eeprom(ioaddr, 0)>>14)];
-#else
-		{
-			char re1000plus_irqmap[4] = {3, 5, 6, 12};
-			irq = re1000plus_irqmap[inb(ioaddr + IOCONFIG1) >> 6];
-		}
-#endif
 	} else {
 		/* Check PnP mode for FMV-183/184/183A/184A. */
 		/* This PnP routine is very poor. IO and IRQ should be known. */
@@ -517,11 +450,7 @@
 	/* Switch to bank 2 */
 	/* Lock our I/O address, and set manual processing mode for 16 collisions. */
 	outb(0x08, ioaddr + CONFIG_1);
-#ifndef CONFIG_X86_PC9800
 	outb(dev->if_port, ioaddr + MODE13);
-#else
-	outb(0, ioaddr + MODE13);
-#endif
 	outb(0x00, ioaddr + COL16CNTL);
 
 	if (net_debug)
@@ -552,12 +481,7 @@
 	return 0;
 
 err_out:
-#ifndef CONFIG_X86_PC9800
 	release_region(ioaddr, AT1700_IO_EXTENT);
-#else
-	for (i = 0; i < 0x2000; i += 0x0200)
-		release_region(ioaddr + i, 2);
-#endif
 	return ret;
 }
 
@@ -568,13 +492,6 @@
 #define EE_DATA_WRITE	0x80	/* EEPROM chip data in, in reg. 17. */
 #define EE_DATA_READ	0x80	/* EEPROM chip data out, in reg. 17. */
 
-/* Delay between EEPROM clock transitions. */
-#ifndef CONFIG_X86_PC9800
-#define eeprom_delay()	do { } while (0)
-#else
-#define eeprom_delay()	__asm__ ("out%B0 %%al,%0" :: "N"(0x5f))
-#endif
-
 /* The EEPROM commands include the alway-set leading bit. */
 #define EE_WRITE_CMD	(5 << 6)
 #define EE_READ_CMD		(6 << 6)
@@ -593,22 +510,17 @@
 		short dataval = (read_cmd & (1 << i)) ? EE_DATA_WRITE : 0;
 		outb(EE_CS, ee_addr);
 		outb(dataval, ee_daddr);
-		eeprom_delay();
 		outb(EE_CS | EE_SHIFT_CLK, ee_addr);	/* EEPROM clock tick. */
-		eeprom_delay();
 	}
 	outb(EE_DATA_WRITE, ee_daddr);
 	for (i = 16; i > 0; i--) {
 		outb(EE_CS, ee_addr);
-		eeprom_delay();
 		outb(EE_CS | EE_SHIFT_CLK, ee_addr);
-		eeprom_delay();
 		retval = (retval << 1) | ((inb(ee_daddr) & EE_DATA_READ) ? 1 : 0);
 	}
 
 	/* Terminate the EEPROM access. */
 	outb(EE_CS, ee_addr);
-	eeprom_delay();
 	outb(EE_SHIFT_CLK, ee_addr);
 	outb(0, ee_addr);
 	return retval;
--- linux-2.6.6-mm3-full/drivers/serial/8250_pnp.c.old	2004-05-16 21:00:34.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/serial/8250_pnp.c	2004-05-16 21:00:48.000000000 +0200
@@ -361,9 +361,6 @@
 			    ((port->min == 0x2f8) ||
 			     (port->min == 0x3f8) ||
 			     (port->min == 0x2e8) ||
-#ifdef CONFIG_X86_PC9800
-			     (port->min == 0x8b0) ||
-#endif
 			     (port->min == 0x3e8)))
 				return 1;
 	}
--- linux-2.6.6-mm3-full/drivers/pnp/isapnp/core.c.old	2004-05-16 21:01:18.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/pnp/isapnp/core.c	2004-05-16 21:01:29.000000000 +0200
@@ -68,13 +68,8 @@
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_X86_PC9800
-#define _PIDXR		0x259
-#define _PNPWRP		0xa59
-#else
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79
-#endif
 
 /* short tags */
 #define _STAG_PNPVERNO		0x01
--- linux-2.6.6-mm3-full/include/linux/serial_core.h.old	2004-05-16 21:02:32.000000000 +0200
+++ linux-2.6.6-mm3-full/include/linux/serial_core.h	2004-05-16 21:02:41.000000000 +0200
@@ -59,14 +59,6 @@
 /* NEC v850.  */
 #define PORT_V850E_UART	40
 
-/* NEC PC-9800 */
-#define PORT_8251_PC98	41
-#define PORT_19K_PC98	42
-#define PORT_FIFO_PC98	43
-#define PORT_VFAST_PC98	44
-#define PORT_PC9861	45
-#define PORT_PC9801_101	46
-
 /* DZ */
 #define PORT_DZ		47
 
--- linux-2.6.6-mm3-full/include/linux/ide.h.old	2004-05-16 21:03:29.000000000 +0200
+++ linux-2.6.6-mm3-full/include/linux/ide.h	2004-05-16 21:04:21.000000000 +0200
@@ -255,7 +255,7 @@
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
-		ide_pc9800,	ide_forced
+		ide_forced
 } hwif_chipset_t;
 
 /*
@@ -308,7 +308,7 @@
 /*
  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
  *
- * arm26, arm, h8300, m68k, m68knommu (broken) and i386-pc9800 (broken)
+ * arm26, arm, h8300, m68k and m68knommu (broken)
  * still have their own versions.
  */
 #if !defined(CONFIG_ARM) && !defined(CONFIG_H8300) && !defined(CONFIG_M68K)
--- linux-2.6.6-mm3-full/include/linux/serio.h.old	2004-05-16 21:04:58.000000000 +0200
+++ linux-2.6.6-mm3-full/include/linux/serio.h	2004-05-16 21:05:16.000000000 +0200
@@ -105,7 +105,6 @@
 #define SERIO_8042	0x01000000UL
 #define SERIO_RS232	0x02000000UL
 #define SERIO_HIL_MLC	0x03000000UL
-#define SERIO_PC9800	0x04000000UL
 #define SERIO_PS_PSTHRU	0x05000000UL
 #define SERIO_8042_XL	0x06000000UL
 
--- linux-2.6.6-mm3-full/include/asm-i386/ide.h.old	2004-05-16 21:06:58.000000000 +0200
+++ linux-2.6.6-mm3-full/include/asm-i386/ide.h	2004-05-16 21:07:22.000000000 +0200
@@ -26,9 +26,6 @@
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
-#ifdef CONFIG_X86_PC9800
-		case 0x640: return 9;
-#endif
 		case 0x1f0: return 14;
 		case 0x170: return 15;
 		case 0x1e8: return 11;
@@ -43,48 +40,17 @@
 static __inline__ unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
-#ifdef CONFIG_X86_PC9800
-		case 0:
-		case 1:	return 0x640;
-#else
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
 		case 2: return 0x1e8;
 		case 3: return 0x168;
 		case 4: return 0x1e0;
 		case 5: return 0x160;
-#endif
 		default:
 			return 0;
 	}
 }
 
-#ifdef CONFIG_X86_PC9800
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-	 unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	unsigned long increment = data_port == 0x640 ? 2 : 1;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += increment;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else if (data_port == 0x640) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = 0x74c;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-#endif
-
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
--- linux-2.6.6-mm3-full/include/asm-i386/timex.h.old	2004-05-16 21:08:10.000000000 +0200
+++ linux-2.6.6-mm3-full/include/asm-i386/timex.h	2004-05-16 21:08:26.000000000 +0200
@@ -9,15 +9,11 @@
 #include <linux/config.h>
 #include <asm/msr.h>
 
-#ifdef CONFIG_X86_PC9800
-   extern int CLOCK_TICK_RATE;
-#else
 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif
-#endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
--- linux-2.6.6-mm3-full/include/asm-i386/serial.h.old	2004-05-16 21:08:46.000000000 +0200
+++ linux-2.6.6-mm3-full/include/asm-i386/serial.h	2004-05-16 21:08:59.000000000 +0200
@@ -47,19 +47,12 @@
 
 #define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
-#ifndef CONFIG_X86_PC9800
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-#else
-#define STD_SERIAL_PORT_DEFNS			\
-	/* UART CLK   PORT IRQ     FLAGS        */			\
-	{ 0, BASE_BAUD, 0x30, 4, STD_COM_FLAGS },	/* ttyS0 */	\
-	{ 0, BASE_BAUD, 0x238, 5, STD_COM_FLAGS },	/* ttyS1 */
-#endif /* CONFIG_X86_PC9800 */
 
 
 #ifdef CONFIG_SERIAL_MANY_PORTS
--- linux-2.6.6-mm3-full/sound/drivers/mpu401/mpu401.c.old	2004-05-16 21:09:36.000000000 +0200
+++ linux-2.6.6-mm3-full/sound/drivers/mpu401/mpu401.c	2004-05-16 21:09:59.000000000 +0200
@@ -52,9 +52,6 @@
 #endif
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* MPU-401 port number */
 static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* MPU-401 IRQ */
-#ifdef CONFIG_X86_PC9800
-static int pc98ii[SNDRV_CARDS];				/* PC98-II dauther board */
-#endif
 static int boot_devs;
 
 module_param_array(index, int, boot_devs, 0444);
@@ -77,11 +74,6 @@
 module_param_array(irq, int, boot_devs, 0444);
 MODULE_PARM_DESC(irq, "IRQ # for MPU-401 device.");
 MODULE_PARM_SYNTAX(irq, SNDRV_IRQ_DESC);
-#ifdef CONFIG_X86_PC9800
-module_param_array(pc98ii, bool, boot_devs, 0444);
-MODULE_PARM_DESC(pc98ii, "Roland MPU-PC98II support.");
-MODULE_PARM_SYNTAX(pc98ii, SNDRV_BOOLEAN_FALSE_DESC);
-#endif
 
 #ifndef CONFIG_ACPI_BUS
 struct acpi_device;
@@ -188,9 +180,6 @@
 	}
 #endif
 	if (snd_mpu401_uart_new(card, 0,
-#ifdef CONFIG_X86_PC9800
-				pc98ii[dev] ? MPU401_HW_PC98II :
-#endif
 				MPU401_HW_MPU401,
 				port[dev], 0,
 				irq[dev], irq[dev] >= 0 ? SA_INTERRUPT : 0, NULL) < 0) {
--- linux-2.6.6-mm3-full/sound/core/seq/instr/Makefile.old	2004-05-16 21:15:58.000000000 +0200
+++ linux-2.6.6-mm3-full/sound/core/seq/instr/Makefile	2004-05-16 21:16:06.000000000 +0200
@@ -26,7 +26,6 @@
 obj-$(call sequencer,$(CONFIG_SND_AD1816A)) += snd-ainstr-fm.o
 obj-$(call sequencer,$(CONFIG_SND_CS4232)) += snd-ainstr-fm.o
 obj-$(call sequencer,$(CONFIG_SND_CS4236)) += snd-ainstr-fm.o
-obj-$(call sequencer,$(CONFIG_SND_PC98_CS4232)) += snd-ainstr-fm.o
 obj-$(call sequencer,$(CONFIG_SND_ES1688)) += snd-ainstr-fm.o
 obj-$(call sequencer,$(CONFIG_SND_GUSCLASSIC)) += snd-ainstr-iw.o snd-ainstr-gf1.o snd-ainstr-simple.o
 obj-$(call sequencer,$(CONFIG_SND_GUSMAX)) += snd-ainstr-iw.o snd-ainstr-gf1.o snd-ainstr-simple.o
--- linux-2.6.6-mm3-full/sound/core/seq/Makefile.old	2004-05-16 21:16:37.000000000 +0200
+++ linux-2.6.6-mm3-full/sound/core/seq/Makefile	2004-05-16 21:16:54.000000000 +0200
@@ -51,7 +51,6 @@
 obj-$(call sequencer,$(CONFIG_SND_CS4231)) += $(RAWMIDI_OBJS)
 obj-$(call sequencer,$(CONFIG_SND_CS4232)) += $(RAWMIDI_OBJS) $(OPL3_OBJS)
 obj-$(call sequencer,$(CONFIG_SND_CS4236)) += $(RAWMIDI_OBJS) $(OPL3_OBJS)
-obj-$(call sequencer,$(CONFIG_SND_PC98_CS4232)) += $(RAWMIDI_OBJS) $(OPL3_OBJS)
 obj-$(call sequencer,$(CONFIG_SND_ES1688)) += $(RAWMIDI_OBJS) $(OPL3_OBJS)
 obj-$(call sequencer,$(CONFIG_SND_GUSCLASSIC)) += $(RAWMIDI_OBJS) $(OPL3_OBJS)
 obj-$(call sequencer,$(CONFIG_SND_GUSMAX)) += $(RAWMIDI_OBJS) $(OPL3_OBJS)
--- linux-2.6.6-mm3-full/sound/drivers/opl3/opl3_lib.c.old	2004-05-16 21:17:16.000000000 +0200
+++ linux-2.6.6-mm3-full/sound/drivers/opl3/opl3_lib.c	2004-05-16 21:17:42.000000000 +0200
@@ -416,26 +416,6 @@
 	case OPL3_HW_OPL3_FM801:
 		opl3->command = &snd_opl3_command;
 		break;
-	case OPL3_HW_OPL3_PC98:
-		opl3->command = &snd_opl3_command;
-
-		/* Initialize? */
-		opl3->command(opl3, OPL3_RIGHT | 0x05, 0x05);
-		opl3->command(opl3, OPL3_RIGHT | 0x08, 0x04);
-		opl3->command(opl3, OPL3_RIGHT | 0x08, 0x00);
-		opl3->command(opl3, OPL3_LEFT | 0xf7, 0x00);
-		opl3->command(opl3, OPL3_LEFT | 0x04, 0x60);
-		opl3->command(opl3, OPL3_LEFT | 0x04, 0x80);
-		inb(opl3->l_port);
-		
-		opl3->command(opl3, OPL3_LEFT | 0x02, 0xff);
-		opl3->command(opl3, OPL3_LEFT | 0x04, 0x21);
-		inb(opl3->l_port);
-		
-		opl3->command(opl3, OPL3_LEFT | 0x04, 0x60);
-		opl3->command(opl3, OPL3_LEFT | 0x04, 0x80);
-
-		break;
 	case OPL3_HW_OPL3_CS4281:
 		opl3->command = &snd_opl3_cs4281_command;
 		break;
--- linux-2.6.6-mm3-full/drivers/ide/ide-proc.c.old	2004-05-16 21:19:18.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/ide/ide-proc.c	2004-05-16 21:19:26.000000000 +0200
@@ -352,7 +352,6 @@
 		case ide_cy82c693:	name = "cy82c693";	break;
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
-		case ide_pc9800:	name = "pc9800";	break;
 		default:		name = "(unknown)";	break;
 	}
 	len = sprintf(page, "%s\n", name);
--- linux-2.6.6-mm3-full/include/asm-i386/processor.h.old	2004-05-16 21:06:16.000000000 +0200
+++ linux-2.6.6-mm3-full/include/asm-i386/processor.h	2004-05-16 21:24:19.000000000 +0200
@@ -259,14 +259,8 @@
 
 /*
  * Bus types (default is ISA, but people can check others with these..)
- * pc98 indicates PC98 systems (CBUS)
  */
 extern int MCA_bus;
-#ifdef CONFIG_X86_PC9800
-#define pc98 1
-#else
-#define pc98 0
-#endif
 
 static inline void __monitor(const void *eax, unsigned long ecx,
 		unsigned long edx)
--- linux-2.6.6-mm3-full/drivers/net/Space.c.old	2004-05-16 21:10:30.000000000 +0200
+++ linux-2.6.6-mm3-full/drivers/net/Space.c	2004-05-16 21:52:37.000000000 +0200
@@ -191,8 +191,8 @@
 #ifdef CONFIG_E2100		/* Cabletron E21xx series. */
 	{e2100_probe, 0},
 #endif
-#if defined(CONFIG_NE2000) || defined(CONFIG_NE2K_CBUS)	|| \
-    defined(CONFIG_NE_H8300)  /* ISA & PC-9800 CBUS (use ne2k-pci for PCI cards) */
+#if defined(CONFIG_NE2000) || \
+    defined(CONFIG_NE_H8300)  /* ISA (use ne2k-pci for PCI cards) */
 	{ne_probe, 0},
 #endif
 #ifdef CONFIG_LANCE		/* ISA/VLB (use pcnet32 for PCI cards) */
