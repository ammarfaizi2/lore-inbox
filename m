Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbTDHAHp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTDGXZ4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:25:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2433
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263862AbTDGXMS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:12:18 -0400
Date: Tue, 8 Apr 2003 01:31:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080031.h380VAVJ009176@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add but do not yet use mach specific definitions for ports etc on PC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/apm.h linux-2.5.67-ac1/include/asm-i386/mach-default/apm.h
--- linux-2.5.67/include/asm-i386/mach-default/apm.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/apm.h	2003-03-06 23:29:16.000000000 +0000
@@ -0,0 +1,75 @@
+/*
+ *  include/asm-i386/mach-default/apm.h
+ *
+ *  Machine specific APM BIOS functions for generic.
+ *  Split out from apm.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+#ifndef _ASM_APM_H
+#define _ASM_APM_H
+
+#ifdef APM_ZERO_SEGS
+#	define APM_DO_ZERO_SEGS \
+		"pushl %%ds\n\t" \
+		"pushl %%es\n\t" \
+		"xorl %%edx, %%edx\n\t" \
+		"mov %%dx, %%ds\n\t" \
+		"mov %%dx, %%es\n\t" \
+		"mov %%dx, %%fs\n\t" \
+		"mov %%dx, %%gs\n\t"
+#	define APM_DO_POP_SEGS \
+		"popl %%es\n\t" \
+		"popl %%ds\n\t"
+#else
+#	define APM_DO_ZERO_SEGS
+#	define APM_DO_POP_SEGS
+#endif
+
+static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
+					u32 *eax, u32 *ebx, u32 *ecx,
+					u32 *edx, u32 *esi)
+{
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%al\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx),
+		  "=S" (*esi)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+}
+
+static inline u8 apm_bios_call_simple_asm(u32 func, u32 ebx_in,
+						u32 ecx_in, u32 *eax)
+{
+	int	cx, dx, si;
+	u8	error;
+
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%bl\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (error), "=c" (cx), "=d" (dx),
+		  "=S" (si)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+	return error;
+}
+
+#endif /* _ASM_APM_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/bios_ebda.h linux-2.5.67-ac1/include/asm-i386/mach-default/bios_ebda.h
--- linux-2.5.67/include/asm-i386/mach-default/bios_ebda.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/bios_ebda.h	2003-03-14 01:10:39.000000000 +0000
@@ -0,0 +1,15 @@
+#ifndef _MACH_BIOS_EBDA_H
+#define _MACH_BIOS_EBDA_H
+
+/*
+ * there is a real-mode segmented pointer pointing to the
+ * 4K EBDA area at 0x40E.
+ */
+static inline unsigned int get_bios_ebda(void)
+{
+	unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
+	address <<= 4;
+	return address;	/* 0 means none */
+}
+
+#endif /* _MACH_BIOS_EBDA_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/io_ports.h linux-2.5.67-ac1/include/asm-i386/mach-default/io_ports.h
--- linux-2.5.67/include/asm-i386/mach-default/io_ports.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/io_ports.h	2003-02-15 01:57:59.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-generic/io_ports.h
+ *
+ *  Machine specific IO port address definition for generic.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_IO_PORTS_H
+#define _MACH_IO_PORTS_H
+
+/* i8253A PIT registers */
+#define PIT_MODE		0x43
+#define PIT_CH0			0x40
+#define PIT_CH2			0x42
+
+/* i8259A PIC registers */
+#define PIC_MASTER_CMD		0x20
+#define PIC_MASTER_IMR		0x21
+#define PIC_MASTER_ISR		PIC_MASTER_CMD
+#define PIC_MASTER_POLL		PIC_MASTER_ISR
+#define PIC_MASTER_OCW3		PIC_MASTER_ISR
+#define PIC_SLAVE_CMD		0xa0
+#define PIC_SLAVE_IMR		0xa1
+
+/* i8259A PIC related value */
+#define PIC_CASCADE_IR		2
+#define MASTER_ICW4_DEFAULT	0x01
+#define SLAVE_ICW4_DEFAULT	0x01
+#define PIC_ICW4_AEOI		2
+
+#endif /* !_MACH_IO_PORTS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/irq_vectors.h linux-2.5.67-ac1/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.5.67/include/asm-i386/mach-default/irq_vectors.h	2003-02-10 18:38:05.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/irq_vectors.h	2003-02-14 22:59:12.000000000 +0000
@@ -82,4 +82,11 @@
 #define NR_IRQS 16
 #endif
 
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
+
 #endif /* _ASM_IRQ_VECTORS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/mach_mpparse.h linux-2.5.67-ac1/include/asm-i386/mach-default/mach_mpparse.h
--- linux-2.5.67/include/asm-i386/mach-default/mach_mpparse.h	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/mach_mpparse.h	2003-02-15 01:59:39.000000000 +0000
@@ -4,7 +4,7 @@
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
 				struct mpc_config_translation *translation)
 {
-	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
+//	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
 }
 
 static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/mach_resources.h linux-2.5.67-ac1/include/asm-i386/mach-default/mach_resources.h
--- linux-2.5.67/include/asm-i386/mach-default/mach_resources.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/mach_resources.h	2003-03-14 01:17:51.000000000 +0000
@@ -0,0 +1,110 @@
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
+static inline void probe_video_rom(int roms)
+{
+	unsigned long base;
+	unsigned char *romstart;
+
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
+}
+
+static inline void probe_extension_roms(int roms)
+{
+	unsigned long base;
+	unsigned char *romstart;
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
+static inline void request_graphics_resource(void)
+{
+	request_resource(&iomem_resource, &vram_resource);
+}
+
+#endif /* !_MACH_RESOURCES_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/mach_time.h linux-2.5.67-ac1/include/asm-i386/mach-default/mach_time.h
--- linux-2.5.67/include/asm-i386/mach-default/mach_time.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/mach_time.h	2003-03-14 01:06:58.000000000 +0000
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
+#define USEC_AFTER	500000
+#define USEC_BEFORE	500000
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/mach_timer.h linux-2.5.67-ac1/include/asm-i386/mach-default/mach_timer.h
--- linux-2.5.67/include/asm-i386/mach-default/mach_timer.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/mach_timer.h	2003-04-04 17:17:11.000000000 +0100
@@ -0,0 +1,47 @@
+/*
+ *  include/asm-i386/mach-default/mach_timer.h
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
+#ifndef _MACH_TIMER_H
+#define _MACH_TIMER_H
+
+#define CALIBRATE_LATCH	(5 * LATCH)
+
+static inline void mach_prepare_counter(void)
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
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb_p(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
+}
+
+static inline void mach_countup(unsigned long *count)
+{
+	*count = 0L;
+	do {
+		*count++;
+	} while ((inb_p(0x61) & 0x20) == 0);
+}
+
+#endif /* !_MACH_TIMER_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/mach_traps.h linux-2.5.67-ac1/include/asm-i386/mach-default/mach_traps.h
--- linux-2.5.67/include/asm-i386/mach-default/mach_traps.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/mach_traps.h	2003-03-06 23:33:53.000000000 +0000
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-default/smpboot_hooks.h linux-2.5.67-ac1/include/asm-i386/mach-default/smpboot_hooks.h
--- linux-2.5.67/include/asm-i386/mach-default/smpboot_hooks.h	2003-02-10 18:38:16.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-i386/mach-default/smpboot_hooks.h	2003-03-14 01:10:39.000000000 +0000
@@ -6,7 +6,18 @@
 	io_apic_irqs = 0;
 }
 
-static inline void smpboot_setup_warm_reset_vector(void)
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	CMOS_WRITE(0xa, 0xf);
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+}
+
+static inline void smpboot_restore_warm_reset_vector(void)
 {
 	/*
 	 * Install writable page 0 entry to set BIOS data area.
