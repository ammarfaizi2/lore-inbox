Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265864AbSKFReQ>; Wed, 6 Nov 2002 12:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSKFReQ>; Wed, 6 Nov 2002 12:34:16 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:48168 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265866AbSKFRdu>; Wed, 6 Nov 2002 12:33:50 -0500
Message-ID: <3DC95400.8361C6CE@cinet.co.jp>
Date: Thu, 07 Nov 2002 02:40:16 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 3/17] support PC-9800 against 2.5.45-ac1 (core)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------04ABF53A6D87B3CD26C8AB7D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------04ABF53A6D87B3CD26C8AB7D
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch includes arch/i386/* that not merged.

diffstat:
[root@precia patch]# diffstat -p1 arch-i386.patch 
 arch/i386/Kconfig                       |   24 +++-
 arch/i386/Makefile                      |   15 ++
 arch/i386/kernel/setup.c                |   99 ----------------
 arch/i386/kernel/time.c                 |  115 ++-----------------
 arch/i386/kernel/timers/timer_pit.c     |   22 ++-
 arch/i386/kernel/timers/timer_tsc.c     |   92 +--------------
 arch/i386/kernel/traps.c                |   12 --
 arch/i386/mach-generic/calibrate_tsc.h  |   90 +++++++++++++++
 arch/i386/mach-generic/mach_resources.h |  113 ++++++++++++++++++
 arch/i386/mach-generic/mach_time.h      |  122 ++++++++++++++++++++
 arch/i386/mach-generic/mach_traps.h     |   29 ++++
 arch/i386/mach-pc9800/calibrate_tsc.h   |   71 +++++++++++
 arch/i386/mach-pc9800/do_timer.h        |   80 +++++++++++++
 arch/i386/mach-pc9800/mach_resources.h  |  192 ++++++++++++++++++++++++++++++++  arch/i386/mach-pc9800/mach_time.h       |  136 ++++++++++++++++++++++
 arch/i386/mach-pc9800/mach_traps.h      |   27 ++++
 arch/i386/mach-pc9800/smpboot_hooks.h   |   33 +++++
 arch/i386/mach-summit/calibrate_tsc.h   |    1 
 arch/i386/mach-summit/mach_resources.h  |    1 
 arch/i386/mach-summit/mach_time.h       |    1 
 arch/i386/mach-summit/mach_traps.h      |    1 
 arch/i386/mach-visws/calibrate_tsc.h    |    1 
 arch/i386/mach-visws/mach_resources.h   |    1 
 arch/i386/mach-visws/mach_time.h        |    1 
 arch/i386/mach-visws/mach_traps.h       |    1 
 arch/i386/mach-voyager/calibrate_tsc.h  |    1 
 arch/i386/mach-voyager/mach_resources.h |    1 
 arch/i386/mach-voyager/mach_time.h      |    1 
 arch/i386/mach-voyager/mach_traps.h     |    1 
 29 files changed, 992 insertions(+), 292 deletions(-)

-- 
Osamu Tomita
--------------04ABF53A6D87B3CD26C8AB7D
Content-Type: text/plain; charset=iso-2022-jp;
 name="arch-i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch-i386.patch"

diff -urN linux/arch/i386/Makefile linux98/arch/i386/Makefile
--- linux/arch/i386/Makefile	Tue Nov  5 10:16:18 2002
+++ linux98/arch/i386/Makefile	Tue Nov  5 16:35:51 2002
@@ -51,9 +51,13 @@
 ifdef CONFIG_VOYAGER
 MACHINE := mach-voyager
 else
+ifdef CONFIG_PC9800
+MACHINE	:= mach-pc9800
+else
 MACHINE	:= mach-generic
 endif
 endif
+endif
 
 ifdef CONFIG_X86_STACK_CHECK
 CFLAGS += -p
@@ -73,15 +77,20 @@
 CFLAGS += -Iarch/i386/$(MACHINE) -Iarch/i386/mach-defaults
 AFLAGS += -Iarch/i386/$(MACHINE) -Iarch/i386/mach-defaults
 
-makeboot = $(call descend,arch/i386/boot,$(1))
+ifndef CONFIG_PC9800
+ARCHDIR=arch/i386/boot
+else
+ARCHDIR=arch/i386/boot98
+endif
+makeboot = $(call descend,$(ARCHDIR),$(1))
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
 		clean archclean archmrproper
 
 all: bzImage
 
-BOOTIMAGE=arch/i386/boot/bzImage
-zImage zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
+BOOTIMAGE=$(ARCHDIR)/bzImage
+zImage zlilo zdisk: BOOTIMAGE=$(ARCHDIR)/zImage
 
 zImage bzImage: vmlinux
 	+@$(call makeboot,$(BOOTIMAGE))
diff -urN linux/arch/i386/Kconfig linux98/arch/i386/Kconfig
--- linux/arch/i386/Kconfig	Tue Nov  5 10:16:17 2002
+++ linux98/arch/i386/Kconfig	Tue Nov  5 17:08:26 2002
@@ -1004,6 +1004,12 @@
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
 #bool 'SGI Visual Workstation support' CONFIG_VISWS
+config PC9800
+	bool "NEC PC-9800 architecture support"
+	help
+	  To make kernel for NEC PC-9801/PC-9821 architecture, say Y.
+	  If say Y, kernel works -ONLY- on PC-9800 architecture.
+
 config X86_VISWS_APIC
 	bool
 	depends on VISWS
@@ -1096,7 +1102,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1112,7 +1118,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !VISWS
+	depends on !(VISWS || PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1460,6 +1466,7 @@
 
 config VGA_CONSOLE
 	bool "VGA text console"
+	depends on !PC9800
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
 	  display that complies with the generic VGA standard. Virtually
@@ -1473,6 +1480,7 @@
 
 config VIDEO_SELECT
 	bool "Video mode selection support"
+	depends on !PC9800
 	---help---
 	  This enables support for text mode selection on kernel startup. If
 	  you want to take advantage of some high-resolution text mode your
@@ -1486,6 +1494,18 @@
 	  Read the file <file:Documentation/svga.txt> for more information
 	  about the Video mode selection support. If unsure, say N.
 
+config GDC_CONSOLE
+	bool "PC-9800 GDC text console"
+	depends on PC9800
+	default y
+	help
+	  This enables support for PC-9800 standard text mode console.
+	  If use PC-9801/PC-9821, Say Y.
+
+config GDC_32BITACCESS
+	bool "Enable 32-bit access to text video RAM"
+	depends on GDC_CONSOLE
+
 if EXPERIMENTAL
 
 config MDA_CONSOLE
diff -urN linux/arch/i386/kernel/setup.c linux98/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Tue Nov  5 10:16:18 2002
+++ linux98/arch/i386/kernel/setup.c	Tue Nov  5 16:28:36 2002
@@ -20,6 +20,7 @@
  * This file handles the architecture-dependent parts of initialization
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
@@ -40,6 +41,7 @@
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include "setup_arch_pre.h"
+#include "mach_resources.h"
 
 static inline char * __init machine_specific_memory_setup(void);
 
@@ -97,98 +99,8 @@
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
 
-struct resource standard_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
-};
-#ifdef CONFIG_MELAN
-standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
-standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
-#endif
-
-#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
-
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
-static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
-
-/* System ROM resources */
-#define MAXROMS 6
-static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
-	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
-};
-
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
-
-static void __init probe_roms(void)
-{
-	int roms = 1;
-	unsigned long base;
-	unsigned char *romstart;
-
-	request_resource(&iomem_resource, rom_resources+0);
-
-	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
-	for (base = 0xC0000; base < 0xE0000; base += 2048) {
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
-			continue;
-		request_resource(&iomem_resource, rom_resources + roms);
-		roms++;
-		break;
-	}
-
-	/* Extension roms at C800:0000 - DFFF:0000 */
-	for (base = 0xC8000; base < 0xE0000; base += 2048) {
-		unsigned long length;
-
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
-			continue;
-		length = romstart[2] * 512;
-		if (length) {
-			unsigned int i;
-			unsigned char chksum;
-
-			chksum = 0;
-			for (i = 0; i < length; i++)
-				chksum += romstart[i];
-
-			/* Good checksum? */
-			if (!chksum) {
-				rom_resources[roms].start = base;
-				rom_resources[roms].end = base + length - 1;
-				rom_resources[roms].name = "Extension ROM";
-				rom_resources[roms].flags = IORESOURCE_BUSY;
-
-				request_resource(&iomem_resource, rom_resources + roms);
-				roms++;
-				if (roms >= MAXROMS)
-					return;
-			}
-		}
-	}
-
-	/* Final check for motherboard extension rom at E000:0000 */
-	base = 0xE0000;
-	romstart = isa_bus_to_virt(base);
-
-	if (romsignature(romstart)) {
-		rom_resources[roms].start = base;
-		rom_resources[roms].end = base + 65535;
-		rom_resources[roms].name = "Extension ROM";
-		rom_resources[roms].flags = IORESOURCE_BUSY;
-
-		request_resource(&iomem_resource, rom_resources + roms);
-	}
-}
 
 static void __init limit_regions (unsigned long long size)
 {
@@ -820,11 +732,8 @@
 			request_resource(res, &data_resource);
 		}
 	}
-	request_resource(&iomem_resource, &vram_resource);
 
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
+	mach_request_resource( );
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
@@ -904,6 +813,8 @@
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
+#elif defined(CONFIG_GDC_CONSOLE)
+	conswitchp = &gdc_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
diff -urN linux/arch/i386/kernel/time.c linux98/arch/i386/kernel/time.c
--- linux/arch/i386/kernel/time.c	Tue Nov  5 10:16:18 2002
+++ linux98/arch/i386/kernel/time.c	Tue Nov  5 16:28:36 2002
@@ -54,12 +54,15 @@
 #include <asm/processor.h>
 #include <asm/timer.h>
 
-#include <linux/mc146818rtc.h>
+#include "mach_time.h"
+
 #include <linux/timex.h>
 #include <linux/config.h>
 
 #include <asm/arch_hooks.h>
 
+#include "io_ports.h"
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -134,69 +137,13 @@
 	write_unlock_irq(&xtime_lock);
 }
 
-/*
- * In order to set the CMOS clock precisely, set_rtc_mmss has to be
- * called 500 ms after the second nowtime has started, because when
- * nowtime is written into the registers of the CMOS clock, it will
- * jump to the next second precisely 500 ms later. Check the Motorola
- * MC146818A or Dallas DS12887 data sheet for details.
- *
- * BUG: This routine does not handle hour overflow properly; it just
- *      sets the minutes. Usually you'll only notice that after reboot!
- */
 static int set_rtc_mmss(unsigned long nowtime)
 {
-	int retval = 0;
-	int real_seconds, real_minutes, cmos_minutes;
-	unsigned char save_control, save_freq_select;
+	int retval;
 
 	/* gets recalled with irq locally disabled */
 	spin_lock(&rtc_lock);
-	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
-	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
-	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-	cmos_minutes = CMOS_READ(RTC_MINUTES);
-	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		BCD_TO_BIN(cmos_minutes);
-
-	/*
-	 * since we're only adjusting minutes and seconds,
-	 * don't interfere with hour overflow. This avoids
-	 * messing with unknown time zones but requires your
-	 * RTC not to be off by more than 15 minutes
-	 */
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
-		real_minutes += 30;		/* correct for half hour time zone */
-	real_minutes %= 60;
-
-	if (abs(real_minutes - cmos_minutes) < 30) {
-		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-			BIN_TO_BCD(real_seconds);
-			BIN_TO_BCD(real_minutes);
-		}
-		CMOS_WRITE(real_seconds,RTC_SECONDS);
-		CMOS_WRITE(real_minutes,RTC_MINUTES);
-	} else {
-		printk(KERN_WARNING
-		       "set_rtc_mmss: can't update from %d to %d\n",
-		       cmos_minutes, real_minutes);
-		retval = -1;
-	}
-
-	/* The following flags have to be released exactly in this order,
-	 * otherwise the DS12887 (popular MC146818A clone with integrated
-	 * battery and quartz) will not reset the oscillator and will not
-	 * update precisely 500 ms later. You won't find this mentioned in
-	 * the Dallas Semiconductor data sheets, but who believes data
-	 * sheets anyway ...                           -- Markus Kuhn
-	 */
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+	retval = mach_set_rtc_mmss(nowtime);
 	spin_unlock(&rtc_lock);
 
 	return retval;
@@ -222,9 +169,9 @@
 		 * on an 82489DX-based system.
 		 */
 		spin_lock(&i8259A_lock);
-		outb(0x0c, 0x20);
+		outb(0x0c, PIC_MASTER_OCW3);
 		/* Ack the IRQ; AEOI will end it automatically. */
-		inb(0x20);
+		inb(PIC_MASTER_POLL);
 		spin_unlock(&i8259A_lock);
 	}
 #endif
@@ -238,14 +185,14 @@
 	 */
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
+	    (xtime.tv_nsec / 1000) >= TIME1 - ((unsigned) TICK_SIZE) / 2 &&
+	    (xtime.tv_nsec / 1000) <= TIME2 + ((unsigned) TICK_SIZE) / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
-	    
+
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
 		/* The PS/2 uses level-triggered interrupts.  You can't
@@ -290,43 +237,15 @@
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
-	unsigned int year, mon, day, hour, min, sec;
-	int i;
+	unsigned long retval;
 
 	spin_lock(&rtc_lock);
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
-		sec = CMOS_READ(RTC_SECONDS);
-		min = CMOS_READ(RTC_MINUTES);
-		hour = CMOS_READ(RTC_HOURS);
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
-		mon = CMOS_READ(RTC_MONTH);
-		year = CMOS_READ(RTC_YEAR);
-	} while (sec != CMOS_READ(RTC_SECONDS));
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	  {
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-	  }
+
+	retval = mach_get_cmos_time();
+
 	spin_unlock(&rtc_lock);
-	if ((year += 1900) < 1970)
-		year += 100;
-	return mktime(year, mon, day, hour, min, sec);
+
+	return retval;
 }
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
diff -urN linux/arch/i386/kernel/timers/timer_pit.c linux98/arch/i386/kernel/timers/timer_pit.c
--- linux/arch/i386/kernel/timers/timer_pit.c	Tue Nov  5 10:16:18 2002
+++ linux98/arch/i386/kernel/timers/timer_pit.c	Tue Nov  5 16:28:36 2002
@@ -15,6 +15,7 @@
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
+#include "io_ports.h"
 
 static int init_pit(void)
 {
@@ -63,7 +64,8 @@
 {
 	int count;
 
-	static int count_p = LATCH;    /* for the first call after boot */
+	static int count_p;
+	static int is_1st_boot = 1;    /* for the first call after boot */
 	static unsigned long jiffies_p = 0;
 
 	/*
@@ -71,12 +73,18 @@
 	 */
 	unsigned long jiffies_t;
 
+	/* for support LATCH is not constant */
+	if (is_1st_boot) {
+		is_1st_boot = 0;
+		count_p = LATCH;
+	}
+
 	/* gets recalled with irq locally disabled */
 	spin_lock(&i8253_lock);
 	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 
-	count = inb_p(0x40);	/* read the latched count */
+	count = inb_p(PIT_CH0);	/* read the latched count */
 
 	/*
 	 * We do this guaranteed double memory access instead of a _p 
@@ -84,13 +92,13 @@
 	 */
  	jiffies_t = jiffies;
 
-	count |= inb_p(0x40) << 8;
+	count |= inb_p(PIT_CH0) << 8;
 	
         /* VIA686a test code... reset the latch if count > max + 1 */
         if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
+                outb_p(0x34, PIT_MODE);
+                outb_p(LATCH & 0xff, PIT_CH0);
+                outb(LATCH >> 8, PIT_CH0);
                 count = LATCH - 1;
         }
 	
diff -urN linux/arch/i386/kernel/timers/timer_tsc.c linux98/arch/i386/kernel/timers/timer_tsc.c
--- linux/arch/i386/kernel/timers/timer_tsc.c	Tue Nov  5 10:16:18 2002
+++ linux98/arch/i386/kernel/timers/timer_tsc.c	Wed Nov  6 21:07:12 2002
@@ -12,6 +12,9 @@
 #include <asm/timer.h>
 #include <asm/io.h>
 
+#include "io_ports.h"
+#include "calibrate_tsc.h"
+
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
@@ -19,8 +22,6 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
@@ -61,7 +62,10 @@
 {
 	int count;
         int countmp;
-        static int count1=0, count2=LATCH;
+        static int count1=0, count2=0x7fff;
+
+	if (count2 == 0x7fff)
+		count2 = LATCH;
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
@@ -79,10 +83,10 @@
 	rdtscl(last_tsc_low);
 
 	spin_lock(&i8253_lock);
-	outb_p(0x00, 0x43);     /* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
-	count = inb_p(0x40);    /* read the latched count */
-	count |= inb(0x40) << 8;
+	count = inb_p(PIT_CH0);    /* read the latched count */
+	count |= inb(PIT_CH0) << 8;
 	spin_unlock(&i8253_lock);
 
 	if (pit_latch_buggy) {
@@ -104,83 +108,9 @@
 }
 
 
-/* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_LATCH	(5 * LATCH)
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
 static unsigned long __init calibrate_tsc(void)
 {
-       /* Set the Gate high, disable speaker */
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
-
-	/*
-	 * Now let's take care of CTC channel 2
-	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
-	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
-	 *
-	 * Some devices need a delay here.
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb_p(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-        outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		count = 0;
-		do {
-			count++;
-		} while ((inb(0x61) & 0x20) == 0);
-		rdtsc(endlow,endhigh);
-
-		last_tsc_low = endlow;
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
-	}
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-bad_ctc:
-	return 0;
+	return mach_calibrate_tsc();
 }
 
 
diff -urN linux/arch/i386/kernel/traps.c linux98/arch/i386/kernel/traps.c
--- linux/arch/i386/kernel/traps.c	Tue Nov  5 10:16:18 2002
+++ linux98/arch/i386/kernel/traps.c	Tue Nov  5 22:40:55 2002
@@ -49,6 +49,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 
+#include "mach_traps.h"
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -452,8 +454,7 @@
 	printk("You probably have a hardware problem with your RAM chips\n");
 
 	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
+	clear_mem_error(reason);
 }
 
 static void io_check_error(unsigned char reason, struct pt_regs * regs)
@@ -490,7 +491,7 @@
 
 static void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = inb(0x61);
+	unsigned char reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
@@ -514,10 +515,7 @@
 	 * Reassert NMI in case it became active meanwhile
 	 * as it's edge-triggered.
 	 */
-	outb(0x8f, 0x70);
-	inb(0x71);		/* dummy */
-	outb(0x0f, 0x70);
-	inb(0x71);		/* dummy */
+	reassert_nmi();
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
diff -urN linux/arch/i386/mach-generic/calibrate_tsc.h linux98/arch/i386/mach-generic/calibrate_tsc.h
--- linux/arch/i386/mach-generic/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/calibrate_tsc.h	Tue Nov  5 22:15:11 2002
@@ -0,0 +1,90 @@
+/*
+ *  arch/i386/mach-generic/calibrate_tsc.h
+ *
+ *  Machine specific calibrate_tsc() for generic.
+ *  Split out from timer_tsc.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+#ifndef _MACH_CALIBRATE_TSC_H
+#define _MACH_CALIBRATE_TSC_H
+
+#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+
+static inline unsigned long mach_calibrate_tsc(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 *
+	 * Some devices need a delay here.
+	 */
+	outb(0xb0, PIT_MODE);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, PIT_CH2);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, PIT_CH2);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+		last_tsc_low = endlow;
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
+}
+
+#endif /* !_MACH_CALIBRATE_TSC_H */
diff -urN linux/arch/i386/mach-generic/mach_resources.h linux98/arch/i386/mach-generic/mach_resources.h
--- linux/arch/i386/mach-generic/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_resources.h	Mon Oct 21 09:59:22 2002
@@ -0,0 +1,113 @@
+/*
+ *  arch/i386/mach-generic/mach_resources.h
+ *
+ *  Machine specific resource allocation for generic.
+ *  Split out from setup.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_RESOURCES_H
+#define _MACH_RESOURCES_H
+
+struct resource standard_io_resources[] = {
+	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
+	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
+	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
+	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
+	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
+	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
+	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
+	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
+};
+#ifdef CONFIG_MELAN
+standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
+standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
+#endif
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
+	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
+};
+
+#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+
+static inline void probe_roms(void)
+{
+	int roms = 1;
+	unsigned long base;
+	unsigned char *romstart;
+
+	request_resource(&iomem_resource, rom_resources+0);
+
+	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
+	for (base = 0xC0000; base < 0xE0000; base += 2048) {
+		romstart = isa_bus_to_virt(base);
+		if (!romsignature(romstart))
+			continue;
+		request_resource(&iomem_resource, rom_resources + roms);
+		roms++;
+		break;
+	}
+
+	/* Extension roms at C800:0000 - DFFF:0000 */
+	for (base = 0xC8000; base < 0xE0000; base += 2048) {
+		unsigned long length;
+
+		romstart = isa_bus_to_virt(base);
+		if (!romsignature(romstart))
+			continue;
+		length = romstart[2] * 512;
+		if (length) {
+			unsigned int i;
+			unsigned char chksum;
+
+			chksum = 0;
+			for (i = 0; i < length; i++)
+				chksum += romstart[i];
+
+			/* Good checksum? */
+			if (!chksum) {
+				rom_resources[roms].start = base;
+				rom_resources[roms].end = base + length - 1;
+				rom_resources[roms].name = "Extension ROM";
+				rom_resources[roms].flags = IORESOURCE_BUSY;
+
+				request_resource(&iomem_resource, rom_resources + roms);
+				roms++;
+				if (roms >= MAXROMS)
+					return;
+			}
+		}
+	}
+
+	/* Final check for motherboard extension rom at E000:0000 */
+	base = 0xE0000;
+	romstart = isa_bus_to_virt(base);
+
+	if (romsignature(romstart)) {
+		rom_resources[roms].start = base;
+		rom_resources[roms].end = base + 65535;
+		rom_resources[roms].name = "Extension ROM";
+		rom_resources[roms].flags = IORESOURCE_BUSY;
+
+		request_resource(&iomem_resource, rom_resources + roms);
+	}
+}
+
+static inline void mach_request_resource(void)
+{
+	int i;
+
+	request_resource(&iomem_resource, &vram_resource);
+
+	/* request I/O space for devices used on all i[345]86 PCs */
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources+i);
+
+}
+
+#endif /* !_MACH_RESOURCES_H */
diff -urN linux/arch/i386/mach-generic/mach_time.h linux98/arch/i386/mach-generic/mach_time.h
--- linux/arch/i386/mach-generic/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_time.h	Mon Oct 21 10:07:35 2002
@@ -0,0 +1,122 @@
+/*
+ *  arch/i386/mach-generic/mach_time.h
+ *
+ *  Machine specific set RTC function for generic.
+ *  Split out from time.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/mc146818rtc.h>
+
+/* for check timing call set_rtc_mmss() 500ms     */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+#define TIME1	500000
+#define TIME2	500000
+
+/*
+ * In order to set the CMOS clock precisely, set_rtc_mmss has to be
+ * called 500 ms after the second nowtime has started, because when
+ * nowtime is written into the registers of the CMOS clock, it will
+ * jump to the next second precisely 500 ms later. Check the Motorola
+ * MC146818A or Dallas DS12887 data sheet for details.
+ *
+ * BUG: This routine does not handle hour overflow properly; it just
+ *      sets the minutes. Usually you'll only notice that after reboot!
+ */
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	unsigned char save_control, save_freq_select;
+
+	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
+	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
+
+	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
+	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
+
+	cmos_minutes = CMOS_READ(RTC_MINUTES);
+	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+		BCD_TO_BIN(cmos_minutes);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
+		real_minutes += 30;		/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+			BIN_TO_BCD(real_seconds);
+			BIN_TO_BCD(real_minutes);
+		}
+		CMOS_WRITE(real_seconds,RTC_SECONDS);
+		CMOS_WRITE(real_minutes,RTC_MINUTES);
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* The following flags have to be released exactly in this order,
+	 * otherwise the DS12887 (popular MC146818A clone with integrated
+	 * battery and quartz) will not reset the oscillator and will not
+	 * update precisely 500 ms later. You won't find this mentioned in
+	 * the Dallas Semiconductor data sheets, but who believes data
+	 * sheets anyway ...                           -- Markus Kuhn
+	 */
+	CMOS_WRITE(save_control, RTC_CONTROL);
+	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+
+	return retval;
+}
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+	int i;
+
+	/* The Linux interpretation of the CMOS clock register contents:
+	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
+	 * RTC registers show the second which has precisely just started.
+	 * Let's hope other operating systems interpret the RTC the same way.
+	 */
+	/* read RTC exactly on falling edge of update flag */
+	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+			break;
+	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+			break;
+	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+		sec = CMOS_READ(RTC_SECONDS);
+		min = CMOS_READ(RTC_MINUTES);
+		hour = CMOS_READ(RTC_HOURS);
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		mon = CMOS_READ(RTC_MONTH);
+		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+	  {
+	    BCD_TO_BIN(sec);
+	    BCD_TO_BIN(min);
+	    BCD_TO_BIN(hour);
+	    BCD_TO_BIN(day);
+	    BCD_TO_BIN(mon);
+	    BCD_TO_BIN(year);
+	  }
+	if ((year += 1900) < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+#endif /* !_MACH_TIME_H */
diff -urN linux/arch/i386/mach-generic/mach_traps.h linux98/arch/i386/mach-generic/mach_traps.h
--- linux/arch/i386/mach-generic/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_traps.h	Tue Nov  5 22:42:05 2002
@@ -0,0 +1,29 @@
+/*
+ *  arch/i386/mach-generic/mach_traps.h
+ *
+ *  Machine specific NMI handling for generic.
+ *  Split out from traps.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	reason = (reason & 0xf) | 4;
+	outb(reason, 0x61);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return inb(0x61);
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x8f, 0x70);
+	inb(0x71);		/* dummy */
+	outb(0x0f, 0x70);
+	inb(0x71);		/* dummy */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -urN linux/arch/i386/mach-pc9800/calibrate_tsc.h linux98/arch/i386/mach-pc9800/calibrate_tsc.h
--- linux/arch/i386/mach-pc9800/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/calibrate_tsc.h	Tue Nov  5 22:19:50 2002
@@ -0,0 +1,71 @@
+/*
+ *  arch/i386/mach-pc9800/calibrate_tsc.h
+ *
+ *  Machine specific calibrate_tsc() for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C.
+ * PC-9800:
+ *  CTC cannot be used because some models (especially
+ *  note-machines) may disable clock to speaker channel (#1)
+ *  unless speaker is enabled.  We use ARTIC instead.
+ */
+#ifndef _MACH_CALIBRATE_TSC_H
+#define _MACH_CALIBRATE_TSC_H
+
+#define CALIBRATE_LATCH	(5 * 307200/HZ) /* 0.050sec * 307200Hz = 15360 */
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+
+static inline unsigned long mach_calibrate_tsc(void)
+{
+
+	unsigned long startlow, starthigh;
+	unsigned long endlow, endhigh;
+	unsigned short count;
+
+	for (count = inw(0x5c); inw(0x5c) == count; )
+		;
+	rdtsc(startlow,starthigh);
+	count = inw(0x5c);
+	while ((unsigned short)(inw(0x5c) - count) < CALIBRATE_LATCH)
+		;
+	rdtsc(endlow,endhigh);
+
+	last_tsc_low = endlow;
+
+	/* 64-bit subtract - gcc just messes up with long longs */
+	__asm__("subl %2,%0\n\t"
+		"sbbl %3,%1"
+		:"=a" (endlow), "=d" (endhigh)
+		:"g" (startlow), "g" (starthigh),
+		 "0" (endlow), "1" (endhigh));
+
+	/* Error: ECPUTOOFAST */
+	if (endhigh)
+		goto bad_ctc;
+
+	/* Error: ECPUTOOSLOW */
+	if (endlow <= CALIBRATE_TIME)
+		goto bad_ctc;
+
+	__asm__("divl %2"
+		:"=a" (endlow), "=d" (endhigh)
+		:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+	return endlow;
+
+	/*
+ 	* The CTC wasn't reliable: we got a hit on the very first read,
+ 	* or the CPU was so fast/slow that the quotient wouldn't fit in
+ 	* 32 bits..
+ 	*/
+bad_ctc:
+	return 0;
+}
+
+#endif /* !_MACH_CALIBRATE_TSC_H */
diff -urN linux/arch/i386/mach-pc9800/do_timer.h linux98/arch/i386/mach-pc9800/do_timer.h
--- linux/arch/i386/mach-pc9800/do_timer.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/do_timer.h	Wed Oct 16 13:20:29 2002
@@ -0,0 +1,80 @@
+/* defines for inline arch setup functions */
+
+/**
+ * do_timer_interrupt_hook - hook into timer tick
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	This hook is called immediately after the timer interrupt is ack'd.
+ *	It's primary purpose is to allow architectures that don't possess
+ *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	do_timer(regs);
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	x86_do_profile(regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+}
+
+
+/* you can safely undefine this if you don't have the Neptune chipset */
+
+#define BUGGY_NEPTUN_TIMER
+
+/**
+ * do_timer_overflow - process a detected timer overflow condition
+ * @count:	hardware timer interrupt count on overflow
+ *
+ * Description:
+ *	This call is invoked when the jiffies count has not incremented but
+ *	the hardware timer interrupt has.  It means that a timer tick interrupt
+ *	came along while the previous one was pending, thus a tick was missed
+ **/
+static inline int do_timer_overflow(int count)
+{
+	int i;
+
+	spin_lock(&i8259A_lock);
+	/*
+	 * This is tricky when I/O APICs are used;
+	 * see do_timer_interrupt().
+	 */
+	i = inb(0x00);
+	spin_unlock(&i8259A_lock);
+	
+	/* assumption about timer being IRQ0 */
+	if (i & 0x01) {
+		/*
+		 * We cannot detect lost timer interrupts ... 
+		 * well, that's why we call them lost, don't we? :)
+		 * [hmm, on the Pentium and Alpha we can ... sort of]
+		 */
+		count -= LATCH;
+	} else {
+#ifdef BUGGY_NEPTUN_TIMER
+		/*
+		 * for the Neptun bug we know that the 'latch'
+		 * command doesnt latch the high and low value
+		 * of the counter atomically. Thus we have to 
+		 * substract 256 from the counter 
+		 * ... funny, isnt it? :)
+		 */
+		
+		count -= 256;
+#else
+		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+#endif
+	}
+	return count;
+}
diff -urN linux/arch/i386/mach-pc9800/mach_resources.h linux98/arch/i386/mach-pc9800/mach_resources.h
--- linux/arch/i386/mach-pc9800/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_resources.h	Sat Oct 26 17:35:19 2002
@@ -0,0 +1,192 @@
+/*
+ *  arch/i386/mach-pc9800/mach_resources.h
+ *
+ *  Machine specific resource allocation for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_RESOURCES_H
+#define _MACH_RESOURCES_H
+
+static char str_pic1[] = "pic1";
+static char str_dma[] = "dma";
+static char str_pic2[] = "pic2";
+static char str_calender_clock[] = "calender clock";
+static char str_system[] = "system";
+static char str_nmi_control[] = "nmi control";
+static char str_kanji_rom[] = "kanji rom";
+static char str_keyboard[] = "keyboard";
+static char str_text_gdc[] = "text gdc";
+static char str_crtc[] = "crtc";
+static char str_timer[] = "timer";
+static char str_graphic_gdc[] = "graphic gdc";
+static char str_dma_ex_bank[] = "dma ex. bank";
+static char str_beep_freq[] = "beep freq.";
+static char str_mouse_pio[] = "mouse pio";
+struct resource standard_io_resources[] = {
+	{ str_pic1, 0x00, 0x00, IORESOURCE_BUSY },
+	{ str_dma, 0x01, 0x01, IORESOURCE_BUSY },
+	{ str_pic1, 0x02, 0x02, IORESOURCE_BUSY },
+	{ str_dma, 0x03, 0x03, IORESOURCE_BUSY },
+	{ str_dma, 0x05, 0x05, IORESOURCE_BUSY },
+	{ str_dma, 0x07, 0x07, IORESOURCE_BUSY },
+	{ str_pic2, 0x08, 0x08, IORESOURCE_BUSY },
+	{ str_dma, 0x09, 0x09, IORESOURCE_BUSY },
+	{ str_pic2, 0x0a, 0x0a, IORESOURCE_BUSY },
+	{ str_dma, 0x0b, 0x0b, IORESOURCE_BUSY },
+	{ str_dma, 0x0d, 0x0d, IORESOURCE_BUSY },
+	{ str_dma, 0x0f, 0x0f, IORESOURCE_BUSY },
+	{ str_dma, 0x11, 0x11, IORESOURCE_BUSY },
+	{ str_dma, 0x13, 0x13, IORESOURCE_BUSY },
+	{ str_dma, 0x15, 0x15, IORESOURCE_BUSY },
+	{ str_dma, 0x17, 0x17, IORESOURCE_BUSY },
+	{ str_dma, 0x19, 0x19, IORESOURCE_BUSY },
+	{ str_dma, 0x1b, 0x1b, IORESOURCE_BUSY },
+	{ str_dma, 0x1d, 0x1d, IORESOURCE_BUSY },
+	{ str_dma, 0x1f, 0x1f, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x20, 0x20, 0 },
+	{ str_dma, 0x21, 0x21, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x22, 0x22, 0 },
+	{ str_dma, 0x23, 0x23, IORESOURCE_BUSY },
+	{ str_dma, 0x25, 0x25, IORESOURCE_BUSY },
+	{ str_dma, 0x27, 0x27, IORESOURCE_BUSY },
+	{ str_dma, 0x29, 0x29, IORESOURCE_BUSY },
+	{ str_dma, 0x2b, 0x2b, IORESOURCE_BUSY },
+	{ str_dma, 0x2d, 0x2d, IORESOURCE_BUSY },
+	{ str_system, 0x31, 0x31, IORESOURCE_BUSY },
+	{ str_system, 0x33, 0x33, IORESOURCE_BUSY },
+	{ str_system, 0x35, 0x35, IORESOURCE_BUSY },
+	{ str_system, 0x37, 0x37, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x50, 0x50, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x52, 0x52, IORESOURCE_BUSY },
+	{ "time stamp", 0x5c, 0x5f, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa1, 0xa1, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa3, 0xa3, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa5, 0xa5, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa7, 0xa7, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa9, 0xa9, IORESOURCE_BUSY },
+	{ str_keyboard, 0x41, 0x41, IORESOURCE_BUSY },
+	{ str_keyboard, 0x43, 0x43, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x60, 0x60, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x62, 0x62, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x64, 0x64, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x66, 0x66, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x68, 0x68, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6a, 0x6a, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6c, 0x6c, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6e, 0x6e, IORESOURCE_BUSY },
+	{ str_crtc, 0x70, 0x70, IORESOURCE_BUSY },
+	{ str_crtc, 0x72, 0x72, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x76, 0x76, IORESOURCE_BUSY },
+	{ str_crtc, 0x78, 0x78, IORESOURCE_BUSY },
+	{ str_crtc, 0x7a, 0x7a, IORESOURCE_BUSY },
+	{ str_timer, 0x71, 0x71, IORESOURCE_BUSY },
+	{ str_timer, 0x73, 0x73, IORESOURCE_BUSY },
+	{ str_timer, 0x75, 0x75, IORESOURCE_BUSY },
+	{ str_timer, 0x77, 0x77, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa0, 0xa0, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa2, 0xa2, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa4, 0xa4, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa6, 0xa6, IORESOURCE_BUSY },
+	{ "cpu", 0xf0, 0xf7, IORESOURCE_BUSY },
+	{ "fpu", 0xf8, 0xff, IORESOURCE_BUSY },
+	{ str_dma_ex_bank, 0x0e05, 0x0e05, 0 },
+	{ str_dma_ex_bank, 0x0e07, 0x0e07, 0 },
+	{ str_dma_ex_bank, 0x0e09, 0x0e09, 0 },
+	{ str_dma_ex_bank, 0x0e0b, 0x0e0b, 0 },
+	{ str_beep_freq, 0x3fd9, 0x3fd9, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdb, 0x3fdb, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdd, 0x3fdd, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdf, 0x3fdf, IORESOURCE_BUSY },
+	/* All PC-9800 have (exactly) one mouse interface.  */
+	{ str_mouse_pio, 0x7fd9, 0x7fd9, 0 },
+	{ str_mouse_pio, 0x7fdb, 0x7fdb, 0 },
+	{ str_mouse_pio, 0x7fdd, 0x7fdd, 0 },
+	{ str_mouse_pio, 0x7fdf, 0x7fdf, 0 },
+	{ "mouse timer", 0xbfdb, 0xbfdb, 0 },
+	{ "mouse irq", 0x98d7, 0x98d7, 0 },
+};
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource tvram_resource = { "Text VRAM/CG window", 0xa0000, 0xa4fff, IORESOURCE_BUSY };
+static struct resource gvram_brg_resource = { "Graphic VRAM (B/R/G)", 0xa8000, 0xbffff, IORESOURCE_BUSY };
+static struct resource gvram_e_resource = { "Graphic VRAM (E)", 0xe0000, 0xe7fff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xe8000, 0xfffff, IORESOURCE_BUSY }
+};
+
+static inline void probe_roms(void)
+{
+	int roms = 1;
+	int i;
+	__u8 *xrom_id;
+
+	request_resource(&iomem_resource, rom_resources+0);
+
+	xrom_id = (__u8 *) isa_bus_to_virt(PC9800SCA_XROM_ID + 0x10);
+
+	for (i = 0; i < 16; i++) {
+		if (xrom_id[i] & 0x80) {
+			int j;
+
+			for (j = i + 1; j < 16 && (xrom_id[j] & 0x80); j++)
+				;
+			rom_resources[roms].start = 0x0d0000 + i * 0x001000;
+			rom_resources[roms].end = 0x0d0000 + j * 0x001000 - 1;
+			rom_resources[roms].name = "Extension ROM";
+			rom_resources[roms].flags = IORESOURCE_BUSY;
+
+			request_resource(&iomem_resource,
+					  rom_resources + roms);
+			if (++roms >= MAXROMS)
+				return;
+		}
+	}
+}
+
+static inline void mach_request_resource(void)
+{
+	int i;
+
+	if (PC9800_HIGHRESO_P()) {
+		tvram_resource.start = 0xe0000;
+		tvram_resource.end   = 0xe4fff;
+		gvram_brg_resource.name  = "Graphic VRAM";
+		gvram_brg_resource.start = 0xc0000;
+		gvram_brg_resource.end   = 0xdffff;
+	}
+
+	request_resource(&iomem_resource, &tvram_resource);
+	request_resource(&iomem_resource, &gvram_brg_resource);
+	if (!PC9800_HIGHRESO_P())
+		request_resource(&iomem_resource, &gvram_e_resource);
+
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources + i);
+
+	if (PC9800_HIGHRESO_P() || PC9800_9821_P()) {
+		static char graphics[] = "graphics";
+		static struct resource graphics_resources[] = {
+			{ graphics, 0x9a0, 0x9a0, 0 },
+			{ graphics, 0x9a2, 0x9a2, 0 },
+			{ graphics, 0x9a4, 0x9a4, 0 },
+			{ graphics, 0x9a6, 0x9a6, 0 },
+			{ graphics, 0x9a8, 0x9a8, 0 },
+			{ graphics, 0x9aa, 0x9aa, 0 },
+			{ graphics, 0x9ac, 0x9ac, 0 },
+			{ graphics, 0x9ae, 0x9ae, 0 },
+		};
+
+#define GRAPHICS_RESOURCES (sizeof(graphics_resources)/sizeof(struct resource))
+
+		for (i = 0; i < GRAPHICS_RESOURCES; i++)
+			request_resource(&ioport_resource, graphics_resources + i);
+	}
+}
+
+#endif /* !_MACH_RESOURCES_H */
diff -urN linux/arch/i386/mach-pc9800/mach_time.h linux98/arch/i386/mach-pc9800/mach_time.h
--- linux/arch/i386/mach-pc9800/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_time.h	Mon Oct 21 11:23:06 2002
@@ -0,0 +1,136 @@
+/*
+ *  arch/i386/mach-pc9800/mach_time.h
+ *
+ *  Machine specific set RTC function for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/upd4990a.h>
+
+/* for check timing call set_rtc_mmss() */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+/*
+ * Because PC-9800's RTC (NEC uPD4990A) does not allow setting
+ * time partially, we always have to read-modify-write the
+ * entire time (including year) so that set_rtc_mmss() will
+ * take quite much time to execute.  You may want to relax
+ * RTC resetting interval (currently ~11 minuts)...
+ */
+#define TIME1	1000000
+#define TIME2	0
+
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	struct upd4990a_raw_data data;
+
+	upd4990a_get_time(&data, 1);
+	cmos_minutes = (data.min >> 4) * 10 + (data.min & 0xf);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1)
+		real_minutes += 30;	/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		u8 temp_seconds = (real_seconds / 10) * 16 + real_seconds % 10;
+		u8 temp_minutes = (real_minutes / 10) * 16 + real_minutes % 10;
+
+		if (data.sec != temp_seconds || data.min != temp_minutes) {
+			data.sec = temp_seconds;
+			data.min = temp_minutes;
+			upd4990a_set_time(&data, 1);
+		}
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* uPD4990A users' manual says we should issue Register Hold
+	 * command after reading time, or future Time Read command
+	 * may not work.  When we have set the time, this also starts
+	 * the clock.
+	 */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	return retval;
+}
+
+#define RTC_SANITY_CHECK
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	int i;
+	u8 prev, cur;
+	unsigned int year;
+#ifdef RTC_SANITY_CHECK
+	int retry_count;
+#endif
+
+	struct upd4990a_raw_data data;
+
+#ifdef RTC_SANITY_CHECK
+	retry_count = 0;
+ retry:
+#endif
+	/* Connect uPD4990A's DATA OUT pin to its 1Hz reference clock. */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	/* Catch rising edge of reference clock.  */
+	prev = ~UPD4990A_READ_DATA();
+	for (i = 0; i < 1800000; i++) { /* may take up to 1 second... */
+		__asm__ ("outb %%al,%0" : : "N" (0x5f)); /* 0.6usec delay */
+		cur = UPD4990A_READ_DATA();
+		if (!(prev & cur & 1))
+			break;
+		prev = ~cur;
+	}
+
+	upd4990a_get_time(&data, 0);
+
+#ifdef RTC_SANITY_CHECK
+# define BCD_VALID_P(x, hi)	(((x) & 0x0f) <= 9 && (x) <= 0x ## hi)
+# define DATA			((const unsigned char *) &data)
+
+	if (!BCD_VALID_P(data.sec, 59) ||
+	    !BCD_VALID_P(data.min, 59) ||
+	    !BCD_VALID_P(data.hour, 23) ||
+	    data.mday == 0 || !BCD_VALID_P(data.mday, 31) ||
+	    data.wday > 6 ||
+	    data.mon < 1 || 12 < data.mon ||
+	    !BCD_VALID_P(data.year, 99)) {
+		printk(KERN_ERR "RTC clock data is invalid! "
+			"(%02X %02X %02X %02X %02X %02X) - ",
+			DATA[0], DATA[1], DATA[2], DATA[3], DATA[4], DATA[5]);
+		if (++retry_count < 3) {
+			printk("retrying (%d)\n", retry_count);
+			goto retry;
+		}
+		printk("giving up, continuing\n");
+	}
+
+# undef BCD_VALID_P
+# undef DATA
+#endif /* RTC_SANITY_CHECK */
+
+#define CVT(x)	(((x) & 0xF) + ((x) >> 4) * 10)
+	if ((year = CVT(data.year) + 1900) < 1995)
+		year += 100;
+	return mktime(year, data.mon, CVT(data.mday),
+		       CVT(data.hour), CVT(data.min), CVT(data.sec));
+#undef CVT
+}
+
+#endif /* !_MACH_TIME_H */
diff -urN linux/arch/i386/mach-pc9800/mach_traps.h linux98/arch/i386/mach-pc9800/mach_traps.h
--- linux/arch/i386/mach-pc9800/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_traps.h	Tue Nov  5 22:46:55 2002
@@ -0,0 +1,27 @@
+/*
+ *  arch/i386/mach-pc9800/mach_traps.h
+ *
+ *  Machine specific NMI handling for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	outb(0x08, 0x37);
+	outb(0x09, 0x37);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return (inb(0x33) & 6) ? 0x80 : 0;
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x09, 0x50);	/* disable NMI once */
+	outb(0x09, 0x52);	/* re-enable it */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -urN linux/arch/i386/mach-pc9800/smpboot_hooks.h linux98/arch/i386/mach-pc9800/smpboot_hooks.h
--- linux/arch/i386/mach-pc9800/smpboot_hooks.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/smpboot_hooks.h	Sun Sep 22 06:56:46 2002
@@ -0,0 +1,33 @@
+/* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
+ * which needs to alter them. */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+	io_apic_irqs = 0;
+}
+
+static inline void smpboot_setup_warm_reset_vector(void)
+{
+	/*
+	 * Install writable page 0 entry to set BIOS data area.
+	 */
+	local_flush_tlb();
+
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	outb(0x0f, 0x37);	/* SHUT0 = 1 */
+
+	*((volatile long *) phys_to_virt(0x404)) = 0;
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+	/*
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+}
diff -urN linux/arch/i386/mach-summit/calibrate_tsc.h linux98/arch/i386/mach-summit/calibrate_tsc.h
--- linux/arch/i386/mach-summit/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/calibrate_tsc.h	Mon Oct 21 02:46:34 2002
@@ -0,0 +1 @@
+#include "../mach-generic/calibrate_tsc.h"
diff -urN linux/arch/i386/mach-summit/mach_resources.h linux98/arch/i386/mach-summit/mach_resources.h
--- linux/arch/i386/mach-summit/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_resources.h	Sun Oct 20 18:11:27 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_resources.h"
diff -urN linux/arch/i386/mach-summit/mach_time.h linux98/arch/i386/mach-summit/mach_time.h
--- linux/arch/i386/mach-summit/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_time.h	Sun Oct 20 20:00:44 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_time.h"
diff -urN linux/arch/i386/mach-summit/mach_traps.h linux98/arch/i386/mach-summit/mach_traps.h
--- linux/arch/i386/mach-summit/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_traps.h	Mon Oct 21 02:48:48 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_traps.h"
diff -urN linux/arch/i386/mach-visws/calibrate_tsc.h linux98/arch/i386/mach-visws/calibrate_tsc.h
--- linux/arch/i386/mach-visws/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/calibrate_tsc.h	Mon Oct 21 02:46:34 2002
@@ -0,0 +1 @@
+#include "../mach-generic/calibrate_tsc.h"
diff -urN linux/arch/i386/mach-visws/mach_resources.h linux98/arch/i386/mach-visws/mach_resources.h
--- linux/arch/i386/mach-visws/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_resources.h	Sun Oct 20 18:11:27 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_resources.h"
diff -urN linux/arch/i386/mach-visws/mach_time.h linux98/arch/i386/mach-visws/mach_time.h
--- linux/arch/i386/mach-visws/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_time.h	Sun Oct 20 20:00:44 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_time.h"
diff -urN linux/arch/i386/mach-visws/mach_traps.h linux98/arch/i386/mach-visws/mach_traps.h
--- linux/arch/i386/mach-visws/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_traps.h	Mon Oct 21 02:48:48 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_traps.h"
diff -urN linux/arch/i386/mach-voyager/calibrate_tsc.h linux98/arch/i386/mach-voyager/calibrate_tsc.h
--- linux/arch/i386/mach-voyager/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-voyager/calibrate_tsc.h	Mon Oct 21 02:46:34 2002
@@ -0,0 +1 @@
+#include "../mach-generic/calibrate_tsc.h"
diff -urN linux/arch/i386/mach-voyager/mach_resources.h linux98/arch/i386/mach-voyager/mach_resources.h
--- linux/arch/i386/mach-voyager/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-voyager/mach_resources.h	Sun Oct 20 18:11:27 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_resources.h"
diff -urN linux/arch/i386/mach-voyager/mach_time.h linux98/arch/i386/mach-voyager/mach_time.h
--- linux/arch/i386/mach-voyager/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-voyager/mach_time.h	Sun Oct 20 20:00:44 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_time.h"
diff -urN linux/arch/i386/mach-voyager/mach_traps.h linux98/arch/i386/mach-voyager/mach_traps.h
--- linux/arch/i386/mach-voyager/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-voyager/mach_traps.h	Mon Oct 21 02:48:48 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_traps.h"

--------------04ABF53A6D87B3CD26C8AB7D--

