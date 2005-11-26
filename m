Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVKZOzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKZOzw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKZOzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:55:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3995 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932154AbVKZOzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:55:42 -0500
Date: Sat, 26 Nov 2005 15:55:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 12/13] Time: i386/x86-64 Clocksource Drivers
Message-ID: <20051126145546.GK12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013635.18537.3747.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013635.18537.3747.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-arch-x86-64-part2.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/hpet.c          |   35 ++++++++++---------
 drivers/clocksource/acpi_pm.c    |   50 ++++++++++++++-------------
 drivers/clocksource/cyclone.c    |   71 ++++++++++++++++++++-------------------
 drivers/clocksource/tsc-interp.c |   55 ++++++++++++++----------------
 4 files changed, 110 insertions(+), 101 deletions(-)

Index: linux/arch/i386/kernel/hpet.c
===================================================================
--- linux.orig/arch/i386/kernel/hpet.c
+++ linux/arch/i386/kernel/hpet.c
@@ -1,15 +1,16 @@
 #include <linux/clocksource.h>
-#include <linux/hpet.h>
 #include <linux/errno.h>
+#include <linux/hpet.h>
 #include <linux/init.h>
-#include <asm/io.h>
+
 #include <asm/hpet.h>
+#include <asm/io.h>
 
-#define HPET_MASK (0xFFFFFFFF)
-#define HPET_SHIFT 22
+#define HPET_MASK	0xFFFFFFFF
+#define HPET_SHIFT	22
 
 /* FSEC = 10^-15 NSEC = 10^-9 */
-#define FSEC_PER_NSEC 1000000
+#define FSEC_PER_NSEC	1000000
 
 static void *hpet_ptr;
 
@@ -19,13 +20,13 @@ static cycle_t read_hpet(void)
 }
 
 struct clocksource clocksource_hpet = {
-	.name = "hpet",
-	.rating = 250,
-	.read = read_hpet,
-	.mask = (cycle_t)HPET_MASK,
-	.mult = 0, /* set below */
-	.shift = HPET_SHIFT,
-	.is_continuous = 1,
+	.name		= "hpet",
+	.rating		= 250,
+	.read		= read_hpet,
+	.mask		= (cycle_t)HPET_MASK,
+	.mult		= 0, /* set below */
+	.shift		= HPET_SHIFT,
+	.is_continuous	= 1,
 };
 
 static int __init init_hpet_clocksource(void)
@@ -37,16 +38,16 @@ static int __init init_hpet_clocksource(
 	if (!hpet_address)
 		return -ENODEV;
 
-	/* calculate the hpet address */
+	/* calculate the hpet address: */
 	hpet_base =
 		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
 	hpet_ptr = hpet_base + HPET_COUNTER;
 
-	/* calculate the frequency */
+	/* calculate the frequency: */
 	hpet_period = readl(hpet_base + HPET_PERIOD);
 
-
-	/* hpet period is in femto seconds per cycle
+	/*
+	 * hpet period is in femto seconds per cycle
 	 * so we need to convert this to ns/cyc units
 	 * aproximated by mult/2^shift
 	 *
@@ -61,6 +62,8 @@ static int __init init_hpet_clocksource(
 	clocksource_hpet.mult = (u32)tmp;
 
 	register_clocksource(&clocksource_hpet);
+
 	return 0;
 }
+
 module_init(init_hpet_clocksource);
Index: linux/drivers/clocksource/acpi_pm.c
===================================================================
--- linux.orig/drivers/clocksource/acpi_pm.c
+++ linux/drivers/clocksource/acpi_pm.c
@@ -16,7 +16,6 @@
  * This file is licensed under the GPL v2.
  */
 
-
 #include <linux/clocksource.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -26,19 +25,20 @@
 #define PMTMR_TICKS_PER_SEC 3579545
 
 #if (defined(CONFIG_X86) && (!defined(CONFIG_X86_64)))
-#include "mach_timer.h"
-#define PMTMR_EXPECTED_RATE ((PMTMR_TICKS_PER_SEC*CALIBRATE_TIME_MSEC)/1000)
+# include "mach_timer.h"
+# define PMTMR_EXPECTED_RATE ((PMTMR_TICKS_PER_SEC*CALIBRATE_TIME_MSEC)/1000)
 #endif
 
-/* The I/O port the PMTMR resides at.
+/*
+ * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
- * in arch/i386/acpi/boot.c */
+ * in arch/i386/acpi/boot.c
+ */
 extern u32 acpi_pmtmr_ioport;
 extern int acpi_pmtmr_buggy;
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
-
 static inline u32 read_pmtmr(void)
 {
 	/* mask the output to 24 bits */
@@ -47,11 +47,13 @@ static inline u32 read_pmtmr(void)
 
 static cycle_t acpi_pm_read_verified(void)
 {
-	u32 v1=0,v2=0,v3=0;
-	/* It has been reported that because of various broken
+	u32 v1 = 0, v2 = 0, v3 = 0;
+
+	/*
+	 * It has been reported that because of various broken
 	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM clock
 	 * source is not latched, so you must read it multiple
-	 * times to insure a safe value is read.
+	 * times to ensure a safe value is read:
 	 */
 	do {
 		v1 = read_pmtmr();
@@ -63,31 +65,30 @@ static cycle_t acpi_pm_read_verified(voi
 	return (cycle_t)v2;
 }
 
-
 static cycle_t acpi_pm_read(void)
 {
 	return (cycle_t)read_pmtmr();
 }
 
 struct clocksource clocksource_acpi_pm = {
-	.name = "acpi_pm",
-	.rating = 200,
-	.read = acpi_pm_read,
-	.mask = (cycle_t)ACPI_PM_MASK,
-	.mult = 0, /*to be caluclated*/
-	.shift = 22,
-	.is_continuous = 1,
+	.name		= "acpi_pm",
+	.rating		= 200,
+	.read		= acpi_pm_read,
+	.mask		= (cycle_t)ACPI_PM_MASK,
+	.mult		= 0, /*to be caluclated*/
+	.shift		= 22,
+	.is_continuous	= 1,
 };
 
-#if (defined(CONFIG_X86) && (!defined(CONFIG_X86_64)))
+#if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
 /*
  * Some boards have the PMTMR running way too fast. We check
  * the PMTMR rate against PIT channel 2 to catch these cases.
  */
 static int __init verify_pmtmr_rate(void)
 {
-	u32 value1, value2;
 	unsigned long count, delta;
+	u32 value1, value2;
 
 	mach_prepare_counter();
 	value1 = read_pmtmr();
@@ -95,7 +96,7 @@ static int __init verify_pmtmr_rate(void
 	value2 = read_pmtmr();
 	delta = (value2 - value1) & ACPI_PM_MASK;
 
-	/* Check that the PMTMR delta is within 5% of what we expect */
+	/* check that the PMTMR delta is within 5% of what we expect: */
 	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
 	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
 		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
@@ -105,7 +106,7 @@ static int __init verify_pmtmr_rate(void
 	return 0;
 }
 #else
-#define verify_pmtmr_rate() (0)
+# define verify_pmtmr_rate() (0)
 #endif
 
 static int __init init_acpi_pm_clocksource(void)
@@ -117,9 +118,9 @@ static int __init init_acpi_pm_clocksour
 		return -ENODEV;
 
 	clocksource_acpi_pm.mult = clocksource_hz2mult(PMTMR_TICKS_PER_SEC,
-									clocksource_acpi_pm.shift);
+						clocksource_acpi_pm.shift);
 
-	/* "verify" this timing source */
+	/* "verify" this timing source: */
 	value1 = read_pmtmr();
 	for (i = 0; i < 10000; i++) {
 		value2 = read_pmtmr();
@@ -139,13 +140,14 @@ pm_good:
 	if (verify_pmtmr_rate() != 0)
 		return -ENODEV;
 
-	/* check to see if pmtmr is known buggy */
+	/* check to see if pmtmr is known buggy: */
 	if (acpi_pmtmr_buggy) {
 		clocksource_acpi_pm.read = acpi_pm_read_verified;
 		clocksource_acpi_pm.rating = 110;
 	}
 
 	register_clocksource(&clocksource_acpi_pm);
+
 	return 0;
 }
 
Index: linux/drivers/clocksource/cyclone.c
===================================================================
--- linux.orig/drivers/clocksource/cyclone.c
+++ linux/drivers/clocksource/cyclone.c
@@ -1,19 +1,20 @@
 #include <linux/clocksource.h>
-#include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/errno.h>
 #include <linux/timex.h>
 #include <linux/init.h>
 
-#include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/io.h>
+
 #include "mach_timer.h"
 
-#define CYCLONE_CBAR_ADDR 0xFEB00CD0		/* base address ptr*/
-#define CYCLONE_PMCC_OFFSET 0x51A0		/* offset to control register */
-#define CYCLONE_MPCS_OFFSET 0x51A8		/* offset to select register */
-#define CYCLONE_MPMC_OFFSET 0x51D0		/* offset to count register */
-#define CYCLONE_TIMER_FREQ 99780000		/* 100Mhz, but not really */
-#define CYCLONE_TIMER_MASK (0xFFFFFFFF) /* 32 bit mask */
+#define CYCLONE_CBAR_ADDR	0xFEB00CD0	/* base address ptr */
+#define CYCLONE_PMCC_OFFSET	0x51A0		/* offset to control register */
+#define CYCLONE_MPCS_OFFSET	0x51A8		/* offset to select register */
+#define CYCLONE_MPMC_OFFSET	0x51D0		/* offset to count register */
+#define CYCLONE_TIMER_FREQ	99780000	/* 100Mhz, but not really */
+#define CYCLONE_TIMER_MASK	0xFFFFFFFF	/* 32 bit mask */
 
 int use_cyclone = 0;
 static void __iomem *cyclone_ptr;
@@ -24,77 +25,81 @@ static cycle_t read_cyclone(void)
 }
 
 struct clocksource clocksource_cyclone = {
-	.name = "cyclone",
-	.rating = 250,
-	.read = read_cyclone,
-	.mask = (cycle_t)CYCLONE_TIMER_MASK,
-	.mult = 10,
-	.shift = 0,
-	.is_continuous = 1,
+	.name		= "cyclone",
+	.rating		= 250,
+	.read		= read_cyclone,
+	.mask		= (cycle_t)CYCLONE_TIMER_MASK,
+	.mult		= 10,
+	.shift		= 0,
+	.is_continuous	= 1,
 };
 
 static int __init init_cyclone_clocksource(void)
 {
 	unsigned long base;	/* saved value from CBAR */
 	unsigned long offset;
-	u32 __iomem* reg;
 	u32 __iomem* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+	u32 __iomem* reg;
 	int i;
 
-	/*make sure we're on a summit box*/
-	if (!use_cyclone) return -ENODEV;
+	/* make sure we're on a summit box: */
+	if (!use_cyclone)
+		return -ENODEV;
 
 	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
 
-	/* find base address */
+	/* find base address: */
 	offset = CYCLONE_CBAR_ADDR;
 	reg = ioremap_nocache(offset, sizeof(reg));
-	if(!reg){
+	if (!reg) {
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
 		return -ENODEV;
 	}
-	/* even on 64bit systems, this is only 32bits */
+	/* even on 64bit systems, this is only 32bits: */
 	base = readl(reg);
-	if(!base){
+	if (!base) {
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
 		return -ENODEV;
 	}
 	iounmap(reg);
 
-	/* setup PMCC */
+	/* setup PMCC: */
 	offset = base + CYCLONE_PMCC_OFFSET;
 	reg = ioremap_nocache(offset, sizeof(reg));
-	if(!reg){
+	if (!reg) {
 		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
 		return -ENODEV;
 	}
 	writel(0x00000001,reg);
 	iounmap(reg);
 
-	/* setup MPCS */
+	/* setup MPCS: */
 	offset = base + CYCLONE_MPCS_OFFSET;
 	reg = ioremap_nocache(offset, sizeof(reg));
-	if(!reg){
+	if (!reg) {
 		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
 		return -ENODEV;
 	}
 	writel(0x00000001,reg);
 	iounmap(reg);
 
-	/* map in cyclone_timer */
+	/* map in cyclone_timer: */
 	offset = base + CYCLONE_MPMC_OFFSET;
 	cyclone_timer = ioremap_nocache(offset, sizeof(u64));
-	if(!cyclone_timer){
+	if (!cyclone_timer) {
 		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
 		return -ENODEV;
 	}
 
-	/*quick test to make sure its ticking*/
-	for(i=0; i<3; i++){
+	/* quick test to make sure its ticking: */
+	for (i = 0; i < 3; i++){
 		u32 old = readl(cyclone_timer);
 		int stall = 100;
-		while(stall--) barrier();
-		if(readl(cyclone_timer) == old){
+
+		while (stall--)
+			barrier();
+
+		if (readl(cyclone_timer) == old) {
 			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
 			iounmap(cyclone_timer);
 			cyclone_timer = NULL;
@@ -103,7 +108,7 @@ static int __init init_cyclone_clocksour
 	}
 	cyclone_ptr = cyclone_timer;
 
-	/* sort out mult/shift values */
+	/* sort out mult/shift values: */
 	clocksource_cyclone.shift = 22;
 	clocksource_cyclone.mult = clocksource_hz2mult(CYCLONE_TIMER_FREQ,
 						clocksource_cyclone.shift);
Index: linux/drivers/clocksource/tsc-interp.c
===================================================================
--- linux.orig/drivers/clocksource/tsc-interp.c
+++ linux/drivers/clocksource/tsc-interp.c
@@ -1,14 +1,15 @@
-/* TSC-Jiffies Interpolation clocksource
-	Example interpolation clocksource.
-TODO:
-	o per-cpu TSC offsets
-*/
+/*
+ * TSC-Jiffies Interpolation clocksource
+ *	Example interpolation clocksource.
+ * TODO:
+ *	o per-cpu TSC offsets
+ */
 #include <linux/clocksource.h>
+#include <linux/jiffies.h>
+#include <linux/threads.h>
 #include <linux/timer.h>
 #include <linux/timex.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/threads.h>
 #include <linux/smp.h>
 
 static unsigned long current_tsc_khz = 0;
@@ -20,27 +21,27 @@ struct timer_list tsc_interp_timer;
 
 static unsigned long mult, shift;
 
-#define NSEC_PER_JIFFY ((((unsigned long long)NSEC_PER_SEC)<<8)/ACTHZ)
-#define SHIFT_VAL 22
+#define NSEC_PER_JIFFY	((((unsigned long long)NSEC_PER_SEC)<<8)/ACTHZ)
+#define SHIFT_VAL	22
 
 static cycle_t read_tsc_interp(void);
 static void tsc_interp_update_callback(void);
 
 static struct clocksource clocksource_tsc_interp = {
-	.name = "tsc-interp",
-	.rating = 150,
-	.type = CLOCKSOURCE_FUNCTION,
-	.read_fnct = read_tsc_interp,
-	.mask = (cycle_t)((1ULL<<32)-1),
-	.mult = 1<<SHIFT_VAL,
-	.shift = SHIFT_VAL,
-	.update_callback = tsc_interp_update_callback,
+	.name			= "tsc-interp",
+	.rating			= 150,
+	.type			= CLOCKSOURCE_FUNCTION,
+	.read_fnct		= read_tsc_interp,
+	.mask			= (cycle_t)((1ULL<<32)-1),
+	.mult			= 1<<SHIFT_VAL,
+	.shift			= SHIFT_VAL,
+	.update_callback	= tsc_interp_update_callback,
 };
 
 static void tsc_interp_sync(unsigned long unused)
 {
-	cycle_t tsc_now;
 	unsigned long jiffies_now;
+	cycle_t tsc_now;
 
 	do {
 		jiffies_now = jiffies;
@@ -55,13 +56,10 @@ static void tsc_interp_sync(unsigned lon
 	mod_timer(&tsc_interp_timer, jiffies+1);
 }
 
-
 static cycle_t read_tsc_interp(void)
 {
-	cycle_t ret;
-	cycle_t now, then;
-	unsigned long jiffs_now, jiffs_then;
-	unsigned long seq;
+	unsigned long seq, jiffs_now, jiffs_then;
+	cycle_t ret, now, then;
 
 	do {
 		seq = read_seqbegin(&tsc_interp_lock);
@@ -75,7 +73,8 @@ static cycle_t read_tsc_interp(void)
 	rdtscll(now);
 	ret = (cycle_t)jiffs_then * NSEC_PER_JIFFY;
 	if (jiffs_then == jiffs_now)
-		ret += min((cycle_t)NSEC_PER_JIFFY,(cycle_t)((now - then)*mult)>> shift);
+		ret += min((cycle_t)NSEC_PER_JIFFY,
+				(cycle_t)((now - then)*mult) >> shift);
 	else
 		ret += (cycle_t)(jiffs_now - jiffs_then)*NSEC_PER_JIFFY;
 
@@ -84,14 +83,13 @@ static cycle_t read_tsc_interp(void)
 
 static void tsc_interp_update_callback(void)
 {
-	/* only update if tsc_khz has changed */
-	if (current_tsc_khz != tsc_khz){
+	/* only update if tsc_khz has changed: */
+	if (current_tsc_khz != tsc_khz) {
 		current_tsc_khz = tsc_khz;
 		mult = clocksource_khz2mult(current_tsc_khz, shift);
 	}
 }
 
-
 static int __init init_tsc_interp_clocksource(void)
 {
 	/* TSC initialization is done in arch/i386/kernel/tsc.c */
@@ -99,7 +97,7 @@ static int __init init_tsc_interp_clocks
 		current_tsc_khz = tsc_khz;
 		shift = SHIFT_VAL;
 		mult = clocksource_khz2mult(current_tsc_khz, shift);
-		/* setup periodic soft-timer */
+		/* setup periodic soft-timer: */
 		init_timer(&tsc_interp_timer);
 		tsc_interp_timer.function = tsc_interp_sync;
 		tsc_interp_timer.expires = jiffies;
@@ -109,4 +107,5 @@ static int __init init_tsc_interp_clocks
 	}
 	return 0;
 }
+
 module_init(init_tsc_interp_clocksource);
