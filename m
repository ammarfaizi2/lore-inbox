Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUJaKJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUJaKJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUJaKJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:09:52 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:60762 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261522AbUJaKCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:02:48 -0500
Date: Sun, 31 Oct 2004 11:02:39 +0100
Message-Id: <200410311002.i9VA2dDr009478@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 473] HP300 core updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update of HP300 core support to use bootinfo etc. (from Kars de Jong)

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/hp300/config.c	2003-05-05 22:35:59.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/hp300/config.c	2004-07-14 13:17:56.000000000 +0200
@@ -7,56 +7,272 @@
  *  called by setup.c.
  */
 
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/kd.h>
-#include <linux/tty.h>
-#include <linux/console.h>
-#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+
+#include <asm/bootinfo.h>
 #include <asm/machdep.h>
 #include <asm/blinken.h>
-#include <asm/hwtest.h>                           /* hwreg_present() */
+#include <asm/io.h>                               /* readb() and writeb() */
+#include <asm/hp300hw.h>
+#include <asm/rtc.h>
 
 #include "ints.h"
 #include "time.h"
 
+unsigned long hp300_model;
+unsigned long hp300_uart_scode = -1;
+unsigned char ledstate;
+
+static char s_hp330[] __initdata = "330";
+static char s_hp340[] __initdata = "340";
+static char s_hp345[] __initdata = "345";
+static char s_hp360[] __initdata = "360";
+static char s_hp370[] __initdata = "370";
+static char s_hp375[] __initdata = "375";
+static char s_hp380[] __initdata = "380";
+static char s_hp385[] __initdata = "385";
+static char s_hp400[] __initdata = "400";
+static char s_hp425t[] __initdata = "425t";
+static char s_hp425s[] __initdata = "425s";
+static char s_hp425e[] __initdata = "425e";
+static char s_hp433t[] __initdata = "433t";
+static char s_hp433s[] __initdata = "433s";
+static char *hp300_models[] __initdata = {
+	[HP_320]	= NULL,
+	[HP_330]	= s_hp330,
+	[HP_340]	= s_hp340,
+	[HP_345]	= s_hp345,
+	[HP_350]	= NULL,
+	[HP_360]	= s_hp360,
+	[HP_370]	= s_hp370,
+	[HP_375]	= s_hp375,
+	[HP_380]	= s_hp380,
+	[HP_385]	= s_hp385,
+	[HP_400]	= s_hp400,
+	[HP_425T]	= s_hp425t,
+	[HP_425S]	= s_hp425s,
+	[HP_425E]	= s_hp425e,
+	[HP_433T]	= s_hp433t,
+	[HP_433S]	= s_hp433s,
+};
+
+static char hp300_model_name[13] = "HP9000/";
+
 extern void hp300_reset(void);
 extern irqreturn_t (*hp300_default_handler[])(int, void *, struct pt_regs *);
 extern int show_hp300_interrupts(struct seq_file *, void *);
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+extern int hp300_setup_serial_console(void) __init;
+#endif
+
+int __init hp300_parse_bootinfo(const struct bi_record *record)
+{
+	int unknown = 0;
+	const unsigned long *data = record->data;
+
+	switch (record->tag) {
+	case BI_HP300_MODEL:
+		hp300_model = *data;
+		break;
+
+	case BI_HP300_UART_SCODE:
+		hp300_uart_scode = *data;
+		break;
+
+	case BI_HP300_UART_ADDR:
+		/* serial port address: ignored here */
+		break;
+
+        default:
+		unknown = 1;
+	}
+
+	return unknown;
+}
 
 #ifdef CONFIG_HEARTBEAT
 static void hp300_pulse(int x)
 {
-   if (x)
-      blinken_leds(0xfe);
-   else
-      blinken_leds(0xff);
+	if (x)
+		blinken_leds(0x10, 0);
+	else
+		blinken_leds(0, 0x10);
 }
 #endif
 
 static void hp300_get_model(char *model)
 {
-  strcpy(model, "HP9000/300");
+	strcpy(model, hp300_model_name);
+}
+
+#define RTCBASE			0xf0420000
+#define RTC_DATA		0x1
+#define RTC_CMD			0x3
+
+#define	RTC_BUSY		0x02
+#define	RTC_DATA_RDY		0x01
+
+#define rtc_busy()		(in_8(RTCBASE + RTC_CMD) & RTC_BUSY)
+#define rtc_data_available()	(in_8(RTCBASE + RTC_CMD) & RTC_DATA_RDY)
+#define rtc_status()		(in_8(RTCBASE + RTC_CMD))
+#define rtc_command(x)		out_8(RTCBASE + RTC_CMD, (x))
+#define rtc_read_data()		(in_8(RTCBASE + RTC_DATA))
+#define rtc_write_data(x)	out_8(RTCBASE + RTC_DATA, (x))
+
+#define RTC_SETREG	0xe0
+#define RTC_WRITEREG	0xc2
+#define RTC_READREG	0xc3
+
+#define RTC_REG_SEC2	0
+#define RTC_REG_SEC1	1
+#define RTC_REG_MIN2	2
+#define RTC_REG_MIN1	3
+#define RTC_REG_HOUR2	4
+#define RTC_REG_HOUR1	5
+#define RTC_REG_WDAY	6
+#define RTC_REG_DAY2	7
+#define RTC_REG_DAY1	8
+#define RTC_REG_MON2	9
+#define RTC_REG_MON1	10
+#define RTC_REG_YEAR2	11
+#define RTC_REG_YEAR1	12
+
+#define RTC_HOUR1_24HMODE 0x8
+
+#define RTC_STAT_MASK	0xf0
+#define RTC_STAT_RDY	0x40
+
+static inline unsigned char hp300_rtc_read(unsigned char reg)
+{
+	unsigned char s, ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	while (rtc_busy());
+	rtc_command(RTC_SETREG);
+	while (rtc_busy());
+	rtc_write_data(reg);
+	while (rtc_busy());
+	rtc_command(RTC_READREG);
+
+	do {
+		while (!rtc_data_available());
+		s = rtc_status();
+		ret = rtc_read_data();
+	} while ((s & RTC_STAT_MASK) != RTC_STAT_RDY);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline unsigned char hp300_rtc_write(unsigned char reg,
+					    unsigned char val)
+{
+	unsigned char s, ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	while (rtc_busy());
+	rtc_command(RTC_SETREG);
+	while (rtc_busy());
+	rtc_write_data((val << 4) | reg);
+	while (rtc_busy());
+	rtc_command(RTC_WRITEREG);
+	while (rtc_busy());
+	rtc_command(RTC_READREG);
+
+	do {
+		while (!rtc_data_available());
+		s = rtc_status();
+		ret = rtc_read_data();
+	} while ((s & RTC_STAT_MASK) != RTC_STAT_RDY);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static int hp300_hwclk(int op, struct rtc_time *t)
+{
+	if (!op) { /* read */
+		t->tm_sec  = hp300_rtc_read(RTC_REG_SEC1) * 10 +
+			hp300_rtc_read(RTC_REG_SEC2);
+		t->tm_min  = hp300_rtc_read(RTC_REG_MIN1) * 10 +
+			hp300_rtc_read(RTC_REG_MIN2);
+		t->tm_hour = (hp300_rtc_read(RTC_REG_HOUR1) & 3) * 10 +
+			hp300_rtc_read(RTC_REG_HOUR2);
+		t->tm_wday = -1;
+		t->tm_mday = hp300_rtc_read(RTC_REG_DAY1) * 10 +
+			hp300_rtc_read(RTC_REG_DAY2);
+		t->tm_mon  = hp300_rtc_read(RTC_REG_MON1) * 10 +
+			hp300_rtc_read(RTC_REG_MON2) - 1;
+		t->tm_year = hp300_rtc_read(RTC_REG_YEAR1) * 10 +
+			hp300_rtc_read(RTC_REG_YEAR2);
+		if (t->tm_year <= 69)
+			t->tm_year += 100;
+	} else {
+		hp300_rtc_write(RTC_REG_SEC1, t->tm_sec / 10);
+		hp300_rtc_write(RTC_REG_SEC2, t->tm_sec % 10);
+		hp300_rtc_write(RTC_REG_MIN1, t->tm_min / 10);
+		hp300_rtc_write(RTC_REG_MIN2, t->tm_min % 10);
+		hp300_rtc_write(RTC_REG_HOUR1,
+				((t->tm_hour / 10) & 3) | RTC_HOUR1_24HMODE);
+		hp300_rtc_write(RTC_REG_HOUR2, t->tm_hour % 10);
+		hp300_rtc_write(RTC_REG_DAY1, t->tm_mday / 10);
+		hp300_rtc_write(RTC_REG_DAY2, t->tm_mday % 10);
+		hp300_rtc_write(RTC_REG_MON1, (t->tm_mon + 1) / 10);
+		hp300_rtc_write(RTC_REG_MON2, (t->tm_mon + 1) % 10);
+		if (t->tm_year >= 100)
+			t->tm_year -= 100;
+		hp300_rtc_write(RTC_REG_YEAR1, t->tm_year / 10);
+		hp300_rtc_write(RTC_REG_YEAR2, t->tm_year % 10);
+	}
+
+	return 0;
+}
+
+static unsigned int hp300_get_ss(void)
+{
+	return hp300_rtc_read(RTC_REG_SEC1) * 10 +
+		hp300_rtc_read(RTC_REG_SEC2);
 }
 
 void __init config_hp300(void)
 {
-  mach_sched_init      = hp300_sched_init;
-  mach_init_IRQ        = hp300_init_IRQ;
-  mach_request_irq     = hp300_request_irq;
-  mach_free_irq        = hp300_free_irq;
-  mach_get_model       = hp300_get_model;
-  mach_get_irq_list    = show_hp300_interrupts;
-  mach_gettimeoffset   = hp300_gettimeoffset;
-  mach_default_handler = &hp300_default_handler;
-  mach_reset           = hp300_reset;
+	mach_sched_init      = hp300_sched_init;
+	mach_init_IRQ        = hp300_init_IRQ;
+	mach_request_irq     = hp300_request_irq;
+	mach_free_irq        = hp300_free_irq;
+	mach_get_model       = hp300_get_model;
+	mach_get_irq_list    = show_hp300_interrupts;
+	mach_gettimeoffset   = hp300_gettimeoffset;
+	mach_default_handler = &hp300_default_handler;
+	mach_hwclk	     = hp300_hwclk;
+	mach_get_ss	     = hp300_get_ss;
+	mach_reset           = hp300_reset;
 #ifdef CONFIG_HEARTBEAT
-  mach_heartbeat       = hp300_pulse;
+	mach_heartbeat       = hp300_pulse;
 #endif
 #ifdef CONFIG_DUMMY_CONSOLE
-  conswitchp	       = &dummy_con;
+	conswitchp	     = &dummy_con;
+#endif
+	mach_max_dma_address = 0xffffffff;
+
+	if (hp300_model >= HP_330 && hp300_model <= HP_433S && hp300_model != HP_350) {
+		printk(KERN_INFO "Detected HP9000 model %s\n", hp300_models[hp300_model-HP_320]);
+		strcat(hp300_model_name, hp300_models[hp300_model-HP_320]);
+	}
+	else {
+		panic("Unknown HP9000 Model");
+	}
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	hp300_setup_serial_console();
 #endif
-  mach_max_dma_address = 0xffffffff;
 }
--- linux-2.6.10-rc1/arch/m68k/hp300/ints.c	2004-04-05 15:09:02.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/hp300/ints.c	2004-07-14 13:17:56.000000000 +0200
@@ -57,14 +57,21 @@
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t hp300_badint(int irq, void *dev_id, struct pt_regs *fp)
+{
+	num_spurious += 1;
+	return IRQ_NONE;
+}
+
 irqreturn_t (*hp300_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	[0] = hp300_int_handler,
+	[0] = hp300_badint,
 	[1] = hp300_int_handler,
 	[2] = hp300_int_handler,
 	[3] = hp300_int_handler,
 	[4] = hp300_int_handler,
 	[5] = hp300_int_handler,
 	[6] = hp300_int_handler,
+	[7] = hp300_int_handler
 };
 
 /* dev_id had better be unique to each handler because it's the only way we have
--- linux-2.6.10-rc1/arch/m68k/hp300/reboot.S	2001-10-22 01:53:57.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/hp300/reboot.S	2004-07-14 13:17:56.000000000 +0200
@@ -13,23 +13,4 @@
 
 	.globl	hp300_reset
 hp300_reset:
-	.chip	68030
-	oriw    #0x0700,%sr			/* cli() */
-	movel	hp300_phys_ram_base, %d1
-	movel	#0, %d0
-	movec	%d0, %vbr			/* reset vector table */
-	lea	zero, %a0
-	lea	1f, %a1
-	add	%d1, %a0
-	add	%d1, %a1
-	pmove	%tc, %a0@
-	bclr	#7, %a0@
-	pmove	%a0@, %tc			/* goodbye MMU */
-	jmp	%a1@
-1:	movel	#0x808, %d0
-	movec	%d0, %cacr			/* cache off */
-	moveb	#0, 0x1ffff
-	movel	#0x1a4, %a0
-	jmp	%a0@
-
-zero:	.quad	0
+	jmp	hp300_reset
--- linux-2.6.10-rc1/arch/m68k/hp300/time.c	2004-03-12 14:34:07.000000000 +0100
+++ linux-m68k-2.6.10-rc1/arch/m68k/hp300/time.c	2004-07-14 13:17:56.000000000 +0200
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/traps.h>
+#include <asm/blinken.h>
 #include "ints.h"
 
 /* Clock hardware definitions */
@@ -38,11 +39,13 @@
 
 static irqreturn_t hp300_tick(int irq, void *dev_id, struct pt_regs *regs)
 {
-  unsigned long tmp;
-  irqreturn_t (*vector)(int, void *, struct pt_regs *) = dev_id;
-  in_8(CLOCKBASE + CLKSR);
-  asm volatile ("movpw %1@(5),%0" : "=d" (tmp) : "a" (CLOCKBASE));
-  return vector(irq, NULL, regs);
+	unsigned long tmp;
+	irqreturn_t (*vector)(int, void *, struct pt_regs *) = dev_id;
+	in_8(CLOCKBASE + CLKSR);
+	asm volatile ("movpw %1@(5),%0" : "=d" (tmp) : "a" (CLOCKBASE));
+	/* Turn off the network and SCSI leds */
+	blinken_leds(0, 0xe0);
+	return vector(irq, NULL, regs);
 }
 
 unsigned long hp300_gettimeoffset(void)
--- linux-2.6.10-rc1/arch/m68k/kernel/head.S	2004-04-05 15:09:05.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/kernel/head.S	2004-07-14 13:17:57.000000000 +0200
@@ -24,6 +24,7 @@
 ** 1998/08/30 David Kilzer: Added support for font_desc structures
 **            for linux-2.1.115
 ** 9/02/11  Richard Zidlicky: added Q40 support (initial vesion 99/01/01)
+** 2004/05/13 Kars de Jong: Finalised HP300 support
 **
 ** This file is subject to the terms and conditions of the GNU General Public
 ** License. See the file README.legal in the main directory of this archive
@@ -313,9 +314,6 @@
 #ifdef CONFIG_Q40
 .globl q40_mem_cptr
 #endif
-#ifdef CONFIG_HP300
-.globl hp300_phys_ram_base
-#endif
 
 CPUTYPE_040	= 1	/* indicates an 040 */
 CPUTYPE_060	= 2	/* indicates an 060 */
@@ -467,7 +465,7 @@
 func_define	mmu_get_page_table_entry,2
 func_define	mmu_print
 func_define	get_new_page
-#ifdef CONFIG_HP300
+#if defined(CONFIG_HP300) || defined(CONFIG_APOLLO)
 func_define	set_leds
 #endif
 
@@ -594,6 +592,7 @@
 	.long	MACH_BVME6000, BVME6000_BOOTI_VERSION
 	.long	MACH_MAC, MAC_BOOTI_VERSION
 	.long	MACH_Q40, Q40_BOOTI_VERSION
+	.long	MACH_HP300, HP300_BOOTI_VERSION
 	.long	0
 1:	jra	__start
 
@@ -605,65 +604,6 @@
 	jra	__start
 __INIT
 ENTRY(__start)
-
-#ifdef CONFIG_HP300
-/* This is a hack.  The HP NetBSD bootloader loads us at an arbitrary
-   address (apparently 0xff002000 in practice) which is not good if we need
-   to be able to map this to VA 0x1000.  We could do it with pagetables but
-   a better solution seems to be to relocate the kernel in physical memory
-   before we start.
-
-   So, we copy the entire kernel image (code+data+bss) down to the 16MB
-   boundary that marks the start of RAM.  This is slightly tricky because
-   we must not overwrite the copying code itself. :-)  */
-
-/* 15/5/98.  The start address of physical RAM changes depending on how much
-   RAM is present.  This is actually a blessing in disguise as it provides
-   a way for us to work out the RAM size rather than hardwiring it.  */
-
-	lea	%pc@(_start),%a0
-	movel	%a0,%d6
-	and	#0xffff0000, %d6
-	lea	%pc@(hp300_phys_ram_base),%a0
-	movel	%d6, %a0@
-	movel	%pc@(L(custom)),%a3
-	moveb	#0xfe,%d7
-	moveb	%d7,%a3@(0x1ffff)
-	lea	%pc@(Lcopystart),%a0
-	lea	%pc@(Lcopyend),%a1
-	movel	%d6,%a2			/* Start of physical RAM */
-1:	moveb	%a0@+,%d0
-	moveb	%d0,%a2@+
-	cmpl	%a0,%a1
-	jbne	1b
-	movel	%d6,%a2
-	moveb	#0xfd,%d7
-	moveb	%d7,%a3@(0x1ffff)
-	lea	%pc@(_stext),%a0
-	lea	%pc@(_end),%a1
-	jmp	%a2@
-
-Lcopystart:
-	moveb	#0xf7,%d7
-	moveb	%d7,%a3@(0x1ffff)
-	movel	%d6,%a2	/* Start of kernel */
-	add	#0x1000,%a2
-1:	moveb	%a0@+,%d0
-	moveb	%d0,%a2@+
-	cmpl	%a0,%a1
-	jbne	1b
-	moveb	#0,%d7
-	moveb	%d7,%a3@(0x1ffff)
-	movel	%d6,%a0
-	addl	#Lstart1,%a0
-	jmp	%a0@
-Lcopyend:
-
-Lstart1:
-	moveb	#0x3f,%d7
-	moveb	%d7,%a3@(0x1ffff)
-#endif /* CONFIG_HP300 */
-
 /*
  * Setup initial stack pointer
  */
@@ -672,8 +612,6 @@
 /*
  * Record the CPU and machine type.
  */
-
-#ifndef CONFIG_HP300
 	get_bi_record	BI_MACHTYPE
 	lea	%pc@(m68k_machtype),%a1
 	movel	%a0@,%a1@
@@ -689,23 +627,8 @@
 	get_bi_record	BI_CPUTYPE
 	lea	%pc@(m68k_cputype),%a1
 	movel	%a0@,%a1@
-#else /* CONFIG_HP300 */
-	/* FIXME HP300 doesn't use bootinfo yet */
-	movel	#MACH_HP300,%d4
-	lea	%pc@(m68k_machtype),%a0
-	movel	%d4,%a0@
-	movel	#FPU_68881,%d0
-	lea	%pc@(m68k_fputype),%a0
-	movel	%d0,%a0@
-	movel	#MMU_68030,%d0
-	lea	%pc@(m68k_mmutype),%a0
-	movel	%d0,%a0@
-	movel	#CPU_68030,%d0
-	lea	%pc@(m68k_cputype),%a0
-	movel	%d0,%a0@
 
-	leds(0x1)
-#endif /* CONFIG_HP300 */
+	leds	0x1
 
 #ifdef CONFIG_MAC
 /*
@@ -956,6 +879,26 @@
 
 #endif
 
+#ifdef CONFIG_HP300
+	is_not_hp300(L(nothp))
+
+	/* Get the address of the UART for serial debugging */
+	get_bi_record	BI_HP300_UART_ADDR
+	tstl	%d0
+	jbmi	1f
+	movel	%a0@,%d3
+	lea	%pc@(L(uartbase)),%a0
+	movel	%d3,%a0@
+	get_bi_record	BI_HP300_UART_SCODE
+	tstl	%d0
+	jbmi	1f
+	movel	%a0@,%d3
+	lea	%pc@(L(uart_scode)),%a0
+	movel	%d3,%a0@
+1:
+L(nothp):
+#endif
+
 /*
  * Initialize serial port
  */
@@ -979,9 +922,7 @@
 
 	putc	'\n'
 	putc	'A'
-#ifdef CONFIG_HP300
-	leds(0x2)
-#endif /* CONFIG_HP300 */
+	leds	0x2
 	dputn	%pc@(L(cputype))
 	dputn	%pc@(m68k_supervisor_cachemode)
 	dputn	%pc@(m68k_pgtable_cachemode)
@@ -1124,16 +1065,30 @@
 #ifdef CONFIG_HP300
 	is_not_hp300(L(nothp300))
 
-/* On the HP300, we map the ROM, INTIO and DIO regions (phys. 0x00xxxxxx)
-   by mapping 32MB from 0xf0xxxxxx -> 0x00xxxxxx) using an 030 early
-   termination page descriptor.  The ROM mapping is needed because the LEDs
-   are mapped there too.  */
+	/* On the HP300, we map the ROM, INTIO and DIO regions (phys. 0x00xxxxxx)
+	 * by mapping 32MB (on 020/030) or 16 MB (on 040) from 0xf0xxxxxx -> 0x00xxxxxx).
+	 * The ROM mapping is needed because the LEDs are mapped there too.
+	 */
+
+	is_040(1f)
 
+	/*
+	 * 030: Map the 32Meg range physical 0x0 upto logical 0xf000.0000
+	 */
 	mmu_map	#0xf0000000,#0,#0x02000000,#_PAGE_NOCACHE030
 
-L(nothp300):
+	jbra	L(mmu_init_done)
 
-#endif
+1:
+	/*
+	 * 040: Map the 16Meg range physical 0x0 upto logical 0xf000.0000
+	 */
+	mmu_map #0xf0000000,#0,#0x01000000,#_PAGE_NOCACHE_S
+
+	jbra	L(mmu_init_done)
+
+L(nothp300):
+#endif /* CONFIG_HP300 */
 
 #ifdef CONFIG_MVME147
 
@@ -1480,15 +1435,23 @@
 #ifdef CONFIG_HP300
 	is_not_hp300(1f)
 	/*
-	 * Fix up the custom register to point to the new location of the LEDs.
+	 * Fix up the iobase register to point to the new location of the LEDs.
 	 */
-	movel	#0xf0000000,L(custom)
+	movel	#0xf0000000,L(iobase)
 
 	/*
 	 * Energise the FPU and caches.
 	 */
+	is_040(1f)
 	movel	#0x60,0xf05f400c
-1:
+	jbra	2f
+
+	/*
+	 * 040: slightly different, apparently.
+	 */
+1:	movew	#0,0xf05f400e
+	movew	#0x64,0xf05f400e
+2:
 #endif
 
 #ifdef CONFIG_SUN3X
@@ -1585,7 +1548,6 @@
 
 	movel	ARG1,%d0
 	lea	%pc@(_end),%a0
-#ifndef CONFIG_HP300
 1:	tstw	%a0@(BIR_TAG)
 	jeq	3f
 	cmpw	%a0@(BIR_TAG),%d0
@@ -1599,7 +1561,6 @@
 3:	moveq	#-1,%d0
 	lea	%a0@(BIR_SIZE),%a0
 4:
-#endif /* CONFIG_HP300 */
 func_return	get_bi_record
 
 
@@ -3013,6 +2974,10 @@
 /* We count on the PROM initializing SIO1 */
 #endif
 
+#ifdef CONFIG_HP300
+/* We count on the boot loader initialising the UART */
+#endif
+
 L(serial_init_done):
 func_return	serial_init
 
@@ -3205,9 +3170,31 @@
 1:      moveb   %a1@(LSRB0),%d0
 	andb	#0x4,%d0
 	beq	1b
+	jbra	L(serial_putc_done)
 2:
 #endif
 
+#ifdef CONFIG_HP300
+	is_not_hp300(3f)
+	movl    %pc@(L(iobase)),%a1
+	addl	%pc@(L(uartbase)),%a1
+	movel	%pc@(L(uart_scode)),%d1	/* Check the scode */
+	jmi	3f			/* Unset? Exit */
+	cmpi	#256,%d1		/* APCI scode? */
+	jeq	2f
+1:      moveb   %a1@(DCALSR),%d1	/* Output to DCA */
+	andb	#0x20,%d1
+	beq	1b
+	moveb	%d0,%a1@(DCADATA)
+	jbra	L(serial_putc_done)
+2:	moveb	%a1@(APCILSR),%d1	/* Output to APCI */
+	andb	#0x20,%d1
+	beq	2b
+	moveb	%d0,%a1@(APCIDATA)
+	jbra	L(serial_putc_done)
+3:
+#endif
+	
 L(serial_putc_done):
 func_return	serial_putc
 
@@ -3295,7 +3282,7 @@
 	movel	ARG1,%d0
 #ifdef CONFIG_HP300
 	is_not_hp300(1f)
-	movel	%pc@(L(custom)),%a0
+	movel	%pc@(L(iobase)),%a0
 	moveb	%d0,%a0@(0x1ffff)
 	jra	2f
 #endif
@@ -3829,10 +3816,6 @@
 __INITDATA
 	.align	4
 
-#ifdef CONFIG_HP300
-hp300_phys_ram_base:
-#endif
-
 #if defined(CONFIG_ATARI) || defined(CONFIG_AMIGA) || \
     defined(CONFIG_HP300) || defined(CONFIG_APOLLO)
 L(custom):
@@ -3924,6 +3907,17 @@
 LCPUCTRL     = 0x10100
 #endif
 
+#if defined(CONFIG_HP300)
+DCADATA	     = 0x11
+DCALSR	     = 0x1b
+APCIDATA     = 0x00
+APCILSR      = 0x14
+L(uartbase):
+	.long	0
+L(uart_scode):
+	.long	-1
+#endif
+
 __FINIT
 	.data
 	.align	4
--- linux-2.6.10-rc1/arch/m68k/kernel/setup.c	2004-07-05 21:21:43.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/kernel/setup.c	2004-07-14 13:17:57.000000000 +0200
@@ -110,6 +110,7 @@
 extern int bvme6000_parse_bootinfo(const struct bi_record *);
 extern int mvme16x_parse_bootinfo(const struct bi_record *);
 extern int mvme147_parse_bootinfo(const struct bi_record *);
+extern int hp300_parse_bootinfo(const struct bi_record *);
 
 extern void config_amiga(void);
 extern void config_atari(void);
@@ -176,6 +177,8 @@
 		    unknown = mvme16x_parse_bootinfo(record);
 		else if (MACH_IS_MVME147)
 		    unknown = mvme147_parse_bootinfo(record);
+		else if (MACH_IS_HP300)
+		    unknown = hp300_parse_bootinfo(record);
 		else
 		    unknown = 1;
 	}
@@ -205,20 +208,8 @@
 	int i;
 	char *p, *q;
 
-	if (!MACH_IS_HP300) {
-		/* The bootinfo is located right after the kernel bss */
-		m68k_parse_bootinfo((const struct bi_record *)&_end);
-	} else {
-		/* FIXME HP300 doesn't use bootinfo yet */
-		extern unsigned long hp300_phys_ram_base;
-		unsigned long hp300_mem_size = 0xffffffff-hp300_phys_ram_base;
-		m68k_cputype = CPU_68030;
-		m68k_fputype = FPU_68882;
-		m68k_memory[0].addr = hp300_phys_ram_base;
-		/* 0.5M fudge factor */
-		m68k_memory[0].size = hp300_mem_size-512*1024;
-		m68k_num_memory++;
-	}
+	/* The bootinfo is located right after the kernel bss */
+	m68k_parse_bootinfo((const struct bi_record *)&_end);
 
 	if (CPU_IS_040)
 		m68k_is040or060 = 4;
--- linux-2.6.10-rc1/include/asm-m68k/blinken.h	2001-10-22 01:50:47.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/blinken.h	2004-07-14 13:19:47.000000000 +0200
@@ -13,15 +13,20 @@
 #define _M68K_BLINKEN_H
 
 #include <asm/setup.h>
+#include <asm/io.h>
 
 #define HP300_LEDS		0xf001ffff
 
-static __inline__ void blinken_leds(int x)
+extern unsigned char ledstate;
+
+static __inline__ void blinken_leds(int on, int off)
 {
-  if (MACH_IS_HP300)
-  {
-    *((volatile unsigned char *)HP300_LEDS) = (x);
-  }
+	if (MACH_IS_HP300)
+	{
+		ledstate |= on;
+		ledstate &= ~off;
+		out_8(HP300_LEDS, ~ledstate);
+	}
 }
 
 #endif
--- linux-2.6.10-rc1/include/asm-m68k/bootinfo.h	2004-04-05 15:09:08.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/bootinfo.h	2004-07-14 13:19:47.000000000 +0200
@@ -213,7 +213,13 @@
 
 #define BI_APOLLO_MODEL         0x8000  /* model (u_long) */
 
+    /*
+     *  HP300-specific tags
+     */
 
+#define BI_HP300_MODEL		0x8000	/* model (u_long) */
+#define BI_HP300_UART_SCODE	0x8001	/* UART select code (u_long) */
+#define BI_HP300_UART_ADDR	0x8002	/* phys. addr of UART (u_long) */
 
     /*
      * Stuff for bootinfo interface versioning
@@ -255,6 +261,7 @@
 #define MVME16x_BOOTI_VERSION  MK_BI_VERSION( 2, 0 )
 #define BVME6000_BOOTI_VERSION MK_BI_VERSION( 2, 0 )
 #define Q40_BOOTI_VERSION      MK_BI_VERSION( 2, 0 )
+#define HP300_BOOTI_VERSION    MK_BI_VERSION( 2, 0 )
 
 #ifdef BOOTINFO_COMPAT_1_0
 
--- linux-2.6.10-rc1/include/asm-m68k/hp300hw.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/hp300hw.h	2004-07-09 22:52:30.000000000 +0200
@@ -0,0 +1,25 @@
+#ifndef _M68K_HP300HW_H
+#define _M68K_HP300HW_H
+
+extern unsigned long hp300_model;
+
+/* This information was taken from NetBSD */
+#define	HP_320		(0)	/* 16MHz 68020+HP MMU+16K external cache */
+#define	HP_330		(1)	/* 16MHz 68020+68851 MMU */
+#define	HP_340		(2)	/* 16MHz 68030 */
+#define	HP_345		(3)	/* 50MHz 68030+32K external cache */
+#define	HP_350		(4)	/* 25MHz 68020+HP MMU+32K external cache */
+#define	HP_360		(5)	/* 25MHz 68030 */
+#define	HP_370		(6)	/* 33MHz 68030+64K external cache */
+#define	HP_375		(7)	/* 50MHz 68030+32K external cache */
+#define	HP_380		(8)	/* 25MHz 68040 */
+#define	HP_385		(9)	/* 33MHz 68040 */
+
+#define	HP_400		(10)	/* 50MHz 68030+32K external cache */
+#define	HP_425T		(11)	/* 25MHz 68040 - model 425t */
+#define	HP_425S		(12)	/* 25MHz 68040 - model 425s */
+#define HP_425E		(13)	/* 25MHz 68040 - model 425e */
+#define HP_433T		(14)	/* 33MHz 68040 - model 433t */
+#define HP_433S		(15)	/* 33MHz 68040 - model 433s */
+
+#endif /* _M68K_HP300HW_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
