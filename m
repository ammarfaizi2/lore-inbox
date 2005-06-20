Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFTVKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFTVKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVFTVGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:06:45 -0400
Received: from bender.bawue.de ([193.7.176.20]:57572 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261488AbVFTUxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:53:44 -0400
Date: Mon, 20 Jun 2005 22:53:34 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Juergen Brunk <Juergen.Brunk@eurolog.com>, johan.heikkila@netikka.fi,
       Tarmo Jarvalt <tarmo.jarvalt@mail.ee>, Tony Lindgren <tony@atomide.com>,
       Johnathan Hicks <thetech@folkwolf.net>
Subject: [PATCH 2.6.12] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050620205334.GA28230@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Juergen Brunk <Juergen.Brunk@eurolog.com>, johan.heikkila@netikka.fi,
	Tarmo Jarvalt <tarmo.jarvalt@mail.ee>,
	Tony Lindgren <tony@atomide.com>,
	Johnathan Hicks <thetech@folkwolf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a processor idle module for AMD SMP 760MP(X) based systems.
The patch was originally written by Tony Lindgren and has been around
since 2002.  It enables C2 mode on AMD SMP systems and thus saves
about 70 - 90 W of energy in the idle mode compared to the default idle
mode.  The idle function has been rewritten and now should be free of
locking issues and is independent from the number of CPUs.  The impact
from this module on the system clock has been reduced. 

This patch can also be found at
http://www.sommrey.de/amd76x_pm/amd_76x_pm-2.6.12-jo1.patch

Signed-off-by: Joerg Sommrey <jo@sommrey.de>

diff -Nru linux-2.6.12/Documentation/amd76x_pm.txt linux-2.6.12-jo1/Documentation/amd76x_pm.txt
--- linux-2.6.12/Documentation/amd76x_pm.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-jo1/Documentation/amd76x_pm.txt	2005-06-18 12:06:24.000000000 +0200
@@ -0,0 +1,97 @@
+	ACPI style power management for SMP AMD-760MP(X) based systems
+	==============================================================
+
+For use until the ACPI project catches up. :-)
+
+Using this module saves about 70 - 90W of energy in the idle mode compared
+to the default idle mode. Waking up from the idle mode is fast to keep the
+system response time good. Currently no CPU load calculation is done, the
+system exits the idle mode if there is a CPU that isn't idle.
+
+NOTE: Currently there's a bug somewhere where the reading the
+      P_LVL2 for the first time causes the system to sleep instead of 
+      idling. This means that you need to hit the power button once to
+      wake the system after loading the module for the first time after
+      reboot. After that the system idles as supposed.
+      (Only observed on Tony's system.)
+
+
+Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+use the PCI features in Linux, and to support SMP systems.
+
+Currently tested amongst others on a TYAN S2460 (760MP) system (Tony), an
+ASUS A7M266-D (760MPX) system (Johnathan) and a TYAN S2466 (760MPX)
+system (Jo). Adding support for other Athlon SMP or single processor
+systems should be easy if desired.  
+
+You'll find some files in /sys/devices/pci0000:00/0000:00:00.0/
+lazy_idle (rw)	see below
+C2_cnt    (ro)	the number of C2 calls
+
+There is a tunable lazy_idle parameter that defines the number of idle
+calls before C2 mode is entered.  Higher values give better system
+response and lower values give better cooling.  This value has an
+influence on the system clock stability too: If the system clock is
+synchronized via ntpd you may watch lower values for the frequency if
+the module is loaded.  If this happens then the system clock speed
+depends on the system load: higher load, less idle calls, higher
+frequency.  Play around with this parameter and try to find a value that
+gives acceptable cooling and clock stability.  This parameter can be set
+as a module parameter to amd76x_pm or via the writable sysfs file
+lazy_idle (see above).  Feel free to play around with this parameter to
+find out which fits best for you.  The default value of 512 might be not
+suitable for your needs but is a good starting point.  
+
+This software is licensed under GNU General Public License Version 2 
+as specified in file COPYING in the Linux kernel source tree main 
+directory.
+
+Copyright (C) 2002 - 2005	Johnathan Hicks <thetech@folkwolf.net>
+				Tony Lindgren <tony@atomide.com>
+				Joerg Sommrey <jo@sommrey.de>
+
+History:
+
+  20020702 - amd-smp-idle: Tony Lindgren <tony@atomide.com>
+Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+use the PCI features in Linux, and to support SMP systems. Provides
+C2 idling on SMP AMD-760MP systems.
+
+  20020722: JH
+  	I adapted Tony's code for the AMD-765/766 southbridge and adapted it
+  	according to the AMD-768 data sheet to provide the same capability for
+  	SMP AMD-760MPX systems. Posted to acpi-devel list.
+  	
+  20020722: Alan Cox
+  	Replaces non-functional amd76x_pm code in -ac tree.
+  	
+  20020730: JH
+  	Added ability to do normal throttling (the non-thermal kind), C3 idling
+  	and Power On Suspend (S1 sleep). It would be very easy to tie swsusp
+  	into activate_amd76x_SLP(). C3 idling doesn't happen yet; see my note
+  	in amd76x_smp_idle(). I've noticed that when NTH and idling are both
+  	enabled, my hardware locks and requires a hard reset, so I have
+  	#ifndefed around the idle loop setting to prevent this. POS locks it up
+  	too, both ought to be fixable. I've also noticed that idling and NTH
+  	make some interference that is picked up by the onboard sound chip on
+  	my ASUS A7M266-D motherboard.
+
+  20030601: Pasi Savolainen
+     Simple port to 2.5
+     Added sysfs interface for making nice graphs with mrtg.
+     Look for /sys/devices/pci0/00:00.0/C2_cnt & lazy_idle (latter writable)
+
+  20050601: Joerg Sommrey (jo)
+     2.6 stuff
+     redesigned amd76x_smp_idle.  The algorithm is basically the same
+        but the implementation has changed.  This part is now independent
+        from the number of CPUs and data is locked against concurrent
+        updates from different CPUs.
+     use _smp_processor_id()
+     use cpu_idle_wait()
+     NTH and POS code not touched and not tested.
+
+TODO: Thermal throttling (TTH).
+	 /proc interface for normal throttling level.
+	 /proc interface for POS.
+
diff -Nru linux-2.6.12/drivers/acpi/Kconfig linux-2.6.12-jo1/drivers/acpi/Kconfig
--- linux-2.6.12/drivers/acpi/Kconfig	2005-06-18 11:47:38.000000000 +0200
+++ linux-2.6.12-jo1/drivers/acpi/Kconfig	2005-06-18 12:08:40.000000000 +0200
@@ -352,4 +352,18 @@
 		$>modprobe acpi_memhotplug 
 endif	# ACPI
 
+config AMD76X_PM
+        tristate "AMD76x Native Power Management support"
+        default n
+        depends on X86 && PCI
+        ---help---
+          This driver enables Power Management on AMD760MP & AMD760MPX chipsets.          This is about same as ACPI C2, except that ACPI folks don't do SMP ATM.
+          See Documentation/amd76x_pm.txt for further details.
+
+          To compile this driver as a module ( = code which can be inserted in
+          and removed from the running kernel whenever you want), say M
+          here.  The module will be called amd76x_pm.
+
+          If unsure, say N.
+
 endmenu
diff -Nru linux-2.6.12/drivers/acpi/Makefile linux-2.6.12-jo1/drivers/acpi/Makefile
--- linux-2.6.12/drivers/acpi/Makefile	2005-06-18 11:47:38.000000000 +0200
+++ linux-2.6.12-jo1/drivers/acpi/Makefile	2005-06-18 11:59:45.000000000 +0200
@@ -56,3 +56,8 @@
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
+
+#
+# not really ACPI thing, until they handle SMP.
+#
+obj-$(CONFIG_AMD76X_PM)               += amd76x_pm.o
diff -Nru linux-2.6.12/drivers/acpi/amd76x_pm.c linux-2.6.12-jo1/drivers/acpi/amd76x_pm.c
--- linux-2.6.12/drivers/acpi/amd76x_pm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-jo1/drivers/acpi/amd76x_pm.c	2005-06-20 22:05:46.000000000 +0200
@@ -0,0 +1,862 @@
+/*
+ * ACPI style PM for SMP AMD-760MP(X) based systems.
+ * For use until the ACPI project catches up. :-)
+ *
+ * Copyright (C) 2002 - 2005	Johnathan Hicks <thetech@folkwolf.net>
+ * 				Tony Lindgren <tony@atomide.com>
+ * 				Joerg Sommrey <jo@sommrey.de>
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
+ *
+ *   20050601: Joerg Sommrey (jo)
+ *        2.6 stuff
+ *        redesigned amd76x_smp_idle.  The algorithm is basically the same
+ *           but the implementation has changed.  This part is now independent
+ *           from the number of CPUs and data is locked against concurrent
+ *           updates from different CPUs.
+ *        use _smp_processor_id()
+ *        use cpu_idle_wait()
+ *        NTH and POS code not touched and not tested.
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
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/version.h>
+#include <asm/atomic.h>
+
+#include <linux/amd76x_pm.h>
+
+#define VERSION	"20050601"
+
+// #define AMD76X_NTH 1
+// #define AMD76X_POS 1
+// #define AMD76X_C3 1
+
+extern void default_idle(void);
+#ifndef AMD76X_NTH
+static void amd76x_smp_idle(void);
+#endif
+static int amd76x_pm_main(void);
+
+static unsigned long lazy_idle = 0;
+module_param(lazy_idle, long, 0);
+MODULE_PARM_DESC(lazy_idle,
+		"number of idle cycles before entering power saving mode");
+
+MODULE_AUTHOR("Tony Lindgren, Johnathan Hicks, Joerg Sommrey, others");
+MODULE_DESCRIPTION("ACPI style power management for SMP AMD-760MP(X) "
+		"based systems");
+
+
+static struct pci_dev *pdev_nb;
+static struct pci_dev *pdev_sb;
+
+struct PM_cfg {
+	unsigned int status_reg;
+	unsigned int tmr_reg;
+	unsigned int C2_reg;
+#ifdef AMD76X_C3
+	unsigned int C3_reg;
+#endif
+#ifdef AMD76X_NTH
+	unsigned int NTH_reg;
+#endif
+	unsigned int slp_reg;
+	unsigned int resume_reg;
+	void (*orig_idle) (void);
+	void (*curr_idle) (void);
+};
+
+struct idle_stat {
+	atomic_t num_idle;
+	atomic_t num_c2;
+#ifdef AMD76X_C3
+	atomic_t num_c3;
+#endif
+	atomic_t leave_idle;
+};
+
+static struct idle_stat amd76x_stat __cacheline_aligned_in_smp = {
+	.num_idle = ATOMIC_INIT(0),
+	.num_c2 = ATOMIC_INIT(0),
+#ifdef AMD76X_C3
+	.num_c3 = ATOMIC_INIT(0),
+#endif
+	.leave_idle = ATOMIC_INIT(0),
+};
+static atomic_t stat_sem __cacheline_aligned_in_smp = ATOMIC_INIT(1);
+
+static struct PM_cfg amd76x_pm_cfg;
+
+struct cpu_stat {
+	int c2_active;
+	int idle_count;
+	unsigned int C2_cnt;
+#ifdef AMD76X_C3
+	int c3_active;
+	unsigned int C3_cnt;
+	int _fill[3];
+#else
+	int _fill;
+#endif
+};
+
+#ifndef AMD76X_NTH
+static struct cpu_stat prs[NR_CPUS] __cacheline_aligned_in_smp;
+#endif
+
+static struct pci_device_id  __devinitdata amd_nb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_700C, PCI_ANY_ID,
+		PCI_ANY_ID,},
+	{0,}
+};
+
+static struct pci_device_id  __devinitdata amd_sb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413, PCI_ANY_ID,
+		PCI_ANY_ID,},
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443, PCI_ANY_ID,
+		PCI_ANY_ID,},
+	{0,}
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
+	amd76x_pm_cfg.tmr_reg =    (regdword + 0x08);
+#ifdef AMD76X_NTH
+	amd76x_pm_cfg.NTH_reg =    (regdword + 0x10);
+#endif
+	amd76x_pm_cfg.C2_reg =     (regdword + 0x14);
+#ifdef AMD76X_C3
+	amd76x_pm_cfg.C3_reg =     (regdword + 0x15);
+#endif
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
+/*
+ * Configures the 765 & 766 southbridges.
+ */
+static int
+config_amd766(int enable)
+{
+	amd76x_get_PM();
+	config_PMIO_amd76x(1, 1);
+	config_amd766_C2(enable);
+#ifdef AMD76X_C3
+        config_amd766_C3(enable);
+#endif
+
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
+        config_amd768_C3(enable);
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
+#ifndef AMD76X_NTH
+/*
+ * Idle loop for SMP systems
+ *
+ * Locking is done using atomic_t variables, no spin locks needed.
+ *
+ */
+
+static void
+amd76x_smp_idle(void)
+{
+	int cpu;
+	int num_idle = 0;
+
+	local_irq_disable();
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10)
+	cpu = _smp_processor_id();
+#else
+	cpu = smp_processor_id();
+#endif
+
+	prs[cpu].idle_count++;
+	if (prs[cpu].c2_active)
+		num_idle = atomic_inc_return(&amd76x_stat.num_idle);
+	
+	/* Reset this CPU's status and counters if leave_idle is set */
+	if (unlikely(atomic_read(&amd76x_stat.leave_idle))) {
+		if (prs[cpu].c2_active) {
+			prs[cpu].idle_count = 0;
+			prs[cpu].c2_active = 0;
+	#ifdef AMD76X_C3
+			prs[cpu].c3_active = 0;
+	#endif
+			atomic_dec(&amd76x_stat.leave_idle);
+			atomic_dec(&amd76x_stat.num_idle);
+		}
+		local_irq_enable();
+		return;
+	}
+
+	/* Test if all CPUs are marked for C2 */
+	if (atomic_read(&amd76x_stat.num_c2) == num_online_cpus()) {
+		if (num_idle < num_online_cpus()) {
+			if (atomic_dec_and_test(&stat_sem)) {
+				if (!atomic_read(&amd76x_stat.leave_idle))
+					atomic_set(&amd76x_stat.leave_idle,
+							num_online_cpus());
+				atomic_set(&amd76x_stat.num_c2, 0);
+			#ifdef AMD76X_C3
+				atomic_set(&amd76x_stat.num_c3, 0);
+			#endif
+			}
+			atomic_inc(&stat_sem);
+			atomic_dec(&amd76x_stat.num_idle);
+			local_irq_enable();
+			return;
+		}
+	}
+
+	/* Don't start the idle mode immediately */
+	if (prs[cpu].idle_count > lazy_idle) {
+
+		prs[cpu].idle_count = 0;
+	#ifdef AMD76X_C3
+		/*
+		 * Mark this CPU for C3 if it is already marked
+		 * for C2
+		 */
+		if (prs[cpu].c2_active) {
+			prs[cpu].c3_active = 1;
+			atomic_inc(&amd76x_stat.num_c3);
+		}
+
+	#endif
+
+		if (!prs[cpu].c2_active) {
+			prs[cpu].c2_active = 1;
+			atomic_inc(&amd76x_stat.num_idle);
+			atomic_inc(&amd76x_stat.num_c2);
+		}
+
+	#ifdef AMD76X_C3
+		/* If all CPUs are marked for C3 mode: enter C3 */
+		if (atomic_read(&amd76x_stat.num_c3) == num_online_cpus()) {
+			prs[cpu].C3_cnt++;
+
+			/* Invoke C3 */
+			inb(amd76x_pm_cfg.C3_reg);
+
+			atomic_dec(&amd76x_stat.num_idle);
+			local_irq_enable();
+			return;
+		}
+	#endif
+		/* Test if all CPUs are marked for C2 */
+		if (atomic_read(&amd76x_stat.num_c2) == num_online_cpus()) {
+			prs[cpu].C2_cnt++;
+
+			/* Invoke C2 */
+			inb(amd76x_pm_cfg.C2_reg);
+
+			atomic_dec(&amd76x_stat.num_idle);
+			local_irq_enable();
+			return;
+		}
+	}
+	if (prs[cpu].c2_active)
+		atomic_dec(&amd76x_stat.num_idle);
+	local_irq_enable();
+}
+#endif
+
+/*
+ *   sysfs support, RW
+ */
+#ifndef AMD76X_NTH
+static ssize_t 
+show_lazy_idle (struct device *dev, char *buf)
+{
+	return sprintf(buf,"%lu\n", lazy_idle);  
+}
+
+static ssize_t         
+set_lazy_idle (struct device *dev, const char *buf, size_t count)
+{
+	lazy_idle = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+
+static ssize_t 
+show_C2_cnt (struct device *dev, char *buf)
+{
+	unsigned int C2_cnt = 0;
+	int i;
+	for_each_online_cpu(i)
+		C2_cnt += prs[i].C2_cnt;
+	return sprintf(buf,"%u\n", C2_cnt);  
+}
+
+#ifdef AMD76X_C3
+static ssize_t 
+show_C3_cnt (struct device *dev, char *buf)
+{
+	unsigned int C3_cnt = 0;
+	int i;
+	for_each_online_cpu(i)
+		C3_cnt += prs[i].C3_cnt;
+	return sprintf(buf,"%u\n", C3_cnt);  
+}
+#endif
+
+static DEVICE_ATTR(lazy_idle, S_IRUGO | S_IWUSR,
+		   show_lazy_idle, set_lazy_idle);
+static DEVICE_ATTR(C2_cnt, S_IRUGO,
+		   show_C2_cnt, NULL);
+#ifdef AMD76X_C3
+static DEVICE_ATTR(C3_cnt, S_IRUGO,
+		   show_C3_cnt, NULL);
+#endif
+#endif
+/*
+ * Finds and initializes the bridges, and then sets the idle function
+ */
+static int
+amd76x_pm_main(void)
+{
+#ifndef AMD76X_NTH
+	int i;
+#endif
+
+	amd76x_pm_cfg.orig_idle = 0;
+	if(lazy_idle == 0)
+	    lazy_idle = LAZY_IDLE_DELAY;
+
+	/* Find southbridge */
+	pdev_sb = NULL;
+	while((pdev_sb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb)) != NULL) {
+		if(pci_match_device(amd_sb_tbl, pdev_sb) != NULL)
+			goto found_sb;
+	}
+	printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+	return -ENODEV;
+
+ found_sb:
+
+	/* Find northbridge */
+	pdev_nb = NULL;
+	while((pdev_nb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_nb)) != NULL) {
+		if(pci_match_device(amd_nb_tbl, pdev_nb) != NULL)
+			goto found_nb;
+	}
+	printk(KERN_ERR "amd76x_pm: Could not find northbridge\n");
+	return -ENODEV;
+
+ found_nb:	
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
+		printk("amd76x_pm: No northbridge found.\n");
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
+	for (i = 0; i < NR_CPUS; i++) {
+		prs[i].idle_count = 0;
+		prs[i].c2_active = 0;
+		prs[i].C2_cnt = 0;
+	#ifdef AMD76X_C3
+		prs[i].c3_active = 0;
+		prs[i].C3_cnt = 0;
+	#endif
+	}
+
+	amd76x_pm_cfg.orig_idle = pm_idle;
+	pm_idle = amd76x_pm_cfg.curr_idle;
+
+	wmb();
+	
+	/* sysfs */
+	device_create_file(&pdev_nb->dev, &dev_attr_lazy_idle);
+	device_create_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+#ifdef AMD76X_C3
+	device_create_file(&pdev_nb->dev, &dev_attr_C3_cnt);
+#endif
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
+
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
+	int i;
+	unsigned int C2_cnt = 0;
+#ifdef AMD76X_C3
+	unsigned int C3_cnt = 0;
+#endif
+	
+#ifndef AMD76X_NTH
+	pm_idle = amd76x_pm_cfg.orig_idle;
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10))
+	cpu_idle_wait();
+#else
+	synchronize_kernel();
+#endif
+
+
+	/* This isn't really needed. */
+	for_each_online_cpu(i) {
+		C2_cnt += prs[i].C2_cnt;
+#ifdef AMD76X_C3
+		C3_cnt += prs[i].C3_cnt;
+#endif
+	}
+#ifdef AMD76X_C3
+	printk(KERN_INFO "amd76x_pm: %u C2 calls, %u C3 calls\n",
+			C2_cnt, C3_cnt);
+#else
+	printk(KERN_INFO "amd76x_pm: %u C2 calls\n", C2_cnt);
+#endif
+	
+	/* remove sysfs */
+	device_remove_file(&pdev_nb->dev, &dev_attr_lazy_idle);
+	device_remove_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+#ifdef AMD76X_C3
+	device_remove_file(&pdev_nb->dev, &dev_attr_C3_cnt);
+#endif
+#endif
+
+#ifdef AMD76X_NTH
+	/* Turn NTH off*/
+	activate_amd76x_NTH(0, 0);
+#endif
+
+}
+
+
+MODULE_LICENSE("GPL");
+module_init(amd76x_pm_init);
+module_exit(amd76x_pm_cleanup);
+
+
diff -Nru linux-2.6.12/include/linux/amd76x_pm.h linux-2.6.12-jo1/include/linux/amd76x_pm.h
--- linux-2.6.12/include/linux/amd76x_pm.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-jo1/include/linux/amd76x_pm.h	2005-06-18 11:58:56.000000000 +0200
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
