Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263215AbVCEQaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbVCEQaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbVCEQZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:25:54 -0500
Received: from europa.telenet-ops.be ([195.130.132.60]:48063 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262979AbVCEQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:12:10 -0500
Date: Sat, 5 Mar 2005 17:12:07 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.11-mm watchdog patches
Message-ID: <20050305161206.GH6650@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog-mm

This will update the following files:

 drivers/char/watchdog/Kconfig       |   14 
 drivers/char/watchdog/Makefile      |    2 
 drivers/char/watchdog/i6300esb.c    |  508 ++++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/i6300esb.h    |   62 ++++
 drivers/char/watchdog/ixp2000_wdt.c |    2 
 drivers/char/watchdog/ixp4xx_wdt.c  |    2 
 drivers/char/watchdog/mv64x60_wdt.c |  252 +++++++++++++++++
 drivers/char/watchdog/pcwd_usb.c    |    9 
 drivers/char/watchdog/s3c2410_wdt.c |    8 
 drivers/char/watchdog/sa1100_wdt.c  |    2 
 drivers/char/watchdog/scx200_wdt.c  |    2 
 include/asm-ppc/mv64x60.h           |    8 
 12 files changed, 858 insertions(+), 13 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/03/05 1.2122)
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

<wim@iguana.be> (05/03/05 1.2123)
   [WATCHDOG] pcwd_usb: usb_control_msg-timeout-patch
   
   set timeout in usb_control_msg to USB_COMMAND_TIMEOUT instead of a 
   full second.

<ben-linux@fluff.org> (05/03/05 1.2124)
   [WATCHDOG] s3c2410-divide-patch
   
   The s3c2410 watchdog driver has an incorrect /2
   in the timer calculation, fix this problem
   
   Signed-off-by: Ben Dooks <ben-linux@fluff.org>

<jchapman@katalix.com> (05/03/05 1.2125)
   [WATCHDOG] mv64x60_wdt.patch
   
   Add mv64x60 (Marvell Discovery) watchdog support.
   
   Signed-off-by: James Chapman <jchapman@katalix.com>

<david@2gen.com> (05/03/05 1.2126)
   [WATCHDOG] i6300esb.patch
   
   From: David Hardeman <david@2gen.com>
   
   I wrote earlier to the list[1] asking for a driver for the watchdog
   included in the 6300ESB chipset.  I got a 2.4 driver via private email
   from Ross Biro which I've changed into what I hope resembles a 2.6
   driver (which was done by looking a lot at the watchdog drivers
   already in the 2.6 tree).
   
   I've attached the result, and I'm hoping to get some feedback on the
   coding as a first step.  I can't actually test it on the hardware
   right now as I won't have physical access until April. So my own tests
   have been limited to "compiles-without-warnings" and 
   "can-be-insmodded-in-other-machine-without-oops".
   
   [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=110711079825794&w=2
   [2] http://marc.theaimsgroup.com/?l=linux-kernel&m=110711973917746&w=2
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog-mm

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
--- a/drivers/char/watchdog/ixp2000_wdt.c	2005-03-05 17:04:16 +01:00
+++ b/drivers/char/watchdog/ixp2000_wdt.c	2005-03-05 17:04:16 +01:00
@@ -186,7 +186,7 @@
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c	2005-03-05 17:04:16 +01:00
+++ b/drivers/char/watchdog/ixp4xx_wdt.c	2005-03-05 17:04:16 +01:00
@@ -180,7 +180,7 @@
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	2005-03-05 17:04:16 +01:00
+++ b/drivers/char/watchdog/sa1100_wdt.c	2005-03-05 17:04:16 +01:00
@@ -176,7 +176,7 @@
 static struct miscdevice sa1100dog_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "SA1100/PXA2xx watchdog",
+	.name		= "watchdog",
 	.fops		= &sa1100dog_fops,
 };
 
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	2005-03-05 17:04:16 +01:00
+++ b/drivers/char/watchdog/scx200_wdt.c	2005-03-05 17:04:16 +01:00
@@ -210,7 +210,7 @@
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	2005-03-05 17:04:19 +01:00
+++ b/drivers/char/watchdog/pcwd_usb.c	2005-03-05 17:04:19 +01:00
@@ -1,7 +1,7 @@
 /*
  *	Berkshire USB-PC Watchdog Card Driver
  *
- *	(c) Copyright 2004 Wim Van Sebroeck <wim@iguana.be>.
+ *	(c) Copyright 2004-2005 Wim Van Sebroeck <wim@iguana.be>.
  *
  *	Based on source code of the following authors:
  *	  Ken Hollis <kenji@bitgate.com>,
@@ -33,6 +33,7 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
@@ -56,8 +57,8 @@
 
 
 /* Module and Version Information */
-#define DRIVER_VERSION "1.00"
-#define DRIVER_DATE "12 Jun 2004"
+#define DRIVER_VERSION "1.01"
+#define DRIVER_DATE "05 Mar 2005"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
 #define DRIVER_LICENSE "GPL"
@@ -227,7 +228,7 @@
 	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
 			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
-			HZ) != sizeof(buf)) {
+			msecs_to_jiffies(USB_COMMAND_TIMEOUT)) != sizeof(buf)) {
 		dbg("usb_pcwd_send_command: error in usb_control_msg for cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
 	}
 	/* wait till the usb card processed the command,
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2005-03-05 17:04:22 +01:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2005-03-05 17:04:22 +01:00
@@ -26,6 +26,8 @@
  *	05-Oct-2004	BJD	Added semaphore init to stop crashes on open
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
+ *
+ *	11-Jan-2004	BJD	Fixed divide-by-2 in timeout code
 */
 
 #include <linux/module.h>
@@ -163,11 +165,7 @@
 	if (timeout < 1)
 		return -EINVAL;
 
-	/* I think someone must have missed a divide-by-2 in the 2410,
-	 * as a divisor of 128 gives half the calculated delay...
-	 */
-
-	freq /= 128/2;
+	freq /= 128;
 	count = timeout * freq;
 
 	DBG("%s: count=%d, timeout=%d, freq=%d\n",
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2005-03-05 17:04:25 +01:00
+++ b/drivers/char/watchdog/Kconfig	2005-03-05 17:04:25 +01:00
@@ -346,6 +346,10 @@
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config MV64X60_WDT
+	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
+	depends on WATCHDOG && MV64X60
+
 # MIPS Architecture
 
 config INDYDOG
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-05 17:04:25 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-05 17:04:25 +01:00
@@ -39,3 +39,4 @@
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
diff -Nru a/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/mv64x60_wdt.c	2005-03-05 17:04:25 +01:00
@@ -0,0 +1,252 @@
+/*
+ * mv64x60_wdt.c - MV64X60 (Marvell Discovery) watchdog userspace interface
+ *
+ * Author: James Chapman <jchapman@katalix.com>
+ *
+ * Platform-specific setup code should configure the dog to generate
+ * interrupt or reset as required.  This code only enables/disables
+ * and services the watchdog.
+ *
+ * Derived from mpc8xx_wdt.c, with the following copyright.
+ * 
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <asm/mv64x60.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+/* MV64x60 WDC (config) register access definitions */
+#define MV64x60_WDC_CTL1_MASK	(3 << 24)
+#define MV64x60_WDC_CTL1(val)	((val & 3) << 24)
+#define MV64x60_WDC_CTL2_MASK	(3 << 26)
+#define MV64x60_WDC_CTL2(val)	((val & 3) << 26)
+
+/* Flags bits */
+#define MV64x60_WDOG_FLAG_OPENED	0
+#define MV64x60_WDOG_FLAG_ENABLED	1
+
+static unsigned long wdt_flags;
+static int wdt_status;
+static void __iomem *mv64x60_regs;
+static int mv64x60_wdt_timeout;
+
+static void mv64x60_wdt_reg_write(u32 val)
+{
+	/* Allow write only to CTL1 / CTL2 fields, retaining values in
+	 * other fields.
+	 */
+	u32 data = readl(mv64x60_regs + MV64x60_WDT_WDC);
+	data &= ~(MV64x60_WDC_CTL1_MASK | MV64x60_WDC_CTL2_MASK);
+	data |= val;
+	writel(data, mv64x60_regs + MV64x60_WDT_WDC);
+}
+
+static void mv64x60_wdt_service(void)
+{
+	/* Write 01 followed by 10 to CTL2 */
+	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x01));
+	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x02));
+}
+
+static void mv64x60_wdt_handler_disable(void)
+{
+	if (test_and_clear_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
+		/* Write 01 followed by 10 to CTL1 */
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
+		printk(KERN_NOTICE "mv64x60_wdt: watchdog deactivated\n");
+	}
+}
+
+static void mv64x60_wdt_handler_enable(void)
+{
+	if (!test_and_set_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
+		/* Write 01 followed by 10 to CTL1 */
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
+		printk(KERN_NOTICE "mv64x60_wdt: watchdog activated\n");
+	}
+}
+
+static int mv64x60_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags))
+		return -EBUSY;
+
+	mv64x60_wdt_service();
+	mv64x60_wdt_handler_enable();
+
+	return 0;
+}
+
+static int mv64x60_wdt_release(struct inode *inode, struct file *file)
+{
+	mv64x60_wdt_service();
+
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	mv64x60_wdt_handler_disable();
+#endif
+
+	clear_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags);
+
+	return 0;
+}
+
+static ssize_t mv64x60_wdt_write(struct file *file, const char *data,
+				 size_t len, loff_t * ppos)
+{
+	if (*ppos != file->f_pos)
+		return -ESPIPE;
+
+	if (len)
+		mv64x60_wdt_service();
+
+	return len;
+}
+
+static int mv64x60_wdt_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	int timeout;
+	static struct watchdog_info info = {
+		.options = WDIOF_KEEPALIVEPING,
+		.firmware_version = 0,
+		.identity = "MV64x60 watchdog",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		if (put_user(wdt_status, (int *)arg))
+			return -EFAULT;
+		wdt_status &= ~WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_GETTEMP:
+		return -EOPNOTSUPP;
+
+	case WDIOC_SETOPTIONS:
+		return -EOPNOTSUPP;
+
+	case WDIOC_KEEPALIVE:
+		mv64x60_wdt_service();
+		wdt_status |= WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		return -EOPNOTSUPP;
+
+	case WDIOC_GETTIMEOUT:
+		timeout = mv64x60_wdt_timeout * HZ;
+		if (put_user(timeout, (int *)arg))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static struct file_operations mv64x60_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = mv64x60_wdt_write,
+	.ioctl = mv64x60_wdt_ioctl,
+	.open = mv64x60_wdt_open,
+	.release = mv64x60_wdt_release,
+};
+
+static struct miscdevice mv64x60_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &mv64x60_wdt_fops,
+};
+
+static int __devinit mv64x60_wdt_probe(struct device *dev)
+{
+	struct platform_device *pd = to_platform_device(dev);
+	struct mv64x60_wdt_pdata *pdata = pd->dev.platform_data;
+	int bus_clk = 133;
+
+	mv64x60_wdt_timeout = 10;
+	if (pdata) {
+		mv64x60_wdt_timeout = pdata->timeout;
+		bus_clk = pdata->bus_clk;
+	}
+
+	mv64x60_regs = mv64x60_get_bridge_vbase();
+
+	writel((mv64x60_wdt_timeout * (bus_clk * 1000000)) >> 8,
+	       mv64x60_regs + MV64x60_WDT_WDC);
+
+	return misc_register(&mv64x60_wdt_miscdev);
+}
+
+static int __devexit mv64x60_wdt_remove(struct device *dev)
+{
+	misc_deregister(&mv64x60_wdt_miscdev);
+
+	mv64x60_wdt_service();
+	mv64x60_wdt_handler_disable();
+
+	return 0;
+}
+
+static struct device_driver mv64x60_wdt_driver = {
+	.name = MV64x60_WDT_NAME,
+	.bus = &platform_bus_type,
+	.probe = mv64x60_wdt_probe,
+	.remove = __devexit_p(mv64x60_wdt_remove),
+};
+
+static struct platform_device *mv64x60_wdt_dev;
+
+static int __init mv64x60_wdt_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "MV64x60 watchdog driver\n");
+
+	mv64x60_wdt_dev = platform_device_register_simple(MV64x60_WDT_NAME,
+							  -1, NULL, 0);
+	if (IS_ERR(mv64x60_wdt_dev)) {
+		ret = PTR_ERR(mv64x60_wdt_dev);
+		goto out;
+	}
+
+	ret = driver_register(&mv64x60_wdt_driver);
+      out:
+	return ret;
+}
+
+static void __exit mv64x60_wdt_exit(void)
+{
+	driver_unregister(&mv64x60_wdt_driver);
+	platform_device_unregister(mv64x60_wdt_dev);
+}
+
+module_init(mv64x60_wdt_init);
+module_exit(mv64x60_wdt_exit);
+
+MODULE_AUTHOR("James Chapman <jchapman@katalix.com>");
+MODULE_DESCRIPTION("MV64x60 watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff -Nru a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
--- a/include/asm-ppc/mv64x60.h	2005-03-05 17:04:25 +01:00
+++ b/include/asm-ppc/mv64x60.h	2005-03-05 17:04:25 +01:00
@@ -119,6 +119,14 @@
 
 #define	MV64x60_64BIT_WIN_COUNT			24
 
+/* Watchdog Platform Device, Driver Data */
+#define	MV64x60_WDT_NAME			"wdt"
+
+struct mv64x60_wdt_pdata {
+	int	timeout;	/* watchdog expiry in seconds, default 10 */
+	int	bus_clk;	/* bus clock in MHz, default 133 */
+};
+
 /*
  * Define a structure that's used to pass in config information to the
  * core routines.
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2005-03-05 17:04:28 +01:00
+++ b/drivers/char/watchdog/Kconfig	2005-03-05 17:04:28 +01:00
@@ -252,6 +252,16 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called i8xx_tco.
 
+config I6300ESB_WDT
+	tristate "Intel 6300ESB Timer/Watchdog"
+	depends on WATCHDOG && X86 && PCI
+	---help---
+	  Hardware driver for the watchdog timer built into the Intel
+	  6300ESB controller hub.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called i6300esb.
+
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
 	depends on WATCHDOG && X86
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-05 17:04:28 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-05 17:04:28 +01:00
@@ -19,6 +19,7 @@
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
+obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
diff -Nru a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/i6300esb.c	2005-03-05 17:04:28 +01:00
@@ -0,0 +1,508 @@
+/*
+ *	i6300esb 0.03:	Watchdog timer driver for Intel 6300ESB chipset
+ *
+ *	(c) Copyright 2004 Google Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *      based on i810-tco.c which is
+ *
+ *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
+ *				developed for
+ *                              Jentro AG, Haar/Munich (Germany)
+ *
+ * 	which is in turn based on softdog.c by Alan Cox <alan@redhat.com>
+ *
+ * 	The timer is implemented in the following I/O controller hubs:
+ * 	(See the intel documentation on http://developer.intel.com.)
+ * 	6300ESB chip : document number 300641-003
+ *
+ *  2004YYZZ Ross Biro
+ *	Initial version 0.01
+ *  2004YYZZ Ross Biro
+ *  	Version 0.02
+ *  20050210 David Härdeman <david@2gen.com>
+ *      Ported driver to kernel 2.6
+ */
+
+/*
+ *      Includes, defines, variables, module parameters, ...
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include "i6300esb.h"
+
+/* Module and version information */
+#define ESB_VERSION "0.03"
+#define ESB_MODULE_NAME "i6300ESB timer"
+#define ESB_DRIVER_NAME ESB_MODULE_NAME ", v" ESB_VERSION
+#define PFX ESB_MODULE_NAME ": "
+
+/* internal variables */
+static void __iomem *BASEADDR;
+static spinlock_t esb_lock; /* Guards the hardware */
+static unsigned long timer_alive;
+static struct pci_dev *esb_pci;
+static unsigned short triggered; /* The status of the watchdog upon boot */
+static char esb_expect_close;
+
+/* module parameters */
+#define WATCHDOG_HEARTBEAT 30   /* 30 sec default heartbeat (1<heartbeat<2*1023) */
+static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (1<heartbeat<2046, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ * Some i6300ESB specific functions
+ */
+
+/*
+ * Prepare for reloading the timer by unlocking the proper registers.
+ * This is performed by first writing 0x80 followed by 0x86 to the
+ * reload register. After this the appropriate registers can be written
+ * to once before they need to be unlocked again.
+ */
+static inline void esb_unlock_registers(void) {
+        writeb(ESB_UNLOCK1, ESB_RELOAD_REG);
+        writeb(ESB_UNLOCK2, ESB_RELOAD_REG);
+}
+
+static void esb_timer_start(void)
+{
+	u8 val;
+
+	/* Enable or Enable + Lock? */
+	val = 0x02 | nowayout ? 0x01 : 0x00;
+
+        pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
+}
+
+static int esb_timer_stop(void)
+{
+	u8 val;
+
+	spin_lock(&esb_lock);
+	/* First, reset timers as suggested by the docs */
+	esb_unlock_registers();
+	writew(0x10, ESB_RELOAD_REG);
+	/* Then disable the WDT */
+	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
+	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
+	spin_unlock(&esb_lock);
+
+	/* Returns 0 if the timer was disabled, non-zero otherwise */
+	return (val & 0x01);
+}
+
+static void esb_timer_keepalive(void)
+{
+	spin_lock(&esb_lock);
+	esb_unlock_registers();
+	writew(0x10, ESB_RELOAD_REG);
+        /* FIXME: Do we need to flush anything here? */
+	spin_unlock(&esb_lock);
+}
+
+static int esb_timer_set_heartbeat(int time)
+{
+	u32 val;
+
+	if (time < 0x1 || time > (2 * 0x03ff))
+		return -EINVAL;
+
+	spin_lock(&esb_lock);
+
+	/* We shift by 9, so if we are passed a value of 1 sec,
+	 * val will be 1 << 9 = 512, then write that to two
+	 * timers => 2 * 512 = 1024 (which is decremented at 1KHz)
+	 */
+	val = time << 9;
+
+	/* Write timer 1 */
+	esb_unlock_registers();
+	writel(val, ESB_TIMER1_REG);
+
+	/* Write timer 2 */
+	esb_unlock_registers();
+        writel(val, ESB_TIMER2_REG);
+
+        /* Reload */
+	esb_unlock_registers();
+	writew(0x10, ESB_RELOAD_REG);
+
+	/* FIXME: Do we need to flush everything out? */
+
+	/* Done */
+	heartbeat = time;
+	spin_unlock(&esb_lock);
+	return 0;
+}
+
+static int esb_timer_read (void)
+{
+       	u32 count;
+
+	/* This isn't documented, and doesn't take into
+         * acount which stage is running, but it looks
+         * like a 20 bit count down, so we might as well report it.
+         */
+        pci_read_config_dword(esb_pci, 0x64, &count);
+        return (int)count;
+}
+
+/*
+ * 	/dev/watchdog handling
+ */
+
+static int esb_open (struct inode *inode, struct file *file)
+{
+        /* /dev/watchdog can only be opened once */
+        if (test_and_set_bit(0, &timer_alive))
+                return -EBUSY;
+
+        /* Reload and activate timer */
+        esb_timer_keepalive ();
+        esb_timer_start ();
+
+	return nonseekable_open(inode, file);
+}
+
+static int esb_release (struct inode *inode, struct file *file)
+{
+        /* Shut off the timer. */
+        if (esb_expect_close == 42) {
+                esb_timer_stop ();
+        } else {
+                printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+                esb_timer_keepalive ();
+        }
+        clear_bit(0, &timer_alive);
+        esb_expect_close = 0;
+        return 0;
+}
+
+static ssize_t esb_write (struct file *file, const char __user *data,
+			  size_t len, loff_t * ppos)
+{
+	/* See if we got the magic character 'V' and reload the timer */
+        if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* note: just in case someone wrote the magic character
+			 * five months ago... */
+			esb_expect_close = 0;
+
+			/* scan to see whether or not we got the magic character */
+			for (i = 0; i != len; i++) {
+				char c;
+				if(get_user(c, data+i))
+					return -EFAULT;
+				if (c == 'V')
+					esb_expect_close = 42;
+			}
+		}
+
+		/* someone wrote to us, we should reload the timer */
+		esb_timer_keepalive ();
+	}
+	return len;
+}
+
+static int esb_ioctl (struct inode *inode, struct file *file,
+		      unsigned int cmd, unsigned long arg)
+{
+	int new_options, retval = -EINVAL;
+	int new_heartbeat;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	static struct watchdog_info ident = {
+		.options =              WDIOF_SETTIMEOUT |
+					WDIOF_KEEPALIVEPING |
+					WDIOF_MAGICCLOSE,
+		.firmware_version =     0,
+		.identity =             ESB_MODULE_NAME,
+	};
+
+	switch (cmd) {
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &ident,
+					    sizeof (ident)) ? -EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+			return put_user (esb_timer_read(), p);
+
+		case WDIOC_GETBOOTSTATUS:
+			return put_user (triggered, p);
+
+                case WDIOC_KEEPALIVE:
+                        esb_timer_keepalive ();
+                        return 0;
+
+                case WDIOC_SETOPTIONS:
+                {
+                        if (get_user (new_options, p))
+                                return -EFAULT;
+
+                        if (new_options & WDIOS_DISABLECARD) {
+                                esb_timer_stop ();
+                                retval = 0;
+                        }
+
+                        if (new_options & WDIOS_ENABLECARD) {
+                                esb_timer_keepalive ();
+                                esb_timer_start ();
+                                retval = 0;
+                        }
+
+                        return retval;
+                }
+
+                case WDIOC_SETTIMEOUT:
+                {
+                        if (get_user(new_heartbeat, p))
+                                return -EFAULT;
+
+                        if (esb_timer_set_heartbeat(new_heartbeat))
+                            return -EINVAL;
+
+                        esb_timer_keepalive ();
+                        /* Fall */
+                }
+
+                case WDIOC_GETTIMEOUT:
+                        return put_user(heartbeat, p);
+
+                default:
+                        return -ENOIOCTLCMD;
+        }
+}
+
+/*
+ *      Notify system
+ */
+
+static int esb_notify_sys (struct notifier_block *this, unsigned long code, void *unused)
+{
+        if (code==SYS_DOWN || code==SYS_HALT) {
+                /* Turn the WDT off */
+                esb_timer_stop ();
+        }
+
+        return NOTIFY_DONE;
+}
+
+/*
+ *      Kernel Interfaces
+ */
+
+static struct file_operations esb_fops = {
+        .owner =        THIS_MODULE,
+        .llseek =       no_llseek,
+        .write =        esb_write,
+        .ioctl =        esb_ioctl,
+        .open =         esb_open,
+        .release =      esb_release,
+};
+
+static struct miscdevice esb_miscdev = {
+        .minor =        WATCHDOG_MINOR,
+        .name =         "watchdog",
+        .fops =         &esb_fops,
+};
+
+static struct notifier_block esb_notifier = {
+        .notifier_call =        esb_notify_sys,
+};
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id esb_pci_tbl[] = {
+        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_9, PCI_ANY_ID, PCI_ANY_ID, },
+        { 0, },                 /* End of list */
+};
+MODULE_DEVICE_TABLE (pci, esb_pci_tbl);
+
+/*
+ *      Init & exit routines
+ */
+
+static unsigned char __init esb_getdevice (void)
+{
+	u8 val1;
+	unsigned short val2;
+
+        struct pci_dev *dev = NULL;
+        /*
+         *      Find the PCI device
+         */
+
+        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+                if (pci_match_device(esb_pci_tbl, dev)) {
+                        esb_pci = dev;
+                        break;
+                }
+        }
+
+        if (esb_pci) {
+        	if (pci_enable_device(esb_pci)) {
+			printk (KERN_ERR PFX "failed to enable device\n");
+			goto out;
+		}
+
+		if (pci_request_region(esb_pci, 0, ESB_MODULE_NAME)) {
+			printk (KERN_ERR PFX "failed to request region\n");
+			goto err_disable;
+		}
+
+		BASEADDR = ioremap(pci_resource_start(esb_pci, 0),
+				   pci_resource_len(esb_pci, 0));
+		if (BASEADDR == NULL) {
+                	/* Something's wrong here, BASEADDR has to be set */
+			printk (KERN_ERR PFX "failed to get BASEADDR\n");
+                        goto err_release;
+                }
+
+		/*
+		 * The watchdog has two timers, it can be setup so that the
+		 * expiry of timer1 results in an interrupt and the expiry of
+		 * timer2 results in a reboot. We set it to not generate
+		 * any interrupts as there is not much we can do with it
+		 * right now.
+		 *
+		 * We also enable reboots and set the timer frequency to
+		 * the PCI clock divided by 2^15 (approx 1KHz).
+		 */
+		pci_write_config_word(esb_pci, ESB_CONFIG_REG, 0x0003);
+
+		/* Check that the WDT isn't already locked */
+		pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val1);
+		if (val1 & ESB_WDT_LOCK)
+			printk (KERN_WARNING PFX "nowayout already set\n");
+
+		/* Set the timer to watchdog mode and disable it for now */
+		pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x00);
+
+		/* Check if the watchdog was previously triggered */
+		esb_unlock_registers();
+		val2 = readw(ESB_RELOAD_REG);
+		triggered = (val2 & (0x01 << 9) >> 9);
+
+		/* Reset trigger flag and timers */
+		esb_unlock_registers();
+		writew((0x11 << 8), ESB_RELOAD_REG);
+
+		/* Done */
+		return 1;
+
+err_release:
+		pci_release_region(esb_pci, 0);
+err_disable:
+		pci_disable_device(esb_pci);
+	}
+out:
+	return 0;
+}
+
+static int __init watchdog_init (void)
+{
+        int ret;
+
+        spin_lock_init(&esb_lock);
+
+        /* Check whether or not the hardware watchdog is there */
+        if (!esb_getdevice () || esb_pci == NULL)
+                return -ENODEV;
+
+        /* Check that the heartbeat value is within it's range ; if not reset to the default */
+        if (esb_timer_set_heartbeat (heartbeat)) {
+                esb_timer_set_heartbeat (WATCHDOG_HEARTBEAT);
+                printk(KERN_INFO PFX "heartbeat value must be 1<heartbeat<2046, using %d\n",
+		       heartbeat);
+        }
+
+        ret = register_reboot_notifier(&esb_notifier);
+        if (ret != 0) {
+                printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+                        ret);
+                goto err_unmap;
+        }
+
+        ret = misc_register(&esb_miscdev);
+        if (ret != 0) {
+                printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+                        WATCHDOG_MINOR, ret);
+                goto err_notifier;
+        }
+
+        esb_timer_stop ();
+
+        printk (KERN_INFO PFX "initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
+                BASEADDR, heartbeat, nowayout);
+
+        return 0;
+
+err_notifier:
+        unregister_reboot_notifier(&esb_notifier);
+err_unmap:
+	iounmap(BASEADDR);
+/* err_release: */
+	pci_release_region(esb_pci, 0);
+/* err_disable: */
+	pci_disable_device(esb_pci);
+/* out: */
+        return ret;
+}
+
+static void __exit watchdog_cleanup (void)
+{
+	/* Stop the timer before we leave */
+	if (!nowayout)
+		esb_timer_stop ();
+
+	/* Deregister */
+	misc_deregister(&esb_miscdev);
+        unregister_reboot_notifier(&esb_notifier);
+	iounmap(BASEADDR);
+	pci_release_region(esb_pci, 0);
+	pci_disable_device(esb_pci);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_cleanup);
+
+MODULE_AUTHOR("Ross Biro and David Härdeman");
+MODULE_DESCRIPTION("Watchdog driver for Intel 6300ESB chipsets");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff -Nru a/drivers/char/watchdog/i6300esb.h b/drivers/char/watchdog/i6300esb.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/i6300esb.h	2005-03-05 17:04:28 +01:00
@@ -0,0 +1,62 @@
+/*
+ *	i8xx_tco:	TCO timer driver for i8xx chipsets
+ *
+ *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
+ *				http://www.kernelconcepts.de
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither kernel concepts nor Nils Faerber admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
+ *
+ *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
+ *				developed for
+ *                              Jentro AG, Haar/Munich (Germany)
+ *
+ *	TCO timer driver for i8xx chipsets
+ *	based on softdog.c by Alan Cox <alan@redhat.com>
+ *
+ *	For history and the complete list of supported I/O Controller Hub's
+ *	see i8xx_tco.c
+ */
+
+
+/*
+ * Some address definitions for the TCO
+ */
+
+/* PCI configuration registers */
+#define ESB_CONFIG_REG  0x60            /* Config register                   */
+#define ESB_LOCK_REG    0x68            /* WDT lock register                 */
+
+/* Memory mapped registers */
+#define ESB_TIMER1_REG  BASEADDR + 0x00 /* Timer1 value after each reset     */
+#define ESB_TIMER2_REG  BASEADDR + 0x04 /* Timer2 value after each reset     */
+#define ESB_GINTSR_REG  BASEADDR + 0x08 /* General Interrupt Status Register */
+#define ESB_RELOAD_REG  BASEADDR + 0x0c /* Reload register                   */
+
+
+/*
+ * Some register bits
+ */
+
+/* Lock register bits */
+#define ESB_WDT_FUNC    ( 0x01 << 2 )   /* Watchdog functionality            */
+#define ESB_WDT_ENABLE  ( 0x01 << 1 )   /* Enable WDT                        */
+#define ESB_WDT_LOCK    ( 0x01 << 0 )   /* Lock (nowayout)                   */
+
+/* Config register bits */
+#define ESB_WDT_REBOOT  ( 0x01 << 5 )   /* Enable reboot on timeout          */
+#define ESB_WDT_FREQ    ( 0x01 << 2 )   /* Decrement frequency               */
+#define ESB_WDT_INTTYPE ( 0x11 << 0 )   /* Interrupt type on timer1 timeout  */
+
+
+/*
+ * Some magic constants
+ */
+#define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
+#define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
