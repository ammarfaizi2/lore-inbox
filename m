Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVJDFec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVJDFec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVJDFec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:34:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:35499 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751195AbVJDFeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:34:31 -0400
Subject: [PATCH] ppc64: Add cpufreq support for SMU based G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 15:30:41 +1000
Message-Id: <1128403842.31063.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iMac G5 and latest single CPU desktop G5 (SMU based machines) have a
970FX DD3 CPU that supports frequency & vooltage switching. This patch
adds support for simple dual frequency switch. It is required for the
upcoming thermal control patch for these machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/misc.S
===================================================================
--- linux-work.orig/arch/ppc64/kernel/misc.S	2005-09-23 12:43:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/misc.S	2005-09-29 17:03:04.000000000 +1000
@@ -616,7 +616,7 @@
 	isync
 	blr
 
-	/*
+/*
  * Do an IO access in real mode
  */
 _GLOBAL(real_writeb)
@@ -649,6 +649,76 @@
 #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE) */
 
 /*
+ * SCOM access functions for 970 (FX only for now)
+ *
+ * unsigned long scom970_read(unsigned int address);
+ * void scom970_write(unsigned int address, unsigned long value);
+ *
+ * The address passed in is the 24 bits register address. This code
+ * is 970 specific and will not check the status bits, so you should
+ * know what you are doing.
+ */
+_GLOBAL(scom970_read)
+	/* interrupts off */
+	mfmsr	r4
+	ori	r0,r4,MSR_EE
+	xori	r0,r0,MSR_EE
+	mtmsrd	r0,1
+
+	/* rotate 24 bits SCOM address 8 bits left and mask out it's low 8 bits
+	 * (including parity). On current CPUs they must be 0'd,
+	 * and finally or in RW bit
+	 */
+	rlwinm	r3,r3,8,0,15
+	ori	r3,r3,0x8000
+
+	/* do the actual scom read */
+	sync
+	mtspr	SPRN_SCOMC,r3
+	isync
+	mfspr	r3,SPRN_SCOMD
+	isync
+	mfspr	r0,SPRN_SCOMC
+	isync
+
+	/* XXX:	fixup result on some buggy 970's (ouch ! we lost a bit, bah
+	 * that's the best we can do). Not implemented yet as we don't use
+	 * the scom on any of the bogus CPUs yet, but may have to be done
+	 * ultimately
+	 */
+
+	/* restore interrupts */
+	mtmsrd	r4,1
+	blr
+
+
+_GLOBAL(scom970_write)
+	/* interrupts off */
+	mfmsr	r5
+	ori	r0,r5,MSR_EE
+	xori	r0,r0,MSR_EE
+	mtmsrd	r0,1
+
+	/* rotate 24 bits SCOM address 8 bits left and mask out it's low 8 bits
+	 * (including parity). On current CPUs they must be 0'd.
+	 */
+
+	rlwinm	r3,r3,8,0,15
+
+	sync
+	mtspr	SPRN_SCOMD,r4      /* write data */
+	isync
+	mtspr	SPRN_SCOMC,r3      /* write command */
+	isync
+	mfspr	3,SPRN_SCOMC
+	isync
+
+	/* restore interrupts */
+	mtmsrd	r5,1
+	blr
+
+
+/*
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
  */
Index: linux-work/include/asm-ppc64/processor.h
===================================================================
--- linux-work.orig/include/asm-ppc64/processor.h	2005-09-23 12:44:12.000000000 +1000
+++ linux-work/include/asm-ppc64/processor.h	2005-09-27 11:42:50.000000000 +1000
@@ -177,6 +177,9 @@
 #define SPRN_CTRLT	0x098
 #define   CTRL_RUNLATCH	0x1
 
+#define SPRN_SCOMC	0x114
+#define SPRN_SCOMD	0x115
+
 /* Performance monitor SPRs */
 #define SPRN_SIAR	780
 #define SPRN_SDAR	781
@@ -536,6 +539,9 @@
 	}
 }
 
+extern unsigned long scom970_read(unsigned int address);
+extern void scom970_write(unsigned int address, unsigned long value);
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
Index: linux-work/arch/ppc64/Kconfig
===================================================================
--- linux-work.orig/arch/ppc64/Kconfig	2005-09-23 12:43:21.000000000 +1000
+++ linux-work/arch/ppc64/Kconfig	2005-09-28 10:41:27.000000000 +1000
@@ -159,6 +159,17 @@
 	  support.  As of this writing the exact hardware interface is
 	  strongly in flux, so no good recommendation can be made.
 
+source "drivers/cpufreq/Kconfig"
+
+config CPU_FREQ_PMAC
+	bool "Support for Apple G5"
+	depends on CPU_FREQ && PPC_PMAC64
+	select CPU_FREQ_TABLE
+	help
+	  This adds support for frequency switching on some Apple G5
+          machine. This is currently very experimental and works only
+          on some iMac G5.
+
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
Index: linux-work/arch/ppc64/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/Makefile	2005-09-23 12:43:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/Makefile	2005-09-27 11:42:50.000000000 +1000
@@ -60,6 +60,7 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
 				   udbg_scc.o
+obj-$(CONFIG_CPU_FREQ_PMAC)	+= pmac_cpufreq.o
 
 obj-$(CONFIG_PPC_MAPLE)		+= maple_setup.o maple_pci.o maple_time.o \
 				   udbg_16550.o
Index: linux-work/arch/ppc64/kernel/pmac_cpufreq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/pmac_cpufreq.c	2005-09-27 11:42:50.000000000 +1000
@@ -0,0 +1,297 @@
+/*
+ *  Copyright (C) 2002 - 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  and                       Markus Demleitner <msdemlei@cl.uni-heidelberg.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This driver adds basic cpufreq support for SMU & 970FX based G5 Macs,
+ * that is iMac G5 and latest single CPU desktop.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/completion.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/sections.h>
+#include <asm/cputable.h>
+#include <asm/time.h>
+#include <asm/smu.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/* see 970FX user manual */
+
+#define SCOM_PCR 0x0aa001			/* PCR scom addr */
+
+#define PCR_HILO_SELECT		0x80000000U	/* 1 = PCR, 0 = PCRH */
+#define PCR_SPEED_FULL		0x00000000U	/* 1:1 speed value */
+#define PCR_SPEED_HALF		0x00020000U	/* 1:2 speed value */
+#define PCR_SPEED_QUARTER	0x00040000U	/* 1:4 speed value */
+#define PCR_SPEED_MASK		0x000e0000U	/* speed mask */
+#define PCR_SPEED_SHIFT		17
+#define PCR_FREQ_REQ_VALID	0x00010000U	/* freq request valid */
+#define PCR_VOLT_REQ_VALID	0x00008000U	/* volt request valid */
+#define PCR_TARGET_TIME_MASK	0x00006000U	/* target time */
+#define PCR_STATLAT_MASK	0x00001f00U	/* STATLAT value */
+#define PCR_SNOOPLAT_MASK	0x000000f0U	/* SNOOPLAT value */
+#define PCR_SNOOPACC_MASK	0x0000000fU	/* SNOOPACC value */
+
+#define SCOM_PSR 0x408001			/* PSR scom addr */
+/* warning: PSR is a 64 bits register */
+#define PSR_CMD_RECEIVED	0x2000000000000000U   /* command received */
+#define PSR_CMD_COMPLETED	0x1000000000000000U   /* command completed */
+#define PSR_CUR_SPEED_MASK	0x0300000000000000U   /* current speed */
+#define PSR_CUR_SPEED_SHIFT	(56)
+
+/*
+ * The G5 only supports two frequencies (Quarter speed is not supported)
+ */
+#define CPUFREQ_HIGH                  0
+#define CPUFREQ_LOW                   1
+
+static struct cpufreq_frequency_table g5_cpu_freqs[] = {
+	{CPUFREQ_HIGH, 		0},
+	{CPUFREQ_LOW,		0},
+	{0,			CPUFREQ_TABLE_END},
+};
+
+static struct freq_attr* g5_cpu_freqs_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+/* Power mode data is an array of the 32 bits PCR values to use for
+ * the various frequencies, retreived from the device-tree
+ */
+static u32 *g5_pmode_data;
+static int g5_pmode_max;
+static int g5_pmode_cur;
+
+
+static struct smu_sdbp_fvt *g5_fvt_table;	/* table of op. points */
+static int g5_fvt_count;			/* number of op. points */
+static int g5_fvt_cur;				/* current op. point */
+
+/* ----------------- real hardware interface */
+
+static void g5_switch_volt(int speed_mode)
+{
+	struct smu_simple_cmd	cmd;
+
+	DECLARE_COMPLETION(comp);
+	smu_queue_simple(&cmd, SMU_CMD_POWER_COMMAND, 8, smu_done_complete,
+			 &comp, 'V', 'S', 'L', 'E', 'W',
+			 0xff, g5_fvt_cur+1, speed_mode);
+	wait_for_completion(&comp);
+}
+
+static int g5_switch_freq(int speed_mode)
+{
+	int to;
+
+	if (g5_pmode_cur == speed_mode)
+		return 0;
+
+	/* If frequency is going up, first ramp up the voltage */
+	if (speed_mode < g5_pmode_cur)
+		g5_switch_volt(speed_mode);
+
+	/* Clear PCR high */
+	scom970_write(SCOM_PCR, 0);
+	/* Clear PCR low */
+       	scom970_write(SCOM_PCR, PCR_HILO_SELECT | 0);
+	/* Set PCR low */
+	scom970_write(SCOM_PCR, PCR_HILO_SELECT |
+		      g5_pmode_data[speed_mode]);
+
+	/* Wait for completion */
+	for (to = 0; to < 10; to++) {
+		unsigned long psr = scom970_read(SCOM_PSR);
+
+		if ((psr & PSR_CMD_RECEIVED) == 0 &&
+		    (((psr >> PSR_CUR_SPEED_SHIFT) ^
+		      (g5_pmode_data[speed_mode] >> PCR_SPEED_SHIFT)) & 0x3)
+		    == 0)
+			break;
+		if (psr & PSR_CMD_COMPLETED)
+			break;
+		udelay(100);
+	}
+
+	/* If frequency is going down, last ramp the voltage */
+	if (speed_mode > g5_pmode_cur)
+		g5_switch_volt(speed_mode);
+
+	g5_pmode_cur = speed_mode;
+	ppc_proc_freq = g5_cpu_freqs[speed_mode].frequency * 1000ul;
+
+	return 0;
+}
+
+static int g5_query_freq(void)
+{
+	unsigned long psr = scom970_read(SCOM_PSR);
+	int i;
+
+	for (i = 0; i <= g5_pmode_max; i++)
+		if ((((psr >> PSR_CUR_SPEED_SHIFT) ^
+		      (g5_pmode_data[i] >> PCR_SPEED_SHIFT)) & 0x3) == 0)
+			break;
+	return i;
+}
+
+/* ----------------- cpufreq bookkeeping */
+static int __pmac g5_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, g5_cpu_freqs);
+}
+
+static int __pmac g5_cpufreq_target(struct cpufreq_policy *policy,
+	unsigned int target_freq, unsigned int relation)
+{
+	unsigned int    newstate = 0;
+
+	if (cpufreq_frequency_table_target(policy, g5_cpu_freqs,
+			target_freq, relation, &newstate))
+		return -EINVAL;
+
+	return g5_switch_freq(newstate);
+}
+
+static int __pmac g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	if (policy->cpu != 0)
+		return -ENODEV;
+
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cur = g5_cpu_freqs[g5_query_freq()].frequency;
+	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
+
+	return cpufreq_frequency_table_cpuinfo(policy,
+		g5_cpu_freqs);
+}
+
+
+static struct cpufreq_driver g5_cpufreq_driver = {
+	.name		= "powermac",
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.init		= g5_cpufreq_cpu_init,
+	.verify		= g5_cpufreq_verify,
+	.target		= g5_cpufreq_target,
+	.attr 		= g5_cpu_freqs_attr,
+};
+
+
+static int __init g5_cpufreq_init(void)
+{
+	struct device_node *cpunode;
+	unsigned int psize, ssize;
+	struct smu_sdbp_header *shdr;
+	unsigned long max_freq;
+	u32 *valp;
+	int rc = -ENODEV;
+
+	/* Look for CPU and SMU nodes */
+	cpunode = of_find_node_by_type(NULL, "cpu");
+	if (!cpunode) {
+		DBG("No CPU node !\n");
+		return -ENODEV;
+	}
+
+	/* Check 970FX for now */
+	valp = (u32 *)get_property(cpunode, "cpu-version", NULL);
+	if (!valp) {
+		DBG("No cpu-version property !\n");
+		goto bail_noprops;
+	}
+	if (((*valp) >> 16) != 0x3c) {
+		DBG("Wrong CPU version: %08x\n", *valp);
+		goto bail_noprops;
+	}
+
+	/* Look for the powertune data in the device-tree */
+	g5_pmode_data = (u32 *)get_property(cpunode, "power-mode-data",&psize);
+	if (!g5_pmode_data) {
+		DBG("No power-mode-data !\n");
+		goto bail_noprops;
+	}
+	g5_pmode_max = psize / sizeof(u32) - 1;
+
+	/* Look for the FVT table */
+	shdr = smu_get_sdb_partition(SMU_SDB_FVT_ID, NULL);
+	if (!shdr)
+		goto bail_noprops;
+	g5_fvt_table = (struct smu_sdbp_fvt *)&shdr[1];
+	ssize = (shdr->len * sizeof(u32)) - sizeof(struct smu_sdbp_header);
+	g5_fvt_count = ssize / sizeof(struct smu_sdbp_fvt);
+	g5_fvt_cur = 0;
+
+	/* Sanity checking */
+	if (g5_fvt_count < 1 || g5_pmode_max < 1)
+		goto bail_noprops;
+
+	/*
+	 * From what I see, clock-frequency is always the maximal frequency.
+	 * The current driver can not slew sysclk yet, so we really only deal
+	 * with powertune steps for now. We also only implement full freq and
+	 * half freq in this version. So far, I haven't yet seen a machine
+	 * supporting anything else.
+	 */
+	valp = (u32 *)get_property(cpunode, "clock-frequency", NULL);
+	if (!valp)
+		return -ENODEV;
+	max_freq = (*valp)/1000;
+	g5_cpu_freqs[0].frequency = max_freq;
+	g5_cpu_freqs[1].frequency = max_freq/2;
+
+	/* Check current frequency */
+	g5_pmode_cur = g5_query_freq();
+	if (g5_pmode_cur > 1) {
+		/* We don't support anything but 1:1 and 1:2, fixup ... */
+		g5_switch_freq(1);
+		g5_pmode_cur = 1;
+	}
+
+	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
+	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
+		g5_cpu_freqs[1].frequency/1000,
+		g5_cpu_freqs[0].frequency/1000,
+		g5_cpu_freqs[g5_pmode_cur].frequency/1000);
+
+	rc = cpufreq_register_driver(&g5_cpufreq_driver);
+
+	/* We keep the CPU node on hold... hopefully, Apple G5 don't have
+	 * hotplug CPU with a dynamic device-tree ...
+	 */
+	return rc;
+
+ bail_noprops:
+	of_node_put(cpunode);
+
+	return rc;
+}
+
+module_init(g5_cpufreq_init);
+
+
+MODULE_LICENSE("GPL");
Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- linux-work.orig/drivers/macintosh/smu.c	2005-09-26 11:48:36.000000000 +1000
+++ linux-work/drivers/macintosh/smu.c	2005-09-29 16:56:59.000000000 +1000
@@ -843,6 +843,18 @@
 	return 0;
 }
 
+struct smu_sdbp_header *smu_get_sdb_partition(int id, unsigned int *size)
+{
+	char pname[32];
+
+	if (!smu)
+		return NULL;
+
+	sprintf(pname, "sdb-partition-%02x", id);
+	return (struct smu_sdbp_header *)get_property(smu->of_node,
+						      pname, size);
+}
+EXPORT_SYMBOL(smu_get_sdb_partition);
 
 
 /*
Index: linux-work/include/asm-ppc64/smu.h
===================================================================
--- linux-work.orig/include/asm-ppc64/smu.h	2005-09-26 11:48:37.000000000 +1000
+++ linux-work/include/asm-ppc64/smu.h	2005-09-29 16:56:59.000000000 +1000
@@ -144,7 +144,11 @@
  *  - lenght 8 ("VSLEWxyz") has 3 additional bytes appended, and is
  *    used to set the voltage slewing point. The SMU replies with "DONE"
  * I yet have to figure out their exact meaning of those 3 bytes in
- * both cases.
+ * both cases. They seem to be:
+ *  x = processor mask
+ *  y = op. point index
+ *  z = processor freq. step index
+ * I haven't yet decyphered result codes
  *
  */
 #define SMU_CMD_POWER_COMMAND			0xaa
@@ -244,6 +248,7 @@
  */
 extern void smu_done_complete(struct smu_cmd *cmd, void *misc);
 
+
 /*
  * Synchronous helpers. Will spin-wait for completion of a command
  */
@@ -334,6 +339,59 @@
 #endif /* __KERNEL__ */
 
 /*
+ * - SMU "sdb" partitions informations -
+ */
+
+
+/*
+ * Partition header format
+ */
+struct smu_sdbp_header {
+	__u8	id;
+	__u8	len;
+	__u8	version;
+	__u8	flags;
+};
+
+/*
+ * 32 bits integers are usually encoded with 2x16 bits swapped,
+ * this demangles them
+ */
+#define SMU_U32_MIX(x)	((((x) << 16) & 0xffff0000u) | (((x) >> 16) & 0xffffu))
+
+/* This is the definition of the SMU sdb-partition-0x12 table (called
+ * CPU F/V/T operating points in Darwin). The definition for all those
+ * SMU tables should be moved to some separate file
+ */
+#define SMU_SDB_FVT_ID		0x12
+
+struct smu_sdbp_fvt {
+	__u32	sysclk;			/* Base SysClk frequency in Hz for
+					 * this operating point
+					 */
+	__u8	pad;
+	__u8	maxtemp;		/* Max temp. supported by this
+					 * operating point
+					 */
+
+	__u16	volts[3];		/* CPU core voltage for the 3
+					 * PowerTune modes, a mode with
+					 * 0V = not supported.
+					 */
+};
+
+#ifdef __KERNEL__
+/*
+ * This returns the pointer to an SMU "sdb" partition data or NULL
+ * if not found. The data format is described below
+ */
+extern struct smu_sdbp_header *smu_get_sdb_partition(int id,
+						     unsigned int *size);
+
+#endif /* __KERNEL__ */
+
+
+/*
  * - Userland interface -
  */
 
@@ -376,4 +434,5 @@
 	__u32		reply_len;		/* Lenght of data follwing */
 };
 
+
 #endif /*  _SMU_H */


