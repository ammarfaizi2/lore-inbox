Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUJWBUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUJWBUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUJWAex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:34:53 -0400
Received: from fmr03.intel.com ([143.183.121.5]:9640 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S269594AbUJWA31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:29:27 -0400
Date: Fri, 22 Oct 2004 17:26:59 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ak@suse.de, pavel@ucw.cz
Subject: [PATCH] HPET reenabling after suspend-resume
Message-ID: <20041022172659.A1632@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hpet hardware seems to need a little prodding during resume for it to start 
sending the timer interupts again. Attached patch does it for both i386 
and x86_64.

Makefile change below: Right now suspend-resume ordering of system devices
depends on their order of linking. It is ugly. But, thats the way it works
currently. And we want timer device to resume before PIC.

Signed-off-by:: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>

--- linux-2.6.9//arch/i386/kernel/time.c.org	2004-10-20 17:25:34.000000000 -0700
+++ linux-2.6.9//arch/i386/kernel/time.c	2004-10-22 19:17:03.000000000 -0700
@@ -321,7 +321,7 @@ unsigned long get_cmos_time(void)
 
 static long clock_cmos_diff;
 
-static int time_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, u32 state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
@@ -331,10 +331,18 @@ static int time_suspend(struct sys_devic
 	return 0;
 }
 
-static int time_resume(struct sys_device *dev)
+static int timer_resume(struct sys_device *dev)
 {
 	unsigned long flags;
-	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sec;
+
+#ifdef CONFIG_HPET_TIMER
+	if (is_hpet_enabled()) {
+		hpet_reenable();
+	}
+#endif
+
+	sec = get_cmos_time() + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
@@ -342,24 +350,24 @@ static int time_resume(struct sys_device
 	return 0;
 }
 
-static struct sysdev_class pit_sysclass = {
-	.resume = time_resume,
-	.suspend = time_suspend,
-	set_kset_name("pit"),
+static struct sysdev_class timer_sysclass = {
+	.resume = timer_resume,
+	.suspend = timer_suspend,
+	set_kset_name("timer"),
 };
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_i8253 = {
+static struct sys_device device_timer = {
 	.id	= 0,
-	.cls	= &pit_sysclass,
+	.cls	= &timer_sysclass,
 };
 
 static int time_init_device(void)
 {
-	int error = sysdev_class_register(&pit_sysclass);
+	int error = sysdev_class_register(&timer_sysclass);
 	if (!error)
-		error = sysdev_register(&device_i8253);
+		error = sysdev_register(&device_timer);
 	return error;
 }
 
--- linux-2.6.9//arch/i386/kernel/time_hpet.c.org	2004-10-20 18:08:52.000000000 -0700
+++ linux-2.6.9//arch/i386/kernel/time_hpet.c	2004-10-22 19:18:21.000000000 -0700
@@ -60,13 +60,46 @@ void __init wait_hpet_tick(void)
 }
 #endif
 
+static int hpet_timer_stop_set_go(unsigned long tick)
+{
+	unsigned int cfg;
+
+	/*
+	 * Stop the timers and reset the main counter.
+	 */
+	cfg = hpet_readl(HPET_CFG);
+	cfg &= ~HPET_CFG_ENABLE;
+	hpet_writel(cfg, HPET_CFG);
+	hpet_writel(0, HPET_COUNTER);
+	hpet_writel(0, HPET_COUNTER + 4);
+
+	/*
+	 * Set up timer 0, as periodic with first interrupt to happen at
+	 * hpet_tick, and period also hpet_tick.
+	 */
+	cfg = hpet_readl(HPET_T0_CFG);
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
+	       HPET_TN_SETVAL | HPET_TN_32BIT;
+	hpet_writel(cfg, HPET_T0_CFG);
+	hpet_writel(tick, HPET_T0_CMP);
+
+	/*
+ 	 * Go!
+ 	 */
+	cfg = hpet_readl(HPET_CFG);
+	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+	hpet_writel(cfg, HPET_CFG);
+
+	return 0;
+}
+
 /*
  * Check whether HPET was found by ACPI boot parse. If yes setup HPET
  * counter 0 for kernel base timer.
  */
 int __init hpet_enable(void)
 {
-	unsigned int cfg, id;
+	unsigned int id;
 	unsigned long tick_fsec_low, tick_fsec_high; /* tick in femto sec */
 	unsigned long hpet_tick_rem;
 
@@ -108,31 +141,8 @@ int __init hpet_enable(void)
 	if (hpet_tick_rem > (hpet_period >> 1))
 		hpet_tick++; /* rounding the result */
 
-	/*
-	 * Stop the timers and reset the main counter.
-	 */
-	cfg = hpet_readl(HPET_CFG);
-	cfg &= ~HPET_CFG_ENABLE;
-	hpet_writel(cfg, HPET_CFG);
-	hpet_writel(0, HPET_COUNTER);
-	hpet_writel(0, HPET_COUNTER + 4);
-
-	/*
-	 * Set up timer 0, as periodic with first interrupt to happen at
-	 * hpet_tick, and period also hpet_tick.
-	 */
-	cfg = hpet_readl(HPET_T0_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
-	       HPET_TN_SETVAL | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T0_CFG);
-	hpet_writel(hpet_tick, HPET_T0_CMP);
-
-	/*
- 	 * Go!
- 	 */
-	cfg = hpet_readl(HPET_CFG);
-	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
-	hpet_writel(cfg, HPET_CFG);
+	if (hpet_timer_stop_set_go(hpet_tick))
+		return -1;
 
 	use_hpet = 1;
 
@@ -185,6 +195,11 @@ int __init hpet_enable(void)
 	return 0;
 }
 
+int hpet_reenable(void)
+{
+	return hpet_timer_stop_set_go(hpet_tick);
+}
+
 int is_hpet_enabled(void)
 {
 	return use_hpet;
--- linux-2.6.9//include/asm-i386/hpet.h.org	2004-10-21 11:48:19.000000000 -0700
+++ linux-2.6.9//include/asm-i386/hpet.h	2004-10-22 19:17:03.000000000 -0700
@@ -96,6 +96,7 @@ extern unsigned long hpet_address;	/* hp
 
 extern int hpet_rtc_timer_init(void);
 extern int hpet_enable(void);
+extern int hpet_reenable(void);
 extern int is_hpet_enabled(void);
 extern int is_hpet_capable(void);
 extern int hpet_readl(unsigned long a);
--- linux-2.6.9//arch/i386/kernel/Makefile.org	2004-10-21 11:39:46.000000000 -0700
+++ linux-2.6.9//arch/i386/kernel/Makefile	2004-10-22 19:17:03.000000000 -0700
@@ -5,7 +5,7 @@
 extra-y := head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
-		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
+		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
 		doublefault.o
 
--- linux-2.6.9//arch/x86_64/kernel/time.c.org	2004-10-21 11:55:31.000000000 -0700
+++ linux-2.6.9//arch/x86_64/kernel/time.c	2004-10-22 19:18:41.000000000 -0700
@@ -723,31 +723,9 @@ static unsigned int __init pit_calibrate
 	return (end - start) / 50;
 }
 
-static int hpet_init(void)
+static int hpet_timer_stop_set_go(unsigned long tick)
 {
-	unsigned int cfg, id;
-
-	if (!vxtime.hpet_address)
-		return -1;
-	set_fixmap_nocache(FIX_HPET_BASE, vxtime.hpet_address);
-	__set_fixmap(VSYSCALL_HPET, vxtime.hpet_address, PAGE_KERNEL_VSYSCALL_NOCACHE);
-
-/*
- * Read the period, compute tick and quotient.
- */
-
-	id = hpet_readl(HPET_ID);
-
-	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
-	    !(id & HPET_ID_LEGSUP))
-		return -1;
-
-	hpet_period = hpet_readl(HPET_PERIOD);
-	if (hpet_period < 100000 || hpet_period > 100000000)
-		return -1;
-
-	hpet_tick = (1000000000L * (USEC_PER_SEC / HZ) + hpet_period / 2) /
-		hpet_period;
+	unsigned int cfg;
 
 /*
  * Stop the timers and reset the main counter.
@@ -779,6 +757,40 @@ static int hpet_init(void)
 	return 0;
 }
 
+static int hpet_init(void)
+{
+	unsigned int id;
+
+	if (!vxtime.hpet_address)
+		return -1;
+	set_fixmap_nocache(FIX_HPET_BASE, vxtime.hpet_address);
+	__set_fixmap(VSYSCALL_HPET, vxtime.hpet_address, PAGE_KERNEL_VSYSCALL_NOCACHE);
+
+/*
+ * Read the period, compute tick and quotient.
+ */
+
+	id = hpet_readl(HPET_ID);
+
+	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
+	    !(id & HPET_ID_LEGSUP))
+		return -1;
+
+	hpet_period = hpet_readl(HPET_PERIOD);
+	if (hpet_period < 100000 || hpet_period > 100000000)
+		return -1;
+
+	hpet_tick = (1000000000L * (USEC_PER_SEC / HZ) + hpet_period / 2) /
+		hpet_period;
+
+	return hpet_timer_stop_set_go(hpet_tick);
+}
+
+static int hpet_reenable(void)
+{
+	return hpet_timer_stop_set_go(hpet_tick);
+}
+
 void __init pit_init(void)
 {
 	unsigned long flags;
@@ -872,7 +884,7 @@ __setup("report_lost_ticks", time_setup)
 
 static long clock_cmos_diff;
 
-static int time_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, u32 state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
@@ -882,10 +894,15 @@ static int time_suspend(struct sys_devic
 	return 0;
 }
 
-static int time_resume(struct sys_device *dev)
+static int timer_resume(struct sys_device *dev)
 {
 	unsigned long flags;
-	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sec;
+
+	if (is_hpet_enabled())
+		hpet_reenable();
+
+	sec = get_cmos_time() + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
@@ -893,24 +910,24 @@ static int time_resume(struct sys_device
 	return 0;
 }
 
-static struct sysdev_class pit_sysclass = {
-	.resume = time_resume,
-	.suspend = time_suspend,
-	set_kset_name("pit"),
+static struct sysdev_class timer_sysclass = {
+	.resume = timer_resume,
+	.suspend = timer_suspend,
+	set_kset_name("timer"),
 };
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_i8253 = {
+static struct sys_device device_timer = {
 	.id	= 0,
-	.cls	= &pit_sysclass,
+	.cls	= &timer_sysclass,
 };
 
 static int time_init_device(void)
 {
-	int error = sysdev_class_register(&pit_sysclass);
+	int error = sysdev_class_register(&timer_sysclass);
 	if (!error)
-		error = sysdev_register(&device_i8253);
+		error = sysdev_register(&device_timer);
 	return error;
 }
 
--- linux-2.6.9//arch/x86_64/kernel/Makefile.org	2004-10-21 11:58:56.000000000 -0700
+++ linux-2.6.9//arch/x86_64/kernel/Makefile	2004-10-22 19:17:03.000000000 -0700
@@ -5,7 +5,7 @@
 extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
-		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
+		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o warmreboot.o
 obj-y += mce.o
