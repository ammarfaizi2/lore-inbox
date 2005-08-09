Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVHIUcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVHIUcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVHIUcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:32:13 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:61837 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964942AbVHIUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:32:12 -0400
Date: Tue, 9 Aug 2005 15:31:46 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, msm@freescale.com
Subject: [PATCH] ppc32: Added support for the Book-E style Watchdog Timer
Message-ID: <Pine.LNX.4.61.0508091530060.10161@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC 40x and Book-E processors support a watchdog timer at the processor
core level.  The timer has implementation dependent timeout frequencies
that can be configured by software. 

One the first Watchdog timeout we get a critical exception.  It is left
to board specific code to determine what should happen at this point.  If
nothing is done and another timeout period expires the processor may
attempt to reset the machine.

Command line parameters:
  wdt=0 : disable watchdog (default)
  wdt=1 : enable watchdog

  wdt_period=N : N sets the value of the Watchdog Timer Period.

  The Watchdog Timer Period meaning is implementation specific. Check
  User Manual for the processor for more details.

This patch is based off of work done by Takeharu Kato.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1780d9e65903f3132133f754cf290a5db7916965
tree 88daf35ce065f24a86ad0ad4f7a57c91aa15527d
parent a60c894ec93e545340a495fc15d34ca69e7accbe
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 09 Aug 2005 15:27:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 09 Aug 2005 15:27:28 -0500

 Documentation/watchdog/watchdog-api.txt |   20 +++
 arch/ppc/kernel/head_44x.S              |    4 +
 arch/ppc/kernel/head_4xx.S              |    4 -
 arch/ppc/kernel/head_fsl_booke.S        |    5 +
 arch/ppc/kernel/setup.c                 |   24 ++++
 arch/ppc/kernel/traps.c                 |   19 +++
 arch/ppc/syslib/ppc4xx_setup.c          |   25 ----
 drivers/char/watchdog/Kconfig           |    4 +
 drivers/char/watchdog/Makefile          |    1 
 drivers/char/watchdog/booke_wdt.c       |  191 +++++++++++++++++++++++++++++++
 10 files changed, 270 insertions(+), 27 deletions(-)

diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -228,6 +228,26 @@ advantechwdt.c -- Advantech Single Board
 	The GETSTATUS call returns if the device is open or not.
 	[FIXME -- silliness again?]
 	
+booke_wdt.c -- PowerPC BookE Watchdog Timer
+
+	Timeout default varies according to frequency, supports
+	SETTIMEOUT
+
+	Watchdog can not be turned off, CONFIG_WATCHDOG_NOWAYOUT
+	does not make sense
+
+	GETSUPPORT returns the watchdog_info struct, and
+	GETSTATUS returns the supported options. GETBOOTSTATUS
+	returns a 1 if the last reset was caused by the
+	watchdog and a 0 otherwise. This watchdog can not be
+	disabled once it has been started. The wdt_period kernel
+	parameter selects which bit of the time base changing
+	from 0->1 will trigger the watchdog exception. Changing
+	the timeout from the ioctl calls will change the
+	wdt_period as defined above. Finally if you would like to
+	replace the default Watchdog Handler you can implement the
+	WatchdogHandler() function in your own code.
+
 eurotechwdt.c -- Eurotech CPU-1220/1410
 
 	The timeout can be set using the SETTIMEOUT ioctl and defaults
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -462,7 +462,11 @@ interrupt_base:
 
 	/* Watchdog Timer Interrupt */
 	/* TODO: Add watchdog support */
+#ifdef CONFIG_BOOKE_WDT
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, WatchdogException)
+#else
 	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+#endif
 
 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -448,7 +448,9 @@ label:
 
 /* 0x1020 - Watchdog Timer (WDT) Exception
 */
-
+#ifdef CONFIG_BOOKE_WDT
+	CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
+#else
 	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
 #endif
 
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -564,8 +564,11 @@ interrupt_base:
 	EXCEPTION(0x3100, FixedIntervalTimer, UnknownException, EXC_XFER_EE)
 
 	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#ifdef CONFIG_BOOKE_WDT
+	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, WatchdogException)
+#else
 	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+#endif
 
 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -615,6 +615,30 @@ machine_init(unsigned long r3, unsigned 
 	if (ppc_md.progress)
 		ppc_md.progress("id mach(): done", 0x200);
 }
+#ifdef CONFIG_BOOKE_WDT
+/* Checks wdt=x and wdt_period=xx command-line option */
+int __init early_parse_wdt(char *p)
+{
+	extern u32 wdt_enable;
+
+	if (p && strncmp(p, "0", 1) != 0)
+	       wdt_enable = 1;
+
+	return 0;
+}
+early_param("wdt", early_parse_wdt);
+
+int __init early_parse_wdt_period (char *p)
+{
+	extern u32 wdt_period;
+
+	if (p)
+		wdt_period = simple_strtoul(p, NULL, 0);
+
+	return 0;
+}
+early_param("wdt_period", early_parse_wdt_period);
+#endif	/* CONFIG_BOOKE_WDT */
 
 /* Checks "l2cr=xxxx" command-line option */
 int __init ppc_setup_l2cr(char *str)
diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -904,6 +904,25 @@ void SPEFloatingPointException(struct pt
 }
 #endif
 
+#ifdef CONFIG_BOOKE_WDT
+/*
+ * Default handler for a Watchdog exception,
+ * spins until a reboot occurs
+ */
+void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
+{
+	/* Generic WatchdogHandler, implement your own */
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
+	return;
+}
+
+void WatchdogException(struct pt_regs *regs)
+{
+	printk (KERN_EMERG "PowerPC Book-E Watchdog Exception\n");
+	WatchdogHandler(regs);
+}
+#endif
+
 void __init trap_init(void)
 {
 }
diff --git a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
--- a/arch/ppc/syslib/ppc4xx_setup.c
+++ b/arch/ppc/syslib/ppc4xx_setup.c
@@ -48,10 +48,6 @@
 extern void abort(void);
 extern void ppc4xx_find_bridges(void);
 
-extern void ppc4xx_wdt_heartbeat(void);
-extern int wdt_enable;
-extern unsigned long wdt_period;
-
 /* Global Variables */
 bd_t __res;
 
@@ -257,22 +253,6 @@ ppc4xx_init(unsigned long r3, unsigned l
 		*(char *) (r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
-#if defined(CONFIG_PPC405_WDT)
-/* Look for wdt= option on command line */
-	if (strstr(cmd_line, "wdt=")) {
-		int valid_wdt = 0;
-		char *p, *q;
-		for (q = cmd_line; (p = strstr(q, "wdt=")) != 0;) {
-			q = p + 4;
-			if (p > cmd_line && p[-1] != ' ')
-				continue;
-			wdt_period = simple_strtoul(q, &q, 0);
-			valid_wdt = 1;
-			++q;
-		}
-		wdt_enable = valid_wdt;
-	}
-#endif
 
 	/* Initialize machine-dependent vectors */
 
@@ -286,11 +266,6 @@ ppc4xx_init(unsigned long r3, unsigned l
 	ppc_md.halt = ppc4xx_halt;
 
 	ppc_md.calibrate_decr = ppc4xx_calibrate_decr;
-
-#ifdef CONFIG_PPC405_WDT
-	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
-#endif
-	ppc_md.heartbeat_count = 0;
 
 	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
 	ppc_md.setup_io_mappings = ppc4xx_map_io;
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -346,6 +346,10 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config BOOKE_WDT
+	tristate "PowerPC Book-E Watchdog Timer"
+	depends on WATCHDOG && (BOOKE || 4xx)
+
 # MIPS Architecture
 
 config INDYDOG
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
+obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -0,0 +1,191 @@
+/*
+ * drivers/char/watchdog/booke_wdt.c
+ *
+ * Watchdog timer for PowerPC Book-E systems
+ *
+ * Author: Matthew McClintock
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/notifier.h>
+#include <linux/watchdog.h>
+
+#include <asm/reg_booke.h>
+#include <asm/uaccess.h>
+
+/* If the kernel parameter wdt_enable=1, the watchdog will be enabled at boot.
+ * Also, the wdt_period sets the watchdog timer period timeout.
+ * For E500 cpus the wdt_period sets which bit changing from 0->1 will
+ * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
+ * first time nothing will happen, the second time a watchdog exception will
+ * occur, and the final time the board will reset.
+ */
+
+#ifdef	CONFIG_FSL_BOOKE
+#define WDT_PERIOD_DEFAULT 63	/* Ex. wdt_period=28 bus=333Mhz , reset=~40sec */
+#else
+#define WDT_PERIOD_DEFAULT 4	/* Refer to the PPC40x and PPC4xx manuals */
+#endif				/* for timing information */
+
+u32 wdt_enable = 0;
+u32 wdt_period = WDT_PERIOD_DEFAULT;
+
+#ifdef	CONFIG_FSL_BOOKE
+#define WDTP(x)		((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
+#else
+#define WDTP(x)		(TCR_WP(x))
+#endif
+
+/*
+ * booke_wdt_enable:
+ */
+static __inline__ void booke_wdt_enable(void)
+{
+	u32 val;
+
+	val = mfspr(SPRN_TCR);
+	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(wdt_period));
+
+	mtspr(SPRN_TCR, val);
+}
+
+/*
+ * booke_wdt_ping:
+ */
+static __inline__ void booke_wdt_ping(void)
+{
+	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
+}
+
+/*
+ * booke_wdt_write:
+ */
+static ssize_t booke_wdt_write (struct file *file, const char *buf,
+				size_t count, loff_t *ppos)
+{
+	booke_wdt_ping();
+	return count;
+}
+
+static struct watchdog_info ident = {
+  .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+  .firmware_version = 0,
+  .identity = "PowerPC Book-E Watchdog",
+};
+
+/*
+ * booke_wdt_ioctl:
+ */
+static int booke_wdt_ioctl (struct inode *inode, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	u32 tmp = 0;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user ((struct watchdog_info *) arg, &ident,
+				sizeof(struct watchdog_info)))
+			return -EFAULT;
+	case WDIOC_GETSTATUS:
+		return put_user(ident.options, (u32 *) arg);
+	case WDIOC_GETBOOTSTATUS:
+		/* XXX: something is clearing TSR */
+		tmp = mfspr(SPRN_TSR) & TSR_WRS(3);
+		/* returns 1 if last reset was caused by the WDT */
+		return (tmp ? 1 : 0);
+	case WDIOC_KEEPALIVE:
+		booke_wdt_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(wdt_period, (u32 *) arg))
+			return -EFAULT;
+		mtspr(SPRN_TCR, (mfspr(SPRN_TCR)&~WDTP(0))|WDTP(wdt_period));
+		return 0;
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdt_period, (u32 *) arg);
+	case WDIOC_SETOPTIONS:
+		if (get_user(tmp, (u32 *) arg))
+			return -EINVAL;
+		if (tmp == WDIOS_ENABLECARD) {
+			booke_wdt_ping();
+			break;
+		} else
+			return -EINVAL;
+		return 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+/*
+ * booke_wdt_open:
+ */
+static int booke_wdt_open (struct inode *inode, struct file *file)
+{
+	if (wdt_enable == 0) {
+		wdt_enable = 1;
+		booke_wdt_enable();
+		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
+				wdt_period);
+	}
+
+	return 0;
+}
+
+static struct file_operations booke_wdt_fops = {
+  .owner = THIS_MODULE,
+  .llseek = no_llseek,
+  .write = booke_wdt_write,
+  .ioctl = booke_wdt_ioctl,
+  .open = booke_wdt_open,
+};
+
+static struct miscdevice booke_wdt_miscdev = {
+  .minor = WATCHDOG_MINOR,
+  .name = "watchdog",
+  .fops = &booke_wdt_fops,
+};
+
+static void __exit booke_wdt_exit(void)
+{
+	misc_deregister(&booke_wdt_miscdev);
+}
+
+/*
+ * booke_wdt_init:
+ */
+static int __init booke_wdt_init(void)
+{
+	int ret = 0;
+
+	printk (KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
+	ident.firmware_version = cpu_specs[0].pvr_value;
+
+	ret = misc_register(&booke_wdt_miscdev);
+	if (ret) {
+		printk (KERN_CRIT "Cannot register miscdev on minor=%d (err=%d)\n",
+				WATCHDOG_MINOR, ret);
+		return ret;
+	}
+
+	if (wdt_enable == 1) {
+		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
+				wdt_period);
+		booke_wdt_enable();
+	}
+
+	return ret;
+}
+device_initcall(booke_wdt_init);
