Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267802AbTBUXja>; Fri, 21 Feb 2003 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267803AbTBUXja>; Fri, 21 Feb 2003 18:39:30 -0500
Received: from fmr06.intel.com ([134.134.136.7]:38875 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267802AbTBUXjX>; Fri, 21 Feb 2003 18:39:23 -0500
Subject: Re: [PATCH][2.5] Sysfs enabling watchdog infrastructure
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045869699.1037.6.camel@vmhack>
References: <1045869699.1037.6.camel@vmhack>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 15:36:09 -0800
Message-Id: <1045870570.1037.13.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a patch against the 2.5.60 kernel that adds a new driver
for the hardware watchdog timers devices on the zt55xx line of cpci compute 
blades.  The driver is writen as a watchdog_driver utilizing the previously
submitted watchdog infrastructure.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1041  -> 1.1042 
#	drivers/char/watchdog/Kconfig	1.6     -> 1.7    
#	drivers/char/watchdog/Makefile	1.8     -> 1.9    
#	               (new)	        -> 1.1     drivers/char/watchdog/ztwd.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/21	rusty@penguin.co.intel.com	1.1042
# Adding a new watchdog driver for the ZT55XX line of CompactPCI
# single board computers.
# --------------------------------------------
#
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	Fri Feb 21 15:06:37 2003
+++ b/drivers/char/watchdog/Kconfig	Fri Feb 21 15:06:37 2003
@@ -354,4 +354,18 @@
 	  Documentation/modules.txt. The module will be called
 	  wafer5823wdt.o
 
+config ZT55XX_WDT
+	tristate "ZT55XX Single Board Computer Watchdog"
+	depends on WATCHDOG
+	help
+          This is a driver for the hardware watchdog on the ZT55XX line 
+          of CompactPCI single board computers originally sold by Ziatech,
+          and then Intel, and then Performance Technologies.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt. The module will be called
+	  ztwd.ko
+
 endmenu
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Fri Feb 21 15:06:37 2003
+++ b/drivers/char/watchdog/Makefile	Fri Feb 21 15:06:37 2003
@@ -31,3 +31,4 @@
 obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
+obj-$(CONFIG_ZT55XX_WDT) += ztwd.o
diff -Nru a/drivers/char/watchdog/ztwd.c b/drivers/char/watchdog/ztwd.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/watchdog/ztwd.c	Fri Feb 21 15:06:37 2003
@@ -0,0 +1,391 @@
+/*
+ * ztwd.c
+ *
+ * Intel/Ziatech ZT55xx watchdog driver
+ *
+ * Copyright (C) 2003 Rusty Lynch <rusty@linux.co.intel.com>
+ * 
+ * Based on original work from SOMA Networks. Original copyright:
+ * Copyright 2001-2003 SOMA Networks, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Contributors:
+ * Scott Murray <scottm@somanetworks.com>
+ * Rusty Lynch <rusty@linux.co.intel.com>
+ *
+ * Send feedback to <rusty@linux.co.intel.com>
+ */
+
+/*
+ * This driver implements the IO controlled watchdog device found
+ * on the ZT55XX line of single board computers. 
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/watchdog.h>
+#include <asm/io.h>
+
+#define DEBUG 1
+#ifdef DEBUG
+#define dbg(format, arg...)				\
+		 printk (KERN_DEBUG "%s: " format "\n",	\
+			 __FUNCTION__, ## arg);
+#define trace(format, arg...)				 \
+                 printk(KERN_INFO "%s(" format ")\n",    \
+		        __FUNCTION__ , ## arg);
+#else
+#define trace(format, arg...) do { } while (0)
+#define dbg(format, arg...) do { } while (0)
+#endif
+
+#define err(format, arg...) \
+                printk(KERN_ERR "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+#define info(format, arg...) \
+                printk(KERN_INFO "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+#define warn(format, arg...) \
+                printk(KERN_WARNING "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+
+#define WD_CTL_REG	       0x79
+
+#define WD_TERMINALCOUNT_MASK  0x07
+#define WD_STAGE1_ACTION_MASK  0x08
+#define WD_STAGE1_ENABLE_MASK  0x10
+#define WD_STAGE2_ENABLE_MASK  0x20
+#define WD_STAGE2_MONITOR_MASK 0x40
+#define WD_STAGE1_MONITOR_MASK 0x80
+
+#define WD_TC_250MS	       0x00
+#define WD_TC_500MS	       0x01
+#define WD_TC_1S	       0x02
+#define WD_TC_8S	       0x03
+#define WD_TC_32S	       0x04
+#define WD_TC_64S	       0x05
+#define WD_TC_128S	       0x06
+#define WD_TC_256S	       0x07
+
+#define DEFAULT_TIMEOUT          64  /* seconds */
+
+static int nowayout = 0;
+static int bootstatus = 0;
+static int status = 0;
+static int pretimeout = 0;
+
+static int ztwd_start(struct watchdog_driver *d)
+{
+    	uint8_t value;
+
+	trace("%s", d->driver.name);
+	value = inb(WD_CTL_REG);
+	if (pretimeout)
+		value |= WD_STAGE1_ENABLE_MASK;
+	value |= WD_STAGE2_ENABLE_MASK;
+	outb(value, WD_CTL_REG);
+	return 0;
+}
+
+static int ztwd_stop(struct watchdog_driver *d)
+{
+    	uint8_t value;
+
+	trace("%s", d->driver.name);
+	if (nowayout) {
+		warn("Nowayout flag is set.  Request to stop timer denied!");
+		return -1;
+	}
+
+	value = inb(WD_CTL_REG);
+	value &= ~WD_STAGE1_ENABLE_MASK;
+	value &= ~WD_STAGE2_ENABLE_MASK;
+	outb(value, WD_CTL_REG);
+	return 0;
+}
+
+static int ztwd_keepalive(struct watchdog_driver *d) 
+{
+	trace("%s", d->driver.name);
+	inb(WD_CTL_REG);
+	status |= WDIOF_KEEPALIVEPING;
+	return 0;
+}
+
+static int ztwd_get_status(struct watchdog_driver *d, int *s) 
+{
+	uint8_t value;
+
+	trace("%s, %p", d->driver.name, s);
+	*s = status;
+	value = inb(WD_CTL_REG);
+	if (value & WD_STAGE1_MONITOR_MASK || value & WD_STAGE2_MONITOR_MASK)
+		*s |= WDIOF_CARDRESET;
+	return 0;
+}
+
+static int ztwd_get_bootstatus(struct watchdog_driver *d, int *bs) 
+{
+	trace("%s, %p", d->driver.name, bs);
+	*bs = bootstatus;
+	return 0;
+}
+
+static int ztwd_get_timeout(struct watchdog_driver *d, int *timeout)
+{
+	uint8_t value;
+
+	trace("%s, %p", d->driver.name, timeout);
+	if (!timeout) {
+		dbg("recieved a null timeout pointer!");
+		return -1;
+	}
+
+	value = inb(WD_CTL_REG);
+	switch (value & WD_TERMINALCOUNT_MASK) {
+	default:
+		dbg("unexpected value in terminal count");
+		return -EFAULT;
+	case WD_TC_250MS:
+	case WD_TC_500MS:
+	case WD_TC_1S:
+		*timeout = 1;
+		break;
+	case WD_TC_8S:
+		*timeout = 8;
+		break;
+	case WD_TC_32S:
+		*timeout = 32;
+		break;
+	case WD_TC_64S:
+		*timeout = 64;
+		break;
+	case WD_TC_128S:
+		*timeout = 128;
+		break;
+	case WD_TC_256S:
+		*timeout = 256;		
+	}
+	status |= WDIOF_SETTIMEOUT;
+	return 0;
+}
+
+static int ztwd_set_timeout(struct watchdog_driver *d, int timeout)
+{
+    	uint8_t value;
+
+	trace("%p, %i", d->driver.name, timeout);
+	if (timeout < 0) {
+	    	dbg("invalid time specifed"); 
+	    	return 1;
+	}
+
+	if (timeout == 0) {
+		ztwd_stop(d);
+		return 0;
+	}
+	if (timeout == 1)
+		timeout = WD_TC_1S;
+	else if (timeout <= 8)
+		timeout = WD_TC_8S;
+	else if (timeout <= 32)
+	    	timeout = WD_TC_32S;
+	else if (timeout <= 64)
+	    	timeout = WD_TC_64S;
+	else if (timeout <= 128)
+	    	timeout = WD_TC_128S;
+	else if (timeout <= 256)
+	    	timeout = WD_TC_256S;
+	else
+	    	timeout = WD_TC_256S;
+	
+	value = inb(WD_CTL_REG);
+	value &= ~WD_TC_256S;
+	value |= timeout;
+	dbg("timeout value set to %X", value);
+	outb (value, WD_CTL_REG);
+	return 0;
+}
+
+static int ztwd_get_options(struct watchdog_driver *d, int *c)
+{
+	trace("%s, %p", d->driver.name, c);
+	*c = WDIOS_DISABLECARD|WDIOS_ENABLECARD;
+	return 0;
+}
+
+static int ztwd_get_nowayout(struct watchdog_driver *d, int *n)
+{
+	trace("%s, %p", d->driver.name, n);
+	*n = nowayout;
+	return 0;
+}
+
+static int ztwd_set_nowayout(struct watchdog_driver *d, int n)
+{
+	trace("%s, %i", d->driver.name, n);
+	nowayout = n;
+	return 0;
+}
+
+static struct watchdog_ops ztwd_ops = {
+	.start                 = ztwd_start,
+	.stop                  = ztwd_stop,
+	.keepalive             = ztwd_keepalive,
+	.get_timeout           = ztwd_get_timeout,
+	.set_timeout           = ztwd_set_timeout,
+	.get_nowayout          = ztwd_get_nowayout,
+	.set_nowayout          = ztwd_set_nowayout,
+	.get_options           = ztwd_get_options,
+	.get_bootstatus        = ztwd_get_bootstatus,
+	.get_status            = ztwd_get_status,
+	/* get/set_temppanic not implemented */
+	/* get_firmware_version not implemented */
+};
+
+static struct watchdog_driver ztwd_driver = {
+	.ops = &ztwd_ops,
+	.driver = {
+		.name		= "ztwd",
+		.bus		= &system_bus_type,
+		.devclass       = &watchdog_devclass,
+	}
+};
+
+/* 
+ * ZT55XX specific controls 
+ */
+
+/* enabling the pretimeout (stage 1 timeout) will cause either a */
+/* NMI or INIT to happen when the stage 1 timer expires */
+static ssize_t pretimeout_enable_show(struct device_driver * d, char * buf)
+{
+	trace("%s, %p", d->name, buf);
+	return sprintf(buf, "%i\n",pretimeout);
+}
+static ssize_t pretimeout_enable_store(struct device_driver *d,
+				       const char * buf, 
+				       size_t count)
+{
+	trace("%s, %p, %i", d->name, buf, count);
+	if (sscanf(buf,"%i",&pretimeout) != 1)
+		return -EINVAL;
+
+	return count;
+}
+DRIVER_ATTR(pretimeout_enable,0644,pretimeout_enable_show,
+	    pretimeout_enable_store);
+
+/* 1 = NMI; 0 = INIT */
+static ssize_t pretimeout_action_show(struct device_driver * d, char * buf)
+{
+	uint8_t value;
+	
+	trace("%s, %p", d->name, buf);
+	value = inb(WD_CTL_REG);
+	return sprintf(buf, "%i\n",value&WD_STAGE1_ACTION_MASK?1:0);
+}
+static ssize_t pretimeout_action_store(struct device_driver *d,
+				       const char * buf, 
+				       size_t count)
+{
+	int tmp;
+	uint8_t value;
+
+	trace("%s, %p, %i", d->name, buf, count);
+	if (sscanf(buf,"%i",&tmp) != 1)
+		return -EINVAL;
+
+	value = inb(WD_CTL_REG);
+	if (tmp)
+		value |= WD_STAGE1_ACTION_MASK;
+	else
+		value &= ~WD_STAGE1_ACTION_MASK;
+	outb(value, WD_CTL_REG);
+	return count;
+}
+DRIVER_ATTR(pretimeout_action,0644,pretimeout_action_show,
+	    pretimeout_action_store);
+
+static int __init ztwd_init(void)
+{
+	int ret = 0;
+    	uint8_t value;
+
+	trace();
+	if (!request_region(WD_CTL_REG, 1, "ZT55XX Watchdog")) {
+		err("Unable to reserve io region 0x%2x", WD_CTL_REG);
+		return -EBUSY;
+	}
+
+	/* determine if the watchdog was previously tripped */
+	value = inb(WD_CTL_REG);	
+	if (value & WD_STAGE2_MONITOR_MASK) {
+		dbg("previous stage 2 watchdog timeout detected");
+		bootstatus = WDIOF_CARDRESET;
+
+		/* clear the stage 1 & 2 monitor flags */
+		value &= 0x3F;
+		outb(value, WD_CTL_REG);
+	}	
+
+	/* set the timeout before we give anyone */
+	/* a chance to start the watchdog device ticking */
+	if (ztwd_set_timeout(&ztwd_driver, DEFAULT_TIMEOUT))
+		return -EFAULT;
+
+	ret = watchdog_driver_register(&ztwd_driver);
+	if (ret) {
+		err("failed to register watchdog device");
+		return -ENODEV;
+	}
+
+	/* create zt55xx specific sysfs control files */
+	driver_create_file(&ztwd_driver.driver, 
+			   &driver_attr_pretimeout_enable);
+	driver_create_file(&ztwd_driver.driver, 
+			   &driver_attr_pretimeout_action);
+	return 0;
+}
+
+static void __exit ztwd_exit(void)
+{
+	trace();
+
+	/* remove zt55xx specific sysfs control files */
+	driver_remove_file(&ztwd_driver.driver, 
+			   &driver_attr_pretimeout_enable);
+	driver_remove_file(&ztwd_driver.driver, 
+			   &driver_attr_pretimeout_action);
+
+	release_region(WD_CTL_REG, 1);
+	watchdog_driver_unregister(&ztwd_driver);
+}
+
+module_init(ztwd_init);
+module_exit(ztwd_exit);
+MODULE_LICENSE("GPL");

