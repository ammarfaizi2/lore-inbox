Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVICUFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVICUFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 16:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVICUFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 16:05:22 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:2440 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751232AbVICUFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 16:05:21 -0400
Date: Sat, 3 Sep 2005 22:04:43 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       Dimitry Andric <dimitry.andric@tomtom.com>, Olaf Hering <olh@suse.de>,
       Deepak Saxena <dsaxena@plexity.net>,
       Christer Weinigel <wingel@nano-system.com>
Subject: [WATCHDOG] v2.6.13 watchdog-patches
Message-ID: <20050903200443.GO19487@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/Kconfig        |   43 ++++++++---------
 drivers/char/watchdog/Makefile       |   71 +++++++++++++++++++---------
 drivers/char/watchdog/ixp2000_wdt.c  |    2 
 drivers/char/watchdog/ixp4xx_wdt.c   |    2 
 drivers/char/watchdog/s3c2410_wdt.c  |   87 ++++++++++++++++++++++-------------
 drivers/char/watchdog/scx200_wdt.c   |    2 
 drivers/char/watchdog/softdog.c      |   13 +++--
 drivers/char/watchdog/w83627hf_wdt.c |    6 ++
 8 files changed, 143 insertions(+), 83 deletions(-)

with these Changes:

Author: Chuck Ebbert <76306.1226@compuserve.com>
Date:   Fri Aug 19 14:14:07 2005 +0200

    [WATCHDOG] softdog-timer-running-oops.patch
    
    The softdog watchdog timer has a bug that can create an oops:
    
    1.  Load the module without the nowayout option.
    2.  Open the driver and close it without writing 'V' before close.
    3.  Unload the module.  The timer will continue to run...
    4.  Oops happens when timer fires.
    
    Reported Sun, 10 Oct 2004, by Michael Schierl <schierlm@gmx.de>
    
    Fix is easy: always take a reference on the module on open.
    Release it only when the device is closed and no timer is running.
    Tested on 2.6.13-rc6 using the soft_noboot option.  While the
    timer is running and the device is closed, the module use count
    stays at 1.  After the timer fires, it drops to 0.  Repeatedly
    opening and closing the driver caused no problems.  Please apply.
    
    Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: P@Draig Brady <P@draigBrady.com>
Date:   Wed Aug 17 09:06:07 2005 +0200

    [WATCHDOG] w83627hf_wdt.c-initialized_bios_bug
    
    Attached is a small update to the w83627hf watchdog driver
    to initialise appropriately if it was already initialised
    in the BIOS. On tyan motherboards for e.g. you can init
    the watchdog to 4 mins, then when the driver is loaded it
    sets the watchdog to "seconds" mode, and then machine will
    reboot within 4 seconds. So this patch resets the timeout
    to the configured value if the watchdog is already running.
    
    Signed-off-by: P@draig Brady <P@draigBrady.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Wed Aug 17 09:04:52 2005 +0200

    [WATCHDOG] s3c2410 watchdog - replace reboot notifier
    
    Patch from Dimitry Andric <dimitry.andric@tomtom.com>
    
    Change to using platfrom driver's .shutdown method instead
    of an reboot notifier
    
    Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Wed Aug 17 09:03:23 2005 +0200

    [WATCHDOG] s3c2410 watchdog power management
    
    Patch from Dimitry Andric <dimitry.andric@tomtom.com>, updated
    by Ben Dooks <ben-linux@fluff.org>. Patch is against 2.6.11-mm2
    
    Add power management support to the s3c2410 watchdog, so that
    it is shut-down over suspend, and re-initialised on resume.
    
    Also add Dimitry to the list of authors.
    
    Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Olaf Hering <olh@suse.de>
Date:   Wed Aug 17 08:58:34 2005 +0200

    [WATCHDOG] correct sysfs name for watchdog devices
    
    While looking for possible candidates for our udev.rules package,
    I found a few odd ->name properties. /dev/watchdog has minor 130
    according to devices.txt. Since all watchdog drivers use the
    misc_register() call, they will end up in /sys/class/misc/$foo.
    udev may create the /dev/watchdog node if the driver is loaded.
    I dont have such a device, so I cant test it.
    The drivers below provide names with spaces and even with / in it.
    Not a big deal, but apps may expect /dev/watchdog.
    
    Signed-off-by: Olaf Hering <olh@suse.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 3 13:46:56 2005 +0200

    [WATCHDOG] Kconfig+Makefile-clean
    
    Clean the Kconfig+Makefile according to a sorted list
    of the drivers of each architecture (and sub-architecture).
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Wed Aug 17 01:49:24 2005 +0200

    [WATCHDOG] Makefile-probe_order-patch
    
    Re-arrange Makefile according to what we want to probe first.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -84,6 +84,17 @@ config 977_WATCHDOG
 
 	  Not sure? It's safe to say N.
 
+config IXP2000_WATCHDOG
+	tristate "IXP2000 Watchdog"
+	depends on WATCHDOG && ARCH_IXP2000
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in the Intel IXP2000(2400, 2800, 2850) network processors.
+	  This driver can be built as a module by choosing M. The module
+	  will be called ixp2000_wdt.
+
+	  Say N if you are unsure.
+
 config IXP4XX_WATCHDOG
 	tristate "IXP4xx Watchdog"
 	depends on WATCHDOG && ARCH_IXP4XX
@@ -100,17 +111,6 @@ config IXP4XX_WATCHDOG
 
 	  Say N if you are unsure.
 
-config IXP2000_WATCHDOG
-	tristate "IXP2000 Watchdog"
-	depends on WATCHDOG && ARCH_IXP2000
-	help
-	  Say Y here if to include support for the watchdog timer
-	  in the Intel IXP2000(2400, 2800, 2850) network processors.
-	  This driver can be built as a module by choosing M. The module
-	  will be called ixp2000_wdt.
-
-	  Say N if you are unsure.
-
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
 	depends on WATCHDOG && ARCH_S3C2410
@@ -346,6 +346,17 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+# PPC64 Architecture
+
+config WATCHDOG_RTAS
+	tristate "RTAS watchdog"
+	depends on WATCHDOG && PPC_RTAS
+	help
+	  This driver adds watchdog support for the RTAS watchdog.
+
+          To compile this driver as a module, choose M here. The module
+	  will be called wdrtas.
+
 # MIPS Architecture
 
 config INDYDOG
@@ -414,16 +425,6 @@ config WATCHDOG_RIO
 	  machines.  The watchdog timeout period is normally one minute but
 	  can be changed with a boot-time parameter.
 
-# ppc64 RTAS watchdog
-config WATCHDOG_RTAS
-	tristate "RTAS watchdog"
-	depends on WATCHDOG && PPC_RTAS
-	help
-	  This driver adds watchdog support for the RTAS watchdog.
-
-          To compile this driver as a module, choose M here. The module
-	  will be called wdrtas.
-
 #
 # ISA-based Watchdog Cards
 #
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -2,42 +2,67 @@
 # Makefile for the WatchDog device drivers.
 #
 
+# Only one watchdog can succeed. We probe the ISA/PCI/USB based
+# watchdog-cards first, then the architecture specific watchdog
+# drivers and then the architecture independant "softdog" driver.
+# This means that if your ISA/PCI/USB card isn't detected that
+# you can fall back to an architecture specific driver and if
+# that also fails then you can fall back to the software watchdog
+# to give you some cover.
+
+# ISA-based Watchdog Cards
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
-obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
-obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
-obj-$(CONFIG_IB700_WDT) += ib700wdt.o
 obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
-obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
-obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_WDT) += wdt.o
+
+# PCI-based Watchdog Cards
+obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
 obj-$(CONFIG_WDTPCI) += wdt_pci.o
+
+# USB-based Watchdog Cards
+obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
+
+# ARM Architecture
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
-obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
-obj-$(CONFIG_MACHZ_WDT) += machzwd.o
-obj-$(CONFIG_SH_WDT) += shwdt.o
+obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
+obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
-obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
-obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
-obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
-obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
-obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
+
+# X86 (i386 + ia64 + x86_64) Architecture
+obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
+obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
 obj-$(CONFIG_ALIM1535_WDT) += alim1535_wdt.o
-obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
+obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
+obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
+obj-$(CONFIG_IB700_WDT) += ib700wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
+obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
+obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
+obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
-obj-$(CONFIG_INDYDOG) += indydog.o
-obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
-obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
-obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
-obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
+obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
+obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
+obj-$(CONFIG_MACHZ_WDT) += machzwd.o
+
+# PowerPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+
+# PPC64 Architecture
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
 
-# Only one watchdog can succeed. We probe the hardware watchdog
-# drivers first, then the softdog driver.  This means if your hardware
-# watchdog dies or is 'borrowed' for some reason the software watchdog
-# still gives you some cover.
+# MIPS Architecture
+obj-$(CONFIG_INDYDOG) += indydog.o
+
+# S390 Architecture
+
+# SUPERH Architecture
+obj-$(CONFIG_SH_WDT) += shwdt.o
+
+# SPARC64 Architecture
 
+# Architecture Independant
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
diff --git a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
--- a/drivers/char/watchdog/ixp2000_wdt.c
+++ b/drivers/char/watchdog/ixp2000_wdt.c
@@ -182,7 +182,7 @@ static struct file_operations ixp2000_wd
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff --git a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c
+++ b/drivers/char/watchdog/ixp4xx_wdt.c
@@ -176,7 +176,7 @@ static struct file_operations ixp4xx_wdt
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -27,7 +27,10 @@
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
  *
- *	11-Jan-2004	BJD	Fixed divide-by-2 in timeout code
+ *	11-Jan-2005	BJD	Fixed divide-by-2 in timeout code
+ *
+ *	25-Jan-2005	DA	Added suspend/resume support
+ *				Replaced reboot notifier with .shutdown method
  *
  *	10-Mar-2005	LCVR	Changed S3C2410_VA to S3C24XX_VA
 */
@@ -40,8 +43,6 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/fs.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -317,20 +318,6 @@ static int s3c2410wdt_ioctl(struct inode
 	}
 }
 
-/*
- *	Notifier for system down
- */
-
-static int s3c2410wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			      void *unused)
-{
-	if(code==SYS_DOWN || code==SYS_HALT) {
-		/* Turn the WDT off */
-		s3c2410wdt_stop();
-	}
-	return NOTIFY_DONE;
-}
-
 /* kernel interface */
 
 static struct file_operations s3c2410wdt_fops = {
@@ -348,10 +335,6 @@ static struct miscdevice s3c2410wdt_misc
 	.fops		= &s3c2410wdt_fops,
 };
 
-static struct notifier_block s3c2410wdt_notifier = {
-	.notifier_call	= s3c2410wdt_notify_sys,
-};
-
 /* interrupt handler code */
 
 static irqreturn_t s3c2410wdt_irq(int irqno, void *param,
@@ -432,18 +415,10 @@ static int s3c2410wdt_probe(struct devic
 		}
 	}
 
-	ret = register_reboot_notifier(&s3c2410wdt_notifier);
-	if (ret) {
-		printk (KERN_ERR PFX "cannot register reboot notifier (%d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = misc_register(&s3c2410wdt_miscdev);
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
-		unregister_reboot_notifier(&s3c2410wdt_notifier);
 		return ret;
 	}
 
@@ -479,15 +454,63 @@ static int s3c2410wdt_remove(struct devi
 	return 0;
 }
 
+static void s3c2410wdt_shutdown(struct device *dev)
+{
+	s3c2410wdt_stop();	
+}
+
+#ifdef CONFIG_PM
+
+static unsigned long wtcon_save;
+static unsigned long wtdat_save;
+
+static int s3c2410wdt_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_POWER_DOWN) {
+		/* Save watchdog state, and turn it off. */
+		wtcon_save = readl(wdt_base + S3C2410_WTCON);
+		wtdat_save = readl(wdt_base + S3C2410_WTDAT);
+
+		/* Note that WTCNT doesn't need to be saved. */
+		s3c2410wdt_stop();
+	}
+
+	return 0;
+}
+
+static int s3c2410wdt_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON) {
+		/* Restore watchdog state. */
+
+		writel(wtdat_save, wdt_base + S3C2410_WTDAT);
+		writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
+		writel(wtcon_save, wdt_base + S3C2410_WTCON);
+
+		printk(KERN_INFO PFX "watchdog %sabled\n",
+		       (wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
+	}
+
+	return 0;
+}
+
+#else
+#define s3c2410wdt_suspend NULL
+#define s3c2410wdt_resume  NULL
+#endif /* CONFIG_PM */
+
+
 static struct device_driver s3c2410wdt_driver = {
 	.name		= "s3c2410-wdt",
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.shutdown	= s3c2410wdt_shutdown,
+	.suspend	= s3c2410wdt_suspend,
+	.resume		= s3c2410wdt_resume,
 };
 
 
-
 static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics\n";
 
 static int __init watchdog_init(void)
@@ -499,13 +522,13 @@ static int __init watchdog_init(void)
 static void __exit watchdog_exit(void)
 {
 	driver_unregister(&s3c2410wdt_driver);
-	unregister_reboot_notifier(&s3c2410wdt_notifier);
 }
 
 module_init(watchdog_init);
 module_exit(watchdog_exit);
 
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
+	      "Dimitry Andric <dimitry.andric@tomtom.com>");
 MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c
+++ b/drivers/char/watchdog/scx200_wdt.c
@@ -206,7 +206,7 @@ static struct file_operations scx200_wdt
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 
diff --git a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c
+++ b/drivers/char/watchdog/softdog.c
@@ -77,7 +77,7 @@ static void watchdog_fire(unsigned long)
 
 static struct timer_list watchdog_ticktock =
 		TIMER_INITIALIZER(watchdog_fire, 0, 0);
-static unsigned long timer_alive;
+static unsigned long driver_open, orphan_timer;
 static char expect_close;
 
 
@@ -87,6 +87,9 @@ static char expect_close;
 
 static void watchdog_fire(unsigned long data)
 {
+	if (test_and_clear_bit(0, &orphan_timer))
+		module_put(THIS_MODULE);
+
 	if (soft_noboot)
 		printk(KERN_CRIT PFX "Triggered - Reboot ignored.\n");
 	else
@@ -128,9 +131,9 @@ static int softdog_set_heartbeat(int t)
 
 static int softdog_open(struct inode *inode, struct file *file)
 {
-	if(test_and_set_bit(0, &timer_alive))
+	if (test_and_set_bit(0, &driver_open))
 		return -EBUSY;
-	if (nowayout)
+	if (!test_and_clear_bit(0, &orphan_timer))
 		__module_get(THIS_MODULE);
 	/*
 	 *	Activate timer
@@ -147,11 +150,13 @@ static int softdog_release(struct inode 
 	 */
 	if (expect_close == 42) {
 		softdog_stop();
+		module_put(THIS_MODULE);
 	} else {
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		set_bit(0, &orphan_timer);
 		softdog_keepalive();
 	}
-	clear_bit(0, &timer_alive);
+	clear_bit(0, &driver_open);
 	expect_close = 0;
 	return 0;
 }
diff --git a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c
+++ b/drivers/char/watchdog/w83627hf_wdt.c
@@ -93,6 +93,12 @@ w83627hf_init(void)
 
 	w83627hf_select_wd_register();
 
+	outb_p(0xF6, WDT_EFER); /* Select CRF6 */
+	t=inb_p(WDT_EFDR);      /* read CRF6 */
+	if (t != 0) {
+		printk (KERN_INFO PFX "Watchdog already running. Resetting timeout to %d sec\n", timeout);
+		outb_p(timeout, WDT_EFDR);    /* Write back to CRF6 */
+	}
 	outb_p(0xF5, WDT_EFER); /* Select CRF5 */
 	t=inb_p(WDT_EFDR);      /* read CRF5 */
 	t&=~0x0C;               /* set second mode & disable keyboard turning off watchdog */
