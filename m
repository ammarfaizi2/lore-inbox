Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTKJAdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 19:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTKJAdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 19:33:37 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:37903
	"EHLO muru.com") by vger.kernel.org with ESMTP id S261267AbTKJAdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 19:33:15 -0500
Date: Sun, 9 Nov 2003 16:33:06 -0800
To: linux-kernel@vger.kernel.org
Cc: pasi.savolainen@hut.fi, Charles Lepple <clepple@ghz.cc>, f.maibaum@web.de,
       peter.gantner@stud.uni-graz.at
Subject: [PATCH] amd76x_pm on 2.6.0-test9 more cleanup and clock skew test
Message-ID: <20031110003305.GA2833@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've done some more cleanup on the amd76x_pm module. Looks like Pasi and
I both did pretty much the same changes last time independently, but Pasi
chopped off even more unnecessary code. So I've continued the cleanup based
on Pasi's code.

I've done some cleanup to remove my old comments and to get rid of all 
the ifdefs. This makes the code more readable and makes it easier to
develop. I've also changed the functions around a bit to group them
better, and changed variable naming to be more standard. I've only edited
the amd76x_pm.c file, and did not do any functional changes. Just cleanup.

On the clock skew problem, it's still there, and to figure out how bad the
problem is, I've done a little shell script based on the earlier thread on
adjtimex on this mailing list. You can get the skewtest.sh from:

http://www.muru.com/linux/amd-smp-idle/skewtest.sh

On my S2460 system with a pair of Athlon 1400's I get the following results:

                            suggested tick
Without amd76x_pm module:   10002
With amd76x_pm module:      between 9952 - 9977

I guess some people see much worse skew on some systems? Can you please 
run the skewtest.sh and post some results, thanks.

Following is the current patch, you can also get it from:

http://www.muru.com/linux/amd-smp-idle/

I may not have access to my Athlon box for next few weeks, but hopefully 
Pasi keeps maintaining the module as needed.

Tony


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="linux-2.6-amd76x_pm-20031109.patch"

diff -Nru linux-2.6.0-test9/drivers/acpi/Kconfig kt9/drivers/acpi/Kconfig
diff -Nru linux-2.6.0-test9/drivers/acpi/Kconfig kt9/drivers/acpi/Kconfig
--- linux-2.6.0-test9/drivers/acpi/Kconfig	2003-10-11 12:36:19.000000000 +0300
+++ kt9/drivers/acpi/Kconfig	2003-10-26 13:06:00.000000000 +0200
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
diff -Nru linux-2.6.0-test9/drivers/acpi/Makefile kt9/drivers/acpi/Makefile
diff -Nru linux-2.6.0-test9/drivers/acpi/Makefile kt9/drivers/acpi/Makefile
--- linux-2.6.0-test9/drivers/acpi/Makefile	2003-10-11 12:36:19.000000000 +0300
+++ kt9/drivers/acpi/Makefile	2003-10-26 13:06:00.000000000 +0200
@@ -48,3 +48,8 @@
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o 
+
+#
+# not really ACPI thing, until they handle SMP.
+#
+obj-$(CONFIG_AMD76X_PM)		+= amd76x_pm.o
--- /dev/null	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/linux/amd76x_pm.h	2003-11-04 12:43:25.000000000 -0800
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
--- /dev/null	1969-12-31 16:00:00.000000000 -0800
+++ linux/drivers/acpi/amd76x_pm.c	2003-11-09 14:30:53.000000000 -0800
@@ -0,0 +1,672 @@
+/*
+ * ACPI style PM for SMP AMD-760MP(X) based systems.
+ * For use until the ACPI project catches up. :-)
+ *
+ * Copyright (C) 2002 Tony Lindgren <tony@atomide.com>
+ * Copyright (C) 2002 Johnathan Hicks <thetech@folkwolf.net>
+ * Copyright (C) 2003 Pasi Savolainen
+ *
+ * HISTORY
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
+ *   	into activate_amd76x_slp(). C3 idling doesn't happen yet; see my note
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
+ *      Look for /sys/devices/pci0/00:00.0/c2_cnt & lazy_idle (latter writable)
+ *
+ *   20031026: Pasi Savolainen
+ *      Removed unnecessary PCI code that caused problems with other modules
+ *
+ *   20031109: Tony Lindgren
+ *      Got rid of the ifdefs, reorganized the code to make it more readable
+ *      for further changes. Cleaned my old comments away, added comments on 
+ *      known problems. No functional changes done.
+ * 
+ * TODO 
+ *
+ * - Thermal throttling (TTH).
+ * - /sys interface for normal throttling level.
+ * - /sys interface for POS.
+ *
+ * NOTES
+ *
+ * Using this module saves about 70 - 90W of energy in the idle mode compared
+ * to the default idle mode. Waking up from the idle mode is fast to keep the
+ * system response time good. Currently no CPU load calculation is done, the
+ * system exits the idle mode if the idle function runs twice on the same
+ * processor in a row. This only works on SMP systems, but maybe the idle mode
+ * enabling can be integrated to ACPI to provide C2 mode at some point.
+ *
+ * At least the following systems are known to work: TYAN S2460, ASUS A7M266-D.
+ *
+ * KNOWN PROBLEMS
+ *
+ * - System goes into sleep mode on S2460 when the driver is compiled in and
+ *   loaded before other ACPI initializations. The system wakes up from an
+ *   ACPI interrupt at this point, such as pressing the power button once.
+ *   Current workaround is to load amd76x_pm as module.
+ *
+ * - System clock skew on certain systems. This seems to be fixed on
+ *   2.6.0-test9 for most part, but still appears on some systems. This may 
+ *   be caused by out of sync TSCs. This problem may also be related to
+ *   spurious interrupts on line 9 (ACPI). Dropping HZ to 100 is the current
+ *   workaround for this problem.
+ *
+ * This software is licensed under GNU General Public License Version 2 
+ * as specified in file COPYING in the Linux kernel source tree main 
+ * directory.
+ */
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
+
+#include <linux/amd76x_pm.h>
+
+#define VERSION	"20031109"
+
+/* Experimental code for future ACPI throttling */
+//#define AMD76X_C3
+//#define AMD76X_NTH
+//#define AMD76X_POS
+
+/* Have the compiler optimize away these functions if not used */
+#ifdef AMD76X_C3
+#define use_amd76x_c3()		1
+#else
+#define use_amd76x_c3()		0
+#endif
+
+#ifdef AMD76X_NTH
+#define use_amd76x_nth()	1
+#else
+#define use_amd76x_nth()	0
+#endif
+
+#ifdef AMD76X_POS
+#define use_amd76x_pos()	1
+#else
+#define use_amd76x_pos()	0
+#endif
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
+	unsigned int c2_reg;
+	unsigned int c3_reg;
+	unsigned int nth_reg;
+	unsigned int slp_reg;
+	unsigned int resume_reg;
+	void (*orig_idle) (void);
+	void (*curr_idle) (void);
+	unsigned long c2_cnt, c3_cnt, idle_cnt;
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
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_700C, PCI_ANY_ID, PCI_ANY_ID,},
+	{0,}
+};
+
+static struct pci_device_id  __devinitdata amd_sb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413, PCI_ANY_ID, PCI_ANY_ID,},
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443, PCI_ANY_ID, PCI_ANY_ID,},
+	{0,}
+};
+
+/*
+ * Get the base PMIO address and set the pm registers in amd76x_pm_cfg.
+ */
+static void
+amd76x_get_pm(void)
+{
+	unsigned int regdword;
+
+	/* Get the address for pm status, P_LVL2, etc */
+	pci_read_config_dword(pdev_sb, 0x58, &regdword);
+	regdword &= 0xff80;
+	amd76x_pm_cfg.status_reg = (regdword + 0x00);
+	amd76x_pm_cfg.slp_reg =    (regdword + 0x04);
+	amd76x_pm_cfg.nth_reg =    (regdword + 0x10);
+	amd76x_pm_cfg.c2_reg =     (regdword + 0x14);
+	amd76x_pm_cfg.c3_reg =     (regdword + 0x15);
+	amd76x_pm_cfg.resume_reg = (regdword + 0x16); /* N/A for 768 */
+}
+
+/*
+ * En/Disable PMIO and configure W4SG & STPGNT.
+ */
+static int
+config_pmio_amd76x(int is_766, int enable)
+{
+	unsigned char regbyte;
+
+	/* Clear W4SG, and set PMIOEN, if using a 765/766 set STPGNT as well.
+	 * AMD-766: C3A41; page 59 in AMD-766 doc
+	 * AMD-768: DevB:3x41C; page 94 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x41, &regbyte);
+	if (enable) {
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
+config_amd766_c2(int enable)
+{
+	unsigned int regdword;
+
+	/* Set C2 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if (enable) {
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
+/*
+ * C2 idling support for AMD-768.
+ */
+static void
+config_amd768_c2(int enable)
+{
+	unsigned char regbyte;
+
+	/* Set C2 options in DevB:3x4F, page 100 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
+	if (enable)
+		regbyte |= C2EN;
+	else
+		regbyte ^= C2EN;
+	pci_write_config_byte(pdev_sb, 0x4F, regbyte);
+}
+
+/*
+ * Untested C3 idle support for AMD-766.
+ */
+static void
+config_amd766_c3(int enable)
+{
+	unsigned int regdword;
+
+	/* Set C3 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if (enable) {
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
+
+/*
+ * C3 idle support for AMD-768. The idle loop would need some extra
+ * handling for C3, but it would make more sense for ACPI to handle CX level
+ * transitions like it is supposed to. Unfortunately ACPI doesn't do CX
+ * levels on SMP systems yet.
+ */
+static void
+config_amd768_c3(int enable)
+{
+	unsigned char regbyte;
+
+	/* Set C3 options in DevB:3x4F, page 100 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
+	if (enable)
+		regbyte |= (C3EN /* | ZZ_C3EN | CSLP_C3EN | CSTP_C3EN */);
+	else
+		regbyte ^= C3EN;
+	pci_write_config_byte(pdev_sb, 0x4F, regbyte);
+}
+
+static void
+config_amd766_pos(int enable)
+{
+	unsigned int regdword;
+
+	/* Set C3 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if (enable) {
+		regdword &= ~((ZZ_CACHE_EN | CPURST_EN) << POS_REGS);
+		regdword |= ((DCSTOP_EN | STPCLK_EN | CPUSTP_EN | PCISTP_EN |
+					CPUSLP_EN | SUSPND_EN) << POS_REGS);
+	}
+	else
+		regdword ^= (0xff << POS_REGS);
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+
+/*
+ * Untested Power On Suspend support for AMD-768. This should also be handled
+ * by ACPI.
+ */
+static void
+config_amd768_pos(int enable)
+{
+	unsigned int regdword;
+
+	/* Set POS options in DevB:3x50, page 101 in AMD-768 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if (enable) 
+		regdword |= (POSEN | CSTP | PSTP | ASTP | DCSTP | CSLP | SUSP);
+	else
+		regdword ^= POSEN;
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+
+/*
+ * Normal Throttling support for AMD-768. There are several settings
+ * that can be set depending on how long you want some of the delays to be.
+ * I'm not sure if this is even neccessary at all as the 766 doesn't need this.
+ */
+static void
+config_amd768_nth(int enable, int ntper, int thminen)
+{
+	unsigned char regbyte;
+
+	/* DevB:3x40, pg 93 of 768 doc */
+	pci_read_config_byte(pdev_sb, 0x40, &regbyte);
+	/* Is it neccessary to use THMINEN at ANY time? */
+	regbyte |= (NTPER(ntper) | THMINEN(thminen));
+	pci_write_config_byte(pdev_sb, 0x40, regbyte);
+}
+
+/*
+ * Activate normal throttling via its ACPI register (P_CNT).
+ */
+static void
+activate_amd76x_nth(int enable, int ratio)
+{
+	unsigned int regdword;
+
+	/* PM10, pg 110 of 768 doc, pg 70 of 766 doc */
+	regdword=inl(amd76x_pm_cfg.nth_reg);
+	if (enable)
+		regdword |= (NTH_EN | NTH_RATIO(ratio));
+	else
+		regdword ^= NTH_EN;
+	outl(regdword, amd76x_pm_cfg.nth_reg);
+}
+
+/*
+ * Activate sleep state via its ACPI register (PM1_CNT).
+ */
+static void
+activate_amd76x_slp(int type)
+{
+	unsigned short regshort;
+
+	/* PM04, pg 109 of 768 doc, pg 69 of 766 doc */
+	regshort=inw(amd76x_pm_cfg.slp_reg);
+	regshort |= (SLP_EN | SLP_TYP(type)) ;
+	outw(regshort, amd76x_pm_cfg.slp_reg);
+}
+
+/*
+ * Wrapper function to activate POS sleep state.
+ */
+static void
+activate_amd76x_pos(void)
+{
+	activate_amd76x_slp(1);
+}
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
+			amd76x_pm_cfg.c2_cnt++;
+			inb(amd76x_pm_cfg.c2_reg);
+		} else if (use_amd76x_c3() && (prs[0].idle==2) && (prs[1].idle==2)) {
+			/*
+			 * JH: I've not been able to get into here. Could this have
+			 * something to do with the way the kernel handles the idle
+			 * loop, or and error that I've made?
+			 */
+			amd76x_pm_cfg.c3_cnt++;
+			inb(amd76x_pm_cfg.c3_reg);
+		}
+
+		prs[smp_processor_id()].count = 0;
+
+	}
+	amd76x_pm_cfg.last_pr = smp_processor_id();
+}
+
+/*
+ * Sysfs support, RW
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
+show_c2_cnt (struct device *dev, char *buf)
+{
+    return sprintf(buf,"%lu\n", amd76x_pm_cfg.c2_cnt);  
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
+static DEVICE_ATTR(c2_cnt, S_IRUGO,
+		   show_c2_cnt, NULL);
+static DEVICE_ATTR(idle_cnt, S_IRUGO,
+		   show_idle_cnt, NULL);
+
+/*
+ * Configures the 765 & 766 southbridges.
+ */
+static int
+config_sb_amd766(int enable)
+{
+	amd76x_get_pm();
+	config_pmio_amd76x(1, 1);
+	config_amd766_c2(enable);
+
+	if (use_amd76x_c3())
+		config_amd766_c3(enable);
+
+	if (use_amd76x_pos())
+		config_amd766_pos(enable);
+
+	return 0;
+}
+
+/*
+ * Configures the 768 southbridge to support idle calls, and gets
+ * the processor idle call register location.
+ */
+static int
+config_sb_amd768(int enable)
+{
+	amd76x_get_pm();
+	config_pmio_amd76x(0, 1);
+	config_amd768_c2(enable);
+
+	if (use_amd76x_c3())
+		config_amd768_c3(enable);
+
+	if (use_amd76x_pos())
+		config_amd768_pos(enable);
+
+	if (use_amd76x_nth())
+		config_amd768_nth(enable, 1, 2);
+
+	return 0;
+}
+
+/*
+ * Configures the AMD-762 northbridge to support PM calls
+ */
+static int
+config_nb_amd762(int enable)
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
+/*
+ * Finds and initializes the bridges, and then sets the idle function
+ */
+static int
+amd76x_pm_main(void)
+{
+	amd76x_pm_cfg.orig_idle = 0;
+	if (lazy_idle == 0)
+	    lazy_idle = LAZY_IDLE_DELAY;
+
+	/* Find southbridge */
+	pdev_sb = NULL;
+	while((pdev_sb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb)) != NULL) {
+		if (pci_match_device(amd_sb_tbl, pdev_sb) != NULL)
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
+		if (pci_match_device(amd_nb_tbl, pdev_nb) != NULL)
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
+		config_sb_amd766(1);
+		break;
+	case PCI_DEVICE_ID_AMD_VIPER_7443:	/* AMD-768 */
+		config_sb_amd768(1);
+		break;
+	default:
+		printk(KERN_ERR "amd76x_pm: No southbridge to initialize\n");		
+		break;
+	}
+
+	/* Init northbridge and queue the new idle function */
+	if (!pdev_nb) {
+		printk("amd76x_pm: No northbridge found.\n");
+		return -ENODEV;
+	}
+	switch (pdev_nb->device) {
+	case PCI_DEVICE_ID_AMD_FE_GATE_700C:	/* AMD-762 */
+		config_nb_amd762(1);
+
+		if (!use_amd76x_nth())
+			amd76x_pm_cfg.curr_idle = amd76x_smp_idle;
+
+		break;
+	default:
+		printk(KERN_ERR "amd76x_pm: No northbridge to initialize\n");
+		break;
+	}
+
+	if (!use_amd76x_nth()) {
+		if (num_online_cpus() == 1) {
+			amd76x_pm_cfg.curr_idle = amd76x_up_idle;
+			printk(KERN_ERR "amd76x_pm: UP machine detected. Use ACPI\n");
+		}
+
+		if (!amd76x_pm_cfg.curr_idle) {
+			printk(KERN_ERR "amd76x_pm: Idle function not changed\n");
+			return 1;
+		}
+
+		amd76x_pm_cfg.orig_idle = pm_idle;
+		pm_idle = amd76x_pm_cfg.curr_idle;
+		wmb();
+	
+		/* sysfs */
+		device_create_file(&pdev_nb->dev, &dev_attr_lazy_idle);
+		device_create_file(&pdev_nb->dev, &dev_attr_c2_cnt);
+		device_create_file(&pdev_nb->dev, &dev_attr_idle_cnt);
+	}
+
+	/* Turn NTH on with maxium throttling for testing. */
+	if (use_amd76x_nth())
+		activate_amd76x_nth(1, 1);
+
+	/* Testing here only. */
+	if (use_amd76x_pos())
+		activate_amd76x_pos();
+
+	return 0;
+}
+
+static int __init
+amd76x_pm_init(void)
+{
+	printk(KERN_INFO "amd76x_pm: Version %s\n", VERSION);
+	return amd76x_pm_main();
+}
+
+static void __exit
+amd76x_pm_cleanup(void)
+{
+	if (!use_amd76x_nth()) {
+		pm_idle = amd76x_pm_cfg.orig_idle;
+		synchronize_kernel();
+
+		/* This isn't really needed. */
+		printk(KERN_INFO "amd76x_pm: %lu C2 calls\n", amd76x_pm_cfg.c2_cnt);
+
+		if (use_amd76x_c3())
+			printk(KERN_INFO "amd76x_pm: %lu C3 calls\n", 
+			       amd76x_pm_cfg.c3_cnt);
+
+		/* Remove sysfs */
+		device_remove_file(&pdev_nb->dev, &dev_attr_lazy_idle);
+		device_remove_file(&pdev_nb->dev, &dev_attr_c2_cnt);
+		device_remove_file(&pdev_nb->dev, &dev_attr_idle_cnt);
+	}
+
+	/* Turn NTH off*/
+	if (use_amd76x_nth())
+		activate_amd76x_nth(0, 0);
+}
+
+MODULE_LICENSE("GPL");
+module_init(amd76x_pm_init);
+module_exit(amd76x_pm_cleanup);
/* 
 * Begin 765/766
 */
/* C2/C3/POS options in C3A50, page 63 in AMD-766 doc */
#define ZZ_CACHE_EN	1
#define DCSTOP_EN	(1 << 1)
#define STPCLK_EN	(1 << 2)
#define CPUSTP_EN	(1 << 3)
#define PCISTP_EN	(1 << 4)
#define CPUSLP_EN	(1 << 5)
#define SUSPND_EN	(1 << 6)
#define CPURST_EN	(1 << 7)

#define C2_REGS		0
#define C3_REGS		8
#define POS_REGS	16	
/*
 * End 765/766
 */


/*
 * Begin 768
 */
/* C2/C3 options in DevB:3x4F, page 100 in AMD-768 doc */
#define C2EN		1
#define C3EN		(1 << 1)
#define ZZ_C3EN		(1 << 2)
#define CSLP_C3EN	(1 << 3)
#define CSTP_C3EN	(1 << 4)

/* POS options in DevB:3x50, page 101 in AMD-768 doc */
#define POSEN	1
#define CSTP	(1 << 2)
#define PSTP	(1 << 3)
#define ASTP	(1 << 4)
#define DCSTP	(1 << 5)
#define CSLP	(1 << 6)
#define SUSP	(1 << 8)
#define MSRSM	(1 << 14)
#define PITRSM	(1 << 15)

/* NTH options DevB:3x40, pg 93 of 768 doc */
#define NTPER(x) (x << 3)
#define THMINEN(x) (x << 4)

/*
 * End 768
 */

/* NTH activate. PM10, pg 110 of 768 doc, pg 70 of 766 doc */
#define NTH_RATIO(x) (x << 1)
#define NTH_EN (1 << 4)

/* Sleep state. PM04, pg 109 of 768 doc, pg 69 of 766 doc */
#define SLP_EN (1 << 13)
#define SLP_TYP(x) (x << 10)

#define LAZY_IDLE_DELAY	800	/* 0: Best savings,  3000: More responsive */

--0ntfKIWw70PvrIHh--
