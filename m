Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVIAUUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVIAUUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVIAUUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:20:54 -0400
Received: from bender.bawue.de ([193.7.176.20]:33213 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1030362AbVIAUUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:20:53 -0400
Date: Thu, 1 Sep 2005 22:20:45 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050901202045.GB8728@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some experimental features to amd76x_pm, namely C3, NTH
and POS support.  These features are not enabled by default and are
intended for kernel hackers only.

Signed-off-by: Joerg Sommrey <jo@sommrey.de>

--- linux-2.6.13-jo/drivers/acpi/amd76x_pm.c	2005-09-01 21:50:34.000000000 +0200
+++ linux-2.6.13-jo/drivers/acpi/amd76x_pm.c-extra	2005-09-01 21:53:50.000000000 +0200
@@ -130,12 +130,17 @@
 
 #include <linux/amd76x_pm.h>
 
-#define VERSION	"20050830"
+#define VERSION	"20050830-extra"
 
+// #define AMD76X_NTH 1
+// #define AMD76X_POS 1
+// #define AMD76X_C3 1
 // #define AMD76X_LOG_C1 1
 
 extern void default_idle(void);
+#ifndef AMD76X_NTH
 static void amd76x_smp_idle(void);
+#endif
 static int amd76x_pm_main(void);
 
 static unsigned long lazy_idle = 0;
@@ -143,8 +148,10 @@
 static unsigned long watch_int = 0;
 static unsigned long min_C1 = AMD76X_MIN_C1;
 
+#ifndef AMD76X_NTH
 static int show_watch_irqs(char *, struct kernel_param *);
 static int set_watch_irqs(const char *, struct kernel_param *);
+#endif
 
 module_param(lazy_idle, long, S_IRUGO | S_IWUSR);
 
@@ -155,6 +162,7 @@
 MODULE_PARM_DESC(spin_idle,
 		"\tnumber of spin cycles to wait for other CPUs to become idle");
 
+#ifndef AMD76X_NTH
 module_param(watch_int, long, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(watch_int,
 		"\twatch interval (in milliseconds) for interrupts");
@@ -165,6 +173,7 @@
 		"\tlist of irqs (and optional their limit per second) that "
 		"cause fallback to C1 mode. "
 		"Syntax: irq0[:limit0],irq1[:limit1],...");
+#endif
 
 module_param(min_C1, long, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(min_C1,
@@ -181,6 +190,12 @@
 struct PM_cfg {
 	unsigned int status_reg;
 	unsigned int C2_reg;
+#ifdef AMD76X_C3
+	unsigned int C3_reg;
+#endif
+#ifdef AMD76X_NTH
+	unsigned int NTH_reg;
+#endif
 	unsigned int slp_reg;
 	unsigned int resume_reg;
 	void (*orig_idle) (void);
@@ -189,21 +204,34 @@
 
 static struct PM_cfg amd76x_pm_cfg __cacheline_aligned_in_smp;
 
+#ifndef AMD76X_NTH
 struct idle_stat {
 	atomic_t num_idle;
+#ifdef AMD76X_C3
+	atomic_t num_C2;
+#endif
 };
 
 static struct idle_stat amd76x_stat __cacheline_aligned_in_smp = {
 	.num_idle = ATOMIC_INIT(0),
+#ifdef AMD76X_C3
+	.num_C2 = ATOMIC_INIT(0)
+#endif
 };
 
 struct cpu_stat {
 	int idle_count;
 	int C2_cnt;
+#ifdef AMD76X_C3
+	int C3_cnt;
+	int C2_active;
+#else
 	int _fill[2];
+#endif
 };
 
 static struct cpu_stat prs[NR_CPUS] __cacheline_aligned_in_smp;
+#endif
 
 struct watch_item {
 	int irq;
@@ -287,7 +315,13 @@
 	regdword &= 0xff80;
 	amd76x_pm_cfg.status_reg = (regdword + 0x00);
 	amd76x_pm_cfg.slp_reg =    (regdword + 0x04);
+#ifdef AMD76X_NTH
+	amd76x_pm_cfg.NTH_reg =    (regdword + 0x10);
+#endif
 	amd76x_pm_cfg.C2_reg =     (regdword + 0x14);
+#ifdef AMD76X_C3
+	amd76x_pm_cfg.C3_reg =     (regdword + 0x15);
+#endif
 	amd76x_pm_cfg.resume_reg = (regdword + 0x16); /* N/A for 768 */
 }
 
@@ -332,6 +366,52 @@
 		regdword &= ~((STPCLK_EN | CPUSLP_EN) << C2_REGS);
 	pci_write_config_dword(pdev_sb, 0x50, regdword);
 }
+#ifdef AMD76X_C3
+/*
+ * Untested C3 idle support for AMD-766.
+ */
+static void
+config_amd766_C3(int enable)
+{
+        unsigned int regdword;
+
+        /* Set C3 options in C3A50, page 63 in AMD-766 doc */
+        pci_read_config_dword(pdev_sb, 0x50, &regdword);
+        if(enable) {
+                regdword &= ~((DCSTOP_EN | PCISTP_EN | SUSPND_EN | CPURST_EN)
+                                << C3_REGS);
+                regdword |= (STPCLK_EN  /* ~ 20 Watt savings max */
+                         |  CPUSLP_EN   /* Additional ~ 70 Watts max! */
+                         |  CPUSTP_EN)  /* yet more savings! */
+                         << C3_REGS;
+        }
+        else
+                regdword &= ~((STPCLK_EN | CPUSLP_EN | CPUSTP_EN) << C3_REGS);
+        pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+#endif
+
+
+#ifdef AMD76X_POS
+static void
+config_amd766_POS(int enable)
+{
+	unsigned int regdword;
+
+	/* Set C3 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if(enable) {
+		regdword &= ~((ZZ_CACHE_EN | CPURST_EN) << POS_REGS);
+		regdword |= ((DCSTOP_EN | STPCLK_EN | CPUSTP_EN | PCISTP_EN |
+					CPUSLP_EN | SUSPND_EN) << POS_REGS);
+	}
+	else
+		regdword ^= (0xff << POS_REGS);
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+#endif
+
+
 
 /*
  * Configures the 765 & 766 southbridges.
@@ -342,6 +422,13 @@
 	amd76x_get_PM();
 	config_PMIO_amd76x(1, 1);
 	config_amd766_C2(enable);
+#ifdef AMD76X_C3
+        config_amd766_C3(enable);
+#endif
+
+#ifdef AMD76X_POS
+	config_amd766_POS(enable);
+#endif
 
 	return 0;
 }
@@ -364,6 +451,69 @@
 	pci_write_config_byte(pdev_sb, 0x4F, regbyte);
 }
 
+#ifdef AMD76X_C3
+/*
+ * C3 idle support for AMD-768. The idle loop would need some extra
+ * handling for C3, but it would make more sense for ACPI to handle CX level
+ * transitions like it is supposed to. Unfortunately ACPI doesn't do CX
+ * levels on SMP systems yet.
+ */
+static void
+config_amd768_C3(int enable)
+{
+        unsigned char regbyte;
+
+        /* Set C3 options in DevB:3x4F, page 100 in AMD-768 doc */
+        pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
+        if(enable)
+                regbyte |= (C3EN /* | ZZ_C3EN | CSLP_C3EN | CSTP_C3EN */);
+        else
+                regbyte ^= C3EN;
+        pci_write_config_byte(pdev_sb, 0x4F, regbyte);
+}
+#endif
+
+#ifdef AMD76X_POS
+/*
+ * Untested Power On Suspend support for AMD-768. This should also be handled
+ * by ACPI.
+ */
+static void
+config_amd768_POS(int enable)
+{
+	unsigned int regdword;
+
+	/* Set POS options in DevB:3x50, page 101 in AMD-768 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if(enable) 
+		regdword |= (POSEN | CSTP | PSTP | ASTP | DCSTP | CSLP | SUSP);
+	else
+		regdword ^= POSEN;
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+#endif
+
+
+#ifdef AMD76X_NTH
+/*
+ * Normal Throttling support for AMD-768. There are several settings
+ * that can be set depending on how long you want some of the delays to be.
+ * I'm not sure if this is even neccessary at all as the 766 doesn't need this.
+ */
+static void
+config_amd768_NTH(int enable, int ntper, int thminen)
+{
+	unsigned char regbyte;
+
+	/* DevB:3x40, pg 93 of 768 doc */
+	pci_read_config_byte(pdev_sb, 0x40, &regbyte);
+	/* Is it neccessary to use THMINEN at ANY time? */
+	regbyte |= (NTPER(ntper) | THMINEN(thminen));
+	pci_write_config_byte(pdev_sb, 0x40, regbyte);
+}
+#endif
+
+
 /*
  * Configures the 768 southbridge to support idle calls, and gets
  * the processor idle call register location.
@@ -376,10 +526,64 @@
 	config_PMIO_amd76x(0, 1);
 
 	config_amd768_C2(enable);
+#ifdef AMD76X_C3
+	config_amd768_C3(enable);
+#endif
+#ifdef AMD76X_POS
+	config_amd768_POS(enable);
+#endif
+#ifdef AMD76X_NTH
+	config_amd768_NTH(enable, 1, 2);
+#endif
 
 	return 0;
 }
 
+#ifdef AMD76X_NTH
+/*
+ * Activate normal throttling via its ACPI register (P_CNT).
+ */
+static void
+activate_amd76x_NTH(int enable, int ratio)
+{
+	unsigned int regdword;
+
+	/* PM10, pg 110 of 768 doc, pg 70 of 766 doc */
+	regdword=inl(amd76x_pm_cfg.NTH_reg);
+	if(enable)
+		regdword |= (NTH_EN | NTH_RATIO(ratio));
+	else
+		regdword ^= NTH_EN;
+	outl(regdword, amd76x_pm_cfg.NTH_reg);
+}
+#endif
+
+#ifdef AMD76X_POS
+/*
+ * Activate sleep state via its ACPI register (PM1_CNT).
+ */
+static void
+activate_amd76x_SLP(int type)
+{
+	unsigned short regshort;
+
+	/* PM04, pg 109 of 768 doc, pg 69 of 766 doc */
+	regshort=inw(amd76x_pm_cfg.slp_reg);
+	regshort |= (SLP_EN | SLP_TYP(type)) ;
+	outw(regshort, amd76x_pm_cfg.slp_reg);
+}
+#endif /* AMD76X_POS */
+#ifdef AMD76X_POS
+/*
+ * Wrapper function to activate POS sleep state.
+ */
+static void
+activate_amd76x_POS(void)
+{
+	activate_amd76x_SLP(1);
+}
+#endif
+
 /*
  * Idle loop for single processor systems
  */
@@ -392,6 +596,7 @@
 	amd76x_pm_cfg.orig_idle();
 }
 
+#ifndef AMD76X_NTH
 /*
  * Idle loop for SMP systems
  *
@@ -437,9 +642,30 @@
 		smp_mb();
 		if (unlikely(atomic_read(&amd76x_stat.num_idle) ==
 					num_online)) {
+		#ifdef AMD76X_C3
+			/* Enter C3 if all CPUs are ready for C3.
+			 * Enter C2 otherwise.
+			 */
+			if (unlikely(atomic_read(&amd76x_stat.num_C2) ==
+					num_online)) {
+				/* Invoke C3 */
+				prs[cpu].C3_cnt++;
+				inb(amd76x_pm_cfg.C3_reg);
+			} else {
+				/* Invoke C2 */
+				prs[cpu].C2_cnt++;
+				inb(amd76x_pm_cfg.C2_reg);
+				/* Now we are ready for C3 */
+				if (!prs[cpu].C2_active) {
+					prs[cpu].C2_active = 1;
+					atomic_inc(&amd76x_stat.num_C2);
+				}
+			}
+		#else
 			/* Invoke C2 */
 			prs[cpu].C2_cnt++;
 			inb(amd76x_pm_cfg.C2_reg);
+		#endif
 			smp_mb();
 			atomic_dec(&amd76x_stat.num_idle);
 			prs[cpu].idle_count = 0;
@@ -450,13 +676,24 @@
 
 	smp_mb();
 	atomic_dec(&amd76x_stat.num_idle);
+#ifdef AMD76X_C3
+	/* We haven't been in C2/C3 if we are here. We are no longer
+	 * ready for C3.
+	 */
+	if (prs[cpu].C2_active) {
+		prs[cpu].C2_active = 0;
+		atomic_dec(&amd76x_stat.num_C2);
+	}
+#endif
 	prs[cpu].idle_count = 0;
 	local_irq_enable();
 }
+#endif
 
 /*
  *   sysfs support, RW
  */
+#ifndef AMD76X_NTH
 static int
 show_watch_irqs(char *buf, struct kernel_param *kp)
 {
@@ -530,8 +767,26 @@
 	return sprintf(buf,"%u\n", C2_cnt);  
 }
 
+#ifdef AMD76X_C3
+static ssize_t 
+show_C3_cnt (struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	unsigned int C3_cnt = 0;
+	int i;
+	for_each_online_cpu(i)
+		C3_cnt += prs[i].C3_cnt;
+	return sprintf(buf,"%u\n", C3_cnt);  
+}
+#endif
+
 static DEVICE_ATTR(C2_cnt, S_IRUGO,
 		   show_C2_cnt, NULL);
+#ifdef AMD76X_C3
+static DEVICE_ATTR(C3_cnt, S_IRUGO,
+		   show_C3_cnt, NULL);
+#endif
+#endif
 
 static void
 setup_watch(void)
@@ -589,7 +844,9 @@
 static int
 amd76x_pm_main(void)
 {
+#ifndef AMD76X_NTH
 	int i;
+#endif
 
 	amd76x_pm_cfg.orig_idle = 0;
 	if(lazy_idle == 0)
@@ -642,13 +899,16 @@
 	switch (pdev_nb->device) {
 	case PCI_DEVICE_ID_AMD_FE_GATE_700C:	/* AMD-762 */
 		config_amd762(1);
+#ifndef AMD76X_NTH
 		amd76x_pm_cfg.curr_idle = amd76x_smp_idle;
+#endif
 		break;
 	default:
 		printk(KERN_ERR "amd76x_pm: No northbridge to initialize\n");
 		break;
 	}
 
+#ifndef AMD76X_NTH
 	if(num_online_cpus() == 1) {
 		amd76x_pm_cfg.curr_idle = amd76x_up_idle;
 		printk(KERN_ERR "amd76x_pm: UP machine detected. ACPI is your friend.\n");
@@ -661,6 +921,10 @@
 	for (i = 0; i < NR_CPUS; i++) {
 		prs[i].idle_count = 0;
 		prs[i].C2_cnt = 0;
+	#ifdef AMD76X_C3
+		prs[i].C3_cnt = 0;
+		prs[i].C2_active = 0;
+	#endif
 	}
 
 	amd76x_pm_cfg.orig_idle = pm_idle;
@@ -670,7 +934,20 @@
 	
 	/* sysfs */
 	device_create_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+#ifdef AMD76X_C3
+	device_create_file(&pdev_nb->dev, &dev_attr_C3_cnt);
+#endif
+#endif
 
+#ifdef AMD76X_NTH
+	/* Turn NTH on with maxium throttling for testing. */
+	activate_amd76x_NTH(1, 1);
+#endif
+
+#ifdef AMD76X_POS
+	/* Testing here only. */
+	activate_amd76x_POS();
+#endif
 	setup_watch();
 
 	return 0;
@@ -688,9 +965,15 @@
 static void __exit
 amd76x_pm_cleanup(void)
 {
+#ifndef AMD76X_NTH
 	int i;
 	unsigned int C2_cnt = 0;
+#ifdef AMD76X_C3
+	unsigned int C3_cnt = 0;
+#endif
+#endif
 	
+#ifndef AMD76X_NTH
 	pm_idle = amd76x_pm_cfg.orig_idle;
 
 	cpu_idle_wait();
@@ -699,11 +982,28 @@
 	/* This isn't really needed. */
 	for_each_online_cpu(i) {
 		C2_cnt += prs[i].C2_cnt;
+#ifdef AMD76X_C3
+		C3_cnt += prs[i].C3_cnt;
+#endif
 	}
+#ifdef AMD76X_C3
+	printk(KERN_INFO "amd76x_pm: %u C2 calls, %u C3 calls\n",
+			C2_cnt, C3_cnt);
+#else
 	printk(KERN_INFO "amd76x_pm: %u C2 calls\n", C2_cnt);
+#endif
 	
 	/* remove sysfs */
 	device_remove_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+#ifdef AMD76X_C3
+	device_remove_file(&pdev_nb->dev, &dev_attr_C3_cnt);
+#endif
+#endif
+
+#ifdef AMD76X_NTH
+	/* Turn NTH off*/
+	activate_amd76x_NTH(0, 0);
+#endif
 
 	irqwatch.schedule = 0;
         flush_scheduled_work();
