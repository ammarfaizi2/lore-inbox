Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTBLNbl>; Wed, 12 Feb 2003 08:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbTBLNbl>; Wed, 12 Feb 2003 08:31:41 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:29568 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267131AbTBLNbK>; Wed, 12 Feb 2003 08:31:10 -0500
Date: Wed, 12 Feb 2003 22:39:36 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (10/34) arch/i386
Message-ID: <20030212133936.GK1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (10/34).

Core patches for PC98 under arch/i386 and include/asm-i386/mach-* directory.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/arch/i386/Kconfig linux98-2.5.60/arch/i386/Kconfig
--- linux-2.5.50-ac1/arch/i386/Kconfig	2003-02-11 03:38:00.000000000 +0900
+++ linux98-2.5.60/arch/i386/Kconfig	2003-02-11 10:52:52.000000000 +0900
@@ -75,6 +75,12 @@
 
 	  If you don't have one of these computers, you should say N here.
 
+config X86_PC9800
+	bool "PC-9800 (NEC)"
+	help
+	  To make kernel for NEC PC-9801/PC-9821 sub-architecture, say Y.
+	  If say Y, kernel works -ONLY- on PC-9800 architecture.
+
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
 	help
@@ -1178,7 +1184,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1196,7 +1202,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
diff -Nru linux-2.5.50-ac1/arch/i386/Makefile linux98-2.5.60/arch/i386/Makefile
--- linux-2.5.50-ac1/arch/i386/Makefile	2003-02-11 09:47:18.000000000 +0900
+++ linux98-2.5.60/arch/i386/Makefile	2003-02-11 11:05:20.000000000 +0900
@@ -64,6 +64,10 @@
 mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
 mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
+# PC-9800 subarch support
+mflags-$(CONFIG_X86_PC9800)	:= -Iinclude/asm-i386/mach-pc9800
+mcore-$(CONFIG_X86_PC9800)	:= mach-pc9800
+
 # BIGSMP subarch support
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
 mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
@@ -89,14 +93,18 @@
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
 
+ifeq ($(CONFIG_X86_PC9800),y)
+boot := arch/i386/boot98
+else
 boot := arch/i386/boot
+endif
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install
 
 all: bzImage
 
-BOOTIMAGE=arch/i386/boot/bzImage
-zImage zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
+BOOTIMAGE=$(boot)/bzImage
+zImage zlilo zdisk: BOOTIMAGE=$(boot)/zImage
 
 zImage bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
@@ -117,7 +125,7 @@
 	$(Q)$(MAKE) $(clean)=arch/i386/boot98
 
 define archhelp
-  echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
+  echo  '* bzImage	- Compressed kernel image ($(boot)/bzImage)'
   echo  '  install	- Install kernel using'
   echo  '		   (your) ~/bin/installkernel or'
   echo  '		   (distribution) /sbin/installkernel or'
diff -Nru linux/arch/i386/kernel/setup.c linux98/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	2002-12-26 13:40:40.000000000 +0900
+++ linux98/arch/i386/kernel/setup.c	2002-12-26 14:01:32.000000000 +0900
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
 
 int disable_pse __initdata = 0;
 
@@ -102,98 +104,8 @@
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
@@ -826,11 +738,8 @@
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
@@ -911,6 +820,8 @@
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
+#elif defined(CONFIG_GDC_CONSOLE)
+	conswitchp = &gdc_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
diff -Nru linux-2.5.60/arch/i386/kernel/time.c linux98-2.5.60/arch/i386/kernel/time.c
--- linux-2.5.60/arch/i386/kernel/time.c	2003-02-11 03:38:37.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/time.c	2003-02-11 10:52:52.000000000 +0900
@@ -55,12 +55,15 @@
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
 
@@ -137,69 +140,13 @@
 	write_sequnlock_irq(&xtime_lock);
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
@@ -225,9 +172,9 @@
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
@@ -241,14 +188,14 @@
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
@@ -329,43 +276,15 @@
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
diff -Nru linux-2.5.60/arch/i386/kernel/timers/timer_pit.c linux98-2.5.60/arch/i386/kernel/timers/timer_pit.c
--- linux-2.5.60/arch/i386/kernel/timers/timer_pit.c	2003-02-11 03:38:51.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/timers/timer_pit.c	2003-02-11 11:15:22.000000000 +0900
@@ -16,6 +16,7 @@
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
+#include "io_ports.h"
 
 static int init_pit(void)
 {
@@ -77,7 +78,8 @@
 {
 	int count;
 	unsigned long flags;
-	static int count_p = LATCH;    /* for the first call after boot */
+	static int count_p;
+	static int is_1st_boot = 1;    /* for the first call after boot */
 	static unsigned long jiffies_p = 0;
 
 	/*
@@ -85,11 +87,17 @@
 	 */
 	unsigned long jiffies_t;
 
+	/* for support LATCH is not constant */
+	if (is_1st_boot) {
+		is_1st_boot = 0;
+		count_p = LATCH;
+	}
+
 	spin_lock_irqsave(&i8253_lock, flags);
 	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 
-	count = inb_p(0x40);	/* read the latched count */
+	count = inb_p(PIT_CH0);	/* read the latched count */
 
 	/*
 	 * We do this guaranteed double memory access instead of a _p 
@@ -97,13 +105,13 @@
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
 	
diff -Nru linux/arch/i386/kernel/timers/timer_tsc.c linux98/arch/i386/kernel/timers/timer_tsc.c
--- linux/arch/i386/kernel/timers/timer_tsc.c	2003-01-14 14:59:01.000000000 +0900
+++ linux98/arch/i386/kernel/timers/timer_tsc.c	2003-01-14 22:42:14.000000000 +0900
@@ -14,6 +14,9 @@
 /* processor.h for distable_tsc flag */
 #include <asm/processor.h>
 
+#include "io_ports.h"
+#include "calibrate_tsc.h"
+
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
@@ -22,8 +25,6 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
@@ -64,7 +65,12 @@
 {
 	int count;
 	int countmp;
-	static int count1=0, count2=LATCH;
+	static int count1=0, count2, initialize = 1;
+
+	if (initialize) {
+		count2 = LATCH;
+		initialize = 0;
+	}
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
@@ -82,10 +88,10 @@
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
@@ -118,83 +124,9 @@
 	} while ((now-bclock) < loops);
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
-	outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
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
 
 
diff -Nru linux/arch/i386/kernel/traps.c linux98/arch/i386/kernel/traps.c
--- linux/arch/i386/kernel/traps.c	2003-01-14 09:33:33.000000000 +0900
+++ linux98/arch/i386/kernel/traps.c	2003-01-14 09:52:36.000000000 +0900
@@ -50,6 +50,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 
+#include "mach_traps.h"
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -387,8 +389,7 @@
 	printk("You probably have a hardware problem with your RAM chips\n");
 
 	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
+	clear_mem_error(reason);
 }
 
 static void io_check_error(unsigned char reason, struct pt_regs * regs)
@@ -425,7 +426,7 @@
 
 static void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = inb(0x61);
+	unsigned char reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
@@ -449,10 +450,7 @@
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
diff -Nru linux/include/asm-i386/mach-default/calibrate_tsc.h linux98/include/asm-i386/mach-default/calibrate_tsc.h
--- linux/include/asm-i386/mach-default/calibrate_tsc.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/calibrate_tsc.h	2002-11-05 22:15:11.000000000 +0900
@@ -0,0 +1,90 @@
+/*
+ *  include/asm-i386/mach-default/calibrate_tsc.h
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
diff -Nru linux/include/asm-i386/mach-default/mach_resources.h linux98/include/asm-i386/mach-default/mach_resources.h
--- linux/include/asm-i386/mach-default/mach_resources.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_resources.h	2002-10-21 09:59:22.000000000 +0900
@@ -0,0 +1,113 @@
+/*
+ *  include/asm-i386/mach-default/mach_resources.h
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
diff -Nru linux/include/asm-i386/mach-default/mach_time.h linux98/include/asm-i386/mach-default/mach_time.h
--- linux/include/asm-i386/mach-default/mach_time.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_time.h	2002-10-21 10:07:35.000000000 +0900
@@ -0,0 +1,122 @@
+/*
+ *  include/asm-i386/mach-default/mach_time.h
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
diff -Nru linux/include/asm-i386/mach-default/mach_traps.h linux98/include/asm-i386/mach-default/mach_traps.h
--- linux/include/asm-i386/mach-default/mach_traps.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_traps.h	2002-11-05 22:42:05.000000000 +0900
@@ -0,0 +1,29 @@
+/*
+ *  include/asm-i386/mach-default/mach_traps.h
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
diff -Nru linux/include/asm-i386/mach-pc9800/calibrate_tsc.h linux98/include/asm-i386/mach-pc9800/calibrate_tsc.h
--- linux/include/asm-i386/mach-pc9800/calibrate_tsc.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/calibrate_tsc.h	2002-11-05 22:19:50.000000000 +0900
@@ -0,0 +1,71 @@
+/*
+ *  include/asm-i386/mach-pc9800/calibrate_tsc.h
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
diff -Nru linux/include/asm-i386/mach-pc9800/do_timer.h linux98/include/asm-i386/mach-pc9800/do_timer.h
--- linux/include/asm-i386/mach-pc9800/do_timer.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/do_timer.h	2002-10-16 13:20:29.000000000 +0900
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
diff -Nru linux/include/asm-i386/mach-pc9800/mach_resources.h linux98/include/asm-i386/mach-pc9800/mach_resources.h
--- linux/include/asm-i386/mach-pc9800/mach_resources.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_resources.h	2002-10-26 17:35:19.000000000 +0900
@@ -0,0 +1,192 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_resources.h
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
diff -Nru linux/include/asm-i386/mach-pc9800/mach_time.h linux98/include/asm-i386/mach-pc9800/mach_time.h
--- linux/include/asm-i386/mach-pc9800/mach_time.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_time.h	2002-10-21 11:23:06.000000000 +0900
@@ -0,0 +1,136 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_time.h
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
diff -Nru linux/include/asm-i386/mach-pc9800/mach_traps.h linux98/include/asm-i386/mach-pc9800/mach_traps.h
--- linux/include/asm-i386/mach-pc9800/mach_traps.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_traps.h	2002-11-05 22:46:55.000000000 +0900
@@ -0,0 +1,27 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_traps.h
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
diff -Nru linux/include/asm-i386/mach-pc9800/smpboot_hooks.h linux98/include/asm-i386/mach-pc9800/smpboot_hooks.h
--- linux/include/asm-i386/mach-pc9800/smpboot_hooks.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/smpboot_hooks.h	2002-09-22 06:56:46.000000000 +0900
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
