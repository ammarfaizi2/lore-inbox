Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUGPJ3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUGPJ3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUGPJ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:29:34 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:40701 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266502AbUGPJ3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:29:01 -0400
Date: Fri, 16 Jul 2004 02:28:59 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: jgarkzik@pobox.om
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Add IXDP2x01 board support to CS89x0 driver
Message-ID: <20040716092859.GA16849@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff,

The following patch modifies the CS89x0 driver to work on Intel's IXDP2401 
and IXDP2801 (Intel ARm/XScale based) platforms: 

- The main change requried is that the IXDP2x01 boards have the 
  chip connected through a CPLD so all registers appear at  
  dword-aligned addresses. A macro in the header adjusts the register
  offsets appropriately.
  
- The boards do not have ISA, so we need to explicitly check for 
  IXDP2X01 in Kconfig.

- There is what I believe is a bug in the driver as it currently 
  only asks for the signature if ioaddr & 1 is set but then
  reads and checks against the expected signature even when
  !(ioaddr & 1). This causes the driver to not load on the IXDP2x01
  since our ioaddr does not have bit 1 set.

- #ifdef out some bits of code that assume the chip is really
  sitting on an ISA bus.

The main IXDP2x01 support will be coming in through rmk's tree at
a later date when all the drivers are merged upstream.

Tnx,
~Deepak

===== drivers/net/Kconfig 1.79 vs edited =====
--- 1.79/drivers/net/Kconfig	Fri Jun 18 09:43:06 2004
+++ edited/drivers/net/Kconfig	Mon Jul 12 12:14:59 2004
@@ -1335,7 +1335,7 @@
 
 config CS89x0
 	tristate "CS89x0 support"
-	depends on NET_PCI && ISA
+	depends on NET_PCI && (ISA || ARCH_IXDP2X01)
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards. If you have a
 	  network (Ethernet) card of this type, say Y and read the
===== drivers/net/cs89x0.c 1.24 vs edited =====
--- 1.24/drivers/net/cs89x0.c	Sat May 22 10:40:55 2004
+++ edited/drivers/net/cs89x0.c	Fri Jul 16 02:02:25 2004
@@ -84,6 +84,9 @@
   Oskar Schirmer    : oskar@scara.com
                     : HiCO.SH4 (superh) support added (irq#1, cs89x0_media=)
 
+  Deepak Saxena     : dsaxena@plexity.net
+                    : Intel IXDP2x01 (XScale ixp2x00 NPU) platform support
+
 */
 
 /* Always include 'config.h' first in case the user wants to turn on
@@ -97,7 +100,11 @@
  * Note that even if DMA is turned off we still support the 'dma' and  'use_dma'
  * module options so we don't break any startup scripts.
  */
+#ifndef CONFIG_ARCH_IXDP2X01
+#define ALLOW_DMA	0
+#else
 #define ALLOW_DMA	1
+#endif
 
 /*
  * Set this to zero to remove all the debug statements via
@@ -162,6 +169,10 @@
 static unsigned int netcard_portlist[] __initdata =
    { 0x0300, 0};
 static unsigned int cs8900_irq_map[] = {1,0,0,0};
+#elif defined(CONFIG_ARCH_IXDP2X01)
+#include <asm/irq.h>
+static unsigned int netcard_portlist[] __initdata = {IXDP2X01_CS8900_VIRT_BASE, 0};
+static unsigned int cs8900_irq_map[] = {IRQ_IXDP2X01_CS8900, 0, 0, 0};
 #else
 static unsigned int netcard_portlist[] __initdata =
    { 0x300, 0x320, 0x340, 0x360, 0x200, 0x220, 0x240, 0x260, 0x280, 0x2a0, 0x2c0, 0x2e0, 0};
@@ -454,11 +465,12 @@
 		        	retval = -ENODEV;
 				goto out2;
 			}
-		ioaddr &= ~3;
-		outw(PP_ChipID, ioaddr + ADD_PORT);
 	}
 printk("PP_addr=0x%x\n", inw(ioaddr + ADD_PORT));
 
+	ioaddr &= ~3;
+	outw(PP_ChipID, ioaddr + ADD_PORT);
+
 	if (inw(ioaddr + DATA_PORT) != CHIP_EISA_ID_SIG) {
 		printk(KERN_ERR "%s: incorrect signature 0x%x\n",
 			dev->name, inw(ioaddr + DATA_PORT));
@@ -665,6 +677,9 @@
 	} else {
 		i = lp->isa_config & INT_NO_MASK;
 		if (lp->chip_type == CS8900) {
+#ifdef CONFIG_ARCH_IXDP2X01
+		        i = cs8900_irq_map[0];
+#else
 			/* Translate the IRQ using the IRQ mapping table. */
 			if (i >= sizeof(cs8900_irq_map)/sizeof(cs8900_irq_map[0]))
 				printk("\ncs89x0: invalid ISA interrupt number %d\n", i);
@@ -681,6 +696,7 @@
 				if ((irq_map_buff[0] & 0xff) == PNP_IRQ_FRMT)
 					lp->irq_map = (irq_map_buff[0]>>8) | (irq_map_buff[1] << 8);
 			}
+#endif
 		}
 		if (!dev->irq)
 			dev->irq = i;
@@ -884,8 +900,10 @@
 
 void  __init reset_chip(struct net_device *dev)
 {
+#ifndef CONFIG_ARCH_IXDP2X01
 	struct net_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
+#endif
 	int reset_start_time;
 
 	writereg(dev, PP_SelfCTL, readreg(dev, PP_SelfCTL) | POWER_ON_RESET);
@@ -894,6 +912,7 @@
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(30*HZ/1000);
 
+#ifndef CONFIG_ARCH_IXDP2X01
 	if (lp->chip_type != CS8900) {
 		/* Hardware problem requires PNP registers to be reconfigured after a reset */
 		outw(PP_CS8920_ISAINT, ioaddr + ADD_PORT);
@@ -904,6 +923,8 @@
 		outb((dev->mem_start >> 16) & 0xff, ioaddr + DATA_PORT);
 		outb((dev->mem_start >> 8) & 0xff,   ioaddr + DATA_PORT + 1);
 	}
+#endif	/* IXDP2x01 */
+
 	/* Wait until the chip is reset */
 	reset_start_time = jiffies;
 	while( (readreg(dev, PP_SelfST) & INIT_DONE) == 0 && jiffies - reset_start_time < 2)
@@ -1155,12 +1176,14 @@
 	else
 #endif
 	{
+#ifndef CONFIG_ARCH_IXDP2X01
 		if (((1 << dev->irq) & lp->irq_map) == 0) {
 			printk(KERN_ERR "%s: IRQ %d is not in our map of allowable IRQs, which is %x\n",
                                dev->name, dev->irq, lp->irq_map);
 			ret = -EAGAIN;
 			goto bad_out;
 		}
+#endif
 /* FIXME: Cirrus' release had this: */
 		writereg(dev, PP_BusCTL, readreg(dev, PP_BusCTL)|ENABLE_IRQ );
 /* And 2.3.47 had this: */
===== drivers/net/cs89x0.h 1.3 vs edited =====
--- 1.3/drivers/net/cs89x0.h	Mon Mar 17 15:42:26 2003
+++ edited/drivers/net/cs89x0.h	Fri Jul 16 02:02:48 2004
@@ -16,6 +16,13 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_ARCH_IXDP2X01
+/* IXDP2401/IXDP2801 uses dword-aligned register addressing */ 
+#define CS89x0_PORT(reg) ((reg) * 2)
+#else
+#define CS89x0_PORT(reg) (reg)
+#endif
+
 #define PP_ChipID 0x0000	/* offset   0h -> Corp -ID              */
 				/* offset   2h -> Model/Product Number  */
 				/* offset   3h -> Chip Revision Number  */
@@ -324,16 +331,16 @@
 #define RAM_SIZE	0x1000       /*  The card has 4k bytes or RAM */
 #define PKT_START PP_TxFrame  /*  Start of packet RAM */
 
-#define RX_FRAME_PORT	0x0000
+#define RX_FRAME_PORT	CS89x0_PORT(0x0000)
 #define TX_FRAME_PORT RX_FRAME_PORT
-#define TX_CMD_PORT	0x0004
+#define TX_CMD_PORT	CS89x0_PORT(0x0004)
 #define TX_NOW		0x0000       /*  Tx packet after   5 bytes copied */
 #define TX_AFTER_381	0x0040       /*  Tx packet after 381 bytes copied */
 #define TX_AFTER_ALL	0x00c0       /*  Tx packet after all bytes copied */
-#define TX_LEN_PORT	0x0006
-#define ISQ_PORT	0x0008
-#define ADD_PORT	0x000A
-#define DATA_PORT	0x000C
+#define TX_LEN_PORT	CS89x0_PORT(0x0006)
+#define ISQ_PORT	CS89x0_PORT(0x0008)
+#define ADD_PORT	CS89x0_PORT(0x000A)
+#define DATA_PORT	CS89x0_PORT(0x000C)
 
 #define EEPROM_WRITE_EN		0x00F0
 #define EEPROM_WRITE_DIS	0x0000

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
