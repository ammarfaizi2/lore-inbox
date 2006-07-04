Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWGDXpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWGDXpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 19:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWGDXpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 19:45:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38833 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932358AbWGDXpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 19:45:20 -0400
Date: Wed, 5 Jul 2006 01:44:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de,
       metan@seznam.cz, arminlitzel@web.de, pavel.urban@ct.cz
Subject: collie: charger partially working
Message-ID: <20060704234414.GA5307@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got battery reading/charging code at collie to somehow working
state, and to my surprise, battery voltage actually went _down_ when I
enabled my charge-control code.

I was suspecting something strange before (battery was warm to touch
when it should not have been charged, it was charged too fast when
charger was off), and this confirms it: it looks like default collie
bootstate is with charger _enabled_.

It does not actually harm, because hardware charger knows when to stop
charging itself, but...

My bigdiff attached -- warning, it is ugly at places. Help determining
right thresholds for...

struct battery_thresh collie_battery_levels_acin[] = {
struct battery_thresh collie_battery_levels[] = {

...would be nice. I guess that just takes little patience: discharge
collie, and notice how voltage changes with time. (I believe some oz
had quite accurate gauges?)

Warning #2: this plays with lithium. But I guess older versions abused
lithium in much worse ways, so...

(I'd not leave collie unattended with both battery and charger plugged
in, though.)

Question: sharpsl_pm only checks if temperature > limit,
AFAICS. Should not it check if temperature is between two limits? IIRC
li-ions should not be charged when room temperature is <5 Celsius or
>40 Celsius or so...

								Pavel

diff --git a/Makefile b/Makefile
index 11a850c..ab4eba2 100644
--- a/Makefile
+++ b/Makefile
@@ -149,10 +149,7 @@ export srctree objtree VPATH TOPDIR
 # then ARCH is assigned, getting whatever value it gets normally, and 
 # SUBARCH is subsequently ignored.
 
-SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
-				  -e s/arm.*/arm/ -e s/sa110/arm/ \
-				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
+SUBARCH := arm
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
@@ -174,7 +171,7 @@ SUBARCH := $(shell uname -m | sed -e s/i
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
 
 ARCH		?= $(SUBARCH)
-CROSS_COMPILE	?=
+CROSS_COMPILE	?= /scratchbox/compilers/arm-gcc-3.3.4-glibc-2.3.2/bin/arm-linux-
 
 # Architecture as present in compile.h
 UTS_MACHINE := $(ARCH)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f81a623..766a737 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -690,7 +690,7 @@ config XIP_PHYS_ADDR
 
 endmenu
 
-if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP)
+if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_PXA)
 
 menu "CPU Frequency scaling"
 
@@ -717,6 +717,18 @@ config CPU_FREQ_INTEGRATOR
 
 	  If in doubt, say Y.
 
+config CPU_FREQ_PXA25x
+	bool
+	select CPU_FREQ_TABLE
+	depends on CPU_FREQ && PXA25x
+	default y
+
+config CPU_FREQ_PXA27x
+	bool
+	select CPU_FREQ_TABLE
+	depends on CPU_FREQ && PXA27x
+	default y
+
 endmenu
 
 endif
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index ec9c400..73ead54 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -56,6 +56,12 @@ $(obj)/compressed/vmlinux: $(obj)/Image 
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
+	@ls -al $@
+	@wc -c $@ | ( read SIZE Y; \
+		if [ $$SIZE -gt 1294336 ]; then \
+			echo '  Kernel is too big, would kill spitz'; \
+			rm $@; \
+		fi )
 
 endif
 
diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index fbc3ab0..fdafed7 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -506,7 +506,7 @@ locomo_init_one_child(struct locomo *lch
 		goto out;
 	}
 
-	strncpy(dev->dev.bus_id,info->name,sizeof(dev->dev.bus_id));
+	strncpy(dev->dev.bus_id, info->name, sizeof(dev->dev.bus_id));
 	/*
 	 * If the parent device has a DMA mask associated with it,
 	 * propagate it down to the children.
@@ -729,7 +729,6 @@ __locomo_probe(struct device *me, struct
 
 	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
 		locomo_init_one_child(lchip, &locomo_devices[i]);
-
 	return 0;
 
  out:
@@ -1046,6 +1045,8 @@ void locomo_m62332_senddata(struct locom
  *	Frontlight control
  */
 
+#define LOCOMO_GPIO9        (1<<9)
+
 static struct locomo *locomo_chip_driver(struct locomo_dev *ldev);
 
 void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
diff --git a/arch/arm/common/sharpsl_pm.c b/arch/arm/common/sharpsl_pm.c
index 045e37e..12beac3 100644
--- a/arch/arm/common/sharpsl_pm.c
+++ b/arch/arm/common/sharpsl_pm.c
@@ -12,7 +12,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/module.h>
 #include <linux/timer.h>
@@ -28,11 +28,17 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <asm/apm.h>
+
+#ifndef CONFIG_SA1100_COLLIE
 #include <asm/arch/pm.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/sharpsl.h>
+#endif
 #include <asm/hardware/sharpsl_pm.h>
 
+#define dev_dbg(a, b...) printk(b)
+
+
 /*
  * Constants
  */
@@ -155,6 +161,7 @@ static void sharpsl_battery_thread(void 
 	dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %d\n", voltage,
 			sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
 
+#ifndef CONFIG_SA1100_COLLIE
 	/* If battery is low. limit backlight intensity to save power. */
 	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
 			&& ((sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_LOW) ||
@@ -167,6 +174,7 @@ static void sharpsl_battery_thread(void 
 		sharpsl_pm.machinfo->backlight_limit(0);
 		sharpsl_pm.flags &= ~SHARPSL_BL_LIMIT;
 	}
+#endif
 
 	/* Suspend if critical battery level */
 	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
@@ -276,13 +284,21 @@ static void sharpsl_chrg_full_timer(unsi
 		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
 		if (sharpsl_pm.charge_mode == CHRG_ON)
 			sharpsl_charge_off();
-	} else if (sharpsl_pm.full_count < 2) {
+		return;
+	} 
+#ifndef CONFIG_SA1100_COLLIE
+	if (sharpsl_pm.full_count < 2) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Count too low\n");
 		schedule_work(&toggle_charger);
-	} else if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
+		return;
+	} 
+	if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Interrupt generated too slowly - retry.\n");
 		schedule_work(&toggle_charger);
-	} else {
+		return;
+	}
+#endif
+	{
 		sharpsl_charge_off();
 		sharpsl_pm.charge_mode = CHRG_DONE;
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Charging Finished\n");
@@ -294,6 +310,7 @@ static void sharpsl_chrg_full_timer(unsi
    delay until after that has been processed */
 irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp)
 {
+	printk("charge full interrupt came\n");
 	if (sharpsl_pm.flags & SHARPSL_SUSPENDED)
 		return IRQ_HANDLED;
 
@@ -412,8 +429,10 @@ static int sharpsl_check_battery_temp(vo
 	val = get_select_val(buff);
 
 	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
-	if (val > sharpsl_pm.machinfo->charge_on_temp)
+	if (val > sharpsl_pm.machinfo->charge_on_temp) {
+		printk(KERN_WARNING "Not charging: temperature out of limits.\n"); 
 		return -1;
+	}
 
 	return 0;
 }
@@ -502,6 +521,7 @@ static void corgi_goto_sleep(unsigned lo
 	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n",sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
 	/* not charging and AC-IN! */
 
+#ifndef CONFIG_SA1100_COLLIE
 	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN))) {
 		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
 		sharpsl_pm.charge_mode = CHRG_OFF;
@@ -532,6 +552,7 @@ static void corgi_goto_sleep(unsigned lo
 	sharpsl_pm.machinfo->postsuspend();
 
 	dev_dbg(sharpsl_pm.dev, "Corgi woken up from suspend: %08x\n",PEDR);
+#endif
 }
 
 static int corgi_enter_suspend(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
@@ -629,6 +650,7 @@ static int sharpsl_fatal_check(void)
 
 static int sharpsl_off_charge_error(void)
 {
+	panic("collie: not off charging\n");
 	dev_err(sharpsl_pm.dev, "Offline Charger: Error occured.\n");
 	sharpsl_pm.machinfo->charge(0);
 	sharpsl_pm_led(SHARPSL_LED_ERROR);
@@ -645,6 +667,7 @@ static int sharpsl_off_charge_battery(vo
 {
 	int time;
 
+	panic("off_charging -- not on collie\n");
 	dev_dbg(sharpsl_pm.dev, "Charge Mode: %d\n", sharpsl_pm.charge_mode);
 
 	if (sharpsl_pm.charge_mode == CHRG_OFF) {
@@ -761,9 +784,11 @@ static void sharpsl_apm_get_power_status
 
 static struct pm_ops sharpsl_pm_ops = {
 	.pm_disk_mode	= PM_DISK_FIRMWARE,
+#ifndef CONFIG_SA1100_COLLIE
 	.prepare	= pxa_pm_prepare,
 	.enter		= corgi_pxa_pm_enter,
 	.finish		= pxa_pm_finish,
+#endif
 };
 
 static int __init sharpsl_pm_probe(struct platform_device *pdev)
@@ -773,6 +798,7 @@ static int __init sharpsl_pm_probe(struc
 
 	sharpsl_pm.dev = &pdev->dev;
 	sharpsl_pm.machinfo = pdev->dev.platform_data;
+
 	sharpsl_pm.charge_mode = CHRG_OFF;
 	sharpsl_pm.flags = 0;
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 35a052f..b7607df 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -56,8 +56,6 @@ void dump_backtrace_entry(unsigned long 
 #ifdef CONFIG_KALLSYMS
 	printk("[<%08lx>] ", where);
 	print_symbol("(%s) ", where);
-	printk("from [<%08lx>] ", from);
-	print_symbol("(%s)\n", from);
 #else
 	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
 #endif
@@ -156,6 +154,7 @@ static void dump_backtrace(struct pt_reg
 	unsigned int fp;
 	int ok = 1;
 
+#if 0
 	printk("Backtrace: ");
 	fp = regs->ARM_fp;
 	if (!fp) {
@@ -170,6 +169,7 @@ static void dump_backtrace(struct pt_reg
 
 	if (ok)
 		c_backtrace(fp, processor_mode(regs));
+#endif
 }
 
 void dump_stack(void)
@@ -209,10 +209,13 @@ static void __die(const char *str, int e
 		tsk->comm, tsk->pid, thread + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
+#if 0
 		dump_mem("Stack: ", regs->ARM_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+#endif
+
 		dump_backtrace(regs, tsk);
-		dump_instr(regs);
+//		dump_instr(regs);
 	}
 }
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 3ca574e..e3ac6ab 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -181,6 +181,6 @@ SECTIONS
  * These must never be empty
  * If you have to comment these two assert statements out, your
  * binutils is too old (for other reasons as well)
- */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+*/
diff --git a/arch/arm/mach-pxa/sharpsl.h b/arch/arm/mach-pxa/sharpsl.h
index da4769c..c92544d 100644
--- a/arch/arm/mach-pxa/sharpsl.h
+++ b/arch/arm/mach-pxa/sharpsl.h
@@ -12,6 +12,9 @@
 /*
  * SharpSL SSP Driver
  */
+
+#include <linux/interrupt.h>
+
 struct corgissp_machinfo {
 	int port;
 	int cs_lcdcon;
diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index e27f150..b90534b 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -24,6 +24,9 @@ obj-$(CONFIG_SA1100_CERF)		+= cerf.o
 led-$(CONFIG_SA1100_CERF)		+= leds-cerf.o
 
 obj-$(CONFIG_SA1100_COLLIE)		+= collie.o
+obj-$(CONFIG_SA1100_COLLIE)		+= collie_pm.o
+obj-$(CONFIG_SA1100_COLLIE)		+= sharpsl_pm.o
+obj-$(CONFIG_SA1100_COLLIE)		+= collie_batswitch.o
 
 obj-$(CONFIG_SA1100_H3600)		+= h3600.o
 
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index a6bab50..5e2a84e 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -83,8 +83,8 @@ static struct scoop_pcmcia_config collie
 
 
 static struct mcp_plat_data collie_mcp_data = {
-	.mccr0          = MCCR0_ADM,
-	.sclk_rate      = 11981000,
+	.mccr0          = MCCR0_ADM | MCCR0_ExtClk,
+	.sclk_rate      = 9216000,
 };
 
 #ifdef CONFIG_SHARP_LOCOMO
@@ -209,7 +209,8 @@ static void collie_set_vpp(int vpp)
 }
 
 static struct flash_platform_data collie_flash_data = {
-	.map_name	= "cfi_probe",
+//	.map_name	= "jedec_probe",
+	.map_name	= "sharp",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),
@@ -228,14 +229,17 @@ static void __init collie_init(void)
 	int ret = 0;
 
 	/* cpu initialize */
-	GAFR = ( GPIO_SSP_TXD | \
+	GAFR = ( GPIO_LDD8 | GPIO_LDD9 | GPIO_LDD10 | GPIO_LDD11 | GPIO_LDD12 | \
+		 GPIO_LDD13 | GPIO_LDD14 | GPIO_LDD15 | GPIO_SSP_TXD | \
 		 GPIO_SSP_SCLK | GPIO_SSP_SFRM | GPIO_SSP_CLK | GPIO_TIC_ACK | \
 		 GPIO_32_768kHz );
 
+
 	GPDR = ( GPIO_LDD8 | GPIO_LDD9 | GPIO_LDD10 | GPIO_LDD11 | GPIO_LDD12 | \
 		 GPIO_LDD13 | GPIO_LDD14 | GPIO_LDD15 | GPIO_SSP_TXD | \
 		 GPIO_SSP_SCLK | GPIO_SSP_SFRM | GPIO_SDLC_SCLK | \
 		 GPIO_SDLC_AAF | GPIO_UART_SCLK1 | GPIO_32_768kHz );
+
 	GPLR = GPIO_GPIO18;
 
 	// PPC pin setting
@@ -243,13 +247,61 @@ static void __init collie_init(void)
 		 PPC_LDD6 | PPC_LDD7 | PPC_L_PCLK | PPC_L_LCLK | PPC_L_FCLK | PPC_L_BIAS | \
 	 	 PPC_TXD1 | PPC_TXD2 | PPC_RXD2 | PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM );
 
+#if 1
+	PPSR = ( PPC_RXD2 | PPC_RXD3 );
+#endif
 	PSDR = ( PPC_RXD1 | PPC_RXD2 | PPC_RXD3 | PPC_RXD4 );
 
+#if 0
+	/* locomo initialize */
+        LCM_ICR = 0;
+        /* KEYBOARD */
+        LCM_KIC = 0;
+        /* GPIO */
+        LCM_GPO = 0;
+        LCM_GPE = ( LCM_GPIO(2) | LCM_GPIO(3) | LCM_GPIO(13) | LCM_GPIO(14) );
+        LCM_GPD = ( LCM_GPIO(2) | LCM_GPIO(3) | LCM_GPIO(13) | LCM_GPIO(14) );
+        LCM_GIE = 0;
+        /* FrontLight */
+        LCM_ALS = 0;
+        LCM_ALD = 0;
+        /* Longtime timer */
+	LCM_LTINT = 0;
+	/* SPI */
+        LCM_SPIIE = 0;
+#endif
+
 	GAFR |= GPIO_32_768kHz;
 	GPDR |= GPIO_32_768kHz;
 	TUCR  = TUCR_32_768kHz;
 
+	/* MCP ExtClk */
+	GAFR |= GPIO_MCP_CLK;
+	GPDR &= ~GPIO_MCP_CLK;
+
+#if 0
+	LCM_ASD  = (6+8+320+30)-10;/* synchronize lccr1 setting : colliefb.c */
+	LCM_ASD |= 0x8000;
+	LCM_HSD  = (6+8+320+30)-10-128+4;
+	LCM_HSD |= 0x8000;
+	LCM_HSC  = 128/8;
+
+	LCM_TADC = 0x80;   /* XON */
+	udelay(1000);
+	LCM_TADC |= 0x10;  /* CLK9MEN */
+	udelay(100);
+
+	LCM_DAC |= (LCM_DAC_SCLOEB | LCM_DAC_SDAOEB); /* init DAC */
+#endif
+
+	// Reset Codec
+	GAFR &= ~COLLIE_GPIO_UCB1x00_RESET;
+	GPDR |= COLLIE_GPIO_UCB1x00_RESET;
+	GPSR |= COLLIE_GPIO_UCB1x00_RESET;
+
+#ifdef CONFIG_PCMCIA_SA1100
 	platform_scoop_config = &collie_pcmcia_config;
+#endif
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
diff --git a/arch/arm/mach-sa1100/collie_batswitch.c b/arch/arm/mach-sa1100/collie_batswitch.c
new file mode 100644
index 0000000..9df53ba
--- /dev/null
+++ b/arch/arm/mach-sa1100/collie_batswitch.c
@@ -0,0 +1,151 @@
+/*
+ * drivers/misc/collie_batswitch.c
+ *
+ * Handling for the Collie battery switch
+ *
+ * 1) immediately suspend if switch isnt flipped during initial boot
+ * 2) abort resume and resuspend if bat switch isnt flipped when unit
+ *    awakens.
+ * 3) register an interrupt handler so that flipping the switch results
+ *    in the user expected "soft reset"
+ *
+ * Copyright (C) 2003 Chris Larson <kergoth@handhelds.org>
+ *
+ * Updated Mar 27, 2004 by John Lenz <lenz@cs.wisc.edu> to work
+ * with 2.6
+ *
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/arch/collie.h>
+
+static inline int batswitch_status(void)
+{
+	return GPLR & COLLIE_GPIO_MAIN_BAT_LOW;
+}
+
+#ifdef CONFIG_PM
+/* item #2 from comments */
+static int batswitch_pm_callback(struct pm_dev* pm_dev, pm_request_t req, void *data)
+{
+	switch (req) {
+	case PM_SUSPEND:
+		disable_irq(COLLIE_IRQ_GPIO_MAIN_BAT_LOW);
+		break;
+	case PM_RESUME:
+		if (batswitch_status() == 0) {
+			printk("return to suspend\n");
+			return 1;
+		}
+		enable_irq(COLLIE_IRQ_GPIO_MAIN_BAT_LOW);
+		break;
+	}
+	return 0;
+}
+#endif
+
+/* item #3 from comments */
+extern asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd, void * arg);
+
+static void batswitch_routine(unsigned long arg)
+{
+	mdelay(10);
+	if (batswitch_status()) {
+		printk("cancel emergency off\n");
+		return;
+	}
+
+	pm_send_all(PM_SUSPEND, (void *)3);
+	pm_suspend(PM_SUSPEND_MEM);
+	sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART, NULL);
+}
+
+DECLARE_TASKLET(batswitch_tasklet, batswitch_routine, 0);
+
+static irqreturn_t batswitch_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	if (batswitch_status() == 0)
+		tasklet_schedule(&batswitch_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+extern int sa11x0_pm_enter(u32 state);
+
+#if 0
+int batswitch_suspend(void)
+{
+	int retval;
+
+	retval = pm_send_all(PM_SUSPEND, (void *)3);
+
+	if (retval == 0) {
+		int resumeval = 1;
+		while ((retval == 0) && (resumeval != 0)) {
+			retval = sa11x0_pm_enter(PM_SUSPEND_MEM);
+			resumeval = pm_send_all(PM_RESUME, (void *)0);
+		}
+	}
+
+	return retval;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int __init batswitch_checkswitch(void)
+{
+	/* suspend if we were reset */
+	/*if (RCSR == 0x01)
+		pm_suspend(PM_SUSPEND_MEM);*/
+
+	/* item #1 from comments */
+	if (batswitch_status() == 0) {
+		/*pm_suspend(PM_SUSPEND_MEM);*/
+		sa11x0_pm_enter(PM_SUSPEND_MEM);
+	}
+
+	return 0;
+}
+#endif
+
+static int __init batswitch_registerirq(void)
+{
+
+#ifdef CONFIG_PM
+	pm_register(PM_SYS_DEV, 0, batswitch_pm_callback);
+#endif
+
+	/* set COLLIE_IRQ_GPIO_MAIN_BAT_LOW to be an edge triggered interrupt */
+
+	if (request_irq(COLLIE_IRQ_GPIO_MAIN_BAT_LOW, 
+			batswitch_interrupt, 
+			SA_INTERRUPT, 
+			"batswitch", 
+			&batswitch_tasklet)) {
+		printk(KERN_INFO "Battery switch install error: Could not register irq handler.\n");
+	}
+
+	return 0;
+}
+
+//arch_initcall(batswitch_checkswitch);
+device_initcall(batswitch_registerirq);
diff --git a/arch/arm/mach-sa1100/collie_pm.c b/arch/arm/mach-sa1100/collie_pm.c
index 45b1e71..c4eee79 100644
--- a/arch/arm/mach-sa1100/collie_pm.c
+++ b/arch/arm/mach-sa1100/collie_pm.c
@@ -70,6 +70,8 @@ static void collie_measure_temp(int on)
 		ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_TMP_ON);
 }
 
+extern struct platform_device colliescoop_device;
+
 static void collie_charge(int on)
 {
 	if (on) {
@@ -77,6 +79,7 @@ static void collie_charge(int on)
 	} else {
 		printk("Should stop charger\n");
 	}
+#define I_AM_SURE
 #ifdef I_AM_SURE
 
 	/* Zaurus seems to contain LTC1731 ; it should know when to
@@ -146,10 +149,10 @@ int collie_read_main_battery(void)
 	ucb1x00_adc_enable(ucb);
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_MBAT_ON, 0);
-	/* gives values 160..255 with battery removed... and
-	   145..255 with battery inserted. (on AC), goes as low as
-	   80 on DC. */
+
+	mdelay(1);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
+//	printk("[%d]", voltage);
 
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_MBAT_ON);
 	ucb1x00_adc_disable(ucb);
@@ -192,7 +195,7 @@ static unsigned long read_devdata(int wh
 	case SHARPSL_BATT_TEMP:
 		return collie_read_temp();
 	case SHARPSL_ACIN_VOLT:
-		return 0x1;
+		return 500;
 	case SHARPSL_STATUS_ACIN: {
 		int ret = GPLR & COLLIE_GPIO_AC_IN;
 		printk("AC status = %d\n", ret);
@@ -208,10 +211,33 @@ static unsigned long read_devdata(int wh
 	}
 }
 
+struct battery_thresh collie_battery_levels_acin[] = {
+	{ 420, 100},
+	{ 417,  95},
+	{ 415,  90},
+	{ 413,  80},
+	{ 411,  75},
+	{ 408,  70},
+	{ 406,  60},
+	{ 403,  50},
+	{ 398,  40},
+	{ 391,  25},
+	{  10,   5},
+	{   0,   0},
+};
+
 struct battery_thresh collie_battery_levels[] = {
-	{ 368, 100},
-	{ 358,  25},
-	{ 356,   5},
+	{ 394, 100},
+	{ 390,  95},
+	{ 380,  90},
+	{ 370,  80},
+	{ 368,  75},	/* From sharp code: battery high with frontlight */
+	{ 366,  70},	/* 60..90 -- fake values invented by me for testing */
+	{ 364,  60},
+	{ 362,  50},
+	{ 360,  40},
+	{ 358,  25},	/* From sharp code: battery low with frontlight */
+	{ 356,   5},	/* From sharp code: battery verylow with frontlight */
 	{   0,   0},
 };
 
@@ -226,13 +252,21 @@ struct sharpsl_charger_machinfo collie_p
 	.postsuspend      = collie_postsuspend,
 	.charger_wakeup   = collie_charger_wakeup,
 	.should_wakeup    = collie_should_wakeup,
-	.bat_levels       = 3,
+	.bat_levels       = 12,
 	.bat_levels_noac  = collie_battery_levels,
-	.bat_levels_acin  = collie_battery_levels,
+	.bat_levels_acin  = collie_battery_levels_acin,
 	.status_high_acin = 368,
 	.status_low_acin  = 358,
 	.status_high_noac = 368,
 	.status_low_noac  = 358,
+	.charge_on_volt	  = 350,	/* spitz uses 2.90V, but lets play it safe. */
+	.charge_on_temp   = 550,
+	.charge_acin_high = 550,	/* collie does not seem to have sensor for this, anyway */
+	.charge_acin_low  = 450,	/* ignored, too */
+	.fatal_acin_volt  = 356,
+	.fatal_noacin_volt = 356,
+
+	.batfull_irq = 1,		/* We do not want periodical charge restarts */
 };
 
 static int __init collie_pm_ucb_add(struct ucb1x00_dev *pdev)
diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index 786c853..f363074 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -54,7 +54,7 @@ enum {	SLEEP_SAVE_SP = 0,
 };
 
 
-static int sa11x0_pm_enter(suspend_state_t state)
+int sa11x0_pm_enter(suspend_state_t state)
 {
 	unsigned long gpio, sleep_save[SLEEP_SAVE_SIZE];
 	struct timespec delta, rtc;
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 6e0f446..794a581 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -115,7 +115,7 @@ $(obj)/qtronixmap.o: $(obj)/qtronixmap.c
 # Uncomment if you're changing the keymap and have an appropriate
 # loadkeys version for the map. By default, we'll use the shipped
 # versions.
-# GENERATE_KEYMAP := 1
+ GENERATE_KEYMAP := 1
 
 ifdef GENERATE_KEYMAP
 
diff --git a/drivers/char/defkeymap.map b/drivers/char/defkeymap.map
index 50b30ca..ecf23c2 100644
--- a/drivers/char/defkeymap.map
+++ b/drivers/char/defkeymap.map
@@ -1,264 +1,169 @@
-# Default kernel keymap. This uses 7 modifier combinations.
-keymaps 0-2,4-5,8,12
-# Change the above line into
-#	keymaps 0-2,4-6,8,12
-# in case you want the entries
-#	altgr   control keycode  83 = Boot            
-#	altgr   control keycode 111 = Boot            
-# below.
-#
-# In fact AltGr is used very little, and one more keymap can
-# be saved by mapping AltGr to Alt (and adapting a few entries):
-# keycode 100 = Alt
-#
+# Note:
+# The way in which the modifiers are handled are quite different
+# than how they were handled in the 2.4.6-rmk1-np2-embedix kernel.
+# 
+# Here, we simply pass up Fn as Control, and the german accent key
+# as Altgr, and simply use a proper keymap.  Said keymap is as
+# follows.
+# keymaps 0-2,4-5,8,12,20
 keycode   1 = Escape           Escape          
-	alt     keycode   1 = Meta_Escape     
-keycode   2 = one              exclam          
-	alt     keycode   2 = Meta_one        
-keycode   3 = two              at               at              
-	control	keycode   3 = nul             
-	shift	control	keycode   3 = nul             
-	alt	keycode   3 = Meta_two        
-keycode   4 = three            numbersign      
-	control keycode   4 = Escape          
-	alt     keycode   4 = Meta_three      
-keycode   5 = four             dollar           dollar          
-	control keycode   5 = Control_backslash
-	alt     keycode   5 = Meta_four       
-keycode   6 = five             percent         
-	control keycode   6 = Control_bracketright
-	alt     keycode   6 = Meta_five       
-keycode   7 = six              asciicircum     
-	control keycode   7 = Control_asciicircum
-	alt     keycode   7 = Meta_six        
-keycode   8 = seven            ampersand        braceleft       
-	control keycode   8 = Control_underscore
-	alt     keycode   8 = Meta_seven      
-keycode   9 = eight            asterisk         bracketleft     
-	control keycode   9 = Delete          
-	alt     keycode   9 = Meta_eight      
-keycode  10 = nine             parenleft        bracketright    
-	alt     keycode  10 = Meta_nine       
-keycode  11 = zero             parenright       braceright      
-	alt     keycode  11 = Meta_zero       
-keycode  12 = minus            underscore       backslash       
-	control	keycode  12 = Control_underscore
-	shift	control	keycode  12 = Control_underscore
-	alt	keycode  12 = Meta_minus      
-keycode  13 = equal            plus            
-	alt     keycode  13 = Meta_equal      
-keycode  14 = Delete           Delete          
-	control keycode  14 = BackSpace
-	alt     keycode  14 = Meta_Delete     
+keycode  14 = BackSpace
+	shift   keycode  14 = BackSpace
+	control keycode  14 = Delete
+	shiftl  control keycode  14 = bracketleft
+	control shiftr  keycode  14 = bracketleft
 keycode  15 = Tab              Tab             
-	alt     keycode  15 = Meta_Tab        
+	shift   keycode  15 = backslash
+	control keycode  15 = Caps_Lock
+	shiftl  control keycode  15 = Caps_Lock
+	control shiftr  keycode  15 = Caps_Lock
 keycode  16 = q               
+	control	keycode  16 = one             
+	shiftl	control	keycode  16 = Control_q       
+	control	shiftr	keycode  16 = Meta_q       
 keycode  17 = w               
-keycode  18 = e
-	altgr   keycode  18 = Hex_E   
+	control	keycode  17 = two       
+	shiftl	control	keycode  17 = Control_w       
+	control	shiftr	keycode  17 = Meta_w       
+keycode  18 = e               
+	control	keycode  18 = three       
+	shiftl	control	keycode  18 = Control_e       
+	control	shiftr	keycode  18 = Meta_e       
 keycode  19 = r               
+	control	keycode  19 = four       
+	shiftr	control	keycode  19 = Control_r       
+	control	shiftl	keycode  19 = Meta_r       
 keycode  20 = t               
+	control	keycode  20 = five       
+	shiftl	control	keycode  20 = Control_t       
+	control	shiftr	keycode  20 = Meta_t       
 keycode  21 = y               
+	control	keycode  21 = six       
+	shiftl	control	keycode  21 = Control_y       
+	control	shiftr	keycode  21 = Meta_y       
 keycode  22 = u               
+	control	keycode  22 = seven       
+	shiftl	control	keycode  22 = Control_u       
+	control	shiftr	keycode  22 = Meta_u       
 keycode  23 = i               
+	control	keycode  23 = eight             
+	shiftl	control	keycode  23 = Control_i             
+	control	shiftr	keycode  23 = Meta_i             
 keycode  24 = o               
+	control	keycode  24 = nine       
+	shiftl	control	keycode  24 = Control_o       
+	control	shiftr	keycode  24 = Meta_o       
 keycode  25 = p               
-keycode  26 = bracketleft      braceleft       
-	control keycode  26 = Escape          
-	alt     keycode  26 = Meta_bracketleft
-keycode  27 = bracketright     braceright       asciitilde      
-	control keycode  27 = Control_bracketright
-	alt     keycode  27 = Meta_bracketright
+	control	keycode  25 = zero       
+	shiftl	control	keycode  25 = Control_p       
+	control	shiftr	keycode  25 = Meta_p       
 keycode  28 = Return          
-	alt     keycode  28 = Meta_Control_m  
+	control keycode  28 = greater
+	shiftl  control keycode  28 = braceright
+	control shiftr  keycode  28 = braceright
 keycode  29 = Control         
-keycode  30 = a
-	altgr   keycode  30 = Hex_A
+keycode  30 = a               
+	control	keycode  30 = exclam       
+	shiftl	control	keycode  30 = Control_a       
+	control	shiftr	keycode  30 = Meta_a       
 keycode  31 = s               
-keycode  32 = d
-	altgr   keycode  32 = Hex_D   
-keycode  33 = f
-	altgr   keycode  33 = Hex_F               
+	control	keycode  31 = at       
+	shiftl	control	keycode  31 = Control_s       
+	control	shiftr	keycode  31 = Meta_s       
+keycode  32 = d               
+	control	keycode  32 = numbersign
+	shiftl	control	keycode  32 = Control_d       
+	control	shiftr	keycode  32 = Meta_d       
+keycode  33 = f               
+	control	keycode  33 = dollar       
+	shiftl	control	keycode  33 = Control_f       
+	control	shiftr	keycode  33 = Meta_f       
 keycode  34 = g               
+	control	keycode  34 = percent       
+	shiftl	control	keycode  34 = Control_g       
+	control	shiftr	keycode  34 = Meta_g       
 keycode  35 = h               
+	control	keycode  35 = underscore       
+	shiftl	control	keycode  35 = BackSpace       
+	control	shiftr	keycode  35 = BackSpace       
 keycode  36 = j               
+	control	keycode  36 = ampersand        
+	shiftl	control	keycode  36 = Linefeed        
+	control	shiftr	keycode  36 = Linefeed        
 keycode  37 = k               
+	control	keycode  37 = asterisk       
+	shiftl	control	keycode  37 = Control_k       
+	control	shiftr	keycode  37 = Meta_k       
 keycode  38 = l               
-keycode  39 = semicolon        colon           
-	alt     keycode  39 = Meta_semicolon  
-keycode  40 = apostrophe       quotedbl        
-	control keycode  40 = Control_g       
-	alt     keycode  40 = Meta_apostrophe 
-keycode  41 = grave            asciitilde      
-	control keycode  41 = nul             
-	alt     keycode  41 = Meta_grave      
+	control	keycode  38 = parenleft       
+	shiftl	control	keycode  38 = Control_l       
+	control	shiftr	keycode  38 = Meta_l       
+keycode  40 = apostrophe       quotedbl
+	control	keycode  40 = asciitilde       
+	shiftl	control	keycode  40 = asciicircum
+	control	shiftr	keycode  40 = asciicircum       
 keycode  42 = Shift           
-keycode  43 = backslash        bar             
-	control keycode  43 = Control_backslash
-	alt     keycode  43 = Meta_backslash  
 keycode  44 = z               
+	control	keycode  44 = Control_z       
+	shiftl	control	keycode  44 = Control_z       
+	control	shiftr	keycode  44 = Meta_z       
 keycode  45 = x               
-keycode  46 = c
-	altgr   keycode  46 = Hex_C   
+	control	keycode  45 = Control_x       
+	shiftl	control	keycode  45 = Control_x       
+	control	shiftr	keycode  45 = Meta_x       
+keycode  46 = c               
+	control	keycode  46 = Control_c       
+	shiftl	control	keycode  46 = Control_c       
+	control	shiftr	keycode  46 = Meta_c       
 keycode  47 = v               
-keycode  48 = b
-	altgr   keycode  48 = Hex_B
+	control	keycode  47 = Control_v       
+	shiftl	control	keycode  47 = Control_v       
+	control	shiftr	keycode  47 = Meta_v       
+## current location ##
+keycode  48 = b               
+	control	keycode  48 = minus       
+	shiftl	control	keycode  48 = Control_b       
+	control	shiftr	keycode  48 = Meta_b       
 keycode  49 = n               
+	control	keycode  49 = plus       
+	shiftl	control	keycode  49 = Control_n       
+	control	shiftr	keycode  49 = Meta_n       
 keycode  50 = m               
-keycode  51 = comma            less            
-	alt     keycode  51 = Meta_comma      
-keycode  52 = period           greater         
-	control keycode  52 = Compose         
-	alt     keycode  52 = Meta_period     
-keycode  53 = slash            question        
-	control keycode  53 = Delete          
-	alt     keycode  53 = Meta_slash      
+	control	keycode  50 = equal       
+	shiftl	control	keycode  50 = Control_m       
+	control	shiftr	keycode  50 = Meta_m       
+keycode  51 = comma
+	shift   keycode  51 = semicolon
+	control keycode  51 = parenright
+	shiftl  control keycode  51 = bracketright
+	control shiftr  keycode  51 = bracketright
+keycode  52 = period
+	shift   keycode  52 = colon
+	control keycode  52 = less
+	shiftl  control keycode  52 = braceleft
+	control shiftr  keycode  52 = braceleft
+keycode  53 = slash
+	shift   keycode  53 = question
+	control	keycode  53 = Num_Lock
+	shiftl  control keycode  53 = Num_Lock
+	control shiftr  keycode  53 = Num_Lock
 keycode  54 = Shift           
 keycode  55 = KP_Multiply     
 keycode  56 = Alt             
-keycode  57 = space            space           
-	control keycode  57 = nul             
-	alt     keycode  57 = Meta_space      
-keycode  58 = Caps_Lock       
-keycode  59 = F1               F11              Console_13      
-	control keycode  59 = F1              
-	alt     keycode  59 = Console_1       
-	control alt     keycode  59 = Console_1       
-keycode  60 = F2               F12              Console_14      
-	control keycode  60 = F2              
-	alt     keycode  60 = Console_2       
-	control alt     keycode  60 = Console_2       
-keycode  61 = F3               F13              Console_15      
-	control keycode  61 = F3              
-	alt     keycode  61 = Console_3       
-	control alt     keycode  61 = Console_3       
-keycode  62 = F4               F14              Console_16      
-	control keycode  62 = F4              
-	alt     keycode  62 = Console_4       
-	control alt     keycode  62 = Console_4       
-keycode  63 = F5               F15              Console_17      
-	control keycode  63 = F5              
-	alt     keycode  63 = Console_5       
-	control alt     keycode  63 = Console_5       
-keycode  64 = F6               F16              Console_18      
-	control keycode  64 = F6              
-	alt     keycode  64 = Console_6       
-	control alt     keycode  64 = Console_6       
-keycode  65 = F7               F17              Console_19      
-	control keycode  65 = F7              
-	alt     keycode  65 = Console_7       
-	control alt     keycode  65 = Console_7       
-keycode  66 = F8               F18              Console_20      
-	control keycode  66 = F8              
-	alt     keycode  66 = Console_8       
-	control alt     keycode  66 = Console_8       
-keycode  67 = F9               F19              Console_21      
-	control keycode  67 = F9              
-	alt     keycode  67 = Console_9       
-	control alt     keycode  67 = Console_9       
-keycode  68 = F10              F20              Console_22      
-	control keycode  68 = F10             
-	alt     keycode  68 = Console_10      
-	control alt     keycode  68 = Console_10      
-keycode  69 = Num_Lock
-	shift   keycode  69 = Bare_Num_Lock
-keycode  70 = Scroll_Lock      Show_Memory      Show_Registers  
-	control keycode  70 = Show_State      
-	alt     keycode  70 = Scroll_Lock     
-keycode  71 = KP_7            
-	alt     keycode  71 = Ascii_7         
-	altgr   keycode  71 = Hex_7         
-keycode  72 = KP_8            
-	alt     keycode  72 = Ascii_8         
-	altgr   keycode  72 = Hex_8         
-keycode  73 = KP_9            
-	alt     keycode  73 = Ascii_9         
-	altgr   keycode  73 = Hex_9         
-keycode  74 = KP_Subtract     
-keycode  75 = KP_4            
-	alt     keycode  75 = Ascii_4         
-	altgr   keycode  75 = Hex_4         
-keycode  76 = KP_5            
-	alt     keycode  76 = Ascii_5         
-	altgr   keycode  76 = Hex_5         
-keycode  77 = KP_6            
-	alt     keycode  77 = Ascii_6         
-	altgr   keycode  77 = Hex_6         
-keycode  78 = KP_Add          
-keycode  79 = KP_1            
-	alt     keycode  79 = Ascii_1         
-	altgr   keycode  79 = Hex_1         
-keycode  80 = KP_2            
-	alt     keycode  80 = Ascii_2         
-	altgr   keycode  80 = Hex_2         
-keycode  81 = KP_3            
-	alt     keycode  81 = Ascii_3         
-	altgr   keycode  81 = Hex_3         
-keycode  82 = KP_0            
-	alt     keycode  82 = Ascii_0         
-	altgr   keycode  82 = Hex_0         
-keycode  83 = KP_Period       
-#	altgr   control keycode  83 = Boot            
-	control alt     keycode  83 = Boot            
-keycode  84 = Last_Console    
-keycode  85 =
-keycode  86 = less             greater          bar             
-	alt     keycode  86 = Meta_less       
-keycode  87 = F11              F11              Console_23      
-	control keycode  87 = F11             
-	alt     keycode  87 = Console_11      
-	control alt     keycode  87 = Console_11      
-keycode  88 = F12              F12              Console_24      
-	control keycode  88 = F12             
-	alt     keycode  88 = Console_12      
-	control alt     keycode  88 = Console_12      
-keycode  89 =
-keycode  90 =
-keycode  91 =
-keycode  92 =
-keycode  93 =
-keycode  94 =
-keycode  95 =
-keycode  96 = KP_Enter        
+keycode  57 = space
+	shift   keycode  57 = bar
+	control	keycode  57 = nul
+	shiftl  control keycode  57 = grave
+	control shiftr  keycode  57 = grave
 keycode  97 = Control         
-keycode  98 = KP_Divide       
 keycode  99 = Control_backslash
 	control keycode  99 = Control_backslash
-	alt     keycode  99 = Control_backslash
 keycode 100 = AltGr           
-keycode 101 = Break           
-keycode 102 = Find            
 keycode 103 = Up              
-keycode 104 = Prior           
-	shift   keycode 104 = Scroll_Backward 
 keycode 105 = Left            
-	alt     keycode 105 = Decr_Console
 keycode 106 = Right           
-	alt     keycode 106 = Incr_Console
 keycode 107 = Select          
 keycode 108 = Down            
-keycode 109 = Next            
-	shift   keycode 109 = Scroll_Forward  
-keycode 110 = Insert          
-keycode 111 = Remove          
-#	altgr   control keycode 111 = Boot            
-	control alt     keycode 111 = Boot            
-keycode 112 = Macro           
-keycode 113 = F13             
-keycode 114 = F14             
-keycode 115 = Help            
-keycode 116 = Do              
-keycode 117 = F17             
-keycode 118 = KP_MinPlus      
-keycode 119 = Pause           
-keycode 120 =
-keycode 121 =
-keycode 122 =
-keycode 123 =
-keycode 124 =
-keycode 125 =
-keycode 126 =
-keycode 127 =
 string F1 = "\033[[A"
 string F2 = "\033[[B"
 string F3 = "\033[[C"
diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
index 3b87951..e832d9f 100644
--- a/drivers/leds/leds-locomo.c
+++ b/drivers/leds/leds-locomo.c
@@ -50,7 +50,7 @@ static struct led_classdev locomo_led0 =
 
 static struct led_classdev locomo_led1 = {
 	.name			= "locomo:green",
-	.default_trigger	= "nand-disk",
+	.default_trigger	= "heartbeat",
 	.brightness_set		= locomoled_brightness_set1,
 };
 
diff --git a/drivers/leds/ledscore.c b/drivers/leds/ledscore.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fc3c885..3fa0aca 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -19,6 +19,10 @@ config MCP_UCB1200
 	tristate "Support for UCB1200 / UCB1300"
 	depends on MCP
 
+config MCP_UCB1200_AUDIO
+	tristate "Audio / Telephony interface support"
+	depends on MCP_UCB1200 && SOUND
+
 config MCP_UCB1200_TS
 	tristate "Touchscreen interface support"
 	depends on MCP_UCB1200 && INPUT
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index adb29b5..9563c66 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -6,7 +6,8 @@ obj-$(CONFIG_MCP)		+= mcp-core.o
 obj-$(CONFIG_MCP_SA11X0)	+= mcp-sa11x0.o
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-core.o
 obj-$(CONFIG_MCP_UCB1200_TS)	+= ucb1x00-ts.o
-
+obj-$(CONFIG_MCP_UCB1200_AUDIO)	+= ucb1x00-audio.o
+ 
 ifeq ($(CONFIG_SA1100_ASSABET),y)
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-assabet.o
 endif
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 1eab7cf..f13f820 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -170,6 +170,16 @@ static int mcp_sa11x0_probe(struct platf
 		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
 	}
 
+	if (machine_is_collie()) {
+		GAFR &= ~(GPIO_GPIO(16));
+		GPDR |= GPIO_GPIO(16);
+		GPSR |= GPIO_GPIO(16);
+
+		/* MCP ExtClk */
+		GAFR |= GPIO_MCP_CLK;
+		GPDR &= ~GPIO_MCP_CLK;
+	}
+
 	/*
 	 * Setup the PPC unit correctly.
 	 */
@@ -185,7 +195,32 @@ static int mcp_sa11x0_probe(struct platf
 	 */
 	Ser4MCSR = -1;
 	Ser4MCCR1 = data->mccr1;
-	Ser4MCCR0 = data->mccr0 | 0x7f7f;
+#if 1
+	if (machine_is_collie()) {
+/* Gives 0/1023 for battery reading. Actually works.. but gives same range as below */
+		Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
+/* From sharp's colliebuzzer. Gives 896 for battery & temp 
+		int asd = (9216000 / ( 32 * 11025 ));
+		Ser4MCCR0 &= ~MCCR0_MCE;
+		Ser4MCCR0 &= ~0xff;
+		Ser4MCCR0 |= ( MCCR0_ATE |MCCR0_ADM | MCCR0_ECS | asd);
+		Ser4MCCR0 |= MCCR0_MCE;
+		Ser4MCSR   = 0xffffffff;
+ */
+/* Sharp seems to initialize it like this: only gives timeouts :-(
+		Ser4MCCR0 = 0;
+ */
+/* Heh, this seems to give 1010 for battery & temp
+		Ser4MCCR0 = MCCR0_ATE | MCCR0_ECS;
+ */
+/*
+  Can't detect interrupt with this :-(.
+		Ser4MCCR0 = MCCR0_ATE;
+*/
+	} else
+#endif
+		Ser4MCCR0 = data->mccr0 | 0x7f7f;
+
 
 	/*
 	 * Calculate the read/write timeout (us) from the bit clock
diff --git a/drivers/mfd/ucb1x00-audio.c b/drivers/mfd/ucb1x00-audio.c
new file mode 100644
index 0000000..b81fa48
--- /dev/null
+++ b/drivers/mfd/ucb1x00-audio.c
@@ -0,0 +1,434 @@
+/*
+ *  linux/drivers/mfd/ucb1x00-audio.c
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/sound.h>
+#include <linux/soundcard.h>
+#include <linux/list.h>
+#include <linux/device.h>
+
+#include <asm/dma.h>
+#include <asm/hardware.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "ucb1x00.h"
+
+#include "../../sound/oss/sa1100-audio.h"
+
+#define MAGIC	0x41544154
+
+struct ucb1x00_audio {
+	struct file_operations	fops;
+	struct file_operations	mops;
+	struct ucb1x00		*ucb;
+	audio_stream_t		output_stream;
+	audio_stream_t		input_stream;
+	audio_state_t		state;
+	unsigned int		rate;
+	int			dev_id;
+	int			mix_id;
+	unsigned int		daa_oh_bit;
+	unsigned int		telecom;
+	unsigned int		magic;
+	unsigned int		ctrl_a;
+	unsigned int		ctrl_b;
+
+	/* mixer info */
+	unsigned int		mod_cnt;
+	unsigned short		output_level;
+	unsigned short		input_level;
+};
+
+struct ucb1x00_devdata {
+	struct ucb1x00_audio	audio;
+	struct ucb1x00_audio	telecom;
+};
+
+#define REC_MASK	(SOUND_MASK_VOLUME | SOUND_MASK_MIC)
+#define DEV_MASK	REC_MASK
+
+static int
+ucb1x00_mixer_ioctl(struct inode *ino, struct file *filp, uint cmd, ulong arg)
+{
+	struct ucb1x00_audio *ucba;
+	unsigned int val, gain;
+	int ret = 0;
+
+	ucba = list_entry(filp->f_op, struct ucb1x00_audio, mops);
+
+	if (_IOC_TYPE(cmd) != 'M')
+		return -EINVAL;
+
+	if (cmd == SOUND_MIXER_INFO) {
+		struct mixer_info mi;
+
+		strncpy(mi.id, "UCB1x00", sizeof(mi.id));
+		strncpy(mi.name, "Philips UCB1x00", sizeof(mi.name));
+		mi.modify_counter = ucba->mod_cnt;
+		return copy_to_user((void *)arg, &mi, sizeof(mi)) ? -EFAULT : 0;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_WRITE) {
+		unsigned int left, right;
+
+		ret = get_user(val, (unsigned int *)arg);
+		if (ret)
+			goto out;
+
+		left  = val & 255;
+		right = val >> 8;
+
+		if (left > 100)
+			left = 100;
+		if (right > 100)
+			right = 100;
+
+		gain = (left + right) / 2;
+
+		ret = -EINVAL;
+		if (!ucba->telecom) {
+			switch(_IOC_NR(cmd)) {
+			case SOUND_MIXER_VOLUME:
+				ucba->output_level = gain | gain << 8;
+				ucba->mod_cnt++;
+				ucba->ctrl_b = (ucba->ctrl_b & 0xff00) |
+					       ((gain * 31) / 100);
+				ucb1x00_reg_write(ucba->ucb, UCB_AC_B,
+						  ucba->ctrl_b);
+				ret = 0;
+				break;
+
+			case SOUND_MIXER_MIC:
+				ucba->input_level = gain | gain << 8;
+				ucba->mod_cnt++;
+				ucba->ctrl_a = (ucba->ctrl_a & 0x7f) |
+					       (((gain * 31) / 100) << 7);
+				ucb1x00_reg_write(ucba->ucb, UCB_AC_A,
+						  ucba->ctrl_a);
+				ret = 0;
+				break;
+			}
+		}
+	}
+
+	if (ret == 0 && _IOC_DIR(cmd) & _IOC_READ) {
+		switch (_IOC_NR(cmd)) {
+		case SOUND_MIXER_VOLUME:
+			val = ucba->output_level;
+			break;
+
+		case SOUND_MIXER_MIC:
+			val = ucba->input_level;
+			break;
+
+		case SOUND_MIXER_RECSRC:
+		case SOUND_MIXER_RECMASK:
+			val = ucba->telecom ? 0 : REC_MASK;
+			break;
+
+		case SOUND_MIXER_DEVMASK:
+			val = ucba->telecom ? 0 : DEV_MASK;
+			break;
+
+		case SOUND_MIXER_CAPS:
+		case SOUND_MIXER_STEREODEVS:
+			val = 0;
+			break;
+
+		default:
+			val = 0;
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret == 0)
+			ret = put_user(val, (int *)arg);
+	}
+ out:
+	return ret;
+}
+
+static int ucb1x00_audio_setrate(struct ucb1x00_audio *ucba, int rate)
+{
+	unsigned int div_rate = ucb1x00_clkrate(ucba->ucb) / 32;
+	unsigned int div;
+
+	div = (div_rate + (rate / 2)) / rate;
+	if (div < 6)
+		div = 6;
+	if (div > 127)
+		div = 127;
+
+	ucba->ctrl_a = (ucba->ctrl_a & ~0x7f) | div;
+
+	if (ucba->telecom) {
+		ucb1x00_reg_write(ucba->ucb, UCB_TC_B, 0);
+		ucb1x00_set_telecom_divisor(ucba->ucb, div * 32);
+		ucb1x00_reg_write(ucba->ucb, UCB_TC_A, ucba->ctrl_a);
+		ucb1x00_reg_write(ucba->ucb, UCB_TC_B, ucba->ctrl_b);
+	} else {
+		ucb1x00_reg_write(ucba->ucb, UCB_AC_B, 0);
+		ucb1x00_set_audio_divisor(ucba->ucb, div * 32);
+		ucb1x00_reg_write(ucba->ucb, UCB_AC_A, ucba->ctrl_a);
+		ucb1x00_reg_write(ucba->ucb, UCB_AC_B, ucba->ctrl_b);
+	}
+
+	ucba->rate = div_rate / div;
+
+	return ucba->rate;
+}
+
+static int ucb1x00_audio_getrate(struct ucb1x00_audio *ucba)
+{
+	return ucba->rate;
+}
+
+static void ucb1x00_audio_startup(void *data)
+{
+	struct ucb1x00_audio *ucba = data;
+
+	ucb1x00_enable(ucba->ucb);
+	ucb1x00_audio_setrate(ucba, ucba->rate);
+
+	ucb1x00_reg_write(ucba->ucb, UCB_MODE, UCB_MODE_DYN_VFLAG_ENA);
+
+	/*
+	 * Take off-hook
+	 */
+	if (ucba->daa_oh_bit)
+		ucb1x00_io_write(ucba->ucb, 0, ucba->daa_oh_bit);
+}
+
+static void ucb1x00_audio_shutdown(void *data)
+{
+	struct ucb1x00_audio *ucba = data;
+
+	/*
+	 * Place on-hook
+	 */
+	if (ucba->daa_oh_bit)
+		ucb1x00_io_write(ucba->ucb, ucba->daa_oh_bit, 0);
+
+	ucb1x00_reg_write(ucba->ucb, ucba->telecom ? UCB_TC_B : UCB_AC_B, 0);
+	ucb1x00_disable(ucba->ucb);
+}
+
+static int
+ucb1x00_audio_ioctl(struct inode *inode, struct file *file, uint cmd, ulong arg)
+{
+	struct ucb1x00_audio *ucba;
+	int val, ret = 0;
+
+	ucba = list_entry(file->f_op, struct ucb1x00_audio, fops);
+
+	/*
+	 * Make sure we have our magic number
+	 */
+	if (ucba->magic != MAGIC)
+		return -ENODEV;
+
+	switch (cmd) {
+	case SNDCTL_DSP_STEREO:
+		ret = get_user(val, (int *)arg);
+		if (ret)
+			return ret;
+		if (val != 0)
+			return -EINVAL;
+		val = 0;
+		break;
+
+	case SNDCTL_DSP_CHANNELS:
+	case SOUND_PCM_READ_CHANNELS:
+		val = 1;
+		break;
+
+	case SNDCTL_DSP_SPEED:
+		ret = get_user(val, (int *)arg);
+		if (ret)
+			return ret;
+		val = ucb1x00_audio_setrate(ucba, val);
+		break;
+
+	case SOUND_PCM_READ_RATE:
+		val = ucb1x00_audio_getrate(ucba);
+		break;
+
+	case SNDCTL_DSP_SETFMT:
+	case SNDCTL_DSP_GETFMTS:
+		val = AFMT_S16_LE;
+		break;
+
+	default:
+		return ucb1x00_mixer_ioctl(inode, file, cmd, arg);
+	}
+
+	return put_user(val, (int *)arg);
+}
+
+static int ucb1x00_audio_open(struct inode *inode, struct file *file)
+{
+	struct ucb1x00_audio *ucba;
+
+	ucba = list_entry(file->f_op, struct ucb1x00_audio, fops);
+
+	return sa1100_audio_attach(inode, file, &ucba->state);
+}
+
+static int
+ucb1x00_audio_add_one(struct ucb1x00 *ucb, struct ucb1x00_audio *a, int telecom)
+{
+	memset(a, 0, sizeof(*a));
+
+	a->magic = MAGIC;
+	a->ucb = ucb;
+	a->fops.owner = THIS_MODULE;
+	a->fops.open  = ucb1x00_audio_open;
+	a->mops.owner = THIS_MODULE;
+	a->mops.ioctl = ucb1x00_mixer_ioctl;
+	a->state.output_stream = &a->output_stream;
+	a->state.input_stream = &a->input_stream;
+	a->state.data = a;
+	a->state.hw_init = ucb1x00_audio_startup;
+	a->state.hw_shutdown = ucb1x00_audio_shutdown;
+	a->state.client_ioctl = ucb1x00_audio_ioctl;
+
+	/* There is a bug in the StrongARM causes corrupt MCP data to be sent to
+	 * the codec when the FIFOs are empty and writes are made to the OS timer
+	 * match register 0. To avoid this we must make sure that data is always
+	 * sent to the codec.
+	 */
+	a->state.need_tx_for_rx = 1;
+
+	init_MUTEX(&a->state.sem);
+	a->rate = 8000;
+	a->telecom = telecom;
+	a->input_stream.dev = ucb->cdev.dev;
+	a->output_stream.dev = ucb->cdev.dev;
+	a->ctrl_a = 0;
+
+	if (a->telecom) {
+		a->input_stream.dma_dev = ucb->mcp->dma_telco_rd;
+		a->input_stream.id = "UCB1x00 telco in";
+		a->output_stream.dma_dev = ucb->mcp->dma_telco_wr;
+		a->output_stream.id = "UCB1x00 telco out";
+		a->ctrl_b = UCB_TC_B_IN_ENA|UCB_TC_B_OUT_ENA;
+#if 0
+		a->daa_oh_bit = UCB_IO_8;
+
+		ucb1x00_enable(ucb);
+		ucb1x00_io_write(ucb, a->daa_oh_bit, 0);
+		ucb1x00_io_set_dir(ucb, UCB_IO_7 | UCB_IO_6, a->daa_oh_bit);
+		ucb1x00_disable(ucb);
+#endif
+	} else {
+		a->input_stream.dma_dev  = ucb->mcp->dma_audio_rd;
+		a->input_stream.id = "UCB1x00 audio in";
+		a->output_stream.dma_dev = ucb->mcp->dma_audio_wr;
+		a->output_stream.id = "UCB1x00 audio out";
+		a->ctrl_b = UCB_AC_B_IN_ENA|UCB_AC_B_OUT_ENA;
+	}
+
+	a->dev_id = register_sound_dsp(&a->fops, -1);
+	a->mix_id = register_sound_mixer(&a->mops, -1);
+
+	printk("Sound: UCB1x00 %s: dsp id %d mixer id %d\n",
+		a->telecom ? "telecom" : "audio",
+		a->dev_id, a->mix_id);
+
+	return 0;
+}
+
+static void ucb1x00_audio_remove_one(struct ucb1x00_audio *a)
+{
+	unregister_sound_dsp(a->dev_id);
+	unregister_sound_mixer(a->mix_id);
+}
+
+static int ucb1x00_audio_add(struct ucb1x00_dev *dev)
+{
+	struct ucb1x00_devdata *dd;
+	struct ucb1x00 *ucb = dev->ucb;
+
+	if (ucb->cdev.dev == NULL || ucb->cdev.dev->dma_mask == NULL)
+		return -ENXIO;
+
+	dd = kmalloc(sizeof(struct ucb1x00_devdata), GFP_KERNEL);
+	if (!dd)
+		return -ENOMEM;
+
+	ucb1x00_audio_add_one(ucb, &dd->audio, 0);
+	ucb1x00_audio_add_one(ucb, &dd->telecom, 1);
+
+	dev->priv = dd;
+
+	return 0;
+}
+
+static void ucb1x00_audio_remove(struct ucb1x00_dev *dev)
+{
+	struct ucb1x00_devdata *dd = dev->priv;
+
+	ucb1x00_audio_remove_one(&dd->audio);
+	ucb1x00_audio_remove_one(&dd->telecom);
+	kfree(dd);
+}
+
+#ifdef CONFIG_PM
+static int ucb1x00_audio_suspend(struct ucb1x00_dev *dev, pm_message_t state)
+{
+	struct ucb1x00_devdata *dd = dev->priv;
+
+	sa1100_audio_suspend(&dd->audio.state, state);
+	sa1100_audio_suspend(&dd->telecom.state, state);
+
+	return 0;
+}
+
+static int ucb1x00_audio_resume(struct ucb1x00_dev *dev)
+{
+	struct ucb1x00_devdata *dd = dev->priv;
+
+	sa1100_audio_resume(&dd->audio.state);
+	sa1100_audio_resume(&dd->telecom.state);
+
+	return 0;
+}
+#else
+#define ucb1x00_audio_suspend	NULL
+#define ucb1x00_audio_resume	NULL
+#endif
+
+static struct ucb1x00_driver ucb1x00_audio_driver = {
+	.add		= ucb1x00_audio_add,
+	.remove		= ucb1x00_audio_remove,
+	.suspend	= ucb1x00_audio_suspend,
+	.resume		= ucb1x00_audio_resume,
+};
+
+static int __init ucb1x00_audio_init(void)
+{
+	return ucb1x00_register_driver(&ucb1x00_audio_driver);
+}
+
+static void __exit ucb1x00_audio_exit(void)
+{
+	ucb1x00_unregister_driver(&ucb1x00_audio_driver);
+}
+
+module_init(ucb1x00_audio_init);
+module_exit(ucb1x00_audio_exit);
+
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("UCB1x00 telecom/audio driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 632bc21..dd973b0 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -28,7 +28,9 @@
 #include <asm/dma.h>
 #include <asm/hardware.h>
 
+#include "mcp.h"
 #include "ucb1x00.h"
+#include <asm/mach-types.h>
 
 static DEFINE_MUTEX(ucb1x00_mutex);
 static LIST_HEAD(ucb1x00_drivers);
@@ -473,15 +475,17 @@ static int ucb1x00_probe(struct mcp *mcp
 {
 	struct ucb1x00 *ucb;
 	struct ucb1x00_driver *drv;
-	unsigned int id;
+	unsigned int id = UCB_ID_1200;
 	int ret = -ENODEV;
 
 	mcp_enable(mcp);
-	id = mcp_reg_read(mcp, UCB_ID);
+	if (!machine_is_collie()) {
+		id = mcp_reg_read(mcp, UCB_ID);
 
-	if (id != UCB_ID_1200 && id != UCB_ID_1300) {
-		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
-		goto err_disable;
+		if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_TC35143) {
+			printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
+			goto err_disable;
+		}
 	}
 
 	ucb = kmalloc(sizeof(struct ucb1x00), GFP_KERNEL);
@@ -501,10 +505,11 @@ static int ucb1x00_probe(struct mcp *mcp
 
 	ucb->id  = id;
 	ucb->mcp = mcp;
-	ucb->irq = ucb1x00_detect_irq(ucb);
+	ucb->irq = ucb1x00_detect_irq(ucb); /* 44 */
 	if (ucb->irq == NO_IRQ) {
 		printk(KERN_ERR "UCB1x00: IRQ probe failed\n");
 		ret = -ENODEV;
+		panic("UCB1x00: We really want our interrupt\n");
 		goto err_free;
 	}
 
diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 0277681..b407c0e 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -39,7 +39,6 @@
 
 #include "ucb1x00.h"
 
-
 struct ucb1x00_ts {
 	struct input_dev	*idev;
 	struct ucb1x00		*ucb;
@@ -55,12 +54,37 @@ struct ucb1x00_ts {
 
 static int adcsync;
 
+/**********************************
+
+     ................
+     .              . = 340
+     .              .
+     .             ^.
+     .             ^.
+     .             ^.
+     .             ^.
+     .              .
+     .             X. = 10
+     .  <<<<<<<<  Y .
+     ................
+     .   Sharp    =200
+     .              .
+     .  -   O    -  .
+     .              .
+     ................
+
+**********************************/
+
+
+
 static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
 {
 	struct input_dev *idev = ts->idev;
+
 	input_report_abs(idev, ABS_X, x);
 	input_report_abs(idev, ABS_Y, y);
 	input_report_abs(idev, ABS_PRESSURE, pressure);
+        input_report_key(idev, BTN_TOUCH, 1);
 	input_sync(idev);
 }
 
@@ -68,6 +92,7 @@ static inline void ucb1x00_ts_event_rele
 {
 	struct input_dev *idev = ts->idev;
 	input_report_abs(idev, ABS_PRESSURE, 0);
+        input_report_key(idev, BTN_TOUCH, 0);
 	input_sync(idev);
 }
 
@@ -86,6 +111,7 @@ static inline void ucb1x00_ts_mode_int(s
  * Switch to pressure mode, and read pressure.  We don't need to wait
  * here, since both plates are being driven.
  */
+/* set_read_pressure() in sharp code */
 static inline unsigned int ucb1x00_ts_read_pressure(struct ucb1x00_ts *ts)
 {
 	if (machine_is_collie()) {
@@ -129,7 +155,7 @@ static inline unsigned int ucb1x00_ts_re
 			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
 			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
 
-	udelay(55);
+	udelay(550);
 
 	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
 }
@@ -157,7 +183,7 @@ static inline unsigned int ucb1x00_ts_re
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
 			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
 
-	udelay(55);
+	udelay(550);
 
 	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPX, ts->adcsync);
 }
@@ -224,10 +250,14 @@ static int ucb1x00_thread(void *_ts)
 		ts->restart = 0;
 
 		ucb1x00_adc_enable(ts->ucb);
-
-		x = ucb1x00_ts_read_xpos(ts);
-		y = ucb1x00_ts_read_ypos(ts);
 		p = ucb1x00_ts_read_pressure(ts);
+		ucb1x00_adc_disable(ts->ucb);
+		ucb1x00_adc_enable(ts->ucb);
+		y = ucb1x00_ts_read_ypos(ts);
+		ucb1x00_adc_disable(ts->ucb);
+		ucb1x00_adc_enable(ts->ucb);
+		x = ucb1x00_ts_read_xpos(ts);
+		x = ucb1x00_ts_read_xpos(ts);
 
 		/*
 		 * Switch back to interrupt mode.
@@ -255,7 +285,9 @@ static int ucb1x00_thread(void *_ts)
 				valid = 0;
 			}
 
-			timeout = MAX_SCHEDULE_TIMEOUT;
+			/* With battery sensing on collie enabled, interrupts do not work quite well.
+			   This works around it */
+			timeout = HZ/10;
 		} else {
 			ucb1x00_disable(ts->ucb);
 
@@ -316,6 +348,10 @@ static int ucb1x00_ts_open(struct input_
 	ts->y_res = ucb1x00_ts_read_yres(ts);
 	ucb1x00_adc_disable(ts->ucb);
 
+	if (machine_is_collie()) {
+		ucb1x00_io_set_dir(ts->ucb, 0, COLLIE_TC35143_GPIO_TBL_CHK);
+	}
+
 	ts->rtask = kthread_run(ucb1x00_thread, ts, "ktsd");
 	if (!IS_ERR(ts->rtask)) {
 		ret = 0;
@@ -396,6 +432,10 @@ static int ucb1x00_ts_add(struct ucb1x00
 	__set_bit(ABS_X, ts->idev->absbit);
 	__set_bit(ABS_Y, ts->idev->absbit);
 	__set_bit(ABS_PRESSURE, ts->idev->absbit);
+        input_set_abs_params(ts->idev, ABS_X, 0, 450, 0, 0);
+        input_set_abs_params(ts->idev, ABS_Y, 200, 800, 0, 0);
+        input_set_abs_params(ts->idev, ABS_PRESSURE, 400, 800, 0, 0);
+
 
 	input_register_device(ts->idev);
 
@@ -435,3 +475,69 @@ module_exit(ucb1x00_ts_exit);
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("UCB1x00 touchscreen driver");
 MODULE_LICENSE("GPL");
+
+#if 0
+
+static void
+ts_take_ownership(void)
+{
+	/* put back in ts int mode */
+	ucb1200_write_reg(UCB1200_REG_TS_CTL,
+			  TSPX_POW | TSMX_POW | TSPY_GND | TSMY_GND |
+                          TSC_MODE_INT);
+
+	ucb1200_enable_irq(IRQ_UCB1200_ADC);
+	set_read_pressure();
+}
+
+static void adcx_take_ownership(void);
+
+static void wait_for_action(void)
+{
+	adc_owner = ADC_OWNER_TS;
+	ts_state = PRESSED;
+	sample = 0;
+
+	ucb1200_set_irq_edge(TSPX_INT, GPIO_RISING_EDGE);
+	ucb1200_enable_irq(IRQ_UCB1200_TSPX);
+
+	ucb1200_stop_adc();
+
+	ucb1200_unlock_adc(ucb1200_ts_interrupt);
+
+	ucb1200_write_reg(UCB1200_REG_TS_CTL,
+			  TSPX_POW | TSMX_POW | TSPY_GND | TSMY_GND |
+                          TSC_MODE_INT);
+
+	/* if adc is waiting, start it */
+	if (adcx_state == ADCX_SAMPLE) {
+		adcx_take_ownership();
+	}
+	idleCancel = 0;
+}
+
+
+static void
+adcx_take_ownership(void)
+{
+	u16 inp = 0;
+
+	adc_owner = ADC_OWNER_ADCX;
+
+	/* take out of ts int mode */
+	ucb1200_write_reg(UCB1200_REG_TS_CTL,
+			  TSPX_POW | TSMX_POW | TSPY_GND | TSMY_GND);
+
+	ucb1200_enable_irq(IRQ_UCB1200_ADC);
+
+        switch (adcx_channel) {
+        case 0: inp = ADC_INPUT_AD0; break;
+        case 1: inp = ADC_INPUT_AD1; break;
+        case 2: inp = ADC_INPUT_AD2; break;
+        case 3: inp = ADC_INPUT_AD3; break;
+	}
+
+        ucb1200_start_adc(inp);
+}
+
+#endif
diff --git a/drivers/mfd/ucb1x00.h b/drivers/mfd/ucb1x00.h
index 9c9a647..ca8df80 100644
--- a/drivers/mfd/ucb1x00.h
+++ b/drivers/mfd/ucb1x00.h
@@ -94,6 +94,7 @@
 #define UCB_ID		0x0c
 #define UCB_ID_1200		0x1004
 #define UCB_ID_1300		0x1005
+#define UCB_ID_TC35143          0x9712
 
 #define UCB_MODE	0x0d
 #define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
diff --git a/drivers/misc/mcp-ac97.c b/drivers/misc/mcp-ac97.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/misc/mcp-core.c b/drivers/misc/mcp-core.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/misc/mcp-sa1100.c b/drivers/misc/mcp-sa1100.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/misc/ucb1x00-assabet.c b/drivers/misc/ucb1x00-assabet.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/misc/ucb1x00-audio.c b/drivers/misc/ucb1x00-audio.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/misc/ucb1x00-core.c b/drivers/misc/ucb1x00-core.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/mtd/chips/sharp.c b/drivers/mtd/chips/sharp.c
index 967abbe..c5212ee 100644
--- a/drivers/mtd/chips/sharp.c
+++ b/drivers/mtd/chips/sharp.c
@@ -25,13 +25,13 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/cfi.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/slab.h>
 
 #define CMD_RESET		0xffffffff
 #define CMD_READ_ID		0x90909090
@@ -60,13 +60,15 @@
 
 #define SR_ERRORS (SR_ERROR_ERASE|SR_ERROR_WRITE|SR_VPP|SR_PROTECT)
 
+#define BLOCK_MASK		0xfffe0000
+
 /* Configuration options */
 
-#undef AUTOUNLOCK  /* automatically unlocks blocks before erasing */
+#define AUTOUNLOCK  /* automatically unlocks blocks before erasing */
 
 static struct mtd_info *sharp_probe(struct map_info *);
 
-static int sharp_probe_map(struct map_info *map,struct mtd_info *mtd);
+static int sharp_probe_map(struct map_info *map, struct mtd_info *mtd);
 
 static int sharp_read(struct mtd_info *mtd, loff_t from, size_t len,
 	size_t *retlen, u_char *buf);
@@ -83,7 +85,7 @@ static int sharp_write_oneword(struct ma
 static int sharp_erase_oneblock(struct map_info *map, struct flchip *chip,
 	unsigned long adr);
 #ifdef AUTOUNLOCK
-static void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
+static inline void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
 	unsigned long adr);
 #endif
 
@@ -105,6 +107,13 @@ static struct mtd_chip_driver sharp_chip
 	.module		= THIS_MODULE
 };
 
+static void sharp_udelay(unsigned long i) {
+	if (in_interrupt()) {
+		udelay(i);
+	} else {
+		schedule();
+	}
+}
 
 static struct mtd_info *sharp_probe(struct map_info *map)
 {
@@ -144,7 +153,7 @@ static struct mtd_info *sharp_probe(stru
 	mtd->name = map->name;
 
 	memset(sharp, 0, sizeof(*sharp));
-	sharp->chipshift = 23;
+	sharp->chipshift = 24;
 	sharp->numchips = 1;
 	sharp->chips[0].start = 0;
 	sharp->chips[0].state = FL_READY;
@@ -179,8 +188,9 @@ static int sharp_probe_map(struct map_in
 
 	read0 = map_read(map, base+0);
 	read4 = map_read(map, base+4);
-	if(read0.x[0] == 0x89898989){
-		printk("Looks like sharp flash\n");
+	if (read0.x[0] == 0x00b000b0) {
+		printk("Sharp chip, %lx, %lx, width = %d\n", read0.x[0], read4.x[0], width);
+		/* Prints b000b0, b000b0, width = 4 on collie */
 		switch(read4.x[0]){
 		case 0xaaaaaaaa:
 		case 0xa0a0a0a0:
@@ -195,18 +205,16 @@ static int sharp_probe_map(struct map_in
 			mtd->erasesize = 0x10000 * width;
 			mtd->size = 0x100000 * width;
 			return width;
-#if 0
-		case 0x00000000: /* unknown */
-			/* XX - LH28F004SCT 512kx8, 8 64k blocks*/
-			mtd->erasesize = 0x10000 * width;
-			mtd->size = 0x80000 * width;
+		case 0x00b000b0:
+			/* a6 - LH28F640BFHE 8 64k * 2 chip blocks*/
+			mtd->erasesize = 0x10000 * width / 2;
+			mtd->size = 0x800000 * width / 2;
 			return width;
-#endif
 		default:
 			printk("Sort-of looks like sharp flash, 0x%08lx 0x%08lx\n",
 				read0.x[0], read4.x[0]);
 		}
-	}else if((map_read(map, base+0).x[0] == CMD_READ_ID)){
+	} else if ((map_read(map, base+0).x[0] == CMD_READ_ID)){
 		/* RAM, probably */
 		printk("Looks like RAM\n");
 		map_write(map, tmp, base+0);
@@ -221,7 +229,6 @@ static int sharp_probe_map(struct map_in
 /* This function returns with the chip->mutex lock held. */
 static int sharp_wait(struct map_info *map, struct flchip *chip)
 {
-	int i;
 	map_word status;
 	unsigned long timeo = jiffies + HZ;
 	DECLARE_WAITQUEUE(wait, current);
@@ -230,27 +237,30 @@ static int sharp_wait(struct map_info *m
 retry:
 	spin_lock_bh(chip->mutex);
 
-	switch(chip->state){
+	switch (chip->state) {
 	case FL_READY:
 		sharp_send_cmd(map, CMD_READ_STATUS, adr);
 		chip->state = FL_STATUS;
 	case FL_STATUS:
-		for(i=0;i<100;i++){
-			status = map_read(map, adr);
-			if((status.x[0] & SR_READY)==SR_READY)
-				break;
-			udelay(1);
+		status = map_read(map, adr);
+		if ((status.x[0] & SR_READY) == SR_READY)
+			break;
+		spin_unlock_bh(chip->mutex);
+		if (time_after(jiffies, timeo)) {
+			printk("Waiting for chip to be ready timed out in erase\n");
+			return -EIO;
 		}
-		break;
+		sharp_udelay(1);
+		goto retry;
 	default:
-		printk("Waiting for chip\n");
-
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&chip->wq, &wait);
 
 		spin_unlock_bh(chip->mutex);
 
-		schedule();
+		sharp_udelay(1);
+
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&chip->wq, &wait);
 
 		if(signal_pending(current))
@@ -355,22 +365,24 @@ static int sharp_write_oneword(struct ma
 	unsigned long adr, __u32 datum)
 {
 	int ret;
-	int timeo;
 	int try;
 	int i;
 	map_word data, status;
 
 	status.x[0] = 0;
 	ret = sharp_wait(map,chip);
+	if (ret < 0)
+		return ret;
+
+	for (try=0; try<10; try++) {
+		long timeo;
 
-	for(try=0;try<10;try++){
 		sharp_send_cmd(map, CMD_BYTE_WRITE, adr);
 		/* cpu_to_le32 -> hack to fix the writel be->le conversion */
 		data.x[0] = cpu_to_le32(datum);
 		map_write(map, data, adr);
 
 		chip->state = FL_WRITING;
-
 		timeo = jiffies + (HZ/2);
 
 		sharp_send_cmd(map, CMD_READ_STATUS, adr);
@@ -379,11 +391,20 @@ static int sharp_write_oneword(struct ma
 			if((status.x[0] & SR_READY) == SR_READY)
 				break;
 		}
+#ifdef AUTOUNLOCK
+		if (status.x[0] & SR_PROTECT) { /* lock block */
+			sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
+			sharp_unlock_oneblock(map,chip,adr);
+			sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
+			sharp_send_cmd(map, CMD_RESET, adr);
+			continue;
+		}
+#endif
 		if(i==100){
 			printk("sharp: timed out writing\n");
 		}
 
-		if(!(status.x[0] & SR_ERRORS))
+		if (!(status.x[0] & SR_ERRORS))
 			break;
 
 		printk("sharp: error writing byte at addr=%08lx status=%08lx\n", adr, status.x[0]);
@@ -393,8 +414,7 @@ static int sharp_write_oneword(struct ma
 	sharp_send_cmd(map, CMD_RESET, adr);
 	chip->state = FL_READY;
 
-	wake_up(&chip->wq);
-	spin_unlock_bh(chip->mutex);
+	sharp_release(chip);
 
 	return 0;
 }
@@ -406,7 +426,6 @@ static int sharp_erase(struct mtd_info *
 	unsigned long adr,len;
 	int chipnum, ret=0;
 
-//printk("sharp_erase()\n");
 	if(instr->addr & (mtd->erasesize - 1))
 		return -EINVAL;
 	if(instr->len & (mtd->erasesize - 1))
@@ -422,8 +441,13 @@ static int sharp_erase(struct mtd_info *
 		ret = sharp_erase_oneblock(map, &sharp->chips[chipnum], adr);
 		if(ret)return ret;
 
-		adr += mtd->erasesize;
-		len -= mtd->erasesize;
+		if (adr >= 0xfe0000) {
+			adr += mtd->erasesize / 8;
+			len -= mtd->erasesize / 8;
+		} else {
+			adr += mtd->erasesize;
+			len -= mtd->erasesize;
+		}
 		if(adr >> sharp->chipshift){
 			adr = 0;
 			chipnum++;
@@ -438,7 +462,7 @@ static int sharp_erase(struct mtd_info *
 	return 0;
 }
 
-static int sharp_do_wait_for_ready(struct map_info *map, struct flchip *chip,
+static inline int sharp_do_wait_for_ready(struct map_info *map, struct flchip *chip,
 	unsigned long adr)
 {
 	int ret;
@@ -449,31 +473,27 @@ static int sharp_do_wait_for_ready(struc
 	sharp_send_cmd(map, CMD_READ_STATUS, adr);
 	status = map_read(map, adr);
 
-	timeo = jiffies + HZ;
+	timeo = jiffies + HZ * 10;
 
-	while(time_before(jiffies, timeo)){
+	while (time_before(jiffies, timeo)) {
 		sharp_send_cmd(map, CMD_READ_STATUS, adr);
 		status = map_read(map, adr);
-		if((status.x[0] & SR_READY)==SR_READY){
+		if ((status.x[0] & SR_READY) == SR_READY) {
 			ret = 0;
 			goto out;
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&chip->wq, &wait);
 
-		//spin_unlock_bh(chip->mutex);
+		spin_unlock_bh(chip->mutex);
 
 		schedule_timeout(1);
 		schedule();
-		remove_wait_queue(&chip->wq, &wait);
 
-		//spin_lock_bh(chip->mutex);
-
-		if (signal_pending(current)){
-			ret = -EINTR;
-			goto out;
-		}
+		spin_lock_bh(chip->mutex);
 
+		remove_wait_queue(&chip->wq, &wait);
+		set_current_state(TASK_RUNNING);
 	}
 	ret = -ETIME;
 out:
@@ -484,11 +504,11 @@ static int sharp_erase_oneblock(struct m
 	unsigned long adr)
 {
 	int ret;
-	//int timeo;
 	map_word status;
-	//int i;
 
-//printk("sharp_erase_oneblock()\n");
+	ret = sharp_wait(map,chip);
+	if (ret < 0)
+		return ret;
 
 #ifdef AUTOUNLOCK
 	/* This seems like a good place to do an unlock */
@@ -501,53 +521,43 @@ static int sharp_erase_oneblock(struct m
 	chip->state = FL_ERASING;
 
 	ret = sharp_do_wait_for_ready(map,chip,adr);
-	if(ret<0)return ret;
+	if(ret<0) {
+		spin_unlock_bh(chip->mutex);
+		return ret;
+	}
 
 	sharp_send_cmd(map, CMD_READ_STATUS, adr);
 	status = map_read(map, adr);
 
-	if(!(status.x[0] & SR_ERRORS)){
+	if (!(status.x[0] & SR_ERRORS)) {
 		sharp_send_cmd(map, CMD_RESET, adr);
 		chip->state = FL_READY;
-		//spin_unlock_bh(chip->mutex);
+		spin_unlock_bh(chip->mutex);
 		return 0;
 	}
 
 	printk("sharp: error erasing block at addr=%08lx status=%08lx\n", adr, status.x[0]);
 	sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
 
-	//spin_unlock_bh(chip->mutex);
+	sharp_release(chip);
 
 	return -EIO;
 }
 
 #ifdef AUTOUNLOCK
-static void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
+static inline void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
 	unsigned long adr)
 {
-	int i;
 	map_word status;
 
-	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_1, adr);
-	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_2, adr);
+	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_1, adr & BLOCK_MASK);
+	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_2, adr & BLOCK_MASK);
 
-	udelay(100);
+	sharp_do_wait_for_ready(map,chip,adr);
 
 	status = map_read(map, adr);
-	printk("status=%08lx\n", status.x[0]);
-
-	for(i=0;i<1000;i++){
-		//sharp_send_cmd(map, CMD_READ_STATUS, adr);
-		status = map_read(map, adr);
-		if((status.x[0] & SR_READY) == SR_READY)
-			break;
-		udelay(100);
-	}
-	if(i==1000){
-		printk("sharp: timed out unlocking block\n");
-	}
 
-	if(!(status.x[0] & SR_ERRORS)){
+	if (!(status.x[0] & SR_ERRORS)) {
 		sharp_send_cmd(map, CMD_RESET, adr);
 		chip->state = FL_READY;
 		return;
@@ -560,25 +570,59 @@ static void sharp_unlock_oneblock(struct
 
 static void sharp_sync(struct mtd_info *mtd)
 {
-	//printk("sharp_sync()\n");
 }
 
 static int sharp_suspend(struct mtd_info *mtd)
 {
-	printk("sharp_suspend()\n");
-	return -EINVAL;
+	struct map_info *map = mtd->priv;
+	struct sharp_info *sharp = map->fldrv_priv;
+	int i;
+	struct flchip *chip;
+	int ret = 0;
+
+	for (i = 0; !ret && i < sharp->numchips; i++) {
+		chip = &sharp->chips[i];
+		ret = sharp_wait(map,chip);
+
+		if (ret) {
+			ret = -EAGAIN;
+		} else {
+			chip->state = FL_PM_SUSPENDED;
+			spin_unlock_bh(chip->mutex);
+		}
+	}
+	return ret;
 }
 
 static void sharp_resume(struct mtd_info *mtd)
 {
-	printk("sharp_resume()\n");
+	struct map_info *map = mtd->priv;
+	struct sharp_info *sharp = map->fldrv_priv;
+	int i;
+	struct flchip *chip;
+
+	for (i = 0; i < sharp->numchips; i++) {
+		chip = &sharp->chips[i];
 
+		spin_lock_bh(chip->mutex);
+
+		if (chip->state == FL_PM_SUSPENDED) {
+			/* We need to force it back to a known state */
+			sharp_send_cmd(map, CMD_RESET, chip->start);
+			chip->state = FL_READY;
+			wake_up(&chip->wq);
+		}
+
+		spin_unlock_bh(chip->mutex);
+	}
 }
 
 static void sharp_destroy(struct mtd_info *mtd)
 {
-	printk("sharp_destroy()\n");
+	struct map_info *map = mtd->priv;
+	struct sharp_info *sharp = map->fldrv_priv;
 
+	kfree(sharp);
 }
 
 static int __init sharp_probe_init(void)
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 83d0b2a..449431d 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -427,7 +427,7 @@ config MTD_CDB89712
 
 config MTD_SA1100
 	tristate "CFI Flash device mapped on StrongARM SA11x0"
-	depends on MTD_CFI && ARCH_SA1100 && MTD_PARTITIONS
+	depends on ARM && (MTD_CFI || MTD_SHARP) && ARCH_SA1100 && MTD_PARTITIONS
 	help
 	  This enables access to the flash chips on most platforms based on
 	  the SA1100 and SA1110, including the Assabet and the Compaq iPAQ.
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index 950bf1c..90c1230 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -210,6 +210,10 @@ static int sa1100_probe_subdev(struct sa
 		goto err;
 	}
 	subdev->mtd->owner = THIS_MODULE;
+#ifdef CONFIG_SA1100_COLLIE
+	if (subdev->mtd->unlock)	/* Should be only done when we are not using sharp map.. */
+		subdev->mtd->unlock(subdev->mtd, 0xc0000, subdev->mtd->size - 0xc0000);
+#endif
 
 	printk(KERN_INFO "SA1100 flash: CFI device at 0x%08lx, %dMiB, "
 		"%d-bit\n", phys, subdev->mtd->size >> 20,
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index c5b2a44..2a960a3 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -117,5 +117,5 @@ MODULE_AUTHOR("John Dorsey <john+@cs.cmu
 MODULE_DESCRIPTION("Linux PCMCIA Card Services: SA-11x0 Socket Controller");
 MODULE_LICENSE("Dual MPL/GPL");
 
-fs_initcall(sa11x0_pcmcia_init);
+late_initcall(sa11x0_pcmcia_init);
 module_exit(sa11x0_pcmcia_exit);
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index ecaa132..7b4bcf5 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -46,6 +46,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
+#define DEBUG
 #include "soc_common.h"
 
 /* FIXME: platform dependent resource declaration has to move out of this file */
@@ -55,7 +56,7 @@
 
 #ifdef DEBUG
 
-static int pc_debug;
+static int pc_debug = 15;
 module_param(pc_debug, int, 0644);
 
 void soc_pcmcia_debug(struct soc_pcmcia_socket *skt, const char *func,
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index cbf260b..78a1eb6 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -274,7 +274,7 @@ static int setup_serial(struct pcmcia_de
 	port.iobase = iobase;
 	port.irq = irq;
 	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
-	port.uartclk = 1843200;
+	port.uartclk = 921600 * 16;
 	port.dev = &handle_to_dev(handle);
 	if (buggy_uart)
 		port.flags |= UPF_BUGGY_UART;
diff --git a/drivers/soc/.built-in.o.cmd b/drivers/soc/.built-in.o.cmd
new file mode 100644
index 0000000..23e5d99
--- /dev/null
+++ b/drivers/soc/.built-in.o.cmd
@@ -0,0 +1 @@
+cmd_drivers/soc/built-in.o :=  rm -f drivers/soc/built-in.o; /scratchbox/compilers/arm-gcc-3.3.4-glibc-2.3.2/bin/arm-linux-ar rcs drivers/soc/built-in.o
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/soc/built-in.o b/drivers/soc/built-in.o
new file mode 100644
index 0000000..8b277f0
--- /dev/null
+++ b/drivers/soc/built-in.o
@@ -0,0 +1 @@
+!<arch>
diff --git a/drivers/soc/tsc2101.c b/drivers/soc/tsc2101.c
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/soc/tsc2101.h b/drivers/soc/tsc2101.h
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/usb/net/zd1201.c b/drivers/usb/net/zd1201.c
diff --git a/include/asm-arm/arch-pxa/pxa_keys.h b/include/asm-arm/arch-pxa/pxa_keys.h
new file mode 100644
index 0000000..e69de29
diff --git a/include/asm-arm/arch-sa1100/collie.h b/include/asm-arm/arch-sa1100/collie.h
index 14a344a..2078011 100644
--- a/include/asm-arm/arch-sa1100/collie.h
+++ b/include/asm-arm/arch-sa1100/collie.h
@@ -14,6 +14,8 @@
 #define __ASM_ARCH_COLLIE_H
 
 
+#define Word16 u16
+
 #define COLLIE_SCP_CHARGE_ON	SCOOP_GPCR_PA11
 #define COLLIE_SCP_DIAG_BOOT1	SCOOP_GPCR_PA12
 #define COLLIE_SCP_DIAG_BOOT2	SCOOP_GPCR_PA13
@@ -81,4 +83,241 @@
 #define COLLIE_TC35143_GPIO_OUT		( UCB_IO_1 | UCB_IO_3 | UCB_IO_4 | UCB_IO_6 | \
 					UCB_IO_7 | UCB_IO_8 | UCB_IO_9 )
 
+
+/*
+ * LoCoMo internal I/O mappings
+ *
+ * We have the following mapping:
+ *      phys            virt
+ *      40000000        f0000000
+ */
+
+/* LoCoMo I/O Base */
+#define LCM_BASE       0x40000000
+#define _LCM( x )      ((x) + LCM_BASE)
+
+#define LCM_p2v( x )    ((x) - LCM_BASE + 0xf0000000)
+#define LCM_v2p( x )    ((x) - 0xf0000000 + LCM_BASE)
+
+/* LCM version */
+#define _LCM_VER       _LCM( 0x00 )
+
+/* Pin status */
+#define _LCM_ST                _LCM( 0x04 )
+
+/* Pin status */
+#define _LCM_C32K      _LCM( 0x08 )
+
+/* Interrupt controller */
+#define _LCM_ICR       _LCM( 0x0C )
+
+/* MCS decoder for boot selecting */
+#define _LCM_MCSX0     _LCM( 0x10 )
+#define _LCM_MCSX1     _LCM( 0x14 )
+#define _LCM_MCSX2     _LCM( 0x18 )
+#define _LCM_MCSX3     _LCM( 0x1c )
+
+/* Touch panel controller */
+#define _LCM_ASD       _LCM( 0x20 )    /* AD start delay */
+#define _LCM_HSD       _LCM( 0x28 )    /* HSYS delay */
+#define _LCM_HSC       _LCM( 0x2c )    /* HSYS period */
+#define _LCM_TADC      _LCM( 0x30 )    /* tablet ADC clock */
+
+/* TFT signal */
+#define _LCM_TC                _LCM( 0x38 )    /* TFT control signal */
+#define _LCM_CPSD      _LCM( 0x3c )    /* CPS delay */
+
+/* Key controller */
+#define _LCM_KIB       _LCM( 0x40 )    /* KIB level */
+#define _LCM_KSC       _LCM( 0x44 )    /* KSTRB control */
+#define _LCM_KCMD      _LCM( 0x48 )    /* KSTRB command */
+#define _LCM_KIC       _LCM( 0x4c )    /* Key interrupt */
+
+/* Audio clock */
+#define _LCM_ACC       _LCM( 0x54 )
+
+/* SPI interface */
+#define _LCM_SPIMD     _LCM( 0x60 )    /* SPI mode setting */
+#define _LCM_SPICT     _LCM( 0x64 )    /* SPI mode control */
+#define _LCM_SPIST     _LCM( 0x68 )    /* SPI status */
+#define _LCM_SPIIS     _LCM( 0x70 )    /* SPI interrupt status */
+#define _LCM_SPIWE     _LCM( 0x74 )    /* SPI interrupt status write enable */
+#define _LCM_SPIIE     _LCM( 0x78 )    /* SPI interrupt enable */
+#define _LCM_SPIIR     _LCM( 0x7c )    /* SPI interrupt request */
+#define _LCM_SPITD     _LCM( 0x80 )    /* SPI transfer data write */
+#define _LCM_SPIRD     _LCM( 0x84 )    /* SPI receive data read */
+#define _LCM_SPITS     _LCM( 0x88 )    /* SPI transfer data shift */
+#define _LCM_SPIRS     _LCM( 0x8C )    /* SPI receive data shift */
+
+#define        LCM_SPI_TEND    (1 << 3)        /* Transfer end bit */
+#define        LCM_SPI_OVRN    (1 << 2)        /* Over Run bit */
+#define        LCM_SPI_RFW     (1 << 1)        /* write buffer bit */
+#define        LCM_SPI_RFR     (1)             /* read buffer bit */
+
+/* GPIO */
+#define _LCM_GPD       _LCM( 0x90 )    /* GPIO direction */
+#define _LCM_GPE       _LCM( 0x94 )    /* GPIO input enable */
+#define _LCM_GPL       _LCM( 0x98 )    /* GPIO level */
+#define _LCM_GPO       _LCM( 0x9c )    /* GPIO out data setteing */
+#define _LCM_GRIE      _LCM( 0xa0 )    /* GPIO rise detection */
+#define _LCM_GFIE      _LCM( 0xa4 )    /* GPIO fall detection */
+#define _LCM_GIS       _LCM( 0xa8 )    /* GPIO edge detection status */
+#define _LCM_GWE       _LCM( 0xac )    /* GPIO status write enable */
+#define _LCM_GIE       _LCM( 0xb0 )    /* GPIO interrupt enable */
+#define _LCM_GIR       _LCM( 0xb4 )    /* GPIO interrupt request */
+
+#define LCM_GPIO0        (1<<0)
+#define LCM_GPIO1        (1<<1)
+#define LCM_GPIO2        (1<<2)
+#define LCM_GPIO3        (1<<3)
+#define LCM_GPIO4        (1<<4)
+#define LCM_GPIO5        (1<<5)
+#define LCM_GPIO6        (1<<6)
+#define LCM_GPIO7        (1<<7)
+#define LCM_GPIO8        (1<<8)
+#define LCM_GPIO9        (1<<9)
+#define LCM_GPIO10       (1<<10)
+#define LCM_GPIO11       (1<<11)
+#define LCM_GPIO12       (1<<12)
+#define LCM_GPIO13       (1<<13)
+#define LCM_GPIO14       (1<<14)
+#define LCM_GPIO15       (1<<15)
+
+/* Front light adjustment controller */
+#define _LCM_ALS       _LCM( 0xc8 )    /* Adjust light cycle */
+#define _LCM_ALD       _LCM( 0xcc )    /* Adjust light duty */
+
+/* PCM audio interface */
+#define _LCM_PAIF      _LCM( 0xd0 )
+
+/* Long time timer */
+#define _LCM_LTC       _LCM( 0xd8 )    /* LTC interrupt setting */
+#define _LCM_LTINT     _LCM( 0xdc )    /* LTC interrupt */
+
+/* DAC control signal for LCD (COMADJ ) */
+#define _LCM_DAC       _LCM( 0xe0 )
+
+/* LED controller */
+#define _LCM_LPT0      _LCM( 0xe8 )    /* LEDPWM0 timer */
+#define _LCM_LPT1      _LCM( 0xec )    /* LEDPWM1 timer */
+
+#define LCM_VER                (*((volatile Word16 *) LCM_p2v (_LCM_VER)))
+
+/* Pin status */
+#define LCM_ST         (*((volatile Word16 *) LCM_p2v (_LCM_ST)))
+
+/* CLK32K status */
+#define LCM_C32K       (*((volatile Word *) LCM_p2v (_LCM_C32K)))
+
+/* Interrupt controller */
+#define LCM_ICR                (*((volatile Word16 *) LCM_p2v (_LCM_ICR)))
+
+/* MCS decoder for boot selecting */
+#define LCM_MCSX0      (*((volatile Word16 *) LCM_p2v (_LCM_MCSX0)))
+#define LCM_MCSX1      (*((volatile Word16 *) LCM_p2v (_LCM_MCSX1)))
+#define LCM_MCSX2      (*((volatile Word16 *) LCM_p2v (_LCM_MCSX2)))
+#define LCM_MCSX3      (*((volatile Word16 *) LCM_p2v (_LCM_MCSX3)))
+
+/* Touch panel controller */
+#define LCM_ASD                (*((volatile Word16 *) LCM_p2v (_LCM_ASD)))
+#define LCM_HSD                (*((volatile Word16 *) LCM_p2v (_LCM_HSD)))
+#define LCM_HSC                (*((volatile Word16 *) LCM_p2v (_LCM_HSC)))
+#define LCM_TADC       (*((volatile Word16 *) LCM_p2v (_LCM_TADC)))
+
+/* TFT signal */
+#define LCM_TC         (*((volatile Word16 *) LCM_p2v (_LCM_TC)))
+#define LCM_CPSD       (*((volatile Word16 *) LCM_p2v (_LCM_CPSD)))
+
+/* Key controller */
+#define LCM_KIB                (*((volatile Word16 *) LCM_p2v (_LCM_KIB)))
+#define LCM_KSC                (*((volatile Word16 *) LCM_p2v (_LCM_KSC)))
+#define LCM_KCMD       (*((volatile Word16 *) LCM_p2v (_LCM_KCMD)))
+#define LCM_KIC                (*((volatile Word16 *) LCM_p2v (_LCM_KIC)))
+
+/* Audio clock */
+#define LCM_ACC                (*((volatile Word16 *) LCM_p2v (_LCM_ACC)))
+
+/* SPI interface */
+#define LCM_SPIMD      (*((volatile Word16 *) LCM_p2v (_LCM_SPIMD)))
+#define LCM_SPICT      (*((volatile Word16 *) LCM_p2v (_LCM_SPICT)))
+#define LCM_SPIST      (*((volatile Word16 *) LCM_p2v (_LCM_SPIST)))
+#define LCM_SPIIS      (*((volatile Word16 *) LCM_p2v (_LCM_SPIIS)))
+#define LCM_SPIWE      (*((volatile Word16 *) LCM_p2v (_LCM_SPIWE)))
+#define LCM_SPIIE      (*((volatile Word16 *) LCM_p2v (_LCM_SPIIE)))
+#define LCM_SPIIR      (*((volatile Word16 *) LCM_p2v (_LCM_SPIIR)))
+#define LCM_SPITD      (*((volatile Word16 *) LCM_p2v (_LCM_SPITD)))
+#define LCM_SPIRD      (*((volatile Word16 *) LCM_p2v (_LCM_SPIRD)))
+#define LCM_SPITS      (*((volatile Word16 *) LCM_p2v (_LCM_SPITS)))
+#define LCM_SPIRS      (*((volatile Word16 *) LCM_p2v (_LCM_SPIRS)))
+
+/* GPIO */
+#define LCM_GPD                (*((volatile Word16 *) LCM_p2v (_LCM_GPD)))
+#define LCM_GPE                (*((volatile Word16 *) LCM_p2v (_LCM_GPE)))
+#define LCM_GPL                (*((volatile Word16 *) LCM_p2v (_LCM_GPL)))
+#define LCM_GPO                (*((volatile Word16 *) LCM_p2v (_LCM_GPO)))
+#define LCM_GRIE       (*((volatile Word16 *) LCM_p2v (_LCM_GRIE)))
+#define LCM_GFIE       (*((volatile Word16 *) LCM_p2v (_LCM_GFIE)))
+#define LCM_GIS                (*((volatile Word16 *) LCM_p2v (_LCM_GIS)))
+#define LCM_GWE                (*((volatile Word16 *) LCM_p2v (_LCM_GWE)))
+#define LCM_GIE                (*((volatile Word16 *) LCM_p2v (_LCM_GIE)))
+#define LCM_GIR                (*((volatile Word16 *) LCM_p2v (_LCM_GIR)))
+
+/* Front light adjustment controller */
+#define LCM_ALS                (*((volatile Word16 *) LCM_p2v (_LCM_ALS)))
+#define LCM_ALD                (*((volatile Word16 *) LCM_p2v (_LCM_ALD)))
+
+/* PCM audio interface */
+#define LCM_PAIF       (*((volatile Word16 *) LCM_p2v (_LCM_PAIF)))
+
+/* Long time timer */
+#define LCM_LTC                (*((volatile Word16 *) LCM_p2v (_LCM_LTC)))
+#define LCM_LTINT      (*((volatile Word16 *) LCM_p2v (_LCM_LTINT)))
+
+/* DAC control signal */
+#define LCM_DAC                (*((volatile Word16 *) LCM_p2v (_LCM_DAC)))
+
+/* DAC control */
+#define        LCM_DAC_SCLOEB  0x08    /* SCL pin output data       */
+#define        LCM_DAC_TEST    0x04    /* Test bit                  */
+#define        LCM_DAC_SDA     0x02    /* SDA pin level (read-only) */
+#define        LCM_DAC_SDAOEB  0x01    /* SDA pin output data       */
+/* LED controller */
+#define LCM_LPT0       (*((volatile Word16 *) LCM_p2v (_LCM_LPT0)))
+#define LCM_LPT1       (*((volatile Word16 *) LCM_p2v (_LCM_LPT1)))
+
+#define LCM_LPT_TOFH           0x80                    /* */
+#define LCM_LPT_TOFL           0x08                    /* */
+#define LCM_LPT_TOH(TOH)       ((TOH & 0x7) << 4)      /* */
+#define LCM_LPT_TOL(TOL)       ((TOL & 0x7))           /* */
+
+/* Audio clock */
+#define        LCM_ACC_XON             0x80    /*  */
+#define        LCM_ACC_XEN             0x40    /*  */
+#define        LCM_ACC_XSEL0           0x00    /*  */
+#define        LCM_ACC_XSEL1           0x20    /*  */
+#define        LCM_ACC_MCLKEN          0x10    /*  */
+#define        LCM_ACC_64FSEN          0x08    /*  */
+#define        LCM_ACC_CLKSEL000       0x00    /* mclk  2 */
+#define        LCM_ACC_CLKSEL001       0x01    /* mclk  3 */
+#define        LCM_ACC_CLKSEL010       0x02    /* mclk  4 */
+#define        LCM_ACC_CLKSEL011       0x03    /* mclk  6 */
+#define        LCM_ACC_CLKSEL100       0x04    /* mclk  8 */
+#define        LCM_ACC_CLKSEL101       0x05    /* mclk 12 */
+
+/* PCM audio interface */
+#define        LCM_PAIF_SCINV          0x20    /*  */
+#define        LCM_PAIF_SCEN           0x10    /*  */
+#define        LCM_PAIF_LRCRST         0x08    /*  */
+#define        LCM_PAIF_LRCEVE         0x04    /*  */
+#define        LCM_PAIF_LRCINV         0x02    /*  */
+#define        LCM_PAIF_LRCEN          0x01    /*  */
+
+/* GPIO */
+#define        LCM_GPIO(Nb)            (0x01 << (Nb))  /* LoCoMo GPIO [0...15] */
+
+#define LCM_GPIO_DAC_ON                LCM_GPIO (8)    /* LoCoMo GPIO  [8] */
+#define LCM_GPIO_DAC_SDATA     LCM_GPIO (10)   /* LoCoMo GPIO [10] */
+#define LCM_GPIO_DAC_SCK       LCM_GPIO (11)   /* LoCoMo GPIO [11] */
+#define LCM_GPIO_DAC_SLOAD     LCM_GPIO (12)   /* LoCoMo GPIO [12] */
+
 #endif
diff --git a/include/linux/device.h b/include/linux/device.h
index 1e5f30d..ef34988 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -418,7 +418,7 @@ extern void firmware_unregister(struct s
 /* debugging and troubleshooting/diagnostic helpers. */
 extern const char *dev_driver_string(struct device *dev);
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , dev_driver_string(dev) , (dev)->bus_id , ## arg)
+	printk(level "%s %s: " format , (!dev) ? "" : (dev)->driver ? (dev)->driver->name : "" , (dev)->bus_id , ## arg)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\
diff --git a/include/linux/plist.h b/include/linux/plist.h
index b95818a..bdd64bb 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -76,6 +76,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
+#include <linux/kernel.h>
 
 struct plist_head {
 	struct list_head prio_list;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54a4f53..efee0fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2208,11 +2208,13 @@ void setup_per_zone_pages_min(void)
 	}
 
 	for_each_zone(zone) {
-		u64 tmp;
+		volatile u32 tmp;
 
+		barrier();
 		spin_lock_irqsave(&zone->lru_lock, flags);
-		tmp = (u64)pages_min * zone->present_pages;
-		do_div(tmp, lowmem_pages);
+		barrier();
+		tmp = (u32)pages_min * zone->present_pages;
+		tmp = tmp / lowmem_pages;
 		if (is_highmem(zone)) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5d4c4d0..efdb26a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -179,13 +179,13 @@ unsigned long shrink_slab(unsigned long 
 		return 1;	/* Assume we'll be able to shrink next time */
 
 	list_for_each_entry(shrinker, &shrinker_list, list) {
-		unsigned long long delta;
+		unsigned long delta;
 		unsigned long total_scan;
 		unsigned long max_pass = (*shrinker->shrinker)(0, gfp_mask);
 
 		delta = (4 * scanned) / shrinker->seeks;
-		delta *= max_pass;
-		do_div(delta, lru_pages + 1);
+		delta *= (*shrinker->shrinker)(0, gfp_mask);
+		delta = delta / (lru_pages + 1);
 		shrinker->nr += delta;
 		if (shrinker->nr < 0) {
 			printk(KERN_ERR "%s: nr=%ld\n",
diff --git a/sound/soc/.built-in.o.cmd b/sound/soc/.built-in.o.cmd
new file mode 100644
index 0000000..3d8f3fc
--- /dev/null
+++ b/sound/soc/.built-in.o.cmd
@@ -0,0 +1 @@
+cmd_sound/soc/built-in.o :=  rm -f sound/soc/built-in.o; /scratchbox/compilers/arm-gcc-3.3.4-glibc-2.3.2/bin/arm-linux-ar rcs sound/soc/built-in.o
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
new file mode 100644
index 0000000..e69de29
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
new file mode 100644
index 0000000..e69de29
diff --git a/sound/soc/built-in.o b/sound/soc/built-in.o
new file mode 100644
index 0000000..8b277f0
--- /dev/null
+++ b/sound/soc/built-in.o
@@ -0,0 +1 @@
+!<arch>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
new file mode 100644
index 0000000..e69de29



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
