Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbUKKNRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUKKNRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 08:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUKKNQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 08:16:34 -0500
Received: from mail.renesas.com ([202.234.163.13]:22961 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262234AbUKKNM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 08:12:58 -0500
Date: Thu, 11 Nov 2004 22:12:44 +0900 (JST)
Message-Id: <20041111.221244.115904688.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org, gniibe@fsij.org
Subject: [PATCH 2.6.10-rc1 2/2] [m32r] CF boot support for Mappi2
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041111.221136.576022723.takata.hirokazu@renesas.com>
References: <20041111.221136.576022723.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc1 2/2] [m32r] CF boot support for Mappi2
- Update io_mappi2.c to access a CF device as an IDE disk device
  for Mappi2 eva board.
- Please set CONFIG_M32R_CFC=n, when you use m32r-g00ff for CF boot.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_m32700ut.c  |    6 +-
 arch/m32r/kernel/io_mappi2.c    |  109 +++++++++++++++++++++++++++++++++-------
 arch/m32r/kernel/setup_mappi2.c |    2 
 include/asm-m32r/ide.h          |    2 
 4 files changed, 97 insertions(+), 22 deletions(-)


diff -ruNp a/arch/m32r/kernel/io_m32700ut.c b/arch/m32r/kernel/io_m32700ut.c
--- a/arch/m32r/kernel/io_m32700ut.c	2004-10-19 06:54:37.000000000 +0900
+++ b/arch/m32r/kernel/io_m32700ut.c	2004-11-10 21:55:52.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/m32r/kernel/io_mappi.c
+ *  linux/arch/m32r/kernel/io_m32700ut.c
  *
  *  Typical I/O routines for M32700UT board.
  *
@@ -32,8 +32,8 @@ extern void pcc_iowrite_byte(int, unsign
 extern void pcc_iowrite_word(int, unsigned long, void *, size_t, size_t, int);
 #endif /* CONFIG_PCMCIA && CONFIG_M32R_CFC */
 
-#define PORT2ADDR(port)  _port2addr(port)
-#define PORT2ADDR_USB(port) _port2addr_usb(port)
+#define PORT2ADDR(port)	     _port2addr(port)
+#define PORT2ADDR_USB(port)  _port2addr_usb(port)
 
 static __inline__ void *_port2addr(unsigned long port)
 {
diff -ruNp a/arch/m32r/kernel/io_mappi2.c b/arch/m32r/kernel/io_mappi2.c
--- a/arch/m32r/kernel/io_mappi2.c	2004-10-19 06:55:28.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi2.c	2004-11-11 19:09:26.000000000 +0900
@@ -13,6 +13,7 @@
 #include <asm/m32r.h>
 #include <asm/page.h>
 #include <asm/io.h>
+#include <asm/byteorder.h>
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 #include <linux/types.h>
@@ -39,6 +40,27 @@ static __inline__ void *_port2addr(unsig
 
 #define LAN_IOSTART	0x300
 #define LAN_IOEND	0x320
+
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+static __inline__ void *__port2addr_ata(unsigned long port)
+{
+	static int	dummy_reg;
+
+	switch (port) {
+	case 0x1f0:	return (void *)0xac002000;
+	case 0x1f1:	return (void *)0xac012800;
+	case 0x1f2:	return (void *)0xac012002;
+	case 0x1f3:	return (void *)0xac012802;
+	case 0x1f4:	return (void *)0xac012004;
+	case 0x1f5:	return (void *)0xac012804;
+	case 0x1f6:	return (void *)0xac012006;
+	case 0x1f7:	return (void *)0xac012806;
+	case 0x3f6:	return (void *)0xac01200e;
+	default: 	return (void *)&dummy_reg;
+	}
+}
+#endif
+
 #ifdef CONFIG_CHIP_OPSP
 static __inline__ void *_port2addr_ne(unsigned long port)
 {
@@ -70,22 +92,13 @@ static __inline__ unsigned char _ne_inb(
 
 static __inline__ unsigned short _ne_inw(void *portp)
 {
-#if 1  /* byte swap */
-	unsigned short tmp,tmp2;
-	tmp = *(volatile unsigned short *)portp;
-	tmp2 = (tmp>>8|tmp<<8);
-	return tmp2;
-#else
-	return *(volatile unsigned short *)portp;
-#endif
+	return (unsigned short)le16_to_cpu(*(volatile unsigned short *)portp);
 }
 
 static __inline__ void _ne_insb(void *portp, void * addr, unsigned long count)
 {
-	unsigned short tmp;
 	unsigned char *buf = addr;
 
-	tmp = *(volatile unsigned char *)portp;
 	while (count--) *buf++ = *(volatile unsigned char *)portp;
 }
 
@@ -96,13 +109,18 @@ static __inline__ void _ne_outb(unsigned
 
 static __inline__ void _ne_outw(unsigned short w, void *portp)
 {
-	*(volatile unsigned short *)portp = (w>>8|w<<8);
+	*(volatile unsigned short *)portp = cpu_to_le16(w);
 }
 
 unsigned char _inb(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inb(PORT2ADDR_NE(port));
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned char *)__port2addr_ata(port);
+	}
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned char b;
@@ -118,8 +136,13 @@ unsigned short _inw(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inw(PORT2ADDR_NE(port));
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned short *)__port2addr_ata(port);
+	}
+#endif
 #if defined(CONFIG_USB)
-        else if (port >= 0x340 && port < 0x3a0)
+	else if (port >= 0x340 && port < 0x3a0)
 	  return *(volatile unsigned short *)PORT2ADDR_USB(port);
 #endif
 
@@ -149,9 +172,14 @@ unsigned char _inb_p(unsigned long port)
 {
 	unsigned char  v;
 
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		v = _ne_inb(PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned char *)__port2addr_ata(port);
+	} else
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned char b;
@@ -169,9 +197,14 @@ unsigned short _inw_p(unsigned long port
 {
 	unsigned short  v;
 
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		v = _ne_inw(PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned short *)__port2addr_ata(port);
+	} else
+#endif
 #if defined(CONFIG_USB)
 	  if (port >= 0x340 && port < 0x3a0)
 		v = *(volatile unsigned short *)PORT2ADDR_USB(port);
@@ -204,6 +237,11 @@ void _outb(unsigned char b, unsigned lon
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned char *)__port2addr_ata(port) = b;
+	} else
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
@@ -217,6 +255,11 @@ void _outw(unsigned short w, unsigned lo
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned short *)__port2addr_ata(port) = w;
+	} else
+#endif
 #if defined(CONFIG_USB)
 	  if (port >= 0x340 && port < 0x3a0)
 	    *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
@@ -245,6 +288,11 @@ void _outb_p(unsigned char b, unsigned l
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned char *)__port2addr_ata(port) = b;
+	} else
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
@@ -260,6 +308,11 @@ void _outw_p(unsigned short w, unsigned 
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned short *)__port2addr_ata(port) = w;
+	} else
+#endif
 #if defined(CONFIG_USB)
 	  if (port >= 0x340 && port < 0x3a0)
 		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
@@ -285,6 +338,13 @@ void _insb(unsigned int port, void * add
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		unsigned char *buf = addr;
+		unsigned char *portp = __port2addr_ata(port);
+		while(count--) *buf++ = *(volatile unsigned char *)portp;
+	}
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
@@ -302,13 +362,18 @@ void _insw(unsigned int port, void * add
 	unsigned short *buf = addr;
 	unsigned short *portp;
 
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) *buf++ = *(volatile unsigned short *)portp;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
 #endif
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while (count--) *buf++ = *(volatile unsigned short *)portp;
+#endif
 	} else {
 		portp = PORT2ADDR(port);
 		while (count--) *buf++ = *(volatile unsigned short *)portp;
@@ -329,9 +394,14 @@ void _outsb(unsigned int port, const voi
 	const unsigned char *buf = addr;
 	unsigned char *portp;
 
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) _ne_outb(*buf++, portp);
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while(count--) *(volatile unsigned char *)portp = *buf++;
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
@@ -347,9 +417,14 @@ void _outsw(unsigned int port, const voi
 	const unsigned short *buf = addr;
 	unsigned short *portp;
 
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) *(volatile unsigned short *)portp = *buf++;
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while(count--) *(volatile unsigned short *)portp = *buf++;
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
diff -ruNp a/arch/m32r/kernel/setup_mappi2.c b/arch/m32r/kernel/setup_mappi2.c
--- a/arch/m32r/kernel/setup_mappi2.c	2004-10-19 06:53:50.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi2.c	2004-11-08 15:00:54.000000000 +0900
@@ -151,7 +151,6 @@ void __init init_IRQ(void)
 	disable_mappi2_irq(M32R_IRQ_INT1);
 #endif /* CONFIG_USB */
 
-#if defined(CONFIG_M32R_CFC)
 	/* ICUCR40: CFC IREQ */
 	irq_desc[PLD_IRQ_CFIREQ].status = IRQ_DISABLED;
 	irq_desc[PLD_IRQ_CFIREQ].handler = &mappi2_irq_type;
@@ -161,6 +160,7 @@ void __init init_IRQ(void)
 	icu_data[PLD_IRQ_CFIREQ].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD01;
 	disable_mappi2_irq(PLD_IRQ_CFIREQ);
 
+#if defined(CONFIG_M32R_CFC)
 	/* ICUCR41: CFC Insert */
 	irq_desc[PLD_IRQ_CFC_INSERT].status = IRQ_DISABLED;
 	irq_desc[PLD_IRQ_CFC_INSERT].handler = &mappi2_irq_type;
diff -ruNp a/include/asm-m32r/ide.h b/include/asm-m32r/ide.h
--- a/include/asm-m32r/ide.h	2004-10-19 06:54:30.000000000 +0900
+++ b/include/asm-m32r/ide.h	2004-11-11 10:32:41.000000000 +0900
@@ -35,7 +35,7 @@
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
-#if defined(CONFIG_PLAT_M32700UT)
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_MAPPI2)
 		case 0x1f0: return PLD_IRQ_CFIREQ;
 		default:
 			return 0;

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

