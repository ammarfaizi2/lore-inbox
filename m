Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311259AbSCLQAV>; Tue, 12 Mar 2002 11:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSCLQAN>; Tue, 12 Mar 2002 11:00:13 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:15635 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311259AbSCLP7p>; Tue, 12 Mar 2002 10:59:45 -0500
Date: Tue, 12 Mar 2002 16:59:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312165937.A4987@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8DDFC8.5080501@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Mar 12, 2002 at 12:00:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:

> Hello Vojtech.
> 
> I have noticed that the ide-timings.h and ide_modules.h are running
> much in aprallel in the purpose they serve. Are the any
> chances you could dare to care about propagating the
> fairly nice ide-timings.h stuff in favour of
> ide_modules.h more.
> 
> BTW.> I think some stuff from ide-timings.h just belongs
> as generic functions intro ide.c, and right now there is
> nobody who you need to work from behind ;-).
> 
> So please feel free to do the changes you apparently desired
> to do a long time ago...

Hmm, ok. Try this. It shouldn't change any functionality, yet makes a
small step towards cleaning the chipset specific drivers.

Reading through them as I was doing the changes, I found out that most
of them compute the timings incorrectly. Because of that I also removed
the pio blacklist (which is going to come back in a more powerful form,
merged together with the DMA blacklist), because that one is based on
ancient experiments with the broken CMD640 chip and a driver which
doesn't get the timings correct either. The blacklist is plain invalid.

I plan to focus on the most important drivers first, to fix and clean
them, working with the authors where possible.

-- 
Vojtech Pavlik
SuSE Labs

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-timing.diff"

diff -urN linux-2.5.6/drivers/ide/Makefile linux-2.5.6-timing/drivers/ide/Makefile
--- linux-2.5.6/drivers/ide/Makefile	Wed Feb 20 03:10:55 2002
+++ linux-2.5.6-timing/drivers/ide/Makefile	Tue Mar 12 16:26:03 2002
@@ -76,7 +76,7 @@
 
 ide-obj-$(CONFIG_PROC_FS)		+= ide-proc.o
 
-ide-mod-objs		:= ide-taskfile.o ide.o ide-probe.o ide-geometry.o ide-features.o $(ide-obj-y)
+ide-mod-objs		:= ide-taskfile.o ide.o ide-probe.o ide-geometry.o ide-features.o ide-timing.o $(ide-obj-y)
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.5.6/drivers/ide/aec62xx.c linux-2.5.6-timing/drivers/ide/aec62xx.c
--- linux-2.5.6/drivers/ide/aec62xx.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/aec62xx.c	Tue Mar 12 16:26:03 2002
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define DISPLAY_AEC62XX_TIMINGS
 
@@ -412,16 +412,11 @@
 static void aec62xx_tune_drive (ide_drive_t *drive, byte pio)
 {
 	byte speed;
-	byte new_pio = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
 
-	switch(pio) {
-		case 5:		speed = new_pio; break;
-		case 4:		speed = XFER_PIO_4; break;
-		case 3:		speed = XFER_PIO_3; break;
-		case 2:		speed = XFER_PIO_2; break;
-		case 1:		speed = XFER_PIO_1; break;
-		default:	speed = XFER_PIO_0; break;
-	}
+	if (pio == 255)
+		speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		speed = XFER_PIO_0 + min_t(byte, pio, 4);
 
 	switch(HWIF(drive)->pci_dev->device) {
 		case PCI_DEVICE_ID_ARTOP_ATP850UF:
diff -urN linux-2.5.6/drivers/ide/ali14xx.c linux-2.5.6-timing/drivers/ide/ali14xx.c
--- linux-2.5.6/drivers/ide/ali14xx.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/ali14xx.c	Tue Mar 12 16:26:03 2002
@@ -48,7 +48,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /* port addresses for auto-detection */
 #define ALI_NUM_PORTS 4
@@ -67,8 +67,6 @@
 	{0x35, 0x03}, {0x00, 0x00}
 };
 
-#define ALI_MAX_PIO 4
-
 /* timing parameter registers for each drive */
 static struct { byte reg1, reg2, reg3, reg4; } regTab[4] = {
 	{0x03, 0x26, 0x04, 0x27},     /* drive 0 */
@@ -114,21 +112,26 @@
 	int time1, time2;
 	byte param1, param2, param3, param4;
 	unsigned long flags;
-	ide_pio_data_t d;
+	struct ide_timing *t;
+
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		pio = XFER_PIO_0 + min_t(byte, pio, 4);
 
-	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO, &d);
+	t = ide_timing_find_mode(pio);
 
 	/* calculate timing, according to PIO mode */
-	time1 = d.cycle_time;
-	time2 = ide_pio_timings[pio].active_time;
+	time1 = t->cycle;
+	time2 = t->active;
 	param3 = param1 = (time2 * system_bus_speed + 999) / 1000;
 	param4 = param2 = (time1 * system_bus_speed + 999) / 1000 - param1;
-	if (pio < 3) {
+	if (pio < XFER_PIO_3) {
 		param3 += 8;
 		param4 += 8;
 	}
 	printk("%s: PIO mode%d, t1=%dns, t2=%dns, cycles = %d+%d, %d+%d\n",
-		drive->name, pio, time1, time2, param1, param2, param3, param4);
+		drive->name, pio - XFER_PIO_0, time1, time2, param1, param2, param3, param4);
 
 	/* stuff timing parameters into controller registers */
 	driveNum = (HWIF(drive)->index << 1) + drive->select.b.unit;
diff -urN linux-2.5.6/drivers/ide/alim15x3.c linux-2.5.6-timing/drivers/ide/alim15x3.c
--- linux-2.5.6/drivers/ide/alim15x3.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/alim15x3.c	Tue Mar 12 16:26:03 2002
@@ -26,7 +26,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define DISPLAY_ALI_TIMINGS
 
@@ -241,7 +241,7 @@
 
 static void ali15x3_tune_drive (ide_drive_t *drive, byte pio)
 {
-	ide_pio_data_t d;
+	struct ide_timing *t;
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
 	int s_time, a_time, c_time;
@@ -250,15 +250,21 @@
 	int port = hwif->index ? 0x5c : 0x58;
 	int portFIFO = hwif->channel ? 0x55 : 0x54;
 	byte cd_dma_fifo = 0;
+	
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		pio = XFER_PIO_0 + min_t(byte, pio, 4);
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, &d);
-	s_time = ide_pio_timings[pio].setup_time;
-	a_time = ide_pio_timings[pio].active_time;
+	t = ide_timing_find_mode(pio);	
+	
+	s_time = t->setup;
+	a_time = t->active;
 	if ((s_clc = (s_time * system_bus_speed + 999) / 1000) >= 8)
 		s_clc = 0;
 	if ((a_clc = (a_time * system_bus_speed + 999) / 1000) >= 8)
 		a_clc = 0;
-	c_time = ide_pio_timings[pio].cycle_time;
+	c_time = t->cycle;
 
 #if 0
 	if ((r_clc = ((c_time - s_time - a_time) * system_bus_speed + 999) / 1000) >= 16)
@@ -295,17 +301,6 @@
 	pci_write_config_byte(dev, port, s_clc);
 	pci_write_config_byte(dev, port+drive->select.b.unit+2, (a_clc << 4) | r_clc);
 	__restore_flags(flags);
-
-	/*
-	 * setup   active  rec
-	 * { 70,   165,    365 },   PIO Mode 0
-	 * { 50,   125,    208 },   PIO Mode 1
-	 * { 30,   100,    110 },   PIO Mode 2
-	 * { 30,   80,     70  },   PIO Mode 3 with IORDY
-	 * { 25,   70,     25  },   PIO Mode 4 with IORDY  ns
-	 * { 20,   50,     30  }    PIO Mode 5 with IORDY (nonstandard)
-	 */
-
 }
 
 static int ali15x3_tune_chipset (ide_drive_t *drive, byte speed)
diff -urN linux-2.5.6/drivers/ide/amd74xx.c linux-2.5.6-timing/drivers/ide/amd74xx.c
--- linux-2.5.6/drivers/ide/amd74xx.c	Tue Mar 12 16:05:37 2002
+++ linux-2.5.6-timing/drivers/ide/amd74xx.c	Tue Mar 12 16:26:03 2002
@@ -235,7 +235,7 @@
 				drive->dn >> 1, drive->dn & 1);
 
 	T = 1000000000 / amd_clock;
-	UT = T / MIN(MAX(amd_config->flags & AMD_UDMA, 1), 2);
+	UT = T / min_t(int, max_t(int, amd_config->flags & AMD_UDMA, 1), 2);
 
 	ide_timing_compute(drive, speed, &t, T, UT);
 
@@ -270,7 +270,7 @@
 		return;
 	}
 
-	amd_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
+	amd_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
diff -urN linux-2.5.6/drivers/ide/cmd640.c linux-2.5.6-timing/drivers/ide/cmd640.c
--- linux-2.5.6/drivers/ide/cmd640.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/cmd640.c	Tue Mar 12 16:29:48 2002
@@ -112,7 +112,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /*
  * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
@@ -589,15 +589,11 @@
 /*
  * Set a specific pio_mode for a drive
  */
-static void cmd640_set_mode (unsigned int index, byte pio_mode, unsigned int cycle_time)
+static void cmd640_set_mode (unsigned int index, byte pio_mode, unsigned int cycle_time, unsigned int active_time, unsigned int setup_time)
 {
-	int setup_time, active_time, recovery_time, clock_time;
+	int recovery_time, clock_time;
 	byte setup_count, active_count, recovery_count, recovery_count2, cycle_count;
 
-	if (pio_mode > 5)
-		pio_mode = 5;
-	setup_time  = ide_pio_timings[pio_mode].setup_time;
-	active_time = ide_pio_timings[pio_mode].active_time;
 	recovery_time = cycle_time - (setup_time + active_time);
 	clock_time = 1000 / system_bus_speed;
 	cycle_count = (cycle_time + clock_time - 1) / clock_time;
@@ -646,7 +642,7 @@
 static void cmd640_tune_drive (ide_drive_t *drive, byte mode_wanted)
 {
 	byte b;
-	ide_pio_data_t  d;
+	struct ide_timing *t;
 	unsigned int index = 0;
 
 	while (drive != cmd_drives[index]) {
@@ -674,14 +670,16 @@
 			return;
 	}
 
-	(void) ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
-	cmd640_set_mode (index, d.pio_mode, d.cycle_time);
+	if (mode_wanted == 255)
+		t = ide_timing_find_mode(ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
+	else
+		t = ide_timing_find_mode(XFER_PIO_0 + min_t(byte, mode_wanted, 4));
+
+	cmd640_set_mode(index, t->mode - XFER_PIO_0, t->cycle, t->active, t->setup);
+
+	printk ("%s: selected cmd640 PIO mode%d (%dns)",
+		drive->name, t->mode, t->cycle);
 
-	printk ("%s: selected cmd640 PIO mode%d (%dns)%s",
-		drive->name,
-		d.pio_mode,
-		d.cycle_time,
-		d.overridden ? " (overriding vendor mode)" : "");
 	display_clocks(index);
 	return;
 }
diff -urN linux-2.5.6/drivers/ide/cmd64x.c linux-2.5.6-timing/drivers/ide/cmd64x.c
--- linux-2.5.6/drivers/ide/cmd64x.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/cmd64x.c	Tue Mar 12 16:26:03 2002
@@ -23,7 +23,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #ifndef SPLIT_BYTE
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
@@ -279,10 +279,10 @@
  */
 static void cmd64x_tuneproc (ide_drive_t *drive, byte mode_wanted)
 {
-	int setup_time, active_time, recovery_time, clock_time, pio_mode, cycle_time;
+	int recovery_time, clock_time;
 	byte recovery_count2, cycle_count;
 	int setup_count, active_count, recovery_count;
-	ide_pio_data_t  d;
+	struct ide_timing *t;
 
 	switch (mode_wanted) {
 		case 8: /* set prefetch off */
@@ -291,27 +291,21 @@
 			/*set_prefetch_mode(index, mode_wanted);*/
 			cmdprintk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
 			return;
+		case 255: mode_wanted = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
 	}
 
-	mode_wanted = ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
-	pio_mode = d.pio_mode;
-	cycle_time = d.cycle_time;
+	t = ide_timing_find_mode(XFER_PIO_0 + min_t(byte, mode_wanted, 4));
 
 	/*
 	 * I copied all this complicated stuff from cmd640.c and made a few minor changes.
 	 * For now I am just going to pray that it is correct.
 	 */
-	if (pio_mode > 5)
-		pio_mode = 5;
-	setup_time  = ide_pio_timings[pio_mode].setup_time;
-	active_time = ide_pio_timings[pio_mode].active_time;
-	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / system_bus_speed;
-	cycle_count = (cycle_time + clock_time - 1) / clock_time;
-
-	setup_count = (setup_time + clock_time - 1) / clock_time;
 
-	active_count = (active_time + clock_time - 1) / clock_time;
+	recovery_time = t->cycle - (t->setup + t->active);
+	clock_time = 1000 / system_bus_speed;
+	cycle_count = (t->cycle + clock_time - 1) / clock_time;
+	setup_count = (t->setup + clock_time - 1) / clock_time;
+	active_count = (t->active + clock_time - 1) / clock_time;
 
 	recovery_count = (recovery_time + clock_time - 1) / clock_time;
 	recovery_count2 = cycle_count - (setup_count + active_count);
@@ -334,9 +328,8 @@
 	 */
 	program_drive_counts (drive, setup_count, active_count, recovery_count);
 
-	cmdprintk("%s: selected cmd646 PIO mode%d : %d (%dns)%s, clocks=%d/%d/%d\n",
-		drive->name, pio_mode, mode_wanted, cycle_time,
-		d.overridden ? " (overriding vendor mode)" : "",
+	cmdprintk("%s: selected cmd646 PIO mode%d : %d (%dns), clocks=%d/%d/%d\n",
+		drive->name, t.mode - XFER_PIO_0, mode_wanted, cycle_time,
 		setup_count, active_count, recovery_count);
 }
 
@@ -391,7 +384,7 @@
 static void config_cmd64x_chipset_for_pio (ide_drive_t *drive, byte set_speed)
 {
 	byte speed	= 0x00;
-	byte set_pio	= ide_get_best_pio_mode(drive, 4, 5, NULL);
+	byte set_pio	= ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 	cmd64x_tuneproc(drive, set_pio);
 	speed = XFER_PIO_0 + set_pio;
@@ -408,7 +401,7 @@
 	u8 speed		= 0x00;
 	u8 mode_pci		= 0x00;
 	u8 channel_timings	= cmd680_taskfile_timing(hwif);
-	u8 set_pio		= ide_get_best_pio_mode(drive, 4, 5, NULL);
+	u8 set_pio		= ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 	pci_read_config_byte(dev, addr_mask, &mode_pci);
 	mode_pci &= ~((unit) ? 0x30 : 0x03);
diff -urN linux-2.5.6/drivers/ide/cs5530.c linux-2.5.6-timing/drivers/ide/cs5530.c
--- linux-2.5.6/drivers/ide/cs5530.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/cs5530.c	Tue Mar 12 16:26:03 2002
@@ -27,7 +27,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define DISPLAY_CS5530_TIMINGS
 
@@ -114,10 +114,13 @@
 {
 	ide_hwif_t	*hwif = HWIF(drive);
 	unsigned int	format, basereg = CS5530_BASEREG(hwif);
-	static byte	modes[5] = {XFER_PIO_0, XFER_PIO_1, XFER_PIO_2, XFER_PIO_3, XFER_PIO_4};
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
-	if (!cs5530_set_xfer_mode(drive, modes[pio])) {
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		pio = XFER_PIO_0 + min_t(byte, pio, 4);
+
+	if (!cs5530_set_xfer_mode(drive, pio)) {
 		format = (inl(basereg+4) >> 31) & 1;
 		outl(cs5530_pio_timings[format][pio], basereg+(drive->select.b.unit<<3));
 	}
diff -urN linux-2.5.6/drivers/ide/cy82c693.c linux-2.5.6-timing/drivers/ide/cy82c693.c
--- linux-2.5.6/drivers/ide/cy82c693.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/cy82c693.c	Tue Mar 12 16:26:03 2002
@@ -53,7 +53,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /* the current version */
 #define CY82_VERSION	"CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)"
@@ -140,8 +140,11 @@
  */ 
 static void compute_clocks (byte pio, pio_clocks_t *p_pclk)
 {
+	struct ide_timing *t;
 	int clk1, clk2;
 
+	t = ide_timing_find_mode(XFER_PIO_0 + pio);
+
 	/* we don't check against CY82C693's min and max speed,
 	 * so you can play with the idebus=xx parameter
 	 */
@@ -150,15 +153,13 @@
 		pio = CY82C693_MAX_PIO;
 
 	/* let's calc the address setup time clocks */
-	p_pclk->address_time = (byte)calc_clk(ide_pio_timings[pio].setup_time, system_bus_speed);
+	p_pclk->address_time = (byte)calc_clk(t->setup, system_bus_speed);
 
 	/* let's calc the active and recovery time clocks */
-	clk1 = calc_clk(ide_pio_timings[pio].active_time, system_bus_speed);
+	clk1 = calc_clk(t->active, system_bus_speed);
 
 	/* calc recovery timing */
-	clk2 =	ide_pio_timings[pio].cycle_time -
-		ide_pio_timings[pio].active_time -
-		ide_pio_timings[pio].setup_time;
+	clk2 =	t->cycle - t->active - t->setup;
 
 	clk2 = calc_clk(clk2, system_bus_speed);
 
@@ -166,7 +167,7 @@
 
 	/* note: we use the same values for 16bit IOR and IOW
          *	those are all the same, since I don't have other
-	 *	timings than those from ide_modes.h
+	 *	timings than those from ide-timing.h
 	 */
 
 	p_pclk->time_16r = (byte)clk1;
@@ -321,7 +322,7 @@
 #endif /* CY82C693_DEBUG_LOGS */
 
         /* first let's calc the pio modes */
-	pio = ide_get_best_pio_mode(drive, pio, CY82C693_MAX_PIO, NULL);
+	pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 #if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s: Selected PIO mode %d\n", drive->name, pio);
diff -urN linux-2.5.6/drivers/ide/dtc2278.c linux-2.5.6-timing/drivers/ide/dtc2278.c
--- linux-2.5.6/drivers/ide/dtc2278.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/dtc2278.c	Tue Mar 12 16:26:03 2002
@@ -15,7 +15,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /*
  * Changing this #undef to #define may solve start up problems in some systems.
@@ -70,7 +70,7 @@
 {
 	unsigned long flags;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 	if (pio >= 3) {
 		save_flags(flags);	/* all CPUs */
diff -urN linux-2.5.6/drivers/ide/hpt34x.c linux-2.5.6-timing/drivers/ide/hpt34x.c
--- linux-2.5.6/drivers/ide/hpt34x.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/hpt34x.c	Tue Mar 12 16:26:03 2002
@@ -40,7 +40,7 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #ifndef SPLIT_BYTE
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
@@ -152,9 +152,9 @@
 
 	byte	timing, speed, pio;
 
-	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
+	pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
-	if (xfer_pio> 4)
+	if (xfer_pio > 4)
 		xfer_pio = 0;
 
 	if (drive->id->eide_pio_iordy > 0) {
diff -urN linux-2.5.6/drivers/ide/hpt366.c linux-2.5.6-timing/drivers/ide/hpt366.c
--- linux-2.5.6/drivers/ide/hpt366.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/hpt366.c	Tue Mar 12 16:26:03 2002
@@ -61,7 +61,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define DISPLAY_HPT366_TIMINGS
 
@@ -600,9 +600,9 @@
 	unsigned short xfer_pio = drive->id->eide_pio_modes;
 	byte	timing, speed, pio;
 
-	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
+	pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
-	if (xfer_pio> 4)
+	if (xfer_pio > 4)
 		xfer_pio = 0;
 
 	if (drive->id->eide_pio_iordy > 0) {
diff -urN linux-2.5.6/drivers/ide/ht6560b.c linux-2.5.6-timing/drivers/ide/ht6560b.c
--- linux-2.5.6/drivers/ide/ht6560b.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/ht6560b.c	Tue Mar 12 16:26:03 2002
@@ -44,7 +44,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /* #define DEBUG */  /* remove comments for DEBUG messages */
 
@@ -199,20 +199,23 @@
 {
 	int active_time, recovery_time;
 	int active_cycles, recovery_cycles;
-	ide_pio_data_t d;
+	struct ide_timing *t;
 	
         if (pio) {
-		pio = ide_get_best_pio_mode(drive, pio, 5, &d);
+		if (pio == 255)
+			pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+		else
+			pio = XFER_PIO_0 + min_t(byte, pio, 4);
+
+		t = ide_timing_find_mode(pio);
 		
 		/*
 		 *  Just like opti621.c we try to calculate the
 		 *  actual cycle time for recovery and activity
 		 *  according system bus speed.
 		 */
-		active_time = ide_pio_timings[pio].active_time;
-		recovery_time = d.cycle_time 
-			- active_time
-			- ide_pio_timings[pio].setup_time;
+		active_time = t->active;
+		recovery_time = t->cycle - active_time - t->setup;
 		/*
 		 *  Cycle times should be Vesa bus cycles
 		 */
@@ -227,7 +230,8 @@
 		if (recovery_cycles > 15) recovery_cycles = 0;  /* 0==16 */
 		
 #ifdef DEBUG
-		printk("ht6560b: drive %s setting pio=%d recovery=%d (%dns) active=%d (%dns)\n", drive->name, pio, recovery_cycles, recovery_time, active_cycles, active_time);
+		printk("ht6560b: drive %s setting pio=%d recovery=%d (%dns) active=%d (%dns)\n",
+			drive->name, pio - XFER_PIO_0, recovery_cycles, recovery_time, active_cycles, active_time);
 #endif
 		
 		return (byte)((recovery_cycles << 4) | active_cycles);
diff -urN linux-2.5.6/drivers/ide/icside.c linux-2.5.6-timing/drivers/ide/icside.c
--- linux-2.5.6/drivers/ide/icside.c	Wed Feb 20 03:10:55 2002
+++ linux-2.5.6-timing/drivers/ide/icside.c	Tue Mar 12 16:26:03 2002
@@ -351,90 +351,6 @@
 	return ide_error(drive, "dma_intr", stat);
 }
 
-/*
- * The following is a sick duplication from ide-dma.c ;(
- *
- * This should be defined in one place only.
- */
-struct drive_list_entry {
-	char * id_model;
-	char * id_firmware;
-};
-
-static struct drive_list_entry drive_whitelist [] = {
-	{ "Micropolis 2112A",			"ALL"		},
-	{ "CONNER CTMA 4000",			"ALL"		},
-	{ "CONNER CTT8000-A",			"ALL"		},
-	{ "ST34342A",				"ALL"		},
-	{ NULL,					0		}
-};
-
-static struct drive_list_entry drive_blacklist [] = {
-	{ "WDC AC11000H",			"ALL"		},
-	{ "WDC AC22100H",			"ALL"		},
-	{ "WDC AC32500H",			"ALL"		},
-	{ "WDC AC33100H",			"ALL"		},
-	{ "WDC AC31600H",			"ALL"		},
-	{ "WDC AC32100H",			"24.09P07"	},
-	{ "WDC AC23200L",			"21.10N21"	},
-	{ "Compaq CRD-8241B",			"ALL"		},
-	{ "CRD-8400B",				"ALL"		},
-	{ "CRD-8480B",				"ALL"		},
-	{ "CRD-8480C",				"ALL"		},
-	{ "CRD-8482B",				"ALL"		},
- 	{ "CRD-84",				"ALL"		},
-	{ "SanDisk SDP3B",			"ALL"		},
-	{ "SanDisk SDP3B-64",			"ALL"		},
-	{ "SANYO CD-ROM CRD",			"ALL"		},
-	{ "HITACHI CDR-8",			"ALL"		},
-	{ "HITACHI CDR-8335",			"ALL"		},
-	{ "HITACHI CDR-8435",			"ALL"		},
-	{ "Toshiba CD-ROM XM-6202B",		"ALL"		},
-	{ "CD-532E-A",				"ALL"		},
-	{ "E-IDE CD-ROM CR-840",		"ALL"		},
-	{ "CD-ROM Drive/F5A",			"ALL"		},
-	{ "RICOH CD-R/RW MP7083A",		"ALL"		},
-	{ "WPI CDD-820",			"ALL"		},
-	{ "SAMSUNG CD-ROM SC-148C",		"ALL"		},
-	{ "SAMSUNG CD-ROM SC-148F",		"ALL"		},
-	{ "SAMSUNG CD-ROM SC",			"ALL"		},
-	{ "SanDisk SDP3B-64",			"ALL"		},
-	{ "SAMSUNG CD-ROM SN-124",		"ALL"		},
-	{ "PLEXTOR CD-R PX-W8432T",		"ALL"		},
-	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
-	{ "_NEC DV5800A",			"ALL"		},
-	{ NULL,					0		}
-};
-
-static int in_drive_list(struct hd_driveid *id, struct drive_list_entry * drive_table)
-{
-	for ( ; drive_table->id_model ; drive_table++)
-		if ((!strcmp(drive_table->id_model, id->model)) &&
-		    ((!strstr(drive_table->id_firmware, id->fw_rev)) ||
-		     (!strcmp(drive_table->id_firmware, "ALL"))))
-			return 1;
-	return 0;
-}
-
-/*
- *  For both Blacklisted and Whitelisted drives.
- *  This is setup to be called as an extern for future support
- *  to other special driver code.
- */
-static int icside_check_drive_lists(ide_drive_t *drive, int good_bad)
-{
-	struct hd_driveid *id = drive->id;
-
-	if (good_bad) {
-		return in_drive_list(id, drive_whitelist);
-	} else {
-		int blacklist = in_drive_list(id, drive_blacklist);
-		if (blacklist)
-			printk("%s: Disabling DMA for %s\n", drive->name, id->model);
-		return(blacklist);
-	}
-	return 0;
-}
 
 static int
 icside_dma_check(ide_drive_t *drive)
@@ -449,14 +365,6 @@
 		goto out;
 
 	/*
-	 * Consult the list of known "bad" drives
-	 */
-	if (icside_check_drive_lists(drive, 0)) {
-		func = ide_dma_off;
-		goto out;
-	}
-
-	/*
 	 * Enable DMA on any drive that has multiword DMA
 	 */
 	if (id->field_valid & 2) {
@@ -473,16 +381,6 @@
 		goto out;
 	}
 
-	/*
-	 * Consult the list of known "good" drives
-	 */
-	if (icside_check_drive_lists(drive, 1)) {
-		if (id->eide_dma_time > 150)
-			goto out;
-		xfer_mode = XFER_MW_DMA_1;
-		func = ide_dma_on;
-	}
-
 out:
 	func = icside_config_if(drive, xfer_mode);
 
@@ -562,11 +460,6 @@
 
 	case ide_dma_test_irq:
 		return inb((unsigned long)hwif->hw.priv) & 1;
-
-	case ide_dma_bad_drive:
-	case ide_dma_good_drive:
-		return icside_check_drive_lists(drive, (func ==
-						ide_dma_good_drive));
 
 	case ide_dma_verbose:
 		return icside_dma_verbose(drive);
diff -urN linux-2.5.6/drivers/ide/ide-m8xx.c linux-2.5.6-timing/drivers/ide/ide-m8xx.c
--- linux-2.5.6/drivers/ide/ide-m8xx.c	Wed Feb 20 03:11:02 2002
+++ linux-2.5.6-timing/drivers/ide/ide-m8xx.c	Tue Mar 12 16:26:03 2002
@@ -37,7 +37,7 @@
 #include <asm/machdep.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 static int identify  (volatile unsigned char *p);
 static void print_fixed (volatile unsigned char *p);
 static void print_funcid (int func);
@@ -222,19 +222,19 @@
 		/* Compute clock cycles for PIO timings */
 		for (i=0; i<6; ++i) {
 			bd_t	*binfo = (bd_t *)__res;
+			struct ide_timing *t;
+
+			t = ide_timing_find_mode(i + XFER_PIO_0);
 
 			hold_time[i]   =
 				PCMCIA_MK_CLKS (hold_time[i],
 						binfo->bi_busfreq);
 			ide_pio_clocks[i].setup_time  =
-				PCMCIA_MK_CLKS (ide_pio_timings[i].setup_time,
-						binfo->bi_busfreq);
+				PCMCIA_MK_CLKS (t->setup, binfo->bi_busfreq);
 			ide_pio_clocks[i].active_time =
-				PCMCIA_MK_CLKS (ide_pio_timings[i].active_time,
-						binfo->bi_busfreq);
+				PCMCIA_MK_CLKS (t->active, binfo->bi_busfreq);
 			ide_pio_clocks[i].cycle_time  =
-				PCMCIA_MK_CLKS (ide_pio_timings[i].cycle_time,
-						binfo->bi_busfreq);
+				PCMCIA_MK_CLKS (t->cycle, binfo->bi_busfreq);
 #if 0
 			printk ("PIO mode %d timings: %d/%d/%d => %d/%d/%d\n",
 				i,
@@ -242,10 +242,7 @@
 				ide_pio_clocks[i].active_time,
 				ide_pio_clocks[i].hold_time,
 				ide_pio_clocks[i].cycle_time,
-				ide_pio_timings[i].setup_time,
-				ide_pio_timings[i].active_time,
-				ide_pio_timings[i].hold_time,
-				ide_pio_timings[i].cycle_time);
+				t->setup, t->active, hold_time[i], t->cycle);
 #endif
 		}
 	}
@@ -429,13 +426,13 @@
 static void
 m8xx_ide_tuneproc(ide_drive_t *drive, byte pio)
 {
-	ide_pio_data_t d;
 #if defined(CONFIG_IDE_8xx_PCCARD) || defined(CONFIG_IDE_8xx_DIRECT)
 	volatile pcmconf8xx_t	*pcmp;
 	ulong timing, mask, reg;
 #endif
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, &d);
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 #if 1
 	printk("%s[%d] %s: best PIO mode: %d\n",
diff -urN linux-2.5.6/drivers/ide/ide-pmac.c linux-2.5.6-timing/drivers/ide/ide-pmac.c
--- linux-2.5.6/drivers/ide/ide-pmac.c	Wed Feb 20 03:11:04 2002
+++ linux-2.5.6-timing/drivers/ide/ide-pmac.c	Tue Mar 12 16:26:03 2002
@@ -36,7 +36,7 @@
 #include <linux/pmu.h>
 #include <asm/irq.h>
 #endif
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
 
@@ -282,7 +282,7 @@
 static void
 pmac_ide_tuneproc(ide_drive_t *drive, byte pio)
 {
-	ide_pio_data_t d;
+	struct ide_timing *t;
 	int i;
 	u32 *timings;
 	int accessTicks, recTicks;
@@ -290,9 +290,15 @@
 	i = pmac_ide_find(drive);
 	if (i < 0)
 		return;
+	
+	if (pio = 255)	
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		pio = XFER_PIO_0 + min_t(byte, pio, 4);
 		
-	pio = ide_get_best_pio_mode(drive, pio, 4, &d);
-	accessTicks = SYSCLK_TICKS(ide_pio_timings[pio].active_time);
+	t = ide_timing_find_mode(pio);
+	
+	accessTicks = SYSCLK_TICKS(t->active);
 	if (drive->select.all & 0x10)
 		timings = &pmac_ide[i].timings[1];
 	else
@@ -300,16 +306,16 @@
 	
 	if (pmac_ide[i].kind == controller_kl_ata4) {
 		/* The "ata-4" IDE controller of Core99 machines */
-		accessTicks = SYSCLK_TICKS_UDMA(ide_pio_timings[pio].active_time * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(d.cycle_time * 1000) - accessTicks;
+		accessTicks = SYSCLK_TICKS_UDMA(t->active * 1000);
+		recTicks = SYSCLK_TICKS_UDMA(t->cycle * 1000) - accessTicks;
 
 		*timings = ((*timings) & 0x1FFFFFC00) | accessTicks | (recTicks << 5);
 	} else {
 		/* The old "ata-3" IDE controller */
-		accessTicks = SYSCLK_TICKS(ide_pio_timings[pio].active_time);
+		accessTicks = SYSCLK_TICKS(t->active);
 		if (accessTicks < 4)
 			accessTicks = 4;
-		recTicks = SYSCLK_TICKS(d.cycle_time) - accessTicks - 4;
+		recTicks = SYSCLK_TICKS(t->cycle) - accessTicks - 4;
 		if (recTicks < 1)
 			recTicks = 1;
 	
diff -urN linux-2.5.6/drivers/ide/ide-timing.c linux-2.5.6-timing/drivers/ide/ide-timing.c
--- linux-2.5.6/drivers/ide/ide-timing.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.6-timing/drivers/ide/ide-timing.c	Tue Mar 12 16:26:03 2002
@@ -0,0 +1,235 @@
+/*
+ * $Id: ide-timing.c,v 2.0 2002/03/12 15:48:43 vojtech Exp $
+ *
+ *  Copyright (c) 1999-2001 Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ */
+
+#include <linux/kernel.h>
+#include "ide-timing.h"
+
+/*
+ * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
+ * These were taken from ATA/ATAPI-6 standard, rev 0a, except
+ * for PIO 5, which is a nonstandard extension and UDMA6, which
+ * is currently supported only by Maxtor drives. 
+ */
+
+struct ide_timing ide_timing[] = {
+
+	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
+	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
+	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
+	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
+
+	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
+	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
+	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
+
+	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 },
+                                          
+	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
+	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
+	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
+                                          
+	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
+	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
+	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
+
+	{ XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 },
+	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
+	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
+
+	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
+	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
+	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },
+
+	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 },
+
+	{ -1 }
+};
+
+short ide_find_best_mode(ide_drive_t *drive, int map)
+{
+	struct hd_driveid *id = drive->id;
+	short best = 0;
+
+	if (!id)
+		return XFER_PIO_SLOW;
+
+	if ((map & XFER_UDMA) && (id->field_valid & 4)) {	/* Want UDMA and UDMA bitmap valid */
+
+		if ((map & XFER_UDMA_133) == XFER_UDMA_133)
+			if ((best = (id->dma_ultra & 0x0040) ? XFER_UDMA_6 : 0)) return best;
+
+		if ((map & XFER_UDMA_100) == XFER_UDMA_100)
+			if ((best = (id->dma_ultra & 0x0020) ? XFER_UDMA_5 : 0)) return best;
+
+		if ((map & XFER_UDMA_66) == XFER_UDMA_66)
+			if ((best = (id->dma_ultra & 0x0010) ? XFER_UDMA_4 :
+                	    	    (id->dma_ultra & 0x0008) ? XFER_UDMA_3 : 0)) return best;
+
+                if ((best = (id->dma_ultra & 0x0004) ? XFER_UDMA_2 :
+                	    (id->dma_ultra & 0x0002) ? XFER_UDMA_1 :
+                	    (id->dma_ultra & 0x0001) ? XFER_UDMA_0 : 0)) return best;
+	}
+
+	if ((map & XFER_MWDMA) && (id->field_valid & 2)) {	/* Want MWDMA and drive has EIDE fields */
+
+		if ((best = (id->dma_mword & 0x0004) ? XFER_MW_DMA_2 :
+                	    (id->dma_mword & 0x0002) ? XFER_MW_DMA_1 :
+                	    (id->dma_mword & 0x0001) ? XFER_MW_DMA_0 : 0)) return best;
+	}
+
+	if (map & XFER_SWDMA) {					/* Want SWDMA */
+
+ 		if (id->field_valid & 2) {			/* EIDE SWDMA */
+
+			if ((best = (id->dma_1word & 0x0004) ? XFER_SW_DMA_2 :
+      				    (id->dma_1word & 0x0002) ? XFER_SW_DMA_1 :
+				    (id->dma_1word & 0x0001) ? XFER_SW_DMA_0 : 0)) return best;
+		}
+
+		if (id->capability & 1) {			/* Pre-EIDE style SWDMA */
+
+			if ((best = (id->tDMA == 2) ? XFER_SW_DMA_2 :
+				    (id->tDMA == 1) ? XFER_SW_DMA_1 :
+				    (id->tDMA == 0) ? XFER_SW_DMA_0 : 0)) return best;
+		}
+	}
+
+
+	if ((map & XFER_EPIO) && (id->field_valid & 2)) {	/* EIDE PIO modes */
+
+		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
+			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
+			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
+	}
+	
+	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
+		(drive->id->tPIO == 1) ? XFER_PIO_1 :
+		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
+}
+
+void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
+{
+	q->setup   = EZ(t->setup   * 1000,  T);
+	q->act8b   = EZ(t->act8b   * 1000,  T);
+	q->rec8b   = EZ(t->rec8b   * 1000,  T);
+	q->cyc8b   = EZ(t->cyc8b   * 1000,  T);
+	q->active  = EZ(t->active  * 1000,  T);
+	q->recover = EZ(t->recover * 1000,  T);
+	q->cycle   = EZ(t->cycle   * 1000,  T);
+	q->udma    = EZ(t->udma    * 1000, UT);
+}
+
+void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
+{
+	if (what & IDE_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
+	if (what & IDE_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
+	if (what & IDE_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
+	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
+	if (what & IDE_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
+	if (what & IDE_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
+	if (what & IDE_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
+	if (what & IDE_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
+}
+
+struct ide_timing* ide_timing_find_mode(short speed)
+{
+	struct ide_timing *t;
+
+	for (t = ide_timing; t->mode != speed; t++)
+		if (t->mode < 0)
+			return NULL;
+	return t; 
+}
+
+int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT)
+{
+	struct hd_driveid *id = drive->id;
+	struct ide_timing *s, p;
+
+/*
+ * Find the mode.
+ */
+
+	if (!(s = ide_timing_find_mode(speed)))
+		return -EINVAL;
+
+/*
+ * If the drive is an EIDE drive, it can tell us it needs extended
+ * PIO/MWDMA cycle timing.
+ */
+
+	if (id && id->field_valid & 2) {	/* EIDE drive */
+
+		memset(&p, 0, sizeof(p));
+
+		switch (speed & XFER_MODE) {
+
+			case XFER_PIO:
+				if (speed <= XFER_PIO_2) p.cycle = p.cyc8b = id->eide_pio;
+						    else p.cycle = p.cyc8b = id->eide_pio_iordy;
+				break;
+
+			case XFER_MWDMA:
+				p.cycle = id->eide_dma_min;
+				break;
+		}
+
+		ide_timing_merge(&p, t, t, IDE_TIMING_CYCLE | IDE_TIMING_CYC8B);
+	}
+
+/*
+ * Convert the timing to bus clock counts.
+ */
+
+	ide_timing_quantize(s, t, T, UT);
+
+/*
+ * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
+ * and some other commands. We have to ensure that the DMA cycle timing is
+ * slower/equal than the fastest PIO timing.
+ */
+
+	if ((speed & XFER_MODE) != XFER_PIO) {
+		ide_timing_compute(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO), &p, T, UT);
+		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
+	}
+
+/*
+ * Lenghten active & recovery time so that cycle time is correct.
+ */
+
+	if (t->act8b + t->rec8b < t->cyc8b) {
+		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
+		t->rec8b = t->cyc8b - t->act8b;
+	}
+
+	if (t->active + t->recover < t->cycle) {
+		t->active += (t->cycle - (t->active + t->recover)) / 2;
+		t->recover = t->cycle - t->active;
+	}
+
+	return 0;
+}
diff -urN linux-2.5.6/drivers/ide/ide-timing.h linux-2.5.6-timing/drivers/ide/ide-timing.h
--- linux-2.5.6/drivers/ide/ide-timing.h	Wed Feb 20 03:11:04 2002
+++ linux-2.5.6-timing/drivers/ide/ide-timing.h	Tue Mar 12 16:29:03 2002
@@ -1,10 +1,11 @@
-#ifndef _IDE_TIMING_H
-#define _IDE_TIMING_H
+#ifndef _IDE_MODES_H
+#define _IDE_MODES_H
 
 /*
- * $Id: ide-timing.h,v 1.6 2001/12/23 22:47:56 vojtech Exp $
+ * $Id: ide-timing.h,v 2.0 2002/03/12 13:02:22 vojtech Exp $
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
+ *  Copyright (C) 1996  Linus Torvalds, Igor Abramov, and Mark Lord
+ *  Copyright (C) 1999-2001 Vojtech Pavlik
  */
 
 /*
@@ -21,13 +22,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/hdreg.h>
+#include <linux/ide.h>
 
 #define XFER_PIO_5		0x0d
 #define XFER_UDMA_SLOW		0x4f
@@ -44,46 +42,7 @@
 	short udma;	/* t2CYCTYP/2 */
 };
 
-/*
- * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
- * These were taken from ATA/ATAPI-6 standard, rev 0a, except
- * for PIO 5, which is a nonstandard extension and UDMA6, which
- * is currently supported only by Maxtor drives. 
- */
-
-static struct ide_timing ide_timing[] = {
-
-	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
-	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
-	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
-	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
-
-	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
-	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
-	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
-
-	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 },
-                                          
-	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
-	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
-	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
-                                          
-	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
-	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
-	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
-
-	{ XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 },
-	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
-	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
-
-	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
-	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
-	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },
-
-	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 },
-
-	{ -1 }
-};
+extern struct ide_timing ide_timing[];
 
 #define IDE_TIMING_SETUP	0x01
 #define IDE_TIMING_ACT8B	0x02
@@ -96,9 +55,7 @@
 #define IDE_TIMING_UDMA		0x80
 #define IDE_TIMING_ALL		0xff
 
-#define MIN(a,b)	((a)<(b)?(a):(b))
-#define MAX(a,b)	((a)>(b)?(a):(b))
-#define FIT(v,min,max)	MAX(MIN(v,max),min)
+#define FIT(v,x,y)	max_t(int,min_t(int,v,x),y)
 #define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
 #define EZ(v,unit)	((v)?ENOUGH(v,unit):0)
 
@@ -112,170 +69,20 @@
 #define XFER_EPIO	0x01
 #define XFER_PIO	0x00
 
-static short ide_find_best_mode(ide_drive_t *drive, int map)
-{
-	struct hd_driveid *id = drive->id;
-	short best = 0;
-
-	if (!id)
-		return XFER_PIO_SLOW;
-
-	if ((map & XFER_UDMA) && (id->field_valid & 4)) {	/* Want UDMA and UDMA bitmap valid */
-
-		if ((map & XFER_UDMA_133) == XFER_UDMA_133)
-			if ((best = (id->dma_ultra & 0x0040) ? XFER_UDMA_6 : 0)) return best;
-
-		if ((map & XFER_UDMA_100) == XFER_UDMA_100)
-			if ((best = (id->dma_ultra & 0x0020) ? XFER_UDMA_5 : 0)) return best;
-
-		if ((map & XFER_UDMA_66) == XFER_UDMA_66)
-			if ((best = (id->dma_ultra & 0x0010) ? XFER_UDMA_4 :
-                	    	    (id->dma_ultra & 0x0008) ? XFER_UDMA_3 : 0)) return best;
-
-                if ((best = (id->dma_ultra & 0x0004) ? XFER_UDMA_2 :
-                	    (id->dma_ultra & 0x0002) ? XFER_UDMA_1 :
-                	    (id->dma_ultra & 0x0001) ? XFER_UDMA_0 : 0)) return best;
-	}
-
-	if ((map & XFER_MWDMA) && (id->field_valid & 2)) {	/* Want MWDMA and drive has EIDE fields */
-
-		if ((best = (id->dma_mword & 0x0004) ? XFER_MW_DMA_2 :
-                	    (id->dma_mword & 0x0002) ? XFER_MW_DMA_1 :
-                	    (id->dma_mword & 0x0001) ? XFER_MW_DMA_0 : 0)) return best;
-	}
-
-	if (map & XFER_SWDMA) {					/* Want SWDMA */
-
- 		if (id->field_valid & 2) {			/* EIDE SWDMA */
-
-			if ((best = (id->dma_1word & 0x0004) ? XFER_SW_DMA_2 :
-      				    (id->dma_1word & 0x0002) ? XFER_SW_DMA_1 :
-				    (id->dma_1word & 0x0001) ? XFER_SW_DMA_0 : 0)) return best;
-		}
-
-		if (id->capability & 1) {			/* Pre-EIDE style SWDMA */
-
-			if ((best = (id->tDMA == 2) ? XFER_SW_DMA_2 :
-				    (id->tDMA == 1) ? XFER_SW_DMA_1 :
-				    (id->tDMA == 0) ? XFER_SW_DMA_0 : 0)) return best;
-		}
-	}
-
-
-	if ((map & XFER_EPIO) && (id->field_valid & 2)) {	/* EIDE PIO modes */
-
-		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
-			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
-			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
-	}
-	
-	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
-		(drive->id->tPIO == 1) ? XFER_PIO_1 :
-		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
-}
-
-static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
-{
-	q->setup   = EZ(t->setup   * 1000,  T);
-	q->act8b   = EZ(t->act8b   * 1000,  T);
-	q->rec8b   = EZ(t->rec8b   * 1000,  T);
-	q->cyc8b   = EZ(t->cyc8b   * 1000,  T);
-	q->active  = EZ(t->active  * 1000,  T);
-	q->recover = EZ(t->recover * 1000,  T);
-	q->cycle   = EZ(t->cycle   * 1000,  T);
-	q->udma    = EZ(t->udma    * 1000, UT);
-}
-
-static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
-{
-	if (what & IDE_TIMING_SETUP  ) m->setup   = MAX(a->setup,   b->setup);
-	if (what & IDE_TIMING_ACT8B  ) m->act8b   = MAX(a->act8b,   b->act8b);
-	if (what & IDE_TIMING_REC8B  ) m->rec8b   = MAX(a->rec8b,   b->rec8b);
-	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = MAX(a->cyc8b,   b->cyc8b);
-	if (what & IDE_TIMING_ACTIVE ) m->active  = MAX(a->active,  b->active);
-	if (what & IDE_TIMING_RECOVER) m->recover = MAX(a->recover, b->recover);
-	if (what & IDE_TIMING_CYCLE  ) m->cycle   = MAX(a->cycle,   b->cycle);
-	if (what & IDE_TIMING_UDMA   ) m->udma    = MAX(a->udma,    b->udma);
-}
-
-static struct ide_timing* ide_timing_find_mode(short speed)
-{
-	struct ide_timing *t;
-
-	for (t = ide_timing; t->mode != speed; t++)
-		if (t->mode < 0)
-			return NULL;
-	return t; 
-}
-
-static int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT)
-{
-	struct hd_driveid *id = drive->id;
-	struct ide_timing *s, p;
-
-/*
- * Find the mode.
- */
-
-	if (!(s = ide_timing_find_mode(speed)))
-		return -EINVAL;
-
-/*
- * If the drive is an EIDE drive, it can tell us it needs extended
- * PIO/MWDMA cycle timing.
- */
-
-	if (id && id->field_valid & 2) {	/* EIDE drive */
-
-		memset(&p, 0, sizeof(p));
-
-		switch (speed & XFER_MODE) {
-
-			case XFER_PIO:
-				if (speed <= XFER_PIO_2) p.cycle = p.cyc8b = id->eide_pio;
-						    else p.cycle = p.cyc8b = id->eide_pio_iordy;
-				break;
-
-			case XFER_MWDMA:
-				p.cycle = id->eide_dma_min;
-				break;
-		}
-
-		ide_timing_merge(&p, t, t, IDE_TIMING_CYCLE | IDE_TIMING_CYC8B);
-	}
+extern short ide_find_best_mode(ide_drive_t *drive, int map);
+extern void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT);
+extern void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what);
+extern struct ide_timing* ide_timing_find_mode(short speed);
+extern int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT);
 
 /*
- * Convert the timing to bus clock counts.
+ * Backward compatibility stuff.
  */
 
-	ide_timing_quantize(s, t, T, UT);
-
-/*
- * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
- * and some other commands. We have to ensure that the DMA cycle timing is
- * slower/equal than the fastest PIO timing.
- */
-
-	if ((speed & XFER_MODE) != XFER_PIO) {
-		ide_timing_compute(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO), &p, T, UT);
-		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
-	}
-
-/*
- * Lenghten active & recovery time so that cycle time is correct.
- */
-
-	if (t->act8b + t->rec8b < t->cyc8b) {
-		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
-		t->rec8b = t->cyc8b - t->act8b;
-	}
-
-	if (t->active + t->recover < t->cycle) {
-		t->active += (t->cycle - (t->active + t->recover)) / 2;
-		t->recover = t->cycle - t->active;
-	}
-
-	return 0;
-}
+typedef struct ide_pio_timings_s {
+	int	setup_time;	/* Address setup (ns) minimum */
+	int	active_time;	/* Active pulse (ns) minimum */
+	int	cycle_time;	/* Cycle time (ns) minimum = (setup + active + recovery) */
+} ide_pio_timings_t;
 
 #endif
diff -urN linux-2.5.6/drivers/ide/ide.c linux-2.5.6-timing/drivers/ide/ide.c
--- linux-2.5.6/drivers/ide/ide.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/ide.c	Tue Mar 12 16:26:03 2002
@@ -149,7 +149,7 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /*
  * Those will be moved into separate header files eventually.
@@ -194,94 +194,6 @@
 extern void pnpide_init(int);
 #endif
 
-/*
- * Constant tables for PIO mode programming:
- */
-const ide_pio_timings_t ide_pio_timings[6] = {
-	{ 70,	165,	600 },	/* PIO Mode 0 */
-	{ 50,	125,	383 },	/* PIO Mode 1 */
-	{ 30,	100,	240 },	/* PIO Mode 2 */
-	{ 30,	80,	180 },	/* PIO Mode 3 with IORDY */
-	{ 25,	70,	120 },	/* PIO Mode 4 with IORDY */
-	{ 20,	50,	100 }	/* PIO Mode 5 with IORDY (nonstandard) */
-};
-
-/*
- * Black list. Some drives incorrectly report their maximal PIO mode,
- * at least in respect to CMD640. Here we keep info on some known drives.
- */
-static struct ide_pio_info {
-	const char	*name;
-	int		pio;
-} ide_pio_blacklist[] = {
-/*	{ "Conner Peripherals 1275MB - CFS1275A", 4 }, */
-	{ "Conner Peripherals 540MB - CFS540A", 3 },
-
-	{ "WDC AC2700",  3 },
-	{ "WDC AC2540",  3 },
-	{ "WDC AC2420",  3 },
-	{ "WDC AC2340",  3 },
-	{ "WDC AC2250",  0 },
-	{ "WDC AC2200",  0 },
-	{ "WDC AC21200", 4 },
-	{ "WDC AC2120",  0 },
-	{ "WDC AC2850",  3 },
-	{ "WDC AC1270",  3 },
-	{ "WDC AC1170",  1 },
-	{ "WDC AC1210",  1 },
-	{ "WDC AC280",   0 },
-/*	{ "WDC AC21000", 4 }, */
-	{ "WDC AC31000", 3 },
-	{ "WDC AC31200", 3 },
-/*	{ "WDC AC31600", 4 }, */
-
-	{ "Maxtor 7131 AT", 1 },
-	{ "Maxtor 7171 AT", 1 },
-	{ "Maxtor 7213 AT", 1 },
-	{ "Maxtor 7245 AT", 1 },
-	{ "Maxtor 7345 AT", 1 },
-	{ "Maxtor 7546 AT", 3 },
-	{ "Maxtor 7540 AV", 3 },
-
-	{ "SAMSUNG SHD-3121A", 1 },
-	{ "SAMSUNG SHD-3122A", 1 },
-	{ "SAMSUNG SHD-3172A", 1 },
-
-/*	{ "ST51080A", 4 },
- *	{ "ST51270A", 4 },
- *	{ "ST31220A", 4 },
- *	{ "ST31640A", 4 },
- *	{ "ST32140A", 4 },
- *	{ "ST3780A",  4 },
- */
-	{ "ST5660A",  3 },
-	{ "ST3660A",  3 },
-	{ "ST3630A",  3 },
-	{ "ST3655A",  3 },
-	{ "ST3391A",  3 },
-	{ "ST3390A",  1 },
-	{ "ST3600A",  1 },
-	{ "ST3290A",  0 },
-	{ "ST3144A",  0 },
-	{ "ST3491A",  1 },	/* reports 3, should be 1 or 2 (depending on
-				 * drive) according to Seagates FIND-ATA program */
-
-	{ "QUANTUM ELS127A", 0 },
-	{ "QUANTUM ELS170A", 0 },
-	{ "QUANTUM LPS240A", 0 },
-	{ "QUANTUM LPS210A", 3 },
-	{ "QUANTUM LPS270A", 3 },
-	{ "QUANTUM LPS365A", 3 },
-	{ "QUANTUM LPS540A", 3 },
-	{ "QUANTUM LIGHTNING 540A", 3 },
-	{ "QUANTUM LIGHTNING 730A", 3 },
-
-        { "QUANTUM FIREBALL_540", 3 }, /* Older Quantum Fireballs don't work */
-        { "QUANTUM FIREBALL_640", 3 },
-        { "QUANTUM FIREBALL_1080", 3 },
-        { "QUANTUM FIREBALL_1280", 3 },
-	{ NULL,	0 }
-};
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES	1
@@ -314,105 +226,6 @@
  */
 ide_hwif_t ide_hwifs[MAX_HWIFS];	/* master data repository */
 
-
-/*
- * This routine searches the ide_pio_blacklist for an entry
- * matching the start/whole of the supplied model name.
- *
- * Returns -1 if no match found.
- * Otherwise returns the recommended PIO mode from ide_pio_blacklist[].
- */
-int ide_scan_pio_blacklist (char *model)
-{
-	struct ide_pio_info *p;
-
-	for (p = ide_pio_blacklist; p->name != NULL; p++) {
-		if (strncmp(p->name, model, strlen(p->name)) == 0)
-			return p->pio;
-	}
-	return -1;
-}
-
-/*
- * This routine returns the recommended PIO settings for a given drive,
- * based on the drive->id information and the ide_pio_blacklist[].
- * This is used by most chipset support modules when "auto-tuning".
- */
-
-/*
- * Drive PIO mode auto selection
- */
-byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d)
-{
-	int pio_mode;
-	int cycle_time = 0;
-	int use_iordy = 0;
-	struct hd_driveid* id = drive->id;
-	int overridden  = 0;
-	int blacklisted = 0;
-
-	if (mode_wanted != 255) {
-		pio_mode = mode_wanted;
-	} else if (!drive->id) {
-		pio_mode = 0;
-	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
-		overridden = 1;
-		blacklisted = 1;
-		use_iordy = (pio_mode > 2);
-	} else {
-		pio_mode = id->tPIO;
-		if (pio_mode > 2) {	/* 2 is maximum allowed tPIO value */
-			pio_mode = 2;
-			overridden = 1;
-		}
-		if (id->field_valid & 2) {	  /* drive implements ATA2? */
-			if (id->capability & 8) { /* drive supports use_iordy? */
-				use_iordy = 1;
-				cycle_time = id->eide_pio_iordy;
-				if (id->eide_pio_modes & 7) {
-					overridden = 0;
-					if (id->eide_pio_modes & 4)
-						pio_mode = 5;
-					else if (id->eide_pio_modes & 2)
-						pio_mode = 4;
-					else
-						pio_mode = 3;
-				}
-			} else {
-				cycle_time = id->eide_pio;
-			}
-		}
-
-#if 0
-		if (drive->id->major_rev_num & 0x0004) printk("ATA-2 ");
-#endif
-
-		/*
-		 * Conservative "downgrade" for all pre-ATA2 drives
-		 */
-		if (pio_mode && pio_mode < 4) {
-			pio_mode--;
-			overridden = 1;
-#if 0
-			use_iordy = (pio_mode > 2);
-#endif
-			if (cycle_time && cycle_time < ide_pio_timings[pio_mode].cycle_time)
-				cycle_time = 0; /* use standard timing */
-		}
-	}
-	if (pio_mode > max_mode) {
-		pio_mode = max_mode;
-		cycle_time = 0;
-	}
-	if (d) {
-		d->pio_mode = pio_mode;
-		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
-		d->use_iordy = use_iordy;
-		d->overridden = overridden;
-		d->blacklisted = blacklisted;
-	}
-	return pio_mode;
-}
 
 #if (DISK_RECOVERY_TIME > 0)
 /*
diff -urN linux-2.5.6/drivers/ide/ide_modes.h linux-2.5.6-timing/drivers/ide/ide_modes.h
--- linux-2.5.6/drivers/ide/ide_modes.h	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/ide_modes.h	Thu Jan  1 01:00:00 1970
@@ -1,42 +0,0 @@
-/*
- *  linux/drivers/ide/ide_modes.h
- *
- *  Copyright (C) 1996  Linus Torvalds, Igor Abramov, and Mark Lord
- */
-
-#ifndef _IDE_MODES_H
-#define _IDE_MODES_H
-
-#include <linux/config.h>
-
-/*
- * Shared data/functions for determining best PIO mode for an IDE drive.
- */
-
-#ifdef CONFIG_BLK_DEV_IDE_MODES
-
-/*
- * Standard (generic) timings for PIO modes, from ATA2 specification.
- * These timings are for access to the IDE data port register *only*.
- * Some drives may specify a mode, while also specifying a different
- * value for cycle_time (from drive identification data).
- */
-typedef struct ide_pio_timings_s {
-	int	setup_time;	/* Address setup (ns) minimum */
-	int	active_time;	/* Active pulse (ns) minimum */
-	int	cycle_time;	/* Cycle time (ns) minimum = (setup + active + recovery) */
-} ide_pio_timings_t;
-
-typedef struct ide_pio_data_s {
-	byte pio_mode;
-	byte use_iordy;
-	byte overridden;
-	byte blacklisted;
-	unsigned int cycle_time;
-} ide_pio_data_t;
-
-extern int ide_scan_pio_blacklist (char *model);
-extern byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d);
-extern const ide_pio_timings_t ide_pio_timings[6];
-#endif
-#endif
diff -urN linux-2.5.6/drivers/ide/it8172.c linux-2.5.6-timing/drivers/ide/it8172.c
--- linux-2.5.6/drivers/ide/it8172.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/it8172.c	Tue Mar 12 16:26:03 2002
@@ -41,7 +41,7 @@
 #include <asm/io.h>
 #include <asm/it8172/it8172_int.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /*
  * Prototypes
@@ -65,7 +65,11 @@
     int master_port	= 0x40;
     int slave_port      = 0x44;
     
-    pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+    if (pio == 255)
+	pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+    else
+       pio = min_t(byte, pio, 4);
+
     pci_read_config_word(HWIF(drive)->pci_dev, master_port, &master_data);
     pci_read_config_dword(HWIF(drive)->pci_dev, slave_port, &slave_data);
 
@@ -186,25 +190,7 @@
     struct hd_driveid *id = drive->id;
     byte speed;
 
-    if (id->dma_ultra & 0x0010) {
-	speed = XFER_UDMA_2;
-    } else if (id->dma_ultra & 0x0008) {
-	speed = XFER_UDMA_1;
-    } else if (id->dma_ultra & 0x0004) {
-	speed = XFER_UDMA_2;
-    } else if (id->dma_ultra & 0x0002) {
-	speed = XFER_UDMA_1;
-    } else if (id->dma_ultra & 0x0001) {
-	speed = XFER_UDMA_0;
-    } else if (id->dma_mword & 0x0004) {
-	speed = XFER_MW_DMA_2;
-    } else if (id->dma_mword & 0x0002) {
-	speed = XFER_MW_DMA_1;
-    } else if (id->dma_1word & 0x0004) {
-	speed = XFER_SW_DMA_2;
-    } else {
-	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
-    }
+    speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA | XFER_UDMA);
 
     (void) it8172_tune_chipset(drive, speed);
 
diff -urN linux-2.5.6/drivers/ide/opti621.c linux-2.5.6-timing/drivers/ide/opti621.c
--- linux-2.5.6/drivers/ide/opti621.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/opti621.c	Tue Mar 12 16:26:03 2002
@@ -97,7 +97,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define OPTI621_MAX_PIO 3
 /* In fact, I do not have any PIO 4 drive
@@ -144,12 +144,16 @@
 	int d;
 	ide_hwif_t *hwif = HWIF(drive);
 
-	drive->drive_data = ide_get_best_pio_mode(drive, pio, OPTI621_MAX_PIO, NULL);
+	if (pio == PIO_DONT_KNOW)
+		drive->drive_data = min(ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0, OPTI621_MAX_PIO);
+	else
+		drive->drive_data = pio;
+		
 	for (d = 0; d < 2; ++d) {
 		drive = &hwif->drives[d];
 		if (drive->present) {
 			if (drive->drive_data == PIO_DONT_KNOW)
-				drive->drive_data = ide_get_best_pio_mode(drive, 255, OPTI621_MAX_PIO, NULL);
+				drive->drive_data = min(ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0, OPTI621_MAX_PIO);
 #ifdef OPTI621_DEBUG
 			printk("%s: Selected PIO mode %d\n", drive->name, drive->drive_data);
 #endif
diff -urN linux-2.5.6/drivers/ide/pdc202xx.c linux-2.5.6-timing/drivers/ide/pdc202xx.c
--- linux-2.5.6/drivers/ide/pdc202xx.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/pdc202xx.c	Tue Mar 12 16:26:03 2002
@@ -46,7 +46,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define PDC202XX_DEBUG_DRIVE_INFO		0
 #define PDC202XX_DECODE_REGISTER_INFO		0
@@ -681,8 +681,10 @@
 {
 	byte speed = 0x00;
 
-	pio = (pio == 5) ? 4 : pio;
-	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
+	if (pio == 255)
+		speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		speed = XFER_PIO_0 + min_t(byte, pio, 4);
         
 	return ((int) pdc202xx_tune_chipset(drive, speed));
 }
diff -urN linux-2.5.6/drivers/ide/pdcadma.c linux-2.5.6-timing/drivers/ide/pdcadma.c
--- linux-2.5.6/drivers/ide/pdcadma.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/pdcadma.c	Tue Mar 12 16:26:03 2002
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #undef DISPLAY_PDCADMA_TIMINGS
 
diff -urN linux-2.5.6/drivers/ide/piix.c linux-2.5.6-timing/drivers/ide/piix.c
--- linux-2.5.6/drivers/ide/piix.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/piix.c	Tue Mar 12 16:26:03 2002
@@ -65,7 +65,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define PIIX_DEBUG_DRIVE_INFO		0
 
@@ -225,7 +225,11 @@
 				    { 2, 1 },
 				    { 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+	else
+		pio = min_t(byte, pio, 4);
+
 	pci_read_config_word(HWIF(drive)->pci_dev, master_port, &master_data);
 	if (is_slave) {
 		master_data = master_data | 0x4000;
@@ -352,27 +356,9 @@
 				   (dev->device == PCI_DEVICE_ID_INTEL_82451NX) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AB_1)) ? 1 : 0;
 
-	if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100)) {
-		speed = XFER_UDMA_5;
-	} else if ((id->dma_ultra & 0x0010) && (ultra)) {
-		speed = ((udma_66) && (ultra66)) ? XFER_UDMA_4 : XFER_UDMA_2;
-	} else if ((id->dma_ultra & 0x0008) && (ultra)) {
-		speed = ((udma_66) && (ultra66)) ? XFER_UDMA_3 : XFER_UDMA_1;
-	} else if ((id->dma_ultra & 0x0004) && (ultra)) {
-		speed = XFER_UDMA_2;
-	} else if ((id->dma_ultra & 0x0002) && (ultra)) {
-		speed = XFER_UDMA_1;
-	} else if ((id->dma_ultra & 0x0001) && (ultra)) {
-		speed = XFER_UDMA_0;
-	} else if (id->dma_mword & 0x0004) {
-		speed = XFER_MW_DMA_2;
-	} else if (id->dma_mword & 0x0002) {
-		speed = XFER_MW_DMA_1;
-	} else if (id->dma_1word & 0x0004) {
-		speed = XFER_SW_DMA_2;
-        } else {
-		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
-	}
+	speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA
+					| (ultra ? XFER_UDMA : 0) | ((udma_66 & ultra66) ? XFER_UDMA_66 : 0)
+					| ((udma_66 & ultra100) ? XFER_UDMA_100 : 0));
 
 	(void) piix_tune_chipset(drive, speed);
 
@@ -385,7 +371,7 @@
 
 static void config_chipset_for_pio (ide_drive_t *drive)
 {
-	piix_tune_drive(drive, ide_get_best_pio_mode(drive, 255, 5, NULL));
+	piix_tune_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0);
 }
 
 static int config_drive_xfer_rate (ide_drive_t *drive)
diff -urN linux-2.5.6/drivers/ide/qd65xx.c linux-2.5.6-timing/drivers/ide/qd65xx.c
--- linux-2.5.6/drivers/ide/qd65xx.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/qd65xx.c	Tue Mar 12 16:26:03 2002
@@ -33,7 +33,7 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 #include "qd65xx.h"
 
 /*
@@ -249,42 +249,46 @@
 
 static void qd6580_tune_drive (ide_drive_t *drive, byte pio)
 {
-	ide_pio_data_t d;
+	struct ide_timing *t;
 	int base = HWIF(drive)->select_data;
 	int active_time   = 175;
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive,&active_time,&recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
-		pio = min(pio,4);
+
+		if (pio == 255)
+			pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+		else
+			pio = XFER_PIO_0 + min_t(byte, pio, 4);
+
+		t = ide_timing_find_mode(pio);
 
 		switch (pio) {
 			case 0: break;
 			case 3:
-				if (d.cycle_time >= 110) {
+				if (t->cycle >= 110) {
 					active_time = 86;
-					recovery_time = d.cycle_time-102;
+					recovery_time = t->cycle-102;
 				} else
 					printk(KERN_WARNING "%s: Strange recovery time !\n",drive->name);
 				break;
 			case 4:
-				if (d.cycle_time >= 69) {
+				if (t->cycle >= 69) {
 					active_time = 70;
-					recovery_time = d.cycle_time-61;
+					recovery_time = t->cycle-61;
 				} else
 					printk(KERN_WARNING "%s: Strange recovery time !\n",drive->name);
 				break;
 			default:
-				if (d.cycle_time >= 180) {
+				if (t->cycle >= 180) {
 					active_time = 110;
-					recovery_time = d.cycle_time - 120;
+					recovery_time = t->cycle - 120;
 				} else {
-					active_time = ide_pio_timings[pio].active_time;
-					recovery_time = d.cycle_time
-							-active_time;
+					active_time = t->active;
+					recovery_time = t->cycle - active_time;
 				}
 		}
-		printk(KERN_INFO "%s: PIO mode%d\n",drive->name,pio);
+		printk(KERN_INFO "%s: PIO mode%d\n", drive->name, pio - XFER_PIO_0);
 	}
 
 	if (!HWIF(drive)->channel && drive->type != ATA_DISK) {
diff -urN linux-2.5.6/drivers/ide/serverworks.c linux-2.5.6-timing/drivers/ide/serverworks.c
--- linux-2.5.6/drivers/ide/serverworks.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/serverworks.c	Tue Mar 12 16:26:03 2002
@@ -91,7 +91,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define DISPLAY_SVWKS_TIMINGS	1
 #undef SVWKS_DEBUG_DRIVE_INFO
@@ -263,7 +263,7 @@
 	byte pio_timing		= 0x00;
 	unsigned short csb5_pio	= 0x00;
 
-	byte pio	= ide_get_best_pio_mode(drive, 255, 5, NULL);
+	byte pio	= ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
         switch (drive->dn) {
 		case 0: drive_pci = 0x41; drive_pci2 = 0x45; break;
@@ -364,9 +364,9 @@
 	unsigned short xfer_pio = drive->id->eide_pio_modes;
 	byte timing, speed, pio;
 
-	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
+	pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
-	if (xfer_pio> 4)
+	if (xfer_pio > 4)
 		xfer_pio = 0;
 
 	if (drive->id->eide_pio_iordy > 0)
@@ -417,29 +417,10 @@
 	byte udma_66	= eighty_ninty_three(drive);
 	int ultra66	= (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : 0;
 	int ultra100 	= (ultra66 && svwks_revision >= SVWKS_CSB5_REVISION_NEW) ? 1 : 0;
-	byte speed;
 
-	if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100)) {
-		speed = XFER_UDMA_5;
-	} else if (id->dma_ultra & 0x0010) {
-		speed = ((udma_66) && (ultra66)) ? XFER_UDMA_4 : XFER_UDMA_2;
-	} else if (id->dma_ultra & 0x0008) {
-		speed = ((udma_66) && (ultra66)) ? XFER_UDMA_3 : XFER_UDMA_1;
-	} else if (id->dma_ultra & 0x0004) {
-		speed = XFER_UDMA_2;
-	} else if (id->dma_ultra & 0x0002) {
-		speed = XFER_UDMA_1;
-	} else if (id->dma_ultra & 0x0001) {
-		speed = XFER_UDMA_0;
-	} else if (id->dma_mword & 0x0004) {
-		speed = XFER_MW_DMA_2;
-	} else if (id->dma_mword & 0x0002) {
-		speed = XFER_MW_DMA_1;
-	} else if (id->dma_1word & 0x0004) {
-		speed = XFER_SW_DMA_2;
-	} else {
-		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
-	}
+	byte speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA | XFER_UDMA
+				| ((udma_66 && ultra66) ? XFER_UDMA_66 : 0)
+				| ((udma_66 && ultra100) ? XFER_UDMA_100 : 0));
 
 	(void) svwks_tune_chipset(drive, speed);
 
diff -urN linux-2.5.6/drivers/ide/sis5513.c linux-2.5.6-timing/drivers/ide/sis5513.c
--- linux-2.5.6/drivers/ide/sis5513.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/sis5513.c	Tue Mar 12 16:26:03 2002
@@ -26,7 +26,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define DISPLAY_SIS_TIMINGS
 #define SIS5513_DEBUG_DRIVE_INFO	0
@@ -256,7 +256,9 @@
 	unsigned short xfer_pio = drive->id->eide_pio_modes;
 
 	config_drive_art_rwp(drive);
-	pio = ide_get_best_pio_mode(drive, 255, pio, NULL);
+	
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 	if (xfer_pio> 4)
 		xfer_pio = 0;
diff -urN linux-2.5.6/drivers/ide/sl82c105.c linux-2.5.6-timing/drivers/ide/sl82c105.c
--- linux-2.5.6/drivers/ide/sl82c105.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/sl82c105.c	Tue Mar 12 16:26:03 2002
@@ -22,7 +22,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 extern char *ide_xfer_verbose (byte xfer_rate);
 
@@ -31,13 +31,13 @@
  * times for the interface.  This has protection against run-away
  * timings.
  */
-static unsigned int get_timing_sl82c105(ide_pio_data_t *p)
+static unsigned int get_timing_sl82c105(struct ide_timing *t)
 {
 	unsigned int cmd_on;
 	unsigned int cmd_off;
 
-	cmd_on = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
-	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
+	cmd_on = (t->active + 29) / 30;
+	cmd_off = (t->cycle - 30 * cmd_on + 29) / 30;
 
 	if (cmd_on > 32)
 		cmd_on = 32;
@@ -49,7 +49,7 @@
 	if (cmd_off == 0)
 		cmd_off = 1;
 
-	return (cmd_on - 1) << 8 | (cmd_off - 1) | (p->use_iordy ? 0x40 : 0x00);
+	return (cmd_on - 1) << 8 | (cmd_off - 1) | ((t->mode > XFER_PIO_2) ? 0x40 : 0x00);
 }
 
 /*
@@ -59,25 +59,21 @@
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
-	ide_pio_data_t p;
+	struct ide_timing *t;
 	unsigned short drv_ctrl = 0x909;
 	unsigned int xfer_mode, reg;
 
 	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
+	if (pio == 255)
+		xfer_mode = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else
+		xfer_mode = XFER_PIO_0 + min_t(byte, pio, 4);
 
-	switch (pio) {
-	default:
-	case 0:		xfer_mode = XFER_PIO_0;		break;
-	case 1:		xfer_mode = XFER_PIO_1;		break;
-	case 2:		xfer_mode = XFER_PIO_2;		break;
-	case 3:		xfer_mode = XFER_PIO_3;		break;
-	case 4:		xfer_mode = XFER_PIO_4;		break;
-	}
+	t = ide_timing_find_mode(xfer_mode);
 
 	if (ide_config_drive_speed(drive, xfer_mode) == 0)
-		drv_ctrl = get_timing_sl82c105(&p);
+		drv_ctrl = get_timing_sl82c105(t);
 
 	if (drive->using_dma == 0) {
 		/*
@@ -89,7 +85,7 @@
 
 		if (report) {
 			printk("%s: selected %s (%dns) (%04X)\n", drive->name,
-			       ide_xfer_verbose(xfer_mode), p.cycle_time, drv_ctrl);
+			       ide_xfer_verbose(xfer_mode), t->cycle, drv_ctrl);
 		}
 	}
 }
diff -urN linux-2.5.6/drivers/ide/slc90e66.c linux-2.5.6-timing/drivers/ide/slc90e66.c
--- linux-2.5.6/drivers/ide/slc90e66.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.6-timing/drivers/ide/slc90e66.c	Tue Mar 12 16:26:03 2002
@@ -48,7 +48,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 #define SLC90E66_DEBUG_DRIVE_INFO		0
 
@@ -202,7 +202,11 @@
 				    { 2, 1 },
 				    { 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+	else
+		pio = min_t(byte, pio, 4);
+
 	pci_read_config_word(HWIF(drive)->pci_dev, master_port, &master_data);
 	if (is_slave) {
 		master_data = master_data | 0x4000;
@@ -299,30 +303,14 @@
 
 #if 1 /* allow PIO modes */
 	if (!HWIF(drive)->autodma) {
-		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
+		speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
 		(void) slc90e66_tune_chipset(drive, speed);
 		return ((int) ide_dma_off_quietly);
 	}
 #endif
-	if ((id->dma_ultra & 0x0010) && (ultra)) {
-		speed = (udma_66) ? XFER_UDMA_4 : XFER_UDMA_2;
-	} else if ((id->dma_ultra & 0x0008) && (ultra)) {
-		speed = (udma_66) ? XFER_UDMA_3 : XFER_UDMA_1;
-	} else if ((id->dma_ultra & 0x0004) && (ultra)) {
-		speed = XFER_UDMA_2;
-	} else if ((id->dma_ultra & 0x0002) && (ultra)) {
-		speed = XFER_UDMA_1;
-	} else if ((id->dma_ultra & 0x0001) && (ultra)) {
-		speed = XFER_UDMA_0;
-	} else if (id->dma_mword & 0x0004) {
-		speed = XFER_MW_DMA_2;
-	} else if (id->dma_mword & 0x0002) {
-		speed = XFER_MW_DMA_1;
-	} else if (id->dma_1word & 0x0004) {
-		speed = XFER_SW_DMA_2;
-        } else {
-		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
-	}
+
+	speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA 
+					| (ultra ? XFER_UDMA : 0) | ((ultra && udma_66) ? XFER_UDMA_66 : 0));
 
 	(void) slc90e66_tune_chipset(drive, speed);
 
diff -urN linux-2.5.6/drivers/ide/umc8672.c linux-2.5.6-timing/drivers/ide/umc8672.c
--- linux-2.5.6/drivers/ide/umc8672.c	Wed Feb 20 03:10:59 2002
+++ linux-2.5.6-timing/drivers/ide/umc8672.c	Tue Mar 12 16:26:03 2002
@@ -52,7 +52,7 @@
 
 #include <asm/io.h>
 
-#include "ide_modes.h"
+#include "ide-timing.h"
 
 /*
  * Default speeds.  These can be changed with "auto-tune" and/or hdparm.
@@ -113,7 +113,11 @@
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = ide_hwifs[HWIF(drive)->index^1].hwgroup;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	if (pio == 255)
+		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+	else
+		pio = min_t(byte, pio, 4);
+
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n", drive->name, pio, pio_to_umc[pio]);
 	save_flags(flags);	/* all CPUs */
 	cli();			/* all CPUs */
diff -urN linux-2.5.6/drivers/ide/via82cxxx.c linux-2.5.6-timing/drivers/ide/via82cxxx.c
--- linux-2.5.6/drivers/ide/via82cxxx.c	Tue Mar 12 16:05:40 2002
+++ linux-2.5.6-timing/drivers/ide/via82cxxx.c	Tue Mar 12 16:26:03 2002
@@ -352,7 +352,7 @@
 		return;
 	}
 
-	via_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
+	via_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA

--n8g4imXOkfNTN/H1--
