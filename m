Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVEaMzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVEaMzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVEaMzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:55:33 -0400
Received: from mail.renesas.com ([202.234.163.13]:60666 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261318AbVEaMsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:48:12 -0400
Date: Tue, 31 May 2005 21:48:05 +0900 (JST)
Message-Id: <20050531.214805.783383719.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sakugawa@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

This patchset is for supporting a new m32r platform,
M3A-2170(Mappi-III) evaluation board.
An M32R chip multiprocessor is equipped on the board.
http://http://www.linux-m32r.org/eng/platform/platform.html

	* arch/m32r/Kconfig: Support Mappi-III platform.
	* arch/m32r/kernel/Makefile: ditto.
	* arch/m32r/kernel/io_mappi3.c: ditto.
	* arch/m32r/kernel/setup.c: ditto.
	* arch/m32r/kernel/setup_mappi3.c: ditto.
	* include/asm-m32r/m32102.h: ditto.
	* include/asm-m32r/m32r.h: ditto.
	* include/asm-m32r/mappi3/mappi3_pld.h: ditto.

	* include/asm-m32r/ide.h: CF support for Mappi-III.
	* arch/m32r/kernel/setup_mappi3.c: ditto.

	* arch/m32r/mappi3/defconfig.smp: A default config file for Mappi-III.
	* arch/m32r/mappi3/dot.gdbinit: A default .gdbinit file for Mappi-III.

	* arch/m32r/boot/compressed/m32r_sio.c: Modified for Mappi-III
	  - At boot time, m32r-g00ff bootloader makes MMU off for Mappi-III,
	    on the contrary it makes MMU on for Mappi-II.

	* arch/m32r/kernel/io_mappi2.c: Update comments.
	* arch/m32r/kernel/setup_mappi2.c: ditto.

Please apply.
Thanks,

Signed-off-by: Mamoru Sakugawa <sakugawa@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Kconfig                    |    7 
 arch/m32r/boot/compressed/m32r_sio.c |    6 
 arch/m32r/kernel/Makefile            |    2 
 arch/m32r/kernel/io_mappi2.c         |    2 
 arch/m32r/kernel/io_mappi3.c         |  454 +++++++++++++++++++++
 arch/m32r/kernel/setup.c             |    2 
 arch/m32r/kernel/setup_mappi2.c      |    6 
 arch/m32r/kernel/setup_mappi3.c      |  208 +++++++++
 arch/m32r/mappi3/defconfig.smp       |  751 +++++++++++++++++++++++++++++++++++
 arch/m32r/mappi3/dot.gdbinit         |  224 ++++++++++
 include/asm-m32r/ide.h               |    2 
 include/asm-m32r/m32102.h            |    1 
 include/asm-m32r/m32r.h              |    4 
 include/asm-m32r/mappi3/mappi3_pld.h |  143 ++++++
 14 files changed, 1799 insertions(+), 13 deletions(-)


diff -ruNp a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
diff -ruNp a/arch/m32r/Kconfig b/arch/m32r/Kconfig
--- a/arch/m32r/Kconfig	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/Kconfig	2005-05-26 20:14:55.000000000 +0900
@@ -78,6 +78,9 @@ config PLAT_OAKS32R
 config PLAT_MAPPI2
        bool "Mappi-II(M3A-ZA36/M3A-ZA52)"
 
+config PLAT_MAPPI3
+       bool "Mappi-III(M3A-2170)"
+
 endchoice
 
 choice
@@ -134,6 +137,7 @@ config BUS_CLOCK
 	int "Bus Clock [Hz] (integer)"
 	default "70000000" if PLAT_MAPPI
 	default "25000000" if PLAT_USRV
+	default "50000000" if PLAT_MAPPI3
 	default "50000000" if PLAT_M32700UT
 	default "50000000" if PLAT_OPSPUT
 	default "33333333" if PLAT_OAKS32R
@@ -149,7 +153,7 @@ config CPU_LITTLE_ENDIAN
 
 config MEMORY_START
 	hex "Physical memory start address (hex)"
-	default "08000000" if PLAT_MAPPI || PLAT_MAPPI2
+	default "08000000" if PLAT_MAPPI || PLAT_MAPPI2 || PLAT_MAPPI3
 	default "08000000" if PLAT_USRV
 	default "08000000" if PLAT_M32700UT
 	default "08000000" if PLAT_OPSPUT
@@ -157,6 +161,7 @@ config MEMORY_START
 
 config MEMORY_SIZE
 	hex "Physical memory size (hex)"
+	default "08000000" if PLAT_MAPPI3
 	default "04000000" if PLAT_MAPPI || PLAT_MAPPI2
 	default "02000000" if PLAT_USRV
 	default "01000000" if PLAT_M32700UT
diff -ruNp a/arch/m32r/boot/compressed/m32r_sio.c b/arch/m32r/boot/compressed/m32r_sio.c
--- a/arch/m32r/boot/compressed/m32r_sio.c	2005-05-26 18:53:29.000000000 +0900
+++ b/arch/m32r/boot/compressed/m32r_sio.c	2005-05-31 17:16:34.000000000 +0900
@@ -38,7 +38,6 @@ static int puts(const char *s)
 
 static void putc(char c)
 {
-
 	while ((*BOOT_SIO0STS & 0x3) != 0x3) ;
 	if (c == '\n') {
 		*BOOT_SIO0TXB = '\r';
@@ -46,8 +45,8 @@ static void putc(char c)
 	}
 	*BOOT_SIO0TXB = c;
 }
-#else /* defined(CONFIG_PLAT_M32700UT_Alpha) || defined(CONFIG_PLAT_M32700UT) */
-#ifdef CONFIG_MMU
+#else /* !(CONFIG_PLAT_M32700UT_Alpha) && !(CONFIG_PLAT_M32700UT) */
+#if defined(CONFIG_PLAT_MAPPI2)
 #define SIO0STS	(volatile unsigned short *)(0xa0efd000 + 14)
 #define SIO0TXB	(volatile unsigned short *)(0xa0efd000 + 30)
 #else
@@ -57,7 +56,6 @@ static void putc(char c)
 
 static void putc(char c)
 {
-
 	while ((*SIO0STS & 0x1) == 0) ;
 	if (c == '\n') {
 		*SIO0TXB = '\r';
diff -ruNp a/arch/m32r/kernel/Makefile b/arch/m32r/kernel/Makefile
--- a/arch/m32r/kernel/Makefile	2004-12-25 06:34:31.000000000 +0900
+++ b/arch/m32r/kernel/Makefile	2005-05-31 16:58:58.000000000 +0900
@@ -10,6 +10,7 @@ obj-y	:= process.o entry.o traps.o align
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_PLAT_MAPPI)	+= setup_mappi.o io_mappi.o
 obj-$(CONFIG_PLAT_MAPPI2)	+= setup_mappi2.o io_mappi2.o
+obj-$(CONFIG_PLAT_MAPPI3)	+= setup_mappi3.o io_mappi3.o
 obj-$(CONFIG_PLAT_USRV)		+= setup_usrv.o io_usrv.o
 obj-$(CONFIG_PLAT_M32700UT)	+= setup_m32700ut.o io_m32700ut.o
 obj-$(CONFIG_PLAT_OPSPUT)	+= setup_opsput.o io_opsput.o
@@ -17,4 +18,3 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_PLAT_OAKS32R)	+= setup_oaks32r.o io_oaks32r.o
 
 EXTRA_AFLAGS	:= -traditional
-
diff -ruNp a/arch/m32r/kernel/io_mappi2.c b/arch/m32r/kernel/io_mappi2.c
--- a/arch/m32r/kernel/io_mappi2.c	2004-12-25 06:35:39.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi2.c	2005-05-26 20:14:55.000000000 +0900
@@ -25,7 +25,7 @@ extern void pcc_ioread_byte(int, unsigne
 extern void pcc_ioread_word(int, unsigned long, void *, size_t, size_t, int);
 extern void pcc_iowrite_byte(int, unsigned long, void *, size_t, size_t, int);
 extern void pcc_iowrite_word(int, unsigned long, void *, size_t, size_t, int);
-#endif /* CONFIG_PCMCIA && CONFIG_MAPPI2_CFC */
+#endif /* CONFIG_PCMCIA && CONFIG_M32R_CFC */
 
 #define PORT2ADDR(port)      _port2addr(port)
 #define PORT2ADDR_NE(port)   _port2addr_ne(port)
diff -ruNp a/arch/m32r/kernel/io_mappi3.c b/arch/m32r/kernel/io_mappi3.c
--- a/arch/m32r/kernel/io_mappi3.c	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi3.c	2005-05-31 17:19:56.000000000 +0900
@@ -0,0 +1,454 @@
+/*
+ *  linux/arch/m32r/kernel/io_mappi3.c
+ *
+ *  Typical I/O routines for Mappi3 board.
+ *
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
+ *                           Hitoshi Yamamoto, Mamoru Sakugawa
+ */
+
+#include <linux/config.h>
+#include <asm/m32r.h>
+#include <asm/page.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+#include <linux/types.h>
+
+#define M32R_PCC_IOMAP_SIZE 0x1000
+
+#define M32R_PCC_IOSTART0 0x1000
+#define M32R_PCC_IOEND0   (M32R_PCC_IOSTART0 + M32R_PCC_IOMAP_SIZE - 1)
+
+extern void pcc_ioread_byte(int, unsigned long, void *, size_t, size_t, int);
+extern void pcc_ioread_word(int, unsigned long, void *, size_t, size_t, int);
+extern void pcc_iowrite_byte(int, unsigned long, void *, size_t, size_t, int);
+extern void pcc_iowrite_word(int, unsigned long, void *, size_t, size_t, int);
+#endif /* CONFIG_PCMCIA && CONFIG_M32R_CFC */
+
+#define PORT2ADDR(port)      _port2addr(port)
+#define PORT2ADDR_NE(port)   _port2addr_ne(port)
+#define PORT2ADDR_USB(port)  _port2addr_usb(port)
+
+static inline void *_port2addr(unsigned long port)
+{
+	return (void *)(port + NONCACHE_OFFSET);
+}
+
+#define LAN_IOSTART	0x300
+#define LAN_IOEND	0x320
+
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+static inline void *__port2addr_ata(unsigned long port)
+{
+	static int	dummy_reg;
+
+	switch (port) {
+	case 0x1f0:	return (void *)0xb4002000;
+	case 0x1f1:	return (void *)0xb4012800;
+	case 0x1f2:	return (void *)0xb4012002;
+	case 0x1f3:	return (void *)0xb4012802;
+	case 0x1f4:	return (void *)0xb4012004;
+	case 0x1f5:	return (void *)0xb4012804;
+	case 0x1f6:	return (void *)0xb4012006;
+	case 0x1f7:	return (void *)0xb4012806;
+	case 0x3f6:	return (void *)0xb401200e;
+	default: 	return (void *)&dummy_reg;
+	}
+}
+#endif
+
+static inline void *_port2addr_ne(unsigned long port)
+{
+	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
+}
+
+static inline void *_port2addr_usb(unsigned long port)
+{
+	return (void *)(port + NONCACHE_OFFSET + 0x12000000);
+}
+static inline void delay(void)
+{
+	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
+}
+
+/*
+ * NIC I/O function
+ */
+
+static inline unsigned char _ne_inb(void *portp)
+{
+	return (unsigned char) *(volatile unsigned char *)portp;
+}
+
+static inline unsigned short _ne_inw(void *portp)
+{
+	return (unsigned short)le16_to_cpu(*(volatile unsigned short *)portp);
+}
+
+static inline void _ne_insb(void *portp, void * addr, unsigned long count)
+{
+	unsigned char *buf = addr;
+
+	while (count--)
+		*buf++ = *(volatile unsigned char *)portp;
+}
+
+static inline void _ne_outb(unsigned char b, void *portp)
+{
+	*(volatile unsigned char *)portp = (unsigned char)b;
+}
+
+static inline void _ne_outw(unsigned short w, void *portp)
+{
+	*(volatile unsigned short *)portp = cpu_to_le16(w);
+}
+
+unsigned char _inb(unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		return _ne_inb(PORT2ADDR_NE(port));
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned char *)__port2addr_ata(port);
+	}
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
+	} else
+#endif
+	return *(volatile unsigned char *)PORT2ADDR(port);
+}
+
+unsigned short _inw(unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		return _ne_inw(PORT2ADDR_NE(port));
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned short *)__port2addr_ata(port);
+	}
+#endif
+#if defined(CONFIG_USB)
+	else if (port >= 0x340 && port < 0x3a0)
+		return *(volatile unsigned short *)PORT2ADDR_USB(port);
+#endif
+
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
+	} else
+#endif
+	return *(volatile unsigned short *)PORT2ADDR(port);
+}
+
+unsigned long _inl(unsigned long port)
+{
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned long l;
+		pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
+		return l;
+	} else
+#endif
+	return *(volatile unsigned long *)PORT2ADDR(port);
+}
+
+unsigned char _inb_p(unsigned long port)
+{
+	unsigned char  v;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		v = _ne_inb(PORT2ADDR_NE(port));
+	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned char *)__port2addr_ata(port);
+	} else
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
+	} else
+#endif
+		v = *(volatile unsigned char *)PORT2ADDR(port);
+
+	delay();
+	return (v);
+}
+
+unsigned short _inw_p(unsigned long port)
+{
+	unsigned short  v;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		v = _ne_inw(PORT2ADDR_NE(port));
+	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned short *)__port2addr_ata(port);
+	} else
+#endif
+#if defined(CONFIG_USB)
+	if (port >= 0x340 && port < 0x3a0)
+		v = *(volatile unsigned short *)PORT2ADDR_USB(port);
+	else
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
+	} else
+#endif
+		v = *(volatile unsigned short *)PORT2ADDR(port);
+
+	delay();
+	return (v);
+}
+
+unsigned long _inl_p(unsigned long port)
+{
+	unsigned long  v;
+
+	v = *(volatile unsigned long *)PORT2ADDR(port);
+	delay();
+	return (v);
+}
+
+void _outb(unsigned char b, unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_outb(b, PORT2ADDR_NE(port));
+	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned char *)__port2addr_ata(port) = b;
+	} else
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+	} else
+#endif
+		*(volatile unsigned char *)PORT2ADDR(port) = b;
+}
+
+void _outw(unsigned short w, unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_outw(w, PORT2ADDR_NE(port));
+	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned short *)__port2addr_ata(port) = w;
+	} else
+#endif
+#if defined(CONFIG_USB)
+	if (port >= 0x340 && port < 0x3a0)
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+	else
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+	} else
+#endif
+		*(volatile unsigned short *)PORT2ADDR(port) = w;
+}
+
+void _outl(unsigned long l, unsigned long port)
+{
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
+	} else
+#endif
+	*(volatile unsigned long *)PORT2ADDR(port) = l;
+}
+
+void _outb_p(unsigned char b, unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_outb(b, PORT2ADDR_NE(port));
+	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned char *)__port2addr_ata(port) = b;
+	} else
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+	} else
+#endif
+		*(volatile unsigned char *)PORT2ADDR(port) = b;
+
+	delay();
+}
+
+void _outw_p(unsigned short w, unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_outw(w, PORT2ADDR_NE(port));
+	else
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned short *)__port2addr_ata(port) = w;
+	} else
+#endif
+#if defined(CONFIG_USB)
+	  if (port >= 0x340 && port < 0x3a0)
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+	else
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+	} else
+#endif
+		*(volatile unsigned short *)PORT2ADDR(port) = w;
+
+	delay();
+}
+
+void _outl_p(unsigned long l, unsigned long port)
+{
+	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	delay();
+}
+
+void _insb(unsigned int port, void * addr, unsigned long count)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_insb(PORT2ADDR_NE(port), addr, count);
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		unsigned char *buf = addr;
+		unsigned char *portp = __port2addr_ata(port);
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
+	}
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char),
+				count, 1);
+	}
+#endif
+	else {
+		unsigned char *buf = addr;
+		unsigned char *portp = PORT2ADDR(port);
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
+	}
+}
+
+void _insw(unsigned int port, void * addr, unsigned long count)
+{
+	unsigned short *buf = addr;
+	unsigned short *portp;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
+		portp = PORT2ADDR_NE(port);
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short),
+				count, 1);
+#endif
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
+#endif
+	} else {
+		portp = PORT2ADDR(port);
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
+	}
+}
+
+void _insl(unsigned int port, void * addr, unsigned long count)
+{
+	unsigned long *buf = addr;
+	unsigned long *portp;
+
+	portp = PORT2ADDR(port);
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
+}
+
+void _outsb(unsigned int port, const void * addr, unsigned long count)
+{
+	const unsigned char *buf = addr;
+	unsigned char *portp;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
+		portp = PORT2ADDR_NE(port);
+		while (count--)
+			_ne_outb(*buf++, portp);
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char),
+				 count, 1);
+#endif
+	} else {
+		portp = PORT2ADDR(port);
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
+	}
+}
+
+void _outsw(unsigned int port, const void * addr, unsigned long count)
+{
+	const unsigned short *buf = addr;
+	unsigned short *portp;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
+		portp = PORT2ADDR_NE(port);
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
+#endif
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
+	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short),
+				 count, 1);
+#endif
+	} else {
+		portp = PORT2ADDR(port);
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
+	}
+}
+
+void _outsl(unsigned int port, const void * addr, unsigned long count)
+{
+	const unsigned long *buf = addr;
+	unsigned char *portp;
+
+	portp = PORT2ADDR(port);
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
+}
diff -ruNp a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
--- a/arch/m32r/kernel/setup.c	2005-05-26 18:53:29.000000000 +0900
+++ b/arch/m32r/kernel/setup.c	2005-05-26 20:14:55.000000000 +0900
@@ -330,6 +330,8 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "Machine\t\t: Mappi Evaluation board\n");
 #elif CONFIG_PLAT_MAPPI2
 	seq_printf(m, "Machine\t\t: Mappi-II Evaluation board\n");
+#elif CONFIG_PLAT_MAPPI3
+	seq_printf(m, "Machine\t\t: Mappi-III Evaluation board\n");
 #elif  CONFIG_PLAT_M32700UT
 	seq_printf(m, "Machine\t\t: M32700UT Evaluation board\n");
 #elif  CONFIG_PLAT_OPSPUT
diff -ruNp a/arch/m32r/kernel/setup_mappi2.c b/arch/m32r/kernel/setup_mappi2.c
--- a/arch/m32r/kernel/setup_mappi2.c	2004-12-25 06:35:50.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi2.c	2005-05-31 16:58:02.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/m32r/kernel/setup_mappi.c
+ *  linux/arch/m32r/kernel/setup_mappi2.c
  *
  *  Setup routines for Renesas MAPPI-II(M3A-ZA36) Board
  *
@@ -156,7 +156,6 @@ void __init init_IRQ(void)
 	irq_desc[PLD_IRQ_CFIREQ].handler = &mappi2_irq_type;
 	irq_desc[PLD_IRQ_CFIREQ].action = 0;
 	irq_desc[PLD_IRQ_CFIREQ].depth = 1;	/* disable nested irq */
-//	icu_data[PLD_IRQ_CFIREQ].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD00;
 	icu_data[PLD_IRQ_CFIREQ].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD01;
 	disable_mappi2_irq(PLD_IRQ_CFIREQ);
 
@@ -167,7 +166,6 @@ void __init init_IRQ(void)
 	irq_desc[PLD_IRQ_CFC_INSERT].action = 0;
 	irq_desc[PLD_IRQ_CFC_INSERT].depth = 1;	/* disable nested irq */
 	icu_data[PLD_IRQ_CFC_INSERT].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD00;
-//	icu_data[PLD_IRQ_CFC_INSERT].icucr = 0;
 	disable_mappi2_irq(PLD_IRQ_CFC_INSERT);
 
 	/* ICUCR42: CFC Eject */
@@ -176,9 +174,7 @@ void __init init_IRQ(void)
 	irq_desc[PLD_IRQ_CFC_EJECT].action = 0;
 	irq_desc[PLD_IRQ_CFC_EJECT].depth = 1;	/* disable nested irq */
 	icu_data[PLD_IRQ_CFC_EJECT].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
-//	icu_data[PLD_IRQ_CFC_EJECT].icucr = 0;
 	disable_mappi2_irq(PLD_IRQ_CFC_EJECT);
-
 #endif /* CONFIG_MAPPI2_CFC */
 }
 
diff -ruNp a/arch/m32r/kernel/setup_mappi3.c b/arch/m32r/kernel/setup_mappi3.c
--- a/arch/m32r/kernel/setup_mappi3.c	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi3.c	2005-05-31 16:57:05.000000000 +0900
@@ -0,0 +1,208 @@
+/*
+ *  linux/arch/m32r/kernel/setup_mappi3.c
+ *
+ *  Setup routines for Renesas MAPPI-III(M3A-2170) Board
+ *
+ *  Copyright (c) 2001-2005   Hiroyuki Kondo, Hirokazu Takata,
+ *                            Hitoshi Yamamoto, Mamoru Sakugawa
+ */
+
+#include <linux/config.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+#include <asm/system.h>
+#include <asm/m32r.h>
+#include <asm/io.h>
+
+#define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
+
+#ifndef CONFIG_SMP
+typedef struct {
+	unsigned long icucr;  /* ICU Control Register */
+} icu_data_t;
+#endif /* CONFIG_SMP */
+
+icu_data_t icu_data[NR_IRQS];
+
+static void disable_mappi3_irq(unsigned int irq)
+{
+	unsigned long port, data;
+
+	if ((irq == 0) ||(irq >= NR_IRQS))  {
+		printk("bad irq 0x%08x\n", irq);
+		return;
+	}
+	port = irq2port(irq);
+	data = icu_data[irq].icucr|M32R_ICUCR_ILEVEL7;
+	outl(data, port);
+}
+
+static void enable_mappi3_irq(unsigned int irq)
+{
+	unsigned long port, data;
+
+	if ((irq == 0) ||(irq >= NR_IRQS))  {
+		printk("bad irq 0x%08x\n", irq);
+		return;
+	}
+	port = irq2port(irq);
+	data = icu_data[irq].icucr|M32R_ICUCR_IEN|M32R_ICUCR_ILEVEL6;
+	outl(data, port);
+}
+
+static void mask_and_ack_mappi3(unsigned int irq)
+{
+	disable_mappi3_irq(irq);
+}
+
+static void end_mappi3_irq(unsigned int irq)
+{
+	enable_mappi3_irq(irq);
+}
+
+static unsigned int startup_mappi3_irq(unsigned int irq)
+{
+	enable_mappi3_irq(irq);
+	return (0);
+}
+
+static void shutdown_mappi3_irq(unsigned int irq)
+{
+	unsigned long port;
+
+	port = irq2port(irq);
+	outl(M32R_ICUCR_ILEVEL7, port);
+}
+
+static struct hw_interrupt_type mappi3_irq_type =
+{
+	"MAPPI3-IRQ",
+	startup_mappi3_irq,
+	shutdown_mappi3_irq,
+	enable_mappi3_irq,
+	disable_mappi3_irq,
+	mask_and_ack_mappi3,
+	end_mappi3_irq
+};
+
+void __init init_IRQ(void)
+{
+#if defined(CONFIG_SMC91X)
+	/* INT0 : LAN controller (SMC91111) */
+	irq_desc[M32R_IRQ_INT0].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_INT0].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_INT0].action = 0;
+	irq_desc[M32R_IRQ_INT0].depth = 1;
+	icu_data[M32R_IRQ_INT0].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
+	disable_mappi3_irq(M32R_IRQ_INT0);
+#endif  /* CONFIG_SMC91X */
+
+	/* MFT2 : system timer */
+	irq_desc[M32R_IRQ_MFT2].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_MFT2].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_MFT2].action = 0;
+	irq_desc[M32R_IRQ_MFT2].depth = 1;
+	icu_data[M32R_IRQ_MFT2].icucr = M32R_ICUCR_IEN;
+	disable_mappi3_irq(M32R_IRQ_MFT2);
+
+#ifdef CONFIG_SERIAL_M32R_SIO
+	/* SIO0_R : uart receive data */
+	irq_desc[M32R_IRQ_SIO0_R].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_SIO0_R].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_SIO0_R].action = 0;
+	irq_desc[M32R_IRQ_SIO0_R].depth = 1;
+	icu_data[M32R_IRQ_SIO0_R].icucr = 0;
+	disable_mappi3_irq(M32R_IRQ_SIO0_R);
+
+	/* SIO0_S : uart send data */
+	irq_desc[M32R_IRQ_SIO0_S].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_SIO0_S].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_SIO0_S].action = 0;
+	irq_desc[M32R_IRQ_SIO0_S].depth = 1;
+	icu_data[M32R_IRQ_SIO0_S].icucr = 0;
+	disable_mappi3_irq(M32R_IRQ_SIO0_S);
+	/* SIO1_R : uart receive data */
+	irq_desc[M32R_IRQ_SIO1_R].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_SIO1_R].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_SIO1_R].action = 0;
+	irq_desc[M32R_IRQ_SIO1_R].depth = 1;
+	icu_data[M32R_IRQ_SIO1_R].icucr = 0;
+	disable_mappi3_irq(M32R_IRQ_SIO1_R);
+
+	/* SIO1_S : uart send data */
+	irq_desc[M32R_IRQ_SIO1_S].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_SIO1_S].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_SIO1_S].action = 0;
+	irq_desc[M32R_IRQ_SIO1_S].depth = 1;
+	icu_data[M32R_IRQ_SIO1_S].icucr = 0;
+	disable_mappi3_irq(M32R_IRQ_SIO1_S);
+#endif  /* CONFIG_M32R_USE_DBG_CONSOLE */
+
+#if defined(CONFIG_USB)
+	/* INT1 : USB Host controller interrupt */
+	irq_desc[M32R_IRQ_INT1].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_INT1].handler = &mappi3_irq_type;
+	irq_desc[M32R_IRQ_INT1].action = 0;
+	irq_desc[M32R_IRQ_INT1].depth = 1;
+	icu_data[M32R_IRQ_INT1].icucr = M32R_ICUCR_ISMOD01;
+	disable_mappi3_irq(M32R_IRQ_INT1);
+#endif /* CONFIG_USB */
+
+	/* ICUCR40: CFC IREQ */
+	irq_desc[PLD_IRQ_CFIREQ].status = IRQ_DISABLED;
+	irq_desc[PLD_IRQ_CFIREQ].handler = &mappi3_irq_type;
+	irq_desc[PLD_IRQ_CFIREQ].action = 0;
+	irq_desc[PLD_IRQ_CFIREQ].depth = 1;	/* disable nested irq */
+	icu_data[PLD_IRQ_CFIREQ].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD01;
+	disable_mappi3_irq(PLD_IRQ_CFIREQ);
+
+#if defined(CONFIG_M32R_CFC)
+	/* ICUCR41: CFC Insert */
+	irq_desc[PLD_IRQ_CFC_INSERT].status = IRQ_DISABLED;
+	irq_desc[PLD_IRQ_CFC_INSERT].handler = &mappi3_irq_type;
+	irq_desc[PLD_IRQ_CFC_INSERT].action = 0;
+	irq_desc[PLD_IRQ_CFC_INSERT].depth = 1;	/* disable nested irq */
+	icu_data[PLD_IRQ_CFC_INSERT].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD00;
+	disable_mappi3_irq(PLD_IRQ_CFC_INSERT);
+
+	/* ICUCR42: CFC Eject */
+	irq_desc[PLD_IRQ_CFC_EJECT].status = IRQ_DISABLED;
+	irq_desc[PLD_IRQ_CFC_EJECT].handler = &mappi3_irq_type;
+	irq_desc[PLD_IRQ_CFC_EJECT].action = 0;
+	irq_desc[PLD_IRQ_CFC_EJECT].depth = 1;	/* disable nested irq */
+	icu_data[PLD_IRQ_CFC_EJECT].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
+	disable_mappi3_irq(PLD_IRQ_CFC_EJECT);
+#endif /* CONFIG_M32R_CFC */
+}
+
+#define LAN_IOSTART     0x300
+#define LAN_IOEND       0x320
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start  = (LAN_IOSTART),
+		.end    = (LAN_IOEND),
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = M32R_IRQ_INT0,
+		.end    = M32R_IRQ_INT0,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources  = ARRAY_SIZE(smc91x_resources),
+	.resource       = smc91x_resources,
+};
+
+static int __init platform_init(void)
+{
+	platform_device_register(&smc91x_device);
+	return 0;
+}
+arch_initcall(platform_init);
diff -ruNp a/arch/m32r/mappi3/defconfig.smp b/arch/m32r/mappi3/defconfig.smp
--- a/arch/m32r/mappi3/defconfig.smp	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/m32r/mappi3/defconfig.smp	2005-05-31 18:05:49.000000000 +0900
@@ -0,0 +1,751 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-rc5
+# Tue May 31 17:55:34 2005
+#
+CONFIG_M32R=y
+# CONFIG_UID16 is not set
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+# CONFIG_CLEAN_COMPILE is not set
+CONFIG_BROKEN=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_CPUSETS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_STOP_MACHINE=y
+
+#
+# Processor type and features
+#
+# CONFIG_PLAT_MAPPI is not set
+# CONFIG_PLAT_USRV is not set
+# CONFIG_PLAT_M32700UT is not set
+# CONFIG_PLAT_OPSPUT is not set
+# CONFIG_PLAT_OAKS32R is not set
+# CONFIG_PLAT_MAPPI2 is not set
+CONFIG_PLAT_MAPPI3=y
+CONFIG_CHIP_M32700=y
+# CONFIG_CHIP_M32102 is not set
+# CONFIG_CHIP_VDEC2 is not set
+# CONFIG_CHIP_OPSP is not set
+CONFIG_MMU=y
+CONFIG_TLB_ENTRIES=32
+CONFIG_ISA_M32R2=y
+CONFIG_ISA_DSP_LEVEL2=y
+CONFIG_ISA_DUAL_ISSUE=y
+CONFIG_BUS_CLOCK=10000000
+CONFIG_TIMER_DIVIDE=128
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_MEMORY_START=0x08000000
+CONFIG_MEMORY_SIZE=0x08000000
+CONFIG_NOHIGHMEM=y
+CONFIG_DISCONTIGMEM=y
+CONFIG_IRAM_START=0x00f00000
+CONFIG_IRAM_SIZE=0x00080000
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PREEMPT=y
+# CONFIG_HAVE_DEC_LOCK is not set
+CONFIG_SMP=y
+# CONFIG_CHIP_M32700_TS1 is not set
+CONFIG_NR_CPUS=2
+# CONFIG_NUMA is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+# CONFIG_PCI is not set
+# CONFIG_ISA is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
+# CONFIG_TCIC is not set
+# CONFIG_M32R_PCC is not set
+# CONFIG_M32R_CFC is not set
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
+# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
+# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=m
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMC91X=y
+# CONFIG_NE2000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_M32R_SIO=y
+CONFIG_SERIAL_M32R_SIO_CONSOLE=y
+# CONFIG_SERIAL_M32R_PLDSIO is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+# CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+CONFIG_DEVFS_MOUNT=y
+# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS_FS=y
+CONFIG_JFFS_FS_VERBOSE=0
+CONFIG_JFFS_PROC_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+# CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=15
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FRAME_POINTER is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
diff -ruNp a/arch/m32r/mappi3/dot.gdbinit b/arch/m32r/mappi3/dot.gdbinit
--- a/arch/m32r/mappi3/dot.gdbinit	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/m32r/mappi3/dot.gdbinit	2005-05-31 17:25:00.000000000 +0900
@@ -0,0 +1,224 @@
+# .gdbinit file
+# $Id: dot.gdbinit,v 1.1 2005/04/11 02:21:08 sakugawa Exp $
+
+# setting
+set width 0d70
+set radix 0d16
+use_debug_dma
+
+# Initialize SDRAM controller for Mappi
+define sdram_init
+  # SDIR0
+  set *(unsigned long *)0x00ef6008 = 0x00000182
+  # SDIR1
+  set *(unsigned long *)0x00ef600c = 0x00000001
+  # Initialize wait
+  shell sleep 0.1
+  # MOD
+  set *(unsigned long *)0x00ef602c = 0x00000020
+  set *(unsigned long *)0x00ef604c = 0x00000020
+  # TR
+  set *(unsigned long *)0x00ef6028 = 0x00051502
+  set *(unsigned long *)0x00ef6048 = 0x00051502
+  # ADR
+  set *(unsigned long *)0x00ef6020 = 0x08000004
+  set *(unsigned long *)0x00ef6040 = 0x0c000004
+  # AutoRef On
+  set *(unsigned long *)0x00ef6004 = 0x00010517
+  # Access enable
+  set *(unsigned long *)0x00ef6024 = 0x00000001
+  set *(unsigned long *)0x00ef6044 = 0x00000001
+end
+
+# Initialize LAN controller for Mappi
+define lanc_init
+  # Set BSEL4
+  #set *(unsigned long *)0x00ef5004 = 0x0fff330f
+  #set *(unsigned long *)0x00ef5004 = 0x01113301
+
+#  set *(unsigned long *)0x00ef5004 = 0x02011101
+#  set *(unsigned long *)0x00ef5004 = 0x04441104
+end
+
+define clock_init
+  set *(unsigned long *)0x00ef4010 = 2
+  set *(unsigned long *)0x00ef4014 = 2
+  set *(unsigned long *)0x00ef4020 = 3
+  set *(unsigned long *)0x00ef4024 = 3
+  set *(unsigned long *)0x00ef4004 = 0x7
+#  shell sleep 0.1
+#  set *(unsigned long *)0x00ef4004 = 0x5
+  shell sleep 0.1
+  set *(unsigned long *)0x00ef4008 = 0x0200
+end
+
+define port_init
+  set $sfrbase = 0x00ef0000
+  set *(unsigned short *)0x00ef1060 = 0x5555
+  set *(unsigned short *)0x00ef1062 = 0x5555
+  set *(unsigned short *)0x00ef1064 = 0x5555
+  set *(unsigned short *)0x00ef1066 = 0x5555
+  set *(unsigned short *)0x00ef1068 = 0x5555
+  set *(unsigned short *)0x00ef106a = 0x0000
+  set *(unsigned short *)0x00ef106e = 0x5555
+  set *(unsigned short *)0x00ef1070 = 0x5555
+end
+
+# MMU enable
+define mmu_enable
+  set $evb=0x88000000
+  set *(unsigned long *)0xffff0024=1
+end
+
+# MMU disable
+define mmu_disable
+  set $evb=0
+  set *(unsigned long *)0xffff0024=0
+end
+
+# Show TLB entries
+define show_tlb_entries
+  set $i = 0
+  set $addr = $arg0
+  while ($i < 0d16 )
+    set $tlb_tag = *(unsigned long*)$addr
+    set $tlb_data = *(unsigned long*)($addr + 4)
+    printf " [%2d] 0x%08lx : 0x%08lx - 0x%08lx\n", $i, $addr, $tlb_tag, $tlb_data
+    set $i = $i + 1
+    set $addr = $addr + 8
+  end
+end
+define itlb
+  set $itlb=0xfe000000
+  show_tlb_entries $itlb
+end
+define dtlb
+  set $dtlb=0xfe000800
+  show_tlb_entries $dtlb
+end
+
+# Cache ON
+define set_cache_type
+  set $mctype = (void*)0xfffffff8
+# chaos
+# set *(unsigned long *)($mctype) = 0x0000c000
+# m32102 i-cache only
+  set *(unsigned long *)($mctype) = 0x00008000
+# m32102 d-cache only
+#  set *(unsigned long *)($mctype) = 0x00004000
+end
+define cache_on
+  set $param = (void*)0x08001000
+  set *(unsigned long *)($param) = 0x60ff6102
+end
+
+
+# Show current task structure
+define show_current
+  set $current = $spi & 0xffffe000
+  printf "$current=0x%08lX\n",$current
+  print *(struct task_struct *)$current
+end
+
+# Show user assigned task structure
+define show_task
+  set $task = $arg0 & 0xffffe000
+  printf "$task=0x%08lX\n",$task
+  print *(struct task_struct *)$task
+end
+document show_task
+  Show user assigned task structure
+  arg0 : task structure address
+end
+
+# Show M32R registers
+define show_regs
+  printf " R0[0x%08lX]   R1[0x%08lX]   R2[0x%08lX]   R3[0x%08lX]\n",$r0,$r1,$r2,$r3
+  printf " R4[0x%08lX]   R5[0x%08lX]   R6[0x%08lX]   R7[0x%08lX]\n",$r4,$r5,$r6,$r7
+  printf " R8[0x%08lX]   R9[0x%08lX]  R10[0x%08lX]  R11[0x%08lX]\n",$r8,$r9,$r10,$r11
+  printf "R12[0x%08lX]   FP[0x%08lX]   LR[0x%08lX]   SP[0x%08lX]\n",$r12,$fp,$lr,$sp
+  printf "PSW[0x%08lX]  CBR[0x%08lX]  SPI[0x%08lX]  SPU[0x%08lX]\n",$psw,$cbr,$spi,$spu
+  printf "BPC[0x%08lX]   PC[0x%08lX] ACCL[0x%08lX] ACCH[0x%08lX]\n",$bpc,$pc,$accl,$acch
+  printf "EVB[0x%08lX]\n",$evb
+
+  set $mests = *(unsigned long *)0xffff000c
+  set $mdeva = *(unsigned long *)0xffff0010
+  printf "MESTS[0x%08lX] MDEVA[0x%08lX]\n",$mests,$mdeva
+end
+
+
+# Setup all
+define setup
+  clock_init
+  shell sleep 0.1
+  port_init
+  sdram_init
+#  lanc_init
+#  dispc_init
+#  set $evb=0x08000000
+end
+
+# Load modules
+define load_modules
+  use_debug_dma
+  load
+#  load busybox.mot
+end
+
+# Set kernel parameters
+define set_kernel_parameters
+  set $param = (void*)0x08001000
+
+  ## MOUNT_ROOT_RDONLY
+  set {long}($param+0x00)=0
+  ## RAMDISK_FLAGS
+  #set {long}($param+0x04)=0
+  ## ORIG_ROOT_DEV
+  #set {long}($param+0x08)=0x00000100
+  ## LOADER_TYPE
+  #set {long}($param+0x0C)=0
+  ## INITRD_START
+  set {long}($param+0x10)=0x082a0000
+  ## INITRD_SIZE
+  set {long}($param+0x14)=0d6200000
+
+  # M32R_CPUCLK
+  set *(unsigned long *)($param + 0x0018) = 0d100000000
+  # M32R_BUSCLK
+  set *(unsigned long *)($param + 0x001c) = 0d50000000
+  # M32R_TIMER_DIVIDE
+  set *(unsigned long *)($param + 0x0020) = 0d128
+
+
+ set {char[0x200]}($param + 0x100) = "console=ttyS0,115200n8x root=/dev/nfsroot nfsroot=192.168.0.1:/project/m32r-linux/export/root.2.6_04 nfsaddrs=192.168.0.102:192.168.0.1:192.168.0.1:255.255.255.0:mappi: \0"
+
+
+end
+
+# Boot
+define boot
+  set_kernel_parameters
+  debug_chaos
+  set *(unsigned long *)0x00f00000=0x08002000
+  set $pc=0x08002000
+  set $fp=0
+  del b
+  si
+end
+
+# Restart
+define restart
+  sdireset
+  sdireset
+  setup
+  load_modules
+  boot
+end
+
+sdireset
+sdireset
+file vmlinux
+target m32rsdi
+
+restart
+boot
diff -ruNp a/include/asm-m32r/ide.h b/include/asm-m32r/ide.h
--- a/include/asm-m32r/ide.h	2004-12-25 06:34:57.000000000 +0900
+++ b/include/asm-m32r/ide.h	2005-05-26 20:14:55.000000000 +0900
@@ -35,7 +35,7 @@
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_MAPPI2)
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_MAPPI2) || defined(CONFIG_PLAT_MAPPI3)
 		case 0x1f0: return PLD_IRQ_CFIREQ;
 		default:
 			return 0;
diff -ruNp a/include/asm-m32r/m32102.h b/include/asm-m32r/m32102.h
--- a/include/asm-m32r/m32102.h	2004-12-25 06:35:00.000000000 +0900
+++ b/include/asm-m32r/m32102.h	2005-05-26 20:22:50.000000000 +0900
@@ -175,6 +175,7 @@
 #define M32R_ICU_CR5_PORTL    (0x210+M32R_ICU_OFFSET)  /* INT4 */
 #define M32R_ICU_CR6_PORTL    (0x214+M32R_ICU_OFFSET)  /* INT5 */
 #define M32R_ICU_CR7_PORTL    (0x218+M32R_ICU_OFFSET)  /* INT6 */
+#define M32R_ICU_CR8_PORTL    (0x219+M32R_ICU_OFFSET)  /* INT7 */
 #define M32R_ICU_CR16_PORTL   (0x23C+M32R_ICU_OFFSET)  /* MFT0 */
 #define M32R_ICU_CR17_PORTL   (0x240+M32R_ICU_OFFSET)  /* MFT1 */
 #define M32R_ICU_CR18_PORTL   (0x244+M32R_ICU_OFFSET)  /* MFT2 */
diff -ruNp a/include/asm-m32r/m32r.h b/include/asm-m32r/m32r.h
--- a/include/asm-m32r/m32r.h	2004-12-25 06:35:23.000000000 +0900
+++ b/include/asm-m32r/m32r.h	2005-05-31 16:55:05.000000000 +0900
@@ -36,6 +36,10 @@
 #include <asm/mappi2/mappi2_pld.h>
 #endif	/* CONFIG_PLAT_MAPPI2 */
 
+#if defined(CONFIG_PLAT_MAPPI3)
+#include <asm/mappi3/mappi3_pld.h>
+#endif	/* CONFIG_PLAT_MAPPI3 */
+
 #if defined(CONFIG_PLAT_USRV)
 #include <asm/m32700ut/m32700ut_pld.h>
 #endif
diff -ruNp a/include/asm-m32r/mappi3/mappi3_pld.h b/include/asm-m32r/mappi3/mappi3_pld.h
--- a/include/asm-m32r/mappi3/mappi3_pld.h	1970-01-01 09:00:00.000000000 +0900
+++ b/include/asm-m32r/mappi3/mappi3_pld.h	2005-05-26 20:22:50.000000000 +0900
@@ -0,0 +1,143 @@
+/*
+ * include/asm/mappi3/mappi3_pld.h
+ *
+ * Definitions for Extended IO Logic on MAPPI3 board.
+ *  based on m32700ut_pld.h
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file "COPYING" in the main directory of
+ * this archive for more details.
+ *
+ */
+
+#ifndef _MAPPI3_PLD_H
+#define _MAPPI3_PLD_H
+
+#ifndef __ASSEMBLY__
+/* FIXME:
+ * Some C functions use non-cache address, so can't define non-cache address.
+ */
+#define PLD_BASE		(0x1c000000 /* + NONCACHE_OFFSET */)
+#define __reg8			(volatile unsigned char *)
+#define __reg16			(volatile unsigned short *)
+#define __reg32			(volatile unsigned int *)
+#else
+#define PLD_BASE		(0x1c000000 + NONCACHE_OFFSET)
+#define __reg8
+#define __reg16
+#define __reg32
+#endif	/* __ASSEMBLY__ */
+
+/* CFC */
+#define	PLD_CFRSTCR		__reg16(PLD_BASE + 0x0000)
+#define PLD_CFSTS		__reg16(PLD_BASE + 0x0002)
+#define PLD_CFIMASK		__reg16(PLD_BASE + 0x0004)
+#define PLD_CFBUFCR		__reg16(PLD_BASE + 0x0006)
+#define PLD_CFCR0		__reg16(PLD_BASE + 0x000a)
+#define PLD_CFCR1		__reg16(PLD_BASE + 0x000c)
+
+/* MMC */
+#define PLD_MMCCR		__reg16(PLD_BASE + 0x4000)
+#define PLD_MMCMOD		__reg16(PLD_BASE + 0x4002)
+#define PLD_MMCSTS		__reg16(PLD_BASE + 0x4006)
+#define PLD_MMCBAUR		__reg16(PLD_BASE + 0x400a)
+#define PLD_MMCCMDBCUT		__reg16(PLD_BASE + 0x400c)
+#define PLD_MMCCDTBCUT		__reg16(PLD_BASE + 0x400e)
+#define PLD_MMCDET		__reg16(PLD_BASE + 0x4010)
+#define PLD_MMCWP		__reg16(PLD_BASE + 0x4012)
+#define PLD_MMCWDATA		__reg16(PLD_BASE + 0x5000)
+#define PLD_MMCRDATA		__reg16(PLD_BASE + 0x6000)
+#define PLD_MMCCMDDATA		__reg16(PLD_BASE + 0x7000)
+#define PLD_MMCRSPDATA		__reg16(PLD_BASE + 0x7006)
+
+/* Power Control of MMC and CF */
+#define PLD_CPCR		__reg16(PLD_BASE + 0x14000)
+
+
+/*==== ICU ====*/
+#define  M32R_IRQ_PC104        (5)   /* INT4(PC/104) */
+#define  M32R_IRQ_I2C          (28)  /* I2C-BUS     */
+#define  PLD_IRQ_CFIREQ       (6)  /* INT5 CFC Card Interrupt */
+#define  PLD_IRQ_CFC_INSERT   (7)  /* INT6 CFC Card Insert */
+#define  PLD_IRQ_CFC_EJECT    (8)  /* INT7 CFC Card Eject */
+#define  PLD_IRQ_MMCCARD      (43)  /* MMC Card Insert */
+#define  PLD_IRQ_MMCIRQ       (44)  /* MMC Transfer Done */
+
+
+#if 0
+/* LED Control
+ *
+ * 1: DIP swich side
+ * 2: Reset switch side
+ */
+#define PLD_IOLEDCR		__reg16(PLD_BASE + 0x14002)
+#define PLD_IOLED_1_ON		0x001
+#define PLD_IOLED_1_OFF		0x000
+#define PLD_IOLED_2_ON		0x002
+#define PLD_IOLED_2_OFF		0x000
+
+/* DIP Switch
+ *  0: Write-protect of Flash Memory (0:protected, 1:non-protected)
+ *  1: -
+ *  2: -
+ *  3: -
+ */
+#define PLD_IOSWSTS		__reg16(PLD_BASE + 0x14004)
+#define	PLD_IOSWSTS_IOSW2	0x0200
+#define	PLD_IOSWSTS_IOSW1	0x0100
+#define	PLD_IOSWSTS_IOWP0	0x0001
+
+#endif
+
+/* CRC */
+#define PLD_CRC7DATA		__reg16(PLD_BASE + 0x18000)
+#define PLD_CRC7INDATA		__reg16(PLD_BASE + 0x18002)
+#define PLD_CRC16DATA		__reg16(PLD_BASE + 0x18004)
+#define PLD_CRC16INDATA		__reg16(PLD_BASE + 0x18006)
+#define PLD_CRC16ADATA		__reg16(PLD_BASE + 0x18008)
+#define PLD_CRC16AINDATA	__reg16(PLD_BASE + 0x1800a)
+
+
+#if 0
+/* RTC */
+#define PLD_RTCCR		__reg16(PLD_BASE + 0x1c000)
+#define PLD_RTCBAUR		__reg16(PLD_BASE + 0x1c002)
+#define PLD_RTCWRDATA		__reg16(PLD_BASE + 0x1c004)
+#define PLD_RTCRDDATA		__reg16(PLD_BASE + 0x1c006)
+#define PLD_RTCRSTODT		__reg16(PLD_BASE + 0x1c008)
+
+/* SIO0 */
+#define PLD_ESIO0CR		__reg16(PLD_BASE + 0x20000)
+#define	PLD_ESIO0CR_TXEN	0x0001
+#define	PLD_ESIO0CR_RXEN	0x0002
+#define PLD_ESIO0MOD0		__reg16(PLD_BASE + 0x20002)
+#define	PLD_ESIO0MOD0_CTSS	0x0040
+#define	PLD_ESIO0MOD0_RTSS	0x0080
+#define PLD_ESIO0MOD1		__reg16(PLD_BASE + 0x20004)
+#define	PLD_ESIO0MOD1_LMFS	0x0010
+#define PLD_ESIO0STS		__reg16(PLD_BASE + 0x20006)
+#define	PLD_ESIO0STS_TEMP	0x0001
+#define	PLD_ESIO0STS_TXCP	0x0002
+#define	PLD_ESIO0STS_RXCP	0x0004
+#define	PLD_ESIO0STS_TXSC	0x0100
+#define	PLD_ESIO0STS_RXSC	0x0200
+#define PLD_ESIO0STS_TXREADY	(PLD_ESIO0STS_TXCP | PLD_ESIO0STS_TEMP)
+#define PLD_ESIO0INTCR		__reg16(PLD_BASE + 0x20008)
+#define	PLD_ESIO0INTCR_TXIEN	0x0002
+#define	PLD_ESIO0INTCR_RXCEN	0x0004
+#define PLD_ESIO0BAUR		__reg16(PLD_BASE + 0x2000a)
+#define PLD_ESIO0TXB		__reg16(PLD_BASE + 0x2000c)
+#define PLD_ESIO0RXB		__reg16(PLD_BASE + 0x2000e)
+
+/* SIM Card */
+#define PLD_SCCR		__reg16(PLD_BASE + 0x38000)
+#define PLD_SCMOD		__reg16(PLD_BASE + 0x38004)
+#define PLD_SCSTS		__reg16(PLD_BASE + 0x38006)
+#define PLD_SCINTCR		__reg16(PLD_BASE + 0x38008)
+#define PLD_SCBAUR		__reg16(PLD_BASE + 0x3800a)
+#define PLD_SCTXB		__reg16(PLD_BASE + 0x3800c)
+#define PLD_SCRXB		__reg16(PLD_BASE + 0x3800e)
+
+#endif
+
+#endif	/* _MAPPI3_PLD.H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
