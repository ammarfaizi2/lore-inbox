Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVEMU0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVEMU0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVEMU0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:26:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46727 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262520AbVEMUAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:00:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 3/8] ppc64: add a watchdog driver for rtas
Date: Fri, 13 May 2005 21:24:47 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de>
In-Reply-To: <200505132117.37461.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505132124.48963.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a watchdog using the RTAS OS surveillance service. This is
provided as a simpler alternative to rtasd. The added value
is that it works with standard watchdog client programs and
can therefore also do user space monitoring.

On BPA, rtasd is not really useful because the hardware does
not have much to report with event-scan.

The driver should also work on other platforms that support
the OS surveillance rtas calls.

From: Utz Bacher <utz.bacher@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-2.6-ppc.orig/drivers/char/watchdog/Kconfig	2005-03-18 07:08:59.836902728 -0500
+++ linux-2.6-ppc/drivers/char/watchdog/Kconfig	2005-03-18 07:09:12.047905480 -0500
@@ -414,6 +414,16 @@ config WATCHDOG_RIO
 	  machines.  The watchdog timeout period is normally one minute but
 	  can be changed with a boot-time parameter.
 
+# ppc64 RTAS watchdog
+config WATCHDOG_RTAS
+	tristate "RTAS watchdog"
+	depends on WATCHDOG && PPC_RTAS
+	help
+	  This driver adds watchdog support for the RTAS watchdog.
+
+          To compile this driver as a module, choose M here. The module
+	  will be called wdrtas.
+
 #
 # ISA-based Watchdog Cards
 #
--- linux-2.6-ppc.orig/drivers/char/watchdog/Makefile	2005-03-18 07:08:59.857899536 -0500
+++ linux-2.6-ppc/drivers/char/watchdog/Makefile	2005-03-18 07:09:52.344904960 -0500
@@ -33,6 +33,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
--- linux-2.6-ppc.orig/drivers/char/watchdog/wdrtas.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-ppc/drivers/char/watchdog/wdrtas.c	2005-03-18 07:09:12.051904872 -0500
@@ -0,0 +1,691 @@
+/*
+ * FIXME: add wdrtas_get_status and wdrtas_get_boot_status as soon as
+ * RTAS calls are available
+ */
+
+/*
+ * RTAS watchdog driver
+ *
+ * (C) Copyright IBM Corp. 2005
+ * device driver to exploit watchdog RTAS functions
+ *
+ * Authors : Utz Bacher <utz.bacher@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#include <asm/rtas.h>
+#include <asm/uaccess.h>
+
+#define WDRTAS_MAGIC_CHAR		42
+#define WDRTAS_SUPPORTED_MASK		(WDIOF_SETTIMEOUT | \
+					 WDIOF_MAGICCLOSE)
+
+MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
+MODULE_DESCRIPTION("RTAS watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_ALIAS_MISCDEV(TEMP_MINOR);
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int wdrtas_nowayout = 1;
+#else
+static int wdrtas_nowayout = 0;
+#endif
+
+static volatile int wdrtas_miscdev_open = 0;
+static char wdrtas_expect_close = 0;
+
+static int wdrtas_interval;
+
+#define WDRTAS_THERMAL_SENSOR		3
+static int wdrtas_token_get_sensor_state;
+#define WDRTAS_SURVEILLANCE_IND		9000
+static int wdrtas_token_set_indicator;
+#define WDRTAS_SP_SPI			28
+static int wdrtas_token_get_sp;
+static int wdrtas_token_event_scan;
+
+#define WDRTAS_DEFAULT_INTERVAL		300
+
+#define WDRTAS_LOGBUFFER_LEN		128
+static char wdrtas_logbuffer[WDRTAS_LOGBUFFER_LEN];
+
+
+/*** watchdog access functions */
+
+/**
+ * wdrtas_set_interval - sets the watchdog interval
+ * @interval: new interval
+ *
+ * returns 0 on success, <0 on failures
+ *
+ * wdrtas_set_interval sets the watchdog keepalive interval by calling the
+ * RTAS function set-indicator (surveillance). The unit of interval is
+ * seconds.
+ */
+static int
+wdrtas_set_interval(int interval)
+{
+	long result;
+	static int print_msg = 10;
+
+	/* rtas uses minutes */
+	interval = (interval + 59) / 60;
+
+	result = rtas_call(wdrtas_token_set_indicator, 3, 1, NULL,
+			   WDRTAS_SURVEILLANCE_IND, 0, interval);
+	if ( (result < 0) && (print_msg) ) {
+		printk("wdrtas: setting the watchdog to %i timeout failed: "
+		       "%li\n", interval, result);
+		print_msg--;
+	}
+
+	return result;
+}
+
+/**
+ * wdrtas_get_interval - returns the current watchdog interval
+ * @fallback_value: value (in seconds) to use, if the RTAS call fails
+ *
+ * returns the interval
+ *
+ * wdrtas_get_interval returns the current watchdog keepalive interval
+ * as reported by the RTAS function ibm,get-system-parameter. The unit
+ * of the return value is seconds.
+ */
+static int
+wdrtas_get_interval(int fallback_value)
+{
+	long result;
+	char value[4];
+
+	result = rtas_call(wdrtas_token_get_sp, 3, 1, NULL,
+			   WDRTAS_SP_SPI, (void *)__pa(&value), 4);
+	if ( (value[0] != 0) || (value[1] != 2) || (value[3] != 0) ||
+	     (result < 0) ) {
+		printk("wdrtas: could not get sp_spi watchdog timeout (%li). "
+		       "Continuing\n", result);
+		return fallback_value;
+	}
+
+	/* rtas uses minutes */
+	return ((int)value[2]) * 60;
+}
+
+/**
+ * wdrtas_timer_start - starts watchdog
+ *
+ * wdrtas_timer_start starts the watchdog by calling the RTAS function
+ * set-interval (surveillance)
+ */
+static void
+wdrtas_timer_start(void)
+{
+	wdrtas_set_interval(wdrtas_interval);
+}
+
+/**
+ * wdrtas_timer_stop - stops watchdog
+ *
+ * wdrtas_timer_stop stops the watchdog timer by calling the RTAS function
+ * set-interval (surveillance)
+ */
+static void
+wdrtas_timer_stop(void)
+{
+	wdrtas_set_interval(0);
+}
+
+/**
+ * wdrtas_log_scanned_event - logs an event we received during keepalive
+ *
+ * wdrtas_log_scanned_event prints a message to the log buffer dumping
+ * the results of the last event-scan call
+ */
+static void
+wdrtas_log_scanned_event(void)
+{
+	int i;
+
+	for (i = 0; i < WDRTAS_LOGBUFFER_LEN; i += 16)
+		printk("wdrtas: dumping event (line %i/%i), data = "
+		       "%02x %02x %02x %02x  %02x %02x %02x %02x   "
+		       "%02x %02x %02x %02x  %02x %02x %02x %02x\n",
+		       (i / 16) + 1, (WDRTAS_LOGBUFFER_LEN / 16),
+		       wdrtas_logbuffer[i + 0], wdrtas_logbuffer[i + 1], 
+		       wdrtas_logbuffer[i + 2], wdrtas_logbuffer[i + 3], 
+		       wdrtas_logbuffer[i + 4], wdrtas_logbuffer[i + 5], 
+		       wdrtas_logbuffer[i + 6], wdrtas_logbuffer[i + 7], 
+		       wdrtas_logbuffer[i + 8], wdrtas_logbuffer[i + 9], 
+		       wdrtas_logbuffer[i + 10], wdrtas_logbuffer[i + 11], 
+		       wdrtas_logbuffer[i + 12], wdrtas_logbuffer[i + 13], 
+		       wdrtas_logbuffer[i + 14], wdrtas_logbuffer[i + 15]);
+}
+
+/**
+ * wdrtas_timer_keepalive - resets watchdog timer to keep system alive
+ *
+ * wdrtas_timer_keepalive restarts the watchdog timer by calling the
+ * RTAS function event-scan and repeats these calls as long as there are
+ * events available. All events will be dumped.
+ */
+static void
+wdrtas_timer_keepalive(void)
+{
+	long result;
+
+	do {
+		result = rtas_call(wdrtas_token_event_scan, 4, 1, NULL,
+				   RTAS_EVENT_SCAN_ALL_EVENTS, 0,
+				   (void *)__pa(wdrtas_logbuffer),
+				   WDRTAS_LOGBUFFER_LEN);
+		if (result < 0)
+			printk("wdrtas: event-scan failed: %li\n",result);
+		if (result == 0)
+			wdrtas_log_scanned_event();
+	} while (result == 0);
+}
+
+/**
+ * wdrtas_get_temperature - returns current temperature
+ *
+ * returns temperature or <0 on failures
+ *
+ * wdrtas_get_temperature returns the current temperature in Fahrenheit. It
+ * uses the RTAS call get-sensor-state, token 3 to do so
+ */
+static int
+wdrtas_get_temperature(void)
+{
+	long result;
+	int temperature = 0;
+
+	result = rtas_call(wdrtas_token_get_sensor_state, 2, 2,
+			   (void *)__pa(&temperature),
+			   WDRTAS_THERMAL_SENSOR, 0);
+
+	if (result < 0)
+		printk("wdrtas: reading the thermal sensor faild: %li\n",
+		       result);
+	else
+		temperature = ((temperature * 9) / 5) + 32; /* fahrenheit */
+
+	return temperature;
+}
+
+/**
+ * wdrtas_get_status - returns the status of the watchdog
+ *
+ * returns a bitmask of defines WDIOF_... as defined in
+ * include/linux/watchdog.h
+ */
+static int
+wdrtas_get_status(void)
+{
+	return 0; /* TODO */
+}
+
+/**
+ * wdrtas_get_boot_status - returns the reason for the last boot
+ *
+ * returns a bitmask of defines WDIOF_... as defined in
+ * include/linux/watchdog.h, indicating why the watchdog rebooted the system
+ */
+static int
+wdrtas_get_boot_status(void)
+{
+	return 0; /* TODO */
+}
+
+/*** watchdog API and operations stuff */
+
+/* wdrtas_write - called when watchdog device is written to
+ * @file: file structure
+ * @buf: user buffer with data
+ * @len: amount to data written
+ * @ppos: position in file
+ *
+ * returns the number of successfully processed characters, which is always
+ * the number of bytes passed to this function
+ *
+ * wdrtas_write processes all the data given to it and looks for the magic
+ * character 'V'. This character allows the watchdog device to be closed
+ * properly.
+ */
+static ssize_t
+wdrtas_write(struct file *file, const char __user *buf,
+	     size_t len, loff_t *ppos)
+{
+	int i;
+	char c;
+
+	if (!len)
+		goto out;
+
+	if (!wdrtas_nowayout) {
+		wdrtas_expect_close = 0;
+		/* look for 'V' */
+		for (i = 0; i < len; i++) {
+			if (get_user(c, buf + i))
+				return -EFAULT;
+			/* allow to close device */
+			if (c == 'V')
+				wdrtas_expect_close = WDRTAS_MAGIC_CHAR;
+		}
+	}
+
+	wdrtas_timer_keepalive();
+
+out:
+	return len;
+}
+
+/**
+ * wdrtas_ioctl - ioctl function for the watchdog device
+ * @inode: inode structure
+ * @file: file structure
+ * @cmd: command for ioctl
+ * @arg: argument pointer
+ *
+ * returns 0 on success, <0 on failure
+ *
+ * wdrtas_ioctl implements the watchdog API ioctls
+ */
+static int
+wdrtas_ioctl(struct inode *inode, struct file *file,
+	     unsigned int cmd, unsigned long arg)
+{
+	int __user *argp = (void *)arg;
+	int i;
+	static struct watchdog_info wdinfo = {
+		.options = WDRTAS_SUPPORTED_MASK,
+		.firmware_version = 0,
+		.identity = "wdrtas"
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user(argp, &wdinfo, sizeof(wdinfo)))
+			return -EFAULT;
+		return 0;
+
+	case WDIOC_GETSTATUS:
+		i = wdrtas_get_status();
+		return put_user(i, argp);
+
+	case WDIOC_GETBOOTSTATUS:
+		i = wdrtas_get_boot_status();
+		return put_user(i, argp);
+
+	case WDIOC_GETTEMP:
+		if (wdrtas_token_get_sensor_state == RTAS_UNKNOWN_SERVICE)
+			return -EOPNOTSUPP;
+
+		i = wdrtas_get_temperature();
+		return put_user(i, argp);
+
+	case WDIOC_SETOPTIONS:
+		if (get_user(i, argp))
+			return -EFAULT;
+		if (i & WDIOS_DISABLECARD)
+			wdrtas_timer_stop();
+		if (i & WDIOS_ENABLECARD) {
+			wdrtas_timer_keepalive();
+			wdrtas_timer_start();
+		}
+		if (i & WDIOS_TEMPPANIC) {
+			/* not implemented. Done by H8 */
+		}
+		return 0;
+
+	case WDIOC_KEEPALIVE:
+		wdrtas_timer_keepalive();
+		return 0;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(i, argp))
+			return -EFAULT;
+
+		if (wdrtas_set_interval(i))
+			return -EINVAL;
+
+		wdrtas_timer_keepalive();
+
+		if (wdrtas_token_get_sp == RTAS_UNKNOWN_SERVICE)
+			wdrtas_interval = i;
+		else
+			wdrtas_interval = wdrtas_get_interval(i);
+		/* fallthrough */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdrtas_interval, argp);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+/**
+ * wdrtas_open - open function of watchdog device
+ * @inode: inode structure
+ * @file: file structure
+ *
+ * returns 0 on success, -EBUSY if the file has been opened already, <0 on
+ * other failures
+ *
+ * function called when watchdog device is opened
+ */
+static int
+wdrtas_open(struct inode *inode, struct file *file)
+{
+	/* only open once */
+	if (xchg(&wdrtas_miscdev_open,1))
+		return -EBUSY;
+
+	wdrtas_timer_start();
+	wdrtas_timer_keepalive();
+
+	return nonseekable_open(inode, file);
+}
+
+/**
+ * wdrtas_close - close function of watchdog device
+ * @inode: inode structure
+ * @file: file structure
+ *
+ * returns 0 on success
+ *
+ * close function. Always succeeds
+ */
+static int
+wdrtas_close(struct inode *inode, struct file *file)
+{
+	/* only stop watchdog, if this was announced using 'V' before */
+	if (wdrtas_expect_close == WDRTAS_MAGIC_CHAR)
+		wdrtas_timer_stop();
+	else {
+		printk("wdrtas: got unexpected close. Watchdog "
+		       "not stopped.\n");
+		wdrtas_timer_keepalive();
+	}
+
+	wdrtas_expect_close = 0;
+	xchg(&wdrtas_miscdev_open,0);
+	return 0;
+}
+
+/**
+ * wdrtas_temp_read - gives back the temperature in fahrenheit
+ * @file: file structure
+ * @buf: user buffer
+ * @count: number of bytes to be read
+ * @ppos: position in file
+ *
+ * returns always 1 or -EFAULT in case of user space copy failures, <0 on
+ * other failures
+ *
+ * wdrtas_temp_read gives the temperature to the users by copying this
+ * value as one byte into the user space buffer. The unit is Fahrenheit...
+ */
+static ssize_t
+wdrtas_temp_read(struct file *file, char __user *buf,
+		 size_t count, loff_t *ppos)
+{
+	int temperature = 0;
+
+	temperature = wdrtas_get_temperature();
+	if (temperature < 0)
+		return temperature;
+
+	if (copy_to_user(buf, &temperature, 1))
+		return -EFAULT;
+
+	return 1;
+}
+
+/**
+ * wdrtas_temp_open - open function of temperature device
+ * @inode: inode structure
+ * @file: file structure
+ *
+ * returns 0 on success, <0 on failure
+ *
+ * function called when temperature device is opened
+ */
+static int
+wdrtas_temp_open(struct inode *inode, struct file *file)
+{
+	return nonseekable_open(inode, file);
+}
+
+/**
+ * wdrtas_temp_close - close function of temperature device
+ * @inode: inode structure
+ * @file: file structure
+ *
+ * returns 0 on success
+ *
+ * close function. Always succeeds
+ */
+static int
+wdrtas_temp_close(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+/**
+ * wdrtas_reboot - reboot notifier function
+ * @nb: notifier block structure
+ * @code: reboot code
+ * @ptr: unused
+ *
+ * returns NOTIFY_DONE
+ *
+ * wdrtas_reboot stops the watchdog in case of a reboot
+ */
+static int
+wdrtas_reboot(struct notifier_block *this, unsigned long code, void *ptr)
+{
+	if ( (code==SYS_DOWN) || (code==SYS_HALT) )
+		wdrtas_timer_stop();
+
+	return NOTIFY_DONE;
+}
+
+/*** initialization stuff */
+
+static struct file_operations wdrtas_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= wdrtas_write,
+	.ioctl		= wdrtas_ioctl,
+	.open		= wdrtas_open,
+	.release	= wdrtas_close,
+};
+
+static struct miscdevice wdrtas_miscdev = {
+	.minor =	WATCHDOG_MINOR,
+	.name =		"watchdog",
+	.fops =		&wdrtas_fops,
+};
+
+static struct file_operations wdrtas_temp_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= wdrtas_temp_read,
+	.open		= wdrtas_temp_open,
+	.release	= wdrtas_temp_close,
+};
+
+static struct miscdevice wdrtas_tempdev = {
+	.minor =	TEMP_MINOR,
+	.name =		"temperature",
+	.fops =		&wdrtas_temp_fops,
+};
+
+static struct notifier_block wdrtas_notifier = {
+	.notifier_call =	wdrtas_reboot,
+};
+
+/**
+ * wdrtas_get_tokens - reads in RTAS tokens
+ *
+ * returns 0 on succes, <0 on failure
+ *
+ * wdrtas_get_tokens reads in the tokens for the RTAS calls used in
+ * this watchdog driver. It tolerates, if "get-sensor-state" and
+ * "ibm,get-system-parameter" are not available.
+ */
+static int
+wdrtas_get_tokens(void)
+{
+	wdrtas_token_get_sensor_state = rtas_token("get-sensor-state");
+	if (wdrtas_token_get_sensor_state == RTAS_UNKNOWN_SERVICE) {
+		printk("wdrtas: couldn't get token for get-sensor-state. "
+		       "Trying to continue without temperature support.\n");
+	}
+
+	wdrtas_token_get_sp = rtas_token("ibm,get-system-parameter");
+	if (wdrtas_token_get_sp == RTAS_UNKNOWN_SERVICE) {
+		printk("wdrtas: couldn't get token for "
+		       "ibm,get-system-parameter. Trying to continue with "
+		       "a default timeout value of %i seconds.\n",
+		       WDRTAS_DEFAULT_INTERVAL);
+	}
+
+	wdrtas_token_set_indicator = rtas_token("set-indicator");
+	if (wdrtas_token_set_indicator == RTAS_UNKNOWN_SERVICE) {
+		printk("wdrtas: couldn't get token for set-indicator. "
+		       "Terminating watchdog code.\n");
+		return -EIO;
+	}
+
+	wdrtas_token_event_scan = rtas_token("event-scan");
+	if (wdrtas_token_event_scan == RTAS_UNKNOWN_SERVICE) {
+		printk("wdrtas: couldn't get token for event-scan. "
+		       "Terminating watchdog code.\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * wdrtas_unregister_devs - unregisters the misc dev handlers
+ *
+ * wdrtas_register_devs unregisters the watchdog and temperature watchdog
+ * misc devs
+ */
+static void
+wdrtas_unregister_devs(void)
+{
+	misc_deregister(&wdrtas_miscdev);
+	if (wdrtas_token_get_sensor_state != RTAS_UNKNOWN_SERVICE)
+		misc_deregister(&wdrtas_tempdev);
+}
+
+/**
+ * wdrtas_register_devs - registers the misc dev handlers
+ *
+ * returns 0 on succes, <0 on failure
+ *
+ * wdrtas_register_devs registers the watchdog and temperature watchdog
+ * misc devs
+ */
+static int
+wdrtas_register_devs(void)
+{
+	int result;
+
+	result = misc_register(&wdrtas_miscdev);
+	if (result) {
+		printk("wdrtas: couldn't register watchdog misc device. "
+		       "Terminating watchdog code.\n");
+		return result;
+	}
+
+	if (wdrtas_token_get_sensor_state != RTAS_UNKNOWN_SERVICE) {
+		result = misc_register(&wdrtas_tempdev);
+		if (result) {
+			printk("wdrtas: couldn't register watchdog "
+			       "temperature misc device. Continuing without "
+			       "temperature support.\n");
+			wdrtas_token_get_sensor_state = RTAS_UNKNOWN_SERVICE;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * wdrtas_init - init function of the watchdog driver
+ *
+ * returns 0 on succes, <0 on failure
+ *
+ * registers the file handlers and the reboot notifier
+ */
+static int __init
+wdrtas_init(void)
+{
+	if (wdrtas_get_tokens())
+		return -ENODEV;
+
+	if (wdrtas_register_devs())
+		return -ENODEV;
+
+	if (register_reboot_notifier(&wdrtas_notifier)) {
+		printk("wdrtas: could not register reboot notifier. "
+		       "Terminating watchdog code.\n");
+		wdrtas_unregister_devs();
+		return -ENODEV;
+	}
+
+	if (wdrtas_token_get_sp == RTAS_UNKNOWN_SERVICE)
+		wdrtas_interval = WDRTAS_DEFAULT_INTERVAL;
+	else
+		wdrtas_interval = wdrtas_get_interval(WDRTAS_DEFAULT_INTERVAL);
+
+	return 0;
+}
+
+/**
+ * wdrtas_exit - exit function of the watchdog driver
+ *
+ * unregisters the file handlers and the reboot notifier
+ */
+static void __exit
+wdrtas_exit(void)
+{
+	if (!wdrtas_nowayout)
+		wdrtas_timer_stop();
+
+	wdrtas_unregister_devs();
+
+	unregister_reboot_notifier(&wdrtas_notifier);
+}
+
+module_init(wdrtas_init);
+module_exit(wdrtas_exit);

