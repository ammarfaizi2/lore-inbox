Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWHAUJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWHAUJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWHAUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:09:53 -0400
Received: from outmx001.isp.belgacom.be ([195.238.5.51]:9887 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751854AbWHAUJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:09:51 -0400
Date: Tue, 1 Aug 2006 22:09:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.18-rc3 patches
Message-ID: <20060801200931.GA3758@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-imss-version: 2.032
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:3.51.1032(14006.000)
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following watchdog patches are ready to be added to the linux-2.6 git tree.
They contain typo fixes for drivers/char/watchdog/Kconfig and a new
watchdog driver for the Philips PNX4008 ARM board inlined.
(So they shouldn't break anything for the 2.6.18 release)
Most of the patches have been a month into the -mm tree.

If there are problems with these patches, please let me know.
If not I will sent them to Linus on sunday.

The patches will update the following files:

 arch/arm/mach-pnx4008/clock.c        |   11 +
 drivers/char/watchdog/Kconfig        |   19 +
 drivers/char/watchdog/Makefile       |    1 
 drivers/char/watchdog/pnx4008_wdt.c  |  349 +++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-pnx4008/clock.h |    1 
 5 files changed, 377 insertions(+), 4 deletions(-)

with these Changes:

Author: Vitaly Wool <vitalywool@gmail.com>
Date:   Mon Jun 26 19:31:49 2006 +0400

    [WATCHDOG] pnx4008: add watchdog support
    
    Add watchdog support for Philips PNX4008 ARM board inlined.
    
    Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jul 3 09:03:47 2006 +0200

    [WATCHDOG] pnx4008_wdt.c - nowayout patch
    
    Change nowayout to: WATCHDOG_NOWAYOUT as defined
    in include/linux/watchdog.h .
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Matt LaPlante <kernel1@cyberdogtech.com>
Date:   Wed Jul 5 01:20:51 2006 +0000

    [WATCHDOG] Kconfig typos fix.
    
    Three typos in drivers/char/watchdog/Kconfig...
    
    Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Jul 30 20:06:07 2006 +0200

    [WATCHDOG] pnx4008_wdt.c - remove patch
    
    Change remove code so that we first detach
    the driver from userspace, then clean up the
    clock and then clean up the memory we allocated.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index f582ed2..daa8d3d 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -735,6 +735,16 @@ static struct clk uart6_ck = {
 	.enable_reg = UARTCLKCTRL_REG,
 };
 
+static struct clk wdt_ck = {
+	.name = "wdt_ck",
+	.parent = &per_ck,
+	.flags = NEEDS_INITIALIZATION,
+	.round_rate = &on_off_round_rate,
+	.set_rate = &on_off_set_rate,
+	.enable_shift = 0,
+	.enable_reg = TIMCLKCTRL_REG,
+};
+
 /* These clocks are visible outside this module
  * and can be initialized
  */
@@ -765,6 +775,7 @@ static struct clk *onchip_clks[] = {
 	&uart4_ck,
 	&uart5_ck,
 	&uart6_ck,
+	&wdt_ck,
 };
 
 static int local_clk_enable(struct clk *clk)
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index d53f664..508fe59 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -45,7 +45,7 @@ #
 comment "Watchdog Device Drivers"
 	depends on WATCHDOG
 
-# Architecture Independant
+# Architecture Independent
 
 config SOFT_WATCHDOG
 	tristate "Software watchdog"
@@ -127,7 +127,7 @@ config S3C2410_WATCHDOG
 	  enabled.
 
 	  The driver is limited by the speed of the system's PCLK
-	  signal, so with reasonbaly fast systems (PCLK around 50-66MHz)
+	  signal, so with reasonably fast systems (PCLK around 50-66MHz)
 	  then watchdog intervals of over approximately 20seconds are
 	  unavailable.
 
@@ -165,6 +165,17 @@ config EP93XX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called ep93xx_wdt.
 
+config PNX4008_WATCHDOG
+	tristate "PNX4008 Watchdog"
+	depends on WATCHDOG && ARCH_PNX4008
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in the PNX4008 processor.
+	  This driver can be built as a module by choosing M. The module
+	  will be called pnx4008_wdt.
+
+	  Say N if you are unsure.
+
 # X86 (i386 + ia64 + x86_64) Architecture
 
 config ACQUIRE_WDT
@@ -423,7 +434,7 @@ config SBC_EPX_C3_WATCHDOG
 	  is no way to know if writing to its IO address will corrupt
 	  your system or have any real effect.  The only way to be sure
 	  that this driver does what you want is to make sure you
-	  are runnning it on an EPX-C3 from Winsystems with the watchdog
+	  are running it on an EPX-C3 from Winsystems with the watchdog
 	  timer at IO address 0x1ee and 0x1ef.  It will write to both those
 	  IO ports.  Basically, the assumption is made that if you compile
 	  this driver into your kernel and/or load it as a module, that you
@@ -472,7 +483,7 @@ config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
 	depends on WATCHDOG && SGI_IP22
 	help
-	  Hardwaredriver for the Indy's/I2's watchdog. This is a
+	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
 	  timer expired and no process has written to /dev/watchdog during
 	  that time.
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index 6ab77b6..9d4c2fb 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_S3C2410_WATCHDOG) += s3c241
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
 obj-$(CONFIG_MPCORE_WATCHDOG) += mpcore_wdt.o
 obj-$(CONFIG_EP93XX_WATCHDOG) += ep93xx_wdt.o
+obj-$(CONFIG_PNX4008_WATCHDOG) += pnx4008_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/char/watchdog/pnx4008_wdt.c b/drivers/char/watchdog/pnx4008_wdt.c
new file mode 100644
index 0000000..465dfd3
--- /dev/null
+++ b/drivers/char/watchdog/pnx4008_wdt.c
@@ -0,0 +1,349 @@
+/*
+ * drivers/char/watchdog/pnx4008_wdt.c
+ *
+ * Watchdog driver for PNX4008 board
+ *
+ * Authors: Dmitry Chigirev <source@mvista.com>,
+ * 	    Vitaly Wool <vitalywool@gmail.com>
+ * Based on sa1100 driver,
+ * Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
+ *
+ * 2005-2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/hardware.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define MODULE_NAME "PNX4008-WDT: "
+
+/* WatchDog Timer - Chapter 23 Page 207 */
+
+#define DEFAULT_HEARTBEAT 19
+#define MAX_HEARTBEAT     60
+
+/* Watchdog timer register set definition */
+#define WDTIM_INT(p)     ((p) + 0x0)
+#define WDTIM_CTRL(p)    ((p) + 0x4)
+#define WDTIM_COUNTER(p) ((p) + 0x8)
+#define WDTIM_MCTRL(p)   ((p) + 0xC)
+#define WDTIM_MATCH0(p)  ((p) + 0x10)
+#define WDTIM_EMR(p)     ((p) + 0x14)
+#define WDTIM_PULSE(p)   ((p) + 0x18)
+#define WDTIM_RES(p)     ((p) + 0x1C)
+
+/* WDTIM_INT bit definitions */
+#define MATCH_INT      1
+
+/* WDTIM_CTRL bit definitions */
+#define COUNT_ENAB     1
+#define RESET_COUNT    (1<<1)
+#define DEBUG_EN       (1<<2)
+
+/* WDTIM_MCTRL bit definitions */
+#define MR0_INT        1
+#undef  RESET_COUNT0
+#define RESET_COUNT0   (1<<2)
+#define STOP_COUNT0    (1<<2)
+#define M_RES1         (1<<3)
+#define M_RES2         (1<<4)
+#define RESFRC1        (1<<5)
+#define RESFRC2        (1<<6)
+
+/* WDTIM_EMR bit definitions */
+#define EXT_MATCH0      1
+#define MATCH_OUTPUT_HIGH (2<<4)	/*a MATCH_CTRL setting */
+
+/* WDTIM_RES bit definitions */
+#define WDOG_RESET      1	/* read only */
+
+#define WDOG_COUNTER_RATE 13000000	/*the counter clock is 13 MHz fixed */
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+static int heartbeat = DEFAULT_HEARTBEAT;
+
+static unsigned long wdt_status;
+#define WDT_IN_USE        0
+#define WDT_OK_TO_CLOSE   1
+#define WDT_REGION_INITED 2
+#define WDT_DEVICE_INITED 3
+
+static unsigned long boot_status;
+
+static struct resource	*wdt_mem;
+static void __iomem	*wdt_base;
+struct clk		*wdt_clk;
+
+static void wdt_enable(void)
+{
+	if (wdt_clk)
+		clk_set_rate(wdt_clk, 1);
+
+	/* stop counter, initiate counter reset */
+	__raw_writel(RESET_COUNT, WDTIM_CTRL(wdt_base));
+	/*wait for reset to complete. 100% guarantee event */
+	while (__raw_readl(WDTIM_COUNTER(wdt_base)));
+	/* internal and external reset, stop after that */
+	__raw_writel(M_RES2 | STOP_COUNT0 | RESET_COUNT0,
+		WDTIM_MCTRL(wdt_base));
+	/* configure match output */
+	__raw_writel(MATCH_OUTPUT_HIGH, WDTIM_EMR(wdt_base));
+	/* clear interrupt, just in case */
+	__raw_writel(MATCH_INT, WDTIM_INT(wdt_base));
+	/* the longest pulse period 65541/(13*10^6) seconds ~ 5 ms. */
+	__raw_writel(0xFFFF, WDTIM_PULSE(wdt_base));
+	__raw_writel(heartbeat * WDOG_COUNTER_RATE, WDTIM_MATCH0(wdt_base));
+	/*enable counter, stop when debugger active */
+	__raw_writel(COUNT_ENAB | DEBUG_EN, WDTIM_CTRL(wdt_base));
+}
+
+static void wdt_disable(void)
+{
+	__raw_writel(0, WDTIM_CTRL(wdt_base));	/*stop counter */
+	if (wdt_clk)
+		clk_set_rate(wdt_clk, 0);
+}
+
+static int pnx4008_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
+		return -EBUSY;
+
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	wdt_enable();
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t
+pnx4008_wdt_write(struct file *file, const char *data, size_t len,
+		  loff_t * ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
+			}
+		}
+		wdt_enable();
+	}
+
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE |
+	    WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "PNX4008 Watchdog",
+};
+
+static int
+pnx4008_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		  unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	int time;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user((struct watchdog_info *)arg, &ident,
+				   sizeof(ident)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(boot_status, (int *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(time, (int *)arg);
+		if (ret)
+			break;
+
+		if (time <= 0 || time > MAX_HEARTBEAT) {
+			ret = -EINVAL;
+			break;
+		}
+
+		heartbeat = time;
+		wdt_enable();
+		/* Fall through */
+
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(heartbeat, (int *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wdt_enable();
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+static int pnx4008_wdt_release(struct inode *inode, struct file *file)
+{
+	if (!test_bit(WDT_OK_TO_CLOSE, &wdt_status))
+		printk(KERN_WARNING "WATCHDOG: Device closed unexpectdly\n");
+
+	wdt_disable();
+	clear_bit(WDT_IN_USE, &wdt_status);
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	return 0;
+}
+
+static struct file_operations pnx4008_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = pnx4008_wdt_write,
+	.ioctl = pnx4008_wdt_ioctl,
+	.open = pnx4008_wdt_open,
+	.release = pnx4008_wdt_release,
+};
+
+static struct miscdevice pnx4008_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &pnx4008_wdt_fops,
+};
+
+static int pnx4008_wdt_probe(struct platform_device *pdev)
+{
+	int ret = 0, size;
+	struct resource *res;
+
+	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
+		heartbeat = DEFAULT_HEARTBEAT;
+
+	printk(KERN_INFO MODULE_NAME
+		"PNX4008 Watchdog Timer: heartbeat %d sec\n", heartbeat);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		printk(KERN_INFO MODULE_NAME
+			"failed to get memory region resouce\n");
+		return -ENOENT;
+	}
+
+	size = res->end - res->start + 1;
+	wdt_mem = request_mem_region(res->start, size, pdev->name);
+
+	if (wdt_mem == NULL) {
+		printk(KERN_INFO MODULE_NAME "failed to get memory region\n");
+		return -ENOENT;
+	}
+	wdt_base = (void __iomem *)IO_ADDRESS(res->start);
+
+	wdt_clk = clk_get(&pdev->dev, "wdt_ck");
+	if (!wdt_clk) {
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
+		goto out;
+	} else
+		clk_set_rate(wdt_clk, 1);
+
+	ret = misc_register(&pnx4008_wdt_miscdev);
+	if (ret < 0) {
+		printk(KERN_ERR MODULE_NAME "cannot register misc device\n");
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
+		clk_set_rate(wdt_clk, 0);
+	} else {
+		boot_status = (__raw_readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
+		    WDIOF_CARDRESET : 0;
+		wdt_disable();		/*disable for now */
+		set_bit(WDT_DEVICE_INITED, &wdt_status);
+	}
+
+out:
+	return ret;
+}
+
+static int pnx4008_wdt_remove(struct platform_device *pdev)
+{
+	misc_deregister(&pnx4008_wdt_miscdev);
+	if (wdt_clk) {
+		clk_set_rate(wdt_clk, 0);
+		clk_put(wdt_clk);
+		wdt_clk = NULL;
+	}
+	if (wdt_mem) {
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
+		wdt_mem = NULL;
+	}
+	return 0;
+}
+
+static struct platform_driver platform_wdt_driver = {
+	.driver = {
+		.name = "watchdog",
+	},
+	.probe = pnx4008_wdt_probe,
+	.remove = pnx4008_wdt_remove,
+};
+
+static int __init pnx4008_wdt_init(void)
+{
+	return platform_driver_register(&platform_wdt_driver);
+}
+
+static void __exit pnx4008_wdt_exit(void)
+{
+	return platform_driver_unregister(&platform_wdt_driver);
+}
+
+module_init(pnx4008_wdt_init);
+module_exit(pnx4008_wdt_exit);
+
+MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
+MODULE_DESCRIPTION("PNX4008 Watchdog Driver");
+
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat,
+		 "Watchdog heartbeat period in seconds from 1 to "
+		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
+		 __MODULE_STRING(DEFAULT_HEARTBEAT));
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Set to 1 to keep watchdog running after device release");
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/include/asm-arm/arch-pnx4008/clock.h b/include/asm-arm/arch-pnx4008/clock.h
index 91ae003..ce155e1 100644
--- a/include/asm-arm/arch-pnx4008/clock.h
+++ b/include/asm-arm/arch-pnx4008/clock.h
@@ -32,6 +32,7 @@ #define I2CCLKCTRL_REG		(PWRMAN_VA_BASE 
 #define KEYCLKCTRL_REG		(PWRMAN_VA_BASE + 0xb0)
 #define TSCLKCTRL_REG		(PWRMAN_VA_BASE + 0xb4)
 #define PWMCLKCTRL_REG		(PWRMAN_VA_BASE + 0xb8)
+#define TIMCLKCTRL_REG		(PWRMAN_VA_BASE + 0xbc)
 #define SPICTRL_REG		(PWRMAN_VA_BASE + 0xc4)
 #define FLASHCLKCTRL_REG	(PWRMAN_VA_BASE + 0xc8)
 #define UART3CLK_REG		(PWRMAN_VA_BASE + 0xd0)
