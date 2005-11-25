Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVKYNkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVKYNkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKYNkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:40:11 -0500
Received: from mail.renesas.com ([202.234.163.13]:50675 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751416AbVKYNkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:40:09 -0500
Date: Fri, 25 Nov 2005 22:40:05 +0900 (JST)
Message-Id: <20051125.224005.278737224.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sakugawa@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc2-mm1] m32r: M3A-2170(Mappi-III) IDE support
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for supporting IDE interface for M3A-2170(Mappi-III) board.
Please apply.

Thanks,

Signed-off-by: Mamoru Sakugawa <sakugawa@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_mappi3.c         |   54 +++++++++++++++++++++++------------
 arch/m32r/kernel/setup_mappi3.c      |   20 +++++++-----
 drivers/pcmcia/m32r_cfc.c            |    3 +
 include/asm-m32r/ide.h               |   13 +++++---
 include/asm-m32r/mappi3/mappi3_pld.h |    2 -
 5 files changed, 59 insertions(+), 33 deletions(-)

Index: linux-2.6.14/arch/m32r/kernel/io_mappi3.c
===================================================================
--- linux-2.6.14.orig/arch/m32r/kernel/io_mappi3.c	2005-11-03 19:26:33.725102280 +0900
+++ linux-2.6.14/arch/m32r/kernel/io_mappi3.c	2005-11-03 20:08:34.679858904 +0900
@@ -36,12 +36,13 @@ static inline void *_port2addr(unsigned 
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+#if defined(CONFIG_IDE)
 static inline void *__port2addr_ata(unsigned long port)
 {
 	static int	dummy_reg;
 
 	switch (port) {
+	  /* IDE0 CF */
 	case 0x1f0:	return (void *)0xb4002000;
 	case 0x1f1:	return (void *)0xb4012800;
 	case 0x1f2:	return (void *)0xb4012002;
@@ -51,6 +52,17 @@ static inline void *__port2addr_ata(unsi
 	case 0x1f6:	return (void *)0xb4012006;
 	case 0x1f7:	return (void *)0xb4012806;
 	case 0x3f6:	return (void *)0xb401200e;
+	  /* IDE1 IDE */
+	case 0x170:	return (void *)0xb4810000;  /* Data 16bit */
+	case 0x171:	return (void *)0xb4810002;  /* Features / Error */
+	case 0x172:	return (void *)0xb4810004;  /* Sector count */
+	case 0x173:	return (void *)0xb4810006;  /* Sector number */
+	case 0x174:	return (void *)0xb4810008;  /* Cylinder low */
+	case 0x175:	return (void *)0xb481000a;  /* Cylinder high */
+	case 0x176:	return (void *)0xb481000c;  /* Device head */
+	case 0x177:	return (void *)0xb481000e;  /* Command     */
+	case 0x376:	return (void *)0xb480800c;  /* Device control / Alt status */
+
 	default: 	return (void *)&dummy_reg;
 	}
 }
@@ -108,8 +120,9 @@ unsigned char _inb(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inb(PORT2ADDR_NE(port));
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	else if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		return *(volatile unsigned char *)__port2addr_ata(port);
 	}
 #endif
@@ -127,8 +140,9 @@ unsigned short _inw(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inw(PORT2ADDR_NE(port));
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	else if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		return *(volatile unsigned short *)__port2addr_ata(port);
 	}
 #endif
@@ -185,8 +199,9 @@ void _outb(unsigned char b, unsigned lon
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		*(volatile unsigned char *)__port2addr_ata(port) = b;
 	} else
 #endif
@@ -203,8 +218,9 @@ void _outw(unsigned short w, unsigned lo
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		*(volatile unsigned short *)__port2addr_ata(port) = w;
 	} else
 #endif
@@ -253,8 +269,9 @@ void _insb(unsigned int port, void * add
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	else if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		unsigned char *buf = addr;
 		unsigned char *portp = __port2addr_ata(port);
 		while (count--)
@@ -289,8 +306,9 @@ void _insw(unsigned int port, void * add
 		pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short),
 				count, 1);
 #endif
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	} else if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		portp = __port2addr_ata(port);
 		while (count--)
 			*buf++ = *(volatile unsigned short *)portp;
@@ -321,8 +339,9 @@ void _outsb(unsigned int port, const voi
 		portp = PORT2ADDR_NE(port);
 		while (count--)
 			_ne_outb(*buf++, portp);
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	} else if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		portp = __port2addr_ata(port);
 		while (count--)
 			*(volatile unsigned char *)portp = *buf++;
@@ -348,8 +367,9 @@ void _outsw(unsigned int port, const voi
 		portp = PORT2ADDR_NE(port);
 		while (count--)
 			*(volatile unsigned short *)portp = *buf++;
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+#if defined(CONFIG_IDE)
+	} else if ( ((port >= 0x170 && port <=0x177) || port == 0x376) ||
+		  ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) ){
 		portp = __port2addr_ata(port);
 		while (count--)
 			*(volatile unsigned short *)portp = *buf++;
Index: linux-2.6.14/arch/m32r/kernel/setup_mappi3.c
===================================================================
--- linux-2.6.14.orig/arch/m32r/kernel/setup_mappi3.c	2005-11-03 19:23:10.147050848 +0900
+++ linux-2.6.14/arch/m32r/kernel/setup_mappi3.c	2005-11-03 20:08:34.687857688 +0900
@@ -151,7 +151,7 @@ void __init init_IRQ(void)
 	disable_mappi3_irq(M32R_IRQ_INT1);
 #endif /* CONFIG_USB */
 
-	/* ICUCR40: CFC IREQ */
+	/* CFC IREQ */
 	irq_desc[PLD_IRQ_CFIREQ].status = IRQ_DISABLED;
 	irq_desc[PLD_IRQ_CFIREQ].handler = &mappi3_irq_type;
 	irq_desc[PLD_IRQ_CFIREQ].action = 0;
@@ -160,7 +160,7 @@ void __init init_IRQ(void)
 	disable_mappi3_irq(PLD_IRQ_CFIREQ);
 
 #if defined(CONFIG_M32R_CFC)
-	/* ICUCR41: CFC Insert */
+	/* ICUCR41: CFC Insert & eject */
 	irq_desc[PLD_IRQ_CFC_INSERT].status = IRQ_DISABLED;
 	irq_desc[PLD_IRQ_CFC_INSERT].handler = &mappi3_irq_type;
 	irq_desc[PLD_IRQ_CFC_INSERT].action = 0;
@@ -168,14 +168,16 @@ void __init init_IRQ(void)
 	icu_data[PLD_IRQ_CFC_INSERT].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD00;
 	disable_mappi3_irq(PLD_IRQ_CFC_INSERT);
 
-	/* ICUCR42: CFC Eject */
-	irq_desc[PLD_IRQ_CFC_EJECT].status = IRQ_DISABLED;
-	irq_desc[PLD_IRQ_CFC_EJECT].handler = &mappi3_irq_type;
-	irq_desc[PLD_IRQ_CFC_EJECT].action = 0;
-	irq_desc[PLD_IRQ_CFC_EJECT].depth = 1;	/* disable nested irq */
-	icu_data[PLD_IRQ_CFC_EJECT].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
-	disable_mappi3_irq(PLD_IRQ_CFC_EJECT);
 #endif /* CONFIG_M32R_CFC */
+
+	/* IDE IREQ */
+	irq_desc[PLD_IRQ_IDEIREQ].status = IRQ_DISABLED;
+	irq_desc[PLD_IRQ_IDEIREQ].handler = &mappi3_irq_type;
+	irq_desc[PLD_IRQ_IDEIREQ].action = 0;
+	irq_desc[PLD_IRQ_IDEIREQ].depth = 1;	/* disable nested irq */
+	icu_data[PLD_IRQ_IDEIREQ].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
+	disable_mappi3_irq(PLD_IRQ_IDEIREQ);
+
 }
 
 #if defined(CONFIG_SMC91X)
Index: linux-2.6.14/drivers/pcmcia/m32r_cfc.c
===================================================================
--- linux-2.6.14.orig/drivers/pcmcia/m32r_cfc.c	2005-11-03 19:23:10.160048872 +0900
+++ linux-2.6.14/drivers/pcmcia/m32r_cfc.c	2005-11-03 20:08:34.700855712 +0900
@@ -355,9 +355,10 @@ static void add_pcc_socket(ulong base, i
 #ifndef CONFIG_PLAT_USRV
 	/* insert interrupt */
 	request_irq(irq, pcc_interrupt, 0, "m32r_cfc", pcc_interrupt);
+#ifndef CONFIG_PLAT_MAPPI3
 	/* eject interrupt */
 	request_irq(irq+1, pcc_interrupt, 0, "m32r_cfc", pcc_interrupt);
-
+#endif
 	debug(3, "m32r_cfc: enable CFMSK, RDYSEL\n");
 	pcc_set(pcc_sockets, (unsigned int)PLD_CFIMASK, 0x01);
 #endif	/* CONFIG_PLAT_USRV */
Index: linux-2.6.14/include/asm-m32r/ide.h
===================================================================
--- linux-2.6.14.orig/include/asm-m32r/ide.h	2005-11-03 19:23:10.172047048 +0900
+++ linux-2.6.14/include/asm-m32r/ide.h	2005-11-03 20:08:34.709854344 +0900
@@ -25,18 +25,21 @@
 # endif
 #endif
 
-#if defined(CONFIG_PLAT_M32700UT)
-#include <asm/irq.h>
-#include <asm/m32700ut/m32700ut_pld.h>
-#endif
+#include <asm/m32r.h>
+
 
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_MAPPI2) || defined(CONFIG_PLAT_MAPPI3)
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_MAPPI2)
+		case 0x1f0: return PLD_IRQ_CFIREQ;
+		default:
+			return 0;
+#elif defined(CONFIG_PLAT_MAPPI3)
 		case 0x1f0: return PLD_IRQ_CFIREQ;
+		case 0x170: return PLD_IRQ_IDEIREQ;
 		default:
 			return 0;
 #else
Index: linux-2.6.14/include/asm-m32r/mappi3/mappi3_pld.h
===================================================================
--- linux-2.6.14.orig/include/asm-m32r/mappi3/mappi3_pld.h	2005-11-03 19:23:10.187044768 +0900
+++ linux-2.6.14/include/asm-m32r/mappi3/mappi3_pld.h	2005-11-03 20:08:34.717853128 +0900
@@ -59,7 +59,7 @@
 #define  M32R_IRQ_I2C          (28)  /* I2C-BUS     */
 #define  PLD_IRQ_CFIREQ       (6)  /* INT5 CFC Card Interrupt */
 #define  PLD_IRQ_CFC_INSERT   (7)  /* INT6 CFC Card Insert */
-#define  PLD_IRQ_CFC_EJECT    (8)  /* INT7 CFC Card Eject */
+#define  PLD_IRQ_IDEIREQ      (8)  /* INT7 IDE Interrupt   */
 #define  PLD_IRQ_MMCCARD      (43)  /* MMC Card Insert */
 #define  PLD_IRQ_MMCIRQ       (44)  /* MMC Transfer Done */
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
