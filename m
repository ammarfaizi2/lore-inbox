Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTKDAXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTKDAXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:23:14 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:6918
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263553AbTKDAWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:22:44 -0500
Date: Mon, 3 Nov 2003 16:22:44 -0800
To: linux-kernel@vger.kernel.org
Cc: psavo@iki.fi
Subject: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104002243.GC1281@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After a year of not having access to my dual athlon box I finally ran
apt-get dist-upgrade on it :)

I also did some cleanup on the amd76x_pm to make the amd76x_pm to load as 
module, and to remove some unnecessary PCI code.

I used Pasi Savolainen's version amd76x_pm-2.6.0-test4.patch as the 
base for the driver.

I'm planning todo some more cleanup on the driver. Pasi do you have some
changes in mind also so we can coordinate?

The patch is also available at:

http://www.muru.com/linux/amd-smp-idle/

Regards,

Tony


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="linux-2.6.0-test9-amd76x_pm-031027.patch"

diff -urN -X /home/tmlind/dontdiff linux-2.6.0-test9-vanilla/drivers/acpi/amd76x_pm.c linux-2.6.0-test9/drivers/acpi/amd76x_pm.c
--- linux-2.6.0-test9-vanilla/drivers/acpi/amd76x_pm.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test9/drivers/acpi/amd76x_pm.c	2003-11-03 15:39:59.000000000 -0800
@@ -0,0 +1,706 @@
+/*
+ * ACPI style PM for SMP AMD-760MP(X) based systems.
+ * For use until the ACPI project catches up. :-)
+ *
+ * Copyright (C) 2002 Johnathan Hicks <thetech@folkwolf.net>
+ *
+ * History:
+ * 
+ *   20020702 - amd-smp-idle: Tony Lindgren <tony@atomide.com>
+ *	Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+ *	use the PCI features in Linux, and to support SMP systems. Provides
+ *	C2 idling on SMP AMD-760MP systems.
+ *	
+ *   20020722: JH
+ *   	I adapted Tony's code for the AMD-765/766 southbridge and adapted it
+ *   	according to the AMD-768 data sheet to provide the same capability for
+ *   	SMP AMD-760MPX systems. Posted to acpi-devel list.
+ *   	
+ *   20020722: Alan Cox
+ *   	Replaces non-functional amd76x_pm code in -ac tree.
+ *   	
+ *   20020730: JH
+ *   	Added ability to do normal throttling (the non-thermal kind), C3 idling
+ *   	and Power On Suspend (S1 sleep). It would be very easy to tie swsusp
+ *   	into activate_amd76x_SLP(). C3 idling doesn't happen yet; see my note
+ *   	in amd76x_smp_idle(). I've noticed that when NTH and idling are both
+ *   	enabled, my hardware locks and requires a hard reset, so I have
+ *   	#ifndefed around the idle loop setting to prevent this. POS locks it up
+ *   	too, both ought to be fixable. I've also noticed that idling and NTH
+ *   	make some interference that is picked up by the onboard sound chip on
+ *   	my ASUS A7M266-D motherboard.
+ *
+ *   20030601: Pasi Savolainen
+ *      Simple port to 2.5
+ *      Added sysfs interface for making nice graphs with mrtg.
+ *      Look for /sys/devices/pci0/00:00.0/C2_cnt & lazy_idle (latter writable)
+ *
+ *   20031027: Tony Lindgren
+ *      Fixed the loading as module and removed some unnecessary PCI code
+ *
+ * TODO: Thermal throttling (TTH).
+ * 	 /proc interface for normal throttling level.
+ * 	 /proc interface for POS.
+ *
+ *
+ *    <Notes from 20020722-ac revision>
+ *
+ * Processor idle mode module for AMD SMP 760MP(X) based systems
+ *
+ * Copyright (C) 2002 Tony Lindgren <tony@atomide.com>
+ *                    Johnathan Hicks (768 support)
+ *
+ * Using this module saves about 70 - 90W of energy in the idle mode compared
+ * to the default idle mode. Waking up from the idle mode is fast to keep the
+ * system response time good. Currently no CPU load calculation is done, the
+ * system exits the idle mode if the idle function runs twice on the same
+ * processor in a row. This only works on SMP systems, but maybe the idle mode
+ * enabling can be integrated to ACPI to provide C2 mode at some point.
+ *
+ * NOTE: Currently there's a bug somewhere where the reading the
+ *       P_LVL2 for the first time causes the system to sleep instead of 
+ *       idling. This means that you need to hit the power button once to
+ *       wake the system after loading the module for the first time after
+ *       reboot. After that the system idles as supposed.
+ *
+ *
+ * Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+ * use the PCI features in Linux, and to support SMP systems.
+ * 
+ * Currently only tested on a TYAN S2460 (760MP) system (Tony) and an
+ * ASUS A7M266-D (760MPX) system (Johnathan). Adding support for other Athlon
+ * SMP or single processor systems should be easy if desired.
+ *
+ * This software is licensed under GNU General Public License Version 2 
+ * as specified in file COPYING in the Linux kernel source tree main 
+ * directory.
+ * 
+ *   </Notes from 20020722-ac revision>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/in.h>
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/init.h>
+
+#include <linux/amd76x_pm.h>
+
+#define VERSION	"20031027"
+
+// #define AMD76X_C3  1
+// #define AMD76X_NTH 1
+// #define AMD76X_POS 1
+
+extern void default_idle(void);
+static void amd76x_smp_idle(void);
+static int amd76x_pm_main(void);
+
+unsigned long lazy_idle = 0;
+MODULE_PARM(lazy_idle, "l");
+
+static struct pci_dev *pdev_nb;
+static struct pci_dev *pdev_sb;
+
+struct PM_cfg {
+	unsigned int status_reg;
+	unsigned int C2_reg;
+	unsigned int C3_reg;
+	unsigned int NTH_reg;
+	unsigned int slp_reg;
+	unsigned int resume_reg;
+	void (*orig_idle) (void);
+	void (*curr_idle) (void);
+	unsigned long C2_cnt, C3_cnt, idle_cnt;
+	int last_pr;
+};
+
+static struct PM_cfg amd76x_pm_cfg;
+
+struct cpu_idle_state {
+	int idle;
+	int count;
+};
+static struct cpu_idle_state prs[2];
+
+static struct pci_device_id  __devinitdata amd_nb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_700C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+static struct pci_device_id  __devinitdata amd_sb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{0,}
+};
+
+static struct pci_driver amd_nb_driver = {
+	.name     = "amd76x_pm-nb",
+	.id_table = amd_nb_tbl,
+#ifdef CONFIG_PM
+	.suspend  = NULL,
+	.resume   = NULL,
+#endif
+};
+
+/*
+ * Configures the AMD-762 northbridge to support PM calls
+ */
+static int
+config_amd762(int enable)
+{
+	unsigned int regdword;
+
+	/* Enable STPGNT in BIU Status/Control for cpu0 */
+	pci_read_config_dword(pdev_nb, 0x60, &regdword);
+	regdword |= (1 << 17);
+	pci_write_config_dword(pdev_nb, 0x60, regdword);
+
+	/* Enable STPGNT in BIU Status/Control for cpu1 */
+	pci_read_config_dword(pdev_nb, 0x68, &regdword);
+	regdword |= (1 << 17);
+	pci_write_config_dword(pdev_nb, 0x68, regdword);
+
+	/* DRAM refresh enable */
+	pci_read_config_dword(pdev_nb, 0x58, &regdword);
+	regdword &= ~(1 << 19);
+	pci_write_config_dword(pdev_nb, 0x58, regdword);
+
+	/* Self refresh enable */
+	pci_read_config_dword(pdev_nb, 0x70, &regdword);
+	regdword |= (1 << 18);
+	pci_write_config_dword(pdev_nb, 0x70, regdword);
+
+	return 0;
+}
+
+
+/*
+ * Get the base PMIO address and set the pm registers in amd76x_pm_cfg.
+ */
+static void
+amd76x_get_PM(void)
+{
+	unsigned int regdword;
+
+	/* Get the address for pm status, P_LVL2, etc */
+	pci_read_config_dword(pdev_sb, 0x58, &regdword);
+	regdword &= 0xff80;
+	amd76x_pm_cfg.status_reg = (regdword + 0x00);
+	amd76x_pm_cfg.slp_reg =    (regdword + 0x04);
+	amd76x_pm_cfg.NTH_reg =    (regdword + 0x10);
+	amd76x_pm_cfg.C2_reg =     (regdword + 0x14);
+	amd76x_pm_cfg.C3_reg =     (regdword + 0x15);
+	amd76x_pm_cfg.resume_reg = (regdword + 0x16); /* N/A for 768 */
+}
+
+
+/*
+ * En/Disable PMIO and configure W4SG & STPGNT.
+ */
+static int
+config_PMIO_amd76x(int is_766, int enable)
+{
+	unsigned char regbyte;
+
+	/* Clear W4SG, and set PMIOEN, if using a 765/766 set STPGNT as well.
+	 * AMD-766: C3A41; page 59 in AMD-766 doc
+	 * AMD-768: DevB:3x41C; page 94 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x41, &regbyte);
+	if(enable) {
+		regbyte |= ((is_766 << 1) | (1 << 7));
+	}
+	pci_write_config_byte(pdev_sb, 0x41, regbyte);
+	return 0;
+}
+
+/*
+ * C2 idle support for AMD-766.
+ */
+static void
+config_amd766_C2(int enable)
+{
+	unsigned int regdword;
+
+	/* Set C2 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if(enable) {
+		regdword &= ~((DCSTOP_EN | CPUSTP_EN | PCISTP_EN | SUSPND_EN |
+					CPURST_EN) << C2_REGS);
+		regdword |= (STPCLK_EN	/* ~ 20 Watt savings max */
+			 |  CPUSLP_EN)	/* Additional ~ 70 Watts max! */
+			 << C2_REGS;
+	}
+	else
+		regdword &= ~((STPCLK_EN | CPUSLP_EN) << C2_REGS);
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+
+
+#ifdef AMD76X_C3
+/*
+ * Untested C3 idle support for AMD-766.
+ */
+static void
+config_amd766_C3(int enable)
+{
+	unsigned int regdword;pci_module_init
+
+	/* Set C3 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if(enable) {
+		regdword &= ~((DCSTOP_EN | PCISTP_EN | SUSPND_EN | CPURST_EN)
+				<< C3_REGS);
+		regdword |= (STPCLK_EN	/* ~ 20 Watt savings max */
+			 |  CPUSLP_EN	/* Additional ~ 70 Watts max! */
+			 |  CPUSTP_EN)	/* yet more savings! */
+			 << C3_REGS;
+	}
+	else
+		regdword &= ~((STPCLK_EN | CPUSLP_EN | CPUSTP_EN) << C3_REGS);
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
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
+/*
+ * Configures the 765 & 766 southbridges.
+ */
+static int
+config_amd766(int enable)
+{
+	amd76x_get_PM();
+	config_PMIO_amd76x(1, 1);
+
+	config_amd766_C2(enable);
+#ifdef AMD76X_C3
+	config_amd766_C3(enable);
+#endif
+#ifdef AMD76X_POS
+	config_amd766_POS(enable);
+#endif
+
+	return 0;
+}
+
+
+/*
+ * C2 idling support for AMD-768.
+ */
+static void
+config_amd768_C2(int enable)
+{
+	unsigned char regbyte;
+
+	/* Set C2 options in DevB:3x4F, page 100 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
+	if(enable)
+		regbyte |= C2EN;
+	else
+		regbyte ^= C2EN;
+	pci_write_config_byte(pdev_sb, 0x4F, regbyte);
+}
+
+
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
+	unsigned char regbyte;
+
+	/* Set C3 options in DevB:3x4F, page 100 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
+	if(enable)
+		regbyte |= (C3EN /* | ZZ_C3EN | CSLP_C3EN | CSTP_C3EN */);
+	else
+		regbyte ^= C3EN;
+	pci_write_config_byte(pdev_sb, 0x4F, regbyte);
+}
+#endif
+
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
+/*
+ * Configures the 768 southbridge to support idle calls, and gets
+ * the processor idle call register location.
+ */
+static int
+config_amd768(int enable)
+{
+	amd76x_get_PM();
+
+	config_PMIO_amd76x(0, 1);
+
+	config_amd768_C2(enable);
+#ifdef AMD76X_C3
+	config_amd768_C3(enable);
+#endif
+#ifdef AMD76X_POS
+	config_amd768_POS(enable);
+#endif
+#ifdef AMD76X_NTH
+	config_amd768_NTH(enable, 1, 2);
+#endif
+
+	return 0;
+}
+
+
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
+#ifdef AMD76X_SLP
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
+#endif /* AMD76X_SLP */
+
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
+
+/*
+ * Idle loop for single processor systems
+ */
+void
+amd76x_up_idle(void)
+{
+	/* ACPI knows how to do C2 on SMP when cpu_count < 2
+	 * we really shouldn't end up here anyway. 
+	 */
+	amd76x_pm_cfg.orig_idle();
+}
+
+
+/*
+ * Idle loop for SMP systems, supports currently only 2 processors.
+ *
+ * Note; for 2.5 folks - not pre-empt safe
+ */
+static void
+amd76x_smp_idle(void)
+{
+	/*
+	 * Exit idle mode immediately if the CPU does not change.
+	 * Usually that means that we have some load on another CPU.
+	 */
+	amd76x_pm_cfg.idle_cnt++;
+	if (prs[0].idle && prs[1].idle && amd76x_pm_cfg.last_pr == smp_processor_id()) {
+		prs[0].idle = 0;
+		prs[1].idle = 0;
+		return;
+	}
+
+	prs[smp_processor_id()].count++;
+
+	/* Don't start the idle mode immediately */
+	if (prs[smp_processor_id()].count >= lazy_idle) {
+
+		/* Put the current processor into idle mode */
+		prs[smp_processor_id()].idle =
+			(prs[smp_processor_id()].idle ? 2 : 1);
+
+		/* Only idle if both processors are idle */
+		if ((prs[0].idle==1) && (prs[1].idle==1)) {
+			amd76x_pm_cfg.C2_cnt++;
+			inb(amd76x_pm_cfg.C2_reg);
+		}
+ #ifdef AMD76X_C3
+		/*
+		 * JH: I've not been able to get into here. Could this have
+		 * something to do with the way the kernel handles the idle
+		 * loop, or and error that I've made?
+		 */
+		else if ((prs[0].idle==2) && (prs[1].idle==2)) {
+			amd76x_pm_cfg.C3_cnt++;
+			inb(amd76x_pm_cfg.C3_reg);
+		}
+ #endif
+
+		prs[smp_processor_id()].count = 0;
+
+	}
+	amd76x_pm_cfg.last_pr = smp_processor_id();
+}
+
+/*
+ *   sysfs support, RW
+ */
+static ssize_t 
+show_lazy_idle (struct device *dev, char *buf)
+{
+    return sprintf(buf,"%lu\n", lazy_idle);  
+}
+
+static ssize_t         
+set_lazy_idle (struct device *dev, const char *buf, size_t count)
+{
+    lazy_idle = simple_strtoul(buf, NULL, 10);
+    return count;
+}
+
+static ssize_t 
+show_C2_cnt (struct device *dev, char *buf)
+{
+    return sprintf(buf,"%lu\n", amd76x_pm_cfg.C2_cnt);  
+}
+
+static ssize_t 
+show_idle_cnt (struct device *dev, char *buf)
+{
+    return sprintf(buf,"%lu\n", amd76x_pm_cfg.idle_cnt);  
+}
+
+static DEVICE_ATTR(lazy_idle, S_IRUGO | S_IWUSR,
+		   show_lazy_idle, set_lazy_idle);
+static DEVICE_ATTR(C2_cnt, S_IRUGO,
+		   show_C2_cnt, NULL);
+static DEVICE_ATTR(idle_cnt, S_IRUGO,
+		   show_idle_cnt, NULL);
+
+/*
+ * Finds and initializes the bridges, and then sets the idle function
+ */
+static int
+amd76x_pm_main(void)
+{
+	int found;
+	amd76x_pm_cfg.orig_idle = 0;
+	if(lazy_idle == 0)
+	    lazy_idle = LAZY_IDLE_DELAY;
+
+	/* Find southbridge */
+	pdev_sb = NULL;
+	while ((pdev_sb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb)) != NULL) {
+		if (pci_match_device(amd_sb_tbl, pdev_sb) != NULL)
+			goto found_sb;
+	}
+	printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+	return -ENODEV;
+
+ found_sb:
+
+	/* Find northbridge */
+	while ((pdev_nb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_nb)) != NULL) {
+		if (pci_match_device(amd_nb_tbl, pdev_nb) != NULL)
+			goto found_nb;
+	}
+	printk(KERN_ERR "amd76x_pm: Could not find northbridge\n");
+	return -ENODEV;
+
+ found_nb:
+	found = pci_module_init(&amd_nb_driver);
+	if (found < 0) {
+		printk(KERN_ERR "amd76x_pm: Could not initialize northbridge\n");
+		return -ENODEV;
+	}
+
+	/* Init southbridge */
+	switch (pdev_sb->device) {
+	case PCI_DEVICE_ID_AMD_VIPER_7413:	/* AMD-765 or 766 */
+		config_amd766(1);
+		break;
+	case PCI_DEVICE_ID_AMD_VIPER_7443:	/* AMD-768 */
+		config_amd768(1);
+		break;
+	default:
+		printk(KERN_ERR "amd76x_pm: No southbridge to initialize\n");
+		break;
+	}
+
+	/* Init northbridge and queue the new idle function */
+	if(!pdev_nb) {
+		printk("amd76x_pm: No Northbridge found\n");
+		pci_unregister_driver(&amd_nb_driver);
+		return -ENODEV;
+	}
+	switch (pdev_nb->device) {
+	case PCI_DEVICE_ID_AMD_FE_GATE_700C:	/* AMD-762 */
+		config_amd762(1);
+#ifndef AMD76X_NTH
+		amd76x_pm_cfg.curr_idle = amd76x_smp_idle;
+#endif
+		break;
+	default:
+		printk(KERN_ERR "amd76x_pm: No northbridge to initialize\n");
+		break;
+	}
+
+#ifndef AMD76X_NTH
+	if(num_online_cpus() == 1) {
+		amd76x_pm_cfg.curr_idle = amd76x_up_idle;
+		printk(KERN_ERR "amd76x_pm: UP machine detected. ACPI is your friend.\n");
+	}
+	if (!amd76x_pm_cfg.curr_idle) {
+		printk(KERN_ERR "amd76x_pm: Idle function not changed\n");
+		return 1;
+	}
+
+	amd76x_pm_cfg.orig_idle = pm_idle;
+	pm_idle = amd76x_pm_cfg.curr_idle;
+	wmb();
+	
+	/* sysfs */
+	device_create_file(&pdev_nb->dev, &dev_attr_lazy_idle);
+	device_create_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+	device_create_file(&pdev_nb->dev, &dev_attr_idle_cnt);
+#endif
+
+#ifdef AMD76X_NTH
+	/* Turn NTH on with maxium throttling for testing. */
+	activate_amd76x_NTH(1, 1);
+#endif
+
+#ifdef AMD76X_POS
+	/* Testing here only. */
+	activate_amd76x_POS();
+#endif
+	return 0;
+}
+
+
+static int __init
+amd76x_pm_init(void)
+{
+	printk(KERN_INFO "amd76x_pm: Version %s\n", VERSION);
+	return amd76x_pm_main();
+}
+
+
+static void __exit
+amd76x_pm_cleanup(void)
+{
+#ifndef AMD76X_NTH
+	pm_idle = amd76x_pm_cfg.orig_idle;
+
+	synchronize_kernel();
+
+	/* This isn't really needed. */
+	printk(KERN_INFO "amd76x_pm: %lu C2 calls\n", amd76x_pm_cfg.C2_cnt);
+
+#ifdef AMD76X_C3
+	printk(KERN_INFO "amd76x_pm: %lu C3 calls\n", amd76x_pm_cfg.C3_cnt);
+#endif
+	/* remove sysfs */
+	device_remove_file(&pdev_nb->dev, &dev_attr_lazy_idle);
+	device_remove_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+	device_remove_file(&pdev_nb->dev, &dev_attr_idle_cnt);
+
+#endif
+
+#ifdef AMD76X_NTH
+	/* Turn NTH off*/
+	activate_amd76x_NTH(0, 0);
+#endif
+
+	pci_unregister_driver(&amd_nb_driver);
+}
+
+
+MODULE_LICENSE("GPL");
+module_init(amd76x_pm_init);
+module_exit(amd76x_pm_cleanup);
Binary files linux-2.6.0-test9-vanilla/drivers/acpi/amd76x_pm.ko and linux-2.6.0-test9/drivers/acpi/amd76x_pm.ko differ
diff -urN -X /home/tmlind/dontdiff linux-2.6.0-test9-vanilla/drivers/acpi/Kconfig linux-2.6.0-test9/drivers/acpi/Kconfig
--- linux-2.6.0-test9-vanilla/drivers/acpi/Kconfig	2003-10-25 11:44:56.000000000 -0700
+++ linux-2.6.0-test9/drivers/acpi/Kconfig	2003-10-27 08:03:44.000000000 -0800
@@ -269,5 +269,21 @@
 	  particular, many Toshiba laptops require this for correct operation
 	  of the AC module.
 
-endmenu
+config AMD76X_PM
+        tristate "AMD76x Native Power Management support"
+	default n
+        depends on X86 && PCI
+        ---help---
+          This driver enables Power Management on AMD760MP & AMD760MPX chipsets.
+	  This is about same as ACPI C2, except that ACPI folks don't do SMP ATM.
+	  In /sys/devices/pci0/0000:00:00.0/ is a statistics C2_cnt
+	  (RO) and lazy_idle (RW) file.
+
+	  To compile this driver as a module ( = code which can be inserted in
+	  and removed from the running kernel whenever you want), say M here
+	  and read <file:Documentation/modules.txt>. The module will be called
+	  amd76x_pm.
 
+	  If unsure, say N.
+
+endmenu
diff -urN -X /home/tmlind/dontdiff linux-2.6.0-test9-vanilla/drivers/acpi/Makefile linux-2.6.0-test9/drivers/acpi/Makefile
--- linux-2.6.0-test9-vanilla/drivers/acpi/Makefile	2003-10-25 11:44:47.000000000 -0700
+++ linux-2.6.0-test9/drivers/acpi/Makefile	2003-10-27 08:03:44.000000000 -0800
@@ -48,3 +48,8 @@
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o 
+
+#
+# not really ACPI thing, until they handle SMP.
+#
+obj-$(CONFIG_AMD76X_PM)		+= amd76x_pm.o
diff -urN -X /home/tmlind/dontdiff linux-2.6.0-test9-vanilla/include/linux/amd76x_pm.h linux-2.6.0-test9/include/linux/amd76x_pm.h
--- linux-2.6.0-test9-vanilla/include/linux/amd76x_pm.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test9/include/linux/amd76x_pm.h	2003-10-27 08:03:44.000000000 -0800
@@ -0,0 +1,59 @@
+/* 
+ * Begin 765/766
+ */
+/* C2/C3/POS options in C3A50, page 63 in AMD-766 doc */
+#define ZZ_CACHE_EN	1
+#define DCSTOP_EN	(1 << 1)
+#define STPCLK_EN	(1 << 2)
+#define CPUSTP_EN	(1 << 3)
+#define PCISTP_EN	(1 << 4)
+#define CPUSLP_EN	(1 << 5)
+#define SUSPND_EN	(1 << 6)
+#define CPURST_EN	(1 << 7)
+
+#define C2_REGS		0
+#define C3_REGS		8
+#define POS_REGS	16	
+/*
+ * End 765/766
+ */
+
+
+/*
+ * Begin 768
+ */
+/* C2/C3 options in DevB:3x4F, page 100 in AMD-768 doc */
+#define C2EN		1
+#define C3EN		(1 << 1)
+#define ZZ_C3EN		(1 << 2)
+#define CSLP_C3EN	(1 << 3)
+#define CSTP_C3EN	(1 << 4)
+
+/* POS options in DevB:3x50, page 101 in AMD-768 doc */
+#define POSEN	1
+#define CSTP	(1 << 2)
+#define PSTP	(1 << 3)
+#define ASTP	(1 << 4)
+#define DCSTP	(1 << 5)
+#define CSLP	(1 << 6)
+#define SUSP	(1 << 8)
+#define MSRSM	(1 << 14)
+#define PITRSM	(1 << 15)
+
+/* NTH options DevB:3x40, pg 93 of 768 doc */
+#define NTPER(x) (x << 3)
+#define THMINEN(x) (x << 4)
+
+/*
+ * End 768
+ */
+
+/* NTH activate. PM10, pg 110 of 768 doc, pg 70 of 766 doc */
+#define NTH_RATIO(x) (x << 1)
+#define NTH_EN (1 << 4)
+
+/* Sleep state. PM04, pg 109 of 768 doc, pg 69 of 766 doc */
+#define SLP_EN (1 << 13)
+#define SLP_TYP(x) (x << 10)
+
+#define LAZY_IDLE_DELAY	800	/* 0: Best savings,  3000: More responsive */

--G4iJoqBmSsgzjUCe--
