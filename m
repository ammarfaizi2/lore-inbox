Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUJRH0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUJRH0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 03:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUJRH0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 03:26:10 -0400
Received: from europa.telenet-ops.be ([195.130.132.60]:40072 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263769AbUJRHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 03:25:06 -0400
Date: Mon, 18 Oct 2004 09:25:25 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [WATCHDOG] v2.6.9-rc3 s3c2410_wdt.c + i8xx_tco.c
Message-ID: <20041018072525.GA1500@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 arch/arm/configs/bast_defconfig              |   11 
 arch/arm/configs/s3c2410_defconfig           |    9 
 drivers/char/watchdog/Kconfig                |   16 
 drivers/char/watchdog/Makefile               |    1 
 drivers/char/watchdog/i8xx_tco.c             |    2 
 drivers/char/watchdog/s3c2410_wdt.c          |  628 ++++++++++++++++++++++++---
 include/asm-arm/arch-s3c2410/regs-watchdog.h |    1 
 7 files changed, 608 insertions(+), 60 deletions(-)

through these ChangeSets:

<ben@fluff.org> (04/09/07 1.1832.68.3)
   Add S3C2410 (Samsung ARM9 Mobile SoC) watchdog driver

<ben@fluff.org> (04/10/03 1.1832.68.4)
   [WATCHDOG] s3c2410_wdt.c-wdog-fix-memrelease.patch
   
   fix the release of the memory resource at exit from the code, and tidy
   up the static variables at the start.
   
   Signed-of-by: Ben Dooks <ben-wdog@fluff.org>
   Signed-of-by: Wim Van Sebroeck <wim@iguana.be>

<ben@fluff.org> (04/10/06 1.1832.68.5)
   [WATCHDOG] s3c2410_wdt.c-wdog-fix3.patch
   
   This patch fixes the following problems:
   - debug is now configurable from cmdline (see previous emails)
   - re-worked the open call
   - moved clock enable to before we setup watchdog
     (some units on the s3c2410 don't like their registers changing
      without the clock enabled)
   - fixed bug in having two timer counts, one unused
   - fixed semaphore initialisation, so opens no longer blow up

<dimitry.andric@tomtom.com> (04/10/06 1.1832.68.6)
   [WATCHDOG] s3c2410_wdt.c-wdog-fix4.patch
   
   This patch moves the tmr_margin assignment until after the check for a
   correct timeout value. (Plus another minor cosmetic thing.)

<wim@iguana.be> (04/10/06 1.1832.68.7)
   [WATCHDOG] s3c2410_wdt.c-wdog-fix5.patch
   
   Changed nowayout handling so that it uses the "Kconfig" value.

<wim@iguana.be> (04/10/17 1.2162)
   [WATCHDOG] v2.6.9-rc3 i8xx_tco.c-stop_reboot-patch
   
   Fix for Bugzilla Bug 132719: "watchdog i8xx_tco causing machine to
   reboot."


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/arch/arm/configs/bast_defconfig b/arch/arm/configs/bast_defconfig
--- a/arch/arm/configs/bast_defconfig	2004-10-18 09:14:58 +02:00
+++ b/arch/arm/configs/bast_defconfig	2004-10-18 09:14:58 +02:00
@@ -479,12 +479,19 @@
 #
 # Watchdog Cards
 #
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_S3C2410_WATCHDOG=y
 # CONFIG_NVRAM is not set
 CONFIG_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
+
 
 #
 # Ftape, the floppy tape device driver
diff -Nru a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
--- a/arch/arm/configs/s3c2410_defconfig	2004-10-18 09:14:58 +02:00
+++ b/arch/arm/configs/s3c2410_defconfig	2004-10-18 09:14:58 +02:00
@@ -493,7 +493,14 @@
 #
 # Watchdog Cards
 #
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_S3C2410_WATCHDOG=y
 # CONFIG_NVRAM is not set
 CONFIG_RTC=y
 # CONFIG_DTLK is not set
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2004-10-18 09:14:58 +02:00
+++ b/drivers/char/watchdog/Kconfig	2004-10-18 09:14:58 +02:00
@@ -106,6 +106,22 @@
 
 	  Say N if you are unsure.
 
+config S3C2410_WATCHDOG
+	tristate "S3C2410 Watchdog"
+	depends on WATCHDOG && ARCH_S3C2410
+	help
+	  Watchdog timer block in the Samsung S3C2410 chips. This will
+	  reboot the system when the timer expires with the watchdog
+	  enabled.
+
+	  The driver is limited by the speed of the system's PCLK
+	  signal, so with reasonbaly fast systems (PCLK around 50-66MHz)
+	  then watchdog intervals of over approximately 20seconds are
+	  unavailable.
+
+	  The driver can be built as a module by choosing M, and will
+	  be called s3c2410_wdt
+
 config SA1100_WATCHDOG
 	tristate "SA1100/PXA2xx watchdog"
 	depends on WATCHDOG && ( ARCH_SA1100 || ARCH_PXA )
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2004-10-18 09:14:58 +02:00
+++ b/drivers/char/watchdog/Makefile	2004-10-18 09:14:58 +02:00
@@ -21,6 +21,7 @@
 obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SH_WDT) += shwdt.o
+obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:14:58 +02:00
@@ -0,0 +1,507 @@
+/* linux/drivers/char/watchdog/s3c2410_wdt.c
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ * Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2410 Watchdog Timer Support
+ *
+ * Based on, softdog.c by Alan Cox,
+ *     (c) Copyright 1996 Alan Cox <alan@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/timer.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <asm/arch/map.h>
+#include <asm/hardware/clock.h>
+
+#undef S3C2410_VA_WATCHDOG
+#define S3C2410_VA_WATCHDOG (0)
+
+#include <asm/arch/regs-watchdog.h>
+
+#define PFX "s3c2410-wdt: "
+
+#ifdef CONFIG_S3C2410_WATCHDOG_DEBUG
+#undef pr_debug
+#define pr_debug(msg, x...) do { printk(KERN_INFO msg, x); } while(0)
+#endif
+
+/* configurations from makefile */
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+#define CONFIG_WATCHDOG_NOWAYOUT (0)
+#endif
+
+#ifndef CONFIG_S3C2410_WATCHDOG_ATBOOT
+#define CONFIG_S3C2410_WATCHDOG_ATBOOT (0)
+#endif
+
+#ifndef CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME
+#define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME (15)
+#endif
+
+static int tmr_margin  = CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
+static int tmr_atboot  = CONFIG_S3C2410_WATCHDOG_ATBOOT;
+static int nowayout    = CONFIG_WATCHDOG_NOWAYOUT;
+static int soft_noboot = 0;
+
+module_param(tmr_margin,  int, 0);
+module_param(tmr_atboot,  int, 0);
+module_param(nowayout,    int, 0);
+module_param(soft_noboot, int, 0);
+
+MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. default=" __MODULE_STRING(CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME) ")");
+
+MODULE_PARM_DESC(tmr_atboot, "Watchdog is started at boot time if set to 1, default=" __MODULE_STRING(CONFIG_S3C2410_WATCHDOG_ATBOOT));
+
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default depends on ONLY_TESTING)");
+
+
+typedef enum close_state {
+	CLOSE_STATE_NOT,
+	CLOSE_STATE_ALLOW=0x4021
+} close_state_t;
+
+static struct semaphore open_lock;
+static struct resource *wdt_mem;
+static struct resource *wdt_irq;
+static struct clk      *wdt_clock;
+static unsigned long    wdt_base;
+static unsigned int     wdt_count;
+static close_state_t    allow_close;
+
+static unsigned int tmr_count;
+
+/* watchdog control routines */
+
+static int s3c2410wdt_keepalive(void)
+{
+	writel(wdt_count, wdt_base + S3C2410_WTCNT);
+	return 0;
+}
+
+static int s3c2410wdt_stop(void)
+{
+	unsigned long wtcon;
+
+	wtcon = readl(wdt_base + S3C2410_WTCON);
+	wtcon &= ~(S3C2410_WTCON_ENABLE | S3C2410_WTCON_RSTEN);
+	writel(wtcon, wdt_base + S3C2410_WTCON);
+
+	return 0;
+}
+
+static int s3c2410wdt_start(void)
+{
+	unsigned long wtcon;
+
+	wtcon = readl(wdt_base + S3C2410_WTCON);
+	wtcon |= S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128;
+
+	if (soft_noboot) {
+		wtcon |= S3C2410_WTCON_INTEN;
+		wtcon &= ~S3C2410_WTCON_RSTEN;
+	} else {
+		wtcon &= ~S3C2410_WTCON_INTEN;
+		wtcon |= S3C2410_WTCON_RSTEN;
+	}
+
+	clk_enable(wdt_clock);
+
+	pr_debug("%s: tmr_count=0x%08x, wtcon=%08lx\n",
+		 __FUNCTION__, tmr_count, wtcon);
+
+	writel(tmr_count, wdt_base + S3C2410_WTDAT);
+	writel(wtcon, wdt_base + S3C2410_WTCON);
+
+	return 0;
+}
+
+static int s3c2410wdt_set_heartbeat(int timeout)
+{
+	unsigned int freq = clk_get_rate(wdt_clock);
+	unsigned int count;
+	unsigned int divisor = 1;
+	unsigned long wtcon;
+
+	if (timeout < 1)
+		return -EINVAL;
+
+	tmr_margin = timeout;
+
+	/* I think someone must have missed a divide-by-2 in the 2410,
+	 * as a divisor of 128 gives half the calculated delay...
+	 */
+
+	freq /= 128/2;
+	count = timeout * freq;
+
+	pr_debug("%s: count=%d, timeout=%d, freq=%d\n",
+		 __FUNCTION__, count, timeout, freq);
+
+	/* if the count is bigger than the watchdog register,
+	   then work out what we need to do (and if) we can
+	   actually make this value
+	*/
+
+	if (count >= 0x10000) {
+		for (divisor = 1; divisor <= 0x100; divisor++) {
+			if ((count / divisor) < 0x10000)
+				break;
+		}
+
+		if ((count / divisor) >= 0x10000) {
+			printk(KERN_ERR PFX "timeout %d too big\n", timeout);
+			return -EINVAL;
+		}
+	}
+
+	pr_debug("%s: timeout=%d, divisor=%d, count=%d (%08x)\n",
+		 __FUNCTION__, timeout, divisor, count, count/divisor);
+
+	count /= divisor;
+	tmr_count = count;
+
+	/* update the pre-scaler */
+	wtcon = readl(wdt_base + S3C2410_WTCON);
+	wtcon &= ~S3C2410_WTCON_PRESCALE_MASK;
+	wtcon |= S3C2410_WTCON_PRESCALE(divisor-1);
+
+	writel(count, wdt_base + S3C2410_WTDAT);
+	writel(wtcon, wdt_base + S3C2410_WTCON);
+
+	return 0;
+}
+
+/*
+ *	/dev/watchdog handling
+ */
+
+static int s3c2410wdt_open(struct inode *inode, struct file *file)
+{
+	if(down_trylock(&open_lock))
+		return -EBUSY;
+
+	if (nowayout) {
+		__module_get(THIS_MODULE);
+	} else {
+		allow_close = CLOSE_STATE_ALLOW;
+	}
+
+	/* start the timer */
+	s3c2410wdt_start();
+	return nonseekable_open(inode, file);
+}
+
+static int s3c2410wdt_release(struct inode *inode, struct file *file)
+{
+	/*
+	 *	Shut off the timer.
+	 * 	Lock it in if it's a module and we set nowayout
+	 */
+	if (allow_close == CLOSE_STATE_ALLOW) {
+		s3c2410wdt_stop();
+	} else {
+		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		s3c2410wdt_keepalive();
+	}
+
+	allow_close = CLOSE_STATE_NOT;
+	up(&open_lock);
+	return 0;
+}
+
+static ssize_t s3c2410wdt_write(struct file *file, const char __user *data,
+				size_t len, loff_t *ppos)
+{
+	/*
+	 *	Refresh the timer.
+	 */
+	if(len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			allow_close = CLOSE_STATE_NOT;
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					allow_close = CLOSE_STATE_ALLOW;
+			}
+		}
+
+		s3c2410wdt_keepalive();
+	}
+	return len;
+}
+
+#define OPTIONS WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE
+
+static struct watchdog_info s3c2410_wdt_ident = {
+	.options          =     OPTIONS,
+	.firmware_version =	0,
+	.identity         =	"S3C2410 Watchdog",
+};
+
+
+static int s3c2410wdt_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_margin;
+
+	switch (cmd) {
+		default:
+			return -ENOIOCTLCMD;
+
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &s3c2410_wdt_ident,
+				sizeof(s3c2410_wdt_ident)) ? -EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, p);
+
+		case WDIOC_KEEPALIVE:
+			s3c2410wdt_keepalive();
+			return 0;
+
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, p))
+				return -EFAULT;
+
+			if (s3c2410wdt_set_heartbeat(new_margin))
+				return -EINVAL;
+
+			s3c2410wdt_keepalive();
+			return put_user(tmr_margin, p);
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(tmr_margin, p);
+	}
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int s3c2410wdt_notify_sys(struct notifier_block *this, unsigned long code,
+			      void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT) {
+		/* Turn the WDT off */
+		s3c2410wdt_stop();
+	}
+	return NOTIFY_DONE;
+}
+
+/* kernel interface */
+
+static struct file_operations s3c2410wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= s3c2410wdt_write,
+	.ioctl		= s3c2410wdt_ioctl,
+	.open		= s3c2410wdt_open,
+	.release	= s3c2410wdt_release,
+};
+
+static struct miscdevice s3c2410wdt_miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &s3c2410wdt_fops,
+};
+
+static struct notifier_block s3c2410wdt_notifier = {
+	.notifier_call	= s3c2410wdt_notify_sys,
+};
+
+/* interrupt handler code */
+
+static irqreturn_t s3c2410wdt_irq(int irqno, void *param,
+				  struct pt_regs *regs)
+{
+	printk(KERN_INFO PFX "Watchdog timer expired!\n");
+
+	s3c2410wdt_keepalive();
+	return IRQ_HANDLED;
+}
+/* device interface */
+
+static int s3c2410wdt_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	int started = 0;
+	int ret;
+
+	pr_debug("%s: probe=%p, device=%p\n", __FUNCTION__, pdev, dev);
+
+	/* get the memory region for the watchdog timer */
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		printk(KERN_INFO PFX "failed to get memory region resouce\n");
+		return -ENOENT;
+	}
+
+	if (!request_mem_region(res->start, res->end-res->start, pdev->name)) {
+		printk(KERN_INFO PFX "failed to get memory region\n");
+		return -ENOENT;
+	}
+
+	wdt_base = (unsigned long)ioremap(res->start, res->end - res->start);
+	if (wdt_base == 0) {
+		printk(KERN_INFO PFX "failed to ioremap() region\n");
+		return -EINVAL;
+	}
+
+	pr_debug("wdt_base=%08lx\n", wdt_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res == NULL) {
+		printk(KERN_INFO PFX "failed to get irq resource\n");
+		return -ENOENT;
+	}
+
+	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, dev);
+	if (ret != 0) {
+		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
+		return ret;
+	}
+
+	wdt_clock = clk_get(dev, "watchdog");
+	if (wdt_clock == NULL) {
+		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
+		return -ENOENT;
+	}
+
+	clk_use(wdt_clock);
+
+	/* see if we can actually set the requested timer margin, and if
+	 * not, try the default value */
+
+	if (s3c2410wdt_set_heartbeat(tmr_margin)) {
+		started = s3c2410wdt_set_heartbeat(CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME);
+
+		if (started == 0) {
+			printk(KERN_INFO PFX "tmr_margin value out of range, default %d used\n",
+			       CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME);
+		} else {
+			printk(KERN_INFO PFX "default timer value is out of range, cannot start\n");
+		}
+	}
+
+	ret = register_reboot_notifier(&s3c2410wdt_notifier);
+	if (ret) {
+		printk (KERN_ERR PFX "cannot register reboot notifier (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = misc_register(&s3c2410wdt_miscdev);
+	if (ret) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
+			WATCHDOG_MINOR, ret);
+		unregister_reboot_notifier(&s3c2410wdt_notifier);
+		return ret;
+	}
+
+	if (tmr_atboot && started == 0) {
+		printk(KERN_INFO PFX "Starting Watchdog Timer\n");
+		s3c2410wdt_start();
+	}
+
+	return 0;
+}
+
+static int s3c2410wdt_remove(struct device *dev)
+{
+	if (wdt_mem != NULL) {
+		release_mem_region(wdt_mem->start,
+				   wdt_mem->end - wdt_mem->start);
+		wdt_mem = NULL;
+	}
+
+	if (wdt_irq != NULL) {
+		free_irq(wdt_irq->start, dev);
+		wdt_irq = NULL;
+	}
+
+	if (wdt_clock != NULL) {
+		clk_disable(wdt_clock);
+		clk_unuse(wdt_clock);
+		clk_put(wdt_clock);
+		wdt_clock = NULL;
+	}
+
+	misc_deregister(&s3c2410wdt_miscdev);
+	return 0;
+}
+
+static struct device_driver s3c2410wdt_driver = {
+	.name		= "s3c2410-wdt",
+	.bus		= &platform_bus_type,
+	.probe		= s3c2410wdt_probe,
+	.remove		= s3c2410wdt_remove,
+};
+
+
+
+static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics";
+
+static int __init watchdog_init(void)
+{
+	printk(banner);
+	return driver_register(&s3c2410wdt_driver);
+}
+
+static void __exit watchdog_exit(void)
+{
+	driver_unregister(&s3c2410wdt_driver);
+	unregister_reboot_notifier(&s3c2410wdt_notifier);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff -Nru a/include/asm-arm/arch-s3c2410/regs-watchdog.h b/include/asm-arm/arch-s3c2410/regs-watchdog.h
--- a/include/asm-arm/arch-s3c2410/regs-watchdog.h	2004-10-18 09:14:58 +02:00
+++ b/include/asm-arm/arch-s3c2410/regs-watchdog.h	2004-10-18 09:14:58 +02:00
@@ -38,6 +38,7 @@
 #define S3C2410_WTCON_DIV128  (3<<3)
 
 #define S3C2410_WTCON_PRESCALE(x) ((x) << 8)
+#define S3C2410_WTCON_PRESCALE_MASK (0xff00)
 
 #endif /* __ASM_ARCH_REGS_WATCHDOG_H */
 
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:01 +02:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:01 +02:00
@@ -93,13 +93,13 @@
 	CLOSE_STATE_ALLOW=0x4021
 } close_state_t;
 
-static struct semaphore open_lock;
-static struct resource *wdt_mem;
-static struct resource *wdt_irq;
-static struct clk      *wdt_clock;
-static unsigned long    wdt_base;
-static unsigned int     wdt_count;
-static close_state_t    allow_close;
+static struct semaphore	 open_lock;
+static struct resource	*wdt_mem;
+static struct resource	*wdt_irq;
+static struct clk	*wdt_clock;
+static void __iomem	*wdt_base;
+static unsigned int	 wdt_count;
+static close_state_t	 allow_close;
 
 static unsigned int tmr_count;
 
@@ -370,6 +370,7 @@
 	struct resource *res;
 	int started = 0;
 	int ret;
+	int size;
 
 	pr_debug("%s: probe=%p, device=%p\n", __FUNCTION__, pdev, dev);
 
@@ -381,12 +382,14 @@
 		return -ENOENT;
 	}
 
-	if (!request_mem_region(res->start, res->end-res->start, pdev->name)) {
+	size = (res->end-res->start)+1;
+	wdt_mem = request_mem_region(res->start, size, pdev->name);
+	if (wdt_mem == NULL) {
 		printk(KERN_INFO PFX "failed to get memory region\n");
 		return -ENOENT;
 	}
 
-	wdt_base = (unsigned long)ioremap(res->start, res->end - res->start);
+	wdt_base = ioremap(res->start, size);
 	if (wdt_base == 0) {
 		printk(KERN_INFO PFX "failed to ioremap() region\n");
 		return -EINVAL;
@@ -454,8 +457,8 @@
 static int s3c2410wdt_remove(struct device *dev)
 {
 	if (wdt_mem != NULL) {
-		release_mem_region(wdt_mem->start,
-				   wdt_mem->end - wdt_mem->start);
+		release_resource(wdt_mem);
+		kfree(wdt_mem);
 		wdt_mem = NULL;
 	}
 
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:04 +02:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:04 +02:00
@@ -1,7 +1,7 @@
 /* linux/drivers/char/watchdog/s3c2410_wdt.c
  *
  * Copyright (c) 2004 Simtec Electronics
- * Ben Dooks <ben@simtec.co.uk>
+ *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 Watchdog Timer Support
  *
@@ -21,6 +21,11 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Changelog:
+ *	05-Oct-2004	BJD	Added semaphore init to stop crashes on open
+ *				Fixed tmr_count / wdt_count confusion
+ *				Added configurable debug
 */
 
 #include <linux/module.h>
@@ -50,34 +55,21 @@
 
 #define PFX "s3c2410-wdt: "
 
-#ifdef CONFIG_S3C2410_WATCHDOG_DEBUG
-#undef pr_debug
-#define pr_debug(msg, x...) do { printk(KERN_INFO msg, x); } while(0)
-#endif
-
-/* configurations from makefile */
-
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-#define CONFIG_WATCHDOG_NOWAYOUT (0)
-#endif
-
-#ifndef CONFIG_S3C2410_WATCHDOG_ATBOOT
-#define CONFIG_S3C2410_WATCHDOG_ATBOOT (0)
-#endif
-
-#ifndef CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME
-#define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME (15)
-#endif
-
-static int tmr_margin  = CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
-static int tmr_atboot  = CONFIG_S3C2410_WATCHDOG_ATBOOT;
-static int nowayout    = CONFIG_WATCHDOG_NOWAYOUT;
-static int soft_noboot = 0;
+#define CONFIG_WATCHDOG_NOWAYOUT		(0)
+#define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
+#define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
+
+static int tmr_margin	= CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
+static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
+static int nowayout	= CONFIG_WATCHDOG_NOWAYOUT;
+static int soft_noboot	= 0;
+static int debug	= 0;
 
 module_param(tmr_margin,  int, 0);
 module_param(tmr_atboot,  int, 0);
 module_param(nowayout,    int, 0);
 module_param(soft_noboot, int, 0);
+module_param(debug,	  int, 0);
 
 MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. default=" __MODULE_STRING(CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME) ")");
 
@@ -87,13 +79,16 @@
 
 MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default depends on ONLY_TESTING)");
 
+MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug, (default 0)");
+
 
 typedef enum close_state {
 	CLOSE_STATE_NOT,
 	CLOSE_STATE_ALLOW=0x4021
 } close_state_t;
 
-static struct semaphore	 open_lock;
+static DECLARE_MUTEX(open_lock);
+
 static struct resource	*wdt_mem;
 static struct resource	*wdt_irq;
 static struct clk	*wdt_clock;
@@ -101,10 +96,15 @@
 static unsigned int	 wdt_count;
 static close_state_t	 allow_close;
 
-static unsigned int tmr_count;
-
 /* watchdog control routines */
 
+#define DBG(msg...) do { \
+	if (debug) \
+		printk(KERN_INFO msg); \
+	} while(0)
+
+/* functions */
+
 static int s3c2410wdt_keepalive(void)
 {
 	writel(wdt_count, wdt_base + S3C2410_WTCNT);
@@ -126,6 +126,8 @@
 {
 	unsigned long wtcon;
 
+	s3c2410wdt_stop();
+
 	wtcon = readl(wdt_base + S3C2410_WTCON);
 	wtcon |= S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128;
 
@@ -137,12 +139,11 @@
 		wtcon |= S3C2410_WTCON_RSTEN;
 	}
 
-	clk_enable(wdt_clock);
-
-	pr_debug("%s: tmr_count=0x%08x, wtcon=%08lx\n",
-		 __FUNCTION__, tmr_count, wtcon);
+	DBG("%s: wdt_count=0x%08x, wtcon=%08lx\n",
+	    __FUNCTION__, wdt_count, wtcon);
 
-	writel(tmr_count, wdt_base + S3C2410_WTDAT);
+	writel(wdt_count, wdt_base + S3C2410_WTDAT);
+	writel(wdt_count, wdt_base + S3C2410_WTCNT);
 	writel(wtcon, wdt_base + S3C2410_WTCON);
 
 	return 0;
@@ -167,8 +168,8 @@
 	freq /= 128/2;
 	count = timeout * freq;
 
-	pr_debug("%s: count=%d, timeout=%d, freq=%d\n",
-		 __FUNCTION__, count, timeout, freq);
+	DBG("%s: count=%d, timeout=%d, freq=%d\n",
+	    __FUNCTION__, count, timeout, freq);
 
 	/* if the count is bigger than the watchdog register,
 	   then work out what we need to do (and if) we can
@@ -187,11 +188,11 @@
 		}
 	}
 
-	pr_debug("%s: timeout=%d, divisor=%d, count=%d (%08x)\n",
-		 __FUNCTION__, timeout, divisor, count, count/divisor);
+	DBG("%s: timeout=%d, divisor=%d, count=%d (%08x)\n",
+	    __FUNCTION__, timeout, divisor, count, count/divisor);
 
 	count /= divisor;
-	tmr_count = count;
+	wdt_count = count;
 
 	/* update the pre-scaler */
 	wtcon = readl(wdt_base + S3C2410_WTCON);
@@ -372,7 +373,7 @@
 	int ret;
 	int size;
 
-	pr_debug("%s: probe=%p, device=%p\n", __FUNCTION__, pdev, dev);
+	DBG("%s: probe=%p, device=%p\n", __FUNCTION__, pdev, dev);
 
 	/* get the memory region for the watchdog timer */
 
@@ -395,7 +396,7 @@
 		return -EINVAL;
 	}
 
-	pr_debug("wdt_base=%08lx\n", wdt_base);
+	DBG("probe: mapped wdt_base=%px\n", wdt_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
@@ -416,6 +417,7 @@
 	}
 
 	clk_use(wdt_clock);
+	clk_enable(wdt_clock);
 
 	/* see if we can actually set the requested timer margin, and if
 	 * not, try the default value */
@@ -487,7 +489,7 @@
 
 
 
-static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics";
+static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics\n";
 
 static int __init watchdog_init(void)
 {
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:06 +02:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:06 +02:00
@@ -159,8 +159,6 @@
 	if (timeout < 1)
 		return -EINVAL;
 
-	tmr_margin = timeout;
-
 	/* I think someone must have missed a divide-by-2 in the 2410,
 	 * as a divisor of 128 gives half the calculated delay...
 	 */
@@ -188,6 +186,8 @@
 		}
 	}
 
+	tmr_margin = timeout;
+
 	DBG("%s: timeout=%d, divisor=%d, count=%d (%08x)\n",
 	    __FUNCTION__, timeout, divisor, count, count/divisor);
 
@@ -396,7 +396,7 @@
 		return -EINVAL;
 	}
 
-	DBG("probe: mapped wdt_base=%px\n", wdt_base);
+	DBG("probe: mapped wdt_base=%p\n", wdt_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:09 +02:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2004-10-18 09:15:09 +02:00
@@ -55,13 +55,17 @@
 
 #define PFX "s3c2410-wdt: "
 
-#define CONFIG_WATCHDOG_NOWAYOUT		(0)
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
 static int tmr_margin	= CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
-static int nowayout	= CONFIG_WATCHDOG_NOWAYOUT;
 static int soft_noboot	= 0;
 static int debug	= 0;
 
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	2004-10-18 09:15:11 +02:00
+++ b/drivers/char/watchdog/i8xx_tco.c	2004-10-18 09:15:11 +02:00
@@ -465,7 +465,7 @@
 		goto unreg_notifier;
 	}
 
-	tco_timer_keepalive ();
+	tco_timer_stop ();
 
 	printk (KERN_INFO PFX "initialized (0x%04x). heartbeat=%d sec (nowayout=%d)\n",
 		TCOBASE, heartbeat, nowayout);
