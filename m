Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVDMBS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVDMBS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVDLUMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:12:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:31432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262147AbVDLKbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:37 -0400
Message-Id: <200504121031.j3CAV7hZ005241@shell0.pdx.osdl.net>
Subject: [patch 030/198] ppc32: Fix cpufreq problems
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch updates the PowerMac cpufreq driver.  It depends on the addition
of the suspend() method (my previous patch) and on the new flag I defined
to silence some warnings that are normal for us.

It fixes various issues related to cpufreq on pmac, including some crashes
on some models when sleeping the machine while in low speed, proper voltage
control on some newer machines, and adds voltage control on 750FX based G3
laptops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/pmac_cpufreq.c |  236 ++++++++++++++++++++++++------
 25-akpm/arch/ppc/platforms/pmac_feature.c |   26 ---
 25-akpm/arch/ppc/syslib/open_pic.c        |    5 
 25-akpm/include/asm-ppc/open_pic.h        |    1 
 25-akpm/include/asm-ppc/reg.h             |    1 
 5 files changed, 194 insertions(+), 75 deletions(-)

diff -puN arch/ppc/platforms/pmac_cpufreq.c~ppc32-fix-cpufreq-problems arch/ppc/platforms/pmac_cpufreq.c
--- 25/arch/ppc/platforms/pmac_cpufreq.c~ppc32-fix-cpufreq-problems	2005-04-12 03:21:10.590526896 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_cpufreq.c	2005-04-12 03:21:10.601525224 -0700
@@ -1,13 +1,18 @@
 /*
  *  arch/ppc/platforms/pmac_cpufreq.c
  *
- *  Copyright (C) 2002 - 2004 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  Copyright (C) 2002 - 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *  Copyright (C) 2004        John Steele Scott <toojays@toojays.net>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
+ * TODO: Need a big cleanup here. Basically, we need to have different
+ * cpufreq_driver structures for the different type of HW instead of the
+ * current mess. We also need to better deal with the detection of the
+ * type of machine.
+ *
  */
 
 #include <linux/config.h>
@@ -35,6 +40,7 @@
 #include <asm/time.h>
 #include <asm/system.h>
 #include <asm/open_pic.h>
+#include <asm/keylargo.h>
 
 /* WARNING !!! This will cause calibrate_delay() to be called,
  * but this is an __init function ! So you MUST go edit
@@ -61,11 +67,13 @@ extern void low_sleep_handler(void);
 static unsigned int low_freq;
 static unsigned int hi_freq;
 static unsigned int cur_freq;
+static unsigned int sleep_freq;
 
 /*
  * Different models uses different mecanisms to switch the frequency
  */
 static int (*set_speed_proc)(int low_speed);
+static unsigned int (*get_speed_proc)(void);
 
 /*
  * Some definitions used by the various speedprocs
@@ -73,6 +81,8 @@ static int (*set_speed_proc)(int low_spe
 static u32 voltage_gpio;
 static u32 frequency_gpio;
 static u32 slew_done_gpio;
+static int no_schedule;
+static int has_cpu_l2lve;
 
 
 #define PMAC_CPU_LOW_SPEED	1
@@ -90,6 +100,14 @@ static struct cpufreq_frequency_table pm
 	{0,			CPUFREQ_TABLE_END},
 };
 
+static inline void local_delay(unsigned long ms)
+{
+	if (no_schedule)
+		mdelay(ms);
+	else
+		msleep(ms);
+}
+
 static inline void wakeup_decrementer(void)
 {
 	set_dec(tb_ticks_per_jiffy);
@@ -118,20 +136,48 @@ static inline void debug_calc_bogomips(v
  */
 static int __pmac cpu_750fx_cpu_speed(int low_speed)
 {
-#ifdef DEBUG_FREQ
-	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
-#endif
+	u32 hid2;
+
+	if (low_speed == 0) {
+		/* ramping up, set voltage first */
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
+		/* Make sure we sleep for at least 1ms */
+		local_delay(10);
+
+		/* tweak L2 for high voltage */
+		if (has_cpu_l2lve) {
+			hid2 = mfspr(SPRN_HID2);
+			hid2 &= ~0x2000;
+			mtspr(SPRN_HID2, hid2);
+		}
+	}
 #ifdef CONFIG_6xx
 	low_choose_750fx_pll(low_speed);
 #endif
-#ifdef DEBUG_FREQ
-	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
-	debug_calc_bogomips();
-#endif
+	if (low_speed == 1) {
+		/* tweak L2 for low voltage */
+		if (has_cpu_l2lve) {
+			hid2 = mfspr(SPRN_HID2);
+			hid2 |= 0x2000;
+			mtspr(SPRN_HID2, hid2);
+		}
+
+		/* ramping down, set voltage last */
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
+		local_delay(10);
+	}
 
 	return 0;
 }
 
+static unsigned int __pmac cpu_750fx_get_cpu_speed(void)
+{
+	if (mfspr(SPRN_HID1) & HID1_PS)
+		return low_freq;
+	else
+		return hi_freq;
+}
+
 /* Switch CPU speed using DFS */
 static int __pmac dfs_set_cpu_speed(int low_speed)
 {
@@ -139,22 +185,25 @@ static int __pmac dfs_set_cpu_speed(int 
 		/* ramping up, set voltage first */
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
 		/* Make sure we sleep for at least 1ms */
-		msleep(1);
+		local_delay(1);
 	}
 
 	/* set frequency */
+#ifdef CONFIG_6xx
 	low_choose_7447a_dfs(low_speed);
+#endif
+	udelay(100);
 
 	if (low_speed == 1) {
 		/* ramping down, set voltage last */
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
-		msleep(1);
+		local_delay(1);
 	}
 
 	return 0;
 }
 
-static unsigned int __pmac dfs_get_cpu_speed(unsigned int cpu)
+static unsigned int __pmac dfs_get_cpu_speed(void)
 {
 	if (mfspr(SPRN_HID1) & HID1_DFS)
 		return low_freq;
@@ -167,30 +216,35 @@ static unsigned int __pmac dfs_get_cpu_s
  */
 static int __pmac gpios_set_cpu_speed(int low_speed)
 {
-	int gpio;
+	int gpio, timeout = 0;
 
 	/* If ramping up, set voltage first */
 	if (low_speed == 0) {
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
 		/* Delay is way too big but it's ok, we schedule */
-		msleep(10);
+		local_delay(10);
 	}
 
 	/* Set frequency */
+	gpio = 	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, frequency_gpio, 0);
+	if (low_speed == ((gpio & 0x01) == 0))
+		goto skip;
+
 	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, frequency_gpio,
 			  low_speed ? 0x04 : 0x05);
 	udelay(200);
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		if (++timeout > 100)
+			break;
+		local_delay(1);
 		gpio = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, slew_done_gpio, 0);
 	} while((gpio & 0x02) == 0);
-
+ skip:
 	/* If ramping down, set voltage last */
 	if (low_speed == 1) {
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
 		/* Delay is way too big but it's ok, we schedule */
-		msleep(10);
+		local_delay(10);
 	}
 
 #ifdef DEBUG_FREQ
@@ -207,6 +261,8 @@ static int __pmac pmu_set_cpu_speed(int 
 	struct adb_request req;
 	unsigned long save_l2cr;
 	unsigned long save_l3cr;
+	unsigned int pic_prio;
+	unsigned long flags;
 
 	preempt_disable();
 
@@ -214,7 +270,8 @@ static int __pmac pmu_set_cpu_speed(int 
 	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
 #endif
 	/* Disable all interrupt sources on openpic */
- 	openpic_set_priority(0xf);
+ 	pic_prio = openpic_get_priority();
+	openpic_set_priority(0xf);
 
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
@@ -224,7 +281,7 @@ static int __pmac pmu_set_cpu_speed(int 
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 
 	/* We can now disable MSR_EE */
-	local_irq_disable();
+	local_irq_save(flags);
 
 	/* Giveup the FPU & vec */
 	enable_kernel_fp();
@@ -277,10 +334,10 @@ static int __pmac pmu_set_cpu_speed(int 
 	wakeup_decrementer();
 
 	/* Restore interrupts */
- 	openpic_set_priority(0);
+ 	openpic_set_priority(pic_prio);
 
 	/* Let interrupts flow again ... */
-	local_irq_enable();
+	local_irq_restore(flags);
 
 #ifdef DEBUG_FREQ
 	debug_calc_bogomips();
@@ -291,9 +348,11 @@ static int __pmac pmu_set_cpu_speed(int 
 	return 0;
 }
 
-static int __pmac do_set_cpu_speed(int speed_mode)
+static int __pmac do_set_cpu_speed(int speed_mode, int notify)
 {
 	struct cpufreq_freqs freqs;
+	unsigned long l3cr;
+	static unsigned long prev_l3cr;
 
 	freqs.old = cur_freq;
 	freqs.new = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
@@ -302,14 +361,35 @@ static int __pmac do_set_cpu_speed(int s
 	if (freqs.old == freqs.new)
 		return 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	if (notify)
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	if (speed_mode == PMAC_CPU_LOW_SPEED &&
+	    cpu_has_feature(CPU_FTR_L3CR)) {
+		l3cr = _get_L3CR();
+		if (l3cr & L3CR_L3E) {
+			prev_l3cr = l3cr;
+			_set_L3CR(0);
+		}
+	}
 	set_speed_proc(speed_mode == PMAC_CPU_LOW_SPEED);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	if (speed_mode == PMAC_CPU_HIGH_SPEED &&
+	    cpu_has_feature(CPU_FTR_L3CR)) {
+		l3cr = _get_L3CR();
+		if ((prev_l3cr & L3CR_L3E) && l3cr != prev_l3cr)
+			_set_L3CR(prev_l3cr);
+	}
+	if (notify)
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	cur_freq = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
 
 	return 0;
 }
 
+static unsigned int __pmac pmac_cpufreq_get_speed(unsigned int cpu)
+{
+	return cur_freq;
+}
+
 static int __pmac pmac_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy, pmac_cpu_freqs);
@@ -325,7 +405,7 @@ static int __pmac pmac_cpufreq_target(	s
 			target_freq, relation, &newstate))
 		return -EINVAL;
 
-	return do_set_cpu_speed(newstate);
+	return do_set_cpu_speed(newstate, 1);
 }
 
 unsigned int __pmac pmac_get_one_cpufreq(int i)
@@ -349,19 +429,65 @@ static int __pmac pmac_cpufreq_cpu_init(
 static u32 __pmac read_gpio(struct device_node *np)
 {
 	u32 *reg = (u32 *)get_property(np, "reg", NULL);
+	u32 offset;
 
 	if (reg == NULL)
 		return 0;
 	/* That works for all keylargos but shall be fixed properly
-	 * some day...
+	 * some day... The problem is that it seems we can't rely
+	 * on the "reg" property of the GPIO nodes, they are either
+	 * relative to the base of KeyLargo or to the base of the
+	 * GPIO space, and the device-tree doesn't help.
+	 */
+	offset = *reg;
+	if (offset < KEYLARGO_GPIO_LEVELS0)
+		offset += KEYLARGO_GPIO_LEVELS0;
+	return offset;
+}
+
+static int __pmac pmac_cpufreq_suspend(struct cpufreq_policy *policy, u32 state)
+{
+	/* Ok, this could be made a bit smarter, but let's be robust for now. We
+	 * always force a speed change to high speed before sleep, to make sure
+	 * we have appropriate voltage and/or bus speed for the wakeup process,
+	 * and to make sure our loops_per_jiffies are "good enough", that is will
+	 * not cause too short delays if we sleep in low speed and wake in high
+	 * speed..
+	 */
+	no_schedule = 1;
+	sleep_freq = cur_freq;
+	if (cur_freq == low_freq)
+		do_set_cpu_speed(PMAC_CPU_HIGH_SPEED, 0);
+	return 0;
+}
+
+static int __pmac pmac_cpufreq_resume(struct cpufreq_policy *policy)
+{
+	/* If we resume, first check if we have a get() function */
+	if (get_speed_proc)
+		cur_freq = get_speed_proc();
+	else
+		cur_freq = 0;
+
+	/* We don't, hrm... we don't really know our speed here, best
+	 * is that we force a switch to whatever it was, which is
+	 * probably high speed due to our suspend() routine
 	 */
-	return 0x50 + (*reg);
+	do_set_cpu_speed(sleep_freq == low_freq ? PMAC_CPU_LOW_SPEED
+			 : PMAC_CPU_HIGH_SPEED, 0);
+
+	no_schedule = 0;
+	return 0;
 }
 
 static struct cpufreq_driver pmac_cpufreq_driver = {
 	.verify 	= pmac_cpufreq_verify,
 	.target 	= pmac_cpufreq_target,
+	.get		= pmac_cpufreq_get_speed,
 	.init		= pmac_cpufreq_cpu_init,
+	.suspend	= pmac_cpufreq_suspend,
+	.resume		= pmac_cpufreq_resume,
+	.flags		= CPUFREQ_PM_NO_WARN,
 	.name		= "powermac",
 	.owner		= THIS_MODULE,
 };
@@ -461,14 +587,14 @@ static int __pmac pmac_cpufreq_init_MacR
 static int __pmac pmac_cpufreq_init_7447A(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np;
-	u32 *reg;
-	struct cpufreq_driver *driver = &pmac_cpufreq_driver;
 
-	/* Look for voltage GPIO */
+	if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
+		return 1;
+
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
-	reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
-	voltage_gpio = *reg;
-	if (!volt_gpio_np){
+	if (volt_gpio_np)
+		voltage_gpio = read_gpio(volt_gpio_np);
+	if (!voltage_gpio){
 		printk(KERN_ERR "cpufreq: missing cpu-vcore-select gpio\n");
 		return 1;
 	}
@@ -478,9 +604,37 @@ static int __pmac pmac_cpufreq_init_7447
 	low_freq = cur_freq/2;
 
 	/* Read actual frequency from CPU */
-	driver->get = dfs_get_cpu_speed;
-	cur_freq = driver->get(0);
+	cur_freq = dfs_get_cpu_speed();
 	set_speed_proc = dfs_set_cpu_speed;
+	get_speed_proc = dfs_get_cpu_speed;
+
+	return 0;
+}
+
+static int __pmac pmac_cpufreq_init_750FX(struct device_node *cpunode)
+{
+	struct device_node *volt_gpio_np;
+	u32 pvr, *value;
+
+	if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
+		return 1;
+
+	hi_freq = cur_freq;
+	value = (u32 *)get_property(cpunode, "reduced-clock-frequency", NULL);
+	if (!value)
+		return 1;
+	low_freq = (*value) / 1000;
+
+	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
+	if (volt_gpio_np)
+		voltage_gpio = read_gpio(volt_gpio_np);
+
+	pvr = mfspr(SPRN_PVR);
+	has_cpu_l2lve = !((pvr & 0xf00) == 0x100);
+
+	set_speed_proc = cpu_750fx_cpu_speed;
+	get_speed_proc = cpu_750fx_get_cpu_speed;
+	cur_freq = cpu_750fx_get_cpu_speed();
 
 	return 0;
 }
@@ -543,16 +697,8 @@ static int __init pmac_cpufreq_setup(voi
 		set_speed_proc = pmu_set_cpu_speed;
 	}
 	/* Else check for 750FX */
-	else if (PVR_VER(mfspr(SPRN_PVR)) == 0x7000) {
-		if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
-			goto out;
-		hi_freq = cur_freq;
-		value = (u32 *)get_property(cpunode, "reduced-clock-frequency", NULL);
-		if (!value)
-			goto out;
-		low_freq = (*value) / 1000;		
-		set_speed_proc = cpu_750fx_cpu_speed;
-	}
+	else if (PVR_VER(mfspr(SPRN_PVR)) == 0x7000)
+		pmac_cpufreq_init_750FX(cpunode);
 out:
 	if (set_speed_proc == NULL)
 		return -ENODEV;
diff -puN arch/ppc/platforms/pmac_feature.c~ppc32-fix-cpufreq-problems arch/ppc/platforms/pmac_feature.c
--- 25/arch/ppc/platforms/pmac_feature.c~ppc32-fix-cpufreq-problems	2005-04-12 03:21:10.592526592 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_feature.c	2005-04-12 03:21:10.603524920 -0700
@@ -1779,32 +1779,6 @@ core99_sleep_state(struct device_node* n
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
 		return -EPERM;
 
-#ifdef CONFIG_CPU_FREQ_PMAC
-	/* XXX should be elsewhere */
-	if (machine_is_compatible("PowerBook6,5") ||
-	    machine_is_compatible("PowerBook6,4") ||
-	    machine_is_compatible("PowerBook5,5") ||
-	    machine_is_compatible("PowerBook5,4")) {
-		struct device_node *volt_gpio_np;
-		u32 *reg = NULL;
-
-		volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
-		if (volt_gpio_np != NULL)
-			reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
-		if (reg != NULL) {
-			/* Set the CPU voltage high if sleeping */
-			if (value == 1) {
-				pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
-						  *reg, 0x05);
-			} else if (value == 0 && (mfspr(SPRN_HID1) & HID1_DFS)) {
-				pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
-						  *reg, 0x04);
-			}
-			mdelay(2);
-		}
-	}
-#endif /* CONFIG_CPU_FREQ_PMAC */
-
 	if (value == 1)
 		return core99_sleep();
 	else if (value == 0)
diff -puN arch/ppc/syslib/open_pic.c~ppc32-fix-cpufreq-problems arch/ppc/syslib/open_pic.c
--- 25/arch/ppc/syslib/open_pic.c~ppc32-fix-cpufreq-problems	2005-04-12 03:21:10.593526440 -0700
+++ 25-akpm/arch/ppc/syslib/open_pic.c	2005-04-12 03:21:10.605524616 -0700
@@ -78,7 +78,6 @@ static void openpic_mapirq(u_int irq, cp
  */
 #ifdef notused
 static void openpic_enable_8259_pass_through(void);
-static u_int openpic_get_priority(void);
 static u_int openpic_get_spurious(void);
 static void openpic_set_sense(u_int irq, int sense);
 #endif /* notused */
@@ -465,8 +464,7 @@ void openpic_eoi(void)
 	(void)openpic_read(&OpenPIC->THIS_CPU.EOI);
 }
 
-#ifdef notused
-static u_int openpic_get_priority(void)
+u_int openpic_get_priority(void)
 {
 	DECL_THIS_CPU;
 
@@ -474,7 +472,6 @@ static u_int openpic_get_priority(void)
 	return openpic_readfield(&OpenPIC->THIS_CPU.Current_Task_Priority,
 				 OPENPIC_CURRENT_TASK_PRIORITY_MASK);
 }
-#endif /* notused */
 
 void openpic_set_priority(u_int pri)
 {
diff -puN include/asm-ppc/open_pic.h~ppc32-fix-cpufreq-problems include/asm-ppc/open_pic.h
--- 25/include/asm-ppc/open_pic.h~ppc32-fix-cpufreq-problems	2005-04-12 03:21:10.594526288 -0700
+++ 25-akpm/include/asm-ppc/open_pic.h	2005-04-12 03:21:10.605524616 -0700
@@ -56,6 +56,7 @@ extern void smp_openpic_message_pass(int
 				     int wait);
 extern void openpic_set_k2_cascade(int irq);
 extern void openpic_set_priority(u_int pri);
+extern u_int openpic_get_priority(void);
 
 extern inline int openpic_to_irq(int irq)
 {
diff -puN include/asm-ppc/reg.h~ppc32-fix-cpufreq-problems include/asm-ppc/reg.h
--- 25/include/asm-ppc/reg.h~ppc32-fix-cpufreq-problems	2005-04-12 03:21:10.596525984 -0700
+++ 25-akpm/include/asm-ppc/reg.h	2005-04-12 03:21:10.606524464 -0700
@@ -181,6 +181,7 @@
 #define HID1_PC3	(1<<13)		/* 7450 PLL_CFG[3] */
 #define HID1_SYNCBE	(1<<11)		/* 7450 ABE for sync, eieio */
 #define HID1_ABE	(1<<10)		/* 7450 Address Broadcast Enable */
+#define HID1_PS		(1<<16)		/* 750FX PLL selection */
 #define SPRN_HID2	0x3F8		/* Hardware Implementation Register 2 */
 #define SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define SPRN_HID4	0x3F4		/* 970 HID4 */
_
