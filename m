Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUGDSgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUGDSgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUGDSgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 14:36:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:61341 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265454AbUGDSeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 14:34:18 -0400
X-Authenticated: #555161
Message-ID: <40E857BB.70504@hasw.net>
Date: Sun, 04 Jul 2004 21:17:15 +0200
From: Sebastian Witt <se.witt@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq driver for nForce2, kernel 2.6.7
Content-Type: multipart/mixed;
 boundary="------------080708050403080204000205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080708050403080204000205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Adds cpufreq support for FSB changing on nForce2 plattforms. On this 
plattforms the PCI/AGP clock is independent from the FSB and it also 
doesn't depend on the used CPU.

Regards,
Sebastian

--------------080708050403080204000205
Content-Type: text/plain;
 name="cpufreq-nforce2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq-nforce2.patch"

diff -ruN linux-2.6.7-orig/Documentation/cpu-freq/cpufreq-nforce2.txt linux/Documentation/cpu-freq/cpufreq-nforce2.txt
--- linux-2.6.7-orig/Documentation/cpu-freq/cpufreq-nforce2.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux/Documentation/cpu-freq/cpufreq-nforce2.txt	2004-06-18 20:10:32.000000000 +0200
@@ -0,0 +1,22 @@
+
+The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 plattforms.
+
+This works better than on other plattforms, because the FSB of the CPU
+can be controlled independently from the PCI/AGP clock.
+
+The module has three options:
+
+	fid: 	 multiplier * 10 (for example 8.5 = 85)
+	min_fsb: minimum FSB
+	max_fsb: maximum FSB
+
+If not set, fid is calculated with the current CPU speed and the FSB,
+max_fsb is set to the current FSB and min_fsb to current FSB - 50.
+
+IMPORTANT: The available range is limited up- _and_ downwards!
+           You should not set max_fsb higher than the FSB at boot-
+           time.
+           Also the minimum available FSB can differ, for systems 
+           booting with 200 MHz, 150 should always work.
+
+
diff -ruN linux-2.6.7-orig/arch/i386/kernel/cpu/cpufreq/Kconfig linux/arch/i386/kernel/cpu/cpufreq/Kconfig
--- linux-2.6.7-orig/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-05-10 04:32:02.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-06-18 20:30:38.000000000 +0200
@@ -186,6 +186,17 @@
 	  option let's the probing code bypass some of those checks if the
 	  parameter "relaxed_check=1" is passed to the module.
 
+config X86_CPUFREQ_NFORCE2
+	tristate "nVidia nForce2 FSB changing"
+	depends on CPU_FREQ && EXPERIMENTAL
+	help
+	  This adds the CPUFreq driver for FSB changing on nVidia nForce2
+	  plattforms.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  If in doubt, say N.
+
 config X86_LONGRUN
 	tristate "Transmeta LongRun"
 	depends on CPU_FREQ
diff -ruN linux-2.6.7-orig/arch/i386/kernel/cpu/cpufreq/Makefile linux/arch/i386/kernel/cpu/cpufreq/Makefile
--- linux-2.6.7-orig/arch/i386/kernel/cpu/cpufreq/Makefile	2004-06-18 19:49:25.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/Makefile	2004-06-18 21:02:48.000000000 +0200
@@ -11,6 +11,7 @@
 obj-$(CONFIG_X86_SPEEDSTEP_SMI) += speedstep-smi.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ)	+= acpi.o
 obj-$(CONFIG_X86_P4_CLOCKMOD)	+= p4-clockmod.o
+obj-$(CONFIG_X86_CPUFREQ_NFORCE2) += cpufreq-nforce2.o
 
 ifdef CONFIG_X86_ACPI_CPUFREQ
   ifdef CONFIG_ACPI_DEBUG
diff -ruN linux-2.6.7-orig/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c linux/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
--- linux-2.6.7-orig/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c	2004-06-18 21:01:24.000000000 +0200
@@ -0,0 +1,468 @@
+/*
+ * (C) 2004  Sebastian Witt <se.witt@gmx.net>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *  Based upon reverse engineered information
+ *
+ *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#define NFORCE2_XTAL 25
+#define NFORCE2_BOOTFSB 0x48
+#define NFORCE2_PLLENABLE 0xa8
+#define NFORCE2_PLLREG 0xa4
+#define NFORCE2_PLLADR 0xa0
+#define NFORCE2_PLL(mul, div) (0x100000 | (mul << 8) | div)
+
+#define NFORCE2_MIN_FSB 50
+#define NFORCE2_MAX_FSB 300
+#define NFORCE2_SAFE_DISTANCE 50
+
+/* Delay in ms between FSB changes */
+//#define NFORCE2_DELAY 10
+
+/* nforce2_chipset:
+ * FSB is changed using the chipset
+ */
+static struct pci_dev *nforce2_chipset_dev;
+
+/* fid:
+ * multiplier * 10
+ */
+static int fid = 0;
+
+/* min_fsb, max_fsb:
+ * maximum and minimum available FSB
+ */
+static int min_fsb = 0;
+static int max_fsb = 0;
+
+MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
+MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
+MODULE_LICENSE("GPL");
+
+module_param(fid, int, 0444);
+module_param(min_fsb, int, 0444);
+module_param(max_fsb, int, 0444);
+
+MODULE_PARM_DESC(fid, "CPU multiplier to use (11.5 = 115)");
+MODULE_PARM_DESC(min_fsb,
+                 "Minimum FSB to use, if not defined: current FSB - 50");
+MODULE_PARM_DESC(max_fsb, "Maximum FSB to use, if not defined: current FSB");
+
+/* DEBUG
+ *   Define it if you want verbose debug output, e.g. for bug reporting
+ */
+#define NFORCE2_DEBUG
+
+#ifdef NFORCE2_DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0)
+#endif
+
+/*
+ * nforce2_calc_fsb - calculate FSB
+ * @pll: PLL value
+ * 
+ *   Calculates FSB from PLL value
+ */
+static int nforce2_calc_fsb(int pll)
+{
+	unsigned char mul, div;
+
+	mul = (pll >> 8) & 0xff;
+	div = pll & 0xff;
+
+	if (div > 0)
+		return NFORCE2_XTAL * mul / div;
+
+	return 0;
+}
+
+/*
+ * nforce2_calc_pll - calculate PLL value
+ * @fsb: FSB
+ * 
+ *   Calculate PLL value for given FSB
+ */
+static int nforce2_calc_pll(unsigned int fsb)
+{
+	unsigned char xmul, xdiv;
+	unsigned char mul = 0, div = 0;
+	int tried = 0;
+
+	/* Try to calculate multiplier and divider up to 4 times */
+	while (((mul == 0) || (div == 0)) && (tried <= 3)) {
+		for (xdiv = 1; xdiv <= 0x80; xdiv++)
+			for (xmul = 1; xmul <= 0xfe; xmul++)
+				if (nforce2_calc_fsb(NFORCE2_PLL(xmul, xdiv)) ==
+				    fsb + tried) {
+					mul = xmul;
+					div = xdiv;
+				}
+		tried++;
+	}
+
+	if ((mul == 0) || (div == 0))
+		return -1;
+
+	return NFORCE2_PLL(mul, div);
+}
+
+/*
+ * nforce2_write_pll - write PLL value to chipset
+ * @pll: PLL value
+ * 
+ *   Writes new FSB PLL value to chipset
+ */
+static void nforce2_write_pll(int pll)
+{
+	int temp;
+
+	/* Set the pll addr. to 0x00 */
+	temp = 0x00;
+	pci_write_config_dword(nforce2_chipset_dev, NFORCE2_PLLADR, temp);
+
+	/* Now write the value in all 64 registers */
+	for (temp = 0; temp <= 0x3f; temp++) {
+		pci_write_config_dword(nforce2_chipset_dev, 
+                                       NFORCE2_PLLREG, pll);
+	}
+
+	return;
+}
+
+/*
+ * nforce2_fsb_read - Read FSB
+ *
+ *   Read FSB from chipset
+ */
+static unsigned int nforce2_fsb_read(void)
+{
+	struct pci_dev *nforce2_sub5;
+	u32 fsb, temp = 0;
+
+	/* PLL reg. already set? */
+	pci_read_config_byte(nforce2_chipset_dev, 
+                             NFORCE2_PLLENABLE, (u8 *)&temp);
+
+	if (!temp) {
+		/* Get chipset boot FSB from subdevice 5 */
+		nforce2_sub5 = pci_get_subsys(PCI_VENDOR_ID_NVIDIA,
+                                              0x01EF,
+                                              PCI_ANY_ID,
+                                              PCI_ANY_ID,
+                                              NULL);
+
+		if (!nforce2_sub5)
+			return 0;
+
+		pci_read_config_dword(nforce2_sub5, NFORCE2_BOOTFSB, &fsb);
+		fsb = fsb / 1000000;
+	} else {
+		/* Use PLL reg. value */
+		pci_read_config_dword(nforce2_chipset_dev, 
+                                      NFORCE2_PLLREG, &temp);
+		fsb = nforce2_calc_fsb(temp);
+	}
+
+	return fsb;
+}
+
+/*
+ * nforce2_set_fsb - set new FSB
+ * @fsb: New FSB
+ * 
+ *   Sets new FSB
+ */
+int nforce2_set_fsb(unsigned int fsb)
+{
+	u32 pll, temp = 0;
+	unsigned int tfsb;
+	int diff;
+
+	if ((fsb > NFORCE2_MAX_FSB) || (fsb < NFORCE2_MIN_FSB)) {
+		printk(KERN_ERR "cpufreq: FSB %d is out of range!\n", fsb);
+		return -EINVAL;
+	}
+
+	tfsb = nforce2_fsb_read();
+	if (!tfsb) {
+		printk(KERN_ERR "cpufreq: Error while reading the FSB\n");
+		return -EINVAL;
+	}
+
+	/* First write? Then set actual value */
+	pci_read_config_byte(nforce2_chipset_dev, 
+                             NFORCE2_PLLENABLE, (u8 *)&temp);
+	if (!temp) {
+		pll = nforce2_calc_pll(tfsb);
+
+		if (pll < 0)
+			return -EINVAL;
+
+		nforce2_write_pll(pll);
+	}
+
+	/* Enable write access */
+	temp = 0x01;
+	pci_write_config_byte(nforce2_chipset_dev, NFORCE2_PLLENABLE, (u8)temp);
+
+	diff = tfsb - fsb;
+
+	if (!diff)
+		return 0;
+
+	while ((tfsb != fsb) && (tfsb <= max_fsb) && (tfsb >= min_fsb)) {
+		if (diff < 0)
+			tfsb++;
+		else
+			tfsb--;
+
+		/* Calculate the PLL reg. value */
+		if ((pll = nforce2_calc_pll(tfsb)) == -1)
+			return -EINVAL;
+		
+		nforce2_write_pll(pll);
+#ifdef NFORCE2_DELAY
+		mdelay(NFORCE2_DELAY);
+#endif
+	}
+
+	temp = 0x40;
+	pci_write_config_byte(nforce2_chipset_dev, NFORCE2_PLLADR, (u8)temp);
+
+	return 0;
+}
+
+/**
+ * nforce2_get - get the CPU frequency
+ * @cpu: CPU number
+ * 
+ * Returns the CPU frequency
+ */
+static unsigned int nforce2_get(unsigned int cpu)
+{
+	if (cpu)
+		return 0;
+	return nforce2_fsb_read() * fid * 100;
+}
+
+/**
+ * nforce2_target - set a new CPUFreq policy
+ * @policy: new policy
+ * @target_freq: the target frequency
+ * @relation: how that frequency relates to achieved frequency (CPUFREQ_RELATION_L or CPUFREQ_RELATION_H)
+ *
+ * Sets a new CPUFreq policy.
+ */
+static int nforce2_target(struct cpufreq_policy *policy,
+			  unsigned int target_freq, unsigned int relation)
+{
+//        unsigned long         flags;
+	struct cpufreq_freqs freqs;
+	unsigned int target_fsb;
+
+	if ((target_freq > policy->max) || (target_freq < policy->min))
+		return -EINVAL;
+
+	target_fsb = target_freq / (fid * 100);
+
+	freqs.old = nforce2_get(policy->cpu);
+	freqs.new = target_fsb * fid * 100;
+	freqs.cpu = 0;		/* Only one CPU on nForce2 plattforms */
+
+	if (freqs.old == freqs.new)
+		return 0;
+
+	printk(KERN_INFO "cpufreq: Old CPU frequency %d kHz, new %d kHz\n",
+	       freqs.old, freqs.new);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	/* Disable IRQs */
+	//local_irq_save(flags);
+
+	if (nforce2_set_fsb(target_fsb) < 0)
+		printk(KERN_ERR "cpufreq: Changing FSB to %d failed\n",
+                       target_fsb);
+	else
+		printk(KERN_INFO "cpufreq: Changed FSB successfully to %d\n",
+                       target_fsb);
+
+	/* Enable IRQs */
+	//local_irq_restore(flags);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
+}
+
+/**
+ * nforce2_verify - verifies a new CPUFreq policy
+ * @policy: new policy
+ */
+static int nforce2_verify(struct cpufreq_policy *policy)
+{
+	unsigned int fsb_pol_max;
+
+	fsb_pol_max = policy->max / (fid * 100);
+
+	if (policy->min < (fsb_pol_max * fid * 100))
+		policy->max = (fsb_pol_max + 1) * fid * 100;
+
+	cpufreq_verify_within_limits(policy,
+                                     policy->cpuinfo.min_freq,
+                                     policy->cpuinfo.max_freq);
+	return 0;
+}
+
+static int nforce2_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int fsb;
+	unsigned int rfid;
+
+	/* capability check */
+	if (policy->cpu != 0)
+		return -ENODEV;
+
+	fsb = nforce2_fsb_read();
+
+	if (!fsb)
+		return -EIO;
+
+	/* FIX: Get FID from CPU */
+	if (!fid) {
+		if (!cpu_khz) {
+			printk(KERN_WARNING
+			       "cpufreq: cpu_khz not set, can't calculate multiplier!\n");
+			return -ENODEV;
+		}
+
+		fid = cpu_khz / (fsb * 100);
+		rfid = fid % 5;
+
+		if (rfid) {
+			if (rfid > 2)
+				fid += 5 - rfid;
+			else
+				fid -= rfid;
+		}
+	}
+
+	printk(KERN_INFO "cpufreq: FSB currently at %i MHz, FID %d.%d\n", fsb,
+	       fid / 10, fid % 10);
+
+	if (!max_fsb)
+		max_fsb = fsb;
+	if (!min_fsb)
+		min_fsb = max_fsb - NFORCE2_SAFE_DISTANCE;
+
+	if (max_fsb > NFORCE2_MAX_FSB)
+		max_fsb = NFORCE2_MAX_FSB;
+	if (min_fsb < NFORCE2_MIN_FSB)
+		min_fsb = NFORCE2_MIN_FSB;
+
+	if (max_fsb > fsb)
+		printk(KERN_WARNING
+		       "cpufreq: Warning! Overclocking the FSB from %d to %d can cause unstability and data loss!\n",
+		       fsb, max_fsb);
+
+	/* cpuinfo and default policy values */
+	policy->cpuinfo.min_freq = min_fsb * fid * 100;
+	policy->cpuinfo.max_freq = max_fsb * fid * 100;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cur = nforce2_get(policy->cpu);
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+
+	return 0;
+}
+
+static int nforce2_cpu_exit(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static struct cpufreq_driver nforce2_driver = {
+	.name = "nforce2",
+	.verify = nforce2_verify,
+	.target = nforce2_target,
+	.get = nforce2_get,
+	.init = nforce2_cpu_init,
+	.exit = nforce2_cpu_exit,
+	.owner = THIS_MODULE,
+};
+
+/**
+ * nforce2_detect_chipset - detect the Southbridge which contains FSB PLL logic
+ *
+ * Detects nForce2 A2 and C1 stepping
+ * 
+ */
+static unsigned int nforce2_detect_chipset(void)
+{
+	u8 revision;
+
+	nforce2_chipset_dev = pci_get_subsys(PCI_VENDOR_ID_NVIDIA,
+                                             PCI_DEVICE_ID_NVIDIA_NFORCE2,
+                                             PCI_ANY_ID,
+                                             PCI_ANY_ID,
+                                             NULL);
+
+	if (nforce2_chipset_dev == NULL)
+		return -ENODEV;
+
+	pci_read_config_byte(nforce2_chipset_dev, PCI_REVISION_ID, &revision);
+
+	printk(KERN_INFO "cpufreq: Detected nForce2 chipset revision %X\n",
+	       revision);
+	printk(KERN_INFO
+	       "cpufreq: FSB changing is maybe unstable and can lead to crashes and data loss.\n");
+
+	return 0;
+}
+
+/**
+ * nforce2_init - initializes the nForce2 CPUFreq driver
+ *
+ * Initializes the nForce2 FSB support. Returns -ENODEV on unsupported
+ * devices, -EINVAL on problems during initiatization, and zero on
+ * success.
+ */
+static int __init nforce2_init(void)
+{
+	/* TODO: do we need to detect the processor? */
+
+	/* detect chipset */
+	if (nforce2_detect_chipset()) {
+		printk(KERN_ERR "cpufreq: No nForce2 chipset.\n");
+		return -ENODEV;
+	}
+
+	return cpufreq_register_driver(&nforce2_driver);
+}
+
+/**
+ * nforce2_exit - unregisters cpufreq module
+ *
+ *   Unregisters nForce2 FSB change support.
+ */
+static void __exit nforce2_exit(void)
+{
+	cpufreq_unregister_driver(&nforce2_driver);
+}
+
+module_init(nforce2_init);
+module_exit(nforce2_exit);
+

--------------080708050403080204000205--
