Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVLFNVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVLFNVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVLFNVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:21:03 -0500
Received: from mail.renesas.com ([202.234.163.13]:60669 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751464AbVLFNU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:20:59 -0500
Date: Tue, 06 Dec 2005 22:20:51 +0900 (JST)
Message-Id: <20051206.222051.713541985.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sugai.Naoto@ak.MitsubishiElectric.co.jp,
       takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5-mm1] m32r: Support M32104UT target platform
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for supporting a new target platform, 
Renesas M32104UT evaluation board.

The M32104UT is an eva board based on an uT-Engine specification.
This board has an MMU-less M32R family processor, M32104.
http://www-wa0.personal-media.co.jp/pmc/archive/te/te_m32104_e.pdf

This board is one of the most popular M32R platform, so we have
ported Linux/M32R to it.

Signed-off-by: Naoto Sugai <Sugai.Naoto@ak.MitsubishiElectric.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Kconfig                        |   26 -
 arch/m32r/boot/compressed/head.S         |    5 
 arch/m32r/boot/setup.S                   |    9 
 arch/m32r/kernel/Makefile                |    1 
 arch/m32r/kernel/entry.S                 |   17 
 arch/m32r/kernel/io_m32104ut.c           |  297 ++++++++++++++
 arch/m32r/kernel/setup.c                 |    7 
 arch/m32r/kernel/setup_m32104ut.c        |  161 +++++++
 arch/m32r/kernel/time.c                  |    4 
 arch/m32r/m32104ut/defconfig.m32104ut    |  657 +++++++++++++++++++++++++++++++
 arch/m32r/mm/cache.c                     |   10 
 include/asm-m32r/assembler.h             |   10 
 include/asm-m32r/cacheflush.h            |    2 
 include/asm-m32r/irq.h                   |   16 
 include/asm-m32r/m32102.h                |   31 +
 include/asm-m32r/m32104ut/m32104ut_pld.h |  163 +++++++
 include/asm-m32r/m32r.h                  |    6 
 include/asm-m32r/system.h                |   12 
 18 files changed, 1405 insertions(+), 29 deletions(-)

Index: linux-2.6.15-rc5-mm1/arch/m32r/Kconfig
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/Kconfig	2005-12-06 10:36:03.693823408 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/Kconfig	2005-12-06 21:01:58.428635920 +0900
@@ -81,6 +81,12 @@ config PLAT_MAPPI2
 config PLAT_MAPPI3
        bool "Mappi-III(M3A-2170)"
 
+config PLAT_M32104UT
+	bool "M32104UT"
+	help
+	  The M3T-M32104UT is an reference board based on uT-Engine
+	  specification.  This board has a M32104 chip.
+
 endchoice
 
 choice
@@ -93,6 +99,10 @@ config CHIP_M32700
 config CHIP_M32102
 	bool "M32102"
 
+config CHIP_M32104
+	bool "M32104"
+	depends on PLAT_M32104UT
+
 config CHIP_VDEC2
        bool "VDEC2"
 
@@ -115,7 +125,7 @@ config TLB_ENTRIES
 
 config ISA_M32R
         bool
-	depends on CHIP_M32102
+	depends on CHIP_M32102 || CHIP_M32104
 	default y
 
 config ISA_M32R2
@@ -140,6 +150,7 @@ config BUS_CLOCK
 	default "50000000" if PLAT_MAPPI3
 	default "50000000" if PLAT_M32700UT
 	default "50000000" if PLAT_OPSPUT
+	default "54000000" if PLAT_M32104UT
 	default "33333333" if PLAT_OAKS32R
 	default "20000000" if PLAT_MAPPI2
 
@@ -157,6 +168,7 @@ config MEMORY_START
 	default "08000000" if PLAT_USRV
 	default "08000000" if PLAT_M32700UT
 	default "08000000" if PLAT_OPSPUT
+	default "04000000" if PLAT_M32104UT
 	default "01000000" if PLAT_OAKS32R
 
 config MEMORY_SIZE
@@ -166,6 +178,7 @@ config MEMORY_SIZE
 	default "02000000" if PLAT_USRV
 	default "01000000" if PLAT_M32700UT
 	default "01000000" if PLAT_OPSPUT
+	default "01000000" if PLAT_M32104UT
 	default "00800000" if PLAT_OAKS32R
 
 config NOHIGHMEM
@@ -174,21 +187,22 @@ config NOHIGHMEM
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool "Internal RAM Support"
-	depends on CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP
+	depends on CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP || CHIP_M32104
 	default y
 
 source "mm/Kconfig"
 
 config IRAM_START
 	hex "Internal memory start address (hex)"
-	default "00f00000"
-	depends on (CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP) && DISCONTIGMEM
+	default "00f00000" if !CHIP_M32104
+	default "00700000" if CHIP_M32104
+	depends on (CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP || CHIP_M32104) && DISCONTIGMEM
 
 config IRAM_SIZE
 	hex "Internal memory size (hex)"
-	depends on (CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP) && DISCONTIGMEM
+	depends on (CHIP_M32700 || CHIP_M32102 || CHIP_VDEC2 || CHIP_OPSP || CHIP_M32104) && DISCONTIGMEM
 	default "00080000" if CHIP_M32700
-	default "00010000" if CHIP_M32102 || CHIP_OPSP
+	default "00010000" if CHIP_M32102 || CHIP_OPSP || CHIP_M32104
 	default "00008000" if CHIP_VDEC2
 
 #
Index: linux-2.6.15-rc5-mm1/arch/m32r/boot/setup.S
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/boot/setup.S	2005-12-06 10:36:03.706821432 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/boot/setup.S	2005-12-06 21:01:58.437634552 +0900
@@ -80,6 +80,10 @@ ENTRY(boot)
 	ldi	r1, #0x101		; cache on (with invalidation)
 ;	ldi	r1, #0x00		; cache off
 	st	r1, @r0
+#elif defined(CONFIG_CHIP_M32104)
+	ldi	r0, #-4              ;LDIMM	(r0, M32R_MCCR)
+	ldi	r1, #0x703		; cache on (with invalidation)
+	st	r1, @r0
 #else
 #error unknown chip configuration
 #endif
@@ -115,10 +119,15 @@ mmu_on:
 	st      r1, @(MATM_offset,r0)		; Set MATM (T bit ON)
 	ld      r0, @(MATM_offset,r0)		; Check
 #else
+#if defined(CONFIG_CHIP_M32700)
 	seth	r0,#high(M32R_MCDCAR)
 	or3	r0,r0,#low(M32R_MCDCAR)
 	ld24	r1,#0x8080
 	st	r1,@r0
+#elif defined(CONFIG_CHIP_M32104)
+	LDIMM	(r2, eit_vector)		; set EVB(cr5)
+	mvtc    r2, cr5
+#endif
 #endif	/* CONFIG_MMU */
 	jmp	r13
 	nop
Index: linux-2.6.15-rc5-mm1/arch/m32r/boot/compressed/head.S
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/boot/compressed/head.S	2005-12-06 10:36:03.721819152 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/boot/compressed/head.S	2005-12-06 21:01:58.445633336 +0900
@@ -143,6 +143,11 @@ startup:
 	ldi	r0, -2
 	ldi	r1, 0x0100	; invalidate
 	stb	r1, @r0
+#elif defined(CONFIG_CHIP_M32104)
+	/* Cache flush */
+	ldi	r0, -2
+	ldi	r1, 0x0700	; invalidate i-cache, copy back d-cache
+	sth	r1, @r0
 #else
 #error "put your cache flush function, please"
 #endif
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/Makefile	2005-12-06 10:36:03.735817024 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/Makefile	2005-12-06 21:01:58.454631968 +0900
@@ -16,5 +16,6 @@ obj-$(CONFIG_PLAT_M32700UT)	+= setup_m32
 obj-$(CONFIG_PLAT_OPSPUT)	+= setup_opsput.o io_opsput.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_PLAT_OAKS32R)	+= setup_oaks32r.o io_oaks32r.o
+obj-$(CONFIG_PLAT_M32104UT)	+= setup_m32104ut.o io_m32104ut.o
 
 EXTRA_AFLAGS	:= -traditional
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/entry.S	2005-12-06 21:01:35.066187552 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/entry.S	2005-12-06 21:01:58.463630600 +0900
@@ -315,7 +315,7 @@ ENTRY(ei_handler)
 	mv	r1, sp			; arg1(regs)
 #if defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_XNUX2) \
 	|| defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_M32102) \
-	|| defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 
 ;    GET_ICU_STATUS;
 	seth	r0, #shigh(M32R_ICU_ISTS_ADDR)
@@ -541,7 +541,20 @@ check_int2:
 	bra	check_end
 	.fillinsn
 check_end:
-#endif  /* CONFIG_PLAT_OPSPUT */
+#elif defined(CONFIG_PLAT_M32104UT)
+	add3	r2, r0, #-(M32R_IRQ_INT1)       ; INT1# interrupt
+	bnez	r2, check_end
+	; read ICU status register of PLD
+	seth	r0, #high(PLD_ICUISTS)
+	or3	r0, r0, #low(PLD_ICUISTS)
+	lduh	r0, @r0
+	slli	r0, #21
+	srli	r0, #27                         ; ISN
+	addi	r0, #(M32104UT_PLD_IRQ_BASE)
+	bra	check_end
+	.fillinsn
+check_end:
+#endif  /* CONFIG_PLAT_M32104UT */
 	bl	do_IRQ
 #endif  /* CONFIG_SMP */
 	ld	r14, @sp+
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_m32104ut.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_m32104ut.c	2005-12-06 21:01:58.473629080 +0900
@@ -0,0 +1,297 @@
+/*
+ *  linux/arch/m32r/kernel/io_m32104ut.c
+ *
+ *  Typical I/O routines for M32104UT board.
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
+#define PORT2ADDR(port)  _port2addr(port)
+
+static inline void *_port2addr(unsigned long port)
+{
+	return (void *)(port + NONCACHE_OFFSET);
+}
+
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
+static inline void *__port2addr_ata(unsigned long port)
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
+/*
+ * M32104T-LAN is located in the extended bus space
+ * from 0x01000000 to 0x01ffffff on physical address.
+ * The base address of LAN controller(LAN91C111) is 0x300.
+ */
+#define LAN_IOSTART	0x300
+#define LAN_IOEND	0x320
+static inline void *_port2addr_ne(unsigned long port)
+{
+	return (void *)(port + NONCACHE_OFFSET + 0x01000000);
+}
+
+static inline void delay(void)
+{
+	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
+}
+
+/*
+ * NIC I/O function
+ */
+
+#define PORT2ADDR_NE(port)  _port2addr_ne(port)
+
+static inline unsigned char _ne_inb(void *portp)
+{
+	return *(volatile unsigned char *)portp;
+}
+
+static inline unsigned short _ne_inw(void *portp)
+{
+	return (unsigned short)le16_to_cpu(*(volatile unsigned short *)portp);
+}
+
+static inline void _ne_insb(void *portp, void *addr, unsigned long count)
+{
+	unsigned char *buf = (unsigned char *)addr;
+
+	while (count--)
+		*buf++ = _ne_inb(portp);
+}
+
+static inline void _ne_outb(unsigned char b, void *portp)
+{
+	*(volatile unsigned char *)portp = b;
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
+
+	return *(volatile unsigned char *)PORT2ADDR(port);
+}
+
+unsigned short _inw(unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		return _ne_inw(PORT2ADDR_NE(port));
+
+	return *(volatile unsigned short *)PORT2ADDR(port);
+}
+
+unsigned long _inl(unsigned long port)
+{
+	return *(volatile unsigned long *)PORT2ADDR(port);
+}
+
+unsigned char _inb_p(unsigned long port)
+{
+	unsigned char v = _inb(port);
+	delay();
+	return (v);
+}
+
+unsigned short _inw_p(unsigned long port)
+{
+	unsigned short v = _inw(port);
+	delay();
+	return (v);
+}
+
+unsigned long _inl_p(unsigned long port)
+{
+	unsigned long v = _inl(port);
+	delay();
+	return (v);
+}
+
+void _outb(unsigned char b, unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_outb(b, PORT2ADDR_NE(port));
+	else
+		*(volatile unsigned char *)PORT2ADDR(port) = b;
+}
+
+void _outw(unsigned short w, unsigned long port)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_outw(w, PORT2ADDR_NE(port));
+	else
+		*(volatile unsigned short *)PORT2ADDR(port) = w;
+}
+
+void _outl(unsigned long l, unsigned long port)
+{
+	*(volatile unsigned long *)PORT2ADDR(port) = l;
+}
+
+void _outb_p(unsigned char b, unsigned long port)
+{
+	_outb(b, port);
+	delay();
+}
+
+void _outw_p(unsigned short w, unsigned long port)
+{
+	_outw(w, port);
+	delay();
+}
+
+void _outl_p(unsigned long l, unsigned long port)
+{
+	_outl(l, port);
+	delay();
+}
+
+void _insb(unsigned int port, void *addr, unsigned long count)
+{
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
+		_ne_insb(PORT2ADDR_NE(port), addr, count);
+	else {
+		unsigned char *buf = addr;
+		unsigned char *portp = PORT2ADDR(port);
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
+	}
+}
+
+void _insw(unsigned int port, void *addr, unsigned long count)
+{
+	unsigned short *buf = addr;
+	unsigned short *portp;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
+		/*
+		 * This portion is only used by smc91111.c to read data
+		 * from the DATA_REG. Do not swap the data.
+		 */
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
+void _insl(unsigned int port, void *addr, unsigned long count)
+{
+	unsigned long *buf = addr;
+	unsigned long *portp;
+
+	portp = PORT2ADDR(port);
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
+}
+
+void _outsb(unsigned int port, const void *addr, unsigned long count)
+{
+	const unsigned char *buf = addr;
+	unsigned char *portp;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
+		portp = PORT2ADDR_NE(port);
+		while (count--)
+			_ne_outb(*buf++, portp);
+	} else {
+		portp = PORT2ADDR(port);
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
+	}
+}
+
+void _outsw(unsigned int port, const void *addr, unsigned long count)
+{
+	const unsigned short *buf = addr;
+	unsigned short *portp;
+
+	if (port >= LAN_IOSTART && port < LAN_IOEND) {
+		/*
+		 * This portion is only used by smc91111.c to write data
+		 * into the DATA_REG. Do not swap the data.
+		 */
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
+void _outsl(unsigned int port, const void *addr, unsigned long count)
+{
+	const unsigned long *buf = addr;
+	unsigned char *portp;
+
+	portp = PORT2ADDR(port);
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
+}
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup.c	2005-12-06 10:36:03.774811096 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup.c	2005-12-06 21:01:58.481627864 +0900
@@ -320,6 +320,9 @@ static int show_cpuinfo(struct seq_file 
 #elif defined(CONFIG_CHIP_MP)
 	seq_printf(m, "cpu family\t: M32R-MP\n"
 		"cache size\t: I-xxKB/D-xxKB\n");
+#elif  defined(CONFIG_CHIP_M32104)
+	seq_printf(m,"cpu family\t: M32104\n"
+		"cache size\t: I-8KB/D-8KB\n");
 #else
 	seq_printf(m, "cpu family\t: Unknown\n");
 #endif
@@ -340,6 +343,8 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "Machine\t\t: uServer\n");
 #elif defined(CONFIG_PLAT_OAKS32R)
 	seq_printf(m, "Machine\t\t: OAKS32R\n");
+#elif  defined(CONFIG_PLAT_M32104UT)
+	seq_printf(m, "Machine\t\t: M3T-M32104UT uT Engine board\n");
 #else
 	seq_printf(m, "Machine\t\t: Unknown\n");
 #endif
@@ -389,7 +394,7 @@ unsigned long cpu_initialized __initdata
  */
 #if defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_XNUX2)	\
 	|| defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_M32102) \
-	|| defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 void __init cpu_init (void)
 {
 	int cpu_id = smp_processor_id();
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_m32104ut.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_m32104ut.c	2005-12-06 21:01:58.488626800 +0900
@@ -0,0 +1,161 @@
+/*
+ *  linux/arch/m32r/kernel/setup_m32104ut.c
+ *
+ *  Setup routines for M32104UT Board
+ *
+ *  Copyright (c) 2002-2005  Hiroyuki Kondo, Hirokazu Takata,
+ *                           Hitoshi Yamamoto, Mamoru Sakugawa
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
+static void disable_m32104ut_irq(unsigned int irq)
+{
+	unsigned long port, data;
+
+	port = irq2port(irq);
+	data = icu_data[irq].icucr|M32R_ICUCR_ILEVEL7;
+	outl(data, port);
+}
+
+static void enable_m32104ut_irq(unsigned int irq)
+{
+	unsigned long port, data;
+
+	port = irq2port(irq);
+	data = icu_data[irq].icucr|M32R_ICUCR_IEN|M32R_ICUCR_ILEVEL6;
+	outl(data, port);
+}
+
+static void mask_and_ack_m32104ut(unsigned int irq)
+{
+	disable_m32104ut_irq(irq);
+}
+
+static void end_m32104ut_irq(unsigned int irq)
+{
+	enable_m32104ut_irq(irq);
+}
+
+static unsigned int startup_m32104ut_irq(unsigned int irq)
+{
+	enable_m32104ut_irq(irq);
+	return (0);
+}
+
+static void shutdown_m32104ut_irq(unsigned int irq)
+{
+	unsigned long port;
+
+	port = irq2port(irq);
+	outl(M32R_ICUCR_ILEVEL7, port);
+}
+
+static struct hw_interrupt_type m32104ut_irq_type =
+{
+	.typename = "M32104UT-IRQ",
+	.startup = startup_m32104ut_irq,
+	.shutdown = shutdown_m32104ut_irq,
+	.enable = enable_m32104ut_irq,
+	.disable = disable_m32104ut_irq,
+	.ack = mask_and_ack_m32104ut,
+	.end = end_m32104ut_irq
+};
+
+void __init init_IRQ(void)
+{
+	static int once = 0;
+
+	if (once)
+		return;
+	else
+		once++;
+
+#if defined(CONFIG_SMC91X)
+	/* INT#0: LAN controller on M32104UT-LAN (SMC91C111)*/
+	irq_desc[M32R_IRQ_INT0].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_INT0].handler = &m32104ut_irq_type;
+	irq_desc[M32R_IRQ_INT0].action = 0;
+	irq_desc[M32R_IRQ_INT0].depth = 1;
+	icu_data[M32R_IRQ_INT0].icucr = M32R_ICUCR_IEN | M32R_ICUCR_ISMOD11; /* "H" level sense */
+	disable_m32104ut_irq(M32R_IRQ_INT0);
+#endif  /* CONFIG_SMC91X */
+
+	/* MFT2 : system timer */
+	irq_desc[M32R_IRQ_MFT2].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_MFT2].handler = &m32104ut_irq_type;
+	irq_desc[M32R_IRQ_MFT2].action = 0;
+	irq_desc[M32R_IRQ_MFT2].depth = 1;
+	icu_data[M32R_IRQ_MFT2].icucr = M32R_ICUCR_IEN;
+	disable_m32104ut_irq(M32R_IRQ_MFT2);
+
+#ifdef CONFIG_SERIAL_M32R_SIO
+	/* SIO0_R : uart receive data */
+	irq_desc[M32R_IRQ_SIO0_R].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_SIO0_R].handler = &m32104ut_irq_type;
+	irq_desc[M32R_IRQ_SIO0_R].action = 0;
+	irq_desc[M32R_IRQ_SIO0_R].depth = 1;
+	icu_data[M32R_IRQ_SIO0_R].icucr = M32R_ICUCR_IEN;
+	disable_m32104ut_irq(M32R_IRQ_SIO0_R);
+
+	/* SIO0_S : uart send data */
+	irq_desc[M32R_IRQ_SIO0_S].status = IRQ_DISABLED;
+	irq_desc[M32R_IRQ_SIO0_S].handler = &m32104ut_irq_type;
+	irq_desc[M32R_IRQ_SIO0_S].action = 0;
+	irq_desc[M32R_IRQ_SIO0_S].depth = 1;
+	icu_data[M32R_IRQ_SIO0_S].icucr = M32R_ICUCR_IEN;
+	disable_m32104ut_irq(M32R_IRQ_SIO0_S);
+#endif /* CONFIG_SERIAL_M32R_SIO */
+}
+
+#if defined(CONFIG_SMC91X)
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
+#endif
+
+static int __init platform_init(void)
+{
+#if defined(CONFIG_SMC91X)
+	platform_device_register(&smc91x_device);
+#endif
+	return 0;
+}
+arch_initcall(platform_init);
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/time.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/time.c	2005-12-06 10:36:03.801806992 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/time.c	2005-12-06 21:01:58.495625736 +0900
@@ -57,7 +57,7 @@ static unsigned long do_gettimeoffset(vo
 
 #if defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_XNUX2) \
 	|| defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_M32700) \
-	|| defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 #ifndef CONFIG_SMP
 
 	unsigned long count;
@@ -268,7 +268,7 @@ void __init time_init(void)
 
 #if defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_XNUX2) \
 	|| defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_M32700) \
-	|| defined(CONFIG_CHIP_OPSP)
+	|| defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 
 	/* M32102 MFT setup */
 	setup_irq(M32R_IRQ_MFT2, &irq0);
Index: linux-2.6.15-rc5-mm1/arch/m32r/m32104ut/defconfig.m32104ut
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm1/arch/m32r/m32104ut/defconfig.m32104ut	2005-12-06 21:01:58.505624216 +0900
@@ -0,0 +1,657 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.14
+# Wed Nov  9 16:04:51 2005
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
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_HOTPLUG=y
+# CONFIG_KOBJECT_UEVENT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_TINY_SHMEM=y
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
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
+# CONFIG_PLAT_MAPPI3 is not set
+CONFIG_PLAT_M32104UT=y
+# CONFIG_CHIP_M32700 is not set
+# CONFIG_CHIP_M32102 is not set
+CONFIG_CHIP_M32104=y
+# CONFIG_CHIP_VDEC2 is not set
+# CONFIG_CHIP_OPSP is not set
+CONFIG_ISA_M32R=y
+CONFIG_BUS_CLOCK=54000000
+CONFIG_TIMER_DIVIDE=128
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_MEMORY_START=04000000
+CONFIG_MEMORY_SIZE=01000000
+CONFIG_NOHIGHMEM=y
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+# CONFIG_PREEMPT is not set
+# CONFIG_SMP is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+# CONFIG_ISA is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+
+#
+# PC-card bridges
+#
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_FLAT=y
+# CONFIG_BINFMT_ZFLAT is not set
+# CONFIG_BINFMT_SHARED_FLAT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Networking
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
+CONFIG_IP_FIB_HASH=y
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
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
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
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
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
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
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
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
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
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
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
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
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
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
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
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+CONFIG_SOFT_WATCHDOG=y
+# CONFIG_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
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
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
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
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=932
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
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
+CONFIG_CRAMFS=y
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
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
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
+CONFIG_NLS_CODEPAGE_437=y
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
+CONFIG_NLS_CODEPAGE_932=y
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
+CONFIG_NLS_UTF8=y
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
+CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_FRAME_POINTER is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
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
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
Index: linux-2.6.15-rc5-mm1/arch/m32r/mm/cache.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/mm/cache.c	2005-12-06 10:36:03.826803192 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/mm/cache.c	2005-12-06 21:01:58.513623000 +0900
@@ -26,6 +26,16 @@
 #define MCCR		((volatile unsigned char*)0xfffffffe)
 #define MCCR_IIV	(1UL << 0)	/* I-cache invalidate */
 #define MCCR_ICACHE_INV		MCCR_IIV
+#elif defined(CONFIG_CHIP_M32104)
+#define MCCR		((volatile unsigned long*)0xfffffffc)
+#define MCCR_IIV	(1UL << 8)	/* I-cache invalidate */
+#define MCCR_DIV	(1UL << 9)	/* D-cache invalidate */
+#define MCCR_DCB	(1UL << 10)	/* D-cache copy back */
+#define MCCR_ICM	(1UL << 0)	/* I-cache mode [0:off,1:on] */
+#define MCCR_DCM	(1UL << 1)	/* D-cache mode [0:off,1:on] */
+#define MCCR_ICACHE_INV		MCCR_IIV
+#define MCCR_DCACHE_CB		MCCR_DCB
+#define MCCR_DCACHE_CBINV	(MCCR_DIV|MCCR_DCB)
 #endif /* CONFIG_CHIP_XNUX2 || CONFIG_CHIP_M32700 */
 
 #ifndef MCCR
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/assembler.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/assembler.h	2005-12-06 10:36:03.839801216 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/assembler.h	2005-12-06 21:01:58.524621328 +0900
@@ -52,7 +52,7 @@
 	or3	\reg, \reg, #low(\x)
 	.endm
 
-#if !defined(CONFIG_CHIP_M32102)
+#if !(defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_M32104))
 #define STI(reg) STI_M reg
 	.macro STI_M reg
 	setpsw  #0x40	    ->	nop
@@ -64,7 +64,7 @@
 	clrpsw  #0x40	    ->	nop
 	; WORKAROUND: "-> nop" is a workaround for the M32700(TS1).
 	.endm
-#else	/* CONFIG_CHIP_M32102 */
+#else	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 #define STI(reg) STI_M reg
 	.macro STI_M reg
 	mvfc	\reg, psw
@@ -191,12 +191,12 @@
 	and  \reg, sp
 	.endm
 
-#if !defined(CONFIG_CHIP_M32102)
+#if !(defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_M32104))
 	.macro	SWITCH_TO_KERNEL_STACK
 	; switch to kernel stack (spi)
 	clrpsw	#0x80	    ->	nop
 	.endm
-#else	/* CONFIG_CHIP_M32102 */
+#else	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 	.macro	SWITCH_TO_KERNEL_STACK
 	push	r0		; save r0 for working
 	mvfc	r0, psw
@@ -218,7 +218,7 @@
 	.fillinsn
 2:
 	.endm
-#endif	/* CONFIG_CHIP_M32102 */
+#endif	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 
 #endif	/* __ASSEMBLY__ */
 
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/cacheflush.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/cacheflush.h	2005-12-06 10:36:03.851799392 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/cacheflush.h	2005-12-06 21:01:58.531620264 +0900
@@ -7,7 +7,7 @@
 extern void _flush_cache_all(void);
 extern void _flush_cache_copyback_all(void);
 
-#if defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_OPSP)
+#if defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/irq.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/irq.h	2005-12-06 10:36:03.864797416 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/irq.h	2005-12-06 21:01:58.537619352 +0900
@@ -65,6 +65,22 @@
 #define NR_IRQS \
 	(OPSPUT_NUM_CPU_IRQ + OPSPUT_NUM_PLD_IRQ \
 	+ OPSPUT_NUM_LCD_PLD_IRQ + OPSPUT_NUM_LAN_PLD_IRQ)
+
+#elif defined(CONFIG_PLAT_M32104UT)
+/*
+ * IRQ definitions for M32104UT
+ *  M32104 Chip: 64 interrupts
+ *  ICU of M32104UT-on-board PLD: 32 interrupts cascaded to INT1# chip pin
+ */
+#define	M32104UT_NUM_CPU_IRQ	(64)
+#define M32104UT_NUM_PLD_IRQ	(32)
+#define M32104UT_IRQ_BASE	0
+#define M32104UT_CPU_IRQ_BASE	M32104UT_IRQ_BASE
+#define M32104UT_PLD_IRQ_BASE	(M32104UT_CPU_IRQ_BASE + M32104UT_NUM_CPU_IRQ)
+
+#define NR_IRQS	\
+    (M32104UT_NUM_CPU_IRQ + M32104UT_NUM_PLD_IRQ)
+
 #else
 #define NR_IRQS	64
 #endif
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/m32102.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/m32102.h	2005-12-06 10:36:03.876795592 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/m32102.h	2005-12-06 21:01:58.546617984 +0900
@@ -11,7 +11,11 @@
 /*======================================================================*
  * Special Function Register
  *======================================================================*/
+#if !defined(CONFIG_CHIP_M32104)
 #define M32R_SFR_OFFSET  (0x00E00000)  /* 0x00E00000-0x00EFFFFF 1[MB] */
+#else
+#define M32R_SFR_OFFSET  (0x00700000)  /* 0x00700000-0x007FFFFF 1[MB] */
+#endif
 
 /*
  * Clock and Power Management registers.
@@ -100,7 +104,7 @@
 #define M32R_MFT5RLD_PORTL     (0x0C+M32R_MFT5_OFFSET)  /* MFT4 reload */
 #define M32R_MFT5CMPRLD_PORTL  (0x10+M32R_MFT5_OFFSET)  /* MFT4 compare reload */
 
-#ifdef CONFIG_CHIP_M32700
+#if defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_M32104)
 #define M32R_MFTCR_MFT0MSK  (1UL<<31)  /* b0 */
 #define M32R_MFTCR_MFT1MSK  (1UL<<30)  /* b1 */
 #define M32R_MFTCR_MFT2MSK  (1UL<<29)  /* b2 */
@@ -113,7 +117,7 @@
 #define M32R_MFTCR_MFT3EN   (1UL<<20)  /* b11 */
 #define M32R_MFTCR_MFT4EN   (1UL<<19)  /* b12 */
 #define M32R_MFTCR_MFT5EN   (1UL<<18)  /* b13 */
-#else	/* not CONFIG_CHIP_M32700 */
+#else	/* not CONFIG_CHIP_M32700 && not CONFIG_CHIP_M32104 */
 #define M32R_MFTCR_MFT0MSK  (1UL<<15)  /* b16 */
 #define M32R_MFTCR_MFT1MSK  (1UL<<14)  /* b17 */
 #define M32R_MFTCR_MFT2MSK  (1UL<<13)  /* b18 */
@@ -126,7 +130,7 @@
 #define M32R_MFTCR_MFT3EN   (1UL<<4)   /* b27 */
 #define M32R_MFTCR_MFT4EN   (1UL<<3)   /* b28 */
 #define M32R_MFTCR_MFT5EN   (1UL<<2)   /* b29 */
-#endif	/* not CONFIG_CHIP_M32700 */
+#endif	/* not CONFIG_CHIP_M32700 && not CONFIG_CHIP_M32104 */
 
 #define M32R_MFTMOD_CC_MASK    (1UL<<15)  /* b16 */
 #define M32R_MFTMOD_TCCR       (1UL<<13)  /* b18 */
@@ -241,8 +245,24 @@
 #define M32R_IRQ_MFT1    (17)  /* MFT1 */
 #define M32R_IRQ_MFT2    (18)  /* MFT2 */
 #define M32R_IRQ_MFT3    (19)  /* MFT3 */
-#define M32R_IRQ_MFT4    (20)  /* MFT4 */
-#define M32R_IRQ_MFT5    (21)  /* MFT5 */
+#ifdef CONFIG_CHIP_M32104
+#define M32R_IRQ_MFTX0   (24)  /* MFTX0 */
+#define M32R_IRQ_MFTX1   (25)  /* MFTX1 */
+#define M32R_IRQ_DMA0    (32)  /* DMA0 */
+#define M32R_IRQ_DMA1    (33)  /* DMA1 */
+#define M32R_IRQ_DMA2    (34)  /* DMA2 */
+#define M32R_IRQ_DMA3    (35)  /* DMA3 */
+#define M32R_IRQ_SIO0_R  (40)  /* SIO0 send    */
+#define M32R_IRQ_SIO0_S  (41)  /* SIO0 receive */
+#define M32R_IRQ_SIO1_R  (42)  /* SIO1 send    */
+#define M32R_IRQ_SIO1_S  (43)  /* SIO1 receive */
+#define M32R_IRQ_SIO2_R  (44)  /* SIO2 send    */
+#define M32R_IRQ_SIO2_S  (45)  /* SIO2 receive */
+#define M32R_IRQ_SIO3_R  (46)  /* SIO3 send    */
+#define M32R_IRQ_SIO3_S  (47)  /* SIO3 receive */
+#define M32R_IRQ_ADC     (56)  /* ADC */
+#define M32R_IRQ_PC      (57)  /* PC */
+#else /* ! M32104 */
 #define M32R_IRQ_DMA0    (32)  /* DMA0 */
 #define M32R_IRQ_DMA1    (33)  /* DMA1 */
 #define M32R_IRQ_SIO0_R  (48)  /* SIO0 send    */
@@ -255,6 +275,7 @@
 #define M32R_IRQ_SIO3_S  (55)  /* SIO3 receive */
 #define M32R_IRQ_SIO4_R  (56)  /* SIO4 send    */
 #define M32R_IRQ_SIO4_S  (57)  /* SIO4 receive */
+#endif /* ! M32104 */
 
 #ifdef CONFIG_SMP
 #define M32R_IRQ_IPI0    (56)
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/m32r.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/m32r.h	2005-12-06 10:36:03.891793312 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/m32r.h	2005-12-06 21:01:58.553616920 +0900
@@ -14,7 +14,7 @@
 #include <asm/m32r_mp_fpga.h>
 #elif defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_XNUX2) \
 	|| defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_M32102) \
-        || defined(CONFIG_CHIP_OPSP)
+        || defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 #include <asm/m32102.h>
 #endif
 
@@ -43,6 +43,10 @@
 #include <asm/m32700ut/m32700ut_pld.h>
 #endif
 
+#if defined(CONFIG_PLAT_M32104UT)
+#include <asm/m32104ut/m32104ut_pld.h>
+#endif  /* CONFIG_PLAT_M32104 */
+
 /*
  * M32R Register
  */
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/system.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/system.h	2005-12-06 10:36:03.904791336 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/system.h	2005-12-06 21:01:58.563615400 +0900
@@ -79,12 +79,12 @@ static inline void sched_cacheflush(void
 }
 
 /* Interrupt Control */
-#if !defined(CONFIG_CHIP_M32102)
+#if !defined(CONFIG_CHIP_M32102) && !defined(CONFIG_CHIP_M32104)
 #define local_irq_enable() \
 	__asm__ __volatile__ ("setpsw #0x40 -> nop": : :"memory")
 #define local_irq_disable() \
 	__asm__ __volatile__ ("clrpsw #0x40 -> nop": : :"memory")
-#else	/* CONFIG_CHIP_M32102 */
+#else	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 static inline void local_irq_enable(void)
 {
 	unsigned long tmpreg;
@@ -106,7 +106,7 @@ static inline void local_irq_disable(voi
 		"mvtc	%0, psw	\n\t"
 	: "=&r" (tmpreg0), "=&r" (tmpreg1) : : "cbit", "memory");
 }
-#endif	/* CONFIG_CHIP_M32102 */
+#endif	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 
 #define local_save_flags(x) \
 	__asm__ __volatile__("mvfc %0,psw" : "=r"(x) : /* no input */)
@@ -115,13 +115,13 @@ static inline void local_irq_disable(voi
 	__asm__ __volatile__("mvtc %0,psw" : /* no outputs */ \
 		: "r" (x) : "cbit", "memory")
 
-#if !defined(CONFIG_CHIP_M32102)
+#if !(defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_M32104))
 #define local_irq_save(x)				\
 	__asm__ __volatile__(				\
   		"mvfc	%0, psw;		\n\t"	\
 	  	"clrpsw	#0x40 -> nop;		\n\t"	\
   		: "=r" (x) : /* no input */ : "memory")
-#else	/* CONFIG_CHIP_M32102 */
+#else	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 #define local_irq_save(x) 				\
 	({						\
 		unsigned long tmpreg;			\
@@ -134,7 +134,7 @@ static inline void local_irq_disable(voi
 			: "=r" (x), "=&r" (tmpreg)	\
 			: : "cbit", "memory");		\
 	})
-#endif	/* CONFIG_CHIP_M32102 */
+#endif	/* CONFIG_CHIP_M32102 || CONFIG_CHIP_M32104 */
 
 #define irqs_disabled()					\
 	({						\
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/m32104ut/m32104ut_pld.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/m32104ut/m32104ut_pld.h	2005-12-06 21:01:58.574613728 +0900
@@ -0,0 +1,163 @@
+/*
+ * include/asm/m32104ut/m32104ut_pld.h
+ *
+ * Definitions for Programable Logic Device(PLD) on M32104UT board.
+ * Based on m32700ut_pld.h
+ *
+ * Copyright (c) 2002	Takeo Takahashi
+ * Copyright (c) 2005	Naoto Sugai
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file "COPYING" in the main directory of
+ * this archive for more details.
+ */
+
+#ifndef _M32104UT_M32104UT_PLD_H
+#define _M32104UT_M32104UT_PLD_H
+
+#include <linux/config.h>
+
+#if defined(CONFIG_PLAT_M32104UT)
+#define PLD_PLAT_BASE		0x02c00000
+#else
+#error "no platform configuration"
+#endif
+
+#ifndef __ASSEMBLY__
+/*
+ * C functions use non-cache address.
+ */
+#define PLD_BASE		(PLD_PLAT_BASE /* + NONCACHE_OFFSET */)
+#define __reg8			(volatile unsigned char *)
+#define __reg16			(volatile unsigned short *)
+#define __reg32			(volatile unsigned int *)
+#else
+#define PLD_BASE		(PLD_PLAT_BASE + NONCACHE_OFFSET)
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
+/* ICU
+ *  ICUISTS:	status register
+ *  ICUIREQ0: 	request register
+ *  ICUIREQ1: 	request register
+ *  ICUCR3:	control register for CFIREQ# interrupt
+ *  ICUCR4:	control register for CFC Card insert interrupt
+ *  ICUCR5:	control register for CFC Card eject interrupt
+ *  ICUCR6:	control register for external interrupt
+ *  ICUCR11:	control register for MMC Card insert/eject interrupt
+ *  ICUCR13:	control register for SC error interrupt
+ *  ICUCR14:	control register for SC receive interrupt
+ *  ICUCR15:	control register for SC send interrupt
+ */
+
+#define PLD_IRQ_INT0		(M32104UT_PLD_IRQ_BASE + 0)	/* None */
+#define PLD_IRQ_CFIREQ		(M32104UT_PLD_IRQ_BASE + 3)	/* CF IREQ */
+#define PLD_IRQ_CFC_INSERT	(M32104UT_PLD_IRQ_BASE + 4)	/* CF Insert */
+#define PLD_IRQ_CFC_EJECT	(M32104UT_PLD_IRQ_BASE + 5)	/* CF Eject */
+#define PLD_IRQ_EXINT		(M32104UT_PLD_IRQ_BASE + 6)	/* EXINT */
+#define PLD_IRQ_MMCCARD		(M32104UT_PLD_IRQ_BASE + 11)	/* MMC Insert/Eject */
+#define PLD_IRQ_SC_ERROR	(M32104UT_PLD_IRQ_BASE + 13)	/* SC error */
+#define PLD_IRQ_SC_RCV		(M32104UT_PLD_IRQ_BASE + 14)	/* SC receive */
+#define PLD_IRQ_SC_SND		(M32104UT_PLD_IRQ_BASE + 15)	/* SC send */
+
+#define PLD_ICUISTS		__reg16(PLD_BASE + 0x8002)
+#define PLD_ICUISTS_VECB_MASK	(0xf000)
+#define PLD_ICUISTS_VECB(x)	((x) & PLD_ICUISTS_VECB_MASK)
+#define PLD_ICUISTS_ISN_MASK	(0x07c0)
+#define PLD_ICUISTS_ISN(x)	((x) & PLD_ICUISTS_ISN_MASK)
+#define PLD_ICUCR3		__reg16(PLD_BASE + 0x8104)
+#define PLD_ICUCR4		__reg16(PLD_BASE + 0x8106)
+#define PLD_ICUCR5		__reg16(PLD_BASE + 0x8108)
+#define PLD_ICUCR6		__reg16(PLD_BASE + 0x810a)
+#define PLD_ICUCR11		__reg16(PLD_BASE + 0x8114)
+#define PLD_ICUCR13		__reg16(PLD_BASE + 0x8118)
+#define PLD_ICUCR14		__reg16(PLD_BASE + 0x811a)
+#define PLD_ICUCR15		__reg16(PLD_BASE + 0x811c)
+#define PLD_ICUCR_IEN		(0x1000)
+#define PLD_ICUCR_IREQ		(0x0100)
+#define PLD_ICUCR_ISMOD00	(0x0000)	/* Low edge */
+#define PLD_ICUCR_ISMOD01	(0x0010)	/* Low level */
+#define PLD_ICUCR_ISMOD02	(0x0020)	/* High edge */
+#define PLD_ICUCR_ISMOD03	(0x0030)	/* High level */
+#define PLD_ICUCR_ILEVEL0	(0x0000)
+#define PLD_ICUCR_ILEVEL1	(0x0001)
+#define PLD_ICUCR_ILEVEL2	(0x0002)
+#define PLD_ICUCR_ILEVEL3	(0x0003)
+#define PLD_ICUCR_ILEVEL4	(0x0004)
+#define PLD_ICUCR_ILEVEL5	(0x0005)
+#define PLD_ICUCR_ILEVEL6	(0x0006)
+#define PLD_ICUCR_ILEVEL7	(0x0007)
+
+/* Power Control of MMC and CF */
+#define PLD_CPCR		__reg16(PLD_BASE + 0x14000)
+#define PLD_CPCR_CDP		0x0001
+
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
+/* CRC */
+#define PLD_CRC7DATA		__reg16(PLD_BASE + 0x18000)
+#define PLD_CRC7INDATA		__reg16(PLD_BASE + 0x18002)
+#define PLD_CRC16DATA		__reg16(PLD_BASE + 0x18004)
+#define PLD_CRC16INDATA		__reg16(PLD_BASE + 0x18006)
+#define PLD_CRC16ADATA		__reg16(PLD_BASE + 0x18008)
+#define PLD_CRC16AINDATA	__reg16(PLD_BASE + 0x1800a)
+
+/* RTC */
+#define PLD_RTCCR		__reg16(PLD_BASE + 0x1c000)
+#define PLD_RTCBAUR		__reg16(PLD_BASE + 0x1c002)
+#define PLD_RTCWRDATA		__reg16(PLD_BASE + 0x1c004)
+#define PLD_RTCRDDATA		__reg16(PLD_BASE + 0x1c006)
+#define PLD_RTCRSTODT		__reg16(PLD_BASE + 0x1c008)
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
+#endif	/* _M32104UT_M32104UT_PLD_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
